;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_DeadSlaveWalking9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(6000)
if SLV_CelebrateSlaveryQuest.IsRunning()
	GetOwningQuest().SetStage(7000)
else
	GetOwningQuest().SetStage(6500)
endif

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Boobjob", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_CelebrateSlaveryQuest Auto 
