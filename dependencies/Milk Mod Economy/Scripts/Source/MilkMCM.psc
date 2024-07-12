scriptname MilkMCM extends SKI_ConfigBase
{MCM Menu script}

MilkQUEST Property MilkQ Auto

int Settings_WeightUpScale_T
int Debug_MM_RemoveMaid_OID

;note to self, max states per script is 128, use oids for spells
;note to self, max states reached, game will probably ctd if add more

; DEBUG MILKMAID
int	Debug_MM_SP_Spell_T
int	Debug_MM_MP_Spell_T
int	Debug_MM_EX_Spell_T
int	Debug_MM_MEX_Spell_T
int	Debug_MM_MC_Spell_T
int	Debug_MM_LFx1_Spell_T
int	Debug_MM_LFx2_Spell_T
int	Debug_MM_LL_Spell_T
int	Debug_MM_BB_Spell_T
int	Debug_MM_UM1_Spell_T
int	Debug_MM_WM1_Spell_T

;Spells configuration
int ExhaustionDebuff_T
int Exhausion_Debuff_T
int Unmilked_DeBuffs_Skills_T
int Unmilked_DeBuffs_SPMP_T
int Unmilked_DeBuffs_SpeedStamina_T
int SkoomaLactacidEffect_T
int Milk_RaceEffect_T
int Milk_SkillsEffect_T
int Milk_LactacidEffect_T
int Milk_RNDEffect_T

;MCM Variables
string[] Preset
string[] Maidlist
Actor[] MaidlistA
string[] MaidlistMode
string[] ArmorSlotList
string[] Armorlist
String[] Slots
string[] RaceMilk
bool ResetMaids = false
bool MaidRemove = false
bool ResetVar = false
bool uninstall = false
int MaidlistModeIndex = 0
int PresetIndex = 3
int MaidIndex = 0
int ArmorlistIndex = 0
int ArmorSlotListIndex = 0

;----------------------------------------------------------------------------

event OnConfigInit()
    ModName = "Milk Mod"
	self.RefreshStrings()
endEvent

Function RefreshStrings()
	MaidIndex = 0
	ArmorlistIndex = 0
	ArmorSlotListIndex = 0

	Pages = new string[9]
	Pages[0] = "$MME_MENU_PAGE_Overview"
	Pages[1] = "$MME_MENU_PAGE_Settings"
	Pages[2] = "$MME_MENU_PAGE_Milking_Configuration"
	Pages[3] = "$MME_MENU_PAGE_Milk_Market_Information"
	Pages[4] = "$MME_MENU_PAGE_Debug"
	Pages[5] = "$MME_MENU_PAGE_Debug_Milk_Maid"
	Pages[6] = "$MME_MENU_PAGE_Compatibility_Check"
	Pages[7] = "$MME_MENU_PAGE_Spells_Configuration"
	Pages[8] = "$MME_MENU_PAGE_Armor_Management"
	
	Preset = new string[6]
	Preset[0] = "$MME_MENU_Preset_Legendary"
	Preset[1] = "$MME_MENU_Preset_Master"
	Preset[2] = "$MME_MENU_Preset_Expert"
	Preset[3] = "$MME_MENU_Preset_Adept"
	Preset[4] = "$MME_MENU_Preset_Apprentice"
	Preset[5] = "$MME_MENU_Preset_Novice"
	
	Armorlist = new string[4]
	Armorlist[0] = "--"
	Armorlist[1] = "Milking equipment"
	Armorlist[2] = "Basic living armor"
	Armorlist[3] = "Parasite living armor(EC+)"

	MaidlistMode = new string[2]
	MaidlistMode[0] = "Maids"
	MaidlistMode[1] = "Slaves"

	RaceMilk = new string[12]
	RaceMilk[0] = "$MME_MENU_RaceMilk_Nothing"
	RaceMilk[1] = "$MME_MENU_RaceMilk_Altmer_Milk"
	RaceMilk[2] = "$MME_MENU_RaceMilk_Argonian_Milk"
	RaceMilk[3] = "$MME_MENU_RaceMilk_Bosmer_Milk"
	RaceMilk[4] = "$MME_MENU_RaceMilk_Breton_Milk"
	RaceMilk[5] = "$MME_MENU_RaceMilk_Dunmer_Milk"
	RaceMilk[6] = "$MME_MENU_RaceMilk_Imperial_Milk"
	RaceMilk[7] = "$MME_MENU_RaceMilk_Khajiit_Milk"
	RaceMilk[8] = "$MME_MENU_RaceMilk_Nord_Milk"
	RaceMilk[9] = "$MME_MENU_RaceMilk_Orc_Milk"
	RaceMilk[10] = "$MME_MENU_RaceMilk_Redguard_Milk"
	RaceMilk[11] = "$MME_MENU_RaceMilk_Exotic_Milk"		;Custom race
EndFunction

;PAGES
event OnPageReset(string page)
	if page == ""
		self.LoadCustomContent("MilkMod/MilkLogo.dds")
		self.RefreshStrings()
		int i = 0
		if MaidlistModeIndex == 0
			Maidlist = new string[20]
			MaidlistA = new Actor[20]
			while i < MilkQ.MilkMaid.Length
				if MilkQ.MilkMaid[i] != None
					Maidlist[i] = MilkQ.MilkMaid[i].GetLeveledActorBase().GetName()
					MaidlistA[i] = MilkQ.MilkMaid[i]
					MaidIndex = i
				else
					Maidlist[i] = "--"
				endif
				i = i + 1
			endwhile
		else
			Maidlist = new string[100]
			MaidlistA = new Actor[100]
			while i < MilkQ.MilkSlave.Length
				if MilkQ.MilkSlave[i] != None
					Maidlist[i] = MilkQ.MilkSlave[i].GetLeveledActorBase().GetName()
					MaidlistA[i] = MilkQ.MilkSlave[i]
					MaidIndex = i
				else
					Maidlist[i] = "--"
				endif
				i = i + 1
			endwhile
		endif
	else
		self.UnloadCustomContent()
	endif

	if page == "$MME_MENU_PAGE_Overview"
		self.Page_Overview()
	elseif page == "$MME_MENU_PAGE_Settings"
		self.Page_Settings()
	elseif page == "$MME_MENU_PAGE_Milking_Configuration"
		self.Page_Milking_Config()
	elseif page == "$MME_MENU_PAGE_Milk_Market_Information"
		self.Page_Market()
	elseif page == "$MME_MENU_PAGE_Debug"
		self.Page_Debug()
	elseif page == "$MME_MENU_PAGE_Debug_Milk_Maid"
		self.Page_MilkMaidDebug()
	elseif page == "$MME_MENU_PAGE_Compatibility_Check"
		self.Page_PluginChecks()
	elseif page == "$MME_MENU_PAGE_Spells_Configuration"
		self.Page_Spell_Constructor()
	elseif page == "$MME_MENU_PAGE_Armor_Management"
		self.Page_ArmorManagement()
	endif
endEvent

function ArmorRefresh()
		if Slots[2] != "" 
			if MilkQ.MilkingEquipment.find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.find(Slots[2]) == -1
				SetTextOptionValueST("$Add", false, "ArmorSupport_ArmorMode_Toggle")
			elseif MilkQ.MilkingEquipment.find(Slots[2]) == -1
				SetTextOptionValueST("$Remove", false, "ArmorSupport_ArmorMode_Toggle")
			elseif MilkQ.BasicLivingArmor.find(Slots[2]) == -1
				SetTextOptionValueST("$Remove", false, "ArmorSupport_ArmorMode_Toggle")
			elseif MilkQ.ParasiteLivingArmor.find(Slots[2]) == -1
				SetTextOptionValueST("$Remove", false, "ArmorSupport_ArmorMode_Toggle")
			endif
		endif
		
		SetTextOptionValueST(Armorlist[ArmorlistIndex], false, "ArmorSupport_PurgeList_Toggle")

		if ArmorlistIndex == 0
			SetTextOptionValueST("-", false, "ASA1")
			SetTextOptionValueST("-", false, "ASA2")
			SetTextOptionValueST("-", false, "ASA3")
			SetTextOptionValueST("-", false, "ASA4")
			SetTextOptionValueST("-", false, "ASA5")
			SetTextOptionValueST("-", false, "ASA6")
			SetTextOptionValueST("-", false, "ASA7")
			SetTextOptionValueST("-", false, "ASA8")
			SetTextOptionValueST("-", false, "ASA9")
			SetTextOptionValueST("-", false, "ASA10")
		elseif ArmorlistIndex == 1
			SetTextOptionValueST(MilkQ.MilkingEquipment[0], false, "ASA1")
			SetTextOptionValueST(MilkQ.MilkingEquipment[1], false, "ASA2")
			SetTextOptionValueST(MilkQ.MilkingEquipment[2], false, "ASA3")
			SetTextOptionValueST(MilkQ.MilkingEquipment[3], false, "ASA4")
			SetTextOptionValueST(MilkQ.MilkingEquipment[4], false, "ASA5")
			SetTextOptionValueST(MilkQ.MilkingEquipment[5], false, "ASA6")
			SetTextOptionValueST(MilkQ.MilkingEquipment[6], false, "ASA7")
			SetTextOptionValueST(MilkQ.MilkingEquipment[7], false, "ASA8")
			SetTextOptionValueST(MilkQ.MilkingEquipment[8], false, "ASA9")
			SetTextOptionValueST(MilkQ.MilkingEquipment[9], false, "ASA10")
		elseif ArmorlistIndex == 2
			SetTextOptionValueST(MilkQ.BasicLivingArmor[0], false, "ASA1")
			SetTextOptionValueST(MilkQ.BasicLivingArmor[1], false, "ASA2")
			SetTextOptionValueST(MilkQ.BasicLivingArmor[2], false, "ASA3")
			SetTextOptionValueST(MilkQ.BasicLivingArmor[3], false, "ASA4")
			SetTextOptionValueST(MilkQ.BasicLivingArmor[4], false, "ASA5")
			SetTextOptionValueST(MilkQ.BasicLivingArmor[5], false, "ASA6")
			SetTextOptionValueST(MilkQ.BasicLivingArmor[6], false, "ASA7")
			SetTextOptionValueST(MilkQ.BasicLivingArmor[7], false, "ASA8")
			SetTextOptionValueST(MilkQ.BasicLivingArmor[8], false, "ASA9")
			SetTextOptionValueST(MilkQ.BasicLivingArmor[9], false, "ASA10")
		elseif ArmorlistIndex == 3
			SetTextOptionValueST(MilkQ.ParasiteLivingArmor[0], false, "ASA1")
			SetTextOptionValueST(MilkQ.ParasiteLivingArmor[1], false, "ASA2")
			SetTextOptionValueST(MilkQ.ParasiteLivingArmor[2], false, "ASA3")
			SetTextOptionValueST(MilkQ.ParasiteLivingArmor[3], false, "ASA4")
			SetTextOptionValueST(MilkQ.ParasiteLivingArmor[4], false, "ASA5")
			SetTextOptionValueST(MilkQ.ParasiteLivingArmor[5], false, "ASA6")
			SetTextOptionValueST(MilkQ.ParasiteLivingArmor[6], false, "ASA7")
			SetTextOptionValueST(MilkQ.ParasiteLivingArmor[7], false, "ASA8")
			SetTextOptionValueST(MilkQ.ParasiteLivingArmor[8], false, "ASA9")
			SetTextOptionValueST(MilkQ.ParasiteLivingArmor[9], false, "ASA10")
		endif
endFunction

String[] function FindAllArmor()
	armor[] BipedSlotsFormArray = new armor[32]
	String[] BipedNameArray = new String[32]
	BipedSlotsFormArray[0] = MilkQ.PlayerREF.GetWornForm(1) as armor
	BipedSlotsFormArray[1] = MilkQ.PlayerREF.GetWornForm(2) as armor
	BipedSlotsFormArray[2] = MilkQ.PlayerREF.GetWornForm(4) as armor
	BipedSlotsFormArray[3] = MilkQ.PlayerREF.GetWornForm(8) as armor
	BipedSlotsFormArray[4] = MilkQ.PlayerREF.GetWornForm(16) as armor
	BipedSlotsFormArray[5] = MilkQ.PlayerREF.GetWornForm(32) as armor
	BipedSlotsFormArray[6] = MilkQ.PlayerREF.GetWornForm(64) as armor
	BipedSlotsFormArray[7] = MilkQ.PlayerREF.GetWornForm(128) as armor
	BipedSlotsFormArray[8] = MilkQ.PlayerREF.GetWornForm(256) as armor
	BipedSlotsFormArray[9] = MilkQ.PlayerREF.GetWornForm(512) as armor
	BipedSlotsFormArray[10] = MilkQ.PlayerREF.GetWornForm(1024) as armor
	BipedSlotsFormArray[11] = MilkQ.PlayerREF.GetWornForm(2048) as armor
	BipedSlotsFormArray[12] = MilkQ.PlayerREF.GetWornForm(4096) as armor
	BipedSlotsFormArray[13] = MilkQ.PlayerREF.GetWornForm(8192) as armor
	BipedSlotsFormArray[14] = MilkQ.PlayerREF.GetWornForm(16384) as armor
	BipedSlotsFormArray[15] = MilkQ.PlayerREF.GetWornForm(32768) as armor
	BipedSlotsFormArray[16] = MilkQ.PlayerREF.GetWornForm(65536) as armor
	BipedSlotsFormArray[17] = MilkQ.PlayerREF.GetWornForm(131072) as armor
	BipedSlotsFormArray[18] = MilkQ.PlayerREF.GetWornForm(262144) as armor
	BipedSlotsFormArray[19] = MilkQ.PlayerREF.GetWornForm(524288) as armor
	BipedSlotsFormArray[20] = MilkQ.PlayerREF.GetWornForm(1048576) as armor
	BipedSlotsFormArray[21] = MilkQ.PlayerREF.GetWornForm(2097152) as armor
	BipedSlotsFormArray[22] = MilkQ.PlayerREF.GetWornForm(4194304) as armor
	BipedSlotsFormArray[23] = MilkQ.PlayerREF.GetWornForm(8388608) as armor
	BipedSlotsFormArray[24] = MilkQ.PlayerREF.GetWornForm(16777216) as armor
	BipedSlotsFormArray[25] = MilkQ.PlayerREF.GetWornForm(33554432) as armor
	BipedSlotsFormArray[26] = MilkQ.PlayerREF.GetWornForm(67108864) as armor
	BipedSlotsFormArray[27] = MilkQ.PlayerREF.GetWornForm(134217728) as armor
	BipedSlotsFormArray[28] = MilkQ.PlayerREF.GetWornForm(268435456) as armor
	BipedSlotsFormArray[29] = MilkQ.PlayerREF.GetWornForm(536870912) as armor
	BipedSlotsFormArray[30] = MilkQ.PlayerREF.GetWornForm(1073741824) as armor
	BipedSlotsFormArray[31] = MilkQ.PlayerREF.GetWornForm(-2147483648) as armor
	Int iCount = 0
	while iCount <= 31
		if BipedSlotsFormArray[iCount]
			BipedNameArray[iCount] = BipedSlotsFormArray[iCount].getName()
		endIf
		iCount += 1
	endWhile
	return BipedNameArray
endFunction

function Page_Overview()
	Float MilkLevel = StorageUtil.GetFloatValue(none, "MME.Progression.Level")

	SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$MME_MENU_PAGE_Overview_Progression_Info_Header")
			AddTextOption("$MME_MENU_Maid_Mastery_Level", MilkLevel as int)
			if MilkLevel < 10
				AddTextOption("$MME_MENU_Times_Milked_(this_level)", StorageUtil.GetFloatValue(none, "MME.Progression.TimesMilked") as int)
			else
				AddTextOption("$MME_MENU_Times_Milked_(this_level)", "--")
			endif
			if MilkLevel < 10
				AddTextOption("$MME_MENU_Next_Level", ((MilkLevel as int + 1) * MilkQ.TimesMilkedMult as int) )
			else
				AddTextOption("$MME_MENU_Next_Level", "MAX")
			endif	
			AddTextOption("$MME_MENU_Times_Milked_(overall)", StorageUtil.GetFloatValue(none, "MME.Progression.TimesMilkedAll") as int)
			AddTextOption("$MME_MENU_Maid_Slots_Unlocked", MilkQ.Milklvl0fix())
	
	SetCursorPosition(1)
		AddHeaderOption("$MME_MENU_PAGE_Overview_Milk_Maids_Header")
			int i = 0
			While i < MilkQ.MilkMaid.Length
				if MilkQ.MilkMaid[i] != None
					Int   MaidLevel = MME_Storage.getMaidLevel(MilkQ.MILKmaid[i])
					Float MilkCnt = MME_Storage.getMilkCurrent(MilkQ.MILKmaid[i])
					Float MilkMax = MME_Storage.getMilkMaximum(MilkQ.MILKmaid[i])
					Float PainCnt = MME_Storage.getPainCurrent(MilkQ.MILKmaid[i])
					Float PainMax = MME_Storage.getPainMaximum(MilkQ.MILKmaid[i])
					AddTextOption(MilkQ.MilkMaid[i].GetLeveledActorBase().GetName(), "")
					AddTextOption("$MME_MENU_PAGE_Overview_Milkmaid_Level" , MaidLevel)
					AddTextOption("$MME_MENU_PAGE_Overview_Milkmaid_Times_Milked_(to_level)" , StorageUtil.GetFloatValue(MilkQ.MILKmaid[i],"MME.MilkMaid.TimesMilked") as int + " (" + ((MaidLevel + 1) * MilkQ.TimesMilkedMult as int)+ ")")
					AddTextOption("$MME_MENU_PAGE_Overview_Milkmaid_Lactacid" , MilkQ.ReduceFloat(MME_Storage.getLactacidCurrent(MilkQ.MILKmaid[i])))
					AddTextOption("$MME_MENU_PAGE_Overview_Milkmaid_Milk" , MilkQ.ReduceFloat(MilkCnt) + " [" + MilkMax as int + "]")
					AddTextOption("$MME_MENU_PAGE_Overview_Milkmaid_Pain", MilkQ.NState(MilkQ.MilkMaid[i]) + " [" + (PainCnt/PainMax*100) as int + "%]")
					AddEmptyOption()
				endif
				i = i + 1
			endWhile
endfunction

function Page_Settings()
	SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$MME_MENU_PAGE_Settings_H1")
			if MilkQ.MilkFlag
				AddTextOptionST("Mod_Status_T", "$MME_MENU_PAGE_Settings_H1_S1", "$MME_MENU_Enabled")
			else
				AddTextOptionST("Mod_Status_T", "$MME_MENU_PAGE_Settings_H1_S1", "$MME_MENU_Disabled")
			endif
			if MilkQ.EconFlag
				AddTextOptionST("Econ_Status_T", "$MME_MENU_PAGE_Settings_Economy", "$MME_MENU_Enabled")
			else
				AddTextOptionST("Econ_Status_T", "$MME_MENU_PAGE_Settings_Economy", "$MME_MENU_Disabled")
			endif
			AddSliderOptionST("Poll_Interval_Slider", "$MME_MENU_PAGE_Settings_H1_S2.1", MilkQ.MilkPoll, "$MME_MENU_PAGE_Settings_H1_S2.2")
			AddToggleOptionST("MaidLvlCap_Toggle", "$MME_MENU_PAGE_Settings_H1_S5", MilkQ.MaidLvlCap)
			if MilkQ.MilkQC.Buffs
				AddTextOptionST("Buff_Toggle", "$MME_MENU_PAGE_Settings_H1_S6", "$MME_MENU_Enabled")
			else
				AddTextOptionST("Buff_Toggle", "$MME_MENU_PAGE_Settings_H1_S6", "$MME_MENU_Disabled")
			endif
			AddSliderOptionST("MilkGenerationValue_Slider", "$MME_MENU_PAGE_Settings_H1_S7", MilkQ.MilkGenValue, "$MME_MENU_PAGE_Settings_H1_S7.1")
			AddToggleOptionST("MaidLevelProgressionAffectsMilkGen_Toggle", "$MME_MENU_PAGE_Settings_H1_S13", StorageUtil.GetIntValue(none,"MME.MaidLevelProgressionAffectsMilkGen", 0))
			AddSliderOptionST("LactacidDecayRate_Slider", "$MME_MENU_PAGE_Settings_H1_S9", MilkQ.LactacidDecayRate, "{2}")
			AddSliderOptionST("LactacidMod_Slider", "$MME_MENU_PAGE_Settings_H1_S12", StorageUtil.GetFloatValue(none,"MME.LactacidMod", missing = 10), "{2}")
			;AddToggleOptionST("Settings_WeightUpScale_Toggle", "$MME_MENU_PAGE_Settings_H1_S8", MilkQ.WeightUpScale)

		AddHeaderOption("$MME_MENU_PAGE_Settings_H2")
			if MilkQ.BreastScale == 3
				AddTextOptionST("BreastScale_Toggle", "$MME_MENU_PAGE_Settings_H2_S6", "OFF")
			else
				AddTextOptionST("BreastScale_Toggle", "$MME_MENU_PAGE_Settings_H2_S6", "ON")
			endif
			AddToggleOptionST("BellyScale_Toggle", "$MME_MENU_PAGE_Settings_H2_S8", MilkQ.BellyScale)
			AddToggleOptionST("BreastScaleLimit_Toggle", "$MME_MENU_PAGE_Settings_H2_S7", MilkQ.BreastScaleLimit)
			AddSliderOptionST("BreastScaleMax_Slider", "$MME_MENU_PAGE_Settings_H2_S1", MilkQ.BoobMAX, "{2}")
			AddSliderOptionST("BreastCurve_Slider", "$MME_MENU_PAGE_Settings_H2_S2", MilkQ.BreastCurve, "{2}")
			AddSliderOptionST("BreastIncrease_Slider", "$MME_MENU_PAGE_Settings_H2_S3", MilkQ.BoobIncr, "{2}")
			AddSliderOptionST("BreastIncreasePerLvl_Slider", "$MME_MENU_PAGE_Settings_H2_S4", MilkQ.BoobPerLvl, "{2}")
			AddToggleOptionST("BreastUpScale_Toggle", "$MME_MENU_PAGE_Settings_H2_S5", MilkQ.BreastUpScale)
			AddToggleOptionST("BreastVolumeScale_Toggle", "$MME_MENU_PAGE_Settings_H2_S9", MilkQ.BreastVolumeScale)

		AddHeaderOption("$MME_MENU_PAGE_Settings_H3")
			AddToggleOptionST("Notification_Messages_Toggle", "$MME_MENU_PAGE_Settings_H3_S1", MilkQ.MilkMsgs)
			AddToggleOptionST("Milk_Count_Notification_Messages_Toggle", "$MME_MENU_PAGE_Settings_H3_S7", MilkQ.MilkCntMsgs)
			AddToggleOptionST("Notification_Economy_Messages_Toggle", "$MME_MENU_PAGE_Settings_H3_S6", MilkQ.MilkEMsgs)
			AddToggleOptionST("Milk_Stories_Toggle", "$MME_MENU_PAGE_Settings_H3_S2", MilkQ.MilkStory)
			AddSliderOptionST("NPCComments_Chance_Slider", "$MME_MENU_PAGE_Settings_H3_S3", MilkQ.MME_NPCComments.GetValue(), "{2}%")
			AddToggleOptionST("DialogueMilking_Toggle", "$MME_MENU_PAGE_Settings_H3_S4", MilkQ.MilkQC.MME_DialogueMilking)
			if MilkQ.MilkQC.Debug_enabled
				AddToggleOptionST("DialogueForceMilkSlave_Toggle", "$MME_MENU_PAGE_Settings_H3_S8", MilkQ.DialogueForceMilkSlave)
			endif
			AddKeyMapOptionST("Hotkey", "$MME_MENU_PAGE_Settings_H3_S5", MilkQ.NotificationKey)
;			if MilkQ.HotkeyMode == 1
;				AddTextOptionST("Hotkey_Toggle", "$MME_MENU_PAGE_Settings_H3_S9", "UI extension")
;			else
;				AddTextOptionST("Hotkey_Toggle", "$MME_MENU_PAGE_Settings_H3_S9", "Classic")
;			endif
		
	SetCursorPosition(1)
		AddHeaderOption("$MME_MENU_PAGE_Settings_H4")
			AddMenuOptionST("Difficulty_Menu", "Difficulty:", Preset[PresetIndex])
			int i = 1
			while i <= 10
				AddTextOption("Times milked for level " + i + ":", i*MilkQ.TimesMilkedMult as int, OPTION_FLAG_DISABLED)	
				i = i +1
			endwhile
endfunction	

function Page_Milking_Config()
	SetCursorFillMode(TOP_TO_BOTTOM)
			AddToggleOptionST("SimpleMilk_Toggle", "$MME_MENU_PAGE_Milking_H3_S13", MilkQ.MilkQC.MME_SimpleMilkPotions)
			AddToggleOptionST("MilkingReq40PctMilk_Toggle", "$MME_MENU_PAGE_Milking_H3_S18", MilkQ.MilkingReq40PctMilk)
			AddSliderOptionST("Milking_Duration_Slider", "$MME_MENU_PAGE_Milking_H3_S7.1", MilkQ.Milking_Duration, "$MME_MENU_PAGE_Milking_H3_S7.2")
			AddSliderOptionST("Milking_GushPct_Slider", "$MME_MENU_PAGE_Milking_H3_S16", MilkQ.GushPct, "{2}" + "%")
			if MilkQ.MilkNaked
				AddTextOptionST("Milking_MilkWithZaZMoMSuctionCups_Toggle", "$MME_MENU_PAGE_Milking_H3_S5", "$MME_MENU_PAGE_Milking_H3_S5.1")
			elseif MilkQ.MilkWithZaZMoMSuctionCups
				AddTextOptionST("Milking_MilkWithZaZMoMSuctionCups_Toggle", "$MME_MENU_PAGE_Milking_H3_S5", "$MME_MENU_PAGE_Milking_H3_S5.2")
			else
				AddTextOptionST("Milking_MilkWithZaZMoMSuctionCups_Toggle", "$MME_MENU_PAGE_Milking_H3_S5", "$MME_MENU_PAGE_Milking_H3_S5.3")
			endif
			;AddToggleOptionST("FutaMilkCuirass_Toggle", "$MME_MENU_PAGE_Milking_H3_S17", MilkQ.UseFutaMilkCuirass)
			AddToggleOptionST("Feeding_Toggle", "$MME_MENU_PAGE_Milking_H3_S8", MilkQ.Feeding)
			AddToggleOptionST("ForcedFeeding_Toggle", "$MME_MENU_PAGE_Milking_H3_S14", MilkQ.ForcedFeeding)
			AddSliderOptionST("Feeding_Duration_Slider", "$MME_MENU_PAGE_Milking_H3_S9.1", MilkQ.Feeding_Duration, "$MME_MENU_PAGE_Milking_H3_S9.2")
			if MilkQ.Feeding_Sound == 0
				AddTextOptionST("Feeding_Sound_Toggle", "$MME_MENU_PAGE_Milking_H3_S12", "$MME_MENU_PAGE_Milking_H3_S12.1")
			elseif MilkQ.Feeding_Sound == 1
				AddTextOptionST("Feeding_Sound_Toggle", "$MME_MENU_PAGE_Milking_H3_S12", "$MME_MENU_PAGE_Milking_H3_S12.2")
			elseif MilkQ.Feeding_Sound == 2
				AddTextOptionST("Feeding_Sound_Toggle", "$MME_MENU_PAGE_Milking_H3_S12", "$MME_MENU_PAGE_Milking_H3_S12.3")
			endif
			AddToggleOptionST("FuckMachine_Toggle", "$MME_MENU_PAGE_Milking_H3_S10", MilkQ.FuckMachine)
			AddSliderOptionST("FuckMachine_Duration_Slider", "$MME_MENU_PAGE_Milking_H3_S11.1", MilkQ.FuckMachine_Duration, "$MME_MENU_PAGE_Milking_H3_S11.2")
			AddToggleOptionST("CumProduction_Toggle", "$MME_MENU_PAGE_Milking_H3_S19", MilkQ.CumProduction)
			AddToggleOptionST("MobileMilkingAnims_Toggle", "$MME_MENU_PAGE_Milking_H3_S20", MilkQ.MobileMilkingAnims)

	SetCursorPosition(1)
			AddToggleOptionST("PainSystem_Toggle", "$MME_MENU_PAGE_Milking_Pain_System", MilkQ.PainSystem)
			AddToggleOptionST("PainHurts_Toggle", "$MME_MENU_PAGE_Milking_Pain_Hurts", MilkQ.PainKills)
			AddToggleOptionST("MilkingDrainsSP_Toggle", "$MME_MENU_PAGE_Milking_MilkingDrainsSP", MilkQ.MilkingDrainsSP)
			AddToggleOptionST("MilkingDrainsMP_Toggle", "$MME_MENU_PAGE_Milking_MilkingDrainsMP", MilkQ.MilkingDrainsMP)
			AddEmptyOption()

		if MilkQ.Plugin_EstrusChaurus
			AddHeaderOption("$MME_MENU_PAGE_Milking_EstrusChaurus_Header")
				AddToggleOptionST("ECTrigger_Toggle", "$MME_MENU_PAGE_Milking_EC_Event", MilkQ.ECTrigger)
				AddToggleOptionST("ECCrowdControl_Toggle", "$MME_MENU_PAGE_Milking_EC_CC", MilkQ.ECCrowdControl)
				AddSliderOptionST("ECRange_Slider", "$MME_MENU_PAGE_Milking_EC_Range", MilkQ.ECRange, "{0}")
		endif
endfunction	

function Page_Market()
	SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption(MilkQ.MilkE.locWhiterun.GetName())
			AddTextOption("$MME_MENU_PAGE_Milk_Market_Information_Market", MilkQ.MilkE.MilkEcoWhiterun + " (" + (MilkQ.MilkE.CalculateServiceTaxHelper(MilkQ.MilkE.MilkEcoWhiterun) * 100) as int + ")", OPTION_FLAG_DISABLED)
			AddTextOption("$MME_MENU_PAGE_Milk_Market_Information_Demand", RaceMilk[MilkQ.MilkE.MilkDemandWhiterun], OPTION_FLAG_DISABLED)
			AddEmptyOption()
		AddHeaderOption(MilkQ.MilkE.locMarkarth.GetName())
			AddTextOption("$MME_MENU_PAGE_Milk_Market_Information_Market", MilkQ.MilkE.MilkEcoMarkarth + " (" + (MilkQ.MilkE.CalculateServiceTaxHelper(MilkQ.MilkE.MilkEcoWhiterun) * 100) as int + ")", OPTION_FLAG_DISABLED)
			AddTextOption("$MME_MENU_PAGE_Milk_Market_Information_Demand", RaceMilk[MilkQ.MilkE.MilkDemandMarkarth], OPTION_FLAG_DISABLED)
			AddEmptyOption()
		AddHeaderOption(MilkQ.MilkE.locSolitude.GetName())
			AddTextOption("$MME_MENU_PAGE_Milk_Market_Information_Market", MilkQ.MilkE.MilkEcoSolitude + " (" + (MilkQ.MilkE.CalculateServiceTaxHelper(MilkQ.MilkE.MilkEcoSolitude) * 100) as int + ")", OPTION_FLAG_DISABLED)
			AddTextOption("$MME_MENU_PAGE_Milk_Market_Information_Demand", RaceMilk[MilkQ.MilkE.MilkDemandSolitude], OPTION_FLAG_DISABLED)
			AddEmptyOption()
		AddHeaderOption(MilkQ.MilkE.locDawnstar.GetName())
			AddTextOption("$MME_MENU_PAGE_Milk_Market_Information_Market", MilkQ.MilkE.MilkEcoDawnstar + " (" + (MilkQ.MilkE.CalculateServiceTaxHelper(MilkQ.MilkE.MilkEcoDawnstar) * 100) as int + ")", OPTION_FLAG_DISABLED)
			AddTextOption("$MME_MENU_PAGE_Milk_Market_Information_Demand", RaceMilk[MilkQ.MilkE.MilkDemandDawnstar], OPTION_FLAG_DISABLED)
			AddEmptyOption()
		AddHeaderOption(MilkQ.MilkE.locWindhelm.GetName())
			AddTextOption("$MME_MENU_PAGE_Milk_Market_Information_Market", MilkQ.MilkE.MilkEcoWindhelm + " (" + (MilkQ.MilkE.CalculateServiceTaxHelper(MilkQ.MilkE.MilkEcoWindhelm) * 100) as int + ")", OPTION_FLAG_DISABLED)
			AddTextOption("$MME_MENU_PAGE_Milk_Market_Information_Demand", RaceMilk[MilkQ.MilkE.MilkDemandWindhelm], OPTION_FLAG_DISABLED)

	SetCursorPosition(1)
		AddHeaderOption(MilkQ.MilkE.locRiften.GetName())
			AddTextOption("$MME_MENU_PAGE_Milk_Market_Information_Market", MilkQ.MilkE.MilkEcoRiften + " (" + (MilkQ.MilkE.CalculateServiceTaxHelper(MilkQ.MilkE.MilkEcoRiften) * 100) as int + ")", OPTION_FLAG_DISABLED)
			AddTextOption("$MME_MENU_PAGE_Milk_Market_Information_Demand", RaceMilk[MilkQ.MilkE.MilkDemandRiften], OPTION_FLAG_DISABLED)
			AddEmptyOption()
		AddHeaderOption(MilkQ.MilkE.locFalkreath.GetName())
			AddTextOption("$MME_MENU_PAGE_Milk_Market_Information_Market", MilkQ.MilkE.MilkEcoFalkreath + " (" + (MilkQ.MilkE.CalculateServiceTaxHelper(MilkQ.MilkE.MilkEcoFalkreath) * 100) as int + ")", OPTION_FLAG_DISABLED)
			AddTextOption("$MME_MENU_PAGE_Milk_Market_Information_Demand", RaceMilk[MilkQ.MilkE.MilkDemandFalkreath], OPTION_FLAG_DISABLED)
			AddEmptyOption()
		AddHeaderOption("$MME_MENU_PAGE_Milk_Market_Information_Orcish_Strongholds")
			AddTextOption("$MME_MENU_PAGE_Milk_Market_Information_Market", MilkQ.MilkE.MilkEcoOrc + " (" + (MilkQ.MilkE.CalculateServiceTaxHelper(MilkQ.MilkE.MilkEcoOrc) * 100) as int + ")", OPTION_FLAG_DISABLED)
			AddTextOption("$MME_MENU_PAGE_Milk_Market_Information_Demand", RaceMilk[MilkQ.MilkE.MilkDemandOrc], OPTION_FLAG_DISABLED)
			AddEmptyOption()
		AddHeaderOption("$MME_MENU_PAGE_Milk_Market_Information_Khajiit_Caravaneers")
			AddTextOption("$MME_MENU_PAGE_Milk_Market_Information_Market", MilkQ.MilkE.MilkEcoCaravan + " (" + (MilkQ.MilkE.CalculateServiceTaxHelper(MilkQ.MilkE.MilkEcoCaravan) * 100) as int + ")", OPTION_FLAG_DISABLED)
			AddTextOption("$MME_MENU_PAGE_Milk_Market_Information_Demand", RaceMilk[MilkQ.MilkE.MilkDemandCaravan], OPTION_FLAG_DISABLED)
			AddEmptyOption()
		AddHeaderOption("$MME_MENU_PAGE_Milk_Market_Information_Solstheim")
			AddTextOption("$MME_MENU_PAGE_Milk_Market_Information_Market", MilkQ.MilkE.MilkEcoMorrowind + " (" + (MilkQ.MilkE.CalculateServiceTaxHelper(MilkQ.MilkE.MilkEcoMorrowind) * 100) as int + ")", OPTION_FLAG_DISABLED)
			AddTextOption("$MME_MENU_PAGE_Milk_Market_Information_Demand", RaceMilk[MilkQ.MilkE.MilkDemandMorrowind], OPTION_FLAG_DISABLED)
endfunction

function Page_Debug()
	SetCursorFillMode(TOP_TO_BOTTOM)
		if MilkQ.MilkQC.Debug_enabled
			AddHeaderOption("$MME_MENU_PAGE_Debug_H1")
				AddSliderOptionST("Debug_Mastery_Slider", "$MME_MENU_Maid_Mastery_Level", StorageUtil.GetFloatValue(none, "MME.Progression.Level"))
				AddSliderOptionST("Debug_TimesMilked_Slider", "$MME_MENU_Times_Milked_(this_level)", StorageUtil.GetFloatValue(none, "MME.Progression.TimesMilked"))
				AddSliderOptionST("Debug_TimesMilked_Overall_Slider", "$MME_MENU_Times_Milked_(overall)", StorageUtil.GetFloatValue(none, "MME.Progression.TimesMilkedAll"))
				;AddToggleOptionST("Debug_Zaz_Milkpump_Toggle", "$MME_MENU_PAGE_Settings_H1_S11", MilkQ.ZazPumps)
				AddToggleOptionST("Debug_PC_Pregnancy_Toggle", "$MME_MENU_PAGE_Settings_H1_S10", MilkQ.PlayerCantBeMilkmaid)
				;AddToggleOptionST("Debug_SexLab_Orgasm_Toggle", "$MME_MENU_PAGE_Settings_H1_S3", MilkQ.SexLabOrgasm)
				AddToggleOptionST("Debug_PassiveArousalIncrease_Toggle", "$MME_MENU_PAGE_Settings_H1_S14", MilkQ.PassiveArousalIncrease)
				AddToggleOptionST("Debug_MilkLeak_Particles_Toggle", "$MME_MENU_PAGE_Debug_H1_S5", MilkQ.MilkLeakToggle)
				AddToggleOptionST("Debug_MilkLeak_Particles_Through_Clothes_Toggle", "$MME_MENU_PAGE_Debug_H1_S6", MilkQ.MilkLeakWearArm)
				AddToggleOptionST("Debug_MilkLeak_Textures_Toggle", "$MME_MENU_PAGE_Debug_H1_S7", MilkQ.MilkLeakTextures)
				AddToggleOptionST("Debug_Male_Milkmaids_Toggle", "$MME_MENU_PAGE_Debug_H1_S8", MilkQ.MaleMaids)
				AddToggleOptionST("Debug_ArmorStripping_Toggle", "$MME_MENU_PAGE_Debug_H1_S9", MilkQ.ArmorStrippingDisabled)
				
			AddHeaderOption("$MME_MENU_PAGE_Debug_H2")
				AddSliderOptionST("Debug_MilkProductionMod_Slider", "$MME_MENU_PAGE_Debug_H2_S1", MilkQ.MilkProdMod, "{0}%")
				AddSliderOptionST("Debug_MilkPriceMod_Slider", "$MME_MENU_PAGE_Debug_H2_S2", MilkQ.MilkPriceMod, "{0}")
				AddSliderOptionST("Debug_ExhaustionSleepMod_Slider", "$MME_MENU_PAGE_Debug_H2_S6", MilkQ.ExhaustionSleepMod, "{0}")
				AddToggleOptionST("Debug_FixedMilkGen_Toggle", "$MME_MENU_PAGE_Debug_H2_S3", MilkQ.FixedMilkGen)
				AddToggleOptionST("Debug_FixedMilkGen4Followers_Toggle", "$MME_MENU_PAGE_Debug_H2_S4", MilkQ.FixedMilkGen4Followers)
				AddToggleOptionST("Debug_CuirassSellsMilk_Toggle", "$MME_MENU_PAGE_Debug_H2_S5", MilkQ.CuirassSellsMilk)
				AddToggleOptionST("Debug_MilkAsMaidTimesMilked_Toggle", "$MME_MENU_PAGE_Debug_H2_S7", MilkQ.MilkAsMaidTimesMilked)
				AddToggleOptionST("Debug_FreeLactacid_Toggle", "$MME_MENU_PAGE_Debug_H2_S8", MilkQ.FreeLactacid)
		endif

			AddHeaderOption("$MME_MENU_PAGE_Debug_Maintenance_Header")
				AddToggleOptionST("Debug_enabled", "Debug enabled", MilkQ.MilkQC.Debug_enabled)
				AddTextOptionST("Debug_ResetMaidsNiO_Toggle", "$MME_MENU_PAGE_Debug_H3_S5", "")
				AddTextOptionST("Debug_ResetMaids_Toggle", "$MME_MENU_PAGE_Debug_H3_S1", "")
				AddTextOptionST("Debug_ResetSlaves_Toggle", "$MME_MENU_PAGE_Debug_H3_S4", "")
				AddTextOptionST("Debug_ResetVar_Toggle", "$MME_MENU_PAGE_Debug_H3_S2", "")
				AddTextOptionST("Debug_Uninstall_Toggle", "$MME_MENU_PAGE_Debug_H3_S3", "")

	SetCursorPosition(1)
		AddHeaderOption("$MME_MENU_PAGE_Debug_Spells_Management_Header")
		if MilkQ.MilkQC.Debug_enabled
			AddToggleOptionST("Debug_MilkSuccubusTransform_Toggle", "$MME_MENU_PAGE_Debug_H4_S1", MilkQ.MilkSuccubusTransform)
			AddToggleOptionST("Debug_MilkVampireTransform_Toggle", "$MME_MENU_PAGE_Debug_H4_S2", MilkQ.MilkVampireTransform)
			AddToggleOptionST("Debug_MilkWerewolfTransform_Toggle", "$MME_MENU_PAGE_Debug_H4_S3", MilkQ.MilkWerewolfTransform)
			AddToggleOptionST("Debug_MilkSelf_Spell_Toggle", MilkQ.MilkSelf.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MilkSelf))
			AddToggleOptionST("Debug_MilkTarget_Spell_Toggle", MilkQ.MilkTarget.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MilkTarget))
			;AddToggleOptionST("Debug_MilkModToggle_Spell_Toggle", MilkQ.MilkModToggle.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MilkModToggle))
			;AddToggleOptionST("Debug_MilkModInfo_Spell_Toggle", MilkQ.MilkModInfo.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MilkModInfo))

			AddToggleOptionST("Debug_MME_MakeMilkmaid_Spell_Toggle", MilkQ.MME_MakeMilkmaid_Spell.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MME_MakeMilkmaid_Spell))
			AddToggleOptionST("Debug_MME_MakeMilkslave_Spell_Toggle", MilkQ.MME_MakeMilkslave_Spell.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MME_MakeMilkslave_Spell))

			AddToggleOptionST("Debug_ArmorMnanagement_ME_Spell_Toggle", MilkQ.MME_AM_ME.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_ME))
			AddToggleOptionST("Debug_ArmorMnanagement_BLA_Spell_Toggle", MilkQ.MME_AM_BLA.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_BLA))
			AddToggleOptionST("Debug_ArmorMnanagement_PLA_Spell_Toggle", MilkQ.MME_AM_PLA.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_PLA))
			AddToggleOptionST("Debug_ArmorMnanagement_Purge_Spell_Toggle", MilkQ.MME_AM_Purge.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_Purge))

			AddToggleOptionST("Debug_Debug_Spell_Toggle", MilkQ.MME_DebugSpell.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MME_DebugSpell))
			;AddToggleOptionST("Debug_ResetMaids_Spell_Toggle", MilkQ.MME_ResetMaids.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MME_ResetMaids))
			;AddToggleOptionST("Debug_ResetMod_Spell_Toggle", MilkQ.MME_ResetMod.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MME_ResetMod))
			;AddToggleOptionST("Debug_Uninstall_Spell_Toggle", MilkQ.MME_Uninstall.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MME_Uninstall))
		else
			AddToggleOptionST("Debug_MilkSelf_Spell_Toggle", MilkQ.MilkSelf.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MilkSelf))
			AddToggleOptionST("Debug_MilkTarget_Spell_Toggle", MilkQ.MilkTarget.getname(), MilkQ.PlayerREF.HasSpell(MilkQ.MilkTarget))
		endif
endfunction	

function Page_MilkMaidDebug()
	SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$MME_MENU_PAGE_Debug_Milk_Maid")
		if MilkQ.MilkQC.Debug_enabled
			AddMenuOptionST("MaidlistMode_Menu", "List Selection", MaidlistMode[MaidlistModeIndex])
			AddMenuOptionST("Debug_Milk_Maid_Menu", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S2", Maidlist[MaidIndex])
			if MaidlistA[MaidIndex] != none
				float MaidBoobIncr = StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.BoobIncr")			;fetch individual maid data
				float MaidBoobPerLvl = StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.BoobPerLvl")		;fetch individual maid data
					if MaidBoobIncr < 0 																				;set to general maid data
						MaidBoobIncr = MilkQ.BoobIncr
					endif
					if MaidBoobPerLvl < 0																				;set to general maid data
						MaidBoobPerLvl = MilkQ.BoobPerLvl
					endif
				float MaidTimesMilked = StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.TimesMilked")
				int   BreastRows = MME_Storage.getBreastRows(MaidlistA[MaidIndex])
				float MilkMax = MME_Storage.getMilkMaximum(MaidlistA[MaidIndex])
				float MilkCnt = MME_Storage.getMilkCurrent(MaidlistA[MaidIndex])
				int   MaidLevel = MME_Storage.getMaidLevel(MaidlistA[MaidIndex])
				float MaidMilkGen = StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkGen") * BreastRows
				float MaidBreastsBasevalue = MME_Storage.getBreastsBasevalue(MaidlistA[MaidIndex])
				float MaidBreastsBaseadjust = MME_Storage.getBreastsBaseadjust(MaidlistA[MaidIndex])
				float LactacidMod = StorageUtil.GetFloatValue(none,"MME.LactacidMod", missing = 10)
				float LactacidCnt = MME_Storage.getLactacidCurrent(MaidlistA[MaidIndex])
				float LactacidFactor = ((LactacidCnt * LactacidCnt) / LactacidMod / PapyrusUtil.ClampInt(MaidLevel, 1, MaidLevel + 1))
				Int MaidLevelProgressionAffectsMilkGen = StorageUtil.GetIntValue(none,"MME.MaidLevelProgressionAffectsMilkGen", missing = 0)
				if MaidLevelProgressionAffectsMilkGen != 0
					MaidMilkGen *= MaidLevelProgressionAffectsMilkGen * MaidLevel
				endif
					
				float MilkTick = 0
				float FinalMilkTick = 0
				if MilkQ.FixedMilkGen || (MaidlistA[MaidIndex] != MilkQ.PlayerREF && MilkQ.FixedMilkGen4Followers)
					MilkTick = 1.0/3 * BreastRows * (1 + MilkQ.SLA.GetActorArousal(MaidlistA[MaidIndex])/100) * MilkQ.MilkProdMod/100
					FinalMilkTick = MilkTick
				else
					MilkTick = (MaidBreastsBasevalue + MaidMilkGen)/3/10 * (1 + MilkQ.SLA.GetActorArousal(MaidlistA[MaidIndex])/100) * MilkQ.MilkProdMod/100
					FinalMilkTick = MilkTick + PapyrusUtil.ClampFloat(MilkTick * LactacidFactor, 0, LactacidCnt)
				endif

				float CurrentSize = MaidBreastsBasevalue + ( MilkCnt * MaidBoobIncr ) + ( MaidLevel + ( MaidTimesMilked / (( MaidLevel + 1 ) * MilkQ.TimesMilkedMult ))) * MaidBoobPerLvl
				;float x = 0.0
				if MilkQ.BreastVolumeScale && CurrentSize > MaidBreastsBasevalue
					CurrentSize += 1 - MaidBreastsBasevalue
					float dx = 1.0
					float x = CurrentSize / 3.0
					
					while dx > 0.1
						dx = (CurrentSize / (x*x) - x) / 3.0
						x += dx
						if dx < 0.0
							dx = -dx
						endif
					endwhile
					CurrentSize = x*MaidBreastsBasevalue
				endif
				CurrentSize += MaidBreastsBaseadjust
				
				; arousal provides an additional bonus
				;  value range: 1 <= x <= 2
;				float ArousalBonus = 1 + (MilkQ.SLA.GetActorArousal(MaidlistA[MaidIndex])/100)

				; global milk production factor
				;  value range: 0 <= x <= 2
;				float MilkProdFactor = MilkQ.MilkProdMod/100

				; base milk production per hour
				;   does not include variable effects
				;   (prefer a static value for configuration)
;				float MilkProdPerHour = MME_Storage.getMilkProdPerHour(MaidlistA[MaidIndex])

				; effective milk production per hour
				;   includes global milk production and arousal adjustments
				;   (show what is actually used right now)
;				float MilkProdPerHourEff = MilkProdPerHour * MilkProdFactor * ArousalBonus

				AddTextOptionST("Debug_MM_MaidPregnancy", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S4", MilkQ.isPregnant(MaidlistA[MaidIndex]) as String, OPTION_FLAG_DISABLED)	
				AddTextOptionST("Debug_MM_MaidGender", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S5", MilkQ.akActorSex(MaidlistA[MaidIndex]) as String, OPTION_FLAG_DISABLED)	

				AddSliderOptionST("Debug_MM_MaidLevel_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S6", MaidLevel)
				AddSliderOptionST("Debug_MM_MaidTimesMilked_Slider", "$MME_MENU_Times_Milked_(this_level)", MaidTimesMilked as int)
				AddTextOptionST("Debug_MM_Maid_MilksToNextLevel", "$MME_MENU_Next_Level", ((MaidLevel+1) * MilkQ.TimesMilkedMult - MaidTimesMilked) as int, OPTION_FLAG_DISABLED)	

				AddTextOption("$MME_MENU_PAGE_Debug_MM_Maid_Breast", "", OPTION_FLAG_DISABLED)
				AddSliderOptionST("Debug_MM_Maid_BreastRows_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S21", BreastRows)
				AddSliderOptionST("Debug_MM_Maid_BreastBaseSize_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S9", MaidBreastsBasevalue, "{2}")
				AddSliderOptionST("Debug_MM_Maid_BreastBaseSizeModified_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S10", MaidBreastsBaseadjust, "{2}")
				AddSliderOptionST("Debug_MM_Maid_MaidBoobIncr_Slider", "$MME_MENU_PAGE_Settings_H2_S3", StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.BoobIncr"), "{2}")	
				AddSliderOptionST("Debug_MM_Maid_MaidBoobPerLvl_Slider", "$MME_MENU_PAGE_Settings_H2_S4", StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.BoobPerLvl"), "{2}")
				;AddTextOptionST("Debug_MM_Maid_BreastEffectiveSize", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S11", MilkQ.ReduceFloat(MaidBreastsBasevalue + MaidBreastsBaseadjust + (MilkCnt*MaidBoobIncr) + (MaidLevel + (MaidTimesMilked / ((MaidLevel + 1) * MilkQ.TimesMilkedMult))) * MaidBoobPerLvl), OPTION_FLAG_DISABLED)
				AddTextOptionST("Debug_MM_Maid_BreastEffectiveSize", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S11", MilkQ.ReduceFloat(CurrentSize), OPTION_FLAG_DISABLED)
				AddTextOptionST("Debug_MM_Maid_BellyScaleEffectiveSize", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S22", MilkQ.ReduceFloat(LactacidCnt/2), OPTION_FLAG_DISABLED)

				AddSliderOptionST("Debug_MM_LactacidCount_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S12", LactacidCnt, "{2}")
				if MilkQ.BreastScaleLimit
					AddSliderOptionST("Debug_MM_MilkCount_Slider", "Milk stored [Max = " + MilkQ.ReduceFloat(MilkMax) + "]:", MilkCnt, "{2}")
					AddSliderOptionST("Debug_MM_MilkMax_Basevalue_Slider", "Milk Limit (base value):", MME_Storage.getMilkMaxBasevalue(MaidlistA[MaidIndex]), "{2}")
					AddSliderOptionST("Debug_MM_MilkMax_Scalefactor_Slider", "Milk Limit (level scale factor):", MME_Storage.getMilkMaxScalefactor(MaidlistA[MaidIndex]), "{2}")
				else
					AddSliderOptionST("Debug_MM_MilkCount_Slider", "Milk stored [unlimited]:", MilkCnt, "{2}")
				endif
				AddSliderOptionST("Debug_MM_MilkGeneration_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S13", MilkTick, "{3}")
				AddTextOptionST("Debug_MM_Maid_Lactacid_Milk_Production_PH", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S15", MilkQ.ReduceFloat(FinalMilkTick), OPTION_FLAG_DISABLED)
				AddSliderOptionST("Debug_MM_PainCount_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S17", MME_Storage.getPainCurrent(MaidlistA[MaidIndex]), "{2}")
				AddTextOptionST("Debug_MM_Maid_Pain_Reduction_PH", "$MME_MENU_PAGE_Debug_Milk_Maid_H1_S18",  MilkQ.ReduceFloat((FinalMilkTick + MilkMax/10)), OPTION_FLAG_DISABLED)

				AddSliderOptionST("Debug_MM_MaidContainerCum_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_ContainerCum", StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingContainerCumsSUM"))
				AddSliderOptionST("Debug_MM_MaidContainerMilk_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_ContainerMilk", StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingContainerMilksSUM"))
				AddSliderOptionST("Debug_MM_MaidContainerLactacid_Slider", "$MME_MENU_PAGE_Debug_Milk_Maid_ContainerLactacid", StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingContainerLactacid"))
				if StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingMode") == 0
					AddTextOptionST("Debug_MM_Maid_MilkingMode", "$MME_MENU_PAGE_Debug_Milk_Maid_MilkingMode", "$MME_MENU_PAGE_Debug_Milk_Maid_MilkingMode.0")
				elseif StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingMode") == 1
					AddTextOptionST("Debug_MM_Maid_MilkingMode", "$MME_MENU_PAGE_Debug_Milk_Maid_MilkingMode", "$MME_MENU_PAGE_Debug_Milk_Maid_MilkingMode.1")
				elseif StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingMode") == 2
					AddTextOptionST("Debug_MM_Maid_MilkingMode", "$MME_MENU_PAGE_Debug_Milk_Maid_MilkingMode", "$MME_MENU_PAGE_Debug_Milk_Maid_MilkingMode.2")
				endif	
				AddToggleOptionST("Debug_MM_Maid_IsSlave", "$MME_MENU_PAGE_Debug_Milk_Maid_IsSlave", StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsSlave"))
				AddToggleOptionST("Debug_MM_Maid_IsVampire", "$MME_MENU_PAGE_Debug_Milk_Maid_IsVampire", StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsVampire"))
				AddToggleOptionST("Debug_MM_Maid_IsWerewolf", "$MME_MENU_PAGE_Debug_Milk_Maid_IsWerewolf", StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsWerewolf"))
				AddToggleOptionST("Debug_MM_Maid_IsSuccubus", "$MME_MENU_PAGE_Debug_Milk_Maid_IsSuccubus", StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsSuccubus"))
				AddEmptyOption()
				Debug_MM_RemoveMaid_OID = AddToggleOption("$MME_MENU_PAGE_Debug_Milk_Maid_H1_S20", MaidRemove)
			endif
		endif
	
	SetCursorPosition(1)
		AddHeaderOption("$MME_MENU_PAGE_Debug_Milk_Maid_Effects_Header")
		if MilkQ.MilkQC.Debug_enabled
			if MaidlistA[MaidIndex] != none
				Debug_MM_SP_Spell_T = AddToggleOption(MilkQ.MilkForSprigganPassive.getname(), MaidlistA[MaidIndex].HasSpell(MilkQ.MilkForSprigganPassive))
				Debug_MM_MP_Spell_T = AddToggleOption(MilkQ.BeingMilkedPassive.getname() + " (Hidden in UI)", MaidlistA[MaidIndex].HasSpell(MilkQ.BeingMilkedPassive))
				Debug_MM_EX_Spell_T = AddToggleOption((MilkQ.MME_Spells_Buffs.GetAt(3) as Spell).getname(), MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(3) as Spell))
				Debug_MM_MEX_Spell_T = AddToggleOption((MilkQ.MME_Spells_Buffs.GetAt(4) as Spell).getname(), MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(4) as Spell))
				Debug_MM_MC_Spell_T = AddToggleOption(MilkQ.MilkCritical.getname(), MaidlistA[MaidIndex].HasSpell(MilkQ.MilkCritical))
				Debug_MM_LFx1_Spell_T = AddToggleOption(MilkQ.MilkFx1.getname() + " (Hidden in UI)", MaidlistA[MaidIndex].HasSpell(MilkQ.MilkFx1))
				Debug_MM_LFx2_Spell_T = AddToggleOption(MilkQ.MilkFx2.getname() + " (Hidden in UI)", MaidlistA[MaidIndex].HasSpell(MilkQ.MilkFx2))
				Debug_MM_LL_Spell_T = AddToggleOption(MilkQ.MilkLeak.getname() + " (Hidden in UI)", MaidlistA[MaidIndex].HasSpell(MilkQ.MilkLeak))
				Debug_MM_BB_Spell_T = AddToggleOption((MilkQ.MME_Spells_Buffs.GetAt(0) as Spell).getname(), MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(0) as Spell))
				Debug_MM_UM1_Spell_T = AddToggleOption((MilkQ.MME_Spells_Buffs.GetAt(1) as Spell).getname(), MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(1) as Spell))
				Debug_MM_WM1_Spell_T = AddToggleOption((MilkQ.MME_Spells_Buffs.GetAt(2) as Spell).getname(), MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(2) as Spell))
			endif
		endif
endfunction	

function Page_PluginChecks()
	SetCursorFillMode(TOP_TO_BOTTOM)
		AddTextOption("DLC HearthFires", MilkQ.Plugin_HearthFires, OPTION_FLAG_DISABLED)
		AddTextOption("	locHeljarchenHall", MilkQ.MilkE.locHeljarchenHall.getname(), OPTION_FLAG_DISABLED)
		AddTextOption("	locWindstadManor", MilkQ.MilkE.locWindstadManor.getname(), OPTION_FLAG_DISABLED)
		AddTextOption("	locLakeviewManor", MilkQ.MilkE.locLakeviewManor.getname(), OPTION_FLAG_DISABLED)
		AddEmptyOption()

		AddTextOption("DLC Dawnguard", MilkQ.Plugin_Dawnguard, OPTION_FLAG_DISABLED)
		AddTextOption("	locFortDawnguard", MilkQ.MilkE.locFortDawnguard.getname(), OPTION_FLAG_DISABLED)
		AddTextOption("	locDayspringCanyon", MilkQ.MilkE.locDayspringCanyon.getname(), OPTION_FLAG_DISABLED)
		AddEmptyOption()
		
		AddTextOption("DLC Dragonborn", MilkQ.Plugin_Dragonborn, OPTION_FLAG_DISABLED)
		AddTextOption("	locRavenRock", MilkQ.MilkE.locRavenRock.getname(), OPTION_FLAG_DISABLED)
		AddTextOption("	locSkaalVillage", MilkQ.MilkE.locSkaalVillage.getname(), OPTION_FLAG_DISABLED)
		AddTextOption("	locTelMithryn", MilkQ.MilkE.locTelMithryn.getname(), OPTION_FLAG_DISABLED)
		AddEmptyOption()
		
		AddTextOption("SexLab Aroused", MilkQ.Plugin_SLA, OPTION_FLAG_DISABLED)
		AddTextOption("*SLA Integration Script", MilkQ.SLA.IsIntegraged(), OPTION_FLAG_DISABLED)
		AddEmptyOption()

		AddTextOption("ZaZAnimationPack", true, OPTION_FLAG_DISABLED)
		AddTextOption("	zbfWornGag", (Game.GetFormFromFile(0x8a4d , "ZaZAnimationPack.esm") as Keyword).GetString(), OPTION_FLAG_DISABLED)
		AddTextOption("*zbf Integration Script", MilkQ.zbf.IsIntegraged(), OPTION_FLAG_DISABLED)
		AddEmptyOption()

		AddTextOption("Devious Devices - Integration", MilkQ.Plugin_DDI, OPTION_FLAG_DISABLED)
		AddTextOption("*DDi Integration Script", MilkQ.DDi.IsIntegraged(), OPTION_FLAG_DISABLED)
		AddEmptyOption()
			
		AddTextOption("SexLab-StoriesDevious", MilkQ.Plugin_SLSD, OPTION_FLAG_DISABLED)
			if MilkQ.Plugin_SLSD
				AddTextOption("	_SLSD_CowHarness", (Game.GetFormFromFile(0x4395 , "SexLab-StoriesDevious.esp") as Keyword).GetString(), OPTION_FLAG_DISABLED)
				AddTextOption("	_SLSD_CowMilker", (Game.GetFormFromFile(0x18D18 , "SexLab-StoriesDevious.esp") as Keyword).GetString(), OPTION_FLAG_DISABLED)
			endif
		AddTextOption("*SLSD Integration Script", MilkQ.SLSD.IsIntegraged(), OPTION_FLAG_DISABLED)
		AddEmptyOption()

	SetCursorPosition(1)
		AddTextOption("iNeed", MilkQ.Plugin_iNeed, OPTION_FLAG_DISABLED)
		AddTextOption("*iNeed Integration Script", MilkQ.ineed.IsIntegraged(), OPTION_FLAG_DISABLED)
		AddTextOption("RealisticNeedsandDiseases", MilkQ.Plugin_RealisticNeedsandDiseases, OPTION_FLAG_DISABLED)
		AddTextOption("SexLabSkoomaWhore", MilkQ.Plugin_SlSW, OPTION_FLAG_DISABLED)
		AddEmptyOption()

		AddTextOption("Schlongs of Skyrim", MilkQ.Plugin_SOS, OPTION_FLAG_DISABLED)
		AddTextOption("Schlongs of Skyrim - UNP", MilkQ.Plugin_SOS_UNP, OPTION_FLAG_DISABLED)
		AddTextOption("SOS Equipable Schlong", MilkQ.Plugin_SOS_EQUIP, OPTION_FLAG_DISABLED)
			if MilkQ.Plugin_SOS_EQUIP
				AddTextOption("	SOS Equipable Schlong", (Game.GetFormFromFile(0xD62, "SOS Equipable Schlong.esp") as Armor).GetName(), OPTION_FLAG_DISABLED)
			endif
		AddTextOption("*SOS Integration Script", MilkQ.SOS.IsIntegraged(), OPTION_FLAG_DISABLED)
		AddEmptyOption()
		
		AddTextOption("PSQ PlayerSuccubusQuest", MilkQ.Plugin_PSQ, OPTION_FLAG_DISABLED)
			if MilkQ.Plugin_PSQ
				AddTextOption("	PlayerIsSuccubus", (Game.GetFormFromFile(0xDAF, "PSQ PlayerSuccubusQuest.esm") as GlobalVariable).GetValue(), OPTION_FLAG_DISABLED)
			endif
		AddTextOption("*PSQ Integration Script", MilkQ.PSQ.IsIntegraged(), OPTION_FLAG_DISABLED)
		AddTextOption("HentaiPregnancy", MilkQ.Plugin_HentaiPregnancy, OPTION_FLAG_DISABLED)
		AddTextOption("*HP Integration Script", MilkQ.SLHP.IsIntegraged(), OPTION_FLAG_DISABLED)
		AddTextOption("SexLabProcreation", MilkQ.Plugin_SexLabProcreation, OPTION_FLAG_DISABLED)
		AddTextOption("*SLP Integration Script", MilkQ.SLP.IsIntegraged(), OPTION_FLAG_DISABLED)
		AddTextOption("*SGO3 Integration Script", MilkQ.SGO.IsIntegraged(), OPTION_FLAG_DISABLED)
		AddTextOption("EstrusChaurus", MilkQ.Plugin_EstrusChaurus, OPTION_FLAG_DISABLED)
			if MilkQ.Plugin_EstrusChaurus
				AddTextOption("	ChaurusBreeder", (Game.GetFormFromFile(0x19121, "EstrusChaurus.esp") as Spell).GetName(), OPTION_FLAG_DISABLED)
				AddTextOption("	zzEstrusParasite", (Game.GetFormFromFile(0x160A8, "EstrusChaurus.esp") as Keyword).GetName(), OPTION_FLAG_DISABLED)
			endif
		AddTextOption("EstrusSpider", MilkQ.Plugin_EstrusSpider, OPTION_FLAG_DISABLED)
			if MilkQ.Plugin_EstrusSpider
				AddTextOption("	SpiderBreeder", (Game.GetFormFromFile(0x4e255, "EstrusSpider.esp") as Spell).GetName(), OPTION_FLAG_DISABLED)
				AddTextOption("	zzEstrusSpiderParasiteKWD", (Game.GetFormFromFile(0x4F2A3, "EstrusSpider.esp") as Keyword).GetName(), OPTION_FLAG_DISABLED)
			endif
		AddTextOption("EstrusDwemer", MilkQ.Plugin_EstrusDwemer, OPTION_FLAG_DISABLED)
			if MilkQ.Plugin_EstrusDwemer
				AddTextOption("	DwemerBreeder", (Game.GetFormFromFile(0x4e255, "EstrusDwemer.esp") as Spell).GetName(), OPTION_FLAG_DISABLED)
				AddTextOption("	zzEstrusDwemerParasiteKWD", (Game.GetFormFromFile(0x4F2A3, "EstrusDwemer.esp") as Keyword).GetName(), OPTION_FLAG_DISABLED)
			endif
		AddTextOption("BeeingFemale", MilkQ.Plugin_BeeingFemale, OPTION_FLAG_DISABLED)
			if MilkQ.Plugin_BeeingFemale
				AddTextOption("	_BFStatePregnant", (Game.GetFormFromFile(0x28a0, "BeeingFemale.esm") as Spell).GetName(), OPTION_FLAG_DISABLED)
			endif
		AddEmptyOption()

endfunction

function Page_Spell_Constructor()
	SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$MME_MENU_PAGE_Spells_Milk_Effects_Header")
			Milk_RaceEffect_T = AddToggleOption("$MME_MENU_PAGE_Spells_Milk_RaceEffect", MilkQ.MilkQC.Milk_RaceEffect)
			Milk_SkillsEffect_T = AddToggleOption("$MME_MENU_PAGE_Spells_Milk_SkillsEffect", MilkQ.MilkQC.Milk_SkillsEffect)
			Milk_LactacidEffect_T = AddToggleOption("$MME_MENU_PAGE_Spells_Milk_LactacidEffect", MilkQ.MilkQC.Milk_LactacidEffect)
			Milk_RNDEffect_T = AddToggleOption("$MME_MENU_PAGE_Spells_Milk_RNDEffect", MilkQ.MilkQC.Milk_RNDEffect)

	SetCursorPosition(1)
		AddHeaderOption("$MME_MENU_PAGE_Spells_Debuffs_Header")
			if MilkQ.MilkQC.ExhaustionMode == 300
				Exhausion_Debuff_T = AddTextOption("$MME_MENU_PAGE_Spells_Exhaustion_Debuff timer", "5 min")
			else
				Exhausion_Debuff_T = AddTextOption("$MME_MENU_PAGE_Spells_Exhaustion_Debuff timer", "1 day")
			endif
			ExhaustionDebuff_T = AddToggleOption("$MME_MENU_PAGE_Spells_ExhaustionDebuff", MilkQ.MilkQC.ExhaustionDebuff)
			Unmilked_DeBuffs_Skills_T = AddToggleOption("$MME_MENU_PAGE_Spells_Unmilked_DeBuffs_Skills", MilkQ.MilkQC.Unmilked_DeBuffs_Skills)
			Unmilked_DeBuffs_SPMP_T = AddToggleOption("$MME_MENU_PAGE_Spells_Unmilked_DeBuffs_SPMP", MilkQ.MilkQC.Unmilked_DeBuffs_SPMP)
			Unmilked_DeBuffs_SpeedStamina_T = AddToggleOption("$MME_MENU_PAGE_Spells_Unmilked_DeBuffs_SpeedStamina", MilkQ.MilkQC.Unmilked_DeBuffs_SpeedStamina)
	
		AddEmptyOption()
			SkoomaLactacidEffect_T = AddToggleOption("$MME_MENU_PAGE_Spells_DisableLactacidSkoomaEffect", MilkQ.DisableSkoomaLactacid)
			AddSliderOptionST("Spell_Constructor_BreastRowChance_Slider", "$MME_MENU_PAGE_Spells_AddBreastRowChance", MilkQ.MilkQC.BrestEnlargement_MultiBreast_Effect)
endfunction

function Page_ArmorManagement()
	Slots = new String[32]
	Slots = self.FindAllArmor()
	self.SetCursorFillMode(self.TOP_TO_BOTTOM)
	self.SetCursorPosition(0)
	self.AddHeaderOption("Body Slots: Items", 0)
;	self.AddTextOption("Slot 30 - Head", Slots[0], 0)
;	self.AddTextOption("Slot 31 - Hair", Slots[1], 0)
	self.AddTextOption("Slot 32 - Body", Slots[2], 0)
;	self.AddTextOption("Slot 33 - Hands", Slots[3], 0)
;	self.AddTextOption("Slot 34 - Forearms", Slots[4], 0)
;	self.AddTextOption("Slot 35 - Amulet", Slots[5], 0)
;	self.AddTextOption("Slot 36 - Ring", Slots[6], 0)
;	self.AddTextOption("Slot 37 - Feet", Slots[7], 0)
;	self.AddTextOption("Slot 38 - Calves", Slots[8], 0)
;	self.AddTextOption("Slot 39 - Shield", Slots[9], 0)
;	self.AddTextOption("Slot 40 - Tail", Slots[10], 0)
;	self.AddTextOption("Slot 41 - Long Hair", Slots[11], 0)
;	self.AddTextOption("Slot 42 - Circlet", Slots[12], 0)
;	self.AddTextOption("Slot 43 - Ears", Slots[13], 0)
;	self.AddTextOption("Slot 44 - Face/Mouth", Slots[14], 0)
;	self.AddTextOption("Slot 45 - Neck", Slots[15], 0)
;	self.AddTextOption("Slot 46 - Chest", Slots[16], 0)
;	self.AddTextOption("Slot 47 - Back", Slots[17], 0)
;	self.AddTextOption("Slot 48 - Misc/FX", Slots[18], 0)
;	self.AddTextOption("Slot 49 - Pelvis Primary", Slots[19], 0)
;	self.AddTextOption("Slot 50 - Decapitated Head", Slots[20], 0)
;	self.AddTextOption("Slot 51 - Decapitate", Slots[21], 0)
;	self.AddTextOption("Slot 52 - Pelvis Secondary", Slots[22], 0)
;	self.AddTextOption("Slot 53 - Leg Primary", Slots[23], 0)
;	self.AddTextOption("Slot 54 - Leg Secondary", Slots[24], 0)
;	self.AddTextOption("Slot 55 - Face Jewelry", Slots[25], 0)
;	self.AddTextOption("Slot 56 - Chest Secondary", Slots[26], 0)
;	self.AddTextOption("Slot 57 - Shoulder", Slots[27], 0)
;	self.AddTextOption("Slot 58 - Arm Secondary", Slots[28], 0)
;	self.AddTextOption("Slot 59 - Arm Primary", Slots[29], 0)
;	self.AddTextOption("Slot 60 - Misc/FX", Slots[30], 0)
;	self.AddTextOption("Slot 61 - FX01", Slots[31], 0)
	self.SetCursorPosition(1)

	AddMenuOptionST("ArmorSupport_Armorlist_Menu", "Armor list", Armorlist[ArmorlistIndex])
	if Slots[2] != "" 
		if MilkQ.MilkingEquipment.find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.find(Slots[2]) == -1
			AddTextOptionST("ArmorSupport_ArmorMode_Toggle", "", "$Add")
		elseif MilkQ.MilkingEquipment.find(Slots[2]) == -1
			AddTextOptionST("ArmorSupport_ArmorMode_Toggle", "", "$Remove")
		elseif MilkQ.BasicLivingArmor.find(Slots[2]) == -1
			AddTextOptionST("ArmorSupport_ArmorMode_Toggle", "", "$Remove")
		elseif MilkQ.ParasiteLivingArmor.find(Slots[2]) == -1
			AddTextOptionST("ArmorSupport_ArmorMode_Toggle", "", "$Remove")
		endif
	endif
	
	AddTextOptionST("ArmorSupport_PurgeList_Toggle", "ERASE LIST", Armorlist[ArmorlistIndex])
	AddEmptyOption()
	
	AddHeaderOption("Added armors:", 0)
		AddTextOptionST("ASA1", "1", "")
		AddTextOptionST("ASA2", "2", "")
		AddTextOptionST("ASA3", "3", "")
		AddTextOptionST("ASA4", "4", "")
		AddTextOptionST("ASA5", "5", "")
		AddTextOptionST("ASA6", "6", "")
		AddTextOptionST("ASA7", "7", "")
		AddTextOptionST("ASA8", "8", "")
		AddTextOptionST("ASA9", "9", "")
		AddTextOptionST("ASA10", "10", "")
	
	ArmorRefresh()
endfunction

event OnOptionHighlight(int option)
	if option == Settings_WeightUpScale_T
		SetInfoText("$MME_MENU_PAGE_Settings_H1_S8_Higlight")
	endif
endevent

event OnOptionSelect(int option)
	if option == Settings_WeightUpScale_T
		if !MilkQ.WeightUpScale
			MilkQ.WeightUpScale = true
			SetToggleOptionValue(Settings_WeightUpScale_T, true)
		else
			int i = 0
				while i < MilkQ.MilkMaid.Length
					if MilkQ.MilkMaid[i] != None
						float MaidWeightBase = MME_Storage.getWeightBasevalue(MilkQ.MILKmaid[i])
						Float NeckDelta = (MilkQ.MILKmaid[i].GetActorBase().GetWeight() / 100) - (MaidWeightBase/100)
						MilkQ.MILKmaid[i].GetActorBase().SetWeight(MaidWeightBase)
						MilkQ.MILKmaid[i].UpdateWeight(NeckDelta)
					endif
				i = i + 1
			endwhile
			MilkQ.BreastUpScale = false
			SetToggleOptionValue(Settings_WeightUpScale_T, false)
		endif
	elseif option == Debug_MM_RemoveMaid_OID
			MilkQ.MCMMaidReset(MaidlistModeIndex,MaidIndex)
			SetToggleOptionValue(Debug_MM_RemoveMaid_OID, true)
			MaidRemove = false
	elseif option == Debug_MM_SP_Spell_T
		if !MaidlistA[MaidIndex].HasSpell( MilkQ.MilkForSprigganPassive )
			MaidlistA[MaidIndex].AddSpell( MilkQ.MilkForSprigganPassive )
		else
			MaidlistA[MaidIndex].RemoveSpell( MilkQ.MilkForSprigganPassive )
		endif
			SetToggleOptionValue(Debug_MM_SP_Spell_T, MaidlistA[MaidIndex].HasSpell( MilkQ.MilkForSprigganPassive ))
	elseif option == Debug_MM_MP_Spell_T
		if !MaidlistA[MaidIndex].HasSpell( MilkQ.BeingMilkedPassive )
			MaidlistA[MaidIndex].AddSpell( MilkQ.BeingMilkedPassive )
		else
			MaidlistA[MaidIndex].RemoveSpell( MilkQ.BeingMilkedPassive )
		endif
			SetToggleOptionValue(Debug_MM_MP_Spell_T, MaidlistA[MaidIndex].HasSpell( MilkQ.BeingMilkedPassive ))
	elseif option == Debug_MM_EX_Spell_T
		if !MaidlistA[MaidIndex].HasSpell( MilkQ.MME_Spells_Buffs.GetAt(3) as Spell )
			MaidlistA[MaidIndex].AddSpell( MilkQ.MME_Spells_Buffs.GetAt(3) as Spell )
		else
			MaidlistA[MaidIndex].RemoveSpell( MilkQ.MME_Spells_Buffs.GetAt(3) as Spell )
		endif
			SetToggleOptionValue(Debug_MM_EX_Spell_T, MaidlistA[MaidIndex].HasSpell( MilkQ.MME_Spells_Buffs.GetAt(3) as Spell ))
	elseif option == Debug_MM_MEX_Spell_T
		if !MaidlistA[MaidIndex].HasSpell( MilkQ.MME_Spells_Buffs.GetAt(4) as Spell )
			MaidlistA[MaidIndex].AddSpell( MilkQ.MME_Spells_Buffs.GetAt(4) as Spell )
		else
			MaidlistA[MaidIndex].RemoveSpell( MilkQ.MME_Spells_Buffs.GetAt(4) as Spell )
		endif
			SetToggleOptionValue(Debug_MM_MEX_Spell_T, MaidlistA[MaidIndex].HasSpell( MilkQ.MME_Spells_Buffs.GetAt(4) as Spell ))
	elseif option == Debug_MM_MC_Spell_T
		if !MaidlistA[MaidIndex].HasSpell( MilkQ.MilkCritical )
			MaidlistA[MaidIndex].AddSpell( MilkQ.MilkCritical )
		else
			MaidlistA[MaidIndex].RemoveSpell( MilkQ.MilkCritical )
		endif
			SetToggleOptionValue(Debug_MM_MC_Spell_T, MaidlistA[MaidIndex].HasSpell( MilkQ.MilkCritical ))
	elseif option == Debug_MM_LFx1_Spell_T
		if !MaidlistA[MaidIndex].HasSpell( MilkQ.MilkFx1 )
			MaidlistA[MaidIndex].AddSpell( MilkQ.MilkFx1 )
		else
			MaidlistA[MaidIndex].RemoveSpell( MilkQ.MilkFx1 )
		endif
			SetToggleOptionValue(Debug_MM_LFx1_Spell_T, MaidlistA[MaidIndex].HasSpell( MilkQ.MilkFx1 ))
	elseif option == Debug_MM_LFx2_Spell_T
		if !MaidlistA[MaidIndex].HasSpell( MilkQ.MilkFx2 )
			MaidlistA[MaidIndex].AddSpell( MilkQ.MilkFx2 )
		else
			MaidlistA[MaidIndex].RemoveSpell( MilkQ.MilkFx2 )
		endif
			SetToggleOptionValue(Debug_MM_LFx2_Spell_T, MaidlistA[MaidIndex].HasSpell( MilkQ.MilkFx2 ))
	elseif option == Debug_MM_LL_Spell_T
		if !MaidlistA[MaidIndex].HasSpell( MilkQ.MilkLeak )
			MaidlistA[MaidIndex].AddSpell( MilkQ.MilkLeak )
		else
			MaidlistA[MaidIndex].RemoveSpell( MilkQ.MilkLeak )
		endif
			SetToggleOptionValue(Debug_MM_LL_Spell_T, MaidlistA[MaidIndex].HasSpell( MilkQ.MilkLeak ))
	elseif option == Debug_MM_BB_Spell_T
		if !MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(0) as Spell)
			MaidlistA[MaidIndex].AddSpell(MilkQ.MME_Spells_Buffs.GetAt(0) as Spell)
		else
			MaidlistA[MaidIndex].RemoveSpell(MilkQ.MME_Spells_Buffs.GetAt(0) as Spell)
		endif
			SetToggleOptionValue(Debug_MM_BB_Spell_T, MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(0) as Spell))
	elseif option == Debug_MM_UM1_Spell_T
		if !MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(1) as Spell)
			MaidlistA[MaidIndex].AddSpell(MilkQ.MME_Spells_Buffs.GetAt(1) as Spell)
		else
			MaidlistA[MaidIndex].RemoveSpell(MilkQ.MME_Spells_Buffs.GetAt(1) as Spell)
		endif
			SetToggleOptionValue(Debug_MM_UM1_Spell_T, MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(1) as Spell))
	elseif option == Debug_MM_WM1_Spell_T
		if !MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(2) as Spell)
			MaidlistA[MaidIndex].AddSpell(MilkQ.MME_Spells_Buffs.GetAt(2) as Spell)
		else
			MaidlistA[MaidIndex].RemoveSpell(MilkQ.MME_Spells_Buffs.GetAt(2) as Spell)
		endif
			SetToggleOptionValue(Debug_MM_WM1_Spell_T, MaidlistA[MaidIndex].HasSpell(MilkQ.MME_Spells_Buffs.GetAt(2) as Spell))
	elseif option == Milk_RaceEffect_T
		if !MilkQ.MilkQC.Milk_RaceEffect
			MilkQ.MilkQC.Milk_RaceEffect = true
		else
			MilkQ.MilkQC.Milk_RaceEffect = false
		endif
			SetToggleOptionValue(Milk_RaceEffect_T, MilkQ.MilkQC.Milk_RaceEffect)
	elseif option == Milk_SkillsEffect_T
		if !MilkQ.MilkQC.Milk_SkillsEffect
			MilkQ.MilkQC.Milk_SkillsEffect = true
		else
			MilkQ.MilkQC.Milk_SkillsEffect = false
		endif
			SetToggleOptionValue(Milk_SkillsEffect_T, MilkQ.MilkQC.Milk_SkillsEffect)
	elseif option == Milk_LactacidEffect_T
		if !MilkQ.MilkQC.Milk_LactacidEffect
			MilkQ.MilkQC.Milk_LactacidEffect = true
		else
			MilkQ.MilkQC.Milk_LactacidEffect = false
		endif
			SetToggleOptionValue(Milk_LactacidEffect_T, MilkQ.MilkQC.Milk_LactacidEffect)
	elseif option == Milk_RNDEffect_T
		if !MilkQ.MilkQC.Milk_RNDEffect
			MilkQ.MilkQC.Milk_RNDEffect = true
		else
			MilkQ.MilkQC.Milk_RNDEffect = false
		endif
			SetToggleOptionValue(Milk_RNDEffect_T, MilkQ.MilkQC.Milk_RNDEffect)
	elseif option == Exhausion_Debuff_T
		if !MilkQ.MilkQC.ExhaustionMode == 300
			MilkQ.MilkQC.ExhaustionMode = 0
			SetTextOptionValue(Exhausion_Debuff_T, "1 day")
		else
			MilkQ.MilkQC.ExhaustionMode = 300
			SetTextOptionValue(Exhausion_Debuff_T, "5 min")
		endif
	elseif option == ExhaustionDebuff_T
		if !MilkQ.MilkQC.ExhaustionDebuff
			MilkQ.MilkQC.ExhaustionDebuff = true
		else
			MilkQ.MilkQC.ExhaustionDebuff = false
		endif
			SetToggleOptionValue(ExhaustionDebuff_T, MilkQ.MilkQC.ExhaustionDebuff)
	elseif option == Unmilked_DeBuffs_Skills_T
		if !MilkQ.MilkQC.Unmilked_DeBuffs_Skills
			MilkQ.MilkQC.Unmilked_DeBuffs_Skills = true
		else
			MilkQ.MilkQC.Unmilked_DeBuffs_Skills = false
		endif
			SetToggleOptionValue(Unmilked_DeBuffs_Skills_T, MilkQ.MilkQC.Unmilked_DeBuffs_Skills)
	elseif option == Unmilked_DeBuffs_SPMP_T
		if !MilkQ.MilkQC.Unmilked_DeBuffs_SPMP
			MilkQ.MilkQC.Unmilked_DeBuffs_SPMP = true
		else
			MilkQ.MilkQC.Unmilked_DeBuffs_SPMP = false
		endif
			SetToggleOptionValue(Unmilked_DeBuffs_SPMP_T, MilkQ.MilkQC.Unmilked_DeBuffs_SPMP)
	elseif option == Unmilked_DeBuffs_SpeedStamina_T
		if !MilkQ.MilkQC.Unmilked_DeBuffs_SpeedStamina
			MilkQ.MilkQC.Unmilked_DeBuffs_SpeedStamina = true
		else
			MilkQ.MilkQC.Unmilked_DeBuffs_SpeedStamina = false
		endif
			SetToggleOptionValue(Unmilked_DeBuffs_SpeedStamina_T, MilkQ.MilkQC.Unmilked_DeBuffs_SpeedStamina)
			
	elseif option == SkoomaLactacidEffect_T
		if !MilkQ.DisableSkoomaLactacid
			MilkQ.DisableSkoomaLactacid = true
		else
			MilkQ.DisableSkoomaLactacid = false
		endif
			SetToggleOptionValue(SkoomaLactacidEffect_T, MilkQ.DisableSkoomaLactacid)
	endif
endevent

state ArmorSupport_ArmorMode_Toggle
	event OnSelectST()
		string toggleVal
		If Slots[2] != "" 
			If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
				MilkQ.Armor_Purge()
			EndIf
		
			if ArmorlistIndex == 1
				if MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1
					MilkQ.MilkingEquipment[MilkQ.MilkingEquipment.Find("Empty")] = Slots[2]
				elseif MilkQ.MilkingEquipment.Find(Slots[2]) != -1
					MilkQ.MilkingEquipment[MilkQ.MilkingEquipment.Find(Slots[2])] = "Empty"
				endif
				
			elseif ArmorlistIndex == 2
				if MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1
					MilkQ.BasicLivingArmor[MilkQ.BasicLivingArmor.Find("Empty")] = Slots[2]
				elseif MilkQ.BasicLivingArmor.Find(Slots[2]) != -1
					MilkQ.BasicLivingArmor[MilkQ.BasicLivingArmor.Find(Slots[2])] = "Empty"
				endif

			elseif ArmorlistIndex == 3
				if MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1
					MilkQ.ParasiteLivingArmor[MilkQ.ParasiteLivingArmor.Find("Empty")] = Slots[2]
				elseif MilkQ.ParasiteLivingArmor.Find(Slots[2]) != -1
					MilkQ.ParasiteLivingArmor[MilkQ.ParasiteLivingArmor.Find(Slots[2])] = "Empty"
				endif
			endif
		endif
		ArmorRefresh()
	endEvent
endState

state ArmorSupport_PurgeList_Toggle
	event OnSelectST()
		string toggleVal

		int i = 0
		if ArmorlistIndex == 0
			MilkQ.Armor_Purge()
		elseif ArmorlistIndex == 1
			MilkQ.MilkingEquipment = new string[10]
			while ( i < MilkQ.MilkingEquipment.Length )
				MilkQ.MilkingEquipment[i] = "Empty"
				i = i + 1
			endWhile
		elseif ArmorlistIndex == 2
			MilkQ.BasicLivingArmor = new string[10]
			while ( i < MilkQ.BasicLivingArmor.Length )
				MilkQ.BasicLivingArmor[i] = "Empty"
				i = i + 1
			endWhile
		elseif ArmorlistIndex == 3
			MilkQ.ParasiteLivingArmor = new string[10]
			while ( i < MilkQ.ParasiteLivingArmor.Length )
				MilkQ.ParasiteLivingArmor[i] = "Empty"
				i = i + 1
			endWhile
		endif
		toggleVal = Armorlist[ArmorlistIndex] as string + " ERASED"
		SetTextOptionValueST(toggleVal)
		Utility.WaitMenuMode(1)
		ArmorRefresh()
	endEvent
	
	event OnHighlightST()
		SetInfoText(" -- ERASES ALL LISTS")
	endEvent
endState

state Mod_Status_T
	event OnSelectST()
		string toggleVal

		if !MilkQ.MilkFlag
			toggleVal = "$MME_MENU_Enabled"
		else
			toggleVal = "$MME_MENU_Disabled"
		endif
		MilkQ.Modtoggle()
		SetTextOptionValueST(toggleVal)
	endEvent
endState

state Econ_Status_T
	event OnSelectST()
		string toggleVal

		if !MilkQ.EconFlag
			toggleVal = "$MME_MENU_Enabled"
			MilkQ.EconFlag = true
			MilkQ.MilkE.RegisterForSingleUpdateGameTime (1)
		else
			toggleVal = "$MME_MENU_Disabled"
			MilkQ.EconFlag = false
			MilkQ.MilkE.RegisterForSingleUpdateGameTime (1)
		endif
		SetTextOptionValueST(toggleVal)
	endEvent
endState

state Debug_Zaz_Milkpump_Toggle
	event OnSelectST()
		if !MilkQ.ZazPumps
			MilkQ.ZazPumps = true
		else
			MilkQ.ZazPumps = false
		endif
		SetToggleOptionValueST(MilkQ.ZazPumps)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H1_S11_Higlight")
	endEvent
endState

state Debug_PC_Pregnancy_Toggle
	event OnSelectST()
		if !MilkQ.PlayerCantBeMilkmaid
			MilkQ.PlayerCantBeMilkmaid = true
		else
			MilkQ.PlayerCantBeMilkmaid = false
		endif
		SetToggleOptionValueST(MilkQ.PlayerCantBeMilkmaid)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H1_S10_Higlight")
	endEvent
endState

;state Debug_SexLab_Orgasm_Toggle
;	event OnSelectST()
;		if !MilkQ.SexLabOrgasm
;			MilkQ.SexLabOrgasm = true
;		else
;			MilkQ.SexLabOrgasm = false
;		endif
;		SetToggleOptionValueST(MilkQ.SexLabOrgasm)
;	endEvent
;	
;	event OnHighlightST()
;		SetInfoText("$MME_MENU_PAGE_Settings_H1_S3_Higlight")
;	endEvent
;endState

state Debug_PassiveArousalIncrease_Toggle
	event OnSelectST()
		if !MilkQ.PassiveArousalIncrease
			MilkQ.PassiveArousalIncrease = true
		else
			MilkQ.PassiveArousalIncrease = false
		endif
		SetToggleOptionValueST(MilkQ.PassiveArousalIncrease)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H1_S14_Higlight")
	endEvent
endState

state MaidLvlCap_Toggle
	event OnSelectST()
		if !MilkQ.MaidLvlCap
			MilkQ.MaidLvlCap = true
		else
			MilkQ.MaidLvlCap = false
		endif
		SetToggleOptionValueST(MilkQ.MaidLvlCap)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H1_S5_Higlight")
	endEvent
endState

state BreastScale_Toggle
	event OnSelectST()
		string toggleVal
		if MilkQ.BreastScale != 3 
			MilkQ.BreastScale = 3
			toggleVal = "Off"
		else
			MilkQ.BreastScale = 0
			toggleVal = "ON"
		endif
		
		MilkQ.UpdateActors()
		SetTextOptionValueST(toggleVal)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H2_S6_Higlight")
	endEvent
endState

;state Hotkey_Toggle
;	event OnSelectST()
;		string toggleVal
;		if MilkQ.HotkeyMode == 1 
;			MilkQ.HotkeyMode = 0
;			toggleVal = "Classic"
;		else
;			MilkQ.BreastScale = 1
;			toggleVal = "UI extension"
;		endif
;		SetTextOptionValueST(toggleVal)
;	endEvent
;endState

; this setting also enforces the maximum milk limit
state BreastScaleLimit_Toggle
	event OnSelectST()
		if !MilkQ.BreastScaleLimit
			MilkQ.BreastScaleLimit = true
			; make sure MilkCurrent is valid for all actors
			MilkQ.UpdateActors()
		else
			MilkQ.BreastScaleLimit = false
		endif
		SetToggleOptionValueST(MilkQ.BreastScaleLimit)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H2_S7_Higlight")
	endEvent
endState

state BellyScale_Toggle
	event OnSelectST()
		if !MilkQ.BellyScale
			MilkQ.BellyScale = true
			; make sure MilkCurrent is valid for all actors
			MilkQ.UpdateActors()
		else
			MilkQ.BellyScale = false
		endif
		SetToggleOptionValueST(MilkQ.BellyScale)
	endEvent
endState

state BreastUpScale_Toggle
	event OnSelectST()
		if !MilkQ.BreastUpScale
			MilkQ.BreastUpScale = true
		else
			MilkQ.BreastUpScale = false
		endif
		SetToggleOptionValueST(MilkQ.BreastUpScale)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H2_S5_Higlight")
	endEvent
endState

state BreastVolumeScale_Toggle
	event OnSelectST()
		if !MilkQ.BreastVolumeScale
			MilkQ.BreastVolumeScale = true
		else
			MilkQ.BreastVolumeScale = false
		endif
		SetToggleOptionValueST(MilkQ.BreastVolumeScale)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H2_S9_Higlight")
	endEvent
endState

state Notification_Messages_Toggle
	event OnSelectST()
		if !MilkQ.MilkMsgs
			MilkQ.MilkMsgs = true
		else
			MilkQ.MilkMsgs = false
		endif
		SetToggleOptionValueST(MilkQ.MilkMsgs)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H3_S1_Higlight")
	endEvent
endState

state Milk_Count_Notification_Messages_Toggle
	event OnSelectST()
		if !MilkQ.MilkCntMsgs
			MilkQ.MilkCntMsgs = true
		else
			MilkQ.MilkCntMsgs = false
		endif
		SetToggleOptionValueST(MilkQ.MilkCntMsgs)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H3_S7_Higlight")
	endEvent
endState

state Notification_Economy_Messages_Toggle
	event OnSelectST()
		if !MilkQ.MilkEMsgs
			MilkQ.MilkEMsgs = true
		else
			MilkQ.MilkEMsgs = false
		endif
		SetToggleOptionValueST(MilkQ.MilkEMsgs)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H3_S6_Higlight")
	endEvent
endState

state Milk_Stories_Toggle
	event OnSelectST()
		if !MilkQ.MilkStory
			MilkQ.MilkStory = true
		else
			MilkQ.MilkStory = false
		endif
		SetToggleOptionValueST(MilkQ.MilkStory)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H3_S2_Higlight")
	endEvent
endState

state DialogueMilking_Toggle
	event OnSelectST()
		if !MilkQ.MilkQC.MME_DialogueMilking
			MilkQ.MilkQC.MME_DialogueMilking = True
		else
			MilkQ.MilkQC.MME_DialogueMilking = False
		endif
		SetToggleOptionValueST(MilkQ.MilkQC.MME_DialogueMilking)
	endEvent
endState

state DialogueForceMilkSlave_Toggle
	event OnSelectST()
		if !MilkQ.DialogueForceMilkSlave
			MilkQ.DialogueForceMilkSlave = True
		else
			MilkQ.DialogueForceMilkSlave = False
		endif
		SetToggleOptionValueST(MilkQ.DialogueForceMilkSlave)
	endEvent
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H3_S8_Higlight")
	endEvent
endState

state Buff_Toggle
	event OnSelectST()
		string toggleVal
		int i = 0
		if !MilkQ.MilkQC.Buffs
			MilkQ.MilkQC.Buffs = true
			toggleVal = "$MME_MENU_Enabled"
		else
			MilkQ.MilkQC.Buffs = false
			toggleVal = "$MME_MENU_Disabled"
		endif
		while i < MilkQ.MilkMaid.Length
			if MilkQ.MilkMaid[i] != None
				MilkQ.PostMilk(MilkQ.MilkMaid[i])
			endif
			i = i + 1
		endwhile
		SetTextOptionValueST(toggleVal)
	endEvent
endState

state Debug_MilkLeak_Particles_Toggle
	event OnSelectST()
		if !MilkQ.MilkLeakToggle
			MilkQ.MilkLeakToggle = true
		else
			MilkQ.MilkLeakToggle = false
		endif
		SetToggleOptionValueST(MilkQ.MilkLeakToggle)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Debug_H1_S5_Higlight")
	endEvent
endState

state Debug_MilkLeak_Particles_Through_Clothes_Toggle
	event OnSelectST()
		if !MilkQ.MilkLeakWearArm
			MilkQ.MilkLeakWearArm = true
		else
			MilkQ.MilkLeakWearArm = false
		endif
		SetToggleOptionValueST(MilkQ.MilkLeakWearArm)
	endEvent
endState

state Debug_MilkLeak_Textures_Toggle
	event OnSelectST()
		if !MilkQ.MilkLeakTextures
			MilkQ.MilkLeakTextures = true
		else
			MilkQ.MilkLeakTextures = false
		endif
		SetToggleOptionValueST(MilkQ.MilkLeakTextures)
	endEvent
endState

state Debug_Male_Milkmaids_Toggle
	event OnSelectST()
		if !MilkQ.MaleMaids
			MilkQ.MaleMaids = true
		else
			MilkQ.MaleMaids = false
		endif
		SetToggleOptionValueST(MilkQ.MaleMaids)
	endEvent
endState

state Debug_ArmorStripping_Toggle
	event OnSelectST()
		if !MilkQ.ArmorStrippingDisabled
			MilkQ.ArmorStrippingDisabled = true
		else
			MilkQ.ArmorStrippingDisabled = false
		endif
		SetToggleOptionValueST(MilkQ.ArmorStrippingDisabled)
	endEvent
endState
		
state Debug_FixedMilkGen_Toggle
	event OnSelectST()
		if !MilkQ.FixedMilkGen
			MilkQ.FixedMilkGen = true
		else
			MilkQ.FixedMilkGen = false
		endif
		SetToggleOptionValueST(MilkQ.FixedMilkGen)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Debug_H2_S3_Higlight")
	endEvent
endState

state Debug_FixedMilkGen4Followers_Toggle
	event OnSelectST()
		if !MilkQ.FixedMilkGen4Followers
			MilkQ.FixedMilkGen4Followers = true
		else
			MilkQ.FixedMilkGen4Followers = false
		endif
		SetToggleOptionValueST(MilkQ.FixedMilkGen4Followers)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Debug_H2_S4_Higlight")
	endEvent
endState

state Debug_CuirassSellsMilk_Toggle
	event OnSelectST()
		if !MilkQ.CuirassSellsMilk
			MilkQ.CuirassSellsMilk = true
		else
			MilkQ.CuirassSellsMilk = false
		endif
		SetToggleOptionValueST(MilkQ.CuirassSellsMilk)
	endEvent
endState

state Debug_MilkAsMaidTimesMilked_Toggle
	event OnSelectST()
		if !MilkQ.MilkAsMaidTimesMilked
			MilkQ.MilkAsMaidTimesMilked = true
		else
			MilkQ.MilkAsMaidTimesMilked = false
		endif
		SetToggleOptionValueST(MilkQ.MilkAsMaidTimesMilked)
	endEvent
endState

state Debug_FreeLactacid_Toggle
	event OnSelectST()
		if !MilkQ.FreeLactacid
			MilkQ.FreeLactacid = true
		else
			MilkQ.FreeLactacid = false
		endif
		SetToggleOptionValueST(MilkQ.FreeLactacid)
	endEvent
endState

state Debug_enabled
	event OnSelectST()
		if !MilkQ.MilkQC.Debug_enabled
			MilkQ.MilkQC.Debug_enabled = 1
		else
			MilkQ.MilkQC.Debug_enabled = 0
		endif
		SetToggleOptionValueST(MilkQ.MilkQC.Debug_enabled)
	endEvent
endState

state Debug_ResetMaids_Toggle
	event OnSelectST()
		SetOptionFlagsST(OPTION_FLAG_DISABLED, true, "Debug_ResetMaids_Toggle")
		MilkQ.MaidReset()
	endEvent
endState

state Debug_ResetMaidsNiO_Toggle
	event OnSelectST()
		SetOptionFlagsST(OPTION_FLAG_DISABLED, true, "Debug_ResetMaidsNiO_Toggle")
		MilkQ.MCMMaidNiOReset()
	endEvent
endState

state Debug_ResetSlaves_Toggle
	event OnSelectST()
		SetOptionFlagsST(OPTION_FLAG_DISABLED, true, "Debug_ResetSlaves_Toggle")
		MilkQ.SlaveReset()
	endEvent
	event OnHighlightST()
		SetInfoText("Milk salves are added by other mods, you probably should not reset this.")
	endEvent
endState

state Debug_ResetVar_Toggle
	event OnSelectST()
		SetOptionFlagsST(OPTION_FLAG_DISABLED, true, "Debug_ResetVar_Toggle")
		MilkQ.VarSetup()
	endEvent
endState

state Debug_Uninstall_Toggle
	event OnSelectST()
		SetOptionFlagsST(OPTION_FLAG_DISABLED, true, "Debug_Uninstall_Toggle")
		MilkQ.UNINSTALL()
	endEvent
endState

state Debug_MilkSuccubusTransform_Toggle
	event OnSelectST()
		if !MilkQ.MilkSuccubusTransform
			MilkQ.MilkSuccubusTransform = true
		else
			MilkQ.MilkSuccubusTransform = false
		endif
		SetToggleOptionValueST(MilkQ.MilkSuccubusTransform)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Debug_H4_S1_Higlight")
	endEvent
endState

state Debug_MilkVampireTransform_Toggle
	event OnSelectST()
		if !MilkQ.MilkVampireTransform
			MilkQ.MilkVampireTransform = true
		else
			MilkQ.MilkVampireTransform = false
		endif
		SetToggleOptionValueST(MilkQ.MilkVampireTransform)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Debug_H4_S2_Higlight")
	endEvent
endState

state Debug_MilkWerewolfTransform_Toggle
	event OnSelectST()
		if !MilkQ.MilkWerewolfTransform
			MilkQ.MilkWerewolfTransform = true
		else
			MilkQ.MilkWerewolfTransform = false
		endif
		SetToggleOptionValueST(MilkQ.MilkWerewolfTransform)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Debug_H4_S3_Higlight")
	endEvent
endState

;state Debug_MilkModToggle_Spell_Toggle
;	event OnSelectST()
;		if !MilkQ.PlayerREF.HasSpell(MilkQ.MilkModToggle)
;			MilkQ.PlayerREF.AddSpell(MilkQ.MilkModToggle)
;		else
;			MilkQ.PlayerREF.RemoveSpell( MilkQ.MilkModToggle )
;		endif
;		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MilkModToggle))
;	endEvent
;endState
		
;state Debug_MilkModInfo_Spell_Toggle
;	event OnSelectST()
;		if !MilkQ.PlayerREF.HasSpell(MilkQ.MilkModInfo)
;			MilkQ.PlayerREF.AddSpell(MilkQ.MilkModInfo)
;		else
;			MilkQ.PlayerREF.RemoveSpell(MilkQ.MilkModInfo)
;		endif
;		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MilkModInfo))
;	endEvent
;endState

state Debug_MilkSelf_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MilkSelf)
			MilkQ.PlayerREF.AddSpell(MilkQ.MilkSelf)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MilkSelf)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MilkSelf))
	endEvent
endState

state Debug_MilkTarget_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MilkTarget)
			MilkQ.PlayerREF.AddSpell(MilkQ.MilkTarget)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MilkTarget)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MilkTarget))
	endEvent
endState

;state Debug_ResetMaids_Spell_Toggle
;	event OnSelectST()
;		if !MilkQ.PlayerREF.HasSpell(MilkQ.MME_ResetMaids)
;			MilkQ.PlayerREF.AddSpell(MilkQ.MME_ResetMaids)
;		else
;			MilkQ.PlayerREF.RemoveSpell(MilkQ.MME_ResetMaids)
;		endif
;		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MME_ResetMaids))
;	endEvent
;endState

;state Debug_ResetMod_Spell_Toggle
;	event OnSelectST()
;		if !MilkQ.PlayerREF.HasSpell(MilkQ.MME_ResetMod)
;			MilkQ.PlayerREF.AddSpell(MilkQ.MME_ResetMod)
;		else
;			MilkQ.PlayerREF.RemoveSpell(MilkQ.MME_ResetMod)
;		endif
;		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MME_ResetMod))
;	endEvent
;endState

;state Debug_Uninstall_Spell_Toggle
;	event OnSelectST()
;		if !MilkQ.PlayerREF.HasSpell(MilkQ.MME_Uninstall)
;			MilkQ.PlayerREF.AddSpell(MilkQ.MME_Uninstall)
;		else
;			MilkQ.PlayerREF.RemoveSpell(MilkQ.MME_Uninstall)
;		endif
;		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MME_Uninstall))
;	endEvent
;endState

state Debug_MM_Maid_IsSlave
	event OnSelectST()
		if StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsSlave") == 0
			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsSlave", 1)
		else
			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsSlave", 0)
		endif
		SetToggleOptionValueST(StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsSlave"))
	endEvent
endState

state Debug_MM_Maid_IsVampire
	event OnSelectST()
		if StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsVampire") == 0
			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsVampire", 1)
		else
			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsVampire", 0)
		endif
		SetToggleOptionValueST(StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsVampire"))
	endEvent
endState

state Debug_MM_Maid_IsWerewolf
	event OnSelectST()
		if StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsWerewolf") == 0
			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsWerewolf", 1)
		else
			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsWerewolf", 0)
		endif
		SetToggleOptionValueST(StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsWerewolf"))
	endEvent
endState

state Debug_MM_Maid_IsSuccubus
	event OnSelectST()
		if StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsSuccubus") == 0
			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsSuccubus", 1)
		else
			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsSuccubus", 0)
		endif
		SetToggleOptionValueST(StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.IsSuccubus"))
	endEvent
endState

state Debug_Debug_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MME_DebugSpell)
			MilkQ.PlayerREF.AddSpell(MilkQ.MME_DebugSpell)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MME_DebugSpell)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MME_DebugSpell))
	endEvent
endState

state Debug_MME_MakeMilkmaid_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MME_MakeMilkmaid_Spell)
			MilkQ.PlayerREF.AddSpell(MilkQ.MME_MakeMilkmaid_Spell)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MME_MakeMilkmaid_Spell)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MME_MakeMilkmaid_Spell))
	endEvent
endState

state Debug_MME_MakeMilkslave_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MME_MakeMilkslave_Spell)
			MilkQ.PlayerREF.AddSpell(MilkQ.MME_MakeMilkslave_Spell)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MME_MakeMilkslave_Spell)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MME_MakeMilkslave_Spell))
	endEvent
endState

state Debug_ArmorMnanagement_ME_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_ME)
			MilkQ.PlayerREF.AddSpell(MilkQ.MME_AM_ME)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MME_AM_ME)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_ME))
	endEvent
endState

state Debug_ArmorMnanagement_BLA_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_BLA)
			MilkQ.PlayerREF.AddSpell(MilkQ.MME_AM_BLA)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MME_AM_BLA)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_BLA))
	endEvent
endState

state Debug_ArmorMnanagement_PLA_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_PLA)
			MilkQ.PlayerREF.AddSpell(MilkQ.MME_AM_PLA)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MME_AM_PLA)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_PLA))
	endEvent
endState

state Debug_ArmorMnanagement_Purge_Spell_Toggle
	event OnSelectST()
		if !MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_Purge)
			MilkQ.PlayerREF.AddSpell(MilkQ.MME_AM_Purge)
		else
			MilkQ.PlayerREF.RemoveSpell(MilkQ.MME_AM_Purge)
		endif
		SetToggleOptionValueST(MilkQ.PlayerREF.HasSpell(MilkQ.MME_AM_Purge))
	endEvent
endState

state ASA1
	event OnSelectST()
		int i = 0
		If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
			MilkQ.Armor_Purge()
		EndIf
		if ArmorlistIndex == 1 
			if MilkQ.MilkingEquipment[i] == Slots[2]
				MilkQ.MilkingEquipment[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.MilkingEquipment[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 2
			if MilkQ.BasicLivingArmor[i] == Slots[2]
				MilkQ.BasicLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.BasicLivingArmor[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 3
			if MilkQ.ParasiteLivingArmor[i] == Slots[2]
				MilkQ.ParasiteLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.ParasiteLivingArmor[i] = Slots[2]
			endif
		endif
		ArmorRefresh()
	endEvent

	event OnHighlightST()
		SetInfoText("Change/Remove armor")
	endEvent
endState

state ASA2
	event OnSelectST()
		int i = 1
		If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
			MilkQ.Armor_Purge()
		EndIf
		if ArmorlistIndex == 1 
			if MilkQ.MilkingEquipment[i] == Slots[2]
				MilkQ.MilkingEquipment[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.MilkingEquipment[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 2
			if MilkQ.BasicLivingArmor[i] == Slots[2]
				MilkQ.BasicLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.BasicLivingArmor[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 3
			if MilkQ.ParasiteLivingArmor[i] == Slots[2]
				MilkQ.ParasiteLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.ParasiteLivingArmor[i] = Slots[2]
			endif
		endif
		ArmorRefresh()
	endEvent

	event OnHighlightST()
		SetInfoText("Change/Remove armor")
	endEvent
endState

state ASA3
	event OnSelectST()
		int i = 2
		If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
			MilkQ.Armor_Purge()
		EndIf
		if ArmorlistIndex == 1 
			if MilkQ.MilkingEquipment[i] == Slots[2]
				MilkQ.MilkingEquipment[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.MilkingEquipment[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 2
			if MilkQ.BasicLivingArmor[i] == Slots[2]
				MilkQ.BasicLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.BasicLivingArmor[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 3
			if MilkQ.ParasiteLivingArmor[i] == Slots[2]
				MilkQ.ParasiteLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.ParasiteLivingArmor[i] = Slots[2]
			endif
		endif
		ArmorRefresh()
	endEvent

	event OnHighlightST()
		SetInfoText("Change/Remove armor")
	endEvent
endState

state ASA4
	event OnSelectST()
		int i = 3
		If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
			MilkQ.Armor_Purge()
		EndIf
		if ArmorlistIndex == 1 
			if MilkQ.MilkingEquipment[i] == Slots[2]
				MilkQ.MilkingEquipment[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.MilkingEquipment[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 2
			if MilkQ.BasicLivingArmor[i] == Slots[2]
				MilkQ.BasicLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.BasicLivingArmor[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 3
			if MilkQ.ParasiteLivingArmor[i] == Slots[2]
				MilkQ.ParasiteLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.ParasiteLivingArmor[i] = Slots[2]
			endif
		endif
		ArmorRefresh()
	endEvent

	event OnHighlightST()
		SetInfoText("Change/Remove armor")
	endEvent
endState

state ASA5
	event OnSelectST()
		int i = 4
		If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
			MilkQ.Armor_Purge()
		EndIf
		if ArmorlistIndex == 1 
			if MilkQ.MilkingEquipment[i] == Slots[2]
				MilkQ.MilkingEquipment[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.MilkingEquipment[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 2
			if MilkQ.BasicLivingArmor[i] == Slots[2]
				MilkQ.BasicLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.BasicLivingArmor[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 3
			if MilkQ.ParasiteLivingArmor[i] == Slots[2]
				MilkQ.ParasiteLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.ParasiteLivingArmor[i] = Slots[2]
			endif
		endif
		ArmorRefresh()
	endEvent

	event OnHighlightST()
		SetInfoText("Change/Remove armor")
	endEvent
endState

state ASA6
	event OnSelectST()
		int i = 5
		If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
			MilkQ.Armor_Purge()
		EndIf
		if ArmorlistIndex == 1 
			if MilkQ.MilkingEquipment[i] == Slots[2]
				MilkQ.MilkingEquipment[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.MilkingEquipment[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 2
			if MilkQ.BasicLivingArmor[i] == Slots[2]
				MilkQ.BasicLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.BasicLivingArmor[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 3
			if MilkQ.ParasiteLivingArmor[i] == Slots[2]
				MilkQ.ParasiteLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.ParasiteLivingArmor[i] = Slots[2]
			endif
		endif
		ArmorRefresh()
	endEvent

	event OnHighlightST()
		SetInfoText("Change/Remove armor")
	endEvent
endState

state ASA7
	event OnSelectST()
		int i = 6
		If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
			MilkQ.Armor_Purge()
		EndIf
		if ArmorlistIndex == 1 
			if MilkQ.MilkingEquipment[i] == Slots[2]
				MilkQ.MilkingEquipment[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.MilkingEquipment[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 2
			if MilkQ.BasicLivingArmor[i] == Slots[2]
				MilkQ.BasicLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.BasicLivingArmor[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 3
			if MilkQ.ParasiteLivingArmor[i] == Slots[2]
				MilkQ.ParasiteLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.ParasiteLivingArmor[i] = Slots[2]
			endif
		endif
		ArmorRefresh()
	endEvent

	event OnHighlightST()
		SetInfoText("Change/Remove armor")
	endEvent
endState

state ASA8
	event OnSelectST()
		int i = 7
		If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
			MilkQ.Armor_Purge()
		EndIf
		if ArmorlistIndex == 1 
			if MilkQ.MilkingEquipment[i] == Slots[2]
				MilkQ.MilkingEquipment[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.MilkingEquipment[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 2
			if MilkQ.BasicLivingArmor[i] == Slots[2]
				MilkQ.BasicLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.BasicLivingArmor[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 3
			if MilkQ.ParasiteLivingArmor[i] == Slots[2]
				MilkQ.ParasiteLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.ParasiteLivingArmor[i] = Slots[2]
			endif
		endif
		ArmorRefresh()
	endEvent

	event OnHighlightST()
		SetInfoText("Change/Remove armor")
	endEvent
endState

state ASA9
	event OnSelectST()
		int i = 8
		If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
			MilkQ.Armor_Purge()
		EndIf
		if ArmorlistIndex == 1 
			if MilkQ.MilkingEquipment[i] == Slots[2]
				MilkQ.MilkingEquipment[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.MilkingEquipment[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 2
			if MilkQ.BasicLivingArmor[i] == Slots[2]
				MilkQ.BasicLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.BasicLivingArmor[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 3
			if MilkQ.ParasiteLivingArmor[i] == Slots[2]
				MilkQ.ParasiteLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.ParasiteLivingArmor[i] = Slots[2]
			endif
		endif
		ArmorRefresh()
	endEvent

	event OnHighlightST()
		SetInfoText("Change/Remove armor")
	endEvent
endState

state ASA10
	event OnSelectST()
		int i = 9
		If MilkQ.MilkingEquipment.Find("") != -1 || MilkQ.MilkingEquipment.Length < 10 || MilkQ.BasicLivingArmor.Find("") != -1 || MilkQ.BasicLivingArmor.Length < 10 || MilkQ.ParasiteLivingArmor.Find("") != -1 || MilkQ.ParasiteLivingArmor.Length < 10
			MilkQ.Armor_Purge()
		EndIf
		if ArmorlistIndex == 1 
			if MilkQ.MilkingEquipment[i] == Slots[2]
				MilkQ.MilkingEquipment[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.MilkingEquipment[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 2
			if MilkQ.BasicLivingArmor[i] == Slots[2]
				MilkQ.BasicLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.BasicLivingArmor[i] = Slots[2]
			endif
		elseif ArmorlistIndex == 3
			if MilkQ.ParasiteLivingArmor[i] == Slots[2]
				MilkQ.ParasiteLivingArmor[i] = "Empty"
			elseif MilkQ.MilkingEquipment.Find(Slots[2]) == -1 && MilkQ.BasicLivingArmor.Find(Slots[2]) == -1 && MilkQ.ParasiteLivingArmor.Find(Slots[2]) == -1 && Slots[2] != "" 
				MilkQ.ParasiteLivingArmor[i] = Slots[2]
			endif
		endif
		ArmorRefresh()
	endEvent

	event OnHighlightST()
		SetInfoText("Change/Remove armor")
	endEvent
endState

state Poll_Interval_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.MilkPoll)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(1, 24)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.MilkPoll = value as int
		SetSliderOptionValueST(MilkQ.MilkPoll, "$MME_MENU_PAGE_Settings_H1_S2.2")
	endEvent

	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H1_S2_Higlight")
	endEvent
endState

state Difficulty_Menu
	event OnMenuOpenST()
		SetMenuDialogStartIndex(PresetIndex)
		SetMenuDialogDefaultIndex(3)
		SetMenuDialogOptions(Preset)
	endEvent

	event OnMenuAcceptST(int index)
		PresetIndex = index
		if PresetIndex == 0
			MilkQ.TimesMilkedMult = 150
		elseif PresetIndex == 1
			MilkQ.TimesMilkedMult = 100
		elseif PresetIndex == 2
			MilkQ.TimesMilkedMult = 75
		elseif PresetIndex == 3
			MilkQ.TimesMilkedMult = 50
		elseif PresetIndex == 4
			MilkQ.TimesMilkedMult = 25
		elseif PresetIndex == 5
			MilkQ.TimesMilkedMult = 10
		endif
		
		SetMenuOptionValueST(Preset[PresetIndex])
		MilkQ.MilkE.InitializeMilkProperties()
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H4_S1_Higlight")
	endEvent
endState

state MaidlistMode_Menu
	event OnMenuOpenST()
		SetMenuDialogStartIndex(MaidlistModeIndex)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(MaidlistMode)
	endEvent

	event OnMenuAcceptST(int index)
		MaidlistModeIndex = index
		int i = 0
		if MaidlistModeIndex == 0
			Maidlist = new string[20]
			MaidlistA = new Actor[20]
			while i < MilkQ.MilkMaid.Length
				if MilkQ.MilkMaid[i] != None
					Maidlist[i] = MilkQ.MilkMaid[i].GetLeveledActorBase().GetName()
					MaidlistA[i] = MilkQ.MilkMaid[i]
					MaidIndex = i
				else
					Maidlist[i] = "--"
				endif
				i = i + 1
			endwhile
		else
			Maidlist = new string[100]
			MaidlistA = new Actor[100]
			while i < MilkQ.MilkSlave.Length
				if MilkQ.MilkSlave[i] != None
					Maidlist[i] = MilkQ.MilkSlave[i].GetLeveledActorBase().GetName()
					MaidlistA[i] = MilkQ.MilkSlave[i]
					MaidIndex = i
				else
					Maidlist[i] = "--"
				endif
				i = i + 1
			endwhile
		endif
		ForcePageReset()
	endEvent
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Debug_Milk_Maid_H1_S2_Higlight")
	endEvent
endState

state BreastScaleMax_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.BoobMax)
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 36.0)
		SetSliderDialogInterval(0.01)
	endEvent

	event OnSliderAcceptST(float value)
 		MilkQ.BoobMax = value as float
		int i = 0
			while i < MilkQ.MilkMaid.Length
				if MilkQ.MilkMaid[i] != None
					MilkQ.CurrentSize(MilkQ.MilkMaid[i])
				endif
				i = i + 1
			endwhile
		SetSliderOptionValueST(MilkQ.BoobMax, "{2}")
	endEvent

	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H2_S1_Higlight")
	endEvent
endState

state BreastCurve_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.BreastCurve)
		SetSliderDialogDefaultValue(0.1)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.BreastCurve = value as float
		int i = 0
			while i < MilkQ.MilkMaid.Length
				if MilkQ.MilkMaid[i] != None
					MilkQ.CurrentSize(MilkQ.MilkMaid[i])
				endif
				i = i + 1
			endwhile
		SetSliderOptionValueST(MilkQ.BreastCurve, "{2}")
	endEvent

	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H2_S2_Higlight")
	endEvent
endState

state BreastIncreasePerLvl_Slider
	event OnSliderOpenST()
		if MilkQ.BreastVolumeScale
			SetSliderDialogStartValue(MilkQ.BoobPerLvl)
			SetSliderDialogDefaultValue(2.0)
			SetSliderDialogRange(0.0, 6.0)
			SetSliderDialogInterval(0.1)
		else
			SetSliderDialogStartValue(MilkQ.BoobPerLvl)
			SetSliderDialogDefaultValue(0.7)
			SetSliderDialogRange(0.0, 3.0)
			SetSliderDialogInterval(0.01)
		endif
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.BoobPerLvl = value
		if MilkQ.BreastVolumeScale
			SetSliderOptionValueST(MilkQ.BoobPerLvl, "{1}")
		else
			SetSliderOptionValueST(MilkQ.BoobPerLvl, "{2}")
		endif
	endEvent
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H2_S4_Higlight")
	endEvent
endState

state BreastIncrease_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.BoobIncr)
		if MilkQ.BreastVolumeScale
			SetSliderDialogDefaultValue(6.0)
			SetSliderDialogRange(0.0, 24.0)
			SetSliderDialogInterval(0.1)
		else
			SetSliderDialogDefaultValue(0.05)
			SetSliderDialogRange(0.0, 0.5)
			SetSliderDialogInterval(0.01)
		endif
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.BoobIncr = value
		if MilkQ.BreastVolumeScale
			SetSliderOptionValueST(MilkQ.BoobIncr, "{1}")
		else
			SetSliderOptionValueST(MilkQ.BoobIncr, "{2}")
		endif
	endEvent
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H2_S3_Higlight")
	endEvent
endState

state LactacidDecayRate_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.LactacidDecayRate)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(-0.01, 1.0)
		SetSliderDialogInterval(0.01)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.LactacidDecayRate = value
		SetSliderOptionValueST(MilkQ.LactacidDecayRate, "{2}")
	endEvent

	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H1_S9_Higlight")
	endEvent
endState

state LactacidMod_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(StorageUtil.GetFloatValue(none,"MME.LactacidMod", missing = 10))
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(1.0, 10.0)
		SetSliderDialogInterval(0.01)
	endEvent

	event OnSliderAcceptST(float value)
		StorageUtil.SetFloatValue(none,"MME.LactacidMod", value)
		SetSliderOptionValueST(value, "{2}")
	endEvent

	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H1_S12_Higlight")
	endEvent
endState

state MilkGenerationValue_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.MilkGenValue)
		SetSliderDialogDefaultValue(0.06)
		SetSliderDialogRange(0.003, 0.30)
		SetSliderDialogInterval(0.003)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.MilkGenValue = value
		SetSliderOptionValueST(MilkQ.MilkGenValue, "$MME_MENU_PAGE_Settings_H1_S7.1")
	endEvent

	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H1_S7_Higlight")
	endEvent
endState

state MaidLevelProgressionAffectsMilkGen_Toggle
	event OnSelectST()
		if StorageUtil.GetIntValue(none,"MME.MaidLevelProgressionAffectsMilkGen") != 1
			StorageUtil.SetIntValue(none,"MME.MaidLevelProgressionAffectsMilkGen", 1)
		else
			StorageUtil.SetIntValue(none,"MME.MaidLevelProgressionAffectsMilkGen", 0)
		endif
		SetToggleOptionValueST(StorageUtil.GetIntValue(none,"MME.MaidLevelProgressionAffectsMilkGen", 0))
	endEvent

	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H1_S13_Higlight")
	endEvent
endState

state NPCComments_Chance_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.MME_NPCComments.GetValue())
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.MME_NPCComments.SetValue(value)
		SetSliderOptionValueST(MilkQ.MME_NPCComments.GetValue(), "{2}%")
	endEvent

	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H3_S3_Higlight")
	endEvent
endState

state PainSystem_Toggle
	event OnSelectST()
		if !MilkQ.PainSystem
			MilkQ.PainSystem = true
		else
			MilkQ.PainSystem = false
		endif
		SetToggleOptionValueST(MilkQ.PainSystem)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Milking_Pain_System_Higlight")
	endEvent
endState

state PainHurts_Toggle
	event OnSelectST()
		if !MilkQ.PainKills
			MilkQ.PainKills = true
		else
			MilkQ.PainKills = false
		endif
		SetToggleOptionValueST(MilkQ.PainKills)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Milking_Pain_Hurts_Higlight")
	endEvent
endState

state MilkingDrainsSP_Toggle
	event OnSelectST()
		if !MilkQ.MilkingDrainsSP
			MilkQ.MilkingDrainsSP = true
		else
			MilkQ.MilkingDrainsSP = false
		endif
		SetToggleOptionValueST(MilkQ.MilkingDrainsSP)
	endEvent
endState

state MilkingDrainsMP_Toggle
	event OnSelectST()
		if !MilkQ.MilkingDrainsMP
			MilkQ.MilkingDrainsMP = true
		else
			MilkQ.MilkingDrainsMP = false
		endif
		SetToggleOptionValueST(MilkQ.MilkingDrainsMP)
	endEvent
endState
		
state ECTrigger_Toggle
	event OnSelectST()
		if !MilkQ.ECTrigger
			MilkQ.ECTrigger = true
		else
			MilkQ.ECTrigger = false
		endif
		SetToggleOptionValueST(MilkQ.ECTrigger)
	endEvent
endState

state ECCrowdControl_Toggle
	event OnSelectST()
		if !MilkQ.ECCrowdControl
			MilkQ.ECCrowdControl = true
		else
			MilkQ.ECCrowdControl = false
		endif
		SetToggleOptionValueST(MilkQ.ECCrowdControl)
	endEvent
endState

state SimpleMilk_Toggle
	event OnSelectST()
		if !MilkQ.MilkQC.MME_SimpleMilkPotions
			MilkQ.MilkQC.MME_SimpleMilkPotions = true
		else
			MilkQ.MilkQC.MME_SimpleMilkPotions = false
		endif
		SetToggleOptionValueST(MilkQ.MilkQC.MME_SimpleMilkPotions)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Milking_H3_S13_Higlight")
	endEvent
endState

state MilkingReq40PctMilk_Toggle
	event OnSelectST()
		if !MilkQ.MilkingReq40PctMilk
			MilkQ.MilkingReq40PctMilk = true
		else
			MilkQ.MilkingReq40PctMilk = false
		endif
		SetToggleOptionValueST(MilkQ.MilkingReq40PctMilk)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Milking_H3_S18_Higlight")
	endEvent
endState

state MobileMilkingAnims_Toggle
	event OnSelectST()
		if !MilkQ.MobileMilkingAnims
			MilkQ.MobileMilkingAnims = true
		else
			MilkQ.MobileMilkingAnims = false
		endif
		SetToggleOptionValueST(MilkQ.MobileMilkingAnims)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Milking_H3_S20_Higlight")
	endEvent
endState

state CumProduction_Toggle
	event OnSelectST()
		if !MilkQ.CumProduction
			MilkQ.CumProduction = true
		else
			MilkQ.CumProduction = false
		endif
		SetToggleOptionValueST(MilkQ.CumProduction)
	endEvent
endState

state Milking_MilkWithZaZMoMSuctionCups_Toggle
	event OnSelectST()
		string toggleVal
		if !MilkQ.MilkNaked && !MilkQ.MilkWithZaZMoMSuctionCups
			MilkQ.MilkNaked = true
			MilkQ.MilkWithZaZMoMSuctionCups = false
			toggleVal = "$MME_MENU_PAGE_Milking_H3_S5.1"
		elseif !MilkQ.MilkWithZaZMoMSuctionCups
			MilkQ.MilkNaked = false
			MilkQ.MilkWithZaZMoMSuctionCups = true
			toggleVal = "$MME_MENU_PAGE_Milking_H3_S5.2"
		else
			MilkQ.MilkNaked = false
			MilkQ.MilkWithZaZMoMSuctionCups = false
			toggleVal = "$MME_MENU_PAGE_Milking_H3_S5.3"
		endif
		SetTextOptionValueST(toggleVal)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Milking_H3_S5_Higlight")
	endEvent
endState

;state FutaMilkCuirass_Toggle
;	event OnSelectST()
;		if !MilkQ.UseFutaMilkCuirass
;			MilkQ.UseFutaMilkCuirass = true
;		else
;			MilkQ.UseFutaMilkCuirass = false
;		endif
;		SetToggleOptionValueST(MilkQ.UseFutaMilkCuirass)
;	endEvent
;endState

state Feeding_Toggle
	event OnSelectST()
		if !MilkQ.Feeding
			MilkQ.Feeding = true
		else
			MilkQ.Feeding = false
		endif
		SetToggleOptionValueST(MilkQ.Feeding)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Milking_H3_S8_Higlight")
	endEvent
endState

state ForcedFeeding_Toggle
	event OnSelectST()
		if !MilkQ.ForcedFeeding
			MilkQ.ForcedFeeding = true
		else
			MilkQ.ForcedFeeding = false
		endif
		SetToggleOptionValueST(MilkQ.ForcedFeeding)
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Milking_H3_S14_Higlight")
	endEvent
endState

state Feeding_Sound_Toggle
	event OnSelectST()
		string toggleVal
		if MilkQ.Feeding_Sound == 0
			MilkQ.Feeding_Sound = 1
			toggleVal = "$MME_MENU_PAGE_Milking_H3_S12.2"
		elseif MilkQ.Feeding_Sound == 1
			MilkQ.Feeding_Sound = 2
			toggleVal = "$MME_MENU_PAGE_Milking_H3_S12.3"
		elseif MilkQ.Feeding_Sound == 2
			MilkQ.Feeding_Sound = 0
			toggleVal = "$MME_MENU_PAGE_Milking_H3_S12.1"
		endif
		SetTextOptionValueST(toggleVal)
	endEvent
endState

state Debug_MM_Maid_MilkingMode
	event OnSelectST()
		string toggleVal
		if StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingMode") == 0
			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingMode", 1)
			toggleVal = "$MME_MENU_PAGE_Debug_Milk_Maid_MilkingMode.1"
		elseif StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingMode") == 1
			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingMode", 2)
			toggleVal = "$MME_MENU_PAGE_Debug_Milk_Maid_MilkingMode.2"
		elseif StorageUtil.GetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingMode") == 2
			StorageUtil.SetIntValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingMode", 0)
			toggleVal = "$MME_MENU_PAGE_Debug_Milk_Maid_MilkingMode.0"
		endif
		SetTextOptionValueST(toggleVal)
	endEvent
endState

state FuckMachine_Toggle
	event OnSelectST()
		if !MilkQ.FuckMachine
			MilkQ.FuckMachine = true
		else
			MilkQ.FuckMachine = false
		endif
		SetToggleOptionValueST(MilkQ.FuckMachine)
	endEvent
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Milking_H3_S10_Higlight")
	endEvent
endState

state Milking_Duration_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.Milking_Duration)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(1, 300)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.Milking_Duration = value as int
		SetSliderOptionValueST(MilkQ.Milking_Duration, "$MME_MENU_PAGE_Milking_H3_S7.2")
	endEvent
endState

state Milking_GushPct_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.GushPct)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(5)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.GushPct = value as Int
		SetSliderOptionValueST(MilkQ.GushPct, "{2}" + "%")
	endEvent
	
	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Milking_H3_S16_Higlight")
	endEvent
endState

state Feeding_Duration_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.Feeding_Duration)
		SetSliderDialogDefaultValue(30)
		SetSliderDialogRange(1, 60)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.Feeding_Duration = value as int
		SetSliderOptionValueST(MilkQ.Feeding_Duration, "$MME_MENU_PAGE_Milking_H3_S9.2")
	endEvent

	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Milking_H3_S9_Higlight")
	endEvent
endState

state FuckMachine_Duration_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.FuckMachine_Duration)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(1, 300)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.FuckMachine_Duration = value as int
		SetSliderOptionValueST(MilkQ.FuckMachine_Duration, "$MME_MENU_PAGE_Milking_H3_S11.2")
	endEvent
endState

state ECRange_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.ECRange)
		SetSliderDialogDefaultValue(500)
		SetSliderDialogRange(0, 500)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.ECRange = value as int
		SetSliderOptionValueST(MilkQ.ECRange, "{0}")
	endEvent

	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Settings_H3_S3_Higlight")
	endEvent
endState

state Debug_MilkProductionMod_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.MilkProdMod)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 200)
		SetSliderDialogInterval(10)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.MilkProdMod = value as Float
		SetSliderOptionValueST(MilkQ.MilkProdMod, "{0}%")
	endEvent
endState

state Debug_MilkPriceMod_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.MilkPriceMod)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(1, 10)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.MilkPriceMod = value as int
		SetSliderOptionValueST(MilkQ.MilkPriceMod, "{0}")
	endEvent

	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Debug_H2_S2_Higlight")
	endEvent
endState

state Debug_ExhaustionSleepMod_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.ExhaustionSleepMod)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 5)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.ExhaustionSleepMod = value as int
		SetSliderOptionValueST(MilkQ.ExhaustionSleepMod, "{0}")
	endEvent

	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Debug_H2_S6_Higlight")
	endEvent
endState

state Debug_Mastery_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(StorageUtil.GetFloatValue(none,"MME.Progression.Level"))
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 40)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		StorageUtil.SetFloatValue(none,"MME.Progression.Level", value )
		SetSliderOptionValueST(StorageUtil.GetFloatValue(none,"MME.Progression.Level"))
	endEvent
endState

state Debug_TimesMilked_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(StorageUtil.GetFloatValue(none,"MME.Progression.TimesMilked"))
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		StorageUtil.SetFloatValue(none,"MME.Progression.TimesMilked", value )
		SetSliderOptionValueST(StorageUtil.GetFloatValue(none,"MME.Progression.TimesMilked"))
	endEvent
endState

state Debug_TimesMilked_Overall_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(StorageUtil.GetFloatValue(none,"MME.Progression.TimesMilkedAll"))
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		StorageUtil.SetFloatValue(none,"MME.Progression.TimesMilkedAll", value )
		SetSliderOptionValueST(StorageUtil.GetFloatValue(none,"MME.Progression.TimesMilkedAll"))
	endEvent
endState

state Debug_MM_MaidLevel_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MME_Storage.getMaidLevel(MaidlistA[MaidIndex]))
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MME_Storage.setMaidLevel(MaidlistA[MaidIndex], value as int)
		MilkQ.CurrentSize(MaidlistA[MaidIndex])
		SetSliderOptionValueST(value)
	endEvent
endState

state Debug_MM_MaidTimesMilked_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.TimesMilked"))
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		StorageUtil.SetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.TimesMilked", value)
		SetSliderOptionValueST(StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.TimesMilked"))
	endEvent
endState

state Debug_MM_Maid_BreastBaseSize_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MME_Storage.getBreastsBasevalue(MaidlistA[MaidIndex]))
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(0, 3)
		SetSliderDialogInterval(0.1)
	endEvent

	event OnSliderAcceptST(float value)
		MME_Storage.setBreastsBasevalue(MaidlistA[MaidIndex], value)
		SetSliderOptionValueST(value, "{2}")
	endEvent
endState

state Debug_MM_Maid_BreastRows_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MME_Storage.getBreastRows(MaidlistA[MaidIndex]))
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(1, 4)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		; may return a different value if provided value is invalid
		int BreastRows = MME_Storage.setBreastRows(MaidlistA[MaidIndex], value as int)
		SetSliderOptionValueST(BreastRows)
		MilkQ.MultiBreastChange(MaidlistA[MaidIndex])
	endEvent
endState

state Debug_MM_Maid_MaidBoobIncr_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.BoobIncr"))
		SetSliderDialogDefaultValue(0.05)
		SetSliderDialogRange(-1, 24.0)
		SetSliderDialogInterval(0.01)
	endEvent

	event OnSliderAcceptST(float value)
		if value != 0
			StorageUtil.SetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.BoobIncr", value)
		else
			StorageUtil.UnsetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.BoobIncr")
		endif
		SetSliderOptionValueST(StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.BoobIncr"), "{2}")
	endEvent
	event OnHighlightST()
		SetInfoText("$MME_Slider_Highlight_Disable")
	endEvent
endState

state Debug_MM_Maid_MaidBoobPerLvl_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.BoobPerLvl"))
		SetSliderDialogDefaultValue(0.07)
		SetSliderDialogRange(-1, 6.0)
		SetSliderDialogInterval(0.01)
	endEvent

	event OnSliderAcceptST(float value)
		if value != 0
			StorageUtil.SetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.BoobPerLvl", value)
		else
			StorageUtil.UnsetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.BoobPerLvl")
		endif
		SetSliderOptionValueST(StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.BoobPerLvl"), "{2}")
	endEvent
	event OnHighlightST()
		SetInfoText("$MME_Slider_Highlight_Disable")
	endEvent
endState

state Debug_MM_Maid_BreastBaseSizeModified_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MME_Storage.getBreastsBaseadjust(MaidlistA[MaidIndex]))
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 3)
		SetSliderDialogInterval(0.1)
	endEvent

	event OnSliderAcceptST(float value)
		MME_Storage.setBreastsBaseadjust(MaidlistA[MaidIndex], value)
		SetSliderOptionValueST(value, "{2}")
	endEvent
endState

state Debug_MM_LactacidCount_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MME_Storage.getLactacidCurrent(MaidlistA[MaidIndex]))
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(0.01)
	endEvent

	event OnSliderAcceptST(float value)
		MME_Storage.setLactacidCurrent(MaidlistA[MaidIndex], value)
		MilkQ.CurrentSize(MaidlistA[MaidIndex])
		SetSliderOptionValueST(value, "{2}")
	endEvent
endState

state Debug_MM_PainCount_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MME_Storage.getPainCurrent(MaidlistA[MaidIndex]))
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(0.01)
	endEvent

	event OnSliderAcceptST(float value)
		MME_Storage.setPainCurrent(MaidlistA[MaidIndex], value)
		SetSliderOptionValueST(value, "{2}")
	endEvent
endState

state Debug_MM_MaidContainerCum_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingContainerCumsSUM"))
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		StorageUtil.SetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingContainerCumsSUM", value)
		SetSliderOptionValueST(StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingContainerCumsSUM"))
	endEvent
endState

state Debug_MM_MaidContainerMilk_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingContainerMilksSUM"))
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		StorageUtil.SetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingContainerMilksSUM", value)
		SetSliderOptionValueST(StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingContainerMilksSUM"))
	endEvent
endState

state Debug_MM_MaidContainerLactacid_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingContainerLactacid"))
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		StorageUtil.SetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingContainerLactacid", value)
		SetSliderOptionValueST(StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkingContainerLactacid"))
	endEvent
endState

state Debug_MM_MilkCount_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MME_Storage.getMilkCurrent(MaidlistA[MaidIndex]))
		SetSliderDialogDefaultValue(0)
		if MilkQ.BreastScaleLimit
			; use maximum milk limit as maximum value for slider
			; (so it is no longer possible to have a maid with 'MilkCurrent > MilkMaximum')
			SetSliderDialogRange(0, MME_Storage.getMilkMaximum(MaidlistA[MaidIndex]))
		else
			SetSliderDialogRange(0, 100)
		endif
		SetSliderDialogInterval(0.01)
	endEvent

	event OnSliderAcceptST(float value)
		; guaranteed to be 'x <= MilkMax' (if the limit applies)
		MME_Storage.setMilkCurrent(MaidlistA[MaidIndex], value, MilkQ.BreastScaleLimit)
		MilkQ.CurrentSize(MaidlistA[MaidIndex])
		SetSliderOptionValueST(value, "{2}")
	endEvent
endState

state Debug_MM_MilkMax_Basevalue_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MME_Storage.getMilkMaxBasevalue(MaidlistA[MaidIndex]))
		SetSliderDialogDefaultValue(2)
		SetSliderDialogRange(0, 20)
		SetSliderDialogInterval(0.25)
	endEvent

	event OnSliderAcceptST(float value)
		MME_Storage.setMilkMaxBasevalue(MaidlistA[MaidIndex], value)
		SetSliderOptionValueST(value, "{2}")
	endEvent
endState

state Debug_MM_MilkMax_Scalefactor_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MME_Storage.getMilkMaxScalefactor(MaidlistA[MaidIndex]))
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(-5, 5)
		SetSliderDialogInterval(0.05)
	endEvent

	event OnSliderAcceptST(float value)
		MME_Storage.setMilkMaxScalefactor(MaidlistA[MaidIndex], value)
		SetSliderOptionValueST(value, "{2}")
	endEvent
endState

state Debug_MM_MilkGeneration_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkGen"))
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 25)
		SetSliderDialogInterval(0.001)
	endEvent

	event OnSliderAcceptST(float value)
		StorageUtil.SetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkGen", value)
		SetSliderOptionValueST(StorageUtil.GetFloatValue(MaidlistA[MaidIndex],"MME.MilkMaid.MilkGen")/3/10, "{3}")
		ForcePageReset()
	endEvent
endState

;state Debug_MM_MilkGeneration_Slider
;	event OnSliderOpenST()
;		SetSliderDialogStartValue(MME_Storage.getMilkProdPerHour(MaidlistA[MaidIndex]))
;		SetSliderDialogDefaultValue(0.05)
;		SetSliderDialogRange(0.0, MME_Storage.getMilkMaxProdPerHour(MaidlistA[MaidIndex]))
;
;		SetSliderDialogInterval(0.01)
;	endEvent
;
;	event OnSliderAcceptST(float value)
;		float MilkProdPerHour = MME_Storage.setMilkProdPerHour(MaidlistA[MaidIndex], Value)
;
;		SetSliderOptionValueST(MilkProdPerHour, "{2}")
;		ForcePageReset()
;	endEvent
;endState

state ArmorSupport_Armorlist_Menu
	event OnMenuOpenST()
		SetMenuDialogStartIndex(ArmorlistIndex)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(Armorlist)
	endEvent

	event OnMenuAcceptST(int index)
		ArmorlistIndex = index
		SetMenuOptionValueST(Armorlist[ArmorlistIndex])
		ArmorRefresh()
	endEvent
endState

state ArmorSupport_ArmorSlotList_Menu ; not active
	event OnMenuOpenST()
		SetMenuDialogStartIndex(ArmorSlotListIndex)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(ArmorSlotList)
	endEvent

	event OnMenuAcceptST(int index)
		ArmorSlotListIndex = index
		SetMenuOptionValueST(ArmorSlotList[ArmorSlotListIndex])
	endEvent
endState

state Debug_Milk_Maid_Menu
	event OnMenuOpenST()
		SetMenuDialogStartIndex(MaidIndex)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(Maidlist)
	endEvent

	event OnMenuAcceptST(int index)
		MaidIndex = index
		if MaidIndex != -1
			SetMenuOptionValueST(Maidlist[MaidIndex])
			ForcePageReset()
		else 
			MaidIndex = 0
			SetMenuOptionValueST(Maidlist[MaidIndex])
			ForcePageReset()
		endif
	endEvent

	event OnHighlightST()
		SetInfoText("$MME_MENU_PAGE_Debug_Milk_Maid_H1_S2_Higlight")
	endEvent
endState

state Spell_Constructor_BreastRowChance_Slider
	event OnSliderOpenST()
		SetSliderDialogStartValue(MilkQ.MilkQC.BrestEnlargement_MultiBreast_Effect)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		MilkQ.MilkQC.BrestEnlargement_MultiBreast_Effect = value as int
		SetSliderOptionValueST(value)
	endEvent
endState

state Hotkey
	event OnKeyMapChangeST(int newKeyCode, string conflictControl, string conflictName)
		MilkQ.UnregisterForAllKeys()
		MilkQ.UnregisterForCrosshairRef()
		bool continue = true
 
		; Check for conflict
		if conflictControl != ""
			string msg
			if conflictName != ""
				msg = "This key is already mapped to:\n'" + conflictControl + "'\n(" + conflictName + ")\n\n Are you sure you want to continue?"
			else
				msg = "This key is already mapped to:\n'" + conflictControl + "'\n\n Are you sure you want to continue?"
			endIf
			continue = ShowMessage(msg, true, "Yes", "No")
		endIf

		; Set allowed key change
		if continue
			MilkQ.NotificationKey = newKeyCode
			SetKeyMapOptionValueST(newKeyCode)
		endIf
		MilkQ.RegisterForKey(MilkQ.NotificationKey)
		MilkQ.RegisterForCrosshairRef()
	endEvent

	event OnHighlightST()
		SetInfoText("Key ID " + MilkQ.NotificationKey + "\n Shows information about player/target milk maid: Milk, Pain, Lactacid amount. \n Holding Notification Key for 2 seconds toggles self/target milking OR pressing Notification Key with L/R Shift. \n If hold during milking - returns control to player. \n If pressed during milking and both shifts - aborts milking.")
	endEvent
endState
