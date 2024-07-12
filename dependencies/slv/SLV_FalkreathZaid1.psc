;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_FalkreathZaid1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
if Game.getplayer().isInFaction(zbfFactionSlaver )
	getowningquest().setstage(500)
else
	getowningquest().setstage(250)
endif

SLV_FalkreathGuardCount.setvalue(0)
Game.GetPlayer().AddItem(Gold, 10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
MiscObject Property Gold  Auto
GlobalVariable Property SLV_FalkreathGuardCount  Auto  
Faction Property zbfFactionSlaver Auto