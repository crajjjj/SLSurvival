ScriptName		_JSW_SUB_TimerME	Extends		ActiveMagicEffect

actor		Property		playerRef		Auto
faction		Property		MorphToggle		Auto

bool	aBool	=	false

event	OnEffectStart(actor one, actor two)

	RegisterForSingleUpdate(2.0)

endEvent

event	OnUpdate()

	aBool = !aBool
	playerRef.SetFactionRank(MorphToggle, (5 * aBool as int))
	GoToState("CloakUp")
	RegisterForSingleUpdate(2.0)

endEvent

state CloakUp

	event	OnUpdate()

		playerRef.RemoveFromFaction(MorphToggle)
		GoToState("")
		RegisterForSingleUpdate(4.0)

	endEvent

endState
