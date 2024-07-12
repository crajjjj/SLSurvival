Scriptname sr_inflateThread extends ReferenceAlias

import StorageUtil
Faction Property sla_Arousal Auto
sr_inflateQuest Property inflater auto
sr_inflateConfig Property config auto
bool inf = true
bool isAnal = false
bool isVaginal = false
bool isOral = false



float OralcumAmount = 0.0
float cumAmount = 0.0
float tme = 0.0

int animate = 0 ; unused during inflation

String cb = ""

bool running = false

Function SetUp(bool inflate, int poolMask, float amount, float time = 6.0, String callback = "", int DoAnimate = 0 )
	inf = inflate
	isAnal = false
	isOral = false
	
	If Math.LogicalAnd(inflater.VAGINAL, poolMask) && (inflater.sexlab.GetGender(GetActorReference())==1);Female
		isVaginal = true
	ElseIf Math.LogicalAnd(inflater.VAGINAL, poolMask)
		isAnal = true
		isVaginal = false
	Else
		isVaginal = false
	EndIf
	
	If Math.LogicalAnd(inflater.ANAL, poolMask)
		isAnal = true
	EndIf

	If Math.LogicalAnd(inflater.ORAL, poolMask)
		isOral = true
	EndIf
	
	cumAmount = amount
	OralcumAmount = amount * 0.75
	tme = time
	cb = callback
	animate = DoAnimate
	
	RegisterForModEvent(inflater.START_INFLATION, "StartInflation")
	; Could also do a custom modevent and receive all the parameters in that.
	; However, this should allow for a more synchronized animation
	
	RegisterForSingleUpdate(10.0)
EndFunction

Event StartInflation()
	UnregisterForModEvent(inflater.START_INFLATION)
	running = true
	UnregisterForUpdate()
	Actor t = GetActorReference()
	If t.IsInFaction(inflater.inflaterAnimatingFaction)
		log("Can't process, she is already animating.", 1)
		clear()
		return
	endIf
	t.AddToFaction(inflater.inflaterAnimatingFaction)
	t.SetFactionRank(inflater.inflaterAnimatingFaction, 1)
	If inf
		Inflate()
	Else
		Deflate()
	EndIf
	t.RemoveFromFaction(inflater.inflaterAnimatingFaction)
	clear()
EndEvent


Function SetUpAbsorb(bool inflate, int poolMask, float amount, float time = 6.0, String callback = "", int DoAnimate = 0 )
	inf = inflate
	isAnal = false
	isOral = false
	
	If Math.LogicalAnd(inflater.VAGINAL, poolMask) && (inflater.sexlab.GetGender(GetActorReference())==1)
		isVaginal = true
	ElseIf Math.LogicalAnd(inflater.VAGINAL, poolMask)
		isAnal = true
		isVaginal = false
	Else
		isVaginal = false
	EndIf
	
	If Math.LogicalAnd(inflater.ANAL, poolMask)
		isAnal = true
	EndIf
	
	If Math.LogicalAnd(inflater.ORAL, poolMask)
		isOral = true
	EndIf
	
	cumAmount = amount
	tme = time
	cb = callback
	animate = DoAnimate
	
	RegisterForModEvent(inflater.START_ABSORPTION, "StartAbsorption")
	; Could also do a custom modevent and receive all the parameters in that.
	; However, this should allow for a more synchronized animation
	
	RegisterForSingleUpdate(10.0)
EndFunction

Event StartAbsorption()
	UnregisterForModEvent(inflater.START_ABSORPTION)
	running = true
	UnregisterForUpdate()
	Actor t = GetActorReference()
	If t.IsInFaction(inflater.inflaterAnimatingFaction)
		log("Can't process, she is already animating.", 1)
		clear()
		return
	endIf
	t.AddToFaction(inflater.inflaterAnimatingFaction)
	t.SetFactionRank(inflater.inflaterAnimatingFaction, 1)
	If inf
		Inflate()
	else
		Absorb()
	EndIf
	t.RemoveFromFaction(inflater.inflaterAnimatingFaction)
	clear()
EndEvent

Function Inflate()
	Actor akActor = GetActorReference()
	log("Inflating, anal: " + isAnal + ", vaginal: " + isVaginal + ", cum amount: " + cumAmount)
	if inflater.GetState() == ""
		inflater.GoToState("MonitoringInflation")
	EndIf
	
	float currentInflation = GetFloatValue(akActor, inflater.INFLATION_AMOUNT)
	float vagCum = GetFloatValue(akActor, inflater.CUM_VAGINAL)
	float analCum = GetFloatValue(akActor, inflater.CUM_ANAL)
	float oralCum = GetFloatValue(akActor, inflater.CUM_ORAL)
	;debug.notification("Oralcum = " + oralCum)
;	if isOral
;		debug.notification("IsOral")
;	else
;		debug.notification("!IsOral")
;	endif
	float maxInflation = inflater.config.maxInflation
	float OralmaxInflation = inflater.config.OralmaxInflation
	

	If ( (vagCum > 0.0 || inflater.sexlab.GetGender(akActor) == 0) && (analCum > 0.0 || isAnal) ) || ( isVaginal && analCum > 0.0 ) || ( isAnal && isVaginal )
		; Allow a bit extra inflation with both holes filled
		maxInflation *= inflater.BURST_MULT
	EndIf
	
	If isAnal && isVaginal
		log("both - halve the cum amount")
		cumAmount /= 2
	EndIf

	float AnaltoOral = 0
	float OralBursting = 0

	float startVag = vagCum
	float startAn = analCum
	float startOral = oralCum

	int belted = 0	
	If isAnal
		If !inflater.isBelted(akActor, 2)
			analCum += cumAmount
			If (analCum > inflater.GetPoolSize(akActor) && inflater.sexlab.GetGender(akActor) == 1)
				AnaltoOral = analCum - inflater.GetPoolSize(akActor)
				analCum = inflater.GetPoolSize(akActor)
			ElseIf (analCum > inflater.GetPoolSize(akActor)*1.2 && inflater.sexlab.GetGender(akActor) == 0)
				;analCum = inflater.GetPoolSize(akActor)*1.2
				;If we mess with this value here, we'll never manage to get male bursting working.
				;If we're working with an unbelted male, let this value pass through untouched.
			EndIf
			SetFloatValue(akActor, inflater.LAST_TIME_ANAL, inflater.GameDaysPassed.GetValue())
			SetFloatValue(akActor, inflater.CUM_ANAL, analCum)
		Else
			If !isVaginal
				log("Anal sex blocked, done.")
				return 
			EndIf
			belted += 1
		EndIf
	EndIf
	
	If isVaginal
		If !inflater.isBelted(akActor, 1)
			vagCum += cumAmount
			If vagCum > inflater.GetPoolSize(akActor)
				vagCum = inflater.GetPoolSize(akActor)
			EndIf
			SetFloatValue(akActor, inflater.LAST_TIME_VAG, inflater.GameDaysPassed.GetValue())
			SetFloatValue(akActor, inflater.CUM_VAGINAL, vagCum)
		Else
			If !isAnal
				log("Vaginal sex blocked, done.")
				return
			EndIf
			belted += 1
		EndIf
	EndIf

	If isOral
		oralCum += OralcumAmount
		If oralCum > inflater.GetOralPoolSize(akActor)
			OralBursting = oralCum - inflater.GetOralPoolSize(akActor); OralBursting Not Ready WIP
			oralCum = inflater.GetOralPoolSize(akActor)
		EndIf
		SetFloatValue(akActor, inflater.LAST_TIME_ORAL, inflater.GameDaysPassed.GetValue())
		SetFloatValue(akActor, inflater.CUM_ORAL, oralCum)
	EndIf

	if AnaltoOral
		oralCum += AnaltoOral
		If oralCum > inflater.GetOralPoolSize(akActor)
			OralBursting += oralCum - inflater.GetOralPoolSize(akActor); OralBursting Not Ready WIP
			oralCum = inflater.GetOralPoolSize(akActor)
		endif
	endif
	

	If belted > 1
		log("Fully belted, done.")
		return
	EndIf
			
	float inflationTarget = vagCum + analCum
	bool bursting = false
	If inflationTarget > maxInflation;Needs some improvement. It is only activated by Dragons.
		If maxInflation > inflater.config.maxInflation
			bursting = true 
		EndIf
		inflationTarget = maxInflation 
	EndIf
	
	float inflationOralAmount = oralCum - startOral
	float inflationAmount = inflationTarget - currentInflation
	
	log("Status: current inflation: " + currentInflation + ", target: " + inflationTarget + ", vaginal cum: " + vagCum + ", anal cum: " +analCum )
	if tme > 6.0
		tme = 6.0
	endif
	int steps =  Math.Ceiling(tme / 0.2)
	float step = inflationAmount / steps
	float oralstep = inflationOralAmount / steps
	
	if(inflater.config.bellyScale)
		while(currentInflation < inflationTarget)
			currentInflation += step
			if config.BodyMorph
				inflater.SetBellyMorphValue(akActor, currentInflation, inflater.InflateMorph)
				if inflater.InflateMorph2 != ""
					inflater.SetBellyMorphValue(akActor, currentInflation, inflater.InflateMorph2)
				endIf
				if inflater.InflateMorph3 != ""
					inflater.SetBellyMorphValue(akActor, currentInflation, inflater.InflateMorph3)
				endif
			Else
				inflater.SetNodeScale(akActor, inflater.BELLY_NODE, currentInflation)
			Endif
			Utility.wait(0.1)
		EndWhile
		if config.BodyMorph
			inflater.SetBellyMorphValue(akActor, inflationTarget, inflater.InflateMorph)
			if inflater.InflateMorph2 != ""
				inflater.SetBellyMorphValue(akActor, inflationTarget, inflater.InflateMorph2)
			endIf
			if inflater.InflateMorph3 != ""
				inflater.SetBellyMorphValue(akActor, inflationTarget, inflater.InflateMorph3)
			endif
		Else
			inflater.SetNodeScale(akActor, inflater.BELLY_NODE, inflationTarget)
		Endif
		
		while(startOral < oralCum)
			startOral += oralstep
			if config.BodyMorph
				if inflater.InflateMorph4 != ""
					inflater.SetBellyMorphValue(akActor, startOral, inflater.InflateMorph4)
				endIf
			Endif
			Utility.wait(0.1)
		EndWhile
		if config.BodyMorph
			if inflater.InflateMorph4 != ""
				inflater.SetBellyMorphValue(akActor, oralCum, inflater.InflateMorph4)
			endif			
		endif
	EndIf	
	
	If bursting
		if akActor == inflater.Player
			If Utility.RandomInt(0, 99) < 50
				inflater.notify("$FHU_BURST_START01")
			Else
				inflater.notify("$FHU_BURST_START02")
			EndIf
		EndIf
		If !akActor.HasMagicEffectWithKeyword(inflater.sr_WhyWontYouDispel)
			akActor.AddSpell(inflater.sr_inflateBurstSpell, false)
		EndIf
	EndIf
	
	log("Inflated to: " + currentInflation + "(" + inflationTarget + ")" )
	
	FormListAdd(inflater, inflater.INFLATED_ACTORS, akActor, false)
	SetFloatValue(akActor, inflater.INFLATION_AMOUNT, inflationTarget)
	SetFloatValue(akActor, inflater.CUM_ORAL, oralCum)
	inflater.UpdateFaction(akActor)
	inflater.EncumberActor(akActor)
	
	If cb != ""
		Int eid = ModEvent.Create(cb)
		ModEvent.PushForm(eid, akActor)
		ModEvent.PushFloat(eid, startVag)
		ModEvent.PushFloat(eid, startAn)
		ModEvent.PushFloat(eid, startOral)
		ModEvent.Send(eid)
	EndIf

	;Remember this complex if-statement?
	If (analCum > inflater.GetPoolSize(akActor)*1.2 && inflater.sexlab.GetGender(akActor) == 0)
		analCum = inflater.GetPoolSize(akActor)*1.2
		;Now we need to mess with this value.
		;This'll keep the amount of cum stored up this male's ass from going
		; off into infinity as they have more and more (ill-advised) sex.
	EndIf
	
	If akActor == inflater.player;No Oral state is needed.
		If (isAnal && isVaginal)
			inflater.SendPlayerCumUpdate(vagCum, false)
			inflater.SendPlayerCumUpdate(analCum, true)
		Else
			float amount = 0.0
			If isAnal
				amount = analCum
			ElseIf isVaginal
				amount = vagCum
			EndIf
			inflater.SendPlayerCumUpdate(amount, isAnal)
		EndIf
	EndIf
EndFunction

Function Deflate()
	Actor akActor = GetActorReference()
	log("Deflating")
	int Cumtype
	isAnal = !isVaginal ; A bit of hack to have the same parameter on both inflate and deflate despite different usage
	
	float currentInflation

	float vagCum = GetFloatValue(akActor, inflater.CUM_VAGINAL)
	float analCum = GetFloatValue(akActor, inflater.CUM_ANAL)
	float oralCum = GetFloatValue(akActor, inflater.CUM_ORAL)
	
	; Starting values for the callback, current values can be fetched directly
	float startVag = vagCum
	float startAn = analCum
	float startOral = oralCum
	float totalInf
	float maxInflation = inflater.config.maxInflation
	
	if isVaginal
		currentInflation = GetFloatValue(akActor, inflater.INFLATION_AMOUNT)
		totalInf = vagCum + analCum
		Cumtype = 1
	elseif isAnal
		currentInflation = GetFloatValue(akActor, inflater.INFLATION_AMOUNT)
		totalInf = vagCum + analCum
		Cumtype = 2
	elseif isOral
		currentInflation = oralCum
		totalInf = oralCum
		Cumtype = 3
	endif
	
	If (isAnal && analCum - cumAmount > 0.0 && vagCum > 0.0) || (!isAnal && vagCum - cumAmount > 0.0 && analCum > 0.0) || (isAnal && analCum - cumAmount > 0.0 && inflater.sexlab.GetGender(akActor)==0)
		maxInflation *= inflater.BURST_MULT
	EndIf

	float deflateTarget = totalInf - cumAmount
	log("deflateTarget = "+vagCum+" + "+analCum+" - "+cumAmount)
	
	If totalInf > maxInflation && deflateTarget < maxInflation
		log("Combined total higher than max and target lower than max! total: "+totalInf+", target: "+deflateTarget+", max: "+maxInflation, 1)
;		deflateTarget = totalInf - cumAmount;Duplicate
	EndIf
	
	float deflationAmount = currentInflation - deflateTarget
;	float deflationOralAmount = currentInflation - deflateTarget
	int steps = Math.Ceiling(tme / 0.2)
	float step
	
;	if isAnal || isVaginal
		step = deflationAmount / steps
;	elseif isOral
;		step = deflationOralAmount / steps
;	endif
	
	log("cumAmount: " + cumAmount)
	log("DefAmount: " + deflationAmount + ", total time: " + tme + ", steps: " + steps + ", step: " + step)
	
	;inflater.StartLeakage(akActor, isAnal, animate)
	inflater.StartLeakage(akActor, Cumtype, animate)
	If akActor.Is3DLoaded()
		inflater.Moan(akActor)
	EndIf
	if deflateTarget < maxInflation
		; Only actually deflate if total cum is less than max belly size
		If inflater.config.bellyScale
			If akActor.Is3DLoaded()
				while currentInflation > deflateTarget
					Utility.Wait(0.1)
					currentInflation -= step
					if config.BodyMorph && (isAnal || isVaginal)
						;inflater.SetBellyMorphValue(akActor, currentInflation, inflater.PregnancyBelly)
						inflater.SetBellyMorphValue(akActor, currentInflation, inflater.InflateMorph)
						if inflater.InflateMorph2 != ""
							inflater.SetBellyMorphValue(akActor, currentInflation, inflater.InflateMorph2)
						endIf
						if inflater.InflateMorph3 != ""
							inflater.SetBellyMorphValue(akActor, currentInflation, inflater.InflateMorph3)
						endif
					elseif config.BodyMorph && isOral
						if inflater.InflateMorph4 != ""
							inflater.SetBellyMorphValue(akActor, currentInflation, inflater.InflateMorph4)
						endif
					Else
						inflater.SetNodeScale(akActor, inflater.BELLY_NODE, currentInflation)
					Endif
				endWhile
			EndIf
			
			if config.BodyMorph && (isAnal || isVaginal)
				;inflater.SetBellyMorphValue(akActor, deflateTarget, inflater.PregnancyBelly)
				inflater.SetBellyMorphValue(akActor, deflateTarget, inflater.InflateMorph)
				if inflater.InflateMorph2 != ""
					inflater.SetBellyMorphValue(akActor, deflateTarget, inflater.InflateMorph2)
				endIf
				if inflater.InflateMorph3 != ""
					inflater.SetBellyMorphValue(akActor, deflateTarget, inflater.InflateMorph3)
				endif
			elseif config.BodyMorph && isOral
				if inflater.InflateMorph4 != ""
					inflater.SetBellyMorphValue(akActor, deflateTarget, inflater.InflateMorph4)
				endif
			Else
				inflater.SetNodeScale(akActor, inflater.BELLY_NODE, deflateTarget)
			Endif
		Else
			Utility.wait(tme)
		EndIf
		
		if isAnal || isVaginal
			akActor.RemoveSpell(inflater.sr_inflateBurstSpell)
			SetFloatValue(akActor, inflater.INFLATION_AMOUNT, deflateTarget)
		endif
	Else
		Utility.wait(tme)
	endIf

	inflater.StopLeakage(akActor)
		
	log("Deflated to: " + deflateTarget +" (" +currentInflation + ")")
	if isAnal
		analCum -= cumAmount
		if analCum < 0.1
			analCum = 0.0
			UnsetFloatValue(akActor, inflater.LAST_TIME_ANAL)
		EndIf
		SetFloatValue(akActor, inflater.CUM_ANAL, analCum)
	Elseif isVaginal
		vagCum -= cumAmount
		if vagCum < 0.1
			vagCum = 0.0
			UnsetFloatValue(akActor, inflater.LAST_TIME_VAG)
		EndIf
		SetFloatValue(akActor, inflater.CUM_VAGINAL, vagCum)
	else
		oralCum -= cumAmount
		if oralCum < 0.1
			oralCum = 0.0
			UnsetFloatValue(akActor, inflater.LAST_TIME_ORAL)
		EndIf
		SetFloatValue(akActor, inflater.CUM_ORAL, oralCum)
	EndIf
	log("Cum amounts after deflation, v: "+ vagCum +", a: "+ analCum +", t: "+ (analCum+vagCum))
	
	if ( analCum <= 0.0 && vagCum <= 0.0 ) || deflateTarget <= 1.0
		If(inflater.config.bellyScale)
			if config.BodyMorph
				;inflater.SetBellyMorphValue(akActor, 0.0, inflater.PregnancyBelly)
				inflater.SetBellyMorphValue(akActor, 0.0, inflater.InflateMorph)
				if inflater.InflateMorph2 != ""
					inflater.SetBellyMorphValue(akActor, 0.0, inflater.InflateMorph2)
				endIf
				if inflater.InflateMorph3 != ""
					inflater.SetBellyMorphValue(akActor, 0.0, inflater.InflateMorph3)
				endif
			Else
				inflater.SetNodeScale(akActor, inflater.BELLY_NODE, 0.0)
			Endif
		EndIf
		SetFloatValue(akActor, inflater.CUM_ANAL, analCum)
		;SetFloatValue(akActor, inflater.CUM_VAGINAL, analCum)
		SetFloatValue(akActor, inflater.CUM_VAGINAL, vagCum)
		SetFloatValue(akActor, inflater.INFLATION_AMOUNT, 0.0)
		log("Deflated to removal of NIO scale")
		FormListRemove(inflater, inflater.INFLATED_ACTORS, akActor, true)
		inflater.RemoveFaction(akActor)
		inflater.UnencumberActor(akActor)
		If akActor == inflater.player
			inflater.sr_plugged.setValueInt(0)
		EndIf
	elseif OralCum <= 0.0 || deflateTarget <= 1.0
		If(inflater.config.bellyScale)
			if config.BodyMorph
				if inflater.InflateMorph4 != ""
					inflater.SetBellyMorphValue(akActor, 0.0, inflater.InflateMorph4)
				endIf
			endif
		endif
		SetFloatValue(akActor, inflater.CUM_ORAL, oralCum)
	Else
		inflater.UpdateFaction(akActor)
		inflater.EncumberActor(akActor)
	EndIf

	If cb != ""
		Int eid = ModEvent.Create(cb)
		ModEvent.PushForm(eid, akActor)
		ModEvent.PushFloat(eid, startVag)
		ModEvent.PushFloat(eid, startAn)
		ModEvent.Send(eid)
	EndIf
	
	If akActor == inflater.player
		float amount = 0.0
		If isAnal
			amount = analCum
		elseif isVaginal
			amount = vagCum
		else
			amount = oralCum
		EndIf
		inflater.SendPlayerCumUpdate(amount, isAnal)
	EndIf
	
	; Update arousal
	int eid = ModEvent.Create("slaUpdateExposure")
	ModEvent.PushForm(eid, akActor)
	ModEvent.PushFloat(eid, ((startVag - vagCum) + (startAn - analCum)) * 2.5)
	ModEvent.Send(eid)
EndFunction

Function Absorb()
	Actor akActor = GetActorReference()
	log("Absorbing")
	int Cumtype
	isAnal = !isVaginal
	
	float currentInflation

	float vagCum = GetFloatValue(akActor, inflater.CUM_VAGINAL)
	float analCum = GetFloatValue(akActor, inflater.CUM_ANAL)
	float oralCum = GetFloatValue(akActor, inflater.CUM_ORAL)

	; Starting values for the callback, current values can be fetched directly
	float startVag = vagCum
	float startAn = analCum
	float startOral = oralCum
	float totalInf
	float maxInflation = inflater.config.maxInflation
	
	;if isAnal || isVaginal
	;	currentInflation = GetFloatValue(akActor, inflater.INFLATION_AMOUNT)
	;	totalInf = vagCum + analCum
	;elseif isOral
	;	currentInflation = oralCum
	;	totalInf = oralCum
	;endif

	if isVaginal
		currentInflation = GetFloatValue(akActor, inflater.INFLATION_AMOUNT)
		totalInf = vagCum + analCum
		Cumtype = 1
	elseif isAnal
		currentInflation = GetFloatValue(akActor, inflater.INFLATION_AMOUNT)
		totalInf = vagCum + analCum
		Cumtype = 2
	elseif isOral
		currentInflation = oralCum
		totalInf = oralCum
		Cumtype = 3
	endif

	If (isAnal && analCum - cumAmount > 0.0 && vagCum > 0.0) || (!isAnal && vagCum - cumAmount > 0.0 && analCum > 0.0) || (isAnal && analCum - cumAmount > 0.0 && inflater.sexlab.GetGender(akActor)==0)
		maxInflation *= inflater.BURST_MULT
	EndIf

	float deflateTarget = totalInf - cumAmount
	log("deflateTarget = "+vagCum+" + "+analCum+" - "+cumAmount)
	
	If totalInf > maxInflation && deflateTarget < maxInflation
		log("Combined total higher than max and target lower than max! total: "+totalInf+", target: "+deflateTarget+", max: "+maxInflation, 1)
;		deflateTarget = totalInf - cumAmount;Duplicate
	EndIf
	
	float deflationAmount = currentInflation - deflateTarget
	int steps = Math.Ceiling(tme / 0.2);Time for animation
	float step

	;if isAnal || isVaginal
		step = deflationAmount / steps
	;elseif isOral
	;	step == inflationOralAmount / steps
	;endif

	;akActor.setfactionrank(sla_Arousal, akActor.getfactionrank(sla_Arousal) + 10) ; It doesn't work
	log("cumAmount: " + cumAmount)
	log("DefAmount: " + deflationAmount + ", total time: " + tme + ", steps: " + steps + ", step: " + step)
	
	;inflater.StartLeakage(akActor, isAnal, animate)
	If akActor.Is3DLoaded()
		inflater.Moan(akActor)
	EndIf
	if deflateTarget < maxInflation
		; Only actually deflate if total cum is less than max belly size
		If inflater.config.bellyScale
			If akActor.Is3DLoaded()
				while currentInflation > deflateTarget
					Utility.Wait(0.1)
					currentInflation -= step
					if config.BodyMorph && (isAnal || isVaginal)
						;inflater.SetBellyMorphValue(akActor, currentInflation, inflater.PregnancyBelly)
						inflater.SetBellyMorphValue(akActor, currentInflation, inflater.InflateMorph)
						if inflater.InflateMorph2 != ""
							inflater.SetBellyMorphValue(akActor, currentInflation, inflater.InflateMorph2)
						endIf
						if inflater.InflateMorph3 != ""
							inflater.SetBellyMorphValue(akActor, currentInflation, inflater.InflateMorph3)
						endif
					elseif config.BodyMorph && isOral
						if inflater.InflateMorph4 != ""
							inflater.SetBellyMorphValue(akActor, currentInflation, inflater.InflateMorph4)
						endif
					Else
						inflater.SetNodeScale(akActor, inflater.BELLY_NODE, currentInflation)
					Endif
				endWhile
			EndIf
			
			if config.BodyMorph && (isAnal || isVaginal)
				;inflater.SetBellyMorphValue(akActor, deflateTarget, inflater.PregnancyBelly)
				inflater.SetBellyMorphValue(akActor, deflateTarget, inflater.InflateMorph)
				if inflater.InflateMorph2 != ""
					inflater.SetBellyMorphValue(akActor, deflateTarget, inflater.InflateMorph2)
				endIf
				if inflater.InflateMorph3 != ""
					inflater.SetBellyMorphValue(akActor, deflateTarget, inflater.InflateMorph3)
				endif
			elseif config.BodyMorph && isOral
				if inflater.InflateMorph4 != ""
					inflater.SetBellyMorphValue(akActor, deflateTarget, inflater.InflateMorph4)
				endif
			Else
				inflater.SetNodeScale(akActor, inflater.BELLY_NODE, deflateTarget)
			Endif
		Else
			Utility.wait(tme)
		EndIf
		
		if isAnal || isVaginal
			akActor.RemoveSpell(inflater.sr_inflateBurstSpell)
			SetFloatValue(akActor, inflater.INFLATION_AMOUNT, deflateTarget)
		endif
	Else
		Utility.wait(tme)
	endIf

	;inflater.StopLeakage(akActor)
		
	log("Deflated to: " + deflateTarget +" (" +currentInflation + ")")
	if isAnal
		analCum -= cumAmount
		if analCum < 0.1
			analCum = 0.0
			UnsetFloatValue(akActor, inflater.LAST_TIME_ANAL)
			UnsetFloatValue(akActor, inflater.CUM_ANAL)
		else
			SetFloatValue(akActor, inflater.CUM_ANAL, analCum)
		EndIf
	Elseif isVaginal
		vagCum -= cumAmount
		if vagCum < 0.1
			vagCum = 0.0
			UnsetFloatValue(akActor, inflater.LAST_TIME_VAG)
			UnsetFloatValue(akActor, inflater.CUM_VAGINAL)
		else
			SetFloatValue(akActor, inflater.CUM_VAGINAL, vagCum)
		EndIf
	else
		oralCum -= cumAmount
		if oralCum < 0.1
			oralCum = 0.0
			UnsetFloatValue(akActor, inflater.LAST_TIME_ORAL)
		EndIf
		SetFloatValue(akActor, inflater.CUM_ORAL, oralCum)
	EndIf
	log("Cum amounts after deflation, v: "+ vagCum +", a: "+ analCum +", t: "+ (analCum+vagCum))
	
	if ( analCum <= 0.0 && vagCum <= 0.0 ) || deflateTarget <= 1.0
		If(inflater.config.bellyScale)
			if config.BodyMorph
				;inflater.SetBellyMorphValue(akActor, 0.0, inflater.PregnancyBelly)
				inflater.SetBellyMorphValue(akActor, 0.0, inflater.InflateMorph)
				if inflater.InflateMorph2 != ""
					inflater.SetBellyMorphValue(akActor, 0.0, inflater.InflateMorph2)
				endIf
				if inflater.InflateMorph3 != ""
					inflater.SetBellyMorphValue(akActor, 0.0, inflater.InflateMorph3)
				endif
			Else
				inflater.SetNodeScale(akActor, inflater.BELLY_NODE, 0.0)
			Endif
		EndIf
		SetFloatValue(akActor, inflater.CUM_ANAL, 0.0)
		SetFloatValue(akActor, inflater.CUM_VAGINAL, 0.0)
		SetFloatValue(akActor, inflater.INFLATION_AMOUNT, 0.0)
		log("Deflated to removal of NIO scale")
		FormListRemove(inflater, inflater.INFLATED_ACTORS, akActor, true)
		inflater.RemoveFaction(akActor)
		inflater.UnencumberActor(akActor)
		If akActor == inflater.player
			inflater.sr_plugged.setValueInt(0)
		EndIf
	elseif OralCum <= 0.0 || deflateTarget <= 1.0
		If(inflater.config.bellyScale)
			if config.BodyMorph
				if inflater.InflateMorph4 != ""
					inflater.SetBellyMorphValue(akActor, 0.0, inflater.InflateMorph4)
				endIf
			endif
		endif
		SetFloatValue(akActor, inflater.CUM_ORAL, 0.0)
	Else
		inflater.UpdateFaction(akActor)
		inflater.EncumberActor(akActor)
	EndIf

	If cb != ""
		Int eid = ModEvent.Create(cb)
		ModEvent.PushForm(eid, akActor)
		ModEvent.PushFloat(eid, startVag)
		ModEvent.PushFloat(eid, startAn)
		ModEvent.Send(eid)
	EndIf
	
	If akActor == inflater.player
		float amount = 0.0
		If isAnal
			amount = analCum
		elseif isVaginal
			amount = vagCum
		else
			amount = oralCum
		EndIf
		inflater.SendPlayerCumUpdate(amount, isAnal)
	EndIf
	
	; Update arousal
	int eid = ModEvent.Create("slaUpdateExposure")
	ModEvent.PushForm(eid, akActor)
	ModEvent.PushFloat(eid, ((startVag - vagCum) + (startAn - analCum)) * 2.5)
	ModEvent.Send(eid)
EndFunction

Event OnUpdate()
	If !running
		log("Thread timed out, clearing.")
		clear()
	EndIf
EndEvent

Function log(String msg, int lvl = 0)
	msg = GetActorReference().GetLeveledActorBase().GetName() + ": " + msg
	If lvl == 1
		inflater.warn(msg)
	ElseIf lvl == 2
		inflater.error(msg)
	Else
		inflater.log(msg)
	EndIf
EndFunction
