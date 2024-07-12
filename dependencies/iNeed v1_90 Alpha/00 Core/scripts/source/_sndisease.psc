Scriptname _SNDisease extends activemagiceffect  

;====================================================================================

MagicEffect Property DisDamageMagicka Auto
MagicEffect Property DisDamageMagickaRegen Auto
MagicEffect Property DisDamageOnehandedTwohanded Auto
MagicEffect Property DisDamagePickpocketLockpick Auto
MagicEffect Property DisDamageStamina Auto
MagicEffect Property DisDamageStaminaRegen Auto
MagicEffect Property TrapDisDamageMagicka Auto
MagicEffect Property TrapDisDamageMagickaRegen Auto
MagicEffect Property TrapDisDamageOnehandedTwohanded Auto
MagicEffect Property TrapDisDamagePickpocketLockpick Auto
MagicEffect Property TrapDisDamageStamina Auto
MagicEffect Property TrapDisDamageStaminaRegen Auto
MagicEffect Property AlchCureDisease Auto

ImageSpaceModifier Property _SNDiseasedImod Auto
ImageSpaceModifier Property _SNDiseasedMainImod Auto
ImageSpaceModifier Property _SNDiseasedOutroImod Auto

_SNQuestScript Property _SNQuest Auto

Int Stage = 1

Bool Property DiseaseCatcher Auto
Bool Property VanillaDisease Auto
Bool ImageModified
Bool Cured

Actor targ

;====================================================================================

Event OnEffectStart(Actor akTarget, Actor akCaster)
	targ = akTarget
	If DiseaseCatcher
		_SNQuest._SNDiseaseStage.SetValue(1)
	ElseIf VanillaDisease
		GoToState("VanillaDisease")
	Else
		If targ.HasMagicEffect(DisDamageOnehandedTwohanded) || targ.HasMagicEffect(TrapDisDamageOnehandedTwohanded)
			_SNQuest.HasSalmonella = 0
			_SNQuest.DiseaseType = 6
			targ.AddSpell(_SNQuest._SNDisRockjointSpell_1, false)
		ElseIf targ.HasMagicEffect(DisDamageMagicka) || targ.HasMagicEffect(TrapDisDamageMagicka)
			_SNQuest.HasSalmonella = 0
			_SNQuest.DiseaseType = 3
			targ.AddSpell(_SNQuest._SNDisBrainRotSpell_1, false)
		ElseIf targ.HasMagicEffect(DisDamageMagickaRegen) || targ.HasMagicEffect(TrapDisDamageMagickaRegen)
			_SNQuest.HasSalmonella = 0
			_SNQuest.DiseaseType = 8
			targ.AddSpell(_SNQuest._SNDisWitbaneSpell_1, false)
		ElseIf targ.HasMagicEffect(DisDamagePickpocketLockpick) || targ.HasMagicEffect(TrapDisDamagePickpocketLockpick)
			_SNQuest.HasSalmonella = 0
			_SNQuest.DiseaseType = 0
			targ.AddSpell(_SNQuest._SNDisAtaxiaSpell_1, false)
		ElseIf targ.HasMagicEffect(DisDamageStamina) || targ.HasMagicEffect(TrapDisDamageStamina)
			_SNQuest.HasSalmonella = 0
			_SNQuest.DiseaseType = 1
			targ.AddSpell(_SNQuest._SNDisBBFSpell_1, false)
		ElseIf targ.HasMagicEffect(DisDamageStaminaRegen) || targ.HasMagicEffect(TrapDisDamageStaminaRegen)
			_SNQuest.HasSalmonella = 0
			_SNQuest.DiseaseType = 5
			targ.AddSpell(_SNQuest._SNDisRattlesSpell_1, false)
		ElseIf targ.HasMagicEffect(_SNQuest.DiseaseBHB)
			_SNQuest.HasSalmonella = 0
			_SNQuest.DiseaseType = 2
			targ.AddSpell(_SNQuest._SNDisBHBSpell_1, false)
		ElseIf targ.HasMagicEffect(_SNQuest.DiseaseDroops)
			_SNQuest.HasSalmonella = 0
			_SNQuest.DiseaseType = 4
			targ.AddSpell(_SNQuest._SNDisDroopsSpell_1, false)
		ElseIf targ.HasSpell(_SNQuest._SNDisSalmonSpell_1)
			_SNQuest.HasSalmonella = 1
			_SNQuest.DiseaseType = 7
		Else
			_SNQuest._SNDiseaseStage.SetValue(0)
			_SNQuest.CalcCosts(0)
			_SNQuest.IsVanillaDiseased = True
			If _SNQuest.SkyInstalled && _SNQuest.SKSEVersion >= 1.0616
				Utility.Wait(0.5)
				SendModEvent("_SN_StatusUpdated")
			EndIf
			GoToState("Dead")
		EndIf
		If _SNQuest.SkyInstalled && _SNQuest.SKSEVersion >= 1.0616
			Utility.Wait(0.5)
			SendModEvent("_SN_StatusUpdated")
		EndIf
		GoToState("Diseased")
	EndIf
EndEvent

;====================================================================================

State VanillaDisease

	Event OnBeginState()
		Utility.Wait(1.0)
		If _SNQuest._SNDiseaseStage.GetValue() as Int == 0
			_SNQuest.IsVanillaDiseased = True
			_SNQuest.CalcCosts(0)
			If _SNQuest.SkyInstalled && _SNQuest.SKSEVersion >= 1.0616
				Utility.Wait(0.1)
				SendModEvent("_SN_StatusUpdated")
			EndIf
		EndIf
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		_SNQuest.CureDiseaseVanilla()
	EndEvent

EndState

;====================================================================================

Function ResetTime()
	If !Cured
		UnregisterForUpdateGameTime()
		RegisterForSingleUpdateGameTime(Utility.RandomFloat(2.0, 12.0))
	EndIf
	Cured = True
EndFunction

State Diseased

	Event OnBeginState()
		_SNQuest.CalcCosts(Stage)
		targ.AddSpell(_SNQuest._SNFeverPenaltySpell_1, false)
		RegisterForModEvent("_SN_PlayerCured", "OnPlayerCured")
		RegisterForSingleUpdateGameTime(Utility.RandomFloat(6.0, 36.0))
	EndEvent

	Event OnSpellCast(Form akSpell)
		If akSpell as Spell && Stage > 0
			Int n = (akSpell as Spell).GetCostliestEffectIndex() as Int
			If _SNQuest._SNMagicEffect_CureList.HasForm((akSpell as Spell).GetNthEffectMagicEffect(n))
				_SNQuest.DiseaseCuring = True
				ResetTime()
				Debug.Notification(_SNQuest.DiseaseCureText)
			EndIf
		EndIf
		Utility.Wait(0.1)
	EndEvent

	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		If akBaseObject as Potion
			Int iPotion = _SNQuest._SNPotion_CureList.Find(akBaseObject)
			If (iPotion > -1 || akBaseObject == _SNQuest._SNCureDisease)
				If _SNQuest._SNDiseaseStage.GetValue() as Int > 0
					If (iPotion == _SNQuest.DiseaseType || akBaseObject == _SNQuest._SNCureDisease)
						_SNQuest.DiseaseCuring = True
						ResetTime()
						Debug.Notification(_SNQuest.DiseaseCureText)
					EndIf
				Else
					_SNQuest.CureDisease()
				EndIf
			EndIf
		EndIf
	EndEvent

	Event OnUpdateGameTime()
		If !_SNQuest.DiseaseCuring
			If Stage < 4
				Stage += 1
			EndIf
		Else
			Stage -= 1
		EndIf
		_SNQuest.CalcCosts(Stage)
		If Stage == 0
			_SNQuest.CureDisease()
		ElseIf Stage == 1
			_SNQuest.HasSalmonella = 0
			If targ.HasSpell(_SNQuest._SNDisSalmonSpell_2)
				targ.RemoveSpell(_SNQuest._SNDisSalmonSpell_2)
				targ.AddSpell(_SNQuest._SNDisSalmonSpell_1, false)
				_SNQuest.HasSalmonella = 1
			ElseIf targ.HasSpell(_SNQuest._SNDisRockjointSpell_2)
				targ.RemoveSpell(_SNQuest._SNDisRockjointSpell_2)
				targ.AddSpell(_SNQuest._SNDisRockjointSpell_1, false)
			ElseIf targ.HasSpell(_SNQuest._SNDisBrainRotSpell_2)
				targ.RemoveSpell(_SNQuest._SNDisBrainRotSpell_2)
				targ.AddSpell(_SNQuest._SNDisBrainRotSpell_1, false)
			ElseIf targ.HasSpell(_SNQuest._SNDisWitbaneSpell_2)
				targ.RemoveSpell(_SNQuest._SNDisWitbaneSpell_2)
				targ.AddSpell(_SNQuest._SNDisWitbaneSpell_1, false)
			ElseIf targ.HasSpell(_SNQuest._SNDisAtaxiaSpell_2)
				targ.RemoveSpell(_SNQuest._SNDisAtaxiaSpell_2)
				targ.AddSpell(_SNQuest._SNDisAtaxiaSpell_1, false)
			ElseIf targ.HasSpell(_SNQuest._SNDisBBFSpell_2)
				targ.RemoveSpell(_SNQuest._SNDisBBFSpell_2)
				targ.AddSpell(_SNQuest._SNDisBBFSpell_1, false)
			ElseIf targ.HasSpell(_SNQuest._SNDisRattlesSpell_2)
				targ.RemoveSpell(_SNQuest._SNDisRattlesSpell_2)
				targ.AddSpell(_SNQuest._SNDisRattlesSpell_1, false)
			ElseIf targ.HasSpell(_SNQuest._SNDisBHBSpell_2)
				targ.RemoveSpell(_SNQuest._SNDisBHBSpell_2)
				targ.AddSpell(_SNQuest._SNDisBHBSpell_1, false)
			ElseIf targ.HasSpell(_SNQuest._SNDisDroopsSpell_2)
				targ.RemoveSpell(_SNQuest._SNDisDroopsSpell_2)
				targ.AddSpell(_SNQuest._SNDisDroopsSpell_1, false)
			EndIf
			RegisterForSingleUpdateGameTime(Utility.RandomFloat(2.0, 12.0))
		ElseIf Stage == 2
			If !_SNQuest.DiseaseCuring
				If Utility.RandomInt(1, 4) < 4
					_SNQuest.HasSalmonella = 0
					If targ.HasSpell(_SNQuest._SNDisSalmonSpell_1)
						targ.RemoveSpell(_SNQuest._SNDisSalmonSpell_1)
						targ.AddSpell(_SNQuest._SNDisSalmonSpell_2, false)
						_SNQuest.HasSalmonella = 2
					ElseIf targ.HasSpell(_SNQuest._SNDisRockjointSpell_1)
						targ.RemoveSpell(_SNQuest._SNDisRockjointSpell_1)
						targ.AddSpell(_SNQuest._SNDisRockjointSpell_2, false)
					ElseIf targ.HasSpell(_SNQuest._SNDisBrainRotSpell_1)
						targ.RemoveSpell(_SNQuest._SNDisBrainRotSpell_1)
						targ.AddSpell(_SNQuest._SNDisBrainRotSpell_2, false)
					ElseIf targ.HasSpell(_SNQuest._SNDisWitbaneSpell_1)
						targ.RemoveSpell(_SNQuest._SNDisWitbaneSpell_1)
						targ.AddSpell(_SNQuest._SNDisWitbaneSpell_2, false)
					ElseIf targ.HasSpell(_SNQuest._SNDisAtaxiaSpell_1)
						targ.RemoveSpell(_SNQuest._SNDisAtaxiaSpell_1)
						targ.AddSpell(_SNQuest._SNDisAtaxiaSpell_2, false)
					ElseIf targ.HasSpell(_SNQuest._SNDisBBFSpell_1)
						targ.RemoveSpell(_SNQuest._SNDisBBFSpell_1)
						targ.AddSpell(_SNQuest._SNDisBBFSpell_2, false)
					ElseIf targ.HasSpell(_SNQuest._SNDisRattlesSpell_1)
						targ.RemoveSpell(_SNQuest._SNDisRattlesSpell_1)
						targ.AddSpell(_SNQuest._SNDisRattlesSpell_2, false)
					ElseIf targ.HasSpell(_SNQuest._SNDisBHBSpell_1)
						targ.RemoveSpell(_SNQuest._SNDisBHBSpell_1)
						targ.AddSpell(_SNQuest._SNDisBHBSpell_2, false)
					ElseIf targ.HasSpell(_SNQuest._SNDisDroopsSpell_1)
						targ.RemoveSpell(_SNQuest._SNDisDroopsSpell_1)
						targ.AddSpell(_SNQuest._SNDisDroopsSpell_2, false)
					EndIf
					_SNQuest.DiseaseNotification()
					RegisterForSingleUpdateGameTime(Utility.RandomFloat(6.0, 36.0))
				Else
					_SNQuest.CureDisease()
				EndIf
			Else
				_SNQuest.HasSalmonella = 0
				If targ.HasSpell(_SNQuest._SNDisSalmonSpell_3)
					targ.RemoveSpell(_SNQuest._SNDisSalmonSpell_3)
					targ.AddSpell(_SNQuest._SNDisSalmonSpell_2, false)
					_SNQuest.HasSalmonella = 2
				ElseIf targ.HasSpell(_SNQuest._SNDisRockjointSpell_3)
					targ.RemoveSpell(_SNQuest._SNDisRockjointSpell_3)
					targ.AddSpell(_SNQuest._SNDisRockjointSpell_2, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisBrainRotSpell_3)
					targ.RemoveSpell(_SNQuest._SNDisBrainRotSpell_3)
					targ.AddSpell(_SNQuest._SNDisBrainRotSpell_2, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisWitbaneSpell_3)
					targ.RemoveSpell(_SNQuest._SNDisWitbaneSpell_3)
					targ.AddSpell(_SNQuest._SNDisWitbaneSpell_2, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisAtaxiaSpell_3)
					targ.RemoveSpell(_SNQuest._SNDisAtaxiaSpell_3)
					targ.AddSpell(_SNQuest._SNDisAtaxiaSpell_2, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisBBFSpell_3)
					targ.RemoveSpell(_SNQuest._SNDisBBFSpell_3)
					targ.AddSpell(_SNQuest._SNDisBBFSpell_2, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisRattlesSpell_3)
					targ.RemoveSpell(_SNQuest._SNDisRattlesSpell_3)
					targ.AddSpell(_SNQuest._SNDisRattlesSpell_2, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisBHBSpell_3)
					targ.RemoveSpell(_SNQuest._SNDisBHBSpell_3)
					targ.AddSpell(_SNQuest._SNDisBHBSpell_2, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisDroopsSpell_3)
					targ.RemoveSpell(_SNQuest._SNDisDroopsSpell_3)
					targ.AddSpell(_SNQuest._SNDisDroopsSpell_2, false)
				EndIf
				RegisterForSingleUpdateGameTime(Utility.RandomFloat(2.0, 12.0))
			EndIf
		ElseIf Stage == 3
			If !_SNQuest.DiseaseCuring
				_SNQuest.HasSalmonella = 0
				If targ.HasSpell(_SNQuest._SNDisSalmonSpell_2)
					targ.RemoveSpell(_SNQuest._SNDisSalmonSpell_2)
					targ.AddSpell(_SNQuest._SNDisSalmonSpell_3, false)
					_SNQuest.HasSalmonella = 3
				ElseIf targ.HasSpell(_SNQuest._SNDisRockjointSpell_2)
					targ.RemoveSpell(_SNQuest._SNDisRockjointSpell_2)
					targ.AddSpell(_SNQuest._SNDisRockjointSpell_3, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisBrainRotSpell_2)
					targ.RemoveSpell(_SNQuest._SNDisBrainRotSpell_2)
					targ.AddSpell(_SNQuest._SNDisBrainRotSpell_3, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisWitbaneSpell_2)
					targ.RemoveSpell(_SNQuest._SNDisWitbaneSpell_2)
					targ.AddSpell(_SNQuest._SNDisWitbaneSpell_3, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisAtaxiaSpell_2)
					targ.RemoveSpell(_SNQuest._SNDisAtaxiaSpell_2)
					targ.AddSpell(_SNQuest._SNDisAtaxiaSpell_3, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisBBFSpell_2)
					targ.RemoveSpell(_SNQuest._SNDisBBFSpell_2)
					targ.AddSpell(_SNQuest._SNDisBBFSpell_3, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisRattlesSpell_2)
					targ.RemoveSpell(_SNQuest._SNDisRattlesSpell_2)
					targ.AddSpell(_SNQuest._SNDisRattlesSpell_3, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisBHBSpell_2)
					targ.RemoveSpell(_SNQuest._SNDisBHBSpell_2)
					targ.AddSpell(_SNQuest._SNDisBHBSpell_3, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisDroopsSpell_2)
					targ.RemoveSpell(_SNQuest._SNDisDroopsSpell_2)
					targ.AddSpell(_SNQuest._SNDisDroopsSpell_3, false)
				EndIf
				_SNQuest.DiseaseNotification()
				RegisterForSingleUpdateGameTime(Utility.RandomFloat(6.0, 36.0))
			Else
				OnEffectFinish(targ, targ)
				_SNQuest.HasSalmonella = 0
				If targ.HasSpell(_SNQuest._SNDisSalmonSpell_4)
					targ.RemoveSpell(_SNQuest._SNDisSalmonSpell_4)
					targ.AddSpell(_SNQuest._SNDisSalmonSpell_3, false)
					_SNQuest.HasSalmonella = 3
				ElseIf targ.HasSpell(_SNQuest._SNDisRockjointSpell_4)
					targ.RemoveSpell(_SNQuest._SNDisRockjointSpell_4)
					targ.AddSpell(_SNQuest._SNDisRockjointSpell_3, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisBrainRotSpell_4)
					targ.RemoveSpell(_SNQuest._SNDisBrainRotSpell_4)
					targ.AddSpell(_SNQuest._SNDisBrainRotSpell_3, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisWitbaneSpell_4)
					targ.RemoveSpell(_SNQuest._SNDisWitbaneSpell_4)
					targ.AddSpell(_SNQuest._SNDisWitbaneSpell_3, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisAtaxiaSpell_4)
					targ.RemoveSpell(_SNQuest._SNDisAtaxiaSpell_4)
					targ.AddSpell(_SNQuest._SNDisAtaxiaSpell_3, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisBBFSpell_4)
					targ.RemoveSpell(_SNQuest._SNDisBBFSpell_4)
					targ.AddSpell(_SNQuest._SNDisBBFSpell_3, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisRattlesSpell_4)
					targ.RemoveSpell(_SNQuest._SNDisRattlesSpell_4)
					targ.AddSpell(_SNQuest._SNDisRattlesSpell_3, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisBHBSpell_4)
					targ.RemoveSpell(_SNQuest._SNDisBHBSpell_4)
					targ.AddSpell(_SNQuest._SNDisBHBSpell_3, false)
				ElseIf targ.HasSpell(_SNQuest._SNDisDroopsSpell_4)
					targ.RemoveSpell(_SNQuest._SNDisDroopsSpell_4)
					targ.AddSpell(_SNQuest._SNDisDroopsSpell_3, false)
				EndIf
				RegisterForSingleUpdateGameTime(Utility.RandomFloat(2.0, 12.0))
			EndIf
		Else
			If !ImageModified
				_SNDiseasedImod.Apply()
				Utility.Wait(9.5)
				_SNDiseasedMainImod.Apply()
				ImageModified = True
			EndIf
			_SNQuest.HasSalmonella = 0
			If targ.HasSpell(_SNQuest._SNDisSalmonSpell_3)
				targ.RemoveSpell(_SNQuest._SNDisSalmonSpell_3)
				targ.AddSpell(_SNQuest._SNDisSalmonSpell_4, false)
				_SNQuest.HasSalmonella = 4
			ElseIf targ.HasSpell(_SNQuest._SNDisRockjointSpell_3)
				targ.RemoveSpell(_SNQuest._SNDisRockjointSpell_3)
				targ.AddSpell(_SNQuest._SNDisRockjointSpell_4, false)
			ElseIf targ.HasSpell(_SNQuest._SNDisBrainRotSpell_3)
				targ.RemoveSpell(_SNQuest._SNDisBrainRotSpell_3)
				targ.AddSpell(_SNQuest._SNDisBrainRotSpell_4, false)
			ElseIf targ.HasSpell(_SNQuest._SNDisWitbaneSpell_3)
				targ.RemoveSpell(_SNQuest._SNDisWitbaneSpell_3)
				targ.AddSpell(_SNQuest._SNDisWitbaneSpell_4, false)
			ElseIf targ.HasSpell(_SNQuest._SNDisAtaxiaSpell_3)
				targ.RemoveSpell(_SNQuest._SNDisAtaxiaSpell_3)
				targ.AddSpell(_SNQuest._SNDisAtaxiaSpell_4, false)
			ElseIf targ.HasSpell(_SNQuest._SNDisBBFSpell_3)
				targ.RemoveSpell(_SNQuest._SNDisBBFSpell_3)
				targ.AddSpell(_SNQuest._SNDisBBFSpell_4, false)
			ElseIf targ.HasSpell(_SNQuest._SNDisRattlesSpell_3)
				targ.RemoveSpell(_SNQuest._SNDisRattlesSpell_3)
				targ.AddSpell(_SNQuest._SNDisRattlesSpell_4, false)
			ElseIf targ.HasSpell(_SNQuest._SNDisBHBSpell_3)
				targ.RemoveSpell(_SNQuest._SNDisBHBSpell_3)
				targ.AddSpell(_SNQuest._SNDisBHBSpell_4, false)
			ElseIf targ.HasSpell(_SNQuest._SNDisDroopsSpell_3)
				targ.RemoveSpell(_SNQuest._SNDisDroopsSpell_3)
				targ.AddSpell(_SNQuest._SNDisDroopsSpell_4, false)
			EndIf
			If _SNQuest.Death
				Float CurrentHealth = targ.GetBaseActorValue("Health")
				targ.DamageActorValue("Health", Utility.RandomFloat(CurrentHealth / 3, CurrentHealth * 1.2))
				Float CurrentStamina = targ.GetBaseActorValue("Stamina")
				targ.DamageActorValue("Stamina", Utility.RandomFloat(CurrentStamina / 2, CurrentStamina))
				Float CurrentMagicka = targ.GetBaseActorValue("Magicka")
				targ.DamageActorValue("Magicka", Utility.RandomFloat(CurrentMagicka / 2, CurrentMagicka))
				RegisterForSingleUpdateGameTime(0.5)
			Else
				RegisterForSingleUpdateGameTime(Utility.RandomFloat(6.0, 36.0))
			EndIf
			_SNQuest.DiseaseNotification()
		EndIf
		_SNQuest._SNDiseaseStage.SetValue(Stage)
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		_SNQuest.CureDisease()
		If ImageModified
			_SNDiseasedOutroImod.Apply()
			Utility.Wait(0.5)
			_SNDiseasedImod.Remove()
			_SNDiseasedMainImod.Remove()
			Utility.Wait(10.0)
			_SNDiseasedOutroImod.Remove()
			ImageModified = False
		EndIf
	EndEvent

EndState

State Dead
EndState