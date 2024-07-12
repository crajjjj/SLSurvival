;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial11_Sex9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
actor[] sexActors = new actor[1]
sexActors[0] = akSpeaker
myScripts.SLV_PlaySex(sexActors,"M,Masturbation,Standing", false)

actor[] sexActors1 = new actor[1]
sexActors1[0] = SLV_Tourist1.getActorRef()
myScripts.SLV_PlaySex(sexActors1,"M,Masturbation,Standing", false)

actor[] sexActors2 = new actor[1]
sexActors2[0] = SLV_Tourist2.getActorRef()
myScripts.SLV_PlaySex(sexActors2,"M,Masturbation,Standing", false)

actor[] sexActors3 = new actor[1]
sexActors3[0] = SLV_Tourist3.getActorRef()
myScripts.SLV_PlaySex(sexActors3,"M,Masturbation,Standing", false)

actor[] sexActors4 = new actor[1]
sexActors4[0] = SLV_Tourist4.getActorRef()
myScripts.SLV_PlaySex(sexActors4,"M,Masturbation,Standing", false)

actor[] sexActors5 = new actor[1]
sexActors5[0] = SLV_Tourist5.getActorRef()
myScripts.SLV_PlaySex(sexActors5,"M,Masturbation,Standing", false)

actor[] sexActors6 = new actor[1]
sexActors6[0] = SLV_Tourist6.getActorRef()
myScripts.SLV_PlaySexSynchron(sexActors6,"M,Masturbation,Standing", false)
SLV_SexIsRunning.setvalue(0)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

Actor player = Game.getplayer()
myScripts.SLV_FullCumShot(player)
myScripts.SLV_FullCumShot(player)
myScripts.SLV_FullCumShot(player)
myScripts.SLV_FullCumShot(player)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_SexIsRunning Auto 
ReferenceAlias Property SLV_Tourist1 Auto
ReferenceAlias Property SLV_Tourist2 Auto
ReferenceAlias Property SLV_Tourist3 Auto
ReferenceAlias Property SLV_Tourist4 Auto
ReferenceAlias Property SLV_Tourist5 Auto
ReferenceAlias Property SLV_Tourist6 Auto



