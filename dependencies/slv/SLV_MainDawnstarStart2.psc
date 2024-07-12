;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainDawnstarStart2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3300)
GetOwningQuest().SetStage(3800)
reviveNPC.resurrectNPC_Dawnstar()

SLV_Dawnstar.Reset() 
SLV_Dawnstar.Start() 
SLV_Dawnstar.SetActive(true) 
SLV_Dawnstar.SetStage(0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_Dawnstar Auto
SLV_ReviveNPC Property reviveNPC auto
