;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiverwoodSlavery8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_quest.SetObjectiveCompleted(1800)
SLV_quest.SetStage(2000)

StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Slavery", 12, 40) ;Fame slavery +40
StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Misogyny", 12, 40) ;Misogyny +40

if ThisMenu.SlaveRenaming
	myScripts.SLV_NextSlaveName(Game.GetPlayer())
	Debug.MessageBox("Your slave name is now " + Game.GetPlayer().GetActorbase().getName())
endif

Game.getplayer().additem(SLV_SexSlaveVol07.getReference())

Utility.wait(2.0)
;myScripts.SLV_miniLevelUp()
myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker,"Vaginal", true)

GetOwningQuest().SetObjectiveCompleted(3500)
GetOwningQuest().SetStage(4000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
Quest Property SLV_quest Auto
SLV_MCMMenu Property ThisMenu auto
ReferenceAlias Property SLV_SexSlaveVol07 Auto

 
