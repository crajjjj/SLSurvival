Scriptname ZazObjectAppearScript extends ObjectReference  

ObjectReference property zbfStatic auto

function OnActivate(ObjectReference akActionRef)

	if akActionRef == game.GetPlayer() as ObjectReference
		
		zbfStatic.enable()
	endIf
endFunction
