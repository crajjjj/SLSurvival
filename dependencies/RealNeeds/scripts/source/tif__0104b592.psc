;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0104B592 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().RemoveItem(RND_WaterskinEmpty,1)
Game.GetPlayer().RemoveItem(Gold001, RND_InnWaterCost.GetValueInt())
Game.GetPlayer().AddItem(RND_WaterskinBoiled00,1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion Property RND_WaterskinEmpty  Auto  

Potion Property RND_WaterskinBoiled00  Auto  

MiscObject Property Gold001  Auto  

GlobalVariable Property RND_InnWaterCost  Auto  
