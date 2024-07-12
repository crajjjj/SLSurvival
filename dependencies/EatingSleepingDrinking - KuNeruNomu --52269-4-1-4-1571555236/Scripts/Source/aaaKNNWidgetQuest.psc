scriptname aaaKNNWidgetQuest extends Quest

KNNWidgetMeter Property widget auto
KNNWidgetMeterOptional Property widgetOption auto

Event OnInit()
	widget.HAnchor = "left"
	widget.VAnchor = "bottom"
	widget.X = 1225
	widget.Y = 600
	widget.Alpha = 85.0
	StartUp()
endEvent

Function StartUp()
	widgetOption.HAnchor = "left"
	widgetOption.VAnchor = "bottom"
	widgetOption.X = 1225
	widgetOption.Y = 520
	widgetOption.Alpha = 85.0
EndFunction

Event OnWidgetHotkey(int switchWidgetType)
	if switchWidgetType == 1 || switchWidgetType == 3
		if widget.Enabled
			SetKNNWidget(false)
		else
			SetKNNWidget(true)			
		endIf
	endIf
	if switchWidgetType == 2 || switchWidgetType == 3
		if widgetOption.Enabled
			SetKNNWidgetOption(false)
		else
			SetKNNWidgetOption(true)
		endIf
	endIf
EndEvent

Function SetKNNWidget(bool value)
	widget.Enabled = value
EndFunction

float Function GetWidgetPositionX()
	return widget.X
endFunction

float Function GetWidgetPositionY()
	return widget.Y
endFunction

float Function GetWigetAlpha()
	return widget.Alpha
EndFunction

Function SetWidgetAlpha(float value)
	widget.Alpha = value
EndFunction

Function SetWidgetPositionX(float value)
	widget.X = value
endFunction

Function SetWidgetPositionY(float value)
	widget.Y = value
endFunction

Event OnChangeHungryValue(int hungryValue, int isPositiveNumber)
	widget.setHungryValue(hungryValue, isPositiveNumber)
	;debug.notification("OnChangeHungryValue")
EndEvent

Event OnChangeThirstyValue(int thirstyValue, int isPositiveNumber)
	widget.SetThirstyValue(thirstyValue, isPositiveNumber)
EndEvent

Event OnChangeSleepinessValue(int sleepinessValue, int isPositiveNumber)
	widget.SetSleepinessValue(sleepinessValue, isPositiveNumber)
EndEvent

Function SetKNNWidgetOption(bool value)
	widgetOption.Enabled = value
EndFunction

float Function GetWidgetOptionPositionX()
	return widgetOption.X
endFunction

float Function GetWidgetOptionPositionY()
	return widgetOption.Y
endFunction

float Function GetWigetOptionAlpha()
	return widgetOption.Alpha
EndFunction

Function SetWidgetOptionAlpha(float value)
	widgetOption.Alpha = value
EndFunction

Function SetWidgetOptionPositionX(float value)
	widgetOption.X = value
endFunction

Function SetWidgetOptionPositionY(float value)
	widgetOption.Y = value
endFunction

Event OnChangeDrunknessValue(int thirstyValue, int stage)
	widgetOption.SetDrunknessValue(thirstyValue, stage)
	;debug.Notification("OnChangeDrunknessValue")
EndEvent

Event OnChangeBodyhealthValue(int sleepinessValue)
	widgetOption.SetBodyhealthValue(sleepinessValue)
	;debug.Notification("OnChangeBodyhealthValue")
EndEvent

;Event OnGameReload()
	;StartUpdating()
;endEvent

;Event OnUpdate()
	;UpdateMeter()
	;RegisterForSingleUpdate(2)
;endEvent

;function StartUpdating()
;	RegisterForSingleUpdate(2)
;endFunction

;function UpdateMeter()
;	widget.SetSleepinessValue(KNNPlugin.GetBasicNeedValue("Sleepiness"))
;	widget.setHungryValue(KNNPlugin.GetBasicNeedValue("Hungry"))
;	widget.SetThirstyValue(KNNPlugin.GetBasicNeedValue("Thirsty"))
	;if KNNBar.Visible
	;	KNNBar.Visible = false
	;else
	;	KNNBar.Visible = true
	;endIf
; SetPercent(0) is empty and SetPercent(1) is full
; example how to fade bar into certain alpha value:
; HungerBar.FadeTo(0, 3.0) <- this would take 3 seconds to fade to 0 (not visible), 100 is fully visible
; you can also just set alpha if you want it instantly:
; HungerBar.Alpha = 0
;endFunction