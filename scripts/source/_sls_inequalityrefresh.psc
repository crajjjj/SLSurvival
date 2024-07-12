Scriptname _SLS_InequalityRefresh extends ReferenceAlias  

Event OnInit()
	Actor akTarget = Self.GetReference() as Actor
	If akTarget
		akTarget.RemoveSpell(_SLS_InequalitySpell)
		Utility.Wait(1.0)
		akTarget.AddSpell(_SLS_InequalitySpell, false)
	EndIf
EndEvent

Spell Property _SLS_InequalitySpell Auto