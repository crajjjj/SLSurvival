;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ArenaFight_Sex1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

Actor fighter1
if !SLV_Fighter1.getActorRef().IsDead()
	fighter1 = SLV_Fighter1.getActorRef()
endif
Actor fighter2
if SLV_Fighter2
	if SLV_Fighter2.getActorRef() != none
		if !SLV_Fighter2.getActorRef().IsDead()
			fighter2 = SLV_Fighter2.getActorRef()
		endif
	endif
endif

if fighter1 && fighter2
	myScripts.SLV_PlaySex3Synchron(PlayerRef ,  fighter1, fighter2 ,"Sex", true)
elseif fighter1
	myScripts.SLV_PlaySex2AnimationSynchron(PlayerRef ,  fighter1 ,"FunnyBizness Necro Tit Ass Rub" , "Anal", true)
	;myScripts.SLV_PlaySex2Synchron(PlayerRef ,  fighter1 ,"Anal", true)
elseif fighter2
	myScripts.SLV_PlaySex2AnimationSynchron(PlayerRef ,  fighter2 ,"FunnyBizness Molag Anal Rapes","Anal", true)
endif

SLV_SexIsRunning.setvalue(0)
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
myScripts.SLV_DisplayInformation("Arenafight rape is over")

Utility.wait(1.0)

int doAmputation = Utility.RandomInt(1,100)		
if doAmputation <= MCMMenu.arenaAmputationProbabilty
	myScripts.SLV_DisplayUser("You notice that your opponent cut off a limb from your body!")
	Amputee.SLV_ProgressiveAmputeeActor(PlayerRef )
endif

;int tearArmor = Utility.RandomInt(1,100)		
;if tearArmor <= MCMMenu.arenaArmorRemoveProbabilty
;	myScripts.SLV_ProgressiveUnequip(PlayerRef, akSpeaker  )
;endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto 
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Fighter1 Auto
ReferenceAlias Property SLV_Fighter2 Auto

SLV_Amputee Property Amputee Auto
SLV_MCMMenu Property MCMMenu Auto
Actor Property PlayerRef Auto



