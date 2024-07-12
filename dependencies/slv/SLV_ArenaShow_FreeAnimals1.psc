;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ArenaShow_FreeAnimals1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
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

if SLV_Animal1 != none
	SLV_Animal1.getActorRef().moveto(homesweethome2)
endif
if SLV_Animal2 != none
	SLV_Animal2.getActorRef().moveto(homesweethome)
endif
if SLV_Animal3 != none
	SLV_Animal3.getActorRef().moveto(homesweethome)
endif
if SLV_Animal4 != none
	SLV_Animal4.getActorRef().moveto(homesweethome)
endif

;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Animal1 Auto
ReferenceAlias Property SLV_Animal2 Auto
ReferenceAlias Property SLV_Animal3 Auto
ReferenceAlias Property SLV_Animal4 Auto

ObjectReference Property homesweethome Auto
ObjectReference Property homesweethome2 Auto


function prepareAnimal(Actor animalActor)
if animalActor == none
	return
endif
ActorUtil.ClearPackageOverride(animalActor)
animalActor.evaluatePackage()
endfunction
