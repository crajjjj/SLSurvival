Scriptname tfpSpawnPlayerTo extends ObjectReference
  
ObjectReference Property xmarkhead auto

function OnTriggerEnter(ObjectReference akActionRef)
		
	if akActionRef == game.GetPlayer() as ObjectReference
		game.GetPlayer().MoveTo(xmarkhead, 0.000000, 0.000000, 0.000000, true)
		
	
	endIf
endFunction