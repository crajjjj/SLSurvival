Scriptname PSQKissingQuestScript Extends Quest

Actor Property PlayerRef Auto
Package Property KissingDoNothing Auto
PlayerSuccubusQuestScript Property PSQ Auto
ImageSpaceModifier Property FadeToBlackHoldImod Auto
Spell Property KissingRaiseArousalSpell Auto
Keyword Property ArmorHelmet Auto
Keyword Property ClothingCirclet Auto
Actor KissingActor
Float LocX
Float LocY
Float LocZ
Float RotX
Float RotY
Float RotZ
Float PlayerRefScale
Float KissingActorScale
Float RaiseArousalCount
Armor KissingActorHelmet
Armor PlayerRefHelmet
Bool KissingNow
Bool AllowDrain

Event OnUpdate()
	If KissingNow
		If KissingActor.IsBleedingOut()
			Debug.SendAnimationEvent(KissingActor, "Arrok_StandingForeplay_A2_S1")
		EndIf
		SyncLocation()
		If AllowDrain
			KissDrain()
		EndIf
		RaiseArousalCount += PSQ.SuccubusRank.GetValue()
		If RaiseArousalCount >= 8
			RaiseArousalCount -= 8
			KissingRaiseArousalSpell.Cast(KissingActor)
		EndIf
		RegisterForSingleUpdate(1.0)
	EndIf
EndEvent

Event OnControlUp(String Control, Float HoldTime)
	If Control != "Activate"
		Return
	Endif
	
	If KissingNow
		EndKissing()
	EndIf
EndEvent

Function StartKissing(Actor Kiss)
	KissingActor = Kiss
	FadeToBlackHoldImod.ApplyCrossFade(2.0)
	Utility.Wait(2.0)
	
	Debug.ToggleCollisions()
	Game.ForceThirdPerson()
	If PSQ.SexLab.Config.AutoTFC && Game.GetCameraState() != 3
		MiscUtil.ToggleFreeCamera()
		MiscUtil.SetFreeCameraSpeed(PSQ.SexLab.Config.AutoSUCSM)
	EndIf
	LockActor()
	SyncLocation()
	
	KissingActor.SplineTranslateTo(LocX, LocY, LocZ, RotX, RotY, RotZ + 0.001, 20.0, 500, 0.00001)
	PlayerRef.SplineTranslateTo(LocX, LocY, LocZ, RotX, RotY, RotZ - 0.001, 20.0, 500, 0.00001)
	
	Utility.Wait(1.0)
	ImageSpaceModifier.RemoveCrossFade(2.0)
	
	RegisterForControl("Activate")
	KissingNow = True
	KissingActor.AddSpell(PSQ.SuccubusRapeVictimDebuffSpell, False)
	PSQ.SetEnergy(KissingActor)
	AllowDrain = PSQ.IsNotUndead(KissingActor)
	RegisterForSingleUpdate(1.0)
EndFunction

Function EndKissing()
	UnregisterForControl("Activate")
	KissingNow = False
	FadeToBlackHoldImod.ApplyCrossFade(2.0)
	Utility.Wait(2.0)
	
	Debug.ToggleCollisions()
	If Game.GetCameraState() == 3
		MiscUtil.ToggleFreeCamera()
	EndIf
	
	KissingActor.StopTranslation()
	PlayerRef.StopTranslation()
	
	UnLockActor()
	
	KissingActor = None
	KissingActorHelmet = None
	PlayerRefHelmet = None
	RaiseArousalCount = 0
	Utility.Wait(1.0)
	ImageSpaceModifier.RemoveCrossFade(2.0)
EndFunction

Function LockActor()
	Scaling()
	ClearHandsAndHead()
	ActorUtil.AddPackageOverride(PlayerRef, KissingDoNothing, 100)
	PlayerRef.EvaluatePackage()
	ActorUtil.AddPackageOverride(KissingActor, KissingDoNothing, 100)
	KissingActor.EvaluatePackage()
	Game.DisablePlayerControls(False, False, True, False, False, False, True)
	Game.SetPlayerAIDriven()
	KissingActor.SetRestrained(True)
	KissingActor.SetDontMove(True)
	MfgConsoleFunc.SetPhonemeModifier(KissingActor, 0, 15, 50)
	MfgConsoleFunc.SetPhonemeModifier(PlayerRef, 0, 15, 50)
	Debug.SendAnimationEvent(KissingActor, "Arrok_StandingForeplay_A2_S1")
	Debug.SendAnimationEvent(PlayerRef, "Arrok_StandingForeplay_A1_S1")
EndFunction

Function UnLockActor()
	Debug.SendAnimationEvent(KissingActor, "IdleForceDefaultState")
	Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
	PlayerRef.SetScale(PlayerRefScale)
	KissingActor.SetScale(KissingActorScale)
	PlayerRef.ClearExpressionOverride()
	MfgConsoleFunc.ResetPhonemeModifier(PlayerRef)
	KissingActor.ClearExpressionOverride()
	MfgConsoleFunc.ResetPhonemeModifier(KissingActor)
	ActorUtil.RemovePackageOverride(PlayerRef, KissingDoNothing)
	PlayerRef.EvaluatePackage()
	ActorUtil.RemovePackageOverride(KissingActor, KissingDoNothing)
	KissingActor.EvaluatePackage()
	Game.EnablePlayerControls()
	Game.SetPlayerAIDriven(False)
	KissingActor.SetRestrained(False)
	KissingActor.SetDontMove(False)
	KissingActor.EquipItem(KissingActorHelmet)
	PlayerRef.EquipItem(PlayerRefHelmet, False, True)
	KissingActor.RemoveSpell(PSQ.SuccubusRapeVictimDebuffSpell)
EndFunction

Function SyncLocation()
	RotX = PlayerRef.GetAngleX()
	RotY = PlayerRef.GetAngleY()
	RotZ = PlayerRef.GetAngleZ()
	LocX = PlayerRef.GetPositionX() + Math.sin(RotZ) * 1
	LocY = PlayerRef.GetPositionY() + Math.cos(RotZ) * 1
	LocZ = PlayerRef.GetPositionZ()
	
	KissingActor.SetPosition(LocX, LocY, LocZ)
	KissingActor.SetAngle(RotX, RotY, RotZ)
EndFunction

Function Scaling()
	Float Display
	Float Base
	
	Display = PlayerRef.GetScale()
	PlayerRef.SetScale(1.0)
	Base = PlayerRef.GetScale()
	PlayerRefScale = Display / Base
	PlayerRef.SetScale(0.985 / Base)
	
	Display = KissingActor.GetScale()
	KissingActor.SetScale(1.0)
	Base = KissingActor.GetScale()
	KissingActorScale = Display / Base
	KissingActor.SetScale(1 / Base)
EndFunction

Function KissDrain()
	If PSQ.IsNotUndead(KissingActor) && KissingActor.GetActorValue("Health") > 1
		Float KissPower = PSQ.SuccubusRank.GetValue()
		If KissPower > KissingActor.GetActorValue("Health")
			KissPower = KissingActor.GetActorValue("Health") - 1
		EndIf
		If KissPower > StorageUtil.GetFloatValue(KissingActor, "PSQ_EnergyOfActor")
			KissPower = StorageUtil.GetFloatValue(KissingActor, "PSQ_EnergyOfActor")
		EndIf
		KissingActor.DamageActorValue("Health", KissPower)
		KissingActor.DamageActorValue("Stamina", KissPower)
		StorageUtil.SetFloatValue(KissingActor, "PSQ_EnergyOfActor", StorageUtil.GetFloatValue(KissingActor, "PSQ_EnergyOfActor") - KissPower)
		PlayerRef.RestoreActorValue("Magicka", KissPower)
		PSQ.Satiety(KissPower)
	EndIf
EndFunction

Function ClearHandsAndHead()
	If KissingActor.IsWeaponDrawn()
		KissingActor.SheatheWeapon()
	EndIf
	
	If PlayerRef.IsWeaponDrawn()
		PlayerRef.SheatheWeapon()
	EndIf
	
	If KissingActor.GetWornForm(0x00001000) != None
		KissingActorHelmet = KissingActor.GetWornForm(0x00001000) as Armor
		If KissingActorHelmet.HasKeyword(ArmorHelmet) && !KissingActorHelmet.HasKeyword(ClothingCirclet)
			KissingActor.UnequipItem(KissingActorHelmet)
		EndIf
	EndIf
	
	If PlayerRef.GetWornForm(0x00001000) != None
		PlayerRefHelmet = PlayerRef.GetWornForm(0x00001000) as Armor
		If PlayerRefHelmet.HasKeyword(ArmorHelmet) && !PlayerRefHelmet.HasKeyword(ClothingCirclet)
			PlayerRef.UnequipItem(PlayerRefHelmet, False, True)
		EndIf
	EndIf
EndFunction
