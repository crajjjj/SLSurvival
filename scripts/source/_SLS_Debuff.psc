Scriptname _SLS_Debuff Hidden

; Debuff notices go through here so the MCM's Debuff Notifications toggle silences all of them.
; The toggle is a global StorageUtil value rather than an MCM property, so magic effect scripts can
; read it without a new CK-filled property.
; Category: notices of one category share a cooldown, so boots off/on/off says "barefoot" once.
Function Notify(String Category, String Msg) Global
	If StorageUtil.GetIntValue(None, "_SLS_DebuffNotify", Missing = 1) != 1
		Return
	EndIf
	; Real time counts from game launch and the stamp lives in the co-save, so a stamp ahead of
	; now is from an earlier session and has expired
	Float Now = Utility.GetCurrentRealTime()
	Float Last = StorageUtil.GetFloatValue(None, "_SLS_DebuffNotifyAt_" + Category, Missing = -1000.0)
	If Now >= Last && Now - Last < 60.0
		Return
	EndIf
	StorageUtil.SetFloatValue(None, "_SLS_DebuffNotifyAt_" + Category, Now)
	Debug.Notification(Msg)
EndFunction

; SexLab strips and redresses the player around every scene, which flips the equipment-driven
; debuffs (barefoot) on and off; those are no news during a scene
Bool Function PlayerInScene() Global
	Return Game.GetPlayer().IsInFaction(Game.GetFormFromFile(0x00E50F, "SexLab.esm") as Faction)
EndFunction
