Scriptname SOS_DecreaseSizeMagicEffect_Script extends activemagiceffect  

;----------CORE PROPERTIES----------

SOS_SetupQuest_Script Property SOS_Quest  Auto

FormList Property SOS_Factions Auto ; DEPRECATED

;----------OTHER PROPERTIES----------

Faction Property SOS_SchlongifiedFaction Auto ; DEPRECATED

;----------EVENTS----------

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	Form addon = SOS_Quest.GetActiveAddon(akTarget)
	Faction kSchlongFaction = SOS_Data.GetFaction(addon) as Faction
	int iSizeRank = akTarget.GetFactionRank(kSchlongFaction) as int
	
	if (iSizeRank > 1)
		iSizeRank -= 1
		SOS_Quest.SetSchlongSize(addon, akTarget, iSizeRank)
	endif

endEvent