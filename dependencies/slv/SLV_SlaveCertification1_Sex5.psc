;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveCertification1_Sex5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_PlaySex3Synchron(SLV_Ivana.getActorRef(), SLV_Nazeem.getActorRef(), SLV_Amren.getActorRef(), "FMM", true)
SLV_SexIsRunning.setvalue(0)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto 
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Ivana Auto
ReferenceAlias Property SLV_Amren Auto
ReferenceAlias Property SLV_Nazeem Auto

