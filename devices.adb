with Kernel.Serial_Output; use Kernel.Serial_Output;
with System; use System;
with tools; use tools;

package body devices is

	EYES_REACTION_WHEN_BEEP: constant integer := 0;
	-- 0 = no reaction
	-- 1 = short reaction
	-- 2 = large reaction 




	---------------------------------------------------------------------
	-- Procedures to get front vehicle distance  
	---------------------------------------------------------------------

	protected Lectura_Distancia is
		procedure Reading_Distance (L: out Distance_Samples_Type);
		procedure Reaction (Level: in integer);
	private
		i: Indice_Secuencia_Distancia := 1;
		Secuencia: tipo_Secuencia_Distancia := Distance_Simulation;
	end Lectura_Distancia;


	procedure Reading_Distance (L: out Distance_Samples_Type) is
	begin
		Lectura_Distancia.Reading_distance (L);
	end Reading_Distance;


	protected body Lectura_distancia is
		procedure Reading_Distance (L: out Distance_Samples_Type)  is
			type Time_index is delta 0.1 range 0.0..100.0;
			t: Time_index;
		begin
			t := Time_index(To_Duration(Clock - Big_Bang));
			i := Indice_Secuencia_Distancia (integer(t * 10.0) mod 100);
			L := Secuencia(i);
			--i := i + 1;
			Execution_Time (WCET_Eyes_Image);
		end Reading_Distance;


		procedure Reaction (Level: in integer) is
			type Time_index is delta 0.1 range 0.0..100.0;
			t: Time_index;
			j: Indice_Secuencia_Distancia := 1;
		begin
			t := Time_index(To_Duration(Clock - Big_Bang));
			j := Indice_Secuencia_Distancia (t * 10.0);
			if (Level = 1) then
				for k in j..j+4 loop
					secuencia (k):= (Distance_Samples_Type(80));
				end loop; 
			elsif (Level = 2) then 
				for k in i..Indice_Secuencia_Distancia'Last loop
				Secuencia (k):= (Distance_Samples_Type(80)); 
				end loop;
			end if;
		end Reaction;
	end Lectura_Distancia;


	procedure Display_Distance (D: Distance_Samples_Type) is
		begin
		Current_Time (Big_Bang);
		Put ("............# ");
		Put ("Distance: ");
		Print_an_Integer (Integer(D));
		Execution_Time (WCET_Distance);
	end Display_Distance;




	---------------------------------------------------------------------
	-- Procedures to get current speed  
	---------------------------------------------------------------------

	protected Lectura_Velocidad is
		procedure Reading_Speed (V: out Speed_Samples_Type);
		procedure Reaction (Level: in integer);
	private
		i: Indice_Secuencia_Velocidad := 1;
		Secuencia: tipo_Secuencia_Velocidad := Speed_Simulation;
	end Lectura_Velocidad;
	
	procedure Reading_Speed (V: out Speed_Samples_Type) is
		begin
			Lectura_Velocidad.Reading_Speed (V);
		end Reading_Speed;


	protected body Lectura_Velocidad is
		procedure Reading_Speed (V: out Speed_Samples_Type)  is
			type Time_index is delta 0.1 range 0.0..100.0;
			t: Time_index;
		begin
			t := Time_index(To_Duration(Clock - Big_Bang));
			i := Indice_Secuencia_Velocidad (integer(t * 10.0) mod 100);
			V := Secuencia(i);
			--i := i + 1;
			Execution_Time (WCET_Speed);
		end Reading_Speed;


		procedure Reaction (Level: in integer) is
			type Time_index is delta 0.1 range 0.0..100.0;
			t: Time_index;
			j: Indice_Secuencia_Velocidad := 1;
		begin
			t := Time_index(To_Duration(Clock - Big_Bang));
			j := Indice_Secuencia_Velocidad (t * 10.0);
			if (Level = 1) then
				for k in j..j+4 loop
					secuencia (k):= (Speed_Samples_Type(70));
				end loop; 
			elsif (Level = 2) then 
				for k in i..Indice_Secuencia_Velocidad'Last loop
					Secuencia (k):= (Speed_Samples_Type(70)); 
				end loop;
			end if;
		end Reaction;	
	end Lectura_Velocidad;


	procedure Display_Speed (V: Speed_Samples_Type) is
	begin
		Current_Time (Big_Bang);
		Put ("............# ");
		Put ("Speed: ");
		Print_an_Integer (Integer(V));
		Execution_Time (WCET_Speed);
	end Display_Speed;




	---------------------------------------------------------------------
	-- Procedures to get head position  
	---------------------------------------------------------------------

	protected Lectura_HeadPosition is
		procedure Reading_HeadPosition (H: out HeadPosition_Samples_Type);
		procedure Reaction (Level: in integer);
	private
		i: Indice_Secuencia_HeadPosition := 1;
		Secuencia: tipo_Secuencia_HeadPosition := HeadPosition_Simulation;
	end Lectura_HeadPosition;


	procedure Reading_HeadPosition (H: out HeadPosition_Samples_Type) is
	begin
		Lectura_HeadPosition.Reading_HeadPosition (H);
	end Reading_HeadPosition;


	protected body Lectura_HeadPosition is
		procedure Reading_HeadPosition (H: out HeadPosition_Samples_Type)  is
			type Time_index is delta 0.1 range 0.0..100.0;
			t: Time_index;
		begin
			t := Time_index(To_Duration(Clock - Big_Bang));
			i := Indice_Secuencia_HeadPosition (integer(t * 10.0) mod 100);
			H := Secuencia(i);
			--i := i + 1;
			Execution_Time (WCET_HeadPosition);
		end Reading_HeadPosition;


		procedure Reaction (Level: in integer) is
			type Time_index is delta 0.1 range 0.0..100.0;
			t: Time_index;
		begin
			t := Time_index(To_Duration(Clock - Big_Bang));
			i := Indice_Secuencia_HeadPosition (t * 10.0);
			if (Level = 1) then
				for k in i..i+4 loop
					secuencia (k):= (HeadPosition_Samples_Values(0),HeadPosition_Samples_Values(0));
				end loop; 
			elsif (Level = 2) then 
				for k in i..Indice_Secuencia_HeadPosition'Last loop
					Secuencia (k):= (HeadPosition_Samples_Values(0),HeadPosition_Samples_Values(0)); 
				end loop;
			end if;
		end Reaction;
	
	end Lectura_HeadPosition;


	procedure Display_HeadPosition_Sample (H: HeadPosition_Samples_Type) is
	begin
		Current_Time (Big_Bang);
		Put ("............# ");
		Put ("HeadPosition: ");
		for i in HeadPosition_Samples_Index loop
			Print_an_Integer (Integer(H(i)));
		end loop;
		Execution_Time (WCET_Display);
	end Display_HeadPosition_Sample;




	---------------------------------------------------------------------
	-- Procedures to get and analyze an eyes image 
	---------------------------------------------------------------------

	protected Lectura_EyesImage is
		procedure Reading_EyesImage (L: out Eyes_Samples_Type);
		procedure Reaction (Level: in integer);
	private
		i: Indice_Secuencia_EyesImage := 1;
		Secuencia: tipo_Secuencia_EyesImage := Eyes_Simulation;
	end Lectura_EyesImage;
	
	procedure Reading_EyesImage (L: out Eyes_Samples_Type) is
		begin
			Lectura_EyesImage.Reading_EyesImage (L);
		end Reading_EyesImage;


	protected body Lectura_EyesImage is
		procedure Reading_EyesImage (L: out Eyes_Samples_Type)  is
			type Time_index is delta 0.1 range 0.0..100.0;
			t: Time_index;
		begin
			t := Time_index(To_Duration(Clock - Big_Bang));
			i := Indice_Secuencia_eyesImage (integer(t * 10.0) mod 100);
			L := Secuencia(i);
			--i := i + 1;
			Execution_Time (WCET_Eyes_Image);
		end Reading_EyesImage;


		procedure Reaction (Level: in integer) is
			type Time_index is delta 0.1 range 0.0..100.0;
			t: Time_index;
		begin
			t := Time_index(To_Duration(Clock - Big_Bang));
			i := Indice_Secuencia_eyesImage (t * 10.0);
			if (Level = 1) then
				for k in i..i+4 loop
					secuencia (k):= (Eyes_Samples_Values(80),Eyes_Samples_Values(80));
				end loop; 
			elsif (Level = 2) then 
				for k in i..Indice_Secuencia_eyesImage'Last loop
					Secuencia (k):= (Eyes_Samples_Values(80),Eyes_Samples_Values(80)); 
				end loop;
			end if;
		end Reaction;	
	end Lectura_EyesImage;


	procedure Display_Eyes_Sample (R: Eyes_Samples_Type) is
		Average: Eyes_Samples_Values;
	begin
		Current_Time (Big_Bang);
		Put ("............# ");
		Put ("Eyes Openness: ");
		for i in Eyes_Samples_Index loop
			Print_an_Integer (Integer(R(i)));
		end loop;
		
		Average := (R(Right) + R(Left))/2;
		if    Average > 80 then Put ("   (O,O)");
		elsif Average > 60 then Put ("   (o,o)");
		elsif Average > 30 then Put ("   (*,*)");
		else                    Put ("   (-,-)");
		end if;
		
		Execution_Time (WCET_Display);
	end Display_Eyes_Sample;




	---------------------------------------------------------------------
	-- Procedures to get current steering wheel position  
	---------------------------------------------------------------------

	protected Lectura_Volante is
		procedure Reading_Steering (S: out Steering_Samples_Type);
		procedure Reaction (Level: in integer);
	private
		i: Indice_Secuencia_Volante := 1;
		Secuencia: tipo_Secuencia_Volante := Steering_Simulation;
	end Lectura_Volante;


	procedure Reading_Steering (S: out Steering_Samples_Type) is
	begin
		Lectura_Volante.Reading_Steering (S);
	end Reading_Steering;
	

	protected body Lectura_Volante is
		procedure Reading_Steering (S: out Steering_Samples_Type)  is
			type Time_index is delta 0.1 range 0.0..100.0;
			t: Time_index;
		begin
			t := Time_index(To_Duration(Clock - Big_Bang));
			i := Indice_Secuencia_Volante (integer(t * 10.0) mod 100);
			S := Secuencia(i);
			--i := i + 1;
			Execution_Time (WCET_Steering);
		end Reading_Steering;


		procedure Reaction (Level: in integer) is
			type Time_index is delta 0.1 range 0.0..100.0;
			t: Time_index;
			j: Indice_Secuencia_Volante := 1;
		begin
			t := Time_index(To_Duration(Clock - Big_Bang));
			j := Indice_Secuencia_Volante (t * 10.0);
			if (Level = 1) then
				for k in j..j+4 loop
					secuencia (k):= (Steering_Samples_Type(70));
				end loop; 
			elsif (Level = 2) then 
				for k in i..Indice_Secuencia_Volante'Last loop
					Secuencia (k):= (Steering_Samples_Type(70)); 
				end loop;
			end if;
	  end Reaction;
	end Lectura_Volante;


	procedure Display_Steering (S: Steering_Samples_Type) is
	begin
		Current_Time (Big_Bang);
		Put ("............# ");
		Put ("Steering: ");
		Print_an_Integer (Integer(S));
		Execution_Time (WCET_Steering);
	end Display_Steering;


   --------------------------------------------------------------------------
   -- Procedures to access electrode sensors
   --------------------------------------------------------------------------

	protected Sensores_Electrodos is
		procedure Reading_Sensors (L: out EEG_Samples_Type);
	private
		i: Indice_Secuencia_Sensores := 1;
		Secuencia: tipo_Secuencia_Sensores := EEG_Simulation;
	end Sensores_Electrodos;


	procedure Reading_Sensors (L: out EEG_Samples_Type) is
	begin
		Sensores_Electrodos.Reading_Sensors (L);
	end Reading_Sensors;


	protected body Sensores_Electrodos is
		procedure Reading_Sensors (L: out EEG_Samples_Type)  is
			type Time_index is delta 0.1 range 0.0..100.0;
			t: Time_index;
		begin
			t := Time_index(To_Duration(Clock - Big_Bang));
			i := indice_Secuencia_Sensores (integer(t * 10.0) mod 100);
			L := Secuencia(i);
			--i := i + 1;
			Execution_Time (WCET_EEG);
		end Reading_Sensors;
	end Sensores_Electrodos;


	procedure Display_Electrodes_Sample (R: EEG_Samples_Type) is
	begin
		Current_Time (Big_Bang);
		Put ("............# ");
		Put ("Electrodes Values: ");
		for i in EEG_Samples_Index loop
			Print_an_Integer (Integer(R(i)));
		end loop;
		Execution_Time (WCET_Display);
	end Display_Electrodes_Sample;









-----------------------------------------------------------------------------
procedure Display_Pulse_Rate (P: Values_Pulse_Rate) is
begin
	Current_Time (Big_Bang);
	Put ("............# ");
	Put ("Pulse Rate: ");
	Print_an_Integer (Integer(P));
	Execution_Time (WCET_Display);
end Display_Pulse_Rate;
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
procedure Display_Cronometro (Origen : Ada.Real_Time.Time; Hora: Ada.Real_Time.Time ) is
	type Crono is delta 0.1 range 0.0..100.0;
begin
	Current_Time (Big_Bang);
	Put ("............%Crono:");
	Put (Crono'Image(Crono(To_Duration(Hora - Origen))));
end Display_Cronometro;
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
procedure Light (E: Light_States) is
begin
	Current_Time (Big_Bang);
	case E is
		when On  => Put ("............Light: ^ON^");
		when Off => Put ("............Light: _off_");
	end case;
	Execution_Time (WCET_Light);
end Light;
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
procedure Beep (v: Volume) is 
    -- emite un sonido durante 0.3 segundos con volumne "v"
begin
	Current_Time (Big_Bang);

	Put ("............%B");
	for i in 1..v loop
		Put ("EE");
	end loop ;  
	Put ("P");
	Put (Volume'Image(v));
	Execution_Time (WCET_Alarm);
	--Lectura_EyesImage.Reaction (EYES_REACTION_WHEN_BEEP);
end Beep;
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
procedure Activate_Automatic_Driving is
begin
	Current_Time (Big_Bang);
	Put ("!!!! Automatic driving system activated !!!!");
	Execution_Time (WCET_Automatic_Driving);
end Activate_Automatic_Driving;
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
procedure Activate_Brake is
begin
	Current_Time (Big_Bang);
	Put ("!!!! Brake activated !!!!");
	Execution_Time (WCET_Brake);
end Activate_Brake;
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
begin
	null;
end devices;


