Scriptname SLIF_GrowTarget extends ActiveMagicEffect

int Casting = 0
float property Max auto
float property Default auto
float property Amount auto
float property Delay auto
string property ModName auto
string property Type auto
string property SpellType auto

Event OnEffectStart(Actor Target, Actor Caster)
	If SLIF_Inflate.HasScale(Target, ModName, Type)
		float tValue = SLIF_Inflate.GetScale(Target, ModName, Type, Default)
		
		While Casting == 0 && tValue < Max
			tValue = SLIF_Inflate.Inflate(Target, ModName, Type, Caster.GetAV(SpellType) * Amount, Max, Default)
			
			Utility.Wait(Delay)
		EndWhile
	EndIf
EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)
	Casting = 1
EndEvent
