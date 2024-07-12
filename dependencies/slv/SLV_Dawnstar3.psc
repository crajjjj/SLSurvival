;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Dawnstar3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_DawnstarTask1.Reset() 
SLV_DawnstarTask1.Start() 
SLV_DawnstarMiningCount.setValue(0)
if !SLV_DawnstarTask1.UpdateCurrentInstanceGlobal(SLV_DawnstarMiningCount )
  Debug.notification("Failed to update SLV_DawnstarMiningCount value for quest")
endif
SLV_DawnstarMiningCount2.setValue(0)
if !SLV_DawnstarTask1.UpdateCurrentInstanceGlobal(SLV_DawnstarMiningCount2)
  Debug.notification("Failed to update SLV_DawnstarMiningCount2 value for quest")
endif
SLV_DawnstarCount.setValue(0)
SLV_DawnstarTask1.SetStage(0)
SLV_DawnstarTask1.SetActive(true)

SLV_DawnstarTask2.Reset() 
SLV_DawnstarTask2.Start() 
SLV_DawnstarSeagullCount.setValue(0)
if !SLV_DawnstarTask2.UpdateCurrentInstanceGlobal(SLV_DawnstarSeagullCount)
  Debug.notification("Failed to update SLV_DawnstarSeagullCount value for quest")
endif
SLV_DawnstarTask2.SetStage(0)
SLV_DawnstarTask2.SetActive(true)

GetOwningQuest().SetObjectiveCompleted(1000)
GetOwningQuest().SetStage(1500)

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_DawnstarTask1 Auto
Quest Property SLV_DawnstarTask2 Auto
GlobalVariable Property SLV_DawnstarMiningCount Auto
GlobalVariable Property SLV_DawnstarMiningCount2 Auto
GlobalVariable Property SLV_DawnstarSeagullCount Auto
GlobalVariable Property SLV_DawnstarCount Auto

