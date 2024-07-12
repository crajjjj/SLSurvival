;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainEnslaveFree6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor player = Game.GetPlayer()

myScripts.SLV_DeviousUnEquipActor3(player,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)

; as simple slavery sends them naked, we give em prison rags
Form ArmorOrClothes = player.GetWornForm(Armor.GetMaskForSlot(32))
if !ArmorOrClothes
	Armor prisonrags = Game.GetFormFromFile(0x03C9FE, "Skyrim.esm") as Armor
	player.equipItem(prisonrags)
endif
Form FeetArmor = player.GetWornForm(Armor.GetMaskForSlot(37)) 
if !FeetArmor
	Armor prisonshoes = Game.GetFormFromFile(0x03CA00, "Skyrim.esm") as Armor
	player.equipItem(prisonshoes)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
