;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_MainQuestTaskStartb Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;SLV_Finn.getActorRef().enable()
;SLV_Finn.getActorRef().moveto(Game.getplayer())

;ActorUtil.ClearPackageOverride(SLV_Finn.getActorRef())
;SLV_Finn.getActorRef().evaluatePackage()

;ActorUtil.AddPackageOverride(SLV_Finn.getActorRef(), SLV_FinnFollowPlayer,100)
;SLV_Finn.getActorRef().evaluatePackage()

SLV_FinnQ.Reset() 
SLV_FinnQ.Start() 
SLV_FinnQ.SetActive(true) 
SLV_FinnQ.SetStage(0)

GetOwningQuest().SetObjectiveCompleted(1200)
GetOwningQuest().SetStage(1300)

slaveroutfit.initSlaverSchlongs()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_SlaverOutfit Property slaveroutfit auto

ReferenceAlias Property SLV_Finn Auto
Quest Property SLV_FinnQ Auto
Package Property SLV_FinnFollowPlayer Auto