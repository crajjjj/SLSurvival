Scriptname SOS_IncreaseSizeMagicEffect_Script extends activemagiceffect  

;----------CORE PROPERTIES----------

SOS_SetupQuest_Script Property SOS_Quest  Auto

FormList Property SOS_Factions Auto  ; DEPRECATED

;----------ACTOR PROPERTIES----------

Faction Property SOS_SchlongifiedFaction Auto
Keyword Property SOS_Merchant Auto
SOS_Config Property config Auto

;----------EVENTS----------

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	Form addon = SOS_Quest.GetActiveAddon(akTarget)
	Faction kSchlongFaction = SOS_Data.GetFaction(addon)
	int iSizeRank = akTarget.GetFactionRank(kSchlongFaction) as int
	
	;Debug.TraceAndBox("SOS increase size:" + akTarget.GetLeveledActorBase().GetName() + " " + iSizeRank + " " + akTarget.HasKeyword(SOS_Merchant) + " " + akTarget.HasKeywordString("SOS_Merchant"))
	if(iSizeRank < config.iMaxSchlongSize || (akTarget.HasKeyword(SOS_Merchant) && iSizeRank < 20))
		iSizeRank += 1
		SOS_Quest.SetSchlongSize(addon, akTarget, iSizeRank)
	endIf

endEvent
