       identification division.
       program-id. CallIntrinsic.

       environment division.
       configuration section.
       data division.
       working-storage section.
       77 ws-x1 pic X(25) value spaces.
       77 ws-x2 pic X(25) value spaces.

       77 Ws-RND  PIC 99.999999999 VALUE ZEROES.
       77 WW-SUB1 PIC 99 VALUE ZEROES.

       procedure division.
       main.
      ******************************************************************
      *    command line: cobc --list-intrinsics
      ******************************************************************

      *    LOWER-CASE function
           move "ABCDEF" TO ws-x1
           MOVE FUNCTION LOWER-CASE(ws-x1) TO ws-x2.
           DISPLAY ">>" ws-x1 ":" ws-x2

      *    RANDOM function
           COMPUTE WS-RND = FUNCTION RANDOM.
           display "RANDOM:" WS-RND

           PERFORM VARYING WW-SUB1 FROM 1 BY 1 UNTIL WW-SUB1 > 9
              COMPUTE WS-RND = FUNCTION RANDOM
              DISPLAY ":" WS-RND
           END-PERFORM

           STOP RUN.
