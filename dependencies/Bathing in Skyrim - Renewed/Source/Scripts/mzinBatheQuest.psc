ScriptName mzinBatheQuest Extends Quest
{ this script handles some functions needed by other scripts }

import PO3_SKSEFunctions
import MiscUtil
import PapyrusUtil
import SPE_Actor
import SPE_ObjectRef

mzinUtilityPlayerAlias Property UtilityPlayer Auto
mzinBathePlayerAlias Property BathePlayer Auto
mzinInit Property Init Auto
mzinBatheMCMMenu Property Menu Auto
mzinOverlayUtility Property OlUtil Auto
mzinUtility Property mzinUtil Auto

GlobalVariable Property WaterRestrictionEnabled Auto
GlobalVariable Property GetSoapyStyle Auto
GlobalVariable Property GetSoapyStyleFollowers Auto
GlobalVariable Property ShynessDistance Auto
GlobalVariable Property CleansingSwim Auto
GlobalVariable Property DirtinessPercentage Auto
GlobalVariable Property GameDaysPassed Auto

FormList Property WashPropList Auto
FormList Property SoapBonusSpellList Auto
FormList Property DirtinessThresholdList Auto
FormList Property WaterfallList Auto
FormList Property SoapBonusMessageList Auto
FormList Property GetDirtyOverTimeSpellList Auto

Keyword Property WashPropKeyword Auto
Keyword Property SoapKeyword Auto
Keyword Property AnimationKeyword Auto
Keyword Property TrackedBatherActor Auto
Keyword Property ActorTypeNPC Auto

Faction Property TrackedBatherFaction Auto

Spell Property PlayBathingAnimation Auto

Message Property BathingNeedsWaterMessage Auto
Message Property BathingWithSoapMessage Auto
Message Property BathingWithoutSoapMessage Auto
Message Property ShoweringNeedsWaterMessage Auto
Message Property ShoweringWithSoapMessage Auto
Message Property ShoweringWithoutSoapMessage Auto

Actor Property PlayerRef Auto

Function RegForEvents()
	RegisterForModEvent("BiS_WashActor", "OnBiS_WashActor")
	RegisterForModEvent("BiS_WashActorFinish", "OnBiS_WashActorFinish")

	BathePlayer.RegisterHotKeys()
	BathePlayer.RegisterForModEvent("BiS_BatheEvent_" + PlayerRef.GetFormID(), "OnBiS_BatheEvent_Player")
	BathePlayer.RegisterForModEvent("BiS_GDOTStateChange_" + PlayerRef.GetFormID(), "OnBiS_GDOTStateChange_Player")

	UtilityPlayer.RegisterForModEvent("BiS_ForbidBathing", "OnBiS_ForbidBathing")
	UtilityPlayer.RegisterForModEvent("BiS_PermitBathing", "OnBiS_PermitBathing")
EndFunction

Event OnBiS_WashActor(Form akDirtyActor, Form akWashProp = none, Bool abDoShower = false, bool abDoPlayerTeammates = false, Bool abDoAnimate = false, Bool abFullClean = false)
	If akDirtyActor as Actor
		WashActor(akDirtyActor as Actor, akWashProp as MiscObject, abDoShower, abDoPlayerTeammates, abDoAnimate, abFullClean)
	Else
		mzinUtil.LogTrace("OnBiS_WashActor(): Received invalid actor: " + akDirtyActor)
	EndIf
EndEvent

Event OnBiS_WashActorFinish(Form akBathingActor, Form akWashProp = none, Bool abFullClean = false)
	If akBathingActor as Actor
		WashActorFinish(akBathingActor as Actor, akWashProp as MiscObject, abFullClean)
	Else
		mzinUtil.LogTrace("OnBiS_WashActorFinish(): Received invalid actor: " + akBathingActor)
	EndIf
EndEvent

Bool Function TryWashActor(Actor DirtyActor, MiscObject WashProp, Bool Shower = false, Bool PlayerTeammates = false)
	If WashProp == None
		WashProp = TryFindWashProp(DirtyActor)
	EndIf
	If !IsRestricted(DirtyActor)
		If Shower
			If IsUnderWaterfall(DirtyActor)
				WashActor(DirtyActor, WashProp, true, PlayerTeammates && Menu.AutomateFollowerBathing.GetValue() > 0)
				return true
			ElseIf DirtyActor == PlayerRef
				mzinUtil.GameMessage(ShoweringNeedsWaterMessage)
			EndIf
		Else
			If IsInWater(DirtyActor)
				WashActor(DirtyActor, WashProp, false, PlayerTeammates && Menu.AutomateFollowerBathing.GetValue() > 0)
				return true
			ElseIf DirtyActor == PlayerRef
				mzinUtil.GameMessage(BathingNeedsWaterMessage)
			EndIf
		EndIf
	EndIf
	return false
EndFunction

Function WashActor(Actor DirtyActor, MiscObject WashProp = none, Bool DoShower = false, Bool DoPlayerTeammates = false, Bool DoAnimate = true, Bool DoFullClean = false)
	mzinUtil.Send_TargetedEvent(DirtyActor, "PauseActorDirt")

	Bool DirtyActorIsPlayer = (DirtyActor == PlayerRef)
	If DirtyActorIsPlayer
		mzinInterfaceFrostfall.MakeWet(Init.FrostfallRunning_var, 1000.0)
	EndIf

	If WashProp && WashProp.HasKeyWord(SoapKeyword) && DirtyActor.GetItemCount(WashProp) > 0
		DirtyActor.RemoveItem(WashProp, 1, True, None)
		DoFullClean = True
	EndIf

	RemoveDecals(DirtyActor, true)

	if DoAnimate && !IsSubmerged(DirtyActor)
		if DirtyActorIsPlayer
			If DoShower
				if DoFullClean
					mzinUtil.GameMessage(ShoweringWithSoapMessage)
				else
					mzinUtil.GameMessage(ShoweringWithoutSoapMessage)
				endIf
			else
				if DoFullClean
					mzinUtil.GameMessage(BathingWithSoapMessage)
				else
					mzinUtil.GameMessage(BathingWithoutSoapMessage)
				endIf
			EndIf
		EndIf
		StorageUtil.SetFormValue(DirtyActor, "mzin_LastWashProp", WashProp)
		StorageUtil.SetIntValue(DirtyActor, "mzin_LastWashState", DoShower as int)
		mzinUtil.Send_ResetActorDirt(DirtyActor, DoFullClean)
		DirtyActor.AddSpell(PlayBathingAnimation, False)
	Else
		ResetGDOTSpell(DirtyActor, (DirtinessThresholdList.GetAt((!DoFullClean) as int) As GlobalVariable).GetValue())
		WashActorFinish(DirtyActor, WashProp, DoFullClean)
	endIf

	DirtyActor.ClearExtraArrows()
	mzinInterfaceSexLab.ClearCum(Init.SL_API, DirtyActor)
	mzinInterfaceOCum.OCClearCum(Init.OCA_API, DirtyActor)
	mzinInterfaceFadeTats.FadeTats(Init.FadeTats_API, DirtyActor, DoFullClean, Menu.FadeTatsFadeTime, Menu.FadeTatsSoapMult)
	mzinUtil.Send_BatheEvent(DirtyActor as Form, DoPlayerTeammates)
EndFunction

Function WashActorFinish(Actor DirtyActor, MiscObject WashProp = none, Bool DoFullClean = false)
	If !DirtyActor.HasKeyword(TrackedBatherActor)
		Return
	EndIf

	If DoFullClean
		ApplySoapBonus(DirtyActor, WashProp)
	EndIf
EndFunction

Function ResetGDOTSpell(Actor targetActor, Float targetValue)
	If !targetActor.HasKeyword(TrackedBatherActor)
		Return
	EndIf

	Float currentValue = GetActorDirtPercent(targetActor)
	RemoveAddedSpells(targetActor, "", mzinUtil.arrkwDirtinessSpell, false)
	RemoveAddedSpells(targetActor, "", mzinUtil.arrkwGDOTSpell, false)
	If targetValue < currentValue
		UpdateActorDirtPercent(targetActor, targetValue)
	Else
		targetValue = currentValue
	EndIf
	If StorageUtil.HasStringValue(targetActor, "mzin_DirtTexturePrefix")
		If targetValue < Menu.OverlayApplyAt
			OlUtil.ClearDirt(targetActor, true)
		Else
			OlUtil.UpdateAlpha(targetActor, Menu.StartingAlpha)
		EndIf
	EndIf
	targetActor.AddSpell(GetGDOTSpell(targetValue, GetDirtyOverTimeSpellList.GetSize()), False)
	StorageUtil.SetFloatValue(targetActor, "BiS_LastUpdate", GameDaysPassed.GetValue())
EndFunction

Spell Function GetGDOTSpell(Float targetValue, int iMax, int iInit = 0)
	While iInit < iMax
		if targetValue <= (DirtinessThresholdList.GetAt(iInit + 1) As GlobalVariable).GetValue()
			return GetDirtyOverTimeSpellList.GetAt(iInit) As Spell
		endIf
		iInit += 1
	EndWhile
	return GetDirtyOverTimeSpellList.GetAt(iInit) As Spell
EndFunction

Bool Function HasGDOTSpell(Actor targetActor)
	int i = GetDirtyOverTimeSpellList.GetSize()
	While i
		i -= 1
		If targetActor.HasSpell(GetDirtyOverTimeSpellList.GetAt(i) As Spell)
			Return True
		EndIf
	EndWhile
	Return False
EndFunction

Function ApplySoapBonus(Actor DirtyActor, MiscObject WashProp)
	If !WashProp
		Return
	EndIf

	RemoveAddedSpells(DirtyActor, "", mzinUtil.arrkwSoapBonusSpell, false)
	Int Index = GetSoapIndex(WashProp)
	DirtyActor.AddSpell(SoapBonusSpellList.GetAt(Index) As Spell, False)
	If DirtyActor == PlayerRef
		mzinUtil.GameMessage(SoapBonusMessageList.GetAt(Index) As Message)
	EndIf
EndFunction

Int Function GetSoapIndex(MiscObject WashProp)
	Int Index = WashPropList.Find(WashProp)
	If Index != -1
		return Index
	Else
		If WashProp.HasKeyword(SoapKeyword)
			return 1
		Else
			return 0
		EndIf
	EndIf
EndFunction

MiscObject Function TryFindWashProp(Actor DirtyActor)
	Keyword[] kwWashPropValid = new Keyword[2]
	kwWashPropValid[0] = SoapKeyword
	kwWashPropValid[1] = WashPropKeyword

	Form[] WashPropArray = SPE_Utility.FilterFormsByKeyword(AddItemsOfTypeToArray(DirtyActor, 32), kwWashPropValid, false, false)
	If !WashPropArray
		Return none
	EndIf

	Form[] arr = SPE_Utility.IntersectArray_Form(AddItemsWithKeywordToArray(DirtyActor, SoapKeyword), WashPropArray)
	if arr
		arr[Utility.RandomInt(0, arr.Length - 1)] as MiscObject
	endIf
	
	Return WashPropArray[Utility.RandomInt(0, WashPropArray.Length - 1)] as MiscObject
EndFunction

Bool Function IsInWater(Actor DirtyActor)
	if Init.IsWadeInWaterInstalled && Menu.WadeDetection
		return !(WaterRestrictionEnabled.GetValue() As Bool) || DirtyActor.HasMagicEffect(Init.LokiWaterSlowdownEffect)
	endIf
	return !(WaterRestrictionEnabled.GetValue() As Bool) || IsActorInWater(DirtyActor)
EndFunction

Bool Function IsUnderWaterfall(Actor DirtyActor)
	If !(WaterRestrictionEnabled.GetValue() As Bool)
		Return True
	EndIf

	ObjectReference closestWaterfall = Game.FindClosestReferenceOfAnyTypeInListFromRef(WaterfallList, DirtyActor, 3000.0)	
	
	If closestWaterfall

		mzinUtil.LogTrace("player_Z() = " + DirtyActor.GetPositionZ() + "     Waterfall_Z = " + closestWaterfall.GetPositionZ() + "  diff_Z = " + (DirtyActor.GetPositionZ() - closestWaterfall.GetPositionZ()) as float)
		; mzinUtil.LogNotification("player_Z() = " + DirtyActor.GetPositionZ() + "     Waterfall_Z = " + closestWaterfall.GetPositionZ() + "  diff_Z = " + (DirtyActor.GetPositionZ() - closestWaterfall.GetPositionZ()) as float)
		mzinUtil.LogTrace("player_X() = " + DirtyActor.GetPositionX() + "     Waterfall_X() = " + closestWaterfall.GetPositionX() + "  diff_X = " + (DirtyActor.GetPositionX() - closestWaterfall.GetPositionX()) as float)
		; mzinUtil.LogNotification("player_X() = " + DirtyActor.GetPositionX() + "     Waterfall_X() = " + closestWaterfall.GetPositionX() + "  diff_X = " + (DirtyActor.GetPositionX() - closestWaterfall.GetPositionX()) as float)
		mzinUtil.LogTrace("player_Y() = " + DirtyActor.GetPositionY() + "     Waterfall_Y() = " + closestWaterfall.GetPositionY() + "  diff_Y = " + (DirtyActor.GetPositionY() - closestWaterfall.GetPositionY()) as float)
		; mzinUtil.LogNotification("player_Y() = " + DirtyActor.GetPositionY() + "     Waterfall_Y() = " + closestWaterfall.GetPositionY() + "  diff_Y = " + (DirtyActor.GetPositionY() - closestWaterfall.GetPositionY()) as float)


		; PC can shower when standing within 2 character lengths of the waterfall (256 units), and at any height below it.
		if (DirtyActor.GetPositionZ() <= closestWaterfall.GetPositionZ() + 1280.0) \
		&& (math.abs(DirtyActor.GetPositionX() - closestWaterfall.GetPositionX()) <= 256.0) \
		&& (math.abs(DirtyActor.GetPositionY() - closestWaterfall.GetPositionY()) <= 256.0)
			Return True
		else
			mzinUtil.LogTrace("There is a waterfall nearby, but the player isn't under it.")
		EndIf
	EndIf

	Return False
EndFunction

Bool Function IsRestricted(Actor DirtyActor, Actor PotentialGawker = None)
	return IsConditionallyRestricted(DirtyActor) || IsTooShy(DirtyActor, PotentialGawker)
EndFunction

Bool Function IsConditionallyRestricted(Actor DirtyActor)
	return IsSwimmingConditional(DirtyActor) || IsDeviceBlocked(DirtyActor) || IsActorAnimating(DirtyActor) || DirtyActor.GetSitState() || IsNotPermitted(DirtyActor)
EndFunction

Bool Function IsActorAnimating(Actor DirtyActor)
	return DirtyActor.HasMagicEffectWithKeyword(AnimationKeyword) \
	|| mzinInterfaceSexLab.IsActorActive(Init.SL_API, DirtyActor) \
	|| (Init.IsOstimInstalled && mzinInterfaceOStim.IsActorActive(DirtyActor))
EndFunction

Bool Function IsDeviceBlocked(Actor akTarget)
	If Init.IsDeviousDevicesInstalled
		If akTarget.WornHasKeyword(Init.zad_DeviousHeavyBondage)
			if akTarget == PlayerRef
				mzinUtil.LogNotification("You can't wash yourself with your hands tied")
			endIf
			Return True
		ElseIf akTarget.WornHasKeyword(Init.zad_DeviousSuit)
			if akTarget == PlayerRef
				mzinUtil.LogNotification("You can't wash yourself while wearing this suit")
			endIf
			Return True
		EndIf
	EndIf
	Return False
EndFunction

Bool Function IsNotPermitted(Actor akTarget)
	Int Index = StorageUtil.FormListFind(none, "BiS_ForbiddenActors", akTarget)
	If Index != -1
		Int ForbiddenCount = StorageUtil.StringListCount(akTarget, "BiS_ForbiddenString") - 1
		String ForbiddenString = StorageUtil.StringListGet(akTarget, "BiS_ForbiddenString", ForbiddenCount)
		If ForbiddenString != ""
			mzinUtil.LogNotification(ForbiddenString)
		Else
			mzinUtil.LogTrace("IsNotPermitted: Blank string retrieved for index " + ForbiddenCount + " on actor " + akTarget)
		EndIf
		
		; Send forbidden bathe attempt modevent
		Int ForbiddenBatheAttempt = ModEvent.Create("BiS_ForbiddenBatheAttempt")
		If (ForbiddenBatheAttempt)
			ModEvent.PushForm(ForbiddenBatheAttempt, akTarget)
			ModEvent.Send(ForbiddenBatheAttempt)
		EndIf
		Return True
	Else
		Return False
	EndIf
EndFunction

Bool Function IsTooShy(Actor akTarget, Actor akGawker = none)
	If (ShynessDistance.GetValue() as int) >= 0
		If Init.IsSexlabArousedInstalled && akTarget.GetFactionRank(Init.SLAExhibitionistFaction) >= 0
			Return False
		EndIf

		If akTarget == PlayerRef
			If !akGawker
				akGawker = GetGawker(akTarget, ShynessDistance.GetValue())
			EndIf
			If akGawker
				mzinUtil.LogNotification("I'd rather not bathe in front of " + akGawker.GetBaseObject().GetName() + ".")
				Return True
			EndIf
		ElseIf akTarget.IsPlayerTeammate()
			If !akGawker
				akGawker = GetGawker(akTarget, ShynessDistance.GetValue())
			EndIf
			If akGawker
				mzinUtil.LogNotification(akTarget.GetBaseObject().GetName() + ": You're joking, right? I'm not bathing in front of " +  akGawker.GetBaseObject().GetName() + "!")
				Return True
			EndIf
		Else
			If GetNPCFromArray(GetDetectedActors(akTarget), akTarget)
				Return True
			EndIf
		EndIf
	EndIf
	Return False
EndFunction

Bool Function IsSwimmingConditional(Actor akTarget)
	return (((CleansingSwim.GetValue() * 100.0) as int) < 0) && akTarget.IsSwimming()
EndFunction

Bool Function IsSubmerged(Actor akTarget)
	Return (akTarget.IsSwimming() || IsActorUnderwater(akTarget))
EndFunction

Bool Function IsWeatherWet(Actor akTarget)
	; This function is able to differentiate functional interiors from functional exteriors using the following logic:
		; Interior WorldSpace Cells flagged as Not Interior have an exterior location.
		; Exterior WorldSpace Cells flagged as Not Interior lack an exterior location.
		
	if akTarget.GetWorldSpace() && (GetWeatherType() > 1)
		Location[] ExteriorLocations = SPE_Cell.GetExteriorLocations(akTarget.GetParentCell())
		return !(ExteriorLocations && ExteriorLocations[0])
	endIf
	Return !akTarget.IsInInterior() && (GetWeatherType() > 1)
EndFunction

Actor Function GetGawker(Actor akActor, Float afDistance)
	; This function should only be run for players and player teammates
	
	If afDistance > 0.00 && (!akActor.IsInInterior() || akActor.GetWorldSpace())
		Return GetNPCFromArray(GetDiffActor(ScanCellNPCs(akActor, afDistance), GetPlayerFollowers()), akActor)
	EndIf
	Return GetNPCFromArray(GetDiffActor(GetDetectedBy(akActor), GetPlayerFollowers()), akActor)
EndFunction

Actor Function GetNPCFromArray(Actor[] ActorList, Actor targetActor)
	ActorList = RemoveActor(ActorList, targetActor)
	int i = ActorList.Length
	While i
		i -= 1
		If ActorList[i].HasKeyword(ActorTypeNPC) && ActorList[i].HasLOS(targetActor)
			Return ActorList[i]
		EndIf
	EndWhile
	Return None
EndFunction

Function UntrackActor(Actor DirtyActor, Bool abRemoveOverlays = true)
	if abRemoveOverlays
		OlUtil.ClearDirtGameLoad(DirtyActor)
	else
		StorageUtil.UnSetStringValue(DirtyActor, "mzin_DirtTexturePrefix")
	endIf

	RemoveAddedSpells(DirtyActor, "", mzinUtil.arrkwGDOTSpell, false)
	RemoveAddedSpells(DirtyActor, "", mzinUtil.arrkwDirtinessSpell, false)
	RemoveAddedSpells(DirtyActor, "", mzinUtil.arrkwSoapBonusSpell, false)

	RemoveKeywordFromRef(DirtyActor, TrackedBatherActor)

	StorageUtil.UnSetFloatValue(DirtyActor, "BiS_Dirtiness")
	StorageUtil.UnSetFloatValue(DirtyActor, "BiS_LastUpdate")
	StorageUtil.UnSetFormValue(DirtyActor, "mzin_LastWashProp")
	StorageUtil.UnSetIntValue(DirtyActor, "mzin_LastWashState")

	if DirtyActor != PlayerRef
		DirtyActor.RemoveFromFaction(TrackedBatherFaction)
		if Init.IsSexLabInstalled
			mzinInterfaceSexLab.UntrackActor(Init.SL_API, DirtyActor, DirtyActor.GetFormID())
		endIf
	endIf
EndFunction

Function UpdateActorDirtPercent(Actor akActor, float afNewValue)
	If akActor == PlayerRef
		DirtinessPercentage.SetValue(afNewValue)
	elseIf akActor.IsInFaction(TrackedBatherFaction)
		StorageUtil.SetFloatValue(akActor, "BiS_Dirtiness", afNewValue)
	EndIf
EndFunction

Float Function GetActorDirtPercent(Actor akActor)
	If akActor == PlayerRef
		return DirtinessPercentage.GetValue()
	ElseIf akActor.IsInFaction(TrackedBatherFaction)
		StorageUtil.GetFloatValue(akActor, "BiS_Dirtiness")
	EndIf
EndFunction