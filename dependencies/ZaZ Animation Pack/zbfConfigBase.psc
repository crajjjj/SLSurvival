Scriptname zbfConfigBase Extends SKI_ConfigBase

Int Property OptionTypeEmpty = 0 AutoReadOnly Hidden
Int Property OptionTypeSlider = 1 AutoReadOnly Hidden
Int Property OptionTypeToggle = 2 AutoReadOnly Hidden
Int Property OptionTypeMenu = 3 AutoReadOnly Hidden
Int Property OptionTypeColor = 4 AutoReadOnly Hidden
Int Property OptionTypeKeymap = 5 AutoReadOnly Hidden
Int Property OptionTypeText = 6 AutoReadOnly Hidden

; 0 - none
Int[] iType
String[] sFormat
String[] sInfo
Float[] fMinValue
Float[] fMaxValue
Float[] fDefault
Float[] fStep

; Functions to override
; 
; These functions should all be overriden for a fully working mod. When properly done, the mod will
; correctly update itself, start and stop quests (for maintenance and updating properties) and so on.
; 

; Returns a float value for the specified MCM property.
; 
Float Function GetFloat(Int aiOption)
	Debug.Trace(ModName + " empty GetFloat called", 2)
	Return 0
EndFunction

; Sets a float value associated with the specified MCM property.
; 
Function SetFloat(Int aiOption, Float fValue)
	Debug.Trace(ModName + " empty SetFloat called", 2)
EndFunction

; Returns a list of strings for the specified MCM property.
; 
; String lists are used in menu options.
; 
String[] Function GetStrings(Int aiOption)
	Debug.Trace(ModName + " empty GetStrings called", 2)
EndFunction

; Handles drawing the specified text page.
; 
Function OnPageDraw(String asPage)
	Debug.Trace(ModName + " empty OnPageDraw called", 2)
EndFunction

; Handles version updates.
; 
Event OnUpdateEvent(Int aiOldVersion, Int aiVersion)
	Debug.Trace(ModName + " empty OnUpdateEvent called", 2)
EndEvent

; Derived functions
Bool Function GetBool(Int aiOption)
	Return (GetFloat(aiOption) As Bool)
EndFunction

Function SetBool(Int aiOption, Bool abValue)
	SetFloat(aiOption, abValue As Float)
EndFunction

Int Function GetInt(Int aiOption)
	Return GetFloat(aiOption) As Int
EndFunction

Function SetInt(Int aiOption, Int aiValue)
	SetFloat(aiOption, aiValue As Float)
EndFunction

Bool Function IsCloseForced()
	Return False
EndFunction

Function ForceCloseMenu()
	GoToState("CloseMenu")
	ForcePageReset()

	UI.Invoke("Journal Menu", "_root.QuestJournalFader.Menu_mc.ConfigPanelClose") ; mcm
	UI.Invoke("Journal Menu", "_root.QuestJournalFader.Menu_mc.CloseMenu") ; quest journal
EndFunction

String Function UpdateEventName()
	Return ModName + "_BaseUpdateEvent"
EndFunction

Bool Function ForceUpdateEvent(Int aiOldVersion, Int aiVersion)
	GoToState("Updating")
	String updateEvent = UpdateEventName()

	RegisterForModEvent(updateEvent, "InternalOnUpdateEvent")
	Int iEvent = ModEvent.Create(updateEvent)
	ModEvent.PushInt(iEvent, aiOldVersion)
	ModEvent.PushInt(iEvent, aiVersion)
	Return ModEvent.Send(iEvent)
EndFunction

; Handles the update event from SKI, delegates to InternalOnUpdateEvent, which calls a mod defined OnUpdateEvent
Event OnVersionUpdate(Int aiVersion)
	Debug.Trace(ModName + " OnVersionUpdate(" + aiVersion + ") vs " + CurrentVersion)
	If CurrentVersion != aiVersion
		Bool bSent = ForceUpdateEvent(CurrentVersion, aiVersion)
		Debug.TraceConditional(ModName + "(OnVersionUpdate) failed to send update event", !bSent)
	EndIf
EndEvent

Event InternalOnUpdateEvent(Int aiOldVersion, Int aiVersion)
	OnUpdateEvent(aiOldVersion, aiVersion)

	UnregisterForModEvent(UpdateEventName())
	GoToState("Idle")
EndEvent

; Default event handlers
Event OnPageReset(String asPage)
	iType = New Int[128]
	sFormat = New String[128]
	fMinValue = New Float[128]
	fMaxValue = New Float[128]
	fDefault = New Float[128]
	fStep = New Float[128]
	sInfo = New String[128]

	OnPageDraw(asPage)
EndEvent

Event OnOptionHighlight(Int aiOption)
	HandleHighlight(aiOption)
EndEvent

Event OnOptionDefault(Int aiOption)
	HandleDefault(aiOption)
EndEvent

Event OnOptionSelect(Int aiOption)
	Int iIndex = ToIndex(aiOption)
	
	If iType[iIndex] == OptionTypeToggle
		HandleSetToggle(aiOption, !GetBool(aiOption))
	EndIf
EndEvent

Event OnOptionSliderOpen(Int aiOption)
	HandleSliderOpen(aiOption)
EndEvent

Event OnOptionSliderAccept(Int aiOption, Float afValue)
	HandleSliderAccept(aiOption, afValue)
EndEvent

Event OnOptionMenuOpen(Int aiOption)
	HandleMenuOpen(aiOption)
EndEvent

Event OnOptionMenuAccept(Int aiOption, Int aiIndex)
	HandleMenuAccept(aiOption, aiIndex)
EndEvent

Event OnOptionColorOpen(Int aiOption)
	HandleColorOpen(aiOption)
EndEvent

Event OnOptionColorAccept(Int aiOption, Int aiColor)
	HandleColorAccept(aiOption, aiColor)
EndEvent

Event OnOptionKeyMapChange(Int aiOption, Int aiKeyCode, String asConflictControl, String asConflictName)
	HandleKeymapChange(aiOption, aiKeyCode, asConflictControl, asConflictName)
EndEvent

Int Function ToIndex(Int aiOption)
	Return aiOption % 256
EndFunction

Function HandleSliderOpen(Int aiOption)
	Int iIndex = ToIndex(aiOption)
	If iType[iIndex] == OptionTypeSlider
		SetSliderDialogStartValue(GetFloat(aiOption))
		SetSliderDialogDefaultValue(fDefault[iIndex])
		SetSliderDialogRange(fMinValue[iIndex], fMaxValue[iIndex])
		SetSliderDialogInterval(fStep[iIndex])
	EndIf
EndFunction

Function HandleSliderAccept(Int aiOption, Float afValue)
	Int iIndex = ToIndex(aiOption)
	If iType[iIndex] == OptionTypeSlider
		SetFloat(aiOption, afValue)
		SetSliderOptionValue(aiOption, afValue, sFormat[iIndex])
	EndIf
EndFunction

Function HandleMenuOpen(Int aiOption)
	Int iIndex = ToIndex(aiOption)
	If iType[iIndex] == OptionTypeMenu
		SetMenuDialogOptions(GetStrings(aiOption))
		SetMenuDialogStartIndex(GetInt(aiOption))
		SetMenuDialogDefaultIndex(fDefault[iIndex] As Int)
	EndIf
EndFunction

Function HandleMenuAccept(Int aiOption, Int aiIndex)
	Int iIndex = ToIndex(aiOption)
	If iType[iIndex] == OptionTypeMenu
		SetInt(aiOption, aiIndex)
		SetMenuOptionValue(aiOption, GetStrings(aiOption)[aiIndex])
	EndIf
EndFunction

Function HandleColorOpen(Int aiOption)
	Int iIndex = ToIndex(aiOption)
	If iType[iIndex] == OptionTypeColor
		SetColorDialogStartColor(GetInt(aiOption))
		SetColorDialogDefaultColor(fDefault[iIndex] As Int)
	EndIf
EndFunction

Function HandleColorAccept(Int aiOption, Int aiColor)
	Int iIndex = ToIndex(aiOption)
	If iType[iIndex] == OptionTypeColor
		SetInt(aiOption, aiColor)
		SetColorOptionValue(aiOption, aiColor)
	EndIf
EndFunction

Function HandleSetToggle(Int aiOption, Bool abValue)
	If iType[ToIndex(aiOption)] == OptionTypeToggle
		SetBool(aiOption, abValue)
		SetToggleOptionValue(aiOption, abValue)
	EndIf
EndFunction

Function HandleKeymapChange(Int aiOption, Int aiKeyCode, String asConflictControl, String asConflictName)
	Int iIndex = ToIndex(aiOption)
	If iType[iIndex] == OptionTypeKeymap
		SetInt(aiOption, aiKeyCode)
		SetKeymapOptionValue(aiOption, aiKeyCode)
	EndIf
EndFunction

Function HandleDefault(Int aiOption)
	Int iIndex = ToIndex(aiOption)

	If iType[iIndex] == OptionTypeSlider
		HandleSliderAccept(aiOption, fDefault[iIndex])
	ElseIf iType[iIndex] == OptionTypeToggle
		HandleSetToggle(aiOption, (fDefault[iIndex] != 0.0))
	ElseIf iType[iIndex] == OptionTypeMenu
		HandleMenuAccept(aiOption, fDefault[iIndex] As Int)
	ElseIf iType[iIndex] == OptionTypeColor
		HandleColorAccept(aiOption, fDefault[iIndex] As Int)
	ElseIf iType[iIndex] == OptionTypeKeymap
		SetInt(aiOption, fDefault[iIndex] As Int)
		SetKeymapOptionValue(aiOption, fDefault[iIndex] As Int)
	EndIf
EndFunction

Function HandleHighlight(Int aiOption)
	SetInfoText(sInfo[ToIndex(aiOption)])
EndFunction


Function SetOptionDefaults(Int aiOption, Float afDefault, String asInfo)
	Int iIndex = ToIndex(aiOption)

	iType[iIndex] = OptionTypeEmpty
	sFormat[iIndex] = ""
	sInfo[iIndex] = asInfo
	fMinValue[iIndex] = 0
	fMaxValue[iIndex] = 0
	fDefault[iIndex] = afDefault
	fStep[iIndex] = 0
EndFunction

Int Function CreateSliderOption(String asText, Float afValue, Float afMin, Float afMax, Float afDefault, Float afStep, String asFormatString, String asInfo, Int aiFlags = 0)
	Int iOption = AddSliderOption(asText, afValue, asFormatString, aiFlags)
	Int iIndex = ToIndex(iOption)

	SetOptionDefaults(iOption, afDefault, asInfo)
	iType[iIndex] = OptionTypeSlider
	sFormat[iIndex] = asFormatString
	fMinValue[iIndex] = afMin
	fMaxValue[iIndex] = afMax
	fStep[iIndex] = afStep

	Return iOption
EndFunction

Int Function CreateToggleOption(String asText, Bool abValue, Bool abDefault, String asInfo, Int aiFlags = 0)
	Int iOption = AddToggleOption(asText, abValue, aiFlags)

	SetOptionDefaults(iOption, abDefault As Float, asInfo)
	iType[ToIndex(iOption)] = OptionTypeToggle

	Return iOption
EndFunction

Int Function CreateMenuOption(String asText, Int aiValue, String[] asStrings, Int aiDefault, String asInfo, Int aiFlags = 0)
	Debug.TraceConditional(ModName + ": String list contains 'None' string. Bugs with MCM.", asStrings.Find("None") != -1)
	Int iOption = AddMenuOption(asText, asStrings[aiValue], aiFlags)

	SetOptionDefaults(iOption, aiDefault As Float, asInfo)
	iType[ToIndex(iOption)] = OptionTypeMenu

	Return iOption
EndFunction

Int Function CreateColorOption(String asText, Int aiColor, Int aiDefault, String asInfo, Int aiFlags = 0)
	Int iOption = AddColorOption(asText, aiColor, aiFlags)

	SetOptionDefaults(iOption, aiDefault As Float, asInfo)
	iType[ToIndex(iOption)] = OptionTypeColor

	Return iOption
EndFunction

Int Function CreateKeymapOption(String asText, Int aiKeymap, Int aiDefault, String asInfo, Int aiFlags = 0)
	Int iOption = AddKeymapOption(asText, aiKeymap, aiFlags)
	
	SetOptionDefaults(iOption, aiDefault As Float, asInfo)
	iType[ToIndex(iOption)] = OptionTypeKeymap
	
	Return iOption
EndFunction

Int Function CreateTextOption(String asText1, String asText2, String asInfo, Int aiFlags = 0)
	Int iOption = AddTextOption(asText1, asText2, aiFlags)
	
	SetOptionDefaults(iOption, 0, asInfo)
	iType[ToIndex(iOption)] = OptionTypeText
	
	Return iOption
EndFunction

;
; Legacy functions. Will be deprecated in the future.
; 
Int Function MyAddSliderOption(String asText, Float afValue, Float afMin, Float afMax, Float afDefault, Float afStep, String asFormatString, String asInfo, Int aiFlags = 0)
	Int iOption = AddSliderOption(asText, afValue, asFormatString, aiFlags)
	Int iIndex = ToIndex(iOption)

	SetOptionDefaults(iOption, afDefault, asInfo)
	iType[iIndex] = OptionTypeSlider
	sFormat[iIndex] = asFormatString
	fMinValue[iIndex] = afMin
	fMaxValue[iIndex] = afMax
	fStep[iIndex] = afStep

	Return iOption
EndFunction

Int Function MyAddToggleOption(String asText, Bool abValue, Bool abDefault, String asInfo, Int aiFlags = 0)
	Int iOption = AddToggleOption(asText, abValue, aiFlags)

	SetOptionDefaults(iOption, abDefault As Float, asInfo)
	iType[ToIndex(iOption)] = OptionTypeToggle

	Return iOption
EndFunction

Int Function MyAddMenuOption(String asText, Int aiValue, String[] asStrings, Int aiDefault, String asInfo, Int aiFlags = 0)
	Debug.TraceConditional(ModName + ": String list contains 'None' string. Bugs with MCM.", asStrings.Find("None") != -1)
	Int iOption = AddMenuOption(asText, asStrings[aiValue], aiFlags)

	SetOptionDefaults(iOption, aiDefault As Float, asInfo)
	iType[ToIndex(iOption)] = OptionTypeMenu

	Return iOption
EndFunction

Int Function MyAddColorOption(String asText, Int aiColor, Int aiDefault, String asInfo, Int aiFlags = 0)
	Int iOption = AddColorOption(asText, aiColor, aiFlags)

	SetOptionDefaults(iOption, aiDefault As Float, asInfo)
	iType[ToIndex(iOption)] = OptionTypeColor

	Return iOption
EndFunction

Int Function MyAddKeymapOption(String asText, Int aiKeymap, Int aiDefault, String asInfo, Int aiFlags = 0)
	Int iOption = AddKeymapOption(asText, aiKeymap, aiFlags)
	
	SetOptionDefaults(iOption, aiDefault As Float, asInfo)
	iType[ToIndex(iOption)] = OptionTypeKeymap
	
	Return iOption
EndFunction

Int Function MyAddTextOption(String asText1, String asText2, String asInfo, Int aiFlags = 0)
	Int iOption = AddTextOption(asText1, asText2, aiFlags)
	
	SetOptionDefaults(iOption, 0, asInfo)
	iType[ToIndex(iOption)] = OptionTypeText
	
	Return iOption
EndFunction

Auto State Idle
EndState

State Updating
	Event OnBeginState()
		Debug.Trace(ModName + ": OnBeginState (updating)")
	EndEvent

	Event OnEndState()
		Debug.Trace(ModName + ": OnEndState (updating)")
	EndEvent

	Event OnPageReset(String asPage)
		String[] empty
		Pages = empty
		CreateTextOption("Updating.... ", "", "Module is currently working and can not respond to MCM commands.\nClose MCM and wait a few seconds.")
	EndEvent

	Event OnVersionUpdate(Int aiVersion)
		Debug.Trace(ModName + " swallowed an event to update to " + aiVersion)
	EndEvent

	Bool Function ForceUpdateEvent(Int aiOldVersion, Int aiVersion)
		Return True
	EndFunction
	
	Function ForceCloseMenu()
		Debug.Trace(ModName + " internal error. Try to force close menu during update.")
	EndFunction
EndState

State CloseMenu
	Function ForceCloseMenu()
		; Do nothing, already right state
	EndFunction

	Event OnBeginState()
		RegisterForSingleUpdate(1.0)
	EndEvent

	Event OnUpdate()
		GoToState("Idle")
	EndEvent

	Event OnPageReset(String asPage)
		String[] empty
		Pages = empty
		CreateTextOption("Working....", "", "Module is currently working and can not respond to MCM commands.\nClose MCM and wait a few seconds.")
	EndEvent

	Bool Function IsCloseForced()
		Return True
	EndFunction
EndState
