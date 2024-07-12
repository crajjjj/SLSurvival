;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveCertification2_End Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ActorUtil.RemoveAllPackageOverride(SLV_DragonsreachCenter)
;ActorUtil.RemoveAllPackageOverride(SLV_FollowPlayer)

SLV_Ivana.getActorRef().removeItem(SLV_Whip)
SLV_Diamond.getActorRef().removeItem(SLV_Whip)

if SLV_Main.getStage() == 6550
	SLV_Main.SetObjectiveCompleted(6550)
	SLV_Main.SetStage(6600)
endif

GetOwningQuest().SetObjectiveCompleted(9500)

if SLV_Main.getStage() < 7250
	getowningquest().setstage(10000)
else	
	getowningquest().setstage(9800)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_Main Auto
ReferenceAlias Property SLV_Ivana Auto 
Package Property SLV_DragonsreachCenter auto
Package Property SLV_FollowPlayer auto
ReferenceAlias Property SLV_Diamond Auto
Weapon Property SLV_Whip Auto
