;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0104090C Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int bCount = 0
Actor PlayerRef =  Game.GetPlayer()
PlayerRef.RemoveItem(Gold001,RND_InnWaterCostAll.GetValueInt())

bCount =  PlayerRef.GetItemCount(RND_EmptyBottle01)
If bCount >= 1
	PlayerRef.RemoveItem(RND_EmptyBottle01, bCount)
	PlayerRef.AddItem(RND_BoiledWater01, bCount)
EndIf
		
bCount = PlayerRef.GetItemCount(RND_EmptyBottle02)
If bCount >= 1
	PlayerRef.RemoveItem(RND_EmptyBottle02, bCount)
	PlayerRef.AddItem(RND_BoiledWater02, bCount)
EndIf
		
bCount = PlayerRef.GetItemCount(RND_EmptyBottle03)
If bCount >= 1
	PlayerRef.RemoveItem(RND_EmptyBottle03, bCount)
	PlayerRef.AddItem(RND_BoiledWater03, bCount)
EndIf

bCount =  PlayerRef.GetItemCount(RND_WaterskinEmpty)
If bCount >= 1
	PlayerRef.RemoveItem(RND_WaterskinEmpty, bCount)
	PlayerRef.AddItem(RND_WaterskinBoiled00, bCount)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion Property RND_EmptyBottle01  Auto  

Potion Property RND_EmptyBottle02  Auto  

Potion Property RND_EmptyBottle03  Auto  

Potion Property RND_BoiledWater01  Auto  

Potion Property RND_BoiledWater02  Auto  

Potion Property RND_BoiledWater03  Auto  

MiscObject Property Gold001  Auto  

GlobalVariable Property RND_InnWaterCostAll  Auto  

Potion Property RND_WaterskinBoiled00  Auto  

Potion Property RND_WaterskinEmpty  Auto  
