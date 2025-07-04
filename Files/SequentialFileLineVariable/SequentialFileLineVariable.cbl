000010 IDENTIFICATION DIVISION.                                         
000020 PROGRAM-ID. FileLineVariable.                        
000030 AUTHOR. PAULO GONCALVES.
000080 ENVIRONMENT DIVISION.
000090 INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FILE-NAME ASSIGN TO "test.txt"
           ORGANIZATION IS LINE SEQUENTIAL
	       ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS FILE-STATUS.
000100 DATA DIVISION.
       FILE SECTION.
       FD FILE-NAME
	       RECORDING MODE IS V
           RECORD IS VARYING FROM 1 TO 255
	       DEPENDING RECORD-LENGHT.
      *     BLOCK CONTAINS 0 RECORDS.
       01 RECORD-DATA           PIC X(255).
         
000120 WORKING-STORAGE SECTION. 
       01 FILE-STATUS           PIC 99.                                        
       01 RECORD-LENGHT         PIC 9(4) COMP-5.
000950                                                                  
000970 01 WS-STRING             PIC X(255).
       01 WS-COUNT-SPACES       pic 9(4).
	   01 WS-POS                pic 9(4).
	   
001060 PROCEDURE DIVISION.                                              
001130 00-BEGIN.                                                       
		   OPEN OUTPUT FILE-NAME.
		   
001150     INITIALIZE  WS-STRING, WS-POS, WS-COUNT-SPACES.

      *******************************************************
      *NOTE:                                                *	  
      *IS NECESSARY PUT LENGHT IN variable 'RECORD-LENGHT'  *
      *FD FILE-NAME                                         *
      *   DEPENDING RECORD-LENGHT                           *
      ******************************************************* 

           MOVE "Paulo" to WS-STRING.
		   
		   PERFORM 2010-GET-TRIM-RIGHT-POSITION-2.
		   MOVE WS-STRING  TO RECORD-DATA.
		   MOVE WS-POS     TO RECORD-LENGHT.

		   WRITE RECORD-DATA.

      **************12*********************

           MOVE "aaaaaaaaaaaz" to WS-STRING.

		   PERFORM 2010-GET-TRIM-RIGHT-POSITION-2.
		   MOVE WS-STRING  TO RECORD-DATA.
		   MOVE WS-POS     TO RECORD-LENGHT.
		   
		   WRITE RECORD-DATA.

      **************30*********************

           MOVE "bbbbbbbbbbbbbbbbbbb cccccccccz" to WS-STRING.
		   
		   PERFORM 2010-GET-TRIM-RIGHT-POSITION-2.
		   MOVE WS-STRING  TO RECORD-DATA.
		   MOVE WS-POS     TO RECORD-LENGHT.
		   
		   WRITE RECORD-DATA.

      ***********************************

001740 99-END.    
		   CLOSE FILE-NAME.                                                      
001750     STOP RUN.

       2000-GET-TRIM-RIGHT-POSITION-1.
	        DISPLAY "2000-GET-TRIM-RIGHT-POSITION-1"
	        DISPLAY "S:" ws-STRING ":Z".

      	   PERFORM VARYING WS-POS
              FROM LENGTH OF WS-STRING BY -1
              UNTIL WS-STRING(WS-POS:1) NOT EQUAL SPACE
			     OR WS-POS < 1
				 
				 CONTINUE
				 
           END-PERFORM.
		   
		   DISPLAY "P:" ws-POS.
		   DISPLAY "T:" ws-STRING(1:WS-POS) ":Z".
           EXIT.
		   
       2010-GET-TRIM-RIGHT-POSITION-2.
           DISPLAY "2010-GET-TRIM-RIGHT-POSITION-2".
	   	   DISPLAY "S:" ws-STRING ":Z".
		   
		   MOVE ZERO TO		WS-COUNT-SPACES.
		   
		   INSPECT FUNCTION REVERSE (WS-STRING)
			TALLYING WS-COUNT-SPACES FOR LEADING SPACES

           COMPUTE WS-POS = LENGTH OF WS-STRING - WS-COUNT-SPACES.
		   
		   DISPLAY "C:" WS-COUNT-SPACES.
		   DISPLAY "P:" ws-POS.
		   DISPLAY "T:" ws-STRING(1:WS-POS) ":Z".
		   EXIT.

		   