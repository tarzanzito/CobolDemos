       IDENTIFICATION DIVISION.
       PROGRAM-ID. VSAM-Write.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *optional - IF FILE NOT EXISTS THEN CREATE
       SELECT optional VSAM-FILE ASSIGN TO "my-vsam-file.dat" 
      *SELECT VSAM-FILE ASSIGN TO "YOUR.VSAM.FILE.dat" 
            ORGANIZATION IS INDEXED 
            ACCESS MODE IS DYNAMIC 
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
			  88 IS-Q VALUE "Q", "q".
           05 DATA-FIELD     PIC X(70). 

       WORKING-STORAGE SECTION. 
       01  WS-FILE-STATUS        PIC X(2). 
       01  WS-EOF                PIC X VALUE "N". 

       PROCEDURE DIVISION. 
       MAIN-PROCEDURE. 
           OPEN I-O VSAM-FILE 

		   DISPLAY "FILE STATUS=" WS-FILE-STATUS.
		   
		   IF WS-FILE-STATUS = "05"
				DISPLAY "FILE CREATED. RUN AGAIN."
		   END-IF.
		   
           IF WS-FILE-STATUS = "00"
		       PERFORM WRITE-RECORDS
           END-IF 			   
           

		   CLOSE VSAM-FILE 

           STOP RUN. 

       WRITE-RECORDS. 
	    display "START...:".
      *Perform until KEY-FIELD = "q"
			Perform until IS-Q
      * how clear screen ??  DISPLAY ""   with blank SCREEN
                display "Enter key ('q' to quit):"
                accept KEY-FIELD from console
      *          if KEY-FIELD not equal "q"
                if not IS-Q
                    display "Enter value:"
                    accept DATA-FIELD from console
                    WRITE VSAM-RECORD
            end-perform.

		display "FINISHED...:".

