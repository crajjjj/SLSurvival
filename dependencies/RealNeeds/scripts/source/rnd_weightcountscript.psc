Scriptname RND_WeightCountScript extends SKI_WidgetBase  

GlobalVariable Property RND_AutoWidget Auto

Bool WeightVisible = false
String WeightName = ""
Int    WeightSize = 100
Int	WeightCount = 0

Bool Property Visible
    Bool Function Get()
        Return WeightVisible
    EndFunction

    Function Set(bool a_val)
        WeightVisible = a_val
        If (Ready)
            UI.InvokeBool(HUD_MENU, WidgetRoot + ".setVisible", WeightVisible)	
        EndIf
    EndFunction
EndProperty

Int Property Count
	Int Function Get()
		Return WeightCount
	EndFunction

	Function set(int a_val)
		WeightCount = a_val
		If (Ready)
			UI.InvokeInt(HUD_MENU, WidgetRoot + ".setCount", WeightCount) 
		EndIf
	EndFunction
EndProperty

String Property MessageText
    String Function Get()
        Return WeightName
    EndFunction

    Function Set(String a_val)
        WeightName = a_val
        If (Ready)
            UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", WeightName)
        EndIf
    EndFunction
EndProperty

Int Property Size
    Int Function Get()
        Return WeightSize
    EndFunction

    Function Set(int a_val)
        WeightSize = a_val
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
	
	If RND_AutoWidget.GetValueInt() == 1
		FadeTo(0, 10.0)
	ElseIf RND_AutoWidget.GetValueInt() == 0
		FadeTo(100, 0.1)
	EndIf

	float Weight = Game.GetPlayer().GetActorBase().GetWeight() as float

	If Weight <= 100.0 && weight > 80.0
		WeightName = "$RNDMuscular"
	ElseIf weight <= 80.0 && weight > 60.0
		WeightName = "$RNDTrained"
	ElseIf weight <= 60.0 && weight > 40.0
		WeightName = "$RNDWiry"
	ElseIf weight <= 40.0 && weight > 20.0
		WeightName = "$RNDSlender"
	ElseIf weight <= 20.0 && weight >= 0.0
		WeightName = "$RNDSkinny"		
	EndIf

   	UI.InvokeBool(HUD_MENU, WidgetRoot + ".setVisible", WeightVisible)
	UI.InvokeInt(HUD_MENU, WidgetRoot + ".setCount", WeightCount)	
  	UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", WeightName)   
	
EndEvent

String Function GetWidgetSource()
    Return "RNAD/RNAD_WeightCount.swf"    
EndFunction

String Function GetWidgetType()
    Return "RNAD_WeightCountScript"
EndFunction

Function UpdateStatus()

	float Weight = Game.GetPlayer().GetActorBase().GetWeight() as float
	float RealWeight

	If Weight <= 100.0 && weight > 80.0
		WeightName = "$RNDMuscular"
	ElseIf weight <= 80.0 && weight > 60.0
		WeightName = "$RNDTrained"
	ElseIf weight <= 60.0 && weight > 40.0
		WeightName = "$RNDWiry"
	ElseIf weight <= 40.0 && weight > 20.0
		WeightName = "$RNDSlender"
	ElseIf weight <= 20.0 && weight >= 0.0
		WeightName = "$RNDSkinny"		
	EndIf
	
	If (Ready)
		RealWeight = ((weight + 100) * 0.5)
		UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setCount", RealWeight)	
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", WeightName) 
	EndIf

EndFunction

Function WidgetFade()

	if RND_AutoWidget.GetValueInt() == 1
	
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", WeightName)
		FadeTo(100, 0.1)
		Utility.Wait(0.1)
		FadeTo(0, 10.0)
	
	endif	

EndFunction

Function UpdateScale()
    UI.SetInt(HUD_MENU, WidgetRoot + ".Scale", WeightSize)
EndFunction