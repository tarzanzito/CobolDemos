      ******************************************************************
      *DESC    : Search records by key (>=) in indexed file (vsam)     *
      *        : navegate to next and precious records                 *
	  *        : using START                                           *
      *AUTHOR  : Paulo                                                 *
      *DATE    : 2025-05-10                                            *
      *VERSION : 1.1.0                                                 *
      *NOTES   :                                                       *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. VSAM-Search-GreaterOrEquals.
      *
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT VSAM-FILE ASSIGN TO "my-vsam-file.dat" 
            ORGANIZATION IS INDEXED
            ACCESS MODE IS Dynamic
      *     ACCESS MODE IS SEQUENTIAL compile error in READ
            RECORD KEY IS KEY-FIELD 
            FILE STATUS IS WS-FILE-STATUS. 
      *
       DATA DIVISION. 
       FILE SECTION. 
       FD  VSAM-FILE. 
       01  VSAM-RECORD. 
           05 KEY-FIELD      PIC X(10).
           05 DATA-FIELD     PIC X(70). 
      *
       WORKING-STORAGE SECTION. 
       01 WS-FILE-STATUS     PIC X(2). 
       01 WS-EOF             PIC X VALUE "N". 
       01 WS-KEY             PIC X(10).
          88 WS-IS-QUIT      VALUE "Q", "q".
          88 WS-IS-FIND      VALUE "F", "f".
          88 WS-IS-PREV      VALUE "P", "p".
          88 WS-IS-NEXT      VALUE "N", "n".
       01 WS-MSG.
          05 FILLER          PIC X(13) VALUE "Record, Key=[".
          05 WS-KEY-FIELD    PIC X(10).
          05 FILLER          PIC X(9) VALUE "] Value=[".
          05 WS-DATA-FIELD   PIC X(70).
          05 FILLER          PIC X(1) VALUE "]". 
      *              
       PROCEDURE DIVISION. 
       MAIN-PROCEDURE. 
           OPEN Input VSAM-FILE 

           DISPLAY "FILE STATUS=" WS-FILE-STATUS.
		   
           IF WS-FILE-STATUS = "00"
              PERFORM START-RECORDS
           END-IF 			   

           CLOSE VSAM-FILE. 

           STOP RUN. 
      *
       START-RECORDS. 
           DISPLAY "START...:".

           PERFORM ASK-RECORDS UNTIL WS-IS-QUIT.

           DISPLAY "FINISHED...:".
	  *	  
       ASK-RECORDS. 
           DISPLAY "Action (f)-find, (n)-next, (p)-prev, (q)-quit".
           ACCEPT WS-KEY FROM CONSOLE

            EVALUATE TRUE
                WHEN WS-IS-QUIT
                    EXIT PARAGRAPH
                WHEN WS-IS-FIND
                    PERFORM FIND-RECORD
                WHEN WS-IS-NEXT
                    PERFORM NEXT-RECORD 
                WHEN WS-IS-PREV
                    PERFORM PREV-RECORD 
                WHEN OTHER
                    DISPLAY "NO Action to do...."
            END-EVALUATE.
      *
       FIND-RECORD. 
           DISPLAY "Search for Key >=:".
           ACCEPT WS-KEY FROM CONSOLE.
           MOVE WS-KEY TO KEY-FIELD

           START VSAM-FILE
              KEY GREATER THAN OR EQUAL TO  KEY-FIELD
              INVALID KEY 
                  DISPLAY "INVALID KEY"
              NOT INVALID KEY
                  MOVE KEY-FIELD TO WS-KEY-FIELD
                  MOVE DATA-FIELD TO WS-DATA-FIELD
                  DISPLAY WS-MSG
             END-START.

            DISPLAY "START STATUS-CODE=" WS-FILE-STATUS.
            
            PERFORM NEXT-RECORD.

            DISPLAY " ".
      *
       NEXT-RECORD. 
            READ VSAM-FILE NEXT INTO VSAM-RECORD
               AT END
                   MOVE "Y" TO WS-EOF
                   DISPLAY "# END FILE"
               NOT AT END
                   MOVE KEY-FIELD TO WS-KEY-FIELD
                   MOVE DATA-FIELD TO WS-DATA-FIELD
                   DISPLAY WS-MSG
            END-READ.

            DISPLAY "Next".
            DISPLAY "READ STATUS CODE=" WS-FILE-STATUS.
      *
       PREV-RECORD. 
            READ VSAM-FILE PREVIOUS INTO VSAM-RECORD
               AT END
                   MOVE "Y" TO WS-EOF
                   DISPLAY "# END FILE"
               NOT AT END
                   MOVE KEY-FIELD TO WS-KEY-FIELD
                   MOVE DATA-FIELD TO WS-DATA-FIELD
                   DISPLAY WS-MSG
            END-READ.

           DISPLAY "Prev".
           DISPLAY "READ STATUS CODE=" WS-FILE-STATUS.
      *  