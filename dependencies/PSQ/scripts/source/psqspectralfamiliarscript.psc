Scriptname PSQSpectralFamiliarScript Extends Actor

EffectShader Property GhostFXShader Auto

Event OnLoad()
	If !StorageUtil.GetIntValue(Self, "PSQ_AstralEffectNone") == 1
		GhostFXShader.Play(Self)
		Self.SetAlpha (0.3)
	EndIf
EndEvent
