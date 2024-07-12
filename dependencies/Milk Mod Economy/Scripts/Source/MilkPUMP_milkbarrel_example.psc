Scriptname MilkPUMP_milkbarrel_example extends ObjectReference

MilkQUEST Property MilkQ Auto
ObjectReference Property MilkBarrel Auto
;after milking put milk & cum into barrel

;----------------------------------------------------------------------------
EVENT OnActivate(ObjectReference akActionRef)
	Actor akActor = akActionRef as Actor
	IF !akActor.HasSpell( MilkQ.BeingMilkedPassive ) && akActor.GetSitState() <= 3 && akActor.GetSitState() > 0  && MilkQ.Sexlab.IsValidActor(akActor)
		if akActor == MilkQ.PlayerRef
			Game.ForceThirdPerson()
		endif
		MilkQ.MilkingToContainer(akActor, 0, 0, 0, MilkBarrel)
	ENDIF
ENDEVENT