Scriptname RND_TentMiscScript extends ObjectReference  

Furniture property RND_Tent Auto
Furniture property RND_SleepingCot Auto
MiscObject property RND_PortableBedroll Auto

Float PosX
Float PosY
Float PosZ
Float AngleZ

Int DoOnce = 0

ObjectReference myTent
ObjectReference myBedroll

Event OnLoad()
	If DoOnce == 0
		DoOnce = 1
		AngleZ = Game.GetPlayer().GetAngleZ()
		Self.MoveTo(Game.GetPlayer(), 60 * Math.Sin(AngleZ), 60 * Math.Cos(AngleZ), 25)
		Self.SetAngle(0, 0, AngleZ)
		PosX = Self.GetPositionX()
		PosY = Self.GetPositionY()
		PosZ = Self.GetPositionZ() - 20
	EndIf
	BlockActivation()
EndEvent

Event OnActivate(ObjectReference akActionRef)  

	If (akActionRef == Game.GetPlayer())
		
		If Game.GetPlayer().IsSneaking()
			; sneak to unpack the tent
			Self.BlockActivation()
			
			myTent = Self.PlaceAtMe(RND_Tent)
			myTent.SetAngle(0.0, 0.0, AngleZ - 90)	
			myTent.SetPosition(PosX, PosY, PosZ)
			; player has a bedroll, unpack it
			If Game.GetPlayer().GetItemCount(RND_PortableBedroll) >= 1
				Game.GetPlayer().removeItem(RND_PortableBedroll, 1)
				myBedroll = Self.PlaceAtMe(RND_SleepingCot)
				myBedroll.SetAngle(0.0, 0.0, AngleZ - 90)
				myBedroll.SetPosition(PosX, PosY, PosZ - 2)
			EndIf
			Self.Disable(True)
			Self.Delete()
		Else
			; pick up the tent
			DoOnce = 0
			Self.Activate(Game.GetPlayer(), True)
		Endif
	Endif
EndEvent


