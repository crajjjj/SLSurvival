;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiterunTaskDremora1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Dremora1.getActorRef().enable()
Dremora2.getActorRef().enable()

GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property Dremora1 Auto 
ReferenceAlias Property Dremora2 Auto 