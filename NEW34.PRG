***************************
* NEW 34.PRG ESCOLHA TELA *
***************************
SAVE SCREEN TO VTELA_TELA
DO WHILE .T.
		@ 10,24 CLEAR TO 18,56
		@ 10,24 TO 18,56 DOUBLE
		@ 11,26 SAY "( ) 北北北北北北北北北北北北�"
		@ 12,26 SAY "( ) 履谅牧履谅牧履谅牧履谅牧�"
		@ 13,26 SAY "( ) 仕褪送仕褪送仕褪送仕褪送�"
		@ 14,26 SAY "( ) 北北北北北北北北北北北北�"
   	@ 15,26 SAY "( ) 膊膊膊膊膊膊膊膊膊膊膊膊�"
		@ 16,26 SAY "( ) 鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍�"
		@ 17,26 SAY "( ) " + VNOME_CLEBER
*		VOP = MENU(11,7,25,55,.T.,.T.)
		VOP =	MENU_O(10,7,27,CHR(7),VAL(V_TELA))
	IF VOP <> 0
		USE CONFIG
		REPLACE C WITH STR(VOP)
		V_TELA = ALLTRIM(STR(VOP))
		EXIT
	ELSE 
		EXIT
	ENDIF
ENDDO 
RESTORE SCREEN FROM VTELA_TELA
RETURN
