;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_FalkreathSlavery26 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3000)
GetOwningQuest().SetStage(3500)

Game.GetPlayer().RemoveItem(Gold, 10000)
SLV_FalkreathTask1.Start() 
SLV_FalkreathTask1.SetStage(0)
SLV_FalkreathTask1.SetActive(true)

SLV_FalkreathTask2.Start() 
SLV_FalkreathTask2.SetStage(0)
SLV_FalkreathTask2.SetActive(true)

SLV_FalkreathTask3.Start() 
SLV_FalkreathTask3.SetStage(0)
SLV_FalkreathTask3.SetActive(true)

myScripts.SLV_Play2Sex(akSpeaker ,MCMMenu.malefollower , "Sex", false)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_MCMMenu Property MCMMenu Auto

Quest Property SLV_FalkreathTask1 Auto
Quest Property SLV_FalkreathTask2 Auto
Quest Property SLV_FalkreathTask3 Auto

MiscObject Property Gold  Auto 
