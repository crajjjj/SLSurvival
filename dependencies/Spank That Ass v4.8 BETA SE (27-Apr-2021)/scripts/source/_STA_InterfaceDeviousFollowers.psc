Scriptname _STA_InterfaceDeviousFollowers extends Quest

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
	If Game.GetModByName("DeviousFollowers.esp") != 255
		If GetState() != "Installed"
			GoToState("Installed")
		EndIf
	
	Else
		If GetState() != ""
			GoToState("")
		EndIf
	EndIf
	DfVersion = GetDfVersion()
EndFunction

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
	DfMcmQuest = Game.GetFormFromFile(0x00C545,"DeviousFollowers.esp") as Quest
EndEvent

; Installed =======================================
State Installed
	Float Function GetDfVersion()
		Return _STA_IntDflow.GetDfVersion(DfMcmQuest)
	EndFunction
	
	Function ModDfDebt(Float Amount) ; +Amount = add debt, -Amount = Remove debt
		
		If DfVersion >= 206.0
			SendModEvent("DF-DebtAdjust", strArg = "", numArg = Amount)
		Else
			; Old method - Versions < 2.06
			GlobalVariable Debt = Game.GetFormFromFile(0x00C54F, "DeviousFollowers.esp") as GlobalVariable
			Float CurDebt = Debt.GetValue()
			CurDebt += Amount
			If CurDebt < 0
				CurDebt = 0
			EndIf
			Debt.SetValue(CurDebt)
		EndIf
	EndFunction
	
	Function UpdateWillLocal()
		_STA_DflowWill.SetValue((Game.GetFormFromFile(0x01A2A7, "Update.esm") as GlobalVariable).GetValue())
	EndFunction
	
	Function DecDflowWill(String SlapString)
		If DfVersion >= 206.0
			;Float Resist = (Game.GetFormFromFile(0x01A2A6, "Update.esm") as GlobalVariable).GetValue()
			;If Resist > 0.0
			Float ResistLoss = DflowResistLoss
			If ModEventResistLoss > 0.0 ; Use event resist loss if higher than 0.0
				ResistLoss = ModEventResistLoss
			EndIf
			SendModEvent("DF-ResistanceLoss", strArg = "", numArg = ResistLoss)
				;Debug.Notification("Your resistance has decreased")
			;EndIf
		
		Else
			GlobalVariable _DWill = Game.GetFormFromFile(0x01A2A7, "Update.esm") as GlobalVariable
			Float Will = _DWill.GetValue()
			If Will > 0
				_DWill.SetValue(Will - 1)
				Debug.Notification("Your " + SlapString + " starting to feel tender along with your ego: Willpower: " + (Will - 1))
				;Debug.Notification("Your willpower has decreased to " + (Will - 1))
			EndIf
		EndIf
	EndFunction
EndState

; Not Installed ====================================

Float Function GetDfVersion()
	Return -1.0
EndFunction

Function ModDfDebt(Float Amount)
EndFunction

Function UpdateWillLocal()
EndFunction

Function DecDflowWill(String SlapString)
EndFunction

Quest DfMcmQuest

Float DfVersion = -1.0

Float Property DflowResistLoss = 1.0 Auto Hidden
Float Property ModEventResistLoss = -1.0 Auto Hidden

GlobalVariable Property _STA_DflowWill Auto
