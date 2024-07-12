Scriptname zbfSlaveControl extends Quest

; @section: zbfSlaveControl
; 
; Simple slavery framework. Made to make it easy to share slave states between mods, since they
; all have in common the basis that is ZaZ Animation Pack.
; 

; This faction is set if the actor is to be considered a slave at all by mods.
;
; There are several defined faction ranks at the moment. Please use the api functions
; to detect the actual state of the slave. (For rationale, 
; see http://www.creationkit.com/GetFactionRank_-_Actor)
; 
; - -1: Actor is an escaped slave
; -  0: Actor is a basic slave
; -  1: Actor is a friend to his/her master.
; -  2: Actor is a confidant to his/her master.
; -  3: Actor is an ally to his/her master.
; -  4: Actor is a lover to his/her master.
; 
; Increasing slave rank has no immediate implications, but these levels indicate how slavery can
; progress from involuntary (0) to voluntary (4). These serve as an alternative to relationship
; ranks, which do not persist across saves.
; 
Faction Property zbfFactionSlave Auto

; Indicates that the actor is a master to a slave.
; 
; The system does not check any inconsistencies in detecting actors being both masters and
; slaves at the same time.
; 
; No defined ranks yet.
; 
; The special faction ::zbfFactionPlayerMaster should only be applied on the current owner(s) 
; of the player character. It should always be paired with zbfFactionMaster.
; 
Faction Property zbfFactionMaster Auto
Faction Property zbfFactionPlayerMaster Auto

; Used for cosmetic purposes, ie. things like adding specific dialogue to a particular group
; of people.
; 
; No defined ranks yet.
; 
Faction Property zbfFactionSlaver Auto

; This faction is used to hold data on borrowing, pausing, escaping and so on. Currently not
; very actively used. Ranks are subject to change, so use the api functions. If using this faction
; in conditions, assume that a IsInFaction == True means that it _could_ be a bad idea to mess 
; with the actor.
; 
; - 0: Owned. A mod claims ownership of this actor. Prefer not to touch it.
; - 1: Paused. A mod claims ownership, and will want it back, but feel free to borrow the actor for now.
; - 2: Borrowed. A mod claims ownership, but has paused processing. Yet another mod has borrowed the actor and is doing something right now.
; 
Faction Property zbfFactionSlaveState Auto

; Constants for current ranks
Int iSlaveRankNotFound = -2
Int iSlaveRankEscaped = -1
Int iSlaveRankSlave = 0
Int iSlaveStateNotOwned = -1
Int iSlaveStateOwned = 0
Int iSlaveStatePaused = 1
Int iSlaveStateBorrowed = 2

; Returns the main object for this api.
; 
zbfSlaveControl Function GetApi() Global
	Return zbfUtil.GetGenericForm(0x020096B2) As zbfSlaveControl
EndFunction

; ------------------------------------
; 
; Functions to control slaves and masters.
; 
; ------------------------------------

; Enslaves the player actor.
; 
; If owner is set to None, the player is instead released. This function does not do
; what ::EnslaveActor does, so see that function for further docs on how to use the 
; different slave ranks.
; 
; This method does not add the player to the ::zbFactionSlave faction, because it can not
; know an appropriate level to do so.
; 
ReferenceAlias Property Alias_PlayerMaster Auto
Function SetPlayerMaster(Actor akOwner, String asModName)
	Log("SetPlayerMaster", asModName + " changed ownership of the player to " + zbfUtil.GetActorName(akOwner) + ".")
	GetMutex()

	Alias_PlayerMaster.Clear()
	If akOwner != None
		Alias_PlayerMaster.ForceRefTo(akOwner)
	EndIf

	ReleaseMutex()
EndFunction

; Marks the actor as a slave.
; 
; If the actor is already a slave this function will fail (return False) with no changes.  
; If the actor is an escaped slave, this actor will restore the slave to "not escaped" at the lowest rank.  
; If the actor is not owned by a mod, the slave rank will not be modified.  
; If the function successfully completes, the actor is considered owned.  
; 
; akActor - Actor to enslave
; asModName - Mod trying to enslave the actor
; 
; Returns True if successful. False otherwise.
; 
Bool Function EnslaveActor(Actor akActor, String asModName)
	Log("EnslaveActor", asModName + " requesting control of actor " + zbfUtil.GetActorName(akActor))
	GetMutex()

	Bool bSuccess = False
	Int iSlaveFaction = akActor.GetFactionRank(zbfFactionSlave)
	Int iSlaveState = akActor.GetFactionRank(zbfFactionSlaveState)

	If (iSlaveFaction <= iSlaveRankNotFound) || (iSlaveState == iSlaveStateNotOwned)
		If iSlaveFaction <= iSlaveRankSlave
			akActor.SetFactionRank(zbfFactionSlave, iSlaveRankSlave)
		EndIf
		akActor.SetFactionRank(zbfFactionSlaveState, iSlaveStateOwned)

		bSuccess = True
		SendEvent("EnslaveActor", akActor, asModName)
	EndIf

	ReleaseMutex()
	Return bSuccess
EndFunction

; Release the actor from the slavery system.
; 
; This function completely removes the actor from the slavery system. To just release the actor
; from the currently controlling mod, let the actor escape, or similar, then use ReleaseSlave instead.
; 
Function FreeSlave(Actor akActor, String asModName)
	Log("FreeSlave", asModName + " has released actor " + zbfUtil.GetActorName(akActor) + " from slave control.")
	GetMutex()

	akActor.RemoveFromFaction(zbfFactionSlave)
	akActor.RemoveFromFaction(zbfFactionSlaveState)
	SendEvent("FreeSlave", akActor, asModName)
	ReleaseMutex()
EndFunction

; Releases the slave from the currently controlling mod.
; 
; Another mod may pick up the slave with no change in faction standing using EnslaveActor. Slave can be 
; marked as an escaped slave before releasing, by setting the slave rank to zero. Marking the actor as
; escaped will change the slave rank.
; 
Function ReleaseSlave(Actor akActor, String asModName, Bool abSetEscaped = False)
	Log("ReleaseSlave", "Releasing actor " + zbfUtil.GetActorName(akActor) + " from " + asModName)
	GetMutex()

	If abSetEscaped
		Log("ReleaseSlave", zbfUtil.GetActorName(akActor) + " is now an escaped slave.")
		akActor.SetFactionRank(zbfFactionSlave, iSlaveRankEscaped)
	EndIf
	akActor.SetFactionRank(zbfFactionSlaveState, iSlaveStateNotOwned)
	SendEvent("ReleaseSlave", akActor, asModName)
	ReleaseMutex()
EndFunction

; Is a mod currently owning/controlling this slave?
; 
Bool Function IsOwnedByMod(Actor akActor)
	Return akActor.GetFactionRank(zbfFactionSlaveState) >= iSlaveStateOwned
EndFunction

; Returns True if an actor is considered a slave, including an escaped slave.
; 
Bool Function IsSlave(Actor akActor)
	Return akActor.GetFactionRank(zbfFactionSlave) >= iSlaveRankEscaped
EndFunction

; Is the actor an escaped slave?
; 
Bool Function IsEscapedSlave(Actor akActor)
	Return akActor.GetFactionRank(zbfFactionSlave) == iSlaveRankEscaped
EndFunction

; Is the actor a slave master?
; 
Bool Function IsMaster(Actor akActor)
	Return akActor.GetFactionRank(zbfFactionMaster) >= 0
EndFunction

; Is the actor a slaver?
; 
Bool Function IsSlaver(Actor akActor)
	Return akActor.GetFactionRank(zbfFactionSlaver) >= 0
EndFunction

; Registers to receive all events from the slavery framework (for logging purposes).
; 
; Modders can copy this function and the empty events below to kick start event handling from this module.
; 
; This function also serves as documentation on the various events that the framework can send out.
; 
Function RegisterForEvents()
	Log("RegisterForEvents", "Registering for slavery events.")

	RegisterForModEvent("zbfSC_EnslaveActor", "OnEnslaveActor")
	RegisterForModEvent("zbfSC_FreeSlave", "OnFreeSlave")
	RegisterForModEvent("zbfSC_ReleaseSlave", "OnReleaseSlave")
	; Not yet fully ready to test, don't register these yet.
	;RegisterForModEvent("zbfSC_BorrowSlave", "OnBorrowSlave")
	;RegisterForModEvent("zbfSC_ReturnSlave", "OnReturnSlave")
	;RegisterForModEvent("zbfSC_PauseSlave", "OnPauseSlave")
	;RegisterForModEvent("zbfSC_ResumeSlave", "OnResumeSlave")
EndFunction

Event OnEnslaveActor(Form akTarget, String asMod)
	Actor slave = akTarget As Actor
	Log("OnEnslaveActor", "Module " + asMod + " enslaved actor " + slave.GetName())
EndEvent

Event OnFreeSlave(Form akTarget, String asMod)
	Actor slave = akTarget As Actor
	Log("OnEnslaveActor", "Module " + asMod + " freed actor " + slave.GetName())
EndEvent

Event OnReleaseSlave(Form akTarget, String asMod)
	Actor slave = akTarget As Actor
	Log("OnReleaseSlave", "Module " + asMod + " released actor " + slave.GetName() + " with escaped state set to " + IsEscapedSlave(slave) + ".")
EndEvent


; @section: Work in progress
; 
; Functions that may not make it into the first version of the framework ... 
; 
; Do not rely on these remaining unchanged for now.
; 

; Is this slave paused for processing by its owner?
; 
Bool Function IsSlavePaused(Actor akActor)
	Return akActor.GetFactionRank(zbfFactionSlaveState) == iSlaveStatePaused
EndFunction

; Borrows a slave for temporary processing by another mod. The slave must be paused. Only the controlling mod
; knows when it's safe to pause processing.
; 
Bool Function BorrowSlave(Actor akActor, String asModName)
	Log("BorrowSlave", asModName + " requesting to borrow actor " + zbfUtil.GetActorName(akActor))
	GetMutex()

	Bool bSuccess = False
	Int iSlaveState = akActor.GetFactionRank(zbfFactionSlaveState)
	If iSlaveState == iSlaveStatePaused
		Log("BorrowSlave", "Success on " + zbfUtil.GetActorName(akActor))
		akActor.SetFactionRank(zbfFactionSlaveState, iSlaveStateBorrowed)
		bSuccess = True
		SendEvent("BorrowSlave", akActor, asModName)
	EndIf
	ReleaseMutex()
	Return bSuccess
EndFunction

; 
Bool Function ReturnSlave(Actor akActor, String asModName)
	Log("ReturnSlave", asModName + " requesting to return actor " + zbfUtil.GetActorName(akActor))
	GetMutex()

	Bool bSuccess = False
	Int iSlaveState = akActor.GetFactionRank(zbfFactionSlaveState)
	If iSlaveState == iSlaveStateBorrowed
		akActor.SetFactionRank(zbfFactionSlaveState, iSlaveStatePaused)
		bSuccess = True
		SendEvent("ReturnSlave", akActor, asModName)
	EndIf
	ReleaseMutex()
	Return bSuccess
EndFunction

; Pauses current mod control of this slave.
; 
Bool Function PauseSlave(Actor akActor, String asModName)
	Log("PauseSlave", asModName + " requesting original controller to pause actor " + zbfUtil.GetActorName(akActor))
	GetMutex()

	Bool bSuccess = False
	If IsOwnedByMod(akActor)
		Int iSlaveState = akActor.GetFactionRank(zbfFactionSlaveState)
		If iSlaveState == iSlaveStateOwned
			Log("PauseSlave", "Success on " + zbfUtil.GetActorName(akActor))
			akActor.SetFactionRank(zbfFactionSlaveState, iSlaveStatePaused)
			bSuccess = True
			SendEvent("PauseSlave", akActor, asModName)
		EndIf
	EndIf
	ReleaseMutex()
	Return bSuccess
EndFunction

; Resumes original mod control of this slave.
; 
Bool Function ResumeSlave(Actor akActor, String asModName)
	Log("ResumeSlave", asModName + " requesting original controller to resume control of actor " + zbfUtil.GetActorName(akActor))
	GetMutex()

	Bool bSuccess = False
	If IsOwnedByMod(akActor)
		Int iSlaveState = akActor.GetFactionRank(zbfFactionSlaveState)
		If iSlaveState >= iSlaveStatePaused ; Paused or borrowed
			Log("ResumeSlave", "Success on " + zbfUtil.GetActorName(akActor))
			akActor.SetFactionRank(zbfFactionSlaveState, iSlaveStateOwned)
			bSuccess = True
			SendEvent("ResumeSlave", akActor, asModName)
		EndIf
	EndIf
	ReleaseMutex()
	Return bSuccess
EndFunction

; 
; @section: Private
; 
; Module private functions.
; 

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

Function SendEvent(String asEvent, Actor akTarget, String asMod)
	Log("SendEvent", "Sending event " + asEvent + " from mod " + asMod + ".")

	Int iEvent = ModEvent.Create("zbfSC_" + asEvent)
	ModEvent.PushForm(iEvent, akTarget)
	ModEvent.PushString(iEvent, asMod)
	ModEvent.Send(iEvent)
EndFunction

Int Property iDebugLevel Auto Hidden
Int iForce = -1
Int iError = 0
Int iWarning = 1
Int iInfo = 2
String sFilePrefix = "zbfSlaveControl"
Function Log(String asMethod, String asMessage, Int aiLevel = 2, Bool abCondition = True)
	If abCondition && (aiLevel <= iDebugLevel)
		Debug.Trace(sFilePrefix + " (" + asMethod + "): " + asMessage)
	EndIf
EndFunction
