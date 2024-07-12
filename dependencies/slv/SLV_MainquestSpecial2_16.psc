;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial2_16 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
getowningquest().setstage(2000)

Game.GetPlayer().AddItem(DeviousItem1, 5)
Game.GetPlayer().AddItem(DeviousItem2, 5)

Slave02.enable()
Slave02.moveto(Game.GetPlayer())

ActorUtil.AddPackageOverride(Slave02 , SLV_FollowPlayer,100)
Slave02.evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor Property Slave02 Auto
Package Property SLV_FollowPlayer Auto
Armor Property DeviousItem1 Auto 
Armor Property DeviousItem2  Auto 
