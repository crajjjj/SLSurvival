;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_MainQuestMan1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;debug.messagebox("Slaver questline is disabled for this beta version!")
;return

GetOwningQuest().SetObjectiveCompleted(250)
GetOwningQuest().SetStage(1050)

Game.GetPlayer().AddToFaction(zbfFactionSlaver) 
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Faction Property zbfFactionSlaver auto
