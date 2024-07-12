;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Abolitionism8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4500)

if Game.getPlayer().isInFaction(zbfFactionSlave ) || Game.getPlayer().isInFaction(zbfFactionSlaver ) 
	GetOwningQuest().SetStage(5000)
else
	GetOwningQuest().SetStage(5200)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Faction  Property zbfFactionSlave Auto
Faction  Property zbfFactionSlaver Auto

