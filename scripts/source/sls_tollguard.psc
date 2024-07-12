Scriptname SLS_TollGuard extends ObjectReference

ReferenceAlias Property AssociatedDoor Auto

Function PaidGuard()
	TollUtil.TollPaid(AssociatedDoor.GetReference(), false)
EndFunction

Event OnActivate(ObjectReference akActionRef)
	TollUtil.GuardActivate(Self)
EndEvent

_SLS_TollUtil Property TollUtil Auto
