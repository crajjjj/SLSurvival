Scriptname _DFlowHumliation extends Quest  Conditional

_DFTools property Tool Auto
Bool property Active Auto
Float Property Multi Auto
Float Property Timer Auto
Float Property NotiPer Auto
Float StoredTime = 0.0

Int Property BoundHands = 0 Auto Conditional

Function Use(String Loc = "")

Debug.Notification(Loc + "LocW")
if !Active
	return
endif

if StoredTime < Tool.GameDaysPassed.GetValue()
	StoredTime = Tool.GameDaysPassed.GetValue() + Timer
else
	Return
endif

Float Hum = 0.0 
 
If Tool.DB.GetStage() >= 3
	Hum += 1
endif
if tool.DO.GetStage() >= 3
	Hum += 1
endif
if tool.DH.GetStage() >= 3
	Hum += 1
endif
if tool.DP.GetStage() >= 3
	Hum += 1
endif
if tool.DS.GetStage() >= 3
	Hum += 1
endif
if tool.DM1.GetStage() >= 3
	Hum += 1
endif
if tool.DM2.GetStage() >= 3
	Hum += 1
endif
if tool.DM3.GetStage() >= 3
	Hum += 1
endif
if tool.DM4.GetStage() >= 3
	Hum += 1
endif
if tool.DM5.GetStage() >= 3
	Hum += 1
endif

Int NumOfT3 = Hum as Int
Hum = Hum*Multi 
Tool.ReduceResist(Hum as Int)

If Utility.RandomFloat(0,1) < NotiPer
	Int Roll = Utility.RandomInt(1,NumOfT3)

	if tool.DB.GetStage() >= 3 
		Roll -= 1
		If Roll == 0
			If Tool.DB.GetStage()==3
				Debug.Notification("$DFDEAL_B1_HUM")
			elseif (Loc == "LocD")
				Debug.Notification("$DFDEAL_B2_HUM")
			endif
		endif
	endif
	if tool.DO.GetStage() >= 3 
		Roll -= 1
		If Roll == 0
			If Tool.DO.GetStage()==3 && Loc == "LocD"
				Debug.Notification("$DFDEAL_O1_HUM")
			elseif Tool.DO.GetStage()==4
				Debug.Notification("$DFDEAL_O2_HUM")
			endif
		endif
	endif
	if tool.DH.GetStage() >= 3
		Roll -= 1
		If Roll == 0
			Debug.Notification(Roll)
			If Tool.DH.GetStage()==3 && Loc == "LocT"
				Debug.Notification("$DFDEAL_H1_HUM")
			elseif Tool.DH.GetStage()==4 && Loc == "LocW"
				Debug.Notification("$DFDEAL_H2_HUM")
			endif
		endif
	endif
	if tool.DP.GetStage() >= 3 
		Roll -= 1
		If Roll == 0
			iF Loc == "LocT"
				Debug.Notification("$DFDEAL_P_HUM")
			Endif
		endif
	endif
	if tool.DS.GetStage() >= 3
		Roll -= 1		
		If Roll == 0
			iF Loc == "LocW"
				Debug.Notification("$DFDEAL_S_HUM")
			endif
		endif
	endif
	if tool.DM1.GetStage() >= 3
		Roll -= 1		
		If Roll == 0
			tool.DM1.HumNoti()
		endif
	endif
	if tool.DM2.GetStage() >= 3
		Roll -= 1		
		If Roll == 0
			tool.DM2.HumNoti()
		endif
	endif
	if tool.DM3.GetStage() >= 3
		Roll -= 1		
		If Roll == 0
			tool.DM3.HumNoti()
		endif
	endif
	if tool.DM4.GetStage() >= 3
		Roll -= 1		
		If Roll == 0
			tool.DM4.HumNoti()
		endif
	endif
	if tool.DM5.GetStage() >= 3
		Roll -= 1		
		If Roll == 0
			tool.DM5.HumNoti()
		endif
	endif
	
Endif

endfunction

Function TriggerALL()
	Tool.DO.DC.AddRandomDeal()
	Tool.DO.DC.AddRandomDeal()
	Tool.DO.DC.AddRandomDeal()
	Tool.DO.DC.AddRandomDeal()
	Tool.DO.DC.AddRandomDeal()
	Tool.DO.DC.AddRandomDeal()
	Tool.DO.DC.AddRandomDeal()
	Tool.DO.DC.AddRandomDeal()
	Tool.DO.DC.AddRandomDeal()
	Tool.DO.DC.AddRandomDeal()
	Tool.DO.DC.AddRandomDeal()
	Tool.DO.DC.AddRandomDeal()
	Tool.DO.DC.AddRandomDeal()
	Tool.DO.DC.AddRandomDeal()
	Tool.DO.DC.AddRandomDeal()
	Tool.DO.DC.AddRandomDeal()

	Tool.DB.Triggered = True
	Tool.DP.Triggered = True
	Tool.DO.Triggered = True
	Tool.DS.Triggered = True
	Tool.DH.Triggered = True
	Tool.DM1.Triggered = True
	Tool.DM2.Triggered = True
	Tool.DM3.Triggered = True
	Tool.DM4.Triggered = True
	Tool.DM5.Triggered = True
endfunction
