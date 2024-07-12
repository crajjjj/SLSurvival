Scriptname _SLS_TeaseMyself extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	TargetActor = akTarget
	Debug.SendAnimationEvent(akTarget, AllInOneKey.GetRandomHornyAnim())
	If akTarget == AllInOneKey.PlayerRef
		StorageUtil.SetIntValue(None, "_SLS_PcIsPlayingWithHerself", 1)
	EndIf
	RegisterForAnimationEvent(AllInOneKey.PlayerRef, "FootRight")
	RegisterForSingleUpdate(Utility.RandomFloat(3.0, 5.0))
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName) ; In case something breaks the animation and the player forgets to stop playing
	UnRegisterForUpdate()
	FinishUp()
	AllInOneKey.PlayerRef.RemoveSpell(AllInOneKey._SLS_TeaseMyselfSpell)
EndEvent

Event OnUpdate()
	Util.ModArousal(TargetActor, 2.0)
	If Counter <= 0
		Devious.DoMoan(TargetActor)
		Counter = Utility.RandomInt(0, 2)
	EndIf
	Counter -= 1
	RegisterForSingleUpdate(Utility.RandomFloat(3.0, 5.0))
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	FinishUp()
EndEvent

Function FinishUp()
	If TargetActor == AllInOneKey.PlayerRef
		StorageUtil.SetIntValue(None, "_SLS_PcIsPlayingWithHerself", 0)
	EndIf
EndFunction

Int Counter = 1

Actor TargetActor

SLS_Utility Property Util Auto

_SLS_InterfaceDevious Property Devious Auto
_SLS_AllInOneKey Property AllInOneKey Auto
