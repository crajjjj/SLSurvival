Scriptname _SLS_Highlight extends Quest

EffectShader Function GetEffectFor(Form akForm)
	Return StorageUtil.GetFormValue(None, "_SLS_EffectShaderType_" + akForm.GetType()) as EffectShader
EndFunction

EffectShader Property _SLS_HighlightAmmo Auto
EffectShader Property _SLS_HighlightArmor Auto
EffectShader Property _SLS_HighlightBook Auto
EffectShader Property _SLS_HighlightKey Auto
EffectShader Property _SLS_HighlightMisc Auto
EffectShader Property _SLS_HighlightPotion Auto
EffectShader Property _SLS_HighlightScroll Auto
EffectShader Property _SLS_HighlightWeapon Auto
EffectShader Property _SLS_HighlightFlora Auto
EffectShader Property _SLS_HighlightSoul Auto
EffectShader Property _SLS_HighlightIngredient Auto
