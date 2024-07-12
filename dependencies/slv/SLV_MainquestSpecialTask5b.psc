;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecialTask5b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(6200)
GetOwningQuest().SetStage(6250)
reviveNPC.resurrectNPC_MainquestSpecial3()

SLV_WhiterunSpecialQuest.Reset() 
SLV_WhiterunSpecialQuest.Start() 
SLV_WhiterunSpecialQuest.SetActive(true) 
SLV_WhiterunSpecialQuest.SetStage(0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_WhiterunSpecialQuest Auto
SLV_ReviveNPC Property reviveNPC auto