;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_DawnstarMining27 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if GetOwningQuest().ModObjectiveGlobal(4, SLV_DawnstarMiningCount2  , 2000, 20)
  	GetOwningQuest().SetObjectiveCompleted(2000)
  	GetOwningQuest().SetStage(2500)
endif

myScripts.SLV_Play2Sex(MCMMenu.slavefollower,akSpeaker, "", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_MCMMenu Property MCMMenu auto
GlobalVariable Property SLV_DawnstarMiningCount2  Auto 
 