Scriptname _SNIconWidgetScript extends SKI_WidgetBase

;====================================================================================

Bool _enabled = True

String _orientation

_SNQuestScript Property _SNQuest Auto

;====================================================================================

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

Int Function Round(Float i)
	If (i - (i as Int)) < 0.5
		Return (i as Int)
	Else
		Return (Math.Ceiling(i) as Int)
	EndIf
EndFunction

;====================================================================================

String Function GetWidgetSource()
	Return "foodandsleep/statusicons.swf"
EndFunction

; @overrides SKI_WidgetBase
String Function GetWidgetType()
	; Must be the same as scriptname
	Return "SNIconWidgetScript"
endFunction

Function UpdateStatus()
	; We have to pull the data for compatibility
	If (Ready)
		Int[] args = New Int[8]
		Int HungerState = Round(_SNQuest.HungerState)
		Int FatigueState = Round(_SNQuest.FatigueState)
		Int ThirstState = Round(_SNQuest.ThirstState)
		Int DiseaseStage = _SNQuest._SNDiseaseStage.GetValue() as Int 
		If _SNQuest.NotifHud == 3
			If _SNQuest.HungerRate > 0.0 && HungerState <= 50
				args[0] = 100 - (HungerState * 2)
			EndIf
			If _SNQuest.ThirstRate > 0.0 && ThirstState <= 50
				args[1] = 100 - (ThirstState * 2)
			EndIf
			If _SNQuest.FatigueRate > 0.0 && FatigueState <= 50
				args[2] = 100 - (FatigueState * 2)
			EndIf
			If _SNQuest.WidgetDisease
				If DiseaseStage == 1 || _SNQuest.IsVanillaDiseased
					args[3] = 1
				ElseIf DiseaseStage == 2
					args[3] = 34
					args[7] = 1
				ElseIf DiseaseStage == 3
					args[3] = 67
					args[7] = 2
				ElseIf DiseaseStage == 4
					args[3] = 100
					args[7] = 2
				EndIf
			EndIf
			args[4] = _SNQuest.HungerLevel
			args[5] = _SNQuest.ThirstLevel
			args[6] = _SNQuest.FatigueLevel
		ElseIf _SNQuest.NotifHud == 2
			If HungerState <= 50
				args[0] = 100 - (HungerState * 2)
			EndIf
			If ThirstState <= 50
				args[1] = 100 - (ThirstState * 2)
			EndIf
			If FatigueState <= 50
				args[2] = 100 - (FatigueState * 2)
			EndIf
			If _SNQuest.WidgetDisease
				If DiseaseStage == 1 || _SNQuest.IsVanillaDiseased
					args[3] = 1
				ElseIf DiseaseStage == 2
					args[3] = 34
				ElseIf DiseaseStage == 3
					args[3] = 67
				ElseIf DiseaseStage == 4
					args[3] = 100
				EndIf
			EndIf
			args[4] = 0
			args[5] = 0
			args[6] = 0
			args[7] = 0
		ElseIf _SNQuest.NotifHud == 1
			If _SNQuest.HungerRate > 0.0
				args[0] = 100
			EndIf
			If _SNQuest.ThirstRate > 0.0
				args[1] = 100
			EndIf
			If _SNQuest.FatigueRate > 0.0
				args[2] = 100
			EndIf
			args[4] = _SNQuest.HungerLevel
			args[5] = _SNQuest.ThirstLevel
			args[6] = _SNQuest.FatigueLevel
			If _SNQuest.WidgetDisease
				If DiseaseStage == 1 || _SNQuest.IsVanillaDiseased
					args[3] = 100
				ElseIf DiseaseStage == 2
					args[3] = 100
					args[7] = 1
				ElseIf DiseaseStage == 3
					args[3] = 100
					args[7] = 2
				ElseIf DiseaseStage == 4
					args[3] = 100
					args[7] = 2
				EndIf
			EndIf
		Else
			args[0] = 0
			args[1] = 0
			args[2] = 0
			args[3] = 0
			args[4] = 0
			args[5] = 0
			args[6] = 0
			args[7] = 0
		EndIf
		UI.InvokeIntA(HUD_MENU, WidgetRoot + ".setStatus", args)
	EndIf
EndFunction

;====================================================================================

Event OnGameReload()
	Parent.OnGameReload()
	RegisterForModEvent("_SN_StatusUpdated", "OnStatusUpdate")
	RegisterForModEvent("_SN_UIConfigured", "OnUIConfig")
	UpdateStatus()
EndEvent

Event OnWidgetReset()
	Parent.OnWidgetReset()

	UI.InvokeBool(HUD_MENU, WidgetRoot + ".setHide", _SNQuest.WidgetHide)

	; Init numbers
	Int[] numberArgs = New Int[2]
	NumberArgs[0] = _enabled as Int
	NumberArgs[1] = _SNQuest.DefaultColor
	UI.InvokeIntA(HUD_MENU, WidgetRoot + ".initNumbers", numberArgs)

	If _SNQuest.WidgetOrient == 0
		_orientation = "vertical"
	Else
		_orientation = "horizontal"
	EndIf

	; Init strings
	String[] stringArgs = New String[1]
	StringArgs[0] = _orientation
	UI.InvokeStringA(HUD_MENU, WidgetRoot + ".initStrings", stringArgs)

	; Init commit
	UI.Invoke(HUD_MENU, WidgetRoot + ".initCommit")
	
	UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setAlpha", _SNQuest.WidgetAlpha)
	UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setColor", _SNQuest.DefaultColor)

	If _SNQuest.WidgetPos == 0
		UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPositionX", 1270 + _SNQuest.WidgetXOffset)
		UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPositionY", 710 + (_SNQuest.WidgetYOffset))
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setHAnchor", "right")
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setVAnchor", "bottom")
	ElseIf _SNQuest.WidgetPos == 1
		UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPositionX", 20 + _SNQuest.WidgetXOffset)	;15.0)
		UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPositionY", 710 + (_SNQuest.WidgetYOffset))	;705.0)
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setHAnchor", "left")
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setVAnchor", "bottom")
	ElseIf _SNQuest.WidgetPos == 2
		UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPositionX", 1270 + _SNQuest.WidgetXOffset)	;1260.0)
		UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPositionY", 20 + (_SNQuest.WidgetYOffset))	;15.0)
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setHAnchor", "right")
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setVAnchor", "top")
	ElseIf _SNQuest.WidgetPos == 3
		UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPositionX", 20 + _SNQuest.WidgetXOffset)	;15.0)
		UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPositionY", 20 + (_SNQuest.WidgetYOffset))	;15.0)
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setHAnchor", "left")
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setVAnchor", "top")
	ElseIf _SNQuest.WidgetPos == 4
		UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPositionX", 1270 + _SNQuest.WidgetXOffset)	;middle,right
		UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPositionY", 420 + (_SNQuest.WidgetYOffset))
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setHAnchor", "right")
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setVAnchor", "bottom")
	ElseIf _SNQuest.WidgetPos == 5
		UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPositionX", 20 + _SNQuest.WidgetXOffset)	;middle,left
		UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPositionY", 420 + (_SNQuest.WidgetYOffset))
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setHAnchor", "left")
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setVAnchor", "bottom")
	ElseIf _SNQuest.WidgetPos == 6
		UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPositionX", 585 + _SNQuest.WidgetXOffset)	;bottom, mid
		UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPositionY", 720 + (_SNQuest.WidgetYOffset))
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setHAnchor", "left")
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setVAnchor", "bottom")
	Else
		UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPositionX", 585 + _SNQuest.WidgetXOffset)	;top, mid
		UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPositionY", 65 + (_SNQuest.WidgetYOffset))
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setHAnchor", "left")
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setVAnchor", "top")
	EndIf
	RegisterForModEvent("_SN_StatusUpdated", "OnStatusUpdate")
	RegisterForModEvent("_SN_UIConfigured", "OnUIConfig")
	UpdateStatus()
EndEvent

Event OnStatusUpdate(string a_eventName, string a_strArg, float a_numArg, Form a_sender)
	UpdateStatus()
EndEvent

Event OnUIConfig(string a_eventName, string a_strArg, float a_numArg, Form a_sender)
	OnWidgetReset()
EndEvent