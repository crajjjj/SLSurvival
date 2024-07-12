Scriptname _SLS_BarefootSpeed extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.ModAv("CarryWeight", 0.01)
	akTarget.ModAv("CarryWeight", -0.01)
	RegisterForModEvent("_SLS_BarefootStaggerChance", "On_SLS_BarefootStaggerChance")
	RegisterForSingleUpdate(1.0)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.ModAv("CarryWeight", 0.01)
	akTarget.ModAv("CarryWeight", -0.01)
EndEvent

Event OnUpdate()
	If StorageUtil.GetFloatValue(Menu, "BarefootStaggerChance", Missing = 20.0) > Utility.RandomFloat(0.0, 100.0) && PlayerRef.IsRunning() && !PlayerRef.IsOnMount() && !PlayerRef.IsSwimming() && PlayerRef.GetSitState() == 0
		If PlayerRef.GetLeveledActorBase().GetSex() == 1
			Int Pain = _SLS_BarefootPainFemaleSM.Play(PlayerRef)
			Sound.SetInstanceVolume(Pain, 0.5)
		Else
			Int Pain = _SLS_BarefootPainMaleSM.Play(PlayerRef)
			Sound.SetInstanceVolume(Pain, 0.5)
		EndIf
		Debug.SendAnimationEvent(PlayerRef, "staggerStart")
		PlayerRef.DamageAv("Stamina", Utility.RandomFloat(10.0, 20.0))
		PlayerRef.DamageAv("Magicka", Utility.RandomFloat(10.0, 20.0))
		PlayerRef.CreateDetectionEvent(PlayerRef, 10)
	EndIf
	RegisterForSingleUpdate(Utility.RandomFloat(1.5, 4.0))
EndEvent

Event On_SLS_BarefootStaggerChance(string eventName, string strArg, float numArg, Form sender)
	If Menu.BarefootMag > 0 && StorageUtil.GetFloatValue(Menu, "BarefootStaggerChance", Missing = 20.0) > 0.0
		RegisterForSingleUpdate(Utility.RandomFloat(2.0, 5.0))
	Else
		UnRegisterForUpdate()
	EndIf
EndEvent

Actor Property PlayerRef Auto

Sound Property _SLS_BarefootPainFemaleSM Auto
Sound Property _SLS_BarefootPainMaleSM Auto

SLS_Mcm Property Menu Auto
