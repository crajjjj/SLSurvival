;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ArenaFight_Bones1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;SLV_Bones.getActorRef().enable()
SLV_Bones.getActorRef().moveto(arenaEnter )

ActorUtil.AddPackageOverride(SLV_Bones.getActorRef(), SLV_DoNothing ,100)
SLV_Bones.getActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_DoNothing Auto
ObjectReference Property arenaEnter auto

ReferenceAlias Property SLV_Bones Auto

