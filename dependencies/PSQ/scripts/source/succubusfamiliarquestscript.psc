ScriptName SuccubusFamiliarQuestScript Extends Quest

PlayerSuccubusQuestScript Property PSQ Auto
Static Property XMarker Auto
ObjectReference Property HomeMarker Auto
Activator Property SummonTargetFXActivator Auto
EffectShader Property ConjureEffect Auto
Race Property HorseRace Auto

Function CallFamiliar(ObjectReference FamiliarRef)
	ObjectReference SMMarker = PSQ.PlayerRef.PlaceAtme(XMarker)
	SMMarker.MoveTo(PSQ.PlayerRef, 120.0 * Math.Sin(PSQ.PlayerRef.GetAngleZ()), 120.0 * Math.Cos(PSQ.PlayerRef.GetAngleZ()))
	SMMarker.SetAngle(PSQ.PlayerRef.GetAngleX(), PSQ.PlayerRef.GetAngleY(), PSQ.PlayerRef.GetAngleZ() + 180)
	SMMarker.PlaceAtme(SummonTargetFXActivator)
	FamiliarRef.MoveTo(SMMarker)
	ConjureEffect.Play(FamiliarRef, 1)
	StorageUtil.SetIntValue(FamiliarRef, "PSQ_IsSummoned", 1)
	StorageUtil.SetFloatValue(FamiliarRef, "PSQ_FamiliarLastConsumeTime", PSQ.GameDaysPassed.GetValue())
	
	If PSQ.EFFActive && (FamiliarRef as Actor).GetRace() != HorseRace
		PSQ.XFLMain.XFL_AddFollower(FamiliarRef)
	EndIf
	
	SMMarker = None
EndFunction

Function ReturnFamiliar(ObjectReference FamiliarRef)
	ConjureEffect.Play(FamiliarRef, 1)
	FamiliarRef.MoveTo(HomeMarker)
EndFunction

Function SetFamiliar(ObjectReference FamiliarRef, ReferenceAlias FamiliarAlias)
	Actor FamiliarActorRef = FamiliarRef as Actor
	FamiliarActorRef.SetPlayerTeammate()
	FamiliarAlias.ForceRefTo(FamiliarActorRef)
	FamiliarAlias.RegisterForSingleUpdate(1)
EndFunction

Function DismissFamiliar(ObjectReference FamiliarRef, ReferenceAlias FamiliarAlias)
	Actor FamiliarActorRef = FamiliarRef as Actor
	
	If PSQ.EFFActive
		PSQ.XFLMain.XFL_RemoveFollower(FamiliarActorRef, 0, 0)
	EndIf
	
	FamiliarActorRef.SetPlayerTeammate(False)
	If FamiliarActorRef.IsDead()
		FamiliarActorRef.Resurrect()
	EndIf
	FamiliarAlias.UnregisterForUpdate()
	FamiliarAlias.Clear()
	StorageUtil.SetIntValue(FamiliarActorRef, "PSQ_IsSummoned", 0)
EndFunction

Function FamiliarDied(Actor FamiliarActorRef, ReferenceAlias FamiliarAlias)
	Float DeadEnergy = StorageUtil.GetFloatValue(FamiliarActorRef, "PSQ_FamiliarEnergy") - StorageUtil.GetFloatValue(FamiliarActorRef, "PSQ_FamiliarMaxEnergy") / 2
	If DeadEnergy < 0
		DeadEnergy = 0
	EndIf
	StorageUtil.SetFloatValue(FamiliarActorRef, "PSQ_FamiliarEnergy", DeadEnergy)
	EnergyConsume(FamiliarActorRef)
	FamiliarActorRef.SetPlayerTeammate(False)
	StorageUtil.SetIntValue(FamiliarActorRef, "PSQ_IsSummoned", 0)
	ConjureEffect.Play(FamiliarActorRef, 1)
	FamiliarActorRef.MoveTo(HomeMarker)
	FamiliarActorRef.Resurrect()
	FamiliarAlias.UnregisterForUpdate()
	FamiliarAlias.Clear()
	Float FamiliarLoyalty = StorageUtil.GetFloatValue(FamiliarActorRef, "PSQ_FamiliarLoyalty")
	FamiliarLoyalty -= 10
	If FamiliarLoyalty < 0
		FamiliarLoyalty = 0
	Endif
	StorageUtil.SetFloatValue(FamiliarActorRef, "PSQ_FamiliarLoyalty", FamiliarLoyalty)
	FamiliarActorRef.SetFactionRank(PSQ.FamiliarLoyaltyFaction, FamiliarLoyalty as Int)
EndFunction

Function EnergyConsume(Actor FamiliarActorRef)
	Float ConsumeTimer = PSQ.GameDaysPassed.GetValue() - StorageUtil.GetFloatValue(FamiliarActorRef, "PSQ_FamiliarLastConsumeTime")
	Float ConsumeEnegy = StorageUtil.GetFloatValue(FamiliarActorRef, "PSQ_FamiliarMaxEnergy") * ConsumeTimer
	ConsumeEnegy = ConsumeEnegy * (1 - StorageUtil.GetFloatValue(FamiliarActorRef, "PSQ_FamiliarLoyalty") / 200)
	Float CurrentEnegy = StorageUtil.GetFloatValue(FamiliarActorRef, "PSQ_FamiliarEnergy") - ConsumeEnegy
	If CurrentEnegy <= 0
		CurrentEnegy = 0
		FamiliarActorRef.AddToFaction(PSQ.FamiliarDebuffFaction)
	Else
		FamiliarActorRef.RemoveFromFaction(PSQ.FamiliarDebuffFaction)
	EndIf
	StorageUtil.SetFloatValue(FamiliarActorRef, "PSQ_FamiliarEnergy", CurrentEnegy)
	StorageUtil.SetFloatValue(FamiliarActorRef, "PSQ_FamiliarLastConsumeTime", PSQ.GameDaysPassed.GetValue())
EndFunction
