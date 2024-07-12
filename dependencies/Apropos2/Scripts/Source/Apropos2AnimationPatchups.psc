ScriptName Apropos2AnimationPatchups Extends Apropos2SystemLibrary

Import Apropos2Util
Import ApUtil

Function Setup()
    Parent.Setup()
    Log("Setup")
EndFunction

Function ApplyPatchups()
    Debug("ApplyPatchups")

    Int rootMapId = LoadJsonFile("AnimationPatchups")
    If !rootMapId
        Return
    EndIf

    JValue.retain(rootMapId)

    String[] allkeys = StringArrayFromJMapKeys(rootMapId)

    Int i = 0
    While i < allKeys.Length
        String animationName = allKeys[i]
        If Config.DebugMessagesEnabled
            Log("Patchup " + animationName + "...")
        EndIf
        Int mapId = JMap.getObj(rootMapId, animationName)

        If JMap.hasKey(mapId, "RemoveTags")
            String[] tagsToRemove = StringArrayFromJArray(JMap.getObj(mapId, "RemoveTags"))
            If Config.DebugMessagesEnabled
                Log("... RemoveTags: " + StringArrayToString(tagsToRemove))
            EndIf
            RemoveTags(animationName, tagsToRemove)
        EndIf

        If JMap.hasKey(mapId, "AddTags")
            String[] tagsToAdd = StringArrayFromJArray(JMap.getObj(mapId, "AddTags"))
            If Config.DebugMessagesEnabled
                Log("... AddTags: " + StringArrayToString(tagsToAdd))
            EndIf            
            AddTags(animationName, tagsToAdd)
        EndIf

        i += 1
    EndWhile
    
    JValue.release(rootMapId)

EndFunction

Function AddTags(String animationName, String[] tagsToAdd)
    SslBaseAnimation anim = SexLab.CreatureSlots.GetByRegistrar(animationName)
    if anim
        DoAddTags(anim, tagsToAdd)
    Else
        anim = SexLab.AnimSlots.GetByRegistrar(animationName)
        If anim
            DoAddTags(anim, tagsToAdd)
        Else
            Log("AddTags: Could not find animation '" + animationName + "' in either creature or normal slots")
        EndIf
    EndIf
EndFunction

Function DoAddTags(SslBaseAnimation anim, String[] tagsToAdd)
    if anim
        Debug("Adding '" + StringArrayToString(tagsToAdd) + "' to " +  anim.Name)
        Int i = tagsToAdd.Length
        While i
            i -= 1
            anim.AddTag(tagsToAdd[i])
        EndWhile
    EndIf
EndFunction

Function RemoveTags(String animationName, String[] tagsToRemove)
    SslBaseAnimation anim = SexLab.CreatureSlots.GetByRegistrar(animationName)
    if anim
       DoRemoveTags(anim, tagsToRemove)
    Else
        anim = SexLab.AnimSlots.GetByRegistrar(animationName)
        If anim
            DoRemoveTags(anim, tagsToRemove)
        Else
            Log("RemoveTags: Could not find animation '" + animationName + "' in either creature or normal slots")
        EndIf
    EndIf
EndFunction

Function DoRemoveTags(SslBaseAnimation anim, String[] tagsToRemove)
    if anim
        Debug("Removing '" + StringArrayToString(tagsToRemove) + "' from " +  anim.Name)
        Int i = tagsToRemove.Length
        While i
            i -= 1
            anim.RemoveTag(tagsToRemove[i])
        EndWhile
    EndIf
EndFunction

Function VaginalToAnal(String animationName)
    RemoveTags(animationName, Strings("Vaginal"))
    AddTags(animationName, Strings("Anal"))
EndFunction

Function AnalToVaginal(String animationName)
    RemoveTags(animationName, Strings("Anal"))
    AddTags(animationName, Strings("Vaginal"))
EndFunction

Function AnalToOral(String animationName)
    RemoveTags(animationName, Strings("Anal"))
    AddTags(animationName, Strings("Oral"))
EndFunction

Function Log(String msg, String display="trace, console")
    Config.Log(msg, Source="Apropos2AnimationPatchups")
EndFunction

Function Debug(String msg)
    Config.Log(msg, Source="Apropos2AnimationPatchups")
EndFunction

