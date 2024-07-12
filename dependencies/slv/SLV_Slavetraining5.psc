;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Slavetraining5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(300)
GetOwningQuest().SetStage(350)

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

SLV_EnslavementQuest.Reset() 
SLV_EnslavementQuest.Start() 
SLV_EnslavementQuest.SetStage(0)
SLV_EnslavementQuest.SetActive(true)

if SLV_WeightMode.getvalue() == 1
	SLV_BabyGotBoobsQuest.Reset() 
	SLV_BabyGotBoobsQuest.Start() 
	SLV_BabyGotBoobsQuest.SetStage(0)
endif

;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_EnslavementQuest Auto

Quest Property SLV_BabyGotBoobsQuest Auto
GlobalVariable Property SLV_WeightMode Auto
