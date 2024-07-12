Scriptname slaFrameworkScr extends Quest

; FOLDSTART - Properties

slaMainScr Property slaMain Auto
slaConfigScr Property slaConfig Auto

FormList Property slaArousedVoiceList Auto
FormList Property slaUnArousedVoiceList Auto

Faction Property slaArousal Auto
Faction Property slaArousalBlocked Auto
Faction Property slaArousalLocked Auto
Faction Property slaExposure Auto
Faction Property slaExhibitionist Auto
Faction Property slaGenderPreference Auto
Faction Property slaTimeRate Auto
Faction Property slaFatigue Auto
Faction Property slaFrustration Auto
Faction Property slaExposureRate Auto
Faction Property slaTrauma Auto
Faction Property slaMasochism Auto
Faction Property slaExhibitionism Auto

GlobalVariable Property sla_NextMaintenance  Auto  

Int Property slaArousalCap = 100 AutoReadOnly

SexLabFramework Property sexLab auto

Actor Property playerRef Auto

; FOLDEND - Properties


Int Function GetVersion()
	Return slaMain.GetVersion()
EndFunction


; 0 - Male
; 1 - Female
; 2 - Both
; 3 - SexLab
Int Function GetGenderPreference(Actor who, Bool forConfig = False)

	If !who
		Return -2
	EndIf
			
	Int genderPreference = who.GetFactionRank(slaGenderPreference)
		
	If genderPreference < 0 || genderPreference == 3
    
		If forConfig
			Return 3
		EndIf

		genderPreference = -1
		
		;;; Doombell algorithm - I think this overprivileged bisexuality, so instead of 35 | 30 | 35, I have 40 | 20 | 40
        ; TODO - toggle for bisexuality so it can be disabled altogether for PC or NPCs seperately.
		Int ratio = SexLab.Stats.GetSexuality(who)
		if ratio > 60
			genderPreference =  1 - who.GetLeveledActorBase().GetSex()
		ElseIf ratio < 30
			genderPreference =  who.GetLeveledActorBase().GetSex()
		Else
			genderPreference =  2
		EndIf
	
		; FOLDSTART - Legacy notes
		;Old SLA code...
		;These following sexlab calls fail unless the user manually sets the Sexlab gender preference:
		;If (SexLab.Stats.IsStraight(who))
		;	If (who.GetLeveledActorBase().GetSex() == 0)
		;		Return 1
		;	Else
		;		Return 0
		;	EndIf
		;EndIf
		;If (SexLab.Stats.IsBisexual(who))
		;	Return 2
		;EndIf		
		
		;If (SexLab.Stats.IsGay(who))
		;	Return who.GetLeveledActorBase().GetSex()
		;EndIf
        ; FOLDEND - Legacy notes
	EndIf
	
	Return genderPreference
    
EndFunction


Function SetGenderPreference(Actor who, Int gender)

	If !who
		Return
	EndIf

	who.SetFactionRank(slaGenderPreference, gender)

    EndFunction


Bool Function IsActorExhibitionist(Actor who)

    Return who && who.GetFactionRank(slaExhibitionist) >= 0

EndFunction


Function SetActorExhibitionist(Actor who, Bool isExhibitionist = False)

	If !who
		Return
	EndIf
	
    Int factionRank = -2
    If isExhibitionist
        factionRank = 0
    EndIf

   	who.SetFactionRank(slaExhibitionist, factionRank)
    
EndFunction


; Returned values range 0.0 - 100.0
Float Function GetActorTimeRate(Actor who)

	If !who
		Return -2.0
	EndIf
	
	; Return default value if set not to decay
	If slaConfig.TimeRateHalfLife == 0 || slaConfig.sexOveruseEffect == 0
		Return 10.0
	EndIf
	
	Float timeRate = StorageUtil.GetFloatValue(who, "SLAroused.TimeRate", 10.0)
	Float daysSinceLastOrgasm = GetActorDaysSinceLastOrgasm(who)
	
	If LewdMod() > 0
		timeRate = timeRate * Math.pow(1.5, - daysSinceLastOrgasm / (((slaConfig.TimeRateHalfLife*10)*1.5 + (slaConfig.TimeRateHalfLife*(LewdMod()*0.05)) * SexLab.Stats.GetSkillLevel(who, "Lewd", 0.3))/10))
	Else
		timeRate = timeRate * Math.pow(1.5, - daysSinceLastOrgasm / slaConfig.TimeRateHalfLife)
	EndIf

	If timeRate < slaConfig.MinimumTimeRate
		timeRate = slaConfig.MinimumTimeRate
	ElseIf timeRate > 100.0
		timeRate = 100.0
	EndIf

	who.SetFactionRank(slaTimeRate, timeRate as Int)

	Return timeRate
    
EndFunction

Float Function GetActorFatigue(Actor who)

	If !who
		Return -2.0
	EndIf

	If slaConfig.FatigueHalfLife == 0 || slaConfig.Fatigue == 0
		Return 0.0
	EndIf

	Float fatigue = StorageUtil.GetFloatValue(who, "SLAroused.Fatigue", 0.0)
	Float daysSinceLastOrgasm = GetActorDaysSinceLastOrgasm(who)

	fatigue = fatigue * Math.pow(1.5, - daysSinceLastOrgasm / slaConfig.FatigueHalfLife)

	If fatigue < 0
		fatigue = 0
	ElseIf fatigue > 100
		fatigue = 100
	EndIf

	who.SetFactionRank(slaFatigue, fatigue as Int)

	Return fatigue

EndFunction

Float Function GetActorFrustration(Actor who)
	If !who
		Return -2.0
	EndIf

	If slaConfig.FrustrationHalfLife == 0 || slaConfig.Frustration == 0
		Return 0.0
	EndIf

	Float frustration = StorageUtil.GetFloatValue(who, "SLAroused.Frustration", 0.0)
	Float daysSinceLastSex = GetActorDaysSinceLastSex(who)

	If who.GetFactionRank(slaArousal) >= slaConfig.FrustrationGrowthThreshold
		If LewdMod() > 0
			frustration = frustration * 2 - frustration * Math.pow(1.5, - daysSinceLastSex / (((slaConfig.FrustrationGrowth*10)*1.5 + (slaConfig.FrustrationGrowth*(LewdMod()*0.05)) * SexLab.Stats.GetSkillLevel(who, "Lewd", 0.3))/10))
		Else
			frustration = frustration * 2 - frustration * Math.pow(1.5, - daysSinceLastSex / slaConfig.FrustrationGrowth)
		EndIf
	Else
		If LewdMod() > 0
			frustration = frustration * Math.pow(1.5, - daysSinceLastSex / (((slaConfig.FrustrationHalfLife*10)*1.5 + (slaConfig.FrustrationHalfLife*(LewdMod()*0.05)) * SexLab.Stats.GetSkillLevel(who, "Lewd", 0.3))/10))
		Else
			frustration = frustration * Math.pow(1.5, - daysSinceLastSex / slaConfig.FrustrationHalfLife)
		EndIf
	EndIf

	If frustration < 0
		frustration = 0
	ElseIf frustration > 100
		frustration = 100
	EndIf

	who.SetFactionRank(slaFrustration, frustration as Int)

	Return frustration

EndFunction

Float Function GetActorTrauma(Actor who)
	If !who
		Return -2.0
	EndIf

	If slaConfig.TraumaHalfLife == 0 || slaConfig.Trauma == 0
		Return 0.0
	EndIf

	Float Trauma = StorageUtil.GetFloatValue(who, "SLAroused.Trauma", 0.0)
	Float daysSinceLastRape = GetActorDaysSinceLastRape(who)

	If LewdMod() > 0
		Float TraumaHalfLifeModded = ((slaConfig.TraumaHalfLife*10)/2 - (slaConfig.TraumaHalfLife*(LewdMod()*0.05)) * SexLab.Stats.GetSkillLevel(who, "Lewd", 0.3))/10
		If TraumaHalfLifeModded < 0
			TraumaHalfLifeModded = 0
		EndIf
		If TraumaHalfLifeModded > 0
			Trauma = Trauma * Math.pow(1.5, - daysSinceLastRape / TraumaHalfLifeModded)
		Else
			Trauma = 0
		EndIf
	Else
		Trauma = Trauma * Math.pow(1.5, - daysSinceLastRape / slaConfig.TraumaHalfLife)
	EndIf

	If Trauma < 0
		Trauma = 0
	ElseIf Trauma > 100
		Trauma = 100
	EndIf

	who.SetFactionRank(slaTrauma, Trauma as Int)

	Return Trauma

EndFunction

Int Function LewdMod()
	If Game.GetModByName("SLSO.esp") < 255
		Return JsonUtil.GetIntValue("/SLSO/Config", "sl_sla_orgasmexposuremodifier")
	Else
		Return slaConfig.LewdMod
	EndIf
EndFunction

Float Function GetActorMasochism(Actor Who)
	If !Who
		Return -2
	EndIf
	If slaConfig.MasochismHalfLife == 0 || slaConfig.Masochism == 0
		Return 0
	EndIf
	Float Masochism = StorageUtil.GetFloatValue(Who, "SLAroused.Masochism", 0)
	Float daysSinceLastRape = GetActorDaysSinceLastRape(Who)
	If LewdMod() > 0
		Masochism = Masochism * Math.pow(1.5, - daysSinceLastRape / (((slaConfig.MasochismHalfLife*10)*1.5 + (slaConfig.MasochismHalfLife*(LewdMod()*0.05)) * SexLab.Stats.GetSkillLevel(who, "Lewd", 0.3))/10))
	Else
		Masochism = Masochism * Math.Pow(1.5, - daysSinceLastRape / slaConfig.MasochismHalfLife)
	EndIf
	If Masochism < 0
		Masochism = 0
	ElseIf Masochism > 100
		Masochism = 100
	EndIf
	Who.SetFactionRank(slaMasochism, Masochism as Int)
	Return Masochism
EndFunction

Float Function GetActorExhibitionism(Actor Who)
	If !Who
		Return -2
	EndIf
	If slaConfig.ExhibitionismHalfLife == 0 || slaConfig.Exhibitionism == 0
		Return 0
	EndIf
	Float Exhibitionism = StorageUtil.GetFloatValue(Who, "SLAroused.Exhibitionism", 0)
	Float daysSinceLastSeenNaked = GetActorDaysSinceLastSeenNaked(Who)
	If LewdMod() > 0
		Exhibitionism = Exhibitionism * Math.pow(1.5, - daysSinceLastSeenNaked / (((slaConfig.ExhibitionismHalfLife*10)*1.5 + (slaConfig.ExhibitionismHalfLife*(LewdMod()*0.05)) * SexLab.Stats.GetSkillLevel(who, "Lewd", 0.3))/10))
	Else
		Exhibitionism = Exhibitionism * Math.Pow(1.5, - daysSinceLastSeenNaked / slaConfig.ExhibitionismHalfLife)
	EndIf
	If Exhibitionism < 0
		Exhibitionism = 0
	ElseIf Exhibitionism > 100
		Exhibitionism = 100
	EndIf
	Who.SetFactionRank(slaExhibitionism, Exhibitionism as Int)
	Return Exhibitionism
EndFunction

; Expects inputs ranging from 0.0 - 100.0
; Returns -2.0 if bogus actor, or the input value
Float Function SetActorTimeRate(Actor who, Float timeRate)

	If !who
		Return -2.0
	EndIf

	If timeRate < slaConfig.MinimumTimeRate
		timeRate = slaConfig.MinimumTimeRate
	ElseIf timeRate > 100.0
		timeRate = 100.0
	EndIf
	
	Return StorageUtil.SetFloatValue(who, "SLAroused.TimeRate", timeRate)
    
EndFunction

Float Function SetActorFatigue(Actor who, Float fatigue)

	If !who
		Return -2.0
	EndIf

	If fatigue < 0
		fatigue = 0
	ElseIf fatigue > 100
		fatigue = 100
	EndIf

	Return StorageUtil.SetFloatValue(who, "SLAroused.Fatigue", fatigue)

EndFunction

Float function SetActorFrustration(Actor who, Float frustration)

	If !who
		Return -2.0
	EndIf

	If frustration < 0
		frustration = 0
	ElseIf Frustration > 100
		frustration = 100
	EndIf

	return StorageUtil.SetFloatValue(who, "SLAroused.Frustration", frustration)

EndFunction

Float Function SetActorTrauma(Actor who, Float Trauma)

	If !who
		Return -2.0
	EndIf

	If Trauma < 0
		Trauma = 0
	ElseIf Trauma > 100
		Trauma = 100
	EndIf

	Return StorageUtil.SetFloatValue(who, "SLAroused.Trauma", Trauma)

EndFunction

Float Function SetActorMasochism(Actor Who, Float Masochism)
	If !Who
		Return -2
	EndIf
	If Masochism < 0
		Masochism = 0
	ElseIf Masochism > 100
		Masochism = 100
	EndIf
	Return StorageUtil.SetFloatValue(Who, "SLAroused.Masochism", Masochism)
EndFunction

Float Function SetActorExhibitionism(Actor Who, Float Exhibitionism)
	If !Who
		Return -2
	EndIf
	If Exhibitionism < 0
		Exhibitionism = 0
	ElseIf Exhibitionism > 100
		Exhibitionism = 100
	EndIf
	Return StorageUtil.SetFloatValue(Who, "SLAroused.Exhibitionism", Exhibitionism)
EndFunction


; Modify time rate by a delta value
Float Function UpdateActorTimeRate(Actor who, Float timeRateDelta)

	If !who
		Return -2.0
	EndIf
	
	Float timeRate = GetActorTimeRate(who) + timeRateDelta
	Return SetActorTimeRate(who, timeRate)
    
EndFunction

Float Function UpdateActorFatigue(Actor who, Float fatigueDelta)

	If !who
		Return -2.0
	EndIf

	Float fatigue = GetActorFatigue(who) + fatigueDelta
	Return SetActorFatigue(who, fatigue)

EndFunction

Float function UpdateActorFrustration(Actor who, Float frustrationDelta)

	If !who
		Return -2.0
	EndIf

	float frustration = GetActorFrustration(who) + frustrationDelta
	Return SetActorFrustration(who, frustration)

EndFunction

Float Function UpdateActorTrauma(Actor who, Float TraumaDelta)

	If !who
		Return -2.0
	EndIf

	Float Trauma = GetActorTrauma(who) + TraumaDelta
	Return SetActorTrauma(who, Trauma)

EndFunction

Float Function UpdateActorMasochism(Actor Who, Float MasochismDelta)
	If !Who
		Return -2
	EndIf
	Float Masochism = GetActorMasochism(Who) + MasochismDelta
	Return SetActorMasochism(Who, Masochism)
EndFunction

Float Function UpdateActorExhibitionism(Actor Who, Float ExhibitionismDelta)
	If !Who
		Return -2
	EndIf
	Float Exhibitionism = GetActorExhibitionism(Who) + ExhibitionismDelta
	Return SetActorExhibitionism(Who, Exhibitionism)
EndFunction


Float Function GetActorExposureRate(Actor who)

	If !who
		Return -2.0
	EndIf
	
	float exposureRate = StorageUtil.GetFloatValue(who, "SLAroused.ExposureRate", -2.0)
	
	; set default value
	If exposureRate < 0.0
		VoiceType actorVoice = who.GetLeveledActorBase().GetVoiceType()
	
        ; Basing the default off voice setting is costly, encourages conflicts, and is unexpected (leads to bugs)
        ; Having to do this on a seemingly PASSIVE get function is troublesome to other mods - GET should NOT have MASSIVE SIDE EFFECTS!!!
		If actorVoice
			If (slaArousedVoiceList.Find(actorVoice) >= 0)
				exposureRate = slaConfig.DefaultExposureRate + 1.0
			ElseIf (slaUnArousedVoiceList.Find(actorVoice) >= 0)
				exposureRate = slaConfig.DefaultExposureRate - 1.0
			Else
				exposureRate = slaConfig.DefaultExposureRate
			EndIf
		Else
			exposureRate = slaConfig.DefaultExposureRate
		EndIf
	EndIf
	
	If (exposureRate < 0.0)
		exposureRate = 0.0
	ElseIf (exposureRate > 10.0)
		exposureRate = 10.0
	EndIf
	
	Return exposureRate
    
EndFunction


Float Function SetActorExposureRate(Actor who, Float exposureRate)

	If !who
		Return -2.0
	EndIf
	
    ; Integer version of exposure rate with single-digit fixed point representation
	Int factionRank = (exposureRate * 10.0) as Int
	
	If (exposureRate < -100.0)
		; Reset values
		exposureRate = -2.0
		factionRank = -2
	ElseIf (exposureRate < 0.0)
		exposureRate = 0.0
		factionRank = 0
	ElseIf (exposureRate > 10.0)
		exposureRate = 10.0
		factionRank = 100
	EndIf
	
	who.SetFactionRank(slaExposureRate, factionRank)
    
	Return StorageUtil.SetFloatValue(who, "SLAroused.ExposureRate", exposureRate)
    
EndFunction


Float Function UpdateActorExposureRate(Actor who, Float exposureRateDelta)

	If !who
		Return -2.0
	EndIf
	
	Float newExposureRate = GetActorExposureRate(who) + exposureRateDelta
    
	Return SetActorExposureRate(who, newExposureRate)
    
EndFunction


; NASTY SIDE EFFECTS of EXPOSURE RECALC HIDDEN INSIDE seemingly innocuous GET operation!!!
; Driving updates off get operations can cause excessive recalculation that is trivially avoidable.
; And is a potential cause of snowballing accuracy errors ... hmmm ... sounds familiar.
; Really need to STOP this toxic pattern.
Int Function GetActorExposure(Actor who)

	If !who
		Return -2
	EndIf

	Float actorExposure = StorageUtil.GetFloatValue(who, "SLAroused.ActorExposure", -2.0)
    Float now = Utility.GetCurrentGameTime()

	; Set initial exposure if needed	
	If (actorExposure < -1.0)
    
        actorExposure = SlaInternals.GetRandomFloat(0.0, 50.0)
            
		StorageUtil.SetFloatValue(who, "SLAroused.ActorExposure", actorExposure)
		StorageUtil.SetFloatValue(who, "SLAroused.ActorExposureDate", now)
        
    Else
    
        slax.Info("SLAX - GetActorExposure BEGIN " + who.GetLeveledActorBase().GetName() + " is " + actorExposure)
        Float actorExposureTime = StorageUtil.GetFloatValue(who, "SLAroused.ActorExposureDate")
        actorExposure = SlaInternals.UpdateExposure(actorExposure, 0.0, slaConfig.ExposureHalfLife, now, actorExposureTime)
        slax.Info("SLAX - GetActorExposure END   " + who.GetLeveledActorBase().GetName() + " returns " + actorExposure)        
	EndIf
	
    ; Store this but not the exposure itself? My head is exploding. Now we've lost all data integrity on arousal. What's the source of truth?
    ; This insanity goes away if GetActorExposure does what it says in the name, not something different.
    Int intActorExposure = actorExposure As Int

	who.SetFactionRank(slaExposure, intActorExposure)
	
	Return intActorExposure
    
EndFunction


Int Function SetActorExposure(Actor who, Int newActorExposure)

	If !who
		Return -2
	EndIf
    
    slax.Info("SLAX - SetActorExposure - " + who.GetLeveledActorBase().GetName() + " to " + newActorExposure)
		
	If (newActorExposure < 0)
		newActorExposure = 0
	ElseIf (newActorExposure > 100)
		newActorExposure = 100
	EndIf

	StorageUtil.SetFloatValue(who, "SLAroused.ActorExposure", newActorExposure as Float)
	StorageUtil.SetFloatValue(who, "SLAroused.ActorExposureDate", Utility.GetCurrentGameTime())
	
	; Force update of resultant arousal - sure, we should do this - but who would expect it to be by GetActorArousal() right?
    ; Laughs all around!
    ; TODO: This needs to STOP.
	GetActorArousal(who)
	
	Return newActorExposure
    
EndFunction


Int Function UpdateActorExposure(Actor who, Int exposureDelta, String debugMessage = "")

    Return FloatUpdateActorExposure(who, exposureDelta As Float, debugMessage) As Int

EndFunction


Float Function FloatUpdateActorExposure(Actor who, Float exposureDelta, String debugMessage = "")

    If !who || who.IsChild()
        Return -2
    EndIf
    
    Float actorExposure = StorageUtil.GetFloatValue(who, "SLAroused.ActorExposure", -2.0)

    If debugMessage
        slax.Info("SLAX - UpdateActorExposure - BEGIN " + who.GetLeveledActorBase().GetName() + " from " + actorExposure + " by " + exposureDelta + " because " + debugMessage)
    EndIf

    Float actorExposureDelta = exposureDelta * GetActorExposureRate(who)
    Float actorExposureTime = StorageUtil.GetFloatValue(who, "SLAroused.ActorExposureDate")
    Float now = Utility.GetCurrentGameTime()

    ; Simply replacing the old RandomFloat code makes this far more responsive, but we can do more...
    actorExposure = SlaInternals.UpdateExposure(actorExposure, actorExposureDelta, slaConfig.ExposureHalfLife, now, actorExposureTime)

    StorageUtil.SetFloatValue(who, "SLAroused.ActorExposure", actorExposure)
    StorageUtil.SetFloatValue(who, "SLAroused.ActorExposureDate", now)

    Int intActorExposure = actorExposure as Int

   	who.SetFactionRank(slaExposure, intActorExposure)

    ; Force update resultant arousal
    GetActorArousal(who)
    
    If debugMessage
        slax.Info("SLAX - UpdateActorExposure - END   " +  who.GetLeveledActorBase().GetName() + " to " + actorExposure + " (int) " + intActorExposure)
    EndIf

    Return actorExposure
        
EndFunction

; For reference - this is the old SLA function.  It was replaced in SLAR with one proposed by BeamerMiasma in this topic:
; http://www.loverslab.com/topic/37652-sexlab-aroused-redux/?p=1300702
; to remove some rounding errors when converting between float and Int ... GetActorExposure was the main culprit.
; I'm not going to keep all the old comments about who wrote what line, like we're trying to recreate Blame via comments.
; That commentary is not highly relevant at this point; those update models are a legacy burden that is only approximately supported.
; Historical contributors are in the mod credits; that's what the mod credits are for.
;
;Int Function UpdateActorExposure(Actor who, Int val, String debugMsg = "")
;	If (who == None)
;		Return -2
;	EndIf
;	
;	If (who.IsChild())
;		Return -2
;	EndIf
;	
;	Int valFix = ((val as Float) * GetActorExposureRate(who)) as Int
;	Int newRank = GetActorExposure(who) + valFix
;	
;	Debug.Trace(self + ": " + who.GetLeveledActorBase().GetName() + " got " + valFix + " exposure for " + debugMsg)
;	
;	Return SetActorExposure(who, newRank)
;EndFunction


Float Function GetActorDaysSinceLastOrgasm(Actor who)

	If !who
		Return -2.0
	EndIf
	
	Float lastOrgasmTime = StorageUtil.GetFloatValue(who, "SLAroused.LastOrgasmDate", -2.0)
	
	If (lastOrgasmTime < -1.0)
        ; Orgasm not yet; set try SexLab
		Return SexLab.Stats.DaysSinceLastSex(who)
	EndIf
	
	Return Utility.GetCurrentGameTime() - lastOrgasmTime
    
EndFunction

Float Function GetActorDaysSinceLastRape(Actor who)

	If !who
		Return -2.0
	EndIf
	
	Float lastRapeTime = StorageUtil.GetFloatValue(who, "SLAroused.LastRapeDate", 0)
	
	Return Utility.GetCurrentGameTime() - lastRapeTime
    
EndFunction

Float Function GetActorTimeSinceLastSeenNaked(Actor Who)
	If !Who
		Return -2
	EndIf
	Float lastSeenNakedTime = StorageUtil.GetFloatValue(Who, "SLAroused.LastSeenNakedTime", 0)
	Return Utility.GetCurrentRealTime() - lastSeenNakedTime
EndFunction

Float Function GetActorDaysSinceLastSeenNaked(Actor Who)
	If !Who
		Return -2
	EndIf
	Float lastSeenNakedTime = StorageUtil.GetFloatValue(Who, "SLAroused.LastSeenNakedDate", 0)
	Return Utility.GetCurrentGameTime() - lastSeenNakedTime
EndFunction


Function UpdateActorOrgasmDate(Actor who)

	If who
        If LewdMod() > 0
            Float FrustrationLossModded = -slaConfig.FrustrationLoss as Float/2 + (slaConfig.FrustrationLoss*(LewdMod()*0.05)) * SexLab.Stats.GetSkillLevel(who, "Lewd", 0.3)
            If FrustrationLossModded > 0
                FrustrationLossModded = 0
            EndIf
            UpdateActorFrustration(who, FrustrationLossModded)
        Else
            UpdateActorFrustration(who, -slaConfig.FrustrationLoss)
        EndIf
		If !slaConfig.MBonUsesSLGender && who.GetLeveledActorBase().GetSex() == 0
			UpdateActorFatigue(who, slaConfig.Fatigue + slaConfig.FatigueMaleBonus)
		ElseIf slaConfig.MBonUsesSLGender && (SexLab.GetGender(who) == 0 || SexLab.GetGender(who) == 2)
			UpdateActorFatigue(who, slaConfig.Fatigue + slaConfig.FatigueMaleBonus)
		Else
			UpdateActorFatigue(who, slaConfig.Fatigue)
		EndIf
		If LewdMod() > 0
			UpdateActorTimeRate(who, slaConfig.sexOveruseEffect as Float - (slaConfig.sexOveruseEffect as Float/2 - (slaConfig.sexOveruseEffect*(LewdMod()*0.05)) * SexLab.Stats.GetSkillLevel(who, "Lewd", 0.3)))
		Else
			UpdateActorTimeRate(who, slaConfig.SexOveruseEffect)
		EndIf
        StorageUtil.SetFloatValue(who, "SLAroused.LastOrgasmDate", Utility.GetCurrentGameTime())
    EndIf
    
EndFunction


Bool Function IsActorArousalLocked(Actor who)

    Return !who || who.GetFactionRank(slaArousalLocked) >= 0

EndFunction


Function SetActorArousalLocked(Actor who, Bool isLocked)
	
    If who
        Int lockedRank = -2
        If isLocked
            lockedRank = 0
        EndIf
        
       	who.SetFactionRank(slaArousalLocked, lockedRank)
	EndIf
    
EndFunction


Bool Function IsActorArousalBlocked(Actor who)

	Return !who || who.GetFactionRank(slaArousalBlocked) >= 0

EndFunction


Function SetActorArousalBlocked(Actor who, Bool isBlocked)

	If who
        Int blockedRank = -2
        If isBlocked
            blockedRank = 0
        EndIf

       	who.SetFactionRank(slaArousalBlocked, blockedRank)
	EndIf
    
EndFunction


; The epitome of the "get operation is almost pure side effects" anti-pattern.
Int Function GetActorArousal(Actor who)

	If !who || IsActorArousalBlocked(who) || who.IsChild()

		who.SetFactionRank(slaArousal, -2)
		Return -2

	EndIf

	If IsActorArousalLocked(who)

		Return who.GetFactionRank(slaArousal)

	EndIf

	Float DaysPassedSinceLastOrgasm = Utility.GetCurrentGameTime() - GetActorDaysSinceLastOrgasm(who)

	If who != playerRef && slaConfig.MinDaysWithoutSex != 0 && DaysPassedSinceLastOrgasm >= slaConfig.MinDaysWithoutSex \
	&& (!StorageUtil.HasFloatValue(who, "SlAroused.LastOrgasmDateAdjustmentDate") || StorageUtil.GetFloatValue(who, "SlAroused.LastOrgasmDateAdjustmentDate") >= slaConfig.MinDaysWithoutSex)
		Float RandomDateForOrgasm = Utility.RandomFloat(Utility.GetCurrentGameTime() - slaConfig.MinDaysWithoutSex, Utility.GetCurrentGameTime())
		StorageUtil.SetFloatValue(who, "SLAroused.LastOrgasmDate", RandomDateForOrgasm)
		StorageUtil.SetFloatValue(who, "SLAroused.LastOrgasmDateAdjustmentDate", Utility.GetCurrentGameTime())
	EndIf

	If GetActorTrauma(who) - GetActorMasochism(who) > 0
		who.SetFactionRank(slaArousal, 0)
		UpdateSOSPosition(who, 0)
		If who == playerRef
			slaMain.OnPlayerArousalUpdate(0)
		EndIf
		Return 0
	EndIf

	Float TimeArousal = GetActorDaysSinceLastOrgasm(who) * ((GetActorTimeRate(who) + GetActorFrustration(who)) - (GetActorFatigue(who)))
	If TimeArousal < -100
		TimeArousal = -100
	EndIf
	Int newRank = TimeArousal as Int + GetActorExposure(who)

	If (newRank < 0)
		newRank = 0
	ElseIf (newRank > slaArousalCap)
		newRank = slaArousalCap
	EndIf

	who.SetFactionRank(slaArousal, newRank)
	UpdateSOSPosition(who, newRank)
	
	If who == playerRef

		slaMain.OnPlayerArousalUpdate(newRank)

	EndIf

	Return newRank

EndFunction


Actor Function GetMostArousedActorInLocation()

	Return slaConfig.slaMostArousedActorInLocation
    
EndFunction


Function UpdateSOSPosition(Actor who, Int actorArousal)

	If !who || !slaConfig.IsUseSOS
		Return
	ElseIf who.IsInFaction(SexLab.AnimatingFaction)
		Return
	EndIf
	
	Int erectionPosition = (actorArousal / 4) - 14;
	HandleErection(who,  erectionPosition)
    
EndFunction


Function HandleErection(Actor who, Int position)

	If position < -9
		Debug.SendAnimationEvent(who, "SOSFlaccid")
	ElseIf position > 9
		Debug.SendAnimationEvent(who, "SOSBend9")
	Else
		Debug.SendAnimationEvent(who, "SOSBend" + position)
	EndIf
    
EndFunction


; *************************************
; Deprecated SexLab wrapper functions
; *************************************
Int Function GetActorHoursSinceLastSex(Actor who)

	If !who
		Return -2
	EndIf
	
	Return SexLab.Stats.HoursSinceLastSex(who) as Int
    
EndFunction


Float Function GetActorDaysSinceLastSex(Actor who)

	If !who
		Return -2.0
	EndIf
	
	Return SexLab.Stats.DaysSinceLastSex(who)
    
EndFunction
