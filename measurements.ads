with devices; use devices; -- Para los tipos

package measurements is
	protected prMeasurements is
		pragma priority(4); -- Risks task priority 
		procedure setmdistance(D : in Distance_Samples_Type);
		procedure setmspeed(S : in Speed_Samples_Type);

		procedure getmdistance(D : out Distance_Samples_Type);
		procedure getmspeed(S : out Speed_Samples_Type);

	private
		mdistance : Distance_Samples_Type;
		mspeed    : Speed_Samples_Type;

	end prMeasurements;

	procedure readMeasurements(D : out Distance_Samples_Type;
							   S : out Speed_Samples_Type);

end measurements;
