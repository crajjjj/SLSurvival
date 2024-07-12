Scriptname SuccubusHESHINNScript Extends ActiveMagicEffect

PlayerSuccubusQuestScript Property PSQ Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If !PSQ.IsHenshinchu && akCaster == PSQ.PlayerRef
		If !PSQ.IsHenshined
			StorageUtil.SetIntValue(Game.GetPlayer(), "PSQ_SuccubusON", 1)
			Henshin(akCaster)
		Else
			StorageUtil.SetIntValue(Game.GetPlayer(), "PSQ_SuccubusON", 0)
			DisHenshin(akCaster)
		EndIf
	EndIf
EndEvent

Function Henshin(Actor Succu)
	PSQ.IsHenshinchu = True
	PSQ.IsHenshined = True
	
	;変身時に出るエフェクト
	Int HenshinMoan = PSQ.SoundHenshinMoan.Play(Succu)
	PSQ.SuccubusTransFXS.Play(Succu, 0.5)
	Utility.Wait(0.5)
	PSQ.FireFXShader.Play(Succu, 0.5)
	PSQ.ShockPlayerCloakFXShader.Play(Succu, 0.5)
	
	;胸のサイズとか変えるやつ
	PSQ.SetScaleSuccubus()
	If PSQ.EnableBreastChangeSuccubus
		PSQ.SetBreastScaleSuccubus()
	EndIf
	
	;バフ追加
	If PSQ.HenshinBuff
		PSQ.SuccubusHenshinBonusSpell.SetNthEffectMagnitude(0, Succu.GetBaseAV("Health") * PSQ.HenshinBuffRateHealth / 100)
		PSQ.SuccubusHenshinBonusSpell.SetNthEffectMagnitude(1, Succu.GetBaseAV("Magicka") * PSQ.HenshinBuffRateMagicka / 100)
		PSQ.SuccubusHenshinBonusSpell.SetNthEffectMagnitude(2, Succu.GetBaseAV("Stamina") * PSQ.HenshinBuffRateStamina / 100)
		PSQ.SuccubusHenshinBonusSpell.SetNthEffectMagnitude(3, Succu.GetBaseAV("CarryWeight") * PSQ.HenshinBuffRateCarry / 100)
		Succu.AddSpell(PSQ.SuccubusHenshinBonusSpell, False)
	EndIf
	
	If PSQ.HenshinArmorRate
		PSQ.SuccubusArmorSpell.SetNthEffectMagnitude(0, PSQ.SuccubusArmorMagnitude * PSQ.SuccubusRank.GetValue())
		Succu.AddSpell(PSQ.SuccubusArmorSpell, False)
	EndIf
	
	;水の上を歩きたい
	If PSQ.CanWalkOnTheWater
		Succu.AddSpell(PSQ.SuccubusWaterWalking, False)
	EndIf
	
	;目を変えるやつ
	If PSQ.HenshinEyes
		Int Eye = Succu.GetLeveledActorBase().GetNumHeadParts()
		Int i = 0
		While i < Eye
			If Succu.GetLeveledActorBase().GetNthHeadPart(i).GetType() == 2
				PSQ.OrgEyes = Succu.GetLeveledActorBase().GetNthHeadPart(i)
				i = Eye
			EndIf
			i += 1
		EndWhile
		Succu.ChangeHeadPart(PSQ.PSQSuccubusEyes)
	EndIf
	
	;ボディを変える奴
	If PSQ.HenshinBody
		Succu.GetLeveledActorBase().SetSkin(PSQ.PSQSuccubusSkin)
		Succu.ChangeHeadPart(PSQ.PSQSuccubusHead)
		If !PSQ.HenshinHairColor && !PSQ.HenshinSkin
			Succu.QueueNiNodeUpdate()
		EndIf
	EndIf
	
	;肌色を変えるやつ
	;NiOverrideのやつで変えようと思って試してみたが、体の色は変わっても頭の色が変わらないので断念した。
	If PSQ.HenshinSkin
		PSQ.OrgSkinColor = Game.GetTintMaskColor(6, 0)
		Game.SetTintMaskColor(PSQ.PSQSkinColor, 6, 0)
		If !PSQ.HenshinHairColor
			Succu.QueueNiNodeUpdate()
		EndIf
	EndIf
	
	;タトゥーが現れることもある
	If PSQ.HenshinTattoo
		Float Manpukudo = PSQ.SuccubusEnergy.GetValue() / PSQ.MaxEnergy
		PSQ.ChangeBodyPaint(Manpukudo)
	EndIf
	
	;髪を変えるやつ
	If PSQ.HenshinHair
		Int Hair = Succu.GetLeveledActorBase().GetNumHeadParts()
		Int i = 0
		While i < Hair
			If Succu.GetLeveledActorBase().GetNthHeadPart(i).GetType() == 3
				PSQ.OrgHair = Succu.GetLeveledActorBase().GetNthHeadPart(i)
				i = Hair
			EndIf
			i += 1
		EndWhile
		Succu.ChangeHeadPart(PSQ.PSQSuccubusHair)
	EndIf
	
	;髪色を変えるやつ
	If PSQ.HenshinHairColor
		PSQ.OrgHairColor = Succu.GetLeveledActorBase().GetHairColor()
		PSQ.PSQSuccubusHairColor.SetColor(PSQ.PSQSuccubusHairColorInt)
		Succu.GetLeveledActorBase().SetHairColor(PSQ.PSQSuccubusHairColor)
		Succu.QueueNiNodeUpdate()
	EndIf
	
	;ちんちんつけるやつ
	If StorageUtil.GetIntValue(Succu, "PSQ_HasPenis") == 1
		StorageUtil.SetIntValue(Succu, "PSQ_StillEquipPenis", 1)
	Else
		StorageUtil.SetIntValue(Succu, "PSQ_StillEquipPenis", 0)
	EndIf
	If PSQ.HenshinPenis || StorageUtil.GetIntValue(Succu, "PSQ_HasPenis") == 1
		Succu.AddItem(PSQ.PlayerSuccubusSchlong, 1, True)
		Succu.UnequipItem(PSQ.PlayerHumanSchlong, True, True)
		Succu.EquipItem(PSQ.PlayerSuccubusSchlong, True, True)
		If !PSQ.PlayerHumanSchlong == PSQ.PlayerSuccubusSchlong
			Succu.RemoveItem(PSQ.PlayerHumanSchlong, Succu.GetItemCount(PSQ.PlayerHumanSchlong), True)
		EndIf
		StorageUtil.SetIntValue(Succu, "PSQ_HasPenis", 1)
		If PSQ.EnableFutanariPower
			Succu.AddSpell(PSQ.PowerOfFutanari, False)
		EndIf
		If PSQ.AutoGenderSwitch
			PSQ.SexLab.TreatAsMale(Succu)
		EndIf
	EndIf
	
	;装備をつけるやつ
	If PSQ.HenshinBoots
		PSQ.OrgBoots = Succu.GetWornForm(0x00000080) as Armor
		Succu.AddItem(PSQ.PSQSuccubusBoots, 1, True)
		Succu.EquipItem(PSQ.PSQSuccubusBoots, True, True)
	EndIf
	If PSQ.HenshinCuirass
		PSQ.OrgArmor = Succu.GetWornForm(0x00000004) as Armor
		Succu.AddItem(PSQ.PSQSuccubusCuirass, 1, True)
		Succu.EquipItem(PSQ.PSQSuccubusCuirass, True, True)
	EndIf
	If PSQ.HenshinGloves
		PSQ.OrgGloves = Succu.GetWornForm(0x00000008) as Armor
		Succu.AddItem(PSQ.PSQSuccubusGauntlets, 1, True)
		Succu.EquipItem(PSQ.PSQSuccubusGauntlets, True, True)
	EndIf
	If PSQ.HenshinHorn
		Succu.AddItem(PSQ.PSQSuccubusHorns, 1, True)
		Succu.EquipItem(PSQ.PSQSuccubusHorns, True, True)
	EndIf
	If PSQ.HenshinWings
		Succu.AddItem(PSQ.PSQSuccubusWings, 1, True)
		Succu.EquipItem(PSQ.PSQSuccubusWings, True, True)
	EndIf
	If PSQ.HenshinTail
		Succu.AddItem(PSQ.PSQSuccubusTail, 1, True)
		Succu.EquipItem(PSQ.PSQSuccubusTail, True, True)
	EndIf
	
	;周囲のやつを怖がらせるやつ
	If PSQ.HenshinFear
		PSQ.SuccubusFormFearSpell.Cast(Succu)
	EndIf
	
	;変身を犯罪行為にするやつ
	If PSQ.HenshinIsCrime
		Succu.AddToFaction(PSQ.SuccubusFoeFaction)
		Succu.SetAttackActorOnSight()
	EndIf
	
	;変身中にサキュバス魔法を強化するやつ
	;強化率 = 0.5 * (SuccubusEXP) ^ 0.25
	;大体250で2.0、2000で3.34になる。
	Float BoosterRate = Math.Sqrt(Math.Sqrt(PSQ.SuccubusEXP.GetValue())) / 2
	If BoosterRate < 1
		BoosterRate = 1
	EndIf
	Int i = 0
	While i <= 6
		PSQ.SuccubusSpellBoostPerk.SetNthEntryValue(i, 1, BoosterRate)
		i += 1
	EndWhile
	If PSQ.EnableSuccubusSpellBooster
		PSQ.TransformBooster.SetValue(1)
	EndIf
	
	PSQ.IsHenshinchu = False
EndFunction

Function DisHenshin(Actor Succu)
	PSQ.IsHenshinchu = True
	PSQ.IsHenshined = False
	
	;変身時に出るエフェクト
	PSQ.SuccubusTransFXS.Play(Succu, 0.5)
	Utility.Wait(0.5)
	
	;バフが外れて水の上を歩けなくなる
	Succu.RemoveSpell(PSQ.SuccubusHenshinBonusSpell)
	Succu.RemoveSpell(PSQ.SuccubusWaterWalking)
	Succu.RemoveSpell(PSQ.SuccubusArmorSpell)
	
	;体型を戻すやつ
	PSQ.SetScaleHuman()
	If PSQ.EnableBreastChangeSuccubus
		PSQ.SetBreastScaleHuman()
	EndIf
	
	;目を変えるやつ
	If PSQ.OrgEyes != None
		Succu.ChangeHeadPart(PSQ.OrgEyes)
	EndIf
	
	;ボデェーを変えるやつ
	If PSQ.HenshinBody
		Succu.GetLeveledActorBase().SetSkin(PSQ.PSQHumanSkin)
		Succu.ChangeHeadPart(PSQ.PSQHumanHead)
		If PSQ.OrgHairColor == None && PSQ.OrgSkinColor == 0
			Succu.QueueNiNodeUpdate()
		EndIf
	EndIf
	
	;肌色を変えるやつ
	If PSQ.OrgSkinColor != 0
		Game.SetTintMaskColor(PSQ.OrgSkinColor, 6, 0)
		If PSQ.OrgHairColor == None
			Succu.QueueNiNodeUpdate()
		EndIf
	EndIf
	
	;タトゥーが消えることもある
	If PSQ.HenshinTattoo
		NiOverride.AddNodeOverrideFloat(Succu, true, "Face [Ovl2]", 8, -1, 0.0, true)
		NiOverride.AddNodeOverrideFloat(Succu, true, "Feet [Ovl2]", 8, -1, 0.0, true)
		NiOverride.AddNodeOverrideFloat(Succu, true, "Hands [Ovl2]", 8, -1, 0.0, true)
		NiOverride.AddNodeOverrideFloat(Succu, true, "Body [Ovl5]", 8, -1, 0.0, true)
	EndIf
	
	;髪型を変えるやつ
	If PSQ.OrgHair != None
		Succu.ChangeHeadPart(PSQ.OrgHair)
	EndIf
	
	;髪色を変えるやつ
	If PSQ.OrgHairColor != None
		Succu.GetLeveledActorBase().SetHairColor(PSQ.OrgHairColor)
		Succu.QueueNiNodeUpdate()
	EndIf
	
	;ちんちんを外すやつ
	If StorageUtil.GetIntValue(Succu, "PSQ_HasPenis") == 1
		Succu.UnequipItem(PSQ.PlayerSuccubusSchlong, True, True)
		If StorageUtil.GetIntValue(Succu, "PSQ_StillEquipPenis") == 1
			Succu.AddItem(PSQ.PlayerHumanSchlong, 1, True)
			Succu.EquipItem(PSQ.PlayerHumanSchlong, True, True)
			StorageUtil.SetIntValue(Succu, "PSQ_HasPenis", 1)
			If !PSQ.PlayerHumanSchlong == PSQ.PlayerSuccubusSchlong
				Succu.RemoveItem(PSQ.PlayerSuccubusSchlong, Succu.GetItemCount(PSQ.PlayerSuccubusSchlong), True)
			EndIf
			If PSQ.AutoGenderSwitch
				PSQ.SexLab.TreatAsMale(Succu)
			EndIf
		Else
			Succu.RemoveItem(PSQ.PlayerSuccubusSchlong, Succu.GetItemCount(PSQ.PlayerSuccubusSchlong), True)
			StorageUtil.SetIntValue(Succu, "PSQ_HasPenis", 0)
			Succu.RemoveSpell(PSQ.PowerOfFutanari)
			If PSQ.AutoGenderSwitch && PSQ.SexLab.GetGender(Succu) == 0
				PSQ.SexLab.ClearForcedGender(Succu)
			EndIf
		EndIf
	EndIf
	
	;装備を戻すやつ
	Succu.RemoveItem(PSQ.PSQSuccubusBoots, Succu.GetItemCount(PSQ.PSQSuccubusBoots), True)
	Succu.RemoveItem(PSQ.PSQSuccubusCuirass, Succu.GetItemCount(PSQ.PSQSuccubusCuirass), True)
	Succu.RemoveItem(PSQ.PSQSuccubusGauntlets, Succu.GetItemCount(PSQ.PSQSuccubusGauntlets), True)
	If PSQ.OrgArmor != None
		If Succu.GetItemCount(PSQ.OrgArmor) > 0
			Succu.EquipItem(PSQ.OrgArmor, abSilent = True)
		EndIf
	EndIf
	If PSQ.OrgGloves != None
		If Succu.GetItemCount(PSQ.OrgGloves) > 0
			Succu.EquipItem(PSQ.OrgGloves, abSilent = True)
		EndIf
	EndIf
	If PSQ.OrgBoots != None
		If Succu.GetItemCount(PSQ.OrgBoots) > 0
			Succu.EquipItem(PSQ.OrgBoots, abSilent = True)
		EndIf
	EndIf
	Succu.RemoveItem(PSQ.PSQSuccubusHorns, Succu.GetItemCount(PSQ.PSQSuccubusHorns), True)
	Succu.RemoveItem(PSQ.PSQSuccubusWings, Succu.GetItemCount(PSQ.PSQSuccubusWings), True)
	Succu.RemoveItem(PSQ.PSQSuccubusTail, Succu.GetItemCount(PSQ.PSQSuccubusTail), True)
	
	;ブースターを解除するやつ
	PSQ.TransformBooster.SetValue(0)
	
	;これ以上住民に襲われなくするやつ
	Succu.RemoveFromFaction(PSQ.SuccubusFoeFaction)
	Succu.SetAttackActorOnSight(False)
	
	;元のなんかをクリア
	PSQ.OrgArmor = None
	PSQ.OrgGloves = None
	PSQ.OrgBoots = None
	PSQ.OrgSkinColor = 0
	PSQ.OrgEyes = None
	
	PSQ.IsHenshinchu = False
EndFunction
