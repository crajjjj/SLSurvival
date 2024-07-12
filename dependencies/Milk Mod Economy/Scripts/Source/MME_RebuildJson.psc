Scriptname MME_RebuildJson Hidden


function MME_JsonRebuild() global
	;Scripts Status
	JsonUtil.SetStringValue("/MME/Strings", "mme_status", "MilkModEconomy has failed script check, scripts are not running/broken(most likely mod was not installed correctly), script will retry check in 60 sec")

	;Economy
	JsonUtil.SetFormValue("/MME/Forms", "haggling00", Game.GetFormFromFile(0xBE128 , "Skyrim.esm"))
	JsonUtil.SetFormValue("/MME/Forms", "haggling20", Game.GetFormFromFile(0xC07CE, "Skyrim.esm"))
	JsonUtil.SetFormValue("/MME/Forms", "haggling40", Game.GetFormFromFile(0xC07CF, "Skyrim.esm"))
	JsonUtil.SetFormValue("/MME/Forms", "haggling60", Game.GetFormFromFile(0xC07D0, "Skyrim.esm"))
	JsonUtil.SetFormValue("/MME/Forms", "haggling80", Game.GetFormFromFile(0xC07D1, "Skyrim.esm"))
	JsonUtil.SetFormValue("/MME/Forms", "gold", Game.GetFormFromFile(0x0F, "Skyrim.esm"))

	;Economy Location names
	JsonUtil.StringListAdd("/MME/Strings", "orcstrongholds", Game.GetFormFromFile(0x1927C, "Skyrim.esm").GetName(), false)	;MorKhazgur
	JsonUtil.StringListAdd("/MME/Strings", "orcstrongholds", Game.GetFormFromFile(0x19171, "Skyrim.esm").GetName(), false)	;DushnikhYal
	JsonUtil.StringListAdd("/MME/Strings", "orcstrongholds", Game.GetFormFromFile(0x19282, "Skyrim.esm").GetName(), false)	;Narzulbur
	JsonUtil.StringListAdd("/MME/Strings", "orcstrongholds", Game.GetFormFromFile(0x19263, "Skyrim.esm").GetName(), false)	;Largashbur

	JsonUtil.StringListAdd("/MME/Strings", "falkreath", Game.GetFormFromFile(0x18A49, "Skyrim.esm").GetName(), false)	;Falkreath
	JsonUtil.StringListAdd("/MME/Strings", "falkreath", Game.GetFormFromFile(0x5CA26, "Skyrim.esm").GetName(), false)	;DeadMansDrink
	JsonUtil.StringListAdd("/MME/Strings", "falkreath", Game.GetFormFromFile(0x308A, "HearthFires.esm").GetName(), false)	;LakeviewManor \ HearthFires
	
	JsonUtil.StringListAdd("/MME/Strings", "dawnstar", Game.GetFormFromFile(0x18A50, "Skyrim.esm").GetName(), false)	;Dawnstar
	JsonUtil.StringListAdd("/MME/Strings", "dawnstar", Game.GetFormFromFile(0x19429, "Skyrim.esm").GetName(), false)	;DawnstarSanctuary
	JsonUtil.StringListAdd("/MME/Strings", "dawnstar", Game.GetFormFromFile(0x20065, "Skyrim.esm").GetName(), false)	;WindpeakInn
	JsonUtil.StringListAdd("/MME/Strings", "dawnstar", Game.GetFormFromFile(0x20555, "Skyrim.esm").GetName(), false)	;Hjerim \ HearthFires

	JsonUtil.StringListAdd("/MME/Strings", "markarth", Game.GetFormFromFile(0x18A59, "Skyrim.esm").GetName(), false)	;Markarth
	JsonUtil.StringListAdd("/MME/Strings", "markarth", Game.GetFormFromFile(0x1F30E, "Skyrim.esm").GetName(), false)	;SilverBloodInn
	JsonUtil.StringListAdd("/MME/Strings", "markarth", Game.GetFormFromFile(0x18A55, "Skyrim.esm").GetName(), false)	;OldHroldan
	JsonUtil.StringListAdd("/MME/Strings", "markarth", Game.GetFormFromFile(0x1F7CB, "Skyrim.esm").GetName(), false)	;OldHroldanInn
	JsonUtil.StringListAdd("/MME/Strings", "markarth", Game.GetFormFromFile(0x18A54, "Skyrim.esm").GetName(), false)	;Karthwasten

	JsonUtil.StringListAdd("/MME/Strings", "riften", Game.GetFormFromFile(0x18A58, "Skyrim.esm").GetName(), false)	;Riften
	JsonUtil.StringListAdd("/MME/Strings", "riften", Game.GetFormFromFile(0x18A4C, "Skyrim.esm").GetName(), false)	;ShorsStone
	JsonUtil.StringListAdd("/MME/Strings", "riften", Game.GetFormFromFile(0x2247E, "Skyrim.esm").GetName(), false)	;BeeandBarb
	JsonUtil.StringListAdd("/MME/Strings", "riften", Game.GetFormFromFile(0x18A4B, "Skyrim.esm").GetName(), false)	;Ivarstead
	JsonUtil.StringListAdd("/MME/Strings", "riften", Game.GetFormFromFile(0x226AA, "Skyrim.esm").GetName(), false)	;IvarsteadVilemyrInn
	JsonUtil.StringListAdd("/MME/Strings", "riften", Game.GetFormFromFile(0x128FE, "Dawnguard.esm").GetName(), false)	;FortDawnguard \ Dawnguard
	JsonUtil.StringListAdd("/MME/Strings", "riften", Game.GetFormFromFile(0x4C1F, "Dawnguard.esm").GetName(), false)	;DayspringCanyon \ Dawnguard

	JsonUtil.StringListAdd("/MME/Strings", "solitude", Game.GetFormFromFile(0x18A5A, "Skyrim.esm").GetName(), false)	;Solitude
	JsonUtil.StringListAdd("/MME/Strings", "solitude", Game.GetFormFromFile(0x200A5, "Skyrim.esm").GetName(), false)	;TheWinkingSkeever
	JsonUtil.StringListAdd("/MME/Strings", "solitude", Game.GetFormFromFile(0x18A46, "Skyrim.esm").GetName(), false)	;DragonBridge
	JsonUtil.StringListAdd("/MME/Strings", "solitude", Game.GetFormFromFile(0x20008, "Skyrim.esm").GetName(), false)	;FourShieldsTavern
	JsonUtil.StringListAdd("/MME/Strings", "solitude", Game.GetFormFromFile(0x18A53, "Skyrim.esm").GetName(), false)	;Morthal
	JsonUtil.StringListAdd("/MME/Strings", "solitude", Game.GetFormFromFile(0x1EB96, "Skyrim.esm").GetName(), false)	;MoorsideInn

	JsonUtil.StringListAdd("/MME/Strings", "whiterun", Game.GetFormFromFile(0x18A56, "Skyrim.esm").GetName(), false)	;Whiterun
	JsonUtil.StringListAdd("/MME/Strings", "whiterun", Game.GetFormFromFile(0x1F86D, "Skyrim.esm").GetName(), false)	;TheBanneredMare
	JsonUtil.StringListAdd("/MME/Strings", "whiterun", Game.GetFormFromFile(0x13163, "Skyrim.esm").GetName(), false)	;Riverwood
	JsonUtil.StringListAdd("/MME/Strings", "whiterun", Game.GetFormFromFile(0x1CB8C, "Skyrim.esm").GetName(), false)	;SleepingGiantInn
	JsonUtil.StringListAdd("/MME/Strings", "whiterun", Game.GetFormFromFile(0x18A47, "Skyrim.esm").GetName(), false)	;Rorikstead
	JsonUtil.StringListAdd("/MME/Strings", "whiterun", Game.GetFormFromFile(0x1F883, "Skyrim.esm").GetName(), false)	;FrostfruitInn

	JsonUtil.StringListAdd("/MME/Strings", "windhelm", Game.GetFormFromFile(0x18A56, "Skyrim.esm").GetName(), false)	;Windhelm
	JsonUtil.StringListAdd("/MME/Strings", "windhelm", Game.GetFormFromFile(0x18A56, "Skyrim.esm").GetName(), false)	;CandlehearthHall
	JsonUtil.StringListAdd("/MME/Strings", "windhelm", Game.GetFormFromFile(0x18A56, "Skyrim.esm").GetName(), false)	;NewGnisisCornerclub
	JsonUtil.StringListAdd("/MME/Strings", "windhelm", Game.GetFormFromFile(0x1F86D, "Skyrim.esm").GetName(), false)	;Winterhold
	JsonUtil.StringListAdd("/MME/Strings", "windhelm", Game.GetFormFromFile(0x13163, "Skyrim.esm").GetName(), false)	;TheFrozenHearth
	JsonUtil.StringListAdd("/MME/Strings", "windhelm", Game.GetFormFromFile(0x13163, "Skyrim.esm").GetName(), false)	;CollegeofWinterhold
	JsonUtil.StringListAdd("/MME/Strings", "windhelm", Game.GetFormFromFile(0x18A56, "Skyrim.esm").GetName(), false)	;Kynesgrove
	JsonUtil.StringListAdd("/MME/Strings", "windhelm", Game.GetFormFromFile(0x18A47, "Skyrim.esm").GetName(), false)	;BraidwoodInn
	
	JsonUtil.StringListAdd("/MME/Strings", "solstheim", Game.GetFormFromFile(0x16E2A, "Dragonborn.esm").GetName(), false)	;Solstheim \ Dragonborn
	JsonUtil.StringListAdd("/MME/Strings", "solstheim", Game.GetFormFromFile(0x143B9, "Dragonborn.esm").GetName(), false)	;RavenRock \ Dragonborn
	JsonUtil.StringListAdd("/MME/Strings", "solstheim", Game.GetFormFromFile(0x143BB, "Dragonborn.esm").GetName(), false)	;SkaalVillage \ Dragonborn
	JsonUtil.StringListAdd("/MME/Strings", "solstheim", Game.GetFormFromFile(0x143BC, "Dragonborn.esm").GetName(), false)	;TelMithryn \ Dragonborn

	JsonUtil.StringListAdd("/MME/Strings", "marketnames", "with the Khajiit Caravaneers", false)
	JsonUtil.StringListAdd("/MME/Strings", "marketnames", "in " + Game.GetFormFromFile(0x18A50, "Skyrim.esm").GetName(), false)	;Dawnstar
	JsonUtil.StringListAdd("/MME/Strings", "marketnames", "in " + Game.GetFormFromFile(0x18A49, "Skyrim.esm").GetName(), false)	;Falkreath
	JsonUtil.StringListAdd("/MME/Strings", "marketnames", "in " + Game.GetFormFromFile(0x18A59, "Skyrim.esm").GetName(), false)	;Markarth
	JsonUtil.StringListAdd("/MME/Strings", "marketnames", "with the Orcish Strongholds", false)	;Orcish Strongholds
	JsonUtil.StringListAdd("/MME/Strings", "marketnames", "in " + Game.GetFormFromFile(0x18A58, "Skyrim.esm").GetName(), false)	;Riften
	JsonUtil.StringListAdd("/MME/Strings", "marketnames", "in " + Game.GetFormFromFile(0x18A5A, "Skyrim.esm").GetName(), false)	;Solitude
	JsonUtil.StringListAdd("/MME/Strings", "marketnames", "in " + Game.GetFormFromFile(0x18A56, "Skyrim.esm").GetName(), false)	;Whiterun
	JsonUtil.StringListAdd("/MME/Strings", "marketnames", "in " + Game.GetFormFromFile(0x18A56, "Skyrim.esm").GetName(), false)	;Windhelm
	JsonUtil.StringListAdd("/MME/Strings", "marketnames", "in the province of Solstheim", false)	;Solstheim


	;RND
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerpoints", Game.GetFormFromFile(0x2884, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerpointsperhour", Game.GetFormFromFile(0x2de7, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerlastupdatetimestamp", Game.GetFormFromFile(0x2de8, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_foodpoints", Game.GetFormFromFile(0x6f1b, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_1stpersonmsg", Game.GetFormFromFile(0x900ca, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_state", Game.GetFormFromFile(0x12c4c, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_forcesatiation", Game.GetFormFromFile(0x536D7, "RealisticNeedsandDiseases.esp"))

	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerspell00", Game.GetFormFromFile(0x1d97, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerspell01", Game.GetFormFromFile(0x1d99, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerspell02", Game.GetFormFromFile(0x1d9b, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerspell03", Game.GetFormFromFile(0x1d9d, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerspell04", Game.GetFormFromFile(0x231b, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerspell05", Game.GetFormFromFile(0x231c, "RealisticNeedsandDiseases.esp"))

	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerlevel00", Game.GetFormFromFile(0x2de9, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerlevel01", Game.GetFormFromFile(0x2dea, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerlevel02", Game.GetFormFromFile(0x2deb, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerlevel03", Game.GetFormFromFile(0x2dec, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerlevel04", Game.GetFormFromFile(0x2ded, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerlevel05", Game.GetFormFromFile(0x2dee, "RealisticNeedsandDiseases.esp"))

	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerlevel00consumemessage", Game.GetFormFromFile(0x53f5, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerlevel01consumemessage", Game.GetFormFromFile(0x53f6, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerlevel02consumemessage", Game.GetFormFromFile(0x53f7, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerlevel03consumemessage", Game.GetFormFromFile(0x53f8, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerlevel04consumemessage", Game.GetFormFromFile(0x53f9, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerlevel05consumemessage", Game.GetFormFromFile(0x53fa, "RealisticNeedsandDiseases.esp"))

	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerlevel00consumemessageb", Game.GetFormFromFile(0x900c4, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerlevel01consumemessageb", Game.GetFormFromFile(0x900c5, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerlevel02consumemessageb", Game.GetFormFromFile(0x900c6, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerlevel03consumemessageb", Game.GetFormFromFile(0x900c7, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerlevel04consumemessageb", Game.GetFormFromFile(0x900c8, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_hungerlevel05consumemessageb", Game.GetFormFromFile(0x900c9, "RealisticNeedsandDiseases.esp"))
	
	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstpoints", Game.GetFormFromFile(0x2e07, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstpointsperhour", Game.GetFormFromFile(0x2e08, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstlastupdatetimestamp", Game.GetFormFromFile(0x2e09, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_waterpoints", Game.GetFormFromFile(0x6f16, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_animdrink", Game.GetFormFromFile(0x24489, "RealisticNeedsandDiseases.esp"))

	JsonUtil.SetFormValue("/MME/RND", "idledrink", Game.GetFormFromFile(0xfd68b, "Skyrim.esm"))
	JsonUtil.SetFormValue("/MME/RND", "chairdrinkingstart", Game.GetFormFromFile(0x65d07, "Skyrim.esm"))
	JsonUtil.SetFormValue("/MME/RND", "idlestop_loose", Game.GetFormFromFile(0x10d9ee, "Skyrim.esm"))

	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstspell00", Game.GetFormFromFile(0x1da1, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstspell01", Game.GetFormFromFile(0x1da3, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstspell02", Game.GetFormFromFile(0x1da5, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstspell03", Game.GetFormFromFile(0x2dfa, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstspell04", Game.GetFormFromFile(0x2dfc, "RealisticNeedsandDiseases.esp"))

	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstlevel00", Game.GetFormFromFile(0x2e0a, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstlevel01", Game.GetFormFromFile(0x2e0b, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstlevel02", Game.GetFormFromFile(0x2e0c, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstlevel03", Game.GetFormFromFile(0x2e0d, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstlevel04", Game.GetFormFromFile(0x2e0e, "RealisticNeedsandDiseases.esp"))

	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstlevel00consumemessage", Game.GetFormFromFile(0x5ecc, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstlevel01consumemessage", Game.GetFormFromFile(0x5ecd, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstlevel02consumemessage", Game.GetFormFromFile(0x5ece, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstlevel03consumemessage", Game.GetFormFromFile(0x5ecf, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstlevel04consumemessage", Game.GetFormFromFile(0x5ed0, "RealisticNeedsandDiseases.esp"))

	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstlevel00consumemessageb", Game.GetFormFromFile(0x90b97, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstlevel01consumemessageb", Game.GetFormFromFile(0x90b98, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstlevel02consumemessageb", Game.GetFormFromFile(0x90b99, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstlevel03consumemessageb", Game.GetFormFromFile(0x90b96, "RealisticNeedsandDiseases.esp"))
	JsonUtil.SetFormValue("/MME/RND", "rnd_thirstlevel04consumemessageb", Game.GetFormFromFile(0x90b95, "RealisticNeedsandDiseases.esp"))
	
	JsonUtil.SetFormValue("/MME/RND", "rnd_emptybottle03", Game.GetFormFromFile(0x43b4, "RealisticNeedsandDiseases.esp"))

	;LactacidScr
	JsonUtil.SetStringValue("/MME/Strings", "lactacidstory", "After you have drank bottle, you are starting to feel strange, your breast warm up, nipples start to tingle and becomes hard rubbing with your clothes. Heat spreads through you body, your mind goes blank, you can hardly stand on your feet. Suddenly you feeling shock-waves going through you body as you collapse.")
	JsonUtil.SetStringValue("/MME/Strings", "lactacidorgasm", "%text1 just had a breast induced orgasm!")
	JsonUtil.SetStringValue("/MME/Strings", "milkingorgasm", "%text1 is having a orgasm!")
	JsonUtil.SetStringValue("/MME/Strings", "milkingboobgasm", "%text1 is having a boobgasm!")
	JsonUtil.SetStringValue("/MME/Strings", "milkingbounddone", "Milk Pump has milked %text1 dry and releases its bounds.")
	JsonUtil.SetStringValue("/MME/Strings", "exhaustiongone", "%text1 feels revitalised, exhaustion is gone!")

	;MilkCheckForSprigganScr
	JsonUtil.SetStringValue("/MME/Strings", "drained", "You are drained until you take a nap.")
	JsonUtil.SetStringValue("/MME/Strings", "rested", "You have rested enough.")

	;Milking dialogues give/receive
	JsonUtil.SetStringValue("/MME/Strings", "milkinggaywarning", "[MME]Sorry, there are no gay animations, dividing universe by zero, have a nice day.")
	
	;CheckForSprigganScr
	JsonUtil.SetStringValue("/MME/Strings", "breastattach", "text1 attaches to your breasts, absorbing your additional breast rows")
	JsonUtil.SetStringValue("/MME/Strings", "breastdettach", "You are free from text1")
	JsonUtil.SetStringValue("/MME/Strings", "cupsattach", "The milking cups attach to your breasts, ready to milk you")
	JsonUtil.SetStringValue("/MME/Strings", "cupsdettach", "The milking cups detach from your breasts")

	JsonUtil.StringListAdd("/MME/Armors", "defaultmilkingarmor", "Milker", false)
	JsonUtil.StringListAdd("/MME/Armors", "defaultmilkingarmor", "Milking Cuirass", false)
	JsonUtil.StringListAdd("/MME/Armors", "defaultmilkingarmor", "Cow Harness", false)
	JsonUtil.StringListAdd("/MME/Armors", "defaultmilkingarmor", "Dwemer milking device", false)
		
	JsonUtil.StringListAdd("/MME/Armors", "defaultlivingarmor", "Spriggan Armor", false)
	JsonUtil.StringListAdd("/MME/Armors", "defaultlivingarmor", "Spriggan Host", false)
	JsonUtil.StringListAdd("/MME/Armors", "defaultlivingarmor", "Living Arm", false)
	JsonUtil.StringListAdd("/MME/Armors", "defaultlivingarmor", "Hermaeus Mora", false)
	JsonUtil.StringListAdd("/MME/Armors", "defaultlivingarmor", "HM Priestess", false)
	JsonUtil.StringListAdd("/MME/Armors", "defaultparasitearmor", "Tentacle Armor", false)
	JsonUtil.StringListAdd("/MME/Armors", "defaultparasitearmor", "Tentacle Parasite", false)
	
	JsonUtil.StringListAdd("/MME/Armors", "addedmilkingarmor", "insert armor name here", false)
	JsonUtil.StringListAdd("/MME/Armors", "addedlivingarmor", "insert armor name here", false)
	JsonUtil.StringListAdd("/MME/Armors", "addedparasitearmor", "insert armor name here", false)
	

	JsonUtil.SetStringValue("/MME/Strings", "ismaid", "%text1 is already milkmaid")
	JsonUtil.SetStringValue("/MME/Strings", "isnotmaid", "%text1 is not milkmaid")
	JsonUtil.SetStringValue("/MME/Strings", "isslave", "%text1 is already milkslave")
	JsonUtil.SetStringValue("/MME/Strings", "isnotslave", "%text1 is not milkslave")
	JsonUtil.SetStringValue("/MME/Strings", "isnotmaidslave", "%text1 is not a milk maid/slave")
	JsonUtil.SetStringValue("/MME/Strings", "femaleonly", "Only works on females")
	
	;MilkPlayer
	;Orgasm
	JsonUtil.SetStringValue("/MME/Strings", "orgasmmilkleak", "Orgasm forces milk from %text1's breasts")
	JsonUtil.SetStringValue("/MME/Strings", "lactationstart", "%text1's breasts has started lactating")
	JsonUtil.SetStringValue("/MME/Strings", "vibrationmilkleak", "Nipple piercing vibrations forces milk from %text1's breasts")
	
	;MilkQuest OnKeyEvent block
	JsonUtil.SetStringValue("/MME/Strings", "onkeyeventnotsn", "%text1 is not a milk maid/slave")
	JsonUtil.SetStringValue("/MME/Strings", "onkeyeventstatus", "Milkmaid: %text1 ; Milk: %text2; Nipples: %text3; Lactacid: %text4")
	JsonUtil.SetStringValue("/MME/Strings", "onkeyeventspriggan", "%text1 is a host for living armor and can not be milked")
	JsonUtil.SetStringValue("/MME/Strings", "onkeyeventisslave", "%text1 is a slave and not allowed to be milked")

	;MilkQuest AssignSlot block
	JsonUtil.SetStringValue("/MME/Strings", "assignslotmaid", "%text1 becomes a Milkmaid")
	JsonUtil.SetStringValue("/MME/Strings", "assignslotnomaidsslots", "No more Milkmaid slots")
	JsonUtil.SetStringValue("/MME/Strings", "assignslotnoslaveslots", "No more Milkslave slots")
	JsonUtil.SetStringValue("/MME/Strings", "assignslotactorispc", "%text1 is Player Character and cannot be Milkslave")
	JsonUtil.SetStringValue("/MME/Strings", "assignslotstm", "%text1 is not a Milkslave, something wrong in calling Function AssignSlotSlaveToMaid")
	JsonUtil.SetStringValue("/MME/Strings", "assignslotmts", "%text1 is not a Milkmaid, something wrong in calling Function AssignSlotSlaveToMaid")

	;MilkQuest AssignSlot
	JsonUtil.SetStringValue("/MME/Strings", "assignslotmts", "%text1 is not a Milkmaid, something wrong in calling Function AssignSlotSlaveToMaid")

	;Nipple piercing
	JsonUtil.SetIntValue("/MME/Armors", "nipplepiercingslot", 56)				;(slot 56)
	JsonUtil.StringListAdd("/MME/Armors", "nipplepiercing", "Piercing", false)
	;Nipple piercing block
	JsonUtil.StringListAdd("/MME/Armors", "nipplepiercingblock", "Plug", false)	;none
	JsonUtil.StringListAdd("/MME/Armors", "nipplepiercingblock", "Shield", false)	;Shout Like a Virgin mod
	
	JsonUtil.StringListAdd("/MME/Strings", "standingmilkinganimations", "ZaZAPCHorFA", false)
	JsonUtil.StringListAdd("/MME/Strings", "standingmilkinganimations", "ZaZAPCHorFB", false)
	JsonUtil.StringListAdd("/MME/Strings", "standingmilkinganimations", "ZaZAPCHorFC", false)

	;Stories
	;mps
	JsonUtil.StringListAdd("/MME/Strings", "milkpumpstart", "Out of curiosity you jump into strange device, nothing bad can happen, right? Suddenly, you start to feel tingles over your skin, scared you try to get out of the device but you can move a finger. Desperate, you see tube appear, moving towards your mouth and forcing itself in, few moments later you feel same happens with your intimate parts. Paralyzed you see some fluids flowing through tubes.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkpumpstart", "As you approach the strange device, your milky nipples grow hard and ready of their own volition, eagerly anticipating the opportunity to get milked. You easily fit yourself into the apparatus, hearing the machinery activate automatically as if sensing your breast's full capacity. The cups twitch and move heavily as they raise to your bountiful chest, ready to milk you.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkpumpstart", "As you take a seat on the strange device, your aching nipples grow hard and ready of their own volition, eagerly anticipating the opportunity to release their milky load. You easily fit yourself into the apparatus, hearing the machinery activate automatically. The cups twitch and move as they raise to your full chest, ready to relieve you of your delicious milky burden.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkpumpstart", "You begin holding the breast-milking cups against your forward jutting nipples and with a sudden lurch the suction pulls against you, pressing the cups tightly against your chest, stretching your nubs to nearly twice their normal length. You feel a building pressure as the machine sucks you relentlessly, drawing your milk to the surface. Your body lets down its milk, flooding the tubes with creamy goodness.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkpumpstart", "You eagerly grab onto the suction cups, pulling them up to your tight and full chest. They latch on, slapping tight against you as the vacuum pressure seals them tightly against your body. You can feel your milk-slicked nipples pulling tight, nearly doubling in size from the intense pressure. The sensitive flesh of your motherly tits fill with a burgeoning pressure that centers around the tubes connected to your nips. Your lactating nubs twitch and pulse for but a moment, then unleash a torrent of milk, totally filling the tubes.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkpumpstart", "You approach the strange device and take a seat. The suckers immediately seal themselves against your breasts and activate, assaulting your nipples with a strong, rhythmic sucking sensation. It's uncomfortable - almost painful, in fact, but the sensation of being milked, brings about a strange, tingling feeling of arousal that washes over your whole being. As you look down to your breasts, you find yourself fantasizing your breasts as heaving boulders of supple flesh, filled with creamy, nutritive milk and maternal purpose. The daydream is oddly erotic, and your thighs begin rubbing against each other of their own accord.", false)
	;mpe
	JsonUtil.StringListAdd("/MME/Strings", "milkpumpend", "After minutes of torment, tubes retract into the unknown, as you feel strange magic fades, you try to escape horrible device as fast as you can, though it's not easy for your abused body, filled with unknown liquid.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkpumpend", "The cups pulse with a strong consistency, milking you HARD and draining you of your reservoir of milk. Your nipples ache with the strange pleasure of it, leaving you moaning and wriggling against your restraints, desperate for release, but you just can't get the stimulation you need. Time stretches on as you're teased like that, pumped of your milk until the machinery shuts off and you wobbly raise to your feet, your milky residue still running down your breasts.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkpumpend", "The machinery lurches, struggling to keep up as you flood the tubes with your creamy bounty. A motherly sense of pride wells within you as you hear the apparatus wind down and indicate it's fullness with a ding; the people of Skyrim will be getting their fill tonight. Even more, you can't wait to continue to satisfy their thirst when it's time to be milked again.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkpumpend", "You feel woozy and light-headed from the intense milking, and have difficulty focusing on anything but the residue of fluids coating your milky tits. Feeling sore and exhausted, you make yourself decent and stagger away from the machinery with a satisfied smile on your face.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkpumpend", "You practically cream yourself from the cup's actions as the milking continues, so hot and horny that you try and wriggle in your harness to press against them. After what seems like hours of non-stop sucking and spurting, your milking is over, and the cups release themselves from your drained breasts. You rise and steady yourself on wobbly knees, eager to experience being milked again.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkpumpend", "Eventually, the milker's action becomes too much for your reddened nipples, and with a slight grimace you deactivate the milker. As you alleviate your tender bosom, you find that the odd tingling sensation is still lingering in your bosom, along with the vision of your breasts swelling with milk.", false)
	;SS
	JsonUtil.StringListAdd("/MME/Strings", "sprigganstart", "Here could be your story", false)
	JsonUtil.StringListAdd("/MME/Strings", "sprigganstart", "The spriggan's root-like tendrils stretch across your swollen breasts, forming tight knots where milk is starting to seep from your nipples. The rough bark of its fingers digs into your flesh, as it starts to massage your breasts, coaxing your milk to the surface.", false)
	JsonUtil.StringListAdd("/MME/Strings", "sprigganstart", "The spriggan's tendrils knot around your milky nipples, then take hold almost painfully hard. You gasp in a mixture of pain and relief, as your milk lets down.", false)
	JsonUtil.StringListAdd("/MME/Strings", "sprigganstart", "The spriggan stirs and suddenly you feel its tendrils rhythmically squeezing your breasts and pulling at your nipples. Pain and pleasure mix as you are forced to meet its demand for your milk.", false)
	;SE
	JsonUtil.StringListAdd("/MME/Strings", "sprigganend", "Here could be your story", false)
	JsonUtil.StringListAdd("/MME/Strings", "sprigganend", "Your whole body throbs in time with the pulse of milk from your nipples, and a strange euphoria courses through you. But your breasts are nearly drained, and the milking comes to an end. The spriggan seems to be satisfied, for now.", false)
	JsonUtil.StringListAdd("/MME/Strings", "sprigganend", "You squirm within the spriggan's tight embrace, as it wrings the last few drops from your drained breasts. The spriggan seems to want more, but there is none to be had.", false)
	JsonUtil.StringListAdd("/MME/Strings", "sprigganend", "The spriggan's tendrils pull harder and faster briefly, and then they begin to relax as every drop of milk is absorbed. You know that it will need to feed again, but when?", false)
	;HMS
	JsonUtil.StringListAdd("/MME/Strings", "hermaeusmorastart", "Here could be your story", false)
	JsonUtil.StringListAdd("/MME/Strings", "hermaeusmorastart", "The tentacles are reaching for your breasts. The suckers melt with your body. You nearly faint in Hermaeus' presence, feeling his caress, becoming one with his parasite. You feel milk gushing out, ravenous imbibed by the tentacles.", false)
	JsonUtil.StringListAdd("/MME/Strings", "hermaeusmorastart", "A dark voice pounds in your head: '%text1, my favourite mind milker. Let me see what knowledge you acquired for me.' The tentacles caress your breast, dig deep into them, you feel them inside your trembling body, reaching your head, your mind...", false)
	;HME
	JsonUtil.StringListAdd("/MME/Strings", "hermaeusmoraend", "Here could be your story", false)
	JsonUtil.StringListAdd("/MME/Strings", "hermaeusmoraend", "The tentacles relax as the penetration on your tits suddenly stops. You can not say if you feel dizzy, relieved or euphoric. But you are happy you have given Hermaeus this sacrifice. And you're eagerly awaiting his next demand.", false)
	JsonUtil.StringListAdd("/MME/Strings", "hermaeusmoraend", "'Well done my pet.' are his last words before he releases your spirit from its prison and gives you control over your body again. You feel ice cold sweat on your skin. Your legs are shaking. 'Thank you master.' whisper from your lips", false)
	;LAS
	JsonUtil.StringListAdd("/MME/Strings", "livingarmorstart", "Here could be your story", false)
	JsonUtil.StringListAdd("/MME/Strings", "livingarmorstart", "The tentacles are reaching for your breasts. The suckers latch on to your body. You nearly faint in anticipation, feeling their caress, and you know what is coming. You feel your milk gushing out, ravenously imbibed by the tentacles.", false)
	JsonUtil.StringListAdd("/MME/Strings", "livingarmorstart", "The armor's tentacles coil around your milky nipples, then the suckers take hold almost painfully hard. You gasp in a mixture of pain and relief, as your milk lets down. The tentacles pulse and pull as they milk you.", false)
	JsonUtil.StringListAdd("/MME/Strings", "livingarmorstart", "Your armor suddenly tightens around you. Tentacles wrap around your swollen breasts as suckers find the nipples and latch on. Your knees nearly buckle as the writhing mass squeezes and massages your breasts. Your milk begins to flow as the suckers do their work.", false)
	;LAE
	JsonUtil.StringListAdd("/MME/Strings", "livingarmorend", "Here could be your story", false)
	JsonUtil.StringListAdd("/MME/Strings", "livingarmorend", "The tentacles relax as the suction on your tits suddenly stops. You can not say if you feel dizzy, relieved or euphoric. But you are happy you have given the armor what it needs. And you're eagerly awaiting its next feeding.", false)
	JsonUtil.StringListAdd("/MME/Strings", "livingarmorend", "You squirm within the tentacles' tight embrace, as they wring the last few drops from your breasts. The armor seems to want more, but it relaxes its hold... for now.", false)
	JsonUtil.StringListAdd("/MME/Strings", "livingarmorend", "The tentacles squeeze harder and faster as the suckers pull every drop of milk they can get and then as suddenly as it began, the armor relaxes its grip. You've been relieved of your milky burden for now. And you know you'll need to satisfy its hunger again.... but when?", false)

	;MaidLvUp
	JsonUtil.StringListAdd("/MME/Strings", "maidlvup", "%text1 has gained a Milkmaid level!", false)
	JsonUtil.StringListAdd("/MME/Strings", "maidlvup", "As a result of a series of repeated vigorous milkings, %text1's breasts have grown accustomed to the great demand for their precious nectar and have grown bigger in size increasing their capacity! \n [Milkmaid Level: 1]", false)
	JsonUtil.StringListAdd("/MME/Strings", "maidlvup", "Due to repeated vigorous milkings, %text1's beautiful boobs are adjusting to the great demand for their precious nectar and have grown bigger in size increasing their capacity even further! \n [Milkmaid Level: 2]", false)
	JsonUtil.StringListAdd("/MME/Strings", "maidlvup", "The repeated vigorous milkings are conditioning %text1's glorious globes to meet the great demand for their precious nectar. They have grown bigger in size increasing their already impressive capacity even further! \n [Milkmaid Level: 3]", false)
	JsonUtil.StringListAdd("/MME/Strings", "maidlvup", "Repeated vigorous milkings have trained %text1's marvellous milk melons to meet the great demand for their precious nectar. They have grown bigger in size increasing their already amazing capacity even further! \n [Milkmaid Level: 4]", false)
	JsonUtil.StringListAdd("/MME/Strings", "maidlvup", "%text1's looking forward to these vigorous milkings. Her breasts have grown accustomed to the great demand for their luscious lactation and have grown bigger in size increasing their inhuman capacity even further! \n [Milkmaid Level: 5]", false)
	JsonUtil.StringListAdd("/MME/Strings", "maidlvup", "%text1's already ample breasts are adjusting to the demand for their precious nectar due to the repeated vigorous milkings. They have grown in size and capacity again! %text2 enjoys being milked! \n [Milkmaid Level: 6]", false)
	JsonUtil.StringListAdd("/MME/Strings", "maidlvup", "Due to the regular, vigorous milkings, %text1's breasts have grown even larger and their capacity has increased. Their now bountiful breasts will work to meet the demand for their tasty milk. \n [Milkmaid Level: 7]", false)
	JsonUtil.StringListAdd("/MME/Strings", "maidlvup", "%text1 enjoys the repeated and vigorous milking. her breasts continue to grow to meet the demand for their rich nectar. Her now Gigantic Jugs can supply more milk and she enjoys it when people notice her breast size! \n [Milkmaid Level: 8]", false)
	JsonUtil.StringListAdd("/MME/Strings", "maidlvup", "These regular, vigorous milking sessions turn your milkmaid's on! They now have Tremendous Tits with increased size and capacity. Their delicious milk is in demand and they feel sexy when they hear comments about their boobs. \n [Milkmaid Level: 9]", false)
	JsonUtil.StringListAdd("/MME/Strings", "maidlvup", "%text1 is now a Master of the Milkmaids with MASSIVE Mammaries! She can supply more milk than an entire herd of cows. And those tits of theirs are the talk of Tamriel. \n [Master Milkmaid]", false)

	;Breast milk status
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts feel a bit warm as they tingle.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts feel quite warm.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts feel very warm and a bit uncomfortable.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts are starting to perk up.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts have become a bit more firm and perky.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts have become quite firm, the nipples feel very tender.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts have become very firm, the nipples feel very sensitive.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts feel slightly heavy.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts have become heavier, the trend is quite alarming.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts have become noticeably heavier.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts feel heavy and full, perhaps it is time to seek release.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts are demanding release! They're beginning to feel painful.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts have reached their natural limit, and scream for release.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts have begun to expand to accommodate the additional milk.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts have expanded beyond their natural limit.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts have now become even larger.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts continue to expand, with no end in sight.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts are starting to block the view of the lower body.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts have obscured the lower body, but continue to expand.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts are swollen with milk.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts are starting to impair movement.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts have expanded to their absolute limit.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's breasts are swollen with milk.", false)

	;Breast milk max status
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's nipples swell and tingle.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's swollen nipples become moistened.", false)
	JsonUtil.StringListAdd("/MME/Strings", "milkstage", "%text1's milk is leaking from swollen nipples.", false)
	
	;Milking
	;armor filter
	JsonUtil.StringListAdd("/MME/Armors", "armorname", "Chastity Bra", false)
;	JsonUtil.StringListAdd("/MME/Armors", "armorname", "Spriggan Armor", false)
;	JsonUtil.StringListAdd("/MME/Armors", "armorname", "Spriggan Host", false)
;	JsonUtil.StringListAdd("/MME/Armors", "armorname", "Dwemer milking device", false)
;	JsonUtil.StringListAdd("/MME/Armors", "armorname", "Cow Harness", false)
;	JsonUtil.StringListAdd("/MME/Armors", "armorname", "Living Arm", false)
;	JsonUtil.StringListAdd("/MME/Armors", "armorname", "Hermaeus Mora", false)
;	JsonUtil.StringListAdd("/MME/Armors", "armorname", "HM Priestess", false)
;	JsonUtil.StringListAdd("/MME/Armors", "armorname", "Tentacle Parasite", false)
;	JsonUtil.StringListAdd("/MME/Armors", "armorname", "Tentacle Armor", false)
	
	;armor bodyslot filter
	JsonUtil.IntListAdd("/MME/Armors", "armorslot", 32, false)	;32 - body
	JsonUtil.IntListAdd("/MME/Armors", "armorslot", 45, false)	;45 - harness
	JsonUtil.IntListAdd("/MME/Armors", "armorslot", 49, false)	;49 - harness
	JsonUtil.IntListAdd("/MME/Armors", "armorslot", 56, false)	;56 - bra
	JsonUtil.IntListAdd("/MME/Armors", "armorslot", 58, false) ;58 - collar?,- locked milk cuirass slstorries

	JsonUtil.Save("/MME/Strings", false)
	Debug.Messagebox("MilkModEconomy Json Rebuid, have a nice day!")
endfunction
