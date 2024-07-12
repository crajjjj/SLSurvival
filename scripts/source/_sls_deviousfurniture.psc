Scriptname _SLS_DeviousFurniture extends ReferenceAlias

Event OnInit()
	If Game.GetModByName("ZaZAnimationPack.esm") != 255
		zbfFurniture = Game.GetFormFromFile(0x00762B, "ZaZAnimationPack.esm") as Keyword
	Else
		zbfFurniture = _SLS_UnusedDummyKw
	EndIf
	
	If Game.GetModByName("MilkModNEW.esp") != 255
		MME_zbfFurniture = Game.GetFormFromFile(0x07E3C7, "MilkModNEW.esp") as Keyword
	Else
		MME_zbfFurniture = _SLS_UnusedDummyKw
	EndIf
EndEvent

Event OnSit(ObjectReference akFurniture)
	If Init.DebugMode
		Debug.Messagebox("SLS: Sat in furniture")
	EndIf
	Form akBaseObject = akFurniture.GetBaseObject()
	If akBaseObject.HasKeyword(MME_zbfFurniture)
		If Menu.BondFurnMilkFreq > -1
			IsInMilkingMachine = true
			StartUp()
		EndIf
	ElseIf akBaseObject.HasKeyword(zbfFurniture)
		If Menu.BondFurnFreq > -1
			IsInMilkingMachine = false
			StartUp()
		EndIf
	EndIf
EndEvent

Function StartUp()
	RegisterForAnimationEvent(PlayerRef, "JumpUp")
	RegisterForAnimationEvent(PlayerRef, "FootLeft")
	RegisterForAnimationEvent(PlayerRef, "FootRight")
	Ticks = 0
	GoToState("Active")
	RegisterForSingleUpdate(1.0)
	If Init.DebugMode
		Debug.Messagebox("SLS: Devious furniture starting up. Is Milking Machine: " + IsInMilkingMachine)
	EndIf
EndFunction

Event OnAnimationEvent(ObjectReference akSource, string asEventName) ; Moving ends dancing
	OnGetUp(None)
EndEvent

Event OnGetUp(ObjectReference akFurniture)
	UnRegisterForAnimationEvent(PlayerRef, "JumpUp")
	UnRegisterForAnimationEvent(PlayerRef, "FootLeft")
	UnRegisterForAnimationEvent(PlayerRef, "FootRight")
	GoToState("")
	UnRegisterForUpdate()
	If Init.DebugMode
		Debug.Messagebox("SLS: Got out of furniture")
	EndIf
EndEvent

Event OnUpdate()

EndEvent

State Active
	Event OnUpdate()
		Ticks += 1
		If IsInMilkingMachine
			Needs.ModFatigue(Menu.BondFurnMilkFatigueMult * 2.0)
			If Ticks >= Menu.BondFurnMilkWill
				Ticks = 0
				Dflow.DecResistWithSeverity(Amount = 1.0, DoNotify = true, Severity = "2")
			EndIf
			RegisterForSingleUpdate(Menu.BondFurnMilkFreq)
		Else
			Needs.ModFatigue(Menu.BondFurnFatigueMult * 5.0)
			If Ticks >= Menu.BondFurnWill
				Ticks = 0
				Dflow.DecResistWithSeverity(Amount = 1.0, DoNotify = true, Severity = "3")
			EndIf
			RegisterForSingleUpdate(Menu.BondFurnFreq)
		EndIf
	EndEvent
EndState

Bool IsInMilkingMachine = false
Int Ticks = 0

Actor Property PlayerRef Auto

Keyword Property _SLS_UnusedDummyKw Auto
Keyword Property zbfFurniture Auto Hidden
Keyword Property MME_zbfFurniture Auto Hidden

SLS_Mcm Property Menu Auto
SLS_Init Property Init Auto
_SLS_Needs Property Needs Auto
_SLS_InterfaceDeviousFollowers Property Dflow Auto
