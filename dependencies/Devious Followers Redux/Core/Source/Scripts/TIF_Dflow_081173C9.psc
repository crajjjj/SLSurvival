;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF_Dflow_081173C9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int NewDebt = (GetowningQuest() as QF__Gift_09000D62).EnslavementDebt.GetValueInt() 
NewDebt -= 100
(GetowningQuest() as QF__Gift_09000D62).SetDebt(NewDebt)
(GetowningQuest() as QF__Gift_09000D62).tool.reduceResist(18)
GoldCont.Setstage(1)

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property GoldCont auto