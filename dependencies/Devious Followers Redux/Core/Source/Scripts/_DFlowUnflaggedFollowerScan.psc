Scriptname _DFlowUnflaggedFollowerScan extends Quest  

Faction Property _DFDisable Auto
Faction Property _DFMaster Auto

; Tragically this DOES NOT WORK ... if the script that starts the quest is on the quest object the aliases are not filled.
Function SetAllFollowersToIgnored()

    GoToState("Busy")
    
    Int totalProcessed = 0
    
    Debug.TraceConditional("DF - SetAllFollowersToIgnored - Begin", True)
    Stop()
    Start()
    Utility.Wait(1.1)
    
    While IsRunning()
        Debug.TraceConditional("DF - SetAllFollowersToIgnored - IsRunning", True)
        
        Int processed = 0
        Int ii = 0
        While ii < 10
            Debug.TraceConditional("DF - SetAllFollowersToIgnored - check alias " + ii, True)
            ReferenceAlias followerAlias = GetNthAlias(ii) As ReferenceAlias
            
            If followerAlias
            
                Debug.TraceConditional("DF - SetAllFollowersToIgnored - alias " + ii + " exists", True)
                
                Actor follower = followerAlias.GetActorRef()
                If follower
                    follower.SetFactionRank(_DFDisable, 0)
                    follower.RemoveFromFaction(_DFMaster)
                    processed += 1
                    Debug.TraceConditional("DF - SetAllFollowersToIgnored - alias " + ii + " has a follower " + follower.GetActorBase().GetName(), True)
                EndIf
                
            EndIf
            
            ii += 1
        EndWhile
        Stop()
        
        If True || 0 == processed
            Debug.TraceConditional("DF - SetAllFollowersToIgnored - is stopping!", True)
            Utility.Wait(0.1)
        Else
            totalProcessed += processed
            Reset()
            Start()
            Debug.TraceConditional("DF - SetAllFollowersToIgnored - is scanning again...", True)
            Utility.Wait(1.1)
        EndIf
        
        
    EndWhile
    Debug.TraceConditional("DF - SetAllFollowersToIgnored - process " + totalProcessed + " followers", True)
    
    Debug.Notification("$DF_IGNORE_COMPLETE_1")
    Debug.Notification("$DF_IGNORE_COMPLETE_2")
    Debug.TraceConditional("DF - SetAllFollowersToIgnored - End", True)
    GoToState("")

EndFunction


State Busy
    ; We don't want the user to start two of these!
    Function SetAllFollowersToIgnored()
        Debug.TraceConditional("DF - SetAllFollowersToIgnored - Busy - do nothing", True)
    EndFunction
EndState
