;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Mainquest2_20 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(250)
GetOwningQuest().SetStage(280)

ActorUtil.ClearPackageOverride( SLV_JarlMorthal1.getActorRef())
SLV_JarlMorthal1.getActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride( SLV_Elenwen.getActorRef())
SLV_Elenwen.getActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride( SLV_Maven.getActorRef())
SLV_Maven.getActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride( SLV_Delphine.getActorRef())
SLV_Delphine.getActorRef().evaluatePackage()

starttime.StartMainquest2Timer()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Mainquest2Timer Property starttime Auto

ReferenceAlias Property SLV_JarlMorthal1 Auto
ReferenceAlias Property SLV_Elenwen Auto
ReferenceAlias Property SLV_Maven Auto
ReferenceAlias Property SLV_Delphine Auto
ReferenceAlias Property SLV_LadyMaraPriestess Auto



