Scriptname SLV_DeathIsNotTheEnd extends ReferenceAlias  

Event OnEnterBleedout()
myScripts.SLV_DisplayInformation(" Entering bleedout")

HandlePlayerDeath()
EndEvent


Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
myScripts.SLV_DisplayInformation("We were hit by " + akAggressor + " PC HP : " + PlayerRef.getActorValue("Health"))

If PlayerRef.getActorValue("Health") < 1
	HandlePlayerDeath()
EndIf
EndEvent

Function HandlePlayerDeath()
myScripts.SLV_DisplayInformation("HandlePlayerDeath, PC HP : " + PlayerRef.getActorValue("Health"))
if MCMMenu.dontDieInArena
	int fightmode = SLV_ColosseumFightMode.getValue() as int
	
	if fightmode == 0 || fightmode == 1
		BringDeadPlayer()
	else
		EndFight()
	endif
EndIf
EndFunction


Function EndFight()
myScripts.SLV_DisplayInformation("Ending the fight, PC HP : " + PlayerRef.getActorValue("Health"))
PlayerRef.StopCombat()
PlayerRef.StopCombatAlarm()

Utility.Wait(5)
;a fadout to hide the "magic"
Game.FadeOutGame(false, true, 5.0, 1.0)

PlayerRef.SetNoBleedoutRecovery(False)
Game.EnablePlayerControls()
PlayerRef.RestoreAV("Health", 100)

deadPlayer.RepairAlivePlayer()
Utility.Wait(2)
fillGladiatorAlias()

SLV_ArenaFightQuest.SetObjectiveCompleted(1500)
SLV_ArenaFightQuest.SetStage(3500)

SLV_ArenaFightLoosingScene.ForceStart()
EndFunction

Function BringDeadPlayer()
PlayerRef.StopCombat()
PlayerRef.StopCombatAlarm()

;Ressurect the player
Utility.Wait(5)
;a fadout to hide the "magic"
Game.FadeOutGame(false, true, 5.0, 1.0)

PlayerRef.SetNoBleedoutRecovery(False)
Game.EnablePlayerControls()
PlayerRef.RestoreAV("Health", 100)
shaving.SaveActualHairCut(PlayerRef)

; make the player a ghost
deadPlayer.MakePlayerAGhost()

; pop the body in
deadPlayer.FakeKillPlayer(PlayerRef, PlayerRef)

fillGladiatorAlias()

SLV_ArenaFightQuest.SetObjectiveCompleted(1500)
SLV_ArenaFightQuest.SetStage(2500)

;int fightmode = SLV_ColosseumFightMode.getValue() as int
;if fightmode == 0 


necroRapeScene.ForceStart()

	;else
;	necroRezzingScene.ForceStart()
;endif
EndFunction

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

SLV_PrepareDeadPlayer Property deadPlayer Auto
SLV_Utilities Property myScripts auto
SLV_MCMMenu Property MCMMenu Auto
SLV_HeadShaving Property shaving Auto
Actor Property PlayerRef Auto
Scene Property necroRapeScene Auto
Scene Property necroRezzingScene Auto
Scene Property SLV_ArenaFightLoosingScene Auto

GlobalVariable Property SLV_ColosseumFightMode Auto

ReferenceAlias Property SLV_Fighter1 Auto
ReferenceAlias Property SLV_Fighter2 Auto
ReferenceAlias Property SLV_Fighter3 Auto
ReferenceAlias Property SLV_Fighter4 Auto
ReferenceAlias Property SLV_Gladiator Auto

Quest Property SLV_ArenaFightQuest Auto
