Scriptname RND_HungerCountScript extends SKI_WidgetBase

GlobalVariable Property RND_HungerPoints Auto
GlobalVariable Property RND_HungerLevel00 Auto
GlobalVariable Property RND_HungerLevel01 Auto
GlobalVariable Property RND_HungerLevel02 Auto
GlobalVariable Property RND_HungerLevel03 Auto
GlobalVariable Property RND_HungerLevel04 Auto
GlobalVariable Property RND_HungerLevel05 Auto
GlobalVariable Property RND_AutoWidget Auto

Bool HungerVisible = false
String HungerName = ""
Int    HungerSize = 100

Bool Property Visible
    Bool Function Get()
        Return HungerVisible
    EndFunction

    Function Set(bool a_val)
        HungerVisible = a_val
        If (Ready)
            UI.InvokeBool(HUD_MENU, WidgetRoot + ".setVisible", HungerVisible)	
        EndIf
    EndFunction
EndProperty

String Property MessageText
    String Function Get()
        Return HungerName
    EndFunction

    Function Set(String a_val)
        HungerName = a_val
        If (Ready)
            UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", HungerName)
        EndIf
    EndFunction
EndProperty

Int Property Size
    Int Function Get()
        Return HungerSize
    EndFunction

    Function Set(int a_val)
        HungerSize = a_val
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
	elseif RND_AutoWidget.GetValueInt() == 0
		FadeTo(100, 0.1)
	endIf

	if RND_HungerPoints.GetValue() < RND_HungerLevel01.GetValue()
		HungerName = "$RNDOverindulged"	
	elseif RND_HungerPoints.GetValue() >= RND_HungerLevel01.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel02.GetValue()
		HungerName = "$RNDSatiated"
	elseif RND_HungerPoints.GetValue() >= RND_HungerLevel02.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel03.GetValue()
		HungerName = "$RNDPeckish"
	elseif RND_HungerPoints.GetValue() >= RND_HungerLevel03.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel04.GetValue()
		HungerName = "$RNDHungry"
	elseif RND_HungerPoints.GetValue() >= RND_HungerLevel04.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel05.GetValue()
		HungerName = "$RNDVeryHungry"	
	elseif RND_HungerPoints.GetValue() >= RND_HungerLevel05.GetValue()
		HungerName = "$RNDStarving"		
	endif

   	UI.InvokeBool(HUD_MENU, WidgetRoot + ".setVisible", HungerVisible)
  	UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", HungerName)   
	
EndEvent

String Function GetWidgetSource()
    Return "RNAD/RNAD_HungerCount.swf"    
EndFunction

String Function GetWidgetType()
    Return "RNAD_HungerCountScript"
EndFunction

Function UpdateStatus()

	if RND_HungerPoints.GetValue() < RND_HungerLevel01.GetValue()
		HungerName = "$RNDOverindulged"	
	elseif RND_HungerPoints.GetValue() >= RND_HungerLevel01.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel02.GetValue()
		HungerName = "$RNDSatiated"
	elseif RND_HungerPoints.GetValue() >= RND_HungerLevel02.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel03.GetValue()
		HungerName = "$RNDPeckish"
	elseif RND_HungerPoints.GetValue() >= RND_HungerLevel03.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel04.GetValue()
		HungerName = "$RNDHungry"
	elseif RND_HungerPoints.GetValue() >= RND_HungerLevel04.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel05.GetValue()
		HungerName = "$RNDVeryHungry"	
	elseif RND_HungerPoints.GetValue() >= RND_HungerLevel05.GetValue()
		HungerName = "$RNDStarving"		
	endif
	
	If (Ready)
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", HungerName) 
	EndIf

EndFunction

Function WidgetFade()

	if RND_AutoWidget.GetValueInt() == 1
	
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", HungerName)
		FadeTo(100, 0.1)
		Utility.Wait(0.1)
		FadeTo(0, 10.0)
	
	endif	

EndFunction

Function UpdateScale()
    UI.SetInt(HUD_MENU, WidgetRoot + ".Scale", HungerSize)
EndFunction