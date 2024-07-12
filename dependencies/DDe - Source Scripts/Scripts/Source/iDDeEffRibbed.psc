ScriptName iDDeEffRibbed Extends zadRibbedEffect

bool Function IsConflictingMenuOpen()
	RETURN (UI.IsMenuOpen("Sleep/Wait Menu") || UI.IsMenuOpen("Dialogue Menu") || UI.IsMenuOpen("BarterMenu") || UI.IsMenuOpen("ContainerMenu") || UI.IsMenuOpen("Console") || UI.IsMenuOpen("Journal Menu"))
EndFunction

;;;;;;;;;;;;;
; Events
;;;;;;;;;;;;;
Function OnJump()
	If (!libs.IsVibrating(Target))
		libs.Log("OnJump()")
		StartEffect(3,1)
		int timeout = 0
		While (Target.GetAnimationVariableBool("bInJumpState") && (timeout <= 15))
			Utility.Wait(0.15)
			timeout += 1
		EndWhile
		StopEffect()
	Else
		libs.Log("iDDeEffRibbed.OnJump():-> Already enjoying good vibrations!")
	EndIf	
EndFunction
