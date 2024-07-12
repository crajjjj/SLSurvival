;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ArenaShow_FreeAnimals Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_ArenaShowQuest.SetObjectiveCompleted(1500)
SLV_ArenaShowQuest.SetStage(9500)

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

if SLV_Animal5 != none
	if SLV_Animal5.getActorRef() != none
		SLV_Animal5.getActorRef().moveto(homesweethome)
	endif
endif
if SLV_Animal6 != none
	if SLV_Animal6.getActorRef() != none
		SLV_Animal6.getActorRef().moveto(homesweethome)
	endif
endif
if SLV_Animal7 != none
	if SLV_Animal7.getActorRef() != none
		SLV_Animal7.getActorRef().moveto(homesweethome)
	endif
endif
if SLV_Animal8 != none
	if SLV_Animal8.getActorRef() != none
		SLV_Animal8.getActorRef().moveto(homesweethome)
	endif
endif
if SLV_Animal9 != none
	if SLV_Animal9.getActorRef() != none
		SLV_Animal9.getActorRef().moveto(homesweethome)
	endif
endif

;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_ArenaShowQuest auto
ReferenceAlias Property SLV_Animal5 Auto
ReferenceAlias Property SLV_Animal6 Auto
ReferenceAlias Property SLV_Animal7 Auto
ReferenceAlias Property SLV_Animal8 Auto
ReferenceAlias Property SLV_Animal9 Auto
ObjectReference Property homesweethome Auto


function prepareAnimal(Actor animalActor)
if animalActor == none
	return
endif
ActorUtil.ClearPackageOverride(animalActor)
animalActor.evaluatePackage()
endfunction
