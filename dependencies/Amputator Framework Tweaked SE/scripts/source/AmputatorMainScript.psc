Scriptname AmputatorMainScript extends Quest

_AMP_Main Property Main Auto

Function ApplyAmputator(Actor akActor, int morphType ,int bothleftright)
	Main.ApplyAmputator(akActor, morphType, bothleftright, SendEvent = true, akSource = None)
EndFunction

Function RemoveAllAmpSpells(Actor akActor) ; For backward compatibility only realy
	If akActor
		akActor.RemoveSpell(AMP_AmputeeStatusEffectSpell)
       		
		akActor.RemoveSpell(AmputeeAbilitiesRight[0])
		akActor.RemoveSpell(AmputeeAbilitiesRight[1])
		akActor.RemoveSpell(AmputeeAbilitiesRight[2])
		akActor.RemoveSpell(AmputeeAbilitiesRight[3])
		akActor.RemoveSpell(AmputeeAbilitiesRight[4])
		akActor.RemoveSpell(AmputeeAbilitiesRight[5])

		akActor.RemoveSpell(AmputeeAbilitiesLeft[0])
		akActor.RemoveSpell(AmputeeAbilitiesLeft[1])
		akActor.RemoveSpell(AmputeeAbilitiesLeft[2])
		akActor.RemoveSpell(AmputeeAbilitiesLeft[3])
		akActor.RemoveSpell(AmputeeAbilitiesLeft[4])
		akActor.RemoveSpell(AmputeeAbilitiesLeft[5])
	EndIf
EndFunction

Function RemoveObseleteSpell(Actor akActor) ; For backward compatibility only realy
	If(akActor.HasSpell(AmputeeAbilitiesLeft[1]))
		akActor.RemoveSpell(AmputeeAbilitiesLeft[0])
	EndIf
	If(akActor.HasSpell(AmputeeAbilitiesLeft[2]))
		akActor.RemoveSpell(AmputeeAbilitiesLeft[1])
	EndIf
	If(akActor.HasSpell(AmputeeAbilitiesLeft[4]))
		akActor.RemoveSpell(AmputeeAbilitiesLeft[3])
	EndIf
	If(akActor.HasSpell(AmputeeAbilitiesLeft[5]))
		akActor.RemoveSpell(AmputeeAbilitiesLeft[4])
	EndIf


	If(akActor.HasSpell(AmputeeAbilitiesRight[1]))
		akActor.RemoveSpell(AmputeeAbilitiesRight[0])
	EndIf
	If(akActor.HasSpell(AmputeeAbilitiesRight[2]))
		akActor.RemoveSpell(AmputeeAbilitiesRight[1])
	EndIf
	If(akActor.HasSpell(AmputeeAbilitiesRight[4]))
		akActor.RemoveSpell(AmputeeAbilitiesRight[3])
	Endif
	If(akActor.HasSpell(AmputeeAbilitiesRight[5]))
		akActor.RemoveSpell(AmputeeAbilitiesRight[4])
	EndIf
EndFunction

Spell[] Property AmputeeAbilitiesLeft Auto
Spell[] Property AmputeeAbilitiesRight Auto

Spell Property AMP_AmputeeStatusEffectSpell Auto
