;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainMarkarthStart Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4600)
GetOwningQuest().SetStage(4800)
reviveNPC.resurrectNPC_Markarth()

SLV_Markarth.Reset() 
SLV_Markarth.Start() 
SLV_Markarth.SetActive(true) 
SLV_Markarth.SetStage(0)

myScripts.SLV_IvanaMoodChange(true,1) 
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_Markarth Auto
SLV_ReviveNPC Property reviveNPC auto
