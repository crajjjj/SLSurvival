Scriptname mndSLDelegateScript Extends Quest Conditional

Actor Property PlayerRef Auto
mndController mnd
Actor[] thePlayer

Function doInit()
	mnd = mndController.instance()
	if !thePlayer
		thePlayer = new Actor[1]
		thePlayer[0] = PlayerRef
	endIf
endFunction

Event hookSexLabAnim(int tid)
	mnd.lastTimeSex = Utility.GetCurrentGameTime()
endEvent

function doMasturbation()
	debug.SendAnimationEvent(PlayerRef, "mndHorny")
	Utility.wait(Utility.randomFloat(3.0, 6.0))
	debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
endFunction

function removeCum()
endFunction



form[] Function StripActor(bool animate, bool full)
	return new form[1]
endFunction
 
function UnStripActor(form[] items)
endFunction

int function CountCum()
	return 0
endFunction
