Scriptname _DFlowAnimation

; Shares a mutex with SLD ... so we won't fight it for animation control.
; This code from SLD, so if bugs found, remember to back-patch SLD.

Bool Function InSLAnimatingFaction(Actor who) Global

    String sexLabFile = "SexLab.esm"
    Int factionId = 0x0000E50F
    
    Int labIndex = Game.GetModByName(sexLabFile)
    If 255 != labIndex
        Faction animatingFaction = Game.GetFormFromFile(factionId, sexLabFile) As Faction
        Return who.IsInFaction(animatingFaction)
    EndIf
    
    Return False
    
EndFunction


Function SetInSLAnimatingFaction(Actor who, Bool inFaction) Global

    String sexLabFile = "SexLab.esm"
    Int factionId = 0x0000E50F
    
    Int labIndex = Game.GetModByName(sexLabFile)
    If 255 != labIndex
        Faction animatingFaction = Game.GetFormFromFile(factionId, sexLabFile) As Faction
        If animatingFaction
            If inFaction
                who.AddToFaction(animatingFaction)
                who.SetFactionRank(animatingFaction, 1)
            Else
                who.RemoveFromFaction(animatingFaction)
            EndIf
        EndIf
    EndIf
    
EndFunction



Int Function GetSLVictimCount(Actor who) Global

    String sexLabFile = "SexLab.esm"
    Int questId = 0x00000D62

    Int labIndex = Game.GetModByName(sexLabFile)
    If 255 != labIndex
    
        SexLabFramework framework = Game.GetFormFromFile(questId, sexLabFile) As SexLabFramework
        
        If framework
        
            Int skillLevel = framework.GetSkill(who, "Victim")
            Return skillLevel
            
        EndIf
    EndIf
    
    Return 0
EndFunction



Bool Function InDDAnimatingFaction(Actor who) Global

    String ddFile ="Devious Devices - Integration.esm"
    Int factionId = 0x00029567
    
    Int ddIndex = Game.GetModByName(ddFile)
    If 255 != ddIndex
        Faction animatingFaction = Game.GetFormFromFile(factionId, ddFile) As Faction
        If animatingFaction
            Return who.IsInFaction(animatingFaction)
        EndIf
    EndIf
    
    Return False
    
EndFunction


Function SetInDDAnimatingFaction(Actor who, Bool inFaction) Global

    String ddFile ="Devious Devices - Integration.esm"
    Int factionId = 0x00029567
    
    Int ddIndex = Game.GetModByName(ddFile)
    If 255 != ddIndex
        Faction animatingFaction = Game.GetFormFromFile(factionId, ddFile) As Faction
        If animatingFaction
            If inFaction
                who.AddToFaction(animatingFaction)
                who.SetFactionRank(animatingFaction, 1)
            Else
                who.RemoveFromFaction(animatingFaction)
            EndIf
        EndIf
    EndIf
    
EndFunction

Bool Function IsInvalidAnimationActor(Actor who) Global
    
    If StorageUtil.GetIntValue(None, "fwb_threadEventMutex") > 0 || !who.Is3DLoaded() || who.IsDisabled() \
            || who.IsOnMount() || who.IsSwimming() || who.GetSitState() || who.GetSleepState() \
            || who.IsBleedingOut() || who.IsFlying() || who.IsInKillMove() || who.IsUnconscious() || who.IsDead() || who.GetCurrentScene()
        Return True
    EndIf

    ; Check mutex here too, just in case it got set between earlier checks and this.
    Return InDDAnimatingFaction(who) || InSLAnimatingFaction(who) || StorageUtil.GetIntValue(None, "fwb_threadEventMutex") > 0
    
EndFunction


; Set ours, and DD's Actor animating status - doesn't set the SexLab status.
Function SetAnimating(Actor who, Bool isAnimating = True) Global

    Int mutexDelta = -1
    If isAnimating
        mutexDelta = 1
    EndIf
    
    StorageUtil.AdjustIntValue(None, "fwb_threadEventMutex", mutexDelta)
    SetInDDAnimatingFaction(who, isAnimating)
    
EndFunction


Bool[] Function StartAnimation(Actor who, String animation) Global

    ; animationState[0] = animation started
    ; animationState[1] = was first person (and not mounted)
    ; animationState[2] = had weapons drawn
    
	_Dutil.Info("DFC - StartAnimation(" + who.GetLeveledActorBase().GetName() + ", " + animation + ")")
	Bool[] animationState = new Bool[3]
    
	_Dutil.Info("DFC - StartAnimation - check valid?")
	If IsInvalidAnimationActor(who)
		_Dutil.Info("FWB - actor is invalid). Aborting.")
		Return animationState
	EndIf
	_Dutil.Info("DFC - StartAnimation - have a valid target")
    
	If who.IsWeaponDrawn()
		who.SheatheWeapon()
		; Wait for users with flourish sheathe animations.
		int timeout=0
		While who.IsWeaponDrawn() && timeout <= 12  ; Try to limit waiting to around 3.6 seconds, in practice could be longer, as Wait is not that responsive.
			Utility.Wait(0.3)
			timeout += 1
		EndWhile
		animationState[2] = True
	EndIf
    
	_Dutil.Info("DFC - StartAnimation - player or NPC")
	If who == Game.GetPlayer()
    
		; Manipulate camera
		_Dutil.Info("DFC - StartAnimation - handle player")
		int cameraOld = Game.GetCameraState()
        
        ; 10 On a horse
		If 10 == cameraOld || who.IsOnMount()
        
            ; We excluded mounted actors in the validity test - mounted actors should just abort.
            _Dutil.Info("DFC - StartAnimation - failed - player mounted")
            Return animationState
            
        ; Bleeding out - do not animate
		ElseIf 11 == cameraOld

            _Dutil.Warning("DFC - StartAnimation - failed - attempt to animate Actor in bleedout.")
			Return animationState

        ; Dragon? - do not animate
        ElseIf 12 == cameraOld

            _Dutil.Warning("DFC - StartAnimation - failed - animation for dragons not supported.")
			Return animationState

        ;;; 8 / 9 are third person. 7 is tween menu.
        ElseIf 8 == cameraOld || 9 == cameraOld || 7 == cameraOld

            _Dutil.Info("DFC - StartAnimation - third-person camera - set animating")
            SetAnimating(who, True)
            
		Else
    
            _Dutil.Info("DFC - StartAnimation - default states - set animating")
            SetAnimating(who, True)
            ; state[1] set If forced third person and not on a horse
			animationState[1] = True
			Game.ForceThirdPerson()
		EndIf
        
		_Dutil.Info("DFC - StartAnimation - stop auto-run and lock controls")		
		; Tap 'forward' to disable possible auto-run
		Input.TapKey(Input.GetMappedKey("Forward"))
		Game.DisablePlayerControls()
	Else
        ; NPCs
		_Dutil.Info("DFC - StartAnimation - handle NPC")
		who.SetDontMove(True)
	EndIf
    
	_Dutil.Info("DFC - StartAnimation - sendAnimationEvent")
	Debug.SendAnimationEvent(who, animation)
    
	_Dutil.Info("DFC - StartAnimation - done OK")
    animationState[0] = True
	Return animationState
    
EndFunction


; Wrapper for both Start/End third person animation. Use this unless you need more control during the wait period.
Function PlayAnimation(Actor who, String animation, Float duration) Global

    ; No need to validate actor here - StartAnimation validates it.
	Bool[] animationState = StartAnimation(who, animation)
    
    If animationState[0]
    
        _Dutil.Info("DFC - PlayAnimation - playing animation " + animation + " for " + duration + " seconds.")
        Utility.Wait(duration)
        
        EndAnimation(who, animationState)
        
    Else
        _Dutil.Info("DFC - PlayAnimation - did not start animation " + animation)
    EndIf
    
EndFunction


Function EndAnimation(Actor who, Bool[] animationState) Global

	_Dutil.Info("DFC - EndAnimation(" + who.GetLeveledActorBase().GetName() + ", " + animationState + ")")
    
    
	If (!who.Is3DLoaded() ||  who.IsDead() || who.IsDisabled())
		_Dutil.Info("DFC - EndAnimation - actor invalid. Aborting.")
        SetAnimating(who, False)
		Return
	EndIf
    
	; Reset idle 
	Debug.SendAnimationEvent(who, "IdleForceDefaultState")
    
	If who == Game.GetPlayer()
    
		If animationState[1]
			game.ForceFirstPerson()		
		EndIf
		If animationState[2]
			;who.SheatheWeapon()
			who.DrawWeapon()
		EndIf
        
        Game.EnablePlayerControls()
        
	Else
		who.SetDontMove(False)
	EndIf
    
 	SetAnimating(who, False)

EndFunction
