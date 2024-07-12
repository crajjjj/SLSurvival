Scriptname _DflowFollowerController extends Quest  

Quest Property pDialogueFollower Auto
SetHirelingRehire Property HirelingRehireScript Auto
QF__Gift_09000D62 Property Q Auto
_DFSold Property Sold Auto
_DFLicensing Property _DFLicenses Auto


Faction Property CurrentHireling  Auto
Faction Property pDismissedFollower Auto
Faction Property PotentialHireling Auto
Faction Property _DFDisable Auto ; No longer used, though the same value is passed IN from outside. Use Q.IsIgnore() instead.

GlobalVariable Property pPlayerFollowerCount Auto

Weapon Property FollowerHuntingBow Auto
Ammo Property FollowerIronArrow Auto
ReferenceAlias Property Alias__DMaster Auto ; Main _DFlow Master alias
MiscObject Property Gold  Auto

ActorBase Property Belrand  Auto
ActorBase Property Erik  Auto
ActorBase Property Jenassa  Auto
ActorBase Property Marcurio  Auto
ActorBase Property Stenvar  Auto
ActorBase Property Vorstag  Auto

GlobalVariable Property _DFFollowerCount Auto
GlobalVariable Property HirelingGold  Auto
GlobalVariable Property HirelingRecognizeStenvar  Auto  ; HirelingRecognizeStenvar.Value=1
GlobalVariable Property HirelingRecognizeJenassa  Auto
GlobalVariable Property HirelingRecognizeBelrand  Auto
GlobalVariable Property HirelingRecognizeErik  Auto
GlobalVariable Property HirelingRecognizeMarcurio  Auto
GlobalVariable Property HirelingRecognizeVorstag  Auto

GlobalVariable Property GameDaysPassed  Auto
GlobalVariable Property CanRehireBelrand  Auto
GlobalVariable Property CanRehireErik  Auto
GlobalVariable Property CanRehireJenassa  Auto
GlobalVariable Property CanRehireMarcurio  Auto
GlobalVariable Property CanRehireStenvar  Auto
GlobalVariable Property CanRehireVorstag  Auto

; Doing this is probably quite wrong.
Function ResetHirelingFlags()
    HirelingRecognizeJenassa.SetValue(0.0)
    HirelingRecognizeMarcurio.SetValue(0.0)
    HirelingRecognizeStenvar.SetValue(0.0)
    HirelingRecognizeVorstag.SetValue(0.0)
    HirelingRecognizeBelrand.SetValue(0.0)
    HirelingRecognizeErik.SetValue(0.0)
EndFunction


Bool Function FrameworkCanAddFollower()

    If 255 != Game.GetModByName("AmazingFollowerTweaks.esp")
        Return _df_AFT_extensions.CanAddFollower()
    EndIf
    
    If 255 != Game.GetModByName("EFFCore.esm")
        Return _df_EFF_extensions.CanAddFollower()
    EndIf

    If 255 != Game.GetModByName("nwsFollowerFramework.esp")
        Return _df_NFF_extensions.CanAddFollower()
    EndIf
    
    ; Vanilla follower 
    ReferenceAlias followerAlias = (pDialogueFollower As DialogueFollowerScript).pFollowerAlias
    If followerAlias
        Actor follower = followerAlias.GetActorRef()
        If follower
            Return False
        EndIf
        Return True
    EndIf
    
    Return False

    EndFunction

Function AddFollowerToFramework(Actor who)

    If 255 != Game.GetModByName("AmazingFollowerTweaks.esp")
        _df_AFT_extensions.AddFollower(who)
        Return
    EndIf
    
    If 255 != Game.GetModByName("EFFCore.esm")
        Debug.TraceConditional("DF - AddFollowerToFramework - add follower to EFF " + who.GetActorBase().GetName(), True)
        _df_EFF_extensions.AddFollower(who)
        Return
    EndIf

    If 255 != Game.GetModByName("nwsFollowerFramework.esp")
        _df_NFF_extensions.AddFollower(who)
        Return
    EndIf
    
    ; Vanilla follower 
    Debug.TraceConditional("DF - AddFollowerToFramework - SetFollower", True)
    (pDialogueFollower As DialogueFollowerScript).SetFollower(who)

EndFunction

; There was NEVER a reason for this to be an ObjectReference instead of an Actor, but too late to fix it now.
Function AddFollower(ObjectReference followerRef)

    Debug.TraceConditional("DF - AddFollower - form " + followerRef.GetFormID(), True)
    Actor follower = followerRef As Actor
    
    If follower && FrameworkCanAddFollower()
    
        Debug.TraceConditional("DF - AddFollower - " + follower.GetActorBase().GetName(), True)
        If follower.IsInFaction(PotentialHireling)
        
            Debug.TraceConditional("DF - AddFollower - is hireling", True)
            follower.AddToFaction(CurrentHireling)
            
            ; The appropriate "recognize" flag is only relevant if the hireling is ignored
            If Q.IsIgnore(follower)
                
                ActorBase thisHireling = follower.GetActorBase()
            
                If thisHireling == Jenassa
                    HirelingRecognizeJenassa.SetValue(1.0)
                ElseIf thisHireling == Marcurio
                    HirelingRecognizeMarcurio.SetValue(1.0)
                ElseIf thisHireling == Stenvar
                    HirelingRecognizeStenvar.SetValue(1.0)
                ElseIf thisHireling == Vorstag
                    HirelingRecognizeVorstag.SetValue(1.0)
                ElseIf thisHireling == Belrand
                    HirelingRecognizeBelrand.SetValue(1.0)
                ElseIf thisHireling == Erik
                    HirelingRecognizeErik.SetValue(1.0)
                EndIf
            EndIf
        EndIf
        
        AddFollowerToFramework(follower)

    EndIf
    
EndFunction


Function DismissHireling (Actorbase thisHireling)

    Debug.TraceConditional("DF - DismissHireling - " + thisHireling.GetName(), True)
    
    Float now = Utility.GetCurrentGameTime()
    Actor currentDF = Alias__DMaster.GetActorRef()
    
    If currentDF && currentDF.GetActorBase() == thisHireling
        Debug.TraceConditional("DF - DismissHireling - current DF", True)
        now -= 1.0
        If thisHireling == Jenassa
            Debug.TraceConditional("DF - DismissHireling + Janassa", True)
            HirelingRecognizeJenassa.SetValue(0.0)
            CanRehireJenassa.SetValue(now)
        ElseIf thisHireling == Marcurio
            HirelingRecognizeMarcurio.SetValue(0.0)
            CanRehireMarcurio.SetValue(now)
        ElseIf thisHireling == Stenvar
            HirelingRecognizeStenvar.SetValue(0.0)
            CanRehireStenvar.SetValue(now)
        ElseIf thisHireling == Vorstag
            HirelingRecognizeVorstag.SetValue(0.0)
            CanRehireVorstag.SetValue(now)
        ElseIf thisHireling == Belrand
            HirelingRecognizeBelrand.SetValue(0.0)
            CanRehireBelrand.SetValue(now)
        ElseIf thisHireling == Erik
            HirelingRecognizeErik.SetValue(0.0)
            CanRehireErik.SetValue(now)
        EndIf
    Else
        Debug.TraceConditional("DF - DismissHireling - non DF", True)
        If thisHireling == Jenassa
            Debug.TraceConditional("DF - DismissHireling * Janassa", True)
            HirelingRecognizeJenassa.SetValue(1.0)
            CanRehireJenassa.SetValue(now+1.0)
        ElseIf thisHireling == Marcurio
            HirelingRecognizeMarcurio.SetValue(1.0)
            CanRehireMarcurio.SetValue(now+1.0)
        ElseIf thisHireling == Stenvar
            HirelingRecognizeStenvar.SetValue(1.0)
            CanRehireStenvar.SetValue(now+1.0)
        ElseIf thisHireling == Vorstag
            HirelingRecognizeVorstag.SetValue(1.0)
            CanRehireVorstag.SetValue(now+1.0)
        ElseIf thisHireling == Belrand
            HirelingRecognizeBelrand.SetValue(1.0)
            CanRehireBelrand.SetValue(now+1.0)
        ElseIf thisHireling == Erik
            HirelingRecognizeErik.SetValue(1.0)
            CanRehireErik.SetValue(now+1.0)
        EndIf
    EndIf
    
EndFunction


Function AddFollowerDflow(ObjectReference followerRef)

	Actor follower = followerRef As Actor
    If follower
        AddFollower(followerRef)
        Q.StartNewAgreement(follower, 10)
    EndIf
    
EndFunction


Function AddFollowerLend(ObjectReference followerRef)

	Actor follower = followerRef As Actor
    If follower
        AddFollower(followerRef)
        Q.StartNewAgreement(follower, 2)
    EndIf
    
EndFunction

; This IS called by the vanilla DialogueFollowerScript when you part ways...
Function DialogDismissFollower(Actor follower)

    Debug.TraceConditional("DF - DialogDismissFollower - begin", True)
    If !follower
        Return
    EndIf

    Actor currentDF = Alias__DMaster.GetActorRef()

    ; Don't dismiss the follower again if already dismissed - but if EFF dismissed them, they will ALREADY have the dismissed faction.
    ; follower.IsInFaction(pDismissedFollower)
    If follower != currentDF
        Debug.TraceConditional("DF - DialogDismissFollower - follower is not the DF, don't dismiss them.", True)
        Return
    EndIf

    Debug.TraceConditional("DF - DialogDismissFollower - doing dialog dismissal", True)
    
    
    Bool vanillaFollowerExists = False
    ReferenceAlias vanillaFollowerAlias = (pDialogueFollower As DialogueFollowerScript).pFollowerAlias
    If vanillaFollowerAlias
        Actor vanillaFollower = vanillaFollowerAlias.GetActorRef()
        If vanillaFollower
            Debug.TraceConditional("DF - DialogDismissFollower - vanilla follower is " + vanillaFollower.GetActorBase().GetName(), True)
            vanillaFollowerExists = True
        Else
            ; Won't be a vanilla follower in EFF; that's normal.
            Debug.TraceConditional("DF - DialogDismissFollower - there is NO vanilla follower!", True)
        EndIf
    EndIf
    
    
    Sold.ReturnBuyer() ; Send buyer home
    Sold.Reset()

    ; Clear the alias, reset _DFlow
    DflowRemoveFollower()
    
    ; Handle dismiss in vanilla - which should eventually call the follower framework
    If vanillaFollowerExists
        ; This won't be true in EFF
        Debug.TraceConditional("DF - DialogDismissFollower - vanilla follower exists - trust the process", True)
        (pDialogueFollower As DialogueFollowerScript).DismissFollower(0, 0)
    Else
        Debug.TraceConditional("DF - DialogDismissFollower - no vanilla follower - trying to remove from follower framework anyway", True)
        RemoveFollower(follower) ; Remove directly from follower framework.
    EndIf
    ; Above sets follower count to 0 if vanilla script

    Debug.TraceConditional("DF - DialogDismissFollower - completed dialog dismissal", True)

EndFunction

; Called by DialogDismissFollower and ExternalDismissFollower in _DFlow
Function DflowRemoveFollower()

    Actor who = Alias__DMaster.GetActorRef() As Actor
    If who
        Debug.Notification("Removing Devious Follower " + who.GetActorBase().GetName())
        If who.IsInFaction(CurrentHireling)
            DismissHireling(who.GetActorBase())
            who.RemoveFromFaction(CurrentHireling)
        EndIf
        ReduceFollowerCount()
        Alias__DMaster.Clear()
    EndIf
    CommonDismissalTasks(who)
    Q.Reset()
    Q.SetStage(0)
    Debug.Notification("Ready for a new Devious Follower")

EndFunction

; When dismiss is called from the framework and it will do the main dismissal work.
Function DismissFromFramework(Actor who)

    ; If we called InternalRemoveFollower we want this to do nothing ... current will be clear
    Actor current = Alias__DMaster.GetActorRef() As Actor
    If current && who == current
        DflowRemoveFollower()
    EndIf
    
EndFunction

Function InternalRemoveFollower(Actor who)
    Debug.TraceConditional("DF - InternalRemoveFollower - " + who.GetActorBase().GetName(), True)

    If who.IsInFaction(CurrentHireling)
        DismissHireling(who.GetActorBase())
        who.RemoveFromFaction(CurrentHireling)
    EndIf
    Q.SetStage(5) ; Set a stage < 10 so CanDismissFollower check will pass ... 
    CommonDismissalTasks(who)
    RemoveFollower(who)
    who.AddToFaction(pDismissedFollower)
    ReduceFollowerCount()
    Alias__DMaster.Clear() ; This is the one in _DFlow ... but there are others ... should they be cleaned too?

EndFunction

Function RemoveFollower(Actor who)

    Debug.TraceConditional("DF - RemoveFollower - " + who.GetActorBase().GetName() + " from framework", True)

    If 255 != Game.GetModByName("AmazingFollowerTweaks.esp")
        _df_AFT_extensions.RemoveFollower(who)
        Return
    EndIf
    
    If 255 != Game.GetModByName("EFFCore.esm")
        _df_EFF_extensions.RemoveFollower(who)
        Return
    EndIf

    If 255 != Game.GetModByName("nwsFollowerFramework.esm")
        _df_NFF_extensions.RemoveFollower(who)
        Return
    EndIf

    Debug.TraceConditional("DF - RemoveFollower - dismiss follower", True)
    (pDialogueFollower As DialogueFollowerScript).DismissFollower(0, 0)

EndFunction

Function ReduceFollowerCount()
    Float currentKnownFollowerCount = _DFFollowerCount.GetValue()
    If currentKnownFollowerCount >= 1.0
        ; This allows the new follower detection to see the difference if you rehire really quickly
        currentKnownFollowerCount -= 1.0
        _DFFollowerCount.SetValue(currentKnownFollowerCount)
    EndIf
EndFunction

; This doesn't check the StorageUtil Tool.TagNeverDevious ... *it should* but the caller currently does that.
; The extension scans don't consider the _DFEnable faction, but this is OK...
; That faction only serves to stop followers from being picked up in the batch disable/ignore scan.
; It's not considered in IsIgnore() or anywhere else; it's only used in the MCM.
Actor[] Function GetFrameworkFollowers(Faction ignoreFaction)

    Actor[] found = New Actor[20]
    Int count = -1
    
    If 255 != Game.GetModByName("AmazingFollowerTweaks.esp")
        count = _df_AFT_extensions.FindDeviousFollowers(ignoreFaction, found)
    EndIf
    
    If 255 != Game.GetModByName("EFFCore.esm")
        count = _df_EFF_extensions.FindDeviousFollowers(ignoreFaction, found)
        Debug.TraceConditional("DF - GetFrameworkFollowers - EFF found " + count, True)
    EndIf

    If 255 != Game.GetModByName("nwsFollowerFramework.esp")
        Debug.TraceConditional("DF - GetFrameworkFollowers via NFF", True)
        count = _df_NFF_extensions.FindDeviousFollowers(ignoreFaction, found)
    EndIf
    
    If count < 0
        Debug.TraceConditional("DF - GetFrameworkFollowers vanilla", True)
        count = 0
        ReferenceAlias followerAlias = (pDialogueFollower As DialogueFollowerScript).pFollowerAlias
        If followerAlias
            Actor follower = followerAlias.GetActorRef()
            If follower
                found[0] = follower
                count = 1
            EndIf
        EndIf
    EndIf
    
    Actor[] followers = PapyrusUtil.ActorArray(count)
    Int ii = count
    While ii
        ii -= 1
        followers[ii] = found[ii]
    EndWhile
        
    Return followers

EndFunction


Function CommonDismissalTasks(Actor who)
    RevokeLicensesFromFollower()
    Q.ResetPunishmentTracking(who) ; can be called with a None actor.
    Q.UpdateFollowerDismissalTags(who)
EndFunction


Function RevokeLicensesFromFollower()
    _DFLicenses.SupplyingFollowerDismissed()
EndFunction
