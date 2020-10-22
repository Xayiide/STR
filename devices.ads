with Ada.Real_Time; use Ada.Real_Time;

package devices is

    ---------------------------------------------------------------------
    ------ Access time for devices
    ---------------------------------------------------------------------
    WCET_Distance: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(12);
    WCET_Speed: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(7);
    WCET_HeadPosition: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(4);
    WCET_Eyes_Image: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(20);
    
    WCET_Steering: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(7);
    WCET_EEG: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(18);
    
    WCET_Display: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(15);
    WCET_Alarm: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);
    WCET_Light: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);
    WCET_Automatic_Driving: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);
    WCET_Brake: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);




    ---------------------------------------------------------------------
    ------ DISTANCE -----------------------------------------------------
    
    type Distance_Samples_Type is new natural range 0..150;
    
    procedure Reading_Distance (L: out Distance_Samples_Type); -- From 0m. to 150m. 
    
    ---------------------------------------------------------------------
    procedure Display_Distance (D: Distance_Samples_Type);
    
    -- SIMULATION
    cantidad_datos_Distancia: constant := 100;
    type Indice_Secuencia_Distancia is mod cantidad_datos_Distancia;
    type tipo_Secuencia_Distancia is array (Indice_Secuencia_Distancia) of Distance_Samples_Type;
    
    Distance_Simulation: tipo_Secuencia_Distancia :=
                 ( 95,90,90,85,80,   -- 1 muestra cada 100ms.
                   90,90,80,85,80,   -- 1s.
 
                   80,80,80,75,70, 
                   70,70,70,65,65,   -- 2s.

                   60,60,60,55,50, 
                   55,50,50,45,40,   -- 3s.

                   30,30,30,25,25, 
                   25,25,20,20,20,   -- 4s.

                   30,30,40,45,50, 
                   60,60,60,65,70,   -- 5s.

                   80,80,80,75,70, 
                   70,70,70,65,65,   -- 6s.
 
                   80,80,80,75,70, 
                   70,70,70,65,65,   -- 7s.

                   60,60,60,55,50, 
                   55,50,50,45,40,   -- 8s.

                   30,30,30,25,25, 
                   25,25,20,20,20,   -- 9s.

                   30,30,40,45,50, 
                   60,60,60,65,70 ); -- 10s.




    ---------------------------------------------------------------------
    ------ SPEED --------------------------------------------------------
    
    type Speed_Samples_Type is new natural range 0..200;
    
    procedure Reading_Speed (V: out Speed_Samples_Type); -- From 0m. to 200m.
    
    ---------------------------------------------------------------------
    procedure Display_Speed (V: Speed_Samples_Type);
    
    -- SIMULATION
    cantidad_datos_Velocidad: constant := 100;
    type Indice_Secuencia_Velocidad is mod cantidad_datos_Velocidad;
    type tipo_Secuencia_Velocidad is array (Indice_Secuencia_Velocidad) of Speed_Samples_Type;
    
    Speed_Simulation: tipo_Secuencia_Velocidad :=
                 ( 62,60,60,65,70,   -- 1 muestra cada 100ms.
                   70,70,70,75,80,   -- 1s.
 
                   80,80,80,85,80, 
                   80,80,80,85,85,   -- 2s.

                   90,90,90,95,99, 
                   99,99,99,99,98,   -- 3s.

                   100,100,100,105,105, 
                   105,105,110,110,110,   -- 4s.

                   110,110,110,115,110, 
                   110,110,110,115,115,   -- 5s.

                   115,115,115,115,115, 
                   120,120,120,120,120,   -- 6s.
 
                   120,120,120,120,120, 
                   120,120,120,120,120,   -- 7s.

                   120,120,120,120,120, 
                   120,120,120,120,120,   -- 8s.

                   110,110,110,115,110, 
                   110,110,110,115,115,   -- 9s.

                   115,110,110,112,110, 
                   100,100,100,100,100 ); -- 10s.




    ---------------------------------------------------------------------
    ------ HeadPosition -------------------------------------------------
    
    type HeadPosition_Samples_Index is (x,y);
    type HeadPosition_Samples_Values is new integer range -90..+90;
    type HeadPosition_Samples_Type is array (HeadPosition_Samples_Index) 
                                         of HeadPosition_Samples_Values;
    
    procedure Reading_HeadPosition (H: out HeadPosition_Samples_Type); -- Returns the angle -90..+90 degrees 
    
    --------------------------------------------------------------------
    procedure Display_HeadPosition_Sample (H: HeadPosition_Samples_Type);
    
    -- SIMULATION
    cantidad_datos_HeadPosition: constant := 100;
    type Indice_Secuencia_HeadPosition is mod cantidad_datos_HeadPosition;
    type tipo_Secuencia_HeadPosition is array (Indice_Secuencia_HeadPosition) 
                                             of HeadPosition_Samples_Type;
    
    HeadPosition_Simulation: tipo_Secuencia_HeadPosition :=
                ((+01,+03),(+01,+03),(+02,+01),(+03,+00),(+01,-03),  -- 1 muestra cada 100ms.
                 (+01,+03),(-01,+03),(-02,+01),(+03,+00),(+01,-03),  --1s.
 
                 (+01,+03),(+01,+03),(+02,+01),(+03,+00),(+01,-03),  
                 (+01,+03),(-01,+03),(-02,+01),(+03,+00),(+01,-03),  --2s.

                 (+01,+03),(+01,+03),(+02,+01),(+03,+00),(+01,-03),  
                 (+15,+03),(+15,+03),(+15,+01),(+20,+00),(+20,-03),  --3s.

                 (+25,+03),(+25,+03),(+35,+01),(+35,+00),(+35,-03),  
                 (+37,+03),(+37,+03),(+37,+01),(+45,+00),(+45,-03),  --4s.

                 (+47,+03),(+47,+03),(+47,+01),(+45,+00),(+45,-03),  
                 (+47,+03),(+47,+03),(+47,+01),(+46,+00),(+46,-03),  --5s.
                  
                 (+47,+03),(+47,+03),(+47,+01),(+45,+00),(+45,-03),  
                 (+47,+03),(+47,+03),(+47,+01),(+46,+00),(+46,-03),  --6s.
 
                 (+47,+03),(+47,+03),(+47,+01),(+45,+00),(+45,-03),  
                 (+47,+03),(+47,+03),(+47,+01),(+46,+00),(+46,-03),  --7s.

                 (+47,+03),(+47,+03),(+47,+01),(+45,+00),(+45,-03),  
                 (+47,+03),(+47,+03),(+47,+01),(+46,+00),(+46,-03),  --8s.

                 (+47,+03),(+47,+03),(+47,+01),(+45,+00),(+45,-03),  
                 (+47,+03),(+47,+03),(+47,+01),(+46,+00),(+46,-03),  --9s.

                 (+47,+03),(+47,+03),(+47,+01),(+45,+00),(+45,-03),  
                 (+47,+03),(+47,+03),(+47,+01),(+46,+00),(+46,-03) );  --10s.




    ---------------------------------------------------------------------
    ------ EYES ---------------------------------------------------------

    type Eyes_Samples_Index is (left,right);
    type Eyes_Samples_Values is new natural range 0..100;
    type Eyes_Samples_Type is array (Eyes_Samples_Index) of Eyes_Samples_Values;

    procedure Reading_EyesImage (L: out Eyes_Samples_Type); -- Returns percentage of aperture

    --------------------------------------------------------------------
    procedure Display_Eyes_Sample (R: Eyes_Samples_Type);

    -- SIMULATION
    cantidad_datos_EyesImage: constant := 100;
    type Indice_Secuencia_EyesImage is mod cantidad_datos_EyesImage;
    type tipo_Secuencia_EyesImage is array (Indice_Secuencia_EyesImage) of Eyes_Samples_Type;

    Eyes_Simulation: tipo_Secuencia_EyesImage :=
                ((85,85),(70,70),(85,85),(85,85),(05,05),  -- 1 muestra cada 100ms.
                 (05,05),(85,85),(20,20),(85,85),(85,85),  --1s.
 
                 (70,70),(60,60),(60,60),(40,40),(40,40),
                 (40,40),(40,40),(40,40),(40,40),(30,30),  --2s.

                 (30,30),(30,30),(40,40),(40,40),(40,40),
                 (50,50),(50,50),(50,50),(50,50),(50,50),  --3s.

                 (60,60),(60,60),(50,50),(40,40),(40,40),
                 (50,50),(50,50),(50,50),(50,50),(50,50),  --4s.

                 (30,30),(30,30),(40,40),(40,40),(40,40),
                 (50,50),(50,50),(50,50),(50,50),(50,50),  --5s.
                  
                 (20,20),(20,20),(20,20),(25,25),(25,25),
                 (20,20),(20,20),(20,20),(15,15),(15,15),  --6s.
 
                 (10,10),(10,10),(10,10),(10,10),(10,40),
                 ( 0, 0),( 0, 0),( 5, 5),( 5, 5),( 5, 5),  --7s.

                 ( 0, 0),( 0, 0),( 0, 0),( 0, 0),( 0, 0),
                 ( 0, 0),( 0, 0),( 0, 0),( 0, 0),( 0, 0),  --8s.

                 ( 0, 0),( 0, 0),( 0, 0),( 0, 0),( 0, 0),
                 ( 0, 0),( 0, 0),( 0, 0),( 0, 0),( 0, 0),  --9s.

                 ( 0, 0),( 0, 0),( 0, 0),( 0, 0),( 0, 0),
                 ( 0, 0),( 0, 0),( 0, 0),( 0, 0),( 0, 0) );  --10s.




    ---------------------------------------------------------------------
    ------ STEERING WHEEL -----------------------------------------------

    type Steering_Samples_Type is new integer range -180..180;

    procedure Reading_Steering (S: out Steering_Samples_Type);

    ---------------------------------------------------------------------
    procedure Display_Steering (S: Steering_Samples_Type);

    -- SIMULATION
    cantidad_datos_Volante: constant := 100;
    type Indice_Secuencia_Volante is mod cantidad_datos_Volante;
    type tipo_Secuencia_Volante is array (Indice_Secuencia_Volante) of Steering_Samples_Type;

    Steering_Simulation: tipo_Secuencia_Volante :=
                 (  0,  0, 0,  5, 4,   -- 1 muestra cada 100ms.
                    0, -2, 0, -3, 0,   -- 1s.
 
                   10,10,10,15,10, 
                   10,10,10,15,15,   -- 2s.

                   20,20,20,25,29, 
                   19,19,10,10,05,   -- 3s.

                   00,00,00,05,05, 
                   -05,-05,00,00,10,  -- 4s.

                   11,21,20,35,35, 
                   35,35,40,45,50,    -- 5s.

                   00,00,01,-01,05, 
                   02,00,00,-02,02,   -- 6s.
 
                   00,00,01,-01,05, 
                   02,00,00,-02,02,   -- 7s.

                   00,00,01,-01,05, 
                   02,00,00,-02,02,   -- 8s.

                   00,00,01,-01,05, 
                   02,00,00,-02,02,   -- 9s.

                   00,00,01,-01,05, 
                   02,00,00,-02,02 ); -- 10s.    




    ---------------------------------------------------------------------
    ------ ELECTRODES --------------------------------------------------- 

    type Value_Electrode is new natural range 0..10;
    Number_Electrodes: constant integer := 10;

    type EEG_Samples_Index is new natural range 1..Number_Electrodes;
    type EEG_Samples_Type is array (EEG_Samples_Index) of Value_Electrode;


    procedure Reading_Sensors (L: out EEG_Samples_Type);

    ---------------------------------------------------------------------
    procedure Display_Electrodes_Sample (R: EEG_Samples_Type);

    -- SIMULATION
    cantidad_datos_Sensores: constant := 100;
    type Indice_Secuencia_Sensores is mod cantidad_datos_Sensores;
    type tipo_Secuencia_Sensores is array (Indice_Secuencia_Sensores) of EEG_Samples_Type;

    EEG_Simulation: tipo_Secuencia_Sensores := 
      ((7,7,7,7,7,7,7,7,7,7),(7,7,7,7,7,7,7,7,7,7),  -- 1 muestra cada 100ms.
       (7,7,7,7,7,7,7,7,7,7),(7,7,7,7,7,7,7,7,7,7),
       (7,7,7,7,7,7,7,7,7,7),(8,8,8,8,8,8,8,8,8,8),
       (8,8,8,8,8,8,8,8,8,8),(8,8,8,8,8,8,8,8,8,8),
       (8,8,8,8,8,8,8,8,8,8),(8,8,8,8,8,8,8,8,8,8),   --1s.

       (4,4,4,4,4,4,4,4,4,4),(4,4,4,4,4,4,4,4,4,4),
       (4,4,4,4,4,4,4,4,4,4),(5,5,5,5,5,5,5,5,5,5),
       (5,5,5,5,5,5,5,5,5,5),(6,6,6,6,6,6,6,6,6,6),
       (6,6,6,6,6,6,6,6,6,6),(6,6,6,6,6,6,6,6,6,6),
       (6,6,6,6,6,6,6,6,6,6),(6,6,6,6,6,6,6,6,6,6),   --2s.

       (1,1,1,1,1,1,1,1,1,1),(1,1,1,1,1,1,1,1,1,1),
       (1,1,1,1,1,1,1,1,1,1),(2,2,2,2,2,2,2,2,2,2),
       (2,2,2,2,2,2,2,2,2,2),(2,2,2,2,2,2,2,2,2,2),
       (2,2,2,2,2,2,2,2,2,2),(3,3,3,3,3,3,3,3,3,3),
       (3,3,3,3,3,3,3,3,3,3),(3,3,3,3,3,3,3,3,3,3),   --3s.

       (1,1,1,1,1,1,1,1,1,1),(1,1,1,1,1,1,1,1,1,1),
       (1,1,1,1,1,1,1,1,1,1),(2,2,2,2,2,2,2,2,2,2),
       (2,2,2,2,2,2,2,2,2,2),(2,2,2,2,2,2,2,2,2,2),
       (2,2,2,2,2,2,2,2,2,2),(3,3,3,3,3,3,3,3,3,3),
       (3,3,3,3,3,3,3,3,3,3),(3,3,3,3,3,3,3,3,3,3),   --4s.

       (4,4,4,4,4,4,4,4,4,4),(4,4,4,4,4,4,4,4,4,4),
       (4,4,4,4,4,4,4,4,4,4),(5,5,5,5,5,5,5,5,5,5),
       (5,5,5,5,5,5,5,5,5,5),(7,7,7,7,7,7,7,7,7,7),
       (7,7,7,7,7,7,7,7,7,7),(7,7,7,7,7,7,7,7,7,7),
       (7,7,7,7,7,7,7,7,7,7),(7,7,7,7,7,7,7,7,7,7),   --5s.

       (7,7,7,7,7,7,7,7,7,7),(7,7,7,7,7,7,7,7,7,7),
       (7,7,7,7,7,7,7,7,7,7),(7,7,7,7,7,7,7,7,7,7),
       (7,7,7,7,7,7,7,7,7,7),(8,8,8,8,8,8,8,8,8,8),
       (8,8,8,8,8,8,8,8,8,8),(8,8,8,8,8,8,8,8,8,8),
       (8,8,8,8,8,8,8,8,8,8),(8,8,8,8,8,8,8,8,8,8),   --6s.

       (4,4,4,4,4,4,4,4,4,4),(4,4,4,4,4,4,4,4,4,4),
       (4,4,4,4,4,4,4,4,4,4),(5,5,5,5,5,5,5,5,5,5),
       (5,5,5,5,5,5,5,5,5,5),(6,6,6,6,6,6,6,6,6,6),
       (6,6,6,6,6,6,6,6,6,6),(6,6,6,6,6,6,6,6,6,6),
       (6,6,6,6,6,6,6,6,6,6),(6,6,6,6,6,6,6,6,6,6),   --7s.

       (1,1,1,1,1,1,1,1,1,1),(1,1,1,1,1,1,1,1,1,1),
       (1,1,1,1,1,1,1,1,1,1),(2,2,2,2,2,2,2,2,2,2),
       (2,2,2,2,2,2,2,2,2,2),(2,2,2,2,2,2,2,2,2,2),
       (2,2,2,2,2,2,2,2,2,2),(3,3,3,3,3,3,3,3,3,3),
       (3,3,3,3,3,3,3,3,3,3),(3,3,3,3,3,3,3,3,3,3),   --8s.

       (1,1,1,1,1,1,1,1,1,1),(1,1,1,1,1,1,1,1,1,1),
       (1,1,1,1,1,1,1,1,1,1),(2,2,2,2,2,2,2,2,2,2),
       (2,2,2,2,2,2,2,2,2,2),(2,2,2,2,2,2,2,2,2,2),
       (2,2,2,2,2,2,2,2,2,2),(3,3,3,3,3,3,3,3,3,3),
       (3,3,3,3,3,3,3,3,3,3),(3,3,3,3,3,3,3,3,3,3),   --9s.

       (4,4,4,4,4,4,4,4,4,4),(4,4,4,4,4,4,4,4,4,4),
       (4,4,4,4,4,4,4,4,4,4),(5,5,5,5,5,5,5,5,5,5),
       (5,5,5,5,5,5,5,5,5,5),(7,7,7,7,7,7,7,7,7,7),
       (7,7,7,7,7,7,7,7,7,7),(7,7,7,7,7,7,7,7,7,7),
       (7,7,7,7,7,7,7,7,7,7),(7,7,7,7,7,7,7,7,7,7) );   --10s.






    ---------------------------------------------------------------------
    type Values_Pulse_Rate is new float range 20.0..300.0;
    procedure Display_Pulse_Rate (P: Values_Pulse_Rate);


    ---------------------------------------------------------------------
    procedure Display_Cronometro (Origen: Ada.Real_Time.Time; Hora: Ada.Real_Time.Time);


    ---------------------------------------------------------------------
    Type Volume is new integer range 1..5; 
    procedure Beep (v: Volume);


    ---------------------------------------------------------------------
    type Light_States is (On, Off);
    procedure Light (E: Light_States);


    ---------------------------------------------------------------------
    procedure Activate_Automatic_Driving;


    ---------------------------------------------------------------------
    procedure Activate_Brake;


end devices;



