with Kernel.Serial_Output; use Kernel.Serial_Output;
with Ada.Real_Time; use Ada.Real_Time;
with System; use System;

with Tools; use Tools;
with Devices; use Devices;

-- Packages needed to generate pulse interrupts       
-- with Ada.Interrupts.Names;
-- with Pulse_Interrupt; use Pulse_Interrupt;


package body add is

	-- Constants
	dist_interval : Time_Span := Milliseconds(300);
	head_interval : Time_Span := Milliseconds(400);



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
		pragma priority(3);
	end check_distance;
	
	
	-----------------------------------------------------------------------
	------------- body of tasks 
	-----------------------------------------------------------------------
	
	-- Aqui se escriben los cuerpos de las tareas 
	task body check_distance is
		next_exec : Time;
		interval  : Time_Span := dist_interval;
		current_d : Distance_Samples_Type := 0;
		current_s : Speed_Samples_Type := 0;
		distance  : Float;
		speed     : Float;
		d_riesgo  : Float;
		d_imprud  : Float;
		d_insegu  : Float;
	begin
		next_exec := Clock + interval;
		loop
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
				Put("................ -> RIESGO_COLISION");
				Beep(5);
			elsif (distance < d_imprud) then
				Put("................ -> DISTANCIA_IMPRUDENTE");
				Light(On);
				Beep(4);
			elsif (distance < d_insegu) then
				Put("................ -> DISTANCIA_INSEGURA");
				Light(On);
			else
				Light(Off);
			end if;
			
			
			delay until next_exec;
			next_exec := next_exec + interval;
		end loop;
	end check_distance;

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


