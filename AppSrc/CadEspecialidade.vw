// C:\Users\Wilber\Documents\Visual DataFlex Projects\SistemaAgendamentoMedicoPessoalv16\AppSrc\CadEspecialidades.vw
// Cadastro de Especialidades
//

Use DFClient.pkg
Use DFEntry.pkg

Use cEspecialDataDictionary.dd

Activate_View Activate_oCadEspecialidade for oCadEspecialidade
Object oCadEspecialidade is a dbView
    Set Location to 4 5
    Set Size to 61 216
    Set Label to "Cadastro de Especialidade"
    Set Border_Style to Border_None
    Set peAnchors to anNone
    Set Icon to "cadastro.ico"

    Object oEspecial_DD is a cEspecialDataDictionary
    End_Object // oEspecial_DD

    Set Main_DD To oEspecial_DD
    Set Server  To oEspecial_DD

    Object oEspecialId is a dbForm
        Entry_Item Especial.Id
        Set Size to 13 42
        Set Location to 14 11
        Set peAnchors to anNone
        Set Label to "ID:"
        Set Label_Justification_mode to JMode_Top
        Set Label_Col_Offset to 0
        Set Label_row_Offset to 0
    End_Object // oEspecialId

    Object oEspecialDescricao is a dbForm
        Entry_Item Especial.Descricao
        Set Size to 13 191
        Set Location to 39 11
        Set peAnchors to anNone
        Set Label to "Descri‡Æo:"
        Set Label_Justification_mode to JMode_Top
        Set Label_Col_Offset to 0
        Set Label_row_Offset to 0
    End_Object // oEspecialDescricao


End_Object // oCadEspecialidades
