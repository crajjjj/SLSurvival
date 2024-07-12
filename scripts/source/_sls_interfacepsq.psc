Scriptname _SLS_InterfacePsq extends Quest  

Quest PsqQuest

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("PSQ PlayerSuccubusQuest.esm") != 255
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
	PsqQuest = Game.GetFormFromFile(0x000D62,"PSQ PlayerSuccubusQuest.esm") as Quest
EndEvent

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

State Installed
	Bool Function PlayerIsSuccubus()
		If (Game.GetFormFromFile(0x000DAF, "PSQ PlayerSuccubusQuest.esm") as GlobalVariable).GetValueInt() == 1
			Return true
		EndIf
		Return false
	EndFunction
	
	Float Function GetEnergyMax()
		Return _SLS_IntPsq.GetEnergyMax(PsqQuest)
	EndFunction
	
	Int Function GetSuccubusRank()
		Return (Game.GetFormFromFile(0x000DB0, "PSQ PlayerSuccubusQuest.esm") as GlobalVariable).GetValueInt()
	EndFunction
	
	Function AddSuccubusEnergy(Float Amount, Bool UpdateDisplay = true)
		;Debug.Messagebox("AddSuccubusEnergy: Amount: " + Amount)
		If PlayerIsSuccubus()
			Float EnergyMax = GetEnergyMax()
			GlobalVariable SuccubusEnergy = Game.GetFormFromFile(0x000DAD, "PSQ PlayerSuccubusQuest.esm") as GlobalVariable
			Amount = SuccubusEnergy.GetValue() + Amount
			If Amount > EnergyMax
				Amount = EnergyMax
			EndIf
			SuccubusEnergy.SetValue(Amount)
			If UpdateDisplay
				UpdateEnergyBar()
			EndIf
		EndIf
	EndFunction
	
	Function UpdateEnergyBar()
		Float Manpukudo = (Game.GetFormFromFile(0x000DAD, "PSQ PlayerSuccubusQuest.esm") as GlobalVariable).GetValue() / GetEnergyMax()
		_SLS_IntPsq.UpdateEnergyBar(PsqQuest, Manpukudo)
	EndFunction
EndState

Bool Function PlayerIsSuccubus()
	Return false
EndFunction

Float Function GetEnergyMax()
	Return 0.0
EndFunction

Int Function GetSuccubusRank()
	Return 0
EndFunction

Function AddSuccubusEnergy(Float Amount, Bool UpdateDisplay = true)
EndFunction

Function UpdateEnergyBar()
EndFunction
