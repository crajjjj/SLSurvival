;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial8End Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_quest.SetObjectiveCompleted(5250)
SLV_quest.SetStage(5300)

if ThisMenu.SkipScenes
	myScripts.SLV_miniLevelUp()
else
	myScripts.SLV_RewardPlayer(SLV_Zaid, SLV_Brutus)
endif

GetOwningQuest().SetObjectiveCompleted(9500)
GetOwningQuest().SetStage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_MCMMenu Property ThisMenu Auto
Quest Property SLV_quest Auto
ReferenceAlias Property SLV_Zaid Auto 
ReferenceAlias Property SLV_Brutus Auto 