;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WindhelmEnd Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_quest.SetObjectiveCompleted(8800)
SLV_quest.SetStage(9000)

if ThisMenu.SlaveRenaming
	myScripts.SLV_NextSlaveName(Game.GetPlayer())
	Debug.MessageBox("Your slave name is now " + Game.GetPlayer().GetActorbase().getName())
endif

Utility.wait(2.0)
myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Blowjob", true)

;myScripts.SLV_miniLevelUp()

GetOwningQuest().SetObjectiveCompleted(9000)
GetOwningQuest().SetStage(9500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SlV_MCMMenu Property ThisMenu auto
Quest Property SLV_quest Auto
