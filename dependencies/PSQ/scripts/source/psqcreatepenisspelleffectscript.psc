Scriptname PSQCreatePenisSpellEffectScript Extends ActiveMagicEffect

PlayerSuccubusQuestScript Property PSQ Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If akTarget.GetLeveledActorBase().GetSex() == 1
		If akTarget == PSQ.PlayerRef
			If StorageUtil.GetIntValue(akTarget, "PSQ_HasPenis") == 1
				akTarget.UnequipItem(PSQ.FemaleSchlongA, True, True)
				akTarget.UnequipItem(PSQ.FemaleSchlongB, True, True)
				akTarget.UnequipItem(PSQ.FemaleSchlongC, True, True)
				akTarget.UnequipItem(PSQ.FemaleSchlongD, True, True)
				akTarget.UnequipItem(PSQ.FemaleSchlongE, True, True)
				akTarget.RemoveItem(PSQ.FemaleSchlongA, akTarget.GetItemCount(PSQ.FemaleSchlongA), True)
				akTarget.RemoveItem(PSQ.FemaleSchlongB, akTarget.GetItemCount(PSQ.FemaleSchlongB), True)
				akTarget.RemoveItem(PSQ.FemaleSchlongC, akTarget.GetItemCount(PSQ.FemaleSchlongC), True)
				akTarget.RemoveItem(PSQ.FemaleSchlongD, akTarget.GetItemCount(PSQ.FemaleSchlongD), True)
				akTarget.RemoveItem(PSQ.FemaleSchlongE, akTarget.GetItemCount(PSQ.FemaleSchlongE), True)
				StorageUtil.SetIntValue(akTarget, "PSQ_HasPenis", 0)
				akTarget.RemoveSpell(PSQ.PowerOfFutanari)
				If PSQ.AutoGenderSwitch && PSQ.SexLab.GetGender(akTarget) == 0
					PSQ.SexLab.ClearForcedGender(akTarget)
				EndIf
			Else
				If PSQ.IsHenshined
					akTarget.AddItem(PSQ.PlayerSuccubusSchlong, 1, True)
					akTarget.EquipItem(PSQ.PlayerSuccubusSchlong, True, True)
				Else
					akTarget.AddItem(PSQ.PlayerHumanSchlong, 1, True)
					akTarget.EquipItem(PSQ.PlayerHumanSchlong, True, True)
				EndIf
				StorageUtil.SetIntValue(akTarget, "PSQ_HasPenis", 1)
				If PSQ.EnableFutanariPower
					akTarget.AddSpell(PSQ.PowerOfFutanari, False)
				EndIf
				If PSQ.AutoGenderSwitch
					PSQ.SexLab.TreatAsMale(akTarget)
				EndIf
			EndIf
		Else
			If StorageUtil.GetIntValue(akTarget, "PSQ_HasPenis") == 1
				akTarget.UnequipItem(PSQ.FemaleSchlongA, True, True)
				akTarget.UnequipItem(PSQ.FemaleSchlongB, True, True)
				akTarget.UnequipItem(PSQ.FemaleSchlongC, True, True)
				akTarget.UnequipItem(PSQ.FemaleSchlongD, True, True)
				akTarget.UnequipItem(PSQ.FemaleSchlongE, True, True)
				akTarget.RemoveItem(PSQ.FemaleSchlongA, akTarget.GetItemCount(PSQ.FemaleSchlongA), True)
				akTarget.RemoveItem(PSQ.FemaleSchlongB, akTarget.GetItemCount(PSQ.FemaleSchlongB), True)
				akTarget.RemoveItem(PSQ.FemaleSchlongC, akTarget.GetItemCount(PSQ.FemaleSchlongC), True)
				akTarget.RemoveItem(PSQ.FemaleSchlongD, akTarget.GetItemCount(PSQ.FemaleSchlongD), True)
				akTarget.RemoveItem(PSQ.FemaleSchlongE, akTarget.GetItemCount(PSQ.FemaleSchlongE), True)
				StorageUtil.SetIntValue(akTarget, "PSQ_HasPenis", 0)
				akTarget.RemoveSpell(PSQ.PowerOfFutanari)
				If PSQ.AutoGenderSwitch && PSQ.SexLab.GetGender(akTarget) == 0
					PSQ.SexLab.ClearForcedGender(akTarget)
				EndIf
			Else
				Int i = PSQ.SelectSchlongMSGBox.Show()
				If i == 0
					akTarget.AddItem(PSQ.FemaleSchlongA, 1, True)
					akTarget.EquipItem(PSQ.FemaleSchlongA, True, True)
				ElseIf i == 1
					akTarget.AddItem(PSQ.FemaleSchlongB, 1, True)
					akTarget.EquipItem(PSQ.FemaleSchlongB, True, True)
				ElseIf i == 2
					akTarget.AddItem(PSQ.FemaleSchlongC, 1, True)
					akTarget.EquipItem(PSQ.FemaleSchlongC, True, True)
				ElseIf i == 3
					akTarget.AddItem(PSQ.FemaleSchlongD, 1, True)
					akTarget.EquipItem(PSQ.FemaleSchlongD, True, True)
				ElseIf i == 4
					akTarget.AddItem(PSQ.FemaleSchlongE, 1, True)
					akTarget.EquipItem(PSQ.FemaleSchlongE, True, True)
				EndIf
				StorageUtil.SetIntValue(akTarget, "PSQ_HasPenis", 1)
				If PSQ.EnableFutanariPower
					akTarget.AddSpell(PSQ.PowerOfFutanari, False)
				EndIf
				If PSQ.AutoGenderSwitch
					PSQ.SexLab.TreatAsMale(akTarget)
				EndIf
			EndIf
		EndIf
	EndIf
EndEvent
