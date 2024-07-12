Scriptname	_JSW_SUB_WidgetAlias	extends	ReferenceAlias  

_JSW_SUB_WidgetCycle	Property	WidgetCycle		Auto

event	OnInit()

	OnPlayerLoadGame()

endEvent

event	OnPlayerLoadGame()

	WidgetCycle.WidgetRegister()

endEvent
