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

GlobalVariable Property sla_NextMaintenance Auto  

Int Property slaArousalCap = 100 AutoReadOnly

SexLabFramework Property sexLab auto

Actor Property playerRef Auto

; FOLDEND - Properties

; New API

int Property DecayFunction
	int function Get()
        return 1
	endFunction
endProperty

int Property LinearFunction 
	int function Get()
        return 2
	endFunction
endProperty

float function GetDynamicEffectValue(Actor who, string effectId)
	return slaMain.GetDynamicEffectValueByName(who, effectId)
endFunction

function SetDynamicArousalEffect(Actor who, string effectId, float initialValue, int functionId, float param, float limit)
	slaMain.SetDynamicArousalEffect(who, effectId, initialValue, functionId, param, limit)
endFunction

function ModDynamicArousalEffect(Form who, string effectId, float modifier, float limit)
	slaMain.ModDynamicArousalEffect(who, effectId, modifier, limit)
endFunction
; New API - End

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
	
	EndIf
	
	Return genderPreference
    
EndFunction


Function SetGenderPreference(Actor who, Int gender)

	If !who
		Return
	EndIf

	If slaGenderPreference && !who.IsInFaction(slaGenderPreference)
		who.AddToFaction(slaGenderPreference)
	EndIf
	
	If slaGenderPreference && who.IsInFaction(slaGenderPreference)
		who.SetFactionRank(slaGenderPreference, gender)
	EndIf

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

    If slaExhibitionist && !who.IsInFaction(slaExhibitionist)
    	who.AddToFaction(slaExhibitionist)
    EndIf
    
    If slaExhibitionist && who.IsInFaction(slaExhibitionist)
    	who.SetFactionRank(slaExhibitionist, factionRank)
    EndIf
    
EndFunction


Float Function GetActorExposureRate(Actor who)
{Deprecated}
	Return -2.0
EndFunction


Float Function SetActorExposureRate(Actor who, Float exposureRate)
	{Deprecated}
	Return -2.0
EndFunction


Float Function UpdateActorExposureRate(Actor who, Float exposureRateDelta)
	{Deprecated}
	Return -2.0
EndFunction


Int Function GetActorExposure(Actor who)
	{Deprecated}
	return slaMain.defaultPlugin.GetExposureLegacy(who) as Int
EndFunction


Int Function SetActorExposure(Actor who, Int newActorExposure)
	{Deprecated}
	int diff = newActorExposure - GetActorExposure(who)
    slaMain.defaultPlugin.ModExposureLegacy(who, diff)
	Return GetActorExposure(who)
EndFunction


Int Function UpdateActorExposure(Actor who, Int exposureDelta, String debugMessage = "")
	{Deprecated}
    Return slaMain.defaultPlugin.ModExposureLegacy(who, exposureDelta) As Int
EndFunction

Float Function GetActorTimeRate(Actor who)
	{Deprecated}
	return 1.0
EndFunction
 
Float Function UpdateActorTimeRate(Actor who, Float timeRateDelta)
	{Deprecated}
	return 0.0
EndFunction

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
	
	Float lastRapeTime = StorageUtil.GetFloatValue(who, "SLAroused.LastRapeDate", -2.0)
	
	If (lastRapeTime < -1.0)
        ; Rape not yet; set try SexLab
		Return SexLab.Stats.DaysSinceLastSex(who)
	EndIf
	
	Return Utility.GetCurrentGameTime() - lastRapeTime
    
EndFunction


Function UpdateActorOrgasmDate(Actor who)

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
        
        If slaArousalLocked && !who.IsInFaction(slaArousalLocked)
        	who.AddToFaction(slaArousalLocked)
        EndIf

        If slaArousalLocked && who.IsInFaction(slaArousalLocked)
        	who.SetFactionRank(slaArousalLocked, lockedRank)
        EndIf
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

        If slaArousalBlocked && !who.IsInFaction(slaArousalBlocked)
        	who.AddToFaction(slaArousalBlocked)
        EndIf

        If slaArousalBlocked && who.IsInFaction(slaArousalBlocked)
        	who.SetFactionRank(slaArousalBlocked, blockedRank)
        EndIf
	EndIf
    
EndFunction

int Function GetActorArousal(Actor who)
	int value = slaInternalModules.GetArousal(who) as int
	return PapyrusUtil.ClampInt(value, 0, 100)
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
