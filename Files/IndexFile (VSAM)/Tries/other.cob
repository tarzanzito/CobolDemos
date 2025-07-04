IDENTIFICATION DIVISION.                 
 PROGRAM-ID. COBOADD.                     
 ENVIRONMENT DIVISION.                   
 INPUT-OUTPUT SECTION.                   
 FILE-CONTROL.                           
     SELECT IN-FILE ASSIGN TO DD1         
     ORGANIZATION IS SEQUENTIAL           
     ACCESS MODE IS SEQUENTIAL.           
     SELECT OUT-FILE ASSIGN TO DD2       
     ORGANIZATION IS INDEXED             
     RECORD KEY IS ONO                   
     ACCESS MODE IS DYNAMIC               
     FILE STATUS IS ST.                   
 DATA DIVISION.                           
 FILE SECTION.                           
 FD IN-FILE.                   
 01 IN-REC.                     
    02 WNO PIC X(3).           
    02 WNAME PIC X(10).         
    02 WADDR PIC X(15).         
    02 FILLER PIC X(52).       
 FD OUT-FILE.                   
 01 OUT-REC.                   
    02 ONO PIC X(3).           
    02 ONAME PIC X(10).         
    02 OADDR PIC X(15).         
    02 FILLER PIC X(52).       
 WORKING-STORAGE SECTION.       
 01 EOF PIC X.                 
 77 ST PIC 99.                 
 PROCEDURE DIVISION.           
 MAIN-PARA.                     
     OPEN INPUT IN-FILE         
           I-O OUT-FILE.                                     
     DISPLAY ST.                                             
     PERFORM READ-PARA UNTIL EOF = 'Y'.                   
     CLOSE IN-FILE.                                       
     CLOSE OUT-FILE.                                       
     DISPLAY ST.                                           
     STOP RUN.                                             
READ-PARA.                                               
       READ IN-FILE INTO OUT-REC AT END MOVE 'Y' TO EOF. 
       IF EOF NOT EQUAL TO 'Y'                           
         WRITE OUT-REC                                   
         DISPLAY ST                                       
         DISPLAY OUT-REC                                 
       END-IF.       