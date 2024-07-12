;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingAva_End Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if SLV_Main.getStage() == 7350
	SLV_Main.SetObjectiveCompleted(7350)
	SLV_Main.SetStage(7400)
endif

SLV_SlaveryEnforcementQuest.SetObjectiveCompleted(10500)
SLV_SlaveryEnforcementQuest.SetStage(11000)

GetOwningQuest().SetObjectiveCompleted(9500)
if SLV_Main.getStage() == 7400
	getowningquest().setstage(10000)
else	
	getowningquest().setstage(9800)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_SlaveryEnforcementQuest Auto
Quest Property SLV_Main Auto

