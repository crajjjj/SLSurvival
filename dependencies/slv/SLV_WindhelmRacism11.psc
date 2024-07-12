;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WindhelmRacism11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if GetOwningQuest().ModObjectiveGlobal(1, SLV_WindhelmDunmer, 1000, SLV_MaxTask.getValue() as int)
  	GetOwningQuest().SetObjectiveCompleted(1000)
  	GetOwningQuest().SetStage(1500)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_WindhelmDunmer  Auto   
GlobalVariable Property SLV_MaxTask  Auto  

