;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ArenaFightRezzing2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor fighter = SLV_Fighter1.getActorRef()
ReanimateCorpse.RemoteCast(akSpeaker, fighter, fighter)
Utility.wait(1.0)
ReanimateCorpse.RemoteCast(akSpeaker, fighter, fighter)
Utility.wait(1.0)

if SLV_Fighter2 != none
	fighter = SLV_Fighter2.getActorRef()
endif
ReanimateCorpse.RemoteCast(akSpeaker, fighter, fighter)
Utility.wait(1.0)
ReanimateCorpse.RemoteCast(akSpeaker, fighter, fighter)
Utility.wait(1.0)

if SLV_Fighter3 != none
	fighter = SLV_Fighter3.getActorRef()
endif
ReanimateCorpse.RemoteCast(akSpeaker, fighter, fighter)
Utility.wait(1.0)
ReanimateCorpse.RemoteCast(akSpeaker, fighter, fighter)

if SLV_Fighter4 != none
	fighter = SLV_Fighter4.getActorRef()
endif
ReanimateCorpse.RemoteCast(akSpeaker, fighter, fighter)
Utility.wait(1.0)
ReanimateCorpse.RemoteCast(akSpeaker, fighter, fighter)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Spell Property ReanimateCorpse Auto 
ReferenceAlias Property SLV_Fighter1 Auto
ReferenceAlias Property SLV_Fighter2 Auto
ReferenceAlias Property SLV_Fighter3 Auto
ReferenceAlias Property SLV_Fighter4 Auto

