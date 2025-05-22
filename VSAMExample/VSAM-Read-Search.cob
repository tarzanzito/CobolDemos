       IDENTIFICATION DIVISION.
       PROGRAM-ID. VSAM-Read-Search.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *optional - IF FILE NOT EXISTS THEN CREATE
       SELECT optional VSAM-FILE ASSIGN TO "my-vsam-file.dat" 
      *SELECT VSAM-FILE ASSIGN TO "YOUR.VSAM.FILE.dat" 
            ORGANIZATION IS INDEXED
            ACCESS MODE IS RANDOM
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
       01  WS-KEY                PIC X(10).
           88 WS-IS-QUIT         VALUE "Q", "q".
       PROCEDURE DIVISION. 
       MAIN-PROCEDURE. 
           OPEN Input VSAM-FILE 
           DISPLAY "# FILE STATUS=" WS-FILE-STATUS.
           IF WS-FILE-STATUS = "00"
              PERFORM START-RECORDS
           END-IF 			   

           CLOSE VSAM-FILE. 

           STOP RUN. 

       START-RECORDS. 
           display "# START...".
           Perform FIND-RECORD-EQUAL until WS-IS-QUIT.
           display "# FINISHED...:".
	
       FIND-RECORD-EQUAL. 
           display "# Enter Key or (q) to quit:".
           accept WS-KEY from console.
           if WS-IS-QUIT
              exit.
           
           MOVE SPACES TO VSAM-RECORD.
           MOVE WS-KEY TO KEY-FIELD
           
           READ VSAM-FILE into VSAM-RECORD
               KEY IS KEY-FIELD
               INVALID KEY
                  DISPLAY "# INVALID KEY"
               NOT INVALID KEY
                  DISPLAY "Record: KEY=" KEY-FIELD "VALUE=" DATA-FIELD
            END-READ.
            display "# STATUS CODE=" WS-FILE-STATUS.

