;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestCaesarFightGroup3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_ArenaFightTask.Reset() 
SLV_ArenaFightTask.Start() 
SLV_ArenaFightTask.SetActive(true) 
SLV_ArenaFightTask.SetStage(0)

SLV_Fighter1.Clear()
SLV_Fighter2.Clear()
SLV_Fighter3.Clear()
SLV_Fighter4.Clear()

Actor[] gladiators  = new actor[19]
int fightersfound = 0

if arenaCheck.isHamaEnabled
	gladiators[fightersfound] = SLV_ArenaHama
	fightersfound = fightersfound + 1
endif
if arenaCheck.isDomonkosEnabled
	gladiators[fightersfound] = SLV_ArenaDomonkos
	fightersfound = fightersfound + 1
endif
if arenaCheck.isBandonEnabled
	gladiators[fightersfound] = SLV_ArenaBandon
	fightersfound = fightersfound + 1
endif

if arenaCheck.isHaldirEnabled
	gladiators[fightersfound] = SLV_ArenaHaldir
	fightersfound = fightersfound + 1
endif
if arenaCheck.isCalumEnabled
	gladiators[fightersfound] = SLV_ArenaCalum
	fightersfound = fightersfound + 1
endif
if arenaCheck.isAllanonEnabled
	gladiators[fightersfound] = SLV_ArenaAllanon
	fightersfound = fightersfound + 1
endif

if arenaCheck.isArtusEnabled
	gladiators[fightersfound] = SLV_ArenaArtus
	fightersfound = fightersfound + 1
endif
if arenaCheck.isDesmondEnabled
	gladiators[fightersfound] = SLV_ArenaDesmond
	fightersfound = fightersfound + 1
endif
if arenaCheck.isAkiroEnabled
	gladiators[fightersfound] = SLV_ArenaAkiro
	fightersfound = fightersfound + 1
endif

if arenaCheck.isAzogEnabled
	gladiators[fightersfound] = SLV_ArenaAzog 
	fightersfound = fightersfound + 1
endif
if arenaCheck.isHannibalEnabled
	gladiators[fightersfound] = SLV_ArenaHannibal 
	fightersfound = fightersfound + 1
endif

if arenaCheck.isMaximusEnabled
	gladiators[fightersfound] = SLV_ArenaMaximus 
	fightersfound = fightersfound + 1
endif
if arenaCheck.isDopperfieldEnabled
	gladiators[fightersfound] = SLV_ArenaDopperfield 
	fightersfound = fightersfound + 1
endif

if arenaCheck.isDastanEnabled
	gladiators[fightersfound] = SLV_ArenaDastan 
	fightersfound = fightersfound + 1
endif
if arenaCheck.isMoudiniEnabled
	gladiators[fightersfound] = SLV_ArenaMoudini 
	fightersfound = fightersfound + 1
endif

if arenaCheck.isCalarEnabled
	gladiators[fightersfound] = SLV_ArenaCalar 
	fightersfound = fightersfound + 1
endif
if arenaCheck.isArnoEnabled
	gladiators[fightersfound] = SLV_ArenaArno
	fightersfound = fightersfound + 1
endif

if SLV_ArenaGladiatorQuest.getstage() >= 4000
	if arenaCheck.isConanEnabled
		gladiators[fightersfound] = SLV_ArenaConan 
		fightersfound = fightersfound + 1
	endif
	if arenaCheck.isMerlinEnabled
		gladiators[fightersfound] = SLV_ArenaMerlin
		fightersfound = fightersfound + 1
	endif
endif
fightersfound = fightersfound - 1 
myScripts.slv_displayinformation("fightersfound:" + fightersfound)

int firstfighter = Utility.RandomInt(0,fightersfound)
SLV_Fighter1.ForceRefTo(gladiators[firstfighter])
myScripts.slv_displayinformation("firstfighter:" + firstfighter)

int secondfighter = firstfighter
if fightersfound > 0
	while secondfighter == firstfighter
		secondfighter = Utility.RandomInt(0,fightersfound)
		myScripts.slv_displayinformation("secondfighter:" + secondfighter)
	endwhile
	SLV_Fighter2.ForceRefTo(gladiators[secondfighter])
endif
int thirdfighter = firstfighter
if fightersfound > 1
	while thirdfighter == firstfighter || thirdfighter == secondfighter 
		thirdfighter = Utility.RandomInt(0,fightersfound)
		myScripts.slv_displayinformation("thirdfighter:" + thirdfighter)
	endwhile
	SLV_Fighter3.ForceRefTo(gladiators[thirdfighter])
endif
int fourthfighter = firstfighter
if fightersfound > 2
	while fourthfighter == firstfighter || fourthfighter == secondfighter  || fourthfighter == thirdfighter 
		fourthfighter = Utility.RandomInt(0,fightersfound)
		myScripts.slv_displayinformation("fourthfighter:" + fourthfighter)
	endwhile
	SLV_Fighter4.ForceRefTo(gladiators[fourthfighter ])
endif

SLV_ColosseumGladiator.setValue(0)
SLV_ColosseumGladiatorsNumber.setValue(4)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_ColosseumGladiatorsNumber Auto
SLV_ArenaOpponentCheck Property arenaCheck Auto
Quest Property SLV_ArenaFightTask Auto
Quest Property SLV_ArenaGladiatorQuest Auto

Actor Property SLV_ArenaHama Auto
Actor Property SLV_ArenaDomonkos Auto
Actor Property SLV_ArenaBandon Auto

Actor Property SLV_ArenaHaldir Auto
Actor Property SLV_ArenaCalum Auto
Actor Property SLV_ArenaAllanon Auto

Actor Property SLV_ArenaArtus Auto
Actor Property SLV_ArenaDesmond Auto
Actor Property SLV_ArenaAkiro Auto

Actor Property SLV_ArenaAzog Auto
Actor Property SLV_ArenaHannibal Auto

Actor Property SLV_ArenaMaximus Auto
Actor Property SLV_ArenaDopperfield Auto

Actor Property SLV_ArenaDastan Auto
Actor Property SLV_ArenaMoudini Auto

Actor Property SLV_ArenaCalar Auto
Actor Property SLV_ArenaArno Auto

Actor Property SLV_ArenaConan Auto
Actor Property SLV_ArenaMerlin Auto

ReferenceAlias Property SLV_Fighter1 Auto
ReferenceAlias Property SLV_Fighter2 Auto
ReferenceAlias Property SLV_Fighter3 Auto
ReferenceAlias Property SLV_Fighter4 Auto
Faction Property SLV_ColosseumNPCLost Auto

GlobalVariable Property SLV_ColosseumGladiator Auto
