;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecialTask1c Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
GetOwningQuest().SetStage(1550)

SLV_WhiterunCarriageQuest.Reset() 
SLV_WhiterunCarriageQuest.Start() 
SLV_WhiterunCarriageQuest.SetActive(true) 
SLV_WhiterunCarriageQuest.SetStage(0)

myScripts.SLV_IvanaMoodChange(true,1)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_WhiterunCarriageQuest Auto
