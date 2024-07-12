Scriptname _SLS_AllInOneFavorite extends Quest  

Event OnInit()
	If Self.IsRunning()
		BuildFavorites()
		GoToState("Outfits")
	EndIf
EndEvent

Function BuildFavorites()
	AioFavorites = new String[22]
	AioFavorites[0] = "Open/Close Mouth"
	AioFavorites[1] = "Tongue "
	AioFavorites[2] = "Emote "
	AioFavorites[3] = "Cover Myself"
	AioFavorites[4] = "Change Stance"
	AioFavorites[5] = "Dance "
	AioFavorites[6] = "More Actions"
	AioFavorites[7] = "Cry For Help"
	AioFavorites[8] = "Spank Npc"
	AioFavorites[9] = "Milk Myself"
	AioFavorites[10] = "Devices "
	AioFavorites[11] = "Outfits "
	AioFavorites[12] = "Survival Skills Menu"
	AioFavorites[13] = "Crafting Menu"
	AioFavorites[14] = "Wildling "
	AioFavorites[15] = "Cum Menu"
	AioFavorites[16] = "Combat Idles"
	AioFavorites[17] = "Gesture Idles"
	AioFavorites[18] = "Debug Menu"
	AioFavorites[19] = "Add Item Menu"
	AioFavorites[20] = "Overlays Menu"
	AioFavorites[21] = "Trauma Menu"
	
	StorageUtil.StringListClear(Self, "AioFavoriteStates")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "OpenCloseMouth")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "Tongue")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "Emote")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "CoverMyself")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "ChangeStance")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "Dance")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "MoreActions")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "CryForHelp")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "SpankNpc")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "MilkMyself")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "Devices")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "Outfits")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "SurvivalSkillsMenu")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "CraftingMenu")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "WildlingMenu")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "CumMenu")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "CombatIdles")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "GestureIdles")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "DebugMenu")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "AddItemMenu")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "DebugOverlays")
	StorageUtil.StringListAdd(Self, "AioFavoriteStates", "DebugTrauma")
EndFunction

Function SetFav(Int Index)
	Favorite = Index
	GoToState(StorageUtil.StringListGet(Self, "AioFavoriteStates", Index))
EndFunction

; Favorite States ====================================================================================================================

String Function GetFavoriteString()
	Return ""
EndFunction
	
Function FavoriteAction()
EndFunction

State OpenCloseMouth
	String Function GetFavoriteString()
		If sslBaseExpression.IsMouthOpen(PlayerRef)
			Return "Close Mouth"
		EndIf
		Return "Open Mouth"
	EndFunction
	
	Function FavoriteAction()
		Aio.CumSwallow.OnKeyDown(0)
	EndFunction
EndState

State Tongue
	String Function GetFavoriteString()
		Return "Tongue "
	EndFunction
	
	Function FavoriteAction()
		Aio.TongueMenu(IsShortcut = true)
	EndFunction
EndState

State Emote
	String Function GetFavoriteString()
		Return "Emote "
	EndFunction
	
	Function FavoriteAction()
		Aio.EmoteMenu(IsShortcut = true)
	EndFunction
EndState

State CoverMyself
	String Function GetFavoriteString()
		If Aio.CoverMyself.GetState() == "Covered"
			Return "Uncover Myself"
		EndIf
		Return "Cover Myself"
	EndFunction
	
	Function FavoriteAction()
		Aio.CoverMyself.OnKeyDown(0)
	EndFunction
EndState

State ChangeStance
	String Function GetFavoriteString()
		Return "Change Stance"
	EndFunction
	
	Function FavoriteAction()
		Aio.ChangeStanceMenu(IsShortcut = true)
	EndFunction
EndState

State Dance
	String Function GetFavoriteString()
		Return "Dance "
	EndFunction
	
	Function FavoriteAction()
		Aio.DanceRootMenu(IsShortcut = true)
	EndFunction
EndState

State MoreActions
	String Function GetFavoriteString()
		Return "More Actions"
	EndFunction
	
	Function FavoriteAction()
		Aio.MoreActionsMenu(IsShortcut = true)
	EndFunction
EndState

State CryForHelp
	String Function GetFavoriteString()
		Return "Cry For Help"
	EndFunction
	
	Function FavoriteAction()
		Aio._SLS_ScreamForHelpSpell.Cast(PlayerRef, PlayerRef)
	EndFunction
EndState

State SpankNpc
	String Function GetFavoriteString()
		Return "Spank Npc"
	EndFunction
	
	Function FavoriteAction()
		Aio.SpankNpc()
	EndFunction
EndState

State MilkMyself
	String Function GetFavoriteString()
		Return "Milk Myself"
	EndFunction
	
	Function FavoriteAction()
		Aio.Mme.MilkPlayer()
	EndFunction
EndState

State Devices
	String Function GetFavoriteString()
		Return "Devices "
	EndFunction
	
	Function FavoriteAction()
		Aio.UntieNpc(IsShortcut = true)
	EndFunction
EndState

State Outfits
	String Function GetFavoriteString()
		Return "Outfits "
	EndFunction
	
	Function FavoriteAction()
		Aio.OutfitMenu(IsShortcut = true)
	EndFunction
EndState

State SurvivalSkillsMenu
	String Function GetFavoriteString()
		Return "Survival Skills"
	EndFunction
	
	Function FavoriteAction()
		Aio.SurvivalSkillsMenu(IsShortcut = true)
	EndFunction
EndState

State CraftingMenu
	String Function GetFavoriteString()
		Return "Crafting "
	EndFunction
	
	Function FavoriteAction()
		Aio.CraftingMenu(IsShortcut = true)
	EndFunction
EndState

State WildlingMenu
	String Function GetFavoriteString()
		Return "Wildling "
	EndFunction
	
	Function FavoriteAction()
		Aio.WildlingMenu(IsShortcut = true)
	EndFunction
EndState

State CumMenu
	String Function GetFavoriteString()
		Return "Cum "
	EndFunction
	
	Function FavoriteAction()
		Aio.CumMenu(IsShortcut = true)
	EndFunction
EndState

State CombatIdles
	String Function GetFavoriteString()
		Return "Combat Idles"
	EndFunction
	
	Function FavoriteAction()
		Aio.IdleCombatMenu(IsShortcut = true)
	EndFunction
EndState

State GestureIdles
	String Function GetFavoriteString()
		Return "Gesture Idles"
	EndFunction
	
	Function FavoriteAction()
		Aio.IdleGesturesMenu(IsShortcut = true)
	EndFunction
EndState

State DebugMenu
	String Function GetFavoriteString()
		Return "Debug Menu"
	EndFunction
	
	Function FavoriteAction()
		Aio.DebugMenu(IsShortcut = true)
	EndFunction
EndState

State AddItemMenu
	String Function GetFavoriteString()
		Return "Add Item Menu"
	EndFunction
	
	Function FavoriteAction()
		Aio.AddItemMenu()
	EndFunction
EndState

State DebugOverlays
	String Function GetFavoriteString()
		Return "Overlays "
	EndFunction
	
	Function FavoriteAction()
		Aio.OverlaysMenu(IsShortcut = true)
	EndFunction
EndState

State DebugTrauma
	String Function GetFavoriteString()
		Return "Trauma "
	EndFunction
	
	Function FavoriteAction()
		Aio.TraumaMenu(IsShortcut = true)
	EndFunction
EndState

String[] Property AioFavorites Auto Hidden

Int Property Favorite = 11 Auto Hidden

Actor Property PlayerRef Auto

_SLS_AllInOneKey Property Aio Auto
