Scriptname sr_InfEventPlugged extends sr_InfEventBase

ImageSpaceModifier Property sr_PluggedFlash Auto

bool Function Filter()
	return inflater.GetInflationPercentage(inflater.player) > 25.0 && inflater.IsFilledAndPlugged(inflater.player) && parent.Filter()
EndFunction

Function Execute()
	If inflater.IsFilledAndPlugged(inflater.player)
		int plugged = inflater.IsPlugged(inflater.player)
		float perc = inflater.GetInflationPercentage(inflater.player)
		
		String msg = "$FHU_PLUGGED_"

		If inflater.IsFilledAndPluggedType(inflater.player, 1)
			msg += "VAG_"
		ElseIf inflater.IsFilledAndPluggedType(inflater.player, 2)
			msg += "AN_"
		Else
		;	log("Plugged both")
			If Utility.RandomInt(1,2) == 1
				msg += "VAG_"
			Else
				msg += "AN_"
			EndIf
		EndIf
		
		float hoursSince = 0.0
		hoursSince = inflater.GetHoursSinceInflation(inflater.player, plugged) ; This shouldn't return -1 as the IsFilledAndPlugged() at the start should guard for that
	;	log("hoursSince: " + hoursSince)
		If hoursSince < 0.0
			log("negative hoursSince", 1)
			return
		EndIf
		
		float flashMaxStr = 1.0
		bool showFlash = false
		
		If perc < 50 || hoursSince < inflater.config.minInflationTime
			msg += "1"
		ElseIf perc >= 50 && hoursSince < ( inflater.config.minInflationTime + 24.0 )
			msg += "2"
			showFlash = true
			flashMaxStr = 0.5
		Else ; hoursSince >= ( inflater.config.minInflationTime + 24.0 )
			msg += "3"
			showFlash = true
		EndIf
		
	;	log("Displaying " + msg)
		inflater.notify(msg)
		
		If showFlash
			; scale the imgspacemodifier strength based on inflation percentage,
			; so that 50% inflation is 0 and 100% is 1.0, and scale that to match better with the painful or excruciating message with flashMaxStr
			float str = ((perc - 50) / 50 ) * flashMaxStr
	;		log("str: " + str + ", perc: " + perc + ", flashMaxStr: " + flashMaxStr)
			If str > 1.0
				str = 1.0
			EndIf
			sr_PluggedFlash.Apply(str)
			Utility.Wait(1.1)
			sr_PluggedFlash.Remove()			
		EndIf
	EndIf
EndFunction
