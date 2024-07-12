;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ArenaFightFollower Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_StopMyFollowers()

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor Property SLV_Finn auto
ReferenceAlias Property SLV_Caesar auto

ObjectReference Property behindBars auto
SLV_MCMMenu Property MCMMenu Auto
Package Property SLV_DoNothing2 Auto


Function SLV_StopMyFollowers()
if !MCMMenu.arenafightAlone
	return
endif
if SLV_IsActorInSameLocCheck(SLV_Finn)
	SLV_Finn.moveto( SLV_Caesar.getActorRef())			
	ActorUtil.AddPackageOverride(SLV_Finn, SLV_DoNothing2 ,100)
	SLV_Finn.evaluatePackage()
	SLV_Finn.moveto( SLV_Caesar.getActorRef())	
endif

int i=0
if MCMMenu.followersCount > 0
	While (i < MCMMenu.followersCount)
		Actor follower = MCMMenu.Followers[i]
		debug.trace("Follower:" + follower.GetLeveledActorBase().getName())
		if SLV_IsActorInSameLocCheck(follower)
			ActorUtil.AddPackageOverride(follower, SLV_DoNothing2 ,100)
			follower.evaluatePackage()
			follower.moveto(SLV_Caesar.getActorRef() )	
		endif
		i = i + 1
	endWhile	
endif
EndFunction

Bool Function SLV_IsActorInSameLocCheck(Actor NPCActor)
if !NPCActor.getCurrentLocation() || !Game.GetPlayer().getCurrentLocation()
	return true
endif
if NPCActor.getCurrentLocation().IsSameLocation(Game.GetPlayer().getCurrentLocation())
	return true
endif
return false
EndFunction
