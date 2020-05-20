// Agenda.sl
// Lista Agendas

Use DFClient.pkg
Use cDbCJGridPromptList.pkg
Use cDbCJGridColumn.pkg
Use Windows.pkg

Use cEspecialDataDictionary.dd
Use cLocalDataDictionary.dd
Use cMedexameDataDictionary.dd
Use cPacienteDataDictionary.dd
Use cAgendaDataDictionary.dd

CD_Popup_Object Agenda_sl is a dbModalPanel
    Set Location to 5 5
    Set Size to 134 610
    Set Label To "Lista Agendas"
    Set Border_Style to Border_Thick
    Set Minimize_Icon to False


    Object oEspecial_DD is a cEspecialDataDictionary
    End_Object // oEspecial_DD

    Object oLocal_DD is a cLocalDataDictionary
    End_Object // oLocal_DD

    Object oMedexame_DD is a cMedexameDataDictionary
        Set DDO_Server To oEspecial_DD
        Set DDO_Server To oLocal_DD
    End_Object // oMedexame_DD

    Object oPaciente_DD is a cPacienteDataDictionary
    End_Object // oPaciente_DD

    Object oAgenda_DD is a cAgendaDataDictionary
        Set DDO_Server To oMedexame_DD
        Set DDO_Server To oPaciente_DD
    End_Object // oAgenda_DD

    Set Main_DD To oAgenda_DD
    Set Server  To oAgenda_DD



    Object oSelList is a cDbCJGridPromptList
        Set Size to 105 600
        Set Location to 5 5
        Set peAnchors to anAll
        Set psLayoutSection to "Agenda_sl_oSelList"
        Set Ordering to 1
        Set pbAutoServer to True

        Object oAgenda_Id is a cDbCJGridColumn
            Entry_Item Agenda.Id
            Set piWidth to 35
            Set psCaption to "ID"
        End_Object // oAgenda_Id

        Object oAgenda_Data is a cDbCJGridColumn
            Entry_Item Agenda.Data
            Set piWidth to 58
            Set psCaption to "Data"
        End_Object // oAgenda_Data

        Object oAgenda_Hora is a cDbCJGridColumn
            Entry_Item Agenda.Hora
            Set piWidth to 43
            Set psCaption to "Hora"
        End_Object // oAgenda_Hora

        Object oAgenda_Fl_Status is a cDbCJGridColumn
            Entry_Item Agenda.Fl_Status
            Set piWidth to 67
            Set psCaption to "Status"
            Set pbComboButton to True
        End_Object // oAgenda_Fl_Status

        Object oPaciente_Nome is a cDbCJGridColumn
            Entry_Item Paciente.Nome
            Set piWidth to 138
            Set psCaption to "Paciente"
        End_Object // oPaciente_Nome

        Object oMedexame_Nome is a cDbCJGridColumn
            Entry_Item Medexame.Nome
            Set piWidth to 138
            Set psCaption to "M‚dico/Exame"
        End_Object // oMedexame_Nome

        Object oEspecial_Descricao is a cDbCJGridColumn
            Entry_Item Especial.Descricao
            Set piWidth to 139
            Set psCaption to "Especialidade"
        End_Object // oEspecial_Descricao

        Object oLocal_Descricao is a cDbCJGridColumn
            Entry_Item Local.Descricao
            Set piWidth to 141
            Set psCaption to "Local"
        End_Object // oLocal_Descricao

        Object oLocal_Endereco is a cDbCJGridColumn
            Entry_Item Local.Endereco
            Set piWidth to 141
            Set psCaption to "Endere‡o"
        End_Object // oLocal_Endereco


    End_Object // oSelList

    Object oOk_bn is a Button
        Set Size to 17 48
        Set Label to "&Ok"
        Set Location to 115 449
        Set peAnchors to anBottomRight
        Set Bitmap to "ok.bmp"

        Procedure OnClick
            Send OK of oSelList
        End_Procedure

    End_Object // oOk_bn
    Object oCancel_bn is a Button
        Set Size to 17 48
        Set Label to "&Cancel"
        Set Location to 115 503
        Set peAnchors to anBottomRight
        Set Bitmap to "cancelar.bmp"

        Procedure OnClick
            Send Cancel of oSelList
        End_Procedure

    End_Object // oCancel_bn
    Object oSearch_bn is a Button
        Set Size to 17 48
        Set Label to "&Search..."
        Set Location to 115 557
        Set peAnchors to anBottomRight
        Set Bitmap to "procurar.bmp"

        Procedure OnClick
            Send Search of oSelList
        End_Procedure

    End_Object // oSearch_bn

    On_Key Key_Alt+Key_O Send KeyAction of oOk_bn
    On_Key Key_Alt+Key_C Send KeyAction of oCancel_bn
    On_Key Key_Alt+Key_S Send KeyAction of oSearch_bn


CD_End_Object // Agenda_sl
