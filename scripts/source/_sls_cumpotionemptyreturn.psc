Scriptname _SLS_CumPotionEmptyReturn extends ActiveMagicEffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.AddItem(Game.GetFormFromFile(0x0FAE1C, "SL Survival.esp"))
EndEvent
