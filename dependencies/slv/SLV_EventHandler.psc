Scriptname SLV_EventHandler extends Quest  

Actor Property PlayerRef Auto ;points to the player

Function PrepareMod()
;MiscUtil.PrintConsole("Registering events")
RegisterSlaverunEvents()

softDependency.testmode = false
SLV_WeightGain.setvalue(0)
  
myScripts.SLV_CheatMode()

if JsonUtil.GetIntValue("../Slaverun/SlaverunConfig.json", "weightmode" ,0 ) == 1
	softDependency.weightmode = true
	SLV_WeightGain.setvalue(1)
endif
myScripts.SLV_BreastMode()

if Game.GetModByName("PSQ PlayerSuccubusQuest.esm")!= 255
	softDependency.psqsuccubusquest = true
	GlobalVariable isSuccubus = Game.GetFormFromFile(0x000DAF, "PSQ PlayerSuccubusQuest.esm") as GlobalVariable
	if isSuccubus.getValue() > 0
		softDependency.psqissuccubus = true
	else
		softDependency.psqissuccubus = false  
	endif
else
	softDependency.psqsuccubusquest = false  
endif

if SLV_Main.isrunning()
	swapJarls.updateAllJarls()
	amputee.SLV_OnLoadGameIvanaAmputee()
	SLV_You.getActorRef().getActorBase().setName(PlayerRef.getActorBase().getName())
	PlayerRef.addToFaction(SLV_PlayerFaction)
	PlayerRef.ModFactionRank(SLV_PlayerFaction,4)
endif

UnregisterForAllKeys()
UpdateKeyRegistery()

RegisterForCrosshairRef()
EndFunction
SLV_SoftDependency Property softDependency auto
SLV_SwapAllJarls  Property swapJarls Auto
GlobalVariable Property SLV_WeightGain  Auto
SLV_Amputee Property amputee Auto
ReferenceAlias Property SLV_You Auto
Faction Property SLV_PlayerFaction Auto

function UpdateKeyRegistery()
	RegisterForKey(MCMMenu.KeyForNotification)
	;Debug.Trace(self + ": Updated notification key to " + MCMMenu.KeyForNotification)
endFunction

Event OnKeyDown( int keyCode )	
	If (!Utility.IsInMenuMode() && MCMMenu.ShowNotifications == 1 && MCMMenu.KeyForNotification == keyCode)
		myScripts.SLV_Notifications()
	EndIf

	If (crosshairRef != None)
		MCMMenu.selectedActor= crosshairRef
	Else
		MCMMenu.selectedActor = PlayerRef
	EndIf
EndEvent
Actor crosshairRef = None

Event OnCrosshairRefChange(ObjectReference ref)
	crosshairRef = none
	if ref != none
		crosshairRef = ref as Actor
	endIf
EndEvent

Function RegisterSlaverunEvents()
;MiscUtil.PrintConsole("Registering events")
RegisterForModEvent("SlaverunReloaded_ForceSlavetraining", "OnForceSlavetraining")
RegisterForModEvent("SlaverunReloaded_ForceEnslavement", "OnForceEnslavement")
RegisterForModEvent("SlaverunReloaded_EndEnslavement", "OnEndEnslavement")
RegisterForModEvent("SlaverunReloaded_SkipSlaveQuests", "OnSkipSlaveQuests")
RegisterForModEvent("SlaverunReloaded_SkipQuests", "OnSkipQuests")
RegisterForModEvent("SlaverunReloaded_Crawl", "OnForceCrawling")


;MiscUtil.PrintConsole("Registering event SlaverunReloaded_FreeSkyrim")
RegisterForModEvent("SlaverunReloaded_FreeSkyrim", "OnFreeSkyrimFromSlavery")

RegisterForModEvent("SlaverunReloaded_ResetSlavery", "OnResetSlavery")
RegisterForModEvent("SlaverunReloaded_ViolateSlaverLaw", "OnViolateSlaverLaw")
RegisterForModEvent("SlaverunReloaded_EscapedSlave", "OnEscapedSlave")
RegisterForModEvent("SlaverunReloaded_WhippingScream", "OnWhippingScream") ; internal only
RegisterForModEvent("SlaverunReloaded_OrgasmSound", "OnOrgasmSound") ; internal only
RegisterForModEvent("SlaverunReloaded_ManipulateDD", "OnManipulateDD") ; internal only


RegisterForModEvent("xpoPCisFree", "xpoOnPCisFree")
RegisterForModEvent("xpoPCinPrison", "xpoOnPCinPrison")
RegisterForModEvent("xpoSceneStart", "xpoOnSceneStart")
RegisterForModEvent("xpoSceneDone", "xpoOnSceneDone")

RegisterForModEvent("dhlp-Suspend", "dhlpOnSuspend")
RegisterForModEvent("dhlp-Resume", "dhlpOnResume")
EndFunction


Event OnForceCrawling(Form akSender, Form akActor, bool doCrawling)
Actor selectedActor = akActor as Actor
myScripts.SLV_ForceToCrawl(selectedActor, doCrawling)
EndEvent

Event OnManipulateDD(Form akSender, Form akActor, bool equipDD, bool equipGag,bool equipAnalPlug,bool equipVagPlug,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipLegCuffs,bool equipArmCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false, bool equipStraitJacket=false)
MiscUtil.PrintConsole("Event OnManipulateDDreceived")

Actor selectedActor = akActor as Actor

;myScripts.SLV_DisplayInformation("OnManipulateDD gag: " + equipGag);
;myScripts.SLV_DisplayInformation("OnManipulateDD collar: " + equipCollar);
;myScripts.SLV_DisplayInformation("OnManipulateDD suit: " + equipSuit);
;myScripts.SLV_DisplayInformation("OnManipulateDD StraitJacket: " + equipStraitJacket);

; unequip everytime, to requip something new
myScripts.SLV_DeviousUnEquipActor4(selectedActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens, equipHood, equipClamps, equipSuit, equipShackles, equipHobblesSkirt, equipHobblesSkirtRelaxed,equipStraitJacket)
if equipDD
	myScripts.SLV_DeviousEquipActor4(selectedActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens, equipHood, equipClamps, equipSuit, equipShackles, equipHobblesSkirt, equipHobblesSkirtRelaxed,equipStraitJacket)
endif
EndEvent


Event xpoOnSceneStart(String eventname, string strArg, float numArg, Form senderr)
MiscUtil.PrintConsole("Event xpoSceneStart received")
SLV_StopEnforcer.setvalue(1)
EndEvent

Event xpoOnSceneDone(String eventname, string strArg, float numArg, Form sender)
MiscUtil.PrintConsole("Event xpoSceneDone received")
SLV_StopEnforcer.setvalue(0)
EndEvent

Event xpoOnPCisFree(String eventname, string strArg, float numArg, Form senderr)
MiscUtil.PrintConsole("Event xpoOnPCisFree received")
SLV_EnforcerIgnorePC.setvalue(0)
EndEvent

Event xpoOnPCinPrison(String eventname, string strArg, float numArg, Form sender)
MiscUtil.PrintConsole("Event xpoOnPCinPrison received")
SLV_EnforcerIgnorePC.setvalue(1)
EndEvent


Event dhlpOnSuspend(String eventname, string strArg, float numArg, Form sender)
MiscUtil.PrintConsole("Event dhlp-Suspend received")
;StorageUtil.SetIntValue(PlayerRef,"DCUR_SceneRunning",StorageUtil.GetIntValue(PlayerRef,"DCUR_SceneRunning") + 1) 
;MiscUtil.PrintConsole(StorageUtil.GetIntValue(PlayerRef,"DCUR_SceneRunning"))
SLV_StopEnforcer.setvalue(1)
EndEvent

Event dhlpOnResume(String eventname, string strArg, float numArg, Form sender)
MiscUtil.PrintConsole("Event dhlp-Resume received")
;StorageUtil.SetIntValue(PlayerRef,"DCUR_SceneRunning",0)
;MiscUtil.PrintConsole(StorageUtil.GetIntValue(PlayerRef,"DCUR_SceneRunning"))
SLV_StopEnforcer.setvalue(0)
EndEvent



Event OnWhippingScream(String eventname, string strArg, float numArg, Form sender)
;Debug.notification("Event WhippingScream received")
;MiscUtil.PrintConsole("Event WhippingScream received")

StorageUtil.IntListResize(None, "SLSF.BuffersToIncFame.Slaverun.Whipping", 20, 0)    
StorageUtil.IntListSet(None, "SLSF.BuffersToIncFame.Slaverun.Whipping", 10, 1)

Int Id = ModEvent.Create("SLSF_Request_CreateFameModEvent")
If (Id)
	ModEvent.PushString(Id, "SLSF.BuffersToIncFame.Slaverun.Whipping")
	ModEvent.Send(Id)
EndIf

myScripts.SLV_DoWhipping(10)
EndEvent

Event OnOrgasmSound(String eventname, string strArg, float numArg, Form sender)
MiscUtil.PrintConsole("Event OnOrgasmSound received")

myScripts.SLV_DoOrgasm(10)
EndEvent



Event OnFreeSkyrimFromSlavery(String eventname, string strArg, float numArg, Form sender)
MiscUtil.PrintConsole("Event OnFreeSkyrimRecieved")

SLV_FreeSkyrim.Stop()
SLV_FreeSkyrim.Reset()
SLV_FreeSkyrim.Start()
SLV_FreeSkyrim.setstage(0)
SLV_FreeSkyrim.setactive(true)

MiscUtil.PrintConsole("Free Skyrim started")

EndEvent



Event OnForceSlavetraining(String eventname, string strArg, float numArg, Form sender)
MiscUtil.PrintConsole("Event OnForceSlavetraining Recieved")

SLV_Training.Stop()
SLV_Training.Reset()
SLV_Training.Start()
SLV_Training.setstage(10)

Debug.notification("Slave training resetted.")
EndEvent




Event OnSkipSlaveQuests(String eventname, string strArg, float numArg, Form sender)
;If PlayerRef.GetActorBase().GetSex() != 1 ; we don't enslave males
;	Return
;EndIf
SendModEvent("dhlp-Suspend")
Game.getplayer().removeFromfaction(SLV_SlaveFaction)
Game.getplayer().removeFromfaction(SLV_Slave)
Game.getplayer().removeFromfaction(SLV_SlaverFaction)

CheckStartmainquest()

myScripts.SLV_enableBrutus()
myScripts.SLV_enableZaid()
myScripts.SLV_enableMundus()
Utility.wait (2.0)
slaveroutfit.initSlaverSchlongs()

Debug.notification("Your clothes are ripped away.")
myScripts.SLV_SexlabStripNPC(PlayerRef)

myScripts.SLV_enslavement(false) 
myScripts.SLV_enslavementChains(Game.getplayer())

SLV_Main.SetObjectiveCompleted(SLV_Main.GetStage())
SLV_Main.setstage(30000)

SendModEvent("dhlp-Resume")
EndEvent




Event OnSkipQuests(String eventname, string strArg, float numArg, Form sender)
SendModEvent("dhlp-Suspend")

CheckStartmainquest()

myScripts.SLV_enableBrutus()
myScripts.SLV_enableZaid()
myScripts.SLV_enableMundus()
Utility.wait (2.0)
slaveroutfit.initSlaverSchlongs()

SLV_Main.SetObjectiveCompleted(SLV_Main.GetStage())
SLV_Main.setstage(31000)

SendModEvent("dhlp-Resume")
EndEvent




Event OnForceEnslavement(String eventname, string strArg, float numArg, Form sender)
;If PlayerRef.GetActorBase().GetSex() != 1 ; we don't enslave males
;	Return
;EndIf
SendModEvent("dhlp-Suspend")

CheckStartmainquest()

debug.notification("A big man grins evily at you.")
debug.notification("Then you are knocked out.")
Game.FadeOutGame(false, true, 50.0, 1.0)

myScripts.SLV_enableBrutus()
myScripts.SLV_enableZaid()
myScripts.SLV_enableMundus()
myScripts.SLV_SetPlayerIsAVirgin()
cageMarker.enable()

slaveroutfit.initSlaverSchlongs()

if SLV_Main.getstage() < 1000
	slaveroutfit.setSlaverOutfit(0)
endif

PlayerRef.moveto(cageMarker)
zad_BlindfoldLeeches.Apply(0)
zad_BlindfoldModifier.Apply(100)
Game.FadeOutGame(false, true, 0.1, 0.1)


debug.messagebox("When you regain consciousness, you are next to a cage full of naked woman.")
;Utility.wait (3.0)
zad_BlindfoldLeeches.ApplyCrossFade(3)
zad_BlindfoldModifier.Remove()
zad_BlindfoldLeeches.Remove()
;Utility.wait (2.0)


;Debug.notification("Your clothes are ripped away.")
;Sexlab.StripActor(PlayerRef)
;Debug.SendAnimationEvent(PlayerRef, "ZazAPCAO053")

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

Actor player = Game.GetPlayer()

myScripts.SLV_StripBothHands(player)
Armor ankleiron = Game.GetFormFromFile(0x004009, "ZaZAnimationPack.esm") as Armor
player.equipItem(ankleiron)
Armor wristiron = Game.GetFormFromFile(0x001008, "ZaZAnimationPack.esm") as Armor
player.equipItem(wristiron)

; as simple slavery sends them naked, we give em prison rags
Form ArmorOrClothes = player.GetWornForm(Armor.GetMaskForSlot(32))
if !ArmorOrClothes
	Armor prisonrags = Game.GetFormFromFile(0x03C9FE, "Skyrim.esm") as Armor
	player.equipItem(prisonrags)
endif
Form FeetArmor = player.GetWornForm(Armor.GetMaskForSlot(37)) 
if !FeetArmor
	Armor prisonshoes = Game.GetFormFromFile(0x03CA00, "Skyrim.esm") as Armor
	player.equipItem(prisonshoes)
endif

; player is a slave but hasn't been enslaved by slaverun, treat her as a free or slaver
if Game.getplayer().IsInFaction(SLV_SlaveFaction) && (!SLV_EnslavePCQuest.IsRunning())&& (!SLV_EnslavePCQuest.IsCompleted())
	Game.getplayer().RemoveFromFaction(SLV_SlaveFaction)
endif

if SLV_Main.getstage() < 1000 ; player has not been enslaved yet, because whiterun is still free
	SLV_Main.SetObjectiveCompleted(SLV_Main.GetStage())
	SLV_Main.setstage(1000)
	myScripts.SLV_enslavement(false)

	if MCMMenu.SkipScenes
		myScripts.SLV_EnslavePlayer(true,true)
		return
	endif
	EnslaveFreeWomanScene.Start()

elseif SLV_Main.getstage() >= 1000 && Game.getplayer().IsInFaction(SLV_SlaverFaction) ; female slaver
	myScripts.SLV_enslavement(false)
	if MCMMenu.SkipScenes
		myScripts.SLV_EnslavePlayer(true,true)
		return
	endif
	EnslaveSlaverWomanScene.Start()

elseif SLV_Main.getstage() >= 1000 && Game.getplayer().IsInFaction(SLV_SlaveFaction) ; female slave

	int doWalkOfShame = Utility.RandomInt(1,100)		

	if SLV_WalkofShameQuest.IsCompleted() && ! SLV_WalkofShame2Quest.IsRunning() && doWalkOfShame < MCMMenu.walkOfShameProbabilty
		SLV_WalkofShame2Quest.reset()
		SLV_WalkofShame2Quest.start()
		SLV_WalkofShame2Quest.setstage(0)
		SLV_WalkofShame2Quest.setActive()
	else
		RemindScene.Start()
	endif

elseif SLV_Main.getstage() >= 1000 && !(Game.getplayer().IsInFaction(SLV_SlaveFaction) || Game.getplayer().IsInFaction(SLV_SlaverFaction)) ; female is still free
	myScripts.SLV_enslavement(false)
	if MCMMenu.SkipScenes
		myScripts.SLV_EnslavePlayer(true,true)
		return
	endif
	EnslaveFreeWomanScene2.Start()

else ; should not happen at the moment
	SendModEvent("dhlp-Resume")
endif
EndEvent
SLV_SlaverOutfit Property slaveroutfit auto




Event OnEndEnslavement(String eventname, string strArg, float numArg, Form sender)
;Debug.notification("Event OnResetSlavery Recieved") 
SendModEvent("dhlp-Suspend")

CheckStartmainquest()

SLV_Main.setstage(50000)
SLV_Main.CompleteAllObjectives()
SLV_Main.CompleteQuest()

myScripts.SLV_disableMerchantSlaves()
myScripts.SLV_disableBrutus()
myScripts.SLV_disableZaid()
myScripts.SLV_disableMundus()
myScripts.SLV_disableExecution()
myScripts.SLV_disableSlavesOutside()

myScripts.SLV_ResetSlavename(Game.getPlayer())
myScripts.SLV_restoreAllNPCOutfits()
resetQuests()
myScripts.SLV_FreePlayer()
SendModEvent("dhlp-Resume")
EndEvent





Event OnResetSlavery(String eventname, string strArg, float numArg, Form sender)
SendModEvent("dhlp-Suspend")

CheckStartmainquest()

SLV_Main.setstage(50000)
SLV_Main.CompleteAllObjectives()
SLV_Main.CompleteQuest()

Utility.Wait(5.0)
;Debug.notification("Old Mainquest stopped")

SLV_HasFinishedSlaverun.setValue(1)
SLV_Main.Stop()
SLV_Main.Reset()
SLV_Main.Start()
Utility.Wait(3.0)
SLV_Main.SetActive(true)
SLV_Main.setstage(10)

myScripts.SLV_disableMerchantSlaves()
myScripts.SLV_disableBrutus()
myScripts.SLV_disableZaid()
myScripts.SLV_disableMundus()
myScripts.SLV_disableExecution()
myScripts.SLV_disableSlavesOutside()

myScripts.SLV_restoreAllNPCOutfits()
myScripts.SLV_ResetSlavename(Game.getPlayer())

;Debug.notification("SLV WhiterunCiticen:" + SLV_WhiterunCiticen.getvalue())
SLV_Main.ModObjectiveGlobal(-3, SLV_WhiterunCiticen)
SLV_WhiterunCiticen.setvalue(0)
if !SLV_Main.UpdateCurrentInstanceGlobal(SLV_WhiterunCiticen)
  Debug.notification("Failed to update WhiterunCiticen value for quest")
endif
SLV_Main.SetActive(true)
SLV_Main.setstage(10)

Utility.Wait(5.0)
;Debug.notification("New Mainquest started")
resetQuests()
myScripts.SLV_FreePlayer()
SendModEvent("dhlp-Resume")
EndEvent
GlobalVariable Property SLV_HasFinishedSlaverun Auto



Function resetQuests()
if SLV_Training.isRunning() && !SLV_Training.IsCompleted()
	SLV_Training.FailAllObjectives()
	SLV_Training.CompleteQuest()
	;Debug.notification("SLV_Training completed.")
endif

if SLV_WhiterunAvenicci.isRunning() && !SLV_WhiterunAvenicci.IsCompleted()
	SLV_WhiterunAvenicci.FailAllObjectives()
	SLV_WhiterunAvenicci.CompleteQuest()
	;Debug.notification("SLV_WhiterunAvenicci completed.")
endif
if SLV_WhiterunAvenicci.isCompleted()
	SLV_WhiterunAvenicci.Reset()
	;Debug.notification("SLV_WhiterunAvenicci resetted.")
endif

if SLV_WhiterunBelethor.isRunning() && !SLV_WhiterunBelethor.IsCompleted()
	SLV_WhiterunBelethor.FailAllObjectives()
	SLV_WhiterunBelethor.CompleteQuest()
	;Debug.notification("SLV_WhiterunBelethor completed.")
endif
if SLV_WhiterunBelethor.isCompleted()
	SLV_WhiterunBelethor.Reset()
	;Debug.notification("SLV_WhiterunBelethor resetted.")
endif

if SLV_WhiterunDeliverPlugsQuest.isRunning() && !SLV_WhiterunDeliverPlugsQuest.IsCompleted()
	SLV_WhiterunDeliverPlugsQuest.FailAllObjectives()
	SLV_WhiterunDeliverPlugsQuest.CompleteQuest()
	;Debug.notification("SLV_WhiterunDeliverPlugsQuest completed.")
endif

if SLV_WhiterunDeliverSlaveQuest.isRunning() && !SLV_WhiterunDeliverSlaveQuest.IsCompleted()
	SLV_WhiterunDeliverSlaveQuest.FailAllObjectives()
	SLV_WhiterunDeliverSlaveQuest.CompleteQuest()
	;Debug.notification("SLV_WhiterunDeliverSlaveQuest completed.")
endif
if SLV_WhiterunDeliverSlaveQuest.isCompleted()
	SLV_WhiterunDeliverSlaveQuest.Reset()
	;Debug.notification("SLV_WhiterunDeliverSlaveQuest resetted.")
endif

if SLV_WhiterunEarnMoney.isRunning() && !SLV_WhiterunEarnMoney.IsCompleted()
	SLV_WhiterunEarnMoney.FailAllObjectives()
	SLV_WhiterunEarnMoney.CompleteQuest()
endif
if SLV_WhiterunEarnMoney.isCompleted()
	SLV_WhiterunEarnMoney.Reset()
	;Debug.notification("SLV_WhiterunEarnMoneyresetted.")
endif

if SLV_WhiterunEnslave.isRunning() && !SLV_WhiterunEnslave.IsCompleted()
	SLV_WhiterunEnslave.FailAllObjectives()
	SLV_WhiterunEnslave.CompleteQuest()
endif
if SLV_WhiterunEnslave.isCompleted()
	SLV_WhiterunEnslave.Reset()
	;Debug.notification("SLV_WhiterunEnslave resetted.")
endif

if SLV_WhiterunEnslaveMaleQuest.isRunning() && !SLV_WhiterunEnslaveMaleQuest.IsCompleted()
	SLV_WhiterunEnslaveMaleQuest.FailAllObjectives()
	SLV_WhiterunEnslaveMaleQuest.CompleteQuest()
endif
if SLV_WhiterunEnslaveMaleQuest.isCompleted()
	SLV_WhiterunEnslaveMaleQuest.Reset()
	;Debug.notification("SLV_WhiterunEnslaveMaleQuestresetted.")
endif

if SLV_WhiterunFarkas.isRunning() && !SLV_WhiterunFarkas.IsCompleted()
	SLV_WhiterunFarkas.FailAllObjectives()
	SLV_WhiterunFarkas.CompleteQuest()
endif
if SLV_WhiterunFarkas.isCompleted()
	SLV_WhiterunFarkas.Reset()
	;Debug.notification("SLV_WhiterunFarkasresetted.")
endif
if SLV_WhiterunFreeFuck.isRunning() && !SLV_WhiterunFreeFuck.IsCompleted()
	SLV_WhiterunFreeFuck.FailAllObjectives()
	SLV_WhiterunFreeFuck.CompleteQuest()
endif
if SLV_WhiterunFreeFuck.isCompleted()
	SLV_WhiterunFreeFuck.Reset()
	;Debug.notification("SLV_WhiterunFreeFuck resetted.")
endif

if SLV_WhiterunFuckWoman.isRunning() && !SLV_WhiterunFuckWoman.IsCompleted()
	SLV_WhiterunFuckWoman.FailAllObjectives()
	SLV_WhiterunFuckWoman.CompleteQuest()
endif
if SLV_WhiterunFuckWoman.isCompleted()
	SLV_WhiterunFuckWoman.Reset()
	;Debug.notification("SLV_WhiterunFuckWoman resetted.")
endif

if SLV_WhiterunJessicaQuest.isRunning() && !SLV_WhiterunJessicaQuest.IsCompleted()
	SLV_WhiterunJessicaQuest.FailAllObjectives()
	SLV_WhiterunJessicaQuest.CompleteQuest()
endif
if SLV_WhiterunJessicaQuest.isCompleted()
	SLV_WhiterunJessicaQuest.Reset()
	;Debug.notification("SLV_WhiterunJessicaQuest resetted.")
endif

if SLV_WhiterunPissPotQuest.isRunning() && !SLV_WhiterunPissPotQuest.IsCompleted()
	SLV_WhiterunPissPotQuest.FailAllObjectives()
	SLV_WhiterunPissPotQuest.CompleteQuest()
endif
if SLV_WhiterunPissPotQuest.isCompleted()
	SLV_WhiterunPissPotQuest.Reset()
	;Debug.notification("SLV_WhiterunPissPotQuest resetted.")
endif

if SLV_WhiterunPussyLickerQuest.isRunning() && !SLV_WhiterunPussyLickerQuest.IsCompleted()
	SLV_WhiterunPussyLickerQuest.FailAllObjectives()
	SLV_WhiterunPussyLickerQuest.CompleteQuest()
endif
if SLV_WhiterunPussyLickerQuest.isCompleted()
	SLV_WhiterunPussyLickerQuest.Reset()
	;Debug.notification("SLV_WhiterunPussyLickerQuest resetted.")
endif

if SLV_WhiterunTrainWomanQuest.isRunning() && !SLV_WhiterunTrainWomanQuest.IsCompleted()
	SLV_WhiterunTrainWomanQuest.FailAllObjectives()
	SLV_WhiterunTrainWomanQuest.CompleteQuest()
endif
if SLV_WhiterunTrainWomanQuest.isCompleted()
	SLV_WhiterunTrainWomanQuest.Reset()
	;Debug.notification("SLV_WhiterunTrainWomanQuest resetted.")
endif

if SLV_StillFreeQuest.isRunning()  && !SLV_StillFreeQuest.IsCompleted()
	SLV_StillFreeQuest.FailAllObjectives() 
	SLV_StillFreeQuest.CompleteQuest()
endif

if SLV_RiverwoodSlaveryQuest.isRunning() && !SLV_RiverwoodSlaveryQuest.IsCompleted()
	SLV_RiverwoodSlaveryQuest.FailAllObjectives()
	SLV_RiverwoodSlaveryQuest.CompleteQuest()
endif
if SLV_RiverwoodTaskAlvorQuest.isRunning() && !SLV_RiverwoodTaskAlvorQuest.IsCompleted()
	SLV_RiverwoodTaskAlvorQuest.FailAllObjectives()
	SLV_RiverwoodTaskAlvorQuest.CompleteQuest()
endif
if SLV_RiverwoodTaskLucanQuest.isRunning() && !SLV_RiverwoodTaskLucanQuest.IsCompleted()
	SLV_RiverwoodTaskLucanQuest.FailAllObjectives()
	SLV_RiverwoodTaskLucanQuest.CompleteQuest()
endif
if SLV_RiverwoodTaskSvenQuest.isRunning() && !SLV_RiverwoodTaskSvenQuest.IsCompleted()
	SLV_RiverwoodTaskSvenQuest.FailAllObjectives()
	SLV_RiverwoodTaskSvenQuest.CompleteQuest()
endif

if SLV_MainSpecial1.isRunning() && !SLV_MainSpecial1.IsCompleted()
	SLV_MainSpecial1.FailAllObjectives()
	SLV_MainSpecial1.CompleteQuest()
endif
if SLV_MainSpecial2.isRunning() && !SLV_MainSpecial2.IsCompleted()
	SLV_MainSpecial2.FailAllObjectives()
	SLV_MainSpecial2.CompleteQuest()
endif
if SLV_MainSpecial3.isRunning() && !SLV_MainSpecial3.IsCompleted()
	SLV_MainSpecial3.FailAllObjectives()
	SLV_MainSpecial3.CompleteQuest()
endif
if SLV_MainSpecial4.isRunning() && !SLV_MainSpecial4.IsCompleted()
	SLV_MainSpecial4.FailAllObjectives()
	SLV_MainSpecial4.CompleteQuest()
endif
if SLV_MainSpecial5.isRunning() && !SLV_MainSpecial5.IsCompleted()
	SLV_MainSpecial5.FailAllObjectives()
	SLV_MainSpecial5.CompleteQuest()
endif
if SLV_MainSpecial6.isRunning() && !SLV_MainSpecial6.IsCompleted()
	SLV_MainSpecial6.FailAllObjectives()
	SLV_MainSpecial6.CompleteQuest()
endif
if SLV_MainSpecial7.isRunning() && !SLV_MainSpecial7.IsCompleted()
	SLV_MainSpecial7.FailAllObjectives()
	SLV_MainSpecial7.CompleteQuest()
endif
if SLV_MainSpecial8.isRunning() && !SLV_MainSpecial8.IsCompleted()
	SLV_MainSpecial8.FailAllObjectives()
	SLV_MainSpecial8.CompleteQuest()
endif
if SLV_MainSpecial9.isRunning() && !SLV_MainSpecial9.IsCompleted()
	SLV_MainSpecial9.FailAllObjectives()
	SLV_MainSpecial9.CompleteQuest()
endif
if SLV_MainSpecial10.isRunning() && !SLV_MainSpecial10.IsCompleted()
	SLV_MainSpecial10.FailAllObjectives()
	SLV_MainSpecial10.CompleteQuest()
endif


if SLV_FalkreathSlaveryQuest.isRunning() && !SLV_FalkreathSlaveryQuest.IsCompleted()
	SLV_FalkreathSlaveryQuest.FailAllObjectives()
	SLV_FalkreathSlaveryQuest.CompleteQuest()
endif
if SLV_FalkreathTaskLodQuest.isRunning() && !SLV_FalkreathTaskLodQuest.IsCompleted()
	SLV_FalkreathTaskLodQuest.FailAllObjectives()
	SLV_FalkreathTaskLodQuest.CompleteQuest()
endif
if SLV_FalkreathTaskSolafQuest.isRunning() && !SLV_FalkreathTaskSolafQuest.IsCompleted()
	SLV_FalkreathTaskSolafQuest.FailAllObjectives()
	SLV_FalkreathTaskSolafQuest.CompleteQuest()
endif
if SLV_FalkreathTaskValgaQuest.isRunning() && !SLV_FalkreathTaskValgaQuest.IsCompleted()
	SLV_FalkreathTaskValgaQuest.FailAllObjectives()
	SLV_FalkreathTaskValgaQuest.CompleteQuest()
endif

if SLV_DawnstarSlaveryQuest.isRunning() && !SLV_DawnstarSlaveryQuest.IsCompleted()
	SLV_DawnstarSlaveryQuest.FailAllObjectives()
	SLV_DawnstarSlaveryQuest.CompleteQuest()
endif
if SLV_DawnstarMiningSlaveQuest.isRunning() && !SLV_DawnstarMiningSlaveQuest.IsCompleted()
	SLV_DawnstarMiningSlaveQuest.FailAllObjectives()
	SLV_DawnstarMiningSlaveQuest.CompleteQuest()
endif
if SLV_DawnstarSailerSlutQuest.isRunning() && !SLV_DawnstarSailerSlutQuest.IsCompleted()
	SLV_DawnstarSailerSlutQuest.FailAllObjectives()
	SLV_DawnstarSailerSlutQuest.CompleteQuest()
endif


if SLV_MarkarthSlaveryQuest.isRunning() && !SLV_MarkarthSlaveryQuest.IsCompleted()
	SLV_MarkarthSlaveryQuest.FailAllObjectives()
	SLV_MarkarthSlaveryQuest.CompleteQuest()
endif
if SLV_MarkarthDibellaSlavesQuest.isRunning() && !SLV_MarkarthDibellaSlavesQuest.IsCompleted()
	SLV_MarkarthDibellaSlavesQuest.FailAllObjectives()
	SLV_MarkarthDibellaSlavesQuest.CompleteQuest()
endif
if SLV_MarkarthOrcSmithQuest.isRunning() && !SLV_MarkarthOrcSmithQuest.IsCompleted()
	SLV_MarkarthOrcSmithQuest.FailAllObjectives()
	SLV_MarkarthOrcSmithQuest.CompleteQuest()
endif


if SLV_RiftenSlaveryQuest.isRunning() && !SLV_RiftenSlaveryQuest.IsCompleted()
	SLV_RiftenSlaveryQuest.FailAllObjectives()
	SLV_RiftenSlaveryQuest.CompleteQuest()
endif
if SLV_RiftenHoneybrewViagrixQuest.isRunning() && !SLV_RiftenHoneybrewViagrixQuest.IsCompleted()
	SLV_RiftenHoneybrewViagrixQuest.FailAllObjectives()
	SLV_RiftenHoneybrewViagrixQuest.CompleteQuest()
endif
if SLV_RiftenJailRapeQuest.isRunning() && !SLV_RiftenJailRapeQuest.IsCompleted()
	SLV_RiftenJailRapeQuest.FailAllObjectives()
	SLV_RiftenJailRapeQuest.CompleteQuest()
endif

if SLV_MorthalSlaveryQuest.isRunning() && !SLV_MorthalSlaveryQuest.IsCompleted()
	SLV_MorthalSlaveryQuest.FailAllObjectives()
	SLV_MorthalSlaveryQuest.CompleteQuest()
endif
if SLV_MorthalVampireStudyQuest.isRunning() && !SLV_MorthalVampireStudyQuest.IsCompleted()
	SLV_MorthalVampireStudyQuest.FailAllObjectives()
	SLV_MorthalVampireStudyQuest.CompleteQuest()
endif

if SLV_WinterholdSlaveryQuest.isRunning() && !SLV_WinterholdSlaveryQuest.IsCompleted()
	SLV_WinterholdSlaveryQuest.FailAllObjectives()
	SLV_WinterholdSlaveryQuest.CompleteQuest()
endif
if SLV_WinterholdCrazyAltmerQuest.isRunning() && !SLV_WinterholdCrazyAltmerQuest.IsCompleted()
	SLV_WinterholdCrazyAltmerQuest.FailAllObjectives()
	SLV_WinterholdCrazyAltmerQuest.CompleteQuest()
endif
if SLV_WinterholdChastityBeltsQuest.isRunning() && !SLV_WinterholdChastityBeltsQuest.IsCompleted()
	SLV_WinterholdChastityBeltsQuest.FailAllObjectives()
	SLV_WinterholdChastityBeltsQuest.CompleteQuest()
endif

if SLV_WindhelmSlaveryQuest.isRunning() && !SLV_WindhelmSlaveryQuest.IsCompleted()
	SLV_WindhelmSlaveryQuest.FailAllObjectives()
	SLV_WindhelmSlaveryQuest.CompleteQuest()
endif
if SLV_WindhelmJobSearchQuest.isRunning() && !SLV_WindhelmJobSearchQuest.IsCompleted()
	SLV_WindhelmJobSearchQuest.FailAllObjectives()
	SLV_WindhelmJobSearchQuest.CompleteQuest()
endif
if SLV_WindhelmRacismQuest.isRunning() && !SLV_WindhelmRacismQuest.IsCompleted()
	SLV_WindhelmRacismQuest.FailAllObjectives()
	SLV_WindhelmRacismQuest.CompleteQuest()
endif
 
if SLV_SolitudeSlaveryQuest.isRunning() && !SLV_SolitudeSlaveryQuest.IsCompleted()
	SLV_SolitudeSlaveryQuest.FailAllObjectives()
	SLV_SolitudeSlaveryQuest.CompleteQuest()
endif
if SLV_SolitudeBardsCollegeQuest.isRunning() && !SLV_SolitudeBardsCollegeQuest.IsCompleted()
	SLV_SolitudeBardsCollegeQuest.FailAllObjectives()
	SLV_SolitudeBardsCollegeQuest.CompleteQuest()
endif
if SLV_SolitudeFashionDaysQuest.isRunning() && !SLV_SolitudeFashionDaysQuest.IsCompleted()
	SLV_SolitudeFashionDaysQuest.FailAllObjectives()
	SLV_SolitudeFashionDaysQuest.CompleteQuest()
endif

if SLV_Abolitionism.isRunning() && !SLV_Abolitionism.IsCompleted()
	SLV_Abolitionism.FailAllObjectives()
	SLV_Abolitionism.CompleteQuest()
endif
EndFunction

Function CheckStartmainquest()

if SLV_Main.isrunning()
	return
endif

SLV_Main.reset()
SLV_Main.start()
SLV_Main.setstage(0)
EndFunction



;Event OnViolateSlaverLaw(String eventname, string strArg, float numArg, Form sender)
Event OnViolateSlaverLaw(Form sender)
Actor NPCActor= sender as Actor
Debug.notification(NPCActor.GetLeveledActorBase().getName() + " rips your clothes off for violating the slaverun laws.")

myScripts.SLV_SexlabStripNPC(Game.GetPlayer())
myScripts.SLV_StripBothHands(Game.GetPlayer())

int numberOfOptions = 0
if MCMMenu.NudityCrime
	numberOfOptions = numberOfOptions +1
endif
if MCMMenu.NudityEnslavement
	numberOfOptions = numberOfOptions +1
endif
if MCMMenu.NudityPunishment
	numberOfOptions = numberOfOptions +1
endif
if MCMMenu.NudityRescue
	numberOfOptions = numberOfOptions +1
endif
if numberOfOptions == 0
	return
endif
int violate = Utility.RandomInt(1,numberOfOptions)

if MCMMenu.NudityCrime 
	if violate == 1
		CrimeFactionWhiterun.ModCrimeGold(MCMMenu.NudityCrimeAmount,true)
		Debug.notification("The bounty on your head increased")
		return
	else
		violate = violate - 1
	endif
endif

if MCMMenu.NudityEnslavement
	if violate == 1
		if SLV_Main.getstage() >= 1000 && !Game.getplayer().IsInfaction(SLV_SlaveFaction) && !Game.getplayer().IsInfaction(SLV_SlaverFaction)
			SLV_PunishmentRunning.setValue(1)
			enslaver.ForceRefTo(NPCActor)
		else
			Debug.notification("Some slavers knock you down.")
			sendModEvent("SlaverunReloaded_ForceEnslavement")
		endif
		return
	else
		violate = violate - 1
	endif
endif

if MCMMenu.NudityPunishment
	if violate == 1
		SLV_PunishmentRunning.setValue(1)
		punisher.ForceRefTo(NPCActor)	
		return
	else
		violate = violate - 1
	endif
endif

if MCMMenu.NudityRescue
	if violate == 1
		SLV_PunishmentRunning.setValue(1)
		rescueer.ForceRefTo(NPCActor)	
		return
	else
		violate = violate - 1
	endif
endif
EndEvent


Event OnEscapedSlave(Form sender)
SendModEvent("dhlp-Suspend")

Actor NPCActor=sender as Actor
Debug.notification(NPCActor.GetLeveledActorBase().getName() + " binds you and knocks you out.")
SLV_EscapedSlave.setValue(0)
myScripts.SLV_SexlabStripNPC(Game.GetPlayer())
myScripts.SLV_StripBothHands(Game.GetPlayer())

Utility.wait(3.0)

cageMarker.enable()

PlayerRef.moveto(cageMarker)
zad_BlindfoldLeeches.Apply(0)
zad_BlindfoldModifier.Apply(100)
;Game.FadeOutGame(false, true, 5.0, 5.0)
debug.messagebox("When you regain consciousness, you are back in Dragonsreach next to a cage full of naked woman.")
Utility.wait (3.0)
zad_BlindfoldLeeches.ApplyCrossFade(3)
zad_BlindfoldModifier.Remove()
zad_BlindfoldLeeches.Remove()
Utility.wait (3.0)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

myScripts.SLV_removeitems(Game.GetPlayer())
myScripts.SLV_StripBothHands(Game.GetPlayer())
periodicReporting.StartPeriodicReportingTimer()

int doWalkOfShame = Utility.RandomInt(1,100)		

if SLV_WalkofShameQuest.IsCompleted() && !SLV_WalkofShame2Quest.IsRunning() && SLV_StoryMode.getValue() == 1 && doWalkOfShame < MCMMenu.walkOfShameProbabilty
	SLV_WalkofShame2Quest.reset()
	SLV_WalkofShame2Quest.start()
	SLV_WalkofShame2Quest.setstage(0)
	SLV_WalkofShame2Quest.setActive()
else
	EscapedSlaveScene.Start()
endif
EndEvent
SLV_PeriodicReporting Property periodicReporting Auto
Quest Property SLV_WalkofShameQuest Auto
Quest Property SLV_WalkofShame2Quest Auto
GlobalVariable Property SLV_StoryMode Auto 


Faction Property CrimeFactionWhiterun auto
Faction Property SLV_SlaveFaction auto
Faction Property SLV_Slave auto
Faction Property SLV_SlaverFaction auto

Quest Property SLV_EnslavePCQuest Auto 
Quest Property SLV_Training Auto 
Quest Property SLV_Main Auto 
Quest Property SLV_MainSpecial1 Auto 
Quest Property SLV_MainSpecial2 Auto 
Quest Property SLV_MainSpecial3 Auto 
Quest Property SLV_MainSpecial4 Auto 
Quest Property SLV_MainSpecial5 Auto 
Quest Property SLV_MainSpecial6 Auto 
Quest Property SLV_MainSpecial7 Auto 
Quest Property SLV_MainSpecial8 Auto 
Quest Property SLV_MainSpecial9 Auto 
Quest Property SLV_MainSpecial10 Auto 

Quest Property SLV_Abolitionism Auto

Quest Property SLV_DawnstarSlaveryQuest Auto 
Quest Property SLV_DawnstarMiningSlaveQuest Auto 
Quest Property SLV_DawnstarSailerSlutQuest Auto 

Quest Property SLV_FalkreathSlaveryQuest Auto 
Quest Property SLV_FalkreathTaskLodQuest Auto 
Quest Property SLV_FalkreathTaskSolafQuest Auto 
Quest Property SLV_FalkreathTaskValgaQuest Auto 

Quest Property SLV_MarkarthDibellaSlavesQuest Auto 
Quest Property SLV_MarkarthOrcSmithQuest Auto 
Quest Property SLV_MarkarthSlaveryQuest Auto 

Quest Property SLV_MorthalSlaveryQuest Auto 
Quest Property SLV_MorthalVampireStudyQuest Auto 

Quest Property SLV_RiftenSlaveryQuest Auto 
Quest Property SLV_RiftenHoneybrewViagrixQuest Auto 
Quest Property SLV_RiftenJailRapeQuest Auto 

Quest Property SLV_RiverwoodSlaveryQuest Auto 
Quest Property SLV_RiverwoodTaskAlvorQuest Auto  
Quest Property SLV_RiverwoodTaskLucanQuest Auto 
Quest Property SLV_RiverwoodTaskSvenQuest Auto 

Quest Property SLV_SolitudeSlaveryQuest Auto 
Quest Property SLV_SolitudeBardsCollegeQuest Auto 
Quest Property SLV_SolitudeFashionDaysQuest Auto 

Quest Property SLV_StillFreeQuest Auto 

Quest Property SLV_WhiterunAvenicci Auto 
Quest Property SLV_WhiterunBelethor Auto 
Quest Property SLV_WhiterunDeliverPlugsQuest Auto 
Quest Property SLV_WhiterunDeliverSlaveQuest Auto 
Quest Property SLV_WhiterunEarnMoney Auto 
Quest Property SLV_WhiterunEnslave Auto 
Quest Property SLV_WhiterunEnslaveMaleQuest Auto 
Quest Property SLV_WhiterunFarkas Auto 
Quest Property SLV_WhiterunFreeFuck Auto 
Quest Property SLV_WhiterunFuckWoman Auto 
Quest Property SLV_WhiterunJessicaQuest Auto 
Quest Property SLV_WhiterunPissPotQuest Auto
Quest Property SLV_WhiterunPussyLickerQuest Auto 
Quest Property SLV_WhiterunTrainWomanQuest Auto 

Quest Property SLV_WindhelmSlaveryQuest Auto 
Quest Property SLV_WindhelmJobSearchQuest Auto 
Quest Property SLV_WindhelmRacismQuest Auto 

Quest Property SLV_WinterholdSlaveryQuest Auto 
Quest Property SLV_WinterholdCrazyAltmerQuest Auto 
Quest Property SLV_WinterholdChastityBeltsQuest Auto 

SLV_Utilities Property myScripts auto
SLV_MCMMenu Property MCMMenu Auto
ObjectReference Property cageMarker Auto

Scene Property EnslaveFreeWomanScene Auto
Scene Property EnslaveFreeWomanScene2 Auto
Scene Property EnslaveSlaverWomanScene Auto
Scene Property PunishScene Auto
Scene Property RemindScene Auto
Scene Property EscapedSlaveScene Auto

ImagespaceModifier Property zad_BlindfoldModifier Auto
ImagespaceModifier Property zad_BlindfoldLeeches Auto

 
GlobalVariable Property SLV_WhiterunTask  Auto 
GlobalVariable Property SLV_WhiterunCiticen  Auto  
GlobalVariable Property SLV_PunishmentRunning  Auto  
GlobalVariable Property SLV_EscapedSlave  Auto    
GlobalVariable Property SLV_StopEnforcer  Auto  
GlobalVariable Property SLV_EnforcerIgnorePC  Auto  

ReferenceAlias Property punisher  Auto  
ReferenceAlias Property rescueer  Auto  
ReferenceAlias Property enslaver  Auto  

Quest Property SLV_FreeSkyrim Auto 
