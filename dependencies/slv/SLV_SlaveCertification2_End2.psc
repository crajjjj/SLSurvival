;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveCertification2_End2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_miniLevelUp()
headshaving.NextProgressiveSlaveTats(game.getplayer())

;SLV_SlaveryEnforcementQuest.SetObjectiveCompleted(9500)
;SLV_SlaveryEnforcementQuest.SetStage(10000)

GetOwningQuest().SetObjectiveCompleted(9800)
getowningquest().setstage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_SlaveryEnforcementQuest Auto
SLV_Utilities Property myScripts auto
SLV_HeadShaving Property headshaving auto
