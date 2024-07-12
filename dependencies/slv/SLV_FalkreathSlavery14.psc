;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_FalkreathSlavery14 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
GetOwningQuest().SetStage(2500)

if ThisMenu.SkipScenes
	return
endif

Game.getplayer().additem(zbfCane)
SendModEvent("dhlp-Suspend") 

myScripts.SLV_SexlabStripNPC(akSpeaker)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

Punishment.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property Punishment  Auto 
Weapon Property zbfCane Auto  
SLV_MCMMenu Property ThisMenu auto
SLV_Utilities Property myScripts auto
