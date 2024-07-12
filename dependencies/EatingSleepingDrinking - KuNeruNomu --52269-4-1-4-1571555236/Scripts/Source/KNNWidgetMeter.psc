Scriptname KNNWidgetMeter Extends SKI_WidgetBase


; PRIVATE VARIABLES -------------------------------------------------------------------------------

Bool _enabled = false
;float _iconSize = 0.0

; PROPERTIES --------------------------------------------------------------------------------------

Bool Property Enabled
	Bool Function Get()
		Return _enabled
	EndFunction

	Function Set(bool a_val)
		_enabled = a_val
		If (Ready)
			UI.InvokeBool(HUD_MENU, WidgetRoot + ".setEnabled", _enabled)
		EndIf
	EndFunction
EndProperty


; EVENTS ------------------------------------------------------------------------------------------

; @override SKI_WidgetBase
event OnWidgetReset()
	parent.OnWidgetReset()
	
	; Init numbers
	If (Ready)
		UI.InvokeBool(HUD_MENU, WidgetRoot + ".initNumbers", _enabled)
		if Enabled
			KNNPlugin_Utility.UpdateWidget(true)
		endIf
	endIf
	;Debug.Notification("OnWidgetReset")
endEvent


; FUNCTIONS ---------------------------------------------------------------------------------------

; @overrides SKI_WidgetBase
;string function GetWidgetSource()
;	return "skyui/arrowcount.swf"
;endFunction

string function GetWidgetSource()
	return "KNN/KNNWidgetMeter.swf"
endFunction

; @overrides SKI_WidgetBase
string function GetWidgetType()
	; Must be the same as scriptname
	return "KNNWidgetMeter"
endFunction

function setWidgetMeter(bool IsEnableTextMeter)
	if Ready
		UI.InvokeBool(HUD_MENU, WidgetRoot + ".setWidgetMeter", IsEnableTextMeter)
	endIf
endfunction

;function SetWidgetSize(int size)
;	if (size > 0 && Ready)
;		_iconSize = size	
;		UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setIconSize", _iconSize)
;	endIf
;endfunction

function SetSleepinessValue(int sleepinessValue, int isPositiveNumber)
	;float fValue = value / 1440.0 * 100
	;int positiveNumber = 1
	;if (fValue < 0)
	;	positiveNumber = 0
	;	fValue = math.abs(fValue)
	;endIf
	Int[] intArgs = New Int[2]
	intArgs[0] = sleepinessValue
	intArgs[1] = isPositiveNumber
	;Debug.Notification("SetSleepinessValue : " + iValue)
	if Ready
		UI.InvokeIntA(HUD_MENU, WidgetRoot + ".setSleepinessValue", intArgs)
	endIf
endfunction

function SetHungryValue(int hungryValue, int isPositiveNumber)
	;float fValue = value / 1440.0 * 100
	;int positiveNumber = 1
	;if (fValue < 0)
	;	positiveNumber = 0
	;	fValue = math.abs(fValue)
	;endIf
	Int[] intArgs = New Int[2]
	intArgs[0] = hungryValue
	intArgs[1] = isPositiveNumber
	;Debug.Notification("SetHungryValue : " + iValue)
	if Ready
		UI.InvokeIntA(HUD_MENU, WidgetRoot + ".setHungryValue", intArgs)
	endIf
endfunction

function SetThirstyValue(int thirstyValue, int isPositiveNumber)
	;float fValue = value / 1440.0 * 100
	;int positiveNumber = 1
	;if (fValue < 0)
	;	positiveNumber = 0
	;	fValue = math.abs(fValue)
	;endIf
	Int[] intArgs = New Int[2]
	intArgs[0] = thirstyValue
	intArgs[1] = isPositiveNumber
	;Debug.Notification("SetHungryValue : " + iValue)
	if Ready
		UI.InvokeIntA(HUD_MENU, WidgetRoot + ".setThirstyValue", intArgs)
	endIf
endfunction