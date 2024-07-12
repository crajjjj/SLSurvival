Scriptname RND_TentScript extends ObjectReference  

MiscObject property RND_PortableTent Auto

Event OnLoad()
	BlockActivation()
EndEvent

Event OnActivate(ObjectReference akActionRef)
	
	If (akActionRef == Game.GetPlayer())

		If (Game.GetPlayer().IsSneaking())
			; block possible duplication
			Self.BlockActivation()
			Self.Disable(True)
			Self.Delete()
			Game.GetPlayer().AddItem(RND_PortableTent)
		Else
			;Self.Activate(Game.GetPlayer(), True)
		EndIf
	EndIf

EndEvent


