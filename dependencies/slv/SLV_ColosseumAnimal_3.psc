;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumAnimal_3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1000)
GetOwningQuest().SetStage(1500)

myDoor.lock(false)
if  SLV_ColosseumArenaQuest.getstage() > 1000
	myDoor2.lock(false)
endif
Utility.wait(2.0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ObjectReference Property myDoor Auto

ObjectReference Property myDoor2 Auto
Quest Property SLV_ColosseumArenaQuest Auto
