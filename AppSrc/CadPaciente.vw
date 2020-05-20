// C:\Users\Wilber\Documents\Visual DataFlex Projects\SistemaAgendamentoMedicoPessoalv16\AppSrc\CadPaciente.vw
// Cadastro de Paciente
//

Use DFClient.pkg
Use DFEntry.pkg

Use cPacienteDataDictionary.dd

ACTIVATE_VIEW Activate_oCadPaciente FOR oCadPaciente
Object oCadPaciente is a dbView
    Set Location to 5 5
    Set Size to 63 221
    Set Label To "Cadastro de Paciente"
    Set Border_Style to Border_None
    Set Icon to "cadastro.ico"

    Object oPaciente_DD is a cPacienteDataDictionary
    End_Object // oPaciente_DD

    Set Main_DD To oPaciente_DD
    Set Server  To oPaciente_DD



    Object oPacienteId is a dbForm
        Entry_Item Paciente.Id
        Set Size to 13 42
        Set Location to 14 11
        Set peAnchors to anNone
        Set Label to "ID:"
        Set Label_Justification_mode to JMode_Top
        Set Label_Col_Offset to 0
        Set Label_row_Offset to 0
    End_Object // oPacienteId

    Object oPacienteNome is a dbForm
        Entry_Item Paciente.Nome
        Set Size to 13 191
        Set Location to 39 11
        Set peAnchors to anNone
        Set Label to "Nome:"
        Set Label_Justification_mode to JMode_Top
        Set Label_Col_Offset to 0
        Set Label_row_Offset to 0
    End_Object // oPacienteNome


End_Object // oCadPaciente
