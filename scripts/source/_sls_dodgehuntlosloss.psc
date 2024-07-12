Scriptname _SLS_DodgeHuntLosLoss extends activemagiceffect  

ObjectReference Property _SLS_TollDodgeLastKnownPos Auto

_SLS_TollDodge Property TollDodge Auto

Actor Property PlayerRef Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;Debug.Messagebox("Los Loss")
	Utility.Wait(1.5) ; Wait a little before moving to 'make the guards a little more intelligent'
	_SLS_TollDodgeLastKnownPos.MoveTo(PlayerRef, afZOffset = 50.0)
	TollDodge.UpdateHunterPackage()
EndEvent