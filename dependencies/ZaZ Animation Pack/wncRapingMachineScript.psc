Scriptname wncRapingMachineScript extends ObjectReference  

Event OnLoad()
	SetMotionType(Motion_Keyframed, false)
EndEvent

bool animationRunning

event onActivate(ObjectReference akActivator)
	Actor activatorREF = akActivator as Actor
	if !activatorREF || activatorREF.getSitState() == 4
		if animationRunning
			PlayGamebryoAnimation("rape", false, 0.1)
			animationRunning = false
		endif
		return
	endif
	SetMotionType(Motion_Keyframed, true)
	animationRunning = PlayGamebryoAnimation("rape", true, 0.0)
endEvent
