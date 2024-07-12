Scriptname _SLS_IntSlsf extends Quest Hidden

Function IncreaseSexFame(Quest FameQuest, String Name, Int[] FameList, Float Multiplier) Global ; Hard sets fame to this value - NOT increase existing values
	(FameQuest as SLSF_CompatibilityScript).RequestFameModEvent(Name, FameList, Multiplier)
EndFunction

Function RequestModFameValueByCurrent(Quest FameQuest, Int FameNum, Int Many, Bool ApplyUserMod = True, Int LimitMin = 0, Int LimitMax = 100) Global
	; Int FameGroup, Identify the Fame NPC(0) or PC(1) - Hard set to 1 as I don't think I'll ever need to set Npc fame. 
	; Int FameNum, Identify the Fame Num to increase, See the Fame Reference Chart
	; Int Many, The Amount of Fame to add/subtract
	; Bool ApplyUserMod, Apply or not the User Multplier for the Fame Gain/Lost, Default True
	; Int LimitMin, Minimum Limit that the Fame level could reach with that Decrease, Default 0
	; Int LimitMax, Maxium limit that the Fame level could reach with that Increase, Default 100

	(FameQuest as SLSF_CompatibilityScript).RequestModFameValueByCurrent(FameGroup = 1, FameNum = FameNum, Many = Many, ApplyUserMod = ApplyUserMod, LimitMin = LimitMin, LimitMax = LimitMax)
EndFunction
