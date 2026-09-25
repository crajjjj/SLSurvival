Scriptname _SLS_IntShsPatch Hidden

; Bridge from the base scripts (sls_mcm) to _SLS_InterfaceShs, which only exists when the OPTIONAL
; SunHelm patch is installed. A property typed to _SLS_InterfaceShs in sls_mcm would fail the whole
; MCM script on load for everyone without the patch; these globals resolve lazily at call time, and
; every caller first gets the quest from GetInterface(), which is None unless the patch is loaded.

Quest Function GetInterface() Global
	If Game.GetModByName("SL Survival Sunhelm Patch.esp") != 255
		Return Game.GetFormFromFile(0x000D61, "SL Survival Sunhelm Patch.esp") as Quest ; _SLS_InterfaceShsQuest
	EndIf
	Return None
EndFunction

Bool Function GetIsInterfaceActive(Quest ShsQuest) Global
	_SLS_InterfaceShs Shs = ShsQuest as _SLS_InterfaceShs
	Return Shs && Shs.GetIsInterfaceActive()
EndFunction

; Stage = SunHelm hunger stage 0 (Well Fed) .. 5 (Desperate)
Float Function GetBellyScale(Quest ShsQuest, Int Stage) Global
	_SLS_InterfaceShs Shs = ShsQuest as _SLS_InterfaceShs
	If !Shs
		Return 0.0
	EndIf
	If Stage == 0
		Return Shs.BellyScaleShs00
	ElseIf Stage == 1
		Return Shs.BellyScaleShs01
	ElseIf Stage == 2
		Return Shs.BellyScaleShs02
	ElseIf Stage == 3
		Return Shs.BellyScaleShs03
	ElseIf Stage == 4
		Return Shs.BellyScaleShs04
	EndIf
	Return Shs.BellyScaleShs05
EndFunction

Function SetBellyScale(Quest ShsQuest, Int Stage, Float Value) Global
	_SLS_InterfaceShs Shs = ShsQuest as _SLS_InterfaceShs
	If !Shs
		Return
	EndIf
	If Stage == 0
		Shs.BellyScaleShs00 = Value
	ElseIf Stage == 1
		Shs.BellyScaleShs01 = Value
	ElseIf Stage == 2
		Shs.BellyScaleShs02 = Value
	ElseIf Stage == 3
		Shs.BellyScaleShs03 = Value
	ElseIf Stage == 4
		Shs.BellyScaleShs04 = Value
	Else
		Shs.BellyScaleShs05 = Value
	EndIf
EndFunction
