;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainWinterholdStart Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(7500)
GetOwningQuest().SetStage(7800)

SLV_Winterhold.Reset() 
SLV_Winterhold.Start() 
SLV_Winterhold.SetActive(true) 
SLV_Winterhold.SetStage(0)

myScripts.SLV_IvanaMoodChange(true,1) 
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_Winterhold Auto
