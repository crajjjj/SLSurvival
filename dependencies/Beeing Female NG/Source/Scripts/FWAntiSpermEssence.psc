Scriptname FWAntiSpermEssence extends activemagiceffect  

int property UpdateEvery = 10 auto
actor woman = none
float Strength = 0.0

FWController property Controller auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	; Check if the user is a woman
	woman=akTarget
	Utility.Wait(0.2)
	Strength = GetMagnitude()
	Execute()
	if GetDuration()>=UpdateEvery
		RegisterForSingleUpdate(UpdateEvery)
	endif
endEvent

function Execute()
	Controller.WashOutSperm(woman, 2, Strength / 100)
endFunction

function OnUpdate()
	Execute()
	RegisterForSingleUpdate(UpdateEvery)
endfunction