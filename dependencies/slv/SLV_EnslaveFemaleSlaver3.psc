;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_EnslaveFemaleSlaver3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_You.GetActorRef().moveto(Game.getPlayer())
myScripts.SLV_StripBothHands(Game.getPlayer())

ActorUtil.ClearPackageOverride(SLV_Zaid.getactorref())
SLV_Zaid.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Zaid.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Zaid.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Eric.getactorref())
SLV_Eric.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Eric.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Eric.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Brutus.getactorref())
SLV_Brutus.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Brutus.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Brutus.GetActorRef().evaluatePackage()
SLV_Brutus.getactorref().moveto(OutsideDragonsreach )

ActorUtil.ClearPackageOverride(SLV_Sven.getactorref())
SLV_Sven.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Sven.GetActorRef(), SLV_FollowPlayer ,100)
SLV_Sven.GetActorRef().evaluatePackage()
SLV_Sven.getactorref().moveto(OutsideDragonsreach )

SLV_Hardmode.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Zaid Auto 
ReferenceAlias Property SLV_Brutus Auto 
ReferenceAlias Property SLV_Sven Auto 
ReferenceAlias Property SLV_Eric Auto 
ReferenceAlias Property SLV_You Auto 

Package Property SLV_FollowPlayer Auto
GlobalVariable Property SLV_Hardmode Auto
ObjectReference Property OutsideDragonsreach Auto
