;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingHeike2_Sex2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_Play2Sex(akSpeaker, SLV_Brutus.getActorRef(), "Anal", true)

Utility.wait(2.0)
myScripts.SLV_PlaySex2Synchron(SLV_Ivana.getActorRef(), SLV_Sven.getActorRef(), "Anal", true)
SLV_SexIsRunning.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_SexIsRunning Auto 
ReferenceAlias Property SLV_Brutus Auto
ReferenceAlias Property SLV_Sven Auto
ReferenceAlias Property SLV_Ivana Auto


