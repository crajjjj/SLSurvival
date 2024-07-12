;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Mainquest_MaleRecruiting Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1050)
GetOwningQuest().SetStage(1200)
Game.GetPlayer().AddToFaction(SLV_SlaverFaction)
Game.GetPlayer().AddToFaction(zbf_FactionSlaver)
Game.GetPlayer().RemoveFromFaction(zbfSlaveMasterFaction)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Faction Property SLV_SlaverFaction auto
Faction Property zbf_FactionSlaver auto

Faction Property zbfSlaveMasterFaction auto