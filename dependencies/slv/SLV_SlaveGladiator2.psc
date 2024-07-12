;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveGladiator2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().AddItem(sword,1)
Game.GetPlayer().AddItem(headarmor,1)
Game.GetPlayer().AddItem(handarmor,1)
Game.GetPlayer().AddItem(bootarmor,1)

GetOwningQuest().SetObjectiveCompleted(500)
GetOwningQuest().SetStage(750)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Armor Property bootarmor  Auto 
Armor Property handarmor  Auto 
Armor Property headarmor  Auto 
Weapon Property sword  Auto 
