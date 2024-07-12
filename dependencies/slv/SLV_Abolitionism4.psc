;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Abolitionism4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if GetOwningQuest().ModObjectiveGlobal(1, SLV_ThalmorSex , 3500, SLV_MaxTask.getValue() as int)
  	GetOwningQuest().SetObjectiveCompleted(3500)
  	GetOwningQuest().SetStage(4000)
endif

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Cowgirl", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
GlobalVariable Property SLV_ThalmorSex  Auto  
GlobalVariable Property SLV_MaxTask  Auto  

