Scriptname _SLS_InterfaceSlpp extends Quest

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
	PlayerLoadsGame() ; catch a mid-save install immediately instead of waiting for the next load
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	; P+ replaces SexLab.esm in place, so Game.GetModByName can't tell the frameworks apart -
	; probe the P+ SKSE plugin version instead (negative on legacy SexLab; old P+ without
	; the SexLabThread interaction API is gated out too).
	If _SLS_IntSlpp.GetIsInstalled()
		If GetState() != "Installed"
			GoToState("Installed")
		EndIf
	Else
		If GetState() != ""
			GoToState("")
		EndIf
	EndIf
EndFunction

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

State Installed
	Int Function GetOralState(Int tid, Actor akSucker, Actor akPartner)
		Return _SLS_IntSlpp.GetOralState(Sexlab, tid, akSucker, akPartner)
	EndFunction

	Actor Function GetOralPartner(Int tid, Actor akSucker)
		Return _SLS_IntSlpp.GetOralPartner(Sexlab, tid, akSucker)
	EndFunction
EndState

; Empty state = P+ not installed. -1 tells callers to fall back to legacy checks (0 would
; wrongly read as "P+ says no").
Int Function GetOralState(Int tid, Actor akSucker, Actor akPartner)
	Return -1
EndFunction

Actor Function GetOralPartner(Int tid, Actor akSucker)
	Return None
EndFunction

SexlabFramework Property Sexlab Auto
