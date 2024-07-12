;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColdharbourTransform Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(9000)
getowningquest().setstage(9500)

;Game.getplayer().RemoveSpell(DLC1VampireChange)
;Game.getplayer().AddSpell(DLC1VampireChange)
;Game.getplayer().RemovePerk(DLC1VampireTurnPerk)			
;Game.getplayer().AddPerk(DLC1VampireTurnPerk)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Perk Property DLC1VampireTurnPerk Auto
Spell Property DLC1VampireChange Auto 