Scriptname _SLS_CombatEquip extends ReferenceAlias  

Event OnInit()
	RegisterForModEvent("_SLS_PlayerCombatChange", "On_SLS_PlayerCombatChange")
EndEvent

Event On_SLS_PlayerCombatChange(Bool InCombat)
	If InCombat
		GoToState("InCombat")
	Else
		GoToState("")
	EndIf
EndEvent

; IN COMBAT =======================================================================

State InCombat
	Event OnBeginState()
		;Debug.Notification("In combat state")
		_SLS_CombatEquipFormlist.Revert()
		RegisterForSingleUpdate(2.0)
	EndEvent

	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		If IsItemOfInterest(akBaseObject)
			_SLS_CombatEquipFormlist.AddForm(akBaseObject)
			;If Menu.CombatEquipWaitPerItemT
				Timer = ;/Menu.CombatEquipTime/; 2.0 * _SLS_CombatEquipFormlist.GetSize()
			;Else
				;Timer = ;/Menu.CombatEquipTime/; 2.0
			;EndIf
			If !IsInProc
				IsInProc = true
				WasInterrupted = false
				RegForControls()
				;Debug.SendAnimationEvent(PlayerRef, "Arrok_Undress_G1") ; Better but SendAnimationEvent(IdleStop) doesn't interrupt it for some reason
				If PlayerRef.IsWeaponDrawn()
					PlayerRef.SheatheWeapon()
					Float Countdown = 2.0
					While Countdown > 0.0 && !WasInterrupted
						Utility.Wait(0.1)
						Countdown -= 0.1
					EndWhile
				EndIf
				If !WasInterrupted
					Debug.SendAnimationEvent(PlayerRef, "IdleWarmHandsCrouched")
				EndIf
				While Timer > 0.0 && !WasInterrupted
					Timer -= 0.1
					Utility.Wait(0.1)
				EndWhile
				UnRegisterForAllControls()
				Debug.SendAnimationEvent(PlayerRef, "IdleStop")
				;Debug.Messagebox("WasInterrupted: " + WasInterrupted)
				If !WasInterrupted
					Int FinishSound = _SLS_ITMGenericArmorUpSM.Play(PlayerRef)
					Sound.SetInstanceVolume(FinishSound, 2.0)
					_SLS_CombatEquipFormlist.Revert()
				EndIf
				IsInProc = false
			EndIf
		EndIf
	EndEvent
	
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		If IsInProc
			Interrupt()
		EndIf
	EndEvent
	
	Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
		If IsInProc
			If akEffect.HasKeyword(MagicDamageFire) || akEffect.HasKeyword(MagicDamageFrost) || akEffect.HasKeyword(MagicDamageShock)
				Interrupt()
			EndIf
		EndIf
	EndEvent
	
	Event OnControlDown(string control)
		If IsInProc
			Interrupt()
		EndIf
	EndEvent
	
	Event OnUpdate()
		If PlayerRef.IsInCombat()
			RegisterForSingleUpdate(2.0)
		Else
			UnRegisterForUpdate()
			GoToState("")
		EndIf
	EndEvent
EndState

Function Interrupt()
	WasInterrupted = true
	UnRegisterForAllControls()
	Debug.SendAnimationEvent(PlayerRef, "IdleStop")
	CancelEquips()
EndFunction

; NOT IN COMBAT =====================================================================

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
EndEvent

Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
EndEvent

Event OnControlDown(string control)
EndEvent

Event OnBeginState()
	;Debug.Notification("NOT in combat state")
EndEvent

; FUNCTIONS ===========================================================================

Bool Function IsItemOfInterest(Form akForm)
	If akForm as Armor && akForm.GetName() && !akForm.HasKeyword(SexlabNoStrip) && !Util.HasZazInvKeyword(akForm) && !_SLS_LicExceptionsArmor.HasForm(akForm) && !Math.LogicalAnd((akForm as Armor).GetSlotMask(), 512) == 512
		Return true
	EndIf
	Return false
EndFunction

Function CancelEquips()
	Int i = _SLS_CombatEquipFormlist.GetSize()
	While i > 0
		i -= 1
		PlayerRef.UnequipItem(_SLS_CombatEquipFormlist.GetAt(i), abPreventEquip = false, abSilent = true)
	EndWhile
	_SLS_CombatEquipFormlist.Revert()
EndFunction

Function RegForControls()
	RegisterForControl("Move")
	RegisterForControl("Forward")
	RegisterForControl("Back")
	RegisterForControl("Strafe Left")
	RegisterForControl("Strafe Right")
EndFunction

Bool WasInterrupted = false
Bool IsInProc = false
Float Timer

Formlist Property _SLS_CombatEquipFormlist Auto
Formlist Property _SLS_LicExceptionsArmor Auto

Actor Property PlayerRef Auto

Keyword Property MagicDamageFire Auto
Keyword Property MagicDamageFrost Auto
Keyword Property MagicDamageShock Auto
Keyword Property SexlabNoStrip Auto

Sound Property _SLS_ITMGenericArmorUpSM Auto

SLS_Utility Property Util Auto
