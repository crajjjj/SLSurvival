Scriptname SLV_OnBleedOut extends ReferenceAlias  

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
myScripts.SLV_DisplayUser(actorNPC.getActorBase().getname() + " has been defeated")

knockOutEssentialNPC(actorNPC)
EndFight()
if SLV_Quest.getStage() == fromStage
	SLV_Quest.SetObjectiveCompleted(fromStage)
	SLV_Quest.SetStage(toStage)
EndIf
EndFunction

Function EndFight()
PlayerRef.StopCombat()
PlayerRef.StopCombatAlarm()
myScripts.SLV_FollowersStopFighting()

Utility.Wait(1.0)
endfunction

function knockOutEssentialNPC(Actor actorNPC)
Utility.wait(1.0)

actorNPC.stopCombat()
actorNPC.StopCombatAlarm()

actorNPC.RestoreAV("Health", 100)

;ActorUtil.AddPackageOverride(actorNPC, SLV_DoNothing2 ,100)
;actorNPC.evaluatePackage()
endfunction

SLV_Utilities Property myScripts auto
Quest Property SLV_Quest Auto
int Property fromStage Auto
int Property toStage Auto
Actor Property PlayerRef Auto