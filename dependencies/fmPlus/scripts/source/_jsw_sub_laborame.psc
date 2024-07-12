ScriptName	_JSW_SUB_LaborAME	Extends	ActiveMagicEffect

Idle						Property	IdleBirth			Auto	; Idle animation for labor (IdleCowering)  efc68
Idle						Property	IdleStop_Loose		Auto	; Termination stage for the idle animation 10d9ee

event	OnEffectStart(actor akTarget, actor akCaster)

	akTarget.PlayIdle(IdleBirth)

endEvent

event	OnEffectFinish(actor akTarget, actor akCaster)

	akTarget.PlayIdle(IdleStop_Loose)

endEvent
