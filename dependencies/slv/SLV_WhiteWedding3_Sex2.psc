;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding3_Sex2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
actor[] sexActors1 = new actor[2]
sexActors1[0] = SLV_Octavia.getActorRef()
sexActors1[1] = SLV_Murphy.getActorRef()
myScripts.SLV_PlaySexAnimation(sexActors1, "Leito Blowjob", "Blowjob", true)
;myScripts.SLV_Play2Sex(SLV_Octavia.getActorRef(), SLV_Murphy.getActorRef(), "Blowjob", true)

;Utility.wait(3.0)

actor[] sexActors2 = new actor[2]
sexActors2[0] = SLV_Raven.getActorRef()
sexActors2[1] = SLV_JarlWhiterun.getActorRef()
myScripts.SLV_PlaySexAnimation(sexActors2 , "Leito Blowjob", "Blowjob", true)
;myScripts.SLV_Play2Sex(SLV_Raven.getActorRef(), SLV_JarlWhiterun.getActorRef(), "Blowjob", true)
Utility.wait(3.0)

actor[] sexActors = new actor[2]
sexActors[0] = Game.getplayer()
sexActors[1] = SLV_Bellamy.getActorRef()
myScripts.SLV_PlaySexAnimationSynchron(sexActors , "Leito Blowjob", "Blowjob", true)
;myScripts.SLV_PlaySex2Synchron(Game.getplayer(), SLV_Bellamy.getActorRef(), "Blowjob", true)
SLV_SexIsRunning.setvalue(0)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto 
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Raven Auto
ReferenceAlias Property SLV_Octavia Auto
ReferenceAlias Property SLV_Bellamy Auto
ReferenceAlias Property SLV_Murphy Auto
ReferenceAlias Property SLV_JarlWhiterun Auto
