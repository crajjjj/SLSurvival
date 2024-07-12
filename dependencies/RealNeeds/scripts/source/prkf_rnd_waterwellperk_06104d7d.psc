;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 15
Scriptname PRKF_RND_WaterWellPerk_06104D7D Extends Perk Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
If (Game.GetPlayer().GetItemCount(RND_WaterskinEmpty) >= 1)

	Game.GetPlayer().RemoveItem(RND_WaterskinEmpty, 1)
	Game.GetPlayer().AddItem(RND_WaterskinRiver00, 1)

ElseIf (Game.GetPlayer().GetItemCount(RND_EmptyBottle03) >= 1)

	Game.GetPlayer().RemoveItem(RND_EmptyBottle03, 1)
	Game.GetPlayer().AddItem(RND_BottledWater01, 1)

ElseIf (Game.GetPlayer().GetItemCount(RND_EmptyBottle02) >= 1)

	Game.GetPlayer().RemoveItem(RND_EmptyBottle02, 1)
	Game.GetPlayer().AddItem(RND_BottledWater01, 1)

ElseIf (Game.GetPlayer().GetItemCount(RND_EmptyBottle01) >= 1)

	Game.GetPlayer().RemoveItem(RND_EmptyBottle01, 1)
	Game.GetPlayer().AddItem(RND_BottledWater01, 1)

ElseIf Debug.Messagebox("You don't have any empty bottles or waterskins!")
	
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion Property RND_WaterskinRiver00 Auto
Potion Property RND_EmptyBottle01 Auto
Potion Property RND_EmptyBottle02 Auto
Potion Property RND_EmptyBottle03 Auto
Potion Property RND_WaterskinEmpty Auto
Potion Property RND_BottledWater01 Auto
