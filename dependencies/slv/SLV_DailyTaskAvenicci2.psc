;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_DailyTaskAvenicci2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_WhiterunTask.Reset() 
SLV_WhiterunTask.Start() 
SLV_WhiterunTask.SetActive(true) 
SLV_WhiterunTask.SetStage(0)

myScripts.SLV_GetMoreSubmissive(true,1)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_WhiterunTask Auto
