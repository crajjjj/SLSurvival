;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ArenaFight_End2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_RewardPlayerWithGold()
myScripts.SLV_GetMoreSubmissive(false,3)
fightprogression.SLV_ArenaFightWon()

if SLV_Fighter1 != none
	prepareFighter(SLV_Fighter1.getActorRef())
endif
if SLV_Fighter2 != none
	prepareFighter(SLV_Fighter2.getActorRef())
endif
if SLV_Fighter3 != none
	prepareFighter(SLV_Fighter3.getActorRef())
endif
if SLV_Fighter4 != none
	prepareFighter(SLV_Fighter4.getActorRef())
endif
prepareFighter( SLV_Bones.getActorRef())

GetOwningQuest().SetObjectiveCompleted(2000)
GetOwningQuest().SetStage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ObjectReference Property fighterArea auto
SLV_Utilities Property myScripts auto
SLV_ArenaGladiatorProgression Property fightprogression auto

ReferenceAlias Property SLV_Fighter1 Auto
ReferenceAlias Property SLV_Fighter2 Auto
ReferenceAlias Property SLV_Fighter3 Auto
ReferenceAlias Property SLV_Fighter4 Auto
ReferenceAlias Property SLV_Bones Auto


function prepareFighter(Actor fighterActor)
if fighterActor == none
	return
endif

fighterActor.enable()
fighterActor.moveto(fighterArea)
if fighterActor.isDead()
	fighterActor.resurrect()
endif
fighterActor.moveto(fighterArea)

ActorUtil.ClearPackageOverride(fighterActor)
fighterActor.evaluatePackage()
endfunction
