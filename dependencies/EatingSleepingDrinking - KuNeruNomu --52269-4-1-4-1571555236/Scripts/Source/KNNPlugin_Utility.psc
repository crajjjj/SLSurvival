Scriptname KNNPlugin_Utility Hidden

;You can use basic-needs state change event. If you used SetBasicNeeds() to change basic-needs values, this will call after about 15 seconds.
;If you used ModBasicNeeds(), this will be called immediately.
;Event OnInIt()
;	RegisterForModEvent("KNNBasicNeeds_Aplly", "OnApllyKNNBasicNeeds")
;	RegisterForModEvent("KNNBasicNeeds_Remove", "OnRemoveKNNBasicNeeds")
;	These are SKSE RegisterForModEvent()
;	KNNPlugin.dll call SendModEvent("KNNBasicNeeds_Aplly") and SendModEvent("KNNBasicNeeds_Remove")
;EndEvent
;Event OnApllyKNNBasicNeeds(string eventName, string values, float flags, form player)
	;Called this when the PC get hungry or thirsty, exhaustion...
	;debug.trace("OnApllyKNNBasicNeeds")
	;if 0 != Math.LogicalAnd(flags as int, 0x01)
	;	debug.trace("Hungry")
	;endIf
	;if 0 != Math.LogicalAnd(flags as int, 0x02)
	;	debug.trace("Thirsty")
	;endIf
	;if 0 != Math.LogicalAnd(flags as int, 0x04)
	;	debug.trace("Exhaustion")
	;endIf
	;if 0 != Math.LogicalAnd(flags as int, 0x08)
	;	debug.trace("Dirty body")
	;endIf
	;if 0 != Math.LogicalAnd(flags as int, 0x10)
	;	debug.trace("Drunk")
	;endIf
	;actor p = player as actor
	;if p
	;	debug.trace(p.GetBaseObject().GetName())
	;endIf
	;int stringLength = StringUtil.GetLength(values)
	;string name = "Hungry value"
	;int numOfArray = 0
	;int i = 0
	;while i < stringLength
	;	int index = StringUtil.Find(values, ",", i)
	;	if 1 == numOfArray
	;		name = "Thirsty value"
	;	elseIf 2 == numOfArray
	;		name = "Exhaustion value"
	;	elseIf 3 == numOfArray
	;		name = "Body-Health value"
	;	elseIf 4 == numOfArray
	;		name = "Drunk value"
	;	endIf
	;	if 0 < index
	;		string floatingStr = StringUtil.Substring(values, i, index - 1 - i)
	;		debug.trace(name + " : " + floatingStr)
	;		if floatingStr as float != GetBasicNeeds("hungry")
	;			debug.trace("Return always true because floatingStr truncating the numbers beyond the 3rd decimal point by KNNPlugin.dll.")
	;		endIf
	;		i = index + 1
	;	else
	;		Last array element(drunk value)
	;		if i < stringLength
	;			string floatingStr = StringUtil.Substring(values, i, stringLength - 1)
	;			debug.trace(name + " : " + floatingStr)
	;		endIf
	;		i = stringLength
	;	endIf
	;	numOfArray += 1
	;endwhile
	;debug.trace("End of OnApllyKNNBasicNeeds")
	;values = "hungry_value,thirsty_value,Exhaustion_value,dirtybody_value,drunk_value"
	;*Incorrect string number if not set flag.
;EndEvent
;Event OnRemoveKNNBasicNeeds(string eventName, string values, float flags, form player)
;EndEvent

;For detect new food. Don't use this.
;hungry
;thirsty
;drunkness
Function AddMealValue(string typeName, float foodWeight) native global

;Hungry
;Thirsty
;Sleepiness
;Bodyhealth
;Drunkness
;followerbodyhealth
;Uppercase or Lowercase either is OK
float Function GetBasicNeeds(string typeName) native global
Function SetBasicNeeds(string typeName, float Value) native global
;If you want to reduce bodyhealth one cycle, use this. if you set value = 1440.0, The SKSE plugin automatically convert to one cycle value(SKSE plugin : 1440.0 * bodyhealth interval value).
float Function ModBasicNeeds(string typeName, float Value) native global

;Force update widget meter
;Main widget : hungry / thirsty / tired
;option widget : dirty body / drunk
Function UpdateWidget(bool IsMainWidget) native global

bool Function IsInWater(Actor thisActor) native global
bool Function IsTorchOut(Actor thisActor) native global
Form Function GetEquipAmmo(ObjectReference ref) native global
bool Function IsTeammateFavor() native global
bool Function DontPlayKNNAnimation(Actor thisActor, bool IsApply) native global
;DontPlayKNNAnimation return value
;true Succeed to set the flag
;false Failed
;The flag will be removed when actors 3D was unloaeded.

;Default(basicNeeds defaut expression)
;Custom(basicNeeds custom expression)
;Pray(activate anim praying)
;int[] Function GetExpressionValue(string typeName) native global

;Don't use this.
int Function SetActivateLeverAnim(ObjectReference leverRef, Actor actionRef) native global
bool Function HasFittingDragonCrow(ObjectReference ref, Actor actionRef) native global

;Foods
;Soup
;Water
;Alchol
;RawFoods
;NoFoodsNoDrinks
;CustomPotions
Form[] Function GetFoodsFromList(string listName) native global
string[] Function GetFoodsFromNameList(string listName) native global

;if set IsFoodItem to false, you will get a alcohol(not included water)
;return Form is null or food Form
Form Function GetFood(Actor thisActor, bool IsFoodItem) native global
;Female : true
;Male : false
;included opposite gender anim
;if set thisActor = none, returned true
bool Function GetActorGender(Actor thisActor) native global
bool Function AreYouAlright(ObjectReference actorRef) native global
Actor Function GetAliasFollower()  native global
;Try to change target-quest priority if the quest is completely stopped. Need to call this every loading the game. Return to the original value unless don't call.
;bool Function SetQuestPriority(int priority, Quest targetQuest) native global

;Don't use this.
bool Function IsCellLoadedDoor(ObjectReference doorRef) native global

Function ForceCrosshairUpdate() native global

;Get HUD target object(included far distance)
ObjectReference Function GetPlayerTarget() native global

;Don't use this.
float Function GetHeadDiffarencePercent(Actor actorRef, ObjectReference targetRef, float maxHeight, float ifOverFlowValue) native global

;Don't use this.
int Function ResolveModBed() native global
bool Function IsBedSingleMakerNode(ObjectReference bedRef) native global
bool Function ShowKNNBasicNeedsStutas() native global
Function ForceCloseFavoritesMenu() native global
Function ForceCloseMCMMenu() native global

Form[] Function GetEquippedArmors(Actor thisActor) native global
string Function GetArmorSlotName(Armor thisArmor) native global
;Don't send more than 0x80000000
Function PlayerUnequipItems(int unequippedSlotMasks) native global
Function PlayerEquipItems() native global
Function ClearPlayerEquipItemData() native global
	
;Don't use this. For SaunaHouse.esp(_BathHouseUtility.psc)
Function PlayerEitherWearOrTakeOffItems(int unequippedSlotMasks) native global

bool Function SaveKNNSettings(float[] widgetPosAlpha) native global
float[] Function LoadKNNSettings(string settingsName) native global
Form[] Function GetKNNSettingsForms(string settingsName) native global
Function SaveSlotMasks(string fileName, bool[] slotMaskArray) native global
bool[] Function LoadSlotMasks(string fileName) native global
;settingsName is SKSE\Plugins\EatingSleepingDrinking\backup\MCMSettings.xml each parent tag name.

string[] Function GetAnimation(int type, bool IsFemale, Form keyForm, string indexName) native global
;type
;see _KNNPrePlayAnimationQuest.pex
;int Property TYPE_WASHING_BODY 				= 1 	autoReadOnly
;int Property TYPE_PEEPED_WASHING_BODY 			= 2 	autoReadOnly
;int Property TYPE_REDING_BOOKS 				= 3 	autoReadOnly
;int Property TYPE_TAKE_POTIONS 				= 4 	autoReadOnly
;int Property TYPE_FORETASTE_INGREDIENTS 		= 5 	autoReadOnly
;int Property TYPE_KNITTING_TOWELS 				= 6 	autoReadOnly
;int Property TYPE_KEEP_JOURNAL 				= 7 	autoReadOnly
;int Property TYPE_REGISTER_POTIONS 			= 8 	autoReadOnly
;int Property TYPE_FILLED_WATER 				= 9 	autoReadOnly
;int Property TYPE_IDLEMARKER_NOTFOUND 			= 10 	autoReadOnly
;int Property TYPE_DRINKWATER_HANDS 			= 11 	autoReadOnly
;int Property TYPE_ABSORB_DRAGONSOUL			= 12 	autoReadOnly
;int Property TYPE_DRINKING_DRINKS				= 13 	autoReadOnly
;int Property TYPE_DRINKING_DRINKS_MOVING		= 14 	autoReadOnly
;int Property TYPE_DRINKING_DRINKS_SITTING		= 15 	autoReadOnly
;int Property TYPE_EATING_FOODS					= 16 	autoReadOnly
;int Property TYPE_EATING_FOODS_SITTING			= 17 	autoReadOnly
;indexName
;see _KNNPrePlayAnimationQuest.psc and Skyrim.xml, Dawnguard.xml, Hearthfire.xml, Dragonborn.xml
;animation="tankard" and "bread"...etc
bool Function CreateAnimationXML(int type) native global
bool Function ManagingAllFoodList(bool IsExportList) native global
;IsExportList = true : exported external mod food formlist to xml. fromlist : foods, alcohol, water, raw foods, nofoods-nodrinkis, custom potion list
;IsExportList = false : import external mod food xml to formlist.

;======================================
;		KNN Headtracking
;======================================
;Need to use : Math.LogicalAnd(GetExpressionState(), 0x10)
;DO NOT SET NEGATIVE INTERGER
;BN = 0x01,
;CustomNB = 0x02,
;Pray = 0x04,
;HT = 0x08,
;Peeping = 0x10,
;Combat = 0x20,
;GoToSleep = 0x40, Used aaaKNNPlayPerkBedAnimQuest.psc, aaaKNNHTQuest.psc
;DoNothing = 0x80000000, If set, stop KNN expression feature. Cleared this when game is reloaded
;When an animation not included in this MOD is being played, the expression does not change,
int Function GetExpressionState() native global
Function SetExpressionState(int currentState) native global
Function ClearExpressionState(int currentState) native global
Function SetPlayerAngleZ(float offset) native global
Function SetNoLookObject() native global