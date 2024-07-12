ScriptName iDDeConfig Extends iSUmConfigBase

Import Utility

; Quests to control/startup
Quest Property iDDeLibsQuest Auto 
Quest Property iDDeUtiQuest Auto

iDDeMain Property iDDe Auto
iDDeLibs Property iDDeLib Auto
iDDeMisc Property iDDeMis Auto
iDDeFuncs Property iDDeFunc Auto
iSUmConfig Property iSUmMCM Auto

STRING Property sInputPass Auto Hidden
STRING Property sExistPass Auto Hidden
STRING Property sConFile Auto Hidden
STRING Property sActLi Auto Hidden
STRING Property sDDeOutEqp Auto Hidden

INT[] Property iPickSuit Auto Hidden
INT[] Property iPickGag Auto Hidden
INT[] Property iPickHood Auto Hidden
INT[] Property iPickBinder Auto Hidden
INT[] Property iPickBlinder Auto Hidden
INT[] Property iPickCollar Auto Hidden
INT[] Property iPickGloves Auto Hidden
INT[] Property iPickBoots Auto Hidden
INT[] Property iPickBelt Auto Hidden
INT[] Property iPickHarn Auto Hidden
INT[] Property iPickPlugA Auto Hidden
INT[] Property iPickPlugV Auto Hidden
INT[] Property iPickPieV Auto Hidden
INT[] Property iPickPieN Auto Hidden
INT[] Property iPickCuffsA Auto Hidden
INT[] Property iPickCuffsL Auto Hidden
INT[] Property iPickBra Auto Hidden

STRING[] Property sPickSuit Auto Hidden
STRING[] Property sPickGag Auto Hidden
STRING[] Property sPickHood Auto Hidden
STRING[] Property sPickBinder Auto Hidden
STRING[] Property sPickBlinder Auto Hidden
STRING[] Property sPickCollar Auto Hidden
STRING[] Property sPickGloves Auto Hidden
STRING[] Property sPickBoots Auto Hidden
STRING[] Property sPickBelt Auto Hidden
STRING[] Property sPickHarn Auto Hidden
STRING[] Property sPickPlugA Auto Hidden
STRING[] Property sPickPlugV Auto Hidden
STRING[] Property sPickPieV Auto Hidden
STRING[] Property sPickPieN Auto Hidden
STRING[] Property sPickCuffsA Auto Hidden
STRING[] Property sPickCuffsL Auto Hidden
STRING[] Property sPickBra Auto Hidden

;Internal Variables 
Actor aLiActor = None
 
INT oidSelectActorKey
INT oidForceRestart
INT oidEqpOutfit
INT oidRemOutfit
INT oidEqpMCM
INT oidRemMCM
INT oidEqpCust
INT oidRemExisting
INT oid86Device
INT oidStripForDD
INT oidHardCoreDD
INT oidAdminHardCoreDD
INT oidRemLockDD
INT oidRemQuestDD
INT oidUtilityTask
INT oidDebInfo
INT oidDisInfo
INT oidConInfo
INT oidSelfTimer
INT oidSelfBondStart
INT oidInputPass
INT oidExistPass
INT oidKeysUnMap
INT oidConSave
INT oidConLoad
INT oidConClear
INT oidConFile
INT oidConFiPg
INT oidConFiPerPg
INT oidNoStrip
INT oidAdminOpt
INT oidExeFun
INT oidAdminFun
INT oidAllWornOpt
INT oidKeySelfBond

INT oidActFolder
INT oidActFolderRfr
INT oidActList
INT oidActListDel
INT oidActListSave
INT oidActListRfr
INT oidActJson
INT oidActLoadOpt
INT oidKeyActSel
INT oidActJsPg
INT oidActJsPerPg
INT oidActPg
INT oidActPerPg
INT oidActLiPg
INT oidActLiPerPg
INT oidActFoJs
INT oidActStr
INT oidActInf

INT oidOutPg
INT oidOutPerPg
INT oidOutJsPg
INT oidOutJsPerPg
INT oidOutRegPg
INT oidOutRegPerPg
INT oidOutDrePg
INT oidOutDrePerPg
INT oidOutLiJson
INT oidOutLiName
INT oidOutLiOpt
INT oidOutLocAdd
INT oidOutLocEdit
INT oidOutLocJsAdd
INT oidOutCusAdd
INT oidOutCusEdit
INT oidOutCusJsAdd
INT oidOutFolder
INT oidOutJson
INT oidOutFoJs

INT oidEqpOutCur
INT oidEqpOutPre
INT oidDevOptsPg

INT oidBinderEff 
INT oidAnklesEff 
INT oidArmFight
INT oidArmSneak
INT oidArmMenu
INT oidArmActive
INT oidArmTravel
INT oidArmWait
INT oidArmTalk
INT oidArmStruggle
INT oidRefreshRate
INT oidEnableBondFX

INT oidPickPlugEff
INT oidPlugRibbed 
INT oidPlugShocker 
INT oidPlugFusStag
INT oidPlugLinked
INT oidPlugLively
INT oidPlugEleStim
INT oidPlugEdgeRand
INT oidPlugEdgeOnly 
INT oidPlugPoss
INT oidPlugTrain
INT oidPlugDrainH 
INT oidPlugDrainS 
INT oidPlugDrainM 
INT oidPlugVeLively 
INT oidPlugVibCast
INT oidPlugVib
INT oidPlugVibRand
INT oidPlugVibStrg
INT oidPlugVibWeak 
INT oidPlugVibVeStrg
INT oidPlugVibVeWeak

INT oidDDeBlindFold
INT oidDDxBlindFold
INT oidDDeGag
INT oidDDxGag
INT oidDDeHood
INT oidDDxHood
INT oidDDeCollar
INT oidDDxCollar
INT oidCDxCollar
INT oidDDeBra
INT oidDDxBra
INT oidCDxBra
INT oidDDxPieN
INT oidDDxPieV
INT oidDDeCuffsA
INT oidDDxCuffsA
INT oidCDxCuffsA
INT oidDDeCuffsL
INT oidDDxCuffsL
INT oidCDxCuffsL
INT oidDDeElbowBinder 
INT oidDDxElbowBinder
INT oidDDeArmBinder 
INT oidDDxArmBinder
INT oidDDeYoke 
INT oidDDxYoke
INT oidDDeShackles 
INT oidDDxShackles
INT oidDDePetSuit 
INT oidDDxPetSuit
INT oidDDeBoxBinder 
INT oidDDxBoxBinder
INT oidDDeBoxBinderOut 
INT oidDDxBoxBinderOut
INT oidDDeBelt
INT oidDDxBelt
INT oidCDxBelt
INT oidDDeHarness 
INT oidDDxHarness
INT oidDDePlugA 
INT oidDDxPlugA 
INT oidCDxPlugA 
INT oidDDePlugV
INT oidDDxPlugV
INT oidCDxPlugV
INT oidDDxCorset 
INT oidDDeGloves
INT oidDDxGloves
INT oidDDeBoots
INT oidDDxBoots
INT oidDDeSuit
INT oidDDxSuit
INT oidDDeCatSuit
INT oidDDxCatSuit
INT oidDDeMech

INT oidOutCusHelp
INT oidSaveOutfitMCM
INT oidDeleteOutfit
INT oidRefrDDsList

INT oidPlugHelp
INT oidRegisterTags
INT oidOutClearMCM
INT oidClearSave
INT oidSaveOutfitWorn
INT oidYesPet 
INT oidBlockActArm
INT oidBlockActMit
INT oidConRfr
INT oidActSelAdd
INT oidDelSelActor
INT oidAutoStoActor 
INT oidOutCo 
INT oidOutLoCo
INT oidOutJsCo
INT oidActCo
INT oidActLiCo
INT oidActJsCo
INT oidConJsCo
INT oidFacCo
INT oidGooCo
INT oidBadCo
INT oidDisCo

INT oidMechFX
INT oidMechJump
INT oidMechDisarm
INT oidMechNoActivate 
INT oidMechNoFighting 
INT oidMechNoMenu 
INT oidMechNoFastTravel 
INT oidMechNoMove 
INT oidMechNoSneak 
INT oidMechNoSprint 
INT oidMechNoWait
INT oidMechPow
INT oidMechPowSnd 

INT _iA1L
INT _iA1i
INT _iA1L2 
INT _iA1P 
INT _iA1Ps
INT _iA1E
INT _iA2L
INT _iA2i
INT _iA2L2
INT _iA2P 
INT _iA2Ps
INT _iA2E
INT _iL1L
INT _iL1i
INT _iL1L2 
INT _iL1P 
INT _iL1Ps
INT _iL1E
INT _iL2L
INT _iL2i
INT _iL2L2 
INT _iL2P 
INT _iL2Ps
INT _iL2E
INT _iSelActPl = 0
INT iConFlag = 0
INT iKeyActSel
INT iActLoadOpt
INT iKeySelfBond
INT iActIdx
INT iActPerPg = 22
INT iOutPerPg = 22
INT iOutRegPerPg = 22
INT iOutDrePerPg = 22
INT iOutJsPerPg = 6
INT iActLiPerPg = 6
INT iActJsPerPg = 4
INT iOutLocAdd
INT iOutCusAdd
INT iDevOptsPg = 1
INT iConFiPerPg = 6

BOOL bRefrDDs = False

STRING sDDaVersion
STRING sDDiVersion
STRING sDDxVersion
STRING sZapVer
STRING sPapyVer
STRING sActLi
STRING sAdminOpt
STRING sAdminFun
STRING sAutoStoActor
STRING sOutCo = "ffffff"
STRING sOutLoCo = "ffffff"
STRING sOutJsCo = "ffffff"
STRING sActCo = "ffffff"
STRING sActLiCo = "ffffff"
STRING sActJsCo = "ffffff"
STRING sConJsCo = "ffffff"
STRING sFacCo = "ffffff"
STRING sGooCo = "ffffff"
STRING sBadCo = "ffffff"
STRING sAllWornOpt
STRING sDDeOutLoc
STRING sDDeOutLocSel
STRING sDDeOutCus
STRING sDDeOutCusSel
STRING sOutLiJson
STRING sOutLiName
STRING sOutLiOpt
STRING sActStrGet
STRING sActStr
STRING sActInf

INT[] oidDDeOutMisc
INT[] oidDDeOutReg
INT[] oidDDeOutDre
INT[] oidCDxOut
INT[] oidConFis
INT[] oidOutCuss
INT[] oidActJsons
INT[] oidActLists
INT[] oidOutJsons
INT[] oidPickSuit
INT[] oidPickGag
INT[] oidPickHood
INT[] oidPickBinder
INT[] oidPickBlinder
INT[] oidPickCollar
INT[] oidPickGloves
INT[] oidPickBoots
INT[] oidPickBelt
INT[] oidPickHarn
INT[] oidPickPlugA
INT[] oidPickPlugV
INT[] oidPickPieV 
INT[] oidPickPieN 
INT[] oidPickCuffsA 
INT[] oidPickCuffsL 
INT[] oidPickBra

STRING[] sUtilityTask
STRING[] sDebInfo
STRING[] sMainPage
STRING[] sBinderEff
STRING[] sPlugEff
STRING[] sPickPlugEff 
STRING[] sConFis
STRING[] sOutCuss
STRING[] sActJsons
STRING[] sActLis
STRING[] sOutJsons
STRING[] sOutSelTos

Function SetDefaults(Int aiPrevVersion) 
	aSelActor = iDDe.PlayerRef
	StorageUtil.SetIntValue(None, "iDDeDisplayInfo", 1)
	StorageUtil.SetIntValue(None, "iDDeConsoleInfo", 0)
	StorageUtil.SetIntValue(None, "iDDeDebugInfo", 4)
	StorageUtil.SetFloatValue(aSelActor, "iDDefSelfTimer", 30)
	sExistPass = JsonUtil.GetStringValue(GetPathJson(sPath = "PlaSys"), "sExistPass", "Password")
	StorageUtil.SetIntValue(aSelActor, "iDDeAnklesEff", 0)
	iDDe.iDDeBinderEff = 1
	iDDe.iDDeArmFight = 0
	iDDe.iDDeArmSneak = 1
	iDDe.iDDeArmMenu = 1
	iDDe.iDDeArmActive = 0
	iDDe.iDDeArmTravel = 1
	iDDe.iDDeArmWait = 1
	iDDe.iDDeArmTalk = 0
	iDDe.iDDeArmStruggle = 1
	iDDe.fDDeRefreshRate = 6.6
	iDDe.iDDePickPlugEff = 1
	iDDe.iDDePlugRibbed = 2
	iDDe.iDDePlugShocker = 3
	iDDe.iDDePlugFusStag = 1
	iDDe.iDDePlugLinked = 3
	iDDe.iDDePlugLively = 3
	iDDe.iDDePlugEleStim = 2
	iDDe.iDDePlugEdgeRand = 2
	iDDe.iDDePlugEdgeOnly = 0
	iDDe.iDDePlugPoss = 3
	iDDe.iDDePlugTrain = 2
	iDDe.iDDePlugDrainH = 1
	iDDe.iDDePlugDrainS = 3
	iDDe.iDDePlugDrainM = 3
	iDDe.iDDePlugVeLively = 3
	iDDe.iDDePlugVibCast = 2
	iDDe.iDDePlugVib = 3
	iDDe.iDDePlugVibRand = 3
	iDDe.iDDePlugVibStrg = 3
	iDDe.iDDePlugVibWeak = 0
	iDDe.iDDePlugVibVeStrg = 0
	iDDe.iDDePlugVibVeWeak = 0
	iDDe.iDDeStrip = 1
	iDDe.iDDeUtilityTask.SetValueInt(0)
	iDDe.iDDeHardCore = 1	
	iDDe.iDDeRemQuest = 0
	iDDe.iDDeMechFX = 1
	iDDe.iDDeMechJump = 1
	iDDe.iDDeMechDisarm = 1
	iDDe.iDDeMechNoActivate = 0 
	iDDe.iDDeMechNoFighting = 1
	iDDe.iDDeMechNoMenu = 1
	iDDe.iDDeMechNoFastTravel = 1
	iDDe.iDDeMechNoMove = 0 
	iDDe.iDDeMechNoSneak = 1
	iDDe.iDDeMechNoSprint = 0 
	iDDe.iDDeMechNoWait = 0
	iDDe.iDDeBlockActArm = 1
	iDDe.iDDeBlockActMit = 1
	iDDe.iEnableBondFX = 1
	sActLi = ""
	RegisterHotKeys(sOpt = "UnMap")
	;Maintenance
	;===============================================
		oidRefrDDsList = 0
		oidInputPass = 0
		oidExistPass = 0
EndFunction 

INT Function GetVersion()
	RETURN iDDeUtil.GetVersion()
EndFunction

STRING Function GetSemVerStr()
	RETURN iDDeUtil.GetSemVerStr()
EndFunction

;Dependent Mods Version Check 
;ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
INT Function CheckMods()
	INT iRet = 1
		iRet *= iSUmUtil.CheckModJson(sCuM = "DDe", sCuJ = GetPathJson(sPath = "DDeSys"), sCuV = iDDeUtil.GetSemVerStr())
			If (iRet)
				iRet *= iSUmUtil.CheckModVer(sCuM = "DDe", sCuJ = GetPathJson(sPath = "DDeSys"), sCuV = iDDeUtil.GetSemVerStr(), \
							 						 					 sCoM = "SUM", sCoJ = iSUmUtil.GetPath(sJson = "iSUmSystem"), sCoV = iSUmUtil.GetSemVerStr())
				iRet *= CheckDDa()
				iRet *= CheckDDi()
				iRet *= CheckDDx() 
				iRet *= CheckCD()
				iRet *= CheckZap()
				iRet *= CheckPapy()
			EndIf
	RETURN iRet
EndFunction
INT Function CheckDDa()
	sDDaVersion = iDDeLib.ZadMain.GetVersionString()
		If (iSUmUtil.CompareStrAsInt(sStr1 = "2.90", sOpr = ">", sStr2 = sDDaVersion))
			Debug.MessageBox("DDe:\nYour current Devious Devices - Assets version No. [" +sDDaVersion+ "] is too old, or could not be found.\nAt least v2.90 is needed.")
			RETURN 0
		EndIf
	RETURN 1
EndFunction 
INT Function CheckDDi() 
	sDDiVersion = iDDeLib.ZadLib.GetVersionString()
		If (iSUmUtil.CompareStrAsInt(sStr1 = "2.90", sOpr = ">", sStr2 = sDDiVersion))
			Debug.MessageBox("DDe:\nYour current Devious Devices - Integration version No. [" +sDDiVersion+ "] is too old, or could not be found.\nAt least v2.90 is needed.")
			RETURN 0
		EndIf
	RETURN 1
EndFunction 
INT Function CheckDDx()
	sDDxVersion = iDDeLib.ZadxLib.GetVersionString()
		If (iSUmUtil.CompareStrAsInt(sStr1 = "1.21", sOpr = ">", sStr2 = sDDxVersion))
			Debug.MessageBox("DDe:\nYour current Devious Devices - Expansion version No. [" +sDDxVersion+ "] is too old, or could not be found.\nAt least v1.21 is needed.")
			RETURN 0
		EndIf
	RETURN 1
EndFunction
INT Function CheckCD()
		If (iDDe.bCD)
			STRING sCurVer = iDDeCDxUtil.GetSemVerStr()
			STRING sComVer = iSUmUtil.CheckStrListVer(sJson = GetPathJson(sPath = "DDeSys"), sList = "CDxPatchCompatibleSemVers", sVer = sCurVer)
				If (iSUmUtil.CompareStrAsInt(sStr1 = sCurVer, sOpr = "!=", sStr2 = sComVer))
					Debug.MessageBox("DDe:\nDDe has detected CD installed but the 'DDe - CD Patch' is missing or the current version No. [" +sCurVer+ "] is the wrong version.\nPlease install the 'DDe - CD Patch' version No. [" +sComVer+ "], so DDe can use CD DDs.")
					RETURN 0
				EndIf
			sCurVer = iDDeCDxUtil.GetCDSemVerStr()
			sComVer = iSUmUtil.CheckStrListVer(sJson = GetPathJson(sPath = "DDeSys"), sList = "CDxCompatibleSemVers", sVer = sCurVer)
				If (iSUmUtil.CompareStrAsInt(sStr1 = sCurVer, sOpr = "!=", sStr2 = sComVer))
					Debug.MessageBox("DDe:\nDDe has detected CD installed but it is the wrong version. Update CD to version [" +sComVer+ "].")
					RETURN 0
				EndIf
		EndIf
	RETURN 1
EndFunction
INT Function CheckZap()
	sZapVer = zbfUtil.GetVersionStr() 
		;If (iSUmUtil.CompareStrAsInt(sStr1 = "6.11", sOpr = ">", sStr2 = sZapVer))
		;	Debug.MessageBox("DDe:\nYour current ZAP version No. [" +sZapVer+ "] is the wrong version.\nAt least ZAP version No. [6.11.0] is needed.")
		;	RETURN 0
		;EndIf
	RETURN 1
EndFunction
INT Function CheckPapy()
	sPapyVer = iSUmUtil.StrToSemVer(sStr = PapyrusUtil.GetVersion(), iDig = 1, iDeli = 1)
		;If (iSUmUtil.CompareStrAsInt(sStr1 = "3.3", sOpr = ">", sStr2 = sPapyVer))
		;	Debug.MessageBox("DDe:\nYour current PapyrusUtil version No. [" +sPapyVer+ "] is the wrong version.\nAt least version No. [3.3.0] is needed.")
		;	RETURN 0
		;EndIf
	RETURN 1
EndFunction
;ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
STRING Function GetCustomControl(INT aiKeyCode)
	If(aiKeyCode == iKeyActSel)
		RETURN "Select Actor Key"
	ElseIf(aiKeyCode == iKeySelfBond)
		RETURN "Self Bondage Key"
	Else
		RETURN ""
	EndIf
EndFunction
BOOL Property bIsOpen = False Auto Hidden 
Event OnKeyUp(Int aiKeyCode, Float afHoldTime)
	If (iDDe.iDDeIsInMenu() || bIsOpen)
		RETURN
	EndIf
		bIsOpen = True
			If (aiKeyCode == iKeyActSel);Actor Handling
				ObjectReference orCurrent = Game.GetCurrentCrosshairRef()
					If (!orCurrent)
						orCurrent = Game.GetCurrentConsoleRef()
					EndIf
					If (orCurrent)
						AddFormToSelection(orCurrent)
					Else
						iDDeUtil.Log("iDDeConfig.OnKeyUp():-> ", "Not a valid selection!", 3, 1)
					EndIf
			ElseIf (aiKeyCode == iKeySelfBond);Self Bondage
				StartSelfBondage(aActor = aSelActor)
			EndIf
		bIsOpen = False
EndEvent
Function AddFormToSelection(ObjectReference orSelForm)
	Actor aActor = (orSelForm AS Actor)
		If (aActor)
			If (aActor.IsChild())
				iDDeUtil.Log("iDDeConfig.AddFormToSelection():-> ", "No children!", 3, 1)
			ElseIf (!iSUmUtil.IsActorValid(aActor))
				iDDeUtil.Log("iDDeConfig.AddFormToSelection():-> ", "Not a valid actor!", 3, 1)
			Else
				If (aActor == iDDe.PlayerRef)
					iDDeUtil.Log("iDDeConfig.AddFormToSelection():-> ", "It's... it's you! The hero of Kvatch.", 3, 1)
				EndIf
				;aSelActor = aActor
				;aLiActor = aSelActor
				sSelActor = iSUmUtil.GetActorName(aActor, "No Actor")
				iDDeUtil.Log("iDDeConfig.AddFormToSelection():-> Selected actor [" +sSelActor+ "].", "Selected actor [" +SetColor(sActCo, sSelActor)+ "].", 3, 2)
				If (sAutoStoActor)
					AddActorToList(aActor = aActor) 
				EndIf
			EndIf
		EndIf
EndFunction
 
INT Function SetSystemPgOIDs()
		oidInputPass = 0
		oidExistPass = 0
		oidRemQuestDD = 0
		oidAdminFun = 0
		oidExeFun = 0
		oidAdminHardCoreDD = 0
		oidAdminOpt = 0
	RETURN 1
EndFunction
INT Function SetDeviceIntPgOIDs()
	oidEqpMCM = 0
	oidEqpCust = 0
	oidEqpOutfit = 0
	oidEqpOutCur = 0
	oidEqpOutPre = 0
	oidRemOutfit = 0
	oidRemExisting = 0
	oidRemMCM = 0
	oidSelfTimer = 0
	oidSelfBondStart = 0
	oidRefrDDsList = 0
	oidOutCusEdit = 0
	oidOutClearMCM = 0
	RETURN 1
EndFunction
INT Function SetLocOutPgOIDs()
	oidOutLocAdd = 0
	RETURN 1
EndFunction
INT Function SetCusOutPgOIDs()
	oidOutCusAdd = 0
	RETURN 1
EndFunction
INT Function SetDeviceOptsPgOIDs()
		oidPickBinder = CreateIntArray(sPickBinder.Length, 0)
		oidPickSuit = CreateIntArray(sPickSuit.Length, 0)
		oidPickGag = CreateIntArray(sPickGag.Length, 0)
		oidPickHood = CreateIntArray(sPickHood.Length, 0)
		oidPickBlinder = CreateIntArray(sPickBlinder.Length, 0)
		oidPickCollar = CreateIntArray(sPickCollar.Length, 0)
		oidPickGloves = CreateIntArray(sPickGloves.Length, 0)
		oidPickBoots = CreateIntArray(sPickBoots.Length, 0)
		oidPickBelt = CreateIntArray(sPickBelt.Length, 0)
		oidPickHarn = CreateIntArray(sPickHarn.Length, 0)
		oidPickPlugA = CreateIntArray(sPickPlugA.Length, 0)
		oidPickPlugV = CreateIntArray(sPickPlugV.Length, 0)
		oidPickPieV = CreateIntArray(sPickPieV.Length, 0) 
		oidPickPieN = CreateIntArray(sPickPieN.Length, 0)
		oidPickCuffsA = CreateIntArray(sPickCuffsA.Length, 0) 
		oidPickCuffsL = CreateIntArray(sPickCuffsL.Length, 0) 
		oidPickBra = CreateIntArray(sPickBra.Length, 0)
		oidBlockActArm = 0
		oidArmFight = 0
		oidArmSneak = 0
		oidArmMenu = 0
		oidArmTalk = 0
		oidMechFX = 0
		oidMechJump = 0
		oidMechDisarm = 0
		oidMechNoActivate = 0
		oidMechNoFighting = 0
		oidMechNoMenu = 0
		oidMechNoFastTravel = 0
		oidEnableBondFX = 0
		oidArmActive = 0
		oidArmTravel = 0
		oidArmWait = 0
		oidArmStruggle = 0
		oidMechNoMove = 0
		oidMechNoSneak = 0
		oidMechNoSprint = 0
		oidMechNoWait = 0
		oidDevOptsPg = 0
		oidBlockActArm = 0
		oidBinderEff = 0
		oidAnklesEff = 0
		oidPickPlugEff = 0
		oidPlugRibbed = 0
		oidPlugShocker = 0
		oidPlugFusStag = 0
		oidPlugLinked = 0
		oidPlugEleStim = 0
		oidPlugEdgeRand = 0
		oidPlugEdgeOnly = 0
		oidPlugPoss = 0
		oidPlugTrain = 0
		oidPlugVibCast = 0
		oidMechPow = 0
		oidRefreshRate = 0
		oidPlugHelp = 0
		oidPlugDrainH = 0
		oidPlugDrainS = 0
		oidPlugDrainM = 0
		oidPlugLively = 0
		oidPlugVeLively = 0
		oidPlugVib = 0
		oidPlugVibRand = 0
		oidPlugVibStrg = 0
		oidPlugVibWeak = 0
		oidPlugVibVeStrg = 0
		oidPlugVibVeWeak = 0
		oidMechPowSnd = 0
	RETURN 1	
EndFunction
BOOL Function InitialSetup()
	;Page Vars
	;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		If (StorageUtil.GetIntValue(None, "iSUmConsoleVer", 0) < 1)
			iConFlag = Option_Flag_Disabled
			StorageUtil.SetIntValue(None, "iSUmConsoleInfo", 0)
		Else
			iConFlag = 0
		EndIf
	;Array Init
	;...............................................
		iPickBinder = NEW INT[8]
		 iPickBinder[0] = 0
		 iPickBinder[1] = 1
		 iPickBinder[2] = 1
		 iPickBinder[3] = 1
		 iPickBinder[4] = 1
		 iPickBinder[5] = 1
		 iPickBinder[6] = 1
		 iPickBinder[7] = 1
		
		iPickSuit = NEW INT[7]
		 iPickSuit[0] = 0
		 iPickSuit[1] = 1 
		 iPickSuit[2] = 1 
		 iPickSuit[3] = 1 
		 iPickSuit[4] = 1 
		 iPickSuit[5] = 1 
		 iPickSuit[6] = 1
		
		iPickGag = NEW INT[7]
		 iPickGag[0] = 0
		 iPickGag[1] = 1
		 iPickGag[2] = 1
		 iPickGag[3] = 1
		 iPickGag[4] = 1
		 iPickGag[5] = 1
		 iPickGag[6] = 1
		
		iPickHood = NEW INT[4]
		 iPickHood[0] = 0
		 iPickHood[1] = 1
		 iPickHood[2] = 1
		 iPickHood[3] = 0
		
		iPickBlinder = NEW INT[2]
		 iPickBlinder[0] = 1
		 iPickBlinder[1] = 1
		
		iPickCollar = NEW INT[8]
		 iPickCollar[0] = 0
		 iPickCollar[1] = 1
		 iPickCollar[2] = 1
		 iPickCollar[3] = 1
		 iPickCollar[4] = 1
		 iPickCollar[5] = 1 
		 iPickCollar[6] = 1
		 iPickCollar[7] = 1
		
		iPickGloves = NEW INT[4]
		 iPickGloves[0] = 0
		 iPickGloves[1] = 1
		 iPickGloves[2] = 1
		 iPickGloves[3] = 1
		
		iPickBoots = NEW INT[7]
		 iPickBoots[0] = 0
		 iPickBoots[1] = 1
		 iPickBoots[2] = 1
		 iPickBoots[3] = 1
		 iPickBoots[4] = 1
		 iPickBoots[5] = 1 
		 iPickBoots[6] = 1
		
		iPickBelt = NEW INT[4]
		 iPickBelt[0] = 0
		 iPickBelt[1] = 1
		 iPickBelt[2] = 1
		 iPickBelt[3] = 0
		
		iPickHarn = NEW INT[3]
		 iPickHarn[0] = 0
		 iPickHarn[1] = 1
		 iPickHarn[2] = 1
		 
		iPickPlugA = NEW INT[14]
		 iPickPlugA[0] = 0
		 iPickPlugA[1] = 1
		 iPickPlugA[2] = 1
		 iPickPlugA[3] = 1
		 iPickPlugA[4] = 1
		 iPickPlugA[5] = 1 
		 iPickPlugA[6] = 1
		 iPickPlugA[7] = 1
		 iPickPlugA[8] = 1
		 iPickPlugA[9] = 1
		 iPickPlugA[10] = 1
		 iPickPlugA[11] = 1
		 iPickPlugA[12] = 1 
		 iPickPlugA[13] = 1
		 
		iPickPlugV = NEW INT[12]
		 iPickPlugV[0] = 0
		 iPickPlugV[1] = 1
		 iPickPlugV[2] = 1
		 iPickPlugV[3] = 1
		 iPickPlugV[4] = 1
		 iPickPlugV[5] = 1 
		 iPickPlugV[6] = 1
		 iPickPlugV[7] = 1
		 iPickPlugV[8] = 1
		 iPickPlugV[9] = 1
		 iPickPlugV[10] = 1
		 iPickPlugV[11] = 1
		 
		iPickPieV = NEW INT[4] 
		 iPickPieV[0] = 0
		 iPickPieV[1] = 1
		 iPickPieV[2] = 1
		 iPickPieV[3] = 1
		 
		iPickPieN = NEW INT[7] 
		 iPickPieN[0] = 0
		 iPickPieN[1] = 1
		 iPickPieN[2] = 1 
		 iPickPieN[3] = 1
		 iPickPieN[4] = 0
		 iPickPieN[5] = 0
		 iPickPieN[6] = 0
		  
		iPickCuffsA = NEW INT[4]
		 iPickCuffsA[0] = 0
		 iPickCuffsA[1] = 1
		 iPickCuffsA[2] = 1
		 iPickCuffsA[3] = 0
		 
		iPickCuffsL = NEW INT[4]
		 iPickCuffsL[0] = 0
		 iPickCuffsL[1] = 1
		 iPickCuffsL[2] = 1
		 iPickCuffsL[3] = 0
		 
		iPickBra = NEW INT[3]
		 iPickBra[0] = 0
		 iPickBra[1] = 1
		 iPickBra[2] = 1
		 
	RETURN True
EndFunction
BOOL Function LoadStuff()
	RETURN True
EndFunction
BOOL Function LoadStrings()
	;String[]
		Pages = NEW STRING[9]
		 Pages[0] = "Setup"
		 Pages[1] = "System"
		 Pages[2] = "Actor Selection"
		 Pages[3] = "Device Interaction"
		 Pages[4] = "Device Library" 
		 Pages[5] = "Device Options"
		 Pages[6] = "Local Outfits"
		 Pages[7] = "Custom Outfits"
		 Pages[8] = "Debug"
		
		sDebInfo = NEW STRING[6]
		 sDebInfo[0] = "No Log"
		 sDebInfo[1] = "Errors "
		 sDebInfo[2] = "Warnings "
		 sDebInfo[3] = "Info "
		 sDebInfo[4] = "Debug "
		 sDebInfo[5] = "Trace "
		
		sUtilityTask = NEW STRING[2] 
		 sUtilityTask[0] = "No Task"
		 sUtilityTask[1] = "Skip Scene" 
		
		sBinderEff = NEW STRING[3]
		 sBinderEff[0] = "Disabled "
		 sBinderEff[1] = "DDe Only"
		 sBinderEff[2] = "All "
		
		sPlugEff = NEW STRING[4]
		 sPlugEff[0] = "Disabled "
		 sPlugEff[1] = "Anal "
		 sPlugEff[2] = "Vaginal "
		 sPlugEff[3] = "Both "
		
		sPickPlugEff = NEW STRING[3]
		 sPickPlugEff[0] = "All Disabled"
		 sPickPlugEff[1] = "Custom "
		 sPickPlugEff[2] = "All Enabled" 
		
		sOutSelTos = NEW STRING[3]
		 sOutSelTos[0] = "As A Single Outfit"
		 sOutSelTos[1] = "To The Local Outfit Array"
		 sOutSelTos[2] = "To The Custom Outfit Array" 
		
		sPickBinder = NEW STRING[8]
		 sPickBinder[0] = "No Heavy Bondage"
		 sPickBinder[1] = "Pet Suit"
		 sPickBinder[2] = "Elbowbinder"
		 sPickBinder[3] = "Armbinder"
		 sPickBinder[4] = "Yoke"
		 sPickBinder[5] = "Shackles"
		 sPickBinder[6] = "Boxbinder"
		 sPickBinder[7] = "Boxbinder Outfit"
		 
		sPickSuit = NEW STRING[7]
		 sPickSuit[0] = "No Dress"
		 sPickSuit[1] = "Elegant Dress"
		 sPickSuit[2] = "Extreme Dress" 
		 sPickSuit[3] = "Extreme Open Dress" 
		 sPickSuit[4] = "Latex Dress" 
		 sPickSuit[5] = "Latex Open Dress" 
		 sPickSuit[6] = "CatSuit Dress" 
		
		sPickGag = NEW STRING[7]
		 sPickGag[0] = "No Gag"
		 sPickGag[1] = "Panel Gag"
		 sPickGag[2] = "Harness Ball Gag"
		 sPickGag[3] = "Simple Ball Gag"
		 sPickGag[4] = "Harness Ring Gag"
		 sPickGag[5] = "Simple Ring Gag"
		 sPickGag[6] = "Bit Gag"
		
		sPickHood = NEW STRING[4]
		 sPickHood[0] = "No Hood"
		 sPickHood[1] = "Cat Hood"
		 sPickHood[2] = "Iron Mask"
		 sPickHood[3] = "Gas Mask" 
		
		sPickBlinder = NEW STRING[2]
		 sPickBlinder[0] = "No Blindfold"
		 sPickBlinder[1] = "Locked Blindfold"
		
		sPickCollar = NEW STRING[8] 
		 sPickCollar[0] = "No Collar"
		 sPickCollar[1] = "CatSuit Collar"
		 sPickCollar[2] = "Restrictive Collar" 
		 sPickCollar[3] = "Harness Collar"
		 sPickCollar[4] = "Paded Collar"
		 sPickCollar[5] = "Rings Collar"
		 sPickCollar[6] = "Posture Collar"
		 sPickCollar[7] = "Shackles Collar" 
	 
		sPickGloves = NEW STRING[4]
		 sPickGloves[0] = "No Gloves" 
		 sPickGloves[1] = "Restrictive Gloves" 
		 sPickGloves[2] = "CatSuit Gloves" 
		 sPickGloves[3] = "Mittens Gloves"
	
		sPickBoots = NEW STRING[7]
		 sPickBoots[0] = "No Boots"
		 sPickBoots[1] = "Chain Boots" 
		 sPickBoots[2] = "CatSuit Boots" 
		 sPickBoots[3] = "Restrictive Boots"
		 sPickBoots[4] = "Ring Boots" 
		 sPickBoots[5] = "Pony Boots"
		 sPickBoots[6] = "Heel Boots" 
		 
		sPickBelt = NEW STRING[4]
		 sPickBelt[0] = "No Belt"
		 sPickBelt[1] = "Paded Belt" 
		 sPickBelt[2] = "Chain Belt" 
		 sPickBelt[3] = "Paded Open Belt"
	 
	 	sPickHarn = NEW STRING[3]
		 sPickHarn[0] = "No Harness"
		 sPickHarn[1] = "Locked Harness" 
		 sPickHarn[2] = "Corset Harness" 
		 
		sPickPlugA = NEW STRING[14]
		 sPickPlugA[0] = "No Anal Plug"
		 sPickPlugA[1] = "Vintage Anal Plug"
		 sPickPlugA[2] = "Soul Gem Anal Plug"
		 sPickPlugA[3] = "Inflatable Anal Plug"
		 sPickPlugA[4] = "Grand Soul Gem Anal Plug"
		 sPickPlugA[5] = "Black Soul Gem Anal Plug" 
		 sPickPlugA[6] = "Shocking Anal Plug"
		 sPickPlugA[7] = "Pear Anal Plug"
		 sPickPlugA[8] = "Pear Bell Anal Plug"
		 sPickPlugA[9] = "Pear Sign Anal Plug"
		 sPickPlugA[10] = "Pony Tail Anal Plug"
		 sPickPlugA[11] = "Pony Tail Braided Plug"
		 sPickPlugA[12] = "Pony Tail Puffy Plug" 
		 sPickPlugA[13] = "DDe Anal Plug"
		 
		sPickPlugV = NEW STRING[12]
		 sPickPlugV[0] = "No Vaginal Plug"
		 sPickPlugV[1] = "Vintage Vaginal Plug"
		 sPickPlugV[2] = "Soul Gem Vaginal Plug"
		 sPickPlugV[3] = "Inflatable Vaginal Plug"
		 sPickPlugV[4] = "Training Vaginal Plug"
		 sPickPlugV[5] = "Grand Soul Gem Vaginal Plug" 
		 sPickPlugV[6] = "Black Soul Gem Vaginal Plug"
		 sPickPlugV[7] = "Shocking Vaginal Plug"
		 sPickPlugV[8] = "Pear Vaginal Plug"
		 sPickPlugV[9] = "Pear Bell Vaginal Plug"
		 sPickPlugV[10] = "Pear Chain Vaginal Plug"
		 sPickPlugV[11] = "DDe Vaginal Plug"
		 
		sPickPieV = NEW STRING[4] 
		 sPickPieV[0] = "No Vaginal Piercing"
		 sPickPieV[1] = "Soul Gem Vaginal Piercing"  
		 sPickPieV[2] = "Common Soul Vaginal Piercing"  
		 sPickPieV[3] = "Shocking Soul Gem Vaginal Piercing"
		 
		sPickPieN = NEW STRING[7] 
		 sPickPieN[0] = "No Nipple Piercing"
		 sPickPieN[1] = "Soul Gem Nipple Piercing"  
		 sPickPieN[2] = "Common Soul Nipple Piercing"  
		 sPickPieN[3] = "Shocking Soul Gem Nipple Piercing"
		 sPickPieN[4] = "HR Chain Harness Nipple Piercing"
		 sPickPieN[5] = "HR Clamps Nipple Piercing"
		 sPickPieN[6] = "HR Nipple Piercing"
		  
		sPickCuffsA = NEW STRING[4]
		 sPickCuffsA[0] = "No Arm Cuffs"
		 sPickCuffsA[1] = "Padded Arm Cuffs"
		 sPickCuffsA[2] = "Rings Arm Cuffs"
		 sPickCuffsA[3] = "Rope Arm Cuffs"
		 
		sPickCuffsL = NEW STRING[4]
		 sPickCuffsL[0] = "No Leg Cuffs"
		 sPickCuffsL[1] = "Padded Leg Cuffs"
		 sPickCuffsL[2] = "Rings Leg Cuffs"
		 sPickCuffsL[3] = "Rope Leg Cuffs"
		 
		sPickBra = NEW STRING[3]
		 sPickBra[0] = "No Bra"
		 sPickBra[1] = "Metal Padded Bra"
		 sPickBra[2] = "Paded Bra"
	
	RETURN True
EndFunction
	 
Event OnPageReset(String asPage)
	Parent.OnPageReset(asPage)
	;Pages Vars
	;***********************************************
		STRING sStrDes = ("The line length for this string can be adjusted in the SUM 'Setup' page.")
		STRING sStrUIe = ("[UseUIE] - it will allow you to edit the whole string at once, needs the UI Extensions mod.")
		STRING sSysJs = GetPathJson(sPath = "DDeSys")
		STRING sJsOID = GetPathJson(sPath = "PlaSys", sJson = "OID")
		STRING sStr1 = ""
		STRING sStr2 = ""
		STRING sInfo = ""
		STRING sLocEqp = ""
		STRING sCusEqp = ""
		STRING sLocCol = sOutCo
		STRING sCusCol = sOutCo
		STRING sLocOut = "Outfit"
		STRING sCusOut = "Outfit"
		STRING sLin = ""
		INT iDisabled = Option_Flag_Disabled
		INT iWornDDs = 0
		INT iLocMax = 0
		INT iCusMax = 0
			;LoadStrings()
			GetSelActor()
			sSelActor = iSUmUtil.GetFormName(aSelActor, "No Actor Selected")
				If (aSelActor && !aSelActor.WornHasKeyword(iDDeLib.ZadLib.zad_Lockable) && !iDDe.PlayerRef.WornHasKeyword(iDDeLib.ZadLib.zad_Lockable))
					iDisabled = 0
				EndIf
				If (sDDeOutLoc)
					iLocMax = StringUtil.GetLength(sDDeOutLoc)
						If ((StringUtil.GetNthChar(sDDeOutLoc, 0) == "[") && (StringUtil.GetNthChar(sDDeOutLoc, (iLocMax - 1)) == "]"))
							sLocEqp = " a random outfit from"
							sLocOut = "Outfit Array"
						ElseIf ((StringUtil.GetNthChar(sDDeOutLoc, 0) == "(") && (StringUtil.GetNthChar(sDDeOutLoc, (iLocMax - 1)) == ")"))
							sLocEqp = " a random outfit from"
							sLocOut = "Outfit Json List"
						EndIf
				EndIf
				If (sDDeOutCus)
					iCusMax = StringUtil.GetLength(sDDeOutCus)
						If ((StringUtil.GetNthChar(sDDeOutCus, 0) == "[") && (StringUtil.GetNthChar(sDDeOutCus, (iCusMax - 1)) == "]"))
							sCusEqp = " a random outfit from"
							sCusOut = "Outfit Array"
						ElseIf ((StringUtil.GetNthChar(sDDeOutCus, 0) == "(") && (StringUtil.GetNthChar(sDDeOutCus, (iCusMax - 1)) == ")"))
							sCusEqp = " a random outfit from"
							sCusOut = "Outfit Json List"
						EndIf
				EndIf
				If (StringUtil.Find(sDDeOutCus, "iDDe") == 0)
					sCusCol = sOutLoCo
				EndIf
				If ((StringUtil.Find(sDDeOutLoc, "iDDe") == 0) || (StringUtil.Find(sDDeOutLoc, "(") == 0) || (StringUtil.Find(sDDeOutLoc, "[") == 0))
					sLocCol = sOutLoCo
				EndIf
	;***********************************************		
	;Default cursor behavior
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)
	;Main Page 
	;mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	If (asPage == "")
		INT iPg = RandomInt(1, 20)
			LoadCustomContent("Devious Devices - Equip/Main" +iPg+ ".dds", 106, 71)
		RETURN
	Else 
		UnloadCustomContent()  
	EndIf
	If (asPage == Pages[0]) ;Setup
	;Setup Page
	;sssssssssssssssssssssssssssssssssssssssssssssss
	STRING sHexHelp = "\n[Random] - Will return a random RRGGBB code."
		sStr1 = "  Save " +SetColor(sOutLoCo, "^The Above^ ") + sLocOut+ " as [" +SetColor(sFacCo, sOutLiName)+ "]"
		sStr2 = "  Save " +SetColor(sOutCo, "^The Above^ ") + sCusOut+ " as [" +SetColor(sFacCo, sOutLiName)+ "]"
			If (StringUtil.Find(sOutLiOpt, "bAdd") > -1)
				sStr1 = "  Add " +SetColor(sOutLoCo, "^The Above^ ") + sLocOut+ " to [" +SetColor(sFacCo, sOutLiName)+ "]"
				sStr2 = "  Add " +SetColor(sOutCo, "^The Above^ ") + sCusOut+ " to [" +SetColor(sFacCo, sOutLiName)+ "]"
			ElseIf (StringUtil.Find(sOutLiOpt, "bRem") > -1)
				sStr1 = "  Remove " +SetColor(sOutLoCo, "^The Above^ ") + sLocOut+ " From [" +SetColor(sFacCo, sOutLiName)+ "]"
				sStr2 = "  Remove " +SetColor(sOutCo, "^The Above^ ") + sCusOut+ " From [" +SetColor(sFacCo, sOutLiName)+ "]"
			EndIf
			If (!sOutLiJson)
				sOutLiJson = "iDDeRandomOutfits.json"
			Else
				sOutLiJson = SetJson(sJson = sOutLiJson)
			EndIf
	;sssssssssssssssssssssssssssssssssssssssssssssss
		AddHeaderOption("Setup Options")
			oid86Device = MyAddToggleOption("Remove Un-equipped Devices", iDDe.iDDe86Device, 1, "When checked - the removed devices will also be removed from the inventory.")
			oidStripForDD = MyAddToggleOption("Strip Before Bondage", iDDe.iDDeStrip, 1, "When checked - actor will be stripped before the bondage session.")
			oidNoStrip = MyAddInputOption("No Strip Items List", iDDe.sDDeNoStrip, "Enter a list name that contains items to be skipped (as in not removed) when an outfit is equipped.\nThis list of items is setup in SUM (>1.44) and only applies to equipped items.\nLeave blank to skip nothing.")	
		
		AddHeaderOption("Hotkeys")
			oidKeyActSel = MyAddKeymapOption("Select Actor Key - > ", iKeyActSel, -1, "Here you can set the actor selection key.")	
			oidKeySelfBond = MyAddKeymapOption("Self Bondage Key - > ", iKeySelfBond, -1, "Here you can set the self bondage key.")
			
		AddHeaderOption("MCM Text Color Options")
			oidDisCo = MyAddInputOption("Screen Text ", SetColor(StorageUtil.GetStringValue(None, "iDDeLogColor"), StorageUtil.GetStringValue(None, "iDDeLogColor")), "Enter the RRGGBB hex color code for DDe screen info text color.\nExample [66ccff] +sHexHelp")
			oidActCo = MyAddInputOption("Actors ", SetColor(sActCo, sActCo), "Enter the RRGGBB hex color code for actors text color.\nExample [1abc9c]" +sHexHelp)
			oidActLiCo = MyAddInputOption("Actor Lists", SetColor(sActLiCo, sActLiCo), "Enter the RRGGBB hex color code for actor lists text color.\nExample [1abc66]" +sHexHelp)
			oidActJsCo = MyAddInputOption("Actor Jsons", SetColor(sActJsCo, sActJsCo), "Enter the RRGGBB hex color code for actor list jsons text color.\nExample [ff8c33]" +sHexHelp)
			oidConJsCo = MyAddInputOption("MCM Save Jsons", SetColor(sConJsCo, sConJsCo), "Enter the RRGGBB hex color code for the MCM saved jsons text color.\nExample [ffffff]" +sHexHelp)
			oidFacCo = MyAddInputOption("Random Lists", SetColor(sFacCo, sFacCo), "Enter the RRGGBB hex color code for the MCM random lists text color.\nExample [ffffff]" +sHexHelp)
				
		AddHeaderOption("Random Outfit Lists Json")	
			oidOutLiJson = MyAddInputOption("Json Name", SetColor(sFacCo, sOutLiJson), "Enter a .json name where the lists bellow will be saved.")
			AddEmptyOption()
			AddEmptyOption()
		AddHeaderOption(" Local " +sLocOut, Option_Flag_Disabled)
			oidOutLocJsAdd = MyAddTextOption(sStr1, "", "Hit this to set the " +sLocOut+ " below to [" +GetPathFolder(sPath = "Glo", sFolder = "Strings")+sOutLiJson+ "].")
				DisplayOutArray(sPre = " ", sStr = sDDeOutLoc, sCo = sLocCol, sOut = sLocOut, iChaMax = iSUmMCM.iLinChaMax, sSub = sDDeOutCus)
			
		AddHeaderOption("")	
	;Second half of the page
		SetCursorPosition(1)
		AddHeaderOption("");Setup Options
			If (aSelActor)
				oidHardCoreDD = MyAddToggleOption("HardCore Mode", iDDe.iDDeHardCore, 1, "When checked - the bondage devices can only be removed with keys.\nCannot change this option while [" +sSelActor+ "] has ANY devious devices on.", iDisabled)
			Else
				MyAddTextOption("No Actor Has Been Selected", "", "Switch to 'Actor Selection' page and select an actor.")
			EndIf
			AddEmptyOption()
			AddEmptyOption()
		
		AddHeaderOption("");Hotkeys
			AddEmptyOption()
			oidKeysUnMap = MyAddTextOption("Unbind Keys Mapping", "", "Will set all hotkeys mapping to 'none'.")
		
		AddHeaderOption("");MCM Text Color Options
			oidOutCo = MyAddInputOption("Custom Outfits", SetColor(sOutCo, sOutCo), "Enter the RRGGBB hex color code for custom outfits text color.\nExample [66ccff]" +sHexHelp)
			oidOutJsCo = MyAddInputOption("Custom Outfits Jsons", SetColor(sOutJsCo, sOutJsCo), "Enter the RRGGBB hex color code for custom outfit jsons text color.\nExample [ff8c66]" +sHexHelp)
			oidOutLoCo = MyAddInputOption("Local Outfits", SetColor(sOutLoCo, sOutLoCo), "Enter the RRGGBB hex color code for the default/local outfits text color.\nExample [66cc66]" +sHexHelp)
			AddEmptyOption()
			oidGooCo = MyAddInputOption("OK Color", SetColor(sGooCo, sGooCo), "Enter the RRGGBB hex color code for when a MCM option is good.\nExample [00ff00]")
			oidBadCo = MyAddInputOption("Failed Color", SetColor(sBadCo, sBadCo), "Enter the RRGGBB hex color code for when a MCM option has failed.\nExample [ff0000]")
				
		AddHeaderOption("") ;Outfit Lists Json
			oidOutLiName = MyAddInputOption(" List Name", SetColor(sFacCo, sOutLiName), "Enter a list name that will contain the random outfit lists bellow.")	
			MyAddTextOption("Outfits In [" +SetColor(sFacCo, sOutLiName)+ "]", SetColor(sFacCo, JsonUtil.StringListCount((GetPathFolder(sPath = "Glo", sFolder = "Strings") + sOutLiJson), sOutLiName)), "Show how many outfits there are in [" +sOutLiName+ "].")
			oidOutLiOpt = MyAddInputOption(" Saving Options", sOutLiOpt, "Enter the saving options. Available options are [bAdd,bRem,bNew].\n[bAdd] - Will add to an existing list. [bRem] - Will remove given outfits from the existing list. [bNew] - Will make a new list, deleting the previous.")
		AddHeaderOption("Custom " +sCusOut, Option_Flag_Disabled)
			oidOutCusJsAdd = MyAddTextOption(sStr2, "", "Hit this to set the " +sCusOut+ " below to [" +GetPathFolder(sPath = "Glo", sFolder = "Strings")+sOutLiJson+ "].")
				DisplayOutArray(sPre = " ", sStr = sDDeOutCus, sCo = sCusCol, sOut = sCusOut, iChaMax = iSUmMCM.iLinChaMax, sSub = sDDeOutLoc)
			
		AddHeaderOption("")
	ElseIf (asPage == Pages[1]) ;System
	;System
	;yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
		SetSystemPgOIDs()
		STRING sJsVer = JsonUtil.GetStringValue(sSysJs, "SemanticVer", "Fail")
		BOOL bJson = iSUmUtil.CompareStrAsInt(sStr1 = iDDeUtil.GetSemVerStr(), sOpr = "==", sStr2 = sJsVer)
			sConFis = iSUmUtil.GetJsonsInFolder(sFolder = GetPathFolder(sPath = "Pla", sFolder = "MCM"))
		INT iConFiMax = SetUpStrA1(sArray = sConFis, iPerPage = iConFiPerPg)
			oidConFis = CreateIntArray(iConFiMax, 0)
	;yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
		AddHeaderOption("System Status")
			MyAddTextOption("DDe Version No.", iSUmUtil.GetModVerStr(sVer = GetSemVerStr(), bMod = iDDe.bDDe, sOkCo = sGooCo, sBadCo = sBadCo), "Devious Devices - Equip version installed.")	
		
		AddHeaderOption("Required Mods")
			AddTextOption("SUM Version No.", iSUmUtil.GetModVerStr(sVer = iSUmUtil.GetSemVerStr(), bMod = iDDe.bSUM, sMod = "esm", sOkCo = sGooCo, sBadCo = sBadCo))
			MyAddTextOption("PapyrusUtil Version No.", iSUmUtil.GetModVerStr(sVer = sPapyVer, bMod = PapyrusUtil.GetVersion(), sMod = ""), "Papyrus Utilities version installed.")
			MyAddTextOption("ZAP Version No.", iSUmUtil.GetModVerStr(sVer = sZapVer, bMod = iDDe.bZAP, sMod = "esm", sOkCo = sGooCo, sBadCo = sBadCo), "ZaZ animation pack version installed.")
		
		AddHeaderOption("Optional Mods")
			MyAddTextOption("Captured Dreams:", iSUmUtil.GetModVerStr(sVer = iDDeCDxUtil.GetCDSemVerStr(), bMod = iDDe.bCD, sOkCo = sGooCo, sBadCo = sBadCo), "Is this mod installed and ready?")	
			MyAddTextOption("DDe - CD Patch:", iSUmUtil.GetModVerStr(sVer = iDDeCDxUtil.GetSemVerStr(), bMod = False, sMod = ""), "Is this mod installed and ready?")
			
		AddHeaderOption("Save MCM")
			oidConFile = MyAddInputOption("Enter a MCM File", SetColor(sConJsCo, sConFile), "[" +sConFile+ "] - Current text.\nEnter a file name to save all MCM configuration settings.")
			oidConSave = MyAddTextOption("Save MCM To [" +SetColor(sConJsCo, sConFile)+ "]", "Clicky", "Hit it to save all MCM configuration settings.")
			oidConLoad = MyAddTextOption("Load MCM From [" +SetColor(sConJsCo, sConFile)+ "]", "Clicky", "Hit it to load the MCM settings.\nYou cannot load the MCM settings while wearing any DDs.", iDisabled)
		AddHeaderOption(" Existing MCM Json Files", Option_Flag_Disabled)	
			MyAddTextOption(" Total Files", iConFiMax, "Total number of saved files.")
			oidConFiPg = MyAddSliderOption(" Go To Page No. ", _iA1P, 1, _iA1Ps, 1, 1, "{0}", "Choose a page number.")	
		AddHeaderOption("  Page No. " +_iA1P, Option_Flag_Disabled)	
			While (_iA1i < _iA1L2)
				oidConFis[_iA1i] = MyAddTextOption("  " +SetColor(sConJsCo, ((_iA1i + 1)+ ". "))+ "Select [" +SetColor(sConJsCo, sConFis[_iA1i])+"] file.", "", "Hit this to load this file.")
					_iA1i += 1
			EndWhile	
				
		AddHeaderOption("Other Options")
			oidRegisterTags = MyAddTextOption("Register DDe Tags.", "", "Hit this to manually register tags for devious devices added by this mod.\nYou only need to do this if you have mods that equip DDs by tags, i.e. 'CD, DD For The Masses'.")
			
		AddHeaderOption("Admin Options")	
			If (sExistPass != sInputPass)
				oidInputPass = MyAddInputOption("Enter Password", sInputPass, "Enter your password.")
			Else
				oidExistPass = MyAddInputOption("Change Your Password?", sInputPass, "Enter new password.")
				AddHeaderOption("", Option_Flag_Disabled)	
					oidRemQuestDD = MyAddToggleOption("Remove Quest DDs", iDDe.iDDeRemQuest, 0, "When checked - quest DDs i.e. CD shop, and DCL will also be removed.")
				
				AddHeaderOption("Utility ")
					oidAdminFun = MyAddInputOption("Admin Function", sAdminFun, "[" +sAdminFun+ "]\n" +iDDeMis.ExeAdminFun(sFun = "AdminFunction", sOpt = "Help"))
					oidExeFun = MyAddTextOption("Execute Function", "", "Hit this to execute the above function.")
			EndIf	
			
		AddHeaderOption("")
	;Second half of the page
	SetCursorPosition(1)
		AddHeaderOption("");System Status
			AddTextOption("DDe System Json", iSUmUtil.GetModVerStr(sVer = sJsVer, bMod = bJson, sMod = "json", sOkCo = sGooCo, sBadCo = sBadCo))
		
		AddHeaderOption("") ;Required Mods 
			MyAddTextOption("DDa Version No.", iSUmUtil.GetModVerStr(sVer = sDDaVersion, bMod = iDDe.bDDa, sMod = "esm", sOkCo = sGooCo, sBadCo = sBadCo), "Devious Devices - Assets version installed.")
			MyAddTextOption("DDi Version No.", iSUmUtil.GetModVerStr(sVer = sDDiVersion, bMod = iDDe.bDDi, sMod = "esm", sOkCo = sGooCo, sBadCo = sBadCo), "Devious Devices - Integration version installed.")
			MyAddTextOption("DDx Version No.", iSUmUtil.GetModVerStr(sVer = sDDxVersion, bMod = iDDe.bDDx, sMod = "esm", sOkCo = sGooCo, sBadCo = sBadCo), "Devious Devices - Expansion version installed.")
		
		AddHeaderOption("") ;Optional Mods
			MyAddTextOption("Sanguine's Debauchery:", iSUmUtil.GetModVerStr(sVer = "", bMod = iDDe.bSD, sMod = ""), "Is this mod installed and ready?")
			AddEmptyOption()
			
		AddHeaderOption("");Save MCM
			AddEmptyOption()
			oidConClear = MyAddTextOption("Clear [" +SetColor(sConJsCo, sConFile)+ "]", "Clicky", "Hit it to clear its contents.")
			oidConRfr = MyAddTextOption("Refresh MCM Files List", "Clicky", "Hit this to refresh the MCM .json files list.") 
		AddHeaderOption(" ", Option_Flag_Disabled) ;Existing MCM Json Files
			oidConFiPerPg = MyAddSliderOption("Files Per Page", iConFiPerPg, 6, 66, 6, 1, "{0}", "Choose how many files to display per page.")
			MyAddTextOption("Total Pages", _iA1Ps, "Total number of pages.")
		AddHeaderOption("", Option_Flag_Disabled)
			While (_iA1i < _iA1L)
				oidConFis[_iA1i] = MyAddTextOption("  " +SetColor(sConJsCo, ((_iA1i + 1)+ ". "))+ "Select [" +SetColor(sConJsCo, sConFis[_iA1i])+"] file.", "", "Hit this to load this file.")
					_iA1i += 1
			EndWhile	
			If (_iA1E)
				AddEmptyOption()
			EndIf		
			
		AddHeaderOption("");Other Options
			AddEmptyOption()
			
		AddHeaderOption("");Admin Options
			If (sExistPass != sInputPass)
				AddEmptyOption()
			Else
				AddEmptyOption()
				AddHeaderOption("", Option_Flag_Disabled)
					oidAdminHardCoreDD = MyAddToggleOption("HardCore Mode", iDDe.iDDeHardCore, 1, "When checked - the bondage devices can only be removed with keys.\nWait, you are not an admin!\nDo not use this option or you will be punished!")
				
				AddHeaderOption("") ;Utility 
					oidAdminOpt = MyAddInputOption("Admin Opts", sAdminOpt, ("[" +sAdminOpt+ "]\n" +iDDeMis.ExeAdminFun(sFun = sAdminFun, sOpt = "Help")))
					AddEmptyOption()	
			EndIf	
			
		AddHeaderOption("")	
	ElseIf (asPage == Pages[2]) ;Actor Selection
	;Actor Selection
	;aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
		STRING sActor = ""
		Actor aActor = None
			iDDe.sActFolder = GetFolder(sFolder = iDDe.sActFolder, sType = "Actors")
				If (!iDDe.sActJson)
					iDDe.sActJson = "iDDeActors.json"
				ElseIf (StringUtil.Find(iDDe.sActJson, ".json", (StringUtil.GetLength(iDDe.sActJson) - 5)) < 0)
					iDDe.sActJson += ".json"
				EndIf
			iDDe.sActFoJs = (iDDe.sActFolder + iDDe.sActJson)
			sActJsons = iSUmUtil.GetJsonsInFolder(sFolder = iDDe.sActFolder)
			sActLis = GetTypesInJson(sJson = iDDe.sActFoJs)
		INT iActJsMax = SetUpStrA1(sArray = sActJsons, iPerPage = iActJsPerPg)	
			oidActJsons = CreateIntArray(iActJsMax, 0)
		INT iActLiMax = SetUpStrA2(sArray = sActLis, iPerPage = iActLiPerPg)
			oidActLists = CreateIntArray(iActLiMax, 0)
			JsonUtil.IntListClear(sJsOID, "ActorsOIDs")
		INT iActMax = SetUpJsonL1(sJson = iDDe.sActFoJs, sList = sActLi, sType = "StringList", iPerPage = iActPerPg)
			JsonUtil.IntListResize(sJsOID, "ActorsOIDs", iActMax)
	;aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
		AddHeaderOption("Selected Actor")
			MyAddTextOption("Selected Actor - > ", SetColor(sActCo, sSelActor), "Actor ID - > [" +aSelActor+ "].")
			oidActLoadOpt = MyAddSliderOption("Load/Choose Actor Option", iActLoadOpt,  0, 4, 1, 1, "{0}", "Here you can choose how actors are loaded/chosen. [0] - Only the actor selected in the list will be loaded. [1] - Crosshair actor first, if none, then the list actor. [2] - Console -> list. [3] - Crosshair -> console -> list. [4] - Console -> crosshair -> list.")
			
		AddHeaderOption("Actors Json Folder/Path") 
			oidActFolder = MyAddInputOption("Folder Path-> [" +iDDe.sActFolder+ "]", "", "[" +iDDe.sActFolder+ "] - Current text.\n[SUM],[iSUmActors] - Will auto load the default SUM actor's folder.\n[DDe],[iDDeActors],[] - Will auto load the default DDe actor's folder.\n[+something] - Appends something to existing text input.")	
			oidActFolderRfr = MyAddTextOption("Refresh Folder", "Clicky", "Hit this to refresh the existing actor folder.")		
		AddHeaderOption(" Existing Actors Json Files", Option_Flag_Disabled)	
			MyAddTextOption(" Total Actors Json Files", iActJsMax, "Total number of .jsons in [" +iDDe.sActFolder+ "] folder.")
			oidActJsPg = MyAddSliderOption(" Go To Page No. ", _iA1P, 1, _iA1Ps, 1, 1, "{0}", "Choose a page number.")	
		AddHeaderOption("  Page No. " +_iA1P, Option_Flag_Disabled)
			While (_iA1i < _iA1L2)
				oidActJsons[_iA1i] = MyAddTextOption("  " +SetColor(sActJsCo, ((_iA1i + 1)+ ". "))+ "Select [" +SetColor(sActJsCo, sActJsons[_iA1i])+ "]", "", "Hit this to load this file.")
					_iA1i += 1
			EndWhile	
		
		AddHeaderOption("Actor Lists In [" +SetColor(sActJsCo, iDDe.sActJson)+ "]")
			oidActList = MyAddInputOption("Actor List Name", SetColor(sActLiCo, sActLi), "Enter an actor list name to store/load actors.\nMax 107 actors per list.\n[Default] - is the default list.")
			oidActListSave = MyAddTextOption("Save Actor List", SetColor(sActLiCo, sActLi), "Save [" +sActLi+ "].")
		AddHeaderOption(" ", Option_Flag_Disabled)
			MyAddTextOption(" Total Lists", iActLiMax, "Total number of lists in [" +iDDe.sActJson+ "].")
			oidActLiPg = MyAddSliderOption(" Go To Page No. ", _iA2P, 1, _iA2Ps, 1, 1, "{0}", "Choose a page number.")	
		AddHeaderOption("   Page No. " +_iA2P, Option_Flag_Disabled)		
			While (_iA2i < _iA2L2)
				oidActLists[_iA2i] = MyAddTextOption("  " +SetColor(sActLiCo, ((_iA2i + 1)+ ". "))+ "Load the [" +SetColor(sActLiCo, sActLis[_iA2i])+ "] list.", "", "Hit this to load this list.")
					_iA2i += 1
			EndWhile	
			
		AddHeaderOption("[" +SetColor(sActLiCo, sActLi)+ "] Actors List")
			oidActStr = MyAddInputOption("Stored Actor Name", SetColor(sActCo, "Edit Me"), "Enter a string/name to store in the list as this actor's name. This string will only be seen by DDe and only for this actor list. Set it to blank [] to reset it to the default name.\n[+something] - will append 'something' at the end of the existing text. " +sStrUIe)
				DisplayStr(sPre = (" " +(iActIdx + 1)+ ". "), sStr = sActStr, sVal = "", sDes = sStrDes, iLinChaMax = iSUmMCM.iLinChaMax, sCol = sActCo, sSub = sActInf)
		AddHeaderOption(" ", Option_Flag_Disabled)
			oidActSelAdd = MyAddTextOption(" Store Actor", SetColor(sActCo, sSelActor), "Actor ID - > [" +aSelActor+ "].\nStore [" +sSelActor+ "] to [" +sActLi+ "] actor list.")
		AddHeaderOption("  Stored Actors", Option_Flag_Disabled)
			MyAddTextOption("  Total Actors ", iActMax, "  Total number of actors in [" +sActLi+ "] list.")
			oidActPg = MyAddSliderOption("  Go To Page No. ", _iL1P, 1, _iL1Ps, 1, 1, "{0}", "Choose a page number.")	
		AddHeaderOption("   Page No. " +_iL1P, Option_Flag_Disabled)
			While (_iL1i < _iL1L2)
				sStr1 = JsonUtil.StringListGet(iDDe.sActFoJs, sActLi, _iL1i)
				aActor = (iSUmUtil.GetFormFromStrHex(sStr = sStr1, akFail = None, sLabel = "Form") AS Actor)
				sActor = iSUmUtil.StrSlice(sStr = sStr1, sSt = "Name=|", sEn = "|,", sFail = "", sRem = "", idx = 0)
				sInfo = iSUmUtil.StrSlice(sStr = sStr1, sSt = "Info=|", sEn = "|,", sFail = "", sRem = "", idx = 0)
					If (!sActor)
						sActor = iSUmUtil.GetFormName(aActor)
					EndIf
				JsonUtil.IntListSet(sJsOID, "ActorsOIDs", _iL1i, MyAddTextOption("   Slot No. " +SetColor(sActCo, ((_iL1i + 1)+ ". "))+ "- > ", SetColor(sActCo, sActor), "Actor ID - > [" +aActor+ "].\nActor Name - > [" +sActor+ "].\nInfo - > [" +sInfo+ "].\nHit this to select this actor."))
				_iL1i += 1
			EndWhile
			
		AddHeaderOption("")
	;Second half of the page
	SetCursorPosition(1)			
		AddHeaderOption("") ;Selected Actor
			oidAutoStoActor = MyAddInputOption("Set Added Actor To Slot", sAutoStoActor, "Enter a slot number where to store the newly added actor.\n[<0] - (negative values), It will append the new actors at the end of the existing list.\n[] - (blank), It will do nothing. You will have to manually store the new actors bellow.\n[>0] - (positive values), will add the new actor to that slot in the list.")
			AddEmptyOption()
			
		AddHeaderOption("");Actor Json Folder/Path
			oidActJson = MyAddInputOption("Json Name", SetColor(sActJsCo, iDDe.sActJson), "[" +iDDe.sActJson+ "] - Current text.\n[iSUmActors] - is the original SUM actor's json name.\n[] - Defaults to iDDeActors.")
			oidActFoJs = MyAddTextOption("Show Current Full Json Path", "Clicky", "Hit this to show the full actor's json path currently entered.")
		AddHeaderOption(" ", Option_Flag_Disabled) ;Existing Actors Json Files
			oidActJsPerPg = MyAddSliderOption(" Jsons Per Page", iActJsPerPg, 2, 66, 4, 1, "{0}", "Choose how many jsons to display per page.")
			MyAddTextOption(" Total Pages", _iA1Ps, "Total number of pages.")
		AddHeaderOption("", Option_Flag_Disabled)
			While (_iA1i < _iA1L)
				oidActJsons[_iA1i] = MyAddTextOption("  " +SetColor(sActJsCo, ((_iA1i + 1)+ ". "))+ "Select [" +SetColor(sActJsCo, sActJsons[_iA1i])+ "]", "", "Hit this to load this file.")
					_iA1i += 1
			EndWhile	
			If (_iA1E)
				AddEmptyOption()
			EndIf		
			
		AddHeaderOption("") ;Actor Lists In
			oidActListRfr = MyAddTextOption("Refresh Actor Lists", "Clicky", "Hit this to refresh the existing actor lists.")
			oidActListDel = MyAddTextOption("Delete Actor List", SetColor(sActLiCo+sActLi), "Delete [" +sActLi+ "].")	
		AddHeaderOption("", Option_Flag_Disabled)
			oidActLiPerPg = MyAddSliderOption("Lists Per Page", iActLiPerPg, 6, 66, 6, 1, "{0}", "Choose how many lists to display per page.")
			MyAddTextOption("Total Pages", _iA2Ps, "Total number of pages.")
		AddHeaderOption("", Option_Flag_Disabled)
			While (_iA2i < _iA2L)
				oidActLists[_iA2i] = MyAddTextOption("  " +SetColor(sActLiCo, ((_iA2i + 1)+ ". "))+ "Load the [" +SetColor(sActLiCo, sActLis[_iA2i])+ "] list.", "", "Hit this to load this list.")
					_iA2i += 1
			EndWhile
			If (_iA2E)
				AddEmptyOption()
			EndIf
							
		AddHeaderOption("") ;Actor List
			oidActInf = MyAddInputOption("Stored Actor Info", SetColor(sActCo, "Edit Me"), "Enter a description to store in the list as this actor's description. This string will only be seen by DDe and only for this actor list.\n[+something] - will append 'something' at the end of the existing text. " +sStrUIe)
				DisplayStr(sPre = (" " +(iActIdx + 1)+ ". "), sStr = sActInf, sVal = "", sDes = sStrDes, iLinChaMax = iSUmMCM.iLinChaMax, sCol = sActCo, sSub = sActStr)
		AddHeaderOption(" ", Option_Flag_Disabled)
			oidDelSelActor = MyAddTextOption("Remove Actor", SetColor(sActCo, sSelActor), "Actor ID - > [" +aSelActor+ "].\nRemove [" +sSelActor+ "] from [" +sActLi+ "] actor list.")
		AddHeaderOption("", Option_Flag_Disabled) ;Stored Actors
			oidActPerPg = MyAddSliderOption("Actors Per Page", iActPerPg, 6, 66, 22, 1, "{0}", "Choose how many actors to display per page.")
			MyAddTextOption("Total Pages", _iL1Ps, "Total number of pages.")
		AddHeaderOption("", Option_Flag_Disabled) ;Page No.
			While (_iL1i < _iL1L)
				sStr1 = JsonUtil.StringListGet(iDDe.sActFoJs, sActLi, _iL1i)
				aActor = (iSUmUtil.GetFormFromStrHex(sStr = sStr1, akFail = None, sLabel = "Form") AS Actor)
				sActor = iSUmUtil.StrSlice(sStr = sStr1, sSt = "Name=|", sEn = "|,", sFail = "", sRem = "", idx = 0)
				sInfo = iSUmUtil.StrSlice(sStr = sStr1, sSt = "Info=|", sEn = "|,", sFail = "", sRem = "", idx = 0)
					If (!sActor)
						sActor = iSUmUtil.GetFormName(aActor)
					EndIf
				JsonUtil.IntListSet(sJsOID, "ActorsOIDs", _iL1i, MyAddTextOption("   Slot No. " +SetColor(sActCo, ((_iL1i + 1)+ ". "))+ "- > ", SetColor(sActCo, sActor), "Actor ID - > [" +aActor+ "].\nActor Name - > [" +sActor+ "].\nInfo - > [" +sInfo+ "].\nHit this to select this actor."))
				_iL1i += 1
			EndWhile	
			If (_iL1E)
				AddEmptyOption()
			EndIf	
			
		AddHeaderOption("")         		
	ElseIf (asPage == Pages[3])	;Device Interaction
	;Device Interaction Page
	;ddddddddddddddddddddddddddddddddddddddddddddddd
		SetDeviceIntPgOIDs()
		BOOL bDDeBusy = StorageUtil.GetIntValue(aSelActor, "iDDeBusy", 0) 
		INT iMcmReady = iDDe.iDDeIsActorMcmReady(aSelActor) 
		STRING sLockMod = iDDe.iDDeGetLockingMod(aSelActor, True)
		STRING sName = ""
			iWornDDs = iDDe.iDDeHasWornDDs(aSelActor)
			;iWornDDs = iDDe.ListWornDDsRen(aSlave = aSelActor) ;Too slow
			JsonUtil.IntListClear(sJsOID, "WornDevOIDs") 
				If (iWornDDs > 0)
					JsonUtil.IntListResize(sJsOID, "WornDevOIDs", SetUpStorStrL1(akForm = aSelActor, sList = iDDeLib.sDDeOutMisc[6])) 
				Else
					_iL1E = 0
					_iL1L = 0
					bRefrDDs = True
					iDDe.SetStoUtilCurOutfit(aSlave = aSelActor, sOutfit = "", iSet = -1)
				EndIf
		STRING sOutPre = iDDe.GetStoUtilPreOutfit(aSlave = aSelActor, sOutfit = "")
			sDDeOutEqp = iDDe.GetStoUtilCurOutfit(aSlave = aSelActor, sOutfit = "")
				If (StringUtil.Find(sDDeOutEqp, "iDDe") == 0)
					sStr1 = SetColor(sOutLoCo, sDDeOutEqp)
				Else
					sStr1 = SetColor(sOutCo, sDDeOutEqp)
				EndIf
				If (StringUtil.Find(sOutPre, "iDDe") == 0)
					sStr2 = SetColor(sOutLoCo, sOutPre)
				Else
					sStr2 = SetColor(sOutCo, sOutPre)
				EndIf
	;ddddddddddddddddddddddddddddddddddddddddddddddd 
			If (aSelActor) 
				If (bDDeBusy)
					AddHeaderOption("Manipulate Outfit")
						MyAddTextOption("iDDe Is Working On   ->  [" +SetColor(sActCo, sSelActor)+ "]", "", "Devious Devices - Equip is busy!")
						ForcePageReset()
					
					AddHeaderOption("")
				;Second half of the page
				SetCursorPosition(1) 
					AddHeaderOption("") ;Manipulate Outfit
						MyAddTextOption(" Please Stand By", "", "DDe is busy!")	
					
					AddHeaderOption("")
				ElseIf ((iDDe.iDDeHardCore) && (iWornDDs > 0))
					AddHeaderOption("Manipulate Outfit")
						MyAddTextOption("HardCore Mode Enabled", "", "Devious devices interaction is disabled for hardcore users.\nNo easy escape for you!\nNo safeword either!\nOnly keys can help you now!.\nSelected actor is [" +sSelActor+ "].")
					AddHeaderOption("")
						oidEqpMCM = MyAddTextOption("Equip MCM Outfit To ", SetColor(sActCo, sSelActor), "Hit this to equip the existing MCM outfit to [" +sSelActor+ "].")
					
					AddHeaderOption("")
				;Second half of the page
				SetCursorPosition(1) 
					AddHeaderOption("") 
						AddEmptyOption()
					
					AddHeaderOption("")
				ElseIf (iMcmReady == 1); Slave is a Beast
					AddHeaderOption("Manipulate Outfit")
						MyAddTextOption("Feature Access Is Locked!", "", "Devious devices interaction is disabled!\n This will unlock itself once [" +sSelActor+ "] reverts back to human form.\nNo easy escape for you!\nNo safeword either!")
					
					AddHeaderOption("")
				;Second half of the page
				SetCursorPosition(1) 
					AddHeaderOption("");Manipulate Outfit
						MyAddTextOption(" [" +SetColor(sActCo, sSelActor)+ "] is a beast!", "", "Devious devices interaction is disabled!\n This will unlock itself once [" +sSelActor+ "] reverts back to human form.\nNo easy escape for you!\nNo safeword either!")
						
					AddHeaderOption("")
				ElseIf (iMcmReady == 2); Slave is a Lord
					AddHeaderOption("Manipulate Outfit")
						MyAddTextOption("Feature Access Is Locked!", "", "Devious devices interaction is disabled!\n This will unlock itself once [" +sSelActor+ "] reverts back to human form.\nNo easy escape for you!\nNo safeword either!")
					
					AddHeaderOption("")
				;Second half of the page
				SetCursorPosition(1)
					AddHeaderOption("");Manipulate Outfit
						MyAddTextOption(" [" +SetColor(sActCo, sSelActor)+ "] is a Vampire Lord! ", "", "Devious devices interaction is disabled!\n This will unlock itself once " +sSelActor+ " reverts back to human form.\nNo easy escape for you!\nNo safeword either!")
					
					AddHeaderOption("")
				ElseIf ((sLockMod != "Unlocked") && (iWornDDs > 0)) ;Locked
					;uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu
						;iWornDDs = iDDe.iDDeHasWornDDs(aSelActor)
						iDDe.ListWornDDeStrKwds(aSlave = aSelActor, sList = "iDDeWornDDs_sKwd")
						FLOAT fTimeLeft = (StorageUtil.GetFloatValue(aSelActor, "iDDefSelfBondEnd", 0) - Game.GetRealHoursPassed()) 
							SetUpStorStrL1(akForm = aSelActor, sList = "iDDeLockingMods")
							SetUpStorStrL2(akForm = aSelActor, sList = "iDDeWornDDs_sKwd")
					;uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu
						AddHeaderOption("DDe Equipped Outfit") ;1
							If (sDDeOutEqp)	
								oidEqpOutCur = MyAddTextOption("Re-Equip Current [" +sStr1+ "] To [" +SetColor(sActCo, sSelActor)+ "]", "", "Hit this to re-equip [" +sDDeOutEqp+ "] equipped outfit on [" +sSelActor+ "].")
							Else
								AddTextOption("No Outfit Equipped", "")
							EndIf
							If (sOutPre)	
								oidEqpOutPre = MyAddTextOption("Re-Equip Previous [" +sStr2+ "] To [" +SetColor(sActCo, sSelActor)+ "]", "", "Hit this to re-equip [" +sOutPre+ "] on [" +sSelActor+ "].")
							Else
								AddTextOption("No Previous Outfit On File", "")
							EndIf	
						AddHeaderOption("Manipulate Outfit") ;2
							If (sLockMod == "DDe Self Bondage Session") 
								AddHeaderOption("[" +SetColor(sActCo, sSelActor)+ "]'s Self Bondage Session")
									If (fTimeLeft > 0.0) 
										MyAddTextOption("No, Not Yet!", "", "Not yet!")	
									Else
										oidRemOutfit = MyAddTextOption("Finally!", "", "Time's up, you can now remove the devices.\nHit the above to remove the items.")
										aSelActor.SendModEvent("iDDeLock", "DDe Self Bondage Session", -1)
									EndIf
							Else
								AddHeaderOption("Features Disabled By The Following Mods")
									While (_iL1i < _iL1L2)
										MyAddTextOption(" " +(_iL1i + 1)+ ". " +StorageUtil.StringListGet(aSelActor, "iDDeLockingMods", _iL1i), "", "Mod currently locking DDe.\nThe removal of devious devices is blocked!\nThis will unlock itself once all DDs have been removed off [" +sSelActor+ "], or there are 0 (zero) mods locking out DDe!")
										_iL1i += 1
									EndWhile
								AddHeaderOption("Worn Restraits Keywords")
									While (_iL2i < _iL2L2)
										MyAddTextOption(" " +(_iL2i + 1)+ ". " +StorageUtil.StringListGet(aSelActor, "iDDeWornDDs_sKwd", _iL2i), "", "The device with this keyword needs to be removed off [" +sSelActor+ "] before proceding further!")
										_iL2i += 1
									EndWhile
							EndIf
							
						AddHeaderOption("")	;End
					;Second half of the page
					SetCursorPosition(1)
						AddHeaderOption("Library Outfit") ;1
							oidOutClearMCM = MyAddTextOption("Clear Library Outfit", "", "Hit this to clear the library outfit.")
							oidEqpMCM = MyAddTextOption("Equip MCM Outfit To [" +SetColor(sActCo, sSelActor)+ "]", "", "Hit this to equip the existing MCM outfit to [" +sSelActor+ "].")
						AddHeaderOption("") ;Manipulate Outfit ;2
							If (sLockMod == "DDe Self Bondage Session") 
								AddHeaderOption("", Option_Flag_Disabled) ;Self Bondage Session
									If (fTimeLeft > 0)	
										MyAddTextOption(" Time Left", iSUmUtil.SecToTime(sSec = iSUmUtil.MathStrAsStr(sStr1 = fTimeLeft, sOpr = "*", sStr2 = "3600.0")), "Not yet!")
									Else
										AddEmptyOption()
									EndIf
							Else
								AddHeaderOption("") ;Features Disabled By The Following Mods
									While (_iL1i < _iL1L)
										MyAddTextOption(" " +(_iL1i + 1)+ ". " +StorageUtil.StringListGet(aSelActor, "iDDeLockingMods", _iL1i), "", "Mod currently locking DDe.\nThe removal of devious devices is blocked!\nThis will unlock itself once all DDs have been removed off [" +sSelActor+ "], or there are 0 (zero) mods locking out DDe!")
										_iL1i += 1
									EndWhile
									If (_iL1E)
										AddEmptyOption()
									EndIf	
								AddHeaderOption("") ;Worn Restraits Keywords
									While (_iL2i < _iL2L)
										MyAddTextOption(" " +(_iL2i + 1)+ ". " +StorageUtil.StringListGet(aSelActor, "iDDeWornDDs_sKwd", _iL2i), "", "The device with this keyword needs to be removed off [" +sSelActor+ "] before proceding further!")
										_iL2i += 1
									EndWhile
									If (_iL2E)
										AddEmptyOption()
									EndIf	
							EndIf
							
						AddHeaderOption("")	;End
				Else
				;mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
					StorageUtil.UnSetFloatValue(aSelActor, "iDDefSelfBondEnd")
						If ((sLockMod != "Unlocked"))
							iDDe.iDDeGetLockingMod(aSelActor, False)
						EndIf
				;mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
						AddHeaderOption("DDe Equipped Outfit") ;1
							If (sDDeOutEqp)	
								oidEqpOutCur = MyAddTextOption("Re-Equip Current [" +sStr1+ "] To [" +SetColor(sActCo, sSelActor)+ "]", "", "Hit this to re-equip [" +sDDeOutEqp+ "] equipped outfit on [" +sSelActor+ "].")
							Else
								AddTextOption("No Outfit Equipped", "")
							EndIf
							If (sOutPre)	
								oidEqpOutPre = MyAddTextOption("Re-Equip Previous [" +sStr2+ "] To [" +SetColor(sActCo, sSelActor)+ "]", "", "Hit this to re-equip [" +sOutPre+ "] on [" +sSelActor+ "].")
							Else
								AddTextOption("No Previous Outfit On File", "")
							EndIf	
							If (sDDeOutEqp) 
								oidRemOutfit = MyAddTextOption("Remove [" +sStr1+ "] From [" +SetColor(sActCo, sSelActor)+ "]", "", "Hit this to remove [" +sDDeOutEqp+ "] from [" +sSelActor+ "].")
							Else
								AddTextOption("No Outfit To Remove", "")
							EndIf	
							oidRemExisting = MyAddTextOption("Remove All DDs From [" +SetColor(sActCo, sSelActor)+ "]", "", "Hit this to remove ALL existing DDs from " +sSelActor)
							
						AddHeaderOption("Loaded " +sLocOut)	;2
							oidOutLocEdit = MyAddInputOption(sLocOut, SetColor(sOutLoCo, "Edit Me"), "Edit the " +sLocOut+ " below.\n[Outfit01,Outfit02,Outfit03] - If inside square brackets, it will pick a random outfit. (MyList) - If inside parenthesis, it will pick a random outfit from the string .json list with that name 'MyList' from the DDe [" +GetPathFolder(sPath = "Glo", sFolder = "Strings")+sOutLiJson+ "] file. Otherwise, it assumes a single outfit name and it works like before, I.E. iDDeOutDrAny.")	
								DisplayOutArray(sPre = " ", sStr = sDDeOutLoc, sCo = sLocCol, sOut = sLocOut, iChaMax = iSUmMCM.iLinChaMax, sSub = sDDeOutCus)
							If (sDDeOutLoc)
								oidEqpOutfit = MyAddTextOption("Equip The Loaded " +sLocOut+ " To [" +SetColor(sActCo, sSelActor)+ "]", "", "Hit this to equip" +sLocEqp+ " the [" +sDDeOutLoc+ "] " +sLocOut+ " to [" +sSelActor+ "].")
							Else
								AddTextOption("Load an Outfit First", "")
							EndIf
								
						AddHeaderOption("Self Bondage (Loaded " +sLocOut+ ")") ;3
							oidSelfTimer = MyAddSliderOption("Bondage Duration.", StorageUtil.GetFloatValue(aSelActor, "iDDefSelfTimer", 0), 1, 1000, 30, 1, "{0} Minutes", "Self-bondage timer.\nActual real time.\nUses the loaded [" +sLocOut+ "]")
							
						AddHeaderOption("Equipped Devices") ;4
							If (iWornDDs > 0)
								oidRefrDDsList = MyAddTextOption("Refresh Worn DD List for ", SetColor(sActCo, sSelActor), "Hit this to refresh the list of devious devices worn by [" +sSelActor+ "].")
							Else
								MyAddTextOption("[" +SetColor(sActCo, sSelActor)+ "] Is Not Wearing Any DDs", "", "[" +sSelActor+ "] Is Not Wearing Any DDs.")
							EndIf 
						AddHeaderOption(" ", Option_Flag_Disabled)
							While (_iL1L && (_iL1i < _iL1L2))
								sName = iSUmUtil.StrSlice(sStr = StorageUtil.StringListGet(aSelActor, iDDeLib.sDDeOutMisc[6], _iL1i), sSt = "Name=|", sEn = "|,", sFail = "No Name", sRem = "", idx = 0)
								JsonUtil.IntListSet(sJsOID, "WornDevOIDs", _iL1i, MyAddTextOption(" " +(_iL1i + 1)+ ". Remove -> " +sName, "", "Worn device.\nHit this to remove the device."))
								_iL1i += 1
							EndWhile
							
						AddHeaderOption("")	;End
					;Second half of the page
					SetCursorPosition(1)
						AddHeaderOption("Library Outfit") ;1
							oidEqpMCM = MyAddTextOption("Equip MCM Outfit To [" +SetColor(sActCo, sSelActor)+ "]", "", "Hit this to equip the existing MCM (Device Library) outfit to [" +sSelActor+ "].")
							oidRemMCM = MyAddTextOption("Remove MCM Outfit From [" +SetColor(sActCo, sSelActor)+ "]", "", "Hit this to remove existing MCM (Device Library) outfit from [" +sSelActor+ "].")
							oidOutClearMCM = MyAddTextOption("Clear MCM Outfit", "", "Hit this to clear the library outfit.")
							AddEmptyOption()
							
						AddHeaderOption("Custom " +sCusOut) ;2
							oidOutCusEdit = MyAddInputOption(sCusOut, SetColor(sOutCo, "Edit Me"), "Edit the custom " +sCusOut+ " below.\nIf inside [] it will be treated as an array and it will pick a random outfit. If iside () it will be treated as an .json string list name and will pick a random outfit from the given list name in the DDe [" +GetPathFolder(sPath = "Glo", sFolder = "Strings")+sOutLiJson+ "] file. If just a single outfit name, it will work like before by equipping that outfit.")
								DisplayOutArray(sPre = " ", sStr = sDDeOutCus, sCo = sCusCol, sOut = sCusOut, iChaMax = iSUmMCM.iLinChaMax, sSub = sDDeOutLoc)
							If (sDDeOutCus)	
								oidEqpCust = MyAddTextOption("Equip Custom " +sCusOut+ " To [" +SetColor(sActCo, sSelActor)+ "]", "", "Hit this to equip" +sCusEqp+ " the [" +sDDeOutCus+ "] " +sCusOut+ " to [" +sSelActor+ "].")
							Else
									AddTextOption("Load an Custom Outfit First", "")
							EndIf
						
						AddHeaderOption("");Self Bondage ;3
							oidSelfBondStart = MyAddTextOption("Start The Self Bondage Session", "", "Hit this to start.\nMake sure you have loaded an outfit first.\nDidn't set that timmer too high... did ya?")
								
						AddHeaderOption("") ;Equipped Devices ;4
							If (!bRefrDDs)
								MyAddTextOption(SetColor(sBadCo, "List Is Not Current"), "", "Hit the left to refresh the worn DDs list, for [" +sSelActor+ "].")	
							Else
								AddEmptyOption()
								bRefrDDs = False
							EndIf
						AddHeaderOption("", Option_Flag_Disabled)
							While (_iL1L && (_iL1i < _iL1L))
								sName = iSUmUtil.StrSlice(sStr = StorageUtil.StringListGet(aSelActor, iDDeLib.sDDeOutMisc[6], _iL1i), sSt = "Name=|", sEn = "|,", sFail = "No Name", sRem = "", idx = 0)
								JsonUtil.IntListSet(sJsOID, "WornDevOIDs", _iL1i, MyAddTextOption(" " +(_iL1i + 1)+ ". Remove -> " +sName, "", "Worn device.\nHit this to remove the device."))
								_iL1i += 1
							EndWhile
							If (_iL1E)
								AddEmptyOption()
							EndIf	
							
						AddHeaderOption("")	;End	
				EndIf
			Else
				AddHeaderOption("Manipulate Outfit")
					MyAddTextOption("No Actor Has Been Selected", "", "Switch to 'Actor Selection' page and select an actor for this bondage session.")
				
				AddHeaderOption("")
				;Second half of the page
				SetCursorPosition(1) 
					AddHeaderOption("") 
						AddEmptyOption()
					
					AddHeaderOption("")
			EndIf
	ElseIf (asPage == Pages[4]) ;Device Library
	;Devices Library Page
	;lllllllllllllllllllllllllllllllllllllllllllllll
	;lllllllllllllllllllllllllllllllllllllllllllllll
		AddHeaderOption("Gag Options") ;1
			oidDDeGag = MyAddMenuOption("DDe Gag", iDDe.iDDeGag, iDDeLib.sDDeGags, 0, "Use this to choose a DDe gag.") 
			oidDDxGag = MyAddMenuOption("DDx Gag", iDDe.iDDxGag, iDDeLib.sDDxGags, 0, "Use this to choose a DDx gag.") 
		
		AddHeaderOption("Collar Options") ;2
			oidDDeCollar = MyAddMenuOption("DDe Collar", iDDe.iDDeCollar, iDDeLib.sDDeCollars, 0, "Use this to choose a DDe collar.") 
			oidDDxCollar = MyAddMenuOption("DDx Collar", iDDe.iDDxCollar, iDDeLib.sDDxCollars, 0, "Use this to choose a DDx collar.")
				If (iDDe.bCD)
					oidCDxCollar = MyAddMenuOption("CD Collar ", iDDe.iCDxCollar, iDDeLib.sCDxCollars, 0, "Use this to choose a CD collar.\nCDQ = Quest item!") 
				Else
					MyAddTextOption("CD Not Installed", "", "", Option_Flag_Disabled)
				EndIf
		
		AddHeaderOption("Vaginal Piercing Options") ;3
			oidDDxPieV = MyAddMenuOption("DDx Vaginal Piercing", iDDe.iDDxPieV, iDDeLib.sDDxPieV, 0, "Use this to choose a DDx vaginal piercing.")
		
		AddHeaderOption("Chastity Belt Options") ;4
			oidDDeBelt = MyAddMenuOption("DDe Belt ", iDDe.iDDeBelt, iDDeLib.sDDeBelts, 0, "Use this to choose a DDe belt.")
			oidDDxBelt = MyAddMenuOption("DDx Belt ", iDDe.iDDxBelt, iDDeLib.sDDxBelts, 0, "Use this to choose a DDx belt.")
				If (iDDe.bCD)
					oidCDxBelt = MyAddMenuOption("CD Belt ", iDDe.iCDxBelt, iDDeLib.sCDxBelts, 0, "Use this to choose a CD belt.\nCDQ = Quest item!")
				Else
					MyAddTextOption("CD Not Installed", "", "", Option_Flag_Disabled)
				EndIf
		
		AddHeaderOption("Vaginal Plug Options")	;5
			oidDDePlugV = MyAddMenuOption("DDe Vaginal Plug", iDDe.iDDePlugV, iDDeLib.sDDePlugsV, 0, "Use this to choose a DDe vaginal plug.")
			oidDDxPlugV = MyAddMenuOption("DDx Vaginal Plug", iDDe.iDDxPlugV, iDDeLib.sDDxPlugsV, 0, "Use this to choose a DDx vaginal plug.")
				If (iDDe.bCD)
					oidCDxPlugV = MyAddMenuOption("CD Vaginal Plug", iDDe.iCDxPlugV, iDDeLib.sCDxPlugsV, 0, "Use this to choose a CD vaginal plug.")
		 		Else
					MyAddTextOption("CD Not Installed", "", "", Option_Flag_Disabled)
				EndIf
		
		AddHeaderOption("Footwear Options") ;6
			oidDDeBoots = MyAddMenuOption("DDe Boots", iDDe.iDDeBoots, iDDeLib.sDDeBoots, 0, "Use this to choose DDe boots.")
			oidDDxBoots = MyAddMenuOption("DDx Boots", iDDe.iDDxBoots, iDDeLib.sDDxBoots, 0, "Use this to choose DDx boots.")
			
		AddHeaderOption("Leg Options") ;7
			oidDDeCuffsL = MyAddMenuOption("DDe Leg Cuffs", iDDe.iDDeCuffsL, iDDeLib.sDDeCuffsL, 0, "Use this to choose DDe leg cuffs.") 
			oidDDxCuffsL = MyAddMenuOption("DDx Leg Cuffs", iDDe.iDDxCuffsL, iDDeLib.sDDxCuffsL, 0, "Use this to choose DDx leg cuffs.")
				If (iDDe.bCD)
					oidCDxCuffsL = MyAddMenuOption("CD Leg Cuffs", iDDe.iCDxCuffsL, iDDeLib.sCDxCuffsL, 0, "Use this to choose CD leg cuffs.\nCDQ = Quest item!")
				Else
					MyAddTextOption("CD Not Installed", "", "", Option_Flag_Disabled)
				EndIf
				
		AddHeaderOption("Heavy Bondage") ;8
			oidDDeElbowBinder = MyAddMenuOption("DDe Elbowbinder", iDDe.iDDeElbowBinder, iDDeLib.sDDeElbowBinders, 0, "Use this to choose the DDe Elbowbinder.")
			oidDDxElbowBinder = MyAddMenuOption("DDx Elbowbinder", iDDe.iDDxElbowBinder, iDDeLib.sDDxElbowBinders, 0, "Use this to choose the DDx Elbowbinder.")
			oidDDeBoxBinder = MyAddMenuOption("DDe Boxbinder", iDDe.iDDeBoxBinder, iDDeLib.sDDeBoxBinders, 0, "Use this to choose the DDe Boxbinder.")
			oidDDxBoxBinder = MyAddMenuOption("DDx Boxbinder", iDDe.iDDxBoxBinder, iDDeLib.sDDxBoxBinders, 0, "Use this to choose the DDx Boxbinder.")
			oidDDeBoxBinderOut = MyAddMenuOption("DDe Boxbinder Outfit", iDDe.iDDeBoxBinderOut, iDDeLib.sDDeBoxBinderOuts, 0, "Use this to choose the DDe Boxbinder Outfit.")
			oidDDxBoxBinderOut = MyAddMenuOption("DDx Boxbinder Outfit", iDDe.iDDxBoxBinderOut, iDDeLib.sDDxBoxBinderOuts, 0, "Use this to choose the DDx Boxbinder Outfit.")
			oidDDeShackles = MyAddMenuOption("DDe Shackles", iDDe.iDDeShackles, iDDeLib.sDDeShackles, 0, "Use this to choose the DDe Shackles.")
			oidDDxShackles = MyAddMenuOption("DDx Shackles", iDDe.iDDxShackles, iDDeLib.sDDxShackles, 0, "Use this to choose the DDx Shackles.")
				
		AddHeaderOption("Dress Options") ;9
			oidDDeSuit = MyAddMenuOption("DDe Dress", iDDe.iDDeSuit, iDDeLib.sDDeSuits, 0, "Use this to choose a DDe suit/dress.")
			oidDDxSuit = MyAddMenuOption("DDx Dress", iDDe.iDDxSuit, iDDeLib.sDDxSuits, 0, "Use this to choose a DDx suit/dress.")	
			AddEmptyOption()
			
		AddHeaderOption("Mech Options") ;10
			oidDDeMech = MyAddMenuOption("DDe Mech", iDDe.iDDeMech, iDDeLib.sDDeMech, 0, "Use this to choose a DDe Mech.")
			AddEmptyOption()
			
		AddHeaderOption("")
	;Second half of the page			 
	SetCursorPosition(1)
		AddHeaderOption("Hood Options") ;1
			oidDDeHood = MyAddMenuOption("DDe Hood", iDDe.iDDeHood, iDDeLib.sDDeHoods, 0, "Use this to choose a DDe hood.\nThis will ocupy the gag slot.") 
			oidDDxHood = MyAddMenuOption("DDx Hood", iDDe.iDDxHood, iDDeLib.sDDxHoods, 0, "Use this to choose a DDx hood.") 
		 	
		AddHeaderOption("Blindfold Options") ;2
			oidDDeBlindFold = MyAddMenuOption("DDe Blindfold ", iDDe.iDDeBlind, iDDeLib.sDDeBlindFolds, 0, "Use this to choose a DDe blindfold.")
			oidDDxBlindFold = MyAddMenuOption("DDx Blindfold ", iDDe.iDDxBlind, iDDeLib.sDDxBlindFolds, 0, "Use this to choose a DDx blindfold.")
			AddEmptyOption()
			
		AddHeaderOption("Nipple Piercing Options") ;3
			oidDDxPieN = MyAddMenuOption("DDx Nipple Piercing", iDDe.iDDxPieN, iDDeLib.sDDxPieN, 0, "Use this to choose a DDx nipple piercings.") 
			 	
		AddHeaderOption("Bra Options") ;4
			oidDDeBra = MyAddMenuOption("DDe Bra ", iDDe.iDDeBra, iDDeLib.sDDeBras, 0, "Use this to choose a DDe bra.") 	 
			oidDDxBra = MyAddMenuOption("DDx Bra ", iDDe.iDDxBra, iDDeLib.sDDxBras, 0, "Use this to choose a DDx bra.")
				If (iDDe.bCD)
					oidCDxBra = MyAddMenuOption("CD Bra", iDDe.iCDxBra, iDDeLib.sCDxBras, 0, "Use this to choose a CD bra.\nCDQ = Quest item!") 
				Else
					MyAddTextOption("CD Not Installed", "", "", Option_Flag_Disabled)
				EndIf
			
		AddHeaderOption("Anal Plug Options") ;5	
			oidDDePlugA = MyAddMenuOption("DDe Anal Plug", iDDe.iDDePlugA, iDDeLib.sDDePlugsA, 0, "Use this to choose a DDe anal plug.")	
			oidDDxPlugA = MyAddMenuOption("DDx Anal Plug", iDDe.iDDxPlugA, iDDeLib.sDDxPlugsA, 0, "Use this to choose a DDx anal plug.")
				If (iDDe.bCD)
					oidCDxPlugA = MyAddMenuOption("CD Anal Plug", iDDe.iCDxPlugA, iDDeLib.sCDxPlugsA, 0, "Use this to choose a CD anal plug.")
				Else
					MyAddTextOption("CD Not Installed", "", "", Option_Flag_Disabled)
				EndIf
		
		AddHeaderOption("Gloves Options") ;6
			oidDDeGloves = MyAddMenuOption("DDe Gloves", iDDe.iDDeGloves, iDDeLib.sDDeGloves, 0, "Use this to choose DDe gloves.")
			oidDDxGloves = MyAddMenuOption("DDx Gloves", iDDe.iDDxGloves, iDDeLib.sDDxGloves, 0, "Use this to choose DDx gloves.")
			
		AddHeaderOption("Arm Options") ;7
			oidDDeCuffsA = MyAddMenuOption("DDe Arm Cuffs", iDDe.iDDeCuffsA, iDDeLib.sDDeCuffsA, 0, "Use this to choose DDe arm cuffs.")
			oidDDxCuffsA = MyAddMenuOption("DDx Arm Cuffs", iDDe.iDDxCuffsA, iDDeLib.sDDxCuffsA, 0, "Use this to choose DDx arm cuffs.")  	
				If (iDDe.bCD)
					oidCDxCuffsA = MyAddMenuOption("CD Arm Cuffs", iDDe.iCDxCuffsA, iDDeLib.sCDxCuffsA, 0, "Use this to choose CD arm cuffs.\nCDQ = Quest item!")
				Else
					MyAddTextOption("CD Not Installed", "", "", Option_Flag_Disabled)
				EndIf
		
		AddHeaderOption("Heavy Bondage") ;8
			oidDDeArmBinder = MyAddMenuOption("DDe ArmBinder", iDDe.iDDeArmBinder, iDDeLib.sDDeArmBinders, 0, "Use this to choose the DDe ArmBinder.")
			oidDDxArmBinder = MyAddMenuOption("DDx ArmBinder", iDDe.iDDxArmBinder, iDDeLib.sDDxArmBinders, 0, "Use this to choose the DDx ArmBinder.")
			oidDDeYoke = MyAddMenuOption("DDe Yoke", iDDe.iDDeYoke, iDDeLib.sDDeYokes, 0, "Use this to choose the DDe Yoke.")
			oidDDxYoke = MyAddMenuOption("DDx Yoke", iDDe.iDDxYoke, iDDeLib.sDDxYokes, 0, "Use this to choose the DDx Yoke.")
			oidDDePetSuit = MyAddMenuOption("DDe Pet Suit", iDDe.iDDePetSuit, iDDeLib.sDDePetSuits, 0, "Use this to choose the DDe Pet Suit.")
			oidDDxPetSuit = MyAddMenuOption("DDx Pet Suit", iDDe.iDDxPetSuit, iDDeLib.sDDxPetSuits, 0, "Use this to choose the DDx Pet Suit.")
			AddEmptyOption()
			AddEmptyOption()
			
		AddHeaderOption("Body Options") ;9
			oidDDeHarness = MyAddMenuOption("DDe Harness", iDDe.iDDeHarness, iDDeLib.sDDeHarness, 0, "Use this to choose a DDe harness.")
			oidDDxHarness = MyAddMenuOption("DDx Harness", iDDe.iDDxHarness, iDDeLib.sDDxHarness, 0, "Use this to choose a DDx harness.")
			oidDDxCorset = MyAddMenuOption("DDx Corset", iDDe.iDDxCorset, iDDeLib.sDDxCorsets, 0, "Use this to choose a DDx corset.") 
		
		AddHeaderOption("CatSuit Options") ;10
			oidDDeCatSuit = MyAddMenuOption("DDe CatSuit", iDDe.iDDeCatSuit, iDDeLib.sDDeCatSuits, 0, "Use this to choose a DDe CatSuit.")
			oidDDxCatSuit = MyAddMenuOption("DDx CatSuit", iDDe.iDDxCatSuit, iDDeLib.sDDxCatSuits, 0, "Use this to choose a DDx CatSuit.")
		
		AddHeaderOption("")
	ElseIf (asPage == Pages[5]) ;Device Options
	;Devices Options
	;eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
		SetDeviceOptsPgOIDs()
		INT iBin = 0
		INT iBinMax = oidPickBinder.Length
		INT iSui = 0
		INT iSuiMax = oidPickSuit.Length
		INT iGag = 0
		INT iGagMax = oidPickGag.Length
		INT iHood = 0
		INT iHoodMax = oidPickHood.Length
		INT iBli = 0
		INT iBliMax = oidPickBlinder.Length
		INT iCol = 0
		INT iColMax = oidPickCollar.Length
		INT iGlo = 0
		INT iGloMax = oidPickGloves.Length
		INT iBoo = 0
		INT iBooMax = oidPickBoots.Length
		INT iBel = 0
		INT iBelMax = oidPickBelt.Length
		INT iHar = 0
		INT iHarMax = oidPickHarn.Length
		INT iPla = 0
		INT iPlaMax = oidPickPlugA.Length
		INT iPlv = 0
		INT iPlvMax = oidPickPlugV.Length
		INT iPieV = 0
		INT iPieVMax = oidPickPieV.Length
		INT iPieN = 0
		INT iPieNMax = oidPickPieN.Length
		INT iCufA = 0
		INT iCufAMax = oidPickCuffsA.Length
		INT iCufL = 0
		INT iCufLMax = oidPickCuffsL.Length
		INT iBra = 0
		INT iBraMax = oidPickBra.Length
	;eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
		SetTitleText(Pages[5]+ " Page No. " +iDevOptsPg)
		AddHeaderOption("Device Options Page No. " +iDevOptsPg)
			oidDevOptsPg = MyAddSliderOption("Go To Page No. ", iDevOptsPg, 1, 2, 1, 1, "{0}", "Choose a page number.")		
			If (iDevOptsPg == 1)
				AddHeaderOption(" Heavy Bondage")
					While (iBin < Math.Ceiling((iBinMax AS FLOAT) / 2))
						oidPickBinder[iBin] = MyAddToggleOption(sPickBinder[iBin]+ " ", iPickBinder[iBin], 1, "When checked - the " +sPickBinder[iBin]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iBin += 1
					EndWhile
				AddHeaderOption("  Heavy Bondage Options", Option_Flag_Disabled)
					oidBlockActArm = MyAddToggleOption(" Block Obj. Activation", iDDe.iDDeBlockActArm, 1, "When checked - you can't activate objects that do not make sense while in heavy bondage.", iDisabled)
				AddHeaderOption("  Heavy Bondage Effects", Option_Flag_Disabled)
					oidBinderEff = MyAddMenuOption("Effects Applied", iDDe.iDDeBinderEff, sBinderEff, 1, "Here you can choose which effects from bellow will be applied with the heavy bondage.\n[Disabled] - No effects will be applied on heavy bondage equip. All heavy bondage will function normally.\n[DDe Only] - Only heavy bondage added by DDe will have the effects applied.\n[All] - All heavy bondage will have the effects.\nCannot change this option while [" +sSelActor+ "] has ANY devious devices on.", iDisabled)
				AddHeaderOption(" ", Option_Flag_Disabled)
					oidArmFight = MyAddToggleOption("  Disable Fighting", iDDe.iDDeArmFight, 1, "When checked - fighting is disabled while in heavy bondage.", iDisabled)
					oidArmSneak = MyAddToggleOption("  Disable Sneaking", iDDe.iDDeArmSneak, 1, "When checked - sneaking is disabled while in heavy bondage.", iDisabled)
					oidArmMenu = MyAddToggleOption("  Disable Menu", iDDe.iDDeArmMenu, 1, "When checked - menu will not be available while in heavy bondage.", iDisabled)
					oidArmTalk = MyAddToggleOption("  Disable Dialog", iDDe.iDDeArmTalk, 1, "When checked - you can't 'talk' your way out of heavy bondage.", iDisabled)
					
				AddHeaderOption(" DDe Plugs")	
					oidPickPlugEff = MyAddMenuOption("Plugs Effects", iDDe.iDDePickPlugEff, sPickPlugEff, 3, "Here you can enable the plugs effects. \nAll Disabled - No effects will be applied.\nCustom - The effects will be applied as per 'Plugs Effects' bellow.\nAll Enabled - All the effects for both plugs will be applied, regardless of the options selected bellow in 'Plugs Effects'.\nCannot change this option while [" +sSelActor+ "] has ANY devious devices on.", iDisabled)
				AddHeaderOption("  Plugs Effects", Option_Flag_Disabled)
					oidPlugRibbed = MyAddMenuOption("  Ribbed For Her Pleasure", iDDe.iDDePlugRibbed, sPlugEff, 2, "The plug is ribbed for her pleasure.\nVibes when doing vertical movements, i.e. jumping, sneaking.", iDisabled)
					oidPlugShocker = MyAddMenuOption("  Shock Her", iDDe.iDDePlugShocker, sPlugEff, 2, "The plug will shock on full arousal and after vibes are over.", iDisabled)
					oidPlugFusStag = MyAddMenuOption("  Shouts Stagger", iDDe.iDDePlugFusStag, sPlugEff, 1, "The plug will stagger user when shouting.", iDisabled)
					oidPlugLinked = MyAddMenuOption("  Effects Linked", iDDe.iDDePlugLinked, sPlugEff, 3, "The plugs effects are linked.", iDisabled)
					oidPlugEleStim = MyAddMenuOption("  Shock Stimulation", iDDe.iDDePlugEleStim, sPlugEff, 3, "The plug will provide electro shock stimulation therapy.", iDisabled)
					oidPlugEdgeRand = MyAddMenuOption("  Edge Randomly", iDDe.iDDePlugEdgeRand, sPlugEff, 2, "The plug will randomly edge the user.", iDisabled)
					oidPlugEdgeOnly = MyAddMenuOption("  Edge Only", iDDe.iDDePlugEdgeOnly, sPlugEff, 0, "The plug will only edge the user, no orgasms.", iDisabled)
					oidPlugPoss = MyAddMenuOption("  Possessed!", iDDe.iDDePlugPoss, sPlugEff, 3, "The plug is possessed.", iDisabled)
					oidPlugTrain = MyAddMenuOption("  Training", iDDe.iDDePlugTrain, sPlugEff, 2, "A docile slave doesn't use magic without master's permission.\nThere will be a test every 7 days.", iDisabled)
					oidPlugVibCast = MyAddMenuOption("  Magically Sensitive", iDDe.iDDePlugVibCast, sPlugEff, 3, "The plug will vibrate on any kind of spell casting.", iDisabled)
					AddEmptyOption()
					
				AddHeaderOption(" Suits")
					While (iSui < Math.Ceiling((iSuiMax AS FLOAT) / 2))
						oidPickSuit[iSui] = MyAddToggleOption(" " +sPickSuit[iSui]+ " ", iPickSuit[iSui], 1, "When checked - the " +sPickSuit[iSui]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iSui += 1
					EndWhile
					
				AddHeaderOption(" Gags")
					While (iGag < Math.Ceiling((iGagMax AS FLOAT) / 2))
						oidPickGag[iGag] = MyAddToggleOption(" " +sPickGag[iGag]+ " ", iPickGag[iGag], 1, "When checked - the " +sPickGag[iGag]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iGag += 1
					EndWhile
					
				AddHeaderOption(" Hoods")
					While (iHood < Math.Ceiling((iHoodMax AS FLOAT) / 2))
						oidPickHood[iHood] = MyAddToggleOption(" " +sPickHood[iHood]+ " ", iPickHood[iHood], 1, "When checked - the " +sPickHood[iHood]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iHood += 1
					EndWhile
				
				AddHeaderOption(" Mecha")
					oidMechPow = MyAddSliderOption(" Mecha Strength", iDDe.iMechPow, 0, 66, 6, 1, "{0}", "Set the mecha strength. It affects the punch strength. [0] - disables this feature.")
				AddHeaderOption(" Mecha Effects", Option_Flag_Disabled)
					oidMechFX = MyAddToggleOption(" Enable FX", iDDe.iDDeMechFX, 1, "When checked - the mecha FX will be active while locked in it.")
					oidMechJump = MyAddToggleOption(" Enable Super Jump", iDDe.iDDeMechJump, 1, "When checked - the mecha will super jump and also eliminate fall damage.")
					oidMechDisarm = MyAddToggleOption(" Enable Disarm Punch", iDDe.iDDeMechDisarm, 1, "When checked - the mecha punch will disarm your opponent.")
					oidMechNoActivate = MyAddToggleOption(" Disable Activate", iDDe.iDDeMechNoActivate, 0, "When checked - the mecha will not activate or pick up objects.", iDisabled)
					oidMechNoFighting = MyAddToggleOption(" Disable Fighting", iDDe.iDDeMechNoFighting, 1, "When checked - the mecha will not fight.", iDisabled)
					oidMechNoMenu = MyAddToggleOption(" Disable Inventory", iDDe.iDDeMechNoMenu, 1, "When checked - the mecha will not allow access to the inventory.", iDisabled)
				
				AddHeaderOption(" Belts")
					While (iBel < Math.Ceiling((iBelMax AS FLOAT) / 2))
						oidPickBelt[iBel] = MyAddToggleOption(" " +sPickBelt[iBel]+ " ", iPickBelt[iBel], 1, "When checked - the " +sPickBelt[iBel]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iBel += 1
					EndWhile
				
				AddHeaderOption(" Harness")
					While (iHar < Math.Ceiling((iHarMax AS FLOAT) / 2))
						oidPickHarn[iHar] = MyAddToggleOption(" " +sPickHarn[iHar]+ " ", iPickHarn[iHar], 1, "When checked - the " +sPickHarn[iHar]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iHar += 1
					EndWhile
						
				AddHeaderOption(" Blindfolds")
					While (iBli < Math.Ceiling((iBliMax AS FLOAT) / 2))
						oidPickBlinder[iBli] = MyAddToggleOption(" " +sPickBlinder[iBli]+ " ", iPickBlinder[iBli], 1, "When checked - the " +sPickBlinder[iBli]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iBli += 1
					EndWhile
				
				AddHeaderOption("")
			Else
				AddHeaderOption(" Collars")
					While (iCol < Math.Ceiling((iColMax AS FLOAT) / 2))
						oidPickCollar[iCol] = MyAddToggleOption(" " +sPickCollar[iCol]+ " ", iPickCollar[iCol], 1, "When checked - the " +sPickCollar[iCol]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iCol += 1
					EndWhile
				
				AddHeaderOption(" Gloves")
					While (iGlo < Math.Ceiling((iGloMax AS FLOAT) / 2))
						oidPickGloves[iGlo] = MyAddToggleOption(" " +sPickGloves[iGlo]+ " ", iPickGloves[iGlo], 1, "When checked - the " +sPickGloves[iGlo]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iGlo += 1
					EndWhile
				AddHeaderOption("  Gloves Options", Option_Flag_Disabled)
					oidBlockActMit = MyAddToggleOption(" Mittens Block Activation", iDDe.iDDeBlockActMit, 1, "When checked - you can't activate objects that do not make sense while in mittens.", iDisabled)
				
				AddHeaderOption(" Anal Plugs")
					While (iPla < Math.Ceiling((iPlaMax AS FLOAT) / 2))
						oidPickPlugA[iPla] = MyAddToggleOption(" " +sPickPlugA[iPla]+ " ", iPickPlugA[iPla], 1, "When checked - the " +sPickPlugA[iPla]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iPla += 1
					EndWhile
				
				AddHeaderOption(" Vaginal Plugs")
					While (iPlv < Math.Ceiling((iPlvMax AS FLOAT) / 2))
						oidPickPlugV[iPlv] = MyAddToggleOption(" " +sPickPlugV[iPlv]+ " ", iPickPlugV[iPlv], 1, "When checked - the " +sPickPlugV[iPlv]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iPlv += 1
					EndWhile
					
				AddHeaderOption(" Vaginal Piercings")
					While (iPieV < Math.Ceiling((iPieVMax AS FLOAT) / 2))
						oidPickPieV[iPieV] = MyAddToggleOption(" " +sPickPieV[iPieV]+ " ", iPickPieV[iPieV], 1, "When checked - the " +sPickPieV[iPieV]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iPieV += 1
					EndWhile
				
				AddHeaderOption(" Nipple Piercings")
					While (iPieN < Math.Ceiling((iPieNMax AS FLOAT) / 2))
						oidPickPieN[iPieN] = MyAddToggleOption(" " +sPickPieN[iPieN]+ " ", iPickPieN[iPieN], 1, "When checked - the " +sPickPieN[iPieN]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iPieN += 1
					EndWhile
				
				AddHeaderOption(" Arm Cuffs")
					While (iCufA < Math.Ceiling((iCufAMax AS FLOAT) / 2))
						oidPickCuffsA[iCufA] = MyAddToggleOption(" " +sPickCuffsA[iCufA]+ " ", iPickCuffsA[iCufA], 1, "When checked - the " +sPickCuffsA[iCufA]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iCufA += 1
					EndWhile
				
				AddHeaderOption(" Leg Restraints")
				AddHeaderOption("  Leg Cuffs/Shackles")
					While (iCufL < Math.Ceiling((iCufLMax AS FLOAT) / 2))
						oidPickCuffsL[iCufL] = MyAddToggleOption("  " +sPickCuffsL[iCufL]+ " ", iPickCuffsL[iCufL], 1, "When checked - the " +sPickCuffsL[iCufL]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iCufL += 1
					EndWhile
				AddHeaderOption("  Boots")
					While (iBoo < Math.Ceiling((iBooMax AS FLOAT) / 2))
						oidPickBoots[iBoo] = MyAddToggleOption(" " +sPickBoots[iBoo]+ " ", iPickBoots[iBoo], 1, "When checked - the " +sPickBoots[iBoo]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iBoo += 1
					EndWhile
				AddHeaderOption("  Leg Restraints Effects", Option_Flag_Disabled)
					oidAnklesEff = MyAddMenuOption(" Connect Leg Restraints Together", StorageUtil.GetIntValue(aSelActor, "iDDeAnklesEff", 0), sBinderEff, 1, "Here you can connect the leg restraints together.\n[Disabled] - The restraints are not connected. All leg cuffs/shacles/boots will function normally.\n[DDe Only] - Only leg restraints added by DDe will be connected together.\n[All] - All leg restraints will be connected.\nCannot change this option while [" +sSelActor+ "] has ANY devious devices on.", iDisabled)
				
				AddHeaderOption(" Bra")
					While (iBra < Math.Ceiling((iBraMax AS FLOAT) / 2))
						oidPickBra[iBra] = MyAddToggleOption(" " +sPickBra[iBra]+ " ", iPickBra[iBra], 1, "When checked - the " +sPickBra[iBra]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iBra += 1
					EndWhile
					
				AddHeaderOption("")
			EndIf
	;Second half of the page
	SetCursorPosition(1)
		AddHeaderOption("") ;Device Options
			MyAddTextOption("Total Pages", 2, "Total number of pages in Device Options.")
			If (iDevOptsPg == 1)
				AddHeaderOption("");Heavy Bondage
					While (iBin < iBinMax)
						oidPickBinder[iBin] = MyAddToggleOption(sPickBinder[iBin]+ " ", iPickBinder[iBin], 1, "When checked - the " +sPickBinder[iBin]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iBin += 1
					EndWhile
					If (iBinMax % 2)
						AddEmptyOption()
					EndIf	
				AddHeaderOption(" ", Option_Flag_Disabled)
					oidEnableBondFX = MyAddToggleOption("Enable Heavy Bondage FX", iDDe.iEnableBondFX, 1, "When checked - a visual FX will be played when heavy bondage is un/equipped.")
				AddHeaderOption("", Option_Flag_Disabled) ;Heavy Bondage Effects
					oidRefreshRate = MyAddSliderOption("Effects Refresh Rate.", iDDe.fDDeRefreshRate, 0.1, 66.6, 6.6, 0.1, "{1} Seconds", "Choose how often the heavy bondage effects are applied.\nHigher numbers may improve performance on slow computers.")
				AddHeaderOption("", Option_Flag_Disabled)
					oidArmActive = MyAddToggleOption("Disable Activate", iDDe.iDDeArmActive, 1, "When checked - you can't activate anything (including doors) while in heavy bondage.\nCareful with this one!", iDisabled)
					oidArmTravel = MyAddToggleOption("Disable Fast Travel", iDDe.iDDeArmTravel, 1, "When checked - fast travel is disabled while in heavy bondage.", iDisabled)
					oidArmWait = MyAddToggleOption("Disable Waiting", iDDe.iDDeArmWait, 1, "When checked - you can't wait while in heavy bondage.", iDisabled)
					oidArmStruggle = MyAddToggleOption("Disable Struggling", iDDe.iDDeArmStruggle, 1, "When checked - you can't struggle your way out of heavy bondage.", iDisabled)
					
				AddHeaderOption("");Plugs
					oidPlugHelp = MyAddTextOption("Get Help", "", "Hit this to get some help about using all the different plug effects.")
				AddHeaderOption("", Option_Flag_Disabled);Plugs Effects
					oidPlugDrainH = MyAddMenuOption("Drain Health", iDDe.iDDePlugDrainH, sPlugEff, 0, "The plug will drain health.\nCareful with this one!It can kill ya!", iDisabled)
					oidPlugDrainS = MyAddMenuOption("Drain Stamina", iDDe.iDDePlugDrainS, sPlugEff, 3, "The plug will drain stamina.", iDisabled)
					oidPlugDrainM = MyAddMenuOption("Drain Magicka", iDDe.iDDePlugDrainM, sPlugEff, 3, "The plug will drain magicka.", iDisabled)
					oidPlugLively = MyAddMenuOption("Lively", iDDe.iDDePlugLively, sPlugEff, 3, "Lively little thing.", iDisabled)
					oidPlugVeLively = MyAddMenuOption("Very Lively", iDDe.iDDePlugVeLively, sPlugEff, 3, "The plug is very lively.\nDevilish little things!", iDisabled)
					oidPlugVib = MyAddMenuOption("Periodically Vibrating", iDDe.iDDePlugVib, sPlugEff, 3, "The plug will periodically vibrate.", iDisabled)
					oidPlugVibRand = MyAddMenuOption("Vibrating Randomly", iDDe.iDDePlugVibRand, sPlugEff, 3, "The plug will periodically vibrate randomly.", iDisabled)
					oidPlugVibStrg = MyAddMenuOption("Vibrating Strongly", iDDe.iDDePlugVibStrg, sPlugEff, 3, "The plug will periodically vibrate strongly.", iDisabled)
					oidPlugVibWeak = MyAddMenuOption("Vibrating Weakly", iDDe.iDDePlugVibWeak, sPlugEff, 3, "The plug will periodically vibrate weakly.", iDisabled)
					oidPlugVibVeStrg = MyAddMenuOption("Vibrating Very Strongly", iDDe.iDDePlugVibVeStrg, sPlugEff, 3, "The plug will periodically vibrate very strongly.\nHold on now!", iDisabled)
					oidPlugVibVeWeak = MyAddMenuOption("Vibrating Very Weakly", iDDe.iDDePlugVibVeWeak, sPlugEff, 3, "The plug will periodically vibrate very weakly.\nTeaser little things.", iDisabled)
					
				AddHeaderOption("") ;Suits
					While (iSui < iSuiMax)
						oidPickSuit[iSui] = MyAddToggleOption(sPickSuit[iSui]+ " ", iPickSuit[iSui], 1, "When checked - the " +sPickSuit[iSui]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iSui += 1
					EndWhile
					If (iSuiMax % 2)
						AddEmptyOption()
					EndIf	
					
				AddHeaderOption("") ;Gags 
					While (iGag < iGagMax)
						oidPickGag[iGag] = MyAddToggleOption(sPickGag[iGag]+ " ", iPickGag[iGag], 1, "When checked - the " +sPickGag[iGag]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iGag += 1
					EndWhile
					If (iGagMax % 2)
						AddEmptyOption()
					EndIf	
				
				AddHeaderOption("") ;Hoods 
					While (iHood < iHoodMax)
						oidPickHood[iHood] = MyAddToggleOption(sPickHood[iHood]+ " ", iPickHood[iHood], 1, "When checked - the " +sPickHood[iHood]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iHood += 1
					EndWhile
					If (iHoodMax % 2)
						AddEmptyOption()
					EndIf	
					
				AddHeaderOption("") ;Mecha
					oidMechPowSnd = MyAddSliderOption("Mecha Punch Sound", iDDe.iMechPowSnd, -1, 11, 1, 1, "{0}", "Select the mecha punch sound. [-1] - Random. [0] - Disabled. [1] - Shield charge. [2] - Draugr Mele. [3] - Rune. [4] - Metal. [5] - Punch. [6] - Chicken. [7] - Dragon tail. [8] - Ram. [9] - Sphere. [10] - Goat. [11] - Mele.")
				AddHeaderOption("", Option_Flag_Disabled) ;Mech Suits Effects
					oidMechNoMove = MyAddToggleOption("Disable Movement", iDDe.iDDeMechNoMove, 0, "When checked - the mecha will not move.", iDisabled)
					oidMechNoSneak = MyAddToggleOption("Disable Sneaking", iDDe.iDDeMechNoSneak, 1, "When checked - the mecha will not allow sneaking.", iDisabled)
					oidMechNoSprint = MyAddToggleOption("Disable Sprint", iDDe.iDDeMechNoSprint, 1, "When checked - the mecha will not sprint.", iDisabled)
					oidMechNoWait = MyAddToggleOption("Disable Waiting", iDDe.iDDeMechNoWait, 0, "When checked - the mecha will not allow you to wait.", iDisabled)
					oidMechNoFastTravel = MyAddToggleOption("Disable Fast Travel", iDDe.iDDeMechNoFastTravel, 1, "When checked - the mecha will not allow you to fast travel.", iDisabled)
					AddEmptyOption()
				
				AddHeaderOption("") ;Belts 
					While (iBel < iBelMax)
						oidPickBelt[iBel] = MyAddToggleOption(sPickBelt[iBel]+ " ", iPickBelt[iBel], 1, "When checked - the " +sPickBelt[iBel]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iBel += 1
					EndWhile
					If (iBelMax % 2)
						AddEmptyOption()
					EndIf	
				
				AddHeaderOption("") ;Harness
					While (iHar < iHarMax)
						oidPickHarn[iHar] = MyAddToggleOption(sPickHarn[iHar]+ " ", iPickHarn[iHar], 1, "When checked - the " +sPickHarn[iHar]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iHar += 1
					EndWhile
					If (iHarMax % 2)
						AddEmptyOption()
					EndIf	
						
				AddHeaderOption("") ;Blindfolds 
					While (iBli < iBliMax)
						oidPickBlinder[iBli] = MyAddToggleOption(sPickBlinder[iBli]+ " ", iPickBlinder[iBli], 1, "When checked - the " +sPickBlinder[iBli]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iBli += 1
					EndWhile
					If (iBliMax % 2)
						AddEmptyOption()
					EndIf	
				
				AddHeaderOption("")
			Else
				AddHeaderOption("") ;Collar
					While (iCol < iColMax)
						oidPickCollar[iCol] = MyAddToggleOption(sPickCollar[iCol]+ " ", iPickCollar[iCol], 1, "When checked - the " +sPickCollar[iCol]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iCol += 1
					EndWhile
					If (iColMax % 2)
						AddEmptyOption()
					EndIf	 
					
				AddHeaderOption("") ;Gloves
					While (iGlo < iGloMax)
						oidPickGloves[iGlo] = MyAddToggleOption(sPickGloves[iGlo]+ " ", iPickGloves[iGlo], 1, "When checked - the " +sPickGloves[iGlo]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iGlo += 1
					EndWhile
					If (iGloMax % 2)
						AddEmptyOption()
					EndIf	 
				AddHeaderOption("", Option_Flag_Disabled) ;Gloves Options
					AddEmptyOption()
						
				AddHeaderOption("") ;Anal Plug
					While (iPla < iPlaMax)
						oidPickPlugA[iPla] = MyAddToggleOption(sPickPlugA[iPla]+ " ", iPickPlugA[iPla], 1, "When checked - the " +sPickPlugA[iPla]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iPla += 1
					EndWhile
					If (iPlaMax % 2)
						AddEmptyOption()
					EndIf	
				
				AddHeaderOption("") ;Vaginal Plug
					While (iPlv < iPlvMax)
						oidPickPlugV[iPlv] = MyAddToggleOption(sPickPlugV[iPlv]+ " ", iPickPlugV[iPlv], 1, "When checked - the " +sPickPlugV[iPlv]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iPlv += 1
					EndWhile
					If (iPlvMax % 2)
						AddEmptyOption()
					EndIf	
				
				AddHeaderOption("") ;Vaginal Piercings
					While (iPieV < iPieVMax)
						oidPickPieV[iPieV] = MyAddToggleOption(sPickPieV[iPieV]+ " ", iPickPieV[iPieV], 1, "When checked - the " +sPickPieV[iPieV]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iPieV += 1
					EndWhile
					If (iPieVMax % 2)
						AddEmptyOption()
					EndIf	
				
				AddHeaderOption("") ;Nipple Piercings
					While (iPieN < iPieNMax)
						oidPickPieN[iPieN] = MyAddToggleOption(sPickPieN[iPieN]+ " ", iPickPieN[iPieN], 1, "When checked - the " +sPickPieN[iPieN]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iPieN += 1
					EndWhile
					If (iPieNMax % 2)
						AddEmptyOption()
					EndIf	
				
				AddHeaderOption("") ;Arm Cuffs
					While (iCufA < iCufAMax)
						oidPickCuffsA[iCufA] = MyAddToggleOption(sPickCuffsA[iCufA]+ " ", iPickCuffsA[iCufA], 1, "When checked - the " +sPickCuffsA[iCufA]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iCufA += 1
					EndWhile
					If (iCufAMax % 2)
						AddEmptyOption()
					EndIf	
				
				AddHeaderOption("") ;Leg Restraints
				AddHeaderOption("") ;Leg Cuffs
					While (iCufL < iCufLMax)
						oidPickCuffsL[iCufL] = MyAddToggleOption(sPickCuffsL[iCufL]+ " ", iPickCuffsL[iCufL], 1, "When checked - the " +sPickCuffsL[iCufL]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iCufL += 1
					EndWhile
					If (iCufLMax % 2)
						AddEmptyOption()
					EndIf	
				AddHeaderOption("") ;Boots 
					While (iBoo < iBooMax)
						oidPickBoots[iBoo] = MyAddToggleOption(sPickBoots[iBoo]+ " ", iPickBoots[iBoo], 1, "When checked - the " +sPickBoots[iBoo]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iBoo += 1
					EndWhile
					If (iBooMax % 2)
						AddEmptyOption()
					EndIf	
				AddHeaderOption("", Option_Flag_Disabled) ;Leg Restraints Effects
					AddEmptyOption()
				
				AddHeaderOption("") ;Bra
					While (iBra < iBraMax)
						oidPickBra[iBra] = MyAddToggleOption(sPickBra[iBra]+ " ", iPickBra[iBra], 1, "When checked - the " +sPickBra[iBra]+ " will be used.\nIf more than one device is checked, a random device will be picked among all the selected devices.")
						iBra += 1
					EndWhile
					If (iBraMax % 2)
						AddEmptyOption()
					EndIf	
						
				AddHeaderOption("")
			EndIf
	ElseIf (asPage == Pages[6]) ;Local Outfits 	
	;Local Outfit Page 
	;ooooooooooooooooooooooooooooooooooooooooooooooo
		SetLocOutPgOIDs()
		INT iCDxL = (iDDeLib.sCDxOutMCM).Length 
		INT iMisL = (iDDeLib.sDDeOutMiscMCM).Length
			If (iCDxL > 6)
				iCDxL -= 1 ;Don't need the cursed one ;-)
			EndIf
		oidCDxOut = CreateIntArray(iCDxL, 0)
		oidDDeOutMisc = CreateIntArray(iMisL, 0)
		INT iCDxi = 1
		INT iCDx2 = Math.Ceiling((iCDxL AS FLOAT) / 2.0)
		INT iMisi = 1
		INT iMis2 = Math.Ceiling((iMisL AS FLOAT) / 2.0)
		INT iRegMax = SetUpStrA1(iDDeLib.sDDeOutRegMCM, iPerPage = iOutRegPerPg)
		INT iDreMax = SetUpStrA2(iDDeLib.sDDeOutDrMCM, iPerPage = iOutDrePerPg)
			oidDDeOutReg = CreateIntArray(iRegMax, 0)
			oidDDeOutDre = CreateIntArray(iDreMax, 0)	
	;ooooooooooooooooooooooooooooooooooooooooooooooo	
		AddHeaderOption("Local " +sLocOut)
			DisplayOutArray(sPre = "", sStr = sDDeOutLoc, sCo = sLocCol, sOut = sLocOut, iChaMax = iSUmMCM.iLinChaMax, sSub = sDDeOutCus)	
		AddHeaderOption(" Local Outfit Adding Options", Option_Flag_Disabled)
			If (sDDeOutLocSel)
				oidOutLocAdd = MyAddMenuOption(" Add Selected Outfit", iOutLocAdd, sOutSelTos, 0, "Use this to choose where to add the selected outfit.\n[As A Single Outfit] - will add the selected outfit as a single outfit in the 'Devices Interaction' page. [To The Local Outfit Array] - You can select a bunch of outfits and they will be stored in a local array of outfits of which a random one will be equipped. [To The Custom Outfit Array] - Will make a custom outfit array.") 
			EndIf	
			
			If (iDDe.bCD)
				AddHeaderOption("CD Outfits")
					While (iCDxi < iCDx2)
						oidCDxOut[iCDxi] = MyAddTextOption(SetColor(sOutLoCo, (iCDxi+ ". "))+ "Select [" +SetColor(sOutLoCo, iDDeLib.sCDxOutMCM[iCDxi])+ "] outfit.", "", "Hit this to load the [" +iDDeLib.sCDxOutMCM[iCDxi]+ "] outfit.")
						iCDxi += 1
					EndWhile
			Else
				AddHeaderOption("Captured Dreams Not Installed", Option_Flag_Disabled)
			EndIf
		AddHeaderOption("DDe Outfits")
			AddHeaderOption(" Misc", Option_Flag_Disabled)	
				While (iMisi < iMis2)
					oidDDeOutMisc[iMisi] = MyAddTextOption(" " +SetColor(sOutLoCo, (iMisi+ ". "))+ "Select [" +SetColor(sOutLoCo, iDDeLib.sDDeOutMiscMCM[iMisi])+ "] outfit.", "", "Hit this to load the [" +iDDeLib.sDDeOutMiscMCM[iMisi]+ "] outfit.")
					iMisi += 1
				EndWhile
			AddHeaderOption(" Regular", Option_Flag_Disabled)			
				MyAddTextOption(" Total Outfits", iRegMax, "Total number of regular DDe outfits.")
				oidOutRegPg = MyAddSliderOption(" Go To Page No. ", _iA1P, 1, _iA1Ps, 1, 1, "{0}", "Choose a page number.")	
			AddHeaderOption("   Page No. " +_iA1P, Option_Flag_Disabled)	
				While (_iA1i < _iA1L2)
					oidDDeOutReg[_iA1i] = MyAddTextOption("  " +SetColor(sOutLoCo, ((_iA1i + 1)+ ". "))+ "Select [" +SetColor(sOutLoCo, iDDeLib.sDDeOutRegMCM[_iA1i])+ "] outfit.", "", "Hit this to load the [" +iDDeLib.sDDeOutRegMCM[_iA1i]+ "] outfit.")
					_iA1i += 1
				EndWhile	
			AddHeaderOption(" Dress", Option_Flag_Disabled)		
				MyAddTextOption(" Total Outfits", iDreMax, "Total number of dress DDe outfits.")
				oidOutDrePg = MyAddSliderOption(" Go To Page No. ", _iA2P, 1, _iA2Ps, 1, 1, "{0}", "Choose a page number.")	
			AddHeaderOption("   Page No. " +_iA2P, Option_Flag_Disabled)	
				While (_iA2i < _iA2L2)
					oidDDeOutDre[_iA2i] = MyAddTextOption("  " +SetColor(sOutLoCo, ((_iA2i + 1)+ ". "))+ "Select [" +SetColor(sOutLoCo, iDDeLib.sDDeOutDrMCM[_iA2i])+"] outfit.", "", "Hit this to load the [" +iDDeLib.sDDeOutDrMCM[_iA2i]+ "] outfit.")
					_iA2i += 1
				EndWhile
					
			AddHeaderOption("")	
	;Second half of the page			 
		SetCursorPosition(1)
			AddHeaderOption("Custom " +sCusOut) ;Loaded Outfit 
				DisplayOutArray(sPre = "", sStr = sDDeOutCus, sCo = sCusCol, sOut = sCusOut, iChaMax = iSUmMCM.iLinChaMax, sSub = sDDeOutLoc)
			AddHeaderOption("", Option_Flag_Disabled) ;Adding Options
				If (sDDeOutLocSel)
					AddEmptyOption()
				EndIf
				
				If (iDDe.bCD)
					AddHeaderOption("") ;CD Outfits
						While (iCDxi < iCDxL)
							oidCDxOut[iCDxi] = MyAddTextOption(SetColor(sOutLoCo, (iCDxi+ ". "))+ "Select [" +SetColor(sOutLoCo, iDDeLib.sCDxOutMCM[iCDxi])+"] outfit.", "", "Hit this to load the [" +iDDeLib.sCDxOutMCM[iCDxi]+ "] outfit.")
							iCDxi += 1
						EndWhile
						If (iCDxL % 1)
							AddEmptyOption()
						EndIf	
						;("Load 'CD Cursed' Outfit", "", "Hit this to make a complete CD cursed outfit. \nWarning! \nThese are quest devices, lest you finish their quest are impossible to remove! \nDo not use these! \nYou've been warned!")
				Else
					AddHeaderOption("", Option_Flag_Disabled) ;CD Not Installed
				EndIf
			
			AddHeaderOption("") ;DDe Outfits
			AddHeaderOption("", Option_Flag_Disabled) ;Misc 	
				While (iMisi < iMisL)
					oidDDeOutMisc[iMisi] = MyAddTextOption(" " +SetColor(sOutLoCo, (iMisi+ ". "))+ "Select [" +SetColor(sOutLoCo, iDDeLib.sDDeOutMiscMCM[iMisi])+"] outfit.", "", "Hit this to load the [" +iDDeLib.sDDeOutMiscMCM[iMisi]+ "] outfit.")
					iMisi += 1
				EndWhile
				If (iMisL % 1)
					AddEmptyOption()
				EndIf	
			AddHeaderOption("", Option_Flag_Disabled)	;Regular 
				oidOutRegPerPg = MyAddSliderOption("Outfits Per Page", iOutRegPerPg, 6, 66, 6, 1, "{0}", "Choose how many outfits to display per page.")
				MyAddTextOption("Total Pages", _iA1Ps, "Total number of pages.")
			AddHeaderOption("", Option_Flag_Disabled)
				While (_iA1i < _iA1L)
					oidDDeOutReg[_iA1i] = MyAddTextOption(" " +SetColor(sOutLoCo, ((_iA1i + 1)+ ". "))+ "Select [" +SetColor(sOutLoCo, iDDeLib.sDDeOutRegMCM[_iA1i])+ "] outfit.", "", "Hit this to load [" +iDDeLib.sDDeOutRegMCM[_iA1i]+ "] outfit.")
					_iA1i += 1
				EndWhile
				If (_iA1E)
					AddEmptyOption()
				EndIf
			AddHeaderOption("", Option_Flag_Disabled)	;Dress 
				oidOutDrePerPg = MyAddSliderOption("Outfits Per Page", iOutDrePerPg, 6, 66, 6, 1, "{0}", "Choose how many outfits to display per page.")
				MyAddTextOption("Total Pages", _iA2Ps, "Total number of pages.")
			AddHeaderOption("", Option_Flag_Disabled)
				While (_iA2i < _iA2L)
					oidDDeOutDre[_iA2i] = MyAddTextOption(" " +SetColor(sOutLoCo, ((_iA2i + 1)+ ". "))+ "Select [" +SetColor(sOutLoCo, iDDeLib.sDDeOutDrMCM[_iA2i])+ "] outfit.", "", "Hit this to load the [" +iDDeLib.sDDeOutDrMCM[_iA2i]+ "] outfit.")
					_iA2i += 1
				EndWhile
				If (_iA2E)
					AddEmptyOption()
				EndIf
				
			AddHeaderOption("")	
	ElseIf (asPage == Pages[7]) ;Custom Outfits
	;Custom Outfits Page
	;ccccccccccccccccccccccccccccccccccccccccccccccc
		SetCusOutPgOIDs()
			iDDe.sOutFolder = GetFolder(sFolder = iDDe.sOutFolder, sType = "Outfits")
				If (!iDDe.sOutJson)
					iDDe.sOutJson = "iDDeOutfits.json"
				Else
					iDDe.sOutJson = SetJson(sJson = iDDe.sOutJson)
				EndIf
			iDDe.sOutFoJs = (iDDe.sOutFolder + iDDe.sOutJson)
			sOutJsons = iSUmUtil.GetJsonsInFolder(sFolder = iDDe.sOutFolder)
			sOutCuss = GetTypesInJson(sJson = iDDe.sOutFoJs)
		INT iOutJsMax = SetUpStrA1(sArray = sOutJsons, iPerPage = iOutJsPerPg)
			oidOutJsons = CreateIntArray(iOutJsMax, 0)
		INT iOutMax = SetUpStrA2(sArray = sOutCuss, iPerPage = iOutPerPg)
			oidOutCuss = CreateIntArray(iOutMax, 0)
	;ccccccccccccccccccccccccccccccccccccccccccccccc
		AddHeaderOption("Outfits Json Folder/Path") 
			oidOutFolder = MyAddInputOption("Folder Path-> [" +iDDe.sOutFolder+ "]", "", "[" +iDDe.sOutFolder+ "] - Current text.\n[DDe],[] - Will auto load the DDe's default outfits folder.\n[+something] - Appends something to existing text input.")	
			AddEmptyOption()	
		AddHeaderOption(" Existing Outfits Json Files", Option_Flag_Disabled)	
			MyAddTextOption(" Total Jsons ", iOutJsMax, "Total number of jsons in [" +iDDe.sOutFolder+ "] folder.")
			oidOutJsPg = MyAddSliderOption(" Go To Page No. ", _iA1P, 1, _iA1Ps, 1, 1, "{0}", "Choose a page number.")	
		AddHeaderOption("   Page No. " +_iA1P, Option_Flag_Disabled)	
			While (_iA1i < _iA1L2)
				oidOutJsons[_iA1i] = MyAddTextOption("  " +SetColor(sOutJsCo, ((_iA1i + 1)+ ". "))+ "Select [" +SetColor(sOutJsCo, sOutJsons[_iA1i])+ "]", "", "Hit this to load this file.")
					_iA1i += 1
			EndWhile	 
		
		AddHeaderOption("Custom " +sCusOut)
			DisplayOutArray(sPre = "", sStr = sDDeOutCus, sCo = sCusCol, sOut = sCusOut, iChaMax = iSUmMCM.iLinChaMax, sSub = sDDeOutLoc)
		AddHeaderOption(" Custom Outfit Adding Options", Option_Flag_Disabled)
			If (sDDeOutCusSel)
				oidOutCusAdd = MyAddMenuOption(" Add Selected Outfit", iOutCusAdd, sOutSelTos, 0, "Use this to choose where to add the selected outfit.\n[As A Single Outfit] - will add the selected outfits as a single outfit in the 'Devices Interaction' page. [To The Local Outfit Array] - You can select a bunch of outfits and they will be stored in a local array of outfits of which a random one will be equipped. [To The Custom Outfit Array] - Will make a custom outfit array.") 
			EndIf	
			
		AddHeaderOption("Create Custom Outfits")
			oidSaveOutfitMCM = MyAddInputOption(" Save Library Outfit As", SetColor(sOutCo, sDDeOutCusSel), "Enter a name for the outfit to be saved.\nI.e. 'My Red Ebonite Outfit'.")
			oidSaveOutfitWorn = MyAddInputOption(" Save Worn Outfit As", SetColor(sOutCo, sDDeOutCusSel), "[" +sDDeOutCusSel+ "] - Current text.\nEnter a name for the worn outfit to be saved.\nI.e. 'My Red Ebonite Outfit'.\nThis will save all currently worn devious devices by [" +sSelActor+ "] as a custom outfit.")
			oidDeleteOutfit = MyAddInputOption(" Delete Outfit", SetColor(sOutCo, sDDeOutCusSel), "Enter the name of the outfit you want deleted.")
		AddHeaderOption(" Custom Outfits In [" +SetColor(sOutJsCo, iDDe.sOutJson)+ "]", Option_Flag_Disabled)
			MyAddTextOption("  Total Outfits ", iOutMax, "Total number of outfits in [" +iDDe.sOutJson+ "] list.")
			oidOutPg = MyAddSliderOption("  Go To Page No. ", _iA2P, 1, _iA2Ps, 1, 1, "{0}", "Choose a page number.")
		AddHeaderOption("   Page No. " +_iA2P, Option_Flag_Disabled)	
			While (_iA2i < _iA2L2)
				oidOutCuss[_iA2i] = MyAddTextOption("  " +SetColor(sOutCo, ((_iA2i + 1)+ ". "))+ "Select [" +SetColor(sOutCo, sOutCuss[_iA2i])+ "] outfit.", "", "Hit this to load this outfit.")
					_iA2i += 1
			EndWhile
			
		AddHeaderOption("")		
	;Second half of the page			 
	SetCursorPosition(1)
		AddHeaderOption("");Outfits Json Folder/Path
			oidOutJson = MyAddInputOption("Json Name", SetColor(sOutJsCo, iDDe.sOutJson), "[" +iDDe.sOutJson+ "] - Current text.\n[] - Defaults to DDe's 'iDDeOutfits'.")
			oidOutFoJs = MyAddTextOption("Show Current Full Json Path", "Clicky", "Hit this to show the full outfit's json path currently entered.")
		AddHeaderOption(" ", Option_Flag_Disabled) ;Existing Outfits Json Files	
			oidOutJsPerPg = MyAddSliderOption("Jsons Per Page", iOutJsPerPg, 6, 66, 22, 1, "{0}", "Choose how many outfit jsons to display per page.")
			MyAddTextOption("Total Pages", _iA1Ps, "Total number of pages.")
		AddHeaderOption("", Option_Flag_Disabled) ;Page No.
			While (_iA1i < _iA1L)
				oidOutJsons[_iA1i] = MyAddTextOption("  " +SetColor(sOutJsCo, ((_iA1i + 1)+ ". "))+ "Select [" +SetColor(sOutJsCo, sOutJsons[_iA1i])+ "]", "", "Hit this to load this file.")
					_iA1i += 1
			EndWhile	
			If (_iA1E)
				AddEmptyOption()
			EndIf		
		
		AddHeaderOption("Local " +sLocOut)
			DisplayOutArray(sPre = "", sStr = sDDeOutLoc, sCo = sLocCol, sOut = sLocOut, iChaMax = iSUmMCM.iLinChaMax, sSub = sDDeOutCus)	
		AddHeaderOption("", Option_Flag_Disabled) ;Adding Options
			If (sDDeOutCusSel)
				AddEmptyOption()
			EndIf
		AddHeaderOption("") ;Create Custom Outfits
			oidAllWornOpt = MyAddInputOption("Save/Equip Options", sAllWornOpt, "[" +sAllWornOpt+ "] - Current text.\nAvailable outfit saving and equipping options -> [bInv,bWorn].\n[bWorn] - will save/equip all worn not just the DDs.[bInv] - will also add the inventory contents to/from the outfit file. [] - (Blank) feature disabled, only worn DDs will be saved/equipped.")
			AddEmptyOption()
			oidOutCusHelp = MyAddTextOption("Get Help", "", "Hit this to get some help about using 'Custom Outfits'.")	
		AddHeaderOption("", Option_Flag_Disabled) ;Saved Custom Outfits
			oidOutPerPg = MyAddSliderOption("Outfits Per Page", iOutPerPg, 6, 66, 22, 1, "{0}", "Choose how many outfits to display per page.")
			MyAddTextOption("Total Pages", _iA2Ps, "Total number of pages.")
		AddHeaderOption("", Option_Flag_Disabled) ;Page No.
			While (_iA2i < _iA2L)
				oidOutCuss[_iA2i] = MyAddTextOption("  " +SetColor(sOutCo, ((_iA2i + 1)+ ". "))+ "Select [" +SetColor(sOutCo, sOutCuss[_iA2i])+ "] outfit.", "", "Hit this to load this outfit.")
					_iA2i += 1
			EndWhile
			If (_iA2E)
				AddEmptyOption()
			EndIf
			
		AddHeaderOption("")
	ElseIf (asPage == Pages[8]) ;Debug
	;Debug Page
	;ddddddddddddddddddddddddddddddddddddddddddddddd
	;ddddddddddddddddddddddddddddddddddddddddddddddd
		AddHeaderOption("Reset Options")
			oidForceRestart = MyAddTextOption("Reset DD Equip.", "", "Hit this to manually force restart the mod.")
			
		AddHeaderOption("Debug Options")
			oidDisInfo = MyAddToggleOption("Display Info To Screen", StorageUtil.GetIntValue(None, "iDDeDisplayInfo", 1), 1, "Check this here option to have a verbose screen.\n")
			oidConInfo = MyAddToggleOption("Display Info To Console", StorageUtil.GetIntValue(None, "iDDeConsoleInfo", 0), 0, "Check this here option to display the log to console.")
		
		AddHeaderOption("Debug StorageUtil Options")
			oidClearSave = MyAddTextOption("Clear ALL Saved StorageUtil Outfits From Save.", "", "Hit this to crear ALL [" +sSelActor+ "]'s StorageUtil outfits from the save.")
		
		AddHeaderOption("")
	;Second half of the page
	SetCursorPosition(1)
		AddHeaderOption("");Reset Options	
			AddEmptyOption()
		
		AddHeaderOption("");Debug Options
			oidDebInfo = MyAddMenuOption("Debug Mode", StorageUtil.GetIntValue(None, "iDDeDebugInfo", 0), sDebInfo, 3, "[No Log] - nothing sent to the log.\n[Debug] - for debugging.\nOption chosen will display everything above it, e.g. [Warnings] will display [Errors] but not vice versa.")
			oidUtilityTask = MyAddMenuOption("Utility Tasks", iDDe.iDDeUtilityTask.GetValueInt(), sUtilityTask, 0, "Use this to perform the corresponding utility tasks.")
		
		AddHeaderOption("");Debug StorageUtil Options
			AddEmptyOption()
			
		AddHeaderOption("")
	EndIf	
EndEvent   
  
Event OnOptionSelect(Int aiOption) 
	;-----------------------------------------------
	;-----------------------------------------------
		If (aiOption == oidForceRestart)
			BOOL abAction = ShowMessage("Are you sure you want to reset DDe?\nYou might get stuck in some awesome DDs.", a_withCancel = True)
				If (abAction)
					ForceCloseMenu()
					SetUpMCM(sEvent = "Reset ", fWait = 2.2, sList = sUpdList, sMod = sUpdMod)
				EndIf 
	;Equp/Un-equip Outfits 
	;eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
		ElseIf ((aiOption == oidEqpOutfit) || (aiOption == oidEqpOutPre) || (aiOption == oidEqpMCM) || (aiOption == oidEqpCust) || (aiOption == oidEqpOutCur))
			ForceCloseMenu()
			STRING sOut = sDDeOutLoc
				If (aiOption == oidEqpOutCur)
					sOut = iDDe.GetStoUtilCurOutfit(aSlave = aSelActor, sOutfit = "")
				ElseIf (aiOption == oidEqpOutPre)
					sOut = iDDe.GetStoUtilPreOutfit(aSlave = aSelActor, sOutfit = "")
				ElseIf (aiOption == oidEqpMCM)
					sOut = iDDeLib.sDDeOutMisc[1]
				ElseIf (aiOption == oidEqpCust)
					sOut = sDDeOutCus
				EndIf
			;aSelActor.SendModEvent("iDDeStrip", "iDDeStripByMCM", 1)
			iDDe.Strip(aSelActor, sList = "iDDeStripByMCM", iDDs = 1)
			iDDe.EquipOutfit(aSelActor, sList = sOut, iDDs = 77, sOpt = "bNew")
			;aSelActor.SendModEvent("iDDeEquipOutfit", sOut, 77)
			sDDeOutEqp = iDDe.GetStoUtilCurOutfit(aSlave = aSelActor, sOutfit = "")
				If (sAllWornOpt && sDDeOutEqp && (aiOption != oidEqpMCM) && (StringUtil.Find(sDDeOutEqp, "iDDe") != 0))
					iDDe.iSUm.SetJsonToActor(aActor = aSelActor, sJson = iDDe.GetGloJsonByList(sFolder = "Outfits", sList = sDDeOutEqp), sList = sDDeOutEqp, sOpt = iSUmUtil.StrAddElement(sStr = sAllWornOpt, sAdd = "bNoEquip", bAdd = (StringUtil.Find(sAllWornOpt, "bWorn") < 0), sDiv = ","))
				EndIf
				If (iDDe.iDDeHardCore) 
					RemoveKeys(aSelActor) 
				EndIf
		ElseIf ((aiOption == oidRemOutfit) || (aiOption == oidRemMCM))
			ForceCloseMenu()
			sDDeOutEqp = iDDe.GetStoUtilCurOutfit(aSlave = aSelActor, sOutfit = "")
			STRING sOut = sDDeOutEqp
				If (aiOption == oidRemMCM) 
					sOut = iDDeLib.sDDeOutMisc[1]
				EndIf
			iDDe.EquipOutfit(aSelActor, sList = sOut, iDDs = -77)
			iDDe.Strip(aSelActor, sList = "iDDeStripByMCM", iDDs = -1)
		ElseIf (aiOption == oidRemExisting)
			ForceCloseMenu()
			iDDe.EquipWorn(aSelActor, sList = iDDeLib.sDDeOutMisc[6], iDDs = -66)
			iDDe.Strip(aSelActor, sList = "iDDeStripByMCM", iDDs = -1) 
		ElseIf (aiOption == oidSelfBondStart)
			ForceCloseMenu() 
			StartSelfBondage(aActor = aSelActor)
		ElseIf (aiOption == oidRefrDDsList)
			aSelActor.SendModEvent("iDDeListAllWornDDs", iDDeLib.sDDeOutMisc[6], 66)
			;iDDe.ListAllWornDDs(aSelActor, sList = iDDeLib.sDDeOutMisc[6], iDDs = 33, sOpt = "bNew")		
			bRefrDDs = True
	;Make/Clear Outfits
	;uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu
		ElseIf (aiOption == oidOutClearMCM)
			ClearOutfitMCM()
		;Making Outfits
		;mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		ElseIf ((aiOption == oidConSave) || (aiOption == oidConLoad) || (aiOption == oidConClear))
			STRING sFile = GetPathJson(sPath = "PlaMCM", sJson = sConFile)
			BOOL bExist = iSUmUtil.IsJson(sFile)
			BOOL bGo = False
				If (aiOption == oidConSave)
					bGo = ShowMessage("This will save all MCM configuration settings to [" +sConFile+ "].\nAre you sure you want to continue?", a_withCancel = True)
						If (bGo)
							If (bExist && !ShowMessage("File already exists.\nOverride the existing file?", a_withCancel = True))
								RETURN
							EndIf
							ForceCloseMenu()
							iDDeExportSettings(sFile)
						EndIf
				ElseIf (aiOption == oidConLoad)
					bGo = ShowMessage("This will load all MCM configuration settings from [" +sConFile+ "].\nAre you sure you want to continue?", a_withCancel = True)
						If (bGo)
							If (bExist)
								If ((JsonUtil.GetStringValue(sFile, "sSemanticVer") != iDDeUtil.GetSemVerStr()) && !ShowMessage("Existing version does not match saved version.\nSome data will not be loaded.\nContinue anyway?", a_withCancel = True))
									RETURN	
								EndIf
								ForceCloseMenu()
								iDDeImportSettings(sFile)
							Else
								ShowMessage("Bad command or file name!")
							EndIf
						EndIf
				ElseIf (aiOption == oidConClear)
					bGo = ShowMessage("This will clear all configuration settings from [" +sConFile+ "].\nAre you sure you want to continue?", a_withCancel = True)
						If (bGo)
							If (bExist)
								If (ShowMessage("All your configuration settings will be deleted from the file.\nProceed?", a_withCancel = True))
									ForceCloseMenu()
									iDDeUtil.Log("iDDeConfig.oidConClear -> ", "Clearing MCM file " +sFile+ "... Please stand by!", 3, 1)
									JsonUtil.ClearAll(sFile)
									Wait(1.1)
									JsonUtil.Save(sFile, False)
									iDDeUtil.Log("iDDeConfig.oidConClear -> ", "Clearing MCM file... Done!", 3, 1)
								EndIf
							Else
								ShowMessage("Bad command or file name!")
							EndIf
						EndIf	
				EndIf
		ElseIf (aiOption == oidOutCusHelp)
			ShowMessage(JsonUtil.GetStringValue(GetPathJson(sPath = "DDeMCM"), "sCustomOutfitsHelp", "No system .json file!"))
		ElseIf (aiOption == oidPlugHelp)
			ShowMessage(JsonUtil.GetStringValue(GetPathJson(sPath = "DDeMCM"), "sPlugsHelp", "No system .json file!"))
		ElseIf (aiOption == oidRegisterTags)
			Bool abAction = ShowMessage("Are you sure you want to register all tags added by DDe?", a_withCancel = True)
				If (abAction)
					ForceCloseMenu()
					iDDeLib.iDDeRegisterTags()
				EndIf
		ElseIf (aiOption == oidClearSave)
			Bool abAction = ShowMessage("Are you sure you want to clear ALL StorageUtil outfits for [" +sSelActor+ "] from your save?\n[" +sSelActor+ "] might get stuck in a currently equipped DDe outfit!\nPlease wait for 'Done'!", a_withCancel = True)
				If (abAction)
					ForceCloseMenu()
					iDDeUtil.Log("iDDeConfig.OnOptionSelect():-> Clearing ALL saved StorageUtil outfits for [" +sSelActor+ "]... Please stand by!", "Clearing ALL saved StorageUtil outfits for [" +SetColor(sActCo, sSelActor)+ "]... Please stand by!", 3, 2)
					INT iClr = iDDe.iDDeClearAllLists(aSelActor)
					iDDeUtil.Log("iDDeConfig.OnOptionSelect():-> Done! Cleared [" +iClr+ "] outfits for [" +sSelActor+ "]!", "Done! Cleared [" +iClr+ "] outfits for [" +SetColor(sActCo, sSelActor)+ "]!", 3, 2)
				EndIf
		ElseIf (GetOidIdx(oidOutCuss, aiOption) != -1) ;Making Outfits
			sDDeOutCusSel = sOutCuss[idxOid]
				If (iOutCusAdd == 0)
					sDDeOutCus = sDDeOutCusSel
				ElseIf (iOutCusAdd == 1) ;Loc
					sDDeOutLoc = AddToOutList(sOut = sDDeOutCusSel, sList = sDDeOutLoc)
				ElseIf (iOutCusAdd == 2) ;Cus
					sDDeOutCus = AddToOutList(sOut = sDDeOutCusSel, sList = sDDeOutCus)
				EndIf
		ElseIf (GetOidIdx(oidDDeOutMisc, aiOption) != -1)
			sDDeOutLocSel = iDDeLib.sDDeOutMisc[idxOid]
				If (iOutLocAdd == 0)
					sDDeOutLoc = sDDeOutLocSel
				ElseIf (iOutLocAdd == 1) ;Loc
					sDDeOutLoc = AddToOutList(sOut = sDDeOutLocSel, sList = sDDeOutLoc)
				ElseIf (iOutLocAdd == 2) ;Cus
					sDDeOutCus = AddToOutList(sOut = sDDeOutLocSel, sList = sDDeOutCus)
				EndIf
		ElseIf (GetOidIdx(oidDDeOutReg, aiOption) != -1)
			sDDeOutLocSel = iDDeLib.sDDeOutReg[idxOid]
				If (iOutLocAdd == 0)
					sDDeOutLoc = sDDeOutLocSel
				ElseIf (iOutLocAdd == 1) ;Loc
					sDDeOutLoc = AddToOutList(sOut = sDDeOutLocSel, sList = sDDeOutLoc)
				ElseIf (iOutLocAdd == 2) ;Cus
					sDDeOutCus = AddToOutList(sOut = sDDeOutLocSel, sList = sDDeOutCus)
				EndIf
		ElseIf (GetOidIdx(oidDDeOutDre, aiOption) != -1)
			sDDeOutLocSel = iDDeLib.sDDeOutDr[idxOid]
				If (iOutLocAdd == 0)
					sDDeOutLoc = sDDeOutLocSel
				ElseIf (iOutLocAdd == 1) ;Loc
					sDDeOutLoc = AddToOutList(sOut = sDDeOutLocSel, sList = sDDeOutLoc)
				ElseIf (iOutLocAdd == 2) ;Cus
					sDDeOutCus = AddToOutList(sOut = sDDeOutLocSel, sList = sDDeOutCus)
				EndIf
		ElseIf (GetOidIdx(oidCDxOut, aiOption) != -1)
			sDDeOutLocSel = iDDeLib.sCDxOut[idxOid]
				If (iOutLocAdd == 0)
					sDDeOutLoc = sDDeOutLocSel
				ElseIf (iOutLocAdd == 1) ;Loc
					sDDeOutLoc = AddToOutList(sOut = sDDeOutLocSel, sList = sDDeOutLoc)
				ElseIf (iOutLocAdd == 2) ;Cus
					sDDeOutCus = AddToOutList(sOut = sDDeOutLocSel, sList = sDDeOutCus)
				EndIf
		ElseIf (GetJsonOidIdx(sList = "WornDevOIDs", sJson = GetPathJson(sPath = "PlaSys", sJson = "OID"), aiOption = aiOption) != -1);Device Handling
			aSelActor.SendModEvent("iDDeEquipIdx", iDDeLib.sDDeOutMisc[6], (-idxOid - 1))
			;iDDe.EquipIdx(aSelActor, sList = iDDeLib.sDDeOutMisc[6], iDDs = (-idxOid - 1))
			bRefrDDs = True
		ElseIf (aiOption == oidConRfr)
			sConFis = iSUmUtil.GetJsonsInFolder(sFolder = GetPathFolder(sPath = "Pla", sFolder = "MCM"))
		ElseIf (GetOidIdx(oidConFis, aiOption) != -1)
			sConFile = sConFis[idxOid]
		ElseIf (aiOption == oidActFolderRfr)
			sActJsons = iSUmUtil.GetJsonsInFolder(sFolder = iDDe.sActFolder)
		ElseIf (GetOidIdx(oidActJsons, aiOption) != -1)
			iDDe.sActJson = sActJsons[idxOid]
		ElseIf (aiOption == oidAdminHardCoreDD)
			ShowMessage("> Punish Time! <") 
			ForceCloseMenu() 
			iDDe.Strip(iDDe.PlayerRef, sList = "iDDeStripByMCM", iDDs = 1)
			StorageUtil.SetFloatValue(iDDe.PlayerRef, "iDDefSelfBondEnd", (Game.GetRealHoursPassed() + (StorageUtil.GetFloatValue(iDDe.PlayerRef, "iDDefSelfTimer", 0) / 60.0)))
			iDDe.EquipOutfit(iDDe.PlayerRef, sList = iDDeLib.sDDeOutMisc[5], iDDs = 76, sOpt = "bNew,Extreme Open Dress,Harness Ball Gag,Elbowbinder,Locked Blindfold")
			aSelActor.SendModEvent("iDDeLock", "DDe Self Bondage Session", 1)
			RemoveKeys(iDDe.PlayerRef)
			iDDe.iDDeHardCore = 1
		;Actor Selection
		ElseIf (aiOption == oidActListRfr)
			sActLis = GetTypesInJson(sJson = iDDe.sActFoJs)
		ElseIf (aiOption == oidActListSave)
			JsonUtil.Save(iDDe.sActFoJs, False)
			sActLis = GetTypesInJson(sJson = iDDe.sActFoJs)
		ElseIf (aiOption == oidActListDel)
			If (ShowMessage("Are you sure you want to delete the [" +sActLi+ "] actor list?", a_withCancel = True))
				JsonUtil.StringListClear(iDDe.sActFoJs, sActLi)
				sActLi = ""
				JsonUtil.Save(iDDe.sActFoJs, False)
				sActLis = GetTypesInJson(sJson = iDDe.sActFoJs)
			EndIf
		ElseIf (GetJsonOidIdx(sList = "ActorsOIDs", sJson = GetPathJson(sPath = "PlaSys", sJson = "OID"), aiOption = aiOption) != -1)
			sActStrGet = JsonUtil.StringListGet(iDDe.sActFoJs, sActLi, idxOid)
			aSelActor = (iSUmUtil.GetFormFromStrHex(sStr = sActStrGet, akFail = None, sLabel = "Form") AS Actor)
			sActStr = iSUmUtil.StrSlice(sStr = sActStrGet, sSt = "Name=|", sEn = "|,", sFail = "", sRem = "", idx = 0)
			sActInf = iSUmUtil.StrSlice(sStr = sActStrGet, sSt = "Info=|", sEn = "|,", sFail = "", sRem = "", idx = 0)
			iActIdx = idxOid
			aLiActor = aSelActor
			_iSelActPl = 1
		ElseIf (aiOption == oidActFoJs)
			ShowMessage(iDDe.sActFoJs)
		ElseIf (aiOption == oidActSelAdd)
			AddActorToList(aActor = aSelActor, iNo = 0)
		ElseIf (aiOption == oidDelSelActor)
			Actor aRem = (iSUmUtil.GetFormFromStr(sStr = JsonUtil.StringListGet(iDDe.sActFoJs, sActLi, iActIdx), akFail = None, sLabel = "Form") AS Actor)
				If (aSelActor == aRem) 
					JsonUtil.StringListRemoveAt(iDDe.sActFoJs, sActLi, iActIdx)
					JsonUtil.Save(iDDe.sActFoJs, False)
					iActIdx = -1
				Else
					ShowMessage("Actor index mismatch, re-select the actor to be removed.")
				EndIf	
		ElseIf (aiOption == oidOutFoJs)
			ShowMessage(iDDe.sOutFoJs)
		ElseIf (GetOidIdx(oidOutJsons, aiOption) != -1)
			iDDe.sOutJson = sOutJsons[idxOid]
		ElseIf (GetOidIdx(oidActLists, aiOption) != -1)
			sActLi = sActLis[idxOid]
		ElseIf ((aiOption == oidOutLocJsAdd) || (aiOption == oidOutCusJsAdd))
			STRING sStr = sDDeOutLoc
				If (aiOption == oidOutCusJsAdd)
					sStr = sDDeOutCus
				EndIf
			STRING sMsg = "This will save the [" +sStr+ "] as (" +sOutLiName+ ") list in [" +(GetPathFolder(sPath = "Glo", sFolder = "Strings") + sOutLiJson)+ "] file.\nAre you sure you want to continue?"
			STRING sDis = "Saving to [" +SetColor(sFacCo, sOutLiName)+ "]"
			INT iRet = -1
				If (StringUtil.Find(sOutLiOpt, "bAdd") > -1)
					sMsg = "This will add the [" +sStr+ "] to (" +sOutLiName+ ") list in [" +(GetPathFolder(sPath = "Glo", sFolder = "Strings") + sOutLiJson)+ "] file.\nAre you sure you want to continue?"
					sDis = "Adding to [" +SetColor(sFacCo, sOutLiName)+ "]"
				ElseIf (StringUtil.Find(sOutLiOpt, "bRem") > -1)
					sMsg = "This will remove the [" +sStr+ "] from (" +sOutLiName+ ") list in [" +(GetPathFolder(sPath = "Glo", sFolder = "Strings") + sOutLiJson)+ "] file.\nAre you sure you want to continue?"
					sDis = "Removing from [" +SetColor(sFacCo, sOutLiName)+ "]"
				EndIf
				If (ShowMessage(sMsg, a_withCancel = True))	
					ForceCloseMenu()
					Wait(0.6)
					iDDeUtil.Log("iDDeConfig.OnOptionSelect():-> ", sDis+ "...", 3, 1)
					iRet = AddStrToJsonList(sStr = sStr, sJson = (GetPathFolder(sPath = "Glo", sFolder = "Strings") + sOutLiJson), sList = sOutLiName, sOpt = sOutLiOpt)
					Wait(0.6)
						If (iRet)
							iDDeUtil.Log("iDDeConfig.OnOptionSelect():-> " +sDis+ "... Done!", sDis+ "... " +SetColor(sGooCo, "Done!"), 3, -1)
						Else
							iDDeUtil.Log("iDDeConfig.OnOptionSelect():-> " +sDis+ "... Failed!", sDis+ "... " +SetColor(sBadCo, "Failed!"), 3, -1)
						EndIf
				EndIf
		ElseIf (aiOption == oidKeysUnMap)
			RegisterHotKeys(sOpt = "UnMap")
		ElseIf (aiOption == oidExeFun)
			BOOL bAct = ShowMessage("Execute [" +sAdminFun+ "(" +sAdminOpt+ ")]?", a_withCancel = True)
				If (bAct)
					ForceCloseMenu()
					iDDeMis.ExeAdminFun(sAdminFun, sAdminOpt)
				EndIf
		Else
			Parent.OnOptionSelect(aiOption)
		EndIf
	ForcePageReset()
EndEvent
Function SetMenuOption(INT aiOption, INT aiIndex)
		If ((aiOption == oidDDeGag) || (aiOption == oidDDxGag) || (aiOption == oidDDeHood))
			SetoidGag(iOID = aiIndex, iSetOID = aiOption)
		ElseIf (aiOption == oidDDxHood)
			If (aiIndex != 0)
				iDDe.iDDeHood = 0
			EndIf
		ElseIf ((aiOption == oidDDeCollar) || (aiOption == oidDDxCollar) || (aiOption == oidCDxCollar)) 
			SetoidCollar(iOID = aiIndex, iSetOID = aiOption)
		ElseIf ((aiOption == oidDDeBra) || (aiOption == oidDDxBra) || (aiOption == oidCDxBra))
			SetoidBra(iOID = aiIndex, iSetOID = aiOption)
		ElseIf ((aiOption == oidDDePlugV) || (aiOption == oidDDxPlugV) || (aiOption == oidCDxPlugV))
			SetoidPlugV(iOID = aiIndex, iSetOID = aiOption)
		ElseIf ((aiOption == oidDDePlugA) || (aiOption == oidDDxPlugA) || (aiOption == oidCDxPlugA))
			SetoidPlugA(iOID = aiIndex, iSetOID = aiOption)
		ElseIf ((aiOption == oidDDeBelt) || (aiOption == oidDDxBelt) || (aiOption == oidCDxBelt))
			SetoidBelt(iOID = aiIndex, iSetOID = aiOption)
		ElseIf ((aiOption == oidDDeBoots) || (aiOption == oidDDxBoots))
			SetoidBoots(iOID = aiIndex, iSetOID = aiOption)
		ElseIf ((aiOption == oidDDeCuffsL) || (aiOption == oidDDxCuffsL) || (aiOption == oidCDxCuffsL))
			SetoidCuffsL(iOID = aiIndex, iSetOID = aiOption)
		ElseIf ((aiOption == oidDDeCuffsA) || (aiOption == oidDDxCuffsA) || (aiOption == oidCDxCuffsA))
			SetoidCuffsA(iOID = aiIndex, iSetOID = aiOption)
		ElseIf ((aiOption == oidDDeElbowBinder) || (aiOption == oidDDxElbowBinder) || (aiOption == oidDDeArmBinder) || (aiOption == oidDDxArmBinder) || \
						(aiOption == oidDDeYoke) || (aiOption == oidDDxYoke) || (aiOption == oidDDeShackles) || (aiOption == oidDDxShackles) || \
						(aiOption == oidDDePetSuit) || (aiOption == oidDDxPetSuit) || (aiOption == oidDDeBoxBinder) || (aiOption == oidDDxBoxBinder) || \
						(aiOption == oidDDeBoxBinderOut) || (aiOption == oidDDxBoxBinderOut))
			SetoidBinder(iOID = aiIndex, iSetOID = aiOption)
		ElseIf ((aiOption == oidDDeGloves) || (aiOption == oidDDxGloves)) 
			SetoidGloves(iOID = aiIndex, iSetOID = aiOption)
		ElseIf ((aiOption == oidDDeHarness) || (aiOption == oidDDxHarness) || (aiOption == oidDDxCorset))
			SetoidHarness(iOID = aiIndex, iSetOID = aiOption)
		ElseIf ((aiOption == oidDDeSuit) || (aiOption == oidDDxSuit) || (aiOption == oidDDeCatSuit) || (aiOption == oidDDxCatSuit) || (aiOption == oidDDeMech))
			SetoidSuit(iOID = aiIndex, iSetOID = aiOption)
		ElseIf ((aiOption == oidDDeBlindFold) || (aiOption == oidDDxBlindFold))
			SetoidBlindFold(iOID = aiIndex, iSetOID = aiOption)
		EndIf
	ForcePageReset()
EndFunction
Function SetInputOption(INT aiOption)
	;Password Selection
	;ppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp
		If (aiOption == oidInputPass)
			STRING sMsg
	      If (sInputPass == sExistPass)
	     		sMsg = "Correct!"
	     	Else
	     		sMsg = "Nope!"
	     	EndIf 
	   	ShowMessage(sMsg, False, "OK")
		ElseIf (aiOption == oidExistPass)	
			BOOL bContinue = True
			STRING sMsg 
	      If (sExistPass == sInputPass)
	      	sMsg = "Password is the same.\nAre you sure you want to continue?"
	      Else
	      	sMsg = "Old password is - > " +sExistPass+ "\nNew password is - > " +sInputPass+ "\nAre you sure you want to continue?"
	      EndIf
	      	bContinue = ShowMessage(sMsg, True, "Yes", "No")
			 			If (bContinue)
							sExistPass = sInputPass
							sInputPass = " "
						EndIf	
	;Custom Outfit Selection
	;ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc	
		ElseIf ((aiOption == oidSaveOutfitMCM) || (aiOption == oidDeleteOutfit) || (aiOption == oidSaveOutfitWorn))
			STRING s = iSUmUtil.GetSingleChaInStr(sCha = "[]()", sStr = sDDeOutCusSel)
				If (s)
					ShowMessage("[" +sDDeOutCusSel+ "] has a reserved character '" +s+ "'. Make sure you are not using reserved characters in the outfit name.\nReserved characters are ')][('.")
					RETURN
				EndIf
			INT iCount = JsonUtil.StringListCount(iDDe.sOutFoJs, sDDeOutCusSel)
				If (aiOption == oidSaveOutfitMCM)
					BOOL bGo = ShowMessage("This will save the current 'Devices Library' outfit as -> [" +sDDeOutCusSel+ "].\nAre you sure you want to continue?", a_withCancel = True)
						If (bGo)
							If (iCount)
								If (ShowMessage("Outfit already exists.\nOverride the existing outfit?", a_withCancel = True))
									JsonUtil.StringListClear(iDDe.sOutFoJs, sDDeOutCusSel)
								Else
									RETURN
								EndIf
							EndIf
							SaveJsonOutfit(aActor = None, sJfile = iDDe.sOutFoJs, sList = sDDeOutCusSel, sOutfit = iDDeLib.sDDeOutMisc[1], sOpt = "")
						EndIf
				ElseIf (aiOption == oidDeleteOutfit)
					BOOL bGo = ShowMessage("This will delete the [" +sDDeOutCusSel+ "] outfit.\nAre you sure you want to continue?", a_withCancel = True)
						If (bGo)
							If (iCount)
								JsonUtil.StringListClear(iDDe.sOutFoJs, sDDeOutCusSel)
								JsonUtil.Save(iDDe.sOutFoJs, False)
								sDDeOutCusSel = ""
							Else
								ShowMessage("Bad command or file name!")
							EndIf
						EndIf
				ElseIf (aiOption == oidSaveOutfitWorn)
					Actor aActor = aSelActor
					STRING sActor = sSelActor
						If (!aActor)
							ShowMessage("No actor selected.\nSelect an actor first.", a_withCancel = False)
						Else
							STRING sDDs = "DDs "
								If (sAllWornOpt)
									sDDs = ""
								EndIf
							BOOL bGo = ShowMessage("This will save all " +sDDs+ "worn by [" +sActor+ "] as -> [" +sDDeOutCusSel+ "].\nContinue?", a_withCancel = True)
								If (bGo)
									If (iCount)
										If (ShowMessage("Outfit already exists.\nOverride the existing outfit?", a_withCancel = True))
											JsonUtil.StringListClear(iDDe.sOutFoJs, sDDeOutCusSel)
										Else
											RETURN
										EndIf
									EndIf
									ForceCloseMenu()
									Wait(0.6)
									iDDeUtil.Log("iDDeConfig.SetInputOption():-> Saving outfit [" +sDDeOutCusSel+ "]...", "Saving outfit [" +SetColor(sOutCo, sDDeOutCusSel)+ "]...", 3, 2)
									SaveJsonOutfit(aActor = aActor, sJfile = iDDe.sOutFoJs, sList = sDDeOutCusSel, sOutfit = iDDeLib.sDDeOutMisc[6], sOpt = sAllWornOpt)
									Wait(0.6)
									iDDeUtil.Log("iDDeConfig.SetInputOption():-> Saving outfit [" +sDDeOutCusSel+ "]... Done!", "Saving outfit [" +SetColor(sOutCo, sDDeOutCusSel)+ "]... Done!", 3, 2)
								EndIf
						EndIf
				EndIf
		EndIf
	ForcePageReset()
EndFunction
Function SetSliderOptionAccept(INT aiOption)
	ForcePageReset()
EndFunction
Function SetToggleOption(INT aiOption)
		If (aiOption == oidRemQuestDD)
			If (iDDe.iDDeRemQuest)
				BOOL abAction = ShowMessage("Are you sure you want to remove quest items?", a_withCancel = True)
					If (abAction)
						abAction = ShowMessage("Are you really REALLY sure you want to remove quest items?", a_withCancel = True)
						If (abAction)
							abAction = ShowMessage("Is this your final answer?", a_withCancel = True)
								If (!abAction)
									iDDe.iDDeRemQuest = 0
								EndIf
						Else
							iDDe.iDDeRemQuest = 0
						EndIf
					Else
						iDDe.iDDeRemQuest = 0
					EndIf
			EndIf	
		EndIf
	ForcePageReset()
EndFunction

FLOAT Function GetFloat(INT aiOption)
	;Something
		If (aiOption == oidDevOptsPg)
			RETURN iDevOptsPg
		ElseIf (aiOption == oidActJsPerPg)
			RETURN iActJsPerPg
		ElseIf (aiOption == oidActLiPerPg)
			RETURN iActLiPerPg
		ElseIf (aiOption == oidConFiPerPg)
			RETURN iConFiPerPg
		ElseIf (aiOption == oidActPerPg)
			RETURN iActPerPg	
		ElseIf (aiOption == oidOutPerPg)
			RETURN iOutPerPg
		ElseIf (aiOption == oidOutJsPerPg)
			RETURN iOutJsPerPg
		ElseIf (aiOption == oidOutRegPerPg)
			RETURN iOutRegPerPg
		ElseIf (aiOption == oidOutDrePerPg)
			RETURN iOutDrePerPg		
		ElseIf (aiOption == oidActLoadOpt)
			RETURN iActLoadOpt
		ElseIf (aiOption == oidSelfTimer) ;Device Interaction Page
			RETURN StorageUtil.GetFloatValue(aSelActor, "iDDefSelfTimer", 0) 
		ElseIf (aiOption == oidMechPow)
			RETURN iDDe.iMechPow
		ElseIf (aiOption == oidMechPowSnd)
			RETURN iDDe.iMechPowSnd
		ElseIf (aiOption == oidRefreshRate) 
			RETURN iDDe.fDDeRefreshRate
		ElseIf (aiOption == oidActPg) ;Paging
			RETURN _iL1P
		ElseIf ((aiOption == oidOutJsPg) || (aiOption == oidOutRegPg) || (aiOption == oidActJsPg) || (aiOption == oidConFiPg))
			RETURN _iA1P
		ElseIf ((aiOption == oidOutPg) || (aiOption == oidOutDrePg) || (aiOption == oidActLiPg))
			RETURN _iA2P
		EndIf
 iSUmUtil.Log("iDDeConfig.GetFloat():-> ", "Unregistered item requested.")
 RETURN 0.0
EndFunction
Function SetFloat(Int aiOption, Float afValue)
	INT aiValue = (afValue AS INT)
		If (aiOption == oidActJsPerPg)
			iActJsPerPg = aiValue	
		ElseIf (aiOption == oidActLiPerPg)
			iActLiPerPg = aiValue	
		ElseIf (aiOption == oidConFiPerPg)
			iConFiPerPg = aiValue	
		ElseIf (aiOption == oidActPerPg)
			iActPerPg = aiValue	
		ElseIf (aiOption == oidOutPerPg)
			iOutPerPg = aiValue
		ElseIf (aiOption == oidOutJsPerPg)
			iOutJsPerPg = aiValue
		ElseIf (aiOption == oidOutRegPerPg)
			iOutRegPerPg = aiValue
		ElseIf (aiOption == oidOutDrePerPg)
			iOutDrePerPg = aiValue
		ElseIf (aiOption == oidActLoadOpt)
			iActLoadOpt = aiValue
		ElseIf (aiOption == oidSelfTimer)
			StorageUtil.SetFloatValue(aSelActor, "iDDefSelfTimer", afValue)
		ElseIf (aiOption == oidMechPow)
			iDDe.iMechPow = aiValue	
		ElseIf (aiOption == oidMechPowSnd)
			iDDe.iMechPowSnd = aiValue
		ElseIf (aiOption == oidDevOptsPg)
			iDevOptsPg = aiValue
		ElseIf (aiOption == oidRefreshRate) 
			iDDe.fDDeRefreshRate = afValue
		ElseIf (aiOption == oidActPg) ;Paging
			_iL1P = aiValue
		ElseIf ((aiOption == oidOutJsPg) || (aiOption == oidOutRegPg) || (aiOption == oidActJsPg) || (aiOption == oidConFiPg))
			_iA1P = aiValue
		ElseIf ((aiOption == oidOutPg) || (aiOption == oidOutDrePg) || (aiOption == oidActLiPg))
			_iA2P = aiValue
		EndIf
EndFunction

INT Function GetInt(INT aiOption)
	;Something
		If (aiOption == oid86Device)
			RETURN iDDe.iDDe86Device
		ElseIf (aiOption == oidStripForDD)
			RETURN iDDe.iDDeStrip
		ElseIf (aiOption == oidHardCoreDD)
			RETURN iDDe.iDDeHardCore
		ElseIf (aiOption == oidRemQuestDD)
			RETURN iDDe.iDDeRemQuest
		ElseIf (aiOption == oidDDeGag) ;Device Library Page
			RETURN iDDe.iDDeGag
		ElseIf (aiOption == oidDDxGag)
			RETURN iDDe.iDDxGag
		ElseIf (aiOption == oidDDeHood)
			RETURN iDDe.iDDeHood
		ElseIf (aiOption == oidDDxHood)
			RETURN iDDe.iDDxHood
		ElseIf (aiOption == oidDDeCollar)
			RETURN iDDe.iDDeCollar	
		ElseIf (aiOption == oidDDxCollar)
			RETURN iDDe.iDDxCollar	
		ElseIf (aiOption == oidCDxCollar)
			RETURN iDDe.iCDxCollar		
		ElseIf (aiOption == oidDDeBra)
			RETURN iDDe.iDDeBra
		ElseIf (aiOption == oidDDxBra)
			RETURN iDDe.iDDxBra
		ElseIf (aiOption == oidDDeBra)
			RETURN iDDe.iDDeBra	
		ElseIf (aiOption == oidDDeElbowBinder) 
			RETURN iDDe.iDDeElbowBinder
		ElseIf (aiOption == oidDDxElbowBinder) 
			RETURN iDDe.iDDxElbowBinder
		ElseIf (aiOption == oidDDeArmBinder) 
			RETURN iDDe.iDDeArmBinder
		ElseIf (aiOption == oidDDxArmBinder) 
			RETURN iDDe.iDDxArmBinder
		ElseIf (aiOption == oidDDeYoke) 
			RETURN iDDe.iDDeYoke
		ElseIf (aiOption == oidDDxYoke) 
			RETURN iDDe.iDDxYoke
		ElseIf (aiOption == oidDDeShackles) 
			RETURN iDDe.iDDeShackles
		ElseIf (aiOption == oidDDxShackles) 
			RETURN iDDe.iDDxShackles	
		ElseIf (aiOption == oidDDePetSuit) 
			RETURN iDDe.iDDePetSuit
		ElseIf (aiOption == oidDDxPetSuit) 
			RETURN iDDe.iDDxPetSuit
		ElseIf (aiOption == oidDDeBoxBinder) 
			RETURN iDDe.iDDeBoxBinder
		ElseIf (aiOption == oidDDxBoxBinder) 
			RETURN iDDe.iDDxBoxBinder
		ElseIf (aiOption == oidDDeBoxBinderOut) 
			RETURN iDDe.iDDeBoxBinderOut
		ElseIf (aiOption == oidDDxBoxBinderOut) 
			RETURN iDDe.iDDxBoxBinderOut
		ElseIf (aiOption == oidDDeBelt)
			RETURN iDDe.iDDeBelt	
		ElseIf (aiOption == oidDDxBelt)
			RETURN iDDe.iDDxBelt	
		ElseIf (aiOption == oidCDxBelt)
			RETURN iDDe.iCDxBelt	
		ElseIf (aiOption == oidDDeBoots)	
			RETURN iDDe.iDDeBoots
		ElseIf (aiOption == oidDDxBoots)	
			RETURN iDDe.iDDxBoots	
		ElseIf (aiOption == oidDDePlugA)
			RETURN iDDe.iDDePlugA 
		ElseIf (aiOption == oidDDxPlugA)
			RETURN iDDe.iDDxPlugA 
		ElseIf (aiOption == oidCDxPlugA)
			RETURN iDDe.iCDxPlugA 
		ElseIf (aiOption == oidDDePlugV)
			RETURN iDDe.iDDePlugV	
		ElseIf (aiOption == oidDDxPlugV)
			RETURN iDDe.iDDxPlugV	
		ElseIf (aiOption == oidCDxPlugV)
			RETURN iDDe.iCDxPlugV
		ElseIf (aiOption == oidDDeSuit)
			RETURN iDDe.iDDeSuit	
		ElseIf (aiOption == oidDDxSuit)
			RETURN iDDe.iDDxSuit
		ElseIf (aiOption == oidDDeCatSuit)
			RETURN iDDe.iDDeCatSuit	
		ElseIf (aiOption == oidDDxCatSuit)
			RETURN iDDe.iDDxCatSuit
		ElseIf (aiOption == oidDDeBlindFold)
			RETURN iDDe.iDDeBlind
		ElseIf (aiOption == oidDDxBlindFold)
			RETURN iDDe.iDDxBlind
		ElseIf (aiOption == oidDDxPieN)
			RETURN iDDe.iDDxPieN
		ElseIf (aiOption == oidDDxPieV)
			RETURN iDDe.iDDxPieV
		ElseIf (aiOption == oidDDeCuffsA)
			RETURN iDDe.iDDeCuffsA
		ElseIf (aiOption == oidDDxCuffsA)
			RETURN iDDe.iDDxCuffsA
		ElseIf (aiOption == oidCDxCuffsA)
			RETURN iDDe.iCDxCuffsA
		ElseIf (aiOption == oidDDeGloves)
			RETURN iDDe.iDDeGloves	
		ElseIf (aiOption == oidDDxGloves)
			RETURN iDDe.iDDxGloves
		ElseIf (aiOption == oidDDeHarness)
			RETURN iDDe.iDDeHarness
		ElseIf (aiOption == oidDDxHarness)
			RETURN iDDe.iDDxHarness	
		ElseIf (aiOption == oidDDxCorset)
			RETURN iDDe.iDDxCorset
		ElseIf (aiOption == oidDDeCuffsL)
			RETURN iDDe.iDDeCuffsL
		ElseIf (aiOption == oidDDxCuffsL)
			RETURN iDDe.iDDxCuffsL
		ElseIf (aiOption == oidCDxCuffsL)
			RETURN iDDe.iCDxCuffsL
		ElseIf (aiOption == oidBinderEff) ;Devices Effects Page
			RETURN iDDe.iDDeBinderEff
		ElseIf (aiOption == oidAnklesEff) 
			RETURN StorageUtil.GetIntValue(aSelActor, "iDDeAnklesEff", 0)
		ElseIf (aiOption == oidArmFight)
			RETURN iDDe.iDDeArmFight
		ElseIf (aiOption == oidArmSneak)
			RETURN iDDe.iDDeArmSneak
		ElseIf (aiOption == oidArmMenu)
			RETURN iDDe.iDDeArmMenu
		ElseIf (aiOption == oidArmActive)
			RETURN iDDe.iDDeArmActive
		ElseIf (aiOption == oidArmTravel)
			RETURN iDDe.iDDeArmTravel
		ElseIf (aiOption == oidArmWait)
			RETURN iDDe.iDDeArmWait
		ElseIf (aiOption == oidArmTalk)
			RETURN iDDe.iDDeArmTalk
		ElseIf (aiOption == oidArmStruggle)
			RETURN iDDe.iDDeArmStruggle
		ElseIf (aiOption == oidPickPlugEff)
			RETURN iDDe.iDDePickPlugEff
		ElseIf (aiOption == oidPlugRibbed)
			RETURN iDDe.iDDePlugRibbed
		ElseIf (aiOption == oidPlugShocker)
			RETURN iDDe.iDDePlugShocker
		ElseIf (aiOption == oidPlugFusStag)
			RETURN iDDe.iDDePlugFusStag
		ElseIf (aiOption == oidPlugLinked)
			RETURN iDDe.iDDePlugLinked
		ElseIf (aiOption == oidPlugLively)
			RETURN iDDe.iDDePlugLively
		ElseIf (aiOption == oidPlugEleStim)
			RETURN iDDe.iDDePlugEleStim
		ElseIf (aiOption == oidPlugEdgeRand)
			RETURN iDDe.iDDePlugEdgeRand
		ElseIf (aiOption == oidPlugEdgeOnly)
			RETURN iDDe.iDDePlugEdgeOnly
		ElseIf (aiOption == oidPlugPoss)
			RETURN iDDe.iDDePlugPoss
		ElseIf (aiOption == oidPlugTrain)
			RETURN iDDe.iDDePlugTrain
		ElseIf (aiOption == oidPlugDrainH)
			RETURN iDDe.iDDePlugDrainH
		ElseIf (aiOption == oidPlugDrainS)
			RETURN iDDe.iDDePlugDrainS
		ElseIf (aiOption == oidPlugDrainM)
			RETURN iDDe.iDDePlugDrainM
		ElseIf (aiOption == oidPlugVeLively)
			RETURN iDDe.iDDePlugVeLively
		ElseIf (aiOption == oidPlugVibCast)
			RETURN iDDe.iDDePlugVibCast
		ElseIf (aiOption == oidPlugVib)
			RETURN iDDe.iDDePlugVib
		ElseIf (aiOption == oidPlugVibRand)
			RETURN iDDe.iDDePlugVibRand
		ElseIf (aiOption == oidPlugVibStrg)
			RETURN iDDe.iDDePlugVibStrg
		ElseIf (aiOption == oidPlugVibWeak)
			RETURN iDDe.iDDePlugVibWeak
 		ElseIf (aiOption == oidPlugVibVeStrg)
			RETURN iDDe.iDDePlugVibVeStrg
		ElseIf (aiOption == oidPlugVibVeWeak)
			RETURN iDDe.iDDePlugVibVeWeak
		ElseIf (aiOption == oidMechFX)
			RETURN iDDe.iDDeMechFX
		ElseIf (aiOption == oidMechJump)
			RETURN iDDe.iDDeMechJump
		ElseIf (aiOption == oidMechDisarm)
			RETURN iDDe.iDDeMechDisarm
		ElseIf (aiOption == oidMechNoActivate)
			RETURN iDDe.iDDeMechNoActivate
		ElseIf (aiOption == oidMechNoFighting)
			RETURN iDDe.iDDeMechNoFighting
		ElseIf (aiOption == oidMechNoMenu)
			RETURN iDDe.iDDeMechNoMenu
		ElseIf (aiOption == oidMechNoFastTravel)
			RETURN iDDe.iDDeMechNoFastTravel
		ElseIf (aiOption == oidMechNoMove)
			RETURN iDDe.iDDeMechNoMove
		ElseIf (aiOption == oidMechNoSneak)
			RETURN iDDe.iDDeMechNoSneak
		ElseIf (aiOption == oidMechNoSprint)
			RETURN iDDe.iDDeMechNoSprint
		ElseIf (aiOption == oidMechNoWait)
			RETURN iDDe.iDDeMechNoWait
		ElseIf (aiOption == oidDDeMech)
			RETURN iDDe.iDDeMech	
		ElseIf (aiOption == oidBlockActArm)
			RETURN iDDe.iDDeBlockActArm
		ElseIf (aiOption == oidBlockActMit)
			RETURN iDDe.iDDeBlockActMit	
		ElseIf (aiOption == oidEnableBondFX)
			RETURN iDDe.iEnableBondFX
		ElseIf (aiOption == oidKeyActSel)
			RETURN iKeyActSel
		ElseIf (aiOption == oidKeySelfBond)
			RETURN iKeySelfBond
		ElseIf (aiOption == oidOutLocAdd)
			RETURN iOutLocAdd
		ElseIf (aiOption == oidOutCusAdd)
			RETURN iOutCusAdd
		ElseIf (GetOidIdx(oidPickSuit, aiOption) != -1)
			RETURN iPickSuit[idxOid]
		ElseIf (GetOidIdx(oidPickGag, aiOption) != -1)
			RETURN iPickGag[idxOid]
		ElseIf (GetOidIdx(oidPickHood, aiOption) != -1)
			RETURN iPickHood[idxOid]
		ElseIf (GetOidIdx(oidPickBinder, aiOption) != -1)
			RETURN iPickBinder[idxOid]
		ElseIf (GetOidIdx(oidPickBlinder, aiOption) != -1)
			RETURN iPickBlinder[idxOid]
		ElseIf (GetOidIdx(oidPickCollar, aiOption) != -1)
			RETURN iPickCollar[idxOid]
		ElseIf (GetOidIdx(oidPickGloves, aiOption) != -1)
			RETURN iPickGloves[idxOid]
		ElseIf (GetOidIdx(oidPickBoots, aiOption) != -1)
			RETURN iPickBoots[idxOid]
		ElseIf (GetOidIdx(oidPickBelt, aiOption) != -1)
			RETURN iPickBelt[idxOid]
		ElseIf (GetOidIdx(oidPickHarn, aiOption) != -1)
			RETURN iPickHarn[idxOid]
		ElseIf (GetOidIdx(oidPickPlugA, aiOption) != -1)
			RETURN iPickPlugA[idxOid]
		ElseIf (GetOidIdx(oidPickPlugV, aiOption) != -1)
			RETURN iPickPlugV[idxOid]
		ElseIf (GetOidIdx(oidPickPieV, aiOption) != -1)
			RETURN iPickPieV[idxOid]
		ElseIf (GetOidIdx(oidPickPieN, aiOption) != -1)
			RETURN iPickPieN[idxOid]
		ElseIf (GetOidIdx(oidPickCuffsA, aiOption) != -1)
			RETURN iPickCuffsA[idxOid]
		ElseIf (GetOidIdx(oidPickCuffsL, aiOption) != -1)
			RETURN iPickCuffsL[idxOid]
		ElseIf (GetOidIdx(oidPickBra, aiOption) != -1)
			RETURN iPickBra[idxOid]
		ElseIf (aiOption == oidDisInfo);Debug Page
			RETURN StorageUtil.GetIntValue(None, "iDDeDisplayInfo", 0)
		ElseIf (aiOption == oidConInfo)
			RETURN StorageUtil.GetIntValue(None, "iDDeConsoleInfo", 0)
		ElseIf (aiOption == oidDebInfo)
			RETURN StorageUtil.GetIntValue(None, "iDDeDebugInfo", 0)
		ElseIf (aiOption == oidUtilityTask)
			RETURN iDDe.iDDeUtilityTask.GetValueInt()
		EndIf
	iDDeUtil.Log("iDDeConfig.GetInt():-> ", "Unregistered item requested.")
	RETURN 0
EndFunction
Function SetInt(Int aiOption, INT aiValue)
	;Something
		If (aiOption == oidDDeBlindFold)
			iDDe.iDDeBlind = aiValue
		ElseIf (aiOption == oidDDxBlindFold)
			iDDe.iDDxBlind = aiValue
		ElseIf (aiOption == oidDDeGag)
			iDDe.iDDeGag = aiValue
		ElseIf (aiOption == oidDDxGag)
			iDDe.iDDxGag = aiValue
		ElseIf (aiOption == oidDDeHood)
			iDDe.iDDeHood = aiValue
		ElseIf (aiOption == oidDDxHood)
			iDDe.iDDxHood = aiValue
		ElseIf (aiOption == oidDDeCollar)
			iDDe.iDDeCollar = aiValue
		ElseIf (aiOption == oidDDxCollar)
			iDDe.iDDxCollar = aiValue
		ElseIf (aiOption == oidCDxCollar)
			iDDe.iCDxCollar = aiValue
		ElseIf (aiOption == oidDDeBra)
			iDDe.iDDeBra = aiValue
		ElseIf (aiOption == oidDDxBra)
			iDDe.iDDxBra = aiValue
		ElseIf (aiOption == oidCDxBra)
			iDDe.iCDxBra = aiValue
		ElseIf (aiOption == oidDDxPieN)
			iDDe.iDDxPieN = aiValue
		ElseIf (aiOption == oidDDxPieV)
			iDDe.iDDxPieV = aiValue
		ElseIf (aiOption == oidDDeCuffsA)
			iDDe.iDDeCuffsA = aiValue
		ElseIf (aiOption == oidDDxCuffsA)
			iDDe.iDDxCuffsA = aiValue
		ElseIf (aiOption == oidCDxCuffsA)
			iDDe.iCDxCuffsA = aiValue
		ElseIf (aiOption == oidDDeCuffsL)
			iDDe.iDDeCuffsL = aiValue
		ElseIf (aiOption == oidDDxCuffsL)
			iDDe.iDDxCuffsL = aiValue
		ElseIf (aiOption == oidCDxCuffsL)
			iDDe.iCDxCuffsL = aiValue		
		ElseIf (aiOption == oidDDeElbowBinder) 
			iDDe.iDDeElbowBinder = aiValue
		ElseIf (aiOption == oidDDxElbowBinder) 
			iDDe.iDDxElbowBinder = aiValue	
		ElseIf (aiOption == oidDDeArmBinder) 
			iDDe.iDDeArmBinder = aiValue
		ElseIf (aiOption == oidDDxArmBinder) 
			iDDe.iDDxArmBinder = aiValue	
		ElseIf (aiOption == oidDDeYoke) 
			iDDe.iDDeYoke = aiValue
		ElseIf (aiOption == oidDDxYoke) 
			iDDe.iDDxYoke = aiValue	
		ElseIf (aiOption == oidDDeShackles) 
			iDDe.iDDeShackles = aiValue
		ElseIf (aiOption == oidDDxShackles) 
			iDDe.iDDxShackles = aiValue		
		ElseIf (aiOption == oidDDePetSuit) 
			iDDe.iDDePetSuit = aiValue
		ElseIf (aiOption == oidDDxPetSuit) 
			iDDe.iDDxPetSuit = aiValue	
		ElseIf (aiOption == oidDDeBoxBinder) 
			iDDe.iDDeBoxBinder = aiValue
		ElseIf (aiOption == oidDDxBoxBinder) 
			iDDe.iDDxBoxBinder = aiValue
		ElseIf (aiOption == oidDDeBoxBinderOut) 
			iDDe.iDDeBoxBinderOut = aiValue
		ElseIf (aiOption == oidDDxBoxBinderOut) 
			iDDe.iDDxBoxBinderOut = aiValue			
		ElseIf (aiOption == oidDDeBelt)
			iDDe.iDDeBelt = aiValue
		ElseIf (aiOption == oidDDxBelt)
			iDDe.iDDxBelt = aiValue
		ElseIf (aiOption == oidCDxBelt)
			iDDe.iCDxBelt = aiValue
		ElseIf (aiOption == oidDDeHarness)
			iDDe.iDDeHarness = aiValue 
		ElseIf (aiOption == oidDDxHarness)
			iDDe.iDDxHarness = aiValue
		ElseIf (aiOption == oidDDePlugA)
			iDDe.iDDePlugA = aiValue 
		ElseIf (aiOption == oidDDxPlugA)
			iDDe.iDDxPlugA = aiValue
		ElseIf (aiOption == oidCDxPlugA)
			iDDe.iCDxPlugA = aiValue
		ElseIf (aiOption == oidDDePlugV)
			iDDe.iDDePlugV = aiValue
		ElseIf (aiOption == oidDDxPlugV)
			iDDe.iDDxPlugV = aiValue
		ElseIf (aiOption == oidCDxPlugV)
			iDDe.iCDxPlugV = aiValue
		ElseIf (aiOption == oidDDxCorset) 
			iDDe.iDDxCorset = aiValue
		ElseIf (aiOption == oidDDeGloves)
			iDDe.iDDeGloves = aiValue
		ElseIf (aiOption == oidDDxGloves)
			iDDe.iDDxGloves = aiValue
		ElseIf (aiOption == oidDDeBoots)
			iDDe.iDDeBoots = aiValue
		ElseIf (aiOption == oidDDxBoots)
			iDDe.iDDxBoots = aiValue
		ElseIf (aiOption == oidDDeSuit)
			iDDe.iDDeSuit = aiValue
		ElseIf (aiOption == oidDDxSuit)
			iDDe.iDDxSuit = aiValue
		ElseIf (aiOption == oidDDeCatSuit)
			iDDe.iDDeCatSuit = aiValue
		ElseIf (aiOption == oidDDxCatSuit)
			iDDe.iDDxCatSuit = aiValue
		ElseIf (aiOption == oid86Device)
			iDDe.iDDe86Device = aiValue	
		ElseIf (aiOption == oidStripForDD)
			iDDe.iDDeStrip = aiValue	
		ElseIf (aiOption == oidHardCoreDD)
			iDDe.iDDeHardCore = aiValue
		ElseIf (aiOption == oidBinderEff) ;Device Eff
			iDDe.iDDeBinderEff = aiValue
		ElseIf (aiOption == oidAnklesEff)
			StorageUtil.SetIntValue(aSelActor, "iDDeAnklesEff", aiValue)
		ElseIf (aiOption == oidArmFight)
			iDDe.iDDeArmFight = aiValue
		ElseIf (aiOption == oidArmSneak)
			iDDe.iDDeArmSneak = aiValue
		ElseIf (aiOption == oidArmMenu)
			iDDe.iDDeArmMenu = aiValue
		ElseIf (aiOption == oidArmActive)
			iDDe.iDDeArmActive = aiValue
		ElseIf (aiOption == oidArmTravel)
			iDDe.iDDeArmTravel = aiValue
		ElseIf (aiOption == oidArmWait)
			iDDe.iDDeArmWait = aiValue
		ElseIf (aiOption == oidArmTalk)
			iDDe.iDDeArmTalk = aiValue
		ElseIf (aiOption == oidArmStruggle)
			iDDe.iDDeArmStruggle = aiValue
		ElseIf (aiOption == oidPickPlugEff)
			iDDe.iDDePickPlugEff = aiValue
		ElseIf (aiOption == oidPlugRibbed)
			iDDe.iDDePlugRibbed = aiValue
		ElseIf (aiOption == oidPlugShocker)
			iDDe.iDDePlugShocker = aiValue
		ElseIf (aiOption == oidPlugFusStag)
			iDDe.iDDePlugFusStag = aiValue
		ElseIf (aiOption == oidPlugLinked)
			iDDe.iDDePlugLinked = aiValue
		ElseIf (aiOption == oidPlugLively)
			iDDe.iDDePlugLively = aiValue
		ElseIf (aiOption == oidPlugEleStim)
			iDDe.iDDePlugEleStim = aiValue
		ElseIf (aiOption == oidPlugEdgeRand)
			iDDe.iDDePlugEdgeRand = aiValue
		ElseIf (aiOption == oidPlugEdgeOnly)
			iDDe.iDDePlugEdgeOnly = aiValue
		ElseIf (aiOption == oidPlugPoss)
			iDDe.iDDePlugPoss = aiValue
		ElseIf (aiOption == oidPlugTrain)
			iDDe.iDDePlugTrain = aiValue
		ElseIf (aiOption == oidPlugDrainH)
			iDDe.iDDePlugDrainH = aiValue
		ElseIf (aiOption == oidPlugDrainS)
			iDDe.iDDePlugDrainS = aiValue
		ElseIf (aiOption == oidPlugDrainM)
			iDDe.iDDePlugDrainM = aiValue
		ElseIf (aiOption == oidPlugVeLively)
			iDDe.iDDePlugVeLively = aiValue
		ElseIf (aiOption == oidPlugVibCast)
			iDDe.iDDePlugVibCast = aiValue
		ElseIf (aiOption == oidPlugVib)
			iDDe.iDDePlugVib = aiValue
		ElseIf (aiOption == oidPlugVibRand)
			iDDe.iDDePlugVibRand = aiValue
		ElseIf (aiOption == oidPlugVibStrg)
			iDDe.iDDePlugVibStrg = aiValue
		ElseIf (aiOption == oidPlugVibWeak)
			iDDe.iDDePlugVibWeak = aiValue
 		ElseIf (aiOption == oidPlugVibVeStrg)
			iDDe.iDDePlugVibVeStrg = aiValue
		ElseIf (aiOption == oidPlugVibVeWeak)
			iDDe.iDDePlugVibVeWeak = aiValue
		ElseIf (aiOption == oidRemQuestDD)
			iDDe.iDDeRemQuest = aiValue
		ElseIf (aiOption == oidMechFX)
			iDDe.iDDeMechFX = aiValue
		ElseIf (aiOption == oidMechJump)
			iDDe.iDDeMechJump = aiValue
		ElseIf (aiOption == oidMechDisarm)
			iDDe.iDDeMechDisarm = aiValue
		ElseIf (aiOption == oidMechNoActivate)
			iDDe.iDDeMechNoActivate = aiValue
		ElseIf (aiOption == oidMechNoFighting)
			iDDe.iDDeMechNoFighting = aiValue
		ElseIf (aiOption == oidMechNoMenu)
			iDDe.iDDeMechNoMenu = aiValue
		ElseIf (aiOption == oidMechNoFastTravel)
			iDDe.iDDeMechNoFastTravel = aiValue
		ElseIf (aiOption == oidMechNoMove)
			iDDe.iDDeMechNoMove = aiValue
		ElseIf (aiOption == oidMechNoSneak)
			iDDe.iDDeMechNoSneak = aiValue
		ElseIf (aiOption == oidMechNoSprint)
			iDDe.iDDeMechNoSprint = aiValue
		ElseIf (aiOption == oidMechNoWait)
			iDDe.iDDeMechNoWait = aiValue
		ElseIf (aiOption == oidDDeMech)
			iDDe.iDDeMech = aiValue
		ElseIf (aiOption == oidBlockActArm)
			iDDe.iDDeBlockActArm = aiValue
		ElseIf (aiOption == oidBlockActMit)
			iDDe.iDDeBlockActMit = aiValue	
		ElseIf (aiOption == oidEnableBondFX)
			iDDe.iEnableBondFX = aiValue
		ElseIf (aiOption == oidKeyActSel)
			iKeyActSel = aiValue
		ElseIf (aiOption == oidKeySelfBond)
			iKeySelfBond = aiValue	
		ElseIf (aiOption == oidOutLocAdd)
			iOutLocAdd = aiValue
		ElseIf (aiOption == oidOutCusAdd)
			iOutCusAdd = aiValue
		ElseIf (GetOidIdx(oidPickSuit, aiOption) != -1)
			iPickSuit[idxOid] = aiValue
		ElseIf (GetOidIdx(oidPickGag, aiOption) != -1)
			iPickGag[idxOid] = aiValue
		ElseIf (GetOidIdx(oidPickHood, aiOption) != -1)
			iPickHood[idxOid] = aiValue
		ElseIf (GetOidIdx(oidPickBinder, aiOption) != -1)
			iPickBinder[idxOid] = aiValue
		ElseIf (GetOidIdx(oidPickBlinder, aiOption) != -1)
			iPickBlinder[idxOid] = aiValue
		ElseIf (GetOidIdx(oidPickCollar, aiOption) != -1)
			iPickCollar[idxOid] = aiValue
		ElseIf (GetOidIdx(oidPickGloves, aiOption) != -1)
			iPickGloves[idxOid] = aiValue
		ElseIf (GetOidIdx(oidPickBoots, aiOption) != -1)
			iPickBoots[idxOid] = aiValue	
		ElseIf (GetOidIdx(oidPickBelt, aiOption) != -1)
			iPickBelt[idxOid] = aiValue	
		ElseIf (GetOidIdx(oidPickHarn, aiOption) != -1)
			iPickHarn[idxOid] = aiValue		
		ElseIf (GetOidIdx(oidPickPlugA, aiOption) != -1)
			iPickPlugA[idxOid] = aiValue	
		ElseIf (GetOidIdx(oidPickPlugV, aiOption) != -1)
			iPickPlugV[idxOid] = aiValue		
		ElseIf (GetOidIdx(oidPickPieV, aiOption) != -1)
			iPickPieV[idxOid] = aiValue	
		ElseIf (GetOidIdx(oidPickPieN, aiOption) != -1)
			iPickPieN[idxOid] = aiValue	
		ElseIf (GetOidIdx(oidPickCuffsA, aiOption) != -1)
			iPickCuffsA[idxOid] = aiValue	
		ElseIf (GetOidIdx(oidPickCuffsL, aiOption) != -1)
			iPickCuffsL[idxOid] = aiValue	
		ElseIf (GetOidIdx(oidPickBra, aiOption) != -1)
			iPickBra[idxOid] = aiValue		
		ElseIf (aiOption == oidDisInfo) ;Debug
			StorageUtil.SetIntValue(None, "iDDeDisplayInfo", aiValue)
		ElseIf (aiOption == oidConInfo)
			StorageUtil.SetIntValue(None, "iDDeConsoleInfo", aiValue)
		ElseIf (aiOption == oidDebInfo)
			StorageUtil.SetIntValue(None, "iDDeDebugInfo", aiValue)
		ElseIf (aiOption == oidUtilityTask)
			iDDe.iDDeUtilityTask.SetValueInt(aiValue)
		EndIf
EndFunction
 
STRING Function GetString(INT aiOption)
		If ((aiOption == oidInputPass) || (aiOption == oidExistPass))
			RETURN sInputPass
		ElseIf ((aiOption == oidSaveOutfitMCM) || (aiOption == oidDeleteOutfit) || (aiOption == oidSaveOutfitWorn))
			RETURN sDDeOutCusSel
		ElseIf (aiOption == oidConFile)
			RETURN sConFile
		ElseIf (aiOption == oidNoStrip)
			RETURN iDDe.sDDeNoStrip
		ElseIf (aiOption == oidActFolder)
			RETURN iDDe.sActFolder
		ElseIf (aiOption == oidOutFolder)
			RETURN iDDe.sOutFolder
		ElseIf (aiOption == oidOutJson)
			RETURN iDDe.sOutJson
		ElseIf (aiOption == oidAdminOpt)
			RETURN sAdminOpt
		ElseIf (aiOption == oidAdminFun)
			RETURN sAdminFun
		ElseIf (aiOption == oidAutoStoActor)
			RETURN sAutoStoActor
		ElseIf (aiOption == oidActList)
			RETURN sActLi
		ElseIf (aiOption == oidActJson)
			RETURN iDDe.sActJson
		ElseIf (aiOption == oidActStr)
			RETURN sActStr
		ElseIf (aiOption == oidActInf)
			RETURN sActInf
		ElseIf (aiOption == oidAllWornOpt)
			RETURN sAllWornOpt
		ElseIf (aiOption == oidOutLocEdit)
			RETURN sDDeOutLoc
		ElseIf (aiOption == oidOutCusEdit)
			RETURN sDDeOutCus
		ElseIf (aiOption == oidOutLiJson)
			RETURN sOutLiJson
		ElseIf (aiOption == oidOutLiName)
			RETURN sOutLiName
		ElseIf (aiOption == oidOutLiOpt)
			RETURN sOutLiOpt
		ElseIf (aiOption == oidOutCo) ;Color
			RETURN sOutCo
		ElseIf (aiOption == oidOutLoCo)
			RETURN sOutLoCo
		ElseIf (aiOption == oidOutJsCo)
			RETURN sOutJsCo
		ElseIf (aiOption == oidActCo)
			RETURN sActCo
		ElseIf (aiOption == oidActLiCo)
			RETURN sActLiCo
		ElseIf (aiOption == oidActJsCo)
			RETURN sActJsCo
		ElseIf (aiOption == oidConJsCo)
			RETURN sConJsCo
		ElseIf (aiOption == oidFacCo)
			RETURN sFacCo
		ElseIf (aiOption == oidGooCo)
			RETURN sGooCo
		ElseIf (aiOption == oidBadCo)
			RETURN sBadCo
		ElseIf (aiOption == oidDisCo)
			RETURN StorageUtil.GetStringValue(None, "iDDeLogColor")	
		EndIf
	iDDeUtil.Log("iDDeConfig.GetString():-> ", "Unregistered string requested.", 1)
	RETURN ""
EndFunction
Function SetString(INT aiOption, STRING asValue)
	STRING sRGB = asValue
		If ((aiOption == oidInputPass) || (aiOption == oidExistPass))
			sInputPass = asValue
		ElseIf ((aiOption == oidSaveOutfitMCM) || (aiOption == oidDeleteOutfit) || (aiOption == oidSaveOutfitWorn))
			sDDeOutCusSel = AppendStr(sDDeOutCusSel, asValue)
		ElseIf (aiOption == oidConFile)
			sConFile = AppendStr(sConFile, asValue)
		ElseIf (aiOption == oidNoStrip)
			iDDe.sDDeNoStrip = AppendStr(iDDe.sDDeNoStrip, asValue)
		ElseIf (aiOption == oidActFolder)
			iDDe.sActFolder = AppendStr(iDDe.sActFolder, asValue)
		ElseIf (aiOption == oidOutFolder)
			iDDe.sOutFolder = AppendStr(iDDe.sOutFolder, asValue)
		ElseIf (aiOption == oidOutJson)
			iDDe.sOutJson = AppendStr(iDDe.sOutJson, asValue)
		ElseIf (aiOption == oidAdminOpt)
			sAdminOpt = AppendStr(sAdminOpt, asValue)
		ElseIf (aiOption == oidAdminFun)
			sAdminFun = AppendStr(sAdminFun, asValue)	
		ElseIf (aiOption == oidAutoStoActor)
			sAutoStoActor = asValue
		ElseIf (aiOption == oidActList)
			sActLi = asValue
		ElseIf (aiOption == oidActJson)
			iDDe.sActJson = AppendStr(iDDe.sActJson, asValue)
		ElseIf (aiOption == oidActStr)
			sActStr = AppendStr(sActStr, asValue)
			sActStrGet = iSUmUtil.StrInsertFormStr(sStr = sActStrGet, foForm = None, sIns = sActStr, sAft = "", sLabel = "Name", sOpt = "", idx = 0)
			JsonUtil.StringListSet(iDDe.sActFoJs, sActLi, iActIdx, sActStrGet)
			JsonUtil.Save(iDDe.sActFoJs, False)
		ElseIf (aiOption == oidActInf)
			sActInf = AppendStr(sActInf, asValue)
			sActStrGet = iSUmUtil.StrInsertFormStr(sStr = sActStrGet, foForm = None, sIns = sActInf, sAft = "", sLabel = "Info", sOpt = "", idx = 0)
			JsonUtil.StringListSet(iDDe.sActFoJs, sActLi, iActIdx, sActStrGet)
			JsonUtil.Save(iDDe.sActFoJs, False)
		ElseIf (aiOption == oidAllWornOpt)
			sAllWornOpt = AppendStr(sAllWornOpt, asValue)	
		ElseIf (aiOption == oidOutLocEdit)
			sDDeOutLoc = AppendStr(sDDeOutLoc, asValue)	
		ElseIf (aiOption == oidOutCusEdit)
			sDDeOutCus = AppendStr(sDDeOutCus, asValue)	
		ElseIf (aiOption == oidOutLiJson)
			sOutLiJson = AppendStr(sOutLiJson, asValue)
		ElseIf (aiOption == oidOutLiName)
			sOutLiName = AppendStr(sOutLiName, asValue)
		ElseIf (aiOption == oidOutLiOpt)
			sOutLiOpt = AppendStr(sOutLiOpt, asValue)
		ElseIf (aiOption == oidOutCo)
			sOutCo = GetHex(sHex = asValue, sBad = "ffffff", iLen = 6)
			StorageUtil.SetStringValue(None, "iDDeOutCustomTextColor", sOutCo)
			sRGB = sOutCo
		ElseIf (aiOption == oidOutLoCo)
			sOutLoCo = GetHex(sHex = asValue, sBad = "ffffff", iLen = 6)
			StorageUtil.SetStringValue(None, "iDDeOutLocalTextColor", sOutLoCo)
			sRGB = sOutLoCo
		ElseIf (aiOption == oidOutJsCo)
			sOutJsCo = GetHex(sHex = asValue, sBad = "ffffff", iLen = 6)
			sRGB = sOutJsCo
		ElseIf (aiOption == oidActCo)
			sActCo = GetHex(sHex = asValue, sBad = "ffffff", iLen = 6)
			sRGB = sActCo
		ElseIf (aiOption == oidActLiCo)
			sActLiCo = GetHex(sHex = asValue, sBad = "ffffff", iLen = 6)
			sRGB = sActLiCo
		ElseIf (aiOption == oidActJsCo)
			sActJsCo = GetHex(sHex = asValue, sBad = "ffffff", iLen = 6)
			sRGB = sActJsCo
		ElseIf (aiOption == oidConJsCo)
			sConJsCo = GetHex(sHex = asValue, sBad = "ffffff", iLen = 6)
			sRGB = sConJsCo
		ElseIf (aiOption == oidFacCo)
			sFacCo = GetHex(sHex = asValue, sBad = "ffffff", iLen = 6)
			sRGB = sFacCo
		ElseIf (aiOption == oidGooCo)
			sGooCo = GetHex(sHex = asValue, sBad = "ffffff", iLen = 6)
			sRGB = sGooCo
		ElseIf (aiOption == oidBadCo)
			sBadCo = GetHex(sHex = asValue, sBad = "ffffff", iLen = 6)
			sRGB = sBadCo
		ElseIf (aiOption == oidDisCo)
			StorageUtil.SetStringValue(None, "iDDeLogColor", GetHex(sHex = asValue, sBad = "ffffff", iLen = 6))
			sRGB = StorageUtil.GetStringValue(None, "iDDeLogColor")
		EndIf
		If ((sRGB != asValue) && (asValue != "Random"))
			ShowMessage("[" +asValue+ "] is an invalid RRGGBB(RGB) hex color code.")
		EndIf	
EndFunction
STRING[] Function GetStrings(INT aiOption)
		If (aiOption == oidDDeBlindFold)
			RETURN iDDeLib.sDDeBlindFolds
		ElseIf (aiOption == oidDDxBlindFold)
			RETURN iDDeLib.sDDxBlindFolds
		ElseIf (aiOption == oidDDeGag)
			RETURN iDDeLib.sDDeGags
		ElseIf (aiOption == oidDDxGag)
			RETURN iDDeLib.sDDxGags
		ElseIf (aiOption == oidDDeHood)
			RETURN iDDeLib.sDDeHoods
		ElseIf (aiOption == oidDDxHood)
			RETURN iDDeLib.sDDxHoods
		ElseIf (aiOption == oidDDeCollar)
			RETURN iDDeLib.sDDeCollars
		ElseIf (aiOption == oidDDxCollar)
			RETURN iDDeLib.sDDxCollars
		ElseIf (aiOption == oidCDxCollar)
			RETURN iDDeLib.sCDxCollars
		ElseIf (aiOption == oidDDeBra)
			RETURN iDDeLib.sDDeBras
		ElseIf (aiOption == oidDDxBra)
			RETURN iDDeLib.sDDxBras
		ElseIf (aiOption == oidCDxBra)
			RETURN iDDeLib.sCDxBras
		ElseIf (aiOption == oidDDxPieN)
			RETURN iDDeLib.sDDxPieN
		ElseIf (aiOption == oidDDxPieV)
			RETURN iDDeLib.sDDxPieV
		ElseIf (aiOption == oidDDeCuffsA)
			RETURN iDDeLib.sDDeCuffsA
		ElseIf (aiOption == oidDDxCuffsA)
			RETURN iDDeLib.sDDxCuffsA
		ElseIf (aiOption == oidCDxCuffsA)
			RETURN iDDeLib.sCDxCuffsA
		ElseIf (aiOption == oidDDeCuffsL)
			RETURN iDDeLib.sDDeCuffsL
		ElseIf (aiOption == oidDDxCuffsL)
			RETURN iDDeLib.sDDxCuffsL
		ElseIf (aiOption == oidCDxCuffsL)
			RETURN iDDeLib.sCDxCuffsL	
		ElseIf (aiOption == oidDDeElbowBinder) 
			RETURN iDDeLib.sDDeElbowBinders
		ElseIf (aiOption == oidDDxElbowBinder) 
			RETURN iDDeLib.sDDxElbowBinders
		ElseIf (aiOption == oidDDeArmBinder) 
			RETURN iDDeLib.sDDeArmBinders
		ElseIf (aiOption == oidDDxArmBinder) 
			RETURN iDDeLib.sDDxArmBinders
		ElseIf (aiOption == oidDDeYoke) 
			RETURN iDDeLib.sDDeYokes
		ElseIf (aiOption == oidDDxYoke) 
			RETURN iDDeLib.sDDxYokes
		ElseIf (aiOption == oidDDeShackles) 
			RETURN iDDeLib.sDDeShackles
		ElseIf (aiOption == oidDDxShackles) 
			RETURN iDDeLib.sDDxShackles		
		ElseIf (aiOption == oidDDePetSuit) 
			RETURN iDDeLib.sDDePetSuits
		ElseIf (aiOption == oidDDxPetSuit) 
			RETURN iDDeLib.sDDxPetSuits
		ElseIf (aiOption == oidDDeBoxBinder) 
			RETURN iDDeLib.sDDeBoxBinders
		ElseIf (aiOption == oidDDxBoxBinder) 
			RETURN iDDeLib.sDDxBoxBinders
		ElseIf (aiOption == oidDDeBoxBinderOut) 
			RETURN iDDeLib.sDDeBoxBinderOuts
		ElseIf (aiOption == oidDDxBoxBinderOut) 
			RETURN iDDeLib.sDDxBoxBinderOuts
		ElseIf (aiOption == oidDDeBelt)
			RETURN iDDeLib.sDDeBelts
		ElseIf (aiOption == oidDDxBelt)
			RETURN iDDeLib.sDDxBelts
		ElseIf (aiOption == oidCDxBelt)
			RETURN iDDeLib.sCDxBelts
		ElseIf (aiOption == oidDDeHarness)
			RETURN iDDeLib.sDDeHarness
		ElseIf (aiOption == oidDDxHarness)
			RETURN iDDeLib.sDDxHarness  
		ElseIf (aiOption == oidDDePlugA) 
			RETURN iDDeLib.sDDePlugsA
		ElseIf (aiOption == oidDDxPlugA) 
			RETURN iDDeLib.sDDxPlugsA
		ElseIf (aiOption == oidCDxPlugA) 
			RETURN iDDeLib.sCDxPlugsA
		ElseIf (aiOption == oidDDePlugV)
			RETURN iDDeLib.sDDePlugsV
		ElseIf (aiOption == oidDDxPlugV)
			RETURN iDDeLib.sDDxPlugsV
		ElseIf (aiOption == oidCDxPlugV)
			RETURN iDDeLib.sCDxPlugsV
		ElseIf (aiOption == oidDDxCorset)
			RETURN iDDeLib.sDDxCorsets 
		ElseIf (aiOption == oidDDeGloves)
			RETURN iDDeLib.sDDeGloves
		ElseIf (aiOption == oidDDxGloves)
			RETURN iDDeLib.sDDxGloves
		ElseIf (aiOption == oidDDeBoots)	
			RETURN iDDeLib.sDDeBoots
		ElseIf (aiOption == oidDDxBoots)	
			RETURN iDDeLib.sDDxBoots
		ElseIf (aiOption == oidDDeSuit)
			RETURN iDDeLib.sDDeSuits
		ElseIf (aiOption == oidDDxSuit)
			RETURN iDDeLib.sDDxSuits
		ElseIf (aiOption == oidDDeCatSuit)
			RETURN iDDeLib.sDDeCatSuits
		ElseIf (aiOption == oidDDxCatSuit)
			RETURN iDDeLib.sDDxCatSuits
		ElseIf (aiOption == oidUtilityTask)
			RETURN sUtilityTask
		ElseIf (aiOption == oidDebInfo)
			RETURN sDebInfo
		ElseIf ((aiOption == oidBinderEff) || (aiOption == oidAnklesEff))
			RETURN sBinderEff
		ElseIf (aiOption == oidDDeMech)
			RETURN iDDeLib.sDDeMech
		ElseIf (aiOption == oidPickPlugEff)
			RETURN sPickPlugEff
		ElseIf ((aiOption == oidOutLocAdd) || (aiOption == oidOutCusAdd))
			RETURN sOutSelTos
		ElseIf ((aiOption == oidPlugRibbed) || (aiOption == oidPlugShocker) || (aiOption == oidPlugFusStag) || (aiOption == oidPlugLinked) || (aiOption == oidPlugLively) || \
						(aiOption == oidPlugEleStim) || (aiOption == oidPlugEdgeRand) || (aiOption == oidPlugEdgeOnly) || (aiOption == oidPlugPoss) || (aiOption == oidPlugTrain) || \
						(aiOption == oidPlugDrainH) || (aiOption == oidPlugDrainS) || (aiOption == oidPlugDrainM) || (aiOption == oidPlugVeLively) || (aiOption == oidPlugVibCast) || \ 
						(aiOption == oidPlugVib) || (aiOption == oidPlugVibRand) || (aiOption == oidPlugVibStrg) || (aiOption == oidPlugVibWeak) || \ 
						(aiOption == oidPlugVibVeStrg) || (aiOption == oidPlugVibVeWeak))
			RETURN sPlugEff 
		EndIf
	iDDeUtil.Log("iDDeConfig.GetStrings():-> ", "Unregistered strings requested.", 1)
EndFunction 

Function SaveJsonOutfit(Actor aActor = None, STRING sJfile = "", STRING sList = "", STRING sOutfit = "iDDeOutMCM", STRING sOpt = "6")
	iDDe.iDDeMakeJsonList(aSlave = aActor, sList = sList, sJson = sJfile, sOutfit = sOutfit)
		If (sOpt)
			If (StringUtil.Find(sOpt, "bNew") > -1)
				sOpt = iSUmUtil.StrPluck(sStr = sOpt, sPluck = "bNew", sRepl = "", iMany = -1, idx = 0)
			EndIf
			iDDe.iSUm.SaveWornToJson(aActor = aActor, sJson = sJfile, sList = sList, sOpt = (sOpt+ ",bIsDDeList"))
		EndIf
	JsonUtil.Save(sJfile, False)
EndFunction
STRING Function AddToOutList(STRING sOut = "", STRING sList = "")
	STRING sRet = ""
		If (!sList && sOut)
			sRet = sOut
		ElseIf (sList && (StringUtil.Find(sList, "[", startIndex = 0) == 0) && (StringUtil.Find(sList, "]", startIndex = 0) > 1))
			sList = iSUmUtil.StrSlice(sStr = sList, sSt = "[", sEn = "]")
		EndIf
		If (!sRet && sOut)
			sRet = iSUmUtil.StrAddElement(sStr = sList, sAdd = sOut, sDiv = ",")
		EndIf
		If (sRet && (StringUtil.Find(sRet, ",", 0) > 0))
			sRet = ("[" +sRet+ "]")
		EndIf
	RETURN sRet
EndFunction
INT Function AddStrToJsonList(STRING sStr = "", STRING sJson = "", STRING sList = "", STRING sOpt = "")
	INT i = 0
		If (sJson && sList && sStr)
				If ((StringUtil.GetNthChar(sStr, 0) == "[") && (StringUtil.GetNthChar(sStr, (StringUtil.GetLength(sStr) - 1)) == "]"))
					sStr = iSUmUtil.StrSlice(sStr = sStr, sSt = "[", sEn = "]")
				ElseIf ((StringUtil.GetNthChar(sStr, 0) == "(") && (StringUtil.GetNthChar(sStr, (StringUtil.GetLength(sStr) - 1)) == ")"))
					sStr = iSUmUtil.StrSlice(sStr = sStr, sSt = "(", sEn = ")")
				EndIf
			STRING[] sStrs = PapyrusUtil.StringSplit(sStr, ",")
			INT iMax = sStrs.Length
				If (StringUtil.Find(sOpt, "bAdd", startIndex = 0) > -1)
					While (i < iMax)
						JsonUtil.StringListAdd(sJson, sList, sStrs[i])
						i += 1
					EndWhile
				ElseIf (StringUtil.Find(sOpt, "bRem", startIndex = 0) > -1)
					While (i < iMax)
						JsonUtil.StringListRemove(sJson, sList, sStrs[i])
						i += 1
					EndWhile
				Else
					i = ((JsonUtil.StringListCopy(sJson, sList, sStrs) AS INT) * JsonUtil.StringListCount(sJson, sList))
				EndIf
				If (i)
					JsonUtil.Save(sJson, False)
				EndIf
		EndIf
	RETURN i
EndFunction
INT Function SetUpJsonL1(STRING sJson, STRING sList, STRING sType = "FormList", INT iPerPage = 0, INT idx = -1, INT iMax = 0)
	INT iLen = 0
		If (sType == "IntList")
			iLen = JsonUtil.IntListCount(sJson, sList)
		ElseIf (sType == "FloatList")
			iLen = JsonUtil.FloatListCount(sJson, sList)
		ElseIf (sType == "StringList")
			iLen = JsonUtil.StringListCount(sJson, sList)
		ElseIf (sType == "FormList")
			iLen = JsonUtil.FormListCount(sJson, sList)
		EndIf	
	INT[] iAs = SetUpAP(iLen = iLen, iPage = _iL1P, iPerPage = iPerPage, idx = idx, iMax = iMax)
		_iL1L 	= iAs[1]
		_iL1L2	= iAs[2] 
		_iL1i 	= iAs[3] ; idx
		_iL1P 	= iAs[4]
		_iL1Ps	= iAs[5]
		_iL1E		= iAs[6]
	RETURN iAs[0]
EndFunction
INT Function SetUpStrA1(STRING[] sArray, INT iPerPage = 0, INT idx = -1, INT iMax = 0)
	INT[] iAs = SetUpAP(iLen = sArray.Length, iPage = _iA1P, iPerPage = iPerPage, idx = idx, iMax = iMax)
		_iA1L 	= iAs[1]
		_iA1L2	= iAs[2] 
		_iA1i 	= iAs[3] ; idx
		_iA1P 	= iAs[4]
		_iA1Ps	= iAs[5]
		_iA1E		= iAs[6]
	RETURN iAs[0]
EndFunction
INT Function SetUpStrA2(STRING[] sArray, INT iPerPage = 0, INT idx = -1, INT iMax = 0)
	INT[] iAs = SetUpAP(iLen = sArray.Length, iPage = _iA2P, iPerPage = iPerPage, idx = idx, iMax = iMax)
		_iA2L 	= iAs[1]
		_iA2L2	= iAs[2] 
		_iA2i 	= iAs[3] ; idx
		_iA2P 	= iAs[4]
		_iA2Ps	= iAs[5]
		_iA2E		= iAs[6]
	RETURN iAs[0]
EndFunction
INT Function SetUpStorStrL1(Form akForm = None, STRING sList, INT iPerPage = 0, INT idx = -1, INT iMax = 0)
	INT[] iAs = SetUpAP(iLen = StorageUtil.StringListCount(akForm, sList), iPage = _iL1P, iPerPage = iPerPage, idx = idx, iMax = iMax)
		_iL1L 	= iAs[1]
		_iL1L2	= iAs[2] 
		_iL1i 	= iAs[3] ; idx
		_iL1P 	= iAs[4]
		_iL1Ps	= iAs[5]
		_iL1E		= iAs[6]
	RETURN iAs[0]
EndFunction	
INT Function SetUpStorStrL2(Form akForm = None, STRING sList, INT iPerPage = 0, INT idx = -1, INT iMax = 0)
	INT[] iAs = SetUpAP(iLen = StorageUtil.StringListCount(akForm, sList), iPage = _iL2P, iPerPage = iPerPage, idx = idx, iMax = iMax)
		_iL2L 	= iAs[1]
		_iL2L2	= iAs[2] 
		_iL2i 	= iAs[3] ; idx
		_iL2P 	= iAs[4]
		_iL2Ps	= iAs[5]
		_iL2E		= iAs[6]
	RETURN iAs[0]
EndFunction	
STRING Function DisplayOutArray(STRING sPre = "", STRING sStr = "", STRING sCo = "ffffff", STRING sOut = "Outfit", INT iChaMax = 0, STRING sSub = "")
	STRING sDes = ("Loaded " +sOut+ " for manipulation.\nThe line length for this string can be adjusted in the 'Setup' page.")
	RETURN DisplayStr(sPre = sPre, sStr = sStr, sVal = "", sDes = sDes, iLinChaMax = iChaMax, sCol = sCo, sSub = sSub)
EndFunction
INT Function GetSelActor()
	Actor aActor = None
		If (!_iSelActPl && iActLoadOpt)
			INT iAct = iActLoadOpt
			ObjectReference orCro = Game.GetCurrentCrosshairRef()	
			ObjectReference orCon = None
			Actor aCro = None
			Actor aCon = None
				If (orCro)
					aCro = (orCro AS Actor)
				EndIf
				If (iAct > 1)
					orCon = Game.GetCurrentConsoleRef()
						If (orCon)
							aCon = (orCon AS Actor)
						EndIf
				EndIf
				While (!aActor && (iAct > 0))
					If (!aActor && ((iAct == 1) || (iAct == 3)))
						If (aCro)
							aActor = aCro	
						EndIf
						iAct -= 1
					EndIf
					If (!aActor && ((iAct == 2) || (iAct == 4)))
						If (aCon)
							aActor = aCon	
						EndIf
						iAct -= 2
					EndIf	
					If (aActor && (aActor != aSelActor))
						aSelActor = aActor
					EndIf
					iAct -= 1
				EndWhile
		EndIf
		If (_iSelActPl)
			_iSelActPl = 0
		ElseIf (aLiActor && !aActor)
			aSelActor = aLiActor
		EndIf
	RETURN 1
EndFunction
Function SetoidBelt(INT iOID = 0, INT iSetOID = 0)
	If (iOID != 0)
		iDDe.iDDeBelt *= ((oidDDeBelt == iSetOID) AS INT)
		iDDe.iDDxBelt *= ((oidDDxBelt == iSetOID) AS INT)
		iDDe.iCDxBelt *= ((oidCDxBelt == iSetOID) AS INT)
	EndIf
EndFunction
Function SetoidBoots(INT iOID = 0, INT iSetOID = 0)
	If (iOID != 0)
		iDDe.iDDeBoots *= ((oidDDeBoots == iSetOID) AS INT)
		iDDe.iDDxBoots *= ((oidDDxBoots == iSetOID) AS INT)
	EndIf
EndFunction
Function SetoidBlindFold(INT iOID = 0, INT iSetOID = 0)
	If (iOID != 0)
		iDDe.iDDeBlind *= ((oidDDeBlindFold == iSetOID) AS INT)
		iDDe.iDDxBlind *= ((oidDDxBlindFold == iSetOID) AS INT)
	EndIf
EndFunction
Function SetoidBra(INT iOID = 0, INT iSetOID = 0)
	If (iOID != 0)
		iDDe.iDDeBra *= ((oidDDeBra == iSetOID) AS INT)
		iDDe.iDDxBra *= ((oidDDxBra == iSetOID) AS INT)
		iDDe.iCDxBra *= ((oidCDxBra == iSetOID) AS INT)
	EndIf
EndFunction
Function SetoidCuffsA(INT iOID = 0, INT iSetOID = 0)
	If (iOID != 0)
		iDDe.iDDeCuffsA *= ((oidDDeCuffsA == iSetOID) AS INT)
		iDDe.iDDxCuffsA *= ((oidDDxCuffsA == iSetOID) AS INT)
		iDDe.iCDxCuffsA *= ((oidCDxCuffsA == iSetOID) AS INT)
	EndIf
EndFunction
Function SetoidCuffsL(INT iOID = 0, INT iSetOID = 0)
	If (iOID != 0)
		iDDe.iDDeCuffsL *= ((oidDDeCuffsL == iSetOID) AS INT)
		iDDe.iDDxCuffsL *= ((oidDDxCuffsL == iSetOID) AS INT)
		iDDe.iCDxCuffsL *= ((oidCDxCuffsL == iSetOID) AS INT)
	EndIf
EndFunction
Function SetoidGloves(INT iOID = 0, INT iSetOID = 0)
	If (iOID != 0)
		iDDe.iDDeGloves *= ((oidDDeGloves == iSetOID) AS INT)
		iDDe.iDDxGloves *= ((oidDDxGloves == iSetOID) AS INT)
	EndIf
EndFunction
Function SetoidHarness(INT iOID = 0, INT iSetOID = 0)
	If (iOID != 0)
		iDDe.iDDeHarness *= ((oidDDeHarness == iSetOID) AS INT)
		iDDe.iDDxHarness *= ((oidDDxHarness == iSetOID) AS INT)
		iDDe.iDDxCorset *= ((oidDDxCorset == iSetOID) AS INT)
	EndIf
EndFunction
Function SetoidPlugA(INT iOID = 0, INT iSetOID = 0)
	If (iOID != 0)
		iDDe.iDDePlugA *= ((oidDDePlugA == iSetOID) AS INT)
		iDDe.iDDxPlugA *= ((oidDDxPlugA == iSetOID) AS INT)
		iDDe.iCDxPlugA *= ((oidCDxPlugA == iSetOID) AS INT)
	EndIf
EndFunction
Function SetoidPlugV(INT iOID = 0, INT iSetOID = 0)
	If (iOID != 0)
		iDDe.iDDePlugV *= ((oidDDePlugV == iSetOID) AS INT)
		iDDe.iDDxPlugV *= ((oidDDxPlugV == iSetOID) AS INT)
		iDDe.iCDxPlugV *= ((oidCDxPlugV == iSetOID) AS INT)
	EndIf
EndFunction
Function SetoidCollar(INT iOID = 0, INT iSetOID = 0)
	If (iOID != 0)
		iDDe.iDDeCollar *= ((oidDDeCollar == iSetOID) AS INT)
		iDDe.iDDxCollar *= ((oidDDxCollar == iSetOID) AS INT)
		iDDe.iCDxCollar *= ((oidCDxCollar == iSetOID) AS INT)
	EndIf
EndFunction
Function SetoidGag(INT iOID = 0, INT iSetOID = 0)
	If (iOID != 0)
		iDDe.iDDeGag *= ((oidDDeGag == iSetOID) AS INT)
		iDDe.iDDxGag *= ((oidDDxGag == iSetOID) AS INT)
		iDDe.iDDeHood *= ((oidDDeHood == iSetOID) AS INT)
	EndIf
EndFunction
Function SetoidBinder(INT iOID = 0, INT iSetOID = 0)
	If (iOID != 0)
		iDDe.iDDeElbowBinder *= ((oidDDeElbowBinder == iSetOID) AS INT)
		iDDe.iDDxElbowBinder *= ((oidDDxElbowBinder == iSetOID) AS INT)
		iDDe.iDDeArmBinder *= ((oidDDeArmBinder == iSetOID) AS INT)
		iDDe.iDDxArmBinder *= ((oidDDxArmBinder == iSetOID) AS INT)
		iDDe.iDDeYoke *= ((oidDDeYoke == iSetOID) AS INT)
		iDDe.iDDxYoke *= ((oidDDxYoke == iSetOID) AS INT)
		iDDe.iDDeShackles *= ((oidDDeShackles == iSetOID) AS INT)
		iDDe.iDDxShackles *= ((oidDDxShackles == iSetOID) AS INT)
		iDDe.iDDePetSuit *= ((oidDDePetSuit == iSetOID) AS INT)
		iDDe.iDDxPetSuit *= ((oidDDxPetSuit == iSetOID) AS INT)
		iDDe.iDDeBoxBinder *= ((oidDDeBoxBinder == iSetOID) AS INT)
		iDDe.iDDxBoxBinder *= ((oidDDxBoxBinder == iSetOID) AS INT)
		iDDe.iDDeBoxBinderOut *= ((oidDDeBoxBinderOut == iSetOID) AS INT)
		iDDe.iDDxBoxBinderOut *= ((oidDDxBoxBinderOut == iSetOID) AS INT)
	EndIf
EndFunction
Function SetoidSuit(INT iOID = 0, INT iSetOID = 0)
	If (iOID != 0)
		iDDe.iDDeSuit *= ((oidDDeSuit == iSetOID) AS INT)
		iDDe.iDDxSuit *= ((oidDDxSuit == iSetOID) AS INT)
		iDDe.iDDeCatSuit *= ((oidDDeCatSuit == iSetOID) AS INT)
		iDDe.iDDxCatSuit *= ((oidDDxCatSuit == iSetOID) AS INT)
		iDDe.iDDeMech *= ((oidDDeMech == iSetOID) AS INT)
	EndIf
EndFunction
STRING[] Function GetTypesInJson(STRING sJson = "", STRING sType = ".stringList")
	RETURN JsonUtil.PathMembers(sJson, sType)
EndFunction
STRING Function GetColor(STRING sCol = "", STRING sStr = "")
	STRING sRet = sStr
		If (sCol == "Act")
			sRet = SetColor(sActCo, sStr)
		ElseIf(sCol == "Out")
			sRet = SetColor(sOutCo, sStr) 
		ElseIf(sCol == "ActLi")
			sRet = SetColor(sActLiCo, sStr) 
		ElseIf(sCol == "Good")
			sRet = SetColor(sGooCo, sStr) 
		ElseIf(sCol == "Bad")
			sRet = SetColor(sBadCo, sStr) 
		EndIf
	RETURN sRet
EndFunction

STRING Function SetFolder(STRING sFolder = "Global")
	If (sFolder && (StringUtil.Find(sFolder, "/", (StringUtil.GetLength(sFolder) - 1)) < 0))
		sFolder += "/"
	EndIf
	RETURN sFolder 
EndFunction 
STRING Function SetJson(STRING sJson = "System")
	If (sJson && (StringUtil.Find(sJson, ".json", (StringUtil.GetLength(sJson) - 5)) < 0))
		sJson += ".json"
	EndIf
	RETURN sJson 
EndFunction 
STRING Function GetPathDDe(STRING sPath = "Global")
	RETURN ("../Devious Devices - Equip/" +sPath) 
EndFunction
STRING Function GetJsonPath(STRING sPath = "System")
	RETURN GetPathDDe(sPath = SetJson(sJson = sPath)) 
EndFunction
STRING Function GetFolderPath(STRING sPath = "Global")
	RETURN GetPathDDe(sPath = SetFolder(sFolder = sPath)) 
EndFunction 
STRING Function GetPathFolder(STRING sPath = "", STRING sFolder = "")
	;Something
		If (sPath == "Pla") ;
			sPath = "Player/"
				If (!sFolder)
					sFolder = "MCM"
				EndIf
		ElseIf (sPath == "Glo") ;
			sPath = "Global/"
				If (!sFolder)
					sFolder = "Outfits"
				EndIf
		ElseIf (sPath == "DDe") ;
			sPath = "DDe/"
				If (!sFolder)
					sFolder = "System"
				EndIf
		EndIf
		If (sFolder == "Null")
			sFolder = ""
		EndIf
	RETURN GetFolderPath(sPath = (sPath + sFolder)) 
EndFunction
STRING Function GetPathJson(STRING sPath = "", STRING sJson = "")
	;Something
		If (sPath == "Glo") 
			sPath = "Global/"
				If (!sJson)
					sJson = "System.json"
				EndIf
		ElseIf (sPath == "GloAct") 
			sPath = "Global/Actors/"
				If (!sJson)
					sJson = "iDDeActors.json"
				EndIf
		ElseIf (sPath == "GloFor") 
			sPath = "Global/Forms/"
				If (!sJson)
					sJson = "iDDeForms.json"
				EndIf
		ElseIf (sPath == "GloOut") 
			sPath = "Global/Outfits/"
				If (!sJson)
					sJson = "iDDeOutfits.json"
				EndIf
		ElseIf (sPath == "GloSys") 
			sPath = "Global/System/"
				If (!sJson)
					sJson = "iDDeSystem.json"
				EndIf
		ElseIf (sPath == "PlaMCM") 
			sPath = "Player/MCM/"
				If (!sJson)
					sJson = "Default.json"
				EndIf
		ElseIf (sPath == "PlaSys") ;User, not shipped.
			sPath = "Player/System/"
				If (!sJson)
					sJson = "System.json"
				EndIf
		ElseIf (sPath == "DDeMCM") 
			sPath = "DDe/MCM/"
				If (!sJson)
					sJson = "MCM.json"
				EndIf
		ElseIf (sPath == "DDeSys") ;DDe System stuff
			sPath = "DDe/System/"
				If (!sJson)
					sJson = "System.json"
				EndIf
		EndIf
		If (sJson == "Null")
			sJson = ""
		EndIf
	RETURN GetJsonPath(sPath = (sPath + sJson))
EndFunction
STRING Function GetFolder(STRING sFolder = "", STRING sType = "")
	STRING sFol = ""
		If (sFolder)
			If (StringUtil.Find(sFolder, "iSUm", 0) == 0) ;iSUm folder
				sFol = JsonUtil.GetStringValue(iSUmUtil.GetPath(sPath = "Null", sJson = "iSUmGloSystem"), sFolder, sFolder) ;SUM
				sFolder = JsonUtil.GetStringValue(iSUmUtil.GetPath(sPath = "Null", sJson = "iSUmPlaSystem"), sFolder, sFol) ;User
					If (StringUtil.Find(sFolder, "/", 0) < 0)	
						sFol = iSUmUtil.StrPluck(sStr = sFolder, sPluck = "iSUm", sRepl = "", iMany = 1, idx = 0)
						sFolder = iSUmUtil.GetPath(sPath = sFol, sJson = "Null")
					EndIf
			Else ;DDe folder
				If (StringUtil.Find(sFolder, "iDDe", 0) == 0)
					sFolder = iSUmUtil.StrPluck(sStr = sFolder, sPluck = "iDDe", sRepl = "", iMany = 1, idx = 0)
					sFolder = GetPathFolder(sPath = "Glo", sFolder = sFolder)
				Else	
					sFol = JsonUtil.GetStringValue(GetPathJson(sPath = "DDeSys"), sFolder, sFolder) ;DDe
					sFolder = JsonUtil.GetStringValue(GetPathJson(sPath = "PlaSys"), sFolder, sFol) ;User
				EndIf
			EndIf
		EndIf
		If (!sFolder || sFolder == "DDE")
			sFolder = GetPathFolder(sPath = "Glo", sFolder = sType)
		ElseIf (sFolder == "SUM")
			sFolder = iSUmUtil.GetPath(sPath = "", sJson = "", sType = sType)
		EndIf
	RETURN SetFolder(sFolder = sFolder)
EndFunction

Function ClearOutfitMCM()
	iDDe.iDDeBlind = 0
	iDDe.iDDxBlind = 0
	iDDe.iDDeGag = 0
	iDDe.iDDxGag = 0
	iDDe.iDDeCollar = 0
	iDDe.iDDxCollar = 0
	iDDe.iCDxCollar = 0
	iDDe.iDDeBra = 0
	iDDe.iDDxBra = 0
	iDDe.iCDxBra = 0
	iDDe.iDDxPieN = 0
	iDDe.iDDxPieV = 0
	iDDe.iDDeCuffsA = 0
	iDDe.iDDxCuffsA = 0
	iDDe.iCDxCuffsA = 0
	iDDe.iDDeCuffsL = 0
	iDDe.iDDxCuffsL = 0
	iDDe.iCDxCuffsL = 0 
	iDDe.iDDeElbowBinder = 0
	iDDe.iDDxElbowBinder = 0
	iDDe.iDDeArmBinder = 0
	iDDe.iDDxArmBinder = 0
	iDDe.iDDeYoke = 0
	iDDe.iDDxYoke = 0
	iDDe.iDDeShackles = 0
	iDDe.iDDxShackles = 0
	iDDe.iDDePetSuit = 0
	iDDe.iDDxPetSuit = 0
	iDDe.iDDeBoxBinder = 0
	iDDe.iDDxBoxBinder = 0
	iDDe.iDDeBoxBinderOut = 0
	iDDe.iDDxBoxBinderOut = 0
	iDDe.iDDeBelt = 0
	iDDe.iDDxBelt = 0
	iDDe.iCDxBelt = 0
	iDDe.iDDeHarness = 0
	iDDe.iDDxHarness = 0
	iDDe.iDDePlugA = 0
	iDDe.iDDxPlugA = 0
	iDDe.iCDxPlugA = 0
	iDDe.iDDePlugV = 0
	iDDe.iDDxPlugV = 0
	iDDe.iCDxPlugV = 0
	iDDe.iDDxCorset = 0
	iDDe.iDDeGloves = 0
	iDDe.iDDxGloves = 0
	iDDe.iDDeBoots = 0
	iDDe.iDDxBoots = 0
	iDDe.iDDeSuit = 0
	iDDe.iDDxSuit = 0
	iDDe.iDDeCatSuit = 0
	iDDe.iDDxCatSuit = 0
	iDDe.iDDeHood = 0
	iDDe.iDDxHood = 0
	iDDe.iDDeMech = 0
	iOutLocAdd = 0
	iOutCusAdd = 0
EndFunction

Function RemoveKeys(Actor akSlave)
	iDDe.iDDeRemoveKeys(iDDe.PlayerRef, False, None)
		If (akSlave != iDDe.PlayerRef)
			iDDe.iDDeRemoveKeys(akSlave, False, None) 
		EndIf
EndFunction
INT Function RegisterHotKeys(STRING sOpt = "Register")
	iKeyActSel = RegisterHotKey(iKey = iKeyActSel, sOpt = sOpt)
	iKeySelfBond = RegisterHotKey(iKey = iKeySelfBond, sOpt = sOpt)
	RETURN 1
EndFunction	
Function StartSelfBondage(Actor aActor = None) 
	If (aActor)
		iDDe.Strip(aActor, sList = "iDDeStripByMCM", iDDs = 1)
		StorageUtil.SetFloatValue(aActor, "iDDefSelfBondEnd", (Game.GetRealHoursPassed() + (StorageUtil.GetFloatValue(aActor, "iDDefSelfTimer", 0) / 60)))
		iDDe.EquipOutfit(aActor, sList = sDDeOutLoc, iDDs = 76, sOpt = "bNew")
		aActor.SendModEvent("iDDeLock", "DDe Self Bondage Session", 1)
		RemoveKeys(aActor)
			If (aActor == iDDe.PlayerRef)
				iDDe.iDDeEqpMagicalArmbinder(aSlave = aActor, iEqp = 1, iDelay = 7)	
			EndIf	
	EndIf
EndFunction

INT Function AddActorToList(Actor aActor = None, INT iNo = 0, INT iDis = 1) 
	STRING sActor = iSUmUtil.GetActorName(aActor, "No Actor")
	INT iSto = AddFormToJsonList(sJson = iDDe.sActFoJs, sList = sActLi, sStr = sActStrGet, akForm = aActor, iForm = iNo, sForm = sActor, sSto = (sAutoStoActor+ ",bNoInt"))
		If (iSto > -1)
			iDDeUtil.Log("iDDeConfig.AddActorToList():-> [" +sActor+ "] saved to slot No. " +(iSto + 1)+ ", in [" +sActLi+ "] list!")
			iDDeUtil.Log("", "[" +SetColor(sActCo, sActor)+ "] saved to slot No. " +(iSto + 1)+ ", in [" +SetColor(sActLiCo, sActLi)+ "] list!", 0, iDis)
		Else
			iDDeUtil.Log("iDDeConfig.AddActorToList():-> [" +sActor+ "] already in [" +sActLi+ "] list!")
			iDDeUtil.Log("", "[" +SetColor(sActCo, sActor)+ "] already in [" +SetColor(sActLiCo, sActLi)+ "] list!", 0, iDis)
		EndIf
	RETURN iSto
EndFunction
INT Function AddFormToJsonList(STRING sJson = "", STRING sList = "", STRING sStr = "", Form akForm = None, INT iForm = 0, STRING sForm = "", STRING sSto = "", STRING sLabel = "Form") 
	STRING[] sStos = PapyrusUtil.StringSplit(sSto, ",")	
	INT iSto = ((sStos[0] AS INT) - 1)
		iSto = iSUmUtil.JsStrListAddFormEx(sJson = sJson, sList = sList, sStr = sStr, akForm = akForm, sForm = sForm, sNum = iForm, idx = iSto, sOpt = sSto, sLabel = sLabel) 
			If (iSto > -1)
				JsonUtil.Save(sJson, False)
			EndIf
	RETURN iSto
EndFunction

Event OnConfigClose()
	If ((iDDe.iDDeBinderEff == 2) && (aSelActor == iDDe.PlayerRef))
		iDDe.iDDeEqpMagicalArmbinder(aSlave = aSelActor, iEqp = 1, iDelay = 1)
	EndIf
	If (StorageUtil.GetIntValue(aSelActor, "iDDeAnklesEff", 0) == 2)
		iDDe.iDDeEqpMagicalAnkles(aSlave = aSelActor, iEqp = 1, iDelay = 1)
	EndIf
	StorageUtil.SetIntValue(None, "iDDeRemQuest", iDDe.iDDeRemQuest)	 
EndEvent 

;MCM Save
;mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
INT Function iDDeExportSettings(STRING sFile = "")
	iDDeUtil.Log("iDDeConfig.iDDeExportSettings():-> ", "Saving MCM... Please stand by!", 3, 1)
	INT i = 0
	INT iMax = 0
		If (sFile == "")
			sFile = GetPathJson(sPath = "PlaMCM", sJson = iDDe.PlayerRef.GetDisplayName())
		EndIf
		
	JsonUtil.ClearAll(sFile)
	
	;FLOAT
	JsonUtil.SetFloatValue(sFile, "fVersion", (iSUmUtil.StrInsert(sStr = iDDeUtil.GetVersion()) AS FLOAT))
	
	;STRING
	JsonUtil.SetStringValue(sFile, "sVersion", iDDeUtil.GetSemVerStr())
	JsonUtil.SetStringValue(sFile, "sSemanticVer", iDDeUtil.GetSemVerStr())
	JsonUtil.SetStringValue(GetPathJson(sPath = "PlaSys"), "sConFile", sConFile)
	JsonUtil.SetStringValue(GetPathJson(sPath = "PlaSys"), "sExistPass", sExistPass)
	JsonUtil.SetStringValue(sFile, "sInputPass", sInputPass)
	JsonUtil.SetStringValue(sFile, "sActLi", sActLi)
	JsonUtil.SetStringValue(sFile, "sAdminOpt", sAdminOpt)
	JsonUtil.SetStringValue(sFile, "sAutoStoActor", sAutoStoActor)
	JsonUtil.SetStringValue(sFile, "sActLi", sActLi)
	JsonUtil.SetStringValue(sFile, "sOutCo", sOutCo)
	JsonUtil.SetStringValue(sFile, "sOutJsCo", sOutJsCo)
	JsonUtil.SetStringValue(sFile, "sActCo", sActCo)
	JsonUtil.SetStringValue(sFile, "sActLiCo", sActLiCo)
	JsonUtil.SetStringValue(sFile, "sActJsCo", sActJsCo)
	JsonUtil.SetStringValue(sFile, "sConJsCo", sConJsCo)
	JsonUtil.SetStringValue(sFile, "sOutLoCo", sOutLoCo)
	JsonUtil.SetStringValue(sFile, "sFacCo", sFacCo)
	JsonUtil.SetStringValue(sFile, "sGooCo", sGooCo)
	JsonUtil.SetStringValue(sFile, "sBadCo", sBadCo)
	JsonUtil.SetStringValue(sFile, "sLogColor", StorageUtil.GetStringValue(None, "iDDeLogColor", "ffffff"))
	JsonUtil.SetStringValue(sFile, "sAllWornOpt", sAllWornOpt)
	JsonUtil.SetStringValue(sFile, "sDDeOutLoc", sDDeOutLoc)
	JsonUtil.SetStringValue(sFile, "sDDeOutLocSel", sDDeOutLocSel)
	JsonUtil.SetStringValue(sFile, "sDDeOutCus", sDDeOutCus)
	JsonUtil.SetStringValue(sFile, "sDDeOutCusSel", sDDeOutCusSel)
	JsonUtil.SetStringValue(sFile, "sOutLiJson", sOutLiJson)
	JsonUtil.SetStringValue(sFile, "sOutLiName", sOutLiName)
	JsonUtil.SetStringValue(sFile, "sOutLiOpt", sOutLiOpt)
	
	;INT
	JsonUtil.SetIntValue(sFile, "iVersion", iDDeUtil.GetVersion())
	JsonUtil.SetIntValue(sFile, "iKeyActSel", iKeyActSel)
	JsonUtil.SetIntValue(sFile, "iKeySelfBond", iKeySelfBond)
	JsonUtil.SetIntValue(sFile, "iActPerPg", iActPerPg)
	JsonUtil.SetIntValue(sFile, "iOutPerPg", iOutPerPg)
	JsonUtil.SetIntValue(sFile, "iOutJsPerPg", iOutJsPerPg)
	JsonUtil.SetIntValue(sFile, "iOutRegPerPg", iOutRegPerPg)
	JsonUtil.SetIntValue(sFile, "iOutDrePerPg", iOutDrePerPg)
	JsonUtil.SetIntValue(sFile, "iOutLocAdd", iOutLocAdd)
	JsonUtil.SetIntValue(sFile, "iOutCusAdd", iOutCusAdd)
	JsonUtil.SetIntValue(sFile, "iActLoadOpt", iActLoadOpt)
	JsonUtil.SetIntValue(sFile, "iDevOptsPg", iDevOptsPg)
	JsonUtil.SetIntValue(sFile, "iActJsPerPg", iActJsPerPg)
	JsonUtil.SetIntValue(sFile, "iActLiPerPg", iActLiPerPg)
	JsonUtil.SetIntValue(sFile, "iConFiPerPg", iConFiPerPg)
	
	;Form
	iSUmUtil.SetFormToJsStr(foForm = aSelActor, sForm = sSelActor, sJson = sFile, sKey = "aSelActor", iSet = 1, sLabel = "Form", sOpt = "")
	iSUmUtil.SetFormToJsStr(foForm = aLiActor, sForm = "", sJson = sFile, sKey = "aLiActor", iSet = 1, sLabel = "Form", sOpt = "")
	
	;INT List
	
	;STRING List
			
	;Form List
	;iSUmUtil.StoreActorsToJson(akSavedActors, "akSavedActors", sFile, True)
	
	;StorageUtil FLOAT
	JsonUtil.SetFloatValue(sFile, "iDDefSelfTimer", StorageUtil.GetFloatValue(aSelActor, "iDDefSelfTimer", 0))
	
	;StorageUtil String
	;JsonUtil.SetStringValue(sFile, "iDDeOutEqpPre", StorageUtil.GetStringValue(aSelActor, "iDDeOutEqpPre", ""))
	
	;StorageUtil INT
	
	;INT Array
	JsonUtil.IntListCopy(sFile, "iPickSuit", iPickSuit)	
	JsonUtil.IntListCopy(sFile, "iPickGag", iPickGag)
	JsonUtil.IntListCopy(sFile, "iPickHood", iPickHood)
	JsonUtil.IntListCopy(sFile, "iPickBinder", iPickBinder)
	JsonUtil.IntListCopy(sFile, "iPickBlinder", iPickBlinder)
	JsonUtil.IntListCopy(sFile, "iPickCollar", iPickCollar)
	JsonUtil.IntListCopy(sFile, "iPickGloves", iPickGloves)
	JsonUtil.IntListCopy(sFile, "iPickBoots", iPickBoots)
	JsonUtil.IntListCopy(sFile, "iPickBelt", iPickBelt)
	JsonUtil.IntListCopy(sFile, "iPickHarn", iPickHarn)
	JsonUtil.IntListCopy(sFile, "iPickPlugA", iPickPlugA)
	JsonUtil.IntListCopy(sFile, "iPickPlugV", iPickPlugV)
	JsonUtil.IntListCopy(sFile, "iPickPieV", iPickPieV)
	JsonUtil.IntListCopy(sFile, "iPickPieN", iPickPieN)
	JsonUtil.IntListCopy(sFile, "iPickCuffsA", iPickCuffsA)
	JsonUtil.IntListCopy(sFile, "iPickCuffsL", iPickCuffsL)
	JsonUtil.IntListCopy(sFile, "iPickBra", iPickBra)
	
	;iDDeUti values
	iDDe.iDDeExportSettings(sFile)
	;iDDeFunc Values
	iDDeFunc.iDDeExportSettings(sFile)
	
	Wait(1.1)
	JsonUtil.Save(sFile, False)
	JsonUtil.Save(GetPathJson(sPath = "PlaSys"), False)
	iDDeUtil.Log("iDDeConfig.iDDeExportSettings():-> ", "Saving MCM... Done!", 3, 1)
	RETURN 1
EndFunction
INT Function iDDeImportSettings(STRING sFile = "")
	iDDeUtil.Log("iDDeConfig.iDDeImportSettings():-> ", "Loading MCM... Please stand by!", 3, 1)
	INT i = 0
	INT iMax = 0
		If (sFile == "")
			sFile = GetPathJson(sPath = "PlaMCM", sJson = iDDe.PlayerRef.GetDisplayName())
		EndIf
	;Unegister old keys 
	RegisterHotKeys(sOpt = "UnMap")
	
	;STRING
	sConFile						= JsonUtil.GetStringValue(GetPathJson(sPath = "PlaSys"), "sConFile", sConFile)
	sExistPass					= JsonUtil.GetStringValue(GetPathJson(sPath = "PlaSys"), "sExistPass", sExistPass)
	sInputPass					= JsonUtil.GetStringValue(sFile, "sInputPass", sInputPass)
	sActLi							= JsonUtil.GetStringValue(sFile, "sActLi", sActLi)
	sAdminOpt						= JsonUtil.GetStringValue(sFile, "sAdminOpt", sAdminOpt)
	sAutoStoActor				= JsonUtil.GetStringValue(sFile, "sAutoStoActor", sAutoStoActor)
	sActLi							= JsonUtil.GetStringValue(sFile, "sActLi", sActLi)
	sOutCo							= JsonUtil.GetStringValue(sFile, "sOutCo", sOutCo)
	sOutJsCo						= JsonUtil.GetStringValue(sFile, "sOutJsCo", sOutJsCo)
	sActCo							= JsonUtil.GetStringValue(sFile, "sActCo", sActCo)
	sActLiCo						= JsonUtil.GetStringValue(sFile, "sActLiCo", sActLiCo)
	sActJsCo						= JsonUtil.GetStringValue(sFile, "sActJsCo", sActJsCo)
	sConJsCo						= JsonUtil.GetStringValue(sFile, "sConJsCo", sConJsCo)
	sOutLoCo						= JsonUtil.GetStringValue(sFile, "sOutLoCo", sOutLoCo)
	sFacCo							= JsonUtil.GetStringValue(sFile, "sFacCo", sFacCo)
	sGooCo							= JsonUtil.GetStringValue(sFile, "sGooCo", sGooCo)
	sBadCo							= JsonUtil.GetStringValue(sFile, "sBadCo", sBadCo)
	sAllWornOpt					= JsonUtil.GetStringValue(sFile, "sAllWornOpt", sAllWornOpt)
	sDDeOutLoc					= JsonUtil.GetStringValue(sFile, "sDDeOutLoc", sDDeOutLoc)
	sDDeOutLocSel				= JsonUtil.GetStringValue(sFile, "sDDeOutLocSel", sDDeOutLocSel)
	sDDeOutCus					= JsonUtil.GetStringValue(sFile, "sDDeOutCus", sDDeOutCus)
	sDDeOutCusSel				= JsonUtil.GetStringValue(sFile, "sDDeOutCusSel", sDDeOutCusSel)
	sOutLiJson					= JsonUtil.GetStringValue(sFile, "sOutLiJson", sOutLiJson)
	sOutLiName					= JsonUtil.GetStringValue(sFile, "sOutLiName", sOutLiName)
	sOutLiOpt						= JsonUtil.GetStringValue(sFile, "sOutLiOpt", sOutLiOpt)
	
	StorageUtil.SetStringValue(None, "iDDeLogColor", \
	JsonUtil.GetStringValue(sFile, "sLogColor", StorageUtil.GetStringValue(None, "iDDeLogColor", "ffffff")))
	
	;INT
	iKeyActSel				= JsonUtil.GetIntValue(sFile, "iKeyActSel", iKeyActSel)
	iKeySelfBond			= JsonUtil.GetIntValue(sFile, "iKeySelfBond", iKeySelfBond)
	iActPerPg					= JsonUtil.GetIntValue(sFile, "iActPerPg", iActPerPg)
	iOutPerPg					= JsonUtil.GetIntValue(sFile, "iOutPerPg", iOutPerPg)
	iOutJsPerPg				= JsonUtil.GetIntValue(sFile, "iOutJsPerPg", iOutJsPerPg)
	iOutRegPerPg			= JsonUtil.GetIntValue(sFile, "iOutRegPerPg", iOutRegPerPg)
	iOutDrePerPg			= JsonUtil.GetIntValue(sFile, "iOutDrePerPg", iOutDrePerPg)
	iOutLocAdd				= JsonUtil.GetIntValue(sFile, "iOutLocAdd", iOutLocAdd)
	iOutCusAdd				= JsonUtil.GetIntValue(sFile, "iOutCusAdd", iOutCusAdd)
	iActLoadOpt				= JsonUtil.GetIntValue(sFile, "iActLoadOpt", iActLoadOpt)
	iDevOptsPg				= JsonUtil.GetIntValue(sFile, "iDevOptsPg", iDevOptsPg)
	iActJsPerPg				= JsonUtil.GetIntValue(sFile, "iActJsPerPg", iActJsPerPg)
	iActLiPerPg				= JsonUtil.GetIntValue(sFile, "iActLiPerPg", iActLiPerPg)
	iConFiPerPg				= JsonUtil.GetIntValue(sFile, "iConFiPerPg", iConFiPerPg)
	
	;Form
	aSelActor					= (iSUmUtil.SetFormToJsStr(foForm = aSelActor, sForm = sSelActor, sJson = sFile, sKey = "aSelActor", iSet = 0, sLabel = "Form", sOpt = "") AS Actor)
	aLiActor					= (iSUmUtil.SetFormToJsStr(foForm = aLiActor, sForm = "", sJson = sFile, sKey = "aLiActor", iSet = 0, sLabel = "Form", sOpt = "") AS Actor)
	
	;INT List
	
	;STRING List
	
	;Form List
	;akSavedActors 			= iSUmUtil.StoreActorsToJson(akSavedActors, "akSavedActors", sFile, False)
	
	;StorageUtil FLOAT
	StorageUtil.SetFloatValue(aSelActor, "iDDefSelfTimer", JsonUtil.GetFloatValue(sFile, "iDDefSelfTimer", StorageUtil.GetFloatValue(aSelActor, "iDDefSelfTimer", 0)))
	
	;StorageUtil String
	;StorageUtil.SetStringValue(aSelActor, "iDDeOutEqpPre", JsonUtil.GetStringValue(sFile, "iDDeOutEqpPre", StorageUtil.GetStringValue(aSelActor, "iDDeOutEqpPre", "")))
	
	;StorageUtil INT
	
	;INT Array
	JsonUtil.IntListSlice(sFile, "iPickSuit", iPickSuit)
	JsonUtil.IntListSlice(sFile, "iPickGag", iPickGag)
	JsonUtil.IntListSlice(sFile, "iPickHood", iPickHood)
	JsonUtil.IntListSlice(sFile, "iPickBinder", iPickBinder)
	JsonUtil.IntListSlice(sFile, "iPickBlinder", iPickBlinder)
	JsonUtil.IntListSlice(sFile, "iPickCollar", iPickCollar)
	JsonUtil.IntListSlice(sFile, "iPickGloves", iPickGloves)
	JsonUtil.IntListSlice(sFile, "iPickBoots", iPickBoots)
	JsonUtil.IntListSlice(sFile, "iPickBelt", iPickBelt)
	JsonUtil.IntListSlice(sFile, "iPickHarn", iPickHarn)
	JsonUtil.IntListSlice(sFile, "iPickPlugA", iPickPlugA)
	JsonUtil.IntListSlice(sFile, "iPickPlugV", iPickPlugV)
	JsonUtil.IntListSlice(sFile, "iPickPieV", iPickPieV)
	JsonUtil.IntListSlice(sFile, "iPickPieN", iPickPieN)
	JsonUtil.IntListSlice(sFile, "iPickCuffsA", iPickCuffsA)
	JsonUtil.IntListSlice(sFile, "iPickCuffsL", iPickCuffsL)
	JsonUtil.IntListSlice(sFile, "iPickBra", iPickBra)
	
	;iDDeUti values
	iDDe.iDDeImportSettings(sFile)
	;iDDeFunc Values
	iDDeFunc.iDDeImportSettings(sFile)
	
	;Register new keys
	RegisterHotKeys(sOpt = "Register")
	;Misc
	StorageUtil.SetStringValue(None, "iDDeOutCustomTextColor", sOutCo)
	StorageUtil.SetStringValue(None, "iDDeOutLocalTextColor", sOutLoCo)
	
	Wait(1.1)
	iDDeUtil.Log("iDDeConfig.iDDeImportSettings():-> ", "Loading MCM... Done!", 3, 1)
	RETURN 1
EndFunction
INT Function ImportDefSettings()
	sConFile	= JsonUtil.GetStringValue(GetPathJson(sPath = "PlaSys"), "sConFile", "Default")
		If (sConFile)
			STRING sFile = GetPathJson(sPath = "PlaMCM", sJson = sConFile)
			RETURN iDDeImportSettings(sFile)
		EndIf
	RETURN 0
EndFunction
;mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
 
Function CleanUpJunk()
	StorageUtil.UnSetIntValue(aSelActor, "iDDeEqpCust")
	StorageUtil.UnSetStringValue(aSelActor, "sDDeEquipNow")
	StorageUtil.UnSetIntValue(iDDe.PlayerRef, "iDDeConfigBusy")
	iDDe.CleanUpJunk()
EndFunction

;Update 
;uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu
STRING sUpdMod = "DDE"
STRING sUpdList = "iDDeConfigBusy"
Event OnConfigInit() 
	SetUpMCM(sEvent = "Initialize ", fWait = 6.66, sList = sUpdList, sMod = sUpdMod)
EndEvent
Event OnVersionUpdate(Int aiVersion)
	If (CurrentVersion != aiVersion)
		SetUpMCM(sEvent = "Update ", fWait = 6.66, sList = sUpdList, sMod = sUpdMod)
	EndIf
EndEvent
Event OnGameReload() 
	Parent.OnGameReload()
	SetUpMCM(sEvent = "LoadGame ", fWait = 2.2, sList = sUpdList, sMod = sUpdMod)
EndEvent
BOOL Function StartAllQuests(STRING sEvent = "")
	BOOL bReturn = False
		iDDeLibsQuest.Start()
		iDDeUtiQuest.Start()
		bReturn = Self.Start()
		WaitMenuMode(6.6)	
	RETURN (iDDe.iDDeRegEvents(sEvent) && bReturn)
EndFunction 
BOOL Function StopAllQuests(STRING sEvent = "") 
	iDDe.iDDeUnRegEvents(sEvent, 1)
	iDDe.iDDeStopQuest(iDDeLibsQuest)
	iDDe.iDDeStopQuest(iDDeUtiQuest)
	RETURN iDDe.iDDeStopQuest(Self)
EndFunction
INT Function RegisterEvents(STRING sEvent = "", INT iDis = 1)
	RETURN iDDe.iDDeRegEvents(sEvent, iDis)
EndFunction
INT Function SetEvent(INT iOldVersion = 0, INT iNewVersion = 0, STRING sEvent = "Update ")
	ForceCloseMenu()
	CurrentVersion = GetVersion()
	STRING sNewVersion = GetSemVerStr()
	STRING sOldVersion = StorageUtil.GetStringValue(None, "iDDeVersionStr", "0.0.0")
	INT iRet = 0
		iDDeUtil.Log("iDDeConfig.SetEvent():-> ", sEvent+ "to version " +sNewVersion+ "!", 3, 1)
		iDDeUtil.Log("iDDeConfig.SetEvent():-> ", "Script reported version " +iDDeUtil.GetSemVerStr(), 3)
			If (sEvent == "Update ")
				iDDeUtil.Log("iDDeConfig.SetEvent():-> ", "Old sVersion " +sOldVersion, 3)
				iDDeUtil.Log("iDDeConfig.SetEvent():-> ", "New MCM reported iVersion " +iNewVersion, 3)
				iDDeUtil.Log("iDDeConfig.SetEvent():-> ", "Old MCM reported iVersion " +iOldVersion, 3)
				CleanUpJunk()
			EndIf
			If (StopAllQuests(sEvent))
				WaitMenuMode(2.2)
			EndIf
		WaitMenuMode(2.2)
			If (StartAllQuests(sEvent))
				StorageUtil.SetStringValue(None, "iDDeVersionStr", sNewVersion)
				iRet = 1
			EndIf
	RETURN iRet
EndFunction
