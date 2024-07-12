Scriptname _SLS_GuardWarnCooldown extends Quest  

Event OnInit()
	RegisterForSingleUpdate(12.0)
EndEvent

Event OnUpdate()
	_SLS_GuardWarnTypeAndCooldown.SetValueInt(0)
	Stop()
EndEvent

GlobalVariable Property _SLS_GuardWarnTypeAndCooldown Auto
