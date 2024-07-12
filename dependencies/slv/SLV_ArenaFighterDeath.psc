Scriptname SLV_ArenaFighterDeath extends ReferenceAlias  

event OnDeath(Actor akKiller)
myScripts.SLV_DisplayInformation("You killed an opponent!")

if SLV_ArenaFightQuest.getStage() == 1500 && allFighterDead()
	SLV_ArenaFightQuest.SetObjectiveCompleted(1500)
	SLV_ArenaFightQuest.SetStage(2000)

	;ActorUtil.RemoveAllPackageOverride(SLV_DoNothing2)
	EndFight()
EndIf
EndEvent

;Event OnActivate(ObjectReference akActionRef)
;	Debug.notification("You are not allowed to loot in the arena")
;EndEvent



Event OnEnterBleedout()
Actor actorNPC = getActorRef()
myScripts.SLV_DisplayInformation(" Entering NPC bleedout")

HandleNCPDeath(actorNPC )
EndEvent


Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
Actor actorNPC =getActorRef()
myScripts.SLV_DisplayInformation("NPC was hit by " + akAggressor + " NPC HP : " + actorNPC.getActorValue("Health"))

If actorNPC.getActorValue("Health") < 1
	HandleNCPDeath(actorNPC )
EndIf
EndEvent

Function HandleNCPDeath(Actor actorNPC)
if actorNPC.IsInFaction(SLV_ColosseumNPCLost)
	myScripts.SLV_DisplayInformation(actorNPC.getActorBase().getname() + " was already defeated")
	return
endif

myScripts.SLV_DisplayUser(actorNPC.getActorBase().getname() + " has been defeated")
actorNPC.addtofaction(SLV_ColosseumNPCLost)

myScripts.SLV_DisplayInformation("HandleNPCDeath, PC HP : " + actorNPC.getActorValue("Health"))
int fightmode = SLV_ColosseumFightMode.getValue() as int

knockOutEssentialNPC(actorNPC)
	
;if (fightmode == 2 || fightmode == 3) 
	if SLV_ArenaFightQuest.getStage() == 1500 && allFighterLost()
		SLV_ArenaFightQuest.SetObjectiveCompleted(1500)
		SLV_ArenaFightQuest.SetStage(2000)
		
		EndFight()
	endif
;else
;	myScripts.SLV_DisplayInformation("This should not happen for fightmode : " + fightmode)
;EndIf
EndFunction

Function EndFight()
PlayerRef.StopCombat()
PlayerRef.StopCombatAlarm()

Utility.Wait(3)
arena.fillGladiatorAlias()

ActorUtil.RemoveAllPackageOverride(SLV_DoNothing2)
ActorUtil.RemoveAllPackageOverride(SLV_ColosseumGladiatorHasLost )

myScripts.SLV_PlayScene(SLV_ArenaFightWinningScene)
EndFunction
SLV_Utilities Property myScripts auto
SLV_MCMMenu Property MCMMenu Auto
SLV_ArenaUtilities Property arena Auto
Quest Property SLV_ArenaFightQuest Auto
Package Property SLV_DoNothing2 auto
Package Property SLV_ColosseumGladiatorHasLost auto

Actor Property PlayerRef Auto
ReferenceAlias Property SLV_Fighter1 Auto
ReferenceAlias Property SLV_Fighter2 Auto
ReferenceAlias Property SLV_Fighter3 Auto
ReferenceAlias Property SLV_Fighter4 Auto
GlobalVariable Property SLV_ColosseumFightMode Auto
Faction Property SLV_ColosseumNPCLost Auto
Scene Property SLV_ArenaFightWinningScene Auto

bool function allFighterDead()
if aFighterIsNotDead(SLV_Fighter1)
	myScripts.SLV_DisplayInformation("Fighter1 still fighting")
	return false
endif
if aFighterIsNotDead(SLV_Fighter2)
	myScripts.SLV_DisplayInformation("Fighter2 still fighting")
	return false
endif
if aFighterIsNotDead(SLV_Fighter3)
	myScripts.SLV_DisplayInformation("Fighter3 still fighting")
	return false
endif
if aFighterIsNotDead(SLV_Fighter4)
	myScripts.SLV_DisplayInformation("Fighter4 still fighting")
	return false
endif
return true
endfunction

bool function aFighterIsNotDead(ReferenceAlias SLV_Fighter)
if SLV_Fighter != none
	if SLV_Fighter.getActorRef() != none
		if !SLV_Fighter.getActorRef().isDead()
			return true
		endif
	endif
endif
return false
endfunction


bool function allFighterLost()
if aFighterHasNotLost(SLV_Fighter1)
	myScripts.SLV_DisplayInformation("Fighter1 still fighting")
	return false
endif
if aFighterHasNotLost(SLV_Fighter2)
	myScripts.SLV_DisplayInformation("Fighter2 still fighting")
	return false
endif
if aFighterHasNotLost(SLV_Fighter3)
	myScripts.SLV_DisplayInformation("Fighter3 still fighting")
	return false
endif
if aFighterHasNotLost(SLV_Fighter4)
	myScripts.SLV_DisplayInformation("Fighter4 still fighting")
	return false
endif
return true
endfunction

bool function aFighterHasNotLost(ReferenceAlias SLV_Fighter)
if SLV_Fighter != none
	if SLV_Fighter.getActorRef() != none
		if !SLV_Fighter.getActorRef().IsInFaction(SLV_ColosseumNPCLost)
			return true
		endif
	endif
endif
return false
endfunction


function knockOutEssentialNPC(Actor actorNPC)
Utility.wait(2.0)

actorNPC.stopCombat()
actorNPC.RestoreAV("Health", 100)
actorNPC.addtofaction(SLV_ColosseumNPCLost)

ActorUtil.AddPackageOverride(actorNPC, SLV_ColosseumGladiatorHasLost ,100)
actorNPC.evaluatePackage()
endfunction
