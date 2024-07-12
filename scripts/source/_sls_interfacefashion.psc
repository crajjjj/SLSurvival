Scriptname _SLS_InterfaceFashion extends Quest  

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("yps-ImmersivePiercing.esp") != 255 && StorageUtil.GetFloatValue(None, "yps_TweakVersion", Missing = -1.0) >= 1.2
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
	RegForEvents()
EndEvent

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

Function RegForEvents()
	RegisterForModEvent("yps_PubicHairStageChange", "Onyps_PubicHairStageChange")
EndFunction

State Installed
	Event Onyps_PubicHairStageChange(string eventName, string strArg, float numArg, Form sender)
		If numArg <= 0
			HairyPussyTaxWhiterun = false
			HairyPussyTaxSolitude = false
			HairyPussyTaxMarkarth = false
			HairyPussyTaxWindhelm = false
			HairyPussyTaxRiften = false
		EndIf
	EndEvent
	
	Int Function GetPubicHairStage()
		Return StorageUtil.GetIntValue(None, "yps_PubicHairStage", Missing = 0)
	EndFunction
EndState

Event Onyps_PubicHairStageChange(string eventName, string strArg, float numArg, Form sender)
EndEvent

Int Function GetPubicHairStage()
	Return 0
EndFunction

Bool Property HairyPussyTaxWhiterun = false Auto Hidden
Bool Property HairyPussyTaxSolitude = false Auto Hidden
Bool Property HairyPussyTaxMarkarth = false Auto Hidden
Bool Property HairyPussyTaxWindhelm = false Auto Hidden
Bool Property HairyPussyTaxRiften = false Auto Hidden
