;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestMorthal Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(7000)
GetOwningQuest().SetStage(7100)

SLV_DeadSlave.SetObjectiveCompleted(2000)
SLV_DeadSlave.SetStage(2500)

if ThisMenu.SkipScenes
	myScripts.SLV_miniLevelUp()
	return
endif

myScripts.SLV_RewardPlayer(SLV_Zaid, SLV_Brutus)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_MCMMenu Property ThisMenu auto
ReferenceAlias Property SLV_Zaid Auto 
ReferenceAlias Property SLV_Brutus Auto  
Quest Property SLV_DeadSlave Auto

