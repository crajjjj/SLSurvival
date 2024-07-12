Scriptname SLSF_Utility extends Quest  

Import MiscUtil
Import StorageUtil

SLSF_Configuration Property Config Auto
SLSF_ExcludedList Property Excluded Auto
SLSF_FameMaintenance Property FameMain Auto
SLSF_Monitor Property Monitor Auto
SexLabFramework Property SexLab Auto
SLSF_CompatibilityScript Property Compatibility Auto

Actor Property PlayerRef Auto
ReferenceAlias Property Caster Auto
ObjectReference Property GTFO Auto
Faction Property JarlFaction Auto
Faction Property AlreadyInitialized Auto	; -2 Not Initialized, 0 In progress, 2 Ready
Faction Property ExcludedNpc Auto
Faction Property ForceReInitialization Auto
Faction Property RoleType Auto
Faction Property RoleGroup Auto
Faction Property NoCommentFaction Auto
Faction Property ZbfFactionSlave Auto
Faction Property ZbfFactionSlaver Auto
Faction Property Sla_Exhibitionist Auto
Faction Property SlAnimation Auto
Faction Property ZbfAnimation Auto
Faction Property CommentStat Auto	;0 None, 1 Normal, 2 Friendly, 3 Affective, 4 Very Affective, 5 Offensive, 6 Very Offensive
Faction Property SexualityFaction Auto	;0 Straight, 1 Gay , 2 Bisexual

FormList Property CollarList_Poor Auto
FormList Property CollarList_Med Auto
FormList Property CollarList_Rich Auto
FormList Property ListCurrentFamePC Auto
FormList Property ListCurrentFameNPC Auto

FormList Property EquipList_Body_Poor Auto
FormList Property EquipList_Feet_Poor Auto
FormList Property EquipList_Body_Med Auto
FormList Property EquipList_Feet_Med Auto
FormList Property EquipList_Body_Rich Auto
FormList Property EquipList_Feet_Rich Auto
FormList Property EquipList_Misc Auto

MagicEffect Property Naked Auto
MagicEffect Property Anonymous Auto
Message[] Property TutorialMessage Auto
Message Property RequestRoleTypeChange Auto
Message Property MaxiWarning Auto

Keyword Property ZbfWornDevice Auto
Keyword Property ZbfWornCollar Auto
Keyword Property ZbfWornGag Auto
Keyword Property HasArmor Auto
Keyword Property HasClothing Auto
Keyword Property HandsOffset Auto

Spell Property EquipStatus Auto
Spell Property DebugSpell1 Auto
Spell Property DebugSpell2 Auto
Spell Property DebugSpell3 Auto
Spell Property DebugSpell4 Auto

Function ShowTutorialInfo(Int which)
	If !Config.DisableTutorial
		Utility.Wait(Utility.RandomFloat(0.1, 0.5))
		If !Config.TutorialShowed[which]
			Config.TutorialShowed[which] = True
			TutorialMessage[which].Show()
		EndIf
	EndIf
EndFunction

Function ReloadTutorialsArray()
	Message[] CopyArray = New Message[3]
	CopyArray[0] = TutorialMessage[0]
	CopyArray[1] = TutorialMessage[1]
	CopyArray[2] = TutorialMessage[2]
	
	TutorialMessage = New Message[4]
	TutorialMessage[0] = CopyArray[0]
	TutorialMessage[1] = CopyArray[1]
	TutorialMessage[2] = CopyArray[2]
	TutorialMessage[3] = Game.GetFormFromFile(0x0002B8DE, "SexLab - Sexual Fame [SLSF].esm") As Message
EndFunction

Function Logger(String Source, String News)
	If Config.LogAllowed()
		Bool AlsoConsoleOutput = True
		If AlsoConsoleOutput
			PrintConsole("[SLSF] "+"["+Source+"] "+News+".")
		EndIf
		
		Debug.Trace("[SLSF] "+"["+Source+"] "+News+".")
	EndIf
EndFunction

Function UpdateToLastest()
	If (Config.LastVersion() > Config.CurrentVersion)
		If Config.CurrentVersion < 2
			Config.LoadRoleTypeString()
			FameMain.UpdateCounterNpcForInc096()
			Config.LoadBaseSTSpecificSlot()
			MagicEffect Fixer = FameMain.SumSur1Sight
			FameMain.SumSur1Sight = FameMain.SumSur3Sight
			FameMain.SumSur3Sight = Fixer
			ReloadTutorialsArray()
			StorageUtil.ClearIntValuePrefix("SLSF.PeriodicFameGain.")
			Int a = Config.FameListNpc.Length
			While a > 0
				a -= 1
				StorageUtil.IntListResize(None, "SLSF.LocationsFame."+Config.FameListNpc[a]+".LevelMin", 34)
				StorageUtil.IntListResize(None, "SLSF.LocationsFame."+Config.FameListNpc[a]+".LevelMax", 34, 100)
			EndWhile
			
			a = Config.FameListPc.Length
			While a > 0
				a -= 1
				StorageUtil.IntListResize(None, "SLSF.LocationsFame."+Config.FameListPc[a]+".LevelMin", 34)
				StorageUtil.IntListResize(None, "SLSF.LocationsFame."+Config.FameListPc[a]+".LevelMax", 34, 100)
			EndWhile
			
			;Config.LocationPCRoleTypes = New Int[34]
			Config.LastDecadencePC = New Float[34]
			Float Now = Utility.GetCurrentGameTime()
			a = 34
			While a > 0
				a -= 1
				;Config.LocationPCRoleTypes[a] = 21
				Config.LastDecadencePC[a] = Now
			EndWhile
			Config.AmountFamePCLocationDecadence = 5
			Compatibility.UnregisterAll()
		EndIf
		
		If Config.CurrentVersion < 3
			PlayerRef.SetFactionRank(Roletype, 21)
		Endif
		
		Debug.Notification("$SLSFUPDATINGMSG")
		Config.CurrentVersion = Config.LastVersion()
		Debug.Trace("[SLSF] Configuration Updating to version " + Config.LastVersion())
	EndIf
EndFunction

Function CallTheCaster(Spell ToCast, ObjectReference ToTarget)
	Caster.GetRef().MoveTo(ToTarget)
	ToCast.Cast(Caster.Getreference(), ToTarget)
EndFunction

Function CheckExtensionPresence()
	Int Check = Game.GetModByName("SlaveTats.esp")
	If Check != 255
		Config.SlaveTatsLoaded = Check as Bool
	Else
		Config.SlaveTatsLoaded = False
	EndIf
	
	Check = Game.GetModByName("hydra_slavegirls.esp")
	If Check != 255
		Config.HydraSlavegirlsLoaded = Check as Bool
	Else
		Config.HydraSlavegirlsLoaded = False
	EndIf
	
	Check = Game.GetModByName("Devious Devices - Integration.esm")
	If Check != 255
		Config.DeviousDevicesIntegrationLoaded = Check as Bool
	Else
		Config.DeviousDevicesIntegrationLoaded = False
	EndIf
	
	Check = Game.GetModByName("Bathing in Skyrim - Main.esp")
	If Check != 255
		Config.BathingInSkyrimLoaded = Check as Bool
	Else
		Config.BathingInSkyrimLoaded = False
	EndIf
	
	Check = Game.GetModByName("SexLabSkoomaWhore.esp")
	If Check != 255
		Config.SkoomaWhoreLoaded = Check as Bool
	Else
		Config.SkoomaWhoreLoaded = False
	EndIf

	Check = Game.GetModByName("EstrusChaurus.esp")
	If Check != 255
		Config.EstrusChaurusLoaded = Check as Bool
	Else
		Config.EstrusChaurusLoaded = False
	EndIf
	
	Check = Game.GetModByName("dcc-soulgem-oven-000.esm")
	If Check != 255
		Config.SoulGemOvenLoaded = Check as Bool
	Else
		Config.SoulGemOvenLoaded = False
	EndIf
	
	If !Config.SlaveTatsLoaded
		Config.AllowIncreaseSpecificWithTats = False
	EndIf
	
	Config.DDUpdateKeyword()
	Config.HydUpdateReference()
	Config.BathingInSkyrimReference()
	Config.LoadSkoomaWhoreReference()
	Config.UpdateLocationsList()
	Config.LoadEstrusChaurusReference()
EndFunction

Bool Function CheckIfExcluded(Form[] List, Form BaseObject)
	If BaseObject == None
		Return True
	EndIf
	
	If List.Find(BaseObject) != -1
		Return True
	EndIf
	
	Return False
EndFunction

Bool Function RemoveChild(Actor Npc)
	Npc.MoveTo(GTFO)
	Return True
EndFunction

Function InitializeSubject(Actor Subject)
	Int Exclusion = GetIntValue(Subject, "SLSF.Exclusion", Missing = -1)
	
	If Exclusion > 0
		Subject.RemoveFromFaction(AlreadyInitialized)
		Subject.AddToFaction(ExcludedNpc)
		UpdateFameCommentStats(Subject)
		Return
	EndIf
	
	If Subject.GetFactionRank(ForceReInitialization) < Config.LastNpcInitVersion()
		Subject.SetFactionRank(ForceReInitialization, Config.LastNpcInitVersion())
		Subject.RemoveFromFaction(AlreadyInitialized)
	Endif
	
	Int Calc = -1
	If Subject.GetFactionRank(AlreadyInitialized) < 0
		Subject.SetFactionRank(AlreadyInitialized, 0)
		
		;DefineSexuality(Subject)
		
			;RoleType Assignation
		Int RoleTypeAssigned = -1
		
		Int Override = GetIntValue(Subject, "SLSF.Override.RoleType", Missing = -1)
		
		If (Override >= 0 && Override < 3) || (Override >= 20 && Override < 23) || (Override >= 40 && Override < 43)
			RoleTypeAssigned = Override
		Else	
		;Free
			If Subject.IsGuard()
				Calc = 1
		;Slave
			ElseIf (Subject.IsInFaction(ZbfFactionSlave) || Subject.WornHasKeyword(ZbfWornDevice) || Subject.WornHasKeyword(Config.DDLockable)) && !Subject.IsInFaction(JarlFaction)
				Calc = 0
		;Master
			ElseIf Subject.IsInFaction(ZbfFactionSlaver) || (Subject.IsInFaction(Config.HydMiscFaction) && !Subject.IsInFaction(ZbfFactionSlave))
				Calc = 2
			Else
		;Random Assign
				Calc = CalcRandomProbability(Config.ProbMaster, Config.ProbFree, Config.ProbSlave)
				Subject.SetFactionRank(RoleGroup, Calc)
			EndIf
			
			If Calc == 0	;Slave
				Calc = CalcRandomProbability(Config.ProbSlaveKind, Config.ProbSlaveNorm, Config.ProbSlaveBast)
				RoleTypeAssigned = 40 + Calc
			ElseIf Calc == 1	;Free
				Calc = CalcRandomProbability(Config.ProbFreeKind, Config.ProbFreeNorm, Config.ProbFreeBast)
				RoleTypeAssigned = 20 + Calc
			ElseIf Calc == 2		;Master
				Calc = CalcRandomProbability(Config.ProbMasterKind, Config.ProbMasterNorm, Config.ProbMasterBast)
				RoleTypeAssigned = 0 + Calc
			EndIf
		EndIf
		
		If RoleTypeAssigned != -1
			Subject.SetFactionRank(RoleType, RoleTypeAssigned)
			If (Subject.GetActorBase().IsUnique())
				StorageUtil.SetIntValue(Subject, "SLSF.Override.RoleType", RoleTypeAssigned)
			EndIf
		Else
			Subject.RemoveFromFaction(AlreadyInitialized)
			Return
		EndIf
		
			;Add Base Equip
		If Config.BaseEquipNPC
			DefineBaseEquip(Subject, RoleTypeAssigned)
		EndIf
		
			;Define Exhib
		;If RoleTypeAssigned == 40
		;	StorageUtil.SetIntValue(Subject, "SLSF.Override.Exhibitionism", 1)
		;EndIf
		
		
		If Config.DefineExhib
			Override = GetIntValue(Subject, "SLSF.Override.Exhibitionism", Missing = -1)
			
			Bool Exhib
			If Override > 0
				Exhib = True
			Else
				If Utility.RandomFloat(0.0, 1.0) < Config.ProbExhibitionist
					Exhib = True
				EndIf
			EndIf
			
			If Exhib
				If (Subject.GetActorBase().IsUnique())
					StorageUtil.SetIntValue(Subject, "SLSF.Override.Exhibitionism", 1)
				EndIf
				Subject.AddToFaction(Sla_Exhibitionist)
			EndIf
		EndIf
		
		Subject.SetFactionRank(AlreadyInitialized, 2)
	EndIf
EndFunction

Int Function CalcRandomProbabilityByList(Int[] Values)
	Int Num = Values.Length
	Int b = Num
	Int NextLevel
	Int Sum
	While Num > 0
		Num -= 1
		Sum += Values[Num]
	EndWhile

	Int Random = Utility.RandomInt(1, Sum)
	NextLevel = Values[Num]
	While Num < b
		If Random <= NextLevel
			Return Num
		EndIf
		
		Num += 1
		NextLevel += Values[Num]
	EndWhile
EndFunction

Int Function CalcRandomProbability(Int value0, Int value1, Int value2 = 0, Int value3 = 0, Int value4 = 0, Int value5 = 0, Int value6 = 0, Int value7 = 0, Int value8 = 0, Int value9 = 0, Int value10 = 0, Int value11 = 0, Int value12 = 0, Int value13 = 0, Int value14 = 0 )
	Int Result = (value0 + value1 + value2 + value3 + value4 + value5 + value6 + value7 + value8 + value9 + value10 + value11 + value12 + value13 + value14)
	
	If Result < 1
		Return -1
	ElseIf Result == Value0
		Return 0
	EndIf
	
	Int Random = Utility.RandomInt(1, Result)
	Result = 0
	
	If Random <= (value0)
		Result = 0
	ElseIf Random <= (value0 + value1)
		Result = 1
	ElseIf Random <= (value0 + value1 + value2)
		Result = 2
	ElseIf Random <= (value0 + value1 + value2 + value3)
		Result = 3
	ElseIf Random <= (value0 + value1 + value2 + value3 + value4)
		Result = 4
	ElseIf Random <= (value0 + value1 + value2 + value3 + value4 + value5)
		Result = 5
	ElseIf Random <= (value0 + value1 + value2 + value3 + value4 + value5 + value6)
		Result = 6
	ElseIf Random <= (value0 + value1 + value2 + value3 + value4 + value5 + value6 + value7)
		Result = 7
	ElseIf Random <= (value0 + value1 + value2 + value3 + value4 + value5 + value6 + value7 + Value8)
		Result = 8
	ElseIf Random <= (value0 + value1 + value2 + value3 + value4 + value5 + value6 + value7 + Value8 + Value9)
		Result = 9
	ElseIf Random <= (value0 + value1 + value2 + value3 + value4 + value5 + value6 + value7 + Value8 + Value9 + Value10)
		Result = 10
	ElseIf Random <= (value0 + value1 + value2 + value3 + value4 + value5 + value6 + value7 + Value8 + Value9 + Value10 + Value11)
		Result = 11
	ElseIf Random <= (value0 + value1 + value2 + value3 + value4 + value5 + value6 + value7 + Value8 + Value9 + Value10 + Value11 + Value12)
		Result = 12
	ElseIf Random <= (value0 + value1 + value2 + value3 + value4 + value5 + value6 + value7 + Value8 + Value9 + Value10 + Value11 + Value12 + Value13)
		Result = 13
	ElseIf Random <= (value0 + value1 + value2 + value3 + value4 + value5 + value6 + value7 + Value8 + Value9 + Value10 + Value11 + Value12 + Value13 + Value14)
		Result = 14
	EndIf
	
	Return Result
EndFunction

Function RemoveDevicesFrom(Actor Subject)
	If Config.DeviousDevicesIntegrationLoaded
		If Subject.WornHasKeyword(Config.DDLockable) || Subject.WornHasKeyword(ZbfWornDevice)
			Int Num = Subject.GetNumItems()
			While Num > 0
				Num -= 1
				Form Item = Subject.GetNthForm(Num)
				If (Item.HasKeyword(Config.DDLockable) || Item.HasKeyword(ZbfWornDevice)) && !Item.HasKeyword(Config.DDGenericBlock)
					Subject.RemoveItem(Item, Subject.GetItemCount(Item), True)
				EndIf
			EndWhile
		Endif
	Else
		If Subject.WornHasKeyword(ZbfWornDevice)
			Int Num = Subject.GetNumItems()
			While Num > 0
				Num -= 1
				Form Item = Subject.GetNthForm(Num)
				If Item.HasKeyword(ZbfWornDevice)
					Subject.RemoveItem(Item, Subject.GetItemCount(Item), True)
				EndIf
			EndWhile
		Endif
	EndIf
EndFunction

Bool Function IsSubmissiveGroup(Actor Who)
	If Who.GetFactionRank(RoleType) >= 40
		If Who.GetFactionRank(RoleGroup) != 2
			Who.SetFactionRank(RoleGroup, 2)
		EndIf
		Return True
	Else
		Return False
	EndIf
EndFunction

Bool Function IsNeutralGroup(Actor Who)
	If Who.GetFactionRank(RoleType) >= 20 && Who.GetFactionRank(RoleType) < 40
		If Who.GetFactionRank(RoleGroup) != 1
			Who.SetFactionRank(RoleGroup, 1)
		EndIf
		Return True
	Else
		Return False
	EndIf
EndFunction

Bool Function IsDominantGroup(Actor Who)
	If Who.GetFactionRank(RoleType) >= 0 && Who.GetFactionRank(RoleType) < 20
		If Who.GetFactionRank(RoleGroup) != 1
			Who.SetFactionRank(RoleGroup, 1)
		EndIf
		Return True
	Else
		Return False
	EndIf
EndFunction

;Function DefineSexuality(Actor Who)
;	Int Sexuality = -1
;	Int Override = GetIntValue(Who, "SLSF.Override.Sexuality", Missing = -1)
;	
;	If Override == -1
;		If Config.DefineSexuality
;			If SexLab.GetGender(Who) == 0	;Male
;				Sexuality = CalcRandomProbability(Config.ProbMaleGay, Config.ProbMaleBisex, Config.ProbMaleStraight)
;			ElseIf SexLab.GetGender(Who) == 1	;Female
;				Sexuality = CalcRandomProbability(Config.ProbFemaleGay, Config.ProbFemaleBisex, Config.ProbFemaleStraight)
;			EndIf
;		EndIf
;	Else
;		Sexuality = Override
;	EndIf
;
;	If Sexuality == 0
;		SexLab.SetSexualityGay(Who)
;	ElseIf Sexuality == 1
;		SexLab.SetSexualityBisexual(Who)
;	ElseIf Sexuality == 2
;		SexLab.SetSexualityStraight(Who)
;	ElseIf Sexuality == -1
;		If SexLab.IsStraight(Who)
;			Sexuality = 0
;		ElseIf SexLab.IsGay(Who)
;			Sexuality = 1
;		ElseIf SexLab.IsBisexual(Who)
;			Sexuality = 2
;		EndIf
;	EndIf
;	
;	SetIntValue(Who, "SLSF.Override.Sexuality", Sexuality)
;	Who.SetFactionRank(SexualityFaction, Sexuality)
;EndFunction

Function UpdateSexualityFactionRef(Actor Who)
	Int Num = -1
	If SexLab.IsStraight(Who)
		Num = 0
	ElseIf SexLab.IsGay(Who)
		Num = 1
	ElseIf SexLab.IsBisexual(Who)
		Num = 2
	EndIf
	
	If Num != -1
		Who.SetFactionRank(SexualityFaction, Num)
	EndIf
EndFunction

Function DefineBaseEquip(Actor Subject, Int RoleTypeAssigned)
	If RoleTypeAssigned >= 0 && RoleTypeAssigned <= 2 ;Master
		RemoveDevicesFrom(Subject)
	ElseIf RoleTypeAssigned >= 20 && RoleTypeAssigned <= 22 ;Free
		RemoveDevicesFrom(Subject)
	ElseIf RoleTypeAssigned >= 40 && RoleTypeAssigned <= 42 ;Slave
		Int Rnd
		FormList CollarList = CollarList_Med
		If !Subject.WornHasKeyword(HasArmor) && !Subject.WornHasKeyword(HasClothing)
			FormList EquipListBody
			FormList EquipListFeet
			Float ProbEquip = Utility.RandomFloat()
			
			If RoleTypeAssigned == 40
				Rnd = CalcRandomProbability(Config.EquipWeightKindPoor, Config.EquipWeightKindMed, Config.EquipWeightKindRich)
			ElseIf RoleTypeAssigned == 41
				Rnd = CalcRandomProbability(Config.EquipWeightNormPoor, Config.EquipWeightNormMed, Config.EquipWeightNormRich)
			ElseIf RoleTypeAssigned == 42
				Rnd = CalcRandomProbability(Config.EquipWeightBastPoor, Config.EquipWeightBastMed, Config.EquipWeightBastRich)
			EndIf
			
			If Rnd != -1
				If Rnd == 2
					EquipListBody = EquipList_Body_Rich
					EquipListFeet = EquipList_Feet_Rich
					CollarList = CollarList_Rich
				ElseIf Rnd == 0
					EquipListBody = EquipList_Body_Poor
					EquipListFeet = EquipList_Feet_Poor
					CollarList = CollarList_Poor
				Else
					EquipListBody = EquipList_Body_Med
					EquipListFeet = EquipList_Feet_Med
					CollarList = CollarList_Med
				EndIf
			
				Rnd = Utility.RandomInt(0, EquipListBody.GetSize())
				If ProbEquip < Config.ProbBaseEquipBodyNPC
					AddAndEquip(Subject, EquipListBody.GetAt(Rnd) as Form)
				EndIf
				
				ProbEquip = Utility.RandomFloat()
				
				If ProbEquip < Config.ProbBaseEquipFeetNPC 
					AddAndEquip(Subject, EquipListFeet.GetAt(Rnd) as Form)
				EndIf
			
				If EquipListBody == EquipList_Body_Rich
					ProbEquip = Utility.RandomFloat()
					
					If ProbEquip < Config.ProbBaseEquipMiscNPC 
						AddAndEquip(Subject, EquipList_Misc.GetAt(Utility.RandomInt(1,4)) as Form)
					EndIf
				EndIf
				
				If EquipListBody == EquipList_Body_Poor
					ProbEquip = Utility.RandomFloat()
					
					If ProbEquip < Config.ProbBaseEquipMiscNPC 
						AddAndEquip(Subject, EquipList_Misc.GetAt(0) as Form)
					EndIf
				EndIf
			EndIf
		EndIf
		
		If !Subject.WornHasKeyword(ZbfWornCollar)
			Rnd = Utility.RandomInt(0, CollarList.GetSize())
			AddAndEquip(Subject, CollarList.GetAt(Rnd) as Form)
		EndIf
	EndIf
EndFunction

Function AddAndEquip(Actor Subject, Form Item)
	If Item != None
		Subject.AddItem(Item, 1, True)
		Utility.Wait(0.1)
		Subject.EquipItem(Item)
	EndIf
EndFunction

Int Function GetSlaveTatsDirt(Actor Subject)
	Int Found         ;0 = None, 1 Light Dirt(Hiddable), 2 Dirt (Not Hiddable) [Used also for the return value]
	Int TemplateList
	Int MatchesList
	TemplateList = JValue.retain(JMap.object())
	MatchesList = JValue.retain(JArray.object())
	
	JMap.setStr(TemplateList, "area", "Body")
	JMap.setStr(TemplateList, "section", "Dirt")
	JMap.setStr(TemplateList, "name", "Dirt 3")
	SlaveTats.Query_applied_tattoos(Subject, TemplateList, MatchesList)
	JMap.setStr(TemplateList, "name", "Dirt 2")
	SlaveTats.Query_applied_tattoos(Subject, TemplateList, MatchesList)
	Found = JArray.Count(MatchesList)
	
	If Found > 0
		Found = 2
	Else
		JMap.setStr(TemplateList, "name", "Dirt 1")
		SlaveTats.Query_applied_tattoos(Subject, TemplateList, MatchesList)
		Found = JArray.Count(MatchesList)
		
		If Found > 0
			Found = 1
		EndIf
	EndIf
	
	JValue.release(TemplateList)
	JValue.release(MatchesList)
	
	Return Found
EndFunction

Bool Function CountSlaveTatsOnArea(Actor Subject, String area)
	Int CountTotal
	Int CountExclude
	Int TemplateListTotal = JValue.retain(JMap.object())
	Int MatchesListTotal = JValue.retain(JArray.object())

	JMap.setStr(TemplateListTotal, "area", area)

	SlaveTats.Query_applied_tattoos(Subject, templateListTotal, matchesListTotal)
	CountTotal = JArray.Count(matchesListTotal)
	
	JValue.release(TemplateListTotal)
	JValue.release(MatchesListTotal)
	
	If CountTotal > 0
		Int a
		Int TemplateListExcl
		Int MatchesListExcl
		
		TemplateListExcl = JValue.retain(JMap.object())
		MatchesListExcl = JValue.retain(JArray.object())
		
		JMap.setStr(TemplateListExcl, "section", "Dirt")
		CountExclude += JArray.Count(matchesListExcl)
		
		SlaveTats.Query_applied_tattoos(Subject, templateListExcl, matchesListExcl)
		CountExclude += JArray.Count(matchesListExcl)
	
		While a < Config.ExcludedSlaveTats.Length
			If Config.ExcludedSlaveTats[a] != ""
				TemplateListExcl = JValue.retain(JMap.object())
				MatchesListExcl = JValue.retain(JArray.object())
				
				JMap.setStr(TemplateListExcl, "area", area)
				JMap.setStr(TemplateListExcl, "section", Config.ExcludedSlaveTats[a])
				
				SlaveTats.Query_applied_tattoos(Subject, templateListExcl, matchesListExcl)
				CountExclude += JArray.Count(matchesListExcl)
				
				JValue.release(TemplateListExcl)
				JValue.release(MatchesListExcl)
			EndIf
			
			a += 1
		EndWhile
	EndIf
	Return (CountTotal - CountExclude) as Bool
EndFunction

Int Function CountSlaveTatsTotal(Actor Subject)
	Int CountTotal
	Int CountExclude
	Int TemplateListTotal = JValue.retain(JMap.object())
	Int MatchesListTotal = JValue.retain(JArray.object())

	;JMap.setStr(TemplateListTotal, "area", area)

	SlaveTats.Query_applied_tattoos(Subject, templateListTotal, matchesListTotal)
	CountTotal = JArray.Count(matchesListTotal)
	
	JValue.release(TemplateListTotal)
	JValue.release(MatchesListTotal)
	
	If CountTotal > 0
		Int a
		Int TemplateListExcl
		Int MatchesListExcl
		
		TemplateListExcl = JValue.retain(JMap.object())
		MatchesListExcl = JValue.retain(JArray.object())
		
		JMap.setStr(TemplateListExcl, "section", "Dirt")
		CountExclude += JArray.Count(matchesListExcl)
		
		SlaveTats.Query_applied_tattoos(Subject, templateListExcl, matchesListExcl)
		CountExclude += JArray.Count(matchesListExcl)
	
		While a < Config.ExcludedSlaveTats.Length
			If Config.ExcludedSlaveTats[a] != ""
				TemplateListExcl = JValue.retain(JMap.object())
				MatchesListExcl = JValue.retain(JArray.object())
				
				;JMap.setStr(TemplateListExcl, "area", area)
				JMap.setStr(TemplateListExcl, "section", Config.ExcludedSlaveTats[a])
				
				SlaveTats.Query_applied_tattoos(Subject, templateListExcl, matchesListExcl)
				CountExclude += JArray.Count(matchesListExcl)
				
				JValue.release(TemplateListExcl)
				JValue.release(MatchesListExcl)
			EndIf
			
			a += 1
		EndWhile
	EndIf
	Return (CountTotal - CountExclude)
EndFunction

Bool Function GainFameWithTats(Actor Subject, String Category, String Area)
	Bool Found
	Int TemplateListExcl = JValue.retain(JMap.object())
	Int MatchesListExcl = JValue.retain(JArray.object())
	
	JMap.setStr(TemplateListExcl, "area", Area)
	JMap.setStr(TemplateListExcl, "section", Category)
	
	SlaveTats.Query_applied_tattoos(Subject, templateListExcl, matchesListExcl)
	Found = JArray.Count(matchesListExcl) as Bool
	
	JValue.release(TemplateListExcl)
	JValue.release(MatchesListExcl)
	
	Return Found
EndFunction

Bool Function CanAnimate(Actor Subject)
	If Subject != None
		If Subject.IsInFaction(Sla_Exhibitionist)
			Return False
		Else
			If Config.ShameEffectEnabled && !Config.ShameAnimSuspended
				If !Subject.IsOnMount() && !Subject.IsDead() && !Subject.WornHasKeyword(HandsOffset) && !Subject.IsWeaponDrawn() && !Subject.IsSwimming() && !Subject.IsInFaction(ZbfAnimation) && !Subject.IsInFaction(SlAnimation) && Subject.GetSitState() != 3 && Subject.GetSleepState() != 3 && Subject.GetCombatState() == 0
					If Config.BathingInSkyrimLoaded
						If Subject.HasMagicEffect(Config.BathingInSkyrimEffects[0]) || Subject.HasMagicEffect(Config.BathingInSkyrimEffects[1]) || Subject.HasMagicEffect(Config.BathingInSkyrimEffects[2]) || Subject.HasMagicEffect(Config.BathingInSkyrimEffects[3])
							Return False
						Else
							Return True
						EndIf
					Else
						Return True
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
	Return False
EndFunction

;Function ApplyStartingShame()
;	Utility.Wait(1.0)
;	ApplyShameEffect(PlayerRef)
;EndFunction

Function ApplyShameEffect(Actor Subject)
	If CanAnimate(Subject)
		If Subject.HasMagicEffect(Naked)
			If Subject.GetActorBase().GetSex() == 0
				Debug.SendAnimationEvent(Subject, "ZaZAPCSHMOFF")
			Elseif Subject.GetActorBase().GetSex() == 1
				Debug.SendAnimationEvent(Subject, "ZaZAPCSHFOFF")
			EndIf
			
			If Subject.Is3DLoaded()
				Subject.SetExpressionOverride(11, 50)
			EndIf
		Else
			If Subject.Is3DLoaded()
				Subject.ClearExpressionOverride()
			EndIf
			Debug.SendAnimationEvent(Subject, "OffsetStop")
		EndIf
	EndIf
EndFunction

Function ClearCum(Actor Ref)
	Game.ForceThirdPerson()
	Game.DisablePlayerControls()
	Debug.SendAnimationEvent(Ref, "IdleWipeBrow")
	Utility.Wait(2.0)
	Debug.SendAnimationEvent(Ref, "IdleStop")
	SexLab.ClearCum(Ref)
	Debug.SendAnimationEvent(Ref, "IdleWarmArms")
	ForceEquipStatusUpdate(3)		;ApplyMgef()
	Utility.Wait(1.0)
	Game.EnablePlayerControls()
EndFunction

Function ApplyMgef()
	If !PlayerRef.IsChild()
		Config.PlayerEquipReady = False
		PlayerRef.RemoveSpell(EquipStatus)
		Utility.Wait(0.1)
		PlayerRef.AddSpell(EquipStatus, False)
		Config.PlayerEquipReady = True
	EndIf
EndFunction

Function ToggleDebugSpells()
	If PlayerRef.HasSpell(DebugSpell1)
		PlayerRef.RemoveSpell(DebugSpell1)
		PlayerRef.RemoveSpell(DebugSpell2)
		PlayerRef.RemoveSpell(DebugSpell3)
		PlayerRef.RemoveSpell(DebugSpell4)
	Else
		PlayerRef.AddSpell(DebugSpell1, False)
		PlayerRef.AddSpell(DebugSpell2, False)
		PlayerRef.AddSpell(DebugSpell3, False)
		PlayerRef.AddSpell(DebugSpell4, False)
		Debug.Notification("$SLSFDEBUGSPELLSADDED")
	EndIf
EndFunction

Function CallConfigMenu()
	Config.KeyCallInPause = True
	UIWheelMenu ConfigMenu = UIExtensions.GetMenu("UIWheelMenu", True) as UIWheelMenu
	
	ConfigMenu.SetPropertyIndexString("OptionLabelText", 0, "$SLSFCONFIGMENUSTSPECCONFIGLABEL")	;NameLine
	ConfigMenu.SetPropertyIndexString("OptionText", 0, "$SLSFCONFIGMENUSTSPECCONFIGTEXT")			;Overlay
	ConfigMenu.SetPropertyIndexBool("OptionEnabled", 0, True)											;Enabled
	
	ConfigMenu.SetPropertyIndexString("OptionLabelText", 1, "$SLSFCONFIGMENUEXCLUSIONCHESTADDLABEL")	;NameLine
	ConfigMenu.SetPropertyIndexString("OptionText", 1, "$SLSFCONFIGMENUEXCLUSIONCHESTADDTEXT")			;Overlay
	ConfigMenu.SetPropertyIndexBool("OptionEnabled", 1, True)											;Enabled
	
	ConfigMenu.SetPropertyIndexString("OptionLabelText", 2, "$SLSFCONFIGMENUEXCLUSIONCHESTREMOVELABEL")	;NameLine
	ConfigMenu.SetPropertyIndexString("OptionText", 2, "$SLSFCONFIGMENUEXCLUSIONCHESTREMOVETEXT")		;Overlay
	ConfigMenu.SetPropertyIndexBool("OptionEnabled", 2, True)											;Enabled
		
	ConfigMenu.SetPropertyIndexString("OptionLabelText", 5, "$SLSFCONFIGMENUCLEARCUMLABEL")		;NameLine
	ConfigMenu.SetPropertyIndexString("OptionText", 5, "$SLSFCONFIGMENUCLEARCUMTEXT")			;Overlay
	ConfigMenu.SetPropertyIndexBool("OptionEnabled", 5, True)									;Enabled
	
	ConfigMenu.SetPropertyIndexString("OptionLabelText", 6, "$SLSFCONFIGMENUDEBUGSPELLLABEL")		;NameLine
	ConfigMenu.SetPropertyIndexString("OptionText", 6, "$SLSFCONFIGMENUDEBUGSPELLTEXT")			;Overlay
	ConfigMenu.SetPropertyIndexBool("OptionEnabled", 6, True)									;Enabled
	
	ConfigMenu.SetPropertyIndexString("OptionLabelText", 7, "$SLSFCONFIGMENUFORCEUPDATELABEL")		;NameLine
	ConfigMenu.SetPropertyIndexString("OptionText", 7, "$SLSFCONFIGMENUFORCEUPDATELABELTEXT")			;Overlay
	ConfigMenu.SetPropertyIndexBool("OptionEnabled", 7, True)
	
	Int Selected = ConfigMenu.OpenMenu(none, none)
	If Selected == 0
		CallSpecificSlaveTatsGainConfiguration()
	ElseIf Selected == 1
		ShowTutorialInfo(0)
		Excluded.OpenAddHubList()
	ElseIf Selected == 2
		Excluded.OpenRemoveListHub()
	ElseIf Selected == 5
		ClearCum(PlayerRef)
	ElseIf Selected == 6
		ToggleDebugSpells()
	ElseIf Selected == 7
		ForceEquipStatusUpdate(-1)
	Endif
	
	Config.KeyCallInPause = False
EndFunction

String Function GetBodyLocNameByNumForSTSpecific(Int Num)
	String Value
	If Num == -1
		Value = "None"
	ElseIf Num == 0
		Value = "Body"
	ElseIf Num == 1
		Value = "Body/Head"
	ElseIf Num == 2
		Value = "All"
	EndIf
	
	Return Value
EndFunction

String Function GetFameNameForSTSpecific(Int Num)
	String Value
	If Num >= 0 && Num < Config.FameListPc.Length
		Value = Config.FameListPc[Num]
	Else
		Value = "None"
	EndIf
	Return Value
EndFunction

Function CallSpecificSlaveTatsGainConfiguration()
	If Config.SlaveTatsLoaded
		If Config.AllowIncreaseSpecificWithTats
			ShowTutorialInfo(3)
			UIListMenu SpecSTGainConfig = UIExtensions.GetMenu("UIListMenu", True) as UIListMenu
			
			Int a = Config.STSpecificTatName.Length
			Int b
			While b < a
				SpecSTGainConfig.AddEntryItem("["+b+"] Tats: "+Config.STSpecificTatName[b] as String+". In: "+GetBodyLocNameByNumForSTSpecific(Config.STSpecificBodyLoc[b])+". Fame Type: "+GetFameNameForSTSpecific(Config.STSpecificFameType[b]))
				b += 1
			EndWhile
			
			SpecSTGainConfig.OpenMenu()
			Int Selected = SpecSTGainConfig.GetResultInt()
			
			If Selected != -1
				OpenSpecificSlaveTatsSlot(Selected)
			EndIf
		Else
			Debug.Notification("$SLSF_SAVETATSSPECIFICDISABLED")
		EndIf
	Else
		Debug.Notification("$SLSF_SAVETATSNOTFOUND")
	EndIf
EndFunction

Function OpenSpecificSlaveTatsSlot(Int Which)
	Bool StillOpen = True
	While StillOpen
		UIListMenu SpecSTGainSlot = UIExtensions.GetMenu("UIListMenu", True) as UIListMenu
		SpecSTGainSlot.AddEntryItem("Fame Category: "+Config.STSpecificTatName[Which])
		SpecSTGainSlot.AddEntryItem("Body Location: "+GetBodyLocNameByNumForSTSpecific(Config.STSpecificBodyLoc[Which]))
		SpecSTGainSlot.AddEntryItem("Fame Increased: "+GetFameNameForSTSpecific(Config.STSpecificFameType[Which]))
		SpecSTGainSlot.AddEntryItem("Fame Cap from This: "+Config.STSpecificLimitMax[Which])
		SpecSTGainSlot.AddEntryItem("Clear This Slot")
		
		SpecSTGainSlot.OpenMenu()
		Int Selected = SpecSTGainSlot.GetResultInt()
		
		If Selected == -1
			StillOpen = False
		ElseIf Selected == 0
			String Result
			UITextEntryMenu TextEntry = UIExtensions.GetMenu("UITextEntryMenu", True) as UITextEntryMenu
			TextEntry.SetPropertyString("text", Config.STSpecificTatName[Which])
			TextEntry.OpenMenu()
			Result = TextEntry.GetResultString()
			
			Debug.Notification("Imput Value got: "+Result)
			If Result == ""
				Result = "None"
			EndIf
			
			String OldValue = Config.STSpecificTatName[Which]
			Config.STSpecificTatName[Which] = Result
			
			If Config.STSpecificTatName[Which] != "None" && OldValue == "None"
				If Config.STSpecificBodyLoc[Which] == -1
					Config.STSpecificBodyLoc[Which] = 0
				EndIf
				
				If Config.STSpecificFameType[Which] == -1
					Config.STSpecificFameType[Which] = 0
				EndIf
				
				If Config.STSpecificLimitMax[Which] != 100
					Config.STSpecificLimitMax[Which] = 100
				EndIf
			EndIf
			
			If Result == "None"
				ClearSTSpecificSlot(Which)
			EndIf
		ElseIf Selected == 1
			Int Next = Config.STSpecificBodyLoc[Which] + 1
			If Next > 2
				Next = 0
			EndIf
			Config.STSpecificBodyLoc[Which] = Next
		ElseIf Selected == 2
			Config.STSpecificFameType[Which] = OpenFameListForSpecificSlaveTatsSlot()
		ElseIf Selected == 3
			String Result
			UITextEntryMenu IntEntry = UIExtensions.GetMenu("UITextEntryMenu", True) as UITextEntryMenu
			IntEntry.SetPropertyString("text", Config.STSpecificLimitMax[Which])
			IntEntry.OpenMenu()
			Result = IntEntry.GetResultString()
			
			Debug.Notification("Imput Value got: "+Result)
			If Result == ""
				Result = "100"
			EndIf
			
			Config.STSpecificLimitMax[Which] = Result as Int
		ElseIf Selected == 4
			ClearSTSpecificSlot(Which)
		EndIf
	EndWhile
	STSpecificsCheckDoubles()
EndFunction

Int Function OpenFameListForSpecificSlaveTatsSlot()
	UIListMenu ListOfFame = UIExtensions.GetMenu("UIListMenu", True) as UIListMenu
	Int a = Config.FameListPc.Length
	Int b
	String FameType
	While b < a
		FameType = Config.FameListPc[b]
		ListOfFame.AddEntryItem(FameType)
		b += 1
	EndWhile
	
	ListOfFame.OpenMenu()
	Return ListOfFame.GetResultInt()
EndFunction

Function ClearSTSpecificSlot(Int Which)
	Config.STSpecificTatName[Which] = "None"
	Config.STSpecificBodyLoc[Which] = -1
	Config.STSpecificFameType[Which] = -1
	Config.STSpecificLimitMax[Which] = 100
EndFunction

Function ForceEquipStatusUpdate(Int WhichUpdate)		; -1 All, 0-9 The Surface Specified
	Int Id = ModEvent.Create("SLSF_Request_UpdateEquip")
	If (Id)
		ModEvent.PushInt(Id, WhichUpdate)
		ModEvent.Send(Id)
	EndIf
EndFunction

Int Function GetRoleTypeNum(Actor Subject)
	Return Subject.GetFactionRank(RoleType)
EndFunction

String Function GetRoleType(Actor Subject)
	String Result
	Int Num = Subject.GetFactionRank(RoleType)
	If Num == 0
		Result = "$SLSF_ROLETYPENAME_00"
	ElseIf Num == 1
		Result = "$SLSF_ROLETYPENAME_01"
	ElseIf Num == 2
		Result = "$SLSF_ROLETYPENAME_02"
	ElseIf Num == 20
		Result = "$SLSF_ROLETYPENAME_20"
	ElseIf Num == 21
		Result = "$SLSF_ROLETYPENAME_21"
	ElseIf Num == 22
		Result = "$SLSF_ROLETYPENAME_22"
	ElseIf Num == 40
		Result = "$SLSF_ROLETYPENAME_40"
	ElseIf Num == 41
		Result = "$SLSF_ROLETYPENAME_41"
	ElseIf Num == 42
		Result = "$SLSF_ROLETYPENAME_42"
	EndIf
	Return Result
EndFunction

String Function GetRoleTypeName(Int Num)
	String Result
	If Num == 0
		Result = "Dominant [Kind]"
	ElseIf Num == 1
		Result = "Dominant [Normal]"
	ElseIf Num == 2
		Result = "Dominant [Bastard]"
	ElseIf Num == 20
		Result = "Neutral [Kind]"
	ElseIf Num == 21
		Result = "Neutral [Normal]"
	ElseIf Num == 22
		Result = "Neutral [Bastard]"
	ElseIf Num == 40
		Result = "Submissive [Kind]"
	ElseIf Num == 41
		Result = "Submissive [Normal]"
	ElseIf Num == 42
		Result = "Submissive [Bastard]"
	EndIf
	Return Result
EndFunction

Bool Function RequestTheRoleTypeChange(Int Which, String Sender = "")
	Int Response = -1
	If Sender == ""
		Return False
	EndIf
	
	;String LocString
	;If LocNum < 0
	;	LocString = "For the Current Location."
	;ElseIf LocNum < Config.FameLocationsListString.Length
	;	LocString = "For the Location: "+Config.FameLocationsListString[LocNum]+"."
	;Else
	;	LocNum = -1
	;	LocString = "For the Current Location."
	;Endif
	;
	;If LocNum == -1 && Config.LocationOfValueLoadedNum == -1
	;	Return False
	;EndIf
	
	Bool CycleStop
	While !CycleStop
		Response = RequestRoleTypeChange.Show()
		If Response == 1 || Response == 2
			CycleStop = True
		Else
			Int PlayerActualRoleTypeNum = PlayerRef.GetFactionRank(RoleType)
			Debug.Notification("Request From: "+Sender+"; Actual: "+GetRoleTypeName(PlayerActualRoleTypeNum)+"; If Accept: "+GetRoleTypeName(Which)+".")
			;Debug.Notification(LocString)
		EndIf
		Utility.Wait(0.1)
	EndWhile
	
	If Response == 1
		SetTheRoleType(PlayerRef, Which)
		Debug.Notification("$SLSFACCEPTEDROLETYPECHANGE")
		Return True
	ElseIf Response == 2
		Debug.Notification("$SLSFREFUSEDROLETYPECHANGE")
		Return False
	EndIf
EndFunction

Function SetTheRoleType(Actor Subject, Int Which)
	;Bool Setted = False
	;If Subject != PlayerRef
		Subject.SetFactionRank(RoleType, Which)
		If (Subject.GetActorBase().IsUnique())
			StorageUtil.SetIntValue(Subject, "SLSF.Override.RoleType", Which)
		EndIf
		;Setted = True
	;Else
	;	If LocNum < 0
	;		LocNum = Config.LocationOfValueLoadedNum
	;	EndIf
	;	
	;	If LocNum != -1
	;		;Config.LocationPCRoleTypes[LocNum] = Which
	;		
	;		If LocNum == Config.LocationOfValueLoadedNum
	;			Subject.SetFactionRank(RoleType, Which)
	;			Setted = True
	;		EndIf
	;	EndIf
	;EndIf
	
	;If Setted
		If Which >= 0 && Which < 20
			Subject.SetFactionRank(RoleGroup, 0)
		ElseIf Which >= 20 && Which < 40
			Subject.SetFactionRank(RoleGroup, 1)
		ElseIf Which >= 40
			Subject.SetFactionRank(RoleGroup, 2)
		EndIf
	;EndIf
EndFunction

Function UpdateFameCommentStats(Actor Subject)
	If Subject.IsChild()
		Subject.SetFactionRank(CommentStat, 0)
		Return
	EndIf
	
	If Subject.IsInFaction(AlreadyInitialized)
		Int Result
		Int NoComment = GetIntValue(Subject, "SLSF.NoComment", Missing = -1)
		If Subject.IsInFaction(ExcludedNpc)
			Result = 0
		ElseIf NoComment > 0
			Subject.SetFactionRank(NoCommentFaction, 1)
			Result = 0
		Else
			Subject.SetFactionRank(NoCommentFaction, 0)
			If !Subject.WornHasKeyword(ZbfWornGag) && !PlayerRef.HasMagicEffect(Anonymous)
				Int RType = Subject.GetFactionRank(RoleType)
				Int RelRank = Subject.GetRelationshipRank(PlayerRef)
	
				If RType >= 0 && RType < 50
					If RType == 0 || RType == 20 || RType == 40		;Kind
						If RelRank < 0
							Result = 1
						ElseIf RelRank == 0
							Result = 2
						ElseIf RelRank >= 1 && RelRank < 4
							Result = 3
						Else	; RelRank == 4
							Result = 4
						EndIf
					ElseIf RType == 1 || RType == 21 || RType == 41	;Normal
						If RelRank < 0
							Result = 5
						ElseIf RelRank == 0
							Result = 1
						ElseIf RelRank >= 1 && RelRank < 4
							Result = 2
						Else	; RelRank == 4
							Result = 3
						EndIf
					ElseIf RType == 2 || RType == 22 || RType == 42	;Bastard
						If RelRank < 0
							Result = 6
						ElseIf RelRank == 0
							Result = 5
						ElseIf RelRank >= 1 && RelRank < 4
							Result = 1
						Else	; RelRank == 4
							Result = 2
						EndIf
					EndIf
				EndIf
			Else
				Result = 0
			EndIf
		EndIf
		Subject.SetFactionRank(CommentStat, Result)
	EndIf
EndFunction

Int Function ObtainFameLocationNum(Location Where)
	If Where != None
		Int a
		While a < Config.FameLocationsList.Length
			If Config.FameLocationsList[a] != None
				If Where == Config.FameLocationsList[a] || Config.FameLocationsList[a].IsChild(Where)
					Return a
				EndIf
			EndIf
			a += 1
		EndWhile
	EndIf
	Return -1
EndFunction

Int Function FixRangeValue(Int Value, Int Min = 0, Int Max = 100)
	If Value < Min
		Value = Min
	ElseIf Value > Max
		Value = Max
	Endif
	Return Value
EndFunction	

Function CallSyncFameLocation()
	Int a
	Int Found
	Bool ClearCurrentGlobals = True
	Location Actual = PlayerRef.GetCurrentLocation()
	
	Found = ObtainFameLocationNum(Actual)
	If Found != -1
		Config.LocationOfValuesLoaded = Config.FameLocationsList[Found]
		Config.LocationOfValueLoadedNum = Found
		ClearCurrentGlobals = False
		
		;Int LocRoleType = Config.LocationPCRoleTypes[Found]
		;PlayerRef.SetFactionRank(RoleType, LocRoleType)
		
		;If LocRoleType >= 0 && LocRoleType < 20
		;	PlayerRef.SetFactionRank(RoleGroup, 0)
		;ElseIf LocRoleType >= 20 && LocRoleType < 40
		;	PlayerRef.SetFactionRank(RoleGroup, 1)
		;ElseIf LocRoleType >= 40
		;	PlayerRef.SetFactionRank(RoleGroup, 2)
		;EndIf
		
		;If Config.NotifyChangeRoleTypeWtLoc
		;	Debug.Notification("[SLSF PC RoleType Here: "+GetRoleTypeName(LocRoleType)+"]")
		;Endif
	Else
		Config.LocationOfValuesLoaded = None
		Config.LocationOfValueLoadedNum = -1
		
		;If Config.NotifyChangeRoleTypeWtLoc
		;	Debug.Notification("[SLSF PC RoleType Here: None]")
		;Endif
		;
		;PlayerRef.RemoveFromFaction(Roletype)
		;PlayerRef.RemoveFromFaction(RoleGroup)
	EndIf
	
	If ClearCurrentGlobals
		FameMain.ClearGlobals()
	Else
		a = Config.FameListNpc.Length
		While a > 0
			a -= 1
			Famemain.UpdateGlobal(0, a)
		EndWhile
		
		a = Config.FameListPc.Length
		While a > 0
			a -= 1
			Famemain.UpdateGlobal(1, a)
		EndWhile
	EndIf
EndFunction

Function STSpecificsCheckDoubles()
	Int a
	Int b
	Int CheckFame
	Int CheckBLoc
	Int CheckLimMax
	String CheckTats
	String Comparation
	Int c = Config.STSpecificTatName.Length
	While a < c
		CheckTats = Config.STSpecificTatName[a]
		CheckFame = Config.STSpecificFameType[a]
		CheckBLoc = Config.STSpecificBodyLoc[a]
		CheckLimMax = Config.STSpecificLimitMax[a]
		
		If CheckTats != "None"
			b = Config.STSpecificTatName.Length
			While b > 0
				b -= 1
				Comparation = Config.STSpecificTatName[b]
				If Comparation != "None" && a != b
					If CheckTats == Comparation && CheckFame == Config.STSpecificFameType[b]
						If CheckBLoc < Config.STSpecificBodyLoc[b]
							Config.STSpecificBodyLoc[a] = Config.STSpecificBodyLoc[b]
						EndIf
						
						If CheckLimMax < Config.STSpecificLimitMax[b]
							Config.STSpecificLimitMax[a] = Config.STSpecificLimitMax[b]
						EndIf
						
						ClearSTSpecificSlot(b)
						Debug.Notification("$STSPECIFICSCHECKDOUBLESFOUND")
					EndIf
				EndIf
			EndWhile
		EndIf
		a += 1
	EndWhile
EndFunction

Function ResetLocationsLimit()
	Int a = Config.FameListNpc.Length
	Int b = Config.FameLocationsList.Length
	While b > 0
		While a > 0
			a -= 1
			StorageUtil.IntListSet(None, "SLSF.LocationsFame."+Config.FameListNpc[a]+".LevelMin", b, 0) 
			StorageUtil.IntListSet(None, "SLSF.LocationsFame."+Config.FameListNpc[a]+".LevelMax", b, 100) 
		EndWhile
	
		a = Config.FameListPc.Length
		While a > 0
			a -= 1
			StorageUtil.IntListSet(None, "SLSF.LocationsFame."+Config.FameListPc[a]+".LevelMin", b, 0) 
			StorageUtil.IntListSet(None, "SLSF.LocationsFame."+Config.FameListPc[a]+".LevelMax", b, 100) 
		EndWhile
		b -= 1
	EndWhile
EndFunction

Function ReInstallAllLocationElements()
	Int a = Config.FameListNpc.Length
	While a > 0
		a -= 1
		StorageUtil.IntListClear(None, "SLSF.LocationsFame."+Config.FameListNpc[a])
		StorageUtil.IntListClear(None, "SLSF.LocationsFame."+Config.FameListNpc[a]+".LevelMin")
		StorageUtil.IntListClear(None, "SLSF.LocationsFame."+Config.FameListNpc[a]+".LevelMax")
		
		StorageUtil.IntListResize(None, "SLSF.LocationsFame."+Config.FameListNpc[a], 34)	;Locations Fame (Cumulative NPCs, what the Npc knows about the Npcs activity in this Location)
		StorageUtil.IntListResize(None, "SLSF.LocationsFame."+Config.FameListNpc[a]+".LevelMin", 34)	;The MinValue that the Decrease could reach
		StorageUtil.IntListResize(None, "SLSF.LocationsFame."+Config.FameListNpc[a]+".LevelMax", 34, 100)	;The MaxValue that the Increase could reach
	EndWhile
	
	a = Config.FameListPc.Length
	While a > 0
		a -= 1
		StorageUtil.IntListClear(None, "SLSF.LocationsFame."+Config.FameListPc[a])
		StorageUtil.IntListClear(None, "SLSF.LocationsFame."+Config.FameListPc[a]+".LevelMin")
		StorageUtil.IntListClear(None, "SLSF.LocationsFame."+Config.FameListPc[a]+".LevelMax")
		
		StorageUtil.IntListResize(None, "SLSF.LocationsFame."+Config.FameListPc[a], 34)		;PC Fame (Cumulative PC, what the Npcs knows about the PC activity in this Location)
		StorageUtil.IntListResize(None, "SLSF.LocationsFame."+Config.FameListPc[a]+".LevelMin", 34)	;The MinValue that theDecrease could reach
		StorageUtil.IntListResize(None, "SLSF.LocationsFame."+Config.FameListPc[a]+".LevelMax", 34, 100)	;The MaxValue that the Increase could reach
	EndWhile
	
	;Various
	StorageUtil.IntListClear(None, "SLSF.LocationsFame.CannotDecay")
	StorageUtil.FloatListClear(None, "SLSF.LocationsFame.Form") 
	
	StorageUtil.IntListResize(None, "SLSF.LocationsFame.CannotDecay", 	34)		;Override to avoid Decay (Temporary only)
	StorageUtil.FormListResize(None, "SLSF.LocationsFame.Form", 34)		;Used for the Compatibility Script
EndFunction

Function CheckPapyrusLocationsConsistence()
	Int a = Config.FameListNpc.Length
	Bool ErrorFound
	While a > 0
		a -= 1
		If StorageUtil.IntListCount(None, "SLSF.LocationsFame."+Config.FameListNpc[a]) != 34
			ErrorFound = True
		EndIf
		
		If StorageUtil.IntListCount(None, "SLSF.LocationsFame."+Config.FameListNpc[a]+".LevelMin") != 34
			ErrorFound = True
		EndIf
		
		If StorageUtil.IntListCount(None, "SLSF.LocationsFame."+Config.FameListNpc[a]+".LevelMax") != 34
			ErrorFound = True
		EndIf
	EndWhile
	
	a = Config.FameListPc.Length
	While a > 0
		a -= 1
		If StorageUtil.IntListCount(None, "SLSF.LocationsFame."+Config.FameListPc[a]) != 34
			ErrorFound = True
		EndIf
		
		If StorageUtil.IntListCount(None, "SLSF.LocationsFame."+Config.FameListPc[a]+".LevelMin") != 34
			ErrorFound = True
		EndIf
		
		If StorageUtil.IntListCount(None, "SLSF.LocationsFame."+Config.FameListPc[a]+".LevelMax") != 34
			ErrorFound = True
		EndIf	
	EndWhile
	
	;Various
	If StorageUtil.IntListCount(None, "SLSF.LocationsFame.CannotDecay") != 34
		ErrorFound = True
	EndIf
	
	If StorageUtil.FormListCount(None, "SLSF.LocationsFame.Form") != 34
		ErrorFound = True
	EndIf
	
	If ErrorFound
		MaxiWarning.Show()
	EndIf
EndFunction

Function ToggleSceneInUse(Bool InUse)
	If InUse
		Config.SceneInUse.SetValue(1.0)
	Else
		Config.SceneInUse.SetValue(0.0)
	Endif
EndFunction

;---------------+
;Function Access|
;---------------+

Bool Function PeriodicFameGain(String Sender, Int FameNum, Int LimitMax = 100)
	If Sender == "" && LimitMax > 0
		Return False
	EndIf
	
	If LimitMax < 0
		LimitMax = 0
	EndIf
	
	If FameNum >= 0 && FameNum < Config.FameListPc.Length
		String CurrentSender = Config.PeriodicIncSender[FameNum]
		If LimitMax > Config.PeriodicIncValue[FameNum]
			Config.PeriodicIncValue[FameNum] = LimitMax
			Config.PeriodicIncSender[FameNum] = Sender
			Debug.Trace("[SLSF] Request of Periodic Fame Gain from "+Sender+" for Increase Limit Max to: "+LimitMax+"; Request ACCEPTED.")
			Return True
		Else
			If CurrentSender == Sender
				If LimitMax == 0
					Config.PeriodicIncSender[FameNum] = ""
				EndIf
				
				Config.PeriodicIncValue[FameNum] = LimitMax
				Debug.Trace("[SLSF] Request of Periodic Fame Gain from "+Sender+" for Decrease Limit Max to: "+LimitMax+"; Request ACCEPTED.")
				Return True
			Else
				Debug.Trace("[SLSF] Request of Periodic Fame Gain from "+Sender+", already Increasing from "+CurrentSender+" for higher value; Request REFUSED.")
				Return False
			EndIf
		EndIf
	EndIf
EndFunction

Int Function GetCurrentSingleFameValue(Bool AboutPC, Int FameNum)
	If AboutPC
		If FameNum >= 0 && FameNum < ListCurrentFamePC.GetSize()
			Return (ListCurrentFamePC.GetAt(FameNum) as GlobalVariable).GetValue() as Int
		EndIf
	Else
		If FameNum >= 0 && FameNum < ListCurrentFameNPC.GetSize()
			Return (ListCurrentFameNPC.GetAt(FameNum) as GlobalVariable).GetValue() as Int
		EndIf
	EndIf
	Return -1
EndFunction

Int[] Function GetCurrentFameValues(Bool AboutPC = True)
	Int[] Result
	FormList List
	If AboutPC
		List = ListCurrentFamePC
	Else
		List = ListCurrentFameNPC
	EndIf
	
	Int a = List.GetSize()
	Result = Utility.CreateIntArray(a)
	While a > 0
		a -= 1
		Result[a] = (List.GetAt(a) as GlobalVariable).GetValue() as Int
	EndWhile
	Return Result
EndFunction

Bool Function ContageFame(Int ContagerNum, Int ToContageNum, Bool AssuredContage = False, Float OverrideContageAmount = 0.0 )
	Int Max = Config.FameLocationsList.Length
	If ContagerNum < 0 || ContagerNum >= Max
		Return False
	EndIf
	
	If ToContageNum < 0 || ToContageNum >= Max
		Int a = 20
		Int b
		While a > 0
			a -= 1
			b = Utility.RandomInt(1, Max) - 1
			If Config.FameLocationsList[b] != None
				ToContageNum = b
			EndIf
		EndWhile		
	EndIf
	
	Return FameMain.ContageFamePc(ContagerNum, ToContageNum, AssuredContage, OverrideContageAmount)
EndFunction

Bool Function ModMorbosty(Int LocNum, Float Value, Bool SetTheValue = False)
	Int Max = Config.FameLocationsList.Length
	If LocNum < 0 || LocNum >= Max
		Return False
	EndIf
	
	If !SetTheValue
		Value = Config.LocationFameMorbosity[LocNum] + Value
	EndIf
	
	If Value < 0.0
		Value = 0.0
	ElseIf Value > 1.0
		Value = 1.0
	EndIf
	Config.LocationFameMorbosity[LocNum] = Value
	Return True
EndFunction

Bool Function ModMorbosityReq(Int LocNum, Float Value, Bool SetTheValue = False)
	Int Max = Config.FameLocationsList.Length
	If LocNum < 0 || LocNum >= Max
		Return False
	EndIf
	
	If !SetTheValue
		Value = Config.LocationFameRequiredMorbosity[LocNum] + Value
	EndIf
	
	If Value < 0.0
		Value = 0.0
	ElseIf Value > 1.0
		Value = 1.0
	EndIf
	Config.LocationFameRequiredMorbosity[LocNum] = Value
	Return True
EndFunction

Bool Function SetRoleType(String Sender, Actor Who, Int RoleNum)
	If Who as Actor
		If Who == PlayerRef
			If Sender != ""
				Return RequestTheRoleTypeChange(RoleNum, Sender)
			EndIf
		Else
			SetTheRoleType(Who as Actor, RoleNum)
			Return True
		EndIf
	EndIf
EndFunction

Function UpdateEquip(Int WhichSurface = -1)
	Bool[] Surface = New Bool[10]
	
	If WhichSurface == -1
		Surface[0] = True
		Surface[1] = True
		Surface[2] = True
		Surface[3] = True
		Surface[4] = True
		Surface[5] = True
		Surface[6] = True
		Surface[7] = True
		Surface[8] = True
		Surface[9] = True
	ElseIf  WhichSurface == 0
		Surface[0] = True
	ElseIf  WhichSurface == 1
		Surface[1] = True
	ElseIf  WhichSurface == 2
		Surface[2] = True
	ElseIf  WhichSurface == 3
		Surface[3] = True
	ElseIf  WhichSurface == 4
		Surface[4] = True
	ElseIf  WhichSurface == 5
		Surface[5] = True
		Surface[7] = True
		Surface[9] = True
	ElseIf  WhichSurface == 6
		Surface[6] = True
	ElseIf  WhichSurface == 7
		Surface[5] = True
		Surface[7] = True
		Surface[9] = True
	ElseIf  WhichSurface == 8
		Surface[8] = True
	ElseIf  WhichSurface == 9
		Surface[5] = True
		Surface[7] = True
		Surface[9] = True
	EndIf
	
	If Surface[0]
		Monitor.CheckSurfaces1()
	EndIf
	
	If Surface[1]
		Monitor.CheckSurfaces1()
	EndIf
	
	If Surface[2]
		Monitor.CheckSurfaces2()
	EndIf
	
	If Surface[3]
		Monitor.CheckSurfaces3()
	EndIf
	
	;If Surface[4]
	;	Monitor.CheckSurfaces3()
	;EndIf
	
	;If Surface[6]
	;	Monitor.CheckSurfaces3()
	;EndIf
	
	;If Surface[8]
	;	Monitor.CheckSurfaces3()
	;EndIf
	
	If Surface[5] || Surface[7] || Surface[9]
		Monitor.CheckSurFaces5_7And9_From_Event()
	EndIf
	
	If Surface[1] || Surface[2] || Surface[3]
		Monitor.ApplyMgef()
	EndIf
EndFunction

Function SuspendShameAnimByRequest(Bool YesOrNot)
	Config.ShameAnimSuspended = YesOrNot
EndFunction

Int Function GetReactionType(Actor Who)
	Int Result = -1
	Result = Who.GetFactionRank(CommentStat)
	Return Result
EndFunction

Int Function AccessFunctionGetRoleType(Actor Who)
	Int Result = -1
	Result = StorageUtil.GetIntValue(Who, "SLSF.Exclusion", Missing = -1)
	
	If Result <= 0
		Result = StorageUtil.GetIntValue(Who, "SLSF.Override.RoleType", Missing = -2)
		If Result == -2
			Result = Who.GetFactionRank(RoleType)
		EndIf
	Else
		Result = -3
	EndIf
	Return Result
EndFunction

Int Function GetRoleGroup(Actor Who)
	Int Result = -1
	Result = StorageUtil.GetIntValue(Who, "SLSF.Exclusion", Missing = -1)
	
	If Result <= 0
		Result = Who.GetFactionRank(RoleGroup)
	Else
		Result = -3
	EndIf
	Return Result
EndFunction

Bool Function ToggleNPCExclusionSLSF(Actor Who)
	Bool IsExcluded
	IsExcluded = StorageUtil.GetIntValue(Who, "SLSF.Exclusion") as Bool
	If IsExcluded
		StorageUtil.SetIntValue(Who, "SLSF.Exclusion", 0)
		Who.RemoveFromFaction(ExcludedNpc)
	Else
		StorageUtil.SetIntValue(Who, "SLSF.Exclusion", 1)
		Who.SetFactionRank(ExcludedNpc, 1)
	EndIf
	Return !IsExcluded
EndFunction

Bool Function ToggleNPCNoCommentSLSF(Actor Who)
	Bool NoComment
	NoComment = StorageUtil.GetIntValue(Who, "SLSF.NoComment") as Bool
	If NoComment
		StorageUtil.SetIntValue(Who, "SLSF.NoComment", 0)
		Who.SetFactionRank(NoCommentFaction, 0)
	Else
		StorageUtil.SetIntValue(Who, "SLSF.NoComment", 1)
		Who.SetFactionRank(NoCommentFaction, 1)
	EndIf
	Return !NoComment
EndFunction

Function SetCommentProbability(Float HowMuch)
	If HowMuch < 0.0
		Config.AllowCommentProbability = Config.CommentProbabilityRepository
	Else
		If HowMuch > 1.0
			Config.AllowCommentProbability = 1.0
		Else
			Config.AllowCommentProbability = HowMuch
		EndIf
	EndIf
EndFunction

Bool Function CheckSceneinUse()
	Return Config.SceneInUse.GetValue() as Bool
EndFunction

Bool Function Request_SceneInUse(Bool RequestUse)
	If RequestUse && CheckSceneinUse()
		Return False
	EndIf
	ToggleSceneInUse(RequestUse)
	Return True
EndFunction

Location[] Function GetAllLocationForm()
	Form[] ListAsForm = StorageUtil.FormListToArray(None, "SLSF.LocationsFame.Form")
	Location[] ListAsLocation = New Location[34]
	Int a = ListAsForm.Length
	While a > 0
		a -= 1
		ListAsLocation[a] = ListAsForm[a] As Location
	EndWhile
	
	Return ListAsLocation
EndFunction

;Bool Function PlayerIsTalking()
;	Actor[] NearbyNpc = MiscUtil.ScanCellActors(PlayerRef, 500.0)
;	Int a = NearbyNpc.Length
;	While a > 0
;		a -= 1
;		If NearbyNpc[a].IsInDialogueWithPlayer()
;			Return True
;		EndIf
;	EndWhile
;	Return False
;EndFunction
