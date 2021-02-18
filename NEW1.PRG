*****************************************
*                                       *
* EST4.PRG - APOIO                      *
*                                       *
*****************************************

PRIVATE VTELA,VOPCAO,VOPCOES[5],VMSG[5]

SAVE SCREEN TO VTELA 

VOPCOES[1] = "Vendas "
VOPCOES[2] = "Orcamento"
VOPCOES[3] = "Rei-Imprime   "
VOPCOES[4] = "Caixa"
VOPCOES[5] = "Pagar"

VMSG[1] = "Vendas "
VMSG[2] = "Orcamento de Pecas"
VMSG[3] = "Rei-Imprime"
VMSG[4] = "Fechamento do Caixa"
VMSG[5] = "Pagar Contas a Prazo"

DO WHILE .T.
	VSIM = .T.
	VHELP = "ASPR1"	
	VOPCAO = SUBMENU (5,VOPCOES,VMSG,01,00,.T.)
	VHELP = "" 
   SAVE SCREEN
	DO CASE

		CASE VOPCAO = 0
			EXIT
	
		CASE VOPCAO = 1	
			DO NEW11
		CASE VOPCAO = 2
			DO NEW12
      CASE VOPCAO = 3
			DO NEW13
		CASE VOPCAO = 4
			DO NEW14
		CASE VOPCAO = 5
			DO NEW15
   ENDCASE

ENDDO

RESTORE SCREEN FROM VTELA
RETURN
SET COLOR TO &VCOR