Scriptname zadDeviceLists extends Quest  

zadlibs Property libs Auto

LeveledItem Property zad_dev_all Auto
LeveledItem Property zad_dev_armbinders Auto
LeveledItem Property zad_dev_armbinders_all Auto
LeveledItem Property zad_dev_armbinders_leather Auto
LeveledItem Property zad_dev_armbinders_ebonite Auto
LeveledItem Property zad_dev_armbinders_rope Auto
LeveledItem Property zad_dev_armcuffs Auto
LeveledItem Property zad_dev_armcuffs_leather Auto
LeveledItem Property zad_dev_armcuffs_ebonite Auto
LeveledItem Property zad_dev_armcuffs_metal Auto
LeveledItem Property zad_dev_armcuffs_rope Auto
LeveledItem Property zad_dev_bb_yokes Auto
LeveledItem Property zad_dev_blindfolds Auto
LeveledItem Property zad_dev_blindfolds_cloth Auto
LeveledItem Property zad_dev_blindfolds_ebonite Auto
LeveledItem Property zad_dev_blindfolds_leather Auto
LeveledItem Property zad_dev_boots Auto
LeveledItem Property zad_dev_boots_leather Auto
LeveledItem Property zad_dev_boots_ebonite Auto
LeveledItem Property zad_dev_boots_metal Auto
LeveledItem Property zad_dev_chastitybelts Auto
LeveledItem Property zad_dev_chastitybelts_open Auto
LeveledItem Property zad_dev_chastitybelts_closed Auto
LeveledItem Property zad_dev_chastitybras Auto
LeveledItem Property zad_dev_collars Auto
LeveledItem Property zad_dev_collars_ebonite Auto
LeveledItem Property zad_dev_collars_leather Auto
LeveledItem Property zad_dev_collars_rope Auto
LeveledItem Property zad_dev_collars_metal Auto
LeveledItem Property zad_dev_corsets Auto
LeveledItem Property zad_dev_corsets_ebonite Auto
LeveledItem Property zad_dev_corsets_leather Auto
LeveledItem Property zad_dev_corsets_rope Auto
LeveledItem Property zad_dev_elbowbinders Auto
LeveledItem Property zad_dev_elbowbinders_leather Auto
LeveledItem Property zad_dev_elbowbinders_ebonite Auto
LeveledItem Property zad_dev_elbowbinders_rope Auto
LeveledItem Property zad_dev_elbowshackles Auto
LeveledItem Property zad_dev_gags Auto
LeveledItem Property zad_dev_gags_ball Auto
LeveledItem Property zad_dev_gags_ball_leather Auto
LeveledItem Property zad_dev_gags_ball_ebonite Auto
LeveledItem Property zad_dev_gags_panel Auto
LeveledItem Property zad_dev_gags_panel_leather Auto
LeveledItem Property zad_dev_gags_panel_ebonite Auto
LeveledItem Property zad_dev_gags_ring Auto
LeveledItem Property zad_dev_gags_ring_ebonite Auto
LeveledItem Property zad_dev_gags_ring_leather Auto
LeveledItem Property zad_dev_gags_rope Auto
LeveledItem Property zad_dev_gags_metal Auto
LeveledItem Property zad_dev_gloves Auto
LeveledItem Property zad_dev_gloves_leather Auto
LeveledItem Property zad_dev_gloves_ebonite Auto
LeveledItem Property zad_dev_harnesses Auto
LeveledItem Property zad_dev_harnesses_rope Auto
LeveledItem Property zad_dev_harnesses_ebonite Auto
LeveledItem Property zad_dev_harnesses_leather Auto
LeveledItem Property zad_dev_harnesses_metal Auto
LeveledItem Property zad_dev_heavyrestraints Auto
LeveledItem Property zad_dev_hoods Auto
LeveledItem Property zad_dev_legcuffs Auto
LeveledItem Property zad_dev_legcuffs_leather Auto
LeveledItem Property zad_dev_legcuffs_ebonite Auto
LeveledItem Property zad_dev_legcuffs_metal Auto
LeveledItem Property zad_dev_legcuffs_rope Auto
LeveledItem Property zad_dev_piercings Auto
LeveledItem Property zad_dev_piercings_nipple Auto
LeveledItem Property zad_dev_piercings_vaginal Auto
LeveledItem Property zad_dev_plugs Auto
LeveledItem Property zad_dev_plugs_anal Auto
LeveledItem Property zad_dev_plugs_vaginal Auto
LeveledItem Property zad_dev_suits Auto
LeveledItem Property zad_dev_suits_catsuits Auto
LeveledItem Property zad_dev_suits_formaldresses Auto
LeveledItem Property zad_dev_suits_formaldresses_leather Auto
LeveledItem Property zad_dev_suits_formaldresses_ebonite Auto
LeveledItem Property zad_dev_suits_hobbledresses Auto
LeveledItem Property zad_dev_suits_hobbledresses_leather Auto
LeveledItem Property zad_dev_suits_hobbledresses_ebonite Auto
LeveledItem Property zad_dev_suits_relaxed_hobbledresses Auto
LeveledItem Property zad_dev_suits_relaxed_hobbledresses_leather Auto
LeveledItem Property zad_dev_suits_relaxed_hobbledresses_ebonite Auto
LeveledItem Property zad_dev_suits_straitjackets Auto
LeveledItem Property zad_dev_suits_straitjackets_catsuit Auto
LeveledItem Property zad_dev_suits_straitjackets_dress Auto
LeveledItem Property zad_dev_suits_straitjackets_dress_leather Auto
LeveledItem Property zad_dev_suits_straitjackets_dress_ebonite Auto
LeveledItem Property zad_dev_suits_straitjackets_legbinder Auto
LeveledItem Property zad_dev_suits_straitjackets_legbinder_ebonite Auto
LeveledItem Property zad_dev_suits_straitjackets_legbinder_leather Auto
LeveledItem Property zad_dev_suits_straitjackets_single Auto
LeveledItem Property zad_dev_suits_straitjackets_single_leather Auto
LeveledItem Property zad_dev_suits_straitjackets_single_ebonite Auto
LeveledItem Property zad_dev_wristshackles Auto
LeveledItem Property zad_dev_yokes Auto

; This function retrieves a random device from a given list (see above).
; If you want to equip a random item on an actor (most common use case), use EquipRandomDevice() instead.
Armor Function GetRandomDevice(LeveledItem DeviceList)		
	Form frm
	Int s = DeviceList.GetNumForms() - 1
	If s < 0 
		; sanity check
		return none
	EndIf
	Int x = Utility.RandomInt(0, s)
	frm = DeviceList.GetNthForm(x)
	While (frm As Armor) == None
		; it's not an armor, but a nested LeveledItem list
		s = (frm As LeveledItem).GetNumForms() - 1
		x = Utility.RandomInt(0, s)
		frm = (frm As LeveledItem).GetNthForm(x)
	EndWhile
	Return frm as Armor
EndFunction

; Equips a random device picked from a given LeveledItem list on an actor.
Function EquipRandomDevice(Actor a, LeveledItem DeviceList)
	Armor dev = GetRandomDevice(DeviceList)
	libs.LockDevice(a, dev)
EndFunction
