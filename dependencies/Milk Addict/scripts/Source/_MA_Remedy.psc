Scriptname _MA_Remedy extends activemagiceffect  

GlobalVariable Property _MA_LactacidAddictionPool  Auto  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForSingleUpdateGameTime(1.0)
	
EndEvent

Event OnUpdateGameTime()
	Int Magnitude = self.GetMagnitude() as int
	Int OldPool = _MA_LactacidAddictionPool.GetValueInt()
	Int NewPool = OldPool - Magnitude
	;debug.trace("_MA_: OldPool: " + OldPool + ". Magnitude: " + Magnitude + ". NewPool: " + NewPool)
	If NewPool < 0
		NewPool = 0
	EndIf
	_MA_LactacidAddictionPool.SetValueInt(NewPool )
endEvent