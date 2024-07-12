;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainWindhelmStart Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(8500)
GetOwningQuest().SetStage(8800) 

reviveNPC.resurrectNPC_Windhelm()
SLV_Windhelm.Reset() 
SLV_Windhelm.Start() 
SLV_Windhelm.SetActive(true) 
SLV_Windhelm.SetStage(0)

myScripts.SLV_IvanaMoodChange(true,1) 
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_Windhelm Auto
SLV_ReviveNPC Property reviveNPC auto
