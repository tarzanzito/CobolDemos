       IDENTIFICATION DIVISION.
       PROGRAM-ID. SEQFILE.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *INPYUT FILE
      *    SELECT INFL ASSIGN TO INFLDD
           SELECT INFL ASSIGN TO DISK
           ORGANIZATION IS SEQUENTIAL
           FILE STATUS FS-INFL.
       DATA DIVISION.
       FILE SECTION.
       FD INFL LABEL RECORD STANDARD
         VALUE OF FILE-ID IS "ARQCLI.DAT".
       01 INFL-REC.
           05 STORE-ID PIC 9(05).
           05 FILLER PIC X(01).
           05 ITEM-ID PIC X(10).
           05 FILLER PIC X(64).
       WORKING-STORAGE SECTION.
       01 FS-INFL PIC X(02) VALUE SPACES.
           88 FS-INFL-OK VALUE '00'.
           88 FS-INFL-EOF VALUE '10'.
       01 COUNTERS.
           05 READ-COUNT PIC 9(2).
           05 WRITE-COUNT PIC 9(2).
       PROCEDURE DIVISION.
       MAIN-PARA.
           PERFORM OPEN-PARA THRU OPEN-EXIT-PARA.
           PERFORM PROCESS-PARA THRU PROCESS-EXIT-PARA.
           PERFORM CLOSE-PARA THRU CLOSE-EXIT-PARA.
           STOP RUN.

       OPEN-PARA.
           INITIALIZE FS-INFL READ-COUNT WRITE-COUNT.
           OPEN INPUT INFL
           IF FS-INFL-OK
               DISPLAY "FILE OPEN: " FS-INFL
              CONTINUE
           ELSE
               DISPLAY "FILE OPEN FAILED: " FS-INFL
           END-IF.
       OPEN-EXIT-PARA.
           EXIT.
       
       PROCESS-PARA.
           PERFORM UNTIL FS-INFL-EOF
               READ INFL
               AT END
                   IF READ-COUNT < 1
                          DISPLAY 'NO RECORDS PRESENT'
                          GO TO EXIT-PARA
                   END-IF
               NOT AT END
                   PERFORM WRITE-PARA THRU WRITE-EXIT-PARA
               END-READ
           END-PERFORM.
       PROCESS-EXIT-PARA.
           EXIT.
       
       WRITE-PARA.
           ADD 1 TO READ-COUNT.
      *     IF STORE-ID > 12346
               DISPLAY 'STORE-ID: ' STORE-ID
               DISPLAY 'ITEM-ID: ' ITEM-ID
      *     END-IF.
            . 
       WRITE-EXIT-PARA.
           EXIT.
       
       CLOSE-PARA.
           CLOSE INFL.
       
       CLOSE-EXIT-PARA.
           EXIT.

       EXIT-PARA.
           EXIT PROGRAM.
