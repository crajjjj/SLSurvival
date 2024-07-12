;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial6Dog Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

if Game.getplayer().isinfaction(zbfFactionSlave)
	myScripts.SLV_Play2Sex(Game.GetPlayer(),Dog1.getActorRef(), "Anal", true)
elseif MCMMenu.slavefollower
	myScripts.SLV_Play2Sex(MCMMenu.slavefollower,Dog1.getActorRef(), "Anal", true)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property Dog1 Auto 
SLV_MCMMenu Property MCMMenu Auto
Faction Property zbfFactionSlave Auto