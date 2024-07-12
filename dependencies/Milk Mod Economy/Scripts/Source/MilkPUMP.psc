Scriptname MilkPUMP extends ObjectReference

MilkQUEST Property MilkQ Auto

;----------------------------------------------------------------------------
EVENT OnActivate(ObjectReference akActionRef)
	Actor akActor = akActionRef as Actor
	IF !akActor.HasSpell( MilkQ.BeingMilkedPassive ) && akActor.GetSitState() <= 3 && akActor.GetSitState() > 0 && MilkQ.Sexlab.IsValidActor(akActor)
		;Non bound milking
		if self.HasKeyword( Game.GetFormFromFile(0x7e3bc, "MilkModNew.esp") as Keyword )\
		|| self.HasKeyword( Game.GetFormFromFile(0x26D1B , "ZaZAnimationPack.esm") as Keyword )
			if akActor == MilkQ.PlayerRef
				Game.ForceThirdPerson()
			endif
			MilkQ.Milking(akActor, 0, 0, 0)
		;Bound milking
		elseif self.HasKeyword( Game.GetFormFromFile(0x7e3bd, "MilkModNew.esp") as Keyword )\
			|| self.HasKeyword( Game.GetFormFromFile(0x26D17 , "ZaZAnimationPack.esm") as Keyword )
			if akActor == MilkQ.PlayerRef
				;akActor.SetRestrained()		;Flags this actor as restrained or not. Restrained actors will not move from their current position, but will continue to "think" (pick packages, run detection so they could yell alarms) and go into dialogue.
				;akActor.Setunconscious(true)	;stand in place as if it's in a trance or their AI is disabled, wakeup if health is low
				Game.SetPlayerAIDriven(true)
				Game.DisablePlayerControls()
				Game.ForceThirdPerson()
			endif
			MilkQ.Milking(akActor, 0, 0, 1)
		endif
	ENDIF
ENDEVENT