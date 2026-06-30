Scriptname sr_infDeflateAbility extends ReferenceAlias

import StorageUtil

sr_inflateConfig Property config auto
sr_inflateQuest Property inflater auto
Quest Property sr_inflateExternalEventManager Auto
bool keydown = false
bool spermout = false
bool bAnimController = true

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
Ingredient Property FHUTentacle Auto
Ingredient Property VoidSalts Auto
Ingredient Property FireSalts Auto
Ingredient Property FrostSalts Auto
Ingredient Property SprigganSap Auto
Ingredient Property DLC2AshHopperJelly Auto

soulgem property SoulGemBlack auto
formlist property sr_InjectorFormlist auto
MagicEffect Property sr_ExpelCumMGEF Auto

Function Maintenance()
	UnregisterForAllKeys()
	spermout = false
	If config.defKey >= 0
		RegisterForKey(config.defKey)
	EndIf
	config.CheckGamePad()
EndFunction

Event OnPlayerLoadGame()
	lastDeflationTime = 0.0
EndEvent

float lastDeflationTime = 0.0
float deflationCooldownSecs = 5.0

Event OnKeyDown(int kc)
	if kc == config.defKey
		float now = Utility.GetCurrentRealTime()
		if now - lastDeflationTime >= deflationCooldownSecs
			lastDeflationTime = now
			SpermOutStart()
		else
			log("Deflation attempt blocked. Cooldown active.")
		endif
	endif
EndEvent

Function SpermOutStart()
	keydown = true
	Actor p = GetActorReference()
		If (!p)
			return
		EndIf
	If p.IsInFaction(inflater.inflaterAnimatingFaction)
		log("Already animating!")
		inflater.notify("$FHU_DEF_FAIL")
		keydown = false
		return
	EndIf
	Utility.Wait(0.1)
	If keydown && !spermout
		spermout = true;To prevent trigger from continual press
		If p.GetActorValuePercentage("Stamina") >= 0.3
			SendModEvent("dhlp-Suspend") ; do not forgot about `dhlp-Resume` before exit this `If` and function
			int type = inflater.GetMostRecentInflationType(p);Important
			int err = 0
			;log("Type: " + type)
			If type > 0 && type < 3
				int plugged = inflater.isPlugged(p)
				;log("Plugged: " + plugged)
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
				err = 3 ; both plugs WIP
				EndIf
			elseif type == 3
				int gagged = inflater.isGagged(p)
				if gagged == 0;Not Gagged
					err = 0
				elseif gagged == 1;Gagged but permitoral
					;No mouthcontrol
					err = 0
				else;Gagged
					;WIP: When it crosses the capacity limit, you vomit. If not, you feel like vomiting but vomit nothing.
					err = 7
					type = inflater.GetMoreInflationType(p, type)
					
					if type > 0
						err = 0
						int plugged = inflater.isPlugged(p)
						If plugged < 3
							If type == plugged ; one plug and it's blocking
								If type == 1 ; determine which message to show
									err = 1;vaginal
								Else
									err = 2;anal
								EndIf
							EndIf
							
							If err == 1 && inflater.GetAnalCum(p) > 0 && plugged != 2; switch pools if possible and clear the error
								type = 2
								err = 0
								log("Vaginal plug, switching to anal deflation")
							ElseIf err == 2 && inflater.GetVaginalCum(p) > 0 && plugged != 1
								type = 1
								err = 0
								log("Anal plug, switching to vaginal deflation")
							EndIf
						endif
					endif
				endif
			
			else
				err = 10; no cum
			EndIf
			
			If err != 10 ; If has cum
				p.DamageActorValue("Stamina", ((p.GetActorValue("Stamina") / p.GetActorValuePercentage("Stamina")) * 0.4))				
				If p.HasSpell(inflater.sr_inflateBurstSpell)
					err = 5
					log("Bursting, can't deflate")
				EndIf
			EndIf
				
			If err == 0 && (Utility.RandomInt(0, 99) < sr_ExpelFaliure.getvalue() as int)
				If type > 0 && type < 3
					err = 4
				elseif type == 3
					err = 6
				endif
			;	log("RandomErrorNotEnoughRandom")
			EndIf
		
			If err == 0
			;	log("Pushing: " + type)
				inflater.UnequipTullAnimatedCreampieCumItem(p, type)
				doPush(type)
			else
				If err == 1
					inflater.notify("$FHU_DEF_BLOCK_V"); animation wip
					DeflateFailMotion(p, 1, true, 0)
				ElseIf err == 2
					inflater.notify("$FHU_DEF_BLOCK_A"); animation wip
					DeflateFailMotion(p, 1, true, 0)
				ElseIf err == 3
					inflater.notify("$FHU_DEF_BLOCK"); animation wip
					DeflateFailMotion(p, 1, true, 0)
				ElseIf err == 4
					inflater.notify("$FHU_DEF_FAIL")
					DeflateFailMotion(p, type, true, inflater.GetSpermLastActor(p, type));Vaginal or Anal
				ElseIf err == 5
					inflater.notify("$FHU_DEF_BURST_FAIL")
					DeflateFailMotion(p, 1, true, inflater.GetSpermLastActor(p, type))
				ElseIf err == 6
					inflater.notify("$FHU_DEF_ORAL_FAIL");Anal to Oral WIP
					DeflateFailMotion(p, 3, true, inflater.GetSpermLastActor(p, type))
				ElseIf err == 7
					inflater.notify("$FHU_EXPELFAILGAGGED_MESSAGES");Oral Gag WIP
					DeflateFailMotion(p, 3, true, 0)
				ElseIf err == 8;Stamina Out
					inflater.notify("$FHU_DEF_FIZZLE")
					DeflateFailMotion(p, 4, false, 0)
				ElseIf err == 9;expel fail vaginal wip - scanner
					inflater.notify("$FHU_DEF_REFUSE")
					DeflateFailMotion(p, 5, false, 0)
				ElseIf err == 10 ; no cum
					; maybe not need
					inflater.notify("$FHU_DEF_NOCUM")
					DeflateFailMotion(p, 4, false)
				Else ; other
					;
				EndIf
			EndIf
			SendModEvent("dhlp-Resume")
		Else
			inflater.notify("$FHU_DEF_FIZZLE")
			DeflateFailMotion(p, 4, false)
		EndIf
		spermout = false
	endIf
EndFunction

Function DeflateFailMotion(actor akactor, int CumType, bool btongue = true, int spermtype = 0)
	If  (akactor.IsInFaction(inflater.inflaterAnimatingFaction))
		return
	EndIf
	akactor.AddToFaction(inflater.inflaterAnimatingFaction)
	akactor.SetFactionRank(inflater.inflaterAnimatingFaction, 1)

	inflater.DeflateFailMotion(akactor, CumType, btongue, spermtype)

	akactor.RemoveFromFaction(inflater.inflaterAnimatingFaction)
EndFunction

Event OnKeyUp(int kc, float time)
	if kc == config.defKey
		SpermOutStop()
	endIf
EndEvent

Function SpermOutStop()
	keydown = false
	Actor p= GetActorReference()
	If (p)
		MfgConsoleFuncExt.ResetMfg(p)
	EndIf
EndFunction

Function doPushDeflate(String pool, Actor p, float currentInf, float startVag, float startAn, float startOral)
       If !config.bellyScale
               return
       EndIf
       If currentInf <= 0
               currentInf = 0
       EndIf

	if bAnimController ;Prevents serious FPS drop due to heavy code stacks.
		bAnimController = false
		if config.BodyMorph
            if (pool == inflater.CUM_VAGINAL || pool == inflater.CUM_ANAL)
					; to cover same morph for oral and vag/anal
				If (inflater.InflateMorph == inflater.InflateMorph4)
					inflater.SetBellyMorphValue(p, currentInf + inflater.GetOralCum(p), inflater.InflateMorph)
				else
					;inflater.SetBellyMorphValue(p, currentInf, "PregnancyBelly")
					inflater.SetBellyMorphValue(p, currentInf, inflater.InflateMorph)
				endif
				;log("deflate SetBellyMorphValue currentInf:" + currentInf + inflater.GetOralCum(p) + ".Cum:" + cum )
				if inflater.InflateMorph2 != ""
					;log("deflate SetBellyMorphValue2 currentInf:" + currentInf + inflater.GetOralCum(p) + ".Cum:" + cum )
					inflater.SetBellyMorphValue(p, currentInf, inflater.InflateMorph2)
				endIf
				if inflater.InflateMorph3 != ""
					;log("deflate SetBellyMorphValue3 currentInf:" + currentInf + inflater.GetOralCum(p) + ".Cum:" + cum )
					inflater.SetBellyMorphValue(p, currentInf, inflater.InflateMorph3)
				endif
			elseif (pool == inflater.CUM_ORAL)
			; to cover same morph for oral and vag/anal
				If (inflater.InflateMorph == inflater.InflateMorph4)
					inflater.SetBellyMorphValue(p, currentInf + inflater.GetInflation(p), inflater.InflateMorph)
				elseif inflater.InflateMorph4 != ""
					inflater.SetBellyMorphValue(p, currentInf, inflater.InflateMorph4)
					;log("deflate SetBellyMorphValue4 currentInf:" + currentInf + inflater.GetOralCum(p) + ".Cum:" + cum )
				endif
			endif
		endif

		if !config.BodyMorph ;SLIF: oralcum now inflates belly node also. Should be capped by cum condition in deflate function
			; ( add by 15, sent to SLIF sum of all pools
			if pool == inflater.CUM_VAGINAL || pool == inflater.CUM_ANAL
				;log(" deflate SetNodeScale currentInf:" + currentInf + inflater.GetOralCum(p) + ".Cum:" + cum )
				inflater.SetNodeScale(p, "NPC Belly", currentInf + startOral)
			elseif pool == inflater.CUM_ORAL
				;log("deflate SetNodeScale currentInf:" + currentInf + inflater.GetInflation(p) + ".Cum:" + cum )
				inflater.SetNodeScale(p, "NPC Belly", currentInf + startVag + startAn)
			endif
			; by 15 )
		endif
	else
		bAnimController = true
	endif
       
EndFunction

bool updateFHU = false
int updateCumType
Event OnUpdate()
	if inflater.UpdateFHUmoan(GetReference(), updateCumType)
		RegisterForSingleUpdate(10.0)
	Else
		updateCumType = 0
		updateFHU = false
	EndIf
EndEvent

Function RegisterFHUUpdate(int CumType)
	updateCumType = CumType
	updateFHU = true
	RegisterForSingleUpdate(10.0)
EndFunction

Function doPush(int type)
	log("doPush")
	Actor p = GetActorReference()
	If p.IsInFaction(inflater.inflaterAnimatingFaction)
		return
	endif
	p.AddToFaction(inflater.inflaterAnimatingFaction)
	p.SetFactionRank(inflater.inflaterAnimatingFaction, 1)
	;Done during leakage call.This is slow
		;Game.DisablePlayerControls()
		;Game.ForceThirdPerson()
	;int spermtype = inflater.GetSpermLastActor(p)
	String pool = ""
	If type == 1
		pool = inflater.CUM_VAGINAL
	elseif type == 2
		pool = inflater.CUM_ANAL
	else
		pool = inflater.CUM_ORAL
	EndIf
	inflater.StartLeakage(p, type, 1)
	RegisterFHUUpdate(type)
	float baseStamina = p.GetBaseActorValue("Stamina")
	float dps = baseStamina * 0.01
	;float dps = ((p.GetActorValue("Stamina") / p.GetActorValuePercentage("Stamina")) * 0.01)
	float currentInf
	float cum

	float vagCum = GetFloatValue(p, inflater.CUM_VAGINAL)
	float analCum = GetFloatValue(p, inflater.CUM_ANAL)
	float oralCum = GetFloatValue(p, inflater.CUM_ORAL)

	float startVag = vagCum
	float startAn = analCum
	float startOral = oralCum
	
	if type == 1
		currentInf = inflater.GetInflation(p)
		cum = vagCum
		log("doPush Vaginal = "+vagCum)
	elseif type == 2
		currentInf = inflater.GetInflation(p)
		cum = analCum
		log("doPush Anal = "+analCum)
	elseif type == 3
		currentInf = inflater.GetOralCum(p)
		cum = oralCum
		log("doPush Oral = "+oralCum)
	endif

	float originalCum = cum
	float originalInf = currentInf
	float deflationTick = inflater.config.BodyMorphApplyPeriod
	float elapsed = deflationTick + 1.0 ; Ensure first run triggers deflation	
;	log("Starting: inf: " + currentInf +", cum: " +cum + ", pool: " + pool)
	float delta = 0.05 * (1.0 / inflater.config.animMult)
	;Cumout(actor p, currentInf);While Script
	While (keydown || p.HasMagicEffect(sr_ExpelCumMGEF)) && p.GetActorValuePercentage("Stamina") > 0.02 && cum > 0.02
		currentInf -= delta
		cum -= delta

		; Run deflation immediately on first tick, then after intervals
		if elapsed >= deflationTick
			doPushDeflate(pool, p, currentInf, startVag, startAn, startOral)
			elapsed = 0.0
		endif

		p.DamageActorValue("Stamina", dps)
		Utility.Wait(0.3)
		elapsed += 0.3
	EndWhile

	If cum <= 0.02
		cum = 0.0
	EndIf
	
	; try to get around some rounding errors and match the values
	float diff = originalCum - cum
	currentInf = originalInf - diff
	
	log("Final cum: "+cum+", cum diff from original: " + diff + ", final inflation: " + currentInf)

	if type == 1
		vagCum = cum
		if vagCum < 0.1
			vagCum = 0.0
			UnsetFloatValue(p, inflater.LAST_TIME_VAG)
			UnsetFloatValue(p, inflater.CUM_VAGINAL)
			sr_InjectorFormlist.revert()
		Else
			SetFloatValue(p, inflater.CUM_VAGINAL, vagCum)
		EndIf
	Elseif type == 2
		analCum = cum
		if analCum < 0.1
			analCum = 0.0
			UnsetFloatValue(p, inflater.LAST_TIME_ANAL)
			UnsetFloatValue(p, inflater.CUM_ANAL)
			FormListClear(p, "sr.inflater.analinjector")
		Else
			SetFloatValue(p, inflater.CUM_ANAL, analCum)
		EndIf
	elseif type == 3
		oralCum = cum
		if oralCum < 0.1
			oralCum = 0.0
			UnsetFloatValue(p, inflater.LAST_TIME_ORAL)
			UnsetFloatValue(p, inflater.CUM_ORAL)
		Else
			SetFloatValue(p, inflater.CUM_ORAL, oralCum)
		EndIf
	EndIf

	If type < 3
		if ( analCum <= 0.0 && vagCum <= 0.0 )
			UnsetFloatValue(p, inflater.INFLATION_AMOUNT)
		else
			currentInf = analCum + vagCum
			SetFloatValue(p, inflater.INFLATION_AMOUNT, currentInf)
		endif
	EndIf

	log("Cum amounts after doPush, v: "+ vagCum +", a: "+ analCum +", t: "+ (analCum+vagCum) + ", o: " + oralCum)

	doPushDeflate(pool, p, currentInf, startVag, startAn, startOral)
	
	Utility.Wait(0.1)
	inflater.StopLeakage(p, type)
	inflater.UpdateFaction(p)
	inflater.UpdateOralFaction(p)
	if type == 1
		inflater.SendPlayerCumUpdate(cum, false)
	elseif type == 2
		inflater.SendPlayerCumUpdate(cum, true)
	endif
	p.RemoveFromFaction(inflater.inflaterAnimatingFaction)
	inflater.EncumberActor(p) ; Has a 2s wait in it, do it after returning controls to keep it responsive
	int cumcompare = 0
	If diff > 0
		cumcompare = diff as Int
	EndIf
	
	if sr_Cumvariationingredients.getvalue() == 1 && cumcompare > 0
		int spermtype = GetIntValue(p, inflater.ANIMATING_SPERMTYPE, -1)
		if type < 3
			if spermtype < 0;none
				; skip
			elseif spermtype == 0;human
				p.additem(FHUHumanCum, cumcompare)
			elseif spermtype == 1;beast
				p.additem(FHUBeastCum, cumcompare)
			elseif spermtype == 2;Draugr
				p.additem(FHURottenCum, cumcompare)
			elseif spermtype == 3;spider
				p.additem(FHUSpiderEgg, cumcompare)
			elseif spermtype == 4;chaurus
				if originalCum > 3.0
					p.additem(FHULarvae, 1)
				endif
				p.additem(FHUChaurusEggs, cumcompare)
			elseif spermtype == 5;spriggan
				p.additem(SprigganSap, cumcompare)
				if originalCum > 3.0
					p.additem(FHUSlug, 1)
				endif
			elseif spermtype == 6;Stone
				p.additem(VoidSalts, cumcompare)
				if originalCum > 3.0
					p.additem(SoulGemBlack, 1)
				endif
			elseif spermtype == 7;Ashhopper
				p.additem(DLC2AshHopperJelly, cumcompare)
				if originalCum > 3.0
					p.additem(FHUAshHopperEggs, 2)
				endif
			elseif spermtype == 8;Flame
				p.additem(FireSalts, cumcompare)
				if originalCum > 3.0
					p.additem(SoulGemBlack, 1)
				endif
			elseif spermtype == 9;Frost
				p.additem(FrostSalts, cumcompare)
				if originalCum > 3.0
					p.additem(SoulGemBlack, 1)
				endif
			else
				p.additem(FHUHumanCum, cumcompare)
			endif
		elseif type == 3
			If spermtype >= 0
				p.additem(FHUVomitCum, cumcompare)
			EndIf
		endif
	endif

	if analCum <= 0.0
		inflater.RemoveAnalFaction(p)
		if vagCum <= 0.0
			inflater.RemoveFaction(p)
			if OralCum <= 0.0
				StorageUtil.FormListRemove(inflater, inflater.INFLATED_ACTORS, p, true)
				inflater.UnencumberActor(p)
				inflater.sr_plugged.setValueInt(0)
			endif
		endif
	endif
	
EndFunction

Function log(String msg)
	inflater.log("[DefAbility]: " + msg)
EndFunction
