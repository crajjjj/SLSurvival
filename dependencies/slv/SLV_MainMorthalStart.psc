;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainMorthalStart Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(6600)
GetOwningQuest().SetStage(6800)
reviveNPC.resurrectNPC_Morthal()

SLV_Morthal.Reset() 
SLV_Morthal.Start() 
SLV_Morthal.SetActive(true) 
SLV_Morthal.SetStage(0)

SLV_AmputeePlayer.setValue(0)
Amputee.SLV_AmputeeActor(Game.GetPlayer(),0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Amputee Property Amputee Auto
GlobalVariable Property SLV_AmputeePlayer Auto
Quest Property SLV_Morthal Auto
SLV_ReviveNPC Property reviveNPC auto