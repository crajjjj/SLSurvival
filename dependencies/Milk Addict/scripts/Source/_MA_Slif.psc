Scriptname _MA_Slif extends Quest  

_MA_Mcm Property Menu Auto

Actor Property PlayerRef Auto

; General
Function IF_SetMaSlifDefaults()
	SLIF_Main.SetMinValue(PlayerRef, "Milk Addict", "slif_butt", Menu.BaseAssScale as Float)
	SLIF_Main.SetMaxValue(PlayerRef, "Milk Addict", "slif_butt", Menu.AssMaxScale)
EndFunction

Function IF_ResetMaSlif()
	SLIF_Main.UnregisterActor(PlayerRef, "Milk Addict")
EndFunction

; Ass
Float Function IF_GetSlifAss() ; Return overall butt scale value
	Return SLIF_Main.GetValue(PlayerRef, "ALL MODS", "slif_butt", default = 0.0)
EndFunction

Float Function IF_GetMaSlifAss() ; Return Milk Addicts butt scale value
	Return SLIF_Main.GetValue(PlayerRef, "Milk Addict", "slif_butt", default = 0.0)
EndFunction

Function IF_InflateMaSlifAss(Float ScaleAmount)
	SLIF_Main.Inflate(PlayerRef, "Milk Addict", "slif_butt", ScaleAmount);, -1, -1, minimum = (Menu.BaseAssScale as Float), maximum = Menu.AssMaxScale)
EndFunction

; Belly
Float Function IF_GetSlifBelly() ; Return overall belly scale value
	Return SLIF_Main.GetValue(PlayerRef, "ALL MODS", "slif_belly", default = 0.0)
EndFunction