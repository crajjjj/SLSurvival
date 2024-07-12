Scriptname SLV_ArenaFightTimer extends Quest  

Function StartArenaTimer()
RegisterForSingleUpdateGameTime(0.2) ; 6m
EndFunction 

Event OnUpdateGameTime()
;debug.notification("Arena Timer")

if  SLV_ArenaFightQuest.getStage() == 1500 && !game.getPlayer().IsGhost()

	if SLV_StopEnforcer.getValue() > 0
		myScripts.SLV_DisplayInformation("Player is already in scene, setting new arenafighttimer")
		RegisterForSingleUpdateGameTime(0.1) ; 6m
		return
	endif

	int counter =  countFighter(false)
	int fightmode = SLV_ColosseumFightMode.getValue() as int

	if fightmode == 0 || fightmode == 2
		myScripts.SLV_DisplayUser("Your enemy tries to throw you on the ground...")
		Utility.wait(2.0)
	
		int playscene = Utility.RandomInt(1,100)		
		if playscene <= MCMMenu.arenaRapeProbabilty
			myScripts.SLV_DisplayUser("...and succeeded...the audience get freaked out as your opponent starts to rape you.")

			if SLV_ArenaFightQuest.getStage() != 1500 || game.getPlayer().IsGhost()
				return
			endif

			counter =  countFighter(true)
			myScripts.SLV_DisplayInformation("Arena rape counter: " + counter)
			if counter == 1
				myScripts.SLV_DisplayInformation("Starting arena rape scene")
				myScripts.SLV_PlayScene(SLV_RapeScene )
			elseif counter > 1
				myScripts.SLV_DisplayInformation("Starting arena gangbang scene")
				myScripts.SLV_PlayScene(SLV_GangbangScene )
			endif
		else 
			myScripts.SLV_DisplayUser("... but failed.")
			tearArmor()
		endif
	else
		tearArmor()
	endif
	
	;int doAmputation = Utility.RandomInt(1,100)		
	;if doAmputation <= MCMMenu.arenaAmputationProbabilty
	;	myScripts.SLV_DisplayUser("You notice that your opponent cut off a limb from your body!")
	;	Amputee.SLV_ProgressiveAmputeeActor(PlayerRef )
	;endif

	myScripts.SLV_DisplayInformation("Setting new arenafighttimer")
	RegisterForSingleUpdateGameTime(0.2) ; 6m
endif
endEvent

SLV_Amputee Property Amputee Auto

SLV_Utilities Property myScripts auto
Quest Property SLV_ArenaFightQuest Auto
ReferenceAlias Property SLV_Fighter1 Auto 
ReferenceAlias Property SLV_Fighter2 Auto 
ReferenceAlias Property SLV_Fighter3 Auto 
ReferenceAlias Property SLV_Fighter4 Auto 

GlobalVariable Property SLV_ColosseumFightMode Auto 
GlobalVariable Property SLV_StopEnforcer  Auto  

Scene Property SLV_RapeScene auto
Scene Property SLV_GangbangScene auto
SLV_MCMMenu Property MCMMenu Auto

function tearArmor()
int tearArmor = Utility.RandomInt(1,100)		
if tearArmor <= MCMMenu.arenaArmorRemoveProbabilty
	myScripts.SLV_ProgressiveUnequip(PlayerRef,Aggressor  )
endif
endfunction

int function countFighter(bool pacify)
int result = 0

if  SLV_Fighter1 != none
	if SLV_Fighter1.getActorRef() != none
		if !SLV_Fighter1.getActorRef().isDead()  && SLV_Fighter1.getActorRef() != PlayerRef
			result = result + 1
	
			if pacify
				SLV_Fighter1.getActorRef().stopCombat()
			endif
			Aggressor = SLV_Fighter1.getActorRef()
			myScripts.SLV_DisplayInformation("Arena Agressor = fighter1 ")
		endif
	endif
endif
if  SLV_Fighter2 != none
	if SLV_Fighter2.getActorRef() != none
		if !SLV_Fighter2.getActorRef().isDead() && SLV_Fighter2.getActorRef() != PlayerRef
			result = result + 1

			if pacify
				SLV_Fighter2.getActorRef().stopCombat()
			endif

			Aggressor = SLV_Fighter2.getActorRef()
		endif
	endif
endif
if  SLV_Fighter3 != none
	if SLV_Fighter3.getActorRef() != none
		if !SLV_Fighter3.getActorRef().isDead() && SLV_Fighter3.getActorRef() != PlayerRef
			result = result + 1

			if pacify
				SLV_Fighter3.getActorRef().stopCombat()
			endif

			Aggressor = SLV_Fighter3.getActorRef()
		endif
	endif
endif
if  SLV_Fighter4 != none
	if SLV_Fighter4.getActorRef() != none
		if !SLV_Fighter4.getActorRef().isDead() && SLV_Fighter4.getActorRef() != PlayerRef
			result = result + 1

			if pacify
				SLV_Fighter4.getActorRef().stopCombat()
			endif

			Aggressor = SLV_Fighter4.getActorRef()
		endif
	endif
endif

myScripts.SLV_DisplayInformation("ArenaFighttimer found " + result + " fighter")

return result
endfunction

Actor Aggressor = none
Actor Property PlayerRef Auto
