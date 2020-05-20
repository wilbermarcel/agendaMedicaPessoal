// C:\Users\Wilber\Documents\Visual DataFlex Projects\SistemaAgendamentoMedicoPessoalv16\AppSrc\CadUsuarios.vw
// Cadastro de Usu rios
//

Use DFClient.pkg
Use DFEntry.pkg

Use cUsuarioDataDictionary.dd

Activate_View Activate_oCadUsuario for oCadUsuario  
Object oCadUsuario is a dbView
    Set Location to 14 17
    Set Size to 65 263
    Set Label to "Cadastro de Usu rio"
    Set Border_Style to Border_None
    Set peAnchors to anNone
    Set Icon to "cadastro.ico"
    
    Object oUsuario_DD is a cUsuarioDataDictionary
    End_Object // oUsuario_DD

    Set Main_DD To oUsuario_DD
    Set Server  To oUsuario_DD



    Object oUsuarioId is a dbForm
        Entry_Item Usuario.Id
        Set Size to 13 42
        Set Location to 14 11
        Set peAnchors to anNone
        Set Label to "ID:"
        Set Label_Justification_mode to JMode_Top
        Set Label_Col_Offset to 0
        Set Label_row_Offset to 0
    End_Object // oUsuarioId

    Object oUsuarioNome is a dbForm
        Entry_Item Usuario.Nome
        Set Size to 13 191
        Set Location to 39 11
        Set peAnchors to anNone
        Set Label to "Nome:"
        Set Label_Justification_mode to JMode_Top
        Set Label_Col_Offset to 0
        Set Label_row_Offset to 0
    End_Object // oUsuarioNome

    Object oUsuarioSenha is a dbForm
        Entry_Item Usuario.Senha
        Set Size to 13 48
        Set Location to 39 206
        Set peAnchors to anNone
        Set Label to "Senha:"
        Set Label_Justification_mode to JMode_Top
        Set Label_Col_Offset to 0
        Set Label_row_Offset to 0
        Set Password_State to True
    End_Object // oUsuarioSenha


End_Object // oCadUsuarios
