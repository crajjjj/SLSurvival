;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__060115CC Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Armor ReEquipArmor = PlayerRef.GetWornForm(0x00000004) as Armor
Init.ClearTornClothesAlias()
PlayerRef.AddItem(Init.RepairedArmor, 1)
Main.EquipToIgnore = Init.RepairedArmor 
PlayerRef.EquipItem(Init.RepairedArmor, false, true)
Int i = 0
While PlayerRef.GetWornForm(0x00000004) != Init.RepairedArmor && i < 8 ; Enchantment is being set before armor is equipped...? wtf
	Utility.Wait(0.5)
	i += 1
EndWhile
If Init.RepairedArmor.GetEnchantment() == None ; If the base form has no enchantment
	If Init.RepairedEnchantment != None
		WornObject.SetEnchantment(PlayerRef, 0, 4, Init.RepairedEnchantment, 100.0)
	EndIf
EndIf
;Main.InitClothesDurability(Init.RepairedArmor)
If ReEquipArmor == None
	PlayerRef.UnequipItem(PlayerRef.GetWornForm(0x00000004) as Armor, false, true)
Else
	;PlayerRef.EquipItem(ReEquipArmor, false, true)
	PlayerRef.EquipItemEx(ReEquipArmor, 0, preventUnequip = false, equipSound = false)
EndIf
PlayerRef.RemoveItem(Gold001, _MA_FixCost.GetValueInt())

debug.Trace("_MA_: ReEquipArmor - " + ReEquipArmor)
Debug.Trace("_MA_: RepairedArmor - " + Init.RepairedArmor)
Debug.Trace("_MA_: RepairedEnchantment - " + Init.RepairedEnchantment)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerRef Auto
_MA_Init Property Init Auto
_MA_Main Property Main Auto
MiscObject Property Gold001  Auto 
GlobalVariable Property _MA_FixCost Auto
