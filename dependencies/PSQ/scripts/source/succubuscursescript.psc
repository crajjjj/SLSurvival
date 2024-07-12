Scriptname SuccubusCurseScript Extends ActiveMagicEffect

PlayerSuccubusQuestScript Property PSQ Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If akTarget.HasKeywordString("ActorTypeNPC")
		CreatePenis(akTarget)
		Utility.Wait(0.2)
		If PSQ.EnableCursePaintGradient
			
			akTarget.RemoveFromFaction(PSQ.SuccubusCursedFaction)
			
			Debug.Notification("$PSQ_GetFirstColor")
			PSQ.OpenRaceMenu(akTarget)
			Utility.Wait(0.2)
			While UI.IsMenuOpen("UICosmeticMenu")
			EndWhile
			PSQ.GetAccursedBodyPaintData(akTarget, True)
			
			Debug.Notification("$PSQ_GetSecondColor")
			PSQ.OpenRaceMenu(akTarget)
			Utility.Wait(0.2)
			While UI.IsMenuOpen("UICosmeticMenu")
			EndWhile
			PSQ.GetAccursedBodyPaintData(akTarget, False)
			
			akTarget.AddToFaction(PSQ.SuccubusCursedFaction)
		Else
			PSQ.OpenRaceMenu(akTarget)
		EndIf
	EndIf
	StorageUtil.SetIntValue(akTarget, "PSQ_Accursed", 1)
	PSQ.SlaUtil.UpdateActorExposureRate(akTarget, PSQ.SuccubusRank.GetValue())
	PSQ.SlaUtil.UpdateActorTimeRate(akTarget, PSQ.SuccubusRank.GetValue()*5)
	PSQ.SlaUtil.UpdateActorExposure(akTarget, 100)
EndEvent

Function CreatePenis(Actor akTarget)
	If akTarget.GetLeveledActorBase().GetSex() == 1
		If StorageUtil.GetIntValue(akTarget, "PSQ_HasPenis") != 1
			If Game.GetFormFromFile(0xE00, "UIExtensions.esp") != None
				UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
				
				String[] sOptions =  New String[7]
				sOptions[0] = "Create Penis"	+ ";;" + -1 + ";;" +  1 + ";;" + 0 + ";;1"
				sOptions[1] = "Not"				+ ";;" + -1 + ";;" +  2 + ";;" + 1 + ";;0"
				sOptions[2] = "Type A"			+ ";;" +  1 + ";;" +  3 + ";;" + 0 + ";;0"
				sOptions[3] = "Type B"			+ ";;" +  1 + ";;" +  4 + ";;" + 1 + ";;0"
				sOptions[4] = "Type C"			+ ";;" +  1 + ";;" +  5 + ";;" + 2 + ";;0"
				sOptions[5] = "Type D"			+ ";;" +  1 + ";;" +  6 + ";;" + 3 + ";;0"
				sOptions[6] = "Type E"			+ ";;" +  1 + ";;" +  7 + ";;" + 4 + ";;0"
				
				ListMenu.SetPropertyStringA("appendEntries", sOptions)
				ListMenu.OpenMenu()
				
				Int sButton = Listmenu.GetResultInt()
				If sButton == 3
					akTarget.AddItem(PSQ.FemaleSchlongA, 1, True)
					akTarget.EquipItem(PSQ.FemaleSchlongA, True, True)
					PenisProcess(akTarget)
				ElseIf sButton == 4
					akTarget.AddItem(PSQ.FemaleSchlongB, 1, True)
					akTarget.EquipItem(PSQ.FemaleSchlongB, True, True)
					PenisProcess(akTarget)
				ElseIf sButton == 5
					akTarget.AddItem(PSQ.FemaleSchlongD, 1, True)
					akTarget.EquipItem(PSQ.FemaleSchlongD, True, True)
					PenisProcess(akTarget)
				ElseIf sButton == 6
					akTarget.AddItem(PSQ.FemaleSchlongD, 1, True)
					akTarget.EquipItem(PSQ.FemaleSchlongD, True, True)
					PenisProcess(akTarget)
				ElseIf sButton == 7
					akTarget.AddItem(PSQ.FemaleSchlongE, 1, True)
					akTarget.EquipItem(PSQ.FemaleSchlongE, True, True)
					PenisProcess(akTarget)
				EndIf
			EndIf
		EndIf
	EndIf
EndFunction

Function PenisProcess(Actor akTarget)
	StorageUtil.SetIntValue(akTarget, "PSQ_HasPenis", 1)
	If PSQ.EnableFutanariPower
		akTarget.AddSpell(PSQ.PowerOfFutanari, False)
	EndIf
	If PSQ.AutoGenderSwitch
		PSQ.SexLab.TreatAsMale(akTarget)
	EndIf
EndFunction
