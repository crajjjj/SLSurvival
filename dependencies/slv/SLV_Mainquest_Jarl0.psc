;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Mainquest_Jarl0 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if GetOwningQuest().getstage() == 0
	GetOwningQuest().SetObjectiveCompleted(0)
endif
if GetOwningQuest().getstage() == 10
	GetOwningQuest().SetObjectiveCompleted(10)
endif
GetOwningQuest().SetStage(50)

Game.getplayer().removefromfaction(SlaverunSlaveFaction)
Game.getplayer().removefromfaction(SlaverunSlaverFaction)
Game.getplayer().removefromfaction(SlaverunSlaverMasterFaction)

SLV_WhiterunTasksDone.setValue(0)
SLV_ArenaFightsWon.setValue(0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Faction Property SlaverunSlaveFaction auto
Faction Property SlaverunSlaverFaction auto
Faction Property SlaverunSlaverMasterFaction auto

GlobalVariable Property SLV_WhiterunTasksDone Auto 
GlobalVariable Property SLV_ArenaFightsWon Auto 


