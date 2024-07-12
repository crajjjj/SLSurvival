Scriptname SuccubusMasturbationSpellScript Extends ActiveMagicEffect

SexLabFramework Property SexLab Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If !SexLab.PlayerRef.HasKeywordString("SexLabActive")
		Actor[] SexActors = new Actor[1]
		SexActors[0] = SexLab.PlayerRef
		sslBaseAnimation[] anims
		SexLab.StartSex(SexActors, anims)
	EndIf
EndEvent
