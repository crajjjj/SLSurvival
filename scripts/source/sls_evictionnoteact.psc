Scriptname SLS_EvictionNoteAct extends ObjectReference  

Event OnActivate(ObjectReference akActionRef)
	ObjectReference Note = PlayerRef.PlaceAtMe(_SLS_EvictionNotice)
	; Read the note first. The old code moved it into TransferBin and only then called Activate,
	; and a book that sits in a container cannot be opened - so the notice never showed and one copy piled up in the
	; bin per click. Book Menu pauses the game, so the Wait below returns only after the player closes it.
	Note.Activate(PlayerRef)
	Utility.Wait(0.1)
	If Note.GetParentCell() ; still in the world (not taken from the book menu): tidy the copy away
	TransferBin.AddItem(Note)
	EndIf
	Init.LastReadEvictionNotice = self
EndEvent

Actor Property PlayerRef Auto
Book Property _SLS_EvictionNotice Auto
SLS_Init Property Init Auto
ObjectReference Property TransferBin  Auto  
