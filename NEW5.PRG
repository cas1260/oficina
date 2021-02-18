*****************************************
*                                       *
* NEW5.PRG - APOIO                      *
*                                       *
*****************************************

PRIVATE VTELA,VOPCAO,VOPCOES[6],VMSG[6]
SAVE SCREEN TO VTELA
VOPCOES[1] = "Reorganizacao "
VOPCOES[2] = "Salvar"
VOPCOES[3] = "Manutecao"

VMSG[1] = "Reorganizacao de arquivos de dados"
VMSG[2] = "Copia de seguranca dos arquivos de dados"
VMSG[3] = "Manutecao do Programa" 


DO WHILE .T.
	VSIM = .T.
	VHELP = "ASPR1"	
	VOPCAO = SUBMENU (3,VOPCOES,VMSG,01,48,.T.)
	VHELP = "" 
   SAVE SCREEN
	
	DO CASE
		CASE VOPCAO = 0
			EXIT
	
      CASE VOPCAO = 1
			DO NEW51
      CASE VOPCAO = 2
			DO NEW52
		CASE VOPCAO = 3
			DO NEW54
		CASE VOPCAO = 5
   ENDCASE

ENDDO
RESTORE SCREEN FROM VTELA
RETURN
