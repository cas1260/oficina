*****************************************
*                                       *
* EST3.PRG - CONFIGURA€åES
*                                       *
*****************************************

PRIVATE VTELA,VOPCAO,VOPCOES[6],VMSG[6]

VCOR=SETCOLOR()

SAVE SCREEN TO VTELA 
VOPCOES[1] = "Personalizacao"
VOPCOES[2] = "Senha"
VOPCOES[3] = "Data & Hora"
VOPCOES[4] = "Tela"

VMSG[1] = "Cabe‡ario,Titulo,Rodape"
VMSG[2] = "Cadastro de Senha"
VMSG[3] = "Data & Hora"
VMSG[4] = "Configura‡äes de Tela"

DO WHILE .T.

	VHELP = "ASPR1"	
	VOPCAO = SUBMENU (4,VOPCOES,VMSG,1,24,.T.)
	VHELP = "" 
   SAVE SCREEN
	
	DO CASE
		CASE VOPCAO = 0
			EXIT
	   CASE VOPCAO = 1
			DO NEW31			
      CASE VOPCAO = 2
			DO NEW32
		CASE VOPCAO = 3
			DO DATA
		CASE VOPCAO = 4
			DO NEW34
   ENDCASE
ENDDO
RESTORE SCREEN FROM VTELA
RETURN
SET COLOR TO &VCOR