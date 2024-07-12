Scriptname _SLS_CumEffectHorse extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If Menu.CumpulsionChance > Utility.RandomFloat(0.0, 100.0)
		_SLS_CumpulsionPonyQuest.Start()
	EndIf
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	CumpulsionPony.EndEffect()
EndEvent

Quest Property _SLS_CumpulsionPonyQuest Auto

_SLS_CumpulsionPony Property CumpulsionPony Auto

SLS_Mcm Property Menu Auto
