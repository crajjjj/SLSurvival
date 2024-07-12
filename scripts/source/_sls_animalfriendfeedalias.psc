Scriptname _SLS_AnimalFriendFeedAlias extends ReferenceAlias  

Event OnInit()
	RegisterForMenu("GiftMenu")
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	If akSourceContainer == PlayerRef
		Friend.GotFed(Self.GetReference() as Actor, akBaseItem, aiItemCount)
	EndIf
EndEvent

Event OnMenuClose(String MenuName)
	Self.GetOwningQuest().Stop()
EndEvent

Actor Property PlayerRef Auto

_SLS_AnimalFriend Property Friend Auto
