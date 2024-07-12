;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_DeadSlaveWalking12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if SLV_Abolitionismquest.isrunning()
	SLV_Abolitionismquest.FailAllObjectives()
	SLV_Abolitionismquest.SetStage(9500)
endif
if SLV_CelebrateSlaveryquest.isrunning()
	SLV_CelebrateSlaveryquest.FailAllObjectives()
	SLV_CelebrateSlaveryquest.SetStage(9500)
endif

SLV_SlaveryMainquest.SetObjectiveCompleted(SLV_SlaveryMainquest.getStage())
SLV_SlaveryMainquest.SetStage(30000)

;SLV_SlaveryMainquest.CompleteAllObjectives()
;SLV_SlaveryMainquest.CompleteQuest()

StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Slavery", 1, 40) ;Fame slavery +40
StorageUtil.IntListAdjust(None, "SLSF.LocationsFame.NPC.Misogyny", 1, 40) ;Misogyny +40

Utility.wait(2.0)

Debug.messagebox("This is the medium end of Slaverun Reloaded. Thank you for playing.")

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Anal", true)
myScripts.SLV_miniLevelUp()

GetOwningQuest().SetObjectiveCompleted(8000)
GetOwningQuest().SetStage(9500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto

Quest Property SLV_Abolitionismquest Auto
Quest Property SLV_CelebrateSlaveryquest Auto
Quest Property SLV_SlaveryMainquest Auto

