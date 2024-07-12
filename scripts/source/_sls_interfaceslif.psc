Scriptname _SLS_InterfaceSlif extends Quest  

Float Property ScaleMaxAss = 2.3 Auto Hidden
Float Property ScaleMaxBreasts = 3.3 Auto Hidden
Float Property ScaleMaxBelly = 5.5 Auto Hidden

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("SexLab Inflation Framework.esp") != 255
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

EndEvent

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

State Installed
	Function Inflate(Actor akTarget, String ModNameAppend = "", String Node, Float ScaleAmount)
		_SLS_IntSlif.Inflate(akTarget, ModNameAppend, Node, ScaleAmount)
	EndFunction
	
	Function Morph(Actor akTarget, String ModNameAppend = "", String MorphName, Float Value)
		_SLS_IntSlif.Morph(akTarget, ModNameAppend, MorphName, Value)
	EndFunction
	
	Function UnRegisterActor(Actor akTarget, String ModNameAppend = "")
		_SLS_IntSlif.UnRegisterActor(akTarget, ModNameAppend)
	EndFunction
	
	Float Function GetInflateValue(Actor akTarget, String ModNameAppend = "", String NodeName) 
		Return _SLS_IntSlif.GetInflateValue(akTarget, ModNameAppend, NodeName)
	EndFunction

	Float Function GetMorphValue(Actor akTarget, String ModNameAppend, String MorphName) 
		Return _SLS_IntSlif.GetMorphValue(akTarget, ModNameAppend, MorphName)
	EndFunction

	Float Function GetTotalInflateValue(Actor akTarget, String NodeName) 
		Return _SLS_IntSlif.GetTotalInflateValue(akTarget, NodeName)
	EndFunction

	Float Function GetTotalMorphValue(Actor akTarget, String MorphName) 
		Return _SLS_IntSlif.GetTotalMorphValue(akTarget, MorphName)
	EndFunction
EndState

Function Inflate(Actor akTarget, String ModNameAppend = "", String Node, Float ScaleAmount)
EndFunction

Function Morph(Actor akTarget, String ModNameAppend = "", String MorphName, Float Value)
EndFunction

Function UnRegisterActor(Actor akTarget, String ModNameAppend = "")
EndFunction

Float Function GetInflateValue(Actor akTarget, String ModNameAppend = "", String NodeName) 
	Return 0.0
EndFunction

Float Function GetMorphValue(Actor akTarget, String ModNameAppend, String MorphName) 
	Return 0.0
EndFunction

Float Function GetTotalInflateValue(Actor akTarget, String NodeName) 
	Return 0.0
EndFunction

Float Function GetTotalMorphValue(Actor akTarget, String MorphName) 
	Return 0.0
EndFunction
