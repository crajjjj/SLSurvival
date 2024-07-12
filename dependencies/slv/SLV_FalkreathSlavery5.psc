;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_FalkreathSlavery5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
GetOwningQuest().SetStage(2500)

if ThisMenu.SkipScenes
	return
endif

myScripts.SLV_BindPlayer()
akSpeaker.additem(zbfCane)
akSpeaker.equipitem(zbfCane)
SendModEvent("dhlp-Suspend")

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

Debug.SendAnimationEvent(Game.getplayer(), "ZazAPCAO263")
Punishment.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property Punishment  Auto 
Weapon Property zbfCane Auto  
SLV_Utilities Property myScripts auto
SlV_MCMMenu Property ThisMenu auto
