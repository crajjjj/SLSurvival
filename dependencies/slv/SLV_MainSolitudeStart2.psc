;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainSolitudeStart2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(9300)
GetOwningQuest().SetStage(9800)
reviveNPC.resurrectNPC_Solitude()

SLV_Solitude.Reset() 
SLV_Solitude.Start() 
SLV_Solitude.SetActive(true) 
SLV_Solitude.SetStage(0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_Solitude Auto
SLV_ReviveNPC Property reviveNPC auto
