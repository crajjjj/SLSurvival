;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_FalkreathSlaveryDone Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_quest.SetObjectiveCompleted(2800)
SLV_quest.SetStage(3000)

StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Slavery", 1, 40) ;Fame slavery +40
StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Misogyny", 1, 40) ;Misogyny +40

if ThisMenu.SlaveRenaming
	myScripts.SLV_NextSlaveName(Game.GetPlayer())
	Debug.MessageBox("Your slave name is now " + Game.GetPlayer().GetActorbase().getName())
endif

Utility.wait(2.0)

;myScripts.SLV_miniLevelUp()
myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Blowjob", true)

GetOwningQuest().SetObjectiveCompleted(5500)
GetOwningQuest().SetStage(6000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SlV_MCMMenu Property ThisMenu auto
Quest Property SLV_quest Auto
