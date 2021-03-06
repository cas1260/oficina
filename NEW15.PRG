*********************************************************
* 											                       *
* NEW15.PRG FONTE DE PAGAMENTOS DOS VENCIMENTOS A PRAZO *
*                                                       *
*********************************************************
PRIVATE VCAMPOS[5],VCAB[5],VCOND
PUBLIC VREG,VPLA
*ERASE("VPRAZO.DBF")
CLOSE ALL
COPY FILE("PRAZO.DBF") TO VPRAZO.DBF
SAVE SCREEN TO VTELA_PAGAR
CLOSE ALL
DO WHILE .T.
	USE VPRAZO
	ZAP
	@ 04,05 CLEAR TO 20,75
   @ 04,05  TO 21,75 DOUBLE

	VCAMPOS[1] = "Empresa"
	VCAMPOS[2] = "Placa"
	VCAMPOS[3] = "Valor"
	VCAMPOS[4] = "Motoqueiro"
	VCAMPOS[5] = "Data do Pagamento"

	VCAB[1] = "EMP"
	VCAB[2] = "PLACA"
	VCAB[3] = "VALORTOTAL"
	VCAB[4] = "NOME"
	VCAB[5] = "DATA"

	KEYBOARD CHR(13)
	DBEDIT(05,06,18,74,VCAB,0,0,VCAMPOS)
	@ 19,06 TO 19,74
	VDATAF = DATE()+2
	VDATAI = DATE()
	@ 20,12 SAY "Data Inicial " GET VDATAI 
	@ 20,45 SAY "Data Final " GET VDATAF
	READ
	IF LASTKEY()=27
		EXIT
	ENDIF
	USE PRAZO 
	GO TOP
   VCOND = "VDATAI<=DATA .AND.VDATAF>=DATA .AND. VENDA = .F."
	COPY TO VPRAZO  FOR &VCOND
	USE VPRAZO
	IF EOF()
		MSGBOX("N�o a Contas a Receber")
	ELSE
		USE VPRAZO
		DBEDIT(05,06,18,74,VCAB,0,0,VCAMPOS)
		IF LASTKEY() = 27
			EXIT
		ELSE
			VREG = CONT
			VPLA = PLACA
			CLOSE ALL
			DO REG_PESQ
		ENDIF
	ENDIF
ENDDO
RESTORE SCREEN FROM VTELA_PAGAR
RETURN
******************
PROCEDURE REG_PESQ
******************
PRIVATE VCAMP[5],VCABO[5]
SAVE SCREEN TO VTELA_P

	VCAMP[1] = "Descricao do Produto"
	VCAMP[2] = "Codigo"
	VCAMP[3] = "Valor"

	VCABO[1] = "DES"
	VCABO[2] = "PRODUTO"
	VCABO[3] = "VALORP"

	USE VENDAS
	VCOND = "PLACA=VPLA .AND. CONT = VREG .AND. VENDA = .T."
	COPY TO PPROD FOR &VCOND
	USE PPROD
	IF !EOF()
		VTOTAL = 0
		DO WHILE !EOF()
			VTOTAL = VTOTAL+VALORP
			SKIP
		ENDDO
		@ 08,08 CLEAR TO 20,76
		@ 08,08 TO 21,76 DOUBLE
		@ 20,60 SAY VTOTAL PICT "999,999.99"
		GO TOP
		@ 19,09 TO 19,75
		DBEDIT(09,09,18,75,VCABO,0,0,VCAMP)
		IF LASTKEY()#27
			@ 16,51 CLEAR TO 21,70
			@ 16,51 TO 21,70 DOUBLE
			CENTRA(17,51,70,"Deseja pagar")
			@ 19,55 SAY "( ) SIM"
			@ 20,55 SAY "( ) N�O"
			SIMNAO = MENU_O(19,2,56,CHR(7),0)
			IF SIMNAO = 1
				USE PRAZO
				GO TOP
				DO WHILE !EOF()
					IF VREG = CONT .AND. VPLA = PLACA 
						REPLACE VENDA WITH .T.
						REPLACE CONT WITH 0
					ENDIF
					SKIP
				ENDDO
				USE PPROD
				X = 1  
				DO WHILE !EOF()
					X = X + 1
					SKIP
				ENDDO
				PRIVATE VCOD_P[X+1],VVALOR_P[X+1]
				PA_PA = X
				X = 1
				USE PPROD
				GO TOP
				DO WHILE !EOF()
					VCOD_P[X] = PRODUTO
					VVALOR_P[X] = VALORP
					SKIP
					X = X + 1
				ENDDO
				X = 1
				USE VENDAS
				DO WHILE X<>PA_PA
					IF VCOD_P[X] = PRODUTO .AND. VVALOR_P[X] = VALORP
						REPLACE VENDA WITH .F.
					ENDIF
					SKIP
					IF EOF()
						X = X + 1
						GO TOP
					ENDIF
					IF X = PA_PA
						EXIT
					ENDIF 
				ENDDO
			ENDIF	
		ENDIF
	ENDIF
RESTORE SCREEN FROM VTELA_P
