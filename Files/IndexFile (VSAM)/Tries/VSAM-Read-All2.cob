       IDENTIFICATION DIVISION.
       PROGRAM-ID. VSAM-Read-All2.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
        SELECT VSAM-FILE ASSIGN TO "my-vsam-file.dat" 
            ORGANIZATION IS INDEXED 
            ACCESS MODE IS DYNAMIC 
      *     ACCESS MODE IS RANDOM (error infinity loop)
      *     ACCESS MODE IS SEQUENTIAL 
            RECORD KEY IS KEY-FIELD 
            FILE STATUS IS WS-FILE-STATUS. 

      *    access mode is dynamic
      *    record key is keyfield of indexing-record
      *    alternate record key is splitkey of indexing-record
      *        with duplicates

       DATA DIVISION. 
       FILE SECTION. 
       FD VSAM-FILE. 
       01 VSAM-RECORD. 
          05 KEY-FIELD      PIC X(10). 
          05 DATA-FIELD     PIC X(70). 

       WORKING-STORAGE SECTION. 
       01 WS-FILE-STATUS        PIC X(2). 
       01 WS-EOF                PIC X VALUE "N". 
       01 WS-MSG.
          05 FILLER         PIC X(13) VALUE "Record, Key=[".
          05 WS-KEY-FIELD   PIC X(10).
          05 FILLER         PIC X(9) VALUE "] Value=[".
          05 WS-DATA-FIELD  PIC X(70).
          05 FILLER         PIC X(1) VALUE "]". 

       PROCEDURE DIVISION. 
       MAIN-PROCEDURE. 
           OPEN Input VSAM-FILE 

		   DISPLAY "FILE STATUS=" WS-FILE-STATUS.
           IF WS-FILE-STATUS = '00' 
               PERFORM READ-RECORD UNTIL WS-EOF = "Y" 
           END-IF 
           
           CLOSE VSAM-FILE 
           STOP RUN. 

       READ-RECORD. 
			
           READ VSAM-FILE 
               INTO VSAM-RECORD 
               AT END MOVE "Y" TO WS-EOF
           END-READ.

		   IF WS-EOF = "N"
               MOVE KEY-FIELD TO WS-KEY-FIELD
               MOVE DATA-FIELD TO WS-DATA-FIELD
               DISPLAY WS-MSG
           END-If.
		   
      *   Display "STATUS=" WS-FILE-STATUS.
  

