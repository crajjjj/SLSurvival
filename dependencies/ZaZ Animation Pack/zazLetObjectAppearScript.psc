Scriptname zazLetObjectAppearScript extends ObjectReference  

ObjectReference property zbfStatic auto

function OnTriggerEnter(ObjectReference akActionRef)

	if akActionRef == game.GetPlayer() as ObjectReference
		
		zbfStatic.enable()
	endIf
endFunction