       IDENTIFICATION DIVISION.
       PROGRAM-ID. VSAM-Read.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
        SELECT VSAM-FILE ASSIGN TO "my-vsam-file.dat" 
            ORGANIZATION IS INDEXED 
      *      ACCESS MODE IS DYNAMIC
      *      ACCESS MODE IS RANDOM 	  
            ACCESS MODE IS SEQUENTIAL 
            RECORD KEY IS KEY-FIELD 
            FILE STATUS IS WS-FILE-STATUS. 

      *    access mode is dynamic
      *    record key is keyfield of indexing-record
      *    alternate record key is splitkey of indexing-record
      *        with duplicates


       DATA DIVISION. 
       FILE SECTION. 
       FD  VSAM-FILE. 
       01  VSAM-RECORD. 
           05 KEY-FIELD      PIC X(10). 
           05 DATA-FIELD     PIC X(70). 

       WORKING-STORAGE SECTION. 
       01  WS-FILE-STATUS        PIC X(2). 
       01  WS-EOF                PIC X VALUE "N". 

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
               DISPLAY 'Record read: ' KEY-FIELD ':' DATA-FIELD 
           END-If.
		   
      *   Display "STATUS=" WS-FILE-STATUS.

       
	   READ-RECORD-B. 
			
           READ VSAM-FILE 
               INTO VSAM-RECORD 
               INVALID KEY 
                   DISPLAY "Record not found" 
               NOT INVALID KEY 
                   DISPLAY "Record read: " KEY-FIELD ":" DATA-FIELD
      *        AT END MOVE "Y" TO WS-EOF
           END-READ.
           Display "STATUS=" WS-FILE-STATUS.
	  

