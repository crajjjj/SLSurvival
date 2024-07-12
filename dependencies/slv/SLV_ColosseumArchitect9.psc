;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumArchitect9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3500)
GetOwningQuest().SetStage(4000)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()

ActorUtil.AddPackageOverride(akSpeaker, SLV_FollowPlayer ,100)
akSpeaker.evaluatePackage()


if ThisMenu.SkipScenes || !ThisMenu.StoryMode
	myScripts.SLV_enslavementNPC(akSpeaker)
	myScripts.SLV_enslavementChains(akSpeaker)
	myScripts.SLV_Play2Sex(akSpeaker, SLV_Leonardo.getActorRef(), "Sex", true)
else
	myScripts.SLV_PlayScene(PunishScene)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property PunishScene  Auto
SLV_Utilities Property myScripts auto
Package Property SLV_FollowPlayer Auto

ReferenceAlias Property SLV_Leonardo Auto
SLV_MCMMenu Property ThisMenu auto