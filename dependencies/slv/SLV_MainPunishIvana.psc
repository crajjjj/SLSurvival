;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainPunishIvana Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_IvanaMoodChange(false,1) 

if ThisMenu.SkipScenes
	return
endif

SLV_You.getActorRef().moveto(Game.GetPlayer())

SLV_Slaver.ForceRefTo(akSpeaker)
;Debug.notification("New Slaver= " + akSpeaker.getActorBase().getName())

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

if SLV_Ivana.getActorRef().getCurrentLocation().IsSameLocation(Game.getplayer().getCurrentLocation())
	BeatScene.start()
else
	PunishScene.ForceStart()
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property BeatScene  Auto  
SLV_MCMMenu Property ThisMenu auto
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_You Auto
ReferenceAlias Property SLV_Ivana Auto

Scene Property PunishScene  Auto
ReferenceAlias Property SLV_Slaver Auto
