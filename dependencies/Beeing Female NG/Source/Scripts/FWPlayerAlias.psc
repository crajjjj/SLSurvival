Scriptname FWPlayerAlias extends ReferenceAlias  

FWSystem property System auto
FWTextContents property Contents auto

spell property CloakAbility auto
actor property PlayerRef auto
int property Interval Auto
spell property BeeingFemaleSpell auto
spell property BeeingMaleSpell auto
spell property BeeingNUFemaleSpell auto

Race Property ElderRace Auto
Race Property ElderRaceVampire Auto

Globalvariable property CloakingSpellEnabled auto

Perk Property _BFPCP_PlayerMenstruation Auto

Armor kArmorItem

int oldSex = 0
Int iStateUpdateInterval

;Tkc (Loverslab): properties for reworked scan
Quest Property FindActors Auto ;Scanquest
ReferenceAlias[] Property FoundFemales Auto ; Female aliases from scanquest
ReferenceAlias[] Property FoundMales Auto ; Male aliases from scanquest


FWPantyWidget property PantyWidget auto
armor property Sanitary_Napkin_Normal auto
armor property Tampon_Normal auto
spell property Effect_VaginalBloodLow auto
spell property Effect_VaginalBloodHigh auto
Globalvariable property ModEnabled auto

Event OnInit()
	;RegisterForSingleUpdate(1)
	
	If self
		Actor SelfActor = GetReference() as Actor
		if(SelfActor)
			oldSex = SelfActor.GetActorBase().GetSex()
		endIf
	EndIf
	OnPlayerLoadGame()
	;RegisterForMenu("RaceSex Menu")
EndEvent

Event OnMenuOpen(string menuName)
	if menuName=="RaceSex Menu"
		oldSex=PlayerRef.GetLeveledActorBase().GetSex()
		;System.Message("Race Menu open",System.MSG_Debug)
		if System.Player;/!=none/; ;by Tkc (Loverslab)
			System.Player.ResetBelly()
		endif
	endIf
endEvent

Event OnMenuClose(string menuName)
	if menuName=="RaceSex Menu"
		;System.Message("Race Menu closed",System.MSG_Debug)
		
		System.CheckPlayerSex()
		
		if System.Player;/!=none/; ;Tkc (Loverslab): optimization
			System.Player.GetBaseMeasurements(true)
			System.Player.SetBelly()
		endif
	endIf
endEvent

Event OnUpdate()
	GoToState("Processing")
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	;if CloakingSpellEnabled.GetValueInt();/==1/; && System.ModEnabled.GetValueInt();/==1/; ;Tkc (Loverslab): optimization; commented because onenterstate same conditions
		RegisterForSingleUpdate(0.25)
	;EndIf
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	PantyWidget.UpdateContent()
	kArmorItem = akBaseObject as Armor
	if kArmorItem
	  	If (kArmorItem == Sanitary_Napkin_Normal || kArmorItem == Tampon_Normal)
			PlayerRef.DispelSpell(Effect_VaginalBloodLow)				
			PlayerRef.DispelSpell(Effect_VaginalBloodHigh)
		Endif
	EndIf
EndEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	PantyWidget.UpdateContent()
EndEvent

Function OnModReset() ;***Added by Bane
	RegisterForSingleUpdate(5)
	UnregisterForAllMenus()
	RegisterForMenu("RaceSex Menu")
EndFunction

Event OnPlayerLoadGame()
	RegisterForSingleUpdate(2.5)
	UnregisterForAllMenus()
	RegisterForMenu("RaceSex Menu")
	Utility.WaitMenuMode(1)
	System.OnGameLoad()
	Interval = 15
	If PlayerRef.HasPerk(_BFPCP_PlayerMenstruation);by Tkc (Loverslab)
	else;If !PlayerRef.HasPerk(_BFPCP_PlayerMenstruation)
		PlayerRef.AddPerk(_BFPCP_PlayerMenstruation)
	EndIf
EndEvent

Event OnRaceSwitchComplete()
	System.Message(Contents.RaceSwitchedCompleted,System.MSG_Debug)
	
	Actor SelfActor = GetReference() as Actor
	int newSex = SelfActor.GetActorBase().GetSex() ;Tkc (Loverslab): optimization ; will be using three times after this
	If oldSex == newSex
	else;If oldSex != GetActorReference().GetActorBase().GetSex()
		If newSex == 0;"if male"
			If (SelfActor.HasSpell(BeeingMaleSpell)) ;Tkc (Loverslab): optimization
			else;If (! GetActorReference().HasSpell(BeeingMaleSpell))
				SelfActor.AddSpell(BeeingMaleSpell)
			EndIf
			If (SelfActor.HasSpell(BeeingFemaleSpell))
				SelfActor.RemoveSpell(BeeingFemaleSpell)
			EndIf
		Else;"if female"
			If (SelfActor.HasSpell(BeeingFemaleSpell)) ;Tkc (Loverslab): optimization
			else;If (! GetActorReference().HasSpell(BeeingFemaleSpell))
				SelfActor.AddSpell(BeeingFemaleSpell)
			EndIf
			If (SelfActor.HasSpell(BeeingMaleSpell)) ;Tkc (Loverslab): fix here. Removed '!'
				SelfActor.RemoveSpell(BeeingMaleSpell)
			EndIf
		EndIf
		oldSex = newSex
	EndIf
EndEvent

; Quest alias conditions (FindActors) pre-filter: Is3DLoaded, IsChild, IsInCombat, HasMagicEffect BF/BM, distance, race, etc.
; Actors reaching here have the spell but its effect is not running, or need the spell added.
; Removes opposite spell on add to handle gender-change scenarios.
Function ProcessActor(Actor akTarget, bool IsFemale = true)
	if akTarget
		if IsFemale
			if akTarget.HasSpell(BeeingFemaleSpell)
				akTarget.RemoveSpell(BeeingFemaleSpell) ; effect not running, remove so it re-applies next cycle
				Return
			else
				akTarget.AddSpell(BeeingFemaleSpell)
				akTarget.RemoveSpell(BeeingMaleSpell)
			endif
		else
			if akTarget.HasSpell(BeeingMaleSpell)
				akTarget.RemoveSpell(BeeingMaleSpell) ; effect not running, remove so it re-applies next cycle
				Return
			else
				akTarget.AddSpell(BeeingMaleSpell)
				akTarget.RemoveSpell(BeeingFemaleSpell)
			endif
		Endif
		Utility.WaitMenuMode(0.5)
	Endif
EndFunction

State Processing

	Event OnBeginState()
		iStateUpdateInterval = Interval
		;If CloakingSpellEnabled.GetValueInt();/==1/; && System.ModEnabled.GetValueInt();/==1/;  ;Tkc (Loverslab): optimization
		If ModEnabled.GetValue() As int ;Tkc (Loverslab): optimization
		If CloakingSpellEnabled.GetValue() As int
			;/Actor[] CellActors = MiscUtil.ScanCellNPCs(PlayerRef, 2048.0)
			Int iActorIdx = CellActors.Length
			;debug.trace("BF: Checking " + iActorIdx + " actors for BF spells")
			While iActorIdx
				iActorIdx -=1
				ProcessActor(CellActors[iActorIdx])
			EndWhile/;
			;;;;;;;;;;;;;;;;;;;
			; Tkc (Loverslab): Get actors by ScanQuest aliases
			;Added conditions for aliases:
			;get distance to Player < 2048
			;IsActor==1
			;Is3DLoaded==1
			;IsInCombat==0
			;IsMale\IsFemale == 1
			;IsCommandedActor==0
			;IsChild==0
			;GetVoiceType=ChildVoice==0
			;GetRace>ElderRace==0
			;IsGhost==0
			;HasMagicEffect BF\BM == 0
			;;All equal conditions in the script do not need anymore		
			FindActors.Start()
			Utility.Wait(0.5)
			Int iActorIdx = FoundFemales.Length
				;debug.trace("BF: Checking " + iActorIdx + " males and females for BF spells")
			While iActorIdx
				iActorIdx -=1
					;debug.trace("BF: Checking #" + iActorIdx + " female actor alias ='" + FoundFemales[iActorIdx].GetActorReference() + "'.")
				ProcessActor(FoundFemales[iActorIdx].GetReference() as Actor)
					;debug.trace("BF: Checking #" + iActorIdx + " male actor alias ='" + FoundMales[iActorIdx].GetActorReference() + "'.")
				ProcessActor(FoundMales[iActorIdx].GetReference() as Actor, false)
			EndWhile
			FindActors.Stop()
			;;;;;;;;;;;;;;;;;
		EndIf
		EndIf
		;FW_log.WriteLog("- Register for single update("+Interval+")")
		GoToState("")
	EndEvent

	Event OnUpdate()
		;Catch Any pending events
	EndEvent

	Event OnLocationChange(Location akOldLoc, Location akNewLoc)
		iStateUpdateInterval = 5
	EndEvent

	Event OnEndState()
		RegisterForSingleUpdate(iStateUpdateInterval)
	EndEvent

EndState