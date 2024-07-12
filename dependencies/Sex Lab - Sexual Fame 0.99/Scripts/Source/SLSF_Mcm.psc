Scriptname SLSF_Mcm extends SKI_ConfigBase

SLSF_Configuration Property Config Auto
SLSF_Monitor Property Monitor Auto
SLSF_FameMaintenance Property FameMain Auto
SLSF_Utility Property SLSFUtility Auto

Int ActualLocationShowed
Int RoleTypeReal
Int RoleTypeString

Int Function GetVersion()
	Return 1 ; Default version
EndFunction

Function LoadRoleTypeConversion()
	RoleTypeReal = SLSFUtility.GetRoleTypeNum(SLSFUtility.PlayerRef)
	If RoleTypeReal >= 0 && RoleTypeReal <= 2
		RoleTypeString = RoleTypeReal
	ElseIf RoleTypeReal == 20
		RoleTypeString = 3
	ElseIf RoleTypeReal == 21
		RoleTypeString = 4
	ElseIf RoleTypeReal == 22
		RoleTypeString = 5
	ElseIf RoleTypeReal == 40
		RoleTypeString = 6
	ElseIf RoleTypeReal == 41
		RoleTypeString = 7
	ElseIf RoleTypeReal == 42
		RoleTypeString = 8
	Else
		RoleTypeString = 4
	EndIf
EndFunction

Int Function ConvertRoleTypeStringToReal()
	If RoleTypeString >= 0 && RoleTypeString <= 2
		RoleTypeReal = RoleTypeString
	ElseIf RoleTypeString == 3
		RoleTypeReal = 20
	ElseIf RoleTypeString == 4
		RoleTypeReal = 21
	ElseIf RoleTypeString == 5
		RoleTypeReal = 22
	ElseIf RoleTypeString == 6
		RoleTypeReal = 40
	ElseIf RoleTypeString == 7
		RoleTypeReal = 41
	ElseIf RoleTypeString == 8
		RoleTypeReal = 42
	Else
		RoleTypeReal = 21
	EndIf
	Return RoleTypeReal
EndFunction

Event OnConfigInit()
	ModName = "Sex Lab - Sexual Fame"
	Pages = New String[4]
	Pages[0] = "$SLSF_MCM_BS"
	Pages[1] = "$SLSF_MCM_CN"
	Pages[2] = "$SLSF_MCM_FC"
	Pages[3] = "$SLSF_MCM_FW"
EndEvent

Event OnVersionUpdate(int a_version)
	If (a_version > 1)
		Debug.Trace(self + ": Updating script to version " + a_version)
		OnConfigInit()
	EndIf
EndEvent

;Pages
Event OnPageReset(String a_page)
	{Called when a new page is selected, including the initial empty page}

	; Load custom logo in DDS format
	If (a_page == "")
		; Image size 300x450
		; X offset = 376 - (height / 2) = 226
		; Y offset = 223 - (width / 2) = -2
		LoadCustomContent("SexLab - SexualFame/SexLab SexualFame Logo.dds", 226, -2)
		Return
	Else
		UnloadCustomContent()
	EndIf
	
	If (a_page == "$SLSF_MCM_BS")
		LoadRoleTypeConversion()
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$SLSF_MCM_BS_H_B")
		AddToggleOptionST("BaseSetting_ChildRemover_TG", "$SLSF_MCM_BS_CHILDRE", Config.ChildRemover)
		AddToggleOptionST("BaseSetting_ShameEffect_TG", "$SLSF_MCM_BS_SHAMEEF", Config.ShameEffectEnabled)
		AddToggleOptionST("BaseSetting_AllowAnonymous_TG", "$SLSF_MCM_BS_ALLOWANONYMOUS", (Config.AllowAnonymous.GetValue() as Bool))
		AddToggleOptionST("BaseSetting_DisableNotificationinc_TG", "$SLSF_MCM_BS_DISNOTINC", Config.NotificationIncrease)
		;AddToggleOptionST("BaseSetting_ChangeRolWtLoc_TG", "$SLSF_MCM_BS_CHANGROLWTLOC", Config.NotifyChangeRoleTypeWtLoc)
		AddToggleOptionST("BaseSetting_Tutorial_TG", "$SLSF_MCM_BS_TUTORIA", Config.DisableTutorial)
		AddToggleOptionST("BaseSetting_Tutorial_Reset_TG", "$SLSF_MCM_BS_TUTORIARESET", False)
		
		AddEmptyOption()
		AddHeaderOption("$SLSF_MCM_BS_H_MODIN")
		AddToggleOptionST("BaseSetting_LoadedSlaveT_TG", "$SLSF_MCM_BS_LOADSLT", Config.SlaveTatsLoaded, OPTION_FLAG_DISABLED)
		AddToggleOptionST("BaseSetting_LoadedHydraSlave_TG", "$SLSF_MCM_BS_LOADHYS", Config.HydraSlavegirlsLoaded, OPTION_FLAG_DISABLED)
		AddToggleOptionST("BaseSetting_LoadedDeviousD_TG", "$SLSF_MCM_BS_LOADDDI", Config.DeviousDevicesIntegrationLoaded, OPTION_FLAG_DISABLED)
		AddToggleOptionST("BaseSetting_LoadedBathingInSkyrim_TG", "$SLSF_MCM_BS_LOADBIS", Config.BathingInSkyrimLoaded, OPTION_FLAG_DISABLED)
		AddToggleOptionST("BaseSetting_LoadedEstrusChaurus_TG", "$SLSF_MCM_BS_ESTRUSCHAURUS", Config.EstrusChaurusLoaded, OPTION_FLAG_DISABLED)
		AddToggleOptionST("BaseSetting_LoadedSGO_TG", "$SLSF_MCM_BS_SGOLoaded", Config.SoulGemOvenLoaded, OPTION_FLAG_DISABLED)
		
		
		SetCursorPosition(1)
		AddHeaderOption("")
		AddSliderOptionST("BaseSetting_CommentProb_SL", "$SLSF_MCM_BS_COMMPROB", Config.AllowCommentProbability * 100, "{0}%")
		AddSliderOptionST("BaseSetting_UpdateInterval_SL", "$SLSF_MCM_BS_UPDATEINT", Config.BaseUpdateInterval, "{0} Sec")
		AddKeyMapOptionST("BaseSetting_MenuKey_KY", "$SLSF_MCM_BS_MENUKEY", Config.KeyForConfigMenu)
		AddToggleOptionST("BaseSetting_CumAlwaysHiddable_TG", "$SLSF_MCM_BS_CUMALWAYSHIDDABLE", Config.CumAlwaysHiddable)
		
		AddEmptyOption()
		AddHeaderOption("$SLSF_MCM_BS_H_COMPANDEXTRAS")
		;AddToggleOptionST("BaseSetting_SLAExtendList_TG", "$SLSF_MCM_BS_EXTENDLIST_TG", Config.SlaExtensionList)
		
		If Config.SlaveTatsLoaded
			AddToggleOptionST("BaseSetting_STSpecificGain_TG", "$SLSF_MCM_BS_STSPECGAIN_TG", Config.AllowIncreaseSpecificWithTats)
		EndIf
		
		If Config.SoulGemOvenLoaded
			AddSliderOptionST("BaseSetting_SGOLevelProgNeeded_SL", "$SLSF_MCM_BS_SGOLVLPROGNEED_SL", Config.SGOProgressionGemLevelNeeded, "{0}")
		EndIf
		
		;If Config.DeviousDevicesIntegrationLoaded
		;	AddSliderOptionST("BaseSetting_DDVibrationIncFame_SL", "$SLSF_MCM_BS_DDINTEGFAME_SL", Config.DDVibAnimIncreaseFame)
		;EndIf
		
		AddEmptyOption()
		AddHeaderOption("$SLSF_MCM_BS_H_DEBUGSECTION")
		AddTextOptionST("BaseSetting_Debug_ReloadBaseLocation_TX", "$SLSF_MCM_BS_RELOADBASELOCATION_TX", "")
		AddTextOptionST("BaseSetting_Debug_ResetAllStandardLimits_TX", "$SLSF_MCM_BS_RESETALLLOCLIM_TX", "")
		AddTextOptionST("BaseSetting_Debug_ReInstallAllLocationElements_TX", "$SLSF_MCM_BS_REINSTALLALLLOCELEMENTS_TX", "")
		AddTextOptionST("BaseSetting_Debug_ResetSTSpecific_TX", "$SLSF_MCM_BS_RESETSTSPEC_TX", "")
		AddMenuOptionST("FameView_RoletypePCSelector_MN", "$SLSF_MCM_FW_PCRTSEL_MN", Config.RoleTypeListstring[RoleTypeString])
		
		
	ElseIf (a_page == "$SLSF_MCM_CN")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$SLSF_MCM_CN_H_ROLET")
		AddSliderOptionST("ConfigNpc_ProbGenDominant_SL", "$SLSF_MCM_CN_GENERALDOM_SL", Config.ProbMaster)
		AddSliderOptionST("ConfigNpc_ProbGenDom_Kind_SL", "$SLSF_MCM_CN_DOMKIND_SL", Config.ProbMasterKind)
		AddSliderOptionST("ConfigNpc_ProbGenDom_Norm_SL", "$SLSF_MCM_CN_DOMNORM_SL", Config.ProbMasterNorm)
		AddSliderOptionST("ConfigNpc_ProbGenDom_Bast_SL", "$SLSF_MCM_CN_DOMBAST_SL", Config.ProbMasterBast)
		
		AddSliderOptionST("ConfigNpc_ProbGenNeutral_SL", "$SLSF_MCM_CN_GENERALNEU_SL", Config.ProbFree)
		AddSliderOptionST("ConfigNpc_ProbGenNeu_Kind_SL", "$SLSF_MCM_CN_NEUKIND_SL", Config.ProbFreeKind)
		AddSliderOptionST("ConfigNpc_ProbGenNeu_Norm_SL", "$SLSF_MCM_CN_NEUNORM_SL", Config.ProbFreeNorm)
		AddSliderOptionST("ConfigNpc_ProbGenNeu_Bast_SL", "$SLSF_MCM_CN_NEUBAST_SL", Config.ProbFreeBast)
		
		AddSliderOptionST("ConfigNpc_ProbGenSubmissive_SL", "$SLSF_MCM_CN_GENERALSUB_SL", Config.ProbSlave)
		AddSliderOptionST("ConfigNpc_ProbGenSub_Kind_SL", "$SLSF_MCM_CN_SUBKIND_SL", Config.ProbSlaveKind)
		AddSliderOptionST("ConfigNpc_ProbGenSub_Norm_SL", "$SLSF_MCM_CN_SUBNORM_SL", Config.ProbSlaveNorm)
		AddSliderOptionST("ConfigNpc_ProbGenSub_Bast_SL", "$SLSF_MCM_CN_SUBBAST_SL", Config.ProbSlaveBast)
		
		SetCursorPosition(1)
		AddHeaderOption("$SLSF_MCM_CN_EXHIB")
		AddToggleOptionST("ConfigNpc_DefineExhib_TG", "$SLSF_MCM_CN_DEFINEEXHIB", Config.DefineExhib)
		AddSliderOptionST("ConfigNpc_DefineExhibitionist_Prob_SL", "$SLSF_MCM_CN_DEFINEEXHIB_PROB", Config.ProbExhibitionist * 100, "{0}%")
		
		AddEmptyOption()
		AddHeaderOption("$SLSF_MCM_CN_EQUIP")
		AddToggleOptionST("ConfigNpc_BaseEquip_TG", "$SLSF_MCM_CN_BASEEQUIP_TG", Config.BaseEquipNPC)
		AddSliderOptionST("ConfigNpc_BaseEquip_EquipBody_SL", "$SLSF_MCM_CN_BASEEQUIP_B_SL", Config.ProbBaseEquipBodyNPC * 100, "{0}%")
		AddSliderOptionST("ConfigNpc_BaseEquip_EquipFeet_SL", "$SLSF_MCM_CN_BASEEQUIP_F_SL", Config.ProbBaseEquipFeetNPC * 100, "{0}%")
		AddSliderOptionST("ConfigNpc_BaseEquip_EquipMisc_SL", "$SLSF_MCM_CN_BASEEQUIP_M_SL", Config.ProbBaseEquipMiscNPC * 100, "{0}%")
		
		AddEmptyOption()
		AddTextOptionST("SLSF_mcm_cn_h_kind_equip_TX", "$SLSF_MCM_CN_H_KIND_EQUIP", "")
		AddSliderOptionST("ConfigNpc_Weight_SKind_Poor_SL", "$SLSF_MCM_CN_SUBKIND_EQUIP_POOR_SL", Config.EquipWeightKindPoor)
		AddSliderOptionST("ConfigNpc_Weight_SKind_Med_SL",  "$SLSF_MCM_CN_SUBKIND_EQUIP_MED_SL", Config.EquipWeightKindMed)
		AddSliderOptionST("ConfigNpc_Weight_SKind_Rich_SL", "$SLSF_MCM_CN_SUBKIND_EQUIP_RICH_SL", Config.EquipWeightKindRich)
		
		AddTextOptionST("SLSF_mcm_cn_h_norm_equip_TX", "$SLSF_MCM_CN_H_NORM_EQUIP", "")
		AddSliderOptionST("ConfigNpc_Weight_SNorm_Poor_SL", "$SLSF_MCM_CN_SUBNORM_EQUIP_POOR_SL", Config.EquipWeightNormPoor)
		AddSliderOptionST("ConfigNpc_Weight_SNorm_Med_SL",  "$SLSF_MCM_CN_SUBNORM_EQUIP_MED_SL", Config.EquipWeightNormMed)
		AddSliderOptionST("ConfigNpc_Weight_SNorm_Rich_SL", "$SLSF_MCM_CN_SUBNORM_EQUIP_RICH_SL", Config.EquipWeightNormRich)
		
		AddTextOptionST("SLSF_mcm_cn_h_bast_equip_TX", "$SLSF_MCM_CN_H_BAST_EQUIP", "")
		AddSliderOptionST("ConfigNpc_Weight_SBast_Poor_SL", "$SLSF_MCM_CN_SUBBAST_EQUIP_POOR_SL", Config.EquipWeightBastPoor)
		AddSliderOptionST("ConfigNpc_Weight_SBast_Med_SL",  "$SLSF_MCM_CN_SUBBAST_EQUIP_MED_SL", Config.EquipWeightBastMed)
		AddSliderOptionST("ConfigNpc_Weight_SBast_Rich_SL", "$SLSF_MCM_CN_SUBBAST_EQUIP_RICH_SL", Config.EquipWeightBastRich)
	ElseIf (a_page == "$SLSF_MCM_FC")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$SLSF_MCM_FC_FAMEGAIN")
		AddSliderOptionST("FameConfig_GainMultiplier_SL", "$SLSF_MCM_FC_FAMEGAIN_SL", Config.LocationFameModInc, "{1}")
		AddToggleOptionST("FameConfig_NeedLosGainFame_TG", "$SLSF_MCM_FC_NEEDLOSGAINFAME_TG", Config.NeedLosForFameGainRequest)
		AddSliderOptionST("FameConfig_DistanceWithoutLos_SL", "$SLSF_MCM_FC_DISTANCEWITHOUTLOSNEEDED_SL", Config.DistanceWithoutLosNeeded, "{0} units")
		AddSliderOptionST("FameConfig_VariationFameNpc_SL", "$SLSF_MCM_FC_VARIATIONFNPCRANGE_SL", Config.VariationFameNpcRange * 100, "{0}%")
		
		;If Config.SlaveTatsLoaded
		;	AddSliderOptionST("FameConfig_STSpecificGainMax_SL", "$SLSF_MCM_FC_STSPECGAINMAX_SL", Config.MaxGainFromSlaveTatsSpecific, "{0}")
		;EndIf
		
		If Config.DeviousDevicesIntegrationLoaded
			AddSliderOptionST("FameConfig_DDVibGainMax_SL", "$SLSF_MCM_FC_DDVIBGAINMAX_SL", Config.MaxGainFromDDVibrationEvent, "{0}")
		EndIf
		
		
		AddEmptyOption()
		AddHeaderOption("$SLSF_MCM_FC_FAMELOST")
		AddSliderOptionST("FameConfig_LoseMultiplier_SL", "$SLSF_MCM_FC_FAMELOSE_SL", Config.LocationFameModDec, "{1}")
		AddSliderOptionST("FameConfig_LoseDayDelay_SL", "$SLSF_MCM_FC_FAMEDAYDELAYDECEREASE_SL", Config.FameDayDelayBeforeDecrease, "{1}")
		AddSliderOptionST("FameConfig_AmountGamePcDecadence_SL", "$SLSF_MCM_FC_AMOUNTFAMEPCDECADENCE_SL", Config.AmountFamePCLocationDecadence, "-{0}")
		
		AddEmptyOption()
		AddHeaderOption("$SLSF_MCM_FC_PROBCOUNT")
		AddSliderOptionST("FameConfig_ProbFameIncLov_SL", "$SLSF_MCM_FC_PROBFAMEINCLOV_SL", Config.FameIncreaseByLover * 100, "{0}%")
		AddSliderOptionST("FameConfig_ProbFameIncFri_SL", "$SLSF_MCM_FC_PROBFAMEINCFRI_SL", Config.FameIncreaseByFriend * 100, "{0}%")
		AddSliderOptionST("FameConfig_ProbFameIncNeu_SL", "$SLSF_MCM_FC_PROBFAMEINCNEU_SL", Config.FameIncreaseByNeutral * 100, "{0}%")
		AddSliderOptionST("FameConfig_ProbFameIncEne_SL", "$SLSF_MCM_FC_PROBFAMEINCENE_SL", Config.FameIncreaseByEnemy * 100, "{0}%")
		
		AddEmptyOption()
		
		SetCursorPosition(1)
		AddHeaderOption("$SLSF_MCM_FC_FAMECONTAGE")
		AddSliderOptionST("FameConfig_ContageMagnitudo_SL", "$SLSF_MCM_FC_CONTAGEMAGNITUDO_SL", Config.ContageMagnitudo * 100, "{0}%")
		AddSliderOptionST("FameConfig_ModContageSameLoc_SL", "$SLSF_MCM_FC_MODCONTAGESAMELOC_SL", Config.ModIfINSameLocation * 100, "{0}%")
		AddSliderOptionST("FameConfig_ModContageNotSameLoc_SL", "$SLSF_MCM_FC_MODCONTAGENOTSAMELOC_SL", Config.ModIfNOTSameLocation * 100, "{0}%")
		AddSliderOptionST("FameConfig_FameMinAllowContage_SL", "$SLSF_MCM_FC_FAMEMINALLOWCONTAGE_SL", Config.FameMinToAllowContage)
		AddSliderOptionST("FameConfig_DaysDelayBefContageNew_SL", "$SLSF_MCM_FC_DAYDELBEFCONTAG_SL", Config.DaysDelayBeforeNewContage, "{1}")
		AddSliderOptionST("FameConfig_BaseProbContage_SL", "$SLSF_MCM_FC_BASEPRCONTAG_SL", Config.BaseProbabilityContage * 100, "{0}%")
		AddSliderOptionST("FameConfig_ModMorbAtCont_SL", "$SLSF_MCM_FC_MODMORBATCONTAGE_SL", Config.ModMorbosityAtContage * 100, "{0}%")
		
		AddEmptyOption()
		
		AddHeaderOption("$SLSF_MCM_FC_TEMPLOC")
		AddSliderOptionST("FameConfig_TemporaryFameExp_SL", "$SLSF_MCM_FC_TEMPFAMEEXP_SL", Config.TemporaryFameLocationExpiration)
		AddToggleOptionST("FameConfig_RandomizeTempFameAtStart_TG", "$SLSF_MCM_FC_RANDTEMPFAS_TG", Config.RandomizeTemporaryFameAtStart)
		AddSliderOptionST("FameConfig_ProbRndFillTempLib_SL", "$SLSF_MCM_FC_PROBTEMPLIB_SL", Config.ProbRandomFillTempLib)
		AddSliderOptionST("FameConfig_ProbRndFillTempPro_SL", "$SLSF_MCM_FC_PROBTEMPPRO_SL", Config.ProbRandomFillTempPro)
		AddSliderOptionST("FameConfig_ProbRndFillTempRap_SL", "$SLSF_MCM_FC_PROBTEMPRAP_SL", Config.ProbRandomFillTempRap)
		AddSliderOptionST("FameConfig_ProbRndFillTempSla_SL", "$SLSF_MCM_FC_PROBTEMPSLA_SL", Config.ProbRandomFillTempSla)
		AddSliderOptionST("FameConfig_ProbRndFillTempZoo_SL", "$SLSF_MCM_FC_PROBTEMPZOO_SL", Config.ProbRandomFillTempZoo)
		AddSliderOptionST("FameConfig_ProbRndFillTempMig_SL", "$SLSF_MCM_FC_PROBTEMPMIG_SL", Config.ProbRandomFillTempMig)
		AddSliderOptionST("FameConfig_ProbRndFillTempMia_SL", "$SLSF_MCM_FC_PROBTEMPMIA_SL", Config.ProbRandomFillTempMia)

	ElseIf (a_page == "$SLSF_MCM_FW")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddMenuOptionST("FameView_LocationSelector_MN", "$SLSF_MCM_FW_LOCSEL_MN", Config.FameLocationsListString[ActualLocationShowed])

		If Config.FameLocationsList[ActualLocationShowed] != None
			AddSliderOptionST("FameView_LocMorbosity_SL", "$SLSF_MCM_FW_LOCMORBOS_SL", Config.LocationFameMorbosity[ActualLocationShowed] * 100, "{0}%")
			AddToggleOptionST("FameView_IsTemporaryLoc_TG", "$SLSF_MCM_FW_LOCTEMP_TG", Config.TemporaryLocation[ActualLocationShowed], OPTION_FLAG_DISABLED)
			AddTextOptionST("FameView_RandomizerNPCFame_TX", "$SLSF_MCM_FW_RANDOMIZNPCF_TX", "")
			AddTextOptionST("FameView_CleanNPCFame_TX", "$SLSF_MCM_FW_CLEANNPCFAME_TX", "")
			
			;List NPC
			AddHeaderOption("$SLSF_MCM_FW_NPC")
			Int a = Config.FameListNpc.Length
			Int[] Values = New Int[3]
			While a > 0
				a -= 1
				Values[0] = SLSFUtility.FixRangeValue(StorageUtil.IntListGet(None, "SLSF.LocationsFame."+Config.FameListNpc[a], ActualLocationShowed))
				Values[1] = SLSFUtility.FixRangeValue(StorageUtil.IntListGet(None, "SLSF.LocationsFame."+Config.FameListNpc[a]+".LevelMin", ActualLocationShowed))
				Values[2] = SLSFUtility.FixRangeValue(StorageUtil.IntListGet(None, "SLSF.LocationsFame."+Config.FameListNpc[a]+".LevelMax", ActualLocationShowed))
				AddTextOptionST("FameView_ShowFameNPC"+a+"_TX", Config.FameListNpc[a], Values[0]+" ["+Values[1]+"-"+Values[2]+"]")
			EndWhile
			
			SetCursorPosition(1)
			If ActualLocationShowed == Config.LocationOfValueLoadedNum
				AddTextOptionST("FameView_IsTheActualLoaded_TX", "$SLSF_MCM_FW_CURRENTLOC_TX", "")
			Else
				If Config.LocationOfValueLoadedNum != -1
					AddTextOptionST("FameView_GoToActualLoaded_TX", "$SLSF_MCM_FW_GOTOCURRENTLOC_TX", "")
				Else
					AddEmptyOption()
				EndIf
			EndIf
			
			AddSliderOptionST("FameView_LocMorbosityReq_SL", "$SLSF_MCM_FW_LOCMORBOSREQ_SL", Config.LocationFameRequiredMorbosity[ActualLocationShowed] * 100, "{0}%")
			
			If Config.TemporaryLocation[ActualLocationShowed]
				AddToggleOptionST("FameView_CannotDecay_TG", "$SLSF_MCM_FW_CATDECAY_TG", StorageUtil.IntListGet(None, "SLSF.LocationsFame.CannotDecay", ActualLocationShowed)as Bool)
				AddTextOptionST("FameView_ResetLocationFame_TX", "$SLSF_MCM_FW_RESETLOCAT_TX", "")
			Else
				AddEmptyOption()
				AddEmptyOption()
			EndIf
			
			AddTextOptionST("FameView_CleanPCFame_TX", "$SLSF_MCM_FW_CLEANPCFAME_TX", "")
			
			;List PC
			AddHeaderOption("$SLSF_MCM_FW_PC")
			a = Config.FameListPc.Length
			Values = New Int[3]
			While a > 0
				a -= 1
				Values[0] = SLSFUtility.FixRangeValue(StorageUtil.IntListGet(None, "SLSF.LocationsFame."+Config.FameListPc[a], ActualLocationShowed))
				Values[1] = SLSFUtility.FixRangeValue(StorageUtil.IntListGet(None, "SLSF.LocationsFame."+Config.FameListPc[a]+".LevelMin", ActualLocationShowed))
				Values[2] = SLSFUtility.FixRangeValue(StorageUtil.IntListGet(None, "SLSF.LocationsFame."+Config.FameListPc[a]+".LevelMax", ActualLocationShowed))
				AddTextOptionST("FameView_ShowFamePC"+a+"_TX", Config.FameListPc[a], Values[0]+" ["+Values[1]+"-"+Values[2]+"]")
			EndWhile
		Else
			AddTextOptionST("FameView_StartTrackThis_TX", "$SLSF_MCM_FW_STARTTRACK_TX", "")
		EndIf
	EndIf
EndEvent

;States
	;Toggles
State BaseSetting_ChildRemover_TG
	Event OnSelectST()
		SetToggleOptionValueST(!Config.ChildRemover)
		Config.ChildRemover = !Config.ChildRemover
	EndEvent

	Event OnDefaultST()
		SetToggleOptionValueST(True)
		Config.ChildRemover = True
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_BS_CHILDRE_DESC")
	EndEvent	
EndState

State BaseSetting_ShameEffect_TG
	Event OnSelectST()
		SetToggleOptionValueST(!Config.ShameEffectEnabled)
		Config.ShameEffectEnabled = !Config.ShameEffectEnabled
	EndEvent

	Event OnDefaultST()
		SetToggleOptionValueST(False)
		Config.ShameEffectEnabled = False
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_BS_SHAMEEF_DESC")
	EndEvent	
EndState

State BaseSetting_AllowAnonymous_TG
	Event OnSelectST()
		Bool AllowAn = (Config.AllowAnonymous.GetValue() as Bool)
		SetToggleOptionValueST(!AllowAn)
		If AllowAn
			Config.AllowAnonymous.SetValue(0.0)
		Else
			Config.AllowAnonymous.SetValue(1.0)
		EndIf
	EndEvent
	
	Event OnDefaultST()
		SetToggleOptionValueST(True)
		Config.AllowAnonymous.SetValue(True as Float)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_BS_ALLOWANONYMOUS_DESC")
	EndEvent	
EndState

State BaseSetting_DisableNotificationinc_TG
	Event OnSelectST()
		SetToggleOptionValueST(!Config.NotificationIncrease)
		Config.NotificationIncrease = !Config.NotificationIncrease
	EndEvent

	Event OnDefaultST()
		SetToggleOptionValueST(True)
		Config.NotificationIncrease = True
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_BS_DISNOTINC_DESC")
	EndEvent	
EndState

;State BaseSetting_ChangeRolWtLoc_TG
;	Event OnSelectST()
;		SetToggleOptionValueST(!Config.NotifyChangeRoleTypeWtLoc)
;		Config.NotifyChangeRoleTypeWtLoc = !Config.NotifyChangeRoleTypeWtLoc
;	EndEvent
;
;	Event OnDefaultST()
;		SetToggleOptionValueST(False)
;		Config.NotifyChangeRoleTypeWtLoc = False
;	EndEvent
;
;	Event OnHighlightST()
;		SetInfoText("$SLSF_MCM_BS_CHANGROLWTLOC_DESC")
;	EndEvent	
;EndState

State BaseSetting_Tutorial_TG
	Event OnSelectST()
		SetToggleOptionValueST(!Config.DisableTutorial)
		Config.DisableTutorial = !Config.DisableTutorial
	EndEvent

	Event OnDefaultST()
		SetToggleOptionValueST(True)
		Config.DisableTutorial = True
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_BS_TUTORIA_DESC")
	EndEvent	
EndState

State BaseSetting_Tutorial_Reset_TG
	Event OnSelectST()
		SetToggleOptionValueST(True)
		Config.ResetTutorial()
	EndEvent

	Event OnDefaultST()
		SetToggleOptionValueST(False)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_BS_TUTORIARESET_DESC")
	EndEvent	
EndState

State BaseSetting_LoadedSlaveT_TG
	Event OnSelectST()
		SetToggleOptionValueST(!Config.SlaveTatsLoaded)
	EndEvent

	Event OnHighlightST()
		SetInfoText("")
	EndEvent	
EndState

State BaseSetting_LoadedHydraSlave_TG
	Event OnSelectST()
		SetToggleOptionValueST(!Config.HydraSlavegirlsLoaded)
	EndEvent

	Event OnHighlightST()
		SetInfoText("")
	EndEvent	
EndState

State BaseSetting_LoadedDeviousD_TG
	Event OnSelectST()
		SetToggleOptionValueST(!Config.DeviousDevicesIntegrationLoaded)
	EndEvent

	Event OnHighlightST()
		SetInfoText("")
	EndEvent	
EndState

State BaseSetting_LoadedBathingInSkyrim_TG
	Event OnSelectST()
		SetToggleOptionValueST(!Config.BathingInSkyrimLoaded)
	EndEvent

	Event OnHighlightST()
		SetInfoText("")
	EndEvent	
EndState

State BaseSetting_LoadedEstrusChaurus_TG
	Event OnSelectST()
		SetToggleOptionValueST(!Config.EstrusChaurusLoaded)
	EndEvent

	Event OnHighlightST()
		SetInfoText("")
	EndEvent	
EndState

State BaseSetting_LoadedSGO_TG
	Event OnSelectST()
		SetToggleOptionValueST(!Config.SoulGemOvenLoaded)
	EndEvent

	Event OnHighlightST()
		SetInfoText("")
	EndEvent	
EndState

State BaseSetting_CumAlwaysHiddable_TG
	Event OnSelectST()
		SetToggleOptionValueST(!Config.CumAlwaysHiddable)
		Config.CumAlwaysHiddable = !Config.CumAlwaysHiddable
	EndEvent

	Event OnDefaultST()
		SetToggleOptionValueST(False)
		Config.CumAlwaysHiddable = False
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_BS_CUMALWAYSHIDDABLE_DESC")
	EndEvent	
EndState

State BaseSetting_SLAExtendList_TG
	Event OnSelectST()
		SetToggleOptionValueST(!Config.SlaExtensionList)
		Config.SlaExtensionList = !Config.SlaExtensionList
	EndEvent

	Event OnDefaultST()
		SetToggleOptionValueST(False)
		Config.SlaExtensionList = False
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_BS_EXTENDLIST_DESC")
	EndEvent	
EndState

State BaseSetting_STSpecificGain_TG
	Event OnSelectST()
		SetToggleOptionValueST(!Config.AllowIncreaseSpecificWithTats)
		Config.AllowIncreaseSpecificWithTats = !Config.AllowIncreaseSpecificWithTats
	EndEvent

	Event OnDefaultST()
		SetToggleOptionValueST(False)
		Config.AllowIncreaseSpecificWithTats = False
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_BS_STSPECGAIN_DESC")
	EndEvent	
EndState

;State ConfigNpc_DefineSexuality_TG
;	Event OnSelectST()
;		SetToggleOptionValueST(!Config.DefineSexuality)
;		Config.DefineSexuality = !Config.DefineSexuality
;	EndEvent
;
;	Event OnDefaultST()
;		SetToggleOptionValueST(True)
;		Config.DefineSexuality = True
;	EndEvent
;
;	Event OnHighlightST()
;		SetInfoText("")
;	EndEvent	
;EndState

State ConfigNpc_BaseEquip_TG
	Event OnSelectST()
		SetToggleOptionValueST(!Config.BaseEquipNPC)
		Config.BaseEquipNPC = !Config.BaseEquipNPC
	EndEvent

	Event OnDefaultST()
		SetToggleOptionValueST(True)
		Config.BaseEquipNPC = True
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_BASEEQUIP_DESC")
	EndEvent	
EndState

State ConfigNpc_DefineExhib_TG
	Event OnSelectST()
		SetToggleOptionValueST(!Config.DefineExhib)
		Config.DefineExhib = !Config.DefineExhib
	EndEvent

	Event OnDefaultST()
		SetToggleOptionValueST(True)
		Config.DefineExhib = True
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_DEFINEEXHIB_DESC")
	EndEvent	
EndState

State FameConfig_NeedLosGainFame_TG
	Event OnSelectST()
		SetToggleOptionValueST(!Config.NeedLosForFameGainRequest)
		Config.NeedLosForFameGainRequest = !Config.NeedLosForFameGainRequest
	EndEvent

	Event OnDefaultST()
		SetToggleOptionValueST(True)
		Config.NeedLosForFameGainRequest = True
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_NEEDLOSGAINFAME_DESC")
	EndEvent	
EndState

State FameConfig_RandomizeTempFameAtStart_TG
	Event OnSelectST()
		SetToggleOptionValueST(!Config.RandomizeTemporaryFameAtStart)
		Config.RandomizeTemporaryFameAtStart = !Config.RandomizeTemporaryFameAtStart
	EndEvent

	Event OnDefaultST()
		SetToggleOptionValueST(True)
		Config.RandomizeTemporaryFameAtStart = True
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_RANDTEMPFAS_DESC")
	EndEvent	
EndState

State FameView_IsTemporaryLoc_TG
	;Event OnSelectST()
	;	SetToggleOptionValueST(!Config.TemporaryLocation[ActualLocationShowed])
	;	Config.TemporaryLocation[ActualLocationShowed] = !Config.TemporaryLocation[ActualLocationShowed]
	;EndEvent
    ;
	;Event OnDefaultST()
	;	SetToggleOptionValueST(True)
	;	Config.TemporaryLocation[ActualLocationShowed] = True
	;EndEvent
    ;
	;Event OnHighlightST()
	;	SetInfoText("")
	;EndEvent	
EndState

State FameView_CannotDecay_TG
	Event OnSelectST()
		Bool Status = StorageUtil.IntListGet(None, "SLSF.LocationsFame.CannotDecay", ActualLocationShowed)as Bool
		SetToggleOptionValueST(!Status)
		If Status
			StorageUtil.IntListSet(None, "SLSF.LocationsFame.CannotDecay", ActualLocationShowed, 0)
		Else
			StorageUtil.IntListSet(None, "SLSF.LocationsFame.CannotDecay", ActualLocationShowed, 1)
		EndIf
	EndEvent
    
	Event OnDefaultST()
		SetToggleOptionValueST(False)
		StorageUtil.IntListSet(None, "SLSF.LocationsFame.CannotDecay", ActualLocationShowed, 0)
	EndEvent
    
	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FW_CATDECAY_DESC")
	EndEvent	
EndState

	;Sliders
State BaseSetting_CommentProb_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.AllowCommentProbability * 100.0)
		SetSliderDialogDefaultValue(70.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.AllowCommentProbability = value / 100.0
		Config.CommentProbabilityRepository = Config.AllowCommentProbability
		SetSliderOptionValueST(value, "{0}%")
	EndEvent

	Event OnDefaultST()
		Config.AllowCommentProbability = 0.7
		Config.CommentProbabilityRepository = 0.7
		;SetSliderDialogStartValue(70.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_BS_COMMPROB_DESC")
	EndEvent
EndState

State BaseSetting_UpdateInterval_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.BaseUpdateInterval)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(1.0, 5.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.BaseUpdateInterval = value
		SetSliderOptionValueST(Config.BaseUpdateInterval, "{0} Sec")
	EndEvent

	Event OnDefaultST()
		Config.BaseUpdateInterval = 2.0
		;SetSliderDialogStartValue(2.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_BS_UPDATEINT_DESC")
	EndEvent
EndState

State BaseSetting_SGOLevelProgNeeded_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.SGOProgressionGemLevelNeeded)
		SetSliderDialogDefaultValue(20.0)
		SetSliderDialogRange(10.0, 70.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.SGOProgressionGemLevelNeeded = value as Int
		SetSliderOptionValueST(Config.SGOProgressionGemLevelNeeded, "{0}")
	EndEvent

	Event OnDefaultST()
		Config.SGOProgressionGemLevelNeeded = 20
		;SetSliderDialogStartValue(2.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_BS_SGOLVLPROGNEED_DESC")
	EndEvent
EndState

;State BaseSetting_DDVibrationIncFame_SL
;	Event OnSliderOpenST()
;		SetSliderDialogStartValue(Config.DDVibAnimIncreaseFame)
;		SetSliderDialogDefaultValue(50.0)
;		SetSliderDialogRange(0.0, 100.0)
;		SetSliderDialogInterval(1.0)
;	EndEvent
;
;	Event OnSliderAcceptST(Float value)
;		Config.DDVibAnimIncreaseFame = value as Int
;		SetSliderOptionValueST(Config.DDVibAnimIncreaseFame)
;	EndEvent
;
;	Event OnDefaultST()
;		Config.DDVibAnimIncreaseFame = 50.0 as Int
;		;SetSliderDialogStartValue(1.0)
;	EndEvent
;
;	Event OnHighlightST()
;		SetInfoText("$SLSF_MCM_BS_DDINTEGFAME_DESC")
;	EndEvent
;EndState

State ConfigNpc_ProbGenDominant_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbMaster)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbMaster = value as Int
		SetSliderOptionValueST( Config.ProbMaster)
	EndEvent

	Event OnDefaultST()
		Config.ProbMaster = 1.0 as Int
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_GENERALDOM_DESC")
	EndEvent
EndState

State ConfigNpc_ProbGenDom_Kind_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbMasterKind)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbMasterKind = value as Int
		SetSliderOptionValueST( Config.ProbMasterKind)
	EndEvent

	Event OnDefaultST()
		Config.ProbMasterKind = 1.0 as Int
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_DOMKIND_DESC")
	EndEvent
EndState

State ConfigNpc_ProbGenDom_Norm_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbMasterNorm)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbMasterNorm = value as Int
		SetSliderOptionValueST( Config.ProbMasterNorm)
	EndEvent

	Event OnDefaultST()
		Config.ProbMasterNorm = 1.0 as Int
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_DOMNORM_DESC")
	EndEvent
EndState

State ConfigNpc_ProbGenDom_Bast_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbMasterBast)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbMasterBast = value as Int
		SetSliderOptionValueST( Config.ProbMasterBast)
	EndEvent

	Event OnDefaultST()
		Config.ProbMasterBast = 1.0 as Int
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_DOMBAST_DESC")
	EndEvent
EndState

State ConfigNpc_ProbGenNeutral_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbFree)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbFree = value as Int
		SetSliderOptionValueST( Config.ProbFree)
	EndEvent

	Event OnDefaultST()
		Config.ProbFree = 1.0 as Int
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_GENERALNEU_DESC")
	EndEvent
EndState

State ConfigNpc_ProbGenNeu_Kind_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbFreeKind)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbFreeKind = value as Int
		SetSliderOptionValueST( Config.ProbFreeKind)
	EndEvent

	Event OnDefaultST()
		Config.ProbFreeKind = 1.0 as Int
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_NEUKIND_DESC")
	EndEvent
EndState

State ConfigNpc_ProbGenNeu_Norm_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbFreeNorm)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbFreeNorm = value as Int
		SetSliderOptionValueST( Config.ProbFreeNorm)
	EndEvent

	Event OnDefaultST()
		Config.ProbFreeNorm = 1.0 as Int
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_NEUNORM_DESC")
	EndEvent
EndState

State ConfigNpc_ProbGenNeu_Bast_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbFreeBast)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbFreeBast = value as Int
		SetSliderOptionValueST( Config.ProbFreeBast)
	EndEvent

	Event OnDefaultST()
		Config.ProbFreeBast = 1.0 as Int
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_NEUBAST_DESC")
	EndEvent
EndState

State ConfigNpc_ProbGenSubmissive_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbSlave)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbSlave = value as Int
		SetSliderOptionValueST(Config.ProbSlave)
	EndEvent

	Event OnDefaultST()
		Config.ProbSlave = 1.0 as Int
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_GENERALSUB_DESC")
	EndEvent
EndState

State ConfigNpc_ProbGenSub_Kind_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbSlaveKind)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbSlaveKind = value as Int
		SetSliderOptionValueST(Config.ProbSlaveKind)
	EndEvent

	Event OnDefaultST()
		Config.ProbSlaveKind = 1.0 as Int
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_SUBKIND_DESC")
	EndEvent
EndState

State ConfigNpc_ProbGenSub_Norm_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbSlaveNorm)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbSlaveNorm = value as Int
		SetSliderOptionValueST(Config.ProbSlaveNorm)
	EndEvent

	Event OnDefaultST()
		Config.ProbSlaveNorm = 1.0 as Int
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_SUBNORM_DESC")
	EndEvent
EndState

State ConfigNpc_ProbGenSub_Bast_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbSlaveBast)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbSlaveBast = value as Int
		SetSliderOptionValueST( Config.ProbSlaveBast)
	EndEvent

	Event OnDefaultST()
		Config.ProbSlaveBast = 1.0 as Int
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_SUBBAST_DESC")
	EndEvent
EndState

State ConfigNpc_BaseEquip_EquipBody_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbBaseEquipBodyNPC * 100.0)
		SetSliderDialogDefaultValue(70.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbBaseEquipBodyNPC = value / 100.0
		SetSliderOptionValueST(value, "{0}%")
	EndEvent

	Event OnDefaultST()
		Config.ProbBaseEquipBodyNPC = 0.7
		;SetSliderDialogStartValue(70.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_BASEEQUIP_B_DESC")
	EndEvent
EndState

State ConfigNpc_BaseEquip_EquipFeet_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbBaseEquipFeetNPC * 100.0)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbBaseEquipFeetNPC = value / 100.0
		SetSliderOptionValueST(value, "{0}%")
	EndEvent

	Event OnDefaultST()
		Config.ProbBaseEquipFeetNPC = 0.5
		;SetSliderDialogStartValue(50.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_BASEEQUIP_F_DESC")
	EndEvent
EndState

State ConfigNpc_BaseEquip_EquipMisc_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbBaseEquipMiscNPC * 100.0)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbBaseEquipMiscNPC = value / 100.0
		SetSliderOptionValueST(value, "{0}%")
	EndEvent

	Event OnDefaultST()
		Config.ProbBaseEquipMiscNPC = 0.5
		;SetSliderDialogStartValue(50.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_BASEEQUIP_M_DESC")
	EndEvent
EndState

State ConfigNpc_Weight_SKind_Poor_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.EquipWeightKindPoor)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.EquipWeightKindPoor = value as Int
		SetSliderOptionValueST(Config.EquipWeightKindPoor)
	EndEvent

	Event OnDefaultST()
		Config.EquipWeightKindPoor = 1
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_SUBKIND_EQUIP_POOR_DESC")
	EndEvent
EndState

State ConfigNpc_Weight_SKind_Med_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.EquipWeightKindMed)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.EquipWeightKindMed = value as Int
		SetSliderOptionValueST(Config.EquipWeightKindMed)
	EndEvent

	Event OnDefaultST()
		Config.EquipWeightKindMed = 1
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_SUBKIND_EQUIP_MED_DESC")
	EndEvent
EndState

State ConfigNpc_Weight_SKind_Rich_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.EquipWeightKindRich)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.EquipWeightKindRich = value as Int
		SetSliderOptionValueST(Config.EquipWeightKindRich)
	EndEvent

	Event OnDefaultST()
		Config.EquipWeightKindRich = 1
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_SUBKIND_EQUIP_RICH_DESC")
	EndEvent
EndState

State ConfigNpc_Weight_SNorm_Poor_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.EquipWeightNormPoor)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.EquipWeightNormPoor = value as Int
		SetSliderOptionValueST(Config.EquipWeightNormPoor)
	EndEvent

	Event OnDefaultST()
		Config.EquipWeightNormPoor = 1
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_SUBNORM_EQUIP_POOR_DESC")
	EndEvent
EndState

State ConfigNpc_Weight_SNorm_Med_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.EquipWeightNormMed)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.EquipWeightNormMed = value as Int
		SetSliderOptionValueST(Config.EquipWeightNormMed)
	EndEvent

	Event OnDefaultST()
		Config.EquipWeightNormMed = 1
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_SUBNORM_EQUIP_MED_DESC")
	EndEvent
EndState

State ConfigNpc_Weight_SNorm_Rich_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.EquipWeightNormRich)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.EquipWeightNormRich = value as Int
		SetSliderOptionValueST(Config.EquipWeightNormRich)
	EndEvent

	Event OnDefaultST()
		Config.EquipWeightNormRich = 1
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_SUBNORM_EQUIP_RICH_DESC")
	EndEvent
EndState

State ConfigNpc_Weight_SBast_Poor_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.EquipWeightBastPoor)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.EquipWeightBastPoor = value as Int
		SetSliderOptionValueST(Config.EquipWeightBastPoor)
	EndEvent

	Event OnDefaultST()
		Config.EquipWeightBastPoor = 1
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_SUBBAST_EQUIP_POOR_DESC")
	EndEvent
EndState

State ConfigNpc_Weight_SBast_Med_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.EquipWeightBastMed)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.EquipWeightBastMed = value as Int
		SetSliderOptionValueST(Config.EquipWeightBastMed)
	EndEvent

	Event OnDefaultST()
		Config.EquipWeightBastMed = 1
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_SUBBAST_EQUIP_MED_DESC")
	EndEvent
EndState

State ConfigNpc_Weight_SBast_Rich_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.EquipWeightBastRich)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.EquipWeightBastRich = value as Int
		SetSliderOptionValueST(Config.EquipWeightBastRich)
	EndEvent

	Event OnDefaultST()
		Config.EquipWeightBastRich = 1
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_SUBBAST_EQUIP_RICH_DESC")
	EndEvent
EndState

State ConfigNpc_DefineExhibitionist_Prob_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbExhibitionist * 100.0)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbExhibitionist = value / 100.0
		SetSliderOptionValueST(value, "{0}%")
	EndEvent

	Event OnDefaultST()
		Config.ProbExhibitionist = 0.3
		;SetSliderDialogStartValue(30.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_CN_DEFINEEXHIB_PDESC")
	EndEvent
EndState

State FameConfig_GainMultiplier_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.LocationFameModInc)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.1, 10.0)
		SetSliderDialogInterval(0.1)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.LocationFameModInc = value
		SetSliderOptionValueST(Config.LocationFameModInc, "{1}")
	EndEvent

	Event OnDefaultST()
		Config.LocationFameModInc = 1.0
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_FAMEGAIN_DESC")
	EndEvent
EndState

State FameConfig_DistanceWithoutLos_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.DistanceWithoutLosNeeded)
		SetSliderDialogDefaultValue(350.0)
		SetSliderDialogRange(0.0, 1024)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.DistanceWithoutLosNeeded = value
		SetSliderOptionValueST(Config.DistanceWithoutLosNeeded, "{0} Unit")
	EndEvent

	Event OnDefaultST()
		Config.DistanceWithoutLosNeeded = 350.0
		;SetSliderDialogStartValue(350.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_DISTANCEWITHOUTLOSNEEDED_DESC")
	EndEvent
EndState

State FameConfig_VariationFameNpc_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.VariationFameNpcRange * 100.0)
		SetSliderDialogDefaultValue(20.0)
		SetSliderDialogRange(0.0, 40.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.VariationFameNpcRange = value / 100.0
		SetSliderOptionValueST(value, "{0}%")
	EndEvent

	Event OnDefaultST()
		Config.VariationFameNpcRange = 0.2
		;SetSliderDialogStartValue(20.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_VARIATIONFNPCRANGE_DESC")
	EndEvent
EndState

;State FameConfig_STSpecificGainMax_SL
;	Event OnSliderOpenST()
;		SetSliderDialogStartValue(Config.MaxGainFromSlaveTatsSpecific)
;		SetSliderDialogDefaultValue(50.0)
;		SetSliderDialogRange(10.0, 100.0)
;		SetSliderDialogInterval(1.0)
;	EndEvent
;
;	Event OnSliderAcceptST(Float value)
;		Config.MaxGainFromSlaveTatsSpecific = value as Int
;		SetSliderOptionValueST(value, "{0}")
;	EndEvent
;
;	Event OnDefaultST()
;		Config.MaxGainFromSlaveTatsSpecific = 10
;	EndEvent
;
;	Event OnHighlightST()
;		SetInfoText("$SLSF_MCM_FC_STSPECGAINMAX_DESC")
;	EndEvent
;EndState

State FameConfig_DDVibGainMax_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.MaxGainFromDDVibrationEvent)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(10.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.MaxGainFromDDVibrationEvent = value as Int
		SetSliderOptionValueST(value, "{0}")
	EndEvent

	Event OnDefaultST()
		Config.MaxGainFromDDVibrationEvent = 10
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_DDVIBGAINMAX_DESC")
	EndEvent
EndState

State FameConfig_LoseMultiplier_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.LocationFameModDec)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.1, 10.0)
		SetSliderDialogInterval(0.1)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.LocationFameModDec = value
		SetSliderOptionValueST(Config.LocationFameModDec, "{1}")
	EndEvent

	Event OnDefaultST()
		Config.LocationFameModDec = 1.0
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_FAMELOSE_DESC")
	EndEvent
EndState

State FameConfig_LoseDayDelay_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.FameDayDelayBeforeDecrease)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 30.0)
		SetSliderDialogInterval(0.5)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.FameDayDelayBeforeDecrease = value
		SetSliderOptionValueST(Config.FameDayDelayBeforeDecrease, "{1}")
	EndEvent

	Event OnDefaultST()
		Config.FameDayDelayBeforeDecrease = 1
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_FAMEDAYDELAYDECEREASE_DESC")
	EndEvent
EndState

State FameConfig_AmountGamePcDecadence_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.AmountFamePCLocationDecadence)
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0.0, 30.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.AmountFamePCLocationDecadence = value as Int
		SetSliderOptionValueST(Config.AmountFamePCLocationDecadence, "-{0}")
	EndEvent

	Event OnDefaultST()
		Config.AmountFamePCLocationDecadence = -5
		;SetSliderDialogStartValue(-5.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_AMOUNTFAMEPCDECADENCE_DESC")
	EndEvent
EndState

State FameConfig_ProbFameIncLov_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.FameIncreaseByLover * 100.0)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.FameIncreaseByLover = value / 100.0
		SetSliderOptionValueST(value, "{0}%")
	EndEvent

	Event OnDefaultST()
		Config.FameIncreaseByLover = 0.1
		;SetSliderDialogStartValue(10.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_PROBFAMEINCLOV_DESC")
	EndEvent
EndState

State FameConfig_ProbFameIncFri_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.FameIncreaseByFriend * 100.0)
		SetSliderDialogDefaultValue(40.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.FameIncreaseByFriend = value / 100.0
		SetSliderOptionValueST(value, "{0}%")
	EndEvent

	Event OnDefaultST()
		Config.FameIncreaseByFriend = 0.4
		;SetSliderDialogStartValue(40.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_PROBFAMEINCFRI_DESC")
	EndEvent
EndState

State FameConfig_ProbFameIncNeu_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.FameIncreaseByNeutral * 100.0)
		SetSliderDialogDefaultValue(70.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.FameIncreaseByNeutral = value / 100.0
		SetSliderOptionValueST(value, "{0}%")
	EndEvent

	Event OnDefaultST()
		Config.FameIncreaseByNeutral = 0.7
		;SetSliderDialogStartValue(70.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_PROBFAMEINCNEU_DESC")
	EndEvent
EndState

State FameConfig_ProbFameIncEne_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.FameIncreaseByEnemy * 100.0)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.FameIncreaseByEnemy = value / 100.0
		SetSliderOptionValueST(value, "{0}%")
	EndEvent

	Event OnDefaultST()
		Config.FameIncreaseByEnemy = 1.0
		;SetSliderDialogStartValue(100.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_PROBFAMEINCENE_DESC")
	EndEvent
EndState

State FameConfig_ContageMagnitudo_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ContageMagnitudo * 100.0)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(10.0, 40.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ContageMagnitudo = value / 100.0
		SetSliderOptionValueST(value, "{0}%")
	EndEvent

	Event OnDefaultST()
		Config.ContageMagnitudo = 0.3
		;SetSliderDialogStartValue(30.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_CONTAGEMAGNITUDO_DESC")
	EndEvent
EndState

State FameConfig_ModContageSameLoc_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ModIfINSameLocation * 100.0)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-100.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ModIfINSameLocation = value / 100.0
		SetSliderOptionValueST(value, "{0}%")
	EndEvent

	Event OnDefaultST()
		Config.ModIfINSameLocation = 0.0
		;SetSliderDialogStartValue(0.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_MODCONTAGESAMELOC_DESC")
	EndEvent
EndState

State FameConfig_ModContageNotSameLoc_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ModIfNOTSameLocation * 100.0)
		SetSliderDialogDefaultValue(-30.0)
		SetSliderDialogRange(-100.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ModIfNOTSameLocation = value / 100.0
		SetSliderOptionValueST(value, "{0}%")
	EndEvent

	Event OnDefaultST()
		Config.ModIfNOTSameLocation = -0.3
		;SetSliderDialogStartValue(-30.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_MODCONTAGENOTSAMELOC_DESC")
	EndEvent
EndState

State FameConfig_FameMinAllowContage_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.FameMinToAllowContage)
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(10.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.FameMinToAllowContage = value as Int
		SetSliderOptionValueST(Config.FameMinToAllowContage)
	EndEvent

	Event OnDefaultST()
		Config.FameMinToAllowContage = 15 as Int
		;SetSliderDialogStartValue(15.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_FAMEMINALLOWCONTAGE_DESC")
	EndEvent
EndState

State FameConfig_DaysDelayBefContageNew_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.DaysDelayBeforeNewContage)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 30.0)
		SetSliderDialogInterval(0.5)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.DaysDelayBeforeNewContage = value
		SetSliderOptionValueST(Config.DaysDelayBeforeNewContage, "{1}")
	EndEvent

	Event OnDefaultST()
		Config.DaysDelayBeforeNewContage = 1.0
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_DAYDELBEFCONTAG_DESC")
	EndEvent
EndState

State FameConfig_BaseProbContage_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.BaseProbabilityContage * 100.0)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(-50.0, 50.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.BaseProbabilityContage = value / 100.0
		SetSliderOptionValueST(value, "{0}%")
	EndEvent

	Event OnDefaultST()
		Config.BaseProbabilityContage = 0.1
		;SetSliderDialogStartValue(10.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_BASEPRCONTAG_DESC")
	EndEvent
EndState

State FameConfig_ModMorbAtCont_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ModMorbosityAtContage * 100.0)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 50.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ModMorbosityAtContage = value / 100.0
		SetSliderOptionValueST(value, "{0}%")
	EndEvent

	Event OnDefaultST()
		Config.ModMorbosityAtContage = 0.1
		;SetSliderDialogStartValue(10.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_MODMORBATCONTAGE_DESC")
	EndEvent
EndState

State FameConfig_TemporaryFameExp_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.TemporaryFameLocationExpiration)
		SetSliderDialogDefaultValue(7.0)
		SetSliderDialogRange(1.0, 30.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.TemporaryFameLocationExpiration = value as Int
		SetSliderOptionValueST( Config.TemporaryFameLocationExpiration)
	EndEvent

	Event OnDefaultST()
		Config.TemporaryFameLocationExpiration = 7.0 as Int
		;SetSliderDialogStartValue(7.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_TEMPFAMEEXP_DESC")
	EndEvent
EndState

State FameConfig_ProbRndFillTempLib_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbRandomFillTempLib)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbRandomFillTempLib = value as Int
		SetSliderOptionValueST( Config.ProbRandomFillTempLib)
	EndEvent

	Event OnDefaultST()
		Config.ProbRandomFillTempLib = 1.0 as Int
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_PROBTEMPLIB_DESC")
	EndEvent
EndState

State FameConfig_ProbRndFillTempPro_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbRandomFillTempPro)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbRandomFillTempPro = value as Int
		SetSliderOptionValueST( Config.ProbRandomFillTempPro)
	EndEvent

	Event OnDefaultST()
		Config.ProbRandomFillTempPro = 1.0 as Int
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_PROBTEMPPRO_DESC")
	EndEvent
EndState

State FameConfig_ProbRndFillTempRap_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbRandomFillTempRap)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbRandomFillTempRap = value as Int
		SetSliderOptionValueST( Config.ProbRandomFillTempRap)
	EndEvent

	Event OnDefaultST()
		Config.ProbRandomFillTempRap = 1.0 as Int
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_PROBTEMPRAP_DESC")
	EndEvent
EndState

State FameConfig_ProbRndFillTempSla_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbRandomFillTempSla)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbRandomFillTempSla = value as Int
		SetSliderOptionValueST( Config.ProbRandomFillTempSla)
	EndEvent

	Event OnDefaultST()
		Config.ProbRandomFillTempSla = 1.0 as Int
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_PROBTEMPSLA_DESC")
	EndEvent
EndState

State FameConfig_ProbRndFillTempZoo_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbRandomFillTempZoo)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbRandomFillTempZoo = value as Int
		SetSliderOptionValueST( Config.ProbRandomFillTempZoo)
	EndEvent

	Event OnDefaultST()
		Config.ProbRandomFillTempZoo = 1.0 as Int
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_PROBTEMPZOO_DESC")
	EndEvent
EndState

State FameConfig_ProbRndFillTempMig_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbRandomFillTempMig)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbRandomFillTempMig = value as Int
		SetSliderOptionValueST( Config.ProbRandomFillTempMig)
	EndEvent

	Event OnDefaultST()
		Config.ProbRandomFillTempMig = 1.0 as Int
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_PROBTEMPMIG_DESC")
	EndEvent
EndState

State FameConfig_ProbRndFillTempMia_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.ProbRandomFillTempMia)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.ProbRandomFillTempMia = value as Int
		SetSliderOptionValueST( Config.ProbRandomFillTempMia)
	EndEvent

	Event OnDefaultST()
		Config.ProbRandomFillTempMia = 1.0 as Int
		;SetSliderDialogStartValue(1.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FC_PROBTEMPMIA_DESC")
	EndEvent
EndState

State FameView_LocMorbosity_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.LocationFameMorbosity[ActualLocationShowed] * 100.0)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.LocationFameMorbosity[ActualLocationShowed] = value / 100.0
		SetSliderOptionValueST(value, "{0}%")
	EndEvent

	Event OnDefaultST()
		Config.LocationFameMorbosity[ActualLocationShowed] = 0.5
		;SetSliderDialogStartValue(50.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FW_LOCMORBOS_DESC")
	EndEvent
EndState

State FameView_LocMorbosityReq_SL
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Config.LocationFameRequiredMorbosity[ActualLocationShowed] * 100.0)
		SetSliderDialogDefaultValue(20.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float value)
		Config.LocationFameRequiredMorbosity[ActualLocationShowed] = value / 100.0
		SetSliderOptionValueST(value, "{0}%")
	EndEvent

	Event OnDefaultST()
		Config.LocationFameRequiredMorbosity[ActualLocationShowed] = 0.2
		;SetSliderDialogStartValue(20.0)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FW_LOCMORBOSREQ_DESC")
	EndEvent
EndState

	;Text
State FameView_RandomizerNPCFame_TX
	Event OnSelectST()
		FameMain.RandomizerNpcFame(ActualLocationShowed)
		ForcePageReset()
		Debug.MessageBox("Done")
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FW_RANDOMIZNPCF_DESC")
	EndEvent
EndState

State FameView_IsTheActualLoaded_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FW_CURRENTLOC_DESC")
	EndEvent
EndState

State FameView_GoToActualLoaded_TX
	Event OnSelectST()
		ActualLocationShowed = Config.LocationOfValueLoadedNum
		ForcePageReset()
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FW_GOTOCURRENTLOC_DESC")
	EndEvent
EndState

State FameView_CleanNPCFame_TX
	Event OnSelectST()
		FameMain.ClearFameByNum(True, False, ActualLocationShowed)
		ForcePageReset()
		Debug.MessageBox("Done")
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FW_CLEANNPCFAME_DESC")
	EndEvent
EndState

State FameView_ResetLocationFame_TX
	Event OnSelectST()
		FameMain.ResetFameByNum(ActualLocationShowed)
		ForcePageReset()
		Debug.MessageBox("Done")
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FW_RESETLOCAT_DESC")
	EndEvent
EndState

State FameView_CleanPCFame_TX
	Event OnSelectST()
		FameMain.ClearFameByNum(False, True, ActualLocationShowed)
		ForcePageReset()
		Debug.MessageBox("Done")
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FW_CLEANPCFAME_DESC")
	EndEvent
EndState

State FameView_StartTrackThis_TX
	Event OnSelectST()
		Int a = FameMain.RegisterTemporaryLocation(Game.GetPlayer().GetCurrentLocation(), True)
		If a > 23
			ActualLocationShowed = a
			ForcePageReset()
			Debug.MessageBox("Done")
		Else
			Debug.MessageBox("Failed [Code:"+a+"]")
		EndIf
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FW_STARTTRACK_DESC")
	EndEvent
EndState

State FameView_ShowFameNPC0_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMENPC0_DESC")
	EndEvent
EndState

State FameView_ShowFameNPC1_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMENPC1_DESC")
	EndEvent
EndState

State FameView_ShowFameNPC2_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMENPC2_DESC")
	EndEvent
EndState

State FameView_ShowFameNPC3_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMENPC3_DESC")
	EndEvent
EndState

State FameView_ShowFameNPC4_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMENPC4_DESC")
	EndEvent
EndState

State FameView_ShowFameNPC5_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMENPC5_DESC")
	EndEvent
EndState

State FameView_ShowFameNPC6_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMENPC6_DESC")
	EndEvent
EndState

State FameView_ShowFamePC0_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMEPC0_DESC")
	EndEvent
EndState

State FameView_ShowFamePC1_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMEPC1_DESC")
	EndEvent
EndState

State FameView_ShowFamePC2_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMEPC2_DESC")
	EndEvent
EndState

State FameView_ShowFamePC3_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMEPC3_DESC")
	EndEvent
EndState

State FameView_ShowFamePC4_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMEPC4_DESC")
	EndEvent
EndState

State FameView_ShowFamePC5_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMEPC5_DESC")
	EndEvent
EndState

State FameView_ShowFamePC6_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMEPC6_DESC")
	EndEvent
EndState

State FameView_ShowFamePC7_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMEPC7_DESC")
	EndEvent
EndState

State FameView_ShowFamePC8_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMEPC8_DESC")
	EndEvent
EndState

State FameView_ShowFamePC9_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMEPC9_DESC")
	EndEvent
EndState

State FameView_ShowFamePC10_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMEPC10_DESC")
	EndEvent
EndState

State FameView_ShowFamePC11_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMEPC11_DESC")
	EndEvent
EndState

State FameView_ShowFamePC12_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMEPC12_DESC")
	EndEvent
EndState

State FameView_ShowFamePC13_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMEPC13_DESC")
	EndEvent
EndState

State FameView_ShowFamePC14_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMEPC14_DESC")
	EndEvent
EndState

State FameView_ShowFamePC15_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMEPC15_DESC")
	EndEvent
EndState

State FameView_ShowFamePC16_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMEPC16_DESC")
	EndEvent
EndState

State FameView_ShowFamePC17_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMEPC17_DESC")
	EndEvent
EndState

State FameView_ShowFamePC18_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMEPC18_DESC")
	EndEvent
EndState

State FameView_ShowFamePC19_TX
	;Event OnSelectST()
	;EndEvent
	
	Event OnHighlightST()
		SetInfoText("$FAMEVIEW_SHOWFAMEPC19_DESC")
	EndEvent
EndState

State BaseSetting_Debug_ReloadBaseLocation_TX
	Event OnSelectST()
		Config.LoadFameLocationsList()
		Config.UpdateLocationsList()
		Debug.MessageBox("Done.")
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_BS_RELOADBASELOCATION_DESC")
	EndEvent
EndState

State BaseSetting_Debug_ResetAllStandardLimits_TX
	Event OnSelectST()
		SLSFUtility.ResetLocationsLimit()
		Debug.MessageBox("Done.")
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_BS_RESETALLLOCLIM_DESC")
	EndEvent
EndState

State BaseSetting_Debug_ReInstallAllLocationElements_TX
	Event OnSelectST()
		SLSFUtility.ReInstallAllLocationElements()
		Debug.MessageBox("Done.")
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_BS_REINSTALLALLLOCELEMENTS_DESC")
	EndEvent
EndState

State BaseSetting_Debug_ResetSTSpecific_TX
	Event OnSelectST()
		Config.LoadBaseSTSpecificSlot()
		Debug.MessageBox("Done.")
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_BS_RESETSTSPEC_DESC")
	EndEvent
EndState

State SLSF_mcm_cn_h_kind_equip_TX
	;Event OnHighlightST()
	;	SetInfoText("$SLSF_MCM_CN_H_KIND_EQUIP_DESC")
	;EndEvent
EndState

State SLSF_mcm_cn_h_norm_equip_TX
	;Event OnHighlightST()
	;	SetInfoText("$SLSF_MCM_CN_H_NORM_EQUIP_DESC")
	;EndEvent
EndState

State SLSF_mcm_cn_h_bast_equip_TX
	;Event OnHighlightST()
	;	SetInfoText("$SLSF_MCM_CN_H_BAST_EQUIP_DESC")
	;EndEvent
EndState

	;Key
State BaseSetting_MenuKey_KY
	Event OnKeyMapChangeST(Int newKeyCode, String conflictControl, String conflictName)
		Config.KeyForConfigMenu = newKeyCode
		SetKeyMapOptionValueST(Config.KeyForConfigMenu)
		Monitor.MaintenanceOfRegisteredKey()
	EndEvent
	
	Event OnDefaultST()
		Config.KeyForConfigMenu = 208
		SetKeyMapOptionValueST(208)
		Monitor.MaintenanceOfRegisteredKey()
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("")
	EndEvent
EndState

	;Menu
State FameView_LocationSelector_MN
	Event OnMenuOpenST()
		SetMenuDialogStartIndex(ActualLocationShowed)
		If Config.LocationOfValueLoadedNum != -1
			SetMenuDialogDefaultIndex(Config.LocationOfValueLoadedNum)
		Else
			SetMenuDialogDefaultIndex(0)
		EndIf
        SetMenuDialogOptions(Config.FameLocationsListString)
	EndEvent

	Event OnMenuAcceptST(int a_index)
		ActualLocationShowed = a_index
		SetMenuOptionValueST(Config.FameLocationsListString[ActualLocationShowed])
		ForcePageReset()
	EndEvent

	Event OnDefaultST()
		If Config.LocationOfValueLoadedNum != -1
			ActualLocationShowed = Config.LocationOfValueLoadedNum
		Else
			ActualLocationShowed = 0
		EndIf
		ForcePageReset()
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FW_LOCSEL_DESC")
	EndEvent
EndState

State FameView_RoletypePCSelector_MN
	Event OnMenuOpenST()
		SetMenuDialogStartIndex(RoleTypeString)
		SetMenuDialogDefaultIndex(4)
        SetMenuDialogOptions(Config.RoleTypeListString)
	EndEvent

	Event OnMenuAcceptST(int a_index)
		RoleTypeString = a_index
		SLSFUtility.SetTheRoleType(SLSFUtility.PlayerRef, ConvertRoleTypeStringToReal())
		SetMenuOptionValueST(Config.RoleTypeListString[RoleTypeString])
		ForcePageReset()
	EndEvent

	Event OnDefaultST()
		RoleTypeString = 4
		SLSFUtility.SetTheRoleType(SLSFUtility.PlayerRef, 21)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$SLSF_MCM_FW_PCRTSEL_DESC")
	EndEvent
EndState