;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_FalkreathSlavery4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if GetOwningQuest().ModObjectiveGlobal(1, SLV_FalkreathGuardCount  , 1000, SLV_MaxTask.getValue() as int)
  GetOwningQuest().SetStage(1500)
endif

actor[] sexActors = new actor[1]
sexActors[0] = akSpeaker 

myScripts.SLV_PlaySex(sexActors,"", false)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_FalkreathGuardCount  Auto  
GlobalVariable Property SLV_MaxTask  Auto  
