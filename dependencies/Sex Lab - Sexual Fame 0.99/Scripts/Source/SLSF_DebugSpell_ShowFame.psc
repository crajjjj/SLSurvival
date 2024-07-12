Scriptname SLSF_DebugSpell_ShowFame extends activemagiceffect  
SLSF_Configuration Property Config Auto
SLSF_Utility Property SLSFUtility Auto
SLSF_FameMaintenance Property FameMain Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	UIListMenu ListOfLocations = UIExtensions.GetMenu("UIListMenu", True) as UIListMenu
	Int a = 0
	String Name
	While a < Config.FameLocationsList.Length
		If Config.TemporaryLocation[a]
			Name = Config.FameLocationsListString[a] + "[Temp]"
		Else
			Name = Config.FameLocationsListString[a]
		EndIf
		ListOfLocations.AddEntryItem(Name)
		a += 1
	EndWhile
	
	ListOfLocations.OpenMenu()
	
	Int LocNum = ListOfLocations.GetResultInt()

	If LocNum < 0
		Return
	EndIf
	
	If Config.FameLocationsList[LocNum] == None
		Debug.Notification("SLSF Debug, ShowFame Location Empty, Can't edit.")
		Return
	EndIf
	
	UIListMenu LevelOrLimitMod = UIExtensions.GetMenu("UIListMenu", True) as UIListMenu
	LevelOrLimitMod.AddEntryItem("Modify Level of Fame")
	LevelOrLimitMod.AddEntryItem("Modify LimitMin of Fame")
	LevelOrLimitMod.AddEntryItem("Modify LimitMax of Fame")
	
	LevelOrLimitMod.OpenMenu()
	
	Int TypeOfMenu = LevelOrLimitMod.GetResultInt()
	If TypeOfMenu == 0
		OpenFameMenu(LocNum, "")
	ElseIf TypeOfMenu == 1
		OpenFameMenu(LocNum, ".LevelMin")
	ElseIf TypeOfMenu == 2
		OpenFameMenu(LocNum, ".LevelMax")
	EndIf
EndEvent

Function OpenFameMenu(Int LocNum, String Suffix)
	Bool Close
	While !Close
		Debug.Notification("SLSF Debug, ShowFame Location: "+Config.FameLocationsList[LocNum].GetName()+".")
		UIListMenu ListOfFame = UIExtensions.GetMenu("UIListMenu", True) as UIListMenu
	
		Int a = 0
		String FameType
		While a < Config.FameListNpc.Length
			FameType = Config.FameListNpc[a]
			ListOfFame.AddEntryItem(FameType+Suffix+": "+StorageUtil.IntListGet(None, "SLSF.LocationsFame."+FameType+Suffix, LocNum))
			a += 1
		EndWhile
		
		a = 0
		While a < Config.FameListPc.Length
			FameType = Config.FameListPc[a]
			ListOfFame.AddEntryItem(FameType+Suffix+": "+StorageUtil.IntListGet(None, "SLSF.LocationsFame."+FameType+Suffix, LocNum))
			a += 1
		EndWhile
	
		ListOfFame.OpenMenu()
		
		Int Selected = ListOfFame.GetResultInt()
		
		Int b = Config.FameListNpc.Length
		Int c = Config.FameListPc.Length
		Int Group
		If Selected >= 0
			If Selected >= 0 && Selected < b
				Group = 0
			ElseIf Selected >= b
				Group = 1
			EndIf
			
			String Result
			Int Actual
			If Group == 0
				Actual = StorageUtil.IntListGet(None, "SLSF.LocationsFame."+Config.FameListNpc[Selected]+Suffix, LocNum)
			ElseIf Group == 1
				Actual = StorageUtil.IntListGet(None, "SLSF.LocationsFame."+Config.FameListPc[Selected - b]+Suffix, LocNum)
			EndIf
			
			UITextEntryMenu TextEntry = UIExtensions.GetMenu("UITextEntryMenu", True) as UITextEntryMenu
			TextEntry.SetPropertyString("text", Actual as String)
			TextEntry.OpenMenu()
			Result = TextEntry.GetResultString()
			
			If Result != ""
				Actual = SLSFUtility.FixRangeValue(Result as Int)
			EndIf
			
			Debug.Notification("Imput Value got: "+Actual)
			If Group == 0
				StorageUtil.IntListSet(None, "SLSF.LocationsFame."+Config.FameListNpc[Selected]+Suffix, LocNum, Actual)
			ElseIf Group == 1
				StorageUtil.IntListSet(None, "SLSF.LocationsFame."+Config.FameListPc[Selected - b]+Suffix, LocNum, Actual)
			EndIf
		Else
			Close = True
		EndIf
	EndWhile
EndFunction
