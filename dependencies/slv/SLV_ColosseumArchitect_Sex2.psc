;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumArchitect_Sex2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_enslavementNPC(SLV_MinerSlave1.getActorRef())

myScripts.SLV_enslavementNPC(SLV_MinerSlave2.getActorRef())
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_MinerSlave1 Auto 
ReferenceAlias Property SLV_MinerSlave2 Auto 

