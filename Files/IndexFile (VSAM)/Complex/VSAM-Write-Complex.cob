      ******************************************************************
      *DESC    : Insert records (key, value) to indexed file (vsam)    *
      *AUTHOR  : Paulo                                                 *
      *DATE    : 2025-05-10                                            *
      *VERSION : 1.1.0                                                 *
      *NOTES   :                                                       *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. VSAM-Write.
      *
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *OPTIONAL - IF FILE NOT EXISTS THEN CREATE
       SELECT OPTIONAL VSAM-FILE ASSIGN TO "my-vsam-file-complex.dat" 
      *SELECT VSAM-FILE ASSIGN TO "YOUR.VSAM.FILE.dat" 
      *assign to dynamic ws-in-file
      *assign to external envvar.
            ORGANIZATION IS INDEXED 
            ACCESS MODE IS DYNAMIC 
            RECORD KEY IS KEY-NUM1 
           alternate record key is KEY-NAME1
      *     with duplicates.
            FILE STATUS IS WS-FILE-STATUS. 

      *    record key is keyfield of indexing-record
      *    alternate record key is splitkey of indexing-record
      *    with duplicates
      *
       DATA DIVISION. 
       FILE SECTION. 
       FD VSAM-FILE
       record is varying in size
      *RECORD IS VARYING
       from 41 to 111 characters depending on ws-record-count.

      * record contains x characters.
       01  VSAM-RECORD1. 
           05 KEY-NUM1      PIC 9(10).
           05 KEY-NAME1     PIC X(20).
           05 DATA-TYPE1    PIC 9.
           05 DATA-Content1 PIC X(10). 
       01  VSAM-RECORD2. 
           05 KEY-NUM2      PIC 9(10).
           05 KEY-NAME2     PIC X(20).
           05 DATA-TYPE2    PIC 9.
           05 DATA-Content2 PIC X(80). 
      *
       WORKING-STORAGE SECTION. 
       01 ws-record-count       pic 99 comp-x.
       01 WS-FILE-STATUS        PIC X(2). 
       01 WS-EOF                PIC X VALUE "N". 
       01 ws-Type               pic 9 value 0.
          88 ws-is-quit         value 9.    
       01 WS-KEY-NUM           PIC 9(10).
       01 WS-KEY-NAME          PIC X(20).  
       01 WS-Content10         PIC X(10).             
       01 WS-Content80         PIC X(80).             
      *
       PROCEDURE DIVISION. 
       MAIN-PROCEDURE. 
      *    OPEN I-O VSAM-FILE 
           OPEN OUTPUT VSAM-FILE 
		   DISPLAY "FILE STATUS=" WS-FILE-STATUS.
		   
		   IF WS-FILE-STATUS = "05"
				DISPLAY "FILE CREATED. RUN AGAIN."
		   END-IF.
		   
           IF WS-FILE-STATUS = "00"
		       PERFORM WRITE-RECORDS
           END-IF 			   

		   CLOSE VSAM-FILE. 

           STOP RUN. 

       WRITE-RECORDS. 
	       DISPLAY "START INSERT...:".
            DISPLAY "Type '9' to quit):".
            DISPLAY " ".

		PERFORM UNTIL ws-is-quit
                 DISPLAY "Enter type (1,2)"
                 ACCEPT ws-Type from console

                  if ws-type = 9
                    exit paragraph
                  end-if

                  if ws-type = 1
                    Perform XPTO1
                  end-if

                  if ws-type = 2
                  perform XPTO2
                  end-if

           END-PERFORM.

	     DISPLAY "FINISHED...:".
      *
       XPTO1.
           DISPLAY "Enter KEY-NUM:"
           ACCEPT WS-KEY-NUM from console.  

           DISPLAY "Enter KEY-NAME:"
           ACCEPT WS-KEY-NAME from console.  

           DISPLAY "Enter CONTENT(10):"
           ACCEPT WS-Content10 from console.  

           MOVE WS-KEY-NUM TO KEY-NUM1.
           MOVE WS-KEY-NAME TO KEY-NAME1.
           MOVE 1 TO DATA-TYPE1.
           MOVE WS-Content10 TO DATA-Content1. 

      * if not correct size value return status-code=44
           MOVE 41 TO ws-record-count .

            WRITE VSAM-RECORD1.
            DISPLAY "Status:" WS-FILE-STATUS,
            DISPLAY " ".
      *
       XPTO2.
           DISPLAY "Enter KEY-NUM:"
           ACCEPT WS-KEY-NUM from console.  

           DISPLAY "Enter KEY-NAME:"
           ACCEPT WS-KEY-NAME from console.  

           DISPLAY "Enter CONTENT(80):"
           ACCEPT WS-Content80 from console.             

           MOVE WS-KEY-NUM TO KEY-NUM2.
           MOVE WS-KEY-NAME TO KEY-NAME2.
           MOVE 2 TO DATA-TYPE2.
           MOVE WS-Content80 TO DATA-Content2. 

           MOVE 111 TO ws-record-count .

            WRITE VSAM-RECORD2.
            DISPLAY "Status:" WS-FILE-STATUS.
            DISPLAY " ".
      *
