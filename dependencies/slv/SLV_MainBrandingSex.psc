;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainBrandingSex Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if SLV_GangbangTraining.IsCompleted()
	actor[] sexActors = new actor[5]
	sexActors[0] =Game.getplayer()
	sexActors[1] = akSpeaker
	sexActors[2] = SLV_Slaver2.getActorRef()
	sexActors[3] = SLV_Igor.getActorRef()
	sexActors[4] = SLV_Titus.getActorRef()

	myScripts.SLV_Gangbang(sexActors)
else
	myScripts.SLV_PlaySex3Synchron(Game.GetPlayer(),akSpeaker,SLV_Slaver2.getActorRef(), "MMF", true)
endif
SLV_SexIsRunning.setvalue(0)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_SexIsRunning Auto
ReferenceAlias Property SLV_Slaver2 Auto
ReferenceAlias Property SLV_Igor Auto
ReferenceAlias Property SLV_Titus Auto

Quest Property SLV_GangbangTraining Auto

