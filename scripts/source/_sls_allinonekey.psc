Scriptname _SLS_AllInOneKey extends Quest

Event OnInit()
	If Self.IsRunning()
		PlayerIsNpcVar = PlayerRef.GetAnimationVariableInt("IsNPC")
		BuildScriptArrays()
		SetKey(AioKey)
		;SetKey(StatusKey)
		StorageUtil.SetIntValue(Self, "SetOverlaysHelp", 1)
	EndIf
EndEvent

Function SetKey(Int KeyCode)
	UnregisterForKey(AioKey)
	AioKey = KeyCode
	If KeyCode > 0
		RegisterForKey(KeyCode)
	EndIf
EndFunction

Function SetStatusKey(Int KeyCode)
	UnregisterForKey(StatusKey)
	StatusKey = KeyCode
	If KeyCode > 0
		RegisterForKey(KeyCode)
	EndIf
EndFunction

Event OnKeyDown(Int KeyCode)
	If !Utility.IsInMenuMode() && !UI.IsMenuOpen("InventoryMenu") && !UI.IsMenuOpen("Crafting Menu") ; Because IsInMenuMode() only checks if time is paused - and the unpause mod fucks that.
		XhairTarget = Game.GetCurrentCrosshairRef()
		;SendWashPlayerEvent()
		If KeyCode == AioKey
			MainMenu()		
			;Debug.Messagebox(Friend.Fm.GetPregnancyRace(PlayerRef).GetDefaultVoiceType(female = false))
		Else
			StatusMenu()
		EndIf
	EndIf
EndEvent
;/
Function SendWashPlayerEvent()
	Int WashActor = ModEvent.Create("BiS_WashActor")
	if (WashActor)
		ModEvent.PushForm(WashActor, (PlayerRef as Form))
		ModEvent.PushBool(WashActor, false)
		ModEvent.PushBool(WashActor, true)
		ModEvent.PushBool(WashActor, true)
		ModEvent.Send(WashActor)
    endIf
EndFunction
/;
Event OnMenuClose(String MenuName)
	; Sleep On Ground
	StorageUtil.SetIntValue(PlayerRef, "_SLS_SleepingRough", 0)
	Debug.SendAnimationEvent(PlayerRef, "IdleBedExitStart")
	UnRegisterForMenu("Sleep/Wait Menu")
EndEvent

Function LoadGameMaintenance()
	;RegisterForModEvent("_SLS_LicenceStateUpdateEvent", "On_SLS_LicenceStateUpdateEvent")
	TongueSlotMask = (_SLS_TonguesList.GetAt(0) as Armor).GetSlotMask()
EndFunction

; Main Menu ===================================================================================================

Actor Function GetMenuTargetActor()
	Actor akActor = XhairTarget as Actor
	If !akActor
		akActor = PlayerRef
	EndIf
	Return akActor
EndFunction

Function MainMenu()
	Int MenuSelect = ShowMainMenu()
	If MenuSelect == 0
		SelfMenu()
	ElseIf MenuSelect == 1
		ActionsMenu()
	ElseIf MenuSelect == 2
		SurvivalMenu()
	ElseIf MenuSelect == 3
		StatusMenu()
	ElseIf MenuSelect == 4
		IdleMenu()
	ElseIf MenuSelect == 5
		MiscMenu()
	ElseIf MenuSelect == 6
		Fav.FavoriteAction()
	ElseIf MenuSelect == 7
		LastAction()
	EndIf
EndFunction

Int Function ShowMainMenu()
	;Debug.Messagebox((Game.GetFormFromFile(0x0C4706, "SL Survival.esp") as _SLS_InterfaceCreatureFramework).GetArousalThreshold())

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Self ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Actions ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Survival ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Status ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 4, value = "Idle ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 5, value = "Misc ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 6, value = Fav.GetFavoriteString())

	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Self ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Actions ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Survival ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Status ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 4, value = "Idle ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 5, value = "Misc ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 6, value = Fav.GetFavoriteString())
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 6, value = true)
	
	If Self.GetState() != ""
		wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 7, value = GetLastActionString())
		wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 7, value = GetLastActionString())
		wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 7, value = LastActionAvailable())
	EndIf

	Return wheelMenu.OpenMenu(GetMenuTargetActor())
EndFunction

; Self Menu ======================================================================================================

Function SelfMenu(Bool IsShortcut = false)
	Int MenuSelect = ShowSelfMenu()
	If MenuSelect == -1
		MainMenu()
	ElseIf MenuSelect == 1 ; Open/Close Mouth
		CumSwallow.OnKeyDown(0)
		GoToState("OpenCloseMouth")
	ElseIf MenuSelect == 0 ; Cover self
		CoverMyself.OnKeyDown(0)
		GoToState("CoverMyself")
	ElseIf MenuSelect == 2
		TongueMenu()
		GoToState("Tongue")
	ElseIf MenuSelect == 3
		BeginLookAt()
		GoToState("LookAt")
	ElseIf MenuSelect == 4
		ChangeStanceMenu()
	ElseIf MenuSelect == 5
		EmoteMenu()
	ElseIf MenuSelect == 6 ; Play with myself
		;Debug.SendAnimationEvent(PlayerRef , "DDZazHornyB")
		If !PlayerRef.HasSpell(_SLS_TeaseMyselfSpell)
			PlayWithMyselfMenu()
		Else
			PlayerRef.RemoveSpell(_SLS_TeaseMyselfSpell)
			;Debug.SendAnimationEvent(PlayerRef, "OffsetStop")
			Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
		EndIf
	ElseIf MenuSelect == 7
		DanceRootMenu()
		GoToState("Dance")
	EndIf
EndFunction

Int Function ShowSelfMenu()
	String MouthString = "Open Mouth"
	If sslBaseExpression.IsMouthOpen(PlayerRef)
		MouthString = "Close Mouth"
	EndIf
	String CoverString = "Cover Myself"
	If CoverMyself.GetState() == "Covered"
		CoverString = "Uncover Myself"
	EndIf
	String LookString = "Look At"
	If LookAtTarget
		LookString = "Stop Looking At"
	EndIf
	String PlayWithMyselfString = "Play With Myself"
	If PlayerRef.HasSpell(_SLS_TeaseMyselfSpell)
		PlayWithMyselfString = "Stop Playing"
	EndIf

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	;UIExtensions.InitMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = CoverString)	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = MouthString)
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Tongue ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = LookString)
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 4, value = "Change Stance")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 5, value = "Emote ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 6, value = PlayWithMyselfString)
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 7, value = "Dance ")

	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = CoverString)
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = MouthString)
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Tongue ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = LookString)
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 4, value = "Change Stance")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 5, value = "Emote ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 6, value = PlayWithMyselfString)
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 7, value = "Dance ")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = _SLS_BodyCoverStatus.GetValueInt() == 0)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = !Devious.IsPlayerGagged())
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = Devious.CanDoOral(PlayerRef))
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 7, value = true)

	Return wheelMenu.OpenMenu()
EndFunction

Function EmoteMenu(Bool IsShortcut = false)
	Int MenuSelect = ShowEmoteMenu()
	If MenuSelect == -1 && !IsShortcut
		SelfMenu()
	ElseIf MenuSelect == 0
		PlayerRef.ClearExpressionOverride()
		PlayerRef.SetExpressionOverride(7, 0)
		GoToState("Emote")
	ElseIf MenuSelect >= 1 && MenuSelect <= 7
		;EmoteStrenthMenu(7 + MenuSelect)
		PlayerRef.SetExpressionOverride(7 + MenuSelect, 100)
		GoToState("Emote")
	Else
		AhegaoMenu()
	EndIf
EndFunction

Int Function ShowEmoteMenu()
	;/
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Clear ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Anger ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Fear ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Happy ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 4, value = "Sad ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 5, value = "Surprise ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 6, value = "Puzzled ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 7, value = "Disgusted ")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Clear ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Anger ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Fear ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Happy ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 4, value = "Sad ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 5, value = "Surprise ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 6, value = "Puzzled ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 7, value = "Disgusted ")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 7, value = true)
	
	Return wheelMenu.OpenMenu()
	/;
	
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("Clear")
	ListMenu.AddEntryItem("Anger ")
	ListMenu.AddEntryItem("Fear ")
	ListMenu.AddEntryItem("Happy ")
	ListMenu.AddEntryItem("Sad ")
	ListMenu.AddEntryItem("Surprise ")
	ListMenu.AddEntryItem("Puzzled ")
	ListMenu.AddEntryItem("Disgusted ")
	ListMenu.AddEntryItem("Ahegao ")
	ListMenu.OpenMenu()
	Return ListMenu.GetResultInt()
EndFunction

Function AhegaoMenu(Bool IsShortcut = false)
	Actor akActor = XhairTarget as Actor
	If !akActor
		akActor = PlayerRef
	EndIf
	
	Int MenuResult = ShowAhegaoMenu()
	If MenuResult == -1
		EmoteMenu()
	ElseIf MenuResult == 0
		AhegaoClear(akActor)
		GoToState("Ahegao")
	ElseIf MenuResult == 1
		AhegaoFaceRandom(akActor)
		GoToState("Ahegao")
	Else
		AhegaoFace(akActor, JsonUtil.StringListGet("SL Survival/AhegaoFaces.json", "facelist", MenuResult - 2))
		GoToState("Ahegao")
	EndIf
EndFunction

Int Function ShowAhegaoMenu()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("Clear ")
	ListMenu.AddEntryItem("Random ")
	Int i = 0
	While i < JsonUtil.StringListCount("SL Survival/AhegaoFaces.json", "facelist")
		ListMenu.AddEntryItem(JsonUtil.StringListGet("SL Survival/AhegaoFaces.json", "facelist", i))
		i += 1
	EndWhile
	ListMenu.OpenMenu()
	Return ListMenu.GetResultInt()
EndFunction

;/
Function EmoteStrenthMenu(Int Emote)
	Int MenuSelect = ShowEmoteStrengthMenu()
	If MenuSelect == -1
		EmoteMenu()
	ElseIf MenuSelect >= 0 && MenuSelect <= 4
		PlayerRef.SetExpressionOverride(Emote, 25 + (25 * MenuSelect))
	EndIf
EndFunction

Int Function ShowEmoteStrengthMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "25% ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "50% ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "75% ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "100% ")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 4, value = "100% ")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 5, value = "Surprise ")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 6, value = "Puzzled ")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 7, value = "Disgusted ")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "25% ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "50% ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "75% ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "100% ")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 4, value = "100% ")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 5, value = "Surprise ")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 6, value = "Puzzled ")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 7, value = "Disgusted ")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = true)
	;wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 4, value = true)
	;wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 5, value = true)
	;wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 6, value = true)
	;wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 7, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction
/;
; ZazCaptiveBoundKneeling_Enter - kneeling, hands behind back, fidgeting. Doesn't look

; ZazBellyDance_Enter

; ZazAPCYKNA1 - Kneel with arms in yoke
; ZazAPCYKNA2 - Same ^
; ZazAPCYKNB1 - Same ^

Function ChangeStanceMenu(Bool IsShortcut = false)
	Int MenuSelect = ShowChangeStanceMenu()
	If MenuSelect == -1 && !IsShortcut
		SelfMenu()
	ElseIf MenuSelect == 0
		ToggleCrawl()
		GoToState("Crawl")
	ElseIf MenuSelect == 1
		ToggleKneel()
		GoToState("Kneel")
	ElseIf MenuSelect == 2
		BendOverMenu()
		;Debug.SendAnimationEvent(PlayerRef , "SLS_BendOver")
	ElseIf MenuSelect == 3
		ChangeAnimationSetMenu()
		GoToState("SexyMove")
	EndIf
EndFunction

Function BendOverMenu(Bool IsShortcut = false)
	Int MenuSelect = ShowBendOverMenu()
	
	If MenuSelect == -1 && !IsShortcut
		ChangeStanceMenu()
	ElseIf MenuSelect == 0
		Debug.SendAnimationEvent(PlayerRef , "SLS_BendOver_BendOver1")
		IsBendingOver = true
		StorageUtil.SetIntValue(None, "_STA_ForbidSpankStaggers", 1)
		Game.DisablePlayerControls(true, !Game.IsFightingControlsEnabled(), !Game.IsCamSwitchControlsEnabled(), !Game.IsLookingControlsEnabled(), !Game.IsSneakingControlsEnabled(), !Game.IsMenuControlsEnabled(), !Game.IsActivateControlsEnabled(), !Game.IsJournalControlsEnabled())
		_SLS_SpankRandomPeriodicQuest.Start()
		GoToState("BendOver")
	ElseIf MenuSelect == 1
		Debug.SendAnimationEvent(PlayerRef , "SLS_BendOver_GetUp1")
		IsBendingOver = false
		Game.EnablePlayerControls(true, Game.IsFightingControlsEnabled(), Game.IsCamSwitchControlsEnabled(), Game.IsLookingControlsEnabled(), Game.IsSneakingControlsEnabled(), Game.IsMenuControlsEnabled(), Game.IsActivateControlsEnabled(), Game.IsJournalControlsEnabled())
		_SLS_SpankRandomPeriodicQuest.Stop()
		StorageUtil.SetIntValue(None, "_STA_ForbidSpankStaggers", 0)
		GoToState("BendOver")
	ElseIf MenuSelect == 2
		Debug.SendAnimationEvent(PlayerRef , "SLS_BendOver_Twerk1")
		GoToState("BendOver")
	ElseIf MenuSelect == 3
		Debug.SendAnimationEvent(PlayerRef , "SLS_BendOver_OfferBj1")
		GoToState("BendOver")
	EndIf		
EndFunction

Int Function ShowBendOverMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Bend Over")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Get up")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Twerk")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Bj")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Bend Over")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Get up")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Twerk")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Bj")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = !IsBendingOver)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = IsBendingOver)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = IsBendingOver)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = IsBendingOver)
	
	Return wheelMenu.OpenMenu()
EndFunction

Int Function ShowChangeStanceMenu()
	String CrawlString = "Crawl "
	If Init.IsCrawling
		CrawlString = "Stop Crawling"
	EndIf
	
	String KneelString = "Kneel "
	If Init.IsKneeling
		KneelString = "Stop Kneeling"
	EndIf

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = CrawlString)
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = KneelString)
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Bend Over")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Sexy Move")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = CrawlString)
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = KneelString)
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Bend Over")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Sexy Move")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = !Init.IsKneeling)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = !Init.IsCrawling)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = (!Init.IsKneeling && !Init.IsCrawling))
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = (!Init.IsKneeling && !Init.IsCrawling) && Game.GetModByName("FNISSexyMove.esp") != 255)
	
	Return wheelMenu.OpenMenu()
EndFunction

Function ChangeAnimationSetMenu(Bool IsShortcut = false)
	Int MenuSelect = ShowChangeAnimationSetMenu()
	If MenuSelect == -1 && !IsShortcut
		ShowSelfMenu()
	Else
		SexyMove.ChangeAnimationSet(MenuSelect, PlayerRef)
	EndIf

	;(Game.GetFormFromFile(0x0012C7, "FNISSexyMove.esp") as FNISSMConfigMenu).set_SMplayer(MenuSelect) ; Function call fails and causes log spam because the Mcm is expected to be open
EndFunction

Int Function ShowChangeAnimationSetMenu(Bool IsShortcut = false)
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("No Sexy Move: Default ")
	ListMenu.AddEntryItem("Sexy Move 1: Female Animation")
	ListMenu.AddEntryItem("Sexy Move 2: A Bit Sexy")
	Int i = 3
	While i < 9
		ListMenu.AddEntryItem("Sexy Move " + i)
		i += 1
	EndWhile
	ListMenu.AddEntryItem("Sexy Move 9: Very Sexy")
	ListMenu.OpenMenu()
	;Debug.Messagebox(ListMenu.GetResultInt())
	Return ListMenu.GetResultInt()
EndFunction

Function ToggleKneel()
	If Init.IsKneeling
		Game.EnablePlayerControls(true, true, Game.IsCamSwitchControlsEnabled(), Game.IsLookingControlsEnabled(), Game.IsSneakingControlsEnabled(), Game.IsMenuControlsEnabled(), Game.IsActivateControlsEnabled(), Game.IsJournalControlsEnabled())
		Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
	Else
		Debug.SendAnimationEvent(PlayerRef , "ZazCaptiveBoundKneeling_Enter")
		Game.DisablePlayerControls(true, true, !Game.IsCamSwitchControlsEnabled(), !Game.IsLookingControlsEnabled(), !Game.IsSneakingControlsEnabled(), !Game.IsMenuControlsEnabled(), !Game.IsActivateControlsEnabled(), !Game.IsJournalControlsEnabled())
		RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
	EndIf
	Init.IsKneeling = !Init.IsKneeling
EndFunction

Event OnAnimationEnd(int tid, bool HasPlayer)
	If HasPlayer
		; AnimationEnd restores player controls and makes standing
		Init.IsKneeling = false
		UnRegisterForModEvent("HookAnimationEnd")
	EndIf
EndEvent

Function PlayWithMyselfMenu(Bool IsShortcut = false)
	Int MenuSelect = ShowPlayWithMyselfMenu()
	If MenuSelect == -1 && !IsShortcut ; Back
		SelfMenu()
	ElseIf MenuSelect == 0 ; Tease
		;Debug.SendAnimationEvent(PlayerRef, HornyAnimsList[Utility.RandomInt(0, HornyAnimsList.Length - 1)])
		PlayerRef.AddSpell(_SLS_TeaseMyselfSpell, false)
		GoToState("Tease")
	ElseIf MenuSelect == 1 ; Masturbate
		Masturbate()
		GoToState("Masturbate")
	EndIf
EndFunction

Function Masturbate()
	sslBaseAnimation Anim = ShowMasturbationList()
	If Anim == None ; Back
		ShowPlayWithMyselfMenu()
	Else
		Main.Masturbate(PlayerRef, Anim)
	EndIf
EndFunction

sslBaseAnimation Function ShowMasturbationList()
	String AnimTags = "Solo"
	If PlayerRef.GetActorBase().GetSex() == 1
		AnimTags += ",F"
	Else
		AnimTags += ",M"
	EndIf
	String SuppressTags = ""
	sslBaseAnimation[] animations = Main.GetAnims(1, false, AnimTags, SuppressTags)

	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("Random ")
	Int i = 0
	While i < animations.Length
		ListMenu.AddEntryItem(animations[i].Name)
		i += 1
	EndWhile
	ListMenu.OpenMenu(PlayerRef)
	Int Result = ListMenu.GetResultInt()
	If Result == -1 ; Back
		Return None
	ElseIf Result == 0 ; Random
		Return animations[Utility.RandomInt(0, animations.Length - 1)]
	Else
		Return animations[Result - 1]
	EndIf
EndFunction

Int Function ShowPlayWithMyselfMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Tease ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Masturbate ")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Tease & Masturbate")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Tease ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Masturbate ")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Tease & Masturbate")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	;wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	Return wheelMenu.OpenMenu(PlayerRef)
EndFunction

Function DanceRootMenu(Bool IsShortcut = false)
	If Devious.AreHandsAvailable(PlayerRef)
		Int MenuSelect = ShowDanceRootMenu()
		If MenuSelect == -1 && !IsShortcut
			SelfMenu()
		ElseIf MenuSelect == 0
			Dance.EndDance(PlayerRef)
		ElseIf MenuSelect == 1
			Dance.BeginDance(PlayerRef, Dance.DancesList[Utility.RandomInt(2, Dance.DancesList.Length - 1)])
		ElseIf MenuSelect > 1
			;Dance.BeginDance(PlayerRef, Dance.DancesList[MenuSelect])
			DanceMenu(MenuSelect)
		EndIf
		
	Else
		Debug.Notification("I can't dance with my hands tied")
	EndIf
EndFunction

Int Function ShowDanceRootMenu()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	Int i = 0
	While i < Dance.DanceMods.Length
		ListMenu.AddEntryItem(Dance.DanceMods[i])
		i += 1
	EndWhile
	ListMenu.OpenMenu()
	;Debug.Messagebox(ListMenu.GetResultInt())
	Return ListMenu.GetResultInt()
EndFunction

Function DanceMenu(Int ModSelect)
	Int Result = ShowDanceMenu(ModSelect)
	If Result == -1
		DanceRootMenu()
	Else
		Dance.BeginDance(PlayerRef, Dance.SelectedDanceList[Result])
	EndIf
EndFunction

Int Function ShowDanceMenu(Int ModSelect)
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	Dance.SetSelectedDanceList(ModSelect)
	Int i = 0
	While i < Dance.SelectedDanceList.Length
		ListMenu.AddEntryItem(Dance.SelectedDanceList[i])
		i += 1
	EndWhile
	ListMenu.OpenMenu()
	;Debug.Messagebox(ListMenu.GetResultInt())
	Return ListMenu.GetResultInt()
EndFunction

Function TongueMenu(Bool IsShortcut = false)
	Int MenuSelect = ShowTongueMenu()
	If MenuSelect == -1 && !IsShortcut
		SelfMenu()
	ElseIf MenuSelect >= 0
		ToggleTongue(MenuSelect)
	EndIf
EndFunction

Int Function ShowTongueMenu()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	TonguesList[0] = "Stick out tongue"
	If PlayerRef.WornHasKeyword(_SLS_TongueKeyword)
		TonguesList[0] = "Retract tongue"
	EndIf
	Int i = 0
	While i < TonguesList.Length
		ListMenu.AddEntryItem(TonguesList[i])
		i += 1
	EndWhile
	ListMenu.OpenMenu()
	;Debug.Messagebox(ListMenu.GetResultInt())
	Return ListMenu.GetResultInt()
EndFunction

Function TongueCleanup(Actor akActor)
	Int i = 0
	While i < _SLS_TonguesList.GetSize()
		If akActor.GetItemCount(_SLS_TonguesList.GetAt(i)) > 0
			If akActor.IsEquipped(_SLS_TonguesList.GetAt(i))
				akActor.RemoveItem(_SLS_TonguesList.GetAt(i), aiCount = akActor.GetItemCount(_SLS_TonguesList.GetAt(i)) - 1, abSilent = true, akOtherContainer = None)
			Else
				akActor.RemoveItem(_SLS_TonguesList.GetAt(i), aiCount = akActor.GetItemCount(_SLS_TonguesList.GetAt(i)), abSilent = true, akOtherContainer = None)
			EndIf
		EndIf
		i += 1
	EndWhile
EndFunction

Function ToggleCrawl()

	;/ ; SD way
	StorageUtil.SetStringValue(PlayerRef, "_SD_sDefaultStance", "Crawling")
	PlayerRef.SendModEvent("SLDRefreshGlobals")
	(Game.GetFormFromFile(0x000D64, "sanguinesDebauchery.esp") as _sdqs_fcts_constraints).CollarEffectStart(akTarget = PlayerRef, akCaster = PlayerRef)
	(Game.GetFormFromFile(0x000D64, "sanguinesDebauchery.esp") as _sdqs_fcts_constraints).UpdateStanceOverrides()
	/;
	
	If !Init.IsCrawling
		; Amputator way
		String ModName = "Amputator"
		Int ModID = FNIS_aa.GetAAModID("amp", "Amputator",true)
		Int mtidle_base = FNIS_aa.GetGroupBaseValue(ModID, FNIS_aa._mtidle(), "Amputator", true)
		Int mt_base = FNIS_aa.GetGroupBaseValue(ModID, FNIS_aa._mt(), "Amputator", true)
		Int mtx_base = FNIS_aa.GetGroupBaseValue(ModID, FNIS_aa._mtx(), "Amputator", true)
		Int sprint_base = FNIS_aa.GetGroupBaseValue(ModID, FNIS_aa._sprint(), "Amputator", true)
		Int mtturn_base = FNIS_aa.GetGroupBaseValue(ModID, FNIS_aa._mtturn(), "Amputator", true)
		
		Int sneakidle_base = FNIS_aa.GetGroupBaseValue(ModID, FNIS_aa._sneakidle(), "Amputator", true)
		Int sneakmt_base = FNIS_aa.GetGroupBaseValue(ModID, FNIS_aa._sneakmt(), "Amputator", true)

		;Bool bOk
		FNIS_aa.SetAnimGroup(PlayerRef,"_mtidle", mtidle_base, 0, "Amputator", true)
		FNIS_aa.SetAnimGroup(PlayerRef,"_mt", mt_base, 0, "Amputator", true)
		FNIS_aa.SetAnimGroup(PlayerRef,"_mtx", mtx_base, 0, "Amputator", true)
		FNIS_aa.SetAnimGroup(PlayerRef,"_sprint", sprint_base, 0, "Amputator", true)
		FNIS_aa.SetAnimGroup(PlayerRef,"_mtturn", mtturn_base, 0, "Amputator", true)
		
		FNIS_aa.SetAnimGroup(PlayerRef,"_sneakidle", sneakidle_base, 0, Modname, true)
		FNIS_aa.SetAnimGroup(PlayerRef,"_sneakmt", sneakmt_base, 0, Modname, true)
		
		; Game.SetGameSettingFloat("fJumpHeightMin", 10.0)
		Init.IsCrawling = true
		PlayerRef.AddPerk(_SLS_CrawlingPerk)
		FightControlsWereEnabled = Game.IsFightingControlsEnabled()
		Game.DisablePlayerControls(!Game.IsMovementControlsEnabled(), true, !Game.IsCamSwitchControlsEnabled(), !Game.IsLookingControlsEnabled(), !Game.IsSneakingControlsEnabled(), !Game.IsMenuControlsEnabled(), !Game.IsActivateControlsEnabled(), !Game.IsJournalControlsEnabled())
		
		;Debug.Messagebox("ADD")
		Friend.Wildling.CrawlToggle(True)
	
	Else
		FNIS_aa.SetAnimGroup(PlayerRef,"_mtidle", 0, 0, "Amputator", true)
		FNIS_aa.SetAnimGroup(PlayerRef,"_mt", 0, 0, "Amputator", true)
		FNIS_aa.SetAnimGroup(PlayerRef,"_mtx", 0, 0, "Amputator", true)
		FNIS_aa.SetAnimGroup(PlayerRef,"_sprint", 0, 0, "Amputator", true)
		FNIS_aa.SetAnimGroup(PlayerRef,"_mtturn", 0, 0, "Amputator", true)
		
		FNIS_aa.SetAnimGroup(PlayerRef,"_sneakidle", 0, 0, "Amputator", true)
		FNIS_aa.SetAnimGroup(PlayerRef,"_sneakmt", 0, 0, "Amputator", true)
		
		Init.IsCrawling = false
		PlayerRef.RemovePerk(_SLS_CrawlingPerk)
		Game.EnablePlayerControls(Game.IsMovementControlsEnabled(), (FightControlsWereEnabled || Game.IsFightingControlsEnabled()), Game.IsCamSwitchControlsEnabled(), Game.IsLookingControlsEnabled(), Game.IsSneakingControlsEnabled(), Game.IsMenuControlsEnabled(), Game.IsActivateControlsEnabled(), Game.IsJournalControlsEnabled())
		;Debug.Messagebox("remove")
		Friend.Wildling.CrawlToggle(false)
	EndIf
	Quest _SLS_CreatureFleeAliases = Game.GetFormFromFile(0x1194B6, "SL Survival.esp") as Quest
	Int i = 0
	Actor Creature
	While i < _SLS_CreatureFleeAliases.GetNumAliases()
		Creature = (_SLS_CreatureFleeAliases.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If Creature
			Creature.EvaluatePackage()
		Else
			Return
		EndIf
		i += 1
	EndWhile
EndFunction

Function BeginLookAt(ObjectReference akTarget = None, Bool MoveMarker = true)
	If LookAtTarget && !akTarget
		ClearLookAtTarget()
	Else
		If !akTarget
			akTarget = ShowLookAtMenulist()
		EndIf
		;Debug.Messagebox("akTarget: " + akTarget)
		If !akTarget
			ShowSelfMenu()
		ElseIf akTarget == _SLS_LookAtMarkerRef
			RegisterForAnimationEvent(PlayerRef, "FootLeft")
			RegisterForAnimationEvent(PlayerRef, "FootRight")
			If MoveMarker
				_SLS_LookAtMarkerRef.MoveTo(PlayerRef, 100.0 * Math.Sin(PlayerRef.GetAngleZ()), 100.0 * Math.Cos(PlayerRef.GetAngleZ()), PlayerRef.GetHeight() - 80.0)
			EndIf
			IsLookingSubmissively = true
		Else
			IsLookingSubmissively = false
		EndIf
		PlayerIsNpcVar = PlayerRef.GetAnimationVariableInt("IsNPC")
		;PlayerRef.ClearLookAt()
		PlayerRef.SetAnimationVariableInt("IsNPC", 1)
		PlayerRef.SetLookAt(akTarget)
		LookAtTarget = akTarget
	EndIf
EndFunction

Function ClearLookAtTarget(Int ForcePlayerIsNpcTo = -1)
	If ForcePlayerIsNpcTo > -1
		PlayerRef.SetAnimationVariableInt("IsNPC", ForcePlayerIsNpcTo)
	Else
		PlayerRef.SetAnimationVariableInt("IsNPC", PlayerIsNpcVar)
	EndIf
	PlayerRef.ClearLookAt()
	UnRegisterForAnimationEvent(PlayerRef, "FootLeft")
	UnRegisterForAnimationEvent(PlayerRef, "FootRight")
	LookAtTarget = None
	IsLookingSubmissively = false
EndFunction

Event OnAnimationEvent(ObjectReference aktarg, String EventName)
	_SLS_LookAtMarkerRef.MoveTo(PlayerRef, 100.0 * Math.Sin(PlayerRef.GetAngleZ()), 100.0 * Math.Cos(PlayerRef.GetAngleZ()), PlayerRef.GetHeight() - 80.0)
	;Debug.Messagebox("Event")
EndEvent

ObjectReference Function ShowLookAtMenulist()
	_SLS_LookAtSearchQuest.Stop()
	_SLS_LookAtSearchQuest.Start()
	
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("Feet")
	Int i = 0
	Actor akTarget
	While i < _SLS_LookAtSearchQuest.GetNumAliases()
		akTarget = (_SLS_LookAtSearchQuest.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If akTarget
			ListMenu.AddEntryItem(akTarget.GetBaseObject().GetName())
		EndIf
		i += 1
	EndWhile
	ListMenu.OpenMenu()
	Int Result = ListMenu.GetResultInt()
	If Result == -1
		Return None
	ElseIf Result == 0 ; Feet
		Return _SLS_LookAtMarkerRef
	Else
		Return (_SLS_LookAtSearchQuest.GetNthAlias(Result - 1) as ReferenceAlias).GetReference() as ObjectReference
	EndIf
EndFunction

Function ToggleTongue(Int MenuSelect)
	If MenuSelect == 0 ; Stick out / retract
		If PlayerRef.WornHasKeyword(_SLS_TongueKeyword) ; Retract
			Form akTongue = PlayerRef.GetWornForm(TongueSlotMask)
			PlayerRef.UnequipItem(akTongue, abPreventEquip = false, abSilent = true)
			PlayerRef.RemoveItem(akTongue, 10, abSilent = true)
		Else ; Stick out
			Form akTongue = _SLS_TonguesList.GetAt(LastTongue)
			If akTongue && akTongue.HasKeyword(_SLS_TongueKeyword)
				If !sslBaseExpression.IsMouthOpen(PlayerRef)
					CumSwallow.OnKeyDown(0)
				EndIf
				PlayerRef.AddItem(akTongue, 1, abSilent = true)
				PlayerRef.EquipItem(akTongue, abSilent = true)
			EndIf
			If Game.GetCameraState() == 3
				;Game.ForceThirdPerson() ; Tongue doesn't visually equip in freecam and QueueNiNodeUpdate closes the mouth again. Resort to bullshitery
				PlayerRef.QueueNiNodeUpdate()
			EndIf
		EndIf
		
	Else ; Select tongue
		Form akTongue
		If PlayerRef.WornHasKeyword(_SLS_TongueKeyword) ; Unequip old tongue
			akTongue = PlayerRef.GetWornForm(TongueSlotMask)
			If akTongue && akTongue.HasKeyword(_SLS_TongueKeyword)
				PlayerRef.UnequipItem(akTongue, abPreventEquip = false, abSilent = true)
				PlayerRef.RemoveItem(akTongue, 10, abSilent = true)
			EndIf
		EndIf
		
		If !sslBaseExpression.IsMouthOpen(PlayerRef)
			CumSwallow.OnKeyDown(0)
		EndIf
		If MenuSelect == 1 ; Random
			MenuSelect = Utility.RandomInt(0, _SLS_TonguesList.GetSize() - 1)
		EndIf
		akTongue = _SLS_TonguesList.GetAt(MenuSelect - 2)
		PlayerRef.AddItem(akTongue, 1, abSilent = true)
		PlayerRef.EquipItem(akTongue, abSilent = true)
		;TongueSlotMask = (akTongue as Armor).GetSlotMask()
		If Game.GetCameraState() == 3
			;Game.ForceThirdPerson() ; Tongue doesn't visually equip in freecam and QueueNiNodeUpdate closes the mouth again. Resort to bullshitery
			PlayerRef.QueueNiNodeUpdate()
		EndIf
		LastTongue = MenuSelect + 2
	EndIf

;/
	If PlayerRef.WornHasKeyword(_SLS_TongueKeyword)
		Form akTongue = PlayerRef.GetWornForm(0x00100000)
		If akTongue && akTongue.HasKeyword(_SLS_TongueKeyword)
			PlayerRef.UnequipItem(akTongue, abPreventEquip = false, abSilent = true)
			PlayerRef.RemoveItem(akTongue, 10, abSilent = true)
		EndIf
	Else
		Form akTongue
		If MenuSelect == -1
			akTongue = _SLS_TonguesList.GetAt(Utility.RandomInt(0, _SLS_TonguesList.GetSize() - 1))
		Else
			akTongue = _SLS_TonguesList.GetAt(MenuSelect)
		EndIf
		PlayerRef.AddItem(akTongue, 1, abSilent = false)
		PlayerRef.EquipItem(akTongue, abSilent = false)

		If Game.GetCameraState() == 3
			Game.ForceThirdPerson() ; Tongue doesn't visually equip in freecam and QueueNiNodeUpdate closes the mouth again. Resort to bullshitery
		EndIf
	EndIf
	/;
EndFunction

Function AhegaoClear(Actor akActor)
	Form akTongue
	If akActor.WornHasKeyword(_SLS_TongueKeyword) ; Unequip old tongue
		akTongue = akActor.GetWornForm(TongueSlotMask)
		If akTongue && akTongue.HasKeyword(_SLS_TongueKeyword)
			akActor.UnequipItem(akTongue, abPreventEquip = false, abSilent = true)
			akActor.RemoveItem(akTongue, 10, abSilent = true)
		EndIf
	EndIf
	Utility.Wait(0.5)
	sslBaseExpression.ClearPhoneme(akActor)
	MfgConsoleFunc.ResetPhonemeModifier(akActor)

	StorageUtil.SetIntValue(PlayerRef, "Sexlab.ManualMouthOpen", 0)
	StorageUtil.IntListClear(akActor, "_SLS_AhegaoExpression")
EndFunction

Function AhegaoFaceRandom(Actor akActor)
	AhegaoFace(akActor, JsonUtil.StringListGet("SL Survival/AhegaoFaces.json", "facelist", Utility.RandomInt(0, JsonUtil.StringListCount("SL Survival/AhegaoFaces.json", "facelist") - 1)))
EndFunction

Function AhegaoFace(Actor akActor, String Face)
	AhegaoClear(akActor)
	Int[] AhegaoValues = JsonUtil.IntListToArray("SL Survival/AhegaoFaces.json", Face)
	StorageUtil.IntListCopy(akActor, "_SLS_AhegaoExpression", AhegaoValues)
	
	Form akTongue
	If akActor.WornHasKeyword(_SLS_TongueKeyword) ; Unequip old tongue
		akTongue = akActor.GetWornForm(TongueSlotMask)
		If akTongue && akTongue.HasKeyword(_SLS_TongueKeyword)
			akActor.UnequipItem(akTongue, abPreventEquip = false, abSilent = true)
			akActor.RemoveItem(akTongue, 10, abSilent = true)
		EndIf
	EndIf
	
	Int TongueSelect = JsonUtil.IntListGet("SL Survival/AhegaoFaces.json", Face, 6)
	If TongueSelect == -1 ; Random
		ToggleTongue(1)
	ElseIf TongueSelect >= 0 ; Specific
		ToggleTongue(TongueSelect + 2)
	EndIf
	
	DoAhegaoExpression(akActor, AhegaoValues)
	;/
	akActor.SetExpressionOverride(JsonUtil.IntListGet("SL Survival/AhegaoFaces.json", Face, 0), JsonUtil.IntListGet("SL Survival/AhegaoFaces.json", Face, 1))
	MfgConsoleFunc.SetPhoneme(akActor, id = JsonUtil.IntListGet("SL Survival/AhegaoFaces.json", Face, 2), value = JsonUtil.IntListGet("SL Survival/AhegaoFaces.json", Face, 3))
	MfgConsoleFunc.SetModifier(akActor, id = JsonUtil.IntListGet("SL Survival/AhegaoFaces.json", Face, 4), value = JsonUtil.IntListGet("SL Survival/AhegaoFaces.json", Face, 5))
	/;
	;Utility.Wait(0.5)
	
	StorageUtil.SetIntValue(PlayerRef, "Sexlab.ManualMouthOpen", 2)
EndFunction

Function DoAhegaoExpression(Actor akActor, Int[] AhegaoValues)
	;Debug.Messagebox("Doing ahegao")
	akActor.SetExpressionOverride(AhegaoValues[0], AhegaoValues[1])
	MfgConsoleFunc.SetPhoneme(akActor, AhegaoValues[2], AhegaoValues[3])
	MfgConsoleFunc.SetModifier(akActor, AhegaoValues[4], AhegaoValues[5])
EndFunction

; Actions Menu ======================================================================================================

Function ActionsMenu(Bool IsShortcut = false)
	Int MenuSelect = ShowActionsMenu()
	If MenuSelect == -1 && !IsShortcut
		MainMenu()
	ElseIf MenuSelect == 0
		OutfitMenu()
		GoToState("Outfits")
	ElseIf MenuSelect == 1
		MoreActionsMenu()
	ElseIf MenuSelect == 2
		ToggleAutoFuck()
		GoToState("AutoFuck")
	ElseIf MenuSelect == 3
		CumMenu()
	ElseIf MenuSelect == 4
		GoToState("Waiting")
		WaitMenu()
	ElseIf MenuSelect == 5

	ElseIf MenuSelect == 6

	ElseIf MenuSelect == 7

	EndIf
EndFunction

Int Function ShowActionsMenu()
	String AutoFuckStr = "Start Fucking"
	If CompulsiveSex.IsFucking
		AutoFuckStr = "Stop Fucking"
	EndIf
	
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Outfits ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "More Actions")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = AutoFuckStr)
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Cum ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 4, value = "Wait ")

	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Outfits ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "More Actions")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = AutoFuckStr)
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Cum ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 4, value = "Wait ")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = PlayerRef.IsInFaction(CompulsiveSex.SexlabAnimatingFaction))
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 4, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction

Function WaitMenu()
	Int MenuResult = ShowWaitMenu()
	If MenuResult == 0
		Util.GameHour.Mod((1.0 / 60.0) * 5.0)
	ElseIf MenuResult == 1
		Util.GameHour.Mod((1.0 / 60.0) * 10.0)
	ElseIf MenuResult == 2
		Util.GameHour.Mod((1.0 / 60.0) * 15.0)
	ElseIf MenuResult == 3
		Util.GameHour.Mod((1.0 / 60.0) * 30.0)
	ElseIf MenuResult == 4
		Util.GameHour.Mod((1.0 / 60.0) * 45.0)
	ElseIf MenuResult == 5
		Util.GameHour.Mod(1.0)
	EndIf
EndFunction

Int Function ShowWaitMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "5 Minutes")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "10 Minutes")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "15 Minutes")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "30 Minutes")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 4, value = "45 Minutes")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 5, value = "1 Hour")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "5 Minutes")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "10 Minutes")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "15 Minutes")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "30 Minutes")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 4, value = "45 Minutes")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 5, value = "1 Hour")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 5, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction

Function CumMenu(Bool IsShortcut = false)
	Int MenuSelect = ShowCumMenu()
	If MenuSelect == -1 && !IsShortcut
		ActionsMenu()
	ElseIf MenuSelect == 0
		Fhu.DrainCum()
		GoToState("DrainCum")
	ElseIf MenuSelect == 1
		CollectCumMenu()
		GoToState("CollectCum")
	ElseIf MenuSelect == 2
		ShowCumPotionList(PlayerRef)
		GoToState("PourCum")
	EndIf
EndFunction

Int Function ShowCumMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Drain Cum")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Collect Cum")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Pour Cum")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Drain Cum")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Collect Cum")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Pour Cum")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = Game.GetModByName("sr_FillHerUp.esp") != 255)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction

Function CollectCumMenu(Bool IsShortcut = false)
	If Bis.GetPlayerDirt() < 0.6
		If Devious.AreHandsAvailable(PlayerRef)
			Int MenuSelect = ShowCollectCumMenu()
			If MenuSelect == -1 && !IsShortcut
				CumMenu()
			ElseIf MenuSelect == 0
				CumAddict.FillCumtainerFromFace(PlayerRef)
			ElseIf MenuSelect == 1
				CumAddict.FillCumtainerFromPussy(PlayerRef)
			ElseIf MenuSelect == 2
				CumAddict.FillCumtainerFromAss(PlayerRef)
			EndIf
		
		Else
			Debug.Notification("I can't do that with my hands tied")
		EndIf
	Else
		Debug.Notification("I'm too dirty to recover any cum")
	EndIf
EndFunction

Int Function ShowCollectCumMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "From My Face & Tits")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "From My Pussy & Belly")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "From My Ass & Back")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "From My Face & Tits")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "From My Pussy & Belly")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "From My Ass & Back")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = Sexlab.CountCumOral(PlayerRef) >= 2)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = Sexlab.CountCumVaginal(PlayerRef) >= 2)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = Sexlab.CountCumAnal(PlayerRef) >= 2)
	
	Return wheelMenu.OpenMenu()
EndFunction

Function PourCumMenu(Form CumPotion, Actor akActor, Bool IsShortcut = false)
	If Devious.AreHandsAvailable(akActor)
		;Debug.Messagebox(CumPotion)
		Int MenuSelect = ShowPourCumMenu()
		Bool LargeLoad = CumPotion.GetWorldModelPath() == "SL Survival\\CumPotions\\great.nif" || CumPotion.GetWorldModelPath() == "SL Survival\\CumPotions\\extreme.nif"
		;Debug.Messagebox(CumPotion.GetWorldModelPath() + "\nLargeLoad: " + LargeLoad + "\nCumType: " + StorageUtil.GetFormValue(CumPotion, "_SLS_CumPotionSource"))
		
		If MenuSelect == -1 && !IsShortcut
			CumMenu()
		ElseIf MenuSelect == 0
			Debug.SendAnimationEvent(PlayerRef, "IdleDrinkPotion")
			Utility.Wait(1.5)
			Sexlab.AddCum(akActor, Vaginal = false, Oral = true, Anal = false)
			StorageUtil.SetFormValue(PlayerRef, "_SLS_LastCumTypeForPotionOral", StorageUtil.GetFormValue(CumPotion, "_SLS_CumPotionSource"))
			If LargeLoad
				Utility.Wait(1.0)
				Sexlab.AddCum(akActor, Vaginal = false, Oral = true, Anal = false)
			EndIf
			PlayerRef.RemoveItem(CumPotion, 1)
			PlayerRef.AddItem(CumAddict._SLS_CumEmptySpent)
		ElseIf MenuSelect == 1
			Sexlab.AddCum(akActor, Vaginal = true, Oral = false, Anal = false)
			StorageUtil.SetFormValue(PlayerRef, "_SLS_LastCumTypeForPotionVaginal", StorageUtil.GetFormValue(CumPotion, "_SLS_CumPotionSource"))
			If LargeLoad
				Utility.Wait(1.0)
				Sexlab.AddCum(akActor, Vaginal = true, Oral = false, Anal = false)
			EndIf
			PlayerRef.RemoveItem(CumPotion, 1)
			PlayerRef.AddItem(CumAddict._SLS_CumEmptySpent)
		ElseIf MenuSelect == 2
			Sexlab.AddCum(akActor, Vaginal = false, Oral = false, Anal = true)
			StorageUtil.SetFormValue(PlayerRef, "_SLS_LastCumTypeForPotionAnal", StorageUtil.GetFormValue(CumPotion, "_SLS_CumPotionSource"))
			If LargeLoad
				Utility.Wait(1.0)
				Sexlab.AddCum(akActor, Vaginal = false, Oral = false, Anal = true)
			EndIf
			PlayerRef.RemoveItem(CumPotion, 1)
			PlayerRef.AddItem(CumAddict._SLS_CumEmptySpent)
		EndIf
		
	Else
		Debug.Notification("I can't do that with my hands tied")
	EndIf
EndFunction

Int Function ShowPourCumMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "On My Face & Tits")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "On My Pussy & Belly")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "On My Ass & Back")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "On My Face & Tits")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "On My Pussy & Belly")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "On My Ass & Back")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction

Function ShowCumPotionList(Actor akActor)
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("Back ")
	StorageUtil.FormListClear(Self, "_SLS_CumPotionListTemp")
	Int i = _SLS_CumPotionAll.GetSize()
	While i > 0
		i -= 1
		If akActor.GetItemCount(_SLS_CumPotionAll.GetAt(i)) > 0
			ListMenu.AddEntryItem(_SLS_CumPotionAll.GetAt(i).GetName())
			StorageUtil.FormListAdd(Self, "_SLS_CumPotionListTemp", _SLS_CumPotionAll.GetAt(i))
		EndIf
	EndWhile
	ListMenu.OpenMenu()
	Int Result = ListMenu.GetResultInt()
	If Result > 0
		PourCumMenu(StorageUtil.FormListGet(Self, "_SLS_CumPotionListTemp", Result - 1), PlayerRef)
	EndIf
	;Return ListMenu.GetResultInt()
EndFunction

Function MoreActionsMenu(Bool IsShortcut = false)
	Int MenuResult = ShowMoreActionsMenu()
	If MenuResult == -1
		ActionsMenu()
	ElseIf MenuResult == 0
		_SLS_ScreamForHelpSpell.Cast(PlayerRef, PlayerRef)
		GoToState("CryForHelp")
	ElseIf MenuResult == 1
		SpankNpc()
		GoToState("SpankNpc")
	ElseIf MenuResult == 2
		Mme.MilkPlayer()
		GoToState("MilkMyself")
	ElseIf MenuResult == 3
		UntieNpc()
		GoToState("UntieNpc")
	ElseIf MenuResult == 4
		TattooNpc()
		GoToState("TattooNpc")
	ElseIf MenuResult == 5
		BegForCockMenu()
	;ElseIf MenuResult == 7
	
	EndIf
EndFunction

Int Function ShowMoreActionsMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Cry For Help")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Spank Npc")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Milk Myself")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Devices ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 4, value = "Tattoo Npc")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 5, value = "Beg For Cock")

	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Cry For Help")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Spank Npc")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Milk Myself")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Devices ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 4, value = "Tattoo Npc")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 5, value = "Beg For Cock")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = Game.GetModByName("Spank That Ass.esp") != 255)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = (Game.GetModByName("MilkModNEW.esp") != 255) && StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkCount", Missing = -1.0) >= 1.0)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = (Game.GetModByName("Devious Devices - Expansion.esm") != 255))
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 4, value = XhairTarget as Actor)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 5, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction

Function ToggleAutoFuck()
	If CompulsiveSex.IsFucking
		If PlayerRef.GetFactionRank(Game.GetFormFromFile(0x03FC36, "SexLabAroused.esm") as Faction) < 100
			CompulsiveSex.ManualStopFucking()
		Else
			Debug.Notification("No way am I stopping now")
		EndIf
	Else
		CompulsiveSex.BeginAutoFucking(tid = -1, HasPlayer = false, ManualStart = true)
	EndIf
EndFunction

Function UntieNpc(Bool IsShortcut = false)
	Int MenuSelect = ShowUntieNpcMenu()
	If MenuSelect == -1 && !IsShortcut
		UntieActorDevices = new String[1]
		UntieActorDevices[0] = "_SLS_RESET"
		ActionsMenu()
	Else
		ExamineDeviceMenu()
	EndIf
EndFunction

Int Function ShowUntieNpcMenu()
	If UntieActorDevices.Length == 0 || (UntieActorDevices.Length == 1 && UntieActorDevices[0] == "_SLS_RESET")
		UntieActor = XhairTarget as Actor
		If !UntieActor
			UntieActor = PlayerRef
		EndIf
		UntieActorDevices = Devious.StringListAllDevices(UntieActor)
	EndIf
	Debug.Notification("Examining " + UntieActor.GetLeveledActorBase().GetName())
	If UntieActorDevices.Length > 0
		UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
		Int i = 0
		While i < UntieActorDevices.Length
			ListMenu.AddEntryItem(UntieActorDevices[i])
			i += 1
		EndWhile
		ListMenu.OpenMenu()
		;Debug.Messagebox(ListMenu.GetResultInt())
		UntieActorDeviceSelect = ListMenu.GetResultInt()
		Return UntieActorDeviceSelect
	EndIf
	If UntieActor == PlayerRef
		Debug.Notification("I'm not wearing any devices")
	Else
		Debug.Notification("She's not wearing any devices")
	EndIf
	Return -1
EndFunction

Function ExamineDeviceMenu(Bool IsShortcut = false)
	Int MenuResult = ShowExamineDeviceMenu()
	If MenuResult == -1
		ShowUntieNpcMenu()
	ElseIf MenuResult == 0
		Key UnlockKey = Devious.ExamineDevice(UntieActorDeviceSelect, UntieActor)
		If UnlockKey
			Debug.Messagebox("That device needs a " + UnlockKey.GetName())
		Else
			Debug.Messagebox("I don't know what key unlocks that device")
		EndIf
		Utility.Wait(0.01)
		UntieNpc()
	ElseIf MenuResult == 1
		UntieActorDevices = new String[1]
		UntieActorDevices[0] = "_SLS_RESET"
		Devious.TryUnlockNpcDevice(UntieActorDeviceSelect, UntieActor)
	EndIf
EndFunction

Int Function ShowExamineDeviceMenu()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("Examine ")
	ListMenu.AddEntryItem("Unlock ")
	ListMenu.OpenMenu()
	Return ListMenu.GetResultInt()
EndFunction

Function TattooNpc()
	Actor akActor = XhairTarget as Actor
	If akActor
		If PlayerRef.GetItemCount(Charcoal) > 0
			If (Init.PahInstalled && akActor.IsInFaction(Init.PahFaction)) || (Init.SbcInstalled && akActor.IsInFaction(Init.SbcFaction)) || (Init.ZazInstalled && akActor.IsInFaction(Init.ZazSlaveFaction)) || !Devious.AreHandsAvailable(akActor)
				Debug.SendAnimationEvent(PlayerRef, "IdleLockPick")
				RapeTats.AddRapeTat(akActor)
				PlayerRef.RemoveItem(Charcoal, 1)
			Else
				Debug.Notification(akActor.GetLeveledActorBase().GetName() + ": I don't think so!")
			EndIf
		Else
			Debug.Notification("I need some charcoal to do that")
		EndIf
	EndIf
EndFunction

Function SpankNpc()
	Actor akTarget = XhairTarget as Actor
	If akTarget
		(Game.GetFormFromFile(0x017E5E, "Spank That Ass.esp") as Spell).Cast(PlayerRef, akTarget)
	EndIf
EndFunction

; Outfits Menu ===================================================================================================

Function OutfitMenu(Bool IsShortcut = false)
	Int MenuResult = ShowOutfitMenu()
	If MenuResult == -1 && !IsShortcut
		ActionsMenu()
	ElseIf MenuResult == 0
		If IsDressed
			Undress()
		Else
			Dress()
		EndIf
	ElseIf MenuResult == 1
		SaveOutfitMenu()
	ElseIf MenuResult == 2
		EquipOutfit(OutfitForms6)
	ElseIf MenuResult == 3
		EquipOutfit(OutfitForms5)
	ElseIf MenuResult == 4
		EquipOutfit(OutfitForms1)
	ElseIf MenuResult == 5
		EquipOutfit(OutfitForms2)
	ElseIf MenuResult == 6
		EquipOutfit(OutfitForms3)
	ElseIf MenuResult == 7
		EquipOutfit(OutfitForms4)
	EndIf
EndFunction

Int Function ShowOutfitMenu()
	String StripStr = "Undress "
	If !IsDressed
		StripStr = "Get Dressed"
	EndIf
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = StripStr)
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Save Outfit")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = OutfitNames[5])
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = OutfitNames[4])
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 4, value = OutfitNames[0])
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 5, value = OutfitNames[1])
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 6, value = OutfitNames[2])
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 7, value = OutfitNames[3])

	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = StripStr)
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Save Outfit")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = OutfitNames[5])
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = OutfitNames[4])
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 4, value = OutfitNames[0])
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 5, value = OutfitNames[1])
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 6, value = OutfitNames[2])
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 7, value = OutfitNames[3])

	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 7, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction

Function SaveOutfitMenu(Bool IsShortcut = false)
	Int MenuResult = ShowSaveOutfitMenu()
	If MenuResult == -1
		OutfitMenu()
	ElseIf MenuResult == 2
		SaveOutfit(5)
	ElseIf MenuResult == 3
		SaveOutfit(4)
	ElseIf MenuResult == 4
		SaveOutfit(0)
	ElseIf MenuResult == 5
		SaveOutfit(1)
	ElseIf MenuResult == 6
		SaveOutfit(2)
	ElseIf MenuResult == 7
		SaveOutfit(3)
	EndIf
EndFunction

Int Function ShowSaveOutfitMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 4, value = "Save As Outfit 1")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 5, value = "Save As Outfit 2")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 6, value = "Save As Outfit 3")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 7, value = "Save As Outfit 4")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Save As Outfit 5")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Save As Outfit 6")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 4, value = "Save As Outfit 1")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 5, value = "Save As Outfit 2")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 6, value = "Save As Outfit 3")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 7, value = "Save As Outfit 4")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Save As Outfit 5")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Save As Outfit 6")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 7, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction

Function Undress()
	Debug.SendAnimationEvent(PlayerRef, "Arrok_Undress_G1")
	StrippedItems = new Form[32]
	Int i = 0
	Form akForm
	While i < Menu.SlotMasks.Length
		akForm = PlayerRef.GetWornForm(Menu.SlotMasks[i])
		;Debug.Trace("_SLS_: Undress(): Doing: " + i + " - " + akForm)
		If akForm && !akForm.HasKeyword(SexLabNoStrip) && akForm.GetName() != "" && akForm.IsPlayable()
			StrippedItems[i] = akForm
			PlayerRef.UnEquipItem(akForm, abPreventEquip = false, abSilent = true)
		EndIf
		i += 1
	EndWhile
	IsDressed = false
	;Debug.Trace("_SLS_: Undress(): EHHHHHH: " + PlayerRef.GetWornForm(0x80000000) + ". SlotMask: " + Menu.SlotMasks[31])
EndFunction

Function Dress()
	Debug.SendAnimationEvent(PlayerRef, "Arrok_Undress_G1")
	Int i = 0
	Form akForm
	While i < StrippedItems.Length
		akForm = StrippedItems[i]
		If akForm && PlayerRef.GetItemCount(akForm) > 0
			PlayerRef.EquipItem(akForm, abPreventRemoval = false, abSilent = true)
		EndIf
		i += 1
	EndWhile
	IsDressed = true
EndFunction

Function EquipOutfit(Form[] OutfitArray)
	If !PlayerRef.IsInFaction(CompulsiveSex.SexLabAnimatingFaction) && !PlayerRef.IsOnMount()
		Debug.SendAnimationEvent(PlayerRef, "Arrok_Undress_G1")
	EndIf
	Int i = 0
	Form akForm
	While i < OutfitArray.Length
		akForm = OutfitArray[i]
		If akForm && PlayerRef.GetItemCount(akForm) > 0
			;PlayerRef.EquipItem(akForm, abPreventRemoval = false, abSilent = true)
			PlayerRef.EquipItemEx(akForm, equipSlot = 0, preventUnequip = false, equipSound = false)
		Else
			akForm = PlayerRef.GetWornForm(Menu.SlotMasks[i])
			If akForm && !akForm.HasKeyword(SexLabNoStrip) && akForm.GetName() != "" && akForm.IsPlayable()
				;PlayerRef.UnEquipItem(akForm, abPreventEquip = false, abSilent = true)
				PlayerRef.UnequipItemEx(akForm, equipSlot = 0, preventEquip = false)
			EndIf
		EndIf
		i += 1
	EndWhile
EndFunction

Form[] Function GetOutfitArray(Int OutfitNumber)
	If OutfitNumber == 0
		Return OutfitForms1
	ElseIf OutfitNumber == 1
		Return OutfitForms2
	ElseIf OutfitNumber == 2
		Return OutfitForms3
	ElseIf OutfitNumber == 3
		Return OutfitForms4
	ElseIf OutfitNumber == 4
		Return OutfitForms5
	Else
		Return OutfitForms6
	EndIf
EndFunction

Function SaveOutfit(Int OutfitNumber)
	Form[] OutfitArray = GetOutfitArray(OutfitNumber)
	Int i = 0
	Int ItemCount = 0
	Form akForm
	While i < Menu.SlotMasks.Length
		akForm = PlayerRef.GetWornForm(Menu.SlotMasks[i])
		If akForm && !akForm.HasKeyword(SexLabNoStrip) && akForm.GetName() != "" && akForm.IsPlayable()
			OutfitArray[i] = akForm
		Else
			OutfitArray[i] = None
		EndIf
		i += 1
	EndWhile
	
	; Name outfit
	String MainName = "Outfit " + (OutfitNumber + 1)
	akForm = PlayerRef.GetWornForm(Menu.SlotMasks[2])
	If akForm && !akForm.HasKeyword(SexLabNoStrip) && akForm.GetName() != "" && akForm.IsPlayable()
		MainName = akForm.GetName()
	Else
		akForm = PlayerRef.GetWornForm(Menu.SlotMasks[Menu.HalfNakedBra - 30])
		If akForm && !akForm.HasKeyword(SexLabNoStrip) && akForm.GetName() != "" && akForm.IsPlayable()
			MainName = akForm.GetName()
		EndIf		
	EndIf
	
	MainName = (OutfitNumber + 1) + ") " + MainName
	Debug.Notification("Name this outfit")
	UITextEntryMenu TextMenu = UIExtensions.GetMenu("UITextEntryMenu") as UITextEntryMenu
	TextMenu.SetPropertyString("text", MainName)
	TextMenu.OpenMenu(PlayerRef)
	;MainName = TextMenu.GetResultString()
	
	OutfitNames[OutfitNumber] = TextMenu.GetResultString()
EndFunction

Function BegForCockMenu(Bool IsShortcut = false)
	Int MenuSelect = ShowBegForCockMenu()
	If MenuSelect == -1  && !IsShortcut
		ActionsMenu()
	ElseIf MenuSelect == 0
		Debug.SendAnimationEvent(PlayerRef , "SLS_BegForCock_LeadIn_HandPump1")
	ElseIf MenuSelect == 1
		Debug.SendAnimationEvent(PlayerRef , "SLS_BegForCock_LeadIn_StickyFingers1")
	ElseIf MenuSelect == 2
		Debug.SendAnimationEvent(PlayerRef , "SLS_BegForCock_LeadIn_Sore1")
	EndIf
EndFunction

Int Function ShowBegForCockMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Hand pump")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Sticky Fingers")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Sore Ass")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Hand pump")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Sticky Fingers")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Sore Ass")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction

; Survival Menu ==============================================================================================================

Function SurvivalMenu(Bool IsShortcut = false)
	Int MenuResult = ShowSurvivalMenu()
	If MenuResult == -1
		MainMenu()
	ElseIf MenuResult == 0
		CraftingMenu()
	ElseIf MenuResult == 1
		SleepOnGround()
		GoToState("SleepOnGround")
	ElseIf MenuResult == 2
		SurvivalSkillsMenu()
	ElseIf MenuResult == 3
		BatheMenu()
		GoToState("Bathe")
	ElseIf MenuResult == 4
		WildlingMenu()
		GoToState("Wildling")
	EndIf	
EndFunction

Int Function ShowSurvivalMenu()
	Bool WildlingEn = Friend.Wildling._SLS_WildlingLevel.GetValue() >= 1.0 || StorageUtil.FormListCount(None, "_SLS_AnimalFriendsList") > 0
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Crafting ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Sleep On Ground")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Skills ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Bathe ")
	If WildlingEn
		wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 4, value = "Wildling ")
	EndIf

	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Crafting ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Sleep On Ground")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Skills ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Bathe ")
	If WildlingEn
		wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 4, value = "Wildling ")
	EndIf
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = Game.GetModByName("Bathing in Skyrim - Main.esp") != 255)
	If WildlingEn
		wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 4, value = WildlingEn)
	EndIf

	Return wheelMenu.OpenMenu()
EndFunction

Function WildlingMenu(Bool IsShortcut = false)
	Int MenuResult = ShowWildlingMenu()
	If MenuResult == -1 && !IsShortcut
		SurvivalMenu()
	ElseIf MenuResult == 0
		Friend.Withdraw()
	ElseIf MenuResult == 1
		Friend.ShowPackList()
	ElseIf MenuResult == 2
		Friend.Wildling.DisplayLog()
	ElseIf MenuResult == 3
		Friend.PlayerStatsMenu()
	EndIf
EndFunction

Int Function ShowWildlingMenu()
	String WithdrawStr = Friend.GetWithdrawMenuString()

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = WithdrawStr)
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Pack List")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Wildling Points Log")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Stats ")

	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = WithdrawStr)
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Pack List")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Wildling Points Log")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Stats ")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = true)

	Return wheelMenu.OpenMenu()
EndFunction

Function CraftingMenu(Bool IsShortcut = false)
	Int MenuSelect = ShowCraftingMenu()
	If MenuSelect == -1 && !IsShortcut
		SurvivalMenu()
	ElseIf MenuSelect == 0
		(Game.GetFormFromFile(0x02306B, "Campfire.esm") as Spell).Cast(PlayerRef, PlayerRef)
		GoToState("FrostfallCrafting")
	ElseIf MenuSelect == 1
		(Game.GetFormFromFile(0x025C0C, "Hunterborn.esp") as Spell).Cast(PlayerRef, PlayerRef)
		GoToState("HunterbornCrafting")
	ElseIf MenuSelect == 2
		(Game.GetFormFromFile(0x073D95, "Hunterborn.esp") as Spell).Cast(PlayerRef, PlayerRef)
		GoToState("PrimitiveCooking")
	ElseIf MenuSelect == 3
		Frostfall.OpenAlchemyCrafting()
		GoToState("MortarPestle")
	EndIf
EndFunction

Int Function ShowCraftingMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Frostfall Crafting")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Hunterborn Crafting")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Primitive Cooking")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Mortar & Pestle")

	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Frostfall Crafting")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Hunterborn Crafting")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Primitive Cooking")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Mortar & Pestle")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = Game.GetModByName("Campfire.esm") != 255)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = Game.GetModByName("Hunterborn.esp") != 255)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = Game.GetModByName("Hunterborn.esp") != 255)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = Game.GetModByName("Campfire.esm") != 255)
	
	Return wheelMenu.OpenMenu()
EndFunction

Function SurvivalSkillsMenu(Bool IsShortcut = false)
	Int MenuResult = ShowSurvivalSkillsMenu()
	If MenuResult == -1 && !IsShortcut
		SurvivalMenu()
	ElseIf MenuResult == 0
		(Game.GetFormFromFile(0x025BD5, "Campfire.esm") as Spell).Cast(PlayerRef, PlayerRef)
		GoToState("BuildCampfire")
	ElseIf MenuResult == 1
		Frostfall.PlaceTent()
		GoToState("PlaceTent")
	ElseIf MenuResult == 2
		SenseMenu()
		
	ElseIf MenuResult == 3
		(Game.GetFormFromFile(0x035411, "Campfire.esm") as Spell).Cast(PlayerRef, PlayerRef)
		GoToState("Instincts")
	ElseIf MenuResult == 4
		(Game.GetFormFromFile(0x014225, "Hunterborn.esp") as Spell).Cast(PlayerRef, PlayerRef)
		GoToState("Forage")
	ElseIf MenuResult == 5
		(Game.GetFormFromFile(0x025647, "Campfire.esm") as Spell).Cast(PlayerRef, PlayerRef)
		GoToState("HarvestWood")
	ElseIf MenuResult == 6
		;(Game.GetFormFromFile(0x01BD9E, "Mortal Weapons & Armor.esp") as Spell).Cast(PlayerRef, PlayerRef)
		
		;/
		Game.ForceFirstPerson()
		Utility.Wait(0.1)
		_SLS_HighlightItemsQuest.Start()
		GoToState("SenseItems")
		/;
	ElseIf MenuResult == 7
		GoToState("SearchGround")
		SearchDistanceMenu()
	EndIf
EndFunction

Int Function ShowSurvivalSkillsMenu()
	Bool CampfireInstalled = Game.GetModByName("Campfire.esm") != 255
	
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Build Campfire")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Place Tent")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Senses")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Instincts ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 4, value = "Forage ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 5, value = "Harvest Wood")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 6, value = "Sense Items")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 7, value = "Search Ground")

	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Build Campfire")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Place Tent")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Senses")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Instincts ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 4, value = "Forage ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 5, value = "Harvest Wood")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 6, value = "Sense Items")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 7, value = "Search Ground")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = CampfireInstalled)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = CampfireInstalled)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = CampfireInstalled)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = CampfireInstalled)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 4, value = Game.GetModByName("Hunterborn.esp") != 255)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 5, value = true)
	;wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 6, value = !_SLS_HighlightItemsQuest.IsRunning()) ;/Game.GetModByName("Mortal Weapons & Armor.esp") != 255)/;
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 7, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction

Function SenseMenu(Bool IsShortcut = false)
	Int MenuResult = ShowSenseMenu()
	If MenuResult == -1
		If IsShortcut
			MainMenu()
		Else
			SurvivalSkillsMenu()
		EndIf
	ElseIf MenuResult == 0
		GoToState("Senses")
		Game.ForceFirstPerson()
		Utility.Wait(0.1)
		_SLS_HighlightItemsQuest.Start()
	ElseIf MenuResult == 1
		GoToState("Senses")
		(Game.GetFormFromFile(0x044ED1, "Hunterborn.esp") as Spell).Cast(PlayerRef, PlayerRef)
	ElseIf MenuResult == 2
		GoToState("Senses")
		_SLS_SenseArousalQuest.Start()
	ElseIf MenuResult == 3
		GoToState("Senses")
		_SLS_SenseCumFullnessQuest.Start()
	EndIf
EndFunction

Int Function ShowSenseMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Sense Items")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Sense Direction")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Sense Arousal")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Sense Cum Fullness")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Sense Items")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Sense Direction")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Sense Arousal")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Sense Cum Fullness")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = !_SLS_HighlightItemsQuest.IsRunning())
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = Game.GetModByName("Hunterborn.esp") != 255)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = !_SLS_SenseArousalQuest.IsRunning() && !_SLS_SenseCumFullnessQuest.IsRunning())
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = !_SLS_SenseCumFullnessQuest.IsRunning() && !_SLS_SenseArousalQuest.IsRunning())
	
	Return wheelMenu.OpenMenu()
EndFunction

Function SearchDistanceMenu(Bool IsShortcut = false)
	Int MenuResult = ShowSearchDistanceMenu()
	If MenuResult == -1
		SurvivalSkillsMenu()
	ElseIf MenuResult == 0
		_SLS_SearchGroundDistance.SetValue(600.0)
		BeginSearchGround()
	ElseIf MenuResult == 1
		_SLS_SearchGroundDistance.SetValue(1800.0)
		BeginSearchGround()
	ElseIf MenuResult == 2
		_SLS_SearchGroundDistance.SetValue(40000.0)
		BeginSearchGround()
	EndIf
EndFunction

Int Function ShowSearchDistanceMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Nearby ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Medium Distance")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Everywhere ")


	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Nearby ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Medium Distance")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Everywhere ")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction

Function BeginSearchGround(Bool IsShortcut = false)
	If !PlayerRef.IsInCombat()
		_SLS_SearchGroundHostilesQuest.Stop()
		_SLS_SearchGroundHostilesQuest.Start()
		If !(_SLS_SearchGroundHostilesQuest.GetNthAlias(0) as ReferenceAlias).GetReference()
			SearchGroundMenu()
		Else
			Debug.Notification("I need to clear the search area of enemies first")
		EndIf
	Else
		Debug.Notification("I can't search in combat")
	EndIf
EndFunction

Function SearchGroundMenu()
	Int MenuResult = ShowSearchGroundMenu()
	If MenuResult == -1
		SearchDistanceMenu()
	Else
		; Get object
		ObjectReference ObjRef = StorageUtil.FormListGet(Self, "_SLS_SearchGroundForms", MenuResult) as ObjectReference
		If ObjRef
			;Debug.Messagebox("GetActorOwner(): " + ObjRef.GetActorOwner() + "\nGetFactionOwner(): " + ObjRef.GetFactionOwner())
			;PlayerRef.AddItem(ObjRef)
			ObjRef.Activate(PlayerRef)
			ObjRef.SendStealAlarm(PlayerRef)
		EndIf
	EndIf
EndFunction

Int Function ShowSearchGroundMenu()
	_SLS_SearchGroundQuest.Stop()
	_SLS_SearchGroundQuest.Start()
	StorageUtil.FormListClear(Self, "_SLS_SearchGroundForms")
	ObjectReference ObjRef
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	Int i = 0
	While i < _SLS_SearchGroundQuest.GetNumAliases()
		ObjRef = (_SLS_SearchGroundQuest.GetNthAlias(i) as ReferenceAlias).GetReference()
		If ObjRef ;/&& ObjRef.GetActorOwner() == None && ObjRef.GetFactionOwner() == None/;
			ListMenu.AddEntryItem(ObjRef.GetDisplayName())
			StorageUtil.FormListAdd(Self, "_SLS_SearchGroundForms", ObjRef)
		EndIf
		i += 1
	EndWhile
	If StorageUtil.FormListCount(Self, "_SLS_SearchGroundForms") > 0
		ListMenu.OpenMenu()
		Return ListMenu.GetResultInt()
	EndIf
	Debug.Notification("I couldn't find anything")
	Return -1
EndFunction

Function SleepOnGround()
	;/
	If Game.GetModByName("SexLab_Dialogues.esp") != 255
		(Game.GetFormFromFile(0x020B5D, "SexLab_Dialogues.esp") as Spell).Cast(PlayerRef, PlayerRef)
	Else
	
	EndIf
	/;
	If Menu.GetIsSleepDeprivationEnabled()
		Needs.GetSleepPenalty(ShowConditions = true, IsSleeping = false)
		Int Button = _SLS_SleepHereMsg.Show()
		If Button == 0 ; Yes
			DoSleepOnGround()
		Else
			SurvivalMenu()
		EndIf
	Else
		DoSleepOnGround()
	EndIf
EndFunction

Function DoSleepOnGround()
	If !PlayerRef.IsTrespassing() && !PlayerRef.IsInCombat()
		Location MyLoc = PlayerRef.GetCurrentLocation()
		If !MyLoc.HasKeyword(LocTypeInn)
			StorageUtil.SetIntValue(PlayerRef, "_SLS_SleepingRough", 1)
			ObjectReference BedObjRef = PlayerRef.PlaceAtMe(Bedroll01, aiCount = 1, abForcePersist = false, abInitiallyDisabled = true)
			BedObjRef.MoveTo(PlayerRef, 0.0, 0.0, PlayerRef.GetHeight() - 1000.0)
			BedObjRef.Enable()
			;Debug.Messagebox(PlayerRef.IsTrespassing())
			;If Utility.RandomInt(0,1) == 0
				Debug.SendAnimationEvent(PlayerRef, "IdleBedRollRightEnterStart")
			;Else
			;	Debug.SendAnimationEvent(PlayerRef, "IdleLayDownEnter")
			;EndIf
			Utility.Wait(3.5)
			FadeToBlack.Apply()
			Utility.Wait(1.5)
			BedObjRef.Activate(PlayerRef)
			BedObjRef.Disable()
			BedObjRef.Delete()
			RegisterForMenu("Sleep/Wait Menu")
		Else
			Debug.Notification("I can't sleep here")
		EndIf
	
	Else
		Debug.Notification("I don't have a good feeling about that")
	EndIf
EndFunction

Function BatheMenu(Bool IsShortcut = false)
	MiscObject MenuSelect = ShowSoapMenu()
	If MenuSelect == None
		SurvivalMenu()
	ElseIf MenuSelect == _SLS_NeverAddedItem
		Bis.TryBatheActor(PlayerRef, None)
	Else
		Bis.TryBatheActor(PlayerRef, MenuSelect)
	EndIf
EndFunction

MiscObject Function ShowSoapMenu()
	; Return None = Menu Back
	; Return _SLS_NeverAddedItem = wash without soap

	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	Bool FoundSoap = false
	Int i = 0
	While i < _SLS_BisSoapList.GetSize()
		If PlayerRef.GetItemCount(_SLS_BisSoapList.GetAt(i)) > 0
			ListMenu.AddEntryItem(_SLS_BisSoapList.GetAt(i).GetName())
			FoundSoap = true
		EndIf
		i += 1
	EndWhile
	If !FoundSoap
		ListMenu.AddEntryItem("Wash Without Soap")
	EndIf
	ListMenu.OpenMenu()
	Int Result = ListMenu.GetResultInt()
	If Result == -1
		Return None
	ElseIf !FoundSoap
		Return _SLS_NeverAddedItem
	Else
		Return _SLS_BisSoapList.GetAt(Result) as MiscObject
	EndIf
EndFunction

; Idle Menu ===============================================================================================================

Function IdleMenu(Bool IsShortcut = false)
	Int MenuSelect = ShowIdleMenu()
	If MenuSelect == -1 && !IsShortcut
		MainMenu()
	ElseIf MenuSelect == 0
		Hug()
	ElseIf MenuSelect == 1
		IdleGesturesMenu()
	ElseIf MenuSelect == 2
		;SlapAss()
	ElseIf MenuSelect == 3

	ElseIf MenuSelect == 4
		IdleCombatMenu()
	ElseIf MenuSelect == 5

	ElseIf MenuSelect == 6

	ElseIf MenuSelect == 7

	EndIf
EndFunction

Int Function ShowIdleMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Hug ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Gestures ")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Slap Ass")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Taunt ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 4, value = "Combat ")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 5, value = "Salute ")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 6, value = "Pray ")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 7, value = "IdleCombatStretchingStar ")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Hug ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Gestures ")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Slap Ass")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Taunt ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 4, value = "Combat ")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 5, value = "Salute ")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 6, value = "Pray ")
	;wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 7, value = "IdleCombatStretchingStart")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = (PlayerRef.IsInCombat() == false && XhairTarget as Actor))
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 7, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction
;/
Function SlapAss()
	Actor akTarget = XhairTarget as Actor
	If akTarget && !akTarget.IsInCombat()
		;Debug.Messagebox("SPank: " + akTarget.GetDisplayName())
		akTarget.PlayIdleWithTarget(pa_PairedButtSlap, PlayerRef)
	Else
		Debug.Messagebox("ELSE: ")
		Debug.SendAnimationEvent(PlayerRef, "pa_PairedButtSlap")
	EndIf
EndFunction
/;
Function IdleCombatMenu(Bool IsShortcut = false)
	Int MenuSelect = ShowIdleCombatMenu()
	If MenuSelect == -1 && !IsShortcut
		IdleMenu()
	ElseIf MenuSelect == 0
		Taunt()
		GoToState("Taunt")
	ElseIf MenuSelect == 1
		Stretch()
		GoToState("Stretch")
	ElseIf MenuSelect == 2
		FlyYouFools()
		GoToState("FlyYouFools")
	ElseIf MenuSelect == 3
		Debug.SendAnimationEvent(PlayerRef, "IdleSurrender")
		_SLS_SubmitAliases.Stop()
		_SLS_SubmitAliases.Start()
	EndIf
EndFunction

Int Function ShowIdleCombatMenu()
	String FlyYouFools = "Withdraw "
	If _SLS_FlyYouFoolsQuest.IsRunning()
		FlyYouFools = "Engage "
	EndIf

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Taunt ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Stretch ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = FlyYouFools)
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Surrender ")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Taunt ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Stretch ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = FlyYouFools)
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Surrender ")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction

Function FlyYouFools()
	If _SLS_FlyYouFoolsQuest.IsRunning()
		_SLS_FlyYouFoolsQuest.Stop()
	Else
		_SLS_FlyYouFoolsQuest.Start()
		If Sta.GetState() == "Installed"
			Sta.QueueComment(_SLS_AioRetreat, PriorityComment = true, ForcedGagComment = false)
		Else
			_SLS_RetreatSM.Play(PlayerRef)
		EndIf
		;PlayerRef.AddSpell(_SLS_CombatChangeDetectSpell, false)
	EndIf
EndFunction

Function Taunt()
	If PlayerRef.IsWeaponDrawn()
		If Sta.GetState() == "Installed"
			Sta.QueueComment(_SLS_AioTauntTopic, PriorityComment = true, ForcedGagComment = false)
		Else
			_SLS_TauntSM.Play(PlayerRef)
		EndIf
		Debug.SendAnimationEvent(PlayerRef, "IdleCombatShieldStart")
		_SLS_CombatTauntQuest.Stop()
		_SLS_CombatTauntQuest.Start()
	Else
		Debug.Notification("I'll need to draw my weapons to intimidate them")
	EndIf
EndFunction

Function Stretch()
	Debug.SendAnimationEvent(PlayerRef, "IdleCombatStretchingStart")
EndFunction

Function IdleGesturesMenu(Bool IsShortcut = false)
	Int MenuResult = ShowIdleGestureMenu()
	If MenuResult == -1 && !IsShortcut
		IdleMenu()
	ElseIf MenuResult == 0
		ComeThisWay()
	ElseIf MenuResult == 1
		Salute()
	ElseIf MenuResult == 2
		AttractAttention()
	ElseIf MenuResult == 3
		Wave()
	ElseIf MenuResult == 4
		Applaud()
	EndIf
EndFunction

Int Function ShowIdleGestureMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Come This Way")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Salute ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Attract Attention")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Wave ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 4, value = "Applaud ")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Come This Way")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Salute ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Attract Attention")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Wave ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 4, value = "Applaud ")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 4, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction

Function Hug()
	ObjectReference akTarget = XhairTarget as Actor
	If akTarget as Actor && !(akTarget as Actor).IsInCombat()
		PlayerRef.PlayIdleWithTarget(pa_HugA, akTarget)
	EndIf
EndFunction

Function Applaud()
	Debug.SendAnimationEvent(PlayerRef, "IdleApplaud" + Utility.RandomInt(2,5))
EndFunction

Function Salute()
	Debug.SendAnimationEvent(PlayerRef, "IdleSalute")
	Actor akTarget = XhairTarget as Actor
	;Debug.Messagebox("akTarget: " + akTarget + "\nakTarget.IsInCombat(): " + akTarget.IsInCombat() + "\nakTarget.IsInFaction(CWImperialFaction): " + akTarget.IsInFaction(CWImperialFaction) + "\nakTarget.IsInFaction(CWSonsFaction): " + akTarget.IsInFaction(CWSonsFaction))
	If akTarget && !akTarget.IsInCombat() && (akTarget.IsInFaction(CWImperialFaction) || akTarget.IsInFaction(CWSonsFaction)) && akTarget.IsInFaction(CWDialogueSoldierFaction)
		Utility.Wait(0.7)
		Debug.SendAnimationEvent(akTarget, "IdleSalute")
	EndIf
EndFunction

Function ComeThisWay()
	Debug.SendAnimationEvent(PlayerRef, "IdleComeThisWay")
EndFunction

Function AttractAttention()
	Debug.SendAnimationEvent(PlayerRef, "IdleGetAttention")
	If Sta.GetState() == "Installed"
		Sta.QueueComment(_SLS_AllInOneKeyGetAttention, PriorityComment = true, ForcedGagComment = false)
		PlayerRef.CreateDetectionEvent(PlayerRef, aiSoundLevel = 1000)
		; There's all sorts of delays calling STA dialogue out. Need to thread off dialogue so the script will continue otherwise waving arms about like a moron for ages
	Else
		_SLS_GetAttentionSM.Play(PlayerRef)
		PlayerRef.CreateDetectionEvent(PlayerRef, aiSoundLevel = 1000)
		Utility.Wait(1.0)
	EndIf
	
	;Debug.Messagebox("STOP")
	Debug.SendAnimationEvent(PlayerRef, "IdleStop")
EndFunction

Function Wave()
	Debug.SendAnimationEvent(PlayerRef, "IdleWave")
EndFunction


;/
String Function GetCustomIdle()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	String[] ZazAnims = New String[128]
	ZazAnims[0] = "TepiFingYes"
	ZazAnims[1] = "TepiFingNo"
	ZazAnims[2] = "xDancerExit"
	ZazAnims[3] = "xDancerIdle"
	ZazAnims[4] = "xDayDreaming"
	ZazAnims[5] = "xEstimateing"
	ZazAnims[6] = "xFlashingIdle"
	ZazAnims[7] = "xGenericEnterExit"
	ZazAnims[8] = "xBarstoolIdle"
	ZazAnims[9] = "xBrokenLying"
	ZazAnims[10] = "TepKneelCuff"
	ZazAnims[11] = "TepiShowVagina"
	ZazAnims[12] = "TepiShowArs"
	ZazAnims[13] = "TepiHandsHip"
	
	
	;ZazAnims[] = ""
	
	
	Int i = 0
	While i < ZazAnims.Length
		ListMenu.AddEntryItem(ZazAnims[i])
		i += 1
	EndWhile
	ListMenu.OpenMenu()
	;Debug.Messagebox(ListMenu.GetResultInt())
	Return ZazAnims[ListMenu.GetResultInt()]
EndFunction
/;

; Status Menu ================================================================================================================

Function StatusMenu(Bool IsShortcut = false)
	Int MenuResult = ShowStatusMenu()
	;/
	If MenuResult == -1
		MainMenu()
	EndIf
	/;
EndFunction

Int Function ShowStatusMenu()	
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	Actor CrosshairRef = XhairTarget as Actor

	;/ Doesn't display max health correctly
	ListMenu.AddEntryItem("H: (" + (PlayerRef.GetAv("Health") as Int) + "/" + (ActorValueInfo.GetActorValueInfoByName("Health").GetMaximumValue(PlayerRef) as Int) +\
	") S: (" + (PlayerRef.GetAv("Stamina") as Int) + "/" + (ActorValueInfo.GetActorValueInfoByName("Stamina").GetMaximumValue(PlayerRef) as Int) +\
	") M: (" + (PlayerRef.GetAv("Magicka") as Int) + "/" + (ActorValueInfo.GetActorValueInfoByName("Magicka").GetMaximumValue(PlayerRef) as Int) + ")")
	/;
	ListMenu.AddEntryItem("==== " + PlayerRef.GetActorBase().GetName() + " ====")
	ListMenu.AddEntryItem("Health: " + (PlayerRef.GetAv("Health") as Int) +\
	". Stamina: " + (PlayerRef.GetAv("Stamina") as Int) +\
	". Magicka: " + (PlayerRef.GetAv("Magicka") as Int))

	Frostfall.ShowMeters()
	;/
	ListMenu.AddEntryItem("H: (" + (PlayerRef.GetAv("Health") as Int) + "/" + (PlayerRef.GetActorValueMax("Health") as Int) +\
	"). S: (" + (PlayerRef.GetAv("Stamina") as Int) + "/" + (PlayerRef.GetActorValueMax("Stamina") as Int) +\
	"). M: (" + (PlayerRef.GetAv("Magicka") as Int) + "/" + (PlayerRef.GetActorValueMax("Magicka") as Int)) + ")"
/;
	
	
	If Needs.GetState() != ""
		; Needs
		;/
		ListMenu.AddEntryItem("Hunger: " + Needs.GetAioHunger())
		ListMenu.AddEntryItem("Thirst: " + Needs.GetAioThirst())
		ListMenu.AddEntryItem("Fatigue: " + Needs.GetAioFatigue())
		/;
		ListMenu.AddEntryItem(Needs.GetAioHunger() + ", " + Needs.GetAioThirst() + ", " + Needs.GetAioFatigue())
	EndIf
	
	; BiS
	String DirtString
	If Bis.GetState() == "Installed"
		DirtString = " Dirt: " + ((Bis.GetPlayerDirt() * 100.0) as Int) + "%"
		;ListMenu.AddEntryItem("Dirt: " + ((Bis.GetPlayerDirt() * 100.0) as Int) + "%")
	EndIf
	
	; Arousal
	Float CumCapacity = Fhu.GetCumCapacityMax()
	ListMenu.AddEntryItem("Arousal: " + PlayerRef.GetFactionRank(Game.GetFormFromFile(0x03FC36, "SexLabAroused.esm") as Faction) + "% Weight: " + (PlayerRef.GetLeveledActorBase().GetWeight() as Int + "%") + DirtString)
	
	; Orgasm Fatigue
	String OrgFat = Orgasmfatigue.GetOrgasmFatigueString()
	If OrgFat != ""
		ListMenu.AddEntryItem("Orgasm Fatigue: " + OrgFat)
	EndIf

	; Devious Followers
	If Game.GetModByName("DeviousFollowers.esp") != 255
		ListMenu.AddEntryItem("Debt: " + (Game.GetFormFromFile(0x00C54F, "DeviousFollowers.esp") as GlobalVariable).GetValue() as Int + \
		" Gold. Lives: " + (Game.GetFormFromFile(0x02DB9E, "DeviousFollowers.esp") as GlobalVariable).GetValueInt() + \
		". Willpower: " + SnipToDecimalPlaces((Game.GetFormFromFile(0x01A2A7, "Update.esm") as GlobalVariable).GetValue(), 2))
	EndIf

	; Wear
	String Wear = Apro2.GetWearTear(PlayerRef)
	If Wear
		ListMenu.AddEntryItem(Wear)
	EndIf
	
	; Cum
	ListMenu.AddEntryItem("Cum On My Skin: Vag: " + Sexlab.CountCumVaginal(PlayerRef) + ". Ass: " + Sexlab.CountCumAnal(PlayerRef) + ". Face: " + Sexlab.CountCumOral(PlayerRef))
	If CumAddict.GetAddictionState() > 0
		ListMenu.AddEntryItem(CumAddict.GetStatusMessage())
	EndIf
	
	If Fhu.GetState() == "Installed"
		;Float CumCapacity = Fhu.GetCumCapacityMax()
		ListMenu.AddEntryItem("Cum In My Pussy: " + (((Fhu.GetCurrentCumVaginal(PlayerRef) / CumCapacity) * 100.0) as Int) + "%" + ". Cum In My Ass: " + (((Fhu.GetCurrentCumAnal(PlayerRef) / CumCapacity) * 100.0) as Int) + "%")
	EndIf

	; Milk
	If StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkCount", Missing = -1.0) >= 0.0
		ListMenu.AddEntryItem("Milk: " + SnipToDecimalPlaces(StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkCount", Missing = 0.0), 2) + "/" + \
		SnipToDecimalPlaces(StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.MilkMaximum", Missing = 0.0), 2) +\
		" Lactacid: " + SnipToDecimalPlaces(StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.LactacidCount", Missing = 0.0), 2) + \
		" Lvl: " + (StorageUtil.GetFloatValue(PlayerRef, "MME.MilkMaid.Level", Missing = 0.0) as Int))
	EndIf

	; Milk Addict
	String MaAddictLevel = MilkAddict.GetAddictionLevel()
	If MaAddictLevel != ""
		ListMenu.AddEntryItem("Lact Addict: " + MilkAddict.GetAddictionLevel() + ". Withdrawal: " + MilkAddict.GetWithdrawalLevel())
	EndIf
	
	; Soulgem Oven
	If Sgo.GetState() == "Installed"
		Float GemProgress = Sgo.ActorGemGetPercent(PlayerRef)
		;Debug.Messagebox("GemProgress: " + GemProgress)
		If GemProgress > 0.0
			String SgoString = "Gems: " + SnipToDecimalPlaces(GemProgress, 2) + "%"
			Float Milk = StorageUtil.GetFloatValue(PlayerRef, "SGO.Actor.Milk.Data")
			If Milk > 0.0
				SgoString += ". Milk: " + SnipToDecimalPlaces(((Milk / Sgo.GetMilkCapacity(PlayerRef)) * 100.0), 2) + "%"
			EndIf
			ListMenu.AddEntryItem(SgoString)
		EndIf
	EndIf
	
	; Creature Corruption
	If StorageUtil.GetFloatValue(None, "_SLS_CreatureCorruption", Missing = 0.0) > 0.0
		ListMenu.AddEntryItem("Creature Corruption: " + (StorageUtil.GetFloatValue(None, "_SLS_CreatureCorruption", Missing = 0.0) as Int) + "/100 Breeder Lvl: " + (Util.CreatureFondleCount as Int))
	EndIf
	
	If Friend.Wildling._SLS_WildlingLevel.GetValue() >= 1 || StorageUtil.FormListCount(None, "_SLS_AnimalFriendsList") > 0
		ListMenu.AddEntryItem("Wildling Level: " + Friend.Wildling._SLS_WildlingLevel.GetValueInt() + " Exp: " + SnipToDecimalPlaces(Friend.Wildling._SLS_WildlingPoints.GetValue(), 3))
	EndIf
	
	; Bikini
	Float BikExp = 0.0
	Float BikExpNextLevel = 0.0
	Float ExpPerLevel = 0.0
	String BikRankString = "Untrained "
	If _SLS_BikiniExpTrainingQuest.IsRunning()
		ExpPerLevel = BikiniExp.ExpPerLevel
		BikExp = BikiniExp.BikExp
		BikExpNextLevel = BikiniExp.ExpPerLevel
		BikRankString = BikiniExp.GetBikRankString()
		
		Int i = 0
		While BikExpNextLevel < BikExp
			BikExpNextLevel += BikiniExp.ExpPerLevel
			If i == 1
				BikExpNextLevel += (BikiniExp.ExpPerLevel * 0.5)
			EndIf
			If i == 2
				BikExpNextLevel += (BikiniExp.ExpPerLevel)
			EndIf
			i += 1
			;Debug.Trace("_SLS_: Looping")
		EndWhile
	EndIf
	ListMenu.AddEntryItem("Bikini Lvl: " + BikRankString + " Xp: " + SnipToDecimalPlaces(BikExp, 1) + " Next Xp: " + SnipToDecimalPlaces(BikExpNextLevel, 1))
	;/
	If LicUtil.LicBikiniEnable
		Bool IsCursed = (LicUtil.HasValidBikiniLicence && !LicUtil.HasValidArmorLicence)
		String CurseStr = "Bikini Cursed: " + (LicUtil.HasValidBikiniLicence && !LicUtil.HasValidArmorLicence)
		If IsCursed
			CurseStr += ". Active: " + (_SLS_LicBikiniCurseIsWearingArmor.GetValueInt() == 1)
		EndIf
		ListMenu.AddEntryItem(CurseStr)
		If IsCursed && _SLS_LicBikiniCurseIsWearingArmor.GetValueInt() == 1
			ListMenu.AddEntryItem("Curse Trigger: " + Menu.BikiniCurseTriggerArmor.GetName() + " - " + StringUtil.Substring(Menu.BikiniCurseTriggerArmor, StringUtil.Find(Menu.BikiniCurseTriggerArmor, "(", 0) + 1, len = 8))
		EndIf
	EndIf
/;
	; STA
	If Sta.GetState() == "Installed"
		ListMenu.AddEntryItem("Masochism: " + Sta.GetMasochismAttitudeString() + " pain (" + SnipToDecimalPlaces(Sta.GetPlayerMasochism(), 2) + "/" + SnipToDecimalPlaces((Sta.GetMasochismStepSize() * 4.0), 2) + ")")
	EndIf
	
	; Jiggles
	If PlayerRef.HasSpell(Game.GetFormFromFile(0x0CF9B0, "SL Survival.esp") as Spell)
		ListMenu.AddEntryItem("Jiggles: " + GetJigglesString())
	EndIf
	
	; Wartimes
	If Game.GetModByName("pchsWartimes.esp") != 255 && (Game.GetFormFromFile(0x005A17, "pchsWartimes.esp") as Quest).GetCurrentStageID() == 200
		ListMenu.AddEntryItem("Father's Favor: " + (Game.GetFormFromFile(0x07559F, "pchsWartimes.esp") as GlobalVariable).GetValueInt() + " Depravity: " + (Game.GetFormFromFile(0x093C22, "pchsWartimes.esp") as GlobalVariable).GetValueInt() + " Sub: " + (Game.GetFormFromFile(0x093C23, "pchsWartimes.esp") as GlobalVariable).GetValueInt())
		If !(Game.GetFormFromFile(0x005A16, "pchsWartimes.esp") as Actor).IsDead()
			If (Game.GetFormFromFile(0x0E4D68, "pchsWartimes.esp") as GlobalVariable).GetValueInt() >= 1 ; pchsMotherCaged
				ListMenu.AddEntryItem("Mother's Health: " + (Game.GetFormFromFile(0x0E9E86, "pchsWartimes.esp") as GlobalVariable).GetValueInt()) ; pchsMotherHealthCaged
			Else
				ListMenu.AddEntryItem("Mother's Health: " + (Game.GetFormFromFile(0x0755AD, "pchsWartimes.esp") as GlobalVariable).GetValueInt()) ; pchsMotherHealth
			EndIf
		EndIf
	EndIf
	
	
	; Target ====================================================
	If CrosshairRef
		ListMenu.AddEntryItem("==== " + CrosshairRef.GetActorBase().GetName() + " ====")
		;ListMenu.AddEntryItem(CrosshairRef.GetActorBase().GetName())
		ListMenu.AddEntryItem("Arousal: " + (CrosshairRef).GetFactionRank(Game.GetFormFromFile(0x03FC36, "SexLabAroused.esm") as Faction) + "%. Weight: " + (CrosshairRef.GetLeveledActorBase().GetWeight() as Int + "%"))
		If (CrosshairRef).GetLeveledActorBase().GetSex() == 0 ; Male
			ListMenu.AddEntryItem("Cum Fullness: " + SnipToDecimalPlaces(StrInput = (Util.GetLoadFullnessMod(CrosshairRef) * 100.0), Places = 1) + "%")
		ElseIf Fhu.GetState() == "Installed"
			ListMenu.AddEntryItem("Cum in her ass: " + (((Fhu.GetCurrentCumAnal(CrosshairRef) / CumCapacity) * 100.0) as Int) + "%. Pussy: " + (((Fhu.GetCurrentCumVaginal(CrosshairRef) / CumCapacity) * 100.0) as Int) + "%")
		EndIf
		ListMenu.AddEntryItem("Cum On Their Skin: Face: " + Sexlab.CountCumOral(CrosshairRef) + ". Vag: " + Sexlab.CountCumVaginal(CrosshairRef) + ". Ass: " + Sexlab.CountCumAnal(CrosshairRef))
	EndIf
	
	;/
	ListMenu.AddEntryItem("Lips: " + StorageUtil.GetStringValue(None, "yps_LipstickColor", Missing = "None") + " " + StorageUtil.GetStringValue(None, "yps_LipstickSmudged"))
	ListMenu.AddEntryItem("Eyes: " + StorageUtil.GetStringValue(None, "yps_EyeShadowColor", Missing = "None") + " " + StorageUtil.GetStringValue(None, "yps_EyeShadowSmudged"))
	ListMenu.AddEntryItem("Finger Nails: " + StorageUtil.GetStringValue(None, "yps_FingerNailPolishColor", Missing = "None") + " " + StorageUtil.GetStringValue(None, "yps_FingerNailPolishSmudged"))
	ListMenu.AddEntryItem("Toe Nails: " + StorageUtil.GetStringValue(None, "yps_ToeNailPolishColor", Missing = "None") + " " + StorageUtil.GetStringValue(None, "yps_ToeNailPolishSmudged"))
	
	ListMenu.AddEntryItem("IsBarredWhiterun: " + Menu.Eviction.IsBarredWhiterun)
	/;
	ListMenu.OpenMenu()
	Return ListMenu.GetResultInt()
	
EndFunction

; Misc Menu ===================================================================================================================

Function MiscMenu(Bool IsShortcut = false)
	Int MenuResult = ShowMiscMenu()
	If MenuResult == -1
		MainMenu()
	ElseIf MenuResult == 0
		DebugMenu()
	ElseIf MenuResult == 1
		(Game.GetFormFromFile(0x002DD9, "dcc-soulgem-oven-000.esm") as Spell).Cast(PlayerRef, PlayerRef)
	ElseIf MenuResult == 2
		;(Game.GetFormFromFile(0x000F5B, "EFFCore.esm") as Spell).Cast(PlayerRef, PlayerRef)
		TeleportFollowersMenu()
	ElseIf MenuResult == 3
		AssignFavorite()
	EndIf
EndFunction

Int Function ShowMiscMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Debug Menu")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "SGO Menu")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Teleport Followers")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Assign Favorite")

	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Debug Menu")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "SGO Menu")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Teleport Followers")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Assign Favorite")

	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = Game.GetModByName("dcc-soulgem-oven-000.esm") != 255)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = Game.GetModByName("EFFCore.esm") != 255)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = true)

	Return wheelMenu.OpenMenu()
EndFunction

Function AssignFavorite()
	Int MenuResult = ShowAssignFavoriteMenu()
	If MenuResult == -1
		MiscMenu()
	Else
		Fav.SetFav(MenuResult)
	EndIf
EndFunction

Int Function ShowAssignFavoriteMenu()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	Int i = 0
	While i < Fav.AioFavorites.Length
		ListMenu.AddEntryItem(Fav.AioFavorites[i])
		i += 1
	EndWhile
	ListMenu.OpenMenu()
	Return ListMenu.GetResultInt()
EndFunction

Bool Function GetIsTransferableTarget(ObjectReference TargetRef)
	If TargetRef
		Form TargetBase = TargetRef.GetBaseObject()
		If TargetRef as Actor || TargetBase as Container
			Return true
		Else
			Debug.Messagebox("Target object is not an actor or container. Sometimes objects can act like a container but they're really just an activator that's linked to a container somewhere (sometimes hidden underground)\nIt's impossible for SLS to determine the target container in these cases\n\nYou can not transfer from/to this object!!!")
			Return false
		EndIf
	EndIf
EndFunction

Function ContainerTransferMenu(Bool IsShortcut = false)
	ObjectReference TargetRef = XhairTarget
	Int MenuResult = ShowContainerTransferMenu(TargetRef)
	;/If MenuResult == -2
		 Not a transferable object under crosshairs
	Else/;If MenuResult == -1
		MiscMenu()
	ElseIf MenuResult == 0
		TransferFromContainer = TargetRef
		Debug.Notification("Transfer from: " + TransferFromContainer.GetBaseObject().GetName())
		GoToState("TransferMenu")
	ElseIf MenuResult == 1
		TransferToMenu(TargetRef)
		GoToState("TransferToMenu")
	EndIf 
EndFunction

Int Function ShowContainerTransferMenu(ObjectReference TargetRef)
	Bool IsTransferableTarget = GetIsTransferableTarget(TargetRef)
	String TargetStr
	If IsTransferableTarget
		TargetStr = TargetRef.GetBaseObject().GetName()
	Else
		Return -2 ; Not a transferable object under crosshairs - Do nothing. Error message printed in GetIsTransferableTarget()
	EndIf
	If TransferFromContainer
		Debug.Notification("Transferring from: " + TransferFromContainer.GetBaseObject().GetName())
	EndIf
	
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Transfer From " + TargetStr)
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Transfer To " + TargetStr)
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Transfer From " + TargetStr)
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Transfer To " + TargetStr)

	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = IsTransferableTarget)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = TransferFromContainer && IsTransferableTarget)
	
	Return wheelMenu.OpenMenu()
EndFunction

Function TransferToMenu(ObjectReference DestRef, Bool IsShortcut = false)
	If !TransferInProc
		Int MenuResult = ShowTransferToMenu(DestRef)
		If MenuResult == -1
			ContainerTransferMenu()
		Else
			TransferInProc = true
			If MenuResult == 0 ; Move ALL To 
				TransferFromContainer.RemoveAllItems(akTransferTo = XhairTarget, abKeepOwnership = true, abRemoveQuestItems = true)
				TransferFromContainer = None
			ElseIf MenuResult == 1 ; ALL ARMORS
				TransferAllArmors(DestRef)
			ElseIf MenuResult == 2 ; Devious Devices
				TransferDeviousDevices(DestRef)
			ElseIf MenuResult == 3 ; Bikini Armor
				TransferBikiniArmors(DestRef)
			ElseIf MenuResult == 4 ; Jewelry
				TransferJewelry(DestRef)
			ElseIf MenuResult == 5 ; Clothes
				TransferClothes(DestRef)
			ElseIf MenuResult == 6 ; Light Armor
				TransferLightArmor(DestRef)
			ElseIf MenuResult == 7 ; Heavy Armor
				TransferHeavyArmor(DestRef)
			ElseIf MenuResult == 8 ; All WEAPONS
				TransferAllWeapons(DestRef)
			ElseIf MenuResult == 9 ; All AMMO
				TransferAmmo(DestRef)
			ElseIf MenuResult == 10 ; All INGREDIENTS
				TransferIngredients(DestRef)
			ElseIf MenuResult == 11 ; All Potions
				TransferAllPotions(DestRef)
			ElseIf MenuResult == 12 ; All Food
				TransferAllFood(DestRef)
			ElseIf MenuResult == 13 ; All BOOKS
				TransferAllBooks(DestRef)
			ElseIf MenuResult == 14 ; All MISC OBJECTS
				TransferAllMiscObjects(DestRef)
			ElseIf MenuResult == 15 ; Gems
				TransferGems(DestRef)
			ElseIf MenuResult == 16 ; Crafting Material
				TransferCraftingMaterial(DestRef)
			ElseIf MenuResult == 17 ; Clutter
				TransferClutter(DestRef)
			EndIf
			TransferInProc = false
		EndIf
		
		If TransferFromContainer && MenuResult > -1
			Debug.Notification(TransferFromContainer.GetBaseObject().GetName() + " item count: " + TransferFromContainer.GetNumItems())
			If TransferFromContainer.GetNumItems() == 0
				TransferFromContainer = None
			EndIf
		EndIf
		
	Else
		Debug.Messagebox("A transfer is already in progress. Wait until it's done")
	EndIf
EndFunction

Int Function ShowTransferToMenu(ObjectReference DestRef)
	Debug.Notification("Move target: " + DestRef.GetBaseObject().GetName())
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("Move ALL")
	ListMenu.AddEntryItem("ALL ARMORS")
	ListMenu.AddEntryItem("Devious Devices")
	ListMenu.AddEntryItem("Bikini Armor")
	ListMenu.AddEntryItem("Jewelry")
	ListMenu.AddEntryItem("Clothes")
	ListMenu.AddEntryItem("Light Armor")
	ListMenu.AddEntryItem("Heavy Armor")
	ListMenu.AddEntryItem("All WEAPONS")
	ListMenu.AddEntryItem("All AMMO")
	ListMenu.AddEntryItem("All INGREDIENTS")
	ListMenu.AddEntryItem("ALL POTIONS")
	ListMenu.AddEntryItem("ALL FOOD")
	ListMenu.AddEntryItem("All BOOKS")
	ListMenu.AddEntryItem("All MISC OBJECTS")
	ListMenu.AddEntryItem("Gems")
	ListMenu.AddEntryItem("Crafting Material")
	ListMenu.AddEntryItem("Clutter")
	ListMenu.OpenMenu()
	Return ListMenu.GetResultInt()
EndFunction

Function TeleportFollowersMenu(Bool IsShortcut = false)
	Int MenuResult = ShowTeleportFollowersMenu()
	If MenuResult == -1
		MiscMenu()
	ElseIf MenuResult == 0
		TeleportAllFollowersToMe()
		GoToState("TeleportFollower")
	ElseIf MenuResult == 1
		TeleportOneFollowerToMe()
		GoToState("TeleportFollower")
	ElseIf MenuResult == 2
		TeleportToFollower()
		GoToState("TeleportFollower")
	EndIf
EndFunction

Int Function ShowTeleportFollowersMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Teleport All To Me")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Teleport One")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Teleport To Follower")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Teleport All To Me")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Teleport One")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Teleport To Follower")

	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction

Int Function TeleportToFollower()
	Int MenuResult = ShowFollowersListMenu()
	If MenuResult == -1
		TeleportFollowersMenu()
	Else
		PlayerRef.MoveTo(FollowersList[MenuResult] as Actor)
	EndIf
EndFunction

Int Function TeleportOneFollowerToMe()
	Int MenuResult = ShowFollowersListMenu()
	If MenuResult == -1
		TeleportFollowersMenu()
	Else
		TeleportActorToMe(FollowersList[MenuResult] as Actor)
	EndIf
EndFunction

Function TeleportAllFollowersToMe()
	FollowersList = Util.GetFollowers()
	Int i = 0
	While i < FollowersList.Length
		If FollowersList[i] as Actor
			TeleportActorToMe(FollowersList[i] as Actor)
		EndIf
		i += 1
	EndWhile
EndFunction

Function TeleportActorToMe(Actor akActor)
	akActor.MoveTo(PlayerRef, 120.0 * Math.Sin(PlayerRef.GetAngleZ()), 120.0 * Math.Cos(PlayerRef.GetAngleZ()), PlayerRef.GetHeight())
EndFunction

Int Function ShowFollowersListMenu()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	FollowersList = Util.GetFollowers()
	Int i = 0
	While i < FollowersList.Length
		ListMenu.AddEntryItem((FollowersList[i] as Actor).GetLeveledActorBase().GetName())
		i += 1
	EndWhile
	ListMenu.OpenMenu()
	;Debug.Messagebox(ListMenu.GetResultInt())
	Return ListMenu.GetResultInt()
EndFunction

; Debug Menu ===================================================================================================================

Function DebugMenu(Bool IsShortcut = false)
	Int MenuResult = ShowDebugMenu()
	If MenuResult == -1 && !IsShortcut
		MiscMenu()
	ElseIf MenuResult == 0
		(Game.GetFormFromFile(0x0840A3, "SL Survival.esp") as Spell).RemoteCast(PlayerRef, akBlameActor = PlayerRef, akTarget = GetMenuTargetActor()) ; GetActorPackage
	ElseIf MenuResult == 1
		Actor akTarget = XhairTarget as Actor
		If akTarget
			(Game.GetFormFromFile(0x0969EC, "SL Survival.esp") as Spell).Cast(PlayerRef, akTarget) ; GetActorVoice
		Else
			Debug.Notification("No crosshair ref")
		EndIf
		
	ElseIf MenuResult == 2
		GetActorFactions()
	ElseIf MenuResult == 3
		TeleportMenu()
		
	ElseIf MenuResult == 4
		LookAtDebug()
		
	ElseIf MenuResult == 5
		ContainerTransferMenu()
	ElseIf MenuResult == 6
		CompulsiveSex.SexStopped()
	ElseIf MenuResult == 7
		CumSwallow.OpenMouth(Override = true)
	ElseIf MenuResult == 8
		ModEventsMenu()
	ElseIf MenuResult == 9
		LicUtil.CheckAllLicencesExpiry()
	ElseIf MenuResult == 10
		Devious.VibrateEffect(GetMenuTargetActor(), VibStrength = 5, Duration = 12, TeaseOnly = false, Silent = false)
	ElseIf MenuResult == 11
		GetFashionValues()
	ElseIf MenuResult == 12
		GoToState("Overlays")
		OverlaysMenu()
	ElseIf MenuResult == 13
		GetKeywordsOnTarget()
	ElseIf MenuResult == 14
		GoToState("AddItemMenu")
		AddItemMenu()
	ElseIf MenuResult == 15
		ToggleHelloComments()
	ElseIf MenuResult == 16
		OwnershipDebugMenu()
	ElseIf MenuResult == 17
		LicUtil.NullifyMagic(GetMenuTargetActor())
	ElseIf MenuResult == 18
		LicUtil.UnNullifyMagic(GetMenuTargetActor())
	ElseIf MenuResult == 19
		DisplayApiGlobals()
	ElseIf MenuResult == 20
		GoToState("IssueLicence")
		IssueLicenceMenu()
	ElseIf MenuResult == 21
		GoToState("Trauma")
		TraumaMenu()
	ElseIf MenuResult == 22
		GoToState("StolenStuff")
		StolenStuffMenu()
	ElseIf MenuResult == 23
		Api.StashTrack.ToggleTracking(Game.GetCurrentCrosshairRef())
	ElseIf MenuResult == 24
		PrintVendorGoldEstimations()
	ElseIf MenuResult == 25
		GetAnimationsListByTags()
	ElseIf MenuResult == 26
		Debug.Messagebox("Faction Reaction: " + PlayerRef.GetFactionReaction(xHairTarget as Actor) + "\nAlarmed: " + (xHairTarget as Actor).IsAlarmed())
	ElseIf MenuResult == 27
		RaceDoorFlagMenu()
	ElseIf MenuResult == 28
		Friend.RecheckAnimalFriendFactions(xHairTarget as Actor)
	ElseIf MenuResult == 29
		If xHairTarget as Actor
			Friend.AttemptTame(xHairTarget as Actor, DebugTame = true)
		Else
			Debug.Notification("No target")
		EndIf
	ElseIf MenuResult == 30
		DroppedItemsMenu()
	ElseIf MenuResult == 31	
		(Game.GetFormFromFile(0x12B251, "SL Survival.esp") as ObjectReference).Activate(PlayerRef) ; LostFoundBarrelRef
	ElseIf MenuResult == 32
		Stuck1()
	ElseIf MenuResult == 33
		Stuck2()
	EndIf
EndFunction

Int Function ShowDebugMenu()
	String CommentFactStr = "Disallow "
	If XhairTarget as Actor && (xHairTarget as Actor).IsInFaction(_SLS_NoHelloCommentsFact)
		CommentFactStr = "Allow "
	EndIf
	
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("Get Actor Package")
	ListMenu.AddEntryItem("Get Actor Voice")
	ListMenu.AddEntryItem("Get Actor Factions")
	ListMenu.AddEntryItem("Teleport To...")
	ListMenu.AddEntryItem("Look At Debug")
	ListMenu.AddEntryItem("Container Transfer")
	ListMenu.AddEntryItem("Stop Fucking")
	ListMenu.AddEntryItem("Open/Close Mouth")
	ListMenu.AddEntryItem("Mod Events")
	ListMenu.AddEntryItem("Licence Check")
	ListMenu.AddEntryItem("Vibrate ")
	ListMenu.AddEntryItem("Fashion StUtil Vars")
	ListMenu.AddEntryItem("Overlays ")
	ListMenu.AddEntryItem("Get Keywords On Target")
	ListMenu.AddEntryItem("AddItem Menu")
	ListMenu.AddEntryItem(CommentFactStr + "Hello Comments/Spanks")
	ListMenu.AddEntryItem("Ownership Debug")
	ListMenu.AddEntryItem("Add Magic Curse")
	ListMenu.AddEntryItem("Remove Magic Curse")
	ListMenu.AddEntryItem("Display API Globals")
	ListMenu.AddEntryItem("Issue Licences")
	ListMenu.AddEntryItem("Trauma ")
	ListMenu.AddEntryItem("Access Stolen Stuff")
	ListMenu.AddEntryItem("Toggle Stash Tracking On Crosshair Ref")
	ListMenu.AddEntryItem("Print Vendor Gold Estimations")
	ListMenu.AddEntryItem("Get Animations By Tags")
	ListMenu.AddEntryItem("Get Faction Reaction")
	ListMenu.AddEntryItem("Race Can't Open Doors Flag")
	ListMenu.AddEntryItem("Recheck Animal Friend Factions")
	ListMenu.AddEntryItem("Tame Creature")
	ListMenu.AddEntryItem("List Current Dropped Items")
	ListMenu.AddEntryItem("Access Older Dropped Items")
	ListMenu.AddEntryItem("Help! My Camera's Stuck")
	ListMenu.AddEntryItem("Help! I'm Ragdoll Stuck")
	ListMenu.OpenMenu()
	;Debug.Messagebox(ListMenu.GetResultInt())
	Return ListMenu.GetResultInt()
EndFunction

Function Stuck1()
	ObjectReference Skyforge = PlayerRef.PlaceAtMe(Game.GetFormFromFile(0xBBCF1, "Skyrim.esm"))
	Utility.Wait(0.5)
	Skyforge.Activate(PlayerRef)
	Utility.Wait(2.0)
	PlayerRef.MoveTo(PlayerRef)
	Utility.Wait(0.5)
	Skyforge.Disable()
	Skyforge.Delete()
EndFunction

Function Stuck2()
	(Game.GetFormFromFile(0x01CAF6, "SL Survival.esp") as Spell).Cast(PlayerRef, PlayerRef) ; _SLS_PushPlayerSpell
	PlayerRef.PushActorAway(PlayerRef, 1.5)
EndFunction

Function DroppedItemsMenu()
	Int MenuResult = ShowDroppedItemsMenu()
	If MenuResult == -1
		DebugMenu()
	Else
		ObjectReference ObjRef = StorageUtil.FormListGet(Self, "_SLS_LostFoundList", MenuResult) as ObjectReference
		PlayerRef.AddItem(ObjRef)
		(Game.GetFormFromFile(0x12B24F, "SL Survival.esp") as _SLS_LostFound).ClearObjRef(ObjRef)
	EndIf
EndFunction

Int Function ShowDroppedItemsMenu()
	StorageUtil.FormListClear(Self, "_SLS_LostFoundList")
	Quest _SLS_LostFoundQuest = Game.GetFormFromFile(0x12B24F, "SL Survival.esp") as Quest
	ObjectReference ObjRef
	Int i = 0
	While i < _SLS_LostFoundQuest.GetNumAliases()
		ObjRef = (_SLS_LostFoundQuest.GetNthAlias(i) as ReferenceAlias).GetReference()
		If ObjRef
			StorageUtil.FormListAdd(Self, "_SLS_LostFoundList", ObjRef)
		EndIf
		i += 1
	EndWhile

	If StorageUtil.FormListCount(Self, "_SLS_LostFoundList")
		UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
		i = 0
		While i < StorageUtil.FormListCount(Self, "_SLS_LostFoundList")
			ListMenu.AddEntryItem((StorageUtil.FormListGet(Self, "_SLS_LostFoundList", i) as ObjectReference).GetDisplayName())
			i += 1
		EndWhile
		ListMenu.OpenMenu()
		Return ListMenu.GetResultInt()
	Else
		Debug.Notification("No lost items found. Try 'Access Older Lost'")
	EndIf
	Return -1
	;Debug.Messagebox(ListMenu.GetResultInt())
	
EndFunction

Function RaceDoorFlagMenu()
	Actor akTarget = XhairTarget as Actor
	If akTarget
		Race akRace = akTarget.GetRace()
		Int MenuResult = ShowRaceDoorFlagMenu(akTarget)
		If MenuResult == -1
			DebugMenu()
		ElseIf MenuResult == 1
			akTarget.GetRace().SetRaceFlag(0x00100000)
			Debug.Notification(Menu.TidyFormString(akRace) + " can't open doors TRUE")
		ElseIf MenuResult == 2
			akTarget.GetRace().ClearRaceFlag(0x00100000)
			Debug.Notification(Menu.TidyFormString(akRace) + " can't open doors FALSE")
		EndIf
	Else
		Debug.Notification("Needs a crosshairs Ref!")
	EndIf
EndFunction

Int Function ShowRaceDoorFlagMenu(Actor akTarget)
	Race akRace = akTarget.GetRace()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("Race: " + Menu.TidyFormString(akRace) + ". Flag: " + akRace.IsRaceFlagSet(0x00100000))
	ListMenu.AddEntryItem("Set Race Can't Opens Doors Flag To True")
	ListMenu.AddEntryItem("Set Race Can't Opens Doors Flag To False")
	ListMenu.OpenMenu()
	Return ListMenu.GetResultInt()
EndFunction

Int Function GetAnimActorCount()
	Return ShowGetAnimActorCount()
EndFunction

Int Function ShowGetAnimActorCount()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("1 Actor")
	ListMenu.AddEntryItem("2 Actors")
	ListMenu.AddEntryItem("3 Actors")
	ListMenu.AddEntryItem("4 Actors")
	ListMenu.AddEntryItem("5 Actors")
	ListMenu.OpenMenu()
	Return ListMenu.GetResultInt() + 1
EndFunction

Function GetAnimationsListByTags()
	If XhairTarget as Actor
		Int ActorCount = GetAnimActorCount()
		
		If ActorCount > -1
			UITextEntryMenu TextMenu = UIExtensions.GetMenu("UITextEntryMenu") as UITextEntryMenu
			TextMenu.SetPropertyString("text", "Anim tags")
			TextMenu.OpenMenu(PlayerRef)
			String Tags = TextMenu.GetResultString()
			TextMenu = UIExtensions.GetMenu("UITextEntryMenu") as UITextEntryMenu
			TextMenu.SetPropertyString("text", "Suppress tags")
			TextMenu.OpenMenu(PlayerRef)
			String SuppressTags = TextMenu.GetResultString()
			
			
			sslBaseAnimation[] Anims
			If Menu._SLS_FondleableVoices.HasForm(XhairTarget.GetVoiceType())
				Anims = Sexlab.GetCreatureAnimationsByRaceTags(ActorCount, (XhairTarget as Actor).GetRace(), Tags, SuppressTags, RequireAll = true)
			Else
				Anims = Sexlab.GetAnimationsByTags(ActorCount, Tags, SuppressTags, RequireAll = true)
			EndIf
			
			UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
			Int i = 0
			While i < Anims.Length
				ListMenu.AddEntryItem(Anims[i].Name)
				i += 1
			EndWhile
			ListMenu.OpenMenu()
		Else
			DebugMenu()
		EndIf
	Else
		Debug.Notification("Needs a crosshairs Ref!")
	EndIf
EndFunction

Function PrintVendorGoldEstimations()
	ObjectReference Chest = Game.GetFormFromFile(0x113901, "SL Survival.esp") as ObjectReference
	
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem(" == Combined Lists: Male, Female, Total == ")
	ListMenu.AddEntryItem(GetCombinedVendorListEstimation(Chest, "VendorGoldApothecary", Main._SLS_VendorGoldApothecaryMale, Main._SLS_VendorGoldApothecaryFemale))
	ListMenu.AddEntryItem(GetCombinedVendorListEstimation(Chest, "VendorGoldBlacksmith", Main._SLS_VendorGoldBlacksmithMale, Main._SLS_VendorGoldBlacksmithFemale))
	ListMenu.AddEntryItem(GetCombinedVendorListEstimation(Chest, "VendorGoldBlacksmithTown", Main._SLS_VendorGoldBlacksmithTownMale, Main._SLS_VendorGoldBlacksmithTownFemale))
	ListMenu.AddEntryItem(GetCombinedVendorListEstimation(Chest, "VendorGoldMisc", Main._SLS_VendorGoldMiscMale, Main._SLS_VendorGoldMiscFemale))
	ListMenu.AddEntryItem(GetCombinedVendorListEstimation(Chest, "VendorGoldSpells", Main._SLS_VendorGoldSpellsMale, Main._SLS_VendorGoldSpellsFemale))
	ListMenu.AddEntryItem(GetCombinedVendorListEstimation(Chest, "VendorGoldStreetVendor", Main._SLS_VendorGoldStreetVendorMale, Main._SLS_VendorGoldStreetVendorFemale))
	ListMenu.AddEntryItem(" == Root Lists == ")
	ListMenu.AddEntryItem(GetRootVendorListEstimation(Chest, "VendorGoldApothecary", Main.VendorGoldApothecary))
	ListMenu.AddEntryItem(GetRootVendorListEstimation(Chest, "VendorGoldBlacksmith", Main.VendorGoldBlacksmith))
	ListMenu.AddEntryItem(GetRootVendorListEstimation(Chest, "VendorGoldBlacksmithTown", Main.VendorGoldBlacksmithTown))
	ListMenu.AddEntryItem(GetRootVendorListEstimation(Chest, "VendorGoldMisc", Main.VendorGoldMisc))
	ListMenu.AddEntryItem(GetRootVendorListEstimation(Chest, "VendorGoldSpells", Main.VendorGoldSpells))
	ListMenu.AddEntryItem(GetRootVendorListEstimation(Chest, "VendorGoldStreetVendor", Main.VendorGoldStreetVendor))
	ListMenu.OpenMenu()
EndFunction

String Function GetCombinedVendorListEstimation(ObjectReference Chest, String ListName, LeveledItem MaleList, LeveledItem FemaleList)
	Chest.RemoveAllItems()
	String S1 = ListName + ": "
	Chest.AddItem(MaleList, 1)
	Int MaleCount = Chest.GetItemCount(Gold001)
	Chest.RemoveAllItems()
	Chest.AddItem(FemaleList, 1)
	Int FemaleCount = Chest.GetItemCount(Gold001)
	Return ListName + ": " + MaleCount + ", " + FemaleCount + ", " + (MaleCount + FemaleCount)
EndFunction

String Function GetRootVendorListEstimation(ObjectReference Chest, String ListName, LeveledItem List)
	Chest.RemoveAllItems()
	Chest.AddItem(List, 1)
	Return ListName + ": " + Chest.GetItemCount(Gold001)
EndFunction

Function StolenStuffMenu(Bool IsShortcut = false)
	Int MenuResult = ShowStolenStuffMenu()
	If MenuResult == -1
		DebugMenu()
	ElseIf MenuResult == 0 ; Lic - Weapon Confiscations
		(Game.GetFormFromFile(0x044685, "SL Survival.esp") as ObjectReference).Activate(PlayerRef)
	ElseIf MenuResult == 1 ; Lic - Armor Confiscations
		(Game.GetFormFromFile(0x044686, "SL Survival.esp") as ObjectReference).Activate(PlayerRef)
	ElseIf MenuResult == 2 ; Lic - Clothes Confiscations
		(Game.GetFormFromFile(0x0492C6, "SL Survival.esp") as ObjectReference).Activate(PlayerRef)
	ElseIf MenuResult == 3 ; Lic - Magic Confiscations
		(Game.GetFormFromFile(0x05819F, "SL Survival.esp") as ObjectReference).Activate(PlayerRef)
	ElseIf MenuResult == 4 ; Stash/Dropped Stolen
		(Game.GetFormFromFile(0x006E06, "SL Survival.esp") as ObjectReference).Activate(PlayerRef)
	ElseIf MenuResult == 5 ; Eviction Confiscations
		EvictionConfiscationsMenu()
	EndIf
EndFunction

Function EvictionConfiscationsMenu(Bool IsShortcut = false)
	Int MenuResult = ShowEvictionConfiscationsMenu()
	If MenuResult == -1
		StolenStuffMenu()
	ElseIf MenuResult == 0 ; Whiterun
		(Game.GetFormFromFile(0x026894, "SL Survival.esp") as ObjectReference).Activate(PlayerRef)
	ElseIf MenuResult == 1 ; Solitude
		(Game.GetFormFromFile(0x026897, "SL Survival.esp") as ObjectReference).Activate(PlayerRef)
	ElseIf MenuResult == 2 ; Markarth
		(Game.GetFormFromFile(0x02689A, "SL Survival.esp") as ObjectReference).Activate(PlayerRef)
	ElseIf MenuResult == 3 ; Windhelm
		(Game.GetFormFromFile(0x02689B, "SL Survival.esp") as ObjectReference).Activate(PlayerRef)
	ElseIf MenuResult == 4 ; Riften
		(Game.GetFormFromFile(0x02689D, "SL Survival.esp") as ObjectReference).Activate(PlayerRef)
	EndIf
EndFunction

Int Function ShowEvictionConfiscationsMenu()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("Whiterun ")
	ListMenu.AddEntryItem("Solitude ")
	ListMenu.AddEntryItem("Markarth ")
	ListMenu.AddEntryItem("Windhelm ")
	ListMenu.AddEntryItem("Riften ")
	ListMenu.OpenMenu()
	Return ListMenu.GetResultInt()
EndFunction

Int Function ShowStolenStuffMenu()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("Lic - Weapon Confiscations")
	ListMenu.AddEntryItem("Lic - Armor Confiscations")
	ListMenu.AddEntryItem("Lic - Clothes Confiscations")
	ListMenu.AddEntryItem("Lic - Magic Confiscations")
	ListMenu.AddEntryItem("Stash/Dropped Stolen")
	ListMenu.AddEntryItem("Eviction Confiscations")
	ListMenu.OpenMenu()
	Return ListMenu.GetResultInt()
EndFunction

Function TraumaMenu(Bool IsShortcut = false)
	Int MenuResult = ShowTraumaMenu()
	If MenuResult == -1
		DebugMenu()
	ElseIf MenuResult == 0
		Menu.Trauma.DumpInfo(GetMenuTargetActor())
	ElseIf MenuResult == 1
		Menu.Trauma.SetupActor(GetMenuTargetActor())
	ElseIf MenuResult == 2
		Menu.Trauma.AddRandomTrauma(GetMenuTargetActor())
	ElseIf MenuResult == 3
		Menu.Trauma.RemoveAllTraumasFromActor(GetMenuTargetActor())
	ElseIf MenuResult == 4
		Menu.Trauma.UnSetupActor(GetMenuTargetActor())	
	EndIf
EndFunction

Int Function ShowTraumaMenu()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("Display Actor Trauma Info")
	ListMenu.AddEntryItem("Add Actor To System")
	ListMenu.AddEntryItem("Add Random Trauma")
	ListMenu.AddEntryItem("Remove All Traumas")
	ListMenu.AddEntryItem("Remove Actor From Trauma System")
	ListMenu.OpenMenu()
	Return ListMenu.GetResultInt()
EndFunction

Function IssueLicenceMenu(Bool IsShortcut = false)
	Int MenuResult = ShowIssueLicenceMenu()
	If MenuResult == -1
		DebugMenu()
	ElseIf MenuResult == 0
		IssueAllLicences(LicDuration = 0)
	ElseIf MenuResult == 1
		IssueAllLicences(LicDuration = 1)
	ElseIf MenuResult == 2
		IssueAllLicences(LicDuration = 2)
	ElseIf MenuResult == 3
		IssueSingleLicence(Duration = 0)
	ElseIf MenuResult == 4
		IssueSingleLicence(Duration = 1)
	ElseIf MenuResult == 5
		IssueSingleLicence(Duration = 2)
	EndIf		
EndFunction

Int Function ShowIssueLicenceMenu()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("Issue All Licence - Short Duration")
	ListMenu.AddEntryItem("Issue All Licence - Long Duration")
	ListMenu.AddEntryItem("Issue All Licence - Perpetual")
	
	ListMenu.AddEntryItem("Issue Single Short Duration Licence")
	ListMenu.AddEntryItem("Issue Single Long Duration Licence")
	ListMenu.AddEntryItem("Issue Single Perpetual Licence")
	ListMenu.OpenMenu()
	Return ListMenu.GetResultInt()
EndFunction

Function IssueSingleLicence(Int Duration)
	Int MenuResult = ShowIssueSingleLicenceMenu()
	If MenuResult == -1
		IssueLicenceMenu()
	Else
		IssueLicence(LicType = MenuResult, LicDuration = Duration)
	EndIf	
EndFunction

Int Function ShowIssueSingleLicenceMenu()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("Magic Licence")
	ListMenu.AddEntryItem("Weapon Licence")
	ListMenu.AddEntryItem("Armor Licence")
	ListMenu.AddEntryItem("Bikini Licence")
	ListMenu.AddEntryItem("Clothes Licence")
	ListMenu.AddEntryItem("Curfew Licence")
	ListMenu.AddEntryItem("Whore Licence")
	ListMenu.AddEntryItem("Property Licence")
	ListMenu.AddEntryItem("Freedom Licence")
	ListMenu.OpenMenu()
	Return ListMenu.GetResultInt()
EndFunction

Function IssueAllLicences(Int LicDuration)
	Int i = 0
	While i < StorageUtil.StringListCount(Self, "HasValidXLicences")
		If StorageUtil.GetIntValue(None, StorageUtil.StringListGet(Self, "HasValidXLicences", i)) != -1 ; Licence enabled - issue
			IssueLicence(LicType = i, LicDuration = LicDuration)
		EndIf
		i += 1
	EndWhile
EndFunction

Function IssueLicence(Int LicType, Int LicDuration)
	Int IssueLic = ModEvent.Create("_SLS_IssueLicence")
	If (IssueLic)
		ModEvent.PushInt(IssueLic, LicType)
		ModEvent.PushInt(IssueLic, LicDuration)
		ModEvent.PushForm(IssueLic, Game.GetFormFromFile(0x046213, "SL Survival.esp"))
		ModEvent.PushForm(IssueLic, PlayerRef)
		ModEvent.PushBool(IssueLic, false)
		ModEvent.PushForm(IssueLic, self)
		ModEvent.Send(IssueLic)
	EndIf
EndFunction

Function DisplayApiGlobals()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("_SLS_PlayerIsMagicCursed: " + StorageUtil.GetIntValue(None, "_SLS_PlayerIsMagicCursed", Missing = -2))
	
	ListMenu.AddEntryItem("=====> _SLS_HasValidXLicence <=====")
	ListMenu.AddEntryItem("_SLS_HasValidMagicLicence: " + StorageUtil.GetIntValue(None, "_SLS_HasValidMagicLicence", Missing = -2))
	ListMenu.AddEntryItem("_SLS_HasValidWeaponLicence: " + StorageUtil.GetIntValue(None, "_SLS_HasValidWeaponLicence", Missing = -2))
	ListMenu.AddEntryItem("_SLS_HasValidArmorLicence: " + StorageUtil.GetIntValue(None, "_SLS_HasValidArmorLicence", Missing = -2))
	ListMenu.AddEntryItem("_SLS_HasValidBikiniLicence: " + StorageUtil.GetIntValue(None, "_SLS_HasValidBikiniLicence", Missing = -2))
	ListMenu.AddEntryItem("_SLS_HasValidClothesLicence: " + StorageUtil.GetIntValue(None, "_SLS_HasValidClothesLicence", Missing = -2))
	ListMenu.AddEntryItem("_SLS_HasValidCurfewLicence: " + StorageUtil.GetIntValue(None, "_SLS_HasValidCurfewLicence", Missing = -2))
	ListMenu.AddEntryItem("_SLS_HasValidWhoreLicence: " + StorageUtil.GetIntValue(None, "_SLS_HasValidWhoreLicence", Missing = -2))
	ListMenu.AddEntryItem("_SLS_HasValidPropertyLicence: " + StorageUtil.GetIntValue(None, "_SLS_HasValidPropertyLicence", Missing = -2))
	ListMenu.AddEntryItem("_SLS_HasValidFreedomLicence: " + StorageUtil.GetIntValue(None, "_SLS_HasValidFreedomLicence", Missing = -2))
	
	ListMenu.AddEntryItem("=====> _SLS_LicenceXValidUntil <=====")
	ListMenu.AddEntryItem("_SLS_LicenceMagicValidUntil: " + StorageUtil.GetFloatValue(None, "_SLS_LicenceMagicValidUntil", Missing = -2.0))
	ListMenu.AddEntryItem("_SLS_LicenceWeaponValidUntil: " + StorageUtil.GetFloatValue(None, "_SLS_LicenceWeaponValidUntil", Missing = -2.0))
	ListMenu.AddEntryItem("_SLS_LicenceArmorValidUntil: " + StorageUtil.GetFloatValue(None, "_SLS_LicenceArmorValidUntil", Missing = -2.0))
	ListMenu.AddEntryItem("_SLS_LicenceBikiniValidUntil: " + StorageUtil.GetFloatValue(None, "_SLS_LicenceBikiniValidUntil", Missing = -2.0))
	ListMenu.AddEntryItem("_SLS_LicenceClothesValidUntil: " + StorageUtil.GetFloatValue(None, "_SLS_LicenceClothesValidUntil", Missing = -2.0))
	ListMenu.AddEntryItem("_SLS_LicenceCurfewValidUntil: " + StorageUtil.GetFloatValue(None, "_SLS_LicenceCurfewValidUntil", Missing = -2.0))
	ListMenu.AddEntryItem("_SLS_LicenceWhoreValidUntil: " + StorageUtil.GetFloatValue(None, "_SLS_LicenceWhoreValidUntil", Missing = -2.0))
	ListMenu.AddEntryItem("_SLS_LicenceFreedomValidUntil: " + StorageUtil.GetFloatValue(None, "_SLS_LicenceFreedomValidUntil", Missing = -2.0))
	ListMenu.AddEntryItem("_SLS_LicencePropertyValidUntil: " + StorageUtil.GetFloatValue(None, "_SLS_LicencePropertyValidUntil", Missing = -2.0))

	ListMenu.OpenMenu()
EndFunction

Function OwnershipDebugMenu(Bool IsShortcut = false)
	Int MenuResult = ShowOwnershipDebugMenu()
	If MenuResult == -1
		DebugMenu()
	ElseIf MenuResult == 0
		GetCellInfo()
	ElseIf MenuResult == 1
		SetCellOwnerNone()
	ElseIf MenuResult == 2
		SetCellPublic(true)
	ElseIf MenuResult == 3
		SetCellPublic(false)
	ElseIf MenuResult == 4
		GetObjectInfo()
	ElseIf MenuResult == 5
		SetObjectOwnerNone()
	ElseIf MenuResult == 6
		ResetCell()
	EndIf
EndFunction

Int Function ShowOwnershipDebugMenu()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu	
	ListMenu.AddEntryItem("Get Cell Info")
	ListMenu.AddEntryItem("Set Cell Owning Faction To None")
	ListMenu.AddEntryItem("Set Cell To Public")
	ListMenu.AddEntryItem("Set Cell To Private")
	ListMenu.AddEntryItem("Get Object Info")
	ListMenu.AddEntryItem("Set Object Owner To None")
	ListMenu.AddEntryItem("Flag Cell For Reset")
	ListMenu.OpenMenu()
	Return ListMenu.GetResultInt()
EndFunction

Function ResetCell()
	;PlayerRef.GetParentCell().Reset()
	(Game.GetFormFromFile(0x005932, "pchsWartimes.esp") as Cell).Reset()
EndFunction

Function SetObjectOwnerNone()
	If xHairTarget
		xHairTarget.SetActorOwner(None)
		xHairTarget.SetFactionOwner(None)
	Else
		Debug.Notification("No Crosshair target!")
	EndIf
EndFunction

Function GetObjectInfo()
	If xHairTarget
		ActorBase Owner = xHairTarget.GetActorOwner()
		String OwnerFormId
		String OwnerName
		If Owner
			OwnerFormId = GetFormIdString(Owner)
			OwnerName = Owner.GetName()
		EndIf
		
		Faction OwnerFact = xHairTarget.GetFactionOwner()
		String OwnerFactFormId
		String OwnerFactName
		If OwnerFact
			OwnerFactFormId = GetFormIdString(OwnerFact)
			OwnerFactName = OwnerFact.GetName()
		EndIf
		Debug.Messagebox("FormID: " + GetFormIdString(xHairTarget) + "\nName: " + xHairTarget.GetName() + "\n\nActor Owner: " + OwnerFormId + "\nActor Name: " + OwnerName + "\n\nFaction: " + OwnerFactFormId + "\nFaction Name: " + OwnerFactName)
	Else
		Debug.Notification("No Crosshair target!")
	EndIf
EndFunction

Function SetCellPublic(Bool Public)
	PlayerRef.GetParentCell().SetPublic(Public)
EndFunction

Function SetCellOwnerNone()
	PlayerRef.GetParentCell().SetActorOwner(None)
	PlayerRef.GetParentCell().SetFactionOwner(None)
EndFunction

Function GetCellInfo()
	Cell CurrentCell = PlayerRef.GetParentCell()
	String OwnerFormId
	String Owner
	If CurrentCell.GetActorOwner()
		OwnerFormId = GetFormIdString(CurrentCell.GetActorOwner())
		Owner = CurrentCell.GetActorOwner().GetName()
	EndIf
	
	String FactionOwnerFormId
	String FactionOwner
	If CurrentCell.GetFactionOwner()
		FactionOwnerFormId = GetFormIdString(CurrentCell.GetFactionOwner())
		FactionOwner = CurrentCell.GetFactionOwner().GetName()
	EndIf
	Debug.Messagebox("Cell FormID: " + GetFormIdString(CurrentCell) + "\nCell Name: " + CurrentCell.GetName() + "\n\nOwner: " + OwnerFormId + "\nName: " + Owner + "\n\nFaction Owner: " + FactionOwnerFormId + "\nFaction Name: " + FactionOwner + "\n\nTrespassing: " + PlayerRef.IsTrespassing() + "\nInterior: " + CurrentCell.IsInterior() + "\nWater Level: " + CurrentCell.GetWaterLevel())
EndFunction

Function ToggleHelloComments()
	Actor akTarget = xHairTarget as Actor
	If akTarget
		If akTarget.IsInFaction(_SLS_NoHelloCommentsFact)
			akTarget.RemoveFromFaction(_SLS_NoHelloCommentsFact)
			JsonUtil.FormListRemove("SL Survival/HelloExclusions.json", "helloexclusions", akTarget)
		Else
			JsonUtil.FormListAdd("SL Survival/HelloExclusions.json", "helloexclusions", akTarget)
			akTarget.AddToFaction(_SLS_NoHelloCommentsFact)
		EndIf
	Else
		Debug.Notification("No crosshairs target")
	EndIf
EndFunction

Function AddItemMenu()
	If Game.GetModByName("AddItemMenuLE.esp") != 255
		(Game.GetFormFromFile(0x00895C, "AddItemMenuLE.esp") as Spell).Cast(PlayerRef, PlayerRef)
	ElseIf Game.GetModByName("AddItemMenuSE.esp") != 255
		(Game.GetFormFromFile(0x16E801, "AddItemMenuSE.esp") as Spell).Cast(PlayerRef, PlayerRef)
	Else
		Debug.Notification("AddItemMenu not found in your load order")
	EndIf
EndFunction

Function GetKeywordsOnTarget()
	If StorageUtil.GetIntValue(Self, "GetKeywordsOnTargetHelp") == 1
		Debug.Messagebox("Gets the keywords attached to the BASE of the object under the crosshairs. Keywords applied via magic effects or aliases are not picked up by this. \n\nUseful for checking if an armor has the bikini keyword or not. Drop it on the ground, put it under the crosshairs and run this to retrieve a list of the attached keywords")
		Utility.Wait(0.2)
		StorageUtil.UnSetIntValue(Self, "GetKeywordsOnTargetHelp")
	EndIf
	ObjectReference akTarget = XhairTarget
	If !akTarget
		akTarget = PlayerRef
	EndIf
	Form akForm
	If akTarget as Actor
		akForm = (akTarget as Actor).GetLeveledActorBase()
	Else
		akForm = akTarget.GetBaseObject()
	EndIf

	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("==> " + akForm.GetName() + " <==")
	ListMenu.AddEntryItem("Keyword Count: " + akForm.GetNumKeywords())

	Int i = 0
	While i < akForm.GetNumKeywords()
		ListMenu.AddEntryItem(akForm.GetNthKeyword(i))
		i += 1
	EndWhile
	ListMenu.OpenMenu()
EndFunction

Function OverlaysMenu(Bool IsShortcut = false)
	Actor akActor = XhairTarget as Actor
	If !akActor
		akActor = PlayerRef
	EndIf
	Debug.Notification("Target: " + akActor.GetLeveledActorBase().GetName())
	Bool Gender = akActor.GetLeveledActorBase().GetSex() as Bool
	
	Int MenuResult = ShowOverlaysMenu()
	If MenuResult == -1
	
	ElseIf MenuResult == 0 ; Clear Overlay
		Util.ClearOverlaySlot(akActor, Gender, GetOverlayNode(akActor, Gender))
	
	ElseIf MenuResult == 1 ; Set Overlay Manually
		If StorageUtil.GetIntValue(Self, "SetOverlaysHelp") == 1
			Debug.Messagebox("Setting overlays is experimental!\nYou should only proceed if you know what you're doing and have saved your game\n\n'data/Textures/' is automatically included in the texture path")
			StorageUtil.UnSetIntValue(Self, "SetOverlaysHelp")
			Utility.Wait(0.5)
		EndIf
		String Node = GetOverlayNode(akActor, Gender)
		String ExistingOverlay = NiOverride.GetNodeOverrideString(akActor, Gender, Node, 9, 0)
		String InputTexture = GetInputTexture(ExistingOverlay)
		If InputTexture == ""
			Debug.Messagebox("Texture can not be set to ''\n\nIf you want to clear an overlay use 'Clear overlay' instead")
		ElseIf InputTexture == ExistingOverlay
			Debug.Messagebox("Input texture the same as the existing texture\nAborting.")
		ElseIf !MiscUtil.FileExists("data/textures/" + InputTexture)
			Debug.Messagebox("Texture file does not exist:\ndata/textures/" + InputTexture)
		Else
			Float Opacity = SelectOverlayOpacity()
			If Opacity >= 0.0
				ApplyOverlay(akActor, Gender, Node, InputTexture, Opacity, GetOverlayColor("Choose TINT color"), GetOverlayColor("Choose EMISSIVE color"))
			EndIf
		EndIf
		
	ElseIf MenuResult == 2 ; Set Overlay From Json
		String File = SelectOverlayJsonFile()
		If File
			String Area = SelectOverlayArea("SL Survival/Overlays/" + File)
			;String[] OverlayList = GetJsonOverlayList(Area)
			String InputTexture = SelectOverlayFromJsonList(File, Area)
			Int SelectedSlot = SelectOverlaySlot(akActor, Gender, Area)
			Float Opacity = SelectOverlayOpacity()
			If Opacity >= 0.0
				ApplyOverlay(akActor, Gender, Area + " [ovl" + SelectedSlot + "]", InputTexture, Opacity, GetOverlayColor("Choose TINT color"), GetOverlayColor("Choose EMISSIVE color"))
			EndIf
		EndIf
		
	ElseIf MenuResult == 3 ; Clear last overlay
		ClearLastOverlay()
		
	ElseIf MenuResult == 4 ; Add Random RapeTat
		If Init.RapeTatsInstalled
			RapeTats.AddRapeTat(akActor)
		Else
			Debug.Notification("RapeTats is not installed")
		EndIf
		
	EndIf
EndFunction

Function ApplyOverlay(Actor akTarget, Bool Gender, String Node, String TextureToApply, Float Alpha, Int TintColor, Int EmissiveColor)
	; Set StUtil variables to allow quick clear
	StorageUtil.SetFormValue(Self, "LastOverlay_Actor", akTarget)
	StorageUtil.SetStringValue(Self, "LastOverlay_Node", Node)
	
	Util.ApplyOverlayAtNodeWithColors(akTarget, Gender, Node, TextureToApply, Alpha, TintColor, EmissiveColor)
EndFunction

Int Function ShowOverlaysMenu()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	;ListMenu.AddEntryItem("Do Nothing")
	ListMenu.AddEntryItem("Clear Overlay")
	ListMenu.AddEntryItem("Set Overlay Manually")
	ListMenu.AddEntryItem("Set Overlay From Json")
	ListMenu.AddEntryItem("Clear Last Overlay (Not RapeTats)")
	If Init.RapeTatsInstalled
		ListMenu.AddEntryItem("Add Random RapeTat")
	EndIf
	ListMenu.OpenMenu()
	Return ListMenu.GetResultInt()
EndFunction

String Function GetOverlayNode(Actor akActor, Bool Gender)
	String Area = SelectOverlayArea()
	Return Area + " [ovl" + (SelectOverlaySlot(akActor, Gender, Area) as String) + "]"
EndFunction

String Function SelectOverlayArea(String File = "")
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	String OverlayCount
	Int i = 0
	While i < Menu.OverlayAreas.Length
		If File
			OverlayCount = " (" + JsonUtil.StringListCount(File, Menu.OverlayAreas[i]) + ")"
		EndIf
		ListMenu.AddEntryItem(Menu.OverlayAreas[i] + OverlayCount)
		i += 1
	EndWhile
	ListMenu.OpenMenu()
	Return Menu.OverlayAreas[ListMenu.GetResultInt()]
EndFunction

Int Function SelectOverlaySlot(Actor akActor, Bool Gender, String Area)
	String Node
	String OverlayName
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	Int i = 0
	While i < Util.GetNumSlots(Area)
		Node = Area + " [ovl" + i + "]"
		OverlayName = NiOverride.GetNodeOverrideString(akActor, Gender, Node, 9, 0)
		ListMenu.AddEntryItem(i + ") " + StringUtil.Substring(OverlayName, startIndex = StringUtil.GetLength(OverlayName) - 40))
		i += 1
	EndWhile
	ListMenu.OpenMenu()
	Return ListMenu.GetResultInt()
EndFunction

Float Function SelectOverlayOpacity()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	Int i = 0
	While i <= 10
		ListMenu.AddEntryItem((i * 10 ) + "% Opacity")
		i += 1
	EndWhile
	ListMenu.OpenMenu()
	Return ((ListMenu.GetResultInt() * 10) / 100.0) as Float
EndFunction

String Function GetInputTexture(String ExistingOverlay)
	UITextEntryMenu TextMenu = UIExtensions.GetMenu("UITextEntryMenu") as UITextEntryMenu
	TextMenu.SetPropertyString("text", ExistingOverlay)
	TextMenu.OpenMenu(inForm = PlayerRef, akReceiver = Self)
	Return TextMenu.GetResultString()
EndFunction

String Function SelectOverlayFromJsonList(String File, String Area)
	String[] OverlayList = JsonUtil.StringListToArray("SL Survival/Overlays/" + File,  Area)
	String[] DisplayList = JsonUtil.StringListToArray("SL Survival/Overlays/" + File,  Area)
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	Int i = 0
	While i < DisplayList.Length
		ListMenu.AddEntryItem(StringUtil.Substring(DisplayList[i], startIndex = StringUtil.GetLength(DisplayList[i]) - 40))
		i += 1
	EndWhile
	ListMenu.OpenMenu()
	Return OverlayList[ListMenu.GetResultInt()]
EndFunction

Int Function GetOverlayColor(String Msg = "")
	If Msg
		Debug.Notification(Msg)
	EndIf
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	Int i = 0
	While i < JsonUtil.StringListCount("SL Survival/OverlayColors.json", "colorlist")
		ListMenu.AddEntryItem(JsonUtil.StringListGet("SL Survival/OverlayColors.json", "colorlist", i))
		i += 1
	EndWhile
	ListMenu.OpenMenu()
	Return JsonUtil.GetIntValue("SL Survival/OverlayColors.json", JsonUtil.StringListGet("SL Survival/OverlayColors.json", "colorlist", ListMenu.GetResultInt()))
EndFunction

Function ClearLastOverlay()
	Actor akTarget = StorageUtil.GetFormValue(Self, "LastOverlay_Actor") as Actor
	If akTarget
		Util.ClearOverlaySlot(akTarget, Gender = akTarget.GetLeveledActorBase().GetSex() as Bool, Node = StorageUtil.GetStringValue(Self, "LastOverlay_Node"))
		StorageUtil.UnSetFormValue(Self, "LastOverlay_Actor")
		StorageUtil.UnSetStringValue(Self, "LastOverlay_Node")
	Else
		Debug.Notification("Clear last overlay - No target")
	EndIf
EndFunction

String Function SelectOverlayJsonFile()
	String[] Files = MiscUtil.FilesInFolder("Data/SKSE/Plugins/StorageUtilData/SL Survival/Overlays/", extension = "json")
	If Files.Length > 0
		UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
		Int i = 0 
		While i < Files.Length
			ListMenu.AddEntryItem(Files[i])
			i += 1
		EndWhile
		ListMenu.OpenMenu()
		Return Files[ListMenu.GetResultInt()]
	EndIf
	Debug.Notification("There are no overlay json files")
	Return ""
EndFunction

Function GetActorFactions()
	Actor akActor = XhairTarget as Actor
	If !akActor
		akActor = PlayerRef
	EndIf
	Faction[] FactionList = akActor.GetFactions(0, 127)
	
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem("==> " + akActor.GetLeveledActorBase().GetName() + " <==")
	ListMenu.AddEntryItem("Rank: FormId: Name (If any)")
	Int i = 0
	While i < FactionList.Length
		ListMenu.AddEntryItem(akActor.GetFactionRank(FactionList[i]) + ": " + GetFormIdString(FactionList[i]) + ": " + FactionList[i].GetName())
		i += 1
	EndWhile
	ListMenu.OpenMenu()
	;Debug.Messagebox(ListMenu.GetResultInt())
	;Return ListMenu.GetResultInt()
EndFunction

Function ModEventsMenu()
	Int MenuResult = ShowModEventsMenu()
	If MenuResult == -1
		DebugMenu()
	ElseIf MenuResult == 0
		EvictRootMenu()
	EndIf
EndFunction

Int Function ShowModEventsMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Evict ")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Evict ")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction

Function EvictRootMenu(Bool IsShortcut = false)
	Int MenuResult = ShowEvictRootMenu()
	If MenuResult == -1
		ModEventsMenu()
	ElseIf MenuResult == 0
		EvictFromMenu()
	ElseIf MenuResult == 1
		UnEvictFromMenu()
	ElseIf MenuResult == 2
		EvictionFormsMenu()
	ElseIf MenuResult == 3
		EvictionReasonsMenu()
	EndIf
EndFunction

Int Function ShowEvictRootMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Evict Test")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "UnEvict Test")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Eviction Forms")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Eviction Reasons")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Evict Test")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "UnEvict Test")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Eviction Forms")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Eviction Reasons")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction

Function EvictFromMenu(Bool IsShortcut = false)
	Int MenuResult = ShowCityLocationMenu()
	If MenuResult == -1
		EvictRootMenu()
	ElseIf MenuResult == 0
		Api.On_SLS_EvictFromHome(HomeInt = 0, EvictForm = Self, EvictReason = "Test ")
	ElseIf MenuResult == 1
		Api.On_SLS_EvictFromHome(HomeInt = 1, EvictForm = Self, EvictReason = "Test ")
	ElseIf MenuResult == 2
		Api.On_SLS_EvictFromHome(HomeInt = 2, EvictForm = Self, EvictReason = "Test ")
	ElseIf MenuResult == 3
		Api.On_SLS_EvictFromHome(HomeInt = 3, EvictForm = Self, EvictReason = "Test ")
	ElseIf MenuResult == 4
		Api.On_SLS_EvictFromHome(HomeInt = 4, EvictForm = Self, EvictReason = "Test ")
	EndIf
EndFunction

Function UnEvictFromMenu(Bool IsShortcut = false)
	Int MenuResult = ShowCityLocationMenu()
	If MenuResult == -1
		EvictRootMenu()
	ElseIf MenuResult == 0
		Api.On_SLS_UnEvictFromHome(HomeInt = 0, EvictForm = Self)
	ElseIf MenuResult == 1
		Api.On_SLS_UnEvictFromHome(HomeInt = 1, EvictForm = Self)
	ElseIf MenuResult == 2
		Api.On_SLS_UnEvictFromHome(HomeInt = 2, EvictForm = Self)
	ElseIf MenuResult == 3
		Api.On_SLS_UnEvictFromHome(HomeInt = 3, EvictForm = Self)
	ElseIf MenuResult == 4
		Api.On_SLS_UnEvictFromHome(HomeInt = 4, EvictForm = Self)
	EndIf
EndFunction

Function EvictionFormsMenu()
	Int i = ShowCityLocationMenu()
	If i > -1
		String Loc = GetCityStringFromInt(i)
		
		UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
		If StorageUtil.FormListCount(Api.Eviction, "EvictForms" + Loc) > 0
			i = 0
			While i < StorageUtil.FormListCount(Api.Eviction, "EvictForms" + Loc)
				ListMenu.AddEntryItem(StorageUtil.FormListGet(Api.Eviction, "EvictForms" + Loc, i))
				i += 1
			EndWhile
		Else
			ListMenu.AddEntryItem(None)
		EndIf
		ListMenu.OpenMenu()
	Else
		EvictRootMenu()
	EndIf
EndFunction

Function EvictionReasonsMenu()
	Int i = ShowCityLocationMenu()
	If i > -1
		String Loc = GetCityStringFromInt(i)
		
		UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
		If StorageUtil.StringListCount(Api.Eviction, "EvictReasons" + Loc) > 0
			i = 0
			While i < StorageUtil.StringListCount(Api.Eviction, "EvictReasons" + Loc)
				ListMenu.AddEntryItem(StorageUtil.StringListGet(Api.Eviction, "EvictReasons" + Loc, i))
				i += 1
			EndWhile
		Else
			ListMenu.AddEntryItem("-- List is EMPTY --")
		EndIf
		ListMenu.OpenMenu()
		;Debug.Messagebox(ListMenu.GetResultInt())
		;Return ListMenu.GetResultInt()
	Else
		EvictRootMenu()
	EndIf
EndFunction

String Function GetCityStringFromInt(Int Loc)
	If Loc == 0
		Return "Whiterun"
	ElseIf Loc == 1
		Return "Solitude"
	ElseIf Loc == 2
		Return "Markarth"
	ElseIf Loc == 3
		Return "Windhelm"
	ElseIf Loc == 4
		Return "Riften"
	EndIf
	Return ""
EndFunction

Function LookAtDebug(Bool IsShortcut = false)
	Int MenuResult = ShowLookAtDebugMenu()
	If MenuResult == -1
		 DebugMenu()
	ElseIf MenuResult == 0
		SetIsNpcVar()
	ElseIf MenuResult == 1
		PlayerRef.ClearLookAt()
	EndIf
EndFunction

Int Function ShowLookAtDebugMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "IsNpc: " + PlayerRef.GetAnimationVariableInt("IsNPC"))
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Clear Look At")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "IsNpc: " + PlayerRef.GetAnimationVariableInt("IsNPC"))
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Clear Look At")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction

Function SetIsNpcVar(Bool IsShortcut = false)
	Int MenuResult = ShowSetIsNpcVarMenu()
	If MenuResult == -1
		LookAtDebug()
	ElseIf MenuResult == 0
		PlayerRef.SetAnimationVariableInt("IsNPC", 0)
	ElseIf MenuResult == 1
		PlayerRef.SetAnimationVariableInt("IsNPC", 1)
	EndIf
EndFunction

Int Function ShowSetIsNpcVarMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Set IsNpc To 0")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Set IsNpc To 1")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Set IsNpc To 0")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Set IsNpc To 1")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction

; Debug Menu ===================================================================================================================

Function TeleportMenu(Bool IsShortcut = false)
	Int MenuResult = ShowTeleportMenu()
	If MenuResult == -1
		ShowDebugMenu()
	ElseIf MenuResult == 0
		TeleportToQuartermasterMenu()
	ElseIf MenuResult == 1
		TeleportToKennelMenu()
	EndIf
EndFunction

Int Function ShowTeleportMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Quartermaster ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Kennel ")

	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Quartermaster ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Kennel ")
	
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction

Function TeleportToKennelMenu(Bool IsShortcut = false)
	Int MenuSelect = ShowCityLocationMenu() ; Same menu
	If MenuSelect == -1 && !IsShortcut
		TeleportMenu()
	ElseIf MenuSelect >= 0 && MenuSelect <= 4
		((Util._SLS_KennelOutsideDoors.GetAt(MenuSelect) as ObjectReference) as SLS_KennelOutsideDoorScript).OnActivate(PlayerRef)
		PlayerRef.MoveTo(Game.GetFormFromFile(0x038F3C, "SL Survival.esp") as ObjectReference)
	EndIf
EndFunction

Function TeleportToQuartermasterMenu(Bool IsShortcut = false)
	Int MenuSelect = ShowCityLocationMenu()
	If MenuSelect == -1 && !IsShortcut
		TeleportMenu()
	ElseIf MenuSelect == 0
		PlayerRef.MoveTo(Game.GetFormFromFile(0x046213, "SL Survival.esp") as ObjectReference)
	ElseIf MenuSelect == 1
		PlayerRef.MoveTo(Game.GetFormFromFile(0x046772, "SL Survival.esp") as ObjectReference)
	ElseIf MenuSelect == 2
		PlayerRef.MoveTo(Game.GetFormFromFile(0x046774, "SL Survival.esp") as ObjectReference)
	ElseIf MenuSelect == 3
		PlayerRef.MoveTo(Game.GetFormFromFile(0x046773, "SL Survival.esp") as ObjectReference)
	ElseIf MenuSelect == 4
		PlayerRef.MoveTo(Game.GetFormFromFile(0x046775, "SL Survival.esp") as ObjectReference)
	EndIf
EndFunction

Int Function ShowCityLocationMenu()
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 0, value = "Whiterun ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 1, value = "Solitude ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 2, value = "Markarth ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 3, value = "Windhelm ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionText", index = 4, value = "Riften ")

	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 0, value = "Whiterun ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 1, value = "Solitude ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 2, value = "Markarth ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 3, value = "Windhelm ")
	wheelMenu.SetPropertyIndexString(propertyName = "optionLabelText", index = 4, value = "Riften ")

	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexBool(propertyName = "optionEnabled", index = 4, value = true)
	
	Return wheelMenu.OpenMenu()
EndFunction

; Last Action States ====================================================================================================================

Function LastAction()
EndFunction

String Function GetLastActionString()
	Return ""
EndFunction

Bool Function LastActionAvailable()
	Return true
EndFunction

State OpenCloseMouth
	String Function GetLastActionString()
		If sslBaseExpression.IsMouthOpen(PlayerRef)
			Return "Close Mouth"
		EndIf
		Return "Open Mouth"
	EndFunction
	
	Function LastAction()
		CumSwallow.OnKeyDown(0)
	EndFunction
EndState

State CoverMyself
	String Function GetLastActionString()
		If CoverMyself.GetState() == "Covered"
			Return "Uncover Myself"
		EndIf
		Return "Cover Myself"
	EndFunction
	
	Function LastAction()
		CoverMyself.OnKeyDown(0)
	EndFunction
EndState

;/
State Tongue

EndState
/;

State LookAt
	String Function GetLastActionString()
		If LookAtTarget
			Return "Stop Looking At"
		EndIf
		Return "Look At"
	EndFunction
	
	Function LastAction()
		BeginLookAt()
	EndFunction
EndState

State Crawl
	String Function GetLastActionString()
		If !Init.IsCrawling
			Return "Crawl"
		EndIf
		Return "Stop Crawling"
	EndFunction
	
	Function LastAction()
		ToggleCrawl()
	EndFunction
EndState

State SexyMove
	String Function GetLastActionString()
		Return "Sexy Move"
	EndFunction
	
	Function LastAction()
		ChangeAnimationSetMenu()
	EndFunction
EndState

State Emote
	String Function GetLastActionString()
		Return "Emote"
	EndFunction
	
	Function LastAction()
		EmoteMenu()
	EndFunction
EndState

State Tease
	String Function GetLastActionString()
		If PlayerRef.HasSpell(_SLS_TeaseMyselfSpell)
			Return "Stop Playing"
		EndIf
		Return "Tease "
	EndFunction
	
	Function LastAction()
		If !PlayerRef.HasSpell(_SLS_TeaseMyselfSpell)
			PlayerRef.AddSpell(_SLS_TeaseMyselfSpell, false)
		Else
			PlayerRef.RemoveSpell(_SLS_TeaseMyselfSpell)
			Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
		EndIf
	EndFunction
EndState

State Masturbate
	String Function GetLastActionString()
		Return "Masturbate "
	EndFunction
	
	Function LastAction()
		Masturbate()
	EndFunction
EndState

State Dance
	String Function GetLastActionString()
		Return "Dance "
	EndFunction
	
	Function LastAction()
		DanceRootMenu()
	EndFunction
EndState

State CryForHelp
	String Function GetLastActionString()
		Return "Cry For Help"
	EndFunction
	
	Function LastAction()
		_SLS_ScreamForHelpSpell.Cast(PlayerRef, PlayerRef)
	EndFunction
EndState

State SpankNpc
	String Function GetLastActionString()
		Return "Spank Npc"
	EndFunction
	
	Function LastAction()
		SpankNpc()
	EndFunction
EndState

State Outfits
	String Function GetLastActionString()
		Return "Outfits "
	EndFunction
	
	Function LastAction()
		OutfitMenu()
	EndFunction
EndState

State MilkMyself
	String Function GetLastActionString()
		Return "Milk Myself"
	EndFunction
	
	Function LastAction()
		Mme.MilkPlayer()
	EndFunction
EndState

State DrainCum
	String Function GetLastActionString()
		Return "Drain Cum"
	EndFunction
	
	Function LastAction()
		Fhu.DrainCum()
	EndFunction
EndState

State FrostfallCrafting
	String Function GetLastActionString()
		Return "Frostfall Crafting"
	EndFunction
	
	Function LastAction()
		(Game.GetFormFromFile(0x02306B, "Campfire.esm") as Spell).Cast(PlayerRef, PlayerRef)
	EndFunction
EndState

State HunterbornCrafting
	String Function GetLastActionString()
		Return "Hunterborn Crafting"
	EndFunction
	
	Function LastAction()
		(Game.GetFormFromFile(0x025C0C, "Hunterborn.esp") as Spell).Cast(PlayerRef, PlayerRef)
	EndFunction
EndState

State PrimitiveCooking
	String Function GetLastActionString()
		Return "Primitive Cooking"
	EndFunction
	
	Function LastAction()
		(Game.GetFormFromFile(0x073D95, "Hunterborn.esp") as Spell).Cast(PlayerRef, PlayerRef)
	EndFunction
EndState

State MortarPestle
	String Function GetLastActionString()
		Return "Mortar & Pestle"
	EndFunction
	
	Function LastAction()
		Frostfall.OpenAlchemyCrafting()
	EndFunction
EndState

State BuildCampfire
	String Function GetLastActionString()
		Return "Build Campfire"
	EndFunction
	
	Function LastAction()
		(Game.GetFormFromFile(0x025BD5, "Campfire.esm") as Spell).Cast(PlayerRef, PlayerRef)
	EndFunction
EndState

State PlaceTent
	String Function GetLastActionString()
		Return "Place Tent"
	EndFunction
	
	Function LastAction()
		Frostfall.PlaceTent()
	EndFunction
EndState

State HarvestWood
	String Function GetLastActionString()
		Return "Harvest Wood"
	EndFunction
	
	Function LastAction()
		(Game.GetFormFromFile(0x025647, "Campfire.esm") as Spell).Cast(PlayerRef, PlayerRef)
	EndFunction
EndState

State Instincts
	String Function GetLastActionString()
		Return "Instincts "
	EndFunction
	
	Function LastAction()
		(Game.GetFormFromFile(0x035411, "Campfire.esm") as Spell).Cast(PlayerRef, PlayerRef)
	EndFunction
EndState

State Forage
	String Function GetLastActionString()
		Return "Forage "
	EndFunction
	
	Function LastAction()
		(Game.GetFormFromFile(0x014225, "Hunterborn.esp") as Spell).Cast(PlayerRef, PlayerRef)
	EndFunction
EndState
;/
State SenseDirection
	String Function GetLastActionString()
		Return "Sense Direction"
	EndFunction
	
	Function LastAction()
		(Game.GetFormFromFile(0x044ED1, "Hunterborn.esp") as Spell).Cast(PlayerRef, PlayerRef)
	EndFunction
EndState
/;
State Senses
	String Function GetLastActionString()
		Return "Senses"
	EndFunction
	
	Function LastAction()
		;(Game.GetFormFromFile(0x01BD9E, "Mortal Weapons & Armor.esp") as Spell).Cast(PlayerRef, PlayerRef)
		;Game.ForceFirstPerson()
		;_SLS_HighlightItemsQuest.Start()
		SenseMenu(IsShortcut = true)
	EndFunction
	
	Bool Function LastActionAvailable()
		Return true
	EndFunction
EndState

State SleepOnGround
	String Function GetLastActionString()
		Return "Sleep On Ground"
	EndFunction
	
	Function LastAction()
		SleepOnGround()
	EndFunction
EndState

State Bathe
	String Function GetLastActionString()
		Return "Bathe "
	EndFunction
	
	Function LastAction()
		BatheMenu()
	EndFunction
EndState

State Taunt
	String Function GetLastActionString()
		Return "Taunt "
	EndFunction
	
	Function LastAction()
		Taunt()
	EndFunction
EndState

State Stretch
	String Function GetLastActionString()
		Return "Stretch "
	EndFunction
	
	Function LastAction()
		Stretch()
	EndFunction
EndState

State FlyYouFools
	String Function GetLastActionString()
		If _SLS_FlyYouFoolsQuest.IsRunning()
			Return "Engage "
		EndIf
		Return "Withdraw "
	EndFunction
	
	Function LastAction()
		FlyYouFools()
	EndFunction
EndState

State Tongue
	String Function GetLastActionString()
		Return "Tongue "
	EndFunction
	
	Function LastAction()
		TongueMenu()
	EndFunction
EndState

State BendOver
	String Function GetLastActionString()
		Return "Bend Over"
	EndFunction
	
	Function LastAction()
		BendOverMenu()
	EndFunction
EndState

State TattooNpc
	String Function GetLastActionString()
		Return "Tattoo Npc"
	EndFunction
	
	Function LastAction()
		TattooNpc()
	EndFunction
EndState

State UntieNpc
	String Function GetLastActionString()
		Return "Devices "
	EndFunction
	
	Function LastAction()
		UntieNpc()
	EndFunction
EndState

State SearchGround
	String Function GetLastActionString()
		Return "Search Ground"
	EndFunction
	
	Function LastAction()
		SearchDistanceMenu()
	EndFunction
EndState

State TeleportFollower
	String Function GetLastActionString()
		Return "Teleport Followers"
	EndFunction
	
	Function LastAction()
		TeleportFollowersMenu()
	EndFunction
EndState

State TransferMenu
	String Function GetLastActionString()
		Return "Container Transfer"
	EndFunction
	
	Function LastAction()
		ContainerTransferMenu()
	EndFunction
EndState

State TransferToMenu
	String Function GetLastActionString()
		Return "Transfer To "
	EndFunction
	
	Function LastAction()
		ObjectReference TargetRef = XhairTarget
		If GetIsTransferableTarget(TargetRef)
			TransferToMenu(TargetRef)
		EndIf
	EndFunction
EndState

State Kneel
	String Function GetLastActionString()
		If Init.IsKneeling
			Return "Stop Kneeling"
		EndIf
		Return "Kneel "
	EndFunction
	
	Function LastAction()
		ToggleKneel()
	EndFunction
EndState

State AutoFuck
	String Function GetLastActionString()
		If CompulsiveSex.IsFucking
			Return "Stop Fucking"
		EndIf
		Return "Start Fucking"
	EndFunction
	
	Function LastAction()
		If PlayerRef.IsInFaction(CompulsiveSex.SexlabAnimatingFaction)
			ToggleAutoFuck()
		EndIf
	EndFunction
EndState

State PourCum
	String Function GetLastActionString()
		Return "Pour Cum"
	EndFunction
	
	Function LastAction()
		ShowCumPotionList(PlayerRef)
	EndFunction
EndState

State CollectCum
	String Function GetLastActionString()
		Return "Collect Cum"
	EndFunction
	
	Function LastAction()
		CollectCumMenu()
	EndFunction
EndState

State Ahegao
	String Function GetLastActionString()
		Return "Ahegao "
	EndFunction
	
	Function LastAction()
		AhegaoMenu()
	EndFunction
EndState

State Overlays
	String Function GetLastActionString()
		Return "Overlays "
	EndFunction
	
	Function LastAction()
		OverlaysMenu()
	EndFunction
EndState

State AddItemMenu
	String Function GetLastActionString()
		Return "Add Item Menu"
	EndFunction
	
	Function LastAction()
		AddItemMenu()
	EndFunction
EndState

State IssueLicence
	String Function GetLastActionString()
		Return "Issue Licence"
	EndFunction
	
	Function LastAction()
		IssueLicenceMenu()
	EndFunction
EndState

State Trauma
	String Function GetLastActionString()
		Return "Trauma"
	EndFunction
	
	Function LastAction()
		TraumaMenu()
	EndFunction
EndState

State StolenStuff
	String Function GetLastActionString()
		Return "Stolen Stuff"
	EndFunction
	
	Function LastAction()
		StolenStuffMenu()
	EndFunction
EndState

State Wildling
	String Function GetLastActionString()
		Return "Wildling "
	EndFunction

	Function LastAction()
		WildlingMenu()
	EndFunction
EndState

State Waiting
	String Function GetLastActionString()
		Return "Wait "
	EndFunction

	Function LastAction()
		WaitMenu()
	EndFunction
EndState

; Functions ====================================================================================================================

Function BuildScriptArrays()
	BuildHornyAnimsList()
	BuildTonguesArray()
	BuildOutfitNames()
	BuildOutfits()
	BuildLicGlobalArray()
EndFunction

Function BuildOutfits()
	OutfitForms1 = new Form[32]
	OutfitForms2 = new Form[32]
	OutfitForms3 = new Form[32]
	OutfitForms4 = new Form[32]
	OutfitForms5 = new Form[32]
	OutfitForms6 = new Form[32]
EndFunction

Function BuildOutfitNames()
	OutfitNames = new String[6]
	OutfitNames[0] = "Outfit 1"
	OutfitNames[1] = "Outfit 2"
	OutfitNames[2] = "Outfit 3"
	OutfitNames[3] = "Outfit 4"
	OutfitNames[4] = "Outfit 5"
	OutfitNames[5] = "Outfit 6"
EndFunction

Function BuildHornyAnimsList()
	HornyAnimsList = new String[5]
	HornyAnimsList[0] = "SLS_ZazHornyA"
	HornyAnimsList[1] = "SLS_ZazHornyB"
	HornyAnimsList[2] = "SLS_ZazHornyC"
	HornyAnimsList[3] = "SLS_ZazHornyD"
	HornyAnimsList[4] = "SLS_ZazHornyE"
EndFunction

Function BuildTonguesArray()
	StorageUtil.StringListAdd(Self, "_SLS_TonguesListTemp", "Stick out/Retract ")
	StorageUtil.StringListAdd(Self, "_SLS_TonguesListTemp", "Random ")
	Int i = 0
	While i < _SLS_TonguesList.GetSize()
		StorageUtil.StringListAdd(Self, "_SLS_TonguesListTemp", "Tongue " + (i + 1))
		i += 1
	EndWhile
	TonguesList = StorageUtil.StringListToArray(Self, "_SLS_TonguesListTemp")
	StorageUtil.StringListClear(Self, "_SLS_TonguesListTemp")
EndFunction

Function BuildLicGlobalArray()
	StorageUtil.StringListClear(Self, "HasValidXLicences")
	StorageUtil.StringListAdd(Self, "HasValidXLicences", "_SLS_HasValidMagicLicence")
	StorageUtil.StringListAdd(Self, "HasValidXLicences", "_SLS_HasValidWeaponLicence")
	StorageUtil.StringListAdd(Self, "HasValidXLicences", "_SLS_HasValidArmorLicence")
	StorageUtil.StringListAdd(Self, "HasValidXLicences", "_SLS_HasValidBikiniLicence")
	StorageUtil.StringListAdd(Self, "HasValidXLicences", "_SLS_HasValidClothesLicence")
	StorageUtil.StringListAdd(Self, "HasValidXLicences", "_SLS_HasValidCurfewLicence")
	StorageUtil.StringListAdd(Self, "HasValidXLicences", "_SLS_HasValidWhoreLicence")
	StorageUtil.StringListAdd(Self, "HasValidXLicences", "_SLS_HasValidPropertyLicence")
	StorageUtil.StringListAdd(Self, "HasValidXLicences", "_SLS_HasValidFreedomLicence")
EndFunction

String Function GetRandomHornyAnim()
	Return HornyAnimsList[Utility.RandomInt(0, HornyAnimsList.Length - 1)]
EndFunction

String Function SnipToDecimalPlaces(String StrInput, Int Places)
	Return StringUtil.Substring(StrInput, startIndex = 0, len =  Places + 1 + StringUtil.Find(StrInput, ".", startIndex = 0))
EndFunction

String Function GetFormIdString(Form akForm)
	; Example: Returns '00013744' FROM '[Race <ImperialRace (00013744)>]'
	String S1 = StringUtil.Substring(akForm, StringUtil.Find(akForm, "(", 0) + 1)
	Return StringUtil.Substring(S1, 0, len = StringUtil.Find(S1, ")>]", 0))
EndFunction

String Function GetJigglesString()
	If _SLS_BodyInflationScale.GetValue() < 0.3
		Return "None "
	ElseIf _SLS_BodyInflationScale.GetValue() < 0.6
		Return "Low (+3% prices, -3% speed)"
	ElseIf _SLS_BodyInflationScale.GetValue() < 0.99
		Return "Moderate (+6% prices, -6% speed)"
	Else
		Return "High (+10% prices, -10% speed)"
	EndIf		
EndFunction

Int Function GetFashionValues()
;/
	Debug.Messagebox("Lipstick: " + StorageUtil.GetStringValue(None, "yps_LipstickColor") + \
					"\nSmudged: " + StorageUtil.GetIntValue(None, "yps_LipstickSmudged") + \
					"\n\nEyeShadow: " + StorageUtil.GetStringValue(None, "yps_EyeShadowColor") + \
					"\nSmudged: " + StorageUtil.GetIntValue(None, "yps_EyeShadowSmudged") + \
					"\n\nFinger Nails: " + StorageUtil.GetStringValue(None, "yps_FingerNailPolishColor") + \
					"\nSmudged: " + StorageUtil.GetIntValue(None, "yps_FingerNailPolishSmudged") + \
					"\n\nToe Nails: " + StorageUtil.GetStringValue(None, "yps_ToeNailPolishColor") + \
					"\nSmudged: " + StorageUtil.GetIntValue(None, "yps_FingerNailPolishSmudged") + \
					"\n\nHair length: " + StorageUtil.GetIntValue(None, "YpsCurrentHairLengthStage") + \
					"\nPubic Hair: " + StorageUtil.GetIntValue(None, "yps_PubicHairStage") + \
					"\n\nAddiction: " + StorageUtil.GetIntValue(None, "yps_AddictionLevel") + \
					"\nBuff Level: " + StorageUtil.GetIntValue(None, "yps_AddictionBuff"))
		/;			
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	ListMenu.AddEntryItem(" === Makeup ===")
	ListMenu.AddEntryItem("Lipstick: " + StorageUtil.GetStringValue(None, "yps_LipstickColor"))
	ListMenu.AddEntryItem("Lipstick Smudged: " + StorageUtil.GetIntValue(None, "yps_LipstickSmudged"))
	ListMenu.AddEntryItem("EyeShadow: " + StorageUtil.GetStringValue(None, "yps_EyeShadowColor"))
	ListMenu.AddEntryItem("EyeShadow Smudged: " + StorageUtil.GetIntValue(None, "yps_EyeShadowSmudged"))
	ListMenu.AddEntryItem("Finger Nails: " + StorageUtil.GetStringValue(None, "yps_FingerNailPolishColor"))
	ListMenu.AddEntryItem("Finger Nails Smudged: " + StorageUtil.GetIntValue(None, "yps_FingerNailPolishSmudged"))
	ListMenu.AddEntryItem("Toe Nails: " + StorageUtil.GetStringValue(None, "yps_ToeNailPolishColor"))
	ListMenu.AddEntryItem("Toe Nails Smudged: " + StorageUtil.GetIntValue(None, "yps_FingerNailPolishSmudged"))
	
	ListMenu.AddEntryItem(" === Stockings ===")
	ListMenu.AddEntryItem("Nylons Type: " + StorageUtil.GetIntValue(None, "yps_NylonsType"))
	ListMenu.AddEntryItem("Nylons Pattern: " + StorageUtil.GetIntValue(None, "yps_NylonsPattern"))
	ListMenu.AddEntryItem("Nylons Color: " + StorageUtil.GetIntValue(None, "yps_NylonsColor"))
	
	ListMenu.AddEntryItem(" === Hair ===")
	ListMenu.AddEntryItem("Hair length: " + StorageUtil.GetIntValue(None, "YpsCurrentHairLengthStage"))
	ListMenu.AddEntryItem("Pubic Hair: " + StorageUtil.GetIntValue(None, "yps_PubicHairStage"))
	ListMenu.AddEntryItem("Addiction: " + StorageUtil.GetIntValue(None, "yps_AddictionLevel"))
	ListMenu.AddEntryItem("Buff Level: " + StorageUtil.GetIntValue(None, "yps_AddictionBuff"))
	
	ListMenu.AddEntryItem(" === Piercings ===")
	ListMenu.AddEntryItem("Unused: " + StorageUtil.IntListGet(None, "yps_PiercingsStatus" , 0))
	ListMenu.AddEntryItem("Earlobes: " + StorageUtil.IntListGet(None, "yps_PiercingsStatus" , 1))
	ListMenu.AddEntryItem("Left nostril: " + StorageUtil.IntListGet(None, "yps_PiercingsStatus" , 2))
	ListMenu.AddEntryItem("Septum: " + StorageUtil.IntListGet(None, "yps_PiercingsStatus" , 3))
	ListMenu.AddEntryItem("Snake bites: " + StorageUtil.IntListGet(None, "yps_PiercingsStatus" , 4))
	ListMenu.AddEntryItem("Right labret: " + StorageUtil.IntListGet(None, "yps_PiercingsStatus" , 5))
	ListMenu.AddEntryItem("Labret: " + StorageUtil.IntListGet(None, "yps_PiercingsStatus" , 6))
	ListMenu.AddEntryItem("Right eyebrow: " + StorageUtil.IntListGet(None, "yps_PiercingsStatus" , 7))
	ListMenu.AddEntryItem("Nose bridge: " + StorageUtil.IntListGet(None, "yps_PiercingsStatus" , 8))
	ListMenu.AddEntryItem("Navel: " + StorageUtil.IntListGet(None, "yps_PiercingsStatus" , 9))
	ListMenu.AddEntryItem("Nipples: " + StorageUtil.IntListGet(None, "yps_PiercingsStatus" , 10))
	ListMenu.AddEntryItem("Clitoris: " + StorageUtil.IntListGet(None, "yps_PiercingsStatus" , 11))
	ListMenu.AddEntryItem("Labia: " + StorageUtil.IntListGet(None, "yps_PiercingsStatus" , 12))
	ListMenu.AddEntryItem("Not implemented: " + StorageUtil.IntListGet(None, "yps_PiercingsStatus" , 13))
	ListMenu.AddEntryItem("Not implemented: " + StorageUtil.IntListGet(None, "yps_PiercingsStatus" , 14))
	ListMenu.AddEntryItem("Not implemented: " + StorageUtil.IntListGet(None, "yps_PiercingsStatus" , 15))
	ListMenu.OpenMenu()
	;Debug.Messagebox(ListMenu.GetResultInt())
	Return ListMenu.GetResultInt()
EndFunction

; Transfer Functions ===============================================================================

Function TransferDeviousDevices(ObjectReference DestRef)
	Form akForm
	Int i = TransferFromContainer.GetNumItems()
	While i > 0
		i -= 1
		akForm = TransferFromContainer.GetNthForm(i)
		If akForm as Armor && Devious.IsDeviousInvDevice(akForm)
			TransferFromContainer.RemoveItem(akItemToRemove = akForm, aiCount = TransferFromContainer.GetItemCount(akForm), abSilent = true, akOtherContainer = DestRef)
		EndIf
	EndWhile
EndFunction

Function TransferAllArmors(ObjectReference DestRef)
	Form akForm
	Int i = TransferFromContainer.GetNumItems()
	While i > 0
		i -= 1
		akForm = TransferFromContainer.GetNthForm(i)
		If akForm as Armor
			TransferFromContainer.RemoveItem(akItemToRemove = akForm, aiCount = TransferFromContainer.GetItemCount(akForm), abSilent = true, akOtherContainer = DestRef)
		EndIf
	EndWhile
EndFunction

Function TransferBikiniArmors(ObjectReference DestRef)
	Form akForm
	Int i = TransferFromContainer.GetNumItems()
	While i > 0
		i -= 1
		akForm = TransferFromContainer.GetNthForm(i)
		If akForm as Armor && akForm.HasKeyword(LicUtil._SLS_BikiniArmor)
			TransferFromContainer.RemoveItem(akItemToRemove = akForm, aiCount = TransferFromContainer.GetItemCount(akForm), abSilent = true, akOtherContainer = DestRef)
		EndIf
	EndWhile
EndFunction

Function TransferJewelry(ObjectReference DestRef)
	Keyword VendorItemJewelry = Game.GetFormFromFile(0x8F95A, "Skyrim.esm") as Keyword
	Form akForm
	Int i = TransferFromContainer.GetNumItems()
	While i > 0
		i -= 1
		akForm = TransferFromContainer.GetNthForm(i)
		If akForm as Armor && akForm.HasKeyword(VendorItemJewelry) && !Devious.IsDeviousInvDevice(akForm)
			TransferFromContainer.RemoveItem(akItemToRemove = akForm, aiCount = TransferFromContainer.GetItemCount(akForm), abSilent = true, akOtherContainer = DestRef)
		EndIf
	EndWhile
EndFunction

Function TransferClothes(ObjectReference DestRef)
	Keyword VendorItemJewelry = Game.GetFormFromFile(0x8F95A, "Skyrim.esm") as Keyword
	Form akForm
	Int i = TransferFromContainer.GetNumItems()
	While i > 0
		i -= 1
		akForm = TransferFromContainer.GetNthForm(i)
		If akForm as Armor && (akForm as Armor).GetWeightClass() == 2 && !Devious.IsDeviousInvDevice(akForm) && !akForm.HasKeyword(VendorItemJewelry)
			TransferFromContainer.RemoveItem(akItemToRemove = akForm, aiCount = TransferFromContainer.GetItemCount(akForm), abSilent = true, akOtherContainer = DestRef)
		EndIf
	EndWhile
EndFunction

Function TransferLightArmor(ObjectReference DestRef)
	Form akForm
	Int i = TransferFromContainer.GetNumItems()
	While i > 0
		i -= 1
		akForm = TransferFromContainer.GetNthForm(i)
		If akForm as Armor && (akForm as Armor).GetWeightClass() == 0 && !Devious.IsDeviousInvDevice(akForm)
			TransferFromContainer.RemoveItem(akItemToRemove = akForm, aiCount = TransferFromContainer.GetItemCount(akForm), abSilent = true, akOtherContainer = DestRef)
		EndIf
	EndWhile
EndFunction

Function TransferHeavyArmor(ObjectReference DestRef)
	Form akForm
	Int i = TransferFromContainer.GetNumItems()
	While i > 0
		i -= 1
		akForm = TransferFromContainer.GetNthForm(i)
		If akForm as Armor && (akForm as Armor).GetWeightClass() == 1 && !Devious.IsDeviousInvDevice(akForm)
			TransferFromContainer.RemoveItem(akItemToRemove = akForm, aiCount = TransferFromContainer.GetItemCount(akForm), abSilent = true, akOtherContainer = DestRef)
		EndIf
	EndWhile
EndFunction

Function TransferAllWeapons(ObjectReference DestRef)
	Form akForm
	Int i = TransferFromContainer.GetNumItems()
	While i > 0
		i -= 1
		akForm = TransferFromContainer.GetNthForm(i)
		If akForm as Weapon
			TransferFromContainer.RemoveItem(akItemToRemove = akForm, aiCount = TransferFromContainer.GetItemCount(akForm), abSilent = true, akOtherContainer = DestRef)
		EndIf
	EndWhile
EndFunction

Function TransferAmmo(ObjectReference DestRef)
	Form akForm
	Int i = TransferFromContainer.GetNumItems()
	While i > 0
		i -= 1
		akForm = TransferFromContainer.GetNthForm(i)
		If akForm as Ammo
			TransferFromContainer.RemoveItem(akItemToRemove = akForm, aiCount = TransferFromContainer.GetItemCount(akForm), abSilent = true, akOtherContainer = DestRef)
		EndIf
	EndWhile
EndFunction

Function TransferIngredients(ObjectReference DestRef)
	Form akForm
	Int i = TransferFromContainer.GetNumItems()
	While i > 0
		i -= 1
		akForm = TransferFromContainer.GetNthForm(i)
		If akForm as Ingredient
			TransferFromContainer.RemoveItem(akItemToRemove = akForm, aiCount = TransferFromContainer.GetItemCount(akForm), abSilent = true, akOtherContainer = DestRef)
		EndIf
	EndWhile
EndFunction

Function TransferAllPotions(ObjectReference DestRef)
	Keyword VendorItemPotion = Game.GetFormFromFile(0x8CDEC, "Skyrim.esm") as Keyword
	Keyword VendorItemPoison = Game.GetFormFromFile(0x8CDED, "Skyrim.esm") as Keyword
	Form akForm
	Int i = TransferFromContainer.GetNumItems()
	While i > 0
		i -= 1
		akForm = TransferFromContainer.GetNthForm(i)
		If akForm as Potion && (akForm.HasKeyword(VendorItemPotion) || akForm.HasKeyword(VendorItemPoison))
			TransferFromContainer.RemoveItem(akItemToRemove = akForm, aiCount = TransferFromContainer.GetItemCount(akForm), abSilent = true, akOtherContainer = DestRef)
		EndIf
	EndWhile
EndFunction

Function TransferAllFood(ObjectReference DestRef)
	Keyword VendorItemFood = Game.GetFormFromFile(0x8CDEA, "Skyrim.esm") as Keyword
	Keyword VendorItemFoodRaw = Game.GetFormFromFile(0xA0E56, "Skyrim.esm") as Keyword
	Form akForm
	Int i = TransferFromContainer.GetNumItems()
	While i > 0
		i -= 1
		akForm = TransferFromContainer.GetNthForm(i)
		If akForm as Potion && (akForm.HasKeyword(VendorItemFood) || akForm.HasKeyword(VendorItemFoodRaw))
			TransferFromContainer.RemoveItem(akItemToRemove = akForm, aiCount = TransferFromContainer.GetItemCount(akForm), abSilent = true, akOtherContainer = DestRef)
		EndIf
	EndWhile
EndFunction

Function TransferAllBooks(ObjectReference DestRef)
	Form akForm
	Int i = TransferFromContainer.GetNumItems()
	While i > 0
		i -= 1
		akForm = TransferFromContainer.GetNthForm(i)
		If akForm as Book
			TransferFromContainer.RemoveItem(akItemToRemove = akForm, aiCount = TransferFromContainer.GetItemCount(akForm), abSilent = true, akOtherContainer = DestRef)
		EndIf
	EndWhile
EndFunction

Function TransferAllMiscObjects(ObjectReference DestRef)
	Form akForm
	Int i = TransferFromContainer.GetNumItems()
	While i > 0
		i -= 1
		akForm = TransferFromContainer.GetNthForm(i)
		If akForm as MiscObject
			TransferFromContainer.RemoveItem(akItemToRemove = akForm, aiCount = TransferFromContainer.GetItemCount(akForm), abSilent = true, akOtherContainer = DestRef)
		EndIf
	EndWhile
EndFunction

Function TransferGems(ObjectReference DestRef)
	Keyword VendorItemGem = Game.GetFormFromFile(0x914ED, "Skyrim.esm") as Keyword
	Form akForm
	Int i = TransferFromContainer.GetNumItems()
	While i > 0
		i -= 1
		akForm = TransferFromContainer.GetNthForm(i)
		If akForm as MiscObject && akForm.HasKeyword(VendorItemGem)
			TransferFromContainer.RemoveItem(akItemToRemove = akForm, aiCount = TransferFromContainer.GetItemCount(akForm), abSilent = true, akOtherContainer = DestRef)
		EndIf
	EndWhile
EndFunction

Function TransferCraftingMaterial(ObjectReference DestRef)
	Form akForm
	Keyword VendorItemOreIngot = Game.GetFormFromFile(0x914EC, "Skyrim.esm") as Keyword
	Keyword VendorItemAnimalPart = Game.GetFormFromFile(0x914EB, "Skyrim.esm") as Keyword
	Keyword VendorItemAnimalHide = Game.GetFormFromFile(0x914EA, "Skyrim.esm") as Keyword
	Keyword VendorItemFireword = Game.GetFormFromFile(0xBECD7, "Skyrim.esm") as Keyword
	
	Int i = TransferFromContainer.GetNumItems()
	While i > 0
		i -= 1
		akForm = TransferFromContainer.GetNthForm(i)
		If akForm as MiscObject && (akForm.HasKeyword(VendorItemOreIngot) || akForm.HasKeyword(VendorItemAnimalPart) || akForm.HasKeyword(VendorItemAnimalHide) || akForm.HasKeyword(VendorItemFireword))
			TransferFromContainer.RemoveItem(akItemToRemove = akForm, aiCount = TransferFromContainer.GetItemCount(akForm), abSilent = true, akOtherContainer = DestRef)
		EndIf
	EndWhile
EndFunction

Function TransferClutter(ObjectReference DestRef)
	Form akForm
	Keyword VendorItemClutter = Game.GetFormFromFile(0x914E9, "Skyrim.esm") as Keyword
	Int i = TransferFromContainer.GetNumItems()
	While i > 0
		i -= 1
		akForm = TransferFromContainer.GetNthForm(i)
		If akForm as MiscObject && akForm.HasKeyword(VendorItemClutter) && akForm != Gold001
			TransferFromContainer.RemoveItem(akItemToRemove = akForm, aiCount = TransferFromContainer.GetItemCount(akForm), abSilent = true, akOtherContainer = DestRef)
		EndIf
	EndWhile
EndFunction

; Transfer Functions END===============================================================================

Bool IsDressed = true
Bool TransferInProc = false

Int PlayerIsNpcVar
Int LastTongue = 0
Int UntieActorDeviceSelect
Int TongueSlotMask = 0x00004000

String[] HornyAnimsList
String[] TonguesList
String[] OutfitNames
String[] UntieActorDevices

Form[] StrippedItems
Form[] OutfitForms1
Form[] OutfitForms2
Form[] OutfitForms3
Form[] OutfitForms4
Form[] OutfitForms5
Form[] OutfitForms6
Form[] FollowersList

Actor UntieActor
ObjectReference XhairTarget

ObjectReference TransferFromContainer

Bool Property IsBendingOver = false Auto Hidden
;Bool Property IsCrawling = false Auto Hidden
Bool Property IsLookingSubmissively = false Auto Hidden
Bool FightControlsWereEnabled = true

Int Property AioKey = 34 Auto Hidden
Int Property StatusKey Auto Hidden

ObjectReference Property LookAtTarget Auto Hidden
ObjectReference Property _SLS_LookAtMarkerRef Auto

Formlist Property _SLS_TonguesList Auto
Formlist Property _SLS_BisSoapList Auto
Formlist Property _SLS_CumPotionAll Auto

Actor Property PlayerRef Auto

Keyword Property SexLabNoStrip Auto

Faction Property CWImperialFaction Auto
Faction Property CWSonsFaction Auto
Faction Property CWDialogueSoldierFaction Auto
Faction Property _SLS_NoHelloCommentsFact Auto

Perk Property _SLS_CrawlingPerk Auto

Spell Property _SLS_TeaseMyselfSpell Auto
Spell Property _SLS_ScreamForHelpSpell Auto

GlobalVariable Property _SLS_LicBikiniCurseIsWearingArmor Auto
GlobalVariable Property _SLS_BodyCoverStatus Auto
GlobalVariable Property _SLS_SearchGroundDistance Auto
GlobalVariable Property _SLS_BodyInflationScale Auto

Keyword Property _SLS_TongueKeyword Auto
Keyword Property LocTypeInn Auto

Quest Property _SLS_CoverMySelfQuest Auto
Quest Property _SLS_LookAtSearchQuest Auto
Quest Property _SLS_CombatTauntQuest Auto
Quest Property _SLS_BikiniExpTrainingQuest Auto
Quest Property _SLS_FlyYouFoolsQuest Auto
Quest Property _SLS_SpankRandomPeriodicQuest Auto
Quest Property _SLS_SearchGroundHostilesQuest Auto
Quest Property _SLS_SearchGroundQuest Auto
Quest Property _SLS_SubmitAliases Auto
Quest Property _SLS_HighlightItemsQuest Auto
Quest Property _SLS_SenseArousalQuest Auto
Quest Property _SLS_SenseCumFullnessQuest Auto

MiscObject Property _SLS_NeverAddedItem Auto
MiscObject Property Charcoal Auto
MiscObject Property Gold001 Auto

Message Property _SLS_SleepHereMsg Auto

Furniture Property Bedroll01 Auto

ImageSpaceModifier Property FadeToBlack Auto

Topic Property _SLS_AllInOneKeyGetAttention Auto
Topic Property _SLS_AioTauntTopic Auto
Topic Property _SLS_AioRetreat Auto

Sound Property _SLS_GetAttentionSM Auto
Sound Property _SLS_TauntSM Auto
Sound Property _SLS_RetreatSM Auto

Armor Property _SLS_DummyObject Auto

Idle Property pa_HugA Auto
;Idle Property pa_PairedButtSlap Auto

_SLS_InterfaceAproposTwo Property Apro2 Auto
_SLS_InterfaceRapeTats Property RapeTats Auto
_SLS_InterfaceDevious Property Devious Auto
_SLS_InterfaceMilkAddict Property MilkAddict Auto
_SLS_InterfaceMme Property Mme Auto
_SLS_InterfaceFrostfall Property Frostfall Auto
_SLS_InterfaceBis Property Bis Auto
_SLS_InterfaceSexyMove Property SexyMove Auto
_SLS_InterfaceSpankThatAss Property Sta Auto
_SLS_InterfaceFhu Property Fhu Auto
_SLS_InterfaceSgo Property Sgo Auto

_SLS_AnimalFriend Property Friend Auto
_SLS_Dance Property Dance Auto
_SLS_CompulsiveSex Property CompulsiveSex Auto
_SLS_OrgasmFatigue Property Orgasmfatigue Auto
_SLS_LicenceUtil Property LicUtil Auto
_SLS_BikiniExpTraining Property BikiniExp Auto
_SLS_CumAddict Property CumAddict Auto
_SLS_CumSwallow Property CumSwallow Auto
_SLS_CoverMyself Property CoverMyself Auto
_SLS_Needs Property Needs Auto
_SLS_Api Property Api Auto
SLS_Utility Property Util Auto
SLS_Main Property Main Auto
SLS_Mcm Property Menu Auto
SLS_Init Property Init Auto
_SLS_AllInOneFavorite Property Fav Auto

SexlabFramework Property Sexlab Auto
