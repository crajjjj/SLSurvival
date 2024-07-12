Scriptname _SLS_InterfaceDeviousFollowers extends Quest  

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
	RegisterForSingleUpdate(15.0) ; 15 + 5 = 20
EndEvent

Event OnUpdate()
	PlayerLoadsGame()
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("DeviousFollowers.esp") != 255
		If GetState() != "Installed"
			Menu.BuildSexOptionsArrays()
			GoToState("Installed")
		EndIf
	
	Else
		If GetState() != ""
			Menu.BuildSexOptionsArrays()
			GoToState("")
		EndIf
	EndIf
	DfVersion = GetDfVersion()
	;Debug.Messagebox("_DFlow: " + _DFlow + "\nDfVersion: " + DfVersion)
EndFunction

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
	_DFlow = Game.GetFormFromFile(0x000D62,"DeviousFollowers.esp") as Quest
	_DFCrawlRequired = Game.GetFormFromFile(0x213D46,"DeviousFollowers.esp") as Keyword
EndEvent

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

State Installed
	Bool Function IsOldDeviousFollowers()
		If DfVersion <= 206
			Return true
		EndIf
		Return false
	EndFunction
	
	Int Function GetDfVersion()
		;Debug.Messagebox("DF version: " + StorageUtil.GetIntValue(_DFlow, "_DF_Version", Missing = 206))
		Return StorageUtil.GetIntValue(_DFlow, "_DF_Version", Missing = 206)
		;Return _SLS_IntDf.GetDfVersion(DfMcmQuest)
	EndFunction
	
	Function ModDfDebt(Float Amount) ; +Amount = add debt, -Amount = Remove debt
		
		If DfVersion >= 206
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
	
	Float Function UpdateWillLocal()
		Float Willpower = (Game.GetFormFromFile(0x01A2A7, "Update.esm") as GlobalVariable).GetValue()
		_SLS_DflowWill.SetValue(Willpower)
		Return Willpower
	EndFunction
	
	Float Function GetWillpower()
		Return (Game.GetFormFromFile(0x01A2A7, "Update.esm") as GlobalVariable).GetValue()
	EndFunction
	
	Function DecDflowWill(Float Amount = 0.0, Bool DoNotify = true)
		If DfVersion >= 206.0 ; New way
			Float Resist = (Game.GetFormFromFile(0x01A2A6, "Update.esm") as GlobalVariable).GetValue()
			If Resist > 0.0
				If Amount == 0.0
					Amount == Menu.DflowResistLoss
				EndIf
				SendModEvent("DF-ResistanceLoss", strArg = "", numArg = Amount)
				If Init.DebugMode
					Debug.Notification("Resistance decreased by " + Amount)
				ElseIf DoNotify
					Debug.Notification("Your resistance has decreased")
				EndIf
			EndIf
		
		Else ; Old way
			GlobalVariable _DWill = Game.GetFormFromFile(0x01A2A7, "Update.esm") as GlobalVariable
			Float Will = _DWill.GetValue()
			If Will > 0
				_DWill.SetValue(Will - 1)
				If DoNotify
					Debug.Notification("Your willpower has decreased to " + (Will - 1))
				EndIf
			EndIf
		EndIf
	EndFunction
	
	Function DecResistWithSeverity(Float Amount = 1.0, Bool DoNotify = true, String Severity)
		; DFC Version 2.09+ only
	
		;/ SEVERITY
		0 = slightly upsetting (cat called in slooty clothes)
		1 = the sort of thing you do not want to be reminded of (cat called, naked, covering) (follower zaps your nipples) / Self Degradation
		2 = you will remember this often, and wish you didn't (cat called, naked, not covering) (follower zaps your clitoral piercing) / Your clothes are stripped off/taken
		3 = you will never be quite the same again (follower pours stale cum all over you) / You whored yourself
		4 = part of you has died inside (raped) (beaten/whipped) (agreed to stay naked)
		5 = you wake up, gasping for breath and shaking often, as this haunts your nightmares (raped in devices) (agreed to whore yourself in a vile whore outfit)
		6 = you think of little else (raped by creatures) (follower enslaves you and whores your out in devices) (you agree to dog sex just to get an orgasm)
		7+ = maybe worse conceptually, but mechanically the same as 6
		/;
	
		;If DfVersion >= 206.0
			SendModEvent("DF-ResistanceLossWithSeverity", Severity, Amount)
			If Init.DebugMode
				Debug.Notification("Resistance decreased by " + Amount)
			ElseIf DoNotify
				Debug.Notification("Your resistance has decreased")
			EndIf
		;EndIf
	EndFunction
	
	Bool Function HasActorCrawlKeyword(Actor akTarget)
		Return akTarget.WornHasKeyword(_DFCrawlRequired)
	EndFunction
	
	Bool Function HasArmorCrawlKeyword(Armor akArmor)
		Return akArmor.HasKeyword(_DFCrawlRequired)
	EndFunction
	
	Bool Function AddDfFollower(ObjectReference followerToAddForm, Int debtToAdd, Bool forceGoldControlMode, Float minimumContractDays)
		; Wait for fix - unfilled property FollowerController in _Dtick
		;/
		If DfVersion >= 211
			Debug.Messagebox("Send event")
			Debug.Trace("SLS_: Send DFC event")
			;"DF-AddFollower" (Form followerToAddForm, Int debtToAdd, Bool forceGoldControlMode, Float minimumContractDays)
			Int AddDf = ModEvent.Create("DF-AddFollower")
			If (AddDf)
				ModEvent.PushForm(AddDf, followerToAddForm)
				ModEvent.PushInt(AddDf, debtToAdd)
				ModEvent.PushBool(AddDf, forceGoldControlMode)
				ModEvent.PushFloat(AddDf, minimumContractDays)
				ModEvent.Send(AddDf)
			EndIf
			Return true
		Else
			Return false
		EndIf
		/;
		Return false
	EndFunction
EndState

Bool Function IsOldDeviousFollowers()
	Return true
EndFunction

Int Function GetDfVersion()
	Return -1
EndFunction

Function ModDfDebt(Float Amount)
EndFunction

Float Function UpdateWillLocal()
	Return 10.0
EndFunction

Float Function GetWillpower()
	Return 10.0
EndFunction

Function DecDflowWill(Float Amount = 0.0, Bool DoNotify = true)
EndFunction

Function DecResistWithSeverity(Float Amount = 1.0, Bool DoNotify = true, String Severity)
EndFunction

Bool Function HasActorCrawlKeyword(Actor akTarget)
	Return false
EndFunction

Bool Function HasArmorCrawlKeyword(Armor akArmor)
	Return false
EndFunction

Bool Function AddDfFollower(ObjectReference followerToAddForm, Int debtToAdd, Bool forceGoldControlMode, Float minimumContractDays)
	Return false
EndFunction

Quest _DFlow

Int DfVersion = -1

GlobalVariable Property _SLS_DflowWill Auto

Keyword Property _DFCrawlRequired Auto Hidden

SLS_Mcm Property Menu Auto
SLS_Init Property Init Auto
