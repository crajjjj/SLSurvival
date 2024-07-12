Scriptname SuccubusFortifyMSGBoxScript Extends ActivemagicEffect

PlayerSuccubusQuestScript Property PSQ Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If akCaster == PSQ.PlayerRef
		PSQ.Satiety()
		MainMenu()
	EndIf
EndEvent

Function MainMenu()
	If Game.GetFormFromFile(0xE00, "UIExtensions.esp") != None
		UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
		
		String[] sOptions =  New String[5]
		sOptions[0] = "Fortify Health"	+ ";;" + -1 + ";;" +  1 + ";;" + 0 + ";;0"
		sOptions[1] = "Fortify Magicka"	+ ";;" + -1 + ";;" +  2 + ";;" + 1 + ";;0"
		sOptions[2] = "Fortify Stamina"	+ ";;" + -1 + ";;" +  3 + ";;" + 2 + ";;0"
		sOptions[3] = "Get Perk Point"	+ ";;" + -1 + ";;" +  4 + ";;" + 3 + ";;0"
		sOptions[4] = "Cancel"			+ ";;" + -1 + ";;" +  5 + ";;" + 4 + ";;0"
		
		ListMenu.SetPropertyStringA("appendEntries", sOptions)
		ListMenu.OpenMenu()
		
		Int sButton = Listmenu.GetResultInt()
		If sButton == 1
			If EnergyCheck(1000)
				PSQ.PlayerRef.SetActorValue("Health", PSQ.PlayerRef.GetBaseActorValue("Health") + 10)
				EnergySubtract(1000)
			EndIf
		ElseIf sButton == 2
			If EnergyCheck(1000)
				PSQ.PlayerRef.SetActorValue("Magicka", PSQ.PlayerRef.GetBaseActorValue("Magicka") + 10)
				EnergySubtract(1000)
			EndIf
		ElseIf sButton == 3
			If EnergyCheck(1000)
				PSQ.PlayerRef.SetActorValue("Stamina", PSQ.PlayerRef.GetBaseActorValue("Stamina") + 10)
				EnergySubtract(1000)
			EndIf
		ElseIf sButton == 4
			If EnergyCheck(3000)
				Game.AddPerkPoints(1)
				EnergySubtract(3000)
			EndIf
		EndIf
	EndIf
EndFunction

Bool Function EnergyCheck(Float Value)
	If PSQ.SuccubusEnergy.GetValue() >= Value
		Return True
	EndIf
	Debug.Notification("$PSQ_EnergyShortNotice")
	Return False
EndFunction

Function EnergySubtract(Float Value)
	PSQ.Satiety(-Value)
	PSQ.SatietyNotification(-Value)
EndFunction
