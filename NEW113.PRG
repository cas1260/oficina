***************************
* NEW11.PRG PRG DE VENDAS *
***************************

PRIVATE VCAMPOS[4],VCABEC[4],VNEW[99]
SAVE SCREEN TO VTELA_VENDAS
DO WHILE .T.
	USE TEMP
	DO WHILE !EOF()
	   DELE
	   SKIP
	ENDDO
	PACK
	CLOSE ALL
*  X = 1
*  DO WHILE X<>99
*     VNOMEP[X] = SPACE(40)
*     VCODIGOP[X] = SPACE(5)
*     VVALORP[X] = 0
*     VCODP[X] = SPACE(5)
*     X = X + 1
*  ENDDO
   VPLACA = SPACE(7)
   VNOMEC = SPACE(40)
   VKM = 0
	@ 10,10 CLEAR TO 14,35
   @ 10,10 TO 14,35 DOUBLE
   @ 11,11 SAY "N.� da Placa " GET VPLACA PICT "@!"
   @ 13,11 SAY "N� do KM     " GET VKM PICT "99999"
   READ
	
   IF LASTKEY()=27
      EXIT
   ENDIF
   IF LASTKEY()#27
      SAVE SCREEN TO VTE_CL
      USE CLIENTE INDEX CLIENTE1 INDEX CLIENTE2
      SEEK VPLACA
      IF EOF()
         SAVE SCREEN TO VTELA_A
            MSGBOX("Cliente n�o Cadastro!")
         RESTORE SCREEN FROM VTELA_A
      ELSE
			VNOMECLI=NOME
			VEMP=EMP
			VPLACA = PLACA
			BOX(VPLACA+" - "+ALLTRIM(VNOMECLI)+" - "+ALLTRIM(VEMP))
			INKEY(3)
			VOBS = OBS
			IF VOBS ="S"
				VCOLOR=SETCOLOR()
				VOBS1=ALLTRIM(OBS1)
				VOBS2=ALLTRIM(OBS2)
				VOBS3=ALLTRIM(OBS3)
				@ 09,14 CLEAR TO 16,66						
				@ 09,14 TO 16,66						
				SET COLOR TO W*/rb
				CENTRA(10,15,65,"Aten�ao")
				SET COLOR TO &VCOLOR
				CENTRA(11,15,65,VOBS1)
				CENTRA(12,15,65,VOBS2)
				CENTRA(13,15,65,VOBS3)
				@ 15,15 SAY "Senha de Liberacao"
				SENHA(15,34,4,10)
				IF UPPER(TD)<>"MATHEUS"
					EXIT
				ENDIF
				SET COLOR TO W+/RB,N/W
			ENDIF
			CLEAR
         DO WHILE .T.
				DO TELA
            VNOMEP = SPACE(40)
            VVALOR = 0
            VCODP = SPACE(5)
				SET KEY -1 TO HIDE
            @ 23,00 SAY "Codigo  " GET VCODP PICT "@!"
            @ 24,25 SAY "Finalizar Venda"
            @ 24,45 SAY "Excluir Iten da Lista"
*				@ 23,25 SAY "F2 - PESQUISA"
            @ 23,55 SAY "Total..: "
            READ
*				SET KEY 9 TO MSPRODUTO
				SET KEY -1 TO
            IF LASTKEY()=27
               EXIT
            ENDIF
            IF VCODP="     "
               SAVE SCREEN TO VTELA_EX
					@ 24,25 PROMPT "Finalizar Venda"
               @ 24,45 PROMPT "Excluir Iten da Lista"
               MENU TO VA
               DO CASE
                  CASE VA = 1
							@ 16,40 CLEAR TO 19,65
                     @ 16,40 TO 19,65
                     CENTRA(17,40,65,"Confimar Dados?")
                     @ 18,45 PROMPT " SIM "
                     @ 18,53 PROMPT " NAO "
                     MENU TO VOP
							IF VOP = 1
		                  USE TEMP
   		               VTOTAL = 0
      		            VCONT = 1
         		         DO WHILE !EOF()
            		        VTOTAL = VTOTAL + VALOR
               		     SKIP
                  		  VCONT = VCONT + 1
	         				ENDDO
								USE TEMP
								GO TOP
								X = 1
								DO WHILE !EOF()
									VNEW[X] = CODP
									SKIP
									X = X + 1
								ENDDO
								P = 1
								DO WHILE P<>X
									USE PRODUTO INDEX PRODUTO1 INDEX PRODUTO2
									SEEK VNEW[P]
									IF !EOF()	
										REPLACE QTD WITH QTD - 1
									ENDIF
									P = P + 1
								ENDDO
			               DO IVENDAS              
         					EXIT
							ENDIF
				     CASE VA = 2
                     @ 00,00 CLEAR TO 22,65
                     @ 00,00 TO 22,65 DOUBLE
                     USE TEMP
                     VCABEC[2] = "NOME"
                     VCABEC[1] = "CODIGO"
                     VCABEC[3] = "VALOR"
   
                     VCAMPOS[2] = "DESCRICAO"
                     VCAMPOS[1] = "CODP"
                     VCAMPOS[3] = "VALOR" 
      
*                     DBEDIT(01,01,21,78,VCAMPOS,0,0,VCABEC)
							DBEDIT(01,01,21,64,VCAMPOS,0,0,VCABEC)
                     IF LASTKEY()#27
                        @ 16,40 CLEAR TO 19,65
                        @ 16,40 TO 19,65
                        CENTRA(17,40,65,"Confimar Dele��o?")
                        @ 18,45 PROMPT " SIM "
                        @ 18,53 PROMPT " NAO "
                        MENU TO VOP
                        DO CASE
                           CASE VOP = 1         
                              DELE
                              PACK
                              SKIP                             
                              VTOTAL = 0
                              X = 3
                              CLOSE ALL
										DO TELA
                        ENDCASE
                  ENDIF
               ENDCASE           
               RESTORE SCREEN FROM VTELA_EX
            ENDIF
            VCODP = STRZERO(VAL(VCODP),5)
            USE PRODUTO INDEX PRODUTO1 INDEX PRODUTO2
            SEEK VCODP
            IF !EOF()
               VCODP = CODP
               VNOMEP = DESCRICAO
               VVALOR = VALOR
               USE TEMP
                  APPEND BLANK
                  REPLACE CODP WITH VCODP
                  REPLACE DESCRICAO WITH VNOMEP
                  REPLACE VALOR WITH VVALOR
               CLOSE ALL
					DO TELA
            ENDIF

         ENDDO
      ENDIF
   RESTORE SCREEN FROM VTE_CL
   
   ENDIF
ENDDO
RESTORE SCREEN FROM VTELA_VENDAS
RETURN
*******************
PROCEDURE IVENDAS *
*******************
PRIVATE VNOMEP[99],VCODIGOP[99],VVALORP[99],VCODP[99]
IF LASTKEY()#27
 *  DO IMPR  
   USE CLIENTE INDEX CLIENTE1 INDEX CLIENTE2
   SEEK VPLACA
   REPLACE TOTAL WITH TOTAL
   SET PRINTER TO MM
   IF LASTKEY()#27
      USE CONFIG
      VCABECA1= CABECA1
      VCABECA2= CABECA2
      VCABECA3= CABECA3
      VRODAPE1 = RODAPE1
      VRODAPE2 = RODAPE2
      VRODAPE3 = RODAPE3
      T=0
      P=X
      X=1
      USE TEMP
		DO WHILE !EOF()
			VNOMEP[X] = DESCRICAO
         VVALORP[X] = VALOR
         VCODP[X] = CODP
			SKIP
			X = X + 1
		ENDDO
		X = 1
      DO WHILE VCONT<>X
         USE VENDAS
         APPEND BLANK
            REPLACE NOME WITH VEMP
            REPLACE PRODUTO WITH VCODP[X]
            REPLACE PLACA WITH VPLACA
            REPLACE DATA WITH DATE()
            REPLACE VALOR WITH VTOTAL
            REPLACE DES WITH VNOMEP[X]
            REPLACE VALORP WITH VVALORP[X]
            REPLACE MOTO WITH VNOMECLI
            X=X+1
         ENDDO
         X=P
    ENDIF
   IF LASTKEY()#27
*		SET PRINTER TO PAPEL
      SET DEVI TO PRINT
      @ PROW(),PCOL() SAY CHR(27)+CHR(48)+CHR(15)
      @ PROW()+1 ,01 SAY CHR(12)+VCABECA1+CHR(20)
      @ PROW()+2, 01 SAY VCABECA2
      @ PROW()+2, 01 SAY VCABECA3   
      @ PROW()+2  ,25 SAY DATE()
      @ PROW()  ,45 SAY TIME()
      @ PROW()+1,02 SAY "RECIBO EMPRESA                       (WG INF.)"
      @ PROW()+2,01 SAY REPLICATE("=",60)
      @ PROW()+2,01 SAY "NOME: "+SUBS(VNOMECLI,1,30)+"  PLACA.: "+VPLACA
      @ PROW()+2,01 SAY "EMPRESA: "+SUBS(VEMP,1,30)
      @ PROW()+2,01 SAY "PLACA "+VPLACA
      @ PROW()+2,01 SAY "KM: " +STR(VKM) +"                  VALOR"
      @ PROW()+2,01 SAY REPLICATE("-",60)
      X=1
		USE TEMP
		DO WHILE !EOF()
	      @ PROW()+2,01 SAY SUBS(DESCRICAO,1,20)
*        @ PROW()  ,36 SAY VCOD[X] 
         @ PROW()  ,25 SAY VALOR PICTURE "@E 99,999.99"
			SKIP
       ENDDO
       @ PROW()+1,01 SAY REPLICATE("-",60)
       @ PROW()+2,01   SAY "VALOR TOTAL..... R$ "
       @ PROW(),PCOL() SAY VTOTAL PICTURE "@E 99,999.99"
 *     @ PROW()+2,01   SAY "# # # # DEVOLUCAO.......: "
 *     @ PROW(),PCOL()+2 SAY VDATA
       @ PROW()+4,02 SAY "CLIENTE:" 
       @ PROW()+2,00 SAY "____________________________________"
       @ PROW()+3,00 SAY VRODAPE1
       @ PROW()+2,00 SAY VRODAPE2
       @ PROW()+2,00 SAY VRODAPE3
       @ PROW()+40,00 SAY " "  
    
       SET DEVI TO SCREEN
	ENDIF
ENDIF

**************
PROCEDURE TELA
**************
PRIVATE VCAMPOS[4],VCABEC[4],VNEW[99]
USE TEMP
VTOTAL = 0
DO WHILE !EOF()
	VTOTAL = VTOTAL + VALOR
	SKIP
ENDDO
VCABEC[2] = "NOME"
VCABEC[1] = "CODIGO"
VCABEC[3] = "VALOR"
  
VCAMPOS[2] = "DESCRICAO"
VCAMPOS[1] = "CODP"
VCAMPOS[3] = "VALOR" 
GO TOP
@ 23,15 SAY " - "+VNOMECLI
@ 23,55 SAY "Total..: "+STR(VTOTAL)
@ 24,00 SAY "F2 - PESQUISA"
KEYBOARD CHR(13)
@ 00,00 TO 22,65 DOUBLE

DBEDIT(01,01,21,64,VCAMPOS,0,0,VCABEC)

PROCEDURE TELA1
@ 00,00 TO 22,60 DOUBLE
@ 01,01 SAY "CODIGO"
@ 01,09 SAY "DESCRI��O"
@ 01,52 SAY "VALOR"
@ 02,01 TO 02,53
@ 01,07 TO 21,07
@ 01,47 TO 21,47
USE TEMP
X = 3
VTOTAL = 0
DO WHILE !EOF()
	@ X,01 SAY CODP
	@ X,09 SAY DESCRICAO
	@ X,52 SAY VALOR
	SKIP
	X = X + 1
	IF X = 18
		@ 19,54 SAY CHR(25)
		EXIT
	ENDIF
ENDDO