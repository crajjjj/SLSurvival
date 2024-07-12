Scriptname _SLS_InterfaceCreatureFramework extends Quest  

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
	RegisterForMenu("Journal Menu")
EndEvent

Event OnMenuOpen(String MenuName)
	SavedThreshold = GetArousalThreshold()
	SetArousalThreshold(ArousalThresholdActual)
EndEvent

Event OnMenuClose(String MenuName)
	; Check arousal threshold was changed
	Int ArousalThreshold = GetArousalThreshold()
	If ArousalThreshold != ArousalThresholdActual && ArousalThreshold != -2
		ArousalThresholdActual = ArousalThreshold
	EndIf
	
	If SavedThreshold == -2 ; Mode was currently active
		SetArousalThreshold(-2)
	EndIf
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("CreatureFramework.esm") != 255
		If GetState() != "Installed"
			GoToState("Installed")
		EndIf
	
	Else
		If GetState() != ""
			GoToState("")
		EndIf
	EndIf
EndFunction

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
	McmQuest = Game.GetFormFromFile(0x000D63,"CreatureFramework.esm") as Quest
	ArousalThresholdActual = GetArousalThreshold()
EndEvent

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

State Installed
	Int Function GetArousalThreshold()
		Return _SLS_IntCf.GetArousalThreshold(McmQuest)
	EndFunction
	
	Function SetArousalThreshold(Int Threshold)
		_SLS_IntCf.SetArousalThreshold(McmQuest, Threshold)
	EndFunction
	
	Function ResetArousalThreshold()
		_SLS_IntCf.SetArousalThreshold(McmQuest, ArousalThresholdActual)
	EndFunction
EndState

Int Function GetArousalThreshold()
	Return 50
EndFunction

Function SetArousalThreshold(Int Threshold)
EndFunction

Function ResetArousalThreshold()
EndFunction

Int ArousalThresholdActual = 50
Int SavedThreshold

Quest McmQuest
