Scriptname RND_BedrollScript extends ObjectReference  
{this script handles the bedroll}

MiscObject property RND_PortableBedroll Auto

Int DoOnce = 0

Event OnLoad()
	BlockActivation()
EndEvent

Event OnActivate(ObjectReference akActionRef)
	
	If (akActionRef == Game.GetPlayer())

		If (Game.GetPlayer().IsSneaking())
			If DoOnce == 0
				DoOnce = 1
				Self.Disable(True)
				Self.Delete()
				Game.GetPlayer().AddItem(RND_PortableBedroll)
			EndIf
		Else
			; sleep
			Self.Activate(Game.GetPlayer(), True)
		Endif
	Endif

EndEvent

