       IDENTIFICATION DIVISION.
       PROGRAM-ID. EXCLI.
       
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       
       DATA DIVISION.
       
       WORKING-STORAGE SECTION.
          77 WS-SPACE            PIC X(40) VALUE SPACES.
          77 FS                  PIC X(02) VALUE SPACES.
          77 WS-FUNC             PIC 9     VALUE ZERO.
          77 MSG                 PIC X(09) VALUE SPACES.
          77 WS-CONF             PIC X     VALUE SPACE.
          
          01 NOME-ENT            PIC X.

          01 WS-DATA-SIS.
             02 AA               PIC 9(02) VALUE ZEROS.
             02 MM               PIC 9(02) VALUE ZEROS.
             02 DD               PIC 9(02) VALUE ZEROS.
          01 WS-MENSAGENS.
             02 MENSA1    PIC X(30) VALUE "FUNÇÃO ERRADA - REDIGITE".
             02 MENSA2    PIC X(30) VALUE "CAMPO INVALIDO".
             02 MENSA3    PIC X(30) VALUE "CLIENTE JÁ CADASTRADO".
             02 MENSA4    PIC X(30) VALUE "CLIENTE NÃO CADASTRADO".
       
       SCREEN SECTION.
          01 TELA1.
             02 BLANK SCREEN.
             02 LINE 01 COLUMN 01 VALUE "EM:".
             02 LINE 01 COLUMN 04 FROM WS-DATA-SIS.
             02 LINE 01 COLUMN 26 
                 VALUE "CADASTRO DE CLIENTES" REVERSE-VIDEO.
             02 LINE 03 COLUMN 19 
                 VALUE "AUTOR: ALEXANDRE SAVELLI BENCZ".
             02 LINE 06 COLUMN 29 VALUE "FUNCAO DESEJADA: < >".
             02 LINE 08 COLUMN 29 VALUE "< 1 > INCLUSAO".
             02 LINE 10 COLUMN 29 VALUE "< 2 > ALTERACAOO".
             02 LINE 12 COLUMN 29 VALUE "< 3 > EXCLUSAO".
             02 LINE 14 COLUMN 29 VALUE "< 4 > CONSULTA".
             02 LINE 16 COLUMN 29 VALUE "< 5 > FIM".
             02 LINE 21 COLUMN 29 VALUE "MENSAGEM:".
             02 LINE 22 COLUMN 29 TO NOME-ENT.
         
          01 TELA-OPCAO.
             02 LINE 06 COLUMN 39 PIC X(09) USING MSG REVERSE-VIDEO.
       
       PROCEDURE DIVISION.
       INICIO.          
       
       TELA.
           ACCEPT WS-DATA-SIS FROM DATE.
           DISPLAY TELA1.
           ACCEPT TELA1.
       FIM.   
           STOP RUN.