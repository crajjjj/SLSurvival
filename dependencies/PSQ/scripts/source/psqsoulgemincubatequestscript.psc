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

;�s�܂��鏈������B
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

;�D�P���̍��΂𖞂�����������B
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

;���΂𐬒������鏈������B
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

;�o�t�ǉ���������B
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

;�Y�����̒E�o�R�}���h����B
Event OnControlUp(String Control, Float HoldTime)
	If Control != "Activate"
		Return
	Endif
	
	If BirthingNow
		StopOviposition = True
	EndIf
EndEvent

;�Y�����鏈������B
Function Birthing()
	;�ɏ��܂ň���Ă��Ȃ��ƎY�߂Ȃ���B
	If FloatListGet(PlayerRef, "PRG_Seeds", 0) < 100
		Debug.Notification("You have no gem to oviposition.")
		Return
	EndIf
	
	;�O��������B
	BirthingNow = True
	RegisterForControl("Activate")
	sslBaseVoice Voice = SexLab.PickVoice(PlayerRef)
	PreProcessing(Voice)
	ObjectReference EggMarkerV = PlayerRef.PlaceAtme(XMarker)
	EggMarkerV.MoveToNode(PlayerRef, "NPC Pelvis [Pelv]")
	Float BeforeTotal = GetFloatValue(PlayerRef, "PRG_SeedsTotal")
	
	;�Y������B
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
	
	;�㏈������B
	SetFloatValue(PlayerRef, "PRG_MilkBonus", GetFloatValue(PlayerRef, "PRG_MilkBonus") + BeforeTotal - GetFloatValue(PlayerRef, "PRG_SeedsTotal"))
	SetFloatValue(PlayerRef, "PRG_LastOvipositionTime", GameDaysPassed.GetValue())
	EggMarkerV = None
	SortSeeds()
	
	;�q�{����ɂȂ��Ă�����D�P���t���O�����������B
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

;�O�������܂Ƃ߂Ă݂���B
Function PreProcessing(sslBaseVoice Voice)
	;�����Ȃ��悤�ɂ��ĈÈłŖڂ��\����B
	FadeToBlackHoldImod.ApplyCrossFade(2.0)
	Utility.Wait(2.0)	
	Game.SetPlayerAIDriven()
	Game.DisablePlayerControls(False, False, False, False, False, False, True, False)
	Game.ForceThirdPerson()
	
	;�A�j���[�V������I�ׂ�悤�ɂ���
	Int OvipositionAnimation
	Int i = SelectAnimationMSGBox.Show()
	If i == 0
		OvipositionAnimation = 1
	ElseIf i == 1
		OvipositionAnimation = 2
	EndIf
	
	;�\���t�����B
	sslBaseExpression Expression = SexLab.PickExpression(PlayerRef)
	Expression.Apply(PlayerRef, 100, 1)
	
	;�Ȃ񂩏`�łĂ�G�t�F�N�g��ǉ������B
	PlayerRef.AddItem(GushSmall, 1, True)
	PlayerRef.AddItem(GushLarge, 1, True)
	PlayerRef.EquipItem(GushLarge, abSilent = True)
	
	;�Z�ƕ�������܂���B
	If PlayerRef.GetWornForm(0x00000004) as Armor != None
		SetFormValue(PlayerRef, "PRG_Armor", PlayerRef.GetWornForm(0x00000004))
		PlayerRef.UnequipItemSlot(32)
	EndIf
	PlayerRef.SheatheWeapon()
	
	;�p���������|�[�Y���������Ă��񂿂�𗧂������B
	If OvipositionAnimation == 1
		Debug.SendAnimationEvent(PlayerRef, "Missionary_A1_S1")
		Debug.SendAnimationEvent(PlayerRef, "Missionary_A1_S4")
	ElseIf OvipositionAnimation == 2
		Debug.SendAnimationEvent(PlayerRef, "DoggyStyle_A1_S1")
		Debug.SendAnimationEvent(PlayerRef, "DoggyStyle_A1_S4")
	EndIf
	Debug.SendAnimationEvent(PlayerRef, "SOSFastErect")
	
	;TFC���ĈÈł𕥂���B
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
	
	;���񂩚b�������B
	i = Utility.RandomInt(2, 4)
	While i > 0
		PSQ.MoanNoWait(Voice, Utility.RandomInt(50, 100))
		Utility.Wait(Utility.RandomFloat(1.5, 3.0))
		i -= 1
	EndWhile
EndFunction

;�㏈�����܂Ƃ߂Ă݂���B
Function PostProcessing()
	;�ÈłŖڂ��\�������ɑ҂��o���l����������Ȃ��悤�ɂ����B
	FadeToBlackHoldImod.ApplyCrossFade(2.0)
	Utility.Wait(2.0)
	If GetFloatValue(PlayerRef, "PRG_IncubateEXP") > 500
		SetFloatValue(PlayerRef, "PRG_IncubateEXP", 500)
	EndIf
	
	;�|�[�Y���f�t�H���g�ɖ߂���B
	Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
	PlayerRef.SetAngle(PlayerRef.GetAngleX(), PlayerRef.GetAngleY(), PlayerRef.GetAngleZ() + 180.0)
	Debug.SendAnimationEvent(PlayerRef, "SOSFlaccid")
	
	;���������ɖ߂���B
	PlayerRef.RemoveItem(GushSmall, 1, True)
	PlayerRef.RemoveItem(GushLarge, 1, True)
	PlayerRef.EquipItem(GetFormValue(PlayerRef, "PRG_Armor") as Armor, abSilent = True)
	
	;�\����N���A�����B
	PlayerRef.ClearExpressionOverride()
	MfgConsoleFunc.ResetPhonemeModifier(PlayerRef)
	
	Utility.Wait(1.0)
	
	;������悤�ɂ���TFC���������ĈÈł𕥂���B
	Game.EnablePlayerControls()
	Game.SetPlayerAIDriven(False)
	If Game.GetCameraState() == 3
		MiscUtil.ToggleFreeCamera()
	EndIf
	ImageSpaceModifier.RemoveCrossFade(2.0)
EndFunction

;�����x�����ɉ��������΂�I�ԏ�������B
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

;�����o�Ă��鏈������B
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

;���΂��\�[�g�����B
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

;�q�{����ɂ��鏈������B
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

;�����ʂ� (����(1.0��1��) * 100 * �D�P�o���l) * RND(0.5, 1.5)
;���΂̃T�C�Y
;1�`99 ����, 100�`199 �ɏ�, 200�`399 ��, 400�`799 ��, 800�`1599 ��, 1600�`2999 �ɑ�, 3000 ��
;���`�̕����ԈႢ�Ȃ��G�����̂ŗ��`�ɂ���B�٘_�������Ă���΂ɒʂ��B
;SoulCairn�ō������n�ł���悤�Ƀ��X�g�ɒǉ����鉽����t���悤���B;formlist 0x002844 SoulGemsEmpty,���ƃo�j���̕��ɂ����������X�g������
;Aroused�̐��~����������@������̂�
;�Ȃ񂩖Y��Ă�C�����邯�ǂƂ肠��������ł�����B

;SoulGemPreg�ƌ݊�����t����Ӗ�������̂��Ǝv�������A
;PSQ�����g���Ă��Ȃ��l��SoulGemPreg���g���n�߂����Ɍ݊���������ƐF�X�����������ς�K�v�B
;�Ȃ��݊���������ƌ����Ă�������L���ɂ��Ȃ��悤�ɁB
