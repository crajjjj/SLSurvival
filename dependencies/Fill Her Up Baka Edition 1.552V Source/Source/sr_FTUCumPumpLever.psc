scriptname sr_FTUCumPumpLever extends objectReference

sr_FTUCumPumpActivator Property pumpHandler auto
bool property isAnal = false auto

bool leftNext = TRUE	; this bool helps us remember which state to go to next


EVENT onInit()
;	playAnimation("MidPosition")
	playAnimation("pullUp")
endEVENT

AUTO STATE OFFpos
	EVENT onActivate (objectReference triggerRef)
		gotoState ("busyState")
	;	trace("Switch Animating Down")
		if leftNEXT == true
			playAnimationandWait("pushDown","pushed")
	;		trace("done animating")
			gotoState("LEFTpos")
			pumpHandler.SetPool(isAnal, 1)
			leftNEXT = false
		else
			playAnimationandWait("pullDown","pulled")
	;		trace ("done animating")
			pumpHandler.SetPool(isAnal, -1)
			gotoState("RIGHTpos")
			leftNEXT = true
		endif
	endEVENT
endSTATE

STATE LEFTpos
	EVENT onBeginState()

	endEVENT
	
	EVENT onActivate(objectReference triggerREF)
		gotoState("busyState")
		playAnimationandWait("pushUp","unPushed")
		pumpHandler.SetPool(isAnal, 0)
		gotoState("OFFpos")
	endEVENT
	
	EVENT onEndState()

	endEVENT
endSTATE

STATE RIGHTpos
	EVENT onBeginState()

	endEVENT
	
	EVENT onActivate(objectReference triggerREF)
		gotoState("busyState")
		playAnimationandWait("pullUp","unPulled")
		pumpHandler.SetPool(isAnal, 0)
		gotoState("OFFpos")
	endEVENT
	
	EVENT onEndState()

	endEVENT
endSTATE

STATE busyState
	; don't do anything while I'm busy.
endSTATE