;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveTraining1_Sex2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_PlaySex2Synchron(akSpeaker,  SLV_Bellamy.getActorRef() ,"Sex", true)

slv_sexisrunning.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto 
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Bellamy Auto