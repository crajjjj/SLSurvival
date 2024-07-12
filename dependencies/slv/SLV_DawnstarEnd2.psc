;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_DawnstarEnd2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_quest.SetObjectiveCompleted(3800)
SLV_quest.SetStage(4000)

StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Slavery", 0, 40) ;Fame slavery +40
StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Misogyny", 0, 40) ;Misogyny +40

if ThisMenu.SlaveRenaming
	myScripts.SLV_NextSlaveName(Game.GetPlayer())
	Debug.MessageBox("Your slave name is now " + Game.GetPlayer().GetActorbase().getName())
endif

Utility.wait(2.0)
;myScripts.SLV_miniLevelUp()
myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Boobjob", true)

GetOwningQuest().SetObjectiveCompleted(3000)
GetOwningQuest().SetStage(3500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SlV_MCMMenu Property ThisMenu auto
Quest Property SLV_quest Auto

