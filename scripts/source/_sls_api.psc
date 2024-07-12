Scriptname _SLS_Api extends Quest  

; To add a container that should be considered as an extension of the player's inventory (like say a backpack) and that should be searched by the licence system when
; appropriate. Do: 
; StorageUtil.FormListAdd(PlayerRef, "_SLS_LicenceSearchContainers", BackpackObjRef, allowDuplicate = false)
; To remove a container to be searched do:
; StorageUtil.FormListRemove(PlayerRef, "_SLS_LicenceSearchContainers", BackpackObjRef, allInstances = true)

; =================== Received Events =================================================================================
; _SLS_IssueLicence - Issue a licence.
; _SLS_BlockLicenceBuy - Block/Unblock normal licence purchasing from quartermasters.
; _SLS_SendToKennel - Send the player to the kennel.
; _SLS_EvictFromHome - Evict the player from one of the vanilla homes.
; _SLS_UnEvictFromHome: Unevict the player from a home.
; _SLS_IncreaseGroundTime: Increase the amount of time the player should be confined to town.
; _SLS_RevokeLicence: Remove a specific licence from the player. Or all licences. Or a random licence. See the function call for accepted values
; _SLS_RemoveMagicCurse: Add the magic curse for blocking magic to an actor
; _SLS_AddMagicCurse:  Remove the magic curse for blocking magic to an actor
; _SLS_AddStashTracking: Add stash tracking and stealing to a container. See On_SLS_AddStashTracking
; _SLS_RemoveStashTracking: Remove a container from stash stealing. See On_SLS_RemoveStashTracking
; _SLS_AddStashException: Flag a container as a stash exception - No stealing. See On_SLS_AddStashException
; _SLS_RemoveStashException: UnFlag a container as safe - Stealing allowed again. See On_SLS_RemoveStashException
; _SLS_SwallowCum: Trigger a cum swallowing event on the player. See On_SLS_SwallowCum
; _SLS_AddTraumaToPlayer: Add traumas to the player

; =================== Sent Events =====================================================================================
; _SLS_PlayerIsInSlavetown - numArg: 0 - Is not in slavetown, 1 - Is in slavetown
; _SLS_CumHungerChange - numArg: -1 - Cum addiction off, 0 - Satisfied, 1 - Peckish, 2 - Hungry, 3 - Starving, 4 - Ravenous
; _SLS_AuthorativeConvoEnd - Sent after getting a dressing down from a toll guard or enforcer.
; _SLS_LicenceStateUpdateEvent - Sent when a licence changes state or a licence type is toggled on/off.
; _SLS_PlayerSwallowedCum - Sent when the player is involved in a cum swallowing event. See SendCumSwallowEvent

; =================== StorageUtil Variables ===========================================================================
; _SLS_SurvivalVersion - SLS version. See SetVersion() for notes. 
; _SLS_FashionRapeExclusions - A form list of actors that will not do fashion rapes during sex scenes. StorageUtil.FormListAdd(None, "_SLS_FashionRapeExclusions", NiceGuy)
; _SLS_LicenceQuartermastersList - Formlist of licence quartermasters. See SetupQuartermasters() for details.
; HasValidXLicence - See SendLicenceStateUpdateEvent() for details.

; _SLS_LicenceXValidUntil - Until what game day the licence is valid until. Licence durations are rounded up to (period + midnight). Valid variables: 
; _SLS_LicenceMagicValidUntil
; _SLS_LicenceWeaponValidUntil
; _SLS_LicenceArmorValidUntil
; _SLS_LicenceBikiniValidUntil
; _SLS_LicenceClothesValidUntil
; _SLS_LicenceCurfewValidUntil
; _SLS_LicenceWhoreValidUntil
; _SLS_LicenceFreedomValidUntil
; _SLS_LicencePropertyValidUntil
; 
; -1.0 = Doesn't have licence. 
; If StorageUtil.GetFloatValue(None, "_SLS_LicenceMagicValidUntil", -2.0) - Math.Ceiling(Utility.GetCurrentGameTime()) > 0.0 ; Then has a valid magic licence
; 
; StorageUtil.GetFloatValue(None, "_SLS_LicenceBikiniValidUntil", -2.0) - Math.Ceiling(Utility.GetCurrentGameTime()) = Time left on bikini licence. 
; Variables are 'read-only' changing them won't affect anything other than possibly messing up other mods. So don't.

; _SLS_PlayerIsMagicCursed
; -1: Magic licence disabled
; 0: Not collared or cursed
; 1: Cursed but not collared
; 2: Cursed and collared
; Eg: StorageUtil.GetIntValue(None, "_SLS_PlayerIsMagicCursed") == 2 ; Player is cursed and collared

Event OnInit()
	If Self.IsRunning()
		SetupQuartermasters()
		RegisterForEvents()
		;RegisterForModEvent("_SLS_LicenceStateUpdateEvent", "On_SLS_LicenceStateUpdateEvent")
	EndIf
EndEvent
;/
Event On_SLS_LicenceStateUpdateEvent(string eventName, string strArg, float numArg, Form sender)
	Debug.Messagebox("HasValidMagicLicence: " + StorageUtil.GetIntValue(None, "_SLS_HasValidMagicLicence", Missing = -2) + \
					"\nHasValidWeaponLicence: " + StorageUtil.GetIntValue(None, "_SLS_HasValidWeaponLicence", Missing = -2) + \
					"\nHasValidArmorLicence: " + StorageUtil.GetIntValue(None, "_SLS_HasValidArmorLicence", Missing = -2) + \
					"\nHasValidBikiniLicence: " + StorageUtil.GetIntValue(None, "_SLS_HasValidBikiniLicence", Missing = -2) + \
					"\nHasValidClothesLicence: " + StorageUtil.GetIntValue(None, "_SLS_HasValidClothesLicence", Missing = -2) + \
					"\nHasValidCurfewLicence: " + StorageUtil.GetIntValue(None, "_SLS_HasValidCurfewLicence", Missing = -2) + \
					"\nHasValidWhoreLicence: " + StorageUtil.GetIntValue(None, "_SLS_HasValidWhoreLicence", Missing = -2) + \
					"\nHasValidPropertyLicence: " + StorageUtil.GetIntValue(None, "_SLS_HasValidPropertyLicence", Missing = -2) + \
					"\nHasValidFreedomLicence: " + StorageUtil.GetIntValue(None, "_SLS_HasValidFreedomLicence", Missing = -2))
EndEvent
/;
Function RegisterForEvents()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
	RegisterForModEvent("_SLS_IssueLicence", "On_SLS_IssueLicence")
	RegisterForModEvent("_SLS_BlockLicenceBuy", "On_SLS_BlockLicenceBuy")
	RegisterForModEvent("_SLS_SendToKennel", "On_SLS_SendToKennel")
	RegisterForModEvent("_SLS_EvictFromHome", "On_SLS_EvictFromHome")
	RegisterForModEvent("_SLS_UnEvictFromHome", "On_SLS_UnEvictFromHome")
	RegisterForModEvent("_SLS_RevokeLicence", "On_SLS_RevokeLicence")
	RegisterForModEvent("_SLS_RemoveMagicCurse", "On_SLS_RemoveMagicCurse")
	RegisterForModEvent("_SLS_AddMagicCurse", "On_SLS_AddMagicCurse")
	RegisterForModEvent("_SLS_AddStashTracking", "On_SLS_AddStashTracking")
	RegisterForModEvent("_SLS_RemoveStashTracking", "On_SLS_RemoveStashTracking")
	RegisterForModEvent("_SLS_AddStashException", "On_SLS_AddStashException")
	RegisterForModEvent("_SLS_RemoveStashException", "On_SLS_RemoveStashException")
	RegisterForModEvent("_SLS_SwallowCum", "On_SLS_SwallowCum")
	RegisterForModEvent("_SLS_AddTraumaToPlayer", "On_SLS_AddTraumaToPlayer")
EndFunction

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	CleanUp()
EndEvent

Function SetVersion(Float Version)
	; StUtil version variable first added in version 0.647
	; StoragUtil.GetFloatValue(None, "_SLS_SurvivalVersion") < 0.647 ; SLS is either not installed or below version 0.647
	
	StorageUtil.SetFloatValue(None, "_SLS_SurvivalVersion", Version)
EndFunction

Event On_SLS_IssueLicence(Int LicenceType, Int TermDuration, Form Issuer, Form GiveLicTo, Bool DeductGold, Form Sender)

	;/
	Issues a licence for the player. 
	
	- LicenceType: 0 - Magic, 1 - weapons, 2 - Armor, 3 - Bikini, 4 - Clothes, 5 - Curfew, 6 - Whore, 7 - Freedom, 8 - Property
	- TermDuration: 0 - Short term, 1 - Long term, 2 - Perpetual
	- Issuer: The actor who's name will appear on the licence as having issued it to the player. 
	- GiveLicTo: The object reference to give the licence to. Usually the player but can be a container etc. Can be None, in which case the licence won't be moved. 
	- DeductGold: Remove the usual cost from the player. Won't matter if the player hasn't enough gold
	- Sender: A form that identifies your mod (Eg. your quest). The form you send to survival will be sent back to you with the ObjectReference for the 
	 licence that was issued. You'll know it was your mod that requested the licence if the forms match. 
	
	Example usage:
	
	Event OnAnimationEnd()
		; Player had sex with Nazeem. Give her a short term weapon licence as promised
		
		RegisterForModEvent("_SLS_LicenceIssuedEvent", "On_SLS_LicenceIssuedEvent") ; Only if you wish to get an object reference for the licence that will be issued!
		
		SendGetLicenceEvent(LicenceType = 1, TermDuration = 0, Issuer = NazeemRef, GiveLicTo = NazeemRef, DeductGold = false, Sender = MyQuest)
	EndFunction
	
	Function SendGetLicenceEvent(Int LicenceType, Int TermDuration, Form Issuer, Form GiveLicTo, Bool DeductGold, Form Sender)
		Int GetLicence = ModEvent.Create("_SLS_IssueLicence")
		If (GetLicence)
			ModEvent.PushInt(GetLicence, LicenceType)
			ModEvent.PushInt(GetLicence, TermDuration)
			ModEvent.PushForm(GetLicence, NazeemRef)
			ModEvent.PushForm(GetLicence, PlayerRef)
			ModEvent.PushBool(GetLicence, DeductGold)
			ModEvent.PushForm(GetLicence, Sender)
			ModEvent.Send(GetLicence)
		EndIf
	EndFunction
	
	Event On_SLS_LicenceIssuedEvent(Form Licence, Int LicenceType, Int TermDuration, Form RequestingMod) ; Only if you wish to get an object reference for the licence that will be issued!
		If RequestingMod == MyQuest ; this was the licence my mod requested!
			ObjectReference MyLicence = Licence as ObjectReference ; Licence was received as type Form. Cast it as an ObjectReference
			GiveLicenceToPlayer(MyLicence)
		EndIf
	EndEvent
	
	Function GiveLicenceToPlayer(ObjectReference Licence)
		PlayerRef.AddItem(Licence)
	EndFunction
	/;

	LicHandle.IssueLicHandle(LicenceType, TermDuration, Issuer, GiveLicTo, DeductGold, Sender)
EndEvent

Function SendLicenceIssuedEvent(ObjectReference Licence, Int LicenceType, Int TermDuration, Form RequestingMod)
	; Event sent by Survival when a mod requests a licence

	; Requesting a licence be issued by sending the _SLS_IssueLicence event will make Survival send back a mod event with: 
	; Licence: The object reference for the licence just issued. Sent as a form - must be cast to an ObjectReference when received. 
	; TermDuration: 0 - Short term, 1 - Long term, 2 - Perpetual
	; LicenceType: 0 - Magic, 1 - weapons, 2 - Armor, 3 - Bikini, 4 - Clothes

	Int IssueLic = ModEvent.Create("_SLS_LicenceIssuedEvent")
	If (IssueLic)
		ModEvent.PushForm(IssueLic, Licence)
		ModEvent.PushInt(IssueLic, LicenceType)
		ModEvent.PushInt(IssueLic, TermDuration)
		ModEvent.PushForm(IssueLic, RequestingMod)
		ModEvent.Send(IssueLic)
	EndIf
EndFunction

Event On_SLS_BlockLicenceBuy(Form Sender, Bool BlockLicence)
	;/
	Use this event to stop the licence quartermasters selling licences to the player. 
	The quartermasters will say something like "Sorry girl, but I've been instructed to not sell licences to you"
	
	Parameters
	Sender - A form from your mod. Any forms sent to Survival will be added to the global StorageUtil formlist "_SLS_LicenceBlockingForms". 
	So if the form count on this key is greater than zero licence buying will be blocked. 
	BlockLicence: 	True - Block licences with the associated sender
					False - Unblock licences and remove sender as a blocking form
	
	Obviously, you must send the same form when blocking and unblocking licences otherwise they won't match and so won't be recognised. 
	
	
	Example usage:
	
	Please do NOT block licences by setting _SLS_LicBuyBlockApi directly! You can however use it to detect if licences are blocked:
	
	If Game.GetModByName("SL Survival.esp") != 255
		If (Game.GetFormFromFile(0x08666A, "SL Survival.esp") as GlobalVariable).GetValueInt() == 1
			; Licences are blocked
		Else
			; Licences are not blocked
		EndIf
	EndIf
	
	Or you can also detect it this way:
	
	If StorageUtil.FormListCount(None, "_SLS_LicenceBlockingForms") > 0
		; Licences are blocked
	Else
		; Licences are not blocked
	EndIf
	
	To block licence buying create a function like this:
	
	Function SendSurvivalBlockEvent(Bool BlockIt)
		Int BlockEvent = ModEvent.Create("_SLS_BlockLicenceBuy")
		If (BlockEvent)
			ModEvent.PushForm(BlockEvent, self)
			ModEvent.PushBool(BlockEvent, BlockIt)
			ModEvent.Send(BlockEvent)
		EndIf
	EndFunction
	
	Then to block licences you'd:
	
	Event SomeEvent()
		SendSurvivalBlockEvent(BlockIt = true)
	EndEvent
	
	Then later to unblock:
	
	Event SomeOtherEvent()
		SendSurvivalBlockEvent(BlockIt = false)
	EndEvent
	
	Unblocking will remove the form you sent as a blocking form but there may be forms from other mods still blocking licences. 
	
	/;
	
	If Sender
		Debug.Trace("_SLS_: On_SLS_BlockLicenceBuy: Received block event. Sender: " + Sender + ". BlockLicence: " + BlockLicence)
		
		;Int i = StorageUtil.FormListCount(None, "_SLS_LicenceBlockingForms")
		
		If BlockLicence ; Block licences
			StorageUtil.FormListAdd(None, "_SLS_LicenceBlockingForms", Sender, allowDuplicate = false)
			StorageUtil.FormListAdd(None, "_SLS_LicenceBlockingForms", None, allowDuplicate = false)
			_SLS_LicBuyBlockApi.SetValueInt(1)
			
		Else ; Unblock licences
			StorageUtil.FormListRemove(None, "_SLS_LicenceBlockingForms", Sender, allInstances = true)
			CleanUp()
			If StorageUtil.FormListCount(None, "_SLS_LicenceBlockingForms") == 0
				_SLS_LicBuyBlockApi.SetValueInt(0)
			EndIf
		EndIf
		;Debug.Messagebox("Forms before: " + i + "\nForms After: " + StorageUtil.FormListCount(None, "_SLS_LicenceBlockingForms"))
	
	Else
		Debug.Trace("_SLS_: On_SLS_BlockLicenceBuy: Received a None Sender - Ignoring")
	EndIf
EndEvent

Event On_SLS_RevokeLicence(string eventName, string strArg, float numArg, Form sender)
	; Revoke licences. Acceptable strArg parameters:
	; "All" - Revoke all licences
	; "Random" - Revoke a random licence type the player has.
	; "Magic"
	; "Weapon"
	; "Armor"
	; "Bikini"
	; "Clothes"
	; "Curfew"
	; "Whore"
	; "Freedom"
	; "Property"
	
	; Unused - numArg, sender
	
	If strArg == "All"
		LicUtil.RevokeAllLicences(ReceivingRef = None)
	ElseIf strArg == "Random"
		LicUtil.RevokeRandomLicence(akSpeaker = None, ReceivingRef = None)
	Else
		LicUtil.RevokeLicence(LicType = strArg, ReceivingRef = None)
	EndIf
EndEvent

Event On_SLS_SendToKennel(Form akActor = None, String Hold = "")
	; Sends player to a kennel.
	; Either directly specify a kennel via Hold or provide an actor. Player will be sent to the kennel with the corresponding CrimeFaction
	; Holds: Whiterun, Solitude, Markarth, Windhelm or Riften
	
	Debug.Trace("_SLS_: Received On_SLS_SendToKennel event")
	Util.SendToKennel(akActor as Actor, Hold)
EndEvent

Event On_SLS_EvictFromHome(Int HomeInt, Form EvictForm, String EvictReason)
	; HomeInt: 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften
	; EvictForm: A form identifying your mod to SLS. You need to use the same form to block and unblock.
	; EvictReason: The reason for eviction. Hopefully I'll be able to add this to the note stuck on your door eventually. But for now it's more to
	; give a user a more relatable/understandable reason for being barred than EvictForm
	
	; Does not trigger a scene. Evicts/Unevicts immediately
	
	; If the player isn't flagged as owning the house then nothing will happen
	; To be flagged as having owned the house the home key must have entered the players inventory one time
	; If the player later buys a home while you've still have them evicted then they will be evicted immediately when the key enters their inventory.
	
	If HomeInt == 0
		If !StorageUtil.FormListHas(Eviction, "EvictFormsWhiterun", EvictForm)
			StorageUtil.FormListAdd(Eviction, "EvictFormsWhiterun", EvictForm, AllowDuplicate = false)
			StorageUtil.StringListAdd(Eviction, "EvictReasonsWhiterun", EvictReason)
		EndIf
		If Eviction.OwnsWhiterun; && !Eviction.IsBarredWhiterun
			Eviction.EvictWhiterun(Evicted = true)
		EndIf
		
	ElseIf HomeInt == 1
		If !StorageUtil.FormListHas(Eviction, "EvictFormsSolitude", EvictForm)
			StorageUtil.FormListAdd(Eviction, "EvictFormsSolitude", EvictForm, AllowDuplicate = false)
			StorageUtil.StringListAdd(Eviction, "EvictReasonsSolitude", EvictReason)
		EndIf
		If Eviction.OwnsSolitude; && !Eviction.IsBarredSolitude
			Eviction.EvictSolitude(Evicted = true)
		EndIf
		
	ElseIf HomeInt == 2
		If !StorageUtil.FormListHas(Eviction, "EvictFormsMarkarth", EvictForm)
			StorageUtil.FormListAdd(Eviction, "EvictFormsMarkarth", EvictForm, AllowDuplicate = false)
			StorageUtil.StringListAdd(Eviction, "EvictReasonsMarkarth", EvictReason)
		EndIf
		If Eviction.OwnsMarkarth; && !Eviction.IsBarredMarkarth
			Eviction.EvictMarkarth(Evicted = true)
		EndIf
		
	ElseIf HomeInt == 3
		If !StorageUtil.FormListHas(Eviction, "EvictFormsWindhelm", EvictForm)
			StorageUtil.FormListAdd(Eviction, "EvictFormsWindhelm", EvictForm, AllowDuplicate = false)
			StorageUtil.StringListAdd(Eviction, "EvictReasonsWindhelm", EvictReason)
		EndIf
		If Eviction.OwnsWindhelm; && !Eviction.IsBarredWindhelm
			Eviction.EvictWindhelm(Evicted = true)
		EndIf
		
	ElseIf HomeInt == 4
		If !StorageUtil.FormListHas(Eviction, "EvictFormsRiften", EvictForm)
			StorageUtil.FormListAdd(Eviction, "EvictFormsRiften", EvictForm, AllowDuplicate = false)
			StorageUtil.StringListAdd(Eviction, "EvictReasonsRiften", EvictReason)
		EndIf
		If Eviction.OwnsRiften; && !Eviction.IsBarredRiften
			Eviction.EvictRiften(Evicted = true)
		EndIf
	Else
		Debug.Trace("_SLS_: On_SLS_EvictFromHome: HomeInt not known: " + HomeInt)
	EndIf
EndEvent

Event On_SLS_UnEvictFromHome(Int HomeInt, Form EvictForm)
	; 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften
	
	; Does not trigger a scene. Evicts/Unevicts immediately
	
	; If the player isn't flagged as owning the house then nothing will happen
	; To be flagged as having owned the house the home key must have entered the players inventory one time
	
	; If the player is already not evicted then nothing will happen
	
	; Multiple mods may evict the player. All blocking forms must be removed for an eviction to be lifted
	
	Int i
	If HomeInt == 0
		i = StorageUtil.FormListFind(Eviction, "EvictFormsWhiterun", EvictForm)
		If i > -1
			StorageUtil.FormListRemoveAt(Eviction, "EvictFormsWhiterun", i)
			StorageUtil.StringListRemoveAt(Eviction, "EvictReasonsWhiterun", i)
		EndIf
		If Eviction.OwnsWhiterun; && Eviction.IsBarredWhiterun
			Eviction.EvictWhiterun(Evicted = false)
		EndIf
		
	ElseIf HomeInt == 1
		i = StorageUtil.FormListFind(Eviction, "EvictFormsSolitude", EvictForm)
		If i > -1
			StorageUtil.FormListRemoveAt(Eviction, "EvictFormsSolitude", i)
			StorageUtil.StringListRemoveAt(Eviction, "EvictReasonsSolitude", i)
		EndIf
		If Eviction.OwnsSolitude; && Eviction.IsBarredSolitude
			Eviction.EvictSolitude(Evicted = false)
		EndIf
		
	ElseIf HomeInt == 2
		i = StorageUtil.FormListFind(Eviction, "EvictFormsMarkarth", EvictForm)
		If i > -1
			StorageUtil.FormListRemoveAt(Eviction, "EvictFormsMarkarth", i)
			StorageUtil.StringListRemoveAt(Eviction, "EvictReasonsMarkarth", i)
		EndIf
		If Eviction.OwnsMarkarth; && Eviction.IsBarredMarkarth
			Eviction.EvictMarkarth(Evicted = false)
		EndIf
		
	ElseIf HomeInt == 3
		i = StorageUtil.FormListFind(Eviction, "EvictFormsWindhelm", EvictForm)
		If i > -1
			StorageUtil.FormListRemoveAt(Eviction, "EvictFormsWindhelm", i)
			StorageUtil.StringListRemoveAt(Eviction, "EvictReasonsWindhelm", i)
		EndIf
		If Eviction.OwnsWindhelm; && Eviction.IsBarredWindhelm
			Eviction.EvictWindhelm(Evicted = false)
		EndIf
		
	ElseIf HomeInt == 4
		i = StorageUtil.FormListFind(Eviction, "EvictFormsRiften", EvictForm)
		If i > -1
			StorageUtil.FormListRemoveAt(Eviction, "EvictFormsRiften", i)
			StorageUtil.StringListRemoveAt(Eviction, "EvictReasonsRiften", i)
		EndIf
		If Eviction.OwnsRiften; && Eviction.IsBarredRiften
			Eviction.EvictRiften(Evicted = false)
		EndIf
	Else
		Debug.Trace("_SLS_: On_SLS_UnEvictFromHome: HomeInt not known: " + HomeInt)
	EndIf
EndEvent

Event On_SLS_IncreaseGroundTime(Form akSpeaker, Int LocInt = -1, Int Days)
	; akSpeaker - Uses this actors set CrimeFaction to determine which city to increase the ground time in. 
	; If the actors crime faction isn't set or known then nothing will happen.
	; Use LocInt if you don't have an actor to send
	
	; LocInt: 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften
	; Use LocInt if you don't want to use akSpeaker and want to hard set the city to ground in. 
	
	; Days - how many days to ground for. 1 = 1 day. 7 = 1 week. 
	; Ground time is rounded to midnight. So if ground time is sent with 1 on Monday then ground time will expire at midnight on Monday. If normal curfew is in effect at midnight then it will take over
	
	Actor akActor = akSpeaker as Actor
	Util.IncreaseGroundTime(akSpeaker = akActor, LocInt = LocInt, Days = Days)
EndEvent

Event On_SLS_RemoveMagicCurse(Form akTarget)
	If akTarget as Actor
		LicUtil.UnNullifyMagic(akTarget as Actor)
	Else
		Debug.Trace("_SLS_: On_SLS_RemoveMagicCurse: received an invalid target: " + akTarget)
	EndIf
EndEvent

Event On_SLS_AddMagicCurse(Form akTarget)
	If akTarget as Actor
		LicUtil.NullifyMagic(akTarget as Actor)
	Else
		Debug.Trace("_SLS_: On_SLS_AddMagicCurse: received an invalid target: " + akTarget)
	EndIf
EndEvent

Event On_SLS_AddStashTracking(Form akContainer, Float TheftFreq = -1.0, Float ContainerSafety = -1.0)
	; Initiate SLS stash tracking on the specified container. Adding a container as a stash may fail if
	; it is not valuable enough to be tracked - Other stashes being tracked are more valuable
	
	; akContainer - The container you want tracked. The container should be in the loaded area. 
	
	; TheftFreq - How often npcs should try to steal from it or discover it in game hours.
	; 1.0 = try to steal/discover every game hour. -1.0 = Have SLS determine how often based on it's location. 
	; Freshly added containers will have an initial attempt to discover and steal when the container is first
	; detatched from cell (player is far enough away). This is to discourage leaving stuff behind. Dumping 
	; your backpack outside a city gate before going to a shop inside will probably be a bad idea....
	
	; ContainerSafety - How safe the container is from discovery. How well hidden it is. 
	; Valid values = 0.0 - 1.0. The higher this value the harder the container will be to discover by npcs.
	; -1.0 = Have SLS determine how safe the container is based on: 
	; The type of location - City, dungeon, town etc
	; How far to the nearest road
	; Type of container. Hunterborn stashes receive a bonus to container safety. Or 'Container Type Matters' is turned off in the Mcm

	If akContainer as ObjectReference && (akContainer as ObjectReference).GetBaseObject() as Container
		StashTrack.AddContainerTracking(akContainer as ObjectReference, TheftFreq, ContainerSafety)
	Else
		Debug.Trace("_SLS_: On_SLS_AddStashTracking(): Received an invalid container ref: " + akContainer)
	EndIf
EndEvent

Event On_SLS_RemoveStashTracking(Form akContainer)
	If akContainer as ObjectReference && (akContainer as ObjectReference).GetBaseObject() as Container
		StashTrack.StopTrackingContainer(akContainer as ObjectReference)
	Else
		Debug.Trace("_SLS_: On_SLS_AddStashTracking(): Received an invalid container ref: " + akContainer)
	EndIf
EndEvent

Event On_SLS_AddStashException(Form akContainer)
	If akContainer as ObjectReference && (akContainer as ObjectReference).GetBaseObject() as Container
		StashTrack.AddException(akContainer as ObjectReference, Silent = true)
		On_SLS_RemoveStashTracking(akContainer)
	Else
		Debug.Trace("_SLS_: On_SLS_AddStashException(): Received an invalid container ref: " + akContainer)
	EndIf
EndEvent

Event On_SLS_RemoveStashException(Form akContainer)
	If akContainer as ObjectReference && (akContainer as ObjectReference).GetBaseObject() as Container
		StashTrack.RemoveException(akContainer as ObjectReference, Silent = true)
	Else
		Debug.Trace("_SLS_: On_SLS_RemoveStashException(): Received an invalid container ref: " + akContainer)
	EndIf
EndEvent

Function SendSlavetownEvent(Int PlayerIsInSlavetown)
	; PlayerIsInSlavetown = 0.0 when leaving a slavetown area. 1.0 when entering
	SendModEvent("_SLS_PlayerIsInSlavetown", strArg = "", numArg = PlayerIsInSlavetown as Float)
EndFunction

Function SendCumHungerChangeEvent(Int HungerState)
	; numArg: -1 - Cum addiction off, 0 - Satisfied, 1 - Peckish, 2 - Hungry, 3 - Starving, 4 - Ravenous
	SendModEvent("_SLS_CumHungerChange", strArg = "", numArg = HungerState)
EndFunction

Function SendAuthorativeConvoEndEvent(Actor akSpeaker)
	; Sent at the end of conversations with toll guards or enforcers.
	Int AuthConvoEnd = ModEvent.Create("_SLS_AuthorativeConvoEnd")
    If AuthConvoEnd
        ModEvent.PushForm(AuthConvoEnd, akSpeaker)
        ModEvent.Send(AuthConvoEnd)
    EndIf
EndFunction

Function SendLicenceStateUpdateEvent()
	; Event sent when a licence changes state: Either from/to HasValidxxxxLicence/!HasValidxxxxLicence or a licence type has been enabled/disabled
	; Note this event is also sent periodically at the beginning of every game day.
	
	; Valid Global Variables:
	; _SLS_HasValidMagicLicence
	; _SLS_HasValidWeaponLicence
	; _SLS_HasValidArmorLicence
	; _SLS_HasValidBikiniLicence
	; _SLS_HasValidClothesLicence
	; _SLS_HasValidCurfewLicence
	; _SLS_HasValidWhoreLicence
	; _SLS_HasValidPropertyLicence
	; _SLS_HasValidFreedomLicence
	
	; Values: -1: Licence type disabled, 0: Does not have licence or licence expired, 1: Has a valid licence
	
	; Eg 1: StorageUtil.GetIntValue(None, "_SLS_HasValidMagicLicence", Missing = -2) == 1 ; Magic licence is enabled and the player has a valid magic licence
	; Eg 2: StorageUtil.GetIntValue(None, "_SLS_HasValidBikiniLicence", Missing = -2) == -1 ; Bikini licence is disabled
	; Eg 3: StorageUtil.GetIntValue(None, "_SLS_HasValidWeaponLicence", Missing = -2) == -1 ; All licences are disabled (because currently you can only disable weapon licences by disabling all licences)
	; Eg 4: StorageUtil.GetIntValue(None, "_SLS_HasValidClothesLicence", Missing = -2) == 0 ; Clothes licence is enabled but the player hasn't got a valid clothes licence
	; Eg 5: StorageUtil.GetIntValue(None, "_SLS_HasValidClothesLicence", Missing = -2) == -2 ; SLS is probably not installed or is < v0.628
	
	SendModEvent("_SLS_LicenceStateUpdateEvent")
EndFunction

Function SetupQuartermasters()
	; Formlist of licence quartermasters for your convenience.

	StorageUtil.FormListClear(None, "_SLS_LicenceQuartermastersList")
	StorageUtil.FormListAdd(None, "_SLS_LicenceQuartermastersList", (Game.GetFormFromFile(0x046213, "SL Survival.esp"))) ; Whiterun - Trilbjorn Stone-Tooth
	StorageUtil.FormListAdd(None, "_SLS_LicenceQuartermastersList", (Game.GetFormFromFile(0x046772, "SL Survival.esp"))) ; Solitude - Ancolanar
	StorageUtil.FormListAdd(None, "_SLS_LicenceQuartermastersList", (Game.GetFormFromFile(0x046774, "SL Survival.esp"))) ; Markarth - Surgug
	StorageUtil.FormListAdd(None, "_SLS_LicenceQuartermastersList", (Game.GetFormFromFile(0x046773, "SL Survival.esp"))) ; Windhelm - Erilas
	StorageUtil.FormListAdd(None, "_SLS_LicenceQuartermastersList", (Game.GetFormFromFile(0x046775, "SL Survival.esp"))) ; Riften - Okan-Jei
EndFunction

Function SendCumSwallowEvent(Form akSource, Bool DidSwallow, Float CumAmount, Float LoadSizeBase, Bool IsCumPotion)
	; akSource: Whos cum the player swallowed
	; DidSwallow: True - Swallowed, False - Spat out cum
	; CumAmount: The 'volume' of cum
	; LoadSizeBase: Usually how much cum the actor would have if his balls were 100% full
	; IsCumPotion: Cum drank was from a cum potion
	
    Int CumSwallowEvent = ModEvent.Create("_SLS_PlayerSwallowedCum")
    If (CumSwallowEvent)
		ModEvent.PushForm(CumSwallowEvent, akSource)
        ModEvent.PushBool(CumSwallowEvent, DidSwallow)
		ModEvent.PushFloat(CumSwallowEvent, CumAmount)
		ModEvent.PushFloat(CumSwallowEvent, LoadSizeBase)
		ModEvent.PushBool(CumSwallowEvent, IsCumPotion)
        ModEvent.Send(CumSwallowEvent)
    EndIf
EndFunction

Event On_SLS_SwallowCum(Form CumSource = none, Float CumAmount = -1.0, Bool DidSwallow = true,  Int AddCumToFace = 0)
	; Specify either an actor to use as a source for cum or directly specify an amount to swallow.
	; DidSwallow = Player tries her best to swallow everything. !DidSwallow = Player still swallows a fraction of load
	; AddCumToFace - Add cum to player's face and set cum type data so it can be collected. 0 - No cum, 1 - 1 layer of cum, 2 - 2 layers of cum

	Util.DoCumSwallow(CumSource as Actor, CumAmount, DidSwallow, AddCumToFace)
EndEvent

Event On_SLS_AddTraumaToPlayer(string eventName, string strArg, float numArg, Form sender)
	If Trauma.TraumaEnable
		If strArg == "DoSound"
			Util.DoHitSound(PlayerRef, Util.HitSoundVol)
			Utility.Wait(Utility.RandomFloat(0.3, 0.7))
			Util.DoFemalePainSound(PlayerRef, Util.PainSoundVol)
		EndIf
		Trauma.AddRandomTrauma(PlayerRef)
	EndIf
EndEvent

Function CleanUp()
	StorageUtil.FormListRemove(None, "_SLS_LicenceBlockingForms", None, allInstances = true) ; Remove any Nones from the list in case a mod was uninstalled etc. 
EndFunction

Actor Property PlayerRef Auto

GlobalVariable Property _SLS_LicBuyBlockApi Auto

_SLS_LicenceUtil Property LicUtil Auto
_SLS_ApiLicHandler Property LicHandle Auto
SLS_Utility Property Util Auto
SLS_EvictionTrack Property Eviction Auto
SLS_StashTrackPlayer Property StashTrack Auto
_SLS_Trauma Property Trauma Auto
