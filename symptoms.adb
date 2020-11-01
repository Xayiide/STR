package body symptoms is
	protected body prsymptoms is
		procedure setSwerve (S: in Boolean) is
		begin
			swerve := S;
		end setSwerve;
		
		
		procedure setLean  (L: in Boolean) is
		begin
			lean := L;
		end setLean;
		
		
		procedure setUnsafeD (U: in  Boolean) is
		begin
			unsafeD := U;
		end setUnsafeD;
		
		
		procedure setImprdD (I: in  Boolean) is
		begin
			imprdD := I;
		end setImprdD;
		
		
		procedure setCollision (C: in  Boolean) is
		begin
			collision := C;
		end setCollision;
		
		---------------------------------
		 -------------------------------
		---------------------------------
		
		procedure getSwerve (S: out Boolean) is
		begin
			S := swerve;
		end getSwerve;
		
		
		procedure getLean (L: out Boolean) is
		begin
			L := lean;
		end getLean;
		
		
		procedure getUnsafeD (U: out Boolean) is
		begin
			U := unsafeD;
		end getUnsafeD;
		
		
		procedure getImprdD (I: out Boolean) is
		begin
			I := imprdD;
		end getImprdD;
		
		
		procedure getCollision (C: out Boolean) is
		begin
			C := collision;
		end getCollision;
		
	end prsymptoms;

	procedure readSymptoms(S : out Boolean,
						   L : Out Boolean,
						   U : Out Boolean,
						   I : Out Boolean,
						   C : Out Boolean) is
	begin
		getSwerve(S);
		getLean(L);
		getUnsafeD(U);
		getImprdD(I);
		getCollision(C);
	end readSymptoms;


begin
	null;
end symptoms;
