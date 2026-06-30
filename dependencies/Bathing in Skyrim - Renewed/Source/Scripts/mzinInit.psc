Scriptname mzinInit extends Quest  

String Property PAPYUTILstate = "$BIS_L_NULL" Auto Hidden
String Property PO3PEstate = "$BIS_L_NULL" Auto Hidden
String Property SKEE64state = "$BIS_L_NULL" Auto Hidden
String Property SPEstate = "$BIS_L_NULL" Auto Hidden

Bool Property IsSexLabInstalled = false Auto Hidden
Bool Property IsSexLabArousedInstalled = false Auto Hidden
Bool Property IsDeviousDevicesInstalled = false Auto Hidden
Bool Property IsWadeInWaterInstalled = false Auto Hidden
Bool Property IsMalignisAnimInstalled = false Auto Hidden
Bool Property IsFadeTattoosInstalled = false Auto Hidden
Bool Property IsFrostFallInstalled = false Auto Hidden
Bool Property IsOCumInstalled = false Auto Hidden
Bool Property IsOStimInstalled = false Auto Hidden

Keyword Property BatheIgnoreItem Auto
Keyword Property zad_DeviousHeavyBondage Auto Hidden
Keyword Property zad_DeviousSuit Auto Hidden

Faction Property ZazSlaveFaction Auto Hidden
Faction Property SLAExhibitionistFaction Auto Hidden
Faction Property SexLabForbiddenActors Auto Hidden

MagicEffect Property LokiWaterSlowdownEffect Auto Hidden

Quest Property SL_API Auto Hidden
Quest Property OCA_API Auto Hidden
Quest Property FadeTats_API Auto Hidden

GlobalVariable Property FrostfallRunning_var Auto Hidden

Keyword[] Property KeywordIgnoreItem Auto

Bool Function DoHardCheck()
	int i = 0

	PAPYUTILstate = "$BIS_L_NULL"
	if (SKSE.GetPluginVersion("PapyrusUtil") != -1 || SKSE.GetPluginVersion("papyrusutil plugin") != -1) && (PapyrusUtil.GetVersion() >= 30)
		PAPYUTILstate = "$BIS_TXT_INSTALLED"
		i += 1
	endIf

	PO3PEstate = "$BIS_L_NULL"
	if SKSE.GetPluginVersion("powerofthree's Papyrus Extender") != -1 && (PO3_SKSEFunctions.GetPapyrusExtenderVersion()[0] >= 5)
		PO3PEstate = "$BIS_TXT_INSTALLED"
		i += 1
	endIf

	SKEE64state = "$BIS_L_NULL"
	if SKSE.GetPluginVersion("skee") != -1
		SKEE64state = "$BIS_TXT_INSTALLED"
		i += 1
	endIf

	SPEstate = "$BIS_L_NULL"
	if SKSE.GetPluginVersion("ScrabsPapyrusExtender") >= 0x02010030
		SPEstate = "$BIS_TXT_INSTALLED"
		i += 1
	endIf

	if i == 4
		return true
	else
		return false
	endIf
EndFunction

Int Function DoSoftCheck()
	int i = 0

	IsSexLabInstalled = false
	If Game.GetModByName("SexLab.esm") != 255
		IsSexLabInstalled = true
		i += 1
	EndIf

	IsSexLabArousedInstalled = false
	If Game.GetModByName("SexLabAroused.esm") != 255
		IsSexLabArousedInstalled = true
		i += 1
	EndIf

	IsDeviousDevicesInstalled = false
	If Game.GetModByName("Devious Devices - Integration.esm") != 255
		IsDeviousDevicesInstalled = true
		i += 1
	EndIf

	IsWadeInWaterInstalled = false
	If Game.GetModByName("WadeInWater.esp") != 255 || Game.GetModByName("SinkOrSwim.esp") != 255
		IsWadeInWaterInstalled = true
		i += 1
	EndIf

	IsFadeTattoosInstalled = false
	If Game.GetModByName("FadeTattoos.esp") != 255
		IsFadeTattoosInstalled = true
		i += 1
	EndIf

	IsFrostFallInstalled = false
	If Game.GetModByName("Frostfall.esp") != 255
		IsFrostFallInstalled = true
		i += 1
	EndIf

	IsOCumInstalled = false
	If Game.GetModByName("OCum.esp") != 255
		IsOCumInstalled = true
		i += 1
	EndIf

	IsOStimInstalled = false
	If Game.GetModByName("OStim.esp") != 255
		IsOStimInstalled = true
		i += 1
	EndIf

	IsMalignisAnimInstalled = false
	If MiscUtil.FileExists("data/meshes/actors/character/behaviors/FNIS_Bathing_in_Skyrim_Malignis_Behavior.hkx")
		IsMalignisAnimInstalled = true
		i += 1
	EndIf

	return i
EndFunction

Function SetInternalVariables()
	KeywordIgnoreItem = new Keyword[7]
	KeywordIgnoreItem[0] = BatheIgnoreItem
	KeywordIgnoreItem[1] = Keyword.GetKeyword("zad_QuestItem")
	KeywordIgnoreItem[2] = Keyword.GetKeyword("zad_Lockable")
	KeywordIgnoreItem[3] = Keyword.GetKeyword("zad_InventoryDevice")
	KeywordIgnoreItem[4] = Keyword.GetKeyword("zbfWornDevice")
	KeywordIgnoreItem[5] = Keyword.GetKeyword("SexLabNoStrip")
	KeywordIgnoreItem[6] = Keyword.GetKeyword("WearWhenStripped")

	If IsWadeInWaterInstalled
		If Game.GetModByName("WadeInWater.esp") != 255
			LokiWaterSlowdownEffect = Game.GetFormFromFile(0x000D62, "WadeInWater.esp") as MagicEffect
		ElseIf Game.GetModByName("SinkOrSwim.esp") != 255
			LokiWaterSlowdownEffect = Game.GetFormFromFile(0x000D62, "SinkOrSwim.esp") as MagicEffect
		Else
			LokiWaterSlowdownEffect = none
		EndIf
	EndIf
	If IsSexLabInstalled
		SL_API = Quest.GetQuest("SexLabQuestFramework")
		SexLabForbiddenActors  = Game.GetFormFromFile(0x049068, "SexLab.esm") as Faction
	else
		SL_API = none
		SexLabForbiddenActors = none
	EndIf
	If IsSexLabArousedInstalled
		SLAExhibitionistFaction = Game.GetFormFromFile(0x0713DA, "SexLabAroused.esm") as Faction
	else
		SLAExhibitionistFaction = none
	EndIf
	If IsDeviousDevicesInstalled
		zad_DeviousHeavyBondage = Keyword.GetKeyword("zad_DeviousHeavyBondage")
		zad_DeviousSuit = Keyword.GetKeyword("zad_DeviousSuit")
	else
		zad_DeviousHeavyBondage = none
		zad_DeviousSuit = none
	EndIf
	If IsOCumInstalled
		OCA_API = Quest.GetQuest("OCumQuest") ;0x001800
	else
		OCA_API = none
	EndIf
	If IsFadeTattoosInstalled
		FadeTats_API = Quest.GetQuest("FadeTattoos_main") ;0x000D62
	else
		FadeTats_API = none
	EndIf
	If IsFrostFallInstalled
		FrostfallRunning_var = Game.GetFormFromFile(0x06DCFB, "Frostfall.esp") as GlobalVariable
	else
		FrostfallRunning_var = none
	EndIf
EndFunction