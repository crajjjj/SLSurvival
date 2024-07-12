Scriptname RND_SleepCountScript extends SKI_WidgetBase

GlobalVariable Property RND_SleepPoints Auto
GlobalVariable Property RND_SleepLevel00 Auto
GlobalVariable Property RND_SleepLevel01 Auto
GlobalVariable Property RND_SleepLevel02 Auto
GlobalVariable Property RND_SleepLevel03 Auto
GlobalVariable Property RND_SleepLevel04 Auto
GlobalVariable Property RND_AutoWidget Auto

Bool SleepVisible = false
String SleepName = ""
Int    SleepSize = 100

Bool Property Visible
    Bool Function Get()
        Return SleepVisible
    EndFunction

    Function Set(bool a_val)
        SleepVisible = a_val
        If (Ready)
            UI.InvokeBool(HUD_MENU, WidgetRoot + ".setVisible", SleepVisible)
        EndIf
    EndFunction
EndProperty

String Property MessageText
    String Function Get()
        Return SleepName
    EndFunction

    Function Set(String a_val)
        SleepName = a_val
        If (Ready)
            UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", SleepName)
        EndIf
    EndFunction
EndProperty

Int Property Size
    Int Function Get()
        Return SleepSize
    EndFunction

    Function Set(int a_val)
        SleepSize = a_val
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

	if RND_SleepPoints.GetValue() < RND_SleepLevel01.GetValue()
		SleepName = "$RNDNotTired"
	elseif RND_SleepPoints.GetValue() >= RND_SleepLevel01.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel02.GetValue()
		SleepName = "$RNDSlightlyTired"
	elseif RND_SleepPoints.GetValue() >= RND_SleepLevel02.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel03.GetValue()
		SleepName = "$RNDTired"
	elseif RND_SleepPoints.GetValue() >= RND_SleepLevel03.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel04.GetValue()
		SleepName = "$RNDVeryTired"
	elseif RND_SleepPoints.GetValue() >= RND_SleepLevel04.GetValue()
		SleepName = "$RNDExhausted"
	endif

   	UI.InvokeBool(HUD_MENU, WidgetRoot + ".setVisible", SleepVisible)
  	UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", SleepName)    
EndEvent

String Function GetWidgetSource()
    Return "RNAD/RNAD_SleepCount.swf"    
EndFunction

String Function GetWidgetType()
    Return "RNAD_SleepCountScript"
EndFunction

Function UpdateStatus()

	if RND_SleepPoints.GetValue() < RND_SleepLevel01.GetValue()
		SleepName = "$RNDNotTired"
	elseif RND_SleepPoints.GetValue() >= RND_SleepLevel01.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel02.GetValue()
		SleepName = "$RNDSlightlyTired"
	elseif RND_SleepPoints.GetValue() >= RND_SleepLevel02.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel03.GetValue()
		SleepName = "$RNDTired"
	elseif RND_SleepPoints.GetValue() >= RND_SleepLevel03.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel04.GetValue()
		SleepName = "$RNDVeryTired"
	elseif RND_SleepPoints.GetValue() >= RND_SleepLevel04.GetValue()
		SleepName = "$RNDExhausted"
	endif
	If (Ready)
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", SleepName) 
	EndIf

EndFunction

Function WidgetFade()

	if RND_AutoWidget.GetValueInt() == 1
	
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", SleepName)
		FadeTo(100, 0.1)
		Utility.Wait(0.1)
		FadeTo(0, 10.0)
	
	endif	

EndFunction

Function UpdateScale()
    UI.SetInt(HUD_MENU, WidgetRoot + ".Scale", SleepSize)
EndFunction