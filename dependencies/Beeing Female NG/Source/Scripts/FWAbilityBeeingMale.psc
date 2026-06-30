Scriptname FWAbilityBeeingMale extends FWAbilityBeeingBase

Bool IsSpouse

GlobalVariable Property ModEnabled Auto
Spell Property BeeingMaleSpell Auto
Spell Property BeeingFemaleSpell Auto
MagicEffect Property _BFAbilityEffectBeeingMale Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if ModEnabled.GetValue() As int ;Tkc (Loverslab): optimization
	else;if System.ModEnabled.GetValueInt()!=1
		Self.Dispel()
		Return
	endif
	;IsPlayer = (akTarget == Game.GetPlayer())
	IsPlayer = (akTarget == PlayerRef) ;Tkc (Loverslab): optimization. PlayerRef added in FWAbilityBeeingBase
	IsFollower = akTarget.IsInFaction(System.FollowerFaction)
	IsSpouse = akTarget.IsInFaction(PlayerMarriedFaction)
	parent.OnEffectStart(akTarget, akCaster)
	ActorRef = akTarget
	ActorRefBase = akTarget.GetLeveledActorBase() ;Tkc (Loverslab): optimization. was not used anywhere but added it below
	If IsPlayer
		System.PlayerMale = Self
		System.Player = none
	EndIf

	if ActorRef.HasMagicEffect(_BFAbilityEffectBeeingMale)
		If IsPlayer || IsFollower || IsSpouse ;Bane 04/07/19: Stack Dump Prevention - For NPC's effect is reapplied on every location change, a 5 hourly update check on non-followers/spouses is unecessary
			RegisterForSingleUpdateGameTime(5)
		EndIf
		RegisterForSleep()
		;If IsPlayer
		;	RegisterForSingleUpdate(5) ;Tkc (Loverslab): optimization, commented because there is no male actions in parent OnUpdate function of FWAbilityBeeingBase script
		;EndIf
	Else
		Return
	endif
	bInitSpell=true
	OnPlayerLoadGame()
EndEvent

function OnPlayerLoadGame()
	if bInit;/==true/; && bInitSpell;/==true/; ;&& Self as String != "[FWAbilityBeeingMale <None>]"
		Utility.WaitMenuMode(1)
		;IsFollower = ActorRef.IsInFaction(System.FollowerFaction) && IsPlayer == false - Never true as only received by the player
		Controller.UpdateParentFaction(ActorRef)
		equipChild()
	endif
endfunction

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	;If System && (System.PlayerMale == Self)
	If System ;Tkc (Loverslab): optimization
		if (System.PlayerMale == Self)
			System.PlayerMale = None
		EndIf
	EndIf
	;If ActorRef && ActorRef.HasSpell(System.BeeingMaleSpell)
	If ActorRef ;Tkc (Loverslab): optimization
		if ActorRef.HasSpell(BeeingMaleSpell)
			ActorRef.RemoveSpell(BeeingMaleSpell)
		EndIf
	EndIf
EndEvent

;Event OnUpdate()
	;RegisterForSingleUpdate(5) ;Tkc (Loverslab): optimization, commented because there is no male actions in parent OnUpdate function of FWAbilityBeeingBase script
	;parent.OnUpdate()
;EndEvent

Event OnUpdateGameTime()
	if System ;Tkc (Loverslab): optimization
	else;if System==none
		return
	endif
	if Controller ;Tkc (Loverslab): optimization
	else;if System.Controller == none
		return
	endif
	Controller.UpdateParentFaction(ActorRef)
	if ActorRefBase.GetSex();!=0 ;Tkc (Loverslab): optimization
		if ActorRef.HasSpell(BeeingFemaleSpell) ;Tkc (Loverslab): optimization
		else;if ActorRef.HasSpell(System.BeeingFemaleSpell)==false
			;if System.IsValidateActor(ActorRef)>0
			if System.IsValidateFemaleActor(ActorRef)>0 ;Tkc (Loverslab): optimization, changed to validated female because here is only female actions and it will be faster
				ActorRef.AddSpell(BeeingFemaleSpell)
			endif
		endif
		Self.Dispel()
		Return
	endif
	if IsPlayer
		if System.PlayerMale ;Tkc (Loverslab): optimization
		else;if System.PlayerMale==none
			System.PlayerMale=self
			System.Player=none
		endif
	endif
	If ActorRef.HasMagicEffect(_BFAbilityEffectBeeingMale)
		if Self as String == "[FWAbilityBeeingMale <None>]"
		else;if Self as String != "[FWAbilityBeeingMale <None>]"
			RegisterForSingleUpdateGameTime(5)
		EndIf
	EndIf
endEvent

; 07 jule 2019 Tkc (Loverslab) optimizations: Changes marked with "Tkc (Loverslab)" comment