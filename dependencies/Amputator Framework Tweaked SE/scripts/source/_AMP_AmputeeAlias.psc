Scriptname _AMP_AmputeeAlias extends ReferenceAlias  

Event OnLoad()
	;Debug.Messagebox("Loaded: "+ Self.GetReference())
	Main.ReapplyAmputations(Self.GetReference() as Actor)
EndEvent

Event OnGetUp(ObjectReference akFurniture)
	Main.AmputeeGetsUp(Self.GetReference() as Actor, akFurniture)
EndEvent

Event OnDeath(Actor akKiller)
	RegisterForSingleUpdateGameTime(1.0)
EndEvent

Event OnUpdateGameTime()
	Main.RemoveActor(Self.GetReference() as Actor)
EndEvent

_AMP_Main Property Main Auto
_AMP_Mcm Property Menu Auto
