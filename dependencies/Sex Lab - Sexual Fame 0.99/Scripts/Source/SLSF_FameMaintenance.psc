Scriptname SLSF_FameMaintenance extends Quest

SLSF_Configuration Property Config Auto
SLSF_Utility Property SLSFUtility Auto
SexLabFramework Property SexLab Auto

Actor Property PlayerRef Auto
Spell Property Counter_Per Auto
Spell Property Counter_SL Auto
Spell Property Counter_Ext Auto
Spell Property Counter_Int Auto

MagicEffect Property Naked Auto
MagicEffect Property SumSur5Sight Auto
MagicEffect Property SumSur3Sight Auto
MagicEffect Property SumSur1Sight Auto
MagicEffect Property OtherSur9 Auto
MagicEffect Property FaceSur3Sight Auto
MagicEffect Property BodySur3Sight Auto
MagicEffect Property FaceSur1Sight Auto
MagicEffect Property BodySur1Sight Auto
MagicEffect Property FeetSur1Sight Auto
MagicEffect Property HandsSur1Sight Auto
MagicEffect Property Anonymous Auto
MagicEffect Property FaceSur3Sight_H Auto
MagicEffect Property BodySur3Sight_H Auto
FormList Property RaceList Auto
Faction Property RoleType Auto
Keyword Property SLCumAnal Auto
Keyword Property SLCumOral Auto
Keyword Property SLCumVaginal Auto
Keyword Property SLCumOralStacked Auto  
Keyword Property SLCumAnalStacked Auto
Keyword Property SLCumVaginalStacked Auto

Race Property DogRace Auto

Int[] CounterNpcForInc
Float LastDecayCheck

;Group		-> Pc Fame / Npc Fame
;FameNum	-> Index of FameType String on (FamelistNPC / FameListPC)
;FameType	-> String with the Fame Name
;LocNum		-> Index FameLocation in PapyrusUtil.Array (0-33, FameLocationsList)
;LocType	-> Location Is Base(Standard Location) Or Temporary(Extra Location)

Event OnInit()
	CounterNpcForInc = New Int[4]
	Int a = Config.FameListNpc.Length
	While a > 0
		a -= 1
		StorageUtil.IntListResize(None, "SLSF.LocationsFame."+Config.FameListNpc[a], 34)	;Locations Fame (Cumulative NPCs, what the Npc knows about the Npcs activity in this Location)
		StorageUtil.IntListResize(None, "SLSF.LocationsFame."+Config.FameListNpc[a]+".LevelMin", 34)	;The MinValue that the Decrease could reach
		StorageUtil.IntListResize(None, "SLSF.LocationsFame."+Config.FameListNpc[a]+".LevelMax", 34, 100)	;The MaxValue that the Increase could reach
	EndWhile
	
	a = Config.FameListPc.Length
	While a > 0
		a -= 1
		StorageUtil.IntListResize(None, "SLSF.LocationsFame."+Config.FameListPc[a], 34)		;PC Fame (Cumulative PC, what the Npcs knows about the PC activity in this Location)
		StorageUtil.IntListResize(None, "SLSF.LocationsFame."+Config.FameListPc[a]+".LevelMin", 34)	;The MinValue that theDecrease could reach
		StorageUtil.IntListResize(None, "SLSF.LocationsFame."+Config.FameListPc[a]+".LevelMax", 34, 100)	;The MaxValue that the Increase could reach
	EndWhile
	
	;Various
	StorageUtil.IntListResize(None, "SLSF.LocationsFame.CannotDecay", 	34)		;Override to avoid Decay (Temporary only)
	StorageUtil.FormListResize(None, "SLSF.LocationsFame.Form", 34)		;Used for the Compatibility Script
EndEvent

Function LoadLocationOnPapyrus()
	Int a = Config.FameLocationsList.Length
	While a > 0
		a -= 1
		StorageUtil.FormListSet(None, "SLSF.LocationsFame.Form", a, Config.FameLocationsList[a])
	EndWhile
EndFunction

Bool Function DelayFameGain(Int TypeInc)
	Bool Ready = (CounterNpcForInc[TypeInc] != 0 || !Config.PlayerEquipReady)
	If !Ready
		Int Delay = 10
		While Delay > 0
			Delay -= 1
			Utility.Wait(0.5)
			If CounterNpcForInc[TypeInc] == 0 && Config.PlayerEquipReady
				Return True
			EndIf
		EndWhile
	Else
		Return True
	EndIf
	Return False
EndFunction

Function CountListIncrease(Int Type)	;0 Periodic, 1 Sl, 2 External, 3 Internal
	Int a = CounterNpcForInc[Type] + 1
	CounterNpcForInc[Type] = a
EndFunction

Function UpdateCounterNpcForInc096()
	CounterNpcForInc = New Int[4]
EndFunction

Int Function GetFameGroupByName(String FameName)
	Int Result = -1
	String Group = StringUtil.GetNthChar(FameName, 0)
	If Group == "N"
		Result = 0
	ElseIf Group == "P"
		Result = 1
	EndIf
	Return Result	;-1 Error, 0 Npc Fame, 1 Pc Fame
EndFunction

Function CleanCurrentGlobalsLoaded(Bool FameNpc, Bool FamePc)
	Int a = Config.CurrentFameLocationNpc.GetSize()
	
	If FameNpc
		While a > 0
			a -= 1
			(Config.CurrentFameLocationNpc.GetAt(a) as GlobalVariable).SetValue(0.0)
		EndWhile
	EndIf
	
	If FamePc
		a = Config.CurrentFameLocationPc.GetSize()
		While a > 0
			a -= 1
			(Config.CurrentFameLocationPc.GetAt(a) as GlobalVariable).SetValue(0.0)
		EndWhile
	EndIf
EndFunction

Bool Function IsTemporaryLocation(Int LocNum)
	Int Max = Config.TemporaryLocation.Length
	If LocNum >= 0 && LocNum < Max
		Return Config.TemporaryLocation[LocNum]
	EndIf
	Return False
EndFunction

Function ClearGlobals()
	Int a = Config.CurrentFameLocationNpc.GetSize()
	While a > 0
		a -= 1
		(Config.CurrentFameLocationNpc.GetAt(a) as GlobalVariable).SetValue(0)
	EndWhile
	
	a = Config.CurrentFameLocationPc.GetSize()
	While a > 0
		a -= 1
		(Config.CurrentFameLocationPc.GetAt(a) as GlobalVariable).SetValue(0)
	EndWhile
EndFunction

Function UpdateGlobal(Int Group, Int FameNum)
	GlobalVariable Selected
	String FameType
	Int LoadedNum = Config.LocationOfValueLoadedNum
	Int Max = Config.FameLocationsList.Length

	If LoadedNum >= 0 && LoadedNum < Max
		If Group == 0
			If FameNum < Config.CurrentFameLocationNpc.GetSize()
				Selected = Config.CurrentFameLocationNpc.GetAt(FameNum) as GlobalVariable
				FameType =  Config.FameListNpc[FameNum]
			EndIf
		ElseIf Group == 1
			If FameNum < Config.CurrentFameLocationPc.GetSize()
				Selected = Config.CurrentFameLocationPc.GetAt(FameNum) as GlobalVariable
				FameType =  Config.FameListPc[FameNum]
			EndIf
		EndIf
		
		Selected.SetValue(SLSFUtility.FixRangeValue(StorageUtil.IntListGet(None, "SLSF.LocationsFame."+FameType, LoadedNum)))
	EndIf
EndFunction

Int Function ApplyFameMod(Int Value)
	Float Total
	If Value > 0
		Total = Value * Config.LocationFameModInc
	Else
		Total = Value * Config.LocationFameModDec
	EndIf
	
	Return (Total As Int)
EndFunction

Bool Function ModFameValueByNum(Int Group, Int FameNum, Int LocNum, Int Many, Bool ApplyUserMod = True, Int LimitMin = 0, Int LimitMax = 100)
	String FameType
	Int MinLevel = LimitMin
	Int MaxLevel = LimitMax
	
	If Group == 0
		If FameNum >= 0 && FameNum < Config.FameListNpc.Length
			FameType = Config.FameListNpc[FameNum]
		EndIf
	ElseIf Group == 1
		If FameNum >= 0 && FameNum < Config.FameListPc.Length
			FameType = Config.FameListPc[FameNum]
		EndIf
	EndIf
	
	If FameType == "" || LocNum < 0 || LocNum >= Config.FameLocationsList.Length || Many == 0 || (Group != 0 && Group != 1)
		Return False
	EndIf
	
	MinLevel = SLSFUtility.FixRangeValue(StorageUtil.IntListGet(None, "SLSF.LocationsFame."+FameType+".LevelMin", LocNum))
	MaxLevel = SLSFUtility.FixRangeValue(StorageUtil.IntListGet(None, "SLSF.LocationsFame."+FameType+".LevelMax", LocNum))
	
	If LimitMin > MinLevel
		MinLevel = LimitMin
	EndIf
	
	If LimitMax < MaxLevel
		MaxLevel = LimitMax
	EndIf
	
	If MaxLevel > 100
		MaxLevel = 100
	EndIf
	
	If Minlevel < 0
		MinLevel = 0
	EndIf
	
	Int NewFameValue = StorageUtil.IntListGet(None, "SLSF.LocationsFame."+FameType, LocNum)
	;If (NewFameValue >= MaxLevel && Many > 0) || (NewFameValue <= MinLevel && Many < 0)
	;	Return False
	;EndIf
	
	If ApplyUserMod
		NewFameValue += ApplyFameMod(Many)
	Else
		NewFameValue += Many
	EndIf
	
	StorageUtil.IntListSet(None, "SLSF.LocationsFame."+FameType, LocNum, SLSFUtility.FixRangeValue(NewFameValue, MinLevel, MaxLevel))
	
	If LocNum == Config.LocationOfValueLoadedNum
		UpdateGlobal(Group, FameNum)
	EndIf
	
	Config.LastFameSet[LocNum] = Utility.GetCurrentGameTime()
	Return True
EndFunction

Bool Function ModFameValueByCurrent(Int Group, Int FameNum, Int Many, Bool ApplyUserMod = True, Int LimitMin = 0, Int LimitMax = 100)
	Return ModFameValueByNum(Group, FameNum, Config.LocationOfValueLoadedNum, Many, ApplyUserMod, LimitMin, LimitMax)
EndFunction

Bool Function ModFameValueByLocation(Int Group, Int FameNum, Location Where, Int Many, Bool ApplyUserMod = True, Int LimitMin = 0, Int LimitMax = 100)
	Return ModFameValueByNum(Group, FameNum, SLSFUtility.ObtainFameLocationNum(Where), Many, ApplyUserMod, LimitMin, LimitMax)
EndFunction

Function ClearFameByNum(Bool NpcFame, Bool PcFame, Int LocNum)		;Simple Set to 0 of the Fame Location's fame
	Int Max = Config.TemporaryLocation.Length
	If LocNum < 0 || LocNum >= Max
		Return
	EndIf
	
	Int a = Config.FameListNpc.Length
	Float Now = Utility.GetCurrentGameTime()
	If NpcFame
		While a > 0
			a -= 1
			StorageUtil.IntListSet(None, "SLSF.LocationsFame."+Config.FameListNpc[a], LocNum, 0)
			StorageUtil.IntListSet(None, "SLSF.LocationsFame."+Config.FameListNpc[a]+".LevelMin", LocNum, 0) 
			StorageUtil.IntListSet(None, "SLSF.LocationsFame."+Config.FameListNpc[a]+".LevelMax", LocNum, 100) 
		EndWhile
		Config.LastFameSet[LocNum] = Now
	EndIf
	
	If PcFame
		a = Config.FameListPc.Length
		While a > 0
			a -= 1
			StorageUtil.IntListSet(None, "SLSF.LocationsFame."+Config.FameListPc[a], LocNum, 0)
			StorageUtil.IntListSet(None, "SLSF.LocationsFame."+Config.FameListPc[a]+".LevelMin", LocNum, 0) 
			StorageUtil.IntListSet(None, "SLSF.LocationsFame."+Config.FameListPc[a]+".LevelMax", LocNum, 100) 
		EndWhile
		Config.LastFameSet[LocNum] = Now
	EndIf
	
	If Config.LocationOfValueLoadedNum == LocNum
		CleanCurrentGlobalsLoaded(NpcFame, PcFame)
	EndIf
EndFunction

Function ClearFameByCurrent(Bool NpcFame, Bool PcFame)
	ClearFameByNum(NpcFame, PcFame, Config.LocationOfValueLoadedNum)
EndFunction

Function ClearFameByLocation(Bool NpcFame, Bool PcFame, Location Where)
	ClearFameByNum(NpcFame, PcFame, SLSFUtility.ObtainFameLocationNum(Where))
EndFunction

Int Function ResetFameByNum(Int LocNum)				;Complete Clean Of the Fame Location
	ClearFameByNum(True, True, LocNum)
	
	If IsTemporaryLocation(LocNum)
		StorageUtil.IntListSet(None, "SLSF.LocationsFame.CannotDecay", LocNum, 0)
		StorageUtil.FormListSet(None, "SLSF.LocationsFame.Form", LocNum, None)
		Config.FameLocationsList[LocNum] = None
		Config.FameLocationsListString[LocNum] = " Empty [Loc#"+LocNum+"]"
		Config.LocationFameMorbosity[LocNum] = 0.5
		Config.LocationFameRequiredMorbosity[LocNum] = 0.2
		Config.LastFameSet[LocNum] = 0.0
		Config.LastDecadencePC[LocNum] = 0.0
		Config.LastVariationNPC[LocNum] = 0.0
		
		If Config.LocationOfValueLoadedNum == LocNum
			Config.LocationOfValuesLoaded = None
			Config.LocationOfValueLoadedNum = -1
			ClearGlobals()
			SLSFUtility.CallSyncFameLocation()
		EndIf
		Return 0
	EndIf
	Return -1
EndFunction

Int Function ResetFameByCurrent()
	Return ResetFameByNum(Config.LocationOfValueLoadedNum)
EndFunction

Int Function ResetFameByLocation(Location Where)
	Return ResetFameByNum(SLSFUtility.ObtainFameLocationNum(Where))
EndFunction

Int Function RegisterTemporaryLocation(Location Which, Bool UserRequest, Bool CannotDecay = False, Float Morbosity = 0.5, Float MorbosityReq = 0.2)
	If Which == None
		If !UserRequest
			Debug.Trace("[SLSF] [Requested from Mod Rejected] Can't start track this location, The Location is None.")
		Else
			Debug.MessageBox("SexLab - Sexual Fame \n Can't start track this location, The Location is None.")
		EndIf
		Return -1
	EndIf
	
	Int FreeSlot = SLSFUtility.ObtainFameLocationNum(Which)
	If FreeSlot != -1
		If !UserRequest
			Debug.Trace("[SLSF] [Requested from Mod Rejected] This Location is already tracked from Slot "+FreeSlot+".")
		Else
			Debug.MessageBox("SexLab - Sexual Fame \n This Location is already tracked from Slot "+FreeSlot+".")
		EndIf
		Return -2
	EndIf

	FreeSlot = -1
	Int a = 24
	Int Max = Config.FameLocationsList.Length
	While a < Max
		If Config.FameLocationsList[a] == None && Config.TemporaryLocation[a]
			FreeSlot = a
			a = Max
		EndIf
		a += 1
	EndWhile
	
	If FreeSlot < 0
		If !UserRequest
			Debug.Trace("[SLSF] [Requested from Mod Rejected] Can't start track this location, No TrackSlotFree.")
		Else
			Debug.MessageBox("SexLab - Sexual Fame \n Can't start track this location, No TrackSlotFree.")
		EndIf
		Return -3
	EndIf
	
	If Which.HasKeyword(Config.LocTypeHold) || Which == Config.LocationExcludedFromTracking[0] || Which == Config.LocationExcludedFromTracking[1]
		If !UserRequest
			Debug.Trace("[SLSF] [Requested from Mod Rejected] Can't start track this, Holds-size location (or Bigger) are excluded.")
		Else
			Debug.MessageBox("SexLab - Sexual Fame \n Can't start track this, Holds-size location (or Bigger) are excluded.")
		EndIf
		Return -4
	EndIf
	
	If Which.HasKeyword(Config.LocTypeHouse)
		If !UserRequest
			Debug.Trace("[SLSF] [Requested from Mod Rejected] Can't start track this, Single Houses Are Exluded.")
		Else
			Debug.MessageBox("SexLab - Sexual Fame \n Can't start track this, Single Houses Are Exluded, Try outside.")
		EndIf
		Return -5
	EndIf
	
	If Config.TemporaryLocation[FreeSlot]
		If Morbosity < 0.0
			Morbosity = 0.0
		Elseif Morbosity > 1.0
			Morbosity = 1.0
		EndIf
		
		If MorbosityReq < 0.0
			MorbosityReq = 0.0
		Elseif MorbosityReq > 1.0
			MorbosityReq = 1.0
		EndIf
		
		ResetFameByNum(FreeSlot)
		Config.FameLocationsList[FreeSlot] = Which
		Config.LastFameSet[FreeSlot] = Utility.GetCurrentGameTime()
		StorageUtil.IntListSet(None, "SLSF.LocationsFame.CannotDecay", FreeSlot, CannotDecay as Int)
		StorageUtil.FormListSet(None, "SLSF.LocationsFame.Form", FreeSlot, Which)
		Config.LocationFameMorbosity[FreeSlot] = Morbosity
		Config.LocationFameRequiredMorbosity[FreeSlot] = MorbosityReq
		Config.LastDecadencePC[FreeSlot] = Utility.GetCurrentGameTime()
		Config.LastVariationNPC[FreeSlot] = 0.0
		
		String Name = Which.GetName()
		If Name == ""
			Name = "Not Named [ID:"+Which.GetFormID()+"]"
		EndIf
		
		Config.FameLocationsListString[FreeSlot] = Name+" [Loc#"+FreeSlot+"]"
		SLSFUtility.CallSyncFameLocation()
		
		If Config.RandomizeTemporaryFameAtStart
			RandomizerNpcFame(FreeSlot)
		EndIf
		
		Return FreeSlot
	Else
		Return -1
	EndIf
EndFunction

Function RandomizerNpcFame(Int WhichLocNum)
	Int Selected
	Int[] Prob = New Int[7]
	Prob[0] = Config.ProbRandomFillTempLib
	Prob[1] = Config.ProbRandomFillTempPro
	Prob[2] = Config.ProbRandomFillTempRap
	Prob[3] = Config.ProbRandomFillTempSla
	Prob[4] = Config.ProbRandomFillTempZoo
	Prob[5] = Config.ProbRandomFillTempMig
	Prob[6] = Config.ProbRandomFillTempMia
	
	If !SexLab.AllowedCreature(DogRace)
		Prob[4] = 0
	EndIf
	
	Int[] Buffer = New Int[7]
	Buffer[0] = 0
	Buffer[1] = 0
	Buffer[2] = 0
	Buffer[3] = 0
	Buffer[4] = 0
	Buffer[5] = 0
	Buffer[6] = 0
	
	Int a = 18
	While a > 0
		a -= 1
		Selected = SLSFUtility.CalcRandomProbability(Prob[0], Prob[1], Prob[2], Prob[3], Prob[4], Prob[5], Prob[6])
		Buffer[Selected] = Buffer[Selected] + 10
		Prob[Selected] = Prob[Selected] + 3
	EndWhile
	
	String Name
	a = Config.FameListNpc.Length
	While a > 0
		a -= 1
		Name = Config.FameListNpc[a]
		StorageUtil.IntListSet(None, "SLSF.LocationsFame."+Name, WhichLocNum, SLSFUtility.FixRangeValue(Buffer[a]))
	EndWhile
EndFunction

Function DecayOfTemporaryLocation()
	Float ActualTime = Utility.GetCurrentGameTime()
	If ActualTime > (LastDecayCheck + 0.5)
		Float LastSet
		LastDecayCheck = ActualTime
		
		Int a = Config.FameLocationsList.Length
		While a > 23
			a -= 1
			If Config.FameLocationsList[a] != None
				If Config.TemporaryLocation[a]
					If StorageUtil.IntListGet(None, "SLSF.LocationsFame.CannotDecay", a) == 0
						LastSet = Config.LastFameSet[a]
						If ActualTime > (LastSet + Config.TemporaryFameLocationExpiration)
							ResetFameByNum(a)
						EndIf
					EndIf
				EndIf
			EndIf
		EndWhile
	EndIf
EndFunction

Function FameDecadencePcAndVariationNpc()
	If Config.AmountFamePCLocationDecadence < 0 || Config.VariationFameNpcRange != 1.0
		Int ActualCheck = Config.NextLocationNumDecadenceToCheck
		Int AmountDecadence = Config.AmountFamePCLocationDecadence
		Int ActualGlobalLoaded = Config.LocationOfValueLoadedNum
		Float Now = Utility.GetCurrentGameTime()
		Float DelayDecrease = Config.FameDayDelayBeforeDecrease
		Float ModVariation = Config.VariationFameNpcRange
		
		Int Amount
		Int DecadencesAmount
		Bool DecadencePC
		Bool VariationNPC
		Bool ActualLoaded
		Float DecadeAt
		Float LastfameSet
		String FameType
		
		Int a
		Int b
		While a < 6
			a += 1
			If ActualCheck == ActualGlobalLoaded
				ActualLoaded = True
			Else
				ActualLoaded = False
			EndIf

			If Config.FameLocationsList[ActualCheck] != None
				If AmountDecadence > 0
					LastfameSet = Config.LastDecadencePC[ActualCheck]
					DecadeAt = LastfameSet + DelayDecrease
					If Now > DecadeAt
						DecadencePC = True
						DecadencesAmount = ((Now - LastfameSet) / DelayDecrease) as Int
					EndIf
				EndIf
					
				If ModVariation != 1.0
					If Now > Config.LastVariationNPC[ActualCheck] + 1.0
						VariationNPC = True
					EndIf
				EndIf
			EndIf
			
			If DecadencePC
				b = Config.FameListPc.Length
				While b > 0
					b -= 1
					;FameType = Config.FameListPc[b]
					;Amount = StorageUtil.IntListGet(None, "SLSF.LocationsFame."+FameType, ActualCheck)
					;If Amount > 0
						;Amount += (AmountDecadence * DecadencesAmount)
						;StorageUtil.IntListSet(None, "SLSF.LocationsFame."+FameType, ActualCheck, SLSFUtility.FixRangeValue(Amount))
						
						Amount = (AmountDecadence * DecadencesAmount) * -1
						ModFameValueByNum(1, b, ActualCheck, Amount, True)
						
						If ActualLoaded
							UpdateGlobal(1, b)
						EndIf
					;EndIf
				EndWhile
				Config.LastDecadencePC[ActualCheck] = Now
				;a = 10
			EndIf
			
			If VariationNPC
				b = Config.FameListNpc.Length
				While b > 0
					b -= 1
					FameType = Config.FameListNpc[b]
					Amount = StorageUtil.IntListGet(None, "SLSF.LocationsFame."+FameType, ActualCheck)
					Amount = (Amount * (Utility.RandomFloat(-ModVariation, ModVariation))) as Int	;Amount = (Amount * (1.0 + Utility.RandomFloat(-ModVariation, ModVariation))) as Int
					;StorageUtil.IntListSet(None, "SLSF.LocationsFame."+FameType, ActualCheck, SLSFUtility.FixRangeValue(Amount))
					ModFameValueByNum(0, b, ActualCheck, Amount, False)
					
					If ActualLoaded
						UpdateGlobal(1, b)
					EndIf
				EndWhile
				Config.LastVariationNPC[ActualCheck] = Now
				;a = 10
			EndIf
			
			If ActualCheck >= (Config.FameLocationsList.Length - 1)
				Config.NextLocationNumDecadenceToCheck = 0
			Else
				Config.NextLocationNumDecadenceToCheck += 1
			EndIf
			ActualCheck = Config.NextLocationNumDecadenceToCheck
		EndWhile
	EndIf
EndFunction

Function BlackWidowCheck()
	Int a = Config.FameLocationsList.Length
	While a > 23
		a -= 1
		If Config.FameLocationsList[a] != None
			If Config.TemporaryLocation[a]
				If Config.FameLocationsList[a].IsCleared()
					ResetFameByNum(a)
				EndIf
			EndIf
		EndIf
	EndWhile
EndFunction

Function ContageFamePCSelect()
	BlackWidowCheck()
	Float Now = Utility.GetCurrentGameTime()
	If Now > (Config.LastContageCheck + Config.DaysDelayBeforeNewContage)
		Int MinToContage = Config.FameMinToAllowContage
		Int MaxSelector = Config.FameLocationsList.Length
		
		Config.LastContageCheck = Now
		
		Int Contager = -1
		Int ToContage = -1
		Int Selector
		Int Amount
		
		Int[] ListOfPossibleContager = New Int[5]
		Int[] ProbabilityOfPossibleContager = New Int[5]
		Int ListIndex
		
		Int a = 10
		Int b = Config.FameListPc.Length
		While a > 0
			a -= 1
			If ListIndex > 4
				a = 0
			Else
				If a != 9
					Selector = Utility.RandomInt(1, MaxSelector) - 1
				Else
					If Config.LocationOfValueLoadedNum != -1
						Selector = Config.LocationOfValueLoadedNum
					EndIf
				EndIf
				
				If Config.FameLocationsList[Selector] != None
					b = Config.FameListPc.Length
					While b > 0
						b -= 1
						Amount = StorageUtil.IntListGet(None, "SLSF.LocationsFame."+Config.FameListPc[b], Selector)
						If Amount > MinToContage
							b = 0
							ListOfPossibleContager[ListIndex] = Selector
							ProbabilityOfPossibleContager[ListIndex] = (Config.LocationFameMorbosity[Selector] * 10) as Int
							ListIndex += 1
						EndIf
					EndWhile
				EndIf
			EndIf
		EndWhile
		
		If ListIndex > 0
			Int Prob = SlSfUtility.CalcRandomProbability(ProbabilityOfPossibleContager[0], ProbabilityOfPossibleContager[1], ProbabilityOfPossibleContager[2], ProbabilityOfPossibleContager[3], ProbabilityOfPossibleContager[4])
			If Prob != -1
				Contager = ListOfPossibleContager[Prob]
				a = 10
				While a > 0
					a -= 1
					If ToContage == -1
						Selector = Utility.RandomInt(1, MaxSelector) - 1
						If Config.FameLocationsList[Selector] != None
							If Config.LocationFameMorbosity[Contager] >= Config.LocationFameRequiredMorbosity[Selector] || Contager == Selector
								ToContage = Selector
							EndIf
						EndIf
					Else
						a = 0
					EndIf
				EndWhile
			EndIf
		EndIf
		
		ContageFamePc(Contager, ToContage)
	EndIf
EndFunction

Bool Function ContageFamePc(Int Contager, Int ToContage, Bool AssuredContage = False, Float OverrideContageAmount = 0.0)
	Int Max = Config.FameLocationsList.Length
	If Contager < 0 || ToContage < 0 || Contager >= Max || ToContage >= Max
		Return False
	EndIf
	
	Int MinToContage = Config.FameMinToAllowContage
	Bool SameLocation = (Contager == ToContage)
	Float ContageMagn = Config.ContageMagnitudo
	Float Probability = Config.BaseProbabilityContage
	
	Int ToSet
	Int MinLevel
	Int MaxLevel
	Int Amount
	Int ComparedAmount
	Float ContageDelta
	String FameType
	
	If OverrideContageAmount <= 0.0
		ContageMagn = Config.ContageMagnitudo
	Else
		ContageMagn = OverrideContageAmount
		If ContageMagn > 1.0
			ContageMagn = 1.0
		EndIf
	EndIf
	
	If !AssuredContage
		If !SameLocation
			If Config.FameLocationsList[Contager].HasCommonParent(Config.FameLocationsList[ToContage], Config.LocTypeHold)
				Probability += Config.ModIfINSameLocation
			Else
				Probability += Config.ModIfNOTSameLocation
			EndIf
		Else
			Probability += Config.ModIfINSameLocation
		EndIf
		Probability += Config.LocationFameMorbosity[Contager]
	Else
		Probability = 2.0
	EndIf
	
	Bool AtLeastOne
	Int b = Config.FameListPc.Length
	While b > 0
		b -= 1
		FameType = Config.FameListPc[b]
		Amount = StorageUtil.IntListGet(None, "SLSF.LocationsFame."+FameType, Contager)
		If Amount > MinToContage
			If Utility.RandomFloat(0.0, 1.0) < Probability
				If SameLocation
					ToSet = (Amount * (Utility.RandomFloat( 1.0, 1.0 + (ContageMagn/2)) as Int))
				Else
					ComparedAmount = StorageUtil.IntListGet(None, "SLSF.LocationsFame."+FameType, ToContage)
					If Amount > ComparedAmount
						ContageDelta = Amount * Utility.RandomFloat(0.1, ContageMagn)
						ToSet = (ComparedAmount + ContageDelta as Int)
					Else
						ToSet = (ComparedAmount * (Utility.RandomFloat( 1.0 , 1.0 + (ContageMagn/2)) as Int))
					EndIf
				EndIf
				MinLevel = SLSFUtility.FixRangeValue(StorageUtil.IntListGet(None, "SLSF.LocationsFame."+FameType+".LevelMin", ToContage))
				MaxLevel = SLSFUtility.FixRangeValue(StorageUtil.IntListGet(None, "SLSF.LocationsFame."+FameType+".LevelMax", ToContage))
				
				If ToSet > MaxLevel
					Toset = MaxLevel
				ElseIf Toset < MinLevel
					ToSet = MinLevel
				EndIf
				
				StorageUtil.IntListSet(None, "SLSF.LocationsFame."+FameType, ToContage, ToSet)
				AtLeastOne = True
			EndIf
		EndIf
	EndWhile
	
	Float Check = Config.LocationFameMorbosity[Contager]
	Float Mod = Config.ModMorbosityAtContage
	If AtLeastOne
		If Mod > 0.0
			Check = Check * (1.0 - Mod)
		EndIf
		Config.LastFameSet[Contager] = Utility.GetCurrentGameTime()
		Config.LastFameSet[ToContage] = Utility.GetCurrentGameTime()
	Else
		If Mod > 0.0
			Check = Check * (1.0 + Mod)
		EndIf
	EndIf
	
	If Check > 1.0
		Config.LocationFameMorbosity[Contager] = 1.0
	ElseIf Check < 0.1
		Config.LocationFameMorbosity[Contager] = 0.1
	Else
		Config.LocationFameMorbosity[Contager] = Check
	EndIf
	Return AtLeastOne
EndFunction

Function FamePeriodicIncrease()
	Int LocNum = Config.LocationOfValueLoadedNum
	If LocNum < 0
		Return
	EndIf

	If !PlayerRef.HasMagicEffect(Anonymous)
		Bool Ready = DelayFameGain(0)
	
		If Ready
			SLSFUtility.CallTheCaster(Counter_Per, PlayerRef)
			Utility.Wait(3.0)
			
			Bool Added
			Int NpcCounter = ApplyFameMod(CounterNpcForInc[0])
			CounterNpcForInc[0] = 0
			
			If NpcCounter > 0
				Int FameNum = Config.FameListPc.Length
				Int[] IncMax = Utility.CreateIntArray(FameNum)
				While FameNum > 0 
					FameNum -= 1
					IncMax[FameNum] = Config.PeriodicIncValue[FameNum]
				EndWhile
				
				If IncMax[0] < 100
					If (PlayerRef.HasMagicEffect(BodySur3Sight) || PlayerRef.HasMagicEffect(BodySur3Sight_H)) && PlayerRef.HasMagicEffectWithKeyword(SLCumAnal)
						IncMax[0] = 100
					EndIf
				EndIf
				
				If IncMax[4] < 100
					If PlayerRef.HasMagicEffect(SumSur1Sight) || PlayerRef.HasMagicEffect(SumSur3Sight) || PlayerRef.HasMagicEffect(SumSur5Sight) || PlayerRef.HasMagicEffect(Naked) ||  PlayerRef.HasMagicEffect(OtherSur9)
						IncMax[4] = 100
					EndIf
				EndIf
				
				If IncMax[11] < 100
					If PlayerRef.HasMagicEffect(FaceSur3Sight_H) || PlayerRef.HasMagicEffect(BodySur3Sight_H)
						IncMax[11] = 100
					EndIf
				EndIf
				
				If IncMax[12] < 100
					If (PlayerRef.HasMagicEffect(FaceSur3Sight) || PlayerRef.HasMagicEffect(FaceSur3Sight_H)) && PlayerRef.HasMagicEffectWithKeyword(SLCumOral)
						IncMax[12] = 100
					EndIf
				EndIf
				
				If Config.EstrusChaurusLoaded
					If IncMax[14] < 100
						If PlayerRef.IsinFaction(Config.EsChaurusBreederFaction)
							Config.EsChaurusPlayerPregnant = True
							IncMax[14] = 100
						EndIf
					EndIf
				EndIf
				
				If Config.SoulGemOvenLoaded
					If IncMax[14] < 100
						Bool IsPregnantBySGO = SLSF_External.IsPregnant(PlayerRef, Config.SGOProgressionGemLevelNeeded)
						If IsPregnantBySGO
							IncMax[14] = 100
						EndIf
					EndIf
				EndIf
				
				If IncMax[17] < 100
					If (PlayerRef.HasMagicEffect(BodySur3Sight) || PlayerRef.HasMagicEffect(BodySur3Sight_H)) && PlayerRef.HasMagicEffectWithKeyword(SLCumVaginal)
						IncMax[17] = 100
					EndIf
				EndIf
				
				If IncMax[18] < 100
					If PlayerRef.HasMagicEffect(OtherSur9) || (PlayerRef.WornHasKeyword(Config.ZazBody[4]) && PlayerRef.HasMagicEffect(Naked))
						IncMax[18] = 100
					EndIf
				EndIf
				
				If Config.SkoomaWhoreLoaded
					If PlayerRef.HasSpell(Config.SKWPhysicalDecadenceSpell[2])
						If IncMax[16] < 100
							IncMax[16] = 100
						EndIf
					ElseIf PlayerRef.HasSpell(Config.SKWPhysicalDecadenceSpell[1])
						If IncMax[16] < 80
							IncMax[16] = 80
						EndIf
					ElseIf PlayerRef.HasSpell(Config.SKWPhysicalDecadenceSpell[0])
						If IncMax[16] < 60
							IncMax[16] = 60
						EndIf
					EndIf
				EndIf
				
				If Config.AllowIncreaseSpecificWithTats			;Note: This at last
					If PlayerRef.HasMagicEffect(SumSur1Sight)
						Int Counter = SlSfUtility.CountSlaveTatsTotal(PlayerRef)
						
						Int CheckFT
						Int CheckBL
						Int CheckLM
						String CheckTN
						Bool AllowedAdd
						Int a = Config.STSpecificTatName.Length
						While a > 0
							a -= 1
							CheckFT = Config.STSpecificFameType[a]
							CheckBL = Config.STSpecificBodyLoc[a]
							CheckLM = Config.STSpecificLimitMax[a]
							CheckTN = Config.STSpecificTatName[a]
							AllowedAdd = False
							If CheckFT != -1 && CheckBL != -1 && CheckTN != "None"
								If IncMax[CheckFT] < CheckLM
									If CheckBL >= 0
										If PlayerRef.HasMagicEffect(BodySur1Sight)
											If SLSFUtility.GainFameWithTats(PlayerRef, CheckTN, "Body")
												AllowedAdd = True
											EndIf
										EndIf
									EndIf
									
									If CheckBL >= 1
										If PlayerRef.HasMagicEffect(FaceSur1Sight)
											If SLSFUtility.GainFameWithTats(PlayerRef, CheckTN, "Face")
												AllowedAdd = True
											EndIf
										EndIf
									EndIf
									
									If CheckBL >= 2
										If PlayerRef.HasMagicEffect(FeetSur1Sight)
											If SLSFUtility.GainFameWithTats(PlayerRef, CheckTN, "Feet")
												AllowedAdd = True
											EndIf
										EndIf
										
										If PlayerRef.HasMagicEffect(HandsSur1Sight)
											If SLSFUtility.GainFameWithTats(PlayerRef, CheckTN, "Hands")
												AllowedAdd = True
											EndIf
										EndIf
									EndIf
									
									If AllowedAdd
										Counter -= 1
										If Counter <= 0
											a = 0
										EndIf
										
										IncMax[CheckFT] = CheckLM
									EndIf
								EndIf
							EndIf
						EndWhile
					EndIf
				EndIf
				
				Int a = IncMax.Length
				Int b
				While a > 0
					a -= 1
					b = IncMax[a]
					If b > 0
						Added = ModFameValueByCurrent(1, a, NpcCounter, False, LimitMax = b)
					EndIf
				EndWhile
				
				If Added
					SLSFUtility.ShowTutorialInfo(1)
					If Config.NotificationIncrease
						Debug.Notification("$SLSFINCREASE")
					EndIf
				EndIf
			EndIf
		Else
			Debug.Trace("[SLSF] Buffer Increase Fame Periodic Occupied for Too long, aborting request.")
		EndIf
	EndIf
EndFunction

Function FameSlIncrease(String eventName, String argString, Float argNum, Form sender)
	Int LocNum = Config.LocationOfValueLoadedNum
	If LocNum >= 0
		sslThreadController Controller = SexLab.GetController(argString as int)		;SexLab.HookController(argString)
		If Controller != None
			Actor[] Actors = Controller.Positions
			Bool IncNpcFame = False
			Bool IncPcFame = Controller.HasPlayer
			Bool Ready = DelayFameGain(1)
			Bool Beast = SexLab.CreatureCount(Actors) > 0
			
			Int IncValue
			
			If Ready
				SLSFUtility.CallTheCaster(Counter_Sl, PlayerRef)
				Utility.Wait(3.0)
				
				IncValue = ApplyFameMod(CounterNpcForInc[1])
				CounterNpcForInc[1] = 0
				If IncValue > 0
					Actor Other
					Actor Victim = Controller.VictimRef			;SexLab.HookVictim(argString)
					
					Int Check = Actors.Length
					Int FameNumPc = Config.FameListPc.Length
					Int FameNumNpc = Config.FameListNpc.Length
					Bool[] ToIncreasePc = Utility.CreateBoolArray(FameNumPc, False)
					Bool[] ToIncreaseNpc = Utility.CreateBoolArray(FameNumNpc, False)
					IncNpcFame = (IncPcFame && Check > 1) || (!IncPcFame && Check > 0)
					sslBaseAnimation Anim = Controller.Animation	;SexLab.HookAnimation(argString)
					Int ActorsNpcInvolved
					
					Int c = ToIncreasePc.Length
					While c > 0
						c -= 1
						ToIncreasePc[c] = False
					EndWhile
					
					c = ToIncreaseNpc.Length
					While c > 0
						c -= 1
						ToIncreaseNpc[c] = False
					EndWhile
					
					If IncPcFame
						ToIncreasePc[0] = Anim.HasTag("Anal")
						ToIncreasePc[2] = (Anim.HasTag("Creature") || Anim.HasTag("Bestiality"))
						ToIncreasePc[3] = Controller.IsAggressor(PlayerRef)
						;ToIncreasePc[4] = False	;Exhib/Exposed Already By Periodic Gain
						ToIncreasePc[5] = (Anim.HasTag("Loving") || Anim.HasTag("Hugging") || Anim.HasTag("Cuddling") || Anim.HasTag("Kissing")) && Victim == None
						ToIncreasePc[6] = (Actors.Length > 2)
						;ToIncreasePc[10] = False ;10 Masochist, Not Here
						ToIncreasePc[11] = (Anim.HasTag("Dirty") || Anim.HasTag("Bestiality") || Anim.HasTag("Creature") || (Anim.HasTag("Aggressive") && Victim == None))
						ToIncreasePc[12] = Anim.HasTag("Oral")
						;ToIncreasePc[14] = False ; Pregnant, Not Here
						;ToIncreasePc[15] = False ; Sadic, Not Here
						;ToIncreasePc[16] = False ; SkoomaUser, Not Here
						ToIncreasePc[17] = True		;Slut
						ToIncreasePc[18] = Victim == PlayerRef
						;ToIncreasePc[19] = False; Whore, Not Here
					EndIf
					
					If IncNpcFame
						If Victim != None	; || Anim.HasTag("Aggressive")
							Int VictimSex = SexLab.GetGender(Victim)
							ToIncreaseNpc[2] = True		;Raper
							
							If VictimSex == 0
								ToIncreaseNpc[6] = True	;Misandry
							ElseIf VictimSex == 1
								ToIncreaseNpc[5] = True	;Misogyny
							EndIf
							
							If Victim.GetFactionRank(Roletype) >= 40
								ToIncreaseNpc[3] = True	;Slavery
							EndIf
						EndIf
						
						ToIncreaseNpc[4] = Beast
					EndIf
					
					While Check > 0
						Check -= 1
						Other = Actors[Check]
						
						If Other != PlayerRef
							If IncPcFame
								If !ToIncreasePc[1]
									ToIncreasePc[1] = (Other.GetRace() == RaceList.GetAt(0) || Other.GetRace() == RaceList.GetAt(1))
								EndIf
								
								If !ToIncreasePc[7]
									ToIncreasePc[7] = (Other.GetRace() == RaceList.GetAt(2) || Other.GetRace() == RaceList.GetAt(3))
								EndIf
								
								If !ToIncreasePc[13]
									ToIncreasePc[13] = (Other.GetRace() == RaceList.GetAt(4) || Other.GetRace() == RaceList.GetAt(5))
								EndIf
								
								If !ToIncreasePc[8]
									ToIncreasePc[8] = SexLab.GetGender(Other) == 0
								EndIf
								
								If !ToIncreasePc[9]
									ToIncreasePc[9] = SexLab.GetGender(Other) == 1
								EndIf
								
								If !ToIncreasePc[2]
									ToIncreasePc[2] = Beast
								EndIf
							EndIf
							
							ActorsNpcInvolved += 1
						EndIf
						SLSFUtility.UpdateSexualityFactionRef(Other)
					EndWhile
					
					If IncPcFame
						While FameNumPc > 0
							FameNumPc -= 1
							If ToIncreasePc[FameNumPc]
								ModFameValueByCurrent(1, FameNumPc, IncValue, False)
							EndIf
						EndWhile
					EndIf
					
					If IncNpcFame
						While FameNumNpc > 0
							FameNumNpc -= 1
							If ToIncreaseNpc[FameNumNpc]
								ModFameValueByCurrent(0, FameNumNpc, ApplyFameMod(ActorsNpcInvolved), False)
							EndIf
						EndWhile
					EndIf
				EndIf
			Else
				Debug.Trace("[SLSF] Buffer Increase Fame Sl Occupied for Too long, aborting request.")
			EndIf
		EndIf
	EndIf
EndFunction

Bool Function FamePcExternalMod(Int[] List, Float Multiplier = 1.0)
	Int LocNum = Config.LocationOfValueLoadedNum
	Bool Added
	If LocNum >= 0
		Bool Ready = DelayFameGain(2)
		If Ready
			Float IncValue
			Int IncThis
			
			SLSFUtility.CallTheCaster(Counter_Ext, PlayerRef)
			Utility.Wait(3.0)
			
			IncValue = (ApplyFameMod(CounterNpcForInc[2]) * Multiplier)
			CounterNpcForInc[2] = 0
			If IncValue >= 1.0
				Int a = Config.FameListPc.Length
				Utility.ResizeIntArray(List, a)
				While a > 0
					a -= 1
					IncThis = List[a]
					If IncThis > 0
						ModFameValueByNum(1, a, LocNum, IncValue as Int, False, 0, LimitMax = IncThis)
						List[a] = 0
						Added = True
					EndIf
				EndWhile
				
				If Config.NotificationIncrease
					If Added
						Debug.Notification("$SLSFINCREASE")
					EndIf
				EndIf
			EndIf
		Else
			Debug.Trace("[SLSF] Buffer Increase Fame Ext Occupied for Too long, aborting request.")
		EndIf
	EndIf
	Return Added
EndFunction

Function FameIncreaseByDD(string eventName, string argString, float argNum, form sender)
	Int LocNum = Config.LocationOfValueLoadedNum
	If LocNum >= 0
		If ArgString == PlayerRef.GetName()
			If Config.MaxGainFromDDVibrationEvent > 0
				Bool Ready = DelayFameGain(2)
				If Ready
					SLSFUtility.CallTheCaster(Counter_Ext, PlayerRef)
					Utility.Wait(4.0)
					
					Int IncValue = ApplyFameMod(CounterNpcForInc[2])/2
					CounterNpcForInc[2] = 0
					Int IncLimitMax = Config.MaxGainFromDDVibrationEvent
					If IncValue > 0 && PlayerRef.IsInFaction(Config.DDAnimationFaction) && PlayerRef.IsInFaction(Config.DDVibratingFaction)
						ModFameValueByCurrent(1, 4, IncValue, False, LimitMin = 0, LimitMax = IncLimitMax)
						ModFameValueByCurrent(1, 18, IncValue, False, LimitMin = 0, LimitMax = IncLimitMax)
						If Config.NotificationIncrease
							Debug.Notification("$SLSFINCREASE")
						EndIf
					EndIf
				Else
					Debug.Trace("[SLSF] Buffer Increase Fame Ext Occupied for Too long, aborting request.")
				EndIf
			EndIf
		EndIf
	EndIf
EndFunction

Function FameIncreaseInternal(Int[] FameList, Float Multiplier = 1.0)
	Int LocNum = Config.LocationOfValueLoadedNum
	If LocNum >= 0
		Bool Ready = DelayFameGain(3)
		If Ready
			Float IncValue
			Bool Added
			Int IncThis
			
			SLSFUtility.CallTheCaster(Counter_Int, PlayerRef)
			Utility.Wait(3.0)
			
			IncValue = (ApplyFameMod(CounterNpcForInc[3]) * Multiplier)
			CounterNpcForInc[3] = 0
			If IncValue >= 1.0
				Int a = Config.FameListPc.Length
				While a > 0
					a -= 1
					IncThis = FameList[a]
					If IncThis > 0
						ModFameValueByNum(1, a, LocNum, IncValue as Int, False, LimitMin = 0, LimitMax = IncThis)
					EndIf
					
					If Config.NotificationIncrease
						If Added
							Debug.Notification("$SLSFINCREASE")
						EndIf
					EndIf
				EndWhile
			EndIf
		Else
			Debug.Trace("[SLSF] Buffer Increase Fame Int Occupied for Too long, aborting request.")
		EndIf
	EndIf
EndFunction

;Function SetPCRoleType(Int WhichFromTheList, Int WhichLoc)
;	If WhichFromTheList == 0
;		SLSFUtility.SetTheRoleType(PlayerRef, 0, WhichLoc)
;	ElseIf WhichFromTheList == 1
;		SLSFUtility.SetTheRoleType(PlayerRef, 1, WhichLoc)
;	ElseIf WhichFromTheList == 2
;		SLSFUtility.SetTheRoleType(PlayerRef, 2, WhichLoc)
;	ElseIf WhichFromTheList == 3
;		SLSFUtility.SetTheRoleType(PlayerRef, 20, WhichLoc)
;	ElseIf WhichFromTheList == 4
;		SLSFUtility.SetTheRoleType(PlayerRef, 21, WhichLoc)
;	ElseIf WhichFromTheList == 5
;		SLSFUtility.SetTheRoleType(PlayerRef, 22, WhichLoc)
;	ElseIf WhichFromTheList == 6
;		SLSFUtility.SetTheRoleType(PlayerRef, 40, WhichLoc)
;	ElseIf WhichFromTheList == 7
;		SLSFUtility.SetTheRoleType(PlayerRef, 41, WhichLoc)
;	ElseIf WhichFromTheList == 8
;		SLSFUtility.SetTheRoleType(PlayerRef, 42, WhichLoc)
;	EndIf
;EndFunction
