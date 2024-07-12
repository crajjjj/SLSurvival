;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining1_11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4500)
getowningquest().setstage(5000)

if MCMMenu.StoryMode ||  !MCMMenu.StoryMode 
	myScripts.SLV_PlayScene(PunishScene)
else
	myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker,"Blowjob", true)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property PunishScene  Auto
SLV_Utilities Property myScripts auto
SLV_MCMMenu Property MCMMenu Auto
