Scriptname _SLS_PickPocketFailCalm extends ReferenceAlias  

Actor Property PlayerRef Auto

Event OnInit()
	Actor akTarget = Self.GetReference() as Actor
	If akTarget
		;While akTarget.IsHostileToActor(PlayerRef)
			akTarget.StopCombatAlarm()
			akTarget.StopCombat()
			Utility.Wait(2.0)
		;EndWhile
	EndIf
EndEvent
