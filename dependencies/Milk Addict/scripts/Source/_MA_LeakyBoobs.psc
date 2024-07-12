Scriptname _MA_LeakyBoobs extends activemagiceffect  

Int LeakSound
Float SecondsToWait = 5.0 ; How long to wait for milk leaking effect to begin

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Float i = 0.0
	Bool IsLeaking = false
	While (i * 0.5) < SecondsToWait && !IsLeaking
		Utility.Wait(0.5)
		IsLeaking = PlayerRef.HasMagicEffect(MME_MilkLeakL_MagicEffect)
		i += 1
	EndWhile
	If IsLeaking
		LeakSound = _MA_MilkDrip.Play(PlayerRef)
		Sound.SetInstanceVolume(LeakSound, (Menu.LeakyBoobsVolume / 100.0))
		RegisterForSingleUpdate(3.0)
	Else
		PlayerRef.RemoveSpell(_MA_LeakyBoobsSpell)
	EndIf
EndEvent

Event OnUpdate()
	If PlayerRef.HasMagicEffect(MME_MilkLeakL_MagicEffect)
		RegisterForSingleUpdate(3.0)
	Else
		Sound.StopInstance(LeakSound)
		UnRegisterForUpdate()
		PlayerRef.RemoveSpell(_MA_LeakyBoobsSpell)
	EndIf
EndEvent

Sound Property _MA_MilkDrip Auto
Actor Property PlayerRef Auto
MagicEffect Property MME_MilkLeakL_MagicEffect Auto
Spell Property _MA_LeakyBoobsSpell Auto

_MA_Mcm Property Menu Auto
