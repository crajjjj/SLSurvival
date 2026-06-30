ScriptName mzinPlayBathingAnimation Extends ActiveMagicEffect
{ this script plays bathing and showering animations based on properties }

mzinInit Property Init Auto
mzinBatheMCMMenu Property Menu Auto
mzinUtility Property mzinUtil Auto
Keyword Property SoapKeyword Auto
Spell Property PlayBathingAnimation Auto
Spell Property SoapyAppearanceSpell Auto
Spell Property SoapyAppearanceAnimatedSpell Auto
FormList Property DirtinessSpellList Auto
FormList Property BathingAnimationLoopCountList Auto
FormList Property PlayerHouseLocationList Auto
FormList Property DungeonLocationList Auto
FormList Property SettlementLocationList Auto
GlobalVariable Property GetSoapyStyle Auto
GlobalVariable Property BathingAnimationStyle Auto
GlobalVariable Property ShoweringAnimationStyle Auto
GlobalVariable Property GetDressedAfterBathingEnabled Auto
GlobalVariable Property ForceCustomAnimationDuration Auto
Message Property BathingCompleteMessage Auto
Package Property StopMovementPackage Auto
Idle[] Property mzinBathe_Baka_S Auto
Idle[] Property mzinBathe_Baka_C Auto
Idle[] Property mzinBathe_Krzp Auto
Idle[] Property mzinBathe_JVRaven Auto
Idle[] Property mzinBathe_Tweens_S Auto
Idle[] Property mzinBathe_Tweens_C Auto
String[] Property mzinAnimEvent Auto
Bool Property TargetIsPlayer Auto
Actor      BathingActor
Armor[]    Clothing
Int[]      ClothingID
Form[]     Objects
Int[]      ObjectsID
Idle       SelectedStyle
MiscObject WashProp
Bool       WashPropIsSoap
Bool       IsShowering

Event OnEffectStart(Actor Target, Actor Caster)
	BathingActor = Target
	mzinUtil.ForbidSex(BathingActor, Forbid = true)
	
	IsShowering = StorageUtil.PluckIntValue(BathingActor, "mzin_LastWashState") as Bool
	WashProp = StorageUtil.PluckFormValue(BathingActor, "mzin_LastWashProp") as MiscObject
	WashPropIsSoap = (WashProp && WashProp.HasKeyWord(SoapKeyword))
	
	StripActor()
	LockActor()
	RegisterForEvents()

	Int AnimStyle
	If IsShowering
		AnimStyle = ShoweringAnimationStyle.GetValue() as int
	Else
		AnimStyle = BathingAnimationStyle.GetValue() as int
	EndIf

	If AnimStyle < 1
		RegisterForSingleUpdate(2.0)
	ElseIf IsShowering
		StartSequence_OVDE(AnimStyle)
	Else
		StartSequence(AnimStyle)
	EndIf
EndEvent

Function StartSequence(Int aiAnimStyle)
	if TargetIsPlayer
		if BathingActor.GetActorBase().GetSex()
			GoToState("InSequence" + GetAnimationFemale(Menu.AnimCustomFSet, aiAnimStyle, Menu.AnimCustomTierCond))
		else
			GoToState("InSequence" + GetAnimationMale(Menu.AnimCustomMSet, aiAnimStyle, Menu.AnimCustomTierCond))
		endIf
	else
		if BathingActor.GetActorBase().GetSex()
			GoToState("InSequence" + GetAnimationFemale(Menu.AnimCustomFSetFollowers, aiAnimStyle, Menu.AnimCustomTierCondFollowers))
		else
			GoToState("InSequence" + GetAnimationMale(Menu.AnimCustomMSetFollowers, aiAnimStyle, Menu.AnimCustomTierCondFollowers))
		endIf
	endIf
EndFunction

Function StartSequence_OVDE(Int aiAnimStyle)
	if TargetIsPlayer
		if BathingActor.GetActorBase().GetSex()
			GoToState("InSequence" + GetAnimationFemale_OVDE(aiAnimStyle))
		else
			GoToState("InSequence" + GetAnimationMale_OVDE(aiAnimStyle))
		endIf
	else
		if BathingActor.GetActorBase().GetSex()
			GoToState("InSequence" + GetAnimationFemale_OVDE(aiAnimStyle))
		else
			GoToState("InSequence" + GetAnimationMale_OVDE(aiAnimStyle))
		endIf
	endIf
EndFunction

State InSequence
	Event OnBeginState()
		Int AnimationCyclesRemaining = 0

		RinseOn()

		AnimationCyclesRemaining = (BathingAnimationLoopCountList.GetAt(mzinUtil.GetDirtinessTier(BathingActor, DirtinessSpellList)) As GlobalVariable).GetValue() As Int

		GetSoapy()

		While (AnimationCyclesRemaining > 0) && (GetState() == "InSequence")
			AnimationCyclesRemaining -= 1	
			Debug.SendAnimationEvent(BathingActor, "IdleWarmArms")
			Utility.Wait(2)
			Debug.SendAnimationEvent(BathingActor, "IdleStop")
			Utility.Wait(1)
		EndWhile

		StopAnimation(true)
	EndEvent
EndState
State InSequenceCustom
	Event OnBeginState()
		if BathingActor.PlayIdle(SelectedStyle)
			RegisterForSingleUpdate(75.0)
		else
			RegisterForSingleUpdate(2.0)
		endIf
	EndEvent
EndState
Function InSequenceDebug(Idle anim, Float animDuration)
	if ForceCustomAnimationDuration.GetValue() > 0
		animDuration = ForceCustomAnimationDuration.GetValue()
	endIf
	BathingActor.PlayIdle(anim)
	Utility.Wait(animDuration)
	StopAnimation()
EndFunction

; helpers
Function LockActor()
	BathingActor.SetHeadTracking(false)
	If TargetIsPlayer
		Game.DisablePlayerControls(False, True, True, False, True, True, True, 0)
		Game.SetPlayerAIDriven(true)
		if Game.GetCameraState() == 0
			Game.ForceFirstPerson()
			Utility.Wait(0.1)
			Game.ForceThirdPerson()
		endIf
		mzinUtil.SetHUDInstanceFlag(false)
		mzinUtil.SetFreeCam(true)
	else
		BathingActor.AllowPCDialogue(false)
		ActorUtil.AddPackageOverride(BathingActor, StopMovementPackage, 1)
		BathingActor.EvaluatePackage()
	EndIf
EndFunction

Function UnlockActor()
	If TargetIsPlayer
		mzinUtil.SetFreeCam(false)
		Game.EnablePlayerControls(abLooking = false)
		Game.SetPlayerAIDriven(false)
		mzinUtil.SetHUDInstanceFlag(true)
		mzinUtil.GameMessage(BathingCompleteMessage)
	else
		BathingActor.AllowPCDialogue(true)
		ActorUtil.RemovePackageOverride(BathingActor, StopMovementPackage)
		BathingActor.EvaluatePackage()
	EndIf
	BathingActor.SetHeadTracking(true)
EndFunction

String Function GetAnimationFemale(float[] IdleWeight, int aiIdleSet, int aiTierCond)

	If aiIdleSet > 1
		aiIdleSet += mzinUtil.GetRandomFromNormalization(IdleWeight)
	endIf

	If aiIdleSet == 2
		if WashPropIsSoap
			SelectedStyle = GetIdleByCondition(mzinBathe_Baka_S)
		else
			SelectedStyle = GetIdleByCondition(mzinBathe_Baka_C)
		endIf
		RinseOn()
	elseIf aiIdleSet == 3
		SelectedStyle = mzinBathe_Krzp[0]
	elseIf aiIdleSet == 4
		SelectedStyle = GetIdleByCondition(mzinBathe_JVRaven, aiTierCond)
	endIf
	
	if SelectedStyle
		return "Custom"
	endIf

	return ""
EndFunction

String Function GetAnimationFemale_OVDE(int aiIdleSet)
	If aiIdleSet == 2
		if WashPropIsSoap
			SelectedStyle = mzinBathe_Baka_S[0]
		else
			SelectedStyle = mzinBathe_Baka_C[0]
		endIf
		RinseOn()
	EndIf

	if SelectedStyle
		return "Custom"
	endIf

	return ""
EndFunction

String Function GetAnimationMale(float[] IdleWeight, int aiIdleSet, int aiTierCond)

	If aiIdleSet > 1
		aiIdleSet += mzinUtil.GetRandomFromNormalization(IdleWeight)
	endIf

	If aiIdleSet == 2
		if WashPropIsSoap
			SelectedStyle = GetIdleByCondition(mzinBathe_Tweens_S)
		else
			SelectedStyle = GetIdleByCondition(mzinBathe_Tweens_C)
		endIf
		RinseOn()
	endIf

	if SelectedStyle
		return "Custom"
	endIf

	return ""
EndFunction

String Function GetAnimationMale_OVDE(int aiIdleSet)
	If aiIdleSet == 2
		if WashPropIsSoap
			SelectedStyle = mzinBathe_Tweens_S[0]
		else
			SelectedStyle = mzinBathe_Tweens_C[0]
		endIf
		RinseOn()
	endIf

	if SelectedStyle
		return "Custom"
	endIf
	
	return ""
EndFunction

Function StopAnimation(bool PlayRinseOff = false)
	if !GetState()
		Return
	endIf

	GoToState("")
	UnregisterForEvents()
	Debug.SendAnimationEvent(BathingActor, "IdleForceDefaultState")
	Utility.Wait(0.5)

	if PlayRinseOff
		RinseOff()
		Debug.SendAnimationEvent(BathingActor, "IdleStop_Loose")
		Utility.Wait(0.5)
	EndIf

	DressActor()
	UnlockActor()
	mzinUtil.ForbidSex(BathingActor, Forbid = false)
	mzinUtil.Send_WashActorFinish(BathingActor, WashProp, WashPropIsSoap)
	BathingActor.RemoveSpell(PlayBathingAnimation)
EndFunction

Idle Function GetIdleByCondition(Idle[] IdleList, int aiArg = 0, int aiTarg = 0)
	if aiArg == 0
		aiTarg = Utility.RandomInt(0, IdleList.Length - 1)
	elseIf aiArg == 1
		aiTarg = mzinUtil.GetDirtinessTier(BathingActor, DirtinessSpellList)
	elseIf aiArg == 2
		aiTarg = mzinUtil.GetDangerTier(BathingActor, PlayerHouseLocationList, SettlementLocationList, DungeonLocationList)
	endIf
	if aiTarg >= IdleList.Length
		aiTarg = IdleList.Length - 1
	endIf
	return IdleList[aiTarg]
EndFunction

Function GetSoapy()
	If WashPropIsSoap
		If GetSoapyStyle.GetValue() == 1
			BathingActor.AddSpell(SoapyAppearanceSpell, False)
		ElseIf GetSoapyStyle.GetValue() == 2
			BathingActor.AddSpell(SoapyAppearanceAnimatedSpell, False)
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

Function StripActor()
	; clothes
	Clothing = mzinUtil.GetActorClothing(BathingActor, TargetIsPlayer, Init.KeywordIgnoreItem)
	ClothingID = mzinUtil.StripActorClothing(BathingActor, Clothing)
	
	; weapons
	Objects = mzinUtil.GetActorWeapons(BathingActor)
	ObjectsID = mzinUtil.StripActorWeapons(BathingActor, Objects)
	
	; sheathe
	mzinUtil.ExitWieldState(BathingActor)
EndFunction
Function DressActor()
	If GetDressedAfterBathingEnabled.GetValue() As Bool
		mzinUtil.DressActorEx(BathingActor, Clothing, ClothingID, Objects, ObjectsID)
	EndIf
EndFunction

Function RinseOn()
	if !IsShowering
		Debug.SendAnimationEvent(BathingActor, "IdleSearchingChest")
		Utility.Wait(3)
		Debug.SendAnimationEvent(BathingActor, "IdleStop")
		Utility.Wait(1.0)
	endIf
EndFunction
Function RinseOff()
	if IsShowering
		Debug.SendAnimationEvent(BathingActor, "IdleWarmArms")
	else
		Debug.SendAnimationEvent(BathingActor, "IdleSearchingChest")
	endIf
	GetUnsoapy()
	Utility.Wait(3)

	Debug.SendAnimationEvent(BathingActor, "IdleStop")
	Utility.Wait(0.7)

	if !IsShowering
		Debug.SendAnimationEvent(BathingActor, "IdleWipeBrow")
		Utility.Wait(3)
	endIf
EndFunction

Function RegisterForEvents()
	int i = mzinAnimEvent.Length
	while i
		i -= 1
		RegisterForAnimationEvent(BathingActor, mzinAnimEvent[i])
	endWhile
EndFunction

Function UnregisterForEvents()
	UnregisterForUpdate()
	int i = mzinAnimEvent.Length
	while i
		i -= 1
		UnregisterForAnimationEvent(BathingActor, mzinAnimEvent[i])
	endWhile
EndFunction

Event OnAnimationEvent(ObjectReference akSource, String asEventName)
	UnregisterForAnimationEvent(BathingActor, asEventName)
	if asEventName == "mzin_GetSoapy"
		GetSoapy()
	elseIf asEventName == "mzin_GetUnsoapy"
		GetUnsoapy()
	elseIf asEventName == "mzin_StopAnimationWithIdle"
		StopAnimation(true)
	elseIf asEventName == "mzin_StopAnimation"
		StopAnimation()
	else
		StopAnimation()
	EndIf
EndEvent

Event OnUpdate()
	StopAnimation()
EndEvent