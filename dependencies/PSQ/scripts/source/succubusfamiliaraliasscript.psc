ScriptName SuccubusFamiliarAliasScript Extends ReferenceAlias

SuccubusFamiliarQuestScript Property CFQ Auto

Event OnDeath(Actor akKiller)
	CFQ.FamiliarDied(Self.GetActorRef(), Self)
EndEvent

;召喚されている場合一定時間ごとにエナジー消費
Event OnUpdate()
	CFQ.EnergyConsume(Self.GetActorRef())
	RegisterForSingleUpdate(15)
EndEvent
