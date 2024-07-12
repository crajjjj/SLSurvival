Scriptname _SLS_LostFoundWidget extends ski_widgetbase 

event OnWidgetLoad()
	parent.OnWidgetLoad()
	OnWidgetReset()
	
	
	;LoadPosition()
	;UpdateDisplayedCount(LastLostCount)
endEvent

event OnWidgetReset()
	;dEBUG.mESSAGEBOX("wIDGET RESET")
	parent.OnWidgetReset()
	
	LoadPosition()
	;UI.SetBool(HUD_MENU, WidgetRoot + ".phaseIcon._visible", false)
	;UI.SetBool(HUD_MENU, WidgetRoot + ".phaseMeter._visible", false)
	;UpdateDisplayedCount(1)
	;UpdateDisplayedCount(0)
endEvent

String function GetWidgetType()
	Return "_SLS_LostFoundWidget"
	;return "_SLS_LostFoundWidget"
endFunction

String function GetWidgetSource()
	;return "Fertility Mode/BeeingFemaleWid1.swf"
	return "SL Survival/BeeingFemaleWid1.swf"
endFunction

Function LoadPosition()
	UI.SetBool(HUD_MENU, WidgetRoot + ".phaseIcon._visible", false)
	UI.SetBool(HUD_MENU, WidgetRoot + ".phaseMeter._visible", false)
	UI.SetBool(HUD_MENU, WidgetRoot + ".phaseText._visible", true)
	
	HAnchor	= "left"
	VAnchor	= "top"
	X = JsonUtil.GetFloatValue("SL Survival/SteepFall.json", "lostitemswidgetx", Missing = 700.0)
	Y = JsonUtil.GetFloatValue("SL Survival/SteepFall.json", "lostitemswidgety", Missing = 10.0)
	Alpha = 100.0
	;UI.Invoke(HUD_MENU, WidgetRoot + ".initCommit")
	;UI.InvokeString(HUD_MENU, WidgetRoot + ".setPhase", JsonUtil.GetStringValue("SL Survival/SteepFall.json", "lostitemsstring", Missing = "Nearby Lost Items: ") + LastLostCount)
	;UI.SetBool(HUD_MENU, WidgetRoot + ".phaseText._visible", false)
EndFunction

Function UpdateDisplayedCount(Int Count)
	;Debug.Messagebox("Update Count: " + Count)
	LastLostCount = Count
	If LastLostCount > 0
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setPhase", JsonUtil.GetStringValue("SL Survival/SteepFall.json", "lostitemsstring", Missing = "Nearby Lost Items: ") + LastLostCount)
		UI.SetBool(HUD_MENU, WidgetRoot + ".phaseText._visible", true)
	Else
		UI.SetBool(HUD_MENU, WidgetRoot + ".phaseText._visible", false)
	EndIf
EndFunction

Int LastLostCount
