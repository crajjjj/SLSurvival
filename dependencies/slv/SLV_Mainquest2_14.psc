;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Mainquest2_14 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(50)

horseOutside.enable()
SLV_LadyMara.GetActorRef().enable()
SLV_LadyMara.GetActorRef().moveto(horseOutside)

;ActorUtil.AddPackageOverride(SLV_LadyMara.GetActorRef(), SLV_DoNothing ,100)
;SLV_LadyMara.GetActorRef().evaluatePackage()

myScripts.SLV_PlayScene(PunishScene)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Package Property SLV_DoNothing Auto
ObjectReference  Property horseOutside auto

ReferenceAlias Property SLV_LadyMara Auto
Scene Property PunishScene  Auto
