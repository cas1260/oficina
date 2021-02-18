***************************
* NEW11.PRG PRG DE VENDAS *
***************************
PRIVATE VCAMPOS[4],VCABEC[4],VNEW[99]
PUBLIC VCONT_CONT,ACESSO
PUBLIC VDES_CONT,VCONT_PRINT
SAVE SCREEN TO VTELA_VENDAS
DO WHILE .T.
VCONT_PRINT = "S"
	VDES_CONT = 0
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
	SET KEY -1 TO E
	@ 10,10 CLEAR TO 14,35
   @ 10,10 TO 14,35 DOUBLE
   @ 11,11 SAY "N.ß da Placa " GET VPLACA PICT "@!"
   @ 13,11 SAY "Nß do KM     " GET VKM PICT "99999"
   READ
	SET KEY -1 TO 	
   IF LASTKEY()=27
      EXIT
   ENDIF
   IF LASTKEY()#27
      SAVE SCREEN TO VTE_CL
      USE CLIENTE INDEX CLIENTE1 INDEX CLIENTE2
      SEEK VPLACA
      IF EOF()
         SAVE SCREEN TO VTELA_A
            MSGBOX("Cliente n∆o Cadastro!")
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
				CENTRA(10,15,65,"Atenáao")
				SET COLOR TO &VCOLOR
				CENTRA(11,15,65,VOBS1)
				CENTRA(12,15,65,VOBS2)
				CENTRA(13,15,65,VOBS3)
				@ 15,15 SAY "Senha de Liberacao"
				TDA = PAS(15,34,10)
				IF UPPER(TDA)<>"MATHEUS"
					EXIT
				ENDIF
				SET COLOR TO W+/RB,N/W
			ENDIF
			CLEAR
         DO WHILE .T.
				USE PRAZO
				VCONT_CONT = LASTREC()+1
				DO TELA
            VNOMEP = SPACE(40)
            VVALOR = 0
            VCODP = SPACE(5)
				SET KEY -1 TO HIDE
            @ 23,00 SAY "Codigo  " GET VCODP PICT "99999"
            @ 24,25 SAY "Finalizar Venda"
            @ 24,45 SAY "Excluir Iten da Lista"
				@ 23,25 SAY "F2 - PESQUISA"
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
							IF EOF()
								MSGBOX("N∆o a Itens a ser Vendidos!")
								LOOP
							ENDIF
							@ 16,40 CLEAR TO 19,65
                     @ 16,40 TO 19,65
                     CENTRA(17,40,65,"Confimar Dados?")
                     @ 18,45 PROMPT " SIM "
                     @ 18,53 PROMPT " NAO "
                     MENU TO VOP
							IF VOP = 1
								SAVE SCREEN TO VTELA_VE_AS
								USE TEMP
   			            VTOTAL = 0
     				         VCONT = 1
        				      DO WHILE !EOF()
           			   		VTOTAL = VTOTAL + VALOR
            	  			   SKIP
               	  			VCONT = VCONT + 1
	        					ENDDO
								@ 16,48 CLEAR TO 24,70
								@ 16,48 TO 24,70 DOUBLE
								@ 17,49 SAY "Imprimir ? " GET VCONT_PRINT PICT "@!" VALID VCONT_PRINT$"SN"
								@ 18,49 SAY "Valor :" + STR(VTOTAL)
                        VDES_CONT = 0
                        @ 19,49 SAY "Desconto:" GET VDES_CONT PICT "999,999.99"
								CENTRA(21,48,67,"Tipo de Pagamento")
								@ 20,48 TO 24,70 DOUBLE
								@ 20,48 SAY "Ã"
								@ 20,70 SAY "π"
								@ 22,49 SAY "( ) VENDA A VISTA"
								@ 23,49 SAY "( ) VENDA A PRAZO"
								READ
                        VTOTAL = VTOTAL - VDES_CONT
								VENDAS = MENU_O(22,2,50,CHR(7),0)
								RESTORE SCREEN FROM VTELA_VE_AS
								VN = .T.
								VD = DATE()
								IF VENDAS = 1
									ACESSO = .F.
									VN=.F.
									VD=DATE()
								ELSEIF VENDAS = 2
									ACESSO = .T.
									VN=.T.
									VD = DATE()
									@ 19,58 CLEAR TO 23,67
									@ 19,48 CLEAR TO 23,67 
									@ 19,48 TO 23,67 DOUBLE
									CENTRA(20,48,67,"Data de Pagamento")
									@ 22,53 GET VD
									READ
								ENDIF
								IF LASTKEY()#27
			                 
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
				               IVENDAS(VN,VD)
									IF VENDAS = 2
										PRAZO(VNOMECLI,VPLACA,VEMP,VD)	
									ENDIF
									EXIT
								ENDIF
							ENDIF
				     CASE VA = 2
							IF EOF()
									MSGBOX("N∆o a itens a Ser excluidos!")
									LOOP
							ENDIF
                     @ 00,00 CLEAR TO 22,65
                     @ 00,00 TO 22,78 DOUBLE
                     USE TEMP
                     VCABEC[2] = "NOME"
                     VCABEC[1] = "CODIGO"
                     VCABEC[3] = "VALOR"
   
                     VCAMPOS[2] = "DESCRICAO"
                     VCAMPOS[1] = "CODP"
                     VCAMPOS[3] = "VALOR" 
      
*                     DBEDIT(01,01,21,78,VCAMPOS,0,0,VCABEC)
							DBEDIT(01,01,21,77,VCAMPOS,0,0,VCABEC)
                     IF LASTKEY()#27
                        @ 16,40 CLEAR TO 19,65
                        @ 16,40 TO 19,65
                        CENTRA(17,40,65,"Confimar Deleá∆o?")
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
PROCEDURE IVENDAS 
*******************
PRIVATE VNOMEP[99],VCODIGOP[99],VVALORP[99],VCODP[99]
PARAMETERS VVENDA,VD
IF LASTKEY()#27
	DO IMPR  
   USE CLIENTE INDEX CLIENTE1 INDEX CLIENTE2
   SEEK VPLACA
   REPLACE TOTAL WITH TOTAL
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
				REPLACE VENDA WITH VVENDA
            REPLACE NOME WITH VEMP
            REPLACE PRODUTO WITH VCODP[X]
            REPLACE PLACA WITH VPLACA
            REPLACE DATA WITH VD
            REPLACE VALOR WITH VTOTAL
            REPLACE DES WITH VNOMEP[X]
            REPLACE VALORP WITH VVALORP[X]
            REPLACE MOTO WITH VNOMECLI
				IF ACESSO = .F. 
					REPLACE CONT WITH 0
				ELSE
					REPLACE CONT WITH VCONT_CONT
				ENDIF
            X=X+1
         ENDDO
         X=P
    ENDIF
   IF LASTKEY()#27
		SET PRINTER TO SCOL
      SET DEVICE TO PRINT
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
      @ PROW()+2,01 SAY "KM: " +STR(VKM) +"          VALOR"
      @ PROW()+2,01 SAY REPLICATE("-",60)
      X=1
		USE TEMP
		DO WHILE !EOF()
	      @ PROW()+2,01 SAY SUBS(DESCRICAO,1,20)
*        @ PROW()  ,36 SAY VCOD[X] 
         @ PROW()  ,25 SAY VALOR PICTURE "@E 99,999.99"
			SKIP
       ENDDO
       @ PROW()+2,01 SAY REPLICATE("-",60)
		 @ PROW()+2,01 SAY "Valor Total..... R$ " 
       @ PROW(),23 SAY VTOTAL+VDES_CONT PICT "999,999.99"
	    @ PROW()+2,01 SAY "Desconto........ R$ "
       @ PROW(),23 SAY VDES_CONT PICT "999,999.99"
       @ PROW()+2,01 SAY "VALOR Final..... R$ " 
       @ PROW(),23 SAY VTOTAL PICT "999,999.99"
       @ PROW()+4,02 SAY "CLIENTE:" 
       @ PROW()+2,00 SAY "____________________________________"
       @ PROW()+3,00 SAY VRODAPE1
       @ PROW()+2,00 SAY VRODAPE2
       @ PROW()+2,00 SAY VRODAPE3
       @ PROW()+40,00 SAY " "  
       SET DEVICE TO SCREEN
		 IF VCONT_PRINT = "S"
	       SWPRUNCMD("COPY SCOL.PRN LPT1",0,"","")					
		 ENDIF
*	INKEY(0)
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
@ 23,55 SAY "Total..: "+STR(VTOTAL)
@ 23,25 SAY "F2 - PESQUISA"
KEYBOARD CHR(13)
@ 00,00 TO 22,78 DOUBLE
TO = LASTREC()
IF TO>18 .AND. TO<35
	VREG = 2
	SKIP LASTREC() / VREG
ELSEIF TO>36 .AND. TO<41
	VREG = 4
	SKIP LASTREC() / VREG
ELSEIF TO>42 .AND. TO<55
	VREG = 6
	SKIP LASTREC() / VREG
ELSEIF TO>56
	VREG = 8
	SKIP LASTREC() / VREG
ENDIF

DBEDIT(01,01,21,77,VCAMPOS,0,0,VCABEC)
PROCEDURE TELA1
@ 00,00 TO 22,60 DOUBLE
@ 01,01 SAY "CODIGO"
@ 01,09 SAY "DESCRIÄ«O"
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
PROCEDURE PRAZO
PARAMETERS VVNOME,VVPLACA,VVEMP,VVDATA,VVCONT
USE PRAZO
APPEND BLANK
	REPLACE NOME WITH VVNOME
	REPLACE PLACA WITH VVPLACA
	REPLACE EMP WITH VVEMP
	REPLACE CONT WITH VCONT_CONT
	REPLACE DATA WITH VVDATA
	REPLACE VALORTOTAL WITH VTOTAL