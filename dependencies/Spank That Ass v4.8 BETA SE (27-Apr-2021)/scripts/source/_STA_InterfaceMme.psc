Scriptname _STA_InterfaceMme extends Quest  

Event OnInit()
	RegisterForModEvent("_STA_Int_PlayerLoadsGame", "On_STA_Int_PlayerLoadsGame")
	RegisterForSingleUpdate(15.0)
EndEvent

Event OnUpdate()
	PlayerLoadsGame()
EndEvent

Event On_STA_Int_PlayerLoadsGame()
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("MilkModNEW.esp") != 255
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

; Installed =======================================
State Installed
	Function BoobLeak()
		If !IsLeakingMilk()
			_STA_IntMme.BoobLeak(MME_MilkQUEST, PlayerRef)
		EndIf
	EndFunction

	Bool Function IsLeakingMilk()
		If PlayerRef.HasMagicEffect(MME_MilkLeakL)
			Return true
		Else
			Return false
		EndIf
	EndFunction
EndState

; Not Installed ====================================

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
	MME_MilkQUEST = Game.GetFormFromFile(0x00E209, "MilkModNEW.esp") as Quest
	MME_MilkLeakL = Game.GetFormFromFile(0x030898, "MilkModNEW.esp") as MagicEffect
EndEvent

Function BoobLeak()
EndFunction

Bool Function IsLeakingMilk()
	Return false
EndFunction

Actor Property PlayerRef Auto

Quest MME_MilkQUEST

MagicEffect MME_MilkLeakL
