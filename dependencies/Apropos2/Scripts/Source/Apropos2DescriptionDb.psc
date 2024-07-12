ScriptName Apropos2DescriptionDb Extends Apropos2SystemLibrary

Import Apropos2Util
Import ApUtil

Function ClearJCObjects()
    JDB.setObj(StoreKey("uniqueanimations"), 0)

    JDB.setObj(StoreKey("themes"), 0)
    JDB.setObj(StoreKey("themes-raw"), 0)

    JDB.setObj(StoreKey("synonyms"), 0)
    JDB.setObj(StoreKey("arousaladjectives"), 0)
    JDB.setObj(StoreKey("actors"), 0)
    
    JDB.setObj(StoreKey("weartearadjectives"), 0)
    JDB.setObj(StoreKey("wearteareffects"), 0)
    JDB.setObj(StoreKey("wearteardamage"), 0)
EndFunction

Function Setup()
    Parent.Setup()
    
    Debug("Initializing Apropos Database")
    InitializeUniqueAnimations()

    InitializeWearTearEffects()
    InitializeWearTearDamage()

    ;InitializeThemes()
    ;String maxTheme = SelectTheme(True)
    ;Debug("Selected theme for synonyms (W&T, Synonyms, Arousal) : " + maxTheme)

    InitializeWearAndTearAdjectives();maxTheme)
    InitializeSynonyms();maxTheme)
    InitializeArousalAdjectives();maxTheme)
    Debug("Apropos Database initialized")
EndFunction

Function InitializeThemes()
    ; load raw Themes definition into temporary JDB map
    Int rootMapId = LoadAndStoreJsonFile("Themes", "themes-raw") 

    If !rootMapId
        Return
    EndIf

    String[] allKeys = StringArrayFromJMapKeys(rootMapId)

    If !allKeys || allKeys.Length == 0
        Verbose("Unable to read any defined themes")
        Return
    EndIf

    ; Sum all weights across all enabled Themes to determine total sample space
    Int totalWeight = 0
    Int max = 0
    String maxTheme = ""

    Int i = 0
    While i < allKeys.Length
        Int val = JDB.solveInt(QueryKey("themes-raw", allKeys[i], "weight"))

        totalWeight += val

        If val > max
            max = val
            maxTheme = allKeys[i]
        EndIf

        i +=1
    EndWhile

    Int newMapId = RetainedMap()
    JMap.setInt(newMapId, "n", totalWeight)
    JMap.setStr(newMapId, "max", maxTheme)

    i = 0
    Int k = 0
    While i < allKeys.Length
        Int val = JDB.solveInt(QueryKey("themes-raw", allKeys[i], "weight"))

        Int j = 0

        While j < val
            JMap.setStr(newMapId, (j + k) As String, allKeys[i])
            j += 1
        EndWhile

        k += j
        i +=1
    EndWhile    

    JDB.setObj(StoreKey("themes"), newMapId)

    allKeys = StringArrayFromJMapKeys(newMapId)

    i = 0
    While i < allKeys.Length
        String aKey = allKeys[i]
        If aKey == "n"
            Trace("themes n=" + JMap.getInt(newMapId, aKey))
        ElseIf aKey == "max"
            Trace("themes max=" + JMap.getStr(newMapId, aKey))
        Else
            Trace("theme key: " + aKey + " => " + JMap.getStr(newMapId, aKey))
        EndIf
        i += 1
    EndWhile

EndFunction

Function InitializeWearTearDamage()
    Int rootMapId = LoadAndStoreJsonFile("WearAndTear_Damage", "wearteardamage")

    If !rootMapId || !Config.DebugMessagesEnabled
        Return
    EndIf 

    String[] allKeys = StringArrayFromJMapKeys(rootMapId)

    Int i = 0
    While i < allKeys.Length
        Float val = JDB.solveFlt(QueryKey("wearteardamage", allKeys[i]))
        Trace("Wear Tear Damage: " + allKeys[i] + " : " + val)
        i +=1
    EndWhile
EndFunction

Int Function GetScaledArousalAmountForConsumable(String consumable)
    ; Correlates healing amount => arousal increase.
    ; Higher healing amount, greater arousal incurred.
    ; Lerp(); x = consumable healing
    ;         x0 = min healing amount
    ;         x1 = max healing amount
    ;         y0 = min arousal (base = 2.0)
    ;         y1 = max arousal (100.0)
    String fullPath = GenerateFullPath("WearAndTear_Consumables")
    If CheckFileExists(fullPath)
        Int jobj = JValue.readFromFile(fullPath)

        If jobj != 0 
            JValue.retain(jobj)
            Int allValuesArray = JMap.allValues(jobj)
            Int maxHeal = JValue.evalLuaInt(allValuesArray, "return jc.accumulateValues(jobject, math.max)")
            Int minHeal = JValue.evalLuaInt(allValuesArray, "return jc.accumulateValues(jobject, math.min)")
            Int healAmount = JMap.getInt(jobj, consumable)
            Int scaled = Lerp(healAmount As Float, minHeal As Float, maxHeal As Float, Config.MinConsumableArousalIncr, Config.MaxConsumableArousalIncr) As Int
            Trace("consumables min value=" + minHeal + ", max=" + maxHeal + ", scaled arousal="+ scaled + " for " + consumable + " which has heal=" + healAmount)
            Return scaled
            JValue.release(jobj)
        EndIf
    EndIf
    Return -1 
EndFunction

Int Function GetWearTearConsumableHealAmount(String name)

    String fullPath = GenerateFullPath("WearAndTear_Consumables")
    If CheckFileExists(fullPath)
        Int jobj = JValue.readFromFile(fullPath)

        If jobj != 0 
            JValue.retain(jobj)
            Int healAmount = JMap.getInt(jobj, name)
            JValue.release(jobj)
            Return healAmount
        EndIf
    EndIf
    Return -1 
EndFunction

Function InitializeWearTearEffects()
    Int rootMapId = LoadAndStoreJsonFile("WearAndTear_Effects", "wearteareffects")

    If !rootMapId || !CheckIsJMap(rootMapId) || !Config.DebugMessagesEnabled
        Return
    EndIf   

    Bool success = True

    String[] allKeys = StringArrayFromJMapKeys(rootMapId)
    Int i = 0
    While i < allKeys.Length && success
        String outerKey = allKeys[i] ; 'oral', 'oral-hc'
        
        Int mapId = JDB.solveObj(QueryKey("wearteareffects", outerKey))

        If !CheckIsJMap(mapId)
            Debug("Could not read values for '" + QueryKey("wearteareffects", outerKey) + "'")
            success = False
        Else
            String[] subKeys = StringArrayFromJMapKeys(mapId) 
            
            Int j = 0

            While j < subKeys.Length && success
                String subKey = subKeys[j] ; level4
                mapId = JDB.solveObj(QueryKey("wearteareffects", outerKey, subKey))
                If !CheckIsJMap(mapId)
                    Debug("Could not read values for '" + QueryKey("wearteareffects", outerKey, subKey) + "'")
                    success = False
                Else
                    String[] itemKeys = StringArrayFromJMapKeys(mapId)

                    Int k = 0
                    While k < itemKeys.Length
                        String itemKey = itemKeys[k]
                        Int value = JMap.getInt(mapId, itemKey)
                        Trace(outerKey + "." + subKey + "." + itemKey + ":" + value)
                        k += 1
                    EndWhile
                EndIf
                j += 1
            EndWhile
        EndIf
        i += 1
    EndWhile

EndFunction

Function InitializeUniqueAnimations()
    Int rootMapId = LoadAndStoreJsonFile("UniqueAnimations", "uniqueanimations")

    If !rootMapId || !Config.DebugMessagesEnabled
        Return
    EndIf 

    String[] allKeys = StringArrayFromJMapKeys(rootMapId)

    Int i = 0
    While i < allKeys.Length
        Int val = JDB.solveInt(QueryKey("uniqueanimations", allKeys[i]))
        String disabled = ""
        If !val
            disabled = " (disabled)"
        EndIf
        Trace("unique animation: " + allKeys[i] + disabled)
        i +=1
    EndWhile

EndFunction

Function InitializeSynonyms();string theme)
    Int rootMapId = LoadAndStoreJsonFile("Synonyms", "synonyms");, theme)

    If !rootMapId || !Config.DebugMessagesEnabled
        Return
    EndIf

    String[] allKeys = StringArrayFromJMapKeys(rootMapId)
    
    Int index = 0
    
    Bool success = True
    
    While ((index < allKeys.Length) && success)
        String currentTokenName = allKeys[index]
        Int arrayId = JDB.solveObj(QueryKey("synonyms", currentTokenName))
        If !CheckIsJArray(arrayId)
            Debug("Could not read values for " + currentTokenName)
            success = False
        Else
            String[] values = StringArrayFromJArray(arrayId)
            Trace("Values for " + currentTokenName + " : " + StringArrayToString(values))
        EndIf
        index += 1
    EndWhile
    
    If success
        Debug("Synonyms successfully read, parsed and stored.")
    Else
        Debug("Could not read all synonyms.")
    EndIf
EndFunction

Function InitializeArousalAdjectives();string theme)
    Int rootMapId = LoadAndStoreJsonFile("Arousal_Descriptors", "arousaladjectives");, theme)

    If !rootMapId || !Config.DebugMessagesEnabled
        Return
    EndIf

    Bool success = True 

    String[] allKeys = StringArrayFromJMapKeys(rootMapId)

    Int i = 0
    While (i < allKeys.Length && success)
        String outerKey = allKeys[i]
        Int mapId = JDB.solveObj(QueryKey("arousaladjectives", outerKey))

        Debug("Values for " + outerKey)

        If !CheckIsJMap(mapId)
            Log("Could not read values for '" + QueryKey("arousaladjectives", outerKey) + "'")
            success = False
        Else

            String[] subKeys = StringArrayFromJMapKeys(mapId)
            
            Int j = 0

            While (j < subKeys.Length && success)
                String subKey = subKeys[j]
                Int arrayId = JDB.solveObj(QueryKey("arousaladjectives", outerKey, subKey))
                If !CheckIsJArray(arrayId)
                    Debug("Could not read values for '" + QueryKey("arousaladjectives", outerKey, subKey) + "'")
                    success = False
                EndIf
                String[] values = StringArrayFromJArray(arrayId)
                Trace("Values for " + subKey + " : " + StringArrayToString(values))
                j += 1
            EndWhile

        EndIf

        i += 1
    EndWhile

    If success
        Debug("Arousal Adjectives successfully read, parsed and stored.")
    Else
        Debug("Could not read all Arousal Adjectives.")
    EndIf    

EndFunction

Function InitializeWearAndTearAdjectives();string theme)
    Int rootMapId = LoadAndStoreJsonFile("WearAndTear_Descriptors", "weartearadjectives");, theme)

    If !rootMapId || !Config.DebugMessagesEnabled
        Return
    EndIf

    Bool success = True 

    Int wearTearMapId = JDB.solveObj(QueryKey("weartearadjectives.descriptors"))
    
    If !CheckIsJMap(wearTearMapId)
        Debug("Could not read values for '" + QueryKey("weartearadjectives.descriptors") + "'")
        success = False
    Else

        String[] allKeys = StringArrayFromJMapKeys(wearTearMapId)
        
        Int index = 0

        While (index < allKeys.Length && success)
            String currentKey = allKeys[index]
            Int arrayId = JDB.solveObj(QueryKey("weartearadjectives.descriptors", currentKey))
            If !CheckIsJArray(arrayId)
                Debug("Could not read values for '" + QueryKey("weartearadjectives.descriptors", currentKey) + "'")
                success = False
            EndIf
            String[] values = StringArrayFromJArray(arrayId)
            Trace("Values for " + currentKey + " : " + StringArrayToString(values))
            index += 1
        EndWhile

    EndIf

    If success
        Debug("Synonyms successfully read, parsed and stored.")
    Else
        Debug("Could not read all synonyms.")
    EndIf    

EndFunction

String Function GetRandomWearAndTearDescriptor(Int wearTearLevel)
    String lvl = "level" + SslUtility.ClampInt(wearTearLevel, 0, 9)
    Int arrayId = JDB.solveObj(QueryKey("weartearadjectives.descriptors", lvl))
    If !CheckIsJArray(arrayId)
        Return DummyArray()
    EndIf
    String[] values = StringArrayFromJArray(arrayId)
    Int random = Utility.RandomInt(0, values.Length - 1)
    Return values[random]
EndFunction

String Function GetMCMWearAndTearDescriptor(Int wearTearLevel)
    wearTearLevel = SslUtility.ClampInt(wearTearLevel, 0, 9)
    Int arrayId = JDB.solveObj(QueryKey("weartearadjectives.descriptors-mcm"))
    If !CheckIsJArray(arrayId)
        Return DummyArray()
    EndIf
    String[] values = StringArrayFromJArray(arrayId)
    Return values[wearTearLevel]
EndFunction

String[] Function GetAllMCMWearAndTearDescriptors()
    Int arrayId = JDB.solveObj(QueryKey("weartearadjectives.descriptors-mcm"))
        If !CheckIsJArray(arrayId)
        Return DummyArray()
    EndIf
    Return StringArrayFromJArray(arrayId)
EndFunction

String Function RandomSynonym(String tokenName)
    Int arrayId = JDB.solveObj(QueryKey("synonyms", tokenName))
    If arrayId == 0
        Debug("Could not find synonym array for " + tokenName)
        Return ""
    EndIf
    
    Int random = Utility.RandomInt(0, JArray.count(arrayId) - 1)
    Return JArray.getStr(arrayId, random)
EndFunction

String Function RandomArousal(String tokenName, Int arousalLevel)
    String lvl = "level" + SslUtility.ClampInt(arousalLevel, 0, 4)
    Int arrayId = JDB.solveObj(QueryKey("arousaladjectives", tokenName, lvl))
    If arrayId == 0
        Debug("Could not find arousal adjective array for " + tokenName)
        Return ""
    EndIf
    
    Int random = Utility.RandomInt(0, JArray.count(arrayId) - 1)
    Return JArray.getStr(arrayId, random)
EndFunction

String[] Function AllSynonymTokenNames()
    Return AllMapKeysAsStringArray("synonyms")
EndFunction

String[] Function AllMapKeysAsStringArray(String storageKey)
    Int mapId = JDB.solveObj(QueryKey(storageKey))
    If !CheckIsJMap(mapId)
        Debug("Could not read storageKey or storageKey is not a map : " + QueryKey(storageKey))
        Return DummyArray()
    EndIf
    Return StringArrayFromJMapKeys(mapId)
EndFunction

Bool Function IsUnique(String animation)
    Bool isUnique = JDB.solveInt(QueryKey("uniqueanimations", animation))
    If isUnique && Config.DebugMessagesEnabled
        Debug("animation " + animation + " is listed as unique")
    EndIf
    Return isUnique
EndFunction

; String Function SelectTheme(Bool selectMaxTheme = False)
;     If selectMaxTheme
;         String maxTheme = JDB.solveStr(QueryKey("themes", "max"))
;         Log("Selected (max) theme: " + maxTheme)
;         Return maxTheme
;     Else
;         Int n = JDB.solveInt(QueryKey("themes", "n"))
;         If n
;             Int i = Utility.RandomInt(0, n - 1)
;             String theme = JDB.solveStr(QueryKey("themes", (i As String)))
;             Log("Selected theme: " + theme)
;             Return theme
;         Else
;             Log("Could not find any configured themes")
;             Return ""
;         EndIf        
;     EndIf

; EndFunction

; sexPart = Oral, Anal, Vaginal, Boobjob, or GangBang
String Function RetrieveDescription(String anim, String subjectPrefix, String partner, Bool isActorVictim, Bool isOrgasm, String sexPart, String narrativeVoice)
    If config.TraceMessagesEnabled
        Debug("RetrieveDescription: " + anim + ",subject=" + subjectPrefix + ",partner=" + partner + "," + StringIfElse(isActorVictim, "actorIsVictim") + "," + StringIfElse(isOrgasm, "Orgasm") + "," + sexPart+","+narrativeVoice)
    EndIf

    String rape = ""
    If isActorVictim
        rape = "_Rape"
    EndIf
    
    String orgasm = ""
    If isOrgasm
        orgasm = "_Orgasm"
    EndIf

    Bool isUnique = IsUnique(anim)
    
    sexPart = "_" + sexPart
    partner = "_" + partner
    String animation = "_" + anim

    String fullPath

    If isUnique
        fullPath = GenerateFullPath(subjectPrefix + animation + rape + orgasm, subjectPrefix + animation)
        If Config.TraceMessagesEnabled
            Debug("Fullpath: " + fullPath)
        EndIf
    EndIf
    
    If !isUnique || !CheckFileExists(fullPath)
        If Config.TraceMessagesEnabled
            Debug("Animation: '" + anim + "' not listed as unique or not found. Falling back...")
        EndIf
        fullPath = GenerateFullPath(subjectPrefix + partner + sexPart + rape + orgasm, subjectPrefix + partner)
        If Config.TraceMessagesEnabled
            Debug("Fullpath: " + fullPath)
        EndIf
    EndIf

    If !CheckFileExists(fullPath)
        Debug("Final. Could not find file '" + fullPath + "'")
        Return ""
    EndIf
    
    Int arrayId = ReadDescriptionFileWithNarrativeVoice(fullPath, narrativeVoice)    
    If arrayId == 0
        Debug("Could not find file '" + fullPath + "'")
        Return ""
    EndIf

    Return GetStringFromArray(arrayId, fullPath, narrativeVoice)
EndFunction

String Function RetrieveStageProgressionDescription(String anim, String subjectPrefix, Bool isActorVictim, String partner, String sexPart, String narrativeVoice, Int stage)
    If config.TraceMessagesEnabled
        Log("RetrieveStageProgressionDescription: " + anim + ",subject=" + subjectPrefix + "," + StringIfElse(isActorVictim, "actorIsVictim") + ",partner=" + partner + "," + sexPart+","+narrativeVoice+ ",stage=" + stage)
    EndIf

    Bool isUnique = IsUnique(anim)

    sexPart = "_" + sexPart
    partner = "_" + partner
    String animation = "_" + anim

    String rape = ""
    If isActorVictim
        rape = "_Rape"
    EndIf    

    String stageStr = "_Stage" + stage

    String fullPath

    If isUnique
        fullPath = GenerateFullPath(subjectPrefix + animation + rape + stageStr, subjectPrefix + animation)
        If Config.TraceMessagesEnabled
            Debug("Fullpath: " + fullPath)
        EndIf        
    EndIf
    
    If !isUnique || !CheckFileExists(fullPath)
        If Config.TraceMessagesEnabled
            Debug("Animation: '" + anim + "' not listed as unique or not found. Falling back...")
        EndIf        
        fullPath = GenerateFullPath(subjectPrefix + partner + sexPart + rape + stageStr, subjectPrefix + partner)
        If Config.TraceMessagesEnabled
            Debug("Fullpath: " + fullPath)
        EndIf        
    EndIf

    If !CheckFileExists(fullPath)
        Debug("Final. Could not find file '" + fullPath + "'")
        Return ""
    EndIf    
    
    Int arrayId = ReadDescriptionFileWithNarrativeVoice(fullPath, narrativeVoice)    
    If !arrayId
        Debug("Could not find file '" + fullPath + "'")
        Return ""
    EndIf

    Return GetStringFromArray(arrayId, fullPath, narrativeVoice)
EndFunction

String Function RetrieveCustomFemaleDescription(String modName, String eventName, String narrativeVoice,  String bodyPart="", String partner="")
    If config.TraceMessagesEnabled
        Log("AproposDescriptionDb.RetrieveCustomFemaleDescription")
    EndIf

    eventName = "_" + eventName

    String fullPath = ""

    If bodyPart 
        bodyPart = "_" + bodyPart
    EndIf

    If partner 
        partner = "_" + partner
    EndIf

    If bodyPart 
        If partner
            fullPath = GenerateFullPath(modName + eventName + bodyPart + partner, modName)
        Else
            fullPath = GenerateFullPath(modName + eventName + bodyPart, modName)
        EndIf
    Else
        fullPath = GenerateFullPath(modName + eventName, modName)
    EndIf

    Debug("Using file '" + fullPath + "'")
    
    Int arrayId = ReadDescriptionFileWithNarrativeVoice(fullPath, narrativeVoice)    
    If !arrayId
        Debug("Could not find file '" + fullPath + "'")
        Return ""
    EndIf

    Return GetStringFromArray(arrayId, fullPath, narrativeVoice)    
EndFunction

String Function RetrieveFemaleWearTearChangedDescription(String change, String sexPart, String narrativeVoice)
    If config.TraceMessagesEnabled
        Log("RetrieveFemaleWearTearChangedDescription: " + sexPart+","+narrativeVoice)
    EndIf

    ; String theme = SelectTheme()

    ; sexPart = "_" + sexPart
    ; String fullPath = GenerateFullPath("FemaleActor_WearTear" + change + sexPart, "FemaleActor", theme)
    ; If theme && !CheckFileExists(fullPath)
    ;     ; fallback
    ;     fullPath = GenerateFullPath("FemaleActor_WearTear" + change + sexPart, "FemaleActor")
    ; EndIf

    sexPart = "_" + sexPart
    String fullPath = GenerateFullPath("FemaleActor_WearTear" + change + sexPart, "FemaleActor")
    
    Int arrayId = ReadDescriptionFileWithNarrativeVoice(fullPath, narrativeVoice)    
    If arrayId == 0
        Debug("Could not find file '" + fullPath + "'")
        Return ""
    EndIf

    Return GetStringFromArray(arrayId, fullPath, narrativeVoice)
EndFunction

String Function RetrieveGoBackDescription(String animation, String subjectPrefix, Bool isActorVictim, String partner, String sexPart, String narrativeVoice)
    If config.TraceMessagesEnabled
        Log("RetrieveGoBackDescription: " + animation + ",subject=" + subjectPrefix + "," + StringIfElse(isActorVictim, "actorIsVictim") + ",partner=" + partner + "," + sexPart+","+narrativeVoice)
    EndIf

    sexPart = "_" + sexPart
    partner = "_" + partner

    String rape = ""
    If isActorVictim
        rape = "_Rape"
    EndIf    

    String goBack = "_GoBack"

    String fullPath = GenerateFullPath(subjectPrefix + partner + sexPart + goBack + rape, subjectPrefix + partner)
    
    If !CheckFileExists(fullPath)
        fullPath = GenerateFullPath(subjectPrefix + goBack + sexPart + rape, subjectPrefix)
    EndIf
    
    Int arrayId = ReadDescriptionFileWithNarrativeVoice(fullPath, narrativeVoice)    
    If !arrayId
        Debug("Could not find file '" + fullPath + "'")
        Return ""
    EndIf

    Return GetStringFromArray(arrayId, fullPath, narrativeVoice)
EndFunction

String Function DisplayLoadDescriptions(String animation, String subjectPrefix, Bool isActorVictim, String partner, String sexPart, String narrativeVoice, String load)
    If config.TraceMessagesEnabled
        Log("DisplayLoadDescriptions: " + animation + ",subject=" + subjectPrefix + "," + StringIfElse(isActorVictim, "actorIsVictim") + ",partner=" + partner + "," + sexPart+","+narrativeVoice+","+load)
    EndIf

    sexPart = "_" + sexPart
    partner = "_" + partner

    String rape = ""
    If isActorVictim
        rape = "_Rape"
    EndIf    

    load = "_" + load

    String fullPath = GenerateFullPath(subjectPrefix + partner + sexPart + load + rape, subjectPrefix + partner)
    
    If !CheckFileExists(fullPath)
        fullPath = GenerateFullPath(subjectPrefix + load + sexPart + rape, subjectPrefix)
    EndIf
    
    Int arrayId = ReadDescriptionFileWithNarrativeVoice(fullPath, narrativeVoice)    
    If !arrayId
        Debug("Could not find file '" + fullPath + "'")
        Return ""
    EndIf

    Return GetStringFromArray(arrayId, fullPath, narrativeVoice)
EndFunction

String Function RetrieveVirginityLostDescription(String subjectPrefix, String sexPart, String narrativeVoice, Bool isActorVictim)
    If config.TraceMessagesEnabled
        Log("RetrieveVirginityLostDescription: " + subjectPrefix + "," + StringIfElse(isActorVictim, "actorIsVictim") +"," + sexPart+","+narrativeVoice)
    EndIf
    
    String rape = ""
    If isActorVictim
        rape = "_Rape"
    EndIf

    ; String theme = SelectTheme()
    
    ; sexPart = "_" + sexPart
    ; String fullPath = GenerateFullPath(subjectPrefix + "_VirginityLost" + sexPart + rape, subjectPrefix, theme)
    ; If theme && !CheckFileExists(fullPath)
    ;     ; fallback
    ;     fullPath = GenerateFullPath(subjectPrefix + "_VirginityLost" + sexPart + rape, subjectPrefix)
    ; EndIf

    sexPart = "_" + sexPart
    String fullPath = GenerateFullPath(subjectPrefix + "_VirginityLost" + sexPart + rape, subjectPrefix)
    
    Int arrayId = ReadDescriptionFileWithNarrativeVoice(fullPath, narrativeVoice)    
    If !arrayId
        Debug("Could not find file '" + fullPath + "'")
        Return ""
    EndIf
    
    Return GetStringFromArray(arrayId, fullPath, narrativeVoice)
EndFunction

String Function RetrieveMasturbationDescription(String animName, String subjectPrefix, Bool isOrgasm, String narrativeVoice, Int stageNumber = 0)
    If config.TraceMessagesEnabled
        Log("RetrieveMasturbationDescription: " + animName + ",subject=" + subjectPrefix +","+narrativeVoice)
    EndIf

    String orgasm = ""
    If isOrgasm
        orgasm = "_Orgasm"
    EndIf

    String stage = ""
    If stageNumber > 0
        stage = "_Stage" + stageNumber
    EndIf

    ; String theme = SelectTheme()
    
    ; String fullPath = GenerateFullPath(subjectPrefix + "_Masturbation" + orgasm + stage, subjectPrefix, theme)
    ; If theme && !CheckFileExists(fullPath)
    ;     ; fallback
    ;     fullPath = GenerateFullPath(subjectPrefix + "_Masturbation" + orgasm + stage, subjectPrefix)
    ; EndIf

    String fullPath = GenerateFullPath(subjectPrefix + "_Masturbation" + orgasm + stage, subjectPrefix)
    
    Int arrayId = ReadDescriptionFileWithNarrativeVoice(fullPath, narrativeVoice)    
    If !arrayId
        Debug("Could not find file '" + fullPath + "'")
        Return ""
    EndIf
    
    Return GetStringFromArray(arrayId, fullPath, narrativeVoice)
EndFunction

Int Function ReadDescriptionFileWithNarrativeVoice(String fullPath, String narrativeVoice)
    
    If !CheckFileExists(fullPath)
        Return 0
    EndIf
    
    Int rootMap = JValue.readFromFile(fullPath)
    
    If !rootMap
        Debug("Problems parsing file '" + fullPath + "'. Check Json validity at jsonlint.com")
        Return 0
    EndIf   
    
    If !JMap.hasKey(rootMap, narrativeVoice)
        Debug("Could not find narrative voice '" + narrativeVoice + "' for file '" + fullPath + "'. Also check Json validity at jsonlint.com")
        Return 0
    EndIf
    
    Return JMap.getObj(rootMap, narrativeVoice)
EndFunction

String Function GetStringFromArray(Int arrayId, String fullPath, String narrativeVoice)
    String result = ""
    Int count = JArray.count(arrayId)
    If count == 0
        If config.DebugMessagesEnabled
            Debug("Apparently there are no descriptions in the file '" + fullPath + "' for the narrative voice " + narrativeVoice)
        EndIf        
    Else
        Int random = Utility.RandomInt(0, count - 1)
        result = JArray.getStr(arrayId, random)
        If !result
            If config.DebugMessagesEnabled
                Debug("Apparently there are no descriptions in the file '" + fullPath + "' for the narrative voice " + narrativeVoice)
            EndIf
        ElseIf config.TraceMessagesEnabled
            Log("AproposDescriptionDb.GetStringFromArray() returning: " + result)
        EndIf        
    EndIf
    Return result
EndFunction

String Function DisplayFemaleActorLoadDescriptions(String animation, Bool isActorVictim, String partner, String sexPart, String narrativeVoice, String load)
    Return DisplayLoadDescriptions(animation, "FemaleActor", isActorVictim, partner, sexPart, narrativeVoice, load)
EndFunction

String Function DisplayMaleActorLoadDescriptions(String animation, Bool isActorVictim, String partner, String sexPart, String narrativeVoice, String load)
    Return DisplayLoadDescriptions(animation, "MaleActor", isActorVictim, partner, sexPart, narrativeVoice, load)
EndFunction

String Function RetrieveFemaleGoBackDescription(String animation, Bool isActorVictim, String partner, String sexPart, String narrativeVoice)
    Return RetrieveGoBackDescription(animation, "FemaleActor", isActorVictim, partner, sexPart, narrativeVoice)
EndFunction

String Function RetrieveMaleGoBackDescription(String animation, Bool isActorVictim, String partner, String sexPart, String narrativeVoice)
    Return RetrieveGoBackDescription(animation, "MaleActor", isActorVictim, partner, sexPart, narrativeVoice)
EndFunction

String Function RetrieveFemaleMasturbationDescription(String animation, Bool isOrgasm, String narrativeVoice, Int stageNumber = 0)
    Return RetrieveMasturbationDescription(animation, "FemaleActor", isOrgasm, narrativeVoice, stageNumber)
EndFunction

String Function RetrieveMaleMasturbationDescription(String animation, Bool isOrgasm, String narrativeVoice, Int stageNumber = 0)
    Return RetrieveMasturbationDescription(animation, "MaleActor", isOrgasm, narrativeVoice, stageNumber)
EndFunction

String Function RetrieveFemaleStageProgressionDescription(String animation, String partner, Bool isVictim, String sexPart, String narrativeVoice, Int stage)
    Return RetrieveStageProgressionDescription(animation, "FemaleActor", isVictim, partner, sexPart, narrativeVoice, stage)
EndFunction

String Function RetrieveMaleStageProgressionDescription(String animation, String partner, Bool isVictim, String sexPart, String narrativeVoice, Int stage)
    Return RetrieveStageProgressionDescription(animation, "MaleActor", isVictim, partner, sexPart, narrativeVoice, stage)
EndFunction

String Function RetrieveFemaleVirginityLostDescription(Bool isActorVictim, String sexPart, String narrativeVoice)
    Return RetrieveVirginityLostDescription("FemaleActor", sexPart, narrativeVoice, isActorVictim)   
EndFunction

String Function RetrieveMaleVirginityLostDescription(Bool isActorVictim, String sexPart, String narrativeVoice)
    Return RetrieveVirginityLostDescription("MaleActor", sexPart, narrativeVoice, isActorVictim)   
EndFunction

; sexPart = Oral, Anal, Vaginal, Boobjob, or GangBang
String Function RetrieveFemaleDescription(String animation, String partner, Bool isActorVictim, Bool isOrgasm, String sexPart, String narrativeVoice)
    Return RetrieveDescription(animation, "FemaleActor", partner, isActorVictim, isOrgasm, sexPart, narrativeVoice)   
EndFunction

; sexPart = Oral, Anal, Vaginal, Boobjob, or GangBang
String Function RetrieveMaleDescription(String animation, String partner, Bool isActorVictim, Bool isOrgasm, String sexPart, String narrativeVoice)
    Return RetrieveDescription(animation, "MaleActor", partner, isActorVictim, isOrgasm, sexPart, narrativeVoice)
EndFunction

String Function ReplaceTokens(String source, Int tokenMapId)
    ;Debug("ReplaceTokens")
    ;DebugJC(tokenMapId, "TokenMap:")

    If False ; config.TraceMessagesEnabled
        Int allKeys = JMap.allKeys(tokenMapId)
        DebugJC(allKeys, "TokenNames:")
        Int allValues = JMap.allValues(tokenMapId)
        DebugJC(allValues, "TokenValues:")
        ;Log("TokenNames : " + StringArrayToString(StringArrayFromJArray(allKeys)))
        ;Log("TokenValues : " + StringArrayToString(StringArrayFromJArray(allValues)))
    EndIf
    
    String result = ""
    
    While StringUtil.GetLength(source) > 0
        ;ToUserLog("source = " + source)
        Int sourceLength = StringUtil.GetLength(source)
        
        Int indexTokenStart = StringUtil.Find(source, "{")
        Int indexTokenEnd = StringUtil.Find(source, "}")
        
        ;ToUserLog("0. indexTokenStart = " + indexTokenStart + ", indexTokenEnd = " + indexTokenEnd)
        
        If indexTokenStart != -1 && indexTokenEnd != -1
            String tokenName = Substring(source, indexTokenStart, indexTokenEnd - indexTokenStart + 1);
            ;ToUserLog("1. tokenName = " + tokenName)
            ;ToUserLog("2. tokenIndex = " + tokenIndex)
            String beforeToken = Substring(source, 0, indexTokenStart);
            String afterToken = Substring(source, indexTokenEnd + 1, sourceLength - (indexTokenEnd + 1));
            ;ToUserLog("3. beforeToken = " + beforeToken)
            ;ToUserLog("4. afterToken = " + afterToken)
            If JMap.hasKey(tokenMapId, tokenName)
                String tokenValue = JMap.getStr(tokenMapId, tokenName)
                ;ToUserLog("Replacing '" + tokenName + "' with value '" + tokenValue + "'")
                If tokenValue == ""
                    result = result + TrimEnd(beforeToken)
                Else
                    result = result + beforeToken + tokenValue;
                EndIf
                ;ToUserLog("5. result = " + result)
            Else
                result = result + beforeToken
                ;ToUserLog("6. result = " + result)					
            EndIf                
            
            source = afterToken;
        Else
            result = result + source;
            ;ToUserLog("7. result = " + result)
            source = "";
        EndIf
        
    EndWhile

    If Config.TraceMessagesEnabled
        Log("AproposDescriptionDb.ReplaceTokens returned : " + result)
    EndIf
    
    Return result
    
EndFunction

Function Log(String msg)
    Config.Log(msg, Source="AproposDescriptionDb")
EndFunction

Function Debug(String msg)
    Config.Debug(msg, Source="AproposDescriptionDb")
EndFunction

Function Trace(String msg)
    If !Config.TraceMessagesEnabled
        Return
    EndIf
    Config.Debug(msg, Source="AproposDescriptionDb")
EndFunction

Function Verbose(String msg)
    If !Config.TraceMessagesEnabled
        Return
    EndIf
    Config.Verbose(msg, Source="Apropos2DescriptionDb")
EndFunction