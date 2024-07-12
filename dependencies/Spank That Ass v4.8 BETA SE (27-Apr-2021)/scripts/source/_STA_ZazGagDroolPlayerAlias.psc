Scriptname _STA_ZazGagDroolPlayerAlias extends ReferenceAlias  

Actor Property PlayerRef Auto
Keyword Property zbfWornGag Auto Hidden
_STA_SexDialogUtil Property DialogUtil Auto

Event OnInit()
	If Game.GetModByName("ZaZAnimationPack.esm") != 255
		zbfWornGag = Game.GetFormFromFile(0x008A4D, "ZaZAnimationPack.esm") as Keyword
	EndIf
EndEvent

Event OnPlayerLoadGame()
	If Game.GetModByName("ZaZAnimationPack.esm") != 255
		zbfWornGag = Game.GetFormFromFile(0x008A4D, "ZaZAnimationPack.esm") as Keyword
	EndIf
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	If akBaseObject as Armor && zbfWornGag != None
		If akBaseObject.HasKeyword(zbfWornGag)
			DialogUtil.IsMouthAvailable = 0
			PlayerRef.RemoveSpell(DialogUtil._STA_DroolCooldownSpell)
			DialogUtil.AddDrool()
		EndIf
	EndIf
EndEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	If akBaseObject as Armor && zbfWornGag != None
		If akBaseObject.HasKeyword(zbfWornGag)
			DialogUtil.IsMouthAvailable = 1
			DialogUtil.AddDroolCooldownSpell()
		EndIf
	EndIf
EndEvent
