      IDENTIFICATION DIVISION. 
       PROGRAM-ID. VSAMExample. 
 
       ENVIRONMENT DIVISION. 
       INPUT-OUTPUT SECTION. 
       FILE-CONTROL. 
           SELECT VSAM-FILE ASSIGN TO YOUR.VSAM.FILE 
               ORGANIZATION IS INDEXED 
               ACCESS MODE IS DYNAMIC 
               RECORD KEY IS KEY-FIELD 
               FILE STATUS IS WS-FILE-STATUS. 
 
       DATA DIVISION. 
       FILE SECTION. 
       FD  VSAM-FILE. 
       01  VSAM-RECORD. 
           05 KEY-FIELD      PIC X(10). 
           05 DATA-FIELD     PIC X(70). 
 
       WORKING-STORAGE SECTION. 
       01  WS-FILE-STATUS        PIC X(2). 
       01  WS-EOF                PIC X VALUE 'N'. 
 
       PROCEDURE DIVISION. 
       MAIN-PROCEDURE. 
           OPEN I-O VSAM-FILE 
           IF WS-FILE-STATUS = '00' 
               PERFORM READ-RECORD 
           END-IF 
           CLOSE VSAM-FILE 
           STOP RUN. 
 
       READ-RECORD. 
           READ VSAM-FILE 
               INTO VSAM-RECORD 
               INVALID KEY 
                   DISPLAY 'Record not found' 
               NOT INVALID KEY 
                   DISPLAY 'Record read: ' KEY-FIELD DATA-FIELD 
           END-READ. 