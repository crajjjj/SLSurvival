Scriptname SLS_BedrollScript extends ObjectReference  
{this script handles the bedroll}

MiscObject property RND_PortableBedroll Auto
Actor Property PlayerRef Auto

Int DoOnce = 0

Event OnLoad()
	BlockActivation()
	RegisterForSingleUpdateGameTime(12.0)
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

Event OnUpdateGameTime()
	If !PlayerRef.GetCurrentLocation().IsSameLocation(Self.GetCurrentLocation())
		Self.Disable()
		Self.Delete()
	Else
		RegisterForSingleUpdateGameTime(6.0)
	EndIf
EndEvent