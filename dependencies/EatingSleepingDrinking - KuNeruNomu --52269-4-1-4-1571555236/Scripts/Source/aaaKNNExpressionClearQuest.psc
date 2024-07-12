Scriptname aaaKNNExpressionClearQuest extends Quest

;Actor Property player auto

;Function ClearExpressionValues()
;	MfgConsoleFunc.ResetPhonemeModifier(player)
;	player.SetExpressionOverride(7, 50)
;EndFunction

;Function ClearPlayerExpressionOverride()
;	player.SetExpressionOverride(7, 50)
;EndFunction

Function RemovePlayerExpressionOverride(Actor thePlayer)
	MfgConsoleFunc.ResetPhonemeModifier(thePlayer)
	thePlayer.ClearExpressionOverride()
EndFunction

;Function ClearExpressionPhonemeModifier()
;	int pStartVal = 0
;	while 16 > pStartVal
;		;Debug.Trace("pStartVal : " + pStartVal)
;		MfgConsoleFunc.SetPhoneme(player, pStartVal, 0)
;		pStartVal += 1
;	endwhile
;	int mStartVal = 0
;	while 17 > mStartVal
;		;Debug.Trace("mStartVal : " + mStartVal)
;		MfgConsoleFunc.SetModifier(player, mStartVal, 0)
;		mStartVal += 1
;	endwhile
;EndFunction

Event OnClearExpression(Actor thePlayer)
	MfgConsoleFunc.ResetPhonemeModifier(thePlayer)
	thePlayer.ClearExpressionOverride()
	;thePlayer.SetExpressionOverride(7, 50)
EndEvent