;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WalkOfShame2_End Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_EnforcerIgnorePC.setValue(0)

SLV_Horse1.getActorRef().disable()
SLV_Horse2.getActorRef().disable()

ActorUtil.ClearPackageOverride(SLV_Bellamy.GetActorRef())
SLV_Bellamy.GetActorRef().evaluatePackage()
ActorUtil.ClearPackageOverride(SLV_Murphy.GetActorRef())
SLV_Murphy.GetActorRef().evaluatePackage()

GetOwningQuest().SetObjectiveCompleted(9500)
GetOwningQuest().SetStage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_EnforcerIgnorePC  Auto  
ReferenceAlias Property SLV_Murphy Auto
ReferenceAlias Property SLV_Bellamy Auto

ReferenceAlias Property SLV_Horse1 Auto
ReferenceAlias Property SLV_Horse2 Auto


