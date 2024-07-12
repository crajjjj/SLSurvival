;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_EnslavePC3b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1000)
GetOwningQuest().SetStage(1500)

SLV_PlayerIsVirgin.setValue(1)

if MCMMenu.skipScenes || (!MCMMenu.StoryMode)
	myScripts.SLV_Play2SexAnimation(Game.getplayer(), akSpeaker ,"FunnyBizness Necro Kissing","Vaginal,Sex", true)
else
	myScripts.SLV_PlayScene(PunishScene)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property PunishScene  Auto
SLV_Utilities Property myScripts auto
SLV_MCMMenu Property MCMMenu Auto
GlobalVariable Property SLV_PlayerIsVirgin Auto

