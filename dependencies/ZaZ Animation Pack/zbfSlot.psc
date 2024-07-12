Scriptname zbfSlot extends ReferenceAlias

; @section: zbfSlot
; 
; Control module for fine grained control of restraints and effects. Rather than equipping items this allows setting everything
; as explicitly as one wants. From adding and removing items on the actor (::SetBinding and ::RemoveBinding), to setting up and playing
; sequences of animations (::SetAnimSet) or changing expressions (::SetExpressionAnim), this module will cover most modding needs for
; fine grained control.
; 
; For a simple use case, just use the ::SetBinding and ::RemoveBinding functions. These will by default behave as expected.
; 
; Some noteworthy entry points. The documentation on each of these functions describe them in more detail: 
; - ::SetBindings: Equips items on the actor and applies effects.
; - ::SetPose: Forces the actor into a specific pose (hogtie/kneeling/etc).
; - ::SetFurniture: Forces the actor into a specific piece of furntiure.
; - ::AddOptions: Configures some of the default assumptions (eg. can allow activation intercept to be on by default when player is bound).
; 

zbfBondageShell zbf
zbfExternalInterface external

Actor PlayerRef
Actor ActorRef
Int iRaceType		; from zbfBondageShell::GetRaceType

; Equipment slots
Int iGagSlotMask = 			0x00004000
Int iCollarSlotMask = 		0x00008000
Int iBeltSlotMask = 		0x00080000
Int iLegsSlotMask =  		0x00800000
Int iBlindfoldSlotMask =	0x02000000
Int iArmsSlotMask =			0x20000000
Int iHoodSlotMask =			0x00000003 ; (0x00000001 + 0x00000002) = (head + hair)

String sName
String sDebugString

Form ArmBinding
Form LegBindings
Form Gag
Form Blindfold
Form Hood
Form[] AllBindings	; First few slots (up to ReservedBindings), reserved for these items, and in this order
Bool[] PreventRemoval
Int ReservedBindings = 5

Faction[] AnimatingFaction

Idle IdleForceReset
Idle IdleSoftReset

String[] sOverlays		; Current texture overlays, dirt and so on



; @section: Registration
; 
; Controls for adding/removing an actor from the system.
; The Player is always slotted, so there is no need to use these functions manually on the player.
; 
; See zbfBondageShell::FindPlayer.
; 
; code: To retrieve the player, run the following.
; zbfSlot player = zbfBondageShell.GetApi().FindPlayer()
; 

; Fills the slot with an actor.
; 
Function Register(Actor akActor)
	sDebugString = GetOwningQuest().GetName() + " [registering]"
	zbf = zbfBondageShell.GetApi()
	Log("Register on " + zbfUtil.GetActorName(akActor) + ".")

	PlayerRef = Game.GetPlayer()
	ActorRef = akActor
	ForceRefTo(akActor)
	iRaceType = zbf.GetRaceType(ActorRef)

	; Get the external interface, for overlays and stuff
	external = zbfExternalInterface.GetApi()

	sName = zbfUtil.GetActorName(akActor)
	sDebugString = GetOwningQuest().GetName() + " [" + sName + " = " + akActor + "]"
	Log("Actor was registered.")
	sDebugString = "zbfSlot [" + sName + "]"

	iEffectSlotControlMask = 0

	; Worn bindings
	ArmBinding = None
	LegBindings = None
	Gag = None
	Blindfold = None
	AllBindings = New Form[10]
	PreventRemoval = New Bool[10]
	ReservedBindings = 5

	; Idles fetched from outside
	IdleForceReset = zbf.zbfIdleForceDefault
	IdleSoftReset = zbf.zbfIdleFree

	; Arm settings
	sArmAnim = ""
	bHasOffsetAnim = False
	IdleCurrentReset = IdleSoftReset

	; Legs settings
	fMovementSpeed = 100.0
	bHasMovementSpeed = False

	; Still animation (anim forced only when not moving, only for the player)
	sStillAnim = ""
	bHasStillAnim = False
	iDirectionalMovement = 0

	; Mouth animation (expression)
	iMouthAnim = 0
	bHasMouthAnim = False

	; Expression animation (expression)
	iExpression = 0
	iExpressionStrength = 100
	bHasExpression = False

	; Forced idle settings
	sCurrentAnim = ""
	CurrentIdle = None
	bIsAnimating = False
	fAnimRepeatTime = 100000.0
	fAnimTimeToNext = fAnimRepeatTime
	SetPose(0)

	; Overlays setup
	sOverlays = New String[4]

	; Furniture
	bIsInFurniture = False
	ForcedFurniture = None
	EventFurniture = None

	; Player controls
	iPlayerControlMaskWorn = 0
	iPlayerControlMask = 0
	iPlayerControlMaskAuto = 0

	; Register for control events
	If IsPlayer()
		RegisterForControl("Activate")
		RegisterForControl("Forward")
		RegisterForControl("Back")
		RegisterForControl("Strafe Left")
		RegisterForControl("Strafe Right")
		RegisterForControl("Move")
		RegisterForControl("Look")
		RegisterForControl("Run")
		RegisterForControl("Toggle Always Run")
		RegisterForControl("Auto-Move")

		RegisterForModEvent("ZapActivateIntercept", "OnZapActivateIntercept")
		RegisterForModEvent("ZapTalkIntercept", "OnZapTalkIntercept")

		RegisterForMenu("InventoryMenu")
	EndIf

	; Listens to the same events that zbfEffectBondage does
	RegisterForModEvent("ZapRescanActors", "OnRefreshActor")
	RegisterForModEvent("ZapLogActors", "OnLogActor")

	; SexLab mod events for added actor control
	RegisterForModEvent("ZapSexLabAnimationStart", "OnSexLabAnimationStart")
	RegisterForModEvent("ZapSexLabAnimationEnd", "OnSexLabAnimationEnd")

	Log("Register: Registered actor " + sName + ".")
	GoToState("Default")
EndFunction

; Releases the slot so another actor can fill it.
; 
Function Unregister()
	Log("UnRegister: Unregister actor " + sName + ".")
	GoToState("Idle")

	UnregisterForUpdate()

	UnregisterForModEvent("ZapActivateIntercept")
	UnregisterForModEvent("ZapTalkIntercept")

	UnregisterForModEvent("ZapRescanActors")
	UnregisterForModEvent("ZapLogActors")

	UnregisterForModEvent("ZapSexLabAnimationStart")
	UnregisterForModEvent("ZapSexLabAnimationEnd")

	UnregisterForAllMenus()

	ActorRef = None
	Clear()
EndFunction

; Magic effect interaction
; 
Int Function GetEffectSlotControlMask()
	Return iEffectSlotControlMask
EndFunction

; Returns if the slot is occupied by an actor. Retrieve the actor with ::GetActorReference
; 
Bool Function IsSlotted()
	Return GetActorReference() != None
EndFunction


; @section: Basics
; 
; Functions to add/remove items. See ::SetBinding and ::RemoveBinding for the majority of the work that needs to be done.
; 
; There are specialized functions to modify the individual bindings (eg ::SetArmBinding), but these functions are 
; not necessary to use. ::SetBinding will typically cover all needs.
; 

; Generic function to add items/devices to an actor
; 
; The function will attempt to guess which kind of binding is being applied. It does this by looking at keywords attached to the item,
; zbfWornGag, zbfWornHood and so on. Several keywords can be present on a single item, in which case all applicable settings are applied from
; that particular item.
;
; If abAdd is set to true, the item is added and equipped on the actor. If not, the item is not equipped on the actor, and abPreventRemoval does nothing.  
; If abPreventRemoval is set to true, the item can not be unequipped, and attempts to get rid of the item will be intercepted.  
; If abUpdateSettings is set to true, the item will update all relevant records. Gags will set the mouth open to True, and so on.  
;
; If settings are automatically updated, all relevant settings for that item will be updated, and may possibly overwrite previously set values.
; For instance: Leg cuffs will overwrite the movement speed of the actor.
; 
; If a binding is already equipped, setting abAdd to True will remove the previously equipped item.
;
Function SetBinding(Form akBinding, Bool abAdd = True, Bool abPreventRemoval = True, Bool abUpdateSettings = True)
	Log("Set bindings " + akBinding)
	If akBinding == None
		Return
	EndIf

	Bool bIsArms = akBinding.HasKeyword(zbf.zbfWornWrist)
	Bool bIsGag = akBinding.HasKeyword(zbf.zbfWornGag)
	Bool bIsLegs = akBinding.HasKeyword(zbf.zbfWornAnkles)
	Bool bIsBlindfold = akBinding.HasKeyword(zbf.zbfWornBlindfold)
	Bool bIsHood = akBinding.HasKeyword(zbf.zbfWornHood)
	Bool bIsMisc = !(bIsArms || bIsGag || bIsLegs || bIsBlindfold)
	Form previousItem

	; make sure that it's possible to not apply slowdown unless the right keywords are present
	; overall, listening to keywords should be made a priority for this module
	; make sure that when the same change is applied twice, only the first one has any effect
	; - eg: SetOffsetAnim("test") will not trigger any changes if "test" is the offset anim

	If bIsArms
		previousItem = AllBindings[0]
		PreventRemoval[0] = abPreventRemoval
		SetArmBindings(akBinding, abUpdateSettings)
	EndIf
	If bIsGag
		previousItem = AllBindings[2]
		PreventRemoval[2] = abPreventRemoval
		SetGag(akBinding, abUpdateSettings)
	EndIf
	If bIsLegs
		previousItem = AllBindings[1]
		PreventRemoval[1] = abPreventRemoval
		SetLegBindings(akBinding, abUpdateSettings)
	EndIf
	If bIsBlindfold
		previousItem = AllBindings[3]
		PreventRemoval[3] = abPreventRemoval
		SetBlindfold(akBinding, abUpdateSettings)
	EndIf
	If bIsHood
		previousItem = AllBindings[4]
		PreventRemoval[4] = abPreventRemoval
		SetHood(akBinding, abUpdateSettings)
	EndIf
	If bIsMisc
		Int slot = AllBindings.Find(akBinding)
		If slot < 0
			slot = AllBindings.RFind(None)
			If slot >= ReservedBindings
				PreventRemoval[slot] = abPreventRemoval
				AllBindings[slot] = akBinding
			EndIf
		EndIf
	EndIf

	If abAdd
		If !ActorRef.IsEquipped(akBinding)
			If previousItem != None
				ActorRef.RemoveItem(previousItem, abSilent = True)
			EndIf
			ActorRef.AddItem(akBinding, abSilent = True)
		EndIf
		ActorRef.EquipItem(akBinding, abPreventRemoval = abPreventRemoval, abSilent = True)
	EndIf
EndFunction
Function RemoveBinding(Form akBinding, Bool abRemove = True, Bool abUpdateSettings = True)
	Log("Remove bindings " + akBinding)
	If akBinding == None
		Return
	EndIf

	Bool bIsArms = akBinding.HasKeyword(zbf.zbfWornWrist)
	Bool bIsGag = akBinding.HasKeyword(zbf.zbfWornGag)
	Bool bIsLegs = akBinding.HasKeyword(zbf.zbfWornAnkles)
	Bool bIsBlindfold = akBinding.HasKeyword(zbf.zbfWornBlindfold)
	Bool bIsHood = akBinding.HasKeyword(zbf.zbfWornHood)
	Bool bIsMisc = !(bIsArms || bIsGag || bIsLegs || bIsBlindfold)

	If bIsArms
		PreventRemoval[0] = False
		SetArmBindings(None, abUpdateSettings)
	EndIf
	If bIsGag
		PreventRemoval[2] = False
		SetGag(None, abUpdateSettings)
	EndIf
	If bIsLegs
		PreventRemoval[1] = False
		SetLegBindings(None, abUpdateSettings)
	EndIf
	If bIsBlindfold
		PreventRemoval[3] = False
		SetBlindfold(None, abUpdateSettings)
	EndIf
	If bIsHood
		PreventRemoval[4] = False
		SetHood(None, abUpdateSettings)
	EndIf
	If bIsMisc
		Int slot = AllBindings.Find(akBinding)
		If slot >= ReservedBindings
			PreventRemoval[slot] = False
			AllBindings[slot] = None
		EndIf
	EndIf

	If abRemove
		ActorRef.UnEquipItem(akBinding, abSilent = True)
		ActorRef.RemoveItem(akBinding, abSilent = True)
	EndIf
EndFunction

; Prevents removal of the specified item, if the item was equipped with ::SetBinding.
;
; Alternatively, items equipped through ::SetBinding, ::SetArmBindings, ::SetGag, ::SetLegBindings and 
; ::SetBlindfold (and similar functions) are all valid for this function.
; 
Function SetRemoval(Form akBinding, Bool abAllowed)
	Int index = AllBindings.Find(akBinding)
	If index < 0
		Return
	EndIf

	PreventRemoval[index] = abAllowed
	ActorRef.EquipItem(akBinding, abPreventRemoval = abAllowed, abSilent = True)
EndFunction


; @section: Options
; 
; These function controls the default assumptions by the mod.
; 

; Comma separated list of options to add/remove.
; 
; Adding options enables those options if not already enabled. Removing does the opposite.
; 
; NoActivate - Automatically disables activation when the player is bound. Uses ::SetActivateIntercept to do this.
; 
; DefaultHandler - Enables the default activate handler to process. Activation intercept must first be turned on.
; See "NoActivate" option and .
; 
; NoInventory - Disables inventory by intercepting the menu and moving to the magic menu instead. This allows menus
; to otherwise work correctly. This is only enabled while the player is restrained.
; 
; NoHider - Disables hiding of restraints when placed in furniture (using ::SetFurniture). Hiding is done by equipping 
; an item which visually occupies slots 53 and 59 (ankles and wrists). Items are still considered equipped by the game 
; engine, but will not appear on the actor.
; 
; A good set of normal options for immersion is "NoActivate, DefaultHandler". This turns off activation except for 
; talking (NoActivate) and doors (DefaultHandler). This allows the player to still talk and move around, but not loot
; chests or pick things up.
; 
; If one wants to, it's easy to write their own activation handler to allow specific events to trigger (cutting 
; rope bonds with sharp objects for instance).
; 
Function AddOptions(String asOptions)
	SetAllOptions(zbfUtil.ArgString(asOptions), True)
EndFunction
Function RemoveOptions(String asOptions)
	SetAllOptions(zbfUtil.ArgString(asOptions), False)
EndFunction
Bool Function HasOption(String asOption)
	If asOption == "NoActivate"
		Return bOptionNoActivate
	ElseIf asOption == "DefaultHandler"
		Return bOptionDefaultHandler
	ElseIf asOption == "NoInventory"
		Return bOptionNoInventory
	ElseIf asOption == "NoHider"
		Return bOptionNoHider
	EndIf

	Return False
EndFunction

; @section: Advanced item control
; 
; More fine grained functions here.
; 

; Set up or remove the arm bindings.
; 
; Send a None to akArmBinding to remove bindings. This function will not add or remove devices, just apply the effects of those
; devices on the slotted actor. Use ::SetBinding to also add/remove devices.
; 
; This function will also only affect arm binding effects, even if the device also would apply to, for instance, legs.
; 
; ::GetArmBindings function will only return items assigned through the ::SetArmBindings function. ::GetCurrentArmBindings will also look at all worn 
; items and figure out a "best guess" on what is currently being worn in the relevant slots (59).
; 
; If abUpdateSettings is set to False, this function will only do basic record keeping on bindings.
;
Function SetArmBindings(Form akArmBinding, Bool abUpdateSettings = True)
	Log("Set arm bindings " + akArmBinding)
	If ArmBinding == None
		fBindTime = Utility.GetCurrentGameTime()
	EndIf
	ArmBinding = akArmBinding
	AllBindings[0] = akArmBinding
	Bool hasArmBinding = (akArmBinding != None)
	iBindType = zbf.GetBindTypeFromKeywords(akArmBinding)

	If abUpdateSettings
		String offsetAnim = ""
		If hasArmBinding
			offsetAnim = zbf.GetArmAnimFromKeywords(akArmBinding)
		EndIf
		SetActivateIntercept(bOptionNoActivate && hasArmBinding)
		SetPlayerControlsAuto()

		SheatheWeapon()

		RebuildPose()
		SetOffsetAnim(offsetAnim)
	EndIf
EndFunction
Form Function GetArmBindings()
	Return ArmBinding
EndFunction
Form Function GetCurrentArmBindings()
	Return GetCurrentItemHelper(ArmBinding, iArmsSlotMask, zbf.zbfWornWrist)
EndFunction
Float fBindTime
Int iBindType

; Returns the number of days the actor has been bound
; 
; Relies on items being set through ::SetArmBindings.
; 
Float Function GetDaysBound()
	If ArmBinding == None
		Return 0
	EndIf
	Return Utility.GetCurrentGameTime() - fBindTime
EndFunction

; Set up or remove leg bindings
; 
Function SetLegBindings(Form akLegBindings, Bool abUpdateSettings = True)
	Bool hasLegBindings = (akLegBindings != None)
	LegBindings = akLegBindings
	AllBindings[1] = akLegBindings

	If abUpdateSettings
		Float fNewSpeed = 100.0
		If hasLegBindings
			fNewSpeed = zbf.GetSpeedFromKeywords(akLegBindings)
		EndIf

		SetMovementSpeed(fNewSpeed)
	EndIf
EndFunction
Form Function GetLegBindings()
	Return LegBindings
EndFunction
Form Function GetCurrentLegBindings()
	Return GetCurrentItemHelper(LegBindings, iLegsSlotMask, zbf.zbfWornAnkles)
EndFunction

; Set up or remove a gag
; 
Function SetGag(Form akGag, Bool abUpdateSettings = True)
	Bool hasGag = (akGag != None)
	Int iAnim = 0
	If Gag == None
		fGagTime = Utility.GetCurrentGameTime()
	EndIf
	Gag = akGag
	AllBindings[2] = akGag

	If abUpdateSettings
		If hasGag
			iAnim = zbf.GetMouthAnimFromKeywords(akGag)
		EndIf

		SetMouthAnim(iAnim)
	EndIf
EndFunction
Form Function GetGag()
	Return Gag
EndFunction
Form Function GetCurrentGag()
	Return GetCurrentItemHelper(Gag, iGagSlotMask, zbf.zbfWornGag)
EndFunction
Float fGagTime

; Returns the number of days the actor has been gagged
; 
; Relies on gags being set through ::SetGag.
; 
Float Function GetDaysGagged()
	If Gag == None
		Return 0
	EndIf
	Return Utility.GetCurrentGameTime() - fGagTime
EndFunction

; Set up or remove blindfold
; 
Function SetBlindfold(Form akBlindfold, Bool abUpdateSettings = True)
	Bool hasBlindfold = (akBlindfold != None)
	Blindfold = akBlindfold
	AllBindings[3] = akBlindfold

	If abUpdateSettings
		Int mode = 0
		ImageSpaceModifier modifier = None

		If (Blindfold != None) || (Hood != None)
			mode = zbf.idxBlindfoldMethod
			modifier = zbf.zbfImageSpaceBlindfold
		EndIf

		SetBlindfoldMode(mode, modifier)
	EndIf
EndFunction
Form Function GetBlindfold()
	Return Blindfold
EndFunction
Form Function GetCurrentBlindfold()
	Return GetCurrentItemHelper(Blindfold, iBlindfoldSlotMask, zbf.zbfWornBlindfold)
EndFunction

; Set up or remove hood
; 
Function SetHood(Form akHoood, Bool abUpdateSettings = True)
	Bool hasHood = (akHoood != None)
	Hood = akHoood
	AllBindings[4] = akHoood

	If abUpdateSettings
		Int mode = 0
		ImageSpaceModifier modifier = None

		If (Blindfold != None) || (Hood != None)
			mode = zbf.idxBlindfoldMethod
			modifier = zbf.zbfImageSpaceBlindfold
		EndIf

		SetBlindfoldMode(mode, modifier)
	EndIf
EndFunction
Form Function GetHood()
	Return Hood
EndFunction
Form Function GetCurrentHood()
	Return GetCurrentItemHelper(Hood, iHoodSlotMask, zbf.zbfWornHood)
EndFunction

; Retrieves the contents of the specified slot
; 
Form Function GetCurrentBinding(Int aiSlot)
	If aiSlot == 0
		Return GetCurrentArmBindings()
	ElseIf aiSlot == 1
		Return GetCurrentLegBindings()
	ElseIf aiSlot == 2
		Return GetCurrentGag()
	ElseIf aiSlot == 3
		Return GetCurrentBlindfold()
	ElseIf aiSlot == 4
		Return GetCurrentHood()
	EndIf

	Return AllBindings[aiSlot]
EndFunction

; @section: Settings
; 
; These functions all control some specific part of the actor behavior. For instance, calling ::SetOffsetAnim
; will force the actor to play that particular offset (arms bound) animation. Optionally, arguments can be provided
; to further control behavior. In this case, the animation can automatically repeat every refresh cycle.
; 
; Another example is the ::SetMouthAnim which forces the mouth open or closes the mouth.
; 
; These functions can be called after items are equipped to further change the behavior of worn items.
; 
; An example:  
; Equipping wrist shackles will internally call ::SetOffsetAnim with an offset animation fetched from zbfBondageShell::GetArmAnimFromKeywords.  
; It is possible to customize this selected animation by calling ::SetOffsetAnim.
; 

; Forces the actor to stay in a specific position.
; 
; A pose will play a set of animations, selecting a new one randomly every few seconds.
; 
; See zbfBondageShell::EnumAnimationPose for a list of available positions.
; 
; Alternatively, the pose can be configured as "struggling" using ::SetStruggle.
; 
; Poses are automatically set when an actor is forced into furniture using ::SetFurniture, which means that
; it is possible to set a furniture animation as struggling (or to make it normal again).
; 
Function SetPose(Int aiPoseIndex)
	iPose = aiPoseIndex
	RebuildPose()
EndFunction
Function SetStruggle(Bool abStruggle)
	Int poseSetIndex = 0
	If abStruggle
		poseSetIndex = 1
	EndIf

	SetAnimSet(sPoseAnims[poseSetIndex], 6.0)
EndFunction
Function RebuildPose()
	sPoseAnims = zbf.GetPoseAnimList(iPose, iBindType)
	SetStruggle(False)
EndFunction
String[] sPoseAnims
Int Property iPose Auto Hidden

; Properties and settings related to offset animation.
; 
; Offset animation control the actors arms primarily. Legs are free to move. Setting this property to an empty string
; will disable the effect.
;
String Property sArmAnim Auto Hidden
Bool bHasOffsetAnim
Bool bAutoRepeatIdle
Idle IdleCurrentReset
Function SetOffsetAnim(String asOffsetIdle, Bool abAutoRepeat = False)
	Log("SetOffsetAnim to " + asOffsetIdle)

	sArmAnim = asOffsetIdle
	bHasOffsetAnim = (asOffsetIdle != "")
	iEffectSlotControlMask = zbfUtil.SetFlag(iEffectSlotControlMask, zbf.iEffectArms + zbf.iEffectRepeat, bHasOffsetAnim)
	bAutoRepeatIdle = abAutoRepeat && bHasOffsetAnim

	ApplyAnimEffects()
EndFunction

; Properties related to the still animation.
;
; Still animation triggers when the player is not moving. Examples can include a kneeling animation, or a struggle pose.
;
String Property sStillAnim Auto Hidden
Bool bHasStillAnim
Function SetStillAnim(String asStillAnim)
	sStillAnim = asStillAnim
	bHasStillAnim = (asStillAnim != "")
	iDirectionalMovement = 0

	ApplyAnimEffects()
EndFunction

; Forced player animation/pose/idle
;
; These properties and functions force a specific pose to be assumed by the player. Will override any still animations and
; any specified offset idles. To disable this effect, specify a None idle or an empty animation event string.
; 
; The function ::SetAnimSet takes a comma separated list of animation events. A random one will automatically play. ::PlayNext
; will trigger a new random animation and reset the repeat timer.
; 
; These functions are safe to use in furniture, but of course a matching idle must be provided or results may look weird. Also,
; animation events trigger real behavior, so the player may very well leave the furniture from a game point of view (triggering
; the OnGetUp event).
; 
; Use ::SetFurniture to make sure that the actor appears to stay put even when sending events and animations. Use ::PinActor to
; make sure that the actor does not move around while playing idles. This function (and it's companion ::UnPinActor) are safe to 
; call in furniture, so it is probably best to always pin the actor before playing animations if movement is not desired.
;
String Property sCurrentAnim Auto Hidden
Idle Property CurrentIdle Auto Hidden
Bool Property bIsAnimating Auto Hidden
Function SetAnim(String asAnim)
	If asAnim != sCurrentAnim
		sCurrentAnim = asAnim
		CurrentIdle = None
		bIsAnimating = (asAnim != "")

		ApplyAnimEffects()
	EndIf
EndFunction
Function SetIdle(Idle akIdle)
	If akIdle != CurrentIdle
		sCurrentAnim = ""
		CurrentIdle = akIdle
		bIsAnimating = (CurrentIdle != None)

		ApplyAnimEffects()
	EndIf
EndFunction
Function StopIdleAnim()
	bIsAnimating = False
	fAnimRepeatTime = 100000.0
	fAnimTimeToNext = fAnimRepeatTime

	If (sCurrentAnim != "") || (CurrentIdle != None)
		sCurrentAnim = ""
		CurrentIdle = None
		ApplyAnimEffects()
	EndIf
EndFunction

; Sets up automatic animation switching
; 
; Animation sequences are played in a random order. A new animation can be picked by calling ::PlayNext, or a repeat time
; can be set which will trigger automatic switching.
; 
; Setting an empty animation set will clear animations from this slot.
; 
; To stop automatic animation selection, call ::SetAnimSet with an empty set or ::StopIdleAnim.
; 
; Example:  
; slot.SetAnimSet("ZapWriPose01", "ZapWriStruggle01", 3.0) ; Will randomly pick between ZapWriPose01 and ZapWriStruggle01 animations every 3s.
; 
Function SetAnimSet(String asAnims, Float afRepeatTime = 0.0)
	AnimSet = zbfUtil.ArgString(asAnims)
	Bool hasAnimSet = (AnimSet.Length > 0)
	If !hasAnimSet
		StopIdleAnim()
		Return
	EndIf

	fAnimRepeatTime = 100000.0
	If afRepeatTime > 0.0
		fAnimRepeatTime = afRepeatTime
	EndIf
	PlayNext()
EndFunction
Function PlayNext()
	fAnimTimeToNext = fAnimRepeatTime
	If AnimSet.Length > 0
		Int index = Utility.RandomInt(0, AnimSet.Length - 1)
		SetAnim(AnimSet[index])
	EndIf
EndFunction
String[] AnimSet
Float fAnimRepeatTime
Float fAnimTimeToNext

; Movement speed properties.
;
; These properties control the character movement speed. Setting the movement speed value to less than zero will disable the effect.
;
Function SetMovementSpeed(Float afSpeed)
	fMovementSpeed = afSpeed
	bHasMovementSpeed = (afSpeed >= 0)
	If !bHasMovementSpeed
		fMovementSpeed = 100.0
	EndIf
	iEffectSlotControlMask = zbfUtil.SetFlag(iEffectSlotControlMask, zbf.iEffectLegs, bHasMovementSpeed)

	ApplyMovementSpeed()
EndFunction
Float fMovementSpeed
Bool bHasMovementSpeed

; Mouth animation properties.
;
; Currently controls mouth open/close settings. Available animations are defined in
; zbfBondageShell::EnumMouthAnimType.
; 
; Setting this property to 0 or less will disable the effect.
;
Int Property iMouthAnim Auto Hidden
Bool bHasMouthAnim
Function SetMouthAnim(Int aiMouth)
	If aiMouth != iMouthAnim
		SetMouthExpressionAnim(iExpression, aiMouth, iExpressionStrength)
	EndIf
EndFunction

; Expression animation properties
; 
; Controls the expression and strength of the emotion.
; 0 - Neutral
; 1 - Fear
; 2 - Happy
; 3 - Angry
; 4 - Shy
; 
; aiStrength can take any value, but 100 is the default "full" effect. Specifying a value larger than 100
; may look weird. Specifying a value lower than zero is likely to not have any impact at all.
; 
Int Property iExpression Auto Hidden
Int Property iExpressionStrength Auto Hidden
Bool bHasExpression
Function SetExpressionAnim(Int aiExpression, Int aiStrength = 100)
	If (aiStrength != iExpressionStrength) || (aiExpression != iExpression)
		SetMouthExpressionAnim(aiExpression, iMouthAnim, aiStrength)
	EndIf
EndFunction

; Sets both mouth open/close and facial expression
; 
Function SetMouthExpressionAnim(Int aiExpression, Int aiMouth, Int aiStrength)
	iExpression = aiExpression
	iExpressionStrength = aiStrength
	bHasExpression = (aiExpression > 0)
	iEffectSlotControlMask = zbfUtil.SetFlag(iEffectSlotControlMask, zbf.iEffectFace, bHasExpression)

	iMouthAnim = aiMouth
	bHasMouthAnim = (aiMouth > 0)
	iEffectSlotControlMask = zbfUtil.SetFlag(iEffectSlotControlMask, zbf.iEffectMouth, bHasMouthAnim)

	ApplyFaceAnim()
EndFunction

; Player controls
;
; Disables some specified player controls completely. It is equally viable to use any zbfPlayerControl object instead.
;
; ::SetDisabledControls will use a nicer to use function for setting each control individually.  
; ::SetPlayerControlMask will use a raw control mask, for those cases where passing a single int is easier.
; 
; Actual player controls are merged with that of worn effects on the player.
; 
; Usually, disabling player control directly is not the easiest way to control what can be done.
; 
; Example:  
; - Use ::PinActor to keep the actor locked to its current location.  
; - Use ::SetActivateIntercept to prevent the player from activating things.  
; - Default on most bindings. Use ::SetDisabledControls if not already present.  
; 
; 
Int Property iPlayerControlMask Auto Hidden
Int iPlayerControlMaskWorn
Function SetDisabledControls(Bool abMovement = False, Bool abFighting = False, Bool abSneaking = False, Bool abMenu = False, Bool abActivate = False)
	If IsPlayer()
		iPlayerControlMask = BuildPlayerControlMask(abMovement, abFighting, abSneaking, abMenu, abActivate)
		ApplyPlayerControls()
	EndIf
EndFunction
Function SetPlayerControlMask(Int aiPlayerControlMask)
	If IsPlayer()
		iPlayerControlMask = aiPlayerControlMask
		ApplyPlayerControls()
	EndIf
EndFunction

; Adjusts player controls based on configured items. Will override any manual changes.
; 
Function SetPlayerControlsAuto()
	Log("SetPlayerControlsAuto")
	If IsPlayer()
		Bool movement = (bIsPinned || bIsInFurniture)

		; iPlayerControlMaskAuto = BuildPlayerControlMask(abMovement = movement, abFighting = (ArmBinding != None), abActivate = bIsInFurniture)
		iPlayerControlMaskAuto = BuildPlayerControlMask(abMovement = movement, abFighting = (ArmBinding != None))
		ApplyPlayerControls()
	EndIf
EndFunction
Int iPlayerControlMaskAuto


; Texture Overlays
; 
; Applies a texture overlay on the actor. Texture overlays are effects like
; tears, drool, scars and so on.
; 
Int Property iOverlayTears Auto Hidden
Int Property iOverlayDrool Auto Hidden
Int Property iOverlayDirt Auto Hidden
Int Property iOverlayScars Auto Hidden
Bool bNeedsOverlayUpdate
Function SetTearsOverlay(Int aiIndex)
	bNeedsOverlayUpdate = bNeedsOverlayUpdate || (iOverlayTears != aiIndex)
	iOverlayTears = aiIndex
EndFunction
Function SetDroolOverlay(Int aiIndex)
	bNeedsOverlayUpdate = bNeedsOverlayUpdate || (iOverlayDrool != aiIndex)
	iOverlayDrool = aiIndex
EndFunction
Function SetDirtOverlay(Int aiIndex)
	bNeedsOverlayUpdate = bNeedsOverlayUpdate || (iOverlayDirt != aiIndex)
	iOverlayDirt = aiIndex
EndFunction
Function SetScarsOverlay(Int aiIndex)
	bNeedsOverlayUpdate = bNeedsOverlayUpdate || (iOverlayScars != aiIndex)
	iOverlayScars = aiIndex
EndFunction

; Sets the current blindfold effect
; 
; aiMode can be set to the following settings.
; -1 - Use default value from MCM config.
; 0 - Off
; 1 - On
; 2 - On when moving
; 
Int Property iBlindfoldMode Auto Hidden
ImageSpaceModifier Property BlindfoldModifier Auto Hidden
Float fBlindfoldStrength
Bool bHasBlindEffect
Function SetBlindfoldMode(Int aiMode, ImageSpaceModifier akModifier = None)
	Log("Actor is not the player. Can't set blindfold effect on non-player actors.", aiLevel = iWarning, abCondition = !IsPlayer())
	If IsPlayer()
		iBlindfoldMode = aiMode
		If aiMode == -1
			iBlindfoldMode = zbf.idxBlindfoldMethod
		EndIf

		BlindfoldModifier = zbf.zbfImageSpaceBlindfold
		If akModifier != None
			BlindfoldModifier = akModifier
		EndIf

		fBlindfoldStrength = zbf.fBlindfoldStrength
		If fBlindfoldStrength < 0.0
			fBlindfoldStrength = 0.0
		ElseIf fBlindfoldStrength > 1.0
			fBlindfoldStrength = 1.0
		EndIf

		bHasBlindEffect = (iBlindfoldMode != 0) && (fBlindfoldStrength > 0.0)
		ApplyImageSpaceModifier()
	EndIf
EndFunction

; Makes sure the actors weapons are sheathed.
; 
; Call this function before forcing animations on the actor, or otherwise make sure that weapons are sheathed. Camera may bug
; out if not used before playing animations.
; 
Function SheatheWeapon()
	If ActorRef.IsWeaponDrawn()
		Int iSafe = 0
		ActorRef.SheatheWeapon()
		While ActorRef.IsWeaponDrawn() && iSafe < 50
			Utility.Wait(0.1)
			iSafe += 1
		EndWhile
	EndIf
EndFunction

; Force into furniture.
; 
; This function forces the actor into the specified furniture. If the actor is not in the furniture the actor is
; moved into position first. In addition, movement controls are disabled (if called on the player) and the activation
; controls are enabled only for living actors (allowing only talking).
; 
; ::GetFurniture returns the currently occupied furniture. This returns any set furniture or if not furniture is set, 
; the function returns any furniture the actor has occupied as determined by the ::OnSit event.
; 
; It's possible for an actor to be moved out of furniture from a game engine point of view but still remain 
; in furniture according to these functions. This is intended since playing different animations need to be supported, 
; and those animations could break the game furniture mechanics.  
; This also means that leaving furniture can not be done through game mechanics (jumping, activating the furniture), 
; and if ::SetFurniture has been called furniture must be left by calling ::SetFurniture with None as parameter.
; 
; Internally, ::SetFurniture uses the ::SetPose function to make sure that animation sets are correctly configured. This
; means that it's possible to toggle struggling on/off in furniture if this function was used to set it up.
; 
Function SetFurniture(ObjectReference akFurniture)
	Log("SetFurniture: " + akFurniture)

	Bool wasInFurniture = bIsInFurniture
	bIsInFurniture = (akFurniture != None)

	ForcedFurniture = akFurniture
	If bIsInFurniture && (ForcedFurniture != EventFurniture)
		ForcedFurniture.Activate(ActorRef)
	EndIf

	Int furnTypeIndex = zbf.GetFurnitureType(akFurniture)
	Log("Furniture identified as " + furnTypeIndex)

	If !bOptionNoHider
		Armor hider = zbf.zbfRestraintHider
		If bIsInFurniture
			ActorRef.AddItem(hider, abSilent = True)
			ActorRef.EquipItem(hider, abSilent = True)
		Else
			ActorRef.UnEquipItem(hider, abSilent = True)
			ActorRef.RemoveItem(hider, abSilent = True)
		EndIf
	EndIf

	SetPose(furnTypeIndex + zbf.iPoseFurnitureBase)
	SetPlayerControlsAuto()
	SetActivateFilter(bOptionNoActivate && bIsInFurniture)
	ActorRef.SetVehicle(akFurniture)

	If wasInFurniture && !bIsInFurniture
		ActorRef.MoveTo(ActorRef)
		IdleCurrentReset = IdleForceReset
		ApplyAnimEffects()
	EndIf
EndFunction
ObjectReference Function GetFurniture()
	If ForcedFurniture != None
		Return ForcedFurniture
	EndIf
	Return EventFurniture
EndFunction
Bool bIsInFurniture
ObjectReference ForcedFurniture

; Pin actor
;
; Pinning an actor forces it to stay put when acted on by outside events and to move around
; when triggered by controls or ai.
; 
; Pinning does not turn off ai routines for npcs, and they may still attempt to
; move around, but be unable to do so. Actors with movement packages will generally be
; unable to complete those packages, even for trivial movement such as moving to self.
; 
; Usually one does not want to pin actors and provide movement packages, but sometimes 
; "stay" packages could include travel commands which will then not complete correctly.
; 
; Pinning interacts correctly with furniture unless the abForce parameter is set.
; 
Function PinActor()
	If !bIsInFurniture
		bIsPinned = True

		zbf.PinActor(ActorRef)
		SetPlayerControlsAuto()
	EndIf
EndFunction
Function UnPinActor(Bool abForce = False)
	If !bIsInFurniture && (bIsPinned || abForce)
		bIsPinned = False

		zbf.UnPinActor(ActorRef)
		SetPlayerControlsAuto()
	EndIf
EndFunction
Bool bIsPinned

; @section: Under construction
; 
; All functions in this section are under construction and not yet ready to use.
; 

Bool bIsMoving

Function SetActivateIntercept(Bool abEnable = True)
	Log("SetActivateIntercept to " + abEnable)
	zbf.SetBoundPerk(ActorRef, abEnable)
EndFunction
Bool Function GetActivateIntercept()
	Return ActorRef.HasPerk(zbf.zbfPerkBound)
EndFunction

Function SetTalkIntercept(Bool abEnable = True)
	Log("SetTalkIntercept to " + abEnable)
	zbf.SetGaggedPerk(ActorRef, abEnable)
EndFunction
Bool Function GetTalkIntercept()
	Return ActorRef.HasPerk(zbf.zbfPerkGagged)
EndFunction

Function SetActivateFilter(Bool abFilter = True)
	Log("SetActivateFilter to " + abFilter)
	zbf.SetLimitedActivation(ActorRef, abFilter)
EndFunction
Bool Function GetActivateFilter()
	Return ActorRef.HasPerk(zbf.zbfPerkLimitActivation)
EndFunction

Event OnZapActivateIntercept(Form akSource, Form akTarget)
	; Example implementation:
	; 
	; Actor source = akSource As Actor
	; ObjectReference target = akTarget As ObjectReference
	; Debug.Notification(zbfUtil.GetActorName(source) + " tried to activate " + zbfUtil.GetObjectName(target) + ".")
	; 

	; This is the handler used by the zbfSlot file (if enabled).
	If bOptionDefaultHandler
		DefaultActivateHandler(akSource As Actor, akTarget As ObjectReference)
	EndIf
EndEvent

Event OnZapTalkIntercept(Form akSource, Form akTarget)
	; Example implementation:
	; 
	; Actor source = akSource As Actor
	; Actor target = akTarget As Actor
	; Debug.Notification(zbfUtil.GetActorName(source) + " tried to talk to " + zbfUtil.GetActorName(target) + ".")
EndEvent

Function DefaultActivateHandler(Actor akSource, ObjectReference akTarget)
	Form base = akTarget.GetBaseObject()
	Int type = base.GetType()

	If iPose != 0
		Debug.Notification("You can't do that from the position you're in.")
		Return
	EndIf

	If type == 29	; Door
		If !akTarget.IsLocked()
			akTarget.Activate(akSource)
			Return
		EndIf
	EndIf

	Debug.Notification("You can't do that with your hands bound.")
EndFunction

Event OnMenuOpen(String MenuName)
	If MenuName == "InventoryMenu"
		If bOptionNoInventory && (bIsInFurniture || (ArmBinding != None))
			Log("Inventory menu was intercepted.")
			UI.Invoke("InventoryMenu", "_root.Menu_mc.openMagicMenu")
		EndIf
	EndIf
EndEvent

Function SetAllOptions(String[] asOptions, Bool abValue)
	Int i = asOptions.Length
	While i > 0
		i -= 1
		String option = asOptions[i]

		If option == "NoActivate"
			bOptionNoActivate = abValue
		ElseIf option == "DefaultHandler"
			bOptionDefaultHandler = abValue
		ElseIf option == "NoInventory"
			bOptionNoInventory = abValue
		ElseIf option == "NoHider"
			bOptionNoHider = abValue
		EndIf
	EndWhile
EndFunction
Bool bOptionNoActivate		; Turns on activate intercept when bound
Bool bOptionDefaultHandler	; Enables a default handler to process Activate intercept events
Bool bOptionNoInventory		; Removes menu/inventory controls when player is bound.
Bool bOptionNoHider			; Hides restraints on the actor when forced into furniture with ::SetFurniture.

; @section: Effects
; 
; These functions all apply one or many effects on the slotted actor (::ApplyFaceAnim updates the expression, etc). They will overwrite current
; settings (like expected) even with the vanilla state if nothing has been configured (::ApplyAnimEffects will reset the actor to default idle
; animation if no animation has been specified, and so on).
;
; This behavior is by design, and these functions should typically not be called directly. Instead use the various Set functions to force 
; a certain behavior. This will then call the respective Apply function, and do other house keeping that is needed. (For instance, instead
; of calling ::ApplyAnimEffects, use ::SetOffsetAnim to control the offset animation.)
; 
; Example:  
; ::ApplyFaceAnim will play the mouth (open/close) and expression animations, but if no animation is specified the mouth instead closes, and expression reverts to default.  
; ::ApplyAnimEffects will determine the configured animation to play and then play it. If no animation is configured, it will reset to the default idle.  
;

Function ApplyMovementSpeed()
	ActorRef.SetAv("SpeedMult", fMovementSpeed)
	ActorRef.ModAv("CarryWeight", -0.02)
	ActorRef.ModAv("CarryWeight", 0.02)
EndFunction

Function ApplyFaceAnim()
	bNeedsFaceUpdate = IsInMenu()	; Then effects needs to reapply again afterwards, workarounds for animations breaking

	ActorRef.SetExpressionOverride(16, 1)
	ActorRef.ClearExpressionOverride()
	MfgConsoleFunc.ResetPhonemeModifier(ActorRef)

	zbf.SetFaceAnimation(ActorRef, iExpression, iExpressionStrength, iRaceType)
	zbf.SetMouthAnimation(ActorRef, iMouthAnim, iRaceType)
EndFunction
Bool bNeedsFaceUpdate

Function ApplyPlayerControls()
	Log("ApplyPlayerControls called on a non-player.", aiLevel = iError, abCondition = (!IsPlayer()))
	If IsPlayer()
		Int iRawMask = Math.LogicalOr(iPlayerControlMaskWorn, iPlayerControlMask)
		iRawMask = Math.LogicalOr(iRawMask, iPlayerControlMaskAuto)

		If zbfUtil.HasFlag(iRawMask, 0x001)
			SetIsMoving(False)
		EndIf

		Log("zbf.PlayerControl.SetRawControlMask(" + iRawMask + ")")
		zbf.PlayerControlsFromSlot = iRawMask
		zbf.ReapplyPlayerControls()
	EndIf
EndFunction

Function SendAnimationEvent(Actor akActor, String asEvent)
	Log("Sending animation event: " + asEvent)
	Debug.SendAnimationEvent(akActor, asEvent)
EndFunction

Function ApplyAnimEffects()
	If bIsAnimating || bIsInFurniture
		Log("Internal error, sCurrentAnim and CurrentIdle set at the same time.", aiLevel = iError, abCondition = (sCurrentAnim != "" && CurrentIdle != None))
		If sCurrentAnim != ""
			SendAnimationEvent(ActorRef, sCurrentAnim)
		EndIf
		If CurrentIdle != None
			ActorRef.PlayIdle(CurrentIdle)
		EndIf
		IdleCurrentReset = IdleForceReset

		Return
	EndIf

	If bHasStillAnim && !bIsMoving
		Log("Still animation configured, but set to empty.", aiLevel = iError, abCondition = (sStillAnim == ""))
		SendAnimationEvent(ActorRef, sStillAnim)
		IdleCurrentReset = IdleForceReset

		Return
	EndIf

	If bHasOffsetAnim
		SendAnimationEvent(ActorRef, sArmAnim)
		IdleCurrentReset = IdleSoftReset

		Return
	EndIf

	Log("Sending animation idle. Forced = " + (IdleCurrentReset == IdleForceReset))
	ActorRef.PlayIdle(IdleCurrentReset)
	IdleCurrentReset = IdleSoftReset
EndFunction

Function ApplySingleTextureOverlay(Int aiCategory, Int aiNewIndex)
	String previous = sOverlays[aiCategory]
	String name = zbf.GetOverlayName(aiCategory, aiNewIndex)
	String section = zbf.GetOverlaySection(aiCategory)

	sOverlays[aiCategory] = name
	zbf.SetOverlayGeneric(ActorRef, name, section, previous)
EndFunction

Function ApplyTextureOverlays()
	ApplySingleTextureOverlay(zbf.iOverlayCategoryTears, iOverlayTears)
	ApplySingleTextureOverlay(zbf.iOverlayCategoryDrool, iOverlayDrool)
	ApplySingleTextureOverlay(zbf.iOverlayCategoryDirt, iOverlayDirt)
	ApplySingleTextureOverlay(zbf.iOverlayCategoryScars, iOverlayScars)
	external.SynchronizeOverlay(ActorRef)
EndFunction

Function ApplyImageSpaceModifier()
	ImageSpaceModifier last = LastImageSpaceModifier
	Float correctedStrength = Math.Sqrt(fBlindfoldStrength)

	ImageSpaceModifier current = None
	If bHasBlindEffect && (bIsMoving || iBlindfoldMode == 1)
		current = BlindfoldModifier
	EndIf
	LastImageSpaceModifier = current

	If last != None && current != None
		last.PopTo(current, correctedStrength)
	ElseIf current != None
		current.Apply(correctedStrength)
	ElseIf last != None
		last.Remove()
	EndIf
EndFunction
ImageSpaceModifier LastImageSpaceModifier

; Applies all possible effects on the actor.
; 
; If the abForce flag is set, values that are not specified by this module are also overwritten.
; If not, zbfSlot attempts to be conservative. (Probably desired behavior.)
; 
Function ApplyAllEffects(Bool abForce = False)
	Log("ApplyAllEffects running.")
	If zbfUtil.IsValidActor(ActorRef)
		If bIsInFurniture
			SetFurniture(ForcedFurniture)
		ElseIf bIsPinned
			PinActor()
		Else
			ActorRef.SetVehicle(None)
			ActorRef.SetDontMove(False)
		EndIf

		If abForce || bHasOffsetAnim || bHasStillAnim || bIsAnimating
			ApplyAnimEffects()
		EndIf

		If abForce || bHasMovementSpeed
			ApplyMovementSpeed()
		EndIf
		
		If abForce || bHasMouthAnim || bHasExpression
			ApplyFaceAnim()
		EndIf

		ApplyTextureOverlays()
		ApplyPlayerControls() ; Needs to come after texture overlays, because SlaveTats messes with player controls
		ApplyImageSpaceModifier()
	EndIf
EndFunction

; Refreshes current effects on the actor.
; 
Function ApplyEffects(Actor akTarget)
	Log("ApplyEffects: No effect in the idle state.", aiLevel = iWarning)
EndFunction


; @section: Support
; 
; Helpers to do various house keeping. Used internally.
; 

Bool Function IsDirectionalMovement(String asControl)
	Return (asControl == "Forward" || asControl == "Back" || asControl == "Strafe Left" || asControl == "Strafe Right")
EndFunction

Bool Function IsInMenu()
	Return Utility.IsInMenuMode() || UI.IsMenuOpen("Console") || UI.IsMenuOpen("Loading Menu") || UI.IsMenuOpen("InventoryMenu")
EndFunction

Bool Function IsSameBaseItem(Form akBase, Form akOtherBase, ObjectReference akReference = None)
	If akReference != None
		Log("IsSameBaseItem is comparing " + akReference + " as " + akReference.GetBaseObject() + " vs " + akBase)
		Return akReference.GetBaseObject() == akBase
	EndIf
	Log("IsSameBaseItem is comparing " + akOtherBase + " vs " + akBase)
	Return akBase == akOtherBase
EndFunction

Bool Function IsPlayer()
	Return ActorRef == PlayerRef
EndFunction

; Helper function to restore an item to the akActor, both in terms of force equipping it, and also restore it if it's dropped.
; 
Function RestoreItemHelper(Actor akActor, Int aiItemCount, Form akBaseItem, ObjectReference akItemReference, ObjectReference akDestContainer)
	If akDestContainer != None
		If akItemReference != None
			akDestContainer.RemoveItem(akItemReference, aiItemCount, abSilent = True, akOtherContainer = akActor)
			akActor.EquipItem(akItemReference, abPreventRemoval = True, abSilent = True)
		Else
			akDestContainer.RemoveItem(akBaseItem, aiItemCount, abSilent = True, akOtherContainer = akActor)
			akActor.EquipItem(akBaseItem, abPreventRemoval = True, abSilent = True)
		EndIf
	Else
		If akItemReference != None
			akItemReference.Disable()
			akItemReference.Delete()
		EndIf
		akActor.AddItem(akBaseItem, aiItemCount, abSilent = True)
		akActor.EquipItem(akBaseItem, abPreventRemoval = True, abSilent = True)
	EndIf
EndFunction

; Builds a player control mask
; 
; All parameters disable functionality when set to True. This means that setting all parameters to False will enable functionality from
; this module's point of view. Other modules may still for other reasons have disabled functionality.
; 
; This is a support function and has no actual side effects. It only returns a mask to be used elsewhere.
; 
Int Function BuildPlayerControlMask(Bool abMovement = False, Bool abFighting = False, Bool abSneaking = False, Bool abMenu = False, Bool abActivate = False)
	Int iMask = 0
	iMask = zbfUtil.SetFlag(iMask, 0x001, abMovement)
	iMask = zbfUtil.SetFlag(iMask, 0x002, abFighting)
	iMask = zbfUtil.SetFlag(iMask, 0x004, abSneaking)
	iMask = zbfUtil.SetFlag(iMask, 0x008, abMenu)
	iMask = zbfUtil.SetFlag(iMask, 0x010, abActivate)

	Return iMask
EndFunction

; Builds the player control mask of special controls.
; 
; Similar to other player control masks, this can be ORed together with any other kind of player control mask to arrive at a final set 
; of disabled controls. This includes the output from ::BuildPlayerControlMask.
; 
; All parameters disable functionality when set to True. This means that setting all parameters to False will enable functionality from
; this module's point of view. Other modules may still for other reasons have disabled functionality.
; 
; This is a support function and has no actual side effects. It only returns a mask to be used elsewhere.
; 
Int Function BuildSpecialPlayerControlMask(Bool abSaving = False, Bool abWaiting = False, Bool abShowMessage = False, Bool abFastTravel = False)
	Int iMask = 0
	iMask = zbfUtil.SetFlag(iMask, 0x020, abSaving)
	iMask = zbfUtil.SetFlag(iMask, 0x040, abWaiting)
	iMask = zbfUtil.SetFlag(iMask, 0x080, abShowMessage)
	iMask = zbfUtil.SetFlag(iMask, 0x100, abFastTravel)

	Return iMask
EndFunction

Function LogItemOnActor(String asItemName, Form akItem)
	If akItem != None
		Log("LogItemOnActor: " + asItemName + ": " + akItem.GetName() + " (" + akItem.GetFormID() + ")")
	EndIf
EndFunction


; @section: Events
;  
; This module listens to the events and sends some of the events (slotting, unslotting) outlined in zbfEffectBondage::Events.
; Look at functions, zbfEffectBondage::SendRescanEvent and zbfEffectBondage::SendLogEvent.
;

; Asks the actor to output a logging message.
Event OnLogActor(Form akActor)
	If ActorRef == akActor
		MiscUtil.PrintConsole(sDebugString + ": slotted")
		Log("State: " + GetState())
		Log("ArmBinding: " + GetCurrentArmBindings())
		Log("Gag: " + GetCurrentGag())
	EndIf
EndEvent

; Refreshes all effects on the actor.
Event OnRefreshActor(Form akActor)
	If ActorRef == akActor
		ApplyAllEffects()
	EndIf
EndEvent

Event OnObjectEquipped(Form akBaseItem, ObjectReference akReference)
EndEvent

Event OnObjectUnequipped(Form akBaseItem, ObjectReference akReference)
EndEvent

Event OnItemRemoved(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	If !IsPlayer()
		Return
	EndIf

	GrabMutex()
	Log("OnItemRemoved item " + akBaseItem + " as reference " + akItemReference + " (" + aiItemCount + ") were lost.")

	;Form item = GetItemHelper(akBaseItem, akItemReference)
	Int index = AllBindings.Find(akBaseItem)
	Form item = akBaseItem
	If index < 0 && akItemReference != None
		index = AllBindings.Find(akItemReference)
		item = akItemReference
	EndIf

	If index >= 0 && PreventRemoval[index] && !ActorRef.IsEquipped(item)
		; Restore and re-equip the item on the player
		RestoreItemHelper(ActorRef, aiItemCount, akBaseItem, akItemReference, akDestContainer)
	EndIf

	ReleaseMutex()
EndEvent

ObjectReference EventFurniture	; Furniture as determined from ::OnSit and ::OnGetUp
Event OnSit(ObjectReference akFurniture)
	Log("OnSit furniture " + zbfUtil.GetObjectName(akFurniture) + ".")
	EventFurniture = akFurniture
EndEvent
Event OnGetUp(ObjectReference akFurniture)
	Log("OnGetUp furniture " + zbfUtil.GetObjectName(akFurniture) + ".")
	EventFurniture = None

	IdleCurrentReset = IdleForceReset
	ApplyAnimEffects()
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)
	Log("OnHit")

	;ModifyMood(afDiffPain = 0.015, akSource = akAggressor As Actor)
EndEvent

Bool bIsAutomove
Int iDirectionalMovement
Event OnControlDown(String asControl)
	Log("OnControlDown: Should not happen unless on the player.", aiLevel = iError, abCondition = !IsPlayer())
	GrabMutex()

	If IsDirectionalMovement(asControl)
		iDirectionalMovement += 1
		bIsAutomove = False

	ElseIf asControl == "Auto-Move" && iDirectionalMovement < 1
		bIsAutomove = !bIsAutomove

	EndIf

	SetIsMoving((iDirectionalMovement > 0) || bIsAutomove)

	ReleaseMutex()
EndEvent

Event OnControlUp(String asControl, Float afHoldTime)
	Log("OnControlUp: Should not happen unless on the player.", aiLevel = iError, abCondition = !IsPlayer())
	GrabMutex()

	If IsDirectionalMovement(asControl)
		iDirectionalMovement -= 1
		If iDirectionalMovement < 1
			iDirectionalMovement = 0
		EndIf
		bIsAutomove = False
	EndIf

	SetIsMoving((iDirectionalMovement > 0) || (bIsAutomove))

	ReleaseMutex()
EndEvent


; @section: States
;

Auto State Idle
EndState

Float fLastX
Float fLastY
Float fLastZ
Int iSkipNextMovementChecks

; Default State
; 
; This is the default state which repeats every 0.5s by default. It will apply effects
; on the actor when needed, and rescan for changes.
; 
Float fUpdateFrequency
Int iEffectSlotControlMask		; The items that are not controlled by the regular enchantment system. When items are added, they are flagged here for removal from "automatic" processing.
State Default
	Event OnBeginState()
		Log("Default: OnBeginState")

		fUpdateFrequency = 0.5
		If !IsPlayer()
			fUpdateFrequency = 4.0
		EndIf
		ApplyEffects(ActorRef)
		RegisterForSingleUpdate(0.1)
	EndEvent

	Event OnUpdate()
		ApplyEffects(ActorRef)
		RegisterForSingleUpdate(fUpdateFrequency)
	EndEvent

	Function ApplyEffects(Actor akTarget)
		Bool isValid = IsPlayer() && !IsInMenu()
		If !isValid
			isValid = zbfUtil.IsValidActor(akTarget)
		EndIf

		If isValid
			; Check movement
			Float x = ActorRef.GetPositionX()
			Float y = ActorRef.GetPositionY()
			Float z = ActorRef.GetPositionZ()

			Float diff = (fLastX - x) * (fLastX - x)
			diff += (fLastY - y) * (fLastY - y)
			diff += (fLastZ - z) * (fLastZ - z)

			iSkipNextMovementChecks -= 1
			If (diff < 15) && (iSkipNextMovementChecks <= 0)
				SetIsMoving(False)
			EndIf

			fLastX = x
			fLastY = y
			fLastZ = z

			If bAutoRepeatIdle
				ApplyAnimEffects()
			EndIf

			If bHasMovementSpeed	; Really apply every iteration?
				ApplyMovementSpeed()
			EndIf

			If bNeedsFaceUpdate
				bNeedsFaceUpdate = False
				ApplyFaceAnim()
			EndIf

			If bNeedsOverlayUpdate
				bNeedsOverlayUpdate = False
				ApplyTextureOverlays()
				ApplyPlayerControls() ; SlaveTats messes with player controls
			EndIf

			; Probably don't do this every iteration.
			; ApplyPlayerControls()

			fAnimTimeToNext -= fUpdateFrequency
			If fAnimTimeToNext < 0.0
				PlayNext()
			EndIf
		EndIf
	EndFunction
EndState

; @section: Events
; 

Event OnSexLabAnimationStart(Form controller, String tags, Form a1, Form a2, Form a3, Form a4)
	Log("OnSexLabAnimationStart event received.")
	If (ActorRef == a1) || (ActorRef == a2) || (ActorRef == a3) || (ActorRef == a4)
		Log("controller = " + controller)
		Log("tags = " + tags)
		Log("a1 = " + zbfUtil.GetActorName(a1 As Actor))
		Log("a2 = " + zbfUtil.GetActorName(a2 As Actor))
		Log("a3 = " + zbfUtil.GetActorName(a3 As Actor))
		Log("a4 = " + zbfUtil.GetActorName(a4 As Actor))

		GoToState("SexLabState")
	EndIf
EndEvent

Event OnSexLabAnimationEnd(Form controller, String tags, Form a1, Form a2, Form a3, Form a4)
EndEvent

; @section: States
;

; SexLab state
; 
; State used to control updates from SexLab. Will basically disable all normal mod functionality.
; 
; Specifically, changing animations and setting face expressions are deferred (settings are still accepted, 
; just not applied immediately) on actors in SexLab events.
; 
State SexLabState
	Event OnBeginState()
		Log("SexLabState: OnBeginState")
	EndEvent
	Event OnSexLabAnimationStart(Form controller, String tags, Form a1, Form a2, Form a3, Form a4)
	EndEvent
	Event OnSexLabAnimationEnd(Form controller, String tags, Form a1, Form a2, Form a3, Form a4)
		Log("OnSexLabAnimationEnd event received.")

		If (ActorRef == a1) || (ActorRef == a2) || (ActorRef == a3) || (ActorRef == a4)
			Log("controller = " + controller)
			Log("tags = " + tags)
			Log("a1 = " + zbfUtil.GetActorName(a1 As Actor))
			Log("a2 = " + zbfUtil.GetActorName(a2 As Actor))
			Log("a3 = " + zbfUtil.GetActorName(a3 As Actor))
			Log("a4 = " + zbfUtil.GetActorName(a4 As Actor))

			Utility.Wait(1.0)	; War of waiting, SexLab will clean up at this point ... 

			GoToState("Default")
			ApplyAllEffects()
		EndIf
	EndEvent

	Function ApplyAnimEffects()
		; No action, will be done later on
	EndFunction

	Function ApplyFaceAnim()
		; No action, will be done later on
	EndFunction
EndState



; @section: Private
; 
; Module private functions. Not to be called from outside the mod.
; 

; Helps to either return akNominal if not None, or search for items on the actor with the specified keyword.
; 
; Currently it searches only in the aiMask slot mask.
; Any found item must have akKeyword.
; No other keywords or properties are checked (not even zbfWornDevice).
; 
Form Function GetCurrentItemHelper(Form akNominal, Int aiMask, Keyword akKeyword)
	If akNominal != None
		Return akNominal
	EndIf
	
	Form guess = ActorRef.GetWornForm(aiMask)
	If guess != None && guess.HasKeyword(akKeyword)
		Return guess
	EndIf
	Return None
EndFunction

; Returns either the akReference or akBaseForm, if akReference is None.
; 
Form Function GetItemHelper(Form akBaseForm, ObjectReference akReference)
	If akReference != None
		Return akReference
	EndIf
	Return akBaseForm
EndFunction

Function SetIsMoving(Bool abIsMoving)
	Bool wasMoving = bIsMoving

	If wasMoving != abIsMoving
		bIsMoving = abIsMoving

		;If !bIsMoving && bHasStillAnim
			;If afHoldTime < 0.7
				; Not sure what to do about this, no animation events are accepted
				;ActorRef.PlayIdle(IdleForceReset)
			;EndIf
		;EndIf

		If bIsMoving && bHasStillAnim
			ApplyAnimEffects()
		EndIf

		If bHasBlindEffect
			ApplyImageSpaceModifier()
		EndIf

		If !bIsMoving
			iDirectionalMovement = 0
			bIsAutomove = False
		EndIf
		
		iSkipNextMovementChecks = 2
	EndIf
EndFunction

Bool Function IsZapEnchanted(Form akBaseItem)
	Armor base = akBaseItem As Armor
	If base == None
		Return False
	EndIf
	Enchantment ench = base.GetEnchantment()
	If ench == None
		Return False
	EndIf

	If ench == zbf.zbfEnchantmentBondage
		Log(akBaseItem.GetName() + " had zbfEnchantmentBondage.")
		Return True
	EndIf

	Int i = ench.GetNumEffects()
	While i > 0
		i -= 1
		If ench.GetNthEffectMagicEffect(i) == zbf.zbfMagicEffectBondage
			Log(akBaseItem.GetName() + " had zbfMagicEffectBondage.")
			Return True
		EndIf
	EndWhile

	Log(akBaseItem.GetName() + " did not have any of the right effects.")
	Return False
EndFunction

Function SetDebugLevel(Int aiLevel)
	iDebugLevel = aiLevel
EndFunction

Int iDebugLevel
Int iError = 0
Int iWarning = 1
Int iInfo = 2
Function Log(String asMessage, Bool abCondition = True, Int aiLevel = 2)
	If abCondition && (aiLevel <= iDebugLevel)
		Debug.Trace(sDebugString + ": " + asMessage)
	EndIf
EndFunction

Int iMutex
Function GrabMutex()
	Int iSafety = 50
	While (iMutex > 0) && (iSafety > 0)
		iSafety -= 1
		Utility.Wait(0.1)
	EndWhile
	iMutex = 1
	If iSafety <= 0
		Debug.Trace(sDebugString + ": Mutex did not release in time.")
	EndIf
EndFunction

Function ReleaseMutex()
	iMutex -= 1
EndFunction
