;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RavenRockTaskNeloth11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if !Game.getplayer().isInFaction(SlaverunSlaverFaction) || (SLV_UseSlaverAsSlave.getValue() == 1)
	myScripts.SLV_SexlabStripNPC(Game.getPlayer())
else
	myScripts.SLV_SexlabStripNPC(SLV_You.getActorRef())
endif

myScripts.SLV_enslavementNPC(SLV_Frea.getActorRef())
myScripts.SLV_enslavementChains(SLV_Frea.getActorRef())
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Frea Auto

GlobalVariable Property SLV_UseSlaverAsSlave auto
ReferenceAlias Property SLV_You Auto
Faction Property SlaverunSlaverFaction Auto


