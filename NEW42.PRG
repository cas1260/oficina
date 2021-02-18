*****************************************
*                                       *
* EST4.PRG - APOIO                      *
*                                       *
*****************************************

PRIVATE VTELA,VOPCAO,VOPCOES[5],VMSG[5]

SAVE SCREEN TO VTELA 

VOPCOES[1] = "Completo"
VOPCOES[2] = "Basico"

VMSG[1] = ""
VMSG[2] = ""

DO WHILE .T.
	VFIM = .F.
	VHELP = "ASPR1"	
	VOPCAO = SUBMENU (2,VOPCOES,VMSG,3,37,.T.)
	VHELP = "" 
   SAVE SCREEN
	
	DO CASE
		CASE VOPCAO = 0
			EXIT
	
      CASE VOPCAO = 1
				DO RPRODUTO

      CASE VOPCAO = 2
			DO PRODUTOREL			
   
   ENDCASE

ENDDO

RESTORE SCREEN FROM VTELA

RETURN
