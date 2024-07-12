Scriptname SLV_Cheating extends Quest  

SLV_Utilities Property myScripts auto 
Quest Property SLV_quest Auto
SLV_MCMMenu Property MCMMenu Auto
Faction Property zbfFactionSlave auto
Faction Property zbfFactionSlaver auto
Actor Property PlayerRef Auto


function SLV_CheatAnimalMainQuest()
completeAnimalSubquest(SLV_AnimalDogQuest)
completeAnimalSubquest(SLV_AnimalCowQuest)
completeAnimalSubquest(SLV_AnimalChickenQuest)
completeAnimalSubquest(SLV_AnimalGoatQuest)

completeAnimalSubquest(SLV_AnimalHorseQuest)
completeAnimalSubquest(SLV_AnimalSkeeverQuest)
completeAnimalSubquest(SLV_AnimalDeerQuest)
completeAnimalSubquest(SLV_AnimalBoarQuest)

completeAnimalSubquest(SLV_AnimalSpiderQuest)
completeAnimalSubquest(SLV_AnimalSkeletonQuest)
completeAnimalSubquest(SLV_AnimalDraugrQuest)
completeAnimalSubquest(SLV_AnimalFalmerQuest)

completeAnimalSubquest(SLV_AnimalRieklingQuest)
completeAnimalSubquest(SLV_AnimalSpiderLargeQuest)
completeAnimalSubquest(SLV_AnimalWolfQuest)
completeAnimalSubquest(SLV_AnimalChaurusQuest)
completeAnimalSubquest(SLV_AnimalDwarvenSpiderQuest)

completeAnimalSubquest(SLV_AnimalBearQuest)
completeAnimalSubquest(SLV_AnimalSabrecatQuest)
completeAnimalSubquest(SLV_AnimalTrollQuest)
completeAnimalSubquest(SLV_AnimalHorkerQuest)
completeAnimalSubquest(SLV_AnimalNetchQuest)
completeAnimalSubquest(SLV_AnimalDwarvenSphereQuest)
completeAnimalSubquest(SLV_AnimalChaurusHunterQuest)

completeAnimalSubquest(SLV_AnimalDeathHoundQuest)
completeAnimalSubquest(SLV_AnimalFrostAtronachQuest)
completeAnimalSubquest(SLV_AnimalGargoyleQuest)
completeAnimalSubquest(SLV_AnimalChaurusReaperQuest)
completeAnimalSubquest(SLV_AnimalDwarvenBallistaQuest)
completeAnimalSubquest(SLV_AnimalBoarRieklingQuest)

completeAnimalSubquest(SLV_AnimalMammothQuest)
completeAnimalSubquest(SLV_AnimalSeekerQuest)
completeAnimalSubquest(SLV_AnimalSpiderGiantQuest)
completeAnimalSubquest(SLV_AnimalDwarvenCenturionQuest)

completeAnimalSubquest(SLV_AnimalDragonPriestQuest)
completeAnimalSubquest(SLV_AnimalVampireLordQuest)
completeAnimalSubquest(SLV_AnimalWerewolfQuest)
completeAnimalSubquest(SLV_AnimalGiantQuest)
completeAnimalSubquest(SLV_AnimalLurkerQuest)

completeAnimalSubquest(SLV_AnimalDragonQuest)

SLV_AnimalMainQuest.SetObjectiveCompleted(0)
SLV_AnimalMainQuest.SetStage(49500)

Debug.MessageBox("Cheat completed")
EndFunction
Quest Property SLV_AnimalDogQuest Auto
Quest Property SLV_AnimalCowQuest Auto
Quest Property SLV_AnimalChickenQuest Auto
Quest Property SLV_AnimalGoatQuest Auto

Quest Property SLV_AnimalHorseQuest Auto
Quest Property SLV_AnimalSkeeverQuest Auto
Quest Property SLV_AnimalDeerQuest Auto
Quest Property SLV_AnimalBoarQuest Auto

Quest Property SLV_AnimalSpiderQuest Auto
Quest Property SLV_AnimalSkeletonQuest Auto
Quest Property SLV_AnimalDraugrQuest Auto
Quest Property SLV_AnimalFalmerQuest Auto

Quest Property SLV_AnimalRieklingQuest Auto
Quest Property SLV_AnimalSpiderLargeQuest Auto
Quest Property SLV_AnimalWolfQuest Auto
Quest Property SLV_AnimalChaurusQuest Auto
Quest Property SLV_AnimalDwarvenSpiderQuest Auto

Quest Property SLV_AnimalBearQuest Auto
Quest Property SLV_AnimalSabrecatQuest Auto
Quest Property SLV_AnimalTrollQuest Auto
Quest Property SLV_AnimalHorkerQuest Auto
Quest Property SLV_AnimalNetchQuest Auto
Quest Property SLV_AnimalDwarvenSphereQuest Auto
Quest Property SLV_AnimalChaurusHunterQuest Auto

Quest Property SLV_AnimalDeathHoundQuest Auto
Quest Property SLV_AnimalFrostAtronachQuest Auto
Quest Property SLV_AnimalGargoyleQuest Auto
Quest Property SLV_AnimalChaurusReaperQuest Auto
Quest Property SLV_AnimalDwarvenBallistaQuest Auto
Quest Property SLV_AnimalBoarRieklingQuest Auto

Quest Property SLV_AnimalMammothQuest Auto
Quest Property SLV_AnimalSeekerQuest Auto
Quest Property SLV_AnimalSpiderGiantQuest Auto
Quest Property SLV_AnimalDwarvenCenturionQuest Auto

Quest Property SLV_AnimalDragonPriestQuest Auto
Quest Property SLV_AnimalVampireLordQuest Auto
Quest Property SLV_AnimalWerewolfQuest Auto
Quest Property SLV_AnimalGiantQuest Auto
Quest Property SLV_AnimalLurkerQuest Auto

Quest Property SLV_AnimalDragonQuest Auto

function completeAnimalSubquest(Quest SLV_AnimalSubQuest)
SLV_AnimalSubQuest.reset()
SLV_AnimalSubQuest.start()
SLV_AnimalSubQuest.setstage(0)
SLV_AnimalSubQuest.SetObjectiveCompleted(0)

SLV_AnimalSubQuest.setstage(9500)
SLV_AnimalSubQuest.SetObjectiveCompleted(9500)
SLV_AnimalSubQuest.setstage(10000)
SLV_AnimalSubQuest.CompleteQuest()
endfunction


function SLV_CheatGladiatorMainQuest()
completeAnimalSubquest(SLV_Gladiator0101HamaQuest)
completeAnimalSubquest(SLV_Gladiator0102BandonQuest)
completeAnimalSubquest(SLV_Gladiator0103DomonkosQuest)

completeAnimalSubquest(SLV_Gladiator0201HaldirQuest)
completeAnimalSubquest(SLV_Gladiator0202CalumQuest)
completeAnimalSubquest(SLV_Gladiator0203AllanonQuest)

completeAnimalSubquest(SLV_Gladiator0301ArtusQuest)
completeAnimalSubquest(SLV_Gladiator0302DesmondQuest)
completeAnimalSubquest(SLV_Gladiator0303AkiroQuest)

completeAnimalSubquest(SLV_Gladiator0401AzogQuest )
completeAnimalSubquest(SLV_Gladiator0402HannibalQuest )

completeAnimalSubquest(SLV_Gladiator0501MaximusQuest )
completeAnimalSubquest(SLV_Gladiator0502DopperfieldQuest )

completeAnimalSubquest(SLV_Gladiator0601DastanQuest )
completeAnimalSubquest(SLV_Gladiator0602MoudiniQuest )

completeAnimalSubquest(SLV_Gladiator0701CalarQuest )
completeAnimalSubquest(SLV_Gladiator0702ArnoQuest )

completeAnimalSubquest(SLV_Gladiator0801ConanQuest )
completeAnimalSubquest(SLV_Gladiator0802MerlinQuest )

completeAnimalSubquest(SLV_Gladiator0901TwotailsQuest )

SLV_GladiatorMainQuest.SetObjectiveCompleted(0)
SLV_GladiatorMainQuest.SetStage(49500)

Debug.MessageBox("Cheat completed")
EndFunction

Quest Property SLV_Gladiator0101HamaQuest Auto
Quest Property SLV_Gladiator0102BandonQuest Auto
Quest Property SLV_Gladiator0103DomonkosQuest Auto

Quest Property SLV_Gladiator0201HaldirQuest Auto
Quest Property SLV_Gladiator0202CalumQuest Auto
Quest Property SLV_Gladiator0203AllanonQuest Auto

Quest Property SLV_Gladiator0301ArtusQuest Auto
Quest Property SLV_Gladiator0302DesmondQuest Auto
Quest Property SLV_Gladiator0303AkiroQuest Auto

Quest Property SLV_Gladiator0401AzogQuest Auto
Quest Property SLV_Gladiator0402HannibalQuest Auto

Quest Property SLV_Gladiator0501MaximusQuest Auto
Quest Property SLV_Gladiator0502DopperfieldQuest Auto

Quest Property SLV_Gladiator0601DastanQuest Auto
Quest Property SLV_Gladiator0602MoudiniQuest Auto

Quest Property SLV_Gladiator0701CalarQuest Auto
Quest Property SLV_Gladiator0702ArnoQuest Auto

Quest Property SLV_Gladiator0801ConanQuest Auto
Quest Property SLV_Gladiator0802MerlinQuest Auto

Quest Property SLV_Gladiator0901TwotailsQuest Auto



function SLV_CheatArenaQuest()
if SLV_ColosseumMainQuest.IsCompleted()
	return
endif

if !SLV_ColosseumMainQuest.IsRunning()
	SLV_ColosseumMainQuest.reset()
	SLV_ColosseumMainQuest.start()
	SLV_ColosseumMainQuest.setstage(0)
	SLV_ColosseumMainQuest.SetObjectiveCompleted(SLV_ColosseumMainQuest.getStage())
	Utility.wait(1.0)
endif

SLV_Caesar.enable()
SLV_Cassius.enable()
SLV_Jaha.enable()
SLV_Gustus.enable()
SLV_Quintus.enable()
SLV_Roan.enable()
SLV_Bones.enable()
SLV_Rosita.enable()

dragonsreachDoor.enable()
skyrimDoor.enable()
skyrimColosseum.enable()

dragonsreachDoor.lock(false)
skyrimDoor.lock(false)
passageAnimalDoor.lock(false)
passageGladiatorDoor.lock(false)
passageSlaveGladiatorDoor.lock(false)
passageTrainingDoor.lock(false)
passageArenaDoor.lock(false)
animalArenaDoor.lock(false)

colosseumEnabling.SLV_enableAll()
colosseumEnabling.SLV_CheatAllRecipes()

completeAnimalSubquest(SLV_ColosseumAnimalQuest)
completeAnimalSubquest(SLV_ColosseumArenaQuest)
completeAnimalSubquest(SLV_ColosseumFunFairQuest)
completeAnimalSubquest(SLV_ColosseumSlaveQuest)
completeAnimalSubquest(SLV_ColosseumTrainingQuest)

SLV_AnimalMainQuest.Reset() 
SLV_AnimalMainQuest.Start() 
SLV_AnimalMainQuest.SetStage(0)
SLV_AnimalMainQuest.SetActive(true)
Utility.wait(1.0)
	
SLV_GladiatorMainQuest.Reset() 
SLV_GladiatorMainQuest.Start() 
SLV_GladiatorMainQuest.SetStage(0)
SLV_GladiatorMainQuest.SetActive(true)
Utility.wait(1.0)

SLV_SexSlaveTraining6Quest.Reset() 
SLV_SexSlaveTraining6Quest.Start() 
SLV_SexSlaveTraining6Quest.SetStage(0)
SLV_SexSlaveTraining6Quest.SetActive(true)
Utility.wait(1.0)

SLV_MapMarker1.enable()
SLV_MapMarker2.enable()

if SLV_ColosseumMainQuest.IsRunning()
	SLV_ColosseumMainQuest.setstage(9500)
	;SLV_ColosseumMainQuest.CompleteQuest()
endif

Utility.wait(5.0)

PlayerRef.additem(SLV_SexSlaveVol47)
PlayerRef.additem(SLV_SexSlaveVol48)
PlayerRef.additem(SLV_SexSlaveVol49)
PlayerRef.additem(SLV_SexSlaveVol50)
PlayerRef.additem(SLV_SexSlaveVol51)
PlayerRef.additem(SLV_SexSlaveVol52)
PlayerRef.additem(SLV_SexSlaveVol53)

Debug.MessageBox("Cheat completed")
EndFunction
ObjectReference Property SLV_MapMarker1 Auto 
ObjectReference Property SLV_MapMarker2 Auto

Actor Property SLV_Caesar Auto
Actor Property SLV_Cassius Auto
Actor Property SLV_Jaha Auto
Actor Property SLV_Gustus Auto
Actor Property SLV_Quintus Auto
Actor Property SLV_Roan Auto
Actor Property SLV_Bones Auto
Actor Property SLV_Rosita Auto

ObjectReference Property dragonsreachDoor auto
ObjectReference Property skyrimDoor auto
ObjectReference Property passageAnimalDoor auto
ObjectReference Property passageGladiatorDoor auto
ObjectReference Property passageSlaveGladiatorDoor auto
ObjectReference Property passageTrainingDoor auto
ObjectReference Property passageArenaDoor auto
ObjectReference Property animalArenaDoor auto
ObjectReference Property skyrimColosseum auto

Quest Property SLV_AnimalMainQuest auto
Quest Property SLV_GladiatorMainQuest auto
Quest Property SLV_ColosseumMainQuest auto
Quest Property SLV_ColosseumAnimalQuest auto
Quest Property SLV_ColosseumArenaQuest auto
Quest Property SLV_ColosseumFunFairQuest auto
Quest Property SLV_ColosseumSlaveQuest auto
Quest Property SLV_ColosseumTrainingQuest auto
Quest Property SLV_SexSlaveTraining6Quest auto
SLV_EnableColosseum Property colosseumEnabling auto



function SLV_CheatEnslavement()
SLV_quest.SetObjectiveCompleted(SLV_quest.getStage())
SLV_quest.SetStage(1200)

; SLV_EnslavePC
myScripts.SLV_enslavementFull(false)
Utility.wait(2.0)
myScripts.SLV_enslavementChains(PlayerRef)
Utility.wait(2.0)

if MCMMenu.SlaveShaving
	shaveScripts.Shave(PlayerRef)
	shaveScripts.ShaveBodyHair()
endif

if MCMMenu.SlaveTatoos
	SlaveTats.simple_add_tattoo(PlayerRef, "Slutmarks", "Cunt (right cheek)", silent = true)
	SlaveTats.simple_add_tattoo(PlayerRef, "Slave Marks", "Slave (left cheek)", silent = true)
	SlaveTats.simple_add_tattoo(PlayerRef, "Slave Marks", "Slave (forehead)", silent = true)
	SlaveTats.simple_add_tattoo(PlayerRef, "Slave Marks", "Slave (left hand)", silent = true)
	SlaveTats.simple_add_tattoo(PlayerRef, "Slave Marks", "Slave (right hand)", silent = true)
endif
Utility.wait(2.0)

; SLV_CatchingIvana
;PlayerRef.additem(SLV_SexSlaveVol01)
myScripts.SLV_enableValentina()

;debug.notification(SLV_Ivana.getActorBase().getName())

SLV_Ivana.removeallitems()
SLV_Ivana.additem(Torch,1)
myScripts.SLV_enslavementNPC(SLV_Ivana)
myScripts.SLV_DeviousEquipActor(SLV_Ivana,false,false,false,false,false,false,false,false,false,false,true,false,false,false,true)
myScripts.SLV_enslavementChains(SLV_Ivana)
Utility.wait(2.0)
myScripts.SLV_IvanaReset()
PlayerRef.additem(SLV_SexSlaveVol02)

; SLV_WalkOfShame
if SLV_Hardmode.getValue() == 1
	;SendModEvent("yps-LockMakeupEvent")
	SendModEvent("yps-PermanentMakeupEvent")
	SendModEvent("yps-DisableSmudgingEvent")
	;Utility.wait(2.0)

	;SendModEvent("yps-LipstickEvent", "Dark Red", 0x8b0000)  
	SendModEvent("yps-LipstickEvent", "Black" , 0)  
	;Utility.wait(2.0)
	SendModEvent("yps-EyeshadowEvent","Black" , 0)    
	; apply makeup: send name of color as string (e.g. "red"), and ColorRGBCode as a 0xRRGGBB value.
	Utility.wait(2.0)
	SendModEvent("yps-FingerNailsEvent", "", 2) 
	;Utility.wait(2.0)
	SendModEvent("yps-ToeNailsEvent",  "", 2)
	Utility.wait(2.0)

	SendModEvent("yps-PiercingEvent", PlayerRef.getActorBase().getName() ,1)
	SendModEvent("yps-PiercingEvent", PlayerRef.getActorBase().getName() ,2)
	SendModEvent("yps-PiercingEvent", PlayerRef.getActorBase().getName() ,3)
	SendModEvent("yps-PiercingEvent", PlayerRef.getActorBase().getName() ,4)
	SendModEvent("yps-PiercingEvent", PlayerRef.getActorBase().getName() ,5)
	SendModEvent("yps-PiercingEvent", PlayerRef.getActorBase().getName() ,6)
	SendModEvent("yps-PiercingEvent", PlayerRef.getActorBase().getName() ,7)
	SendModEvent("yps-PiercingEvent", PlayerRef.getActorBase().getName() ,8)
	SendModEvent("yps-PiercingEvent", PlayerRef.getActorBase().getName() ,9)
	SendModEvent("yps-PiercingEvent", PlayerRef.getActorBase().getName() ,10)
	SendModEvent("yps-PiercingEvent", PlayerRef.getActorBase().getName() ,11)
	Utility.wait(20.0)
	
	SLV_SlaveMiniLevelUP()
	
	SLV_WalkOfShameQuest.reset()
	SLV_WalkOfShameQuest.start()
	SLV_WalkOfShameQuest.setstage(6500)
	SLV_WalkOfShameQuest.SetObjectiveCompleted(SLV_WalkOfShameQuest.getStage())
	Utility.wait(2.0)
	SLV_WalkOfShameQuest.setstage(9500)
	SLV_WalkOfShameQuest.CompleteQuest()
endif

; SLV_SlaveTraining01
if MCMMenu.SlaveReNaming
	shaveScripts.SlaveName(PlayerRef)
endif

SLV_PlayerHasToReport.setvalue(1)
periodicReporting.StartPeriodicReportingTimer()
ActorUtil.ClearPackageOverride(SLV_Ivana)
SLV_Ivana.evaluatePackage()

myScripts.SLV_IvanaReset()
SLV_SlaveMiniLevelUP()
PlayerRef.additem(SLV_SexSlaveVol03)

SLV_EnslavePCQuest.SetObjectiveCompleted(SLV_EnslavePCQuest.getstage())
SLV_EnslavePCQuest.setstage(9500)
SLV_EnslavePCQuest.CompleteQuest()

SLV_SexSlaveTraining1Quest.reset()
SLV_SexSlaveTraining1Quest.start()
SLV_SexSlaveTraining1Quest.setstage(1500)
SLV_SexSlaveTraining1Quest.SetObjectiveCompleted(SLV_SexSlaveTraining1Quest.getStage())
Utility.wait(2.0)
SLV_SexSlaveTraining1Quest.setstage(11000)
SLV_SexSlaveTraining1Quest.CompleteQuest()

if MCMMenu.BreastWeightGrowing
	SLV_BabyGotBoobsQuest.reset()
	SLV_BabyGotBoobsQuest.start()
	SLV_BabyGotBoobsQuest.setstage(0)
endif

Debug.MessageBox("Cheat completed")
EndFunction
Actor Property SLV_Ivana Auto 
Light Property Torch Auto
GlobalVariable Property SLV_Hardmode Auto
SLV_HeadShaving Property shaveScripts auto 
SLV_PeriodicReporting Property periodicReporting Auto
Quest Property SLV_EnslavePCQuest Auto
Quest Property SLV_SexSlaveTraining1Quest Auto
Quest Property SLV_WalkOfShameQuest Auto
Quest Property SLV_BabyGotBoobsQuest Auto
GlobalVariable Property SLV_PlayerHasToReport Auto 



function SLV_CheatRiverwoodEnslaved(bool showmessage)
SLV_quest.SetObjectiveCompleted(SLV_quest.getStage())
SLV_quest.SetStage(2000)

; MainquestSpecial01
Horse.enable()

if PlayerRef.IsInFaction(zbfFactionSlave)
	; sexSlaveTraining2
	PlayerRef.additem(SLV_SexSlaveVol04)
	

	; MainquestSpecial01	
	PlayerRef.additem(SLV_SexSlaveVol05)
	SLV_SlaveMiniLevelUP()
	
	; sexSlaveTraining3
	PlayerRef.additem(SLV_SexSlaveVol06)

	; RiverwoodSlavery
	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Slavery", 12, 40) ;Fame slavery +40
	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Misogyny", 12, 40) ;Misogyny +40

	if MCMMenu.SlaveRenaming
		myScripts.SLV_NextSlaveName(PlayerRef)
	endif

	PlayerRef.additem(SLV_SexSlaveVol07)

	SLV_SexSlaveTraining2Quest.reset()
	SLV_SexSlaveTraining2Quest.start()
	SLV_SexSlaveTraining2Quest.setstage(0)
	SLV_SexSlaveTraining2Quest.SetObjectiveCompleted(SLV_SexSlaveTraining2Quest.getStage())
	Utility.wait(1.0)
	SLV_SexSlaveTraining2Quest.setstage(10000)
	SLV_SexSlaveTraining2Quest.CompleteQuest()

	SLV_MainquestSpecial1Quest.reset()
	SLV_MainquestSpecial1Quest.start()
	SLV_MainquestSpecial1Quest.setstage(0)
	SLV_MainquestSpecial1Quest.SetObjectiveCompleted(SLV_MainquestSpecial1Quest.getStage())
	Utility.wait(1.0)
	SLV_MainquestSpecial1Quest.setstage(3000)
	SLV_MainquestSpecial1Quest.CompleteQuest()

	SLV_SexSlaveTraining3Quest.reset()
	SLV_SexSlaveTraining3Quest.start()
	SLV_SexSlaveTraining3Quest.setstage(0)
	SLV_SexSlaveTraining3Quest.SetObjectiveCompleted(SLV_SexSlaveTraining3Quest.getStage())
	Utility.wait(1.0)
	SLV_SexSlaveTraining3Quest.setstage(10000)
	SLV_SexSlaveTraining3Quest.CompleteQuest()
	
	if !SLV_FinnTrainingQuest.isRunning() && MCMMenu.slaveguard
		SLV_FinnTrainingQuest.Reset() 
		SLV_FinnTrainingQuest.Start() 
		SLV_FinnTrainingQuest.SetActive(true) 
		SLV_FinnTrainingQuest.SetStage(0)
	endif
elseif PlayerRef.IsInFaction(zbfFactionSlaver)
	; MainquestSpecial01	
	myScripts.SLV_miniLevelUp()
	
	myScripts.SLV_miniLevelUp()
else
endif

if showmessage
	Debug.MessageBox("Cheat completed")
endif
EndFunction
Actor Property Horse  Auto

Quest Property SLV_SexSlaveTraining2Quest Auto
Quest Property SLV_MainquestSpecial1Quest Auto
Quest Property SLV_SexSlaveTraining3Quest Auto
Quest Property SLV_FinnTrainingQuest Auto



function SLV_CheatFalkreathEnslaved(bool showmessage)
if SLV_quest.getStage() < 2000
	SLV_CheatRiverwoodEnslaved(false)
endif

SLV_quest.SetObjectiveCompleted(SLV_quest.getStage())
SLV_quest.SetStage(3000)
Dremora1.enable()

if PlayerRef.IsInFaction(zbfFactionSlave)
	SLV_SlaveMiniLevelUP()
	
	;SLV_MainquestSpecial11
	PlayerRef.additem(SLV_SexSlaveVol08)
	SLV_SlaveMiniLevelUP()
	
	; sexSlaveTraining4
	PlayerRef.additem(SLV_SexSlaveVol09)
	
	; slavecertification1
	PlayerRef.additem(SLV_SexSlaveVol10)
	
	; sexSlaveTraining5
	PlayerRef.additem(SLV_SexSlaveVol11)
	
	; falkreathslavery
	PlayerRef.additem(SLV_SexSlaveVol12)
	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Slavery", 1, 40) ;Fame slavery +40
	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Misogyny", 1, 40) ;Misogyny +40

	if MCMMenu.SlaveRenaming
		myScripts.SLV_NextSlaveName(Game.GetPlayer())
	endif

	SLV_SexSlaveTraining4Quest.reset()
	SLV_SexSlaveTraining4Quest.start()
	SLV_SexSlaveTraining4Quest.setstage(0)
	SLV_SexSlaveTraining4Quest.SetObjectiveCompleted(SLV_SexSlaveTraining4Quest.getStage())
	Utility.wait(1.0)
	SLV_SexSlaveTraining4Quest.setstage(10000)
	SLV_SexSlaveTraining4Quest.CompleteQuest()

	SLV_MainquestSpecial11Quest.reset()
	SLV_MainquestSpecial11Quest.start()
	SLV_MainquestSpecial11Quest.setstage(0)
	SLV_MainquestSpecial11Quest.SetObjectiveCompleted(SLV_MainquestSpecial11Quest.getStage())
	Utility.wait(1.0)
	SLV_MainquestSpecial11Quest.setstage(10000)
	SLV_MainquestSpecial11Quest.CompleteQuest()

	SLV_SlaveCertification1Quest.reset()
	SLV_SlaveCertification1Quest.start()
	SLV_SlaveCertification1Quest.setstage(0)
	SLV_SlaveCertification1Quest.SetObjectiveCompleted(SLV_SlaveCertification1Quest.getStage())
	Utility.wait(1.0)
	SLV_SlaveCertification1Quest.setstage(10000)
	SLV_SlaveCertification1Quest.CompleteQuest()

	SLV_SexSlaveTraining5Quest.reset()
	SLV_SexSlaveTraining5Quest.start()
	SLV_SexSlaveTraining5Quest.setstage(0)
	SLV_SexSlaveTraining5Quest.SetObjectiveCompleted(SLV_SexSlaveTraining5Quest.getStage())
	Utility.wait(1.0)
	SLV_SexSlaveTraining5Quest.setstage(10000)
	SLV_SexSlaveTraining5Quest.CompleteQuest()
	
elseif PlayerRef.IsInFaction(zbfFactionSlaver)
	myScripts.SLV_miniLevelUp()
else
endif

if showmessage
	Debug.MessageBox("Cheat completed")
endif
EndFunction
Quest Property SLV_MainquestSpecial11Quest Auto
Quest Property SLV_SexSlaveTraining4Quest Auto
Quest Property SLV_SlaveCertification1Quest Auto
Quest Property SLV_SexSlaveTraining5Quest Auto
Actor Property Dremora1 Auto 



function SLV_CheatDawnstarEnslaved(bool showmessage)
if SLV_quest.getStage() < 3000
	SLV_CheatFalkreathEnslaved(false)
endif

SLV_quest.SetObjectiveCompleted(SLV_quest.getStage())
SLV_quest.SetStage(4000)

if PlayerRef.IsInFaction(zbfFactionSlave)
	SLV_SlaveMiniLevelUP()
	
	;SLV_MainquestSpecial02
	PlayerRef.additem(SLV_SexSlaveVol13)
	SLV_SlaveMiniLevelUP()
	
	;SLV_SlaveryEnforcement
	;SLV_CatchingJasmin
	PlayerRef.additem(SLV_SexSlaveVol14)
	SLV_Jasmin.enable()
	myScripts.SLV_enslavementNPC(SLV_Jasmin)
	myScripts.SLV_enslavementChains(SLV_Jasmin)
	ActorUtil.ClearPackageOverride(SLV_Jasmin)
	SLV_Jasmin.evaluatePackage()
	ActorUtil.AddPackageOverride(SLV_Jasmin, SLV_JasminUseCross ,100)
	SLV_Jasmin.evaluatePackage()
	ActorUtil.AddPackageOverride(SLV_Jasmin, SLV_JasminWalkToCross ,60)
	SLV_Jasmin.evaluatePackage()
	
	;SLV_CatchingJulia
	PlayerRef.additem(SLV_SexSlaveVol15)
	SLV_Julia.enable()
	myScripts.SLV_enslavementNPC(SLV_Julia)
	myScripts.SLV_enslavementChains(SLV_Julia)
	ActorUtil.ClearPackageOverride(SLV_Julia)
	SLV_Julia.evaluatePackage()
	ActorUtil.AddPackageOverride(SLV_Julia, SLV_JuliaUseCross ,100)
	SLV_Julia.evaluatePackage()
	ActorUtil.AddPackageOverride(SLV_Julia, SLV_JuliaWalkToCross ,60)
	SLV_Julia.evaluatePackage()

	;SLV_CatchingJane
	PlayerRef.additem(SLV_SexSlaveVol16)
	SLV_Jane.enable()
	myScripts.SLV_enslavementNPC(SLV_Jane)
	myScripts.SLV_enslavementChains(SLV_Jane)
	ActorUtil.ClearPackageOverride(SLV_Jane)
	SLV_Jane.evaluatePackage()
	ActorUtil.AddPackageOverride(SLV_Jane, SLV_JaneUseCross ,100)
	SLV_Jane.evaluatePackage()
	ActorUtil.AddPackageOverride(SLV_Jane, SLV_JaneWalkToCross ,60)
	SLV_Jane.evaluatePackage()
	
	; dawnstarslavery
	PlayerRef.additem(SLV_SexSlaveVol17)
	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Slavery", 0, 40) ;Fame slavery +40
	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Misogyny", 0, 40) ;Misogyny +40

	if MCMMenu.SlaveRenaming
		myScripts.SLV_NextSlaveName(Game.GetPlayer())
	endif
elseif PlayerRef.IsInFaction(zbfFactionSlaver)
	;SLV_MainquestSpecial02
	myScripts.SLV_miniLevelUp()
	
	myScripts.SLV_miniLevelUp()
else
endif

if showmessage
	Debug.MessageBox("Cheat completed")
endif
EndFunction
Actor Property SLV_Jasmin Auto 
Package Property SLV_JasminWalkToCross Auto
Package Property SLV_JasminUseCross Auto	
Actor Property SLV_Julia Auto 
Package Property SLV_JuliaWalkToCross Auto
Package Property SLV_JuliaUseCross Auto
Actor Property SLV_Jane Auto 
Package Property SLV_JaneWalkToCross Auto
Package Property SLV_JaneUseCross Auto



function SLV_CheatMarkarthEnslaved(bool showmessage)
if SLV_quest.getStage() < 4000
	SLV_CheatDawnstarEnslaved(false)
endif

SLV_quest.SetObjectiveCompleted(SLV_quest.getStage())
SLV_quest.SetStage(5000)

if PlayerRef.IsInFaction(zbfFactionSlave)
	SLV_SlaveMiniLevelUP()

	;SLV_MainquestSpecial05
	PlayerRef.additem(SLV_SexSlaveVol18)
	SLV_SlaveMiniLevelUP()
	
	;SLV_CatchingJane2
	PlayerRef.additem(SLV_SexSlaveVol19)
	ActorUtil.ClearPackageOverride(SLV_Ivana)
	SLV_Ivana.evaluatePackage()
	SLV_Ivana.moveto(SLV_Titus)
	ActorUtil.AddPackageOverride(SLV_Ivana, SLV_IvanaUseCross ,100)
	SLV_Ivana.evaluatePackage()
	ActorUtil.AddPackageOverride(SLV_Ivana, SLV_IvanaWalkToCross ,60)
	SLV_Ivana.evaluatePackage()
	
	;SLV_CatchingBlake
	PlayerRef.additem(SLV_SexSlaveVol20)
	SLV_Blake.enable()
	myScripts.SLV_enslavementNPC(SLV_Blake)
	myScripts.SLV_enslavementChains(SLV_Blake)
	ActorUtil.ClearPackageOverride(SLV_Blake)
	SLV_Blake.evaluatePackage()
	ActorUtil.AddPackageOverride(SLV_Blake, SLV_BlakeUseCross ,100)
	SLV_Blake.evaluatePackage()
	ActorUtil.AddPackageOverride(SLV_Blake, SLV_BlakeWalkToCross ,60)
	SLV_Blake.evaluatePackage()
	ActorUtil.ClearPackageOverride(SLV_Diamond)
	SLV_Diamond.evaluatePackage()
	ActorUtil.AddPackageOverride(SLV_Diamond, SLV_DiamondUseCross ,100)
	SLV_Diamond.evaluatePackage()
	ActorUtil.AddPackageOverride(SLV_Diamond, SLV_DiamondWalkToCross ,80)
	SLV_Diamond.evaluatePackage()

	;SLV_CatchingHeike
	PlayerRef.additem(SLV_SexSlaveVol21)
	SLV_Valentina.enable()
	myScripts.SLV_enslavementNPC(SLV_Valentina)
	myScripts.SLV_enslavementChains(SLV_Valentina)
	ActorUtil.ClearPackageOverride(SLV_Valentina)
	SLV_Valentina.evaluatePackage()
	ActorUtil.AddPackageOverride(SLV_Valentina, SLV_ValentinaUseCross ,100)
	SLV_Valentina.evaluatePackage()
	ActorUtil.AddPackageOverride(SLV_Valentina, SLV_ValentinaWalkToCross ,60)
	SLV_Valentina.evaluatePackage()
	
	; markarthslavery
	PlayerRef.additem(SLV_SexSlaveVol22)
	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Slavery", 2, 40) ;Fame slavery +40
	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Misogyny", 2, 40) ;Misogyny +40
	
	
	PlayerRef.AddItem(ChestKey, 1)

	if MCMMenu.SlaveRenaming
		myScripts.SLV_NextSlaveName(Game.GetPlayer())
	endif

	SLV_MainquestSpecial5Quest.reset()
	SLV_MainquestSpecial5Quest.start()
	SLV_MainquestSpecial5Quest.setstage(0)
	SLV_MainquestSpecial5Quest.SetObjectiveCompleted(SLV_MainquestSpecial5Quest.getStage())
	SLV_MainquestSpecial5Quest.setstage(9500)
	SLV_MainquestSpecial5Quest.CompleteQuest()

elseif PlayerRef.IsInFaction(zbfFactionSlaver)
	;SLV_MainquestSpecial05)
	myScripts.SLV_miniLevelUp()

	myScripts.SLV_miniLevelUp()
else
endif

if showmessage
	Debug.MessageBox("Cheat completed")
endif
EndFunction
Key Property ChestKey Auto
Actor Property SLV_Titus Auto
Package Property SLV_IvanaWalkToCross Auto
Package Property SLV_IvanaUseCross Auto
Actor Property SLV_Blake Auto 
Package Property SLV_BlakeWalkToCross Auto
Package Property SLV_BlakeUseCross Auto
Actor Property SLV_Diamond Auto 
Package Property SLV_DiamondWalkToCross Auto
Package Property SLV_DiamondUseCross Auto
Actor Property SLV_Valentina Auto 
Package Property SLV_ValentinaWalkToCross Auto
Package Property SLV_ValentinaUseCross Auto
Quest Property SLV_MainquestSpecial5Quest Auto


function SLV_CheatRiftenEnslaved(bool showmessage)
if SLV_quest.getStage() < 5000
	SLV_CheatMarkarthEnslaved(false)
endif

SLV_quest.SetObjectiveCompleted(SLV_quest.getStage())
SLV_quest.SetStage(6000)

if PlayerRef.IsInFaction(zbfFactionSlave)
	SLV_SlaveMiniLevelUP()

	;SLV_MainquestSpecial08
	PlayerRef.additem(SLV_SexSlaveVol23)
	SLV_SlaveMiniLevelUP()
	
	;SLV_CatchingHeike2
	PlayerRef.additem(SLV_SexSlaveVol24)
	
	;SLV_CatchingEva
	PlayerRef.additem(SLV_SexSlaveVol25)
	SLV_Eva.enable()
	myScripts.SLV_enslavementNPC(SLV_Eva)
	myScripts.SLV_enslavementChains(SLV_Eva)
	ActorUtil.ClearPackageOverride(SLV_Eva)
	SLV_Eva.evaluatePackage()
	ActorUtil.AddPackageOverride(SLV_Eva, SLV_EvaUseCross ,100)
	SLV_Eva.evaluatePackage()
	ActorUtil.AddPackageOverride(SLV_Eva, SLV_EvaWalkToCross ,60)
	SLV_Eva.evaluatePackage()

	; riftenslavery
	PlayerRef.additem(SLV_SexSlaveVol26)
	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Slavery", 4, 40) ;Fame slavery +40
	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Misogyny", 4, 40) ;Misogyny +40

	if MCMMenu.SlaveRenaming
		myScripts.SLV_NextSlaveName(Game.GetPlayer())
	endif
elseif PlayerRef.IsInFaction(zbfFactionSlaver)
	;SLV_MainquestSpecial08)
	myScripts.SLV_miniLevelUp()

	myScripts.SLV_miniLevelUp()
else
	SLV_EnslaveQ.setstage(20)
endif

if showmessage
	Debug.MessageBox("Cheat completed")
endif
EndFunction
Actor Property SLV_Eva Auto 
Package Property SLV_EvaWalkToCross Auto
Package Property SLV_EvaUseCross Auto
Quest Property SLV_EnslaveQ Auto



function SLV_CheatMorthalEnslaved(bool showmessage)
if SLV_quest.getStage() < 6000
	SLV_CheatRiftenEnslaved(false)
endif

SLV_quest.SetObjectiveCompleted(SLV_quest.getStage())
SLV_quest.SetStage(7000)

if PlayerRef.IsInFaction(zbfFactionSlave)
	SLV_SlaveMiniLevelUP()

	;SLV_MainquestSpecial03
	PlayerRef.additem(SLV_SexSlaveVol27)
	SLV_SlaveMiniLevelUP()
	
	;SLV_CatchingHeike3
	PlayerRef.additem(SLV_SexSlaveVol28)
	if !(SLV_SlaveryEnforcementQuest.isRunning() || SLV_SlaveryEnforcementQuest.IsCompleted())
		SLV_SlaveryEnforcementQuest.Reset() 
		SLV_SlaveryEnforcementQuest.Start() 
		SLV_SlaveryEnforcementQuest.SetStage(0)
		SLV_SlaveryEnforcementQuest.SetObjectiveCompleted(SLV_SlaveryEnforcementQuest.getStage())	
		SLV_SlaveryEnforcementQuest.setstage(20000)
		SLV_SlaveryEnforcementQuest.CompleteQuest()
	endif
	
	;SLV_DeadslaveWalking)
	SLV_DeadSlaveWalkingQuest.Reset() 
	SLV_DeadSlaveWalkingQuest.Start() 
	SLV_DeadSlaveWalkingQuest.SetActive(true) 
	SLV_DeadSlaveWalkingQuest.SetStage(0)
	SLV_DeadSlaveWalkingQuest.SetObjectiveCompleted(SLV_DeadSlaveWalkingQuest.getStage())
	SLV_DeadSlaveWalkingQuest.SetStage(2500)

	;SLV_SlaveCertification2
	PlayerRef.additem(SLV_SexSlaveVol29)
	
	; morthalslavery
	PlayerRef.additem(SLV_SexSlaveVol30)
	Abolitionism.Reset()
	Abolitionism.Start() 
	Abolitionism.SetStage(0)
	Abolitionism.SetActive(true)

	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Slavery", 3, 40) ;Fame slavery +40
	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Misogyny", 3, 40) ;Misogyny +40

	if MCMMenu.SlaveRenaming
		myScripts.SLV_NextSlaveName(Game.GetPlayer())
	endif
elseif PlayerRef.IsInFaction(zbfFactionSlaver)
	;SLV_MainquestSpecial03)
	myScripts.SLV_miniLevelUp()
	
	; morthalslavery
	Abolitionism.Reset()
	Abolitionism.Start() 
	Abolitionism.SetStage(300)
	Abolitionism.SetActive(true)
	
	myScripts.SLV_miniLevelUp()
else
endif

if showmessage
	Debug.MessageBox("Cheat completed")
endif
EndFunction
Quest Property SLV_DeadSlaveWalkingQuest Auto
Quest Property Abolitionism Auto
Quest Property SLV_SlaveryEnforcementQuest Auto




function SLV_CheatWinterholdEnslaved(bool showmessage)
if SLV_quest.getStage() < 7000
	SLV_CheatMorthalEnslaved(false)
endif

SLV_quest.SetObjectiveCompleted(SLV_quest.getStage())
SLV_quest.SetStage(8000)

if PlayerRef.IsInFaction(zbfFactionSlave)
	SLV_SlaveMiniLevelUP()

	;SLV_MainquestSpecial06
	PlayerRef.additem(SLV_SexSlaveVol31)
	SLV_SlaveMiniLevelUP()
	
	;SLV_CatchingAva
	PlayerRef.additem(SLV_SexSlaveVol32)
	SLV_Ava.enable()
	myScripts.SLV_enslavementNPC(SLV_Ava)
	myScripts.SLV_enslavementChains(SLV_Ava)
	ActorUtil.ClearPackageOverride(SLV_Ava)
	SLV_Ava.evaluatePackage()
	ActorUtil.AddPackageOverride(SLV_Ava, SLV_AvaUseCross ,100)
	SLV_Ava.evaluatePackage()
	ActorUtil.AddPackageOverride(SLV_Ava, SLV_AvaWalkToCross ,60)
	SLV_Ava.evaluatePackage()
	
	;SLV_MainquestSpecial09
	PlayerRef.additem(SLV_SexSlaveVol33)
	SLV_Maria.enable()
	SLV_MariaSlave.enable()
	schlongs.SLV_SchlongSize(SLV_MariaSlave,19)
	schlongs.SLV_SchlongSize(SLV_MariaSlave,20)
	
	; winterholdslavery
	PlayerRef.additem(SLV_SexSlaveVol34)
	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Slavery", 8, 40) ;Fame slavery +40
	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Misogyny", 8, 40) ;Misogyny +40

	if MCMMenu.SlaveRenaming
		myScripts.SLV_NextSlaveName(Game.GetPlayer())
	endif
	
	SLV_MainquestSpecial6Quest.reset()
	SLV_MainquestSpecial6Quest.start()
	SLV_MainquestSpecial6Quest.setstage(0)
	SLV_MainquestSpecial6Quest.SetObjectiveCompleted(SLV_MainquestSpecial6Quest.getStage())	
	SLV_MainquestSpecial6Quest.setstage(9500)
	SLV_MainquestSpecial6Quest.CompleteQuest()

elseif PlayerRef.IsInFaction(zbfFactionSlaver)
	;SLV_MainquestSpecial06)
	myScripts.SLV_miniLevelUp()
	
	myScripts.SLV_miniLevelUp()
else
endif

if showmessage
	Debug.MessageBox("Cheat completed")
endif
EndFunction
Actor Property SLV_Ava Auto 
Package Property SLV_AvaWalkToCross Auto
Package Property SLV_AvaUseCross Auto
Actor Property SLV_Maria Auto 
Actor Property SLV_MariaSlave Auto 
SLV_SOSSchlong Property schlongs Auto
Quest Property SLV_MainquestSpecial6Quest Auto




function SLV_CheatWindhelmEnslaved(bool showmessage)
if SLV_quest.getStage() < 8000
	SLV_CheatWinterholdEnslaved(false)
endif

SLV_quest.SetObjectiveCompleted(SLV_quest.getStage())
SLV_quest.SetStage(9000)
Thalmor1.enable()

if PlayerRef.IsInFaction(zbfFactionSlave)
	SLV_SlaveMiniLevelUP()

	;SLV_MainquestSpecial04
	PlayerRef.additem(SLV_SexSlaveVol35)
	SLV_SlaveMiniLevelUP()
	
	;SLV_SlaveCertification3
	PlayerRef.additem(SLV_SexSlaveVol36)
	;SLV_SlaveCertification4
	PlayerRef.additem(SLV_SexSlaveVol37)
	
	; windhelmslavery
	PlayerRef.additem(SLV_SexSlaveVol38)
	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Slavery", 0, 40) ;Fame slavery +40
	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Misogyny", 0, 40) ;Misogyny +40

	if MCMMenu.SlaveRenaming
		myScripts.SLV_NextSlaveName(Game.GetPlayer())
	endif
	
	if !SLV_WhiteWedding3Quest.isCompleted()
		SLV_CheatWhiteWedding(false)
	endif
elseif PlayerRef.IsInFaction(zbfFactionSlaver)
	;SLV_MainquestSpecial04
	myScripts.SLV_miniLevelUp()
	
	myScripts.SLV_miniLevelUp()
else
endif

if showmessage
	Debug.MessageBox("Cheat completed")
endif
EndFunction
Actor Property Thalmor1 Auto 


function SLV_CheatSolitudeEnslaved(bool showmessage)
if SLV_quest.getStage() < 9000
	SLV_CheatWindhelmEnslaved(false)
endif

SLV_quest.SetObjectiveCompleted(SLV_quest.getStage())
SLV_quest.SetStage(10000)

if PlayerRef.IsInFaction(zbfFactionSlave)
	SLV_SlaveMiniLevelUP()

	;SLV_MainquestSpecial07
	PlayerRef.additem(SLV_SexSlaveVol39)
	SLV_SlaveMiniLevelUP()
	
	; solitudeslavery
	PlayerRef.additem(SLV_SexSlaveVol40)
	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Slavery", 0, 40) ;Fame slavery +40
	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Misogyny", 0, 40) ;Misogyny +40

	if MCMMenu.SlaveRenaming
		myScripts.SLV_NextSlaveName(Game.GetPlayer())
	endif
elseif PlayerRef.IsInFaction(zbfFactionSlaver)
	;SLV_MainquestSpecial07)
	myScripts.SLV_miniLevelUp()
	
	myScripts.SLV_miniLevelUp()
else
endif

if showmessage
	Debug.MessageBox("Cheat completed")
endif
EndFunction


function SLV_CheatRavenRockEnslaved(bool showmessage)
if SLV_quest.getStage() < 10000
	SLV_CheatSolitudeEnslaved(false)
endif

SLV_quest.SetObjectiveCompleted(SLV_quest.getStage())
SLV_quest.SetStage(11000)

if PlayerRef.IsInFaction(zbfFactionSlave)
	SLV_SlaveMiniLevelUP()

	;SLV_MainquestSpecial10
	PlayerRef.additem(SLV_SexSlaveVol41)
	SLV_SlaveMiniLevelUP()
	
	; raven rock slavery
	PlayerRef.additem(SLV_SexSlaveVol42)
	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Slavery", 0, 40) ;Fame slavery +40
	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Misogyny", 0, 40) ;Misogyny +40

	if MCMMenu.SlaveRenaming
		myScripts.SLV_NextSlaveName(Game.GetPlayer())
	endif
elseif PlayerRef.IsInFaction(zbfFactionSlaver)
	;SLV_MainquestSpecial10)
	myScripts.SLV_miniLevelUp()
	
	myScripts.SLV_miniLevelUp()
else
endif

if showmessage
	Debug.MessageBox("Cheat completed")
endif
EndFunction



function SLV_CheatSkyrimEnslaved(bool showmessage)
if SLV_quest.getStage() < 11000
	SLV_CheatRavenRockEnslaved(false)
endif

if Abolitionism.isRunning()
	Abolitionism.SetStage(11000)
endif

SLV_quest.SetObjectiveCompleted(SLV_quest.getStage())
if PlayerRef.IsInFaction(zbfFactionSlave)
	SLV_quest.SetStage(30000)
elseif PlayerRef.IsInFaction(zbfFactionSlaver)
	SLV_quest.SetStage(29000)
else
	SLV_quest.SetStage(31000)
endif

if showmessage
	Debug.MessageBox("Cheat completed")
endif
EndFunction



function SLV_CheatWhiteWedding(bool showmessage)
SLV_Marcus.enable()
SLV_Abigail.enable()

myScripts.SLV_enslavementNPC(SLV_Abigail)
myScripts.SLV_enslavementChains(SLV_Abigail)

myScripts.SLV_enslavementNPC(SLV_Marcus)
schlongs.SLV_SchlongSize(SLV_Marcus,19)
schlongs.SLV_SchlongSize(SLV_Marcus,20)


SLV_Aden.enable()
SLV_Octavia.enable()
SLV_Raven.enable()

myScripts.SLV_enslavementNPC(SLV_Octavia)
myScripts.SLV_enslavementChains(SLV_Octavia)

ActorUtil.ClearPackageOverride(SLV_Octavia)
SLV_Octavia.evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Octavia, SLV_OctaviaUseCross ,100)
SLV_Octavia.evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Octavia, SLV_OctaviaWalkToCross ,60)
SLV_Octavia.evaluatePackage()

myScripts.SLV_enslavementNPC(SLV_Raven)
myScripts.SLV_enslavementChains(SLV_Raven)

ActorUtil.ClearPackageOverride(SLV_Raven)
SLV_Raven.evaluatePackage()

ActorUtil.AddPackageOverride(SLV_Raven, SLV_RavenUseCross ,100)
SLV_Raven.evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Raven, SLV_RavenWalkToCross ,60)
SLV_Raven.evaluatePackage()

schlongs.SLV_SchlongSize(SLV_Aden,19)
schlongs.SLV_SchlongSize(SLV_Aden,20)

SLV_WhiteWedding3Quest.reset()
SLV_WhiteWedding3Quest.start()
SLV_WhiteWedding3Quest.setstage(0)
SLV_WhiteWedding3Quest.SetObjectiveCompleted(SLV_WhiteWedding3Quest.getStage())
SLV_WhiteWedding3Quest.setstage(10000)
SLV_WhiteWedding3Quest.CompleteQuest()

SLV_Bellamy.setFactionRank(PotentialFollowerFaction,0)
SLV_Bellamy.setFactionRank(CurrentlFollowerFaction ,-1)

PlayerRef.additem(SLV_SexSlaveVol44)
PlayerRef.additem(SLV_SexSlaveVol45)
PlayerRef.additem(SLV_SexSlaveVol46)
	
if showmessage
	Debug.MessageBox("Cheat completed")
endif
EndFunction
Actor Property SLV_Marcus Auto 
Actor Property SLV_Abigail Auto 

Actor Property SLV_Aden Auto
Actor Property SLV_Octavia Auto 
Actor Property SLV_Raven Auto 
Package Property SLV_OctaviaWalkToCross Auto
Package Property SLV_OctaviaUseCross Auto
Package Property SLV_RavenWalkToCross Auto
Package Property SLV_RavenUseCross Auto


Actor Property SLV_Bellamy Auto 
Quest Property SLV_WhiteWedding3Quest Auto
Faction Property PotentialFollowerFaction auto
Faction Property CurrentlFollowerFaction auto

function SLV_SlaveMiniLevelUP()
bool brand = MCMMenu.SkipBranding
MCMMenu.SkipBranding = true
myScripts.SLV_miniLevelUp()
MCMMenu.SkipBranding = brand

EndFunction

Book Property SLV_SexSlaveVol01 Auto
Book Property SLV_SexSlaveVol02 Auto
Book Property SLV_SexSlaveVol03 Auto
Book Property SLV_SexSlaveVol04 Auto
Book Property SLV_SexSlaveVol05 Auto
Book Property SLV_SexSlaveVol06 Auto
Book Property SLV_SexSlaveVol07 Auto
Book Property SLV_SexSlaveVol08 Auto
Book Property SLV_SexSlaveVol09 Auto
Book Property SLV_SexSlaveVol10 Auto

Book Property SLV_SexSlaveVol11 Auto
Book Property SLV_SexSlaveVol12 Auto
Book Property SLV_SexSlaveVol13 Auto
Book Property SLV_SexSlaveVol14 Auto
Book Property SLV_SexSlaveVol15 Auto
Book Property SLV_SexSlaveVol16 Auto
Book Property SLV_SexSlaveVol17 Auto
Book Property SLV_SexSlaveVol18 Auto
Book Property SLV_SexSlaveVol19 Auto
Book Property SLV_SexSlaveVol20 Auto

Book Property SLV_SexSlaveVol21 Auto
Book Property SLV_SexSlaveVol22 Auto
Book Property SLV_SexSlaveVol23 Auto
Book Property SLV_SexSlaveVol24 Auto
Book Property SLV_SexSlaveVol25 Auto
Book Property SLV_SexSlaveVol26 Auto
Book Property SLV_SexSlaveVol27 Auto
Book Property SLV_SexSlaveVol28 Auto
Book Property SLV_SexSlaveVol29 Auto
Book Property SLV_SexSlaveVol30 Auto

Book Property SLV_SexSlaveVol31 Auto
Book Property SLV_SexSlaveVol32 Auto
Book Property SLV_SexSlaveVol33 Auto
Book Property SLV_SexSlaveVol34 Auto
Book Property SLV_SexSlaveVol35 Auto
Book Property SLV_SexSlaveVol36 Auto
Book Property SLV_SexSlaveVol37 Auto
Book Property SLV_SexSlaveVol38 Auto
Book Property SLV_SexSlaveVol39 Auto
Book Property SLV_SexSlaveVol40 Auto

Book Property SLV_SexSlaveVol41 Auto
Book Property SLV_SexSlaveVol42 Auto
Book Property SLV_SexSlaveVol43 Auto
Book Property SLV_SexSlaveVol44 Auto
Book Property SLV_SexSlaveVol45 Auto
Book Property SLV_SexSlaveVol46 Auto
Book Property SLV_SexSlaveVol47 Auto
Book Property SLV_SexSlaveVol48 Auto
Book Property SLV_SexSlaveVol49 Auto
Book Property SLV_SexSlaveVol50 Auto

Book Property SLV_SexSlaveVol51 Auto
Book Property SLV_SexSlaveVol52 Auto
Book Property SLV_SexSlaveVol53 Auto
Book Property SLV_SexSlaveVol54 Auto
Book Property SLV_SexSlaveVol55 Auto
Book Property SLV_SexSlaveVol56 Auto
Book Property SLV_SexSlaveVol57 Auto
Book Property SLV_SexSlaveVol58 Auto
Book Property SLV_SexSlaveVol59 Auto
Book Property SLV_SexSlaveVol60 Auto
