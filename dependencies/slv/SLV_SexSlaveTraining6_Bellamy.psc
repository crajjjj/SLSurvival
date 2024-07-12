Scriptname SLV_SexSlaveTraining6_Bellamy extends ReferenceAlias  

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

if SLV_SexSlaveTraining6Quest.getStage() == 7000
	SLV_SexSlaveTraining6Quest.SetObjectiveCompleted(7000)
	SLV_SexSlaveTraining6Quest.SetStage(7500)

	ActorUtil.ClearPackageOverride(SLV_Bellamy.getActorRef())
	SLV_Bellamy.getActorRef().evaluatePackage()
	ActorUtil.AddPackageOverride(SLV_Bellamy.getActorRef(), SLV_ColosseumTrainingWalkToCenter ,100)
	SLV_Bellamy.getActorRef().evaluatePackage()
EndIf
EndFunction
SLV_Utilities Property myScripts auto
Quest Property SLV_SexSlaveTraining6Quest Auto
Actor Property PlayerRef Auto

GlobalVariable Property SLV_EnforcerIgnorePC Auto

Package Property SLV_ColosseumTrainingWalkToCenter Auto
ReferenceAlias Property SLV_Bellamy Auto