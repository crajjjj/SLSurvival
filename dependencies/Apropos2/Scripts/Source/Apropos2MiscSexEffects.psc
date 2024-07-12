ScriptName Apropos2MiscSexEffects Extends Apropos2SystemLibrary

Import Apropos2Util
Import ApUtil

Faction Property HadChangedAnimationFaction Auto

String Property TimesStageGoBackStorage = "TimesStageGoBack" AutoReadOnly

Function Setup()
    Parent.Setup()
    Debug("Setup")
    GameLoaded()
EndFunction

Function GameLoaded()
    Debug("GameLoaded")

    UnregisterForEvents()

    If !Config.CheckSystemComponent("JContainers")
        Return
    EndIf

    RegisterForEvents()
    Debug("GameLoaded - Ready")
EndFunction

Function UnregisterForEvents()
    Debug("UnregisterForEvents")
    UnregisterForAllModEvents()
EndFunction

Function RegisterForEvents()
    Debug("RegisterForEvents")
    RegisterForModEvent("HookStageStart", "StageStart")
    RegisterForModEvent("HookLeadInStart", "StageStart")
    RegisterForModEvent("HookOrgasmStart", "OrgasmStart")
    RegisterForModEvent("HookAnimationStart", "AnimationStart")
    RegisterForModEvent("HookAnimationEnd", "AnimationEnd")
EndFunction

Bool Function CheckCanRun(String meth)
    Debug(meth)    
    If !Self || !SexLab || !Config
        Error("Critical error - " + meth)
        Return False
    EndIf    

    If !Config.Enabled
        Debug("Config.Enabled=" + Config.Enabled)        
        Return False
    EndIf    
    Return True
EndFunction

Event AnimationStart(int threadID, bool HasPlayer)
    If !CheckCanRun("AnimationStart")
        Return
    EndIf
    ; DO NOT REMOVE THESE EMPTY SUBSCRIPTIONS - THEY FOR SOME REASON make the ModEvent subs in Apropos2Framework work.
EndEvent

Event OrgasmStart(int threadId, bool HasPlayer)
    If !CheckCanRun("OrgasmStart")
        Return
    EndIf
    ; DO NOT REMOVE THESE EMPTY SUBSCRIPTIONS - THEY FOR SOME REASON make the ModEvent subs in Apropos2Framework work.
EndEvent

Event AnimationEnd(int threadId, bool HasPlayer)
    If !CheckCanRun("AnimationEnd")
        Return
    EndIf

    If Config.GoBackAggressorFactor == 0 ; is feature turned off
        Return
    EndIf

    SslThreadController thread = SexLab.GetController(threadID)
    SslBaseAnimation animation = thread.Animation
    Actor[] actorList = thread.Positions

    If actorList.length != 2
        return
    EndIf

    Actor victim = GetVictimFromList(thread, actorList)

    If !victim
        ; If there was no victim found, and the animation was not tagged as aggressive then quit.
        If !animation.HasTag(AGGRESSIVE) && !animation.HasTag(ROUGH) && !animation.HasTag(FORCED)
            Return
        EndIf
        ; There was no victim found, so just make assumptions.
        victim = ActorList[0]
    EndIf

    If !victim
        Return
    EndIF

    SetIntValue(victim, TimesStageGoBackStorage, 0)
    Trace("Victim: " + victim.GetDisplayName() + " reset stage goback counter.")

EndEvent

Event StageStart(int threadID, bool HasPlayer)
    If !CheckCanRun("StageStart")
        Return
    EndIf

    If Config.RapeAnimationSwitchChance == 0 && Config.GoBackAggressorFactor == 0
    	Return
    EndIf

    SslThreadController thread = SexLab.GetController(threadID)
    SslBaseAnimation animation = thread.Animation
    Actor[] actorList = thread.Positions

	If actorList.length != 2
		return
	EndIf

	Actor aggressor
    Actor victim

    Int i = 0
    While i < actorList.Length
    	Actor test = actorList[i]
    	If thread.IsVictim(test) 
    		victim = test
    	Else
    		aggressor = test
    	EndIf
    	i += 1
    EndWhile

    If !victim
    	; If there was no victim found, and the animation was not tagged as aggressive then quit.
    	If !animation.HasTag(AGGRESSIVE) && !animation.HasTag(ROUGH) && !animation.HasTag(FORCED)
    		Return
    	EndIf
    	; There was no victim found, so just make assumptions.
    	victim = ActorList[0]
    	aggressor = ActorList[1]
    EndIf

    If !victim || !aggressor
        Return
    EndIF

    String victimName = victim.GetDisplayName()
    String aggressorName = aggressor.GetDisplayName()

    Trace("Victim: " + victimName)
    Trace("Aggressor: " + aggressorName)

    Int stage = thread.Stage

	If stage < 2 && Config.RapeAnimationSwitchChance > 0
		aggressor.SetFactionRank(HadChangedAnimationFaction, -2)
	EndIf

    Bool currentHasFurnOrObject = animation.HasTag("AnimObject") || animation.HasTag("Furniture") || StringContains(animation.Name, "Table") || StringContains(animation.Name, "Throne") || StringContains(animation.Name, "Chair")

	; switch animation
	If (2 <= stage && stage <= 3 && d100() < Config.RapeAnimationSwitchChance && aggressor.GetFactionRank(HadChangedAnimationFaction) < 0)
        If !currentHasFurnOrObject
    		thread.ChangeAnimation(Utility.RandomInt(1, 2) < 2)
    		aggressor.SetFactionRank(HadChangedAnimationFaction, 0)
        EndIf
	EndIf

    Int timesAlreadyGoneBack = GetIntValue(victim, TimesStageGoBackStorage)
    Trace("timesAlreadyGoneBack: " + timesAlreadyGoneBack)
    If timesAlreadyGoneBack > Config.MaxGoBacksPerAnimation
        Debug("...exceeds configured maximum times to go back one stage...")
        Return
    EndIf
    Float scale = (Config.GoBackAggressorFactor As Float) / 100.0
    ; Add 1 for actors that have been zeroed out accidentally by Aroused.
    ; Allows calculations to proceed.
    Int aggressorArousal = SlaUtil.GetActorArousal(aggressor) + 1
    Int ar = (aggressorArousal * scale) As Int
    Trace("scaled arousal: " + ar)
	If (stage > 1) && (d100() < ar)

        Debug("Aggressor moving animation back one stage...")
		thread.AdvanceStage(true)
        Trace("timesAlreadyGoneBack: " + timesAlreadyGoneBack)
        SetIntValue(victim, TimesStageGoBackStorage, timesAlreadyGoneBack + 1)

        String[] parts = BuildSexPartsFromAnimation(animation)
        Bool isPlayer = (victim == PlayerRef)
        String effectiveVoice = Config.GetEffectiveNarrativeVoice(isPlayer)
        String defaultSexPart = ""
        If parts.Length > 0 
            defaultSexPart = parts[0]
        EndIf

        String partner
        If thread.HasCreature
            partner = GetCreatureFromAnimation(animation, aggressor)
        Else
            partner = "Male"
        EndIf

        Descriptions.DisplayFemaleActorGoBackDescriptions(thread, partner, True, aggressor, victim, effectiveVoice, defaultSexPart)
	EndIf 

EndEvent

Function Log(String msg)
    Config.Log(msg, source="Apropos2MiscSexEffects")
EndFunction

Function Debug(String msg)
    Config.Debug(msg, source="Apropos2MiscSexEffects")
EndFunction

Function Trace(String msg)
    If Config.TraceMessagesEnabled
        Config.Debug(msg, source="Apropos2MiscSexEffects")
    EndIf
EndFunction

