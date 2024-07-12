Scriptname SuccubusCallFamiliarEffectScript Extends ActiveMagicEffect

Actor Property FamiliarActorRef Auto
SuccubusFamiliarQuestScript Property CFQ Auto
ReferenceAlias Property FamiliarAlias Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If StorageUtil.GetIntValue(FamiliarActorRef, "PSQ_IsSummoned") == 0
		CFQ.CallFamiliar(FamiliarActorRef)
		CFQ.SetFamiliar(FamiliarActorRef, FamiliarAlias)
		Debug.Notification("Remaining Energy" + (StorageUtil.GetFloatValue(FamiliarActorRef, "PSQ_FamiliarEnergy")))
	Else
		CFQ.EnergyConsume(FamiliarActorRef)
		CFQ.DismissFamiliar(FamiliarActorRef, FamiliarAlias)
		CFQ.ReturnFamiliar(FamiliarActorRef)
	EndIf
EndEvent
