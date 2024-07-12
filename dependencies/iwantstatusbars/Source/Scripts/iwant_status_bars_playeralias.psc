ScriptName iWant_Status_Bars_PlayerAlias extends ReferenceAlias
 
iWant_Status_Bars Property iBars Auto
 
Event OnPlayerLoadGame()
	Debug.Trace("iWant Status Bars:  Player alias detected OnPlayerLoadGame")
	iBars.GameLoad()
EndEvent
