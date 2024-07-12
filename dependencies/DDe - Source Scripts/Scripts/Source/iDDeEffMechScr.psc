ScriptName iDDeEffMechScr Extends ActiveMagicEffect  

iDDeMain Property iDDe Auto

;Properties 
VisualEffect Property veStartFX Auto ;VE start FX.(HercinTotemPVFX01)
VisualEffect Property veDoneFX auto ;VE done FX (HercinTotemPVFX02)

Sound[] Property soStarts Auto ;VE start FX sound.(SL 07)
Sound[] Property soDones Auto ;VE done FX sound.(SL 08) 
Sound[] Property soPows Auto

Actor Property PlayerRef Auto 

Keyword Property iSUmKwdWornMech Auto

Perk Property iDDe_PerkNoFallingDamage Auto
Perk Property iDDe_PerkDeflectArrows Auto

;Variables 
Actor _aActor = None

BOOL _bIsOn = False
BOOL _bIsPC = False
BOOL _bBusyAnim = False

STRING _sAttack01 = "SoundPlay.WPNSwingUnarmed" 
STRING _sAttack02 = "SoundPlay.NPCHumanCombatShieldBash"
;"SoundPlay.FXMeleePunchMedium", "SoundPlay.WPNImpactUnarmedVsFlesh", "SoundPlay.WPNImpactUnarmedVsOther"

;Events 
Event OnEffectStart(Actor Target, Actor Caster)	
	_aActor = Target
		If (_aActor && _aActor.WornHasKeyword(iSUmKwdWornMech))
			_bIsOn = True
			_bIsPC = (_aActor == PlayerRef)	
				If (_bIsPC && _aActor.Is3DLoaded())
					INT i = Utility.RandomInt(1, (soStarts.Length - 1))	
						iDDe.iDDeSetMechEffects(aSlave = _aActor, iSet = 1, iAll = 0)
							If (soStarts[i])
								soStarts[i].Play(_aActor)
							EndIf
							If (veStartFX)
								veStartFX.Play(_aActor, 7.7)
							EndIf
						iDDe.iDDeLog("iDDeEffMechScr.OnEffectStart():-> ", "You moan uncontrollably, as your powers are leaving your body!...", 3, 1)
				EndIf
				If (iDDe.iMechPow)
					RegisterForAnimationEvent(akSender = _aActor, asEventName = _sAttack01) 
					RegisterForAnimationEvent(akSender = _aActor, asEventName = _sAttack02)
				EndIf
				If (iDDe.iDDeMechJump && !_aActor.HasPerk(iDDe_PerkNoFallingDamage))
					_aActor.AddPerk(iDDe_PerkNoFallingDamage)
				EndIf
			_aActor.AddPerk(iDDe_PerkDeflectArrows)
			RegisterForSingleUpdate(6.6)
		EndIf 
EndEvent

Event OnUpdate()
	If (_bIsOn && _aActor && _bIsPC)
		If (_aActor.WornHasKeyword(iSUmKwdWornMech)) 
			iDDe.iDDeSetMechEffects(aSlave = _aActor, iSet = 1, iAll = 0)
			RegisterForSingleUpdate(iDDe.fDDeRefreshRate)
		Else
			iDDe.iDDeSetMechEffects(aSlave = _aActor, iSet = 0, iAll = 0)
			UnregisterForUpdate()
		EndIf
	EndIf
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	If (!_bBusyAnim && iDDe.iMechPow && _bIsOn && _aActor && (_aActor == akSource) && ((asEventName == _sAttack01) || (asEventName == _sAttack02)))
		_bBusyAnim = True
		Actor aTarget = None
			If (_aActor == PlayerRef)
				aTarget = (Game.GetCurrentCrosshairRef() AS Actor)
			Else
				aTarget = _aActor.GetCombatTarget()
			EndIf
			If (aTarget && !aTarget.IsDead() && (aTarget.GetDistance(_aActor) < 150)) ;Hand reach 150 units?
				INT iPowMax = (soPows.Length - 1)
				INT i = iDDe.iMechPowSnd
					If ((i < 0) || (i > iPowMax))
						i = Utility.RandomInt(1, iPowMax)
					EndIf
					If (i && soPows[i])
						soPows[i].Play(_aActor)
					EndIf
				_aActor.PushActorAway(aTarget, iDDe.iMechPow) 
					If (iDDe.iDDeMechDisarm)
						iSUmUtil.UnequipActorHands(aActor = aTarget, iDrop = 1, foItem = None)
					EndIf
			EndIf
		_bBusyAnim = False
	EndIf
EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)
	If (_bIsOn)
		_bIsOn = False
			If (_bIsPC)
				INT i = Utility.RandomInt(1, (soDones.Length - 1))	
					If (soDones[i])
						soDones[i].Play(_aActor)
					EndIf
					If (veDoneFX)
						veDoneFX.Play(_aActor, 7.7)	
					EndIf
				iDDe.iDDeLog("iDDeEffMechScr.OnEffectStart():-> ", "You get aroused as your powers return!...", 3, 1)
				iDDe.iDDeSetMechEffects(aSlave = _aActor, iSet = 0, iAll = 0)
			EndIf
			If (_aActor.HasPerk(iDDe_PerkNoFallingDamage))
				_aActor.RemovePerk(iDDe_PerkNoFallingDamage)
			EndIf
		_aActor.RemovePerk(iDDe_PerkDeflectArrows)
		UnregisterForAnimationEvent(akSender = _aActor, asEventName = _sAttack01)
		UnregisterForAnimationEvent(akSender = _aActor, asEventName = _sAttack02)
	EndIf
EndEvent	
	

