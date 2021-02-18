*****************************************
*                                       *
* EST4.PRG - APOIO                      *
*                                       *
*****************************************

PRIVATE VTELA,VOPCAO,VOPCOES[5],VMSG[5]

SAVE SCREEN TO VTELA 

VOPCOES[1] = "Cliente       "
VOPCOES[2] = "Produto       "
VOPCOES[3] = "Estoque       "

VMSG[1] = ""
VMSG[2] = ""
VMSG[3] = ""

DO WHILE .T.
	VSIM = .T.
	VHELP = "ASPR1"	
	VOPCAO = SUBMENU (3,VOPCOES,VMSG,1,36,.T.)
	VHELP = "" 
   SAVE SCREEN
	
	DO CASE
		CASE VOPCAO = 0
			EXIT
	
      CASE VOPCAO = 1
			DO NEW411
      CASE VOPCAO = 2
			DO NEW42
		CASE VOPCAO = 3
			DO NEW43      
   ENDCASE

ENDDO
RESTORE SCREEN FROM VTELA

RETURN
