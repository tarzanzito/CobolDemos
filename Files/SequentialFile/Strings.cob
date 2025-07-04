       IDENTIFICATION DIVISION.
       PROGRAM-ID. EXAMPLE.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-S1 PIC X(10) VALUE 'HI Z  '.
       01 WS-S2 PIC X(10) VALUE 'HOW    '.
       01 WS-S3 PIC X(10) VALUE 'ARE     '.
       01 WS-S4 PIC X(10) VALUE 'YOU?   '.
       01 WS-CONCAT PIC X(43) VALUE SPACES.
       01 FIELD-LEN pic 9999.
       01 WS-FINAL  pic X(100).
       01 WS-TEMP   pic X(100).
       01 WS-TEMPC redefines WS-TEMP occurs 100 times pic x.
      * 
       PROCEDURE DIVISION.
       MAIN-PARAGRAPH.
           move LENGTH OF WS-TEMP to  FIELD-LEN.
           display "LEN:" FIELD-LEN.

      *    move low-values to WS-FINAL.
      *    move low-values to WS-TEMP.

          move ws-s1 to ws-temp.
          perform GET-LAST-SPACE.

      * PERFORM VARYING FIELD-LEN
      *     FROM LENGTH OF WS-S1 BY -1
      *      UNTIL FIELD-LEN = 0
      *      display FIELD-LEN
      *      display WS-S1(FIELD-LEN:1)
      *     OR WS-S1(FIELD-LEN:1) NOT = SPACE
      *END-PERFORM.

        DISPLAY "SIZE:" FIELD-LEN. 
      *  STRING SEARCH-FIELD(1:FIELD-LEN) DELIMITED BY SIZE


      * STRING WS-S1 DELIMITED BY SPACE
      *         ';' DELIMITED BY SIZE
      *         WS-S2 DELIMITED BY SPACE
      *         ';' DELIMITED BY SIZE
      *         WS-S3 DELIMITED BY SPACE
      *         ';' DELIMITED BY SIZE
      *         WS-S4 DELIMITED BY SPACE
      *    INTO WS-CONCAT
      * END-STRING.
      DISPLAY '[' WS-FINAL ']'.
       STOP RUN.
      *
       GET-LAST-SPACE.
           
           PERFORM VARYING FIELD-LEN
           FROM LENGTH OF WS-TEMP BY -1
            UNTIL FIELD-LEN = 0
            OR WS-TEMPC(FIELD-LEN) NOT = SPACE
            
      *      display WS-TEMP(FIELD-LEN:1)
             display WS-TEMPC(FIELD-LEN)
      *     OR WS-S1(FIELD-LEN:1) NOT = SPACE
       END-PERFORM.
