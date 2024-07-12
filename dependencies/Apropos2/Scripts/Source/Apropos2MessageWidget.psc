ScriptName Apropos2MessageWidget Extends SKI_WidgetBase

Apropos2SystemConfig Property Config Auto

String _messageText = ""
String _nextMessageText = ""
String _font = "$EverywhereMediumFont"
String _align = "left"
Int _textSize = 16
Bool _visible = False
Int _textColor = 0xFFFFFF
Int _widgetWidth = 300

; Function FadeOut()
;     If Ready
;         Debug("FadeOut")
;         FadeTo(0.0, FadeOutDuration)
;     EndIf
; EndFunction

; Function FadeIn()
;     If Ready
;         Debug("FadeIn")
;         FadeTo(1.0, FadeInDuration)
;     EndIf
; EndFunction

; int function GetVersion()
;     return 2
; endFunction

; ; @implements SKI_QuestBase
; event OnVersionUpdate(int a_version)
    
;     ; Version 2
;     if (a_version >= 2 && CurrentVersion < 2)
;         Debug(self + ": Updating to script version 2")

;     endIf
; endEvent

Function DisplayMessage(String mess)
    MessageText = mess
EndFunction

Bool Property IsLargeWidget = False AutoReadOnly

String Property DebugText
    String Function get()
        Return "Widget " + WidgetIndex + ", IsEnabled : " + IsEnabled + ", Section: " + WidgetSection + ", SecondsToDisplay: " + SecondsToDisplay
    EndFunction
EndProperty

Function DisplayPlayerMessage(String mess)
    ; Log("DisplayPlayerMessage(" + mess + ")")
    ; Log("... WidgetIndex : " + WidgetIndex)
    If WidgetIndex != 0
        Return
    EndIf

    MessageText = mess
EndFunction

Function Test(String text = "")
    Log("Running Test " + text)
    DisplayMessage(WidgetName + text)
EndFunction

Float Property SecondsToDisplay = 7.0 Auto

Bool Property IsEnabled         = False Auto

Bool _isReadyForUpdate = True
Bool Property IsReadyForUpdate
    Bool Function get()
        Return _isReadyForUpdate
    EndFunction
EndProperty

Float Property FadeOutDuration = 1.0 Auto
Float Property FadeInDuration = 0.1 Auto

; True: will be used for main SL animation descriptions, 
; False: will be used for misc descriptions, e.g. W&T, custom mod messages
Int Property WidgetIndex = -1 Auto
String Property WidgetSection Auto

Event OnUpdate()
    ;Debug("OnUpdate")
    ; FadeOut()

    _messageText = ""
    _isReadyForUpdate = True

    If _nextMessageText
        String tmp = _nextMessageText
        _nextMessageText = ""
        MessageText = tmp
    Else
        UpdateWidgetText("")
        Visible = False
    EndIf

EndEvent

String Property MessageText
    String Function get()
        Return _messageText
    EndFunction

    Function set(String a_val)
        ;Debug("MessageText.set(" + a_val + ")")
        ;Debug("_isReadyForUpdate : " + _isReadyForUpdate)

        If !_isReadyForUpdate
            _nextMessageText = a_val
            ;Debug("_messageText : " + _messageText)
            ;Debug("_nextMessageText : " + _nextMessageText)
            Return
        EndIf

        _isReadyForUpdate = False
        _messageText = a_val

        Visible = True
        UpdateWidgetText(_messageText)

        ;FadeIn()

        UnregisterForUpdate()
        RegisterForSingleUpdate(SecondsToDisplay)
    EndFunction
EndProperty

Int Property TextColor
    Int Function Get()
        Return _textColor
    EndFunction

    Function Set(Int newValue)
        _textColor = newValue
        UpdateWidgetTextColor(_textColor)
    EndFunction
EndProperty

Bool Property Visible
    Bool Function get()
        Return _visible
    EndFunction

    Function set(Bool a_val)
        _visible = a_val
        UpdateWidgetVisible(_visible)
    EndFunction
EndProperty

String Property Font
    String Function get()
        Return _font
    EndFunction

    Function set(String a_val)
        _font = a_val
        UpdateWidgetFont(_font)
    EndFunction
EndProperty

String Property Align
    String Function get()
        Return _align
    EndFunction

    Function set(String a_val)
        _align = a_val
        UpdateWidgetTextAlignment(_align)
    EndFunction
EndProperty

Int Property TextSize
    Int Function get()
        Return _textSize
    EndFunction
    
    Function set(Int a_val)
        _textSize = a_val
        UpdateWidgetTextSize(_textSize)
    EndFunction
EndProperty

Int Property WidgetWidth
    Int Function get()
        Return _widgetWidth
    EndFunction
    Function set(Int a_val)
        _widgetWidth = a_val
        UpdateWidgetWidth(_widgetWidth)
    EndFunction
EndProperty

Event OnWidgetReset()
    Log("OnWidgetReset")
    Parent.OnWidgetReset()
    UpdateWidgetFont(_font)
    UpdateWidgetTextSize(_textSize)
    UpdateWidgetTextColor(_textColor)
    UpdateWidgetTextAlignment(_align)
    UpdateWidgetText(_messageText)
EndEvent

Event OnWidgetInit()
    string[] hudModes = new string[14]
    hudModes[0] = "All"
    hudModes[1] = "StealthMode"
    hudModes[2] = "Favor"
    hudModes[3] = "Swimming"
    hudModes[4] = "HorseMode"
    hudModes[5] = "WarHorseMode"
    hudModes[6] = "MovementDisabled"
    hudModes[7] = "InventoryMode"
    hudModes[8] = "BookMode"
    hudModes[9] = "DialogueMode"
    hudModes[10] = "BarterMode"
    hudModes[11] = "TweenMode"
    hudModes[12] = "WorldMapMode"
    hudModes[13] = "CartMode"
    ;hudModes[14] = "SleepWaitMode"
    ;hudModes[15] = "JournalMode"
    ;hudModes[16] = "VATSPlayback"

    Modes = hudModes
EndEvent

Event OnWidgetLoad()
    Log("OnWidgetLoad")
    ; Don't call the parent event since it will display the widget regardless of the Visible property.
    ;Parent.OnWidgetLoad()

    OnWidgetReset()

    UpdateWidgetModes()

    ; Determine if the widget should be displayed
    UpdateWidgetVisible(_visible)
EndEvent

; @overrides SKI_WidgetBase
Float[] Function GetDimensions()
    {Return the dimensions of the widget (width,height).}
    Float[] dim = New Float[2]
    dim[0] = UI.GetFloat(HUD_MENU, WidgetRoot + "._width")
    dim[1] = UI.GetFloat(HUD_MENU, WidgetRoot + "._height")
    Return dim
EndFunction

; @overrides SKI_WidgetBase
String Function GetWidgetSource()
    Return "Apropos2/MessageWidget.swf"
EndFunction

; @overrides SKI_WidgetBase
String Function GetWidgetType()
    ; Must be the same as scriptname
    Return "Apropos2MessageWidget"
EndFunction

Function MoveTo(Int newX, Int newY)
    ; If Config.TraceMessagesEnabled
    ;     Log("MoveTo("+ newX +"," + newY + ")")
    ; EndIf
    UpdateWidgetVisible(False)
    If (newX As Float != X)
        X = newX As Float
    EndIf
    If (newY As Float != Y)
        Y = newY As Float
    EndIf
    UpdateWidgetVisible(_visible)
EndFunction

Function UpdateWidgetText(String a_val)
    If !Ready
        Log("Not ready")
        Return
    EndIf    
    ; If Config.TraceMessagesEnabled
    ;     Log("UpdateWidgetText -> " + a_val)
    ; EndIf
    UI.InvokeString(HUD_MENU, WidgetRoot + ".setMessageText", a_val)
EndFunction

Function UpdateWidgetFont(String a_val)
    If !Ready
        Log("Not ready")
        Return
    EndIf    
    ; If Config.TraceMessagesEnabled
    ;     Log("UpdateWidgetFont -> " + a_val)
    ; EndIf
    UI.InvokeString(HUD_MENU, WidgetRoot + ".setFont", a_val)
EndFunction

Function UpdateWidgetTextSize(Int a_val)
    If !Ready
        Log("Not ready")
        Return
    EndIf    
    ; If Config.TraceMessagesEnabled
    ;     Log("UpdateWidgetTextSize -> " + a_val)
    ; EndIf
    UI.InvokeNumber(HUD_MENU, WidgetRoot + ".setTextSize", a_val)
EndFunction

Function UpdateWidgetTextColor(Int a_val)
    If !Ready
        Log("Not ready")
        Return
    EndIf    
    ; If Config.TraceMessagesEnabled
    ;     Log("UpdateWidgetTextColor -> " + a_val)
    ; EndIf
    UI.InvokeNumber(HUD_MENU, WidgetRoot + ".setTextColor", a_val)
EndFunction

Function UpdateWidgetTextAlignment(String a_val)
    If !Ready
        Log("Not ready")
        Return
    EndIf
    ; If Config.TraceMessagesEnabled
    ;     Log("UpdateWidgetTextAlignment -> " + a_val)
    ; EndIf
    UI.InvokeString(HUD_MENU, WidgetRoot + ".setAlign", a_val)
EndFunction

Function UpdateWidgetVisible(Bool a_val)
    If !Ready
        Log("Not ready")
        Return
    EndIf    
    ; If Config.TraceMessagesEnabled
    ;     Log("UpdateWidgetVisible -> " + a_val)
    ; EndIf
    UI.InvokeBool(HUD_MENU, WidgetRoot + ".setVisible", a_val)
EndFunction

Function UpdateWidgetWidth(Int a_val)
    If !Ready
        Log("Not ready")
        Return
    EndIf    
    ; If Config.TraceMessagesEnabled
    ;     Log("UpdateWidgetWidth -> " + a_val)
    ; EndIf
    UI.InvokeNumber(HUD_MENU, WidgetRoot + ".setWidgetWidth", a_val)    
EndFunction

Function Log(String mess)
    Apropos2Util.ULog(WidgetName + ": " + mess, source="Apropos2MessageWidget")
EndFunction
