Scriptname PSQSoulGemIncubateQuestScript Extends Quest

SexLabFramework Property SexLab Auto
PlayerSuccubusQuestScript Property PSQ Auto
Actor Property PlayerRef Auto
Import StorageUtil

Bool Property BirthingNow Auto Hidden
Bool StopOviposition
Bool IsMilking
Spell PregnantEffectX
Spell PregnantEffectY

Int Property FillingChance = 3 Auto Hidden
Float Property SpeedDecreaseMax = 70.0 Auto Hidden
GlobalVariable Property GameDaysPassed Auto
GlobalVariable Property PlayerIsSuccubus Auto
Armor Property GushSmall Auto
Armor Property GushLarge Auto
Armor Property SuccubusNanka Auto
Sound Property SoundSio Auto
Sound Property SoundMilking Auto
Sound Property SoundOviposition Auto
Message Property SelectAnimationMSGBox Auto
ImageSpaceModifier Property FadeToBlackHoldImod Auto
Static Property XMarker Auto
Spell Property SoulGemPregnantEffectA Auto
Spell Property SoulGemPregnantEffectB Auto
SoulGem Property SoulgemPettyEgg Auto
SoulGem Property SoulgemPettyEggFilled Auto
SoulGem Property SoulGemLesserEgg Auto
SoulGem Property SoulGemLesserEggFilled Auto
SoulGem Property SoulGemCommonEgg Auto
SoulGem Property SoulGemCommonEggFilled Auto
SoulGem Property SoulGemGreaterEgg Auto
SoulGem Property SoulGemGreaterEggFilled Auto
SoulGem Property SoulGemGrandEgg Auto
SoulGem Property SoulGemGrandEggFilled Auto
SoulGem Property SoulGemBlackEgg Auto
SoulGem Property SoulGemBlackEggFilled Auto

Event OnUpdate()
	RegisterForSingleUpdate(60.0)
	GrowthGem()
EndEvent

;孕ませる処理だよ。
Function Impregnate()
	If GetIntValue(PlayerRef, "PRG_SeedsNum") != 0
		SetIntValue(PlayerRef, "PRG_IsPregnant", 1)
		SetFloatValue(PlayerRef, "PRG_LastUpdateTimeGem", GameDaysPassed.GetValue())
		SetFloatValue(PlayerRef, "PRG_LastUpdateTimeMilk", GameDaysPassed.GetValue())
		If GetFloatValue(PlayerRef, "PRG_IncubateEXP") < 100
			SetFloatValue(PlayerRef, "PRG_IncubateEXP", 100.0)
		EndIf
		RegisterForSingleUpdate(2.0)
	Else
		GrowthGem()
		PSQ.AddMilk()
	EndIf
	
	If GetIntValue(PlayerRef, "PRG_SeedsNum") < 100
		FloatListAdd(PlayerRef, "PRG_Seeds", 1.0)
		IntListAdd(PlayerRef, "PRG_SeedsFilled", 0)
		SetIntValue(PlayerRef, "PRG_SeedsNum", GetIntValue(PlayerRef, "PRG_SeedsNum") + 1)
		SetFloatValue(PlayerRef, "PRG_SeedsTotal", GetFloatValue(PlayerRef, "PRG_SeedsTotal") + 1.0)
		Debug.Notification("$PSQ_FertilizedGem")
	EndIf
EndFunction

;妊娠中の魂石を満たす処理だよ。
Function Filling()
	If GetIntValue(PlayerRef, "PRG_SeedsNum") != 0
		Int SeedsNumX = GetIntValue(PlayerRef, "PRG_SeedsNum")
		Int i = 0
		While i < SeedsNumX
			If IntListGet(PlayerRef, "PRG_SeedsFilled", i) == 0
				If FillingChance >= Utility.RandomInt(0, 100)
					IntListSet(PlayerRef, "PRG_SeedsFilled", i, 1)
				EndIf
			EndIf
			i += 1
		EndWhile
	EndIf
EndFunction

;魂石を成長させる処理だよ。
Function GrowthGem()
	If !BirthingNow
		Float SeedsTotalX
		Float GrownBase = (GameDaysPassed.GetValue() - GetFloatValue(PlayerRef, "PRG_LastUpdateTimeGem")) * GetFloatValue(PlayerRef, "PRG_IncubateEXP")
		SetFloatValue(PlayerRef, "PRG_LastUpdateTimeGem", GameDaysPassed.GetValue())
		Int SeedsNumX = GetIntValue(PlayerRef, "PRG_SeedsNum")
		Float[] Gems = New Float[100]
		Int i = 0
		While i < SeedsNumX
			Gems[i] = FloatListGet(PlayerRef, "PRG_Seeds", i) + Utility.RandomFloat(GrownBase * 0.5, GrownBase * 1.5)
			If Gems[i] > 3000
				Gems[i] = 3000
			EndIf
			FloatListSet(PlayerRef, "PRG_Seeds", i, Gems[i])
			SeedsTotalX = SeedsTotalX + Gems[i]
			i += 1
		EndWhile
		SetFloatValue(PlayerRef, "PRG_SeedsTotal", SeedsTotalX)
		AddBuff()
	EndIf
EndFunction

;バフ追加処理だよ。
Function AddBuff()
	If PlayerRef.HasSpell(SoulGemPregnantEffectA)
		PregnantEffectX = SoulGemPregnantEffectB
		PregnantEffectY = SoulGemPregnantEffectA
	Else
		PregnantEffectX = SoulGemPregnantEffectA
		PregnantEffectY = SoulGemPregnantEffectB
	EndIf
	Float Magnitude = GetFloatValue(PlayerRef, "PRG_SeedsTotal") / 300
	If Magnitude > SpeedDecreaseMax
		Magnitude = SpeedDecreaseMax
	EndIf
	PregnantEffectX.SetNthEffectMagnitude(0, Magnitude)
	If GetFloatValue(PlayerRef, "PRG_SeedsTotal") > 0.0
		PlayerRef.AddSpell(PregnantEffectX, False)
	EndIf
	PlayerRef.RemoveSpell(PregnantEffectY)
	PlayerRef.AddItem(SuccubusNanka, 1, True)
	PlayerRef.EquipItem(SuccubusNanka, abSilent = True)
	PlayerRef.RemoveItem(SuccubusNanka, PlayerRef.GetItemCount(SuccubusNanka), True)
EndFunction

;産卵中の脱出コマンドだよ。
Event OnControlUp(String Control, Float HoldTime)
	If Control != "Activate"
		Return
	Endif
	
	If BirthingNow
		StopOviposition = True
	EndIf
EndEvent

;産卵する処理だよ。
Function Birthing()
	;極小まで育っていないと産めないよ。
	If FloatListGet(PlayerRef, "PRG_Seeds", 0) < 100
		Debug.Notification("You have no gem to oviposition.")
		Return
	EndIf
	
	;前処理だよ。
	BirthingNow = True
	RegisterForControl("Activate")
	sslBaseVoice Voice = SexLab.PickVoice(PlayerRef)
	PreProcessing(Voice)
	ObjectReference EggMarkerV = PlayerRef.PlaceAtme(XMarker)
	EggMarkerV.MoveToNode(PlayerRef, "NPC Pelvis [Pelv]")
	Float BeforeTotal = GetFloatValue(PlayerRef, "PRG_SeedsTotal")
	
	;産卵だよ。
	SoulGem BirthGem
	int i = 0
	While i < GetIntValue(PlayerRef, "PRG_SeedsNum")
		If FloatListGet(PlayerRef, "PRG_Seeds", i) > 0 && !StopOviposition
			BirthGem = GemSelect(FloatListGet(PlayerRef, "PRG_Seeds", i), IntListGet(PlayerRef, "PRG_SeedsFilled", i))
			If BirthGem != None
				Oviposition(BirthGem, Voice, EggMarkerV)
				FloatListSet(PlayerRef, "PRG_Seeds", i, 10000)
				IntListSet(PlayerRef, "PRG_SeedsFilled", i, 2)
			EndIf
			BirthGem = None
			i += 1
		Else
			i = 334
		EndIf
	EndWhile
	
	;後処理だよ。
	SetFloatValue(PlayerRef, "PRG_MilkBonus", GetFloatValue(PlayerRef, "PRG_MilkBonus") + BeforeTotal - GetFloatValue(PlayerRef, "PRG_SeedsTotal"))
	SetFloatValue(PlayerRef, "PRG_LastOvipositionTime", GameDaysPassed.GetValue())
	EggMarkerV = None
	SortSeeds()
	
	;子宮が空になっていたら妊娠中フラグを解除するよ。
	If GetIntValue(PlayerRef, "PRG_SeedsNum") == 0	
		FloatListClear(PlayerRef, "PRG_Seeds")
		IntListClear(PlayerRef, "PRG_SeedsFilled")
		SetFloatValue(PlayerRef, "PRG_SeedsTotal", 0)
		SetIntValue(PlayerRef, "PRG_SeedsNum", 0)
		PlayerRef.RemoveSpell(SoulGemPregnantEffectA)
		PlayerRef.RemoveSpell(SoulGemPregnantEffectB)
	Else
		AddBuff()
	EndIf
	
	PostProcessing()
	UnregisterForControl("Activate")
	StopOviposition = False
	BirthingNow = False
EndFunction

;前処理をまとめてみたよ。
Function PreProcessing(sslBaseVoice Voice)
	;動かないようにして暗闇で目を欺くよ。
	FadeToBlackHoldImod.ApplyCrossFade(2.0)
	Utility.Wait(2.0)	
	Game.SetPlayerAIDriven()
	Game.DisablePlayerControls(False, False, False, False, False, False, True, False)
	Game.ForceThirdPerson()
	
	;アニメーションを選べるようにした
	Int OvipositionAnimation
	Int i = SelectAnimationMSGBox.Show()
	If i == 0
		OvipositionAnimation = 1
	ElseIf i == 1
		OvipositionAnimation = 2
	EndIf
	
	;表情を付けるよ。
	sslBaseExpression Expression = SexLab.PickExpression(PlayerRef)
	Expression.Apply(PlayerRef, 100, 1)
	
	;なんか汁でてるエフェクトを追加するよ。
	PlayerRef.AddItem(GushSmall, 1, True)
	PlayerRef.AddItem(GushLarge, 1, True)
	PlayerRef.EquipItem(GushLarge, abSilent = True)
	
	;鎧と武器をしまうよ。
	If PlayerRef.GetWornForm(0x00000004) as Armor != None
		SetFormValue(PlayerRef, "PRG_Armor", PlayerRef.GetWornForm(0x00000004))
		PlayerRef.UnequipItemSlot(32)
	EndIf
	PlayerRef.SheatheWeapon()
	
	;恥ずかしいポーズを強制してちんちんを立たせるよ。
	If OvipositionAnimation == 1
		Debug.SendAnimationEvent(PlayerRef, "Missionary_A1_S1")
		Debug.SendAnimationEvent(PlayerRef, "Missionary_A1_S4")
	ElseIf OvipositionAnimation == 2
		Debug.SendAnimationEvent(PlayerRef, "DoggyStyle_A1_S1")
		Debug.SendAnimationEvent(PlayerRef, "DoggyStyle_A1_S4")
	EndIf
	Debug.SendAnimationEvent(PlayerRef, "SOSFastErect")
	
	;TFCして暗闇を払うよ。
	Utility.Wait(0.5)
	PlayerRef.SetAngle(PlayerRef.GetAngleX(), PlayerRef.GetAngleY(), PlayerRef.GetAngleZ() + 180.0)
	If SexLab.Config.AutoTFC && Game.GetCameraState() != 3
		MiscUtil.ToggleFreeCamera()
		MiscUtil.SetFreeCameraSpeed(SexLab.Config.AutoSUCSM)
	EndIf
	If Game.GetCameraState() != 3
		PlayerRef.EquipItem(GushSmall, abSilent = True)
	EndIf
	Utility.Wait(1.0)
	ImageSpaceModifier.RemoveCrossFade(2.0)
	
	;何回か喘がせるよ。
	i = Utility.RandomInt(2, 4)
	While i > 0
		PSQ.MoanNoWait(Voice, Utility.RandomInt(50, 100))
		Utility.Wait(Utility.RandomFloat(1.5, 3.0))
		i -= 1
	EndWhile
EndFunction

;後処理をまとめてみたよ。
Function PostProcessing()
	;暗闇で目を欺き微妙に待ちつつ経験値が上限超えないようにするよ。
	FadeToBlackHoldImod.ApplyCrossFade(2.0)
	Utility.Wait(2.0)
	If GetFloatValue(PlayerRef, "PRG_IncubateEXP") > 500
		SetFloatValue(PlayerRef, "PRG_IncubateEXP", 500)
	EndIf
	
	;ポーズをデフォルトに戻すよ。
	Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
	PlayerRef.SetAngle(PlayerRef.GetAngleX(), PlayerRef.GetAngleY(), PlayerRef.GetAngleZ() + 180.0)
	Debug.SendAnimationEvent(PlayerRef, "SOSFlaccid")
	
	;装備を元に戻すよ。
	PlayerRef.RemoveItem(GushSmall, 1, True)
	PlayerRef.RemoveItem(GushLarge, 1, True)
	PlayerRef.EquipItem(GetFormValue(PlayerRef, "PRG_Armor") as Armor, abSilent = True)
	
	;表情をクリアするよ。
	PlayerRef.ClearExpressionOverride()
	MfgConsoleFunc.ResetPhonemeModifier(PlayerRef)
	
	Utility.Wait(1.0)
	
	;動けるようにしてTFCを解除して暗闇を払うよ。
	Game.EnablePlayerControls()
	Game.SetPlayerAIDriven(False)
	If Game.GetCameraState() == 3
		MiscUtil.ToggleFreeCamera()
	EndIf
	ImageSpaceModifier.RemoveCrossFade(2.0)
EndFunction

;成長度合いに応じた魂石を選ぶ処理だよ。
SoulGem Function GemSelect(Float Size, Int Filled)
	If Size >= 3000
		SetFloatValue(PlayerRef, "PRG_IncubateEXP", GetFloatValue(PlayerRef, "PRG_IncubateEXP") + 10)
		SetFloatValue(PlayerRef, "PRG_SeedsTotal", GetFloatValue(PlayerRef, "PRG_SeedsTotal") - Size)
		If Filled == 1
			Return SoulGemBlackEggFilled
		Else
			Return SoulGemBlackEgg
		EndIf
	ElseIf Size >= 1600
		SetFloatValue(PlayerRef, "PRG_IncubateEXP", GetFloatValue(PlayerRef, "PRG_IncubateEXP") + 5)
		SetFloatValue(PlayerRef, "PRG_SeedsTotal", GetFloatValue(PlayerRef, "PRG_SeedsTotal") - Size)
		If Filled == 1
			Return SoulGemGrandEggFilled
		Else
			Return SoulGemGrandEgg
		EndIf
	ElseIf Size >= 800
		SetFloatValue(PlayerRef, "PRG_IncubateEXP", GetFloatValue(PlayerRef, "PRG_IncubateEXP") + 4)
		SetFloatValue(PlayerRef, "PRG_SeedsTotal", GetFloatValue(PlayerRef, "PRG_SeedsTotal") - Size)
		If Filled == 1
			Return SoulGemGreaterEggFilled
		Else
			Return SoulGemGreaterEgg
		EndIf
	ElseIf Size >= 400
		SetFloatValue(PlayerRef, "PRG_IncubateEXP", GetFloatValue(PlayerRef, "PRG_IncubateEXP") + 3)
		SetFloatValue(PlayerRef, "PRG_SeedsTotal", GetFloatValue(PlayerRef, "PRG_SeedsTotal") - Size)
		If Filled == 1
			Return SoulGemCommonEggFilled
		Else
			Return SoulGemCommonEgg
		EndIf
	ElseIf Size >= 200
		SetFloatValue(PlayerRef, "PRG_IncubateEXP", GetFloatValue(PlayerRef, "PRG_IncubateEXP") + 2)
		SetFloatValue(PlayerRef, "PRG_SeedsTotal", GetFloatValue(PlayerRef, "PRG_SeedsTotal") - Size)
		If Filled == 1
			Return SoulGemLesserEggFilled
		Else
			Return SoulGemLesserEgg
		EndIf
	ElseIf Size >= 100
		SetFloatValue(PlayerRef, "PRG_IncubateEXP", GetFloatValue(PlayerRef, "PRG_IncubateEXP") + 1)
		SetFloatValue(PlayerRef, "PRG_SeedsTotal", GetFloatValue(PlayerRef, "PRG_SeedsTotal") - Size)
		If Filled == 1
			Return SoulgemPettyEggFilled
		Else
			Return SoulgemPettyEgg
		EndIf
	Else
		Return None
	EndIf
EndFunction

;卵が出てくる処理だよ。
Function Oviposition(SoulGem BirthGem, sslBaseVoice Voice, ObjectReference EggMarkerV)
	Utility.Wait(2.0)
	ObjectReference MyEgg
	If Game.GetCameraState() != 3
		PlayerRef.EquipItem(GushLarge, abSilent = True)
	EndIf
	Utility.Wait(0.2)
	PSQ.MoanNoWait(Voice, 100)
	SoundOviposition.Play(PlayerRef)
	SoundSio.Play(PlayerRef)
	MyEgg = EggMarkerV.PlaceAtme(BirthGem)
	MyEgg.SetActorOwner(PlayerRef.GetActorBase())
	PSQ.SetBellyScale()
	MyEgg.ApplyHavokImpulse(PlayerRef.GetAngleX() - Math.sin(PlayerRef.GetAngleZ()), PlayerRef.GetAngleY() - Math.cos(PlayerRef.GetAngleZ()), 0.5, 4.0)
	If Game.GetCameraState() != 3
		PlayerRef.EquipItem(GushSmall, abSilent = True)
	EndIf
	Utility.Wait(Utility.RandomFloat(1.5, 3.0))
	int i = Utility.RandomInt(2, 4)
	While i > 0 && !StopOviposition
		PSQ.MoanNoWait(Voice, Utility.RandomInt(50, 100))
		Utility.Wait(Utility.RandomFloat(1.5, 3.0))
		i -= 1
	EndWhile
EndFunction

;魂石をソートするよ。
Function SortSeeds()
	Float[] SoulGemSeedsTemp = New Float[100]
	Int[] SoulGemSeedsFilledTemp = New Int[100]
	Int SeedsNumTemp = 0
	Int SeedsNumX = GetIntValue(PlayerRef, "PRG_SeedsNum")
	Int i = 0
	While i < SeedsNumX
		If FloatListGet(PlayerRef, "PRG_Seeds", i) >= 9999
			SoulGemSeedsTemp[i] = 0
			i += 1
		ElseIf FloatListGet(PlayerRef, "PRG_Seeds", i) > 0
			SoulGemSeedsTemp[i] = FloatListGet(PlayerRef, "PRG_Seeds", i)
			SoulGemSeedsFilledTemp[i] = IntListGet(PlayerRef, "PRG_SeedsFilled", i)
			SeedsNumTemp += 1
			i += 1
		EndIf
	EndWhile
	
	SetIntValue(PlayerRef, "PRG_SeedsNum", SeedsNumTemp)
	FloatListClear(PlayerRef, "PRG_Seeds")
	IntListClear(PlayerRef, "PRG_SeedsFilled")
	
	i = 0
	While i < SeedsNumX
		If SoulGemSeedsTemp[i] != 0
			FloatListAdd(PlayerRef, "PRG_Seeds", SoulGemSeedsTemp[i])
			IntListAdd(PlayerRef, "PRG_SeedsFilled", SoulGemSeedsFilledTemp[i])
		EndIf
		i += 1
	EndWhile
EndFunction

;子宮を空にする処理だよ。
Function ClearUterus()
	FloatListClear(PlayerRef, "PRG_Seeds")
	IntListClear(PlayerRef, "PRG_SeedsFilled")
	SetIntValue(PlayerRef, "PRG_IsPregnant", 0)
	SetIntValue(PlayerRef, "PRG_SeedsNum", 0)
	SetFloatValue(PlayerRef, "PRG_SeedsTotal", 0.0)
	StorageUtil.SetIntValue(PlayerRef, "PSQ_SoulGemPregnancyON", 0)
	PlayerRef.RemoveSpell(SoulGemPregnantEffectA)
	PlayerRef.RemoveSpell(SoulGemPregnantEffectB)
	UnregisterForUpdate()
	PSQ.SetBellyScale()
	PlayerRef.AddItem(SuccubusNanka, 1, True)
	PlayerRef.EquipItem(SuccubusNanka, abSilent = True)
	PlayerRef.RemoveItem(SuccubusNanka, PlayerRef.GetItemCount(SuccubusNanka), True)
EndFunction

;成長量は (時間(1.0で1日) * 100 * 妊娠経験値) * RND(0.5, 1.5)
;魂石のサイズ
;1～99 無し, 100～199 極小, 200～399 小, 400～799 中, 800～1599 大, 1600～2999 極大, 3000 黒
;卵形の方が間違いなくエロいので卵形にする。異論があっても絶対に通す。
;SoulCairnで魂を収穫できるようにリストに追加する何かを付けようぞ。;formlist 0x002844 SoulGemsEmpty,あとバニラの方にもいくつかリストがある
;Arousedの性欲解消する方法を入れるのだ
;なんか忘れてる気がするけどとりあえずこれでいいや。

;SoulGemPregと互換性を付ける意味があるのかと思ったが、
;PSQしか使っていない人がSoulGemPregを使い始めた時に互換性があると色々いいからやっぱり必要。
;なお互換性があると言っても両方を有効にしないように。
