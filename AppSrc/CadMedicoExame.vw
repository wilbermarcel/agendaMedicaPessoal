// C:\Users\Wilber\Documents\Visual DataFlex Projects\SistemaAgendamentoMedicoPessoalv16\AppSrc\CadMedicoExame.vw
// Cadastro de M‚dico/Exame
//

Use DFClient.pkg
Use DFEntry.pkg

Use cEspecialDataDictionary.dd
Use cMedexameDataDictionary.dd

ACTIVATE_VIEW Activate_oCadMedicoExame FOR oCadMedicoExame
Object oCadMedicoExame is a dbView
    Set Location to 5 5
    Set Size to 134 247
    Set Label To "Cadastro de M‚dico/Exame"
    Set Border_Style to Border_None
    Set Icon to "cadastro.ico"
    
    Object oEspecial_DD is a cEspecialDataDictionary
    End_Object // oEspecial_DD

    Object oMedexame_DD is a cMedexameDataDictionary
        Set DDO_Server to oEspecial_DD
    End_Object // oMedexame_DD

    Set Main_DD To oMedexame_DD
    Set Server  To oMedexame_DD

    Object oMedexameId is a dbForm
        Entry_Item Medexame.Id
        Set Size to 13 42
        Set Location to 14 11
        Set peAnchors to anNone
        Set Label to "ID:"
        Set Label_Justification_mode to JMode_Top
        Set Label_Col_Offset to 0
        Set Label_row_Offset to 0
    End_Object // oMedexameId

    Object oMedexameNome is a dbForm
        Entry_Item Medexame.Nome
        Set Size to 13 191
        Set Location to 39 11
        Set peAnchors to anNone
        Set Label to "Nome:"
        Set Label_Justification_mode to JMode_Top
        Set Label_Col_Offset to 0
        Set Label_row_Offset to 0
    End_Object // oMedexameNome

    Object oEspecialId is a dbForm
        Entry_Item Especial.Id
        Set Size to 13 42
        Set Location to 65 11
        Set peAnchors to anNone
        Set Label to "Especialidade:"
        Set Label_Justification_mode to JMode_Top
        Set Label_Col_Offset to 0
        Set Label_row_Offset to 0
    End_Object // oEspecialId

    Object oEspecialDescricao is a dbForm
        Entry_Item Especial.Descricao
        Set Size to 13 172
        Set Location to 65 60
        Set peAnchors to anNone
        
        Set Label_Justification_mode to jMode_Left
        Set Label_Col_Offset to 34
        Set Label_row_Offset to 0
        Set Enabled_State to False
    End_Object // oEspecialDescricao

    Object oLocalId is a dbForm
        //Entry_Item Local.Id
        Entry_Item MEDEXAME.ID_LOC
        Set Size to 13 42
        Set Location to 91 11
        Set peAnchors to anNone
        Set Label to "Local:"
        Set Label_Justification_mode to JMode_Top
        Set Label_Col_Offset to 0
        Set Label_row_Offset to 0
        Set Prompt_Button_Mode to PB_PromptOn
        Set Prompt_Object to Local_norelate_sl
        
        Procedure OnChange
            Clear LOCAL
            Move (Value(Self)) to LOCAL.ID
            Find eq LOCAL by Index.1
            Set Value of oLocalDescricao to (Trim(LOCAL.DESCRICAO))
            Set Value of oLocalEndereco  to (Trim(LOCAL.ENDERECO))
        End_Procedure
    End_Object // oLocalId

    Object oLocalDescricao is a dbForm
//        Entry_Item Local.Descricao
        Set Size to 13 172
        Set Location to 91 60
        Set peAnchors to anNone
        Set Label_Justification_mode to jMode_Left
        Set Label_Col_Offset to 34
        Set Label_row_Offset to 0
        Set Enabled_State to False
    End_Object // oLocalDescricao

    Object oLocalEndereco is a dbForm
//        Entry_Item Local.Endereco
        Set Size to 13 221
        Set Location to 108 11
        Set peAnchors to anNone
        Set Label_Justification_mode to jMode_Left
        Set Label_Col_Offset to 0
        Set Label_row_Offset to 0
        Set Enabled_State to False
    End_Object // oLocalEndereco
End_Object 
