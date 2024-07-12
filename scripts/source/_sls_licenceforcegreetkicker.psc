Scriptname _SLS_LicenceForceGreetKicker extends Quest  

Event OnInit()
	If Self.IsRunning()	
		;Debug.Messagebox("Startup")
		RegisterForSingleUpdate(0.75)
		;RegisterForSingleUpdate(5.0)
	EndIf
EndEvent

Event OnUpdate()
	;If LicUtil.LicInfractionType == -1 ; Still in proc = force greet
	If !_SLS_LicenceForceGreetQuest.IsRunning()
		_SLS_LicenceForceGreetQuest.Start()
	EndIf
	;Debug.Messagebox("Shutdown: " + LicUtil.LicInfractionType)
	Self.Stop()
EndEvent

Quest Property _SLS_LicenceForceGreetQuest Auto

_SLS_LicenceUtil Property LicUtil Auto
