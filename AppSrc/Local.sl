// Local.sl
// Lista Locais

Use DFClient.pkg
Use cDbCJGridPromptList.pkg
Use cDbCJGridColumn.pkg
Use Windows.pkg

Use cLocalDataDictionary.dd

CD_Popup_Object Local_sl is a dbModalPanel
    Set Location to 5 5
    Set Size to 134 356
    Set Label To "Lista Locais"
    Set Border_Style to Border_Thick
    Set Minimize_Icon to False


    Object oLocal_DD is a cLocalDataDictionary
    End_Object // oLocal_DD

    Set Main_DD To oLocal_DD
    Set Server  To oLocal_DD



    Object oSelList is a cDbCJGridPromptList
        Set Size to 105 346
        Set Location to 5 5
        Set peAnchors to anAll
        Set psLayoutSection to "Local_sl_oSelList"
        Set Ordering to 1
        Set pbAutoServer to True

        Object oLocal_Id is a cDbCJGridColumn
            Entry_Item Local.Id
            Set piWidth to 54
            Set psCaption to "ID"
        End_Object // oLocal_Id

        Object oLocal_Descricao is a cDbCJGridColumn
            Entry_Item Local.Descricao
            Set piWidth to 225
            Set psCaption to "Descri‡Æo"
        End_Object // oLocal_Descricao

        Object oLocal_Endereco is a cDbCJGridColumn
            Entry_Item Local.Endereco
            Set piWidth to 225
            Set psCaption to "Endere‡o"
        End_Object // oLocal_Endereco


    End_Object // oSelList

    Object oOk_bn is a Button
        Set Size to 17 48
        Set Label to "&Ok"
        Set Location to 115 194
        Set peAnchors to anBottomRight
        Set Bitmap to "ok.bmp"

        Procedure OnClick
            Send OK of oSelList
        End_Procedure

    End_Object // oOk_bn
    Object oCancel_bn is a Button
        Set Size to 17 48
        Set Label to "&Cancel"
        Set Location to 115 248
        Set peAnchors to anBottomRight
        Set Bitmap to "cancelar.bmp"

        Procedure OnClick
            Send Cancel of oSelList
        End_Procedure

    End_Object // oCancel_bn
    Object oSearch_bn is a Button
        Set Size to 17 48
        Set Label to "&Search..."
        Set Location to 115 302
        Set peAnchors to anBottomRight
        Set Bitmap to "procurar.bmp"

        Procedure OnClick
            Send Search of oSelList
        End_Procedure

    End_Object // oSearch_bn

    On_Key Key_Alt+Key_O Send KeyAction of oOk_bn
    On_Key Key_Alt+Key_C Send KeyAction of oCancel_bn
    On_Key Key_Alt+Key_S Send KeyAction of oSearch_bn


CD_End_Object // Local_sl
