
with Kernel.Serial_Output; use Kernel.Serial_Output;
with Ada.Real_Time; use Ada.Real_Time;
--use type Ada.Real_Time.Time_Span;
--with System; use System;

with Workload;
--with Kernel.Peripherals; use Kernel.Peripherals;
--use type Kernel.Peripherals.UART_Channel;

package body tools is
	---------------------------------------------------------------------
	--     PROCEDIMIENTO QUE IMPRIME LA HORA                           --
	---------------------------------------------------------------------
	procedure Current_Time (Origen : Ada.Real_Time.Time)is
	begin
		Put_Line ("");
		Put ("[");
		--Print_RTClok;
		--Kernel.Serial_Output.Put (" / ");
		Kernel.Serial_Output.Put(Duration'Image(To_Duration(Clock - Origen)));
		Put ("] ");
		-- Put_Line ("");
	end Current_Time;


	---------------------------------------------------------------------
	--     PROCEDIMIENTO QUE SACA EL VALOR DE UN ENTERO POR LA UART    --
	---------------------------------------------------------------------
	procedure Print_an_Integer (x : in integer) is
	begin
		--Put ("(");
		Kernel.Serial_Output.Put (Integer'Image(x));
		--Put (")");
	end Print_an_Integer;


	---------------------------------------------------------------------
	--     PROCEDIMIENTO QUE SACA EL VALOR DE UN FLOAT POR LA UART    --
	---------------------------------------------------------------------
	procedure Print_a_Float (x : in float) is
		type Float_Printable is digits 2; 
		nx: Float_Printable;
	begin
		--Put ("(");
		nx := Float_Printable (x);
		Kernel.Serial_Output.Put (Float_Printable'Image(nx));
		--Put (")");
	end Print_a_Float;


	---------------------------------------------------------------------
	--     PROCEDIMIENTO PARA AVISAR DEL ARRANQUE DE UNA TAREA         --
	---------------------------------------------------------------------
	procedure Starting_Notice (T: in String) is
	begin
		Current_Time (Big_Bang);
		Put (">>> ");
		Put (T);
	end Starting_Notice;
	
	procedure Finishing_Notice (T: in String) is
	begin
		Current_Time (Big_Bang);
		Put ("--- ");
		Put (T);
	end Finishing_Notice;
	
	
	---------------------------------------------------------------------
	--     PROCEDIMIENTO QUE HACE CALCULOS                             --
	---------------------------------------------------------------------
	Time_per_Kwhetstones : constant Ada.Real_Time.Time_Span :=
									Ada.Real_Time.Nanoseconds (660000); -- anterior (479936);
	procedure Execution_Time (Time : Ada.Real_Time.Time_Span) is
	begin
		Workload.Small_Whetstone (Time / Time_per_Kwhetstones);
	end Execution_Time;
---------------------------------------------------------------------


begin
	null;
end tools;



