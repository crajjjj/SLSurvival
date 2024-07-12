Scriptname PSQContractActorScript Extends Actor

Spell Property CallMePower Auto
EffectShader Property ConjureEffect Auto
Float Property FamiliarEnergy Auto
Actor Property FamiliarActorRef Auto

Event OnActivate(ObjectReference akActionRef)
	RegisterForModEvent("OrgasmEnd", "ContractFormation")
EndEvent

Event ContractFormation(String HookName, String ArgString, Float ArgNum, Form Sender)
	RegisterForModEvent("AnimationEnd", "ContractFormationFinish")
EndEvent

Event ContractFormationFinish(String HookName, String ArgString, Float ArgNum, Form Sender)
	Game.GetPlayer().AddSpell(CallMePower)
	StorageUtil.SetFloatValue(FamiliarActorRef, "PSQ_FamiliarMaxEnergy", FamiliarEnergy)
	StorageUtil.SetFloatValue(FamiliarActorRef, "PSQ_FamiliarEnergy", FamiliarEnergy)
	ConjureEffect.Play(Self, 1)
	Self.Disable(True)
	Self.Delete()
EndEvent
