Scriptname SuccubusSuccmonContractEffectScript Extends ActiveMagicEffect

ActorBase Property ContractActor Auto
Static Property XMarker Auto
Activator Property SummonTargetFXActivator Auto
EffectShader Property ConjureEffect Auto
Actor ContractActorRef

Event OnEffectStart(Actor akTarget, Actor akCaster)
	ObjectReference SMMarker = akCaster.PlaceAtme(XMarker)
	SMMarker.MoveTo(akCaster, 120.0 * Math.Sin(akCaster.GetAngleZ()), 120.0 * Math.Cos(akCaster.GetAngleZ()))
	SMMarker.SetAngle(akCaster.GetAngleX(), akCaster.GetAngleY(), akCaster.GetAngleZ() + 180)
	SMMarker.PlaceAtme(SummonTargetFXActivator)
	ContractActorRef = SMMarker.PlaceAtMe(ContractActor) As Actor
	ConjureEffect.Play(ContractActorRef, 1)
	SMMarker = None
	While !ContractActorRef.IsDisabled()
	EndWhile
	Dispel()
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	ConjureEffect.Play(ContractActorRef, 1)
	ContractActorRef.Disable(True)
	ContractActorRef.Delete()
EndEvent
