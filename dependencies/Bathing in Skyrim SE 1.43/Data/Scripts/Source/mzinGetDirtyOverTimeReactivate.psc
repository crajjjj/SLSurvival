ScriptName mzinGetDirtyOverTimeReactivate Extends ActiveMagicEffect

FormList Property DirtyActors Auto

FormList Property GetDirtyOverTimeSpellList Auto
FormList Property DirtinessSpellList Auto

Event OnEffectStart(Actor Target, Actor Caster)
	If DirtyActors.HasForm(Target)
		If Target.HasSpell(GetDirtyOverTimeSpellList.GetAt(0) As Spell) == False \
		&& Target.HasSpell(GetDirtyOverTimeSpellList.GetAt(1) As Spell) == False \
		&& Target.HasSpell(GetDirtyOverTimeSpellList.GetAt(2) As Spell) == False \
		&& Target.HasSpell(GetDirtyOverTimeSpellList.GetAt(3) As Spell) == False 
			Int Index = DirtinessSpellList.GetSize()
			While Index
				Index -= 1
				Spell DirtinessSpell = DirtinessSpellList.GetAt(Index) As Spell
				If Target.HasSpell(DirtinessSpell)
					Target.RemoveSpell(DirtinessSpell)
					Utility.Wait(0.1)
					Target.AddSpell(GetDirtyOverTimeSpellList.GetAt(Index) As Spell, False)
					Return
				EndIf
			EndWhile
		EndIf
	EndIf
EndEvent
