Scriptname _SLS_TollUtil extends Quest  

; Loc: 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften

Event OnInit()
	If Self.IsRunning()
		SetupArrays()
		InitGlobals()
	EndIf
EndEvent

Function SetupArrays()
	HoldsStr = new String[5]
	HoldsStr[0] = "Whiterun"
	HoldsStr[1] = "Solitude"
	HoldsStr[2] = "Markarth"
	HoldsStr[3] = "Windhelm"
	HoldsStr[4] = "Riften"
EndFunction

Function InitGlobals()
	StorageUtil.SetFloatValue(None, "_SLS_LicenceMagicValidUntil", -1.0)
	StorageUtil.SetFloatValue(None, "_SLS_LicenceWeaponValidUntil", -1.0)
	StorageUtil.SetFloatValue(None, "_SLS_LicenceArmorValidUntil", -1.0)
	StorageUtil.SetFloatValue(None, "_SLS_LicenceBikiniValidUntil", -1.0)
	StorageUtil.SetFloatValue(None, "_SLS_LicenceClothesValidUntil", -1.0)
	StorageUtil.SetFloatValue(None, "_SLS_LicenceCurfewValidUntil", -1.0)
	StorageUtil.SetFloatValue(None, "_SLS_LicenceWhoreValidUntil", -1.0)
	StorageUtil.SetFloatValue(None, "_SLS_LicenceFreedomValidUntil", -1.0)
	StorageUtil.SetFloatValue(None, "_SLS_LicencePropertyValidUntil", -1.0)
EndFunction

Int Function GetTollCostByString(String Hold)
	Return GetTollCostByLoc(HoldsStr.Find(Hold))
EndFunction

Int Function GetTollCostByLoc(Int Loc)
	If LocTrackCentral.ResidentsDontPayTolls && LocTrackCentral.HasHomeAtLoc()
		Return 0
	Else
		If Loc == 0
			Return GetTollCost(!Slaverun.IsFreeTownWhiterun(), Fashion.HairyPussyTaxWhiterun)
		ElseIf Loc == 1
			Return GetTollCost(!Slaverun.IsFreeTownSolitude(), Fashion.HairyPussyTaxSolitude)
		ElseIf Loc == 2
			Return GetTollCost(!Slaverun.IsFreeTownMarkarth(), Fashion.HairyPussyTaxMarkarth)
		ElseIf Loc == 3
			Return GetTollCost(!Slaverun.IsFreeTownWindhelm(), Fashion.HairyPussyTaxWindhelm)
		ElseIf Loc == 4
			Return GetTollCost(!Slaverun.IsFreeTownRiften(), Fashion.HairyPussyTaxRiften)
		Else
			Debug.Trace("_SLS_: GetTollCost(): Loc not resolved: " + Loc)
		EndIf
	EndIf
	Return 0
EndFunction

Int Function GetTollCostByDoor(ObjectReference TollDoor)
	If LocTrackCentral.ResidentsDontPayTolls && !LocTrackCentral.HasHomeAtLoc()
		If _SLS_TollDoorsWhiterun.HasForm(TollDoor)
			Return GetTollCost(!Slaverun.IsFreeTownWhiterun(), Fashion.HairyPussyTaxWhiterun)
		ElseIf _SLS_TollDoorsSolitude.HasForm(TollDoor)
			Return GetTollCost(!Slaverun.IsFreeTownSolitude(), Fashion.HairyPussyTaxSolitude)
		ElseIf _SLS_TollDoorsMarkarth.HasForm(TollDoor)
			Return GetTollCost(!Slaverun.IsFreeTownMarkarth(), Fashion.HairyPussyTaxMarkarth)
		ElseIf _SLS_TollDoorsWindhelm.HasForm(TollDoor)
			Return GetTollCost(!Slaverun.IsFreeTownWindhelm(), Fashion.HairyPussyTaxWindhelm)
		ElseIf _SLS_TollDoorsRiften.HasForm(TollDoor)
			Return GetTollCost(!Slaverun.IsFreeTownRiften(), Fashion.HairyPussyTaxRiften)
		Else
			Debug.Trace("_SLS_: GetTollCostByDoor(): Could not resolve: " + TollDoor)
		EndIf
	EndIf
	Return 0
EndFunction

Bool Function IsSlavetownByDoor(ObjectReference TollDoor)
	If _SLS_TollDoorsWhiterun.HasForm(TollDoor)
		Return !Slaverun.IsFreeTownWhiterun()
	ElseIf _SLS_TollDoorsSolitude.HasForm(TollDoor)
		Return !Slaverun.IsFreeTownSolitude()
	ElseIf _SLS_TollDoorsMarkarth.HasForm(TollDoor)
		Return !Slaverun.IsFreeTownMarkarth()
	ElseIf _SLS_TollDoorsWindhelm.HasForm(TollDoor)
		Return !Slaverun.IsFreeTownWindhelm()
	ElseIf _SLS_TollDoorsRiften.HasForm(TollDoor)
		Return !Slaverun.IsFreeTownRiften()
	EndIf
	Debug.Trace("_SLS_: IsSlavetownByDoor(): Could not resolve: " + TollDoor)
	Return false
EndFunction

Int Function GetTollCost(Bool IsSlavetown, Bool HairyPussyTax)
	Int JobsTotal = GetTollJobsTotal(IsSlavetown, HairyPussyTax)
	If IsSlavetown
		If TollCostPerLevel
			Return Math.Ceiling(((TollCostGold * PlayerRef.GetLevel() * SlaverunFactor) + (HairyPussyTax as Int * HairyPussyTaxCost)) * (GetTollJobsRemaining(IsSlavetown,HairyPussyTax) as Float / JobsTotal as Float))
		Else
			Return Math.Ceiling(((TollCostGold * SlaverunFactor) + (HairyPussyTax as Int * HairyPussyTaxCost)) * (GetTollJobsRemaining(IsSlavetown, HairyPussyTax) as Float / JobsTotal as Float))
		EndIf
	Else
		If TollCostPerLevel
			Return (TollCostGold * PlayerRef.GetLevel()) + (HairyPussyTax as Int * HairyPussyTaxCost)
		Else
			Return TollCostGold + (HairyPussyTax as Int * HairyPussyTaxCost)
		EndIf
	EndIf
EndFunction

Function SetTollCost(Bool IsSlavetown, Bool HairyPussyTax)
	_SLS_TollCost.SetValueInt(GetTollCost(IsSlavetown, HairyPussyTax))
EndFunction

Function SetTollCostByDoor(ObjectReference TollDoor)
	If _SLS_TollDoorsWhiterun.HasForm(TollDoor)
		SetTollCost(!Slaverun.IsFreeTownWhiterun(), Fashion.HairyPussyTaxWhiterun)
	ElseIf _SLS_TollDoorsSolitude.HasForm(TollDoor)
		SetTollCost(!Slaverun.IsFreeTownSolitude(), Fashion.HairyPussyTaxSolitude)
	ElseIf _SLS_TollDoorsMarkarth.HasForm(TollDoor)
		SetTollCost(!Slaverun.IsFreeTownMarkarth(), Fashion.HairyPussyTaxMarkarth)
	ElseIf _SLS_TollDoorsWindhelm.HasForm(TollDoor)
		SetTollCost(!Slaverun.IsFreeTownWindhelm(), Fashion.HairyPussyTaxWindhelm)
	ElseIf _SLS_TollDoorsRiften.HasForm(TollDoor)
		SetTollCost(!Slaverun.IsFreeTownRiften(), Fashion.HairyPussyTaxRiften)
	EndIf
	Debug.Trace("_SLS_: SetTollCostByDoor(): Could not resolve: " + TollDoor)
EndFunction

Function DisplayTollCostByLoc(Int Loc)	
	If Loc == 0
		DisplayTollCost(!Slaverun.IsFreeTownWhiterun(), Fashion.HairyPussyTaxWhiterun)
	ElseIf Loc == 1
		DisplayTollCost(!Slaverun.IsFreeTownSolitude(), Fashion.HairyPussyTaxSolitude)
	ElseIf Loc == 2
		DisplayTollCost(!Slaverun.IsFreeTownMarkarth(), Fashion.HairyPussyTaxMarkarth)
	ElseIf Loc == 3
		DisplayTollCost(!Slaverun.IsFreeTownWindhelm(), Fashion.HairyPussyTaxWindhelm)
	ElseIf Loc == 4
		DisplayTollCost(!Slaverun.IsFreeTownRiften(), Fashion.HairyPussyTaxRiften)
	Else
		Debug.Trace("_SLS_: GetTollCost(): Loc not resolved: " + Loc)
	EndIf
EndFunction

Function DisplayTollCost(Bool IsSlavetown, Bool HairyPussyTax)
	String DisplayStr
	Int JobsToDo = GetTollJobsRemaining(IsSlavetown, HairyPussyTax)
	Int JobsTotal = GetTollJobsTotal(IsSlavetown, HairyPussyTax)
	Int Total = 0
	If LocTrackCentral.ResidentsDontPayTolls && LocTrackCentral.HasHomeAtLoc()
		DisplayStr = "Resident: No Tolls"
	Else
		If IsSlavetown
			If TollCostPerLevel
				DisplayStr = "Toll Base: " + TollCostGold + " Septims\nLevel: " + PlayerRef.GetLevel()
				Total = (TollCostGold * PlayerRef.GetLevel())
				If IsSlavetown
					DisplayStr += "\nSlaverun: x" + SnipToDecimalPlaces(StrInput = SlaverunFactor, Places = 2)
					Total = (Total * SlaverunFactor) as Int
				EndIf
				DisplayStr += "\nBase Subtotal: " + (TollCostGold * PlayerRef.GetLevel() * SlaverunFactor) as Int + " Septims\n"
				If HairyPussyTax
					DisplayStr += "\nAdditional Charges: " + HairyPussyTaxCost + " Septims"
					Total += HairyPussyTaxCost
				EndIf
				DisplayStr += "\nTotal: " + Total + " Septims\n\nSlaverun Jobs: (" + JobsToDo + "/" + JobsTotal + ") x " + (((JobsToDo as Float / JobsTotal as Float) * 100.0) as Int) + "%"
				DisplayStr += "\nTotal Due: " + Math.Ceiling(((TollCostGold * PlayerRef.GetLevel() * SlaverunFactor) + (HairyPussyTax as Int * HairyPussyTaxCost)) * (JobsToDo as Float / JobsTotal as Float)) + " Septims"
			
			Else
				Total = (TollCostGold * SlaverunFactor) as Int
				DisplayStr = "Toll Base: " + TollCostGold + " Septims\nSlaverun: x" + SnipToDecimalPlaces(StrInput = SlaverunFactor, Places = 2) + "\nBase Subtotal: " + Total + " Septims"
				If HairyPussyTax
					DisplayStr += "\n\nAdditional Charges: " + HairyPussyTaxCost + " Septims"
					Total += HairyPussyTaxCost
				EndIf
				DisplayStr += "\nTotal: " + Total + " Septims\n\nSlaverun Jobs: (" + JobsToDo + "/" + JobsTotal + ") x " + (((JobsToDo as Float / JobsTotal as Float) * 100.0) as Int) + "%"
				DisplayStr += "\nTotal Due: " + Math.Ceiling(((TollCostGold * SlaverunFactor) + (HairyPussyTax as Int * HairyPussyTaxCost)) * (JobsToDo as Float / JobsTotal as Float)) + " Septims"
			EndIf
		
		Else
			If TollCostPerLevel
				Total = TollCostGold * PlayerRef.GetLevel()
				DisplayStr = "Toll Base: " + TollCostGold + "\nLevel: " + PlayerRef.GetLevel() + "\nBase Subtotal: " + Total + " Septims"
				If HairyPussyTax
					DisplayStr += "\n\nAdditional Charges: " + HairyPussyTaxCost + " Septims"
					Total += HairyPussyTaxCost
				EndIf
				DisplayStr += "\nTotal: " + Total + " Septims\n\nTotal Due: " + ((TollCostGold * PlayerRef.GetLevel()) + (HairyPussyTax as Int * HairyPussyTaxCost)) + " Septims"
			
			Else
				Total = TollCostGold
				DisplayStr = "Toll Base: " + TollCostGold + " Septims"
				If HairyPussyTax
					DisplayStr += "\n\nAdditional Charges: " + HairyPussyTaxCost + " Septims"
					Total += HairyPussyTaxCost
				EndIf
				DisplayStr += "\nTotal: " + Total + " Septims\n\nTotal Due: " + (TollCostGold + (HairyPussyTax as Int * HairyPussyTaxCost)) + " Septims"
			EndIf
		EndIf
	EndIf
	Debug.Messagebox(DisplayStr)
EndFunction

Int Function GetHairyPussyTax(Int Loc)
	If  Loc == 0
		Return (Fashion.HairyPussyTaxWhiterun as Int) * HairyPussyTaxCost
	ElseIf  Loc == 1
		Return (Fashion.HairyPussyTaxSolitude as Int) * HairyPussyTaxCost
	ElseIf  Loc == 2
		Return (Fashion.HairyPussyTaxMarkarth as Int) * HairyPussyTaxCost
	ElseIf  Loc == 3
		Return (Fashion.HairyPussyTaxWindhelm as Int) * HairyPussyTaxCost
	ElseIf  Loc == 4
		Return (Fashion.HairyPussyTaxRiften as Int) * HairyPussyTaxCost
	EndIf
	Return 0
EndFunction

Bool Function HasTownHairyPussyTaxByDoor(ObjectReference TollDoor)
	If _SLS_TollDoorsWhiterun.HasForm(TollDoor)
		Return Fashion.HairyPussyTaxWhiterun
	ElseIf _SLS_TollDoorsSolitude.HasForm(TollDoor)
		Return Fashion.HairyPussyTaxSolitude
	ElseIf _SLS_TollDoorsMarkarth.HasForm(TollDoor)
		Return Fashion.HairyPussyTaxMarkarth
	ElseIf _SLS_TollDoorsWindhelm.HasForm(TollDoor)
		Return Fashion.HairyPussyTaxWindhelm
	ElseIf _SLS_TollDoorsRiften.HasForm(TollDoor)
		Return Fashion.HairyPussyTaxRiften
	EndIf
	Debug.Trace("_SLS_: GetTollCostByDoor(): Could not resolve: " + TollDoor)
	Return false
EndFunction

Function TollBoxActivate(ObjectReference TollBox, ObjectReference akActionRef, Int BoxLoc, ReferenceAlias TollGate)
	If akActionRef == PlayerRef
		TollHasEnoughFollowers()
		If !Init.IsTollPaid
			_SLS_TollCost.SetValue(GetTollCostByLoc(BoxLoc))
		EndIf
		If IsGrounded(LocInt = BoxLoc)
			Debug.Notification("You are being punished and aren't allowed to leave town today")
			
		ElseIf IsCurfewTimeByLoc(PlayerRef.GetCurrentLocation())
			Debug.Notification("You can not leave during curfew. Wait til morning")
			
		ElseIf LocTrackCentral.ResidentsDontPayTolls && LocTrackCentral.HasHomeAtLoc()
			Debug.Notification("Residents don't pay tolls")
			
		ElseIf Init.IsTollPaid
			Debug.Notification("You have already paid the toll")
			
		ElseIf PlayerRef.GetItemCount(Gold001) >= _SLS_TollCost.GetValueInt()
			
			If Init.HasEnoughFollowers == 1
				;SLS_TollGate TollGateScript = TollGate as SLS_TollGate
				TollPaid(TollGate.GetReference(), true)
			ElseIf Init.HasEnoughFollowers == 0
				Debug.Notification("You need more protection if the guards are to let you leave")
			Else
				Debug.Notification("Women are not permitted to leave without an escort")
			EndIf
		Else
			Debug.notification("You are too poor to afford the toll - " + _SLS_TollCost.GetValueInt() + " septims")
		EndIf

		; Close strongbox again
		Utility.Wait(1.0)
		int openState = TollBox.GetOpenState()
		If (openState == 1 || openState == 2)
			TollBox.SetOpen(false)
		EndIf
	EndIf
EndFunction

Function TollLedgerActivate(ObjectReference akActionRef, Int Loc)
	If akActionRef == PlayerRef
		DisplayTollCostByLoc(Loc)
	EndIf
EndFunction

Function TollHasEnoughFollowers(Bool LeavingCity = true) ; Determine if the player has enough players to leave toll area
	If LocTrackCentral.HasHomeAtLoc()
		Init.HasEnoughFollowers = 1
		
	ElseIf !LeavingCity && LocTrackCentral.PlayerCurrentLocIndex <= 4 && LocTrackCentral.PlayerCurrentLocIndex >= 0 ; In city but is not trying to leave - Caught for contraband by city guard
		Init.HasEnoughFollowers = 1
	Else
		Int RequiredFollowerCount = _SLS_TollFollowersRequired.GetValueInt()
		If RequiredFollowerCount > 0
			Int FollowerCount = 0
			Actor Follower

			If Game.GetModByName("EFFCore.esm") != 255
				Formlist FollowerList = Game.GetFormFromFile(0x000F53, "EFFCore.esm") as Formlist
				FollowerCount = FollowerList.GetSize()
				If FollowerCount >= RequiredFollowerCount
					Init.HasEnoughFollowers = 1
					Return
				EndIf
				
			Else
				Int i = DialogueFollower.GetNumAliases()
				While i > 0
					i -= 1
					Follower = (DialogueFollower.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
					Debug.Trace("EFF: Follower: " + Follower + "\nAlias: " + i)
					If Follower
						If !Follower.IsInFaction(CreatureFaction) && !Follower.IsInFaction(PlayerPotentialAnimalFaction)
							FollowerCount += 1
							If FollowerCount >= RequiredFollowerCount
								Init.HasEnoughFollowers = 1
								Return
							EndIf			
						EndIf
					EndIf
				EndWhile
			EndIf		

			If FollowerCount > 0 && FollowerCount < RequiredFollowerCount
				Init.HasEnoughFollowers = 0
			Else
				Init.HasEnoughFollowers = -1
			EndIf
		
		Else
			Init.HasEnoughFollowers = 1
		EndIf
	EndIf
EndFunction

Bool Function IsCurfewTimeByLoc(Location akLocation)
	Return IsCurfewTimeByBool(!Slaverun.IsFreeArea(akLocation))
EndFunction

Bool Function IsCurfewTimeByBool(Bool IsSlavetown)
	If Menu.CurfewEnable
		Float CurHour = GameHour.GetValue()
		
		If IsSlavetown
			If CurHour > _SLS_GateCurfewSlavetownBegin.GetValue() || CurHour < _SLS_GateCurfewSlavetownEnd.GetValue()
				_SLS_GateCurfewIsInEffect.SetValueInt(1)
				Return true
			EndIf
			_SLS_GateCurfewIsInEffect.SetValueInt(0)
			Return false
		Else
			If CurHour > _SLS_GateCurfewBegin.GetValue() || CurHour < _SLS_GateCurfewEnd.GetValue()
				_SLS_GateCurfewIsInEffect.SetValueInt(1)
				Return true
			EndIf
			_SLS_GateCurfewIsInEffect.SetValueInt(0)
			Return false
		EndIf
	Else
		_SLS_GateCurfewIsInEffect.SetValueInt(0)
		Return false
	EndIf
EndFunction

Bool Function IsGrounded(Int LocInt, ObjectReference akSpeaker = None)
	Float CurTime = Utility.GetCurrentGameTime()
	Faction CrimeFact
	If akSpeaker
		CrimeFact = (akSpeaker as Actor).GetCrimeFaction()
	EndIf
	;Debug.Messagebox("LocInt: " + LocInt + ". akSpeaker: " + akSpeaker + ". As Actor: " + (akSpeaker as Actor) + ". CrimeFact: " + CrimeFact)
	If LocInt == 0 || CrimeFact == CrimeFactionWhiterun ; Whiterun
		If GroundedUntilWhiterun > CurTime
			_SLS_IsGrounded.SetValueInt(1)
			Return true
		EndIf
	Elseif LocInt == 1 || CrimeFact == CrimeFactionHaafingar ; Solitude
		If GroundedUntilSolitude > CurTime
			_SLS_IsGrounded.SetValueInt(1)
			Return true
		EndIf
	Elseif LocInt == 2 || CrimeFact == CrimeFactionReach ; Markarth
		If GroundedUntilMarkarth > CurTime
			_SLS_IsGrounded.SetValueInt(1)
			Return true
		EndIf
	Elseif LocInt == 3 || CrimeFact == CrimeFactionEastmarch ; Windhelm
		If GroundedUntilWindhelm > CurTime
			_SLS_IsGrounded.SetValueInt(1)
			Return true
		EndIf
	Elseif LocInt == 4 || CrimeFact == CrimeFactionRift ; Riften
		If GroundedUntilRiften > CurTime
			_SLS_IsGrounded.SetValueInt(1)
			Return true
		EndIf
	Else
		Debug.Trace("_SLS_: IsGrounded: Unknown LocInt: " + LocInt)
	EndIf
	_SLS_IsGrounded.SetValueInt(0)
	Return false
EndFunction

Function GuardActivate(ObjectReference Guard)
	IsCurfewTimeByLoc(PlayerRef.GetCurrentLocation())
	IsGrounded(-1, Guard)
	TollHasEnoughFollowers()
EndFunction

Function PaidGuard(ReferenceAlias AssociatedDoor)
	TollPaid(AssociatedDoor.GetReference(), false)
EndFunction

Function PaidGuardTats(ObjectReference Guard)
	Int i = 0
	While i < TollCostTattoos
		SendModEvent("RapeTattoos_addTattoo")
		Utility.Wait(1.0)
		i += 1
	EndWhile
	PaidGuard((Guard as SLS_TollGuard).AssociatedDoor)
	Init.CanDoTats = 0
	Utility.WaitMenuMode(1.5)
	Util.StripAll(PlayerRef, false, true)
EndFunction

Function PaidGuardDrugs(ObjectReference Guard)
	Init.ForceDrug.DoTollDrugs(PlayerRef, Quantity = TollCostDrugs)
	PaidGuard((Guard as SLS_TollGuard).AssociatedDoor)
EndFunction

Function PaidGuardDance(ObjectReference Guard)
	Init.TdfDance.Cast(PlayerRef, PlayerRef)
	PaidGuard((Guard as SLS_TollGuard).AssociatedDoor)
	Init.TollAllowDance = false
	Init.CanDoDance = 0
EndFunction

Function PaidGuardBlowjob(ObjectReference Guard, Bool SwallowDeal)
	Main.StartSexOralMale(Guard as Actor, SexCat = 1, DecWillIncFame = true, Victim = none, TeleportType = 0)
	TollOrgasm.Setup(Guard as Actor)
	If SwallowDeal
		Init.IsTollSwallowDeal = true
	EndIf
EndFunction

Function PaidGuardDDs(ObjectReference Guard)
	Util.StripAll(PlayerRef, Menu.DropItems, true)
	Devious.EquipRandomDds(PlayerRef, TollCostDevices)
	PaidGuard((Guard as SLS_TollGuard).AssociatedDoor)
	Init.CanDoDevices = 0
	Init.TollDialogDevicesDoOnce = true
EndFunction

Function PaidGuardDflow(ObjectReference Guard)
	ReferenceAlias DoorAlias = (Guard as SLS_TollGuard).AssociatedDoor
	PaidGuard(DoorAlias)
	Dflow.ModDfDebt(GetTollCostByDoor(DoorAlias.GetReference()))
EndFunction

Function OnTollDoorAttach(Bool IsInteriorDoor, ReferenceAlias ThisDoorAlias)
	;Debug.Messagebox("Attach Toll Door: " + ThisDoorAlias.GetReference() + "\nIsInteriorDoor: " + IsInteriorDoor)
	If IsInteriorDoor
		Utility.Wait(1.0) ; Wait for LocTrackCentral to update IsTollPaid
		ObjectReference ThisDoor = ThisDoorAlias.GetReference()
		
		If PlayerRef.GetCurrentPackage() != None
			; Player controls disabled
			;Debug.Messagebox("Door load Package: " + PlayerRef.GetCurrentPackage())
			ToggleDoorLocks(ThisDoor, false)
			;Debug.Messagebox(PlayerRef.GetCurrentPackage())		
		
		ElseIf IsGrounded(LocTrackCentral.PlayerCurrentLocIndex) || IsCurfewTimeByLoc(PlayerRef.GetCurrentLocation())
			ToggleDoorLocks(ThisDoor, true)
			
		ElseIf (LocTrackCentral.ResidentsDontPayTolls && LocTrackCentral.HasHomeAtLoc())
			ToggleDoorLocks(ThisDoor, false)
		
		Else
			;Debug.Messagebox("Door load NO AI")
			;Init.IsPlayerInside = true ; now handled in LocTrackCentral
			;Debug.Trace("SLS_: Player is INside")
			
			Int HairyPussyTax
			;Debug.Messagebox("Init.IsTollPaid: " + Init.IsTollPaid)
			If !Init.IsTollPaid
				If Menu.DoorLockDownT
					
					If !ThisDoor.IsLocked()
						Debug.Trace("SLS_: Locking door: " + ThisDoor)
						ThisDoor.SetLockLevel(100)
						ThisDoor.Lock(true, true)
					EndIf
				EndIf
				
				If Init.SlvrunRelInstalled

					; Whiterun
					If Init._SLS_TollDoorsWhiterun.HasForm(ThisDoor)
						HairyPussyTax = (Init.LicUtil.Fashion.HairyPussyTaxWhiterun as Int) * 200
						Init.IsEnslavedTown = !Slaverun.IsFreeTownWhiterun()
					
					; Solitude
					ElseIf Init._SLS_TollDoorsSolitude.HasForm(ThisDoor)
						HairyPussyTax = (Init.LicUtil.Fashion.HairyPussyTaxSolitude as Int) * 200
						Init.IsEnslavedTown = !Slaverun.IsFreeTownSolitude()
						
					; Markarth
					ElseIf Init._SLS_TollDoorsMarkarth.HasForm(ThisDoor)
						HairyPussyTax = (Init.LicUtil.Fashion.HairyPussyTaxMarkarth as Int) * 200
						Init.IsEnslavedTown = !Slaverun.IsFreeTownMarkarth()
						
					; Windhelm
					ElseIf Init._SLS_TollDoorsWindhelm.HasForm(ThisDoor)
						HairyPussyTax = (Init.LicUtil.Fashion.HairyPussyTaxWindhelm as Int) * 200
						Init.IsEnslavedTown = !Slaverun.IsFreeTownWindhelm()
						
					; Riften
					ElseIf Init._SLS_TollDoorsRiften.HasForm(ThisDoor) || ThisDoor == Init.JkRiftenExtraDoorExterior.GetReference()
						HairyPussyTax = (Init.LicUtil.Fashion.HairyPussyTaxRiften as Int) * 200
						Init.IsEnslavedTown = !Slaverun.IsFreeTownRiften()
					EndIf
				EndIf
				
				TollJobsDone = 0
				;/
				If Init.IsEnslavedTown
					TollJobsToDo = SlaverunJobFactor
				Else
					TollJobsToDo = 1
				EndIf
				/;
				;ObjectReference TollBox = Game.FindClosestReferenceOfTypeFromRef(Game.GetFormFromFile(0x009EDB, "SL Survival.esp"), arCenter = Game.GetPlayer(), afRadius = 1000.0)
				;_SLS_TollCost.SetValueInt((TollBox as SLS_TollBox).GetTollCost())
				Debug.Trace("SLS_: " + ThisDoor + " toll cost set to " + _SLS_TollCost.GetValueInt())
			EndIf
		EndIf
	EndIf
EndFunction

Function TollDoorLoad(Bool IsInteriorDoor, ReferenceAlias ThisDoorAlias)
	
EndFunction

Function TollDoorLockStateChange(ObjectReference ThisDoor, Bool IsInteriorDoor)
	If Menu.DoorLockDownT
		If Init.IsPlayerInside && !Init.IsTollPaid && PlayerRef.GetCurrentPackage() == None && !LocTrackCentral.HasHomeAtLoc()
			Debug.Trace("SLS_: StateChange - " + ThisDoor + ". Interior: " + IsInteriorDoor + ". Locked: " + ThisDoor.IsLocked())
			If !ThisDoor.IsLocked()
				Debug.Trace("SLS_: Locking door: " + ThisDoor)
				ThisDoor.SetLockLevel(100)
				ThisDoor.Lock(true, true)
			EndIf
		EndIf
	EndIf
EndFunction

Function TollDoorActivate(ObjectReference TollDoor, Bool IsInteriorDoor, ObjectReference akActionRef)
	If IsInteriorDoor && akActionRef == PlayerRef && !TollDoor.IsLocked() && LocTrackCentral.HasHomeAtLoc()
		TollPaid(TollDoor, Gold = false, Override = true)
	EndIf
EndFunction

Function ToggleDoorLocks(ObjectReference TollDoor, Bool LockThem) ; false - Unlock. True - Lock
	debug.Trace("SLS_: Locking gates: " + LockThem)
	
	Formlist DoorList = GetDoorList(TollDoor)
	; Lock/Unlock this door and associated doors
	If DoorList
		ObjectReference DoorSelect
		Int i = 0
		While i < DoorList.GetSize()
			DoorSelect = DoorList.GetAt(i) as ObjectReference
			If LockThem
				TollDoor.SetLockLevel(100)
			EndIf
			TollDoor.Lock(LockThem, true)
			i += 1
		EndWhile
	EndIf
EndFunction

Formlist Function GetDoorList(ObjectReference TollDoor)
	If _SLS_TollDoorsWhiterun.HasForm(TollDoor)
		Return _SLS_TollDoorsWhiterun
	ElseIf _SLS_TollDoorsSolitude.HasForm(TollDoor)
		Return _SLS_TollDoorsSolitude
	ElseIf _SLS_TollDoorsMarkarth.HasForm(TollDoor)
		Return _SLS_TollDoorsMarkarth
	ElseIf _SLS_TollDoorsWindhelm.HasForm(TollDoor)
		Return _SLS_TollDoorsWindhelm
	ElseIf _SLS_TollDoorsRiften.HasForm(TollDoor)
		Return _SLS_TollDoorsRiften
	EndIf
	Return None
EndFunction

Function TollPaid(ObjectReference TollDoor, Bool Gold, Bool Override = false)
	 ; Gold - True: Player paid with gold. False: player paid via other means
	 ; Override - Pay toll for the player. 'Pay' toll evasion.
	 
	If !Override
		If Gold
			SetTollCostByDoor(TollDoor)
			PlayerRef.RemoveItem(Gold001, _SLS_TollCost.GetValueInt())
		EndIf
		TollJobsDone += 1
		
		If Init.TdfProsInstalled
			If !Gold && !Init.TollAllowDance
				If Utility.RandomFloat(0.0, 100.0) > 75.0
					Init.TollAllowDance = true
					Debug.Notification("The Toll Collectors will allow you to dance for them again")
				EndIf
			EndIf
		EndIf
		
		Bool IsHairyPussyTaxed = HasTownHairyPussyTaxByDoor(TollDoor)
		Bool IsSlavetown = IsSlavetownByDoor(TollDoor)
		If GetTollJobsRemaining(IsSlavetown, IsHairyPussyTaxed) <= 0 || Gold
			Init.IsTollPaid = true
			TollDodge.PaidToll()
			ToggleDoorLocks(TollDoor, false)
			Init.ResetCanDos()
		
		Else
			;_SLS_TollCost.SetValueInt(_SLS_TollCost.GetValueInt() - Math.Floor(_SLS_TollCost.GetValueInt() * (TollJobsToDo as Float / SlaverunJobFactor as Float))) 
			SetTollCostByDoor(TollDoor)
			Debug.Notification("You still need to do " + GetTollJobsRemaining(IsSlavetown, IsHairyPussyTaxed) + " more tasks for the collectors. Toll: " + GetTollCostByDoor(TollDoor))
			Init.CheckTaskReset()
		EndIf
	
	Else
		Init.IsTollPaid = true
		TollDodge.PaidToll()
		ToggleDoorLocks(TollDoor, false)
	EndIf
EndFunction

String Function SnipToDecimalPlaces(String StrInput, Int Places)
	Return StringUtil.Substring(StrInput, startIndex = 0, len =  Places + 1 + StringUtil.Find(StrInput, ".", startIndex = 0))
EndFunction
;/
Int Function GetTollJobsToDo(Bool IsSlavetown, Bool HairyPussyTax)
	Return TollJobsToDo + ((HairyPussyTax as Int) + (HairyPussyTax as Int * IsSlavetown as Int))
EndFunction
/;
Int Function GetTollJobsTotal(Bool IsSlavetown, Bool HairyPussyTax)
	If IsSlavetown
		Return SlaverunJobFactor + ((HairyPussyTax as Int) * 2)
	EndIf
	Return 1 + (HairyPussyTax as Int)
EndFunction

Int Function GetTollJobsRemaining(Bool IsSlavetown, Bool HairyPussyTax)
	If IsSlavetown
		Return PapyrusUtil.ClampInt((SlaverunJobFactor + ((HairyPussyTax as Int * 2)) - TollJobsDone), 0, 1000)
	Else
		Return PapyrusUtil.ClampInt(((1 + (HairyPussyTax as Int)) - TollJobsDone), 0, 1000)
	EndIf
EndFunction

Function RecheckGateConditions()
	Int i = 0
	ObjectReference DoorRef
	While i < GetNumAliases()
		DoorRef = (GetNthAlias(i) as ReferenceAlias).GetReference()
		If DoorRef && DoorRef.Is3dLoaded() ; No point if door is not loaded - will be handled later by OnCellAttach
			If (GetNthAlias(i) as SLS_TollGate).IsInteriorDoor
				OnTollDoorAttach(true, GetNthAlias(i) as ReferenceAlias)
			EndIf
		EndIf
		i += 1
	EndWhile
EndFunction

String[] HoldsStr

Bool Property TollCostPerLevel = false Auto Hidden
Bool Property IsTollSwallowDeal = false Auto Hidden

Int Property TollCostDrugs = 2 Auto Hidden
Int Property TollCostTattoos = 2 Auto Hidden
Int Property TollCostDevices = 3 Auto Hidden
Int Property SlaverunJobFactor = 3 Auto Hidden
Int Property TollCostGold = 100 Auto Hidden
;Int Property TollJobsToDo = 1 Auto Hidden
Int Property TollJobsDone = 0 Auto Hidden
Int Property HairyPussyTaxCost = 200 Auto Hidden

Float Property SlaverunFactor = 2.0 Auto Hidden
Float Property GroundedUntilWhiterun = 0.0 Auto Hidden
Float Property GroundedUntilSolitude = 0.0 Auto Hidden
Float Property GroundedUntilMarkarth = 0.0 Auto Hidden
Float Property GroundedUntilWindhelm = 0.0 Auto Hidden
Float Property GroundedUntilRiften = 0.0 Auto Hidden

Actor Property PlayerRef Auto

Faction Property CrimeFactionWhiterun Auto
Faction Property CrimeFactionHaafingar Auto
Faction Property CrimeFactionReach Auto
Faction Property CrimeFactionEastmarch Auto
Faction Property CrimeFactionRift Auto
Faction Property CreatureFaction Auto
Faction Property PlayerPotentialAnimalFaction Auto

Quest Property DialogueFollower Auto

GlobalVariable Property _SLS_TollCost Auto
GlobalVariable Property _SLS_IsGrounded Auto
GlobalVariable Property _SLS_TollFollowersRequired Auto
GlobalVariable Property _SLS_GateCurfewIsInEffect Auto
GlobalVariable Property _SLS_GateCurfewBegin Auto
GlobalVariable Property _SLS_GateCurfewEnd Auto
GlobalVariable Property _SLS_GateCurfewSlavetownBegin Auto
GlobalVariable Property _SLS_GateCurfewSlavetownEnd Auto

GlobalVariable Property GameHour Auto

MiscObject Property Gold001 Auto

Formlist Property _SLS_TollDoorsWhiterun Auto
Formlist Property _SLS_TollDoorsSolitude Auto
Formlist Property _SLS_TollDoorsMarkarth Auto
Formlist Property _SLS_TollDoorsWindhelm Auto
Formlist Property _SLS_TollDoorsRiften Auto

_SLS_InterfaceDevious Property Devious Auto
_SLS_InterfaceDeviousFollowers Property Dflow Auto
_SLS_InterfaceFashion Property Fashion Auto
_SLS_InterfaceSlaverun Property Slaverun Auto
_SLS_TollDodge Property TollDodge Auto
SLS_Init Property Init Auto
SLS_Mcm Property Menu Auto
SLS_Main Property Main Auto
SLS_Utility Property Util Auto
_SLS_TollOrgasm Property TollOrgasm Auto
_SLS_LocTrackCentral Property LocTrackCentral Auto
