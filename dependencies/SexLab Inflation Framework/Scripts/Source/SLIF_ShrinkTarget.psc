Scriptname SLIF_ShrinkTarget extends ActiveMagicEffect

int Casting = 0
float property Min auto
float property Default auto
float property Amount auto
float property Delay auto
string property ModName auto
string property Type auto
string property SpellType auto

Event OnEffectStart(Actor Target, Actor Caster)
	If SLIF_Inflate.HasScale(Target, ModName, Type)
		float tValue = SLIF_Inflate.GetScale(Target, ModName, Type, Default)
		
		While Casting == 0 && tValue > Min
			tValue = SLIF_Inflate.Deflate(Target, ModName, Type, Caster.GetAV(SpellType) * Amount, Min, Default)
			
			Utility.Wait(Delay)
		EndWhile
	EndIf
EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)
	Casting = 1
EndEvent
