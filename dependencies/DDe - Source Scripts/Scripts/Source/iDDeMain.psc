ScriptName iDDeMain Extends Quest Conditional

Import Utility 
Import Game 

iDDeLibs Property iDDeLib Auto
iDDeMisc Property iDDeMis Auto
iDDeFuncs Property iDDeFunc Auto
iDDeConfig Property iDDeMCM Auto
zadLibs Property ZadLib Auto
zadArmbinderQuestScript Property ZadAbq Auto 
zbfPlayerControl Property zbfPC Auto
iSUmMain Property iSUm Auto

INT Property iDDeBlind Auto Hidden
INT Property iDDxBlind Auto Hidden
INT Property iDDeGag Auto Hidden
INT Property iDDxGag Auto Hidden
INT Property iDDeHood Auto Hidden
INT Property iDDxHood Auto Hidden
INT Property iDDeCollar Auto Hidden
INT Property iDDxCollar Auto Hidden
INT Property iCDxCollar Auto Hidden
INT Property iDDeBra Auto Hidden
INT Property iDDxBra Auto Hidden
INT Property iCDxBra Auto Hidden
INT Property iDDxPieN Auto Hidden 
INT Property iDDxPieV Auto Hidden
INT Property iDDeCuffsA Auto Hidden 
INT Property iDDxCuffsA Auto Hidden
INT Property iCDxCuffsA Auto Hidden
INT Property iDDeCuffsL Auto Hidden
INT Property iDDxCuffsL Auto Hidden
INT Property iCDxCuffsL Auto Hidden
INT Property iDDeCuffs Auto Hidden
INT Property iDDeElbowBinder Auto Hidden
INT Property iDDxElbowBinder Auto Hidden
INT Property iDDeArmBinder Auto Hidden
INT Property iDDxArmBinder Auto Hidden
INT Property iDDeYoke Auto Hidden
INT Property iDDxYoke Auto Hidden
INT Property iDDeShackles Auto Hidden
INT Property iDDxShackles Auto Hidden
INT Property iDDeBelt Auto Hidden
INT Property iDDxBelt Auto Hidden
INT Property iCDxBelt Auto Hidden
INT Property iDDeHarness Auto Hidden 
INT Property iDDxHarness Auto Hidden 
INT Property iDDePlugA Auto Hidden 
INT Property iDDxPlugA Auto Hidden
INT Property iCDxPlugA Auto Hidden
INT Property iDDePlugV Auto Hidden
INT Property iDDxPlugV Auto Hidden
INT Property iCDxPlugV Auto Hidden
INT Property iDDxCorset Auto Hidden
INT Property iDDeGloves Auto Hidden
INT Property iDDxGloves Auto Hidden
INT Property iDDeBoots Auto Hidden
INT Property iDDxBoots Auto Hidden
INT Property iDDeSuit Auto Hidden
INT Property iDDxSuit Auto Hidden
INT Property iDDeCatSuit Auto Hidden
INT Property iDDxCatSuit Auto Hidden
INT Property iDDeBinderEff Auto Hidden
INT Property iDDeMech Auto Hidden
INT Property iDDeRemQuest Auto Hidden
INT Property iDDePetSuit Auto Hidden
INT Property iDDxPetSuit Auto Hidden
INT Property iDDeBoxBinder Auto Hidden
INT Property iDDxBoxBinder Auto Hidden
INT Property iDDeBoxBinderOut Auto Hidden
INT Property iDDxBoxBinderOut Auto Hidden
INT Property iDisInfo Auto Hidden
INT Property iDDeStrip Auto Hidden
INT Property iDDeHardCore Auto Hidden
INT Property iDDe86Device Auto Hidden
INT Property iDDeArmFight Auto Hidden
INT Property iDDeArmSneak Auto Hidden
INT Property iDDeArmMenu Auto Hidden
INT Property iDDeArmActive Auto Hidden
INT Property iDDeArmTravel Auto Hidden
INT Property iDDeArmWait Auto Hidden
INT Property iDDeArmTalk Auto Hidden
INT Property iDDeArmStruggle Auto Hidden
INT Property iEnableBondFX = 1 Auto Hidden
INT Property iMechPow = 6 Auto Hidden
INT Property iMechPowSnd = 1 Auto Hidden

INT Property iDDePickPlugEff Auto Conditional Hidden
INT Property iDDePlugRibbed Auto Conditional Hidden
INT Property iDDePlugShocker Auto Conditional Hidden
INT Property iDDePlugFusStag Auto Conditional Hidden 
INT Property iDDePlugLinked Auto Conditional Hidden
INT Property iDDePlugLively Auto Conditional Hidden
INT Property iDDePlugDrainH Auto Conditional Hidden
INT Property iDDePlugDrainS Auto Conditional Hidden
INT Property iDDePlugDrainM Auto Conditional Hidden
INT Property iDDePlugEleStim Auto Conditional Hidden
INT Property iDDePlugEdgeRand Auto Conditional Hidden
INT Property iDDePlugEdgeOnly Auto Conditional Hidden
INT Property iDDePlugPoss Auto Conditional Hidden 
INT Property iDDePlugTrain Auto Conditional Hidden
INT Property iDDePlugVeLively Auto Conditional Hidden
INT Property iDDePlugVib Auto Conditional Hidden
INT Property iDDePlugVibCast Auto Conditional Hidden
INT Property iDDePlugVibRand Auto Conditional Hidden
INT Property iDDePlugVibStrg Auto Conditional Hidden
INT Property iDDePlugVibVeStrg Auto Conditional Hidden
INT Property iDDePlugVibVeWeak Auto Conditional Hidden
INT Property iDDePlugVibWeak Auto Conditional Hidden
INT Property iDDeMechFX Auto Conditional Hidden
INT Property iDDeMechJump Auto Conditional Hidden
INT Property iDDeMechDisarm Auto Conditional Hidden
INT Property iDDeMechNoActivate Auto Conditional Hidden
INT Property iDDeMechNoFighting Auto Conditional Hidden
INT Property iDDeMechNoMenu Auto Conditional Hidden
INT Property iDDeMechNoFastTravel Auto Conditional Hidden
INT Property iDDeMechNoMove Auto Conditional Hidden
INT Property iDDeMechNoSneak Auto Conditional Hidden
INT Property iDDeMechNoSprint Auto Conditional Hidden
INT Property iDDeMechNoWait Auto Conditional Hidden
INT Property iDDeBlockActArm = 1 Auto Conditional Hidden
INT Property iDDeBlockActMit = 1 Auto Conditional Hidden

FLOAT Property fDDeRefreshRate Auto Hidden 

BOOL Property bSUM Auto Hidden
BOOL Property bZAP Auto Hidden
BOOL Property bDDa Auto Hidden
BOOL Property bDDi Auto Hidden
BOOL Property bDDx Auto Hidden
BOOL Property bDDe Auto Hidden
BOOL Property bCD Auto Hidden
BOOL Property bSD Auto Hidden
BOOL Property bIsSE = False Auto Hidden

STRING Property sDDeSlave Auto Hidden
STRING Property sDDeNoStrip = "" Auto Hidden
STRING Property sActFolder Auto Hidden
STRING Property sActJson Auto Hidden
STRING Property sOutFolder Auto Hidden
STRING Property sOutJson Auto Hidden
STRING Property sActFoJs Auto Hidden
STRING Property sOutFoJs Auto Hidden

GlobalVariable Property iDDeUtilityTask Auto
GlobalVariable Property iDDeEqpOutfit Auto 
GlobalVariable Property iDDeOutfitReady Auto

Perk Property iDDe_PerkHeavyBondage Auto
Perk Property zad_BoundActivation Auto

Ammo Property iSUmFakeArrow Auto

Armor Property iDDe_Naked Auto

LeveledItem Property iDDe_LvItemTemp Auto

Outfit Property iDDe_OutfitTemp Auto
Outfit Property iDDe_OutfitNaked Auto

Actor Property PlayerRef Auto 
 
FLOAT Function GetVersion() 
	RETURN iDDeUtil.GetVersion()
EndFunction
STRING Function GetVersionStr() 
	RETURN iDDeUtil.GetVersionStr() 
EndFunction

;Events
;eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
Event iDDeOnEquipWorn(STRING eventName = "iDDeEquipWorn", STRING sList = "iDDeOutWorn", FLOAT fEquip, Form eSender)
	EventLock("iDDeOnEquipWorn")
	iDDeUtil.Log("iDDeOnEquipWorn():-> ", "Event started.")	
	Actor aSlave = eSender AS Actor
	INT iRet = EquipWorn(aSlave = aSlave, sList = sList, iDDs = (fEquip AS INT))
	aSlave.SendModEvent("iDDeDone", "iDDeEquipWorn", iRet)
	iDDeUtil.Log("iDDeOnEquipWorn():-> Done!")
	bEventBusy = False
EndEvent 
INT Function EquipWorn(Actor aSlave = None, STRING sList = "iDDeOutWorn", INT iDDs = 66, STRING sOpt = "", INT iOpt = 0)
;Equip/Unequip worn DDs.
;fEquip > 0 -> Will equip DDs.
;fEquip < 0 -> Will unequip DDs.
;fEquip = 0 -> Will ignore event.
	StorageUtil.SetIntValue(aSlave, "iDDeBusy", 1)
	FLOAT fTime = GetCurrentRealTime()
	INT iRet = 0
		If (aSlave)
			sDDeSlave = iDDeGetName(aSlave, "Global")
			iDDeUtil.Log("EquipWorn():-> ", "Started for [" +sDDeSlave+ "].")
				If (iDDs == 0)
					iDDeUtil.Log("EquipWorn():-> ", "fDDs = [" +iDDs+ "]. Ignoring the call.")
				Else
					iDDeUtil.Log("EquipWorn():-> ", "List = [" +sList+ "], fDDs = [" +iDDs+ "].")
					INT iDelL = 0
						If (iDDs < 0)
							iRet = iDDeListWorn(aSlave = aSlave, sList = sList, sMake = "bNew", bAll = True)
							iDelL = 3
						EndIf
					iRet = iDDeEquipRenStrList(aSlave = aSlave, sList = sList, iDDs = iDDs, b86 = iDDe86Device, bRemQ = iDDeRemQuest, iDelL = iDelL, bPluckL = False, idx = -7, orCont = None, bSkipO = False, bSkipE = False, bSkipM = False)
						If (iRet && (iDDs < 0) && sList && SetStoUtilCurOutfit(aSlave = aSlave, sOutfit = sList, iSet = -1))
						EndIf
				EndIf
		Else
			iDDeUtil.Log("EquipWorn():-> ", "No slave.")	 
		EndIf
	iDDeUtil.Log("EquipWorn():-> Done! Processed [" +iRet+ "] DDs in [" +iSUmUtil.SecToTime(sSec = (GetCurrentRealTime() - fTime))+ "].")
	StorageUtil.SetIntValue(aSlave, "iDDeBusy", 0)
	RETURN iRet
EndFunction 
Event iDDeOnEquipList(STRING eventName = "iDDeEquipList", STRING sList = "iDDeOutNoName", FLOAT fEquip, Form eSender)	
	EventLock("iDDeOnEquipList")
	iDDeUtil.Log("iDDeOnEquipList():-> ", "Event started.")	
	Actor aSlave = eSender AS Actor
	INT iRet = EquipList(aSlave = aSlave, sList = sList, iDDs = (fEquip AS INT))
	aSlave.SendModEvent("iDDeDone", "iDDeEquipList", iRet)
	iDDeUtil.Log("iDDeOnEquipList():-> Done!")
	bEventBusy = False
EndEvent
INT Function EquipList(Actor aSlave = None, STRING sList = "iDDeOutNoName", INT iDDs = 66, STRING sOpt = "", INT iOpt = 0)	
;Equip/Unequip a premade list.
;fEquip > 0 -> Will equip list.
;fEquip < 0 -> Will unequip list.
;fEquip = 0 -> Will ignore the event.  
	StorageUtil.SetIntValue(aSlave, "iDDeBusy", 1)
	FLOAT fTime = GetCurrentRealTime()
	INT iRet = 0
	sDDeSlave = iDDeGetName(aSlave, "Global")	
	iDDeUtil.Log("EquipList():-> ", "Started for [" +sDDeSlave+ "].")
		If (iDDs == 0)
			iDDeUtil.Log("EquipList():-> ", "fDDs = [" +iDDs+ "]. Ignoring the call.")
		Else
			iDDeUtil.Log("EquipList():-> ", "List = [" +sList+ "], iDDs [" +iDDs+ "].")
			iRet = iDDeEquipFormList(aSlave = aSlave, sList = sList, iDDs = iDDs, b86 = iDDe86Device, bRemQ = iDDeRemQuest, iDelL = 3, bPluckL = False, idx = -1, orCont = None, bSkipO = False, bSkipE = False, bSkipM = False)
		EndIf
	iDDeUtil.Log("EquipList():-> Done! Processed [" +iRet+ "] DDs in [" +iSUmUtil.SecToTime(sSec = (GetCurrentRealTime() - fTime))+ "].")
	StorageUtil.SetIntValue(aSlave, "iDDeBusy", 0)
	RETURN iRet
EndFunction
Event iDDeOnEquipOutfit(STRING eventName = "iDDeEquipOutfit", STRING sList = "iDDeOutNoName", FLOAT fEquip, Form eSender) 
	EventLock("iDDeOnEquipOutfit", 256)
	iDDeUtil.Log("iDDeOnEquipOutfit():-> ", "Event started.")	 
	Actor aSlave = eSender AS Actor
	INT iRet = EquipOutfit(aSlave = aSlave, sList = sList, iDDs = (fEquip AS INT))
	aSlave.SendModEvent("iDDeDone", "iDDeEquipOutfit", iRet)
	iDDeUtil.Log("iDDeOnEquipOutfit():-> Done!")
	bEventBusy = False
EndEvent
INT Function EquipOutfit(Actor aSlave = None, STRING sList = "iDDeOutNoName", INT iDDs = 66, STRING sOpt = "", INT iOpt = 0) 
;Equip outfit on actor - outside call
;sList = "iDDeOutAny" -> Will Un/equip a random outfit from bellow.
;See iDDeLibs.iDDeSetMcmOutfits() for the outfit names, or iDDePreMadeOutfits StorageUtil list. 
;fEquip > 0 -> Will equip that many items from the outfit.
;fEquip < 0 -> Will unequip that many items from the outfit.
;fEquip = 0 -> Will ignore the event.
	StorageUtil.SetIntValue(aSlave, "iDDeBusy", 1)
	FLOAT fTime = GetCurrentRealTime()
	sDDeSlave = iDDeGetName(aSlave, "Global")	
	INT iRet = 0
	iDDeUtil.Log("EquipOutfit(): ", "Started for [" +sDDeSlave+ "]. sList = [" +sList+ "]. iDDs = [" +iDDs+ "].")
	iDDeUtil.Log("EquipOutfit(): ", "sOpt = [" +sOpt+ "]. iOpt = [" +iOpt+ "].")
		If ((iDDs != 0) && sList)
			sList = GetFinalList(sList = sList)
			INT iDeli = StringUtil.Find(sList, ",", 0)
				If (iDeli > 0)
					STRING s = StringUtil.Substring(sList, (iDeli + 1), 0)
						iDDeUtil.Log("EquipOutfit(): ", "Pre final sList = [" +sList+ "].")
							If (s && (StringUtil.Find(sOpt, s, 0) < 0))
								sOpt = iSUmUtil.StrAddElement(sStr = sOpt, sAdd = s, bAdd = True, sDiv = ",")
							EndIf
						sList = StringUtil.Substring(sList, 0, iDeli)
				EndIf		
			iDDeUtil.Log("EquipOutfit(): ", "Final sList = [" +sList+ "].")
			INT iList = 0 
			INT iDelL = (((iDDs < 0) AS INT) * 3)
			BOOL bNew = (StringUtil.Find(sOpt, "bNew") > -1)
			iDDeUtil.Log("EquipOutfit(): ", "Final sOpt = [" +sOpt+ "]. iDelL = [" +iDelL+ "].")
				If (!bNew)
					iList = StorageUtil.StringListCount(aSlave, sList)
					iDDeUtil.Log("EquipOutfit(): ", "[" +sList+ "] string list has [" +iList+ "] items in it.")
				EndIf	
				If (iList > 0)
					iRet = iDDeEquipRenStrList(aSlave = aSlave, sList = sList, iDDs = iDDs, b86 = iDDe86Device, bRemQ = iDDeRemQuest, iDelL = iDelL)
				Else
					iDDeUtil.Log("EquipOutfit(): ", "Trying the [" +sList+ "] form list.")
					iList = StorageUtil.FormListCountValue(aSlave, sList, None, exclude = True) 	
					iDDeUtil.Log("EquipOutfit(): ", "[" +sList+ "] form list has [" +iList+ "] items in it.")
						If ((iList < 1) || bNew)
							iDDeUtil.Log("EquipOutfit(): ", "Making a new [" +sList+ "] list.")
							iList = iDDeFunc.MakeOutfit(aSlave = aSlave, sList = sList, sOutfit = sList, sOpt = sOpt)
							iDDeUtil.Log("EquipOutfit(): ", "MakeOutfit() returned [" +iList+ "] items!")
						EndIf
						If (iList > 0)
							iRet = iDDeEquipFormList(aSlave = aSlave, sList = sList, iDDs = iDDs, b86 = iDDe86Device, bRemQ = iDDeRemQuest, iDelL = iDelL, bSkipO = True)	
						Else
							iDDeUtil.Log("EquipOutfit(): ", "[" +sList+ "] has [" +iList+ "] items! Exiting!")
						EndIf
				EndIf
				If (iRet && (iDDs < 0) && sList && SetStoUtilCurOutfit(aSlave = aSlave, sOutfit = sList, iSet = -1))
				EndIf
		Else
			iDDeUtil.Log("EquipOutfit(): ", "List = [" +sList+ "], iDDs = [" +iDDs+ "]. Ignoring the call.")
		EndIf
	iDDeUtil.Log("EquipOutfit(): Done! Processed [" +iRet+ "] DDs in [" +iSUmUtil.SecToTime(sSec = (GetCurrentRealTime() - fTime))+ "].")
	StorageUtil.SetIntValue(aSlave, "iDDeBusy", 0)
	RETURN iRet
EndFunction    
Event iDDeOnListAllWornDDs(STRING eventName = "iDDeListAllWornDDs" , STRING sList = "iDDeOutWorn", FLOAT fMake, Form eSender)	
	EventLock("iDDeOnListAllWornDDs")
	iDDeUtil.Log("iDDeOnListAllWornDDs():-> ", "Event started.")	
	Actor aSlave = eSender AS Actor
	STRING sOpt = "bAppend"
		If (fMake > 0)
			sOpt = "bNew"
		EndIf
	INT iRet = ListAllWornDDs(aSlave = aSlave, sList = sList, iDDs = (fMake AS INT), sOpt = sOpt)
	aSlave.SendModEvent("iDDeDone", "iDDeListAllWornDDs", iRet)
	iDDeUtil.Log("iDDeOnListAllWornDDs():-> Done!")		
	bEventBusy = False
EndEvent
INT Function ListAllWornDDs(Actor aSlave = None, STRING sList = "iDDeOutWorn", INT iDDs = 66, STRING sOpt = "bNew", INT iOpt = 0)	
;Will make a StorUtil list of all DDs worn. 
;fEquip > 0 -> Will make a new StorUtil list.
;fEquip = 0 -> Will erase the StorUtil list.
;fEquip < 0 -> Will append to existing StorUtil list.
;fEquip > 10 -> Will make a new StorUtil list listing all items (inventory and rendered).
	StorageUtil.SetIntValue(aSlave, "iDDeBusy", 1)
	FLOAT fTime = GetCurrentRealTime()
	sDDeSlave = iDDeGetName(aSlave, "Global")	
	BOOL bAll = (iDDs > 10)
	INT iRet = 0
		iDDeUtil.Log("ListAllWornDDs():-> ", "Started for [" +sDDeSlave+ "].")
		iDDeUtil.Log("ListAllWornDDs():-> ", "List = [" +sList+ "], iDDs = [" +iDDs+ "], sOpt = [" +sOpt+ "].")
			If (iDDs == 0)
				StorageUtil.FormListClear(aSlave, sList)
				iRet = StorageUtil.StringListClear(aSlave, sList)
			Else
				iRet = iDDeListWorn(aSlave, sList, sOpt, bAll)	
			EndIf
	iDDeUtil.Log("ListAllWornDDs():-> Done! Processed [" +iRet+ "] DDs in [" +iSUmUtil.SecToTime(sSec = (GetCurrentRealTime() - fTime))+ "].")
	StorageUtil.SetIntValue(aSlave, "iDDeBusy", 0)
	RETURN iRet
EndFunction
Event iDDeOnEquipByTags(STRING eventName = "iDDeEquipByTags", STRING sTags = "", FLOAT fEquip, Form eSender)	
	EventLock("iDDeOnEquipByTags")
	iDDeUtil.Log("iDDeOnEquipByTags():-> ", "Event started.")	
	Actor aSlave = eSender AS Actor
	INT iRet = EquipByTags(aSlave = aSlave, sTags = sTags, iDDs = (fEquip AS INT))
	aSlave.SendModEvent("iDDeDone", "iDDeEquipByTags", iRet)
	iDDeUtil.Log("iDDeOnEquipByTags():-> Done!")
	bEventBusy = False
EndEvent 
INT Function EquipByTags(Actor aSlave = None, STRING sTags = "", INT iDDs = 66, STRING sOpt = "", INT iOpt = 0)	
;Equip/Unequip one DD by tags.
;sTags = "Bra, White Leather" will equip the white leather bra. 
;        sTags is looking for 2 tags separated by a comma (,). The first describes the kind of item, 
;        i.e. Bra or Belt. The second describes the options the item should have, i.e. Metal, Black Ebonite, etc.
;        The tags are exactly the same as they are spelled in the 'MCM Library' page.  
;fEquip > 0 -> Will equip that many DDs. 
;fEquip < 0 -> Will unequip that many DDs.
;fEquip = 0 -> Will ignore the event.
	StorageUtil.SetIntValue(aSlave, "iDDeBusy", 1)
	FLOAT fTime = GetCurrentRealTime()
	STRING sList = "iDDeTagDevice"
	sDDeSlave = iDDeGetName(aSlave, "Global")	
	INT iTags = 0
	INT iRet = 0
	iDDeUtil.Log("EquipByTags(): ", "Started for [" +sDDeSlave+ "].")
		If (iDDs == 0)
			iDDeUtil.Log("EquipByTags(): ", "fDDs = [" +iDDs+ "]. Ignoring the event.")
		ElseIf (sTags == "")
			iDDeUtil.Log("EquipByTags(): ", "Started without tags! Exiting!", 1)
		Else 
			INT iDelL = (((iDDs < 0) AS INT) * 3)
			iDDeUtil.Log("EquipByTags(): ", "Tags = [" +sTags+ "], fDDs = [" +iDDs+ "].")
				iTags = iDDeGetTagsDD(aSlave, sList, sTags)
					If (iTags > 0)
						iRet = iDDeEquipFormList(aSlave = aSlave, sList = sList, iDDs = iDDs, b86 = iDDe86Device, bRemQ = iDDeRemQuest, iDelL = iDelL)
					Else
						iDDeUtil.Log("EquipByTags(): ", "iDDeGetTagsDD() returned [" +iTags+ "] tags! Exiting!", 1)
					EndIf
		EndIf
	iDDeUtil.Log("EquipByTags(): Done! Processed [" +iRet+ "] DDs in [" +iSUmUtil.SecToTime(sSec = (GetCurrentRealTime() - fTime))+ "].")
	StorageUtil.SetIntValue(aSlave, "iDDeBusy", 0)
	RETURN iRet
EndFunction 
Event iDDeOnEquipOutfitByKeyword(STRING eventName = "iDDeEquipOutfitByKeyword", STRING sList = "", FLOAT fEquip, Form eSender) 
	EventLock("iDDeOnEquipOutfitByKeyword")
	iDDeUtil.Log("iDDeOnEquipOutfitByKeyword():-> ", "Event started.")
	Actor aSlave = eSender AS Actor
	STRING sOpt = ""
	INT iDelL = 0
		If (fEquip < 0.0)
			iDelL = 4
		EndIf
		If (StringUtil.Find(sList, "Opt=bNew") > -1)
			sList = iSUmUtil.StrPluck(sStr = sList, sPluck = "Opt=bNew")
			sOpt = iSUmUtil.StrAddElement(sStr = sOpt, sAdd = "bNew", bAdd = True, sDiv = ",")
		EndIf
		If (StringUtil.Find(sList, "Opt=bInvDDs") > -1)
			sList = iSUmUtil.StrPluck(sStr = sList, sPluck = "Opt=bInvDDs")
			sOpt = iSUmUtil.StrAddElement(sStr = sOpt, sAdd = "bInvDDs", bAdd = True, sDiv = ",")
		EndIf
		If (StringUtil.Find(sList, "Opt=bNoMatch") > -1)
			sList = iSUmUtil.StrPluck(sStr = sList, sPluck = "Opt=bNoMatch")
			sOpt = iSUmUtil.StrAddElement(sStr = sOpt, sAdd = "bNoMatch", bAdd = True, sDiv = ",")
		EndIf
	INT iRet = EquipOutfitByKeyword(aSlave = aSlave, sList = sList, iDDs = (fEquip AS INT), sOpt = sOpt, iDelL = iDelL)
	aSlave.SendModEvent("iDDeDone", "iDDeEquipOutfitByKeyword", iRet)
	iDDeUtil.Log("iDDeOnEquipOutfitByKeyword():-> Done!")
	bEventBusy = False
EndEvent   
INT Function EquipOutfitByKeyword(Actor aSlave = None, STRING sList = "iDDeOutNoName", INT iDDs = 66, STRING sOpt = "", INT iDelL = 0) 
;Un/Equip DD's from an outfit by a given list of keywords strings divided by commas (,). 
;The first string has to be the outfit name.
;Example,
;sList = "iDDeOutFifa,zad_DeviousBra,zad_DeviousBelt"
;fEquip > 0 -> Will equip only the bra and the belt from iDDeFifa outfit list.
;fEquip < 0 -> Will unequip only the bra and the belt from iDDeFifa outfit list.
;fEquip = 0 -> Will ignore the event.
;iOpt > 0 -> Will clear the list.
	StorageUtil.SetIntValue(aSlave, "iDDeBusy", 1)
	FLOAT fTime = GetCurrentRealTime()
	sDDeSlave = iDDeGetName(aSlave, "Global")
	INT iRet = 0
	iDDeUtil.Log("EquipOutfitByKeyword(): ", "Started for [" +sDDeSlave+ "].")
	iDDeUtil.Log("EquipOutfitByKeyword(): ", "List = [" +sList+ "].")
	iDDeUtil.Log("EquipOutfitByKeyword():-> ", "iDDs = [" +iDDs+ "], sOpt = [" +sOpt+ "], iDelL = [" +iDelL+ "].")
		If ((iDDs != 0) && aSlave)
			sList = GetFinalList(sList = sList)
			iDDeUtil.Log("EquipOutfitByKeyword(): ", "List + keywords = [" +sList+ "].")
			STRING[] sKwds = PapyrusUtil.StringSplit(sList, ",")
				sList = sKwds[0]
			STRING sKwdLi = (sList+ "_FilterKwds")
			STRING sTmpLi = (sList+  "_Tmp")
			INT iList = 0
			INT iKwds = iDDeStrToKwdList(aSlave = aSlave, sKwds = sKwds, sList = sKwdLi, idx = 1)
			BOOL bNew = (StringUtil.Find(sOpt, "bNew") > -1) 
			BOOL bInvDDs = (StringUtil.Find(sOpt, "bInvDDs") > -1)
			BOOL bFilter = True
			iDDeUtil.Log("EquipOutfitByKeyword(): ", "List name = [" +sList+ "].") 
				If (!bNew && !bInvDDs)
					iList = StorageUtil.StringListCount(aSlave, sList) 
					bFilter = (StringUtil.Find(sOpt, "bNoFilter") < 0)
					iDDeUtil.Log("EquipOutfitByKeyword(): ", "[" +sList+ "] string list has [" +iList+ "] items in it. Filter? [" +bFilter+ "].")
				EndIf	
				If (iList < 1)
					iDDeUtil.Log("EquipOutfitByKeyword(): ", "Trying the [" +sList+ "] form list.")
					iList = StorageUtil.FormListCountValue(aSlave, sList, None, exclude = True) 	
					iDDeUtil.Log("EquipOutfitByKeyword(): ", "[" +sList+ "] has [" +iList+ "] items in it.")
						If (bInvDDs)
							iDDeUtil.Log("EquipOutfitByKeyword(): ", "Using inventory DDs.")
							iList = iDDeMakeInvList(aSlave, sList = sList)
						ElseIf ((iList < 1) || bNew)
							iDDeUtil.Log("EquipOutfitByKeyword(): ", "Making a new list.")
							iList = iDDeFunc.MakeOutfit(aSlave = aSlave, sList = sList, sOutfit = sList, sOpt = sOpt)
						EndIf
					iDDeUtil.Log("EquipOutfitByKeyword(): ", "Got [" +iList+ "] items!")
						If (iList > 0)
							sOpt = iSUmUtil.StrAddElement(sStr = sOpt, sAdd = "FormList", bAdd = True, sDiv = ",")
							iList = iDDeFilterListByKwds(aSlave = aSlave, sList = sList, sKwdList = sKwdLi, sOpt = sOpt)
							iDDeUtil.Log("EquipOutfitByKeyword(): ", "[" +sKwdLi+ "] has  [" +iKwds+ "] keywords!")
							iDDeUtil.Log("EquipOutfitByKeyword(): ", "iDDeFilterListByKwds() adjusted the list to [" +iList+ "] DDs!")	
						EndIf	
				Else
					If (StringUtil.Find(sOpt, "bKeepList") > -1)
						iList = iDDeCopyList(aSlave = aSlave, sOriList = sList, sDesList = sTmpLi, sOpt = "bNew")
						sList = sTmpLi
					EndIf
					If (bFilter)
						iList = iDDeFilterListByKwds(aSlave = aSlave, sList = sList, sKwdList = sKwdLi, sOpt = sOpt)
					EndIf
				EndIf
				If (iList > 0)
					iRet = iDDeEquipRenStrList(aSlave = aSlave, sList = sList, iDDs = iDDs, b86 = iDDe86Device, bRemQ = iDDeRemQuest, iDelL = iDelL, bPluckL = False, idx = -1, orCont = None, bSkipO = False, bSkipE = False, bSkipM = False)
				Else
					iDDeUtil.Log("EquipOutfitByKeyword(): ", "The final list has [" +iList+ "] items! Exiting!", 1)
				EndIf
				If (iKwds > 0)
					StorageUtil.FormListClear(aSlave, sKwdLi)
				EndIf
				If (iRet && (iDDs < 0) && sList && SetStoUtilCurOutfit(aSlave = aSlave, sOutfit = sList, iSet = -1))
				EndIf
			StorageUtil.StringListClear(aSlave, sTmpLi)
		Else
			iDDeUtil.Log("EquipOutfitByKeyword():-> ", "fDDs = [" +iDDs+ "], aSlave = [" +sDDeSlave+ "]. Ignoring the call.")		
		EndIf
	iDDeUtil.Log("EquipOutfitByKeyword():-> ", "Done! Processed [" +iRet+ "] DDs in [" +iSUmUtil.SecToTime(sSec = (GetCurrentRealTime() - fTime))+ "].")
	StorageUtil.SetIntValue(aSlave, "iDDeBusy", 0)
	RETURN iRet
EndFunction  
Event iDDeOnEquipIdx(STRING eventName = "iDDeEquipIdx", STRING sList = "iDDeOutWorn", FLOAT fEquip, Form eSender)	
	EventLock("iDDeOnEquipIdx")
	iDDeUtil.Log("iDDeOnEquipIdx():-> ", "Event started.")
	Actor aSlave = eSender AS Actor
	INT iRet = EquipIdx(aSlave = aSlave, sList = sList, iDDs = (fEquip AS INT))
	aSlave.SendModEvent("iDDeDone", "iDDeOnEquipIdx", iRet)
	iDDeUtil.Log("iDDeOnEquipIdx():-> Done!")
	bEventBusy = False
EndEvent
INT Function EquipIdx(Actor aSlave = None, STRING sList = "iDDeOutNoName", INT iDDs = 66, STRING sOpt = "", INT iOpt = 0)	
;Equip/Unequip Actor by DD (index +/- 1).
;fEquip > 0 -> Will equip item.
;fEquip < 0 -> Will unequip item. 
;fEquip = 0 -> Will ignore event.
	StorageUtil.SetIntValue(aSlave, "iDDeBusy", 1)
	FLOAT fTime = GetCurrentRealTime()
	INT iRet = 0
		If (aSlave)
			sDDeSlave = iDDeGetName(aSlave, "Global")	
			STRING sJson
			INT idx = ((Math.abs(iDDs) AS INT) - 1)
			iDDeUtil.Log("EquipIdx():-> ", "Started for [" +sDDeSlave+ "].")
				If (iDDs == 0)
					iDDeUtil.Log("EquipIdx():-> ", "iDDs = [" +iDDs+ "]. Ignoring the event.")
				Else
					iDDeUtil.Log("EquipIdx():-> ", "List = [" +sList+ "], iDDs -> [" +iDDs+ "].")
					INT iList = StorageUtil.StringListCount(aSlave, sList)
					iDDeUtil.Log("EquipIdx():-> ", "[" +sList+ "] string list has [" +iList+ "] items in it.")
						If (iList > idx)
							iRet = iDDeEquipRenStrList(aSlave = aSlave, sList = sList, iDDs = iDDs, b86 = iDDe86Device, bRemQ = iDDeRemQuest, iDelL = 0, bPluckL = True, idx = idx, orCont = None, bSkipO = True, bSkipE = False, bSkipM = False)
						Else
							iRet = iDDeEquipFormList(aSlave = aSlave, sList = sList, iDDs = iDDs, b86 = iDDe86Device, bRemQ = iDDeRemQuest, iDelL = 0, bPluckL = True, idx = idx, orCont = None, bSkipO = True, bSkipE = False, bSkipM = False)
						EndIf
				EndIf
		Else
			iDDeUtil.Log("EquipIdx():-> ", "No slave.")	 
		EndIf
	iDDeUtil.Log("EquipIdx():-> Done! Processed [" +iRet+ "] DDs in [" +iSUmUtil.SecToTime(sSec = (GetCurrentRealTime() - fTime))+ "].")
	StorageUtil.SetIntValue(aSlave, "iDDeBusy", 0)
	RETURN iRet
EndFunction
Event iDDeOnSetMech(STRING eventName = "iDDeOutSetMech", STRING sList = "iDDeSetMech", FLOAT fSet = -1.0, Form eSender) 
	EventLock("iDDeOnSetMech", 256)
	iDDeUtil.Log("iDDeOnSetMech():-> ", "Event started.") 
	Actor aSlave = (eSender AS Actor)
	INT iRet = 0
	STRING sOpt = ""
		If (StringUtil.Find(sList, "Opt=|") > -1)
			STRING[] sOpts = iSUmUtil.StrSliceReplEx(sStr = sList, sSt = "Opt=|", sEn = "|", sRep = "", idx = 0, bSt = True, bEn = True, iRet = 2)
				sList = sOpts[0]
					If (sOpts[2])
						sOpt = sOpts[2]
					EndIf
				iDDeUtil.Log("iDDeOnSetMech():-> ", "Extracted sOpt = [" +sOpt+ "].")
		EndIf
	iRet = StringUtil.Find(sList, ",", 0)
		If (iRet > 0)
			sList = StringUtil.Substring(sList, 0, iRet)
			iDDeUtil.Log("iDDeOnSetMech():-> ", "Extracted sList = [" +sList+ "].")
		EndIf
	iRet = SetMech(aSlave = aSlave, sList = sList, iDDs = (fSet AS INT), sOpt = sOpt)
	aSlave.SendModEvent("iDDeDone", "iDDeOnSetMech", iRet)
	iDDeUtil.Log("iDDeOnSetMech():-> ", "Done!")
	bEventBusy = False
EndEvent   
INT Function SetMech(Actor aSlave = None, STRING sList = "iDDeSetMech", INT iDDs = 66, STRING sOpt = "", INT iOpt = 0) 
	StorageUtil.SetIntValue(aSlave, "iDDeBusy", 1)
	sDDeSlave = iDDeGetName(aSlave, "Global")
	INT iRet = 0
	iDDeUtil.Log("SetMech():-> ", "Started for [" +sDDeSlave+ "]. sList = [" +sList+ "], iDDs = [" +iDDs+ "], sOpt = [" +sOpt+ "], iOpt = [" +iOpt+ "].")
		If (aSlave && (aSlave == PlayerRef) && sOpt)
			INT[] iMCMs = NEW INT[11]
			STRING[] sOpts = NEW STRING[11]
			STRING[] sMCMs = NEW STRING[11]
				iMCMs[0] = iDDeMechFX
				sOpts[0] = iSUmUtil.StrSlice(sStr = sOpt, sSt = "FX=|", sEn = "|,", sFail = "Null", sRem = " ")
				sMCMs[0] = (sList+ "FX")
				iMCMs[1] = iDDeMechNoActivate
				sOpts[1] = iSUmUtil.StrSlice(sStr = sOpt, sSt = "NoActivate=|", sEn = "|,", sFail = "Null", sRem = " ")
				sMCMs[1] = (sList+ "NoActivate")
				iMCMs[2] = iDDeMechNoFighting
				sOpts[2] = iSUmUtil.StrSlice(sStr = sOpt, sSt = "NoFighting=|", sEn = "|,", sFail = "Null", sRem = " ")
				sMCMs[2] = (sList+ "NoFighting")
				iMCMs[3] = iDDeMechNoMenu
				sOpts[3] = iSUmUtil.StrSlice(sStr = sOpt, sSt = "NoMenu=|", sEn = "|,", sFail = "Null", sRem = " ")
				sMCMs[3] = (sList+ "NoMenu")
				iMCMs[4] = iDDeMechNoFastTravel
				sOpts[4] = iSUmUtil.StrSlice(sStr = sOpt, sSt = "NoFastTravel=|", sEn = "|,", sFail = "Null", sRem = " ")
				sMCMs[4] = (sList+ "NoFastTravel")
				iMCMs[5] = iDDeMechNoMove
				sOpts[5] = iSUmUtil.StrSlice(sStr = sOpt, sSt = "NoMove=|", sEn = "|,", sFail = "Null", sRem = " ")
				sMCMs[5] = (sList+ "NoMove")
				iMCMs[6] = iDDeMechNoSneak
				sOpts[6] = iSUmUtil.StrSlice(sStr = sOpt, sSt = "NoSneak=|", sEn = "|,", sFail = "Null", sRem = " ")
				sMCMs[6] = (sList+ "NoSneak")
				iMCMs[7] = iDDeMechNoSprint
				sOpts[7] = iSUmUtil.StrSlice(sStr = sOpt, sSt = "NoSprint=|", sEn = "|,", sFail = "Null", sRem = " ")
				sMCMs[7] = (sList+ "NoSprint")
				iMCMs[8] = iDDeMechNoWait
				sOpts[8] = iSUmUtil.StrSlice(sStr = sOpt, sSt = "NoWait=|", sEn = "|,", sFail = "Null", sRem = " ")
				sMCMs[8] = (sList+ "NoWait")
				iMCMs[9] = iDDeMechJump
				sOpts[9] = iSUmUtil.StrSlice(sStr = sOpt, sSt = "Jump=|", sEn = "|,", sFail = "Null", sRem = " ")
				sMCMs[9] = (sList+ "Jump")
				iMCMs[10] = iDDeMechDisarm
				sOpts[10] = iSUmUtil.StrSlice(sStr = sOpt, sSt = "Disarm=|", sEn = "|,", sFail = "Null", sRem = " ")
				sMCMs[10] = (sList+ "Disarm")
			INT iSet = iDDs
			INT i = 0
			INT iMax = sOpts.Length
				While (i < iMax)
					If (sOpts[i] != "Null")
						If (iDDs == 0)
							iSet = (sOpts[i] AS INT)
						EndIf
						If (sOpts[i] == "MCM")
							iSet = iMCMs[i]
							iMCMs[i] = StorageUtil.GetIntValue(aSlave, sMCMs[i], iMCMs[i])
							StorageUtil.UnSetIntValue(aSlave, sMCMs[i])
							iDDeUtil.Log("SetMech():-> ", "Unset [" +sMCMs[i]+ "] and restore MCM from [" +iSet+ "] to [" +iMCMs[i]+ "].")
						Else
							StorageUtil.SetIntValue(aSlave, sMCMs[i], iMCMs[i])
							iMCMs[i] = iSet
							iDDeUtil.Log("SetMech():-> ", "Set [" +sMCMs[i]+ "] to [" +iMCMs[i]+ "].")
						EndIf
						iRet += 1
					EndIf
					i += 1
				EndWhile
				If (iRet)
					iDDeMechFX 						= iMCMs[0]
					iDDeMechNoActivate 		= iMCMs[1]
					iDDeMechNoFighting 		= iMCMs[2]
					iDDeMechNoMenu 				= iMCMs[3]
					iDDeMechNoFastTravel 	= iMCMs[4]
					iDDeMechNoMove 				= iMCMs[5]
					iDDeMechNoSneak 			= iMCMs[6]
					iDDeMechNoSprint 			= iMCMs[7]
					iDDeMechNoWait 				= iMCMs[8]
					iDDeMechJump 					= iMCMs[9]
					iDDeMechDisarm 				= iMCMs[10]
				EndIf
		ElseIf (!sOpt)
			iDDeUtil.Log("SetMech():-> ", "No options!")
		Else
			iDDeUtil.Log("SetMech():-> ", "[" +sDDeSlave+ "] is no aSlave.")
		EndIf		
	iDDeUtil.Log("SetMech():-> ", "Done! Processed [" +iRet+ "] options.")
	StorageUtil.SetIntValue(aSlave, "iDDeBusy", 0)
	RETURN iRet
EndFunction 
Event iDDeOnStrip(STRING eventName = "iDDeStrip", STRING sList = "iDDeSripped", FLOAT fStrip = 0.0, Form eSender) 
	EventLock("iDDeOnStrip", 256)
	iDDeUtil.Log("iDDeOnStrip():-> ", "Event started.")
	Actor aSlave = eSender AS Actor
	INT iRet = Strip(aSlave = aSlave, sList = sList, iDDs = (fStrip AS INT))
	aSlave.SendModEvent("iDDeDone", "iDDeStrip", iRet)
	StorageUtil.SetIntValue(aSlave, (sList+ "_Return"), iRet)
	iDDeUtil.Log("iDDeOnStrip():-> Done!")
	bEventBusy = False
EndEvent 
INT Function Strip(Actor aSlave = None, STRING sList = "iDDeSripped", INT iDDs = 66, STRING sOpt = "", INT iOpt = 0) 
;Will strip the aSlave.
;sList -> the file to store the stripped outfits.  
;sList = 'StripByMCM' will strip according to the MCM option. 
;fStrip > 0 -> will strip the aSlave.
;fStrip > 10 -> will strip the aSlave and play a stripping animation.  
;fStrip < 0 -> will equip the previously removed stuff.
;fStrip = even -> will remove the stripped.
;fStrip = 0 -> will ignore the event.
	StorageUtil.SetIntValue(aSlave, "iDDeBusy", 1)
	sDDeSlave = iDDeGetName(aSlave, "Global")	
	INT iRet = 0
	iDDeUtil.Log("Strip():-> ", "Started for [" +sDDeSlave+ "].")
		If (iDDs == 0)
			iDDeUtil.Log("Strip():-> ", "iDDs = [" +iDDs+ "]. Ignoring the event.")
		Else
			iDDeUtil.Log("Strip():-> ", "List = [" +sList+ "], iDDs = [" +iDDs+ "].")
				If (sList == "iDDeStripByMCM")
					iDDs *= (iDDeStrip AS INT) 
				EndIf
				iRet = iDDeStripToList(aSlave, sList = sList, sNoStrip = sDDeNoStrip, iStrip = iDDs, bRem = ((iDDs % 2) == 0), bRemDDs = False, Anim = (iDDs > 10)) 						
		EndIf	
	iDDeUtil.Log("Strip():-> Done! Return = [" +iRet+ "].")
	StorageUtil.SetIntValue(aSlave, "iDDeBusy", 0)
	RETURN iRet
EndFunction 
INT Property iDDeLocks Auto Hidden 
STRING Function iDDeGetLockingMod(Actor aSlave, BOOL bGet = True)
;Locks out DDe
	STRING sMod = "Unlocked" 
		If (bGet)
			iDDeLocks = StorageUtil.StringListCount(aSlave, "iDDeLockingMods")
				If (iDDeLocks > 0)
					sMod = StorageUtil.StringListGet(aSlave, "iDDeLockingMods", (iDDeLocks - 1))
				EndIf
		Else
			iDDeLocks = 0
			StorageUtil.StringListClear(aSlave, "iDDeLockingMods")
		EndIf
	RETURN sMod			
EndFunction							
Event iDDeOnLock(STRING eventName = "iDDeLock", STRING sLockMod = "NoName Mod", FLOAT fLock = 1.0, Form eSender)
	Actor aSlave = eSender AS Actor
		If (fLock > 0)
			StorageUtil.StringListAdd(aSlave, "iDDeLockingMods", sLockMod, False);No duplicates
		Else
			StorageUtil.StringListRemove(aSlave, "iDDeLockingMods", sLockMod, True);All instances
		EndIf
EndEvent 
Event iDDeOnLockArmbinder(STRING eventName = "iDDeLockArmbinder", STRING sLockMod = "NoName Mod", FLOAT fLock = 1.0, Form eSender)
	Actor aSlave = eSender AS Actor
	INT iLock = (fLock AS INT)
		iDDeEqpMagicalArmbinder(aSlave, iLock, iLock)
EndEvent   	
;eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee

;Remove Items Functions
;rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
INT Function iDDeEquipFormList(Actor aSlave = None, STRING sList = "iDDeNoName", INT iDDs = 111, BOOL b86 = False, BOOL bRemQ = False, INT iDelL = 0, BOOL bPluckL = False, INT idx = -1, ObjectReference orCont = None, BOOL bSkipO = False, BOOL bSkipE = False, BOOL bSkipM = False)
;Will un/equip DD's from the StorageUtil list (sList) on the aSlave
;sList  -> the StorageUtil String list to work from.
;bEquip -> equip/unequip DD's
;orContainer -> optional - will move removed DD's here, or equip from here.
	iDDeUtil.Log("iDDeEquipFormList(): ", "Start! Remove quest DDs?-> [" +bRemQ+ "].")
	INT iRet = SetFormLiToRenStrLi(aSlave = aSlave, sList = sList, idx = idx)
	RETURN iDDeEquipRenStrList(aSlave = aSlave, sList = sList, iDDs = iDDs, b86 = b86, bRemQ = bRemQ, iDelL = iDelL, bPluckL = bPluckL, idx = idx, orCont = orCont, bSkipO = bSkipO, bSkipE = bSkipE, bSkipM = bSkipM) 
EndFunction	 
INT Function iDDeEquipRenStrList(Actor aSlave = None, STRING sList = "iDDeNoName", INT iDDs = 111, BOOL b86 = False, BOOL bRemQ = False, INT iDelL = 0, BOOL bPluckL = False, INT idx = -1, ObjectReference orCont = None, BOOL bSkipO = False, BOOL bSkipE = False, BOOL bSkipM = False) 
	iDDeUtil.Log("iDDeEquipRenStrList(): ", "Start!")
	STRING sEqp = "???"
	STRING saSlave = iDDeGetName(aSlave, "Global")
	STRING sCont = "Null"
	STRING sLiPl = (sList+ "_Pluck")
	STRING sStr = ""
	INT i = 0
	INT iMax = StorageUtil.StringListCount(aSlave, sList)
	INT iHasLockedDDs = 0
	INT iHasQuestDDs = 0
	INT iRet = 0
	BOOL bEqp = (iDDs > 0)
	Armor arInv = None
	Armor arRen = None
	Keyword keDev = None
	iDDeUtil.Log("iDDeEquipRenStrList(): ", "List passed is [" +sList+ "] and has a total of [" +iMax+ "] DDs listed.")
	StorageUtil.StringListClear(aSlave, sLiPl)
	iDDs = (Math.abs(iDDs) AS INT)
		If (aSlave != PlayerRef)
			;bSkipM = True
			bSkipE = True
		EndIf
		If (orCont)
			sCont = orCont.GetDisplayName()
		EndIf
		If ((idx > -1) && (idx < iMax))
			i = idx
			iMax = (idx + 1)
		ElseIf (iDDs < iMax)
			iMax = iDDs
		EndIf
		If (bEqp)
			iSUmUtil.UnequipActorHands(aActor = aSlave, iDrop = 0, foItem = iSUmFakeArrow)
		EndIf
		While (i < iMax)
			sStr = StorageUtil.StringListGet(aSlave, sList, i)
				If (sStr)
					arInv = (iSUmUtil.GetFormFromStr(sStr = sStr, akFail = None, sLabel = "Inv") AS Armor)
					arRen = (iSUmUtil.GetFormFromStr(sStr = sStr, akFail = None, sLabel = "Ren") AS Armor)
					keDev = (iSUmUtil.GetFormFromStr(sStr = sStr, akFail = None, sLabel = "Kwd") AS Keyword)
					sEqp = iSUmUtil.StrSlice(sStr = sStr, sSt = "Name=|", sEn = "|,", sFail = "Failed!", sRem = "", idx = 0)
					iDDeUtil.Log("iDDeEquipRenStrList(): ", "Working on [" +sEqp+ "] for [" +saSlave+ "].") 
						If (arInv && arRen && keDev)
							If (bEqp)
								iDDeUtil.Log("iDDeEquipRenStrList(): ", "[" +i+ "]-> [" +sEqp+ "], equipping...")
									If (orCont)
										If (orCont.GetItemCount(arInv) > 0)
											iDDeUtil.Log("iDDeEquipRenStrList(): ", "Moving [" +sEqp+ "] from [" +sCont+ "] to [" +saSlave+ "].")
											orCont.RemoveItem(arInv, 1, True, aSlave)
										Else
											iDDeUtil.Log("iDDeEquipRenStrList(): ", "No [" +sEqp+ "] found in [" +sCont+ "]!")
										EndIf
									EndIf
									If(!aSlave.IsEquipped(arRen) || !aSlave.IsEquipped(arInv))
										If (iDDeEquipDevice(aSlave, arInv, arRen, keDev, bSkipE, bSkipM) > 0)
											If (!iDelL && bPluckL)
												StorageUtil.StringListAdd(aSlave, sLiPl, sStr)
											EndIf	
											iRet += 1
										EndIf
									Else
										iDDeUtil.Log("iDDeEquipRenStrList(): ", "[" +sEqp+ "] is already equipped!")
									EndIf
							Else
								iDDeUtil.Log("iDDeEquipRenStrList(): ", "[" +i+ "]-> [" +sEqp+ "], removing...")
									If (aSlave.IsEquipped(arRen) || aSlave.IsEquipped(arInv))
										INT iRemDev = iDDeRemoveDevice(aSlave, arInv, arRen, keDev, bRemQ, b86, bSkipE, bSkipM)
											If (iRemDev == -1) ;Quest device
												iHasQuestDDs += 1
											ElseIf (iRemDev == -2) ;Locked device
												iHasLockedDDs += 1
											ElseIf (iRemDev > 0)
												If (!iDelL && bPluckL)
													StorageUtil.StringListAdd(aSlave, sLiPl, sStr)
												EndIf	
												If (orCont)
													iDDeUtil.Log("iDDeEquipRenStrList(): ", "Moving [" +sEqp+ "] from [" +saSlave+ "] to [" +sCont+ "].")
													aSlave.RemoveItem(arInv, 1, True, orCont)
												EndIf
												iRet += 1
											EndIf
									Else
										iDDeUtil.Log("iDDeEquipRenStrList(): ", "[" +sEqp+ "] is already unequipped!")
									EndIf			
							EndIf	
						Else
							iDDeUtil.Log("iDDeEquipRenStrList(): ", "Inventory DD is [" +arInv+ "]!")
							iDDeUtil.Log("iDDeEquipRenStrList(): ", "Rendered DD is [" +arRen+ "]!")
							iDDeUtil.Log("iDDeEquipRenStrList(): ", "Keyword is [" +keDev+ "]!")
						EndIf	
				Else
					iDDeUtil.Log("iDDeEquipRenStrList(): ", "sStr = [" +sStr+ "].")
				EndIf
			i += 1
		EndWhile
		If (iRet)
			If (iDelL)
				If (iDelL >= 2)
					iDDeUtil.Log("iDDeEquipRenStrList(): ", "Clearing the form [" +sList+ "] list.")
						StorageUtil.FormListClear(aSlave, sList)
					iDelL -= 2
				EndIf 
				If (iDelL >= 1)
					iDDeUtil.Log("iDDeEquipRenStrList(): ", "Clearing the string [" +sList+ "] list.")
						StorageUtil.StringListClear(aSlave, sList)
					iDelL -= 1
				EndIf
			ElseIf (bPluckL)
				i = StorageUtil.StringListCount(aSlave, sLiPl)
					While (i > 0)
						i -= 1
						StorageUtil.StringListRemove(aSlave, sList, StorageUtil.StringListGet(aSlave, sLiPl, i), False)
					EndWhile
				StorageUtil.StringListClear(aSlave, sLiPl)
			EndIf
			If (bEqp && (iDDeBinderEff > 0))
				iDDeEqpMagicalArmbinder(aSlave, 1, 7)
			ElseIf (!bEqp && !aSlave.WornHasKeyword(ZadLib.zad_DeviousHeavyBondage))
				iDDeEqpMagicalArmbinder(aSlave, 0, 1)
			EndIf 
			If (bEqp && ((StorageUtil.GetIntValue(aSlave, "iDDeAnklesEff", 0) > 0) || (StorageUtil.GetIntValue(aSlave, "iDDeAnklesEffBypass", 0) > 0)))
				iDDeEqpMagicalAnkles(aSlave, 1, 1)
			Else
				iDDeEqpMagicalAnkles(aSlave, 0, 1)
			EndIf 
		EndIf 
		If (iHasLockedDDs > 0)
			iDDeUtil.Log("iDDeEquipRenStrList(): ", "[" +saSlave+ "] has [" +iHasLockedDDs+ "] locked DDs, which were not removed!", 3, 1)
		EndIf
		If (iHasQuestDDs > 0)
			iDDeUtil.Log("iDDeEquipRenStrList(): ", "[" +saSlave+ "] has [" +iHasQuestDDs+ "] quest DDs, which were not removed!", 3, 1)
		EndIf
	iDDeUtil.Log("iDDeEquipRenStrList(): ", "Done! Devices processed [" +iRet+ "].")
	RETURN iRet
EndFunction
INT Function SetFormLiToRenStrLi(Actor aSlave, STRING sList = "iDDeNoName", INT idx = -1)
;It will take a list of DDs and will make a str list containing the Name, Inv, Ren, Kwd. 
;One containing the corresponding inventory DDs, named 'sList_Inv'. 
;Second containing the corresponding rendered DDs, named 'sList_Ren'.
;Third containing the corresponding keywords, named 'sList_Kwd".
	iDDeUtil.Log("SetFormLiToRenStrLi(): ", "Start!")
	INT iRet = 0
	INT i = 0
	INT iMax = StorageUtil.FormListCount(aSlave, sList)
	StorageUtil.StringListClear(aSlave, sList)
	STRING sDev = ""
	STRING sActor = iDDeGetName(aSlave, "Global")
	iDDeUtil.Log("SetFormLiToRenStrLi(): ", "For [" +sActor+ "].") 
	iDDeUtil.Log("SetFormLiToRenStrLi(): ", "[" +sList+ "] has a total of [" +iMax+ "] DDs listed.")
	iDDeUtil.Log("SetFormLiToRenStrLi(): ", "The idx is [" +idx+ "].")
		If ((idx > -1) && (idx < iMax))
			i = idx
			iMax = (idx + 1)
		EndIf
		While (i < iMax)
			sDev = SetDevToStr(akDev = StorageUtil.FormListGet(aSlave, sList, i))
				If (sDev)
					iRet += ((StorageUtil.StringListAdd(aSlave, sList, sDev, False) > -1) AS INT)
				EndIf	
			i += 1
		EndWhile		
	iDDeUtil.Log("SetFormLiToRenStrLi(): ", "String [" +sList+ "] list has a total of [" +StorageUtil.StringListCount(aSlave, sList)+ "] DDs listed.")
	iDDeUtil.Log("SetFormLiToRenStrLi(): ", "Form [" +sList+ "] list has a total of [" +StorageUtil.FormListCount(aSlave, sList)+ "] DDs listed.")
	iDDeUtil.Log("SetFormLiToRenStrLi(): ", "Done! Devices processed [" +iRet+ "].")	
	RETURN iRet		
EndFunction	
STRING Function SetDevToStr(Form akDev = None)
	STRING sRet = ""
		If (akDev)
			ObjectReference orDev = PlayerRef.PlaceAtMe(akDev, abInitiallyDisabled = True)
				zadEquipScript zadDev = (orDev AS zadEquipScript)
					If (zadDev)
						sRet = ("Name=|" +iDDeGetObjName(akDev)+ "|," + \
										iSUmUtil.SetFormToStr(akForm = zadDev.deviceInventory, sFail = "", sLabel = "Inv") + \
										iSUmUtil.SetFormToStr(akForm = zadDev.deviceRendered, sFail = "", sLabel = "Ren") + \
										iSUmUtil.SetFormToStr(akForm = zadDev.zad_DeviousDevice, sFail = "", sLabel = "Kwd"))
					EndIf	
				orDev.Delete()
		EndIf
	RETURN sRet
EndFunction 		 
INT Function iDDeManDDsByKeyword(Actor aSlave, Keyword kw, BOOL bEquip, BOOL b86 = False, INT iRemQ = 0, BOOL bSkipE = False, BOOL bSkipM = False)
	INT iRet = 0
	INT i = aSlave.GetNumItems()
	STRING sList = "iDDeManDDsByKeyword"
		If (kw && aSlave)
			StorageUtil.FormListClear(aSlave, sList)
			While ((i > 0) && (iRet == 0))
				Form kForm = aSlave.GetNthForm(i)
					If (kForm && (kForm.HasKeyword(ZadLib.zad_InventoryDevice) && (((aSlave.IsEquipped(kForm) || aSlave != PlayerRef) && !bEquip) || (!aSlave.IsEquipped(kForm) && bEquip))))
						StorageUtil.FormListAdd(aSlave, sList, kForm, False)
						iRet += 1
					EndIf
				i -= 1
			EndWhile
		EndIf
		If (iRet > 0)
			If (!bEquip)
				iRet = (0 - iRet)
			EndIf
			iRet = iDDeEquipFormList(aSlave = aSlave, sList = sList, iDDs = iRet, b86 = b86, bRemQ = iRemQ, iDelL = 4, bPluckL = False, idx = -7, orCont = None, bSkipO = False, bSkipE = bSkipE, bSkipM = bSkipM)
		EndIf	
	RETURN iRet
EndFunction 
INT Function iDDeEquipDevice(Actor aSlave, Armor Device_Inv, Armor Device_Ren, Keyword Device_Kw, BOOL bSkipEvents = False, BOOL bSkipMutex = False); From ZadLibs.
	STRING sDevice_Inv = ("[" +iDDeGetObjName(Device_Inv)+ "]")
	iDDeUtil.Log("iDDeEquipDevice():-> ", "EquipDevice() called for [" +sDevice_Inv+ "].")
		If (ZadLib.GetVersion() > 11)
			ZadLib.LockDevice(akActor = aSlave, deviceInventory = Device_Inv, force = False)
		Else
			If (!bSkipMutex)
				ZadLib.AcquireAndSpinlock()
				iDDeUtil.Log("iDDeEquipDevice():-> ", "Acquired mutex, equipping [" +sDevice_Inv+ "].")
			EndIf
			ZadLib.ReEquipExistingDevice(aSlave, Device_Kw)
			If (ZadLib.WearingConflictingDevice(aSlave, Device_Ren, Device_Kw))
				iDDeUtil.Log("iDDeEquipDevice():-> ", "EquipDevice() called for one device, while already wearing another: [" +Device_Kw+ "].")
				If (!bSkipMutex)
					ZadLib.DeviceMutex = False
				EndIf
				RETURN 0
			EndIf
			If (aSlave.GetItemCount(Device_Inv) < 1)
				aSlave.AddItem(Device_Inv, 1, True)
			EndIf
			If (bSkipEvents)
				aSlave.EquipItem(Device_Inv, False, True)
				aSlave.EquipItem(Device_Ren, True, True)
				If (!bSkipMutex)
					ZadLib.DeviceMutex = False
				EndIf
			Else
				aSlave.EquipItemEx(Device_Inv, 0, False, True)
			Endif
			;DeviceMutex is unlocked in zadEquipScript
		EndIf
	RETURN (aSlave.IsEquipped(Device_Inv) AS INT)
EndFunction
INT Function iDDeRemoveDevice(Actor aSlave, Armor Device_Inv, Armor Device_Ren, Keyword Device_Kw, BOOL bRemQuest = False, BOOL b86DD = False, BOOL bSkipEvents = False, BOOL bSkipMutex = False); From ZadLibs.
	STRING sDevice_Inv = ("[" +iDDeGetObjName(Device_Inv)+ "]")
	iDDeUtil.Log("iDDeRemoveDevice():-> ", "RemoveDevice() called for [" +sDevice_Inv+ "].")
		If (!aSlave.IsEquipped(Device_Inv) && !aSlave.IsEquipped(Device_Ren))
			iDDeUtil.Log("iDDeRemoveDevice():-> ", "[" +sDevice_Inv+ "] is not currently worn.")
			RETURN 0
		EndIf
		If (!bRemQuest && (Device_Ren.HasKeyword(ZadLib.zad_QuestItem) || Device_Inv.HasKeyword(ZadLib.zad_QuestItem)))	
			iDDeUtil.Log("iDDeRemoveDevice():-> ", "RemoveDevice denied for [" +sDevice_Inv+ "] because it's a quest item.")
			RETURN -1
		EndIf
		If (ZadLib.GetVersion() > 11)
			ZadLib.UnlockDevice(akActor = aSlave, deviceInventory = Device_Inv, deviceRendered = Device_Ren, zad_DeviousDevice = Device_Kw, destroyDevice = b86DD)
		Else
			If (!bSkipMutex)
				ZadLib.AcquireAndSpinlock()
				iDDeUtil.Log("iDDeRemoveDevice():-> ", "Acquired mutex, removing [" +sDevice_Inv+ "].")
			EndIf
			If (bSkipEvents)
				aSlave.RemoveItem(Device_Ren, 1, True)
				aSlave.UnequipItemEx(Device_Inv, 0, False)
				If (!bSkipMutex)
					ZadLib.DeviceMutex = False
				EndIf
			Else
				StorageUtil.SetIntValue(aSlave, "zad_RemovalToken" +Device_Inv, 1)
				aSlave.UnequipItemEx(Device_Inv, 0, False)
				aSlave.RemoveItem(Device_Ren, 1, True)
					If (aSlave != PlayerRef)
						If ((Device_Kw == ZadLib.zad_DeviousHeavyBondage) || (Device_Kw == ZadLib.zad_DeviousPonyGear) || (Device_Kw == ZadLib.zad_DeviousHobbleSkirt))
							ZadLib.BoundCombat.EvaluateAA(aSlave)
						EndIf		
						If (Device_Kw == ZadLib.zad_DeviousGag)
							ZadLib.RemoveGagEffect(aSlave)
						EndIf
					EndIf
			Endif
			ZadLib.CleanupDevices(aSlave, Device_Kw) 
			If (b86DD)
				aSlave.RemoveItem(Device_Inv, 1, True)
			EndIf
			;DeviceMutex is unlocked in zadEquipScript
		EndIf
	RETURN ((!aSlave.IsEquipped(Device_Inv)) AS INT)
EndFunction
INT Function iDDeRemoveDevice2(Actor aSlave, Armor Device_Inv, Armor Device_Ren, Keyword Device_Kw, BOOL bRemQuest = False, BOOL b86 = False, BOOL bSkipEvents = False, BOOL bSkipMutex = False); From ZadLibs.
	STRING sDevice_Inv = ("[" +iDDeGetObjName(Device_Inv)+ "]")
	Keyword kwdToken = None
	iDDeUtil.Log("iDDeRemoveDevice():-> ", "RemoveDevice() called for [" +sDevice_Inv+ "].")
		If (!aSlave.IsEquipped(Device_Inv) && !aSlave.IsEquipped(Device_Ren))
			iDDeUtil.Log("iDDeRemoveDevice():-> ", "[" +sDevice_Inv+ "] is not currently worn.")
			RETURN 0
		EndIf
		If (Device_Ren.HasKeyword(ZadLib.zad_QuestItem) || Device_Inv.HasKeyword(ZadLib.zad_QuestItem))	
			If (bRemQuest)
				INT iKwds = Device_Ren.GetNumKeywords()
					While ((iKwds > 0) && !kwdToken)
						iKwds -= 1
						kwdToken = Device_Ren.GetNthKeyword(iKwds)
							If (kwdToken && !ZadLib.zadStandardKeywords.HasForm(kwdToken))
								ZadLib.questItemRemovalAuthorizationToken = kwdToken
							Else
								kwdToken = None
							EndIf	
					EndWhile
			Else
				iDDeUtil.Log("iDDeRemoveDevice():-> ", "RemoveDevice denied for [" +sDevice_Inv+ "] because it's a quest item.")
				RETURN -1
			EndIf
		EndIf
		If (ZadLib.GetVersion() > 11)
			If (kwdToken)
				ZadLib.RemoveQuestDevice(akActor = aSlave, deviceInventory = Device_Inv, deviceRendered = Device_Ren, zad_DeviousDevice = Device_Kw, RemovalToken = kwdToken, destroyDevice = b86, skipMutex = bSkipMutex)
			Else
				ZadLib.UnlockDevice(akActor = aSlave, deviceInventory = Device_Inv, deviceRendered = Device_Ren, zad_DeviousDevice = Device_Kw, destroyDevice = b86)
			EndIf
		Else
			If (!bSkipMutex)
				ZadLib.AcquireAndSpinlock()
				iDDeUtil.Log("iDDeRemoveDevice():-> ", "Acquired mutex, removing [" +sDevice_Inv+ "].")
			EndIf
			If (bSkipEvents)
				aSlave.RemoveItem(Device_Ren, 1, True)
				aSlave.UnequipItemEx(Device_Inv, 0, False)
				If (!bSkipMutex)
					ZadLib.DeviceMutex = False
				EndIf
			Else
				StorageUtil.SetIntValue(aSlave, "zad_RemovalToken" +Device_Inv, 1)
				aSlave.UnequipItemEx(Device_Inv, 0, False)
				aSlave.RemoveItem(Device_Ren, 1, True)
					If (aSlave != PlayerRef)
						If ((Device_Kw == ZadLib.zad_DeviousHeavyBondage) || (Device_Kw == ZadLib.zad_DeviousPonyGear) || (Device_Kw == ZadLib.zad_DeviousHobbleSkirt))
							ZadLib.BoundCombat.EvaluateAA(aSlave)
						EndIf		
						If (Device_Kw == ZadLib.zad_DeviousGag)
							ZadLib.RemoveGagEffect(aSlave)
						EndIf
					EndIf
			Endif
			ZadLib.CleanupDevices(aSlave, Device_Kw) 
			If (b86)
				aSlave.RemoveItem(Device_Inv, 1, True)
			EndIf
			;DeviceMutex is unlocked in zadEquipScript
		EndIf
	RETURN ((!aSlave.IsEquipped(Device_Inv)) AS INT)
EndFunction 
INT Function iDDeListWorn(Actor aSlave = None, STRING sList = "iDDeNoName", STRING sMake = "bNew", BOOL bAll = False)
;Will list all DDs worn in an StorageUtil string list.  
;sList  = ""    -> it will make a StorageUtil string list named "iDDeWorn".
;sList != ""    -> it will make a StorageUtil string list named whatever is in sList. 
;sMake  = bNew  -> it will make a new list. 
;sMake  = bClear -> it will clear and delete the sList.
;sMake  = bAppend -> it will append to the existing list.
	iDDeUtil.Log("iDDeListWorn(): ", "Start!")
	INT i = 0
	INT iRet = -1 
	STRING sActor = iDDeGetName(aSlave, "Global")
	STRING sEqp = "No Name"
	Keyword kwID = ZadLib.zad_InventoryDevice
	Form akEqp
		If (aSlave)
			i = aSlave.GetNumItems()
			iDDeUtil.Log("iDDeListWorn(): ", "Triggered on [" +sActor+ "]. List = [" +sList+ "]. Make = [" +sMake+ "], bAll = [" +bAll+ "].")
			iDDeUtil.Log("iDDeListWorn(): ", "[" +sActor+ "] has a total of [" +i+ "] items in the inventory.")	
				If ((sMake == "bClear") || (sMake == "bNew"))
						If (sMake == "bClear")
							iDDeUtil.Log("iDDeListWorn(): ", "Clearing the [" +sList+ "] list!")
							i = -7
						Else
							iDDeUtil.Log("iDDeListWorn(): ", "Clearing the [" +sList+ "] for a new list!")
						EndIf
					StorageUtil.StringListClear(aSlave, sList)
					StorageUtil.FormListClear(aSlave, sList)
				ElseIf (sMake == "bAppend")
					iDDeUtil.Log("iDDeListWorn(): ", "Appending the [" +sList+ "] to the existing list!")
				Else
					iDDeUtil.Log("iDDeListWorn(): ", "Option [" +sMake+ "] is the wrong type, exiting!", 1)
					i = -7
				EndIf	
				While (i > 0)
					i -= 1
					akEqp = aSlave.GetNthForm(i)
						If (akEqp && (akEqp AS Armor) && (bAll || (akEqp.HasKeyword(kwID) && aSlave.IsEquipped(akEqp))))
							ObjectReference orEqp = aSlave.PlaceAtMe(akEqp, abInitiallyDisabled = True)
							zadEquipScript zadEqp = (orEqp AS zadEquipScript)
								If (zadEqp && (aSlave.IsEquipped(zadEqp.deviceRendered) || aSlave.IsEquipped(zadEqp.deviceInventory)))
									sEqp = iDDeGetObjName(akEqp)	
									iDDeUtil.Log("iDDeListWorn(): ", "[" +sEqp+ "] is an equipped DD, adding it to the [" +sList+ "] list!")
									sEqp = ("Name=|" +sEqp+ "|," + \
													iSUmUtil.SetFormToStr(akForm = zadEqp.deviceInventory, sFail = "", sLabel = "Inv") + \
													iSUmUtil.SetFormToStr(akForm = zadEqp.deviceRendered, sFail = "", sLabel = "Ren") + \
													iSUmUtil.SetFormToStr(akForm = zadEqp.zad_DeviousDevice, sFail = "", sLabel = "Kwd"))
									iRet += ((StorageUtil.StringListAdd(aSlave, sList, sEqp, False) > -1) AS INT)
														StorageUtil.FormListAdd(aSlave, sList, akEqp, False)
								EndIf	
							orEqp.Delete()
						EndIf
				EndWhile
		Else
			iDDeUtil.Log("iDDeListWornSlots():-> ", "Error - No actor! Exiting", 1)
		EndIf	
	iDDeUtil.Log("iDDeListWorn(): ", "Added [" +iRet+ "] items.")
	iRet = StorageUtil.StringListCount(aSlave, sList)
	iDDeUtil.Log("iDDeListWorn(): ", "Done! [" +sList+ "] now has [" +iRet+ "] items in it.")
	RETURN iRet
EndFunction	
INT Function iDDeRemoveKeys(Actor aSlave, BOOL bStdKeysOnly = False, ObjectReference akOtherContainer = None) 
	INT iRetBit = -1
	INT iRestrKeys = aSlave.GetItemCount(ZadLib.restraintsKey)
	INT iChastityKeys = aSlave.GetItemCount(ZadLib.ChastityKey)
	INT iPiercTool = aSlave.GetItemCount(ZadLib.PiercingKey)	
		aSlave.RemoveItem(ZadLib.restraintsKey, iRestrKeys, True, akOtherContainer) 
			IDDeDisplayInfo(aSlave, iRestrKeys, "restraints key")	
		aSlave.RemoveItem(ZadLib.ChastityKey, iChastityKeys, True, akOtherContainer) 
			IDDeDisplayInfo(aSlave, iChastityKeys, "chastity key")
		aSlave.RemoveItem(ZadLib.piercingKey, iPiercTool, True, akOtherContainer) 
			IDDeDisplayInfo(aSlave, iPiercTool, "piercing tool")		 
	iRetBit = (iRestrKeys + iChastityKeys + iPiercTool) 	
	RETURN iRetBit
EndFunction 
INT Function iDDeStripToList(Actor aSlave, STRING sList = "", STRING sNoStrip = "", INT iStrip = 0, BOOL bRem = False, BOOL bRemDDs = False, BOOL Anim = False)
;Will strip worn slots from aSlave to sList.
;iStrip > 0 will strip.
;iStrip < 0 will equip.
;iStrip = 0 will do nothing.
;sList = "" will unequip only and will not remove.
;bRem -> enables armor removal feature.  
	iDDeUtil.Log("iDDeStripToList():-> ", "Start!")
	INT iRet = 0
	INT i = 32
	INT j = 0
	INT iType = 0
	STRING sActor = iDDeGetObjName(aSlave)
	STRING sEqp
	STRING sJson = ""
	BOOL bIsNPC = False
	Form Eqp = None
	Outfit oEqp = None
		If (sNoStrip)
			sJson = iSUmUtil.GetJsonByList(sList = sNoStrip, sFolder = iDDeMCM.GetPathFolder(sPath = "Glo", sFolder = "Forms"))
		EndIf
		If (!aSlave)
			iDDeUtil.Log("iDDeStripToList():-> ", "[" +sActor+ "] is no actor!")
			RETURN 0
		ElseIf (iStrip == 0)
			iDDeUtil.Log("iDDeStripToList():-> ", "iStrip = [" +iStrip+ "]. Ignoring call!")
			RETURN 0
		Else
			bIsNPC = (aSlave != PlayerRef)
			iDDeUtil.Log("iDDeStripToList():-> ", "Working on [" +sActor+ "]!")
				If (iStrip < 0) 
					i = StorageUtil.FormListCount(aSlave, sList)
					j = 2
					iDDe_LvItemTemp.Revert()
					iDDeUtil.Log("iDDeStripToList():-> ", "Form list has [" +i+ "] items.")
				Else
					iSUmUtil.UnequipActorHands(aActor = aSlave, iDrop = 0, foItem = iSUmFakeArrow)
				EndIf	
				If (Anim)
					INT iSex = aSlave.GetLeveledActorBase().GetSex()
					Debug.SendAnimationEvent(aSlave, "Arrok_Undress_G" +iSex)
				EndIf
				If (aSlave.IsWeaponDrawn())
					aSlave.SheatheWeapon()
					WaitMenuMode(1.1)
				EndIf
		EndIf
		While (i > -1)
			If (iStrip < 0)
				i -= 1
				Eqp = StorageUtil.FormListPluck(aSlave, sList, i, None)
			Else
				If (j < 3)
					Eqp = aSlave.GetEquippedObject(j)
					j += 1
				Else
					i -= 1
					Eqp = aSlave.GetWornForm(Armor.GetMaskForSlot(i + 30))
				EndIf	
			EndIf
			If (Eqp)
				sEqp = ("[" +iDDeGetObjName(Eqp)+ "]")
				iType = Eqp.GetType()
				iDDeUtil.Log("iDDeStripToList():-> ", "[" +sEqp+ "] is of type [" +iType+ "]!")
					If (!bRemDDs && iDDeIsDD(Eqp))
						iDDeUtil.Log("iDDeStripToList():-> ", "Skipping DD restraint [" +sEqp+ "].")
					ElseIf (!bRemDDs && Eqp.HasKeyword(iDDeLib.zbfWornDevice))
						iDDeUtil.Log("iDDeStripToList():-> ", "Skipping ZAP restraint [" +sEqp+ "].") 
					ElseIf (!bRemDDs && Eqp.HasKeyword(iDDeLib.SexLabNoStrip))
						iDDeUtil.Log("iDDeStripToList():-> ", "Skipping SL NoStrip [" +sEqp+ "].")
					ElseIf (sNoStrip && sJson && (iSUmUtil.FindFormInJsStrLi(akForm = Eqp, sJson = sJson, sList = sNoStrip) > -1))
						iDDeUtil.Log("iDDeStripToList():-> ", "Skipping [" +sEqp+ "] found in the [" +sNoStrip+ "] no strip list.")
					ElseIf (iStrip < 0)
						If (bIsNPC)
							If (iType == 26) ;Armor
								iSUmUtil.Log("iDDeStripToList():-> ", "Adding [" +sEqp+ "] to the outfit.")
								iDDe_LvItemTemp.AddForm(Eqp, 1, 1)
							ElseIf (iType == 124) ;Outfit
								iSUmUtil.Log("iDDeStripToList():-> ", "Setting the [" +sEqp+ "] as the outfit.")
								oEqp = (Eqp AS Outfit)
							ElseIf (bRem && (aSlave.GetItemCount(Eqp) < 1))
								iSUmUtil.Log("iDDeStripToList():-> ", "[" +sEqp+ "] is not in the inventory, adding...")
								aSlave.AddItem(Eqp, 1, abSilent = True)
							EndIf
						EndIf
						If ((iType == 22) && (j > 0)) ;Spell
							j -= 1
							iSUmUtil.Log("iDDeStripToList():-> ", "[" +sEqp+ "] is a spell, equipping...")
							aSlave.EquipSpell((Eqp AS Spell), j)
						Else
							iSUmUtil.Log("iDDeStripToList():-> ", "Equipping the [" +sEqp+ "].")
							aSlave.EquipItemEx(Eqp, 0, False, False)		
						EndIf  
						iRet += 1						
					Else
						aSlave.UnequipItem(Eqp, abPreventEquip = True, abSilent = True)
						iRet += 1
						StorageUtil.FormListAdd(aSlave, sList, Eqp, True)
							If ((sList != "") && bRem)
								iDDeUtil.Log("iDDeStripToList():-> ", "Moving [" +sEqp+ "] from [" +sActor+ "] to [" +sList+ "]!")
								aSlave.RemoveItem(Eqp, 1, True)
							Else
								iDDeUtil.Log("iDDeStripToList():-> ", "Stripped [" +sEqp+ "] off [" +sActor+ "] to [" +sList+ "]!")
							EndIf	
					EndIf
			EndIf  
		EndWhile 
		If (bIsNPC)
			If (iStrip > 0)
				oEqp = iDDe_OutfitNaked
			ElseIf (iDDe_LvItemTemp.GetNumForms() > 0)
				oEqp = iDDe_OutfitTemp
			EndIf
			If (oEqp)
				aSlave.SetOutfit(oEqp, False)
				;aSlave.SetOutfit(oEqp, True)
			EndIf
		EndIf
	iDDeUtil.Log("iDDeStripToList():-> ", "Done!... Items manipulated => [" +iRet+ "].")
	RETURN iRet
EndFunction 
BOOL Function iDDeIsDD(Form Eqp = None)
	RETURN (Eqp && (Eqp.HasKeyword(ZadLib.zad_InventoryDevice) || Eqp.HasKeyword(ZadLib.zad_Lockable) || Eqp.HasKeyword(ZadLib.zad_DeviousPlug))) 
EndFunction
INT Function iDDeRemoveAll(Actor aSlave, ObjectReference akStoreContainer = None, BOOL bWornRestr = False, BOOL Anim = False)
	iDDeUtil.Log("iDDeRemoveAll:-> ", "Start!")
	INT iRet = 0
	INT i = 0
	INT iLot = 0
	BOOL bIsEqp = False
	STRING sActor = "???"
	STRING sEqp = "???"
	STRING sContainer = "Oblivion"
	Form Eqp = None
		If (aSlave)
			i = aSlave.GetNumItems()
			INT iSex = aSlave.GetLeveledActorBase().GetSex()
			sActor = iDDeGetObjName(aSlave)
				If (Anim)
					Debug.SendAnimationEvent(aSlave, "Arrok_Undress_G" +iSex)
				EndIf
				If (akStoreContainer)
					sContainer = iDDeGetObjName(akStoreContainer)
				EndIf
				iDDeUtil.Log("iDDeRemoveAll():-> ", "[" +sActor+ "] has [" +i+ "] items in the inventory.")
					While (i > 0)
						i -= 1
						Eqp = aSlave.GetNthForm(i)
							If (Eqp)
								sEqp = iDDeGetObjName(Eqp)
								iLot = aSlave.GetItemCount(Eqp)
								bIsEqp = aSlave.IsEquipped(Eqp)
									If (iLot > 0)
										If (bIsEqp && iDDeIsDD(Eqp))
											iDDeUtil.Log("iDDeRemoveAll():-> ", "Skipping worn DD [" +sEqp+ "] from index [" +i+ "].")
										ElseIf (!bWornRestr && bIsEqp && Eqp.HasKeyword(iDDeLib.zbfWornDevice))
											iDDeUtil.Log("iDDeRemoveAll():-> ", "Skipping worn restraint [" +sEqp+ "] from index [" +i+ "].") 
										ElseIf (!bWornRestr && bIsEqp && Eqp.HasKeyword(iDDeLib.SexLabNoStrip))
											iDDeUtil.Log("iDDeRemoveAll():-> ", "Skipping SL NoStrip [" +sEqp+ "] from index [" +i+ "].")
										Else
											aSlave.RemoveItem(Eqp, iLot, True, akStoreContainer)
											iDDeUtil.Log("iDDeRemoveAll():-> ", "Moving [" +iLot+ "] x [" +sEqp+ "] to [" +sContainer+ "]!")
											iRet += 1
										EndIf
									EndIf
							EndIf
					EndWhile
		Else
			iDDeUtil.Log("iDDeRemoveAll():-> ", "No valid actor, aborting!")
		EndIf
	iDDeUtil.Log("iDDeRemoveAll():-> ", "Done! ... No. items removed => [" +iRet+ "].")
	RETURN iRet
EndFunction
;rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
  
;Keyword Functions
;kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
INT iDDsKwStored
KEYWORD Function iDDeGetWornKwd(Actor aSlave = None, INT iKw = -1)
;Returns the first worn DD keyword.
;if iKw > 0 will return the kw at iKw index.
;if iKw < 0 will start at index 1 and stop at first worn kw or at the end of the list.
;if iKw = 0 will start at the previous index and stop at first worn kw or at the end of the list. 
	INT idx = 0
		If (!aSlave)
			iDDeUtil.Log("iDDeGetWornKwd():-> ", "No slave.")
			RETURN None
		EndIf
		If (iKw > 0)
			idx = iKw
		ElseIf (iKw < 0)
			idx = iDDeHasWornDDs(aSlave, 1)
		ElseIf (iKw == 0)
			idx = iDDeHasWornDDs(aSlave, iDDsKwStored)
			iDDsKwStored = idx
		EndIf				
	RETURN (iDDeLib.kDDeKwdsAll[idx]) 
EndFunction 
BOOL Function iDDeWornHasStr(Actor aSlave = None, STRING sKwd = "")
	RETURN iDDeGetWornKwdByStr(aSlave, sKwd) AS BOOL
EndFunction
INT Function ListWornDDsRen(Actor aSlave = None, STRING sList = "iDDeWornDDs_Ren")
	StorageUtil.FormListClear(aSlave, sList)
		If (aSlave && (aSlave.WornHasKeyword(ZadLib.zad_Lockable) || aSlave.WornHasKeyword(ZadLib.zad_DeviousPlug)))
			INT i = 32
			Form akEqp = None
				While (i > 0)
					i -= 1
					akEqp = aSlave.GetWornForm(Armor.GetMaskForSlot(i + 30))
						If (akEqp && (akEqp.HasKeyword(ZadLib.zad_Lockable) || akEqp.HasKeyword(ZadLib.zad_DeviousPlug)))
							StorageUtil.FormListAdd(aSlave, sList, akEqp, False)
						EndIf
				EndWhile	
		EndIf
	RETURN StorageUtil.FormListCount(aSlave, sList)
EndFunction
STRING Function ListWornDDeStrKwds(Actor aSlave = None, STRING sList = "") ;iDDeWornDDs_sKwd
	STRING sRet = ""
	INT i = 1
	INT iMax = (iDDeLib.kDDeKwdsAll).Length
		If (!aSlave)
			iDDeUtil.Log("ListWornDDeStrKwds():-> ", "No slave.")
			RETURN ""
		EndIf
		If (iMax && sList)
			StorageUtil.StringListClear(aSlave, sList)
		EndIf
		While (i < iMax)
			If (iDDeLib.kDDeKwdsAll[i] && aSlave.WornHasKeyword(iDDeLib.kDDeKwdsAll[i]))
				sRet = iSUmUtil.StrAddElement(sRet, iDDeLib.sDDeKwdsAll[i], ",")
					If (sList)
						StorageUtil.StringListAdd(aSlave, sList, iDDeLib.sDDeKwdsAll[i], False)
					EndIf
			EndIf
			i += 1
		EndWhile
	RETURN sRet
EndFunction
INT Function iDDeHasWornDDs(Actor aSlave = None, INT idx = 0)
;Checks if aSlave is wearing any DD's.
;idx > 0 will return if that index is worn. 
;idx <= 0 will return the first worn index. 
;Returns -1 if no DD worn.
	If (aSlave)
		INT iMax = iDDeLib.kDDeKwdsAll.Length
			If ((idx > 0) && (idx < iMax)) 
				iMax = (idx + 1)
			Else
				idx = 1
			EndIf
			While (idx < iMax)
				If (iDDeLib.kDDeKwdsAll[idx] && aSlave.WornHasKeyword(iDDeLib.kDDeKwdsAll[idx])) 
					RETURN idx
				EndIf
				idx += 1
			EndWhile
	EndIf
	RETURN -1 
EndFunction
KEYWORD Function iDDeGetKwdByStr(STRING sKwd = "None")
	If (sKwd)
		INT idx = (iDDeLib.sDDeKwdsAll).Find(sKwd)
			If (idx > -1)
				RETURN iDDeLib.kDDeKwdsAll[idx]
			EndIf
	EndIf
	RETURN None
EndFunction
KEYWORD Function iDDeGetWornKwdByStr(Actor aSlave = None, STRING sKwd = "")
	If (sKwd && aSlave)
		KEYWORD Kwd = iDDeGetKwdByStr(sKwd)
			If (Kwd && aSlave.WornHasKeyword(Kwd))
				RETURN Kwd
			EndIf
	EndIf 
	RETURN None
EndFunction
STRING Function iDDeGetWornStrByStr(Actor aSlave = None, STRING sKwd = "")
	If (sKwd && aSlave)
		KEYWORD Kwd = iDDeGetKwdByStr(sKwd)
			If (Kwd && aSlave.WornHasKeyword(Kwd))
				RETURN sKwd
			EndIf
	EndIf
	RETURN "" 
EndFunction
INT Function iDDeGetTagsDD(Actor aSlave, STRING sList = "iDDeTagDevice", STRING sTags = "", STRING sDivider = ",")
;Will fill a StoreUtil form list named sList with DDs, found by tags. 
;All tags have to be divided by sDivider.
;Each DD is obtained by a tag pair i.e. tags 0 and 1 will get the first device, 2 and 3 the second ... etc.
	iDDeUtil.Log("iDDeGetTagDevice():-> ", "Start!")
	StorageUtil.FormListClear(aSlave, sList)
	STRING[] sDevTypes = PapyrusUtil.StringSplit(sTags, sDivider)
	INT iDev = 0
	INT iType = 1
	INT iRet = 0
	INT iDDeDevType = -1
	INT iDDxDevType = -1
	INT iCDxDevType = -1
	INT iDevTypes = sDevTypes.Length
	Form Eqp
	iDDeUtil.Log("iDDeGetTagsDD():-> ", "DD list name is [" +sList+ ". Found [" +iDevTypes+ "] tags.")
	iDDeUtil.Log("iDDeGetTagsDD():-> ", "Tags list -> [" +sTags+ "].")
		While (iType < iDevTypes)
			Eqp = None
			iDDeUtil.Log("iDDeGetTagsDD():-> ", "Tag [" +iDev+ "] is [" +sDevTypes[iDev]+ "].")
			iDDeUtil.Log("iDDeGetTagsDD():-> ", "Tag [" +iType+ "] is [" +sDevTypes[iType]+ "].")
				If (sDevTypes[iDev] == "Gag")
					iDDeDevType = (iDDeLib.sDDeGags).Find(sDevTypes[iType])
					iDDxDevType = (iDDeLib.sDDxGags).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDeGags[iDDeDevType]
						ElseIf (iDDxDevType > 0)
							Eqp = iDDeLib.DDxGags[iDDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Hood")
					iDDeDevType = (iDDeLib.sDDeHoods).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDeHoods[iDDeDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Collar")
					iDDeDevType = (iDDeLib.sDDeCollars).Find(sDevTypes[iType])
					iDDxDevType = (iDDeLib.sDDxCollars).Find(sDevTypes[iType])
					iCDxDevType = (iDDeLib.sCDxCollars).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDeCollars[iDDeDevType]
						ElseIf (iDDxDevType > 0)
							Eqp = iDDeLib.DDxCollars[iDDxDevType]
						ElseIf (iCDxDevType > 0)
							Eqp = iDDeLib.CDxCollars[iCDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Bra")
					iDDeDevType = (iDDeLib.sDDeBras).Find(sDevTypes[iType])
					iDDxDevType = (iDDeLib.sDDxBras).Find(sDevTypes[iType])
					iCDxDevType = (iDDeLib.sCDxBras).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDeBras[iDDeDevType]
						ElseIf (iDDxDevType > 0)
							Eqp = iDDeLib.DDxBras[iDDxDevType]
						ElseIf (iCDxDevType > 0)
							Eqp = iDDeLib.CDxBras[iCDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Nipple Piercings")
					iDDxDevType = (iDDeLib.sDDxPieN).Find(sDevTypes[iType])
						If (iDDxDevType > 0)
							Eqp = iDDeLib.DDxPieN[iDDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Vaginal Piercing")
					iDDxDevType = (iDDeLib.sDDxPieV).Find(sDevTypes[iType])
						If (iDDxDevType > 0)
							Eqp = iDDeLib.DDxPieV[iDDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Arm Cuffs")
					iDDeDevType = (iDDeLib.sDDeCuffsA).Find(sDevTypes[iType])
					iDDxDevType = (iDDeLib.sDDxCuffsA).Find(sDevTypes[iType])
					iCDxDevType = (iDDeLib.sCDxCuffsA).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDeCuffsA[iDDeDevType]
						ElseIf (iDDxDevType > 0)
							Eqp = iDDeLib.DDxCuffsA[iDDxDevType]
						ElseIf (iCDxDevType > 0)
							Eqp = iDDeLib.CDxCuffsA[iCDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Leg Cuffs")
					iDDeDevType = (iDDeLib.sDDeCuffsL).Find(sDevTypes[iType])
					iDDxDevType = (iDDeLib.sDDxCuffsL).Find(sDevTypes[iType])
					iCDxDevType = (iDDeLib.sCDxCuffsL).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDeCuffsL[iDDeDevType]
						ElseIf (iDDxDevType > 0)
							Eqp = iDDeLib.DDxCuffsL[iDDxDevType]
						ElseIf (iCDxDevType > 0)
							Eqp = iDDeLib.CDxCuffsL[iCDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "ElbowBinder")
					iDDeDevType = (iDDeLib.sDDeElbowBinders).Find(sDevTypes[iType])
					iDDxDevType = (iDDeLib.sDDxElbowBinders).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDeElbowBinders[iDDeDevType]
						ElseIf (iDDxDevType > 0)
							Eqp = iDDeLib.DDxElbowBinders[iDDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "ArmBinder")
					iDDeDevType = (iDDeLib.sDDeArmBinders).Find(sDevTypes[iType])
					iDDxDevType = (iDDeLib.sDDxArmBinders).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDeArmBinders[iDDeDevType]
						ElseIf (iDDxDevType > 0)
							Eqp = iDDeLib.DDxArmBinders[iDDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Yoke")
					iDDeDevType = (iDDeLib.sDDeYokes).Find(sDevTypes[iType])
					iDDxDevType = (iDDeLib.sDDxYokes).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDeYokes[iDDeDevType]
						ElseIf (iDDxDevType > 0)
							Eqp = iDDeLib.DDxYokes[iDDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Shackles")
					iDDeDevType = (iDDeLib.sDDeShackles).Find(sDevTypes[iType])
					iDDxDevType = (iDDeLib.sDDxShackles).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDeShackles[iDDeDevType]
						ElseIf (iDDxDevType > 0)
							Eqp = iDDeLib.DDxShackles[iDDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Pet Suit")
					iDDeDevType = (iDDeLib.sDDePetSuits).Find(sDevTypes[iType])
					iDDxDevType = (iDDeLib.sDDxPetSuits).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDePetSuits[iDDeDevType]
						ElseIf (iDDxDevType > 0)
							Eqp = iDDeLib.DDxPetSuits[iDDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Boxbinder")
					iDDeDevType = (iDDeLib.sDDeBoxBinders).Find(sDevTypes[iType])
					iDDxDevType = (iDDeLib.sDDxBoxBinders).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDeBoxBinders[iDDeDevType]
						ElseIf (iDDxDevType > 0)
							Eqp = iDDeLib.DDxBoxBinders[iDDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Boxbinder Outfit")
					iDDeDevType = (iDDeLib.sDDeBoxBinderOuts).Find(sDevTypes[iType])
					iDDxDevType = (iDDeLib.sDDxBoxBinderOuts).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDeBoxBinderOuts[iDDeDevType]
						ElseIf (iDDxDevType > 0)
							Eqp = iDDeLib.DDxBoxBinderOuts[iDDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Belt")
					iDDeDevType = (iDDeLib.sDDeBelts).Find(sDevTypes[iType])
					iDDxDevType = (iDDeLib.sDDxBelts).Find(sDevTypes[iType])
					iCDxDevType = (iDDeLib.sCDxBelts).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDeBelts[iDDeDevType]
						ElseIf (iDDxDevType > 0)
							Eqp = iDDeLib.DDxBelts[iDDxDevType]
						ElseIf (iCDxDevType > 0)
							Eqp = iDDeLib.CDxBelts[iCDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Harness")
					iDDeDevType = (iDDeLib.sDDeHarness).Find(sDevTypes[iType])
					iDDxDevType = (iDDeLib.sDDxHarness).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDeHarness[iDDeDevType]
						ElseIf (iDDxDevType > 0)
							Eqp = iDDeLib.DDxHarness[iDDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Anal Plug")
					iDDeDevType = (iDDeLib.sDDePlugsA).Find(sDevTypes[iType])
					iDDxDevType = (iDDeLib.sDDxPlugsA).Find(sDevTypes[iType])
					iCDxDevType = (iDDeLib.sCDxPlugsA).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDePlugsA[iDDeDevType]
						ElseIf (iDDeDevType > 0)
							Eqp = iDDeLib.DDePlugsA[iDDeDevType]
						ElseIf (iCDxDevType > 0)
							Eqp = iDDeLib.CDxPlugsA[iCDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Vaginal Plug")
					iDDeDevType = (iDDeLib.sDDePlugsV).Find(sDevTypes[iType])
					iDDxDevType = (iDDeLib.sDDxPlugsV).Find(sDevTypes[iType])
					iCDxDevType = (iDDeLib.sCDxPlugsV).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDePlugsV[iDDeDevType]
						ElseIf (iDDxDevType > 0)
							Eqp = iDDeLib.DDxPlugsV[iDDxDevType]
						ElseIf (iCDxDevType > 0)
							Eqp = iDDeLib.CDxPlugsV[iCDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Corset")
					iDDxDevType = (iDDeLib.sDDxCorsets).Find(sDevTypes[iType])
						If (iDDxDevType > 0)
							Eqp = iDDeLib.DDxCorsets[iDDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Gloves")
					iDDeDevType = (iDDeLib.sDDeGloves).Find(sDevTypes[iType])
					iDDxDevType = (iDDeLib.sDDxGloves).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDeGloves[iDDeDevType]
						ElseIf (iDDxDevType > 0)
							Eqp = iDDeLib.DDxGloves[iDDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Boots")
					iDDeDevType = (iDDeLib.sDDeBoots).Find(sDevTypes[iType])
					iDDxDevType = (iDDeLib.sDDxBoots).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDeBoots[iDDeDevType]
						ElseIf (iDDxDevType > 0)
							Eqp = iDDeLib.DDxBoots[iDDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Suit")
					iDDeDevType = (iDDeLib.sDDeSuits).Find(sDevTypes[iType])
					iDDxDevType = (iDDeLib.sDDxSuits).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDeSuits[iDDeDevType]
						ElseIf (iDDxDevType > 0)
							Eqp = iDDeLib.DDxSuits[iDDxDevType]
						EndIf
				ElseIf (sDevTypes[iDev] == "Blindfold")
					iDDeDevType = (iDDeLib.sDDeBlindFolds).Find(sDevTypes[iType])
					iDDxDevType = (iDDeLib.sDDxBlindFolds).Find(sDevTypes[iType])
						If (iDDeDevType > 0)
							Eqp = iDDeLib.DDeBlindFolds[iDDeDevType]
						ElseIf (iDDxDevType > 0)
							Eqp = iDDeLib.DDxBlindFolds[iDDxDevType]
						EndIf
				EndIf
				If (Eqp)
					StorageUtil.FormListAdd(aSlave, sList, Eqp, False)
				Else
					iDDeUtil.Log("iDDeGetTagsDD():-> ", "Could not find a device with the given tag pair. Check spelling!", 1)
				EndIf
			iDev += 2
			iType += 2
		EndWhile		 
	iRet = StorageUtil.FormListCount(aSlave, sList)
	iDDeUtil.Log("iDDeGetTagsDD():-> ", "Done! [" +sList+ "] list has => [" +iRet+ "] items in it.")
	RETURN iRet
EndFunction
INT Function iDDeFilterListByKwds(Actor aSlave, STRING sList = "iDDeNoName", STRING sKwdList = "iDDeKwds", STRING sOpt = "")
;It will filter devices in the given sList by using the (sKwdList) keywords.
;iDDs -> will control the direction the list is made. [-] will start at the end.
;bNoMatch -> will filter the sList by matching (or not) the sKwdList, i.e. the final list will only have the not/matching keywords.
;bChkAll -> will check all keywords against every single device even after a match. It will destroy (sKwdList) in the process if is set to false. 
;Returns the new rendered list (sList) length. 
	iDDeUtil.Log("iDDeFilterListByKwds(): ", "Start!")
	INT iRet = 0
	INT iKwd = StorageUtil.FormListCount(aSlave, sKwdList)
	INT i = 0
	BOOL bMatch = (StringUtil.Find(sOpt, "bNoMatch") < 0) ;True
	BOOL bChkAll = (StringUtil.Find(sOpt, "bChkAll") > -1) ;False
	BOOL bGot = False
	STRING sRen = ""
	Keyword kwRen = None 
	Keyword kwKwd = None
		If (StringUtil.Find(sOpt, "FormList") > -1)
			i = SetFormLiToRenStrLi(aSlave = aSlave, sList = sList) ;Makes the rendered and inventory string list. 
		Else
			i = StorageUtil.StringListCount(aSlave, sList)
		EndIf
	iDDeUtil.Log("iDDeFilterListByKwds(): ", "Master list is [" +sList+ "].")
	iDDeUtil.Log("iDDeFilterListByKwds(): ", "Keyword list length is [" +iKwd+ "]. Match keywords? [" +bMatch+ "].")
	iDDeUtil.Log("iDDeFilterListByKwds(): ", "Rendered list length is [" +i+ "]. Check all devices? [" +bChkAll+ "].")
		If (iKwd && i)
			While (i > 0)
				i -= 1
				kwRen = (iSUmUtil.GetFormFromStr(sStr = StorageUtil.StringListGet(aSlave, sList, i), akFail = None, sLabel = "Kwd") AS Keyword)
					If (kwRen)
						bGot = False
							While ((iKwd > 0) && !bGot)
								iKwd -= 1
								kwKwd = (StorageUtil.FormListGet(aSlave, sKwdList, iKwd) AS Keyword)
									If (kwKwd == kwRen)
										iDDeUtil.Log("iDDeFilterListByKwds(): ", "[" +i+ "]. The device has keyword [" +kwKwd+ "] from index [" +iKwd+ "].")
										bGot = True
											If (!bChkAll)
												StorageUtil.FormListPluck(aSlave, sKwdList, iKwd, None)
											EndIf
									Else
										iDDeUtil.Log("iDDeFilterListByKwds(): ", "[" +i+ "]. The device does not have the keyword [" +kwKwd+ "] from index [" +iKwd+ "].")
									EndIf
							EndWhile
							If ((bGot && !bMatch) || (!bGot && bMatch))
								iDDeUtil.Log("iDDeFilterListByKwds(): ", "[" +i+ "]. Removing device from list.")
								StorageUtil.StringListPluck(aSlave, sList, i, "")
							EndIf	
						iKwd = StorageUtil.FormListCount(aSlave, sKwdList)
					EndIf
			EndWhile
		Else
			iDDeUtil.Log("iDDeFilterListByKwds():-> ", "Keyword list = [" +iKwd+ "], DDs list = [" +i+ "]. Exiting!", 1)
		EndIf
	iRet = StorageUtil.StringListCount(aSlave, sList)
	iDDeUtil.Log("iDDeFilterListByKwds():-> ", "[" +sList+ "] now has [" +iRet+ "] DDs.")
	iDDeUtil.Log("iDDeFilterListByKwds():-> ", "Done!")	
	RETURN iRet		
EndFunction	
INT Function iDDeStrToKwdList(Actor aSlave, STRING[] sKwds, STRING sList = "iDDeKwds", INT idx = 1)
;It will store a string array of keywords names (sKwds)into a list of keywords (sList) starting at (idx).
	iDDeUtil.Log("iDDeStrToKwdList():-> ", "Start!")
	StorageUtil.FormListClear(aSlave, sList)
	INT iRet = 0
	INT iMax = sKwds.Length
	Keyword Kwd = None
		While (idx < iMax)
			Kwd = iDDeGetKwdByStr(sKwds[idx])
				If (Kwd)
					StorageUtil.FormListAdd(aSlave, sList, Kwd)
				Else
					iDDeUtil.Log("iDDeStrToKwdList():-> ", "String [" +sKwds[idx]+ "] is not a DD keyword.")
				EndIf
			idx += 1
		EndWhile
	iRet = StorageUtil.FormListCount(aSlave, sList)
	iDDeUtil.Log("iDDeStrToKwdList():-> ", "Done! Processed [" +iRet+ "] keywords.")		
	RETURN iRet
EndFunction	
INT Function iDDeStrKwdsToList(Actor aSlave, STRING sList = "iDDsKwds", STRING sKwds = "", STRING sDivider = ",")
;It will store a string of keyword names (sKwds) divided by (sDivider) into a PapyrusUtil keyword list (sList).
	iDDeUtil.Log("iDDeStrKwdsToList():-> ", "Start!")
	STRING[] sKw = PapyrusUtil.StringSplit(sKwds, sDivider)
	INT iRet = iDDeStrToKwdList(aSlave, sKwds = sKw, sList = sList, idx = 0)
	iDDeUtil.Log("iDDeStrKwdsToList():-> ", "Done! [" +sList+ "] list has => [" +iRet+ "] items in it.")
	RETURN iRet
EndFunction	
;kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk

;Actor Functions
;aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
BOOL Function iDDeGotLocked(ObjectReference DDContainer)
	BOOL bReturnBit = False
	 	If (DDContainer.GetItemCount(ZadLib.zad_BlockGeneric) > 0)
	 		bReturnBit = True
		EndIf
	RETURN bReturnBit
EndFunction
BOOL Function iDDeIsInMenu()
	RETURN IsInMenuMode() || UI.IsMenuOpen("Console") || UI.IsMenuOpen("Loading Menu")
EndFunction
STRING Function iDDeGetName(Actor aSlave, STRING sNone = "")
	RETURN iSUmUtil.GetActorName(aSlave, sNone)
EndFunction
Function iDDeEqpMagicalArmbinder(Actor aSlave = None, INT iEqp = 1, INT iDelay = 1)   
	;Something
		If (!aSlave || (aSlave == PlayerRef))
			WaitMenuMode(iDelay AS FLOAT)
				If (!aSlave)
					aSlave = PlayerRef
				EndIf
				If (iEqp)
					If (!aSlave.IsEquipped(iDDeLib.iDDe_MagicalArmBinder) && aSlave.WornHasKeyword(ZadLib.zad_DeviousHeavyBondage))
						iDDeUtil.Log("iDDeEqpMagicalArmbinder():-> ", "Equipping the magical armbinder!")
						aSlave.EquipItem(iDDeLib.iDDe_MagicalArmBinder, abPreventRemoval = True, abSilent = True)
					EndIf
				Else
					iDDeUtil.Log("iDDeEqpMagicalArmbinder():-> ", "Unequipping the magical armbinder!")
					aSlave.RemoveItem(iDDeLib.iDDe_MagicalArmBinder, aSlave.GetItemCount(iDDeLib.iDDe_MagicalArmBinder), True)
				EndIf
		EndIf
EndFunction
Function iDDeEqpMagicalAnkles(Actor aSlave = None, INT iEqp = 1, INT iDelay = 1)   
	;Something
		If (iEqp && (!aSlave.IsEquipped(iDDeLib.iDDe_MagicalAnkles) && (aSlave.WornHasKeyword(ZadLib.zad_DeviousBoots) || aSlave.WornHasKeyword(ZadLib.zad_DeviousLegCuffs) || aSlave.WornHasKeyword(ZadLib.zad_DeviousAnkleShackles))))
			iDDeUtil.Log("iDDeEqpMagicalAnkles():-> ", "Equipping the magical ankles!")
			WaitMenuMode(iDelay AS FLOAT)
			aSlave.EquipItem(iDDeLib.iDDe_MagicalAnkles, abPreventRemoval = True, abSilent = True)
		ElseIf ((iEqp < 0) || (!iEqp && (!aSlave.WornHasKeyword(ZadLib.zad_DeviousBoots) && !aSlave.WornHasKeyword(ZadLib.zad_DeviousLegCuffs) && !aSlave.WornHasKeyword(ZadLib.zad_DeviousAnkleShackles))))
			iDDeUtil.Log("iDDeEqpMagicalAnkles():-> ", "Unequipping the magical ankles!")
			WaitMenuMode(iDelay AS FLOAT)
			aSlave.RemoveItem(iDDeLib.iDDe_MagicalAnkles, aSlave.GetItemCount(iDDeLib.iDDe_MagicalAnkles), True)
			StorageUtil.UnSetIntValue(aSlave, "iDDeAnklesEffBypass")
		EndIf
EndFunction
Function iDDeEnableArmEffects(Actor aSlave = None, INT iEna = 1, INT iAll = 0)
	;Something
		If (!aSlave || (aSlave == PlayerRef))
			;Something
				If (iEna)
					iSUm.DisControlsPC(bMovement = False, bFighting = (iDDeArmFight || iAll), bSneaking = (iDDeArmSneak || iAll), bMenu = (iDDeArmMenu || iAll), \
														 bActivate = (iDDeArmActive || iAll), bTravel = (iDDeArmTravel || iAll), bWaiting = (iDDeArmWait || iAll))
					iDDeDisableArmStruggle(iDDeArmStruggle || iAll)
					iDDeDisableArmTalk(iDDeArmTalk || iAll)
				Else
					iSUm.DisControlsPC(bMovement = False, bFighting = False, bSneaking = False, bMenu = False, bActivate = False, bTravel = False, bWaiting = False)
					iDDeDisableArmStruggle(False)
					iDDeDisableArmTalk(False)
				EndIf
		EndIf
EndFunction
Function iDDeSetMechEffects(Actor aSlave = None, INT iSet = 1, INT iAll = 0)
	;Something
		If (!aSlave || (aSlave == PlayerRef))
			;Something
				If (iSet)
					iSUm.DisControlsPC(bMovement = (iDDeMechNoMove || iAll), bFighting = (iDDeMechNoFighting || iAll), bSneaking = (iDDeMechNoSneak || iAll), \
														 bMenu = (iDDeMechNoMenu || iAll), bActivate = (iDDeMechNoActivate || iAll), bTravel = (iDDeMechNoFastTravel || iAll), \
														 bWaiting = (iDDeMechNoWait || iAll))
				Else
					iSUm.DisControlsPC(bMovement = False, bFighting = False, bSneaking = False, bMenu = False, bActivate = False, bTravel = False, bWaiting = False)
				EndIf
		EndIf
EndFunction 
Function iDDeDisableArmStruggle(BOOL bDisable = True)
	If (bDisable)
		ZadAbq.DisableStruggling()
	Else
		ZadAbq.EnableStruggling()
	EndIf
EndFunction
Function iDDeDisableArmTalk(BOOL bDisable = True)
	If (bDisable)
		ZadAbq.DisableDialogue()
	Else
		ZadAbq.EnableDialogue()
	EndIf
EndFunction
Function iDDeStoreActorsToJson(Actor[] aSlaves, STRING sList = "iDDeStoActors", STRING sJson = "", BOOL bStore = True, INT idx = 0)
	iSUmUtil.StoreActorsToJson(aSlaves, sList, sJson, bStore, idx) 
EndFunction
BOOL Function iDDeIsAnimating(Actor aSlave) 
	RETURN ZadLib.IsAnimating(aSlave)	
EndFunction
INT Function iDDeIsActorMcmReady(Actor aSlave)   
		If (iDDeLib.BeastFormFaction && aSlave.IsInFaction(iDDeLib.BeastFormFaction))
			RETURN 1
		ElseIf (iDDeLib.VampireLordFaction && aSlave.IsInFaction(iDDeLib.VampireLordFaction)) 	
			ReTURN 2
		EndIf
	RETURN 0
EndFunction
;aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa

;Object Functions
;ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
STRING Function iDDeGetNoName(Form Obj, STRING sNoName = "No Name")
	RETURN iSUmUtil.GetFormName(Obj, sNoName = sNoName)
EndFunction
STRING Function iDDeGetObjName(Form Obj = None)
	RETURN iSUmUtil.GetFormName(Obj)
EndFunction
STRING[] Function iDDeGetArrayObjName(Form[] Obj = None)
	RETURN iSUmUtil.GetArrayObjName(Obj)
EndFunction
;ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo

;Utility Functions
;uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu 
BOOL Property bFunctionBusy Auto Hidden
BOOL Function FunctionLock(STRING sFunction = "Default", INT iMax = 222); From zadLibs ;)
;Will stop and que function calls until the current call finishes.
	If (bFunctionBusy)
		iDDeUtil.Log("FunctionLock():-> ", "Queuing [" +sFunction+ "] with a delay of, [" +iMax+ "].")
		INT iTimeout = 0
		While (bFunctionBusy)
			WaitMenuMode(0.1)
			If (iTimeout > iMax)
				iDDeUtil.Log("FunctionLock():-> ", "Timed out.", 1);
				bFunctionBusy = False
			EndIf
			iTimeout += 1
		EndWhile
		iDDeUtil.Log("FunctionLock():-> ", "Now processing [" +sFunction+ "]. Waited [" +iTimeout+ "] cycles.")
	Else
		bFunctionBusy = True ; Immediately reacquire lock
	EndIf
	RETURN bFunctionBusy
EndFunction 
BOOL Property bEventBusy Auto Hidden
BOOL Function EventLock(STRING sEvent = "Default", INT iMax = 333)
;Will stop and que event calls until the current event finishes.
	If (bEventBusy)
		iDDeUtil.Log("EventLock():-> ", "Queuing [" +sEvent+ "] with a delay of, [" +iMax+ "].")
		INT iTimeout = 0
		While (bEventBusy)
			WaitMenuMode(0.1)
			If (iTimeout > iMax)
				iDDeUtil.Log("EventLock():-> ", "Timed out!", 1);
				bEventBusy = False
			EndIf
			iTimeout += 1
		EndWhile
		iDDeUtil.Log("EventLock():-> ", "Now processing [" +sEvent+ "]. Waited [" +iTimeout+ "] cycles.")
	Else
		bEventBusy = True ; Immediately reacquire lock
	EndIf
	RETURN bEventBusy
EndFunction
Function IDDeDisplayInfo(Actor aSlave, INT iDeviceCount = 0, STRING sDeviceName = "")
	STRING saSlave = "???"
	If (aSlave)
		saSlave = aSlave.GetDisplayName()
			If (iDeviceCount > 1) 
				iDDeUtil.Log("", "[" +saSlave+ "] lost [" +iDeviceCount+ "] [" +sDeviceName+ "]s!", 3, 1)
			ElseIf (iDeviceCount <= 0)
				iDDeUtil.Log("", "[" +saSlave+ "] doesn't have any [" +sDeviceName+ "]s! Hardcore!", 3, 1)
			Else 
				If (aSlave.GetActorBase().GetSex() == 1)
					iDDeUtil.Log("", "[" +saSlave+ "] lost her only [" +sDeviceName+ "]!", 3, 1)
				Else
					iDDeUtil.Log("", "[" +saSlave+ "] lost his only [" +sDeviceName+ "]!", 3, 1)
				EndIf
			EndIf
	EndIf
EndFunction 
STRING Function iDDeGetJsonFile(STRING sFolder = "", STRING sName = "", STRING sFile = "")
	STRING sPlayer = PlayerRef.GetDisplayName()
		If ((sFolder == "") || (sName == "PlayerRef"))
			sFolder = sPlayer
		EndIf
		If ((sName == "") || (sName == "PlayerRef"))
			sName = sPlayer
		EndIf
		If (sFile == "")
			sFile = "Stuff"
		EndIf
	RETURN ("../Devious Devices - Equip/" +sFolder+ "/" +sName+ " - " +sFile+ ".json")
EndFunction 
INT Function iDDeMakeJsonList(Actor aSlave = None, STRING sList = "iDDeNoName", STRING sJson = "", STRING sOutfit = "iDDeOutMCM")
	iDDeUtil.Log("iDDeMakeJsonList():-> ", "Start!")
	INT iRet = 0
	STRING sSlave = iDDeGetName(aSlave, "Global")
		If (sJson == "")
			sJson = iDDeGetJsonFile(sSlave, sSlave, "") 
		EndIf	
		If (sOutfit == iDDeLib.sDDeOutMisc[6])
			iDDeListWorn(aSlave = aSlave, sList = sList, sMake = "bNew", bAll = False)
			iDDeStorToJson(aSlave = aSlave, sStorList = sList, sJsonList = sList, sJson = sJson, sOpt = "bClrJsLi,bDup")
		Else
			iDDeFunc.MakeOutfit(aSlave = aSlave, sList = sOutfit, sOutfit = sOutfit, sOpt = "")
			iSUmUtil.FormArrToJsStrList(akForms = iDDeFunc.DDeOutfit, sJson = sJson, sList = sList, sNum = 1, sEqp = "0", sOpt = "bNew,bDup")	
		EndIf	
	iRet = JsonUtil.StringListCount(sJson, sList)
	iDDeUtil.Log("iDDeMakeJsonList():-> ", "Done! Returned -> [" +iRet+ "]!")
	RETURN iRet
EndFunction	
INT Function iDDeAppendList(Actor aSlave = None, STRING sFinalList = "iDDeOutFinNoName", STRING sAddList = "iDDeOutAddNoName")
;Will append given lists together, i.e. "sFinalList + sAddList" = sFinalList. 
	iDDeUtil.Log("iDDeAppendList():-> ", "Start!")
	STRING sActor = iDDeGetName(aSlave, "Global")
	STRING sStr = ""
	INT iFinMax = StorageUtil.StringListCount(aSlave, sFinalList)
	INT iAddMax = StorageUtil.StringListCount(aSlave, sAddList)
	INT iRet = -3
	iDDeUtil.Log("iDDeAppendList():-> ", "For [" +sActor+ "].")
	iDDeUtil.Log("iDDeAppendList():-> ", "List [" +sFinalList+ "] to be appended has [" +iFinMax+ "] items in it.")
	iDDeUtil.Log("iDDeAppendList():-> ", "List [" +sAddList+ "] to be added has [" +iAddMax+ "] items in it.")
		While (iAddMax > 0)
			iAddMax -= 1
			sStr = StorageUtil.StringListGet(aSlave, sAddList, iAddMax)
				If (sStr)
					iDDeUtil.Log("iDDeAppendList():-> ", "Adding item No. [" +(iAddMax + 1)+ "], => [" +sStr+ "] from [" +sAddList+ "] to ["  +sFinalList+ "].")
					StorageUtil.StringListAdd(aSlave, sFinalList, sStr, True)
				Else
					iDDeUtil.Log("iDDeAppendList():-> ", "Item No. [" +(iAddMax + 1)+ "], => is none.")
				EndIf
		EndWhile
	iRet = StorageUtil.StringListCount(aSlave, sFinalList)
	iDDeUtil.Log("iDDeAppendList():-> ", "Done! ... Appended list [" +sFinalList+ "] now has [" +iRet+ "] items in it.")
	RETURN iRet
EndFunction	 
INT Function iDDeCopyList(Actor aSlave = None, STRING sOriList = "iDDeOutFinNoName", STRING sDesList = "iDDeOutAddNoName", STRING sOpt = "bNew")
;Will copy one list to the other.
	iDDeUtil.Log("iDDeCopyList():-> ", "Start!")
	INT iRet = 0
	INT i = 0
	INT iMax = StorageUtil.StringListCount(aSlave, sOriList)
		If (StringUtil.Find(sOpt, "bNew") > -1)
			StorageUtil.StringListClear(aSlave, sDesList)
		EndIf
	iDDeUtil.Log("iDDeCopyList():-> ", "Original list [" +sOriList+ "] has [" +iMax+ "] items in it.")
	iDDeUtil.Log("iDDeCopyList():-> ", "Destination list [" +sDesList+ "] has [" +StorageUtil.StringListCount(aSlave, sDesList)+ "] items in it.")		
		While (i < iMax)
			iRet += ((StorageUtil.StringListAdd(aSlave, sDesList, StorageUtil.StringListGet(aSlave, sOriList, i), True) > -1) AS INT)
			i += 1
		EndWhile
	iDDeUtil.Log("iDDeCopyList():-> ", "Added [" +iRet+ "] items to [" +sDesList+ "].")
	iRet = StorageUtil.StringListCount(aSlave, sDesList)
	iDDeUtil.Log("iDDeCopyList():-> ", "Done!... [" +sDesList+ "] now has [" +iRet+ "] items in it.")
	RETURN iRet
EndFunction	 
INT Function iDDePluckList(Actor aActor = None, STRING sFin = "iDDeOutFinNoName", STRING sRem = "iDDeOutRemNoName")
;Will remove given list from another, i.e. "sFinalList - sRemoveList" = sFinalList.
	iDDeUtil.Log("iDDePluckList():-> ", "Start!")
	STRING sActor = iDDeGetName(aActor, "Global")
	STRING sStr = ""
	INT iFin = StorageUtil.StringListCount(aActor, sFin)
	INT iRem = StorageUtil.StringListCount(aActor, sRem)
	INT iRet = 0
	iDDeUtil.Log("iDDePluckList():-> ", "For [" +sActor+ "],")
	iDDeUtil.Log("iDDePluckList():-> ", "List [" +sFin+ "] to be cleaned has [" +iFin+ "] items in it.")
	iDDeUtil.Log("iDDePluckList():-> ", "List [" +sRem+ "] to be removed has [" +iRem+ "] items in it.")
		While (iRem > 0)
			iRem -= 1
			sStr = StorageUtil.StringListGet(aActor, sRem, iRem)
				If (sStr)
					If (StorageUtil.StringListRemove(aActor, sFin, sStr, allInstances = False))
						iDDeUtil.Log("iDDePluckList():-> ", "[" +(iRem + 1)+ "]. Removed [" +sStr+ "] in [" +sRem+ "] from [" +sFin+ "].")
					Else
						iDDeUtil.Log("iDDePluckList():-> ", "[" +(iRem + 1)+ "]. Could not remove [" +sStr+ "] in [" +sRem+ "] from ["  +sFin+ "].")
					EndIf
				EndIf
		EndWhile
	iRet = StorageUtil.StringListCount(aActor, sFin)
	iDDeUtil.Log("iDDePluckList():-> ", "Done! ... Cleaned list [" +sFin+ "] now has [" +iRet+ "] items in it.")
	StorageUtil.StringListClear(aActor, sRem)
	RETURN iRet
EndFunction	
INT Function iDDePluckKeyword(Actor aSlave = None, STRING sList = "iDDeOutNoName", STRING sKeyWord = "zad_QuestItem")
;Will remove all items containing sKeyWord from sList.
	iDDeUtil.Log("iDDePluckKeyword():-> ", "Start!")
	STRING sActor = iDDeGetName(aSlave, "Global")
	STRING sStr = ""
	INT i = StorageUtil.StringListCount(aSlave, sList)
	INT iRet = -3
	Keyword kwRem = iDDeGetKwdByStr(sKeyWord)
	Form akInv = None
	Form akRen = None
		If (kwRem)
			iDDeUtil.Log("iDDePluckKeyword(): ", "For [" +sActor)
			iDDeUtil.Log("iDDePluckKeyword(): ", "List [" +sList+ "] to be plucked has [" +i+ "] items in it.")
			iDDeUtil.Log("iDDePluckKeyword(): ", "Keyword to remove from list is [" +sKeyWord+ "] as STRING, and [" +iDDeGetObjName(kwRem)+ "] as FORM.")
				While (i > 0)
					i -= 1
					sStr = StorageUtil.StringListGet(aSlave, sList, i)
						If (sStr)
							akInv = iSUmUtil.GetFormFromStr(sStr = sStr, akFail = None, sLabel = "Inv")
							akRen = iSUmUtil.GetFormFromStr(sStr = sStr, akFail = None, sLabel = "Ren")
							sStr = iSUmUtil.StrSlice(sStr = sStr, sSt = "Name=|", sEn = "|,", sFail = "Failed!", sRem = "", idx = 0)
								If (akInv)  
									If (akInv.HasKeyword(kwRem) || akRen.HasKeyword(kwRem))
										If (StorageUtil.StringListRemoveAt(aSlave, sList, i))
											iDDeUtil.Log("iDDePluckKeyword(): ", "Removed [" +sStr+ "] at idx [" +i+ "], from list.")
										Else
											iDDeUtil.Log("iDDePluckKeyword(): ", "Could not remove [" +sStr+ "] at idx [" +i+ "], => from list.")
										EndIf
									Else
										iDDeUtil.Log("iDDePluckKeyword(): ",  "[" +sStr+ "] at idx [" +i+ "], => does not have the keyword [" +sKeyWord+ "].")
									EndIf	
								EndIf
						Else
							iDDeUtil.Log("iDDePluckKeyword(): ",  "[" +sStr+ "] at idx [" +i+ "], => is a none.")
						EndIf	
				EndWhile
		Else
			iDDeUtil.Log("iDDePluckKeyword(): ", "Cannot find the corresponding keyword form for [" +sKeyWord+ "]. Exiting!", 1)
		EndIf			
	iRet = StorageUtil.StringListCount(aSlave, sList)
	iDDeUtil.Log("iDDePluckKeyword(): ", "Done! ... Plucked list [" +sList+ "] now has [" +iRet+ "] items in it.")
	RETURN iRet
EndFunction	
INT Function iDDeStorToJson(Actor aSlave = None, STRING sStorList = "iDDeOutNoName", STRING sJsonList = "iDDeOutNoName", STRING sJson = "", STRING sOpt = "")
;Will save a StorageUtil list to JsonUtil.
	iDDeUtil.Log("iDDeStorToJson(): Start!")
	INT iRet = -3
	STRING sActor = iDDeGetName(aSlave, "Global")
	iDDeUtil.Log("iDDeStorToJson(): For [" +sActor+ "].")
		If (!sJson)
			sJson = iDDeGetJsonFile(sActor, sActor, "") 
		EndIf	
		iRet = iSUmUtil.StFormListToJsStrList(akLiFor = aSlave, sStLi = sStorList, sJson = sJson, sJsLi = sJsonList, sNum = 1, sEqp = 0, sOpt = sOpt)
	iDDeUtil.Log("iDDeStorToJson(): ", "[" +iRet+ "] items were added to the json list [" +sJsonList+ "].")
		iRet = JsonUtil.StringListCount(sJson, sJsonList)
	iDDeUtil.Log("iDDeStorToJson(): ", "Done! ... Json list [" +sJsonList+ "] now has [" +iRet+ "] items in it.")
	RETURN iRet
EndFunction	
INT Function iDDeJsonToStor(Actor aSlave = None, STRING sJsonList = "iDDeOutNoName", STRING sStorList = "iDDeOutNoName", STRING sJson = "", STRING sOpt = "")
;Will save a JsonUtil list to StorageUtil.
	iDDeUtil.Log("iDDeJsonToStor(): Start!")
	INT iRet = -3
	STRING sActor = iDDeGetName(aSlave, "Global")
	iDDeUtil.Log("iDDeJsonToStor(): For [" +sActor+ "].")
		If (!sJson)
			sJson = iDDeGetJsonFile(sActor, sActor, "") 
		EndIf	
		iRet = iSUmUtil.JsStrListToStFormList(akLiFor = aSlave, sStLi = sStorList, sJson = sJson, sJsLi = sJsonList, sOpt = sOpt)
	iDDeUtil.Log("iDDeJsonToStor(): [" +iRet+ "] items were added to the StorageUtil list [" +sStorList+ "].")
		iRet = StorageUtil.FormListCount(aSlave, sStorList)
	iDDeUtil.Log("iDDeJsonToStor(): Done! ...StorageUtil list [" +sStorList+ "] now has [" +iRet+ "] items in it.")
	RETURN iRet
EndFunction	
INT Function iDDeMakeInvList(Actor aSlave = None, STRING sList = "iDDeOutNoName")
	iDDeUtil.Log("iDDeMakeInvList(): ", "Start!")
	INT iRet = 0
	INT i = 0
	INT iMax = aSlave.GetNumItems()
	Form ak = None
	StorageUtil.FormListClear(aSlave, sList)
		While (i < iMax)
			ak = aSlave.GetNthForm(i)
				If (ak && ak.HasKeyword(ZadLib.zad_InventoryDevice))
					StorageUtil.FormListAdd(aSlave, sList, ak, False)
				EndIf
			i += 1
		EndWhile
	iRet = StorageUtil.FormListCount(aSlave, sList)
	iDDeUtil.Log("iDDeMakeInvList(): ", "Done! Returned -> [" +iRet+ "]!")
	RETURN iRet
EndFunction
STRING Function GetFinalList(STRING sList = "")
	INT i = 0
	STRING s = ""
		If ((StringUtil.Find(sList, "[", 0) == 0) && (StringUtil.Find(sList, "]", 1) > 1))
			i = StringUtil.Find(sList, "],", 0)
				If (i > 1)
					s = StringUtil.Substring(sList, (i + 1), 0)
				EndIf
			sList = iSUmUtil.StrSlice(sStr = sList, sSt = "[", sEn = "]")
			STRING[] sLists = PapyrusUtil.StringSplit(sList, ",")
				i = RandomInt(0, (sLists.Length - 1))
				sList = (sLists[i] + s)
		ElseIf ((StringUtil.Find(sList, "(", 0) == 0) && (StringUtil.Find(sList, ")", 1) > 1))
			i = StringUtil.Find(sList, "),", 0)
				If (i > 1)
					s = StringUtil.Substring(sList, (i + 1), 0)
				EndIf
			sList = iSUmUtil.StrSlice(sStr = sList, sSt = "(", sEn = ")")	
			STRING sJson = iSUmUtil.GetJsonByList(sList = sList, sFolder = iDDeMCM.GetPathFolder(sPath = "Glo", sFolder = "Strings"), sType = ".stringList")
				i = RandomInt(0, (JsonUtil.StringListCount(sJson, sList) - 1))
				sList = (JsonUtil.StringListGet(sJson, sList, i) + s)
		EndIf	
	RETURN sList
EndFunction
STRING Function SetStoUtilCurOutfit(Actor aSlave = None, STRING sOutfit = "", INT iSet = 1)
	STRING sCur = StorageUtil.GetStringValue(aSlave, "iDDeOutEqpCur", "")
		If (iSet > 0)
			STRING sPre = StorageUtil.GetStringValue(aSlave, "iDDeOutEqpPre", "")
				If (sOutfit && (sOutfit != sPre) && (sOutfit != iDDeLib.sDDeOutMisc[1]) && sCur && (sCur != sPre))
					StorageUtil.SetStringValue(aSlave, "iDDeOutEqpPre", sCur)
				EndIf
			RETURN StorageUtil.SetStringValue(aSlave, "iDDeOutEqpCur", sOutfit)
		ElseIf (sCur)
			If (!sOutfit || (sOutfit == sCur))
				StorageUtil.SetStringValue(aSlave, "iDDeOutEqpPre", sCur)
				RETURN StorageUtil.UnSetStringValue(aSlave, "iDDeOutEqpCur")
			EndIf
		EndIf
	RETURN ""
EndFunction
STRING Function GetStoUtilCurOutfit(Actor aSlave = None, STRING sOutfit = "")
	RETURN StorageUtil.GetStringValue(aSlave, "iDDeOutEqpCur", sOutfit)
EndFunction
STRING Function GetStoUtilPreOutfit(Actor aSlave = None, STRING sOutfit = "")
	RETURN StorageUtil.GetStringValue(aSlave, "iDDeOutEqpPre", sOutfit)
EndFunction
;uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu

;System Functions
;sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss
Function iDDeLog(STRING sInfoLog = "", STRING sInfoDis = "", INT iLevel = 4, INT iDis = 0) 
	iDDeUtil.Log(sInfoLog = sInfoLog, sInfoDis = sInfoDis, iLevel = iLevel, iDis = iDis)
EndFunction
BOOL Function iDDeGotMod(STRING sFuncName, STRING sModName = "")
	RETURN iSUmUtil.GotMod(sFuncName, sModName)
EndFunction 
INT Function iDDeRegEvents(STRING sEvent = "", INT iDis = 1)
	iDDeUtil.Log("iDDeRegEvents():-> ", sEvent+ "start; iDis = [" +iDis+ "]!", 3)
	iDDeUtil.Log("iDDeRegEvents():-> ", "DDe version No. [" +iDDeUtil.GetSemVerStr()+ "].", 3)
	iDDeUtil.Log("iDDeRegEvents():-> ", "Registering events... Please stand by!", 3, iDis)
	INT iRet = UpdateVariables(iOpt = 1, iDis = iDis)
			iRet += iDDeLoadLibs(iDis)
			iRet += iDDeRegModEvents(True)	
				If (iRet)
					iDDeUtil.Log("iDDeRegEvents():-> ", "Events ready!", 3, iDis)
				Else
					iDDeUtil.Log("iDDeRegEvents():-> ", "Events failed! Reset DDe!", 1, 1)
				EndIf
	RETURN iRet
EndFunction
INT Function iDDeUnRegEvents(STRING sEvent = "", INT iDis = 1)
	iDDeUtil.Log("iDDeUnRegEvents():-> ", sEvent+ "start; iDis = [" +iDis+ "]!")
	iDDeUtil.Log("iDDeUnRegEvents():->", "Unregistering events... Please stand by!", 3, iDis)
	INT iRet = iDDeClearAllLists(None, 1)
		iRet += iDDeResetVariables()
		iRet += iDDeRegModEvents(False)
			If (PlayerRef.HasPerk(iDDe_PerkHeavyBondage) && !PlayerRef.WornHasKeyword(ZadLib.zad_DeviousBondageMittens) && !PlayerRef.WornHasKeyword(ZadLib.zad_DeviousHeavyBondage))
				PlayerRef.RemovePerk(iDDe_PerkHeavyBondage)	
			EndIf 
		WaitMenuMode(5.5)
		iDDeUtil.Log("iDDeUnRegEvents():->", "Events unregistered.", 3, iDis)
	RETURN iRet		
EndFunction
INT Function iDDeRegModEvents(BOOL bReg = True)
	INT iRet = 0
		If (bReg)
			RegisterForModEvent("iDDeEquipWorn", "iDDeOnEquipWorn")
			RegisterForModEvent("iDDeEquipList", "iDDeOnEquipList")
			RegisterForModEvent("iDDeEquipOutfit", "iDDeOnEquipOutfit")
			RegisterForModEvent("iDDeListAllWornDDs", "iDDeOnListAllWornDDs")
			RegisterForModEvent("iDDeLock", "iDDeOnLock")
			RegisterForModEvent("iDDeDone", "iDDeOnDone")
			RegisterForModEvent("iDDeEquipByTags", "iDDeOnEquipByTags")
			RegisterForModEvent("iDDeEquipIdx", "iDDeOnEquipIdx")
			RegisterForModEvent("iDDeLockArmbinder", "iDDeOnLockArmbinder")
			RegisterForModEvent("iDDeStrip", "iDDeOnStrip")
			RegisterForModEvent("iDDeEquipOutfitByKeyword", "iDDeOnEquipOutfitByKeyword")
			RegisterForModEvent("iDDeSetMech", "iDDeOnSetMech")
			iRet += 1
		Else
			UnRegisterForModEvent("iDDeEquipWorn")
			UnRegisterForModEvent("iDDeEquipList")
			UnRegisterForModEvent("iDDeEquipOutfit")
			UnRegisterForModEvent("iDDeListAllWornDDs")
			UnRegisterForModEvent("iDDeLock")
			UnRegisterForModEvent("iDDeDone")
			UnRegisterForModEvent("iDDeEquipByTags")
			UnRegisterForModEvent("iDDeEquipIdx")
			UnRegisterForModEvent("iDDeLockArmbinder")
			UnRegisterForModEvent("iDDeStrip")
			UnRegisterForModEvent("iDDeEquipOutfitByKeyword")
			UnRegisterForModEvent("iDDeSetMech")
			iRet += 1
		EndIf
	RETURN iRet
EndFunction
INT Function iDDeLoadLibs(INT iDis = 1)
	iDDeUtil.Log("iDDeLoadLibs():-> ", "Start!")
	iDDeUtil.Log("iDDeLoadLibs():-> ", "Loading Database!", 3, iDis)
	CheckForMods()
	RETURN iDDeLib.iDDeSetLibs()
EndFunction 
Function CheckForMods()
	bSUM = iDDeGotMod("CheckForMods()", "Skyrim - Utility Mod.esm")
	bZAP = iDDeGotMod("CheckForMods()", "ZaZAnimationPack.esm")
	bDDa = iDDeGotMod("CheckForMods()", "Devious Devices - Assets.esm")
	bDDi = iDDeGotMod("CheckForMods()", "Devious Devices - Integration.esm") 
	bDDx = iDDeGotMod("CheckForMods()", "Devious Devices - Expansion.esm") 
	bDDe = iDDeGotMod("CheckForMods()", "Devious Devices - Equip.esp")
	bCD = iDDeGotMod("CheckForMods()", "Captured Dreams.esp")
	bSD = iDDeGotMod("CheckForMods()", "sanguinesDebauchery.esp")
	bIsSE = (SKSE.GetVersion() > 1)
EndFunction
INT Function UpdateVariables(INT iOpt = 1, INT iDis = 1)
	INT iRet = 0
		If (iOpt)
			STRING sGloSysJ = iDDeMCM.GetPathJson(sPath = "GloSys")
			iDDeLog("UpdateVariables():-> ", "Updating variables...", 3, iDis)
			StorageUtil.SetStringValue(None, "iDDeSystemJson", iDDeMCM.GetPathJson(sPath = "DDeSys"))
			StorageUtil.SetStringValue(None, "iDDeOutfitsFolder", iDDeMCM.GetPathFolder(sPath = "Glo", sFolder = "Outfits"))
			JsonUtil.SetStringValue(sGloSysJ, "iDDeOutfitsFolder", iDDeMCM.GetPathFolder(sPath = "Glo", sFolder = "Outfits"))
			JsonUtil.SetStringValue(sGloSysJ, "iDDeActorsJs", iDDeMCM.GetPathJson(sPath = "GloAct"))
			JsonUtil.SetStringValue(sGloSysJ, "iDDeFormsJson", iDDeMCM.GetPathJson(sPath = "GloFor"))
			JsonUtil.SetStringValue(sGloSysJ, "iDDeOutfitsJs", iDDeMCM.GetPathJson(sPath = "GloOut"))
			JsonUtil.SetStringValue(sGloSysJ, "iDDeSystemJson", iDDeMCM.GetPathJson(sPath = "DDeSys"))
			JsonUtil.SetStringValue(sGloSysJ, "iDDeConSystemJson", sGloSysJ)
			iDDeLog("UpdateVariables():-> ", "Updating variables... Done.", 3, iDis)
			iRet += 1
		EndIf
	RETURN iRet
EndFunction
INT Function iDDeClearAllLists(Form akObj = None, INT iObj = 0) 
	INT iRet = 0
	iDDeUtil.Log("iDDeClearAllLists():-> ", "Triggered on [" +iDDeGetNoName(akObj, "Global")+ ". iOpt = [" +iObj+ "].")
		iRet += StorageUtil.ClearFormListPrefix("iDDeOut")
		iRet += StorageUtil.ClearObjFormListPrefix(akObj, "iDDeOut")
			If (akObj != PlayerRef)
				iRet += StorageUtil.ClearObjFormListPrefix(PlayerRef, "iDDeOut")
			EndIf
		iRet += ClearAllCusOutFromStorUtil()
	iDDeUtil.Log("iDDeClearAllLists():-> ", "Cleared [" +iRet+ "] lists.")
	RETURN iRet
EndFunction
INT Function ClearAllCusOutFromStorUtil(STRING sFolder = "")
	INT iRet = 0
		If (!sFolder)
			sFolder = iDDeMCM.GetPathFolder(sPath = "Glo", sFolder = "Outfits")
		EndIf
	STRING[] sJsons = iSUmUtil.GetJsonsInFolder(sFolder = sFolder, bExt = True)
	STRING[] sOuts
	STRING sJs = ""
	STRING sOu = ""
	INT iJs = 0
	INT iJsMax = sJsons.Length
	INT iOu = 0
	INT iOuMax = 0
		While (iJs < iJsMax)
			sJs = (sFolder + sJsons[iJs])
			sOuts = JsonUtil.PathMembers(sJs, ".stringList")
			iOu = 0
			iOuMax = sOuts.Length
				While (iOu < iOuMax)
					sOu = sOuts[iOu]
						iRet += StorageUtil.ClearFormListPrefix(sOu)
						StorageUtil.ClearStringListPrefix(sOu)
						StorageUtil.ClearIntListPrefix(sOu)
					iOu += 1
				EndWhile
			iJs += 1
		EndWhile
	RETURN iRet
EndFunction
INT Function iDDeResetVariables()
		iDDeUtilityTask.SetValueInt(0) 
		iDDeEqpOutfit.SetValueInt(0) 
		iDDeOutfitReady.SetValueInt(0)
	RETURN 1
EndFunction
BOOL Function iDDeStartQuest(Quest akQuest)
	RETURN iSUmUtil.StartQuest(akQuest)
EndFunction
BOOL Function iDDeStopQuest(Quest akQuest)
	RETURN iSUmUtil.StopQuest(akQuest)
EndFunction 
STRING FUnction GetGloJsonByList(STRING sFolder = "", STRING sList = "")
	STRING sJson = ""
		If (sList)
			If (sFolder)
				sJson = iSUmUtil.GetJsonByList(sList = sList, sFolder = iDDeMCM.GetPathFolder(sPath = "Glo", sFolder = sFolder))
			EndIf
			If (!sJson)
				sJson = iDDeMCM.GetPathJson(sPath = "GloFor", sJson = "iDDeForms")
			EndIf
		EndIf
	RETURN sJson
EndFunction 

INT Function CleanUpJunk()
	INT iRet = 0
	iDDeUtil.Log("iDDeCleanUpJunk():-> ", "Started.")
		iRet += ClearAllCusOutFromStorUtil()
	iDDeUtil.Log("iDDeCleanUpJunk():-> ", "Done! Cleared [" +iRet+ "] items.")
	RETURN iRet
EndFunction
;sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss

;MCM Export/Import
;mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
BOOL Function iDDeExportSettings(STRING sFile = "")
	If (sFile == "")
		RETURN False
	EndIf
	
		;STRING
		JsonUtil.SetStringValue(sFile, "sDDeSlave", sDDeSlave)
		JsonUtil.SetStringValue(sFile, "sDDeNoStrip", sDDeNoStrip)
		JsonUtil.SetStringValue(sFile, "sActFolder", sActFolder)
		JsonUtil.SetStringValue(sFile, "sActJson", sActJson)
		JsonUtil.SetStringValue(sFile, "sOutFolder", sOutFolder)
		JsonUtil.SetStringValue(sFile, "sOutJson", sOutJson)
		JsonUtil.SetStringValue(sFile, "sActFoJs", sActFoJs)
		JsonUtil.SetStringValue(sFile, "sOutFoJs", sOutFoJs)
		
		;BOOL
		
		;INT
		JsonUtil.SetIntValue(sFile, "iDDeStrip", iDDeStrip)
		JsonUtil.SetIntValue(sFile, "iDDeHardCore", iDDeHardCore)
		JsonUtil.SetIntValue(sFile, "iDDe86Device", iDDe86Device)
		JsonUtil.SetIntValue(sFile, "iDDeArmFight", iDDeArmFight)
		JsonUtil.SetIntValue(sFile, "iDDeArmSneak", iDDeArmSneak)
		JsonUtil.SetIntValue(sFile, "iDDeArmMenu", iDDeArmMenu)
		JsonUtil.SetIntValue(sFile, "iDDeArmActive", iDDeArmActive)
		JsonUtil.SetIntValue(sFile, "iDDeArmTravel", iDDeArmTravel)
		JsonUtil.SetIntValue(sFile, "iDDeArmWait", iDDeArmWait)
		JsonUtil.SetIntValue(sFile, "iDDeArmTalk", iDDeArmTalk)
		JsonUtil.SetIntValue(sFile, "iDDeArmStruggle", iDDeArmStruggle)
		JsonUtil.SetIntValue(sFile, "iDDeBlind", iDDeBlind)
		JsonUtil.SetIntValue(sFile, "iDDxBlind", iDDxBlind)
		JsonUtil.SetIntValue(sFile, "iDDeGag", iDDeGag)
		JsonUtil.SetIntValue(sFile, "iDDxGag", iDDxGag)
		JsonUtil.SetIntValue(sFile, "iDDeCollar", iDDeCollar)
		JsonUtil.SetIntValue(sFile, "iDDxCollar", iDDxCollar)
		JsonUtil.SetIntValue(sFile, "iCDxCollar", iCDxCollar)
		JsonUtil.SetIntValue(sFile, "iDDeBra", iDDeBra)
		JsonUtil.SetIntValue(sFile, "iDDxBra", iDDxBra)
		JsonUtil.SetIntValue(sFile, "iCDxBra", iCDxBra)
		JsonUtil.SetIntValue(sFile, "iDDxPieN", iDDxPieN)
		JsonUtil.SetIntValue(sFile, "iDDxPieV", iDDxPieV)
		JsonUtil.SetIntValue(sFile, "iDDeCuffsA", iDDeCuffsA)
		JsonUtil.SetIntValue(sFile, "iDDxCuffsA", iDDxCuffsA)
		JsonUtil.SetIntValue(sFile, "iCDxCuffsA", iCDxCuffsA)
		JsonUtil.SetIntValue(sFile, "iDDeCuffsL", iDDeCuffsL)
		JsonUtil.SetIntValue(sFile, "iDDxCuffsL", iDDxCuffsL)
		JsonUtil.SetIntValue(sFile, "iCDxCuffsL", iCDxCuffsL)
		JsonUtil.SetIntValue(sFile, "iDDeElbowBinder", iDDeElbowBinder)
		JsonUtil.SetIntValue(sFile, "iDDxElbowBinder", iDDxElbowBinder)
		JsonUtil.SetIntValue(sFile, "iDDeArmBinder", iDDeArmBinder)
		JsonUtil.SetIntValue(sFile, "iDDxArmBinder", iDDxArmBinder)
		JsonUtil.SetIntValue(sFile, "iDDeYoke", iDDeYoke)
		JsonUtil.SetIntValue(sFile, "iDDxYoke", iDDxYoke)
		JsonUtil.SetIntValue(sFile, "iDDeShackles", iDDeShackles)
		JsonUtil.SetIntValue(sFile, "iDDxShackles", iDDxShackles)
		JsonUtil.SetIntValue(sFile, "iDDeBelt", iDDeBelt)
		JsonUtil.SetIntValue(sFile, "iDDxBelt", iDDxBelt)
		JsonUtil.SetIntValue(sFile, "iCDxBelt", iCDxBelt)
		JsonUtil.SetIntValue(sFile, "iDDeHarness", iDDeHarness)
		JsonUtil.SetIntValue(sFile, "iDDxHarness", iDDxHarness)
		JsonUtil.SetIntValue(sFile, "iDDePlugA", iDDePlugA)
		JsonUtil.SetIntValue(sFile, "iDDxPlugA", iDDxPlugA)
		JsonUtil.SetIntValue(sFile, "iCDxPlugA", iCDxPlugA)
		JsonUtil.SetIntValue(sFile, "iDDePlugV", iDDePlugV)
		JsonUtil.SetIntValue(sFile, "iDDxPlugV", iDDxPlugV)
		JsonUtil.SetIntValue(sFile, "iCDxPlugV", iCDxPlugV)
		JsonUtil.SetIntValue(sFile, "iDDxCorset", iDDxCorset)
		JsonUtil.SetIntValue(sFile, "iDDeGloves", iDDeGloves)
		JsonUtil.SetIntValue(sFile, "iDDxGloves", iDDxGloves)
		JsonUtil.SetIntValue(sFile, "iDDeBoots", iDDeBoots)
		JsonUtil.SetIntValue(sFile, "iDDxBoots", iDDxBoots)
		JsonUtil.SetIntValue(sFile, "iDDeSuit", iDDeSuit)
		JsonUtil.SetIntValue(sFile, "iDDxSuit", iDDxSuit)
		JsonUtil.SetIntValue(sFile, "iDDeCatSuit", iDDeCatSuit)
		JsonUtil.SetIntValue(sFile, "iDDxCatSuit", iDDxCatSuit)
		JsonUtil.SetIntValue(sFile, "iDDeBinderEff", iDDeBinderEff)
		JsonUtil.SetIntValue(sFile, "iDDePickPlugEff", iDDePickPlugEff)
		JsonUtil.SetIntValue(sFile, "iDDePlugRibbed", iDDePlugRibbed)
		JsonUtil.SetIntValue(sFile, "iDDePlugShocker", iDDePlugShocker)
		JsonUtil.SetIntValue(sFile, "iDDePlugFusStag", iDDePlugFusStag)
		JsonUtil.SetIntValue(sFile, "iDDePlugLinked", iDDePlugLinked)
		JsonUtil.SetIntValue(sFile, "iDDePlugLively", iDDePlugLively)
		JsonUtil.SetIntValue(sFile, "iDDePlugDrainH", iDDePlugDrainH)
		JsonUtil.SetIntValue(sFile, "iDDePlugDrainS", iDDePlugDrainS)
		JsonUtil.SetIntValue(sFile, "iDDePlugDrainM", iDDePlugDrainM)
		JsonUtil.SetIntValue(sFile, "iDDePlugEleStim", iDDePlugEleStim)
		JsonUtil.SetIntValue(sFile, "iDDePlugEdgeRand", iDDePlugEdgeRand)
		JsonUtil.SetIntValue(sFile, "iDDePlugEdgeOnly", iDDePlugEdgeOnly)
		JsonUtil.SetIntValue(sFile, "iDDePlugPoss", iDDePlugPoss)
		JsonUtil.SetIntValue(sFile, "iDDePlugTrain", iDDePlugTrain)
		JsonUtil.SetIntValue(sFile, "iDDePlugVeLively", iDDePlugVeLively)
		JsonUtil.SetIntValue(sFile, "iDDePlugVib", iDDePlugVib)
		JsonUtil.SetIntValue(sFile, "iDDePlugVibCast", iDDePlugVibCast)
		JsonUtil.SetIntValue(sFile, "iDDePlugVibRand", iDDePlugVibRand)
		JsonUtil.SetIntValue(sFile, "iDDePlugVibStrg", iDDePlugVibStrg)
		JsonUtil.SetIntValue(sFile, "iDDePlugVibVeStrg", iDDePlugVibVeStrg)
		JsonUtil.SetIntValue(sFile, "iDDePlugVibVeWeak", iDDePlugVibVeWeak)
		JsonUtil.SetIntValue(sFile, "iDDePlugVibWeak", iDDePlugVibWeak)
		JsonUtil.SetIntValue(sFile, "iDDeMechFX", iDDeMechFX)
		JsonUtil.SetIntValue(sFile, "iDDeMechJump", iDDeMechJump)
		JsonUtil.SetIntValue(sFile, "iDDeMechDisarm", iDDeMechDisarm)
		JsonUtil.SetIntValue(sFile, "iDDeMechNoActivate", iDDeMechNoActivate)
		JsonUtil.SetIntValue(sFile, "iDDeMechNoFighting", iDDeMechNoFighting)
		JsonUtil.SetIntValue(sFile, "iDDeMechNoMenu", iDDeMechNoMenu)
		JsonUtil.SetIntValue(sFile, "iDDeMechNoFastTravel", iDDeMechNoFastTravel)
		JsonUtil.SetIntValue(sFile, "iDDeMechNoMove", iDDeMechNoMove)
		JsonUtil.SetIntValue(sFile, "iDDeMechNoSneak", iDDeMechNoSneak)
		JsonUtil.SetIntValue(sFile, "iDDeMechNoSprint", iDDeMechNoSprint)
		JsonUtil.SetIntValue(sFile, "iDDeMechNoWait", iDDeMechNoWait)
		JsonUtil.SetIntValue(sFile, "iDDeMech", iDDeMech)
		JsonUtil.SetIntValue(sFile, "iDDeRemQuest", iDDeRemQuest)
		JsonUtil.SetIntValue(sFile, "iDDePetSuit", iDDePetSuit)
		JsonUtil.SetIntValue(sFile, "iDDxPetSuit", iDDxPetSuit)
		JsonUtil.SetIntValue(sFile, "iDDeBoxBinder", iDDeBoxBinder)
		JsonUtil.SetIntValue(sFile, "iDDxBoxBinder", iDDxBoxBinder)
		JsonUtil.SetIntValue(sFile, "iDDeBoxBinderOut", iDDeBoxBinderOut)
		JsonUtil.SetIntValue(sFile, "iDDxBoxBinderOut", iDDxBoxBinderOut)
		JsonUtil.SetIntValue(sFile, "iDDeBlockActArm", iDDeBlockActArm)
		JsonUtil.SetIntValue(sFile, "iDDeBlockActMit", iDDeBlockActMit)
		JsonUtil.SetIntValue(sFile, "iEnableBondFX", iEnableBondFX)
		JsonUtil.SetIntValue(sFile, "iMechPow", iMechPow)
		JsonUtil.SetIntValue(sFile, "iMechPowSnd", iMechPowSnd)
		
		;FLOAT
		JsonUtil.SetFloatValue(sFile, "fDDeRefreshRate", fDDeRefreshRate)
		
		;INT Global
		JsonUtil.SetIntValue(sFile, "iDDeUtilityTask", iDDeUtilityTask.GetValueInt())
		JsonUtil.SetIntValue(sFile, "iDDeEqpOutfit", iDDeEqpOutfit.GetValueInt())
		JsonUtil.SetIntValue(sFile, "iDDeOutfitReady", iDDeOutfitReady.GetValueInt())
		
		;StorageUtil INT Var
		JsonUtil.SetIntValue(sFile, "iDDeDebugInfo", StorageUtil.GetIntValue(None, "iDDeDebugInfo", 0))
		JsonUtil.SetIntValue(sFile, "iDDeDisplayInfo", StorageUtil.GetIntValue(None, "iDDeDisplayInfo", 0))
		JsonUtil.SetIntValue(sFile, "iDDeConsoleInfo", StorageUtil.GetIntValue(None, "iDDeConsoleInfo", 0))
		JsonUtil.SetIntValue(sFile, "iDDeAnklesEff", StorageUtil.GetIntValue(PlayerRef, "iDDeAnklesEff", 0))
	RETURN True
EndFunction	
BOOL Function iDDeImportSettings(STRING sFile = "") 
	If (sFile == "")
		RETURN False
	EndIf
		
		;STRING
		sDDeSlave 			= JsonUtil.GetStringValue(sFile, "sDDeSlave", sDDeSlave)
		sDDeNoStrip			= JsonUtil.GetStringValue(sFile, "sDDeNoStrip", sDDeNoStrip)
		sActFolder			= JsonUtil.GetStringValue(sFile, "sActFolder", sActFolder)
		sActJson				= JsonUtil.GetStringValue(sFile, "sActJson", sActJson)
		sOutFolder			= JsonUtil.GetStringValue(sFile, "sOutFolder", sOutFolder)
		sOutJson				= JsonUtil.GetStringValue(sFile, "sOutJson", sOutJson)
		sActFoJs				= JsonUtil.GetStringValue(sFile, "sActFoJs", sActFoJs)
		sOutFoJs				= JsonUtil.GetStringValue(sFile, "sOutFoJs", sOutFoJs)
		
		;BOOL
		
		;INT
		iDDeStrip 						= JsonUtil.GetIntValue(sFile, "iDDeStrip", iDDeStrip)
		iDDeHardCore 					= JsonUtil.GetIntValue(sFile, "iDDeHardCore", iDDeHardCore)
		iDDe86Device 					= JsonUtil.GetIntValue(sFile, "iDDe86Device", iDDe86Device)
		iDDeArmFight 					= JsonUtil.GetIntValue(sFile, "iDDeArmFight", iDDeArmFight)
		iDDeArmSneak 					= JsonUtil.GetIntValue(sFile, "iDDeArmSneak", iDDeArmSneak)
		iDDeArmMenu 					= JsonUtil.GetIntValue(sFile, "iDDeArmMenu", iDDeArmMenu)
		iDDeArmActive 				= JsonUtil.GetIntValue(sFile, "iDDeArmActive", iDDeArmActive)
		iDDeArmTravel 				= JsonUtil.GetIntValue(sFile, "iDDeArmTravel", iDDeArmTravel)
		iDDeArmWait 					= JsonUtil.GetIntValue(sFile, "iDDeArmWait", iDDeArmWait)
		iDDeArmTalk 					= JsonUtil.GetIntValue(sFile, "iDDeArmTalk", iDDeArmTalk)
		iDDeArmStruggle 			= JsonUtil.GetIntValue(sFile, "iDDeArmStruggle", iDDeArmStruggle)
		iDDeBlind 						= JsonUtil.GetIntValue(sFile, "iDDeBlind", iDDeBlind)
		iDDxBlind 						= JsonUtil.GetIntValue(sFile, "iDDxBlind", iDDxBlind)
		iDDeGag 							= JsonUtil.GetIntValue(sFile, "iDDeGag", iDDeGag)
		iDDxGag 							= JsonUtil.GetIntValue(sFile, "iDDxGag", iDDxGag)
		iDDeCollar 						= JsonUtil.GetIntValue(sFile, "iDDeCollar", iDDeCollar)
		iDDxCollar 						= JsonUtil.GetIntValue(sFile, "iDDxCollar", iDDxCollar)
		iCDxCollar 						= JsonUtil.GetIntValue(sFile, "iCDxCollar", iCDxCollar)
		iDDeBra 							= JsonUtil.GetIntValue(sFile, "iDDeBra", iDDeBra)
		iDDxBra 							= JsonUtil.GetIntValue(sFile, "iDDxBra", iDDxBra)
		iCDxBra 							= JsonUtil.GetIntValue(sFile, "iCDxBra", iCDxBra)
		iDDxPieN 							= JsonUtil.GetIntValue(sFile, "iDDxPieN", iDDxPieN)
		iDDxPieV 							= JsonUtil.GetIntValue(sFile, "iDDxPieV", iDDxPieV)
		iDDeCuffsA 						= JsonUtil.GetIntValue(sFile, "iDDeCuffsA", iDDeCuffsA)
		iDDxCuffsA 						= JsonUtil.GetIntValue(sFile, "iDDxCuffsA", iDDxCuffsA)
		iCDxCuffsA 						= JsonUtil.GetIntValue(sFile, "iCDxCuffsA", iCDxCuffsA)
		iDDeCuffsL 						= JsonUtil.GetIntValue(sFile, "iDDeCuffsL", iDDeCuffsL)
		iDDxCuffsL 						= JsonUtil.GetIntValue(sFile, "iDDxCuffsL", iDDxCuffsL)
		iCDxCuffsL 						= JsonUtil.GetIntValue(sFile, "iCDxCuffsL", iCDxCuffsL)
		iDDeElbowBinder 			= JsonUtil.GetIntValue(sFile, "iDDeElbowBinder", iDDeElbowBinder)
		iDDxElbowBinder 			= JsonUtil.GetIntValue(sFile, "iDDxElbowBinder", iDDxElbowBinder)
		iDDeArmBinder 				= JsonUtil.GetIntValue(sFile, "iDDeArmBinder", iDDeArmBinder)
		iDDxArmBinder 				= JsonUtil.GetIntValue(sFile, "iDDxArmBinder", iDDxArmBinder)
		iDDeYoke 							= JsonUtil.GetIntValue(sFile, "iDDeYoke", iDDeYoke)
		iDDxYoke 							= JsonUtil.GetIntValue(sFile, "iDDxYoke", iDDxYoke)
		iDDeShackles 					= JsonUtil.GetIntValue(sFile, "iDDeShackles", iDDeShackles)
		iDDxShackles 					= JsonUtil.GetIntValue(sFile, "iDDxShackles", iDDxShackles)
		iDDeBelt 							= JsonUtil.GetIntValue(sFile, "iDDeBelt", iDDeBelt)
		iDDxBelt 							= JsonUtil.GetIntValue(sFile, "iDDxBelt", iDDxBelt)
		iCDxBelt 							= JsonUtil.GetIntValue(sFile, "iCDxBelt", iCDxBelt)
		iDDeHarness 					= JsonUtil.GetIntValue(sFile, "iDDeHarness", iDDeHarness)
		iDDxHarness 					= JsonUtil.GetIntValue(sFile, "iDDxHarness", iDDxHarness)
		iDDePlugA 						= JsonUtil.GetIntValue(sFile, "iDDePlugA", iDDePlugA)
		iDDxPlugA 						= JsonUtil.GetIntValue(sFile, "iDDxPlugA", iDDxPlugA)
		iCDxPlugA 						= JsonUtil.GetIntValue(sFile, "iCDxPlugA", iCDxPlugA)
		iDDePlugV 						= JsonUtil.GetIntValue(sFile, "iDDePlugV", iDDePlugV)
		iDDxPlugV 						= JsonUtil.GetIntValue(sFile, "iDDxPlugV", iDDxPlugV)
		iCDxPlugV 						= JsonUtil.GetIntValue(sFile, "iCDxPlugV", iCDxPlugV)
		iDDxCorset 						= JsonUtil.GetIntValue(sFile, "iDDxCorset", iDDxCorset)
		iDDeGloves 						= JsonUtil.GetIntValue(sFile, "iDDeGloves", iDDeGloves)
		iDDxGloves 						= JsonUtil.GetIntValue(sFile, "iDDxGloves", iDDxGloves)
		iDDeBoots 						= JsonUtil.GetIntValue(sFile, "iDDeBoots", iDDeBoots)
		iDDxBoots 						= JsonUtil.GetIntValue(sFile, "iDDxBoots", iDDxBoots)
		iDDeSuit 							= JsonUtil.GetIntValue(sFile, "iDDeSuit", iDDeSuit)
		iDDxSuit 							= JsonUtil.GetIntValue(sFile, "iDDxSuit", iDDxSuit)
		iDDeCatSuit 					= JsonUtil.GetIntValue(sFile, "iDDeCatSuit", iDDeCatSuit)
		iDDxCatSuit 					= JsonUtil.GetIntValue(sFile, "iDDxCatSuit", iDDxCatSuit)
		iDDeBinderEff 				= JsonUtil.GetIntValue(sFile, "iDDeBinderEff", iDDeBinderEff)
		iDDePickPlugEff				= JsonUtil.GetIntValue(sFile, "iDDePickPlugEff", iDDePickPlugEff)
		iDDePlugRibbed				=	JsonUtil.GetIntValue(sFile, "iDDePlugRibbed", iDDePlugRibbed)
		iDDePlugShocker 			= JsonUtil.GetIntValue(sFile, "iDDePlugShocker", iDDePlugShocker)
		iDDePlugFusStag 			= JsonUtil.GetIntValue(sFile, "iDDePlugFusStag", iDDePlugFusStag)
		iDDePlugLinked 				= JsonUtil.GetIntValue(sFile, "iDDePlugLinked", iDDePlugLinked)
		iDDePlugLively 				= JsonUtil.GetIntValue(sFile, "iDDePlugLively", iDDePlugLively)
		iDDePlugDrainH 				= JsonUtil.GetIntValue(sFile, "iDDePlugDrainH", iDDePlugDrainH)
		iDDePlugDrainS 				= JsonUtil.GetIntValue(sFile, "iDDePlugDrainS", iDDePlugDrainS)
		iDDePlugDrainM 				= JsonUtil.GetIntValue(sFile, "iDDePlugDrainM", iDDePlugDrainM)
		iDDePlugEleStim 			= JsonUtil.GetIntValue(sFile, "iDDePlugEleStim", iDDePlugEleStim)
		iDDePlugEdgeRand 			= JsonUtil.GetIntValue(sFile, "iDDePlugEdgeRand", iDDePlugEdgeRand)
		iDDePlugEdgeOnly 			= JsonUtil.GetIntValue(sFile, "iDDePlugEdgeOnly", iDDePlugEdgeOnly)
		iDDePlugPoss 					= JsonUtil.GetIntValue(sFile, "iDDePlugPoss", iDDePlugPoss)
		iDDePlugTrain 				= JsonUtil.GetIntValue(sFile, "iDDePlugTrain", iDDePlugTrain)
		iDDePlugVeLively 			= JsonUtil.GetIntValue(sFile, "iDDePlugVeLively", iDDePlugVeLively)
		iDDePlugVib 					= JsonUtil.GetIntValue(sFile, "iDDePlugVib", iDDePlugVib)
		iDDePlugVibCast 			= JsonUtil.GetIntValue(sFile, "iDDePlugVibCast", iDDePlugVibCast)
		iDDePlugVibRand 			= JsonUtil.GetIntValue(sFile, "iDDePlugVibRand", iDDePlugVibRand)
		iDDePlugVibStrg 			= JsonUtil.GetIntValue(sFile, "iDDePlugVibStrg", iDDePlugVibStrg)
		iDDePlugVibVeStrg 		= JsonUtil.GetIntValue(sFile, "iDDePlugVibVeStrg", iDDePlugVibVeStrg)
		iDDePlugVibVeWeak 		= JsonUtil.GetIntValue(sFile, "iDDePlugVibVeWeak", iDDePlugVibVeWeak)
		iDDePlugVibWeak 			= JsonUtil.GetIntValue(sFile, "iDDePlugVibWeak", iDDePlugVibWeak)
		iDDeMechFX 						= JsonUtil.GetIntValue(sFile, "iDDeMechFX", iDDeMechFX)
		iDDeMechJump 					= JsonUtil.GetIntValue(sFile, "iDDeMechJump", iDDeMechJump)
		iDDeMechDisarm 				= JsonUtil.GetIntValue(sFile, "iDDeMechDisarm", iDDeMechDisarm)
		iDDeMechNoActivate 		= JsonUtil.GetIntValue(sFile, "iDDeMechNoActivate", iDDeMechNoActivate)
		iDDeMechNoFighting 		= JsonUtil.GetIntValue(sFile, "iDDeMechNoFighting", iDDeMechNoFighting)
		iDDeMechNoMenu				= JsonUtil.GetIntValue(sFile, "iDDeMechNoMenu", iDDeMechNoMenu)
		iDDeMechNoFastTravel	= JsonUtil.GetIntValue(sFile, "iDDeMechNoFastTravel", iDDeMechNoFastTravel)
		iDDeMechNoMove 				= JsonUtil.GetIntValue(sFile, "iDDeMechNoMove", iDDeMechNoMove)
		iDDeMechNoSneak 			= JsonUtil.GetIntValue(sFile, "iDDeMechNoSneak", iDDeMechNoSneak)
		iDDeMechNoSprint			= JsonUtil.GetIntValue(sFile, "iDDeMechNoSprint", iDDeMechNoSprint)
		iDDeMechNoWait				= JsonUtil.GetIntValue(sFile, "iDDeMechNoWait", iDDeMechNoWait)
		iDDeMech 							= JsonUtil.GetIntValue(sFile, "iDDeMech", iDDeMech)
		iDDeRemQuest 					= JsonUtil.GetIntValue(sFile, "iDDeRemQuest", iDDeRemQuest)
		iDDePetSuit 					= JsonUtil.GetIntValue(sFile, "iDDePetSuit", iDDePetSuit)
		iDDxPetSuit						= JsonUtil.GetIntValue(sFile, "iDDxPetSuit", iDDxPetSuit)
		iDDeBoxBinder 				= JsonUtil.GetIntValue(sFile, "iDDeBoxBinder", iDDeBoxBinder)
		iDDxBoxBinder					= JsonUtil.GetIntValue(sFile, "iDDxBoxBinder", iDDxBoxBinder)
		iDDeBoxBinderOut 			= JsonUtil.GetIntValue(sFile, "iDDeBoxBinderOut", iDDeBoxBinderOut)
		iDDxBoxBinderOut			= JsonUtil.GetIntValue(sFile, "iDDxBoxBinderOut", iDDxBoxBinderOut)
		iDDeBlockActArm				= JsonUtil.GetIntValue(sFile, "iDDeBlockActArm", iDDeBlockActArm)
		iDDeBlockActMit				= JsonUtil.GetIntValue(sFile, "iDDeBlockActMit", iDDeBlockActMit)
		iEnableBondFX					= JsonUtil.GetIntValue(sFile, "iEnableBondFX", iEnableBondFX)
		iMechPow							= JsonUtil.GetIntValue(sFile, "iMechPow", iMechPow)
		iMechPowSnd						= JsonUtil.GetIntValue(sFile, "iMechPowSnd", iMechPowSnd)
		
		;FLOAT
		fDDeRefreshRate 			= JsonUtil.GetFloatValue(sFile, "fDDeRefreshRate", fDDeRefreshRate)
		
		;INT Global
		iDDeUtilityTask.SetValueInt(JsonUtil.GetIntValue(sFile, "iDDeUtilityTask", iDDeUtilityTask.GetValueInt()))
		iDDeEqpOutfit.SetValueInt(JsonUtil.GetIntValue(sFile, "iDDeEqpOutfit", iDDeEqpOutfit.GetValueInt()))
		iDDeOutfitReady.SetValueInt(JsonUtil.GetIntValue(sFile, "iDDeOutfitReady", iDDeOutfitReady.GetValueInt()))
		
		;StorageUtil INT Var
		StorageUtil.SetIntValue(None, "iDDeDebugInfo", JsonUtil.GetIntValue(sFile, "iDDeDebugInfo", StorageUtil.GetIntValue(None, "iDDeDebugInfo", 1)))	
		StorageUtil.SetIntValue(None, "iDDeDisplayInfo", JsonUtil.GetIntValue(sFile, "iDDeDisplayInfo", StorageUtil.GetIntValue(None, "iDDeDisplayInfo", 1)))
		StorageUtil.SetIntValue(None, "iDDeConsoleInfo", JsonUtil.GetIntValue(sFile, "iDDeConsoleInfo", StorageUtil.GetIntValue(None, "iDDeConsoleInfo", 0)))
		StorageUtil.SetIntValue(None, "iDDeRemQuest", iDDeRemQuest)
		StorageUtil.SetIntValue(PlayerRef, "iDDeAnklesEff", JsonUtil.GetIntValue(sFile, "iDDeAnklesEff", StorageUtil.GetIntValue(PlayerRef, "iDDeAnklesEff", 0)))
	RETURN True
EndFunction	  
;mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm 

;Deprecated/Unused
;uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu
;/ 
INT Function iDDeAllToList(Actor aSlave, STRING sList = "", INT iRem = 0, BOOL bRemDDs = False, BOOL Anim = False)
;Will remove all from aSlave to sList.
;iRem > 0 will remove items.
;iRem < 0 will restore items.
;iRem = 0 will do nothing.
;sList = "" will unequip the items only.
	iDDeUtil.Log("iDDeAllToList():-> ", "Start!")
	BOOL bIsEqp = False
	INT iRet = 0
	INT i = 0
	INT iType = 0
	INT iCount = 0
	STRING sActor = iDDeGetObjName(aSlave)
	STRING sEqp
	Form Eqp = None
		If (aSlave && (iRem != 0))
			iDDeUtil.Log("iDDeAllToList():-> ", "Working on [" +sActor+ "]!")
				If (iRem < 0) 
					i = StorageUtil.FormListCount(aSlave, sList)
					iDDeUtil.Log("iDDeAllToList():-> ", "Form list has [" +i+ "] items.")
					iDDeUtil.Log("iDDeAllToList():-> ", "Count list has [" +StorageUtil.IntListCount(aSlave, sList)+ "] items.")
				Else
					i = aSlave.GetNumItems()
					StorageUtil.FormListAdd(aSlave, sList, Eqp) ;To make sure the list exists
					StorageUtil.IntListAdd(aSlave, sList, i)
				EndIf	
				If (Anim)
					INT iSex = aSlave.GetLeveledActorBase().GetSex()
					Debug.SendAnimationEvent(aSlave, "Arrok_Undress_G" +iSex)
				EndIf
					While (i > 0)
						i -= 1
							If (iRem < 0)
								Eqp = StorageUtil.FormListPluck(aSlave, sList, i, None)
								iCount = StorageUtil.IntListPluck(aSlave, sList, i, 0)
							Else
								Eqp = aSlave.GetNthForm(i)
							EndIf
								If (Eqp)
									If (iRem > 0)
										iCount = aSlave.GetItemCount(Eqp) 
									EndIf
									sEqp = iDDeGetObjName(Eqp)
									bIsEqp = aSlave.IsEquipped(Eqp)
									iType = Eqp.GetType()
									iDDeUtil.Log("iDDeAllToList():-> ", "[" +sActor+ "] has [" +iCount+ "] x [" +sEqp+ "] of type [" +iType+ "]!")
										If (iCount > 0)
											If (iRem < 0)
												iRet += 1
												aSlave.AddItem(Eqp, iCount, abSilent = True)
												iDDeUtil.Log("iDDeAllToList():-> ", "Restoring [" +iCount+ "] x [" +sEqp+ "] from [" +sList+ "] to [" +sActor+ "]!")
											ElseIf (!bRemDDs && bIsEqp && iDDeIsDD(Eqp))
												iDDeUtil.Log("iDDeAllToList():-> ", "Skipping worn DD [" +sEqp+ "] from index [" +i+ "].")
											ElseIf (!bRemDDs && bIsEqp && Eqp.HasKeyword(iDDeLib.zbfWornDevice))
												iDDeUtil.Log("iDDeAllToList():-> ", "Skipping worn ZAP restraint [" +sEqp+ "] from index [" +i+ "].") 
											ElseIf (!bRemDDs && bIsEqp && Eqp.HasKeyword(iDDeLib.SexLabNoStrip))
												iDDeUtil.Log("iDDeAllToList():-> ", "Skipping SL NoStrip [" +sEqp+ "] from index [" +i+ "].")
											Else
												aSlave.UnequipItem(Eqp, abPreventEquip = True, abSilent = True)
												iRet += 1
													If (sList != "")
														StorageUtil.FormListSet(aSlave, sList, i, Eqp)
														StorageUtil.IntListSet(aSlave, sList, i, iCount)
														aSlave.RemoveItem(Eqp, iCount, True)
														iDDeUtil.Log("iDDeAllToList():-> ", "Moving [" +iCount+ "x" +sEqp+ "] from [" +sActor+ "] to [" +sList+ "]!")
													EndIf	
											EndIf
										EndIf
								EndIf
					EndWhile	
		Else
			iDDeUtil.Log("iDDeAllToList():-> ", "[" +sActor+ "] is no actor!", (((!aSlave) AS INT) * 4))
			iDDeUtil.Log("iDDeAllToList():-> ", "iStrip = [" +iRem+ "]. Ignoring call!", ((((iRem == 0)) AS INT) * 4))
		EndIf
	iDDeUtil.Log("iDDeAllToList():-> ", "Done! ... Items manipulated? => [" +iRet+ "].")
	RETURN iRet
EndFunction 
/;
;uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu
