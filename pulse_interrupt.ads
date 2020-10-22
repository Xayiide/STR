

with Ada.Real_Time; use Ada.Real_Time;
with System; use System; 

package pulse_interrupt is

    ---------------------------------------------------------------------
    ------ declaracion de procedimientos de acceso a DISPOSITIVOS E/S  --
    ---------------------------------------------------------------------

   Interr_1: constant Time_Span := To_Time_Span (0.5);
   Interr_2: constant Time_Span := To_Time_Span (0.5);
   Interr_3: constant Time_Span := To_Time_Span (0.7);
   Interr_4: constant Time_Span := To_Time_Span (0.9);
   Interr_5: constant Time_Span := To_Time_Span (0.9);
   Interr_6: constant Time_Span := To_Time_Span (0.8);
   Interr_7: constant Time_Span := To_Time_Span (0.7);
   Interr_8: constant Time_Span := To_Time_Span (0.7);
   Interr_9: constant Time_Span := To_Time_Span (0.6);
   Interr_10: constant Time_Span := To_Time_Span (0.6);


   --------------------------------------------------------------------------
   -- Tarea que fuerza la interrupcion externa 2 en los instantes indicados --
   --------------------------------------------------------------------------

   Priority_Of_External_Interrupts_2 : constant System.Interrupt_Priority
                                       := System.Interrupt_Priority'First + 9;

   task Interrupt is
      pragma Priority (Priority_Of_External_Interrupts_2);
   end Interrupt;


end pulse_interrupt;



