Scriptname SOS_Debug extends activemagiceffect  

;----------PROPERTIES----------

SOS_SetupQuest_Script Property SOS_Quest Auto
SOS_Config Property config Auto

MagicEffect Property SOS_ActorMagicEffect Auto
MagicEffect Property SOS_ErectionMagicEffect Auto
MagicEffect Property SOS_ErectionNPCMagicEffect Auto
Spell Property SOS_SetupSpell Auto
Spell Property SOS_ActorSpell Auto
Faction Property SOS_SchlongifiedFaction Auto
Keyword Property SOS_Revealing Auto
Keyword Property SOS_Concealing Auto

;----------EVENTS----------

Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	Actor PlayerRef = Game.GetPlayer()

	int i = 0
	int n = 0
	bool b = False
	
	;----------VERSION----------
	String version = SOS_Quest.SOS_VersionInt
	version = StringUtil.Substring(version, 0, 1) + "." + StringUtil.Substring(version, 1, 2) + "." + StringUtil.Substring(version, 3, 3)

	;----------ACTOR----------
	string ActorName = akTarget.GetLeveledActorBase().GetName()
	
	;----------GENDER----------
	string ActorGender = "No Gender"
	i = akTarget.GetLeveledActorBase().GetSex()
	If (i == 0)
		ActorGender = "Male"
	elseif (i == 1)
		ActorGender = "Female"
	endIf
	
	;----------RACE----------
	string ActorRace = akTarget.GetRace().GetName() + " (" + akTarget.GetRace().GetFormID() + ")"

	;----------MAGIC AND ERECTION EFFECT-------
	bool ErectionMagic = false
	if(akTarget == akCaster)
		ErectionMagic = akTarget.HasMagicEffect(SOS_ErectionMagicEffect)
	else
		; npc will have the ErectionMagicEffect if started via dialog, and the ErectionNPCMagicEffect if started via erection spell
		ErectionMagic = akTarget.HasMagicEffect(SOS_ErectionMagicEffect) || akTarget.HasMagicEffect(SOS_ErectionNPCMagicEffect)
	endif
	
	bool ActorMagic = akTarget.HasMagicEffect(SOS_ActorMagicEffect)
	
	bool ActorSpell = akTarget.HasSpell(SOS_ActorSpell)

	;----------SETUP SPELL----------
	bool SetupSpell = PlayerRef.HasSpell(SOS_SetupSpell)
	;bool SetupSpellEnabled = config.bSchlongificationEnabled todo check if active magic effect
	
	;----------ADDONS----------
	i = 0
	int CountAddons = SOS_Data.CountAddons()
	int addonsOK = 0
	While i < CountAddons
		If SOS_Data.GetAddon(i)
			addonsOK += 1
		EndIf
		i += 1
	EndWhile
	
	;----------FACTION AND FACTION RANK----------
	string ActorFaction = "None"
	string ActorFactionRank = "N/A"
	Form addon = SOS_Quest.GetActiveAddon(akTarget)
	Faction sosFaction = SOS_Data.GetFaction(addon)
	if sosFaction && akTarget.IsInFaction(sosFaction)
		ActorFaction = sosFaction.GetName()
	endIf
	If sosFaction
		ActorFactionRank = akTarget.GetFactionRank(sosFaction)
	EndIf
	
	;----------SCHLONGIFIED AND SCHLONGIFIED RANK----------
	string ActorSchlongified = "None"
	string ActorSchlongifiedRank = "N/A"
	If akTarget.IsInFaction(SOS_SchlongifiedFaction)
		ActorSchlongified = SOS_SchlongifiedFaction.GetName()
	EndIf
	ActorSchlongifiedRank = akTarget.GetFactionRank(SOS_SchlongifiedFaction)
	
	;----------ADDON FORMLIST----------
	bool schlonged = SOS_Data.FindSchlonged(addon, akTarget) > -1
	
	bool blacklisted = SOS_Data.FindBlacklisted(akTarget) > -1
	
	;----------ARMOR----------
	Armor bodyArmor = akTarget.GetWornForm(0x00000004) as Armor
	int SlotMask = 0
	int bodyArmorID = 0
	bool revealingKeyword = False
	bool concealingFormList = False
	bool revealingFormList = False
	If bodyArmor
		SlotMask = bodyArmor.GetSlotMask()
		bodyArmorID = bodyArmor.GetFormID()
		revealingKeyword = bodyArmor.HasKeyWord(SOS_Revealing)
		concealingFormList = SOS_SKSE.IsInConcealingList(bodyArmor)
		revealingFormList = SOS_SKSE.IsRevealing(bodyArmor) && !revealingKeyword
	EndIf
	
	String msg = "SOS version " + version
	msg += "\nActor: " + ActorName + ", " + ActorGender
	msg += "\nRace: " + ActorRace
	msg += "\nActor Spell: " + ActorSpell + "," + ActorMagic + ", Erection: " + ErectionMagic
	msg += "\nPC Setup Spell: " + SetupSpell ; + " , Enabled: " + SetupSpellEnabled
	msg += "\nAddons: " + CountAddons + ", OK: " + addonsOK
	msg += "\nFaction: " + ActorFaction + ", Rank: " + ActorFactionRank
	msg += "\nSchlongified: " + ActorSchlongified + ", Rank: " + ActorSchlongifiedRank
	msg += "\nSchlonged by addon: " + schlonged + ", Blacklist: " + blacklisted
	msg += "\nArmor: " + bodyArmorID + ", SlotMask: " + SlotMask
	msg += "\nArmor revealing: keyword " + revealingKeyword + ", list " + revealingFormList
	msg += "\nArmor concealing list: " + concealingFormList

	Debug.TraceAndBox(msg) ; todo translate

EndEvent
