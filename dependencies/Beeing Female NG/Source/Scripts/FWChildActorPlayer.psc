Scriptname FWChildActorPlayer extends FWChildActor  

import PO3_Events_Form

function Upgrade(int oldVersion, int newVersion)
	if oldVersion<9
		RemoveFromFaction(CurrentFollowerFaction)
		;RemoveFromFaction(Game.GetFormFromFile(0x5C84E, "Skyrim.esm") as faction)
	endif
endFunction

event OnInit()
	;SetActorValue("Variable07", 1)
	parent.SetActorValue("Destruction", self.GetActorValue("Destruction"))
	parent.SetActorValue("Illusion", self.GetActorValue("Illusion"))
	parent.SetActorValue("Conjuration", self.GetActorValue("Conjuration"))
	parent.SetActorValue("OneHanded", self.GetActorValue("OneHanded"))
	parent.SetActorValue("TwoHanded", self.GetActorValue("TwoHanded"))
	parent.SetActorValue("Marksman", self.GetActorValue("Marksman"))
	parent.SetActorValue("Health", self.GetActorValue("Health"))
	parent.SetActorValue("Sneak", self.GetActorValue("Sneak"))
	parent.SetActorValue("Magicka", self.GetActorValue("Magicka"))
	parent.SetActorValue("Restoration", self.GetActorValue("Restoration"))
	parent.SetActorValue("Alteration", self.GetActorValue("Alteration"))
	parent.SetActorValue("Block", self.GetActorValue("Block"))
	parent.SetActorValue("SpeedMult", self.GetActorValue("SpeedMult"))
	parent.SetActorValue("CarryWeight", self.GetActorValue("CarryWeight"))
	int sc = StorageUtil.FormListCount(self,"FW.Child.Perks")
	GivePerks()
	parent.OnInit()
	
	RegisterForHitEventEx(self, aiBlockFilter = 1)
endEvent

Event OnPlayerLoadGame()
	parent.OnPlayerLoadGame()
	
	; Init Stats
	parent.SetActorValue("Destruction", self.GetActorValue("Destruction"))
	parent.SetActorValue("Illusion", self.GetActorValue("Illusion"))
	parent.SetActorValue("Conjuration", self.GetActorValue("Conjuration"))
	parent.SetActorValue("OneHanded", self.GetActorValue("OneHanded"))
	parent.SetActorValue("TwoHanded", self.GetActorValue("TwoHanded"))
	parent.SetActorValue("Marksman", self.GetActorValue("Marksman"))
	parent.SetActorValue("Health", self.GetActorValue("Health"))
	parent.SetActorValue("Sneak", self.GetActorValue("Sneak"))
	parent.SetActorValue("Magicka", self.GetActorValue("Magicka"))
	parent.SetActorValue("Restoration", self.GetActorValue("Restoration"))
	parent.SetActorValue("Alteration", self.GetActorValue("Alteration"))
	parent.SetActorValue("Block", self.GetActorValue("Block"))
	parent.SetActorValue("SpeedMult", self.GetActorValue("SpeedMult"))
	parent.SetActorValue("CarryWeight", self.GetActorValue("CarryWeight"))
	
	;SetActorValue("Variable07", 1)

	GivePerks()
EndEvent

Event OnHitEx(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	actor ak = akAggressor as actor
	if ak!= none
		;if abHitBlocked == true
			AddExp(ak.GetLevel() / 10)
		;endif
	endif
endEvent

; 0 - not in combat
; 1 - in combat
; 2 - searching
float SearchStartTime = 0.0;
float InCombatStartTime = 0.0;
Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	; Add exp
	float curTime = Utility.GetCurrentRealTime()
	if SearchStartTime>0
		AddExp((curTime - SearchStartTime) / 20)
	endif
	if InCombatStartTime>0
		AddExp((curTime - InCombatStartTime) / 10)
	endif
	SearchStartTime = 0
	InCombatStartTime = 0
	
	; No friendly fire
	if (akTarget!=none)
		if (akTarget.IsPlayerTeammate())
			StopCombat()		
			SetRelationshipRank(akTarget, 3)
			akTarget.SetRelationshipRank(self, 3)
		endif
	endif
	
	; Set Timers and EnemyStats
	if(aeCombatState >= 0)
		if(aeCombatState < 2)
			if(aeCombatState==0)
				if GetActorValuePercentage("Health")<=0
					RestoreActorValue("Health", GetActorValue("Health") * 99999)
					DamageActorValue("Health", GetActorValue("Health") - 10)
				endif
			else;if(aeCombatState==1)
				SearchStartTime = 0
				InCombatStartTime = curTime
			endIf
		elseif(aeCombatState==2)
			SearchStartTime = curTime
			InCombatStartTime = 0
		endif
	endIf
EndEvent