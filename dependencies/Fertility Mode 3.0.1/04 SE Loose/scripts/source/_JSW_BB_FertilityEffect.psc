Scriptname _JSW_BB_FertilityEffect extends ActiveMagicEffect

_JSW_BB_Storage Property Storage  Auto            ; Storage data helper

GlobalVariable Property Enabled  Auto             ; Whether the mod is actively running or not

bool _wasOvulating = false

event OnEffectStart(Actor akTarget, Actor akCaster)
	if (!Enabled.GetValueInt())
		return
	endIf
	
	int index = Storage.TrackedActors.Find(akTarget)
		
	if (index != -1 && Storage.LastOvulation[index] == 0.0)
		; Force ovulation for the duration of the effect
		Storage.LastOvulation[index] = 1.0
		_wasOvulating = false
	else
		_wasOvulating = true
	endIf
endEvent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	if (!Enabled.GetValueInt())
		return
	endIf
	
	int index = Storage.TrackedActors.Find(akTarget)
	
	if (index != -1 && !_wasOvulating)
		; Clear the forced ovulation
		Storage.LastOvulation[index] = 0.0
	endIf
endEvent