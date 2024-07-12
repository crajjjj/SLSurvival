Scriptname iDDeFxNoTravel Extends ActiveMagicEffect  

Import Utility
;Import Form

iDDeMain Property iDDe Auto

;p Properties p
;ppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp
VisualEffect Property veStartFX Auto ;VE start FX.(HercinTotemPVFX01)
VisualEffect Property veMainFX auto ;VE main FX (DA10SummonValorTargetFX)
VisualEffect Property veDoneFX auto ;VE done FX (HercinTotemPVFX02)

Sound Property sStartSoundFX Auto ;VE start FX sound.(SL 07)
Sound Property sMainSoundFX Auto ;VE main FX sound. (Zad short moan)
Sound Property sDoneSoundFX Auto ;VE done FX sound.(SL 08) 

Actor Property PlayerRef Auto 
Actor _aSlave
;Actor aMaster

Keyword _kHeavyBond
Keyword _kMech
;ppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp

;v Variables v
;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
BOOL _bIsDone = False
BOOL _bIsPC = False
INT _sMainSoundID = 0
;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

;e Events e
;eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
Event OnEffectStart(Actor Target, Actor Caster)	
	_kHeavyBond = iDDe.ZadLib.zad_DeviousHeavyBondage
	_kMech = iDDe.iDDeLib.iSUmKwdWornMech
	_aSlave = Target
	_bIsPC = (_aSlave == PlayerRef)
		If (_bIsPC && _aSlave && _aSlave.WornHasKeyword(_kHeavyBond) && !_aSlave.WornHasKeyword(_kMech)) ;
			iDDe.iDDeEnableArmEffects(aSlave = _aSlave, iEna = 1, iAll = 0)
				If (iDDe.iEnableBondFX && _aSlave.Is3DLoaded())
					INT iStartSoundID = sStartSoundFX.Play(_aSlave AS ObjectReference)
					veStartFX.Play(_aSlave AS ObjectReference, 7.7)	
					iDDe.iDDeLog("iDDeFxNoTravel.OnEffectStart():-> ", "You moan uncontrollably, as your powers are leaving your body!...", 3, 1)
					;Wait(6.7)
					;Sound.StopInstance(iStartSoundID)
						;If (!_bIsDone)
							;_sMainSoundID = sMainSoundFX.Play(Target AS ObjectReference)  
							;veMainFX.Play(Target AS ObjectReference, 66)                           
						;EndIf
				EndIf
			_bIsDone = False
		Else
			_bIsDone = True
		EndIf
	RegisterForSingleUpdate(iDDe.fDDeRefreshRate)
EndEvent

Event OnUpdate()
		If (!_bIsDone && _aSlave.WornHasKeyword(_kHeavyBond)) 
			iDDe.iDDeEnableArmEffects(aSlave = _aSlave, iEna = 1, iAll = 0)
			RegisterForSingleUpdate(iDDe.fDDeRefreshRate)
		ElseIf (!_bIsDone && iDDe.iDDeIsAnimating(_aSlave)) 
			RegisterForSingleUpdate(iDDe.fDDeRefreshRate)
		Else
			iDDe.iDDeEnableArmEffects(aSlave = _aSlave, iEna = 0, iAll = 0)
			iDDe.iDDeEqpMagicalArmbinder(aSlave = _aSlave, iEqp = 0, iDelay = 0)
			UnregisterForUpdate()
		EndIf
EndEvent

;EVENT OnCellLoad()
;		If (!_bIsDone)
;			Game.EnableFastTravel(False)
;		EndIf
;ENDEVENT

Event OnEffectFinish(Actor Target, Actor Caster)
	_bIsDone = True
		If (_bIsPC)
			iDDe.iDDeEnableArmEffects(aSlave = _aSlave, iEna = 0, iAll = 0)
				If (iDDe.iEnableBondFX)
					;Sound.StopInstance(_sMainSoundID)
					;veMainFX.Stop(orObject)
					INT iDoneSoundID = sDoneSoundFX.Play(_aSlave AS ObjectReference)
					veDoneFX.Play(_aSlave AS ObjectReference, 7.7)	
					iDDe.iDDeLog("iDDeFxNoTravel.OnEffectFinish():-> ", "You get aroused as your powers return!...", 3, 1)
					;Wait(9.9)
					;Sound.StopInstance(iDoneSoundID)
					;UnregisterForUpdate()
				EndIf
			iDDe.iDDeEqpMagicalArmbinder(aSlave = _aSlave, iEqp = 0, iDelay = 2)
		EndIf
EndEvent		
;eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee	

