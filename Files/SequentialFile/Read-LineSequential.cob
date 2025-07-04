       IDENTIFICATION DIVISION.
       PROGRAM-ID. EMPLOYEE-DATA.                  
      //Line Number 2
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT EMPLOYEE                         
      //Line Number 6
           ASSIGN TO 'C:\Users\Desktop\Employee.dat'   
      //Line Number 7
           ORGANISATION IS LINE SEQUENTIAL.
      //Line Number 8
       DATA DIVISION.
       FILE SECTION.
       FD EMPLOYEE.                                    
      //Line Number 11
       01  EMPLOYEE-RECORD.                            
      //Line Number 12
           05 EMPLOYEE-ID PIC 9(3).                   
      //Line Number 13
           05 FILLER PIC X(10).
           05 EMPLOYEE_NAME PIC X(6).
           05 FILLER PIC X(9).
           05 AGE PIC 9(2).
           05 FILLER PIC X(3).
           05 GRADE PIC X(1).
           05 FILLER PIC X(6).
           05 SALARY PIC 9(5).                         
      //Line Number 21
       WORKING-STORAGE SECTION.                        
      //Line Number 22
       01  WS-EOF PIC X(1) VALUE 'N'.                  
      //Line Number 23
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.                                 
      //Line Number 25
           OPEN INPUT EMPLOYEE                         
      //Line Number 26
            PERFORM READ-PROCEDURE UNTIL WS-EOF = 'Y'  
      //Line Number 27 
            CLOSE EMPLOYEE                             
      //Line Number 28
            STOP RUN.                                  
      //Line Number 29
       READ-PROCEDURE.
           READ EMPLOYEE    
      //Line Number 31
            AT END MOVE 'Y' TO WS-EOF
            NOT AT END PERFORM DISPLAY-PROCEDURE
           END-READ.
       DISPLAY-PROCEDURE.   
      //Line Number 35 
           IF EMPLOYEE-ID NOT = 'EMP'     
      //Line Number 36
               IF EMPLOYEE-ID NOT = ' ' THEN  
      //Line Number 37
                   DISPLAY 'EMPLOYEE-ID IS :'EMPLOYEE-ID  
      //Line Number 38
                   IF EMPLOYEE_NAME NOT = 'EMPLOY' 
      //Line Number 39
                       IF EMPLOYEE_NAME NOT = ' ' THEN  
      //Line Number 40
       DISPLAY 'EMPLOYEE NAME IS :'EMPLOYEE_NAME  
      //Line Number 41
        IF SALARY NOT = 'SALAR'   
      //Line Number 42
        IF SALARY NOT = ' ' THEN   
      //Line Number 43
        DISPLAY 'EMPLOYEE SALARY IS :'SALARY   
      //Line Number 44
           END-IF
           DISPLAY '-------------------------------------'.