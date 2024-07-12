Scriptname EFFMenuScript extends Quest  Conditional

EFFCore Property XFLMain Auto

FormList Property XFL_FollowerPlugins Auto

GlobalVariable Property XFL_FollowerCountEx Auto

ObjectReference Property FollowerMenuContainer Auto
ObjectReference Property FollowerMenuOption_None Auto
MiscObject Property FollowerMenuObject Auto

ReferenceAlias[] Property XFL_FollowerMenuAliases Auto

Perk Property CommandFollower Auto
Actor Property XFL_Player Auto
Actor Property XFL_PreviousActor Auto
Spell Property XFL_SlowTime Auto

ReferenceAlias Property XFL_Placeholder Auto

Message Property XFL_MessageCommands Auto
Message Property XFL_MessageCommand Auto
Message Property XFL_MessageGroupCommands Auto
Message Property XFL_MessageFeatures Auto
Message Property XFL_MessageToggleFeatures Auto
Message Property XFL_MessageTogglePlugins Auto
Message Property XFL_MessagePlugins Auto
Message Property XFL_MessageSelectFollower Auto

Message Property XFL_MessageFeatureUseMenus Auto
Message Property XFL_MessageFeatureIgnoreTimeout Auto
Message Property XFL_MessageFeatureRideHorses Auto
Message Property XFL_MessageFeatureShowStats Auto

Message Property XFL_MessageStats_General Auto
Message Property XFL_MessageStats_Resistances Auto
Message Property XFL_MessageStats_Combat Auto
Message Property XFL_MessageStats_Skill Auto
Message Property XFL_MessageStats_Magic Auto

GlobalVariable Property XFL_Config_UseClassicMenus Auto
GlobalVariable Property XFL_Config_UseMenus Auto
GlobalVariable Property XFL_Config_IgnoreTimeout Auto
GlobalVariable Property XFL_Config_RideHorses Auto
GlobalVariable Property XFL_Config_ShowStats Auto

; Toggle Features
Bool Property XFL_MessageMod_Features_Enable Auto Conditional
Bool Property XFL_MessageMod_Features_Disable Auto Conditional
Bool Property XFL_MessageMod_Features_Help Auto Conditional

; Variables to enable/disable certain menu options
Bool Property XFL_MessageMod_Command Auto Conditional
Bool Property XFL_MessageMod_Wait Auto Conditional
Bool Property XFL_MessageMod_Follow Auto Conditional
Bool Property XFL_MessageMod_Dismiss Auto Conditional
Bool Property XFL_MessageMod_Back Auto Conditional
Bool Property XFL_MessageMod_Talk Auto Conditional
Bool Property XFL_MessageMod_Trade Auto Conditional
Bool Property XFL_MessageMod_Stats Auto Conditional
Bool Property XFL_MessageMod_Relax Auto Conditional
Bool Property XFL_MessageMod_More Auto Conditional
; Stats menu
Bool Property XFL_MessageMod_Stats_General Auto Conditional
Bool Property XFL_MessageMod_Stats_Resistances Auto Conditional
Bool Property XFL_MessageMod_Stats_Combat Auto Conditional
Bool Property XFL_MessageMod_Stats_Skill Auto Conditional
Bool Property XFL_MessageMod_Stats_Magic Auto Conditional

Bool Property XFL_MessageMod_Plugin_0 Auto Conditional
Bool Property XFL_MessageMod_Plugin_1 Auto Conditional
Bool Property XFL_MessageMod_Plugin_2 Auto Conditional
Bool Property XFL_MessageMod_Plugin_3 Auto Conditional
Bool Property XFL_MessageMod_Plugin_4 Auto Conditional
Bool Property XFL_MessageMod_Plugin_5 Auto Conditional
Bool Property XFL_MessageMod_Plugin_6 Auto Conditional
Bool Property XFL_MessageMod_Next Auto Conditional

string Property STRING_COMMAND_GROUP = "$Group" AutoReadOnly
string Property STRING_COMMAND_COMMAND = "$Command" AutoReadOnly
string Property STRING_COMMAND_TALK = "$Talk" AutoReadOnly
string Property STRING_COMMAND_EXIT = "$Exit" AutoReadOnly
string Property STRING_COMMAND_WAIT = "$Wait" AutoReadOnly
string Property STRING_COMMAND_FOLLOW = "$EFF_Follow" AutoReadOnly
string Property STRING_COMMAND_DISMISS = "$Dismiss" AutoReadOnly
string Property STRING_COMMAND_RELAX = "$Relax" AutoReadOnly
string Property STRING_COMMAND_TRADE = "$Trade" AutoReadOnly
string Property STRING_COMMAND_STATS = "$Stats" AutoReadOnly
string Property STRING_COMMAND_NEXT = "$Next" AutoReadOnly
string Property STRING_COMMAND_MORE = "$More" AutoReadOnly
string Property STRING_COMMAND_BACK = "$Back" AutoReadOnly
string Property STRING_COMMAND_EQUIPMENT = "$Equipment" AutoReadOnly
string Property STRING_COMMAND_INVENTORY = "$Inventory" AutoReadOnly
string Property STRING_COMMAND_MAGIC = "$Magic" AutoReadOnly

string branchState = ""

bool selectionLock = false

Event OnInit()
	Game.GetPlayer().AddPerk(CommandFollower)
	FollowerMenuOption_None = XFL_RegisterMenuOption(FollowerMenuObject) ; Dummy plugin to be used as a reference
EndEvent


ObjectReference Function XFL_RegisterMenuOption(MiscObject miscObj)
	ObjectReference temp = FollowerMenuContainer.PlaceAtMe(miscObj, 1, true)
	FollowerMenuContainer.AddItem(temp)
	return temp
EndFunction

Function XFL_ShowOptionByAlias(ReferenceAlias refAlias, bool enabled)
	If refAlias == XFL_FollowerMenuAliases[0]
		XFL_MessageMod_Plugin_0 = enabled
	Elseif refAlias == XFL_FollowerMenuAliases[1]
		XFL_MessageMod_Plugin_1 = enabled
	Elseif refAlias == XFL_FollowerMenuAliases[2]
		XFL_MessageMod_Plugin_2 = enabled
	Elseif refAlias == XFL_FollowerMenuAliases[3]
		XFL_MessageMod_Plugin_3 = enabled
	Elseif refAlias == XFL_FollowerMenuAliases[4]
		XFL_MessageMod_Plugin_4 = enabled
	Elseif refAlias == XFL_FollowerMenuAliases[5]
		XFL_MessageMod_Plugin_5 = enabled
	Elseif refAlias == XFL_FollowerMenuAliases[6]
		XFL_MessageMod_Plugin_6 = enabled
	EndIf
EndFunction

int Function XFL_Features()
	Int Features_UseMenus = 0
	Int Features_IgnoreTimeout = 1
	Int Features_RideHorses = 2
	Int Features_ShowStats = 3
	Int Features_Plugins = 4
	Int Features_Exit = 5
	
	int ret = XFL_MessageFeatures.Show(XFL_Config_UseMenus.value, XFL_Config_IgnoreTimeout.value, XFL_Config_RideHorses.value, XFL_Config_ShowStats.value)
	If ret == Features_UseMenus
		XFL_ToggleFeature(XFL_Config_UseMenus, XFL_MessageFeatureUseMenus)
	Elseif ret == Features_IgnoreTimeout
		XFL_ToggleFeature(XFL_Config_IgnoreTimeout, XFL_MessageFeatureIgnoreTimeout)
	Elseif ret == Features_RideHorses
		XFL_ToggleFeature(XFL_Config_RideHorses, XFL_MessageFeatureRideHorses)
	Elseif ret == Features_ShowStats
		XFL_ToggleFeature(XFL_Config_ShowStats, XFL_MessageFeatureShowStats)
	Elseif ret == Features_Plugins
		XFL_TogglePlugins()
	Elseif ret == Features_Exit
		; Do nothing
	EndIf
	return ret
EndFunction

int Function XFL_ToggleFeature(GlobalVariable globalVar, Message help = None)
	Int Toggle_Features_Enable = 0
	Int Toggle_Features_Disable = 1
	Int Toggle_Features_Help = 2
	Int Toggle_Features_Back = 3
	
	If globalVar.GetValueInt() == 0
		XFL_MessageMod_Features_Enable = 1
		XFL_MessageMod_Features_Disable = 0
	Elseif globalVar.GetValueInt() == 1
		XFL_MessageMod_Features_Enable = 0
		XFL_MessageMod_Features_Disable = 1
	Else ; Not a boolean value, enable both to set to 1 or 0
		XFL_MessageMod_Features_Enable = 1
		XFL_MessageMod_Features_Disable = 1
	EndIf
	
	If help == None
		XFL_MessageMod_Features_Help = 0
	Else
		XFL_MessageMod_Features_Help = 1
	EndIf

	int ret = XFL_MessageToggleFeatures.Show()
	If ret == Toggle_Features_Enable
		globalVar.SetValue(1)
		XFL_ToggleFeature(globalVar, help)
	Elseif ret == Toggle_Features_Disable
		globalVar.SetValue(0)
		XFL_ToggleFeature(globalVar, help)
	Elseif ret == Toggle_Features_Back
		XFL_Features()
	Elseif ret == Toggle_Features_Help
		help.Show()
		XFL_ToggleFeature(globalVar, help)
	EndIf
	return ret
EndFunction


Function XFL_TogglePlugins(int page = 0)
	Int Command_Plugin_Back = 7
	Int Command_Plugin_Next = 8
	Int Command_Plugin_Exit = 9
	
	XFL_MessageMod_Back = 1
	
	Int[] pluginStatus = new Int[7] ; Store which Plugin Status corresponds to which Menu index
	Int[] pluginIndex = new Int[7] ; Store which Plugin Index corresponds to which Menu index
			
	int ret = 0
	While ret != Command_Plugin_Exit

		int totalPlugins = XFL_FollowerPlugins.GetSize()
		int i = 0
		While i < totalPlugins ; Subtract disabled or hidden plugins
			EFFPlugin plugin = (XFL_FollowerPlugins.GetAt((page * 7) + i) As EFFPlugin)
			If !plugin
				totalPlugins -= 1
			Endif
			i += 1
		EndWhile
	
		; If there are more mods then what are displayed
		If totalPlugins > (page + 1) * 7
			XFL_MessageMod_Next = 1
		Else
			XFL_MessageMod_Next = 0
		EndIf

		; Setup plugin menu options
		i = 0
		int itemIndex = page
		While i < XFL_FollowerMenuAliases.Length
			bool incrementAlias = true
			If XFL_FollowerPlugins.GetSize() > (page * 7) + itemIndex ; Check if there are still more mods to process
				EFFPlugin plugin = (XFL_FollowerPlugins.GetAt((page * 7) + itemIndex) As EFFPlugin)
				If plugin
					XFL_FollowerMenuAliases[i].ForceRefTo(plugin.MenuRef) ; Force the Menu Object into the menu alias for text replacement
					XFL_ShowOptionByAlias(XFL_FollowerMenuAliases[i], true)
					pluginStatus[i] = plugin.isEnabled() as Int
					pluginIndex[i] = (page * 7) + itemIndex
				Else
					incrementAlias = false ; Skip the item and stay on this alias
				EndIf
			Else
				XFL_FollowerMenuAliases[i].ForceRefTo(FollowerMenuOption_None) ; Reaching end of list, rest of the aliases are empty
				XFL_ShowOptionByAlias(XFL_FollowerMenuAliases[i], false)
				pluginStatus[i] = 0
				pluginIndex[i] = -1
			EndIf
			If incrementAlias
				i += 1
			EndIf
			itemIndex += 1
		EndWhile
			
		ret = XFL_MessageTogglePlugins.Show(pluginStatus[0], pluginStatus[1], pluginStatus[2], pluginStatus[3], pluginStatus[4], pluginStatus[5], pluginStatus[6], page + 1)
		
		If ret < Command_Plugin_Back ; Activate the correct menu
			EFFPlugin plugin = (XFL_FollowerPlugins.GetAt(pluginIndex[ret]) as EFFPlugin)
			If plugin
				If plugin.enabledVar.value
					plugin.enabledVar.value = 0
					plugin.onDisabled()
				Else
					plugin.enabledVar.value = 1
					plugin.onEnabled()
				Endif
			EndIf
			;ret = Command_Plugin_Exit ; Discontinue menu loop
		Elseif ret == Command_Plugin_Back
			If page == 0
				XFL_Features()
				ret = Command_Plugin_Exit ; Discontinue menu loop
			Else
				page -= 1
			EndIf
		Elseif ret == Command_Plugin_Next
			XFL_MessageMod_Back = 1 ; We have previous pages
			page += 1
		Elseif ret == Command_Plugin_Exit
			; Do nothing this is shown during a book
		EndIf
	EndWhile
	
	XFL_MessageMod_Plugin_0 = 0
	XFL_MessageMod_Plugin_1 = 0
	XFL_MessageMod_Plugin_2 = 0
	XFL_MessageMod_Plugin_3 = 0
	XFL_MessageMod_Plugin_4 = 0
	XFL_MessageMod_Plugin_5 = 0
	XFL_MessageMod_Plugin_6 = 0
	XFL_MessageMod_Next = 0
	XFL_MessageMod_Back = 0
EndFunction


Actor Function XFL_SelectFollower(int page = 0, bool showPlayer = false)
	Int Command_Plugin_Back = 7
	Int Command_Plugin_Next = 8
	Int Command_Plugin_Exit = 9
	
	If page > 0
		XFL_MessageMod_Back = 1
	Else
		XFL_MessageMod_Back = 0
	EndIf
	
	Actor foundFollower = None
				
	int ret = 0
	While ret != Command_Plugin_Exit
		Int totalFollowers = XFLMain.XFL_GetMaximum() + 1 ; Maximum is an index not a count, adjust
		If showPlayer
			totalFollowers += 1
		Endif
	
		; If there are more followers then what are displayed
		If totalFollowers > (page + 1) * 7
			XFL_MessageMod_Next = 1
		Else
			XFL_MessageMod_Next = 0
		EndIf
		
		; Setup plugin menu options
		int i = 0
		
		; Add the player to the first of the list
		If showPlayer && page == 0
			XFL_FollowerMenuAliases[i].ForceRefTo(Game.GetPlayer()) ; Force the Menu Object into the menu alias for text replacement
			XFL_ShowOptionByAlias(XFL_FollowerMenuAliases[i], true)
			i += 1
		Endif
		
		int itemIndex = 0
		While i < XFL_FollowerMenuAliases.Length
			bool incRow = true
			If totalFollowers >= (page * 7) + itemIndex ; Check if there are still more followers to process
				Actor follower = XFLMain.XFL_FollowerAliases[((page * 7) + itemIndex)].GetReference() as Actor
				If follower
					XFL_FollowerMenuAliases[i].ForceRefTo(follower) ; Force the follower into the menu alias for text replacement
					XFL_ShowOptionByAlias(XFL_FollowerMenuAliases[i], true)
				Else ; Empty alias, next
					incRow = false
				Endif
			Else
				XFL_FollowerMenuAliases[i].ForceRefTo(FollowerMenuOption_None) ; Reaching end of list, rest of the aliases are empty
				XFL_ShowOptionByAlias(XFL_FollowerMenuAliases[i], false)
			EndIf
			If incRow
				i += 1
			EndIf
			itemIndex += 1
		EndWhile
			
		ret = XFL_MessageSelectFollower.Show(page + 1)
		If ret < Command_Plugin_Back ; Activate the correct menu
			Actor follower = XFL_FollowerMenuAliases[ret].GetActorRef()
			If follower
				foundFollower = follower
			EndIf
			ret = Command_Plugin_Exit ; Discontinue menu loop
		Elseif ret == Command_Plugin_Back
			page -= 1
			If page == 0 ; We're returning to the first page of the menu, but we had no previous menu
				XFL_MessageMod_Back = 0
			EndIf
		Elseif ret == Command_Plugin_Next
			XFL_MessageMod_Back = 1 ; We have previous pages
			page += 1
		Elseif ret == Command_Plugin_Exit
			; Do nothing, end after this returns
		EndIf
	EndWhile
	
	XFL_MessageMod_Plugin_0 = 0
	XFL_MessageMod_Plugin_1 = 0
	XFL_MessageMod_Plugin_2 = 0
	XFL_MessageMod_Plugin_3 = 0
	XFL_MessageMod_Plugin_4 = 0
	XFL_MessageMod_Plugin_5 = 0
	XFL_MessageMod_Plugin_6 = 0
	XFL_MessageMod_Next = 0
	XFL_MessageMod_Back = 0
	return foundFollower
EndFunction

; Trigger standalone menus
Function XFL_FollowerMenu(Form akForm)
	OnStartMenu()
	XFL_TriggerMenu(akForm, GetMenuState("FollowerMenu"))
EndFunction

Function XFL_CommandFollower(Form akForm)
	OnStartMenu()
	XFL_TriggerMenu(akForm, GetMenuState("CommandMenu"))
EndFunction

Function XFL_CommandGroup(Form akForm = None)
	OnStartMenu()
	XFL_TriggerMenu(akForm, GetMenuState("GroupMenu"))
EndFunction

Function XFL_Stats(Form akForm)
	XFL_TriggerMenu(akForm, GetMenuState("StatsMenu"))
EndFunction

Function XFL_Plugins(Form akForm)
	XFL_TriggerMenu(akForm, GetMenuState("PluginMenu"))
EndFunction

Function XFL_TriggerMenu(Form akForm, string menuState = "", string previousState = "", int page = 0)
	GoToState(menuState)
	activateMenu(akForm, previousState, page)
EndFunction

Function activateMenu(Form akForm = None, string previousState = "", int page = 0)
	; Do nothing while not in the empty state
EndFunction

Function deactivateMenu()
	; Do nothing
EndFunction

string Function GetMenuState(string menuName)
	string menuSuffix = "_Classic"
	If XFL_Config_UseClassicMenus.value == 1
		menuSuffix = "_Classic"
	Else
		menuSuffix = "_Standard"
	Endif

	return menuName + menuSuffix
endFunction

string Function GetParentState(string menuState = "")
	If menuState == GetMenuState("PluginMenu")
		return branchState
	Elseif menuState == GetMenuState("TradeMenu")
		return GetMenuState("CommandMenu")
	Elseif menuState == GetMenuState("StatsMenu")
		return GetMenuState("CommandMenu")
	Elseif menuState == GetMenuState("FollowerMenu")
		return ""
	Elseif menuState == GetMenuState("GroupMenu")
		return GetMenuState("FollowerMenu")
	Elseif menuState == GetMenuState("CommandMenu")
		return GetMenuState("FollowerMenu")
	Else
		return ""
	Endif
EndFunction

State FollowerMenu_Classic
	Function activateMenu(Form akForm = None, string previousState = "", int page = 0)
		Int Command_Group = 0
		Int Command_Command = 1
		Int Command_Talk = 2
		Int Command_Exit = 3

		Actor followerActor = akForm as Actor
		
		If followerActor
			XFL_Placeholder.ForceRefTo(followerActor)
		Else
			XFL_Placeholder.Clear()
		EndIf

		If followerActor
			XFL_MessageMod_Command = 1 ; Show Command
			XFL_MessageMod_Talk = 1 ; Show Talk
		Else ; We have no follower reference for some reason, hide all options except for group
			XFL_MessageMod_Command = 0
			XFL_MessageMod_Talk = 0
		EndIf
		
		int ret = XFL_MessageCommands.Show()
		If ret == Command_Group ; Group Menu
			XFL_TriggerMenu(followerActor, GetMenuState("GroupMenu"), GetState())
		Elseif ret == Command_Command ; Command Menu
			XFL_TriggerMenu(followerActor, GetMenuState("CommandMenu"), GetState())
		Elseif ret == Command_Talk ; Talk
			followerActor.Activate(Game.GetPlayer(), true)
			OnFinishMenu()
		Elseif ret == Command_Exit ; Exit
			OnFinishMenu()
		EndIf
		
		deactivateMenu()
	EndFunction
	
	Function deactivateMenu()
		XFL_MessageMod_Command = 0
		XFL_MessageMod_Talk = 0
		
		XFL_Placeholder.Clear()
		
		GoToState("")
	EndFunction
EndState

State FollowerMenu_Standard
	Function activateMenu(Form akForm = None, string previousState = "", int page = 0)
		Int Command_Group = 0
		Int Command_Command = 1
		Int Command_Talk = 3
		Int Command_Equipment = 4
		Int Command_Inventory = 5
		Int Command_Magic = 6
		Int Command_Exit = 7

		Actor followerActor = akForm as Actor
		UIMenuBase wheelMenu = XFL_GetStandardMenu("UIWheelMenu")
		if wheelMenu
			wheelMenu.SetPropertyIndexString("optionText", Command_Group, STRING_COMMAND_GROUP)
			wheelMenu.SetPropertyIndexString("optionText", Command_Command, STRING_COMMAND_COMMAND)
			wheelMenu.SetPropertyIndexString("optionText", Command_Talk, STRING_COMMAND_TALK)
			wheelMenu.SetPropertyIndexString("optionText", Command_Equipment, STRING_COMMAND_EQUIPMENT)
			wheelMenu.SetPropertyIndexString("optionText", Command_Inventory, STRING_COMMAND_INVENTORY)
			wheelMenu.SetPropertyIndexString("optionText", Command_Magic, STRING_COMMAND_MAGIC)
			wheelMenu.SetPropertyIndexString("optionText", Command_Exit, STRING_COMMAND_EXIT)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Group, STRING_COMMAND_GROUP)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Command, STRING_COMMAND_COMMAND)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Talk, STRING_COMMAND_TALK)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Equipment, STRING_COMMAND_EQUIPMENT)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Inventory, STRING_COMMAND_INVENTORY)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Magic, STRING_COMMAND_MAGIC)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Exit, STRING_COMMAND_EXIT)
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Group, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Command, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Talk, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Equipment, !XFLMain.XFL_HasFollowerFlags(followerActor, XFLMain.ACTOR_FLAG_DISABLE_TRADE_EQUIP))
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Inventory, !XFLMain.XFL_HasFollowerFlags(followerActor, XFLMain.ACTOR_FLAG_DISABLE_TRADE_INVENTORY))
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Magic, !XFLMain.XFL_HasFollowerFlags(followerActor, XFLMain.ACTOR_FLAG_DISABLE_TRADE_MAGIC))
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Exit, true)
			int ret = wheelMenu.OpenMenu(akForm)
			If ret == Command_Group
				XFL_PreviousActor = followerActor
				XFL_TriggerMenu(XFLMain.XFL_FollowerList, GetMenuState("CommandMenu"), GetState())
			Elseif ret == Command_Command
				XFL_TriggerMenu(akForm, GetMenuState("CommandMenu"), GetState())
			Elseif ret == Command_Talk
				followerActor.Activate(Game.GetPlayer(), true)
				OnFinishMenu()
			Elseif ret == Command_Equipment
				followerActor.OpenInventory()
				OnFinishMenu()
			Elseif ret == Command_Inventory
				XFLMain.XFL_OpenInventory(followerActor)
				OnFinishMenu()
			Elseif ret == Command_Magic
				UIMenuBase magicMenu = XFL_GetStandardMenu("UIMagicMenu")
				if magicMenu
					magicMenu.SetPropertyForm("receivingActor", Game.GetPlayer())
					magicMenu.OpenMenu(followerActor)
				Endif
				OnFinishMenu()
			Elseif ret == Command_Exit || ret == -1
				OnFinishMenu()
			Endif
		Endif
		deactivateMenu()
	EndFunction
	
	Function deactivateMenu()		
		GoToState("")
	EndFunction
EndState

State CommandMenu_Classic
	Function activateMenu(Form akForm = None, string previousState = "", int page = 0)
		Int Command_Wait = 0
		Int Command_Follow = 1
		Int Command_Dismiss = 2
		Int Command_Relax = 3
		Int Command_Trade = 4
		Int Command_Stats = 5
		Int Command_More = 6
		Int Command_Back = 7
		Int Command_Exit = 8

		Actor followerActor = akForm as Actor
		If followerActor
			XFL_Placeholder.ForceRefTo(followerActor)
		Else
			XFL_Placeholder.Clear()
		Endif
		
		branchState = GetState()

		If followerActor
			float waiting = followerActor.GetAv("WaitingForPlayer")
			If waiting == 0 ; Not waiting for player
				XFL_MessageMod_Follow = 0 ; Hide Follow
				XFL_MessageMod_Wait = 1 ; Show Wait
				XFL_MessageMod_Relax = 1 ; Show Relax
			Elseif waiting == 1 ; Waiting for player
				XFL_MessageMod_Wait = 0 ; Hide Wait
				XFL_MessageMod_Follow = 1 ; Show Follow
				XFL_MessageMod_Relax = 1 ; Show Relax
			Elseif waiting == 2 ; Relaxing
				XFL_MessageMod_Wait = 1 ; Show Wait
				XFL_MessageMod_Follow = 1 ; Show Follow
				XFL_MessageMod_Relax = 0 ; Hide Relax
			Else ; Waiting state neither of these three, show all
				XFL_MessageMod_Wait = 1 ; Show Wait
				XFL_MessageMod_Follow = 1 ; Show Follow
				XFL_MessageMod_Relax = 1 ; Show Relax
			EndIf
			XFL_MessageMod_Dismiss = 1 ; Show dismiss
			XFL_MessageMod_Trade = 1 ; Show Trade
			XFL_MessageMod_Stats = 1 ; Show Stats
			If XFL_FollowerPlugins.GetSize() > 0
				XFL_MessageMod_More = 1 ; We have loaded plugins show the plugin menu
			Else
				XFL_MessageMod_More = 0
			Endif
		Else ; We have no follower reference for some reason, hide all options except for group
			XFL_MessageMod_Trade = 0
			XFL_MessageMod_Wait = 0
			XFL_MessageMod_Follow = 0
			XFL_MessageMod_Dismiss = 0
			XFL_MessageMod_Stats = 0
			XFL_MessageMod_More = 0
		EndIf
		
		If previousState != ""
			XFL_MessageMod_Back = 1
		EndIf

		int ret = XFL_MessageCommand.Show()
		If ret == Command_Wait ; Wait
			XFLMain.XFL_SetWait(followerActor)
			OnFinishMenu()
		Elseif ret == Command_Follow ; Follow
			XFLMain.XFL_SetFollow(followerActor)
			OnFinishMenu()
		Elseif ret == Command_Dismiss ; Dismiss
			XFLMain.XFL_RemoveFollower(followerActor)
			OnFinishMenu()
		Elseif ret == Command_Relax ; Relax
			XFLMain.XFL_SetSandbox(followerActor)
			OnFinishMenu()
		Elseif ret == Command_Trade ; Trade
			If followerActor
				followerActor.OpenInventory()
			Endif
			OnFinishMenu()
		Elseif ret == Command_Stats ; Stats
			XFL_TriggerMenu(followerActor, GetMenuState("StatsMenu"), GetState())
		Elseif ret == Command_More ; More
			XFL_TriggerMenu(followerActor, GetMenuState("PluginMenu"), GetState())
		Elseif ret == Command_Back ; Back
			XFL_TriggerMenu(followerActor, previousState)
		Elseif ret == Command_Exit ; Exit
			OnFinishMenu()
		EndIf
		
		deactivateMenu()
	EndFunction
	
	Function deactivateMenu()
		XFL_MessageMod_Trade = 0
		XFL_MessageMod_Wait = 0
		XFL_MessageMod_Follow = 0
		XFL_MessageMod_Dismiss = 0
		XFL_MessageMod_Stats = 0
		XFL_MessageMod_Back = 0
		XFL_MessageMod_More = 0
		XFL_Placeholder.Clear()
		GoToState("")
	EndFunction
EndState

State CommandMenu_Standard
	Function activateMenu(Form akForm = None, string previousState = "", int page = 0)
		Int Command_WaitFollow = 0
		Int Command_Dismiss = 1
		Int Command_Relax = 2
		Int Command_Trade = 3
		Int Command_Stats = 4
		Int Command_More = 5
		Int Command_Back = 6
		Int Command_Exit = 7
		Int Command_Follow = -1
		Int Command_Wait = -1

		Actor followerActor = akForm as Actor
		FormList actorList = akForm as FormList
		if actorList
			Command_Follow = 0
			Command_Wait = 1
			Command_Dismiss = 2
			Command_Relax = 3
			Command_Stats = 4
			Command_More = 5
			Command_WaitFollow = -1
			Command_Trade = -1
		Endif
		

		XFL_MessageMod_Back = 0
		If previousState != "" && (followerActor || XFL_PreviousActor) ; Back button only available when theres a single actor
			XFL_MessageMod_Back = 1
		Endif

		UIMenuBase wheelMenu = XFL_GetStandardMenu("UIWheelMenu")
		if wheelMenu
			wheelMenu.SetPropertyIndexString("optionText", Command_Wait, STRING_COMMAND_WAIT)
			wheelMenu.SetPropertyIndexString("optionText", Command_Follow, STRING_COMMAND_FOLLOW)
			wheelMenu.SetPropertyIndexString("optionText", Command_Dismiss, STRING_COMMAND_DISMISS)
			wheelMenu.SetPropertyIndexString("optionText", Command_Relax, STRING_COMMAND_RELAX)
			wheelMenu.SetPropertyIndexString("optionText", Command_Trade, STRING_COMMAND_TRADE)
			wheelMenu.SetPropertyIndexString("optionText", Command_Stats, STRING_COMMAND_STATS)
			wheelMenu.SetPropertyIndexString("optionText", Command_More, STRING_COMMAND_MORE)
			wheelMenu.SetPropertyIndexString("optionText", Command_Back, STRING_COMMAND_BACK)
			wheelMenu.SetPropertyIndexString("optionText", Command_Exit, STRING_COMMAND_EXIT)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Wait, STRING_COMMAND_WAIT)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Follow, STRING_COMMAND_FOLLOW)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Dismiss, STRING_COMMAND_DISMISS)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Relax, STRING_COMMAND_RELAX)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Trade, STRING_COMMAND_TRADE)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Stats, STRING_COMMAND_STATS)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_More, STRING_COMMAND_MORE)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Back, STRING_COMMAND_BACK)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Exit, STRING_COMMAND_EXIT)
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Wait, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Follow, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_WaitFollow, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Dismiss, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Relax, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Trade, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Stats, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_More, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Back, false)
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Exit, true)
			wheelMenu.SetPropertyIndexInt("optionTextColor", Command_Back, 0x777777)

			float waiting = -1
			If followerActor
				waiting = followerActor.GetActorValue("WaitingForPlayer")
				If waiting == 0 ; Not waiting for player
					wheelMenu.SetPropertyIndexString("optionText", Command_WaitFollow, STRING_COMMAND_WAIT)
					wheelMenu.SetPropertyIndexString("optionLabelText", Command_WaitFollow, STRING_COMMAND_WAIT)
				Elseif waiting == 1 ; Waiting for player
					wheelMenu.SetPropertyIndexString("optionText", Command_WaitFollow, STRING_COMMAND_FOLLOW)
					wheelMenu.SetPropertyIndexString("optionLabelText", Command_WaitFollow, STRING_COMMAND_FOLLOW)
					wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Relax, false)
				Elseif waiting == 2 ; Relaxing
					wheelMenu.SetPropertyIndexString("optionText", Command_WaitFollow, STRING_COMMAND_FOLLOW)
					wheelMenu.SetPropertyIndexString("optionLabelText", Command_WaitFollow, STRING_COMMAND_FOLLOW)
				Else ; Waiting state neither of these three, show all
					wheelMenu.SetPropertyIndexString("optionText", Command_WaitFollow, STRING_COMMAND_FOLLOW)
					wheelMenu.SetPropertyIndexString("optionLabelText", Command_WaitFollow, STRING_COMMAND_FOLLOW)
				EndIf

				wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Dismiss, !XFLMain.XFL_HasFollowerFlags(followerActor, XFLMain.ACTOR_FLAG_DISABLE_DISMISS))
				wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Relax, !XFLMain.XFL_HasFollowerFlags(followerActor, XFLMain.ACTOR_FLAG_DISABLE_RELAX))
				wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Stats, !XFLMain.XFL_HasFollowerFlags(followerActor, XFLMain.ACTOR_FLAG_DISABLE_STATS))
				wheelMenu.SetPropertyIndexBool("optionEnabled", Command_More, !XFLMain.XFL_HasFollowerFlags(followerActor, XFLMain.ACTOR_FLAG_DISABLE_MORE))
			Endif
			
			If XFL_MessageMod_Back == 1 ; Back button only available when theres a single actor
				wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Back, true)
				wheelMenu.SetPropertyIndexInt("optionTextColor", Command_Back, 0xFFFFFF)
			EndIf

			int ret = wheelMenu.OpenMenu(akForm)
			if followerActor
				If ret == Command_WaitFollow
					If waiting == 0
						XFLMain.XFL_SetWait(followerActor)
					Else
						XFLMain.XFL_SetFollow(followerActor)
					Endif
					OnFinishMenu()
				Elseif ret == Command_Dismiss
					XFLMain.XFL_RemoveFollower(followerActor)
					OnFinishMenu()
				Elseif ret == Command_Relax
					XFLMain.XFL_SetSandbox(followerActor)
					OnFinishMenu()
				Elseif ret == Command_Trade
					;followerActor.OpenInventory()
					;OnFinishMenu()
					XFL_TriggerMenu(akForm, GetMenuState("TradeMenu"), GetState())
				Elseif ret == Command_Stats
					UIMenuBase statsMenu = XFL_GetStandardMenu("UIStatsMenu")
					if statsMenu
						statsMenu.OpenMenu(followerActor)
					Endif
					XFL_TriggerMenu(akForm, GetState(), previousState)
				Elseif ret == Command_More
					XFL_TriggerMenu(akForm, GetMenuState("PluginMenu"), GetState())
				Elseif ret == Command_Back || (ret == -1 && XFL_MessageMod_Back == 1)
					XFL_TriggerMenu(akForm, previousState)
				Elseif ret == Command_Exit || (ret == -1 && XFL_MessageMod_Back == 0)
					OnFinishMenu()
				Endif
			Elseif actorList
				If ret == Command_Wait
					XFLMain.XFL_WaitList(akForm)
					OnFinishMenu()
				Elseif ret == Command_Follow
					XFLMain.XFL_FollowList(akForm)
					OnFinishMenu()
				Elseif ret == Command_Dismiss
					XFLMain.XFL_DismissList(akForm)
					OnFinishMenu()
				Elseif ret == Command_Relax
					XFLMain.XFL_SandboxList(akForm)
					OnFinishMenu()
				Elseif ret == Command_Stats
					UIMenuBase statsMenu = XFL_GetStandardMenu("UIStatsMenu")
					if statsMenu
						statsMenu.OpenMenu(akForm)
					Endif
					XFL_TriggerMenu(akForm, GetState(), previousState)
				Elseif ret == Command_More
					XFL_TriggerMenu(akForm, GetMenuState("PluginMenu"), GetState())
				Elseif ret == Command_Back || (ret == -1 && XFL_MessageMod_Back == 1)
					XFL_TriggerMenu(XFL_PreviousActor, previousState)
				Elseif ret == Command_Exit || (ret == -1 && XFL_MessageMod_Back == 0)
					OnFinishMenu()
				Endif
			Elseif akForm == None
				Debug.Trace("EFF WARNING: activateMenu null reference form detected in standard mode.")
			Endif
		Endif
		deactivateMenu()
	EndFunction
	
	Function deactivateMenu()		
		GoToState("")
	EndFunction
EndState

State TradeMenu_Standard
	Function activateMenu(Form akForm = None, string previousState = "", int page = 0)
		Int Command_Equipment = 1
		Int Command_Inventory = 2
		Int Command_Magic = 3
		Int Command_Back = 6
		Int Command_Exit = 7

		Actor followerActor = akForm as Actor
		FormList actorList = akForm as FormList
		if actorList ; Somehow we got to this menu as a group?
			XFL_TriggerMenu(akForm, GetState(), previousState)
			deactivateMenu()
			return
		Endif
		
		XFL_MessageMod_Back = 0
		If previousState != "" && (followerActor || XFL_PreviousActor) ; Back button only available when theres a single actor
			XFL_MessageMod_Back = 1
		Endif

		UIMenuBase wheelMenu = XFL_GetStandardMenu("UIWheelMenu")
		if wheelMenu
			wheelMenu.SetPropertyInt("lastIndex", Command_Equipment)
			wheelMenu.SetPropertyIndexString("optionText", Command_Equipment, STRING_COMMAND_EQUIPMENT)
			wheelMenu.SetPropertyIndexString("optionText", Command_Inventory, STRING_COMMAND_INVENTORY)
			wheelMenu.SetPropertyIndexString("optionText", Command_Magic, STRING_COMMAND_MAGIC)
			wheelMenu.SetPropertyIndexString("optionText", Command_Back, STRING_COMMAND_BACK)
			wheelMenu.SetPropertyIndexString("optionText", Command_Exit, STRING_COMMAND_EXIT)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Equipment, STRING_COMMAND_EQUIPMENT)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Inventory, STRING_COMMAND_INVENTORY)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Magic, STRING_COMMAND_MAGIC)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Back, STRING_COMMAND_BACK)
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Exit, STRING_COMMAND_EXIT)
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Equipment, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Inventory, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Magic, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Back, false)
			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Exit, true)
			wheelMenu.SetPropertyIndexInt("optionTextColor", Command_Back, 0x777777)
			
			If XFL_MessageMod_Back == 1 ; Back button only available when theres a single actor
				wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Back, true)
				wheelMenu.SetPropertyIndexInt("optionTextColor", Command_Back, 0xFFFFFF)
			EndIf

			If followerActor
				wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Equipment, !XFLMain.XFL_HasFollowerFlags(followerActor, XFLMain.ACTOR_FLAG_DISABLE_TRADE_EQUIP))
				wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Inventory, !XFLMain.XFL_HasFollowerFlags(followerActor, XFLMain.ACTOR_FLAG_DISABLE_TRADE_INVENTORY))
				wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Magic, !XFLMain.XFL_HasFollowerFlags(followerActor, XFLMain.ACTOR_FLAG_DISABLE_TRADE_MAGIC))
			Endif

			int ret = wheelMenu.OpenMenu(akForm)
			if followerActor
				If ret == Command_Equipment
					followerActor.OpenInventory()
					OnFinishMenu()
				Elseif ret == Command_Inventory
					XFLMain.XFL_OpenInventory(followerActor)
					OnFinishMenu()
				Elseif ret == Command_Magic
					UIMenuBase magicMenu = XFL_GetStandardMenu("UIMagicMenu")
					if magicMenu
						magicMenu.SetPropertyForm("receivingActor", Game.GetPlayer())
						magicMenu.OpenMenu(followerActor)
					Endif
					OnFinishMenu()
				Elseif ret == Command_Back || (ret == -1 && XFL_MessageMod_Back == 1)
					XFL_TriggerMenu(akForm, previousState)
				Elseif ret == Command_Exit || (ret == -1 && XFL_MessageMod_Back == 0)
					OnFinishMenu()
				Endif
			Elseif akForm == None
				Debug.Trace("EFF WARNING: activateMenu null reference form detected in standard mode.")
			Endif
		Endif
		deactivateMenu()
	EndFunction
	
	Function deactivateMenu()		
		GoToState("")
	EndFunction
EndState

State GroupMenu_Classic
	Function activateMenu(Form akForm = None, string previousState = "", int page = 0)
		Int Command_Group_Wait = 0
		Int Command_Group_Follow = 1
		Int Command_Group_Dismiss = 2
		Int Command_Group_Relax = 3
		Int Command_Group_More = 4
		Int Command_Group_Back = 5
		Int Command_Group_Exit = 6
		
		XFL_MessageMod_Wait = 1 ; Enable both follow and wait as both may be possible
		XFL_MessageMod_Follow = 1
		XFL_MessageMod_Dismiss = 1
		XFL_MessageMod_Relax = 1

		Actor followerActor = akForm as Actor
		
		branchState = GetState()
		
		If previousState != "" && followerActor
			XFL_MessageMod_Back = 1
		Else
			XFL_MessageMod_Back = 0
		EndIf
		
		If XFL_FollowerPlugins.GetSize() > 0
			XFL_MessageMod_More = 1 ; We have loaded plugins show the plugin menu
		Else
			XFL_MessageMod_More = 0
		Endif
		
		int ret = XFL_MessageGroupCommands.Show(XFL_FollowerCountEx.GetValue())
		If ret == Command_Group_Wait ; Group Wait
			XFLMain.XFL_WaitAll()
			OnFinishMenu()
		Elseif ret == Command_Group_Follow ; Group Follow
			XFLMain.XFL_FollowAll()
			OnFinishMenu()
		Elseif ret == Command_Group_Dismiss ; Group Dismiss
			XFLMain.XFL_RemoveAll()
			OnFinishMenu()
		Elseif ret == Command_Group_Relax ; Group Relax
			XFLMain.XFL_SandboxAll()
			OnFinishMenu()
		Elseif ret == Command_Group_More ; Group Plugins
			XFL_TriggerMenu(followerActor, GetMenuState("PluginMenu"), GetState())
		Elseif ret == Command_Group_Back ; Group Back
			XFL_TriggerMenu(followerActor, previousState, GetParentState(previousState))
		Elseif ret == Command_Group_Exit ; Exit Group Menu
			OnFinishMenu()
		EndIf
		
		deactivateMenu()
	EndFunction
	
	Function deactivateMenu()
		XFL_MessageMod_Wait = 1
		XFL_MessageMod_Follow = 1
		XFL_MessageMod_Dismiss = 1
		XFL_MessageMod_Relax = 1
		XFL_MessageMod_Back = 0
		GoToState("")
	EndFunction
EndState

State StatsMenu_Classic
	Function activateMenu(Form akForm = None, string previousState = "", int page = 0)
		Int Command_Stats_General = 0
		Int Command_Stats_Resistances = 1
		Int Command_Stats_Combat = 2
		Int Command_Stats_Skill = 3
		Int Command_Stats_Magic = 4
		Int Command_Stats_Back = 5
		Int Command_Stats_Exit = 6

		Actor followerActor = akForm as Actor
		If followerActor
			XFL_Placeholder.ForceRefTo(followerActor)
		Else
			XFL_Placeholder.Clear()
		Endif
		
		If previousState != ""
			XFL_MessageMod_Back = 1
		EndIf
		
		int ret = 0
		If followerActor
			While ret != Command_Stats_Exit && ret != Command_Stats_Back
				XFL_MessageMod_Stats_General = 1
				XFL_MessageMod_Stats_Resistances = 1
				XFL_MessageMod_Stats_Combat = 1
				XFL_MessageMod_Stats_Skill = 1
				XFL_MessageMod_Stats_Magic = 1
				If ret == Command_Stats_General
					XFL_MessageMod_Stats_General = 0
					ret = XFL_MessageStats_General.Show(followerActor.GetLevel(), \
														followerActor.GetActorValue("Health"), \
														followerActor.GetActorValue("Magicka"), \
														followerActor.GetActorValue("Stamina"), \
														followerActor.GetActorValue("HealRateMult"), \
														followerActor.GetActorValue("MagickaRateMult"), \
														followerActor.GetActorValue("StaminaRateMult"), \
														followerActor.GetActorValue("DamageResist"))
				Elseif ret == Command_Stats_Resistances
					XFL_MessageMod_Stats_Resistances = 0
					ret = XFL_MessageStats_Resistances.Show(followerActor.GetActorValue("DiseaseResist"), \
														followerActor.GetActorValue("ElectricResist"), \
														followerActor.GetActorValue("FireResist"), \
														followerActor.GetActorValue("FrostResist"), \
														followerActor.GetActorValue("PoisonResist"), \
														followerActor.GetActorValue("MagicResist"))
				Elseif ret == Command_Stats_Combat
					XFL_MessageMod_Stats_Combat = 0
					ret = XFL_MessageStats_Combat.Show(followerActor.GetActorValue("OneHanded"), \
														followerActor.GetActorValue("TwoHanded"), \
														followerActor.GetActorValue("Marksman"), \
														followerActor.GetActorValue("Block"), \
														followerActor.GetActorValue("HeavyArmor"), \
														followerActor.GetActorValue("LightArmor"), \
														followerActor.GetActorValue("Sneak"))
				Elseif ret == Command_Stats_Skill
					XFL_MessageMod_Stats_Skill = 0
					ret = XFL_MessageStats_Skill.Show(followerActor.GetActorValue("Alchemy"), \
													followerActor.GetActorValue("Enchanting"), \
													followerActor.GetActorValue("Smithing"), \
													followerActor.GetActorValue("Lockpicking"), \
													followerActor.GetActorValue("Pickpocket"), \
													followerActor.GetActorValue("Speechcraft"))
				Elseif ret == Command_Stats_Magic
					XFL_MessageMod_Stats_Magic = 0
					ret = XFL_MessageStats_Magic.Show(followerActor.GetActorValue("Alteration"), \
													followerActor.GetActorValue("Conjuration"), \
													followerActor.GetActorValue("Destruction"), \
													followerActor.GetActorValue("Illusion"), \
													followerActor.GetActorValue("Restoration"))
				Endif
			EndWhile
		EndIf
		
		If ret == Command_Stats_Back
			XFL_TriggerMenu(followerActor, previousState, GetParentState(previousState)) ; Third level menu, need parent of parent
		Elseif ret == Command_Stats_Exit
			OnFinishMenu()
		Endif
		
		deactivateMenu()
	EndFunction
	
	Function deactivateMenu()
		XFL_MessageMod_Stats_General = 0
		XFL_MessageMod_Stats_Combat = 0
		XFL_MessageMod_Stats_Skill = 0
		XFL_MessageMod_Stats_Magic = 0
		XFL_MessageMod_Back = 0
		XFL_Placeholder.Clear()
		GoToState("")
	EndFunction
EndState

State PluginMenu_Standard
	Function activateMenu(Form akForm = None, string previousState = "", int page = 0)
		Int Command_Plugin_Back = 5
		Int Command_Plugin_Next = 6
		Int Command_Plugin_Exit = 7
		
		If previousState != "" || page > 0
			XFL_MessageMod_Back = 1
		Else
			XFL_MessageMod_Back = 0
		EndIf
		
		bool isGroup = (previousState == GetMenuState("GroupMenu"))
		UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
		if listMenu
			int totalPlugins = XFL_FollowerPlugins.GetSize()
			int i = 0
			int itemIndex = 0
			While i < totalPlugins ; Index available plugins
				EFFPlugin plugin = (XFL_FollowerPlugins.GetAt(i) As EFFPlugin)
				If plugin && plugin.isEnabled() && ((!isGroup && plugin.showMenu(akForm)) || (isGroup && plugin.showGroupMenu()))
					string[] premadeEntries = plugin.GetMenuEntries(akForm)
					if premadeEntries[0] != ""
						listMenu.SetPropertyStringA("appendEntries", premadeEntries)
					Endif
				Endif
				i += 1
			EndWhile

			if listMenu.OpenMenu(akForm)
				int itemId = listMenu.GetResultInt() ; ItemId
				int identifier = (itemId / 100) as int
				int callback = listMenu.GetResultFloat() as int ; Callback value

				i = 0
				While i < totalPlugins ; Index available plugins
					EFFPlugin plugin = (XFL_FollowerPlugins.GetAt(i) As EFFPlugin)
					If plugin && plugin.GetIdentifier() == identifier
						plugin.OnMenuEntryTriggered(akForm, itemId, callback)
					Endif
					i += 1
				EndWhile
			Else
				XFL_TriggerMenu(akForm, previousState, GetParentState(previousState)) ; Third level menu, need parent of parent
			Endif
		Else
			Debug.Trace("EFF ERROR: Failed to retrieve UIListMenu.")
		Endif
		; Int[] pluginIndexes = new Int[5] ; Store which Plugin Index corresponds to which Menu index
		; int pageEnum = pluginIndexes.Length
				
		; int ret = 0
		; While ret != Command_Plugin_Exit
		; 	bool Command_Plugin_Back_Enabled = (previousState != "")
		; 	pluginIndexes[0] = -1
		; 	pluginIndexes[1] = -1
		; 	pluginIndexes[2] = -1
		; 	pluginIndexes[3] = -1
		; 	pluginIndexes[4] = -1

		; 	int totalPlugins = XFL_FollowerPlugins.GetSize()
		; 	int i = 0
		; 	int itemIndex = 0
		; 	While i < totalPlugins ; Index available plugins
		; 		int pluginIndex = (page * pageEnum) + i
		; 		EFFPlugin plugin = (XFL_FollowerPlugins.GetAt(pluginIndex) As EFFPlugin)
		; 		If plugin && plugin.isEnabled() && ((!isGroup && plugin.showMenu(akForm)) || (isGroup && plugin.showGroupMenu()))
		; 			If itemIndex < pluginIndexes.Length
		; 				pluginIndexes[itemIndex] = pluginIndex
		; 				itemIndex += 1
		; 			Endif
		; 		Else
		; 			totalPlugins -= 1
		; 		Endif
		; 		i += 1
		; 	EndWhile

		; 	; If there are more mods then what are displayed
		; 	If totalPlugins > (page + 1) * pageEnum
		; 		XFL_MessageMod_Next = 1
		; 	Else
		; 		XFL_MessageMod_Next = 0
		; 	EndIf

		; 	UIMenuBase wheelMenu = XFL_GetStandardMenu("UIWheelMenu")
		; 	if wheelMenu
		; 		; Setup plugin menu options
		; 		i = 0
		; 		While i < pluginIndexes.Length
		; 			If pluginIndexes[i] != -1
		; 				EFFPlugin plugin = (XFL_FollowerPlugins.GetAt(pluginIndexes[i]) As EFFPlugin)
		; 				If plugin
		; 					wheelMenu.SetPropertyIndexString("optionText", i, plugin.GetPluginName())
		; 					wheelMenu.SetPropertyIndexString("optionLabelText", i, plugin.GetPluginName())
		; 					wheelMenu.SetPropertyIndexBool("optionEnabled", i, true)
		; 				Endif
		; 			Else
		; 				wheelMenu.SetPropertyIndexString("optionText", i, "")
		; 				wheelMenu.SetPropertyIndexString("optionLabelText", i, "")
		; 				wheelMenu.SetPropertyIndexBool("optionEnabled", i, false)
		; 			EndIf
		; 			i += 1
		; 		EndWhile

		; 		wheelMenu.SetPropertyIndexString("optionText", Command_Plugin_Back, STRING_COMMAND_BACK)
		; 		wheelMenu.SetPropertyIndexString("optionLabelText", Command_Plugin_Back, STRING_COMMAND_BACK)
		; 		wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Plugin_Back, false)
		; 		wheelMenu.SetPropertyIndexInt("optionTextColor", Command_Plugin_Back, 0x777777)

		; 		wheelMenu.SetPropertyIndexString("optionText", Command_Plugin_Next, STRING_COMMAND_NEXT)
		; 		wheelMenu.SetPropertyIndexString("optionLabelText", Command_Plugin_Next, STRING_COMMAND_NEXT)
		; 		wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Plugin_Next, false)
		; 		wheelMenu.SetPropertyIndexInt("optionTextColor", Command_Plugin_Next, 0x777777)

		; 		If XFL_MessageMod_Next
		; 			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Plugin_Next, true)
		; 			wheelMenu.SetPropertyIndexInt("optionTextColor", Command_Plugin_Next, 0xFFFFFF)
		; 		Endif

		; 		If Command_Plugin_Back_Enabled
		; 			wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Plugin_Back, true)
		; 			wheelMenu.SetPropertyIndexInt("optionTextColor", Command_Plugin_Back, 0xFFFFFF)
		; 		EndIf

		; 		wheelMenu.SetPropertyIndexString("optionText", Command_Plugin_Exit, STRING_COMMAND_EXIT)
		; 		wheelMenu.SetPropertyIndexString("optionLabelText", Command_Plugin_Exit, STRING_COMMAND_EXIT)
		; 		wheelMenu.SetPropertyIndexBool("optionEnabled", Command_Plugin_Exit, true)

		; 		ret = wheelMenu.OpenMenu(akForm)			
		; 		If ret >= 0 && ret < Command_Plugin_Back ; Activate the correct menu
		; 			EFFPlugin plugin = (XFL_FollowerPlugins.GetAt(pluginIndexes[ret]) as EFFPlugin)
		; 			If plugin
		; 				If isGroup
		; 					plugin.activateGroupMenu(page, akForm)
		; 				Else
		; 					plugin.activateMenu(page, akForm)
		; 				Endif
		; 			EndIf
		; 			ret = Command_Plugin_Exit ; Discontinue menu loop
		; 		Elseif ret == Command_Plugin_Back || (ret == -1 && XFL_MessageMod_Back == 1)
		; 			If page == 0
		; 				XFL_TriggerMenu(akForm, previousState, GetParentState(previousState)) ; Third level menu, need parent of parent
		; 				ret = Command_Plugin_Exit ; Discontinue menu loop
		; 			Else
		; 				page -= 1
						
		; 				If page == 0 && previousState == "" ; We're returning to the first page of the menu, but we had no previous menu
		; 					XFL_MessageMod_Back = 0
		; 				EndIf
		; 			EndIf
		; 		Elseif ret == Command_Plugin_Next
		; 			XFL_MessageMod_Back = 1 ; We have previous pages
		; 			page += 1
		; 		Elseif ret == Command_Plugin_Exit || (ret == -1 && XFL_MessageMod_Back == 0)
		; 			ret = Command_Plugin_Exit ; Discontinue menu loop
		; 			OnFinishMenu()
		; 		EndIf
		; 	Endif
		; EndWhile
		
		deactivateMenu()
	EndFunction
	
	Function deactivateMenu()
		XFL_MessageMod_Plugin_0 = 0
		XFL_MessageMod_Plugin_1 = 0
		XFL_MessageMod_Plugin_2 = 0
		XFL_MessageMod_Plugin_3 = 0
		XFL_MessageMod_Plugin_4 = 0
		XFL_MessageMod_Plugin_5 = 0
		XFL_MessageMod_Plugin_6 = 0
		XFL_MessageMod_Next = 0
		XFL_MessageMod_Back = 0
		GoToState("")
	EndFunction
EndState

State PluginMenu_Classic
	Function activateMenu(Form akForm = None, string previousState = "", int page = 0)
		Int Command_Plugin_Back = 7
		Int Command_Plugin_Next = 8
		Int Command_Plugin_Exit = 9
		
		If previousState != "" || page > 0
			XFL_MessageMod_Back = 1
		EndIf

		Actor followerActor = akForm as Actor
		
		bool isGroup = (previousState == GetMenuState("GroupMenu"))
		
		Int[] pluginIndex = new Int[7] ; Store which Plugin Index corresponds to which Menu index
				
		int ret = 0
		While ret != Command_Plugin_Exit
			int totalPlugins = XFL_FollowerPlugins.GetSize()
			int i = 0
			While i < totalPlugins ; Subtract disabled or hidden plugins
				EFFPlugin plugin = (XFL_FollowerPlugins.GetAt((page * 7) + i) As EFFPlugin)
				If plugin && plugin.MenuRef && (!plugin.isEnabled() || ((!isGroup && !plugin.showMenu(followerActor)) || (isGroup && !plugin.showGroupMenu())))
					totalPlugins -= 1
				Elseif !plugin
					totalPlugins -= 1
				Endif
				i += 1
			EndWhile

			; If there are more mods then what are displayed
			If totalPlugins > (page + 1) * 7
				XFL_MessageMod_Next = 1
			Else
				XFL_MessageMod_Next = 0
			EndIf
			
			; Setup plugin menu options
			i = 0
			int itemIndex = 0
			While i < XFL_FollowerMenuAliases.Length
				bool incrementAlias = true
				If XFL_FollowerPlugins.GetSize() > (page * 7) + itemIndex ; Check if there are still more mods to process
					EFFPlugin plugin = (XFL_FollowerPlugins.GetAt((page * 7) + itemIndex) As EFFPlugin)
					If plugin && plugin.isEnabled() && plugin.MenuRef && ((!isGroup && plugin.showMenu(followerActor)) || (isGroup && plugin.showGroupMenu()))
						XFL_FollowerMenuAliases[i].ForceRefTo(plugin.MenuRef) ; Force the Menu Object into the menu alias for text replacement
						XFL_ShowOptionByAlias(XFL_FollowerMenuAliases[i], true)
						pluginIndex[i] = (page * 7) + itemIndex
					Else
						incrementAlias = false ; Skip the item and stay on this alias
					EndIf
				Else
					XFL_FollowerMenuAliases[i].ForceRefTo(FollowerMenuOption_None) ; Reaching end of list, rest of the aliases are empty
					XFL_ShowOptionByAlias(XFL_FollowerMenuAliases[i], false)
					pluginIndex[i] = -1
				EndIf
				If incrementAlias
					i += 1
				EndIf
				itemIndex += 1
			EndWhile
				
			ret = XFL_MessagePlugins.Show(page + 1)
			
			If ret < Command_Plugin_Back ; Activate the correct menu
				EFFPlugin plugin = (XFL_FollowerPlugins.GetAt(pluginIndex[ret]) as EFFPlugin)
				If plugin
					If isGroup
						plugin.activateGroupMenu(page, followerActor)
					Else
						plugin.activateMenu(page, followerActor)
					Endif
				EndIf
				ret = Command_Plugin_Exit ; Discontinue menu loop
			Elseif ret == Command_Plugin_Back
				If page == 0
					XFL_TriggerMenu(followerActor, previousState, GetParentState(previousState)) ; Third level menu, need parent of parent
					ret = Command_Plugin_Exit ; Discontinue menu loop
				Else
					page -= 1
					
					If page == 0 && previousState == "" ; We're returning to the first page of the menu, but we had no previous menu
						XFL_MessageMod_Back = 0
					EndIf
				EndIf
			Elseif ret == Command_Plugin_Next
				XFL_MessageMod_Back = 1 ; We have previous pages
				page += 1
			Elseif ret == Command_Plugin_Exit
				OnFinishMenu()
			EndIf
		EndWhile
		
		deactivateMenu()
	EndFunction
	
	Function deactivateMenu()
		XFL_MessageMod_Plugin_0 = 0
		XFL_MessageMod_Plugin_1 = 0
		XFL_MessageMod_Plugin_2 = 0
		XFL_MessageMod_Plugin_3 = 0
		XFL_MessageMod_Plugin_4 = 0
		XFL_MessageMod_Plugin_5 = 0
		XFL_MessageMod_Plugin_6 = 0
		XFL_MessageMod_Next = 0
		XFL_MessageMod_Back = 0
		GoToState("")
	EndFunction
EndState

Event OnStartMenu()
	If XFL_Config_UseClassicMenus.value == 1
		XFL_Player.DoCombatSpellApply(XFL_SlowTime, XFL_Player)
	Endif
EndEvent

Event OnFinishMenu()
	XFL_Player.DispelSpell(XFL_SlowTime)
EndEvent

; Lock selection until menu returns data
Form Function XFL_SelectFollowers()
	UIMenuBase selection = XFL_GetStandardMenu("UISelectionMenu")
	selection.SetPropertyInt("menuMode", 1)
	selection.OpenMenu(XFLMain.XFL_FollowerList, selection)
	return selection.GetResultForm()
EndFunction

; Menu Extensions
UIMenuBase Function XFL_GetStandardMenu(string menuName)
	If XFLMain.SKSEExtended == false
		Debug.Trace("EFF WARNING: This feature requires SKSE.")
		return None
	Elseif XFLMain.MENUExtended == false
		Debug.Trace("EFF WARNING: This menu requires UIExtensions.")
		return None
	Endif
	
	return UIExtensions.GetMenu(menuName)
EndFunction
