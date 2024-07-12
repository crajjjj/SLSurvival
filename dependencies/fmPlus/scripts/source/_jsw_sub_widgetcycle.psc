Scriptname		_JSW_SUB_WidgetCycle		extends		SKI_WidgetBase
;float	Alpha	=	0.00		string	HAnchor	=	"Left"			string	VAnchor	=	"Bottom"		Defaults as passed in by the quest
;float	X		=	900.0		float	Y		=	100.0
function	WidgetRegister()
	self.RegisterForModEvent("FMPatchWidgetUpdate", "OnFMPUpdateContent")
endfunction

event OnWidgetLoad()
	parent.OnWidgetLoad()
	OnWidgetReset()
endEvent

event OnWidgetReset()
	parent.OnWidgetReset()
	UI.Invoke(HUD_MENU, WidgetRoot + ".initCommit")
	OnFMPUpdateContent()
endEvent

String function GetWidgetType()
	return "_JSW_SUB_WidgetCycle"
endFunction

String function GetWidgetSource()
	self.RegisterForModEvent("FMPatchWidgetUpdate", "OnFMPUpdateContent")
	return "Fertility Mode/BeeingFemaleWid1.swf"
endFunction

event OnFMPUpdateContent(float newAlpha = 0.0, string textString = " ", int stateID = 0, float percent = 0.0, float newX = 100.0, float newY = 900.0)
	Alpha = newAlpha
	X = newX
	Y = newY
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setFillDirection", "right")
	UI.InvokeInt(HUD_MENU, WidgetRoot + ".setColor", 0x880044)
	UI.InvokeInt(HUD_MENU, WidgetRoot + ".setDarkColor", 0x880044)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setPhase", textString)
	UI.InvokeInt(HUD_MENU, WidgetRoot + ".setIcon", stateID)
	UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPercent", percent)
endEvent
