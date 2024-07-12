Scriptname SLV_Utilities extends Quest

float SLIF_Delta = 0.1

Bool Function SLV_SendDDEvent(Actor NPCActor,bool equip, bool equipGagParam,bool equipAnalPlugParam,bool equipVagPlugParam,bool equipHarnessParam,bool equipBeltParam,bool equipBraParam,bool equipCollarParam,bool equipLegCuffsParam,bool equipArmCuffsParam,bool equipArmbinderParam,bool equipYokeParam,bool equipBlindfoldParam,bool equipNPiercingsParam,bool equipVPiercingsParam,bool equipBootsParam,bool equipGlovesParam,bool equipCorsetParam,bool equipMittensParam=true, bool equipHoodParam=true, bool equipClampsParam=true, bool equipSuitParam=true, bool equipShacklesParam=true, bool equipHobblesSkirtParam=true, bool equipHobblesSkirtRelaxedParam=true, bool equipStraitJacketParam=true)

Int Handle = ModEvent.Create("SlaverunReloaded_ManipulateDD")

If (Handle)
	ModEvent.PushForm(Handle, Self)
	ModEvent.PushForm(Handle, NPCActor)
	ModEvent.PushBool(Handle, equip)
	ModEvent.PushBool(Handle, equipGagParam)
	ModEvent.PushBool(Handle, equipAnalPlugParam)
	ModEvent.PushBool(Handle, equipVagPlugParam)
	ModEvent.PushBool(Handle, equipHarnessParam)
	ModEvent.PushBool(Handle, equipBeltParam)
	ModEvent.PushBool(Handle, equipBraParam)
	ModEvent.PushBool(Handle, equipCollarParam)
	ModEvent.PushBool(Handle, equipLegCuffsParam)
	ModEvent.PushBool(Handle, equipArmCuffsParam)
	ModEvent.PushBool(Handle, equipArmbinderParam)
	ModEvent.PushBool(Handle, equipYokeParam)
	ModEvent.PushBool(Handle, equipBlindfoldParam)
	ModEvent.PushBool(Handle, equipNPiercingsParam)
	ModEvent.PushBool(Handle, equipVPiercingsParam)
	ModEvent.PushBool(Handle, equipBootsParam)
	ModEvent.PushBool(Handle, equipGlovesParam)
	ModEvent.PushBool(Handle, equipCorsetParam)
	ModEvent.PushBool(Handle, equipMittensParam)
	ModEvent.PushBool(Handle, equipHoodParam)
	ModEvent.PushBool(Handle, equipClampsParam)
	ModEvent.PushBool(Handle, equipSuitParam)
	ModEvent.PushBool(Handle, equipShacklesParam)
	ModEvent.PushBool(Handle, equipHobblesSkirtParam)
	ModEvent.PushBool(Handle, equipHobblesSkirtRelaxedParam)
	ModEvent.PushBool(Handle, equipStraitJacketParam)
	ModEvent.Send(Handle)
	Return True
Else
	Return False
EndIf
EndFunction

Function SLV_StartWhipping(Actor NPCActor)
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
myMarker.moveto(NPCActor)
if !SLV_IsInSameLocation(myMarker, NPCActor)
	myMarker.moveto(NPCActor)
else
	SLV_DisplayInformation("Whip marker correct")
endif

if SLV_IsInSameLocation(myMarker, NPCActor) && !SLV_Sex.SLV_isZAPAnimating(NPCActor)
	SLV_DisplayInformation("Using whip marker now")
	NPCActor.setVehicle(none)
	NPCActor.setVehicle(myMarker)
endif

;Utility.SetIniBool("bDisablePlayerCollision:Havok",true)
SLV_DisplayInformation("Whip player started")

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
endFunction
ObjectReference Property myMarker Auto


Function SLV_EndWhipping(Actor NPCActor)
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)

;Utility.SetIniBool("bDisablePlayerCollision:Havok",false)
SLV_DisplayInformation("Whip player ended")
if !SLV_Sex.SLV_isZAPAnimating(NPCActor)
	SLV_DisplayInformation("Unsetting whip marker now")
	NPCActor.setVehicle(none)
endif

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
endFunction

Bool Function SLV_IsInSameLocation(ObjectReference aObject1, ObjectReference aObject2)
if !aObject1.getCurrentLocation() || !aObject2.getCurrentLocation()
	return true
endif
if aObject1.getCurrentLocation().IsSameLocation(aObject2.getCurrentLocation())
	return true
endif
return false
EndFunction

Function SLV_ImmersivePiercings(Actor NPCActor)
;SendModEvent("yps-LockMakeupEvent")
SendModEvent("yps-PermanentMakeupEvent")
SendModEvent("yps-DisableSmudgingEvent")
;Utility.wait(2.0)

;SendModEvent("yps-LipstickEvent", "Dark Red", 0x8b0000)  
SendModEvent("yps-LipstickEvent", "Black" , 0)  
Utility.wait(1.0)
    
SendModEvent("yps-EyeshadowEvent","Black" , 0)    
; apply makeup: send name of color as string (e.g. "red"), and ColorRGBCode as a 0xRRGGBB value.
Utility.wait(1.0)


SendModEvent("yps-FingerNailsEvent", "", 2) 
Utility.wait(1.0)

SendModEvent("yps-ToeNailsEvent",  "", 2)
Utility.wait(1.0)

SendModEvent("yps-PiercingEvent", NPCActor.getActorBase().getName() ,1)
SendModEvent("yps-PiercingEvent", NPCActor.getActorBase().getName() ,2)
SendModEvent("yps-PiercingEvent", NPCActor.getActorBase().getName() ,3)
SendModEvent("yps-PiercingEvent", NPCActor.getActorBase().getName() ,4)
SendModEvent("yps-PiercingEvent", NPCActor.getActorBase().getName() ,5)
SendModEvent("yps-PiercingEvent", NPCActor.getActorBase().getName() ,6)
SendModEvent("yps-PiercingEvent", NPCActor.getActorBase().getName() ,7)
SendModEvent("yps-PiercingEvent", NPCActor.getActorBase().getName() ,8)
SendModEvent("yps-PiercingEvent", NPCActor.getActorBase().getName() ,9)
SendModEvent("yps-PiercingEvent", NPCActor.getActorBase().getName() ,10)
SendModEvent("yps-PiercingEvent", NPCActor.getActorBase().getName() ,11)
EndFunction


Function SLV_FollowersStopFighting()
if SLV_IsActorInSameLocCheck(SLV_Finn)
	SLV_Finn.stopCombat()	
	SLV_Finn.StopCombatAlarm()		
endif

int i=0
if MCMMenu.followersCount > 0
	While (i < MCMMenu.followersCount)
		Actor follower = MCMMenu.Followers[i]
		debug.trace("Follower:" + follower.GetLeveledActorBase().getName())
		if SLV_IsActorInSameLocCheck(follower)
			follower.stopCombat()
			follower.StopCombatAlarm()
		endif
		i = i + 1
	endWhile	
endif
EndFunction
Actor Property SLV_Finn auto
Bool Function SLV_IsActorInSameLocCheck(Actor NPCActor)
if !NPCActor.getCurrentLocation() || !PlayerRef.getCurrentLocation()
	return true
endif
if NPCActor.getCurrentLocation().IsSameLocation(PlayerRef.getCurrentLocation())
	return true
endif
return false
EndFunction


function SLV_ForceToCrawl(Actor NPCActor, bool crawling)
String modname = "SlaverunReloaded"

int playeriscrawling = SLV_PlayerIsCrawling.getvalue() as int

if !MCMMenu.enforcerForceToCrawl || !NPCActor.IsInFaction(SlaverunSlaveFaction) || !SLV_SexSlavetraining1Quest.isCompleted()
	if playeriscrawling
		SLV_DisplayInformation("Unforce actor to crawl")
		FNIS_aa.SetAnimGroup(NPCActor, "_mtidle",0,0,modname,true)
		FNIS_aa.SetAnimGroup(NPCActor, "_mt",0,0,modname,true)
		FNIS_aa.SetAnimGroup(NPCActor, "_mtx",0,0,modname,true)
		SLV_PlayerIsCrawling.setvalue(0)
		return
	endif
endif

if crawling
	SLV_DisplayInformation("Force actor to crawl")
	int modID = FNIS_aa.GetAAModID("slv", modname, true)
	int mtIdleBase = FNIS_aa.GetGroupBaseValue(modID,FNIS_aa._mtidle(),modname,true) 
	int mtBase = FNIS_aa.GetGroupBaseValue(modID,FNIS_aa._mt(),modname,true) 
	int mtxBase = FNIS_aa.GetGroupBaseValue(modID,FNIS_aa._mtx(),modname,true)
					
	FNIS_aa.SetAnimGroup(NPCActor, "_mtidle", mtIdleBase, 0, modname,true)
	FNIS_aa.SetAnimGroup(NPCActor, "_mt", mtBase, 0, modname,true)
	FNIS_aa.SetAnimGroup(NPCActor, "_mtx", mtxBase, 0, modname,true)
	SLV_PlayerIsCrawling.setvalue(1)
else
	if playeriscrawling
		SLV_DisplayInformation("Unforce actor to crawl")
		FNIS_aa.SetAnimGroup(NPCActor, "_mtidle",0,0,modname,true)
		FNIS_aa.SetAnimGroup(NPCActor, "_mt",0,0,modname,true)
		FNIS_aa.SetAnimGroup(NPCActor, "_mtx",0,0,modname,true)
		SLV_PlayerIsCrawling.setvalue(0)
	endif
endif
endFunction
Quest Property SLV_SexSlavetraining1Quest auto
GlobalVariable Property SLV_PlayerIsCrawling auto

function SLV_CutJugs(Actor NPCActor)
if Game.GetModByName("SexLab Inflation Framework.esp") != 255
	SLIF_Main.inflate(NPCActor, "Slaverun Reloaded", "slif_breast", 0, -1, -1, "Slaverun_Reloaded")
endif

float fWeightOrig = NPCActor.GetActorBase().GetWeight()
SLV_PlayerBreastWeight.setValue(fWeightOrig)

SLV_SetNPCWeight(NPCActor , 0)
endFunction

function SLV_RestorePlayerJugs()
if Game.GetModByName("SexLab Inflation Framework.esp") != 255
	SLIF_Main.inflate(PlayerRef, "Slaverun Reloaded", "slif_breast", SLV_BreastSize.getvalue(), -1, -1, "Slaverun_Reloaded")
endif

float fWeightOrig = SLV_PlayerBreastWeight.getValue()

SLV_SetNPCWeight(PlayerRef, fWeightOrig)
endFunction
GlobalVariable Property SLV_PlayerBreastWeight auto

function SLV_GetMoreSubmissive(bool increase=true,int value=1)
if PlayerRef.IsInFaction(SlaverunSlaveFaction)
	SLV_IvanaMoodChange(increase,value)
elseif PlayerRef.IsInFaction(SlaverunSlaverFaction)
	SLV_PikeMoodChange(increase,value)
else
	SLV_FreeSubmissiveChange(increase,value)
endif
endFunction

function SLV_WonAnotherColosseumFight()
SLV_RewardPlayerWithGold()
endFunction

function SLV_WonAnotherArenaFight()
SLV_ArenaFightsWon.setValue(SLV_ArenaFightsWon.getValue() + 1)
SLV_RewardPlayerWithGold()

if deadslavewalking.getstage() == 3000
	deadslavewalking.SetObjectiveCompleted(3000)
	deadslavewalking.SetStage(3500)
endif

if SLV_IsArenaMaxLevelReached()
	SLV_ArenaChampion()
endif
EndFunction

function SLV_ArenaChampion()
if deadslavewalking.getstage() == 4500
	deadslavewalking.SetObjectiveCompleted(4500)

	if SLV_IsSlaveMaxLevelReached()
		deadslavewalking.SetStage(6000)
	else
		deadslavewalking.SetStage(5000)
	endif
endif
if deadslavewalking.getstage() == 5500
	deadslavewalking.SetObjectiveCompleted(5500)
	deadslavewalking.SetStage(6000)
endif
endFunction

function SLV_ProgressiveUnequip(Actor NPCActor, Actor NPCAggressor)
ActorBase NPCAggressorBase = NPCAggressor.getActorBase()
SLV_DisplayInformation("Starting SLV_ProgressiveUnequip: " + NPCAggressorBase.getName())

Form ArmorOrClothes = None
Form TitsOuterGarment = None
Form TitsUnderGarment = None
Form PussyOuterGarment = None
Form PussyUnderGarment = None
Form Helmet = None
Form FeetArmor = None
Form HandArmor = None
Form BracerArmor = None
Form LeftHand = None
Form RightHand = None

Helmet = NPCActor.GetWornForm(Armor.GetMaskForSlot(31)) 
if Helmet != none && MCMMenu.EnableUndressSlot30
	if SLV_StripThisArmor(Helmet, NPCActor)
		SLV_DisplayUser("Your helmet has been torn away by " + NPCAggressorBase.getName())
		return
	endif
endif
SLV_DisplayInformation("No helmet to remove")

ArmorOrClothes = NPCActor.GetWornForm(Armor.GetMaskForSlot(32)) 
if ArmorOrClothes != none && MCMMenu.EnableUndressSlot32
	if SLV_StripThisArmor(ArmorOrClothes, NPCActor)
		SLV_DisplayUser("Your body armor has been torn away by " + NPCAggressorBase.getName())
		return
	endif
endif
SLV_DisplayInformation("No armor to remove")

;TitsOuterGarment = NPCActor.GetWornForm(Armor.GetMaskForSlot(46))
;if TitsOuterGarment != none && MCMMenu.EnableUndressSlot46
;	if SLV_StripThisArmor(TitsOuterGarment, NPCActor)
;		SLV_DisplayUser("Your body armor has been torn away by " + NPCAggressorBase.getName())
;		return
;	endif
;endif
;TitsUnderGarment = NPCActor.GetWornForm(Armor.GetMaskForSlot(56))
;if TitsUnderGarment != none && MCMMenu.EnableUndressSlot56
;	if SLV_StripThisArmor(TitsUnderGarment, NPCActor)
;		SLV_DisplayUser("Your body armor has been torn away by " + NPCAggressorBase.getName())
;		return
;	endif
;endif
;PussyOuterGarment = NPCActor.GetWornForm(Armor.GetMaskForSlot(49)) 
;if PussyOuterGarment != none && MCMMenu.EnableUndressSlot49
;	if SLV_StripThisArmor(PussyOuterGarment, NPCActor)
;		SLV_DisplayUser("Your body armor has been torn away by " + NPCAggressorBase.getName())
;		return
;	endif
;endif
;PussyUnderGarment = NPCActor.GetWornForm(Armor.GetMaskForSlot(52)) 
;if PussyUnderGarment != none && MCMMenu.EnableUndressSlot52
;	if SLV_StripThisArmor(PussyUnderGarment, NPCActor)
;		SLV_DisplayUser("Your body armor has been torn away by " + NPCAggressorBase.getName())
;		return
;	endif
;endif
FeetArmor = NPCActor.GetWornForm(Armor.GetMaskForSlot(37))
if FeetArmor != none ;&& MCMMenu.EnableUndressSlot37
	if SLV_StripThisArmor(FeetArmor, NPCActor)
		SLV_DisplayUser("Your boots have been torn away by " + NPCAggressorBase.getName())
		return
	endif
endif
SLV_DisplayInformation("No boots to remove")

HandArmor = NPCActor.GetWornForm(Armor.GetMaskForSlot(33)) 
if HandArmor != none ;&& MCMMenu.EnableUndressSlot33
	if SLV_StripThisArmor(HandArmor, NPCActor)
		SLV_DisplayUser("Your hand armor has been torn away by " + NPCAggressorBase.getName())
		return
	endif
endif
SLV_DisplayInformation("No handarmor to remove")

BracerArmor = NPCActor.GetWornForm(Armor.GetMaskForSlot(34)) 
if BracerArmor != none ;&& MCMMenu.EnableUndressSlot34
	if SLV_StripThisArmor(BracerArmor, NPCActor)
		SLV_DisplayUser("Your bracer has been torn away by " + NPCAggressorBase.getName())
		return
	endif
endif
SLV_DisplayInformation("No bracer to remove")

LeftHand = NPCActor.GetEquippedObject(0)
if LeftHand != none && MCMMenu.EnableUndressLeftHand
	if SLV_StripThisWeapon(LeftHand, NPCActor)
		SLV_DisplayUser("Your left hand has been unarmed by " + NPCAggressorBase.getName())
		return
	endif
endif
SLV_DisplayInformation("No lefthand to remove")

RightHand = NPCActor.GetEquippedObject(1)
if RightHand != none && MCMMenu.EnableUndressRightHand
	if SLV_StripThisWeapon(RightHand, NPCActor)
		SLV_DisplayUser("Your right hand has been unarmed by " + NPCAggressorBase.getName())
		return
	endif
endif
SLV_DisplayInformation("No righthand to remove")


EndFunction

Bool Function SLV_StripThisArmor(Form ItemToStrip, Actor NPCActor)
if ItemToStrip.HasKeyword(ArmorCuirass) || ItemToStrip.HasKeyword(ArmorClothing) || ItemToStrip.HasKeyword(ClothingBody) || ItemToStrip.HasKeyword(ArmorHelmet) || ItemToStrip.HasKeyword(ArmorGauntlets)
	NPCActor.UnEquipItem(ItemToStrip, True, True)
	return true
else 
	return false
endif
EndFunction
Bool Function SLV_StripThisWeapon(Form ItemToStrip, Actor NPCActor)
if !ItemToStrip.HasKeyword(SexlabNoStrip)
	NPCActor.UnEquipItem(ItemToStrip, True, True)
	return true
else 
	return false
endif
EndFunction

Keyword Property SexlabNoStrip auto
Keyword Property ArmorClothing auto
Keyword Property ArmorCuirass auto
Keyword Property ClothingBody auto
Keyword Property ArmorHelmet auto
Keyword Property ArmorGauntlets auto
Keyword Property ArmorShield auto

; We check for specific types that would cover the sexy bits while allowing decorative items to remain. 
Bool Function SLV_CheckThisArmor(Form ItemToCheck)
if ItemTocheck == None
	return false;
endif
if ItemToCheck.HasKeyword(SexlabNoStrip)	; Don't remove anything marked as not stripable to Sexlab
	return false
endif
if ItemToCheck.HasKeyword(ArmorCuirass)|| ItemToCheck.HasKeyword(ArmorClothing) || ItemToCheck.HasKeyword(ClothingBody) || ItemToCheck.HasKeyword(ArmorHelmet)
	return true
endif
return false
EndFunction

Bool function SLV_TestCreatureAnimation2(Actor ActorCreature, int ActorCount, string Tags)
return SLV_Sex.SLV_TestCreatureAnimation2(ActorCreature, ActorCount, Tags)
EndFunction

Bool function SLV_TestCreatureAnimation(int ActorCount, string RaceKey)
return SLV_Sex.SLV_TestCreatureAnimation(ActorCount, RaceKey)
EndFunction

function SLV_PlaySexKissingSynchron(actor sexActor1, actor sexActor2)
SLV_Sex.SLV_PlaySexKissingSynchron(sexActor1, sexActor2)
EndFunction

function SLV_SetPlayerIsAVirgin()
if MCMMenu.useSexlabVirginity
	bool isVirgin = SLV_PlayerIsAVirgin()

	if isVirgin
		SLV_PlayerIsVirgin.setValue(1)
	else
		SLV_PlayerIsVirgin.setValue(0)
	endif
else
	SLV_PlayerIsVirgin.setValue(0)
endif
EndFunction
GlobalVariable Property SLV_PlayerIsVirgin Auto


function SLV_SetArousal(Actor NPCActor, int value)
int eid = ModEvent.Create("slaUpdateExposure")
ModEvent.PushForm(eid, NPCActor)
ModEvent.PushFloat(eid, value)
ModEvent.Send(eid)
EndFunction


int function SLV_GetPlayerSexSkill(String skillname)
return SLV_Sex.SLV_GetPlayerSexSkill(skillname)
endFunction


bool function SLV_PlayerIsAVirgin()
return SLV_Sex.SLV_PlayerIsAVirgin()
endFunction


function SLV_TravelPlayer(int destination)
if SLV_TourdeSkyrimQuest.IsCompleted()
	SLV_CarriageTravelPlayer(destination)
else
	SLV_WhiterunTravelPlayer(destination)
endif
endFunction
Quest Property SLV_TourdeSkyrimQuest Auto

function SLV_WhiterunTravelPlayer(int destination)
SLV_CarriageDestination.setvalue(destination)

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

SLV_PlayerMoveTo(SLV_WhiterunHorse)
SLV_PlaySex2Synchron(PlayerRef,SLV_WhiterunHorse, "Doggystyle", true)

SLV_DoTravelPlayer()
EndFunction
Actor Property SLV_WhiterunHorse Auto

function SLV_CarriageTravelPlayer(int destination)
SLV_CarriageDestination.setvalue(destination)

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

SLV_TravelQuest.Reset() 
SLV_TravelQuest.Start() 
SLV_TravelQuest.setactive(true) 
SLV_TravelQuest.SetStage(0)

;SLV_PlayerMoveTo(SLV_CarriageDriver.getactorref())
SLV_CarriageDriver.getactorref().moveto(onCartMarker)
PlayerRef.moveto(SLV_CarriageDriver.getactorref())
Utility.wait(1.0)
SLV_CarriageDriver.getactorref().moveto(onCartMarker)
Utility.wait(1.0)
SLV_CarriageDriver.getactorref().moveto(onCartMarker)
SLV_Play2SexAnimation(PlayerRef,SLV_CarriageDriver.getactorref(), "FunnyBizness Standing Anal", "Standing", true)
EndFunction
Quest Property SLV_TravelQuest Auto
GlobalVariable Property SLV_CarriageDestination Auto
ReferenceAlias Property SLV_CarriageDriver Auto
ObjectReference Property onCartMarker Auto

function SLV_DoTravelPlayer()
int destination = SLV_CarriageDestination.getvalue() as int
if destination == 1
	SLV_PlayerMoveTo(SLV_TravelDawnstar)
elseif destination == 2
	SLV_PlayerMoveTo(SLV_TravelFalkreath)
elseif destination == 3
	SLV_PlayerMoveTo(SLV_TravelMarkarth)
elseif destination == 4
	SLV_PlayerMoveTo(SLV_TravelMorthal)
elseif destination == 5
	SLV_PlayerMoveTo(SLV_TravelRiften)
elseif destination == 6
	SLV_PlayerMoveTo(SLV_TravelSolitude)
elseif destination == 7
	SLV_PlayerMoveTo(SLV_TravelWindhelm)
elseif destination == 8
	SLV_PlayerMoveTo(SLV_TravelWinterhold)
elseif destination == 9
	SLV_PlayerMoveTo(SLV_TravelWhiterun)
endif
EndFunction
ObjectReference Property SLV_TravelDawnstar Auto
ObjectReference Property SLV_TravelFalkreath Auto
ObjectReference Property SLV_TravelMarkarth Auto
ObjectReference Property SLV_TravelMorthal Auto
ObjectReference Property SLV_TravelRiften Auto
ObjectReference Property SLV_TravelSolitude Auto
ObjectReference Property SLV_TravelWindhelm Auto
ObjectReference Property SLV_TravelWinterhold Auto
ObjectReference Property SLV_TravelWhiterun Auto

function SLV_EndPlayerSlaver()
SLV_IsSlaveOfSlaverun.setvalue(0)
SLV_PlayerHasBeenASlaver.setvalue(1)

PlayerRef.RemoveFromFaction(SlaverunSlaveFaction)
PlayerRef.RemoveFromFaction(SlaverunSlaverFaction)
EndFunction

function SLV_FreePlayer()
SLV_IsSlaveOfSlaverun.setvalue(0)
SLV_PlayerHasBeenASlave.setvalue(1)

PlayerRef.RemoveFromFaction(SlaverunSlaveFaction)
PlayerRef.RemoveFromFaction(SlaverunSlaverFaction)
PlayerRef.RemoveFromFaction(SLV_Slave)
EndFunction

function SLV_FreeNPC(Actor NPCActor)
NPCActor.RemoveFromFaction(SlaverunSlaveFaction)
NPCActor.RemoveFromFaction(SlaverunSlaverFaction)
NPCActor.RemoveFromFaction(SLV_Slave)
EndFunction

function SLV_EnslavePlayer(bool hardmode=true,bool strip=true)
SLV_EnslavePlayer2(hardmode,strip,false)
EndFunction


function SLV_EnslavePlayer2(bool hardmode=true,bool strip=true,bool softmode=false)

if SLV_Sex.SLV_SexCount(PlayerRef) > 30
	SLV_PlayerIsaSlut.setvalue(1)
else
	SLV_PlayerIsaSlut.setvalue(0)
endif

SLV_Enslavement(strip)
if hardmode
	SLV_Hardmode.setvalue(1)
	SLV_IvanaMood.setvalue(0)
elseif softmode
	SLV_IvanaMood.setvalue(20)
else
	SLV_Hardmode.setvalue(0)
	SLV_IvanaMood.setvalue(5)
endif
SLV_IsSlaveOfSlaverun.setvalue(1)

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

SLV_EnslavePCQuest.Reset() 
SLV_EnslavePCQuest.Start() 
SLV_EnslavePCQuest.setactive(true) 
SLV_EnslavePCQuest.SetStage(0)

slaveroutfit.initSlaverSchlongs()

SLV_FamilyQuest.Reset() 
SLV_FamilyQuest.Start()
EndFunction
Quest Property SLV_EnslavePCQuest Auto
Quest Property SLV_FamilyQuest Auto
SLV_SlaverOutfit Property slaveroutfit auto
GlobalVariable Property SLV_IsSlaveOfSlaverun Auto
GlobalVariable Property SLV_PlayerIsaSlut Auto

function SLV_IvanaReset()
ActorUtil.ClearPackageOverride(SLV_Ivana.getactorref())
SLV_Ivana.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Ivana.GetActorRef(), SLV_WalktoDragonsReachCage,100)
SLV_Ivana.GetActorRef().evaluatePackage()
EndFunction
ReferenceAlias Property SLV_Ivana Auto
Package Property SLV_WalktoDragonsReachCage auto

function SLV_makePlayeraFuckingSlaveSlut()
Actor player = PlayerRef
if MCMMenu.BreastWeightGrowing
	SLV_SetPlayerWeight(10)
endif

SLV_SexlabStripNPC(player)
if MCMMenu.BreastWeightGrowing
	SLV_SetPlayerWeight(20)
endif

SLV_ypsEvents()
if MCMMenu.BreastWeightGrowing
	SLV_SetPlayerWeight(30)
endif

SlaveTats.simple_remove_tattoo(player , "Slutmarks", "Cunt (right cheek)", silent = true)
SlaveTats.simple_remove_tattoo(player , "Slave Marks", "Slave (left cheek)", silent = true)
SlaveTats.simple_remove_tattoo(player , "Slave Marks", "Slave (forehead)", silent = true)
SlaveTats.simple_remove_tattoo(player , "Slave Marks", "Slave (left hand)", silent = true)
SlaveTats.simple_remove_tattoo(player , "Slave Marks", "Slave (right hand)", silent = true)

SlaveTats.simple_add_tattoo(player , "Slutmarks", "Cunt (right cheek)", silent = true)
SlaveTats.simple_add_tattoo(player , "Slave Marks", "Slave (left cheek)", silent = true)
SlaveTats.simple_add_tattoo(player , "Slave Marks", "Slave (forehead)", silent = true)
SlaveTats.simple_add_tattoo(player , "Slave Marks", "Slave (left hand)", silent = true)
SlaveTats.simple_add_tattoo(player , "Slave Marks", "Slave (right hand)", silent = true)
if MCMMenu.BreastWeightGrowing
	SLV_SetPlayerWeight(40)
endif

StorageUtil.SetIntValue(none, "SlaverunTatooLevel", 9)
headshaving.RefreshProgressiveSlaveTats(player)
if MCMMenu.BreastWeightGrowing
	SLV_SetPlayerWeight(50)
endif

headshaving.Shave(player)
if MCMMenu.BreastWeightGrowing
	SLV_SetPlayerWeight(60)
endif		

headshaving.NextSlaveName(player)
if MCMMenu.BreastWeightGrowing
	SLV_SetPlayerWeight(80)
endif

SLV_equipDDChains(player)
if MCMMenu.BreastWeightGrowing
	SLV_SetPlayerWeight(100)
endif
EndFunction


function SLV_ypsEvents()
SendModEvent("yps-LockMakeupEvent")
SendModEvent("yps-PermanentMakeupEvent")
;Utility.wait(2.0)

;SendModEvent("yps-LipstickEvent", "Dark Red", 0x8b0000)  
SendModEvent("yps-LipstickEvent", "Black" , 0)  
Utility.wait(2.0)
    
SendModEvent("yps-EyeshadowEvent","Black" , 0)    
; apply makeup: send name of color as string (e.g. "red"), and ColorRGBCode as a 0xRRGGBB value.
Utility.wait(2.0)


SendModEvent("yps-FingerNailsEvent", "", 2) 
Utility.wait(2.0)

SendModEvent("yps-ToeNailsEvent",  "", 2)
Utility.wait(2.0)


SendModEvent("yps-PiercingEvent", playerRef.getActorBase().getName() ,1)
SendModEvent("yps-PiercingEvent", playerRef.getActorBase().getName() ,2)
SendModEvent("yps-PiercingEvent", playerRef.getActorBase().getName() ,3)
SendModEvent("yps-PiercingEvent", playerRef.getActorBase().getName() ,4)
SendModEvent("yps-PiercingEvent", playerRef.getActorBase().getName() ,5)
SendModEvent("yps-PiercingEvent", playerRef.getActorBase().getName() ,6)
SendModEvent("yps-PiercingEvent", playerRef.getActorBase().getName() ,7)
SendModEvent("yps-PiercingEvent", playerRef.getActorBase().getName() ,8)
SendModEvent("yps-PiercingEvent", playerRef.getActorBase().getName() ,9)
SendModEvent("yps-PiercingEvent", playerRef.getActorBase().getName() ,10)
SendModEvent("yps-PiercingEvent", playerRef.getActorBase().getName() ,11)

EndFunction

function SLV_Notifications()
if PlayerRef.IsInFaction(SlaverunSlaveFaction)
	int ivanamood = SLV_IvanaMood.getValue() as int
	int brutusmood = SLV_BrutusMood.getValue() as int
	
	String enslavementtext = "not set"
	Float enslavementdate = StorageUtil.GetFloatValue(None, "SLV_PlayerSlaveTime", 0.0 )
	if enslavementdate != 0.0
		;MiscUtil.PrintConsole("Reportdate:" + enslavementdate)
		Float currentdate = Utility.GetCurrentGameTime()
	
		Float Time = currentdate - enslavementdate
		Int Std = Math.Floor(Time)
		;MiscUtil.PrintConsole("Std:" + Std)
		Time = Time - Std
		;Time = ((Time / 5)*3)
		Int IntTime = Math.Floor(Time*24.0)
		;Time = Time + "d" + " " + Std * "h"
		;MiscUtil.PrintConsole("Time:" + Time)
		enslavementtext = Std + "d " + IntTime + "h"
	endif
	int rapecounter = SLV_SlaveSexCounter.getValue() as int
	SLV_DisplayUser("You are a slave for " + enslavementtext + " and have been raped " + rapecounter + " times.")
	
	if (ivanamood == 0) 
		SLV_DisplayUser("You are the most rebellious slave ever (" + ivanamood + "/20)")
	elseif (ivanamood < 5)
		SLV_DisplayUser("You are a very rebellious slave (" + ivanamood + "/20)")
	elseif (ivanamood < 10)
		SLV_DisplayUser("You still dream to be free some day (" + ivanamood + "/20)")
	elseif (ivanamood < 15)
		SLV_DisplayUser("You slowely learn to obey and accept your fate (" + ivanamood + "/20)")
	elseif (ivanamood < 20)
		SLV_DisplayUser("You love to obey your Master (" + ivanamood + "/20)")
	else
		SLV_DisplayUser("You are a perfect slave, submissive and born to be a slut (" + ivanamood + "/20)")
	endif
	
	if (brutusmood == 0) 
		SLV_DisplayUser("You hate Master Bellamy with all your heart (" + brutusmood + "/20)")
	elseif (brutusmood < 5)
		SLV_DisplayUser("Maybe Master Bellamy is not so bad at all (" + brutusmood + "/20)")
	elseif (brutusmood < 10)
		SLV_DisplayUser("You start to like Master Bellamy more and more (" + brutusmood + "/20)")
	elseif (brutusmood < 15)
		SLV_DisplayUser("You have a crush for sweet Master Bellamy (" + brutusmood + "/20)")
	elseif (brutusmood < 20)
		SLV_DisplayUser("You fell in love with Master Bellamy (" + brutusmood + "/20)")
	else
		SLV_DisplayUser("You're absolutely in love with Master Bellamy (" + brutusmood + "/20)")
	endif
	SLV_ReportBackNotification()
	
elseif PlayerRef.IsInFaction(SlaverunSlaverFaction)
	int pikemood = SLV_PikeMood.getValue() as int
		
	if (pikemood == 0) 
		SLV_DisplayUser("You are ruthless and brutal, the perfect slaver (" + pikemood + "/20)")
	elseif (pikemood < 10)
		SLV_DisplayUser("Maybe you are not so ruthless as slaver should be (" + pikemood + "/20)")
	elseif (pikemood < 20)
		SLV_DisplayUser("You love to be dominated and abused. Unusual for a slaver (" + pikemood + "/20)")
	else
		SLV_DisplayUser("You're the most submissive and sluttiest slaver ever (" + pikemood + "/20)")
	endif
	
	if SLV_PlayerHasToReport.getvalue() > 0
		SLV_ReportBackNotification()
	endif
else
	int freeSubmissive = SLV_FactionFreeSubmissive.getValue() as int
	;if (freeSubmissive < 10) 
		;SLV_DisplayUser("You are a free woman, be proud of it as long as you can.")
	;elseif (freeSubmissive < 20)
		;SLV_DisplayUser("You're still free, but also more submissive than you thought (" + freeSubmissive + "/20)")
	;else
		;SLV_DisplayUser("You're still free, but your desire to be enslaved is so strong (" + freeSubmissive + "/20)")
	;endif
	
	if(freeSubmissive >= 20)
		Debug.notification("You're still free, but no women has ever been more submissive than you.")
		Utility.wait(1.0)
		Debug.notification("Someone will enslave you soon for sure (" + freeSubmissive + "/20)")
	elseif(freeSubmissive >= 15)
		Debug.notification("You're still free, but you started dreaming about being a slave.")
		Utility.wait(1.0)
		Debug.notification("Maybe being a slave would't be so bad. (" + freeSubmissive + "/20)")
	elseif(freeSubmissive >= 10)
		Debug.notification("You're still free, but your resistance again being enslaved has weakened.")
		Utility.wait(1.0)
		Debug.notification("You would look so good... with a slave collar and in leather devices. (" + freeSubmissive + "/20)")
	elseif(freeSubmissive >= 5)
		Debug.notification("You're still a free woman, be proud of it as long as you can.")
		Utility.wait(1.0)
		Debug.notification("Maybe? No... but thinking about slavery makes you wet. (" + freeSubmissive + "/20)")
	else
		Debug.notification("You are a free woman, be proud of it as long as you can.")
		if SLV_Main.getstage() >= 1000
			Utility.wait(1.0)
			Debug.notification("Thinking about being enslaved fills you with horror. (" + freeSubmissive + "/20)")
		endif
	endif
	
	String enslavetext = "not set"
	Float enslavedate = StorageUtil.GetFloatValue(None, "SLV_EnslavingHours", 0.0 )
	if enslavedate != 0.0 && MCMMenu.AutoProgression
		Float currentdate = Utility.GetCurrentGameTime()
		Float Time = enslavedate - currentdate
		Int Std = Math.Floor(Time)
		;MiscUtil.PrintConsole("Std:" + Std)
		Time = Time - Std
		;Time = ((Time / 5)*3)
		Int IntTime = Math.Floor(Time*24.0)
		;Time = Time + "d" + " " + Std * "h"
		;MiscUtil.PrintConsole("Time:" + Time)
		enslavetext = enslavedate - currentdate
		enslavetext = Std + "d " + IntTime + "h"
		SLV_DisplayUser("Time left until next city enslavement " + enslavetext)
		;MiscUtil.PrintConsole("Currentdate:" + currentdate)
	endif	
	
	if SLV_PlayerHasToReport.getvalue() > 0
		SLV_ReportBackNotification()
	endif
endif
EndFunction
GlobalVariable Property SLV_SlaveSexCounter Auto
GlobalVariable Property SLV_PlayerHasToReport Auto

Function SLV_ReportBackNotification()
String reporttext = "not set"
Float reportdate = StorageUtil.GetFloatValue(None, "SLV_ReportBackHours", 0.0 )
;MiscUtil.PrintConsole("Reportdate:" + reportdate)
Float currentdate = Utility.GetCurrentGameTime()

Float Time = reportdate - currentdate
if Time >= 0.0  && MCMMenu.ForceReporting
	Int Std = Math.Floor(Time)
	;MiscUtil.PrintConsole("Std:" + Std)
	Time = Time - Std
	;Time = ((Time / 5)*3)
	Int IntTime = Math.Floor(Time*24.0)
	;Time = Time + "d" + " " + Std * "h"
	;MiscUtil.PrintConsole("Time:" + Time)
	reporttext = reportdate - currentdate
	reporttext = Std + "d " + IntTime + "h"
	SLV_DisplayUser("Time left to report back : " + reporttext)
	;MiscUtil.PrintConsole("Currentdate:" + currentdate)
endif
endFunction

function SLV_BreastMode()
softDependency.weightmode = false
SLV_WeightGain.setvalue(0)

if JsonUtil.GetIntValue("../Slaverun/SlaverunConfig.json", "weightmode" ,0 ) == 1 || MCMMenu.BreastGrowing
	softDependency.weightmode = true
	SLV_WeightGain.setvalue(1)
endif
EndFunction
GlobalVariable Property SLV_WeightGain Auto


function SLV_InflationFramework(Actor NPCActor, float size)
SLV_BreastSize.SetValue(size)
if Game.GetModByName("SexLab Inflation Framework.esp") != 255
	SLIF_Main.inflate(NPCActor, "Slaverun Reloaded", "slif_breast", size, -1, -1, "Slaverun_Reloaded")
endif
EndFunction
			

function SLV_PlayScene(Scene SLV_Scene)
if MCMMenu.SkipScenes
	return
endif

SLV_You.getActorRef().moveto(PlayerRef)
SLV_You.getActorRef().getActorBase().setName(PlayerRef.getActorBase().getName())
;SLV_You.getActorRef().disable()
;SLV_You.getActorRef().AllowPCDialogue(false)
SendModEvent("dhlp-Suspend")

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
SLV_Scene.ForceStart()
endfunction
ReferenceAlias Property SLV_You Auto

function SLV_StopScene()
debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")
endfunction



function SLV_SetPlayerWeight(float newWeight)
float fWeightOrig = PlayerRef.GetActorBase().GetWeight()
if newWeight >= 0
	PlayerRef.GetActorBase().SetWeight(newWeight)
else
	newWeight = fWeightOrig
endif
Float NeckDelta = (fWeightOrig / 100) - (newWeight / 100) ;Work out the neckdelta.
PlayerRef.UpdateWeight(NeckDelta)
endFunction

function SLV_SetNPCWeight(Actor actorNPC, float newWeight)
float fWeightOrig = actorNPC.GetActorBase().GetWeight()
if newWeight >= 0
	actorNPC.GetActorBase().SetWeight(newWeight)
else
	newWeight = fWeightOrig
endif
Float NeckDelta = (fWeightOrig / 100) - (newWeight / 100) ;Work out the neckdelta.
actorNPC.UpdateWeight(NeckDelta)
endFunction


function SLV_decreaseWeight()
if MCMMenu.BreastGrowing
	if MCMMenu.BreastWeightGrowing
		float fWeightOrig = PlayerRef.GetActorBase().GetWeight()
		float fWeight = fWeightOrig - 5
		if fWeightOrig - 5 > 0
			PlayerRef.GetActorBase().SetWeight(fWeightOrig - 5)
		else
			PlayerRef.GetActorBase().SetWeight(0)
			fWeight = 0.0
		endif
		SLV_DisplayUser("You feel weaker.")
		SLV_DisplayInformation("You lost some weight (" + fWeight + ")")
		;PlayerRef.QueueNiNodeUpdate()
		Float NeckDelta = (fWeightOrig / 100) - (fWeight / 100) ;Work out the neckdelta.
		PlayerRef.UpdateWeight(NeckDelta)
		
		SLV_AdvanceBoobsQuest(fWeight)
	endif
	
	
	if MCMMenu.BreastSLIFGrowing
		if MCMMenu.BreastSLIFDelta
			SLIF_Delta = MCMMenu.BreastSLIFDelta
		endif
		float fWeightOrig = SLV_BreastSize.getValue() as float
		float fWeight = fWeightOrig - SLIF_Delta
		if fWeightOrig - SLIF_Delta > 1.0
			SLV_BreastSize.SetValue(fWeightOrig - SLIF_Delta)
		else
			SLV_BreastSize.SetValue(1.0)
			fWeight = 1.0
		endif
		SLV_InflationFramework(PlayerRef, fWeight)
		MCMMenu.BreastSLIFSize = fWeight
		SLV_AdvanceBoobsQuest(fWeight*10)
	endif
endif
endfunction
GlobalVariable Property SLV_BreastSize Auto


function SLV_CheatMode()
softDependency.testmode = false
if JsonUtil.GetIntValue("../Slaverun/SlaverunConfig.json", "testmode" ,0 ) == 1 || MCMMenu.CheatsEnabled
	SLV_DisplayUser("Slaverun testmode activated")
	softDependency.testmode = true
endif
EndFunction


function SLV_Gangbang(actor[] sexActorsList)
if SLV_CheckforSexTag(5,"MMMMF") && sexActorsList.Length == 5
	actor[] sexActors = new actor[5]
	sexActors[0] = sexActorsList[0]
	sexActors[1] = sexActorsList[1]
	sexActors[2] = sexActorsList[2]
	sexActors[3] = sexActorsList[3]
	sexActors[4] = sexActorsList[4]
	
	SLV_PlaySexSynchron(sexActors,"MMMMF", true)
elseif SLV_CheckforSexTag(4,"MMMF") && sexActorsList.Length == 4
	actor[] sexActors = new actor[4]
	sexActors[0] = sexActorsList[0]
	sexActors[1] = sexActorsList[1]
	sexActors[2] = sexActorsList[2]
	sexActors[3] = sexActorsList[3]
	
	SLV_PlaySexSynchron(sexActors,"MMMF", true)
elseif SLV_CheckforSexTag(3,"MMF") && sexActorsList.Length == 3
	actor[] sexActors = new actor[3]
	sexActors[0] = sexActorsList[0]
	sexActors[1] = sexActorsList[1]
	sexActors[2] = sexActorsList[2]

	SLV_PlaySexSynchron(sexActors,"MMF", true)
else
	SLV_PlaySex2Synchron(sexActorsList[0], sexActorsList[1], "Sex", true)
endif
EndFunction


function SLV_CreatureGangbang(actor[] sexActorsList, string Tags, bool splitGroups= true)
Actor creatureActor = sexActorsList[1]
SLV_DisplayInformation("Gangbang with creature race: " + creatureActor.getActorBase().getRace().getName())

if sexActorsList.Length == 5
	if SLV_TestCreatureAnimation2(creatureActor, 5, Tags)
		actor[] sexActors = new actor[5]
		sexActors[0] = sexActorsList[0]
		sexActors[1] = sexActorsList[1]
		sexActors[2] = sexActorsList[2]
		sexActors[3] = sexActorsList[3]
		sexActors[4] = sexActorsList[4]
		
		SLV_PlaySexSynchron(sexActors, Tags, true)
	else 
		SLV_DisplayInformation("No animation with actor and 4 creatures found")
		actor[] sexActors1 = new actor[4]
		sexActors1[0] = sexActorsList[0]
		sexActors1[1] = sexActorsList[1]
		sexActors1[2] = sexActorsList[2]
		sexActors1[3] = sexActorsList[3]
		SLV_CreatureGangbang(sexActors1, Tags,splitGroups)
		
		if splitGroups
			actor[] sexActors2 = new actor[2]
			sexActors2[0] = sexActorsList[0]
			sexActors2[1] = sexActorsList[4]
			SLV_CreatureGangbang(sexActors2, Tags,splitGroups)
		endif
	endif
	
elseif sexActorsList.Length == 4
	if SLV_TestCreatureAnimation2(creatureActor, 4, Tags)
		actor[] sexActors = new actor[4]
		sexActors[0] = sexActorsList[0]
		sexActors[1] = sexActorsList[1]
		sexActors[2] = sexActorsList[2]
		sexActors[3] = sexActorsList[3]
		
		SLV_PlaySexSynchron(sexActors, Tags, true)
	else 
		SLV_DisplayInformation("No animation with actor and 3 creatures found")
		actor[] sexActors1 = new actor[3]
		sexActors1[0] = sexActorsList[0]
		sexActors1[1] = sexActorsList[1]
		sexActors1[2] = sexActorsList[2]
		SLV_CreatureGangbang(sexActors1, Tags,splitGroups)
		
		if splitGroups
			actor[] sexActors2 = new actor[2]
			sexActors2[0] = sexActorsList[0]
			sexActors2[1] = sexActorsList[3]
			SLV_CreatureGangbang(sexActors2, Tags,splitGroups)
		endif
	endif
	
elseif sexActorsList.Length == 3
	if SLV_TestCreatureAnimation2(creatureActor, 3, Tags)
		actor[] sexActors = new actor[3]
		sexActors[0] = sexActorsList[0]
		sexActors[1] = sexActorsList[1]
		sexActors[2] = sexActorsList[2]
		
		SLV_PlaySexSynchron(sexActors, Tags, true)
	else 
		SLV_DisplayInformation("No animation with actor and 2 creatures found")
		actor[] sexActors1 = new actor[2]
		sexActors1[0] = sexActorsList[0]
		sexActors1[1] = sexActorsList[1]
		SLV_CreatureGangbang(sexActors1, Tags,splitGroups)
		
		if splitGroups
			actor[] sexActors2 = new actor[2]
			sexActors2[0] = sexActorsList[0]
			sexActors2[1] = sexActorsList[2]
			SLV_CreatureGangbang(sexActors2, Tags,splitGroups)
		endif
	endif
else	
	if SLV_TestCreatureAnimation2(creatureActor, 2, Tags)
		SLV_PlaySex2Synchron(sexActorsList[0], sexActorsList[1], Tags, true)
	else
		SLV_DisplayInformation("No Animation with actor and this creature found")
	endif
endif
EndFunction

function SLV_SchlongSize(Actor NPCActor, int size)
sosSchlong.SLV_SchlongSize(NPCActor, size)
EndFunction

function SLV_SlaverSchlong(Actor NPCActor)
sosSchlong.SLV_SlaverSchlong(NPCActor)
EndFunction

function SLV_IncleaseSchlong(Actor NPCActor)
sosSchlong.SLV_IncleaseSchlong(NPCActor)
EndFunction

int function SLV_GetSchlongSize(Actor NPCActor)
return sosSchlong.SLV_GetSchlongSize(NPCActor)
EndFunction
SLV_SOSSchlong Property sosSchlong Auto

function SLV_SexlabStripNPC(Actor NPCActor)
SLV_Sex.SLV_SexlabStrip(NPCActor, true)
EndFunction

function SLV_SexlabStripNPC2(Actor NPCActor, bool animated)
SLV_Sex.SLV_SexlabStrip(NPCActor, animated)
EndFunction


function SLV_PrepareForTattoo(Actor NPCActor)
SLV_SexlabStripNPC(NPCActor)

SLV_DeviousUnEquipActor(NPCActor, true, false, true, true, true, false, false, true, true, false, false, false, false, false, true)
EndFunction

function SLV_RewardPlayer(ReferenceAlias SLV_SlaveMaster1,ReferenceAlias SLV_SlaveMaster2)
SLV_miniLevelUp()
if MCMMenu.SkipScenes || MCMMenu.SkipBranding
	return
endif
SLV_BrandPlayer(SLV_SlaveMaster1,SLV_SlaveMaster2)
EndFunction

function SLV_BrandPlayer(ReferenceAlias SLV_SlaveMaster1,ReferenceAlias SLV_SlaveMaster2)
bool brandingDevice
bool slaveTatoos
if Game.GetModByName("BrandingDeviceOfDoom.esp")!= 255
	brandingDevice = true
else
	brandingDevice = false
endif

if Game.GetModByName("SlaveTats.esp")!= 255
	slaveTatoos = true
else
	slaveTatoos = false  
endif

SLV_Slaver1.ForceRefTo(SLV_SlaveMaster1.getActorRef())
;Debug.notification("New SLV_Slaver1= " + SLV_Slaver1.getActorRef().getActorBase().getName())
SLV_Slaver2.ForceRefTo(SLV_SlaveMaster2.getActorRef())
;Debug.notification("New SLV_Slaver2= " + SLV_Slaver2.getActorRef().getActorBase().getName())

SLV_You.getActorRef().moveto(PlayerRef)

if brandingDevice && MCMMenu.SlaveTatoos
	if !MCMMenu.SkipBranding
		SendModEvent("dhlp-Suspend")
		game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
		game.SetPlayerAIDriven(true)

	
		ActorUtil.AddPackageOverride(SLV_SlaveMaster1.GetActorRef(), SLV_Follow ,100)
		SLV_SlaveMaster1.GetActorRef().evaluatePackage()
		ActorUtil.AddPackageOverride(SLV_SlaveMaster2.GetActorRef(), SLV_Follow ,100)
		SLV_SlaveMaster2.GetActorRef().evaluatePackage()
		SLV_SlaveMaster2.getActorRef().moveto(SLV_SlaveMaster1.getActorRef())

		;Debug.notification("Start Branding")
		PunishSceneBranding.Start()
	else
		headshaving.NextProgressiveSlaveTats(PlayerRef)
	endif
elseif slaveTatoos && MCMMenu.SlaveTatoos
	SendModEvent("dhlp-Suspend")
	game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
	game.SetPlayerAIDriven(true)

	PunishSceneTattoo.Start()
else
	SendModEvent("dhlp-Suspend")
	game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
	game.SetPlayerAIDriven(true)

	PunishSceneRape.Start()
endif
EndFunction
Scene Property PunishSceneBranding  Auto
Scene Property PunishSceneTattoo  Auto
Scene Property PunishSceneRape  Auto

ReferenceAlias Property SLV_Slaver1 Auto
ReferenceAlias Property SLV_Slaver2 Auto 




function SLV_PikeMoodChange(bool increase=true,int value=1)
if !PlayerRef.IsInFaction(SlaverunSlaverFaction)
	return
endif

int pikemood = SLV_PikeMood.getValue() as int
if(increase)
	pikemood = pikemood + value;
	if(pikemood >= 20)
		pikemood = 20
		Debug.notification("You are the most submissive and slutty slaver ever.")
		Utility.wait(1.0)
		Debug.notification("You can't get any more submissive.")
		Utility.wait(1.0)
		Debug.notification("Maybe someone will enslave you soon and you would enjoy it.")
	else
		Debug.notification("You seem to be more submissive than you thought.")
		Utility.wait(1.0)
		Debug.notification("Maybe you would be a good slave slut?")
	endif
else
	pikemood = pikemood - value;
	if(pikemood <= 0)
		pikemood = 0
		Debug.notification("You love to humiliate and torture your slaves.")
		Utility.wait(1.0)
		Debug.notification("Well done, slaver!")
	else
		Debug.notification("You like to humiliate your slaves.")
		Utility.wait(1.0)
		Debug.notification("Well done, slaver!")
	endif
endif

SLV_PikeMood.setValue(pikemood)
endFunction
GlobalVariable Property SLV_PikeMood Auto

function SLV_FreeSubmissiveChange(bool increase=true,int value=1)
if PlayerRef.IsInFaction(SlaverunSlaveFaction) || PlayerRef.IsInFaction(SlaverunSlaverFaction)
	return
endif

int freeSubmissive = SLV_FactionFreeSubmissive.getValue() as int
if(increase)
	freeSubmissive = freeSubmissive + value;
	if(freeSubmissive >= 20)
		freeSubmissive = 20
		Debug.notification("No women has ever been more submissive than you.")
		Utility.wait(1.0)
		Debug.notification("Someone will enslave you soon for sure.")
	elseif(freeSubmissive >= 15)
		Debug.notification("Your resistance again being enslaved weakens even more.")
		Utility.wait(1.0)
		Debug.notification("Maybe being a slave would't be so bad.")
	elseif(freeSubmissive >= 10)
		Debug.notification("Your resistance again being enslaved weakens again.")
		Utility.wait(1.0)
		Debug.notification("You would look so good... with a slave collar and in leather devices.")
	elseif(freeSubmissive >= 5)
		Debug.notification("Your resistance again being enslaved weakens.")
		Utility.wait(1.0)
		Debug.notification("Maybe? No... but thinking about slavery makes you wet.")
	else
		Debug.notification("Your resistance again being enslaved weakens a little bit.")
		Utility.wait(1.0)
		Debug.notification("But thinking about being enslaved fills you with horror.")
	endif
else
	freeSubmissive = freeSubmissive - value;
	if(freeSubmissive < 0)
		freeSubmissive = 0
	endif
	Debug.notification("You still resist the slavers and insult them.")
	Utility.wait(1.0)
	Debug.notification("Do you really think you will stay free forever?")
endif

SLV_FactionFreeSubmissive.setValue(freeSubmissive)
endFunction
GlobalVariable Property SLV_FactionFreeSubmissive Auto

function SLV_IvanaMoodChange(bool increase=true,int value=1)
if !PlayerRef.IsInFaction(SlaverunSlaveFaction)
	return
endif

int ivanamood = SLV_IvanaMood.getValue() as int
if(increase)
	ivanamood = ivanamood + value;
	if(ivanamood >= 20)
		ivanamood = 20
		Debug.notification("You obey your Master and feel happy.")
		Utility.wait(1.0)
		Debug.notification("But you can't get any more submissive.")
		Utility.wait(1.0)
		Debug.notification("You are the best trained slave slut already.")
	else
		Debug.notification("You obey your Master and become more submissive.")
		Utility.wait(1.0)
		Debug.notification("Oh you will be a good slave slut.")
	endif
else
	ivanamood = ivanamood - value;
	if(ivanamood < 0)
		ivanamood = 0
	endif
	Debug.notification("You still resist your Slave Master.")
	Utility.wait(1.0)
	Debug.notification("Do you really think you can get free again?")
endif

SLV_IvanaMood.setValue(ivanamood)
endFunction
GlobalVariable Property SLV_IvanaMood Auto


function SLV_BrutusMoodChange(bool increase=true,int value=1)
int brutusmood = SLV_BrutusMood.getValue() as int
if(increase)
	brutusmood = brutusmood + value;
	if(brutusmood >= 20)
		brutusmood = 20
		Debug.notification("You are already in deepest love with Master Bellamy.")
		SLV_PlayerLovesBellamy.setvalue(1)
	else
		Debug.notification("Your seem to fall more and more in love with Master Bellamy.")
	endif
else
	brutusmood = brutusmood - value;
	if(brutusmood < 0)
		brutusmood = 0
		Debug.notification("You totaly hate your Slave Master Bellamy's guts.")
	else
		Debug.notification("Your dislike for your handsome Slave Master Bellamy grows.")
	endif
endif

if (brutusmood == 0) 
	SLV_Bellamy.GetActorReference().SetRelationshipRank(PlayerRef, -1)
elseif (brutusmood < 5)
	SLV_Bellamy.GetActorReference().SetRelationshipRank(PlayerRef, 0)
elseif (brutusmood < 10)
	SLV_Bellamy.GetActorReference().SetRelationshipRank(PlayerRef, 1)
elseif (brutusmood < 15)
	SLV_Bellamy.GetActorReference().SetRelationshipRank(PlayerRef, 2)
elseif (brutusmood < 20)
	SLV_Bellamy.GetActorReference().SetRelationshipRank(PlayerRef, 3)
else
	SLV_Bellamy.GetActorReference().SetRelationshipRank(PlayerRef, 4)
endif

SLV_BrutusMood.setValue(brutusmood)
endFunction
GlobalVariable Property SLV_BrutusMood Auto
GlobalVariable Property SLV_PlayerLovesBellamy Auto
ReferenceAlias Property SLV_Bellamy Auto


Bool function SLV_CheckForSexTag(int ActorCount, string tags)
return SLV_Sex.SLV_CheckForSexTag(ActorCount,tags)
endFunction

Bool function SLV_CheckForSexAnimation(string animation)
return SLV_Sex.SLV_CheckForSexAnimation(animation)
endFunction

function SLV_PlaySexSynchron(actor[] sexActors, string tag, bool rape=true)
SLV_Sex.SLV_PlaySexSynchron(sexActors,tag,rape)
endFunction
function SLV_PlaySexAnimationSynchron(actor[] sexActors, string animation, string tag, bool rape=true)
SLV_Sex.SLV_PlaySexAnimationSynchron(sexActors,animation, tag,rape)
endFunction

function SLV_PlaySex2AnimationSynchron(actor sexActor1, actor sexActor2, string animation, string tag, bool rape=true)
actor[] sexActors = new actor[2]
sexActors[0] = sexActor1
sexActors[1] = sexActor2
SLV_Sex.SLV_PlaySexAnimationSynchron(sexActors,animation, tag,rape)
endFunction

function SLV_PlaySex3AnimationSynchron(actor sexActor1, actor sexActor2, actor sexActor3, string animation, string tag, bool rape=true)
actor[] sexActors = new actor[3]
sexActors[0] = sexActor1
sexActors[1] = sexActor2
sexActors[2] = sexActor3
SLV_Sex.SLV_PlaySexAnimationSynchron(sexActors,animation, tag,rape)
endFunction

function SLV_PlaySex2Synchron(actor sexActor1, actor sexActor2, string tag, bool rape=true)
actor[] sexActors = new actor[2]
sexActors[0] = sexActor1
sexActors[1] = sexActor2
SLV_Sex.SLV_PlaySexSynchron(sexActors,tag,rape)
endFunction
function SLV_PlaySex3Synchron(actor sexActor1, actor sexActor2, actor sexActor3, string tag, bool rape=true)
actor[] sexActors = new actor[3]
sexActors[0] = sexActor1
sexActors[1] = sexActor2
sexActors[2] = sexActor3
SLV_Sex.SLV_PlaySexSynchron(sexActors,tag,rape)
endFunction

function SLV_PlaySex(actor[] sexActors, string tag, bool rape=true)
SLV_Sex.SLV_PlaySex(sexActors,tag,rape)
endFunction
function SLV_PlaySexAnimation(actor[] sexActors, string animation, string tag, bool rape=true)
SLV_Sex.SLV_PlaySexAnimation(sexActors,animation, tag,rape)
endFunction

function SLV_Play2SexAnimation(actor sexActor1, actor sexActor2, string animation, string tag, bool rape=true)
actor[] sexActors = new actor[2]
sexActors[0] = sexActor1
sexActors[1] = sexActor2
SLV_Sex.SLV_PlaySexAnimation(sexActors, animation, tag,rape)
endFunction

function SLV_Play2Sex(actor sexActor1, actor sexActor2, string tag, bool rape=true)
actor[] sexActors = new actor[2]
sexActors[0] = sexActor1
sexActors[1] = sexActor2
SLV_Sex.SLV_PlaySex(sexActors,tag,rape)
endFunction
function SLV_Play3Sex(actor sexActor1, actor sexActor2, actor sexActor3, string tag, bool rape=true)
actor[] sexActors = new actor[3]
sexActors[0] = sexActor1
sexActors[1] = sexActor2
sexActors[2] = sexActor3
SLV_Sex.SLV_PlaySex(sexActors,tag,rape)
endFunction
SLV_Sexlab Property SLV_Sex Auto

function SLV_bigLevelDown()
if PlayerRef.IsInFaction(SlaverunSlaveFaction)
	SLV_decreaseWeight()
	SLV_decreaseWeight()
	
	headshaving.RemoveProgressiveSlaveTats(PlayerRef)
	headshaving.RemoveProgressiveSlaveTats(PlayerRef)
	headshaving.RemoveProgressiveSlaveTats(PlayerRef)
	headshaving.RemoveProgressiveSlaveTats(PlayerRef)

	SLV_decreaseWeight()
	SLV_decreaseWeight()
	headshaving.RemoveProgressiveSlaveTats(PlayerRef)
	headshaving.RemoveProgressiveSlaveTats(PlayerRef)
else
	PlayerRef.AddItem(Gold, 5000)
endif
endfunction
function SLV_miniLevelDown()
if PlayerRef.IsInFaction(SlaverunSlaveFaction)
	headshaving.RemoveProgressiveSlaveTats(PlayerRef)

	SLV_decreaseWeight()
	SLV_decreaseWeight()
else
	PlayerRef.AddItem(Gold, 100)
endif
endfunction

function SLV_miniLevelUp()
if PlayerRef.IsInFaction(SlaverunSlaveFaction)
	if MCMMenu.SkipScenes || MCMMenu.SkipBranding
		headshaving.NextProgressiveSlaveTats(PlayerRef)
	endif
	SLV_BoobGrowing()
else
	PlayerRef.AddItem(Gold, 500)
endif
endfunction
MiscObject Property Gold Auto  
SLV_SoftDependency Property softdependency auto
SLV_HeadShaving Property headshaving auto
Faction Property SlaverunSlaveFaction auto



function SLV_BoobGrowing()
;Debug.Notification("weightMode " + softdependency.weightMode)

;Debug.Notification("BreastGrowing " + MCMMenu.BreastGrowing)

if MCMMenu.BreastGrowing
	;Debug.Notification("BreastWeightGrowing " + MCMMenu.BreastWeightGrowing)
	if MCMMenu.BreastWeightGrowing
		float fWeightOrig = PlayerRef.GetActorBase().GetWeight()
		float fWeight = fWeightOrig + 5
		if fWeightOrig + 5 < 100
			PlayerRef.GetActorBase().SetWeight(fWeightOrig + 5)
		else
			PlayerRef.GetActorBase().SetWeight(100)
			fWeight = 100.0
		endif
		;PlayerRef.QueueNiNodeUpdate()
		Float NeckDelta = (fWeightOrig / 100) - (fWeight / 100) ;Work out the neckdelta.
		PlayerRef.UpdateWeight(NeckDelta) 
		
		SLV_AdvanceBoobsQuest(fWeight)
	endif
	
	;Debug.Notification("BreastSLIFGrowing " + MCMMenu.BreastSLIFGrowing)
	if MCMMenu.BreastSLIFGrowing
		if MCMMenu.BreastSLIFDelta
			SLIF_Delta = MCMMenu.BreastSLIFDelta
		endif
		float fWeightOrig = SLV_BreastSize.getValue() as float
		float increaseBoobs = SLIF_Delta
		float fWeight = fWeightOrig + increaseBoobs
		if fWeightOrig + increaseBoobs < 10.0
			SLV_BreastSize.SetValue(fWeightOrig + increaseBoobs)
		else
			SLV_BreastSize.SetValue(10.0)
			fWeight = 10.0
		endif

		SLV_InflationFramework(PlayerRef, fWeight)
		MCMMenu.BreastSLIFSize = fWeight
		SLV_AdvanceBoobsQuest(fWeight*10)
	endif
endif
endfunction


Function SLV_AdvanceBoobsQuest(float fWeight)
if !SLV_BabyGotBoobsQuest.isRunning()
	return
endif

SLV_BabyGotBoobsQuest.SetObjectiveCompleted(SLV_BabyGotBoobsQuest.getStage())

if fWeight >= 5.0 && fWeight <10
	SLV_BabyGotBoobsQuest.setstage(50)
endif
if fWeight >= 10.0 && fWeight <15
	SLV_BabyGotBoobsQuest.setstage(100)
endif
if fWeight >= 15.0 && fWeight <20
	SLV_BabyGotBoobsQuest.setstage(150)
endif
if fWeight >= 20.0 && fWeight <25
	SLV_BabyGotBoobsQuest.setstage(200)
endif
if fWeight >= 25.0 && fWeight <30
	SLV_BabyGotBoobsQuest.setstage(250)
endif
if fWeight >= 30.0 && fWeight <35
	SLV_BabyGotBoobsQuest.setstage(300)
endif
if fWeight >= 35.0 && fWeight <40
	SLV_BabyGotBoobsQuest.setstage(350)
endif
if fWeight >= 40.0 && fWeight <45
	SLV_BabyGotBoobsQuest.setstage(400)
endif
if fWeight >= 45.0 && fWeight <50
	SLV_BabyGotBoobsQuest.setstage(450)
endif
if fWeight >= 50.0 && fWeight <55
	SLV_BabyGotBoobsQuest.setstage(500)
endif
if fWeight >= 55.0 && fWeight <60
	SLV_BabyGotBoobsQuest.setstage(550)
endif
if fWeight >= 60.0 && fWeight <65
	SLV_BabyGotBoobsQuest.setstage(600)
endif
if fWeight >= 65.0 && fWeight <70
	SLV_BabyGotBoobsQuest.setstage(650)
endif
if fWeight >= 70.0 && fWeight <75
	SLV_BabyGotBoobsQuest.setstage(700)
endif
if fWeight >= 75.0 && fWeight <80
	SLV_BabyGotBoobsQuest.setstage(750)
endif
if fWeight >= 80.0 && fWeight <85
	SLV_BabyGotBoobsQuest.setstage(800)
endif
if fWeight >= 85.0 && fWeight <90
	SLV_BabyGotBoobsQuest.setstage(850)
endif
if fWeight >= 90.0 && fWeight <95
	SLV_BabyGotBoobsQuest.setstage(900)
endif
if fWeight >= 95.0 && fWeight <100
	SLV_BabyGotBoobsQuest.setstage(950)
endif
if fWeight >= 100.0
	SLV_BabyGotBoobsQuest.setstage(1000)
endif
endfunction
Quest Property SLV_BabyGotBoobsQuest auto

Function SLV_NextSlaveName(Actor NPCActor)
headshaving.NextSlaveName(NPCActor)
endfunction

Function SLV_ResetSlaveName(Actor NPCActor)
headshaving.ResetSlaveName(NPCActor)
endfunction

function SLV_restoreNPCOutfitsforZone(int zone)
String strippedKeyWord = "SLV_StrippedNPC"

SLV_restoreAllNPCOutfitsForKeyWord(strippedKeyWord+zone)
endfunction


function SLV_restoreAllNPCOutfits()
String strippedKeyWord = "SLV_StrippedNPC"

SLV_restoreAllNPCOutfitsForKeyWord(strippedKeyWord)

SLV_restoreAllNPCOutfitsForKeyWord(strippedKeyWord+1)
SLV_restoreAllNPCOutfitsForKeyWord(strippedKeyWord+2)
SLV_restoreAllNPCOutfitsForKeyWord(strippedKeyWord+3)
SLV_restoreAllNPCOutfitsForKeyWord(strippedKeyWord+4)
SLV_restoreAllNPCOutfitsForKeyWord(strippedKeyWord+5)
SLV_restoreAllNPCOutfitsForKeyWord(strippedKeyWord+6)
SLV_restoreAllNPCOutfitsForKeyWord(strippedKeyWord+7)
SLV_restoreAllNPCOutfitsForKeyWord(strippedKeyWord+8)
SLV_restoreAllNPCOutfitsForKeyWord(strippedKeyWord+9)
SLV_restoreAllNPCOutfitsForKeyWord(strippedKeyWord+10)
SLV_restoreAllNPCOutfitsForKeyWord(strippedKeyWord+11)
endfunction


function SLV_restoreSingleNPCOutfits(Actor nakedActor)
String strippedKeyWord = "SLV_StrippedNPC"

SLV_restoreSingleNPCOutfitsForKeyWord(nakedActor, strippedKeyWord)

SLV_restoreSingleNPCOutfitsForKeyWord(nakedActor, strippedKeyWord+1)
SLV_restoreSingleNPCOutfitsForKeyWord(nakedActor, strippedKeyWord+2)
SLV_restoreSingleNPCOutfitsForKeyWord(nakedActor, strippedKeyWord+3)
SLV_restoreSingleNPCOutfitsForKeyWord(nakedActor, strippedKeyWord+4)
SLV_restoreSingleNPCOutfitsForKeyWord(nakedActor, strippedKeyWord+5)
SLV_restoreSingleNPCOutfitsForKeyWord(nakedActor, strippedKeyWord+6)
SLV_restoreSingleNPCOutfitsForKeyWord(nakedActor, strippedKeyWord+7)
SLV_restoreSingleNPCOutfitsForKeyWord(nakedActor, strippedKeyWord+8)
SLV_restoreSingleNPCOutfitsForKeyWord(nakedActor, strippedKeyWord+9)
SLV_restoreSingleNPCOutfitsForKeyWord(nakedActor, strippedKeyWord+10)
SLV_restoreSingleNPCOutfitsForKeyWord(nakedActor, strippedKeyWord+11)
endfunction


function SLV_restoreAllNPCOutfitsForKeyWord(String strippedKeyWord)
int valueCount = StorageUtil.IntListCount(none, strippedKeyWord)

while(valueCount > 0)
	valueCount -= 1
	SLV_DisplayDebug2("List[" + valueCount + "] = " + StorageUtil.IntListGet(none, strippedKeyWord, valueCount))
	int formid = StorageUtil.IntListGet(none, strippedKeyWord, valueCount)
	Actor NPCActor = Game.GetForm(formid) as Actor
	if NPCActor
		if NPCActor.IsInFaction(SlaverunSlaveFaction)
			NPCActor.RemoveFromFaction(SlaverunSlaveFaction)
			if NPCActor.getActorBase() && MCMMenu.OutfitNPCSlave
				SLV_DisplayDebug2("Actor " + NPCActor.getActorBase().getName())
				if NPCActor.getActorBase().getSex() == 1
					NPCActor.SetOutfit(FreeOutfit)
				else
					NPCActor.SetOutfit(FreeMaleOutfit)
				endif
			endif
		else
			if NPCActor.getActorBase() && MCMMenu.OutfitNPCFree
				SLV_DisplayDebug2("Actor " + NPCActor.getActorBase().getName())
				if NPCActor.getActorBase().getSex() == 1
					NPCActor.SetOutfit(FreeOutfit)
				else
					NPCActor.SetOutfit(FreeMaleOutfit)
				endif
			endif
		endif
	endif

	StorageUtil.IntListRemove(none, strippedKeyWord, formid)
endwhile
endfunction


function SLV_restoreSingleNPCOutfitsForKeyWord(Actor nakedActor, String strippedKeyWord)
int valueCount = StorageUtil.IntListCount(none, strippedKeyWord)

while(valueCount > 0)
	valueCount -= 1
	SLV_DisplayDebug2("List[" + valueCount + "] = " + StorageUtil.IntListGet(none, strippedKeyWord, valueCount))
	int formid = StorageUtil.IntListGet(none, strippedKeyWord, valueCount)
	Actor NPCActor = Game.GetForm(formid) as Actor
	if NPCActor && (NPCActor == nakedActor)
		if NPCActor.IsInFaction(SlaverunSlaveFaction)
			NPCActor.RemoveFromFaction(SlaverunSlaveFaction)
			if NPCActor.getActorBase() && MCMMenu.OutfitNPCSlave
				SLV_DisplayDebug2("Actor " + NPCActor.getActorBase().getName())
				if NPCActor.getActorBase().getSex() == 1
					NPCActor.SetOutfit(FreeOutfit)
				else
					NPCActor.SetOutfit(FreeMaleOutfit)
				endif
			endif
		else
			if NPCActor.getActorBase() && MCMMenu.OutfitNPCFree
				SLV_DisplayDebug2("Actor " + NPCActor.getActorBase().getName())
				if NPCActor.getActorBase().getSex() == 1
					NPCActor.SetOutfit(FreeOutfit)
				else
					NPCActor.SetOutfit(FreeMaleOutfit)
				endif
			endif
		endif
		StorageUtil.IntListRemove(none, strippedKeyWord, formid)
	endif

endwhile
endfunction
Outfit Property FreeOutfit auto
Outfit Property FreeMaleOutfit auto


function SLV_enslavementNPC(Actor NPCActor)
zbfSlaveControl zbs = zbfSlaveControl.getApi()
zbs.EnslaveActor(NPCActor, "SlaverunReloaded")

if NPCActor.GetEquippedWeapon() != None
	NPCActor.UnEquipitem(NPCActor.GetEquippedWeapon(), True, True)
endif
if NPCActor.GetEquippedShield() != None
	NPCActor.UnEquipitem(NPCActor.GetEquippedShield(), True, True)
endif
SLV_SexlabStripNPC(NPCActor)
NPCActor.AddToFaction(SlaverunSlaveFaction)
NPCActor.AddToFaction(SLV_StrippedNPC)
SLV_setNPCSlaveOutfit(NPCActor)
SLV_changeOutfitNPC(NPCActor)

;SLV_enslavementChains(NPCActor)
SLV_StripBothHands(NPCActor)
endfunction
Faction Property SLV_StrippedNPC auto


function SLV_changeOutfitNPC(Actor NPCActor)
StorageUtil.IntListAdd(none, "SLV_StrippedNPC", (NPCActor as Form).GetFormID())
endfunction

function SLV_changeOutfitNPCForZone(Actor NPCActor, int zone)
StorageUtil.IntListAdd(none, "SLV_StrippedNPC" + zone, (NPCActor as Form).GetFormID())
endfunction



function SLV_setNPCSlaveOutfit(Actor NPCActor)
if (NPCActor.IsPlayerTeammate() || NPCActor.IsInFaction(CurrentFollowerFaction))
	if !MCMMenu.OutfitNPCFollower
		return
	endif
else
	if !MCMMenu.OutfitNPCSlave
		return
	endif
endif

if MCMMenu.SkipDevices
	return
endif

Outfit SlaveOutfit

int color = MCMMenu.NPCOutfitcolor
int slaveColor = 0
int slaveTheme = 0

if MCMMenu.SlaveNPCOutfit == 0
	slaveTheme = Utility.RandomInt(1,6)
else 
	slaveTheme = MCMMenu.SlaveNPCOutfit
endif

;male?
if NPCActor.getActorBase().getSex() == 0
	NPCActor.setOutfit(SlaveOutfitMale)
	return
endif

if(slaveTheme == 1) ; Naked
	NPCActor.setOutfit(SLV_SlaveOutfit1)
elseif (slaveTheme == 2) ; Collar
	if color == 0
		slaveColor = Utility.RandomInt(1,3)
	else 
		slaveColor = color
	endif
	if slaveColor == 1
		NPCActor.SetOutfit(SlaveOutfitNormalWhite)
	elseif slaveColor == 2
		NPCActor.SetOutfit(SlaveOutfitNormalRed)
	elseif slaveColor == 3
		NPCActor.SetOutfit(SLV_SlaveOutfit2)
	else	
		NPCActor.SetOutfit(SLV_SlaveOutfit2)
	endif
elseif (slaveTheme == 3) ; collar and foot chain
	if color == 0
		slaveColor = Utility.RandomInt(1,3)
	else 
		slaveColor = color
	endif
	if slaveColor == 1
		NPCActor.SetOutfit(SlaveOutfitFullWhite)
	elseif slaveColor == 2
		NPCActor.SetOutfit(SlaveOutfitFullRed)
	elseif slaveColor == 3
		NPCActor.SetOutfit(SLV_SlaveOutfit3)
	else	
		NPCActor.SetOutfit(SLV_SlaveOutfit3)
	endif
elseif (slaveTheme == 4) ; collar+foot+cuffs
	if color == 0
		slaveColor = Utility.RandomInt(1,3)
	else 
		slaveColor = color
	endif
	if slaveColor == 1
		NPCActor.SetOutfit(SlaveOutfitFullWhite)
	elseif slaveColor == 2
		NPCActor.SetOutfit(SlaveOutfitFullRed)
	elseif slaveColor == 3
		NPCActor.SetOutfit(SLV_SlaveOutfit4)
	else	
		NPCActor.SetOutfit(SLV_SlaveOutfit4)
	endif
elseif (slaveTheme == 5) ; collar+foot+cuffs+piercings
	if color == 0
		slaveColor = Utility.RandomInt(1,3)
	else 
		slaveColor = color
	endif
	if slaveColor == 1
		NPCActor.SetOutfit(SlaveOutfitFullWhite)
	elseif slaveColor == 2
		NPCActor.SetOutfit(SlaveOutfitFullRed)
	elseif slaveColor == 3
		NPCActor.SetOutfit(SLV_SlaveOutfit5)
	else	
		NPCActor.SetOutfit(SLV_SlaveOutfit5)
	endif
elseif (slaveTheme == 6) ; collar+foot+cuffs+piercings+corset
	if color == 0
		slaveColor = Utility.RandomInt(1,3)
	else 
		slaveColor = color
	endif
	if slaveColor == 1
		NPCActor.SetOutfit(SlaveOutfitFullWhite)
	elseif slaveColor == 2
		NPCActor.SetOutfit(SlaveOutfitFullRed)
	elseif slaveColor == 3
		NPCActor.SetOutfit(SLV_SlaveOutfit6)
	else	
		NPCActor.SetOutfit(SLV_SlaveOutfit6)
	endif
endif
endfunction
Outfit Property SLV_SlaveOutfit1 auto
Outfit Property SLV_SlaveOutfit2 auto
Outfit Property SLV_SlaveOutfit3 auto
Outfit Property SLV_SlaveOutfit4 auto
Outfit Property SLV_SlaveOutfit5 auto
Outfit Property SLV_SlaveOutfit6 auto
Outfit Property SlaveOutfitNaked auto
Outfit Property SlaveOutfitNormalWhite auto
Outfit Property SlaveOutfitNormalRed auto
Outfit Property SlaveOutfitNormalBlack auto
Outfit Property SlaveOutfitFullWhite auto
Outfit Property SlaveOutfitFullRed auto
Outfit Property SlaveOutfitFullBlack auto
Outfit Property SlaveOutfitMale auto
Outfit Property SLV_SlaveOutfitMetal2 auto
Outfit Property SLV_SlaveOutfitMetal3 auto
Outfit Property SLV_SlaveOutfitMetal4 auto



function SLV_setNPCFreeOutfit(Actor NPCActor)
if (NPCActor.IsPlayerTeammate() || NPCActor.IsInFaction(CurrentFollowerFaction))
	return
else
	if !MCMMenu.OutfitNPCFree
		return
	endif
endif

if MCMMenu.SkipDevices
	return
endif

SLV_changeOutfitNPC(NPCActor)
int freeTheme = 0

if MCMMenu.FreeNPCOutfit == 0
	freeTheme = Utility.RandomInt(1,5)
else 
	freeTheme = MCMMenu.FreeNPCOutfit
endif

;male?
if NPCActor.getActorBase().getSex() == 0
	return
endif

if(freeTheme == 1) ; Naked
	NPCActor.setOutfit(SLV_FreeFemaleOutfit1)
elseif (freeTheme == 2) ; Shoes
	NPCActor.SetOutfit(SLV_FreeFemaleOutfit2)
elseif (freeTheme == 3) ; Boots
	NPCActor.SetOutfit(SLV_FreeFemaleOutfit3)
elseif (freeTheme == 4) ; Shoes and Gloves
	NPCActor.SetOutfit(SLV_FreeFemaleOutfit4)
elseif (freeTheme == 5) ; Boots and Gloves
	NPCActor.SetOutfit(SLV_FreeFemaleOutfit5)
endif
endfunction
Outfit Property SLV_FreeFemaleOutfit1 auto
Outfit Property SLV_FreeFemaleOutfit2 auto
Outfit Property SLV_FreeFemaleOutfit3 auto
Outfit Property SLV_FreeFemaleOutfit4 auto
Outfit Property SLV_FreeFemaleOutfit5 auto




function SLV_SetSlaveFactions()
PlayerRef.AddToFaction(SlaverunSlaveFaction)
PlayerRef.AddToFaction(SLV_Slave)
if PlayerRef.IsInFaction(SlaverunSlaverFaction)
	SLV_PlayerHasBeenASlaver.setvalue(1)
endif
PlayerRef.RemoveFromFaction(SlaverunSlaverFaction)
SLV_PlayerIsSlaveOfSlaverun.setvalue(1)
endfunction
GlobalVariable Property SLV_PlayerHasBeenASlave Auto
GlobalVariable Property SLV_PlayerHasBeenASlaver Auto
GlobalVariable Property SLV_PlayerIsSlaveOfSlaverun Auto

function SLV_enslavement(bool strip=true)
SLV_SetSlaveFactions()

SLV_Hardmode.setvalue(0)
SLV_IvanaMood.setvalue(0)
reviveNPC.resurrectNPC_Whiterun()

zbfSlaveControl zbs = zbfSlaveControl.getApi()
zbs.EnslaveActor(PlayerRef, "SlaverunReloaded")
zbs.setPlayerMaster(Brutus, "Slaverun Reloaded")

;zbfSlaveLeash leash = zbfSlaveLeash.GetApi()
;leash.SetMaster(Brutus) 

Float Time = Utility.GetCurrentGameTime()
StorageUtil.SetFloatValue(None, "SLV_PlayerSlaveTime", Time )
endfunction
Actor Property Brutus Auto
;zbfSlaveControl Property zbs auto
;zbfSlaveLeash Property zbl auto 
;zbfBondageShell Property zbf Auto
Faction Property SlaverunSlaverFaction auto
Faction Property SLV_Slave auto

function SLV_enslavementFull(bool strip=true)
SLV_SetSlaveFactions()

reviveNPC.resurrectNPC_Whiterun()
if strip
	SLV_SerialStrip()
else
	SLV_SexlabStripNPC(PlayerRef)
endif
SLV_removeitems(PlayerRef)
SLV_StripBothHands(PlayerRef)

SLV_DeviousUnEquipActor2(PlayerRef,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)
endfunction
SLV_ReviveNPC Property reviveNPC auto
GlobalVariable Property SLV_Hardmode Auto
SLV_SpecialDevices Property specialDevices auto

function SLV_enslavementChains(Actor NPCActor)

if MCMMenu.SkipDevices
	return
endif
;male?
if NPCActor.getActorBase().getSex() == 0
	NPCActor.setOutfit(SlaveOutfitMale)
	return
endif

if NPCActor == PlayerRef
	;specialDevices.SLV_equipBallChain02(NPCActor)
	specialDevices.SLV_equipShackles(NPCActor)
	;specialDevices.SLV_equipAnkleIron(NPCActor)
else
	specialDevices.SLV_equipAnkleIron(NPCActor)
endif

if Game.GetModByName("DjekNoseChain.esp")!= 255
	Armor DjekNoseChain = Game.GetFormFromFile(0x000D63, "DjekNoseChain.esp") as Armor
	NPCActor.EquipItem(DjekNoseChain)
	if Game.GetModByName("Zarias_Piercings1.esp")!= 255
		NPCActor.EquipItem(Game.GetFormFromFile(0x0012CE, "Zarias_Piercings1.esp") as Armor)
	endif
elseif Game.GetModByName("Zarias_Piercings1.esp")!= 255
	Armor ZariasEarring = Game.GetFormFromFile(0x000D68, "Zarias_Piercings1.esp") as Armor
	NPCActor.EquipItem(ZariasEarring)
endif

if Game.GetModByName("MiasLair.esp")!= 255
	NPCActor.EquipItem(Game.GetFormFromFile(0x01D579, "MiasLair.esp") as Armor)
endif
if Game.GetModByName("Svs Collection Jewelry.esp")!= 255
	NPCActor.EquipItem(Game.GetFormFromFile(0x01866C, "Svs Collection Jewelry.esp") as Armor)
endif
if Game.GetModByName("HN66_NAILS4ALL.esp")!= 255
	NPCActor.EquipItem(Game.GetFormFromFile(0x003DEF, "HN66_NAILS4ALL.esp") as Armor)
endif

SLV_DeviousEquipActor(NPCActor,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false)

SLV_StripBothHands(NPCActor)
endfunction


function SLV_equipDDChains(Actor NPCActor)
if MCMMenu.SkipDevices
	return
endif

SLV_equipDDChainsNoPlugs(NPCActor)
SLV_equipDDChainsPlugs(NPCActor)
endfunction

function SLV_equipDDChainsNoPlugs(Actor NPCActor)
if MCMMenu.SkipDevices
	return
endif

specialDevices.SLV_equipDDChainsNoPlugs(NPCActor)

SLV_DeviousEquipActorColor2(NPCActor,",black","",false,false,false,false,false,false,false,false,false,true,false,true,false,false,false)
;SLV_DeviousEquipActorColor2(NPCActor,",black","",false,false,false,false,false,false,false,false,true,true,false,true,false,false,false)
endfunction

function SLV_equipDDChainsPlugs(Actor NPCActor)
if MCMMenu.SkipDevices
	return
endif
SLV_DeviousUnEquipActor(NPCActor,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false)

specialDevices.SLV_equipDDChainsPlugs(NPCActor)
endfunction


function SLV_enableMerchantSlaves()
Int newMerchantSlavesItems = newMerchantSlavesEnabling.Length
While newMerchantSlavesItems 
	newMerchantSlavesItems -= 1
	newMerchantSlavesEnabling[newMerchantSlavesItems].Enable()
EndWhile
endfunction
function SLV_disableMerchantSlaves()
Int newMerchantSlavesItems = newMerchantSlavesEnabling.Length
While newMerchantSlavesItems 
	newMerchantSlavesItems -= 1
	newMerchantSlavesEnabling[newMerchantSlavesItems].Disable()
EndWhile
endfunction

function SLV_enableBrutus()
Int newBrutusItems = newBrutusEnabling.Length
While newBrutusItems 
	newBrutusItems -= 1
	newBrutusEnabling[newBrutusItems].Enable()
EndWhile
SLV_enableDiamond()
endfunction

function SLV_enableValentina()
SLV_Valentina.getActorRef().moveto(SLV_BrutusWayMarker)
SLV_Valentina.getActorRef().Enable()

SLV_Valentina.getActorRef().equipItem(BarClothes,true)
SLV_Valentina.getActorRef().equipItem(BarShoes,true)
SLV_DeviousEquipActor(SLV_Valentina.getActorRef(),false,false,false,false,false,false,false,false,false,true,false,false,false,false,false)

ActorUtil.ClearPackageOverride(SLV_Valentina.getActorRef())
;SLV_Valentina.getActorRef().evaluatePackage()


;ActorUtil.AddPackageOverride(SLV_Valentina.getActorRef(), SLV_Idle ,100)
;ActorUtil.AddPackageOverride(SLV_Valentina.getActorRef(), SLV_WalkToBrutusWayMarker ,100)
ActorUtil.AddPackageOverride(SLV_Valentina.getActorRef(), SLV_FollowBellamy ,100)
;ActorUtil.AddPackageOverride(SLV_Valentina.getActorRef(), SLV_Kneel ,100)
SLV_Valentina.getActorRef().evaluatePackage()

SLV_Valentina.getActorRef().moveto(SLV_BrutusWayMarker)
SLV_Valentina.getActorRef().Enable()
endfunction 
ReferenceAlias Property SLV_Valentina Auto 
Package Property SLV_Kneel Auto
Package Property SLV_Idle Auto
Package Property SLV_WalkToBrutusWayMarker Auto
Package Property SLV_FollowBellamy Auto
ObjectReference Property SLV_BrutusWaymarker Auto
Armor Property BarClothes Auto
Armor Property BarShoes Auto

function SLV_enableDiamond()
SLV_Diamond.getActorRef().moveto(SLV_BrutusWayMarker)
SLV_Diamond.getActorRef().Enable()

ActorUtil.AddPackageOverride(SLV_Diamond.getActorRef(), SLV_Idle ,100)
ActorUtil.AddPackageOverride(SLV_Diamond.getActorRef(), SLV_Kneel ,100)

SLV_Diamond.getActorRef().moveto(SLV_BrutusWayMarker)
SLV_Diamond.getActorRef().Enable()
endfunction 
ReferenceAlias Property SLV_Diamond Auto 

function SLV_disableBrutus()
Int newBrutusItems = newBrutusEnabling.Length
While newBrutusItems 
	newBrutusItems -= 1
	newBrutusEnabling[newBrutusItems].Disable()
EndWhile
endfunction

function SLV_enableZaid()
Int newZaidItems = newZaidEnabling.Length
While newZaidItems 
	newZaidItems -= 1
	newZaidEnabling[newZaidItems ].Enable()
EndWhile

SLV_SlaveGuardsQuest.reset()
SLV_SlaveGuardsQuest.start()
SLV_SlaveGuardsQuest.setstage(0)
SLV_SlaveManagement.reset()
SLV_SlaveManagement.start()
SLV_SlaveManagement.setstage(0)
endfunction
Quest Property SLV_SlaveGuardsQuest Auto
Quest Property SLV_SlaveManagement Auto

;ObjectReference function SLV_createBrandingDevice()
;if Game.GetModByName("BrandingDeviceOfDoom.esp")!= 255
;	return TPBDOD()
;endif
;endfunction
;ObjectReference function TPBDOD()
;if Game.GetModByName("BrandingDeviceOfDoom.esp")!= 255
;    Quest xbQ=Game.GetFormFromFile(0x001854, "BrandingDeviceOfDoom.esp") As Quest
;    objectReference bdodObjRef=(xbQ as xxbQuestScript).BdodInDungeonObjRef
;    (bdodObjRef as xxBrandingDeviceScript).MoveBDODFromDungeonToObjRef(SLV_DeviceWaymarker, 5) ;25.0
;    return(bdodObjRef as xxBrandingDeviceScript).BDODGetTPStocksRef()
;endif
;endfunction
ObjectReference Property SLV_DeviceWaymarker Auto

function SLV_disableZaid()
Int newZaidItems = newZaidEnabling.Length
While newZaidItems 
	newZaidItems -= 1
	newZaidEnabling[newZaidItems ].Disable()
EndWhile
SLV_disableExecution()
SLV_SlaveGuardsQuest.setstage(10000)
endfunction

function SLV_enableMundus()
Int newMundusItems = newMundusEnabling.Length
While newMundusItems 
	newMundusItems -= 1
	newMundusEnabling[newMundusItems ].Enable()
EndWhile
endfunction
function SLV_disableMundus()
Int newMundusItems = newMundusEnabling.Length
While newMundusItems 
	newMundusItems -= 1
	newMundusEnabling[newMundusItems ].Disable()
EndWhile
endfunction

function SLV_enableExecution()
Int newExecutionItems = newExecutionEnabling.Length
While newExecutionItems 
	newExecutionItems -= 1
	newExecutionEnabling[newExecutionItems ].Enable()
EndWhile
endfunction
function SLV_disableExecution()
Int newExecutionItems = newExecutionEnabling.Length
While newExecutionItems 
	newExecutionItems -= 1
	newExecutionEnabling[newExecutionItems ].Disable()
EndWhile
endfunction

function SLV_disableSlavesOutside()
Int newSlavesOutsideItems = newSlavesOutsideEnabling.Length
While newSlavesOutsideItems 
	newSlavesOutsideItems -= 1
	newSlavesOutsideEnabling[newSlavesOutsideItems ].Disable()
EndWhile
endfunction

function SLV_disableMaria()
Int newMariaItems = newMariaEnabling.Length
While newMariaItems 
	newMariaItems -= 1
	newMariaEnabling[newMariaItems].Disable()
EndWhile
endfunction

ObjectReference[] Property newZaidEnabling Auto
ObjectReference[] Property newBrutusEnabling Auto
ObjectReference[] Property newMundusEnabling Auto
ObjectReference[] Property newExecutionEnabling Auto
ObjectReference[] Property newMerchantSlavesEnabling Auto
ObjectReference[] Property newSlavesOutsideEnabling Auto
ObjectReference[] Property newMariaEnabling Auto


function SLV_removeItems(Actor akActor)
SLV_removeItemsFromActor(akActor, StashContainer, true)
endFunction

function SLV_removeGladiatoritems(Actor akActor)
SLV_removeItemsFromActor(akActor, GladiatorContainer, false)
endfunction

function SLV_removeReportingitems(Actor akActor)
SLV_removeItemsFromActor(akActor, ReportingContainer, true)
endfunction

function SLV_removeItemsFromActor(Actor akActor, ObjectReference ToContainer, bool removeGold)
if !MCMMenu.PutItemsInChest
	return
endif
ObjectReference playerContainer = akActor
Int iFormIndex = playerContainer.GetNumItems()
;debug.notification("Items:" + iFormIndex)

While iFormIndex > 0
	iFormIndex -= 1
	Form kForm = playerContainer.GetNthForm(iFormIndex)
	;debug.notification("Inspecting:" + kForm.getName())
	int ItemCount = playerContainer.GetItemCount(kForm )

	If SLV_removeItemCheck(kForm)
		SLV_DisplayInformation("Removing: " + kForm.getName())
		playerContainer.removeItem(kForm ,ItemCount ,true, ToContainer)
	EndIf
EndWhile

if removeGold && MCMMenu.reportConfiscateGold
	int goldcount = akActor.getItemCount(Gold) - MCMMenu.reportConfiscateGoldLeft
	if goldcount > 0
		SLV_DisplayInformation("Removing gold: " + goldcount)
		playerContainer.removeItem(Gold ,goldcount ,true, ToContainer)
	endif
endif

ToContainer.lock()
endfunction



Bool function SLV_removeItemCheck(Form kForm)
if kForm.HasKeyWord(NoStripProperty) || kForm.HasKeyWord(VendorNoSale)
	return false
endif

if kForm.HasKeyWord(VendorArmor) || kForm.HasKeyWord(VendorWeapon) || kForm.HasKeyWord(VendorAmmo) || kForm.HasKeyWord(VendorClothing) || kForm.HasKeyWord(VendorJewellry)
	return true
endif
return false
endfunction
Keyword Property NoStripProperty Auto
ObjectReference Property StashContainer Auto  
ObjectReference Property GladiatorContainer Auto  
ObjectReference Property ReportingContainer Auto  
Keyword Property VendorArmor Auto
Keyword Property VendorWeapon Auto
Keyword Property VendorAmmo Auto
Keyword Property VendorClothing Auto
Keyword Property VendorJewellry Auto
Keyword Property VendorNoSale Auto


Function SLV_DeviousUnEquip(bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset)
SLV_DeviousUnEquipActor(PlayerRef,equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset)
EndFunction
Actor Property PlayerRef Auto



Function SLV_DeviousUnEquipActor(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset)

;Deviously equip the devices
SLV_DeviousUnEquipActor2(NPCActor,equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,false, false, false, false, false, false, false)
EndFunction


Function SLV_DeviousUnEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=true, bool equipHood=true, bool equipClamps=true, bool equipSuit=true, bool equipShackles=true, bool equipHobblesSkirt=true, bool equipHobblesSkirtRelaxed=true)

SLV_DeviousUnEquipActor3(NPCActor,equipGag,equipPlugs,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed)
EndFunction


Function SLV_DeviousUnEquipActor3(Actor NPCActor,bool equipGag,bool equipAnalPlug,bool equipVagPlug,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipLegCuffs,bool equipArmCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=true, bool equipHood=true, bool equipClamps=true, bool equipSuit=true, bool equipShackles=true, bool equipHobblesSkirt=true, bool equipHobblesSkirtRelaxed=true)

deviousDevices.SLV_DeviousUnEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt, equipBra, equipCollar, equipLegCuffs, equipArmCuffs, equipArmbinder, equipYoke, equipBlindfold, equipNPiercings, equipVPiercings, equipBoots, equipGloves, equipCorset, equipMittens,  equipHood,  equipClamps,  equipSuit,  equipShackles,  equipHobblesSkirt,  equipHobblesSkirtRelaxed, false)
endfunction

Function SLV_DeviousUnEquipActor4(Actor NPCActor,bool equipGag,bool equipAnalPlug,bool equipVagPlug,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipLegCuffs,bool equipArmCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=true, bool equipHood=true, bool equipClamps=true, bool equipSuit=true, bool equipShackles=true, bool equipHobblesSkirt=true, bool equipHobblesSkirtRelaxed=true, bool equipStraitJacket=true)

deviousDevices.SLV_DeviousUnEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt, equipBra, equipCollar, equipLegCuffs, equipArmCuffs, equipArmbinder, equipYoke, equipBlindfold, equipNPiercings, equipVPiercings, equipBoots, equipGloves, equipCorset, equipMittens,  equipHood,  equipClamps,  equipSuit,  equipShackles,  equipHobblesSkirt,  equipHobblesSkirtRelaxed, equipStraitJacket)
endfunction


Function SLV_SerialStrip()
SLV_SerialStripNPC(PlayerRef)
endfunction


Function SLV_SerialStripNPC(Actor NPCActor)
bool strippedCallOK = false
; and here another call for serialstrip 1.1.2
Int Handle = ModEvent.Create("SerialStripStart")
If (Handle)
	ModEvent.PushForm(Handle, NPCActor)
	ModEvent.PushForm(Handle,NPCActor)
	ModEvent.PushString(Handle, "")
	ModEvent.PushString(Handle, "")
	ModEvent.PushBool(Handle, TRUE)
	ModEvent.Send(Handle)
	strippedCallOK = true
else
	strippedCallOK = false
EndIf

if strippedCallOK &&  Game.GetModByName("SerialStrip.esp")!= 255
	Debug.notification(NPCActor.getActorBase().getName() + " begins to strip her clothes.")
	Utility.Wait(30)
else
	SLV_SexlabStripNPC(NPCActor)
	Utility.Wait(3)
endif
EndFunction



Function SLV_BindPlayer()
Game.DisablePlayerControls(true, true, false, false, false, true, false, false)
	
int AnimationSelector = Utility.RandomInt(1,23)

if (AnimationSelector == 1) 
	Debug.SendAnimationEvent(PlayerRef, "ZazAPCAO051")
elseif (AnimationSelector == 2 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPCAO052")
elseif (AnimationSelector == 3 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPCAO053")
elseif (AnimationSelector == 4 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPCAO054")
elseif (AnimationSelector == 5 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPCAO055")
elseif (AnimationSelector == 6 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPC011")
elseif (AnimationSelector == 7 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPC013")
elseif (AnimationSelector == 8 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPC014")
elseif (AnimationSelector == 9 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPC018")
elseif (AnimationSelector == 10 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPC019")
elseif (AnimationSelector == 11 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPC020")
elseif (AnimationSelector == 12 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPC056")
elseif (AnimationSelector == 13 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPC057")
elseif (AnimationSelector == 14 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPCAO025")
elseif (AnimationSelector == 15 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPCAO012")
elseif (AnimationSelector == 16 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPCAO011")
elseif (AnimationSelector == 17)
	Debug.SendAnimationEvent(PlayerRef, "ZazAPCAO013")
elseif (AnimationSelector == 18 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPCAO014")
elseif (AnimationSelector == 19 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPCAO201")
elseif (AnimationSelector == 20 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPCAO204")
elseif (AnimationSelector == 21 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPCAO202")
elseif (AnimationSelector == 22 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPCAO251")
elseif (AnimationSelector == 23 )
	Debug.SendAnimationEvent(PlayerRef, "ZazAPCAO263")
endif
EndFunction


Function SLV_DeviousEquip(bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset)

SLV_DeviousEquipActor(PlayerRef,equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset)
EndFunction


Function SLV_DeviousEquipActor(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset)

SLV_DeviousEquipActor2(NPCActor,equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar, equipCuffs, equipArmbinder, equipYoke, equipBlindfold, equipNPiercings, equipVPiercings, equipBoots, equipGloves, equipCorset,false, false, false, false, false, false, false)
EndFunction


Function SLV_DeviousEquipActorColor(Actor NPCActor,string colortag="",string themetag="",bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset)

SLV_DeviousEquipActorColor2(NPCActor, colortag, themetag, equipGag, equipPlugs, equipHarness, equipBelt, equipBra, equipCollar, equipCuffs, equipArmbinder, equipYoke, equipBlindfold, equipNPiercings, equipVPiercings, equipBoots, equipGloves, equipCorset,false, false, false, false, false, false, false)
EndFunction






Function SLV_DeviousEquipActor2(Actor NPCActor,bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)

string colortag = ""
string tagwhite = ",white"
string tagred = ",red"
string tagblack = ",black"

string tagmetal = ",metal"
string tagleather = ",leather"
string tagebonite = ",ebonite"
string themetag = ""

int color = MCMMenu.equipcolor
if NPCActor != PlayerRef
	color = MCMMenu.npcoutfitcolor
endif
if(color == 1) 
	colortag = tagwhite 
elseif (color == 2)
	colortag = tagred
elseif (color == 3)
	colortag = tagblack
endif

int theme = MCMMenu.equiptheme
if(theme == 1) 
	themetag = tagmetal 
elseif (theme == 2)
	themetag = tagleather 
elseif (theme == 3)
	themetag = tagebonite 
endif

SLV_DeviousEquipActorColor2(NPCActor,colortag,themetag,equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens, equipHood, equipClamps, equipSuit, equipShackles, equipHobblesSkirt, equipHobblesSkirtRelaxed)
EndFunction


Function SLV_DeviousEquipActorColor2(Actor NPCActor,string colortag="",string themetag="",bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)

SLV_DeviousEquipActorColor3(NPCActor,colortag,themetag,equipGag,equipPlugs,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed)
EndFunction


Function SLV_DeviousProgressiveUnEquipActor(Actor NPCActor,bool random)
deviousDevices.SLV_DeviousProgressiveUnEquipActor(NPCActor,random)
EndFunction
Function SLV_DeviousProgressiveEquipActor(Actor NPCActor,bool random)
deviousDevices.SLV_DeviousProgressiveEquipActor(NPCActor,random)
EndFunction



Function SLV_DeviousEquipActor3(Actor NPCActor,bool equipGag,bool equipAnalPlug,bool equipVagPlug,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipLegCuffs,bool equipArmCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)

SLV_DeviousEquipActor4(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipArmCuffs,equipLegCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed, false)
EndFunction

Function SLV_DeviousEquipActor4(Actor NPCActor,bool equipGag,bool equipAnalPlug,bool equipVagPlug,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipLegCuffs,bool equipArmCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false, bool equipStraitJacket=false)

string colortag = ""
string tagwhite = ",white"
string tagred = ",red"
string tagblack = ",black"

string tagmetal = ",metal"
string tagleather = ",leather"
string tagebonite = ",ebonite"
string themetag = ""

int color = MCMMenu.equipcolor
if NPCActor != PlayerRef
	color = MCMMenu.npcoutfitcolor
endif
if(color == 1) 
	colortag = tagwhite 
elseif (color == 2)
	colortag = tagred
elseif (color == 3)
	colortag = tagblack
endif

int theme = MCMMenu.equiptheme
if(theme == 1) 
	themetag = tagmetal 
elseif (theme == 2)
	themetag = tagleather 
elseif (theme == 3)
	themetag = tagebonite 
endif

SLV_DeviousEquipActorColor4(NPCActor,colortag,themetag,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipArmCuffs,equipLegCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
EndFunction


Function SLV_DeviousEquipActorColor3(Actor NPCActor,string colortag="",string themetag="",bool equipGag,bool equipAnalPlug,bool equipVagPlug,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipArmCuffs,bool equipLegCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false)

SLV_DeviousEquipActorColor4(NPCActor,colortag,themetag, equipGag, equipAnalPlug, equipVagPlug, equipHarness, equipBelt, equipBra, equipCollar, equipArmCuffs, equipLegCuffs, equipArmbinder, equipYoke, equipBlindfold, equipNPiercings, equipVPiercings, equipBoots, equipGloves, equipCorset, equipMittens, equipHood, equipClamps,  equipSuit, equipShackles, equipHobblesSkirt, equipHobblesSkirtRelaxed, false)

EndFunction

Function SLV_DeviousEquipActorColor4(Actor NPCActor,string colortag="",string themetag="",bool equipGag,bool equipAnalPlug,bool equipVagPlug,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipArmCuffs,bool equipLegCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false, bool equipStraitJacket=false)

deviousDevices.SLV_DeviousEquipActorColor(NPCActor,colortag,themetag, equipGag, equipAnalPlug, equipVagPlug, equipHarness, equipBelt, equipBra, equipCollar, equipArmCuffs, equipLegCuffs, equipArmbinder, equipYoke, equipBlindfold, equipNPiercings, equipVPiercings, equipBoots, equipGloves, equipCorset, equipMittens, equipHood, equipClamps,  equipSuit, equipShackles, equipHobblesSkirt, equipHobblesSkirtRelaxed, equipStraitJacket)
EndFunction



Function SLV_AddDeviousDevice(Actor NPCActor, int count, bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset)

SLV_AddDeviousDevice2(NPCActor, count, equipGag, equipPlugs, equipHarness, equipBelt, equipBra, equipCollar, equipCuffs, equipArmbinder, equipYoke, equipBlindfold, equipNPiercings, equipVPiercings, equipBoots, equipGloves, equipCorset)
EndFunction

Function SLV_AddDeviousDevice2(Actor NPCActor, int count, bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset)
;Deviously equip the devices

deviousDevices.SLV_AddDeviousDevice(NPCActor, count, equipGag,equipPlugs, equipHarness, equipBelt, equipBra, equipCollar, equipCuffs, equipArmbinder, equipYoke, equipBlindfold, equipNPiercings, equipVPiercings, equipBoots, equipGloves, equipCorset)

EndFunction


Function SLV_StripBothHands(Actor NPCActor)
If NPCActor.GetEquippedObject(0) 
	NPCActor.UnEquipItem(NPCActor.GetEquippedObject(0), True, True)
endif
If NPCActor.GetEquippedObject(1) 
	NPCActor.UnEquipItem(NPCActor.GetEquippedObject(1), True, True)
endif
EndFunction




Function SLV_RewardPlayerWithGold()
if PlayerRef.IsInFaction(SlaverunSlaveFaction)
	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Slavery", 6, 2) ;Fame slavery +2
elseif PlayerRef.IsInFaction(SlaverunSlaverFaction)
	PlayerRef.AddItem(Gold, 300)
else
	PlayerRef.AddItem(Gold, 300)
	return
endif
EndFunction

Function SLV_ProgressMainQuest()
SLV_WhiterunTasksDone.setValue(SLV_WhiterunTasksDone.getValue() + 1)
SLV_RewardPlayerWithGold()

if SLV_IsSlaveMaxLevelReached()
	if deadslavewalking.getstage() == 4500
		deadslavewalking.SetObjectiveCompleted(4500)
		if SLV_IsArenaMaxLevelReached()
			deadslavewalking.SetStage(6000)
		else
			deadslavewalking.SetStage(5500)
		endif
	endif
	if deadslavewalking.getstage() == 5000
		deadslavewalking.SetObjectiveCompleted(5000)
		deadslavewalking.SetStage(6000)
	endif
endif

if SLV_Main.GetStage() == 1300
	if SLV_Main.ModObjectiveGlobal(1, SLV_WhiterunTask  ,1300, SLV_WhiterunMaxTask.getValue())
		SLV_Main.SetStage(1400)
	endif
endif
if SLV_Main.GetStage() == 2100
	if SLV_Main.ModObjectiveGlobal(1, SLV_WhiterunTask  ,2100, SLV_WhiterunMaxTask.getValue())
		SLV_Main.SetStage(2200)
	endif
endif
if SLV_Main.GetStage() == 3100
	if SLV_Main.ModObjectiveGlobal(1, SLV_WhiterunTask  ,3100, SLV_WhiterunMaxTask.getValue())
		SLV_Main.SetStage(3200)
	endif
endif
if SLV_Main.GetStage() == 4100
	if SLV_Main.ModObjectiveGlobal(1, SLV_WhiterunTask  ,4100, SLV_WhiterunMaxTask.getValue())
		SLV_Main.SetStage(4200)
	endif
endif
if SLV_Main.GetStage() == 5100
	if SLV_Main.ModObjectiveGlobal(1, SLV_WhiterunTask  ,5100, SLV_WhiterunMaxTask.getValue())
		SLV_Main.SetStage(5200)
	endif
endif
if SLV_Main.GetStage() == 6100
	if SLV_Main.ModObjectiveGlobal(1, SLV_WhiterunTask  ,6100, SLV_WhiterunMaxTask.getValue())
		SLV_Main.SetStage(6200)
	endif
endif
if SLV_Main.GetStage() == 7100
	if SLV_Main.ModObjectiveGlobal(1, SLV_WhiterunTask  ,7100, SLV_WhiterunMaxTask.getValue())
		SLV_Main.SetStage(7200)
	endif
endif
if SLV_Main.GetStage() == 8100
	if SLV_Main.ModObjectiveGlobal(1, SLV_WhiterunTask  ,8100, SLV_WhiterunMaxTask.getValue())
		SLV_Main.SetStage(8200)
	endif
endif
if SLV_Main.GetStage() == 9100
	if SLV_Main.ModObjectiveGlobal(1, SLV_WhiterunTask  ,9100, SLV_WhiterunMaxTask.getValue())
		SLV_Main.SetStage(9200)
	endif
endif
if SLV_Main.GetStage() == 10100
	if SLV_Main.ModObjectiveGlobal(1, SLV_WhiterunTask  ,10100, SLV_WhiterunMaxTask.getValue())
		SLV_Main.SetStage(10200)
	endif
endif
if SLV_Main.getStage() == 1450
	if SLV_Main.ModObjectiveGlobal(1, SLV_WhiterunTask  ,1450, SLV_WhiterunMaxTask.getValue())
		SLV_Main.SetStage(1550)
	endif
endif
EndFunction
Quest Property SLV_Main Auto 
Quest Property deadslavewalking Auto


Function SLV_IncreaseSlaveFameSpecificNpc(Actor Who)
if  Game.GetModByName("SexLab - Sexual Fame.esm")== 255
	return
endif

FormList FameList = Game.GetFormFromFile(0x0000697D, "SexLab - Sexual Fame.esm") As FormList	;FameList FormList
If Who != None && FameList != None
	Int Count = Who.GetFactionRank(FameList.GetAt(18) as Faction) + 1
			
	If Count > 100
		Count = 100
	ElseIf Count < 0
		Count = 0
	EndIf
			
	Who.SetFactionRank(FameList.GetAt(18) as Faction, Count)
EndIf
EndFunction


Function SLV_DoWhipping(int maxloop)
if MCMMenu.WhippingSound && !MCMMenu.SkipWhipping
	Utility.wait(3.0)
	int counter = 0
	while counter < maxloop
		counter = counter + 1
		scream.play(PlayerRef)
		Utility.wait(2.5)
	endwhile
endif
EndFunction
Sound Property scream auto

Function SLV_DoOrgasm(int maxloop)
Utility.wait(3.0)
int counter = 0
while counter < maxloop
	counter = counter + 1
	orgasm.play(PlayerRef)
	Utility.wait(2.5)
endwhile
EndFunction
Sound Property orgasm auto
Quest Property SLV_FinnTrainingQuest auto



Function SLV_PlayerMoveTo(ObjectReference wayMarker)
Cell PlayerCell = PlayerRef.GetParentCell()
Actor kPlayerRef = PlayerRef


if SLV_FinnTrainingQuest.isRunning() && SLV_FinnTrainingQuest.getStage() < 10000
	SLV_Finn.moveto(wayMarker)
endif

int i=0
if MCMMenu.followersCount > 0
	While (i < MCMMenu.followersCount)
		Actor follower = MCMMenu.followers[i]
		if(follower)
			SLV_DisplayDebug1("Slaverun MCM follower moved")
			follower.moveto(wayMarker)
		endif
		i = i + 1
	endWhile	
endif
	
Int iLoopCount = 10
While iLoopCount > 0
		iLoopCount -= 1
		Actor kPlayerDialogueTarget = Game.FindRandomActorFromRef(kPlayerRef , 200.0)
		ActorBase NPCActorBase = kPlayerDialogueTarget.GetLeveledActorBase()
		SLV_DisplayDebug1("NPC=" + NPCActorBase.GetName() + " Index=" + iLoopCount)
		if SLV_IsActorAFollower(kPlayerDialogueTarget,NPCActorBase)
			SLV_DisplayDebug1("Moving follower " + NPCActorBase.GetName())
			kPlayerDialogueTarget.moveto(wayMarker)
		endif
EndWhile	

int NPCMax = PlayerCell.getNumRefs(43)	; Not zero based, is actual count
SLV_DisplayDebug1("NPCMax =" +NPCMax )
int NPCIndex = 0

while (NPCIndex <= NPCMax )
	Actor NPCActor = playerCell.getNthRef(NPCIndex, 43) as Actor
	ActorBase NPCActorBase
	if NPCActor
	   	NPCActorBase = NPCActor.GetLeveledActorBase()  ; Only get leveled base if NPC exists, no Papyrus log errors this way
		SLV_DisplayDebug1("NPC=" + NPCActorBase.GetName() + " Index=" + NPCIndex)
		if SLV_IsActorAFollower(NPCActor,NPCActorBase)
			SLV_DisplayDebug1("Moving follower " + NPCActorBase.GetName())
			NPCActor.moveto(wayMarker)
		endif
	else
		SLV_DisplayDebug1("No actor on Index=" + NPCIndex)
	endif

	NPCIndex = NPCIndex  + 1
endWhile
PlayerRef.moveto(wayMarker)

i=0
if MCMMenu.followersCount > 0
	While (i < MCMMenu.followersCount)
		Actor follower = MCMMenu.followers[i]
		if(follower)
			SLV_DisplayDebug1("Slaverun MCM follower moved")
			follower.moveto(wayMarker)
		endif
		i = i + 1
	endWhile	
endif

SLV_DisplayDebug1("PlayerMoveTo finished")
EndFunction
Faction Property CurrentFollowerFaction auto


;  Longer function calls replace very complex IF statements to clarify code path and ease future updates
Bool Function SLV_IsActorAFollower(Actor NPCActor, ActorBase NPCActorBase)
if NPCActor == None
	SLV_DisplayDebug1(NPCActorBase.GetName() + " is no actor")
	return false 	; 	No actor
endif
;if !NPCActor.Is3dLoaded()
	;SLV_DisplayDebug1(NPCActorBase.GetName() + " is not 3dLoaded")
	;return false	;	Not really here, can't be used
;endif
if !NPCActor.IsEnabled()
	SLV_DisplayDebug1(NPCActorBase.GetName() + " is not enabled")
	return false	;	Disabled actor, can't be used
endif
If !NPCActor.HasKeyword(ActorTypeNPC)  ; Not marked as a NPC
	SLV_DisplayDebug1(NPCActorBase.GetName() + " is not an actortypenpc")
	return false
endif
if NPCActor.IsDead()
	SLV_DisplayDebug1(NPCActorBase.GetName() + " is dead")
	return false	;	They're dead already
endif
if NPCActor.IsChild() 
	SLV_DisplayDebug1(NPCActorBase.GetName() + " is a child")
	return false	;	No children
endif
if !NPCActor.IsInFaction(CurrentFollowerFaction)
	SLV_DisplayDebug1(NPCActorBase.GetName() + " is no follower")
	return false	;	No follower
endif
return true
EndFunction
Keyword Property ActorTypeNPC auto


Potion Property Skooma auto
Potion Property DDSkooma auto
Potion Property SleepingTreeSap auto


Function SLV_ForcedDrugging()
if Game.GetModByName("SexLabSkoomaWhore.esp") == 255
	return
endif

;Potion Skooma = Game.GetFormFromFile(0x343F2, "SexLabSkoomaWhore.esp") as Potion
;Potion DDSkooma  = Game.GetFormFromFile(0x343F2, "SexLabSkoomaWhore.esp") as Potion
;Potion SleepingTreeSap  = Game.GetFormFromFile(0x343F2, "SexLabSkoomaWhore.esp") as Potion

Potion RoseOfAzura  = Game.GetFormFromFile(0x14980, "SexLabSkoomaWhore.esp") as Potion
Potion BoethiasDeception  = Game.GetFormFromFile(0x169ea, "SexLabSkoomaWhore.esp") as Potion
Potion ThiefsDelight  = Game.GetFormFromFile(0x174bd, "SexLabSkoomaWhore.esp") as Potion
Potion TheSecondBrain  = Game.GetFormFromFile(0x17a2f, "SexLabSkoomaWhore.esp") as Potion
Potion ElendrsFlask  = Game.GetFormFromFile(0x17a3e, "SexLabSkoomaWhore.esp") as Potion
Potion TheContortionist  = Game.GetFormFromFile(0x17fb0, "SexLabSkoomaWhore.esp") as Potion
Potion MorgulsTouch  = Game.GetFormFromFile(0x18521, "SexLabSkoomaWhore.esp") as Potion
Potion ToughFlesh  = Game.GetFormFromFile(0x18a94, "SexLabSkoomaWhore.esp") as Potion
Potion OcatosPallatine  = Game.GetFormFromFile(0x19003, "SexLabSkoomaWhore.esp") as Potion
Potion MagesFriend  = Game.GetFormFromFile(0x19011, "SexLabSkoomaWhore.esp") as Potion
Potion TheArchMage  = Game.GetFormFromFile(0x19022, "SexLabSkoomaWhore.esp") as Potion
Potion VerminasPrice  = Game.GetFormFromFile(0x19aea, "SexLabSkoomaWhore.esp") as Potion
Potion LeafSkooma  = Game.GetFormFromFile(0x1a05f, "SexLabSkoomaWhore.esp") as Potion
Potion HerbTea  = Game.GetFormFromFile(0x1a064, "SexLabSkoomaWhore.esp") as Potion
Potion PurifingSolution  = Game.GetFormFromFile(0x1a065, "SexLabSkoomaWhore.esp") as Potion 

int Drug = Utility.RandomInt(1,14)

if Drug == 1
	PlayerRef.EquipItem(Skooma)
elseif Drug == 2
	PlayerRef.EquipItem(RoseOfAzura )
elseif Drug == 3
	PlayerRef.EquipItem(BoethiasDeception )
elseif Drug == 4
	PlayerRef.EquipItem(ThiefsDelight )
elseif Drug == 5
	PlayerRef.EquipItem(TheSecondBrain )
elseif Drug == 6
	PlayerRef.EquipItem(ElendrsFlask )
elseif Drug == 7
	PlayerRef.EquipItem(TheContortionist )
elseif Drug == 8
	PlayerRef.EquipItem(MorgulsTouch )
elseif Drug == 9
	PlayerRef.EquipItem(OcatosPallatine )
elseif Drug == 10
	PlayerRef.EquipItem(MagesFriend )
elseif Drug == 11
	PlayerRef.EquipItem(TheArchMage )
elseif Drug == 12
	PlayerRef.EquipItem(VerminasPrice )
elseif Drug == 13
	PlayerRef.EquipItem(LeafSkooma )
else	
	PlayerRef.EquipItem(DDSkooma )
endif
EndFunction



String Function SLV_GetArenaTitle()
int lvl = 5
String arenatitle = ""

while lvl >= 0
	arenatitle = SLV_GetArenaTitleForLevel(lvl)
	if(arenatitle != "")
		return arenatitle
	endif
	lvl = lvl - 1
endWhile
return ""
EndFunction


String Function SLV_GetArenaTitleForLevel(int level)
int arenawon = SLV_ArenaFightsWon.getValue() as int
String File = "../Slaverun/SlaverunConfig.json"

String fightlvlneeded = "arenawonrequired" + level
String fightlvltitle = "arenatitle" + level
int fightsneeded = JsonUtil.GetIntValue(File, fightlvlneeded,0 )
if(arenawon >= fightsneeded) 
	return JsonUtil.GetStringValue(File, fightlvltitle,"")
endif
return ""
EndFunction


bool Function SLV_IsArenaMaxLevelReached()
int arenawon = SLV_ArenaFightsWon.getValue() as int
String File = "../Slaverun/SlaverunConfig.json"
String fightlvlneeded = "arenawonrequired5"
int fightsneeded = JsonUtil.GetIntValue(File, fightlvlneeded,0 )

SLV_DisplayDebug1("Fights wone: " + arenawon + " Fights needed: " + fightsneeded)
if arenawon >= fightsneeded
	return true
else
	return false
endif
EndFunction


String Function SLV_GetSlaveTitle()
int lvl = 5
String slavetitle = ""

while lvl >= 0
	slavetitle = SLV_GetSlaveTitleForLevel(lvl)
	if(slavetitle != "")
		return slavetitle
	endif
	lvl = lvl - 1
endWhile
return ""
EndFunction


String Function SLV_GetSlaveTitleForLevel(int level)
int tasksdone = SLV_WhiterunTasksDone.getValue() as int
String File = "../Slaverun/SlaverunConfig.json"

String tasklvlneeded = "slaveruntaskrequired" + level
String tasklvltitle = "slaveruntaskslavetitle" + level

if PlayerRef.IsInFaction(SlaverunSlaveFaction)
	tasklvltitle = "slaveruntaskslavetitle" + level
elseif PlayerRef.IsInFaction(SlaverunSlaverFaction)
	tasklvltitle = "slaveruntaskslavertitle" + level
else
	tasklvltitle = "slaveruntaskfreetitle" + level
endif
int tasksneeded = JsonUtil.GetIntValue(File, tasklvlneeded,0 )
if(tasksdone >= tasksneeded) 
	return JsonUtil.GetStringValue(File, tasklvltitle,"")
endif
return ""
EndFunction


bool Function SLV_IsSlaveMaxLevelReached()
int tasksdone = SLV_WhiterunTasksDone.getValue() as int
String File = "../Slaverun/SlaverunConfig.json"
String tasklvlneeded = "slaveruntaskrequired5"
int tasksneeded = JsonUtil.GetIntValue(File, tasklvlneeded,0 )

SLV_DisplayDebug1("Tasks done: " + tasksdone + " Tasks needed: " + tasksneeded)
if tasksdone >= tasksneeded
	return true
else
	return false
endif
EndFunction
GlobalVariable Property SLV_WhiterunMaxTask Auto 
GlobalVariable Property SLV_WhiterunTask Auto 
GlobalVariable Property SLV_WhiterunTasksDone Auto 
GlobalVariable Property SLV_ArenaFightsWon Auto 


Function SLV_CleanUpPackages()
ActorUtil.RemoveAllPackageOverride(SLV_Follow)
ActorUtil.RemoveAllPackageOverride(SLV_DragonsreachCenter)
ActorUtil.RemoveAllPackageOverride(SLV_DragonsreachLeft)
ActorUtil.RemoveAllPackageOverride(SLV_DragonsreachCross1)
ActorUtil.RemoveAllPackageOverride(SLV_DragonsreachCross2)
ActorUtil.RemoveAllPackageOverride(SLV_DragonsreachDungeon)
EndFunction
Package Property SLV_Follow auto
Package Property SLV_DragonsreachCenter auto
Package Property SLV_DragonsreachLeft auto
Package Property SLV_DragonsreachCross1 auto
Package Property SLV_DragonsreachCross2 auto
Package Property SLV_DragonsreachDungeon auto

Function SLV_DisplayUser(String MyMessage)
	SLV_DisplayAMessage(0, MyMessage)
EndFunction
Function SLV_DisplayInformation(String MyMessage)
	SLV_DisplayAMessage(1, MyMessage)
EndFunction
Function SLV_DisplayDebug1(String MyMessage)
	SLV_DisplayAMessage(2, MyMessage)
EndFunction
Function SLV_DisplayDebug2(String MyMessage)
	SLV_DisplayAMessage(3, MyMessage)
EndFunction

Function SLV_DisplayAMessage(Int MessageType, String MyMessage)
	Bool Screen = false
	Bool Console = false
	Bool Log = false
	String ConsoleAndLogMessage = "Slaverun: " + MyMessage + " MT=" + MessageType	
	if MessageType == 0
		Screen = MCMMenu.MTUserScreen
		Console = MCMMenu.MTUserConsole
		Log = MCMMenu.MTUserLog
	elseif MessageType == 1
		Screen = MCMMenu.MTInformationScreen
		Console = MCMMenu.MTInformationConsole
		Log = MCMMenu.MTInformationLog
	elseif MessageType == 2
		Screen = MCMMenu.MTDebug1Screen
		Console = MCMMenu.MTDebug1Console
		Log = MCMMenu.MTDebug1Log
	elseif MessageType == 3
		Screen = MCMMenu.MTDebug2Screen
		Console = MCMMenu.MTDebug2Console
		Log = MCMMenu.MTDebug2Log
	else
		; Unknown type - do nothing with it
	endif
	if Screen
		debug.Notification(MyMessage)
	endif
	if Console
		MiscUtil.PrintConsole(ConsoleAndLogMessage)
	endif
	if Log
		debug.Trace(ConsoleAndLogMessage)
	endif
EndFunction
SLV_MCMMenu Property MCMMenu Auto
SLV_DeviousDevices Property deviousDevices Auto
