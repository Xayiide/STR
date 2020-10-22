with Kernel.Peripherals.Registers;
--  to get definitions of MEC registers such as:
--         Test_Control
--         Interrupt_Mask
--         Interrupt_Force

procedure Force_External_Interrupt_2 is

   package KPR renames Kernel.Peripherals.Registers;

   --  The MEC registers must be accesses as a whole.
   --  The workaround used to force GNAT to generate proper instructions is:
   --  Registers type definition are cualified with pragma Atomic
   --  and auxiliary objects are used to write the MEC registers

   Test_Control_Auxiliary : KPR.Test_Control_Register :=
                            KPR.Test_Control;
   Interrupt_Mask_Auxiliary : KPR.Interrupt_Mask_Register :=
                              KPR.Interrupt_Mask;
   Interrupt_Force_Auxiliary : KPR.Interrupt_Force_Register :=
                               KPR.Interrupt_Force;

begin

   Test_Control_Auxiliary.Interrupt_Force_Register_Write_Enable := True;
   Interrupt_Mask_Auxiliary.External_Interrupt_2 := False;
   Interrupt_Force_Auxiliary.External_Interrupt_2 := True;

   KPR.Test_Control := Test_Control_Auxiliary;
   KPR.Interrupt_Mask := Interrupt_Mask_Auxiliary;
   KPR.Interrupt_Force := Interrupt_Force_Auxiliary;

end Force_External_Interrupt_2;
