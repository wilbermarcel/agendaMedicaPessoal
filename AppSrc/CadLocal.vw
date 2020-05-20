// C:\Users\Wilber\Documents\Visual DataFlex Projects\SistemaAgendamentoMedicoPessoalv16\AppSrc\CadLocal.vw
// Cadastro de Local
//

Use DFClient.pkg
Use DFEntry.pkg

Use cLocalDataDictionary.dd

ACTIVATE_VIEW Activate_oCadLocal FOR oCadLocal
Object oCadLocal is a dbView
    Set Location to 5 5
    Set Size to 90 342
    Set Label To "Cadastro de Local"
    Set Border_Style to Border_None
    Set Icon to "cadastro.ico"

    Object oLocal_DD is a cLocalDataDictionary
    End_Object // oLocal_DD

    Set Main_DD To oLocal_DD
    Set Server  To oLocal_DD

    Object oLocalId is a dbForm
        Entry_Item Local.Id
        Set Size to 13 42
        Set Location to 14 11
        Set peAnchors to anNone
        Set Label to "ID:"
        Set Label_Justification_mode to JMode_Top
        Set Label_Col_Offset to 0
        Set Label_row_Offset to 0
    End_Object // oLocalId

    Object oLocalDescricao is a dbForm
        Entry_Item Local.Descricao
        Set Size to 13 191
        Set Location to 39 11
        Set peAnchors to anNone
        Set Label to "Descri‡Æo:"
        Set Label_Justification_mode to JMode_Top
        Set Label_Col_Offset to 0
        Set Label_row_Offset to 0
    End_Object // oLocalDescricao

    Object oLocalEndereco is a dbForm
        Entry_Item Local.Endereco
        Set Size to 13 322
        Set Location to 65 11
        Set peAnchors to anNone
        Set Label to "Endere‡o:"
        Set Label_Justification_mode to JMode_Top
        Set Label_Col_Offset to 0
        Set Label_row_Offset to 0
    End_Object // oLocalEndereco


End_Object // oCadLocal
