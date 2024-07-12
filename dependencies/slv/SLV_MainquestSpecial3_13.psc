;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial3_13 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(500)

Slave02.enable()
Slave02.moveto(Game.GetPlayer())

ActorUtil.AddPackageOverride(Slave02 , followPlayer,100)
Slave02.evaluatePackage()
newMerchantEnabling.enable()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor Property Slave02 Auto
Package Property followPlayer Auto
ObjectReference Property newMerchantEnabling Auto
