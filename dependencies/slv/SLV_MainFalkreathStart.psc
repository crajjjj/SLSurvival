;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainFalkreathStart Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2600)
GetOwningQuest().SetStage(2800)
reviveNPC.resurrectNPC_Falkreath()

SLV_Falkreath.Reset() 
SLV_Falkreath.Start() 
SLV_Falkreath.SetActive(true) 
SLV_Falkreath.SetStage(0)

myScripts.SLV_IvanaMoodChange(true,1) 
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_Falkreath Auto
SLV_ReviveNPC Property reviveNPC auto