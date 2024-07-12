Scriptname RND_StaleFood extends activemagiceffect  
{this script plays CoughCough animation and sound after eating stale food}

Event OnEffectStart(Actor akTarget, Actor akCaster)

	If RND_AnimMisc.GetValue() == 1
		If !Game.GetPlayer().GetAnimationVariableInt("i1stPerson") == 1
			Game.GetPlayer().PlayIdle(IdleUnControllableCough)
		EndIf
	EndIf
	Game.GetPlayer().Say(CoughCough)
	
EndEvent


Topic Property CoughCough Auto 

Idle Property IdleUnControllableCough  Auto

GlobalVariable Property RND_AnimMisc Auto

 