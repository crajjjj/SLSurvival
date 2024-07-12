Scriptname PSC_QuestScript extends Quest  

PaySexCrimeMCM Property PSC_MCM Auto

GlobalVariable Property PrivacyStatus Auto

Location Property WindhelmLocation  Auto 
Location Property FalkreathLocation  Auto  
Location Property SolitudeLocation  Auto  
Location Property MorthalLocation  Auto   
Location Property DawnstarLocation  Auto    
Location Property MarkarthLocation  Auto  
Location Property RiftenLocation  Auto  
Location Property WhiterunLocation  Auto    
Location Property WinterholdLocation  Auto

Bool property DragonbornOn Auto
Bool property PrisonOverhaulOn Auto



	Event OnInit()
		PluginCheck()
	EndEvent


	Function PluginCheck()
		DragonbornOn = (Game.GetFormFromFile(0x000143B9, "Dragonborn.esm") as Location) as Bool	;check for Dragonborn, (RavenRock location).
		PrisonOverhaulOn = (Game.GetFormFromFile(0x00022355, "xazPrisonOverhaul.esp") as GlobalVariable) as Bool	;check for prison overhaul, (ReleaseTime global).
	EndFunction





	Int Function ShouldPardonEnd()
	
		int Status = 0

		;wait if player is in dialogue.
		if (UI.IsMenuOpen("Dialogue Menu"))
			Status -= 1
		endif

		;wait if player is leading guard to sex.
		If (PrivacyStatus.GetValue() > 0)
			Status -= 2
		EndIf



		;wait if player is in prison overhauls custody.
		If (PrisonOverhaulOn)
			GlobalVariable ReleaseTimeGlobal = Game.GetFormFromFile(0x00022355, "xazPrisonOverhaul.esp") as GlobalVariable
			float ReleaseTime = ReleaseTimeGlobal.GetValue()
			;is prison overhaul installed.
			if (ReleaseTime != 0.0)
				Status -= 8
			endif
		EndIf

		Return Status
	EndFunction



	Function PardonEndCheck(Int Tracker, Int CrimeFac)
		;wait if no new event but should wait.
		
		Int EndStatus = ShouldPardonEnd()
		while ((Tracker == PSC_MCM.SuccessTracker[CrimeFac]) && (EndStatus != 0))
			if (EndStatus == -8)
				;player is in prison overhauls custody.
				;could take time wait longer.
				Utility.WaitGameTime(1)
			else
				Utility.Wait(1)
			endif
			EndStatus = ShouldPardonEnd()
		endWhile
	EndFunction



	;for guard approach quest
	Int Function ShouldLookingStop(Location Holder)
		Int Status = 0

		If (PSC_MCM.PSC_UseApproachLocations)
			If (IsApprovedLocation(Holder))
				If !(Game.GetPlayer().IsInLocation(Holder))
					Status += 1
				EndIf
			Else
				Status += 1
			EndIf
		EndIf

		;player is leading guard to sex.
		If (PrivacyStatus.GetValue() > 0)
			Status += 2
		EndIf

		If (PrisonOverhaulOn)
			;player is in prison overhauls custody.
			GlobalVariable ReleaseTimeGlobal = Game.GetFormFromFile(0x00022355, "xazPrisonOverhaul.esp") as GlobalVariable
			float ReleaseTime = ReleaseTimeGlobal.GetValue()
			;is prison overhaul installed.
			if (ReleaseTime != 0.0)
				Status += 16
			endif
		EndIf

		Return Status
	EndFunction



	;for guard approach quest
	Int Function ShouldApproachStop(Location Holder, Actor ApproachingGuard)
		Int Status = 0

		If (PSC_MCM.PSC_UseApproachLocations)
			If (IsApprovedLocation(Holder))
				If !(Game.GetPlayer().IsInLocation(Holder))
					Status += 1
				EndIf
			Else
				Status += 1
			EndIf
		EndIf


		;player is leading guard to sex.
		If (PrivacyStatus.GetValue() > 0)
			Status += 2
		EndIf

		;player has bounty.
		If (ApproachingGuard.GetCrimeFaction().GetCrimeGold() > 0)
			Status += 4
		EndIf

		;player to far from guard.
		If (ApproachingGuard.GetDistance(Game.GetPlayer()) > 3000)
			Status += 8
		EndIf

		If (PrisonOverhaulOn)
			;player is in prison overhauls custody.
			GlobalVariable ReleaseTimeGlobal = Game.GetFormFromFile(0x00022355, "xazPrisonOverhaul.esp") as GlobalVariable
			float ReleaseTime = ReleaseTimeGlobal.GetValue()
			;is prison overhaul installed.
			if (ReleaseTime != 0.0)
				Status += 16
			endif
		EndIf

		Return Status
	EndFunction



	Int Function ShouldApproachSuspend()
		Int Status = 0

		;if player is in dialogue.
		if (UI.IsMenuOpen("Dialogue Menu"))
			Status += 1
		EndIf

		;if player if having sex
		If (Game.GetPlayer().HasKeyWordString("SexLabActive")) 
			Status += 2
		EndIf

		Return Status
	EndFunction



	;for guard approach quest
	Int Function IsApprovedLocation(Location HolderLoc)
		Int Status = 0
		If (HolderLoc)
			If ( (HolderLoc == WindhelmLocation) || (HolderLoc == FalkreathLocation) || (HolderLoc == SolitudeLocation) || (HolderLoc == MorthalLocation) || (HolderLoc == DawnstarLocation) || (HolderLoc == MarkarthLocation) || (HolderLoc == RiftenLocation) || (HolderLoc == WhiterunLocation) || (HolderLoc == WinterholdLocation) )
				Status += 1
			EndIf
			If (DragonbornOn)
				Location RavenRockLocation = (Game.GetFormFromFile(0x000143B9, "Dragonborn.esm") as Location)
				If (RavenRockLocation)
					If (HolderLoc == RavenRockLocation)
						Status += 2
					EndIf
				EndIf
			EndIf
		EndIf

		Return Status
	EndFunction