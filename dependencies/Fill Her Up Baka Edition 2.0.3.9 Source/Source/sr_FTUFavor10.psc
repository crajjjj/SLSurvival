;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname sr_FTUFavor10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor pl = Game.GetPlayer()
pl.AddItem(QSTKey, 1)
pl.AddToFaction(QSTFaction)
pl.SetFactionRank(QSTFaction, 10)
pumpEnabler.Enable()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Key Property QSTKey Auto
Faction Property QSTFaction Auto
ObjectReference Property pumpEnabler Auto
