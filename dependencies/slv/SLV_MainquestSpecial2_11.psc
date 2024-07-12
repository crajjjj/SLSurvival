;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial2_11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5000)
GetOwningQuest().SetStage(5500)

Game.GetPlayer().RemoveItem(DeviousItem1, 5)
Game.GetPlayer().RemoveItem(DeviousItem2, 5)

ActorUtil.ClearPackageOverride(slave)
slave.evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor Property slave Auto
Armor Property DeviousItem1 Auto 
Armor Property DeviousItem2 Auto 