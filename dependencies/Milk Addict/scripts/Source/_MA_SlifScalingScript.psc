Scriptname _MA_SlifScalingScript extends Quest  

Event OnInit()
	CurrentAssScale = (Menu.BaseAssScale as float)
	StartSlifScaling()
EndEvent

Event OnMME_MilkCycleComplete(string eventName, string strArg, float numArg, Form sender)
	UnregisterForModEvent("MME_MilkCycleComplete")
	UpdateAssScale()
	
	; Update SLIF Scaling at 1am
	float Time = Utility.GetCurrentGameTime()
	Time -= Math.Floor(Time) ; Remove "previous in-game days passed" bit
	Time *= 24	
	
	If Time < 14.0 ; Update scaling at 2:00pm
		RegisterForSingleUpdateGameTime(14.0 - Time)
		Debug.trace("_MA_: SLIF Scaling Updating in " + (14.0 - Time))
		;Debug.Notification("_MA_: SLIF Scaling Updating in " + (14.0 - Time))
	Else 
		Debug.trace("_MA_: SLIF Scaling Updating in " + (14.0 - Time + 24.0))
		;Debug.Notification("_MA_: SLIF Scaling Updating in " + (14.0 - Time + 24.0))
		RegisterForSingleUpdateGameTime(14.0 - Time + 24.0)
	EndIf
EndEvent

Event OnUpdateGameTime()
	RegisterForModEvent("MME_MilkCycleComplete", "OnMME_MilkCycleComplete") ; Run ass update after the next MME update cycle to ensure we have an accurate lactacid reading
EndEvent

Function UpdateAssScale()
	If MilkQ.MILKmaid.find(PlayerRef) > -1 ; Player is milkmaid
		Float CurrentLactacid = StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.LactacidCount")
		CurrentAssScale = Init.GetMaSlifAss()
		Float InflateAmount
		
		If CurrentLactacid < Menu.RequiredLactMild ; Decreasing
			InflateAmount = -(Menu.RequiredLactMild - CurrentLactacid) * Menu.AssLactMult * 10
		ElseIf CurrentLactacid >= Menu.RequiredLactMild && CurrentLactacid < Menu.RequiredLactModerate ; Static
			InflateAmount = 0.0
		Else ; Increasing
			InflateAmount = (CurrentLactacid - Menu.RequiredLactModerate) * Menu.AssLactMult * 5
		Endif
Float MaxAssScale
		If InflateAmount != 0.0
			If InflateAmount > 0.0 ; Increasing
				float MaidLevel = StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.Level")
				MaxAssScale = ((Menu.BaseAssScale as Int) + (Menu.AssMaxScale * ((MaidLevel + 1.0)/ 11.0)))
				If CurrentAssScale == MaxAssScale
					InflateAmount = 0.0
				ElseIf InflateAmount + CurrentAssScale > MaxAssScale
					InflateAmount = MaxAssScale - CurrentAssScale
				EndIf
			
			Else ; Decreasing
				If CurrentAssScale == (Menu.BaseAssScale as float)
					InflateAmount = 0.0
				ElseIf CurrentAssScale + InflateAmount < (Menu.BaseAssScale as float)
					InflateAmount = (Menu.BaseAssScale as float) ; Bottom out ;)
				EndIf
				
			EndIf
			;Debug.messagebox("CurrentAssScale: " + CurrentAssScale + ". InflateAmount: " + InflateAmount +  ". MaxAssScale: " + MaxAssScale)
			If InflateAmount != 0.0
				Init.InflateMaSlifAss(CurrentAssScale + InflateAmount)
				If InflateAmount > 0.0
					Debug.Notification("My ass feels a little heavier")
				Else
					Debug.Notification("My ass feels a little lighter")
				EndIf
			EndIf
			Debug.Trace("_MA_: SlifAss - Current: " + CurrentAssScale + ". InflateAmount: " + InflateAmount)
		EndIf
	Else
		Debug.Trace("_MA_: Slif Scaling - Player is not a maid")
	EndIf
EndFunction

Function StartSlifScaling()
	While (MQ101.GetCurrentStageID() < 240)
		Utility.Wait(30)
	EndWhile
	If Init.SlifInstalled && Menu.SlifScaling
		RegisterForSingleUpdateGameTime(0.01)
		Init.InflateMaSlifAss(CurrentAssScale)
		Debug.Trace("_MA_: Milk Addict: Scaling started")
	Else
		StopSlifScaling()
	EndIf
EndFunction

Function StopSlifScaling()
	If !Menu.SlifScaling
		Init.InflateMaSlifAss(Menu.BaseAssScale as float)
		Init.ResetMaSlif()
		UnregisterForUpdateGameTime()
		Debug.Trace("_MA_: Milk Addict: Scaling stopped")
	EndIf
EndFunction

Function ResetAss()
	CurrentAssScale = (Menu.BaseAssScale as float)
	Init.InflateMaSlifAss(CurrentAssScale)
EndFunction

Float CurrentAssScale

MilkQUEST Property MilkQ Auto 
_MA_Mcm Property Menu Auto
_MA_Init Property Init Auto

Actor Property PlayerRef Auto

Quest Property MQ101 Auto