Scriptname mndPissPoopCleanUp Extends ObjectReference

Event OnActivate(ObjectReference akActionRef)
	if akActionRef!=Game.getPlayer()
		return
	endIf
	int id = ModEvent.Create("MiniNeedsCleanPissPoop")
	ModEvent.PushForm(id, self)
	ModEvent.Send(id)
endEvent
