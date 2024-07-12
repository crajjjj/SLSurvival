Scriptname SLV_SexSlaveTraining6_Quintus extends ReferenceAlias  

event OnDeath(Actor akKiller)
myScripts.SLV_DisplayInformation("You killed an opponent!")

Actor actorNPC = getActorRef()
EndFight(actorNPC)
EndEvent

Event OnEnterBleedout()
Actor actorNPC = getActorRef()
myScripts.SLV_DisplayInformation(" Entering NPC bleedout")

EndFight(actorNPC)
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
Actor actorNPC =getActorRef()
myScripts.SLV_DisplayInformation("NPC was hit by " + akAggressor + " NPC HP : " + actorNPC.getActorValue("Health"))

If actorNPC.GetActorValuePercentage("Health") < 0.8
	EndFight(actorNPC)
EndIf
EndEvent

Function EndFight(Actor actorNPC)
actorNPC.StopCombat()
PlayerRef.StopCombat()
PlayerRef.StopCombatAlarm()
myScripts.SLV_StripBothHands(PlayerRef)
SLV_EnforcerIgnorePC.setValue(0)

SendModEvent("dhlp-Resume")

if SLV_SexSlaveTraining6Quest.getStage() == 5000
	SLV_SexSlaveTraining6Quest.SetObjectiveCompleted(5000)
	SLV_SexSlaveTraining6Quest.SetStage(5500)
EndIf
EndFunction
SLV_Utilities Property myScripts auto
Quest Property SLV_SexSlaveTraining6Quest Auto
Actor Property PlayerRef Auto

GlobalVariable Property SLV_EnforcerIgnorePC Auto