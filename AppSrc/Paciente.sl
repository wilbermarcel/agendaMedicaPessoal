// Paciente.sl
// Lista Pacientes

Use DFClient.pkg
Use cDbCJGridPromptList.pkg
Use cDbCJGridColumn.pkg
Use Windows.pkg

Use cPacienteDataDictionary.dd

CD_Popup_Object Paciente_sl is a dbModalPanel
    Set Location to 5 5
    Set Size to 134 206
    Set Label To "Lista Pacientes"
    Set Border_Style to Border_Thick
    Set Minimize_Icon to False


    Object oPaciente_DD is a cPacienteDataDictionary
    End_Object // oPaciente_DD

    Set Main_DD To oPaciente_DD
    Set Server  To oPaciente_DD



    Object oSelList is a cDbCJGridPromptList
        Set Size to 105 196
        Set Location to 5 5
        Set peAnchors to anAll
        Set psLayoutSection to "Paciente_sl_oSelList"
        Set Ordering to 1
        Set pbAutoServer to True

        Object oPaciente_Id is a cDbCJGridColumn
            Entry_Item Paciente.Id
            Set piWidth to 54
            Set psCaption to "ID"
        End_Object // oPaciente_Id

        Object oPaciente_Nome is a cDbCJGridColumn
            Entry_Item Paciente.Nome
            Set piWidth to 225
            Set psCaption to "Nome"
        End_Object // oPaciente_Nome


    End_Object // oSelList

    Object oOk_bn is a Button
        Set Size to 17 48
        Set Label to "&Ok"
        Set Location to 115 45
        Set peAnchors to anBottomRight
        Set Bitmap to "ok.bmp"

        Procedure OnClick
            Send OK of oSelList
        End_Procedure

    End_Object // oOk_bn
    Object oCancel_bn is a Button
        Set Size to 17 48
        Set Label to "&Cancel"
        Set Location to 115 99
        Set peAnchors to anBottomRight
        Set Bitmap to "cancelar.bmp"

        Procedure OnClick
            Send Cancel of oSelList
        End_Procedure

    End_Object // oCancel_bn
    Object oSearch_bn is a Button
        Set Size to 17 48
        Set Label to "&Search..."
        Set Location to 115 153
        Set peAnchors to anBottomRight
        Set Bitmap to "procurar.bmp"

        Procedure OnClick
            Send Search of oSelList
        End_Procedure

    End_Object // oSearch_bn

    On_Key Key_Alt+Key_O Send KeyAction of oOk_bn
    On_Key Key_Alt+Key_C Send KeyAction of oCancel_bn
    On_Key Key_Alt+Key_S Send KeyAction of oSearch_bn


CD_End_Object // Paciente_sl
