;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainQuest_7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if GetOwningQuest().getStage() ==5300
	GetOwningQuest().SetObjectiveCompleted(5300)
	GetOwningQuest().SetStage(5350)
endif

SLV_Catching.Reset() 
SLV_Catching.Start() 
SLV_Catching.SetActive(true) 
SLV_Catching.SetStage(0)

SLV_SlaveryEnforcementQuest.SetObjectiveCompleted(7000)
SLV_SlaveryEnforcementQuest.SetStage(7500)

myScripts.SLV_IvanaMoodChange(true,1) 
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_SlaveryEnforcementQuest Auto
Quest Property SLV_Catching Auto
