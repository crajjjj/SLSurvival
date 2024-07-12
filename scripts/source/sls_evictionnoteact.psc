Scriptname SLS_EvictionNoteAct extends ObjectReference  

Event OnActivate(ObjectReference akActionRef)
	ObjectReference Note = PlayerRef.PlaceAtMe(_SLS_EvictionNotice)
	TransferBin.AddItem(Note)
	;TransferBin.RemoveItem(Note, 1, false, PlayerRef)
	Note.Activate(PlayerRef)
	Init.LastReadEvictionNotice = self
EndEvent

Actor Property PlayerRef Auto
Book Property _SLS_EvictionNotice Auto
SLS_Init Property Init Auto
ObjectReference Property TransferBin  Auto  
