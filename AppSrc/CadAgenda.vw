// C:\Users\Wilber\Documents\Visual DataFlex Projects\SistemaAgendamentoMedicoPessoalv16\AppSrc\CadAgenda.vw
// Cadastro de Agenda
//

Use DFClient.pkg
Use DFEntry.pkg

Use cEspecialDataDictionary.dd
//Use cLocalDataDictionary.dd
Use cMedexameDataDictionary.dd
Use cPacienteDataDictionary.dd
Use cAgendaDataDictionary.dd
Use Windows.pkg
Use dfcentry.pkg
Use cDbTextEdit.pkg

ACTIVATE_VIEW Activate_oCadAgenda FOR oCadAgenda
Object oCadAgenda is a dbView
    Set Location to 4 5
    Set Size to 313 351
    Set Label To "Cadastro de Agenda"
    Set Border_Style to Border_None
    Set peAnchors to anNone
    Set Icon to "agenda2.ico"
    
    Property Integer piOperacaoGed 0

    Object oEspecial_DD is a cEspecialDataDictionary
    End_Object // oEspecial_DD


    Object oMedexame_DD is a cMedexameDataDictionary
        Set DDO_Server To oEspecial_DD
    End_Object // oMedexame_DD

    Object oPaciente_DD is a cPacienteDataDictionary
    End_Object // oPaciente_DD

    Object oAgenda_DD is a cAgendaDataDictionary
        Set DDO_Server To oMedexame_DD
        Set DDO_Server to oPaciente_DD
        
        Send DefineAllExtendedFields
        
        Procedure Update
            String sID sArquivoAnexo sCaminho sArquivoGED
            Boolean bFileExists
            Forward Send Update
            If (piOperacaoGed(Self)=1) Begin
                Set piOperacaoGed to 0
                Move "000000"   to sID
                Append sID AGENDA.ID
                Move (Right(sID, 6)) to sID
                Get ReadString of oIniFileAbaco "documentos" "Ged" "" to sCaminho
                Append sArquivoGED sCaminho "\" sID ".PDF"
                Get Value of (oAGENDA_GED(oGroup5(Self))) to sArquivoAnexo
                File_Exist sCaminho  bFileExists
                If (not(bFileExists)) Begin
                    Make_Directory sCaminho
                    File_Exist sCaminho bFileExists
                    If (not(bFileExists)) Send UserError "Sem permissÆo de criar pasta!" "ERRO"    
                End
                CopyFile sArquivoAnexo to sArquivoGED
                File_Exist sArquivoGED bFileExists
                If (not(bFileExists)) Send UserError "Ocorreu um erro ao anexar o arquivo!\nCertifique-se que o nome do arquivo nÆo possu¡ s¡mbolos e/ou acentos!" "ERRO" 
                Move sArquivoGED to AGENDA.GED
            End
        End_Procedure
    End_Object // oAgenda_DD

    Set Main_DD To oAgenda_DD
    Set Server  To oAgenda_DD

    Object oGroup1 is a dbGroup
        Set Size to 38 332
        Set Location to 6 7
        Set Label to "Principal"

        Object oAgendaId is a cHighLightDbForm
            Entry_Item Agenda.Id
            Set Size to 13 42
            Set Location to 18 8
            Set peAnchors to anNone
            Set Label to "ID:"
            Set Label_Justification_mode to JMode_Top
            Set Label_Col_Offset to 0
            Set Label_row_Offset to 0
            Set Prompt_Button_Mode to PB_PromptOn
        End_Object // oAgendaId
        
        Use Calend.SL
        Object oAgendaData is a cHighLightDbForm
            Entry_Item Agenda.Data
            Set Size to 13 59
            Set Location to 18 58
            Set peAnchors to anNone
            Set Label to "Data:"
            Set Label_Justification_mode to JMode_Top
            Set Label_Col_Offset to 0
            Set Label_row_Offset to 0
            Set Prompt_Button_Mode to PB_PromptOn
            Set Prompt_Object to oCalendario_sl
        End_Object // oAgendaData
        
        Object oAgendaHora is a cHighLightDbForm
            Entry_Item Agenda.Hora
            Set Size to 13 51
            Set Location to 18 124
            Set peAnchors to anNone
            Set Label to "Hora:"
            Set Label_Justification_mode to JMode_Top
            Set Label_Col_Offset to 0
            Set Label_row_Offset to 0
        End_Object // oAgendaHora

        Object oAGENDA_FL_STATUS is a cHighLightDbComboForm
            Entry_Item AGENDA.FL_STATUS
            Set Location to 18 183
            Set Size to 13 66
            Set Label to "Status:"
            Set Label_Col_Offset to 0
            Set Label_Justification_Mode to JMode_Top
            Set Entry_State to False
        End_Object
    End_Object

    Object oGroup2 is a dbGroup
        Set Size to 33 332
        Set Location to 45 7
        Set Label to "Paciente"

        Object oPacienteId is a cHighLightDbForm
            Entry_Item Paciente.Id
            Set Size to 13 42
            Set Location to 12 9
            Set peAnchors to anNone
            Set Label_Justification_mode to JMode_Top
            Set Label_Col_Offset to 0
            Set Label_row_Offset to 0
            Set Prompt_Button_Mode to PB_PromptOn
        End_Object // oPacienteId
        Object oPacienteNome is a cHighLightDbForm
            Entry_Item Paciente.Nome
            Set Size to 13 264
            Set Location to 12 56
            Set peAnchors to anNone
            Set Label_Justification_mode to jMode_Left
            Set Label_Col_Offset to 34
            Set Label_row_Offset to 0
            Set Enabled_State to False
        End_Object // oPacienteNome
    End_Object

    Object oGroup3 is a dbGroup
        Set Size to 63 332
        Set Location to 81 8
        Set Label to "M‚dico/Exame/Especialidade"

        Object oMedexameId is a cHighLightDbForm
            Entry_Item Medexame.Id
            Set Size to 13 42
            Set Location to 18 9
            Set peAnchors to anNone
            Set Label_Justification_mode to JMode_Top
            Set Label_Col_Offset to 0
            Set Label_row_Offset to 0
            Set Label to "M‚dico:"
            Set Prompt_Button_Mode to PB_PromptOn
            
            Procedure OnKillFocus
                Integer iID_LOC
                Get Value of (oLocalId(oGroup4(Self))) to iID_LOC
                If (iID_LOC=0 or AGENDA.Recnum=0) Begin
                    Move MEDEXAME.ID_LOC to LOCAL.ID
                    Find eq LOCAL by Index.1
                    Set Field_Changed_Value of oAgenda_DD Field AGENDA.ID_LOC to LOCAL.ID
                    Set Value of (oLocalDescricao(oGroup4(Self))) to (Trim(LOCAL.DESCRICAO))
                    Set Value of (oLocalEndereco (oGroup4(Self))) to (Trim(LOCAL.ENDERECO ))
                End
                Forward Send OnKillFocus
            End_Procedure
            
            Procedure Prompt
                Forward Send Prompt
                Move MEDEXAME.ID_LOC to LOCAL.ID
                Find eq LOCAL by Index.1
                Set Field_Changed_Value of oAgenda_DD Field AGENDA.ID_LOC to LOCAL.ID
                Set Value of (oLocalDescricao(oGroup4(Self))) to (Trim(LOCAL.DESCRICAO))
                Set Value of (oLocalEndereco (oGroup4(Self))) to (Trim(LOCAL.ENDERECO ))
            End_Procedure

        End_Object // oMedexameId
        Object oMedexameNome is a cHighLightDbForm
            Entry_Item Medexame.Nome
            Set Size to 13 264
            Set Location to 18 57
            Set peAnchors to anNone
            Set Label_Justification_mode to jMode_Left
            Set Label_Col_Offset to 34
            Set Label_row_Offset to 0
            Set Enabled_State to False
        End_Object // oMedexameNome

        Object oEspecialId is a cHighLightDbForm
            Entry_Item Especial.Id
            Set Size to 13 42
            Set Location to 42 9
            Set peAnchors to anNone
            Set Label to "Especialidade:"
            Set Label_Justification_mode to JMode_Top
            Set Label_Col_Offset to 0
            Set Label_row_Offset to 0
            Set Prompt_Button_Mode to PB_PromptOn
            Set Enabled_State to False
        End_Object // oEspecialId
        Object oEspecialDescricao is a cHighLightDbForm
            Entry_Item Especial.Descricao
            Set Size to 13 264
            Set Location to 42 57
            Set peAnchors to anNone
            Set Label_Justification_mode to jMode_Left
            Set Label_Col_Offset to 34
            Set Label_row_Offset to 0
            Set Enabled_State to False
        End_Object // oEspecialDescricao
    End_Object

    Object oGroup4 is a dbGroup
        Set Size to 52 332
        Set Location to 146 9
        Set Label to "Local:"

        Object oLocalId is a cHighLightDbForm
//            Entry_Item Local.Id
            Entry_Item AGENDA.ID_LOC
            Set Size to 13 42
            Set Location to 12 10
            Set peAnchors to anNone
            Set Label_Justification_mode to JMode_Top
            Set Label_Col_Offset to 0
            Set Label_row_Offset to 0
            Set Prompt_Button_Mode to PB_PromptOn
//            Set Enabled_State to False
            
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
        Object oLocalDescricao is a cHighLightDbForm
//            Entry_Item Local.Descricao
            Set Size to 13 264
            Set Location to 12 58
            Set peAnchors to anNone
            Set Label_Justification_mode to JMode_Top
            Set Label_row_Offset to 0
            Set Enabled_State to False
        End_Object // oLocalDescricao
        Object oLocalEndereco is a cHighLightDbForm
//            Entry_Item Local.Endereco
            Set Size to 13 313
            Set Location to 31 10
            Set peAnchors to anNone
            Set Label_Justification_mode to jMode_Left
            Set Label_row_Offset to 0
            Set Enabled_State to False
        End_Object // oLocalEndereco
    End_Object

    Object oAGENDA_OBS is a cHighLightDbTextEdit
        Entry_Item AGENDA.OBS
        Set Location to 210 11
        Set Size to 41 331
        Set Label to "Observa‡Æo:"
        
        Procedure Switch
            Boolean bEnabled bRec
            Get HasRecord of (Main_DD(Self)) to bRec
            If (not(bRec)) Begin
                Send Request_Save_No_Clear
                Send EnableObjects
            End
            Forward Send Switch 
            
        End_Procedure
    End_Object

    Object oGroup5 is a dbGroup
        Set Size to 56 332
        Set Location to 253 9
        Set Label to "GED:"

        Object btAnexar is a Button
            Set Size to 17 48
            Set Location to 35 79
            Set Label to "Anexar"
            Set Bitmap to "anexar.bmp"
            
            Function Confirm_Save_Anexo Returns Integer
                Function_Return (Confirm(Self, "Confirma Anexar Documento?"))
            End_Function
        
            Procedure OnClick
                String sNomeArquivo iFail
                Get Value of oAGENDA_GED to sNomeArquivo
                If ((Trim(sNomeArquivo))>"") Begin
                    Get Confirm_Save_Anexo to iFail
                    If (not(iFail)) Begin
                        Set piOperacaoGed to 1
                        Send Request_Save of (Main_DD(Self))
                        If (not(Err)) Send Info_Box "Arquivo anexado com sucesso!" "INFORMA€ÇO"
                    End
                End
                Else Send UserError "Selecione o arquivo para anexar!" "ERRO"
            End_Procedure
        
        End_Object
        
        Object btVisualizar is a Button
            Set Size to 17 48
            Set Location to 35 205
            Set Label to "Visualizar"
            Set Bitmap to "visualizar.bmp"
            
            Procedure OnClick
                Send Popup_Modal to oGEDVisualizar               
            End_Procedure
            
        End_Object

        Object oAGENDA_GED is a cHighLightDbForm
            Entry_Item AGENDA.GED
            Set Location to 19 7
            Set Size to 13 318
            Set Label to "Caminho Arquivo:"
            Set Label_Col_Offset to 0
            Set Label_Justification_Mode to JMode_Top
            Set Prompt_Button_Mode to pb_PromptOn
            
            Procedure Prompt
                Boolean bOpen
                String  sSelectedFile sExtensao
                String sCaminhoDocs
                Get ReadString of oIniFileAbaco "documentos" "Ged" "" to sCaminhoDocs
                
                Set Initial_Folder of oNewDialog to sCaminhoDocs
                
                Get Show_Dialog of oNewDialog to bOpen
                If bOpen Begin
                    Get File_Name of oNewDialog to sSelectedFile
                    Set Value to sSelectedFile
                End
            End_Procedure 
    
            Object oNewDialog is a OpenDialog
                Set Dialog_Caption to "Selecione o arquivo"
                Set Filter_String to "PDF|*.PDF"
                Set HideReadOnly_State to True
            End_Object  
        End_Object
    
    End_Object
    Object oIdle is a cIdleHandler
        Procedure OnIdle
            Delegate Send OnIdle
        End_Procedure
    End_Object
    
    Procedure OnIdle
        Send EnableObjects
    End_Procedure

    Procedure EnableObjects
        Handle hServer 
        Boolean bRec
        Get Server of (Main_DD(Self)) to hServer
        Get HasRecord of hServer to bRec
        Set Enabled_State of (btAnexar    (oGroup5(Self))) to bRec
        Set Enabled_State of (btVisualizar(oGroup5(Self))) to bRec
        Set Enabled_State of (oAGENDA_GED (oGroup5(Self))) to bRec
    End_Procedure

    Procedure Activating
        Forward Send Activating
        Set pbEnabled of oIdle to True
    End_Procedure
    
    Procedure DeActivating
        Set pbEnabled of oIdle to False
        Forward Send Deactivating
    End_Procedure
    
    Function Confirm_Delete_Agenda Returns Integer
        Integer iRetVal
        Get Confirm "Deletar Agenda?" to iRetVal
        Function_Return iRetVal
    End_Function
    
    Function Confirm_Save_Agenda Returns Integer
        Integer iNoSave 
        Boolean bRec
        Get HasRecord of (Main_DD(Self)) to bRec
        If (not(bRec)) Get Confirm "Confirma Salvar Agenda?"    to iNoSave
        Else           Get Confirm "Confirma Atualizar Agenda?" to iNoSave
        Function_Return iNoSave
    End_Function
    
    Set Verify_Save_MSG       to (RefFunc(Confirm_Save_Agenda))
    Set Verify_Delete_MSG     to (RefFunc(Confirm_Delete_Agenda))
    Set Verify_Data_Loss_Msg  to (RefFunc(No_Confirmation))

End_Object // oCadAgenda
