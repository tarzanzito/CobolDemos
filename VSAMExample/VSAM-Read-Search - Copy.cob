       IDENTIFICATION DIVISION.
       PROGRAM-ID. VSAM-Read-Search.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *optional - IF FILE NOT EXISTS THEN CREATE
       SELECT optional VSAM-FILE ASSIGN TO "my-vsam-file.dat" 
      *SELECT VSAM-FILE ASSIGN TO "YOUR.VSAM.FILE.dat" 
            ORGANIZATION IS INDEXED
      *      ACCESS MODE IS RANDOM
            ACCESS MODE IS SEQUENTIAL
            RECORD KEY IS KEY-FIELD 
            FILE STATUS IS WS-FILE-STATUS. 

      *    record key is keyfield of indexing-record
      *    alternate record key is splitkey of indexing-record
      *    with duplicates

       DATA DIVISION. 
       FILE SECTION. 
       FD  VSAM-FILE. 
       01  VSAM-RECORD. 
           05 KEY-FIELD      PIC X(10).
           05 DATA-FIELD     PIC X(70). 

       WORKING-STORAGE SECTION. 
       01  WS-FILE-STATUS        PIC X(2). 
       01  WS-EOF                PIC X VALUE "N". 
       01  WS-DATA-FIELDS.
           05 WS-KEY-FIELD      PIC X(10).
              88 WS-IS-QUIT      VALUE "Q", "q".
              88 WS-IS-FIND      VALUE "F", "f".
              88 WS-IS-PREV      VALUE "P", "p".
              88 WS-IS-NEXT      VALUE "N", "n".
           05 WS-DATA-FIELD     PIC X(70).
       PROCEDURE DIVISION. 
       MAIN-PROCEDURE. 
           OPEN Input VSAM-FILE 

           DISPLAY "FILE STATUS=" WS-FILE-STATUS.
		   
           IF WS-FILE-STATUS = "00"
              PERFORM START-RECORDS
           END-IF 			   

           CLOSE VSAM-FILE. 

           STOP RUN. 

       START-RECORDS. 
           display "START...:".

           Perform ASK-RECORDS until WS-IS-QUIT.

           display "FINISHED...:".
		  
       ASK-RECORDS. 
           display "Action (f)-find, (n)-next, (p)-prev, (q)-quit".
           accept WS-KEY-FIELD from console
           if WS-IS-QUIT
              exit.
           
           if WS-IS-FIND
              PERFORM FIND-RECORD.

           if WS-IS-NEXT    
              PERFORM NEXT-RECORD. 

           if WS-IS-PREV    
              PERFORM PREV-RECORD. 

       FIND-RECORD. 
           display "Key:".
           accept WS-KEY-FIELD from console.
           MOVE WS-KEY-FIELD TO KEY-FIELD

      *    START VSAM-FILE KEY IS GREATER THAN OR EQUAL TO KEY-FIELD
           READ VSAM-FILE into VSAM-RECORD
      *    READ VSAM-FILE into WS-DATA-FIELDS
      *    find equal	  
               KEY IS KEY-FIELD
      *find GREATER THAN OR EQUAL				
      *         KEY IS NOT LESS THAN KEY-FIELD
               INVALID KEY
                  DISPLAY "INVALID KEY"
               NOT INVALID KEY
                  DISPLAY "Record: KEY=" KEY-FIELD "VALUE=" DATA-FIELD
            END-READ.
            display "STATUS CODE=" WS-FILE-STATUS.

       NEXT-RECORD. 
           display "Next".

       PREV-RECORD. 
           display "Prev".
