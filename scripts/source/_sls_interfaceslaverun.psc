Scriptname _SLS_InterfaceSlaverun extends Quest Conditional

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("Slaverun_Reloaded.esp") != 255
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

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
	SLV_PlayerIsSlaveOfSlaverun = Game.GetFormFromFile(0x8C4B40, "Slaverun_Reloaded.esp") as GlobalVariable
	SlvUtilQuest = Game.GetFormFromFile(0x07ACEE, "Slaverun_Reloaded.esp") as Quest
	SlvLocCheckQuest = Game.GetFormFromFile(0x00182E, "Slaverun_Reloaded.esp") as Quest
	SlvEnslaveProgQuest = Game.GetFormFromFile(0x08D7BD, "Slaverun_Reloaded.esp") as Quest
EndEvent

; Installed ==============================================================
State Installed
	Bool Function IsPlayerSlaverunSlave()
		Bool Result = SLV_PlayerIsSlaveOfSlaverun.GetValue() as Bool
		Init.IsSlaverunSlave = Result
		Return Result
	EndFunction

	Function DecreaseResistance(Bool Increase = true, int value = 1)	
		_SLS_IntSlvrun.DecreaseResistance(Increase = true, value = 1, SlvUtilQuest = SlvUtilQuest)
	EndFunction
	
	Function BeginSlaverun()
		_SLS_IntSlvrun.BeginSlaverun(SlvEnslaveProgQuest)
	EndFunction
	
	; True = free. False = Enslaved
	; Cities
	Bool Function IsFreeTownWhiterun()
		Return _SLS_IntSlvrun.IsFreeTownWhiterun(SlvLocCheckQuest)
	EndFunction
	
	Bool Function IsFreeTownRiften()
		Return _SLS_IntSlvrun.IsFreeTownRiften(SlvLocCheckQuest)
	EndFunction

	Bool Function IsFreeTownWindhelm()
		Return _SLS_IntSlvrun.IsFreeTownWindhelm(SlvLocCheckQuest)
	EndFunction

	Bool Function IsFreeTownMarkarth()
		Return _SLS_IntSlvrun.IsFreeTownMarkarth(SlvLocCheckQuest)
	EndFunction

	Bool Function IsFreeTownSolitude()
		Return _SLS_IntSlvrun.IsFreeTownSolitude(SlvLocCheckQuest)
	EndFunction
	
	; Towns
	Bool Function IsFreeTownRiverwood()
		Return _SLS_IntSlvrun.IsFreeTownRiverwood(SlvLocCheckQuest)
	EndFunction

	Bool Function IsFreeTownFalkreath()
		Return _SLS_IntSlvrun.IsFreeTownFalkreath(SlvLocCheckQuest)
	EndFunction

	Bool Function IsFreeTownDawnstar()
		Return _SLS_IntSlvrun.IsFreeTownDawnstar(SlvLocCheckQuest)
	EndFunction

	Bool Function IsFreeTownMorthal()
		Return _SLS_IntSlvrun.IsFreeTownMorthal(SlvLocCheckQuest)
	EndFunction

	Bool Function IsFreeTownWinterhold()
		Return _SLS_IntSlvrun.IsFreeTownWinterhold(SlvLocCheckQuest)
	EndFunction

	Bool Function IsFreeTownRavenRock()
		Return _SLS_IntSlvrun.IsFreeTownRavenRock(SlvLocCheckQuest)
	EndFunction

;/
	Bool Function IsInFreeArea(Location PlayerLoc)
		If PlayerRef.IsInInterior()
			;Location PlayerLoc = PlayerRef.GetCurrentLocation()
			If PlayerLoc
				Formlist FlSelect
				Int i = 0
				While i < _SLS_LocsAll.GetSize()
					FlSelect = _SLS_LocsAll.GetAt(i) as Formlist
					If FlSelect.HasForm(PlayerLoc)
						Return LocResolver.GetIsFreeTown(i)
					EndIf
					i += 1
				EndWhile
			EndIf
		Else
			If LastTracker.Is3dLoaded()
				Int i = _SLS_LocTrackersAll.Find(LastTracker)
				If i >= 5 ; Is not a walled city
					If LocResolver.GetIsFreeTown(i)
						Return true
					Else
						Return PlayerRef.GetDistance(LastTracker) > 12000.0
					EndIf
				Else
					Return LocResolver.GetIsFreeTown(i)
				EndIf
			EndIf
		EndIf
		Return true
	EndFunction
/;
	Bool Function IsFreeArea(Location akLocation)
		Return LocOps.GetIsFreeTownByString(LocTrack.ResolveLocation(akLocation))
	EndFunction
	
	Bool Function IsFreeAreaByString(String Town)
		Return LocOps.GetIsFreeTownByString(Town)
	EndFunction
EndState

; NOT Installed ==============================================================

Bool Function IsPlayerSlaverunSlave()
	Init.IsSlaverunSlave = false
	Return false
EndFunction
	
Function DecreaseResistance(Bool Increase = true, int value = 1)
EndFunction

Function BeginSlaverun()
EndFunction

; True = free. False = Enslaved
; Cities
Bool Function IsFreeTownWhiterun()
	Return true
EndFunction

Bool Function IsFreeTownRiften()
	Return true
EndFunction

Bool Function IsFreeTownWindhelm()
	Return true
EndFunction

Bool Function IsFreeTownMarkarth()
	Return true
EndFunction

Bool Function IsFreeTownSolitude()
	Return true
EndFunction

; Towns
Bool Function IsFreeTownRiverwood()
	Return true
EndFunction

Bool Function IsFreeTownFalkreath()
	Return true
EndFunction

Bool Function IsFreeTownDawnstar()
	Return true
EndFunction

Bool Function IsFreeTownMorthal()
	Return true
EndFunction

Bool Function IsFreeTownWinterhold()
	Return true
EndFunction

Bool Function IsFreeTownRavenRock()
	Return true
EndFunction

Bool Function IsFreeArea(Location akLocation)
	Return true
EndFunction

Bool Function IsFreeAreaByString(String Town)
	Return true
EndFunction

Quest SlvUtilQuest
Quest SlvLocCheckQuest
Quest SlvEnslaveProgQuest

GlobalVariable Property SLV_PlayerIsSlaveOfSlaverun Auto Hidden

SLS_Init Property Init Auto
_SLS_LocTrackCentral Property LocTrack Auto
_SLS_LocationOpsSpecific Property LocOps Auto
