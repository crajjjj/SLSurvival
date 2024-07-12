Scriptname _SLS_ForcedDrugging extends Quest

Event OnInit()
	If Self.IsRunning()
		TollDrugLactacid = Game.GetModByName("MilkModNEW.esp") != 255
		TollDrugSkooma = Game.GetModByName("SexLabSkoomaWhore.esp") != 255
		TollDrugHumanCum = true
		TollDrugCreatureCum = false
		TollDrugInflate = Game.GetModByName("SexLab Inflation Framework.esp") != 255
		TollDrugFmFertility = Game.GetModByName("Fertility Mode.esm") != 255
		TollDrugSlenAphrodisiac = Game.GetModByName("SexLab Eager NPCs.esp") != 255
		TollDrugSensitivity = Game.GetModByName("SLSO.esp") != 255
		
		RapeDrugLactacid = TollDrugLactacid
		RapeDrugSkooma = TollDrugSkooma
		RapeDrugHumanCum = TollDrugHumanCum
		RapeDrugCreatureCum = TollDrugCreatureCum
		RapeDrugInflate = TollDrugInflate
		RapeDrugFmFertility = TollDrugFmFertility
		RapeDrugSlenAphrodisiac = TollDrugSlenAphrodisiac
		RapeDrugSensitivity = TollDrugSensitivity
	EndIf
EndEvent

Function DoTollDrugs(Actor akTarget, Int Quantity, Bool Silent = true)
	Util.SuspendSwAddicted()
	While Quantity > 0
		Quantity -= 1
		DoForceDrug(akTarget, 1, Silent = false, DoLactacid = TollDrugLactacid, DoSkooma = TollDrugSkooma, DoHumanCum = TollDrugHumanCum, DoCreatureCum = TollDrugCreatureCum, DoInflate = TollDrugInflate, DoFmFertility = TollDrugFmFertility, DoSlenAphrodisiac = TollDrugSlenAphrodisiac, DoSensitivity = TollDrugSensitivity)	
	EndWhile
	Util.ResumeSwAddicted()
EndFunction

Function DoRapeDrugs(Actor akTarget, Int Quantity, Bool Silent = true)
	Util.SuspendSwAddicted()
	While Quantity > 0
		Quantity -= 1
		DoForceDrug(akTarget, 1, Silent = false, DoLactacid = RapeDrugLactacid, DoSkooma = RapeDrugSkooma, DoHumanCum = RapeDrugHumanCum, DoCreatureCum = RapeDrugCreatureCum, DoInflate = RapeDrugInflate, DoFmFertility = RapeDrugFmFertility, DoSlenAphrodisiac = RapeDrugSlenAphrodisiac, DoSensitivity = RapeDrugSensitivity)	
	EndWhile
	Util.ResumeSwAddicted()
EndFunction

Function ForceDrug(Actor akTarget, String[] Drugs, Int Quantity, Bool Silent = true)
	GoToState(Drugs[Utility.RandomInt(0, Drugs.Length - 1)])
	
	If GetState() != ""
		Form akDrug
		While Quantity > 0
			Quantity -= 1
			akDrug = GetDrug(akTarget)
			akTarget.AddItem(akDrug, 1, Silent)
			akTarget.EquipItem(akDrug, false, Silent)
		EndWhile
	EndIf
EndFunction

Bool Function GetCanDoMilkOrSkooma()
	Return CanDoForcedDrugs(PlayerRef, DoLactacid = TollDrugLactacid, DoSkooma = TollDrugSkooma, DoHumanCum = TollDrugHumanCum, DoCreatureCum = TollDrugCreatureCum, DoInflate = TollDrugInflate, DoFmFertility = TollDrugFmFertility, DoSlenAphrodisiac = TollDrugSlenAphrodisiac, DoSensitivity = TollDrugSensitivity)
EndFunction

Bool Function CanDoForcedDrugs(Actor akTarget, Bool DoLactacid = true, Bool DoSkooma = true, Bool DoHumanCum = true, Bool DoCreatureCum = true, Bool DoInflate = true, Bool DoFmFertility = true, Bool DoSlenAphrodisiac = true, Bool DoSensitivity = true)
	; Lactacid
	If DoLactacid && Init.MaAddictionPool && Init.MaAddictionPool.GetValueInt() < 400
		Return true
	EndIf
	
	; Skooma
	If DoSkooma && Init.SwPhysicalDecay && Init.SwPhysicalDecay.GetValueInt() < 500
		Return true
	EndIf
	
	; Cum
	If (DoHumanCum || DoCreatureCum) && Menu.CumAddictEn && _SLS_CumAddictionPool.GetValueInt() < 400
		; Human Cum
		Return true
	EndIf
	
	If DoInflate && Game.GetModByName("SexLab Inflation Framework.esp") != 255 && !_SLS_InflatePotionQuest.IsRunning()
		Return true
	EndIf
	
	; Fertility Mode fertility potion
	If DoFmFertility && Game.GetModByName("Fertility Mode.esm") != 255 && !(akTarget.HasMagicEffect(Game.GetFormFromFile(0x0058D4, "Fertility Mode.esm") as MagicEffect))
		Return true
	EndIf

	; SLEN Aphrodisiac potion
	If DoSlenAphrodisiac && Game.GetModByName("SexLab Eager NPCs.esp") != 255 && !(akTarget.HasMagicEffectWithKeyword(Game.GetFormFromFile(0x021E40, "SexLab Eager NPCs.esp") as Keyword))
		Return true
	EndIf
	
	; Sensitivity potion
	If DoSensitivity && StorageUtil.GetFloatValue(None, "_SLS_PlayerSexSensitivity", Missing = 0.0) < 9.0
		Return true
	EndIf
	
	Return false
EndFunction

Function DoForceDrug(Actor akTarget, Int Quantity = 1, Bool Silent = true, Bool DoLactacid = true, Bool DoSkooma = true, Bool DoHumanCum = true, Bool DoCreatureCum = true, Bool DoInflate = true, Bool DoFmFertility = true, Bool DoSlenAphrodisiac = true, Bool DoSensitivity = true)	
	StorageUtil.StringListClear(Self, "_SLS_PotentialDrugsList")
	
	; Lactacid
	If DoLactacid && Init.MaAddictionPool && Init.MaAddictionPool.GetValueInt() < 400
		StorageUtil.StringListAdd(Self, "_SLS_PotentialDrugsList", "Lactacid")
	EndIf
	
	; Skooma
	If DoSkooma && Init.SwPhysicalDecay && Init.SwPhysicalDecay.GetValueInt() < 500
		StorageUtil.StringListAdd(Self, "_SLS_PotentialDrugsList", "Skooma")
	EndIf
	
	; Cum
	If Menu.CumAddictEn && _SLS_CumAddictionPool.GetValueInt() < 400
		; Human Cum
		If DoHumanCum
			StorageUtil.StringListAdd(Self, "_SLS_PotentialDrugsList", "HumanCum")
		EndIf
		
		; Creature Cum
		If DoCreatureCum
			StorageUtil.StringListAdd(Self, "_SLS_PotentialDrugsList", "CreatureCum")
		EndIf
	EndIf
	
	; Futa curse ?
	; 'Mysterious potion'. Must be consumed 3? times. Sleeping = give the player a huge (horse/optional?) cock and balls
	; Must impregnate 10/random? women to remove curse. Women won't be cooperative in helping a freak. Must force yourself on them (defeat etc)
	; Player won't be able to orgasm via masturbation, only edge. 
	
	; Scaling potion
	If DoInflate && Game.GetModByName("SexLab Inflation Framework.esp") != 255 && !_SLS_InflatePotionQuest.IsRunning()
		StorageUtil.StringListAdd(Self, "_SLS_PotentialDrugsList", "InflatePotion")
	EndIf
	
	; Fertility Mode fertility potion
	If DoFmFertility && Game.GetModByName("Fertility Mode.esm") != 255 && !(akTarget.HasMagicEffect(Game.GetFormFromFile(0x0058D4, "Fertility Mode.esm") as MagicEffect))
		StorageUtil.StringListAdd(Self, "_SLS_PotentialDrugsList", "FmFertilityPotion")
	EndIf

	; SLEN Aphrodisiac potion
	If DoSlenAphrodisiac && Game.GetModByName("SexLab Eager NPCs.esp") != 255 && !(akTarget.HasMagicEffectWithKeyword(Game.GetFormFromFile(0x021E40, "SexLab Eager NPCs.esp") as Keyword))
		StorageUtil.StringListAdd(Self, "_SLS_PotentialDrugsList", "SlenAphrodisiac")
	EndIf
	
	; Sensitivity Potion
	If DoSensitivity && StorageUtil.GetFloatValue(None, "_SLS_PlayerSexSensitivity", Missing = 0.0) < 9.0
		StorageUtil.StringListAdd(Self, "_SLS_PotentialDrugsList", "Sensitivity")
	EndIf
	
	If StorageUtil.StringListCount(Self, "_SLS_PotentialDrugsList") > 0
		ForceDrug(akTarget, Drugs = StorageUtil.StringListToArray(Self, "_SLS_PotentialDrugsList"), Quantity = Quantity, Silent = Silent)
	Else
		Debug.Trace("_SLS_: DoForceDrug(): No options available")
	EndIf
EndFunction

Form Function GetSlenAphrodisiac()
	If StorageUtil.FormListCount(Self, "SlenAphrodisiacsList") == 0
		StorageUtil.FormListAdd(Self, "SlenAphrodisiacsList", Game.GetFormFromFile(0x021369, "SexLab Eager NPCs.esp")) ; Elixir of Aphrodisia
		StorageUtil.FormListAdd(Self, "SlenAphrodisiacsList", Game.GetFormFromFile(0x021377, "SexLab Eager NPCs.esp")) ; Potion of Aphrodisia
		StorageUtil.FormListAdd(Self, "SlenAphrodisiacsList", Game.GetFormFromFile(0x021376, "SexLab Eager NPCs.esp")) ; Draught of Aphrodisia
		StorageUtil.FormListAdd(Self, "SlenAphrodisiacsList", Game.GetFormFromFile(0x021370, "SexLab Eager NPCs.esp")) ; Philter of Aphrodisia
	EndIf
	Return StorageUtil.FormListGet(Self, "SlenAphrodisiacsList", Utility.RandomInt(0, 3))
EndFunction

Form Function GetDrug(Actor akTarget)
	Return None
EndFunction

State Lactacid
	Form Function GetDrug(Actor akTarget)
		Return Game.GetFormFromFile(0x0343F2, "MilkModNEW.esp")
	EndFunction
EndState

State Skooma
	Form Function GetDrug(Actor akTarget)
		Return _SLS_DrugsListWoLactacid.GetAt(Utility.RandomInt(0, _SLS_DrugsListWoLactacid.GetSize() - 1))
	EndFunction
EndState

State HumanCum
	Form Function GetDrug(Actor akTarget)
		Return _SLS_CumPotionHuman.GetAt(Utility.RandomInt(0, _SLS_CumPotionHuman.GetSize() - 1))
	EndFunction
EndState

State CreatureCum
	Form Function GetDrug(Actor akTarget)
		Return _SLS_CumPotionCreature.GetAt(Utility.RandomInt(0, _SLS_CumPotionCreature.GetSize() - 1))
	EndFunction
EndState

State InflatePotion
	Form Function GetDrug(Actor akTarget)
		Return _SLS_InflatePotionPot
	EndFunction
EndState

State FmFertilityPotion
	Form Function GetDrug(Actor akTarget)
		Return Game.GetFormFromFile(0x0058D2, "Fertility Mode.esm")
	EndFunction
EndState

State SlenAphrodisiac
	Form Function GetDrug(Actor akTarget)
		Return GetSlenAphrodisiac()
	EndFunction
EndState

State Sensitivity
	Form Function GetDrug(Actor akTarget)
		Return _SLS_SensitivityPotList.GetAt(Utility.RandomInt(0, _SLS_SensitivityPotList.GetSize() - 1))
	EndFunction
EndState

Bool Property TollDrugLactacid Auto Hidden
Bool Property TollDrugSkooma Auto Hidden
Bool Property TollDrugHumanCum Auto Hidden
Bool Property TollDrugCreatureCum Auto Hidden
Bool Property TollDrugInflate Auto Hidden
Bool Property TollDrugFmFertility Auto Hidden
Bool Property TollDrugSlenAphrodisiac Auto Hidden
Bool Property TollDrugSensitivity = true Auto Hidden

Bool Property RapeDrugLactacid Auto Hidden
Bool Property RapeDrugSkooma  Auto Hidden
Bool Property RapeDrugHumanCum Auto Hidden
Bool Property RapeDrugCreatureCum Auto Hidden
Bool Property RapeDrugInflate Auto Hidden
Bool Property RapeDrugFmFertility Auto Hidden
Bool Property RapeDrugSlenAphrodisiac Auto Hidden
Bool Property RapeDrugSensitivity = true Auto Hidden

Formlist Property _SLS_DrugsListWoLactacid Auto
Formlist Property _SLS_CumPotionHuman Auto
Formlist Property _SLS_CumPotionCreature Auto
Formlist Property _SLS_SensitivityPotList Auto

Potion Property _SLS_InflatePotionPot Auto

GlobalVariable Property _SLS_CumAddictionPool Auto

Actor Property PlayerRef Auto

Quest Property _SLS_InflatePotionQuest Auto

SLS_Utility Property Util Auto
SLS_Init Property Init Auto
SLS_Mcm Property Menu Auto
