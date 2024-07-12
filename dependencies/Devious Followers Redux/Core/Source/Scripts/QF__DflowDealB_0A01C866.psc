;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname QF__DflowDealB_0A01C866 Extends Quest Hidden

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN AUTOCAST TYPE _DF_BondageDeal
Quest __temp = self as Quest
_DF_BondageDeal kmyQuest = __temp as _DF_BondageDeal
;END AUTOCAST
;BEGIN CODE
KmyQuest.addgag()
KmyQuest.Delayhr()
KmyQuest.Triggered = False
Float Temp = 0
if (_DflowDealBPTimer.getValue() <=  GameDaysPassed.GetValue())
temp = GameDaysPassed.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealBPTimer.SetValue(temp)
Else
temp =_DflowDealBPTimer.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealBPTimer.SetValue(temp)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
KmyQuest.DelayForever()
KmyQuest.Triggered = False
Float Temp = 0
if (_DflowDealBPTimer.getValue() <=  GameDaysPassed.GetValue())
temp = GameDaysPassed.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealBPTimer.SetValue(temp)
Else
temp =_DflowDealBPTimer.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealBPTimer.SetValue(temp)
endif
libs.equipDevice(libs.PlayerRef, kmyQuest.Item1 ,kmyQuest.Item1R, libs.zad_DeviousGag, skipevents = false, skipmutex = true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
kmyQuest.Stage0()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE _DDeal
Quest __temp = self as Quest
_DDeal kmyQuest = __temp as _DDeal
;END AUTOCAST
;BEGIN CODE
KmyQuest.addbootsandhands()
Float temp = 0
if (_DflowDealBPTimer.getValue() <=  GameDaysPassed.GetValue())
temp = GameDaysPassed.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealBPTimer.SetValue(temp)
Else
temp =_DflowDealBPTimer.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealBPTimer.SetValue(temp)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
KmyQuest.addcorset()
Float temp = GameDaysPassed.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealBPTimer.SetValue(temp)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Function Cleaning()
Int Choice = 0 

Bool Resist = False
	if TimesDone < 3
	Choice = _DFlowDealBCleaning1.Show()
	
		If Choice == 0
			Choice = _DFlowDealBCleaning2.Show()
			If Choice == 0
				_DFlowDealBCleaning3.Show()
				DDeal.Triggered = True
				TimesDone +=1
			Else
				_DFlowDealBCleaning2Resist.Show()
				Resist = True
			endif
		else 
			_DFlowDealBCleaning1Resist.Show()
			Resist = True
		endif
	else 
		_DFlowDealBCleaning4.Show()
	endif
	
	
	If Resist
		DDeal.DelayReset()
		DDeal.DelayHrs(2.0)
			q.PunDebt()
	Else
		libs.equipDevice(libs.PlayerRef, DDeal.Item1 ,DDeal.Item1R, libs.zad_DeviousGag, skipevents = false, skipmutex = true)
	
	endif
	

EndFunction

Int Property TimesDone = 0 Auto 
Message Property _DFlowDealBCleaning1 Auto
Message Property _DFlowDealBCleaning2 Auto
Message Property _DFlowDealBCleaning3 Auto
Message Property _DFlowDealBCleaning4 Auto
Message Property _DFlowDealBCleaning1Resist Auto
Message Property _DFlowDealBCleaning2Resist Auto
_DDeal Property DDeal Auto
GlobalVariable Property GameDaysPassed auto
GlobalVariable Property _DflowDealBPTimer auto
GlobalVariable Property _DflowDealBaseDays auto
QF__Gift_09000D62 Property q auto



zadlibs Property libs  Auto  
