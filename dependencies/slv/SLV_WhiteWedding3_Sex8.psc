;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding3_Sex8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_Play2Sex(SLV_Octavia.getActorRef(), SLV_MariaSlave.getActorRef(), "Sex", true)
Utility.wait(2.0)

actor[] sexActors = new actor[5]
sexActors[0] =SLV_Raven.getActorRef()
sexActors[1] = SLV_Pike.getActorRef()
sexActors[2] = SLV_Eric.getActorRef()
sexActors[3] = SLV_Aden.getActorRef()
sexActors[4] = SLV_Murphy.getActorRef()

myScripts.SLV_Gangbang(sexActors)
SLV_SexIsRunning.setvalue(0)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto 
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Pike Auto
ReferenceAlias Property SLV_Eric Auto
ReferenceAlias Property SLV_Murphy Auto
ReferenceAlias Property SLV_MariaSlave Auto


ReferenceAlias Property SLV_Aden Auto
ReferenceAlias Property SLV_Raven Auto
ReferenceAlias Property SLV_Octavia Auto
