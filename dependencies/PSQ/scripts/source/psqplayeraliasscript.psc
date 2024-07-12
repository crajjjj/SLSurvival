Scriptname PSQPlayerAliasScript Extends ReferenceAlias

PlayerSuccubusQuestScript Property PSQ Auto

;魔法がサキュバス魔法かの判定
Event OnSpellCast(Form akSpell)
	If PSQ.EnableEnergyConsumingBySuccubusSpell
		If akSpell.HasKeyword(PSQ.SuccubusSpell) && !akSpell.HasKeyword(PSQ.SuccubusSpellNoConsume)
			Spell UsedSpell = akSpell as Spell
			Float CostRate
			If PSQ.EnergyModeAlt
				CostRate = PSQ.SuccubusRank.GetValue()
			Else 
				CostRate = 2
			EndIf
			Float Cost = UsedSpell.GetEffectiveMagickaCost(PSQ.PlayerRef) / CostRate
			If PSQ.SuccubusEnergy.GetValue() < Cost
				PSQ.PlayerRef.DamageActorValue("Health", Cost - PSQ.SuccubusEnergy.GetValue())
				Debug.Notification("$PSQ_EnergyDepletionNotice")
			EndIf
			PSQ.Satiety(-Cost)
			If PSQ.EnableSpellCastingNotification
				PSQ.SatietyNotification(-Cost, True)
			EndIf
		EndIf
	EndIf
EndEvent

;何かを装備した時に翼と扱われるかってやつ
Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	If PSQ.PlayerIsSuccubus.GetValue() == 1
		If akBaseObject as Armor
			If StringUtil.Find(akBaseObject.GetName(), "Wing") != -1
				PSQ.HasWing.SetValue(1)
				Game.SetGameSettingFloat("fJumpHeightMin", PSQ.WingMaxJumpHeight)
				If PSQ.EnableAutoAddFlying
					If PSQ.SuccubusRank.GetValueInt() >= PSQ.CanFlyingLevel
						PSQ.PlayerRef.AddSpell(PSQ.SuccubusFlyingSpell, False)
					EndIf
				EndIf
				PSQ.Satiety()
			EndIf
		EndIf
	EndIf
EndEvent

;何かを外した時に翼と扱われるかってやつ
Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	If PSQ.PlayerIsSuccubus.GetValue() == 1
		If akBaseObject as Armor
			If StringUtil.Find(akBaseObject.GetName(), "Wing") != -1
				PSQ.HasWing.SetValue(0)
				PSQ.PlayerRef.RemoveSpell(PSQ.SuccubusFlyingSpell)
				PSQ.Satiety()
				Game.SetGameSettingFloat("fJumpHeightMin", PSQ.DefaultJumpHeight)
			EndIf
		EndIf
	EndIf
EndEvent

;オートで強姦事件が発生するためのやつ
Event OnHit(ObjectReference akAggressor, Form akSrc, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	If PSQ.PlayerIsSuccubus.GetValue() == 1 && PSQ.EnablePSQRape
		Actor Aggressor = akAggressor as Actor
		If IsRaper(Aggressor) && RapeIncidentOccurrence()
			If !PSQ.PlayerRef.HasKeywordString("SexLabActive")
				Debug.SendAnimationEvent(PSQ.PlayerRef, "BleedoutStart")
				Aggressor.AddToFaction(PSQ.PSQRapeNoAttackFaction)
				PSQ.PlayerRef.AddToFaction(PSQ.PSQRapeNoAttackFaction)
				Actor[] SexActors = new Actor[2]
				SexActors[0] = PSQ.PlayerRef
				SexActors[1] = Aggressor
				sslBaseAnimation[] anims = PSQ.SexLab.GetAnimationsByType(2, Aggressive = True)
				PSQ.SexLab.StartSex(SexActors, anims, Victim = PSQ.PlayerRef)
			EndIf
		EndIf
	EndIf
Endevent

;暴行魔の性欲を判定
Bool Function IsRaper(Actor Target)
	If PSQ.SexLab.ValidateActor(Target) == 1
		If Target.HasMagicEffectWithKeyword(PSQ.MagicInfluence) || PSQ.SlaUtil.GetActorArousal(Target) >= PSQ.RapeArousalThreshold
			Return True
		EndIf
	EndIf
	Return False
EndFunction

;プレイヤーの体力と乱数から強姦事件発生を判定
Bool Function RapeIncidentOccurrence()
	If Utility.RandomInt(1, 100) <= PSQ.RapeChance && PSQ.PlayerRef.GetActorValuePercentage("Health") * 100 <= PSQ.RapeHealthThreshold
		Return True
	Endif
	Return False
EndFunction
