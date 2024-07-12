Scriptname PSC_BountyDecay extends Quest

PaySexCrimeMCM Property PSC_MCM Auto

	;locations

Location Property EastmarchHoldLocation  Auto
Location Property WindhelmLocation  Auto
Location Property FalkreathHoldLocation  Auto  
Location Property FalkreathLocation  Auto  
Location Property HaafingarHoldLocation  Auto  
Location Property SolitudeLocation  Auto  
Location Property HjaalmarchHoldLocation  Auto  
Location Property MorthalLocation  Auto  
Location Property PaleHoldLocation  Auto  
Location Property DawnstarLocation  Auto  
Location Property ReachHoldLocation  Auto  
Location Property MarkarthLocation  Auto  
Location Property RiftenHoldLocation  Auto  
Location Property RiftenLocation  Auto  
Location Property WhiterunHoldLocation  Auto  
Location Property WhiterunLocation  Auto  
Location Property WinterholdHoldLocation  Auto  
Location Property WinterholdLocation  Auto  
Location Property WinterholdCollegeLocation  Auto

GlobalVariable Property GameHour Auto
Float Property NextUpdateTime Auto

	;called on Update, and called when mcm changes UpdatesPerDay.

Function RegisterUpdateTime()
	UnRegisterForUpdateGameTime()	;for when called when not onupdate.
	if (PSC_MCM._sliderPercent_UpdatesPerDay > 0)
		float TimeTilUpdate = (24 - GameHour.GetValue())	;Hours til midnight.
		float UpdatesHours = (24 / PSC_MCM._sliderPercent_UpdatesPerDay)	;number of hours between updates.
		while (TimeTilUpdate > UpdatesHours)
			TimeTilUpdate -= UpdatesHours
		endWhile
		NextUpdateTime = Utility.GetCurrentGameTime() + ((TimeTilUpdate) / 24)
		RegisterForSingleUpdateGameTime(TimeTilUpdate)	;wait til time for next update.
	endif
endfunction






Function DecayBounty(Int CrimeFac)
	;subtract decay from bounty.
	float NonViolent = (PSC_MCM.BountyNonViolent[CrimeFac] as float)
	float Violent = (PSC_MCM.BountyViolent[CrimeFac] as float)
	if ((NonViolent + Violent) > 0)
		float Decay = ((NonViolent + Violent) * (PSC_MCM._sliderPercent_PercentDrop / 100))
		Decay += (PSC_MCM._sliderPercent_FixedDrop)
		Decay = Math.Ceiling(Decay)
		if (NonViolent <= Decay)
			PSC_MCM.BountyNonViolent[CrimeFac] = 0
			Decay -= NonViolent
			if (Violent <= Decay)
				PSC_MCM.BountyViolent[CrimeFac] = 0
			else
				PSC_MCM.BountyViolent[CrimeFac] = (PSC_MCM.BountyViolent[CrimeFac] - (Decay as int))
			endif
		else
			PSC_MCM.BountyNonViolent[CrimeFac] = (PSC_MCM.BountyNonViolent[CrimeFac] - (Decay as int))
		endif
	endif
EndFunction




Event OnUpdateGameTime()

	;Debug.Notification("Running update check.")


	If (Utility.GetCurrentGameTime() >= NextUpdateTime)		;Time for to drop some bounties
		;Debug.Notification("Updating bounties.")

		;check missed updates
		float UpdatesHours = (24 / PSC_MCM._sliderPercent_UpdatesPerDay)	;number of hours between updates.
		float TimeOver = ((Utility.GetCurrentGameTime() - NextUpdateTime) * 24)
		int n = 1
		while (TimeOver > UpdatesHours)
			n += 1
			TimeOver -= UpdatesHours
		endWhile
		;missed n - 1 updates.

		if ( ((PSC_MCM.BountyNonViolent[1] + PSC_MCM.BountyViolent[1]) > 0) && (!Game.GetPlayer().IsInLocation(WindhelmLocation) || !PSC_MCM.PSC_UseSettlements) && (!Game.GetPlayer().IsInLocation(EastmarchHoldLocation) || !PSC_MCM.PSC_UseHolds))
			int i = n
			while (i > 0)
				DecayBounty(1)
				i -= 1
			endwhile
			if ((PSC_MCM.BountyNonViolent[1] + PSC_MCM.BountyViolent[1]) == 0)	;if no bounty, then it has decayed away.
				;end pardon without penalty.
				PSC_MCM.PardonEndTime[1] = (Utility.GetCurrentGameTime() * 24)
				;increase tracker
				PSC_MCM.SuccessTracker[1] = (PSC_MCM.SuccessTracker[1] + 1)
				if (PSC_MCM.SuccessTracker[1] > 2000000000)
					PSC_MCM.SuccessTracker[1] = 0
				endif
				Debug.Notification("I'd wager that the guards of Windhelm have forgotten about me by now.")
			endif
		endif

		if ( ((PSC_MCM.BountyNonViolent[2] + PSC_MCM.BountyViolent[2]) > 0) && (!Game.GetPlayer().IsInLocation(FalkreathLocation) || !PSC_MCM.PSC_UseSettlements) && (!Game.GetPlayer().IsInLocation(FalkreathHoldLocation) || !PSC_MCM.PSC_UseHolds))
			int i = n
			while (i > 0)
				DecayBounty(2)
				i -= 1
			endwhile
			if ((PSC_MCM.BountyNonViolent[2] + PSC_MCM.BountyViolent[2]) == 0)	;if no bounty, then it has decayed away.
				;end pardon without penalty.
				PSC_MCM.PardonEndTime[2] = (Utility.GetCurrentGameTime() * 24)
				;increase tracker
				PSC_MCM.SuccessTracker[2] = (PSC_MCM.SuccessTracker[2] + 1)
				if (PSC_MCM.SuccessTracker[2] > 2000000000)
					PSC_MCM.SuccessTracker[2] = 0
				endif
				Debug.Notification("The heat's probably blown over in Falkreath.")
			endif
		endif

		if ( ((PSC_MCM.BountyNonViolent[3] + PSC_MCM.BountyViolent[3]) > 0) && (!Game.GetPlayer().IsInLocation(SolitudeLocation) || !PSC_MCM.PSC_UseSettlements) && (!Game.GetPlayer().IsInLocation(HaafingarHoldLocation) || !PSC_MCM.PSC_UseHolds))
			int i = n
			while (i > 0)
				DecayBounty(3)
				i -= 1
			endwhile
			if ((PSC_MCM.BountyNonViolent[3] + PSC_MCM.BountyViolent[3]) == 0)	;if no bounty, then it has decayed away.
				;end pardon without penalty.
				PSC_MCM.PardonEndTime[3] = (Utility.GetCurrentGameTime() * 24)
				;increase tracker
				PSC_MCM.SuccessTracker[3] = (PSC_MCM.SuccessTracker[3] + 1)
				if (PSC_MCM.SuccessTracker[3] > 2000000000)
					PSC_MCM.SuccessTracker[3] = 0
				endif
				Debug.Notification("Solitude should be safe enough for me to visit now.")
			endif
		endif

		if ( ((PSC_MCM.BountyNonViolent[4] + PSC_MCM.BountyViolent[4]) > 0) && (!Game.GetPlayer().IsInLocation(MorthalLocation) || !PSC_MCM.PSC_UseSettlements) && (!Game.GetPlayer().IsInLocation(HjaalmarchHoldLocation) || !PSC_MCM.PSC_UseHolds))
			int i = n
			while (i > 0)
				DecayBounty(4)
				i -= 1
			endwhile
			if ((PSC_MCM.BountyNonViolent[4] + PSC_MCM.BountyViolent[4]) == 0)	;if no bounty, then it has decayed away.
				;end pardon without penalty.
				PSC_MCM.PardonEndTime[4] = (Utility.GetCurrentGameTime() * 24)
				;increase tracker
				PSC_MCM.SuccessTracker[4] = (PSC_MCM.SuccessTracker[4] + 1)
				if (PSC_MCM.SuccessTracker[4] > 2000000000)
					PSC_MCM.SuccessTracker[4] = 0
				endif
				Debug.Notification("I don't think they're looking for me in Morthal anymore.")
			endif
		endif

		if ( ((PSC_MCM.BountyNonViolent[5] + PSC_MCM.BountyViolent[5]) > 0) && (!Game.GetPlayer().IsInLocation(DawnstarLocation) || !PSC_MCM.PSC_UseSettlements) && (!Game.GetPlayer().IsInLocation(PaleHoldLocation) || !PSC_MCM.PSC_UseHolds))
			int i = n
			while (i > 0)
				DecayBounty(5)
				i -= 1
			endwhile
			if ((PSC_MCM.BountyNonViolent[5] + PSC_MCM.BountyViolent[5]) == 0)	;if no bounty, then it has decayed away.
				;end pardon without penalty.
				PSC_MCM.PardonEndTime[5] = (Utility.GetCurrentGameTime() * 24)
				;increase tracker
				PSC_MCM.SuccessTracker[5] = (PSC_MCM.SuccessTracker[5] + 1)
				if (PSC_MCM.SuccessTracker[5] > 2000000000)
					PSC_MCM.SuccessTracker[5] = 0
				endif
				Debug.Notification("Dawnstar will have other criminals to worry about by now.")
			endif
		endif

		if ( ((PSC_MCM.BountyNonViolent[6] + PSC_MCM.BountyViolent[6]) > 0) && (!Game.GetPlayer().IsInLocation(MarkarthLocation) || !PSC_MCM.PSC_UseSettlements) && (!Game.GetPlayer().IsInLocation(ReachHoldLocation) || !PSC_MCM.PSC_UseHolds))
			int i = n
			while (i > 0)
				DecayBounty(6)
				i -= 1
			endwhile
			if ((PSC_MCM.BountyNonViolent[6] + PSC_MCM.BountyViolent[6]) == 0)	;if no bounty, then it has decayed away.
				;end pardon without penalty.
				PSC_MCM.PardonEndTime[6] = (Utility.GetCurrentGameTime() * 24)
				;increase tracker
				PSC_MCM.SuccessTracker[6] = (PSC_MCM.SuccessTracker[6] + 1)
				if (PSC_MCM.SuccessTracker[6] > 2000000000)
					PSC_MCM.SuccessTracker[6] = 0
				endif
				Debug.Notification("Pretty sure I'm off the boards in Markarth, after this long.")
			endif
		endif

		if ( ((PSC_MCM.BountyNonViolent[7] + PSC_MCM.BountyViolent[7]) > 0) && (!Game.GetPlayer().IsInLocation(RiftenLocation) || !PSC_MCM.PSC_UseSettlements) && (!Game.GetPlayer().IsInLocation(RiftenHoldLocation) || !PSC_MCM.PSC_UseHolds))
			int i = n
			while (i > 0)
				DecayBounty(7)
				i -= 1
			endwhile
			if ((PSC_MCM.BountyNonViolent[7] + PSC_MCM.BountyViolent[7]) == 0)	;if no bounty, then it has decayed away.
				;end pardon without penalty.
				PSC_MCM.PardonEndTime[7] = (Utility.GetCurrentGameTime() * 24)
				;increase tracker
				PSC_MCM.SuccessTracker[7] = (PSC_MCM.SuccessTracker[7] + 1)
				if (PSC_MCM.SuccessTracker[7] > 2000000000)
					PSC_MCM.SuccessTracker[7] = 0
				endif
				Debug.Notification("Riften's full of criminals anyway.  They won't remember me.")
			endif
		endif

		if ( ((PSC_MCM.BountyNonViolent[8] + PSC_MCM.BountyViolent[8]) > 0) && (!Game.GetPlayer().IsInLocation(WhiterunLocation) || !PSC_MCM.PSC_UseSettlements) && (!Game.GetPlayer().IsInLocation(WhiterunHoldLocation) || !PSC_MCM.PSC_UseHolds))
			int i = n
			while (i > 0)
				DecayBounty(8)
				i -= 1
			endwhile
			if ((PSC_MCM.BountyNonViolent[8] + PSC_MCM.BountyViolent[8]) == 0)	;if no bounty, then it has decayed away.
				;end pardon without penalty.
				PSC_MCM.PardonEndTime[8] = (Utility.GetCurrentGameTime() * 24)
				;increase tracker
				PSC_MCM.SuccessTracker[8] = (PSC_MCM.SuccessTracker[8] + 1)
				if (PSC_MCM.SuccessTracker[8] > 2000000000)
					PSC_MCM.SuccessTracker[8] = 0
				endif
				Debug.Notification("Should be safe to say hello to the guards in Whiterun again.")
			endif
		endif

		if ( ((PSC_MCM.BountyNonViolent[9] + PSC_MCM.BountyViolent[9]) > 0) && ((!Game.GetPlayer().IsInLocation(WinterholdLocation) && !Game.GetPlayer().IsInLocation(WinterholdCollegeLocation)) || !PSC_MCM.PSC_UseSettlements) && (!Game.GetPlayer().IsInLocation(WinterholdHoldLocation) || !PSC_MCM.PSC_UseHolds))
			int i = n
			while (i > 0)
				DecayBounty(9)
				i -= 1
			endwhile
			if ((PSC_MCM.BountyNonViolent[9] + PSC_MCM.BountyViolent[9]) == 0)	;if no bounty, then it has decayed away.
				;end pardon without penalty.
				PSC_MCM.PardonEndTime[9] = (Utility.GetCurrentGameTime() * 24)
				;increase tracker
				PSC_MCM.SuccessTracker[9] = (PSC_MCM.SuccessTracker[9] + 1)
				if (PSC_MCM.SuccessTracker[9] > 2000000000)
					PSC_MCM.SuccessTracker[9] = 0
				endif
				Debug.Notification("That whole unpleasantness in Winterhold has probably blown over.")
			endif
		endif

		if ((PSC_MCM.BountyNonViolent[0] + PSC_MCM.BountyViolent[0]) > 0)
			int i = n
			while (i > 0)
				DecayBounty(0)
				i -= 1
			endwhile
			if ((PSC_MCM.BountyNonViolent[0] + PSC_MCM.BountyViolent[0]) == 0)	;if no bounty, then it has decayed away.
				;end pardon without penalty.
				PSC_MCM.PardonEndTime[0] = (Utility.GetCurrentGameTime() * 24)
				;increase tracker
				PSC_MCM.SuccessTracker[0] = (PSC_MCM.SuccessTracker[0] + 1)
				if (PSC_MCM.SuccessTracker[0] > 2000000000)
					PSC_MCM.SuccessTracker[0] = 0
				endif
				Debug.Notification("That other place has surely forgotten my little indiscretion.")
			endif
		endif
	EndIf
	RegisterUpdateTime()
EndEvent