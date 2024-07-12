;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MorthalEnd Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_quest.SetObjectiveCompleted(6800)
SLV_quest.SetStage(7000)

StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Slavery", 3, 40) ;Fame slavery +40
StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Misogyny", 3, 40) ;Misogyny +40

if ThisMenu.SlaveRenaming
	myScripts.SLV_NextSlaveName(Game.GetPlayer())
	Debug.MessageBox("Your slave name is now " + Game.GetPlayer().GetActorbase().getName())
endif

;myScripts.SLV_miniLevelUp()

GetOwningQuest().SetObjectiveCompleted(9000)
GetOwningQuest().SetStage(9500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_MCMMenu Property ThisMenu auto
Quest Property SLV_quest Auto
