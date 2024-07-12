;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial5_18b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(8500)
GetOwningQuest().SetStage(9000)

SexTourist1b.getactorref().enable()

SexTourist2a.getactorref().moveto(SexTourist1a.getactorref())
ActorUtil.ClearPackageOverride(SexTourist2a.getactorref())
SexTourist2a.getactorref().evaluatePackage()
SexTourist2b.getactorref().moveto(SexTourist1a.getactorref())
ActorUtil.ClearPackageOverride(SexTourist2b.getactorref())
SexTourist2b.getactorref().evaluatePackage()

SexTourist3a.getactorref().moveto(SexTourist1a.getactorref())
ActorUtil.ClearPackageOverride(SexTourist3a.getactorref())
SexTourist3a.getactorref().evaluatePackage()
SexTourist3b.getactorref().moveto(SexTourist1a.getactorref())
ActorUtil.ClearPackageOverride(SexTourist3b.getactorref())
SexTourist3b.getactorref().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SexTourist1a Auto 
ReferenceAlias Property SexTourist1b Auto 
ReferenceAlias Property SexTourist2a Auto 
ReferenceAlias Property SexTourist2b Auto 
ReferenceAlias Property SexTourist3a Auto 
ReferenceAlias Property SexTourist3b Auto 

