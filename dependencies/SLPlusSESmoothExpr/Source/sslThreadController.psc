scriptname sslThreadController extends sslThreadModel
{ Animation Thread Controller: Runs manipulation logic of thread based on information from model. Access only through functions; NEVER create a property directly to this. }

; TODO: SetFirstAnimation() - allow custom defined starter anims instead of random

import PapyrusUtil

; Animation
float SkillTime

; SFX
float BaseDelay
float SFXDelay
float SFXTimer

; Processing
bool TimedStage
float StageTimer
int StageCount

; Adjustment hotkeys
sslActorAlias AdjustAlias
bool Adjusted
bool hkReady

; ------------------------------------------------------- ;
; --- Thread Starter                                  --- ;
; ------------------------------------------------------- ;

bool Prepared
state Prepare
	function FireAction()
		Prepared = false

		HookAnimationPrepare()

		; Ensure center is set
		if !CenterRef
			CenterOnObject(Positions[0], false)
		endIf
		if CenterAlias.GetReference() != CenterRef
			CenterAlias.TryToClear()
			CenterAlias.ForceRefTo(CenterRef)
		endIf
		; Set important vars needed for actor prep
		UpdateAdjustKey()
		if StartingAnimation && Animations.Find(StartingAnimation) != -1
			SetAnimation(Animations.Find(StartingAnimation))
		else
			SetAnimation()
			StartingAnimation = none
		endIf
		Log(AdjustKey, "Adjustment Profile")

		; Begin actor prep
		SyncEvent(kPrepareActor, 40.0)
	endFunction

	function PrepareDone()
		RegisterForSingleUpdate(0.1)
	endFunction

	function StartupDone()
		if Config.HasSLSO
			;Log("SLSO reinit orgam default values")
			SLSO_condition_maximum_aggressor_orgasm = -1
			SLSO_condition_minimum_aggressor_orgasm = -1
			SLSO_condition_maximum_aggressor_orgasm = Get_maximum_aggressor_orgasm_Count()
			SLSO_condition_minimum_aggressor_orgasm = Get_minimum_aggressor_orgasm_Count()
			
			String File = "/SLSO/Config.json"
			SLSO_shouldrun_SLSO_Animating_GoToStage = Config.SeparateOrgasms && HasPlayer
			;Log("SLSO_shouldrun_SLSO_Animating_GoToStage so+hp " + SLSO_shouldrun_SLSO_Animating_GoToStage)
			if (GetVictim() == none) ; consensual
				SLSO_shouldrun_SLSO_Animating_GoToStage = SLSO_shouldrun_SLSO_Animating_GoToStage && JsonUtil.GetIntValue(File, "condition_consensual_orgasm") == 1
				;Log("SLSO_shouldrun_SLSO_Animating_GoToStage c " + SLSO_shouldrun_SLSO_Animating_GoToStage)
			else
				SLSO_shouldrun_SLSO_Animating_GoToStage = SLSO_shouldrun_SLSO_Animating_GoToStage && (JsonUtil.GetIntValue(File, "condition_aggressor_orgasm") == 1 || JsonUtil.GetIntValue(File, "condition_player_aggressor_orgasm") == 1)
				;Log("SLSO_shouldrun_SLSO_Animating_GoToStage a " + SLSO_shouldrun_SLSO_Animating_GoToStage)
			endif
		endIf
		RegisterForSingleUpdate(0.1)
	endFunction

	event OnUpdate()
		if !Prepared
			Prepared = true
			; Reset loc, incase actor type center has moved during prep
			;/ if CenterRef && CenterRef.Is3DLoaded() && SexLabUtil.IsActor(CenterRef) && Positions.Find(CenterRef as Actor) != -1
				CenterLocation[0] = CenterRef.GetPositionX()
				CenterLocation[1] = CenterRef.GetPositionY()
				; CenterLocation[2] = CenterRef.GetPositionZ()
				CenterLocation[3] = CenterRef.GetAngleX()
				CenterLocation[4] = CenterRef.GetAngleY()
				CenterLocation[5] = CenterRef.GetAngleZ()
			endIf /;
			; Set starting adjusted actor
			int AdjustPos = Positions.Find(Config.TargetRef)
			if AdjustPos == -1
				AdjustPos   = (ActorCount > 1) as int
				if Positions[AdjustPos] != PlayerRef
					Config.TargetRef = Positions[AdjustPos]
				endIf
			endIf
			AdjustAlias = PositionAlias(AdjustPos)
			; Get localized config options
			BaseDelay = Config.SFXDelay
			; Send starter events
			SendThreadEvent("AnimationStart")
			if LeadIn
				SendThreadEvent("LeadInStart")
			endIf
			; Start time trackers
			RealTime[0] = SexLabUtil.GetCurrentGameRealTime()
			SkillTime = RealTime[0]
			StartedAt = RealTime[0]
			; Start actor loops
			SyncEvent(kStartup, 35.0)
		else
			; Start animating
			Action("Advancing")
		endIf
	endEvent

	function PlayStageAnimations()
	endFunction
	function ResetPositions()
	endFunction
	function RecordSkills()
	endFunction
	function SetBonuses()
	endFunction
endState

; ------------------------------------------------------- ;
; --- Animation Loop                                  --- ;
; ------------------------------------------------------- ;

state Advancing
	function FireAction()
		; Log("Stage: "+Stage, "Advancing")
		if Stage < 1
			Stage = 1
		elseIf Stage > StageCount
			if LeadIn
				EndLeadIn()
			else
				EndAnimation()
			endIf
			return
		endIf
		SyncEvent(kSyncActor, 65.0)
	endFunction
	function SyncDone()
		if Stage > 1 && Stage > (StageCount * 0.5)
			string[] Tags = Animation.GetRawTags()
			IsType[6]  = IsType[6] || Females > 0 && Tags.Find("Vaginal") != -1
			IsType[7]  = IsType[7] || Tags.Find("Anal")   != -1 || (Females == 0 && Tags.Find("Vaginal") != -1)
			IsType[8]  = IsType[8] || Tags.Find("Oral")   != -1
		endIf
		RegisterForSingleUpdate(0.1)
	endFunction
	event OnUpdate()
		HookStageStart()
		Action("Animating")
		SendThreadEvent("StageStart")
		
		int HotKey = GetThreadHotkey(kAdvanceAnimation)
		If HotKey != -1 && GetState() == "Animating"
			RegisterForKey(HotKey)
		EndIf
	endEvent
endState

state Animating

	function FireAction()
		UnregisterForUpdate()
		; Prepare loop
		RealTime[0] = SexLabUtil.GetCurrentGameRealTime()
		SoundFX  = Animation.GetSoundFX(Stage)
		SFXDelay = ClampFloat(BaseDelay - ((Stage * 0.3) * ((Stage != 1) as int)), 0.5, 30.0)
		ResolveTimers()
		PlayStageAnimations()
		; Send events
		if !LeadIn && Stage >= StageCount && !DisableOrgasms && (!Config.HasSLSO || !Config.SeparateOrgasms \
		|| JsonUtil.GetIntValue("/SLSO/Config", "sl_default_always_orgasm") == 1 || (!HasPlayer && JsonUtil.GetIntValue("/SLSO/Config", "sl_npcscene_always_orgasm") == 1))
			SendThreadEvent("OrgasmStart")
			TriggerOrgasm()
		endIf
		; Begin loop
		RegisterForSingleUpdate(0.5)
	endFunction

	event OnUpdate()
		; Debug.Trace("(thread update)")
		; Update timer share
		RealTime[0] = SexLabUtil.GetCurrentGameRealTime()
		; Pause further updates if in menu
		if HasPlayer && Utility.IsInMenuMode()
			Utility.Wait(0.1)
		endIf
		; Advance stage on timer
		if (AutoAdvance || TimedStage) && StageTimer < RealTime[0]
			GoToStage((Stage + 1))
			return
		endIf
		; Play SFX
		if SoundFX && SFXTimer < RealTime[0]
			ObjectReference CenterFX = GetCenterFX()
			if CenterFX
				SoundFX.Play(CenterFX)
			endIf
			SFXTimer = RealTime[0] + SFXDelay
		endIf
		; Loop
		If GetState() == "Animating"
			RegisterForSingleUpdate(0.5)
		EndIf
	endEvent

	function EndAction()
		HookStageEnd()
		if !LeadIn && Stage >= StageCount && !DisableOrgasms && (!Config.HasSLSO || !Config.SeparateOrgasms \
		|| JsonUtil.GetIntValue("/SLSO/Config", "sl_default_always_orgasm") == 1 || (!HasPlayer && JsonUtil.GetIntValue("/SLSO/Config", "sl_npcscene_always_orgasm") == 1))
			SendThreadEvent("OrgasmEnd")
		else
			SendThreadEvent("StageEnd")
		endIf
	endFunction

	function GoToStage(int ToStage)
		int HotKey = GetThreadHotkey(kAdvanceAnimation)
		UnregisterForKey(HotKey)

		UnregisterForUpdate()
		if Config.HasSLSO && !LeadIn && (!TimedStage || Stage >= StageCount)
			ToStage = SLSO_Animating_GoToStage(ToStage)
			if (ToStage == -1)
				Log("Lead is not satisfied, Lead changing animation")
				Stage = 2 ; 1 - is probably leadin
				ChangeAnimation()

				If HotKey != -1 && GetState() == "Animating"
					RegisterForKey(HotKey)
				EndIf
				return
			endif
		endIf

		Stage = ToStage
		Action("Advancing")
	endFunction

	; ------------------------------------------------------- ;
	; --- Hotkey functions                                --- ;
	; ------------------------------------------------------- ;

	function AdvanceStage(bool backwards = false)
		if !backwards
			GoToStage((Stage + 1))
		elseIf backwards && Stage > 1
			if Config.IsAdjustStagePressed()
				GoToStage(1)
			else
				GoToStage((Stage - 1))
			endIf
		endIf
	endFunction

	function ChangeAnimation(bool backwards = false)
		if Animations.Length < 2
			return ; Nothing to change
		endIf
		int HotKey = GetThreadHotkey(kChangeAnimation)
		UnregisterForKey(HotKey)
		
		UnregisterForUpdate()
		
		if !Config.AdjustStagePressed()
			; Forward/Backward
			SetAnimation(sslUtility.IndexTravel(Animations.Find(Animation), Animations.Length, backwards))
		else
			; Random
			int current = Animations.Find(Animation)
			int r = Utility.RandomInt(0, (Animations.Length - 1))
			; Try to get something other than the current animation
			if r == current
				int tries = 10
				while r == current && tries > 0
					tries -= 1
					r = Utility.RandomInt(0, (Animations.Length - 1))
				endWhile
			endIf
			SetAnimation(r)
		endIf

		SendThreadEvent("AnimationChange")
		RegisterForSingleUpdate(0.2)

		If HotKey != -1 && GetState() == "Animating"
			RegisterForKey(HotKey)
		EndIf
	endFunction

	function ChangePositions(bool backwards = false)
		if ActorCount < 2 || HasCreature
			return ; Solo/Creature Animation, nobody to swap with
		endIf
		int HotKey = GetThreadHotkey(kChangePositions)
		UnregisterForKey(HotKey)
		
		UnregisterforUpdate()
		; GoToState("")
		; Find position to swap to
		int AdjustPos = GetAdjustPos()
		int NewPos = sslUtility.IndexTravel(AdjustPos, ActorCount, backwards)
		Actor AdjustActor = Positions[AdjustPos]
		Actor MovedActor  = Positions[NewPos]
		if MovedActor == AdjustActor
			Log("MovedActor["+NewPos+"] == AdjustActor["+AdjustPos+"] -- "+Positions, "ChangePositions() Error")
			RegisterForSingleUpdate(0.2)

			If HotKey != -1 && GetState() == "Animating"
				RegisterForKey(HotKey)
			EndIf
			return
		endIf
		Input.IsKeyPressed(HotKey) && PlayHotkeyFX(0, backwards)

		; Shuffle actor positions
		Positions[AdjustPos] = MovedActor
		Positions[NewPos] = AdjustActor
		; New adjustment profile
		; UpdateActorKey()
		UpdateAdjustKey()
		Log(AdjustKey, "Adjustment Profile")
		; Sync new positions
		AdjustPos = NewPos
		; GoToState("Animating")
		ResetPositions()
		SendThreadEvent("PositionChange")
		RegisterForSingleUpdate(1.0)

		If HotKey != -1 && GetState() == "Animating"
			RegisterForKey(HotKey)
		EndIf
	endFunction

	function AdjustForward(bool backwards = false, bool AdjustStage = false)
		int HotKey = GetThreadHotkey(kAdjustForward)
		UnregisterForKey(HotKey)
		
		UnregisterforUpdate()
		float Amount = SignFloat(backwards, 0.50)
		Adjusted = true
		int AdjustPos = GetAdjustPos()
		Animation.AdjustForward(AdjustKey, AdjustPos, Stage, Amount, AdjustStage)
		AdjustAlias.RefreshLoc()
	;	Utility.Wait(0.5)
		while Input.IsKeyPressed(HotKey)
			PlayHotkeyFX(Config.AdjustStagePressed() as int, backwards)
			Animation.AdjustForward(AdjustKey, AdjustPos, Stage, Amount, Config.AdjustStagePressed())
			AdjustAlias.RefreshLoc()
		endWhile
		if StageTimer < (RealTime[0] + GetTimer())
			StageTimer = StageTimer + GetTimer()
		endIf
		RegisterForSingleUpdate(0.1)

		If HotKey != -1 && GetState() == "Animating"
			RegisterForKey(HotKey)
		EndIf
	endFunction

	function AdjustSideways(bool backwards = false, bool AdjustStage = false)
		int HotKey = GetThreadHotkey(kAdjustSideways)
		UnregisterForKey(HotKey)
		
		UnregisterforUpdate()
		float Amount = SignFloat(backwards, 0.50)
		Adjusted = true
		int AdjustPos = GetAdjustPos()
		Animation.AdjustSideways(AdjustKey, AdjustPos, Stage, Amount, AdjustStage)
		AdjustAlias.RefreshLoc()
	;	Utility.Wait(0.5)
		while Input.IsKeyPressed(HotKey)
			PlayHotkeyFX(Config.AdjustStagePressed() as int, backwards)
			Animation.AdjustSideways(AdjustKey, AdjustPos, Stage, Amount, Config.AdjustStagePressed())
			AdjustAlias.RefreshLoc()
		endWhile
		if StageTimer < (RealTime[0] + GetTimer())
			StageTimer = StageTimer + GetTimer()
		endIf
		RegisterForSingleUpdate(0.1)

		If HotKey != -1 && GetState() == "Animating"
			RegisterForKey(HotKey)
		EndIf
	endFunction

	function AdjustUpward(bool backwards = false, bool AdjustStage = false)
		int HotKey = GetThreadHotkey(kAdjustUpward)
		UnregisterForKey(HotKey)

		UnregisterforUpdate()
		float Amount = SignFloat(backwards, 0.50)
		Adjusted = true
		int AdjustPos = GetAdjustPos()
		Animation.AdjustUpward(AdjustKey, AdjustPos, Stage, Amount, AdjustStage)
		AdjustAlias.RefreshLoc()
	;	Utility.Wait(0.5)
		while Input.IsKeyPressed(HotKey)
			PlayHotkeyFX(1 + Config.AdjustStagePressed() as int, backwards)
			Animation.AdjustUpward(AdjustKey, AdjustPos, Stage, Amount, Config.AdjustStagePressed())
			AdjustAlias.RefreshLoc()
		endWhile
		if StageTimer < (RealTime[0] + GetTimer())
			StageTimer = StageTimer + GetTimer()
		endIf
		RegisterForSingleUpdate(0.1)

		If HotKey != -1 && GetState() == "Animating"
			RegisterForKey(HotKey)
		EndIf
	endFunction

	function RotateScene(bool backwards = false)
		int HotKey = GetThreadHotkey(kRotateScene)
		UnregisterForKey(HotKey)

		UnregisterForUpdate()
		float Amount = 15.0
		if Config.IsAdjustStagePressed()
			Amount = 180.0
		endIf
		Amount = SignFloat(backwards, Amount)
		CenterLocation[5] = CenterLocation[5] + Amount
		if CenterLocation[5] >= 360.0
			CenterLocation[5] = CenterLocation[5] - 360.0
		elseIf CenterLocation[5] < 0.0
			CenterLocation[5] = CenterLocation[5] + 360.0
		endIf
		ActorAlias[0].RefreshLoc()
		ActorAlias[1].RefreshLoc()
		ActorAlias[2].RefreshLoc()
		ActorAlias[3].RefreshLoc()
		ActorAlias[4].RefreshLoc()
	;	Utility.Wait(0.5)
		while Input.IsKeyPressed(HotKey)
			PlayHotkeyFX(1, !backwards)
			if Config.IsAdjustStagePressed()
				Amount = 180.0
			else
				Amount = 15.0
			endIf
			Amount = SignFloat(backwards, Amount)
			CenterLocation[5] = CenterLocation[5] + Amount
			if CenterLocation[5] >= 360.0
				CenterLocation[5] = CenterLocation[5] - 360.0
			elseIf CenterLocation[5] < 0.0
				CenterLocation[5] = CenterLocation[5] + 360.0
			endIf
			ActorAlias[0].RefreshLoc()
			ActorAlias[1].RefreshLoc()
			ActorAlias[2].RefreshLoc()
			ActorAlias[3].RefreshLoc()
			ActorAlias[4].RefreshLoc()
		endWhile
		RegisterForSingleUpdate(0.2)

		If HotKey != -1 && GetState() == "Animating"
			RegisterForKey(HotKey)
		EndIf
	endFunction

	function AdjustSchlong(bool backwards = false)
		int HotKey = GetThreadHotkey(kAdjustSchlong)
		UnregisterForKey(HotKey)

		int Amount  = SignInt(backwards, 1)
		int AdjustPos = GetAdjustPos()
		int Schlong = Animation.GetSchlong(AdjustKey, AdjustPos, Stage) + Amount
		if Math.Abs(Schlong) <= 9
			Adjusted = true
			Animation.AdjustSchlong(AdjustKey, AdjustPos, Stage, Amount)
			AdjustAlias.GetPositionInfo()
			Debug.SendAnimationEvent(Positions[AdjustPos], "SOSBend"+Schlong)
			Input.IsKeyPressed(HotKey) && PlayHotkeyFX(2, !backwards)
		endIf
		if StageTimer < (RealTime[0] + GetTimer())
			StageTimer = StageTimer + GetTimer()
		endIf

		If HotKey != -1 && GetState() == "Animating"
			RegisterForKey(HotKey)
		EndIf
	endFunction

	function AdjustChange(bool backwards = false)
		int HotKey = GetThreadHotkey(kAdjustChange)
		UnregisterForKey(HotKey)

		UnregisterForUpdate()
		if ActorCount > 1
			int AdjustPos = GetAdjustPos()
			AdjustPos = sslUtility.IndexTravel(AdjustPos, ActorCount, backwards)
			if Positions[AdjustPos] != PlayerRef
				Config.TargetRef = Positions[AdjustPos]
			endIf
			AdjustAlias = PositionAlias(AdjustPos)
			Config.SelectedSpell.Cast(Positions[AdjustPos], Positions[AdjustPos])
			Input.IsKeyPressed(HotKey) && PlayHotkeyFX(0, !backwards)
			string msg = "Adjusting Position For: "+Positions[AdjustPos].GetLeveledActorBase().GetName()
			Debug.Notification(msg)
			SexLabUtil.PrintConsole(msg)
		endIf
		RegisterForSingleUpdate(0.2)

		If HotKey != -1 && GetState() == "Animating"
			RegisterForKey(HotKey)
		EndIf
	endFunction

	function RestoreOffsets()
		int HotKey = GetThreadHotkey(kRestoreOffsets)
		UnregisterForKey(HotKey)

		UnregisterForUpdate()
		Animation.RestoreOffsets(AdjustKey)
		RealignActors()
		RegisterForSingleUpdate(0.2)

		If HotKey != -1 && GetState() == "Animating"
			RegisterForKey(HotKey)
		EndIf
	endFunction

	function CenterOnObject(ObjectReference CenterOn, bool resync = true)
		parent.CenterOnObject(CenterOn, resync)
		if resync
			RealignActors()
			SendThreadEvent("ActorsRelocated")
		endIf
	endFunction

	function CenterOnCoords(float LocX = 0.0, float LocY = 0.0, float LocZ = 0.0, float RotX = 0.0, float RotY = 0.0, float RotZ = 0.0, bool resync = true)
		parent.CenterOnCoords(LocX, LocY, LocZ, RotX, RotY, RotZ, resync)
		if resync
			RealignActors()
			SendThreadEvent("ActorsRelocated")
		endIf
	endFunction

	function MoveScene()
		int HotKey = GetThreadHotkey(kMoveScene)
		UnregisterForKey(HotKey)

		; Enable Controls
		if Config.GetThreadControlled() == self || PlayerRef.IsInFaction(Config.AnimatingFaction) && PlayerRef.GetFactionRank(Config.AnimatingFaction) != 0
			; Stop animation loop
			GoToState("Resetting")
			If Stage >= StageCount * 0.75
				Stage = 1
			EndIf
			; Processing Furnitures
			if UsingFurniture && CenterRef.IsActivationBlocked()
				SetFurnitureIgnored(false)
			elseIf CenterRef.GetBaseObject() == Config.XMarkerHiddenPlace
				CenterRef.Enable()
			endIf
			ActorBase BaseRef
			sslActorAlias PlayerSlot = ActorAlias(PlayerRef)
			if PlayerSlot ;&& PlayerSlot != none
				PlayerSlot.GoToState("Resetting") ; To stop the Updates of the actor and disable some functions
				PlayerSlot.StopAnimating(true)
				PlayerSlot.UnlockActor()
				PlayerSlot.SendDefaultAnimEvent(true)
			;	PlayerRef.StopTranslation()
				BaseRef = PlayerRef.GetLeveledActorBase()
				if BaseRef && !sslCreatureAnimationSlots.HasRaceType(BaseRef.GetRace())
					If sslBaseExpression.IsMouthOpen(PlayerRef)
						Log("IsMouthOpen("+ActorRef+") - TRUE")
						sslBaseExpression.UnequipFaceItem(PlayerRef)
						sslBaseExpression.CloseMouth(PlayerRef)			
					endIf
					; Add back high heel effects
					if Config.RemoveHeelEffect
						; HDT High Heel
					;	if HDTHeelSpell && PlayerRef.GetWornForm(0x00000080) && !PlayerRef.HasSpell(HDTHeelSpell)
					;		PlayerRef.AddSpell(HDTHeelSpell)
					;	endIf
						Form HighHeels = PlayerRef.GetWornForm(0x00000080)
						If HighHeels as armor
							PlayerRef.EquipItem(HighHeels, False, True)
						endIf
						; NiOverride High Heels move out to prevent isues and add NiOverride Scale for race menu compatibility
					endIf
					if Config.HasNiOverride
						bool isRealFemale = BaseRef.GetSex() == 1
						if NiOverride.RemoveNodeTransformPosition(PlayerRef, false, isRealFemale, "NPC", "SexLab.esm")
							NiOverride.UpdateNodeTransform(PlayerRef, false, isRealFemale, "NPC")
						endIf
					endIf
				endIf
			else
				Config.DisableThreadControl(self)
				PlayerRef.SetFactionRank(Config.AnimatingFaction, 0)
			endIf
			Debug.Notification("Player movement unlocked - repositioning scene in 30 seconds...")
			UnregisterForUpdate() ; Just in case!!!
			Actor ActorRef
			int i
			while i < ActorCount
				sslActorAlias ActorSlot = ActorAlias[i]
				
				if ActorSlot != none && ActorSlot != PlayerSlot
					ActorSlot.GoToState("Resetting") ; To stop the Updates of the actor
					ActorSlot.StopAnimating(true)
					ActorSlot.UnlockActor()
					ActorSlot.SendDefaultAnimEvent(true)
					ActorRef = ActorSlot.ActorRef
					BaseRef = ActorRef.GetLeveledActorBase()
					if BaseRef && !sslCreatureAnimationSlots.HasRaceType(BaseRef.GetRace())
						if !(ActorRef.IsDead() || ActorRef.GetActorValue("Health") <= 1.0)
							If sslBaseExpression.IsMouthOpen(ActorRef)
								sslBaseExpression.UnequipFaceItem(ActorRef)
								sslBaseExpression.CloseMouth(ActorRef)			
							endIf
							; Add back high heel effects
							if Config.RemoveHeelEffect
								; HDT High Heel
							;	if HDTHeelSpell && ActorRef.GetWornForm(0x00000080) && !ActorRef.HasSpell(HDTHeelSpell)
							;		ActorRef.AddSpell(HDTHeelSpell)
							;	endIf
								Form HighHeels = ActorRef.GetWornForm(0x00000080)
								If HighHeels as armor
									ActorRef.EquipItem(HighHeels, False, True)
								endIf
								; NiOverride High Heels move out to prevent isues and add NiOverride Scale for race menu compatibility
							endIf
							if Config.HasNiOverride
								bool isRealFemale = BaseRef.GetSex() == 1
								if NiOverride.RemoveNodeTransformPosition(ActorRef, false, isRealFemale, "NPC", "SexLab.esm")
									NiOverride.UpdateNodeTransform(ActorRef, false, isRealFemale, "NPC")
								endIf
							endIf
						endIf
					endIf
					ActorRef.SetFactionRank(Config.AnimatingFaction, 2)
					ActorRef.EvaluatePackage()
				endIf
				i += 1
			endWhile
			
			CenterAlias.TryToClear()
			CenterAlias.ForceRefTo(PlayerRef) ; Make them follow me

			; Lock hotkeys and wait 30 seconds
			Utility.WaitMenuMode(1.0)
			If HotKey != -1
				RegisterForKey(HotKey)
			EndIf
			; Ready
		;	hkReady = true
			i = 28 ; Time to wait
			while i ;&& hkReady
				i -= 1
				Utility.Wait(1.0)
				if !PlayerRef.IsInFaction(Config.AnimatingFaction)
					PlayerRef.SetFactionRank(Config.AnimatingFaction, 0) ; In case some mod call ValidateActor function.
				endIf
			endWhile
		else
			If HotKey != -1
				RegisterForKey(HotKey)
			EndIf
		endIf
		if GetState() == "Resetting"
			MoveScene()
		endIf
	endFunction

	event OnKeyDown(int KeyCode)
		; StateCheck()
		if !Utility.IsInMenuMode(); || UI.IsMenuOpen("Console") || UI.IsMenuOpen("Loading Menu")
			int i = Hotkeys.Find(KeyCode)
			; Advance Stage
			if i == kAdvanceAnimation
				If Config.BackwardsPressed()
					PlayHotkeyFX(0, True)
				EndIf
				AdvanceStage(Config.BackwardsPressed())

			; Change Animation
			elseIf i == kChangeAnimation
				PlayHotkeyFX(1, Config.BackwardsPressed())
				ChangeAnimation(Config.BackwardsPressed())

			; Forward / Backward adjustments
			elseIf i == kAdjustForward
				PlayHotkeyFX(Config.AdjustStagePressed() as int, Config.BackwardsPressed())
				AdjustForward(Config.BackwardsPressed(), Config.AdjustStagePressed())

			; Up / Down adjustments
			elseIf i == kAdjustUpward
				PlayHotkeyFX(1 + Config.AdjustStagePressed() as int, Config.BackwardsPressed())
				AdjustUpward(Config.BackwardsPressed(), Config.AdjustStagePressed())

			; Left / Right adjustments
			elseIf i == kAdjustSideways
				PlayHotkeyFX(Config.AdjustStagePressed() as int, Config.BackwardsPressed())
				AdjustSideways(Config.BackwardsPressed(), Config.AdjustStagePressed())

			; Rotate Scene
			elseIf i == kRotateScene
				PlayHotkeyFX(1, !Config.BackwardsPressed())
				RotateScene(Config.BackwardsPressed())

			; Adjust schlong bend
			elseIf i == kAdjustSchlong
				AdjustSchlong(Config.BackwardsPressed())

			; Change Adjusted Actor
			elseIf i == kAdjustChange
				AdjustChange(Config.BackwardsPressed())

			; RePosition Actors
			elseIf i == kRealignActors
				PlayHotkeyFX(0, false)
				ResetPositions()

			; Change Positions
			elseIf i == kChangePositions
				ChangePositions(Config.BackwardsPressed())

			; Restore animation offsets
			elseIf i == kRestoreOffsets
				PlayHotkeyFX(0, false)
				RestoreOffsets()

			; Move Scene
			elseIf i == kMoveScene
				PlayHotkeyFX(0, false)
				MoveScene()

			; EndAnimation
			elseIf i == kEndAnimation
				UnregisterForKey(KeyCode)

				PlayHotkeyFX(2, Config.BackwardsPressed())
				if Config.BackwardsPressed()
					; End all threads
					Config.ThreadSlots.StopAll()
				else
					; End only current thread
					EndAnimation(true)
				endIf
			endIf
		endIf
	endEvent

	function MoveActors()
		Utility.Wait(0.1)
		ActorAlias[0].RefreshLoc()
		ActorAlias[1].RefreshLoc()
		ActorAlias[2].RefreshLoc()
		ActorAlias[3].RefreshLoc()
		ActorAlias[4].RefreshLoc()
		Utility.Wait(0.1)
	endFunction

	function RealignActors()
		If RealignLock
			Log("RealignLocked - Ignoring RealignActors()")
		endIf
		RealignLock = True
		UnregisterForUpdate()
		ActorAlias[0].SyncAll(true)
		ActorAlias[1].SyncAll(true)
		ActorAlias[2].SyncAll(true)
		ActorAlias[3].SyncAll(true)
		ActorAlias[4].SyncAll(true)
		Utility.Wait(0.1)
		If GetState() == "Animating"
			RegisterForSingleUpdate(0.5)
		EndIf
		RealignLock = False
	endFunction

	function TriggerOrgasm()
		UnregisterForUpdate()
		if SoundFX
			ObjectReference CenterFX = GetCenterFX()
			if CenterFX
				SoundFX.Play(CenterFX)
			endIf
		endIf
		QuickEvent("Orgasm")
		RegisterForSingleUpdate(0.5)
	endFunction

	function ResetPositions()
		int HotKey = GetThreadHotkey(kRealignActors)
		UnregisterForKey(HotKey)

		UnregisterForUpdate()
		ApplyFade()
		GoToState("Refresh")
		SyncEvent(kRefreshActor, 55.0)
	endFunction
endState

state Refresh
	function RefreshDone()
		RegisterForSingleUpdate(0.5)
	endFunction
	function ResetPositions()
		RegisterForSingleUpdate(0.5)
	endFunction
	event OnUpdate()
		GoToState("Animating")
		FireAction()
		
		int HotKey = GetThreadHotkey(kRealignActors)
		If HotKey != -1
			RegisterForKey(HotKey)
		EndIf
		HotKey = GetThreadHotkey(kChangePositions)
		If HotKey != -1
			RegisterForKey(HotKey)
		EndIf
	endEvent
endState

; ------------------------------------------------------- ;
; --- Context Sensitive Info                          --- ;
; ------------------------------------------------------- ;

function SetAnimation(int aid = -1)
	; Randomize if -1
	if aid < 0 || aid >= Animations.Length
		aid = Utility.RandomInt(0, (Animations.Length - 1))
	endIf
	; Set active animation
	Animation = Animations[aid]
	; Sort actors positions if needed
	if !SortFurnitureActors() && SortActors
		int VictimPos = Positions.Find(VictimRef)
		if Config.FixVictimPos && IsAggressive && ActorCount > 1 && VictimPos >= 0
			if Animation.HasTag("FemDom") && VictimPos == 0
				; Shuffle actor positions
				Positions[VictimPos] = Positions[1]
				Positions[1] = VictimRef
			elseIf !Animation.HasTag("FemDom") && VictimPos != 0
				; Shuffle actor positions
				Positions[VictimPos] = Positions[0]
				Positions[0] = VictimRef
			endIf
		endIf
		Positions = ThreadLib.SortActorsByAnimation(Positions, Animation)
	endIf
	UpdateAdjustKey()
	int i = ActorCount
	
	; Inform player of animation being played now
	if HasPlayer
		string msg = "Playing Animation: " + Animation.Name
		SexLabUtil.PrintConsole(msg)
		if DebugMode
			Debug.Notification(msg)
		endIf
	endIf
	; Update animation info
	RecordSkills()
	string[] Tags = Animation.GetRawTags()
	; IsType = [1] IsVaginal, [2] IsAnal, [3] IsOral, [4] IsLoving, [5] IsDirty, [6] HadVaginal, [7] HadAnal, [8] HadOral
	IsType[1]  = Females > 0 && (Tags.Find("Vaginal") != -1 || Tags.Find("Pussy") != -1)
	IsType[2]  = Tags.Find("Anal")   != -1 || (Females == 0 && Tags.Find("Vaginal") != -1)
	IsType[3]  = Tags.Find("Oral")   != -1
	IsType[4]  = Tags.Find("Loving") != -1
	IsType[5]  = Tags.Find("Dirty")  != -1
	StageCount = Animation.StageCount
	SoundFX    = Animation.GetSoundFX(Stage)
	SetBonuses()
	; Check for out of range stage
	if Stage >= StageCount
		GoToStage((StageCount - 1))
	else
		TimedStage = Animation.HasTimer(Stage)
		if Stage == 1
			ResetPositions()
		else
			ActorAlias[0].SyncAll(FALSE)
			ActorAlias[1].SyncAll(FALSE)
			ActorAlias[2].SyncAll(FALSE)
			ActorAlias[3].SyncAll(FALSE)
			ActorAlias[4].SyncAll(FALSE)
			Utility.WaitMenuMode(0.2)
			PlayStageAnimations()
		endIf
	endIf
endFunction

ObjectReference function GetCenterFX()
	if CenterRef != none && CenterRef.Is3DLoaded()
		return CenterRef
	else
		int i = 0
		while i < ActorCount
			if Positions[i] != none && Positions[i].Is3DLoaded()
				return Positions[i]
			endIf
			i += 1
		endWhile
	endIf
	return none
endFunction

float function GetTimer()
	; Custom acyclic stage timer
	if TimedStage
		return Animation.GetTimer(Stage)
	endIf
	; Default stage timers
	int last = ( Timers.Length - 1 )
	if Stage < last
		return Timers[(Stage - 1)]
	elseIf Stage >= StageCount
		return Timers[last]
	endIf
	return Timers[(last - 1)]
endFunction

function ResolveTimers()
	parent.ResolveTimers()
	if Animation
		TimedStage = Animation.HasTimer(Stage)
		if TimedStage
			Log("Stage has timer: "+Animation.GetTimer(Stage))
		endIf
	else
		TimedStage = false
	endIf
endFunction

float function GetAnimationRunTime()
	return Animation.GetTimersRunTime(Timers)
endFunction

function UpdateTimer(float AddSeconds = 0.0)
	TimedStage = true
	StageTimer += AddSeconds
endFunction

function EndLeadIn()
	if LeadIn
		UnregisterForUpdate()
		; Swap to non lead in animations
		Stage  = 1
		LeadIn = false
		SetAnimation()
		; Add runtime to foreplay skill xp
		SkillXP[0] = SkillXP[0] + (TotalTime / 10.0)
		; Restrip with new strip options
		QuickEvent("Strip")
		; Start primary animations at stage 1
		StorageUtil.SetFloatValue(Config,"SexLab.LastLeadInEnd", SexLabUtil.GetCurrentGameRealTime())
		SendThreadEvent("LeadInEnd")
		Action("Advancing")
	endIf
endFunction

function EndAnimation(bool Quickly = false)
	UnregisterForUpdate()
	Stage   = StageCount
	FastEnd = Quickly
	if HasPlayer
		MiscUtil.SetFreeCameraState(false)
		if Game.GetCameraState() < 8 && Game.GetCameraState() != 3
			Game.ForceThirdPerson()
		endIf
	endIf
	Utility.WaitMenuMode(0.5)
	GoToState("Ending")
endFunction

state Ending
	event OnBeginState()
		UnregisterForUpdate()
		if UsingFurniture && CenterRef.IsActivationBlocked()
			SetFurnitureIgnored(false)
		elseIf CenterRef.GetBaseObject() == Config.XMarkerHiddenPlace
			CenterRef.Enable()
		endIf
		SetCircleOfIntimacy()
		HookAnimationEnding()
		SendThreadEvent("AnimationEnding")
		if IsObjectiveDisplayed(0)
			SetObjectiveDisplayed(0, False)
		endIf
		RecordSkills()
		DisableHotkeys()
		Config.DisableThreadControl(self)
		SyncEvent(kResetActor, 60.0)
	endEvent
	event OnUpdate()
		ResetDone()
	endEvent
	function ResetDone()
		UnregisterforUpdate()
		HookAnimationEnd()
		SendThreadEvent("AnimationEnd")
		if Adjusted
			Log("Auto saving adjustments...")
			sslSystemConfig.SaveAdjustmentProfile()
		endIf
		GoToState("Frozen")
	endFunction
	; Don't allow to be called twice
	function EndAnimation(bool Quickly = false)
	endFunction
	function ChangeActors(Actor[] NewPositions)
	endFunction
endState

state Frozen
	; Hold before full reset so hook events can finish
	event OnBeginState()
		Log(GetState(), "OnBeginState()")
		RegisterForSingleUpdate(10.0)
	endEvent
	event OnEndState()
		Log("Returning to thread pool...")
	endEvent
	event OnUpdate()
		Initialize()
	endEvent
	function EndAnimation(bool Quickly = false)
	endFunction
	function ChangeActors(Actor[] NewPositions)
	endFunction
endState

state Resetting
	event OnBeginState()
		; The main objective of this state is ignore the update events while the scene and actors are being reissued
		Log(GetState(), "OnBeginState()")
		UnregisterforUpdate()
	endEvent
	event OnEndState()
		Log(GetState(), "OnEndState()")
	endEvent
	event OnUpdate()
		; Do nothing
	endEvent
	event OnKeyDown(int KeyCode)
		; StateCheck()
		if !Utility.IsInMenuMode(); || UI.IsMenuOpen("Console") || UI.IsMenuOpen("Loading Menu")
			int i = Hotkeys.Find(KeyCode)
			; Move Scene
			If i == kMoveScene
				PlayHotkeyFX(0, true)
				MoveScene()
			endIf
		endIf
	endEvent

	function CenterOnObject(ObjectReference CenterOn, bool resync = true)
		parent.CenterOnObject(CenterOn, resync)
		if resync
			RealignActors()
			SendThreadEvent("ActorsRelocated")
		endIf
	endFunction

	function CenterOnCoords(float LocX = 0.0, float LocY = 0.0, float LocZ = 0.0, float RotX = 0.0, float RotY = 0.0, float RotZ = 0.0, bool resync = true)
		parent.CenterOnCoords(LocX, LocY, LocZ, RotX, RotY, RotZ, resync)
		if resync
			RealignActors()
			SendThreadEvent("ActorsRelocated")
		endIf
	endFunction

	function RealignActors()
		If RealignLock
			Log("RealignLocked - Ignoring RealignActors()")
		endIf
		RealignLock = True
		ActorAlias[0].SyncAll(FALSE)
		ActorAlias[1].SyncAll(FALSE)
		ActorAlias[2].SyncAll(FALSE)
		ActorAlias[3].SyncAll(FALSE)
		ActorAlias[4].SyncAll(FALSE)
		Utility.Wait(0.1)
		RealignLock = False
	endFunction

	function MoveScene()
		int HotKey = GetThreadHotkey(kMoveScene)
		UnregisterForKey(HotKey)

		if PlayerRef.GetFactionRank(Config.AnimatingFaction) == 0
			Debug.Notification("Player movement locked - repositioning scene...")
			ApplyFade()
			; Processing Furnitures
			int PreFurnitureStatus = FurnitureTypeID
			; Disable Controls
			sslActorAlias PlayerSlot = ActorAlias(PlayerRef)
			if PlayerSlot != none
				if PlayerRef.GetFurnitureReference() == none
					PlayerSlot.SendDefaultAnimEvent() ; Seems like the CenterRef don't change if PlayerRef is running
				endIf
				PlayerSlot.UnregisterForUpdate() ; Don't whant missing Updates on the Animating State
				PlayerSlot.GoToState("Animating") ; To revert the effects of it's Resetting State
				PlayerSlot.LockActor() ; On the Animating State becouse is the one that have the event OnTranslationComplete() to hold the position
			else
				Config.GetThreadControl(self)
			endIf
			int i
			while i < ActorCount
				sslActorAlias ActorSlot = ActorAlias[i]
				if ActorSlot != none && ActorSlot != PlayerSlot
					ActorSlot.UnregisterForUpdate() ; Don't whant missing Updates on the Animating State
					ActorSlot.GoToState("Animating") ; To revert the effects of it's Resetting State
					ActorSlot.LockActor() ; On the Animating State becouse is the one that have the event OnTranslationComplete() to hold the position
				endIf
				i += 1
			endWhile
			; Clear CenterAlias to avoid player repositioning to previous position
			if CenterAlias.GetReference() != none
				CenterAlias.TryToClear()
			endIf
			; Give player time to settle incase airborne
			Utility.Wait(1.0)
			; Recenter on coords to avoid stager + resync animations
			if AreUsingFurniture(Positions) > 0
				CenterOnObject(ThreadLib.FindFurnitureForAnimation(Positions, none, PlayerRef, 300.0), false)
			endIf
			Log("PreFurnitureStatus:"+PreFurnitureStatus+" FurnitureTypeID:"+FurnitureTypeID)
			if PreFurnitureStatus != FurnitureTypeID || (PreFurnitureStatus > 0 && CenterAlias.GetReference() == none)
				ClearAnimations()
				if CenterAlias.GetReference() == none ;Is not longer using Furniture
					; Center on fallback choices
					if HasPlayer && !(PlayerRef.GetFurnitureReference() || PlayerRef.IsSwimming() || PlayerRef.IsFlying())
						CenterOnObject(PlayerRef, false)
					elseIf IsAggressive && !(VictimRef.GetFurnitureReference() || VictimRef.IsSwimming() || VictimRef.IsFlying())
						CenterOnObject(VictimRef, false)
					else
						i = 0
						while i < ActorCount
							if !(Positions[i].GetFurnitureReference() || Positions[i].IsSwimming() || Positions[i].IsFlying())
								CenterOnObject(Positions[i], false)
								i = ActorCount
							endIf
							i += 1
						endWhile
					endIf
					CenterOnObject(PlayerRef, false)
				endIf
				ChangeActors(Positions)
				SendThreadEvent("ActorsRelocated")
			elseIf CenterAlias.GetReference() != none ;Is using Furniture
				RealignActors()
				SendThreadEvent("ActorsRelocated")
			else
				CenterOnObject(PlayerRef, true)
			endIf
			; Return to animation loop
			UnregisterForUpdate()
			GoToState("Animating")
			ResetPositions()
		endIf

		If HotKey != -1 && GetState() == "Animating"
			RegisterForKey(HotKey)
		EndIf
	endFunction

	function ResetPositions()
	endFunction
endState

; ------------------------------------------------------- ;
; --- System Use Only                                 --- ;
; ------------------------------------------------------- ;

function RecordSkills()
	float TimeNow = RealTime[0]
	float xp = ((TimeNow - SkillTime) / 8.0)
	if xp >= 0.5
		if IsType[1]
			SkillXP[1] = SkillXP[1] + xp
		endIf
		if IsType[2]
			SkillXP[2] = SkillXP[2] + xp
		endIf
		if IsType[3]
			SkillXP[3] = SkillXP[3] + xp
		endIf
		if IsType[4]
			SkillXP[4] = SkillXP[4] + xp
		endIf
		if IsType[5]
			SkillXP[5] = SkillXP[5] + xp
		endIf
	endIf
	SkillTime = TimeNow
endfunction

function SetBonuses()
	SkillBonus[0] = SkillXP[0]
	if IsType[1]
		SkillBonus[1] = SkillXP[1]
	endIf
	if IsType[2]
		SkillBonus[2] = SkillXP[2]
	endIf
	if IsType[3]
		SkillBonus[3] = SkillXP[3]
	endIf
	if IsType[4]
		SkillBonus[4] = SkillXP[4]
	endIf
	if IsType[5]
		SkillBonus[5] = SkillXP[5]
	endIf
endFunction

int function GetThreadHotkey(int kIndex = -1)
	If kIndex >= 0 && Hotkeys.Length > kIndex
		return Hotkeys[kIndex]
	EndIf
	return -1
endFunction

function EnableHotkeys(bool forced = false)
	if HasPlayer || forced
		; Prepare bound keys
		Hotkeys = new int[13]
		Hotkeys[kAdvanceAnimation] = Config.AdvanceAnimation
		Hotkeys[kChangeAnimation]  = Config.ChangeAnimation
		Hotkeys[kChangePositions]  = Config.ChangePositions
		Hotkeys[kAdjustChange]     = Config.AdjustChange
		Hotkeys[kAdjustForward]    = Config.AdjustForward
		Hotkeys[kAdjustSideways]   = Config.AdjustSideways
		Hotkeys[kAdjustUpward]     = Config.AdjustUpward
		Hotkeys[kRealignActors]    = Config.RealignActors
		Hotkeys[kRestoreOffsets]   = Config.RestoreOffsets
		Hotkeys[kMoveScene]        = Config.MoveScene
		Hotkeys[kRotateScene]      = Config.RotateScene
		Hotkeys[kEndAnimation]     = Config.EndAnimation
		Hotkeys[kAdjustSchlong]    = Config.AdjustSchlong
		int i
		while i < Hotkeys.Length
			If Hotkeys[i] != -1
				RegisterForKey(Hotkeys[i])
			EndIf
			i += 1
		endwhile
		; Prepare soundfx
		HotkeyUp   = Config.HotkeyUp
		HotkeyDown = Config.HotkeyDown
		; Ready
	;	hkReady = true
	endIf
endFunction

function DisableHotkeys()
	UnregisterForAllKeys()
;	hkReady = false
endFunction

function Initialize()
	Hotkeys     = Utility.CreateIntArray(0)
	Config.DisableThreadControl(self)
	DisableHotkeys()
	SFXTimer    = 0.0
	SkillTime   = 0.0
	TimedStage  = false
	Adjusted    = false
	Prepared    = false
	AdjustAlias = ActorAlias[0]
	parent.Initialize()
endFunction

int function GetAdjustPos()
	int AdjustPos = -1
	if AdjustAlias && AdjustAlias.ActorRef
		AdjustPos = Positions.Find(AdjustAlias.ActorRef)
	endIf
	if AdjustPos == -1 && Config.TargetRef
		AdjustPos = Positions.Find(Config.TargetRef)
	endIf
	if AdjustPos == -1
		AdjustPos = (ActorCount > 1) as int
	endIf
	if Positions[AdjustPos] != PlayerRef
		Config.TargetRef = Positions[AdjustPos]
	endIf
	AdjustAlias = PositionAlias(AdjustPos)
	return AdjustPos
endFunction

function PlayStageAnimations()
	if Stage <= StageCount
		Animation.GetAnimEvents(AnimEvents, Stage)
		QuickEvent("Animate")
		StageTimer = RealTime[0] + GetTimer()
	endIf
endFunction

; ------------------------------------------------------- ;
; --- Thread Events - SYSTEM USE ONLY                 --- ;
; ------------------------------------------------------- ;



; ------------------------------------------------------- ;
; --- State Restricted                                --- ;
; ------------------------------------------------------- ;

auto state Unlocked
	function EndAnimation(bool Quickly = false)
	endFunction
endState

; State Animating
function AdvanceStage(bool backwards = false)
endFunction
function ChangeAnimation(bool backwards = false)
endFunction
function ChangePositions(bool backwards = false)
endFunction
function AdjustForward(bool backwards = false, bool AdjustStage = false)
endFunction
function AdjustSideways(bool backwards = false, bool AdjustStage = false)
endFunction
function AdjustUpward(bool backwards = false, bool AdjustStage = false)
endFunction
function RotateScene(bool backwards = false)
endFunction
function AdjustSchlong(bool backwards = false)
endFunction
function AdjustChange(bool backwards = false)
endFunction
function RestoreOffsets()
endFunction
bool RealignLock
function RealignActors()
endFunction
function MoveActors()
endFunction
function GoToStage(int ToStage)
endFunction
function ResetPositions()
endFunction
function TriggerOrgasm()
endFunction

int[] Hotkeys
int property kAdvanceAnimation = 0  autoreadonly hidden
int property kChangeAnimation  = 1  autoreadonly hidden
int property kChangePositions  = 2  autoreadonly hidden
int property kAdjustChange     = 3  autoreadonly hidden
int property kAdjustForward    = 4  autoreadonly hidden
int property kAdjustSideways   = 5  autoreadonly hidden
int property kAdjustUpward     = 6  autoreadonly hidden
int property kRealignActors    = 7  autoreadonly hidden
int property kRestoreOffsets   = 8  autoreadonly hidden
int property kMoveScene        = 9  autoreadonly hidden
int property kRotateScene      = 10 autoreadonly hidden
int property kEndAnimation     = 11 autoreadonly hidden
int property kAdjustSchlong    = 12 autoreadonly hidden

Sound[] HotkeyDown
Sound[] HotkeyUp
function PlayHotkeyFX(int i, bool backwards)
	int AdjustPos = GetAdjustPos()
	if backwards
		HotkeyDown[i].Play(Positions[AdjustPos])
	else
		HotkeyUp[i].Play(Positions[AdjustPos])
	endIf
endFunction

event OnKeyDown(int keyCode)
	; StateCheck()
endEvent

;/ function StateCheck()
	Log("THREAD STATE: "+GetState())
	if ActorCount == 1
		ActorAlias[0].Log("State: "+ActorAlias[0].GetState())
	elseIf ActorCount == 2
		ActorAlias[0].Log("State: "+ActorAlias[0].GetState())
		ActorAlias[1].Log("State: "+ActorAlias[1].GetState())
	elseIf ActorCount == 3
		ActorAlias[0].Log("State: "+ActorAlias[0].GetState())
		ActorAlias[1].Log("State: "+ActorAlias[1].GetState())
		ActorAlias[2].Log("State: "+ActorAlias[2].GetState())
	elseIf ActorCount == 4
		ActorAlias[0].Log("State: "+ActorAlias[0].GetState())
		ActorAlias[1].Log("State: "+ActorAlias[1].GetState())
		ActorAlias[2].Log("State: "+ActorAlias[2].GetState())
		ActorAlias[3].Log("State: "+ActorAlias[3].GetState())
	elseIf ActorCount == 5
		ActorAlias[0].Log("State: "+ActorAlias[0].GetState())
		ActorAlias[1].Log("State: "+ActorAlias[1].GetState())
		ActorAlias[2].Log("State: "+ActorAlias[2].GetState())
		ActorAlias[3].Log("State: "+ActorAlias[3].GetState())
		ActorAlias[4].Log("State: "+ActorAlias[4].GetState())
	endIf
endFunction /;

;SLSO, block stage advancing/finishing animation until aggressor orgasms once
int function SLSO_Animating_GoToStage(int ToStage)
	int maxStage = StageCount - 1
	; if possible do not proceed to last stage until after orgasm
	if StageCount > 2
		maxStage = StageCount - 2
	endIf
	
	if Stage > maxStage
		if SLSO_shouldrun_SLSO_Animating_GoToStage
			String File = "/SLSO/Config.json"
			int i = ActorCount
			while i > 0
				i -= 1
				if ActorAlias[i].GetRef() != none
					if ActorAlias[i].IsAggressor() && ((ActorAlias[i].GetRef() != GetPlayer() && JsonUtil.GetIntValue(File, "condition_aggressor_orgasm") == 1) || (ActorAlias[i].GetRef() == GetPlayer() && JsonUtil.GetIntValue(File, "condition_player_aggressor_orgasm") == 1))
						if ((ActorAlias[i].IsCreature() && JsonUtil.GetIntValue(File, "game_enabled") == 1) || !ActorAlias[i].IsCreature())
							if ActorAlias[i].GetOrgasmCount() < Get_minimum_aggressor_orgasm_Count() && ActorAlias[i].IsOrgasmAllowed()
								Bool Belted = false
								
								if JsonUtil.GetIntValue(File, "condition_ddbelt_orgasm") == 0
									Keyword zadDeviousBelt = None
									if Config.HasZadDevice
										zadDeviousBelt = Game.GetFormFromFile(0x3330, "Devious Devices - Assets.esm") As Keyword
										if (ActorAlias[i].GetRef() as Actor).WornHasKeyword(zadDeviousBelt)
											Belted = true
											i = 0
											Log("Lead is DD belted, DD belt orgasms blocked, ending animation")
										EndIf
									EndIf
								EndIf
								
								if Belted == false
									int minStage = 1
									; If there are more than 5 stages, do not include first 2
									if StageCount > 5
										minStage = 3
									; If there are more than 3 stages, do not include first 1(often transition)
									elseIf StageCount > 3
										minStage = 2
									endIf

									ToStage = Utility.RandomInt(minStage, maxStage)
									if ActorAlias[i].GetRef() != GetPlayer()
										if JsonUtil.GetIntValue(File, "condition_aggressor_change_animation") == 1
											ToStage = -1
										endif
									endif
									i = 0
									Log("Lead is not satisfied, setting stage to " + ToStage)
								endif
							endIf
						endIf
					endIf
				endIf
			endWhile
		endIf
	endIf
	return ToStage
endFunction




;SLSO
bool SLSO_shouldrun_SLSO_Animating_GoToStage = false

int SLSO_condition_minimum_aggressor_orgasm = -1
int function Get_minimum_aggressor_orgasm_Count()
	;not set, setup
	if SLSO_condition_minimum_aggressor_orgasm == -1
		String File = "/SLSO/Config.json"
		;game on, use min orgasm
		if JsonUtil.GetIntValue(File, "game_enabled") == 1
			SLSO_condition_minimum_aggressor_orgasm = JsonUtil.GetIntValue(File, "condition_minimum_aggressor_orgasm")
		;game off, use 1
		else
			SLSO_condition_minimum_aggressor_orgasm = 1
		endif
	endif
	return SLSO_condition_minimum_aggressor_orgasm
endFunction

int SLSO_condition_maximum_aggressor_orgasm = -1
int function Get_maximum_aggressor_orgasm_Count()
	;not set, setup
	if SLSO_condition_maximum_aggressor_orgasm == -1
		String File = "/SLSO/Config.json"
		;game on, use min orgasm
		if JsonUtil.GetIntValue(File, "game_enabled") == 1
			SLSO_condition_maximum_aggressor_orgasm = JsonUtil.GetIntValue(File, "condition_maximum_aggressor_orgasm")
		;game off, use 1
		else
			SLSO_condition_maximum_aggressor_orgasm = 1
		endif
	endif
	return SLSO_condition_maximum_aggressor_orgasm
endFunction

function Set_minimum_aggressor_orgasm_Count(int i)
	if i < 1
		SLSO_condition_minimum_aggressor_orgasm = 0
	elseif Get_maximum_aggressor_orgasm_Count() > 0
		if SLSO_condition_maximum_aggressor_orgasm > i
			SLSO_condition_minimum_aggressor_orgasm = i
		else
			SLSO_condition_minimum_aggressor_orgasm = SLSO_condition_maximum_aggressor_orgasm
		endif
	else
		SLSO_condition_minimum_aggressor_orgasm = i
	endif
endFunction

function Set_maximum_aggressor_orgasm_Count(int i)
	if i < 1
		SLSO_condition_maximum_aggressor_orgasm = 0
	else
		SLSO_condition_maximum_aggressor_orgasm = i
	endif
endFunction

;int property SLSO_condition_minimum_aggressor_orgasm
;int property SLSO_condition_maximum_aggressor_orgasm
