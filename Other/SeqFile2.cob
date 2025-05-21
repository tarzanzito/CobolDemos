       IDENTIFICATION DIVISION.
        PROGRAM-ID. SEQFILE.
        ENVIRONMENT DIVISION.
        INPUT-OUTPUT SECTION.
        FILE-CONTROL.
             SELECT INFL ASSIGN TO INFLDD
             ORGANIZATION IS SEQUENTIAL
             FILE STATUS FS-INFL.
             SELECT OUTFL ASSIGN TO OUTFLDD
             ORGANIZATION IS SEQUENTIAL
             FILE STATUS FS-OUTFL.
       DATA DIVISION.
        FILE SECTION.
        FD INFL.
        01 INFL-REC.
           05 STORE-ID PIC 9(05).
           05 FILLER PIC X(01).
           05 ITEM-ID PIC X(10).
           05 FILLER PIC X(64).
        FD OUTFL.
        01 OUTFL-REC.
           05 O-STORE-ID PIC 9(05).
           05 DELIMIT PIC X(01).
           05 O-ITEM-ID PIC X(10).
           05 FILLER PIC X(64).
        WORKING-STORAGE SECTION.
        01 FS-INFL PIC X(02) VALUE SPACES.
           88 FS-INFL-OK VALUE '00'.
           88 FS-INFL-EOF VALUE '10'.
        01 FS-OUTFL PIC X(02) VALUE SPACES.
           88 FS-OUTFL-OK VALUE '00'.
           88 FS-OUTFL-EOF VALUE '10'.
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
             INITIALIZE FS-INFL FS-OUTFL READ-COUNT WRITE-COUNT.
             OPEN INPUT INFL
             IF FS-INFL-OK
                CONTINUE
             ELSE
                DISPLAY "FILE OPEN FAILED: " FS-INFL
                GO TO EXIT-PARA
             END-IF.
             OPEN OUTPUT OUTFL
             IF FS-OUTFL-OK
                CONTINUE
             ELSE
                DISPLAY "OUTPUT FILE OPEN FAILED: " FS-OUTFL
                GO TO EXIT-PARA
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
            IF STORE-ID > 12346
                MOVE "|" TO DELIMIT
                MOVE STORE-ID TO O-STORE-ID
                MOVE ITEM-ID TO O-ITEM-ID
                WRITE OUTFL-REC
                DISPLAY 'HI'
            END-IF.
       WRITE-EXIT-PARA.
            EXIT.
       CLOSE-PARA.
            CLOSE INFL.
       CLOSE-EXIT-PARA.
           EXIT.
       EXIT-PARA.
           EXIT PROGRAM.
           