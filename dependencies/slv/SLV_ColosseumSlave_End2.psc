;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumSlave_End2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_Play2Sex(SLV_Michelangela.GetActorRef(),akSpeaker,"Anal, Sex", true)

SLV_GladiatorMainQuest.Reset() 
SLV_GladiatorMainQuest.Start() 
SLV_GladiatorMainQuest.SetStage(0)
SLV_GladiatorMainQuest.SetActive(true)

if SLV_ColosseumSubquest1.isCompleted() && SLV_ColosseumSubquest2.isCompleted() && SLV_ColosseumSubquest3.isCompleted()
	SLV_ColosseumMainQuest.SetObjectiveCompleted(7000)
	SLV_ColosseumMainQuest.SetStage(7500)
endif

GetOwningQuest().SetObjectiveCompleted(9500)
GetOwningQuest().SetStage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_ColosseumMainQuest Auto
Quest Property SLV_GladiatorMainQuest Auto
ReferenceAlias Property SLV_Michelangela Auto

Quest Property SLV_ColosseumSubquest1 Auto
Quest Property SLV_ColosseumSubquest2 Auto
Quest Property SLV_ColosseumSubquest3 Auto

