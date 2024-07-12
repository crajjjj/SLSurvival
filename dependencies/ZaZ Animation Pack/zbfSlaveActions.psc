Scriptname zbfSlaveActions extends Quest

zbfBondageShell Property zbf Auto
zbfSexLab Property zbfSL Auto
zbfSlaveLeash Property zbfLeash Auto

zbfSlot Property PlayerSlot Auto
ReferenceAlias Property Alias_Master Auto
ReferenceAlias Property Alias_PlayerMaster Auto

ObjectReference Property MarkerPlayer Auto	; Markers used for various scenes. Do not hijack.
ObjectReference Property MarkerMaster Auto
ObjectReference Property MarkerExtra Auto

Weapon Property zbfWeaponCane Auto
GlobalVariable Property zbfSlaveWhipHealth Auto
GlobalVariable Property zbfSlaveWhipEndTime Auto

GlobalVariable Property TimeScale Auto

; @section: zbfSlaveActions
; 
; Actions that can be taken on slaves, primarily the player slave as applicable. For each action, a
; start and stop event are sent out. See ::RegisterForEvents on documentation for all the different
; events that can be sent from this framework.
; 
; Code: Example use
; Actor Owner = ....
; zbfSA.WhipPlayer(Owner, "MyMod_Whip", afMaxTime = 60.0)
; 
; Code: Example use
; Actor Owner = ...
; ObjectReference CageDoor = ...
; zbfSA.MoveToCage(Owner, CageDoor, "MyMod_CagePlayer")
; 
; In the above examples the first will whip the player for at most 60s (or default 25 health remaining),
; and the second will play a scene where the player is taken to a cage and locked in there.
; 
; In both cases, an event is sent when the action is completed, "ZapSlaveActionDone". Please see ::OnSlaveActionDone
; on documentation for this event's signature.
; 
; Code: Example sex action
; Actor Owner = ...
; zbfSA.OralSex(Owner, "MyMod_Sex", abForced = False)
; 
; The above code will play an oral sex animation and return an event when done. See ::OnSlaveSexLabDone for
; documentation on how to use this event.
; 

; Returns the main object for this api.
; 
zbfSlaveActions Function GetApi() Global
	Return zbfUtil.GetGenericForm(0x020096B2) As zbfSlaveActions
EndFunction

; Retrieves the current master and markers.
; 
Actor Function GetMaster()
	Return Alias_Master.GetActorReference()
EndFunction
ObjectReference Function GetMasterMarker()
	Return MarkerMaster
EndFunction
ObjectReference Function GetPlayerMarker()
	Return MarkerPlayer
EndFunction
ObjectReference Function GetExtraMarker()
	Return MarkerExtra
EndFunction


; @section: Actions
; 
; All the following functions are helpers to replay scenes where the master does something with
; the player. Master in this context refers to any actor, specified when the action is set up. By
; default, the actor set through zbfSlaveControl::SetPlayerMaster is used for this purpose, but this
; is not necessary.
; 
; 
; An options string can be sent to the scenes to further customize behavior.
; 
; If akMaster is set to None, then the currently assigned player master will be used (see zbfSlaveControl::SetPlayerMaster).
; 
; asMessage is an optional message that is passed along to the event when the action is completed.
; This can be used to make sure that only actions initiated by the calling module are actually
; responded to.
; 
; Options are listed as a list of strings separated by a comma. Example: "silent" will disable 
; all dialogue.
; 
; Options:  
; silent - Forces the scene to skip dialogue. See ::SetDialogueType (with aiType set to 0).
; 
; Set the player master using zbfSlaveControl::SetPlayerMaster.
; 
; Code: Examples
; BindPlayer(ropes) ; Player's master will tie the player's arms up with the "ropes" form.
; WhipPlayer() ; Player's master whips the player for 30s or until 25 health (default settings).
; AnySexAction("missionary", asMaster = BanditChief) ; plays a missionary animation with the BanditChief and the player
; AnySexAction("missionary,aggressive", asMaster = BanditChief) ; plays an aggressive missionary animation with the BanditChief and the player
; 

; Sets the type of dialogue to use in scenes
; 
; 0 - No dialogue (silent)
; 1 - Generic
; 2 - Slave (forced slavery)
; 
; Not all scenes support dialogue, and may be silent for some types. This value is overwritten each
; time a scene is started.
; 
GlobalVariable Property zbfSlaveDialogueType Auto
Function SetDialogueType(Int aiType)
	zbfSlaveDialogueType.SetValueInt(aiType)
EndFunction

; Adds or removes bindings on the player
; 
; Update bindings on the player to the current definition. Bindings are automatically added to the player
; inventory if needed, or removed if no longer needed. Only bindings equipped through the slotting system
; are considered for removal.
; 
; Set bindings to ::RemoveSlot to remove bindings instead. Setting a slot to None will not alter the worn
; item in that slot.
; 
; When the scene ends, an event is sent. See ::OnSlaveActionDone for signature. asType will be
; set to "Bind".
; 
Scene Property BindScene Auto
Armor Property RemoveSlot Auto
Function BindPlayer(Form akArms = None, Form akGag = None, Form akBlindfold = None, Actor akMaster = None, String asMessage = "", String asOptions = "")
	Log("BindPlayer", "(\"" + zbfUtil.GetActorName(akMaster) + "\", " + akArms + ", " + akGag + ", " + akBlindfold + ", \"" + asOptions + "\").")

	BindSceneArms = akArms
	BindSceneGag = akGag
	BindSceneBlindfold = akBlindfold

	; There is no scene defined yet, just stop the queue to signal events and so on.
	String[] options = zbfUtil.ArgString(asOptions)
	SetQueueValues("Bind", akMaster, asMessage, options)
	AddToQueue(BindScene)
	StartQueue()
EndFunction
Form BindSceneArms
Form BindSceneGag
Form BindSceneBlindfold

; Plays a short scene where the master whips the player.
; 
Scene Property WhipScene Auto
Function WhipPlayer(Actor akMaster = None, String asMessage = "", Float afMaxTime = 30.0, Float afMinHealth = 25.0, String asOptions = "")
	Log("WhipPlayer", "(\"" + zbfUtil.GetActorName(akMaster) + "\", " + afMaxTime + ", " + afMinHealth + ", \"" + asOptions + "\").")

	zbfSlaveWhipHealth.SetValue(afMinHealth)

	String[] options = zbfUtil.ArgString(asOptions)
	SetQueueValues("Whip", akMaster, asMessage, options)
	AddToQueue(WhipScene)
	StartQueue()
EndFunction

; Puts the player inside a cage or a cell.
; 
; Works by putting the player on the other side of a door. The companion function ::MoveFromCage
; removes the player from a cage or cell.
; 
; The orientation of the door is important. If the direction is wrong, the player will be placed on 
; the other side. It is assumed that doors open outward from the cage or cell. Should they open inward
; they must first be rotated before they can be used.
; 
; In the future, options may allow auto detecting direction and/or manually force a door reverse.
; 
Scene Property ToCageScene Auto
Scene Property FromCageScene Auto
ObjectReference Property CageDoor Auto Hidden
Function MoveToCage(ObjectReference akCageDoor, Actor akMaster = None, String asMessage = "", String asOptions = "")
	Log("MoveToCage", "(\"" + zbfUtil.GetActorName(akMaster) + "\", " + zbfUtil.GetObjectName(akCageDoor) + ", \"" + asOptions + "\").")

	CageDoor = akCageDoor

	String[] options = zbfUtil.ArgString(asOptions)
	SetQueueValues("ToCage", akMaster, asMessage, options)
	AddToQueue(ToCageScene)
	StartQueue()
EndFunction
Function MoveFromCage(ObjectReference akCageDoor, Actor akMaster = None, String asMessage = "", String asOptions = "")
	Log("MoveFromCage", "(\"" + zbfUtil.GetActorName(akMaster) + "\", " + zbfUtil.GetObjectName(akCageDoor) + ", \"" + asOptions + "\").")

	CageDoor = akCageDoor

	String[] options = zbfUtil.ArgString(asOptions)
	SetQueueValues("FromCage", akMaster, asMessage, options)
	AddToQueue(FromCageScene)
	StartQueue()
EndFunction

; Forces player into the specified furniture.
; 
; Set akDevice to "None" to take player out of the device instead. Current device is auto detected.
; 
Scene Property FromDeviceScene Auto
Scene Property ToDeviceScene Auto
Function RestrainInDevice(ObjectReference akDevice, Actor akMaster = None, String asMessage = "", String asOptions = "")
	Log("BindPlayerInDevice", "(\"" + zbfUtil.GetActorName(akMaster) + "\", " + zbfUtil.GetObjectName(akDevice) + ", \"" + asOptions + "\").")

	String[] options = zbfUtil.ArgString(asOptions)
	SetQueueValues("Furniture", akMaster, asMessage, options)
	ObjectReference currentDevice = PlayerSlot.GetFurniture()

	If currentDevice != akDevice
		FromDeviceReference = currentDevice
		If FromDeviceReference != None
			AddToQueue(FromDeviceScene)
		EndIf

		ToDeviceReference = akDevice
		If ToDeviceReference != None
			AddToQueue(ToDeviceScene)
		EndIf
	EndIf

	StartQueue()
EndFunction
ObjectReference ToDeviceReference
ObjectReference FromDeviceReference


; @section: SexLab
; 
; All these actions connect to SexLab. They will return with another type of event, ZapSlaveSexLabDone.
; See ::OnSlaveSexLabDone for signature for this event.
; 
; The asOptions parameter follows the same conventions as zbfSexLab::StartSexEx.
; 
; To separate different types of events, it is possible to send a message with asMessage that the script
; can listen to.
; 

; Generic function to start SexLab
; 
; Regardless of success, it returns with a ZapSlaveSexLabDone event. See ::OnSlaveSexLabDone for signature.
; 
; asMessage contain a modder specified message.
; 
; asRequired contain required SexLab tags. All of these must be present.  
; asBlocked contain blocked SexLab tags. None of these may be present.  
; asAny contains SexLab tags where at least one must be present.
; 
; asOptions contains additional options to send to SexLab. These follow the conventions of zbfSexLab::StartSexEx.
; 
; An example option that is useful is the "forced" setting. This works like setting "forced" to true in SexLab
; animations.
; 
; If akMaster is left as None, then the current PlayerMaster is used (as defined by zbfSlaveControl::MakePlayerOwned).
; 
; Code: Examples
; AnySexAction(asRequired = "spank", asOptions = "forced") ; Will start a spanking animation with the owner, which is forced.
; AnySexAction(asRequired = "missionary", asMessage = "MyMod_Scene1") ; Will respond with a "MyMod_Scene1" message when done playing a missionary scene.
; 
Function AnySexAction(String asRequired = "", String asBlocked = "", String asAny = "", Actor akMaster = None, String asMessage = "", String asOptions = "")
	Actor masterToSlot = akMaster
	If masterToSlot == None
		masterToSlot = Alias_PlayerMaster.GetActorReference()
	EndIf
	Actor[] actors = zbfUtil.ActorList(PlayerSlot.GetActorReference(), masterToSlot)
	GenericSexLabStarter(asRequired, asBlocked, asAny, asMessage, asOptions, actors)
EndFunction

; This function works like ::AnySexAction but will define SexLab events on an array of actors.
; 
; Order of slotting is always Player, akActors[0], akActors[1], akActors[2]. This function can be used to trigger solo animations
; as well, since it does not automatically fill any actor slots like ::AnySexAction. Just leave the akActors as an empty array using
; zbfUtil::ActorList() or using New Actor[4].
; 
Function AnyGroupSexAction(Actor[] akActors, String asRequired = "", String asBlocked = "", String asAny = "", String asMessage = "", String asOptions = "")
	Actor[] actors = New Actor[4]
	Int i = 1
	While i < 4 && i < akActors.Length
		actors[i] = akActors[i]
		i += 1
	EndWhile
	actors[0] = PlayerSlot.GetActorReference()
	GenericSexLabStarter(asRequired, asBlocked, asAny, asMessage, asOptions, actors)
EndFunction

; Starts spanking the player.
; 
Function SpankSexAction(Actor akMaster = None, String asMessage = "", String asOptions = "")
	AnySexAction(asRequired = "spank", akMaster = akMaster, asMessage = asMessage, asOptions = asOptions)
EndFunction

; Forces the player to have oral sex with the master
; 
Function OralSexAction(Actor akMaster = None, String asMessage = "", String asOptions = "")
	AnySexAction(asRequired = "oral", akMaster = akMaster, asMessage = asMessage, asOptions = asOptions)
EndFunction

; Forces the player to have missionary sex with the master
; 
Function MissionarySexAction(Actor akMaster = None, String asMessage = "", String asOptions = "")
	AnySexAction(asRequired = "missionary", akMaster = akMaster, asMessage = asMessage, asOptions = asOptions)
EndFunction

; Rough sex with the player
; 
Function RoughSexAction(Actor akMaster = None, String asMessage = "", String asOptions = "")
	AnySexAction(asRequired = "aggressive,sex", asAny = "missionary,doggystyle", akMaster = akMaster, asMessage = asMessage, asOptions = asOptions)
EndFunction

FormList Property ListWhipFurniture Auto
ObjectReference Function FindWhipFurniture()
	Float fRad = 1000.0
	Return Game.FindRandomReferenceOfAnyTypeInListFromRef(ListWhipFurniture, PlayerSlot.GetReference(), fRad)
EndFunction


; @section: Events
; 
; Registers to receive all events from the slavery framework (for logging purposes).
; 
; Modders can copy this function and the empty events below to kick start event handling from this module.
; 
; This function also serves as documentation on the various events that the framework can send out.
; 
Function RegisterForEvents()
	Log("RegisterForEvents", "Registering for slavery action events.")

	RegisterForModEvent("ZapSexLabAnimationEnd", "OnSexLabAnimationEnd")	; Event from zbfSexLab translated to this framework
	RegisterForModEvent("ZapSlaveActionDone", "OnSlaveActionDone")
	RegisterForModEvent("ZapSlaveSexLabDone", "OnSlaveSexLabDone")
EndFunction

; Callback signature for all action functions.
; 
Event OnSlaveActionDone(String asType, String asMessage, Form akMaster, Int aiSceneIndex)
	Log("OnSlaveActionDone", "Returned a \"" + asType + "\" with message \"" + asMessage + "\" for scene index " + aiSceneIndex + ".")
EndEvent

; Callback signature for SexLab events started through this module.
; 
Event OnSlaveSexLabDone(String asMessage)
	Log("OnSlaveSexLabDone", "SexLab done with message \"" + asMessage + "\".")
EndEvent

; Bridge between zbfSexLab and zbfSlaveActions
; 
Event OnSexLabAnimationEnd(Form controller, String tags, Form a1, Form a2, Form a3, Form a4)
	If !isWaitingForSexLab
		Return
	EndIf
	isWaitingForSexLab = False

	Actor player = Game.GetPlayer()

	If (a1 == player) || (a2 == player) || (a3 == player) || (a4 == player)
		SendSexLabEvent()
	EndIf
EndEvent

; @section: Helpers
; 

FormList Property zbfListMetalCageDoor Auto
FormList Property zbfListMetalCageLongDoor Auto
FormList Property zbfListImperialJailDoor Auto
FormList Property zbfListRiftenJailDoor Auto
FormList Property zbfListFarmhouseJailDoor Auto
FormList Property zbfListSolitudeJailDoor Auto

; Returns the type of jail door.
; 
; There are several types of cage/jail doors available.
; 0 - Unknown or default
; 1 - MetalCageDoor01
; 2 - MetalCageLongGate01
; 3 - ImpJailDoor01
; 4 - RiftenRWDoorJail01
; 5 - FarmhouseJailDoor01
; 6 - SDoorJail01
; 
; Variant doors are matched in the above categories. For instance, ImpJailDoor01MinUse is matched as a ImpJailDoor01 (3).
; 
Int Function GetDoorType(ObjectReference akObject)
	Form base = akObject.GetBaseObject()
	Log("GetDoorType", "Checking " + akObject + " with base " + base)

	FormList[] lists = New FormList[6]
	lists[0] = zbfListMetalCageDoor
	lists[1] = zbfListMetalCageLongDoor
	lists[2] = zbfListImperialJailDoor
	lists[3] = zbfListRiftenJailDoor
	lists[4] = zbfListFarmhouseJailDoor
	lists[5] = zbfListSolitudeJailDoor

	Int i = lists.Length
	While i > 0
		i -= 1
		FormList list = lists[i]
		If list.HasForm(base)
			Return i + 1
		EndIf
	EndWhile

	Log("GetDoorType", "Could not find door type. Returning default value.", aiLevel = iWarning)
	Return 0
EndFunction

; Sets markers according to the door type.
; 
; Doors open toward the "outside" marker. If the door direction is reversed, just swap outside to inside.
; 
; See ::GetDoorType for a list of available door types.
; 
Function PlaceDoorMarkers(ObjectReference akOutside, ObjectReference akInside, ObjectReference akDoor, Int aiDoorType)
	Log("PlaceDoorMarkers", "Markers placing for door type " + aiDoorType)

	Float angleOutside = 0
	Float distanceOutside = 120
	Float angleInside = 180
	Float distanceInside = 90

	If aiDoorType == 1
		angleOutside = 20
		distanceOutside = 140
		angleInside = -160
		distanceInside = 140

	ElseIf aiDoorType == 2
		angleOutside = 0
		distanceOutside = 300
		angleInside = -180
		distanceInside = 30

	ElseIf aiDoorType == 3
		angleOutside = 45
		distanceOutside = 170
		angleInside = 135
		distanceInside = 170

	ElseIf aiDoorType == 4
		angleOutside = 0
		distanceOutside = 120
		angleInside = 180
		distanceInside = 90

	ElseIf aiDoorType == 5
		angleOutside = 0
		distanceOutside = 120
		angleInside = 180
		distanceInside = 90

	ElseIf aiDoorType == 6
		angleOutside = 0
		distanceOutside = 120
		angleInside = 180
		distanceInside = 90

	Else
		angleOutside = 0
		distanceOutside = 120
		angleInside = 180
		distanceInside = 90

	EndIf

	zbfUtil.PlaceRelative(akOutside, akDoor, distanceOutside, angleOutside)
	zbfUtil.PlaceRelative(akInside, akDoor, distanceInside, angleInside)

	zbfUtil.FaceObject(akOutside, akInside)
	zbfUtil.FaceObject(akInside, akOutside)

	; Move slightly to the right to allow player to pass
	zbfUtil.PlaceRelative(akOutside, akOutside, 25.0, 90.0)
EndFunction


; 
; @section: Queue
; 
; Functions to support queueing of scenes. This is used by the ::Actions section.
; 

; Global action variables
; 
; Tracks state of the action being taken. Are not automatically cleared after action data has been sent,
; and may contain old data.
; 
String sActionType
String sActionMessage
Int iActionIndex

Float fQueueTimeout
Scene[] SceneQueue
Int iCurrentScene
Function StartQueue()
	Log("StartQueue", "No default action in state " + GetState() + ".", aiLevel = iError)
EndFunction
Function StopQueue()
	Log("StopQueue", "No default action in state " + GetState() + ".", aiLevel = iError)
EndFunction
Function SetQueueValues(String asType, Actor akMaster, String asMessage, String[] asOptions, Float afGlobalTimeout = 180.0)
	Log("SetQueueValues", "No default action in state " + GetState() + ".", aiLevel = iError)
EndFunction
Function AddToQueue(Scene akScene)
	Log("AddToQueue", "No default action in state " + GetState() + ".", aiLevel = iError)
EndFunction
Function AbortQueue()
	Log("AbortQueue", "No default action in state " + GetState() + ".", aiLevel = iError)
EndFunction

; 
; @section: States
; 

Auto State Idle
	Event OnBeginState()
		Alias_Master.Clear()
	EndEvent

	Function SetQueueValues(String asType, Actor akMaster, String asMessage, String[] asOptions, Float afGlobalTimeout = 180.0)
		Log("SetQueueValues", "")

		; Set generic properties
		iActionIndex += 1
		fQueueTimeout = afGlobalTimeout
		SceneQueue = New Scene[10]

		; Send scene specific properties
		Actor masterToUse = akMaster
		If masterToUse == None
			masterToUse = Alias_PlayerMaster.GetActorReference()
		EndIf
		Alias_Master.ForceRefTo(masterToUse)
		sActionType = asType
		sActionMessage = asMessage

		If masterToUse == None || asType == "" || afGlobalTimeout < 0.0
			Log("SetQueueValues", "Something was broken setting up the queue. Master = " + masterToUse + ", type = \"" + asType + "\", timeout = \"" + afGlobalTimeout + "\".")
			GoToState("BrokenQueue")
			Return
		EndIf
		GoToState("QueueSetup")
	EndFunction

	Function SendActionEvent()
		Log("SendActionEvent", "Can't send an action event before action has been set up.", aiLevel = iError)
	EndFunction
EndState

State QueueSetup
	Function StartQueue()
		Log("StartQueue", "")
		If SceneQueue[0] == None
			Log("StartQueue", "No scene queue defined.")
			StopQueue()
			Return
		EndIf

		iCurrentScene = 0
		StartSceneHelper(SceneQueue[iCurrentScene])
		GoToState("SceneQueue")
	EndFunction

	Function AddToQueue(Scene akScene)
		Log("AddToQueue", "")
		Int firstFree = SceneQueue.Find(None)
		Log("AddToQueue", "Can't add any more scenes", abCondition = (firstFree < 0))

		SceneQueue[firstFree] = akScene
	EndFunction

	Function StopQueue()
		SendActionEvent()
		GoToState("Idle")
	EndFunction

	Function AbortQueue()
		GoToState("BrokenQueue")
	EndFunction
EndState

State BrokenQueue
	Event OnBeginState()
		Log("BrokenQueue(OnBeginState)", "Queue was broken. Waiting for the StartQueue, which will then immediately trigger a stop and fail.")
	EndEvent

	Function StartQueue()
		SendActionEvent()
		GoToState("Idle")
	EndFunction

	Function AddToQueue(Scene akScene)
	EndFunction

	Function StopQueue()
		SendActionEvent()
		GoToState("Idle")
	EndFunction

	Function AbortQueue()
	EndFunction
EndState

Float fQueueEndTime
State SceneQueue
	Event OnBeginState()
		Log("OnBeginState", "SceneQueue")
		fQueueEndTime = Utility.GetCurrentGameTime() + fQueueTimeout * TimeScale.GetValue() / 86400.0
		RegisterForSingleUpdate(1.0)
	EndEvent

	Event OnEndState()
		Log("OnEndState", "SceneQueue")
	EndEvent

	Function StopQueue()
		Log("StopQueue", "")
		Scene current = SceneQueue[iCurrentScene]
		If current != None
			current.Stop()
			current = None
		EndIf

		SendActionEvent()
		GoToState("Idle")
	EndFunction

	Event OnUpdate()
		Log("OnUpdate", "")

		Float time = Utility.GetCurrentGameTime()
		Scene current = SceneQueue[iCurrentScene]

		; Either timeout or end of queued scenes
		If (time > fQueueEndTime) || (current == None)
			StopQueue()
			Return
		EndIf

		; Scene stopped, pick next one and start playing that one
		If !current.IsPlaying()
			iCurrentScene += 1
			current = SceneQueue[iCurrentScene]
			If current != None
				StartSceneHelper(current)
			EndIf
		EndIf

		RegisterForSingleUpdate(1.0)
	EndEvent
EndState


; 
; @section: Scene Private
; 
; These functions are helpers for the various scenes and should not be called.
; 

Function SetPinPlayer(Bool abPin)
	If abPin
		PlayerSlot.PinActor()
	Else
		PlayerSlot.UnPinActor()
	EndIf
EndFunction
Function SetPinMaster(Bool abPin)
	Actor master = Alias_Master.GetActorReference()
	If abPin
		zbf.PinActor(master)
	Else
		zbf.UnPinActor(master)
	EndIf
EndFunction

Function ModMasterCaneCount(Int aiCount)
	Actor master = Alias_Master.GetActorReference()
	If aiCount > 0
		master.AddItem(zbfWeaponCane, aiCount = aiCount, abSilent = True)
	ElseIf aiCount < 0
		master.RemoveItem(zbfWeaponCane, aiCount = aiCount, abSilent = True)
	EndIf
EndFunction
Function PlaceWhipMarkers()
	ObjectReference player = PlayerSlot.GetReference()
	MarkerPlayer.MoveTo(player)

	; Figure out interaction position
	zbfUtil.PlaceRelative(MarkerMaster, player, 80.0)
	zbfUtil.FaceObject(MarkerMaster, player)
EndFunction
Function SetWhipTimeOut(Float afTime = 30.0)
	Log("SetWhipTimeout", "")
	zbfSlaveWhipEndTime.SetValue(Utility.GetCurrentGameTime() + afTime * TimeScale.GetValue() / 86400.0)
EndFunction

Function PlaceCageDoorMarkers()
	Int doorType = GetDoorType(CageDoor)
	PlaceDoorMarkers(MarkerMaster, MarkerPlayer, CageDoor, doorType)
EndFunction
Function SetCageDoorOpen(Bool abState)
	CageDoor.SetOpen(abState)
EndFunction

Function PlaceBindMarkers()
	MarkerMaster.MoveTo(Alias_Master.GetActorReference())
	zbfUtil.PlaceRelative(MarkerPlayer, MarkerMaster, 70.0)
	zbfUtil.FaceObject(MarkerPlayer, MarkerMaster)
EndFunction
Function PlaceBindActors()
	Actor master = Alias_Master.GetActorReference()
	Actor player = PlayerSlot.GetActorReference()

	master.MoveTo(MarkerMaster)
	player.MoveTo(MarkerPlayer)
EndFunction
Function PlayBindAnimation()
	; Debug.SendAnimationEvent(akActor, "IdleLockpick")
	; Debug.SendAnimationEvent(akActor, "MariaAddGag")
	; Debug.SendAnimationEvent(akActor, "ZapWriTurn01")
	; Debug.SendAnimationEvent(akActor, "IdleSurrender")
	Actor master = Alias_Master.GetActorReference()

	Debug.SendAnimationEvent(master, "IdleLockpick")
	PlayerSlot.SetAnim("ZapWriTurn01")
EndFunction
Function BindingHelper(zbfSlot akSlot, Form akItem, Form akSlotted)
	If akItem == RemoveSlot
		akSlot.RemoveBinding(akSlotted)
	ElseIf akItem != None && akItem != akSlotted
		akSlot.SetBinding(akItem)
	EndIf
EndFunction
Function DoBindPlayer()
	BindingHelper(PlayerSlot, BindSceneArms, PlayerSlot.GetArmBindings())
	BindingHelper(PlayerSlot, BindSceneGag, PlayerSlot.GetGag())
	BindingHelper(PlayerSlot, BindSceneBlindfold, PlayerSlot.GetBlindfold())
EndFunction
Function DropBindAnimation()
	PlayerSlot.StopIdleAnim()
EndFunction

Function PlaceFromDeviceMarkers()
	PlaceDeviceMarkers(FromDeviceReference)
EndFunction
Function PlaceToDeviceMarkers()
	PlaceDeviceMarkers(ToDeviceReference)
EndFunction
Function PlaceDeviceMarkers(ObjectReference akFurniture)
	Int furnitureType = zbf.GetFurnitureType(akFurniture)
	zbf.MoveToInteraction(furnitureType, MarkerMaster, akFurniture)
EndFunction
Function StartReleaseFromDevice()
	Actor master = Alias_Master.GetActorReference()
	Debug.SendAnimationEvent(master, "IdleLockpick")
EndFunction
Function DoneReleaseFromDevice()
	PlayerSlot.SetFurniture(None)
EndFunction
Function StartBindInDevice()
	Actor master = Alias_Master.GetActorReference()
	Actor player = PlayerSlot.GetActorReference()

	Debug.SendAnimationEvent(master, "IdleLockpick")
	PlayerSlot.SetFurniture(ToDeviceReference)
EndFunction


; 
; @section: Private
; 
; Module private functions.
; 

; Processes options present on all scenes
Function ProcessStandardSceneOptions(String asOptions)
	String[] options = zbfUtil.ArgString(asOptions)
	
	If options.Find("silent") != -1
		SetDialogueType(0)
	EndIf
EndFunction

; Forces actor to stay put.
; 
Function PinActor(Actor akActor)
	zbfSlot slot = zbf.SlotActor(akActor)
	slot.PinActor()
EndFunction
Function UnPinActor(Actor akActor)
	zbfSlot slot = zbf.FindSlot(akActor)

	slot.UnPinActor()
	zbf.UnSlotActor(akActor)
EndFunction

String sSexLabMessage
Bool isWaitingForSexLab
; Function GenericSexLabStarter(Actor akMaster, String asMessage, String asRequired, String asBlocked = "", String asOptions = "", Bool abForced = False, Actor akOther1 = None, Actor akOther2 = None)
Function GenericSexLabStarter(String asRequired, String asBlocked, String asAny, String asMessage, String asOptions, Actor[] akActors)
	Log("GenericSexLabStarter", "(\"" + asRequired + ", " + asBlocked + ", " + asAny + ").")
	Log("GenericSexLabStarter", "(\"" + akActors + ").")
	Log("GenericSexLabStarter", "(\"" + asMessage + ", " + asOptions + ").")

	String options = asOptions + ",NoBed"
	String blocked = asBlocked
	String[] inputOptions = zbfUtil.ArgString(asOptions)
	Bool forced = (inputOptions.Find("forced") != -1)

	If forced
		blocked += ", loving"
		options += ", Vic1"
	EndIf

	sSexLabMessage = asMessage
	isWaitingForSexLab = True
	
	zbfSexLabBaseEntry[] entries = zbfSL.GetEntriesByTags(akActors, asRequired, blocked)
	If asAny != ""
		zbfSL.FilterEntriesAny(entries, zbfUtil.ArgString(asAny))
	EndIf

	Int tid = zbfSL.StartSexEx(akActors, entries, options)
	if tid == -1
		isWaitingForSexLab = False
		SendSexLabEvent()
	EndIf
EndFunction

Function SendSexLabEvent()
	String eventName = "ZapSlaveSexLabDone"
	Log("SendSexLabEvent", "Sending ZapSlaveSexLabDone with message \"" + sSexLabMessage + "\".")

	Int iEvent = ModEvent.Create(eventName)
	ModEvent.PushString(iEvent, sSexLabMessage)
	ModEvent.Send(iEvent)
EndFunction

Function ManipulateLow(Actor akActor)
	Debug.SendAnimationEvent(akActor, "IdleLockpick")
EndFunction

Function ManipulateHigh(Actor akActor)
	Debug.SendAnimationEvent(akActor, "MariaAddGag")
EndFunction

Function TurnAround(Actor akActor)
	Debug.SendAnimationEvent(akActor, "ZapWriTurn01")
EndFunction

Function Surrender(Actor akActor)
	Debug.SendAnimationEvent(akActor, "IdleSurrender")
EndFunction


Int iMutex = 0 
Function GetMutex()
	Int iSafety = 50
	While (iMutex > 0) && (iSafety > 0)
		Utility.Wait(0.1)
		iSafety -= 1
	EndWhile
	iMutex = 1
	Log("GetMutex", "Mutex in a deadlock!", aiLevel = iError, abCondition = (iSafety <= 0))
EndFunction

Function ReleaseMutex()
	iMutex = 0
EndFunction

Function SendActionEvent()
	String eventName = "ZapSlaveActionDone"
	Log("SendActionEvent", "Sending event type \"" + sActionType + "\" with message \"" + sActionMessage + "\" for scene " + iActionIndex + ".")

	Int iEvent = ModEvent.Create(eventName)
	ModEvent.PushString(iEvent, sActionType)
	ModEvent.PushString(iEvent, sActionMessage)
	ModEvent.PushForm(iEvent, Alias_Master.GetActorReference())
	ModEvent.PushInt(iEvent, iActionIndex)
	ModEvent.Send(iEvent)
EndFunction

Function StartSceneHelper(Scene akScene)
	Log("StartSceneHelper", "Scene: " + akScene)

	akScene.ForceStart()
	Int safety = 50
	While safety > 0 && !akScene.IsPlaying()
		Utility.Wait(0.1)
		safety -= 1
	EndWhile
EndFunction

Int Property iDebugLevel Auto Hidden
Int iForce = -1
Int iError = 0
Int iWarning = 1
Int iInfo = 2
String sFilePrefix = "zbfSlaveActions"
Function Log(String asMethod, String asMessage, Int aiLevel = 2, Bool abCondition = True)
	If abCondition && (aiLevel <= iDebugLevel)
		Debug.Trace(sFilePrefix + " (" + asMethod + "): " + asMessage)
	EndIf
EndFunction
