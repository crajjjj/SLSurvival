;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeFreedom_11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

if GetOwningQuest().ModObjectiveGlobal(1,SLV_SolitudeSoldierCount, 4500, 5 as int)
  	GetOwningQuest().SetObjectiveCompleted(4500)
  	GetOwningQuest().SetStage(5000)

	SLV_GeneralSolitude1.GetActorRef().moveto(leaderBedroom )

	ActorUtil.AddPackageOverride(SLV_GeneralSolitude1.GetActorRef(), SLV_DoNothing ,100)
	SLV_GeneralSolitude1.GetActorRef().evaluatePackage()

	SLV_GeneralSolitude1.GetActorRef().moveto(leaderBedroom )
endif

akSpeaker.removefromFaction(zbfFactionSlave)
debug.SendAnimationEvent(akSpeaker, "IdleForceDefaultState")

if akSpeaker == SLV_Slave1.GetActorRef()
	SLV_Slaver1.enable()
	ActorUtil.AddPackageOverride(SLV_Slaver1, SLV_FollowPlayer ,100)
	SLV_Slaver1.evaluatePackage()
	SLV_Slaver1.startCombat(Game.getplayer())
elseif akSpeaker == SLV_Slave2.GetActorRef()
	SLV_Slaver2.enable()
	ActorUtil.AddPackageOverride(SLV_Slaver2, SLV_FollowPlayer ,100)
	SLV_Slaver2.evaluatePackage()

	SLV_Slaver2.startCombat(Game.getplayer())
elseif akSpeaker == SLV_Slave3.GetActorRef()
	SLV_Slaver3.enable()
	ActorUtil.AddPackageOverride(SLV_Slaver3, SLV_FollowPlayer ,100)
	SLV_Slaver3.evaluatePackage()

	SLV_Slaver3.startCombat(Game.getplayer())
elseif akSpeaker == SLV_Slave4.GetActorRef()
	SLV_Slaver4.enable()
	ActorUtil.AddPackageOverride(SLV_Slaver4, SLV_FollowPlayer ,100)
	SLV_Slaver4.evaluatePackage()

	SLV_Slaver4.startCombat(Game.getplayer())
elseif akSpeaker == SLV_Slave5.GetActorRef()
	SLV_Slaver5.enable()
	ActorUtil.AddPackageOverride(SLV_Slaver5, SLV_FollowPlayer ,100)
	SLV_Slaver5.evaluatePackage()

	SLV_Slaver5.startCombat(Game.getplayer())
endif

ActorUtil.AddPackageOverride(akspeaker, SLV_SolitudeCastleDourWalk ,100)
akSpeaker.evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_DoNothing Auto
Package Property SLV_FollowPlayer Auto
Package Property SLV_SolitudeCastleDourWalk Auto

ObjectReference Property leaderBedroom auto

ReferenceAlias Property SLV_Slave1 Auto
ReferenceAlias Property SLV_Slave2 Auto
ReferenceAlias Property SLV_Slave3 Auto
ReferenceAlias Property SLV_Slave4 Auto
ReferenceAlias Property SLV_Slave5 Auto
Actor Property SLV_Slaver1 Auto
Actor Property SLV_Slaver2 Auto
Actor Property SLV_Slaver3 Auto
Actor Property SLV_Slaver4 Auto
Actor Property SLV_Slaver5 Auto

ReferenceAlias Property SLV_GeneralSolitude1 Auto
GlobalVariable Property SLV_SolitudeSoldierCount Auto 

Faction Property zbfFactionSlave Auto

