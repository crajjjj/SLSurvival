Scriptname _SLS_TollDodgeGiftMenu extends ReferenceAlias

_SLS_TollDodge Property TollDodge Auto

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	TollDodge.GiftedItem(akBaseItem, aiItemCount, akDestContainer)
EndEvent
