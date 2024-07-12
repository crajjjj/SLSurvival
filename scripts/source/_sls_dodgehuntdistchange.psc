Scriptname _SLS_DodgeHuntDistChange extends activemagiceffect  

;ObjectReference Property _SLS_TollDodgeLastKnownPos Auto

_SLS_TollDodge Property TollDodge Auto

Actor Property PlayerRef Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;Debug.Messagebox("Dist thres change")
	;_SLS_TollDodgeLastKnownPos.MoveTo(PlayerRef, afZOffset = 50.0)
	TollDodge.UpdateHunterPackage()
EndEvent