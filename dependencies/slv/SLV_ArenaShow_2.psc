;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ArenaShow_2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if SLV_Animal1 != none
	prepareAnimal(SLV_Animal1.getActorRef(), true)
endif
if SLV_Animal2 != none
	prepareAnimal(SLV_Animal2.getActorRef(), true)
endif
if SLV_Animal3 != none
	prepareAnimal(SLV_Animal3.getActorRef(), true)
endif
if SLV_Animal4 != none
	prepareAnimal(SLV_Animal4.getActorRef(), true)
endif
if SLV_Animal5 != none
	prepareAnimal(SLV_Animal5.getActorRef(), false)
endif
if SLV_Animal6 != none
	prepareAnimal(SLV_Animal6.getActorRef(), false)
endif
if SLV_Animal7 != none
	prepareAnimal(SLV_Animal7.getActorRef(), false)
endif
if SLV_Animal8 != none
	prepareAnimal(SLV_Animal8.getActorRef(), false)
endif
if SLV_Animal9 != none
	prepareAnimal(SLV_Animal9.getActorRef(), false)
endif

;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_DoNothing Auto
ObjectReference Property arenaEnter auto
ObjectReference Property arenaEnter2 auto

ReferenceAlias Property SLV_Animal1 Auto
ReferenceAlias Property SLV_Animal2 Auto
ReferenceAlias Property SLV_Animal3 Auto
ReferenceAlias Property SLV_Animal4 Auto
ReferenceAlias Property SLV_Animal5 Auto
ReferenceAlias Property SLV_Animal6 Auto
ReferenceAlias Property SLV_Animal7 Auto
ReferenceAlias Property SLV_Animal8 Auto
ReferenceAlias Property SLV_Animal9 Auto

function prepareAnimal(Actor animalActor, bool firsthalf)
if animalActor == none
	return
endif
if firsthalf
	animalActor.moveto(arenaEnter )
else	
	animalActor.moveto(arenaEnter2 )
endif

ActorUtil.AddPackageOverride(animalActor, SLV_DoNothing ,100)
animalActor.evaluatePackage()

if firsthalf
	animalActor.moveto(arenaEnter )
else	
	animalActor.moveto(arenaEnter2 )
endif

endfunction