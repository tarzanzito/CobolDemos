      ******************************************************************
      *DESC    : Search records by key (equals) in indexed file (vsam) *
      *AUTHOR  : Paulo                                                 *
      *DATE    : 2025-05-10                                            *
      *VERSION : 1.1.0                                                 *
      *NOTES   :                                                       *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. VSAM-Search-Equals.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT VSAM-FILE ASSIGN TO "my-vsam-file.dat" 
            ORGANIZATION IS INDEXED
            ACCESS MODE IS RANDOM
            RECORD KEY IS KEY-FIELD 
            FILE STATUS IS WS-FILE-STATUS. 

       DATA DIVISION. 
       FILE SECTION. 
       FD VSAM-FILE. 
       01 VSAM-RECORD. 
          05 KEY-FIELD      PIC X(10).
          05 DATA-FIELD     PIC X(70). 

       WORKING-STORAGE SECTION. 
       01 WS-FILE-STATUS    PIC X(2). 
       01 WS-EOF            PIC X VALUE "N". 
       01 WS-KEY            PIC X(10).
          88 WS-IS-QUIT     VALUE "Q", "q".
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
           DISPLAY "# FILE STATUS=" WS-FILE-STATUS.

           IF WS-FILE-STATUS = "00"
              PERFORM START-RECORDS
           END-IF 			   

           CLOSE VSAM-FILE. 
           STOP RUN. 
      *
       START-RECORDS. 
           DISPLAY "# START Search equals...".
           PERFORM FIND-RECORD-EQUALS UNTIL WS-IS-QUIT.
           DISPLAY "# FINISHED...:".
	  *
       FIND-RECORD-EQUALS. 
           DISPLAY "# Enter Key or (q) to quit:".
           ACCEPT WS-KEY from console.
           IF WS-IS-QUIT
              EXIT PARAGRAPH.
           
           MOVE SPACES TO VSAM-RECORD.
           MOVE WS-KEY TO KEY-FIELD
           
           READ VSAM-FILE INTO VSAM-RECORD
               KEY IS KEY-FIELD
               INVALID KEY
                  DISPLAY "# INVALID KEY"
               NOT INVALID KEY
                   MOVE KEY-FIELD  TO WS-KEY-FIELD
                   MOVE DATA-FIELD TO WS-DATA-FIELD
                   DISPLAY WS-MSG
            END-READ.

            DISPLAY "# STATUS CODE=" WS-FILE-STATUS.
            DISPLAY " ".
      *
