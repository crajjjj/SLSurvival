;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainEnslaveFree2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_You.GetActorRef().moveto(Game.getPlayer())

ActorUtil.ClearPackageOverride(SLV_Mundus.getactorref())
SLV_Mundus.GetActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Mundus.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Mundus.GetActorRef().evaluatePackage()

SLV_Hardmode.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Mundus Auto 
ReferenceAlias Property SLV_You Auto 

Package Property SLV_FollowPlayer Auto
GlobalVariable Property SLV_Hardmode Auto
