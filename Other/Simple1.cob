       IDENTIFICATION DIVISION.
       PROGRAM-ID. "SIMPLE1".
       AUTHOR. PAULO.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       working-storage section.
           01 WS-NAME PIC X(10).

       PROCEDURE DIVISION.

       1000-START.
           DISPLAY "ENTER YOUR NAME: " WITH NO advancing.
           ACCEPT WS-NAME.
           DISPLAY "WELCOME " WS-NAME.
                
           STOP RUN.
        
      *compile: cobc -x Simple1.cob