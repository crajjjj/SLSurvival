;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname _SNtif__0301fdd1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
_SNQuest._SNWaterskinRefillLP.PlayandWait(akSpeaker)
_SNQuest.Refill(_SNQuest.PlayerRef)
Utility.Wait(0.5)
_SNQuest.PlayerRef.RemoveItem(_SNQuest.Gold001, 5 * _SNQuest.RefillableSkins_Total, false, akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SNQuestScript Property _SNQuest Auto
