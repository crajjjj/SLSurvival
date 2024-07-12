Scriptname SLIF_Give extends ActiveMagicEffect

int Casting = 0
float property cDivisor auto
float property tDivisor auto
float property Min auto
float property Max auto
float property Default auto
float property Amount auto
float property Delay auto
string property ModName auto
string property Type auto
string property SpellType auto
string property ResistType auto

Event OnEffectStart(Actor Target, Actor Caster)
	If SLIF_Inflate.HasScale(Caster, ModName, Type)
		float tValue = SLIF_Inflate.GetScale(Target, ModName, Type, Default)
		float cValue = SLIF_Inflate.GetScale(Caster, ModName, Type, Default)
		
		While Casting == 0 && (tValue < Max || cValue > Min)
			float Change = Caster.GetAV(SpellType) * Amount / ((Target.GetAV(ResistType)/10) + 1)
			
			tValue = SLIF_Inflate.Inflate(Target, ModName, Type, SLIF_Math.DivideFloatNumbers(Change, tDivisor), Max, Default)
			cValue = SLIF_Inflate.Deflate(Caster, ModName, Type, SLIF_Math.DivideFloatNumbers(Change, cDivisor), Min, Default)
			
			Utility.Wait(Delay)
		EndWhile
	EndIf
EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)
	Casting = 1
EndEvent
