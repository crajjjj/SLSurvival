Scriptname SLIF_Absorb extends ActiveMagicEffect

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
GlobalVariable property KillTarget auto

Event OnEffectStart(Actor Target, Actor Caster)
	If SLIF_Inflate.HasScale(Target, ModName, Type)
		float tValue = SLIF_Inflate.GetScale(Target, ModName, Type, Default)
		float cValue = SLIF_Inflate.GetScale(Caster, ModName, Type, Default)
		
		While Casting == 0 && Target.IsDead() == 0 && (tValue > Min || cValue < Max)
			float Change = Caster.GetAV(SpellType) * Amount / ((Target.GetAV(ResistType)/10) + 1)
			
			tValue = SLIF_Inflate.Deflate(Target, ModName, Type, SLIF_Math.DivideFloatNumbers(Change, tDivisor), Min, Default)
			cValue = SLIF_Inflate.Inflate(Caster, ModName, Type, SLIF_Math.DivideFloatNumbers(Change, cDivisor), Max, Default)
			
			Utility.Wait(Delay)
		EndWhile
		
		If tValue <= Min && KillTarget.GetValueInt() as bool  ; Kills target if too small.
			Target.Kill(Caster)
		EndIf
	EndIf
EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)
	Casting = 1
EndEvent
