Scriptname sr_inflateBurstEffect extends ActiveMagicEffect

sr_inflateQuest Property inflater auto
Faction Property slAnimatingFaction auto
ImagespaceModifier Property sr_burstFlash Auto

Actor t 
float totalMultChange = 0.0

Event OnEffectStart(Actor akTarget, Actor akCaster)
	inflater.log("Starting burst effect for " + akTarget.GetLeveledActorBase().GetName())
	t = akTarget
	totalMultChange = -20.0
	akTarget.ModActorValue("SpeedMult", totalMultChange)
	RegisterForSingleUpdateGameTime(0.67)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	inflater.log("OnEffectFinish() burst effect for " + t.GetLeveledActorBase().GetName())
	t.ModActorValue("SpeedMult", (totalMultChange * -1))
	t.RemoveSpell(inflater.sr_inflateBurstSpell) ; WTF? just Dispel() seems to leave the effects on the actor
EndEvent

Event OnUpdateGameTime()
	inflater.log("OnUpdateGameTime() burst effect for " + t.GetLeveledActorBase().GetName())
	If t.IsInFaction(slAnimatingFaction) || t.IsInCombat() || inflater.isPlugged(t) == 3
		inflater.log(t.GetLeveledActorBase().GetName() + " stays bursting.")
		If totalMultChange > -40.0
			totalMultChange -= 5.0
			t.ModActorValue("SpeedMult", -5.0)
		EndIf
		float currentHP = t.GetActorValue("Health")
		float maxHP = currentHP / t.GetActorValuePercentage("Health")
		float toDMG = maxHP * 0.13
		If currentHP - toDMG < 10
			toDMG = currentHP - 10
		EndIf
		t.DamageActorValue("Health", toDMG)
		if t == inflater.Player 
			If Utility.RandomInt(0, 99) < 15
				inflater.notify("$FHU_BURST_TICK")
			EndIf
			sr_burstFlash.Apply()
			Utility.Wait(2.0)
			sr_burstFlash.Remove()
		EndIf

		RegisterForSingleUpdateGameTime(0.5)
	Else
		float maxInflation = inflater.config.maxInflation * inflater.BURST_MULT
		float deflateAmount = (inflater.GetTotalCum(t)) - maxInflation
		
		If deflateAmount > 0.0
			inflater.log("Deflating burst from " + t.GetLeveledActorBase().GetName())
			int poolmask = 0
			If inflater.isPlugged(t) < 2 && inflater.GetMostRecentInflationType(t) == 2
				poolmask = inflater.ANAL
			else
				poolmask = inflater.VAGINAL
			EndIf
			inflater.QueueActor(t, false, poolmask, deflateAmount, utility.RandomFloat(4.0, 8.0), animate = 2)
			inflater.InflateQueued()
			if t == inflater.Player
				inflater.Notify("$FHU_BURST_END")
			EndIf
			Dispel()
		Else 
			inflater.warn("Burst effect OnUpdate with total cum less than max inflation on actor "+t.GetLeveledActorBase().GetName()+"! (" + inflater.GetTotalCum(t) + "/" + maxInflation + ")" )
			Dispel()
		EndIf		
	EndIf
EndEvent

Event OnUnload()
	inflater.log("OnUnload() burst effect for " + t.GetLeveledActorBase().GetName())
	Dispel()
EndEvent

Event OnDying(Actor akKiller)
	inflater.log("OnDying() burst effect for " + t.GetLeveledActorBase().GetName())
	Dispel()
EndEvent 