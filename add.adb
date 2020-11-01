with Kernel.Serial_Output; use Kernel.Serial_Output;
with Ada.Real_Time; use Ada.Real_Time;
with System; use System;

with Tools; use Tools;
with Devices; use Devices;
with Symptoms; -- use Symptoms;

-- Packages needed to generate pulse interrupts       
-- with Ada.Interrupts.Names;
-- with Pulse_Interrupt; use Pulse_Interrupt;


package body add is

	-- Constants
	dist_interval  : Time_Span := Milliseconds(300);
	steer_interval : Time_Span := Milliseconds(350);
	disp_interval  : Time_Span := Milliseconds(1000);
	
	DISTPRIO  : constant := 4;
	STERPRIO  : constant := 5;
	DISPPRIO  : constant := 1;
	
	
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

	task display is
		pragma priority(DISPPRIO);
	end display;
	
	-----------------------------------------------------------------------
	------------- body of tasks 
	-----------------------------------------------------------------------
	
	-- Aqui se escriben los cuerpos de las tareas 
	task body check_distance is
		next_exec : Time;
		interval  : Time_Span := dist_interval;
		current_d : Distance_Samples_Type := 0;
		current_s : Speed_Samples_Type    := 0;
		distance  : Float;
		speed     : Float;
		d_riesgo  : Float;
		d_imprud  : Float;
		d_insegu  : Float;
	begin
		next_exec := Clock + interval;
		loop

			Starting_Notice("CHECK_DISTANCE");

			Reading_Distance(current_d);
			Reading_Speed(current_s);
			Display_Distance(current_d);
			Display_Speed(current_s);

			distance := Float(current_d);
			speed    := Float(current_s);

			d_riesgo := (((speed/10.0)**2)/3.0);
			d_imprud := (((speed/10.0)**2)/2.0);
			d_insegu := (((speed/10.0)**2));
			
			if (distance < d_riesgo) then
				symptoms.prsymptoms.setCollision(TRUE);
				Put("................ -> RIESGO_COLISION");
				Beep(5);
			elsif (distance < d_imprud) then
				symptoms.prsymptoms.setImprdD(TRUE);
				Put("................ -> DISTANCIA_IMPRUDENTE");
				Light(On);
				Beep(4);
			elsif (distance < d_insegu) then
				symptoms.prsymptoms.setUnsafeD(TRUE);
				Put("................ -> DISTANCIA_INSEGURA");
				Light(On);
			else
				symptoms.prsymptoms.setCollision(FALSE);
				symptoms.prsymptoms.setImprdD(FALSE);
				symptoms.prsymptoms.setUnsafeD(FALSE);
				Light(Off);
			end if;
			
			Finishing_Notice("CHECK_DISTANCE");

			delay until next_exec;
			next_exec := next_exec + interval;
		end loop;
	end check_distance;


	task body check_steer is
		next_exec     : Time;
		interval      : Time_Span := steer_interval;
		last_steer    : Steering_Samples_Type := 0;
		current_steer : Steering_Samples_Type := 0;
		current_speed : Speed_Samples_Type    := 0;

		l_angle : Integer;
		c_angle : Integer;
		c_speed : Integer;
	begin
		next_exec := Clock + interval;
		loop
			Starting_Notice("CHECK_STEER");

			Reading_Steering(current_steer);
			Reading_Speed(current_speed);

			l_angle := Integer(last_steer);
			c_angle := Integer(current_steer);
			c_speed := Integer(current_speed);

			if ((abs(l_angle - c_angle) >= 20) AND (c_speed >= 40)) then
				symptoms.prsymptoms.setSwerve(TRUE);
				Put("................ -> VOLANTAZO");
				Beep(1);
			else
				symptoms.prsymptoms.setSwerve(FALSE); -- Clean symptom
			end if;
			
			Finishing_Notice("CHECK_STEER");

			delay until next_exec;
			next_exec := next_exec + interval;
		end loop;
	end check_steer;

	task body display is
		next_exec: Time;
		interval : Time_Span := disp_interval;
		swerve   : Boolean;
		lean     : Boolean;
		unsafeD  : Boolean;
		imprdD   : Boolean;
		collision: Boolean;
	begin
		next_exec := Clock + interval;
		loop
		
			Starting_Notice("DISPLAY");
			-- Read symptoms protected object
			-- symptoms.readSymptoms(swerve, lean, unsafeD, imprdD, collision);
			Symptoms.readSymptoms(swerve, lean, unsafeD, imprdD, collision);

			if (swerve = TRUE) then Put(" [DISPLAY] -> VOLANTAZO");
			elsif(lean = TRUE) then Put(" [DISPLAY] -> CABEZA INCLINADA");
			elsif(unsafeD = TRUE) then Put(" [DISPLAY] -> DISTANCIA INSEGURA");
			elsif(imprdD = TRUE) then Put(" [DISPLAY] -> DISTANCIA IMPRUDENTE");
			elsif(collision = TRUE) then Put(" [DISPLAY] -> RIESGO COLISION");
			end if;

			Finishing_Notice("DISPLAY");

			delay until next_exec;
			next_exec := next_exec + interval;
		end loop;
	end display;



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


