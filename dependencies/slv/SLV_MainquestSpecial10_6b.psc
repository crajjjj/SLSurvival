;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial10_6b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
GetOwningQuest().SetStage(2500)

myScripts.SLV_PikeMoodChange(true,1)
myScripts.SLV_BrutusMoodChange(true,1)
myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Anal", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto