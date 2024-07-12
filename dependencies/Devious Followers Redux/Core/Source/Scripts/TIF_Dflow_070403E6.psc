;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF_Dflow_070403E6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(tool as _DFtools).ReduceResist(4)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if _DflowDealMulti.getvalue() < 1
_DflowDealMulti.setvalue(1)
endif

Int roll = Utility.RandomInt(1,3)
Float time = 0
If roll == 1
time = _DflowDealOPTimer.Getvalue()
elseif roll == 2
time = _DflowDealHPTimer.Getvalue()
elseif roll == 3
time = _DflowDealBPTimer.Getvalue()
endif 


if (time <=  GameDaysPassed.GetValue())
time = GameDaysPassed.GetValue() + _DflowDealBaseDays.GetValue()  + _DflowDealBaseDays.GetValue() 
Else
time =time + _DflowDealBaseDays.GetValue()  + _DflowDealBaseDays.GetValue() 
endif

Float temp = GameDaysPassed.GetValue() + 7
if temp > time
time = temp
endif

If roll == 1
_DflowDealOPTimer.Setvalue(time)
elseif roll == 2
_DflowDealHPTimer.Setvalue(time)
elseif roll == 3
_DflowDealBPTimer.Setvalue(time)
endif 

q.DealDebt()
q.DealDebt()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property _DflowDealOPTimer Auto
GlobalVariable Property _DflowDealHPTimer Auto
GlobalVariable Property _DflowDealBPTimer Auto
GlobalVariable Property _DflowDealMulti Auto
GlobalVariable Property _DflowDealBaseDays Auto 
GlobalVariable Property _DflowDealBaseDebt Auto  
GlobalVariable Property GameDaysPassed Auto

QF__Gift_09000D62 Property q Auto
Quest Property tool Auto
