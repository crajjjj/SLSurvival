Scriptname SLIF_Debug Hidden

; Severity is one of the following:
; 0 - Info
; 1 - Warning
; 2 - Error
function TraceMsg(String msg, bool trace = true, int severity = 0) Global
	if (trace)
		Debug.OpenUserLog("SLIF_Debug")
		Debug.TraceUser("SLIF_Debug", msg, severity)
	endIf
endFunction

function Trace(String msg) Global
	TraceMsg(msg, SLIF_Config.GetInt("show_debug_messages", 0))
endFunction

function NotificationMsg(String msg, bool notify) Global
	if (notify)
		Debug.Notification(msg)
		MiscUtil.PrintConsole(msg)
	endIf
endFunction

function Notification(String msg) Global
	NotificationMsg(msg, SLIF_Config.GetInt("show_notifications", 1))
endFunction
