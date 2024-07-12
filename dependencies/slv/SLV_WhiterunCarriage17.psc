;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiterunCarriage17 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int hasPikeSlave = SLV_UseSlaverAsSlave.getValue() as int

if game.getplayer().IsInFaction(zbfFactionSlaver)
	if MCMMenu.slavefollower
		SLV_UseSlaverAsSlave.setValue(0)
	endif
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property MCMMenu auto
GlobalVariable Property SLV_UseSlaverAsSlave auto

Faction Property zbfFactionSlaver auto
