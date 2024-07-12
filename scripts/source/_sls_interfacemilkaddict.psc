Scriptname _SLS_InterfaceMilkAddict extends Quest  

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("Milk Addict.esp") != 255
		If GetState() != "Installed"
			;GoToState("Installed")
			GoToState("")
		EndIf
	
	Else
		If GetState() != ""
			GoToState("")
		EndIf
	EndIf
EndFunction

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
	MaMcmQuest = Game.GetFormFromFile(0x000D62,"Milk Addict.esp") as Quest
	AddictionPool = Game.GetFormFromFile(0x008424, "Milk Addict.esp") as GlobalVariable
	MaMainAlias = (Game.GetFormFromFile(0x000D62, "Milk Addict.esp") as Quest).GetNthAlias(0) as ReferenceAlias
EndEvent

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

State Installed
	Int Function GetMilkDuration(Float MilkLevel)
		If MilkLevel == 5.0 ; Dilute
			Return _SLS_IntMa.GetDurDilute(MaMcmQuest)
		ElseIf MilkLevel == 10.0 ; Weak
			Return _SLS_IntMa.GetDurWeak(MaMcmQuest)
		ElseIf MilkLevel == 15.0 ; Regular
			Return _SLS_IntMa.GetDurRegular(MaMcmQuest)
		ElseIf MilkLevel == 20.0 ; Strong
			Return _SLS_IntMa.GetDurStrong(MaMcmQuest)
		ElseIf MilkLevel == 25.0 ; Tasty
			Return _SLS_IntMa.GetDurTasty(MaMcmQuest)
		ElseIf MilkLevel == 30.0 ; Creamy
			Return _SLS_IntMa.GetDurCreamy(MaMcmQuest)
		ElseIf MilkLevel == 35.0 ; Enriched
			Return _SLS_IntMa.GetDurEnriched(MaMcmQuest)
		ElseIf MilkLevel == 40.0 ; Sublime
			Return _SLS_IntMa.GetDurSublime(MaMcmQuest)
		Else
			Debug.Trace("_SLS_: GetMilkDuration: No match")
		EndIf
	EndFunction
	
	String Function GetAddictionLevel()
		Int Pool = AddictionPool.GetValueInt()
		If Pool > 399
			Return "Junkie"
		ElseIf Pool > 299
			Return "Addict"
		ElseIf Pool > 199
			Return "Moderate"
		ElseIf Pool > 99
			Return "Mild"
		EndIf
		Return ""
	EndFunction
	
	String Function GetWithdrawalLevel()
		Int Withdrawal = _SLS_IntMa.GetCurrentEffectsStage(MaMainAlias)
		If Withdrawal == 4 ; Junkie
			Return "Junkie "
		ElseIf Withdrawal == 3 ; Addict
			Return "Addict "
		ElseIf Withdrawal == 2 ; Moderate
			Return "Moderate "
		ElseIf Withdrawal == 1 ; Mild
			Return "Mild "
		Else
			Return "None"
		EndIf
	EndFunction
EndState

Int Function GetMilkDuration(Float MilkLevel)
	Return -1
EndFunction

String Function GetAddictionLevel()
	Return ""
EndFunction

String Function GetWithdrawalLevel()
	Return ""
EndFunction

Quest MaMcmQuest
ReferenceAlias MaMainAlias

GlobalVariable AddictionPool

Actor Property PlayerRef Auto
