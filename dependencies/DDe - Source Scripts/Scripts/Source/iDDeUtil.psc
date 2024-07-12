ScriptName iDDeUtil Hidden

Import Utility
Import Game

;Versions
STRING Function GetSemVerStr() GLOBAL ;Semantic Version
	RETURN "6.3.6"
EndFunction
INT Function GetVersion() GLOBAL  
	RETURN iSUmUtil.SemVerToInt(sVer = GetSemVerStr())
EndFunction 
STRING Function GetVersionStr() GLOBAL
	RETURN GetSemVerStr()
EndFunction
 
;API
iDDeMain Function GetAPI() GLOBAL
	If (GetModByName("Devious Devices - Equip.esp") < 255)
		RETURN (GetFormFromFile(0x00000D62, "Devious Devices - Equip.esp") AS iDDeMain)
	EndIf
	RETURN None
EndFunction
iDDeConfig Function GetMCM() GLOBAL
	If (Game.GetModByName("Devious Devices - Equip.esp") < 255)
		RETURN (Game.GetFormFromFile(0x00000D63, "Devious Devices - Equip.esp") AS iDDeConfig)
	EndIf
	RETURN None
EndFunction
iDDeLibs Function GetLibs() GLOBAL
	If (GetModByName("Devious Devices - Equip.esp") < 255)
		RETURN (GetFormFromFile(0x00000D64, "Devious Devices - Equip.esp") AS iDDeLibs)
	EndIf
	RETURN None
EndFunction

;System
Function Log(STRING sInfoLog = "", STRING sInfoDis = "", INT iLevel = 4, INT iDis = 0) GLOBAL
	iSUmUtil.Log(sInfoLog = sInfoLog, sInfoDis = sInfoDis, iLevel = iLevel, iDis = iDis, sMod = "DDE")
EndFunction
STRING Function GetPath(STRING sPath = "", STRING sJson = "Null", STRING sType = "") GLOBAL
	iDDeConfig iDDeMCM = GetMCM()
		If (iDDeMCM)
			If (sJson != "Null")
				If (sJson == "iDDeSystem")
					RETURN iDDeMCM.GetPathJson(sPath = "DDeSys")
				ElseIf (sJson == "iDDeGloSystem")
					RETURN iDDeMCM.GetPathJson(sPath = "GloSys")	
				ElseIf (sJson == "iDDePlaSystem")
					RETURN iDDeMCM.GetPathJson(sPath = "PlaSys")
				ElseIf (sJson == "iDDeSystemMCM")
					RETURN iDDeMCM.GetPathJson(sPath = "DDeMCM")	
				EndIf
				sJson = iDDeMCM.SetJson(sJson = sJson)
			EndIf
			If (sPath != "Null")
				If (sJson == "Null")
					sJson = ""
				EndIf
				If (sPath == "iDDeSystem")
					sPath = iDDeMCM.GetPathFolder(sPath = "DDe", sFolder = "System")
				ElseIf (StringUtil.Find(sPath, "/", 0) < 0)
					sPath = iDDeMCM.GetFolder(sFolder = sPath, sType = sType)
				EndIf
				RETURN (sPath + sJson)
			EndIf
		EndIf
	RETURN ""
EndFunction

;Will stop and que function calls until the current function finishes. 
INT Function FunctionLock(Form akForm, STRING sFunction = "Default", INT iMax = 222) GLOBAL
	RETURN FormLock(akForm = akForm, sThisF = "FunctionLock", sForm = "iDDeFunctionLock", sCallF = sFunction, iMax = iMax)
EndFunction
INT Function FunctionUnLock(Form akForm, STRING sFunction = "Default") GLOBAL
	RETURN FormUnLock(akForm = akForm, sThisF = "FunctionUnLock", sForm = "iDDeFunctionLock", sCallF = sFunction)
EndFunction

;Will stop and que event calls until the current event finishes. 
INT Function EventLock(Form akForm, STRING sFunction = "Default", INT iMax = 333) GLOBAL
	RETURN FormLock(akForm = akForm, sThisF = "EventLock", sForm = "iDDeEventLock", sCallF = sFunction, iMax = iMax)
EndFunction
INT Function EventUnLock(Form akForm, STRING sFunction = "Default") GLOBAL
	RETURN FormUnLock(akForm = akForm, sThisF = "EventUnLock", sForm = "iDDeEventLock", sCallF = sFunction)
EndFunction

INT Function FormLock(Form akForm, STRING sThisF = "FormLock", STRING sForm = "Global", STRING sCallF = "?", INT iMax = 157, FLOAT fWait = 0.1, BOOL bReset = True) GLOBAL
		If (StorageUtil.GetIntValue(akForm, sForm, 0) != 0)
			Log(sThisF+ "():-> ", "[" +sCallF+ "] has set [" +sForm+ "] with a delay of [" +iMax+ "].")
			INT iMin = 0
				While ((StorageUtil.GetIntValue(akForm, sForm, 0) != 0) && (iMin <= iMax))
					iMin += 1
					WaitMenuMode(fWait)
				EndWhile
					If (iMin > iMax)
						Log(sThisF+ "():-> ", "[" +sCallF+ "] for [" +sForm+ "] has timed out! Cycles: " +iMin+ ". Reset? [" +bReset+ "].");
							If (bReset)
								StorageUtil.SetIntValue(akForm, sForm, 0)
							EndIf
						RETURN 0
					Else
						Log(sThisF+ "():-> ", "[" +sCallF+ "] finished with [" +sForm+ "]. Cycles: " +iMin+ ".")
					EndIf
		Else
			StorageUtil.SetIntValue(akForm, sForm, 1)
		EndIf
	RETURN 1
EndFunction
INT Function FormUnLock(Form akForm, STRING sThisF = "FormUnLock", STRING sForm = "Global", STRING sCallF = "?", INT iVal = 0, BOOL bReset = True) GLOBAL
	Log(sThisF+ "():-> ", "[" +sCallF+ "] is setting [" +sForm+ "] to [" +iVal+ "].")
	StorageUtil.SetIntValue(akForm, sForm, iVal)
	If (bReset)
		StorageUtil.UnSetIntValue(akForm, sForm)
	EndIf
	RETURN 1
EndFunction

;DDe Functions
INT Function SendDDeEvent(Actor aActor, STRING sEvent = "iDDeEquipOutfit", STRING sList = "iDDeNoName", INT iDDs = 66, STRING sOpt = "", INT iOpt = 0) GLOBAL
	iDDeMain iDDe = GetAPI()
	INT iRet = -1
		If (iDDe)
			FunctionLock(aActor, sFunction = "SendDDeEvent", iMax = 256)
				If (sEvent == "iDDeEquipWorn")
					iRet = iDDe.EquipWorn(aSlave = aActor, sList = sList, iDDs = iDDs, sOpt = sOpt, iOpt = iOpt)
				ElseIf(sEvent == "iDDeEquipList")
					iRet = iDDe.EquipList(aSlave = aActor, sList = sList, iDDs = iDDs, sOpt = sOpt, iOpt = iOpt)
				ElseIf(sEvent == "iDDeEquipOutfit")
					iRet = iDDe.EquipOutfit(aSlave = aActor, sList = sList, iDDs = iDDs, sOpt = sOpt, iOpt = iOpt)
				ElseIf(sEvent == "iDDeListAllWornDDs")
					iRet = iDDe.ListAllWornDDs(aSlave = aActor, sList = sList, iDDs = iDDs, sOpt = sOpt, iOpt = iOpt)
				ElseIf(sEvent == "iDDeEquipByTags")
					iRet = iDDe.EquipByTags(aSlave = aActor, sTags = sList, iDDs = iDDs, sOpt = sOpt, iOpt = iOpt)
				ElseIf(sEvent == "iDDeEquipOutfitByKeyword")
					iRet = iDDe.EquipOutfitByKeyword(aSlave = aActor, sList = sList, iDDs = iDDs, sOpt = sOpt, iDelL = iOpt)
				ElseIf(sEvent == "iDDeEquipIdx")
					iRet = iDDe.EquipIdx(aSlave = aActor, sList = sList, iDDs = iDDs, sOpt = sOpt, iOpt = iOpt)
				ElseIf(sEvent == "iDDeSetMech")
					iRet = iDDe.SetMech(aSlave = aActor, sList = sList, iDDs = iDDs, sOpt = sOpt, iOpt = iOpt)
				ElseIf(sEvent == "iDDeStrip")
					iRet = iDDe.Strip(aSlave = aActor, sList = sList, iDDs = iDDs, sOpt = sOpt, iOpt = iOpt)
				Else
					Log("SendDDeEvent():-> ", "[" +sEvent+ "]-> No such event. Check spelling.", 1)
				EndIf
			FunctionUnLock(aActor, sFunction = "SendDDeEvent")
		EndIf
	RETURN iRet
EndFunction
INT Function RemoveAll(Actor aActor, ObjectReference akStoreContainer = None, BOOL bWornRestr = False, BOOL Anim = False) GLOBAL
	iDDeMain iDDe = GetAPI()
		If (iDDe)
			RETURN iDDe.iDDeRemoveAll(aActor, akStoreContainer, bWornRestr, Anim)
		EndIf
	RETURN 0
EndFunction
INT Function GetDDsByTags(Actor aSlave, STRING sList = "iDDeTagDevice", STRING sTags = "", STRING sDivider = ",") GLOBAL
	iDDeMain iDDe = GetAPI()
		If (iDDe)
			RETURN iDDe.iDDeGetTagsDD(aSlave, sList, sTags, sDivider)	
		EndIf
	RETURN 0
EndFunction
INT Function EquipFormList(Actor aActor = None, STRING sList = "iDDeNoName", INT iDDs = 111, BOOL b86 = False, BOOL bRemQ = False, INT iDelL = 4, BOOL bPluckL = False, INT idx = -1, ObjectReference orCont = None, BOOL bSkipO = False, BOOL bSkipE = False, BOOL bSkipM = False) GLOBAL
	iDDeMain iDDe = GetAPI()
		If (iDDe)
			RETURN iDDe.iDDeEquipFormList(aSlave = aActor, sList = sList, iDDs = iDDs, b86 = b86, bRemQ = bRemQ, iDelL = iDelL, bPluckL = bPluckL, idx = idx, orCont = orCont, bSkipO = bSkipO, bSkipE = bSkipE, bSkipM = bSkipM)
		EndIf
	RETURN 0
EndFunction
INT Function EquipRenStrList(Actor aActor = None, STRING sList = "iDDeNoName", INT iDDs = 111, BOOL b86 = False, BOOL bRemQ = False, INT iDelL = 4, BOOL bPluckL = False, INT idx = -1, ObjectReference orCont = None, BOOL bSkipO = False, BOOL bSkipE = False, BOOL bSkipM = False) GLOBAL
	iDDeMain iDDe = GetAPI()
		If (iDDe)
			RETURN iDDe.iDDeEquipRenStrList(aSlave = aActor, sList = sList, iDDs = iDDs, b86 = b86, bRemQ = bRemQ, iDelL = iDelL, bPluckL = bPluckL, idx = idx, orCont = orCont, bSkipO = bSkipO, bSkipE = bSkipE, bSkipM = bSkipM)
		EndIf
	RETURN 0
EndFunction
INT Function AppendList(Actor aActor = None, STRING sFinalList = "iDDeFinNoName", STRING sAddList = "iDDeAddNoName") GLOBAL
	iDDeMain iDDe = GetAPI()
		If (iDDe)
			RETURN iDDe.iDDeAppendList(aSlave = aActor, sFinalList = sFinalList, sAddList = sAddList)
		EndIf
	RETURN 0
EndFunction
INT Function CopyList(Actor aActor = None, STRING sOriList = "iDDeFinNoName", STRING sDesList = "iDDeAddNoName", STRING sOpt = "bNew") GLOBAL
	iDDeMain iDDe = GetAPI()
		If (iDDe)
			RETURN iDDe.iDDeCopyList(aSlave = aActor, sOriList = sOriList, sDesList = sDesList, sOpt = sOpt)
		EndIf
	RETURN 0
EndFunction
INT Function ManDDsByKeyword(Actor aActor, Keyword kw, BOOL bEquip, BOOL b86Dev = False, INT iRemQuest = 0, BOOL bSkipEvents = False, BOOL bSkipMutex = False) GLOBAL
	iDDeMain iDDe = GetAPI()
		If (iDDe)
			RETURN iDDe.iDDeManDDsByKeyword(aActor, kw, bEquip, b86Dev, iRemQuest, bSkipEvents, bSkipMutex)
		EndIf
	RETURN 0
EndFunction
INT Function HasWornDDs(Actor aSlave = None, INT idx = 0) GLOBAL
	iDDeMain iDDe = GetAPI()
		If (iDDe)
			RETURN iDDe.iDDeHasWornDDs(aSlave, idx)
		EndIf
	RETURN 0
EndFunction
INT Function RemoveKeys(Actor aSlave, BOOL bStdKeysOnly = False, ObjectReference akOtherContainer = None) GLOBAL 
	iDDeMain iDDe = GetAPI()
		If (iDDe)
			RETURN iDDe.iDDeRemoveKeys(aSlave, bStdKeysOnly, akOtherContainer) 
		EndIf
	RETURN 0
EndFunction
INT Function ListWornDDs(Actor aActor = None, STRING sList = "iDDeNoName", STRING sMake = "bNew", BOOL bAll = False) GLOBAL
	iDDeMain iDDe = GetAPI()
		If (iDDe)
			RETURN iDDe.iDDeListWorn(aActor, sList, sMake, bAll)
		EndIf
	RETURN 0
EndFunction
INT Function PluckKeyword(Actor aActor = None, STRING sList = "iDDeNoName", STRING sKeyWord = "zad_QuestItem") GLOBAL
	iDDeMain iDDe = GetAPI()
		If (iDDe)
			RETURN iDDe.iDDePluckKeyword(aActor, sList, sKeyWord)
		EndIf
	RETURN 0
EndFunction
KEYWORD Function GetWornKwd(Actor aSlave = None, INT iKw = -1) GLOBAL
	iDDeMain iDDe = GetAPI()
		If (iDDe)
			RETURN iDDe.iDDeGetWornKwd(aSlave, iKw)
		EndIf
	RETURN None
EndFunction
KEYWORD Function GetKwdByStr(STRING sKwd = "None") GLOBAL
	iDDeMain iDDe = GetAPI()
		If (iDDe)
			RETURN iDDe.iDDeGetKwdByStr(sKwd)
		EndIf
	RETURN None
EndFunction
KEYWORD Function GetWornKwdByStr(Actor aSlave = None, STRING sKwd = "") GLOBAL
	iDDeMain iDDe = GetAPI()
		If (iDDe)
			RETURN iDDe.iDDeGetWornKwdByStr(aSlave, sKwd)
		EndIf
	RETURN None
EndFunction
STRING Function GetWornStrByStr(Actor aSlave = None, STRING sKwd = "") GLOBAL
	iDDeMain iDDe = GetAPI()
		If (iDDe)
			RETURN iDDe.iDDeGetWornStrByStr(aSlave, sKwd)
		EndIf
	RETURN ""
EndFunction
INT Function ManDDsByStrKwds(Actor aSlave = None, STRING sOutfit = "", STRING sKwds = "", INT iDDs = 0, STRING sOpt = "", INT iDelL = 0) GLOBAL
	iDDeMain iDDe = GetAPI()
	iDDeLibs Libs = GetLibs()
	INT iRet = 0
	Log("ManDDsByKwdStr():-> ", "Got sKwds = [" +sKwds+ "]. sOpt = [" +sOpt+ "].")
		If (iDDe && Libs && aSlave) 
			STRING sWornKwds = sKwds
				If (iDDs == 0)
					Log("ManDDsByKwdStr():-> ", "No. DDs = [" +iDDs+ "]. Exiting!", 1)
					RETURN 0
				EndIf
				If (!sOutfit)
					If ((sKwds == "Sex") || (sKwds == "Pose") || (sKwds == "Dance"))
						sOutfit = "iDDeOutManDDs" +sKwds
					Else
						sOutfit = "iDDeOutManDDs"
					EndIf
				EndIf
				If ((sKwds == "Clear") || (StringUtil.Find(sOpt, "bClear") > -1))
					INT j = StorageUtil.ClearFormListPrefix(sOutfit) 
						j += StorageUtil.ClearFormListPrefix("iDDeOutManDDs")
					Log("ManDDsByKwdStr():-> ", "Cleared [" +j+ "] form lists.")
					iRet += j
						j = StorageUtil.ClearStringListPrefix(sOutfit) 
						j += StorageUtil.ClearStringListPrefix("iDDeOutManDDs")
					Log("ManDDsByKwdStr():-> ", "Cleared [" +j+ "] string lists.")
					iRet += j
					RETURN iRet
				EndIf
			BOOL bMatch = (StringUtil.Find(sOpt, "bNoMatch") < 0)
				If (sKwds == "New")
					RETURN iDDe.EquipOutfit(aSlave = aSlave, sList = sOutfit, iDDs = iDDs, sOpt = sOpt)
				ElseIf (sKwds == "Sex")
					sWornKwds = GetWornStrKwds(aSlave, Libs.sSexKwds, !bMatch) 
				ElseIf (sKwds == "Pose") 
					sWornKwds = GetWornStrKwds(aSlave, Libs.sPoseKwds, !bMatch) 
				ElseIf (sKwds == "Dance") 
					sWornKwds = GetWornStrKwds(aSlave, Libs.sDanceKwds, !bMatch)
				EndIf
			Log("ManDDsByKwdStr():-> ", "sWornKwds = [" +sWornKwds+ "].")
				If (iDDs > 0)
					iRet = StorageUtil.StringListCount(aSlave, sOutfit)
					sOpt = iSUmUtil.StrAddElement(sStr = sOpt, sAdd = "bNoFilter", bAdd = (iRet && ((sKwds == "Sex") || (sKwds == "Pose") || (sKwds == "Dance"))), sDiv = ",")
					Log("ManDDsByKwdStr():-> ", "Found " +iRet+ " devices in [" +sOutfit+ "].")
				Else
					If (sWornKwds && (\
						 ((StringUtil.Find(sOpt, "bKeepBoxbinder", 0) > -1) || (StringUtil.Find(sOpt, "bKeepStraitJacket", 0) > -1)) && \
						 (iDDe.iDDeGetWornStrByStr(aSlave, "iDDe_DeviousBoxbinder") || iDDe.iDDeGetWornStrByStr(aSlave, "zad_DeviousStraitJacket"))\
						 ))
						sWornKwds = iSUmUtil.StrPluck(sStr = sWornKwds, sPluck = "zad_DeviousHeavyBondage", sRepl = "", iMany = -1, idx = 0)
						Log("ManDDsByKwdStr():-> ", "Readjusted sWornKwds = [" +sWornKwds+ "].")
					EndIf	
					If (sKwds && !sWornKwds)
						Log("ManDDsByKwdStr():-> ", "No worn keywords to process!", 2)
						RETURN 0
					EndIf 
					iRet = iDDe.ListAllWornDDs(aSlave = aSlave, sList = sOutfit, iDDs = 1, sOpt = "bNew")
					Log("ManDDsByKwdStr():-> ", "Found " +iRet+ " worn devices!")
					If (iRet < 1)
						Log("ManDDsByKwdStr():-> ", "No devices to process!", 2)
						RETURN 0
					EndIf
				EndIf
			iRet = iDDe.EquipOutfitByKeyword(aSlave = aSlave, sList = (sOutfit+ "," +sWornKwds), iDDs = iDDs, sOpt = sOpt, iDelL = iDelL)
		Else
			Log("ManDDsByKwdStr():-> ", "Failed! Got iDDe? " +iDDe+ ". Got Libs? " +Libs+ ". Slave = [" +aSlave+ "].", 1)
		EndIf
	RETURN iRet
EndFunction
STRING Function GetWornStrKwds(Actor aActor = None, STRING[] sWorns, BOOL bAll = False) GLOBAL	
	iDDeMain iDDe = GetAPI()
	STRING sRet = ""
		If (iDDe)
			INT iMax = sWorns.Length
			INT i = 0
				While (i < iMax)
					If (bAll || iDDe.iDDeGetWornStrByStr(aActor, sWorns[i]))
						sRet = iSUmUtil.StrAddElement(sStr = sRet, sAdd = sWorns[i], bAdd = True, sDiv = ",")
					EndIf
					i += 1
				EndWhile
		EndIf
	RETURN sRet
EndFunction
STRING Function ListWornDDeStrKwds(Actor aActor = None, STRING sList = "") GLOBAL	
	iDDeMain iDDe = GetAPI()
		If (iDDe)
			RETURN iDDe.ListWornDDeStrKwds(aSlave = aActor, sList = sList)
		EndIf
	RETURN ""
EndFunction
STRING Function SetDevToStr(Form akDev = None) GLOBAL
	iDDeMain iDDe = GetAPI()
		If (iDDe)
			RETURN iDDe.SetDevToStr(akDev = akDev)
		EndIf
	RETURN ""
EndFunction

;DDi Functions
BOOL Function ZadSetAnimating(Actor aActor, BOOL bAnimate) GLOBAL
	zadLibs Libs = GetFormFromFile(0x0000F624, "Devious Devices - Integration.esm") AS zadLibs 
		If (Libs)
			Libs.SetAnimating(aActor, bAnimate)
			RETURN True
		EndIf
	RETURN False
EndFunction
BOOL Function ZadIsAnimating(Actor aActor) GLOBAL
	zadLibs Libs = GetFormFromFile(0x0000F624, "Devious Devices - Integration.esm") AS zadLibs 
		If (Libs)	
			RETURN Libs.IsAnimating(aActor)
		EndIf
	RETURN False
EndFunction
INT Function VibrateEffect(Actor aSlave, INT iPower = 5, INT iDuration = 66, STRING sOpt = "") GLOBAL
	INT iRet = 0
		If (aSlave)
			zadLibs Libs = GetFormFromFile(0x0000F624, "Devious Devices - Integration.esm") AS zadLibs 
				If (Libs)
					Wait(0.1) ;for menus to close
						If (iDuration > 0)
							BOOL bShock = False
							BOOL bOrgasm = False
							BOOL bTeaseOnly = False
							BOOL bSilent = False
							INT iVibe = 1
								If (sOpt)
									bShock = (StringUtil.Find(sOpt, "bShock") != -1)	
									bOrgasm = (StringUtil.Find(sOpt, "bOrgasm") != -1)
									bTeaseOnly = (StringUtil.Find(sOpt, "bTeaseOnly") != -1)	
									bSilent = (StringUtil.Find(sOpt, "bSilent") != -1)
										If ((StringUtil.Find(sOpt, "bPlug") != -1) && !aSlave.WornHasKeyword(Libs.zad_DeviousPlug));, int startIndex = 0)
											iVibe = 0
										ElseIf ((StringUtil.Find(sOpt, "bPiercing") != -1) && !(aSlave.WornHasKeyword(Libs.zad_DeviousPiercingsNipple) || \
											aSlave.WornHasKeyword(Libs.zad_DeviousPiercingsVaginal)))
											iVibe = 0
										EndIf
										If (bShock)	
											Libs.ShockActor(aSlave)
											Libs.AttrDrain(aSlave, "Health")
											Libs.AttrDrain(aSlave, "Magicka")
											Libs.AttrDrain(aSlave, "Stamina")
											Libs.ShockActor(aSlave)
										EndIf
								EndIf
								If (iVibe)
									iRet = Libs.VibrateEffect(aSlave, iPower, iDuration, bTeaseOnly, bSilent)
								Else
									iRet = ((bOrgasm || bShock) AS INT)
								EndIf
								If (bOrgasm)
									Libs.ActorOrgasm(aSlave, 66, -1)
								EndIf
								If (bShock)	
									Libs.ShockActor(aSlave)
									Libs.AttrDrain(aSlave, "Health")
									Libs.AttrDrain(aSlave, "Magicka")
									Libs.AttrDrain(aSlave, "Stamina")
									Libs.ShockActor(aSlave)
								EndIf
						Else
							Libs.StopVibrating(aSlave)
							iRet = -3
						EndIf
				EndIf
		EndIf
	RETURN iRet
EndFunction

