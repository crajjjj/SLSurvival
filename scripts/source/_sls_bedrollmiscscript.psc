Scriptname _SLS_BedrollMiscScript extends ObjectReference  

Furniture property _SLS_BedrollFurn Auto

Actor Property PlayerRef Auto

ObjectReference myBedroll

Event OnLoad()
	BlockActivation()
EndEvent

Event OnActivate(ObjectReference akActionRef)  
	If (akActionRef == PlayerRef)
		If PlayerRef.IsSneaking()
			; sneak to unpack the bedroll
			Self.BlockActivation()
			Float PosX = Self.GetPositionX()
			Float PosY = Self.GetPositionY()
			Float PosZ = PlayerRef.GetPositionZ()
			myBedroll = Self.PlaceAtMe(_SLS_BedrollFurn)
			myBedroll.SetPosition(PosX, PosY, PosZ - 1)
			myBedroll.SetAngle(0.0, 0.0, PlayerRef.GetAngleZ() - 90)
			Self.Disable(True)
			Self.Delete()

		Else
			; pick up the bedroll
			Self.Activate(PlayerRef, True)
		Endif
	Endif
EndEvent

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	If akNewContainer == PlayerRef && StorageUtil.GetIntValue(None, "_SLS_BedrollTutorial") == 1
		StorageUtil.UnSetIntValue(None, "_SLS_BedrollTutorial")
		Debug.Messagebox("You've just received a bedroll\n\nTo use it drop it from your inventory, then sneak and activate it to turn it into a sleeping spot\n\nYou can grab it and move it around before activating it to adjust it's position\n\nDon't worry about cleaning it up. Your 'host' will do that after you leave")
	EndIf
EndEvent

