Scriptname dcc_sgo_EffectDeflateTrigger_Main extends ActiveMagicEffect
{this script triggers the deflation ability.}

dcc_sgo_QuestController Property  SGO Auto

Event OnEffectStart(Actor Who, Actor From)
	Who.AddSpell(SGO.dcc_sgo_SpellDeflate,TRUE)
	Return
EndEvent
