;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainWhipSex2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_Play2Sex(SLV_Ivana.getActorRef(), akSpeaker,  "Anal", true)

myScripts.SLV_Play2Sex(Game.GetPlayer(), SLV_Zaid.getActorRef(),  "Anal", true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
ReferenceAlias Property SLV_Ivana Auto
ReferenceAlias Property SLV_Zaid Auto



