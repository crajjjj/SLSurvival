;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingHeike3_End Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if SLV_Main.getStage() == 6350
	SLV_Main.SetObjectiveCompleted(6350)
	SLV_Main.SetStage(6400)
endif

;SLV_AmputeePlayer.setValue(0)
;Amputee.SLV_AmputeeActor(Game.GetPlayer(),0)

SLV_SlaveryEnforcementQuest.SetObjectiveCompleted(9500)
SLV_SlaveryEnforcementQuest.SetStage(10000)

GetOwningQuest().SetObjectiveCompleted(9500)

if SLV_Main.getStage() == 6400
	getowningquest().setstage(10000)
else	
	getowningquest().setstage(9800)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Amputee Property Amputee Auto
GlobalVariable Property SLV_AmputeePlayer Auto
Quest Property SLV_SlaveryEnforcementQuest Auto
Quest Property SLV_Main Auto
