;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_FalkreathSolaf4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
getowningquest().setstage(2000)

if ThisMenu.SkipScenes
	return
endif

myScripts.SLV_SexlabStripNPC(Game.GetPlayer())

akSpeaker.addItem(Whip)
SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
Debug.SendAnimationEvent(Game.getplayer(), "ZazAPCAO263")
SolafPunishment.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SlV_MCMMenu Property ThisMenu auto
Scene Property SolafPunishment  Auto  
Weapon Property Whip Auto
SLV_Utilities Property myScripts auto