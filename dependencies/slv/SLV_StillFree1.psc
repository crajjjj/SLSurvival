;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname SLV_StillFree1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_5
Function Fragment_5(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().RemoveItem(Gold, 1000)
Game.GetPlayer().AddItem(ChestKey, 1)
GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(100)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
MiscObject Property Gold Auto  
Key Property ChestKey Auto  

