;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveGladiator6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1000)
getowningquest().setstage(3000)

Game.GetPlayer().RemoveItem(sword,1)
Game.GetPlayer().RemoveItem(headarmor,1)
Game.GetPlayer().RemoveItem(handarmor,1)
Game.GetPlayer().RemoveItem(bootarmor,1)

GladiatorContainer.lock(false)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Armor Property bootarmor  Auto 
Armor Property handarmor  Auto 
Armor Property headarmor  Auto 
Weapon Property sword  Auto 

ObjectReference Property GladiatorContainer  Auto  
