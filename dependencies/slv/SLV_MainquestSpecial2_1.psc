;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial2_1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(500)

Slave02.enable()
Slave02.moveto(Game.GetPlayer())

ActorUtil.AddPackageOverride(Slave02 , SLV_FollowPlayer,100)
Slave02.evaluatePackage()

Game.GetPlayer().AddItem(DeviousItem, 5)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor Property Slave02 Auto
Package Property SLV_FollowPlayer Auto
Armor Property DeviousItem  Auto  