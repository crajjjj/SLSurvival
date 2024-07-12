Scriptname _SLS_BikCurseShortBreath extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;Debug.Messagebox("BEGIN")
	RegisterForSingleUpdate(1.0)
EndEvent

Event OnUpdate()
	;Debug.Messagebox("Update")
	Bool Animating = false
	AnimCoolOff -= 1
	_SLS_BikCurseShortBreathImod.Apply()
	Int i = Utility.RandomInt(4, 9)
	Utility.Wait(1.0)
	PlayerRef.DamageActorValue("Stamina", Utility.RandomFloat(10.0, 25.0))
	
	If AnimCoolOff < 0 && !Util.IsAnimating(PlayerRef, CheckCombat = true) && StorageUtil.GetFloatValue(None, "_SLS_LicBikOutOfBreathAnimChance", Missing = 60.0) > Utility.RandomFloat(0.0, 100.0)
		;Debug.Messagebox("ctach breath")
		Animating = true
		;Devious.CatchBreathWithoutMoan(PlayerRef)
		Debug.SendAnimationEvent(PlayerRef, "ft_out_of_breath_reg")
	EndIf
	
	
	;Debug.Messagebox("play sound")
	While i > 0
		i -= 1
		;If Utility.RandomFloat(0.0, 100.0) > 20.0
		;	_SLS_BikCurseShortBreathImod.Apply()
		;EndIf

		_SLS_BikCurseShortBreathSM.Play(PlayerRef)
		Utility.WaitMenuMode(Utility.RandomFloat(0.6, 0.9))
	EndWhile
	If Animating
		Utility.Wait(1.0)
		Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
		AnimCoolOff = Utility.RandomInt(0, 1)
	EndIf
	RegisterForSingleUpdate(Utility.RandomFloat(5.0, 20.0))
EndEvent

Int AnimCoolOff

Sound Property _SLS_BikCurseShortBreathSM Auto

Actor Property PlayerRef Auto

ImageSpaceModifier Property _SLS_BikCurseShortBreathImod Auto

_SLS_InterfaceDevious Property Devious Auto
SLS_Utility Property Util Auto
