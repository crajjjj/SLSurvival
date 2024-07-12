scriptName _KNNPrePlayAnimationQuest extends Quest

aaaKNNBasicNeedsQuest Property Msg 				auto
Quest Property AnimCtrl 						auto
Message Property aaaKNNMsgPeepedSomeone 		auto
Message Property aaaKNNMsgMakeTowel 			auto
GlobalVariable Property aaaKNNNeedTundraCotton 	auto
GlobalVariable Property aaaAnimMakeTowel 		auto
FormList Property waterBottleList 				auto
Potion Property towels 							auto
Keyword Property _KNNPlayAnimationKey 			auto
int Property AnimType = 0						auto
string[] Property AnimData 						auto
bool Property IsPCFemale = true 				auto
form Property something = none					auto

int Property TYPE_WASHING_BODY 				= 1 	autoReadOnly
int Property TYPE_PEEPED_WASHING_BODY 		= 2 	autoReadOnly
int Property TYPE_REDING_BOOKS 				= 3 	autoReadOnly
int Property TYPE_TAKE_POTIONS 				= 4 	autoReadOnly
int Property TYPE_FORETASTE_INGREDIENTS 	= 5 	autoReadOnly
int Property TYPE_KNITTING_TOWELS 			= 6 	autoReadOnly
int Property TYPE_KEEP_JOURNAL 				= 7 	autoReadOnly
int Property TYPE_REGISTER_POTIONS 			= 8 	autoReadOnly
int Property TYPE_FILLED_WATER 				= 9 	autoReadOnly
int Property TYPE_IDLEMARKER_NOTFOUND 		= 10 	autoReadOnly
int Property TYPE_DRINKWATER_HANDS 			= 11 	autoReadOnly
int Property TYPE_ABSORB_DRAGONSOUL			= 12 	autoReadOnly
int Property TYPE_DRINKING_DRINKS			= 13 	autoReadOnly
int Property TYPE_DRINKING_DRINKS_MOVING	= 14 	autoReadOnly
int Property TYPE_DRINKING_DRINKS_SITTING	= 15 	autoReadOnly
int Property TYPE_EATING_FOODS				= 16 	autoReadOnly
int Property TYPE_EATING_FOODS_SITTING		= 17 	autoReadOnly

bool Function CheckAnimType(Actor player, int type, form keyForm)
	IsPCFemale = (AnimCtrl as aaaKNNAnimControlQuest).GetGender(player)
	if TYPE_EATING_FOODS == type || TYPE_EATING_FOODS_SITTING == type
		animData = KNNPlugin_Utility.GetAnimation(type, IsPCFemale, keyForm, "bread")
		if 2 == animData.Length
			return true
		endIf
	elseIf TYPE_DRINKING_DRINKS == type || TYPE_DRINKING_DRINKS_MOVING == type || TYPE_DRINKING_DRINKS_SITTING == type	
		animData = KNNPlugin_Utility.GetAnimation(type, IsPCFemale, keyForm, "tankard")
		if 2 == animData.Length
			return true
		endIf
	elseIf TYPE_FILLED_WATER == type
		string callName = ""
		int index = waterBottleList.Find(keyForm)
		if 0 == index
			callName = "black"
		elseIf 1 == index
			callName = "mead"
		elseIf 2 == index
			callName = "wine"
		elseIf 3 == index
			callName = "flin"
		elseIf 4 == index
			callName = "matze"
		elseIf 5 == index
			callName = "shein"
		elseIf 6 == index
			callName = "sujamma"
		endIf
		animData = KNNPlugin_Utility.GetAnimation(type, IsPCFemale, none, callName)
		if 2 == animData.Length
			return true
		endIf
	elseIf TYPE_WASHING_BODY == type || TYPE_PEEPED_WASHING_BODY == type
		animData = KNNPlugin_Utility.GetAnimation(type, IsPCFemale, none, "random")
		if 2 == animData.Length && !player.GetAnimationVariableBool("bAnimationDriven")
			return true
		endIf
	elseIf TYPE_REDING_BOOKS == type
		string callName = ""
		if 0 != player.GetSitState()
			if player.GetAnimationVariableBool("bNeutralState")
				callName = "chair"
			endIf
		else
			if !player.GetAnimationVariableBool("bAnimationDriven")
				if keyForm && 0.0 == keyForm.GetWeight()
					callName = "notes"
				else
					callName = "books"
				endIf
			endIf
		endIf
		if "" != callName
			animData = KNNPlugin_Utility.GetAnimation(type, IsPCFemale, none, callName)
			if 2 == animData.Length
				string bookName = "none object"
				if keyForm
					bookName = keyForm.GetName()
				endIf
				;Debug.Trace("[ESD debug log] PrePlayAnimationQuest -> event name : " + animData[0] + ", duration : " + animData[1] + ", book name : " + bookName)
				return true
			endIf
		endIf
	elseIf TYPE_TAKE_POTIONS == type
		string callName = "standing"
		if player.IsSneaking()
			callName = "sneaking"
		endIf
		animData = KNNPlugin_Utility.GetAnimation(type, IsPCFemale, none, callName)
		if 2 == animData.Length
			return true
		endIf
	elseIf TYPE_DRINKWATER_HANDS == type || TYPE_FORETASTE_INGREDIENTS == type || TYPE_KEEP_JOURNAL == type || TYPE_REGISTER_POTIONS == type || TYPE_IDLEMARKER_NOTFOUND == type || TYPE_ABSORB_DRAGONSOUL == type
		animData = KNNPlugin_Utility.GetAnimation(type, IsPCFemale, none, "random")
		if 2 == animData.Length
			return true
		endIf
	elseIf TYPE_KNITTING_TOWELS == type
		if !keyForm || !(keyForm as Ingredient)
			return false
		endIf
		int index = aaaKNNMsgMakeTowel.Show()
		if 1 == index
			if UI.IsMenuOpen("InventoryMenu")
				Game.DisablePlayerControls()
				Utility.Wait(0.1)
				Game.EnablePlayerControls()
			elseIf UI.IsMenuOpen("FavoritesMenu")
				KNNPlugin_Utility.ForceCloseFavoritesMenu()
			endIf
			int tundraAmount = aaaKNNNeedTundraCotton.GetValueInt()
			int tundraCount = player.GetItemCount(keyForm)
			int towelCount = 0
			if 0 == tundraAmount
				towelCount = Utility.RandomInt(0, tundraCount)
			else
				towelCount = tundraCount / tundraAmount
			endIf
			if 0 < towelCount
				player.RemoveItem(keyForm, towelCount * tundraAmount)
				player.AddItem(towels, towelCount)
			endIf
			if 0 != aaaAnimMakeTowel.GetValueInt()
				animData = KNNPlugin_Utility.GetAnimation(type, IsPCFemale, none, "random")
				if 2 == animData.Length
					return true
				endIf
			endIf
		endIf
	endIf
	return false
EndFunction

Function Cleanup()
	GoToState("READY")
EndFunction

Auto State READY
	Event OnBeginState()
		AnimType = 0
		something = none
	EndEvent

	bool Function IsStartPlayerAnimation(Actor player, int type, form keyForm)
		GoToState("")
		if CheckAnimType(player, type, keyForm) && _KNNPlayAnimationKey.SendStoryEventAndWait(none, player)
			AnimType = type
			something = keyForm
			return true
		endIf
		GoToState("READY")
		return false
	EndFunction

	Event StartPlayerAnimation(Actor player, int type, form keyForm)
		GoToState("")
		if CheckAnimType(player, type, keyForm) && _KNNPlayAnimationKey.SendStoryEventAndWait(none, player)
			AnimType = type
			something = keyForm
			return
		endIf
		GoToState("READY")
	EndEvent
EndState

bool Function IsStartPlayerAnimation(Actor player, int type, form keyForm)
EndFunction
Event StartPlayerAnimation(Actor player, int type, form keyForm)
EndEvent

Event OnCantWashBody(Actor player, Potion towelPotion)
	if player && towelPotion
		player.AddItem(towelPotion, 1, false)
	endIf
EndEvent