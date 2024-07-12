Scriptname _SNSackofSalt extends activemagiceffect

_SNQuestScript Property _SNQuest Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	_SNQuest.HasSalmonella = 1
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	_SNQuest.HasSalmonella = 0
EndEvent