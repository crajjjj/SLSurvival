Scriptname SLV_ArenaUtilities extends Quest  

Function fillGladiatorAlias()
if SLV_Fighter1
	if !SLV_Fighter1.getActorRef().IsDead()
		SLV_Gladiator.forceRefTo(SLV_Fighter1.getActorRef())
		return
	endif
endif
if SLV_Fighter2
	if !SLV_Fighter2.getActorRef().IsDead()
		SLV_Gladiator.forceRefTo(SLV_Fighter2.getActorRef())
		return
	endif
endif
if SLV_Fighter3
	if !SLV_Fighter3.getActorRef().IsDead()
		SLV_Gladiator.forceRefTo(SLV_Fighter3.getActorRef())
		return
	endif
endif
if SLV_Fighter4
	if !SLV_Fighter4.getActorRef().IsDead()
		SLV_Gladiator.forceRefTo(SLV_Fighter4.getActorRef())
		return
	endif
endif
endfunction
ReferenceAlias Property SLV_Fighter1 Auto
ReferenceAlias Property SLV_Fighter2 Auto
ReferenceAlias Property SLV_Fighter3 Auto
ReferenceAlias Property SLV_Fighter4 Auto
ReferenceAlias Property SLV_Gladiator Auto


function clearFighter(Actor fighterActor)
if fighterActor == none
	return
endif

if fighterActor.isDead()
	fighterActor.resurrect()
endif

ActorUtil.ClearPackageOverride(fighterActor)
fighterActor.evaluatePackage()

debug.SendAnimationEvent(fighterActor, "IdleForceDefaultState")
fighterActor.getActorBase().SetEssential(false)
endfunction




Actor Property SLV_Finn auto
ReferenceAlias Property SLV_Caesar auto

ObjectReference Property behindBars auto
SLV_MCMMenu Property MCMMenu Auto
Package Property SLV_DoNothing2 Auto


Function SLV_StopMyFollowers(Bool hideFollowers)
if !MCMMenu.arenafightAlone
	return
endif
if SLV_IsActorInSameLocCheck(SLV_Finn)
	SLV_Finn.moveto( SLV_Caesar.getActorRef())			
	ActorUtil.AddPackageOverride(SLV_Finn, SLV_DoNothing2 ,100)
	SLV_Finn.evaluatePackage()

	if hideFollowers
		SLV_Finn.moveto( SLV_Caesar.getActorRef())
	else	
		SLV_Finn.moveto( behindBars )
	endif
endif

int i=0
if MCMMenu.followersCount > 0
	While (i < MCMMenu.followersCount)
		Actor follower = MCMMenu.Followers[i]
		debug.trace("Follower:" + follower.GetLeveledActorBase().getName())
		if SLV_IsActorInSameLocCheck(follower)
			ActorUtil.AddPackageOverride(follower, SLV_DoNothing2 ,100)
			follower.evaluatePackage()
			
			if hideFollowers
				follower.moveto(SLV_Caesar.getActorRef() )	
			else
				follower.moveto(behindBars  )	
			endif
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

