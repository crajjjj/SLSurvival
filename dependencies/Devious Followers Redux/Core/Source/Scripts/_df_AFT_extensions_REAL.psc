Scriptname _df_AFT_extensions

Function AddFollower(Actor who) Global

    Form dialogFollower = Game.GetForm(0x000750BA)
    TweakDFScript aftScript = (dialogFollower As TweakDFScript)
    
    If aftScript
        aftScript.SetFollower(who)
    EndIf
    
EndFunction


Bool Function CanAddFollower() Global
    
    Actor[] followers = new Actor[5]
    Int howMany = FindFollowers(followers)
    
    Return howMany < 5

EndFunction


Function RemoveFollower(Actor who) Global

    Form dialogFollower = Game.GetForm(0x000750BA)
    TweakDFScript aftScript = (dialogFollower As TweakDFScript)
    
    If aftScript
        aftScript.DismissFollowerEx(who, 0, 0)
    EndIf

EndFunction


Int Function CountDeviousFollowers(Faction ignoreFaction) Global

    ; Vanilla DialogFollower quest is overridden by AFT
    Form dialogFollower = Game.GetForm(0x000750BA)
    TweakDFScript aftScript = (dialogFollower As TweakDFScript)
    Race dogCompanionRace = Game.GetForm(0x000F1AC4) As Race

    If aftScript

        Int found = 0
        
        Actor foundActor = aftScript.pFollowerAlias.GetReference() As Actor
        If foundActor && !foundActor.IsInFaction(ignoreFaction) && foundActor.GetRace() != dogCompanionRace
            found += 1
        EndIf
            
        foundActor = aftScript.pFollowerAlias2.GetReference() As Actor
        If foundActor && !foundActor.IsInFaction(ignoreFaction) && foundActor.GetRace() != dogCompanionRace
            found += 1
        EndIf

        foundActor = aftScript.pFollowerAlias3.GetReference() As Actor
        If foundActor && !foundActor.IsInFaction(ignoreFaction) && foundActor.GetRace() != dogCompanionRace
            found += 1
        EndIf
        
        foundActor = aftScript.pFollowerAlias4.GetReference() As Actor
        If foundActor && !foundActor.IsInFaction(ignoreFaction) && foundActor.GetRace() != dogCompanionRace
            found += 1
        EndIf
        
        foundActor = aftScript.pFollowerAlias5.GetReference() As Actor
        If foundActor && !foundActor.IsInFaction(ignoreFaction) && foundActor.GetRace() != dogCompanionRace
            found += 1
        EndIf
       
        Return found
        
    EndIf
    
    Return -1
        
EndFunction

Int Function FindDeviousFollowers(Faction ignoreFaction, Actor[] foundFollowers) Global

    ; Vanilla DialogFollower quest is overridden by AFT
    Form dialogFollower = Game.GetForm(0x000750BA)
    TweakDFScript aftScript = (dialogFollower As TweakDFScript)
    Race dogCompanionRace = Game.GetForm(0x000F1AC4) As Race

    If aftScript

        Int found = 0

        Actor foundActor = aftScript.pFollowerAlias.GetReference() As Actor
        If foundActor && !foundActor.IsInFaction(ignoreFaction) && foundActor.GetRace() != dogCompanionRace
            foundFollowers[found] = foundActor
            found += 1
        EndIf
            
        foundActor = aftScript.pFollowerAlias2.GetReference() As Actor
        If foundActor && !foundActor.IsInFaction(ignoreFaction) && foundActor.GetRace() != dogCompanionRace
            foundFollowers[found] = foundActor
            found += 1
        EndIf

        foundActor = aftScript.pFollowerAlias3.GetReference() As Actor
        If foundActor && !foundActor.IsInFaction(ignoreFaction) && foundActor.GetRace() != dogCompanionRace
            foundFollowers[found] = foundActor
            found += 1
        EndIf
        
        foundActor = aftScript.pFollowerAlias4.GetReference() As Actor
        If foundActor && !foundActor.IsInFaction(ignoreFaction) && foundActor.GetRace() != dogCompanionRace
            foundFollowers[found] = foundActor
            found += 1
        EndIf
        
        foundActor = aftScript.pFollowerAlias5.GetReference() As Actor
        If foundActor && !foundActor.IsInFaction(ignoreFaction) && foundActor.GetRace() != dogCompanionRace
            foundFollowers[found] = foundActor
            found += 1
        EndIf
       
        Return found
        
    EndIf
    
    Return -1
        
EndFunction


Int Function FindFollowers(Actor[] foundFollowers) Global

    ; This function will include any kind of follower, including dogs.
    ; Vanilla DialogFollower quest is overridden by AFT
    Form dialogFollower = Game.GetForm(0x000750BA)
    TweakDFScript aftScript = (dialogFollower As TweakDFScript)
    Race dogCompanionRace = Game.GetForm(0x000F1AC4) As Race

    If aftScript

        Int found = 0

        Actor foundActor = aftScript.pFollowerAlias.GetReference() As Actor
        If foundActor
            foundFollowers[found] = foundActor
            found += 1
        EndIf
            
        foundActor = aftScript.pFollowerAlias2.GetReference() As Actor
        If foundActor
            foundFollowers[found] = foundActor
            found += 1
        EndIf

        foundActor = aftScript.pFollowerAlias3.GetReference() As Actor
        If foundActor
            foundFollowers[found] = foundActor
            found += 1
        EndIf
        
        foundActor = aftScript.pFollowerAlias4.GetReference() As Actor
        If foundActor
            foundFollowers[found] = foundActor
            found += 1
        EndIf
        
        foundActor = aftScript.pFollowerAlias5.GetReference() As Actor
        If foundActor
            foundFollowers[found] = foundActor
            found += 1
        EndIf
       
        Return found
        
    EndIf
    
    Return -1
        
EndFunction


