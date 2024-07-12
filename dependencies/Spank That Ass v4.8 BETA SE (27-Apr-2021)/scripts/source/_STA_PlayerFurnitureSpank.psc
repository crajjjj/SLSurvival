Scriptname _STA_PlayerFurnitureSpank extends ReferenceAlias  

Formlist Property _STA_SpankableFurnitureList Auto

Keyword Property _STA_DummyNeverUsedKeyword Auto
Keyword zbfFurniture

Spell Property _STA_SpankFurnitureDetectSpell Auto

Actor Property PlayerRef Auto

Quest Property _STA_RandomNpcRunUpAndSpankQuest Auto

_STA_Mcm Property Menu Auto

Event OnPlayerLoadGame()
	zbfFurniture = _STA_DummyNeverUsedKeyword
	If Game.GetModByName("ZaZAnimationPack.esm") != 255
		zbfFurniture = Game.GetFormFromFile(0x00762B, "ZaZAnimationPack.esm") as Keyword
	EndIf
EndEvent

Event OnUpdate()
	If Menu.FurnSpankChance > Utility.RandomFloat(0.0, 100.0)
		;_STA_SpankFurnitureDetectSpell.Cast(PlayerRef, PlayerRef)
		SendNpcSpankEvent()
	EndIf
	RegisterForSingleUpdate(8.0)
EndEvent

Event OnSit(ObjectReference akFurniture)
	Form akFurnitureBase = akFurniture.GetBaseObject()
	If _STA_SpankableFurnitureList.HasForm(akFurnitureBase) || akFurnitureBase.HasKeyword(zbfFurniture)
		RegisterForSingleUpdate(1.0)
	EndIf
EndEvent

Event OnGetUp(ObjectReference akFurniture)
	UnRegisterForUpdate()
	_STA_RandomNpcRunUpAndSpankQuest.Stop()
EndEvent

Function SendNpcSpankEvent()
	int SpankEvent = ModEvent.Create("STA_DoRandomNpcSpank")
	if (SpankEvent)
		ModEvent.PushFloat(SpankEvent, 8.0)
		ModEvent.PushBool(SpankEvent, true)
		ModEvent.PushFloat(SpankEvent, -1.0)
		ModEvent.Send(SpankEvent)
	EndIf
EndFunction
