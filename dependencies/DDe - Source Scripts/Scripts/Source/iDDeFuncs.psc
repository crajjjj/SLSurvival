ScriptName iDDeFuncs Extends Quest 

Import Utility 
Import Game 

iDDeMain Property iDDe Auto
iDDeLibs Property iDDeLib Auto
iDDeMisc Property iDDeMis Auto
iDDeConfig Property iDDeMCM Auto

;Functions
;fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
INT[] Function iDDeGetRandomIdx(INT[] iDev)
	INT iMax = iDev.Length
	INT[] iRets = CreateIntArray(iMax, 0)
		If (iMax > 0)
			INT[] iIs = iSUmUtil.GetRandomIdx(idxs = iDev, sDiv = ",") 
			INT i = iIs[0]
				If ((i > -1) && (i < iMax))
					iRets[i] = iIs[1]
				EndIf
		EndIf
	RETURN iRets
EndFunction
Form Function iDDeGetFormIdx(Form[] akDevices, INT iPick = -1)
	INT iMax = (akDevices.Length - 1)
	INT idx = iDDeGetIdx(iMax = iMax, idx = iPick)
	Form akForm = None
		If (akDevices[idx])
			akForm = akDevices[idx]
		Else
			akDevices = PapyrusUtil.RemoveForm(akDevices, None)
			iMax = (akDevices.Length - 1)	
				If (iMax > -1)
					akForm = akDevices[iDDeGetIdx(iMax = iMax, idx = -1)]
				EndIf
		EndIf
		If (akForm && (akForm == iDDeLib.NullTokens[1]))
			akForm = None
		EndIf
	RETURN akForm
EndFunction 
INT Function iDDeGetIdx(INT iMax = 0, INT idx = 0)
	If ((idx < 0) || (idx > iMax))
		RETURN RandomInt(0, iMax)
	Else
		RETURN idx
	EndIf
EndFunction	 	

;Outfit Manipulation  
;uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu
INT Function MakeOutfit(Actor aSlave = None, STRING sList = "iDDeNoName", STRING sOutfit = "iDDeOutMCM", STRING sOpt = "")
	iDDeUtil.Log("iDDeFuncs.MakeOutfit():-> ", "Start!")
	INT iRet = 0
		If (iDDeGetOutfit(aSlave, sOutfit, sOpt))
			DDeOutfit = PapyrusUtil.RemoveForm(DDeOutfit, None)
			StorageUtil.FormListCopy(aSlave, sList, DDeOutfit)		
		Else
			iDDeUtil.Log("iDDeFuncs.MakeOutfit():-> ", "Could not make a new outfit!")
		EndIf
	iRet = StorageUtil.FormListCount(aSlave, sList)
	iDDeUtil.Log("iDDeFuncs.MakeOutfit():-> ", "Done! Returned -> [" +iRet+ "]!")
	RETURN iRet
EndFunction
INT Function iDDeGetOutfit(Actor aSlave = None, STRING sOutfit = "iDDeOutMCM", STRING sOpt = "") 
	STRING sSlave = ("[" +iDDe.iDDeGetName(aSlave, "Global")+ "]")
	iDDeUtil.Log("iDDeFuncs.iDDeGetOutfit(): ", "Start for " +sSlave+ ".")
	iDDeUtil.Log("iDDeFuncs.iDDeGetOutfit(): ", "Outfit = [" +sOutfit+ "]; sOpt = [" +sOpt+ "].")
	INT iRet = 0
	GetDDsOpts(aSlave = aSlave, sOpt = sOpt)
	ResetLocalDevs(sOpt = sOpt)
		If (sOutfit == iDDeLib.sDDeOutMisc[4]) ;"iDDeAny"
			INT iCDxMax = iDDeLib.sCDxOut.Length
			INT[] iRndIdx = NEW INT[4]
				iRndIdx[0] = iDDeLib.sDDeOutMisc.Length
				iRndIdx[1] = iDDeLib.sDDeOutReg.Length
				iRndIdx[2] = iDDeLib.sDDeOutDr.Length
					If (iCDxMax > 3) 
						iRndIdx[3] = (iCDxMax - 1)
					Else
						iRndIdx[3] = iCDxMax
					EndIf
						iRndIdx = iDDeGetRandomIdx(iRndIdx)
							If (iRndIdx[0])
								iRet = iDDeSetOutMisc(aSlave, iRndIdx[0])
							ElseIf (iRndIdx[1])
								iRet = iDDeSetOutReg(aSlave, iRndIdx[1])
							ElseIf (iRndIdx[2])
								iRet = iDDeSetOutDr(aSlave, iRndIdx[2])
							ElseIf (iRndIdx[3])
								If (iRndIdx[3] == 2)
									iRndIdx[3] = 1
								EndIf
								iRet = iDDeSetOutCDx(aSlave, iRndIdx[3])
							Else
								iDDeUtil.Log("iDDeFuncs.iDDeGetOutfit(): ", "Could not decide on an outfit for " +sSlave+ ".")
							EndIf
							If (!iRet)
								sOutfit = iDDeLib.sDDeOutMisc[5] ;"iDDeAnyDr"
							EndIf
		EndIf
		If (!iRet)
			iRet = 1
				If (sOutfit == iDDeLib.sDDeOutMisc[5])
					INT iMax = (iDDeLib.sDDeOutDr.Length - 1)
					iRet = iDDeSetOutDr(aSlave, RandomInt(1, iMax))
				ElseIf (iDDeSetOutMisc(aSlave, (iDDeLib.sDDeOutMisc).Find(sOutfit))) 
				ElseIf (iDDeSetOutReg(aSlave, (iDDeLib.sDDeOutReg).Find(sOutfit)))
				ElseIf (iDDeSetOutDr(aSlave, (iDDeLib.sDDeOutDr).Find(sOutfit))) 
				ElseIf (iDDe.bCD && iDDeSetOutCDx(aSlave, (iDDeLib.sCDxOut).Find(sOutfit))) 
				ElseIf (iDDeMkCuOutfit(sOutfit))
					iDDe.SetStoUtilCurOutfit(aSlave = aSlave, sOutfit = sOutfit, iSet = 1)
				Else
					iDDeUtil.Log("iDDeFuncs.iDDeGetOutfit(): ", "Could not find an outfit for " +sSlave+ ".")
					iRet = 0
				EndIf
		EndIf
	sOutfit = iDDe.GetStoUtilCurOutfit(aSlave = aSlave, sOutfit = sOutfit) 
	iDDeUtil.Log("iDDeFuncs.iDDeGetOutfit(): ", "Done! For " +sSlave+ ", returned -> [" +sOutfit+ "]. Index = [" +iRet+ "].")
	RETURN iRet
EndFunction
INT Function GetDDsOpts(Actor aSlave = None, STRING sOpt = "")
	INT i = 0
	INT[] iOpts = NEW INT[17]
		iOpts[0] = -1 ;Suits
		iOpts[1] = -1 ;Gags
		iOpts[2] = -1 ;Hoods
		iOpts[3] = -1 ;ArmBinders
		iOpts[4] = -1 ;Blindfolds
		iOpts[5] = -1 ;Collars
		iOpts[6] = -1 ;Gloves
		iOpts[7] = -1 ;Boots
		iOpts[8] = -1 ;Belts
		iOpts[9] = -1 ;Harness
		iOpts[10] = -1 ;PlugsA
		iOpts[11] = -1 ;PlugsV
		iOpts[12] = -1 ;PieV
		iOpts[13] = -1 ;PieN
		iOpts[14] = -1 ;CuffsA
		iOpts[15] = -1 ;CuffsL
		iOpts[16] = -1 ;Bra
			If (sOpt)
				;Something
					If (StringUtil.Find(sOpt, "iDDeAnklesEffBypass") > -1)
						StorageUtil.SetIntValue(aSlave, "iDDeAnklesEffBypass", 1)
						sOpt = iSUmUtil.StrPluck(sStr = sOpt, sPluck = "iDDeAnklesEffBypass,", sRepl = "", iMany = 1, idx = 0)
					EndIf
				STRING[] sOpts = PapyrusUtil.StringSplit(sOpt, ",") 
				INT iMax = sOpts.Length
				iDDeUtil.Log("iDDeFuncs.GetDDsOpts(): ", "sOpts[" +iMax+ "] = [" +sOpts+ "].")
					If (iMax)
						INT j = -1
							iPickSuit = CreateIntArray((iDDeMCM.iPickSuit).Length, 0)
							iPickGag = CreateIntArray((iDDeMCM.iPickGag).Length, 0)
							iPickHood = CreateIntArray((iDDeMCM.iPickHood).Length, 0)
							iPickBinder = CreateIntArray((iDDeMCM.iPickBinder).Length, 0)
							iPickBlinder = CreateIntArray((iDDeMCM.iPickBlinder).Length, 0)
							iPickCollar = CreateIntArray((iDDeMCM.iPickCollar).Length, 0)
							iPickGloves = CreateIntArray((iDDeMCM.iPickGloves).Length, 0)
							iPickBoots = CreateIntArray((iDDeMCM.iPickBoots).Length, 0)
							iPickBelt = CreateIntArray((iDDeMCM.iPickBelt).Length, 0)
							iPickHarn = CreateIntArray((iDDeMCM.iPickHarn).Length, 0)
							iPickPlugA = CreateIntArray((iDDeMCM.iPickPlugA).Length, 0)
							iPickPlugV = CreateIntArray((iDDeMCM.iPickPlugV).Length, 0)
							iPickPieV = CreateIntArray((iDDeMCM.iPickPieV).Length, 0)
							iPickPieN = CreateIntArray((iDDeMCM.iPickPieN).Length, 0)
							iPickCuffsA = CreateIntArray((iDDeMCM.iPickCuffsA).Length, 0)
							iPickCuffsL = CreateIntArray((iDDeMCM.iPickCuffsL).Length, 0)
							iPickBra = CreateIntArray((iDDeMCM.iPickBra).Length, 0)
							i = 0
								While (i < iMax)
									j = -1
										If ((j < 0) && (iOpts[0] < 0))
											iOpts[0] = (iDDeMCM.sPickSuit).Find(sOpts[i])
											j = iOpts[0] 
										EndIf
										If ((j < 0) && (iOpts[1] < 0))
											iOpts[1] = (iDDeMCM.sPickGag).Find(sOpts[i])
											j = iOpts[1] 
										EndIf
										If ((j < 0) && (iOpts[2] < 0))
											iOpts[2] = (iDDeMCM.sPickHood).Find(sOpts[i])
											j = iOpts[2] 
										EndIf
										If ((j < 0) && (iOpts[3] < 0))
											iOpts[3] = (iDDeMCM.sPickBinder).Find(sOpts[i])
											j = iOpts[3] 
										EndIf
										If ((j < 0) && (iOpts[4] < 0))
											iOpts[4] = (iDDeMCM.sPickBlinder).Find(sOpts[i])
											j = iOpts[4] 
										EndIf
										If ((j < 0) && (iOpts[5] < 0))
											iOpts[5] = (iDDeMCM.sPickCollar).Find(sOpts[i])
											j = iOpts[5] 
										EndIf
										If ((j < 0) && (iOpts[6] < 0))
											iOpts[6] = (iDDeMCM.sPickGloves).Find(sOpts[i])
											j = iOpts[6] 
										EndIf
										If ((j < 0) && (iOpts[7] < 0))
											iOpts[7] = (iDDeMCM.sPickBoots).Find(sOpts[i])
											j = iOpts[7] 
										EndIf
										If ((j < 0) && (iOpts[8] < 0))
											iOpts[8] = (iDDeMCM.sPickBelt).Find(sOpts[i])
											j = iOpts[8] 
										EndIf
										If ((j < 0) && (iOpts[9] < 0))
											iOpts[9] = (iDDeMCM.sPickHarn).Find(sOpts[i])
											j = iOpts[9] 
										EndIf
										If ((j < 0) && (iOpts[10] < 0))
											iOpts[10] = (iDDeMCM.sPickPlugA).Find(sOpts[i])
											j = iOpts[10] 
										EndIf
										If ((j < 0) && (iOpts[11] < 0))
											iOpts[11] = (iDDeMCM.sPickPlugV).Find(sOpts[i])
											j = iOpts[11] 
										EndIf
										If ((j < 0) && (iOpts[12] < 0))
											iOpts[12] = (iDDeMCM.sPickPieV).Find(sOpts[i])
											j = iOpts[12] 
										EndIf
										If ((j < 0) && (iOpts[13] < 0))
											iOpts[13] = (iDDeMCM.sPickPieN).Find(sOpts[i])
											j = iOpts[13] 
										EndIf
										If ((j < 0) && (iOpts[14] < 0))
											iOpts[14] = (iDDeMCM.sPickCuffsA).Find(sOpts[i])
											j = iOpts[14] 
										EndIf
										If ((j < 0) && (iOpts[15] < 0))
											iOpts[15] = (iDDeMCM.sPickCuffsL).Find(sOpts[i])
											j = iOpts[15] 
										EndIf
										If ((j < 0) && (iOpts[16] < 0))
											iOpts[16] = (iDDeMCM.sPickBra).Find(sOpts[i])
											j = iOpts[16] 
										EndIf
									i += 1
								EndWhile
					EndIf
			EndIf
			If (iOpts[0] > -1)
				i = iOpts[0]
				iPickSuit[i] = 1
			Else
				iPickSuit = iDDeMCM.iPickSuit
			EndIf
			If (iOpts[1] > -1)
				i = iOpts[1]
				iPickGag[i] = 1
			Else
				iPickGag = iDDeMCM.iPickGag
			EndIf
			If (iOpts[2] > -1)
				i = iOpts[2]
				iPickHood[i] = 1
			Else
				iPickGag = iDDeMCM.iPickGag
			EndIf
			If (iOpts[3] > -1)
				i = iOpts[3]
				iPickBinder[i] = 1
			Else
				iPickBinder = iDDeMCM.iPickBinder
			EndIf
			If (iOpts[4] > -1)
				i = iOpts[4]
				iPickBlinder[i] = 1
			Else
				iPickBlinder = iDDeMCM.iPickBlinder
			EndIf
			If (iOpts[5] > -1)
				i = iOpts[5]
				iPickCollar[i] = 1
			Else
				iPickCollar = iDDeMCM.iPickCollar
			EndIf
			If (iOpts[6] > -1)
				i = iOpts[6]
				iPickGloves[i] = 1
			Else
				iPickGloves = iDDeMCM.iPickGloves
			EndIf
			If (iOpts[7] > -1)
				i = iOpts[7]
				iPickBoots[i] = 1
			Else
				iPickBoots = iDDeMCM.iPickBoots
			EndIf
			If (iOpts[8] > -1)
				i = iOpts[8]
				iPickBelt[i] = 1
			Else
				iPickBelt = iDDeMCM.iPickBelt
			EndIf
			If (iOpts[9] > -1)
				i = iOpts[9]
				iPickHarn[i] = 1
			Else
				iPickHarn = iDDeMCM.iPickHarn
			EndIf
			If (iOpts[10] > -1)
				i = iOpts[10]
				iPickPlugA[i] = 1
			Else
				iPickPlugA = iDDeMCM.iPickPlugA
			EndIf
			If (iOpts[11] > -1)
				i = iOpts[11]
				iPickPlugV[i] = 1
			Else
				iPickPlugV = iDDeMCM.iPickPlugV
			EndIf
			If (iOpts[12] > -1)
				i = iOpts[12]
				iPickPieV[i] = 1
			Else
				iPickPieV = iDDeMCM.iPickPieV
			EndIf
			If (iOpts[13] > -1)
				i = iOpts[13]
				iPickPieN[i] = 1
			Else
				iPickPieN = iDDeMCM.iPickPieN
			EndIf
			If (iOpts[14] > -1)
				i = iOpts[14]
				iPickCuffsA[i] = 1
			Else
				iPickCuffsA = iDDeMCM.iPickCuffsA
			EndIf
			If (iOpts[15] > -1)
				i = iOpts[15]
				iPickCuffsL[i] = 1
			Else
				iPickCuffsL = iDDeMCM.iPickCuffsL
			EndIf
			If (iOpts[16] > -1)
				i = iOpts[16]
				iPickBra[i] = 1
			Else
				iPickBra = iDDeMCM.iPickBra
			EndIf
	RETURN i
EndFunction 
INT Function iDDeSetOutMisc(Actor aSlave = None, INT idx = 0)
		If (idx < 1)
			idx = 0
		ElseIf (idx == 1)
			iDDeMkMCMOutfit()
		ElseIf (idx == 2)
			iDDeMkRndDDsOutfit()	
		ElseIf (idx == 3)
			If (!iDDe.SetStoUtilCurOutfit(aSlave = aSlave, sOutfit = iDDeMkCuRndOutfit(), iSet = 1))
				iDDeMkInDrOutfit()
			EndIf	
			RETURN idx
		Else
			idx = 0
		EndIf
		If (idx != 1)
			iDDe.SetStoUtilCurOutfit(aSlave = aSlave, sOutfit = iDDeLib.sDDeOutMisc[idx], iSet = 1)
		EndIf
	RETURN idx
EndFunction		
INT Function iDDeSetOutReg(Actor aSlave = None, INT idx = 0)
		If (idx < 1)
			idx = 0
		ElseIf (idx == 1)
			iDDeMkEbBkOutfit()
		ElseIf (idx == 2)
			iDDeMkEbWhOutfit()
		ElseIf (idx == 3)
			iDDeMkEbRdOutfit()
		ElseIf (idx == 4)
			iDDeMkLeBkOutfit()
		ElseIf (idx == 5)
			iDDeMkLeWhOutfit()
		ElseIf (idx == 6)
			iDDeMkLeRdOutfit()
		ElseIf (idx == 7)
			iDDeMkMtOutfit()
		ElseIf (idx == 8)
			iDDeMkFalmerOutfit()
		ElseIf (idx == 9)
			iDDeMkWoOutfit()
		ElseIf (idx == 10)
			iDDeMkIrOutfit()	
		ElseIf (idx == 11)
			iDDeMkGoOutfit()
		ElseIf (idx == 12)
			iDDeMkGoZbfOutfit()
		ElseIf (idx == 13)
			iDDeMkInOutfit()
		ElseIf (idx == 14)
			iDDeMkInZbfOutfit()
		ElseIf (idx == 15)
			iDDeMkLtWoOutfit()
		ElseIf (idx == 16)
			iDDeMkRustyOutfit()
		ElseIf (idx == 17)
			iDDeMkHexChOutfit()
		ElseIf (idx == 18)
			iDDeMkHexRdOutfit()
		ElseIf (idx == 19)
			iDDeMkHypOutfit()
		ElseIf (idx == 20)
			iDDeMkJadeOutfit()
		ElseIf (idx == 21)
			iDDeMkJadeZbfOutfit()
		ElseIf (idx == 22)
			iDDeMkFifaOutfit()
		ElseIf (idx == 23)
			iDDeMkFifaZbfOutfit()
		ElseIf (idx == 24)
			iDDeMkFireOutfit()
		ElseIf (idx == 25)
			iDDeMkFireZbfOutfit()
		ElseIf (idx == 26)
			iDDeMkRopeOutfit()
		ElseIf (idx == 27)
			iDDeMkLeBrOutfit()	
		ElseIf (idx == 28)
			iDDeMkCrimsonOutfit()
		ElseIf (idx == 29)
			iDDeMkCrimsonZbfOutfit()
		ElseIf (idx == 30)
			iDDeMkHexOrOutfit()
		ElseIf (idx == 31)
			iDDeMkBumbeeOutfit()
		ElseIf (idx == 32)
			iDDeMkBumbeeZbfOutfit()
		ElseIf (idx == 33)
			iDDeMkHrBkOutfit()
		ElseIf (idx == 34)
			iDDeMkHrRuOutfit()
		ElseIf (idx == 35)
			iDDeMkInMechOutfit()	
		ElseIf (idx == 36)
			iDDeMkDweMechOutfit()
		Else
			idx = 0
		EndIf
	iDDe.SetStoUtilCurOutfit(aSlave = aSlave, sOutfit = iDDeLib.sDDeOutReg[idx], iSet = 1)
	RETURN idx
EndFunction	
INT Function iDDeSetOutDr(Actor aSlave = None, INT idx = 0)
		If (idx < 1)
			idx = 0
		ElseIf (idx == 1)
			iDDeMkHexOrDrOutfit()
		ElseIf (idx == 2)
			iDDeMkGoDrOutfit()
		ElseIf (idx == 3)
			iDDeMkInDrOutfit()
		ElseIf (idx == 4)
			iDDeMkCrimsonDrOutfit()
		ElseIf (idx == 5)
			iDDeMkBumbeeDrOutfit()
		ElseIf (idx == 6)
			iDDeMkHexRdDrOutfit()
		ElseIf (idx == 7)
			iDDeMkJadeDrOutfit()
		ElseIf (idx == 8)
			iDDeMkEbBkDrOutfit()
		ElseIf (idx == 9)
			iDDeMkEbRdDrOutfit()
		ElseIf (idx == 10)
			iDDeMkEbWhDrOutfit()
		ElseIf (idx == 11)
			iDDeMkLeBkDrOutfit()
		ElseIf (idx == 12)
			iDDeMkLeRdDrOutfit()
		ElseIf (idx == 13)
			iDDeMkLeWhDrOutfit()
		ElseIf (idx == 14)
			iDDeMkLeBrDrOutfit()
		ElseIf (idx == 15)
			iDDeMkWoDrOutfit()
		ElseIf (idx == 16)
			iDDeMkRustyDrOutfit()
		ElseIf (idx == 17)
			iDDeMkHypDrOutfit()
		ElseIf (idx == 18)
			iDDeMkFifaDrOutfit()
		ElseIf (idx == 19)
			iDDeMkRopeDrOutfit()
		ElseIf (idx == 20)
			iDDeMkFalmerDrOutfit()
		ElseIf (idx == 21)
			iDDeMkFireDrOutfit()
		ElseIf (idx == 22)	
			iDDeMkLtWoDrOutfit()
		Else
			idx = 0
		EndIf
	iDDe.SetStoUtilCurOutfit(aSlave = aSlave, sOutfit = iDDeLib.sDDeOutDr[idx], iSet = 1)
	RETURN idx
EndFunction	
INT Function iDDeSetOutCDx(Actor aSlave = None, INT idx = 0)
		If (idx < 1)
			idx = 0
		ElseIf (idx == 1)
			iDDeMkCDxSvOutfit()
		ElseIf (idx == 2)
			iDDeMkCDxOutfit()
		ElseIf (idx == 3)
			iDDeMkCDxBrOutfit()
		ElseIf (idx == 4)
			iDDeMkCDxBkOutfit()
		ElseIf (idx == 5)
			iDDeMkCDxRdOutfit()
		ElseIf (idx == 6)
			iDDeMkCDxWhOutfit()
		ElseIf (idx == 7)
			iDDeMkCDxCursedOutfit()	
		Else
			idx = 0
		EndIf
	iDDe.SetStoUtilCurOutfit(aSlave = aSlave, sOutfit = iDDeLib.sCDxOut[idx], iSet = 1)
	RETURN idx
EndFunction	
INT Function ResetLocalDevs(STRING sOpt = "")
	_akBinds = NEW Form[1]
  _akGags = NEW Form[1]
  _akHoods = NEW Form[1]
  _akBlinders = NEW Form[1]
  _akCollars = NEW Form[1]
  _akGloves = NEW Form[1]
  _akBoots = NEW Form[1]
  _akBelts = NEW Form[1]
  _akHarns = NEW Form[1]
  _akPlugsA = NEW Form[1]
  _akPlugsV = NEW Form[1]
  _akPieV = NEW Form[1]
  _akPieN = NEW Form[1]
  _akCuffsA = NEW Form[1]
  _akCuffsL = NEW Form[1]
  _akBras = NEW Form[1]
  _akSuits = NEW Form[1]
  _sDevOpt = sOpt
	RETURN 1
EndFunction

;Outfits 
;ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo 
Function SetLocalOutfit(INT iMech = 0)
	DDeOutfit = NEW Form[18]
   DDeOutfit[0] = iDDeLib.DDeMech[iMech] 
   DDeOutfit[1] = iDDeGetFormIdx(_akPlugsA)
   DDeOutfit[2] = iDDeGetFormIdx(_akPlugsV)
   DDeOutfit[3] = iDDeGetFormIdx(_akPieV)
   DDeOutfit[4] = iDDeGetFormIdx(_akBelts)
   DDeOutfit[5] = iDDeGetFormIdx(_akPieN)
   DDeOutfit[6] = iDDeGetFormIdx(_akCuffsA) 
   DDeOutfit[7] = iDDeGetFormIdx(_akCuffsL)
   DDeOutfit[8] = iDDeGetFormIdx(_akGags)  
   DDeOutfit[9] = iDDeGetFormIdx(_akCollars)
   DDeOutfit[10] = iDDeGetFormIdx(_akBlinders)		
   DDeOutfit[11] = iDDeGetFormIdx(_akBras) 
   DDeOutfit[12] = iDDeGetFormIdx(_akHarns) 
   DDeOutfit[13] = iDDeGetFormIdx(_akBoots) 
   DDeOutfit[14] = iDDeGetFormIdx(_akGloves)
   DDeOutfit[15] = iDDeGetFormIdx(_akSuits)	
   DDeOutfit[16] = iDDeGetFormIdx(_akHoods) 
   DDeOutfit[17] = iDDeGetFormIdx(_akBinds)
		;Hood, IronMask Conflict
			If (DDeOutfit[16]) ;Hood
				DDeOutfit[8] = None ;Gag
					If (DDeOutfit[16] == _akHoods[2])
						DDeOutfit[9] = None ;Collar
						DDeOutfit[10] = None ;Blindfold
					EndIf
			EndIf	
		;Pet Suit and Dress Conflict	
			If (DDeOutfit[17] && (DDeOutfit[17] == _akBinds[1]) && DDeOutfit[15] && (DDeOutfit[15] != _akSuits[6]))
				DDeOutfit[15] = None
			EndIf 
		;Cat gloves gap conflict
			;If (DDeOutfit[15] && (DDeOutfit[15] != _akSuits[6]) && DDeOutfit[14] && (DDeOutfit[14] == _akGloves[2]))
			;	_akGloves[2] = None
			;	DDeOutfit[14] = iDDeGetFormIdx(_akGloves)
			;EndIf
		;Boxbinder conflicts
			If (DDeOutfit[17] && ((DDeOutfit[17] == _akBinds[6]) || (DDeOutfit[17] == _akBinds[7]))) 
				If (!DDeOutfit[0])
					DDeOutfit[0] = DDeOutfit[17]
					DDeOutfit[17] = None
				EndIf
				If (DDeOutfit[15]) ;Suit
					DDeOutfit[15] = None
				EndIf
			EndIf
		;Collar & harness conflict
		;	If (DDeOutfit[12] && DDeOutfit[9]) 
		;		DDeOutfit[9] = None
		;	EndIf	
		;Lock Gloves
			If (_sDevOpt && !DDeOutfit[17] && DDeOutfit[14] && (StringUtil.Find(_sDevOpt, "bLockGloves", 0) > -1))
				DDeOutfit[17] = iDDeLib.iDDe_InvShacklesArms_Inv
			EndIf			
EndFunction 
Function iDDeMkMCMOutfit() 
	DDeOutfit = NEW Form[55]
		If (!iDDeLib.DDeMech[iDDe.iDDeMech]) ;No Mech Suit
			DDeOutfit[0] = iDDeLib.DDeBoxBinders[iDDe.iDDeBoxBinder] 
			DDeOutfit[1] = iDDeLib.DDxBoxBinders[iDDe.iDDxBoxBinder]
			DDeOutfit[2] = iDDeLib.DDeBoxBinderOuts[iDDe.iDDeBoxBinderOut] 
			DDeOutfit[3] = iDDeLib.DDxBoxBinderOuts[iDDe.iDDxBoxBinderOut]
			DDeOutfit[4] = iDDeLib.DDePlugsA[iDDe.iDDePlugA]
			DDeOutfit[5] = iDDeLib.DDxPlugsA[iDDe.iDDxPlugA]
			DDeOutfit[6] = iDDeLib.CDxPlugsA[iDDe.iCDxPlugA]
			DDeOutfit[7] = iDDeLib.DDePlugsV[iDDe.iDDePlugV]
			DDeOutfit[8] = iDDeLib.DDxPlugsV[iDDe.iDDxPlugV]
			DDeOutfit[9] = iDDeLib.CDxPlugsV[iDDe.iCDxPlugV]
			DDeOutfit[10] = iDDeLib.DDeCuffsA[iDDe.iDDeCuffsA] 
			DDeOutfit[11] = iDDeLib.DDxCuffsA[iDDe.iDDxCuffsA]
			DDeOutfit[12] = iDDeLib.CDxCuffsA[iDDe.iCDxCuffsA]
			DDeOutfit[13] = iDDeLib.DDeCuffsL[iDDe.iDDeCuffsL]
			DDeOutfit[14] = iDDeLib.DDxCuffsL[iDDe.iDDxCuffsL]
			DDeOutfit[15] = iDDeLib.CDxCuffsL[iDDe.iCDxCuffsL]
			DDeOutfit[16] = iDDeLib.DDeBras[iDDe.iDDeBra] 
			DDeOutfit[17] = iDDeLib.DDxBras[iDDe.iDDxBra] 
			DDeOutfit[18] = iDDeLib.CDxBras[iDDe.iCDxBra]
			DDeOutfit[19] = iDDeLib.DDeHoods[iDDe.iDDeHood]
			DDeOutfit[20] = iDDeLib.DDxHoods[iDDe.iDDxHood]
			DDeOutfit[21] = iDDeLib.DDePetSuits[iDDe.iDDePetSuit] 
			DDeOutfit[22] = iDDeLib.DDxPetSuits[iDDe.iDDxPetSuit]	
			DDeOutfit[23] = iDDeLib.DDeBoots[iDDe.iDDeBoots]	
			DDeOutfit[24] = iDDeLib.DDxBoots[iDDe.iDDxBoots]	
			DDeOutfit[25] = iDDeLib.DDeGloves[iDDe.iDDeGloves]
			DDeOutfit[26] = iDDeLib.DDxGloves[iDDe.iDDxGloves]
			DDeOutfit[27] = iDDeLib.DDeSuits[iDDe.iDDeSuit]
			DDeOutfit[28] = iDDeLib.DDxSuits[iDDe.iDDxSuit]
			DDeOutfit[29] = iDDeLib.DDeCatSuits[iDDe.iDDeCatSuit]
			DDeOutfit[30] = iDDeLib.DDxCatSuits[iDDe.iDDxCatSuit]	
			DDeOutfit[31] = iDDeLib.DDeArmBinders[iDDe.iDDeArmBinder] 
			DDeOutfit[32] = iDDeLib.DDxArmBinders[iDDe.iDDxArmBinder]
			DDeOutfit[33] = iDDeLib.DDeElbowBinders[iDDe.iDDeElbowBinder] 
			DDeOutfit[34] = iDDeLib.DDxElbowBinders[iDDe.iDDxElbowBinder]
		EndIf
			DDeOutfit[35] = iDDeLib.DDeMech[iDDe.iDDeMech]
			DDeOutfit[36] = iDDeLib.DDxPieV[iDDe.iDDxPieV]
			DDeOutfit[37] = iDDeLib.DDxPieN[iDDe.iDDxPieN] 	
			DDeOutfit[38] = iDDeLib.DDeBelts[iDDe.iDDeBelt]
			DDeOutfit[39] = iDDeLib.DDxBelts[iDDe.iDDxBelt]
			DDeOutfit[40] = iDDeLib.CDxBelts[iDDe.iCDxBelt]
			DDeOutfit[41] = iDDeLib.DDeGags[iDDe.iDDeGag]
			DDeOutfit[42] = iDDeLib.DDxGags[iDDe.iDDxGag] 
			DDeOutfit[43] = iDDeLib.DDeCollars[iDDe.iDDeCollar]
			DDeOutfit[44] = iDDeLib.DDxCollars[iDDe.iDDxCollar]
			DDeOutfit[45] = iDDeLib.CDxCollars[iDDe.iCDxCollar]
			DDeOutfit[46] = iDDeLib.DDeBlindFolds[iDDe.iDDeBlind]
			DDeOutfit[47] = iDDeLib.DDxBlindFolds[iDDe.iDDxBlind]
			DDeOutfit[48] = iDDeLib.DDeYokes[iDDe.iDDeYoke] 
			DDeOutfit[49] = iDDeLib.DDxYokes[iDDe.iDDxYoke]
			DDeOutfit[50] = iDDeLib.DDeShackles[iDDe.iDDeShackles] 
			DDeOutfit[51] = iDDeLib.DDxShackles[iDDe.iDDxShackles]
			DDeOutfit[52] = iDDeLib.DDeHarness[iDDe.iDDeHarness]
			DDeOutfit[53] = iDDeLib.DDxHarness[iDDe.iDDxHarness]
			DDeOutfit[54] = iDDeLib.DDxCorsets[iDDe.iDDxCorset]	
EndFunction
Function iDDeMkEbBkOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDxPetSuits[(iPickBinder[1] * 4)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDxElbowBinders[(iPickBinder[2] * 4)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDxArmBinders[(iPickBinder[3] * 2)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDxYokes[(iPickBinder[4] * 2)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 3)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDxBoxBinders[(iPickBinder[6] * 1)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDxBoxBinderOuts[(iPickBinder[7] * 1)] ;Boxbinder Outfit Binds
			  
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 8)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 6)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 9)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 7)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 10)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 60)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDxHoods[(iPickHood[1] * 3)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 8)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDxBlindFolds[(iPickBlinder[1] * 2)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDxCollars[(iPickCollar[1] * 37)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDxCollars[(iPickCollar[2] * 9)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDxCollars[(iPickCollar[3] * 22)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDxCollars[(iPickCollar[4] * 52)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDxCollars[(iPickCollar[5] * 7)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDxCollars[(iPickCollar[6] * 55)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDxCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 2)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 12)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 25)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 4)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 2)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 39)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 43)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDxBelts[(iPickBelt[1] * 12)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDxBelts[(iPickBelt[2] * 2)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 15)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDxHarness[(iPickHarn[1] * 3)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 2)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDxCuffsA[(iPickCuffsA[1] * 18)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDxCuffsA[(iPickCuffsA[2] * 3)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDxCuffsA[(iPickCuffsA[3] * 14)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDxCuffsL[(iPickCuffsL[1] * 20)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDxCuffsL[(iPickCuffsL[2] * 3)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDxCuffsL[(iPickCuffsL[3] * 16)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDxBras[(iPickBra[1] * 8)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 15)] ;Padded Bra        

	SetLocalOutfit(iMech = 0)	 
EndFunction
Function iDDeMkEbBkDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDxPetSuits[(iPickBinder[1] * 4)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDxElbowBinders[(iPickBinder[2] * 4)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDxArmBinders[(iPickBinder[3] * 2)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDxYokes[(iPickBinder[4] * 2)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 3)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDxBoxBinders[(iPickBinder[6] * 1)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDxBoxBinderOuts[(iPickBinder[7] * 1)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 8)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 6)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 9)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 7)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 10)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 60)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDxHoods[(iPickHood[1] * 3)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 8)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDxBlindFolds[(iPickBlinder[1] * 2)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDxCollars[(iPickCollar[1] * 37)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDxCollars[(iPickCollar[2] * 9)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDxCollars[(iPickCollar[3] * 22)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDxCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDxCollars[(iPickCollar[5] * 7)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDxCollars[(iPickCollar[6] * 8)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDxCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 2)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 15)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 12)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 25)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 4)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 2)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 10)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 43)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDxBelts[(iPickBelt[1] * 12)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDxBelts[(iPickBelt[2] * 2)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDxBelts[(iPickBelt[3] * 15)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDxHarness[(iPickHarn[1] * 3)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 2)] ;Corset Harness   
		
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA  
							
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDxCuffsA[(iPickCuffsA[1] * 18)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDxCuffsA[(iPickCuffsA[2] * 3)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDxCuffsA[(iPickCuffsA[3] * 14)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDxCuffsL[(iPickCuffsL[1] * 20)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDxCuffsL[(iPickCuffsL[2] * 3)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDxCuffsL[(iPickCuffsL[3] * 16)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDxBras[(iPickBra[1] * 8)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 15)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDxSuits[(iPickSuit[1] * 28)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDxSuits[(iPickSuit[2] * 7)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDxSuits[(iPickSuit[3] * 10)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDxSuits[(iPickSuit[4] * 19)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDxSuits[(iPickSuit[5] * 22)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDxCatSuits[(iPickSuit[6] * 1)] ;Cat Suit
						
	SetLocalOutfit(iMech = 0)		 
EndFunction
Function iDDeMkEbWhOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDxPetSuits[(iPickBinder[1] * 6)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDxElbowBinders[(iPickBinder[2] * 6)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDxArmBinders[(iPickBinder[3] * 3)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDxYokes[(iPickBinder[4] * 1)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 3)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDxBoxBinders[(iPickBinder[6] * 3)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDxBoxBinderOuts[(iPickBinder[7] * 3)] ;Boxbinder Outfit Binds
		  
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 13)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 11)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 14)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 12)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 15)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 61)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDxHoods[(iPickHood[1] * 15)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 9)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDxBlindFolds[(iPickBlinder[1] * 7)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDxCollars[(iPickCollar[1] * 48)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDxCollars[(iPickCollar[2] * 12)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDxCollars[(iPickCollar[3] * 23)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDxCollars[(iPickCollar[4] * 51)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDxCollars[(iPickCollar[5] * 10)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDxCollars[(iPickCollar[6] * 54)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDxCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 3)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 14)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 36)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 5)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 2)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 14)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 45)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDxBelts[(iPickBelt[1] * 11)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDxBelts[(iPickBelt[2] * 2)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDxBelts[(iPickBelt[3] * 14)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[22] * 5)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 3)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDxCuffsA[(iPickCuffsA[1] * 17)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDxCuffsA[(iPickCuffsA[2] * 4)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDxCuffsA[(iPickCuffsA[3] * 15)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDxCuffsL[(iPickCuffsL[1] * 19)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDxCuffsL[(iPickCuffsL[2] * 4)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDxCuffsL[(iPickCuffsL[3] * 17)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDxBras[(iPickBra[1] * 7)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 2)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0)
EndFunction 
Function iDDeMkEbWhDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDxPetSuits[(iPickBinder[1] * 6)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDxElbowBinders[(iPickBinder[2] * 6)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDxArmBinders[(iPickBinder[3] * 3)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDxYokes[(iPickBinder[4] * 1)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 3)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDxBoxBinders[(iPickBinder[6] * 3)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDxBoxBinderOuts[(iPickBinder[7] * 3)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 13)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 11)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 14)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 12)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 15)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 61)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDxHoods[(iPickHood[1] * 15)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 9)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDxBlindFolds[(iPickBlinder[1] * 7)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDxCollars[(iPickCollar[1] * 48)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDxCollars[(iPickCollar[2] * 12)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDxCollars[(iPickCollar[3] * 23)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDxCollars[(iPickCollar[4] * 51)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDxCollars[(iPickCollar[5] * 10)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDxCollars[(iPickCollar[6] * 54)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDxCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 3)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 26)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 14)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 36)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 5)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 2)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 14)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 45)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDxBelts[(iPickBelt[1] * 11)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDxBelts[(iPickBelt[2] * 2)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDxBelts[(iPickBelt[3] * 14)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[22] * 5)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 3)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDxCuffsA[(iPickCuffsA[1] * 17)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 4)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDxCuffsA[(iPickCuffsA[3] * 15)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDxCuffsL[(iPickCuffsL[1] * 19)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 4)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDxCuffsL[(iPickCuffsL[3] * 17)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDxBras[(iPickBra[1] * 7)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 2)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDxSuits[(iPickSuit[1] * 30)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDxSuits[(iPickSuit[2] * 9)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDxSuits[(iPickSuit[3] * 12)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDxSuits[(iPickSuit[4] * 21)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDxSuits[(iPickSuit[5] * 24)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDxCatSuits[(iPickSuit[6] * 13)] ;Cat Suit
									
	SetLocalOutfit(iMech = 0)			 				 
EndFunction
Function iDDeMkEbRdOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDxPetSuits[(iPickBinder[1] * 5)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDxElbowBinders[(iPickBinder[2] * 5)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDxArmBinders[(iPickBinder[3] * 5)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDxYokes[(iPickBinder[4] * 1)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 3)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDxBoxBinders[(iPickBinder[6] * 2)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDxBoxBinderOuts[(iPickBinder[7] * 2)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 23)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 21)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 24)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 22)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 25)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 62)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDxHoods[(iPickHood[1] * 14)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 10)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDxBlindFolds[(iPickBlinder[1] * 13)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDxCollars[(iPickCollar[1] * 42)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDxCollars[(iPickCollar[2] * 18)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDxCollars[(iPickCollar[3] * 25)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDxCollars[(iPickCollar[4] * 50)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDxCollars[(iPickCollar[5] * 16)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDxCollars[(iPickCollar[6] * 53)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDxCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 5)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 13)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 30)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 7)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 2)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 13)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 44)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDxBelts[(iPickBelt[1] * 10)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDxBelts[(iPickBelt[2] * 2)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDxBelts[(iPickBelt[3] * 13)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDxHarness[(iPickHarn[1] * 9)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 5)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV    	
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDxCuffsA[(iPickCuffsA[1] * 16)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDxCuffsA[(iPickCuffsA[2] * 6)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDxCuffsA[(iPickCuffsA[3] * 13)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDxCuffsL[(iPickCuffsL[1] * 18)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDxCuffsL[(iPickCuffsL[2] * 6)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDxCuffsL[(iPickCuffsL[3] * 15)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDxBras[(iPickBra[1] * 6)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 3)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0) 
EndFunction
Function iDDeMkEbRdDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDxPetSuits[(iPickBinder[1] * 5)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDxElbowBinders[(iPickBinder[2] * 5)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDxArmBinders[(iPickBinder[3] * 5)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDxYokes[(iPickBinder[4] * 1)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 3)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDxBoxBinders[(iPickBinder[6] * 2)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDxBoxBinderOuts[(iPickBinder[7] * 2)] ;Boxbinder Outfit Binds 
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 23)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 21)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 24)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 22)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 25)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 62)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDxHoods[(iPickHood[1] * 14)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 10)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDxBlindFolds[(iPickBlinder[1] * 13)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDxCollars[(iPickCollar[1] * 42)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDxCollars[(iPickCollar[2] * 18)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDxCollars[(iPickCollar[3] * 25)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDxCollars[(iPickCollar[4] * 50)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDxCollars[(iPickCollar[5] * 16)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDxCollars[(iPickCollar[6] * 53)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDxCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 5)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 20)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 13)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 30)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 7)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 2)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 13)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 44)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDxBelts[(iPickBelt[1] * 10)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDxBelts[(iPickBelt[2] * 2)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDxBelts[(iPickBelt[3] * 13)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDxHarness[(iPickHarn[1] * 9)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 5)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDxCuffsA[(iPickCuffsA[1] * 16)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDxCuffsA[(iPickCuffsA[2] * 6)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDxCuffsA[(iPickCuffsA[3] * 13)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDxCuffsL[(iPickCuffsL[1] * 18)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDxCuffsL[(iPickCuffsL[2] * 6)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDxCuffsL[(iPickCuffsL[3] * 15)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDxBras[(iPickBra[1] * 6)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 3)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDxSuits[(iPickSuit[1] * 29)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDxSuits[(iPickSuit[2] * 8)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDxSuits[(iPickSuit[3] * 11)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDxSuits[(iPickSuit[4] * 20)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDxSuits[(iPickSuit[5] * 23)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDxCatSuits[(iPickSuit[6] * 6)] ;Cat Suit
			
	SetLocalOutfit(iMech = 0)			 			 
EndFunction
Function iDDeMkLeBkOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDxPetSuits[(iPickBinder[1] * 1)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDxElbowBinders[(iPickBinder[2] * 1)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDxArmBinders[(iPickBinder[3] * 1)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDxYokes[(iPickBinder[4] * 1)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 3)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDxBoxBinders[(iPickBinder[6] * 0)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDxBoxBinderOuts[(iPickBinder[7] * 0)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 5)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 1)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 2)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 3)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 4)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 57)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDxHoods[(iPickHood[1] * 2)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 3)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDxBlindFolds[(iPickBlinder[1] * 1)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDxCollars[(iPickCollar[1] * 37)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDxCollars[(iPickCollar[2] * 1)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDxCollars[(iPickCollar[3] * 4)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDxCollars[(iPickCollar[4] * 52)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDxCollars[(iPickCollar[5] * 6)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDxCollars[(iPickCollar[6] * 55)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDxCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 1)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 9)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 25)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 3)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 2)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 9)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDxBoots[(iPickBoots[6] * 21)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDxBelts[(iPickBelt[1] * 12)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDxBelts[(iPickBelt[2] * 2)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDxBelts[(iPickBelt[3] * 15)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDxHarness[(iPickHarn[1] * 1)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 1)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDxCuffsA[(iPickCuffsA[1] * 18)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDxCuffsA[(iPickCuffsA[2] * 2)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDxCuffsA[(iPickCuffsA[3] * 14)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDxCuffsL[(iPickCuffsL[1] * 20)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDxCuffsL[(iPickCuffsL[2] * 2)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDxCuffsL[(iPickCuffsL[3] * 16)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDxBras[(iPickBra[1] * 8)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 16)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0)						 
EndFunction
Function iDDeMkLeBkDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDxPetSuits[(iPickBinder[1] * 1)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDxElbowBinders[(iPickBinder[2] * 1)] ;Elbowbinder Binds 
	 _akBinds[3] = iDDeLib.DDxArmBinders[(iPickBinder[3] * 1)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDxYokes[(iPickBinder[4] * 1)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 3)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDxBoxBinders[(iPickBinder[6] * 0)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDxBoxBinderOuts[(iPickBinder[7] * 0)] ;Boxbinder Outfit Binds
	
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 5)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 1)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 2)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 3)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 4)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 57)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDxHoods[(iPickHood[1] * 2)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 3)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDxBlindFolds[(iPickBlinder[1] * 1)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDxCollars[(iPickCollar[1] * 37)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDxCollars[(iPickCollar[2] * 1)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDxCollars[(iPickCollar[3] * 4)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDxCollars[(iPickCollar[4] * 52)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDxCollars[(iPickCollar[5] * 6)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDxCollars[(iPickCollar[6] * 55)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDxCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 1)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 15)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 9)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 25)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 3)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 2)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 9)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDxBoots[(iPickBoots[6] * 21)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDxBelts[(iPickBelt[1] * 12)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDxBelts[(iPickBelt[2] * 2)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDxBelts[(iPickBelt[3] * 15)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDxHarness[(iPickHarn[1] * 1)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 1)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDxCuffsA[(iPickCuffsA[1] * 18)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 2)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDxCuffsA[(iPickCuffsA[3] * 14)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDxCuffsL[(iPickCuffsL[1] * 20)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 2)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDxCuffsL[(iPickCuffsL[3] * 16)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDxBras[(iPickBra[1] * 8)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 16)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDxSuits[(iPickSuit[1] * 25)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDxSuits[(iPickSuit[2] * 1)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDxSuits[(iPickSuit[3] * 4)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDxSuits[(iPickSuit[4] * 13)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDxSuits[(iPickSuit[5] * 16)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDxCatSuits[(iPickSuit[6] * 0)] ;Cat Suit
										
	SetLocalOutfit(iMech = 0)	 				 
EndFunction 
Function iDDeMkLeWhOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDxPetSuits[(iPickBinder[1] * 3)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDxElbowBinders[(iPickBinder[2] * 3)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDxArmBinders[(iPickBinder[3] * 4)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDxYokes[(iPickBinder[4] * 1)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 3)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDxBoxBinders[(iPickBinder[6] * 0)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDxBoxBinderOuts[(iPickBinder[7] * 0)] ;Boxbinder Outfit Binds
	
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 18)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 16)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 19)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 17)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 20)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 58)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDxHoods[(iPickHood[1] * 0)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 4)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDxBlindFolds[(iPickBlinder[1] * 10)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDxCollars[(iPickCollar[1] * 48)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDxCollars[(iPickCollar[2] * 15)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDxCollars[(iPickCollar[3] * 24)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDxCollars[(iPickCollar[4] * 51)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDxCollars[(iPickCollar[5] * 13)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDxCollars[(iPickCollar[6] * 54)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDxCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 4)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 11)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 36)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 6)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 2)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 12)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDxBoots[(iPickBoots[6] * 23)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDxBelts[(iPickBelt[1] * 11)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDxBelts[(iPickBelt[2] * 2)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDxBelts[(iPickBelt[3] * 14)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[25] * 7)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 4)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDxCuffsA[(iPickCuffsA[1] * 17)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDxCuffsA[(iPickCuffsA[2] * 5)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDxCuffsA[(iPickCuffsA[3] * 15)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDxCuffsL[(iPickCuffsL[1] * 19)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDxCuffsL[(iPickCuffsL[2] * 5)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDxCuffsL[(iPickCuffsL[3] * 17)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDxBras[(iPickBra[1] * 7)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 4)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0)					 			 
EndFunction
Function iDDeMkLeWhDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDxPetSuits[(iPickBinder[1] * 3)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDxElbowBinders[(iPickBinder[2] * 3)] ;Elbowbinder Binds 
	 _akBinds[3] = iDDeLib.DDxArmBinders[(iPickBinder[3] * 4)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDxYokes[(iPickBinder[4] * 1)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 3)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDxBoxBinders[(iPickBinder[6] * 0)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDxBoxBinderOuts[(iPickBinder[7] * 0)] ;Boxbinder Outfit Binds
	
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 18)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 16)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 19)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 17)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 20)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 58)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDxHoods[(iPickHood[1] * 0)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 4)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDxBlindFolds[(iPickBlinder[1] * 10)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDxCollars[(iPickCollar[1] * 48)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDxCollars[(iPickCollar[2] * 15)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDxCollars[(iPickCollar[3] * 24)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDxCollars[(iPickCollar[4] * 51)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDxCollars[(iPickCollar[5] * 13)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDxCollars[(iPickCollar[6] * 54)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDxCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 4)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 26)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 11)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 36)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 6)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 2)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 12)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDxBoots[(iPickBoots[6] * 23)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDxBelts[(iPickBelt[1] * 11)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDxBelts[(iPickBelt[2] * 2)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDxBelts[(iPickBelt[3] * 14)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[25] * 7)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 4)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDxCuffsA[(iPickCuffsA[1] * 17)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDxCuffsA[(iPickCuffsA[2] * 5)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDxCuffsA[(iPickCuffsA[3] * 15)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDxCuffsL[(iPickCuffsL[1] * 19)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDxCuffsL[(iPickCuffsL[2] * 5)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDxCuffsL[(iPickCuffsL[3] * 17)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDxBras[(iPickBra[1] * 7)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 4)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDxSuits[(iPickSuit[1] * 27)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDxSuits[(iPickSuit[2] * 3)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDxSuits[(iPickSuit[3] * 6)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDxSuits[(iPickSuit[4] * 15)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDxSuits[(iPickSuit[5] * 18)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDxCatSuits[(iPickSuit[6] * 0)] ;Cat Suit
					
	SetLocalOutfit(iMech = 0)	 			 
EndFunction
Function iDDeMkLeRdOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDxPetSuits[(iPickBinder[1] * 2)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDxElbowBinders[(iPickBinder[2] * 2)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDxArmBinders[(iPickBinder[3] * 6)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDxYokes[(iPickBinder[4] * 1)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 3)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDxBoxBinders[(iPickBinder[6] * 0)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDxBoxBinderOuts[(iPickBinder[7] * 0)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 28)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 26)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 29)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 27)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 30)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 59)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDxHoods[(iPickHood[1] * 0)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 5)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDxBlindFolds[(iPickBlinder[1] * 16)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDxCollars[(iPickCollar[1] * 42)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDxCollars[(iPickCollar[2] * 21)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDxCollars[(iPickCollar[3] * 26)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDxCollars[(iPickCollar[4] * 50)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDxCollars[(iPickCollar[5] * 19)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDxCollars[(iPickCollar[6] * 53)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDxCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 6)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 10)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 30)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 8)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 2)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 11)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDxBoots[(iPickBoots[6] * 22)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDxBelts[(iPickBelt[1] * 10)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDxBelts[(iPickBelt[2] * 2)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDxBelts[(iPickBelt[3] * 13)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDxHarness[(iPickHarn[1] * 11)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 6)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDxCuffsA[(iPickCuffsA[1] * 16)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDxCuffsA[(iPickCuffsA[2] * 7)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDxCuffsA[(iPickCuffsA[3] * 13)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDxCuffsL[(iPickCuffsL[1] * 18)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDxCuffsL[(iPickCuffsL[2] * 7)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDxCuffsL[(iPickCuffsL[3] * 15)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDxBras[(iPickBra[1] * 6)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 5)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0)						 				 
EndFunction
Function iDDeMkLeRdDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDxPetSuits[(iPickBinder[1] * 2)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDxElbowBinders[(iPickBinder[2] * 2)] ;Elbowbinder Binds 
	 _akBinds[3] = iDDeLib.DDxArmBinders[(iPickBinder[3] * 6)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDxYokes[(iPickBinder[4] * 1)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 3)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDxBoxBinders[(iPickBinder[6] * 0)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDxBoxBinderOuts[(iPickBinder[7] * 0)] ;Boxbinder Outfit Binds
	
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 28)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 26)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 29)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 27)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 30)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 59)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDxHoods[(iPickHood[1] * 0)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 5)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDxBlindFolds[(iPickBlinder[1] * 16)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDxCollars[(iPickCollar[1] * 42)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDxCollars[(iPickCollar[2] * 21)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDxCollars[(iPickCollar[3] * 26)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDxCollars[(iPickCollar[4] * 50)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDxCollars[(iPickCollar[5] * 19)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDxCollars[(iPickCollar[6] * 53)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDxCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 6)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 20)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 10)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 30)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 8)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 2)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 11)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDxBoots[(iPickBoots[6] * 22)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDxBelts[(iPickBelt[1] * 10)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDxBelts[(iPickBelt[2] * 2)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDxBelts[(iPickBelt[3] * 13)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDxHarness[(iPickHarn[1] * 11)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 6)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDxCuffsA[(iPickCuffsA[1] * 16)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDxCuffsA[(iPickCuffsA[2] * 7)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDxCuffsA[(iPickCuffsA[3] * 13)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDxCuffsL[(iPickCuffsL[1] * 15)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDxCuffsL[(iPickCuffsL[2] * 7)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDxCuffsL[(iPickCuffsL[3] * 15)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDxBras[(iPickBra[1] * 6)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 5)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDxSuits[(iPickSuit[1] * 26)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDxSuits[(iPickSuit[2] * 2)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDxSuits[(iPickSuit[3] * 5)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDxSuits[(iPickSuit[4] * 14)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDxSuits[(iPickSuit[5] * 17)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDxCatSuits[(iPickSuit[6] * 0)] ;Cat Suit
	
	SetLocalOutfit(iMech = 0)				 				 
EndFunction
Function iDDeMkMtOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDxPetSuits[(iPickBinder[1] * 1)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDxElbowBinders[(iPickBinder[2] * 1)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDxArmBinders[(iPickBinder[3] * 1)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDxYokes[(iPickBinder[4] * 1)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 3)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDxBoxBinders[(iPickBinder[6] * 1)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDxBoxBinderOuts[(iPickBinder[7] * 1)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 5)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 1)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 2)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 3)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 4)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 57)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDxHoods[(iPickHood[1] * 4)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 3)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDxBlindFolds[(iPickBlinder[1] * 1)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDxCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDxCollars[(iPickCollar[2] * 1)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDxCollars[(iPickCollar[3] * 4)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDxCollars[(iPickCollar[4] * 2)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDxCollars[(iPickCollar[5] * 6)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDxCollars[(iPickCollar[6] * 3)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDxCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 1)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 9)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 15)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 25)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 24)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 2)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 10)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 43)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDxBelts[(iPickBelt[1] * 1)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDxBelts[(iPickBelt[2] * 2)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDxBelts[(iPickBelt[3] * 3)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 1)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 1)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDxCuffsA[(iPickCuffsA[1] * 1)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 0)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDxCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDxCuffsL[(iPickCuffsL[1] * 1)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 0)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDxCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDxBras[(iPickBra[1] * 1)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 0)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0) 				 
EndFunction
Function iDDeMkFalmerOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 1)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 1)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 1)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 1)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 1)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 2)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 1)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 4)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 3)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 5)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 27)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 0)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 1)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 3)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 4)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 2)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 1)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 1)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 26)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 2)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 1)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 3)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 1)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 2)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 1)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 1)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 1)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0) 			 
EndFunction
Function iDDeMkFalmerDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 1)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 1)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 1)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 1)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 1)] ;Boxbinder Outfit Binds
	
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 2)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 1)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 4)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 3)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 5)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 27)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 0)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 1)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 3)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 4)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 2)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 1)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 1)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 26)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 2)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 1)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 3)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 1)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 2)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 1)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 1)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 1)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDeSuits[(iPickSuit[1] * 1)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDeSuits[(iPickSuit[2] * 2)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDeSuits[(iPickSuit[3] * 3)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDeSuits[(iPickSuit[4] * 4)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDeSuits[(iPickSuit[5] * 5)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDeCatSuits[(iPickSuit[6] * 1)] ;Cat Suit					
	
	SetLocalOutfit(iMech = 0) 				 
EndFunction 
Function iDDeMkGoZbfOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 0)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 0)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 4)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 2)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 0)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 0)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 0)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 0)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 0)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 0)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 7)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 0)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 11)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 3)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 12)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 11)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 10)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 9)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 0)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 4)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 3)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 30)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 6)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 5)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 4)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 2)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 3)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 0)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 5)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 8)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0) 				 
EndFunction
Function iDDeMkGoOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 3)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 3)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 2)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 2)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 3)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 3)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 8)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 9)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 0)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 10)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 7)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 31)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 11)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 3)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 12)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 11)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 10)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 9)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 5)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 31)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 4)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 3)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 30)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 6)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 5)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 4)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 2)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 3)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 3)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 4)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 8)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0)				 
EndFunction
Function iDDeMkGoDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 3)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 3)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 2)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 2)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 3)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 3)] ;Boxbinder Outfit Binds
	
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 8)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 9)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 0)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 10)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 7)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 31)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 11)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 3)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 12)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 11)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 10)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 9)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 22)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 5)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 31)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 4)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 3)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 30)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 6)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 5)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 4)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 2)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 3)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 3)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 4)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 8)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDeSuits[(iPickSuit[1] * 21)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDeSuits[(iPickSuit[2] * 22)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDeSuits[(iPickSuit[3] * 23)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDeSuits[(iPickSuit[4] * 24)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDeSuits[(iPickSuit[5] * 25)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDeCatSuits[(iPickSuit[6] * 5)] ;Cat Suit

	SetLocalOutfit(iMech = 0)			 				 
EndFunction
Function iDDeMkInZbfOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 0)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 0)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 5)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 3)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 0)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 0)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 0)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 0)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 0)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 0)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 11)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 0)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 12)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 4)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 16)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 15)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 14)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 13)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 0)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 6)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 5)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 31)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 8)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 7)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 5)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 0)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 7)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 9)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0)			 				 
EndFunction
Function iDDeMkInOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 4)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 4)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 3)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 3)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 4)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 4)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 12)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 14)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 13)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 15)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 11)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 32)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 12)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 4)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 16)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 15)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 14)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 13)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 6)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 6)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 5)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 31)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 8)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 7)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 5)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 4)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 6)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 9)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0)				 
EndFunction
Function iDDeMkInDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 4)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 4)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 3)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 3)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 4)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 4)] ;Boxbinder Outfit Binds 
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 12)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 14)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 13)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 15)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 11)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 32)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 12)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 4)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 16)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 15)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 14)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 13)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 23)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 6)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 6)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 5)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 31)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 8)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 7)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 5)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV  
	
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 4)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 6)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 9)] ;Padded Bra   
					
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDeSuits[(iPickSuit[1] * 26)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDeSuits[(iPickSuit[2] * 27)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDeSuits[(iPickSuit[3] * 28)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDeSuits[(iPickSuit[4] * 29)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDeSuits[(iPickSuit[5] * 30)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDeCatSuits[(iPickSuit[6] * 6)] ;Cat Suit				
	
	SetLocalOutfit(iMech = 0)		 				 
EndFunction
Function iDDeMkInMechOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 0)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 0)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 3)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 3)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 0)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 0)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 73)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 0)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 0)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 0)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 24)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 23)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 4)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 16)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 15)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 14)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 13)] ;Shackles Collar
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 8)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 7)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 0)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
		
	SetLocalOutfit(iMech = 1) 
EndFunction 
Function iDDeMkLtWoOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 6)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 6)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 0)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 6)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 6)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 71)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 16)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 72)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 0)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 30)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 6)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 17)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 17)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 0)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 19)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 18)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 4)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 7)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 29)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 9)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 0)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 7)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 5)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 8)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 10)] ;Padded Bra
				
	SetLocalOutfit(iMech = 0)	 					 
EndFunction
Function iDDeMkLtWoDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 6)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 6)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 0)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 6)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 6)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 71)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 16)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 72)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 0)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 30)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 6)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 17)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 17)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 0)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 19)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 18)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 21)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 4)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 7)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 29)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 9)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 0)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 7)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
	
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 5)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 8)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 10)] ;Padded Bra	 		
						
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDeSuits[(iPickSuit[1] * 16)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDeSuits[(iPickSuit[2] * 17)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDeSuits[(iPickSuit[3] * 18)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDeSuits[(iPickSuit[4] * 19)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDeSuits[(iPickSuit[5] * 20)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDeCatSuits[(iPickSuit[6] * 4)] ;Cat Suit
		
	SetLocalOutfit(iMech = 0)
EndFunction 
Function iDDeMkWoOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 2)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 2)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 0)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 2)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 2)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 68)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 6)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 0)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 0)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 29)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 1)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 19)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 6)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 0)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 7)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 5)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 3)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 2)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 28)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 3)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 0)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 6)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 13)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 3)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 2)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 2)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 6)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0)	 
EndFunction
Function iDDeMkWoDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 2)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 2)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 0)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 2)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 2)] ;Boxbinder Outfit Binds
	
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 68)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 6)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 0)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 0)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 29)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 1)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 19)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 6)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 0)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 7)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 5)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 20)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 3)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 2)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 28)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 3)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 0)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 6)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 2)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 3)] ;DDe PlugV  				
	
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 2)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 2)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 6)] ;Padded Bra     
		
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDeSuits[(iPickSuit[1] * 11)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDeSuits[(iPickSuit[2] * 12)] ;Extreme Dress
	 _akSuits[3] = iDDeLib.DDeSuits[(iPickSuit[3] * 13)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDeSuits[(iPickSuit[4] * 14)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDeSuits[(iPickSuit[5] * 15)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDeCatSuits[(iPickSuit[6] * 3)] ;Cat Suit						
	
	SetLocalOutfit(iMech = 0)		 
EndFunction
Function iDDeMkRustyOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 7)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 7)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 6)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 2)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 7)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 7)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 17)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 19)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 18)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 20)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 34)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 14)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 5)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 22)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 21)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 20)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDxCollars[(iPickCollar[7] * 28)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 8)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 19)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 20)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 8)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 33)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 11)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 10)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 8)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 14)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 15)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 17)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 15)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 16)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 17)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 6)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 9)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 11)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0) 				 
EndFunction
Function iDDeMkRustyDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 7)] ;Elbowbinder Binds 
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 7)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 6)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 2)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 7)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 7)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 17)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 19)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 18)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 20)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 34)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 14)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 5)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 22)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 21)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 20)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDxCollars[(iPickCollar[7] * 28)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 25)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 8)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 19)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 20)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 8)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 33)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 11)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 10)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 8)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 14)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 15)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 17)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 15)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 16)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 17)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
	
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 6)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 9)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 11)] ;Padded Bra
						
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDeSuits[(iPickSuit[1] * 36)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDeSuits[(iPickSuit[2] * 37)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDeSuits[(iPickSuit[3] * 38)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDeSuits[(iPickSuit[4] * 39)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDeSuits[(iPickSuit[5] * 40)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDeCatSuits[(iPickSuit[6] * 8)] ;Cat Suit
	
	SetLocalOutfit(iMech = 0)		 				 
EndFunction
Function iDDeMkHexChOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 8)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 8)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 8)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 8)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 8)] ;Boxbinder Outfit Binds
	
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 21)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 23)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 22)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 24)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 35)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 0)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 6)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 26)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 25)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 24)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 9)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 9)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 34)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 13)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 12)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 9)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
	
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 7)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 10)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 12)] ;Padded Bra
				
	SetLocalOutfit(iMech = 0) 			 
EndFunction
Function iDDeMkHexRdOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 9)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 9)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 9)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 9)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 9)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 25)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 27)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 26)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 28)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 36)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 15)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 7)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 29)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 28)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 27)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 10)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 10)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 35)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 15)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 14)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 10)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 7)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 8)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 8)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 11)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 13)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0) 	 				 
EndFunction
Function iDDeMkHexRdDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 9)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 9)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 9)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 9)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 9)] ;Boxbinder Outfit Binds
	
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 25)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 27)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 26)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 28)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 36)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 15)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 7)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 29)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 28)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 27)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 27)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 10)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 10)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 35)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 15)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 14)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 10)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 7)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 8)] ;DDe PlugV  
	
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 8)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 11)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 13)] ;Padded Bra
					
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDeSuits[(iPickSuit[1] * 46)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDeSuits[(iPickSuit[2] * 47)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDeSuits[(iPickSuit[3] * 48)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDeSuits[(iPickSuit[4] * 49)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDeSuits[(iPickSuit[5] * 50)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDeCatSuits[(iPickSuit[6] * 10)] ;Cat Suit						
	
	SetLocalOutfit(iMech = 0) 		 				 
EndFunction
Function iDDeMkHexOrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 17)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 17)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 21)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 17)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 17)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 59)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 61)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 60)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 62)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 37)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 16)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 14)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 57)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 56)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 55)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 11)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 23)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 36)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 29)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 28)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 18)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 16)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 23)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 23)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0) 		 
EndFunction
Function iDDeMkHexOrDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 17)] ;Elbowbinder Binds 
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 17)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 21)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 17)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 17)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 59)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 61)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 60)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 62)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 37)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 16)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 14)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 57)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 56)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 55)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 28)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 11)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 23)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 36)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 29)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 28)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 18)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 16)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 23)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 23)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDeSuits[(iPickSuit[1] * 51)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDeSuits[(iPickSuit[2] * 52)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDeSuits[(iPickSuit[3] * 53)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDeSuits[(iPickSuit[4] * 54)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDeSuits[(iPickSuit[5] * 55)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDeCatSuits[(iPickSuit[6] * 11)] ;Cat Suit						
	
	SetLocalOutfit(iMech = 0)				 
EndFunction
Function iDDeMkHypOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 11)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 11)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 11)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 11)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 11)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 29)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 31)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 30)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 32)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 38)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 18)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 8)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 32)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 31)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 30)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 12)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 11)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 37)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 17)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 16)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 11)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 6)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 9)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 12)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 14)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0) 				 
EndFunction
Function iDDeMkHypDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 11)] ;Elbowbinder Binds 
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 11)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 11)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 11)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 11)] ;Boxbinder Outfit Binds
	
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 29)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 31)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 30)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 32)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 38)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 18)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 8)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 32)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 31)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 30)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 29)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 12)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 11)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 37)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 17)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 16)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 11)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 5)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 6)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 9)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 12)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 14)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDeSuits[(iPickSuit[1] * 56)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDeSuits[(iPickSuit[2] * 57)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDeSuits[(iPickSuit[3] * 58)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDeSuits[(iPickSuit[4] * 59)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDeSuits[(iPickSuit[5] * 60)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDeCatSuits[(iPickSuit[6] * 12)] ;Cat Suit
	
	SetLocalOutfit(iMech = 0)			 
EndFunction
Function iDDeMkJadeZbfOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 0)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 0)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 14)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 4)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 0)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 0)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 0)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 0)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 0)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 0)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 33)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 0)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 19)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 9)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 0)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 0)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 0)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 33)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 0)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 13)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 12)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 38)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 0)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 19)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 12)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 4)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 5)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 0)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 14)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 17)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0) 				 
EndFunction
Function iDDeMkJadeOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 12)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 12)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 13)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 4)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 12)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 12)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 34)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 36)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 35)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 37)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 33)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 39)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 19)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 9)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 36)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 35)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 34)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 33)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 13)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 13)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 12)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 38)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 18)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 19)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 12)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 4)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 5)] ;;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 10)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 13)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 17)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0)
EndFunction
Function iDDeMkJadeDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 12)] ;Elbowbinder Binds 
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 12)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 13)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 4)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 12)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 12)] ;Boxbinder Outfit Binds	
	
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 34)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 36)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 35)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 37)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 33)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 39)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 19)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 9)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 36)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 35)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 34)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 33)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 30)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 13)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 13)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 12)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 38)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 18)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 19)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 12)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 4)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 5)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 10)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 13)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 17)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDeSuits[(iPickSuit[1] * 61)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDeSuits[(iPickSuit[2] * 62)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDeSuits[(iPickSuit[3] * 63)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDeSuits[(iPickSuit[4] * 64)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDeSuits[(iPickSuit[5] * 65)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDeCatSuits[(iPickSuit[6] * 13)] ;Cat Suit
	
	SetLocalOutfit(iMech = 0) 
EndFunction
Function iDDeMkFifaZbfOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 0)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 0)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 16)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 5)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 0)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 0)] ;Boxbinder Outfit Binds 
			
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 0)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 0)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 0)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 0)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 38)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 0)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 20)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 10)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 0)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 0)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 0)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 37)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 0)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 15)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 14)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 39)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 0)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 20)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 13)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 5)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 6)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 0)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 16)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 18)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0)				 				 
EndFunction
Function iDDeMkFifaOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 13)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 13)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 15)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 5)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 13)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 13)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 39)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 41)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 40)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 42)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 38)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 40)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 20)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 10)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 40)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 39)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 38)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 37)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 14)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 15)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 14)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 39)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 21)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 20)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 13)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 5)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 6)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 11)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 15)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 18)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0) 				 
EndFunction
Function iDDeMkFifaDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 13)] ;Elbowbinder Binds 
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 13)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 15)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 5)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 13)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 13)] ;Boxbinder Outfit Binds
	
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 39)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 41)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 40)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 42)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 38)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 40)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 20)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 10)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 40)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 39)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 38)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 37)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 31)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 14)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 15)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 14)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 39)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 21)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 20)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 13)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 5)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 6)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 11)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 15)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 18)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDeSuits[(iPickSuit[1] * 66)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDeSuits[(iPickSuit[2] * 67)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDeSuits[(iPickSuit[3] * 68)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDeSuits[(iPickSuit[4] * 69)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDeSuits[(iPickSuit[5] * 70)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDeCatSuits[(iPickSuit[6] * 14)] ;Cat Suit						
	
	SetLocalOutfit(iMech = 0) 				 
EndFunction
Function iDDeMkFireZbfOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 0)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 0)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 18)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 6)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 0)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 0)] ;Boxbinder Outfit Binds 
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 0)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 0)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 0)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 0)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 43)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 0)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 21)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 11)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 0)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 0)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 0)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 41)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 0)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 17)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 16)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 40)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 0)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 22)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 14)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 6)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 7)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 0)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 18)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 19)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0)			 			 
EndFunction
Function iDDeMkFireOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 14)] ;Elbowbinder Binds 
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 14)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 17)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 6)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 14)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 14)] ;Boxbinder Outfit Binds
			
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 44)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 46)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 45)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 47)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 43)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 41)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 21)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 11)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 44)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 43)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 42)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 41)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 15)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 17)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 16)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 40)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 23)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 22)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 14)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 6)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 7)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 12)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 17)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 19)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0)	 
EndFunction
Function iDDeMkFireDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 14)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 14)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 17)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 6)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 14)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 14)] ;Boxbinder Outfit Binds
	
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 44)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 46)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 45)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 47)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 43)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 41)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 21)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 11)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 44)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 43)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 42)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 41)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 32)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 15)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 17)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 16)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 40)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 23)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 22)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 14)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 6)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 7)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 12)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 17)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 19)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDeSuits[(iPickSuit[1] * 71)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDeSuits[(iPickSuit[2] * 72)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDeSuits[(iPickSuit[3] * 73)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDeSuits[(iPickSuit[4] * 74)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDeSuits[(iPickSuit[5] * 75)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDeCatSuits[(iPickSuit[6] * 15)] ;Cat Suit
	
	SetLocalOutfit(iMech = 0)
EndFunction
Function iDDeMkRopeOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 5)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 5)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 0)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 5)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 5)] ;Boxbinder Outfit Binds 
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 69)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 48)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 70)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 0)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 33)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 13)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 18)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 46)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 0)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 47)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 45)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 7)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 18)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 32)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 24)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 0)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 15)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 9)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 13)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 19)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 20)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0) 			 
EndFunction
Function iDDeMkRopeDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 5)] ;Elbowbinder Binds 
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 5)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 0)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 5)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 5)] ;Boxbinder Outfit Binds
	
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 69)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 48)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 70)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 0)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 33)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 13)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 18)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 46)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 0)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 47)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 45)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 24)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 7)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 18)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 32)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 24)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 0)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 15)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 9)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 13)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 19)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 20)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDeSuits[(iPickSuit[1] * 31)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDeSuits[(iPickSuit[2] * 32)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDeSuits[(iPickSuit[3] * 33)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDeSuits[(iPickSuit[4] * 34)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDeSuits[(iPickSuit[5] * 35)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDeCatSuits[(iPickSuit[6] * 7)] ;Cat Suit		
	
	SetLocalOutfit(iMech = 0)			 
EndFunction 
Function iDDeMkLeBrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 15)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 15)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 0)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 15)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 15)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 50)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 52)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 51)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 53)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 49)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 28)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 2)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 12)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 50)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 49)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 48)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 2)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 19)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 27)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 32)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 0)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 16)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 14)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 20)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 21)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0)					 				 
EndFunction
Function iDDeMkLeBrDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 15)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 15)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 0)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 15)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 15)] ;Boxbinder Outfit Binds 
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 50)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 52)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 51)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 53)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 49)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 28)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 2)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 12)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 50)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 49)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 48)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 19)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 2)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 19)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 27)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 32)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 0)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 16)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 14)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 20)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 21)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDeSuits[(iPickSuit[1] * 6)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDeSuits[(iPickSuit[2] * 7)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDeSuits[(iPickSuit[3] * 8)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDeSuits[(iPickSuit[4] * 9)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDeSuits[(iPickSuit[5] * 10)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDeCatSuits[(iPickSuit[6] * 2)] ;Cat Suit
	
	SetLocalOutfit(iMech = 0)		 
EndFunction
Function iDDeMkCrimsonZbfOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 0)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 0)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 20)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 7)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 0)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 0)] ;Boxbinder Outfit Binds 
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 0)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 0)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 0)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 0)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 54)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 0)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 7)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 13)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 0)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 0)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 0)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 51)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 0)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 21)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 20)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 41)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 0)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 25)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 17)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 7)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 8)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 0)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 22)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 22)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0)			 
EndFunction
Function iDDeMkCrimsonOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 16)] ;Elbowbinder Binds 
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 16)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 19)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 7)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 16)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 16)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 55)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 57)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 56)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 58)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 54)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 42)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 7)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 13)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 54)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 53)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 52)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 51)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 16)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 21)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 20)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 41)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 26)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 25)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 17)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 7)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 8)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 15)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 21)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 22)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0)			 
EndFunction
Function iDDeMkCrimsonDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 16)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 16)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 19)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 7)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 16)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 16)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 55)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 57)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 56)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 58)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 54)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 42)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 7)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 13)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 54)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 53)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 52)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 51)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 33)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 16)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 21)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 20)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 41)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 26)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 25)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 17)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 7)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 8)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 15)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 21)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 22)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDeSuits[(iPickSuit[1] * 76)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDeSuits[(iPickSuit[2] * 77)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDeSuits[(iPickSuit[3] * 78)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDeSuits[(iPickSuit[4] * 79)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDeSuits[(iPickSuit[5] * 80)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDeCatSuits[(iPickSuit[6] * 16)] ;Cat Suit

	SetLocalOutfit(iMech = 0)	 				 
EndFunction
Function iDDeMkBumbeeZbfOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 0)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 0)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 24)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 8)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 0)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 0)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 0)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 0)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 0)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 0)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 63)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 0)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 22)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 15)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 0)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 0)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 0)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 58)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 0)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 25)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 24)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 42)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 0)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 30)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 19)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 8)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 9)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 0)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 24)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 24)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0)	 					 
EndFunction
Function iDDeMkBumbeeOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 18)] ;Elbowbinder Binds 
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 18)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 23)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 8)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 18)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 18)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 64)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 66)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 65)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 67)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 63)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 43)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 22)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 15)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 61)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 60)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 59)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 58)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 17)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 25)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 24)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 42)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 31)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 30)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 19)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 8)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 9)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 17)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 25)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 24)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0)		 
EndFunction
Function iDDeMkBumbeeDrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 18)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 18)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 23)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 8)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 18)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 18)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 64)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 66)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 65)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 67)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 63)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 43)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 22)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 15)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 61)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 60)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 59)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 58)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 34)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 17)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDeBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDeBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDeBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDeBoots[(iPickBoots[4] * 25)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDeBoots[(iPickBoots[5] * 24)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 42)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 31)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 30)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 19)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDeCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 8)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 9)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 17)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 25)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 24)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDeSuits[(iPickSuit[1] * 81)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDeSuits[(iPickSuit[2] * 82)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDeSuits[(iPickSuit[3] * 83)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDeSuits[(iPickSuit[4] * 84)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDeSuits[(iPickSuit[5] * 85)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDeCatSuits[(iPickSuit[6] * 17)] ;Cat Suit
	
	SetLocalOutfit(iMech = 0)			 
EndFunction
Function iDDeMkIrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 0)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 0)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 25)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 1)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 0)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 0)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 33)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 40)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 32)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 41)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 39)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 0)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 17)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 16)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDeCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDeCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 0)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDeCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 0)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDeCollars[(iPickCollar[6] * 0)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 8)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDeGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDeGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDeGloves[(iPickGloves[3] * 0)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 15)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 17)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDxBoots[(iPickBoots[6] * 18)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 0)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 4)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDxHarness[(iPickHarn[1] * 14)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 0)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 3)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 7)] ;Padded Bra        
							
	SetLocalOutfit(iMech = 0)	 			 
EndFunction
Function iDDeMkHrBkOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDxPetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 0)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 0)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 25)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDeShackles[(iPickBinder[5] * 1)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 0)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 0)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 32)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 33)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 37)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 39)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 41)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 40)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDxHoods[(iPickHood[1] * 0)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 17)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 16)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDxCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDxCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDxCollars[(iPickCollar[3] * 0)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDxCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDxCollars[(iPickCollar[5] * 0)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDxCollars[(iPickCollar[6] * 0)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDxCollars[(iPickCollar[7] * 27)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 7)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 15)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 17)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDxBoots[(iPickBoots[6] * 18)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDxBelts[(iPickBelt[1] * 0)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDxBelts[(iPickBelt[2] * 0)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDxBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDxHarness[(iPickHarn[1] * 13)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 0)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 0)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 0)] ;Padded Bra        
	
	_sDevOpt += ",bLockGloves"						
	SetLocalOutfit(iMech = 0)		 
EndFunction 
Function iDDeMkHrRuOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDePetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDeElbowBinders[(iPickBinder[2] * 0)] ;Elbowbinder Binds 
	 _akBinds[3] = iDDeLib.DDeArmBinders[(iPickBinder[3] * 0)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDeYokes[(iPickBinder[4] * 6)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 2)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 0)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 0)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 35)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 36)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 38)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 44)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 42)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 43)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 34)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 14)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDeBlindFolds[(iPickBlinder[1] * 5)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.DDxCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.DDxCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.DDeCollars[(iPickCollar[3] * 0)] ;Harness Collar
	 _akCollars[4] = iDDeLib.DDxCollars[(iPickCollar[4] * 0)] ;Paded Collar
	 _akCollars[5] = iDDeLib.DDeCollars[(iPickCollar[5] * 0)] ;Rings Collar
	 _akCollars[6] = iDDeLib.DDxCollars[(iPickCollar[6] * 0)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDxCollars[(iPickCollar[7] * 28)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 8)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 16)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 0)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 19)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDxBoots[(iPickBoots[6] * 20)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDxBelts[(iPickBelt[1] * 0)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDxBelts[(iPickBelt[2] * 0)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDxBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDxHarness[(iPickHarn[1] * 15)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 0)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 14)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 15)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 17)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.DDePlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 15)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 16)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 17)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.DDePlugsV[(iPickPlugV[11] * 4)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.DDeCuffsA[(iPickCuffsA[1] * 0)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.DDeCuffsA[(iPickCuffsA[2] * 0)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.DDeCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.DDeCuffsL[(iPickCuffsL[1] * 0)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.DDeCuffsL[(iPickCuffsL[2] * 0)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.DDeCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.DDeBras[(iPickBra[1] * 0)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.DDeBras[(iPickBra[2] * 0)] ;Padded Bra        
	
	_sDevOpt += ",bLockGloves"							
	SetLocalOutfit(iMech = 0) 
EndFunction
Function iDDeMkDweMechOutfit()
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDeGags[(iPickGag[1] * 74)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDeGags[(iPickGag[2] * 74)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDeGags[(iPickGag[3] * 0)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDeGags[(iPickGag[4] * 0)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDeGags[(iPickGag[5] * 0)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDeGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDeHoods[(iPickHood[1] * 26)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 25)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDeHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	SetLocalOutfit(iMech = 2)
EndFunction
;CD
Function iDDeMkCDxOutfit()
	_akBinds = NEW Form[8] 
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDxPetSuits[(iPickBinder[1] * 4)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDxElbowBinders[(iPickBinder[2] * 4)] ;Elbowbinder Binds 
	 _akBinds[3] = iDDeLib.DDxArmBinders[(iPickBinder[3] * 2)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDxYokes[(iPickBinder[4] * 1)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 3)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 4)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 4)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 8)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 6)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 9)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 7)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 10)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDxHoods[(iPickHood[1] * 19)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDxHoods[(iPickHood[2] * 17)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDxBlindFolds[(iPickBlinder[1] * 19)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.CDxCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.CDxCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.CDxCollars[(iPickCollar[3] * 0)] ;Harness Collar
	 _akCollars[4] = iDDeLib.CDxCollars[(iPickCollar[4] * 5)] ;Paded Collar
	 _akCollars[5] = iDDeLib.CDxCollars[(iPickCollar[5] * 0)] ;Rings Collar
	 _akCollars[6] = iDDeLib.CDxCollars[(iPickCollar[6] * 6)] ;Posture Collar
	 _akCollars[7] = iDDeLib.CDxCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 2)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 0)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 12)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 4)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 2)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 10)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDxBoots[(iPickBoots[6] * 43)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 0)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 0)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDxHarness[(iPickHarn[1] * 3)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 2)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.CDxPlugsA[(iPickPlugA[13] * 4)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.CDxPlugsV[(iPickPlugV[11] * 9)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.CDxCuffsA[(iPickCuffsA[1] * 3)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.CDxCuffsA[(iPickCuffsA[2] * 0)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.CDxCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.CDxCuffsL[(iPickCuffsL[1] * 3)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.CDxCuffsL[(iPickCuffsL[2] * 0)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.CDxCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.CDxBras[(iPickBra[1] * 3)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.CDxBras[(iPickBra[2] * 0)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDxSuits[(iPickSuit[1] * 28)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDxSuits[(iPickSuit[2] * 7)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDxSuits[(iPickSuit[3] * 10)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDxSuits[(iPickSuit[4] * 19)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDxSuits[(iPickSuit[5] * 22)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDeCatSuits[(iPickSuit[6] * 18)] ;Cat Suit
	
	SetLocalOutfit(iMech = 0) 	 
EndFunction
Function iDDeMkCDxSvOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDxPetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDxElbowBinders[(iPickBinder[2] * 7)] ;Elbowbinder Binds 
	 _akBinds[3] = iDDeLib.DDxArmBinders[(iPickBinder[3] * 7)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDxYokes[(iPickBinder[4] * 0)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 7)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 7)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 0)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 47)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 0)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 0)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 0)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 48)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDxHoods[(iPickHood[1] * 19)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDxHoods[(iPickHood[2] * 17)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDxBlindFolds[(iPickBlinder[1] * 19)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.CDxCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.CDxCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.CDxCollars[(iPickCollar[3] * 0)] ;Harness Collar
	 _akCollars[4] = iDDeLib.CDxCollars[(iPickCollar[4] * 1)] ;Paded Collar
	 _akCollars[5] = iDDeLib.CDxCollars[(iPickCollar[5] * 0)] ;Rings Collar
	 _akCollars[6] = iDDeLib.CDxCollars[(iPickCollar[6] * 2)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 29)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 0)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 38)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 24)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 0)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDxBoots[(iPickBoots[6] * 0)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.DDeBelts[(iPickBelt[1] * 0)] ;Paded Belt
	 _akBelts[2] = iDDeLib.DDeBelts[(iPickBelt[2] * 0)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.DDeBelts[(iPickBelt[3] * 0)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDxHarness[(iPickHarn[1] * 17)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 21)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.CDxPlugsA[(iPickPlugA[13] * 3)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.CDxPlugsV[(iPickPlugV[11] * 5)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.CDxCuffsA[(iPickCuffsA[1] * 1)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.CDxCuffsA[(iPickCuffsA[2] * 0)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.CDxCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.CDxCuffsL[(iPickCuffsL[1] * 1)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.CDxCuffsL[(iPickCuffsL[2] * 0)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.CDxCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.CDxBras[(iPickBra[1] * 1)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.CDxBras[(iPickBra[2] * 0)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDxSuits[(iPickSuit[1] * 0)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDxSuits[(iPickSuit[2] * 31)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDxSuits[(iPickSuit[3] * 0)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDxSuits[(iPickSuit[4] * 0)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDxSuits[(iPickSuit[5] * 0)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDeCatSuits[(iPickSuit[6] * 18)] ;Cat Suit
		
	SetLocalOutfit(iMech = 0) 	 			 
EndFunction
Function iDDeMkCDxBrOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDxPetSuits[(iPickBinder[1] * 0)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDxElbowBinders[(iPickBinder[2] * 7)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDxArmBinders[(iPickBinder[3] * 7)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDxYokes[(iPickBinder[4] * 0)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 7)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 7)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 58)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 54)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 55)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 0)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 0)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 60)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDxHoods[(iPickHood[1] * 19)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDxHoods[(iPickHood[2] * 17)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
		
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDxBlindFolds[(iPickBlinder[1] * 19)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.CDxCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.CDxCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.CDxCollars[(iPickCollar[3] * 0)] ;Harness Collar
	 _akCollars[4] = iDDeLib.CDxCollars[(iPickCollar[4] * 3)] ;Paded Collar
	 _akCollars[5] = iDDeLib.CDxCollars[(iPickCollar[5] * 0)] ;Rings Collar
	 _akCollars[6] = iDDeLib.CDxCollars[(iPickCollar[6] * 4)] ;Posture Collar
	 _akCollars[7] = iDDeLib.DDeCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 0)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 29)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 0)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 0)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 24)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 0)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 0)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDxBoots[(iPickBoots[6] * 38)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.CDxBelts[(iPickBelt[1] * 3)] ;Paded Belt
	 _akBelts[2] = iDDeLib.CDxBelts[(iPickBelt[2] * 0)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.CDxBelts[(iPickBelt[3] * 4)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDxHarness[(iPickHarn[1] * 17)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 23)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.CDxPlugsA[(iPickPlugA[13] * 4)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.CDxPlugsV[(iPickPlugV[11] * 8)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.CDxCuffsA[(iPickCuffsA[1] * 2)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.CDxCuffsA[(iPickCuffsA[2] * 0)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.CDxCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.CDxCuffsL[(iPickCuffsL[1] * 2)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.CDxCuffsL[(iPickCuffsL[2] * 0)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.CDxCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.CDxBras[(iPickBra[1] * 2)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.CDxBras[(iPickBra[2] * 0)] ;Padded Bra              
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDxSuits[(iPickSuit[1] * 0)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDxSuits[(iPickSuit[2] * 31)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDxSuits[(iPickSuit[3] * 0)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDxSuits[(iPickSuit[4] * 0)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDxSuits[(iPickSuit[5] * 0)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDeCatSuits[(iPickSuit[6] * 18)] ;Cat Suit
		
	SetLocalOutfit(iMech = 0) 				 
EndFunction
Function iDDeMkCDxBkOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDxPetSuits[(iPickBinder[1] * 4)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDxElbowBinders[(iPickBinder[2] * 4)] ;Elbowbinder Binds 
	 _akBinds[3] = iDDeLib.DDxArmBinders[(iPickBinder[3] * 2)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDxYokes[(iPickBinder[4] * 2)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 3)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 4)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 4)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 8)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 6)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 9)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 7)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 10)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 0)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDxHoods[(iPickHood[1] * 3)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDxHoods[(iPickHood[2] * 20)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDxBlindFolds[(iPickBlinder[1] * 2)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.CDxCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.CDxCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.CDxCollars[(iPickCollar[3] * 0)] ;Harness Collar
	 _akCollars[4] = iDDeLib.CDxCollars[(iPickCollar[4] * 8)] ;Paded Collar
	 _akCollars[5] = iDDeLib.CDxCollars[(iPickCollar[5] * 0)] ;Rings Collar
	 _akCollars[6] = iDDeLib.CDxCollars[(iPickCollar[6] * 9)] ;Posture Collar
	 _akCollars[7] = iDDeLib.CDxCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 2)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 15)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 12)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 25)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 4)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 2)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 10)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 43)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.CDxBelts[(iPickBelt[1] * 10)] ;Paded Belt
	 _akBelts[2] = iDDeLib.CDxBelts[(iPickBelt[2] * 0)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.CDxBelts[(iPickBelt[3] * 11)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDxHarness[(iPickHarn[1] * 3)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 2)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.CDxPlugsA[(iPickPlugA[13] * 8)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.CDxPlugsV[(iPickPlugV[11] * 1)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.CDxCuffsA[(iPickCuffsA[1] * 4)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.CDxCuffsA[(iPickCuffsA[2] * 0)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.CDxCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.CDxCuffsL[(iPickCuffsL[1] * 4)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.CDxCuffsL[(iPickCuffsL[2] * 0)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.CDxCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.CDxBras[(iPickBra[1] * 4)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.CDxBras[(iPickBra[2] * 0)] ;Padded Bra         
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDxSuits[(iPickSuit[1] * 28)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDxSuits[(iPickSuit[2] * 7)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDxSuits[(iPickSuit[3] * 10)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDxSuits[(iPickSuit[4] * 19)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDxSuits[(iPickSuit[5] * 22)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDxCatSuits[(iPickSuit[6] * 1)] ;Cat Suit
		
	SetLocalOutfit(iMech = 0) 		 
EndFunction
Function iDDeMkCDxRdOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDxPetSuits[(iPickBinder[1] * 5)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDxElbowBinders[(iPickBinder[2] * 5)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDxArmBinders[(iPickBinder[3] * 5)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDxYokes[(iPickBinder[4] * 0)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 5)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 5)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 23)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 21)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 24)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 22)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 25)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 62)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDxHoods[(iPickHood[1] * 9)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDeHoods[(iPickHood[2] * 10)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDxBlindFolds[(iPickBlinder[1] * 13)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.CDxCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.CDxCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.CDxCollars[(iPickCollar[3] * 0)] ;Harness Collar
	 _akCollars[4] = iDDeLib.CDxCollars[(iPickCollar[4] * 10)] ;Paded Collar
	 _akCollars[5] = iDDeLib.CDxCollars[(iPickCollar[5] * 0)] ;Rings Collar
	 _akCollars[6] = iDDeLib.CDxCollars[(iPickCollar[6] * 11)] ;Posture Collar
	 _akCollars[7] = iDDeLib.CDxCollars[(iPickCollar[7] * 0)] ;Shackles Collar
		
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 5)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 20)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 13)] ;Mittens Gloves 
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 30)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 7)] ;Restrictivev
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 2)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 13)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 44)] ;Heels Boots
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.CDxBelts[(iPickBelt[1] * 12)] ;Paded Belt
	 _akBelts[2] = iDDeLib.CDxBelts[(iPickBelt[2] * 0)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.CDxBelts[(iPickBelt[3] * 13)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDxHarness[(iPickHarn[1] * 9)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 5)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.CDxPlugsA[(iPickPlugA[13] * 7)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.CDxPlugsV[(iPickPlugV[11] * 6)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.CDxCuffsA[(iPickCuffsA[1] * 5)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.CDxCuffsA[(iPickCuffsA[2] * 0)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.CDxCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.CDxCuffsL[(iPickCuffsL[1] * 5)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.CDxCuffsL[(iPickCuffsL[2] * 0)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.CDxCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.CDxBras[(iPickBra[1] * 5)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.CDxBras[(iPickBra[2] * 0)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDxSuits[(iPickSuit[1] * 29)] ;Elegant Dress
	 _akSuits[2] = iDDeLib.DDxSuits[(iPickSuit[2] * 8)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDxSuits[(iPickSuit[3] * 11)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDxSuits[(iPickSuit[4] * 20)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDxSuits[(iPickSuit[5] * 23)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDxCatSuits[(iPickSuit[6] * 11)] ;Cat Suit
		
	SetLocalOutfit(iMech = 0)	 
EndFunction
Function iDDeMkCDxWhOutfit()
	_akBinds = NEW Form[8]
	 _akBinds[0] = iDDeLib.NullTokens[(iPickBinder[0] * 1)] ;Null Binds
	 _akBinds[1] = iDDeLib.DDxPetSuits[(iPickBinder[1] * 6)] ;Pet Suit Binds
	 _akBinds[2] = iDDeLib.DDxElbowBinders[(iPickBinder[2] * 6)] ;Elbowbinder Binds
	 _akBinds[3] = iDDeLib.DDxArmBinders[(iPickBinder[3] * 3)] ;Armbinder Binds
	 _akBinds[4] = iDDeLib.DDxYokes[(iPickBinder[4] * 0)] ;Yoke Binds
	 _akBinds[5] = iDDeLib.DDxShackles[(iPickBinder[5] * 0)] ;Shackles Binds
	 _akBinds[6] = iDDeLib.DDeBoxBinders[(iPickBinder[6] * 6)] ;Boxbinder Binds
	 _akBinds[7] = iDDeLib.DDeBoxBinderOuts[(iPickBinder[7] * 6)] ;Boxbinder Outfit Binds
		
	_akGags = NEW Form[7]
	 _akGags[0] = iDDeLib.NullTokens[(iPickGag[0] * 1)] ;Null Gag
	 _akGags[1] = iDDeLib.DDxGags[(iPickGag[1] * 13)] ;Panel Gag
	 _akGags[2] = iDDeLib.DDxGags[(iPickGag[2] * 11)] ;Harness Ball Gag
	 _akGags[3] = iDDeLib.DDxGags[(iPickGag[3] * 14)] ;Simple Ball Gag
	 _akGags[4] = iDDeLib.DDxGags[(iPickGag[4] * 12)] ;Harness Ring Gag
	 _akGags[5] = iDDeLib.DDxGags[(iPickGag[5] * 15)] ;Simple Ring Gag
	 _akGags[6] = iDDeLib.DDxGags[(iPickGag[6] * 61)] ;Bit Gag
		
	_akHoods = NEW Form[4]
	 _akHoods[0] = iDDeLib.NullTokens[(iPickHood[0] * 1)] ;Null Hood
	 _akHoods[1] = iDDeLib.DDxHoods[(iPickHood[1] * 0)] ;Cat Hood
	 _akHoods[2] = iDDeLib.DDxHoods[(iPickHood[2] * 0)] ;Iron Mask
	 _akHoods[3] = iDDeLib.DDxHoods[(iPickHood[3] * 0)] ;Gas Mask
	
	_akBlinders = NEW Form[2]
	 _akBlinders[0] = iDDeLib.NullTokens[(iPickBlinder[0] * 1)] ;Null Blindfold
	 _akBlinders[1] = iDDeLib.DDxBlindFolds[(iPickBlinder[1] * 7)] ;Locked Blindfold
	
	_akCollars = NEW Form[8]
	 _akCollars[0] = iDDeLib.NullTokens[(iPickCollar[0] * 1)] ;Null Collar
	 _akCollars[1] = iDDeLib.CDxCollars[(iPickCollar[1] * 0)] ;Cat Collar
	 _akCollars[2] = iDDeLib.CDxCollars[(iPickCollar[2] * 0)] ;Restrictive Collar
	 _akCollars[3] = iDDeLib.CDxCollars[(iPickCollar[3] * 0)] ;Harness Collar
	 _akCollars[4] = iDDeLib.CDxCollars[(iPickCollar[4] * 12)] ;Paded Collar
	 _akCollars[5] = iDDeLib.CDxCollars[(iPickCollar[5] * 0)] ;Rings Collar
	 _akCollars[6] = iDDeLib.CDxCollars[(iPickCollar[6] * 13)] ;Posture Collar
	 _akCollars[7] = iDDeLib.CDxCollars[(iPickCollar[7] * 0)] ;Shackles Collar
	
	_akGloves = NEW Form[4]
	 _akGloves[0] = iDDeLib.NullTokens[(iPickGloves[0] * 1)] ;Null Gloves
	 _akGloves[1] = iDDeLib.DDxGloves[(iPickGloves[1] * 3)] ;Restrictive Gloves
	 _akGloves[2] = iDDeLib.DDxGloves[(iPickGloves[2] * 26)] ;Cat Gloves
	 _akGloves[3] = iDDeLib.DDxGloves[(iPickGloves[3] * 14)] ;Mittens Gloves
	
	_akBoots = NEW Form[7]
	 _akBoots[0] = iDDeLib.NullTokens[(iPickBoots[0] * 1)] ;Null Boots
	 _akBoots[1] = iDDeLib.DDxBoots[(iPickBoots[1] * 0)] ;Chain Boots
	 _akBoots[2] = iDDeLib.DDxBoots[(iPickBoots[2] * 36)] ;Cat Boots
	 _akBoots[3] = iDDeLib.DDxBoots[(iPickBoots[3] * 5)] ;Restrictive Boots
	 _akBoots[4] = iDDeLib.DDxBoots[(iPickBoots[4] * 2)] ;Ring Boots
	 _akBoots[5] = iDDeLib.DDxBoots[(iPickBoots[5] * 14)] ;Pony Boots
	 _akBoots[6] = iDDeLib.DDeBoots[(iPickBoots[6] * 45)] ;Heels Boots 
	
	_akBelts = NEW Form[4]
	 _akBelts[0] = iDDeLib.NullTokens[(iPickBelt[0] * 1)] ;Null Belt
	 _akBelts[1] = iDDeLib.CDxBelts[(iPickBelt[1] * 14)] ;Paded Belt
	 _akBelts[2] = iDDeLib.CDxBelts[(iPickBelt[2] * 0)] ;Chain Belt 
	 _akBelts[3] = iDDeLib.CDxBelts[(iPickBelt[3] * 15)] ;Paded Open Belt 
		
	_akHarns = NEW Form[3]
	 _akHarns[0] = iDDeLib.NullTokens[(iPickHarn[0] * 1)] ;Null Harness
	 _akHarns[1] = iDDeLib.DDeHarness[(iPickHarn[1] * 5)] ;Locking Harness
	 _akHarns[2] = iDDeLib.DDxCorsets[(iPickHarn[2] * 3)] ;Corset Harness   
	
	_akPlugsA = NEW Form[14]
	 _akPlugsA[0] = iDDeLib.NullTokens[(iPickPlugA[0] * 1)] ;Null PlugA
	 _akPlugsA[1] = iDDeLib.DDxPlugsA[(iPickPlugA[1] * 1)] ;Vintage PlugA
	 _akPlugsA[2] = iDDeLib.DDxPlugsA[(iPickPlugA[2] * 3)] ;Soul Gem PlugA
	 _akPlugsA[3] = iDDeLib.DDxPlugsA[(iPickPlugA[3] * 4)] ;Inflatable PlugA
	 _akPlugsA[4] = iDDeLib.DDxPlugsA[(iPickPlugA[4] * 6)] ;Grand Soul Gem PlugA
	 _akPlugsA[5] = iDDeLib.DDxPlugsA[(iPickPlugA[5] * 7)] ;Black Soul Gem PlugA
	 _akPlugsA[6] = iDDeLib.DDxPlugsA[(iPickPlugA[6] * 9)] ;Shocking PlugA
	 _akPlugsA[7] = iDDeLib.DDxPlugsA[(iPickPlugA[7] * 10)] ;Pear PlugA
	 _akPlugsA[8] = iDDeLib.DDxPlugsA[(iPickPlugA[8] * 11)] ;Pear Bell PlugA
	 _akPlugsA[9] = iDDeLib.DDxPlugsA[(iPickPlugA[9] * 13)] ;Pear Sign PlugA
	 _akPlugsA[10] = iDDeLib.DDxPlugsA[(iPickPlugA[10] * 18)] ;Pony Tail PlugA
	 _akPlugsA[11] = iDDeLib.DDxPlugsA[(iPickPlugA[11] * 20)] ;Pony Tail Braided PlugA
	 _akPlugsA[12] = iDDeLib.DDxPlugsA[(iPickPlugA[12] * 21)] ;Pony Tail Puffy PlugA
	 _akPlugsA[13] = iDDeLib.CDxPlugsA[(iPickPlugA[13] * 6)] ;DDe PlugA
		
	_akPlugsV = NEW Form[12]
	 _akPlugsV[0] = iDDeLib.NullTokens[(iPickPlugV[0] * 1)] ;Null PlugV
	 _akPlugsV[1] = iDDeLib.DDxPlugsV[(iPickPlugV[1] * 1)] ;Vintage PlugV
	 _akPlugsV[2] = iDDeLib.DDxPlugsV[(iPickPlugV[2] * 3)] ;Soul Gem PlugV
	 _akPlugsV[3] = iDDeLib.DDxPlugsV[(iPickPlugV[3] * 4)] ;Inflatable PlugV
	 _akPlugsV[4] = iDDeLib.DDxPlugsV[(iPickPlugV[4] * 6)] ;Training PlugV
	 _akPlugsV[5] = iDDeLib.DDxPlugsV[(iPickPlugV[5] * 8)] ;Grand Soul Gem PlugV
	 _akPlugsV[6] = iDDeLib.DDxPlugsV[(iPickPlugV[6] * 9)] ;Black Soul Gem PlugV
	 _akPlugsV[7] = iDDeLib.DDxPlugsV[(iPickPlugV[7] * 11)] ;Shocking PlugV
	 _akPlugsV[8] = iDDeLib.DDxPlugsV[(iPickPlugV[8] * 12)] ;Pear PlugV
	 _akPlugsV[9] = iDDeLib.DDxPlugsV[(iPickPlugV[9] * 13)] ;Pear Bell PlugV
	 _akPlugsV[10] = iDDeLib.DDxPlugsV[(iPickPlugV[10] * 14)] ;Pear Chain PlugV
	 _akPlugsV[11] = iDDeLib.CDxPlugsV[(iPickPlugV[11] * 3)] ;DDe PlugV 
		
	_akPieV = NEW Form[4]
	 _akPieV[0] = iDDeLib.NullTokens[(iPickPieV[0] * 1)] ;Null PieV
	 _akPieV[1] = iDDeLib.DDxPieV[(iPickPieV[1] * 1)] ;Soul Gem PieV  
	 _akPieV[2] = iDDeLib.DDxPieV[(iPickPieV[2] * 2)] ;Common Soul Gem PieV  
	 _akPieV[3] = iDDeLib.DDxPieV[(iPickPieV[3] * 3)] ;Shocking Soul Gem PieV 
		
	_akPieN = NEW Form[7]
	 _akPieN[0] = iDDeLib.NullTokens[(iPickPieN[0] * 1)] ;Null PieN
	 _akPieN[1] = iDDeLib.DDxPieN[(iPickPieN[1] * 1)] ;Soul Gem PieN  
	 _akPieN[2] = iDDeLib.DDxPieN[(iPickPieN[2] * 2)] ;Common Soul Gem PieN  
	 _akPieN[3] = iDDeLib.DDxPieN[(iPickPieN[3] * 3)] ;Shocking Soul Gem PieN 
	 _akPieN[4] = iDDeLib.DDxPieN[(iPickPieN[4] * 4)] ;HR Chain Harness PieN 
	 _akPieN[5] = iDDeLib.DDxPieN[(iPickPieN[5] * 6)] ;HR Clamps PieN 
	 _akPieN[6] = iDDeLib.DDxPieN[(iPickPieN[6] * 8)] ;HR PieN  
		
	_akCuffsA = NEW Form[4]
	 _akCuffsA[0] = iDDeLib.NullTokens[(iPickCuffsA[0] * 1)] ;Null CuffsA
	 _akCuffsA[1] = iDDeLib.CDxCuffsA[(iPickCuffsA[1] * 6)] ;Padded CuffsA  
	 _akCuffsA[2] = iDDeLib.CDxCuffsA[(iPickCuffsA[2] * 0)] ;Rings CuffsA  
	 _akCuffsA[3] = iDDeLib.CDxCuffsA[(iPickCuffsA[3] * 0)] ;Rope CuffsA 
		
	_akCuffsL = NEW Form[4]
	 _akCuffsL[0] = iDDeLib.NullTokens[(iPickCuffsL[0] * 1)] ;Null CuffsL
	 _akCuffsL[1] = iDDeLib.CDxCuffsL[(iPickCuffsL[1] * 6)] ;Padded CuffsL  
	 _akCuffsL[2] = iDDeLib.CDxCuffsL[(iPickCuffsL[2] * 0)] ;Rings CuffsL  
	 _akCuffsL[3] = iDDeLib.CDxCuffsL[(iPickCuffsL[3] * 0)] ;Rope CuffsL 
		
	_akBras = NEW Form[3]
	 _akBras[0] = iDDeLib.NullTokens[(iPickBra[0] * 1)] ;Null Bra
	 _akBras[1] = iDDeLib.CDxBras[(iPickBra[1] * 6)] ;Metal Padded Bra
	 _akBras[2] = iDDeLib.CDxBras[(iPickBra[2] * 0)] ;Padded Bra        
							
	_akSuits = NEW Form[7]
	 _akSuits[0] = iDDeLib.NullTokens[(iPickSuit[0] * 1)] ;Null Suit
	 _akSuits[1] = iDDeLib.DDxSuits[(iPickSuit[1] * 30)] ;Elegant Dress 
	 _akSuits[2] = iDDeLib.DDxSuits[(iPickSuit[2] * 9)] ;Extreme Dress 
	 _akSuits[3] = iDDeLib.DDxSuits[(iPickSuit[3] * 12)] ;Extreme Open Dress
	 _akSuits[4] = iDDeLib.DDxSuits[(iPickSuit[4] * 21)] ;Latex Dress
	 _akSuits[5] = iDDeLib.DDxSuits[(iPickSuit[5] * 24)] ;Latex Open Dress
	 _akSuits[6] = iDDeLib.DDeCatSuits[(iPickSuit[6] * 18)] ;Cat Suit
		
	SetLocalOutfit(iMech = 0)		 
EndFunction
Function iDDeMkCDxCursedOutfit()
	DDeOutfit = NEW Form[8] 
	 DDeOutfit[0] = iDDeLib.DDxCollars[14]
	 DDeOutfit[1] = iDDeLib.DDxPlugsA[7]
	 DDeOutfit[2] = iDDeLib.CDxPlugsV[7]
	 DDeOutfit[3] = iDDeLib.DDxPieV[3]
	 DDeOutfit[4] = iDDeLib.CDxBelts[16] 
	 DDeOutfit[5] = iDDeLib.DDxPieN[3] 
	 DDeOutfit[6] = iDDeLib.CDxCuffsA[7] 
	 DDeOutfit[7] = iDDeLib.CDxCuffsL[7]   				 
EndFunction 
;Random
Function iDDeMkRndDDsOutfit()
		INT[] iRndPlugA = NEW INT[3]
			iRndPlugA[0] = iDDeLib.DDePlugsA.Length
			iRndPlugA[1] = iDDeLib.DDxPlugsA.Length
			iRndPlugA[2] = iDDeLib.CDxPlugsA.Length
			iRndPlugA = iDDeGetRandomIdx(iRndPlugA)
		INT[] iRndPlugV = NEW INT[3]
			iRndPlugV[0] = iDDeLib.DDePlugsV.Length
			iRndPlugV[1] = iDDeLib.DDxPlugsV.Length
			iRndPlugV[2] = iDDeLib.CDxPlugsV.Length
			iRndPlugV = iDDeGetRandomIdx(iRndPlugV)
		INT[] iRndBelt = NEW INT[3]
			iRndBelt[0] = iDDeLib.DDeBelts.Length
			iRndBelt[1] = iDDeLib.DDxBelts.Length
			iRndBelt[2] = iDDeLib.CDxBelts.Length
			iRndBelt = iDDeGetRandomIdx(iRndBelt)
		INT[] iRndCuffsA = NEW INT[3]
			iRndCuffsA[0] = iDDeLib.DDeCuffsA.Length 
			iRndCuffsA[1] = iDDeLib.DDxCuffsA.Length
			iRndCuffsA[2] = iDDeLib.CDxCuffsA.Length
			iRndCuffsA = iDDeGetRandomIdx(iRndCuffsA)
		INT[] iRndCuffsL = NEW INT[3]
			iRndCuffsL[0] = iDDeLib.DDeCuffsL.Length
			iRndCuffsL[1] = iDDeLib.DDxCuffsL.Length
			iRndCuffsL[2] = iDDeLib.CDxCuffsL.Length
			iRndCuffsL = iDDeGetRandomIdx(iRndCuffsL)
		INT[] iRndBra = NEW INT[3]
			iRndBra[0] = iDDeLib.DDeBras.Length
			iRndBra[1] = iDDeLib.DDxBras.Length
			iRndBra[2] = iDDeLib.CDxBras.Length
			iRndBra = iDDeGetRandomIdx(iRndBra)
		INT[] iRndCollar = NEW INT[3]
			iRndCollar[0] = iDDeLib.DDeCollars.Length 
			iRndCollar[1] = iDDeLib.DDxCollars.Length
			iRndCollar[2] = iDDeLib.CDxCollars.Length
			iRndCollar = iDDeGetRandomIdx(iRndCollar)
		INT[] iRndHood = NEW INT[2]
			iRndHood[0] = iDDeLib.DDeHoods.Length
			iRndHood[1] = iDDeLib.DDxHoods.Length
			iRndHood = iDDeGetRandomIdx(iRndHood)
		INT[] iRndBlindFold = NEW INT[2]
			iRndBlindFold[0] = iDDeLib.DDeBlindFolds.Length 
			iRndBlindFold[1] = iDDeLib.DDxBlindFolds.Length
			iRndBlindFold = iDDeGetRandomIdx(iRndBlindFold)
		INT[] iRndGag = NEW INT[2]
			iRndGag[0] = iDDeLib.DDeGags.Length
			iRndGag[1] = iDDeLib.DDxGags.Length
			iRndGag = iDDeGetRandomIdx(iRndGag)
		INT[] iRndArms = NEW INT[14]
			iRndArms[0] = iDDeLib.DDeElbowBinders.Length
			iRndArms[1] = iDDeLib.DDxElbowBinders.Length
			iRndArms[2] = iDDeLib.DDeArmBinders.Length
			iRndArms[3] = iDDeLib.DDxArmBinders.Length
			iRndArms[4] = iDDeLib.DDeYokes.Length
			iRndArms[5] = iDDeLib.DDxYokes.Length
			iRndArms[6] = iDDeLib.DDeShackles.Length
			iRndArms[7] = iDDeLib.DDxShackles.Length
			iRndArms[8] = iDDeLib.DDePetSuits.Length
			iRndArms[9] = iDDeLib.DDxPetSuits.Length
			iRndArms[10] = iDDeLib.DDeBoxBinders.Length
			iRndArms[11] = iDDeLib.DDxBoxBinders.Length
			iRndArms[12] = iDDeLib.DDeBoxBinderOuts.Length
			iRndArms[13] = iDDeLib.DDxBoxBinderOuts.Length
			iRndArms = iDDeGetRandomIdx(iRndArms)
		INT[] iRndHarness = NEW INT[2]
			iRndHarness[0] = iDDeLib.DDeHarness.Length 
			iRndHarness[1] = iDDeLib.DDxHarness.Length
			iRndHarness = iDDeGetRandomIdx(iRndHarness)
		INT[] iRndBoots = NEW INT[2]
			iRndBoots[0] = iDDeLib.DDeBoots.Length
			iRndBoots[1] = iDDeLib.DDxBoots.Length
			iRndBoots = iDDeGetRandomIdx(iRndBoots)
		INT[] iRndGloves = NEW INT[2]
			iRndGloves[0] = iDDeLib.DDeGloves.Length
			iRndGloves[1] = iDDeLib.DDxGloves.Length
			iRndGloves = iDDeGetRandomIdx(iRndGloves)
		INT[] iRndSuit = NEW INT[3]
			iRndSuit[0] = iDDeLib.DDeSuits.Length
			iRndSuit[1] = iDDeLib.DDxSuits.Length
			iRndSuit[2] = iDDeLib.DDeMech.Length
			iRndSuit = iDDeGetRandomIdx(iRndSuit)
		
		DDeOutfit = NEW Form[53]
			If (!iRndSuit[2]) ;No mech suit.
				DDeOutfit[0] = iDDeLib.DDeBoxBinders[iRndArms[10]]
				DDeOutfit[1] = iDDeLib.DDxBoxBinders[iRndArms[11]]
				DDeOutfit[2] = iDDeLib.DDeBoxBinderOuts[iRndArms[12]]
				DDeOutfit[3] = iDDeLib.DDxBoxBinderOuts[iRndArms[13]]
				DDeOutfit[4] = iDDeLib.DDePlugsA[iRndPlugA[0]]
				DDeOutfit[5] = iDDeLib.DDxPlugsA[iRndPlugA[1]]
				DDeOutfit[6] = iDDeLib.CDxPlugsA[iRndPlugA[2]]
				DDeOutfit[7] = iDDeLib.DDePlugsV[iRndPlugV[0]]
				DDeOutfit[8] = iDDeLib.DDxPlugsV[iRndPlugV[1]]
				DDeOutfit[9] = iDDeLib.CDxPlugsV[iRndPlugV[2]]
				DDeOutfit[10] = iDDeLib.DDxPieN[RandomInt(0, (iDDeLib.DDxPieN.Length - 1))]
				DDeOutfit[11] = iDDeLib.DDeCuffsA[iRndCuffsA[0]]
				DDeOutfit[12] = iDDeLib.DDxCuffsA[iRndCuffsA[1]]
				DDeOutfit[13] = iDDeLib.CDxCuffsA[iRndCuffsA[2]]
				DDeOutfit[14] = iDDeLib.DDeCuffsL[iRndCuffsL[0]]
				DDeOutfit[15] = iDDeLib.DDxCuffsL[iRndCuffsL[1]]
				DDeOutfit[16] = iDDeLib.CDxCuffsL[iRndCuffsL[2]]
				DDeOutfit[17] = iDDeLib.DDeBras[iRndBra[0]]
				DDeOutfit[18] = iDDeLib.DDxBras[iRndBra[1]]
				DDeOutfit[19] = iDDeLib.CDxBras[iRndBra[2]]
				DDeOutfit[20] = iDDeLib.DDePetSuits[iRndArms[8]]
				DDeOutfit[21] = iDDeLib.DDxPetSuits[iRndArms[9]]
				DDeOutfit[22] = iDDeLib.DDeHarness[iRndHarness[0]]
				DDeOutfit[23] = iDDeLib.DDxHarness[iRndHarness[1]]
				DDeOutfit[24] = iDDeLib.DDeBoots[iRndBoots[0]]
				DDeOutfit[25] = iDDeLib.DDxBoots[iRndBoots[1]]
				DDeOutfit[26] = iDDeLib.DDeGloves[iRndGloves[0]]
				DDeOutfit[27] = iDDeLib.DDxGloves[iRndGloves[1]]
				DDeOutfit[28] = iDDeLib.DDeSuits[iRndSuit[0]]
				DDeOutfit[29] = iDDeLib.DDxSuits[iRndSuit[1]]
				DDeOutfit[30] = iDDeLib.DDxCorsets[RandomInt(0, (iDDeLib.DDxCorsets.Length - 1))]	
				DDeOutfit[31] = iDDeLib.DDeArmBinders[iRndArms[2]]
				DDeOutfit[32] = iDDeLib.DDxArmBinders[iRndArms[3]]
				DDeOutfit[33] = iDDeLib.DDeElbowBinders[iRndArms[0]]
				DDeOutfit[34] = iDDeLib.DDxElbowBinders[iRndArms[1]]
			EndIf
				DDeOutfit[35] = iDDeLib.DDxPieV[RandomInt(0, (iDDeLib.DDxPieV.Length - 1))]
				DDeOutfit[36] = iDDeLib.DDeBelts[iRndBelt[0]]
				DDeOutfit[37] = iDDeLib.DDxBelts[iRndBelt[1]]
				DDeOutfit[38] = iDDeLib.CDxBelts[iRndBelt[2]]
				DDeOutfit[39] = iDDeLib.DDeHoods[iRndHood[0]]
				DDeOutfit[40] = iDDeLib.DDxHoods[iRndHood[1]]
			If (!iRndHood[0]) ;DDe hood has built-in gag.
				DDeOutfit[41] = iDDeLib.DDeGags[iRndGag[0]]
				DDeOutfit[42] = iDDeLib.DDxGags[iRndGag[1]]
			EndIf	
				DDeOutfit[43] = iDDeLib.DDeCollars[iRndCollar[0]]
				DDeOutfit[44] = iDDeLib.DDxCollars[iRndCollar[1]]
				DDeOutfit[45] = iDDeLib.CDxCollars[iRndCollar[2]]
				DDeOutfit[46] = iDDeLib.DDeBlindFolds[iRndBlindFold[0]]
				DDeOutfit[47] = iDDeLib.DDxBlindFolds[iRndBlindFold[1]]
				DDeOutfit[48] = iDDeLib.DDeYokes[iRndArms[4]]
				DDeOutfit[49] = iDDeLib.DDxYokes[iRndArms[5]]
				DDeOutfit[50] = iDDeLib.DDeShackles[iRndArms[6]]
				DDeOutfit[51] = iDDeLib.DDxShackles[iRndArms[7]]
				DDeOutfit[52] = iDDeLib.DDeMech[iRndSuit[2]]		 	 
EndFunction

;Custom
STRING Function GetRndJson(STRING sFolder = "")
		If (!sFolder)
			sFolder = iDDeMCM.GetPathFolder(sPath = "Glo", sFolder = "Outfits")
		EndIf
	STRING[] sJsons = iSUmUtil.GetJsonsInFolder(sFolder = sFolder, bExt = True)
	INT iMax = sJsons.Length
		If (iMax > 1)
			INT[] iPicks = CreateIntArray(iMax, 0)
			INT i = 0
				While (i < iMax)
					iPicks[i] = JsonUtil.PathCount((sFolder + sJsons[i]), ".stringList")
					i += 1
				EndWhile
			INT[] iIs = iSUmUtil.GetRandomIdx(idxs = iPicks, sDiv = ",") 
			i = iIs[0]
			RETURN (sFolder + sJsons[i])
		Else
			RETURN iDDeMCM.GetPathJson(sPath = "GloOut", sJson = "iDDeOutfits")
	 	EndIf
EndFunction
STRING Function iDDeMkCuRndOutfit() 
	STRING sJson = GetRndJson()
	STRING sList = ""
	STRING[] sOuts = JsonUtil.PathMembers(sJson, ".stringList")
	INT iMax = sOuts.Length
		If (iMax > 0)
			sList = sOuts[RandomInt(0, (iMax - 1))]
			DDeOutfit = iSUmUtil.JsStrListToFormArr(akForms = DDeOutfit, sJson = sJson, sList = sList, sOpt = "bNew,bEqp")
		EndIf
	RETURN sList
EndFunction
BOOL Function iDDeMkCuOutfit(STRING sOutfit = "")  
	STRING sJson = iSUmUtil.GetJsonByList(sList = sOutfit, sFolder = iDDeMCM.GetPathFolder(sPath = "Glo", sFolder = "Outfits")) 
		If (sOutfit && sJson)
			DDeOutfit = iSUmUtil.JsStrListToFormArr(akForms = DDeOutfit, sJson = sJson, sList = sOutfit, sOpt = "bNew,bEqp")
			RETURN True
		Else
			RETURN False
		EndIf
EndFunction
;ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo

;MCM Export/Import
;mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
BOOL Function iDDeExportSettings(STRING sFile = "")
	If (sFile == "")
		RETURN False
	EndIf
	
	;STRING

	RETURN True
EndFunction	
BOOL Function iDDeImportSettings(STRING sFile = "") 
	If (sFile == "")
		RETURN False
	EndIf
		
	;STRING
	
		
	RETURN True
EndFunction	  

;Deprecated
;ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd

;Properties
;ppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp
Form[] Property DDeOutfit Auto Hidden

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

STRING _sDevOpt = ""

Form[] _akBinds
Form[] _akGags
Form[] _akHoods
Form[] _akBlinders
Form[] _akCollars
Form[] _akGloves
Form[] _akBoots
Form[] _akBelts
Form[] _akHarns
Form[] _akPlugsA
Form[] _akPlugsV
Form[] _akPieV
Form[] _akPieN
Form[] _akCuffsA
Form[] _akCuffsL
Form[] _akBras
Form[] _akSuits