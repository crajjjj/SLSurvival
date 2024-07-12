;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial10Sex5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_Maven.getActorRef().removeFromFaction(zbfSlaveMaster)

myScripts.SLV_enslavementNPC(SLV_Maven.getActorRef())
myScripts.SLV_enslavementChains(SLV_Maven.getActorRef())
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Maven Auto
Faction Property zbfSlaveMaster Auto


