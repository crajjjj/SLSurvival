;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial5_9b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4000)
GetOwningQuest().SetStage(4500)

Utility.wait(5)

SexTourist1a.getactorref().enable()
SexTourist1b.getactorref().enable()
SexTourist2a.getactorref().enable()
SexTourist2b.getactorref().enable()

SexTourist2a.getactorref().moveto(SexTourist1a.getactorref())
ActorUtil.ClearPackageOverride(SexTourist2a.getactorref())
SexTourist2a.getactorref().evaluatePackage()
SexTourist2b.getactorref().moveto(SexTourist1a.getactorref())
ActorUtil.ClearPackageOverride(SexTourist2b.getactorref())
SexTourist2b.getactorref().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SexTourist1a Auto 
ReferenceAlias Property SexTourist1b Auto 
ReferenceAlias Property SexTourist2a Auto 
ReferenceAlias Property SexTourist2b Auto 
