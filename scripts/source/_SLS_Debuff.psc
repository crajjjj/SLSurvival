Scriptname _SLS_Debuff Hidden

; Debuff notices go through here so the MCM's Debuff Notifications toggle silences all of them.
; The toggle is a global StorageUtil value rather than an MCM property, so magic effect scripts can
; read it without a new CK-filled property.
; Category: notices of one category share a cooldown, so boots off/on/off says "barefoot" once.
Function Notify(String Category, String Msg) Global
	If StorageUtil.GetIntValue(None, "_SLS_DebuffNotify", Missing = 1) != 1
		Return
	EndIf
	; Real time counts from game launch and the stamp lives in the co-save, so a stamp ahead of
	; now is from an earlier session and has expired
	Float Now = Utility.GetCurrentRealTime()
	Float Last = StorageUtil.GetFloatValue(None, "_SLS_DebuffNotifyAt_" + Category, Missing = -1000.0)
	If Now >= Last && Now - Last < 60.0
		Return
	EndIf
	StorageUtil.SetFloatValue(None, "_SLS_DebuffNotifyAt_" + Category, Now)
	Debug.Notification(Msg)
EndFunction

; The Debuffs line of the wheel's Status list. Orgasm fatigue and cum hunger have lines of their own there.
String Function GetStatusString() Global
	Actor PlayerRef = Game.GetPlayer()
	String Debuffs = ""
	; The barefoot effect is conditioned (crawling and werewolf switch it off), so ask for the effect
	; and the global both
	If (Game.GetFormFromFile(0x0783BF, "SL Survival.esp") as GlobalVariable).GetValueInt() == 1 && PlayerRef.HasMagicEffect(Game.GetFormFromFile(0x0783C0, "SL Survival.esp") as MagicEffect) ; _SLS_PlayerIsBareFoot, _SLS_BarefootSpeedMgef
		Debuffs = AddToList(Debuffs, "Barefoot")
	EndIf
	If PlayerRef.HasSpell(Game.GetFormFromFile(0x04F450, "SL Survival.esp")) || PlayerRef.HasSpell(Game.GetFormFromFile(0x04F454, "SL Survival.esp")) || PlayerRef.HasSpell(Game.GetFormFromFile(0x04F44D, "SL Survival.esp")) || PlayerRef.HasSpell(Game.GetFormFromFile(0x04F452, "SL Survival.esp")) ; heavy bondage lockpick/pickpocket, difficult/impossible
		Debuffs = AddToList(Debuffs, "Heavy bondage")
	EndIf
	If PlayerRef.HasSpell(Game.GetFormFromFile(0x07CF47, "SL Survival.esp")) ; _SLS_BikCurseShortBreathSpell
		Debuffs = AddToList(Debuffs, "Bikini curse (short of breath)")
	EndIf
	If PlayerRef.HasSpell(Game.GetFormFromFile(0x045C3C, "SL Survival.esp")) || PlayerRef.HasSpell(Game.GetFormFromFile(0x045161, "SL Survival.esp")) ; _SLS_MagicLicenceCurse, _SLS_MagicLicenceCollarSpell
		Debuffs = AddToList(Debuffs, "Magicka curse")
	EndIf
	If PlayerRef.HasSpell(Game.GetFormFromFile(0x0C36DB, "SL Survival.esp")) ; _SLS_DeviousDrowningSpell
		Debuffs = AddToList(Debuffs, "Drowning")
	EndIf
	If PlayerRef.HasMagicEffect(Game.GetFormFromFile(0x0778F8, "SL Survival.esp") as MagicEffect) ; _SLS_DrugFatigueIncMgef
		Debuffs = AddToList(Debuffs, "Drug comedown ahead")
	EndIf
	If Debuffs == ""
		Return "None"
	EndIf
	Return Debuffs
EndFunction

String Function AddToList(String List, String Item) Global
	If List == ""
		Return Item
	EndIf
	Return List + ", " + Item
EndFunction

; SexLab strips and redresses the player around every scene, which flips the equipment-driven
; debuffs (barefoot) on and off; those are no news during a scene
Bool Function PlayerInScene() Global
	Return Game.GetPlayer().IsInFaction(Game.GetFormFromFile(0x00E50F, "SexLab.esm") as Faction)
EndFunction
