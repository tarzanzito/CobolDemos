       IDENTIFICATION DIVISION.
       PROGRAM-ID. WriteLineSequentialFixed.                  
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT optional EMPLOYEE-RECORD                         
           ASSIGN TO 'msgs2.csv'   
           ORGANISATION IS LINE SEQUENTIAL
           FILE STATUS WS-STATUS.
      *     
       DATA DIVISION.
       FILE SECTION.
       FD EMPLOYEE-RECORD
       record varying from 3 to 80 characters
          depending on ws-record-length.
       01 recseqv-fd-record  pic x(80).
      *
       WORKING-STORAGE SECTION.   
       01 ws-record-length   pic 99.                     
       01 WS-EOF PIC X(1) VALUE 'N'. 
       01 WS-STATUS pic x(2).
      *78 CONST-FIELD-SEPARATOR        PIC X VALUE ';'.
       78 CONST-FIELD-SEPARATOR        VALUE ';'.
       78 CONST-STRING_DELIMITER       VALUE '"'.
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.     
            DISPLAY "V3:".
      *    INITIALIZE WS-RECORD-COUNT.
      *    INITIALISE WS-INFL-REC.                            

            OPEN OUTPUT EMPLOYEE-RECORD 
            DISPLAY "FILE STATUS:" WS-STATUS.
            IF WS.STATUS NOT EQAUL "00"
                GO TO MAIN-PROCEDURE-EXIT
            END-IF.

            
            WRITE EMPLOYEE-RECORD.
            DISPLAY "FILE STATUS:"WS-STATUS.

            MOVE 2 TO EMPLOYEE-ID.                   
            MOVE "MANUEL" to EMPLOYEE_NAME.
            MOVE 30 TO AGE.
            WRITE EMPLOYEE-RECORD.
            DISPLAY "FILE STATUS:"WS-STATUS.

       MAIN-PROCEDURE-EXIT.     
            CLOSE EMPLOYEE.                             
            DISPLAY "FILE STATUS:"WS-STATUS.
            STOP RUN.                                  
      *
