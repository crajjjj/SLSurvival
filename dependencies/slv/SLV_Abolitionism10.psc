;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Abolitionism10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_Thalmor.getActorRef().resurrect()
SLV_Thalmor.getActorRef().moveto(TrapDoor )
SLV_Thalmor.getActorRef().disable()

SLV_Draemora.getActorRef().resurrect()
SLV_Draemora.getActorRef().moveto(TrapDoor )
SLV_Draemora.getActorRef().disable()


if SLV_DeadSlaveWalkingquest.isrunning()
	SLV_DeadSlaveWalkingquest.CompleteAllObjectives()
	SLV_DeadSlaveWalkingquest.SetStage(9000)
endif
if SLV_CelebrateSlaveryquest.isrunning()
	SLV_CelebrateSlaveryquest.FailAllObjectives()
	SLV_CelebrateSlaveryquest.SetStage(9000)
endif

TrapDoor.disable()
Game.GetPlayer().AddItem(Gold, 5000)

Debug.messagebox("This is the good end of Slaverun Reloaded. Thank you for playing.")


if ThisMenu.SleepingSlavery
	sendModEvent("SlaverunReloaded_ResetSlavery")
else
	sendModEvent("SlaverunReloaded_EndEnslavement")
endif
GetOwningQuest().SetObjectiveCompleted(6500)
GetOwningQuest().SetStage(9000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_DeadSlaveWalkingquest Auto
Quest Property SLV_CelebrateSlaveryquest Auto
MiscObject Property Gold  Auto  
SLV_MCMMenu Property ThisMenu auto
ObjectReference Property TrapDoor Auto

ReferenceAlias Property SLV_Thalmor Auto
ReferenceAlias Property SLV_Draemora Auto

