Scriptname RND_ThirstCountScript extends SKI_WidgetBase

GlobalVariable Property RND_ThirstPoints Auto
GlobalVariable Property RND_ThirstLevel00 Auto
GlobalVariable Property RND_ThirstLevel01 Auto
GlobalVariable Property RND_ThirstLevel02 Auto
GlobalVariable Property RND_ThirstLevel03 Auto
GlobalVariable Property RND_ThirstLevel04 Auto
GlobalVariable Property RND_AutoWidget Auto

Bool ThirstVisible = false
String ThirstName = ""
Int    ThirstSize = 100

Bool Property Visible
    Bool Function Get()
        Return ThirstVisible
    EndFunction

    Function Set(bool a_val)
        ThirstVisible = a_val
        If (Ready)
            UI.InvokeBool(HUD_MENU, WidgetRoot + ".setVisible", ThirstVisible)
        EndIf
    EndFunction
EndProperty

String Property MessageText
    String Function Get()
        Return ThirstName
    EndFunction

    Function Set(String a_val)
        ThirstName = a_val
        If (Ready)
            UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", ThirstName)
        EndIf
    EndFunction
EndProperty

Int Property Size
    Int Function Get()
        Return ThirstSize
    EndFunction

    Function Set(int a_val)
        ThirstSize = a_val
        If (Ready)
            UpdateScale()
        EndIf
    EndFunction
EndProperty

Function SetX(Float afX)
    If (Ready)
        X = afX
    EndIf
EndFunction

Function SetY(Float afY)
    If (Ready)
        Y = afY
    EndIf
EndFunction

Function SetHorizontalAnchor(String asAnchor)
    If (Ready)
        HAnchor = asAnchor
    EndIf
EndFunction

Function SetVerticalAnchor(String asAnchor)
    If (Ready)
        VAnchor = asAnchor
    EndIf
EndFunction

Function SetTransparency(Float afAlpha)
    If (Ready)
        Alpha = afAlpha
    EndIf
EndFunction

Event OnWidgetReset()
   	UpdateScale()
	Parent.OnWidgetReset()
	
	if RND_AutoWidget.GetValueInt() == 1
		FadeTo(0, 10.0)
	elseif 	RND_AutoWidget.GetValueInt() == 0
		FadeTo(100, 0.1)
	endIf

	if RND_ThirstPoints.GetValue() < RND_ThirstLevel01.GetValue()
		ThirstName = "$RNDQuenched"
	elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel01.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel02.GetValue()
		ThirstName = "$RNDSlightlyThirsty"
	elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel02.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel03.GetValue()
		ThirstName = "$RNDThirsty"
	elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel03.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel04.GetValue()
		ThirstName = "$RNDVeryThirsty"
	elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel04.GetValue()
		ThirstName = "$RNDDehydrated"
	endif

   	UI.InvokeBool(HUD_MENU, WidgetRoot + ".setVisible", ThirstVisible)
  	UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", ThirstName)    
EndEvent

String Function GetWidgetSource()
    Return "RNAD/RNAD_ThirstCount.swf"    
EndFunction

String Function GetWidgetType()
    Return "RNAD_ThirstCountScript"
EndFunction

Function UpdateStatus()

	if RND_ThirstPoints.GetValue() < RND_ThirstLevel01.GetValue()
		ThirstName = "$RNDQuenched"
	elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel01.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel02.GetValue()
		ThirstName = "$RNDSlightlyThirsty"
	elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel02.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel03.GetValue()
		ThirstName = "$RNDThirsty"
	elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel03.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel04.GetValue()
		ThirstName = "$RNDVeryThirsty"
	elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel04.GetValue()
		ThirstName = "$RNDDehydrated"
	endif
	If (Ready)
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", ThirstName) 
	EndIf

EndFunction

Function WidgetFade()

	if RND_AutoWidget.GetValueInt() == 1
	
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", ThirstName)
		FadeTo(100, 0.1)
		Utility.Wait(0.1)
		FadeTo(0, 10.0)
	
	endif	

EndFunction

Function UpdateScale()
    UI.SetInt(HUD_MENU, WidgetRoot + ".Scale", ThirstSize)
EndFunction