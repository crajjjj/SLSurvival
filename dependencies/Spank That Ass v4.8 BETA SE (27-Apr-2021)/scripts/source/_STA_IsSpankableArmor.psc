Scriptname _STA_IsSpankableArmor extends ReferenceAlias  

Keyword Property SLA_ArmorSpendex Auto Hidden
Keyword Property SLA_ArmorHalfNakedBikini Auto Hidden
Keyword Property SLA_ArmorHalfNaked Auto Hidden
Keyword Property EroticArmor Auto Hidden

GlobalVariable Property _STA_IsSpankableArmorGlobal Auto

Actor Property PlayerRef Auto

_STA_Mcm Property Menu Auto

Bool Property BakaSla = false Auto Hidden

Form LastArmor

Event OnInit()
	RegisterForModEvent("_MA_ConfigureSlutiness", "On_MA_ConfigureSlutiness")
	RegisterForMenu("Journal Menu")
EndEvent

Event OnPlayerLoadGame()
	RegisterForModEvent("_MA_ConfigureSlutiness", "On_MA_ConfigureSlutiness")
	RegisterForMenu("Journal Menu")
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	If akBaseObject as Armor
		GetIsSpankable()
	EndIf
EndEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	If akBaseObject as Armor
		GetIsSpankable()
	EndIf
EndEvent

Function GetIsSpankable()
	Armor Cuirass = PlayerRef.GetWornForm(0x00000004) as Armor
	If Cuirass != None
		Form akBaseObject = Cuirass as Form
		If Cuirass.GetWeightClass() == 2 ; Clothes
			_STA_IsSpankableArmorGlobal.SetValueInt(1)
		Else
			Bool HasBakaKeyword = false
			Int Index = JsonUtil.FormListFind("Milk Addict/SlutClothes.json", "ClothesList", akBaseObject)
			Int Slutiness = -1
			If Index > -1
				Slutiness = JsonUtil.IntListGet("Milk Addict/SlutClothes.json", "Sluttiness", Index)
			EndIf
			If BakaSla
				If akBaseObject.HasKeyword(SLA_ArmorSpendex) || akBaseObject.HasKeyword(SLA_ArmorHalfNakedBikini) || akBaseObject.HasKeyword(SLA_ArmorHalfNaked) || akBaseObject.HasKeyword(EroticArmor)
					HasBakaKeyword = true
				EndIf
			EndIf
			If StorageUtil.GetIntValue(akBaseObject, "SLAroused.IsNakedArmor", 0) > 0 || StorageUtil.GetIntValue(akBaseObject, "SLAroused.IsSlootyArmor", Missing = -1) == 1 || (Slutiness >= Menu.SpankableSlutiness && Slutiness < 7) || HasBakaKeyword
				_STA_IsSpankableArmorGlobal.SetValueInt(1)
				
			Else
				_STA_IsSpankableArmorGlobal.SetValueInt(0)
			EndIf
		EndIf
	Else
		_STA_IsSpankableArmorGlobal.SetValueInt(1)
	EndIf
EndFunction

Function InitBakaKeywords()
	SLA_ArmorSpendex = Game.GetFormFromFile(0x8E858, "SexLabAroused.esm") as Keyword
	If SLA_ArmorSpendex
		SLA_ArmorHalfNakedBikini = Game.GetFormFromFile(0x8E854, "SexLabAroused.esm") as Keyword
		SLA_ArmorHalfNaked = Game.GetFormFromFile(0x8E855, "SexLabAroused.esm") as Keyword
		EroticArmor = Game.GetFormFromFile(0x8C7F6, "SexLabAroused.esm") as Keyword
	Else
		Debug.Messagebox("STA: Keyword not found. You're not using Bakas SLA. Option Disabled")
		BakaSla = false
	EndIf
EndFunction

Event OnMenuClose(String MenuName) ; Check was armor set as naked in SLA MCM
	GetIsSpankable()
EndEvent

Event On_MA_ConfigureSlutiness()
	GetIsSpankable()
EndEvent
