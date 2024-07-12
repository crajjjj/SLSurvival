Scriptname zbfConfig extends zbfConfigBase

zbfSexLab Property SexLab Auto
zbfBondageShell Property Main Auto
zbfSlaveControl Property SlaveControl Auto
zbfSlaveActions Property SlaveActions Auto Hidden ; Same object as SlaveControl
zbfSlaveLeash Property SlaveLeash Auto Hidden ; Same object as SlaveControl
Quest Property SharedDialogue Auto
Quest Property TestDialogue Auto
zbfExternalInterface Property External Auto

Actor PlayerRef

;
; Settings variables
; 

; Global variables
GlobalVariable Property zbfSettingUpdateInterval Auto
GlobalVariable Property zbfSettingDisableEffects Auto
GlobalVariable Property zbfSettingSpeedMult Auto
GlobalVariable Property zbfSettingBlindStrength Auto
GlobalVariable Property zbfSettingBlindPulseStrength Auto
GlobalVariable Property zbfSettingDebugMode Auto

; Global variable setting indices
Int oidUpdateInterval
Int oidDisableEffects
Int oidSpeedMult
Int oidBlindStrength
Int oidBlindPulseStrength

; Settings

; 5.50

; Gag sounds selection (female)
Int oidGagSoundFemale
Int Property idxGagSoundFemale Auto Hidden
String[] sGagSoundFemale
; Gag sounds selection (male)
Int oidGagSoundMale
Int Property idxGagSoundMale Auto Hidden
String[] sGagSoundMale
; Gag sound volume
Int oidGagSoundVolume
Float Property fGagSoundVolume Auto Hidden
; Gag sound frequency
Int oidGagSoundFrequency
Float Property fGagSoundFrequency Auto Hidden
; Gag sound repeat
Int oidGagSoundRepeat
Bool Property bGagSoundRepeat Auto Hidden
; Gag sound repeat
Int oidForceAi
Bool Property bForceAi Auto Hidden
; Bound offset selection
Int oidDefaultOffset
Int Property idxDefaultOffset Auto Hidden
String[] sDefaultOffset

; 5.60
String[] sUpdateInterval
Int oidUpdateIntervalPlayer
Int Property idxUpdateIntervalPlayer Auto Hidden
Int oidUpdateIntervalNpc
Int Property idxUpdateIntervalNpc Auto Hidden
Int oidGagSoundAuto
Bool Property bGagSoundAuto Auto Hidden
Int oidRebuildBaseAnimations ; Just a button

; Animation control
String[] sAnimationTypes
Int oidAnimationTypes
Int idxAnimationTypes
String[] sAnimationIndex
String[] sAnimationId
Int oidAnimationIndex
Int idxAnimationIndex
String sSelectedAnimationEvent
Int oidPlayIdleAnimation
zbfSexLabBaseEntry SelectedBaseEntry
Int oidPlaySexLabAnimation


; 5.62
Int oidAnimationHelp

; Loose buttons and other misc controls
Int oidRegisterSexLab
Int oidRestart
Int oidReleaseAi
Int oidResetControls

; 6.00
Int oidOverrideSexLabSound
Int oidForceSilenceSexLabSound
Int oidDebugLogging
Bool Property bDebugLogging Auto Hidden
Int oidTestButton

; 6.02
Int oidDebugMode
Int oidDialogueTest
GlobalVariable Property zbfSettingDialogueTest Auto

; 6.05
Int oidOverrideSexLabAnimation
Int oidOverrideSexLabExpression
Int iSelectActorKey
Int oidSelectActorKey
Actor[] Property SelectSlots Auto Hidden
Actor Property SelectedActor Auto Hidden
String[] sSelectSlotNames
Int oidSelectActorMenu
Int idxSelectActorMenu

Int[] oidSexLabActor
Int[] idxSexLabActor
Actor[] Property SexLabActors Auto Hidden

Int oidFilterActors
Bool bFilterActors

Int[] oidSlots				; All indices of actors in the slots sub-menu.
Int idxSelectedSlot			; Which is currently selected from these?
zbfSlot CurrentSlot			; Slot selected, matched idxSelectedSlot
zbfSlot PlayerSlot			; Player slot, always active
Int oidSelectedActorSlot	; Actor currently selected in the slots sub-menu. Can be slotted.

Int oidAddSlotActor
Int oidRemoveSlotActor

Int oidArmBindings
Int idxArmBindings
String[] sArmBindings
Form[] ArmBindings

Int oidGag
Int idxGag
String[] sGags
Form[] Gags

Int oidLegBindings
Int idxLegBindings
String[] sLegBindings
Form[] LegBindings

Int oidBlindfold
Int idxBlindfold
String[] sBlindfolds
Form[] Blindfolds

Int oidArmAnim
Int idxArmAnim
String[] sArmAnim
String[] sArmAnimTranslate

Int oidStillAnim
Int idxStillAnim
String[] sAnim
String[] sAnimTranslate

Int oidForceAnim
Int idxForceAnim

Int oidSlotMouthIndex
Int oidSlotExpressionIndex
Int oidSlotExpressionStrength
Int oidSlotMovementSpeed

Int oidSlotDisableMovement
Bool Property bSlotDisableMovement Auto Hidden
Int oidSlotDisableFight
Bool Property bSlotDisableFight Auto Hidden
Int oidSlotDisableSneak
Bool Property bSlotDisableSneak Auto Hidden
Int oidSlotDisableMenu
Bool Property bSlotDisableMenu Auto Hidden
Int oidSlotDisableActivate
Bool Property bSlotDisableActivate Auto Hidden

Int oidSlaveAiDistance
Int oidSlaveTeleportDistance

Int oidSlaveArrivalBegin
Int oidSlaveArrivalEnd

; 6.06
Int oidSlotOverlayDrool
Int oidSlotOverlayTears
Int oidSlotOverlayDirt
Int oidSlotOverlayScars

; 6.07
Int oidBlindfoldMethod
String[] sBlindfoldMethod
Int oidSlotBlindfoldMethod

; 6.08
Int oidSlaveAiCooldown
Int oidSlaveControlCooldown



; Convenience properties
Bool Property bDisableEffects
	Bool Function Get()
		Return zbfSettingDisableEffects.GetValueInt() != 0
	EndFunction
EndProperty
Float Property fUpdateInterval
	Float Function Get()
		Return zbfSettingUpdateInterval.GetValue()
	EndFunction
EndProperty
Float Property fSpeedMult
	Float Function Get()
		Return zbfSettingSpeedMult.GetValue()
	EndFunction
EndProperty
Float Property fBlindPulseStrength
	Float Function Get()
		Return zbfSettingBlindPulseStrength.GetValue()
	EndFunction
EndProperty
Float Property fUpdateIntervalPlayer
	Float Function Get()
		Return IndexToUpdateInterval(idxUpdateIntervalPlayer)
	EndFunction
EndProperty
Float Property fUpdateIntervalNpc
	Float Function Get()
		Return IndexToUpdateInterval(idxUpdateIntervalNpc)
	EndFunction
EndProperty
Int Property iDefaultOffset
	Int Function Get()
		If idxDefaultOffset == 0
			Return 11
		ElseIf idxDefaultOffset == 1
			Return 1
		ElseIf idxDefaultOffset == 2
			Return 6
		ElseIf idxDefaultOffset == 3
			Return 2
		EndIf
		Return 11
	EndFunction
EndProperty

zbfConfig Function GetApi() Global
	Return zbfUtil.GetGenericForm(0x0200c243) As zbfConfig
EndFunction

Int Function GetVersion()
	Return zbfUtil.GetVersion()
EndFunction

Event OnGameReload()
	External.Initialize()

	Log("OnGameReload", "External is not running.", abCondition = (!External.IsRunning()))
	Parent.OnGameReload()
EndEvent

Function OnUpdateEvent(Int aiOldVersion, Int aiVersion)
	Log("OnUpdateEvent", ModName + ": Version from " + aiOldVersion + " to " + aiVersion, iForce)
	Log("OnUpdateEvent", ModName + ": Update proceeding", iForce)
	Log("OnUpdateEvent", ModName + ": Script version " + zbfUtil.GetVersion(), iForce)

	RestartAllQuests()

	If aiOldVersion < 500
		zbfSettingUpdateInterval.SetValue(0.5)
		zbfSettingDisableEffects.SetValueInt(0)
		zbfSettingSpeedMult.SetValueInt(70)
		zbfSettingBlindStrength.SetValueInt(50)
		zbfSettingBlindPulseStrength.SetValueInt(50)
	EndIf

	If aiOldVersion <= 550
		; Nothing yet
		idxGagSoundFemale = 1
		idxGagSoundMale = 0
		fGagSoundVolume = 100.0
		fGagSoundFrequency = 10.0
		bGagSoundRepeat = False
		bForceAi = False
		idxDefaultOffset = 0
	EndIf

	If aiOldVersion <= 560
		idxGagSoundMale = 2
		idxGagSoundFemale = 3

		idxUpdateIntervalPlayer = 0
		idxUpdateIntervalNpc = 2

		fGagSoundVolume = 100.0
		bGagSoundAuto = True

		idxAnimationTypes = 0
		idxAnimationIndex = 0
	EndIf

	If aiOldVersion <= 600
		SetDebugMode(False, False)
	EndIf

	If aiOldVersion <= 602
		zbfSettingDialogueTest.SetValueInt(1)
	EndIf

	If aiOldVersion <= 605
		iSelectActorKey = 49 ; N set by default, same as SexLab
		RegisterForKey(iSelectActorKey)
		PlayerRef = Game.GetPlayer() ; Yes, only just made it in the 6.05 version :/
		SelectSlots = New Actor[6]
		SelectSlots[0] = None
		SelectSlots[1] = PlayerRef
		idxSelectActorMenu = 0

		oidSexLabActor = New Int[4]
		oidSexLabActor[0] = -1
		oidSexLabActor[1] = -1
		oidSexLabActor[2] = -1
		oidSexLabActor[3] = -1
		idxSexLabActor = New Int[4]
		SexLabActors = New Actor[4]

		bFilterActors = True
	EndIf

	If aiOldVersion <= 607
		Main.idxBlindfoldMethod = 2
		Main.fBlindfoldStrength = 0.5

		Main.iDefaultBoundOffset = iDefaultOffset
		Main.fUpdateIntervalPlayer = fUpdateIntervalPlayer
		Main.fUpdateIntervalNpc = fUpdateIntervalNpc
		Main.bGagSoundRepeat = bGagSoundRepeat
		Main.fGagSoundFrequency = fGagSoundFrequency
		Main.idxGagSoundFemale = idxGagSoundFemale
		Main.idxGagSoundMale = idxGagSoundMale
		Main.fGagSoundVolume = fGagSoundVolume
	EndIf

	If aiOldVersion <= 608
		SexLab.bOverrideSexLabSound = True
		SexLab.bForceSilenceSexLabSound = False
		SexLab.bOverrideSexLabExpression = True
		SexLab.bOverrideSexLabAnimation = True
	EndIf

	; Debug?
	Int iDebugNumber = Game.GetModByName("db_tg_armors.esp")
	If  iDebugNumber != 255
		SetDebugMode(True, True)
	EndIf

	Log("OnUpdateEvent", ModName + " quest running (zbf) - " + Main.IsRunning(), iForce)
	Log("OnUpdateEvent", ModName + " quest running (zbfSexLab) - " + SexLab.IsRunning(), iForce)
	Log("OnUpdateEvent", ModName + " quest running (zbfConfig) - " + IsRunning(), iForce)
	Log("OnUpdateEvent", ModName + " quest running (zbfSlaveControl) - " + SlaveControl.IsRunning(), iForce)
	Log("OnUpdateEvent", ModName + " quest running (zbfSlaveActions) - " + SlaveActions.IsRunning(), iForce)
	Log("OnUpdateEvent", ModName + " quest running (zbfSlaveLeash) - " + SlaveLeash.IsRunning(), iForce)
	Log("OnUpdateEvent", ModName + " quest running (zbfDialogue) - " + SharedDialogue.IsRunning(), iForce)
	Log("OnUpdateEvent", ModName + " quest running (zbfDialogueTest) - " + TestDialogue.IsRunning(), iForce)
	Log("OnUpdateEvent", ModName + " quest running (zbfExternal) - " + External.IsRunning(), iForce)

	; Start up SexLab integration, do not automatically register animations
	SexLab.InitializeModule()
	Main.InitializeModule()
	If SexLab.HasSexLab()
		Main.zbfIsAnimatingExtra = SexLab.GetAnimatingFaction()
	EndIf
	SlaveControl.RegisterForEvents()
	SlaveActions.RegisterForEvents()
	SlaveLeash.SetAllDefaults()

	Log("OnUpdateEvent", ModName + " finished updating.", iForce)
	Debug.Notification(ModName + " version " + zbfUtil.GetVersionStr())
EndFunction

;
; Settings parameters
;
Float Function GetFloat(Int aiOption)
	If aiOption == oidUpdateInterval
		Return fUpdateInterval
	ElseIf aiOption == oidDisableEffects
		Return bDisableEffects As Float
	ElseIf aiOption == oidSpeedMult
		Return fSpeedMult
	ElseIf aiOption == oidBlindStrength
		Return Main.fBlindfoldStrength * 100.0
	ElseIf aiOption == oidBlindPulseStrength
		Return fBlindPulseStrength

	; 5.50
	ElseIf aiOption == oidGagSoundFemale
		Return idxGagSoundFemale
	ElseIf aiOption == oidGagSoundMale
		Return idxGagSoundMale
	ElseIf aiOption == oidGagSoundVolume
		Return fGagSoundVolume
	ElseIf aiOption == oidGagSoundFrequency
		Return fGagSoundFrequency
	ElseIf aiOption == oidForceAi
		Return bForceAi As Float
	ElseIf aiOption == oidGagSoundRepeat
		Return bGagSoundRepeat As Float
	ElseIf aiOption == oidDefaultOffset
		Return idxDefaultOffset

	; 5.60
	ElseIf aiOption == oidUpdateIntervalPlayer
		Return idxUpdateIntervalPlayer
	ElseIf aiOption == oidUpdateIntervalNpc
		Return idxUpdateIntervalNpc
	ElseIf aiOption == oidGagSoundAuto
		Return bGagSoundAuto As Float
	ElseIf aiOption == oidAnimationTypes
		Return idxAnimationTypes
	ElseIf aiOption == oidAnimationIndex
		Return idxAnimationIndex

	; 6.00
	ElseIf aiOption == oidOverrideSexLabSound
		Return SexLab.bOverrideSexLabSound As Float
	ElseIf aiOption == oidForceSilenceSexLabSound
		Return SexLab.bForceSilenceSexLabSound As Float
	ElseIf aiOption == oidDebugLogging
		Return bDebugLogging As Float

	; 6.02
	ElseIf aiOption == oidDebugMode
		Return (GetDebugMode()) As Float
	ElseIf aiOption == oidDialogueTest
		Return (zbfSettingDialogueTest.GetValueInt() > 0) As Float
		
	; 6.05
	ElseIf aiOption == oidOverrideSexLabAnimation
		Return SexLab.bOverrideSexLabAnimation As Float
	ElseIf aiOption == oidOverrideSexLabExpression
		Return SexLab.bOverrideSexLabExpression As Float
	ElseIf aiOption == oidSelectActorKey
		Return iSelectActorKey
	ElseIf aiOption == oidSelectActorMenu
		Return idxSelectActorMenu
	ElseIf aiOption == oidSexLabActor[0]
		Return idxSexLabActor[0]
	ElseIf aiOption == oidSexLabActor[1]
		Return idxSexLabActor[1]
	ElseIf aiOption == oidSexLabActor[2]
		Return idxSexLabActor[2]
	ElseIf aiOption == oidSexLabActor[3]
		Return idxSexLabActor[3]
	ElseIf aiOption == oidFilterActors
		Return bFilterActors As Float

	; Forced bindings
	ElseIf aiOption == oidArmBindings
		Return idxArmBindings
	ElseIf aiOption == oidGag
		Return idxGag
	ElseIf aiOption == oidLegBindings
		Return idxLegBindings
	ElseIf aiOption == oidBlindfold
		Return idxBlindfold

	; Forced animations
	ElseIf aiOption == oidArmAnim
		Return idxArmAnim
	ElseIf aiOption == oidStillAnim
		Return idxStillAnim
	ElseIf aiOption == oidForceAnim
		Return idxForceAnim

	; Forced expressions
	ElseIf aiOption == oidSlotMouthIndex
		Return CurrentSlot.iMouthAnim
	ElseIf aiOption == oidSlotExpressionIndex
		Return CurrentSlot.iExpression
	ElseIf aiOption == oidSlotExpressionStrength
		Return CurrentSlot.iExpressionStrength

	; Forced player controls
	ElseIf aiOption == oidSlotDisableMovement
		Return zbfUtil.HasFlag(CurrentSlot.iPlayerControlMask, 0x001) As Float
	ElseIf aiOption == oidSlotDisableFight
		Return zbfUtil.HasFlag(CurrentSlot.iPlayerControlMask, 0x002) As Float
	ElseIf aiOption == oidSlotDisableSneak
		Return zbfUtil.HasFlag(CurrentSlot.iPlayerControlMask, 0x004) As Float
	ElseIf aiOption == oidSlotDisableMenu
		Return zbfUtil.HasFlag(CurrentSlot.iPlayerControlMask, 0x008) As Float
	ElseIf aiOption == oidSlotDisableActivate
		Return zbfUtil.HasFlag(CurrentSlot.iPlayerControlMask, 0x010) As Float

	; Slave leash controls
	ElseIf aiOption == oidSlaveAiDistance
		Return SlaveLeash.fMaxLeashLength
	ElseIf aiOption == oidSlaveTeleportDistance
		Return SlaveLeash.fTeleportDistance

	; 6.06
	ElseIf aiOption == oidSlotOverlayDrool
		Return CurrentSlot.iOverlayDrool
	ElseIf aiOption == oidSlotOverlayTears
		Return CurrentSlot.iOverlayTears
	ElseIf aiOption == oidSlotOverlayDirt
		Return CurrentSlot.iOverlayDirt
	ElseIf aiOption == oidSlotOverlayScars
		Return CurrentSlot.iOverlayScars

	; 6.07
	ElseIf aiOption == oidBlindfoldMethod
		Return Main.idxBlindfoldMethod
	ElseIf aiOption == oidSlotBlindfoldMethod
		Return CurrentSlot.iBlindfoldMode

	; 6.08
	ElseIf aiOption == oidSlaveAiCooldown
		Return SlaveLeash.fMinInterruptTime
	ElseIf aiOption == oidSlaveControlCooldown
		Return SlaveLeash.fMinAiTime

	EndIf

	Log("GetFloat", "Unknown configuration option requested", iWarning)
EndFunction

Function SetFloat(Int aiOption, Float afValue)
	Bool abValue = (afValue != 0)
	Int aiValue = (afValue As Int)

	If aiOption == oidUpdateInterval
		zbfSettingUpdateInterval.SetValue(afValue)
	ElseIf aiOption == oidDisableEffects
		zbfSettingDisableEffects.SetValue(afValue)
	ElseIf aiOption == oidSpeedMult
		zbfSettingSpeedMult.SetValue(afValue)
	ElseIf aiOption == oidBlindStrength
		zbfSettingBlindStrength.SetValue(afValue)
		Main.fBlindfoldStrength = afValue / 100.0
		PlayerSlot.SetBlindfoldMode(PlayerSlot.iBlindfoldMode, PlayerSlot.BlindfoldModifier)
	ElseIf aiOption == oidBlindPulseStrength
		zbfSettingBlindPulseStrength.SetValue(afValue)

	; 5.50
	ElseIf aiOption == oidGagSoundFemale
		idxGagSoundFemale = aiValue
		Main.idxGagSoundFemale = idxGagSoundFemale
		Debug.Trace("Main.idxGagSoundFemale = " + Main.idxGagSoundFemale)
	ElseIf aiOption == oidGagSoundMale
		idxGagSoundMale = aiValue
		Main.idxGagSoundMale = idxGagSoundMale
		Debug.Trace("Main.idxGagSoundMale = " + Main.idxGagSoundMale)
	ElseIf aiOption == oidGagSoundVolume
		fGagSoundVolume = afValue
		Main.fGagSoundVolume = fGagSoundVolume
		Debug.Trace("Main.fGagSoundVolume = " + Main.fGagSoundVolume)
	ElseIf aiOption == oidGagSoundFrequency
		fGagSoundFrequency = afValue
		Main.fGagSoundFrequency = afValue
		Debug.Trace("Main.fGagSoundFrequency = " + Main.fGagSoundFrequency)
	ElseIf aiOption == oidForceAi
		bForceAi = abValue
	ElseIf aiOption == oidGagSoundRepeat
		bGagSoundRepeat = abValue
		Main.bGagSoundRepeat = bGagSoundRepeat
		Debug.Trace("Main.bGagSoundRepeat = " + Main.bGagSoundRepeat)
	ElseIf aiOption == oidDefaultOffset
		idxDefaultOffset = aiValue
		Main.iDefaultBoundOffset = iDefaultOffset ; Property function Get() will mutate the value
		Debug.Trace("Main.iDefaultBoundOffset = " + Main.iDefaultBoundOffset)

	; 5.60
	ElseIf aiOption == oidUpdateIntervalPlayer
		idxUpdateIntervalPlayer = aiValue
		Main.fUpdateIntervalPlayer = fUpdateIntervalPlayer ; Property function Get() will mutate the value
		Debug.Trace("Main.fUpdateIntervalPlayer = " + Main.fUpdateIntervalPlayer)
	ElseIf aiOption == oidUpdateIntervalNpc
		idxUpdateIntervalNpc = aiValue
		Main.fUpdateIntervalNpc = fUpdateIntervalNpc ; Property function Get() will mutate the value
		Debug.Trace("Main.fUpdateIntervalNpc = " + Main.fUpdateIntervalNpc)
	ElseIf aiOption == oidGagSoundAuto
		bGagSoundAuto = abValue
	ElseIf aiOption == oidAnimationTypes
		idxAnimationTypes = aiValue
	ElseIf aiOption == oidAnimationIndex
		idxAnimationIndex = aiValue

	; 6.00
	ElseIf aiOption == oidOverrideSexLabSound
		SexLab.bOverrideSexLabSound = abValue
	ElseIf aiOption == oidForceSilenceSexLabSound
		SexLab.bForceSilenceSexLabSound = abValue
	ElseIf aiOption == oidDebugLogging
		SetDebugMode(bDebugMode, abValue)

	; 6.02
	ElseIf aiOption == oidDebugMode
		SetDebugMode(abValue, bDebugLogging)
	ElseIf aiOption == oidDialogueTest
		zbfSettingDialogueTest.SetValueInt(aiValue)

	; 6.05
	ElseIf aiOption == oidOverrideSexLabAnimation
		SexLab.bOverrideSexLabAnimation = abValue
	ElseIf aiOption == oidOverrideSexLabExpression
		SexLab.bOverrideSexLabExpression = abValue
	ElseIf aiOption == oidSelectActorKey
		iSelectActorKey = aiValue
	ElseIf aiOption == oidSelectActorMenu
		idxSelectActorMenu = aiValue
	ElseIf aiOption == oidSexLabActor[0]
		idxSexLabActor[0] = aiValue
		ForcePageReset()
	ElseIf aiOption == oidSexLabActor[1]
		idxSexLabActor[1] = aiValue
		ForcePageReset()
	ElseIf aiOption == oidSexLabActor[2]
		idxSexLabActor[2] = aiValue
		ForcePageReset()
	ElseIf aiOption == oidSexLabActor[3]
		idxSexLabActor[3] = aiValue
		ForcePageReset()
	ElseIf aiOption == oidFilterActors
		bFilterActors = abValue
		ForcePageReset()

	; Forced bindings
	ElseIf aiOption == oidArmBindings
		If sArmBindings[aiValue] != "No change"
			idxArmBindings = aiValue
			CurrentSlot.RemoveBinding(CurrentSlot.GetArmBindings())
			CurrentSlot.SetBinding(ArmBindings[idxArmBindings])
			ForcePageReset()
		EndIf
	ElseIf aiOption == oidGag
		If sGags[aiValue] != "No change"
			idxGag = aiValue
			CurrentSlot.RemoveBinding(CurrentSlot.GetGag())
			CurrentSlot.SetBinding(Gags[idxGag])
			ForcePageReset()
		EndIf
	ElseIf aiOption == oidLegBindings
		If sLegBindings[aiValue] != "No change"
			idxLegBindings = aiValue
			CurrentSlot.RemoveBinding(CurrentSlot.GetLegBindings())
			CurrentSlot.SetBinding(LegBindings[idxLegBindings])
			ForcePageReset()
		EndIf
	ElseIf aiOption == oidBlindfold
		If sBlindfolds[aiValue] != "No change"
			idxBlindfold = aiValue
			CurrentSlot.RemoveBinding(CurrentSlot.GetBlindfold())
			CurrentSlot.SetBinding(Blindfolds[idxBlindfold])
			ForcePageReset()
		EndIf

	; Forced animations
	ElseIf aiOption == oidArmAnim
		idxArmAnim = aiValue
		CurrentSlot.SetOffsetAnim(sArmAnimTranslate[idxArmAnim])
		SetupAnimStringVars()
	ElseIf aiOption == oidStillAnim
		idxStillAnim = aiValue
		CurrentSlot.SetStillAnim(sAnimTranslate[idxStillAnim])
	ElseIf aiOption == oidForceAnim
		idxForceAnim = aiValue
		CurrentSlot.SetAnim(sAnimTranslate[idxForceAnim])

	; Forced expressions
	ElseIf aiOption == oidSlotMouthIndex
		CurrentSlot.SetMouthAnim(aiValue)
	ElseIf aiOption == oidSlotExpressionIndex
		CurrentSlot.SetExpressionAnim(aiValue, CurrentSlot.iExpressionStrength)
	ElseIf aiOption == oidSlotExpressionStrength
		CurrentSlot.SetExpressionAnim(CurrentSlot.iExpression, aiValue)

	; Forced player controls
	ElseIf aiOption == oidSlotDisableMovement
		CurrentSlot.SetPlayerControlMask(zbfUtil.FlipFlag(CurrentSlot.iPlayerControlMask, 0x001))
	ElseIf aiOption == oidSlotDisableFight
		CurrentSlot.SetPlayerControlMask(zbfUtil.FlipFlag(CurrentSlot.iPlayerControlMask, 0x002))
	ElseIf aiOption == oidSlotDisableSneak
		CurrentSlot.SetPlayerControlMask(zbfUtil.FlipFlag(CurrentSlot.iPlayerControlMask, 0x004))
	ElseIf aiOption == oidSlotDisableMenu
		CurrentSlot.SetPlayerControlMask(zbfUtil.FlipFlag(CurrentSlot.iPlayerControlMask, 0x008))
	ElseIf aiOption == oidSlotDisableActivate
		CurrentSlot.SetPlayerControlMask(zbfUtil.FlipFlag(CurrentSlot.iPlayerControlMask, 0x010))

	; Slave leash controls
	ElseIf aiOption == oidSlaveAiDistance
		SlaveLeash.SetDistances(afValue, SlaveLeash.fTeleportDistance)
	ElseIf aiOption == oidSlaveTeleportDistance
		SlaveLeash.SetDistances(SlaveLeash.fMaxLeashLength, afValue)

	; 6.06
	ElseIf aiOption == oidSlotOverlayDrool
		CurrentSlot.SetDroolOverlay(aiValue)
	ElseIf aiOption == oidSlotOverlayTears
		CurrentSlot.SetTearsOverlay(aiValue)
	ElseIf aiOption == oidSlotOverlayDirt
		CurrentSlot.SetDirtOverlay(aiValue)
	ElseIf aiOption == oidSlotOverlayScars
		CurrentSlot.SetScarsOverlay(aiValue)

	; 6.07
	ElseIf aiOption == oidBlindfoldMethod
		Main.idxBlindfoldMethod = aiValue
	ElseIf aiOption == oidSlotBlindfoldMethod
		PlayerSlot.SetBlindfoldMode(aiValue, PlayerSlot.BlindfoldModifier)

	; 6.08
	ElseIf aiOption == oidSlaveAiCooldown 
		SlaveLeash.SetControlInterrupt(SlaveLeash.fMinAiTime, afValue)
	ElseIf aiOption == oidSlaveControlCooldown 
		SlaveLeash.SetControlInterrupt(afValue, SlaveLeash.fMinInterruptTime)

	; End of list ...
	EndIf
EndFunction

String[] Function GetStrings(Int aiOption)
	If aiOption == oidGagSoundFemale
		Return sGagSoundFemale
	ElseIf aiOption == oidGagSoundMale
		Return sGagSoundMale
	ElseIf aiOption == oidDefaultOffset
		Return sDefaultOffset

	; 5.60
	ElseIf aiOption == oidUpdateIntervalPlayer
		Return sUpdateInterval
	ElseIf aiOption == oidUpdateIntervalNpc
		Return sUpdateInterval
	ElseIf aiOption == oidAnimationTypes
		Return sAnimationTypes
	ElseIf aiOption == oidAnimationIndex
		Return sAnimationIndex
		
	; 6.05
	ElseIf aiOption == oidSelectActorMenu
		Return sSelectSlotNames
	ElseIf aiOption == oidSexLabActor[0]
		Return sSelectSlotNames
	ElseIf aiOption == oidSexLabActor[1]
		Return sSelectSlotNames
	ElseIf aiOption == oidSexLabActor[2]
		Return sSelectSlotNames
	ElseIf aiOption == oidSexLabActor[3]
		Return sSelectSlotNames

	ElseIf aiOption == oidArmAnim
		Return sArmAnim
	ElseIf aiOption == oidStillAnim
		Return sAnim
	ElseIf aiOption == oidForceAnim
		Return sAnim

	ElseIf aiOption == oidArmBindings
		Return sArmBindings
	ElseIf aiOption == oidGag
		Return sGags
	ElseIf aiOption == oidLegBindings
		Return sLegBindings
	ElseIf aiOption == oidBlindfold
		Return sBlindfolds

	ElseIf aiOption == oidBlindfoldMethod
		Return sBlindfoldMethod
	ElseIf aiOption == oidSlotBlindfoldMethod
		Return sBlindfoldMethod

	EndIf

	Log("GetStrings", "Unregistered string requested", iWarning)
	Return Parent.GetStrings(aiOption)
EndFunction

Event OnKeyUp(Int aiKeyCode, Float afHoldTime)
	If zbfUtil.IsInMenu()
		Return
	EndIf

	If aiKeyCode == iSelectActorKey
		Actor current = None
		current = Game.GetCurrentCrosshairRef() As Actor
		If !zbfUtil.IsValidActor(current)
			current = Game.GetCurrentConsoleRef() As Actor
		EndIf

		If (current != PlayerRef) && zbfUtil.IsValidActor(current)
			AddActorToSelection(current)
			SelectedActor = current
			Debug.Notification("ZaZ Animation Pack: Selected actor " + zbfUtil.GetActorName(current))
		EndIf
	EndIf
EndEvent

Float Function IndexToUpdateInterval(Int iIndex)
	If iIndex == 0
		Return 0.5
	ElseIf iIndex == 3
		Return 10.0
	ElseIf iIndex == 1
		Return 1.0
	ElseIf iIndex == 2
		Return 5.0
	EndIf
	Return 1.0
EndFunction

String Function BoolToStr(Bool abValue)
	If abValue == True
		Return "$ZazAP_Yes"
	EndIf
	Return "$ZazAP_No"
EndFunction

String Function FormToStr(Form akValue)
	If akValue != None
		Return akValue.GetName()
	EndIf
	Return "$ZazAP_None"
EndFunction

Function ShowActorStatus(Actor akActor)
	If akActor == None
		Return
	EndIf

	Int i
	AddHeaderOption(akActor.GetDisplayName())
	String header = "$ZazAP_Required"
	String[] tags = SexLab.GetRequiredTags(akActor)
	i = tags.Length
	While i > 0
		i -= 1
		If tags[i] != ""
			CreateTextOption(header, tags[i], "$ZazAP_RequiredDesc")
			header = ""
		EndIf
	EndWhile
	;AddEmptyOption()
	header = "$ZazAP_Blocked"
	tags = SexLab.GetBlockedTags(akActor)
	i = tags.Length
	While i > 0
		i -= 1
		If tags[i] != ""
			CreateTextOption(header, tags[i], "$ZazAP_BlockedDesc")
			header = ""
		EndIf
	EndWhile

	; Finally an empty line for the  next option
	AddEmptyOption()
EndFunction

Function AddActorToSelection(Actor akActor)
	If akActor == PlayerRef || akActor == None
		Return
	EndIf

	Int i = SelectSlots.Find(akActor)
	If i < 0
		i = 5
	EndIf
	While i > 2
		SelectSlots[i] = SelectSlots[i - 1]
		i -= 1
	EndWhile
	SelectSlots[2] = akActor

	sSelectSlotNames = zbfUtil.StrList(\
		"$ZazAP_None", \
		zbfUtil.GetActorName(SelectSlots[1]), \
		zbfUtil.GetActorName(SelectSlots[2]), \
		zbfUtil.GetActorName(SelectSlots[3]), \
		zbfUtil.GetActorName(SelectSlots[4]), \
		zbfUtil.GetActorName(SelectSlots[5]))
	If idxSelectActorMenu >= sSelectSlotNames.Length
		idxSelectActorMenu = 0
	EndIf

	; SexLab selection resets to player first, then the selected actor, then two empty slots
	idxSexLabActor[0] = 1
	idxSexLabActor[1] = 2
	idxSexLabActor[2] = 0
	idxSexLabActor[3] = 0
EndFunction

Function SetupWornDevicesHelper(Form[] akBindings, Armor[] akBase, Form akCurrent, String[] asBindings)
	Int i
	Int j
	
	akBindings[0] = None
	asBindings[0] = FormToStr(akBindings[0])
	i = 1
	j = 0
	While j < akBase.Length
		akBindings[i] = akBase[j]
		asBindings[i] = FormToStr(akBindings[i])
		i += 1
		j += 1
	EndWhile
	If akCurrent != None
		akBindings[i] = akCurrent
		asBindings[i] = FormToStr(akBindings[i])
		i += 1
	EndIf
	akBindings[i] = None
	asBindings[i] = "No change"
EndFunction

Function SetupWornDevicesVars()
	If !CurrentSlot.IsSlotted()
		Return
	EndIf

	String[] sTemp
	Form current

	current = CurrentSlot.GetCurrentArmBindings()
	sTemp = New String[20]
	ArmBindings = New Form[20]
	SetupWornDevicesHelper(ArmBindings, Main.ArmBindings, current, sTemp)
	sArmBindings = zbfUtil.TrimStringArray(sTemp)
	idxArmBindings = ArmBindings.Find(current)

	current = CurrentSlot.GetCurrentGag()
	sTemp = New String[20]
	Gags = New Form[20]
	SetupWornDevicesHelper(Gags, Main.Gags, current, sTemp)
	sGags = zbfUtil.TrimStringArray(sTemp)
	idxGag = Gags.Find(current)

	current = CurrentSlot.GetCurrentLegBindings()
	sTemp = New String[20]
	LegBindings = New Form[20]
	SetupWornDevicesHelper(LegBindings, Main.LegBindings, current, sTemp)
	sLegBindings = zbfUtil.TrimStringArray(sTemp)
	idxLegBindings = LegBindings.Find(current)

	current = CurrentSlot.GetCurrentBlindfold()
	sTemp = New String[20]
	Blindfolds = New Form[20]
	SetupWornDevicesHelper(Blindfolds, Main.Blindfolds, current, sTemp)
	sBlindfolds = zbfUtil.TrimStringArray(sTemp)
	idxBlindfold = Blindfolds.Find(current)
EndFunction

Function SetupAnimStringVars()
	sArmAnim = New String[5]
	sArmAnim[0] = "No anim"
	sArmAnim[1] = "Wrist"
	sArmAnim[2] = "Yoke"
	sArmAnim[3] = "Armbinder"
	sArmAnim[4] = "No anim"
	
	sArmAnimTranslate = New String[5]
	sArmAnimTranslate[0] = ""
	sArmAnimTranslate[1] = "ZapWriOffset01"
	sArmAnimTranslate[2] = "ZapYokeOffset01"
	sArmAnimTranslate[3] = "ZapArmbOffset01"
	sArmAnimTranslate[4] = "INVALID"
	idxArmAnim = sArmAnimTranslate.Find(CurrentSlot.sArmAnim)
	If idxArmAnim < 0
		sArmAnim[4] = "Current (" + CurrentSlot.sArmAnim + ")"
		sArmAnimTranslate[4] = CurrentSlot.sArmAnim
		idxArmAnim = 4
	EndIf
	
	String sPreFix = ""
	If idxArmAnim == 1
		sPreFix = "Wri"
	ElseIf idxArmAnim == 2
		sPreFix = "Yoke"
	ElseIf idxArmAnim == 3
		sPreFix = "Armb"
	EndIf

	sAnim = New String[7]
	sAnim[0] = "No anim"
	sAnim[1] = "Struggle"
	sAnim[2] = "Hogtied"
	sAnim[3] = "Knees"
	sAnim[4] = "Horny"
	sAnim[5] = "No anim"
	sAnim[6] = "No anim"
	
	sAnimTranslate = New String[7]
	sAnimTranslate[0] = ""
	sAnimTranslate[1] = "Zap" + sPreFix + "Struggle02"
	sAnimTranslate[2] = "Zap" + sPreFix + "Pose13"
	sAnimTranslate[3] = "Zap" + sPreFix + "Pose07"
	sAnimTranslate[4] = "Zap" + sPreFix + "Horny01"
	sAnimTranslate[5] = "INVALID"
	sAnimTranslate[6] = "INVALID"

	idxStillAnim = sAnimTranslate.Find(CurrentSlot.sStillAnim)
	idxForceAnim = sAnimTranslate.Find(CurrentSlot.sCurrentAnim)
	If idxStillAnim < 0
		idxStillAnim = 5
		sAnimTranslate[idxStillAnim] = CurrentSlot.sStillAnim
		sAnim[idxStillAnim] = "Current (" + CurrentSlot.sStillAnim + ")"
	EndIf
	If idxForceAnim < 0
		idxForceAnim = 6
		sAnimTranslate[idxForceAnim] = CurrentSlot.sCurrentAnim
		sAnim[idxForceAnim] = "Current (" + CurrentSlot.sCurrentAnim + ")"
	EndIf

	If sPreFix == ""
		sAnim = New String[1]
		sAnim[0] = "No anim"
		sAnimTranslate = New String[1]
		sAnimTranslate[0] = ""
		
		idxForceAnim = 0
		idxStillAnim = 0
	EndIf
EndFunction

;
; MCM event overrides
;
Function OnPageDraw(String asPage)
	Int i
	String tempPages

	tempPages = "$ZazAP_General"
	tempPages += ", $ZazAP_SexLab"
	tempPages += ", $ZazAP_PlayerCC"
	tempPages += ", $ZazAP_SlaveLeash"
	tempPages += ", $ZazAP_Slots"
	tempPages += ", $ZazAP_AnimationTest"
	If GetDebugMode()
		tempPages += ", $ZazAP_Debug"
	EndIf
	Pages = zbfUtil.ArgString(tempPages)

	sDefaultOffset = New String[4]
	sDefaultOffset[0] = "$ZazAP_OffsetDefault"
	sDefaultOffset[1] = "$ZazAP_OffsetNoStruggle"
	sDefaultOffset[2] = "$ZazAP_OffsetLegacy"
	sDefaultOffset[3] = "$ZazAP_OffsetLightStruggle"

	sGagSoundFemale = New String[5]
	sGagSoundFemale[0] = "$ZazAP_VoiceDisable"
	sGagSoundFemale[1] = "$ZazAP_VoiceCustom"
	sGagSoundFemale[2] = "$ZazAP_VoiceSoft"
	sGagSoundFemale[3] = "$ZazAP_VoiceNormal"
	sGagSoundFemale[4] = "$ZazAP_VoiceFrustrated"

	sGagSoundMale = New String[3]
	sGagSoundMale[0] = "$ZazAP_VoiceDisable"
	sGagSoundMale[1] = "$ZazAP_VoiceCustom"
	sGagSoundMale[2] = "$ZazAP_VoiceNormal"

	sUpdateInterval = New String[4]
	sUpdateInterval[0] = "$ZazAP_HalfSecond"
	sUpdateInterval[1] = "$ZazAP_OneSecond"
	sUpdateInterval[2] = "$ZazAP_FiveSecond"
	sUpdateInterval[3] = "$ZazAP_TenSecond"

	sSelectSlotNames = zbfUtil.StrList(\
		"$ZazAP_None", \
		zbfUtil.GetActorName(SelectSlots[1]), \
		zbfUtil.GetActorName(SelectSlots[2]), \
		zbfUtil.GetActorName(SelectSlots[3]), \
		zbfUtil.GetActorName(SelectSlots[4]), \
		zbfUtil.GetActorName(SelectSlots[5]))
	If idxSelectActorMenu >= sSelectSlotNames.Length
		idxSelectActorMenu = 0
	EndIf

	oidSlots = New Int[1]

	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)

	SelectedActor = zbfUtil.GetSelectedActor()
	PlayerSlot = Main.FindPlayer()

	; Link SexLab
	oidRegisterSexLab = -1

	If asPage == "" || asPage =="$ZazAP_General"
		sBlindfoldMethod = zbfUtil.ArgString("$ZazAP_AlwaysOff, $ZazAP_AlwaysOn, $ZazAP_BlindMove")

		; Left side
		AddHeaderOption("$ZazAP_General")
		;oidDisableEffects = CreateToggleOption("$ZazAP_Disable", bDisableEffects, False, "$ZazAP_DisableDesc")
		CreateTextOption("$ZazAP_Version", zbfUtil.GetVersionStr(), "")
		AddEmptyOption()
		
		AddHeaderOption("$ZazAP_KeyBindingsHeader")
		oidSelectActorKey = CreateKeymapOption("$ZazAP_SelectActor", iSelectActorKey, 49, "$ZazAP_SelectActorDesc")
		If GetDebugMode()
			i = 1
			While i < sSelectSlotNames.Length
				CreateTextOption("$ZazAP_Slot", sSelectSlotNames[i], "$ZazAP_SlotDesc")
				i += 1
			EndWhile
			oidSelectActorMenu = CreateMenuOption("$ZazAP_SelectActorMenu", idxSelectActorMenu, sSelectSlotNames, 0, "$ZazAP_SelectActorMenuDesc")
		EndIf
		AddEmptyOption()

		AddHeaderOption("$ZazAP_UpdateInterval")
		oidUpdateIntervalPlayer = CreateMenuOption("$ZazAP_UpdateIntervalPlayer", idxUpdateIntervalPlayer, sUpdateInterval, 0, "$ZazAP_UpdateIntervalPlayerDesc")
		oidUpdateIntervalNpc = CreateMenuOption("$ZazAP_UpdateIntervalNpc", idxUpdateIntervalNpc, sUpdateInterval, 2, "$ZazAP_UpdateIntervalNpcDesc")
		AddEmptyOption()

		AddHeaderOption("$ZazAP_Cleaning")
		oidRestart = CreateTextOption("$ZazAP_CleanRestart", "$ZazAP_Restart", "$ZazAP_CleanRestartDesc")
		oidDebugLogging = CreateToggleOption("$ZazAP_DebugLog", bDebugLogging, False, "$ZazAP_DebugLogDesc")
		oidDebugMode = CreateToggleOption("$ZazAP_DebugMode", GetDebugMode(), False, "$ZazAP_DebugModeDesc")
		AddEmptyOption()

		; Right side
		SetCursorPosition(1)

		AddHeaderOption("$ZazAP_Defaults")
		oidDefaultOffset = CreateMenuOption("$ZazAP_OffsetAnim", idxDefaultOffset, sDefaultOffset, 0, "$ZazAP_OffsetAnimDesc")
		oidSpeedMult = CreateSliderOption("$ZazAP_MovementSpeed", fSpeedMult, 10.0, 100.0, 70.0, 1.0, "$ZazAP_Percent_0", "$ZazAP_MovementSpeedLong")
		oidBlindfoldMethod = CreateMenuOption("$ZazAP_BlindfoldMethod", Main.idxBlindfoldMethod, sBlindfoldMethod, 2, "$ZazAP_BlindfoldMethodDesc")
		oidBlindStrength = CreateSliderOption("$ZazAP_BlindfoldAmount", Main.fBlindfoldStrength * 100.0, 0.0, 100.0, 50.0, 10.0, "$ZazAP_Percent_0", "$ZazAP_BlindfoldAmount")
		oidBlindPulseStrength = CreateSliderOption("$ZazAP_BlindfoldPulse", fBlindPulseStrength, 0.0, 100.0, 50.0, 10.0, "$ZazAP_Percent_0", "$ZazAP_BlindfoldPulseLong")
		AddEmptyOption()

		AddHeaderOption("$ZazAP_GagHeader")
		oidGagSoundFemale = CreateMenuOption("$ZazAP_GagSoundFemale", idxGagSoundFemale, sGagSoundFemale, 3, "$ZazAP_GagSoundDesc")
		oidGagSoundMale = CreateMenuOption("$ZazAP_GagSoundMale", idxGagSoundMale, sGagSoundMale, 2, "$ZazAP_GagSoundDesc")
		oidGagSoundVolume = CreateSliderOption("$ZazAP_GagSoundVolume", fGagSoundVolume, 10.0, 100.0, 100.0, 10.0, "$ZazAP_Percent_0", "$ZazAP_GagSoundVolumeLong")
		oidGagSoundRepeat = CreateToggleOption("$ZazAP_GagSoundRepeat", bGagSoundRepeat, False, "$ZazAP_GagSoundRepeatDesc")
		oidGagSoundFrequency = CreateSliderOption("$ZazAP_GagSoundFrequency", fGagSoundFrequency, 1.0, 12.0, 8.0, 1.0, "$ZazAP_Seconds_0", "$ZazAP_GagSoundFrequencyDesc")
		oidGagSoundAuto = CreateToggleOption("$ZazAP_GagSoundAuto", bGagSoundAuto, True, "$ZazAP_GagSoundAutoDesc")
		oidDialogueTest = CreateToggleOption("$ZazAP_GagDialogueTest", zbfSettingDialogueTest.GetValueInt() == 1, True, "$ZazAP_GagDialogueTestDesc")
		AddEmptyOption()
	EndIf

	If asPage == "$ZazAP_PlayerCC"
		AddHeaderOption("$ZazAP_PlayerAiHeader")
		oidForceAi = CreateToggleOption("$ZazAP_PlayerForceAi", bForceAi, False, "$ZazAP_PlayerForceAiDesc")
		CreateTextOption("$ZazAP_PlayerAiReferences", Main.GetAiRef(), "$ZazAP_PlayerAiReferencesLong")
		oidReleaseAi = CreateTextOption("$ZazAP_PlayerAiRelease", "", "$ZazAP_PlayerAiReleaseLong")
		AddEmptyOption()

		AddHeaderOption("$ZazAP_RegistrationsHeader")
		zbfPlayerControl[] Regs = Main.PlayerControlRegs
		i = 0
		While i < Regs.Length
			If Regs[i] != None
				CreateTextOption(Regs[i].ModName, "", "$ZazAP_RegistrationsDesc")
			EndIf
			i += 1
		EndWhile

		SetCursorPosition(1)
		AddHeaderOption("$ZazAP_PlayerControlHeader")
		CreateTextOption("$ZazAP_PlayerControlMovement", BoolToStr(Game.IsMovementControlsEnabled()), "")
		CreateTextOption("$ZazAP_PlayerControlActivate", BoolToStr(Game.IsActivateControlsEnabled()), "")
		CreateTextOption("$ZazAP_PlayerControlFighting", BoolToStr(Game.IsFightingControlsEnabled()), "")
		CreateTextOption("$ZazAP_PlayerControlJournal", BoolToStr(Game.IsJournalControlsEnabled()), "")
		CreateTextOption("$ZazAP_PlayerControlLooking", BoolToStr(Game.IsLookingControlsEnabled()), "")
		CreateTextOption("$ZazAP_PlayerControlSneaking", BoolToStr(Game.IsSneakingControlsEnabled()), "")
		CreateTextOption("$ZazAP_PlayerControlMenu", BoolToStr(Game.IsMenuControlsEnabled()), "")
		CreateTextOption("$ZazAP_PlayerControlFastTravel", BoolToStr(Game.IsFastTravelEnabled()), "")
		AddEmptyOption()
		oidResetControls = CreateTextOption("$ZazAP_PlayerControlRestore", "", "$ZazAP_PlayerControlRestoreLong")
		AddEmptyOption()
	EndIf
	
	If asPage == "$ZazAP_Slots"
		oidSlots = New Int[4]

		AddHeaderOption("$ZazAP_General")
		oidSlots[0] = CreateTextOption("Player", zbfUtil.GetActorName(PlayerSlot.GetActorReference()), "")
		i = 1
		While i < Main.Slots.Length
			zbfSlot tempSlot = Main.GetSlot(i)
			If tempSlot.IsSlotted()
				oidSlots[i] = CreateTextOption(i + ":", zbfUtil.GetActorName(tempSlot.GetActorReference()), "")
			EndIf
			i += 1
		EndWhile
		AddEmptyOption()

		If SelectedActor != None
			oidSelectedActorSlot = CreateTextOption("$ZazAP_SelectedSlot", zbfUtil.GetActorName(SelectedActor), "$ZazAP_SelectedSlotDesc")
			AddEmptyOption()
		EndIf

		;AddHeaderOption("Actions")
		;oidLogEvent = CreateTextOption("Log All", "", "Sends a logging action to all ZaZ actors. They will output diagnostics data to the console.")
		;oidRefreshEvent = CreateTextOption("Refresh All", "", "Sends a refresh/rescan action to all defined actors. They will refresh their currently playing effects.")
		;AddEmptyOption()

		SetCursorPosition(1)
		If idxSelectedSlot >= 0
			If idxSelectedSlot < 0
				idxSelectedSlot = 0
			EndIf
			CurrentSlot = Main.GetSlot(idxSelectedSlot)
			If !CurrentSlot.IsSlotted()
				idxSelectedSlot = 0
				CurrentSlot = Main.GetSlot(0)
			EndIf

			String slotName = zbfUtil.GetActorName(CurrentSlot.GetActorReference())
			SetupWornDevicesVars()
			SetupAnimStringVars()

			AddHeaderOption(slotName)
			If CurrentSlot != PlayerSlot
				oidRemoveSlotActor = CreateTextOption("$ZazAP_RemoveSlot", slotName, "$ZazAP_RemoveSlotDesc")
			EndIf
			AddEmptyOption()

			AddHeaderOption("$ZazAP_ItemsHeader")
			oidArmBindings = CreateMenuOption("$ZazAP_ArmBindings", idxArmBindings, sArmBindings, 0, "$ZazAP_ArmBindingsDesc")
			oidGag = CreateMenuOption("$ZazAP_Gag", idxGag, sGags, 0, "$ZazAP_GagDesc")
			oidLegBindings = CreateMenuOption("$ZazAP_LegBindings", idxLegBindings, sLegBindings, 0, "$ZazAP_LegBindingsDesc")
			oidBlindfold = CreateMenuOption("$ZazAP_Blindfold", idxBlindfold, sBlindfolds, 0, "$ZazAP_BlindfoldDesc")
			AddEmptyOption()

			AddHeaderOption("$ZazAP_AnimationHeader")
			oidArmAnim = CreateMenuOption("$ZazAP_OffsetAnim", idxArmAnim, sArmAnim, 0, "$ZazAP_OffsetAnimDesc")
			If CurrentSlot == PlayerSlot
				oidStillAnim = CreateMenuOption("$ZazAP_StillAnim", idxStillAnim, sAnim, 0, "$ZazAP_StillAnimDesc")
			EndIf
			oidForceAnim = CreateMenuOption("$ZazAP_ForceAnim", idxForceAnim, sAnim, 0, "$ZazAP_ForceAnimDesc")
			AddEmptyOption()
			oidSlotMouthIndex = CreateSliderOption("$ZazAP_MouthAnim", CurrentSlot.iMouthAnim, 0, 2, 0, 1, "{0}", "$ZazAP_MouthAnimDesc")
			oidSlotExpressionIndex = CreateSliderOption("$ZazAP_FaceAnim", CurrentSlot.iExpression, 0, 4, 0, 1, "{0}", "$ZazAP_FaceAnimDesc")
			oidSlotExpressionStrength = CreateSliderOption("$ZazAP_FaceAnimStrength", CurrentSlot.iExpressionStrength, 0, 200, 100, 10, "{0}", "$ZazAP_FaceAnimStrengthDesc")
			AddEmptyOption()

			If External.HasOverlay()
				AddHeaderOption("$ZazAP_Overlays")
				oidSlotOverlayDrool = CreateSliderOption("$ZazAP_OverlayDrool", CurrentSlot.iOverlayDrool, 0, Main.GetOverlayCount(Main.iOverlayCategoryDrool), 0, 1, "{0}", "$ZazAP_OverlayDroolDesc")
				oidSlotOverlayTears = CreateSliderOption("$ZazAP_OverlayTears", CurrentSlot.iOverlayTears, 0, Main.GetOverlayCount(Main.iOverlayCategoryTears), 0, 1, "{0}", "$ZazAP_OverlayTearsDesc")
				oidSlotOverlayDirt = CreateSliderOption("$ZazAP_OverlayDirt", CurrentSlot.iOverlayDirt, 0, Main.GetOverlayCount(Main.iOverlayCategoryDirt), 0, 1, "{0}", "$ZazAP_OverlayDirtDesc")
				oidSlotOverlayScars = CreateSliderOption("$ZazAP_OverlayScars", CurrentSlot.iOverlayScars, 0, Main.GetOverlayCount(Main.iOverlayCategoryScars), 0, 1, "{0}", "$ZazAP_OverlayScarsDesc")
				AddEmptyOption()
			EndIf

			If CurrentSlot == PlayerSlot
				AddHeaderOption("Blindfold")
				oidSlotBlindfoldMethod = CreateMenuOption("$ZazAP_SlotBlindfoldMethod", CurrentSlot.iBlindfoldMode, sBlindfoldMethod, 0, "$ZazAP_SlotBlindfoldMethodDesc")
				oidBlindStrength = CreateSliderOption("$ZazAP_BlindfoldAmount", Main.fBlindfoldStrength * 100.0, 0.0, 100.0, 50.0, 10.0, "$ZazAP_Percent_0", "$ZazAP_BlindfoldAmount")
				AddEmptyOption()
			EndIf

			If CurrentSlot == PlayerSlot
				Int iFlags = CurrentSlot.iPlayerControlMask
				bSlotDisableMovement = zbfUtil.HasFlag(iFlags, 0x001)
				bSlotDisableFight = zbfUtil.HasFlag(iFlags, 0x002)
				bSlotDisableSneak = zbfUtil.HasFlag(iFlags, 0x004)
				bSlotDisableMenu = zbfUtil.HasFlag(iFlags, 0x008)
				bSlotDisableActivate = zbfUtil.HasFlag(iFlags, 0x010)

				AddHeaderOption("$ZazAP_PlayerControlHeader")
				oidSlotDisableMovement = CreateToggleOption("$ZazAP_PlayerControlMovement", bSlotDisableMovement, False, "")
				oidSlotDisableFight = CreateToggleOption("$ZazAP_PlayerControlFighting", bSlotDisableFight, False, "")
				oidSlotDisableSneak = CreateToggleOption("$ZazAP_PlayerControlSneaking", bSlotDisableSneak, False, "")
				oidSlotDisableMenu = CreateToggleOption("$ZazAP_PlayerControlMenu", bSlotDisableMenu, False, "")
				oidSlotDisableActivate = CreateToggleOption("$ZazAP_PlayerControlActivate", bSlotDisableActivate, False, "")
				AddEmptyOption()
			EndIf

		ElseIf idxSelectedSlot == -1
			oidAddSlotActor = CreateTextOption("$ZazAP_AddSlot", zbfUtil.GetActorName(SelectedActor), "$ZazAP_AddSlotDesc")
			AddEmptyOption()
		EndIf
	EndIf

	If asPage == "$ZazAP_SlaveLeash"
		SetCursorPosition(0)
		AddHeaderOption("$ZazAP_SlaveForceHeader")
		oidSlaveAiDistance = CreateSliderOption("$ZazAP_SlaveMinDistance", SlaveLeash.fMaxLeashLength, 100.0, 1000.0, 300.0, 50.0, "{0}", "$ZazAP_SlaveMinDistanceDesc")
		oidSlaveTeleportDistance = CreateSliderOption("$ZazAP_SlaveTeleportDistance", SlaveLeash.fTeleportDistance, 500.0, 2500.0, 1000.0, 500.0, "{0}", "$ZazAP_SlaveTeleportDistanceDesc")
		oidSlaveAiCooldown = CreateSliderOption("$ZazAP_SlaveControlAiCooldown", SlaveLeash.fMinInterruptTime, 0.0, 10.0, 2.0, 1.0, "$ZazAP_Seconds_0", "$ZazAP_SlaveControlAiCooldownDesc")
		oidSlaveControlCooldown = CreateSliderOption("$ZazAP_SlaveControlCooldown", SlaveLeash.fMinAiTime, 0.0, 10.0, 4.0, 1.0, "$ZazAP_Seconds_0", "$ZazAP_SlaveControlCooldownDesc")
		AddEmptyOption()
	EndIf

	If asPage == "$ZazAP_SexLab"
		AddHeaderOption("$ZazAP_SexLabIntegration")
		oidRegisterSexLab = -1

		If External.HasSexLab()
			String sVersion = External.GetSexLabStringVersion()

			CreateTextOption("$ZazAP_SexLabVersion", sVersion, "$ZazAP_SexLabVersion")
			If External.HasSexLab()
				If SexLab.IsFullyRegistered()
					CreateTextOption("$ZazAP_SexLabAnimations", "$ZazAP_SexLabRegistered", "", aiFlags = OPTION_FLAG_DISABLED)
				Else
					oidRegisterSexLab = CreateTextOption("$ZazAP_SexLabAnimations", "$ZazAP_SexLabRegister", "$ZazAP_SexLabRegisterDesc")
				EndIf
			EndIf
			oidRebuildBaseAnimations = CreateTextOption("$ZazAP_BaseAnimation", "$ZazAP_BaseAnimationRebuild", "$ZazAP_BaseAnimationDesc")
			AddEmptyOption()
			
			AddHeaderOption("$ZazAP_AnimationHeader")
			oidOverrideSexLabAnimation = CreateToggleOption("$ZazAP_SexLabAnimationOverride", SexLab.bOverrideSexLabAnimation, True, "$ZazAP_SexLabAnimationOverrideDesc")
			AddEmptyOption()

			AddHeaderOption("$ZazAP_GagHeader")
			oidOverrideSexLabSound = CreateToggleOption("$ZazAP_SexLabGagEnable", SexLab.bOverrideSexLabSound, True, "$ZazAP_SexLabGagEnableDesc")
			oidForceSilenceSexLabSound = CreateToggleOption("$ZazAP_SexLabGagSilence", SexLab.bForceSilenceSexLabSound, False, "$ZazAP_SexLabGagSilenceDesc")
			oidOverrideSexLabExpression = CreateToggleOption("$ZazAP_SexLabGagExpression", SexLab.bOverrideSexLabExpression, True, "$ZazAP_SexLabGagExpressionDesc")
			AddEmptyOption()

			SetCursorPosition(1)
			AddHeaderOption("$ZazAP_BaseAnimationHeader")
			i = SexLab.BaseSlots.Length
			While i > 0
				i -= 1
				If SexLab.BaseSlots[i].Name != ""
					CreateTextOption(SexLab.BaseSlots[i].Name, "", "")
				EndIf
			EndWhile
			AddEmptyOption()

			If External.HasSexLab()
				AddHeaderOption("$ZazAP_SexLabAnimsHeader")
				i = SexLab.GetAnimCount()
				While i > 0
					i -= 1
					CreateTextOption(SexLab.GetAnimName(i), BoolToStr(SexLab.GetAnimRegistered(i)), "")
				EndWhile
			Else
				CreateTextOption("$ZazAP_SexLabAnimations", "$ZazAP_SexLabTooOld", "$ZazAP_SexLabTooOldDesc")
			EndIf
		Else
			CreateTextOption("$ZazAP_SexLab", "$ZazAP_SexLabNotFound", "$ZazAP_SexLabNotFoundDesc")
		EndIf
		AddEmptyOption()
	EndIf

	; Test page for running animations
	If asPage == "$ZazAP_AnimationTest"
		SexLabActors = zbfUtil.ActorList(SelectSlots[idxSexLabActor[0]], SelectSlots[idxSexLabActor[1]], SelectSlots[idxSexLabActor[2]], SelectSlots[idxSexLabActor[3]])
		Int[] currentBindTypes = SexLab.GetBindTypes(SexLabActors)

		Bool bCanSexLab = (idxAnimationTypes == 4)
		Bool bCanIdle = (idxAnimationTypes != 4) && (currentBindTypes[0] != Main.iBindUnbound)

		sAnimationTypes = New String[5]
		sAnimationTypes[0] = "$ZazAP_AnimTypePose"
		sAnimationTypes[1] = "$ZazAP_AnimTypeHorny"
		sAnimationTypes[2] = "$ZazAP_AnimTypeStruggle"
		sAnimationTypes[3] = "$ZazAP_AnimTypeOffset"
		sAnimationTypes[4] = "$ZazAP_AnimTypeSexLab"

		SetCursorPosition(0)
		sSelectedAnimationEvent = ""
		SelectedBaseEntry = None

		AddHeaderOption("$ZazAP_AnimationSelectionHeader")
		oidAnimationTypes = CreateMenuOption("$ZazAP_AnimationType", idxAnimationTypes, sAnimationTypes, 0, "$ZazAP_AnimationTypeDesc")
		If idxAnimationTypes == 3
			sAnimationIndex = New String[1]
			sAnimationIndex[0] = "$ZazAP_Regular"
		ElseIf (idxAnimationTypes == 2) || (idxAnimationTypes == 0)
			sAnimationIndex = New String[15]
			sAnimationIndex[0] = "$ZazAP_AnimDesc01"
			sAnimationIndex[1] = "$ZazAP_AnimDesc02"
			sAnimationIndex[2] = "$ZazAP_AnimDesc03"
			sAnimationIndex[3] = "$ZazAP_AnimDesc04"
			sAnimationIndex[4] = "$ZazAP_AnimDesc05"
			sAnimationIndex[5] = "$ZazAP_AnimDesc06"
			sAnimationIndex[6] = "$ZazAP_AnimDesc07"
			sAnimationIndex[7] = "$ZazAP_AnimDesc08"
			sAnimationIndex[8] = "$ZazAP_AnimDesc09"
			sAnimationIndex[9] = "$ZazAP_AnimDesc10"
			sAnimationIndex[10] = "$ZazAP_AnimDesc11"
			sAnimationIndex[11] = "$ZazAP_AnimDesc12"
			sAnimationIndex[12] = "$ZazAP_AnimDesc13"
			sAnimationIndex[13] = "$ZazAP_AnimDesc14"
			sAnimationIndex[14] = "$ZazAP_AnimDesc15"
		ElseIf idxAnimationTypes == 4
			zbfSexLabBaseEntry[] list = SexLab.GetEntries(True, True)
			SexLab.FilterEntriesAuto(list, SexLabActors, currentBindTypes)

			sAnimationIndex = New String[30]
			sAnimationId = New String[30]
			i = list.Length
			Int j = 0
			While i > 0
				i -= 1
				If list[i] != None
					sAnimationIndex[j] = list[i].Name
					sAnimationId[j] = list[i].BaseId
					j += 1
				EndIf
			EndWhile

			bCanSexLab = (j > 0)
		ElseIf idxAnimationTypes == 1
			sAnimationIndex = New String[3]
			sAnimationIndex[0] = "$ZazAP_AnimHornyDesc01"
			sAnimationIndex[1] = "$ZazAP_AnimHornyDesc02"
			sAnimationIndex[2] = "$ZazAP_AnimHornyDesc03"
		EndIf

		If (idxAnimationIndex >= sAnimationIndex.Length) || (sAnimationIndex[idxAnimationIndex] == "")
			idxAnimationIndex = 0
		EndIf
		oidAnimationIndex = CreateMenuOption("$ZazAP_AnimationIndex", idxAnimationIndex, sAnimationIndex, 0, "$ZazAP_AnimationIndexDesc")
		AddEmptyOption()

		AddHeaderOption("$ZazAP_ActorSelectionHeader")
		oidSexLabActor = New Int[4]
		oidSexLabActor[0] = CreateMenuOption("$ZazAP_SexLabSelectActor1", idxSexLabActor[0], sSelectSlotNames, 0, "$ZazAP_SexLabSelectActorDesc")
		oidSexLabActor[1] = CreateMenuOption("$ZazAP_SexLabSelectActor2", idxSexLabActor[1], sSelectSlotNames, 0, "$ZazAP_SexLabSelectActorDesc")
		oidSexLabActor[2] = CreateMenuOption("$ZazAP_SexLabSelectActor3", idxSexLabActor[2], sSelectSlotNames, 0, "$ZazAP_SexLabSelectActorDesc")
		oidSexLabActor[3] = CreateMenuOption("$ZazAP_SexLabSelectActor4", idxSexLabActor[3], sSelectSlotNames, 0, "$ZazAP_SexLabSelectActorDesc")
		AddEmptyOption()

		If bCanIdle
			sSelectedAnimationEvent = Main.GetAnimationName(currentBindTypes[0], idxAnimationTypes, idxAnimationIndex + 1)
			CreateTextOption("$ZazAP_AnimationName", sSelectedAnimationEvent, "Animation that will play.")
			AddEmptyOption()
		EndIf
		If bCanSexLab
			String selectedSexLabId = sAnimationId[idxAnimationIndex]
			SelectedBaseEntry = SexLab.GetEntryById(selectedSexLabId)

			CreateTextOption("$ZazAP_AnimationName", selectedSexLabId, "$ZazAP_AnimationNameDesc")
			CreateTextOption("$ZazAP_SexLabVanillaBase", SelectedBaseEntry.VanillaBaseName, "$ZazAP_SexLabVanillaBaseDesc")
			CreateTextOption("$ZazAP_SexLabZapBase", SelectedBaseEntry.BaseName, "$ZazAP_SexLabZapBaseDesc")
			AddEmptyOption()
		EndIf

		AddHeaderOption("$ZazAP_AnimationHelpHeader")
		oidAnimationHelp = CreateTextOption("$ZazAP_AnimationHelpButton", "", "")

		oidPlayIdleAnimation = -1
		oidPlaySexLabAnimation = -1

		; Show options for both actors
		SetCursorPosition(1)
		AddHeaderOption("$ZazAP_AnimationControlHeader")
		If bCanIdle
			oidPlayIdleAnimation = CreateTextOption("$ZazAP_AnimationRun", "", "$ZazAP_AnimationRunDesc")
			AddEmptyOption()
		EndIf
		If bCanSexLab
			oidPlaySexLabAnimation = CreateTextOption("$ZazAP_AnimationRun", "", "$ZazAP_AnimationRunDesc")
			AddEmptyOption()
		EndIf

		oidFilterActors = CreateToggleOption("$ZazAP_AnimationFilterActors", bFilterActors, True, "$ZazAP_AnimationFilterActorsDesc")
		AddEmptyOption()

		ShowActorStatus(SexLabActors[0])
		ShowActorStatus(SexLabActors[1])
		ShowActorStatus(SexLabActors[2])
		ShowActorStatus(SexLabActors[3])
	EndIf

	If asPage == "$ZazAP_Debug"
		AddHeaderOption("Quests")
		CreateTextOption(GetName(), BoolToStr(IsRunning()), "")
		CreateTextOption(Main.GetName(), BoolToStr(Main.IsRunning()), "")
		CreateTextOption(SexLab.GetName(), BoolToStr(SexLab.IsRunning()), "")
		CreateTextOption(SlaveControl.GetName(), BoolToStr(SlaveControl.IsRunning()), "")
		CreateTextOption(SlaveLeash.GetName(), BoolToStr(SlaveLeash.IsRunning()), "")
		CreateTextOption(SharedDialogue.GetName(), BoolToStr(SharedDialogue.IsRunning()), "")
		CreateTextOption(TestDialogue.GetName(), BoolToStr(TestDialogue.IsRunning()), "")
		CreateTextOption(External.GetName(), BoolToStr(External.IsRunning()), "")
		AddEmptyOption()

		AddHeaderOption("Test stuff")
		oidTestButton = CreateTextOption("Press me", "", "")
		AddEmptyOption()
	EndIf
EndFunction

Function RestartAllQuests()
	zbfPlayerControl[] zbfControls = Main.PlayerControlRegs ; Save all registrations, since these happen at startup

	TestDialogue.Stop()
	SharedDialogue.Stop()
	SlaveControl.Stop()
	SexLab.Stop()
	Main.Stop()

	SexLab.Start()
	Main.Start()
	SlaveControl.Start()
	SharedDialogue.Start()
	TestDialogue.Start()

	Main.PlayerControlRegs = zbfControls ; Restore registrations
	SlaveLeash = (SlaveControl As Quest) As zbfSlaveLeash	; Points to the same object
	SlaveActions = (SlaveControl As Quest) As zbfSlaveActions	; Points to the same object
EndFunction

Bool bDebugMode
Function SetDebugMode(Bool abMode, Bool abLogging)
	bDebugMode = abMode
	bDebugLogging = abLogging

	zbfSettingDebugMode.SetValueInt(bDebugMode As Int)

	iDebugLevel = 0
	If bDebugLogging
		iDebugLevel = 2
	EndIf

	SexLab.iDebugLevel = iDebugLevel
	Main.SetDebugLevel(iDebugLevel)
	SlaveControl.iDebugLevel = iDebugLevel
	SlaveActions.iDebugLevel = iDebugLevel
	SlaveLeash.iDebugLevel = iDebugLevel
	External.iDebugLevel = iDebugLevel
EndFunction
Bool Function GetDebugMode()
	Return bDebugMode
EndFunction

Event OnOptionMenuAccept(Int aiOption, Int aiIndex)
	If aiOption == oidAnimationTypes
		Parent.OnOptionMenuAccept(aiOption, aiIndex)
		ForcePageReset()

	ElseIf aiOption == oidAnimationIndex
		Parent.OnOptionMenuAccept(aiOption, aiIndex)
		ForcePageReset()

	Else
		Parent.OnOptionMenuAccept(aiOption, aiIndex)

	EndIf
EndEvent

Event OnOptionKeyMapChange(Int aiOption, Int aiKeyCode, String asConflictControl, String asConflictName)
	If aiOption == oidSelectActorKey
		Log("OnOptionKeyMapChange", "Unregistering for key " + iSelectActorKey)
		UnregisterForKey(iSelectActorKey)
		Log("OnOptionKeyMapChange", "Registering for key " + iSelectActorKey)
		RegisterForKey(aiKeyCode)
		Parent.OnOptionKeyMapChange(aiOption, aiKeyCode, asConflictControl, asConflictName)

	Else
		Parent.OnOptionKeyMapChange(aiOption, aiKeyCode, asConflictControl, asConflictName)

	EndIf
EndEvent

Event OnOptionSelect(Int aiOption)
	Int i = oidSlots.Length
	While i > 0
		i -= 1
		If aiOption == oidSlots[i]
			idxSelectedSlot = i
			ForcePageReset()
			Return
		EndIf
	EndWhile

	If aiOption == oidRegisterSexLab
		SetOptionFlags(oidRegisterSexLab, a_flags = OPTION_FLAG_DISABLED, a_noUpdate = False)
		SexLab.RegisterForSexLab()
		ForcePageReset()

	ElseIf aiOption == oidReleaseAi
		Main.ReleaseAllAiRefs()
		bForceAi = False
		ForcePageReset()

	ElseIf aiOption == oidResetControls
		Game.EnablePlayerControls()
		ForcePageReset()

	ElseIf aiOption == oidForceAi
		Parent.OnOptionSelect(aiOption)
		If bForceAi
			Main.RetainAi()
		Else
			Main.ReleaseAi()
		EndIf
		ForcePageReset()

	ElseIf aiOption == oidRebuildBaseAnimations
		SexLab.RebuildBaseAnimations()
		ForcePageReset()

	ElseIf aiOption == oidAnimationHelp
		ShowMessage("$ZazAP_AnimationHelp", a_withCancel = False)

	ElseIf aiOption == oidTestButton
		Bool bAccept = ShowMessage("This is a test of the message system.")
		If bAccept
			ShowMessage("Last message was accepted.", a_withCancel = False)
		Else
			ShowMessage("Failed to accept!", a_withCancel = False)
		EndIf

		If SelectedBaseEntry != None
			String out = ""
			out += "Name: " + SelectedBaseEntry.Name + "\n"

			ShowMessage(out, a_withCancel = False)
		EndIf

	ElseIf aiOption == oidPlayIdleAnimation
		Debug.SendAnimationEvent(SexLabActors[0], sSelectedAnimationEvent)
		ShowMessage("Menu will now close.\n" + sSelectedAnimationEvent + " will start playing.", a_withCancel = False)
		ForceCloseMenu()

	ElseIf aiOption == oidPlaySexLabAnimation
		ShowMessage("Menu will now close.\n" + SelectedBaseEntry.BaseId + " will start playing.", a_withCancel = False)
		zbfSexLabBaseEntry[] entries = New zbfSexLabBaseEntry[1]
		entries[0] = SelectedBaseEntry
		SexLab.StartSexEx(SexLabActors, entries, "NoBed")
		ForceCloseMenu()

	ElseIf aiOption == oidRestart
		Log("OnOptionSelect", "Restarting quests. Sending ForceUpdatEvent.")
		ForceUpdateEvent(CurrentVersion, CurrentVersion)
		ForcePageReset()
		
	ElseIf aiOption == oidSelectedActorSlot
		idxSelectedSlot = -1
		ForcePageReset()

	ElseIf aiOption == oidAddSlotActor
		zbfSlot act = Main.SlotActor(SelectedActor)
		idxSelectedSlot = Main.Slots.Find(act)
		ForcePageReset()

	ElseIf aiOption == oidRemoveSlotActor
		Main.UnSlotActor(CurrentSlot.GetActorReference())
		ForcePageReset()

	Else
		Parent.OnOptionSelect(aiOption)
	EndIf
EndEvent

Function LogTempDiag(zbfSlaveControl akSC, Actor akPlayer)
	Log("Test", "IsOwnedByMod:" + akSC.IsOwnedByMod(akPlayer) + " IsSlave:" + akSC.IsSlave(akPlayer) + " IsEscapedSlave:" + akSC.IsEscapedSlave(akPlayer))
EndFunction

Int iDebugLevel
Int iForce = -1
Int iError = 0
Int iWarning = 1
Int iInfo = 2
String sFilePrefix = "zbfConfig"
Function Log(String asMethod, String asMessage, Int aiLevel = 2, Bool abCondition = True)
	If abCondition && (aiLevel <= iDebugLevel)
		Debug.Trace(sFilePrefix + " (" + asMethod + "): " + asMessage)
	EndIf
EndFunction
