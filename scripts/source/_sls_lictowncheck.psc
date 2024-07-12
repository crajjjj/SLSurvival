Scriptname _SLS_LicTownCheck extends Quest

Event EnterRestrictedArea()
	;Debug.Messagebox("Enter restricted area")
	Utility.Wait(2.0)
	;Debug.Messagebox("Time: " + Utility.GetCurrentGameTime() + "\nLastLicCheckTime: " + LicUtil.LastLicCheckTime + "\nDifference: " + (Utility.GetCurrentGameTime() - LicUtil.LastLicCheckTime))
	If Utility.GetCurrentGameTime() - LicUtil.LastLicCheckTime > 0.0015 ; Don't check if entered via toll door (a full check is either already in progress or just finished)
		;Debug.Messagebox("Run check")
		_SLS_LicTownViolation.SetValueInt(0)
		PlayerRef.AddPerk(_SLS_ChaseDoorActivatePerk)
		LicUtil.SetIsPlayerAiDriven()
		RandomizeEnforcers()
		LicUtil.SetIsSlaverunFreeTownByPos()
		TownCheckPlayerAlias.GetShouldApproach()
	;Else
	;	Debug.Messagebox("Don't run check")
	EndIf
	BeginGuardEnforcers()
	_SLS_LicTownCheckPlayerAliasQuest.Start()
EndEvent

Event LeaveRestrictedArea()
	;Debug.Messagebox("Leave restricted area")
	_SLS_LicTownCheckPlayerAliasQuest.Stop()
	PlayerRef.RemovePerk(_SLS_ChaseDoorActivatePerk)
EndEvent

Event PlayerLocationChange(Int LocInt, Location akNewLoc)
	If Self.IsRunning()
		If LocInt >= 0 ;/&& akNewLoc != _SLS_KennelWhiterunLocation && (!akNewLoc || (akNewLoc && !akNewLoc.HasKeyword(LocTypePlayerHouse)))/;
			EnterRestrictedArea()
		Else
			LeaveRestrictedArea()
		EndIf
	EndIf
EndEvent

Function BeginGuardEnforcers()
	_SLS_LicTownCheckGuardAliases.Stop()
	Int Guards = Utility.RandomInt(EnforcerGuardsMin, EnforcerGuardsMax)
	If Guards
		_SLS_GuardEnforcerCount.SetValueInt(Guards)
		_SLS_LicTownCheckGuardAliases.Start()
	EndIf
EndFunction

Function RandomizeEnforcers()
	;Debug.Messagebox("RandomizeEnforcers()")
	Formlist FlSelect = LocTrack.GetEnforcerList()
	If FlSelect
		;Debug.Messagebox("Randomize enforcers - BEGIN")
		
		; Copy Formlist
		_SLS_LicTownBlank.Revert()
		Int i = FlSelect.GetSize()
		Actor Enforcer
		While i > 0
			i -= 1
			Enforcer = FlSelect.GetAt(i) as Actor
			Enforcer.Enable()
			If !Enforcer.IsDead()
				_SLS_LicTownBlank.AddForm(Enforcer)
			EndIf
		EndWhile
		
		Int EnforcerCount = Utility.RandomInt(Menu.EnforcersMin, Menu.EnforcersMax)
		If EnforcerCount > _SLS_LicTownBlank.GetSize()
			EnforcerCount = _SLS_LicTownBlank.GetSize()
		EndIf
		;Debug.Messagebox("Randomize enforcers - WAIT\nEnforcer Count: " + EnforcerCount)
		
		;Utility.Wait(2.0)
		While _SLS_LicTownBlank.GetSize() > EnforcerCount
			Enforcer = _SLS_LicTownBlank.GetAt(Utility.RandomInt(0, _SLS_LicTownBlank.GetSize() - 1)) as Actor
			Enforcer.Disable()
			_SLS_LicTownBlank.RemoveAddedForm(Enforcer)
		EndWhile
		;Debug.Messagebox("Randomize enforcers - END")
	EndIf
EndFunction

Int Property EnforcerGuardsMin = 3 Auto Hidden
Int Property EnforcerGuardsMax = 7 Auto Hidden

Actor Property PlayerRef Auto

Perk Property _SLS_ChaseDoorActivatePerk Auto

GlobalVariable Property _SLS_LicTownViolation Auto
GlobalVariable Property _SLS_GuardEnforcerCount Auto

Formlist Property _SLS_LicTownBlank Auto

Quest Property _SLS_LicTownCheckPlayerAliasQuest Auto
Quest Property _SLS_LicTownCheckGuardAliases Auto

Keyword Property LocTypePlayerHouse Auto

Location Property _SLS_KennelWhiterunLocation Auto

_SLS_LocTrackCentral Property LocTrack Auto
_SLS_LicTownCheckPlayerAlias Property TownCheckPlayerAlias Auto
_SLS_LicenceUtil Property LicUtil Auto
SLS_Mcm Property Menu Auto
