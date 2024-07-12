;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF__0201D8C9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().RemoveItem(RND_EmptyBottle01,1)
Game.GetPlayer().RemoveItem(Gold001, RND_InnWaterCost.GetValueInt())
Game.GetPlayer().AddItem(RND_BoiledWater01,1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property Gold001  Auto  

Potion Property RND_EmptyBottle01  Auto  

Potion Property RND_BoiledWater01  Auto  

GlobalVariable Property RND_InnWaterCost  Auto  
