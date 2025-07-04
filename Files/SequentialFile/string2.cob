       IDENTIFICATION DIVISION.
       PROGRAM-ID. String_EXAMPLE.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-FIRST                PIC X(5).
       01 WS-SECOND               PIC X(10).
       01 WS-NAME                 PIC X(15).
       01 WS-VAR1                 PIC X(10).
       01 WS-VAR2                 PIC X(10).
       01 WS-NAME2                 PIC X(30).
       PROCEDURE DIVISION.
           DISPLAY 'STRING STATEMENT EXAMPLES....'.
           DISPLAY '-------------------------------------------------'.
           MOVE "RUPA" TO WS-FIRST.
           MOVE "KUMARI" TO WS-SECOND.

           DISPLAY 'ORIGINAL:['  WS-FIRST '][' WS-SECOND ']'.
           DISPLAY 'DELIMITED BY SIZE: '
      
      * join all string into new string with total size of any 
           STRING WS-FIRST DELIMITED BY SIZE
            '/ ' DELIMITED BY SIZE
            WS-SECOND DELIMITED BY SIZE
            INTO WS-NAME 
            ON OVERFLOW DISPLAY "OVERFLOW...".
            DISPLAY "[" WS-NAME "]".

            DISPLAY '-------------------------------------------------'.
            MOVE "KESHAV AAA" TO WS-VAR1.
            MOVE "KUMAR BBB" TO WS-VAR2.

            DISPLAY 'ORIGINAL:[' WS-VAR1 '][' WS-VAR2 ']'.
            DISPLAY 'DELIMITED BY SPACE: '.
            
       * join all string into new string (any until first space)
            STRING WS-VAR1 DELIMITED BY SPACE
             '/ ' DELIMITED BY SPACE
              WS-VAR2 DELIMITED BY SPACE
              INTO WS-NAME2 ON 
              OVERFLOW DISPLAY "OVERFLOW...".

            DISPLAY "[" WS-NAME2 "]".    
            STOP RUN.
