
with Kernel.Serial_Output; use Kernel.Serial_Output;

with System; use System;
with Force_External_Interrupt_2;

--with Registro; use Registro;
with tools; use tools;

package body pulse_interrupt is

   --------------------------------------------------------------------------
   -- Tarea que fuerza la interrupcion externa 2 en los instantes indicados --
   --------------------------------------------------------------------------

   task body Interrupt is
     Next_Time : Ada.Real_Time.Time := Big_Bang;

     Tamanio_Tabla_Retardos : constant Integer := 10;
     type Indice_Retardos is mod Tamanio_Tabla_Retardos;
     type Tabla_Retardos is array (Indice_Retardos) of Ada.Real_Time.Time_Span;
     periodoInterrupcion: Tabla_Retardos := (Interr_1,Interr_2,Interr_3,Interr_4,Interr_5,
                                             Interr_6,Interr_7,Interr_8,Interr_9,Interr_10);
     j : Indice_Retardos := Indice_Retardos'First;
   begin
      loop
         Next_Time := Next_Time + PeriodoInterrupcion(j);
         delay until Next_Time;
         Force_External_Interrupt_2;
         j := j + 1;

         --Hora_Actual (Big_Bang);
         --Put ("======> Interrupción Externa 2 ");
      end loop;
   end Interrupt;

---------------------------------------------------------------------

begin
   null;
end pulse_interrupt;



