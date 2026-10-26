Scriptname _SLS_Knock Hidden
{Begging a house owner for a bed through a knock mod's door dialogue, for whichever knock mod's
SLS patch is installed: SL Survival - Simply Knock.esp or SL Survival - Simpler Knock.esp. The
core plugin keeps the beg topics detached; each patch attaches them to its mod's door
conversation. SLS_Main and the dialogue fragments go through here and never name a knock mod.}

; 0 none, 1 Simply Knock, 2 Simpler Knock. Keyed on SLS's patch, not the knock mod: the patch is
; what puts the beg topics into a conversation, and only one of the two is ever installed.
Int Function KnockMod() Global
	If Game.IsPluginInstalled("SL Survival - Simply Knock.esp")
		Return 1
	ElseIf Game.IsPluginInstalled("SL Survival - Simpler Knock.esp")
		Return 2
	EndIf
	Return 0
EndFunction

; The resident who answered the door.
Actor Function Host() Global
	Int Which = KnockMod()
	If Which == 1
		Return _SLS_IntSimplyKnock.CurrentSpeaker()
	ElseIf Which == 2
		ReferenceAlias HouseOwner = SimplerAlias("HouseOwner")
		If HouseOwner
			Return HouseOwner.GetActorRef()
		EndIf
	EndIf
	Return None
EndFunction

; The door the player knocked on (outside).
ObjectReference Function OutsideDoor() Global
	Int Which = KnockMod()
	If Which == 1
		Return _SLS_IntSimplyKnock.CurrentDoor()
	ElseIf Which == 2
		ReferenceAlias DoorAlias = SimplerAlias("Door")
		If DoorAlias
			Return DoorAlias.GetReference()
		EndIf
	EndIf
	Return None
EndFunction

; The host agreed: open the house to the player as a guest.
Function LetIn() Global
	Int Which = KnockMod()
	If Which == 1
		_SLS_IntSimplyKnock.SetResult_Succeeded()
	ElseIf Which == 2
		; What Simpler Knock's own persuade success does: a guest is not a trespasser, then
		; the door opens and the player goes straight in.
		ObjectReference KnockedDoor = OutsideDoor()
		If !KnockedDoor
			Return
		EndIf
		Cell House = None
		ObjectReference Inside = PO3_SKSEFunctions.GetDoorDestination(KnockedDoor)
		If Inside
			House = Inside.GetParentCell()
		Else
			Actor Owner = Host()
			If Owner
				House = Owner.GetParentCell()
			EndIf
		EndIf
		If House
			House.SetPublic()
		EndIf
		KnockedDoor.Lock(false, true)
		Utility.Wait(0.2)
		KnockedDoor.Activate(Game.GetPlayer())
	EndIf
EndFunction

; The player refused the host's terms.
Function Refused() Global
	If KnockMod() == 1
		; Simply Knock refuses this door for a while ("initially failed").
		_SLS_IntSimplyKnock.SetResult_FailedInitial()
	EndIf
EndFunction

; The inside door of akOutsideDoor, once the player has come through it.
ObjectReference Function InsideDoor(ObjectReference akOutsideDoor) Global
	ObjectReference Inside = None
	If KnockMod() == 1
		ReferenceAlias Linked = _SLS_IntSimplyKnock.LinkedDoorAlias()
		If Linked
			Inside = Linked.GetReference()
		EndIf
	EndIf
	If !Inside && akOutsideDoor
		Inside = PO3_SKSEFunctions.GetDoorDestination(akOutsideDoor)
	EndIf
	If !Inside
		; Without Papyrus Extender: the player has just arrived through it.
		Inside = NearestDoorToPlayer()
	EndIf
	Return Inside
EndFunction

; SLS locks the inside door for the stay. Simply Knock would unlock it again whenever it is
; locked with the player inside, so take it out of Simply Knock's alias.
Function HoldDoor() Global
	If KnockMod() == 1
		ReferenceAlias Linked = _SLS_IntSimplyKnock.LinkedDoorAlias()
		If Linked
			Linked.Clear()
		EndIf
	EndIf
EndFunction

ReferenceAlias Function SimplerAlias(String asName) Global
	Quest KnockQuest = Quest.GetQuest("aaaknockknock")
	If KnockQuest
		Return KnockQuest.GetAliasByName(asName) as ReferenceAlias
	EndIf
	Return None
EndFunction

ObjectReference Function NearestDoorToPlayer() Global
	Actor PlayerRef = Game.GetPlayer()
	Cell Here = PlayerRef.GetParentCell()
	If !Here
		Return None
	EndIf
	ObjectReference Best = None
	Float BestDistance = 0.0
	Int i = Here.GetNumRefs(29) ; kDoor
	While i > 0
		i -= 1
		ObjectReference Ref = Here.GetNthRef(i, 29)
		If Ref
			Float Distance = Ref.GetDistance(PlayerRef)
			If !Best || Distance < BestDistance
				Best = Ref
				BestDistance = Distance
			EndIf
		EndIf
	EndWhile
	Return Best
EndFunction
