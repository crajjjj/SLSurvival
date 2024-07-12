;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial9_Sex10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_Play2Sex(SLV_Diamond.getActorRef(),SLV_Maria.getActorRef(), "Anal", true)
Utility.wait(2.0)

myScripts.SLV_PlaySex2Synchron(SLV_Ivana.getActorRef(),akSpeaker, "Anal", true)
SLV_SexIsRunning.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_SexIsRunning Auto 
ReferenceAlias Property SLV_Ivana Auto
ReferenceAlias Property SLV_Diamond Auto
ReferenceAlias Property SLV_Maria Auto


