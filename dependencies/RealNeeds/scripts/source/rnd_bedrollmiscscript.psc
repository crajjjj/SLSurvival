Scriptname RND_BedrollMiscScript extends ObjectReference  
{this script handles the bedroll misc item}

Furniture property RND_Bedroll Auto

ObjectReference myBedroll

Event OnLoad()
	BlockActivation()
EndEvent

Event OnActivate(ObjectReference akActionRef)  

	If (akActionRef == Game.GetPlayer())
		
		If Game.GetPlayer().IsSneaking()
			; sneak to unpack the bedroll
			Self.BlockActivation()
			Float PosX = Self.GetPositionX()
			Float PosY = Self.GetPositionY()
			Float PosZ = Game.GetPlayer().GetPositionZ()
			myBedroll = Self.PlaceAtMe(RND_Bedroll)
			myBedroll.SetPosition(PosX, PosY, PosZ - 1)
			myBedroll.SetAngle(0.0, 0.0, Game.GetPlayer().GetAngleZ() - 90)
			Self.Disable(True)
			Self.Delete()	
		Else
			; pick up the bedroll
			Self.Activate(Game.GetPlayer(), True)
		Endif
	Endif
EndEvent
