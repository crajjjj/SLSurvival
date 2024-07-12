Scriptname _SLS_HelloSpankCooloff extends Quest  

Event OnInit()
	If Menu.ProxSpankCooloff > 0.0
		_SLS_HelloSpankCooldown.SetValueInt(1)
		RegisterForSingleUpdate(Menu.ProxSpankCooloff)
	Else
		Self.Stop()
	EndIf
EndEvent

Event OnUpdate()
	_SLS_HelloSpankCooldown.SetValueInt(0)
	Self.Stop()
EndEvent

GlobalVariable Property _SLS_HelloSpankCooldown Auto

SLS_Mcm Property Menu Auto
