
package symptoms is
	protected prSymptoms is
		pragma priority(10); -- Risks task priority
		procedure setSwerve   (S: in Boolean);
		procedure setLean     (L: in Boolean);
		procedure setUnsafeD  (U: in Boolean);
		procedure setImprdD   (I: in Boolean);
		procedure setCollision(C: in Boolean);
		
		procedure getSwerve   (S: out Boolean);
		procedure getLean     (L: out Boolean);
		procedure getUnsafeD  (U: out Boolean);
		procedure getImprdD   (I: out Boolean);
		procedure getCollision(C: out Boolean);
		
	private
		swerve    : Boolean;
		lean      : Boolean;
		unsafeD   : Boolean;
		imprdD    : Boolean; 
		collision : Boolean; 
	end prSymptoms;

	procedure readSymptoms(S : out Boolean;
						   L : Out Boolean;
						   U : Out Boolean;
						   I : Out Boolean;
						   C : Out Boolean);

end symptoms;
