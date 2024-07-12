Scriptname SAT_RedFlashesScript extends Quest  

ImagespaceModifier property SAT_RedFlash auto
SAT_mcmConfig property mcm auto
SAT_UpkeepScript property main auto

Event OnInit()
	RegisterForUpdateGameTime(0.5)
endEvent

Event OnUpdate()
		Sat_RedFlash.apply()
endEvent

Event OnUpdateGameTime()
	If mcm.StressText
		if main.stress > mcm.stressFreeValue
			Debug.Notification("Stress: " + main.Stress as Int)
		endif
	endif
	If mcm.TraumaText
		if main.trauma > mcm.traumaFreeValue
			Debug.Notification("Trauma: " + main.Trauma as Int)
		endif
	endif
endEvent