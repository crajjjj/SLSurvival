Scriptname dcc_sgo_QuestController extends Quest
{The main API controlpoint for Soulgem Oven 3.}
	
;/*****************************************************************************
	_______             __                          _______                   
 |   _   .-----.--.--|  .-----.-----.--------.   |   _   .--.--.-----.-----.
 |   1___|  _  |  |  |  |  _  |  -__|        |   |.  |   |  |  |  -__|     |
 |____   |_____|_____|__|___  |_____|__|__|__|   |.  |   |\___/|_____|__|__|
 |:  1   |              |_____|                  |:  1   |                  
 |::.. . |                                       |::.. . |                  
 `-------'                                       `-------'                  
	 __   __              _______ __    __         __                       
	|  |_|  |--.-----.   |       |  |--|__.----.--|  |                      
	|   _|     |  -__|   |.|   | |     |  |   _|  _  |                      
	|____|__|__|_____|   `-|.  |-|__|__|__|__| |_____|                      
	                       |:  |                                            
	                       |::.|                                            
	                       `---'                                            

*****************************************************************************/;

;; >
;; THERE ARE ONLY 6 SOULGEM
;; MODELS.

Int Function GetVersion() Global
{report a version number. this is new to sgo3. the first public release will
report 300, following the same system i have for the versioning in the past.}

	Return 310
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; StorageUtil Keys (Global) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FormList SGO.ActorList.Gem - list all actors currently growing gems.
;; FormList SGO.ActorList.Milk - list all actors currently producing milk.
;; FormList SGO.ActorList.Semen - list all the actors producing semen.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; StorageUtil Keys (Actor) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Float    SGO.Actor.Gem.Time - the last time actor's gem data updated.
;; Float[]  SGO.Actor.Gem.Data - the gem data for this actor.
;; Float    SGO.Actor.Milk.Time - the last time actor's milk data updated.
;; Float    SGO.Actor.Milk.Data - the milk data for this actor.
;; Float    SGO.Actor.Semen.Time - the last time actor semen data was updated.
;; Float    SGO.Actor.Semen.Data - the semen data for this actor.
;; Float    SGO.Actor.Fertility.Time - the last time actor's fertility updated.
;; Float    SGO.Actor.Fertility.Data - the fertility data for this actor.
;; String[x] SGO.Actor.Mod.Belly.Encumber
;; String[x] SGO.Actor.Mod.Belly.Scale
;; String[x] SGO.Actor.Mod.Belly.ScaleMax
;; String[x] SGO.Actor.Mod.Breast.Influence
;; String[x] SGO.Actor.Mod.Breast.Scale
;; String[x] SGO.Actor.Mod.Breast.ScaleMax
;; String[x] SGO.Actor.Mod.Testicle.Scale
;; String[x] SGO.Actor.Mod.Testicle.ScaleMax
;; String[x] SGO.Actor.Mod.Gem.Capacity (multiply %)
;; String[x] SGO.Actor.Mod.Gem.Rate (multiply %)
;; String[x] SGO.Actor.Mod.Milk.Capacity (multiply %)
;; String[x] SGO.Actor.Mod.Milk.Rate (multiply %)
;; String[v] SGO.Actor.Mod.Milk.Produce (install 1 to force without preg)
;; String[x] SGO.Actor.Mod.Semen.Capacity (multiply %)
;; String[x] SGO.Actor.Mod.Semen.Rate (multiply %)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Method List ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; these are the methods which have been designed to be used by mods that wish
;; to integrate with soulgem oven.

;; Int   SGO.ActorGemGetCapacity(Actor Who)
;; Float SGO.ActorGemGetTime(Actor Who)
;; Float SGO.ActorGemGetWeight(Actor Who)
;; Int   SGO.ActorMilkGetCapacity(Actor Who)
;; Float SGO.ActorMilkGetTime(Actor Who)
;; Float SGO.ActorMilkGetWeight(Actor Who)
;; Int   SGO.ActorSemenGetCapacity(Actor Who)
;; Float SGO.ActorSemenGetTime(Actor Who)
;; Float SGO.ActorSemenGetWeight(Actor Who)

;; Float SGO.ActorGetTimeSinceUpdate(Actor Who, String What)
;; Void  SGO.ActorSetTimeUpdated(Actor Who, String What[, Float When])

;; Void  SGO.ActorTrackForGems(Actor Who, Bool Enabled)
;; Void  SGO.ActorTrackForMilk(Actor who, Bool Enabled)
;; Void  SGO.ActorTrackForSemen(Actor who, Bool Enabled)

;; Float SGO.ActorModGetTotal(Actor Who, String What)
;; Float SGO.ActorModGetMultiplier(Actor Who, String What)
;; Float SGO.ActorModGetValue(Actor Who, String What, String ModKey)
;; Void  SGO.ActorModSetValue(Actor Who, String What, String ModKey, Float Value)
;; Void  SGO.ActorModUnsetValue(Actor Who, String What, String ModKey)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Event List ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; events emitted by this mod that can be watched for by mods that wish to
;; integrate with soulgem oven.

;; SGO.OnGemProgress ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Actor Who, Int No, Int Pet, Int Les, Int Com, Int Gre, Int Gra, Int Bla
;; This event describes the number of gems the specified actor is carrying in
;; the various states of development. It is emitted any time a gem crosses
;; into the next stage.

;; SGO.OnMilkProgress ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Actor Who, Int Amount
;; This event describes how many bottles of milk the specified actor is
;; carrying. It is emitted any time another whole bottle is ready.

;; SGO.OnSemenProgress ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Actor Who, Int Amount
;; This event describes how many bottles of semen the specified actor is
;; carrying. It is emitted any time another whole bottle is ready.

;; SGO.OnBirthed ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Actor Who, Form What
;; This event describes an object that was just birthed from the specified
;; actor.

;; SGO.OnMilked ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Actor Who, Form What
;; This event describes an object that was just milked from the specific actor.

;; SGO.OnWanked ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Actor Who, Form What
;; This event describes an object that was just wanked from the specific actor.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NiOverride Keys ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; NPC Belly -> SGO.Inflate
;; NPC Belly -> SGO.Scale
;; NPC L Breast -> SGO.Scale
;; NPC R Breast -> SGO.Scale
;; NPC GenitalsScrotum [GenScrot] -> SGO.Scale

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Forcing Milk Production ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; so you want to make a mod that forces an actor to produce milk without being
;; pregnant? the following TWO lines of code are what you need to make it start
;; happening.
;;
;; SGO.ActorModSetValue(Who,"Milk.Produce","YourModName",1.0)
;; SGO.ActorTrackForMilk(Who,TRUE)
;;
;; at some point, your mod will need to make it stop. the following ONE line of
;; code is what you need to stop it.
;;
;; SGO.ActorModUnsetValue(Who,"Milk.Produce","YourModName")
;; 
;; note - when you want to stop generating milk do not undo the tracking for
;; milk. SGO will automatically stop tracking as soon as all mods have removed
;; their desire for production.
;;

;/*****************************************************************************
	                                __   __             
 .-----.----.-----.-----.-----.----|  |_|__.-----.-----.
 |  _  |   _|  _  |  _  |  -__|   _|   _|  |  -__|__ --|
 |   __|__| |_____|   __|_____|__| |____|__|_____|_____|
 |__|             |__|                                  

*****************************************************************************/;

Bool Property Enabled = TRUE Auto hidden
{if the mod should be allowed to do things.}

Bool Property OK = FALSE Auto Hidden
{this will be set to true if everything this mod needs to run has been found
and accessible during startup or reset.}

Actor Property Player Auto
{maintain a pointer to player. set via ck.}

SexLabFramework Property SexLab Auto Hidden
{the sexlab framework scripting. it will be set by the dependency checker.}

Static Property StaticXMarker Auto
{the xmarker from the game,}

;/*****************************************************************************
	                __      ___                           
 .--------.-----.--|  |   .'  _.-----.----.--------.-----.
 |        |  _  |  _  |   |   _|  _  |   _|        |__ --|
 |__|__|__|_____|_____|   |__| |_____|__| |__|__|__|_____|

*****************************************************************************/;

dcc_sgo_QuestController_UpdateLoop Property UpdateLoop Auto
{the script that will handle the update queue. set via ck.}

Faction Property dcc_sgo_FactionCannotProduceGems Auto
{prevent an actor from producing gems if it normally could.}

Faction Property dcc_sgo_FactionCanProduceGems Auto
{allow an actor to produce gems if it normally could not.}

Faction Property dcc_sgo_FactionCannotProduceMilk Auto
{prevent an actor from producing milk if it normally could.}

Faction Property dcc_sgo_FactionCanProduceMilk Auto
{allow an actor to produce milk if it normally could not}

Faction Property dcc_sgo_FactionCannotInseminate Auto
{prevent an actor from inseminating others if it normally could.}

Faction Property dcc_sgo_FactionCanInseminate Auto
{allow an actor to inseminate others if it normally could not.}

Faction Property dcc_sgo_FactionDisableScaleBreast Auto
{prevent an actor from scaling the breast nodes.}

Faction Property dcc_sgo_FactionDisableScaleBelly Auto
{prevent an actor from scaling the belly node.}

Faction Property dcc_sgo_FactionDisableScaleTesticle Auto
{prevent an actor from scaling the testicle node.}

FormList Property dcc_sgo_ListMilkItems Auto
{form list of milks. this list needs to line up with the two race lists.}

FormList Property dcc_sgo_ListMilkPot Auto
{form list of milk potions. this list needs to line up with the race lists.}

FormList Property dcc_sgo_ListSemenItems  Auto
{form list of semens. it needs to line up with the race lists.}

FormList Property dcc_sgo_ListRaceNormal Auto
{form list of normal races. this list needs to line up with the milk list.}

FormList Property dcc_sgo_ListRaceVampire Auto
{form list of vampire races. this list needs to line up with the milk list.}

FormList Property dcc_sgo_ListGemEmpty Auto
{form list of full gems.}

FormList Property dcc_sgo_ListGemFull Auto
{form list of empty gems.}

FormList Property dcc_sgo_ListGemFragment Auto
{form list of gem fragments.}

Package Property dcc_sgo_PackageDoNothing Auto
{a package to force an actor to do nothing.}

Spell Property dcc_sgo_SpellBellyEncumber Auto
{spell that emcumbers you with belly size.}

Spell Property dcc_sgo_SpellBellyBonus Auto
{spell that gives you bonus health and mana with belly size.}

Spell Property dcc_sgo_SpellBellyDamage Auto
{spell that handles damage to growing gems.}

Spell Property dcc_sgo_SpellBreastInfluence Auto
{spell that increases barter ability with boob size.}

Spell Property dcc_sgo_SpellDeflate Auto
{the cum deflation effect.}

Spell Property dcc_sgo_SpellDeflateTrigger Auto
{manual trigger for deflation.}

Spell Property dcc_sgo_SpellInflate Auto
{the cum inflation effect.}

Spell Property dcc_sgo_SpellMenuMain Auto
{the spell to trigger the main menu.}

ImageSpaceModifier Property dcc_sgo_ImodMenu Auto
{to tint the screen the classic sgo shade of purple on menus.}

Armor Property dcc_sgo_ArmorSquirtingCum Auto
{fx object for squirting.}

;/*****************************************************************************
	                __                       ___ __       
 .--------.-----.--|  |   .----.-----.-----.'  _|__.-----.
 |        |  _  |  _  |   |  __|  _  |     |   _|  |  _  |
 |__|__|__|_____|_____|   |____|_____|__|__|__| |__|___  |
	                                               |_____|

*****************************************************************************/;

;; gem options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Float Property OptGemMatureTime = 144.0 Auto Hidden
{how many hours for a gem to mature. default 144 = 6 days.}

Int Property OptGemMaxCapacity = 6 Auto Hidden
{how many gems can be carried at one time.}

Bool Property OptGemFilled = TRUE Auto Hidden
{if we should give filled gems or empty gems.}

;; milk options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Float Property OptMilkProduceTime = 8.0 Auto Hidden
{how many hours for milk to produce. default 8 = 3 per day.}

Int Property OptMilkMaxCapacity = 3 Auto Hidden
{how many bottles of milk can be carried at one time.}

Float Property OptMilkLeakThresh = 0.8 Auto Hidden
{at what capacity percentage the milk leak texture should start showing.}

Bool Property OptMilkLeakClear = TRUE Auto Hidden
{clear the milk leaking immediately after milking.}

;; semen options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Float Property OptSemenProduceTime = 12.0 Auto Hidden
{how many hours for semen to produce.}

Int Property OptSemenMaxCapacity = 2 Auto Hidden
{how many bottles of semen can be carried at a time.}

;; body scaling options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Float Property OptScaleBellyCum = 2.0 Auto Hidden
{how much to scale with cum inflation.}

FLoat Property OptScaleBellyCurve = 1.75 Auto Hidden 
{the value that tweaks the curve for bellies.}

Float Property OptScaleBellyMax = 5.0 Auto Hidden
{the maximum size of the belly when full up.}

Float Property OptScaleBellyHigh = 0.0 Auto Hidden
{modifier while at the high end of the weight scale}

Float Property OptScaleBreastCurve = 1.5 Auto Hidden
{the value that tweaks the curve for breasts.}

Float Property OptScaleBreastMax = 3.5 Auto Hidden
{the maximum size of the breasts when filled up.}

Float Property OptScaleBreastHigh = 0.0 Auto Hidden
{modifier while at the high end of the weight scale}

Float Property OptScaleTesticleCurve = 1.25 Auto Hidden
{the value that scales the curve for testicles.}

Float Property OptScaleTesticleMax = 2.0 Auto Hidden
{the maximum size of the testicles when filled up.}

;; pregnancy options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Int Property OptPregChanceHumanoid = 50 Auto Hidden
{preg chance on encounters with people.}

Int Property OptPregChanceBeast = 10 Auto Hidden
{preg chance on encounters with beasts.}

Bool Property OptPregIncludeAnal = TRUE Auto Hidden
{if anal should be considered inseminable, since the animations are nearly
impossible to tell by looking at them.}

Bool Property OptFertility = TRUE Auto Hidden
{if to enable fertility multiplier or not.}

Int Property OptFertilityDays = 28 Auto Hidden
{how many days for a complete cycle. 0 to disable fertility.}

Float Property OptFertilityWindow = 2.0 Auto Hidden
{this is how wide the fertility is. 2.0 = twice as likely.}

;; immersion options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Bool Property OptImmersivePlayer = TRUE Auto Hidden
{if we should show messages about the player state.}

Bool Property OptImmersiveNPC = TRUE Auto Hidden
{if we should show messages about npc states.}

Bool Property OptEffectBreastInfluence = TRUE Auto Hidden
{if the breast influence buff/debuffs should be applied.}

Bool Property OptEffectBellyEncumber = TRUE Auto Hidden
{if the belly encumberment buff/debuff should be applied.}

Bool Property OptEffectBellyBonus = TRUE Auto Hidden
{if the belly bonus buff should be applied.}

Bool Property OptEffectBellyDamage = TRUE Auto Hidden
{if taking damage should be detrimental to your gems.}

Bool Property OptCumInflation = TRUE Auto Hidden
{if to enable cum inflation or not.}

Bool Property OptCumInflationHold = TRUE Auto Hidden
{if cum should be held in or leaked out.}

Int Property OptAnimationBirthing = -1 Auto Hidden
{-1 = random animation every gem. 0 = random animation every birthing set. other
values stand for the configured animations.}

Int Property OptBellyDamageChance = 10 Auto Hidden
{chance a gem will get damaged on hit}

Int Property OptBellyDamageChancePower = 25 Auto Hidden
{chance a gem will get damaged when it with a power attack}

Float Property OptBellyDamageMax = 0.2 Auto Hidden
{max value a gem can be hurt for}

Float Property OptBellyDamageMaxPower = 0.4 Auto Hidden
{max value a gem can be hurt for by a power attack}

Int Property OptAchievementActorGemGrowth = 100 Auto Hidden
{how many gem levels to get incubator achive}

Int Property OptAchievementActorMilkProduce = 100 Auto Hidden
{how many bottles to milk to get moomoo achive}

Int Property OptAchievementActorInserts = 100 Auto Hidden
{how many gems you have to insert to get unbirthing}

;; leveling options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Float Property OptProgressAlchFactor = 1.0 Auto Hidden
{how fast alchemy should level by milking.}

Float Property OptProgressEnchFactor = 1.0 Auto Hidden
{how fast enchanting should level by birthing.}

;; mod options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Bool Property OptDebug = TRUE Auto Hidden
{print debugging information out to the console}

Bool Property OptEnableMenuImod = FALSE Auto Hidden
{if the purple fade should play and time wasted.}

Bool Property OptKickThingsWithHavok = TRUE Auto Hidden
{if dropped items should be kicked.}

Float Property OptUpdateInterval = 20.0 Auto Hidden
{how long to wait before beginning the calculation queue again.}

Float Property OptUpdateDelay = 0.125 Auto Hidden
{how long to delay the update loop each iteration.}

Bool Property OptValidateActor = TRUE Auto Hidden
{used to disable the use of sexlab's validate actor to debug why an actor may
not be working. usually because its a creature that has no animation or
someshit like that.}

Bool Property OptUntamedPregChance = TRUE Auto Hidden
{integrate with untamed so the untamed level increases pregchance with
beasts.}

Bool Property OptResetNodeOnDisable = TRUE Auto Hidden
{reset the bones when they are disabled.}

Bool Property OptResetDataOnDisable = TRUE Auto Hidden
{drop all the preg/milk/semen data when that function is disabled.}

Bool Property OptSexlabStrip = TRUE Auto Hidden
{if we should use sexlab's stripping options.}

Bool Property OptAchievements = TRUE Auto Hidden
{if we should do Achievements lol}

Bool Property OptAchievementBonus = TRUE Auto Hidden
{if there should be a bonus effect for Achievements.}

;; constants ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Int Property BioProduceGems = 1  AutoReadOnly
Int Property BioProduceMilk = 2  AutoReadOnly
Int Property BioInseminate  = 4  AutoReadOnly
Int Property BioIsBeast     = 8  AutoReadOnly
Int Property BioInflate     = 16 AutoReadOnly

;/*****************************************************************************
	                 __                      __              __ 
 .--------.-----.--|  |   .----.-----.-----|  |_.----.-----|  |
 |        |  _  |  _  |   |  __|  _  |     |   _|   _|  _  |  |
 |__|__|__|_____|_____|   |____|_____|__|__|____|__| |_____|__|

*****************************************************************************/;

Function ResetMod()
{perform a quest (and ergo mod) reboot. quest RunOnce is disabled so that we
trigger OnInit() to finish the deal.}

	self.Reset()
	Utility.Wait(0.25)
	self.Stop()
	Utility.Wait(0.25)
	self.Start()

	Return
EndFunction

Function ResetMod_Prepare()
{check that everything this mod needs to run exists and is ready.}

	If(!self.IsInstalledNiOverride())
		Return
	EndIf

	If(!self.IsInstalledUIExtensions())
		Return
	EndIf

	If(!self.IsSexLabInstalled())
		Return
	EndIf

	If(!self.IsPapyrusUtilInstalled())
		Return
	EndIf

	self.OK = TRUE
	Return
EndFunction

Function ResetMod_Values()
{force reset settings to default values.}

	self.OptGemMatureTime = 144.0
	self.OptGemMaxCapacity = 6
	self.OptGemFilled = TRUE
	self.OptMilkProduceTime = 8.0
	self.OptMilkMaxCapacity = 3
	self.OptMilkLeakThresh = 0.8
	self.OptMilkLeakClear = TRUE
	self.OptSemenProduceTime = 12.0
	self.OptSemenMaxCapacity = 2
	self.OptScaleBellyCurve = 1.75
	self.OptScaleBellyMax = 5.0
	self.OptScaleBreastCurve = 1.50
	self.OptScaleBreastMax = 3.5
	self.OptScaleTesticleCurve = 1.25
	self.OptScaleTesticleMax = 2.0
	self.OptProgressEnchFactor = 1.0
	self.OptProgressAlchFactor = 1.0
	self.OptFertility = TRUE
	self.OptFertilityWindow = 2.0
	self.OptFertilityDays = 28
	self.OptCumInflation = TRUE
	self.OptCumInflationHold = FALSE
	self.OptEffectBreastInfluence = TRUE
	self.OptEffectBellyEncumber = TRUE
	self.OptPregChanceHumanoid = 75
	self.OptPregChanceBeast = 10
	self.OptImmersivePlayer = TRUE
	self.OptImmersiveNPC = TRUE
	self.OptDebug = TRUE
	self.OptEnableMenuImod = FALSE
	self.OptKickThingsWithHavok = TRUE
	self.OptUpdateInterval = 20.0
	self.OptUpdateDelay = 0.125

	Return
EndFunction

Function ResetMod_Spells()
{force refresh of the spells.}

	self.Player.RemoveSpell(self.dcc_sgo_SpellMenuMain)
	Utility.Wait(1.0)
	self.Player.AddSpell(self.dcc_sgo_SpellMenuMain,TRUE)

	Return
EndFunction

Function ResetMod_Events()
{cleanup and reinit of any event handling things.}

	self.UnregisterForModEvent("SexLabActorGenderChange")
	self.UnregisterForModEvent("OrgasmStart")
	self.UpdateLoop.UnregisterForUpdate()

	If(!self.OK)
		;; we allowed this method to do a cleanup, but if the mod is not
		;; satisified we will not re-engage events.
		Return
	EndIf

	self.RegisterForModEvent("SexLabActorGenderChange","OnGenderChange")
	self.RegisterForModEvent("OrgasmStart","OnEncounterEnding")
	self.UpdateLoop.RegisterForSingleUpdate(self.OptUpdateInterval)
	Return
EndFunction

Function UninstallMod(Bool Prompt=TRUE)
{delete all the data that it can from storageutil.}

	StorageUtil.ClearAllPrefix("SGO.")
	self.OK = FALSE
	self.Enabled = FALSE

	If(Prompt)
		String Msg = "All SGO3 data has been removed from your co-save. "
		Msg += "Close all menus, save your game, and then it is safe to "
		Msg += "remove the mod files from your computer."

		Debug.MessageBox(Msg)
	EndIf

	Return
EndFunction

Function ReinstallMod() 
{attempt to seriously reinstall this mod to make it feel like a new game.
blow anyway all previous data and reset.}

	self.UninstallMod(FALSE)
	self.ResetMod()

	Return
EndFunction

Function ResetActor(Actor Who)
{delete all the data in storage util for a specific actor to make it like sgo
never even touched it.}

	;; ask ashal why there is no ClearAllPrefix that works with the object to
	;; provide scope before i go writing a 50 line long clear func.

	Return
EndFunction

;/*****************************************************************************
	    __   __ __ __ __              ___                  
 .--.--|  |_|__|  |__|  |_.--.--.   .'  _.--.--.-----.----.
 |  |  |   _|  |  |  |   _|  |  |   |   _|  |  |     |  __|
 |_____|____|__|__|__|____|___  |   |__| |_____|__|__|____|
	                      |_____|                          
	                                                       
*****************************************************************************/;

Function FormListLock(Form Scope, String Name, String CalledBy="Unknown")
{create a spinlock for a formlist.}

	Int Count = 0

	While(StorageUtil.GetStringValue(Scope,(Name+"--FormListLock")) != "")
		Count += 1
		self.PrintDebug(CalledBy + "(" + Count + ") spinning from " + StorageUtil.GetStringValue(Scope,(Name+"--FormListLock")))
		Utility.Wait(0.25)
	EndWhile

	StorageUtil.SetStringValue(Scope,(Name+"--FormListLock"),CalledBy)
	;;self.PrintDebug("Locking " + Name)
EndFunction

Function FormListUnlock(Form Scope, String Name)
{release a spinlock for a formlist.}

	StorageUtil.UnsetStringValue(Scope,(Name+"--FormListLock"))
	;;self.PrintDebug("Unlocking " + Name)
EndFunction

Function FormListFlushLost(Form Scope, String Name)
{forcably remove anything from the specified form list if it retrieves from
storage as None.}

	self.FormListLock(Scope,Name,"FormListFlushLost")

	Int Count = 0
	Int Len = StorageUtil.FormListCount(Scope,Name)
	Int Iter = 0
	Form What 

	While(Iter < Len)
		What = StorageUtil.FormListGet(Scope,Name,Iter)

		If(What == None)
			StorageUtil.FormListRemoveAt(Scope,Name,Iter)
			Len -= 1
			Count += 1
		Else
			Iter += 1
		EndIf
	EndWhile

	If(Count > 0)
		self.PrintDebug("flushed " + Count + " killed/lost/trashed refs from " + Name)
		self.PrintLog("flushed " + Count + " killed/lost/trashed refs from " + Name)
	EndIf

	self.FormListUnlock(Scope,Name)

	Return
EndFunction

String Function ChooseRandomString(String[] What)
{given an array choose a random string from it. we will use this for things
like printing random messages or choosing random animations.}

	Int Offset = Utility.RandomInt(0,(What.Length - 1))
	self.PrintLog("Choosing Random String " + Offset + " of " + (What.Length - 1))
	
	Return What[Offset]
EndFunction

Function Print(String Msg)
{send a message to the notification area.}

	Debug.Notification("[SGO] " + Msg)
	Return
EndFunction

Function PrintDebug(String Msg)
{send a message to the console.}

	If(!self.OptDebug)
		Return
	EndIf

	MiscUtil.PrintConsole("[SGO] " + Msg)
	Return
EndFunction

Function PrintRandom(String[] MsgList)
{print a random one of the strings from a given array.}

	String Msg = self.ChooseRandomString(MsgList)
	self.PrintLog("Printing Random String: " + Msg)

	self.Print(Msg)
	Return
EndFunction

Function PrintLog(String Msg)
{print to log file}

	Debug.Trace("[SGO] " + Msg);
	Return
EndFunction

String Function GetGemName(Float Value)
{based on the gem value, return its short name. doing it here for intl later.}

	If(Value < 1)
		Return "Fragment"
	ElseIf(Value < 2)
		Return "Petty"
	ElseIf(Value < 3)
		Return "Lesser"
	ElseIf(Value < 4)
		Return "Common"
	ElseIf(Value < 5)
		Return "Greater"
	ElseIf(value < 6)
		Return "Grand"
	Else
		Return "Black"
	EndIf
EndFunction

Int Function GetGemValue(Form What)
{get the value of a gem, which also equals its formlist offset plus one.}

	FormList List
	Int Value

	Value = self.dcc_sgo_ListGemEmpty.Find(What)
	If(Value == -1)
		Value = self.dcc_sgo_ListGemFull.Find(What)
		If(Value == -1)
			Return 0
		EndIf
	EndIf

	Return (Value + 1)
EndFunction

Int Function GetGemStageCount()
{count how many things are in the gem list. we will (eventually) use this to
support dynamic stages depending on if the list has been modified.}

	If(self.OptGemFilled)
		Return self.dcc_sgo_ListGemFull.GetSize()
	Else
		Return self.dcc_sgo_ListGemEmpty.GetSize()
	EndIf
EndFunction

Float Function GetLeveledValue(Float Level, Float Value, Float Factor = 1.0)
{modify a value based on a level 100 system. this means at level 100 the input
value will be doubled.}
	
	;; scale 1 at level 0
	;; ((0 / 100) * 1) + 1 = 1

	;; scale 1 at level 1
	;; ((1 / 100) * 1) + 1 = 1.01

	;; scale 1 at level 50
	;; ((50 / 100) * 1) + 1 = 1.5

	;; scale 1 at level 100
	;; ((100 / 100) * 1) + 1 = 2.0

	Return (((level / 100.0) * (value * factor)) + value) as Float
EndFunction

String Function GetSexWord(Int Sex)
{get the word that describes what the sex is.}

	If(Sex == 0 || Sex == 2)
		Return "Male"
	Else
		Return "Female"
	EndIf
EndFunction

Function PlayDualAnimation(Actor Who1, String Ani1, Actor Who2, String Ani2)
{rig up and play stacked dual animations. sex without the lab.}

	If(self.ActorNoAnimate(Who1))
		Return
	EndIf

	If(self.ActorNoAnimate(Who2))
		Return
	EndIf

	ObjectReference Here = Who1.PlaceAtMe(self.StaticXMarker)
	Who1.SetVehicle(Here)
	Who2.SetVehicle(Here)

	;; about face...
	Who2.SetAngle(Who1.GetAngleX(),Who1.GetAngleY(),Who1.GetAngleZ())

	;; commit hillarious collision hack: the slomoroto
	Who1.SplineTranslateTo(Here.GetPositionX(),Here.GetPositionY(),Here.GetPositionZ(),Here.GetAngleX(),Here.GetAngleY(),(Here.GetAngleZ() + 0.01),1.0,500,0.001)
	Who2.SplineTranslateTo(Here.GetPositionX(),Here.GetPositionY(),Here.GetPositionZ(),Here.GetAngleX(),Here.GetAngleY(),(Here.GetAngleZ() + 0.01),1.0,500,0.001)

	;; and animate.
	Debug.SendAnimationEvent(Who1,Ani1)
	Debug.SendAnimationEvent(Who2,Ani2)

	;; yoink.
	Who1.SetVehicle(None)
	Who2.SetVehicle(None)
	Here.Delete()

	;; honestly i think the vehicle trick may not even be needed here.
	;; i just emulated this after sexlab and cleaned it up a bit. the
	;; slomoroto is the key here.

	Return
EndFunction

;; skeleton manipulation ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Float Function BoneCurveValue(Actor Who, String Bone, Float Value)
{curve the given Value based on the actors current value and the curve.}

	If(Value <= 1.0)
		Return Value;
	EndIf

	Float Curve = 2.0

	If(Bone == "NPC Belly" || Bone == "Belly")
		Curve = self.OptScaleBellyCurve
	ElseIf(Bone == "NPC L Breast" || Bone == "NPC R Breast" || Bone == "Breasts")
		Curve = self.OptScaleBreastCurve
	ElseIf(Bone == "NPC GenitalsScrotum [GenScrot]" || Bone == "NPC Testicles" || Bone == "Testicles")
		Curve = self.OptScaleTesticleCurve
	EndIf

	If(Curve == 2.0)
		;; the math works out such that 2.0 is no curving so skip the math.
		Return Value
	EndIf

	;; http://i.imgur.com/tHUAaME.png
	;; this curve was designed to accelerate visual response at lower scalings
	;; while dampening it at higher scalings to provide a more consistant
	;; feeling of volume, however it has curve pairity at 2.0 for all settings.
	;; curve of 2.0 = no curve. reasonable minimum is 0.5.
	;; Return Math.Sqrt(Math.Pow((Value - 1),Curve)) + 1

	;; http://i.imgur.com/Ylelmrr.png
	;; this curve lessens the ramp-up of the values and dampens sooner than
	;; the previous curve. curve of 2.0 = no curve. reasonable minimum is 1.0.
	;; belly - max 5.0 curve 1.75 1.75 = ~4 @ 5.0
	;; breast - max 2.0 curve 1.5 = ~1.75 @ 2.0
	;; testicle - max 2.0 curve 1.25 
	Return (Math.Sqrt(Math.Pow((Value - 1),Curve)) * (Curve / 2)) + 1
EndFunction

Bool Function BoneHasScale(Actor Who, String Bone, String ModKey)
{wrap nioverride, test if a bone scale exists.}

	If(Bone == "NPC Testicles")
		Bone = "NPC GenitalsScrotum [GenScrot]"
	EndIf

	Return NiOverride.HasNodeTransformScale((Who as ObjectReference),FALSE,(Who.GetLeveledActorBase().GetSex() == 1),Bone,ModKey)
EndFunction

Float Function BoneGetScale(Actor Who, String Bone, String ModKey)
{wrap nioverride, get a bone scale.}

	If(Bone == "NPC Testicles")
		Bone = "NPC GenitalsScrotum [GenScrot]"
	EndIf

	Float Value = NiOverride.GetNodeTransformScale((Who as ObjectReference),False,(Who.GetLeveledActorBase().GetSex() == 1),Bone,ModKey)

	If(Value != 0.0)
		Return Value
	Else
		;; because no scale couldn't have just been one point oh fucking zero
		;; which is the actual representation of "no scales" in nioverride.
		Return 1.0
	EndIf
EndFunction

Function BoneSetScale(Actor Who, String Bone, String ModKey, Float Value)
{wrap nioverride, set a bone scale.}

	If(Bone == "NPC Breasts")
		self.BoneSetScale(Who,"NPC L Breast",ModKey,Value)
		self.BoneSetScale(Who,"NPC R Breast",ModKey,Value)
		Return
	EndIf

	If(Bone == "NPC Testicles")
		Bone = "NPC GenitalsScrotum [GenScrot]"
	EndIf

	If(!NetImmerse.HasNode((Who as ObjectReference),Bone,FALSE))
		;; do not try if the node does not exist.
		Return
	EndIf

	If(Value != 1.0)
		NiOverride.AddNodeTransformScale((Who as ObjectReference),FALSE,(Who.GetLeveledActorBase().GetSex() == 1),Bone,ModKey,self.BoneCurveValue(Who,Bone,Value))
	Else
		NiOverride.RemoveNodeTransformScale((Who as ObjectReference),FALSE,(Who.GetLeveledActorBase().GetSex() == 1),Bone,ModKey)
	EndIf

	NiOverride.UpdateNodeTransform((Who as ObjectReference),FALSE,(Who.GetLeveledActorBase().GetSex() == 1),Bone)

	;;self.PrintDebug(Bone + " NiO: " + self.BoneGetScale(Who,Bone,ModKey))
	;;self.PrintDebug(Bone + " NetImm: " + NetImmerse.GetNodeScale((Who as ObjectReference),"NPC Belly",FALSE))

	Return
EndFunction

;; overlay manipulation ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

String Function ActorOverlayGetSlot(Actor Who, String OverlayName, Bool OursOnly=FALSE)
{find the next available overlay slot, or the slot we were already using.}

	String NodeName

	;; prefix the overlay name.

	OverlayName = "SGO.Actor.Overlay." + OverlayName

	;; see if we already selected a node.

	NodeName = StorageUtil.GetStringValue(Who,OverlayName)
	If(NodeName != "" || OursOnly)
		Return NodeName
	EndIf

	;; alright lets find an empty slot and gank it.

	Int NodeCount = NiOverride.GetNumBodyOverlays()
	Int NodeIter = 0
	Bool NodeSex = (Who.GetLeveledActorBase().GetSex() == 1)
	String NodeTexture

	While(NodeIter < NodeCount)
		NodeName = "Body [Ovl" + NodeIter + "]"
		NodeTexture = NiOverride.GetNodeOverrideString(Who,NodeSex,NodeName,9,0)

		If(NodeTexture == "" || NodeTexture == "textures\\Actors\\character\\overlays\\default.dds")
			;; mine now.
			StorageUtil.SetStringValue(Who,OverlayName,NodeName)
			Return NodeName
		EndIf

		NodeIter += 1
	EndWhile

	Return ""
EndFunction

Function ActorOverlayApply(Actor Who, String OverlayName, String Texture, Int Colour, Float Opacity)
{apply an overlay to an actor.}

	String NodeName = self.ActorOverlayGetSlot(Who,OverlayName,FALSE)
	Bool NodeSex = (Who.GetLeveledActorBase().GetSex() == 1)

	If(NodeName == "")
		;; we were unable to find a slot, or slots were disabled.
		Return
	EndIf

	;; setting the texture.
	NiOverride.AddNodeOverrideString(Who,NodeSex,NodeName,9, 0,Texture,TRUE)
	NiOverride.AddNodeOverrideFloat( Who,NodeSex,NodeName,8,-1,Opacity,TRUE)
	NiOverride.AddNodeOverrideInt(   Who,NodeSex,NodeName,7,-1,Colour, TRUE)
	;; NiOverride.AddNodeOverrideInt(Who,NodeSex,NodeName,0,-1,0,TRUE)
	;; NiOverride.AddNodeOverrideFloat(Who,NodeSex,NodeName,0,-1,1.0,TRUE)
	NiOverride.ApplyNodeOverrides(Who)


	Return
EndFunction

Function ActorOverlayClear(Actor Who, String OverlayName)
{remove our overlay and free the slot up.}

	String NodeName = self.ActorOverlayGetSlot(Who,OverlayName,TRUE)
	Bool NodeSex = (Who.GetLeveledActorBase().GetSex() == 1)

	If(NodeName == "")
		;; we were unable to find a slot we set.
		Return
	EndIF

	;;NiOverride.RemoveNodeOverride(Who,NodeSex,NodeName,9,0)
	;;NiOverride.RemoveNodeOverride(Who,NodeSex,NodeName,8,-1)
	;;NiOverride.RemoveNodeOverride(Who,NodeSex,NodeName,7,-1)
	NiOverride.RemoveAllNodeNameOverrides(Who,NodeSex,NodeName)
	NiOverride.AddNodeOverrideString(Who,NodeSex,NodeName,9,0,"textures\\Actors\\character\\overlays\\default.dds",TRUE)
	StorageUtil.UnsetStringValue(Who,("SGO.Actor.Overlay." + OverlayName))
	NiOverride.ApplyNodeOverrides(Who)

	Return
EndFunction

;; stat manipulation ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Function StatBump(Form Who, String What, Float Amount=1.0)
{incremement or decremement a stat on a form or global if none. bumping stats
will trigger Achievement checks.}

	Float OldValue = StorageUtil.AdjustFloatValue(Who,("SGO.Stat." + What),Amount)

	If(self.OptAchievements && Who as Actor)
		If(What == "GemGrowth")
			self.AchievementActorGemGrowth(Who as Actor,(OldValue + Amount))
		ElseIf(What == "MilkProduce")
			self.AchievementActorMilkProduce(Who as Actor,(OldValue + Amount))
		ElseIf(What == "Inserts")
			self.AchievementActorInserts(Who as Actor,(OldValue + Amount))
		EndIf
	EndIf

	Return
EndFunction

Float Function StatGetFloat(Form Who, String What)
{fetch the requested stat in its native float}

	Return StorageUtil.GetFloatValue(Who,("SGO.Stat." + What))
EndFunction

Int Function StatGetInt(Form Who, String What)
{fetch the requested stat as an integer}

	Return self.StatGetFloat(Who,What) as Int
EndFunction

Function AchievementActorGemGrowth(Actor Who, Float Value)
{Achievement: incubator}

	If(Value >= self.OptAchievementActorGemGrowth)
		If(self.ActorModGetValue(Who,"Gem.Rate","SGO.Achievement.GemGrowth") == 0.0)
			self.ActorModSetValue(Who ,"Gem.Rate","SGO.Achievement.GemGrowth",0.1)
			Debug.MessageBox(Who.GetDisplayName() + " Achievement: Incubator\nIncubated 100 levels worth of gems. They can now produce gems 10% faster than before.")
		EndIf
	EndIf

	Return
EndFunction

Function AchievementActorMilkProduce(Actor Who, Float Value)
{Achievement: moo moo}

	If(Value >= self.OptAchievementActorMilkProduce)
		If(self.ActorModGetValue(Who,"Milk.Rate","SGO.Achievement.MilkProduce") == 0.0)
			self.ActorModSetValue(Who,"Milk.Rate","SGO.Achievement.MilkProduce",0.1)
			Debug.MessageBox(Who.GetDisplayName() + " Achievement: Moo Moo\nProduced 100 bottles (25 litres) worth of milk. They can now produce milk 10% faster than before.")
		EndIf
	EndIf

	Return
EndFunction

Function AchievementActorInserts(Actor Who, Float Value)
{Achievement: unbirthing}

	If(Value >= self.OptAchievementActorInserts)
		If(self.ActorModGetValue(Who,"Gem.Capacity","SGO.Achievement.Inserts") == 0.0)
			self.ActorModSetValue(Who,"Gem.Capacity","SGO.Achievement.Inserts",1)
			Debug.MessageBox(Who.GetDisplayName() + " Achievement: Unbirthing\nForcefully inserted 100 gems. They can now hold an extra gem.")
		EndIf
	EndIf

	Return
EndFunction

;/*****************************************************************************
	 __                            __                        
 .--|  .-----.-----.-----.-----.--|  .-----.-----.----.--.--.
 |  _  |  -__|  _  |  -__|     |  _  |  -__|     |  __|  |  |
 |_____|_____|   __|_____|__|__|_____|_____|__|__|____|___  |
	         |__|                                     |_____|
	                                                         
*****************************************************************************/;

Bool Function IsInstalledNiOverride(Bool Popup=TRUE)
{make sure NiOverride is installed and active.}

	If(SKSE.GetPluginVersion("NiOverride") == -1)
		If(Popup)
			Debug.MessageBox("NiOverride not installed. Install it by installing RaceMenu or by installing it standalone from the Nexus.")
		EndIf
		Return FALSE
	EndIf

	Return TRUE
EndFunction

Bool Function IsInstalledUIExtensions(Bool Popup=TRUE)
{make sure UIExtensions is installed and active.}

	If(Game.GetModByName("UIExtensions.esp") == 255)
		If(Popup)
			Debug.MessageBox("UIExtensions not installed. Install it from the Nexus.")
		EndIf
		Return FALSE
	EndIf

	Return TRUE
EndFunction

Bool Function IsSexLabInstalled(Bool Popup=TRUE)
{make sure SexLab is installed and active.}

	If(Game.GetModByName("SexLab.esm") == 255)
		If(Popup)
			Debug.MessageBox("SexLab not installed. Install it from LoversLab.")
		EndIf
		Return FALSE
	EndIf

	self.SexLab = Game.GetFormFromFile(0xD62,"SexLab.esm") as SexLabFramework
	Return TRUE
EndFunction

Bool Function IsPapyrusUtilInstalled(Bool Popup=TRUE)
{make sure papyrus util is a version we need. if we test this after sexlab we
can basically promise it will be there. we need to make sure that shlongs of
skyrim though didn't fuck it up again with an older version, that will break
the use of AdjustFloatValue and the like.}

	If(PapyrusUtil.GetVersion() < 31)
		If(Popup)
			Debug.MessageBox("Your PapyrusUtil is too old or has been overwritten by something like SOS. Install PapyrusUtil 3.1 from LoversLab and make sure it dominates the load order.")
		EndIf
		Return FALSE
	EndIf

	Return TRUE
EndFunction

;/*****************************************************************************
	                      __         
 .-----.--.--.-----.-----|  |_.-----.
 |  -__|  |  |  -__|     |   _|__ --|
 |_____|\___/|_____|__|__|____|_____|
	                                                         
*****************************************************************************/;

Event OnInit()
{handler for installing and resetting}

	self.OK = FALSE
	self.ResetMod_Prepare()
	self.ResetMod_Values()
	self.ResetMod_Spells()
	self.ResetMod_Events()

	self.Print("Mod Installed.")
	If(self.OK)
		self.Print("Mod Active.")
	Else
		self.Print("Mod Inactive - Go fix missing dependencies.")
	EndIf
	
	Return
EndEvent

Event OnEncounterEnding(String EventName, String Args, Float Argc, Form From)
{handler for sexlab encounters ending.}

	Actor[] ActorList = SexLab.HookActors(Args)
	Int[] ActorBio = PapyrusUtil.IntArray(ActorList.Length)
	sslBaseAnimation Animation = SexLab.HookAnimation(Args)
	Int PartyBio = 0
	Int MaleCount = 0
	Int BeastCount = 0
	Bool Preg = 0
	Int x

	;;;;;;;;
	;;;;;;;;

	;; check if the animation type even included penetration.

	If(!Animation.IsVaginal && !(self.OptPregIncludeAnal && Animation.IsAnal))
		self.PrintDebug("Scene did not appear to include inseminable actions.")
		Return
	EndIf

	;;;;;;;;
	;;;;;;;;

	;; we need to go through the party and determine which biological
	;; features they are capable of providing to the mix. because of the way
	;; SexLab animations and just how you play the game in general works,
	;; all characters able to recieve bounties will get them if there is at
	;; least one character able to produce them. we cannot really reliably
	;; trust who is the pitcher and who is the catcher with the animations
	;; even more so when there is more than two actors.

	x = 0
	While(x < ActorList.Length)
		ActorBio[x] = self.ActorGetBiologicalFunctions(ActorList[x])
		PartyBio = Math.LogicalOr(PartyBio,ActorBio[x])

		;; determine what pitchers we have for determining which preg
		;; chance to use.
		If(Math.LogicalAnd(ActorBio[x],self.BioIsBeast) > 0 && (Animation.getGender(x) % 2) == 0)
			BeastCount += 1
		ElseIf(Math.LogicalAnd(ActorBio[x],self.BioInseminate) > 0 && (Animation.getGender(x) % 2) == 0)
			MaleCount += 1
		EndIf

		x += 1
	EndWhile

	If(Math.LogicalAnd(PartyBio,(self.BioInseminate + self.BioProduceGems)) != (self.BioInseminate + self.BioProduceGems) || (BeastCount == 0 && MaleCount == 0))
		;; if we didn't have a winning combination of fuel and ovens
		;; available there is no point in proceeeding.
		self.PrintDebug("Encounter did not have a viable combo (" + PartyBio + " (" + (self.BioInseminate + self.BioProduceGems) + ")).")
		Return
	EndIf

	;;;;;;;;
	;;;;;;;;

	x = 0
	While(x < ActorList.Length)
		If(MaleCount > 0)
			Preg = (Utility.RandomInt(0,100) <= self.ActorGetPregChance(ActorList[x],FALSE))
		Else
			Preg = (Utility.RandomInt(0,100) <= self.ActorGetPregChance(ActorList[x],TRUE))
		EndIf

		If(Preg)
			self.PrintDebug("Preg Chance Success for " + ActorList[x].GetDisplayName())
		Else
			self.PrintDebug("Preg Chance Fail for " + ActorList[x].GetDisplayName())
		EndIf

		;; decide what to do if the actor is able to produce gems.

		If(Math.LogicalAnd(ActorBio[x],self.BioProduceGems) == self.BioProduceGems && (Animation.getGender(x) % 2) == 1)
			If(Preg)				
				self.ActorGemAdd(ActorList[x])
				self.StatBump(None,"Preg")
				self.StatBump(ActorList[x],"Preg")
			EndIf

			If(self.OptCumInflation)
				;; cancel any currently happening cum effects before applying
				;; the new one, which will pick up where the previous left off.
				ActorList[x].RemoveSpell(self.dcc_sgo_SpellDeflate)
				ActorList[x].RemoveSpell(self.dcc_sgo_SpellInflate)
				ActorList[x].AddSpell(self.dcc_sgo_SpellInflate)
			EndIf
		EndIf

		;; decide what to do if the actor is able to jizz upon all the things.

		If(Math.LogicalAnd(ActorBio[x],self.BioInseminate) == self.BioInseminate)
			self.ActorSemenRemove(ActorList[x])
		EndIf

		x += 1
	EndWhile

	Return
EndEvent

Event OnGenderChange(Form Who, Int Gender)
{handler for sexlab changing genders.}

	;; drop this actor's cached value.
	self.ActorGetBiologicalFunctions(Who as Actor, FALSE)
	self.ActorTrackForSemen(Who as Actor,TRUE)
	self.ActorTrackForGems(Who as Actor,TRUE)
	self.ActorTrackForMilk(Who as Actor,TRUE)

	Debug.Notification("[SGO] SexLab Gender Change Detected")

	Return
EndEvent

Function EventSend_OnGemProgress(Actor Who, Int[] Progress)
{emit an event listing the current state of the gems being carried.}

	Int e = ModEvent.Create("SGO.OnGemProgress")

	;; fml, you cannot push an array into mod events.

	If(e)
		ModEvent.PushForm(e,Who)
		ModEvent.PushInt(e,Progress[0]) ;; unready gems
		ModEvent.PushInt(e,Progress[1]) ;; petty gems
		ModEvent.PushInt(e,Progress[2]) ;; lesser gems
		ModEvent.PushInt(e,Progress[3]) ;; common gems
		ModEvent.PushInt(e,Progress[4]) ;; greater gems
		ModEvent.PushInt(e,Progress[5]) ;; grand gems
		ModEvent.PushInt(e,Progress[6]) ;; black gems
		ModEvent.Send(e)
	EndIf

	Return
EndFunction

Function EventSend_OnMilkProgress(Actor Who, Int Progress, Int Overage)
{emit an event stating the current amount of milk being carried.}

	Int e = ModEvent.Create("SGO.OnMilkProgress")

	If(e)
		ModEvent.PushForm(e,Who)
		ModEvent.PushInt(e,Progress)
		ModEvent.PushInt(e,Overage)
		ModEvent.Send(e)
	EndIf

	Return
EndFunction

Function EventSend_OnSemenProgress(Actor Who, Int Progress)
{emit an event when an actor gains another bottle of semen.}

	Int e = ModEvent.Create("SGO.OnSemenProgress")

	If(e)
		ModEvent.PushForm(e,Who)
		ModEvent.PushInt(e,Progress)
		ModEvent.Send(e)
	EndIf

	Return
EndFunction

Function EventSend_OnBirthing(Actor Who)
{emit an event stating that we are birthing.}

	Int e = ModEvent.Create("SGO.OnBirthing")
	If(!e)
		Return
	EndIf

	ModEvent.PushForm(e,Who)
	ModEvent.Send(e)
	Return
EndFunction

Function EventSend_OnBirthed(Actor Who, Form What)
{emit an event stating the gem an actor just birthed.}

	Int e = ModEvent.Create("SGO.OnBirthed")
	If(!e)
		Return
	EndIf

	ModEvent.PushForm(e,Who)
	ModEvent.PushForm(e,What)
	ModEvent.Send(e)
	Return
EndFunction

Function EventSend_OnMilking(Actor Who)
{emit an event stating that we are milking.}

	Int e = ModEvent.Create("SGO.OnMilking")
	If(!e)
		Return
	EndIf

	ModEvent.PushForm(e,Who)
	ModEvent.Send(e)
	Return
EndFunction

Function EventSend_OnMilked(Actor Who, Form What)
{emit an event stating a bottle of milk was just milked.}

	Int e = ModEvent.Create("SGO.OnMilked")
	If(!e)
		Return
	EndIf

	ModEvent.PushForm(e,Who)
	ModEvent.PushForm(e,What)
	ModEvent.Send(e)
	Return
EndFunction

Function EventSend_OnWanking(Actor Who)
{emit an event stating that we are wanking.}

	Int e = ModEvent.Create("SGO.OnWanking")
	If(!e)
		Return
	EndIf

	ModEvent.PushForm(e,Who)
	ModEvent.Send(e)
	Return
EndFunction

Function EventSend_OnWanked(Actor Who, Form What)
{emit an event stating a bottle of semen was just wanked.}

	Int e = ModEvent.Create("SGO.OnWanked")
	If(!e)
		Return
	EndIf

	ModEvent.PushForm(e,Who)
	ModEvent.PushForm(e,What)
	ModEvent.Send(e)
	Return
EndFunction

Function EventSend_OnInserting(Actor Who, Form What)
{emit an event stating we are inserting.}

	Int e = ModEvent.Create("SGO.OnInserting")
	If(!e)
		Return
	EndIf

	ModEvent.PushForm(e,Who)
	ModEvent.PushForm(e,What)
	ModEvent.Send(e)
	Return
EndFunction

Function EventSend_OnInserted(Actor Who, Form What)
{emit an event staring we are done inserting.}

	Int e = ModEvent.Create("SGO.OnInserted")
	If(!e)
		Return
	EndIf

	ModEvent.PushForm(e,Who)
	ModEvent.PushForm(e,What)
	ModEvent.Send(e)
	Return
EndFunction

Function EventSend_OnInseminating(Actor Who, Form What)
{emit an event stating we are inseminating.}

	Int e = ModEvent.Create("SGO.OnInseminating")
	If(!e)
		Return
	EndIf

	ModEvent.PushForm(e,Who)
	ModEvent.PushForm(e,What)
	ModEvent.Send(e)
	Return
EndFunction

Function EventSend_OnInseminated(Actor Who, Form What)
{emit an event staing we are done inseminating.}

	Int e = ModEvent.Create("SGO.OnInseminated")
	If(!e)
		Return
	EndIf

	ModEvent.PushForm(e,Who)
	ModEvent.PushForm(e,What)
	ModEvent.Send(e)
	Return
EndFunction

;/*****************************************************************************
	         __                     __       __         
 .---.-.----|  |_.-----.----.   .--|  .---.-|  |_.---.-.
 |  _  |  __|   _|  _  |   _|   |  _  |  _  |   _|  _  |
 |___._|____|____|_____|__|     |_____|___._|____|___._|
	                                                    
*****************************************************************************/;

ObjectReference Function ActorDropObject(Actor Who, Form What, Int Count=1, Bool Kick=TRUE, String Bone="")
{place an object in the 3d world by the specified actor. this method will
perform a few checks to determine the most immersive type of drop we should
do for the current scenerio.}

	ObjectReference ThisGuy

	If(self.ActorNoAnimate(Who) || !Kick)
		ThisGuy = self.ActorDropObject_Gentle(Who,What,Count)
	Else
		;;NPC Pelvis [Pelv]
		;;NPC GenitalsBase [GenBase]
		;;SchlongMagic
		;;NPC GenitalsScrotum [GenScrot]
		If(Bone == "")
			Bone = "NPC GenitalsScrotum [GenScrot]"
		EndIf

		ThisGuy = self.ActorDropObject_Positioned(Who,What,Bone,Count,Kick)
	EndIf

	Return ThisGuy
EndFunction

ObjectReference Function ActorDropObject_Gentle(Actor Source, Form What, Int Count=1)
{place an object at the actor's feet in a way that should not cause havok to
push the actor or various other things around the room. just like the normal
actor methods this method only return the last item.}

	;; however we perform the count in a loop so that we can update
	;; options for all the objects dropped.

	Int Iter = 0
	ObjectReference ThisGuy

	While(Iter < Count)
	;; this process involves giving the actor one of the things.
	Source.AddItem(What,1)

	;; then using the drop function on the actor which places it
	;; gently at their feet.
	ThisGuy = Source.DropObject(What,1)

	;; and we will apply the theft hack to stop you from getting
	;; in trouble for picking it up.
	ThisGuy.SetActorOwner(self.Player.GetLeveledActorBase())

	Iter += 1
	EndWhile

	Return ThisGuy
EndFunction

ObjectReference Function ActorDropObject_Positioned(Actor Source, Form What, String Where, Int Count=1, Bool Kick=TRUE)
{place an object at a specified bone location of an actor with an optional
kick by havok.}

	;; so this function now implements a hilarious hack to get around
	;; having to properly trig the direction to kick the gem. this is
	;; because it appears while GetNodeWorldPosition works properly,
	;; GetWorldNodeRotation returns the same as GetLocalNodeRotation
	;; one hundred percent of the time making its values useless.

	;; we cannot just use GetAngle on the actor because the angle
	;; will not reflect what the animation has done to it. this way
	;; we attempt to shoot the gem in the proper direction no matter
	;; which way the animation changed the actor.

	Int Iter = 0
	ObjectReference ThisGuy

	Float Speed ;; calculated speed of how hard to kick it.
	Float VecDiv ;; a lol divisor for the vector. explained below.
	Float[] Pot = new Float[3] ;; the position of the node we want the gem to appear
	Float[] Ref = new Float[3] ;; the reference vector pointing from the neck to the pelvis
	Float[] Vec = New Float[3] ;; the chilled calculated vector to give to havok

	;;;;;;;;
	;;;;;;;;

	NetImmerse.GetNodeWorldPosition(Source,Where,Pot,FALSE)
	NetImmerse.GetRelativeNodePosition(Source,"NPC Neck [Neck]","NPC Pelvis [Pelv]",Ref,FALSE)

	;; this 45 is just slightly more than the vertical distance between neck and pelvis.
	;; it is multipled by the scale to create a divisor for the realtive position.
	;; GetScale() detects console done scaling. NodeScale detects racemenu done scaling.
	VecDiv = Source.GetScale() * NetImmerse.GetNodeScale(Source,"NPC",FALSE) * 45

	;;;;;;;;
	;;;;;;;;

	Vec[0] = (Ref[0] / VecDiv)
	Vec[1] = (Ref[1] / VecDiv)
	Vec[2] = (Ref[2] / VecDiv)

	;; kick it harder the higher up we're trying to point it, but avoid
	;; punting it too hard straight into the ground so it doesn't fly
	;; crazy anywhere.
	If(Vec[2] > -0.6)
		Speed = (3 * (1 + (Ref[2] / VecDiv)))
	Else
		Speed = 0.01
	EndIf

	self.PrintDebug(Where + " Vec(" + Vec[0] + "," + Vec[1] + "," + Vec[2] + ") Speed(" + Speed + ")")

	;;;;;;;;
	;;;;;;;;

	If(Where == "SkirtFBone02C" || Where == "SkirtBBone02C")
		;; adjust the position for these bones a bit more to try and get out of
		;; the actor's collision area by applying the neck->pelvis vector.
		Pot[0] = Pot[0] + (Vec[0] * 10)
		Pot[1] = Pot[1] + (Vec[1] * 10)
		Pot[2] = Pot[2] + (Vec[2] * 4)
	EndIf

	;;;;;;;;
	;;;;;;;;

	While(Iter < Count)
		ThisGuy = Source.PlaceAtMe(What,1,FALSE,TRUE)
		ThisGuy.SetPosition(Pot[0],Pot[1],Pot[2])
		ThisGuy.SetActorOwner(self.Player.GetLeveledActorBase())
		ThisGuy.Enable(FALSE)

		If(Kick)
		 	Utility.Wait(0.10)
			ThisGuy.ApplyHavokImpulse(Vec[0],Vec[1],Vec[2],Speed)
		EndIf

		Iter += 1
	EndWhile

	return ThisGuy
EndFunction

Int Function ActorGetSex(Actor Who, Bool Easy=TRUE)
{get gender from sexlab collapsing the sexlab genders in it, always
returning 0 or 1.}

	;; my understanding of the new sexlab genders by looking at the code
	;; in the GetGender function.
	;; 0 = male
	;; 1 = female
	;; 2 = manimal
	;; 3 = fanimal

	Int Value = SexLab.GetGender(Who)

	If(Easy && Value >= 2)
		Value -= 2;
	EndIf

	Return Value;
EndFunction

Int Function ActorGetBiologicalFunctions(Actor Who, Bool Cached=TRUE)
{determine what this actor's body is able to accomplish. returns a bitwised
integer that defines the capaiblities of this actor.}

	Int Value = 0

	If(Cached)
		Value = StorageUtil.GetIntValue(Who,"SGO.Actor.Biologicalfunctions",0)
		If(Value != 0)
			;; if we found cached data use it. this should prevent us getting our
			;; shit reset while in a temporary state like vampire lord or werewolf.
			;; also, speed.
			Return Value
		EndIf
	EndIf

	Int Sex = self.ActorGetSex(Who,FALSE)
	self.PrintDebug(Who.GetDisplayName() + " is " + self.GetSexWord(Sex) + " according to sexlab")

	;; figure out if we were a beast.

	If(Sex >= 2)
		Sex -= 2
		Value = Math.LogicalOr(Value, self.BioIsBeast)
	EndIf

	;; figure out what the body can do based on the sex.

	If(Sex == 0)
		Value = Math.LogicalOr(Value, self.BioInseminate)
	Else

		If(Game.GetModByName("Schlongs of Skyrim - Core.esm") != 255)

			;; Cetuximab - Futa check
			SOS_API sos = SOS_API.Get()
			if(sos != None)
				SOS_AddonQuest_Script sos_addon = sos.GetSchlong(Who) As SOS_AddonQuest_Script
				If(sos_addon != None)
					If(sos_addon.GetName() == "UNP")
						Self.PrintDebug("SOS UNP Plugin schlong found on " + Who.GetDisplayName() + ". Marking as Futa (Inseminator).")
						;; Futas must only inseminate, otherwise they can get themselves pregnant :/
						Value = Math.LogicalOr(Value, self.BioInseminate)
					Else
						Self.PrintDebug("Futa incompatible SOS Plugin found on " + Who.GetDisplayName() + ": " + sos_addon.GetName() + ". Marking as female.")
						Value = Math.LogicalOr(Value, (self.BioProduceGems + self.BioProduceMilk))
					EndIf
				Else
					Self.PrintDebug("No SOS Addon was placed on " + Who.GetDisplayName() + ". Assuming normal female.")
					Value = Math.LogicalOr(Value, (self.BioProduceGems + self.BioProduceMilk))
				EndIf
			Else
				Self.PrintDebug("SOS API not found, are you using SOS ver 3.00.004 or later?")
				Value = Math.LogicalOr(Value, (self.BioProduceGems + self.BioProduceMilk))
			EndIf

		EndIf

	EndIf

	;; figure out what the user wanted. negatives override positives.

	If(Who.IsInFaction(self.dcc_sgo_FactionCanInseminate))
		Value = Math.LogicalOr(Value, self.BioInseminate)
	EndIf

	If(Who.IsInFaction(self.dcc_sgo_FactionCanProduceGems))
		Value = Math.LogicalOr(Value, self.BioProduceGems)
	EndIf

	If(Who.IsInFaction(self.dcc_sgo_FactionCanProduceMilk))
		Value = Math.LogicalOr(Value, self.BioProduceMilk)
	EndIf

	If(Who.IsInFaction(self.dcc_sgo_FactionCannotInseminate))
		Value = Math.LogicalAnd(Value, Math.LogicalNot(self.BioInseminate))
	EndIf

	If(Who.IsInFaction(self.dcc_sgo_FactionCannotProduceGems))
		Value = Math.LogicalAnd(Value, Math.LogicalNot(self.BioProduceGems))
	EndIf

	If(Who.IsInFaction(self.dcc_sgo_FactionCannotProduceMilk))
		Value = Math.LogicalAnd(Value, Math.LogicalNot(self.BioProduceMilk))
	EndIf

	;/* <= v308
	If(Sex >= 2)
		Value += self.BioIsBeast
	EndIf

	If((Sex != 1 || Who.IsInFaction(self.dcc_sgo_FactionCanInseminate)) && !Who.IsInFaction(self.dcc_sgo_FactionCannotInseminate))
		Value += self.BioInseminate
	EndIf

	If((Sex == 1 || Who.IsInFaction(self.dcc_sgo_FactionCanProduceGems)) && !Who.IsInFaction(self.dcc_sgo_FactionCannotProduceGems))
		Value += self.BioProduceGems
	EndIf

	If((Sex == 1 || Who.IsInFaction(self.dcc_sgo_FactionCanProduceMilk)) && !Who.IsInFaction(self.dcc_sgo_FactionCannotProduceMilk))
		Value += self.BioProduceMilk
	EndIf
	*/;

	StorageUtil.SetIntValue(Who,"SGO.Actor.Biologicalfunctions",Value)
	self.PrintDebug(Who.GetDisplayName() + " features " + Value + " according to soulgem oven")

	Return Value
EndFunction

Function ActorSetBiologicalFunction(Actor Who, Int Func, Bool Enable)
{set this actor's biological functions. this function does not do bitwise so
you must do each function individually.}

	;; todo - re-engineer the inner workings of this method to allow
	;; for a bitwise operation instead.

	Faction ToEnable
	Faction ToDisable

	If(Func == self.BioProduceGems)
		ToEnable = self.dcc_sgo_FactionCanProduceGems
		ToDisable = self.dcc_sgo_FactionCannotProduceGems
	ElseIf(Func == self.BioProduceMilk)
		ToEnable = self.dcc_sgo_FactionCanProduceMilk
		ToDisable = self.dcc_sgo_FactionCannotProduceMilk
	ElseIf(Func == self.BioInseminate)
		ToEnable = self.dcc_sgo_FactionCanInseminate
		ToDisable = self.dcc_sgo_FactionCannotInseminate
	EndIf

	If(Enable)
		Who.RemoveFromFaction(ToDisable)
		Who.AddToFaction(ToEnable)

		self.ActorTrackForSemen(Who,TRUE)
		self.ActorTrackForGems(Who,TRUE)
		self.ActorTrackForMilk(Who,TRUE)
	Else
		Who.RemoveFromFaction(ToEnable)
		Who.AddToFaction(ToDisable)

		If(self.OptResetDataOnDisable)
			If(Func == self.BioInseminate)
				self.ActorSemenClearData(Who)
			ElseIf(Func == self.BioProduceMilk)
				self.ActorMilkClearData(Who)
			ElseIf(Func == self.BioProduceGems)
				self.ActorGemClearData(Who)
			EndIf

			self.ActorBodyUpdate(Who)
		EndIf
	EndIf

	;; update cached value.
	self.ActorGetBiologicalFunctions(Who,FALSE)
	Return
EndFunction

Float Function ActorGetPregChance(Actor Who, Bool Beast=FALSE)
{determine the value to use for preg chancing.}

	Float Base = self.OptPregChanceHumanoid as Float
	If(Beast == TRUE)
		Base = self.OptPregChanceBeast as Float
	EndIf

	If(Beast && self.OptUntamedPregChance)
		;; an untamed level of 100 increases chance by 20%.
		Base += PapyrusUtil.ClampFloat((StorageUtil.GetFloatValue(Who,"Untamed.Level",1.0) / 5),1,20)
	EndIf

	Return Base
EndFunction

Function ActorToggleBiologicalFunction(Actor Who, Int Func)
{toggle this actor's biological functions. this method does not work in
bitwise so you must do each function indivdually.}

	If(Math.LogicalAnd(self.ActorGetBiologicalFunctions(Who),Func) == Func)
		self.ActorSetBiologicalFunction(Who,Func,FALSE)
	Else
		self.ActorSetBiologicalFunction(Who,Func,TRUE)
	EndIf

	Return
EndFunction

Function ActorToggleFaction(Actor Who, Faction What)
{toggle an actor's perk. any perk. whatever.}

	If(Who.IsInFaction(What))
		Who.RemoveFromFaction(What)
		self.ActorBodyUpdate(Who)
	Else
		Who.AddToFaction(What)

		If(self.OptResetNodeOnDisable)
			If(What == self.dcc_sgo_FactionDisableScaleTesticle)
				self.BoneSetScale(who,"NPC Testicles","SGO.Scale",1.0)
			ElseIf(What == self.dcc_sgo_FactionDisableScaleBelly)
				self.BoneSetScale(who,"NPC Belly","SGO.Scale",1.0)
			ElseIf(What == self.dcc_sgo_FactionDisableScaleBreast)
				self.BoneSetScale(who,"NPC Breasts","SGO.Scale",1.0)
			EndIf
		EndIf
	EndIf

	Return
EndFunction

Float Function ActorGetTimeSinceUpdate(Actor Who, String What)
{return how many game hours have passed since this actors specified data has
been updated. the string value is the storageutil name for the data you want.}

	Float Current = Utility.GetCurrentGameTime()
	Float Last = StorageUtil.GetFloatValue(Who,What,0.0)

	If(Last == 0.0)
		;; when this is the first time report the first time was more than an
		;; hour ago so that things like fertility initialise on new games.
		Last = Current - (1.5 / 24)
		StorageUtil.SetFloatValue(Who,What,Last)
	EndIf

	Return (Current - Last) * 24.0
EndFunction

Function ActorSetTimeUpdated(Actor Who, String What, Float When=0.0)
{set the current time to mark this actor having been updated. the string value
is the storageutil name for the data you want.}

	If(When == 0.0)
		When = Utility.GetCurrentGameTime()
	EndIf

	StorageUtil.SetFloatValue(Who,What,When)
	Return
EndFunction

Function ActorRemoveChestpiece(Actor Who)
{remove an actor's chestpiece.}

	If(self.OptSexlabStrip)
		Form[] Items
		Int Iter = 0

		Items = SexLab.StripActor(Who,None,FALSE,FALSE)
		While(Iter < Items.Length)
			StorageUtil.FormListAdd(Who,"SGO.Actor.Armor",Items[Iter],TRUE)
			Iter += 1
		EndWhile

	Else
		If(Who.GetWornForm(0x00000004) != None)
			StorageUtil.SetFormValue(Who,"SGO.Actor.Armor.Chest",Who.GetWornForm(0x00000004))
			Who.UnequipItemSlot(32)
			Who.QueueNiNodeUpdate()
		EndIf
	EndIf
EndFunction

Function ActorReplaceChestpiece(Actor Who)
{replace an actor's chestpiece.}

	If(self.OptSexLabStrip)
		SexLab.UnstripActor(Who, StorageUtil.FormListToArray(Who,"SGO.Actor.Armor"), FALSE)
		StorageUtil.FormListClear(Who,"SGO.Actor.Armor")
	Else
		If(StorageUtil.GetFormValue(Who,"SGO.Actor.Armor.Chest"))
			Who.EquipItem(Storageutil.GetFormValue(Who,"SGO.Actor.Armor.Chest"),FALSE,TRUE)
			StorageUtil.SetFormValue(who,"SGO.Actor.Armor.Chest",None)
		EndIf
	EndIf
EndFunction

Function ActorProgressAlchemy(Actor Who, Float ItemValue=1.0)
{progress the alchemy skill for the specified actor. for most things we will
leave ItemValue at the default of 1.0.}

	If(Who != self.Player)
		;; not possible to level npcs at this time.
		Return
	EndIf

	If(self.OptProgressAlchFactor == 0.0)
		;; do not process when disabled.
		Return
	EndIf

	;; http://www.uesp.net/wiki/Skyrim:Leveling#Skill_XP

	;; xp/btl gained at x btl/day at level 0.
	;; double this at level 100 with 1.0 progress factor.
	;; 1 = 100xp
	;; 2 = 50xp
	;; 3 = 33xp (default)

	Float Level = Who.GetLevel()
	Float Value = (100 / (24 / self.OptMilkProduceTime)) * ItemValue

	;; if its progressing retarded fast, manipulate the 24 to be smaller.
	;; if too slow manipulate the 24 larger.
	;; once this calc feels good to me at default, users can tweak it via the factor.

	Game.AdvanceSkill("Alchemy",self.GetLeveledValue(Level,Value,self.OptProgressAlchFactor))
	Return
EndFunction

Function ActorProgressEnchanting(Actor Who, Float ItemValue=6.0)
{progress the enchanting skill for the specified actor. it works on a base 6
system because it will primarily be used on soulgems birthing.}

	If(Who != self.Player)
		;; not possible to level npcs at this time.
		Return
	EndIf

	If(self.OptProgressEnchFactor == 0.0)
		;; do not process when disabled.
		Return
	EndIf

	;; http://www.uesp.net/wiki/Skyrim:Leveling#Skill_XP
	;; normal enchanting works as 1xp per item enchanted and it seems enchanting levels fast
	;; so we will use small numbers here.

	Float Level = Who.GetLevel()
	Float Value = ((ItemValue / 6.0) / 2.0)

	;; if enchanting levels too slow manipulate the /2.0 smaller.
	;; if too fast, manipulate the /2.0 larger.
	;; once this calc feels good to me at default, users can tweak it via the factor.

	Game.AdvanceSkill("Enchanting",self.GetLeveledValue(Level,Value,self.OptProgressEnchFactor))
	Return
EndFunction

Float Function ActorFertilityGetMod(Actor Who, float Vmod=0.0)
{fetch the current multiplier for the fertility value using science and shit.}

	If(!self.OptFertility)
		Return 1.0
	EndIf

	;; the x value of the wave.
	Float Fval = StorageUtil.GetFloatValue(Who,"SGO.Actor.Fertility.Data",missing=0.0)
	Fval += Vmod


	;; the period offset is used to crank the amplitude and vertical offset of
	;; the wave.
	Float Poff = (self.OptFertilityWindow - 1) / 2

	;; the period length.
	Int Plen = self.OptFertilityDays

	;;  /     /          \      \
	;; |     | 2[pi]      |      |
	;; | sin | ----- fval | poff | + poff
	;; |     | plen       |      |
	;;  \     \          /      /
	;;           period    amp    y-offset

	;; SINEWAVESMOTHERFUCKER.

	Return ((Math.Sin(Math.RadiansToDegrees(((2*3.14159) / Plen) * Fval)) * Poff) + Poff) + 1
EndFunction

Function ActorFertilityUpdateData(Actor Who, Bool Force=FALSE)
{this function will keep a running loop of time from 0 to 28.}

	;; 1 2 3... 27 28 0 1 2 3...

	If(!self.OptFertility)
		;; no need to process if disabled.
		Return
	EndIf

	Float Time = self.ActorGetTimeSinceUpdate(Who,"SGO.Actor.Fertility.Time")
	If(Time < 1.0 && !Force)
		;; no need to process if too soon.
		Return
	EndIf

	;; get our current values. if this actor has not yet ever been calculated
	;; then we set them at a random point in the cycle to try and avoid having
	;; all the females in skyrim synced up.
	Float Fval = StorageUtil.GetFloatValue(Who,"SGO.Actor.Fertility.Data",missing=Utility.RandomFloat(0.0,self.OptFertilityDays))
	Float Nval = Fval + (Time / 24)

	;; attempt to sync up cycles with any followers currently following lololol.
	;; for starters we will try just making followers run hotter until they
	;; are synced up.
	;;If(self.OptFertilitySync && SexLab.GetGender(self.Player) == 1)
	;;	If(Who != self.Player && SexLab.GetGender(Who) == 1 && self.Player.GetDistance(Who) <= 250)
	;;		If(Math.abs(self.ActorFertilityGetMod(Who)-self.ActorFertilityGetMod(self.Player)) / self.OptFertilityWindow > 0.1)
	;;			Nval += (self.OptFertilityDays * 0.01) * Time
	;;		EndIf
	;;	EndIf
	;;EndIf

	;;If(Nval > self.OptFertilityDays)
		;; reset the period if this actor is over a cycle.
	;;	Nval = Nval - (Math.Floor(Nval / self.OptFertilityDays) * self.OptFertilityDays)
	;;EndIf
	Nval = PapyrusUtil.WrapFloat(Nval,self.OptFertilityDays,1.0)

	;; update our fertile value.
	self.ActorSetTimeUpdated(Who,"SGO.Actor.Fertility.Time")
	StorageUtil.SetFloatValue(who,"SGO.Actor.Fertility.Data",Nval)

	;; todo: immersive messages comparing fval and nval.

	;; todo: more research on blood splattering actors. i seem to be able to
	;; splatter everything except the actor. the lol was gonna be bleeding on
	;; people while sexing while at the low point of the fertility cycle.
	;; who.PlayImpactEffect(Game.GetFormFromFile(0xF457B,"Skyrim.esm") as ImpactDataSet,"SchlongMagic",0.0,0.0,1.0,0.0)

	Return
EndFunction

Function ActorApplyBreastInfluence(Actor Who)
{this function will re-calculate the breast influence for barter and refresh it
when needed.}

	If(Who != self.Player)
		;; no point since mgefs fall off them anyway.
		Return
	EndIf

	;;;;;;;;
	;;;;;;;;

	If(Who.HasSpell(self.dcc_sgo_SpellBreastInfluence))
		Who.RemoveSpell(self.dcc_sgo_SpellBreastInfluence)
	EndIf

	;;;;;;;;
	;;;;;;;;

	If(self.OptEffectBreastInfluence && self.ActorMilkGetWeight(Who) > 0)
		;; effect 0 is the normal breast influence. effect 1 is a hidden bonus
		;; influence that i never told anyone about that only applies if you
		;; are naked.
		Float InfluenceMulti = self.ActorModGetMultiplier(Who,"Breast.Influence")
		self.dcc_sgo_SpellBreastInfluence.SetNthEffectMagnitude(0,((self.ActorMilkGetPercent(Who) / 4) * InfluenceMulti))
		self.dcc_sgo_SpellBreastInfluence.SetNthEffectMagnitude(1,((self.ActorMilkGetPercent(Who) / 8) * (InfluenceMulti / 2)))
		Who.AddSpell(self.dcc_sgo_SpellBreastInfluence,FALSE)
	EndIf

	Return
EndFunction

Function ActorApplyBellyEncumber(Actor Who)
{this function will re-calculate the belly encumberment and refresh it when
needed.}

	;; speedmult normally does not get updated until the player stance changes
	;; such that as of crouching, sprinting, or brandishing weapons.

	;; a new note on the ck wiki claims that modding the carryweight will
	;; fool the game into updating the speed, so i restructured this a little
	;; to avoid having to do it four times.

	If(Who != self.Player)
		;; no point since mgefs fall off them anyway.
		Return
	EndIf

	;;;;;;;;
	;;;;;;;;

	If(Who.HasSpell(self.dcc_sgo_SpellBellyEncumber))
		Who.RemoveSpell(self.dcc_sgo_SpellBellyEncumber)
		Who.ModActorValue("CarryWeight",1.0)
		Who.ModActorValue("CarryWeight",-1.0)
	EndIf

	If(Who.HasSpell(self.dcc_sgo_SpellBellyBonus))
		Who.RemoveSpell(self.dcc_sgo_SpellBellyBonus)
	EndIf

	If(Who.HasSpell(self.dcc_sgo_SpellBellyDamage))
		Who.RemoveSpell(self.dcc_sgo_SpellBellyDamage)
	EndIf

	;;;;;;;;
	;;;;;;;;

	Float GemCount = self.ActorGemGetCount(Who)
	Float GemPercent = self.ActorGemGetPercent(Who)

	If(self.OptEffectBellyEncumber && GemCount > 0)
		;; slow them down the fuller they get.
		;; 0 to -25 before modifiers.
		self.dcc_sgo_SpellBellyEncumber.SetNthEffectMagnitude(0,((GemPercent / 4) * -1) * self.ActorModGetMultiplier(Who,"Belly.Encumber"))
		Who.AddSpell(self.dcc_sgo_SpellBellyEncumber,FALSE)
		Who.ModActorValue("CarryWeight",1.0)
		Who.ModActorValue("CarryWeight",-1.0)
	EndIf

	If(self.OptEffectBellyBonus && GemCount > 0)
		;; give more health and mana due to having power within your belly.
		;; effect 0 is health and effect 1 is mana.
		;; at 100% full the range is 5 to 250, your level making it scale.
		self.dcc_sgo_SpellBellyBonus.SetNthEffectMagnitude(0, ((GemPercent / 20) * (Who.GetLevel() / 2)) * self.ActorModGetMultiplier(Who,"Belly.Bonus.Health"))
		self.dcc_sgo_SpellBellyBonus.SetNthEffectMagnitude(1, ((GemPercent / 20) * (Who.GetLevel() / 2)) * self.ActorModGetMultiplier(Who,"Belly.Bonus.Mana") )
		Who.AddSpell(self.dcc_sgo_SpellBellyBonus,FALSE)
	EndIf

	If(self.OptEffectBellyDamage && GemCount > 0)
		Who.AddSpell(self.dcc_sgo_SpellBellyDamage,FALSE)
	EndIf

	Return
EndFunction

Bool Function ActorNoAnimate(Actor Who)
{check if there is a reason this actor should not be animated. returns true if it
shoudl not be animated, returns false if it is safe to animate.}

	;; todo - add no animate faction so that sgo can be told not to animate
	;; actors. this will allow players to set the flag and me not have to
	;; add support for every mod under the sun.

	;; support for old Display Model.
	If(StorageUtil.GetIntValue(Who,"IsBoundStrict") == 1)
		Return TRUE

	;; support for new Display Model 2.
	ElseIf(StorageUtil.GetIntValue(Who,"DM2.Actor.Restrain") == 1)
		Return TRUE

	EndIf

	Return FALSE
EndFunction

Bool Function ActorCanAnimate(Actor Who)
{the inverse of no animate. literally.}

	Return !self.ActorNoAnimate(Who)
EndFunction

;/*****************************************************************************
	         __                              __                       __       
 .---.-.----|  |_.-----.----.   .--.--.---.-|  |   .--------.-----.--|  .-----.
 |  _  |  __|   _|  _  |   _|   |  |  |  _  |  |   |        |  _  |  _  |__ --|
 |___._|____|____|_____|__|      \___/|___._|__|   |__|__|__|_____|_____|_____|

*****************************************************************************/;

Float Function ActorModGetTotal(Actor Who, String What)
{fetch the sum of all the mods so.}

	What = "SGO.Actor.Mod." + What

	Int x
	Int Count = StorageUtil.StringListCount(Who,What)
	String ModKey
	Float Value = 0.0
	
	x = 0
	While(x < Count)
		ModKey = StorageUtil.StringListGet(Who,What,x)
		Value += StorageUtil.GetFloatValue(Who,ModKey)
		x += 1
	EndWhile

	Return Value
EndFunction

Float Function ActorModGetMultiplier(Actor Who, String What)
{literally just the total plus one, so that it can be used as a multiplier. no
mods means we will get 1 instead of 0.}

	Return self.ActorModGetTotal(Who,What) + 1.0
EndFunction

Float Function ActorModGetValue(Actor Who, String What, String ModKey)
{fetch the specified actor mod.}

	ModKey = "SGO.ActorModValue." + What + "." + ModKey

	Return StorageUtil.GetFloatValue(Who,ModKey,0.0)
EndFunction

Function ActorModSetValue(Actor Who, String What, String ModKey, Float Value=0.0)
{set a specified actor mod.}

	String WhatList = "SGO.Actor.Mod." + What
	ModKey = "SGO.ActorModValue." + What + "." + ModKey

	StorageUtil.StringListAdd(Who,WhatList,ModKey,FALSE)
	StorageUtil.SetFloatValue(Who,ModKey,Value)

	Return
EndFunction

Function ActorModUnsetValue(Actor Who, String What, String ModKey)
{remove a specified actor mod.}

	String WhatList = "SGO.Actor.Mod." + What
	ModKey = "SGO.ActorModValue." + What + "." + ModKey

	StorageUtil.StringListRemove(Who,WhatList,ModKey,TRUE)
	StorageUtil.UnsetFloatValue(Who,ModKey)

	Return
EndFunction

;/*****************************************************************************
	         __                                   __              __ 
 .---.-.----|  |_.-----.----.   .----.-----.-----|  |_.----.-----|  |
 |  _  |  __|   _|  _  |   _|   |  __|  _  |     |   _|   _|  _  |  |
 |___._|____|____|_____|__|     |____|_____|__|__|____|__| |_____|__|

*****************************************************************************/;

Function BehaviourApply(Actor Who, Package Pkg)
{have an actor begin a specific package.}

	self.BehaviourClear(Who)

	StorageUtil.SetFormValue(Who,"SGO.Actor.Package",Pkg)
	ActorUtil.AddPackageOverride(Who,Pkg,100)
	Who.EvaluatePackage()

	Return
EndFunction

Function BehaviourClear(Actor Who, Bool Full=False)
{have an actor clear their ruling overwrite package.}

	Package Pkg = StorageUtil.GetFormValue(Who,"SGO.Actor.Package",missing=None) as Package

	If(Pkg != None)
		StorageUtil.UnsetFormValue(Who,"SGO.Actor.Package")
		ActorUtil.RemovePackageOverride(Who,Pkg)
		Who.EvaluatePackage()
	EndIf

	If(Full)
		ActorUtil.RemovePackageOverride(Who,self.dcc_sgo_PackageDoNothing)
		who.EvaluatePackage()

		If(Who == self.Player)
			Game.SetPlayerAIDriven(FALSE)
		EndIf
	EndIf

	Return
EndFunction

Function BehaviourDefault(Actor Who)
{enforce the default ai behaviour of do nothing.}

	self.BehaviourClear(Who,TRUE)

	If(Who == self.Player)
		Game.SetPlayerAIDriven(TRUE)
	EndIf

	ActorUtil.AddPackageOverride(Who,self.dcc_sgo_PackageDoNothing,99)
	Who.EvaluatePackage()

	Return
EndFunction

Function PersistHackApply(Actor Who)
{apply persistence hacks to keep temporary actors alive.}

	If(StorageUtil.FormListFind(None,"SGO.ActorList.Persist",Who) != -1)
		;; don't re-register if we are already in here.
		Return
	EndIf

	self.PrintDebug(Who.GetDisplayName() + " shall persist.")
	Who.RegisterForUpdate(600)

	self.FormListLock(None,"SGO.ActorList.Persist","PersistHackApply")
	StorageUtil.FormListAdd(None,"SGO.ActorList.Persist",Who,FALSE)
	self.FormListUnlock(None,"SGO.ActorList.Persist")

	Return
EndFunction

Function PersistHackClear(Actor Who)
{clear the persistence hack. take into account known mods that also use this
same persistence hack (more or less, mine only, for the time being) so that
we don't fuck up those mods.}

	self.FormListLock(None,"SGO.ActorList.Persist","PersistHackClear")
	StorageUtil.FormListRemove(None,"SGO.ActorList.Persist",Who,TRUE)
	self.FormListUnlock(None,"SGO.ActorList.Persist")

	;; mods need to track their persistance hacking via a global scope form
	;; list containing actor references if they want me to support it:
	;; - to create and add to a list.
	;;   StorageUtil.FormListAdd(None,"YourModKey",Actor,FALSE)
	;; - to remove from a list.
	;;   StorageUtil.FormListRemove(None,"YourModKey",Actor,TRUE)

	;; other mods which implement this hack should have simliar as here
	;; to make sure they don't fuck up other mods. to add support for this
	;; mod you should test the SGO.ActorList.Persist list. other mods
	;; are below.

	String[] FourthPartyList = new String[2]
	FourthPartyList[0] = "Untamed.TrackingList"  ;; Untamed
	FourthPartyList[1] = "DisplayModel.ActorList.Persist" ;; Display Model 2

	Int CurrentMod = 0
	While(CurrentMod < FourthPartyList.Length)
		If(StorageUtil.FormListFind(None,FourthPartyList[CurrentMod],Who) != -1)
			;; if found in any of the fourth party lists then do not
			;; unregister it.
			self.PrintDebug(Who.GetDisplayName() + " persist kept for " + FourthPartyList[CurrentMod])
			Return
		EndIf

		CurrentMod += 1
	EndWhile

	Who.UnregisterForUpdate()
	self.PrintDebug(Who.GetDisplayName() + " persist cleared.")

	Return
EndFunction

;/*****************************************************************************
	__                   __    __                             __ 
 |  |_.----.---.-.----|  |--|__.-----.-----.   .---.-.-----|__|
 |   _|   _|  _  |  __|    <|  |     |  _  |   |  _  |  _  |  |
 |____|__| |___._|____|__|__|__|__|__|___  |   |___._|   __|__|
	                                 |_____|         |__|      

*****************************************************************************/;

Function ActorTrackForGems(Actor Who, Bool Enabled)
{place or remove an actor from the list tracking actors who are growing gems}

	self.FormListLock(None,"SGO.ActorList.Gem","ActorTrackForGems")

	If(Enabled && Math.LogicalAnd(self.ActorGetBiologicalFunctions(Who),self.BioProduceGems) != 0)
		StorageUtil.FormListAdd(None,"SGO.ActorList.Gem",Who,False)
		self.ActorSetTimeUpdated(Who,"SGO.Actor.Gem.Time")
		self.PersistHackApply(Who)
	Else
		StorageUtil.FormListRemove(None,"SGO.ActorList.Gem",Who,True)
		;;StorageUtil.UnsetFloatValue(Who,"SGO.Actor.Gem.Time")
		;;StorageUtil.FloatListClear(Who,"SGO.Actor.Gem.Data")
	EndIf

	self.FormListUnlock(None,"SGO.ActorList.Gem")

	Return
EndFunction

Function ActorTrackForMilk(Actor Who, Bool Enabled)
{place or remove an actor from the list tracking actors generating milk.}

	self.FormListLock(None,"SGO.ActorList.Milk","ActorTrackForMilk")

	If(Enabled && Math.LogicalAnd(self.ActorGetBiologicalFunctions(Who),self.BioProduceMilk) != 0)
		StorageUtil.FormListAdd(None,"SGO.ActorList.Milk",Who,FALSE)
		self.ActorSetTimeUpdated(Who,"SGO.Actor.Milk.Time")
		self.PersistHackApply(Who)
	Else
		StorageUtil.FormListRemove(None,"SGO.ActorList.Milk",Who,TRUE)
		;;StorageUtil.UnsetFloatValue(Who,"SGO.Actor.Milk.Time")
		;;StorageUtil.UnsetFloatValue(Who,"SGO.Actor.Milk.Data")
	EndIf

	self.FormListUnlock(None,"SGO.ActorList.Milk")

	Return
EndFunction

Function ActorTrackForSemen(Actor Who, Bool Enabled)
{place or remove an actor from the list tracking actors generating semen.}

	self.FormListLock(None,"SGO.ActorList.Semen","ActorTrackForSemen")

	If(Enabled && Math.LogicalAnd(self.ActorGetBiologicalFunctions(Who),self.BioInseminate) != 0)
		StorageUtil.FormListAdd(None,"SGO.ActorList.Semen",Who,FALSE)
		self.ActorSetTimeUpdated(Who,"SGO.Actor.Semen.Time")
		self.PersistHackApply(Who)
	Else
		StorageUtil.FormListRemove(None,"SGO.ActorList.Semen",Who,FALSE)
		StorageUtil.UnsetFloatValue(Who,"SGO.Actor.Semen.Time")

		;; StorageUtil.UnsetFloatValue(Who,"SGO.Actor.Semen.Data")
		;; we want to keep the actual data so we can still use it for scale
		;; computations later. we just want to stop iterating over them every
		;; loop after they are full.
	EndIf

	self.FormListUnlock(None,"SGO.ActorList.Semen")

	Return
EndFunction

;/*****************************************************************************
	__             __                       __ 
 |  |--.-----.--|  .--.--.   .---.-.-----|__|
 |  _  |  _  |  _  |  |  |   |  _  |  _  |  |
 |_____|_____|_____|___  |   |___._|   __|__|
	               |_____|         |__|      

*****************************************************************************/;

Function ActorBodyUpdate(Actor Who)
{push the updated visual data into NiOverride. cheers to Groovtama for helping
witht he NiO stuffs.}

	self.ActorBodyUpdate_BellyScale(Who)
	self.ActorBodyUpdate_BreastScale(Who)
	self.ActorBodyUpdate_TesticleScale(Who)
	Return
EndFunction

Function ActorBodyUpdate_BellyScale(Actor Who)
{handle the physical representation of the belly.}

	If(Who.IsInFaction(self.dcc_sgo_FactionDisableScaleBelly))
		Return
	EndIf

	Float Belly = self.ActorModGetMultiplier(Who,"Belly.Scale")
	Int Count = StorageUtil.FloatListCount(Who,"SGO.Actor.Gem.Data")
	Float ScaleMax = (self.OptScaleBellyMax * self.ActorModGetMultiplier(Who,"Belly.ScaleMax"))

	;; with a max of six gems, max of 300% more visual
	;; depending on how the visual results look we may want to curve this value.
	;; to scale less at higher volumes.
	;; 0 gems (( 0 / 36) * 3.0) + 1 == 1.0
	;; 6 gems ((36 / 36) * 3.0) + 1 == 4.0

	Belly += ((self.ActorGemGetWeight(Who,FALSE) / (6 * self.ActorGemGetCapacity(Who))) * ScaleMax)
	Belly = PapyrusUtil.ClampFloat(Belly,0.01,ScaleMax) * (((Who.GetLeveledActorBase().GetWeight() / 100) * self.OptScaleBellyHigh) + 1)

	self.BoneSetScale(Who,"NPC Belly","SGO.Scale",Belly)
	Return
EndFunction

Function ActorBodyUpdate_BreastScale(Actor Who)
{handle the physical representation of the breasts.}

	If(Who.IsInFaction(self.dcc_sgo_FactionDisableScaleBreast))
		Return
	EndIf

	Float Breast = self.ActorModGetMultiplier(Who,"Breast.Scale")
	Float ScaleMax = (self.OptScaleBreastMax * self.ActorModGetMultiplier(Who,"Breast.ScaleMax"))

	;; with a max of 3 bottles, max of 200% more visual
	;; 0 milk ((0 / 3) * 2.0) + 1 == 1.0
	;; 3 milk ((3 / 3) * 2.0) + 1 == 3.0

	Breast += ((self.ActorMilkGetWeight(Who) / self.ActorMilkGetCapacity(Who)) * ScaleMax)
	Breast = PapyrusUtil.ClampFloat(Breast,0.01,ScaleMax) * (((Who.GetLeveledActorBase().GetWeight() / 100) * self.OptScaleBreastHigh) + 1)

	self.BoneSetScale(Who,"NPC L Breast","SGO.Scale",Breast)
	self.BoneSetScale(Who,"NPC R Breast","SGO.Scale",Breast)
	Return
EndFunction

Function ActorBodyUpdate_TesticleScale(Actor Who)
{handle the physical representation of the breasts.}

	If(Who.IsInFaction(self.dcc_sgo_FactionDisableScaleTesticle))
		Return
	EndIf
	
	Float Testicle = self.ActorModGetMultiplier(Who,"Testicle.Scale")
	Float ScaleMax = (self.OptScaleTesticleMax * self.ActorModGetMultiplier(Who,"Testicle.ScaleMax"))

	;; with a max of 2 bottles, max of 200% more visual
	;; 0 semen ((0 / 2) * 2.0) + 1 == 1.0
	;; 2 semen ((2 / 2) * 2.0) + 1 == 3.0

	Testicle += ((self.ActorSemenGetWeight(Who) / self.ActorSemenGetCapacity(Who)) * ScaleMax)
	Testicle = PapyrusUtil.ClampFloat(Testicle,0.01,ScaleMax)

	self.BoneSetScale(Who,"NPC GenitalsScrotum [GenScrot]","SGO.Scale",Testicle)
	Return
EndFunction

;/*****************************************************************************
	                                   __ 
 .-----.-----.--------.   .---.-.-----|__|
 |  _  |  -__|        |   |  _  |  _  |  |
 |___  |_____|__|__|__|   |___._|   __|__|
 |_____|                        |__|      
	                                      
*****************************************************************************/;

Bool Function ActorGemAdd(Actor Who, Float Value=0.0)
{add another gem to this actor's pipeline.}

	If(Math.LogicalAnd(self.ActorGetBiologicalFunctions(Who),self.BioProduceGems) == 0)
		self.PrintDebug(Who.GetDisplayName() + " cannot produce gems.");
		Return FALSE
	EndIf

	If(self.ActorGemGetCount(Who) < self.ActorGemGetCapacity(Who))
		StorageUtil.FloatListAdd(Who,"SGO.Actor.Gem.Data",Value,TRUE)
		self.Print(Who.GetDisplayName() + " is incubating another gem. (" + self.ActorGemGetCount(Who) + ")")	
		self.ActorTrackForGems(Who,TRUE)
		self.ActorTrackForMilk(Who,TRUE)
		self.ActorBodyUpdate(Who)
		Return TRUE
	EndIf

	Return FALSE
EndFunction

Function ActorGemGiveTo(Actor Source, Actor Dest, Int Count=1, String Bone="")
{transfer a gem from one actor's oven to another actors inventory. both actors
can be the same. this will mainly be used for a lulz transfer animation if
i can find a lesbian one that is suitable or get an animator to make me one.}

	Int x
	Form GemType

	x = 0
	While(x < Count)
		GemType = self.ActorGemRemove(Source)
		If(GemType == None)
			self.Print(Source.GetDisplayName() + " has no more gems to give.")
			Return
		EndIf

		If(Dest == None)
			self.ActorDropObject(Source,GemType,1,self.OptKickThingsWithHavok,Bone)
		Else
			Dest.AddItem(GemType,1)
		EndIf

		self.ActorProgressEnchanting(Source,self.GetGemValue(GemType))
		self.StatBump(None,"Gems")
		self.StatBump(Source,"Gems")
		self.EventSend_OnBirthed(Source,GemType)
		x += 1
	EndWhile

	Return
EndFunction

Form Function ActorGemRemove(Actor Who)
{remove the next gem from the specified actor. returns a form describing
what object we should spawn in the world. this will be used mostly by the
gem place and gem give functions. if the value is provided it will only
remove the gem if it is that.}

	Float Value = self.ActorGemRemoveFloat(Who)
	If(Value == -1)
		Return None
	EndIf

	If(Value < 1.0)
		;; return a random fragment if less than a gem.
		Return self.dcc_sgo_ListGemFragment.GetAt(Utility.RandomInt(0,(self.dcc_sgo_ListGemFragment.GetSize() - 1))) as Form
	EndIf

	If(self.OptGemFilled)
		Return self.dcc_sgo_ListGemFull.GetAt(Value as Int - 1)
	Else
		Return self.dcc_sgo_ListGemEmpty.GetAt(Value as Int - 1)
	EndIf
EndFunction

Float Function ActorGemRemoveFloat(Actor Who)
{removes the first gem returning the float value rather than the form.}

	If(self.ActorGemGetCount(Who) == 0)
		Return -1
	EndIf

	;; get the first thing.
	Float Value = PapyrusUtil.ClampFloat(StorageUtil.FloatListGet(Who,"SGO.Actor.Gem.Data",0),0.0,6.0)

	;; the first thing off.
	StorageUtil.FloatListRemoveAt(Who,"SGO.Actor.Gem.Data",0)

	;; prompt a visual update.
	self.ActorBodyUpdate_BellyScale(Who)

	Return Value
EndFunction

Form Function ActorGemRemoveFromInventory(Actor Who, Int Size)
{remove a gem or fragment of type from the specified actor's inventory. for
actual gems it will prefer unfilled over filled.}

	Form What
	Int x

	If(Size == 0)
		;; handle the removal of various fragments.

		x = 0
		While(x < self.dcc_sgo_ListGemFragment.GetSize())
			If(Who.GetItemCount(self.dcc_sgo_ListGemFragment.GetAt(x)) > 0)
				Who.RemoveItem(self.dcc_sgo_ListGemFragment.GetAt(x),1,FALSE)
				Return self.dcc_sgo_ListGemFragment.GetAt(x)
			EndIf
			x += 1
		EndWhile
	Else
		;; handle the removal of gems. prefer unfilled first.

		If(Who.GetItemCount(self.dcc_sgo_ListGemEmpty.GetAt(Size - 1)) > 0)
			Who.RemoveItem(self.dcc_sgo_ListGemEmpty.GetAt(Size - 1),1,FALSE)
			Return self.dcc_sgo_ListGemEmpty.GetAt(Size - 1)
		EndIf

		If(Who.GetItemCount(self.dcc_sgo_ListGemFull.GetAt(Size - 1)) > 0)
			Who.RemoveItem(self.dcc_sgo_ListGemFull.GetAt(Size - 1),1,FALSE)
			Return self.dcc_sgo_ListGemFull.GetAt(Size - 1)
		EndIf
	EndIf

	Return None
EndFunction

Function ActorGemAdjustValue(Actor Who, Int Gem, Float Adjustment)
{modify a gem's current state in our belly.}

	StorageUtil.FloatListAdjust(Who,"SGO.Actor.Gem.Data",Gem,Adjustment)
	Return
EndFunction

;;;;;;;;

Int Function ActorGemGetCapacity(Actor Who)
{determine how many gems this actor should be able to carry.}

	;; the actor mod allows to add or remove a gem slot from this actor.

	Return (self.OptGemMaxCapacity + self.ActorModGetTotal(Who,"Gem.Capacity")) as Int
EndFunction

Int Function ActorGemGetCount(Actor Who)
{get how many gems are currently brewing.}
	
	Return StorageUtil.FloatListCount(Who,"SGO.Actor.Gem.Data")
EndFunction

Int[] Function ActorGemGetInventory(Actor Who)
{get the state of gems from the actors inventory. returns a length 7 array.}

	Int[] Result = new Int[7]
	Int x

	x = 0
	While(x < Result.Length)
		If(x == 0)
			Result[x] = self.ActorGemGetInventory_GetFragments(Who)
		Else
			Result[x] = self.ActorGemGetInventory_GetGems(Who,(x - 1))
		EndIf

		x += 1
	EndWhile

	Return Result
EndFunction

Int Function ActorGemGetInventory_GetFragments(Actor Who)
{how many of the various fragments do we have?}

	Int Count = 0
	Int x = 0

	While(x < self.dcc_sgo_ListGemFragment.GetSize())
		Count += Who.GetItemCount(self.dcc_sgo_ListGemFragment.GetAt(x))
		x += 1
	EndWhile

	Return Count
EndFunction

Int Function ActorGemGetInventory_GetGems(Actor Who, Int Offset)
{how many of a specific gem offset we have?}

	Int Count = Who.GetItemCount(self.dcc_sgo_ListGemEmpty.GetAt(Offset))
	Count += Who.GetItemCount(self.dcc_sgo_ListGemFull.GetAt(Offset))

	Return Count
EndFunction

Form[] Function ActorGemListInventory(Actor Who)
{build a list of all the gems we have in inventory.}

	Form[] List = Utility.CreateFormArray(0)
	Form Current
	Int x

	x = 0
	While(x < self.dcc_sgo_ListGemFragment.GetSize())
		Current = self.dcc_sgo_ListGemFragment.GetAt(x)
		If(Who.GetItemCount(Current) > 0)
			List = PapyrusUtil.PushForm(List,Current)
		EndIf
		x += 1
	EndWhile

	x = 0
	While(x < self.dcc_sgo_ListGemEmpty.GetSize())
		Current = self.dcc_sgo_ListGemEmpty.GetAt(x)
		If(Who.GetItemCount(Current) > 0)
			List = PapyrusUtil.PushForm(List,Current)
		EndIf
		x += 1
	EndWhile

	x = 0
	While(x < self.dcc_sgo_ListGemFull.GetSize())
		Current = self.dcc_sgo_ListGemFull.GetAt(x)
		If(Who.GetItemCount(Current) > 0)
			List = PapyrusUtil.PushForm(List,Current)
		EndIf
		x += 1
	EndWhile

	Return List
EndFunction

Float Function ActorGemGetTime(Actor Who)
{determine how fast gems should be generating for this actor.}

	;; the mod is 0 when empty. if we have a total of 1.5 that means i want
	;; 150% faster production rate.
	Return self.OptGemMatureTime * (self.ActorModGetMultiplier(Who,"Gem.Rate"))
EndFunction

Float Function ActorGemGetPercent(Actor Who)
{return a percentage range 0 to 100}

	Return (self.ActorGemGetWeight(Who,FALSE) / (self.ActorGemGetCapacity(Who) * 6)) * 100
EndFunction

Float Function ActorGemGetWeight(Actor Who, Bool Overflow=FALSE)
{find the current gem weight being carried.}

	Int Count = StorageUtil.FloatListCount(Who,"SGO.Actor.Gem.Data")
	Float Weight = 0.0
	Float Current = 0.0
	Int x = 0

	While(x < Count)
		Current = StorageUtil.FloatListGet(Who,"SGO.Actor.Gem.Data",x)
		If(!Overflow && Current > 6)
			Current = 6
		EndIf

		Weight += Current
		x += 1
	EndWhile

	Return Weight
EndFunction

Function ActorGemClearData(Actor Who)
{drop gem data}

	StorageUtil.FloatListClear(Who,"SGO.Actor.Gem.Data")
	Return
EndFunction

Function ActorGemUpdateData(Actor Who, Bool Force=FALSE, Bool RequireLock=TRUE)
{cause this actor to have its gem data recalculated. it will generate an array
that is a snapshot of the current gem states, and that snapshot will be emitted
in a mod event if a gem reached the next stage. this is probably the heaviest
function in this mod, as data is flying in and out of papyrusutil constantly.}

	Int Bio = self.ActorGetBiologicalFunctions(Who)
	Float Time = self.ActorGetTimeSinceUpdate(Who,"SGO.Actor.Gem.Time")
	Int Count = self.ActorGemGetCount(Who)

	If(Math.LogicalAnd(Bio,self.BioProduceGems) == 0)
		;; no need to recalculate someone who cant produce gems.
		self.ActorTrackForGems(Who,FALSE)
		Return
	EndIf

	If(Count == 0)
		;; no need to recalculate someone who has no gems.
		self.ActorTrackForGems(Who,FALSE)
		Return
	EndIf

	If(Time < 1.0 && !Force)
		;; no need to recalculate this actor more than once a game hour.
		;;self.PrintLog("ActorGemUpdateData:TimeAbort " + Who.GetDisplayName())
		Return
	EndIf

	;;;;;;;;
	;;;;;;;;

	;; we allow gems to grow larger than 6 for a mechanic later where we
	;; will force labour if you wait too long. bodyscaling will clamp it
	;; to six for the scales though.

	;;self.PrintLog("ActorGemUpdateData:Start " + Who.GetDisplayName())

	Int[] Progress = new Int[7]
	Bool Progressed = FALSE
	Float Total = 0.0

	Float Gem
	Float Before
	Int x = 0

	While(x < Count)
		Gem = StorageUtil.FloatListGet(Who,"SGO.Actor.Gem.Data",x)
		If(Gem < 0)
			;; we are able to drop below 0 now as we damage the gems and do not
			;; bother clamping them for performance reasons.
			Gem = 0
		EndIf

		Before = Gem

		;; if mature time = 24hr, processed once an hour
		;; 1 / 24 = 0.0416666/hr * 24 = 1 = one level per day = wrong
		;; (1 / 24) * 6 = 0.25/hr * 24 = 6 = six level per day = right

		;; if mature time = 144hr (6d), processed once an hour
		;; (1 / 144) * 6 = 0.0416/hr * 24 = 1 = one level per day = right

		Gem += ((Time / self.ActorGemGetTime(Who)) * 6)
		Gem = PapyrusUtil.ClampFloat(Gem,0.0,12.0)

		Progress[PapyrusUtil.ClampInt(Gem as Int,0,6)] = Progress[PapyrusUtil.ClampInt(Gem as Int,0,6)] + 1
		Total += Gem
		self.StatBump(None,"GemGrowth",(Gem-Before))
		self.StatBump(Who,"GemGrowth",(Gem-Before))

		If(Before as Int < Gem as Int)
			;; if the gem reached the next stage then mark it down
			;; so we can emit an event listing the progression.
			Progressed = TRUE
		EndIf
		
		StorageUtil.FloatListSet(Who,"SGO.Actor.Gem.Data",x,Gem)
		x += 1
	EndWhile

	self.ActorSetTimeUpdated(Who,"SGO.Actor.Gem.Time")
	self.ActorBodyUpdate_BellyScale(Who)
	self.ActorApplyBellyEncumber(Who)

	;;;;;;;;
	;;;;;;;;

	Float Capacity = self.ActorGemGetCapacity(Who)

	If(Progressed)
		self.Immersive_OnGemProgress(Who,Progress)
		self.EventSend_OnGemProgress(Who,Progress)
	Else
		If(Progress[6] >= Capacity)
			self.Immersive_OnGemFull(Who)
		EndIf
	EndIf

	;;self.PrintLog("ActorGemUpdateData:Done " + Who.GetDisplayName())

	Return
EndFunction

;/*****************************************************************************
	       __ __ __                    __ 
 .--------|__|  |  |--.   .---.-.-----|__|
 |        |  |  |    <    |  _  |  _  |  |
 |__|__|__|__|__|__|__|   |___._|   __|__|
	                            |__|      

*****************************************************************************/;

Function ActorMilkGiveTo(Actor Source, Actor Dest, Int Count=1)
{transfer a bottle of milk from one actor to another. both actors can be the
same.}

	Form MilkType
	Int x

	x = 0
	While(x < Count)
		MilkType = self.ActorMilkRemove(Source)
		If(MilkType == None)
			self.Print(Source.GetDisplayName() + " is not ready to give milk.");
			Return
		EndIf

		self.ActorProgressAlchemy(Source)

		If(Dest == None)
			self.ActorDropObject(Source,MilkType,1,self.OptKickThingsWithHavok,"NPC L Breast")
		Else
			Dest.AddItem(MilkType,1)
		EndIf

		self.StatBump(None,"Milks")
		self.StatBump(Source,"Milks")
		self.EventSend_OnMilked(Source,MilkType)
		x += 1
	EndWhile

	Return
EndFunction

Form Function ActorMilkRemove(Actor Who)
{remove a bottle of milk from the specified actor. returns a form describing
the type of milk that we should spawn in the world.}

	If(self.ActorMilkGetWeight(Who) < 1.0)
		Return None
	EndIf

	StorageUtil.AdjustFloatValue(Who,"SGO.Actor.Milk.Data",-1.0)
	self.ActorBodyUpdate_BreastScale(Who)

	return self.ActorMilkGetType(Who)
EndFunction

;;;;;;;;

Int Function ActorMilkGetCapacity(Actor Who)
{figure out how much milk this actor can carry.}

	;; no mods return a default of 0. a mod of 1.5 means i want to be able to
	;; carry 150% more milks.
	Return (self.OptMilkMaxCapacity * self.ActorModGetMultiplier(Who,"Milk.Capacity")) as Int
EndFunction

Int Function ActorMilkGetCount(Actor Who)
{get the current whole bottle count.}

	Return self.ActorMilkGetWeight(Who) as Int
EndFunction

Float Function ActorMilkGetTime(Actor Who)
{figure out how fast this actor is generating milk.}

	Return (self.OptMilkProduceTime * (self.ActorModGetMultiplier(Who,"Milk.Rate")))
EndFunction

Form Function ActorMilkGetType(Actor Who)
{figure out what racist milk to give.}

	Int Index

	;; give a milk for normal races.
	Index = self.dcc_sgo_ListRaceNormal.Find(Who.GetRace())
	If(Index != -1)
		Return self.dcc_sgo_ListMilkItems.GetAt(Index)
	EndIf

	;; give a milk for vampire races that match normal races.
	Index = self.dcc_sgo_ListRaceVampire.Find(Who.GetRace())
	If(Index != -1)
		Return self.dcc_sgo_ListMilkItems.GetAt(Index)
	EndIf

	;; give the generic milk that sucks.
	Return self.dcc_sgo_ListMilkItems.GetAt(0)
EndFunction

Float Function ActorMilkGetPercent(Actor Who)
{find the current mik percentage of fullness. returns a float between 0 and
100.}

	Return (self.ActorMilkGetWeight(Who) / self.ActorMilkGetCapacity(Who)) * 100
EndFunction

Float Function ActorMilkGetWeight(Actor Who)
{find the current milk weight being carried.}

	Return StorageUtil.GetFloatValue(Who,"SGO.Actor.Milk.Data")
EndFunction

Function ActorMilkClearData(Actor Who)
{drop gem data}

	StorageUtil.UnsetFloatValue(Who,"SGO.Actor.Milk.Data")
	Return
EndFunction

Function ActorMilkUpdateData(Actor Who, Bool Force=FALSE)
{cause this actor to have its milk data recalculated. if we have gained another
full bottle then emit a mod event saying how many bottles are ready to go.}

	Int Bio = self.ActorGetBiologicalFunctions(Who)
	Float Time = self.ActorGetTimeSinceUpdate(Who,"SGO.Actor.Milk.Time")

	If(Math.LogicalAnd(Bio,self.BioProduceMilk) == 0)
		;; no need to recalculate someone who cant make milk.
		;; self.PrintDebug(Who.GetDisplayName() + " stopping milk (no produce)")
		self.ActorTrackForMilk(Who,FALSE)
		Return
	EndIf

	If(self.ActorGemGetCount(Who) == 0 && self.ActorModGetTotal(Who,"Milk.Produce") == 0.0)
		;; no need to recalculate someone who doesn't need to make milk.
		;; self.PrintDebug(Who.GetDisplayName() + " stopping milk (no need)")
		self.ActorTrackForMilk(Who,FALSE)
		Return
	EndIf

	If(Time < 1.0 && !Force)
		;; no need to recalculate this actor more than once a game hour.
		;; self.PrintDebug(Who.GetDisplayName() + " skipping milk (not time)")
		;;self.PrintLog("ActorMilkUpdateData:TimeAbort " + Who.GetDisplayName())
		Return
	EndIf

	;;;;;;;;
	;;;;;;;;

	;;self.PrintLog("ActorMilkUpdateData:Start " + Who.GetDisplayName())

	Float Capacity = self.ActorMilkGetCapacity(Who)
	Float Overage = 0.0
	Float Milk = StorageUtil.GetFloatValue(Who,"SGO.Actor.Milk.Data",0.0)
	Float Before = Milk

	;; produce time 8hr (3/day), once an hour
	;; 1 / 8 = 0.125/hr * 24 = 3 = three per day = right
	;; calculate how much we are over as well for later use.

	Milk += (Time / self.ActorMilkGetTime(Who))
	If(Milk >= Capacity)
		Overage = Milk - Capacity
		Milk = Capacity
	EndIf
	self.StatBump(None,"MilkProduce",(Milk-Before))
	self.StatBump(Who,"MilkProduce",(Milk-Before))

	If(Milk / Capacity >= self.OptMilkLeakThresh)
		self.ActorOverlayApply(Who,"MilkLeak","textures\\dcc-soulgem-oven\\milk-leak.dds",1,0.35)
	Else
		self.ActorOverlayClear(Who,"MilkLeak")
	EndIf

	StorageUtil.SetFloatValue(Who,"SGO.Actor.Milk.Data",Milk)
	self.ActorSetTimeUpdated(Who,"SGO.Actor.Milk.Time")
	self.ActorBodyUpdate_BreastScale(Who)
	self.ActorApplyBreastInfluence(Who)

	;;;;;;;;
	;;;;;;;;

	;; if the last calculation was a bottle less than the current calculation
	;; that means we slept/waited/fasttraveled a long time. if the last calc
	;; is equal to this calc that means we never milked after being full.
	;; if we wait while already full we can see there will be overage then
	;; and we will now send that with the event so that the milker can give
	;; you what you are due for wearing it across fast travels or whatever.

	If(Before as Int < Milk as Int || Overage)
		If(Before == Milk)
			self.Immersive_OnMilkFull(Who)
		Else
			self.Immersive_OnMilkProgress(Who)
		EndIf
		
		self.EventSend_OnMilkProgress(Who,(Milk as Int),(Overage as Int))
	EndIf

	;;self.PrintLog("ActorMilkUpdateData:Done " + Who.GetDisplayName())

	Return
EndFunction

;/*****************************************************************************
	                                               __ 
 .-----.-----.--------.-----.-----.   .---.-.-----|__|
 |__ --|  -__|        |  -__|     |   |  _  |  _  |  |
 |_____|_____|__|__|__|_____|__|__|   |___._|   __|__|
	                                        |__|      

*****************************************************************************/;

Function ActorSemenGiveTo(Actor Source, Actor Dest, Int Count=1)
{transfer a bottle of semen from one actor to another. both actors can be the
same.}

	Form SemenType
	Int x

	x = 0
	While(x < Count)
		SemenType = self.ActorSemenRemove(Source)
		If(SemenType == None)
			self.Print(Source.GetDisplayName() + " is not ready to give semen.");
			Return
		EndIf

		self.ActorProgressAlchemy(Source,0.75)

		If(Dest == None)
			self.ActorDropObject(Source,SemenType,1,self.OptKickThingsWithHavok)
		Else
			Dest.AddItem(SemenType,1)
		EndIf

		self.StatBump(None,"Semen")
		self.StatBump(Source,"Semen")
		self.EventSend_OnWanked(Source,SemenType)
		x += 1
	EndWhile

	Return
EndFunction

Form Function ActorSemenRemove(Actor Who)
{remove a bottle of semen from the specified actor. returns a form describing
the type of semen that we should spawn in the world.}

	If(self.ActorSemenGetWeight(Who) < 1.0)
		Return None
	EndIf

	Int Index

	StorageUtil.AdjustFloatValue(Who,"SGO.Actor.Semen.Data",-1.0)
	self.ActorBodyUpdate_TesticleScale(Who)

	;; give a semen for normal races.
	Index = self.dcc_sgo_ListRaceNormal.Find(Who.GetRace())
	If(Index != -1)
		Return self.dcc_sgo_ListSemenItems.GetAt(Index)
	EndIf

	;; give a semen for vampire races that match normal races.
	Index = self.dcc_sgo_ListRaceVampire.Find(Who.GetRace())
	If(Index != -1)
		Return self.dcc_sgo_ListSemenItems.GetAt(Index)
	EndIf

	;; give the generic semen that sucks.
	Return self.dcc_sgo_ListSemenItems.GetAt(0)
EndFunction

Form[] Function ActorSemenListInventory(Actor Who)
{get an array that only lists the semens an actor has. this function is kinda a
hax and currently the only one. gem has a non-hax but milk will need one of
these in the near future.}

	Form[] List = Utility.CreateFormArray(0)
	Int ListLen = self.dcc_sgo_ListSemenItems.GetSize()
	Int x = 0

	While(x < ListLen)
		If(Who.GetItemCount(self.dcc_sgo_ListSemenItems.GetAt(x)) != 0)
			List = PapyrusUtil.PushForm(List,self.dcc_sgo_ListSemenItems.GetAt(x))
		EndIf

		x += 1
	EndWhile

	Return List
EndFunction

;;;;;;;;

Int Function ActorSemenGetCapacity(Actor Who)
{figure out how much semen this actor can carry.}

	;; no mods return a default of 0. a mod of 1.5 means i want to be able to
	;; carry 150% more milks.
	Return (self.OptSemenMaxCapacity * self.ActorModGetMultiplier(Who,"Semen.Capacity")) as Int
EndFunction

Float Function ActorSemenGetTime(Actor Who)
{figure out how fast this actor is generating semen.}

	Return (self.OptSemenProduceTime * (self.ActorModGetMultiplier(Who,"Semen.Rate")))
EndFunction

Float Function ActorSemenGetPercent(Actor Who)
{find the current semen percentage of fullness.}

	Return (self.ActorSemenGetWeight(Who) / self.OptSemenMaxCapacity) * 100
EndFunction

Float Function ActorSemenGetWeight(Actor Who)
{find the current semen weight being carried.}

	Int Bio = self.ActorGetBiologicalFunctions(Who)
	Int FirstTime = 0
	Float Semen = StorageUtil.GetFloatValue(Who,"SGO.Actor.Semen.Data",-1.0)

	;; trick it a bit so that when wanked the first time ever they report as
	;; being full if they are a semen producer.

	If(Semen == -1.0)
		If(Math.LogicalAnd(Bio,self.BioInseminate))
			Semen = self.ActorSemenGetCapacity(Who)
			StorageUtil.SetFloatValue(Who,"SGO.Actor.Semen.Data",Semen)
		Else
			Semen = 0.0
		EndIf
	EndIf

	Return Semen
EndFunction

Function ActorSemenClearData(Actor Who)
{drop gem data}

	StorageUtil.UnsetFloatValue(Who,"SGO.Actor.Semen.Data")
	Return
EndFunction

Function ActorSemenUpdateData(Actor Who, Bool Force=FALSE)
{cause this actor to have its milk data recalculated. if we have gained another
full bottle then emit a mod event saying how many bottles are ready to go.}

	Int Bio = self.ActorGetBiologicalFunctions(Who)
	Float Time = self.ActorGetTimeSinceUpdate(Who,"SGO.Actor.Semen.Time")
	Float Capacity = self.ActorSemenGetCapacity(Who)
	Float Semen = self.ActorSemenGetWeight(Who)
	Float Before = Semen

	If(Math.LogicalAnd(Bio,self.BioInseminate) == 0)
		;; no need to recalculate someone who cant inseminate.
		;; self.PrintDebug(Who.GetDisplayName() + " does not need semen")
		self.ActorTrackForSemen(Who,FALSE)
		Return
	EndIf

	If(Semen >= Capacity)
		;; no need to recalculate someone who is full. for semen we will
		;; unregister them since wanking will rereg. (this logic does not
		;; apply to gems or milk.)
		self.ActorTrackForSemen(Who,FALSE)
		Return
	EndIf

	If(Time < 1.0 && !Force)
		;; no need to recalculate this actor more than once a game hour.
		;; self.PrintDebug(Who.GetDisplayName() + " semen calc too soon")
		Return
	EndIf

	;;;;;;;;
	;;;;;;;;

	;; produce time 12hr (2/day), once an hour
	;; 1 / 12 = 0.083/hr * 24 = 2 = two per day = right

	Semen += (Time / self.ActorSemenGetTime(Who))
	If(Semen > Capacity)
		self.Immersive_OnSemenFull(Who)
		Semen = Capacity
	EndIf
	self.StatBump(None,"SemenProduce",(Semen-Before))
	self.StatBump(Who,"SemenProduce",(Semen-Before))

	StorageUtil.SetFloatValue(Who,"SGO.Actor.Semen.Data",Semen)
	self.ActorSetTimeUpdated(Who,"SGO.Actor.Semen.Time")

	;;;;;;;;
	;;;;;;;;

	If(Before as Int < Semen as Int)
		self.Immersive_OnSemenProgress(Who)
		self.EventSend_OnSemenProgress(Who,(Semen as Int))
	EndIf

	If(Semen >= Capacity)
		self.ActorTrackForSemen(Who,FALSE)
	EndIf

	self.ActorBodyUpdate_TesticleScale(Who)
	Return
EndFunction

;/*****************************************************************************
	         __                             __   __                   
 .---.-.----|  |_.-----.----.   .---.-.----|  |_|__.-----.-----.-----.
 |  _  |  __|   _|  _  |   _|   |  _  |  __|   _|  |  _  |     |__ --|
 |___._|____|____|_____|__|     |___._|____|____|__|_____|__|__|_____|

*****************************************************************************/;

Function ActorActionBirth(Actor Source, Actor Dest)
{perform the full birthing sequence.}

	If(self.ActorGemGetCount(Source) == 0)
		self.Print(Source.GetDisplayName() + " is not ready for labour.")
		Return
	EndIf

	If(Source == Dest)
		self.ActorActionBirth_Solo(Source)
	Else
		self.ActorActionBirth_Duo(Source,Dest)
	EndIf

	Return
EndFunction

Function ActorActionBirth_Solo(Actor Source)
{single actor birthing sequence.}

	Float WaitTime = 3.0
	String Bone

	If(self.ActorNoAnimate(Source))
		WaitTime = 0.25
	EndIf

	self.BehaviourDefault(Source)
	self.ActorRemoveChestpiece(Source)
	Bone = self.ImmersiveAnimationBirthing(Source)

	If(Source == self.Player)
		MiscUtil.SetFreeCameraState(TRUE,7.0)
	EndIf

	While(self.ActorGemGetCount(Source) > 0)
		self.EventSend_OnBirthing(Source)
		self.ImmersiveBlush(Source,1.0,3,3.0)
		self.ImmersiveExpression(Source,FALSE)
		Utility.Wait(WaitTime)
		self.ImmersiveExpression(Source,TRUE)
		self.ImmersiveSoundMoan(Source,FALSE)
		Utility.Wait(WaitTime)
		self.ImmersiveSoundMoan(Source,TRUE)
		self.ActorGemGiveTo(Source,None,1,Bone)
		Utility.Wait(3.0)
		If(self.OptAnimationBirthing == -1)
			Bone = self.ImmersiveAnimationBirthing(Source)
		EndIf
	EndWhile

	If(Source == self.Player)
		MiscUtil.SetFreeCameraState(FALSE)
	EndIf

	self.ImmersiveExpression(Source,FALSE)
	self.ImmersiveAnimationIdle(Source)
	self.BehaviourClear(Source,TRUE)
	self.ActorReplaceChestpiece(Source)
	self.ActorApplyBellyEncumber(Source)

	Return
EndFunction

Function ActorActionBirth_Duo(Actor Source, Actor Dest)
{dual actor birthing sequence - aka transfer from one to another.}

	Float WaitTime = 3.0

	If(self.ActorNoAnimate(Source) || self.ActorNoAnimate(Dest))
		WaitTime = 0.25
	EndIf

	self.BehaviourDefault(Source)
	self.BehaviourDefault(Dest)
	self.ActorRemoveChestpiece(Source)
	self.ActorRemoveChestpiece(Dest)

	If(Source == self.Player || Dest == self.Player)
		MiscUtil.SetFreeCameraState(TRUE,7.0)
	EndIf

	self.PlayDualAnimation(Source,"SGO_Transfer_A1",Dest,"SGO_Transfer_A2")
	While(self.ActorGemGetCount(Source) > 0 && self.ActorGemGetCount(Dest) < self.ActorGemGetCapacity(Dest))
		self.EventSend_OnBirthing(Source)
		self.ImmersiveBlush(Source,1.0,3,3.0)
		Utility.Wait(WaitTime)
		self.ImmersiveExpression(Source,TRUE)
		self.ImmersiveSoundMoan(Source,FALSE)
		Utility.Wait(0.5)
		self.ImmersiveBlush(Dest,1.0,3,3.0)
		self.ImmersiveExpression(Dest,TRUE)
		self.ImmersiveSoundMoan(Dest,TRUE)
		self.ActorGemAdd(Dest,self.ActorGemRemoveFloat(Source))
		self.StatBump(None,"Transfers")
		self.StatBump(Source,"TransfersOut")
		self.StatBump(Dest,"TransfersIn")
		Utility.Wait(3.0)
		self.ImmersiveExpression(Source,FALSE)
		self.ImmersiveExpression(Dest,FALSE)
	EndWhile

	If(Source == self.Player || Dest == self.Player)
		MiscUtil.SetFreeCameraState(FALSE)
	EndIf

	self.ImmersiveExpression(Source,FALSE)
	self.ImmersiveExpression(Dest,FALSE)
	self.ImmersiveAnimationIdle(Source)
	self.ImmersiveAnimationIdle(Dest)
	self.ActorReplaceChestpiece(Source)
	self.ActorReplaceChestpiece(Dest)
	self.BehaviourClear(Source,TRUE)
	self.BehaviourClear(Dest,TRUE)
	self.ActorApplyBellyEncumber(Source)
	self.ActorApplyBellyEncumber(Dest)

	Return
EndFunction

Function ActorActionMilk(Actor Source, Actor Dest)
{perform the full milking sequence.}

	If(self.ActorMilkGetWeight(Source) < 1.0)
		self.Print(Source.GetDisplayName() + " is not ready to be milked.")
		Return
	EndIf

	If(Source == Dest)
		self.ActorActionMilk_Solo(Source)
	Else
		self.ActorActionMilk_Duo(Source,Dest)
	EndIf

	If(self.OptMilkLeakClear)
		self.ActorOverlayClear(Source,"MilkLeak")
	EndIf

	Return
EndFunction

Function ActorActionMilk_Solo(Actor Source)
{single actor milking sequence.}

	Float WaitTime = 3.0
	If(self.ActorNoAnimate(Source))
		WaitTime = 0.25
	EndIf

	Actor Dest = None
	If(Source == self.Player)
		Dest = self.Player
	EndIf

	self.BehaviourDefault(Source)
	self.ActorRemoveChestpiece(Source)
	self.ImmersiveAnimationMilking(Source)

	While(self.ActorMilkGetWeight(Source) >= 1.0)
		self.EventSend_OnMilking(Source)
		self.ImmersiveBlush(Source)
		Utility.Wait(WaitTime)
		self.ImmersiveExpression(Source,TRUE)
		self.ImmersiveSoundMoan(Source,FALSE)
		Utility.Wait(2.0)
		self.ActorMilkGiveTo(Source,Dest,1)
		self.ImmersiveExpression(Source,FALSE)
	EndWhile

	self.ImmersiveExpression(Source,FALSE)
	self.ImmersiveAnimationIdle(Source)
	self.ActorReplaceChestpiece(Source)
	self.ActorApplyBreastInfluence(Source)
	self.BehaviourClear(Source,TRUE)
	Return
EndFunction

Function ActorActionMilk_Duo(Actor Source, Actor Dest)
{dual actor milking sequence.}

	Return
EndFunction

Function ActorActionWank(Actor Source, Actor Dest)
{perform the full wanking sequence.}

	If(self.ActorSemenGetWeight(Source) < 1.0)
		self.Print(Source.GetDisplayName() + " is not ready to be wanked.")
		Return
	EndIf

	If(Source == Dest)
		self.ActorActionWank_Solo(Source)
	Else
		self.ActorActionWank_Duo(Source,Dest)
	EndIf

	self.ActorTrackForSemen(Source,TRUE)
	Return
EndFunction

Function ActorActionWank_Solo(Actor Source)
{single actor wanking sequence.}

	Float WaitTime = 3.0
	If(self.ActorNoAnimate(Source) || self.ActorNoAnimate(Dest))
		WaitTime = 0.25
	EndIf

	Actor Dest = None
	If(Source == self.Player)
		Dest = self.Player
	EndIf

	self.BehaviourDefault(Source)
	self.ActorRemoveChestpiece(Source)
	self.ImmersiveErection(Source,TRUE)
	self.ImmersiveAnimationWanking(Source)

	While(self.ActorSemenGetWeight(Source) >= 1.0)
		self.EventSend_OnWanking(Source)
		self.ImmersiveBlush(Source)
		Utility.Wait(WaitTime)
		self.ImmersiveExpression(Source,TRUE)
		self.ImmersiveSoundMoan(Source,FALSE)
		Utility.Wait(WaitTime)
		self.ActorSemenGiveTo(Source,Dest,1)
		self.ImmersiveExpression(Source,FALSE)
		Utility.Wait(3.0)
	EndWhile

	self.ImmersiveExpression(Source,FALSE)
	self.ImmersiveAnimationIdle(Source)
	self.ImmersiveErection(Source,FALSE)
	self.ActorReplaceChestpiece(Source)
	self.BehaviourClear(Source,TRUE)

	Return
EndFunction

Function ActorActionWank_Duo(Actor Source, Actor Dest)
{dual actor wanking sequence.}

	Return
EndFunction

Function ActorActionInsert(Actor Source, Actor Dest, Form GemType)
{gem insertion sequence.}

	Float WaitTime = 3.0
	Int Iter = 0
	Int Count = ActorActionInsert_QueryCount(Source,Dest,GemType)
	Float GemValue = self.GetGemValue(GemType) As Float

	;; decide if we should even attempt.

	If(self.ActorGemGetCount(Dest) >= self.ActorGemGetCapacity(Dest))
		self.Print(Dest.GetDisplayName() + " cannot fit anymore gems.")
		Return
	EndIf

	If(Source.GetItemCount(GemType) == 0)
		self.Print(Source.GetDisplayName() + " has none of those gems to use.")
		Return
	EndIf

	;;;;;;;;
	;;;;;;;;

	;; decide on an animation delay.

	If(self.ActorNoAnimate(Source) || self.ActorNoAnimate(Dest))
		WaitTime = 1.25
	EndIf

	;; if inserting a fragment then pick a random number to start the value
	;; at to represent its mass.

	If(GemValue == 0.0)
		GemValue = Utility.RandomFloat(0.1,0.6)
	EndIf

	;;;;;;;;
	;;;;;;;;

	self.Print(Dest.GetDisplayName() + " will insert " + Count + " " + GemType.GetName())
	Source.RemoveItem(GemType,Count)

	If(self.ActorNoAnimate(Dest))
	;; if the destination actor is set to not be animated then perform an
	;; abbreviated sequence.

		Iter = 0
		While(Iter < Count)
			self.ImmersiveBlush(Dest)
			self.ImmersiveSoundMoan(Dest,FALSE)
			self.ImmersiveExpression(Dest,TRUE)
			self.EventSend_OnInserting(Dest,GemType)
			Utility.Wait(WaitTime)

			self.ActorGemAdd(Dest,GemValue)
			self.StatBump(None,"Inserts")
			self.StatBump(Dest,"Inserts")
			self.EventSend_OnInserted(Dest,GemType)
			self.ImmersiveExpression(Dest,FALSE)
			Utility.Wait(WaitTime)

			Iter += 1
		EndWhile	
	Else
	;; else run a full sexy animation sequence for total super immersion.

		self.BehaviourDefault(Dest)
		self.ActorRemoveChestpiece(Dest)

		Iter = 0
		While(Iter < Count)
			self.ImmersiveAnimationInsertion(Dest)
			self.EventSend_OnInserting(Dest,GemType)
			Utility.Wait(WaitTime)

			self.ImmersiveExpression(Dest,TRUE)
			self.ImmersiveSoundMoan(Dest,FALSE)
			self.ImmersiveBlush(Dest)
			Utility.Wait(WaitTime)

			self.ActorGemAdd(Dest,GemValue)
			self.StatBump(None,"Inserts")
			self.StatBump(Dest,"Inserts")
			self.ImmersiveSoundMoan(Dest)
			self.EventSend_OnInserted(Dest,GemType)
			Utility.Wait(WaitTime * 0.666)

			self.ImmersiveExpression(Dest,FALSE)
			Iter += 1
		EndWhile

		self.ImmersiveAnimationIdle(Dest)
		self.ImmersiveExpression(Dest,FALSE)
		self.ActorReplaceChestpiece(Dest)
		self.BehaviourClear(Dest,TRUE)
	EndIf

	Return
EndFunction

Int Function ActorActionInsert_QueryCount(Actor Source, Actor Dest, Form What)
{ask how many gems you wish to insert.}

	;; determine the maximum to default the entry to.

	Int DestCount = self.ActorGemGetCapacity(Dest) - self.ActorGemGetCount(Dest)
	Int SourceCount = Source.GetItemCount(What)
	Int Output

	;; if the only reasonable choice is 1 then just do it.

	If(SourceCount <= 1 || DestCount <= 1)
		Return 1
	EndIf

	self.Print(Dest.GetDisplayName() + " can fit " + DestCount + " more gems.")
	self.Print(Source.GetDisplayName() + " has " + SourceCount + " " + What.GetName())
	self.Print("How many should be inserted?")

	If(SourceCount < DestCount)
		DestCount = SourceCount
	EndIf

	;; ask the user

	UIExtensions.InitMenu("UITextEntryMenu")
	UIExtensions.SetMenuPropertyString("UITextEntryMenu","text",(DestCount as String))
	UIExtensions.OpenMenu("UITextEntryMenu")
	Output = UIExtensions.GetMenuResultString("UITextEntryMenu") as Int

	Return PapyrusUtil.ClampInt(Output,0,DestCount)
EndFunction

Function ActorActionInseminate(Actor Source, Actor Dest, Form What)
{semen insertion sequence.}

	If(Source.GetItemCount(What) == 0)
		self.Print(Source.GetDisplayName() + " has no semen to use.")
		Return
	EndIf

	If(self.ActorGemGetCount(Dest) >= self.ActorGemGetCapacity(Dest))
		self.Print(Dest.GetDisplayName() + " cannot fit anymore gems.")
		Return
	EndIf

	If(self.ActorNoAnimate(Dest))
		;; short scene
		self.ImmersiveBlush(Dest)
		self.ImmersiveSoundMoan(Dest,FALSE)
		self.ImmersiveExpression(Dest,TRUE)
		Source.RemoveItem(What,1)
		self.ActorGemAdd(Dest,0)
		self.StatBump(None,"Inseminations")
		self.StatBump(Dest,"Inseminations")
		Utility.Wait(1.5)
		self.ImmersiveExpression(Dest,FALSE)
	Else
		;; long scene
		self.BehaviourDefault(Dest)
		self.ActorRemoveChestpiece(Dest)
		self.ImmersiveAnimationInsertion(Dest)
		self.EventSend_OnInseminating(Dest,What)
		Source.RemoveItem(What,1)
		Utility.Wait(3.0)
		self.ImmersiveExpression(Dest,TRUE)
		self.ImmersiveSoundMoan(Dest,FALSE)
		self.ImmersiveBlush(Dest)
		Utility.Wait(3.0)
		self.ActorGemAdd(Dest,0)
		self.StatBump(None,"Inseminations")
		self.StatBump(Dest,"Inseminations")
		self.ImmersiveSoundMoan(Dest)
		Utility.Wait(2.0)
		self.EventSend_OnInseminated(Dest,What)
		self.ImmersiveAnimationIdle(Dest)
		self.ImmersiveExpression(Dest,FALSE)
		self.ActorReplaceChestpiece(Dest)
		self.BehaviourClear(Dest,TRUE)
	EndIf

	Return
EndFunction


;/*****************************************************************************
	__                                    __               __     __   
 |__.--------.--------.-----.----.-----|__.-----.-----._|  |_ _|  |_ 
 |  |        |        |  -__|   _|__ --|  |  _  |     |_    _|_    _|
 |__|__|__|__|__|__|__|_____|__| |_____|__|_____|__|__| |__|   |__|  
	                                                                 
*****************************************************************************/;

;; immersive events

Function Immersive_OnGemFull(Actor Who)
{send messages about gem fullness.}

	If(Who == self.Player && self.OptImmersivePlayer)
		String[] Msg = new String[6]
		Msg[0] = "It feels like all my gems are ready."
		Msg[1] = "I can tell the gems I carry have hit their max potential."
		Msg[2] = "My belly feels like it is about to burst."
		Msg[3] = "Ugh some of these gems have sharp corners."
		Msg[4] = "If I drop my weapon I'm not sure I could bend down to pick it up again!"
		Msg[5] = "Ding! Oven's done."
		self.PrintRandom(Msg)
	EndIf

	Return
EndFunction

Function Immersive_OnGemProgress(Actor Who, Int[] Progress)
{send messages about gem progression.}

	If(Who == self.Player && self.OptImmersivePlayer)
		String[] Msg = new String[3]
		Msg[0] = "You feel another gem has progressed."
		Msg[1] = "You feel a gem has reached the next stage of development."
		Msg[2] = "You can tell a gem got a little bigger than earlier."
		self.PrintRandom(Msg)
	EndIf

	Return
EndFunction

Function Immersive_OnMilkFull(Actor Who)
{send messages about milk being full.}

	If(Who == self.Player && self.OptImmersivePlayer)
		String[] Msg = new String[8]
		Msg[0] = "My breasts are sore and ready to burst."
		Msg[1] = "If my breasts get any fuller they might pop!"
		Msg[2] = "If my breasts get any larger they are going to need their own Jarl."
		Msg[3] = "I bet I could get some great deals flashing these milkshakes around."
		Msg[4] = "My back is sore from supporting these things."
		Msg[5] = "These things are so full they are dribbling milk."
		Msg[6] = "My boobs are so full. I wonder if anyone is thirsty?" ;; chajapa
		Msg[7] = "I think my jugs are full." ;; chajapa
		self.PrintRandom(Msg)
	EndIf

	Return
EndFunction

Function Immersive_OnMilkProgress(Actor Who)
{send messages about milk progression.}

	If(Who == self.Player && self.OptImmersivePlayer)
		String[] Msg = new String[3]
		Msg[0] = "My breasts feel a little heavier."
		Msg[1] = "My breasts have gotten heavier."
		Msg[2] = "Who needs a cow for milk when I've got these puppies." ;; mm777
		self.PrintRandom(Msg)
	EndIf

	Return
EndFunction

Function Immersive_OnSemenFull(Actor Who)
{send messages about milk being full.}

	If(Who == self.Player && self.OptImmersivePlayer)
		String[] Msg = new String[4]
		Msg[0] = "My balls ache from being so full."
		Msg[1] = "My balls are so full it hurts."
		Msg[2] = "My balls are so full I can probably out-cum a dragon." ;; mm777
		Msg[3] = "Sitting may be a bit difficult." ;; Meerkats Dance
		self.PrintRandom(Msg)
	EndIf

	Return
EndFunction

Function Immersive_OnSemenProgress(Actor Who)
{send messages about milk progression.}

	If(Who == self.Player && self.OptImmersivePlayer)
		String[] Msg = new String[2]
		Msg[0] = "My balls feel a little heavier"
		Msg[1] = "I can tell my balls have refilled some."
		self.PrintRandom(Msg)
	EndIf

	Return
EndFunction

;; immersive actions

Function ImmersiveBlush(Actor Who, Float Opacity=1.0, Int FullTime=2, Float FadeTime=2.0)
{provide integration for Blush When Aroused. this will trigger a short blushing
event if installed http://www.loverslab.com/files/file/1724-blush-when-aroused}

	int e = 0

	If(Who != self.Player)
		e = ModEvent.Create("BWA_ForceBlushOn")
	Else
		e = ModEvent.Create("BWA_ForceBlushOnPlr")
	Endif

	If(e == 0)
		self.PrintDebug("Blush Event Failure")
		Return
	EndIf

	If(Who != self.Player)
		ModEvent.PushForm(e,Who as Form)
	EndIf

	ModEvent.PushFloat(e,Opacity)
	ModEvent.PushInt(e,FullTime)
	ModEvent.PushFloat(e,FadeTime)
	ModEvent.PushBool(e,FALSE)
	ModEvent.Send(e)
	Return
EndFunction

Function ImmersiveExpression(Actor Who, Bool Enable)
{play an expression on the actor face.}

	If(Enable)
		sslBaseExpression exp = SexLab.PickExpression(Who)
		exp.Apply(Who,100,1)
	Else
		Who.ClearExpressionOverride()
		MfgConsoleFunc.ResetPhonemeModifier(Who)
	EndIf
EndFunction

Function ImmersiveSheatheWeapon(Actor Who)
{sheathe the weapon and wait if drawn.}

	If(Who.IsWeaponDrawn())
		Who.SheatheWeapon()
		Utility.Wait(3.0)
	EndIf

	Return
EndFunction

Function ImmersiveSoundMoan(Actor Who, Bool Hard=FALSE)
{play a moaning sound from the actor.}

	sslBaseVoice Voice = SexLab.PickVoice(Who)
	Int SoundID = StorageUtil.GetIntValue(Who,"SGO.Actor.Sound.Moan")
	Sound Moan

	If(Hard)
		Moan = Voice.GetSound(100)
	Else
		Moan = Voice.GetSound(30)
	EndIf

	if SoundID > 0
		Sound.StopInstance(SoundID)
	Endif

	StorageUtil.SetIntValue(Who,"SGO.Actor.Sound.Moan",Moan.Play(who))
EndFunction

Function ImmersiveAboutFace(Actor Who)
{spin the actor around 180deg.}

	Who.SetAngle(Who.GetAngleX(),Who.GetAngleY(),(Who.GetAngleZ() + 180.0))
	Return
EndFunction

String Function ImmersiveAnimationBirthing(Actor Who)
{play a birthing animation on the actor. returns the bone it should appear it.}

	If(self.ActorNoAnimate(Who))
		Return ""
	EndIf

	self.ImmersiveSheatheWeapon(Who)

	;;;;;;;;

	;; Ani are the animations we want.
	;; Pre are the animations we have to call before aclling the one we
	;; want. a weird bug introduced into the animations in sexlab 1.6.
	;; animations greater than S1 need to have S1 called before the actual.

	;; cannot compare a string to a none (cast missing or types unrelated)
	;; roflmao.

	String[] Ani = new String[6]
	String[] Pre = new String[6]
	String[] Bon = new String[6]

	Ani[0] = "AP_BedMissionary_A1_S3"
	Pre[0] = "AP_BedMissionary_A1_S1"
	Bon[0] = "SkirtFBone02C"

	Ani[1] = "DoggyStyle_A1_S4"
	Pre[1] = "DoggyStyle_A1_S1"
	Bon[1] = "SkirtBBone02C"

	Ani[2] = "Missionary_A1_S4"
	Pre[2] = "Missionary_A1_S1"
	Bon[2] = "SkirtFBone02C"

	;;Ani[3] = "Zyn_Missionary_A1_S1"
	;;Pre[3] = "----"
	;;Bon[3] = "SkirtFBone02C"

	Ani[3] = "ZaZAPCHorFB"
	Pre[3] = "----"
	Bon[3] = "SkirtBBone02C"

	Ani[4] = "ZaZAPC201"
	Pre[4] = "----"
	Bon[4] = "SkirtBBone02C"

	Ani[5] = "ZaZAPC202"
	Pre[5] = "----"
	Bon[5] = "SkirtBBone02C"

	;;Ani[7] = "ZaZAPC205"
	;;Pre[7] = "----"
	;;Bon[7] = "SkirtBBone02C"

	;;;;;;;;

	Int Which
	ObjectReference Here = Who.PlaceAtMe(self.StaticXMarker)

	If(self.OptAnimationBirthing <= 0)
		Which = Utility.RandomInt(0,(Ani.Length - 1))
	Else
		If(self.OptAnimationBirthing >= Ani.Length)
			;; i shortened the list so handle that.
			self.OptAnimationBirthing = Ani.Length - 1
		EndIf

		Which = self.OptAnimationBirthing - 1
	EndIf

	If(Pre[Which] != "----")
		Debug.SendAnimationEvent(Who,Pre[Which])
	EndIf

	Who.SetVehicle(Here)
	Who.StopTranslation()
	Who.SplineTranslateTo(Here.GetPositionX(),Here.GetPositionY(),Here.GetPositionZ(),Here.GetAngleX(),Here.GetAngleY(),(Here.GetAngleZ() + 1.01),1.0,500,0.001)
	Who.SetVehicle(None)
	Here.Delete()


	Debug.SendAnimationEvent(Who,Ani[Which])
	Return Bon[Which]
EndFunction

Function ImmersiveAnimationIdle(Actor Who, Bool Force=false)
{play the idle animation on an actor.}

	If(!Force && self.ActorNoAnimate(Who))
		Return
	EndIf

	self.ImmersiveSheatheWeapon(Who)

	Who.StopTranslation()
	Debug.SendAnimationEvent(who,"IdleForceDefaultState")

	Return
EndFunction

Function ImmersiveAnimationMilking(Actor Who)
{play the milking animation on an actor.} 

	If(self.ActorNoAnimate(Who))
		Return
	EndIf

	self.ImmersiveSheatheWeapon(Who)
	Debug.SendAnimationEvent(Who,"ZaZAPCHorFC")
	Return
EndFunction

Function ImmersiveAnimationWanking(Actor Who)
{play the milking animation on an actor.} 

	If(self.ActorNoAnimate(Who))
		Return
	EndIf

	self.ImmersiveSheatheWeapon(Who)
	Debug.SendAnimationEvent(Who,"Arrok_MaleMasturbation_A1_S1")
	Debug.SendAnimationEvent(Who,"Arrok_MaleMasturbation_A1_S2")
	Return
EndFunction

Function ImmersiveAnimationInsertion(Actor Who)
{play the insertion animation on an actor.} 

	If(self.ActorNoAnimate(Who))
		Return
	EndIf

	self.ImmersiveSheatheWeapon(Who)
	Debug.SendAnimationEvent(Who,"ZaZAPCHorFA")
	Return
EndFunction

Function ImmersiveErection(Actor Who, Bool Enable)
{give the actor an erection or not.}

	Utility.Wait(0.1)

	If(Enable)
		Debug.SendAnimationEvent(Who, "SOSFastErect")
	Else
		Debug.SendAnimationEvent(Who, "SOSFlaccid")
	EndIf

	Return
EndFunction

Function ImmersiveMenuCamera(Bool Enable)
{move the camera when the menu opens.}

	;; disabling this because apparently i am the only one it is
	;; working for correctly.
	Return

	Int Camera = Game.GetCameraState()
	If(Camera != 5 && Camera != 8 && Camera != 9 && Camera != 10)
		self.PrintDebug("not in third person")
		Return
	EndIf

	Float CurX = Utility.GetINIFloat("fOverShoulderPosX:Camera")
	Float CurZ = Utility.GetINIFloat("fOverShoulderPosZ:Camera")
	Float CurS = Utility.GetINIFLoat("fShoulderDollySpeed:Camera")

	If(Enable)
		StorageUtil.SetFloatValue(None,"SGO.Camera.X",CurX)
		StorageUtil.SetFloatValue(None,"SGO.Camera.Z",CurZ)
		StorageUtil.SetFloatValue(None,"SGO.Camera.S",CurS)
		Utility.SetINIFloat("fOverShoulderPosX:Camera",-50)
		Utility.SetINIFloat("fOverShoulderPosZ:Camera",-40)
		Utility.SetINIFloat("fShoulderDollySpeed:Camera",40)
	Else
		Utility.SetINIFloat("fOverShoulderPosX:Camera",StorageUtil.GetFloatValue(None,"SGO.Camera.X"))
		Utility.SetINIFloat("fOverShoulderPosZ:Camera",StorageUtil.GetFloatValue(None,"SGO.Camera.Z"))
		Utility.SetINIFloat("fShoulderDollySpeed:Camera",StorageUtil.GetFloatValue(None,"SGO.Camera.S"))
		StorageUtil.UnsetFloatValue(None,"SGO.Camera.X")
		StorageUtil.UnsetFloatValue(None,"SGO.Camera.Z")
		StorageUtil.UnsetFloatValue(None,"SGO.Camera.S")
	EndIf

	Game.UpdateThirdPerson()
	Return
EndFunction


;/*****************************************************************************
	                                         __ 
 .--------.-----.-----.--.--.   .---.-.-----|__|
 |        |  -__|     |  |  |   |  _  |  _  |  |
 |__|__|__|_____|__|__|_____|   |___._|   __|__|
	                                  |__|      

*****************************************************************************/;

;; ui extension utility.

Function MenuWheelSetItem(Int Num, String Label, String Text, Bool Enabled=True)
{assign an item to the uiextensions wheel menu.}

	UIExtensions.SetMenuPropertyIndexString("UIWheelMenu","optionLabelText",Num,Label)
	UIExtensions.SetMenuPropertyIndexString("UIWheelMenu","optionText",Num,Text)
	UIExtensions.SetMenuPropertyIndexBool("UIWheelMenu","optionEnabled",Num,Enabled)

	If(!Enabled)
		UIExtensions.SetMenuPropertyIndexInt("UIWheelMenu","optionTextColor",Num,0x555555)
	EndIf

	Return
EndFunction

;; mod menus.

Function MenuMain(Actor Who=None)
{show the main soulgem oven menu.}

	If(Who == None)
		Who = Game.GetCurrentCrosshairRef() as Actor
	EndIf

	If(Who == None)
		Who = self.Player
	EndIf

	If(self.OptValidateActor && !SexLab.IsValidActor(Who))
		self.PrintDebug(Who.GetDisplayName() + " is not SexLab Valid.")
		Return
	EndIf

	self.MenuMain_Construct(Who)
	self.MenuMain_Handle(Who)
	Return
EndFunction

Function MenuMain_Construct(Actor Who)
{construct the menu for the main sgo menu.}

	Int ActorBio = self.ActorGetBiologicalFunctions(Who)

	;;;;;;;;

	Bool ItemBirthEnable = FALSE
	String ItemBirthLabel = "Not Pregnant"
	String ItemBirthText = "Perform Ultrasound."

	If(self.ActorGemGetCount(Who) > 0)
		ItemBirthEnable = TRUE
		ItemBirthLabel = "Gems (" + (self.ActorGemGetCount(Who)) + ", " + (self.ActorGemGetPercent(Who) as Int) + "%)"
	EndIf

	;;;;;;;;

	Bool ItemGemEnable = FALSE
	String ItemGemLabel = "Insert Gem..."
	String ItemGemText = "Insert gems from inventory."
	Int ItemGemCount = PapyrusUtil.AddIntValues(self.ActorGemGetInventory(self.Player))

	If(ItemGemCount > 0)
		ItemGemEnable = TRUE
		ItemGemLabel = "Insert Gem (" + ItemGemCount  + ")..."
	EndIf

	;;;;;;;;

	Bool ItemSemenEnable = FALSE
	String ItemSemenLabel = "Inseminate..."
	String ItemSemenText = "Insert a bottle of semen."
	Int ItemSemenCount = self.Player.GetItemCount(self.dcc_sgo_ListSemenItems)

	If(ItemSemenCount > 0)
		ItemSemenEnable = TRUE
		ItemSemenLabel = "Inseminate (" + ItemSemenCount + ")..."
	EndIf

	;;;;;;;;

	Bool ItemMilkEnable = FALSE
	String ItemMilkLabel = "Not Milkable"
	String ItemMilkText = "Milk it dry."

	If(self.ActorMilkGetWeight(Who) > 0.0)
		ItemMilkEnable = TRUE
		ItemMilkLabel = "Milk (" + (self.ActorMilkGetWeight(Who) as Int) + ", " + (self.ActorMilkGetPercent(Who) as Int) + "%)"
	EndIf

	;;;;;;;;

	Bool ItemWankEnable = FALSE
	String ItemWankLabel = "Not Wankable"
	String ItemWankText = "Wank it dry."

	If(self.ActorSemenGetWeight(Who) > 0.0)
		ItemWankEnable = TRUE
		ItemWankLabel = "Semen (" + (self.ActorSemenGetWeight(Who) as Int) + ", " + (self.ActorSemenGetPercent(Who) as Int) + "%)"
	EndIf

	;;;;;;;;

	Bool ItemTransferEnable = FALSE
	String ItemTransferLabel = "No Target."
	String ItemTransferText  = "Transfer gems from one to another."

	If(Who != self.Player)
		ItemTransferEnable = TRUE
		ItemTransferLabel = "Transfer..."
	EndIf

	;;;;;;;;

	UIExtensions.InitMenu("UIWheelMenu")
	self.MenuWheelSetItem(0,ItemGemLabel,ItemGemText,ItemGemEnable) ;; insert gem
	self.MenuWheelSetItem(1,ItemTransferLabel,ItemTransferText,ItemTransferEnable) ;; transfer gems
	self.MenuWheelSetItem(2,ItemSemenLabel,ItemSemenText,ItemSemenEnable) ;; insert semen
	self.MenuWheelSetItem(3,"Actor Options...","Set advanced options.",TRUE) ;; actor options

	self.MenuWheelSetItem(4,ItemBirthLabel,ItemBirthText,ItemBirthEnable) ;; gem status + birth
	self.MenuWheelSetItem(5,ItemMilkLabel,ItemMilkText,ItemMilkEnable) ;; milk status + milk
	self.MenuWheelSetItem(6,ItemWankLabel,ItemWankText,ItemWankEnable) ;; semen status + wank
	self.MenuWheelSetItem(7,"Actor Stats","Show statistics for this actor.",TRUE) ;; actor stats
	Return
EndFunction

Function MenuMain_Handle(Actor Who)
{handle the choice from the sgo menu.}

	If(self.OptEnableMenuImod)
		self.ImmersiveMenuCamera(TRUE)
		self.dcc_sgo_ImodMenu.Apply(1.0)
		Utility.Wait(0.25)
	EndIf

	Int Result = UIExtensions.OpenMenu("UIWheelMenu",Who)
	self.ImmersiveMenuCamera(FALSE)

	If(Result == 0)
		self.MenuSoulgemInsert(Who)
	ElseIf(Result == 1)
		self.MenuSoulgemTransfer(Who)
	ElseIf(Result == 2)
		self.MenuSemenInsert(Who)
	ElseIf(Result == 3)
		self.MenuActorOptions(Who)
	ElseIf(Result == 4)
		;;self.ActorActionBirth(Who,Who)
		self.MenuSoulgemStatus(Who)
	ElseIf(Result == 5)
		self.ActorActionMilk(Who,Who)
	ElseIf(Result == 6)
		self.ActorActionWank(Who,Who)
	ElseIf(Result == 7)
		self.MenuActorStats(Who)
	EndIf

	Return
EndFunction

Function MenuSoulgemInsert(Actor Who)
{show the soulgem insertion menu system.}

	If(Who == None)
		Who = Game.GetCurrentCrosshairRef() as Actor
	EndIf

	If(Who == None)
		Who = self.Player
	EndIf

	;;;;;;;;

	Int Bio = self.ActorGetBiologicalFunctions(Who)

	If(Math.LogicalAnd(Bio,self.BioProduceGems) == 0)
		self.Print(Who.GetDisplayName() + " cannot produce gems.")
		Return
	EndIf

	self.MenuSoulgemInsert_Construct(Who)
	self.MenuSoulgemInsert_Handle(Who)
	Return
EndFunction

Function MenuSoulgemInsert_Construct(Actor Who)
{construct the soulgem insertion menu}

	UIListMenu Menu = UIExtensions.GetMenu("UIListMenu",TRUE) as UIListMenu
	Form[] List = self.ActorGemListInventory(self.Player)
	Int x = 0
	Int GemCount
	String GemPrefix

	While(x < List.Length)
		GemCount = self.Player.GetItemCount(List[x])
		If(self.dcc_sgo_ListGemEmpty.Find(List[x]) >= 0)
			GemPrefix = "< > "
		ElseIf(self.dcc_sgo_ListGemFull.Find(List[x]) >= 0)
			GemPrefix = "<=> "
		Else
			GemPrefix = ""
		EndIf


		Menu.AddEntryItem(GemPrefix + List[x].GetName() + " (" + GemCount + ")")
		x += 1
	EndWhile

	Menu.AddEntryItem("[<< Main Menu]")
	Return
EndFunction

Function MenuSoulgemInsert_Handle(Actor Who)
{handle the soulgem insertion menu.}

	Form[] List = self.ActorGemListInventory(self.Player)
	Int Result

	If(self.OptEnableMenuImod)
		self.ImmersiveMenuCamera(TRUE)
		self.dcc_sgo_ImodMenu.Apply(1.0)
		Utility.Wait(0.25)
	EndIf

	UIExtensions.OpenMenu("UIListMenu",Who)
	Result = UIExtensions.GetMenuResultInt("UIListMenu")
	self.ImmersiveMenuCamera(FALSE)

	If(Result >= List.Length)
		self.MenuMain(Who)
		
	ElseIf(Result >= 0)	
		self.ActorActionInsert(self.Player,Who,List[Result])
	EndIf

	Return
EndFunction

Function MenuSemenInsert(Actor Who)
{show the insemination menu.}

	If(Who == None)
		Who = Game.GetCurrentCrosshairRef() as Actor
	EndIf

	If(Who == None)
		Who = self.Player
	EndIf

	;;;;;;;;

	Int Bio = self.ActorGetBiologicalFunctions(Who)

	If(Math.LogicalAnd(Bio,self.BioProduceGems) == 0)
		self.Print(Who.GetDisplayName() + " cannot produce gems.")
		Return
	EndIf

	self.MenuSemenInsert_Construct(Who)	
	self.MenuSemenInsert_Handle(Who)
	Return
EndFunction

Function MenuSemenInsert_Construct(Actor Who)
{construct the insemination menu}

	UIListMenu Menu = UIExtensions.GetMenu("UIListMenu",TRUE) as UIListMenu
	Form[] List = self.ActorSemenListInventory(self.Player)
	Int x = 0

	While(x < List.Length)
		Menu.AddEntryItem(List[x].GetName())
		x += 1
	EndWhile

	Menu.AddEntryItem("[<< Main Menu]")
	Return
EndFunction

Function MenuSemenInsert_Handle(Actor Who)
{handle the insemination menu.}
	
	Form[] List = self.ActorSemenListInventory(self.Player)
	Int Result

	If(self.OptEnableMenuImod)
		self.ImmersiveMenuCamera(TRUE)
		self.dcc_sgo_ImodMenu.Apply(1.0)
		Utility.Wait(0.25)
	EndIf

	UIExtensions.OpenMenu("UIListMenu",Who)
	Result = UIExtensions.GetMenuResultInt("UIListMenu")
	self.ImmersiveMenuCamera(FALSE)

	If(Result >= List.Length)
		self.MenuMain(Who)
	Else
		self.ActorActionInseminate(self.Player,Who,List[Result])
	EndIf

	Return
EndFunction

Function MenuActorOptions(Actor Who)
{show the biological feature toggle menu}

	If(Who == None)
		Who = Game.GetCurrentCrosshairRef() as Actor
	EndIf

	If(Who == None)
		Who = self.Player
	EndIf

	self.MenuActorOptions_Construct(Who)
	self.MenuActorOptions_Handle(Who)
	Return
EndFunction

Function MenuActorOptions_Construct(Actor Who)
{construct the actor option menu.}

	Int Bio = self.ActorGetBiologicalFunctions(Who)

	;;;;;;;;

	Bool ItemGemEnable = TRUE
	String ItemGemLabel = "Enable Gems"
	String ItemGemText = "Toggle gem pregnancy on/off."

	If(Math.LogicalAnd(Bio,self.BioProduceGems) == self.BioProduceGems)
		ItemGemLabel = "Disable Gems"
	EndIf

	;;;;;;;;

	Bool ItemMilkEnable = TRUE
	String ItemMilkLabel = "Enable Milk"
	String ItemMilkText = "Toggle milk production on/off."

	If(Math.LogicalAnd(Bio,self.BioProduceMilk) == self.BioProduceMilk)
		ItemMilklabel = "Disable Milk"
	EndIf

	;;;;;;;;

	Bool ItemInseminateEnable = TRUE
	String ItemInseminateLabel = "Enable Inseminate"
	String ItemInseminateText = "Toggle to inseminate others on/off."

	If(Math.LogicalAnd(Bio,self.BioInseminate) == self.BioInseminate)
		ItemInseminateLabel = "Disable Inseminate"
	EndIf

	;;;;;;;;
	;; note to future self.
	;; i know people are going to ask about global disable and then only
	;; enabling one or two. when that happens add global OptNode toggle options
	;; and then treat the disables as enables instead of creating new enable
	;; perks.
	;;;;;;;;

	Bool ItemNodeBreastEnable = TRUE
	String ItemNodeBreastLabel = "Breast Scale ON"
	String ItemNodeBreastText = "Pevent scaling of Breasts."

	If(Who.IsInFaction(self.dcc_sgo_FactionDisableScaleBreast))
		ItemNodeBreastLabel = "Breast Scale OFF"
	EndIf

	;;;;;;;;

	Bool ItemNodeBellyEnable = TRUE
	String ItemNodeBellyLabel = "Belly Scale ON"
	String ItemNodeBellyText = "Pevent scaling of Belly."

	If(Who.IsInFaction(self.dcc_sgo_FactionDisableScaleBelly))
		ItemNodeBellyLabel = "Belly Scale is OFF"
	EndIf

	;;;;;;;;

	Bool ItemNodeTesticleEnable = TRUE
	String ItemNodeTesticleLabel = "Testicle Scale ON"
	String ItemNodeTesticleText = "Pevent scaling of Testicles."

	If(Who.IsInFaction(self.dcc_sgo_FactionDisableScaleTesticle))
		ItemNodeTesticleLabel = "Testicle Scale OFF"
	EndIf

	;;;;;;;;

	UIExtensions.InitMenu("UIWheelMenu")
	self.MenuWheelSetItem(0,ItemGemLabel,ItemGemText,ItemGemEnable)
	self.MenuWheelSetItem(1,ItemMilkLabel,ItemMilkText,ItemMilkEnable)
	self.MenuWheelSetItem(2,ItemInseminateLabel,ItemInseminateText,ItemInseminateEnable)

	self.MenuWheelSetItem(4,ItemNodeBellyLabel,ItemNodeBellyText,ItemNodeBellyEnable)
	self.MenuWheelSetItem(5,ItemNodeBreastLabel,ItemNodeBreastText,ItemNodeBreastEnable)
	self.MenuWheelSetItem(6,ItemNodeTesticleLabel,ItemNodeTesticleText,ItemNodeTesticleEnable)

	self.MenuWheelSetItem(3,"F: " + self.ActorFertilityGetMod(Who) + "x","This actor's fertility modifier.",FALSE)
	self.MenuWheelSetItem(7,"[<< Main Menu]","Back to main menu.",TRUE)

	Return
EndFunction

Function MenuActorOptions_Handle(Actor Who)
{handle the actor option menu.}

	If(self.OptEnableMenuImod)
		self.ImmersiveMenuCamera(TRUE)
		self.dcc_sgo_ImodMenu.Apply(1.0)
		Utility.Wait(0.25)
	EndIf

	Int Result = UIExtensions.OpenMenu("UIWheelMenu",Who)
	self.ImmersiveMenuCamera(FALSE)

	If(Result == 0)
		self.ActorToggleBiologicalFunction(Who,self.BioProduceGems)
	ElseIf(Result == 1)
		self.ActorToggleBiologicalFunction(Who,self.BioProduceMilk)
	ElseIf(Result == 2)
		self.ActorToggleBiologicalFunction(Who,self.BioInseminate)
	ElseIf(Result == 4)
		self.ActorToggleFaction(Who,self.dcc_sgo_FactionDisableScaleBelly)
	ElseIf(Result == 5)
		self.ActorToggleFaction(Who,self.dcc_sgo_FactionDisableScaleBreast)
	ElseIf(Result == 6)
		self.ActorToggleFaction(Who,self.dcc_sgo_FactionDisableScaleTesticle)
	ElseIf(Result == 7)
		self.MenuMain(Who)
	EndIf

	Return
EndFunction

Function MenuSoulgemTransfer(Actor Who)

	If(Who == None)
		Who = Game.GetCurrentCrosshairRef() as Actor
	EndIf

	If(Who == None)
		Who = self.Player
	EndIf

	self.MenuSoulgemTransfer_Construct(Who)
	self.MenuSoulgemTransfer_Handle(Who)
	Return
EndFunction

Function MenuSoulgemTransfer_Construct(Actor Who)

	UIExtensions.InitMenu("UIWheelMenu")
	self.MenuWheelSetItem(2,"Give To...","Give gems to target.",TRUE)
	self.MenuWheelSetItem(6,"Take From...","Take gems from the target.",TRUE)

	Return
EndFunction

Function MenuSoulgemTransfer_Handle(Actor Who)

	If(self.OptEnableMenuImod)
		self.ImmersiveMenuCamera(TRUE)
		self.dcc_sgo_ImodMenu.Apply(1.0)
		Utility.Wait(0.25)
	EndIf

	Int Result = UIExtensions.OpenMenu("UIWheelMenu",Who)
	self.ImmersiveMenuCamera(FALSE)

	If(Result == 2)
		self.ActorActionBirth(self.Player,Who)
	ElseIf(Result == 6)
		self.ActorActionBirth(Who,self.Player)
	EndIf

	Return
EndFunction

Function MenuSoulgemStatus(Actor Who)

	If(Who == None)
		Who = Game.GetCurrentCrosshairRef() as Actor
	EndIf

	If(Who == None)
		Who = self.Player
	EndIf

	self.MenuSoulgemStatus_Construct(Who)
	self.MenuSoulgemStatus_Handle(Who)
	return
EndFunction

Function MenuSoulgemStatus_Construct(Actor Who)

	Int[] States = new Int[7]
	Int Count = self.ActorGemGetCount(Who)
	Int Iter
	Int Current

	Iter = 0
	While(Iter < Count)
		Current = PapyrusUtil.ClampInt((StorageUtil.FloatListGet(Who,"SGO.Actor.Gem.Data",Iter) as Int),0,6)
		States[Current] = States[Current] + 1
		Iter += 1
	EndWhile

	UIExtensions.InitMenu("UIWheelMenu")
	self.MenuWheelSetItem(7,"Induce Labour","Birth the soulgems.",TRUE)

	Iter = 0
	While(Iter < 7)
		self.MenuWheelSetItem(Iter,(States[Iter] + " " + self.GetGemName(Iter)),"",FALSE)
		Iter += 1
	EndWhile

	Return
EndFunction

Function MenuSoulgemStatus_Handle(Actor Who)

	Int Result = UIExtensions.OpenMenu("UIWheelMenu",Who)

	If(Result == 7)
		self.ActorActionBirth(Who,Who)
	EndIf

	Return
EndFunction

Function MenuActorStats(Actor Who)
{show the stats list}

	If(Who == None)
		Who = Game.GetCurrentCrosshairRef() as Actor
	EndIf

	If(Who == None)
		Who = self.Player
	EndIf

	;;;;;;;;

	self.MenuActorStats_Construct(Who)	
	;;self.MenuActorStats_Handle(Who)
	Return
EndFunction

Function MenuActorStats_Construct(Actor Who)
{construct the stats menu}

	UIListMenu Menu = UIExtensions.GetMenu("UIListMenu",TRUE) as UIListMenu
	Form[] List = self.ActorSemenListInventory(self.Player)

	;;Int GemItem = Menu.AddEntryItem("Gems",-1,-1,TRUE)
	;;Int MilkItem = Menu.AddEntryItem("Milk",-1,-1,TRUE)
	;;Int SemenItem = Menu.AddEntryItem("Semen",-1,-1,TRUE)

	Int GemItem = -1
	Int MilkItem = -1;
	Int SemenItem = -1;

	Menu.AddEntryItem("Gems Incubated",GemItem)
	Menu.AddEntryItem(self.StatGetFloat(Who,"GemGrowth"),GemItem)
	Menu.AddEntryItem(" ",GemItem)
	Menu.AddEntryItem("Gems Birthed",GemItem)
	Menu.AddEntryItem(self.StatGetInt(Who,"Gems"),GemItem)
	Menu.AddEntryItem(" ",GemItem)
	Menu.AddEntryItem("Gems Conceived",GemItem)
	Menu.AddEntryItem(self.StatGetInt(Who,"Preg"),GemItem)
	Menu.AddEntryItem(" ",GemItem)
	Menu.AddEntryItem("Gems Inserted",GemItem)
	Menu.AddEntryItem(self.StatGetInt(Who,"Inserts"),GemItem)
	Menu.AddEntryItem(" ",GemItem)
	Menu.AddEntryItem("Gems Inseminated",GemItem)
	Menu.AddEntryItem(self.StatGetInt(Who,"Inseminations"),GemItem)
	Menu.AddEntryItem(" ",GemItem)
	Menu.AddEntryItem("Gems Transferred Out",GemItem)
	Menu.AddEntryItem(self.StatGetInt(Who,"TransfersOut"),GemItem)
	Menu.AddEntryItem(" ",GemItem)
	Menu.AddEntryItem("Gems Transferred In",GemItem)
	Menu.AddEntryItem(self.StatGetInt(Who,"TransfersIn"),GemItem)
	Menu.AddEntryItem(" ",-1)
	Menu.AddEntryItem("Milk Produced",MilkItem)
	Menu.AddEntryItem((self.StatGetFloat(Who,"MilkProduce")*0.25 + " L"),MilkItem)
	Menu.AddEntryItem(" ",MilkItem)
	Menu.AddEntryItem("Milk Milked",MilkItem)
	Menu.AddEntryItem(self.StatGetInt(Who,"Milks") + " (" + (self.StatGetInt(Who,"Milks")*0.25) + " L)",MilkItem)
	Menu.AddEntryItem(" ",-1)
	Menu.AddEntryItem("Semen Produced",SemenItem)
	Menu.AddEntryItem((self.StatGetFloat(Who,"SemenProduce")*0.004) + " L",SemenItem)
	Menu.AddEntryItem(" ",-1)
	Menu.AddEntryItem("Semen Bottled",SemenItem)
	Menu.AddEntryItem(self.StatGetInt(Who,"Semen") + " (" + (self.StatGetInt(Who,"Semen")*0.004) + "L)",SemenItem)

	UIExtensions.OpenMenu("UIListMenu",Who)
	Return
EndFunction
