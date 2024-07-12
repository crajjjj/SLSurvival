Scriptname mndShowerLocationsBookScript extends ObjectReference

Quest property mndShowers Auto

Event OnRead()
	mndShowers.start()
	mndShowers.setStage(10)
	mndShowers.setObjectiveDisplayed(0)
endEvent

