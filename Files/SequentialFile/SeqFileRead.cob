      *http://www.cadcobol.com.br/cobol_balance_line_3_arquivos_programa.htm
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SEQ_FILE_READ.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT INFL ASSIGN TO "OUTFLDD.DAT"
       ORGANIZATION IS SEQUENTIAL
      *ORGANIZATION IS LINE SEQUENTIAL
      *ORGANIZATION IS BINARY SEQUENTIAL
       ACCESS MODE IS SEQUENTIAL
       FILE STATUS FS-INFL.
      *
       DATA DIVISION.
       FILE SECTION.
       FD INFL
       RECORDING MODE F.
       01 INFL-REC.
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
       01 WS-VAR               PIC +9(13).99.
       01 WS-RECORD-COUNT      PIC 9(10) VALUE ZERO.
       01 FS-INFL              PIC X(02) VALUE SPACES.
          88 FS-INFL-OK        VALUE '00'.
          88 FS-INFL-EOF       VALUE '10'.
      *
       01 WS-INFL-REC.
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

           PERFORM OPEN-PARA
              THRU OPEN-EXIT-PARA.
           PERFORM PROCESS-PARA
              THRU PROCESS-EXIT-PARA.
           PERFORM CLOSE-PARA
              THRU CLOSE-EXIT-PARA.

       MAIN-PARA-EXIT.
      *     EXIT PROGRAM.
           STOP RUN.

       OPEN-PARA.
           DISPLAY "OPEN-PARA:" FS-INFL
           INITIALIZE WS-RECORD-COUNT.
           INITIALISE WS-INFL-REC.

           OPEN INPUT INFL
           IF FS-INFL-OK
               CONTINUE
           ELSE
               DISPLAY "FILE OPEN FAILED:  " FS-INFL
               GO TO MAIN-PARA-EXIT
           END-IF.

       OPEN-EXIT-PARA.
           EXIT.

       PROCESS-PARA.
           DISPLAY "PROCESS-PARA:" FS-INFL

           PERFORM UNTIL FS-INFL-EOF
               READ INFL
               AT END
                   IF WS-RECORD-COUNT < 1
                          DISPLAY 'NO RECORDS PRESENT'
                          GO TO PROCESS-EXIT-PARA
                   END-IF
               NOT AT END
                   PERFORM READ-PARA
                      THRU READ-PARA-EXIT
               END-READ
           END-PERFORM.

           EXIT.

       PROCESS-EXIT-PARA.
           EXIT.

       READ-PARA.

           ADD 1 TO WS-RECORD-COUNT.

           MOVE INFL-REC TO WS-INFL-REC.

           DISPLAY "+++++++++++++++++++"
           DISPLAY "RECORD ID:" WS-RECORD-COUNT.
           DISPLAY "FS-FA:" WS-FA.

           MOVE WS-FS-COMP TO WS-VAR.
           DISPLAY "FS-COMP :" WS-VAR.

           MOVE WS-FS-COMP1 TO WS-VAR.
           DISPLAY "FS-COMP1:" WS-VAR.

           MOVE WS-FS-COMP2 TO WS-VAR.
           DISPLAY "FS-COMP2:" WS-VAR.

           MOVE WS-FS-COMP3 TO WS-VAR.
           DISPLAY "FS-COMP3:" WS-VAR.

           MOVE WS-FS-COMP4 TO WS-VAR.
           DISPLAY "FS-COMP4:" WS-VAR.

           MOVE WS-FS-COMP5 TO WS-VAR.
           DISPLAY "FS-COMP5:" WS-VAR.

           MOVE WS-FS-COMP6 TO WS-VAR.
           DISPLAY "FS-COMP6:" WS-VAR.

           MOVE WS-FS-COMPX TO WS-VAR.
           DISPLAY "FS-COMPX:" WS-VAR.

       READ-PARA-EXIT.
            EXIT.

       CLOSE-PARA.
           CLOSE INFL.
           DISPLAY "CLOSE-PARA:" FS-INFL.

       CLOSE-EXIT-PARA.
           EXIT.
