ScriptName iDDeMisc Extends Quest

Import Utility
Import Game

STRING Function ExeAdminFun(STRING sFun = "", STRING sOpt = "", INT iOpt = 0) 
	STRING sRet = ""
		If (sOpt == "Help")
			If (sFun == "AdminFunction")
				sRet = "Available functions:\n[DDsBuild]; [DDsBuildForms]; [SomeFunction]."
			ElseIf (sFun == "DDsBuildForms")
				sRet = "[iGetLMax=66] - Max No. of lists to process. [iSave=0] - no save.[sSetJ=] - Destination .json. [sModL=] - Mods to replace list. [sRenL] - Rename list. [sNamL] - Name/word list."
			Else
				sRet = "Enter admin function."
			EndIf
		ElseIf (sFun && sOpt)
			STRING[] sOpts = PapyrusUtil.StringSplit(sOpt, ",")	
			INT iOp = 0
			INT iOpMax = sOpts.Length
				If (sFun == "DDsBuildForms")
					STRING sSetJ = iDDeMCM.GetPathJson(sPath = "DDeSys", sJson = "DDsLibs")
						If (StringUtil.Find(sOpt, "sSetJ=") > -1)
							While (iOp < iOpMax)
								If (StringUtil.Find(sOpts[iOp], "sSetJ=") == 0)
									sSetJ = StringUtil.Substring(sOpts[iOp], StringUtil.GetLength("sSetJ="), 0)
									iOp = iOpMax
								EndIf
								iOp += 1
							EndWhile
							If (StringUtil.Find(sSetJ, "../") < 0)
								sSetJ = iDDeMCM.GetPathJson(sPath = "DDeSys", sJson = sSetJ)
							EndIf
						EndIf
					DDsBuildForms(sOpt = sOpt, sSetJ = sSetJ)
				ElseIf (sFun == "SomeFunction")
					
				EndIf
		EndIf
		If (!sRet)
			If (!sFun)
				iDDeUtil.Log("iDDeMisc.ExeAdminFun():-> ", "Bad, bad function! sFun = [" +sFun+ "].", 1, 1)
			ElseIf (!sOpt)	
				iDDeUtil.Log("iDDeMisc.ExeAdminFun():-> ", "Bad, bad function options! sOpt = [" +sOpt+ "].", 1, 1)
			EndIf
		EndIf
	RETURN sRet
EndFunction
INT Function StrOptsToJson(STRING sOpt = "", STRING sFunc = "", STRING sJson = "", BOOL bDup = False, STRING sOpr = "=")
	iSUmUtil.Log("iDDeMisc.StrOptsToJson():-> ", "Start...")
	INT iRet = 0
		If (sJson)
			STRING[] sStrVal = NEW STRING[5]
				sStrVal[0] = "sGetJ"
				sStrVal[1] = "sSys"
				sStrVal[2] = "sModL"
				sStrVal[3] = "sRenL"
				sStrVal[4] = "sNamL"
			STRING[] sStrList = NEW STRING[1]
				sStrList[0] = "sTypes"
			STRING[] sIntVal = NEW STRING[2]	
				sIntVal[0] = "iGetLMax"
				sIntVal[1] = "iSave"
			INT i = 0
			INT iStrValMax = sStrVal.Length
			INT iStrListMax = sStrList.Length
			INT iIntValMax = sIntVal.Length
				While (i < iStrValMax)
					JsonUtil.UnSetStringValue(sJson, (sFunc + sStrVal[i]))
					i += 1
					iRet += i
				EndWhile
			i = 0
				While (i < iIntValMax)
					JsonUtil.UnSetIntValue(sJson, (sFunc + sIntVal[i]))
					i += 1
					iRet += i
				EndWhile
			i = 0
				While (i < iStrListMax)
					JsonUtil.StringListClear(sJson, (sFunc + sStrList[i]))
					i += 1
					iRet += i
				EndWhile
				If (sOpt)
					STRING[] sOpts = PapyrusUtil.StringSplit(sOpt, ",")
					INT iOpt = 0
					INT iOptMax = sOpts.Length
					INT iGot = 0
					iRet = 0
						While (iOpt < iOptMax)
							i = 0
							iGot = iRet
								While ((iGot == iRet) && (i < iIntValMax))
									If ((sOpts[iOpt] == sIntVal[i]) && JsonUtil.SetIntValue(sJson, (sFunc + sIntVal[i]), 1)) ;Bools
										iRet += 1
									ElseIf ((StringUtil.Find(sOpts[iOpt], (sIntVal[i] + sOpr)) == 0) && \
										(JsonUtil.SetIntValue(sJson, (sFunc + sIntVal[i]), (StringUtil.Substring(sOpts[iOpt], StringUtil.GetLength(sIntVal[i] + sOpr), 0) AS INT)) > -1))
										iRet += 1
									EndIf
									i += 1
								EndWhile
							i = 0
								While ((iGot == iRet) && (i < iStrValMax))
									If ((StringUtil.Find(sOpts[iOpt], (sStrVal[i] + sOpr)) == 0) && \
										(JsonUtil.SetStringValue(sJson, (sFunc + sStrVal[i]), StringUtil.Substring(sOpts[iOpt], StringUtil.GetLength(sStrVal[i] + sOpr), 0)) > -1))
										iRet += 1
									EndIf
									i += 1
								EndWhile
							i = 0
								While ((iGot == iRet) && (i < iStrListMax))
									If ((StringUtil.Find(sOpts[iOpt], (sStrList[i] + sOpr)) == 0) && \
										(JsonUtil.StringListAdd(sJson, (sFunc + sStrList[i]), StringUtil.Substring(sOpts[iOpt], StringUtil.GetLength(sStrList[i] + sOpr), 0), bDup) > -1))
										iRet += 1
									ElseIf ((i == (iStrListMax - 1)) && (JsonUtil.StringListAdd(sJson, (sFunc + sStrList[i]), sOpts[iOpt], bDup) > -1)) ;Has to be last.
										iRet += 1
									EndIf
									i += 1
								EndWhile
							iOpt += 1
						EndWhile
				EndIf
				If (iRet)
					JsonUtil.SetStringValue(sJson, (sFunc+ "sOpt"), sOpt) 
				EndIf
		Else
			iSUmUtil.Log("iDDeMisc.StrOptsToJson():-> ", "No json!")
		EndIf		
	iSUmUtil.Log("iDDeMisc.StrOptsToJson():-> ", "Done! Processed [" +iRet+ "] items.")
	RETURN iRet
EndFunction
INT Function DDsBuildForms(STRING sOpt = "", STRING sSetJ = "", STRING sFunc = "DDsBuildForms_")
	;+++++++++++++++++++++++++++++++++++++++++++++++
		;sOpt => 
	;+++++++++++++++++++++++++++++++++++++++++++++++
	iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "Proccesing DDs... Please stand by!", 3, 1)
		If (!sOpt)
			iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "No options!", 1, 1)
			RETURN iRet
		EndIf
	StrOptsToJson(sOpt = sOpt, sFunc = sFunc, sJson = sSetJ)
	STRING sGetJ = JsonUtil.GetStringValue(sSetJ, (sFunc+ "sGetJ"), "DDsRaw")
	STRING sSys = JsonUtil.GetStringValue(sSetJ, (sFunc+ "sSys"), "DDsPara")
		If (StringUtil.Find(sGetJ, "../") < 0)
			sGetJ = iDDeMCM.GetPathJson(sPath = "DDeSys", sJson = sGetJ)
		EndIf
		If (StringUtil.Find(sSys, "../") < 0)
			sSys = iDDeMCM.GetPathJson(sPath = "DDeSys", sJson = sSys)
		EndIf
	iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "Save json file = [" +sSetJ+ "].")
		If (!sSetJ)
			iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "No data .json!", 1)
			RETURN iRet
		EndIf
	JsonUtil.SetIntValue(sSetJ, (sFunc+ "Status"), 1)
	JsonUtil.SetIntValue(sSetJ, (sFunc+ "FuncSave"), 0)
	iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "System json file = [" +sSys+ "].")
	iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "DDs json file = [" +sGetJ+ "].")
	STRING[] sGetLs = JsonUtil.PathMembers(sGetJ, ".stringList")
	INT iRet = 0
	INT iGetL = JsonUtil.GetIntValue(sSetJ, (sFunc+ "iGetLMax"), 0)
	INT iGetLMax = sGetLs.Length
		If (iGetL && (iGetL < iGetLMax)) 
			iGetLMax = iGetL
		EndIf
	iGetL = JsonUtil.GetIntValue(sSetJ, (sFunc+ "iGetL"), 0)
		If (iGetL > iGetLMax)
			iGetL = 0
		EndIf
		If (iGetLMax)
			STRING s = ""
			STRING sMod = ""
			STRING sRen = ""
			STRING sNam = ""
			STRING sNamW = ""
			STRING sNamF = ""
			STRING sNamT = ""
			STRING sGetL = ""
			STRING sSetL = ""
			STRING sForm = ""
			STRING sModL = JsonUtil.GetStringValue(sSetJ, (sFunc+ "sModL"), "dds_mods_toreplace")
			STRING sRenL = JsonUtil.GetStringValue(sSetJ, (sFunc+ "sRenL"), "dds_editorids_toreplace")
			STRING sNamL = JsonUtil.GetStringValue(sSetJ, (sFunc+ "sNamL"), "dds_word_")
			INT i = 0
			INT iMax = 0
			INT iMod = 0
			INT iModMax = JsonUtil.StringListCount(sSys, sModL)
			INT iRen = 0
			INT iRenMax = JsonUtil.StringListCount(sSys, sRenL)
			INT iNam = 0
			INT iNamMax = 0
			INT iNamL = 0
			INT iNamLMax = JsonUtil.CountStringListPrefix(sSys, sNamL)
			INT iForm = 0
			INT iSetL = 0
			BOOL bDone = False
			INT iSave = JsonUtil.GetIntValue(sSetJ, (sFunc+ "iSave"), 1)
				iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "sModL = [" +sModL+ "].")
				iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "sRenL = [" +sRenL+ "].")
				iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "sNamL = [" +sNamL+ "].")
					While (iGetL < iGetLMax)
						sGetL = sGetLs[iGetL] 
						iMax = JsonUtil.StringListCount(sGetJ, sGetL)
						sMod = ""
						sSetL = ""
						iSetL = 0
						iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "List [" +sGetL+ "] has [" +iMax+ "] elements!")
							If (iMax)
								If (sGetL && (StringUtil.Find(sGetL, "formids") > -1))
									sSetL = iSUmUtil.StrPluck(sStr = sGetL, sPluck = "id")
									iSetL = 1
								ElseIf(sGetL && (StringUtil.Find(sGetL, "editorids") > -1))
									sSetL = iSUmUtil.StrPluck(sStr = sGetL, sPluck = "editorids", sRepl = "Name")
									iSetL = 2
								ElseIf(sGetL && (StringUtil.Find(sGetL, "name") > -1))
									sSetL = iSUmUtil.StrPluck(sStr = sGetL, sPluck = "name", sRepl = "DispName")
									iSetL = 3
								ElseIf(sGetL && (StringUtil.Find(sGetL, "description") > -1))
									sSetL = sGetL
									iSetL = 4
								EndIf
								If (iModMax)
									iMod = 0
										While (!sMod && (iMod < iModMax))
											If (sGetL && (StringUtil.Find(sGetL, JsonUtil.StringListGet(sSys, sModL, iMod)) > -1))
												sMod = JsonUtil.StringListGet(sSys, sModL, (iMod + 1))
											EndIf
											iMod += 2
										EndWhile
								Else
									iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "Mod array empty???", 1)	
								EndIf	
								If (sSetL && sMod)
									If (iSetL == 1)
										iSUmUtil.JsonPathClear(sJson = sSetJ, sKey = sSetL, sType = ".formList")
									Else
										JsonUtil.StringListClear(sSetJ, sSetL)
										JsonUtil.StringListResize(sSetJ, sSetL, iMax, "")
									EndIf
									i = 0
										While (i < iMax)
											sForm = JsonUtil.StringListGet(sGetJ, sGetL, i)
												If (iSetL == 1)
													iForm = iSUmUtil.HexToInt(sHex = sForm)
													sForm = (iForm+ "|" +sMod)
												ElseIf (iSetL == 2)
													iRen = 0
														While (iRen < iRenMax)
															sForm = iSUmUtil.StrPluck(sStr = sForm, sPluck = JsonUtil.StringListGet(sSys, sRenL, iRen), \
																																			 sRepl = JsonUtil.StringListGet(sSys, sRenL, (iRen + 1)))
															iRen += 2
														EndWhile
														If (sForm)
															iNamL = 0
															sNamF = ""
																While (sForm && (iNamL < iNamLMax)) ;All words
																	s = sNamL
																		If (iNamL < 9)
																			s += "0"
																		EndIf
																	s += (iNamL + 1)
																	iNamMax = JsonUtil.StringListCount(sSys, s)
																	iNam = 0
																	bDone = False	
	;iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "s = [" +s+ "].")
	;iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "iNamMax = [" +iNamMax+ "].")
	;iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "sForm = [" +sForm+ "].")
																		While (!bDone && sForm && (iNam < iNamMax)) ;One word
																			sNamW = JsonUtil.StringListGet(sSys, s, iNam)
																			sNamT = iSUmUtil.StrPluck(sStr = sForm, sPluck = sNamW, iMany = 1)
	;iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "sNamW = [" +sNamW+ "].")
	;iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "sNamT = [" +sNamT+ "].")
																				If (sNamT != sForm)
																					sNamF += sNamW
																					sForm = sNamT
																					bDone = True
																				EndIf
	;iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "sNamF = [" +sNamF+ "].")
	;iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "sForm = [" +sForm+ "].")
																			iNam += 1
																		EndWhile
																	iNamL += 1
																EndWhile
															sForm = sNamF
														EndIf	
	;iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "Final sForm = [" +sForm+ "].")
												EndIf
												If ((iSetL == 1) && iSUmUtil.JsonStringSet(sJson = sSetJ, sKey = sSetL, idx = i, sVal = sForm, sType = ".formList"))
													iRet += 1
												ElseIf ((iSetL > 1) && JsonUtil.StringListSet(sSetJ, sSetL, i, sForm))
													iRet += 1
												EndIf
											i += 1
										EndWhile
								Else
									iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "sSetL = [" +sSetL+ "]; sMod = [" +sMod+ "]!")
								EndIf
							Else
								iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "List [" +sGetL+ "] is empty!")
							EndIf	
						iGetL += 1
					EndWhile
					If (iSave && iRet)
						SaveJson(sJson = sSetJ)
					EndIf
		Else
			iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "No lists!", 1)
		EndIf
	iDDeUtil.Log("iDDeMisc.DDsBuildForms():-> ", "Proccesing DDs... Done! Processed [" +iRet+ "] devices.", 3, 1)
	JsonUtil.SetIntValue(sSetJ, (sFunc+ "Status"), 0)
	RETURN iRet
EndFunction

Function SaveJson(STRING sName = "", STRING sJson = "")
	JsonUtil.SetIntValue(sJson, "iVersion", iDDeUtil.GetVersion())
	JsonUtil.SetStringValue(sJson, "sVersion", iDDeUtil.GetVersionStr())
	JsonUtil.SetStringValue(sJson, "sSemanticVer", iDDeUtil.GetSemVerStr())
		If (sName)
			JsonUtil.SetStringValue(sJson, "Name", sName)
		EndIf
	JsonUtil.Save(sJson, False)
	iDDeUtil.Log("iDDeMisc.SaveJson():-> ", "Saved to [" +sJson+ "].")
EndFunction
;Properties
;ppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp
iDDeMain Property iDDe Auto
iDDeLibs Property iDDeLib Auto
iDDeFuncs Property iDDeFunc Auto
iDDeConfig Property iDDeMCM Auto
zadLibs Property ZadLib Auto