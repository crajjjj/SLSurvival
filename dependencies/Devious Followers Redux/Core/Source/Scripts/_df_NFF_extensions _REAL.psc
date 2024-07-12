Scriptname _df_NFF_extensions

String Function NffModName() Global
    Return "nwsFollowerFramework.esp"
EndFunction

Function AddFollower(Actor who) Global

    nwsFollowerControllerScript nffFollowerController = Game.GetFormFromFile(0x0000434F, NffModName()) As nwsFollowerControllerScript
    If nffFollowerController
        nffFollowerController.RecruitFollower(who)
    EndIf
    
EndFunction


Bool Function CanAddFollower() Global

    Actor[] followers = new Actor[10]
    Int howMany = FindFollowers(followers)
    
    Return howMany < 10

EndFunction


Function RemoveFollower(Actor who) Global

    nwsFollowerControllerScript nffFollowerController = Game.GetFormFromFile(0x0000434F, NffModName()) As nwsFollowerControllerScript
    If nffFollowerController
        nffFollowerController.RemoveAction(who, -9999, 0)
    EndIf

    EndFunction


Int Function CountDeviousFollowers(Faction ignoreFaction) Global

    Race dogCompanionRace = Game.GetForm(0x000F1AC4) As Race
    nwsFollowerVariableScript nwsVariables = Game.GetFormFromFile(0x0023CBC0, NffModName()) As nwsFollowerVariableScript

    If nwsVariables

        Int found = 0
        
        ; NFF tends to put followers at start of the aliases, but we have to check all of them anyway.
        Int ff = 10
        While ff
            ff -= 1
            ReferenceAlias foundAlias = nwsVariables.DialogueFollower.GetAlias(ff) As ReferenceAlias
            If foundAlias
                Actor foundActor = foundAlias.GetReference() As Actor
                If foundActor && !foundActor.IsInFaction(ignoreFaction) && foundActor.GetRace() != dogCompanionRace
                    found += 1
                EndIf
            EndIf
        EndWhile
       
        ;Debug.TraceConditional("DF - NFF - CountDeviousFollowers " + found, True)
        Return found
        
    EndIf
    
    Return -1
        
EndFunction

Int Function FindDeviousFollowers(Faction ignoreFaction, Actor[] foundFollowers) Global

    Race dogCompanionRace = Game.GetForm(0x000F1AC4) As Race
    nwsFollowerVariableScript nwsVariables = Game.GetFormFromFile(0x0023CBC0, NffModName()) As nwsFollowerVariableScript

    If nwsVariables

        Int found = 0
        Int findLimit = foundFollowers.Length
        
        Int ff = 10
        While ff
            ff -= 1
            ReferenceAlias foundAlias = nwsVariables.DialogueFollower.GetAlias(ff) As ReferenceAlias
            If foundAlias
                Actor foundActor = foundAlias.GetReference() As Actor
                If foundActor && !foundActor.IsInFaction(ignoreFaction) && foundActor.GetRace() != dogCompanionRace
                    foundFollowers[found] = foundActor
                    found += 1
                    If found == findLimit
                        Debug.TraceConditional("DF - NFF - CountDeviousFollowers " + found + " aborted due to hit the limit", True)
                        Return found
                    EndIf
                EndIf
            EndIf
        EndWhile

        ;Debug.TraceConditional("DF - NFF - CountDeviousFollowers " + found, True)
        Return found
        
    EndIf
    Debug.TraceConditional("DF - NFF - CountDeviousFollowers failed to get the script", True)
    Return -1
        
EndFunction


Int Function FindFollowers(Actor[] foundFollowers) Global

    ; This function will include any kind of follower, including dogs.
    nwsFollowerVariableScript nwsVariables = Game.GetFormFromFile(0x0023CBC0, NffModName()) As nwsFollowerVariableScript

    If nwsVariables

        Int found = 0
        Int findLimit = foundFollowers.Length
        
        Int ff = 10
        While ff
            ff -= 1
            ReferenceAlias foundAlias = nwsVariables.DialogueFollower.GetAlias(ff) As ReferenceAlias
            If foundAlias
                Actor foundActor = foundAlias.GetReference() As Actor
                If foundActor
                    foundFollowers[found] = foundActor
                    found += 1
                    If found == findLimit
                        Return found
                    EndIf
                EndIf
            EndIf
        EndWhile

        Return found
        
    EndIf
    
    Return -1
        
EndFunction


