Scriptname _SLS_InterfaceAmputation extends Quest  

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("Amputator.esm") != 255
		If GetState() != "Installed"
			GoToState("Installed")
		EndIf
	
	Else
		If GetState() != ""
			GoToState("")
		EndIf
	EndIf
EndFunction

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
	AmpQuest = Game.GetFormFromFile(0x000801,"Amputator.esm") as Quest
	
	;/
	AmpArmLeftEffects = new MagicEffect[3]
	AmpArmLeftEffects[0] = Game.GetFormFromFile(0x000815,"Amputator.esm") as MagicEffect
	AmpArmLeftEffects[1] = Game.GetFormFromFile(0x000807,"Amputator.esm") as MagicEffect
	AmpArmLeftEffects[2] = Game.GetFormFromFile(0x000805,"Amputator.esm") as MagicEffect
	
	AmpArmRightEffects = new MagicEffect[3]
	AmpArmRightEffects[0] = Game.GetFormFromFile(0x0012EF,"Amputator.esm") as MagicEffect
	AmpArmRightEffects[1] = Game.GetFormFromFile(0x0012EC,"Amputator.esm") as MagicEffect
	AmpArmRightEffects[2] = Game.GetFormFromFile(0x0012ED,"Amputator.esm") as MagicEffect
	
	AmpLegLeftEffects = new MagicEffect[3]
	AmpLegLeftEffects[0] = Game.GetFormFromFile(0x000804,"Amputator.esm") as MagicEffect
	AmpLegLeftEffects[1] = Game.GetFormFromFile(0x000803,"Amputator.esm") as MagicEffect
	AmpLegLeftEffects[2] = Game.GetFormFromFile(0x000806,"Amputator.esm") as MagicEffect
	
	AmpLegRightEffects = new MagicEffect[3]
	AmpLegRightEffects[0] = Game.GetFormFromFile(0x0012F0,"Amputator.esm") as MagicEffect
	AmpLegRightEffects[1] = Game.GetFormFromFile(0x0012EE,"Amputator.esm") as MagicEffect
	AmpLegRightEffects[2] = Game.GetFormFromFile(0x0012EB,"Amputator.esm") as MagicEffect
	/;
	
	_AMP_AmputeeArmLeftFact = Game.GetFormFromFile(0x00BF77,"Amputator.esm") as Faction
	_AMP_AmputeeArmRightFact = Game.GetFormFromFile(0x00BF79,"Amputator.esm") as Faction
	_AMP_AmputeeLegLeftFact = Game.GetFormFromFile(0x00BF76,"Amputator.esm") as Faction
	_AMP_AmputeeLegRightFact = Game.GetFormFromFile(0x00BF78,"Amputator.esm") as Faction
	
EndEvent

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

State Installed
	Function Amputate(Actor akActor, int morphType ,int bothLeftRight)
		;/
		AmputatorMainScript.psc
		AMS.ApplyAmputator(Actor akActor, int morphType ,int bothLeftRight)

		morphType determines which bodypart to remove, the codes are:
		0 = Heal all Amputations
		1 = Feet
		2 = Lower Legs
		3 = Upper Legs
		4 = Hands
		5 = Forearms
		6 = UpperArms

		bothLeftRight determines which side to remove
		0 = Both sides
		1 = Left
		2 = Right
		/;
		
		;Amp.IgnoreLimbChangeEvents()
		
		If akActor == PlayerRef
			_SLS_IntAmp.Amputate(AmpQuest, akActor, morphType, bothLeftRight, Self)
			;Amp.ResumeLimbChangeEvents()
			If morphType >= 4
				If bothLeftRight == 0 ; Both
					Amp.LeftHandDisabled = true
					Amp.RightHandDisabled = true
					
				ElseIf bothLeftRight == 1 ; Left
					Amp.LeftHandDisabled = true
					
				ElseIf bothLeftRight == 2 ; Right
					Amp.RightHandDisabled = true
					
				Else
					Debug.Trace("_SLS_: Amputate: Invalid bothLeftRight")
				EndIf
				ProcHands()
				
			;ElseIf morphType == 0 ; Heal
			;	PlayerRef.RemoveSpell(_SLS_CombatChangeDetectSpell)
			;	_SLS_AmpArmlessPacifyQuest.Stop()
			;	_SLS_AmputationHelplessQuest.Stop()
			;	Amp.LeftHandDisabled = false
			;	Amp.RightHandDisabled = false
			EndIf
		EndIf
	EndFunction
	
	Function RefreshAvailability()
		;Amp.AvailLeftArm = GetRemainingLimb(AmpArmLeftEffects)
		;Amp.AvailRightArm = GetRemainingLimb(AmpArmRightEffects)
		;Amp.AvailLeftLeg = GetRemainingLimb(AmpLegLeftEffects)
		;Amp.AvailRightLeg = GetRemainingLimb(AmpLegRightEffects)

		Amp.AvailLeftArm = GetAvail(_AMP_AmputeeArmLeftFact)
		Amp.AvailRightArm = GetAvail(_AMP_AmputeeArmRightFact)
		Amp.AvailLeftLeg = GetAvail(_AMP_AmputeeLegLeftFact)
		Amp.AvailRightLeg = GetAvail(_AMP_AmputeeLegRightFact)
		
		;Debug.Messagebox("AvailLeftArm: " + Amp.AvailLeftArm + "\nAvailRightArm: " + Amp.AvailRightArm + "\nAvailLeftLeg: " + Amp.AvailLeftLeg + "\nAvailRightLeg: " + Amp.AvailRightLeg)
	EndFunction
	
	Int Function GetAvail(Faction AmpFaction)
		Int Rank = PlayerRef.GetFactionRank(AmpFaction)
		If Rank < 0
			Return 3
		Else
			Return 3 - (Rank + 1)
		EndIf
	EndFunction
EndState

;/
Int Function GetRemainingLimb(MagicEffect[] LimbEffects)
	Int i = 0
	While i < 3
		If PlayerRef.HasMagicEffect(LimbEffects[i])
			Return i
		EndIf
		i += 1
	EndWhile
	Return 3
EndFunction
/;

Function ProcHands()
	Form EquippedItem
	If Amp.LeftHandDisabled
		 EquippedItem = PlayerRef.GetEquippedShield()
		 If !EquippedItem
			EquippedItem = PlayerRef.GetEquippedWeapon(abLeftHand = true)
		 EndIf
		 
		 If EquippedItem
			ProcEquippedItem(EquippedItem, 2)
		 Else
			ProcEquippedSpell(0)
		 EndIf
	EndIf
	
	If Amp.RightHandDisabled
		EquippedItem = PlayerRef.GetEquippedWeapon(abLeftHand = false)
		 If EquippedItem
			ProcEquippedItem(EquippedItem, 1)
		 Else
			ProcEquippedSpell(1)
		 EndIf
	EndIf
EndFunction

Function ProcEquippedItem(Form akBaseObject, Int Hand)
	If akBaseObject as Weapon
		PlayerRef.UnequipItemEx(akBaseObject, Hand, preventEquip = false)
	Else
		PlayerRef.UnequipItem(akBaseObject)
	EndIf
	If Menu.DropItems
		Int i = 10
		;ObjectReference ObjRef = PlayerRef.DropObject(akBaseObject)
		ObjectReference ObjRef = LostFound.DropItem(PlayerRef, akBaseObject)
		While !ObjRef.Is3dLoaded() && i > 0
			Utility.Wait(0.05)
			i -= 1
		EndWhile
		If ObjRef
			ObjRef.ApplyHavokImpulse(Utility.RandomFloat(-1.0, 1.0), Utility.RandomFloat(-1.0, 1.0), Utility.RandomFloat(-1.0, 0.5), Utility.RandomFloat(50.0, 150.0))
		EndIf
	EndIf
EndFunction

Function ProcEquippedSpell(Int Hand) ; Hand 0 - Left, 1 - Right
	Spell EquippedSpell = PlayerRef.GetEquippedSpell(Hand)
	If EquippedSpell
		PlayerRef.UnequipSpell(EquippedSpell, Hand)
	EndIf
EndFunction

Function Amputate(Actor akActor, int morphType ,int bothLeftRight)
EndFunction

Function RefreshAvailability()
	Amp.AvailLeftArm = 3
	Amp.AvailRightArm = 3
	Amp.AvailLeftLeg = 3
	Amp.AvailRightLeg = 3
EndFunction

Int Function GetAvail(Faction AmpFaction)
	Return 0
EndFunction

;MagicEffect[] Property AmpArmLeftEffects Auto Hidden
;MagicEffect[] Property AmpArmRightEffects Auto Hidden
;MagicEffect[] Property AmpLegLeftEffects Auto Hidden
;MagicEffect[] Property AmpLegRightEffects Auto Hidden

Faction Property _AMP_AmputeeArmLeftFact Auto Hidden
Faction Property _AMP_AmputeeArmRightFact Auto Hidden
Faction Property _AMP_AmputeeLegLeftFact Auto Hidden
Faction Property _AMP_AmputeeLegRightFact Auto Hidden

Actor Property PlayerRef Auto

;/
MagicEffect Property AMP_AmputeeEffectUpperArmsLeft Auto Hidden
MagicEffect Property AMP_AmputeeEffectForearmsLeft Auto Hidden
MagicEffect Property AMP_AmputeeEffectHandsLeft Auto Hidden

MagicEffect Property AMP_AmputeeEffectUpperArmsRight Auto Hidden
MagicEffect Property AMP_AmputeeEffectForearmsRight Auto Hidden
MagicEffect Property AMP_AmputeeEffectHandsRight Auto Hidden

MagicEffect Property AMP_AmputeeEffectUpperLegsRight Auto Hidden
MagicEffect Property AMP_AmputeeEffectLowerLegsRight Auto Hidden
MagicEffect Property AMP_AmputeeEffectFeetLeft Auto Hidden

MagicEffect Property AMP_AmputeeEffectUpperLegsLeft Auto Hidden
MagicEffect Property AMP_AmputeeEffectLowerLegsLeft Auto Hidden
MagicEffect Property AMP_AmputeeEffectFeetRight Auto Hidden

MagicEffect Property AMP_AmputeeStatusEffect Auto Hidden
/;

Quest AmpQuest
;Quest Property _SLS_AmputationHelplessQuest Auto
;Quest Property _SLS_AmpArmlessPacifyQuest Auto

;Spell Property _SLS_CombatChangeDetectSpell Auto

_SLS_LostFound Property LostFound Auto
_SLS_Amputation Property Amp Auto
_SLS_AmputationAlias Property AmpAlias Auto
SLS_Mcm Property Menu Auto
