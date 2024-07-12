Scriptname sr_infDeflateAbility extends ReferenceAlias

sr_inflateConfig Property config auto
sr_inflateQuest Property inflater auto
Quest Property sr_inflateExternalEventManager Auto
bool keydown = false

Globalvariable Property sr_OnEventNoDeflation Auto
Globalvariable Property sr_ExpelFaliure Auto
Globalvariable Property sr_OnEventAbsorbSperm Auto
Globalvariable Property sr_Cumvariationingredients Auto

Ingredient Property FHUVomitCum Auto
Ingredient Property FHUHumanCum Auto
Ingredient Property FHUBeastCum Auto
Ingredient Property FHURottenCum Auto
Ingredient Property FHUSpiderEgg Auto
Ingredient Property FHUChaurusEggs Auto
Ingredient Property FHUAshHopperEggs Auto
Ingredient Property FHULarvae Auto
Ingredient Property FHUSlug Auto
Ingredient Property VoidSalts Auto
Ingredient Property SprigganSap Auto
Ingredient Property DLC2AshHopperJelly Auto

soulgem property SoulGemBlack auto
formlist property sr_InjectorFormlist auto

Event OnPlayerLoadGame()
	Maintenance()
EndEvent

Function Maintenance()
	UnregisterForAllKeys()
	If config.defKey >= 0
		RegisterForKey(config.defKey)
	EndIf
	inflater.BaboAnimsSet()
	(sr_inflateExternalEventManager as sr_inflateExternalEventController).RegisterModEvent()
EndFunction

Event OnKeyDown(int kc)
	If kc == config.defKey
		keydown = true
		Utility.Wait(0.4)
		If keydown
			Actor p = GetActorReference()
			
			If p.IsInFaction(inflater.inflaterAnimatingFaction)
				log("Already animating!")
				return
			EndIf
			
			If p.GetActorValuePercentage("Stamina") >= 0.3
				int type = inflater.GetMostRecentInflationType(p);Important
				int err = 0
				log("Type: " + type)
				If type > 0 && type < 3
					int plugged = inflater.isPlugged(p)
					log("Plugged: " + plugged)
					If plugged < 3
						If type == plugged ; one plug and it's blocking
							If type == 1 ; determine which message to show
								err = 1;vaginal
							Else
								err = 2;anal
							EndIf
						EndIf
						
						If err == 1 && inflater.GetAnalCum(p) > 0	&& plugged != 2; switch pools if possible and clear the error
							type = 2
							err = 0
							log("Vaginal plug, switching to anal deflation")
						ElseIf err == 2 && inflater.GetVaginalCum(p) > 0 && plugged != 1
							type = 1
							err = 0
							log("Anal plug, switching to vaginal deflation")
						EndIf						
					Else
						err = 3 ; both plugs
					EndIf
				elseif type == 3; WIP
				;When it crosses the capacity limit, you vomit. If not, you feel like vomiting but vomit nothing.
					err = 0
				Else
					return ; no cum
				EndIf
				
				p.DamageActorValue("Stamina", ((p.GetActorValue("Stamina") / p.GetActorValuePercentage("Stamina")) * 0.4))				
				If p.HasSpell(inflater.sr_inflateBurstSpell)
					err = 5
					log("Bursting, can't deflate")
				EndIf
				
				If (Utility.RandomInt(0, 99) < sr_ExpelFaliure.getvalue() as int) && err == 0
					If type > 0 && type < 3
						err = 4
					elseif type == 3
						err = 6
					endif
				;	log("RandomErrorNotEnoughRandom")
				EndIf
				
				If err == 0
				;	log("Pushing: " + type)
					doPush(type)
				ElseIf err == 1
					inflater.notify("$FHU_DEF_BLOCK_V")
					inflater.DeflateFailMotion(p, 1)
				ElseIf err == 2
					inflater.notify("$FHU_DEF_BLOCK_A")
					inflater.DeflateFailMotion(p, 2)
				ElseIf err == 3
					inflater.notify("$FHU_DEF_BLOCK")
					inflater.DeflateFailMotion(p, 1)
				ElseIf err == 4
					inflater.notify("$FHU_DEF_FAIL")
					inflater.DeflateFailMotion(p, 1)
				ElseIf err == 5
					inflater.notify("$FHU_DEF_BURST_FAIL")
					inflater.DeflateFailMotion(p, 1)
				ElseIf err == 6
					inflater.notify("$FHU_DEF_ORAL_FAIL");Anal to Oral WIP
					inflater.DeflateFailMotion(p, 3)
				EndIf	
			Else
				inflater.notify("$FHU_DEF_FIZZLE")
			EndIf		
		endIf 
	endIf
EndEvent

Event OnKeyUp(int kc, float time)
	if kc == config.defkey
		keydown = false
	endIf
EndEvent

Function doPush(int type)
	Actor p = GetActorReference()
	Game.DisablePlayerControls()
	Game.ForceThirdPerson()
	
	p.AddToFaction(inflater.inflaterAnimatingFaction)
	p.SetFactionRank(inflater.inflaterAnimatingFaction, 1)
	
	String pool = ""
	If type == 1
		pool = inflater.CUM_VAGINAL
	elseif type == 2
		pool = inflater.CUM_ANAL
	else
		pool = inflater.CUM_ORAL
	EndIf
	inflater.CheckingLastActor(p)
	inflater.StartLeakage(p, type, 1)
	float dps = ((p.GetActorValue("Stamina") / p.GetActorValuePercentage("Stamina")) * 0.01)
	float currentInf
	float startInf
	if type == 1 || type == 2
		currentInf = inflater.GetInflation(p)
	elseif type == 3
		currentInf = inflater.GetOralCum(p)
	endif
	startInf = currentInf
	float cum = StorageUtil.GetFloatValue(p, pool)
	float originalCum = cum
	float originalInf = currentInf
;	log("Starting: inf: " + currentInf +", cum: " +cum + ", pool: " + pool)
	While keydown && p.GetActorValuePercentage("Stamina") > 0.02 && cum > 0.02
		currentInf -= 0.05*(1.0/inflater.config.animMult)
		cum -= 0.05*(1.0/inflater.config.animMult)
		if config.BodyMorph && (pool == inflater.CUM_VAGINAL || pool == inflater.CUM_ANAL)
			;inflater.SetBellyMorphValue(p, currentInf, "PregnancyBelly")
			inflater.SetBellyMorphValue(p, currentInf, inflater.InflateMorph)
			if inflater.InflateMorph2 != ""
				inflater.SetBellyMorphValue(p, currentInf, inflater.InflateMorph2)
			endIf
			if inflater.InflateMorph3 != ""
				inflater.SetBellyMorphValue(p, currentInf, inflater.InflateMorph3)
			endif
		elseif config.BodyMorph && pool == inflater.CUM_ORAL
			if inflater.InflateMorph4 != ""
				inflater.SetBellyMorphValue(p, currentInf, inflater.InflateMorph4)
			endif
		else
			inflater.SetNodeScale(p, "NPC Belly", currentInf)
		endif
	;	log("current: inf: " + currentInf +", cum: " +cum)
		p.DamageActorValue("Stamina", dps)
		Utility.wait(0.3)
	endWhile

	If cum < 0.02
		cum = 0.0
		If type == 1
			StorageUtil.UnsetFloatValue(p, inflater.LAST_TIME_VAG)
			sr_InjectorFormlist.revert()
		Elseif type == 2
			StorageUtil.UnsetFloatValue(p, inflater.LAST_TIME_ANAL)
		elseif type == 3
			StorageUtil.UnsetFloatValue(p, inflater.LAST_TIME_ORAL)
		EndIf

	EndIf
	
	; try to get around some rounding errors and match the values
	float diff = originalCum - cum
	currentInf = originalInf - diff
	
;	log("Final cum: "+cum+", cum diff from original: " + diff + ", final inflation: " + currentInf)
	
	If currentInf < 1.0
		currentInf = 0.0
		StorageUtil.FormListRemove(inflater, inflater.INFLATED_ACTORS, p, true)
		inflater.sr_plugged.SetValueInt(0)
	EndIf
	if config.BodyMorph && (pool == inflater.CUM_VAGINAL || pool == inflater.CUM_ANAL)
		;inflater.SetBellyMorphValue(p, currentInf, "PregnancyBelly")
		inflater.SetBellyMorphValue(p, currentInf, inflater.InflateMorph)
		if inflater.InflateMorph2 != ""
			inflater.SetBellyMorphValue(p, currentInf, inflater.InflateMorph2)
		endIf
		if inflater.InflateMorph3 != ""
			inflater.SetBellyMorphValue(p, currentInf, inflater.InflateMorph3)
		endif
	elseif config.BodyMorph && pool == inflater.CUM_ORAL
		if inflater.InflateMorph4 != ""
			inflater.SetBellyMorphValue(p, currentInf, inflater.InflateMorph4)
		endif
	else
		inflater.SetNodeScale(p, "NPC Belly", currentInf)
	endif
	if type < 3
		StorageUtil.SetFloatValue(p, inflater.INFLATION_AMOUNT, currentInf)
	endif
	StorageUtil.SetFloatValue(p, pool, cum)
	Utility.Wait(0.1)
	inflater.StopLeakage(p)
	inflater.UpdateFaction(p)
	inflater.SendPlayerCumUpdate(cum, type == 2)
	Game.EnablePlayerControls()
	p.RemoveFromFaction(inflater.inflaterAnimatingFaction)
	inflater.EncumberActor(p) ; Has a 2s wait in it, do it after returning controls to keep it responsive
	float cumcomparefloat = startInf - currentInf
	int cumcompare = Math.Ceiling(cumcomparefloat)
	
	if sr_Cumvariationingredients.getvalue() == 1
		if type < 3
			if inflater.spermtype == 0;human
				p.additem(FHUHumanCum, cumcompare)
			elseif inflater.spermtype == 1;beast
				p.additem(FHUBeastCum, cumcompare)
			elseif inflater.spermtype == 2;Draugr
				p.additem(FHURottenCum, cumcompare)
			elseif inflater.spermtype == 3;spider
				p.additem(FHUSpiderEgg, cumcompare)
			elseif inflater.spermtype == 4;chaurus
				if startInf > 3.0
					p.additem(FHULarvae, 1)
				endif
				p.additem(FHUChaurusEggs, cumcompare)
			elseif inflater.spermtype == 5;spriggan
				p.additem(SprigganSap, cumcompare)
				if startInf > 3.0
					p.additem(FHUSlug, 1)
				endif
			elseif inflater.spermtype == 6;Stone
				p.additem(VoidSalts, cumcompare)
				if startInf > 3.0
					p.additem(SoulGemBlack, 1)
				endif
			elseif inflater.spermtype == 7;Ashhopper
				p.additem(DLC2AshHopperJelly, cumcompare)
				if startInf > 3.0
					p.additem(FHUAshHopperEggs, 2)
				endif
			else
				p.additem(FHUHumanCum, cumcompare)
			endif
		elseif type == 3
			p.additem(FHUVomitCum, cumcompare)
		endif
	endif
EndFunction

Function log(String msg)
	inflater.log("[DefAbility]: " + msg)
EndFunction
