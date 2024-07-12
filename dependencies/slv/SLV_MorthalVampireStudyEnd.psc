;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MorthalVampireStudyEnd Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
morthalmain.SetObjectiveCompleted(1500)
morthalmain.setStage(2000)

Undead1.disable()
Undead2.disable()
Undead3.disable()

GetOwningQuest().SetObjectiveCompleted(5000)
GetOwningQuest().SetStage(5500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor Property Undead1 Auto
Actor Property Undead2 Auto
Actor Property Undead3 Auto
Quest Property morthalmain Auto

