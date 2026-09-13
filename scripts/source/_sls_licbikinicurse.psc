Scriptname _SLS_LicBikiniCurse extends ReferenceAlias

; The assoicated quest used to be turned off/on as needed but it's now needed on all the time to track bikini experience.

Event OnInit()
	GoToState("Off")
	If Self.GetOwningQuest().IsRunning()
		BuildSlotMasks()
		InitHeelsMgef()
		RegisterForMenu("InventoryMenu")
		RegisterForMenu("ContainerMenu")
		RegisterForMenu("Journal Menu")
		RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
		GoToState("")
		DoArmorCheck()
	EndIf
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	InitHeelsMgef()
EndEvent

Function InitHeelsMgef()
	AndInstalled = Game.GetModByName("Advanced Nudity Detection.esp") != 255 ; Re-checked each load alongside the heels mgef
	If AndInstalled
		; Subscribe for the whole session - AND's update pings drive the cover/naked/slooty
		; status (see On_SLS_AndNudityUpdate). Re-registered each load (mod-event registrations
		; don't survive save/load); -1 forces the next pass to re-apply after a load.
		RegisterForModEvent("AdvancedNudityDetectionUpdate", "On_SLS_AndNudityUpdate")
		LastAndSig = -1
	EndIf
	HdtHeelsInstalled = false
	If Game.GetModByName("hdtHighHeel.esm") != 255
		hdtMagicEffectHighHeels = Game.GetFormFromFile(0x000800, "hdtHighHeel.esm") as MagicEffect
		HdtHeelsInstalled = true
	Else
		hdtMagicEffectHighHeels = _SLS_DummyNeverUsedMgef
		HdtHeelsInstalled = false
	EndIf
EndFunction

Event OnMenuOpen(String MenuName)
	IsInMenu = true
EndEvent

Event OnMenuClose(String MenuName)
	IsInMenu = false
	If MenuName == "Journal Menu"
		GoToState("InProc")
		ArmorCheckWait()
	EndIf
EndEvent

State Off
	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	EndEvent

	Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	EndEvent
EndState

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	PreCheck(akBaseObject)
EndEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	PreCheck(akBaseObject)
EndEvent

State InProc
	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		ObjectJustEquipped = true
	EndEvent

	Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
		ObjectJustEquipped = true
	EndEvent
	
	Function PreCheck(Form akBaseObject)
	EndFunction
EndState

Function PreCheck(Form akBaseObject)
	If akBaseObject as Armor
		If !akBaseObject.HasKeyword(_SLS_BikiniArmor) && StorageUtil.GetIntValue(akBaseObject, "SLAroused.IsBikiniArmor", Missing = -1) <= 0 && !akBaseObject.HasKeyword(SexLabNoStrip)
			If !akBaseObject.HasKeyword(ArmorGauntlets) && !akBaseObject.HasKeyword(ArmorHelmet) && !(akBaseObject).HasKeyword(ArmorShield)
				If !_SLS_LicExceptionsArmor.HasForm(akBaseObject)
					GoToState("InProc")
					ArmorCheckWait()
					DoCatCallCheck()
				EndIf
			EndIf
		Else
			CheckBoots()
			DoCatCallCheck()
		EndIf
	EndIf
EndFunction

Function ArmorCheckWait()
	
	If IsInMenu ; Equipping from menu - wait for menu to close
		While IsInMenu
			Utility.Wait(2.0)
		EndWhile
		DoArmorCheck()
		
	Else  ; Not equipping from menu - Wait for equipping/unequipping to stop
		While ObjectJustEquipped
			ObjectJustEquipped = false
			Utility.Wait(2.0)
		EndWhile
		DoArmorCheck()
	EndIf
	GoToState("")
EndFunction


Function DoArmorCheck()
	; Check boots are heels. Check boots first to also set Barefoot debuff before returning
	akBaseObject = PlayerRef.GetWornForm(128) ; Feet slot
	If akBaseObject
		 If akBaseObject.HasKeywordString("BareFeet")
                                                 ;Debug.Messagebox("Player IS barefoot")
		               _SLS_PlayerIsBareFoot.SetValueInt(1)
       	                  Else                     
		                ;Debug.Messagebox("Player is not barefoot")
		                _SLS_PlayerIsBareFoot.SetValueInt(0)
                                   EndIf
		If HeelsRequired
			If !akBaseObject.HasKeyword(SexLabNoStrip) && !_SLS_LicExceptionsArmor.HasForm(akBaseObject)
				If !IsWearingHeels(PlayerRef)
					Debug.Trace("_SLS_: Bikini curse triggered by: " + akBaseObject.GetName() + " - " + akBaseObject + ". Boots are not heels!")
					Menu.BikiniCurseTriggerArmor = akBaseObject
					ToggleGlobal(1)
					Return
				EndIf
			EndIf
		EndIf
	
	Else
		;Debug.Messagebox("Player IS barefoot")
		_SLS_PlayerIsBareFoot.SetValueInt(1)
	EndIf

	Int i = SlotMasks.Length
	Form akBaseObject
	While i > 0
		i -= 1
		akBaseObject = PlayerRef.GetWornForm(SlotMasks[i])
		If akBaseObject
			If (akBaseObject as Armor).GetWeightClass() < 2
				If !akBaseObject.HasKeyword(_SLS_BikiniArmor) && StorageUtil.GetIntValue(akBaseObject, "SLAroused.IsBikiniArmor", Missing = -1) <= 0 && !akBaseObject.HasKeyword(SexLabNoStrip) && !akBaseObject.HasKeyword(ArmorBoots) && !akBaseObject.HasKeyword(ArmorGauntlets) && !akBaseObject.HasKeyword(ArmorHelmet) && !(akBaseObject).HasKeyword(ArmorShield)
					If !_SLS_LicExceptionsArmor.HasForm(akBaseObject)
						Debug.Trace("_SLS_: Bikini curse triggered by: " + akBaseObject.GetName() + " - " + akBaseObject)
						Menu.BikiniCurseTriggerArmor = akBaseObject
						;Debug.Messagebox("_SLS_: Bikini curse triggered by: " + akBaseObject.GetName() + " - " + akBaseObject + ". i = " + i)
						ToggleGlobal(1)
						;Debug.Messagebox("Is armor")
						Return
					EndIf
				EndIf
			EndIf
		EndIf
	EndWhile
	
	; Check body slot is not covered in clothing
	akBaseObject = PlayerRef.GetWornForm(4) ; Body slot
	If akBaseObject
		If (akBaseObject as Armor).GetWeightClass() == 2 ; Is clothes
			If akBaseObject.HasKeyword(ClothingBody) && !akBaseObject.HasKeyword(SexLabNoStrip) && !_SLS_LicExceptionsArmor.HasForm(akBaseObject) && !akBaseObject.HasKeyword(_SLS_BikiniArmor) && StorageUtil.GetIntValue(akBaseObject, "SLAroused.IsSlootyArmor", Missing = -1) <= 0 && StorageUtil.GetIntValue(akBaseObject, "SLAroused.IsBikiniArmor", Missing = -1) <= 0
				Debug.Trace("_SLS_: Bikini curse triggered by: " + akBaseObject.GetName() + " - " + akBaseObject)
				Menu.BikiniCurseTriggerArmor = akBaseObject
				;Debug.Messagebox("_SLS_: Bikini curse triggered by: " + akBaseObject.GetName() + " - " + akBaseObject)
				ToggleGlobal(1)
				;Debug.Messagebox("Is clothes")
				Return
			EndIf
		EndIf
	EndIf
		
	;Debug.Messagebox("In the clear")
	Menu.BikiniCurseTriggerArmor = None
	;Debug.Trace("_SLS_: Bikini curse - All Clear")
	ToggleGlobal(0)
EndFunction

Function CheckBoots()
	Form akBaseObject = PlayerRef.GetWornForm(128)
	If akBaseObject
                                  If akBaseObject.HasKeywordString("BareFeet")
                                                 ;Debug.Messagebox("Player IS barefoot")
		               _SLS_PlayerIsBareFoot.SetValueInt(1)
       	                  Else                     
		                ;Debug.Messagebox("Player is not barefoot")
		                _SLS_PlayerIsBareFoot.SetValueInt(0)
                                   EndIf
	Else
		;Debug.Messagebox("Player IS barefoot")
		_SLS_PlayerIsBareFoot.SetValueInt(1)
	EndIf
EndFunction

Function ToggleGlobal(Int Value)
	Int i = _SLS_LicBikiniCurseIsWearingArmor.GetValueInt()
	If i != Value ; If global is being toggled then update the players bikini experience up to this point, then toggle
		If _SLS_BikiniExpTrainingQuest.IsRunning()
			BikExp.DoUpdate()
		EndIf
	EndIf
	DoShortBreathEffect(Value)
	_SLS_LicBikiniCurseIsWearingArmor.SetValueInt(Value)
EndFunction

Function DoShortBreathEffect(Int Value)
	If Value == 1 && LicUtil.HasValidBikiniLicence && !LicUtil.HasValidArmorLicence && LicUtil.BikiniCurseEnable ; Add/remove breathlessness effect
		PlayerRef.AddSpell(_SLS_BikCurseShortBreathSpell, false)
	Else
		PlayerRef.RemoveSpell(_SLS_BikCurseShortBreathSpell)
	EndIf
EndFunction

Function BuildSlotMasks()
	SlotMasks = new Int[27]
	;SlotMasks[0] = 1 ; kSlotMask30 - Ignore Head
	;SlotMasks[1] = 2 ; kSlotMask31 - Ignore Hair
	SlotMasks[0] = 4 ; kSlotMask32
	;SlotMasks[3] = 8 ; kSlotMask33 - Ignore Hands
	SlotMasks[1] = 16 ; kSlotMask34
	SlotMasks[2] = 32 ; kSlotMask35
	SlotMasks[3] = 64 ; kSlotMask36
	;SlotMasks[7] = 128 ; kSlotMask37 - Ignore Feet
	SlotMasks[4] = 256 ; kSlotMask38
	;SlotMasks[9] = 512 ; kSlotMask39 - Ignore shield slot
	SlotMasks[5] = 1024 ; kSlotMask40
	SlotMasks[6] = 2048 ; kSlotMask41
	SlotMasks[7] = 4096 ; kSlotMask42
	SlotMasks[8] = 8192 ; kSlotMask43
	SlotMasks[9] = 16384 ; kSlotMask44
	SlotMasks[10] = 32768 ; kSlotMask45
	SlotMasks[11] = 65536 ; kSlotMask46
	SlotMasks[12] = 131072 ; kSlotMask47
	SlotMasks[13] = 262144 ; kSlotMask48
	SlotMasks[14] = 524288 ; kSlotMask49
	SlotMasks[15] = 1048576 ; kSlotMask50
	SlotMasks[16] = 2097152 ; kSlotMask51
	SlotMasks[17] = 4194304 ; kSlotMask52
	SlotMasks[18] = 8388608 ; kSlotMask53
	SlotMasks[19] = 16777216 ; kSlotMask54
	SlotMasks[20] = 33554432 ; kSlotMask55
	SlotMasks[21] = 67108864 ; kSlotMask56
	SlotMasks[22] = 134217728 ; kSlotMask57
	SlotMasks[23] = 268435456 ; kSlotMask58
	SlotMasks[24] = 536870912 ; kSlotMask59
	SlotMasks[25] = 1073741824 ; kSlotMask60
	SlotMasks[26] = 0x80000000 ; kSlotMask61 - Use hex otherwise number ends up being 1 short....?
EndFunction

Bool Function IsWearingHeels(Actor akTarget)
	If HasHdtHeels(akTarget) || HasNioHeels(akTarget) || HasKillerHeels(akTarget)
		Return true
	EndIf
	Return false	
EndFunction

Bool Function HasHdtHeels(Actor akTarget)
	If HdtHeelsInstalled && akTarget.HasMagicEffect(hdtMagicEffectHighHeels) ; Check for HDT heels
		Return true
	EndIf
	Return false
EndFunction

Bool Function HasNioHeels(Actor akTarget)
	Int IsFemale = akTarget.GetLeveledActorBase().GetSex()
	If NiOverride.HasNodeTransformPosition(akTarget, False, IsFemale, "NPC", "internal")
		;Float[] Pos = NiOverride.GetNodeTransformPosition(akTarget, false, IsFemale, "NPC", "internal")
		If NiOverride.GetNodeTransformPosition(akTarget, false, IsFemale, "NPC", "internal")[2] >= HeelHeightRequired
			Return true
		EndIf
	EndIf
	Return false
EndFunction

Bool Function HasKillerHeels(Actor akTarget)
	Form Boots = PlayerRef.GetWornForm(0x00000080)
	If Boots
		If StorageUtil.GetIntValue(Boots, "SLAroused.IsKillerHeels", Missing = -1) > 0
			Return true
		EndIf
	EndIf
	Return false
EndFunction

Function DoCatCallCheck()
	; Check is body slot armor eligible for cat calling
	Form akBaseObject = PlayerRef.GetWornForm(4) ; Body slot

	; Advanced Nudity Detection sees what is actually rendered (transparent meshes, partial
	; coverage, non-body-slot outfits), so when present its verdict replaces the body-slot
	; check. AND's scan is async (it reads the rebuilding body, ~3s behind an equip), but every
	; scan pass re-fires AdvancedNudityDetectionUpdate and On_SLS_AndNudityUpdate recomputes
	; from it - so if this equip-time read is still stale, the next pass self-corrects. No wait.
	If AndInstalled
		ApplyFromAnd(akBaseObject)
	Else
		ApplyCoverStatus(akBaseObject, !akBaseObject)
	EndIf
EndFunction

; AND re-fires AdvancedNudityDetectionUpdate on EVERY scan pass (per footstep, per equip, and
; its game-time timer) - never a single "verdict final" signal. So we stay subscribed the whole
; time (registered in InitHeelsMgef, per game load) and just recompute whenever AND's exposure
; verdict actually changes. The signature compare is the cheap per-footstep guard: an unchanged
; verdict - the overwhelming common case - returns before any of ApplyCoverStatus's real work.
Event On_SLS_AndNudityUpdate(string eventName, string strArg, float numArg, Form sender)
	If !AndInstalled || !GetOwningQuest().IsRunning() ; stopped quests still receive mod events
		Return
	EndIf
	Int Sig = AndExposureSig()
	If Sig == LastAndSig
		Return
	EndIf
	LastAndSig = Sig
	ApplyCoverStatus(PlayerRef.GetWornForm(4), Math.LogicalAnd(Sig, 1) == 1) ; bit 0 = naked
EndEvent

Function ApplyFromAnd(Form akBaseObject)
	Int Sig = AndExposureSig()
	LastAndSig = Sig ; keep the listener's cache in step so it won't redundantly re-fire
	ApplyCoverStatus(akBaseObject, Math.LogicalAnd(Sig, 1) == 1)
EndFunction

Int Function AndExposureSig()
	; Bit 0 = naked, 1 = underwear, 2 = otherwise revealing. Any exposure change flips the value
	; and triggers a recompute; between equips a fixed outfit reads the same, so the guard holds.
	Int Sig = 0
	If _SLS_IntAnd.IsNude(PlayerRef)
		Sig = Sig + 1
	EndIf
	If _SLS_IntAnd.IsInUnderwear(PlayerRef)
		Sig = Sig + 2
	EndIf
	If _SLS_IntAnd.IsRevealing(PlayerRef)
		Sig = Sig + 4
	EndIf
	Return Sig
EndFunction

Function ApplyCoverStatus(Form akBaseObject, Bool PlayerIsNaked)
	If PlayerIsNaked
		_SLS_BodyCoverStatus.SetValueInt(0) ; Player is naked
		SendModEvent(eventName = "_SLS_IntCoverShutdown", strArg = "", numArg = 0.0)
		If Menu.CoverMyselfMechanics
			_SLS_CoverMySelfQuest.Start()
		EndIf
		Return
	EndIf

	; Get is armor set as whoreish or slutty in Milk addict
	Int MaSlutiness = -1
	If akBaseObject && Init.MilkAddictInstalled
		Int Index = JsonUtil.FormListFind("Milk Addict/SlutClothes.json", "ClothesList", akBaseObject)
		If Index > -1
			MaSlutiness = JsonUtil.IntListGet("Milk Addict/SlutClothes.json", "Sluttiness", Index)
		EndIf
	EndIf

	; The bikini/slooty keyword checks stay even with AND installed: bikini armor can cover
	; everything AND tracks while still deserving cat calls (bikini licence mechanics).
	Bool IsSlooty = false
	If akBaseObject
		IsSlooty = akBaseObject.HasKeyword(_SLS_BikiniArmor) || akBaseObject.HasKeyword(_SLS_HalfNakedCoverKw) || StorageUtil.GetIntValue(akBaseObject, "SLAroused.IsSlootyArmor", Missing = -1) > 0 || StorageUtil.GetIntValue(akBaseObject, "SLAroused.IsBikiniArmor", Missing = -1) > 0 || (MaSlutiness >= 5 && MaSlutiness <=6)
	EndIf
	If !IsSlooty && AndInstalled
		; Dressed but visibly exposed (sheer/skimpy/partial), or down to bra/panties - the
		; latter is the half-naked tier the _SLS_HalfNakedCoverArmor marker used to flag,
		; now read straight from AND since HalfNakedCover stands down when AND is present.
		IsSlooty = _SLS_IntAnd.IsRevealing(PlayerRef) || _SLS_IntAnd.IsInUnderwear(PlayerRef)
	EndIf

	If IsSlooty
		_SLS_BodyCoverStatus.SetValueInt(1) ; Bikini/slooty etc
		SendModEvent(eventName = "_SLS_IntCoverShutdown", strArg = "", numArg = 1.0)
	Else
		_SLS_BodyCoverStatus.SetValue(2) ; Full cover
		SendModEvent(eventName = "_SLS_IntCoverShutdown", strArg = "", numArg = 2.0)
	EndIf
EndFunction

Int[] SlotMasks
Bool IsInMenu = false
Bool ObjectJustEquipped = false
Bool HdtHeelsInstalled = false
Bool AndInstalled = false ; Advanced Nudity Detection present - set in InitHeelsMgef()
Int LastAndSig = -1 ; last AND exposure verdict applied (bit0 naked / bit1 underwear / bit2 revealing); -1 = recompute on next pass

Bool Property HeelsRequired = true Auto Hidden
Float Property HeelHeightRequired = 5.0 Auto Hidden

Keyword Property _SLS_HalfNakedCoverKw Auto
Keyword Property _SLS_BikiniArmor Auto
Keyword Property SexLabNoStrip Auto
Keyword Property ClothingBody Auto
Keyword Property ArmorBoots Auto
Keyword Property ArmorGauntlets Auto
Keyword Property ArmorHelmet Auto
Keyword Property ArmorShield Auto
Keyword Property BareFeet Auto

MagicEffect Property hdtMagicEffectHighHeels Auto Hidden
MagicEffect Property _SLS_DummyNeverUsedMgef Auto

Spell Property _SLS_BikCurseShortBreathSpell Auto

Actor Property PlayerRef Auto

GlobalVariable Property _SLS_LicBikiniCurseIsWearingArmor Auto
GlobalVariable Property _SLS_PlayerIsBareFoot Auto
GlobalVariable Property _SLS_BodyCoverStatus Auto ; 0 - Naked, 1 - Bikini/Slooty armor/clothes, 2 - Non skimpy armor/clothes

Formlist Property _SLS_LicExceptionsArmor Auto

Quest Property _SLS_BikiniExpTrainingQuest Auto
Quest Property _SLS_CoverMySelfQuest Auto

_SLS_BikiniExpTraining Property BikExp Auto
_SLS_LicenceUtil Property LicUtil Auto
SLS_Mcm Property Menu Auto
SLS_Init Property Init Auto
