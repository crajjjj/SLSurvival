Scriptname _SLS_LicFollowerEnforcementDumb extends ReferenceAlias  

Event OnInit()
	If Game.GetModByName("EFFCore.esm") != 255
		FollowerInventoryContainer = Game.GetFormFromFile(0x0031F3, "EFFCore.esm")
		EffInstalled = true
	EndIf
	AddInventoryEventFilter(_SLS_NeverAddedItem)
	RegisterForMenu("ContainerMenu")
EndEvent

Event OnMenuOpen(String MenuName)
	DidTradeWithFollower = false
	Follower = None
	CrosshairRef = None
	RemoveAllInventoryEventFilters()
EndEvent

Event OnMenuClose(String MenuName)
	AddInventoryEventFilter(_SLS_NeverAddedItem)
	If DidTradeWithFollower
		Utility.Wait(1.0)
		If Follower as Actor
			CrosshairRef = Follower as Actor
		EndIf
		;	LicUtil.DumbFollowerEnforceActor(Follower as Actor, PlayerRef, true)
		;Else
			LicUtil.DumbFollowerEnforceObjRef(Follower, CrosshairRef, PlayerRef, true)
		;EndIf
	EndIf
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	;Debug.Messagebox("Event: " + "\nItem: " + akBaseItem + "\nakDest: " + akDestContainer)
	If akDestContainer
		AddInventoryEventFilter(_SLS_NeverAddedItem)
		If IsNormalFollower(akDestContainer)
			;Debug.Messagebox("Did trade")
			Follower = akDestContainer
			DidTradeWithFollower = true
			
		ElseIf IsStupidEffFollower(akDestContainer) ; Did I mention that i hate EFF?
			CrosshairRef = Game.GetCurrentCrosshairRef() as Actor
			;Debug.Messagebox("Did trade EFF")
			Follower = akDestContainer
			DidTradeWithFollower = true
		EndIf
	EndIf
EndEvent

Bool Function IsNormalFollower(ObjectReference akDestContainer)
	Actor akTarget = akDestContainer as Actor
	If akTarget
		;Debug.Messagebox("Object: " + akDestContainer + "\nName: " + akTarget.GetBaseObject().GetName() + "\nFaction: " + akTarget.IsInFaction(CurrentFollowerFaction))
		If akTarget.IsInFaction(CurrentFollowerFaction) && !akTarget.IsDead()
			Return true
		EndIf
	EndIf
	Return false
EndFunction

Bool Function IsStupidEffFollower(ObjectReference akDestContainer)
	If (EffInstalled && akDestContainer.GetBaseObject() == FollowerInventoryContainer)
		Return true
	EndIf
	Return false
EndFunction

Bool EffInstalled = false
Bool DidTradeWithFollower = false
ObjectReference Follower
Actor CrosshairRef
Form FollowerInventoryContainer

MiscObject Property _SLS_NeverAddedItem Auto

Actor Property PlayerRef Auto

Faction Property CurrentFollowerFaction Auto

_SLS_LicenceUtil Property LicUtil Auto
