Scriptname SLV_PeriodicCheck extends ReferenceAlias

Quest Property SlaverunDialogueQuest Auto
Quest Property SLV_SlaveCertification1Quest Auto
Quest Property SLV_EnforcerSexQuest Auto
Quest Property SLV_FindSlaverPatrolQuest Auto
SLV_EnforcerLocationCheck Property locationCheck Auto
SLV_MCMMenu Property MCMMenu Auto
SLV_LocationEnslaveCheck Property enslavequest auto
SLV_Utilities Property myScripts auto 
SLV_EnforcerSexStart Property enforcerSex auto 
SLV_FindSlaverPatrol Property findPatrol auto
SLV_Arousal Property arousal auto
SLV_Sexlab Property SLV_Sex Auto

zadLibs Property libs Auto
SexLabFramework Property SexLab Auto

Actor Property PlayerRef Auto
GlobalVariable Property SLV_ForcePeriodicCheck Auto 
GlobalVariable Property SexForEnslavement Auto
GlobalVariable Property SLV_EnforcerRunning Auto
GlobalVariable Property SLV_SlaveOnTheRun Auto
GlobalVariable Property SLV_StopEnforcer Auto
GlobalVariable Property SLV_EnforcerIgnorePC Auto
GlobalVariable Property SLV_FollowerSlaves Auto
GlobalVariable Property SLV_FollowerNonSlaves Auto
GlobalVariable Property SLV_FollowerMales Auto
GlobalVariable Property SLV_ForceSlaverPatrol Auto
GlobalVariable Property SLV_IsLocationEnslaved Auto

int SexToCheck = 1
int SexCounter = 0
int SlaveGuardsCounter = 0

Keyword Property ActorTypeNPC auto
Keyword Property ActorTypeCreature auto
Keyword Property ActorTypeAnimal auto
Keyword Property ArmorJewelry auto
Keyword Property SexlabNoStrip auto
Keyword Property ArmorClothing auto
Keyword Property ArmorCuirass auto
Keyword Property ClothingBody auto
Keyword Property ClothingPoor auto
Keyword Property ClothingRich auto
Keyword Property ArmorHelmet auto

Faction Property sla_Arousal Auto
Faction Property SLV_NoEnforcerFaction auto
Faction Property SlaverunSlaveFaction auto
Faction Property SLV_Slave auto
Faction Property SlaverunSlaverFaction auto
Faction Property CrimeFactionWhiterun auto
Faction Property SlaveMasterFaction auto
Faction Property SLV_StrippedNPC auto
Faction Property CurrentFollowerFaction auto

Race Property ElderRace auto
Race Property ElderRaceVampire auto

Outfit Property SlaveRunFreeFemaleOutfit auto
Outfit Property SlaveOutfit auto
Outfit Property SlaveRunFreeMaleOutfit auto
Outfit Property SlaveMaleOutfit auto

Bool PlayerIsCompliant = true
Bool PlayerIsReported = false

Float DistanceToPlayer = 0.0
Float DistanceToNearestFemale = 200000.0   ; Way further than needed
Float MaxDistanceToSlave = 1500.0

Bool PlayerIsInAWhiterunLocation = false
Bool PlayerIsANudeSubject = false

WorldSpace PlayerCurrentWorld = none
String PlayerCurrentWorldName = ""
Location PlayerCurrentLocation = none
String PlayerCurrentLocationName = ""
Cell PlayerCell = None
Float LastRealTime = 0.0
actor[] gangbangsexActors
int gangbangcount = 0
Bool gangbang = false
int enforcerLocationCheck = 0



Event OnPlayerLoadGame()
Utility.Wait(5.0)
SLV_StopEnforcer.setvalue(0)
UnRegisterForUpdate()   ; Remove any pending events since we are going to create a new one if we need one 
FollowerCheck()
	
SlaveGuardCheck()
PlayerLocationCheck()
RegisterForSingleUpdate(MCMMenu.CheckInterval as Float) ; This uses a MCM menu selection for the interval
EndEvent

;Event OnLocationChange(Location akOldLoc, Location akNewLoc)
;Utility.Wait(2.0)

;UnRegisterForUpdate()   ; Remove any pending events since we are going to create a new one if we need one
;FollowerCheck()
;PlayerLocationCheck()
;RegisterForSingleUpdate(MCMMenu.CheckInterval as Float) ; This uses a MCM menu selection for the interval
;endEvent


Event OnLocationChange(Location akOldLoc, Location akNewLoc)
amputee.SLV_OnLoadGameIvanaAmputee()
endEvent
SLV_Amputee Property amputee Auto


Event onUpdate()
;Utility.Wait(2.0)
myScripts.SLV_DisplayInformation("onUpdate")
UnRegisterForUpdate()   ; Remove any pending events since we are going to create a new one if we need one

FollowerCheck()
	
; some other mod freed our player?
if PlayerRef.IsInFaction(SLV_Slave) && !PlayerRef.IsInFaction(SlaverunSlaveFaction)
	PlayerRef.AddToFaction(SlaverunSlaveFaction)
endif
	
SlaveGuardCheck()

; Because it seems the OnLocationChange event doesn't fire when passing through the Whiterun gate we need another check here!
if PlayerCurrentLocation != PlayerRef.GetCurrentLocation() || PlayerCurrentWorld != PlayerRef.GetWorldSpace() || PlayerIsInAWhiterunLocation ||  SLV_ForcePeriodicCheck.GetValue() == 1
	;amputee.SLV_OnLoadGameIvanaAmputee()
	PlayerLocationCheck()
else
	myScripts.SLV_DisplayInformation("No Locationchange")
endif
RegisterForSingleUpdate(MCMMenu.CheckInterval as Float) ; This uses a MCM menu selection for the interval
EndEvent
ReferenceAlias Property SLV_You Auto


Function FollowerCheck()
if !MCMMenu.EnforcerEnabled
	myScripts.SLV_DisplayDebug2("Enforcer is disabled")
	return ; if disabled we do nothing
endif

if !MCMMenu.FollowerScan
	return
endif

SLV_FindFollowersScript findFollowers = (SLV_FindFollower as SLV_FindFollowersScript)
MCMMenu.followersCount = findFollowers.getFollowers()
myScripts.SLV_DisplayDebug2("followersCount:" + MCMMenu.followersCount)
int i=0
int slaves=0
int nonslaves=0
int males=0
	
MCMMenu.followers = new Actor[5]
MCMMenu.slavefollower = MCMMenu.followers[0]
MCMMenu.nonslavefollower = MCMMenu.followers[0]
MCMMenu.malefollower = MCMMenu.followers[0]
if MCMMenu.followersCount > 0
	While (i < MCMMenu.followersCount)
		Actor follower = findFollowers.followers[i]
		MCMMenu.followers[i] = follower
		myScripts.SLV_DisplayDebug2("Follower:" + follower.GetLeveledActorBase().getName())
		if follower.getactorbase().getSex() == 1  ;female
			if (follower.IsInFaction(SlaverunSlaveFaction))
				slaves = slaves + 1
				MCMMenu.slavefollower = follower
			else
				nonslaves = nonslaves + 1
				MCMMenu.nonslavefollower = follower
			endif
		else
			MCMMenu.malefollower = follower
			males = males + 1
		endif
		i = i + 1
	endWhile	
endif
SLV_FollowerSlaves.setValue(slaves)
SLV_FollowerNonSlaves.setValue(nonslaves)
SLV_FollowerMales.setValue(males)
endFunction
Quest Property SLV_FindFollower Auto


Bool Function FightingCheck()
if !MCMMenu.EnforcerEnabled
	myScripts.SLV_DisplayDebug2("Enforcer is disabled")
	return false; if disabled we do nothing
endif

if !MCMMenu.CombatPausesEnforcer
	return false
endif

SLV_FindFightersScript findFighters = (SLV_FindFighter as SLV_FindFightersScript)
int fighterCount = findFighters.getFighters()
myScripts.SLV_DisplayDebug2("FighterCount:" + fighterCount)
int i=0
	
if fighterCount > 0
	While (i < fighterCount)
		Actor fighter = findFighters.fighters[i]
		myScripts.SLV_DisplayDebug2("Fighter:" + fighter.GetLeveledActorBase().getName())
		i = i + 1
	endWhile	
	return true
endif
return false
endFunction
Quest Property SLV_FindFighter Auto


Function PlayerLocationCheck()
int isRunning = SLV_EnforcerRunning.getValue() as Int
if isRunning > 0 
	myScripts.SLV_DisplayInformation("Second enforcer call aborted")
	SLV_EnforcerRunning.setValue(0)
	return;
endif
if !MCMMenu.EnforcerEnabled
	myScripts.SLV_DisplayDebug2("Enforcer is disabled")
	return ; if disabled we do nothing
endif
myScripts.SLV_Displaydebug1("StopEnforcer:" + SLV_StopEnforcer.getValue())
if  SLV_StopEnforcer.getValue() > 0
	myScripts.SLV_DisplayDebug2("Enforcer is disabled from outside (event)")
	return ; if disabled we do nothing
endif

SLV_EnforcerRunning.setValue(1)
SexToCheck = SexForEnslavement.GetValue() as Int
SLV_ForcePeriodicCheck.SetValue(0)
PlayerIsReported = false

PlayerCurrentWorld = PlayerRef.GetWorldSpace()
if PlayerCurrentWorld == None 
	PlayerCurrentWorldName = "None"
else
	PlayerCurrentWorldName = PlayerCurrentWorld.GetName()
endif
PlayerCurrentLocation = PlayerRef.GetCurrentLocation()
if PlayerCurrentLocation == None 
	PlayerCurrentLocationName ="None"
else
	PlayerCurrentLocationName = PlayerCurrentLocation.GetName()
endif
int mainqueststage = SlaverunDialogueQuest.GetStage()

enforcerLocationCheck = locationCheck.PlayerIsInAEnforcedLocation()
bool isEnforceLocation = false
if enforcerLocationCheck > 0
	isEnforceLocation = true
endif
Cell currentCell = PlayerRef.GetParentCell()

myScripts.SLV_DisplayInformation("Location = " + PlayerCurrentLocationName + " Worldspace = " + PlayerCurrentWorldName + " mainquest=" + mainqueststage + " enforced=" + isEnforceLocation)
if isEnforceLocation 
	if !PlayerIsInAWhiterunLocation && mainqueststage  >= 1000
		myScripts.SLV_DisplayUser("This location is subject to Whiterun's nudity law")
		enslavequest.isLocationEnslaved = true
		SLV_IsLocationEnslaved.setValue(1)
		HandleFemalePlayer()
	endif
	
	PlayerIsInAWhiterunLocation = true
	if PlayerRef.IsInFaction(SlaverunSlaveFaction)
		;if MCMMenu.forceToCrawlInteriorOnly
		;	if currentCell.IsInterior()
		;		myScripts.SLV_ForceToCrawl(PlayerRef, true)
		;	else
		;		myScripts.SLV_ForceToCrawl(PlayerRef, false)
		;	endif
		;else
		;	myScripts.SLV_ForceToCrawl(PlayerRef, true)
		;endif
	
		StorageUtil.SetIntValue(None, "SLSF.PeriodicFameGain.PC.Submissive/Slave", 1)
	endif
	PeriodicCheck()
else
	if PlayerIsInAWhiterunLocation && mainqueststage  >= 1000 
		myScripts.SLV_DisplayUser("This location is free from Whiterun's nudity law")
		enslavequest.isLocationEnslaved = false
		SLV_IsLocationEnslaved.setValue(0)
		myScripts.SLV_ForceToCrawl(PlayerRef, false)
	endif
	PlayerIsInAWhiterunLocation = false
	LastRealTime = 0.0
	StorageUtil.SetIntValue(None, "SLSF.PeriodicFameGain.PC.Submissive/Slave", 0)
endif

if isEnforceLocation && PlayerRef.IsInFaction(SlaverunSlaveFaction) && MCMMenu.enforcerForceToCrawl
	if MCMMenu.forceToCrawlInteriorOnly
		if currentCell.IsInterior()
			myScripts.SLV_ForceToCrawl(PlayerRef, true)
		else
			myScripts.SLV_ForceToCrawl(PlayerRef, false)
		endif
	else
		myScripts.SLV_ForceToCrawl(PlayerRef, true)
	endif
else
	myScripts.SLV_ForceToCrawl(PlayerRef, false)
endif
	
SLV_EnforcerRunning.setValue(0)
EndFunction


Function SlaveGuardCheck()
if !MCMMenu.EnforcerEnabled
	myScripts.SLV_DisplayDebug2("Enforcer is disabled")
	return ; if disabled we do nothing
endif

if locationCheck.SLV_IsWhiterunFree() || !MCMMenu.SlaveGuardsForceGreet
	return
endIf

myScripts.SLV_DisplayDebug1("SlaveGuardCheck")
String reporttext = "not set"
Float reportdate = StorageUtil.GetFloatValue(None, "SLV_SlaveGuardHours", 0.0 )
myScripts.SLV_DisplayDebug1("Guard forcegreat: " + reportdate)
Float currentdate = Utility.GetCurrentGameTime()
	
Float Time = currentdate - reportdate
myScripts.SLV_DisplayDebug1("Time passed since last forcegreet:" + Time)
Int Std = Math.Floor(Time)
myScripts.SLV_DisplayDebug1("Std (=days): " + Std)
Time = Time - Std
;Time = ((Time / 5)*3)
Int IntTime = Math.Floor(Time*24.0)
;Time = Time + "d" + " " + Std * "h"
myScripts.SLV_DisplayDebug1("IntTime (=hours):" + IntTime)
Int hours = IntTime + 24*Std
myScripts.SLV_DisplayDebug1("hours: " + hours)

if hours >= MCMMenu.SlaveGuardsCheckInterval
	myScripts.SLV_DisplayDebug1("Starting SLV_ForceSlaverPatrol")
	reporttext = Std + "d " + IntTime + "h"
	myScripts.SLV_DisplayDebug1("reporttext: " + reporttext)

	Time = Utility.GetCurrentGameTime()
	
	SLV_ForceSlaverPatrol.setValue(1)
	
	if SLV_FindSlaverPatrolQuest.IsRunning()
		SLV_FindSlaverPatrolQuest.Setstage(1000)
	endif
	SLV_FindSlaverPatrolQuest.Reset()
	SLV_FindSlaverPatrolQuest.Start()
	SLV_FindSlaverPatrolQuest.Setstage(0)
	if findPatrol.Alias_SlaverPatrol
		StorageUtil.SetFloatValue(None, "SLV_SlaveGuardHours", Time )
	endif
else
	SlaveGuardsCounter = SlaveGuardsCounter + 1
	
	myScripts.SLV_DisplayDebug1("SlaveGuardCheck: wait for next cycle")
	if SLV_FindSlaverPatrolQuest.IsRunning() 
		if !findPatrol.Alias_SlaverPatrol
			myScripts.SLV_DisplayDebug1("FindSlaverPatrol: check restart timout")
			reportdate = StorageUtil.GetFloatValue(None, "SLV_SlaveGuardHours", 0.0 )
			currentdate = Utility.GetCurrentGameTime()
			Time = currentdate - reportdate
			myScripts.SLV_DisplayDebug1("Check Restart time > 2: " + Time)
			if (time > 2)
				myScripts.SLV_DisplayDebug1("FindSlaverPatrol: restarting")
				SLV_FindSlaverPatrolQuest.Setstage(1000)
				SLV_FindSlaverPatrolQuest.Reset()
				SLV_FindSlaverPatrolQuest.Start()
				SLV_FindSlaverPatrolQuest.Setstage(0)
			endif
		elseif SlaveGuardsCounter > 5
			SlaveGuardsCounter = 0
			myScripts.SLV_DisplayDebug1("FindSlaverPatrol: restarting by counter")
			SLV_FindSlaverPatrolQuest.Setstage(1000)
			SLV_FindSlaverPatrolQuest.Reset()
			SLV_FindSlaverPatrolQuest.Start()
			SLV_FindSlaverPatrolQuest.Setstage(0)
		else 
			myScripts.SLV_DisplayDebug1("FindSlaverPatrol: restart counter: " + SlaveGuardsCounter )
		endif
	else
		myScripts.SLV_DisplayDebug1("FindSlaverPatrol is not running")
	endif
endif
EndFunction


Function PeriodicCheck()
Float NewRealTime = Utility.GetCurrentRealTime()
Float ActualInterval = 	NewRealTime - LastRealTime
If LastRealTime != 0.0 
	MCMMenu.TotalCheckIntervals += ActualInterval
	MCMMenu.TotalChecksPerformed += 1
endif
LastRealTime = NewRealTime

if !MCMMenu.EnforcerEnabled || SlaverunDialogueQuest.GetStage() >= 50000 || SlaverunDialogueQuest.GetStage() < 1000
	return
endif
	
if isPlayerInDialogue(PlayerRef)
	return
endif
	
if PlayerRef.GetCurrentScene() != None
	myScripts.SLV_DisplayDebug2("PC is in a scene")
	return;
endIf
	
if  MCMMenu.CombatPausesEnforcer
	PlayerRef.GetCombatState()
	myScripts.SLV_DisplayDebug2("Combat State:" + PlayerRef.GetCombatState())
	if PlayerRef.GetCombatState() > 0
		myScripts.SLV_DisplayInformation("Enforcer is disabled because the PC fights")
		return ; if disabled we do nothing
	endIf
		
	if FightingCheck()
		myScripts.SLV_DisplayInformation("Enforcer is disabled because an NPC fights")
		return;
	endif
endif
	
gangbangsexActors = new actor[4]
gangbangcount = 0
gangbang = false

PlayerCell = PlayerRef.GetParentCell()
int NPCMax = playerCell.getNumRefs(43)	; Not zero based, is actual count

int NPCIndex = 0
SexCounter = 0

myScripts.SLV_DisplayInformation("--------Periodic Checking " + NPCMax + " NPCs")
;NPCMax -= 1 ; Last entry is always None otherwise
	
while (NPCIndex < NPCMax)
	Actor NPCActor
	if NPCIndex > PlayerRef.GetParentCell().getNumRefs(43)
		myScripts.SLV_Displaydebug1("--------Periodic Checking aborted: " + NPCIndex + " of " + PlayerRef.GetParentCell().getNumRefs(43))
		return
	endif

	if !playerCell
		return
	endIf
	if playerCell != PlayerRef.GetParentCell()
		return
	endIf

		
	if playerCell.getNthRef(NPCIndex, 43)
		NPCActor = playerCell.getNthRef(NPCIndex, 43) as Actor
	endif
	ActorBase NPCActorBase
	Race NPCRace
	if NPCActor
	   	NPCActorBase = NPCActor.GetLeveledActorBase()  ; Only get leveled base if NPC exists, no Papyrus log errors this way
		NPCRace = NPCActorBase.GetRace()
		myScripts.SLV_DisplayDebug1("NPC=" + NPCActorBase.GetName() + " Index=" + NPCIndex + " Sex=" + NPCActorBase.GetSex() + " Race=" + NPCRace.GetName())
	EndIf
	If IsActorAvailable(NPCActor, NPCActorBase, NPCRace)
		 HandleNPCActorInCell(NPCActor, NPCActorBase, NPCRace)
	endif
	NPCIndex += 1
endWhile
	
if gangbang && SLV_StopEnforcer.getValue() == 0
	Actor[] sexActors
	if gangbangsexActors[2]
		sexActors = new actor[5]
		myScripts.SLV_DisplayDebug1("5 actors for gangbang")	
	elseif gangbangsexActors[1]
		sexActors = new actor[4]
		myScripts.SLV_DisplayDebug1("4 actors for gangbang")
	elseif gangbangsexActors[0]
		sexActors = new actor[3]
		myScripts.SLV_DisplayDebug1("3 actors for gangbang")
	else
		sexActors = new actor[2]
		myScripts.SLV_DisplayDebug1("2 actors for gangbang")
	endif
	sexActors[0] = PlayerRef
	sexActors[1] = gangbangsexActors[3]
	if gangbangsexActors[0]
		sexActors[2] = gangbangsexActors[0]
		myScripts.SLV_DisplayUser(gangbangsexActors[0].GetActorBase().GetName() + " joins to gangbang the slave " + PlayerRef.GetActorBase().GetName())
	endif
	if gangbangsexActors[1]
		sexActors[3] = gangbangsexActors[1]
		myScripts.SLV_DisplayUser(gangbangsexActors[1].GetActorBase().GetName() + " joins to gangbang the slave " + PlayerRef.GetActorBase().GetName())
	endif
	if gangbangsexActors[2]
		sexActors[4] = gangbangsexActors[2]
		myScripts.SLV_DisplayUser(gangbangsexActors[2].GetActorBase().GetName() + " joins to gangbang the slave " + PlayerRef.GetActorBase().GetName())
	endif

	int playscene = Utility.RandomInt(1,100)		
	if MCMMenu.EnforcerSexScenes && playscene <= MCMMenu.enforcerSexSceneProbabilty && sexActors.length > 4
		;SLV_EnforcerSexQuest.Stop()
		SLV_EnforcerSexQuest.Reset()
		SLV_EnforcerSexQuest.Start()
		SLV_EnforcerSexQuest.Setstage(0)
		enforcerSex.SLV_EnforcerGangbangRape(sexActors)
	else
		myScripts.SLV_Gangbang(sexActors)
	endif
endif
endFunction


Function HandleNPCActorInCell(Actor NPCActor, ActorBase NPCActorBase, Race NPCRace)
; Here we handle women and the men, women who are not the player or a follower will get automatically stripped if wearing clothing while
; men will be checked for their arousal and will get to fuck any available slave if aroused and may rape any naked female he sees if  
; his arousal is high enough and no slave is available. 
; Men will also report any crime of young females wearing clothing or with equipped weapons or spells if they see any
; so the player and followers will get in trouble unless they are naked.
myScripts.SLV_IncreaseSlaveFameSpecificNpc(NPCActor)
if NPCActorBase && NPCActorBase.GetSex() == SexToCheck; We have a female, time to check her clothing status
	if !(MCMMenu.EnableUndressing)
		return
	endif

	;all slots disabled?
	if !(MCMMenu.EnableUndressSlot30 || MCMMenu.EnableUndressSlot32 ||  MCMMenu.EnableUndressSlot46 ||  MCMMenu.EnableUndressSlot49 ||  MCMMenu.EnableUndressSlot52 ||  MCMMenu.EnableUndressSlot56 ||  MCMMenu.EnableUndressLeftHand ||  MCMMenu.EnableUndressRightHand)
		return
	endif

	if NPCActor != PlayerRef ;  Make sure we are not dealing with the player, she can't get in trouble if we take her clothes away
		If NPCActor.IsPlayerTeammate()|| NPCActor.IsInFaction(CurrentFollowerFaction)
			; We have a follower, right now there is no code for handling followers but we'll call a code stub anyway to make it easy to script any ideas for handling followers
			;
			HandleFemaleFollower(NPCActor, NPCActorBase, NPCRace)
		else
			; We have a NPC, call the code that checks if she's properly undressed and fix her clothing if she's wearing anything that covers her formerly private bits
			; This is preferable to creating patch mods for mods that add NPCs since this gets all NPCs
			HandleFemaleNPC(NPCActor, NPCActorBase, NPCRace)
		endif
	else
		; This is the player, we'll set a flag for if she is compliant with the law or not so she can be ratted out by men who see her 
		HandleFemalePlayer()
	endif
else	
	; Male NPC, Follower or player
	if NPCActor.IsPlayerTeammate() || NPCActor.IsInFaction(CurrentFollowerFaction)
		; Male player teammate, no specific code right now, this function will just call the normal male NPC code until we decide to handle followers differently from other male NPCs
		; Having male followers chasing a female player may be hard on the players pussy because when they get horny enough she may always be close enough to fuck
		HandleMaleFollower(NPCActor, NPCActorBase, NPCRace)
	else
		; Male NPC (not a follower)
		HandleMaleNPC(NPCActor, NPCActorBase, NPCRace)
	endif
endif
endFunction

Function HandleFemaleFollower(Actor NPCActor, ActorBase NPCActorBase, Race NPCRace)
	; How to handle followers, female followers that is.  Strip em?  Dismiss em?  Enslave them too?  
	; For now we'll just strip them by calling the default FemaleNPC function but only if the Player has been
	; told about AND accepted the nudity laws
	;if PlayerIsANudeSubject
if IsPlayerANudeSubject()
	HandleFemaleNPC(NPCActor, NPCActorBase, NPCRace)
	if MCMMenu.FemaleFollowersMimicPlayer && SlaverunDialogueQuest.GetStage() >= 1000 && !NPCActor.IsInFaction(SlaverunSlaveFaction)  && PlayerRef.IsInFaction(SlaverunSlaveFaction)
		myScripts.SLV_DisplayUser("Follower " + NPCActorBase.GetName() + " is now a slave")
		myScripts.SLV_SexlabStripNPC(NPCActor)
		myScripts.SLV_removeitems(NPCActor)
		myScripts.SLV_enslavementNPC(NPCActor)
	endif
endif
EndFunction

Function HandleFemaleNPC(Actor NPCActor, ActorBase NPCActorBase, Race NPCRace)
if (NPCRace == ElderRace || NPCRace == ElderRaceVampire) && MCMMenu.SkipOldPeople
	return; 	Not looking for old women
endif
if  NPCActor == None|| NPCActorBase== None
	return; No character
endif
if NPCActor.IsInFaction(SlaveMasterFaction)
	return; don't strip SlaveMasters
endif
if NPCActor.IsInFaction(SlaverunSlaverFaction) && !MCMMenu.enforcerForSlavers
	return; don't strip Slavers
endif

Form ArmorOrClothes = NPCActor.GetWornForm(Armor.GetMaskForSlot(32)) 
Form TitsOuterGarment = NPCActor.GetWornForm(Armor.GetMaskForSlot(46))
Form TitsUnderGarment = NPCActor.GetWornForm(Armor.GetMaskForSlot(56))
Form PussyOuterGarment = NPCActor.GetWornForm(Armor.GetMaskForSlot(49)) 
Form PussyUnderGarment = NPCActor.GetWornForm(Armor.GetMaskForSlot(52)) 
Form Helmet = NPCActor.GetWornForm(Armor.GetMaskForSlot(30))  
Form Hair = NPCActor.GetWornForm(Armor.GetMaskForSlot(31)) 
;Form FeetArmor = NPCActor.GetWornForm(Armor.GetMaskForSlot(37)) 
;Form HandArmor = NPCActor.GetWornForm(Armor.GetMaskForSlot(33)) 
;Form BracerArmor = NPCActor.GetWornForm(Armor.GetMaskForSlot(34)) 
Form LeftHand = NPCActor.GetEquippedObject(0)
Form RightHand = NPCActor.GetEquippedObject(1)
Bool Strippeditem = false
Bool MakeNPCIntoSlave = false
myScripts.SLV_DisplayDebug2("HandleFemaleNPC Checking " + NPCActorBase.GetName())
if ArmorOrClothes && MCMMenu.EnableUndressSlot32
	myScripts.SLV_DisplayDebug2("HandleFemaleNPC Checking slot32 ")
	Bool StripedThisArmor = StripThisArmor(ArmorOrClothes, NPCActor, NPCActorBase, MakeNPCIntoSlave)
	StrippedItem = StrippedItem || StripedThisArmor
endif
if TitsOuterGarment  && MCMMenu.EnableUndressSlot46
	myScripts.SLV_DisplayDebug2("HandleFemaleNPC Checking slot46 ")
	Bool StripedThisArmor =  StripThisArmor(TitsOuterGarment, NPCActor, NPCActorBase, MakeNPCIntoSlave)
	StrippedItem = StrippedItem || StripedThisArmor
endif
if TitsUnderGarment && MCMMenu.EnableUndressSlot56
	myScripts.SLV_DisplayDebug2("HandleFemaleNPC Checking slot56 ")
	Bool StripedThisArmor = StripThisArmor(TitsUnderGarment, NPCActor, NPCActorBase, MakeNPCIntoSlave)
	StrippedItem = StrippedItem || StripedThisArmor
endif
if PussyOuterGarment && MCMMenu.EnableUndressSlot49
	myScripts.SLV_DisplayDebug2("HandleFemaleNPC Checking slot49 ")
	Bool StripedThisArmor = StripThisArmor(PussyOuterGarment, NPCActor, NPCActorBase, MakeNPCIntoSlave)
	StrippedItem = StrippedItem || StripedThisArmor
endif
if PussyUnderGarment && MCMMenu.EnableUndressSlot52
	myScripts.SLV_DisplayDebug2("HandleFemaleNPC Checking slot52 ")
	Bool StripedThisArmor = StripThisArmor(PussyUnderGarment, NPCActor, NPCActorBase, MakeNPCIntoSlave)
	StrippedItem = StrippedItem || StripedThisArmor
endif
if Helmet && MCMMenu.EnableUndressSlot30
	myScripts.SLV_DisplayDebug2("HandleFemaleNPC Checking slot30 ")
	Bool StripedThisArmor = StripThisArmor(Helmet, NPCActor, NPCActorBase, MakeNPCIntoSlave)
	StrippedItem = StrippedItem || StripedThisArmor
endif
if Hair && MCMMenu.EnableUndressSlot30
	myScripts.SLV_DisplayDebug2("HandleFemaleNPC Checking slot31 ")
	Bool StripedThisArmor = StripThisArmor(Hair, NPCActor, NPCActorBase, MakeNPCIntoSlave)
	StrippedItem = StrippedItem || StripedThisArmor
endif
If LeftHand && MCMMenu.EnableUndressLeftHand
	myScripts.SLV_DisplayDebug2("HandleFemaleNPC Checking slot0 ")
	Bool StripedThisArmor = StripThisHand(LeftHand, NPCActor, NPCActorBase)
	StrippedItem = StrippedItem || StripedThisArmor
endif
If RightHand && MCMMenu.EnableUndressRightHand
	myScripts.SLV_DisplayDebug2("HandleFemaleNPC Checking slot1 ")
	Bool StripedThisArmor = StripThisHand(RightHand, NPCActor, NPCActorBase)
	StrippedItem = StrippedItem || StripedThisArmor
endif
; Here we change the NPCs default outfit so they should no longer equip clothes that cover their best bits.  A future enhancement might be to allow
; a NPC menu to select sexy wear for multiple outfits and then randomly select one of those outfits to replace this bare bones set of ugly shoes outfit
if MakeNPCIntoSlave
	NPCActor.AddToFaction(SlaverunSlaveFaction)
endif
if StrippedItem && !(NPCActor.IsPlayerTeammate() || NPCActor.IsInFaction(CurrentFollowerFaction))
	if NPCActor.IsInFaction(SlaverunSlaveFaction) && !MCMMenu.OutfitNPCSlave
		return
	endif
	if !NPCActor.IsInFaction(SlaverunSlaveFaction) && !MCMMenu.OutfitNPCFree
		return
	endif
	if MCMMenu.SkipDevices
		return
	endif
		
	MCMMenu.FemaleNPCsStripped+= 1
	NPCActor.AddToFaction(SLV_StrippedNPC)

	myScripts.SLV_changeOutfitNPCForZone(NPCActor, enforcerLocationCheck)
	if NPCActor.IsInFaction(SlaverunSlaveFaction)   ; Set appropriate outfit
		;if NPCActorBase.GetSex() == 0
       			;NPCActor.SetOutfit(SlaveOutfit)
		;else
       			;NPCActor.SetOutfit(SlaveMaleOutfit)
		;endif
		myScripts.SLV_setNPCSlaveOutfit(NPCActor)
	else
		;if NPCActorBase.GetSex() == 1
			;NPCActor.SetOutfit(SlaveRunFreeFemaleOutfit)
		;else
			;NPCActor.SetOutfit(SlaveRunFreeMaleOutfit)
		;endif
		myScripts.SLV_setNPCFreeOutfit(NPCActor)
	endif
endif
EndFunction

Bool Function StripThisArmor(Form ItemToStrip, Actor NPCActor, ActorBase NPCActorBase, Bool MakeNPCIntoSlave)
; Means testing, NPCs wearing "poor people's clothing" will automatically be enslaved.  If they have a mix of poor and 
; rich clothing which ever gets tested last will mark their status.  Either way they get to say goodbye to the clothing.
if ItemToStrip.HasKeyword(ClothingPoor)
	MakeNPCIntoSlave = true
endif
if ItemToStrip.HasKeyword(ClothingRich)
	MakeNPCIntoSlave = false
endif
	
myScripts.SLV_DisplayDebug2("Test for Stripping " + ItemToStrip.GetName() + " from " + NPCActorBase.GetName())
if ItemToStrip.HasKeyword(ArmorCuirass) || ItemToStrip.HasKeyword(ArmorClothing) || ItemToStrip.HasKeyword(ClothingBody) || ItemToStrip.HasKeyword(ArmorHelmet)
	myScripts.SLV_DisplayDebug2("Stripping " + ItemToStrip.GetName() + " from " + NPCActorBase.GetName())
	NPCActor.UnEquipItem(ItemToStrip, True, True)
	;NPCActor.addItem(ItemToStrip)
	return true
else 
	return false
endif
EndFunction

Function StripThisHand(Form ItemToStrip,Actor NPCActor, ActorBase NPCActorBase)
myScripts.SLV_DisplayDebug2("Stripping " + ItemToStrip.GetName() + " from " + NPCActorBase.GetName())
NPCActor.UnEquipItem(ItemToStrip, True, True)
;NPCActor.addItem(ItemToStrip)
;NPCActor.RemoveItem(ItemToStrip, 1, True, None)  ; Remove it so they won't re-equip it
EndFunction


Function HandleFemalePlayerFrostfall()
if Game.GetModByName("Frostfall.esp") != 255
	;The player did something that should make them warmer, but not below "Cold".
	FrostUtil.ModPlayerExposure(-40.0, 40.0)
	myScripts.SLV_DisplayInformation("Frostfall exposure raised")
endif
EndFunction

;
; 	For female players who don't object to going naked or being enslaved we will set a flag to mark
;	the player as compliant with the law or not.  That flag can then be used for the male player checks
;	to decide on how they'll handle a compliant or non-compliant female.
;

Bool Function IsPlayerANudeSubject()
if PlayerRef.GetLeveledActorBase().GetSex() != SexToCheck  ;|| PlayerRef.IsInFaction(SlaveMasterFaction) || PlayerRef.IsInFaction(SlaverunSlaverFaction)
	return false
endif
if SlaverunDialogueQuest.GetStage() >= 1000	; Only check if player has been informed of and accepted that law 
	return true
endIf
return false
EndFunction


Function HandleFemalePlayer()
if PlayerRef.GetLeveledActorBase().GetSex() != SexToCheck  || PlayerRef.IsInFaction(SlaveMasterFaction)
	return
endif
if PlayerRef.IsInFaction(SlaverunSlaverFaction) && ! MCMMenu.enforcerForSlavers
	return
endif

HandleFemalePlayerFrostfall()

Bool PreviouslyCompliant = PlayerIsCompliant ; Save previous setting for comparison later
Bool NudityCompliant = true
Bool ArmedOrSpellsCompliant = true
PlayerIsCompliant = true ;  Default to true, change to false if the situation warrants
Form ArmorOrClothese = None

Form ArmorOrClothes = None
Form TitsOuterGarment = None
Form TitsUnderGarment = None
Form PussyOuterGarment = None
Form PussyUnderGarment = None
Form Helmet = None
if MCMMenu.EnableUndressSlot32
	ArmorOrClothes = PlayerRef.GetWornForm(Armor.GetMaskForSlot(32))
endif
if MCMMenu.EnableUndressSlot46
	TitsOuterGarment = PlayerRef.GetWornForm(Armor.GetMaskForSlot(46))
endif
if MCMMenu.EnableUndressSlot56
	TitsUnderGarment = PlayerRef.GetWornForm(Armor.GetMaskForSlot(56))
endif
if MCMMenu.EnableUndressSlot49
	PussyOuterGarment = PlayerRef.GetWornForm(Armor.GetMaskForSlot(49))
endif 
if MCMMenu.EnableUndressSlot52
	PussyUnderGarment = PlayerRef.GetWornForm(Armor.GetMaskForSlot(52))
endif 
if MCMMenu.EnableUndressSlot30
	Helmet = PlayerRef.GetWornForm(Armor.GetMaskForSlot(30)) 
endif
Int LeftHand = PlayerRef.GetEquippedItemType(0)
Int RightHand = PlayerRef.GetEquippedItemType(1)
if SlaverunDialogueQuest.GetStage() >= 1000	; Only check if player has been informed of and accepted that law 
	PlayerIsANudeSubject = true
	if CheckThisArmor(ArmorOrClothes)  || CheckThisArmor(TitsOuterGarment) || CheckThisArmor(TitsUnderGarment) || CheckThisArmor(PussyOuterGarment) || CheckThisArmor(PussyUnderGarment) || CheckThisArmor(Helmet)
		PlayerIsCompliant = false
		NudityCompliant = false
	endif
	; 9 = Magic, now allowed as nowbody sees it or?
	if (LeftHand != 0 && LeftHand != 9 && LeftHand != 11 && MCMMenu.EnableUndressLeftHand) || (RightHand != 0 && RightHand != 9 && RightHand != 11&& MCMMenu.EnableUndressRightHand)
		PlayerIsCompliant = false
		ArmedOrSpellsCompliant = false
	endif
endif
if PreviouslyCompliant != PlayerIsCompliant
	if MCMMenu.EnforcerAutomaticStrip
		PlayerIsCompliant = true
		myScripts.SLV_DisplayUser("Before anyone can notice you quickly undress to comply with the nudity law.")
		myScripts.SLV_SexlabStripNPC(PlayerRef)
	else
		PlayerIsReported = false
		if PlayerIsCompliant
			myScripts.SLV_DisplayUser("You are now complying with the new laws")
		else
			myScripts.SLV_DisplayUser("You are not complying with the law and can be turned in if anyone catches you")
		endif
	endif
endif
EndFunction

; We check for specific types that would cover the sexy bits while allowing decorative items to remain. 
Bool Function CheckThisArmor(Form ItemToCheck)
if ItemTocheck == None
	return false;
endif
if ItemToCheck.HasKeyword(SexlabNoStrip)	; Don't remove anything marked as not stripable to Sexlab
	return false
endif

if Game.GetModByName("Shout Like a Virgin.esp")!= 255
	Form NocturnalRobe = Game.GetFormFromFile(0x11AD6C, "Shout Like a Virgin.esp") as Form
	if ItemToCheck == NocturnalRobe
		return false
	endif
endif

if ItemToCheck.HasKeyword(ArmorCuirass)|| ItemToCheck.HasKeyword(ArmorClothing) || ItemToCheck.HasKeyword(ClothingBody) || ItemToCheck.HasKeyword(ArmorHelmet)
	return true
endif
return false
EndFunction

Function HandleMaleFollower(Actor NPCActor, ActorBase NPCActorBase, Race NPCRace)
HandleMaleNPC(NPCActor, NPCActorBase, NPCRace)
EndFunction

Function HandleMaleNPC(Actor NPCActor, ActorBase NPCActorBase, Race NPCRace)
; Just bail quickly if this actor is having sex
if Sexlab.IsActorActive(NPCActor) ||  NPCActor == PlayerRef || NPCActor == None|| NPCActorBase== None
	return   ;No player character
endif

bool actorIsACreature = IsActorACreature(NPCActor, NPCActorBase, NPCRace)

; Notice you are not naked distance 550  ; NPCActor.HasLOS(PlayerRef) && 
if SLV_SlaveOnTheRun.getValue() == 1
	myScripts.SLV_DisplayInformation(NPCActorBase.GetName() + " checking you if you are an escaped slave")
	if NpcActor.GetDistance(PlayerRef) <= 550 && (!PlayerIsReported) && MCMMenu.ForceReporting && (!actorIsACreature)
		myScripts.SLV_DisplayUser(NPCActorBase.GetName() + " has noticed that you are an escaped slave")
		Int Handle = ModEvent.Create("SlaverunReloaded_EscapedSlave")
		If (Handle)
			ModEvent.PushForm(Handle, NPCActor)
			ModEvent.Send(Handle)
		EndIf
		PlayerIsReported = true
		return
	elseif PlayerIsReported
		myScripts.SLV_DisplayInformation(" Player is already reported")
	endif
endIf

if NPCActor.HasLOS(PlayerRef) && NpcActor.GetDistance(PlayerRef) <= 550 && !PlayerIsCompliant && !PlayerIsReported && MCMMenu.TattleTales && !actorIsACreature
	myScripts.SLV_DisplayUser(NPCActorBase.GetName() + " has noticed you not complying with the laws and is reporting your crime")
	Int Handle = ModEvent.Create("SlaverunReloaded_ViolateSlaverLaw")
	If (Handle)
		ModEvent.PushForm(Handle, NPCActor)
		ModEvent.Send(Handle)
	EndIf
	;CrimeFactionWhiterun.SetCrimeGoldViolent(1000)
	PlayerIsReported = true
endif

myScripts.SLV_DisplayDebug2("EnforcerMaxSexlabCalls " + MCMMenu.EnforcerMaxSexlabCalls + "SexCounter " + SexCounter)
if MCMMenu.EnforcerMaxSexlabCalls > 0 && SexCounter >= MCMMenu.EnforcerMaxSexlabCalls
;if MCMMenu.EnforcerMaxSexlabCalls == 0
	return
endif

if !IsMaleAndReady(NPCActor, NPCActorBase, NPCRace)
	myScripts.SLV_DisplayDebug2("Male NPC Check aborted" )
	return
endif

bool ArousedMalesFuckSlaves = MCMMenu.ArousedMalesFuckSLaves
if PlayerRef.IsInFaction(SlaverunSlaveFaction)
	ArousedMalesFuckSlaves = ArousedMalesFuckSlaves || MCMMenu.ArousedMalesFuckPC
elseif PlayerRef.IsInFaction(SlaverunSlaverFaction) && MCMMenu.rapeForSlavers
	ArousedMalesFuckSlaves = ArousedMalesFuckSlaves || MCMMenu.ArousedMalesFuckPC
endIf

myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " has arousal " +  NPCActor.GetFactionRank(sla_Arousal))
myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " has new arousal " +  arousal.GetArousalRank(NPCActor))

myScripts.SLV_DisplayDebug2("MCM Fuckslaves=" + MCMMenu.ArousedMalesFuckSLaves + " , MCM Fuckfreewoman=" + MCMMenu.ArousedMalesFuckFreeFemales)
Bool SlaveIsFucked = false
if (NPCActor.GetFactionRank(sla_Arousal) >= MCMMenu.ArousalToFuckSlave) && ArousedMalesFuckSLaves  && (SexCounter < MCMMenu.EnforcerMaxSexlabCalls || MCMMenu.EnforcerMaxSexlabCalls==0) && !gangbang
	myScripts.SLV_DisplayUser(NPCActorBase.GetName() + " is now searching for a slave to fuck")

	; Arousal is too high, find a nearby slave to fuck
	Actor SlaveToFuck = FindNearestAvailableFemale(NPCActor, NPCActorBase, NPCRace, True)
	if SlaveToFuck && !Sexlab.IsActorActive(NPCActor) && !Sexlab.IsActorActive(SlaveToFuck)
		ActorBase SlaveToFuckBase = SlaveToFuck.GetLeveledActorBase()
		int isvalid = 1 ; Sexlab.ValidateActor(SlaveToFuck)
		bool isAnimating =  false ;libs.IsAnimating(SlaveToFuck)		
		
		if !MCMMenu.SkipIntensiveSexlabChecks
			isvalid = Sexlab.ValidateActor(SlaveToFuck)
			isAnimating =  libs.IsAnimating(SlaveToFuck)
		endif
		
		bool playerIsInDialog =  isPlayerInDialogue(SlaveToFuck)
		bool lastcheck = LastSexCheck(SlaveToFuck, NPCActor)
		if (isvalid == 1) && !isAnimating && !playerIsInDialog && lastcheck
			myScripts.SLV_DisplayUser(NPCActorBase.GetName() + " is going to fuck the slave " + SlaveToFuckBase.GetName())
			String AnimationTags = "Sex"
			if MCMMenu.AggressiveFuckForSlaves
				AnimationTags = AnimationTags + ",Aggressive"
			endif
			if MCMMenu.AnalFuckForSlaves
				AnimationTags = AnimationTags + ",Anal"
			endif
			
			int gangbangrandom = Utility.RandomInt(1,100)
			int playscene = Utility.RandomInt(1,100)
			
			; when the player has been certified as gangbang painslut, she gets gangbanged
			if SlaveToFuck == PlayerRef 
				handlePlayerRape(NPCActor, NPCActorBase, AnimationTags)
			else
				myScripts.SLV_Play2Sex(SlaveToFuck,NPCActor,AnimationTags, true)
			endIf
				
			SexCounter+= 1
			SlaveIsFucked = true
			MCMMenu.SlavesCalledForSex = MCMMenu.SlavesCalledForSex + 1
			;Utility.wait(3.0)
		else
			myScripts.SLV_DisplayUser(NPCActorBase.GetName() + " wants to fuck the slave " + SlaveToFuckBase.GetName() + " ,but this pussy is already occupied.")

			myScripts.SLV_DisplayDebug2("isvalid:" + isvalid)
			myScripts.SLV_DisplayDebug2("isAnimating:" + isAnimating)
			myScripts.SLV_DisplayDebug2("playerIsInDialog:" + playerIsInDialog)
			myScripts.SLV_DisplayDebug2("lastcheck:" + lastcheck)
		endif
		return
	else
		if NPCActor.GetFactionRank(sla_Arousal) < MCMMenu.ArousalToFuckFreeFemale
			myScripts.SLV_DisplayInformation(NPCActorBase.GetName() + " is horny "  + NPCActor.GetFactionRank(sla_Arousal) + " but has no slaves close enough to demand sex from. Distance=" + DistanceToNearestFemale as Int)
		endif
	endif	
endif

bool ArousedMalesFuckFreeFemales = MCMMenu.ArousedMalesFuckFreeFemales
if PlayerRef.IsInFaction(SlaverunSlaveFaction)
	ArousedMalesFuckFreeFemales = ArousedMalesFuckFreeFemales || MCMMenu.ArousedMalesFuckPC
endIf
if NPCActor.GetFactionRank(sla_Arousal) >= MCMMenu.ArousalToFuckFreeFemale && SlaveIsFucked == false && ArousedMalesFuckFreeFemales  && (SexCounter < MCMMenu.EnforcerMaxSexlabCalls || MCMMenu.EnforcerMaxSexlabCalls==0) && !gangbang
	; No slave is available, we'll rape any close young female because we are super horny
	; Arousal is too high and no convenient slave is close so find a nearby young female to fuck
	; For now we just go straight to a fuck, in the future we'll give the female a chance to refuse by running away.  Ultimately the idea will be if
	; the female NPC also has high arousal she'll consent, if she doesn't consent she must run and be X distance away or out of sight within 5 seconds
	; or she's gonna get raped.  Player will be handled similar but she gets to decide to fuck or not independent of how aroused she is.
	; Comment when entering town is that you would not be a free fuck, may incorporate a pay system. Free females get X gold for being fucked while slaves get
	; Y gold to give to their master for the same.  Y would be x * .5 or less, probably make the amount and ratio a MCM menu choice.
	; The only ones to whom X or Y would matter of course will be the player (and female followers eventually) and of course their master of the moment.
	
	; animals don't fuck free women
	if  actorIsACreature
		return
	endif
	
	myScripts.SLV_DisplayUser(NPCActorBase.GetName() + " is now searching for a free or slave to fuck")
	Actor FemaleToFuck = FindNearestAvailableFemale(NPCActor, NPCActorBase, NPCRace, False)
	if FemaleToFuck != None && !Sexlab.IsActorActive(NPCActor) && !Sexlab.IsActorActive(FemaleToFuck)
		ActorBase FemaleToFuckBase = FemaleToFuck.GetLeveledActorBase()
		
		int isvalid = 1 ; Sexlab.ValidateActor(FemaleToFuck)
		bool isAnimating =  false ;libs.IsAnimating(FemaleToFuck)		
		
		if !MCMMenu.SkipIntensiveSexlabChecks
			isvalid = Sexlab.ValidateActor(FemaleToFuck)
			isAnimating =  libs.IsAnimating(FemaleToFuck)
		endif
		
		bool playerIsInDialog =  isPlayerInDialogue(FemaleToFuck)
		bool lastcheck = LastSexCheck(FemaleToFuck, NPCActor)
		if (isvalid == 1) && !isAnimating && !playerIsInDialog && lastcheck
			myScripts.SLV_DisplayUser(NPCActorBase.GetName() + " is going to rape " + FemaleToFuckBase.GetName())
			String AnimationTags = "Sex"
			if MCMMenu.AggressiveFuckForFreeFemales
				AnimationTags = AnimationTags + ",Aggressive"
			endif
			if MCMMenu.AnalFuckForFreeFemales
				AnimationTags = AnimationTags + ",Anal"
			endif
			
			int playscene = Utility.RandomInt(1,100)

			if FemaleToFuck == PlayerRef 
				handlePlayerRape(NPCActor, NPCActorBase, AnimationTags)
			
			; if FemaleToFuck == PlayerRef && SlaverunDialogueQuest.GetStage() >= 2500 && MCMMenu.PCGangbang && !(checkForCreature(NPCActor,NPCActorBase))
			; 	gangbang = true
			; 	gangbangsexActors[3] = NpcActor
			; elseif FemaleToFuck == PlayerRef && MCMMenu.EnforcerSexScenes && playscene <= MCMMenu.enforcerSexSceneProbabilty
			; 	SLV_EnforcerSexQuest.Stop()
			; 	SLV_EnforcerSexQuest.Reset()
			; 	SLV_EnforcerSexQuest.Start()
			; 	enforcerSex.SLV_EnforcerFreeRape(NPCActor)
			else
				myScripts.SLV_Play2Sex(FemaleToFuck,NPCActor,AnimationTags, true)
			endif
			
			SexCounter+= 1
			MCMMenu.FreeFemalesCalledForSex = MCMMenu.FreeFemalesCalledForSex + 1
			;Utility.wait(3.0)
		else
			myScripts.SLV_DisplayUser(NPCActorBase.GetName() + " wants to fuck a free woman " + FemaleToFuckBase.GetName() + " ,but this pussy is already occupied.")
			
			myScripts.SLV_DisplayDebug2("isvalid:" + isvalid)
			myScripts.SLV_DisplayDebug2("isAnimating:" + isAnimating)
			myScripts.SLV_DisplayDebug2("playerIsInDialog:" + playerIsInDialog)
			myScripts.SLV_DisplayDebug2("lastcheck:" + lastcheck)
		endif
	else
		myScripts.SLV_DisplayInformation(NPCActorBase.GetName() + " is very horny "  + NPCActor.GetFactionRank(sla_Arousal) + " but has no free females close enough demand sex. Distance=" + DistanceToNearestFemale as Int + " Player=" + DistanceToPlayer as Int)
	endif
else
	Int attackerGender = SexLab.GetGender(NPCActor)

	if checkForCreature(NPCActor,NPCActorBase)
		myScripts.SLV_DisplayDebug1(NPCActorBase.GetName() + " is a creature and cannot join gangbang " + attackerGender)
	else
		myScripts.SLV_DisplayDebug1(NPCActorBase.GetName() + " is not a creature and would join gangbang " + attackerGender)
		if gangbangcount < 3
			gangbangsexActors[gangbangcount] = NPCActor
			gangbangcount = gangbangcount + 1
		else
			int slot = Utility.RandomInt(0,5) ; 0-6  ; if 0-2 NPC is replaced
			if slot < 3 && gangbangsexActors[0] != NpcActor && gangbangsexActors[1] != NpcActor && gangbangsexActors[2] != NpcActor
				gangbangsexActors[slot] = NPCActor
			endif
		endif
	endif
endif
EndFunction

Function handlePlayerRape(Actor NPCActor, ActorBase NPCActorBase, String AnimationTags)
int gangbangrandom = Utility.RandomInt(1,100)
int playscene = Utility.RandomInt(1,100)
int slaverrape = Utility.RandomInt(1,100)

if PlayerRef.IsInFaction(SlaverunSlaverFaction)
	gangbangrandom = 0
	playscene= 0
endif

; when the player is a slaver
if PlayerRef.IsInFaction(SlaverunSlaverFaction)	
	SLV_EnforcerSexQuest.Reset()
	SLV_EnforcerSexQuest.Start()
	SLV_EnforcerSexQuest.Setstage(0)
	enforcerSex.SLV_EnforcerSlaverRape(NPCActor)
	
; when the player has been certified as gangbang painslut, she gets gangbanged	
elseif SLV_SlaveCertification1Quest.IsCompleted() && MCMMenu.PCGangbang && gangbangrandom <= MCMMenu.PCGangbangProbability && !(checkForCreature(NPCActor,NPCActorBase))
	gangbang = true
	gangbangsexActors[3] = NpcActor
	
elseif MCMMenu.EnforcerSexScenes && playscene <= MCMMenu.enforcerSexSceneProbabilty && checkForCreature(NPCActor,NPCActorBase)
	;SLV_EnforcerSexQuest.Stop()
	SLV_EnforcerSexQuest.Reset()
	SLV_EnforcerSexQuest.Start()
	SLV_EnforcerSexQuest.Setstage(0)
	enforcerSex.SLV_EnforcerAnimalRape(NPCActor)
elseif MCMMenu.EnforcerSexScenes && playscene <= MCMMenu.enforcerSexSceneProbabilty
	;SLV_EnforcerSexQuest.Stop()
	SLV_EnforcerSexQuest.Reset()
	SLV_EnforcerSexQuest.Start()
	SLV_EnforcerSexQuest.Setstage(0)
	enforcerSex.SLV_EnforcerNormalRape(NPCActor)
else
	myScripts.SLV_Play2Sex(PlayerRef,NPCActor,AnimationTags, true)
endIf
endFunction


Bool Function checkForCreature(Actor NPCActor, ActorBase NPCActorBase)
Int attackerGender = SexLab.GetGender(NPCActor)

if attackerGender == 2 || attackerGender == 3
	return true
endif

if NPCActorBase.HasKeyword(ActorTypeCreature) || NPCActorBase.HasKeyword(ActorTypeAnimal) || SexLab.AllowedCreature(NPCActor.GetRace())
	return true
endif

return false
EndFunction


Actor Function FindNearestAvailableFemale(Actor NPCActor, ActorBase NPCActorBase, Race NPCRace, Bool SlavesOnly = false)
; A inner looping through all the actors in this location, we'll try to keep it very tight to reduce lagging
int NPCMax = PlayerCell.getNumRefs(43)	; Not zero based, is actual count
int NPCIndex = 0
DistanceToNearestFemale = 50000.0   ; Way further than needed
Float FemaleDistance = DistanceToNearestFemale
Actor ClosestFemale = None
if SlavesOnly
	myScripts.SLV_DisplayDebug1("--- Finding nearest slave for sex")
else
	myScripts.SLV_DisplayDebug1("--- Finding nearest female slave or free female for sex")
endif
Actor FemaleActor
ActorBase FemaleActorBase 
Race FemaleRace
while (NPCMax > NPCIndex)
	FemaleActor = playerCell.getNthRef(NPCIndex, 43) as Actor
	if FemaleActor
		FemaleActorBase = FemaleActor.GetLeveledActorBase()
		FemaleRace = FemaleActorBase.GetRace()
	endif
	if IsFemaleAndAvailable(NPCActor, FemaleActor, FemaleActorBase, FemaleRace, SlavesOnly)
		FemaleDistance = NPCActor.GetDistance(FemaleActor) ; Get it only 1 time, limits problems with moving actors
		if FemaleDistance < DistanceToNearestFemale 
			ClosestFemale = FemaleActor
			DistanceToNearestFemale = FemaleDistance
			myScripts.SLV_DisplayDebug2("Female for sex hunt, new closest " + FemaleActorBase.GetName() + " is at " + FemaleDistance)
		else
			myScripts.SLV_DisplayDebug2("Female for sex hunt " + FemaleActorBase.GetName() + " is further away at " + FemaleDistance)
		endif
		if FemaleActor == PlayerRef
			DistanceToPlayer = FemaleDistance
		endif
	endif

	NPCIndex += 1
endWhile
If ClosestFemale == None
	myScripts.SLV_DisplayDebug1("Closest available Female = None (No females in cell!?!)")
	Return None
else
	myScripts.SLV_DisplayDebug1("Closest available Female = " + FemaleActorBase.GetName() + " at " + FemaleDistance)
endif
Float MaxDistance = MCMMenu.MaxDistanceToCallSlave	; Limit to how far away slaves can be called for sex
if !SlavesOnly && !ClosestFemale.IsInFaction(SlaverunSlaveFaction)	; Free women get more room to avoid sex
	MaxDistance = MaxDistance *  MCMMenu.RatioOfSlaveDistanceForFreeWomen
endif
if DistanceToNearestFemale > MaxDistance  ; Limit to how far away women can be called for sex
	myScripts.SLV_DisplayDebug1("Closest available Female is out of range Distance=" + FemaleDistance + " MaxDistance=" + MaxDistance)
	Return None
else
	myScripts.SLV_DisplayDebug1("Closest available Female is " + ClosestFemale.GetDisplayName() + " Distance=" + FemaleDistance + " MaxDistance=" + MaxDistance)
	Return ClosestFemale
endif
EndFunction


;  Longer function calls replace very complex IF statements to clarify code path and ease future updates
Bool Function IsActorAvailable(Actor NPCActor, ActorBase NPCActorBase, Race NPCRace)
if NPCActor == None
	return false 	; 	No actor
endif

if  SLV_StopEnforcer.getValue() > 0
	myScripts.SLV_DisplayDebug2("Enforcer is disabled from outside (event)")
	return false ; if disabled we do nothing
endif

if NPCActor.IsInFaction(SLV_NoEnforcerFaction)
	myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is ignored by enforcer")
	return false	; 	ignored by enforcer
endif	

if !NPCActor.Is3dLoaded()
	myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is not 3dLoaded")
	return false	;	Not really here, can't be used
endif
if !NPCActor.IsEnabled()
	myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is not enabled")
	return false	;	Disabled actor, can't be used
endif
if NPCActor.IsDead()
	myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is dead")
	return false	;	They're dead already
endif
if NPCActor.IsChild() || NPCRace.IsChildRace()
	myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is a child")
	return false	;	No children
endif

;if NPCActor.GetCurrentScene() != None
;	myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is in a scene")
;	return false	;	No npc running a scene
;endIf

if SlaverunDialogueQuest.GetStage() < 7300 || MCMMenu.SkipCreatureSex	; Only check until slaves are allowed to be raped by animals 
	If !NPCActor.HasKeyword(ActorTypeNPC)  ; Not marked as a NPC
		myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is not an actortypenpc")
		return false
	endif
	if NPCActorBase.HasKeyword(ActorTypeCreature) || NPCActorBase.HasKeyword(ActorTypeAnimal)	; Is creature or animal
		myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is a creature")
		return false
	endif
endif
myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is available")
return true
EndFunction


Bool Function IsActorACreature(Actor NPCActor, ActorBase NPCActorBase, Race NPCRace)
If !NPCActor.HasKeyword(ActorTypeNPC)  ; Not marked as a NPC
	myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is not an actortypenpc")
	return true
endif
if NPCActorBase.HasKeyword(ActorTypeCreature) || NPCActorBase.HasKeyword(ActorTypeAnimal)	; Is creature or animal
	myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is a creature")
	return true
endif
return false
EndFunction


Bool Function IsFemaleAndAvailable(Actor MaleActor, Actor NPCActor, ActorBase NPCActorBase, Race NPCRace, Bool SlavesOnly = false)
myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " checking now for sex")

if !IsActorAvailable(NPCActor, NPCActorBase, NPCRace) 
	return false;
endif
If !NPCActor.HasKeyword(ActorTypeNPC)  ; Not marked as a NPC
	myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is not an actortypenpc")
	return false
endif
if NPCActorBase.HasKeyword(ActorTypeCreature) || NPCActorBase.HasKeyword(ActorTypeAnimal)	; Is creature or animal
	myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is a creature")
	return false
endif
if NPCActor == PlayerRef 
	if !MCMMenu.ArousedMalesFuckPC
		myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is player char")
		return false  ; female player character check in Kenjoka Version
	endIf
else
	if NPCActor.IsInFaction(SlaverunSlaveFaction)
		if !MCMMenu.ArousedMalesFuckSlaves
			return false	; 	a slave and we are searching for slaves
		endIf
	else
		if !MCMMenu.ArousedMalesFuckFreeFemales
			return false	; 	Not a slave and we are searching for slaves
		endIf	
	endif
endif

if  (NPCActor == PlayerRef || NPCActor.IsInFaction(CurrentFollowerFaction)) && SLV_EnforcerIgnorePC.getValue() == 1
	myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is player char or follower and IgnorePC is true")
	return false  ; female player character check in Kenjoka Version
endif

if NPCActor.IsInFaction(SlaveMasterFaction)
	myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is a slave master")
	return false	; 	No slave masters
endif
if NPCActor.IsInFaction(SlaverunSlaverFaction) && !MCMMenu.enforcerForSlavers
	myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is a slaver")
	return false	; 	No slavers
endif
if NPCActorBase.GetSex() != SexToCheck 
	myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is wrong sex")
	return false	;  Male actor
endif
if (NPCRace == ElderRace || NPCRace == ElderRaceVampire) && MCMMenu.SkipOldPeople
	myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is old")
	return false	; 	Not looking for old women
endif
if SlavesOnly
	if NPCActor.IsInFaction(SlaverunSlaveFaction)
	 ; do nothing
	elseif NPCActor.IsInFaction(SlaverunSlaverFaction) && MCMMenu.rapeForSlavers
		int slaverrape = Utility.RandomInt(1,100)
		if slaverrape <= MCMMenu.rapeForSlaversProbabilty
		else
			return false
		endif
	else
		return false	; 	Not a slave and we are searching for slaves
	endIf
endif
;if !MaleActor.HasLOS(NPCActor)
	;myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is not in LOS")
	;return false	;	If he can't see her, he can't call her for sex
;endif
int isvalid = 1
bool isAnimating = false

if !MCMMenu.SkipIntensiveSexlabChecks
	isvalid = Sexlab.ValidateActor(NPCActor)
	isAnimating = libs.IsAnimating(NPCActor)
endif
if Sexlab.IsActorActive(NPCActor) || !isvalid || isAnimating
	myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is already sex active")
	return false	;	That pussy is already occupied
endif

if (NPCActor.GetDialogueTarget() == PlayerRef  && NPCActor.IsInDialogueWithPlayer())
	myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is in dialogue with the player!")
	return false	;	in dialogue with player
endIf

if (NPCActor.wornHasKeyword(libs.zad_DeviousBelt) || NPCActor.wornHasKeyword(zazKeywordWornBelt)) && \
	!NPCActor.wornhaskeyword(libs.zad_PermitVaginal) && !NPCActor.wornhaskeyword(libs.zad_PermitAnal)    
	 
	if (NPCActor.wornhaskeyword(libs.zad_DeviousGag) || NPCActor.wornhaskeyword(libs.zad_DeviousGagPanel)) && \
	   !NPCActor.wornhaskeyword(libs.zad_PermitOral)
		myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is belted and gagged (1)!")
		return false ; actor is in full chastity
	endif

	if (NPCActor.wornHasKeyword(zazKeywordWornGag) || NPCActor.wornhaskeyword(libs.zad_DeviousGag)) && \
		!NPCActor.wornHasKeyword(zazKeywordPermitOral)
		myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is belted and gagged (1)!")
		return false ; actor is in full chastity
	endif
endIf

if isPlayerInDialogue(NPCActor)
	return false
endif

myScripts.SLV_DisplayDebug2(NPCActor.GetName() + " is available for sex")
return true	; Passed all our tests, she is available for sex
EndFunction
Keyword Property zazKeywordWornBelt auto
Keyword Property zazKeywordWornGag auto
Keyword Property zazKeywordPermitOral auto


Bool Function IsMaleAndReady(Actor NPCActor, ActorBase NPCActorBase, Race NPCRace)
myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " thinks about sex")

if (NPCRace == ElderRace || NPCRace == ElderRaceVampire) && MCMMenu.SkipOldPeople
	myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is old")
	return false	; 	Not looking for old women
endif

int isvalid = 1
bool isAnimating = false

if !MCMMenu.SkipIntensiveSexlabChecks
	isvalid = Sexlab.ValidateActor(NPCActor)
	isAnimating =  libs.IsAnimating(NPCActor)
endif
if Sexlab.IsActorActive(NPCActor) || !isvalid || isAnimating
	myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is already sex active")
	return false	;	That cock is already occupied
endif

if (NPCActor.GetDialogueTarget() == PlayerRef && NPCActor.IsInDialogueWithPlayer())
;if (NPCActor.GetDialogueTarget())
	myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is in dialogue with the player!")
	return false	;	in dialogue with player
endIf

myScripts.SLV_DisplayDebug2(NPCActorBase.GetName() + " is available for sex")
return true	; Passed all our tests, he is available for sex
EndFunction


Bool Function isPlayerInDialogue(Actor NPCActor)
if NPCActor != PlayerRef
	return false
endif

Actor target = GetPlayerDialogueTarget()
if target
	return true
else
	return false
endif
EndFunction


Actor Function GetPlayerDialogueTarget()
Actor kPlayerDialogueTarget
Actor kPlayerRef = PlayerRef
Int iLoopCount = 10
While iLoopCount > 0
	iLoopCount -= 1
	kPlayerDialogueTarget = Game.FindRandomActorFromRef(kPlayerRef , 200.0)
	If kPlayerDialogueTarget != none && kPlayerDialogueTarget != kPlayerRef && kPlayerDialogueTarget.IsInDialogueWithPlayer() 
		Return kPlayerDialogueTarget
	EndIf
EndWhile
Return None
EndFunction


Bool Function LastSexCheck(Actor NPCActor1, Actor NPCActor2)
if !NPCActor1.getCurrentLocation().IsSameLocation(PlayerRef.getCurrentLocation())
	return false
endif
if !NPCActor2.getCurrentLocation().IsSameLocation(PlayerRef.getCurrentLocation())
	return false
endif
return true
EndFunction

