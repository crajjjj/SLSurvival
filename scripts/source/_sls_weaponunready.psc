Scriptname _SLS_WeaponUnready extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Util.PlayerUnreadysWeapon()
EndEvent

SLS_Utility Property Util Auto
