Scriptname _SLS_Debuff Hidden

; Debuff notices go through here so the MCM's Debuff Notifications toggle silences all of them.
; The toggle is a global StorageUtil value rather than an MCM property, so magic effect scripts can
; read it without a new CK-filled property.
Function Notify(String Msg) Global
	If StorageUtil.GetIntValue(None, "_SLS_DebuffNotify", Missing = 1) == 1
		Debug.Notification(Msg)
	EndIf
EndFunction
