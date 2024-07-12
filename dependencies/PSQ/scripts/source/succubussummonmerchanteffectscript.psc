Scriptname SuccubusSummonMerchantEffectScript Extends ActiveMagicEffect

ActorBase Property SuccubusMerchant Auto
Static Property XMarker Auto
Activator Property SummonTargetFXActivator Auto
Actor SuccubusMerchantRef

Event OnEffectStart(Actor akTarget, Actor akCaster)
	ObjectReference SMMarker = akCaster.PlaceAtme(XMarker)
	SMMarker.MoveTo(akCaster, 120.0 * Math.Sin(akCaster.GetAngleZ()), 120.0 * Math.Cos(akCaster.GetAngleZ()))
	SMMarker.SetAngle(akCaster.GetAngleX(), akCaster.GetAngleY(), akCaster.GetAngleZ() + 180)
	SMMarker.PlaceAtme(SummonTargetFXActivator)
	Utility.Wait(0.5)
	SuccubusMerchantRef = SMMarker.PlaceAtMe(SuccubusMerchant) As Actor
	SMMarker = None
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	SuccubusMerchantRef.Disable()
	SuccubusMerchantRef.Delete()
EndEvent
