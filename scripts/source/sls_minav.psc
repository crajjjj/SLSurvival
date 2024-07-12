Scriptname SLS_MinAv extends ReferenceAlias  

Event OnInit()
	InitKeywords()
	StartUp()
	RegForEvents()
	GoToState("EventBased")
EndEvent

Event OnPlayerLoadGame()
	InitKeywords()
EndEvent

Function InitKeywords()
	If Game.GetModByName("Devious Devices - Integration.esm") != 255
		zad_DeviousHobbleSkirt = Game.GetFormFromFile(0x05F4BA, "Devious Devices - Integration.esm") as Keyword
	Else
		zad_DeviousHobbleSkirt = _SLS_UnusedDummyKw
	EndIf
EndFunction

Function RegForEvents()
	RegisterForModEvent("MME_MilkCycleComplete", "OnMME_MilkCycleComplete")
EndFunction

Event OnMME_MilkCycleComplete(string eventName, string strArg, float numArg, Form sender)
	
EndEvent

Function Shutdown()
	GoToState("StopUpdates")
	UnregisterForModEvent("MME_MilkCycleComplete")
	PlayerRef.RemoveSpell(_SLS_MinSpeedSpell)
	PlayerRef.RemoveSpell(_SLS_MinCarrySpell)
	PlayerRef.ModActorValue("CarryWeight", 0.1)
	PlayerRef.ModActorValue("CarryWeight", -0.1)
	;PlayerRef.RemoveSpell(_SLS_WeaponReadySpell)
EndFunction

Function StartUp()
	MySpeedMultBonus = 0.0
	MyCarryWeightBonus = 0.0
	OldSpeedMult = 0.0
	OldCarryWeight= 0.0
	;PlayerRef.AddSpell(_SLS_WeaponReadySpell, false)
	RegForEvents()
	GoToState("EventBased")
EndFunction

Event OnUpdate()
	If Utility.IsInMenuMode()
		Utility.Wait(0.1)
		DoUpdate()
	Else
		If RecentEquip
			RecentEquip = false
			;Debug.Messagebox("Delay update")
			RegisterForSingleUpdate(0.5)
		Else
			;Debug.Messagebox("DO update")
			DoUpdate()
		EndIf
	EndIf
EndEvent

Function DoUpdate()
	If CheckSpeed
		BalanceSpeed()
	EndIf
	If CheckWeight
		BalanceCarryWeight()
	EndIf
EndFunction

State EventBased
	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		RecentEquip = true
		;Debug.Messagebox("Equip")
		
		If PlayerRef.WornHasKeyword(zad_DeviousHobbleSkirt)
			;Debug.Messagebox("1")
			GoToState("Hobbled")
		
		Else
			;Debug.Messagebox("2")
			If PlayerRef.GetActorValue("SpeedMult") != OldSpeedMult
				;Debug.Messagebox("3")
				GoToState("StopUpdates")
				CheckSpeed = true
				
			;Else
			;	Debug.Messagebox("Speed not changed")
			EndIf
			If PlayerRef.GetActorValue("CarryWeight") != OldCarryWeight
				GoToState("StopUpdates")
				CheckWeight = true
			EndIf
			
			If CheckSpeed || CheckWeight
				RegisterForSingleUpdate(0.0)
			EndIf
		EndIf
	EndEvent
	
	Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
		RecentEquip = true
		;Debug.Messagebox("UnEquip")
		If PlayerRef.WornHasKeyword(zad_DeviousHobbleSkirt)
			GoToState("Hobbled")
			
		Else
			If PlayerRef.GetActorValue("SpeedMult") != OldSpeedMult
				GoToState("StopUpdates")
				CheckSpeed = true
			EndIf
			If PlayerRef.GetActorValue("CarryWeight") != OldCarryWeight
				GoToState("StopUpdates")
				CheckWeight = true
			EndIf
			
			If CheckSpeed || CheckWeight
				RegisterForSingleUpdate(0.0)
			EndIf
		EndIf
	EndEvent
;/
	Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
		If PlayerRef.WornHasKeyword(zad_DeviousHobbleSkirt)
			GoToState("Hobbled")

		Else
			If PlayerRef.GetActorValue("SpeedMult") != OldSpeedMult
				GoToState("StopUpdates")
				BalanceSpeed()
			EndIf
			If PlayerRef.GetActorValue("CarryWeight") != OldCarryWeight
				GoToState("StopUpdates")
				BalanceCarryWeight()
			EndIf
		EndIf
	EndEvent
/;
	Function ForceUpdate()
		GoToState("StopUpdates")
		;Debug.Messagebox("MinAv firing")
		CheckWeight = true
		BalanceSpeed()
		BalanceCarryWeight()
	EndFunction
EndState

State StopUpdates
	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		RecentEquip = true
		;Debug.Messagebox("Equip")
	EndEvent
	
	Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
		RecentEquip = true
		;Debug.Messagebox("UnEquip")
	EndEvent
	;/
	Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
	EndEvent
	/;
EndState

State Hobbled
	Event OnBeginState()
		PlayerRef.RemoveSpell(_SLS_MinSpeedSpell)
		PlayerRef.RemoveSpell(_SLS_MinCarrySpell)
		PlayerRef.ModActorValue("CarryWeight", 0.1)
		PlayerRef.ModActorValue("CarryWeight", -0.1)
	EndEvent
	
	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		If !PlayerRef.WornHasKeyword(zad_DeviousHobbleSkirt)
			BalanceSpeed()
			BalanceCarryWeight()
			GoToState("EventBased")
		EndIf
	EndEvent

	Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
		If !PlayerRef.WornHasKeyword(zad_DeviousHobbleSkirt)
			BalanceSpeed()
			BalanceCarryWeight()
			GoToState("EventBased")
		EndIf
	EndEvent
;/
	Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
		If !PlayerRef.WornHasKeyword(zad_DeviousHobbleSkirt)
			BalanceSpeed()
			BalanceCarryWeight()
			GoToState("EventBased")
		EndIf
	EndEvent
	/;
EndState

Function BalanceSpeed()
	Float ActualSpeed = (PlayerRef.GetActorValue("SpeedMult") - MySpeedMultBonus)
	Float NewBonus = Menu.MinSpeedMult - ActualSpeed
	;Debug.trace("SLS_: Speed Bonus = " + NewBonus)
	If NewBonus < 0.0
		NewBonus = 0.0
	EndIf
	_SLS_MinSpeedSpell.SetNthEffectMagnitude(0, NewBonus)
	PlayerRef.RemoveSpell(_SLS_MinSpeedSpell)
	Utility.Wait(0.1)
	PlayerRef.AddSpell(_SLS_MinSpeedSpell, false)
	PlayerRef.ModActorValue("CarryWeight", 0.1)
	PlayerRef.ModActorValue("CarryWeight", -0.1)
	OldSpeedMult = PlayerRef.GetActorValue("SpeedMult")
	MySpeedMultBonus = NewBonus
	If Menu.MinAvToggleT
		If !CheckWeight ; If weight is still to be checked the let BalanceCarryWeight() change state back to EventBased. If not, resume now.
			GoToState("EventBased")
		EndIf
	Else
		GoToState("StopUpdates")
	EndIf
EndFunction

Function BalanceCarryWeight()
	Float ActualCarry = (PlayerRef.GetActorValue("CarryWeight") - MyCarryWeightBonus)
	Float NewBonus = Menu.MinCarryWeight - ActualCarry
	;Debug.Messagebox("SLS_: Carry Bonus = " + NewBonus)
	If NewBonus < 0.0
		NewBonus = 0.0
	EndIf
	_SLS_MinCarrySpell.SetNthEffectMagnitude(0, NewBonus)
	PlayerRef.RemoveSpell(_SLS_MinCarrySpell)
	Utility.Wait(0.1)
	PlayerRef.AddSpell(_SLS_MinCarrySpell, false)
	PlayerRef.ModActorValue("CarryWeight", 0.1)
	PlayerRef.ModActorValue("CarryWeight", -0.1)
	OldCarryWeight = PlayerRef.GetActorValue("CarryWeight")
	MyCarryWeightBonus = NewBonus
	If Menu.MinAvToggleT
		GoToState("EventBased")
	Else
		GoToState("StopUpdates")
	EndIf
EndFunction

Function ForceUpdate()
EndFunction

Float MySpeedMultBonus = 0.0
Float MyCarryWeightBonus = 0.0

Float OldSpeedMult = 0.0
Float OldCarryWeight= 0.0

Bool CheckSpeed = false
Bool CheckWeight = false
Bool RecentEquip = false

Actor Property PlayerRef Auto

Keyword Property _SLS_UnusedDummyKw Auto

Spell Property _SLS_MinCarrySpell Auto
Spell Property _SLS_MinSpeedSpell Auto
Spell Property _SLS_WeaponReadySpell Auto

Keyword zad_DeviousHobbleSkirt

SLS_Mcm Property Menu Auto
