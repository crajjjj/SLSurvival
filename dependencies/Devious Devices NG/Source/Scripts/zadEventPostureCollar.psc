scriptName zadEventPostureCollar extends zadBaseEvent

bool Function HasKeywords(actor akActor)
	if !libs.AllowGenericEvents(akActor, libs.zad_DeviousCollar)
		return false
	elseif !akActor.WornHasKeyword(libs.zad_DeviousCollar)
		return false
	else
		string s = ""
		armor a = libs.GetWornDevice(akActor, libs.zad_DeviousCollar)
		if a
			; no keyword specifically for posture collars.
			s = a.GetName()
			if StringUtil.Find(s, "Posture") != -1
				return true
			endif
		endif		
		return false
		;return (akActor.WornHasKeyword(libs.zad_DeviousCollar) && akActor.IsEquipped(libs.collarPosture) )
	endif
EndFunction

Function Execute(actor akActor)
	libs.Moan(akActor)
	libs.NotifyPlayer("The posture collar uncomfortably forces you into a more refined posture.")	
EndFunction
