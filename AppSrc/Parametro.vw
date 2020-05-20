// C:\Users\Wilber\Documents\Visual DataFlex Projects\SistemaAgendamentoMedicoPessoalv16\AppSrc\Paramˆtros.vw
// Parametro
//

Use DFClient.pkg
Use DFEntry.pkg

Use cParametrDataDictionary.dd

ACTIVATE_VIEW Activate_oParametro FOR oParametro
Object oParametro is a dbView
    Set Location to 5 5
    Set Size to 98 130
    Set Label To "Paramˆtros"
    Set Border_Style to Border_Thick


    Object oParametr_DD is a cParametrDataDictionary
    End_Object // oParametr_DD

    Set Main_DD To oParametr_DD
    Set Server  To oParametr_DD



    Object oParametrUlt_Id_Usu is a dbForm
        Entry_Item Parametr.Ult_Id_Usu
        Set Size to 13 48
        Set Location to 5 77
        Set peAnchors to anLeftRight
        Set Label to "élt. ID Usuario"
        Set Label_Justification_mode to jMode_Left
        Set Label_Col_Offset to 72
        Set Label_row_Offset to 0
    End_Object // oParametrUlt_Id_Usu

    Object oParametrUlt_Id_Esp is a dbForm
        Entry_Item Parametr.Ult_Id_Esp
        Set Size to 13 48
        Set Location to 20 77
        Set peAnchors to anLeftRight
        Set Label to "élt. ID Especialidade"
        Set Label_Justification_mode to jMode_Left
        Set Label_Col_Offset to 72
        Set Label_row_Offset to 0
    End_Object // oParametrUlt_Id_Esp

    Object oParametrUlt_Id_Med is a dbForm
        Entry_Item Parametr.Ult_Id_Med
        Set Size to 13 48
        Set Location to 35 77
        Set peAnchors to anLeftRight
        Set Label to "élt. ID M‚dico/Exame"
        Set Label_Justification_mode to jMode_Left
        Set Label_Col_Offset to 72
        Set Label_row_Offset to 0
    End_Object // oParametrUlt_Id_Med

    Object oParametrUlt_Id_Loc is a dbForm
        Entry_Item Parametr.Ult_Id_Loc
        Set Size to 13 48
        Set Location to 50 77
        Set peAnchors to anLeftRight
        Set Label to "élt. ID Local"
        Set Label_Justification_mode to jMode_Left
        Set Label_Col_Offset to 72
        Set Label_row_Offset to 0
    End_Object // oParametrUlt_Id_Loc

    Object oParametrUlt_Id_Pac is a dbForm
        Entry_Item Parametr.Ult_Id_Pac
        Set Size to 13 48
        Set Location to 65 77
        Set peAnchors to anLeftRight
        Set Label to "élt. ID Paciente"
        Set Label_Justification_mode to jMode_Left
        Set Label_Col_Offset to 72
        Set Label_row_Offset to 0
    End_Object // oParametrUlt_Id_Pac

    Object oParametrUlt_Id_Age is a dbForm
        Entry_Item Parametr.Ult_Id_Age
        Set Size to 13 48
        Set Location to 80 77
        Set peAnchors to anLeftRight
        Set Label to "élt. ID Agenda"
        Set Label_Justification_mode to jMode_Left
        Set Label_Col_Offset to 72
        Set Label_row_Offset to 0
    End_Object // oParametrUlt_Id_Age


End_Object // oParametro
