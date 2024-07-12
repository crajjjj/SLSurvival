;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Enslavement27 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5000)
GetOwningQuest().SetStage(5500)

if ThisMenu.SkipScenes
	return
endif

myScripts.SLV_RewardPlayer(SLV_Brutus, SLV_Sven )
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_MCMMenu Property ThisMenu auto
ReferenceAlias Property SLV_Sven Auto 
ReferenceAlias Property SLV_Brutus Auto
