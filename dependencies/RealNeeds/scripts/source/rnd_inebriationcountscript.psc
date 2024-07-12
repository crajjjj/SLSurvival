Scriptname RND_InebriationCountScript extends SKI_WidgetBase

GlobalVariable Property RND_InebriationPoints Auto
GlobalVariable Property RND_InebriationLevel00 Auto
GlobalVariable Property RND_InebriationLevel01 Auto
GlobalVariable Property RND_InebriationLevel02 Auto
GlobalVariable Property RND_InebriationLevel03 Auto
GlobalVariable Property RND_InebriationLevel04 Auto
GlobalVariable Property RND_AutoWidget Auto

Bool InebriationVisible = false
String InebriationName = ""
Int    InebriationSize = 100

Bool Property Visible
    Bool Function Get()
        Return InebriationVisible
    EndFunction

    Function Set(bool a_val)
        InebriationVisible = a_val
        If (Ready)
            UI.InvokeBool(HUD_MENU, WidgetRoot + ".setVisible", InebriationVisible)
        EndIf
    EndFunction
EndProperty

String Property MessageText
    String Function Get()
        Return InebriationName
    EndFunction

    Function Set(String a_val)
        InebriationName = a_val
        If (Ready)
            UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", InebriationName)
        EndIf
    EndFunction
EndProperty

Int Property Size
    Int Function Get()
        Return InebriationSize
    EndFunction

    Function Set(int a_val)
        InebriationSize = a_val
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

	if RND_InebriationPoints.GetValue() < RND_InebriationLevel01.GetValue()
		InebriationName = "$RNDSober"
	elseif RND_InebriationPoints.GetValue() >= RND_InebriationLevel01.GetValue() && RND_InebriationPoints.GetValue() < RND_InebriationLevel02.GetValue()
		InebriationName = "$RNDDizzy"
	elseif RND_InebriationPoints.GetValue() >= RND_InebriationLevel02.GetValue() && RND_InebriationPoints.GetValue() < RND_InebriationLevel03.GetValue()
		InebriationName = "$RNDDrunk"
	elseif RND_InebriationPoints.GetValue() >= RND_InebriationLevel03.GetValue()
		InebriationName = "$RNDWasted"
	endif

   	UI.InvokeBool(HUD_MENU, WidgetRoot + ".setVisible", InebriationVisible)
  	UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", InebriationName)    
EndEvent

String Function GetWidgetSource()
    Return "RNAD/RNAD_InebriationCount.swf"    
EndFunction

String Function GetWidgetType()
    Return "RNAD_InebriationCountScript"
EndFunction

Function UpdateStatus()

	if RND_InebriationPoints.GetValue() < RND_InebriationLevel01.GetValue()
		InebriationName = "$RNDSober"
	elseif RND_InebriationPoints.GetValue() >= RND_InebriationLevel01.GetValue() && RND_InebriationPoints.GetValue() < RND_InebriationLevel02.GetValue()
		InebriationName = "$RNDDizzy"
	elseif RND_InebriationPoints.GetValue() >= RND_InebriationLevel02.GetValue() && RND_InebriationPoints.GetValue() < RND_InebriationLevel03.GetValue()
		InebriationName = "$RNDDrunk"
	elseif RND_InebriationPoints.GetValue() >= RND_InebriationLevel03.GetValue()
		InebriationName = "$RNDWasted"
	endif
	If (Ready)
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", InebriationName) 
	EndIf

EndFunction

Function WidgetFade()

	if RND_AutoWidget.GetValueInt() == 1
	
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", InebriationName)
		FadeTo(100, 0.1)
		Utility.Wait(0.1)
		FadeTo(0, 10.0)
	
	endif	

EndFunction

Function UpdateScale()
    UI.SetInt(HUD_MENU, WidgetRoot + ".Scale", InebriationSize)
EndFunction