      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. "Called".
      *AUTHOR. TARZANZITO.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
      *     DECIMAL-POINT IS COMMA.
       DATA DIVISION.

       WORKING-STORAGE SECTION.
      *
       LINKAGE SECTION.
       01 WS-PARAMETERS-IN.
          05 PART-ID              PIC X(10).
          05 SALES                PIC 9(5).
       01 WS-PARAMETERS-OUT.
          05 RETURN-VALUE         PIC X(10).
      *
       PROCEDURE DIVISION USING WS-PARAMETERS-IN, WS-PARAMETERS-OUT.
       A1000-MAIN.
           DISPLAY "CALLED STARTED.".

           DISPLAY "RECEIVED: PART-ID     :" PART-ID.
           DISPLAY "RECEIVED: SALES       :" SALES.
           DISPLAY "RECEIVED: RETURN VALUE:" RETURN-VALUE.

           MOVE "MY RESULT" TO RETURN-VALUE.

           DISPLAY "SEND   : RETURN VALUE:" RETURN-VALUE.

       A1000-MAIN-EXIT.
           DISPLAY "CALLED FINISHED.".
           GOBACK.
