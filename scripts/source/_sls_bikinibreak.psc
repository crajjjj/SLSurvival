Scriptname _SLS_BikiniBreak extends Quest  

Event OnInit()
	If Self.IsRunning() && _SLS_BikBreakEnable.GetValueInt() == 1
		StorageUtil.SetIntValue(Self, "ArmorBreakdownHelp", 1)
		SetupCustomBikiniBreaks()
	EndIf
EndEvent

Function LoadGameMaintenance()
	
EndFunction

Function DoOncePerGameSessionLoad()
	CustomCobjMaintenance()
EndFunction

Function CustomCobjMaintenance()
	Int i = 0
	While i < _SLS_BikBreakCustomMiscObjsList.GetSize()
		String JsonFile = StorageUtil.GetStringValue(_SLS_BikBreakCustomMiscObjsList.GetAt(i), "_SLS_AssignedCobjJson")
		If JsonFile
			SetCustomCobjAttributes(JsonFile, Cobj = _SLS_BikBreakCustomCobjsList.GetAt(i) as ConstructibleObject, Token = _SLS_BikBreakCustomMiscObjsList.GetAt(i) as MiscObject)
		Else ; End of assigned custom Cobjs
			;Debug.Messagebox("End proc at: " + i)
			Return
		EndIf
		i += 1
	EndWhile
EndFunction

Function BuildRecipes()
	SetupCustomBikiniBreaks()
EndFunction

Function SetupCustomBikiniBreaks()
	;Debug.Messagebox(StorageUtil.ClearStringValuePrefix("_SLS_AssignedCobjJson"))
	Int Count
	String[] JsonFiles
	JsonFiles = MiscUtil.FilesInFolder("Data/skse/Plugins/StorageUtilData/SL Survival/BikBreak/Custom/", extension = "json")
	Int j = 0
	While j < JsonFiles.Length
		If Count <= _SLS_BikBreakCustomMiscObjsList.GetSize()
			If AssignCustomCobj("/SL Survival/BikBreak/Custom/" + JsonFiles[j], Index = Count)
				Count += 1
			Else
				Debug.Trace("_SLS_: SetupCustomBikiniBreaks(): Got false from AssignCustomCobj(): Json: " + "/SL Survival/BikBreak/Custom/" + JsonFiles[j] + ". Index: " + Count)
			EndIf
		Else
			Debug.Messagebox("_SLS_: SetupCustomBikiniBreaks(): Custom breakdown count exceeded. Count: " + Count + ". Max: " + _SLS_BikBreakCustomMiscObjsList.GetSize())
		EndIf
		j += 1
	EndWhile
EndFunction

Bool Function AssignCustomCobj(String JsonFile, Int Index)
	If Game.GetModByName(JsonUtil.GetStringValue(JsonFile, "modname")) != 255
		ConstructibleObject Cobj = _SLS_BikBreakCustomCobjsList.GetAt(Index) as ConstructibleObject
		MiscObject Token = _SLS_BikBreakCustomMiscObjsList.GetAt(Index) as MiscObject
		StorageUtil.SetStringValue(Token, "_SLS_AssignedCobjJson", JsonFile)
		SetCustomCobjAttributes(JsonFile, Cobj, Token)
		Return true
	EndIf
	Return false
EndFunction

Function SetCustomCobjAttributes(String JsonFile, ConstructibleObject Cobj, MiscObject Token)
	Cobj.SetResult(Token)
	Cobj.SetNthIngredient(JsonUtil.GetFormValue(JsonFile, "sourcearmor"), 0)
	Token.SetName(JsonUtil.GetStringValue(JsonFile, "cobjname"))
	Token.SetGoldValue(JsonUtil.GetIntValue(JsonFile, "value"))
	Token.SetWeight(JsonUtil.GetFloatValue(JsonFile, "weight"))
	Token.SetWorldModelPath(JsonUtil.GetStringValue(JsonFile, "modelpath"))
EndFunction

Function BreakdownArmor(MiscObject Token)
	Int Index = _SLS_BikBreakBuiltInMiscObjsList.Find(Token)
	String JsonFile
	If Index > -1
		JsonFile = JsonUtil.StringListGet("SL Survival/BikBreak/BuiltInLookup.json", "jsons", Index)
	Else
		Index = _SLS_BikBreakCustomMiscObjsList.Find(Token)
		If Index > -1
			JsonFile = StorageUtil.GetStringValue(Token, "_SLS_AssignedCobjJson")
		EndIf
	EndIf
	
	;Debug.Messagebox("CobjToken: " + CobjToken + "\nIndex: " + Index + "\nJsonFile: " + JsonFile + "\nExists: " + MiscUtil.FileExists("data/skse/plugins/StorageUtilData/" + JsonFile))
	If Index >= 0 && JsonFile != "" && MiscUtil.FileExists("data/skse/plugins/StorageUtilData/" + JsonFile)
		ObjectReference akContainer = PlayerRef
		If CompatibilityMode
			RegisterForMenu("Crafting Menu")
			akContainer = _SLS_ArmorBreakdownBarrelRef
		EndIf
	
		Armor SourceArmor = JsonUtil.GetFormValue(JsonFile, "sourcearmor") as Armor
		Float SkillReq = JsonUtil.GetFloatValue(JsonFile, "skillreq")
		If StorageUtil.GetIntValue(Self, "ArmorBreakdownHelp") == 1
			Debug.Messagebox("Congratulations!\n\nYou've broken down your first armor piece into slutty bikini parts and are complying with the rightful laws of men in Skyrim like a little good girl. Well done!\n\nBreaking down an armor will give you a random set of bikini armor of that type.\n\nBreaking down does not require the crafting perk or the crafting book. To compensate for this there is a chance for you to fail to recover pieces of the bikini when you break down an armor based on your crafting skill. This chance is never less than 30%! Low skill may mean no pieces are recovered!")
			StorageUtil.UnSetIntValue(Self, "ArmorBreakdownHelp")
		EndIf
		
		Float Skill = PlayerRef.GetActorValue("Smithing")
		PlayerRef.RemoveItem(Token, 999, abSilent = true)
		PlayerRef.RemoveItem(SourceArmor, 1, abSilent = true)
		String[] BikParts = JsonUtil.StringListToArray(JsonFile, "parts")
		Form akArmor
		Int Waste
		Int i = 0
		While i < BikParts.Length
			akArmor = JsonUtil.FormListGet(JsonFile, BikParts[i], Utility.RandomInt(0, JsonUtil.FormListCount(JsonFile, BikParts[i]) - 1))
			If akArmor
				If BreakdownSuccessCheck(Skill, SkillReq)
					akContainer.AddItem(akArmor, 1, abSilent = true)
				Else
					Waste += 1
				EndIf
			EndIf
			i += 1
		EndWhile
		If Waste > 0
			Debug.Notification("You failed to recover " + waste + " pieces of bikini armor. Skill Needed: " + SkillReq as Int)
		EndIf
	
	Else
		Debug.Trace("_SLS_: MiscObject or JsonFile not found!")
		Debug.Trace("_SLS_: BreakdownArmor Fail: Token: " + Token + ". Index: " + Index + ". JsonFile: " + JsonFile)
		Debug.Notification("_SLS_: MiscObject of JsonFile not found!")
	EndIf
EndFunction

Bool Function BreakdownSuccessCheck(Float SkillAct, Float SkillReq)
	If SkillAct > SkillReq 
		If Utility.RandomFloat(0.0, 100.0) > 20.0 ; 20% chance of not recovering a part even at full skill
			Return true
		EndIf
	Else
		If Utility.RandomFloat(0.0, 100.0) > 20.0 + ((SkillReq - SkillAct) * 2.0)
			Return true
		EndIf
	EndIf
	Return false
EndFunction

Event OnMenuClose(String MenuName)
	UnRegisterForMenu("Crafting Menu")
	Utility.WaitMenuMode(0.1)
	Int i = _SLS_ArmorBreakdownBarrelRef.GetNumItems()
	Form akItem
	If Game.GetModByName("Mortal Weapons & Armor.esp") != 255
		While i > 0
			i -= 1
			akItem = _SLS_ArmorBreakdownBarrelRef.GetNthForm(i)
			Int j = _SLS_ArmorBreakdownBarrelRef.GetItemCount(akItem)
			While j > 0
				j -= 1
				Util.GiveMortalObject(akTarget = PlayerRef, akBaseObject = akItem, DurMinMod = 1.0, DurMaxMod = 1.0, Silent = true, FitLoosely = false, CursedChance = 0.0)
			EndWhile
		EndWhile
		_SLS_ArmorBreakdownBarrelRef.RemoveAllItems(akTransferTo = None)
	Else
		;/
		While i > 0
			i -= 1
			akItem = _SLS_ArmorBreakdownBarrelRef.GetNthForm(i)
			Debug.Messagebox("Item: " + akItem + "\nName: " + akItem.GetName())
			_SLS_ArmorBreakdownBarrelRef.RemoveItem(akItem, aiCount = _SLS_ArmorBreakdownBarrelRef.GetItemCount(akItem), abSilent = true, akOtherContainer = PlayerRef)
		EndWhile
		_SLS_ArmorBreakdownBarrelRef.RemoveAllItems(akTransferTo = None)
		/;
		
		_SLS_ArmorBreakdownBarrelRef.RemoveAllItems(akTransferTo = PlayerRef, abKeepOwnership = true, abRemoveQuestItems = true)
	EndIf
EndEvent

Bool Property CompatibilityMode = true Auto Hidden

ObjectReference Property _SLS_ArmorBreakdownBarrelRef Auto

Formlist Property _SLS_BikBreakBuiltInMiscObjsList Auto
Formlist Property _SLS_BikBreakCustomMiscObjsList Auto
Formlist Property _SLS_BikBreakCustomCobjsList Auto

Actor Property PlayerRef Auto

GlobalVariable Property _SLS_BikBreakEnable Auto

SLS_Utility Property Util Auto
