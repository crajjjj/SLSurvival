ScriptName PSQLureCastScript Extends ActiveMagicEffect  

PlayerSuccubusQuestScript Property PSQ Auto
Float Increment
Float ArousalIncrement

Event OnEffectStart(Actor Target, Actor Caster)
	Int Area = PSQ.SuccubusRank.GetValueInt() * PSQ.SuccubusRank.GetValueInt() * 10
	If Area < 50
		Area = 50
	EndIf
	PSQ.PSQLureRegisterSpell.SetNthEffectArea(0, Area)
	Increment = PSQ.SuccubusRank.GetValue() / 2
	RegisterForSingleUpdate(2)
EndEvent

Event OnUpdate()
	ArousalIncrement = ArousalIncrement + Increment
	If ArousalIncrement > 1
		Int I = Math.Floor(ArousalIncrement)
		PSQ.PSQLureRegisterSpell.SetNthEffectMagnitude(0, I as Float)
		PSQ.PSQLureRegisterSpell.Cast(PSQ.PlayerRef, PSQ.PlayerRef)
		ArousalIncrement = ArousalIncrement - I as Float
	EndIf
	PSQ.Satiety(-1 * PSQ.SuccubusRank.GetValue())
	RegisterForSingleUpdate(1)
EndEvent
