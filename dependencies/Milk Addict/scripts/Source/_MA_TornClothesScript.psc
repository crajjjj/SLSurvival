Scriptname _MA_TornClothesScript extends ReferenceAlias

_MA_Init Property Init Auto
_MA_Mcm Property Menu Auto

GlobalVariable Property _MA_FixCost Auto

Actor Property PlayerRef Auto

Faction Property _MA_LostClothesMerchant Auto

Armor WhatIReallyAm
Enchantment E

ObjectReference ClothesContainer

Function InitAlias()
	WhatIReallyAm = Init.LastTornArmor
	E = Init.LastTornEnchantment
	RegisterForSingleUpdateGameTime(24.0)
EndFunction

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	if akOldContainer == PlayerRef && (akNewContainer as Actor).IsInFaction(_MA_LostClothesMerchant) ; need to add a check to this line that akNewContainer != None
		Init.IsRepairable = true
		_MA_FixCost.SetValueInt((WhatIReallyAm .GetGoldValue() * Menu.RepairCostMult) as Int)
		Init.RepairedArmor = WhatIReallyAm
		Init.RepairedEnchantment = E
		If Utility.IsInMenuMode()
			Input.TapKey(15)
		EndIf
		Init.CurrentTornClothesAlias = self
		Init.CurrentTornClothes = self.GetReference()
	ElseIf akNewContainer == PlayerRef
		ClothesContainer = PlayerRef
	Else
		ClothesContainer = None
	EndIf
	RegisterForSingleUpdateGameTime(24.0)
EndEvent

Event OnUpdateGameTime()
	If WhatIReallyAm
		if ClothesContainer == PlayerRef
			RegisterForSingleUpdateGameTime(24.0)
		Else
			Init.CurrentTornClothes = Self.GetReference()
			Init.CurrentTornClothesAlias = Self
			Init.ClearTornClothesAlias()
		EndIf
	EndIf
EndEvent


;/
Int Function GetEnchantedGoldValue(Form TheItem) ; Completely robbed from a helpful forum post
	Int GoldValue = 0
	Enchantment E = TheItem.GetEnchantment()
	Index = 0
	While Index < E.GetNumEffects()
		MagicEffect ME = E.GetNthEffectMagicEffect(Index)
		Float MEBaseCost = ME.GetBaseCost()
		Float Mag = E.GetNthEffectMagnitude(Index)
		Int Dur = E.GetNthEffectDuration(Index)
		GoldValue = GoldValue + ( (MEBaseCost*8) * (pow(Mag,1.1)) * (pow(Dur/10,1.1) )
		Index += 1
	EndWhile
	Return GoldValue
EndFunction 
/;