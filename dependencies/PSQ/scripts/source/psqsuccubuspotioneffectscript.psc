Scriptname PSQSuccubusPotionEffectScript Extends ActiveMagicEffect

slaUtilScr Property slaUtil Auto
Int Property MagnitudeExposure Auto
Int Property MagnitudeTimeRate Auto
Int Property MagnitudeExposureRate Auto
GlobalVariable Property PlayerIsSuccubus Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If akTarget == Game.GetPlayer() && PlayerIsSuccubus.GetValueInt() == 1
	Else
		slaUtil.UpdateActorExposure(akTarget, MagnitudeExposure)
		slaUtil.UpdateActorTimeRate(akTarget, MagnitudeTimeRate)
		slaUtil.UpdateActorExposureRate(akTarget, MagnitudeExposureRate)
	EndIf
EndEvent
