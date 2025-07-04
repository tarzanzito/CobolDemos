      *http://www.cadcobol.com.br/cobol_balance_line_3_arquivos_programa.htm
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SEQ_FILE_WRITE.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT OUTFL ASSIGN TO "OUTFLDD.DAT"
      *ORGANIZATION IS SEQUENTIAL
      *ORGANIZATION IS LINE SEQUENTIAL
       ORGANIZATION IS BINARY SEQUENTIAL
       ACCESS MODE IS SEQUENTIAL
       FILE STATUS FS-OUTFL.

       DATA DIVISION.
       FILE SECTION.
       FD OUTFL
      *DATA RECORD IS OUTFL-REC   obsolete
      *RECORD CONTAINS 94 CHARACTERS. obsolete
       RECORDING MODE F.
      * RECORDING MODE IS V (variable)
      * RECORDING MODE IS U (fixed or variable)
      * RECORDING MODE F.   (fixed)
      * RECORDING MODE S.   (spanned))

      *DATA RECORD IS XPTO
      *RECORDING MODE IS V
      *RECORD IS VARYING FROM 4 TO 100 CHARACTERS.
      *01  COMMUTER-RECORD-A           PIC X(4).
      *01  COMMUTER-RECORD-B           PIC X(75).
      *
      *
      *PELOS VISTOS OUTPL-REC NAO PODE TER FILLERs E VALUEs
      *SE NAO FOR FEITO MOVEs ENTAO GERA SEMPRE NULLs
       01 OUTFL-REC.
          05 FA             PIC X(10).

          05 F0             PIC X.
          05 FS-COMP        PIC S9999 COMP.
      *    EQUAL BINARY TYPE
      *    S9 to S9(4)        2 BYTES
      *    S9(5) to S9(9)     4 BYTES
      *    S9(9) to S9(18)    8 BYTES

           05 F1             PIC X.
           05 FS-COMP1       COMP-1.
      *   9(16)   - 1 word      4 BYTES

           05 F2             PIC X.
           05 FS-COMP2       COMP-2.
      *    9(32)   - 2 word      8 BYTES

           05 F3             PIC X.
           05 FS-COMP3       PIC 9(5)V99 COMP-3.
      *    packed decimal
      *    BCD (Binary Coded Decimal)

           05 F4             PIC X.
           05 FS-COMP4       PIC 9(5)V99 COMP-4.

           05 F5             PIC X.
           05 FS-COMP5       PIC 9(5)V99 COMP-5.

           05 F6             PIC X VALUE "#".
           05 FS-COMP6       PIC 9(5)V99 COMP-6.

           05 F7             PIC X VALUE "#".
           05 FS-COMPX       PIC 9(5)V99 COMP-X.

           05 F99            PIC X.
      *
       WORKING-STORAGE SECTION.
       01 FS-OUTFL PIC X(02) VALUE SPACES.
          88 FS-OUTFL-OK VALUE '00'.
          88 FS-OUTFL-EOF VALUE '10'.
      *
       01 WS-OUTFL-REC.
          05 WS-FA             PIC X(10).

          05 WS-F0             PIC X.
          05 WS-FS-COMP        PIC S9999 COMP.
      *    EQUAL BINARY TYPE
      *    S9 to S9(4)        2 BYTES
      *    S9(5) to S9(9)     4 BYTES
      *    S9(9) to S9(18)    8 BYTES

          05 WS-F1             PIC X.
          05 WS-FS-COMP1       COMP-1.
      *   9(16)   - 1 word      4 BYTES

          05 WS-F2             PIC X.
          05 WS-FS-COMP2       COMP-2.
      *    9(32)   - 2 word      8 BYTES

          05 WS-F3             PIC X.
          05 WS-FS-COMP3       PIC 9(5)V99 COMP-3.
      *    packed decimal
      *    BCD (Binary Coded Decimal)

          05 WS-F4             PIC X.
          05 WS-FS-COMP4       PIC 9(5)V99 COMP-4.

          05 WS-F5             PIC X.
          05 WS-FS-COMP5       PIC 9(5)V99 COMP-5.

          05 WS-F6             PIC X VALUE "#".
          05 WS-FS-COMP6       PIC 9(5)V99 COMP-6.

          05 WS-F7             PIC X VALUE "#".
          05 WS-FS-COMPX       PIC 9(5)V99 COMP-X.

          05 WS-F99            PIC X.

       PROCEDURE DIVISION.
       MAIN-PARA.

           PERFORM OPEN-PARA THRU OPEN-EXIT-PARA.
           PERFORM PROCESS-PARA THRU PROCESS-EXIT-PARA.
           PERFORM CLOSE-PARA THRU CLOSE-EXIT-PARA.

       MAIN-PARA-EXIT.
      *    EXIT PROGRAM.
           STOP RUN.

       OPEN-PARA.
           DISPLAY "OPEN-PARA:" FS-OUTFL
      *    INITIALIZE FITE-COUNT.
      *    INITIALISE WS-OUTFL-REC.

           MOVE ZERO  TO WS-FS-COMP.
           MOVE ZERO  TO WS-FS-COMP1.
           MOVE ZERO  TO WS-FS-COMP2.
           MOVE ZERO  TO WS-FS-COMP3.
           MOVE ZERO  TO WS-FS-COMP4.
           MOVE ZERO  TO WS-FS-COMP5.
           MOVE ZERO  TO WS-FS-COMP6.
           MOVE ZERO  TO WS-FS-COMPX.

           OPEN OUTPUT OUTFL
           IF FS-OUTFL-OK
               CONTINUE
           ELSE
               DISPLAY "FILE OPEN FAILED: " FS-OUTFL
               GO TO MAIN-PARA-EXIT
           END-IF.

       OPEN-EXIT-PARA.
           EXIT.

       PROCESS-PARA.
           DISPLAY "PROCESS-PARA:" FS-OUTFL

           PERFORM WRITE-PARA
              THRU WRITE-PARA-EXIT 10 TIMES.
           EXIT.

       PROCESS-EXIT-PARA.
           EXIT.

       WRITE-PARA.
           DISPLAY "WRITE-PARA"

           ADD 1    TO WS-FS-COMP.
           ADD 2    TO WS-FS-COMP1.
           ADD 3    TO WS-FS-COMP2.
           ADD 4.1  TO WS-FS-COMP3.
           ADD 5    TO WS-FS-COMP4.
           ADD 6    TO WS-FS-COMP5.
           ADD 7    TO WS-FS-COMP6.
           ADD 8    TO WS-FS-COMPX.

           MOVE "PAULO-GONC" TO WS-FA
           MOVE  "#" TO WS-F0.
           MOVE  "#" TO WS-F1.
           MOVE  "#" TO WS-F2.
           MOVE  "#" TO WS-F3.
           MOVE  "#" TO WS-F4.
           MOVE  "#" TO WS-F5.
           MOVE  "#" TO WS-F6.
           MOVE  "#" TO WS-F7.
           MOVE  "$" TO WS-F99.

           MOVE WS-OUTFL-REC TO OUTFL-REC.
           WRITE OUTFL-REC.
           DISPLAY "WRITE-PARA2:" FS-OUTFL.
       WRITE-PARA-EXIT.
            EXIT.

       CLOSE-PARA.
           DISPLAY "CLOSE-PARA"
            CLOSE OUTFL.
             DISPLAY "CLOSE-PARA2:" FS-OUTFL.

       CLOSE-EXIT-PARA.
           EXIT.
