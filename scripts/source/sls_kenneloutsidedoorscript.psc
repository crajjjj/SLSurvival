Scriptname SLS_KennelOutsideDoorScript extends ObjectReference  

Event OnActivate(ObjectReference akActionRef)
	If !Self.IsLocked() && akActionRef == Game.GetPlayer()
		SendModEvent("dhlp-Suspend")
		Int DoorIndex = (Game.GetFormFromFile(0x0D2A67, "SL Survival.esp") as Formlist).Find(Self)
		SwapStash(DoorIndex)
		Menu.LocTrack.SetPlayerKennelLocation(DoorIndex)
		ShuffleDoors(DoorIndex)

		If Menu.KennelFollowerToggle
			;Utility.Wait(3.0) ; Give time to animate door and transition
			_SLS_FollowerSearch.Start()
			Int i = 0
			ReferenceAlias FollowerAlias
			While i < _SLS_FollowerSearch.GetNumAliases()
				FollowerAlias = (_SLS_FollowerSearch.GetNthAlias(i) as ReferenceAlias)
				If FollowerAlias.GetReference() == None
					i = _SLS_FollowerSearch.GetNumAliases()
				Else
					(FollowerAlias as SLS_KennelFollowerDisable).DisableFollower()
					StorageUtil.SetFloatValue(None, "_SLS_KennelEnterTime", Utility.GetCurrentGameTime())
				EndIf
				i += 1
			EndWhile
		EndIf
		_SLS_OnLocChangeDlhpResumeQuest.Start()
	EndIf
EndEvent

Function SwapStash(Int DoorIndex)
	ObjectReference SrcCont = (Game.GetFormFromFile(0x10F2AA, "SL Survival.esp") as Formlist).GetAt(DoorIndex) as ObjectReference
	ObjectReference DestCont = Game.GetFormFromFile(0x10F2A0, "SL Survival.esp") as ObjectReference
	;Debug.Messagebox("Src: " + SrcCont + "\nDest: " + DestCont)
	SrcCont.RemoveAllItems(akTransferTo = DestCont, abKeepOwnership = true, abRemoveQuestItems = true)
EndFunction

Function ShuffleDoors(Int DoorIndex)
	;Formlist OutsideDoors = Game.GetFormFromFile(0x0D2A67, "SL Survival.esp") as Formlist
	Formlist InsideDoors = Game.GetFormFromFile(0x0D2A66, "SL Survival.esp") as Formlist

	; Has enabled door changed? If so restock creature cum
	ObjectReference EnabledDoor = GetEnabledDoor(InsideDoors)

	; Enable correct door. Disable all others
	;Int i = OutsideDoors.Find(Self)
	If DoorIndex >= 0
		Int j = 0
		While j < InsideDoors.GetSize()
			(InsideDoors.GetAt(j) as ObjectReference).Disable()
			j += 1
		EndWhile
		;Debug.Messagebox(InsideDoors.GetAt(DoorIndex))
		(InsideDoors.GetAt(DoorIndex) as ObjectReference).Enable()
	Else
		Debug.Messagebox("Kennel door not found in list")
	EndIf
	
	; Has enabled door changed? If so restock creature cum
	Utility.Wait(3.0) ; Give time to animate door and transition. Moved from up above ^^^^^^
	If EnabledDoor != GetEnabledDoor(InsideDoors)
		(Game.GetFormFromFile(0x0D3547, "SL Survival.esp") as Quest).Stop()
		(Game.GetFormFromFile(0x0D3547, "SL Survival.esp") as Quest).Start()
	;	Debug.Messagebox("Restock cum")
	;Else
	;	Debug.Messagebox("DON'T Restock cum")
	EndIf
EndFunction

ObjectReference Function GetEnabledDoor(Formlist InsideDoors)
	Int i = 0
	While i < InsideDoors.GetSize()
		If (InsideDoors.GetAt(i) as ObjectReference).IsEnabled()
			Return InsideDoors.GetAt(i) as ObjectReference
		EndIf
		i += 1
	EndWhile
EndFunction

Quest Property _SLS_FollowerSearch Auto
Quest Property _SLS_OnLocChangeDlhpResumeQuest Auto

SLS_Mcm Property Menu Auto
