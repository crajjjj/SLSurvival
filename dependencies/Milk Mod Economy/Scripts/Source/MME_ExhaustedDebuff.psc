Scriptname MME_ExhaustedDebuff extends activemagiceffect Hidden

int i = 0
float SleepStartTime

; ----------------------------------------------------------------------------------
Event OnEffectStart( Actor akTarget, Actor akCaster )
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	If MilkQ.PlayerREF == akTarget && MilkQ.MilkMsgs
		Debug.Notification(JsonUtil.GetStringValue("/MME/Strings", "drained"))
	endif
	i = MilkQ.MILKmaid.find(akTarget)
	if i != -1
		if !MilkQ.MilkQC.Buffs
			if akTarget.HasSpell(MilkQ.MME_Spells_Buffs.GetAt(3) as Spell)
				akTarget.RemoveSpell( MilkQ.MME_Spells_Buffs.GetAt(3) as Spell )
			endif
			if akTarget.HasSpell(MilkQ.MME_Spells_Buffs.GetAt(4) as Spell)
				akTarget.RemoveSpell( MilkQ.MME_Spells_Buffs.GetAt(4) as Spell )
			endif
		else
			RegisterForSleep()
		endif
	else
		if akTarget.HasSpell(MilkQ.MME_Spells_Buffs.GetAt(3) as Spell)
			akTarget.RemoveSpell( MilkQ.MME_Spells_Buffs.GetAt(3) as Spell )
		endif
		if akTarget.HasSpell(MilkQ.MME_Spells_Buffs.GetAt(4) as Spell)
			akTarget.RemoveSpell( MilkQ.MME_Spells_Buffs.GetAt(4) as Spell )
		endif
	endif
EndEvent

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	SleepStartTime = afSleepStartTime
EndEvent

Event OnSleepStop ( bool abInterrupted )
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	int scriptupdatetimes = ((Math.Floor(Utility.GetCurrentGameTime()*24)) - (Math.Floor(SleepStartTime*24)))
	if scriptupdatetimes >= 6 - MilkQ.ExhaustionSleepMod && !abInterrupted
		if MilkQ.MILKmaid[i].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(3) as Spell)
			MilkQ.MILKmaid[i].RemoveSpell( MilkQ.MME_Spells_Buffs.GetAt(3) as Spell )
		endif
		if MilkQ.MILKmaid[i].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(4) as Spell)
			MilkQ.MILKmaid[i].RemoveSpell( MilkQ.MME_Spells_Buffs.GetAt(4) as Spell )
		endif
		If MilkQ.PlayerREF == MilkQ.MILKmaid[i] && MilkQ.MilkMsgs
			Debug.Notification(JsonUtil.GetStringValue("/MME/Strings", "rested"))
		endif
	endif
EndEvent