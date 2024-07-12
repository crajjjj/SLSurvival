ScriptName mzinPlayBathingAnimation Extends ActiveMagicEffect
{ this script plays bathing and showering animations based on properties }

Bool Property UsingSoap Auto
Bool Property Showering Auto

Spell Property PlayBatheAnimationWithSoap Auto
Spell Property PlayBatheAnimationWithoutSoap Auto
Spell Property PlayShowerAnimationWithSoap Auto
Spell Property PlayShowerAnimationWithoutSoap Auto

FormList Property DirtinessSpellList Auto

FormList Property BathingAnimationLoopCountList Auto
FormList Property BathingAnimationLoopCountListFollowers Auto

GlobalVariable Property GetSoapyStyle Auto
GlobalVariable Property GetSoapyStyleFollowers Auto

GlobalVariable Property BathingAnimationStyle Auto
GlobalVariable Property BathingAnimationStyleFollowers Auto

GlobalVariable Property ShoweringAnimationStyle Auto
GlobalVariable Property ShoweringAnimationStyleFollowers Auto

GlobalVariable Property GetDressedAfterBathingEnabled Auto
GlobalVariable Property GetDressedAfterBathingEnabledFollowers Auto
GlobalVariable Property BathingIgnoredArmorSlotsMask Auto
GlobalVariable Property BathingIgnoredArmorSlotsMaskFollowers Auto

Spell Property SoapyAppearanceSpell Auto
Spell Property SoapyAppearanceAnimatedSpell Auto

Idle Property BathingAnimationStop Auto

Message Property BathingCompleteMessage Auto

Package Property StopMovementPackage Auto

Form[] Clothing
Actor  BathingActor
Bool   BathingActorIsPlayer

String AnimationEventNameToSend
String AnimationEventNameToReceive
Bool AnimationSequenceComplete
Int AnimationCyclesRemaining

Int BailOutSecondsPerLoop = 60
Int BailOutSecondsRemaining

Event OnEffectStart(Actor Target, Actor Caster)
	BathingActor = Target
	BathingActorIsPlayer = (Target == Game.GetPlayer())

	StartAnimation()
EndEvent

; bathing
Function PlayBathingAnimationDefault()
	Debug.SendAnimationEvent(BathingActor, "IdleWarmHandsCrouched")
	Utility.Wait(3)

	GetSoapy()

	Debug.SendAnimationEvent(BathingActor, "IdleStop")
	Utility.Wait(1.5)

	While AnimationCyclesRemaining > 0	
		AnimationCyclesRemaining -= 1	
		Debug.SendAnimationEvent(BathingActor, "IdleWarmArms")
		Utility.Wait(2)
		Debug.SendAnimationEvent(BathingActor, "IdleStop")
		Utility.Wait(1)
	EndWhile

	RinseOff()
	StopAnimation()
EndFunction
Function PlayBathingAnimationCustom1()
	GetSoapy()

	If UsingSoap
		StartAnimationSequence("mzinBatheA1_S1_Soap", "mzinBatheA1_S2_Soap_DONE")
	Else
		StartAnimationSequence("mzinBatheA1_S1_Cloth", "mzinBatheA1_S2_Cloth_DONE")
	EndIf

	BailOutSecondsRemaining = BailOutSecondsPerLoop
	While AnimationSequenceComplete == False && BailOutSecondsRemaining > 0
		Utility.Wait(1)
		BailOutSecondsRemaining -= 1
	EndWhile

	GetUnsoapy()	
	StopAnimation()
EndFunction
Function PlayBathingAnimationCustom2()
	GetSoapy()

	If UsingSoap
		StartAnimationSequence("mzinBatheA2_S1_Soap", "mzinBatheA2_S2_Soap_DONE")
	Else
		StartAnimationSequence("mzinBatheA2_S1_Cloth", "mzinBatheA2_S2_Cloth_DONE")
	EndIf

	BailOutSecondsRemaining = BailOutSecondsPerLoop
	While AnimationSequenceComplete == False && BailOutSecondsRemaining > 0
		Utility.Wait(1)
		BailOutSecondsRemaining -= 1
	EndWhile

	RinseOff()
	StopAnimation()
EndFunction
Function PlayBathingAnimationCustom3()
	Debug.SendAnimationEvent(BathingActor, "IdleWarmHandsCrouched")
	Utility.Wait(3)

	GetSoapy()

	If UsingSoap
		StartAnimationSequence("mzinBatheA3_S1_Soap", "mzinBatheA3_S3_Soap_DONE")
	Else
		StartAnimationSequence("mzinBatheA3_S1_Cloth", "mzinBatheA3_S3_Cloth_DONE")
	EndIf

	BailOutSecondsRemaining = BailOutSecondsPerLoop
	While AnimationSequenceComplete == False && BailOutSecondsRemaining > 0
		Utility.Wait(1)
		BailOutSecondsRemaining -= 1
	EndWhile

	RinseOff()
	StopAnimation()
EndFunction

; showering
Function PlayShoweringAnimationDefault()
	GetSoapy()

	While AnimationCyclesRemaining > 0	
		AnimationCyclesRemaining -= 1	
		Debug.SendAnimationEvent(BathingActor, "IdleWarmArms")
		Utility.Wait(2)
		Debug.SendAnimationEvent(BathingActor, "IdleStop")
		Utility.Wait(1)
	EndWhile

	GetUnsoapy()	
	StopAnimation()
EndFunction
Function PlayShoweringAnimationCustom1()
	GetSoapy()

	If UsingSoap
		StartAnimationSequence("mzinBatheA2_S1_Soap", "mzinBatheA2_S2_Soap_DONE")
	Else
		StartAnimationSequence("mzinBatheA2_S1_Cloth", "mzinBatheA2_S2_Cloth_DONE")
	EndIf

	BailOutSecondsRemaining = BailOutSecondsPerLoop
	While AnimationSequenceComplete == False && BailOutSecondsRemaining > 0
		Utility.Wait(1)
		BailOutSecondsRemaining -= 1
	EndWhile

	Debug.SendAnimationEvent(BathingActor, "IdleStop")
	Utility.Wait(1)

	Debug.SendAnimationEvent(BathingActor, "IdleWipeBrow")
	Utility.Wait(3)

	GetUnsoapy()
	StopAnimation()
EndFunction

; helpers
Function StartAnimation()
	If BathingActorIsPlayer == False
		ActorUtil.AddPackageOverride(BathingActor, StopMovementPackage, 1)
		BathingActor.EvaluatePackage()
	EndIf

	GetNaked()

	Int DirtinessTier = 0
	
	Int DirtinessTierIndex = DirtinessSpellList.GetSize()
	While DirtinessTierIndex
		DirtinessTierIndex -= 1
		If BathingActor.HasSpell(DirtinessSpellList.GetAt(DirtinessTierIndex) As Spell)
			DirtinessTier = DirtinessTierIndex
		EndIf
	EndWhile

	Int AnimationStyle = 0
	If BathingActorIsPlayer
		If Showering
			AnimationStyle = ShoweringAnimationStyle.GetValue() As Int
		Else
			AnimationStyle = BathingAnimationStyle.GetValue() As Int
		EndIf
		AnimationCyclesRemaining = (BathingAnimationLoopCountList.GetAt(DirtinessTier) As GlobalVariable).GetValue() As Int
	Else
		If Showering
			AnimationStyle = ShoweringAnimationStyleFollowers.GetValue() As Int
		Else
			AnimationStyle = BathingAnimationStyleFollowers.GetValue() As Int
		EndIf
		AnimationCyclesRemaining = (BathingAnimationLoopCountListFollowers.GetAt(DirtinessTier) As GlobalVariable).GetValue() As Int
	EndIf

	If AnimationStyle > 0 && BathingActor.IsSwimming() == False
	
		If BathingActorIsPlayer
			Game.ForceThirdPerson()
			Game.DisablePlayerControls(True, True, False, False, True, False, True)
		EndIf

		BathingActor.PlayIdle(BathingAnimationStop)

		If Showering
			If AnimationStyle == 1
				PlayShoweringAnimationDefault()
			ElseIf AnimationStyle == 2
				PlayShoweringAnimationCustom1()
			EndIf
		Else
			If AnimationStyle == 1
				PlayBathingAnimationDefault()
			ElseIf AnimationStyle == 2
				PlayBathingAnimationCustom1()
			ElseIf AnimationStyle == 3
				PlayBathingAnimationCustom2()
			ElseIf AnimationStyle == 4
				PlayBathingAnimationCustom3()
			EndIf
		EndIf

	EndIf
EndFunction
Function StopAnimation()
	BathingActor.PlayIdle(BathingAnimationStop)

	If BathingActor.HasSpell(SoapyAppearanceSpell)
		BathingActor.RemoveSpell(SoapyAppearanceSpell)
	EndIf

	If BathingActor.HasSpell(SoapyAppearanceAnimatedSpell)
		BathingActor.RemoveSpell(SoapyAppearanceAnimatedSpell)
	EndIf

	If BathingActorIsPlayer
		Game.EnablePlayerControls()
	EndIf	

	GetDressed()

	If BathingActorIsPlayer == False
		ActorUtil.RemovePackageOverride(BathingActor, StopMovementPackage)
		BathingActor.EvaluatePackage()
	EndIf

	If BathingActorIsPlayer
		BathingCompleteMessage.Show()
	EndIf

	BathingActor.RemoveSpell(PlayBatheAnimationWithSoap)
	BathingActor.RemoveSpell(PlayBatheAnimationWithoutSoap)
	BathingActor.RemoveSpell(PlayShowerAnimationWithSoap)
	BathingActor.RemoveSpell(PlayShowerAnimationWithoutSoap)
EndFunction
Function GetSoapy()
	If UsingSoap
		If BathingActorIsPlayer
			If GetSoapyStyle.GetValue() == 1
				BathingActor.AddSpell(SoapyAppearanceSpell, False)
			ElseIf GetSoapyStyle.GetValue() == 2
				BathingActor.AddSpell(SoapyAppearanceAnimatedSpell, False)
			EndIf
		Else
			If GetSoapyStyleFollowers.GetValue() == 1
				BathingActor.AddSpell(SoapyAppearanceSpell, False)
			ElseIf GetSoapyStyleFollowers.GetValue() == 2
				BathingActor.AddSpell(SoapyAppearanceAnimatedSpell, False)
			EndIf
		EndIf
	EndIf
EndFunction
Function GetUnsoapy()
	If BathingActor.HasSpell(SoapyAppearanceSpell)
		BathingActor.RemoveSpell(SoapyAppearanceSpell)
	ElseIf BathingActor.HasSpell(SoapyAppearanceAnimatedSpell)
		BathingActor.RemoveSpell(SoapyAppearanceAnimatedSpell)
	EndIf
EndFunction
Function GetNaked()
	Clothing = new Form[33]

	Int CurrentIgnoreArmorSlotMask = 0 
	If BathingActorIsPlayer
		CurrentIgnoreArmorSlotMask = BathingIgnoredArmorSlotsMask.GetValue() As Int
	Else
		CurrentIgnoreArmorSlotMask = BathingIgnoredArmorSlotsMaskFollowers.GetValue() As Int
	EndIf
	
	Int Index = Clothing.Length
	While Index
		Index -= 1
		Int ArmorSlotMask = Armor.GetMaskForSlot(Index + 30)
		If Math.LogicalAnd(ArmorSlotMask, CurrentIgnoreArmorSlotMask) != ArmorSlotMask
			Clothing[Index] = BathingActor.GetWornForm(ArmorSlotMask)
			If Clothing[Index]
				BathingActor.UnequipItem(Clothing[Index], False, True)
			EndIf
		EndIf		
	EndWhile
	
	; weapons
	BathingActor.UnequipItemEX(BathingActor.GetEquippedWeapon(True),  2, False) ; left hand
	BathingActor.UnequipItemEX(BathingActor.GetEquippedWeapon(False), 1, False) ; right hand
EndFunction
Function GetDressed()
	If (BathingActorIsPlayer == True  && GetDressedAfterBathingEnabled.GetValue() As Bool) \
	|| (BathingActorIsPlayer == False && GetDressedAfterBathingEnabledFollowers.GetValue() As Bool)
		
		Int ClothingIndex = Clothing.Length
		While ClothingIndex
			ClothingIndex -= 1
			If Clothing[ClothingIndex]
				BathingActor.EquipItem(Clothing[ClothingIndex], False, True)
			EndIf
		EndWhile
	EndIf
EndFunction
Function RinseOff()
	Debug.SendAnimationEvent(BathingActor, "IdleStop")
	Utility.Wait(1)

	Debug.SendAnimationEvent(BathingActor, "IdleSearchingChest")
	Utility.Wait(3)

	GetUnsoapy()

	Debug.SendAnimationEvent(BathingActor, "IdleStop")
	Utility.Wait(1)

	Debug.SendAnimationEvent(BathingActor, "IdleWipeBrow")
	Utility.Wait(3)
EndFunction

Function StartAnimationSequence(String AnimationEventToPlay, String AnimationEventToWaitFor)
	AnimationSequenceComplete = False
	AnimationEventNameToSend = AnimationEventToPlay
	AnimationEventNameToReceive = AnimationEventToWaitFor
	Debug.SendAnimationEvent(BathingActor, AnimationEventNameToSend)
	Utility.Wait(1)
	Self.RegisterForAnimationEvent(BathingActor, AnimationEventNameToReceive)
	AnimationCyclesRemaining -= 1
EndFunction
Event OnAnimationEvent(ObjectReference Source, string EventName)
	If Source == BathingActor && EventName == AnimationEventNameToReceive
		If AnimationCyclesRemaining > 0
			AnimationCyclesRemaining -= 1
			Utility.Wait(0.5)
			BailOutSecondsRemaining = BailOutSecondsPerLoop
			Debug.SendAnimationEvent(BathingActor, AnimationEventNameToSend)
		Else
			AnimationSequenceComplete = True
			Self.UnregisterForAnimationEvent(BathingActor, AnimationEventNameToReceive)
		EndIf
	EndIf
EndEvent