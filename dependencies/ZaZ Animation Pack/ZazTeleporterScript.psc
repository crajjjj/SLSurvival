Scriptname ZazTeleporterScript extends ObjectReference
  


Event OnActivate(ObjectReference acti)
	Actor victim = acti as Actor

	
			if (!IsActive)
			IsActive = true
			victim.MoveTo(target)
			
		else
			IsActive = false
			victim.Moveto(self)
			
		
	
	endif
EndEvent

bool Property IsActive Auto
ObjectReference property target auto