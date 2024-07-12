Scriptname SuccubusSpellLearningMSGBoxScript Extends ActivemagicEffect

PlayerSuccubusQuestScript Property PSQ Auto

Sound Property UISpellLearned Auto

String Property StringSuccubusRank Auto
String Property StringIsRequired Auto
String Property StringLevel Auto
String Property StringEnergy Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If akCaster == PSQ.PlayerRef
		PSQ.Satiety()
		MainMenu()
	EndIf
EndEvent

Function MainMenu()
	If Game.GetFormFromFile(0xE00, "UIExtensions.esp") != None
		UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
		
		String[] sOptions =  New String[45]
		sOptions[0]  = "Destruction"			+ ";;" + -1 + ";;" +  1 + ";;" + 0 + ";;1"
		sOptions[1]  = "Illusion"				+ ";;" + -1 + ";;" +  2 + ";;" + 0 + ";;1"
		sOptions[2]  = "Alteration"				+ ";;" + -1 + ";;" +  3 + ";;" + 0 + ";;1"
		sOptions[3]  = "Healing"				+ ";;" + -1 + ";;" +  4 + ";;" + 0 + ";;1"
		
		sOptions[4]  = "Apprentice"				+ ";;" +  1 + ";;" + 10 + ";;" + 0 + ";;1"
		sOptions[5]  = "Succu Firebolt"			+ ";;" + 10 + ";;" + 11 + ";;" + 0 + ";;0"
		sOptions[6]  = "Succu IceSpike"			+ ";;" + 10 + ";;" + 12 + ";;" + 1 + ";;0"
		sOptions[7]  = "Succu Lightningbolt"	+ ";;" + 10 + ";;" + 13 + ";;" + 2 + ";;0"
		
		sOptions[8]  = "Adept"					+ ";;" +  1 + ";;" + 20 + ";;" + 0 + ";;1"
		sOptions[9]  = "Succu Fireball"			+ ";;" + 20 + ";;" + 21 + ";;" + 0 + ";;0"
		sOptions[10] = "Succu Ice Storm"		+ ";;" + 20 + ";;" + 22 + ";;" + 1 + ";;0"
		sOptions[11] = "Succu Chain Lightning"	+ ";;" + 20 + ";;" + 23 + ";;" + 2 + ";;0"
		
		sOptions[12] = "Expert"					+ ";;" +  1 + ";;" + 30 + ";;" + 0 + ";;1"
		sOptions[13] = "Succu Incinerate"		+ ";;" + 30 + ";;" + 31 + ";;" + 0 + ";;0"
		sOptions[14] = "Succu Icy Spear"		+ ";;" + 30 + ";;" + 32 + ";;" + 1 + ";;0"
		sOptions[15] = "Succu Thunderbolt"		+ ";;" + 30 + ";;" + 33 + ";;" + 2 + ";;0"
		
		sOptions[16] = "Master"					+ ";;" +  1 + ";;" + 40 + ";;" + 0 + ";;1"
		sOptions[17] = "Succu FireStorm"		+ ";;" + 40 + ";;" + 41 + ";;" + 0 + ";;0"
		sOptions[18] = "Succu Blizzard"			+ ";;" + 40 + ";;" + 42 + ";;" + 1 + ";;0"
		
		sOptions[19] = "Target"					+ ";;" +  2 + ";;" + 50 + ";;" + 0 + ";;1"
		sOptions[20] = "Succu Courage"			+ ";;" + 50 + ";;" + 51 + ";;" + 0 + ";;0"
		sOptions[21] = "Succu Calm"				+ ";;" + 50 + ";;" + 52 + ";;" + 1 + ";;0"
		sOptions[22] = "Succu Fear"				+ ";;" + 50 + ";;" + 53 + ";;" + 2 + ";;0"
		sOptions[23] = "Succu Fury"				+ ";;" + 50 + ";;" + 54 + ";;" + 3 + ";;0"
		
		sOptions[24] = "Area"					+ ";;" +  2 + ";;" + 60 + ";;" + 0 + ";;1"
		sOptions[25] = "Succu Rally"			+ ";;" + 60 + ";;" + 61 + ";;" + 0 + ";;0"
		sOptions[26] = "Succu Pacify"			+ ";;" + 60 + ";;" + 62 + ";;" + 1 + ";;0"
		sOptions[27] = "Succu Rout"				+ ";;" + 60 + ";;" + 63 + ";;" + 2 + ";;0"
		sOptions[28] = "Succu Frenzy"			+ ";;" + 60 + ";;" + 64 + ";;" + 3 + ";;0"
		
		sOptions[29] = "Mass"					+ ";;" +  2 + ";;" + 70 + ";;" + 0 + ";;1"
		sOptions[30] = "Succu Call to Arms"		+ ";;" + 70 + ";;" + 71 + ";;" + 0 + ";;0"
		sOptions[31] = "Succu Harmony"			+ ";;" + 70 + ";;" + 72 + ";;" + 1 + ";;0"
		sOptions[32] = "Succu Hysteria"			+ ";;" + 70 + ";;" + 73 + ";;" + 2 + ";;0"
		sOptions[33] = "Succu Mayhem"			+ ";;" + 70 + ";;" + 74 + ";;" + 3 + ";;0"
		
		sOptions[34] = "Succu Oakflesh"			+ ";;" +  3 + ";;" + 81 + ";;" + 0 + ";;0"
		sOptions[35] = "Succu Stoneflesh"		+ ";;" +  3 + ";;" + 82 + ";;" + 1 + ";;0"
		sOptions[36] = "Succu Ironflesh"		+ ";;" +  3 + ";;" + 83 + ";;" + 2 + ";;0"
		sOptions[37] = "Succu Ebonyflesh"		+ ";;" +  3 + ";;" + 84 + ";;" + 3 + ";;0"
		sOptions[38] = "Succu Dragonhide"		+ ";;" +  3 + ";;" + 85 + ";;" + 4 + ";;0"
		sOptions[39] = "Succu Paralyze"			+ ";;" +  3 + ";;" + 86 + ";;" + 5 + ";;0"
		
		sOptions[40] = "Succu Fast Healing"		+ ";;" +  4 + ";;" + 91 + ";;" + 0 + ";;0"
		sOptions[41] = "Succu Close Wounds"		+ ";;" +  4 + ";;" + 92 + ";;" + 1 + ";;0"
		sOptions[42] = "Succu Heal Other"		+ ";;" +  4 + ";;" + 93 + ";;" + 2 + ";;0"
		sOptions[43] = "Succu Grand Healing"	+ ";;" +  4 + ";;" + 94 + ";;" + 3 + ";;0"
		
		sOptions[44] = "Cancel"					+ ";;" + -1 + ";;" +  5 + ";;" + 0 + ";;0"
		
		ListMenu.SetPropertyStringA("appendEntries", sOptions)
		ListMenu.OpenMenu()
		
		Int sButton = Listmenu.GetResultInt()
		If sButton == 11
			LearnIfAble(PSQ.SuccuFirebolt, 2, 1000, 15, "Destruction")
		ElseIf sButton == 12
			LearnIfAble(PSQ.SuccuIceSpike, 2, 1000, 15, "Destruction")
		ElseIf sButton == 13
			LearnIfAble(PSQ.SuccuLightningBolt, 2, 1000, 15, "Destruction")
		ElseIf sButton == 21
			LearnIfAble(PSQ.SuccuFireball, 4, 2000, 40, "Destruction")
		ElseIf sButton == 22
			LearnIfAble(PSQ.SuccuIceStorm, 4, 2000, 40, "Destruction")
		ElseIf sButton == 23
			LearnIfAble(PSQ.SuccuChainLightning, 4, 2000, 40, "Destruction")
		ElseIf sButton == 31
			LearnIfAble(PSQ.SuccuIncinerate, 5, 3000, 65, "Destruction")
		ElseIf sButton == 32
			LearnIfAble(PSQ.SuccuIcySpear, 5, 3000, 65, "Destruction")
		ElseIf sButton == 33
			LearnIfAble(PSQ.SuccuThunderbolt, 5, 3000, 65, "Destruction")
		ElseIf sButton == 41
			LearnIfAble(PSQ.SuccuFireStorm, 6, 5000, 90, "Destruction")
		ElseIf sButton == 42
			LearnIfAble(PSQ.SuccuBlizzard, 6, 5000, 90, "Destruction")
		ElseIf sButton == 51
			LearnIfAble(PSQ.SuccuCourage, 1, 500, 0, "Illusion")
		ElseIf sButton == 52
			LearnIfAble(PSQ.SuccuCalm, 2, 1000, 15, "Illusion")
		ElseIf sButton == 53
			LearnIfAble(PSQ.SuccuFear, 2, 1000, 15, "Illusion")
		ElseIf sButton == 54
			LearnIfAble(PSQ.SuccuFury, 1, 500, 0, "Illusion")
		ElseIf sButton == 61
			LearnIfAble(PSQ.SuccuRally, 3, 1500, 30, "Illusion")
		ElseIf sButton == 62
			LearnIfAble(PSQ.SuccuPacify, 4, 2000, 45, "Illusion")
		ElseIf sButton == 63
			LearnIfAble(PSQ.SuccuRout, 4, 2000, 30, "Illusion")
		ElseIf sButton == 64
			LearnIfAble(PSQ.SuccuFrenzy, 3, 1500, 45, "Illusion")
		ElseIf sButton == 71
			LearnIfAble(PSQ.SuccuCallToArms, 6, 5000, 90, "Illusion")
		ElseIf sButton == 72
			LearnIfAble(PSQ.SuccuHarmony, 6, 5000, 90, "Illusion")
		ElseIf sButton == 73
			LearnIfAble(PSQ.SuccuHysteria, 6, 5000, 90, "Illusion")
		ElseIf sButton == 74
			LearnIfAble(PSQ.SuccuMayhem, 6, 5000, 90, "Illusion")
		ElseIf sButton == 81
			LearnIfAble(PSQ.SuccuOakflesh,1 ,500, 0, "Alteration")
		ElseIf sButton == 82
			LearnIfAble(PSQ.SuccuStoneflesh, 3, 1500, 30, "Alteration")
		ElseIf sButton == 83
			LearnIfAble(PSQ.SuccuIronflesh, 4, 2000, 45, "Alteration")
		ElseIf sButton == 84
			LearnIfAble(PSQ.SuccuEbonyflesh, 5, 3000, 65, "Alteration")
		ElseIf sButton == 85
			LearnIfAble(PSQ.SuccuDragonhide, 6, 5000, 90, "Alteration")
		ElseIf sButton == 86
			LearnIfAble(PSQ.SuccuParalyze, 5, 3000, 65, "Alteration")
		ElseIf sButton == 91
			LearnIfAble(PSQ.SuccuFastHealing, 2, 1000, 15, "Restoration")
		ElseIf sButton == 92
			LearnIfAble(PSQ.SuccuCloseWounds, 4, 2000, 40, "Restoration")
		ElseIf sButton == 93
			LearnIfAble(PSQ.SuccuHealOther,4 ,2000, 40, "Restoration")
		ElseIf sButton == 94
			LearnIfAble(PSQ.SuccuGrandHealing, 5, 3000, 65, "Restoration")
		EndIf
	EndIf
EndFunction

Function LearnIfAble(Spell LearningSpell,Int RequiredRank, Float RequiredEnergy, Float RequiredSkillLevel, String MagicSchool)
	If !PSQ.PlayerRef.HasSpell(LearningSpell)
		If PSQ.EnergyModeAlt
			RequiredEnergy = PSQ.MaxEnergy * (RequiredRank / 6) - 1
		EndIf
		If PSQ.SuccubusRank.GetValueInt() >= RequiredRank
			If PSQ.PlayerRef.GetBaseAV(MagicSchool) >= RequiredSkillLevel
				If PSQ.SuccubusEnergy.GetValue() >= RequiredEnergy
					PSQ.PlayerRef.AddSpell(LearningSpell)
					Int LearnSound = UISpellLearned.Play(PSQ.PlayerRef)
					PSQ.Satiety(-RequiredEnergy)
					PSQ.SatietyNotification(-RequiredEnergy, True)
				Else
					Debug.Notification(StringEnergy + RequiredEnergy as Int + StringIsRequired)
				EndIf
			Else
				Debug.Notification(MagicSchool + StringLevel + RequiredSkillLevel as Int + StringIsRequired)
			EndIf
		Else
			Debug.Notification(StringSuccubusRank + RequiredRank + StringIsRequired)
		EndIf
	Else
		Debug.Notification("$PSQ_YouHaveThatSpell")
	EndIf
EndFunction
