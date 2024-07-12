Scriptname _STA_ApiSpankHandler extends Quest  

Function SpankBasicAss()
	GoToState("Active")
	SpankUtil.SpankAssBasic()
	GoToState("")
EndFunction

Function SpankBasicTits()
	GoToState("Active")
	SpankUtil.SpankTitsBasic()
	GoToState("")
EndFunction

State Active
	Function SpankBasicAss()
	EndFunction
	
	Function SpankBasicTits()
	EndFunction
EndState

_STA_SpankUtil Property SpankUtil Auto
