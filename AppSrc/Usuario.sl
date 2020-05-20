// Usuario.sl
// Lista Usu rios

Use DFClient.pkg
Use cDbCJGridPromptList.pkg
Use cDbCJGridColumn.pkg
Use Windows.pkg

Use cUsuarioDataDictionary.dd

CD_Popup_Object Usuario_sl is a dbModalPanel
    Set Location to 5 5
    Set Size to 134 254
    Set Label To "Lista Usu rios"
    Set Border_Style to Border_Thick
    Set Minimize_Icon to False


    Object oUsuario_DD is a cUsuarioDataDictionary
    End_Object // oUsuario_DD

    Set Main_DD To oUsuario_DD
    Set Server  To oUsuario_DD



    Object oSelList is a cDbCJGridPromptList
        Set Size to 105 244
        Set Location to 5 5
        Set peAnchors to anAll
        Set psLayoutSection to "Usuario_sl_oSelList"
        Set Ordering to 1
        Set pbAutoServer to True

        Object oUsuario_Id is a cDbCJGridColumn
            Entry_Item Usuario.Id
            Set piWidth to 54
            Set psCaption to "ID"
        End_Object // oUsuario_Id

        Object oUsuario_Nome is a cDbCJGridColumn
            Entry_Item Usuario.Nome
            Set piWidth to 225
            Set psCaption to "Nome"
        End_Object // oUsuario_Nome

        Object oUsuario_Senha is a cDbCJGridColumn
            Entry_Item Usuario.Senha
            Set piWidth to 72
            Set psCaption to "Senha"
        End_Object // oUsuario_Senha


    End_Object // oSelList

    Object oOk_bn is a Button
        Set Size to 17 48
        Set Label to "&Ok"
        Set Location to 115 91
        Set peAnchors to anBottomRight
        Set Bitmap to "ok.bmp"

        Procedure OnClick
            Send OK of oSelList
        End_Procedure

    End_Object // oOk_bn

    Object oCancel_bn is a Button
        Set Size to 17 48
        Set Label to "&Cancel"
        Set Location to 115 145
        Set peAnchors to anBottomRight
        Set Bitmap to "cancelar.bmp"

        Procedure OnClick
            Send Cancel of oSelList
        End_Procedure

    End_Object // oCancel_bn

    Object oSearch_bn is a Button
        Set Size to 17 48
        Set Label to "&Search..."
        Set Location to 115 199
        Set peAnchors to anBottomRight
        Set Bitmap to "procurar.bmp"

        Procedure OnClick
            Send Search of oSelList
        End_Procedure

    End_Object // oSearch_bn

    On_Key Key_Alt+Key_O Send KeyAction of oOk_bn
    On_Key Key_Alt+Key_C Send KeyAction of oCancel_bn
    On_Key Key_Alt+Key_S Send KeyAction of oSearch_bn


CD_End_Object // Usuario_sl
