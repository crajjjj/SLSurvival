;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ArenaGladiator_3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.getPlayer().additem(enchBow,1)
Game.getPlayer().additem(enchSword1h ,1)
Game.getPlayer().additem(enchSword2h ,1)
Game.getPlayer().additem(enchDagger ,1)
Game.getPlayer().additem(enchStaff ,1)
Game.getPlayer().additem(enchShield ,1)

GetOwningQuest().SetObjectiveCompleted(9500)
GetOwningQuest().SetStage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Weapon Property enchBow auto
Weapon Property enchSword1h auto
Weapon Property enchSword2h auto
Weapon Property enchDagger auto
Weapon Property enchStaff auto
Armor Property enchShield auto




