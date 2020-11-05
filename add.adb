with Kernel.Serial_Output; use Kernel.Serial_Output;
with Ada.Real_Time; use Ada.Real_Time;
with System; use System;

with Tools; use Tools;
with Devices; use Devices;
with Symptoms; -- use Symptoms;
with Measurements; -- use Measurements;

-- Packages needed to generate pulse interrupts       
-- with Ada.Interrupts.Names;
-- with Pulse_Interrupt; use Pulse_Interrupt;


package body add is

	-- Constants
	dist_interval  : Time_Span := Milliseconds(300);
	steer_interval : Time_Span := Milliseconds(350);
	head_interval  : Time_Span := Milliseconds(400);
	disp_interval  : Time_Span := Milliseconds(1000);
	risk_interval  : Time_Span := Milliseconds(150);

	RISKPRIO : constant := 10; -- Highest Prio I guess
	HEADPRIO : constant := 5;
	DISTPRIO : constant := 4;
	STERPRIO : constant := 3;
	DISPPRIO : constant := 1;
	
	light_st  : Light_States := Off;
	----------------------------------------------------------------------
	------------- procedure exported 
	----------------------------------------------------------------------
	procedure Background is
	begin
		loop
			null;
		end loop;
	end Background;
	----------------------------------------------------------------------
	
	-----------------------------------------------------------------------
	------------- declaration of tasks 
	-----------------------------------------------------------------------
	
	-- Aqui se declaran las tareas que forman el STR
	task check_distance is
		pragma priority(DISTPRIO);
	end check_distance;
	
	task check_steer is
		pragma priority(STERPRIO);
	end check_steer;

	task check_head is
		pragma priority(HEADPRIO);
	end check_head;

	task display is
		pragma priority(DISPPRIO);
	end display;

	task risks is
		pragma priority(RISKPRIO);
	end risks;
	
	-----------------------------------------------------------------------
	------------- body of tasks 
	-----------------------------------------------------------------------
	-- TODO: Quitar Puts (Deberian ir a Display, excepto tracing)
	--       Quitar Actuadores [BEEP, Lights] (Deberian ir a Riesgos)
	task body check_distance is
		next_exec : Time;
		interval  : Time_Span := dist_interval;
		curr_d    : Distance_Samples_Type := 0;
		curr_s    : Speed_Samples_Type    := 0;
		distance  : Float;
		speed     : Float;
		d_riesgo  : Float;
		d_imprud  : Float;
		d_insegu  : Float;
	begin
		next_exec := Clock + interval;
		loop
			Starting_Notice("DIST");

			Reading_Distance(curr_d);
			Reading_Speed(curr_s);
			measurements.prMeasurements.setmdistance(curr_d);
			measurements.prMeasurements.setmspeed(curr_s);
			-- Display_Distance(current_d);
			-- Display_Speed(current_s);

			distance := Float(curr_d);
			speed    := Float(curr_s);

			d_riesgo := (((speed/10.0)**2)/3.0);
			d_imprud := (((speed/10.0)**2)/2.0);
			d_insegu := (((speed/10.0)**2));
			
			if (distance < d_riesgo) then
				symptoms.prSymptoms.setCollision(TRUE);
				Put_Line("................ -> RIESGO_COLISION [B5]");
				-- Beep(5);
			elsif (distance < d_imprud) then
				symptoms.prSymptoms.setImprdD(TRUE);
				Put_Line("................ -> DISTANCIA_IMPRUDENTE [L+B4]");
				-- Light(On);
				-- Beep(4);
			elsif (distance < d_insegu) then
				symptoms.prSymptoms.setUnsafeD(TRUE);
				Put_Line("................ -> DISTANCIA_INSEGURA [L]");
				-- Light(On);
			else
				symptoms.prSymptoms.setCollision(FALSE);
				symptoms.prSymptoms.setImprdD(FALSE);
				symptoms.prSymptoms.setUnsafeD(FALSE);
			end if;
			
			Finishing_Notice("DIST");

			delay until next_exec;
			next_exec := next_exec + interval;
		end loop;
	end check_distance;


	-- TODO: Quitar Puts (Deberian ir a Display, excepto tracing)
	--       Quitar Actuadores [BEEP, Lights] (Deberian ir a Riesgos)
	task body check_steer is
		next_exec  : Time;
		interval   : Time_Span := steer_interval;
		last_steer : Steering_Samples_Type := 0;
		curr_steer : Steering_Samples_Type := 0;
		curr_speed : Speed_Samples_Type    := 0;

		l_steer : Integer;
		c_steer : Integer;
		c_speed : Integer;
	begin
		next_exec := Clock + interval;
		loop
			Starting_Notice("STEER");

			Reading_Steering(curr_steer);
			Reading_Speed(curr_speed);

			Display_Steering(curr_steer);

			l_steer := Integer(last_steer);
			c_steer := Integer(curr_steer);
			c_speed := Integer(curr_speed);

			if ((abs(l_steer - c_steer) >= 20) AND (c_speed >= 40)) then
				symptoms.prSymptoms.setSwerve(TRUE);
				Put_Line("................ -> VOLANTAZO [B1]");
				-- Beep(1);
			else
				symptoms.prSymptoms.setSwerve(FALSE); -- Clean symptom
			end if;

			last_steer := curr_steer;
			
			Finishing_Notice("STEER");

			delay until next_exec;
			next_exec := next_exec + interval;
		end loop;
	end check_steer;


	task body check_head is
		next_exec  : Time;
		interval   : Time_Span                  := head_interval;
		curr_hp    : HeadPosition_Samples_Type;
		curr_steer : Steering_Samples_Type;
		steer_x    : Integer;
		steer_y    : Integer;
		xover30    : Integer := 0;
		yover30    : Integer := 0;
	begin
		next_exec := Clock + interval;
		loop
			Starting_Notice("HEAD");

			Reading_HeadPosition(curr_hp);
			Reading_Steering(curr_steer);

			steer_x := Integer(curr_hp(x));
			steer_y := Integer(curr_hp(y));

			-- X
			if ((steer_x >= 30) OR (steer_x <= -30)) then
				xover30 := xover30 + 1;
			else
				xover30 := 0;
			end if;

			-- Y
			if (((steer_y >=  30) AND (steer_y <= 0)) OR
			    ((steer_y <= -30) AND (steer_y >= 0))) then
				yover30 := yover30 + 1;
			else
				yover30 := 0;
			end if;


			if ((xover30 = 2) OR (yover30 = 2)) then
				-- Activar symptom CABEZA_INCLINADA
				symptoms.prSymptoms.setLean(TRUE);
			else
				symptoms.prSymptoms.setLean(FALSE);
			end if;

			Finishing_Notice("HEAD");
			delay until next_exec;
			next_exec := next_exec + interval;
		end loop;
	end check_head;



	task body display is
		next_exec : Time;
		interval  : Time_Span := disp_interval;
		swerve    : Boolean;
		lean      : Boolean;
		unsafeD   : Boolean;
		imprdD    : Boolean;
		collision : Boolean;
		current_s : Speed_Samples_Type;
		current_d : Distance_Samples_Type;
	begin
		next_exec := Clock + interval;
		loop
		
			Starting_Notice("DISPLAY");
			-- Read symptoms protected object
			-- symptoms.readSymptoms(swerve, lean, unsafeD, imprdD, collision);
			symptoms.readSymptoms(swerve, lean, unsafeD, imprdD, collision);

			measurements.readMeasurements(current_d, current_s);
			-- Reading_Speed(current_s);
			-- Reading_Distance(current_d);

			Display_Speed(current_s); 
			Display_Distance(current_d);

			if ((swerve = TRUE) AND (current_s > 40)) then
				Put_Line(" [DISPLAY] -> VOLANTAZO");
			elsif (lean = TRUE) then
				Put_Line(" [DISPLAY] -> CABEZA INCLINADA");
			elsif (unsafeD = TRUE) then
				Put_Line(" [DISPLAY] -> DISTANCIA INSEGURA");
			elsif (imprdD = TRUE)
				then Put_Line(" [DISPLAY] -> DISTANCIA IMPRUDENTE");
			elsif (collision = TRUE)
				then Put_Line(" [DISPLAY] -> RIESGO COLISION");
			end if;

			Finishing_Notice("DISPLAY");

			delay until next_exec;
			next_exec := next_exec + interval;
		end loop;
	end display;


	task body risks is
		next_exec : Time;
		interval  : Time_Span := risk_interval;	
		swerve    : Boolean;
		lean      : Boolean;
		unsafeD   : Boolean;
		imprdD    : Boolean;
		collision : Boolean;
		current_s : Speed_Samples_Type;
		current_d : Distance_Samples_Type;
	begin
		next_exec := Clock + interval;
		loop
			Starting_Notice("RISKS");
			symptoms.readSymptoms(swerve, lean, unsafeD, imprdD, collision);
			measurements.readMeasurements(current_d, current_s);

			-- Turn off the light here? TODO: check this
			if (light_st = On) then
				Light(Off);
				light_st := Off;
			end if;

			if (swerve = TRUE)  then
				Beep(1);
			end if;

			if (lean = TRUE) then
				if (current_s > 70) then
					Beep(3);
				else
					Beep(2);
				end if;
			end if;

			if (unsafeD = TRUE) then
				Light(On);
				light_st := On;
			elsif (light_st = On) then
				Light(Off);
				light_st := Off;
			end if;

			if (imprdD = TRUE) then
				Light(On);
				light_st := On;
				Beep(4);
			elsif ((light_st = On) AND (unsafeD = FALSE)) then
				-- Second check to avoid this if to turn off the light for
				-- unsafeD
				Light(Off);
				light_st := Off;
			end if;

			if ((collision = TRUE) AND (lean = TRUE)) then
				Activate_Brake;
				Beep(5);
			end if;
			Finishing_Notice("RISKS");
			delay until next_exec;
			next_exec := next_exec + interval;
		end loop;
	end risks;

    ----------------------------------------------------------------------
    ------------- procedure para probar los dispositivos 
    ----------------------------------------------------------------------
	procedure Prueba_Dispositivos; 


	Procedure Prueba_Dispositivos is
		Current_V: Speed_Samples_Type := 0;
		Current_H: HeadPosition_Samples_Type := (+2,-2);
		Current_D: Distance_Samples_Type := 0;
		Current_O: Eyes_Samples_Type := (70,70);
		Current_E: EEG_Samples_Type := (1,1,1,1,1,1,1,1,1,1);
		Current_S: Steering_Samples_Type := 0;
	begin
		Starting_Notice ("Prueba_Dispositivo");
		
		for I in 1..120 loop
         -- Prueba distancia
            --Reading_Distance (Current_D);
            --Display_Distance (Current_D);
            --if (Current_D < 40) then Light (On); 
            --                    else Light (Off); end if;

         -- Prueba velocidad
            --Reading_Speed (Current_V);
            --Display_Speed (Current_V);
            --if (Current_V > 110) then Beep (2); end if;

         -- Prueba volante
            --Reading_Steering (Current_S);
            --Display_Steering (Current_S);
            --if (Current_S > 30) OR (Current_S < -30) then Light (On);
            --                                         else Light (Off); end if;

         -- Prueba Posicion de la cabeza
            --Reading_HeadPosition (Current_H);
            --Display_HeadPosition_Sample (Current_H);
            --if (Current_H(x) > 30) then Beep (4); end if;

         -- Prueba ojos
            --Reading_EyesImage (Current_O);
            --Display_Eyes_Sample (Current_O);

         -- Prueba electroencefalograma
            --Reading_Sensors (Current_E);
            --Display_Electrodes_Sample (Current_E);
   
			delay until (Clock + To_time_Span(0.1));
		end loop;
		Finishing_Notice ("Prueba_Dispositivo");
	end Prueba_Dispositivos;


begin
	Starting_Notice ("Programa Principal");
	Prueba_Dispositivos;
	Finishing_Notice ("Programa Principal");
end add;


