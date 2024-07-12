ScriptName		_JSW_SUB_BabyScript		Extends		ObjectReference


FormList		Property		BabyCries		Auto

float		distress		=		0.0

event	OnLoad()

	RegisterForSingleUpdateGameTime(0.10 + Utility.RandomFloat() / 2.0)

endEvent

event	OnUpdate()

	if distress < 100.0
		distress = (distress as int + 1) as float
	endIf
	if Is3DLoaded()
		Sound.SetInstanceVolume((BabyCries.GetAt(Utility.RandomInt(0, BabyCries.GetSize() - 1))as Sound).Play(self), (0.45 + (distress / 200.0)))
	endIf
	RegisterForSingleUpdate(12.0 - (8.0 * distress / 100.0))

endEvent

event	OnUpdateGameTime()

	GoToState("RampUp")
	RegisterForSingleUpdate(5.0)
	RegisterForSingleUpdateGameTime(6.0)

endEvent

state	RampUp

	event	OnUpdateGameTime()

		UnregisterforUpdate()
		Delete()
		
	endEvent

endState

event	OnCellDetach()

	GoToState("RampUp")
	OnUpdateGameTime()

endEvent
