;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding1_Enslave Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_enslavementNPC(SLV_Abigail.getActorRef())
myScripts.SLV_enslavementChains(SLV_Abigail.getActorRef())

myScripts.SLV_enslavementNPC(SLV_Marcus.getActorRef())
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_SexIsRunning Auto 
ReferenceAlias Property SLV_Marcus Auto
ReferenceAlias Property SLV_Abigail Auto