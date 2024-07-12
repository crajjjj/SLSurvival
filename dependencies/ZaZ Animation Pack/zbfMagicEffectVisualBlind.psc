Scriptname zbfMagicEffectVisualBlind extends activemagiceffect  

Actor Property PlayerRef Auto
ImageSpaceModifier Property BlindModifier Auto
ImageSpaceModifier Property BlindModifierHeavy Auto
GlobalVariable Property BlindStrength Auto
GlobalVariable Property BlindPulseStrength Auto

Float fUpdateFreq = 7.0
Float fLastStrength

Float Function fClamp(Float afVal, Float afMin, Float afMax)
	Debug.TraceConditional("zbfMagicEffectVisualBlind fClamp: Unexpected afMin, afMax parameters.", afMin > afMax)

	Float fRet = afVal
	If afVal < afMin
		fRet = afMin
	ElseIf afVal > afMax
		fRet = afMax
	EndIf
	Return fRet
EndFunction

Float Function GetBlindStrength()
	; 100 translates to 1.25, 0 translates to 0.0
	; These values are tuned to provide a good effect at roughly 75% brightness and 50% setting
	Return fClamp(1.125 * BlindStrength.GetValue() / 100.0, afMin = 0, afMax = 2.0)
EndFunction

Float Function GetBlindPulseStrength()
	; 100 translates to 1.4625, 0 translates to 0.0
	; These values are tuned to provide a good effect at roughly 75% brightness and 50% setting
	Return fClamp(1.4625 * BlindPulseStrength.GetValue() / 100.0, afMin = 0, afMax = 2.0)
EndFunction

Bool Function IsBlindEnabled()
	;Return (Game.GetCameraState() == 0)
	Return True
EndFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If akTarget == PlayerRef
		RegisterForUpdate(fUpdateFreq)
		GoToState("BlindStart")
	EndIf
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	If akTarget == PlayerRef
		UnregisterForUpdate()
		GoToState("BlindDisabled")
	EndIf
EndEvent

State BlindDisabled
	Event OnUpdate()
		If IsBlindEnabled()
			GoToState("BlindEnabled")
		EndIf
	EndEvent
EndState

State BlindEnabled
	Event OnBeginState()
		fLastStrength = GetBlindStrength()
		
		BlindModifier.Apply(fLastStrength)
		BlindModifierHeavy.Apply(GetBlindPulseStrength())
	EndEvent
	
	Event OnEndState()
		BlindModifierHeavy.Remove()
		BlindModifier.Remove()
	EndEvent
	
	Event OnUpdate()
		If fLastStrength != GetBlindStrength()
			GoToState("BlindStart")
			Return
		EndIf
		
		If IsBlindEnabled()
			BlindModifierHeavy.Remove()
			Utility.Wait(0.1)
			BlindModifierHeavy.Apply(GetBlindPulseStrength())
		Else
			GoToState("BlindDisabled")
		EndIf
	EndEvent
EndState

State BlindStart
	Event OnBeginState()
		If IsBlindEnabled()
			GoToState("BlindEnabled")
		Else
			GoToState("BlindDisabled")
		EndIf
	EndEvent
EndState
