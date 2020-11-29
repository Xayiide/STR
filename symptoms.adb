package body symptoms is
	protected body prSymptoms is
		procedure setSwerve (S: in Boolean) is
		begin
			Execution_Time(Milliseconds(5));
			swerve := S;
		end setSwerve;
		
		
		procedure setLean  (L: in Boolean) is
		begin
			Execution_Time(Milliseconds(2));
			lean := L;
		end setLean;
		
		
		procedure setUnsafeD (U: in  Boolean) is
		begin
			Execution_Time(Milliseconds(3));
			unsafeD := U;
			if (U = TRUE) then
				imprdD    := FALSE;
				collision := FALSE;
			end if;
		end setUnsafeD;
		
		
		procedure setImprdD (I: in  Boolean) is
		begin
			Execution_Time(Milliseconds(4));
			imprdD := I;
			if (I = TRUE) then
				unsafeD   := FALSE;
				collision := FALSE;
			end if;
		end setImprdD;
		
		
		procedure setCollision (C: in  Boolean) is
		begin
			Execution_Time(Milliseconds(6));
			collision := C;
			if (C = TRUE) then
				unsafeD := FALSE;
				imprdD  := FALSE;
			end if;
		end setCollision;
		
		---------------------------------
		 -------------------------------
		---------------------------------
		
		procedure getSwerve (S: out Boolean) is
		begin
			Execution_Time(Milliseconds(5));
			S := swerve;
		end getSwerve;
		
		
		procedure getLean (L: out Boolean) is
		begin
			Execution_Time(Milliseconds(2));
			L := lean;
		end getLean;
		
		
		procedure getUnsafeD (U: out Boolean) is
		begin
			Execution_Time(Milliseconds(3));
			U := unsafeD;
		end getUnsafeD;
		
		
		procedure getImprdD (I: out Boolean) is
		begin
			Execution_Time(Milliseconds(6));
			I := imprdD;
		end getImprdD;
		
		
		procedure getCollision (C: out Boolean) is
		begin
			Execution_Time(Milliseconds(7));
			C := collision;
		end getCollision;
		
	end prSymptoms;

	procedure readSymptoms(S : out Boolean;
						   L : Out Boolean;
						   U : Out Boolean;
						   I : Out Boolean;
						   C : Out Boolean) is
	begin
		Execution_Time(Milliseconds(8));
		prSymptoms.getSwerve(S);
		prSymptoms.getLean(L);
		prSymptoms.getUnsafeD(U);
		prSymptoms.getImprdD(I);
		prSymptoms.getCollision(C);
	end readSymptoms;


begin
	null;
end symptoms;

-- Nota:
-- los sintomas unsafeD, imprdD y collision son excluyentes. Esto se debe a que
-- en esencia son el mismo sintoma pero con mayor gravedad cada uno. Por ello
-- sus respectivos setters se encargan de que solo uno de ellos este activo en
-- cada momento: no tiene sentido que este activo el sintoma de riesgo_colision
-- y el de distancia_imprudente al mismo tiempo, porque el de riesgo_colision
-- es el de distancia_imprudente pero en un rango de peligrosidad aumentada.
