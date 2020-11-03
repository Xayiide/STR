with devices; use devices;

package body measurements is	
	protected body prmeasurements is
		procedure setmdistance (D : in Distance_Samples_Type) is
		begin
			mdistance := D;
		end setmdistance;

		procedure setmspeed (S : in Speed_Samples_Type) is
		begin
			mspeed := S;
		end setmspeed;

		---------------------------------
		 -------------------------------
		--------------------------------

		procedure getmdistance (D : out Distance_Samples_Type) is
		begin
			D := mdistance;
		end getmdistance;

		procedure getmspeed (S : out Speed_Samples_Type) is
		begin
			S := mspeed;
		end getmspeed;

	end prmeasurements;
end measurements;