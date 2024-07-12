Scriptname SLV_ColosseumArenaLever extends ObjectReference Conditional

import debug
import utility

bool property isInPullPosition = True Auto

EVENT OnLoad()
	SetDefaultState()
endEVENT

Event OnReset()
	SetDefaultState()
EndEvent

;This has to be handled as a function, since OnLoad and OnReset can fire in either order, and we can't handle competing animation calls.
Function SetDefaultState()
	if (isInPullPosition)
		gotoState("pulledPosition")
	Else
		gotoState("pushedPosition")
	EndIf
EndFunction


Auto STATE pulledPosition
	EVENT onActivate (objectReference triggerRef)
		gotoState ("busy")
		isInPullPosition = False
		gotoState("pushedPosition")

		myScripts.SLV_DisplayInformation("Lever was pulled")
		SLV_TriggerLever()
	endEVENT
endState

STATE pushedPosition
	EVENT onActivate (objectReference triggerRef)
		gotoState ("busy")
		isInPullPosition = True
		gotoState("pulledPosition")

		myScripts.SLV_DisplayInformation("Lever was pushed")
		SLV_TriggerLever()
	endEVENT
endState

STATE busy
	; This is the state when I'm busy animating
		EVENT onActivate (objectReference triggerRef)
			;do nothing
		endEVENT
endSTATE

Quest Property SLV_ColosseumArenaquest Auto
Quest Property SLV_ArenaShowquest Auto
Quest Property SLV_ArenaFightquest Auto
Scene Property PunishScene  Auto

Scene Property ArenaShowScene  Auto
Scene Property ArenaFightScene  Auto

Actor Property SLV_Finn auto
SLV_MCMMenu Property MCMMenu Auto
Package Property SLV_DoNothing2 Auto
SLV_Utilities Property myScripts auto
Actor Property PlayerRef auto


Function SLV_TriggerLever()
myScripts.SLV_ForceToCrawl(PlayerRef , false)
if SLV_ColosseumArenaquest.getStage() == 5000
	SLV_ColosseumArenaquest.SetObjectiveCompleted(5000)
	SLV_ColosseumArenaquest.SetStage(5500)

	myScripts.SLV_PlayScene(PunishScene)
elseif SLV_ArenaShowquest.getStage() == 1000
	SLV_ArenaShowquest.SetObjectiveCompleted(1000)
	SLV_ArenaShowquest.SetStage(1500)
	SLV_StopMyFollowers()

	myScripts.SLV_PlayScene(ArenaShowScene)
elseif SLV_ArenaFightquest.getStage() == 1000
	SLV_ArenaFightquest.SetObjectiveCompleted(1000)
	SLV_ArenaFightquest.SetStage(1500)
	SLV_StopMyFollowers()

	myScripts.SLV_PlayScene(ArenaFightScene)
endif

EndFunction


Function SLV_StopMyFollowers()
if !MCMMenu.arenafightAlone
	return
endif
if SLV_IsActorInSameLocCheck(SLV_Finn)
	;SLV_Finn.moveto(behindBars )			
	ActorUtil.AddPackageOverride(SLV_Finn, SLV_DoNothing2 ,100)
	SLV_Finn.evaluatePackage()
endif

int i=0
if MCMMenu.followersCount > 0
	While (i < MCMMenu.followersCount)
		Actor follower = MCMMenu.Followers[i]
		debug.trace("Follower:" + follower.GetLeveledActorBase().getName())
		if SLV_IsActorInSameLocCheck(follower)
			ActorUtil.AddPackageOverride(follower, SLV_DoNothing2 ,100)
			follower.evaluatePackage()
			;follower.moveto(behindBars )	
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