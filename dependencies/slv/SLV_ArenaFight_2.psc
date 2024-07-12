;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ArenaFight_2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
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
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_DoNothing Auto
ObjectReference Property arenaEnter auto

ReferenceAlias Property SLV_Fighter1 Auto
ReferenceAlias Property SLV_Fighter2 Auto
ReferenceAlias Property SLV_Fighter3 Auto
ReferenceAlias Property SLV_Fighter4 Auto

function prepareFighter(Actor fighterActor)
;fighterActor.enable()
if fighterActor == none
	return
endif

fighterActor.moveto(arenaEnter )

ActorUtil.AddPackageOverride(fighterActor, SLV_DoNothing ,100)
fighterActor.evaluatePackage()

if SLV_ColosseumFightMode.getValue() == 0  || SLV_ColosseumFightMode.getValue() == 1
	fighterActor.getActorBase().SetEssential(false)
else
	fighterActor.getActorBase().SetEssential(true)
endif

endfunction
GlobalVariable Property SLV_ColosseumFightMode auto