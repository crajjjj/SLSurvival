Scriptname sr_InfEventStatus extends sr_InfEventbase

sr_inflateMessages Property msgQ auto

bool Function Filter()
	If inflater.player.GetFactionRank(inflater.inflateFaction) >= 20 && Utility.RandomInt(0, 99) < (chance + msgQ.getMod())
		If msgQ.getMod() > 0
			msgQ.setMod(0)
		EndIf
		return true
	EndIf
	return false
EndFunction

Function Execute()
	If inflater.player.GetFactionRank(inflater.inflateFaction) >= 20
		msgQ.processMessage()
	EndIf
EndFunction
