Scriptname zadc_buildScript extends ObjectReference  

Activator Property FurnitureToBuild  Auto  
zadclibs Property clib Auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	if akNewContainer || ((akOldContainer As Actor) == None)
		; if it didn't get dumped to the ground by somebody, don't do anything
		return
	EndIf	
	clib.BobTheBuilder(FurnitureToBuild)
	self.Delete()
EndEvent