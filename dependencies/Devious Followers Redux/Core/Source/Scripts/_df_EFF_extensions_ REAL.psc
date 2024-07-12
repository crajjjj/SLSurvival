Scriptname _df_EFF_extensions

Function AddFollower(Actor who) Global

    EFFCore effCoreScript = Game.GetFormFromFile(0x00000EFF, "EFFCore.esm") As EFFCore
    If effCoreScript
        effCoreScript.XFL_AddFollower(who)
    EndIf

EndFunction


Bool Function CanAddFollower() Global
    
    Debug.Trace("DF - EFF - CanAddFollower?")
    EFFCore effCoreScript = Game.GetFormFromFile(0x00000EFF, "EFFCore.esm") As EFFCore
    If effCoreScript
        Int howMany = effCoreScript.XFL_GetCount()
        Debug.Trace("DF - EFF - CanAddFollower, have " + howMany + ", limit is 6")
        Return howMany < 6
    EndIf
    
    Return False
    
EndFunction


Function RemoveFollower(Actor who) Global

    Debug.Trace("DF - EFF - RemoveFollower " + who.GetActorBase().GetName())
    EFFCore effCoreScript = Game.GetFormFromFile(0x00000EFF, "EFFCore.esm") As EFFCore
    If effCoreScript
        effCoreScript.XFL_RemoveFollower(who, -9999, 0)
    EndIf

EndFunction


Int Function CountDeviousFollowers(Faction ignoreFaction) Global

    ; Haven't actually checked EFF puts dog followers in this list ... Saw some vague signs they are special.
    Race dogCompanionRace = Game.GetForm(0x000F1AC4) As Race
    EFFCore effCoreScript = Game.GetFormFromFile(0x00000EFF, "EFFCore.esm") As EFFCore

    If effCoreScript

        Int found = 0
        
        Int ff = effCoreScript.XFL_FollowerList.GetSize()
        While ff
            ff -= 1
            Actor foundActor = effCoreScript.XFL_FollowerList.GetAt(ff) As Actor
            
            If foundActor && !foundActor.IsInFaction(ignoreFaction) && foundActor.GetRace() != dogCompanionRace
                found += 1
            EndIf
        
        EndWhile
       
        Return found
        
    EndIf
    
    Return -1
        
EndFunction

Int Function FindDeviousFollowers(Faction ignoreFaction, Actor[] foundFollowers) Global

    Race dogCompanionRace = Game.GetForm(0x000F1AC4) As Race
    EFFCore effCoreScript = Game.GetFormFromFile(0x00000EFF, "EFFCore.esm") As EFFCore
       
    If effCoreScript

        Int found = 0
        Int findLimit = foundFollowers.Length
        
        Int ff = effCoreScript.XFL_FollowerList.GetSize()
        While ff
            ff -= 1
            Actor foundActor = effCoreScript.XFL_FollowerList.GetAt(ff) As Actor
            
            If foundActor && !foundActor.IsInFaction(ignoreFaction) && foundActor.GetRace() != dogCompanionRace
                foundFollowers[found] = foundActor
                found += 1
                If found == findLimit
                    Return found
                EndIf
            EndIf
        
        EndWhile

        Return found
        
    EndIf
    
    Return -1
        
EndFunction


Int Function FindFollowers(Actor[] foundFollowers) Global

    ; This function will include any kind of follower, including dogs.
    EFFCore effCoreScript = Game.GetFormFromFile(0x00000EFF, "EFFCore.esm") As EFFCore
       
    If effCoreScript

        Int found = 0
        Int findLimit = foundFollowers.Length
        
        Int ff = effCoreScript.XFL_FollowerList.GetSize()
        While ff
            ff -= 1
            Actor foundActor = effCoreScript.XFL_FollowerList.GetAt(ff) As Actor
            
            If foundActor
                foundFollowers[found] = foundActor
                found += 1
                If found == findLimit
                    Return found
                EndIf
            EndIf
        
        EndWhile

        Return found
        
    EndIf
    
    Return -1
        
EndFunction


