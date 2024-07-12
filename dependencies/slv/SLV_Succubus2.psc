;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Succubus2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(500)
GetOwningQuest().SetStage(1000)

if ThisMenu.SkipSexScenes
	return
endif
actor[] sexActors = new actor[2]
sexActors[0] = akSpeaker
sexActors[1] = Game.GetPlayer()

myScripts.SLV_PlaySexAnimationSynchron(sexActors,"3jiou Breastfeeding Straight","Breastfeeding", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SlV_MCMMenu Property ThisMenu auto
SLV_Utilities Property myScripts auto 
