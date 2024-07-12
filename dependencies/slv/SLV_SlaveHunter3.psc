;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveHunter3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2000)
GetOwningQuest().SetStage(2500)

;startingtimer.StartSlaveHunterWalkTimer()

if SLV_StoryMode.getValue() != 0
	myScripts.SLV_PlayScene(PunishScene)
else	
	myScripts.SLV_PlayScene(WalkingScene)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property ThisMenu auto
SLV_Utilities Property myScripts auto
Scene Property PunishScene  Auto 

SLV_SlaveHunter_Timer Property startingtimer auto


GlobalVariable Property SLV_StoryMode Auto 
Scene Property WalkingScene  Auto 



