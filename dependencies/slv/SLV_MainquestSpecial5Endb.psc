;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial5Endb Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_quest.SetObjectiveCompleted(4250)
SLV_quest.SetStage(4300)

SexTourist1a.getActorRef().disable()
SexTourist1b.getActorRef().disable()
SexTourist2a.getActorRef().disable()
SexTourist2b.getActorRef().disable()
SexTourist3a.getActorRef().disable()
SexTourist3b.getActorRef().disable()

myUtilities.SLV_miniLevelUp()

GetOwningQuest().SetObjectiveCompleted(9000)
GetOwningQuest().SetStage(9500)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myUtilities auto
Quest Property SLV_quest Auto

ReferenceAlias Property SexTourist1a Auto 
ReferenceAlias Property SexTourist1b Auto 
ReferenceAlias Property SexTourist2a Auto 
ReferenceAlias Property SexTourist2b Auto 
ReferenceAlias Property SexTourist3a Auto 
ReferenceAlias Property SexTourist3b Auto 
