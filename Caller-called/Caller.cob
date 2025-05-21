      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. "Caller".
      *AUTHOR. TARZANZITO.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
      *     DECIMAL-POINT IS COMMA.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-PARAMETERS-IN.
          05 WS-STUDENT-ID            PIC X(10) VALUE "PAULOG".
          05 WS-SALES                 PIC 9(5) VALUE 1001.
       01 WS-PARAMETERS-OUT.
          05 WS-RETURN-VALUE          PIC X(10).
      *
      * https://www.tutorialspoint.com/cobol/cobol_subroutines.htm
      * https://www.youtube.com/watch?v=7ukpBeMJpL4
      * http://www.simotime.com/cblpar01.htm
       PROCEDURE DIVISION.
       A1000-MAIN.
           DISPLAY "CALLER STARTED.".

           DISPLAY "BEFORE: STUDANT ID  :" WS-STUDENT-ID.
           DISPLAY "BEFORE: SALES       :" WS-SALES.
           DISPLAY "BEFORE: RETURN VALUE:" WS-RETURN-VALUE.
           DISPLAY LOW-VALUES.

      *BY CONTENT - new values will NOT reflect in calling program
      *BY REFERENCE default - new values are reflect in calling program
      *BY VALUE -
           CALL "Called" USING BY CONTENT WS-PARAMETERS-IN,
                               BY REFERENCE WS-PARAMETERS-OUT.
      *
      *defauly (by reference)
      *    CALL "Called" USING WS-PARAMETERS-IN, WS-PARAMETERS-OUT.

           DISPLAY LOW-VALUES.
           DISPLAY "AFTER : STUDANT ID :" WS-STUDENT-ID.
           DISPLAY "AFTER : SALES      :" WS-SALES.
           DISPLAY "AFTER : RETURN VALUE:" WS-RETURN-VALUE.

       A1000-MAIN-EXIT.
           DISPLAY "CALLER FINISHED.".
           STOP RUN.
