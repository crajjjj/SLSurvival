Scriptname _df_global

Bool Function CanDismissFollower(Actor who) Global

    Debug.Trace("DF - CanDismissFollower? " + who.GetActorBase().GetName())
    
    ;Debug.TraceStack("DF - Stack dump on purpose: ", 2)
    
    Int stage = -1
    Quest dfMain = Game.GetFormFromFile(0x00000D62, "DeviousFollowers.esp") As Quest
    If dfMain 
        stage = dfMain.GetStage()
        If stage < 10
            Debug.Trace("DF - CanDismissFollower - OK - stage " + stage + " < 10")
            _df_global.DismissFromDF(who)
            Return True
        EndIf
        Debug.Trace("DF - CanDismissFollower - stage not OK  " + stage + " >= 10")
        ; But can still dismiss them if they are ignored...
    EndIf
    
    Faction facIgnore = Game.GetFormFromFile(0x090B8A73, "DeviousFollowers.esp") As Faction
    If facIgnore && who.IsInFaction(facIgnore)
        Debug.Trace("DF - CanDismissFollower - OK - faction says ignore")
        Return True
    EndIf
    
    Debug.Trace("DF - CanDismissFollower - NO - cannot dismiss, not ignored and stage is " + stage)
    Return False
    
EndFunction

Function DismissFromDF(Actor who) Global
    _DflowFollowerController controller = Game.GetFormFromFile(0x001B5B9E, "DeviousFollowers.esp") As _DflowFollowerController
    controller.DismissFromFramework(who)
EndFunction
    
