;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingHeike3_Enslave Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
	
myScripts.SLV_enslavementNPC(SLV_Ivana.getActorRef())
myScripts.SLV_enslavementChains(SLV_Ivana.getActorRef())

myScripts.SLV_enslavementNPC(SLV_Valentina.getActorRef())
myScripts.SLV_enslavementChains(SLV_Valentina.getActorRef())
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Ivana Auto
ReferenceAlias Property SLV_Valentina Auto
SLV_Utilities Property myScripts auto