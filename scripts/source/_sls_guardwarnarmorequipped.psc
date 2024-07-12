Scriptname _SLS_GuardWarnArmorEquipped extends ReferenceAlias  

Event OnInit()
	If Self.GetOwningQuest().IsRunning()
		SlotMasks = new Int[5]
		SlotMasks[0] = 1 ; kSlotMask30 Head
		SlotMasks[1] = 2 ; kSlotMask31 Hair
		SlotMasks[2] = 4 ; kSlotMask32 Body
		SlotMasks[3] = 8 ; kSlotMask33 Hands
		;SlotMasks[4] = 16 ; kSlotMask34
		;SlotMasks[5] = 32 ; kSlotMask35
		;SlotMasks[6] = 64 ; kSlotMask36
		SlotMasks[4] = 128 ; kSlotMask37 Feet
		;SlotMasks[8] = 256 ; kSlotMask38
		;SlotMasks[9] = 512 ; kSlotMask39
		;SlotMasks[10] = 1024 ; kSlotMask40
		;SlotMasks[11] = 2048 ; kSlotMask41
		;SlotMasks[12] = 4096 ; kSlotMask42
		;SlotMasks[13] = 8192 ; kSlotMask43
		;SlotMasks[14] = 16384 ; kSlotMask44
		;SlotMasks[15] = 32768 ; kSlotMask45
		;SlotMasks[16] = 65536 ; kSlotMask46
		;SlotMasks[17] = 131072 ; kSlotMask47
		;SlotMasks[18] = 262144 ; kSlotMask48
		;SlotMasks[19] = 524288 ; kSlotMask49
		;SlotMasks[20] = 1048576 ; kSlotMask50
		;SlotMasks[21] = 2097152 ; kSlotMask51
		;SlotMasks[22] = 4194304 ; kSlotMask52
		;SlotMasks[23] = 8388608 ; kSlotMask53
		;SlotMasks[24] = 16777216 ; kSlotMask54
		;SlotMasks[25] = 33554432 ; kSlotMask55
		;SlotMasks[26] = 67108864 ; kSlotMask56
		;SlotMasks[27] = 134217728 ; kSlotMask57
		;SlotMasks[28] = 268435456 ; kSlotMask58
		;SlotMasks[29] = 536870912 ; kSlotMask59
		;SlotMasks[30] = 1073741824 ; kSlotMask60
		;SlotMasks[31] = 0x80000000 ; kSlotMask61
		
		RegisterForSingleUpdate(7.0) ; Wait some time after entering a city
	EndIf
EndEvent

Event OnUpdate()
	If DoDetection
		DoGuardDetection()
		
	Else
		If IsWearingArmor()
			BeginGuardDetection()
		Else
			;Debug.Messagebox("UnREGISTER")
			UnRegisterForUpdate()
		EndIf
	EndIf
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	If !InProc && akBaseObject as Armor
		If IsArmorViolation(akBaseObject, akBaseObject as Armor)
			If UI.IsMenuOpen("InventoryMenu")
				InProc = true
				Utility.Wait(2.0)
				If IsWearingArmor()
					BeginGuardDetection()
					InProc = false
				EndIf
			Else
				BeginGuardDetection()
			EndIf
		EndIf
	EndIf
EndEvent

Bool Function IsWearingArmor()
	If StorageUtil.GetIntValue(Menu, "GuardBehavArmorEquipAnyArmor", Missing = 0) == 0
		Int i = 0
		Form akForm
		Armor akArmor
		While i < SlotMasks.Length
			akForm = PlayerRef.GetWornForm(SlotMasks[i])
			If akForm
				akArmor = akForm as Armor
				If IsArmorViolation(akForm, akArmor)
					;Debug.Messagebox("TRUE")
					Return true
				EndIf
			EndIf
			i += 1
		EndWhile
	
	Else
		If PlayerRef.WornHasKeyword(ArmorLight) || PlayerRef.WornHasKeyword(ArmorHeavy) ; Doesn't check for licence exceptions
			;Debug.Messagebox("TRUE")
			Return true
		EndIf
	EndIf
	;Debug.Messagebox("FALSE")
	Return false
EndFunction

Bool Function IsArmorViolation(Form akForm, Armor akArmor)
	If akArmor.GetWeightClass() < 2 ; Light or heavy
		If !akForm.HasKeyword(SexlabNoStrip) && akArmor.IsPlayable() && (akForm.HasKeyword(ArmorLight) || akForm.HasKeyword(ArmorHeavy)) && !_SLS_LicExceptionsArmor.HasForm(akForm)
			Return true
		EndIf
	EndIf
	Return false
EndFunction

Function BeginGuardDetection()
	DoDetection = true
	RegisterForSingleUpdate(3.0)
EndFunction

Function DoGuardDetection()
	If !CheckIsDetected()
		RegForUpdate()
	Else
		While _SLS_GuardWarnArmorEquippedDetectQuest.IsRunning() || UI.IsMenuOpen("Dialogue Menu")
			Utility.Wait(8.0)
		EndWhile
		If IsWearingArmor()
			DoDetection = true
		Else
			DoDetection = false
		EndIf
		RegForUpdate()
	EndIf
EndFunction

Function RegForUpdate()
	If PlayerRef.IsInCombat()
		RegisterForSingleUpdate(30.0)
	Else
		RegisterForSingleUpdate(3.0)
	EndIf
EndFunction

Bool Function CheckIsDetected()
	; _SLS_GuardWarnTypeAndCooldown - 0: Nothing, 1: Armor equipped, 2: Drugs, 3: Lockpicking, 4: Shouting, 5: Weapons drop, 6: Weapons drawn, 7: Weapons equipped

	If _SLS_GuardWarnTypeAndCooldown.GetValueInt() == 0 ; Check is another warning in progress or in cooldown
		_SLS_PlayerIsAIDriven.SetValueInt((PlayerRef.GetCurrentPackage() != None) as Int)
		_SLS_GuardWarnArmorEquippedDetectQuest.Stop()
		_SLS_GuardWarnArmorEquippedDetectQuest.Start()
		Actor Guard = (_SLS_GuardWarnArmorEquippedDetectQuest.GetNthAlias(0) as ReferenceAlias).GetReference() as Actor
		If Guard ; Detected
			_SLS_GuardWarnTypeAndCooldown.SetValueInt(1)
			If Guard.IsInFaction(_SLS_GuardBehaviourWarningFact)
				_SLS_GuardWarnArmorEquippedDetectQuest.Stop()
				Util.SendBeginGuardWarnPunishEvent(_SLS_GuardWarnArmorEquippedDetectQuest, Guard)
			EndIf
			_SLS_GuardWarnDoApproach.SetValueInt(1)
			Guard.EvaluatePackage()
			Return true
		Else ; Not detected
			_SLS_GuardWarnArmorEquippedDetectQuest.Stop()
			Return false
		EndIf
		
	ElseIf _SLS_GuardWarnTypeAndCooldown.GetValueInt() == 1 && _SLS_GuardWarnCooldownQuest.IsRunning()
		DoDetection = false
	EndIf
	Return false
EndFunction

Faction Property _SLS_GuardBehaviourWarningFact Auto

GlobalVariable Property _SLS_GuardWarnDoApproach Auto
GlobalVariable Property _SLS_GuardWarnTypeAndCooldown Auto
GlobalVariable Property _SLS_PlayerIsAIDriven Auto

Formlist Property _SLS_LicExceptionsArmor Auto

Quest Property _SLS_GuardWarnArmorEquippedDetectQuest Auto
Quest Property _SLS_GuardWarnCooldownQuest Auto

Actor Property PlayerRef Auto

Keyword Property SexlabNoStrip Auto
Keyword Property ArmorLight Auto
Keyword Property ArmorHeavy Auto

SLS_Utility Property Util Auto
SLS_Mcm Property Menu Auto

Bool InProc = false
Bool DoDetection = false

Int[] SlotMasks
