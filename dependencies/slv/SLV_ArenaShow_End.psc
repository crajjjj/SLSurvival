;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ArenaShow_End Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_RewardPlayerWithGold()
beastProgression.SLV_ArenaShowDone()

if SLV_Animal1 != none
	prepareAnimal(SLV_Animal1.getActorRef())
endif
if SLV_Animal2 != none
	prepareAnimal(SLV_Animal2.getActorRef())
endif
if SLV_Animal3 != none
	prepareAnimal(SLV_Animal3.getActorRef())
endif
if SLV_Animal4 != none
	prepareAnimal(SLV_Animal4.getActorRef())
endif
if SLV_Animal5 != none
	prepareAnimal(SLV_Animal5.getActorRef())
endif
if SLV_Animal6 != none
	prepareAnimal(SLV_Animal6.getActorRef())
endif
if SLV_Animal7 != none
	prepareAnimal(SLV_Animal7.getActorRef())
endif
if SLV_Animal8 != none
	prepareAnimal(SLV_Animal8.getActorRef())
endif
if SLV_Animal9 != none
	prepareAnimal(SLV_Animal9.getActorRef())
endif

GetOwningQuest().SetObjectiveCompleted(9500)
GetOwningQuest().SetStage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ObjectReference Property animalArea auto
SLV_ArenaBeastLoverProgression property beastProgression auto

ReferenceAlias Property SLV_Animal1 Auto
ReferenceAlias Property SLV_Animal2 Auto
ReferenceAlias Property SLV_Animal3 Auto
ReferenceAlias Property SLV_Animal4 Auto
ReferenceAlias Property SLV_Animal5 Auto
ReferenceAlias Property SLV_Animal6 Auto
ReferenceAlias Property SLV_Animal7 Auto
ReferenceAlias Property SLV_Animal8 Auto
ReferenceAlias Property SLV_Animal9 Auto

function prepareAnimal(Actor animalActor)
if animalActor == none
	return
endif

;animalActor.enable()
animalActor.moveto(animalArea )

ActorUtil.ClearPackageOverride(animalActor)
animalActor.evaluatePackage()
endfunction
