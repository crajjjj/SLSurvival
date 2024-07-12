;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJulia15 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5500)
getowningquest().setstage(6000)

myScripts.SLV_enslavementNPC(SLV_Julia.getActorRef())
myScripts.SLV_enslavementChains(SLV_Julia.getActorRef())

if ThisMenu.SkipScenes
	return
endif
SLV_You.getActorRef().moveto(Game.GetPlayer())

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
BeatScene.start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_You Auto
Scene Property BeatScene  Auto  
SLV_MCMMenu Property ThisMenu auto
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Julia Auto
