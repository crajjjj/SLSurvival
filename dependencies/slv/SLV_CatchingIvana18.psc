;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingIvana18 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2800)
GetOwningQuest().SetStage(3000)

if !MCMMenu.storymode
	myScripts.SLV_Play3Sex(Game.getplayer(),akSpeaker,SLV_Murphy.getActorRef(), "Sex, anal, vaginal", true)
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
ReferenceAlias Property SLV_Murphy Auto
