Scriptname zbfSlaveLeash extends Quest

zbfBondageShell Property zbf Auto

ReferenceAlias Property Alias_Slave Auto
ReferenceAlias Property Alias_Master Auto
ReferenceAlias Property Alias_Destination Auto
ReferenceAlias[] Property Alias_Extras Auto

Float Property MaxFloat = 100000.0 AutoReadOnly ; Not really, by far, but will do the job
Float Property fUpdateInterval = 1.0 AutoReadOnly ; Default update interval, can't be changed

; @section: zbfSlaveLeash
; 
; Leash controls for the slavery module.
; 
; Allows for capture and hauling of the player and other npcs. The module is fairly player centric, and since most
; of the complexities with player leashing is different from setting ai packages on npcs, the module will keep this
; focus.
; 
; Code: Simplest example of how to use this module would be the following:
; zbfSlaveLeash leash = zbfSlaveLeash.GetApi()
; leash.SetMaster(Guard)	; Guard is an actor
; leash.TravelTo(PilloryRef)	; PilloryRef is some kind of marker, furniture or similar.
; RegisterForModEvent("ZapSlaveLeashDone", "DoneLeash")
; 
; When the player has moved to the PilloryRef with the Guard, the "DoneLeash" method is called. See functions 
; ::OnSlaveLeashMove and ::OnSlaveLeashDone in this module for signature on the events that are sent.
; 


; @section: Properties

; Aliases used for package assignment.
; 
; Travel - Assigning actors to these aliases will assign them a travel package with the player.  
;          This travel package will move a bit forward, then if the player is not following, run back to "fetch"
;          the player.
; SingleFile - Single file packages is a simple single file marching. Master is leader, then comes the prisoner, then any extra
;              actors.
; SimpleFollowMaster - Simple package for following the master with a "follow" procedure.
; 
ReferenceAlias[] Property Travel Auto
ReferenceAlias[] Property SingleFile Auto
ReferenceAlias Property SimpleFollowMaster Auto

ObjectReference Property OrigLeashMarker Auto	; Marker resource, connected to the AI and can be moved around

GlobalVariable Property LeashPauseDistance Auto		; Distance when the master pauses to let player catch up
GlobalVariable Property LeashReturnDistance Auto	; Distance when the master returns to fetch the player


; @section: zbfSlaveLeash

; Returns the main object.
zbfSlaveLeash Function GetApi() Global
	Return zbfUtil.GetGenericForm(0x020096B2) As zbfSlaveLeash
EndFunction


; Starts travelling to the specified destination.
; 
; Travelling behavior is that the master will pause and wait for the player if the player falls too far behind.
; If way behind, the master will run back to fetch the player.
; 
; If akMaster is set to None, the currently assigned master will be used. Otherwise the master will be overriden.
; If no master is configured, the function will fail.  
; 
; Returns False if the function fails to start.
; 
; This function will still send events and change globals as if it was sucessful, even when it fails. This is so to
; prevent failing from blocking quests and scenes to proceed.
; 
Bool Function TravelTo(ObjectReference akDestination, Actor akMaster = None, Actor akExtra1 = None, Actor akExtra2 = None, String asMessage = "")
	Log("TravelTo")
	sLeashMessage = asMessage
	If (akMaster == None) || (akDestination == None)
		Log("No master assigned.", akMaster == None, iError)
		Log("None destination specified.", akDestination == None, iError)
		StopLeash()
		Return False
	EndIf

	SetAllDefaults()
	SetAllActors(akMaster, akExtra1, akExtra2)
	SetDestination(akDestination)
	SetTravelPackages()

	StartLeash("TravelTo", asMessage = asMessage)
	Return True
EndFunction

; Starts single file toward the destination.
; 
; Single file does not have any other behavior than walking toward the destination, as fast as possible. There is 
; no behavior to wait or so. Player will use the standard behavior when falling behind, ie. forcing ai and 
; teleporting when getting too far from the master.
; 
; If akMaster is set to None, the currently assigned master will be used. Otherwise the master will be overriden.
; If no master is configured, the function will fail.  
; 
; Returns False if the function fails to start.
; 
; This function will still send events and change globals as if it was successful, even when it fails. This is so to
; prevent failing from blocking quests and scenes to proceed.
; 
Bool Function SingleFileTo(ObjectReference akDestination, Actor akMaster = None, Actor akExtra1 = None, Actor akExtra2 = None, String asMessage = "")
	Log("SingleFileTo")
	sLeashMessage = asMessage
	If akMaster == None || akDestination == None
		Log("No master assigned", akMaster == None, iError)
		Log("None destination specified.", akDestination == None, iError)
		StopLeash()
		Return False
	EndIf

	SetAllDefaults()
	SetAllActors(akMaster, akExtra1, akExtra2)
	SetDestination(akDestination)
	SetSingleFilePackages()

	StartLeash("SingleFileTo", asMessage = asMessage)
	Return True
EndFunction

; Terminates the leash functionality.
; 
; This function sends a "ZapSlaveLeashDone" event even if the leash was not running before.
; 
; This method is automatically called when arriving at the leash destination, so does not have
; to be called manually. If called manually, it stops leash functionality immediately, without
; moving actors to the final targets.
; 
Function StopLeash()
	Log("StopLeash")

	zbfSlaveLeashStatus.SetValueInt(iDoneValue)
	LeashRef = None

	UnregisterForControl("Forward")
	UnregisterForControl("Back")
	UnregisterForControl("Strafe Left")
	UnregisterForControl("Strafe Right")

	SendDoneEvent(sLeashMessage)
	ClearAllPackages()
	ClearAllAliases()

	GoToState("Idle")
EndFunction

; Turns on distance polling, continuously checking distance and turning on/off ai.
; 
; Call ::StopLeash to turn off this behavior, and stop the leash from running.
; 
; This method is automatically called by ::SingleFileTo and ::TravelTo and does not need to be called 
; manually. It's included here for additional customization that one may want to do.
; 
; An optional asMessage is provided that will be sent with the events after leash is done (or failed to
; start).
; 
Function StartLeash(String asMethod, String asMessage = "", Int aiDoneValue = 2)
	Log("StartLeash (" + asMethod + ") reporting " + aiDoneValue + " and message \"" + asMessage + "\" when done.")
	Log("StartLeash: Unsuitable aiDoneValue. Should be greater than or equal to 2.", aiDoneValue < 2, iWarning)

	sLeashMessage = asMessage

	Actor master = Alias_Master.GetActorReference()
	If LeashRef == None
		LeashRef = master
	EndIf
	If LeashRef == None
		LeashRef = Alias_Destination.GetReference()
	EndIf
	Log("Leash holder was set to None when leash was started and no fall back was available.", LeashRef == None, iError)

	RegisterForModEvent("ZapSlaveLeashMove", "OnSlaveLeashMove")
	RegisterForModEvent("ZapSlaveLeashDone", "OnSlaveLeashDone")

	Heartbeat() ; First update of all internals, needs to be done here.
	fLastForceTime = 0
	fLastFreeTime = 0
	iDoneValue = aiDoneValue
	zbfSlaveLeashStatus.SetValueInt(1)

	fLeashSlack = 0.0
	If fLeashLength > fMaxLeashLength
		fLeashSlack = fLeashLength - fMaxLeashLength + 10.0
	EndIf

	RegisterForControl("Forward")
	RegisterForControl("Back")
	RegisterForControl("Strafe Left")
	RegisterForControl("Strafe Right")

	SendMoveEvent(asMethod, asMessage = sLeashMessage)
	GoToState("Running")
EndFunction

; Immediately skips ahead.
; 
; This will move all actors to the specified destination. 
; 
Function SkipToDestination()
	ObjectReference destination = Alias_Destination.GetReference()
	Log("SkipToDestination")
	Log("Skip failed, no destination specified.", destination == None, iError)
	Log("Leash not running.", GetLeashStatus() <= 0, iError)

	Alias_Master.TryToMoveTo(destination)
	Alias_Slave.TryToMoveTo(destination)
	Alias_Extras[0].TryToMoveTo(destination)
	Alias_Extras[1].TryToMoveTo(destination)
EndFunction

; Checks the status of leash control, if it's currently running and so on.
; 
; Events are sent on status change.
; ZapSlaveLeashDone - Movement is complete, and any scene involved with force moving can continue now.
; ZapSlaveLeashMove - Movement has started.
; 
; The events one should listen to are ZapSlaveLeashDone and ZapSlaveLeashMove. More events may be added later on.
; 
; ::zbfSlaveLeashStatus contains the status of the slave leash.
; 0 - No status, idle or not running
; 1 - Moving
; 2 - Done
; custom - Custom done code.
; 
; Custom "done values" can be used (see ::StartLeash) to prevent race conditions when running fragments in Scenes.
; 
GlobalVariable Property zbfSlaveLeashStatus Auto
Int Property iDoneValue Auto Hidden
Int Function GetLeashStatus()
	Return zbfSlaveLeashStatus.GetValueInt()
EndFunction

; @section: References
; 
; These functions provide a more fine grained control over actors and object references than what is 
; otherwise provided. They are not necessary to use, but can be used to further customize behavior.
; 

; Sets akActor as the master.
; 
; Master is used as the leader when leashing the player to some destination. If no leash reference is
; set (see ::SetLeashRef), the master will be holding the player's leash when the system starts up.
; 
; If akActor is set to None, the function clears the current master.
; 
Function SetMaster(Actor akActor)
	Log("SetMaster on " + akActor)
	Alias_Master.Clear()
	If akActor != None
		Alias_Master.ForceRefTo(akActor)
	EndIf
EndFunction

; Sets the specified object as the destination.
; 
; Can not specify a None object. To place the destination at a specific place use the function ::SetDestination
; instead.
; 
Function SetDestinationReference(ObjectReference akTarget)
	Log("SetDestination to " + akTarget)
	Log("Can't specify a None location.", akTarget == None)
	If akTarget != None
		Alias_Destination.ForceRefTo(akTarget)
	EndIf
EndFunction

; Sets the current destination at the object location.
; 
; This function does not track the reference marker if it moves. Internally it uses it's own marker for keeping track
; of where to go. This marker is moved to the new location. Use ::SetDestinationReference if you want the location to track
; movements of the specified object.
; 
Function SetDestination(ObjectReference akTarget)
	Log("SetDestinationAt")
	Log("Can't specify a None location.", akTarget == None)
	If akTarget != None
		OrigLeashMarker.MoveTo(akTarget)
		Alias_Destination.ForceRefTo(OrigLeashMarker)
	EndIf
EndFunction

; Set the extra guards and other actors
; 
Function SetExtras(Actor akExtra1 = None, Actor akExtra2 = None)
	Log("SetExtras " + akExtra1 + " and " + akExtra2)
	Int index = 0
	If akExtra1 != None
		Alias_Extras[index].ForceRefTo(akExtra1)
		index += 1
	EndIf
	If akExtra2 != None
		Alias_Extras[index].ForceRefTo(akExtra2)
		index += 1
	EndIf
	While index < Alias_Extras.Length
		Alias_Extras[index].Clear()
		index += 1
	EndWhile
EndFunction

; Sets the target that holds the players leash.
; 
; The leash reference determines how far the player is from where she is expected to be. For instance,
; when following the master, the player is supposed to stay close to the master. If the player is instead forced
; to move to a particular location (eg. inside a cage), the inside of the cage is the leash holder.
; 
; This is separate for destination when the master is leashing the player, but leash reference and destination
; is normally in the same spot when the player is forced moved without a master.
; 
Function SetLeashRef(ObjectReference akObj)
	LeashRef = akObj
EndFunction



; @section: Settings
; 
; Options for configuring behavior of the leash system. These options are mirrored in MCM, and changes here
; will overwrite the options in MCM, and the other way around. The method ::SetAllDefaults deserves special
; mention as it will overwrite all settings with their default values.
; 
; For most setups, the default values will work fine, and no settings will need to be changed.
; 

; Sets up basic ranges
; 
; afForceAiDistance - When the leash stretches further than this, AI is forced on.
; afTeleportDistance - When the leash is further than this, the player is teleported to the leash reference.
; 
Float Property fMaxLeashLength Auto Hidden
Float Property fTeleportDistance Auto Hidden
Function SetDistances(Float afForceAiDistance = 300.0, Float afTeleportDistance = 1000.0)
	fMaxLeashLength = afForceAiDistance
	fTeleportDistance = afTeleportDistance
EndFunction

; Sets cooldown for control interrupts
; 
; Ai controls can be interrupted by pressing a movement button. This function sets the cooldown
; of these controls. Normally, once the ai has been turned on or off, it should not be able to switch
; back to the previous state right away. These parameters control those timings.
; 
; Brief parameter description:  
; - afMinAiTime: Minimum time that AI stays turned on after receiving control.
; - afMinInterruptTime: Minimum time that AI stays off after losing control due to input (or other reasons).
; 
Float Property fMinAiTime Auto Hidden
Float Property fMinInterruptTime Auto Hidden
Function SetControlInterrupt(Float afMinAiTime = 4.0, Float afMinInterruptTime = 2.0)
	fMinAiTime = afMinAiTime
	fMinInterruptTime = afMinInterruptTime
EndFunction

; Upon arrival, turn on ai for x seconds
; 
; After getting within distance units from the destination, ai is turned on for x seconds. By default, this
; behavior is not used and ai is not turned on at the end of a leash.
; 
Float Property fArrivalDistance Auto Hidden
Float Property fArrivalTime Auto Hidden
Float Property fArrivalLeash Auto Hidden
Function SetArrival(Float afDistance = 200.0, Float afTime = 0.0)
	fArrivalDistance = afDistance
	fArrivalTime = afTime
	fArrivalLeash = afDistance
	If fArrivalLeash < 200.0
		fArrivalLeash = 200.0
	EndIf
EndFunction

; Specifies fast transport mode
; 
; For skipping ahead using scripting, consider using ::SkipToDestination instead. It's used internally, and does not change any
; behavior the user may have configured through MCM.
; 
; ::zbfSlaveLeashSkip controls skipping to the destination. This can also be accomplished by calling ::SkipToDestination()
; 0 - No action		Use method ::SetSkipMode(::iSkipModeNever) to trigger this behavior, or set ::zbfSlaveLeashSkip manually.
; 1 - Skip once		Use method ::SetSkipMode(::iSkipModeOnce) to trigger this behavior, or set ::zbfSlaveLeashSkip manually.
; 2 - Skip always	Use method ::SetSkipMode(::iSkipModeAlways) to trigger this behavior, or set ::zbfSlaveLeashSkip manually.
; 
GlobalVariable Property zbfSlaveLeashSkip Auto
Int Property iSkipModeNever = 0 AutoReadOnly
Int Property iSkipModeOnce = 1 AutoReadOnly
Int Property iSkipModeAlways = 2 AutoReadOnly
Function SetSkipMode(Int iMode)
	zbfSlaveLeashSkip.SetValueInt(iMode)
EndFunction

; Set all values to default.
; 
; Set all values to their default configuration, clear all packages, restore module for running again.
; 
Function SetAllDefaults()
	ClearAllPackages()
	SetDistances()
	SetControlInterrupt()
	SetArrival()
EndFunction


; @section: AI packages
; 
; Section used to force actors into the right AI packages.  
; Not necessary to call for normal operation, but can be used to further customize behavior.
; 

; Clears all AI assignments
; 
; Packages are assigned to the Reference Aliases in the main quest. Clearing out the aliases means that no
; packages are assigned to any actors.
; 
Function ClearAllPackages()
	Log("Leash is still running. Scenes may break.", GetLeashStatus() == 1, iError)

	Travel[0].Clear()
	Travel[1].Clear()
	SingleFile[0].Clear()
	SingleFile[1].Clear()
	SingleFile[2].Clear()
	SingleFile[3].Clear()
	SimpleFollowMaster.Clear()
EndFunction

; Clears out all aliases for the next run to work properly.
; 
Function ClearAllAliases()
	Alias_Master.Clear()
	Int i = Alias_Extras.Length
	While i > 0
		i -= 1
		Alias_Extras[i].Clear()
	EndWhile
	Alias_Destination.ForceRefTo(OrigLeashMarker)
EndFunction

; Master travels with the player to the destination.
; 
; If too far away master will run back to the player.
; 
Function SetTravelPackages()
	Travel[0].ForceRefTo(Alias_Master.GetActorReference())
	Travel[1].ForceRefTo(Alias_Slave.GetActorReference())
	TransferRefIfFilled(Alias_Extras[0], SingleFile[2])
	TransferRefIfFilled(Alias_Extras[1], SingleFile[3])
EndFunction

; Master and player and extras travel single file to the destination.
; 
Function SetSingleFilePackages()
	SingleFile[0].ForceRefTo(Alias_Master.GetActorReference())
	SingleFile[1].ForceRefTo(Alias_Slave.GetActorReference())
	TransferRefIfFilled(Alias_Extras[0], SingleFile[2])
	TransferRefIfFilled(Alias_Extras[1], SingleFile[3])
EndFunction

; Player follows the master.
; 
; The player is assigned a package where she follows the master around.
; 
Function SetSimpleFollowPackages()
	SimpleFollowMaster.ForceRefTo(Alias_Slave.GetActorReference())
EndFunction

; @section States

Event OnControlDown(String asControl)
	; By default no action
EndEvent

Event OnSlaveLeashMove(String asMethod, String asMessage, Form akMasterForm, Form akPrisonerForm)
	Log("OnSlaveLeashMove event (" + asMethod + ") with message " + asMessage + ".")
EndEvent

Event OnSlaveLeashDone(String asMessage, Form akMasterForm, Form akPrisonerForm)
	Log("OnSlaveLeashDone event with message " + asMessage + ".")
EndEvent

Float Function GetDistance(ObjectReference akObj1, ObjectReference akObj2)
	If akObj1 == None || akObj2 == None
		Return MaxFloat
	EndIf

	Float distance = akObj1.GetDistance(akObj2)
	If distance > MaxFloat
		Return MaxFloat
	EndIf
	Return distance
EndFunction

Function RunStateMachine(Float afDistanceToDestination, Float afLeashLength, Float afTime)
	If False	; To make it easier to rearrange.....

	ElseIf zbfSlaveLeashSkip.GetValueInt() >= 1
		If zbfSlaveLeashSkip.GetValueInt() == iSkipModeOnce
			SetSkipMode(iSkipModeNever)
		EndIf
		SkipToDestination()

	ElseIf afLeashLength >= fTeleportDistance + fLeashSlack
		ObjectReference target = Alias_Master.GetReference()
		If target == None
			target = Alias_Destination.GetReference()
		EndIf

		Alias_Slave.TryToMoveTo(target)
		GoToState("Running")

	ElseIf afLeashLength >= fMaxLeashLength + fLeashSlack && bCanForce
		GoToState("ForceControl")

	ElseIf afDistanceToDestination < fArrivalDistance && afLeashLength < fArrivalLeash
		GoToState(sArrivalState)

	EndIf
EndFunction

; Function gathers data on distance to targets, and registers the current time
; 
Float fLeashLength	; Current distance between the Leash reference and the player
Float fDistanceToDestination	; Distance between the traveller (usually master) and destination
Float fLeashSlack	; Extra slack allowed the player
Float fTime
Bool bCanInterrupt
Bool bCanForce
Bool bCanArrive
String sArrivalState
Function Heartbeat()
	Actor slave = Alias_Slave.GetActorReference()
	Actor master = Alias_Master.GetActorReference()
	Actor traveller = master
	If traveller == None
		traveller = slave
	EndIf

	fLeashLength = GetDistance(LeashRef, slave)
	fDistanceToDestination = GetDistance(Alias_Destination.GetReference(), traveller)
	fTime = Game.GetRealHoursPassed() * 3600.0

	; Make sure slack is continually decreasing
	If fLeashSlack > fLeashLength
		fLeashSlack = fLeashLength
	EndIf
	If fLeashSlack < fMaxLeashLength - 10.0
		fLeashSlack = 0.0	; No longer needed
	EndIf

	bCanInterrupt = fTime > fMinAiTime + fLastFreeTime
	bCanForce = fTime > fMinInterruptTime + fLastForceTime
	bCanArrive = fArrivalTime > 0.0

	sArrivalState = "Stopping"
	If bCanArrive
		sArrivalState = "Arrival"
	EndIf
EndFunction

; State when nothing is supposed to be happening.
; 
; It's expected that no events are firing and so on.
; 
Auto State Idle
	Event OnBeginState()
		Log("Idle state")
	EndEvent
EndState

State Running
	Event OnBeginState()
		Log("Running state")
		RegisterForSingleUpdate(0.1)
	EndEvent

	Event OnEndState()
		fLastFreeTime = fTime
	EndEvent

	Event OnUpdate()
		Heartbeat()
		RunStateMachine(fDistanceToDestination, fLeashLength, fTime)
		RegisterForSingleUpdate(fUpdateInterval)
	EndEvent
EndState

Float fLastForceTime
Float fLastFreeTime
State ForceControl
	Event OnBeginState()
		Log("ForceControl state")

		zbf.RetainAi()
		RegisterForSingleUpdate(0.1)
	EndEvent

	Event OnEndState()
		zbf.ReleaseAi()
		fLastForceTime = fTime
	EndEvent

	Event OnUpdate()
		Heartbeat()
		RunStateMachine(fDistanceToDestination, fLeashLength, fTime)
		RegisterForSingleUpdate(fUpdateInterval)
	EndEvent

	Event OnControlDown(String asControl)
		; Ready to accept a new "break ai" event?
		If bCanInterrupt
			GoToState("Running")
			Game.SetPlayerAIDriven(False)
		EndIf
	EndEvent
EndState

Float fArrivalTime
Float fStartArrivalTime
State Arrival
	Event OnBeginState()
		Log("Arrival state")
		zbf.RetainAi()
		fStartArrivalTime = fTime
		RegisterForSingleUpdate(fUpdateInterval)
	EndEvent

	Event OnEndState()
		zbf.ReleaseAi()
	EndEvent

	Event OnUpdate()
		Heartbeat()

		If fTime > fStartArrivalTime + fArrivalTime
			GoToState("Stopping")
			Return
		EndIf

		RegisterForSingleUpdate(fUpdateInterval)
	EndEvent
EndState

State Stopping
	Event OnBeginState()
		Log("Stopping state")
		StopLeash()
	EndEvent

	Event OnEndState()
	EndEvent
EndState


; @section: Private
; 
; Module private functions and events here

String sLeashMessage
ObjectReference Property LeashRef Auto Hidden			; Object to which distance is measured. Usually set to the master.

; Convenience function used internally to set up all actors.
; 
; Does not set the master if akMaster is set to None.
; 
Function SetAllActors(Actor akMaster, Actor akExtra1 = None, Actor akExtra2 = None)
	SetMaster(akMaster)
	SetExtras(akExtra1, akExtra2)
EndFunction

Function TransferRefIfFilled(ReferenceAlias akSource, ReferenceAlias akTarget)
	If akSource.GetRef() != None
		akTarget.ForceRefTo(akSource.GetRef())
	EndIf
EndFunction

Function SendMoveEvent(String asMoveMethod, String asMessage)
	Int iEvent = ModEvent.Create("ZapSlaveLeashMove")
	If iEvent > 0
		ModEvent.PushString(iEvent, asMoveMethod)
		ModEvent.PushString(iEvent, asMessage)
		ModEvent.PushForm(iEvent, Alias_Master.GetActorReference())
		ModEvent.PushForm(iEvent, Alias_Slave.GetActorReference())
		ModEvent.Send(iEvent)
	EndIf
EndFunction

Function SendDoneEvent(String asMessage)
	Int iEvent = ModEvent.Create("ZapSlaveLeashDone")
	If iEvent > 0
		ModEvent.PushString(iEvent, asMessage)
		ModEvent.PushForm(iEvent, Alias_Master.GetActorReference())
		ModEvent.PushForm(iEvent, Alias_Slave.GetActorReference())
		ModEvent.Send(iEvent)
	EndIf
EndFunction

Int Property iDebugLevel Auto Hidden
Int iForce = -1
Int iError = 0
Int iWarning = 1
Int iInfo = 2
String sFilePrefix = "zbfSlaveLeash: "
Function Log(String asMessage, Bool abCondition = True, Int aiLevel = 2)
	If abCondition && (aiLevel <= iDebugLevel)
		Debug.Trace(sFilePrefix + asMessage)
	EndIf
EndFunction
