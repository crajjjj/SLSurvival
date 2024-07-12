;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WindhelmSlavery12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5000)
GetOwningQuest().SetStage(5500)

if(SLV_Antislavery.IsRunning() && SLV_Antislavery.getStage() >= 0 && SLV_Antislavery.getStage() < 2000)
	SLV_Antislavery.SetObjectiveCompleted(SLV_Antislavery.getStage())
endif

if SLV_Antislavery.IsRunning()
	SLV_Antislavery.SetStage(2500)
endif

ActorUtil.AddPackageOverride(Brutus.GetActorRef(), FollowPlayer ,100)
Brutus.GetActorRef().evaluatePackage()
Brutus.GetActorRef().moveto(Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property Brutus Auto 
Package Property FollowPlayer Auto
Quest Property SLV_Antislavery Auto
