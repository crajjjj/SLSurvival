;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJane_BrutusSex1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_PlaySex3Synchron( SLV_Jane.getActorRef(),SLV_Brutus.getActorRef(),Game.GetPlayer(), "Sex", true)
SLV_SexIsRunning.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_SexIsRunning Auto 
ReferenceAlias Property SLV_Jane Auto 
ReferenceAlias Property SLV_Brutus Auto 
