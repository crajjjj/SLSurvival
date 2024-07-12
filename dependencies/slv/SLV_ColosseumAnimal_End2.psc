;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumAnimal_End2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_AnimalMainQuest.Reset() 
SLV_AnimalMainQuest.Start() 
SLV_AnimalMainQuest.SetStage(0)
SLV_AnimalMainQuest.SetActive(true)

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
Quest Property SLV_AnimalMainQuest Auto
Quest Property SLV_ColosseumMainQuest Auto

Quest Property SLV_ColosseumSubquest1 Auto
Quest Property SLV_ColosseumSubquest2 Auto
Quest Property SLV_ColosseumSubquest3 Auto

