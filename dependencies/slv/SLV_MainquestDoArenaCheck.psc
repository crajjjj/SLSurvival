;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestDoArenaCheck Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if MCMMenu.arenaHama && SLV_Gladiator0101HamaQuest.isCompleted()
	arenaCheck.isHamaEnabled = true
else
	arenaCheck.isHamaEnabled = false
endif
if MCMMenu.arenaDomonkos && SLV_Gladiator0102DomonkosQuest.isCompleted()
	arenaCheck.isDomonkosEnabled = true
else
	arenaCheck.isDomonkosEnabled = false
endif
if MCMMenu.arenaBandon && SLV_Gladiator0103BandonQuest.isCompleted()
	arenaCheck.isBandonEnabled = true
else
	arenaCheck.isBandonEnabled = false
endif



if MCMMenu.arenaHaldir && SLV_Gladiator0201HaldirQuest.isCompleted()
	arenaCheck.isHaldirEnabled = true
else
	arenaCheck.isHaldirEnabled = false
endif
if MCMMenu.arenaCalum && SLV_Gladiator0202CalumQuest.isCompleted()
	arenaCheck.isCalumEnabled = true
else
	arenaCheck.isCalumEnabled = false
endif
if MCMMenu.arenaAllanon && SLV_Gladiator0203AllanonQuest.isCompleted()
	arenaCheck.isAllanonEnabled = true
else
	arenaCheck.isAllanonEnabled = false
endif



if MCMMenu.arenaArtus && SLV_Gladiator0301ArtusQuest.isCompleted()
	arenaCheck.isArtusEnabled = true
else
	arenaCheck.isArtusEnabled = false
endif
if MCMMenu.arenaDesmond && SLV_Gladiator0302DesmondQuest.isCompleted()
	arenaCheck.isDesmondEnabled = true
else
	arenaCheck.isDesmondEnabled = false
endif
if MCMMenu.arenaAkiro && SLV_Gladiator0303AkiroQuest.isCompleted()
	arenaCheck.isAkiroEnabled = true
else
	arenaCheck.isAkiroEnabled = false
endif



if MCMMenu.arenaAzogtheOrc && SLV_Gladiator0401AzogQuest.isCompleted()
	arenaCheck.isAzogEnabled = true
else
	arenaCheck.isAzogEnabled = false
endif
if MCMMenu.arenaHannibal && SLV_Gladiator0402HannibalQuest.isCompleted()
	arenaCheck.isHannibalEnabled = true
else
	arenaCheck.isHannibalEnabled = false
endif



if MCMMenu.arenaMaximus && SLV_Gladiator0501MaximusQuest.isCompleted()
	arenaCheck.isMaximusEnabled = true
else
	arenaCheck.isMaximusEnabled = false
endif
if MCMMenu.arenaDopperfield && SLV_Gladiator0502DopperfieldQuest.isCompleted()
	arenaCheck.isDopperfieldEnabled = true
else
	arenaCheck.isDopperfieldEnabled = false
endif



if MCMMenu.arenaDastan && SLV_Gladiator0601DastanQuest.isCompleted()
	arenaCheck.isDastanEnabled = true
else
	arenaCheck.isDastanEnabled = false
endif
if MCMMenu.arenaMoudini && SLV_Gladiator0602MoudiniQuest.isCompleted()
	arenaCheck.isMoudiniEnabled = true
else
	arenaCheck.isMoudiniEnabled = false
endif


if MCMMenu.arenaCalar && SLV_Gladiator0701CalarQuest.isCompleted()
	arenaCheck.isCalarEnabled = true
else
	arenaCheck.isCalarEnabled = false
endif
if MCMMenu.arenaArno && SLV_Gladiator0702ArnoQuest.isCompleted()
	arenaCheck.isArnoEnabled = true
else
	arenaCheck.isArnoEnabled = false
endif



if MCMMenu.arenaMerlin && SLV_Gladiator0802MerlinQuest.isCompleted()
	arenaCheck.isMerlinEnabled = true
else
	arenaCheck.isMerlinEnabled = false
endif
if MCMMenu.arenaConan && SLV_Gladiator0801ConanQuest.isCompleted()
	arenaCheck.isConanEnabled = true
else
	arenaCheck.isConanEnabled = false
endif
if MCMMenu.arenaTwoTails && SLV_Gladiator0901TwotailsQuest.isCompleted()
	arenaCheck.isTwoTailsEnabled = true
else
	arenaCheck.isTwoTailsEnabled = false
endif






if MCMMenu.arenaDog
	arenaCheck.isDogEnabled = true
else
	arenaCheck.isDogEnabled = false
endif
if MCMMenu.arenaCow
	arenaCheck.isCowEnabled = true
else
	arenaCheck.isCowEnabled = false
endif
if MCMMenu.arenaChicken
	arenaCheck.isChickenEnabled = true
else
	arenaCheck.isChickenEnabled = false
endif
if MCMMenu.arenaGoat
	arenaCheck.isGoatEnabled = true
else
	arenaCheck.isGoatEnabled = false
endif


if MCMMenu.arenaHorse
	arenaCheck.isHorseEnabled = true
else
	arenaCheck.isHorseEnabled = false
endif
if MCMMenu.arenaSkeever
	arenaCheck.isSkeeverEnabled = true
else
	arenaCheck.isSkeeverEnabled = false
endif
if MCMMenu.arenaDeer
	arenaCheck.isDeerEnabled = true
else
	arenaCheck.isDeerEnabled = false
endif
if MCMMenu.arenaBoar
	arenaCheck.isBoarEnabled = true
else
	arenaCheck.isBoarEnabled = false
endif


if MCMMenu.arenaSpider
	arenaCheck.isSpiderEnabled = true
else
	arenaCheck.isSpiderEnabled = false
endif
if MCMMenu.arenaSkeleton
	arenaCheck.isSkeletonEnabled = true
else
	arenaCheck.isSkeletonEnabled = false
endif
if MCMMenu.arenaDraugr
	arenaCheck.isDraugrEnabled = true
else
	arenaCheck.isDraugrEnabled = false
endif
if MCMMenu.arenaFalmer
	arenaCheck.isFalmerEnabled = true
else
	arenaCheck.isFalmerEnabled = false
endif



if MCMMenu.arenaRiekling
	arenaCheck.isRieklingEnabled = true
else
	arenaCheck.isRieklingEnabled = false
endif
if MCMMenu.arenaLargeSpider
	arenaCheck.isLargeSpiderEnabled = true
else
	arenaCheck.isLargeSpiderEnabled = false
endif
if MCMMenu.arenaWolf
	arenaCheck.isWolfEnabled = true
else
	arenaCheck.isWolfEnabled = false
endif
if MCMMenu.arenaChaurus
	arenaCheck.isChaurusEnabled = true
else
	arenaCheck.isChaurusEnabled = false
endif
if MCMMenu.arenaDwarvenSpider
	arenaCheck.isDwarvenSpiderEnabled = true
else
	arenaCheck.isDwarvenSpiderEnabled = false
endif



if MCMMenu.arenaBear
	arenaCheck.isBearEnabled = true
else
	arenaCheck.isBearEnabled = false
endif
if MCMMenu.arenaSabrecat
	arenaCheck.isSabrecatEnabled = true
else
	arenaCheck.isSabrecatEnabled = false
endif
if MCMMenu.arenaTroll
	arenaCheck.isTrollEnabled = true
else
	arenaCheck.isTrollEnabled = false
endif
if MCMMenu.arenaHorker
	arenaCheck.isHorkerEnabled = true
else
	arenaCheck.isHorkerEnabled = false
endif
if MCMMenu.arenaNetch
	arenaCheck.isNetchEnabled = true
else
	arenaCheck.isNetchEnabled = false
endif
if MCMMenu.arenaDwarvenSphere
	arenaCheck.isDwarvenSphereEnabled = true
else
	arenaCheck.isDwarvenSphereEnabled = false
endif
if MCMMenu.arenaChaurusHunter
	arenaCheck.isChaurusHunterEnabled = true
else
	arenaCheck.isChaurusHunterEnabled = false
endif



if MCMMenu.arenaDeathHound
	arenaCheck.isDeathHoundEnabled = true
else
	arenaCheck.isDeathHoundEnabled = false
endif
if MCMMenu.arenaFrostAtronach
	arenaCheck.isFrostAtronachEnabled = true
else
	arenaCheck.isFrostAtronachEnabled = false
endif
if MCMMenu.arenaGargoyle
	arenaCheck.isGargoyleEnabled = true
else
	arenaCheck.isGargoyleEnabled = false
endif
if MCMMenu.arenaChaurusReaper
	arenaCheck.isChaurusReaperEnabled = true
else
	arenaCheck.isChaurusReaperEnabled = false
endif
if MCMMenu.arenaDwarvenBallista
	arenaCheck.isDwarvenBallistaEnabled = true
else
	arenaCheck.isDwarvenBallistaEnabled = false
endif
if MCMMenu.arenaBoarRiekling
	arenaCheck.isBoarRieklingEnabled = true
else
	arenaCheck.isBoarRieklingEnabled = false
endif



if MCMMenu.arenaMammoth
	arenaCheck.isMammothEnabled = true
else
	arenaCheck.isMammothEnabled = false
endif
if MCMMenu.arenaSeeker
	arenaCheck.isSeekerEnabled = true
else
	arenaCheck.isSeekerEnabled = false
endif
if MCMMenu.arenaSpiderGiant
	arenaCheck.isSpiderGiantEnabled = true
else
	arenaCheck.isSpiderGiantEnabled = false
endif
if MCMMenu.arenaDwarvenCenturion
	arenaCheck.isDwarvenCenturionEnabled = true
else
	arenaCheck.isDwarvenCenturionEnabled = false
endif



if MCMMenu.arenaDragonPriest
	arenaCheck.isDragonPriestEnabled = true
else
	arenaCheck.isDragonPriestEnabled = false
endif
if MCMMenu.arenaVampireLord
	arenaCheck.isVampireLordEnabled = true
else
	arenaCheck.isVampireLordEnabled = false
endif
if MCMMenu.arenaWerewolf
	arenaCheck.isWerewolfEnabled = true
else
	arenaCheck.isWerewolfEnabled = false
endif
if MCMMenu.arenaGiant
	arenaCheck.isGiantEnabled = true
else
	arenaCheck.isGiantEnabled = false
endif
if MCMMenu.arenaLurker
	arenaCheck.isLurkerEnabled = true
else
	arenaCheck.isLurkerEnabled = false
endif



if MCMMenu.arenaDragon
	arenaCheck.isDragonEnabled = true
else
	arenaCheck.isDragonEnabled = false
endif

;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property MCMMenu Auto
SLV_ArenaOpponentCheck Property arenaCheck Auto

Quest Property SLV_Gladiator0101HamaQuest Auto
Quest Property SLV_Gladiator0102DomonkosQuest Auto
Quest Property SLV_Gladiator0103BandonQuest Auto

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