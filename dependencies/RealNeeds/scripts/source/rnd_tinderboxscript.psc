Scriptname RND_TinderboxScript extends ObjectReference  
{this script starts a campire if player has firewood}

Int DoOnce = 0

Event OnLoad()

	If DoOnce == 0
		DoOnce = 1
		Float AngleZ = Game.GetPlayer().GetAngleZ()
		Self.MoveTo(Game.GetPlayer(), 60 * Math.Sin(AngleZ), 60 * Math.Cos(AngleZ), 20)
		Self.SetAngle(0, 0, AngleZ)
	EndIf
	BlockActivation()
EndEvent

Event OnActivate(ObjectReference akActionRef)  

	If (akActionRef == Game.GetPlayer())
		
		If Game.GetPlayer().IsSneaking()
		
			Self.BlockActivation()
			If Game.GetPlayer().GetItemCount(Firewood01) >= 3

				Game.GetPlayer().removeItem(Firewood01,3)
				Self.PlaceAtMe(RND_Campfire)
				
				If Utility.RandomInt(1,10) >= 1
					DoOnce = 0
					Self.Activate(Game.GetPlayer(), True)
				Else
					Self.Delete()
				EndIf
			Else
				RND_CampfireNeedsFirewood.Show()
				DoOnce = 0
				Self.Activate(Game.GetPlayer(), True)
			EndIf
			
		Else
			; pick up the Tinderbox
			DoOnce = 0
			Self.Activate(Game.GetPlayer(), True)
		Endif
	Endif
EndEvent

MiscObject Property Firewood01  Auto  

Furniture Property RND_Campfire  Auto

Message Property RND_CampfireNeedsFirewood Auto

