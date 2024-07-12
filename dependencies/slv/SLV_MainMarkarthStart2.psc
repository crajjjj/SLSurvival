;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainMarkarthStart2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4300)
GetOwningQuest().SetStage(4800)
reviveNPC.resurrectNPC_Markarth()

SLV_Markarth.Reset() 
SLV_Markarth.Start() 
SLV_Markarth.SetActive(true) 
SLV_Markarth.SetStage(0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_Markarth Auto
SLV_ReviveNPC Property reviveNPC auto