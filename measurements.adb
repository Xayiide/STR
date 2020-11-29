with devices; use devices;
with Tools; use Tools;
with Ada.Real_Time; use Ada.Real_Time;

package body measurements is	
	protected body prMeasurements is
		procedure setmdistance (D : in Distance_Samples_Type) is
		begin
		Execution_Time(Milliseconds(2));
			mdistance := D;
		end setmdistance;

		procedure setmspeed (S : in Speed_Samples_Type) is
		begin
		Execution_Time(Milliseconds(3));
			mspeed := S;
		end setmspeed;

		---------------------------------
		 -------------------------------
		--------------------------------

		procedure getmdistance (D : out Distance_Samples_Type) is
		begin
		Execution_Time(Milliseconds(4));
			D := mdistance;
		end getmdistance;

		procedure getmspeed (S : out Speed_Samples_Type) is
		begin
		Execution_Time(Milliseconds(6));
			S := mspeed;
		end getmspeed;

	end prMeasurements;


	procedure readMeasurements(D : out Distance_Samples_Type;
							   S : out Speed_Samples_Type) is
	begin
	Execution_Time(Milliseconds(2));
		prMeasurements.getmdistance(D);
		prMeasurements.getmspeed(S);
	end readMeasurements;



end measurements;
