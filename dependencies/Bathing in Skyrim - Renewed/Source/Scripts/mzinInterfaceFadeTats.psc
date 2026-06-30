Scriptname mzinInterfaceFadeTats

Function FadeTats(Quest kFadeTattoos, Actor Target, Bool UsedSoap, Float FadeTatsFadeTime, Float FadeTatsSoapMult) Global
    if !kFadeTattoos
        return
    endIf

    Int appliedMap
    Int template
    Int appliedTattoos
    Int tattooEntry
    Int dataMap
    
    Float TatDuration
    
    String texturePath
    
    Float HoursToAge ; Hours
    
    If UsedSoap
        HoursToAge = FadeTatsFadeTime * FadeTatsSoapMult
    Else
        HoursToAge = FadeTatsFadeTime
    EndIf
    
    template = JValue.retain(JMap.object())
    appliedTattoos = JValue.retain(JArray.object())
    appliedMap = JFormDB.getObj(target, ".fTatsForm.appliedMap")
    SlaveTats.query_applied_tattoos(target, template, appliedTattoos)
    fadeTattoos.appliedMapFilterAndUpdate(appliedMap, appliedTattoos)
    Int i = JArray.count(appliedTattoos) - 1

    Debug.Trace("Mzin: Fade: Beginning fade tats")
    If i != -1
        while i >= 0 
            tattooEntry = JArray.getObj(appliedTattoos,i)
            texturePath = JMap.getStr(tattooEntry,"texture")
            Debug.Trace("Mzin: Fade: Procing " + texturePath)
            
            If SlaveTats.query_applied_tattoos(target, template, appliedTattoos)
                ; Error Occurred, silentely quit for now
                JValue.release(appliedTattoos)
                JValue.release(template)
                Debug.Trace("Mzin: Fade: Error")
                return
            EndIf
            JValue.release(template)

            dataMap = JMap.getObj(appliedMap,texturePath)
            TatDuration = JMap.getFlt(dataMap,"duration")
            TatDuration -= HoursToAge
            If TatDuration < 0.0
                TatDuration = 0.0
            EndIf
            JMap.setFlt(dataMap, "duration", TatDuration)
            
            i -= 1
        EndWhile
        (kFadeTattoos as fadeTattoos).updateForTarget(Target, appliedMap)
        
    EndIf
    JValue.release(appliedTattoos)
EndFunction