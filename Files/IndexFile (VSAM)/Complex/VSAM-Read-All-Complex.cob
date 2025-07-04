      ******************************************************************
      *DESC    : Read all records from indexed file (vsam)             *
      *AUTHOR  : Paulo                                                 *
      *DATE    : 2025-05-10                                            *
      *VERSION : 1.1.0                                                 *
      *NOTES   :                                                       *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. VSAM-Read-All.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
        SELECT VSAM-FILE ASSIGN TO "my-vsam-file-complex.dat" 
            ORGANIZATION IS INDEXED 
            ACCESS MODE IS DYNAMIC 
      *      ACCESS MODE IS SEQUENTIAL 
            RECORD KEY IS KEY-NUM 
            alternate record key is KEY-NAME
            FILE STATUS IS WS-FILE-STATUS. 

      *    access mode is dynamic
      *    record key is keyfield of indexing-record
      *    alternate record key is splitkey of indexing-record
      *        with duplicates

       DATA DIVISION. 
       FILE SECTION. 
       FD VSAM-FILE 
      *RECORD IS VARYING
       record is varying in size
       from 41 to 111 characters depending on ws-record-count.
      * record contains x characters.
       01 VSAM-RECORD. 
          05 KEY-NUM      PIC 9(10).
          05 KEY-NAME     PIC X(20).
          05 DATA-TYPE    PIC 9.
          05 DATA-Content PIC X(80). 
      *01  VSAM-RECORD2. 
      *     05 KEY-NUM2      PIC 9(10).
      *     05 KEY-NAME2     PIC X(20).
      *     05 DATA-TYPE2    PIC 9.
      *     05 DATA-Content2 PIC X(80). 

       WORKING-STORAGE SECTION.
       01 ws-record-count       pic 99 comp-x.
       01 WS-FILE-STATUS        PIC X(2). 
       01 WS-EOF                PIC X VALUE "N". 
      * 
       01 ws-Type               pic 9 value 0.
          88 ws-is-quit         value 9.
      *        
       01 WS-KEY-NUM           PIC 9(10).
       01 WS-KEY-NAME          PIC X(20).  
       01 WS-Content10         PIC X(10).             
       01 WS-Content80         PIC X(80).   
       *
       01 WS-MSG.
          05 FILLER         PIC X(13) VALUE "Record, Key=[".
          05 WS-KEY-FIELD   PIC X(10).
          05 FILLER         PIC X(9) VALUE "] Value=[".
          05 WS-DATA-FIELD  PIC X(70).
          05 FILLER         PIC X(1) VALUE "]". 
      *
       PROCEDURE DIVISION. 
       MAIN-PROCEDURE. 
           OPEN Input VSAM-FILE 
		   DISPLAY "FILE STATUS=" WS-FILE-STATUS.

           IF WS-FILE-STATUS = '00' 
               PERFORM READ-RECORD UNTIL WS-EOF = "Y" 
           END-IF 
           
           CLOSE VSAM-FILE 
           STOP RUN. 
      *
       READ-RECORD. 
			
           READ VSAM-FILE NEXT
               INTO VSAM-RECORD 
               AT END MOVE "Y" TO WS-EOF
           END-READ.

		   IF WS-EOF = "N"
           05 KEY-NUM      PIC 9(10).
           05 KEY-NAME     PIC X(20).
           05 DATA-TYPE    PIC 9.
           05 DATA-Content1 PIC X(80). 

               MOVE KEY-FIELD TO WS-KEY-FIELD
               MOVE DATA-FIELD TO WS-DATA-FIELD
               DISPLAY WS-MSG
           END-If.
	  	   
      *   Display "STATUS=" WS-FILE-STATUS.
      *

