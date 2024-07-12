Scriptname _STA_Api extends Quest  

Event OnInit()
	If Self.IsRunning()
		RegisterForModEvent("_STA_SpankBasicAss", "On_STA_SpankBasicAss")
		RegisterForModEvent("_STA_SpankBasicTits", "On_STA_SpankBasicTits")
	EndIf
EndEvent

Event On_STA_SpankBasicAss(string eventName, string strArg, float numArg, Form sender)
	SpankHandle.SpankBasicAss()
EndEvent

Event On_STA_SpankBasicTits(string eventName, string strArg, float numArg, Form sender)
	SpankHandle.SpankBasicTits()
EndEvent

_STA_ApiSpankHandler Property SpankHandle Auto
