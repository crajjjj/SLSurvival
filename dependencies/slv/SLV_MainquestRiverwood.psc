;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestRiverwood Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1600)
GetOwningQuest().SetStage(1800)

reviveNPC.resurrectNPC_Riverwood()

SLV_Riverwood.Reset() 
SLV_Riverwood.Start() 
SLV_Riverwood.SetActive(true) 
SLV_Riverwood.SetStage(0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_Riverwood Auto
SLV_ReviveNPC Property reviveNPC auto