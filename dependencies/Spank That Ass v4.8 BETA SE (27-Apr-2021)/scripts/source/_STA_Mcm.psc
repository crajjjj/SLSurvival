Scriptname _STA_Mcm extends SKI_ConfigBase

string[] PlayerDialogOptions
string[] ArmorSlutinessTiers

Event OnConfigInit()
	BuildArrays()
EndEvent

Event OnConfigClose()
	If DoSpankUtilPlayerLoadGame
		DoSpankUtilPlayerLoadGame = false
		SpankUtil.PlayerLoadsGame()
	EndIf
EndEvent

Event OnPageReset(string page)
	SetCursorFillMode(TOP_TO_BOTTOM)
	
	; Conditional flags
	Int SlsoInstalledFlag = OPTION_FLAG_DISABLED
	Int VanillaFlag = OPTION_FLAG_DISABLED
	Int DFlowFlag = OPTION_FLAG_DISABLED
	Int DflowContinFlag = OPTION_FLAG_DISABLED
	Int ZapFlag = OPTION_FLAG_DISABLED
	Int MmeFlag = OPTION_FLAG_DISABLED
	Int MilkAddictFlag = OPTION_FLAG_DISABLED
	Int DdFlag = OPTION_FLAG_DISABLED
	Int FollowerOnlyFlag = OPTION_FLAG_DISABLED
	
	; SLSO / Vanilla Sexlab
	If DialogUtil.IsSlsoInstalled
		SlsoInstalledFlag = OPTION_FLAG_NONE
		VanillaFlag = OPTION_FLAG_DISABLED
	Else
		SlsoInstalledFlag = OPTION_FLAG_DISABLED
		VanillaFlag = OPTION_FLAG_NONE
	EndIf
	
	; Devious Followers
	If Game.GetModByName("DeviousFollowers.esp") != 255 ; Needs integration
		DFlowFlag = OPTION_FLAG_NONE
		If Dflow.GetDfVersion() >= 206.0
			DflowContinFlag = OPTION_FLAG_NONE
		EndIf
	EndIf
	
	; Milk Mod Economy
	If DialogUtil.IsMmeInstalled ; Needs integration ?
		MmeFlag = OPTION_FLAG_NONE
	EndIf
	
	; Milk Addict
	If Game.GetModByName("Milk Addict.esp") != 255
		MilkAddictFlag = OPTION_FLAG_NONE
	EndIf
	
	; Devious Devices
	If Game.GetModByName("Devious Devices - Integration.esm") != 255
		DdFlag = OPTION_FLAG_NONE
	EndIf
	
	; Follower spanks only
	If DialogUtil.OnlyFollowerSpanks
		FollowerOnlyFlag = OPTION_FLAG_NONE
	EndIf
	
	If(page == "Settings")
		AddHeaderOption("Masochism ")
		MasochismStatusOID_T = AddTextOption("Masochism Status: " + SpankUtil.PlayerMasochism + " - " + GetMasochismStatus(), "")
		MasochismStepSizeOID_S = AddSliderOption("Masochism Step Size: ", SpankUtil.MasochismStepSize, "{1}")
		PauseMasochismOID = AddToggleOption("Freeze Masochism Progression", PauseMasochism)
		DdThresholdOID_S = AddSliderOption("Devious Device Threshold: ", SpankUtil.DdThreshold, "{0}")
		ResetPlayerMasochismOID_T = AddTextOption("Reset Player Masochism ", "")
		AddEmptyOption()
		
		AddHeaderOption("Ass/Tits Overlays ")
		SpanksToMaxIntensityOID_S = AddSliderOption("Spanks To Max Intensity: ", SpankUtil.SpanksToMaxIntensity, "{0}")
		AgeFadeFactorOID_S = AddSliderOption("Age Factor: ", SpankUtil.AgeFadeFactor * 100.0, "{0}%")
		MaxIntensityAssOID_S = AddSliderOption("Max Ass Intensity: ", SpankUtil.MaxAssIntensity * 100.0, "{0}%")
		MaxIntensityTitsOID_S = AddSliderOption("Max Tits Intensity: ", SpankUtil.MaxTitsIntensity * 100.0, "{0}%")
		ResetAssTitsOID_T = AddTextOption("Reset Ass/Tits Overlays ", "")
		AddEmptyOption()
		
		AddHeaderOption("Skin Balm ")
		SpanksHealedOID_S = AddSliderOption("Spanks Healed: ", SpanksHealed, "{0}")
		SpanksHealedDecayOID_S = AddSliderOption("Spanks Healed Decay: ", SpanksHealedDecay, "{2}")
		OldSpankHealChanceOID_S = AddSliderOption("Chance To Heal Old Spank: ", OldSpankHealChance, "{0}%")
		AddEmptyOption()
		
		AddHeaderOption("Player Dialogue")
		PlayerDialogDB = AddMenuOption("Player Dialogue Level: ", PlayerDialogOptions[PlayerDialog], 0)
		AlwaysUseDummyOID = AddToggleOption("Always Use Dummy", AlwaysUseDummy)
		GagTalkChanceOID_S = AddSliderOption("Chance For Gag Talk: ", DialogUtil.GagTalkChance, "{0}%")
		AddEmptyOption()

		AddHeaderOption("Drool & Tears")
		TearsCooldownIntervalOID_S = AddSliderOption("Tears Cooldown: ", DialogUtil.TearsCooldownInterval, "{0} seconds")
		DroolCooldownOID_S = AddSliderOption("Drool Cooldown: ", DialogUtil.DroolCooldown, "{0} seconds")
		TearsOpacityOID_S = AddSliderOption("Tears Opacity: ", DialogUtil.TearsOpacity, "{2}")
		DroolOpacityOID_S = AddSliderOption("Drool Opacity: ", DialogUtil.DroolOpacity, "{2}")
		ResetTearsOID_T = AddTextOption("Reset Tears ", "")
		ResetDroolOID_T = AddTextOption("Reset Drool ", "")
		AddEmptyOption()

		AddHeaderOption("Pain ")
		PainDebuffMaxOID_S = AddSliderOption("Pain Buff Base: ", DialogUtil.PainDebuffMax, "{0} points")
		AddEmptyOption()
		
		AddHeaderOption("Volumes ")
		SlapHeavyVolumeOID_S = AddSliderOption("Slap Volume: ", SpankUtil.SlapHeavyVolume * 100.0, "{0}%")
		SlapMoanVolumeOID_S = AddSliderOption("Slap Moan Volume: ", SpankUtil.SlapMoanVolume * 100.0, "{0}%")
		AddEmptyOption()
		
		AddHeaderOption("Interfaces ")
		IsDdIntActiveOID = AddToggleOption("Devious Devices", DialogUtil.DeviousInterface.GetIsInterfaceActive())
		IsSlsoIntActiveOID = AddToggleOption("Sexlab Separate Orgasms", DialogUtil.SlsoInterface.GetIsInterfaceActive())
		IsMmeIntActiveOID = AddToggleOption("Milk Mod Economy", DialogUtil.MmeInterface.GetIsInterfaceActive())
		
		SetCursorPosition(1)
		AddHeaderOption("Debug ")
		DebugModeOID = AddToggleOption("Debug Mode", DebugMode)
		AddEmptyOption()
		
		AddHeaderOption("Import/Export Settings")
		ExportSettingsOID_T = AddTextOption("Export Settings ", "")
		ImportSettingsOID_T = AddTextOption("Import Settings", "")
		AddEmptyOption()
		
		AddHeaderOption("Spanking ")
		BumpSpankToggleOID = AddToggleOption("Allow Bump Spanks", SpankUtil.BumpSpankToggle)
		BumpSpankNotificationsOID = AddToggleOption("Bump Spank Notifications", SpankUtil.BumpSpankNotifications)
		BumpSpankStaggerChanceOID_S = AddSliderOption("Stagger Chance: ", SpankUtil.BumpSpankStaggerChance, "{0}%")
		BumpSpankVibeChanceOID_S = AddSliderOption("Bump Spank Vibe Chance: ", SpankUtil.BumpSpankVibeChance, "{0}%")
		SexSpankToggleOID = AddToggleOption("Allow Sex Spanks", SpankUtil.SexSpankToggle)
		FurnSpankChanceOID_S = AddSliderOption("Furniture Spank Chance: ", FurnSpankChance, "{0}%")
		SpankStaminaPercentOID_S = AddSliderOption("Spank Stamina Damage: ", SpankUtil.SpankStaminaPercent * 100.0, "{0}%")
		ArousalModifierOID_S = AddSliderOption("Base Spank Arousal Modifier: ", SpankUtil.BaseSpankArousalMod, "{0}")
		BakaSlaOID = AddToggleOption("Check Baka SLA Keywords", IsSpankableArmor.BakaSla)
		AddEmptyOption()
		
		AddHeaderOption("Sex ")
		SpeakKeyOID = AddKeyMapOption("Speak Key", DialogUtil.SpeakKey, SlsoInstalledFlag)
		
		OnlyFollowerSpanksOID = AddToggleOption("Only Followers Spank During Sex", DialogUtil.OnlyFollowerSpanks)
		FollowerSexSpankChanceOID_S = AddSliderOption("Follower Sex Spanking Chance: " , DialogUtil.FollowerSexSpankChance, "{0}%", FollowerOnlyFlag)
		
		SexSlapNotifyOID = AddToggleOption("Sex Slap Notifications", SpankUtil.SexSlapNotify)
		SexIdleCommentChanceOID = AddSliderOption("Idle Sex Comment Chance: " , DialogUtil.SexIdleCommentChance, "{1}%")
		SpankyNpcChanceOID = AddSliderOption("Base Chance Of Spank-Happy Npc: " , DialogUtil.SpankyNpcChance, "{0}%")
		SpankyNpcIncPerRapeOID = AddSliderOption("Increase Per Rape: " , SpankyNpcIncPerRape, "{0}%")

		FuckBackTickOID_S = AddSliderOption("Fuck Back Reward: ", DialogUtil.FuckBackTick, "{0} seconds", SlsoInstalledFlag)
		DenigrateTickOID_S = AddSliderOption("Denigrate Reward: ", DialogUtil.DenigrateTick, "{0} seconds", SlsoInstalledFlag)
		VanillaRapeSpankChanceOID_S = AddSliderOption("Chance Of Spank During Rape ", DialogUtil.VanillaRapeSpankChance, "{0}%", VanillaFlag)
		SexSoundsOID_S = AddSliderOption("Sex Sounds Volume: ", DialogUtil.SexSoundVol * 100.0, "{0}%", SlsoInstalledFlag)
		SexAssClapChanceOID_S = AddSliderOption("Ass Clap Chance: ", DialogUtil.AssClapChance, "{0}%", SlsoInstalledFlag)
		AddEmptyOption()

		AddHeaderOption("Enjoyment ")
		LowJoyThresholdOID_S = AddSliderOption("Low Joy Threshold: ", DialogUtil.LowJoyThreshold, "{0}", SlsoInstalledFlag)
		MidJoyThresholdOID_S = AddSliderOption("Mid Joy Threshold: ", DialogUtil.MidJoyThreshold, "{0}", SlsoInstalledFlag)
		NearOrgasmJoyThresholdOID_S = AddSliderOption("Near Orgasm Joy Threshold: ", DialogUtil.NearOrgasmJoyThreshold, "{0}", SlsoInstalledFlag)
		BaseSpankEnjoymentOID_S = AddSliderOption("Base Spank Enjoyment: ", DialogUtil.BaseSpankEnjoyment, "{0}", SlsoInstalledFlag)
		AddEmptyOption()
		
		AddHeaderOption("Minimum Sex Av")
		MinStaminaRateOID_S = AddSliderOption("Minimum Stamina Rate: ", DialogUtil.MinStaminaRate, "{1}", SlsoInstalledFlag)
		MinStaminaMultOID_S = AddSliderOption("Minimum Stamina Rate Mult: ", DialogUtil.MinStaminaMult, "{0}", SlsoInstalledFlag)
		MinMagickaRateOID_S = AddSliderOption("Minimum Magicka Rate: ", DialogUtil.MinMagickaRate, "{1}", SlsoInstalledFlag)
		MinMagickaMultOID_S = AddSliderOption("Minimum Magicka Rate Mult: ", DialogUtil.MinMagickaMult, "{0}", SlsoInstalledFlag)
		RapeDrainsAttributesOID = AddToggleOption("Drain Magicka & Stamina After Rape", RapeDrainsAttributes, SlsoInstalledFlag)
		AddEmptyOption()
		
		AddHeaderOption("Devious Followers ")
		DflowSpankThresholdOID_S = AddSliderOption("Spanks To Decrease: ", SpankUtil.DflowSpankThreshold, "{0}", DFlowFlag)
		DflowResistDecOID_S = AddSliderOption("Resistance Loss: ", Dflow.DflowResistLoss, "{1}", DflowContinFlag)
		AddEmptyOption()
		
		AddHeaderOption("Milk Mod Economy ")
		MmeSlapLeakChanceOID_S = AddSliderOption("Milk Leak Chance: ", DialogUtil.MmeSlapLeakChance, "{0}%", MmeFlag)
		AddEmptyOption()
		
		AddHeaderOption("Milk Addict ")
		SpankableSlutinessDB = AddMenuOption("Armor Is Spankable From: ", ArmorSlutinessTiers[SpankableSlutiness], MilkAddictFlag)
	EndIf
EndEvent

Event OnOptionHighlight(int option)

	; Settings
	If (option == MasochismStatusOID_T)
		SetInfoText("Your current masochism status\n1 - Hates, 2 - Dislikes, 3 - Likes, 4 - Loves\nMasochism is updated every 6 game hours")
	ElseIf (option == MasochismStepSizeOID_S)
		SetInfoText("This determines how quickly you'll become a masochist\nSet it too low and you'll change too quickly\nSet it too high and you may never become a masochist or you may have to spend all day, every day getting raped, spanked and locked in DDs to change")
	ElseIf (option == MasochismStepSizeOID_S)
		SetInfoText("How many Devious Devices you can wear before it starts affecting your masochism trait\nSet to highest if you don't want DDs to influence masochism at all'")
	ElseIf (option == PauseMasochismOID)
		SetInfoText("Allows you to freeze your masochism trait progression\nReset masochism and enable this if you never want to become a masochist")
	ElseIf (option == SpanksToMaxIntensityOID_S)
		SetInfoText("How many spanks to reach maximum intensity of the overlays\nThis isn't exact as it also depends on your previous spanking sessions and their age\nIncreasing this will decrease the redness gained from one spank\nKeep in mind that your masochism progress is determined by how red your ass/tits are and for how long")
	ElseIf (option == AgeFadeFactorOID_S)
		SetInfoText("Determines how much your history of spanking will influence the redness of the overlays\nDecrease this if you want overlays to fade faster\nKeep in mind that your masochism progress is determined by how red your ass/tits are and for how long")
	ElseIf (option == MaxIntensityAssOID_S)
		SetInfoText("The maximum intensity of the redness of your ass. Lower this if you feel your ass is too red\nThis just caps the maximum redness of the overlay")
	ElseIf (option == MaxIntensityTitsOID_S)
		SetInfoText("The maximum intensity of the redness of your tits. Lower this if you feel your tits are too red\nThis just caps the maximum redness of the overlay")
	ElseIf (option == ResetAssTitsOID_T)
		SetInfoText("Reset your tits and ass redness overlays back to nothing")
	ElseIf (option == SpanksHealedOID_S)
		SetInfoText("This is how many spanks are healed when you first apply the balm and on every game hour update for the current hour\nThis option only affects spanks received this hour and every hour after the balm is applied")
	ElseIf (option == SpanksHealedDecayOID_S)
		SetInfoText("Your balm will lose this much effectiveness each hour. When it's effectiveness reaches zero the balm effect will expire\nEg: Spanks Healed = 4.0. Heal Decay = 0.5. Then you'll get (4.0 / 0.5) = 8.0 hours of healing\nThe amount of spanks healed for the current hour will be random if it's a fraction. Eg: if current Spanks Healed is 3.5 then spanks healed will either be 3 or 4")
	ElseIf (option == OldSpankHealChanceOID_S)
		SetInfoText("Spanks from before the balm was applied will have this much chance to be reduced by 1 for each of the previously tracked 48 hours")
	ElseIf (option == PlayerDialogDB)
		SetInfoText("The quality of player dialog. \nOff - Exactly that. Off completely\nVanilla - Vanilla lines only. Lines that could be cut cleanly\nCustom But Decent - A lot of editing but usually the results are 'ok'\nButchered - Badly put together lines or the tone is really unsuitable or changeable\nButchered will have the most diversity of lines. Dialog options will be more limited (and repetitive) at Vanilla or CBD")
	ElseIf (option == AlwaysUseDummyOID)
		SetInfoText("Alway use a dummy 'you' to say dialogue on your behalf. If disabled the dummy will only be used in freecam mode\nUsing the dummy should reduce conflicts/CTDs when using lots of player dialogue mods due to a 'Bethesda oversight'\nThe downside is your characters mouth won't move when using the dummy.")
	ElseIf (option == GagTalkChanceOID_S)
		SetInfoText("Normally the player will be silent when gagged\nThis is the chance for speaking 'gag talk' when a normal comment is requested by the system")
	ElseIf (option == TearsCooldownIntervalOID_S)
		SetInfoText("Tears will take this many seconds to drop one level\nGetting raped again will reset the cooldown timer")
	ElseIf (option == DroolCooldownOID_S)
		SetInfoText("Drool will take this long to disappear\nGiving head again will reset the cooldown timer")
	ElseIf (option == TearsOpacityOID_S)
		SetInfoText("How transparent tears will be")
	ElseIf (option == DroolOpacityOID_S)
		SetInfoText("How transparent drool will be")
	ElseIf (option == PainDebuffMaxOID_S)
		SetInfoText("Base Buff/Debuff applied from pain\nYour masochist level will double it at Hates or Loves status")

	ElseIf (option == SlapHeavyVolumeOID_S)
		SetInfoText("Volume of the slap/spank sounds")
	ElseIf (option == SlapMoanVolumeOID_S)
		SetInfoText("Volume of the players cries from being spanked")
	VanillaRapeSpankChanceOID_S
	ElseIf (option == DebugModeOID)
		SetInfoText("Enable/Disable debug mode")
	ElseIf (option == ExportSettingsOID_T)
		SetInfoText("Export settings to file /SKSE/Plugins/StorageUtilData/Spank That Ass/Settings.json")
	ElseIf (option == ImportSettingsOID_T)
		SetInfoText("Import settings from file /SKSE/Plugins/StorageUtilData/Spank That Ass/Settings.json")
	ElseIf (option == BumpSpankToggleOID)
		SetInfoText("Allow spanking events when you 'push' Npcs or sprint into them")
	ElseIf (option == BumpSpankNotificationsOID)
		SetInfoText("Enable/Disable notifications of what an Npc does to you when they spank you while NOT in sex - Bump spanks/Proximity spanks in SL Survival")
	ElseIf (option == BumpSpankStaggerChanceOID_S)
		SetInfoText("The chance to play a stagger animation when slapped\nSome events ignore this setting - furniture spanking etc")
	ElseIf (option == BumpSpankVibeChanceOID_S)
		SetInfoText("The chance of setting off a devious vibration event when slapped\nSlaps to the ass can set off anal/vaginal plugs\nSlaps to the tits can set off nipple piercings\nDevice must have a vibration type keyword - Primitive plugs/iron nipple piercings shouldn't set off vibes")
	ElseIf (option == SexSpankToggleOID)
		SetInfoText("Enable/Disable spanking during sex")
	ElseIf (option == FurnSpankChanceOID_S)
		SetInfoText("Chance for a random Npc to spank you while in furniture. This mostly includes crafting type furniture.\nSet to zero to disable the effect altogether.\nThis chance is checked every 8 seconds while in furniture")
	ElseIf (option == SpankStaminaPercentOID_S)
		SetInfoText("Base amount of stamina damaged/restored on spanks\nHating/Loving pain will double the amount\nRemember stamina is damaged when you Hate/Dislike and restored when you Like/Love pain")
	ElseIf (option == ArousalModifierOID_S)
		SetInfoText("Base amount of arousal gained from being spanked as a masochist or removed as not a masochist\nValues are doubled at Hates/Loves levels\nRemember SLA again modifies this value by your exposure rate")
	ElseIf (option == BakaSlaOID)
		SetInfoText("Enable this if you use Bakas modified version of Sexlab Aroused Redux\nEnables checking of armors for the additional keywords that mod adds to determine if the armor you're wearing is spankable\nIf you don't know what any of this means just leave it off.")
	ElseIf (option == SpeakKeyOID)
		SetInfoText("The key used to 'speak' during sex\nOnly available if SLSO is installed")
	ElseIf (option == OnlyFollowerSpanksOID)
		SetInfoText("Only followers will spank your character during sex")
	ElseIf (option == FollowerSexSpankChanceOID_S)
		SetInfoText("Chance for a follower to begin spanking you during a sex scene")
	ElseIf (option == SexSlapNotifyOID)
		SetInfoText("Enable/Disable slap notifications during sex")
	ElseIf (option == SexIdleCommentChanceOID)
		SetInfoText("Chance for an automatic (idle) comment during sex per update tick\nNeeds to be low as tick frequency is high during sex")
	ElseIf (option == SpankyNpcChanceOID)
		SetInfoText("Base chance when raped to get a spank-happy Npc")
	ElseIf (option == VanillaRapeSpankChanceOID_S)
		SetInfoText("Chance for a spanky type Npc to spank you per tick\nThere is short cooldown period after a spank")
	ElseIf (option == SexSoundsOID_S)
		SetInfoText("STA adds 'ass clapping' and sucking sounds to sex when you provide enjoyment\nSet to zero to disable. You must have enough stamina for a sound to play")
	ElseIf (option == SexAssClapChanceOID_S)
		SetInfoText("The chance to get an ass clap sound when fucking back\nIf fails check then a 'slimy wet' sound is played instead")
	ElseIf (option == SpankyNpcIncPerRapeOID)
		SetInfoText("Increase per rape of the chance of getting a spank-happy Npc\nThis chance is reduced back to the base chance once you get a spanky Npc")
	ElseIf (option == FuckBackTickOID_S)
		SetInfoText("The amount of allowance 'time' you're granted from spanking for fucking back as NOT a masochist\nTime is roughly equal to x seconds + script processing time\nLowering this will increase the amount of work you'll need to do to not get spanked")
	ElseIf (option == DenigrateTickOID_S)
		SetInfoText("The amount of allowance 'time' you're granted from spanking for talking shit about yourself as NOT a masochist\nTime is roughly equal to x seconds + script processing time\nLowering this will increase the amount of work you'll need to do to not get spanked")
	ElseIf (option == ResetTearsOID_T)
		SetInfoText("Removes all tear overlays and resets your stored tears status")
	ElseIf (option == ResetDroolOID_T)
		SetInfoText("Removes all drool overlays and resets your stored drool status")
	ElseIf (option == DdThresholdOID_S)
		SetInfoText("How many Devious Devices you can wear before it begins to affect your masochism trait")
	ElseIf (option == ResetPlayerMasochismOID_T)
		SetInfoText("Reset your masochism status back to zero and clears your masochism history")
		
	ElseIf (option == LowJoyThresholdOID_S)
		SetInfoText("At what enjoyment the player will pass from Low enjoyment to Mid enjoyment\nObviously the values you set should be progressive - Cum should be higher than Mid and Mid should be higher than Low")
	ElseIf (option == MidJoyThresholdOID_S)
		SetInfoText("At what enjoyment the player will pass from Mid enjoyment to High enjoyment\nObviously the values you set should be progressive - Cum should be higher than Mid and Mid should be higher than Low")
	ElseIf (option == NearOrgasmJoyThresholdOID_S)
		SetInfoText("At what enjoyment an actor will be about to cum\nObviously the values you set should be progressive - Cum should be higher than Mid and Mid should be higher than Low")
	ElseIf (option == BaseSpankEnjoymentOID_S)
		SetInfoText("How much enjoyment/unenjoyment you get from being spanked during sex depending on your masochism status\nFor eg: Base = 5 then if Masochism is Hates/Dislikes/Likes/Loves enjoyment will be -10/-5/5/10 respectively")
	
	ElseIf (option == MinStaminaRateOID_S)
		SetInfoText("Determines the stamina rate buff you'll receive during SLSO sex\nVanilla default is 5.0")	
	ElseIf (option == MinStaminaMultOID_S)
		SetInfoText("Determines the stamina rate mult buff you'll receive during SLSO sex\nVanilla default is 100")
	ElseIf (option == MinMagickaRateOID_S)
		SetInfoText("Determines the magicka rate buff you'll receive during SLSO sex\nVanilla default is 3.0")
	ElseIf (option == MinMagickaMultOID_S)
		SetInfoText("Determines the magicka rate mult buff you'll receive during SLSO sex\nVanilla default is 100")
	ElseIf (option == RapeDrainsAttributesOID)
		SetInfoText("Completely drain your magicka and stamina after rape events\nYou would probably have no stamina or magicka after rape if it wasn't for STA buffing your rates")
	ElseIf (option == DflowSpankThresholdOID_S)
		SetInfoText("Number of spanks before sending changes to Devious Followers. Set to zero to disable. This slider affects original DF and DFC differently\nDF: Once the threshold is reach it will decrease your willpower by 1\nDFC: Once the threshold is reached it will decrease instead your Resistance by the slider below")
	ElseIf (option == DflowResistDecOID_S)
		SetInfoText("Resistance lost when the spank threshold above is reached\nThis slider is only for DFC v2.06+. Note that Resistance is of type integer in version 2.06 which means that values less than 0.5 won't change you resistance at all (it's rounded up or down). To be fixed in DFC")
	ElseIf (option == MmeSlapLeakChanceOID_S)
		SetInfoText("Chance for a slap to your tits to cause them to leak\nUsual MME conditions apply: Wearing armor etc")
	ElseIf (option == SpankableSlutinessDB)
		SetInfoText("If Milk Addict is installed armors that are this revealing and up to 'Slutty' will be spankable")
	ElseIf option == IsDdIntActiveOID || option == IsSlsoIntActiveOID || option == IsMmeIntActiveOID
		SetInfoText("Displays whether an interface to this mod is in the active state or not\nInterface startup is delayed by 20 seconds on new games and by 5 seconds when a dependency is installed for the first time\nClicking this option will restart the associated interface quest")
	EndIf
EndEvent

Event OnOptionKeyMapChange(int option, int keyCode, string conflictControl, string conflictName)
	If option == SpeakKeyOID
		If conflictControl != ""
			If ShowMessage("Key is already bound to: " + conflictControl + "\nAre you sure you want to bind it?\nIt won't overwrite the control")
				SetKeyMapOptionValue(SpeakKeyOID, keyCode)
				DialogUtil.ChangeSpeakKey(KeyCode)
			EndIf
		
		Else
			SetKeyMapOptionValue(SpeakKeyOID, keyCode)
			DialogUtil.ChangeSpeakKey(KeyCode)
		EndIf
	EndIf
EndEvent

Event OnOptionMenuOpen(int option)
	If (option == PlayerDialogDB)
		SetMenuDialogStartIndex(PlayerDialog)
		SetMenuDialogDefaultIndex(3)
		SetMenuDialogOptions(PlayerDialogOptions)
	ElseIf (option == SpankableSlutinessDB)
		SetMenuDialogStartIndex(SpankableSlutiness)
		SetMenuDialogDefaultIndex(5)
		SetMenuDialogOptions(ArmorSlutinessTiers)
	EndIf
EndEvent

Event OnOptionMenuAccept(int option, int index)
	If (option == PlayerDialogDB)
		PlayerDialog = index
		SetMenuOptionValue(option, PlayerDialogOptions[PlayerDialog])
		_STA_SpankSpeech.SetValueInt(PlayerDialog)
	ElseIf (option == SpankableSlutinessDB)
		SpankableSlutiness = index
		SetMenuOptionValue(option, ArmorSlutinessTiers[SpankableSlutiness])
		IsSpankableArmor.GetIsSpankable()
	EndIf
EndEvent

Event OnOptionSelect(int option)
	
	; Settings
	If (option == ExportSettingsOID_T)
		SetTextOptionValue(ExportSettingsOID_T, "Exporting Settings ", false)
		If ShowMessage("Overwrite settings file with your current settings?")
			SaveSettings()
			SetTextOptionValue(ExportSettingsOID_T, "Done! ", false)
		Else
			SetTextOptionValue(ExportSettingsOID_T, "", false)
		Endif
	ElseIf (option == ImportSettingsOID_T)
		SetTextOptionValue(ImportSettingsOID_T, "Importing Settings ", false)
		If ShowMessage("Overwrite your current settings with the settings saved to file?")
			LoadSettings()
			SetTextOptionValue(ImportSettingsOID_T, "Done! ", false)
		Else
			SetTextOptionValue(ImportSettingsOID_T, "", false)
		Endif
	ElseIf (option == DebugModeOID)
		DebugMode = !DebugMode
		SetToggleOptionValue(DebugModeOID, DebugMode)	
	ElseIf (option == BumpSpankToggleOID)
		SpankUtil.BumpSpankToggle = !SpankUtil.BumpSpankToggle
		SetToggleOptionValue(BumpSpankToggleOID, SpankUtil.BumpSpankToggle)
	ElseIf (option == BumpSpankNotificationsOID)
		SpankUtil.BumpSpankNotifications = !SpankUtil.BumpSpankNotifications
		SetToggleOptionValue(BumpSpankNotificationsOID, SpankUtil.BumpSpankNotifications)	
	ElseIf (option == SexSpankToggleOID)
		SpankUtil.SexSpankToggle = !SpankUtil.SexSpankToggle
		SetToggleOptionValue(SexSpankToggleOID, SpankUtil.SexSpankToggle)
		
	ElseIf (option == SexSlapNotifyOID)
		SpankUtil.SexSlapNotify = !SpankUtil.SexSlapNotify
		SetToggleOptionValue(SexSlapNotifyOID, SpankUtil.SexSlapNotify)
		
	ElseIf (option == ResetAssTitsOID_T)
		SetTextOptionValue(ResetAssTitsOID_T, "Resetting ", false)
		If ShowMessage("Reset the redness of your ass and tits overlays?")
			SpankUtil.ResetTitsAndAssOverlays()
			SetTextOptionValue(ResetAssTitsOID_T, "Done! ", false)
		Else
			SetTextOptionValue(ResetAssTitsOID_T, "", false)
		Endif
	ElseIf (option == PauseMasochismOID)
		PauseMasochism = !PauseMasochism
		SetToggleOptionValue(PauseMasochismOID, PauseMasochism)	
	ElseIf (option == BakaSlaOID)
		IsSpankableArmor.BakaSla = !IsSpankableArmor.BakaSla
		SetToggleOptionValue(BakaSlaOID, IsSpankableArmor.BakaSla)
		If IsSpankableArmor.BakaSla
			IsSpankableArmor.InitBakaKeywords()
		EndIf
	ElseIf (option == OnlyFollowerSpanksOID)
		DialogUtil.OnlyFollowerSpanks = !DialogUtil.OnlyFollowerSpanks
		SetToggleOptionValue(OnlyFollowerSpanksOID, DialogUtil.OnlyFollowerSpanks)
		ForcePageReset()
	ElseIf (option == AlwaysUseDummyOID)
		AlwaysUseDummy = !AlwaysUseDummy
		SetToggleOptionValue(AlwaysUseDummyOID, AlwaysUseDummy)
	ElseIf (option == ResetTearsOID_T)
		DialogUtil.ResetTears()
		SetTextOptionValue(ResetTearsOID_T, "Done ", false)
	ElseIf (option == ResetDroolOID_T)
		DialogUtil.ResetDrool()
		DialogUtil.GetIsGagged()
		SetTextOptionValue(ResetDroolOID_T, "Done ", false)
	ElseIf (option == ResetPlayerMasochismOID_T)
		If ShowMessage("Reset your masochism status back to 'Hates'?")
			SpankUtil.ResetMasochism()
			SetTextOptionValue(ResetPlayerMasochismOID_T, "Done! ", false)
		Else
			SetTextOptionValue(ResetPlayerMasochismOID_T, "", false)
		Endif
		ForcePageReset()
	ElseIf (option == RapeDrainsAttributesOID)
		RapeDrainsAttributes = !RapeDrainsAttributes
		SetToggleOptionValue(RapeDrainsAttributesOID, RapeDrainsAttributes)
		
	ElseIf (option == IsDdIntActiveOID)
		RestartInterface(_STA_InterfaceDeviousDevicesQuest)
	ElseIf (option == IsSlsoIntActiveOID)
		RestartInterface(_STA_InterfaceSlsoQuest)
	ElseIf (option == IsMmeIntActiveOID)
		RestartInterface(_STA_InterfaceMmeQuest)
	EndIf
EndEvent

Event OnOptionDefault(int option)
	
	; Settings
	If(option == PauseMasochismOID)
		PauseMasochism = false
		SetToggleOptionValue(PauseMasochismOID, PauseMasochism)
	ElseIf(option == BakaSlaOID)
		IsSpankableArmor.BakaSla = false
		SetToggleOptionValue(BakaSlaOID, IsSpankableArmor.BakaSla)
	ElseIf(option == OnlyFollowerSpanksOID)
		DialogUtil.OnlyFollowerSpanks = false
		SetToggleOptionValue(OnlyFollowerSpanksOID, DialogUtil.OnlyFollowerSpanks)
		ForcePageReset()
	ElseIf(option == AlwaysUseDummyOID)
		AlwaysUseDummy = false
		SetToggleOptionValue(AlwaysUseDummyOID, AlwaysUseDummy)
	ElseIf(option == DebugModeOID)
		DebugMode = false
		SetToggleOptionValue(DebugModeOID, DebugMode)
	ElseIf(option == BumpSpankToggleOID)
		SpankUtil.BumpSpankToggle = true
		SetToggleOptionValue(BumpSpankToggleOID, SpankUtil.BumpSpankToggle)
	ElseIf(option == BumpSpankNotificationsOID)
		SpankUtil.BumpSpankNotifications = true
		SetToggleOptionValue(BumpSpankNotificationsOID, SpankUtil.BumpSpankNotifications)
	ElseIf(option == SexSpankToggleOID)
		SpankUtil.SexSpankToggle = true
		SetToggleOptionValue(SexSpankToggleOID, SpankUtil.SexSpankToggle)
	ElseIf(option == SexSlapNotifyOID)
		SpankUtil.SexSlapNotify = true
		SetToggleOptionValue(SexSlapNotifyOID, SpankUtil.SexSlapNotify)
	ElseIf(option == RapeDrainsAttributesOID)
		RapeDrainsAttributes = true
		SetToggleOptionValue(RapeDrainsAttributesOID, RapeDrainsAttributes)
	EndIf
EndEvent

Event OnOptionSliderOpen(int option)
	; Settings
	If (option == MasochismStepSizeOID_S)
		SetSliderDialogStartValue(SpankUtil.MasochismStepSize)
		SetSliderDialogDefaultValue(0.4)
		SetSliderDialogRange(0.1, 10.0)
		SetSliderDialogInterval(0.1)
	ElseIf (option == DdThresholdOID_S)
		SetSliderDialogStartValue(SpankUtil.DdThreshold)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 20.0)
		SetSliderDialogInterval(1.0)
		
	ElseIf (option == SpanksToMaxIntensityOID_S)
		SetSliderDialogStartValue(SpankUtil.SpanksToMaxIntensity)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
		
	ElseIf (option == AgeFadeFactorOID_S)
		SetSliderDialogStartValue(SpankUtil.AgeFadeFactor * 100.0)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)	
		
	ElseIf (option == MaxIntensityAssOID_S)
		SetSliderDialogStartValue(SpankUtil.MaxAssIntensity * 100.0)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == MaxIntensityTitsOID_S)
		SetSliderDialogStartValue(SpankUtil.MaxTitsIntensity * 100.0)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
		
	ElseIf (option == SpanksHealedOID_S)
		SetSliderDialogStartValue(SpanksHealed)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == SpanksHealedDecayOID_S)
		SetSliderDialogStartValue(SpanksHealedDecay)
		SetSliderDialogDefaultValue(0.50)
		SetSliderDialogRange(0.1, 10.0)
		SetSliderDialogInterval(0.1)
	ElseIf (option == OldSpankHealChanceOID_S)
		SetSliderDialogStartValue(OldSpankHealChance)
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
		
	ElseIf (option == GagTalkChanceOID_S)
		SetSliderDialogStartValue(SpankUtil.MaxTitsIntensity)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == TearsCooldownIntervalOID_S)
		SetSliderDialogStartValue(DialogUtil.TearsCooldownInterval)
		SetSliderDialogDefaultValue(300.0)
		SetSliderDialogRange(1.0, 600.0)
		SetSliderDialogInterval(5.0)
	ElseIf (option == DroolCooldownOID_S)
		SetSliderDialogStartValue(DialogUtil.DroolCooldown)
		SetSliderDialogDefaultValue(180.0)
		SetSliderDialogRange(1.0, 600.0)
		SetSliderDialogInterval(5.0)
	ElseIf (option == TearsOpacityOID_S)
		SetSliderDialogStartValue(DialogUtil.TearsOpacity)
		SetSliderDialogDefaultValue(0.99)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf (option == DroolOpacityOID_S)
		SetSliderDialogStartValue(DialogUtil.DroolOpacity)
		SetSliderDialogDefaultValue(0.99)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	ElseIf (option == PainDebuffMaxOID_S)
		SetSliderDialogStartValue(DialogUtil.PainDebuffMax)
		SetSliderDialogDefaultValue(40.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == SlapHeavyVolumeOID_S)
		SetSliderDialogStartValue(SpankUtil.SlapHeavyVolume * 100.0)
		SetSliderDialogDefaultValue(60.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(5.0)
	ElseIf (option == SlapMoanVolumeOID_S)
		SetSliderDialogStartValue(SpankUtil.SlapMoanVolume * 100.0)
		SetSliderDialogDefaultValue(60.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(5.0)
	ElseIf (option == SpankStaminaPercentOID_S)
		SetSliderDialogStartValue(SpankUtil.SpankStaminaPercent * 100.0)
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == ArousalModifierOID_S)
		SetSliderDialogStartValue(SpankUtil.BaseSpankArousalMod)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	
	ElseIf (option == BumpSpankStaggerChanceOID_S)
		SetSliderDialogStartValue(SpankUtil.BumpSpankStaggerChance)
		SetSliderDialogDefaultValue(65.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == BumpSpankVibeChanceOID_S)
		SetSliderDialogStartValue(SpankUtil.BumpSpankVibeChance)
		SetSliderDialogDefaultValue(33.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == FurnSpankChanceOID_S)
		SetSliderDialogStartValue(FurnSpankChance)
		SetSliderDialogDefaultValue(33.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)	
	ElseIf (option == FollowerSexSpankChanceOID_S)
		SetSliderDialogStartValue(DialogUtil.FollowerSexSpankChance)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == SexIdleCommentChanceOID)
		SetSliderDialogStartValue(DialogUtil.SexIdleCommentChance)
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.1)
	ElseIf (option == SpankyNpcChanceOID)
		SetSliderDialogStartValue(DialogUtil.SpankyNpcChance)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == SexSoundsOID_S)
		SetSliderDialogStartValue(DialogUtil.SexSoundVol * 100.0)
		SetSliderDialogDefaultValue(80.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == SexAssClapChanceOID_S)
		SetSliderDialogStartValue(DialogUtil.AssClapChance)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == SpankyNpcIncPerRapeOID)
		SetSliderDialogStartValue(SpankyNpcIncPerRape)
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == VanillaRapeSpankChanceOID_S)
		SetSliderDialogStartValue(DialogUtil.VanillaRapeSpankChance)
		SetSliderDialogDefaultValue(20.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)	
	ElseIf (option == FuckBackTickOID_S)
		SetSliderDialogStartValue(DialogUtil.FuckBackTick)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(1.0, 10.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == DenigrateTickOID_S)
		SetSliderDialogStartValue(DialogUtil.DenigrateTick)
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(1.0, 10.0)
		SetSliderDialogInterval(1.0)
		
	ElseIf (option == LowJoyThresholdOID_S)
		SetSliderDialogStartValue(DialogUtil.LowJoyThreshold)
		SetSliderDialogDefaultValue(35.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == MidJoyThresholdOID_S)
		SetSliderDialogStartValue(DialogUtil.MidJoyThreshold)
		SetSliderDialogDefaultValue(60.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == NearOrgasmJoyThresholdOID_S)
		SetSliderDialogStartValue(DialogUtil.NearOrgasmJoyThreshold)
		SetSliderDialogDefaultValue(80.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == BaseSpankEnjoymentOID_S)
		SetSliderDialogStartValue(DialogUtil.BaseSpankEnjoyment)
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(1.0, 50.0)
		SetSliderDialogInterval(1.0)
	
	ElseIf (option == MinStaminaRateOID_S)
		SetSliderDialogStartValue(DialogUtil.MinStaminaRate)
		SetSliderDialogDefaultValue(2.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	ElseIf (option == MinStaminaMultOID_S)
		SetSliderDialogStartValue(DialogUtil.MinStaminaMult)
		SetSliderDialogDefaultValue(60.0)
		SetSliderDialogRange(0.0, 200.0)
		SetSliderDialogInterval(10.0)
	ElseIf (option == MinMagickaRateOID_S)
		SetSliderDialogStartValue(DialogUtil.MinMagickaRate)
		SetSliderDialogDefaultValue(1.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	ElseIf (option == MinMagickaMultOID_S)
		SetSliderDialogStartValue(DialogUtil.MinMagickaMult)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0, 200.0)
		SetSliderDialogInterval(10.0)
	ElseIf (option == DflowSpankThresholdOID_S)
		SetSliderDialogStartValue(SpankUtil.DflowSpankThreshold)
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 50.0)
		SetSliderDialogInterval(1.0)
	ElseIf (option == DflowResistDecOID_S)
		SetSliderDialogStartValue(Dflow.DflowResistLoss)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 20.0)
		SetSliderDialogInterval(0.1)
	ElseIf (option == MmeSlapLeakChanceOID_S)
		SetSliderDialogStartValue(DialogUtil.MmeSlapLeakChance)
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndIf
EndEvent

Event OnOptionSliderAccept(int option, float value)
	
	; Settings
	If (option == MasochismStepSizeOID_S)
		SpankUtil.MasochismStepSize = value
		SetSliderOptionValue(MasochismStepSizeOID_S, SpankUtil.MasochismStepSize)
		SpankUtil.AdjustMasochismAttitude(Utility.GetCurrentGameTime())
	ElseIf (option == DdThresholdOID_S)
		SpankUtil.DdThreshold = value as Int
		SetSliderOptionValue(DdThresholdOID_S, SpankUtil.DdThreshold)		
	ElseIf (option == SpanksToMaxIntensityOID_S)
		SpankUtil.SpanksToMaxIntensity = value as Int
		SetSliderOptionValue(SpanksToMaxIntensityOID_S, SpankUtil.SpanksToMaxIntensity)
		SpankUtil.PlayerLoadsGame()
	ElseIf (option == AgeFadeFactorOID_S)
		SpankUtil.AgeFadeFactor = value / 100.0
		SetSliderOptionValue(AgeFadeFactorOID_S, SpankUtil.AgeFadeFactor * 100.0)
		SpankUtil.PlayerLoadsGame()
	ElseIf (option == MaxIntensityAssOID_S)
		SpankUtil.MaxAssIntensity = value / 100.0
		SetSliderOptionValue(MaxIntensityAssOID_S, SpankUtil.MaxAssIntensity * 100.0)
		DoSpankUtilPlayerLoadGame = true
	ElseIf (option == MaxIntensityTitsOID_S)
		SpankUtil.MaxTitsIntensity = value / 100.0
		SetSliderOptionValue(MaxIntensityTitsOID_S, SpankUtil.MaxTitsIntensity * 100.0)
		DoSpankUtilPlayerLoadGame = true
		
	ElseIf (option == SpanksHealedOID_S)
		SpanksHealed = value
		SetSliderOptionValue(SpanksHealedOID_S, SpanksHealed)
	ElseIf (option == SpanksHealedDecayOID_S)
		SpanksHealedDecay = value
		SetSliderOptionValue(SpanksHealedDecayOID_S, SpanksHealedDecay)
	ElseIf (option == OldSpankHealChanceOID_S)
		OldSpankHealChance = value
		SetSliderOptionValue(OldSpankHealChanceOID_S, OldSpankHealChance)
	ElseIf (option == GagTalkChanceOID_S)
		DialogUtil.GagTalkChance = value
		SetSliderOptionValue(GagTalkChanceOID_S, DialogUtil.GagTalkChance)
	ElseIf (option == TearsCooldownIntervalOID_S)
		DialogUtil.TearsCooldownInterval = value as Int
		SetSliderOptionValue(TearsCooldownIntervalOID_S, DialogUtil.TearsCooldownInterval)
	ElseIf (option == DroolCooldownOID_S)
		DialogUtil.DroolCooldown = value as Int
		SetSliderOptionValue(DroolCooldownOID_S, DialogUtil.DroolCooldown)	
	ElseIf (option == TearsOpacityOID_S)
		DialogUtil.TearsOpacity = value
		SetSliderOptionValue(TearsOpacityOID_S, DialogUtil.TearsOpacity)
	ElseIf (option == DroolOpacityOID_S)
		DialogUtil.DroolOpacity = value
		SetSliderOptionValue(DroolOpacityOID_S, DialogUtil.DroolOpacity)
		
	ElseIf (option == PainDebuffMaxOID_S)
		DialogUtil.PainDebuffMax = value as Int
		SetSliderOptionValue(PainDebuffMaxOID_S, DialogUtil.PainDebuffMax)
		
	ElseIf (option == SlapHeavyVolumeOID_S)
		SpankUtil.SlapHeavyVolume = value / 100.0
		SetSliderOptionValue(SlapHeavyVolumeOID_S, SpankUtil.SlapHeavyVolume)
	ElseIf (option == SlapMoanVolumeOID_S)
		SpankUtil.SlapMoanVolume = value / 100.0
		SetSliderOptionValue(SlapMoanVolumeOID_S, SpankUtil.SlapMoanVolume)
	ElseIf (option == SpankStaminaPercentOID_S)
		SpankUtil.SpankStaminaPercent = value / 100.0
		SetSliderOptionValue(SpankStaminaPercentOID_S, SpankUtil.SpankStaminaPercent)
	ElseIf (option == ArousalModifierOID_S)
		SpankUtil.BaseSpankArousalMod = value
		SetSliderOptionValue(ArousalModifierOID_S, SpankUtil.BaseSpankArousalMod)
	
	ElseIf (option == BumpSpankStaggerChanceOID_S)
		SpankUtil.BumpSpankStaggerChance = value
		SetSliderOptionValue(BumpSpankStaggerChanceOID_S, SpankUtil.BumpSpankStaggerChance)
	ElseIf (option == BumpSpankVibeChanceOID_S)
		SpankUtil.BumpSpankVibeChance = value
		SetSliderOptionValue(BumpSpankVibeChanceOID_S, SpankUtil.BumpSpankVibeChance)
	ElseIf (option == FurnSpankChanceOID_S)
		FurnSpankChance = value
		SetSliderOptionValue(FurnSpankChanceOID_S, FurnSpankChance)
		ToggleFurnitureSpankChance()
	ElseIf (option == FollowerSexSpankChanceOID_S)
		DialogUtil.FollowerSexSpankChance = value
		SetSliderOptionValue(FollowerSexSpankChanceOID_S, DialogUtil.FollowerSexSpankChance)
	ElseIf (option == SexIdleCommentChanceOID)
		DialogUtil.SexIdleCommentChance = value
		SetSliderOptionValue(SexIdleCommentChanceOID, DialogUtil.SexIdleCommentChance)
	ElseIf (option == SpankyNpcChanceOID)
		DialogUtil.SpankyNpcChance = value
		SetSliderOptionValue(SpankyNpcChanceOID, DialogUtil.SpankyNpcChance)
	ElseIf (option == SexSoundsOID_S)
		DialogUtil.SexSoundVol = value / 100.0
		SetSliderOptionValue(SexSoundsOID_S, value)
	ElseIf (option == SexAssClapChanceOID_S)
		DialogUtil.AssClapChance = value
		SetSliderOptionValue(SexAssClapChanceOID_S, DialogUtil.AssClapChance)
	ElseIf (option == SpankyNpcIncPerRapeOID)
		SpankyNpcIncPerRape = value
		SetSliderOptionValue(SpankyNpcIncPerRapeOID, SpankyNpcIncPerRape)
	ElseIf (option == VanillaRapeSpankChanceOID_S)
		DialogUtil.VanillaRapeSpankChance = value
		SetSliderOptionValue(VanillaRapeSpankChanceOID_S, DialogUtil.VanillaRapeSpankChance)
	ElseIf (option == FuckBackTickOID_S)
		DialogUtil.FuckBackTick = value as Int
		SetSliderOptionValue(FuckBackTickOID_S, DialogUtil.FuckBackTick)
	ElseIf (option == DenigrateTickOID_S)
		DialogUtil.DenigrateTick = value as Int
		SetSliderOptionValue(DenigrateTickOID_S, DialogUtil.DenigrateTick)
		
	ElseIf (option == LowJoyThresholdOID_S)
		DialogUtil.LowJoyThreshold = value as Int
		SetSliderOptionValue(LowJoyThresholdOID_S, DialogUtil.LowJoyThreshold)
	ElseIf (option == MidJoyThresholdOID_S)
		DialogUtil.MidJoyThreshold = value as Int
		SetSliderOptionValue(MidJoyThresholdOID_S, DialogUtil.MidJoyThreshold)
	ElseIf (option == NearOrgasmJoyThresholdOID_S)
		DialogUtil.NearOrgasmJoyThreshold = value as Int
		SetSliderOptionValue(NearOrgasmJoyThresholdOID_S, DialogUtil.NearOrgasmJoyThreshold)
	ElseIf (option == BaseSpankEnjoymentOID_S)
		DialogUtil.BaseSpankEnjoyment = value as Int
		SetSliderOptionValue(BaseSpankEnjoymentOID_S, DialogUtil.BaseSpankEnjoyment)
	
	ElseIf (option == MinStaminaRateOID_S)
		DialogUtil.MinStaminaRate = value
		SetSliderOptionValue(MinStaminaRateOID_S, DialogUtil.MinStaminaRate)
	ElseIf (option == MinStaminaMultOID_S)
		DialogUtil.MinStaminaMult = value
		SetSliderOptionValue(MinStaminaMultOID_S, DialogUtil.MinStaminaMult)
	ElseIf (option == MinMagickaRateOID_S)
		DialogUtil.MinMagickaRate = value
		SetSliderOptionValue(MinMagickaRateOID_S, DialogUtil.MinMagickaRate)
	ElseIf (option == MinMagickaMultOID_S)
		DialogUtil.MinMagickaMult = value
		SetSliderOptionValue(MinMagickaMultOID_S, DialogUtil.MinMagickaMult)
	ElseIf (option == DflowSpankThresholdOID_S)
		SpankUtil.DflowSpankThreshold = value as Int
		SetSliderOptionValue(DflowSpankThresholdOID_S, SpankUtil.DflowSpankThreshold)
	ElseIf (option == DflowResistDecOID_S)
		Dflow.DflowResistLoss = value
		SetSliderOptionValue(DflowResistDecOID_S, Dflow.DflowResistLoss)
	ElseIf (option == MmeSlapLeakChanceOID_S)
		DialogUtil.MmeSlapLeakChance = value
		SetSliderOptionValue(MmeSlapLeakChanceOID_S, DialogUtil.MmeSlapLeakChance)
	EndIf
	ForcePageReset()
EndEvent

; Functions ==================================================================================

Function SaveSettings()

	; Ints
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "TearsCooldownInterval", DialogUtil.TearsCooldownInterval)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "DroolCooldown", DialogUtil.DroolCooldown)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "LowJoyThreshold", DialogUtil.LowJoyThreshold)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "MidJoyThreshold", DialogUtil.MidJoyThreshold)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "NearOrgasmJoyThreshold", DialogUtil.NearOrgasmJoyThreshold)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "BaseSpankEnjoyment", DialogUtil.BaseSpankEnjoyment)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "BaseSpankEnjoyment", DialogUtil.BaseSpankEnjoyment)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "DflowSpankThreshold", SpankUtil.DflowSpankThreshold)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "FuckBackTick", DialogUtil.FuckBackTick)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "DenigrateTick", DialogUtil.DenigrateTick)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "SpanksToMaxIntensity", SpankUtil.SpanksToMaxIntensity)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "DdThreshold", SpankUtil.DdThreshold)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "SpankableSlutiness", SpankableSlutiness)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "SpeakKey", DialogUtil.SpeakKey)
	
	; Floats
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "MasochismStepSize", SpankUtil.MasochismStepSize)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "TearsOpacity", DialogUtil.TearsOpacity)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "DroolOpacity", DialogUtil.DroolOpacity)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "PainDebuffMax", DialogUtil.PainDebuffMax)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "MinStaminaRate", DialogUtil.MinStaminaRate)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "MinStaminaMult", DialogUtil.MinStaminaMult)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "MinMagickaRate", DialogUtil.MinMagickaRate)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "MinMagickaMult", DialogUtil.MinMagickaMult)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "SlapHeavyVolume", SpankUtil.SlapHeavyVolume)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "SlapMoanVolume", SpankUtil.SlapMoanVolume)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "MaxAssIntensity", SpankUtil.MaxAssIntensity)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "MaxTitsIntensity", SpankUtil.MaxTitsIntensity)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "SexIdleCommentChance", DialogUtil.SexIdleCommentChance)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "SpankyNpcChance", DialogUtil.SpankyNpcChance)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "SpankyNpcIncPerRape", SpankyNpcIncPerRape)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "VanillaRapeSpankChance", DialogUtil.VanillaRapeSpankChance)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "SpankStaminaPercent", SpankUtil.SpankStaminaPercent)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "GagTalkChance", DialogUtil.GagTalkChance)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "SpanksHealed", SpanksHealed)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "SpanksHealedDecay", SpanksHealedDecay)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "OldSpankHealChance", OldSpankHealChance)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "AgeFadeFactor", SpankUtil.AgeFadeFactor)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "BaseSpankArousalMod", SpankUtil.BaseSpankArousalMod)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "MmeSlapLeakChance", DialogUtil.MmeSlapLeakChance)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "FollowerSexSpankChance", DialogUtil.FollowerSexSpankChance)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "DflowResistLoss", Dflow.DflowResistLoss)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "BumpSpankVibeChance", SpankUtil.BumpSpankVibeChance)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "BumpSpankStaggerChance", SpankUtil.BumpSpankStaggerChance)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "SexSoundVol", DialogUtil.SexSoundVol)
	JsonUtil.SetFloatValue("Spank That Ass/Settings.json", "AssClapChance", DialogUtil.AssClapChance)
	
	; Bools
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "AlwaysUseDummy", AlwaysUseDummy as Int)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "PauseMasochism", PauseMasochism as Int)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "BumpSpankToggle", SpankUtil.BumpSpankToggle as Int)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "SexSpankToggle", SpankUtil.SexSpankToggle as Int)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "SexSlapNotify", SpankUtil.SexSlapNotify as Int)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "DebugMode", DebugMode as Int)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "BakaSla", IsSpankableArmor.BakaSla as Int)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "RapeDrainsAttributes", RapeDrainsAttributes as Int)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "OnlyFollowerSpanks", DialogUtil.OnlyFollowerSpanks as Int)
	JsonUtil.SetIntValue("Spank That Ass/Settings.json", "BumpSpankNotifications", SpankUtil.BumpSpankNotifications as Int)
	
	JsonUtil.Save("Spank That Ass/Settings.json")
EndFunction

Function LoadSettings()
	; Ints
	DialogUtil.TearsCooldownInterval = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "TearsCooldownInterval", Missing = 300)
	DialogUtil.DroolCooldown = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "DroolCooldown", Missing = 180)
	DialogUtil.LowJoyThreshold = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "LowJoyThreshold", Missing = 35)
	DialogUtil.MidJoyThreshold = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "MidJoyThreshold", Missing = 60)
	DialogUtil.NearOrgasmJoyThreshold = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "NearOrgasmJoyThreshold", Missing = 80)
	DialogUtil.BaseSpankEnjoyment = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "BaseSpankEnjoyment", Missing = 5)
	SpankUtil.DflowSpankThreshold = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "DflowSpankThreshold", Missing = 1)
	DialogUtil.FuckBackTick = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "FuckBackTick", Missing = 3)
	DialogUtil.DenigrateTick = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "DenigrateTick", Missing = 4)
	SpankUtil.SpanksToMaxIntensity = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "SpanksToMaxIntensity", Missing = 30)
	SpankUtil.DdThreshold = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "DdThreshold", Missing = 3)
	SpankableSlutiness = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "SpankableSlutiness", Missing = 5)
	DialogUtil.SpeakKey = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "SpeakKey", Missing = 258)
	
	; Floats
	SpankUtil.MasochismStepSize = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "MasochismStepSize", Missing = 0.5)
	DialogUtil.TearsOpacity = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "TearsOpacity", Missing = 0.99)
	DialogUtil.DroolOpacity = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "DroolOpacity", Missing = 0.99)
	DialogUtil.PainDebuffMax = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "PainDebuffMax", Missing = 10.0)
	DialogUtil.MinStaminaRate = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "MinStaminaRate", Missing = 2.5)
	DialogUtil.MinStaminaMult = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "MinStaminaMult", Missing = 60.0)
	DialogUtil.MinMagickaRate = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "MinMagickaRate", Missing = 1.5)
	DialogUtil.MinMagickaMult = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "MinMagickaMult", Missing = 50.0)
	SpankUtil.SlapHeavyVolume = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "SlapHeavyVolume", Missing = 0.6)
	SpankUtil.SlapMoanVolume = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "SlapMoanVolume", Missing = 0.6)
	SpankUtil.MaxAssIntensity = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "MaxAssIntensity", Missing = 1.0)
	SpankUtil.MaxTitsIntensity = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "MaxTitsIntensity", Missing = 1.0)
	DialogUtil.SexIdleCommentChance = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "SexIdleCommentChance", Missing = 5.0)
	DialogUtil.SpankyNpcChance = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "SpankyNpcChance", Missing = 30.0)
	SpankyNpcIncPerRape = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "SpankyNpcIncPerRape", Missing = 15.0)
	DialogUtil.VanillaRapeSpankChance = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "VanillaRapeSpankChance", Missing = 20.0)
	SpankUtil.SpankStaminaPercent = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "SpankStaminaPercent", Missing = 0.15)
	DialogUtil.GagTalkChance = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "GagTalkChance", Missing = 20.0)
	SpanksHealed = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "SpanksHealed", Missing = 4.0)
	SpanksHealedDecay = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "SpanksHealedDecay", Missing = 0.5)
	OldSpankHealChance = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "OldSpankHealChance", Missing = 15.0)
	SpankUtil.AgeFadeFactor = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "AgeFadeFactor", Missing = 1.0)
	SpankUtil.BaseSpankArousalMod = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "BaseSpankArousalMod", Missing = 2.0)
	DialogUtil.MmeSlapLeakChance = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "MmeSlapLeakChance", Missing = 15.0)
	DialogUtil.FollowerSexSpankChance = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "FollowerSexSpankChance", Missing = 50.0)
	Dflow.DflowResistLoss = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "DflowResistLoss", Missing = 5.0)
	FurnSpankChance = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "FurnSpankChance", Missing = 33.0)
	SpankUtil.BumpSpankVibeChance = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "BumpSpankVibeChance", Missing = 33.0)
	SpankUtil.BumpSpankStaggerChance = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "BumpSpankStaggerChance", Missing = 65.0)
	DialogUtil.SexSoundVol = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "SexSoundVol", Missing = 0.8)
	DialogUtil.AssClapChance = JsonUtil.GetFloatValue("Spank That Ass/Settings.json", "AssClapChance", Missing = 50.0)
	
	
	; Bools
	AlwaysUseDummy = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "AlwaysUseDummy", Missing = 1)
	PauseMasochism = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "PauseMasochism", Missing = 0)
	SpankUtil.BumpSpankToggle = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "BumpSpankToggle", Missing = 1)
	SpankUtil.SexSpankToggle = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "SexSpankToggle", Missing = 1)
	SpankUtil.SexSlapNotify = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "SexSlapNotify", Missing = 0)
	DebugMode = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "DebugMode", Missing = 0)
	IsSpankableArmor.BakaSla = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "BakaSla", Missing = 0)
	RapeDrainsAttributes = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "RapeDrainsAttributes", Missing = 1)
	DialogUtil.OnlyFollowerSpanks = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "OnlyFollowerSpanks", Missing = 0)
	SpankUtil.BumpSpankNotifications = JsonUtil.GetIntValue("Spank That Ass/Settings.json", "BumpSpankNotifications", Missing = 1)
	
	If IsSpankableArmor.BakaSla
		IsSpankableArmor.InitBakaKeywords()
	EndIf
	
	SetKeyMapOptionValue(SpeakKeyOID, DialogUtil.SpeakKey)
	DialogUtil.ChangeSpeakKey(DialogUtil.SpeakKey)
	
	ForcePageReset()
EndFunction

String Function GetMasochismStatus()
	Int Attitude = SpankUtil.GetMasochismAttitude(SpankUtil.PlayerMasochism)
	If Attitude == -2
		Return "Hates"
	ElseIf Attitude == -1
		Return "Dislikes"
	ElseIf Attitude == 1
		Return "Likes"
	Else
		Return "Loves"
	EndIf
EndFunction

Function BuildArrays()
	Pages = new string[1]
	Pages[0] = "Settings"

	
	PlayerDialogOptions = new string[4]
	PlayerDialogOptions[0] = "Off "
	PlayerDialogOptions[1] = "Vanilla "
	PlayerDialogOptions[2] = "Custom But Decent "
	PlayerDialogOptions[3] = "Butchered "

	ArmorSlutinessTiers = new string[8]
	ArmorSlutinessTiers[0] = "Prudish"
	ArmorSlutinessTiers[1] = "Conservative"
	ArmorSlutinessTiers[2] = "Modest"
	ArmorSlutinessTiers[3] = "Average"
	ArmorSlutinessTiers[4] = "Revealing"
	ArmorSlutinessTiers[5] = "Whoreish"
	ArmorSlutinessTiers[6] = "Slutty"
	ArmorSlutinessTiers[7] = "Disabled"
EndFunction

Function ToggleFurnitureSpankChance()
	If FurnSpankChance > 0.0
		_STA_PlayerFurnitureSpankQuest.Start()
	Else
		_STA_PlayerFurnitureSpankQuest.Stop()
	EndIf
EndFunction

Function RestartInterface(Quest TargetQuest)
	If ShowMessage("Are you sure you want to restart this interface?\n\n" + TargetQuest)
		Debug.Messagebox("Please exit the menu to apply changes")
		TargetQuest.Stop()
		Utility.Wait(0.5)
		TargetQuest.Start()
		Debug.Messagebox("Interface restarting.\nPlease note that for safety the startup is delayed by 20 seconds.\n\n" + TargetQuest)
	EndIf
EndFunction

; MCM Begin ===================================================

; Keymap
Int SpeakKeyOID

; Text
Int MasochismStatusOID_T
Int ExportSettingsOID_T
Int ImportSettingsOID_T
Int ResetTearsOID_T
Int ResetDroolOID_T
Int ResetPlayerMasochismOID_T
Int ResetAssTitsOID_T

; Toggles
Int AlwaysUseDummyOID
Int PauseMasochismOID
Int BumpSpankToggleOID
Int BumpSpankNotificationsOID
Int SexSpankToggleOID
Int SexSlapNotifyOID
Int DebugModeOID
Int BakaSlaOID
Int RapeDrainsAttributesOID
Int OnlyFollowerSpanksOID

; Sliders
Int MasochismStepSizeOID_S
Int DdThresholdOID_S
Int MaxIntensityAssOID_S
Int MaxIntensityTitsOID_S
Int TearsCooldownIntervalOID_S
Int DroolCooldownOID_S
Int TearsOpacityOID_S
Int DroolOpacityOID_S
Int PainDebuffMaxOID_S
Int LowJoyThresholdOID_S
Int MidJoyThresholdOID_S
Int NearOrgasmJoyThresholdOID_S
Int BaseSpankEnjoymentOID_S
Int MinStaminaRateOID_S
Int MinStaminaMultOID_S
Int MinMagickaRateOID_S
Int MinMagickaMultOID_S
Int DflowSpankThresholdOID_S
Int DflowResistDecOID_S
Int SlapHeavyVolumeOID_S
Int SlapMoanVolumeOID_S
Int FuckBackTickOID_S
Int DenigrateTickOID_S
Int SexIdleCommentChanceOID
Int SpankyNpcChanceOID
Int SpankyNpcIncPerRapeOID
Int VanillaRapeSpankChanceOID_S
Int SexSoundsOID_S
Int SexAssClapChanceOID_S
Int SpankStaminaPercentOID_S
Int GagTalkChanceOID_S
Int SpanksHealedOID_S
Int SpanksHealedDecayOID_S
Int OldSpankHealChanceOID_S
Int SpanksToMaxIntensityOID_S
Int AgeFadeFactorOID_S
Int ArousalModifierOID_S
Int MmeSlapLeakChanceOID_S
Int IsDdIntActiveOID
Int IsSlsoIntActiveOID
Int IsMmeIntActiveOID
Int FollowerSexSpankChanceOID_S
Int FurnSpankChanceOID_S
Int BumpSpankVibeChanceOID_S
Int BumpSpankStaggerChanceOID_S

; DialogBox
Int PlayerDialogDB
Int SpankableSlutinessDB

; Menu Variables Begin =======================================================
Int PlayerDialog = 3
Int Property SpankableSlutiness = 5 Auto Hidden

; Properties ============================================================

Bool DoSpankUtilPlayerLoadGame = false

Bool Property PauseMasochism = false Auto Hidden
Bool Property AlwaysUseDummy = true Auto Hidden
Bool Property DebugMode = false Auto Hidden 
Bool Property RapeDrainsAttributes = true Auto Hidden

Float Property SpankyNpcIncPerRape = 15.0 Auto Hidden
Float Property SpanksHealed = 4.0 Auto Hidden
Float Property SpanksHealedDecay = 0.5 Auto Hidden
Float Property OldSpankHealChance = 15.0 Auto Hidden
Float Property FurnSpankChance = 33.0 Auto Hidden

GlobalVariable Property _STA_SpankSpeech Auto

Quest Property _STA_PlayerFurnitureSpankQuest Auto
Quest Property _STA_InterfaceDeviousDevicesQuest Auto
Quest Property _STA_InterfaceMmeQuest Auto
Quest Property _STA_InterfaceSlsoQuest Auto

_STA_SexDialogUtil Property DialogUtil Auto
_STA_SpankUtil Property SpankUtil Auto
_STA_IsSpankableArmor Property IsSpankableArmor Auto

_STA_InterfaceDeviousFollowers Property Dflow Auto
