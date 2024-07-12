Scriptname _SLS_SensitivityPotion extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	SendModEvent("_SLS_IncPlayerSexSensitivity", "", GetMagnitude())
	If StorageUtil.GetIntValue(None, "_SLS_SensitivityHelp", Missing = -1) == 1
		StorageUtil.UnSetIntValue(None, "_SLS_SensitivityHelp")
		Debug.Messagebox("A sudden hot flush overcomes me as I finish drinking the potion. My head begins to spin as the heat slowly fades.")
	EndIf
EndEvent
