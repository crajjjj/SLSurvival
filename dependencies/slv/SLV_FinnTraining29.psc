;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_FinnTraining29 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetStage(5200)

finnTimer.StartFinnTrainingTimer()
myScripts.SLV_GetMoreSubmissive(true,1)

akSpeaker.removefromFaction(SLV_NoEnforcer )
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_FinnTraining_Timer Property finnTimer Auto

Faction Property SLV_NoEnforcer Auto
