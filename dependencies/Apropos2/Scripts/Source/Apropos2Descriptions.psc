ScriptName Apropos2Descriptions Extends Apropos2SystemLibrary
{Apropos Descriptions for SexLab Animations}

Import Apropos2Util
Import ApUtil

Int PAUSE_AFTER_VIRGINITY_LOST = 2 ; seconds

Function Setup()
    Parent.Setup()
    Log("Setup")
EndFunction

String Function GetWearTearVaginal(Actor anActor)
    String res = ActorsLib.GetWearTearVaginal(anActor)
    ; If the actor isn't being tracked for W&T
    ; make sure we delegate back to IsVaginalVirgin 
    ; to return a lookup for level0 W&T (virgin) descriptor
    If res == "" && Framework.IsVaginalVirgin(anActor)
        res = Database.GetRandomWearAndTearDescriptor(0)
    EndIf
    Return res
EndFunction

String Function GetWearTearAnal(Actor anActor)
    String res = ActorsLib.GetWearTearAnal(anActor)
    ; If the actor isn't being tracked for W&T
    ; make sure we delegate back to IsVaginalVirgin 
    ; to return a lookup for level0 W&T (virgin) descriptor    
    If res == "" && Framework.IsAnalVirgin(anActor)
        res = Database.GetRandomWearAndTearDescriptor(0)
    EndIf
    Return res    
EndFunction

String Function GetWearTearOral(Actor anActor)
    String res = ActorsLib.GetWearTearOral(anActor)
    ; If the actor isn't being tracked for W&T
    ; make sure we delegate back to IsVaginalVirgin 
    ; to return a lookup for level0 W&T (virgin) descriptor    
    If res == "" && Framework.IsOralVirgin(anActor)
        res = Database.GetRandomWearAndTearDescriptor(0)
    EndIf
    Return res      
EndFunction

Int Function GenerateOralTokenMap(Actor primaryFemaleActor, Actor activeActor)
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()
    String activeName = activeActor.GetDisplayName()
    String wearTearOral = ActorsLib.GetWearTearOral(primaryFemaleActor)    
    Int mapId = GenerateStandardTokenMap(primaryFemaleName, activeName)
    JMap.setStr(mapId, WEARTEAR_ORAL_TOKEN, wearTearOral)
    Return mapId    
EndFunction

Int Function GenerateAnalTokenMap(Actor primaryFemaleActor, Actor activeActor)
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()
    String activeName = activeActor.GetDisplayName()
    String wearTearAnal = ActorsLib.GetWearTearAnal(primaryFemaleActor)
    Int mapId = GenerateStandardTokenMap(primaryFemaleName, activeName)
    JMap.setStr(mapId, WEARTEAR_ANAL_TOKEN, wearTearAnal)
    Return mapId
EndFunction

Int Function GenerateVaginalTokenMap(Actor primaryFemaleActor, Actor activeActor = None)
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()
    String activeName = ""
    If activeActor
        activeName = activeActor.GetDisplayName()
    EndIf
    String wearTearVaginal = ActorsLib.GetWearTearVaginal(primaryFemaleActor)
    Int mapId = GenerateStandardTokenMap(primaryFemaleName, activeName)
    JMap.setStr(mapId, WEARTEAR_VAGINAL_TOKEN, wearTearVaginal)
    Return mapId
EndFunction

Int Function GenerateStandardTokenMap(String primaryName, String activeName = "")
    Int mapId = JMap.object()
    If activeName
        JMap.setStr(mapId, ACTIVE_NAME_TOKEN, activeName)
    EndIf   
    JMap.setStr(mapId, PRIMARY_NAME_TOKEN, primaryName)

    AddAllSynonymTokensToMap(mapId)

    Return mapId
EndFunction

Function AddArousalTextsToMap(Int mapId, Actor primaryFemaleActor, Bool isPrimaryActorVictim = False, Actor activeActor = None)

    Int primaryArousalIndex = GetFactoredArousalIndex(primaryFemaleActor, False)
    Int activeArousalIndex
    If activeActor
        activeArousalIndex = GetFactoredArousalIndex(activeActor, isPrimaryActorVictim)
    EndIf

    String femaleArousalText = Database.RandomArousal(FEMALE_AROUSAL_TOKEN, primaryArousalIndex)
    String readinessText = Database.RandomArousal(READINESS_TOKEN, primaryArousalIndex)
    String maleArousalText
    If activeActor
        maleArousalText = Database.RandomArousal(MALE_AROUSAL_TOKEN, activeArousalIndex)
    EndIf

    JMap.setStr(mapId, FEMALE_AROUSAL_TOKEN, femaleArousalText)
    JMap.setStr(mapId, READINESS_TOKEN, readinessText)
    If activeActor
        JMap.setStr(mapId, MALE_AROUSAL_TOKEN, maleArousalText)
    EndIf
EndFunction

Function AddMaleArousalTextsToMap(Int mapId, Actor primaryMaleActor, Bool isPrimaryActorVictim = False)

    Int primaryArousalIndex = GetFactoredArousalIndex(primaryMaleActor, False)
    String readinessText = Database.RandomArousal(READINESS_TOKEN, primaryArousalIndex)
    String maleArousalText = Database.RandomArousal(MALE_AROUSAL_TOKEN, primaryArousalIndex)

    JMap.setStr(mapId, READINESS_TOKEN, readinessText)
    JMap.setStr(mapId, MALE_AROUSAL_TOKEN, maleArousalText)
EndFunction

Function AddAllSynonymTokensToMap(Int mapId)
    String[] allSynonymTokenNames = Database.AllSynonymTokenNames()
    Int index = 0
    While index < allSynonymTokenNames.Length
        String randomSynonym = Database.RandomSynonym(allSynonymTokenNames[index])
        JMap.setStr(mapId, allSynonymTokenNames[index], randomSynonym)        
        index += 1    
    EndWhile
EndFunction

Function PresentMessage(String msg, SslThreadController thread = None)

    Bool hasPlayer = False
    If thread && thread.HasPlayer()
        hasPlayer = True
    EndIf

    If Config.TraceMessagesEnabled
        Log("Apropos2Descriptions.PresentMessage('" + msg + "', " + StringIfElse(hasPlayer, "hasPlayer"))
    EndIf
    If thread
        If hasPlayer
            Widgets.DisplayPlayerDescriptionMessage(msg)
        Else
            Widgets.EnqueueDescriptionMessage(msg, section="NPC")
        EndIf
    Else
        Widgets.EnqueueDescriptionMessage(msg, section="MISC")
    EndIf   
EndFunction

Function DisplayMaleActorMasturbationMessage(SslThreadController thread, Actor maleActor, String effectiveVoice, Bool isOrgasm, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String maleName = maleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayMaleActorMasturbationMessage: " + animation + "," + maleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm"))
    EndIf

    Int mapId = JValue.retain(GenerateStandardTokenMap(maleName), tag=MODNAME)

    AddMaleArousalTextsToMap(mapId, maleActor)
    String tokenizedDescription = Database.RetrieveMaleMasturbationDescription(animation, isOrgasm, effectiveVoice, stage)
       
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf      

    JValue.release(mapId)  
EndFunction

Function DisplayFemaleActorMasturbationMessage(SslThreadController thread, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorMasturbationMessage:" + animation + "," + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm"))
    EndIf

    Int mapId = JValue.retain(GenerateVaginalTokenMap(primaryFemaleActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor)
    String tokenizedDescription = Database.RetrieveFemaleMasturbationDescription(animation, isOrgasm, effectiveVoice, stage)
       
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf    

    JValue.release(mapId)  
EndFunction

Function DisplayCustomFemaleMessage(Actor primaryFemaleActor, String modName, String eventName, Int inboundMap) 
    String effectiveVoice = Config.GetEffectiveNarrativeVoice(primaryFemaleActor == PlayerRef)
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()
    String bodyPart = JMap.getStr(inboundMap, "BodyPart")
    String partner = JMap.getStr(inboundMap, "Partner")

    If config.TraceMessagesEnabled
        Log("DisplayCustomFemaleMessage: " + primaryFemaleName + "," + effectiveVoice + "," + bodyPart + "," + partner)
    EndIf

    If bodyPart
        AddWearTearTokens(inboundMap, primaryFemaleActor, bodyPart)        
    EndIf

    JMap.setStr(inboundMap, PRIMARY_NAME_TOKEN, primaryFemaleName)

    String tokenizedDescription = Database.RetrieveCustomFemaleDescription(modName, eventName, effectiveVoice, bodyPart, partner)
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, inboundMap)
        PresentMessage(result, None)
    EndIf    

    JValue.Release(inboundMap)

EndFunction

Function AddWearTearTokens(Int mapId, Actor primaryFemaleActor, String bodyPart, Bool addAll = False) 
    If bodyPart == VAGINAL || addAll
        JMap.setStr(mapId, WEARTEAR_VAGINAL_TOKEN, GetWearTearVaginal(primaryFemaleActor))
    EndIf
    If bodyPart == ANAL || addAll
        JMap.setStr(mapId, WEARTEAR_ANAL_TOKEN, GetWearTearAnal(primaryFemaleActor))
    EndIf
    If bodyPart == ORAL || addAll
        JMap.setStr(mapId, WEARTEAR_ORAL_TOKEN, GetWearTearOral(primaryFemaleActor))
    EndIf
EndFunction

Function DisplayFemaleActorWearTearChangedMessage(String change, Actor primaryFemaleActor, String effectiveVoice, String sexPart)
    If !config.ShowWTChangedMessages
        Return
    EndIf
    
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorWearTearChangedMessage:" + change + "," + primaryFemaleName + "," + effectiveVoice + "," + sexPart+")")
    EndIf    

    Int mapId = JValue.retain(GenerateStandardTokenMap(primaryFemaleName), tag=MODNAME)
    AddWearTearTokens(mapId, primaryFemaleActor, sexPart)

    String tokenizedDescription = Database.RetrieveFemaleWearTearChangedDescription(change, sexPart, effectiveVoice)
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, None)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorVirginityLostMessage(SslThreadController thread, Bool isActorVictim, String effectiveVoice, String sexPart, String sexPartSynonym, String sexPartTokenName, Int mapId)
    If !Config.ShowVirginityLostMessages
        Return
    EndIf

    String tokenizedDescription = Database.RetrieveFemaleVirginityLostDescription(isActorVictim, sexPart, effectiveVoice)
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    Utility.Wait(PAUSE_AFTER_VIRGINITY_LOST) 
EndFunction

Function DisplayFemaleActorCreatureHandjobDescriptions(SslThreadController thread, String creature, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorCreatureHandjobDescriptions: " + animation + "," + creature + "," + StringIfElse(isPrimaryActorVictim, "primaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm"))
    EndIf

    Int mapId = JValue.retain(GenerateVaginalTokenMap(primaryFemaleActor, activeActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, creature, isPrimaryActorVictim, HANDJOB, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, creature, isPrimaryActorVictim, isOrgasm, HANDJOB, effectiveVoice)
    EndIf         
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf    

    JValue.release(mapId)
EndFunction

Function DisplayArbitraryTokenizedString(String tokenizedString, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor) 
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()    

    Int mapId = JValue.retain(GenerateVaginalTokenMap(primaryFemaleActor, activeActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)    

    String result = Database.ReplaceTokens(tokenizedString, mapId)
    PresentMessage(result, None)
    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorCreatureVaginalDescriptions(SslThreadController thread, String creature, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Bool displayVirginityLost, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorCreatureVaginalDescriptions: " + animation + "," + creature + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm") + "," + StringIfElse(displayVirginityLost, "displayVirginityLost"))
    EndIf

    Int mapId = JValue.retain(GenerateVaginalTokenMap(primaryFemaleActor, activeActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)

    If displayVirginityLost
        DisplayFemaleActorVirginityLostMessage(thread, isPrimaryActorVictim, effectiveVoice, VAGINAL, Database.RandomSynonym(PUSSY_TOKEN), PUSSY_TOKEN, mapId)
    EndIf       

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, creature, isPrimaryActorVictim, VAGINAL, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, creature, isPrimaryActorVictim, isOrgasm, VAGINAL, effectiveVoice)
    EndIf         
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorCreatureAnalDescriptions(SslThreadController thread, String creature, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Bool displayVirginityLost, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorCreatureAnalDescriptions: " + animation + "," + creature + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName +  "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm") + "," + StringIfElse(displayVirginityLost, "displayVirginityLost"))
    EndIf

    Int mapId = JValue.retain(GenerateAnalTokenMap(primaryFemaleActor, activeActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)    
    
    If displayVirginityLost
        DisplayFemaleActorVirginityLostMessage(thread, isPrimaryActorVictim, effectiveVoice, ANAL, Database.RandomSynonym(ASS_TOKEN), ASS_TOKEN, mapId)
    EndIf       

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, creature, isPrimaryActorVictim, ANAL, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, creature, isPrimaryActorVictim, isOrgasm, ANAL, effectiveVoice)
    EndIf            
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorCreatureOralDescriptions(SslThreadController thread, String creature, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Bool displayVirginityLost, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorCreatureOralDescriptions:" + animation + "," + creature + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm") + "," + StringIfElse(displayVirginityLost, "displayVirginityLost"))
    EndIf    

    Int mapId = JValue.retain(GenerateOralTokenMap(primaryFemaleActor, activeActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)
    
    If displayVirginityLost
        DisplayFemaleActorVirginityLostMessage(thread, isPrimaryActorVictim, effectiveVoice, ORAL, Database.RandomSynonym(MOUTH_TOKEN), MOUTH_TOKEN, mapId)
    EndIf       

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, creature, isPrimaryActorVictim, ORAL, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, creature, isPrimaryActorVictim, isOrgasm, ORAL, effectiveVoice)
    EndIf        
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorCreatureGangbangDescriptions(SslThreadController thread, String creature, Bool isPrimaryActorVictim, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, String[] gangBangParts, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorCreatureGangbangDescriptions:" + animation + "," + creature + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm") + ",parts=" + StringArrayToString(gangBangParts))
    EndIf

    Int mapId = JValue.retain(GenerateStandardTokenMap(primaryFemaleName, creature), tag=MODNAME) ; use creature generically here as ActiveName
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim)        

    If (Config.WearAndTearEnabled && isOrgasm)
        If (gangBangParts.Find(VAGINAL) >= 0 && Framework.IsVaginalVirgin(primaryFemaleActor))
            DisplayFemaleActorVirginityLostMessage(thread, isPrimaryActorVictim, effectiveVoice, VAGINAL, Database.RandomSynonym(PUSSY_TOKEN), PUSSY_TOKEN, mapId)
        EndIf
        If (gangBangParts.Find(ANAL) >= 0 && Framework.IsAnalVirgin(primaryFemaleActor))
            DisplayFemaleActorVirginityLostMessage(thread, isPrimaryActorVictim, effectiveVoice, ANAL, Database.RandomSynonym(ASS_TOKEN), ASS_TOKEN, mapId)
        EndIf
        If (gangBangParts.Find(ORAL) >= 0 && Framework.IsOralVirgin(primaryFemaleActor))
            DisplayFemaleActorVirginityLostMessage(thread, isPrimaryActorVictim, effectiveVoice, ORAL, Database.RandomSynonym(MOUTH_TOKEN), MOUTH_TOKEN, mapId)
        EndIf        
    EndIf       

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, creature, isPrimaryActorVictim, GANGBANG, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, creature, isPrimaryActorVictim, isOrgasm, GANGBANG, effectiveVoice)
    EndIf    
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorGoBackDescriptions(SslThreadController thread, String partner, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, String sexPart)
    If Config.GoBackAggressorFactor == 0
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorGoBackDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + sexPart)
    EndIf        

    Int mapId = JValue.retain(GenerateStandardTokenMap(primaryFemaleName, activeName), tag=MODNAME)
    AddWearTearTokens(mapId, primaryFemaleActor, sexPart, addAll=True)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)
    
    String tokenizedDescription = Database.RetrieveFemaleGoBackDescription(animation, isPrimaryActorVictim, partner, sexPart, effectiveVoice)
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorHugeOrLargeLoadDescriptions(SslThreadController thread, String partner, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, String sexPart, Int arousal)
    If !Config.ShowHugeLargeLoadMessages
        Return
    EndIf

    String load = ""

    If arousal > Config.MinArousalForHugeLoad
        load = "HugeLoad"
    ElseIf arousal > Config.MinArousalForLargeLoad
        load = "LargeLoad"
    Else
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorHugeOrLargeLoadDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + sexPart + "," + load)
    EndIf        

    Int mapId = JValue.retain(GenerateStandardTokenMap(primaryFemaleName, activeName), tag=MODNAME)
    AddWearTearTokens(mapId, primaryFemaleActor, sexPart, addAll=True)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)
    
    String tokenizedDescription = Database.DisplayFemaleActorLoadDescriptions(animation, isPrimaryActorVictim, partner, sexPart, effectiveVoice, load)
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorEstrusDescriptions(SslThreadController thread, Bool isPrimaryVictim, Actor primaryActor, String effectiveVoice, Bool isOrgasm, String[] bodyParts, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String primaryFemaleName = primaryActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorEstrusDescriptions: " + animation + "," + StringIfElse(isPrimaryVictim, "PrimaryIsVictim") + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm"))
    EndIf 
   
    Int mapId = JValue.retain(GenerateStandardTokenMap(primaryFemaleName), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryActor, isPrimaryVictim) 

    Int i = 0
    While i < bodyParts.Length
        AddWearTearTokens(mapId, primaryActor, bodyParts[i])
        i += 1
    EndWhile

    If Config.ShowVirginityLostMessages && isOrgasm
        If (bodyParts.Find(VAGINAL) >= 0) && Framework.IsVaginalVirgin(primaryActor)
            DisplayFemaleActorVirginityLostMessage(thread, isPrimaryVictim, effectiveVoice, VAGINAL, Database.RandomSynonym(PUSSY_TOKEN), PUSSY_TOKEN, mapId)
        EndIf
        If (bodyParts.Find(ANAL) >= 0) && Framework.IsAnalVirgin(primaryActor)
            DisplayFemaleActorVirginityLostMessage(thread, isPrimaryVictim, effectiveVoice, ANAL, Database.RandomSynonym(ASS_TOKEN), ASS_TOKEN, mapId)
        EndIf
    EndIf    

    String abbreviationString = GetSexPartAbbreviationString(bodyParts)

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, "Estrus", isPrimaryVictim, abbreviationString, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, "Estrus", isPrimaryVictim, isOrgasm, abbreviationString, effectiveVoice)
    EndIf

    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorMaleGangbangDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, String[] gangBangParts, String specifier, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorMaleGangbangDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm") + ",parts=" + StringArrayToString(gangBangParts) + ",specifier=" + specifier)
    EndIf

    Int mapId = JValue.retain(GenerateStandardTokenMap(primaryFemaleName), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim)        
    
    If Config.ShowVirginityLostMessages && isOrgasm
        If (gangBangParts.Find(VAGINAL) >= 0) && Framework.IsVaginalVirgin(primaryFemaleActor)
            DisplayFemaleActorVirginityLostMessage(thread, isPrimaryActorVictim, effectiveVoice, VAGINAL, Database.RandomSynonym(PUSSY_TOKEN), PUSSY_TOKEN, mapId)
        EndIf
        If (gangBangParts.Find(ANAL) >= 0) && Framework.IsAnalVirgin(primaryFemaleActor)
            DisplayFemaleActorVirginityLostMessage(thread, isPrimaryActorVictim, effectiveVoice, ANAL, Database.RandomSynonym(ASS_TOKEN), ASS_TOKEN, mapId)
        EndIf
        If (gangBangParts.Find(ORAL) >= 0) && Framework.IsOralVirgin(primaryFemaleActor)
            DisplayFemaleActorVirginityLostMessage(thread, isPrimaryActorVictim, effectiveVoice, ORAL, Database.RandomSynonym(MOUTH_TOKEN), MOUTH_TOKEN, mapId)
        EndIf        
    EndIf       

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, "Male", isPrimaryActorVictim, specifier, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, "Male", isPrimaryActorVictim, isOrgasm, specifier, effectiveVoice)
    EndIf    
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorFemaleFistingDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorFemaleFistingDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm"))
    EndIf    

    Int mapId = JValue.retain(GenerateStandardTokenMap(primaryFemaleName, activeName), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)         

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveMaleStageProgressionDescription(animation, "Female", isPrimaryActorVictim, FISTING, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveMaleDescription(animation, "Female", isPrimaryActorVictim, isOrgasm, FISTING, effectiveVoice)
    EndIf

    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayMaleActorFemaleFistingDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayMaleActorFemaleHandjobDescription: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm"))
    EndIf    

    Int mapId = JValue.retain(GenerateStandardTokenMap(primaryFemaleName, activeName), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)         

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveMaleStageProgressionDescription(animation, "Female", isPrimaryActorVictim, FISTING, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveMaleDescription(animation, "Female", isPrimaryActorVictim, isOrgasm, FISTING, effectiveVoice)
    EndIf

    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorMaleFistingDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorMaleHandjobDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm"))
    EndIf    

    Int mapId = JValue.retain(GenerateStandardTokenMap(primaryFemaleName, activeName), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)    

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, "Male", isPrimaryActorVictim, FISTING, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, "Male", isPrimaryActorVictim, isOrgasm, FISTING, effectiveVoice)
    EndIf
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayMaleActorFemaleFootjobDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayMaleActorFemaleHandjobDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm"))
    EndIf    

    Int mapId = JValue.retain(GenerateStandardTokenMap(primaryFemaleName, activeName), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)         

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveMaleStageProgressionDescription(animation, "Female", isPrimaryActorVictim, FOOTJOB, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveMaleDescription(animation, "Female", isPrimaryActorVictim, isOrgasm, FOOTJOB, effectiveVoice)
    EndIf

    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorFemaleFootjobDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorFemaleFootjobDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm"))
    EndIf    

    Int mapId = JValue.retain(GenerateStandardTokenMap(primaryFemaleName, activeName), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)    

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, "Female", isPrimaryActorVictim, FOOTJOB, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, "Female", isPrimaryActorVictim, isOrgasm, FOOTJOB, effectiveVoice)
    EndIf
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorMaleFootjobDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorMaleHandjobDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm"))
    EndIf    

    Int mapId = JValue.retain(GenerateStandardTokenMap(primaryFemaleName, activeName), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)    

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, "Male", isPrimaryActorVictim, FOOTJOB, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, "Male", isPrimaryActorVictim, isOrgasm, FOOTJOB, effectiveVoice)
    EndIf
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayMaleActorFemaleHandjobDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayMaleActorFemaleHandjobDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm"))
    EndIf    

    Int mapId = JValue.retain(GenerateStandardTokenMap(primaryFemaleName, activeName), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)         

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveMaleStageProgressionDescription(animation, "Female", isPrimaryActorVictim, HANDJOB, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveMaleDescription(animation, "Female", isPrimaryActorVictim, isOrgasm, HANDJOB, effectiveVoice)
    EndIf

    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

;DisplayFemaleActorFemaleFootjobDescriptions

Function DisplayFemaleActorFemaleHandjobDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorMaleHandjobDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm"))
    EndIf    

    Int mapId = JValue.retain(GenerateStandardTokenMap(primaryFemaleName, activeName), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)    

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, "Female", isPrimaryActorVictim, HANDJOB, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, "Female", isPrimaryActorVictim, isOrgasm, HANDJOB, effectiveVoice)
    EndIf
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorMaleHandjobDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorMaleHandjobDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm"))
    EndIf    

    Int mapId = JValue.retain(GenerateStandardTokenMap(primaryFemaleName, activeName), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)    

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, "Male", isPrimaryActorVictim, HANDJOB, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, "Male", isPrimaryActorVictim, isOrgasm, HANDJOB, effectiveVoice)
    EndIf
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayMaleActorFemaleBoobjobDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayMaleActorFemaleBoobjobDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm"))
    EndIf    

    Int mapId = JValue.retain(GenerateStandardTokenMap(primaryFemaleName, activeName), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)         

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveMaleStageProgressionDescription(animation, "Female", isPrimaryActorVictim, BOOBJOB, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveMaleDescription(animation, "Female", isPrimaryActorVictim, isOrgasm, BOOBJOB, effectiveVoice)
    EndIf

    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)   
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorFemaleBoobjobDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorFemaleBoobjobDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm"))
    EndIf    

    Int mapId = JValue.retain(GenerateStandardTokenMap(primaryFemaleName, activeName), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)    

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, "Female", isPrimaryActorVictim, BOOBJOB, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, "Female", isPrimaryActorVictim, isOrgasm, BOOBJOB, effectiveVoice)
    EndIf
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)      
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorMaleBoobjobDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorMaleBoobjobDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm"))
    EndIf    

    Int mapId = JValue.retain(GenerateStandardTokenMap(primaryFemaleName, activeName), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)    

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, "Male", isPrimaryActorVictim, BOOBJOB, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, "Male", isPrimaryActorVictim, isOrgasm, BOOBJOB, effectiveVoice)
    EndIf
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)      
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayMaleActorFemaleVaginalDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Bool displayVirginityLost, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayMaleActorFemaleVaginalDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm") + "," + StringIfElse(displayVirginityLost, "displayVirginityLost"))
    EndIf      

    Int mapId = JValue.retain(GenerateVaginalTokenMap(primaryFemaleActor, activeActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)    
    
    If displayVirginityLost && isOrgasm
        DisplayFemaleActorVirginityLostMessage(thread, isPrimaryActorVictim, THIRDPERSON, VAGINAL, Database.RandomSynonym(PUSSY_TOKEN), PUSSY_TOKEN, mapId)
    EndIf    
    
    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveMaleStageProgressionDescription(animation, "Female", isPrimaryActorVictim, VAGINAL, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveMaleDescription(animation, "Female", isPrimaryActorVictim, isOrgasm, VAGINAL, effectiveVoice)
    EndIf
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorFemaleForeplayDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorFemaleForeplayDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm"))
    EndIf 
   
    Int mapId = JValue.retain(GenerateVaginalTokenMap(primaryFemaleActor, activeActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor) 

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, "Female", isPrimaryActorVictim, FOREPLAY, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, "Female", isPrimaryActorVictim, isOrgasm, FOREPLAY, effectiveVoice)
    EndIf
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayMaleActorFemaleForeplayDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Bool displayVirginityLost, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayMaleActorFemaleForeplayDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm") + "," + StringIfElse(displayVirginityLost, "displayVirginityLost"))
    EndIf      

    Int mapId = JValue.retain(GenerateVaginalTokenMap(primaryFemaleActor, activeActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)    
    
    ; Virginity lost during Foreplay still not really decided upon.
    ; Perhaps add an MCM option with low value default perct to actually happen (like 5%)?    
    ; If displayVirginityLost && isOrgasm
    ;     DisplayFemaleActorVirginityLostMessage(isPrimaryActorVictim, THIRDPERSON, FOREPLAY, Database.RandomSynonym(PUSSY_TOKEN), PUSSY_TOKEN, mapId)
    ; EndIf    
    
    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveMaleStageProgressionDescription(animation, "Female", isPrimaryActorVictim, FOREPLAY, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveMaleDescription(animation, "Female", isPrimaryActorVictim, isOrgasm, FOREPLAY, effectiveVoice)
    EndIf
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorMaleForeplayDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Bool displayVirginityLost, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorMaleForeplayDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm") + "," + StringIfElse(displayVirginityLost, "displayVirginityLost"))
    EndIf 
   
    Int mapId = JValue.retain(GenerateVaginalTokenMap(primaryFemaleActor, activeActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor) 

    ; Virginity lost during Foreplay still not really decided upon.
    ; Perhaps add an MCM option with low value default perct to actually happen (like 5%)?
    ; If displayVirginityLost && isOrgasm
    ;     DisplayFemaleActorVirginityLostMessage(isPrimaryActorVictim, effectiveVoice, FOREPLAY, Database.RandomSynonym(PUSSY_TOKEN), PUSSY_TOKEN, mapId)
    ; EndIf    

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, "Male", isPrimaryActorVictim, FOREPLAY, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, "Male", isPrimaryActorVictim, isOrgasm, FOREPLAY, effectiveVoice)
    EndIf
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorMaleVaginalDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Bool displayVirginityLost, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorMaleVaginalDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm") + "," + StringIfElse(displayVirginityLost, "displayVirginityLost"))
    EndIf 
   
    Int mapId = JValue.retain(GenerateVaginalTokenMap(primaryFemaleActor, activeActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor) 

    If displayVirginityLost && isOrgasm
        DisplayFemaleActorVirginityLostMessage(thread, isPrimaryActorVictim, effectiveVoice, VAGINAL, Database.RandomSynonym(PUSSY_TOKEN), PUSSY_TOKEN, mapId)
    EndIf    

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, "Male", isPrimaryActorVictim, VAGINAL, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, "Male", isPrimaryActorVictim, isOrgasm, VAGINAL, effectiveVoice)
    EndIf
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorMaleDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Bool displayVirginityLost, Int stage = 0)

    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorMaleDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm") + "," + StringIfElse(displayVirginityLost, "displayVirginityLost"))
    EndIf 
   
    Int mapId = JValue.retain(GenerateVaginalTokenMap(primaryFemaleActor, activeActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor) 

    If displayVirginityLost && isOrgasm
        DisplayFemaleActorVirginityLostMessage(thread, isPrimaryActorVictim, effectiveVoice, VAGINAL, Database.RandomSynonym(PUSSY_TOKEN), PUSSY_TOKEN, mapId)
    EndIf    

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, "Male", isPrimaryActorVictim, VAGINAL, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, "Male", isPrimaryActorVictim, isOrgasm, VAGINAL, effectiveVoice)
    EndIf
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)    
EndFunction

Function DisplayMaleActorFemaleAnalDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Bool displayVirginityLost, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayMaleActorFemaleAnalDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm") + "," + StringIfElse(displayVirginityLost, "displayVirginityLost"))
    EndIf        
    
    Int mapId = JValue.retain(GenerateAnalTokenMap(primaryFemaleActor, activeActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)

    If displayVirginityLost  && isOrgasm
        DisplayFemaleActorVirginityLostMessage(thread, isPrimaryActorVictim, THIRDPERSON, ANAL, Database.RandomSynonym(ASS_TOKEN), ASS_TOKEN, mapId)
    EndIf

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveMaleStageProgressionDescription(animation, "Female", isPrimaryActorVictim, ANAL, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveMaleDescription(animation, "Female", isPrimaryActorVictim, isOrgasm, ANAL, effectiveVoice)
    EndIf
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorMaleAnalDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Bool displayVirginityLost, Int stage = 0)  
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorMaleAnalDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm") + "," + StringIfElse(displayVirginityLost, "displayVirginityLost"))
    EndIf        
    
    Int mapId = JValue.retain(GenerateAnalTokenMap(primaryFemaleActor, activeActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)

    If displayVirginityLost && isOrgasm
        DisplayFemaleActorVirginityLostMessage(thread, isPrimaryActorVictim, effectiveVoice, ANAL, Database.RandomSynonym(ASS_TOKEN), ASS_TOKEN, mapId)
    EndIf

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, "Male", isPrimaryActorVictim, ANAL, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, "Male", isPrimaryActorVictim, isOrgasm, ANAL, effectiveVoice)
    EndIf
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayMaleActorFemaleOralDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Bool displayVirginityLost, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayMaleActorFemaleOralDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice+ "," + StringIfElse(isOrgasm, "Orgasm") + "," + StringIfElse(displayVirginityLost, "displayVirginityLost"))
    EndIf        
    
    Int mapId = JValue.retain(GenerateOralTokenMap(primaryFemaleActor, activeActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)

    If displayVirginityLost && isOrgasm
        DisplayFemaleActorVirginityLostMessage(thread, isPrimaryActorVictim, THIRDPERSON, ORAL, Database.RandomSynonym(MOUTH_TOKEN), MOUTH_TOKEN, mapId)
    EndIf

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveMaleStageProgressionDescription(animation, "Female", isPrimaryActorVictim, ORAL, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveMaleDescription(animation, "Female", isPrimaryActorVictim, isOrgasm, ORAL, effectiveVoice)
    EndIf    
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorFemaleCunnilingusDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorFemaleCunnilingusDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice+ "," + StringIfElse(isOrgasm, "Orgasm"))
    EndIf        

    Int mapId = JValue.retain(GenerateOralTokenMap(primaryFemaleActor, activeActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)
    
    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, "Female", isPrimaryActorVictim, CUNNILINGUS, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, "Female", isPrimaryActorVictim, isOrgasm, CUNNILINGUS, effectiveVoice)
    EndIf        
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorFemaleOralDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Bool displayVirginityLost, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorFemaleOralDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice+ "," + StringIfElse(isOrgasm, "Orgasm") + "," + StringIfElse(displayVirginityLost, "displayVirginityLost"))
    EndIf        

    Int mapId = JValue.retain(GenerateOralTokenMap(primaryFemaleActor, activeActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)
    
    If displayVirginityLost && isOrgasm
        DisplayFemaleActorVirginityLostMessage(thread, isPrimaryActorVictim, effectiveVoice, ORAL, Database.RandomSynonym(MOUTH_TOKEN), MOUTH_TOKEN, mapId)
    EndIf

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, "Female", isPrimaryActorVictim, ORAL, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, "Female", isPrimaryActorVictim, isOrgasm, ORAL, effectiveVoice)
    EndIf        
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorMaleOralDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Bool displayVirginityLost, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf

    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorMaleOralDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "PrimaryIsVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice+ "," + StringIfElse(isOrgasm, "Orgasm") + "," + StringIfElse(displayVirginityLost, "displayVirginityLost"))
    EndIf        

    Int mapId = JValue.retain(GenerateOralTokenMap(primaryFemaleActor, activeActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)
    
    If displayVirginityLost && isOrgasm
        DisplayFemaleActorVirginityLostMessage(thread, isPrimaryActorVictim, effectiveVoice, ORAL, Database.RandomSynonym(MOUTH_TOKEN), MOUTH_TOKEN, mapId)
    EndIf

    String tokenizedDescription
    If stage > 0
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, "Male", isPrimaryActorVictim, ORAL, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, "Male", isPrimaryActorVictim, isOrgasm, ORAL, effectiveVoice)
    EndIf        
    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorFemaleLesbianDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf
        
    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorFemaleLesbianDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "isPrimaryActorVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm"))
    EndIf        
    
    Int mapId = JValue.retain(GenerateVaginalTokenMap(primaryFemaleActor, activeActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)

    String tokenizedDescription
    If stage > 0 
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, "Female", isPrimaryActorVictim, LESBIAN, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, "Female", isPrimaryActorVictim, isOrgasm, LESBIAN, effectiveVoice)
    EndIf

    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorFemaleVaginalDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Bool displayVirginityLost, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf
        
    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorFemaleVaginalDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "isPrimaryActorVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm") + "," + StringIfElse(displayVirginityLost, "displayVirginityLost"))
    EndIf        
    
    Int mapId = JValue.retain(GenerateVaginalTokenMap(primaryFemaleActor, activeActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)

    If displayVirginityLost && isOrgasm
        DisplayFemaleActorVirginityLostMessage(thread, isPrimaryActorVictim, effectiveVoice, VAGINAL, Database.RandomSynonym(PUSSY_TOKEN), PUSSY_TOKEN, mapId)
    EndIf   

    String tokenizedDescription
    If stage > 0 
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, "Female", isPrimaryActorVictim, VAGINAL, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, "Female", isPrimaryActorVictim, isOrgasm, VAGINAL, effectiveVoice)
    EndIf

    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayFemaleActorFemaleAnalDescriptions(SslThreadController thread, Bool isPrimaryActorVictim, Actor activeActor, Actor primaryFemaleActor, String effectiveVoice, Bool isOrgasm, Bool displayVirginityLost, Int stage = 0)
    If !Config.ShowSexDescriptions
        Return
    EndIf
    
    String animation = thread.Animation.Registry
    String activeName = activeActor.GetDisplayName()
    String primaryFemaleName = primaryFemaleActor.GetDisplayName()

    If config.TraceMessagesEnabled
        Log("DisplayFemaleActorFemaleAnalDescriptions: " + animation + "," + StringIfElse(isPrimaryActorVictim, "isPrimaryActorVictim") + ",active=" + activeName + ",primary=" + primaryFemaleName + "," + effectiveVoice + "," + StringIfElse(isOrgasm, "Orgasm") + "," + StringIfElse(displayVirginityLost, "displayVirginityLost"))
    EndIf        
    
    Int mapId = JValue.retain(GenerateVaginalTokenMap(primaryFemaleActor, activeActor), tag=MODNAME)
    AddArousalTextsToMap(mapId, primaryFemaleActor, isPrimaryActorVictim, activeActor)

    If displayVirginityLost && isOrgasm
        DisplayFemaleActorVirginityLostMessage(thread, isPrimaryActorVictim, effectiveVoice, ANAL, Database.RandomSynonym(ASS_TOKEN), ASS_TOKEN, mapId)
    EndIf   

    String tokenizedDescription
    If stage > 0 
        tokenizedDescription = Database.RetrieveFemaleStageProgressionDescription(animation, "Female", isPrimaryActorVictim, ANAL, effectiveVoice, stage)
    Else
        tokenizedDescription = Database.RetrieveFemaleDescription(animation, "Female", isPrimaryActorVictim, isOrgasm, ANAL, effectiveVoice)
    EndIf

    If tokenizedDescription
        String result = Database.ReplaceTokens(tokenizedDescription, mapId)
        PresentMessage(result, thread)
    EndIf

    JValue.release(mapId)
EndFunction

Function DisplayAnimationStartChangeOrStageStartMessage(SslThreadController thread, Int stage, Bool isAnimationChange)
    SslBaseAnimation animation = thread.Animation
    Actor[] actorList = thread.Positions

    If stage > 0 && !Config.ShouldPlayStage(stage)
        Return
    EndIf

    If stage == 0 && !Config.ShowAnimationStartMessages
        Return
    EndIf

    Bool isThreeWay = animation.HasTag("Orgy"); captures MMF, FMM, FFM, MFF
    Bool isCreatureSex = thread.HasCreature || animation.HasTag("Creature")
    Bool isLesbianSex = IsLesbianSex(animation, actorList)
    Bool isGangBang = animation.HasTag(GANGBANG)    
    Bool isAnal = animation.HasTag(ANAL)
    Bool isVaginal = animation.HasTag(VAGINAL)
    Bool isOral = animation.HasTag(ORAL)
    Bool isBoobJob = animation.HasTag(BOOBJOB)  
    Bool isHandJob = animation.HasTag(HANDJOB)
    Bool isFisting = animation.HasTag(FISTING)
    Bool isFootJob = animation.HasTag(FOOTJOB)
    Bool isForeplay = animation.HasTag(FOREPLAY)
    Bool isBlowjob = animation.HasTag(BLOWJOB)
    Bool isMasturbation = animation.HasTag("Solo") && animation.HasTag("Masturbation")    
    Bool isGaySex = IsGaySex(animation, actorList)
    Bool isCunnilingus = animation.HasTag("Cunnilingus") || (isOral && !isBlowjob)
    Bool isCreatureGangBang = IsCreatureGangBang(animation)
    Bool isEstrusSex = animation.HasTag("Estrus")
    String maleGangBangSpecifier = GetGangBangSpecifier(animation)    

    Actor primaryActor
    
    If thread.HasPlayer
        primaryActor = PlayerRef
    Else
        primaryActor = actorList[0]
    EndIf
    
    Bool isPrimaryFemale = SexLab.GetGender(primaryActor) == FEMALE
    Bool isPrimaryMale = !isPrimaryFemale
    Bool isPrimaryVictim = thread.IsVictim(primaryActor)

    String[] parts = BuildSexPartsFromAnimation(animation)

    Actor activeActor
    If actorList.Length > 1
        activeActor = actorList[1]
    EndIf

    String effectiveVoice = Config.GetEffectiveNarrativeVoice(thread.HasPlayer)

    If isMasturbation
        If isPrimaryFemale
            DisplayFemaleActorMasturbationMessage(thread, primaryActor, effectiveVoice, False, stage)
        Else
            DisplayMaleActorMasturbationMessage(thread, primaryActor, effectiveVoice, False, stage)
        EndIf  
    ElseIf isEstrusSex
        DisplayFemaleActorEstrusDescriptions(thread, isPrimaryVictim, primaryActor, effectiveVoice, False, parts, stage)

    ; Straight Male and Female PC 
    ElseIf !isLesbianSex && isPrimaryFemale && !isCreatureSex; && !isThreeWay
        Debug(">> Straight Male and Female PC")
        If maleGangBangSpecifier != ""
            DisplayFemaleActorMaleGangbangDescriptions(thread, isPrimaryVictim, primaryActor, effectiveVoice, False, parts, maleGangBangSpecifier, stage)

        ElseIf isVaginal
            DisplayFemaleActorMaleVaginalDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, False, False, stage)

        ElseIf isAnal
            DisplayFemaleActorMaleAnalDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, False, False, stage)

        ElseIf isOral
            DisplayFemaleActorMaleOralDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, False, False, stage)

        ElseIf isBoobJob
            DisplayFemaleActorMaleBoobjobDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, False, stage)

        ElseIf isHandJob
            DisplayFemaleActorMaleHandjobDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, False, stage)

        ElseIf isFisting
            DisplayFemaleActorMaleFistingDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, False, stage)

        ElseIf isFootJob
            DisplayFemaleActorMaleFootjobDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, False, stage)

        ElseIf isForeplay
            DisplayFemaleActorMaleForeplayDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, False, False, stage)

        EndIf   

        ActorsLib.ProcessStageStart(primaryActor, actorList)

    ; Creature and Female PC
    ElseIf isCreatureSex && isPrimaryFemale
        Debug(">> Creature and Female PC or NPC")
        String creatureType = GetCreatureFromAnimation(animation, activeActor)

        If isCreatureGangBang
            DisplayFemaleActorCreatureGangbangDescriptions(thread, creatureType, isPrimaryVictim, primaryActor, effectiveVoice, False, parts, stage)

        ElseIf isVaginal
            DisplayFemaleActorCreatureVaginalDescriptions(thread, creatureType, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, False, False, stage)

        ElseIf isAnal
            DisplayFemaleActorCreatureAnalDescriptions(thread, creatureType, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, False, False, stage)
        
        ElseIf isOral
            DisplayFemaleActorCreatureOralDescriptions(thread, creatureType, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, False, False, stage)

        ElseIf isHandJob
            DisplayFemaleActorCreatureHandjobDescriptions(thread, creatureType, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, False, stage)
        EndIf

        ActorsLib.ProcessStageStart(primaryActor, actorList)

    ; Primary Straight Male PC and Female
    ElseIf !isLesbianSex && !isCreatureSex && isPrimaryMale && !isGaySex
        Debug(">> Primary Straight Male PC and Female")
        Actor femaleActor = actorList[0] ; in a two-way MF, Female is always position 0 according to Ashal
        Bool isFemaleVictim = thread.IsVictim(femaleActor)

        If isGangBang
            ;DisplayMaleActorGangbangDescriptions(...) ?
        
        ElseIf isVaginal
            DisplayMaleActorFemaleVaginalDescriptions(thread, isFemaleVictim, primaryActor, femaleActor, effectiveVoice, False, False, stage)

        ElseIf isAnal
            DisplayMaleActorFemaleAnalDescriptions(thread, isFemaleVictim, primaryActor, femaleActor, effectiveVoice, False, False, stage)

        ElseIf isOral
            DisplayMaleActorFemaleOralDescriptions(thread, isFemaleVictim, primaryActor, femaleActor, effectiveVoice, False, False, stage)

        ElseIf isBoobJob
            DisplayMaleActorFemaleBoobjobDescriptions(thread, isFemaleVictim, primaryActor, femaleActor, effectiveVoice, False, stage)

        ElseIf isHandJob
            DisplayMaleActorFemaleHandjobDescriptions(thread, isPrimaryVictim, primaryActor, femaleActor, effectiveVoice, False, stage)

        ElseIf isFisting
            DisplayMaleActorFemaleFistingDescriptions(thread, isPrimaryVictim, primaryActor, femaleActor, effectiveVoice, False, stage)

        ElseIf isFootJob
            DisplayMaleActorFemaleFootjobDescriptions(thread, isPrimaryVictim, primaryActor, femaleActor, effectiveVoice, False, stage)

        ElseIf isForeplay
            DisplayMaleActorFemaleForeplayDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, False, False, stage)

        EndIf  

    ElseIf isLesbianSex ; defined as two females
        Debug(">> Lesbian sex")
        If !animation.HasTag("Lesbian"); we are using a regular MF animation probably but with two Fs
            Debug("... not tagged as Lesbian")
            If isVaginal || isAnal || isBoobJob || (isOral && !isCunnilingus); look for tags that seem to indicate a strapon
                Int actorWithStrapOnIndex = GetIndexOfMalePosition(thread, actorList)
                If actorWithStrapOnIndex != -1 ; if the animation is tagged as vaginal or anal, and we are all females, we should have a strapon somewhere ...
                    Int receivingActorIndex = -1 ; index of actor receiving the strapon

                    If actorWithStrapOnIndex == 0
                        receivingActorIndex = 1
                    Else
                        receivingActorIndex = 0
                    EndIf

                    Actor actorWithStrapOn = actorList[actorWithStrapOnIndex]
                    Actor receivingActor = actorList[receivingActorIndex]
                    Bool isReceivingVictim = thread.IsVictim(receivingActor)

                    If Config.TraceMessagesEnabled
                        String rape = ""
                        If isReceivingVictim
                            rape = " (victim)"
                        EndIf   
                        Log("Actor with strap on : " + actorWithStrapOn.GetDisplayName() + ", receiving : " + receivingActor.GetDisplayName() + rape)
                    EndIf

                    If isVaginal
                        DisplayFemaleActorFemaleVaginalDescriptions(thread, isReceivingVictim, actorWithStrapOn, receivingActor, effectiveVoice, False, False, stage)                    
                    ElseIf isAnal
                        DisplayFemaleActorFemaleAnalDescriptions(thread, isReceivingVictim, actorWithStrapOn, receivingActor, effectiveVoice, False, False, stage)      
                    ElseIf isBoobJob
                        DisplayFemaleActorFemaleBoobJobDescriptions(thread, isReceivingVictim, actorWithStrapOn, receivingActor, effectiveVoice, False, stage)
                    ElseIf isOral
                        DisplayFemaleActorFemaleBoobJobDescriptions(thread, isReceivingVictim, actorWithStrapOn, receivingActor, effectiveVoice, False, stage)
                    EndIf
                EndIf
            ; else it is a MF animation playing with two F's and no StrapOn
            ; Assume actorList[0] is 'receiving' generally 
            ElseIf isForeplay
                ; who is primary and who is active? Gonna just use the default answers: that 0-PlayerRef, 1-other chick
                DisplayFemaleActorFemaleForeplayDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, False, stage)
            ElseIf isCunnilingus
                ; who is primary and who is active? Gonna just use the default answers: that 0-PlayerRef, 1-other chick
                DisplayFemaleActorFemaleCunnilingusDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, False, stage)
            ElseIf isFisting
                ; who is primary and who is active? Gonna just use the default answers: that 0-PlayerRef, 1-other chick
                DisplayFemaleActorFemaleFistingDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, False, stage)
            ElseIf isFootJob
                ; who is primary and who is active? Gonna just use the default answers: that 0-PlayerRef, 1-other chick
                DisplayFemaleActorFemaleFootjobDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, False, stage)
            ElseIf isHandJob
                ; who is primary and who is active? Gonna just use the default answers: that 0-PlayerRef, 1-other chick
                DisplayFemaleActorFemaleFootjobDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, False, stage)
            EndIf
        Else ; has Lesbian tag
            DisplayFemaleActorFemaleLesbianDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, False, stage)
        EndIf

    ; Male and Male PC
    ; TODO    
    ElseIf isGaySex
        ; TODO
    EndIf

EndFunction

Function DisplayOrgasmStartMessage(SslThreadController thread)
    SslBaseAnimation animation = thread.Animation
    Actor[] actorList = thread.Positions

    Bool isThreeWay = animation.HasTag("Orgy"); captures MMF, FMM, FFM, MFF
    Bool isCreatureSex = thread.HasCreature || animation.HasTag("Creature")
    Bool isLesbianSex = IsLesbianSex(animation, actorList)
    
    Bool isGangBang = animation.HasTag(GANGBANG)    
    Bool isAnal = animation.HasTag(ANAL)
    Bool isVaginal = animation.HasTag(VAGINAL)
    Bool isOral = animation.HasTag(ORAL)
    Bool isBoobJob = animation.HasTag(BOOBJOB)
    Bool isHandJob = animation.HasTag(HANDJOB)
    Bool isFisting = animation.HasTag(FISTING)
    Bool isFootJob = animation.HasTag(FOOTJOB)
    Bool isForeplay = animation.HasTag(FOREPLAY)    
    Bool isBlowjob = animation.HasTag(BLOWJOB)
    Bool isMasturbation = animation.HasTag("Solo") || animation.HasTag("Masturbation")
    Bool isGaySex = IsGaySex(animation, actorList)
    Bool isAggressive = animation.HasTag(AGGRESSIVE) || animation.HasTag(FORCED) || animation.HasTag(ROUGH)
    ;Bool isDaedricCreatureOrDremora = animation.HasTag("Seeker") || animation.HasTag("Lurker") || Common.IsDremora
    Bool isCunnilingus = animation.HasTag("Cunnilingus") || (isOral && !isBlowjob)
    Bool isCreatureGangBang = IsCreatureGangBang(animation)
    Bool isEstrusSex = animation.HasTag("Estrus")
    String maleGangBangSpecifier = GetGangBangSpecifier(animation)
    
    Actor primaryActor
    
    If (thread.HasPlayer)
        primaryActor = PlayerRef
    Else
        primaryActor = actorList[0]
    EndIf
    
    Bool isPrimaryFemale = SexLab.GetGender(primaryActor) == FEMALE
    Bool isPrimaryMale = !isPrimaryFemale
    Bool isPrimaryVictim = thread.IsVictim(primaryActor)

    Actor activeActor
    If actorList.Length > 1
        activeActor = actorList[1]
    EndIf
    
    String[] parts = BuildSexPartsFromAnimation(animation)

    String effectiveVoice = Config.GetEffectiveNarrativeVoice(thread.HasPlayer)

    If isMasturbation
        Debug(">> Masturbation")

        If isPrimaryFemale
            DisplayFemaleActorMasturbationMessage(thread, primaryActor, effectiveVoice, True)
        Else
            DisplayMaleActorMasturbationMessage(thread, primaryActor, effectiveVoice, True)
        EndIf
    ElseIf isEstrusSex
        DisplayFemaleActorEstrusDescriptions(thread, isPrimaryVictim, primaryActor, effectiveVoice, True, parts)

    ; Straight Male and Female PC or Male and Female NPC
    ElseIf !isLesbianSex && isPrimaryFemale && !isCreatureSex; && !isThreeWay
        Debug(">> Straight Male and Female PC or Male and Female NPC")
        Bool hasVictimOrAggressive = isPrimaryVictim || isAggressive
        
        ;Bool isDremora = IsDremora(activeActor) ; just check the second actor, the first active actor. Assume if one is dremora, all are dremora

        String damageClass

        If IsDremora(activeActor) 
            damageClass = "Dremora"
        Else
            damageClass = "Human"
        EndIf

        ; Two guys and one girl
        If maleGangBangSpecifier != "" 
            DisplayFemaleActorMaleGangbangDescriptions(thread, isPrimaryVictim, primaryActor, effectiveVoice, True, parts, maleGangBangSpecifier)

            If isVaginal
                ;Framework.ApplyVaginalWearAndTear(primaryActor, "Human", isPrimaryVictim || isAggressive, isDremora, False)
                ActorsLib.DoApplyWearAndTear(primaryActor, VAGINAL, damageClass, hasVictimOrAggressive, isCreature=False)
            EndIf
            If isAnal
                ;Framework.ApplyAnalWearAndTear(primaryActor, "Human", isPrimaryVictim || isAggressive, isDremora, False)
                ActorsLib.DoApplyWearAndTear(primaryActor, ANAL, damageClass, hasVictimOrAggressive, isCreature=False)
            EndIf
            If isOral
                ;Framework.ApplyOralWearAndTear(primaryActor, "Human", isPrimaryVictim || isAggressive, isDremora, False)
                ActorsLib.DoApplyWearAndTear(primaryActor, ORAL, damageClass, hasVictimOrAggressive, isCreature=False)                
            EndIf
            
        ; One on One Sex::
        ElseIf isVaginal
            DisplayFemaleActorMaleVaginalDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, True, Framework.IsVaginalVirgin(primaryActor))
            ;Framework.ApplyVaginalWearAndTear(primaryActor, "Human", isPrimaryVictim || isAggressive, isDremora, False)            
            ActorsLib.DoApplyWearAndTear(primaryActor, VAGINAL, damageClass, hasVictimOrAggressive, isCreature=False)            
        ElseIf isAnal
            DisplayFemaleActorMaleAnalDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, True, Framework.IsAnalVirgin(primaryActor))
            ;Framework.ApplyAnalWearAndTear(primaryActor, "Human", isPrimaryVictim || isAggressive, isDremora, False)
            ActorsLib.DoApplyWearAndTear(primaryActor, ANAL, damageClass, hasVictimOrAggressive, isCreature=False)
        ElseIf isOral
            DisplayFemaleActorMaleOralDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, True, Framework.IsOralVirgin(primaryActor))
            ;Framework.ApplyOralWearAndTear(primaryActor, "Human", isPrimaryVictim || isAggressive, isDremora, False)            
            ActorsLib.DoApplyWearAndTear(primaryActor, ORAL, damageClass, hasVictimOrAggressive, isCreature=False)             
        ElseIf isBoobJob
            DisplayFemaleActorMaleBoobjobDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, True)

        ElseIf isHandJob
            DisplayFemaleActorMaleHandjobDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, True)

        ElseIf isFisting
            DisplayFemaleActorMaleFistingDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, True)

        ElseIf isFootJob
            DisplayFemaleActorMaleFootjobDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, True)

        ElseIf isForeplay
            DisplayFemaleActorMaleForeplayDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, True, Framework.IsVaginalVirgin(primaryActor))

        EndIf 

        ActorsLib.DoUpdateEffectsAndTats(primaryActor, increasingAbuse=True) 
        ActorsLib.ProcessOrgasm(thread, primaryActor, activeActor, hasVictimOrAggressive, damageClass, parts)
        ;Framework.UpdateWearTearEffectsAndAbuseTextures(primaryActor)
        Deflower(primaryActor, isVaginal, isAnal, isOral)     
           
    ; Creature and Female PC
    ElseIf isCreatureSex && isPrimaryFemale
        Debug(">> Creature and Female PC or NPC")

        String creatureType = GetCreatureFromAnimation(animation, activeActor)     

        ;Bool isDaedric = animation.HasTag("Seeker") || animation.HasTag("Lurker")
        Bool hasVictimOrAggressive = isPrimaryVictim || isAggressive

        If isCreatureGangBang
            DisplayFemaleActorCreatureGangBangDescriptions(thread, creatureType, isPrimaryVictim, primaryActor, effectiveVoice, True, parts)  
            If isVaginal
                ActorsLib.DoApplyWearAndTear(primaryActor, VAGINAL, creatureType, isPrimaryVictim || isAggressive, isCreature=True)
                ;Framework.ApplyVaginalWearAndTear(primaryActor, creatureType, isPrimaryVictim || isAggressive, isDaedric, True)
            EndIf
            If isAnal
                ActorsLib.DoApplyWearAndTear(primaryActor, ANAL, creatureType, isPrimaryVictim || isAggressive, isCreature=True)
                ;Framework.ApplyAnalWearAndTear(primaryActor, creatureType, isPrimaryVictim || isAggressive, isDaedric, True)
            EndIf
            If isOral
                ActorsLib.DoApplyWearAndTear(primaryActor, ORAL, creatureType, isPrimaryVictim || isAggressive, isCreature=True)
                ;Framework.ApplyOralWearAndTear(primaryActor, creatureType, isPrimaryVictim || isAggressive, isDaedric, True)           
            EndIf
        Else
            If isVaginal
                DisplayFemaleActorCreatureVaginalDescriptions(thread, creatureType, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, True, Framework.IsVaginalVirgin(primaryActor))        
                ;Framework.ApplyVaginalWearAndTear(primaryActor, creatureType, isPrimaryVictim || isAggressive, isDaedric, True)
                ActorsLib.DoApplyWearAndTear(primaryActor, VAGINAL, creatureType, isPrimaryVictim || isAggressive, isCreature=True)                
            EndIf
            If isAnal
                DisplayFemaleActorCreatureAnalDescriptions(thread, creatureType, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, True, Framework.IsAnalVirgin(primaryActor))        
                ;Framework.ApplyAnalWearAndTear(primaryActor, creatureType, isPrimaryVictim || isAggressive, isDaedric, True)
                ActorsLib.DoApplyWearAndTear(primaryActor, ANAL, creatureType, isPrimaryVictim || isAggressive, isCreature=True)                 
            EndIf
            If isOral
                DisplayFemaleActorCreatureOralDescriptions(thread, creatureType, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, True, Framework.IsOralVirgin(primaryActor))        
                ;Framework.ApplyOralWearAndTear(primaryActor, creatureType, isPrimaryVictim || isAggressive, isDaedric, True)
                ActorsLib.DoApplyWearAndTear(primaryActor, ORAL, creatureType, isPrimaryVictim || isAggressive, isCreature=True)                 
            EndIf
            If isHandJob
                ; Handjobs will not cause virginity to be lost!
                DisplayFemaleActorCreatureHandjobDescriptions(thread, creatureType, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, isOrgasm=True)
                ;Framework.ApplyVaginalWearAndTear(primaryActor, creatureType, isPrimaryVictim || isAggressive, isDaedric, True)
            EndIf
        EndIf

        ActorsLib.DoUpdateEffectsAndTats(primaryActor, increasingAbuse=True) 
        ;Framework.UpdateWearTearEffectsAndAbuseTextures(primaryActor)
        ActorsLib.ProcessOrgasm(thread, primaryActor, activeActor, hasVictimOrAggressive, creatureType, parts)
        Deflower(primaryActor, isVaginal, isAnal, isOral)

    ; Primary Straight Male PC and Female
    ElseIf !isLesbianSex && !isCreatureSex && isPrimaryMale && !isGaySex && !isThreeWay
        Debug(">> Primary Straight Male PC and Female")
        Actor femaleActor = actorList[0] ; in a two-way MF, Female is always position 0 according to Ashal
        Bool isFemaleVictim = thread.IsVictim(femaleActor)
        ;Bool isPrimaryDremora = IsDremora(primaryActor)
        Bool hasVictimOrIsAggressive = isFemaleVictim || isAggressive
        String damageClass = "Human"
        If IsDremora(primaryActor)
            damageClass = "Dremora"
        EndIf

        If isVaginal
            DisplayMaleActorFemaleVaginalDescriptions(thread, isFemaleVictim, primaryActor, femaleActor, effectiveVoice, True, Framework.IsVaginalVirgin(femaleActor))
            ;Framework.ApplyVaginalWearAndTear(femaleActor, damageClass, isFemaleVictim || isAggressive, isPrimaryDremora, False)
            ActorsLib.DoApplyWearAndTear(femaleActor, VAGINAL, damageClass, hasVictimOrIsAggressive, isCreature=False)
        ElseIf isAnal
            DisplayMaleActorFemaleAnalDescriptions(thread, isFemaleVictim, primaryActor, femaleActor, effectiveVoice, True, Framework.IsAnalVirgin(femaleActor))
            ;Framework.ApplyAnalWearAndTear(femaleActor, damageClass, isFemaleVictim || isAggressive, isPrimaryDremora, False)
            ActorsLib.DoApplyWearAndTear(femaleActor, ANAL, damageClass, hasVictimOrIsAggressive, isCreature=False)
        ElseIf isOral
            DisplayMaleActorFemaleOralDescriptions(thread, isFemaleVictim, primaryActor, femaleActor, effectiveVoice, True, Framework.IsOralVirgin(femaleActor))
            ;Framework.ApplyOralWearAndTear(femaleActor, damageClass, isFemaleVictim || isAggressive, isPrimaryDremora, False)
            ActorsLib.DoApplyWearAndTear(femaleActor, ORAL, damageClass, hasVictimOrIsAggressive, isCreature=False)
        ElseIf isBoobJob
            DisplayMaleActorFemaleBoobjobDescriptions(thread, isFemaleVictim, primaryActor, femaleActor, effectiveVoice, True)

        ElseIf isHandJob
            DisplayMaleActorFemaleHandjobDescriptions(thread, isFemaleVictim, primaryActor, femaleActor, effectiveVoice, True)

        ElseIf isFisting
            DisplayMaleActorFemaleFistingDescriptions(thread, isFemaleVictim, primaryActor, femaleActor, effectiveVoice, True)

        ElseIf isFootJob
            DisplayMaleActorFemaleFootjobDescriptions(thread, isFemaleVictim, primaryActor, femaleActor, effectiveVoice, True)   

        ElseIf isMasturbation
            DisplayMaleActorMasturbationMessage(thread, primaryActor, effectiveVoice, True)         

        ElseIf isForeplay
            DisplayMaleActorFemaleForeplayDescriptions(thread, isFemaleVictim, primaryActor, femaleActor, effectiveVoice, False, Framework.IsVaginalVirgin(femaleActor))

        EndIf   

        ActorsLib.DoUpdateEffectsAndTats(femaleActor, increasingAbuse=True)
        ;Framework.UpdateWearTearEffectsAndAbuseTextures(femaleActor)
        ActorsLib.ProcessOrgasm(thread, primaryActor, activeActor, hasVictimOrIsAggressive, damageClass, parts)
        Deflower(femaleActor, isVaginal, isAnal, isOral)

    ElseIf isLesbianSex ; defined as two females
        Debug(">> Lesbian sex")
        If !animation.HasTag("Lesbian")  ; we are using a regular MF animation probably but with two Fs
            Debug("... not tagged as Lesbian")
            If isVaginal || isAnal || isBoobJob || (isOral && !isCunnilingus) ; look for tags that seem to indicate a strapon
                Int actorWithStrapOnIndex = GetIndexOfMalePosition(thread, actorList)
                If actorWithStrapOnIndex != -1 ; if the animation is tagged as vaginal or anal, and we are all females, we should have a strapon somewhere ...
                    Int receivingActorIndex = -1 ; index of actor receiving the strapon

                    If actorWithStrapOnIndex == 0
                        receivingActorIndex = 1
                    Else
                        receivingActorIndex = 0
                    EndIf

                    Actor actorWithStrapOn = actorList[actorWithStrapOnIndex]
                    Actor receivingActor = actorList[receivingActorIndex]
                    Bool isReceivingVictim = thread.IsVictim(receivingActor)

                    If Config.TraceMessagesEnabled
                        String rape = ""
                        If isReceivingVictim
                            rape = " (victim)"
                        EndIf   
                        Log("Actor with strap on : " + actorWithStrapOn.GetDisplayName() + ", receiving : " + receivingActor.GetDisplayName() + rape)
                    EndIf

                    If isVaginal
                        DisplayFemaleActorFemaleVaginalDescriptions(thread, isReceivingVictim, actorWithStrapOn, receivingActor, effectiveVoice, True, Framework.IsVaginalVirgin(receivingActor))                    
                    ElseIf isAnal
                        DisplayFemaleActorFemaleAnalDescriptions(thread, isReceivingVictim, actorWithStrapOn, receivingActor, effectiveVoice, True, Framework.IsAnalVirgin(receivingActor))      
                    ElseIf isBoobJob
                        DisplayFemaleActorFemaleBoobJobDescriptions(thread, isReceivingVictim, actorWithStrapOn, receivingActor, effectiveVoice, True)
                    EndIf
                EndIf
            ElseIf isForeplay
                ; who is primary and who is active? Gonna just use the default answers: that 0-PlayerRef, 1-other chick
                DisplayFemaleActorFemaleForeplayDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, True)
            ElseIf isCunnilingus
                ; who is primary and who is active? Gonna just use the default answers: that 0-PlayerRef, 1-other chick
                DisplayFemaleActorFemaleCunnilingusDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, True)
            ElseIf isFisting
                ; who is primary and who is active? Gonna just use the default answers: that 0-PlayerRef, 1-other chick
                DisplayFemaleActorFemaleFistingDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, True)
            ElseIf isFootJob
                ; who is primary and who is active? Gonna just use the default answers: that 0-PlayerRef, 1-other chick
                DisplayFemaleActorFemaleFootjobDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, True)
            ElseIf isHandJob
                ; who is primary and who is active? Gonna just use the default answers: that 0-PlayerRef, 1-other chick
                DisplayFemaleActorFemaleFootjobDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, True)
            EndIf            
        Else ; has Lesbian tag
            ; currently hardcoding False for virginitylost - cuz? I don't know! Do people consider lesbian sex virginity loss possible?
            DisplayFemaleActorFemaleLesbianDescriptions(thread, isPrimaryVictim, activeActor, primaryActor, effectiveVoice, True)
        EndIf

    ; Male and Male PC
    ElseIf isGaySex
        ; TODO
    EndIf

EndFunction

; Upon orgasm, set Virginal status here. No MCM config options are created to reset these,
; because I presume at some point to switch over to use SexLab's stats for
; tracking virginity, assuming they work for any NPC as well as PC.
Function Deflower(Actor anActor, Bool hadVaginalSex, Bool hadAnalSex, Bool hadOralSex)
    If hadVaginalSex && Framework.IsVaginalVirgin(anActor)
        SetIntValue(anActor, "hadVaginalSex", 1)
        If Config.DebugMessagesEnabled
            Log(anActor.GetDisplayName() + " just lost her vaginal virginity.")
        EndIf
    EndIf

    If hadAnalSex && Framework.IsAnalVirgin(anActor)
        SetIntValue(anActor, "hadAnalSex", 1)
        If Config.DebugMessagesEnabled
            Log(anActor.GetDisplayName() + " just lost anal virginity.")
        EndIf        
    EndIf
    
    If hadOralSex && Framework.IsOralVirgin(anActor)
        SetIntValue(anActor, "hadOralSex", 1)
        If Config.DebugMessagesEnabled
            Log(anActor.GetDisplayName() + " just lost oral virginity.")
        EndIf        
    EndIf
EndFunction

Function Log(String msg)
    Config.Log(msg, Source="AproposDescriptions")
EndFunction

Function Debug(String msg)
    Config.Debug(msg, Source="AproposDescriptions")
EndFunction

Function DisplayStageEndMessage(SslThreadController thread, Int stage)
; TODO
EndFunction

Function DisplayActorChangeStartMessage(SslThreadController thread)
; TODO
EndFunction

Function DisplayActorChangeEndMessage(SslThreadController thread)
; TODO
EndFunction

Function DisplayPositionChangeMessage(SslThreadController thread)
; TODO
EndFunction

Function DisplayOrgasmEndMessage(SslThreadController thread)
; TODO
EndFunction

Function DisplayAnimationChangeMessage(SslThreadController thread)
    ; Animation Change Events are currently not printing anything. still thinking about this...
EndFunction

    ; During stage start:
    ; 33% - say something about activeActor's arousal
    ; 33% - say something about primary female actor's arousal
    ; 33% - print description from db.txt file.

    ; If stage < 2
    ;     actorList[1].SetFactionRank(HadChangedAnimationFaction, -2)
    ; EndIf

    ; sslThreadController thisThread = SexLab.HookController(argString)
    
    ; ; switch animation
    ; If (2 <= stage && stage <= 3 && Utility.RandomInt(1, 100) < lvConfig.RapeAnimationSwitchProbability && actorList[1].GetFactionRank(HadChangedAnimationFaction) < 0)
    ;     thisThread.ChangeAnimation(Utility.RandomInt(1, 2) < 2)
    ;     actorList[1].SetFactionRank(HadChangedAnimationFaction, 0)
    ; EndIf
    
    ; Actor victim = SexLab.HookVictim(argString)
    
    ; If (victim != None)
    ;     ; go one stage back
    ;     If (2 < stage && stage <= 4)
    ;         Actor akRef = None
    ;         int i = 0
    ;         While i < actorList.length
    ;             If (victim != actorList[i])
    ;                 akRef = actorList[i]
    ;             EndIf
    ;             i += 1
    ;         EndWhile
            
    ;         If (Utility.RandomInt(1, 100) < (slaUtility.GetActorArousal(akRef) / 3))
    ;             thisThread.AdvanceStage(true)
    ;             Debug.Notification(akRef.GetLeveledActorBase().GetName() + " desires more...")
    ;         EndIf
    ;     EndIf
    ; EndIf