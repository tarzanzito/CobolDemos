       IDENTIFICATION DIVISION.
       PROGRAM-ID. WriteSequentialFixed.                  
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OPTIONAL NOTE-FILE                         
           ASSIGN TO 'notes.dat'   
           ORGANISATION IS SEQUENTIAL
           FILE STATUS WS-STATUS.
      *     
       DATA DIVISION.
       FILE SECTION.
       FD NOTE-FILE.
      *  LABEL RECORD IS STANDARD
      *  DATA RECORD IS NOTES-RECORD             
      *  RECORDING MODE IS F                    
      *  BLOCK CONTAINS 0.                
      
      *note: cannot use 'value' in definition, Status-code=71                                   
       01 NOTE-RECORD.                            
          05 NOTE-ID               PIC 9(4).                   
          05 NOTE_NAME             PIC X(30).
          05 NOTE-LEVEL            PIC 9(1).
          05 NOTE-CONTENT          PIC X(128).
          05 NOTE-END              PIC X(1).
      *
       WORKING-STORAGE SECTION.                        
       01 WS-EOF                      PIC X(1) VALUE 'N'. 
       01 WS-STATUS                   pic X(2).

      *CONSTANTS (level 78 but not cobol standard) 
      *78 CONST-RECORD-END            VALUE '|'.
       01 CONST-RECORD-END            PIC X VALUE '|'.
      *
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
            DISPLAY "Version: 0.0.3:".
			
            OPEN OUTPUT NOTE-FILE 
            DISPLAY "FILE STATUS:"WS-STATUS.
			
			IF WS-STATUS NOT EQUAL "00"
                GO TO MAIN-PROCEDURE-EXIT
            END-IF.
      *
            INITIALIZE NOTE-RECORD.
            MOVE 1                   TO NOTE-ID.                   
            MOVE "PAULO"             TO NOTE_NAME.
            MOVE 2                   TO NOTE-LEVEL.
            MOVE "Any data 1"        TO NOTE-CONTENT.
            MOVE CONST-RECORD-END    TO NOTE-END.

            WRITE NOTE-RECORD.
            DISPLAY "FILE STATUS:"WS-STATUS.
      *
            INITIALIZE NOTE-RECORD.
            MOVE 2                   TO NOTE-ID.                   
            MOVE "MANUEL"            TO NOTE_NAME.
            MOVE 1                   TO NOTE-LEVEL.
            MOVE "Any data 2 abcd"   TO NOTE-CONTENT.
            MOVE CONST-RECORD-END    TO NOTE-END.

            WRITE NOTE-RECORD.
            DISPLAY "FILE STATUS:"WS-STATUS.

       MAIN-PROCEDURE-EXIT.
            CLOSE NOTE-FILE.                             
            DISPLAY "FILE STATUS:"WS-STATUS.
            STOP RUN.                                  
      *
