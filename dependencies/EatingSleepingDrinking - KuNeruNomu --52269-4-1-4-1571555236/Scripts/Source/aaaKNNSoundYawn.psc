Scriptname aaaKNNSoundYawn extends ActiveMagicEffect

Sound Property aaaKNNYawnFemale auto
Sound Property aaaKNNYawnMale auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	ActorBase playerBase = akTarget.GetActorBase()
	if playerBase
		if 0 == playerBase.GetSex()
			aaaKNNYawnMale.Play(akTarget)
		else
			aaaKNNYawnFemale.Play(akTarget)
		endIf
	endIf
EndEvent