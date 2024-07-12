;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJasmin3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1000)
GetOwningQuest().SetStage(1500)

horseOutside.enable()
SLV_Jasmin.GetActorRef().enable()
SLV_Jasmin.GetActorRef().moveto(horseOutside)

ActorUtil.AddPackageOverride(SLV_Jasmin.GetActorRef(), SLV_DoNothing ,100)
SLV_Jasmin.GetActorRef().evaluatePackage()

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Sex", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Jasmin Auto 
Package Property SLV_DoNothing Auto
SLV_Utilities Property myScripts auto
Actor Property horseOutside auto
