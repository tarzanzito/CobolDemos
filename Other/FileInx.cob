       IDENTIFICATION DIVISION.
          PROGRAM-ID.    EXCLI.
       
          ENVIRONMENT DIVISION.
          CONFIGURATION SECTION.
          SPECIAL-NAMES.
             DECIMAL-POINT IS COMMA.
       
          INPUT-OUTPUT SECTION.
          FILE-CONTROL.
               SELECT ARQCLI ASSIGN TO DISK
      *ERRO : PARA ficheiros INDEXADOS PRECISA outra INSTalacao         
               ORGANIZATION            INDEXED
               ACCESS MODE             DYNAMIC
               RECORD KEY              FD-CODIGO
               FILE STATUS             FS.
       
          DATA DIVISION.
          FILE SECTION.
          FD ARQCLI LABEL RECORD STANDARD
                VALUE OF FILE-ID IS "ARQCLI.DAT".
       
          01 REG-ARQCLI.
             02 FD-CODIGO.
                 03 CODIGO       PIC 9(04).
             02 FD-NOME          PIC X(30).
             02 FD-END           PIC X(30).
             02 FD-BAIRRO        PIC X(20).
             02 FD-CIDADE        PIC X(20).
             02 FD-CEP           PIC 9(05).
       
          WORKING-STORAGE SECTION.
          77 WS-SPACE            PIC X(40) VALUE SPACES.
          77 FS                  PIC X(02) VALUE SPACES.
          77 WS-FUNC             PIC 9     VALUE ZERO.
          77 MSG                 PIC X(09) VALUE SPACES.
          77 WS-CONF             PIC X     VALUE SPACE.
          01 WS-DATA-SIS.
             02 AA               PIC 9(02) VALUE ZEROS.
             02 MM               PIC 9(02) VALUE ZEROS.
             02 DD               PIC 9(02) VALUE ZEROS.
          01 WS-MENSAGENS.
             02 MENSA1    PIC X(30) VALUE "FUNÇÃO ERRADA - REDIGITE".
             02 MENSA2    PIC X(30) VALUE "CAMPO INVALIDO".
             02 MENSA3    PIC X(30) VALUE "CLIENTE JÁ CADASTRADO".
             02 MENSA4    PIC X(30) VALUE "CLIENTE NÃO CADASTRADO".
       
                PROCEDURE DIVISION.
          INICIO.          
             OPEN I-O ARQCLI.
             IF FS NOT = "00"
                IF FS = "30"
                   CLOSE ARQCLI OPEN OUTPUT ARQCLI CLOSE ARQCLI
                   GO TO INICIO
                ELSE
                   DISPLAY "FILE STATUS --->" LINE 24 COLUMN 35
                   DISPLAY FS LINE 24 COLUMN 52
                   STOP RUN
                ELSE
                   NEXT SENTENCE.
                   ACCEPT WS-DATA-SIS FROM DATE.
       
          TELA.
      *      DISPLAY TELA1.
       
          FIM.   
             STOP RUN.
      * error [-Werror]: compiler is not configured to support ORGANIZATION INDEXED; FD      