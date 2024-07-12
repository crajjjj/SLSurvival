Scriptname Apropos2WidgetManager extends Quest

Import Apropos2Util
Import ApUtil

Apropos2SystemConfig Property Config Auto

Apropos2MessageWidget Property MessageWidget0 Auto
Apropos2MessageWidget Property MessageWidget1 Auto
Apropos2MessageWidget Property MessageWidget2 Auto
Apropos2MessageWidget Property MessageWidget3 Auto
Apropos2MessageWidget Property MessageWidget4 Auto
Apropos2MessageWidget Property MessageWidget5 Auto
Apropos2MessageWidget Property MessageWidget6 Auto
Apropos2MessageWidget Property MessageWidget7 Auto
Apropos2MessageWidget Property MessageWidget8 Auto
Apropos2MessageWidget Property MessageWidget9 Auto
Apropos2MessageWidget[] Property MessageWidgets Auto Hidden

; Inbound queue request data
String[] _msgSections
String[] _msgTexts
; Once we reach the end of the arrays, we start over.
Int _firstMsg
Int _msgCount
Bool _isRunning

String _horizontalAnchor
String _verticalAnchor
Int _widgetspacing
Int _horizontalOffset
Int _verticalOffset
Bool _testMode
Int _fontSize
Int _playerFontSize
Float _alpha
Bool _initialized
Bool _isEnabled
Bool _isVisible
Float _secondsToDisplay
Int _testKey
Int _widgetWidth

Event OnInit()
	Log("OnInit")
    SetUpMessageWidgets()
    InitMessageWidgets()
    _msgTexts    = new String[128]
    _msgSections = new String[128]
EndEvent

Function Setup()
    Debug("Setup")

    If !MessageWidgets
        SetUpMessageWidgets()
    EndIf

EndFunction

; This function never release the lock on "self"
Function EnsurePumpIsRunning()
	If !_isRunning
		_isRunning = True
		RegisterForSingleUpdate(0.1) ; <-- this function has the same self as this script, so calling RegisterForSingleUpdate()
	EndIf                            ; will not unlock the script. (However, once the EnsurePumpIsRunning() function has finished,
EndFunction                          ; other threads CAN sneak in during the wait time before the update).

Int Property MaxQueueLength = 128 AutoReadOnly

; This function never release the lock on "self"
; (mess) -> queues messages for W&T
Function EnqueueDescriptionMessage(String mess, String section)
	Int index = (_firstMsg + _msgCount) % MaxQueueLength
	_msgCount += 1
	_msgSections[index] = section
	_msgTexts[index] = mess
	EnsurePumpIsRunning()
EndFunction

; Displays message to player widget directly, without queuing, threading logic.
Function DisplayPlayerDescriptionMessage(String mess)
    MessageWidgets[0].DisplayPlayerMessage(mess)
    UpdatePosition(0)
EndFunction

Event OnUpdate()
    While _msgCount != 0
        int index = _firstMsg
        _firstMsg += 1
        If _firstMsg > (MaxQueueLength - 1)
            _firstMsg = 0
        EndIf
        _msgCount -= 1

        ; If Config.AreTraceMessagesEnabled()
        ;     Config.Log("OnUpdate... _firstMsg : " + _firstMsg + ", _msgCount : " + _msgCount, True)
        ; EndIf   

        String section = _msgSections[index]
        String text = _msgTexts[index]

        ; If Config.AreDebugMessagesEnabled()
        ;     Config.Log("OnUpdate... section : " + section + ", text " + text, True)
        ; EndIf        

        Apropos2MessageWidget widget = FindWidget(section)

        If widget
            widget.DisplayMessage(text)
            UpdatePosition(widget.WidgetIndex)
        Else
            Error("Could not find an available widget for message: '" + text + "'")
        EndIf

    EndWhile
    _isRunning = False
EndEvent

; used to test graphical functionality of widget only. Unrelated to queuing system.
Function PerformVisualTest(Bool CausedByPropertySetter=False)
    If !_initialized
        Return
    EndIf

    If !Enabled
        Notification("You need to enable Apropos Message MessageWidgets in")
        Notification("the MCM menu in order to be able to perform tests.")
    EndIf    
    
    If !TestMode
        If !CausedByPropertySetter
            Notification("Unable to run Apropos widget test because Test mode is not enabled in MCM.")
        EndIf
    Else
        Debug("AproposWidgetManager.PerformVisualTest")

        UpdateAllWidgetPositions()
        Notification(CreateTestSentence(1, 5))

        Int i = 0
        While i < MessageWidgets.Length
            MessageWidgets[i].Test(" : " + CreateTestSentence(10, 15) + ".")
            ;Notification(CreateTestSentence(1, 5))
            i += 1
        EndWhile
    EndIf
EndFunction

Apropos2MessageWidget Function FindWidget(String section)
    Int i = 1 
    While i < MessageWidgets.Length
        Apropos2MessageWidget widget = MessageWidgets[i]
        ;Config.Log("FindWidget() " + widget.DebugText)
        If widget.IsEnabled && widget.WidgetSection == section
            Return widget
        EndIf
        i += 1
    EndWhile
    Return None
EndFunction

Function SetUpMessageWidgets()
	Log("SetUpMessageWidgets", display="console,trace")
	MessageWidgets = New Apropos2MessageWidget[7]
	MessageWidgets[0] = MessageWidget0
	MessageWidgets[1] = MessageWidget1
	MessageWidgets[2] = MessageWidget2
	MessageWidgets[3] = MessageWidget3
	MessageWidgets[4] = MessageWidget4
	MessageWidgets[5] = MessageWidget5
	MessageWidgets[6] = MessageWidget6
	; MessageWidgets[7] = MessageWidget7
	; MessageWidgets[8] = MessageWidget8
	; MessageWidgets[9] = MessageWidget9

    MessageWidgets[0].IsEnabled = True
    MessageWidgets[1].IsEnabled = True
    MessageWidgets[2].IsEnabled = True
    MessageWidgets[3].IsEnabled = True
    MessageWidgets[4].IsEnabled = True
    MessageWidgets[5].IsEnabled = True
    MessageWidgets[6].IsEnabled = True

    MessageWidgets[0].WidgetSection = "Player"
    MessageWidgets[1].WidgetSection = "NPC"
    MessageWidgets[2].WidgetSection = "NPC"
    MessageWidgets[3].WidgetSection = "NPC"
    MessageWidgets[4].WidgetSection = "MISC"
    MessageWidgets[5].WidgetSection = "MISC"
    MessageWidgets[6].WidgetSection = "MISC"

    Int i = 0 
    While i < MessageWidgets.Length
        Apropos2MessageWidget widget = MessageWidgets[i]
        widget.WidgetIndex = i
        i += 1
    EndWhile
    Log("SetUpMessageWidgets - Finished", display="console,trace")
EndFunction

Function InitMessageWidgets()
    Debug("InitMessageWidgets")

    Self.Enabled = True
    Self.Visible = False
    _testMode = False
    _fontSize = DefaultFontSize
    _playerFontSize = DefaultPlayerFontSize
    _horizontalAnchor = DefaultHorizontalAnchor
    _verticalAnchor = DefaultVerticalAnchor
    _horizontalOffset = DefaultHorizontalOffset
    _verticalOffset = DefaultVerticalOffset
    _widgetspacing = DefaultWidgetspacing
    _secondsToDisplay = DefaultSecondsToDisplay
    _widgetWidth = DefaultWidgetWidth
    _alpha = 100.0
    UpdateMessageWidgets()
    _initialized = True
EndFunction

Function UpdateMessageWidgets()
	UpdateStyle()
	UpdateAllWidgetPositions()
EndFunction

Function UpdateStyle()
    Self.Alpha = _alpha
    Self.FontSize = _fontSize
    Self.PlayerFontSize = _playerFontSize
    ;Self.Visible = _isVisible
EndFunction

Function Stop()
	Self.Enabled = FALSE
	Int i = 0
	While i < MessageWidgets.Length
		MessageWidgets[i].Stop()
		i +=1 
	EndWhile
	Parent.Stop()
EndFunction

Bool Property TestMode
    Bool Function get()
        Return _testMode
    EndFunction

    Function set(Bool a_val)
        _testMode = a_val
    EndFunction
EndProperty

Bool Property Enabled
	Bool Function get()
		Return _isEnabled
	EndFunction

	Function set(Bool a_val)
        ; If Config.TraceMessagesEnabled
        ;     Log("Apropos2WidgetManager.Enabled.set(" + a_val + ")", display="console,trace")
        ; EndIf
		If a_val
			_isEnabled = a_val
			Self.Visible = _isEnabled
		Else
			Self.Visible = a_val
			_isEnabled = a_val
		EndIf                        
	EndFunction
EndProperty

Bool Property Visible
	Bool Function Get()
		Return _isVisible
	EndFunction

	Function Set(Bool a_val)
        ; If Config.TraceMessagesEnabled
        ;     Log("Apropos2WidgetManager.Visible.set(" + a_val + ")", display="console,trace")
        ; EndIf
		If _isEnabled
			 _isVisible = a_val

			 Int i = 0
			 While i < MessageWidgets.Length
			 	MessageWidgets[i].Visible = a_val
			 	i += 1
             EndWhile
        EndIf
    EndFunction
EndProperty

Float Property SecondsToDisplay
    Float Function get()
        Return _secondsToDisplay
    EndFunction

    Function set(Float a_val)
        ; If Config.TraceMessagesEnabled
        ;     Log("Apropos2WidgetManager.SecondsToDisplay.set(" + a_val + ")", display="console,trace")
        ; EndIf
        _secondsToDisplay = a_val
        Int i = 0
        While i < MessageWidgets.Length
            MessageWidgets[i].SecondsToDisplay = a_val
            i += 1
        EndWhile
        PerformVisualTest(CausedByPropertySetter=True)        
    EndFunction
EndProperty

Int Property FontSize
    Int Function get()
        Return _fontSize
    EndFunction

    Function set(Int a_val)
        ; If Config.TraceMessagesEnabled
        ;     Log("FontSize.set(" + a_val + ")", source="Apropos2WidgetManager", display="console,trace")
        ; EndIf
        _fontSize = a_val
		Int i = 1
		While i < MessageWidgets.Length
			MessageWidgets[i].TextSize = a_val
			i += 1
		EndWhile
        UpdateAllWidgetPositions()
        PerformVisualTest(CausedByPropertySetter=True)
    EndFunction
EndProperty

Int Property PlayerFontSize
    Int Function get()
        Return _playerFontSize
    EndFunction

    Function set(Int a_val)
        ; If Config.TraceMessagesEnabled
        ;     Debug("Apropos2WidgetManager.PlayerFontSize.set(" + a_val + ")")
        ; EndIf
        _playerFontSize = a_val
        If MessageWidgets && MessageWidgets.Length > 0
            MessageWidgets[0].TextSize = a_val
        EndIf
        UpdateAllWidgetPositions()
        PerformVisualTest(CausedByPropertySetter=True)
    EndFunction
EndProperty

Int Property WidgetWidth
    Int Function get()
        If _widgetWidth == 0
            _widgetWidth = DefaultWidgetWidth
        EndIf
        Return _widgetWidth
    EndFunction

    Function set(Int a_val)
        ; If Config.TraceMessagesEnabled
        ;     Log("WidgetWidth.set(" + a_val + ")", source="Apropos2WidgetManager", display="console,trace")
        ; EndIf
        _widgetWidth = a_val
        Int i = 0
        While i < MessageWidgets.Length
            MessageWidgets[i].WidgetWidth = a_val
            i += 1
        EndWhile
        ;UpdateAllWidgetPositions()
        PerformVisualTest(CausedByPropertySetter=True)
    EndFunction
EndProperty

Int Property Widgetspacing
    Int Function get()
        Return _widgetspacing
    EndFunction

    Function set(Int a_val)
        ; If Config.TraceMessagesEnabled
        ;     Debug("Apropos2WidgetManager.Widgetspacing.set(" + a_val + ")")
        ; EndIf
        _widgetSpacing = a_val
        UpdateAllWidgetPositions()
        PerformVisualTest(CausedByPropertySetter=True)
    EndFunction
EndProperty

Int Property HorizontalOffset
    Int Function get()
        Return _horizontalOffset
    EndFunction

    Function set(Int a_val)
        ; If Config.TraceMessagesEnabled
        ;     Log("HorizontalOffset.set(" + a_val + ")")
        ; EndIf
        _horizontalOffset = a_val
        UpdateAllWidgetPositions()
        PerformVisualTest(CausedByPropertySetter=True)
    EndFunction
EndProperty

Int Property VerticalOffset
    Int Function get()
        Return _verticalOffset
    EndFunction

    Function set(Int a_val)
        ; If Config.TraceMessagesEnabled
        ;     Log("VerticalOffset.set(" + a_val + ")")
        ; EndIf
        _verticalOffset = a_val
        UpdateAllWidgetPositions()
        PerformVisualTest(CausedByPropertySetter=True)
    EndFunction
EndProperty

String Property HorizontalAnchor
    String Function get()
        Return _horizontalAnchor
    EndFunction

    Function set(String a_val)
        If !a_val
            If Config.TraceMessagesEnabled
                Log("HorizontalAnchor.set(<empty string>)... Aborting")
            EndIf
            Return
        EndIf
                
        ; If Config.TraceMessagesEnabled
        ;     Log("HorizontalAnchor.set(" + a_val + ")")
        ; EndIf
        _horizontalAnchor = a_val
		Int i = 0
		While i < MessageWidgets.Length
			MessageWidgets[i].Align = a_val
			i += 1
		EndWhile
        UpdateAllWidgetPositions()
        PerformVisualTest(CausedByPropertySetter=True)
    EndFunction
EndProperty

String Property VerticalAnchor
    String Function get()
        Return _verticalAnchor
    EndFunction

    Function set(String a_val)
        If !a_val
            If Config.TraceMessagesEnabled
                Log("VerticalAnchor.set(<empty string>)... Aborting")
            EndIf
            Return
        EndIf

        ; If Config.TraceMessagesEnabled
        ;     Log("VerticalAnchor.set(" + a_val + ")")
        ; EndIf
        _verticalAnchor = a_val
        UpdateAllWidgetPositions()
        PerformVisualTest(CausedByPropertySetter=True)
    EndFunction
EndProperty

Function DeferredUpdateForProperties()
    UpdateAllWidgetPositions()
    PerformVisualTest(CausedByPropertySetter=True)
EndFunction

Float Property Alpha
    Float Function get()
        Return _alpha
    EndFunction

    Function set(Float a_val)
        ; If Config.TraceMessagesEnabled
        ;     Log("Apropos2WidgetManager.Alpha.set(" + a_val + ")", display="console,trace")
        ; EndIf
        _alpha = a_val
		Int i = 0
		While i < MessageWidgets.Length
			MessageWidgets[i].Alpha = a_val
			i += 1
		EndWhile
    EndFunction
EndProperty

Bool Property Ready
    Bool Function get()
    	Bool isReady = True
		Int i = 0
		While i < MessageWidgets.Length
			isReady = isReady && MessageWidgets[i].Ready
			i += 1
		EndWhile    	
		Return isReady
    EndFunction
EndProperty

Bool Property Initialized
    Bool Function get()
        Return _initialized
    EndFunction
EndProperty

Int[] Function GetOffsetPos(Int widgetIndex)
    Int[] offsetPos = New Int[2]

    Apropos2MessageWidget widget = MessageWidgets[widgetIndex]
    
    If _horizontalAnchor == "$APR_Left" || _horizontalAnchor == "Left"
        offsetPos[0] = 0
    ElseIf _horizontalAnchor == "$APR_Center" || _horizontalAnchor == "Center"
    	offsetPos[0] = (-widget.GetDimensions()[0] / 2.0) As Int
    ElseIf _horizontalAnchor == "$APR_Right" || _horizontalAnchor == "Right"
    	offsetPos[0] = -widget.GetDimensions()[0] As Int
    EndIf

    Apropos2MessageWidget firstWidget = MessageWidgets[0]

    Apropos2MessageWidget previousWidget
    Float previousHeights

    If widgetIndex == 0
        previousWidget = firstWidget
        previousHeights = 0
    Else
        previousWidget = MessageWidgets[widgetIndex - 1]
        Int i = 0
        While i < widgetIndex
            widget = MessageWidgets[i]
            previousHeights += widget.GetDimensions()[1]
            i += 1
        EndWhile
    EndIf

    ; If Config.TraceMessagesEnabled
    ;     Log("PreviousHeights " + previousHeights + ", previousYpos " + previousWidget.Y)
    ; EndIf

    ; Assumes first widget has a unique size, and all others are sized vertically uniformly.

    If _verticalAnchor == "$APR_Top" || _verticalAnchor == "Top"
        offsetPos[1] = (previousHeights + (_widgetSpacing As Float)) As Int
        ;offsetPos[1] = ((widgetIndex As Float) * (previousHeight + (_widgetSpacing As Float))) As Int
    ElseIf _verticalAnchor == "$APR_Center" || _verticalAnchor == "Center"
        offsetPos[1] = (((widgetIndex - 5) As Float) * (previousHeights + (_widgetSpacing As Float))) As Int
    ElseIf _verticalAnchor == "$APR_Bottom" || _verticalAnchor == "Bottom"
        offsetPos[1] = ((widgetIndex As Float) * -(previousHeights + (_widgetSpacing As Float))) As Int
    EndIf

    ; If Config.TraceMessagesEnabled
    ;     Log("GetOffsetPos(" + widgetIndex + ") = (" + offsetPos[0] + "," + offsetPos[1] + ")")
    ; EndIf

    Return offsetPos
EndFunction

Function UpdatePosition(Int widgetIndex)
    Int[] refPos = GetReferencePos()
    Int[] offset = GetOffsetPos(widgetIndex)
    Apropos2MessageWidget widget = MessageWidgets[widgetIndex]
    Int calc1 = refPos[0] + offset[0]
	Int calc2 = refPos[1] + offset[1]
    widget.MoveTo(calc1, calc2)
EndFunction

Function UpdateAllWidgetPositions()
	Int[] refPos = GetReferencePos()
    Int[] offset
    Int calc1
    Int calc2
	Int i = 0
    If Config.TraceMessagesEnabled
        Log("UpdateAllWidgetPositions()")
    EndIf        

    While i < MessageWidgets.Length
        offset = GetOffsetPos(i)
    	Apropos2MessageWidget widget = MessageWidgets[i]
    	calc1 = refPos[0] + offset[0]
    	calc2 = refPos[1] + offset[1]
        ; If Config.TraceMessagesEnabled
        ;     Log("... widget[" + i + "].MoveTo(" + calc1 +" ," + calc2 + ")")
        ; EndIf        
    	widget.MoveTo(calc1, calc2)
    	i += 1
    EndWhile
EndFunction

Int[] Function GetReferencePos()
    Int[] refPos = New Int[2]
    
    If (_horizontalAnchor == "Left" || _horizontalAnchor == "$APR_Left")
        refPos[0] = _horizontalOffset
    ElseIf (_horizontalAnchor == "Center" || _horizontalAnchor == "$APR_Center")
        refPos[0] = 640 + _horizontalOffset
    ElseIf (_horizontalAnchor == "Right" || _horizontalAnchor == "$APR_Right")
        refPos[0] = 1280 + _horizontalOffset
    EndIf
    
    If (_verticalAnchor == "Top" || _verticalAnchor == "$APR_Top")
        refPos[1] = _verticalOffset
    ElseIf (_verticalAnchor == "Center" || _verticalAnchor == "$APR_Center")
        refPos[1] = 360 + _verticalOffset
    ElseIf (_verticalAnchor == "Bottom" || _verticalAnchor == "$APR_Bottom")
        refPos[1] = 720 + _verticalOffset
    EndIf

    ; If Config.DebugMessagesEnabled
    ;     Log("Apropos2WidgetManager.GetReferencePos() = (" + refPos[0] + "," + refPos[1] + ")")
    ; EndIf
    
    Return refPos
EndFunction

Function Log(String msg, String display="trace, console")
    Config.Log(msg, Source="Apropos2WidgetManager")
EndFunction

Function Debug(String msg)
    Config.Debug(msg, Source="Apropos2WidgetManager")
EndFunction

Int Property    DefaultFontSize         = 16          AutoReadOnly
Int Property    DefaultPlayerFontSize   = 20          AutoReadOnly
String Property DefaultHorizontalAnchor = "$APR_Left" AutoReadOnly
String Property DefaultVerticalAnchor   = "$APR_Top"  AutoReadOnly
Int Property    DefaultHorizontalOffset = 5           AutoReadOnly
Int Property    DefaultVerticalOffset   = 134         AutoReadOnly
Int Property    DefaultWidgetspacing    = 0           AutoReadOnly
Float Property  DefaultSecondsToDisplay = 7.0         AutoReadOnly
Int Property    DefaultWidgetWidth      = 300         AutoReadOnly
