Scriptname SOS_TrollololScript extends activemagiceffect  

;----------CORE PROPERTIES----------

SOS_SetupQuest_Script Property SOS_Quest  Auto

FormList Property SOS_Factions Auto

;----------OTHER PROPERTIES----------

Faction Property SOS_SchlongifiedFaction Auto
Keyword Property SOS_Merchant Auto

;----------EVENTS----------

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	If !akTarget.HasKeyword(SOS_Merchant)
		SOS_Quest.ScaleSchlongBones(SOS_Quest.GetActiveAddon(akTarget), akTarget, 0)
	EndIf

endEvent