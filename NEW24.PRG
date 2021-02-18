*******************************************
* FONTE DE CONTROLE DE PRODUTOS A COMPRAR *
*******************************************

SAVE SCREEN TO VTELA_A
DO WHILE .T.
	USE PRODUTO INDEX PRODUTO1 INDEX PRODUTO2
	@ 05,03 CLEAR TO 19,77
	@ 05,03 TO 19,77 DOUBLE
	VCODP=SPACE(5)
	SET KEY -1 TO HIDE
	@ 06,04 SAY "CODIGO    " GET VCODP PICT "99999" VALID .NOT. EMPT(VCODP)
	READ
	SET KEY -1 TO
	IF LASTKEY() = 27
		EXIT
	ENDIF
	IF LASTKEY()#27
		USE PRODUTO INDEX PRODUTO1 INDEX PRODUTO2
		VCODP=STRZERO(VAL(VCODP),5)
		SEEK VCODP
		IF EOF()
			MSGBOX("Produto nao Encontrado!")
		ELSE
			@ 06,04 SAY "CODIGO   : " + VCODP 
			@ 08,04 SAY "Descricao: " + DESCRICAO
			@ 10,04 SAY "Minimo de Qtd. no Estoque: "+STR(CONT)
			@ 12,04 SAY "QTD.                     : "+STR(QTD)
			VTOTAL=CONT-QTD
			VV_VALOR = VALORC
			IF VTOTAL<0
				@ 14,04 SAY "N§ A Compra              :  Nao e Preciso Compra , Produto Sobrando"
*				VTOTAL=VAL(VTOTAL)
				VTOTAL=STRZERO(VTOTAL,25)
				VTOTAL=RIGHT(VTOTAL,LEN(VTOTAL)-1)
				VTOTAL=VAL(VTOTAL)
				VTOTAL=STR(VTOTAL)
				SET CURSO OFF
				@ 16,04 SAY "Voce Tem                 : " + VTOTAL
				INKEY(0)
				SET CURSO ON
				PP=.F.
			ELSE
				@ 14,04 SAY "N§ A Compra              : " + STR(VTOTAL)
				TTA_A = QTD
				VQTD = 0
				@ 16,04 SAY "Valor de Compra " 
				@ 16,30 SAY VV_VALOR PICT "999,999.99"
				@ 17,04 SAY "Quantas Voce Comprou     : " GET VQTD PICT "9999999999"
				READ
				PP=.T.
			ENDIF
			IF LASTKEY() = 27
				EXIT
			ENDIF
			IF LASTKEY()#27 
				IF PP=.T.
					IF VQTD<>0
						@ 16,40 CLEAR TO 19,65
						@ 16,40 TO 19,65
						CENTRA(17,40,65,"Confimar Grava‡ao")
						@ 18,45 PROMPT " SIM "
						@ 18,53 PROMPT " NAO "
						MENU TO VOP
							DO CASE 
								CASE VOP=0
									EXIT
								CASE VOP=1
									REPLACE QTD WITH TTA_A + VQTD
							ENDCASE
					ENDIF
				ENDIF
			ENDIF
		ENDIF
	ENDIF
ENDDO
RESTORE SCREEN FROM VTELA_A		
RETURN
