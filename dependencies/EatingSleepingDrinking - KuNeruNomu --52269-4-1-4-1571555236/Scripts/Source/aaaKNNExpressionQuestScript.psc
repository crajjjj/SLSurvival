Scriptname aaaKNNExpressionQuestScript extends Quest

;Actor Property player auto

;Event OnInIt()
	;RegisterForModEvent("IsPlayerCombatExpression", "CallIsPlayerCombatExpression")
;EndEvent

Function ApllyExpressionValues(Actor thePlayer, int[] values)	
	;ModExpression(exIndex, exId, exVal)
	int exprettionArraySize = values.Length
	;Debug.Trace("values.Length : " + exprettionArraySize)
	if 2 == exprettionArraySize
		;MfgConsoleFunc.ResetPhonemeModifier(thePlayer)
		
		thePlayer.SetExpressionOverride(values[0], values[1])
		int i = 0
		while i < 17
			if i < 16 && 0 != MfgConsoleFunc.GetPhoneme(thePlayer, i)
				MfgConsoleFunc.SetPhoneme(thePlayer, i, 0)
			endIf
			if 0 != MfgConsoleFunc.GetModifier(thePlayer, i)
				MfgConsoleFunc.SetModifier(thePlayer, i, 0)
			endIf
			i += 1
		endwhile
		;Debug.Notification("ApllyExpression default")
		;Debug.Notification("values[0] : " + values[0] + ". values[1] : " + values[1])
	elseIf 35 == exprettionArraySize
		;Debug.Notification("ApllyExpression custom")
		;MfgConsoleFunc.ResetPhonemeModifier(thePlayer)
		
		;Debug.Notification("values[0] : " + values[0] + ". values[1] : " + values[1])
		thePlayer.SetExpressionOverride(values[0], values[1])
		int iMax = 2
		int mpId = 0
		int mmId = 0
		While iMax < 35
			if iMax >= 2 && iMax <= 17
				;Debug.Notification("iMax : ExpressionValue " + iMax + " : " + ExpressionValue)
				MfgConsoleFunc.SetPhoneme(thePlayer, mpId, values[iMax])
				;player.SetExpressionPhoneme(mpId, (ExpressionValue as float) / 100)
				mpId += 1
			elseIf iMax > 17
				MfgConsoleFunc.SetModifier(thePlayer, mmId, values[iMax])
				;player.SetExpressionModifier(mmId, (ExpressionValue as float) / 100)
				mmId += 1
			endIf
			iMax += 1
		endWhile
	endIf
EndFunction

Event OnSetExpression(Actor thePlayer, int[] exValues)
	ApllyExpressionValues(thePlayer, exValues)
EndEvent

Event OnUpdateEyeExpression(Actor thePlayer, int[] values)
	if 4 == values.Length
		int i = 0
		while i < 4
			MfgConsoleFunc.SetModifier(thePlayer, (i + 8), values[i])
			i += 1
		endwhile
	endIf
EndEvent

;Event OnKNNGameLoaded()
	;RegisterForModEvent("IsPlayerCombatExpression", "CallIsPlayerCombatExpression")
;EndEvent

;Event CallIsPlayerCombatExpression(string eventName, string strArg, float numArg, Form sender)
;	MfgConsoleFunc.GetExpressionID(player) != 15
;EndEvent