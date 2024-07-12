Scriptname _SLS_Amputation extends Quest Conditional

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
	
Event OnInit()
	RegForEvents()
EndEvent

Function RegForEvents()
	RegisterForModEvent("_SLS_PlayerSwallowedCum", "On_SLS_PlayerSwallowedCum")
	RegisterForModEvent("_AMP_LimbChangeEvent", "On_AMP_LimbChangeEvent")
EndFunction

Event On_SLS_PlayerSwallowedCum(Form akSource, Bool Swallowed, Float LoadSize, Float LoadSizeBase, Bool IsCumPotion)
	If Menu.DismemberTrollCum && Swallowed && (LoadSize / LoadSizeBase) >= (Menu.CumEffectVolThres / 100.0)
		If akSource as Actor
			VoiceType CumVoice = (akSource as Actor).GetVoiceType()
			If CumVoice == CrTrollVoice
				Utility.Wait(5.0)
				_SLS_AmpHealEffectSpell.Cast(PlayerRef, PlayerRef)
				RestoreAllLimbs(DoWait = true)
			EndIf
		EndIf
	EndIf
EndEvent

Event On_AMP_LimbChangeEvent(Form akTarget, Form akSource)
	Actor akActor = akTarget as Actor
	If akActor
		If akActor == PlayerRef
			;Debug.Messagebox("_SLS_InterfaceAmputationQuest: " + _SLS_InterfaceAmputationQuest + "\nSource: " + akSource)
			If akSource != _SLS_InterfaceAmputationQuest as Form ; If the change was not made by survival, process it.
				RecheckLimbStatus()
			EndIf
		EndIf
	EndIf
EndEvent

Function RecheckLimbStatus()
	Amputation.RefreshAvailability()
	If AvailLeftArm == 3 && AvailRightArm == 3 && AvailLeftLeg == 3 && AvailRightLeg == 3 ; All healed
		;PlayerRef.RemoveSpell(_SLS_CombatChangeDetectSpell)
		_SLS_AmputationHelplessQuest.Stop()
		PermitBathing()
		_SLS_AmpIsHandless.SetValueInt(0)
		_SLS_AmpArmlessPacifyQuest.Stop()
		LeftHandDisabled = false
		RightHandDisabled = false
		PlayerRef.RemovePerk(_SLS_AmputationContainerBlockPerk)
	
	ElseIf AvailLeftArm < 3 || AvailRightArm < 3
		If AvailLeftArm < 3
			LeftHandDisabled = true
		EndIf
		If AvailRightArm < 3
			RightHandDisabled = true
		EndIf
		_SLS_AmputationHelplessQuest.Stop()
		_SLS_AmputationHelplessQuest.Start()

		If AvailLeftArm < 3 && AvailRightArm < 3
			;PlayerRef.AddSpell(_SLS_CombatChangeDetectSpell, false)
			ForbidBathing()
			_SLS_AmpIsHandless.SetValueInt(1)
			If StorageUtil.GetIntValue(Menu, "DismemberCombatStop", Missing = 1)
				_SLS_AmpArmlessPacifyQuest.Stop()
				_SLS_AmpArmlessPacifyQuest.Start()
			EndIf
		EndIf
	EndIf
EndFunction

Function PriestHeal(Actor akSpeaker)
	_SLS_AmpHealEffectSpell.Cast(akSpeaker, PlayerRef) ; Lazy for visual effect only
	PlayerRef.RemoveItem(Gold001, _SLS_AmpPriestHealCost.GetValueInt())
	RestoreAllLimbs(DoWait = false)	
EndFunction

Function RestoreAllLimbs(Bool DoWait = true)
	PlayerRef.RemovePerk(_SLS_AmputationContainerBlockPerk)
	Amputation.Amputate(PlayerRef, 0, 0)
	Amputation.RefreshAvailability()
	;PlayerRef.RemoveSpell(_SLS_CombatChangeDetectSpell)
	_SLS_AmputationHelplessQuest.Stop()
	PermitBathing()
	_SLS_AmpIsHandless.SetValueInt(0)
	LeftHandDisabled = false
	RightHandDisabled = false
	If DoWait
		Utility.Wait(5.0)
	EndIf
	_SLS_AmpArmlessPacifyQuest.Stop()
EndFunction

Function PowerAttacked()
	If Menu.AmpType != 0
		CheckAvailabilty()
		If IsUnderMaxAmpedLimbs()
			Int Limb = ChooseLimb()
			If Limb != -1
				Game.ShakeCamera(afStrength = 1.0)
				Int Side = GetSide(Limb)
				Int morphType = GetMorph(Limb, GetAmpDepth(Limb))
				_SLS_AmpIomod.Apply(1.0)
				Amputation.Amputate(PlayerRef, morphType, Side)

				If Limb <= 1 && AvailLeftLeg == 3 && AvailRightLeg == 3
					Debug.SendAnimationEvent(PlayerRef, "staggerStart")
					If Limb == 0
						LeftHandDisabled = true
					Else
						RightHandDisabled = true
					EndIf
				EndIf
				_SLS_AmputationHelplessQuest.Stop()
				_SLS_AmputationHelplessQuest.Start()
				PlayerSpeak(_SLS_AmpHurt)
				Amputation.RefreshAvailability()
				;Debug.Messagebox("Limb: " + GetLimbString(Limb) + "\nmorphType: " + morphType + "\n\nAvailLeftArm: " + AvailLeftArm + "\nAvailRightArm: " + AvailRightArm + "\nAvailLeftLeg: " + AvailLeftLeg + "\nAvailRightLeg: " + AvailRightLeg + "\n\nCanAmpLeftArm: " + CanAmpLeftArm + "\nCanAmpRightArm: " + CanAmpRightArm + "\nCanAmpLeftLeg: " + CanAmpLeftLeg + "\nCanAmpRightLeg: " + CanAmpRightLeg)
				
				Utility.Wait(3.0)
				PlayerSpeak(_SLS_AmpPain)
			EndIf
		EndIf
	EndIf
EndFunction

Bool Function IsDismemberWeapon(Form akSource, Actor akAggressor)
	If akSource as Weapon
		Weapon akWeapon = akSource as Weapon
		If akWeapon == Unarmed && !akAggressor.GetRace().IsRaceFlagSet(0x00000001) && akAggressor.GetBaseActorValue("Health") >= Menu.DismemberHealthThres && (akAggressor.GetEquippedWeapon() == Unarmed || akAggressor.GetEquippedWeapon() == None)
			Return true
		ElseIf akWeapon.GetBaseDamage() >= Menu.DismemberDamageThres
			Int Type = (akSource as Weapon).GetWeaponType()
			If Menu.DismemberWeapon == 0
				If Type > 4 && Type < 7
					Return true
				EndIf
				
			ElseIf Menu.DismemberWeapon == 1
				If Type > 0 && Type < 7 && Type != 2
					Return true
				EndIf
				
			Else
				Return true
			EndIf
		EndIf
	EndIf
	Return false
EndFunction

Bool Function IsUnderMaxAmpedLimbs()
	Int AmpedLimbs = 0
	If AvailLeftArm <= Menu.MaxAmpDepthArms
		AmpedLimbs += 1
	EndIf
	If AvailRightArm <= Menu.MaxAmpDepthArms
		AmpedLimbs += 1
	EndIf
	
	If AvailLeftLeg <= Menu.MaxAmpDepthLegs
		AmpedLimbs += 1
	EndIf
	If AvailRightLeg <= Menu.MaxAmpDepthLegs
		AmpedLimbs += 1
	EndIf
	If AmpedLimbs >= Menu.MaxAmpedLimbs
		Return false
	EndIf
	Return true
EndFunction

Function CheckAvailabilty()
	;Debug.Messagebox("AvailLeftArm: " + AvailLeftArm + ". Menu.MaxAmpDepthArms: " + Menu.MaxAmpDepthArms)
	If AvailLeftArm - Menu.MaxAmpDepthArms > 0
		CanAmpLeftArm = true
	Else
		CanAmpLeftArm = false
	EndIf
	If AvailRightArm - Menu.MaxAmpDepthArms > 0
		CanAmpRightArm = true
	Else
		CanAmpRightArm = false
	EndIf
	
	If AvailLeftLeg - Menu.MaxAmpDepthLegs > 0
		CanAmpLeftLeg = true
	Else
		CanAmpLeftLeg = false
	EndIf
	
	If AvailRightLeg - Menu.MaxAmpDepthLegs > 0
		CanAmpRightLeg = true
	Else
		CanAmpRightLeg = false
	EndIf
EndFunction

Int Function ChooseLimb()
	; Returns int for limb: 0 - left arm, 1 - right arm, 2 - left leg, 3 - right leg

	If Menu.AmpType == 1 ; Random
		Int Index = 0
		Int CanAmpLimbCount = 0
		Int[] LimbArray
		
		; Determine array size
		If CanAmpLeftArm
			CanAmpLimbCount += 1
		EndIf
		If CanAmpRightArm
			CanAmpLimbCount += 1
		EndIf
		If CanAmpLeftLeg
			CanAmpLimbCount += 1
		EndIf
		If CanAmpRightLeg
			CanAmpLimbCount += 1
		EndIf
		
		; Create array
		If CanAmpLimbCount == 1
			LimbArray = new Int[1]
		ElseIf CanAmpLimbCount == 2
			LimbArray = new Int[2]
		ElseIf CanAmpLimbCount == 3
			LimbArray = new Int[3]
		ElseIf CanAmpLimbCount == 4
			LimbArray = new Int[4]
		Else
			Return -1 ; zero length array - no limbs available
		EndIf
		
		; Populate array with available limbs
		If CanAmpLeftArm
			LimbArray[Index] = 0
			Index += 1
		EndIf
		If CanAmpRightArm
			LimbArray[Index] = 1
			Index += 1
		EndIf
		If CanAmpLeftLeg
			LimbArray[Index] = 2
			Index += 1
		EndIf
		If CanAmpRightLeg
			LimbArray[Index] = 3
			Index += 1
		EndIf
		
		; Select a random limb
		Return LimbArray[Utility.RandomInt(0, LimbArray.Length - 1)]
	
	ElseIf Menu.AmpType == 2 ; Hands first
		If CanAmpLeftArm && CanAmpRightArm
			Return Utility.RandomInt(0, 1)
		ElseIf CanAmpLeftArm
			Return 0
		ElseIf CanAmpRightArm
			Return 1
		
		Else ; Check Legs
			If CanAmpLeftLeg && CanAmpRightLeg
				Return Utility.RandomInt(2,3)
			ElseIf CanAmpLeftLeg
				Return 2
			ElseIf CanAmpRightLeg
				Return 3
			Else
				Return -1
				Debug.Trace("_SLS_: No limbs left for amputation")
			EndIf			
		EndIf
		
	ElseIf Menu.AmpType == 3 ; Legs first
		If CanAmpLeftLeg && CanAmpRightLeg
			Return Utility.RandomInt(2, 3)
		ElseIf CanAmpLeftLeg
			Return 2
		ElseIf CanAmpRightLeg
			Return 3
			
		Else ; Check Arms
			If CanAmpLeftArm && CanAmpRightArm
				Return Utility.RandomInt(0,1)
			ElseIf CanAmpLeftArm
				Return 0
			ElseIf CanAmpRightArm
				Return 1
			Else
				Return -1
				Debug.Trace("_SLS_: No limbs left for amputation")
			EndIf			
		EndIf
	EndIf
EndFunction

Int Function GetAmpDepth(Int Limb)
	;Returns 0 - upper leg/upper arm, 1 - Lower leg/forearm, 2 - Hands/Feet
	Int MaxAmpDepth = Menu.MaxAmpDepthArms
	If Limb >= 2
		MaxAmpDepth = Menu.MaxAmpDepthLegs
	EndIf
	
	Int DepthMax = GetAmpDepthMax(Limb)
	If Menu.AmpDepth == 0 ; One level at a time
		Return GetAvail(Limb) - 1
	ElseIf Menu.AmpDepth == 1 ; Max in one go
		Return MaxAmpDepth
	Else ; Random
		Return Utility.RandomInt(DepthMax, GetAvail(Limb) - 1)
	EndIf
EndFunction

Int Function GetAmpDepthMax(Int Limb)
	If Limb == 0 || Limb == 1; arms
		Return Menu.MaxAmpDepthArms
	
	Else ; legs
		Return Menu.MaxAmpDepthLegs
	EndIf
EndFunction

Int Function GetAvail(Int Limb)
	If Limb == 0
		Return AvailLeftArm
	ElseIf Limb == 1
		Return AvailRightArm
	ElseIf Limb == 2
		Return AvailLeftLeg
	Else
		Return AvailRightLeg
	EndIf
EndFunction

Int Function GetSide(Int Limb)
	If Limb == 0 || Limb == 2
		Return 1
	Else
		Return 2
	EndIf
EndFunction

Int Function GetMorph(Int Limb, Int Depth)
	If Limb <= 1 ; Left/right arm
		If Depth == 0
			Return 6
		ElseIf Depth == 1
			Return 5
		Else
			Return 4
		EndIf
		
	ElseIf Limb >= 2 ; Left/Right leg
		If Depth == 0
			Return 3
		ElseIf Depth == 1
			Return 2
		Else
			Return 1
		EndIf
	EndIf
EndFunction

String Function GetLimbString(Int Limb)
	If Limb == 0
		Return "Left arm"
	ElseIf Limb == 1
		Return "Right arm"
	Elseif Limb == 2
		Return "Left Leg"
	Else
		Return "Right Leg"
	EndIf
EndFunction

Function PlayerSpeak(Topic WhatToSay)
	If Menu.DismemberPlayerSay
		_SLS_PlayerSpeak.SetValueInt(1)
		PlayerRef.Say(WhatToSay)
		_SLS_PlayerSpeak.SetValueInt(0)
	
	Else
		Int Fx
		If WhatToSay == _SLS_AmpHurt
			Fx = _SLS_AmpHurtSM.Play(PlayerRef)
		ElseIf WhatToSay == _SLS_AmpPain
			Fx = _SLS_AmpPainSM.Play(PlayerRef)
		EndIf
		;Sound.SetInstanceVolume(Fx, 1.0)
	EndIf
EndFunction

Function Shutdown()
	;PlayerRef.RemoveSpell(_SLS_CombatChangeDetectSpell)
	;_SLS_AmputationHelplessQuest.Stop()
	;_SLS_AmpArmlessPacifyQuest.Stop()
	;Amputation.Amputate(PlayerRef, 0 , 0)
	RestoreAllLimbs()
	Self.Stop()
EndFunction

Function ForbidBathing()
	If Menu.DismemberBathing
		Int Bath = ModEvent.Create("BiS_ForbidBathing")
		If (Bath)
			ModEvent.PushForm(Bath, self)
			ModEvent.PushForm(Bath, PlayerRef)
			ModEvent.PushString(Bath, "You can not bathe without hands")
			ModEvent.Send(Bath)
		EndIf
	EndIf
EndFunction

Function PermitBathing()
	Int Bath = ModEvent.Create("BiS_PermitBathing")
    If (Bath)
        ModEvent.PushForm(Bath, self)
        ModEvent.PushForm(Bath, PlayerRef)
        ModEvent.Send(Bath)
    EndIf
EndFunction

Function SetWillFollowerEquip(Actor akSpeaker)
	Bool IsColdEnvironment = Frost.IsColdEnvironment()
	Int FollowerWillNotEquip = StorageUtil.GetIntValue(akSpeaker, "_SLS_AmpFollowerWillNotEquip", -1)
	;Debug.Messagebox("FollowerWillNotEquip: " + FollowerWillNotEquip)
	If IsColdEnvironment
		FollowerWillEquip = 2
		
	Else
		If FollowerWillNotEquip == -1 ; Do check
			If Utility.RandomFloat(0.0, 100.0) > 50.0
				StorageUtil.SetIntValue(akSpeaker, "_SLS_AmpFollowerWillNotEquip", 0)
				FollowerWillEquip = 1
			Else
				StorageUtil.SetIntValue(akSpeaker, "_SLS_AmpFollowerWillNotEquip", 1)
				FollowerWillEquip = 0
			EndIf
			ReferenceAlias AliasSelect = GetFollowerEquipAlias()
			If AliasSelect
				(AliasSelect as _SLS_AmpHelplessFolEquipUpdate).LoadAlias(akSpeaker)
			Else
				Debug.Trace("_SLS_: SetWillFollowerEquip: No empty aliases found.")
			EndIf
			
			
		ElseIf FollowerWillNotEquip == 1
			FollowerWillEquip = 0
		Else
			FollowerWillEquip = 1
		EndIf
	EndIf
EndFunction

ReferenceAlias Function GetFollowerEquipAlias()
	ReferenceAlias AliasSelect
	Int i = 1
	While i < _SLS_AmputationHelplessQuest.GetNumAliases()
		AliasSelect = _SLS_AmputationHelplessQuest.GetNthAlias(i) as ReferenceAlias
		If AliasSelect.GetReference() == None
			Return AliasSelect
		EndIf
		i += 1
	EndWhile
	Return None
EndFunction

Function FollowerEquip()
	RegisterForMenu("Dialogue Menu")
	
EndFunction

Event OnMenuClose(String MenuName)
	If MenuName == "Dialogue Menu"
		UnRegisterForMenu("Dialogue Menu")
		_SLS_AmpAllowEquip.SetValue(1)
		RegisterForMenu("InventoryMenu")
		Input.TapKey(Input.GetMappedKey("Quick Inventory"))
	
	ElseIf MenuName == "InventoryMenu"
		UnRegisterForMenu("InventoryMenu")
		_SLS_AmpAllowEquip.SetValue(0)
		Debug.Messagebox("Your follower spends an inordinate amount of time dressing you, paying particular attention to your underwear, pulling them too tight to be comfortable")
	EndIf
EndEvent

Bool Property LeftHandDisabled = false Auto Hidden
Bool Property RightHandDisabled = false Auto Hidden
Bool Property BlockMagic = true Auto Hidden

Bool CanAmpLeftArm = true
Bool CanAmpRightArm = true
Bool CanAmpLeftLeg = true
Bool CanAmpRightLeg = true

Int Property AvailLeftArm = 3 Auto Hidden Conditional
Int Property AvailRightArm = 3 Auto Hidden Conditional
Int Property AvailLeftLeg = 3 Auto Hidden Conditional
Int Property AvailRightLeg = 3 Auto Hidden Conditional

Int Property FollowerWillEquip = 0 Auto Hidden Conditional ; 0 - No, 1 - Yes, 2 - Yes (Frostfall)

;/
Int Property AmpType = 2 Auto Hidden
Int Property AmpDepth = 2 Auto Hidden
Int Property MaxAmpDepthArms = 1 Auto Hidden
Int Property MaxAmpDepthLegs = 1 Auto Hidden

Float Property DismemberHealthThres = 110.0 Auto Hidden
Int Property DismemberDamageThres = 3 Auto Hidden
Int Property DismemberWeapon = 0 Auto Hidden

Int Property MaxAmpedLimbs = 2 Auto Hidden

Float Property DismemberChance = 33.0 Auto Hidden
Float Property DismemberCooldown = 0.5 Auto Hidden
/;

Sound Property _SLS_AmpHurtSM Auto
Sound Property _SLS_AmpPainSM Auto

VoiceType Property CrTrollVoice Auto

Spell Property _SLS_AmpHealEffectSpell Auto
Spell Property _SLS_CombatChangeDetectSpell Auto

Perk Property _SLS_AmputationContainerBlockPerk Auto

ImageSpaceModifier Property _SLS_AmpIomod Auto

MiscObject Property Gold001 Auto

GlobalVariable Property _SLS_PlayerSpeak Auto
GlobalVariable Property _SLS_AmpPriestHealCost Auto
GlobalVariable Property _SLS_AmpIsHandless Auto
GlobalVariable Property _SLS_AmpAllowEquip Auto

Topic Property _SLS_AmpHurt Auto
Topic Property _SLS_AmpPain Auto

Actor Property PlayerRef Auto

Quest Property _SLS_AmputationHelplessQuest Auto
Quest Property _SLS_AmpArmlessPacifyQuest Auto
Quest Property _SLS_InterfaceAmputationQuest Auto

Weapon Property Unarmed Auto

_SLS_InterfaceFrostfall Property Frost Auto
_SLS_InterfaceAmputation Property Amputation Auto
SLS_Mcm Property Menu Auto
