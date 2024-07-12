;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial6_14 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2000)
GetOwningQuest().SetStage(2500)

ActorUtil.AddPackageOverride(Dog1.getActorRef() , SLV_Idle,100)
Dog1.getActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(Dog2.getActorRef() , SLV_Idle,100)
Dog2.getActorRef().evaluatePackage()

ActorUtil.AddPackageOverride(akSpeaker, SLV_Idle,100)
akSpeaker.evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property Dog1 Auto 
ReferenceAlias Property Dog2 Auto 
Package Property SLV_Idle Auto
