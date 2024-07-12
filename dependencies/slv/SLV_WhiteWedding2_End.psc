;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding2_End Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
reviveNPC.resurrectNPC_Wedding()

SLV_WhiteWedding3Quest.Reset() 
SLV_WhiteWedding3Quest.Start() 
SLV_WhiteWedding3Quest.SetStage(0)
SLV_WhiteWedding3Quest.SetActive(true)

GetOwningQuest().SetObjectiveCompleted(9500)
GetOwningQuest().SetStage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_ReviveNPC Property reviveNPC auto
Quest Property SLV_WhiteWedding3Quest Auto
