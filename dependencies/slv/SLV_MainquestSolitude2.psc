;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSolitude2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;if SLV_AbolitionismQuest.isrunning()
;	SLV_AbolitionismQuest.setStage(11000)
;endif

GetOwningQuest().SetObjectiveCompleted(11000)
GetOwningQuest().SetStage(12000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_AbolitionismQuest Auto
