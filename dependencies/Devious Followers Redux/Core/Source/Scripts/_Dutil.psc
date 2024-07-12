Scriptname _Dutil

Bool Function DebugSpam_IsEnabled() Global
    Int enabled = StorageUtil.GetIntValue(None, "df_EnableDebugSpam")
    Return 0 != enabled
EndFunction

Int Function DebugSpam_GetSeverity() Global
    Return StorageUtil.GetIntValue(None, "df_TraceSpamSeverity", 127)
EndFunction


Function DebugSpam_SetInfo() Global
    StorageUtil.SetIntValue(None, "df_EnableDebugSpam", 1)
    StorageUtil.SetIntValue(None, "df_TraceSpamSeverity", 0)
EndFunction

Function DebugSpam_SetWarning() Global
    StorageUtil.SetIntValue(None, "df_EnableDebugSpam", 1)
    StorageUtil.SetIntValue(None, "df_TraceSpamSeverity", 1)
EndFunction

Function DebugSpam_SetError() Global
    StorageUtil.SetIntValue(None, "df_EnableDebugSpam", 1)
    StorageUtil.SetIntValue(None, "df_TraceSpamSeverity", 2)
EndFunction

Function DebugSpam_SetAlert() Global
    StorageUtil.SetIntValue(None, "df_EnableDebugSpam", 1)
    StorageUtil.SetIntValue(None, "df_TraceSpamSeverity", 3)
EndFunction

Function DebugSpam_Off_AlertsOn() Global
    StorageUtil.SetIntValue(None, "df_EnableDebugSpam", 0)
    StorageUtil.SetIntValue(None, "df_TraceSpamSeverity", 3)
EndFunction

Function DebugSpam_Off() Global
    StorageUtil.SetIntValue(None, "df_EnableDebugSpam", 0)
    StorageUtil.SetIntValue(None, "df_TraceSpamSeverity", 4)
EndFunction


Function EnableDebugSpam(Bool enable) Global
    StorageUtil.SetIntValue(None, "df_EnableDebugSpam", enable as Int)
EndFunction

Function Notify(String txtMsg) Global
	If StorageUtil.GetIntValue(None, "df_EnableDebugSpam")
		Debug.Notification(txtMsg)
	EndIf
EndFunction

Function MessageBox(String txtMsg) Global
	If StorageUtil.GetIntValue(None, "df_EnableDebugSpam")
		Debug.MessageBox(txtMsg)
	EndIf
EndFunction


; Debug Trace severity levels:
; 0: info, 1: warning, 2: error, (3: alert - not a Bethesda value)
; Only messages of at least enabled level are logged.
;
Function EnableTraceSpam(int severity = 0) Global
    StorageUtil.SetIntValue(None, "df_TraceSpamSeverity", severity)
EndFunction

Function DisableTraceSpam() Global
    StorageUtil.SetIntValue(None, "df_TraceSpamSeverity", 127)
EndFunction

Function Trace(Int severity, String txtMsg) Global
	If severity >= StorageUtil.GetIntValue(None, "slax_TraceSpamSeverity", 127)
        Debug.Trace(txtMsg, 2)
    EndIf
EndFunction

; Yes, I know these messages are severity filtered twice as implemented. (tdt?)
; This allows Debug.Trace to be swapped for direct file logging, or a text buffer, or anything you like without changing the callers.
Function Info(String txtMsg) Global
	If StorageUtil.GetIntValue(None, "df_TraceSpamSeverity", 127) <= 0
        Debug.Trace(txtMsg, 2)
    EndIf
EndFunction

Function InfoConditional(String txtMsg, Bool condition) Global
	If condition && StorageUtil.GetIntValue(None, "df_TraceSpamSeverity", 127) <= 0
        Debug.Trace(txtMsg, 2)
    EndIf
EndFunction

Function Warning(String txtMsg) Global
	If StorageUtil.GetIntValue(None, "df_TraceSpamSeverity", 127) <= 1
        Debug.Trace(txtMsg, 2)
    EndIf
EndFunction

Function WarningConditional(String txtMsg, Bool condition) Global
	If condition && StorageUtil.GetIntValue(None, "df_TraceSpamSeverity", 127) <= 1
        Debug.Trace(txtMsg, 2)
    EndIf
EndFunction

Function Error(String txtMsg) Global
	If StorageUtil.GetIntValue(None, "df_TraceSpamSeverity", 127) <= 2
        Debug.Trace(txtMsg, 2)
    EndIf
EndFunction

Function ErrorConditional(String txtMsg, Bool condition) Global
	If condition && StorageUtil.GetIntValue(None, "df_TraceSpamSeverity", 127) <= 2
        Debug.Trace(txtMsg, 2)
    EndIf
EndFunction

; The 'spam' type doesn't check any severity.
Function Spam(String txtMsg) Global
    Debug.Trace(txtMsg, 2)
EndFunction

Function Alert(String txtMsg) Global
    If StorageUtil.GetIntValue(None, "df_TraceSpamSeverity", 127) <= 3
        Debug.TraceAndBox(txtMsg, 2)
    EndIf
EndFunction

Function AlertConditional(String txtMsg, Bool condition) Global
    If condition && StorageUtil.GetIntValue(None, "df_TraceSpamSeverity", 127) <= 3
        Debug.TraceAndBox(txtMsg, 2)
    EndIf
EndFunction

Function DumpStackConditional(String txtMsg, Bool condition) Global ; Must set info level to see these
    If condition && StorageUtil.GetIntValue(None, "df_TraceSpamSeverity", 127) <= 0
        Debug.TraceStack(txtMsg, 2)
    EndIf
EndFunction
