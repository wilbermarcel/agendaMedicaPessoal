// C:\Users\Wilber\Documents\Visual DataFlex Projects\SistemaAgendamentoMedicoPessoalv16\AppSrc\ConsAgenda.vw
// Consulta Agenda
//

Use DFClient.pkg
Use DFEntry.pkg

Use cEspecialDataDictionary.dd
Use cLocalDataDictionary.dd
Use cMedexameDataDictionary.dd
Use cPacienteDataDictionary.dd
Use cAgendaDataDictionary.dd
Use cDbCJGrid.pkg
Use cCJGridColumnRowIndicator.pkg
Use dfallent.pkg
Use Windows.pkg

ACTIVATE_VIEW Activate_oConsAgenda FOR oConsAgenda
Object oConsAgenda is a dbView
    Set Location to 4 5
    Set Size to 313 580
    Set Label To "Consulta Agenda"
    Set Border_Style to Border_None
    Set Icon to "agenda3.ico"
    
    Property Boolean pbUmCliqueGridConsAgenda (False)
        
    Object oEspecial_DD is a cEspecialDataDictionary
    End_Object // oEspecial_DD

    Object oLocal_DD is a cLocalDataDictionary
    End_Object // oLocal_DD

    Object oMedexame_DD is a cMedexameDataDictionary
        Set DDO_Server To oEspecial_DD
        Set DDO_Server to oLocal_DD
                
        Procedure OnConstrain
            Forward Send OnConstrain
            Integer iEspecialidade iLocal
            Get Value of (oForm3(oDbGroup6(Self))) to iEspecialidade
            Get Value of (oForm3(oDbGroup7(Self))) to iLocal
            If (iEspecialidade>0) Constrain MEDEXAME.ID_ESP eq iEspecialidade
            If (iLocal        >0) Constrain MEDEXAME.ID_LOC eq iLocal
        End_Procedure
    End_Object // oMedexame_DD
    
    Object oPaciente_DD is a cPacienteDataDictionary
    End_Object // oPaciente_DD
    
    Object oAgenda_DD is a cAgendaDataDictionary
        Set DDO_Server To oMedexame_DD
        Set DDO_Server to oPaciente_DD
        
        Procedure OnConstrain
            Forward Send OnConstrain
            String sDataDe sDataAte sStatus
            Integer iPaciente iMedicoExame
            Get Value of (oForm1     (oDbGroup3(Self))) to sDataDe
            Get Value of (oForm2     (oDbGroup3(Self))) to sDataAte
            Get Value of (oComboForm1(oDbGroup4(Self))) to sStatus
            Get Value of (oForm3     (oDbGroup5(Self))) to iPaciente
            Get Value of (oForm3     (oDbGroup8(Self))) to iMedicoExame
            Move (Mid(sStatus, 1, 2)) to sStatus
            
            If (sDataDe   > "") Constrain AGENDA.DATA      ge sDataDe
            If (sDataAte   >"") Constrain AGENDA.DATA      le sDataAte
            If (sStatus<>'T' and sStatus<>'') Constrain AGENDA.FL_STATUS eq sStatus
            If (iPaciente   >0) Constrain AGENDA.ID_PAC    eq iPaciente
            If (iMedicoExame>0) Constrain AGENDA.ID_MEDEX  eq iMedicoExame
        End_Procedure
    End_Object // oAgenda_DD

    Set Main_DD To oAgenda_DD
    Set Server  To oAgenda_DD

    Object oDbCJGrid1 is a cDbCJGrid
        Set Size to 127 566
        Set Location to 33 6
        
        Set piFreezeColumnsCount             to 3
        Set pbAllowColumnReorder             to True
        Set pbAllowInsertRow                 to False
        Set pbSelectionEnable                to True
        Set piHighlightBackColor             to 16303535
        Set pbUseAlternateRowBackgroundColor to True
        Set piFocusCellBackColor             to 13369082
        Set piFocusCellForeColor             to clBlack
        Set pbEditOnClick                    to True
        Set pbEditOnKeyNavigation            to True
        Set pbHeaderReorders                 to True
        Set pbHeaderTogglesDirection         to True
        Set peColumnStyle                    to xtpColumnOffice2007
        Set pbAutoColumnSizing               to False
        Set piHighlightForeColor             to 13959693
        Set psNoItemsText to (Character (13) + "Sem Registros para exibir!")
        
        Procedure OnRowDoubleClick Integer iRow Integer iCol
            Send Activate_ocadAgenda of (ClientAreaObject(ghoCommandBars))
        End_Procedure
        
        Procedure OnHeaderClick Integer iCol
            Forward Send OnHeaderClick iCol
            If      (iCol = 1) Send ChangeOrdering 1 False
            Else If (iCol = 2) Begin
                If (pbUmCliqueGridConsAgenda(Self)) Send DoSelectNone of oDbCJGridSelectColumn1
                Else                                Send DoSelectAll  of oDbCJGridSelectColumn1
                Set pbUmCliqueGridConsAgenda to (not(pbUmCliqueGridConsAgenda(Self)))
            End
            Else If (iCol = 6) Send ChangeOrdering 2 False
            Else If (iCol = 7) Send ChangeOrdering 4 False
            Else If (iCol = 3 or iCol = 4) Send ChangeOrdering 3 False
        End_Procedure
        
        Object oCJGridColumnRowIndicator1 is a cCJGridColumnRowIndicator
            Set piWidth to 31
        End_Object
        
        Object oAGENDA_ID is a cDbCJGridColumn
            Entry_Item AGENDA.ID
            Set piWidth to 38
            Set psCaption to "ID"
            Set pbEditable to False
        End_Object
        
        Object oDbCJGridSelectColumn1 is a cDbCJGridSelectColumn
            Set piWidth to 48
            Set psCaption to "Marcar"
        End_Object

        Object oAGENDA_DATA is a cDbCJGridColumn
            Entry_Item AGENDA.DATA
            Set piWidth to 69
            Set psCaption to "Data"
            Set pbEditable to False
        End_Object
        
        Object oAGENDA_HORA is a cDbCJGridColumn
            Entry_Item AGENDA.HORA
            Set piWidth to 52
            Set psCaption to "Hora"
            Set pbEditable to False
            Set peTextAlignment to xtpAlignmentCenter
        End_Object

        Object oAGENDA_FL_STATUS is a cDbCJGridColumn
            Entry_Item AGENDA.FL_STATUS
            Set piWidth to 70
            Set psCaption to "Status"
            Set pbComboButton to True
            Set pbEditable to False
        End_Object

        Object oPACIENTE_NOME is a cDbCJGridColumn
            Entry_Item PACIENTE.NOME
            Set piWidth to 83
            Set psCaption to "Paciente"
            Set pbEditable to False
        End_Object

        Object oMEDEXAME_NOME is a cDbCJGridColumn
            Entry_Item MEDEXAME.NOME
            Set piWidth to 108
            Set psCaption to "M‚dico/Exame"
            Set pbEditable to False
        End_Object

        Object oESPECIAL_DESCRICAO is a cDbCJGridColumn
            Entry_Item ESPECIAL.DESCRICAO
            Set piWidth to 130
            Set psCaption to "Especialidade"
            Set pbEditable to False
        End_Object

        Object oLOCAL_DESCRICAO is a cDbCJGridColumn
//            Entry_Item LOCAL.DESCRICAO
            Set piWidth to 177
            Set psCaption to "Local"
            Set pbEditable to False
            
            Procedure OnSetCalculatedValue String ByRef sValue
                Clear LOCAL
                Move AGENDA.ID_LOC to LOCAL.ID
                Find eq LOCAL by Index.1
                Move (Trim(LOCAL.DESCRICAO)) to sValue
            End_Procedure
        End_Object

        Object oLOCAL_ENDERECO is a cDbCJGridColumn
//            Entry_Item LOCAL.ENDERECO
            Set piWidth to 272
            Set psCaption to "Endere‡o"
            Set pbEditable to False
            
            Procedure OnSetCalculatedValue String ByRef sValue
                Clear LOCAL
                Move AGENDA.ID_LOC to LOCAL.ID
                Find eq LOCAL by Index.1
                Move (Trim(LOCAL.ENDERECO)) to sValue
            End_Procedure
        End_Object
        
        Object oAGENDA_OBS is a cDbCJGridColumn
            Entry_Item AGENDA.OBS
            Set piWidth to 500
            Set psCaption to "Observa‡Æo"
            Set pbEditable to False
        End_Object
        
        Object oAgenda_RECNUM is a cDbCJGridColumn
            Entry_Item AGENDA.Recnum
            Set pbEditable to False
            Set pbVisible  to False
        End_Object
        
        Function CanEditColumn Integer iCol Returns Boolean
            Integer iRecnum
            Boolean bCanDo
            Forward Get CanEditColumn iCol to bCanDo
            If (bCanDo) Begin
                Get SelectedRowValue of oAgenda_RECNUM to iRecnum
                If (iRecnum=0) Move False to bCanDo
            End
            Function_Return bCanDo
        End_Function
    End_Object

    Object oDbGroup1 is a dbGroup
        Set Size to 135 567
        Set Location to 164 6
        Set Label to "Filtros"

        Object oDbGroup3 is a dbGroup
            Set Size to 36 155
            Set Location to 8 7
            Set Label to "Data:"

            Object oForm1 is a cHighLightForm
                Set Size to 13 61
                Set Location to 17 11
                Set Form_Datatype to Mask_Date_Window
                Set Label to "De:"
                Set Label_Col_Offset to 0
                Set Label_Justification_Mode to JMode_Top
            
                //OnChange is called on every changed character
            
                //Procedure OnChange
                //    String sValue
                //
                //    Get Value to sValue
                //End_Procedure
            
            End_Object

            Object oForm2 is a cHighLightForm
                Set Size to 13 61
                Set Location to 17 81
                Set Form_Datatype to Mask_Date_Window
                Set Label to "At‚:"
                Set Label_Col_Offset to 0
                Set Label_Justification_Mode to JMode_Top
            
                //OnChange is called on every changed character
            
                //Procedure OnChange
                //    String sValue
                //
                //    Get Value to sValue
                //End_Procedure
            
            End_Object
        End_Object

        Object oDbGroup4 is a dbGroup
            Set Size to 36 102
            Set Location to 9 166
            Set Label to "Status"

            Object oComboForm1 is a cHighLightComboForm
                Set Size to 13 75
                Set Location to 14 12
                Set Entry_State to False
                Set Combo_Sort_State to False
                //Combo_Fill_List is called when the list needs filling
            
                Procedure Combo_Fill_List
                    Send Combo_Add_Item "[T] - Todos"
                    Send Combo_Add_Item "[M] - Marcado"
                    Send Combo_Add_Item "[A] - Agendar"
                    Send Combo_Add_Item "[S] - Conclu¡do"
                    Send Combo_Add_Item "[C] - Cancelado"
                End_Procedure
            
                //OnChange is called on every changed character
            
                //Procedure OnChange
                //    String sValue
                //
                //    Get Value To sValue // the current selected item
                //End_Procedure
            
                //Notification that the list has dropped down
            
                //Procedure OnDropDown
                //End_Procedure
            
                //Notification that the list was closed
            
                //Procedure OnCloseUp
                //End_Procedure
            
            End_Object
        End_Object

        Object oDbGroup5 is a dbGroup
            Set Size to 36 287
            Set Location to 9 273
            Set Label to "Paciente"

            Object oForm3 is a cHighLightForm
                Set Size to 13 36
                Set Location to 14 9
                Set Prompt_Button_Mode to PB_PromptOn
                Set Prompt_Object to Paciente_sl
                
                Procedure Prompt_Callback Integer hoPrompt
                  Set peUpdateMode of hoPrompt to umPromptValue
                End_Procedure
                //OnChange is called on every changed character
            
                Procedure OnChange
                    String sValue
                    Get Value to sValue
                    Clear PACIENTE
                    Move sValue to PACIENTE.ID
                    Find EQ PACIENTE by Index.1
                    Set Value of (oForm4(Self)) to (Trim(PACIENTE.NOME))
                End_Procedure
            
            End_Object

            Object oForm4 is a cHighLightForm
                Set Size to 13 229
                Set Location to 14 50
                Set Enabled_State to False
            
                //OnChange is called on every changed character
            
                //Procedure OnChange
                //    String sValue
                //
                //    Get Value to sValue
                //End_Procedure
            
            End_Object
        End_Object

        Object oDbGroup6 is a dbGroup
            Set Size to 33 262
            Set Location to 44 7
            Set Label to "Especialidade"

            Object oForm3 is a cHighLightForm
                Set Size to 13 36
                Set Location to 12 9
                Set Prompt_Button_Mode to PB_PromptOn
                Set Prompt_Object to Especial_sl
                
                Procedure Prompt_Callback Integer hoPrompt
                  Set peUpdateMode of hoPrompt to umPromptValue
                End_Procedure
                //OnChange is called on every changed character
            
                Procedure OnChange
                    String sValue
                    Get Value to sValue
                    Clear ESPECIAL
                    Move sValue to ESPECIAL.ID
                    Find EQ ESPECIAL by Index.1
                    Set Value of (oForm4(Self)) to (Trim(ESPECIAL.DESCRICAO))
                End_Procedure
            
            End_Object

            Object oForm4 is a cHighLightForm
                Set Size to 13 205
                Set Location to 12 50
                Set Enabled_State to False
            
                //OnChange is called on every changed character
            
                //Procedure OnChange
                //    String sValue
                //
                //    Get Value to sValue
                //End_Procedure
            
            End_Object
        End_Object

        Object oDbGroup7 is a dbGroup
            Set Size to 33 554
            Set Location to 80 7
            Set Label to "Local"

            Object oForm3 is a cHighLightForm
                Set Size to 13 36
                Set Location to 12 9
                Set Prompt_Button_Mode to PB_PromptOn
                Set Prompt_Object to Local_sl
                
                Procedure Prompt_Callback Integer hoPrompt
                  Set peUpdateMode of hoPrompt to umPromptValue
                End_Procedure
            
                Procedure OnChange
                    String sValue
                    Get Value to sValue
                    Clear LOCAL
                    Move sValue to LOCAL.ID
                    Find EQ LOCAL by Index.1
                    Set Value of (oForm4(Self)) to (Trim(LOCAL.DESCRICAO))
                    Set Value of (oForm5(Self)) to (Trim(LOCAL.ENDERECO))
                End_Procedure
            
            End_Object

            Object oForm4 is a cHighLightForm
                Set Size to 13 202
                Set Location to 12 51
                Set Enabled_State to False
            
                //OnChange is called on every changed character
            
                //Procedure OnChange
                //    String sValue
                //
                //    Get Value to sValue
                //End_Procedure
            
            End_Object

            Object oForm5 is a cHighLightForm
                Set Size to 13 291
                Set Location to 12 257
                Set Enabled_State to False
                //OnChange is called on every changed character
            
                //Procedure OnChange
                //    String sValue
                //
                //    Get Value to sValue
                //End_Procedure
            
            End_Object
        End_Object

        Object oButton3 is a Button
            Set Size to 17 48
            Set Location to 115 457
            Set Label to "Filtrar"
            Set Bitmap to "filtrar.bmp"
        
            // fires when the button is clicked
            Procedure OnClick
                Send Rebuild_Constraints of oAgenda_DD
                Send ChangeOrdering of oDbCJGrid1 3 False
                Send MovetoFirstRow to oDbCJGrid1
            End_Procedure
        
        End_Object

        Object oButton4 is a Button
            Set Size to 17 48
            Set Location to 115 513
            Set Label to "Limpar"
            Set Bitmap to "limpar.bmp"
        
            // fires when the button is clicked
            Procedure OnClick
                Set Value of (oForm1(oDbGroup3(Self))) to (CurrentDateTime())
                Set Value of (oForm2(oDbGroup3(Self))) to ""
                Set Value of (oForm3(oDbGroup4(Self))) to ""
                Set Value of (oForm3(oDbGroup6(Self))) to ""
                Set Value of (oForm3(oDbGroup7(Self))) to ""
                Set Value of (oForm3(oDbGroup8(Self))) to ""
                Set Value of (oComboForm1(oDbGroup4(Self))) to "[T] - Todos"
                Send Rebuild_Constraints of oAgenda_DD
                Send ChangeOrdering of oDbCJGrid1 3 False
                Send MovetoFirstRow to oDbCJGrid1
            End_Procedure
        
        End_Object

        Object oDbGroup8 is a dbGroup
            Set Size to 33 287
            Set Location to 44 273
            Set Label to "M‚dico/Exame"

            Object oForm3 is a cHighLightForm
                Set Size to 13 36
                Set Location to 12 9
                Set Prompt_Button_Mode to PB_PromptOn
                Set Prompt_Object to Medexame_sl
                
                Procedure Prompt_Callback Integer hoPrompt
                  Set peUpdateMode of hoPrompt to umPromptValue
                End_Procedure
                //OnChange is called on every changed character
            
                Procedure OnChange
                    String sValue
                    Get Value to sValue
                    Clear MEDEXAME
                    Move sValue to MEDEXAME.ID
                    Find EQ MEDEXAME by Index.1
                    Set Value of (oForm4(Self)) to (Trim(MEDEXAME.NOME))
                End_Procedure
            
            End_Object

            Object oForm4 is a cHighLightForm
                Set Size to 13 231
                Set Location to 12 50
                Set Enabled_State to False
            
                //OnChange is called on every changed character
            
                //Procedure OnChange
                //    String sValue
                //
                //    Get Value to sValue
                //End_Procedure
            
            End_Object
        End_Object
    End_Object

    Object oDbGroup2 is a dbGroup
        Set Size to 30 269
        Set Location to 0 130
        Set Label to "Controle da Agenda"

        Object oButton1 is a Button
            Set Size to 17 48
            Set Location to 11 57
            Set Label to "Concluir"
            Set Bitmap to "concluir.bmp"
        
            Property Boolean pbSuccess (False)
            
            Object bpProcessaConcluir is a BusinessProcess
                Set Allow_Cancel_State to True
                Set Display_Error_State to True
                Set Error_Check_State to True
                Set Process_Caption to "Processamento"
                Set Process_Message to "Processando Arquivo"
                Set Process_Title to "Processando..."
                
                Property Integer piRecAgenda 0
                
                Use cWorkDataDictionary.dd
                
                Object oWORK_DD is a cWorkDataDictionary
                    Set validate_save_structure_mode   to DD_validate_structure_never
                    Set validate_deos_only_state       to False
                    
                    Send Add_System_File AGENDA.File_Number DD_Lock_On_ALL
                    
                    Procedure Update
                        Clear AGENDA
                        Move (piRecAgenda(Self)) to AGENDA.ID
                        Find eq AGENDA by Index.1
                        If      (AGENDA.FL_STATUS="M") Move "S" to AGENDA.FL_STATUS
                        Else If (AGENDA.FL_STATUS="A") Move "M" to AGENDA.FL_STATUS
                        SaveRecord AGENDA
                    End_Procedure
                End_Object
                
                Procedure OnProcess
                    RowID[] ariSelecao
                    Integer iCont iSize
                    Get SelectedRecords of (oDbCJGridSelectColumn1(oDbCJGrid1(Self))) to ariSelecao 
                    Move (SizeOfArray(ariSelecao)) to iSize
                    For iCont from 0 to (iSize - 1)
                        Send Clear of oAgenda_DD
                        Send FindByRowId of oAgenda_DD AGENDA.File_Number ariSelecao[iCont]
                        If (Found) Begin
                            Send Update_Status ("Registro #Agenda:" * (String(AGENDA.ID)))
                            Set piRecAgenda to AGENDA.ID
                            Send Request_Clear to oWORK_DD
                            Send Request_Save  to oWORK_DD
                        End
                    Loop
                    Set pbSuccess to (True)
                End_Procedure
                
                Procedure OnError Integer iErrNum Integer iErrLine String sErrMsg
                    Forward Send OnError iErrNum iErrLine sErrMsg
                    If (Status_Panel_State(Self)) Send Resume_Status
                End_Procedure
                
            End_Object
            
            Procedure OnClick
                Integer iFail iSize
                RowID[] ariSelecao
                Get Confirm "Confirma Concluir os registros selecionados?" to iFail
                If (iFail) Procedure_Return
                Get SelectedRecords of (oDbCJGridSelectColumn1(oDbCJGrid1(Self))) to ariSelecao 
                Move (SizeOfArray(ariSelecao)) to iSize
                If (iSize=0) Begin
                    Send Stop_Box "Sem registros selecionados para Concluir!" "AVISO"
                    Procedure_Return
                End
                Set pbSuccess to (False)
                Send Cursor_Wait to (Cursor_Control(Self))
                Send DoProcess to bpProcessaConcluir
                Send Cursor_Ready to (Cursor_Control(Self))
                Send DoSelectNone of (oDbCJGridSelectColumn1(oDbCJGrid1(Self)))
                Set pbUmCliqueGridConsAgenda to (False)
                Send Rebuild_Constraints of oAgenda_DD
                Send MovetoFirstRow      to oDbCJGrid1
                If (pbSuccess(Self)) Send Info_Box "Procedimento realizado com sucesso!"      "INFORMA€ÇO"
                Else                 Send UserError "Ocorreu um erro durante o processamento" "ERRO"
            End_Procedure  
        
        End_Object

        Object oButton2 is a Button
            Set Size to 17 48
            Set Location to 10 109
            Set Label to "Cancelado"
            Set Bitmap to "cancelar.bmp"
            
            Property Boolean pbSuccess (False)
            
            Object bpProcessaCancela is a BusinessProcess
                Set Allow_Cancel_State to True
                Set Display_Error_State to True
                Set Error_Check_State to True
                Set Process_Caption to "Processamento"
                Set Process_Message to "Processando Arquivo"
                Set Process_Title to "Processando..."
                
                Property Integer piRecAgenda 0
                
                Use cWorkDataDictionary.dd
                
                Object oWORK_DD is a cWorkDataDictionary
                    Set validate_save_structure_mode   to DD_validate_structure_never
                    Set validate_deos_only_state       to False
                    
                    Send Add_System_File AGENDA.File_Number DD_Lock_On_ALL
                    
                    Procedure Update
                        Clear AGENDA
                        Move (piRecAgenda(Self)) to AGENDA.ID
                        Find eq AGENDA by Index.1
                        Move "C" to AGENDA.FL_STATUS
                        SaveRecord AGENDA
                    End_Procedure
                End_Object
                
                Procedure OnProcess
                    RowID[] ariSelecao
                    Integer iCont iSize
                    Get SelectedRecords of (oDbCJGridSelectColumn1(oDbCJGrid1(Self))) to ariSelecao 
                    Move (SizeOfArray(ariSelecao)) to iSize
                    For iCont from 0 to (iSize - 1)
                        Send Clear of oAgenda_DD
                        Send FindByRowId of oAgenda_DD AGENDA.File_Number ariSelecao[iCont]
                        If (Found) Begin
                            Send Update_Status ("Registro #Agenda:" * (String(AGENDA.ID)))
                            Set piRecAgenda to AGENDA.ID
                            Send Request_Clear to oWORK_DD
                            Send Request_Save  to oWORK_DD
                        End
                    Loop
                    Set pbSuccess to (True)
                End_Procedure
                
                Procedure OnError Integer iErrNum Integer iErrLine String sErrMsg
                    Forward Send OnError iErrNum iErrLine sErrMsg
                    If (Status_Panel_State(Self)) Send Resume_Status
                End_Procedure
                
            End_Object
            
            Procedure OnClick
                Integer iFail iSize
                RowID[] ariSelecao
                Get Confirm "Confirma cancelar os registros selecionados?" to iFail
                If (iFail) Procedure_Return
                Get SelectedRecords of (oDbCJGridSelectColumn1(oDbCJGrid1(Self))) to ariSelecao 
                Move (SizeOfArray(ariSelecao)) to iSize
                If (iSize=0) Begin
                    Send Stop_Box "Sem registros selecionados para cancelar!" "AVISO"
                    Procedure_Return
                End
                Set pbSuccess to (False)
                Send Cursor_Wait to (Cursor_Control(Self))
                Send DoProcess to bpProcessaCancela
                Send Cursor_Ready to (Cursor_Control(Self))
                Send DoSelectNone of (oDbCJGridSelectColumn1(oDbCJGrid1(Self)))
                Set pbUmCliqueGridConsAgenda to (False)
                Send Rebuild_Constraints of oAgenda_DD
                Send MovetoFirstRow      to oDbCJGrid1
                If (pbSuccess(Self)) Send Info_Box "Procedimento realizado com sucesso!"      "INFORMA€ÇO"
                Else                 Send UserError "Ocorreu um erro durante o processamento" "ERRO"
            End_Procedure        
        End_Object

        Object oButton3 is a Button
            Set Size to 17 48
            Set Location to 10 5
            Set Label to "Concluir"
            Set Bitmap to "cadastro.bmp"
        
            // fires when the button is clicked
            Procedure OnClick
                Send Activate_ocadAgenda of (ClientAreaObject(ghoCommandBars))
            End_Procedure
        
        End_Object

        Object oButton2 is a Button
            Set Size to 17 48
            Set Location to 10 161
            Set Label to "Imprimir"
            Set Bitmap to "imprimir.bmp"
            
            Property Boolean pbSuccess (False)
            Property Integer piOperacaoRel 0
            
            Object bpProcessaRelatorio is a BusinessProcess
                Set Allow_Cancel_State to True
                Set Display_Error_State to True
                Set Error_Check_State to True
                Set Process_Caption to "Processamento"
                Set Process_Message to "Processando Arquivo"
                Set Process_Title to "Processando..."
                
                Property Integer piRecAgenda 0
                
                Use cWorkDataDictionary.dd
                
                Object oWORK_DD is a cWorkDataDictionary
                    Set validate_save_structure_mode   to DD_validate_structure_never
                    Set validate_deos_only_state       to False
                    
                    Send Add_System_File AGENDA.File_Number DD_Lock_On_ALL
                    
                    Procedure Update
                        Clear AGENDA
                        Move (piRecAgenda(Self)) to AGENDA.ID
                        Find eq AGENDA by Index.1
                        If (piOperacaoRel(Self)=1) Move "S" to AGENDA.FL_IMPRIME
                        Else                       Move ""  to AGENDA.FL_IMPRIME
                        SaveRecord AGENDA
                    End_Procedure
                End_Object
                
                Procedure OnProcess
                    RowID[] ariSelecao
                    Integer iCont iSize
                    Get SelectedRecords of (oDbCJGridSelectColumn1(oDbCJGrid1(Self))) to ariSelecao 
                    Move (SizeOfArray(ariSelecao)) to iSize
                    For iCont from 0 to (iSize - 1)
                        Send Clear of oAgenda_DD
                        Send FindByRowId of oAgenda_DD AGENDA.File_Number ariSelecao[iCont]
                        If (Found) Begin
                            Send Update_Status ("Registro #Agenda:" * (String(AGENDA.ID)))
                            Set piRecAgenda to AGENDA.ID
                            Send Request_Clear to oWORK_DD
                            Send Request_Save  to oWORK_DD
                        End
                    Loop
                    Set pbSuccess to (True)
                    Set piOperacaoRel to 0
                End_Procedure
                
                //Move (sSelection+(If(sSelection<>""," or ",""))+"{AGENDA.ID} = "+(String(AGENDA.ID))) to sSelection
                Procedure OnError Integer iErrNum Integer iErrLine String sErrMsg
                    Forward Send OnError iErrNum iErrLine sErrMsg
                    If (Status_Panel_State(Self)) Send Resume_Status
                End_Procedure
                
            End_Object
            
            Object oRelatorioConsAgenda is a _cCrystal11
                Procedure OnInitializeReport Handle hoReport
                    Set ComReportTitle of hoReport to "Consulta Agenda"
                    Forward Send OnInitializeReport hoReport
                End_Procedure
        
                Procedure OnDisplayReport Handle hoReport
                  Forward Send OnDisplayReport hoReport
                  
                  Set ComPaperOrientation of hoReport to crPortrait
                  Set ComPaperSize        of hoReport to crPaperA4
                End_Procedure
            End_Object      
            
            Procedure OnClick
                Integer iFail iSize
                RowID[] ariSelecao
                Get Confirm "Confirma imprimir os registros selecionados?" to iFail
                If (iFail) Procedure_Return
                Get SelectedRecords of (oDbCJGridSelectColumn1(oDbCJGrid1(Self))) to ariSelecao 
                Move (SizeOfArray(ariSelecao)) to iSize
                If (iSize=0) Begin
                    Send Stop_Box "Sem registros selecionados para imprimir!" "AVISO"
                    Procedure_Return
                End
                Set piOperacaoRel to 1
                Send DoProcess to bpProcessaRelatorio
                If (pbSuccess(Self)) Begin
                    Set  psReportName of oRelatorioConsAgenda to "ConsAgenda.rpt"
                    Send RunReport                            to oRelatorioConsAgenda
                    Send MovetoFirstRow                       to oDbCJGrid1
                    Send DoProcess                            to bpProcessaRelatorio
                    Send DoSelectNone of (oDbCJGridSelectColumn1(oDbCJGrid1(Self)))
                    Set pbUmCliqueGridConsAgenda to (False)
                End
                Else Send UserError "Ocorreu um erro durante o processamento" "ERRO"
            End_Procedure        
        End_Object

        Object oButton99 is a Button
            Set Size to 17 48
            Set Location to 10 213
            Set Label to "Excluir"
            Set Bitmap to "excluir.bmp"
            Set Focus_Mode to Pointer_Only
            
            Property Boolean pbSuccess (False)
            
            Object bpProcessaExclui is a BusinessProcess
                Set Allow_Cancel_State to True
                Set Display_Error_State to True
                Set Error_Check_State to True
                Set Process_Caption to "Processamento"
                Set Process_Message to "Processando Arquivo"
                Set Process_Title to "Processando..."
                
                Property Integer piRecAgenda 0
                
                Use cWorkDataDictionary.dd
                
                Object oWORK_DD is a cWorkDataDictionary
                    Set validate_save_structure_mode   to DD_validate_structure_never
                    Set validate_deos_only_state       to False
                    
                    Send Add_System_File AGENDA.File_Number DD_Lock_On_ALL
                    
                    Procedure Update
                        Clear AGENDA
                        Move (piRecAgenda(Self)) to AGENDA.ID
                        Find eq AGENDA by Index.1
                        Delete AGENDA
                    End_Procedure
                End_Object
                
                Procedure OnProcess
                    RowID[] ariSelecao
                    Integer iCont iSize
                    Get SelectedRecords of (oDbCJGridSelectColumn1(oDbCJGrid1(Self))) to ariSelecao 
                    Move (SizeOfArray(ariSelecao)) to iSize
                    For iCont from 0 to (iSize - 1)
                        Send Clear of oAgenda_DD
                        Send FindByRowId of oAgenda_DD AGENDA.File_Number ariSelecao[iCont]
                        If (Found) Begin
                            Send Update_Status ("Registro #Agenda:" * (String(AGENDA.ID)))
                            Set piRecAgenda to AGENDA.ID
                            Send Request_Clear to oWORK_DD
                            Send Request_Save  to oWORK_DD
                        End
                    Loop
                    Set pbSuccess to (True)
                End_Procedure
                
                Procedure OnError Integer iErrNum Integer iErrLine String sErrMsg
                    Forward Send OnError iErrNum iErrLine sErrMsg
                    If (Status_Panel_State(Self)) Send Resume_Status
                End_Procedure
                
            End_Object
            
            Procedure OnClick
                Integer iFail iSize
                RowID[] ariSelecao
                Get Confirm "Confirma excluir os registros selecionados?" to iFail
                If (iFail) Procedure_Return
                Get SelectedRecords of (oDbCJGridSelectColumn1(oDbCJGrid1(Self))) to ariSelecao 
                Move (SizeOfArray(ariSelecao)) to iSize
                If (iSize=0) Begin
                    Send Stop_Box "Sem registros selecionados para excluir!" "AVISO"
                    Procedure_Return
                End
                Set pbSuccess to (False)
                Send Cursor_Wait to (Cursor_Control(Self))
                Send DoProcess to bpProcessaExclui
                Send Cursor_Ready to (Cursor_Control(Self))
                Set pbUmCliqueGridConsAgenda to (False)
                Send Rebuild_Constraints of oAgenda_DD
                Send MovetoFirstRow      to oDbCJGrid1
                Send DoSelectNone of (oDbCJGridSelectColumn1(oDbCJGrid1(Self)))
                If (pbSuccess(Self)) Send Info_Box "Procedimento realizado com sucesso!"      "INFORMA€ÇO"
                Else                 Send UserError "Ocorreu um erro durante o processamento" "ERRO"
            End_Procedure        
        End_Object
    End_Object

    Object oButton5 is a Button
        Set Size to 11 567
        Set Location to 300 7
        Set Label to "Consulta"
        
        Property Boolean pbUmClique (False)
        
        Procedure OnClick
            If (pbUmClique(Self)) Begin
                Set Size of oDbCJGrid1 to 132 566 
                Set Label to "Consulta"               
                Set Visible_State of oDbGroup1 to True
                Set Enabled_State of oDbGroup1 to True
            End
            Else Begin
                Set Size of oDbCJGrid1 to 263 566
                Set Label to "Filtros"
                Set Visible_State of oDbGroup1 to False
                Set Enabled_State of oDbGroup1 to False
            End
            Set pbUmClique to (not(pbUmClique(Self)))
        End_Procedure
    
    End_Object
    
    Procedure Activate_View Returns Integer
        Integer iRetorno
        Forward Get Msg_Activate_View to iRetorno
        Set Value of (oForm1(oDbGroup3(oDbCJGrid1(Self)))) to (CurrentDateTime())
        Send Rebuild_Constraints of oAgenda_DD
        Send ChangeOrdering of oDbCJGrid1 3 False
        Send MovetoFirstRow to oDbCJGrid1
        Procedure_Return iRetorno
    End_Procedure

    Object oDbGroup99 is a dbGroup
        Set Size to 30 57
        Set Location to 0 400
        Set Label to "Grid"

        Object oButton99 is a Button
            Set Size to 17 48
            Set Location to 10 5
            Set Label to "Concluir"
            Set Bitmap to "atualizar.bmp"
        
            // fires when the button is clicked
            Procedure OnClick
                Send MovetoFirstRow to oDbCJGrid1
            End_Procedure
        
        End_Object
    End_Object

End_Object 
