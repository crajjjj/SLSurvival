;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiverwoodLucan5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(500)
if Game.getplayer().isInFaction(zbfFactionSlaver )
	getowningquest().setstage(2500)
else
	getowningquest().setstage(1000)
endif
Slave02.enable()
Slave02.moveto(Game.GetPlayer())

ActorUtil.AddPackageOverride(Slave02 , SLV_FollowPlayer,100)
Slave02.evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor Property Slave02 Auto
Package Property SLV_FollowPlayer Auto
Faction Property zbfFactionSlaver Auto
