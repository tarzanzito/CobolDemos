       IDENTIFICATION DIVISION.
       PROGRAM-ID. WriteLineSequentialFixed.                  
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OPTIONAL NOTE-FILE                         
           ASSIGN TO 'notes.csv'   
           ORGANISATION IS LINE SEQUENTIAL
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
       01  NOTE-RECORD.                            
           05 NOTE-ID               PIC 9(3).                   
      *     05 FILLER PIC X value ';'. error
           05 FIELD-SEPARATOR-1         PIC X.
           05 STRING-DELIMITER-B1       PIC X.
           05 NOTE-NAME                 PIC X(40).
           05 STRING-DELIMITER-E1       PIC X.
           05 FIELD-SEPARATOR-2         PIC X.
           05 NOTE-LEVEL                PIC 9(1).
           05 FIELD-SEPARATOR-3         PIC X.
           05 STRING-DELIMITER-B2       PIC X.
           05 NOTE-CONTENT              PIC X(64).
           05 STRING-DELIMITER-E2       PIC X.
      *
       WORKING-STORAGE SECTION.                        
       01 WS-EOF                       PIC X(1) VALUE 'N'. 
       01 WS-STATUS                    PIC X(2).

      *CONSTANTS (level 78 but not cobol standard) 
      *78 CONST-RECORD-END            VALUE '|'.
       01 CONST-FIELD-SEPARATOR       PIC X VALUE ';'.
       01 CONST-STRING_DELIMITER      PIC X VALUE '"'.
      * 
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.     
            DISPLAY "Version: 0.0.4".

            OPEN OUTPUT NOTE-FILE. 
            DISPLAY "FILE STATUS:" WS-STATUS.
            IF WS-STATUS NOT EQUAL "00"
                GO TO MAIN-PROCEDURE-EXIT
            END-IF.
      *
            INITIALIZE NOTE-RECORD.
            MOVE 1                       TO NOTE-ID.                   
            MOVE "PAULO"                 TO NOTE-NAME.
            MOVE 2                       TO NOTE-LEVEL.
            MOVE "Any data 1"            TO NOTE-CONTENT.
            move CONST-STRING_DELIMITER  TO STRING-DELIMITER-B1.
            move CONST-STRING_DELIMITER  TO STRING-DELIMITER-E1.
            move CONST-STRING_DELIMITER  TO STRING-DELIMITER-B2.
            move CONST-STRING_DELIMITER  TO STRING-DELIMITER-E2.
            move CONST-FIELD-SEPARATOR   TO FIELD-SEPARATOR-1.
            move CONST-FIELD-SEPARATOR   TO FIELD-SEPARATOR-2.
            move CONST-FIELD-SEPARATOR   TO FIELD-SEPARATOR-3.
            
            WRITE NOTE-RECORD.
            DISPLAY "FILE STATUS:"WS-STATUS.
      *
            INITIALIZE NOTE-RECORD.
            MOVE 2                       TO NOTE-ID.                   
            MOVE "MANUEL"                TO NOTE-NAME.
            MOVE 1                       TO NOTE-LEVEL.
            MOVE "Any data 22222222"     TO NOTE-CONTENT.
            move CONST-STRING_DELIMITER  TO STRING-DELIMITER-B1.
            move CONST-STRING_DELIMITER  TO STRING-DELIMITER-E1.
            move CONST-STRING_DELIMITER  TO STRING-DELIMITER-B2.
            move CONST-STRING_DELIMITER  TO STRING-DELIMITER-E2.
            move CONST-FIELD-SEPARATOR   TO FIELD-SEPARATOR-1.
            move CONST-FIELD-SEPARATOR   TO FIELD-SEPARATOR-2.
            move CONST-FIELD-SEPARATOR   TO FIELD-SEPARATOR-3.

            WRITE NOTE-RECORD.
            DISPLAY "FILE STATUS:"WS-STATUS.

       MAIN-PROCEDURE-EXIT.     
            CLOSE NOTE-FILE.                             
            DISPLAY "FILE STATUS:"WS-STATUS.
            STOP RUN.                                  
      *
