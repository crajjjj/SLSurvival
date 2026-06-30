scriptName zadEventArmorRestraints extends zadBaseEvent

Bool Function HasKeywords(actor akActor)
	 Return (akActor.WornHasKeyword(libs.zad_Lockable) && akActor.GetWornForm(0x00000004) != None )
EndFunction

Function Execute(actor akActor)
	String outfitType = "clothes"
	If akActor.GetWornForm(0x00000004).HasKeywordString("ArmorCuirass")
		outfitType = "armor"
	EndIf
	libs.Moan(akActor)
	libs.NotifyPlayer("Your restraints brush against your " + outfitType + ", reminding you of their presence.")
EndFunction
