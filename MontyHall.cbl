      ******************************************************************
      * Author: Maxamilian Demian
      * Purpose: Example Monty Hall problem simulation.
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MONTY-HALL.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      * The number of times to run for each choice (keep and change will
      * run NUMBER-OF-RUNS times EACH)
       01 NUMBER-OF-RUNS PIC 9(7) VALUE 1000000.

       01 KEEP-WINS PIC 9(7) VALUE 0.
       01 KEEP-LOSSES PIC 9(7) VALUE 0.
       01 CHANGE-WINS PIC 9(7) VALUE 0.
       01 CHANGE-LOSSES PIC 9(7) VALUE 0.
       01 KEEP-PERCENT PIC 99V99.
       01 CHANGE-PERCENT PIC 99V99.

       01 I PIC 9(7).
       01 RANDOM-NUMBER PIC 9V9.
       01 NUMBER-OF-DOORS PIC 9 VALUE 3.
       01 WINNING-DOOR PIC 9.
       01 PLAYER-DOOR PIC 9.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
      *    loop NUMBER-OF-RUNS without changing our door selection
           PERFORM VARYING I FROM 0 BY 1 UNTIL I >= NUMBER-OF-RUNS
      *        pick a winning door between 1 and 3
               COMPUTE RANDOM-NUMBER = FUNCTION RANDOM
               MULTIPLY NUMBER-OF-DOORS BY RANDOM-NUMBER
               MOVE RANDOM-NUMBER TO WINNING-DOOR
               ADD 1 TO WINNING-DOOR

      *        player selects a random door between 1 and 3
               COMPUTE RANDOM-NUMBER = FUNCTION RANDOM
               MULTIPLY NUMBER-OF-DOORS BY RANDOM-NUMBER
               MOVE RANDOM-NUMBER TO PLAYER-DOOR
               ADD 1 TO PLAYER-DOOR

               IF PLAYER-DOOR = WINNING-DOOR
      *            player chose the winning door
                   ADD 1 TO KEEP-WINS
               ELSE
      *            player chose a losing door
                   ADD 1 TO KEEP-LOSSES
               END-IF
           END-PERFORM


      *    loop NUMBER-OF-RUNS while changing our door selection
           PERFORM VARYING I FROM 0 BY 1 UNTIL I >= NUMBER-OF-RUNS
      *        pick a winning door between 1 and 3
               COMPUTE RANDOM-NUMBER = FUNCTION RANDOM
               MULTIPLY NUMBER-OF-DOORS BY RANDOM-NUMBER
               MOVE RANDOM-NUMBER TO WINNING-DOOR
               ADD 1 TO WINNING-DOOR

      *        player selects a random door between 1 and 3
               COMPUTE RANDOM-NUMBER = FUNCTION RANDOM
               MULTIPLY NUMBER-OF-DOORS BY RANDOM-NUMBER
               MOVE RANDOM-NUMBER TO PLAYER-DOOR
               ADD 1 TO PLAYER-DOOR

               IF PLAYER-DOOR = WINNING-DOOR
      *            player chose the winning door already, count it as a
      *            loss as the player will be changing
                   ADD 1 TO CHANGE-LOSSES
               ELSE
      *            if the player HAS NOT chosen the winning door already
      *            and they change, they will win
      *            example:
      *            - player chooses door 1
      *            - winning door is door 3
      *            - host opens door 2 showing a goat
      *            - player switches to door 3 and wins
      *            
      *            every variation of this will win since we have
      *            already eliminated the aspect of the player having
      *            already picked the winning door
                   ADD 1 TO CHANGE-WINS
               END-IF
           END-PERFORM

           COMPUTE KEEP-PERCENT =
               (KEEP-WINS / NUMBER-OF-RUNS) * 100
           COMPUTE CHANGE-PERCENT =
               (CHANGE-WINS / NUMBER-OF-RUNS) * 100

           DISPLAY "Keep Wins/Losses: " KEEP-WINS "/" KEEP-LOSSES
               " (" KEEP-PERCENT "% wins)"
           DISPLAY "Change Wins/Losses: " CHANGE-WINS "/" CHANGE-LOSSES
               " (" CHANGE-PERCENT "% wins)"

           STOP RUN.
       END PROGRAM MONTY-HALL.
