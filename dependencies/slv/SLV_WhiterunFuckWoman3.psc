;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiterunFuckWoman3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_Play2Sex(akSpeaker , Game.GetPlayer(), "Anal", true)

if GetOwningQuest().ModObjectiveGlobal(1,SLV_WhiterunFuckWoman, 0, SLV_MaxTask.getValue() as int)
  	GetOwningQuest().SetObjectiveCompleted(0)
  	GetOwningQuest().SetStage(500)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
GlobalVariable Property SLV_WhiterunFuckWoman  Auto  
GlobalVariable Property SLV_MaxTask  Auto  
