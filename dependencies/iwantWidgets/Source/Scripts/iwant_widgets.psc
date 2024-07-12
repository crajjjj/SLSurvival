Scriptname iWant_Widgets extends SKI_WidgetBase
{iWant Scaleform (Flash) interface for widgets}

String PARAMETER_DEMARC = "|" ; Must match ActionScript code, used to pass strings as arrays, ideally the most unused character possible, really obscure values got messy with Unicode
Bool loadInProgress = False

Int Function loadWidget(String filename, Int xpos = 10000, Int ypos = 10000, Bool visible = False)
	String[] value
	String s
	value = Utility.CreateStringArray(4, "")
	value[0] = filename
	value[1] = xpos As String
	value[2] = ypos As String
	value[3] = (visible As Int) As String
	s = _serializeArray(value)

	Int id
	
	_waitForReadyToLoad()
	loadInProgress = True
	UI.InvokeString(HUD_MENU, WidgetRoot + ".loadWidget", s)
	id = (_getMessageFromFlash()) As Int
	loadInProgress = False

	Return(id)	
EndFunction

Int Function loadLibraryWidget(String filename, Int xpos = 10000, Int ypos = 10000, Bool visible = False)
	String libraryPrefix = "widgets/iwant/widgets/library/"
	String path
	Int id
	
	path = libraryPrefix + filename + ".dds"
	id = loadWidget(path, xpos, ypos, visible)
	
	Return(id)
EndFunction

Int Function loadText(String displayString, String font = "$EverywhereFont", Int size = 24, Int xpos = 10000, Int ypos = 10000, Bool visible = False)
	String[] value
	String s
	value = Utility.CreateStringArray(6, "")
	value[0] = displayString
	value[1] = font
	value[2] = size As String
	value[3] = xpos As String
	value[4] = ypos As String
	value[5] = (visible As Int) As String
	s = _serializeArray(value)

	Int id
	Bool loading
	Bool msgReady
	
	_waitForReadyToLoad()
	loadInProgress = True
	UI.InvokeString(HUD_MENU, WidgetRoot + ".loadText", s)
	id = (_getMessageFromFlash()) As Int
	loadInProgress = False

	Return(id)	
EndFunction

Int Function loadMeter(Int xpos = 10000, Int ypos = 10000, Bool visible = False)
	String[] value
	String s
	value = Utility.CreateStringArray(3, "")
	value[0] = xpos As String
	value[1] = ypos As String
	value[2] = (visible As Int) As String
	s = _serializeArray(value)

	Int id
	Bool loading
	Bool msgReady
	String inputString = ""
	
	_waitForReadyToLoad()
	loadInProgress = True
	UI.InvokeString(HUD_MENU, WidgetRoot + ".loadMeter", s)
	id = (_getMessageFromFlash()) As Int
	loadInProgress = False

	Return(id)
EndFunction

Function _waitForReadyToLoad()
	int breakout = 0

	; Make sure we have a valid SkyUI widget
	While (WidgetRoot == "")
		Utility.Wait(1.0)
	EndWhile

	; Make sure SkyUI say we're Ready
	While (!Ready)
		Utility.Wait(1.0)
	EndWhile


	; Make sure another loading call is not underway
	While loadInProgress
		Utility.Wait(0.1)

		; Seems like there's a race condition in how this check gets executed (funny since it was made to avoid a different race condition)
		; Based on reports from users, it seems there is a way for parallel changes to loadInProgress to happen
		;  resulting in a corruption of the variable and a permanent true state
		; This new breakout counter code adds a sanity check, arbitrarily I've added logic that loading shouldn't take more than 5 seconds
		; After this arbitrary timer, break out of the loop regardless.  Hopefully the odds of this being incorrect are so low
		;  they will not impact any game in actual practice and forcing the breakout clears the problems users have seen.
		breakout += 1
		If breakout > 50
			loadInProgress = False
		EndIf

	EndWhile
EndFunction

String Function _getMessageFromFlash()
	Bool msgReady
	String msg
	; Wait for widget ID to be ready
	msgReady = UI.GetBool(HUD_MENU, WidgetRoot + ".outputReady")
	While !msgReady
		msgReady = UI.GetBool(HUD_MENU, WidgetRoot + ".outputReady")
		Utility.Wait(0.1)
	EndWhile
	
	msg = UI.GetString(HUD_MENU, WidgetRoot + ".outputMessage")

	; Restore Flash message variables back to safe state
	UI.SetString(HUD_MENU, WidgetRoot + ".outputMessage","")
	UI.SetBool(HUD_MENU, WidgetRoot + ".outputReady",false)
	
	Return(msg)
EndFunction

Function setMeterPercent(Int id, Int percent)
	String s
	String[] value
	
	value = new String[2]
	value[0] = id As String
	value[1] = percent As String

	s = _serializeArray(value)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setMeterPercent", s)
EndFunction

Function setMeterFillDirection(Int id, String direction)
	String s
	String[] value
	
	value = new String[2]
	value[0] = id As String
	value[1] = direction

	s = _serializeArray(value)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setMeterFillDirection", s)
EndFunction

Function sendToBack(Int id)
	String s
	String[] value
	
	value = new String[2]
	value[0] = id As String

	s = _serializeArray(value)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".sendToBack", s)
EndFunction

Function sendToFront(Int id)
	String s
	String[] value
	
	value = new String[2]
	value[0] = id As String

	s = _serializeArray(value)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".sendToFront", s)
EndFunction

Function doMeterFlash(Int id)
	String[] value
	String s

	value = Utility.CreateStringArray(1, "")
	value[0] = id As String
	s = _serializeArray(value)

	UI.InvokeString(HUD_MENU, WidgetRoot + ".doMeterFlash", s)
EndFunction

Function setMeterRGB(Int id, Int lightR = 255, Int lightG = 255, Int lightB = 255, Int darkR = 0, Int darkG = 0, Int darkB = 0, Int flashR = 127, Int flashG = 127, Int flashB = 127)
	String s
	String[] value
	
	value = Utility.CreateStringArray(4, "")
	value[0] = id As String
	value[1] = ((lightR * 256 * 256) + (lightG * 256) + lightB) As String
	value[2] = ((darkR * 256 * 256) + (darkG * 256) + darkB) As String
	value[3] = ((flashR * 256 * 256) + (flashG * 256) + flashB) As String

	s = _serializeArray(value)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setMeterColors", s)
EndFunction

Function setText(Int id, String displayString)
	String s
	String[] value
	
	value = Utility.CreateStringArray(2, "")
	value[0] = id As String
	value[1] = displayString

	s = _serializeArray(value)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setText", s)
EndFunction

Function appendText(Int id, String displayString)
	String s
	String[] value

	value = Utility.CreateStringArray(2, "")
	value[0] = id As String
	value[1] = displayString
	
	s = _serializeArray(value)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".appendText", s)
EndFunction

Function swapDepths(Int id1, Int id2)
	String s
	String[] value
	
	value = new String[2]
	value[0] = id1 As String
	value[1] = id2 As String

	s = _serializeArray(value)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".swapDepths", s)
EndFunction

Function setPos(Int id, Int xpos, Int ypos)
	String[] value
	String s

	value = Utility.CreateStringArray(2, "")
	value[0] = id As String

	value[1] = xpos As String
	s = _serializeArray(value)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setXPos", s)

	value[1] = ypos As String
	s = _serializeArray(value)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setYPos", s)
EndFunction

Function setSize(Int id, Int h, Int w)
	String[] value
	String s

	value = Utility.CreateStringArray(2, "")
	value[0] = id As String

	value[1] = h As String
	s = _serializeArray(value)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setHeight", s)

	value[1] = w As String
	s = _serializeArray(value)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setWidth", s)
EndFunction

Int Function getXsize(Int id)
	String[] value
	String s
	
	Int size

	value = Utility.CreateStringArray(1, "")
	value[0] = id As String
	s = _serializeArray(value)

	_waitForReadyToLoad()
	loadInProgress = True
	UI.InvokeString(HUD_MENU, WidgetRoot + ".getXsize", s)
	size = (_getMessageFromFlash()) As Int
	loadInProgress = False

	Return(size)
EndFunction

Int Function getYsize(Int id)
	String[] value
	String s
	
	Int size

	value = Utility.CreateStringArray(1, "")
	value[0] = id As String
	s = _serializeArray(value)

	_waitForReadyToLoad()
	loadInProgress = True
	UI.InvokeString(HUD_MENU, WidgetRoot + ".getYsize", s)
	size = (_getMessageFromFlash()) As Int
	loadInProgress = False

	Return(size)
EndFunction

Function setZoom(Int id, Int xscale, Int yscale)
	String[] value
	String s
	
	value = Utility.CreateStringArray(2, "")
	value[0] = id As String
	
	value[1] = xscale As String
	s = _serializeArray(value)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setXScale", s)

	value[1] = yscale As String
	s = _serializeArray(value)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setYScale", s)
EndFunction

Function setVisible(Int id, Int visible = 1)
	String[] value
	String s
	
	value = Utility.CreateStringArray(2, "")
	value[0] = id As String
	
	value[1] = visible As String
	s = _serializeArray(value)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setVisible", s)
EndFunction

Function setRotation(Int id, Int rotation)
	String[] value
	String s
	
	value = Utility.CreateStringArray(2, "")
	value[0] = id As String
	
	value[1] = rotation As String
	s = _serializeArray(value)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setRotation", s)
EndFunction

Function setTransparency(Int id, Int a)
	String[] value
	String s
	
	value = Utility.CreateStringArray(2, "")
	value[0] = id As String
	
	value[1] = a As String
	s = _serializeArray(value)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setAlpha", s)
EndFunction

Function setRGB(Int id, Int r, Int g, Int b)
	String[] value
	String s

	Int color = (r * 65536) + (g * 256) + b
	
	value = Utility.CreateStringArray(2, "")
	value[0] = id As String
	value[1] = color As String
	s = _serializeArray(value)

	UI.InvokeString(HUD_MENU, WidgetRoot + ".setColor", s)
EndFunction

Function destroy(Int id)
	String[] value
	String s

	value = Utility.CreateStringArray(1, "")
	value[0] = id As String
	s = _serializeArray(value)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".destroy", s)
EndFunction

Function drawShapeLine(Int[] list, Int XPos = 639, Int YPos = 359, Int XChange = 25, Int YChange = 25, Bool skipInvisible = True, Bool skipAlpha0 = True)
	String[] value
	String s
	Int i = 0
	
	value = Utility.CreateStringArray((list.Length + 6), "")
	value[0] = XPos As String
	value[1] = YPos As String
	value[2] = XChange As String
	value[3] = YChange As String
	value[4] = (skipInvisible As Int) As String
	value[5] = (skipAlpha0 As Int) As String
	While i < list.Length
		value[(i + 6)] = list[i]
		i += 1
	EndWhile
	
	s = _serializeArray(value)

	UI.InvokeString(HUD_MENU, WidgetRoot + ".drawLine", s)
EndFunction

Function drawShapeCircle(Int[] list, Int XPos = 639, Int YPos = 359, Int radius = 50, Int startAngle = 0, Int degreeChange = 45, Bool skipInvisible = True, Bool skipAlpha0 = True, Bool autoSpace = False)
	String[] value
	String s
	Int i = 0
	
	value = Utility.CreateStringArray((list.Length + 8), "")
	value[0] = XPos As String
	value[1] = YPos As String
	value[2] = radius As String
	value[3] = startAngle As String
	value[4] = degreeChange As String
	value[5] = (skipInvisible As Int) As String
	value[6] = (skipAlpha0 As Int) As String
	value[7] = (autoSpace As Int) As String
	While i < list.Length
		value[(i + 8)] = list[i]
		i += 1
	EndWhile
	
	s = _serializeArray(value)

	UI.InvokeString(HUD_MENU, WidgetRoot + ".drawCircle", s)
EndFunction

Function drawShapeOrbit(Int[] list, Int XPos = 639, Int YPos = 359, Int radius = 50, Int startAngle = 0, Int degreeChange = 45, Bool skipInvisible = True, Bool skipAlpha0 = True, Bool autoSpace = False)
	String[] value
	String s
	Int i = 0
	
	value = Utility.CreateStringArray((list.Length + 8), "")
	value[0] = XPos As String
	value[1] = YPos As String
	value[2] = radius As String
	value[3] = startAngle As String
	value[4] = degreeChange As String
	value[5] = (skipInvisible As Int) As String
	value[6] = (skipAlpha0 As Int) As String
	value[7] = (autoSpace As Int) As String
	While i < list.Length
		value[(i + 8)] = list[i]
		i += 1
	EndWhile
	
	s = _serializeArray(value)

	UI.InvokeString(HUD_MENU, WidgetRoot + ".drawOrbit", s)
EndFunction

Function doTransition(Int id, Int targetValue, Int frames = 60, String targetAttribute = "alpha", String easingClass = "none", String easingMethod = "none", Int delay = 0)
	doTransitionByFrames(id, targetValue, frames, targetAttribute, easingClass, easingMethod, delay, fps = 30)
EndFunction

Function doTransitionByFrames(Int id, Int targetValue, Int frames = 120, String targetAttribute = "alpha", String easingClass = "none", String easingMethod = "none", Int delay = 0, Int fps = 60)
	String[] value
	String s
	Int i = 0
	Float seconds
	Float delaySeconds

	seconds = (frames As Float) / (fps As Float)
	delaySeconds = (delay As Float) / (fps As Float)

	doTransitionByTime(id, targetValue, seconds, targetAttribute, easingClass, easingMethod, delaySeconds)
EndFunction

Function doTransitionByTime(Int id, Int targetValue, Float seconds = 2.0, String targetAttribute = "alpha", String easingClass = "none", String easingMethod = "none", Float delay = 0.0)
	String[] value
	String s
	Int i = 0

	value = Utility.CreateStringArray(7, "")
	value[0] = id As String
	value[1] = targetValue As String
	value[2] = seconds As String

	If (targetAttribute == "x" || targetAttribute == "y" || targetAttribute == "xscale" || targetAttribute == "yscale" || targetAttribute == "rotation")
		value[3] = "_"+targetAttribute
	ElseIf targetAttribute == "meterpercent"
		value[1] = (targetValue / 100.0) as String
		value[3] = "percent"
	Else
		; Default to alpha
		value[3] = "_alpha"
	EndIf
	
	If (easingClass == "regular" || easingClass == "bounce" || easingClass == "back" || easingClass == "elastic" || easingClass == "strong")
		value[4] = easingClass
	Else
		; Default to no easing
		value[4] = "none"
	EndIf
	
	If (easingMethod == "in")
		value[5] = "easeIn"
	ElseIf easingMethod == "out"
		value[5] = "easeOut"
	ElseIf easingMethod == "inout"
		value[5] = "easeInOut"
	Else
		; If a valid easing method is not defined, revert to no easing
		value[4] = "none"
		value[5] = ""
	EndIf
	
	value[6] = delay As String

	s = _serializeArray(value)

	UI.InvokeString(HUD_MENU, WidgetRoot + ".doTransition", s)
EndFunction

Function setAllVisible(Bool visible = True)
	UI.InvokeBool(HUD_MENU, WidgetRoot + ".setAllVisible", visible)
EndFunction

String Function _serializeArray(String[] a)
	Int i;
	String s = "";
	
	; Avoid demarc after last value
	While (i < (a.Length - 1))
		s += a[i]+PARAMETER_DEMARC
		i += 1
	EndWhile
	
	s += a[a.Length - 1]
	
	Return (s)
EndFunction

Function logWidgetData(Int id)
	String[] value
	String s

	value = Utility.CreateStringArray(1, "")
	value[0] = id As String
	s = _serializeArray(value)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".loadWidgetData", s)
	
	Debug.Trace("======logWidgetData Start=======")

	Debug.Trace("Calculated Name: "+UI.GetString(HUD_MENU, WidgetRoot + ".widget_namecalc"))
	Debug.Trace("Object Name: "+UI.GetString(HUD_MENU, WidgetRoot + ".widget_name"))
	Debug.Trace("X: "+UI.GetInt(HUD_MENU, WidgetRoot + ".widget_x"))
	Debug.Trace("Y: "+UI.GetInt(HUD_MENU, WidgetRoot + ".widget_y"))
	Debug.Trace("Height: "+UI.GetInt(HUD_MENU, WidgetRoot + ".widget_height"))
	Debug.Trace("Width: "+UI.GetInt(HUD_MENU, WidgetRoot + ".widget_width"))
	Debug.Trace("Xscale: "+UI.GetInt(HUD_MENU, WidgetRoot + ".widget_xscale"))
	Debug.Trace("Yscale: "+UI.GetInt(HUD_MENU, WidgetRoot + ".widget_yscale"))
	Debug.Trace("Rotation: "+UI.GetInt(HUD_MENU, WidgetRoot + ".widget_rotation"))
	Debug.Trace("Alpha: "+UI.GetInt(HUD_MENU, WidgetRoot + ".widget_alpha"))
	Debug.Trace("Visible: "+UI.GetBool(HUD_MENU, WidgetRoot + ".widget_visible"))

	Debug.Trace("=======logWidgetData End========")

EndFunction

Function triggerReset()
	Debug.Trace("iWant Widgets: ***LIBRARY RESET***")
	UI.Invoke(HUD_MENU, WidgetRoot + "._reset")
	RegisterForModEvent("iWantWidgetsReset", "OniWantWidgetsReset")
	SendModEvent("iWantWidgetsReset")
EndFunction

Event OniWantWidgetsReset(String eventName, String strArg, Float numArg, Form sender)
	Debug.Trace("iWant Widgets: iWant Widgets Reset Event Fired")
EndEvent

Function setSkyrimTemperature(Int level)
	;0 = Neutral
	;1 = Fire
	;2 = Warm
	;3 = Cold
	;4 = Freezing

	UI.InvokeInt("HUD Menu", "_root.HUDMovieBaseInstance.SetCompassTemperature", level)
	UI.Invoke   ("HUD Menu", "_root.HUDMovieBaseInstance.TemperatureMeterAnim")
EndFunction

Function setSkyrimHealthMeterPercent(Int percent)
	UI.InvokeInt("HUD Menu", "_root.HUDMovieBaseInstance.SetHealthMeterPercent", percent)
EndFunction

Function setSkyrimStaminaMeterPercent(Int percent)
	UI.InvokeInt("HUD Menu", "_root.HUDMovieBaseInstance.SetStaminaMeterPercent", percent)
EndFunction

Function setSkyrimMagickaMeterPercent(Int percent)
	UI.InvokeInt("HUD Menu", "_root.HUDMovieBaseInstance.SetMagickaMeterPercent", percent)
EndFunction

String Function _getSkyrimTargetBase(String element)
	String targetBase = ""
	
	If element == "health"
		targetBase = "_root.HUDMovieBaseInstance.Health."
	ElseIf element == "magicka"
		targetBase = "_root.HUDMovieBaseInstance.Magica."
	ElseIf element == "stamina"
		targetBase = "_root.HUDMovieBaseInstance.Stamina."
	ElseIf element == "enemyhealth"
		targetBase = "_root.HUDMovieBaseInstance.EnemyHealth."
	ElseIf element == "crosshair"
		targetBase = "_root.HUDMovieBaseInstance.CrosshairInstance."
	ElseIf element == "crosshairalert"
		targetBase = "_root.HUDMovieBaseInstance.CrosshairAlert."
	ElseIf element == "stealthmeter"
		targetBase = "_root.HUDMovieBaseInstance.StealthMeterInstance."
	ElseIf element == "questmarker"
		targetBase = "_root.HUDMovieBaseInstance.FloatingQuestMarker."
	ElseIf element == "compass"
		targetBase = "_root.HUDMovieBaseInstance.CompassShoutMeterHolder."
	EndIf
	
	Return(targetBase)
EndFunction

Function setSkyrimTransparency(String element, Int a = 100)
	String targetBase = _getSkyrimTargetBase(element)
	String attribute = "_alpha"
	
	If targetBase != ""
		UI.SetInt(HUD_MENU, (targetBase + attribute), a)
	EndIf
EndFunction

Function setSkyrimZoom(String element, Int xscale = 100, Int yscale = 100)
	String targetBase = _getSkyrimTargetBase(element)
	String attribute = "_xscale"
	
	If targetBase != ""
		UI.SetInt(HUD_MENU, (targetBase + attribute), xscale)
		attribute = "_yscale"
		UI.SetInt(HUD_MENU, (targetBase + attribute), yscale)
	EndIf
EndFunction

Function setSkyrimVisible(String element, Int visible = 1)
	String targetBase = _getSkyrimTargetBase(element)
	String attribute = "_visible"
	
	If targetBase != ""
		UI.SetInt(HUD_MENU, (targetBase + attribute), visible)
	EndIf
EndFunction

Function _setSkyrimPos(String element, Int xpos = 0, Int ypos = 0)
	; This function is undocumented and included for experimentation only
	; Do not expect it to be available in all future releases
	String targetBase = _getSkyrimTargetBase(element)
	String attribute = "_x"
	
	If targetBase != ""
		UI.SetInt(HUD_MENU, (targetBase + attribute), xpos)
		attribute = "_y"
		UI.SetInt(HUD_MENU, (targetBase + attribute), ypos)
	EndIf
EndFunction

Int Function _getSkyrimXPos(String element)
	; This function is undocumented and included for experimentation only
	; Do not expect it to be available in all future releases
	String targetBase = _getSkyrimTargetBase(element)
	String attribute = "_x"
	
	If targetBase != ""
		Return(UI.GetInt(HUD_MENU, (targetBase + attribute)))
	EndIf
EndFunction

Int Function _getSkyrimYPos(String element)
	; This function is undocumented and included for experimentation only
	; Do not expect it to be available in all future releases
	String targetBase = _getSkyrimTargetBase(element)
	String attribute = "_y"
	
	If targetBase != ""
		Return(UI.GetInt(HUD_MENU, (targetBase + attribute)))
	EndIf
EndFunction

Function _setSkyrimSize(String element, Int h, Int w)
	; This function is undocumented and included for experimentation only
	; Do not expect it to be available in all future releases
	String targetBase = _getSkyrimTargetBase(element)
	String attribute = "_height"
	
	If targetBase != ""
		UI.SetInt(HUD_MENU, (targetBase + attribute), h)
		attribute = "_width"
		UI.SetInt(HUD_MENU, (targetBase + attribute), w)
	EndIf
EndFunction

Function _setSkyrimRotation(String element, Int rot = 0)
	; This function is undocumented and included for experimentation only
	; Do not expect it to be available in all future releases
	String targetBase = _getSkyrimTargetBase(element)
	String attribute = "_rotation"
	
	If targetBase != ""
		UI.SetInt(HUD_MENU, (targetBase + attribute), rot)
	EndIf
EndFunction

Event OnWidgetReset()
	; Overrides SKI_WidgetBase
	Parent.OnWidgetReset()
	
	triggerReset()
EndEvent

String Function GetWidgetSource()
	; Overrides SKI_WidgetBase
	Return("iwant\\widgets\\iWantWidgets.swf")
EndFunction

String Function GetWidgetType()
	; Overrides SKI_WidgetBase
	; Must be the same as script name
	Return "iWant_Widgets"
endFunction
