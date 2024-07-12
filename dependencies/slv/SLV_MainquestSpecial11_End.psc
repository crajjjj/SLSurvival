;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial11_End Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if SLV_quest.getStage() == 2250
	SLV_quest.SetObjectiveCompleted(2250)
	SLV_quest.SetStage(2300)
endif

Game.getplayer().additem(SLV_SexSlaveVol08.getReference())

if ThisMenu.SkipScenes
	myScripts.SLV_miniLevelUp()
else
	myScripts.SLV_RewardPlayer(SLV_Pike , SLV_Bellamy)
endif

GetOwningQuest().SetObjectiveCompleted(9000)

if SLV_quest.getStage() == 2300
	GetOwningQuest().SetStage(10000)
else
	GetOwningQuest().SetStage(9500)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_MCMMenu Property ThisMenu Auto
Quest Property SLV_quest Auto
ReferenceAlias Property SLV_Pike Auto 
ReferenceAlias Property SLV_Bellamy Auto 
ReferenceAlias Property SLV_SexSlaveVol08 Auto
