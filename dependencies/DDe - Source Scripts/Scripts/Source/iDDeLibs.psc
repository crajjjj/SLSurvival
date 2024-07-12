ScriptName iDDeLibs Extends Quest

Import Game 

iDDeMain Property iDDe Auto
iDDeMisc Property iDDeMis Auto 
iDDeConfig Property iDDeMCM Auto
zadLibs Property ZadLib Auto
zadxLibs Property ZadxLib Auto 
zadxLibs2 Property ZadxLib2 Auto 
zadAssets Property ZadMain Auto 
;SexLabFramework Property SexLab Auto

Faction Property BeastFormFaction Auto
Faction Property VampireLordFaction Auto Hidden

INT Property iCDxVer = 0 Auto Hidden

BOOL bGotCD = False

INT Function iDDeSetLibs()
	bGotCD = (iDDe.iDDeGotMod("iDDeLibs.iDDeSetLibs()", "Captured Dreams.esp") && iDDeCDxUtil.GetVersion())
	iCDxVer = -1
	 	If (bGotCD)
	 		iCDxVer = iDDeCDxUtil.GetVersion()
	 	Else
	 		iCDxVer = 0
	 	EndIf
	SetMisc()
	iDDeSetBlindFolds()
	iDDeSetBlindFoldsDDx()
	iDDeSetHoods()
	iDDeSetHoodsDDx()
	iDDeSetGags()
	iDDeSetGagsDDx()
	iDDeSetCollars()
	iDDeSetCollarsDDx()
	iDDeSetCollarsCDx()
	iDDeSetBras()
	iDDeSetBrasDDx()
	iDDeSetBrasCDx()
	iDDeSetPieNDDx()  
	iDDeSetPieVDDx() 
	iDDeSetCuffsA()
	iDDeSetCuffsADDx()
	iDDeSetCuffsACDx()
	iDDeSetCuffsL()
	iDDeSetCuffsLDDx()
	iDDeSetCuffsLCDx()
	iDDeSetElbowBinders()
	iDDeSetElbowBindersDDx()
	iDDeSetArmBinders()
	iDDeSetArmBindersDDx()
	iDDeSetYokes()
	iDDeSetYokesDDx()
	iDDeSetShackles()
	iDDeSetShacklesDDx()
	iDDeSetPetSuits()
	iDDeSetPetSuitsDDx()
	iDDeSetBoxBinders()
	iDDeSetBoxBindersDDx()
	iDDeSetBoxBinderOuts()
	iDDeSetBoxBindersOutDDx()
	iDDeSetBelts()
	iDDeSetBeltsDDx()
	iDDeSetBeltsCDx()
	iDDeSetHarness()
	iDDeSetHarnessDDx()
	iDDeSetPlugsA()
	iDDeSetPlugsADDx()
	iDDeSetPlugsACDx()
	iDDeSetPlugsV()
	iDDeSetPlugsVDDx()
	iDDeSetPlugsVCDx()
	iDDeSetCorsetsDDe()
	iDDeSetCorsetsDDx()
	iDDeSetGloves()
	iDDeSetGlovesDDx()
	iDDeSetBoots()
	iDDeSetBootsDDx()
	iDDeSetSuits()
	iDDeSetSuitsDDx()
	iDDeSetCatSuits()
	iDDeSetCatSuitsDDx()
	iDDeSetKeywords()
	iDDeSetMcmOutfits()
	iDDeSetFactions()
	iDDeSetMech()
	iDDeSetMiscArr()
	RETURN 1
EndFunction

;Misc
;mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
FORM[] Property NullTokens Auto Hidden
Function SetMisc()
	NullTokens = NEW FORM[2]
	NullTokens[0] = None
	NullTokens[1] = iDDe.iSUmFakeArrow
EndFunction
;mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm	
;BlindFold Slot No. 55
;bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
STRING[] Property sDDeBlindFolds Auto Hidden	
FORM[] Property DDeBlindFolds Auto Hidden
Function iDDeSetBlindFolds()
	sDDeBlindFolds = NEW STRING[20]; MCM display name.	
	 DDeBlindFolds = NEW FORM[20]; Inventory device
		sDDeBlindFolds[0] = "No DDe Blindfold"	
		 DDeBlindFolds[0] = None  
		sDDeBlindFolds[1] = "Falmer Locked" 
		 DDeBlindFolds[1] = iDDe_FalmerBlindfold_Inv 
		sDDeBlindFolds[2] = "Falmer Blocking"	 
		 DDeBlindFolds[2] = iDDe_FalmerBlindfoldBlock_Inv
		sDDeBlindFolds[3] = "Gold Locked" 
		 DDeBlindFolds[3] = iDDe_GoldBlindfold_Inv
		sDDeBlindFolds[4] = "Inox Locked"	 
		 DDeBlindFolds[4] = iDDe_InoxBlindfold_Inv
		sDDeBlindFolds[5] = "Rusty Locked"	 
		 DDeBlindFolds[5] = iDDe_RustyBlindfold_Inv
		sDDeBlindFolds[6] = "Chromo-Hex Locked" 
		 DDeBlindFolds[6] = iDDe_HexChBlindfold_Inv
		sDDeBlindFolds[7] = "Red Hex Locked"	 
		 DDeBlindFolds[7] = iDDe_HexRdBlindfold_Inv
		sDDeBlindFolds[8] = "Hypnotic Locked"	 
		 DDeBlindFolds[8] = iDDe_HypBlindfold_Inv
		sDDeBlindFolds[9] = "Jade Locked"	 
		 DDeBlindFolds[9] = iDDe_JadeBlindfold_Inv
		sDDeBlindFolds[10] = "Fifa Locked" 
		 DDeBlindFolds[10] = iDDe_FifaBlindfold_Inv 
		sDDeBlindFolds[11] = "Fire Locked" 
		 DDeBlindFolds[11] = iDDe_FireBlindfold_Inv 
		sDDeBlindFolds[12] = "Brown Leather Locked" 
		 DDeBlindFolds[12] = iDDe_LeBrBlindfold_Inv
		sDDeBlindFolds[13] = "Crimson Locked" 
		 DDeBlindFolds[13] = iDDe_CrimsonBlindfold_Inv
		sDDeBlindFolds[14] = "Orange-Hex Locked" 
		 DDeBlindFolds[14] = iDDe_HexOrBlindfold_Inv
		sDDeBlindFolds[15] = "Bumblebee Locked" 
		 DDeBlindFolds[15] = iDDe_BumbeeBlindfold_Inv
		sDDeBlindFolds[16] = "Iron Locked" 
		 DDeBlindFolds[16] = iDDe_IronBlindfold_Inv
		sDDeBlindFolds[17] = "Lte Wood Locked" 
		 DDeBlindFolds[17] = iDDe_LteWoodBlindfold_Inv
		sDDeBlindFolds[18] = "Rope Locked" 
		 DDeBlindFolds[18] = iDDe_RopeBlindfold_Inv
		sDDeBlindFolds[19] = "Wood Locked" 
		 DDeBlindFolds[19] = iDDe_WoodBlindfold_Inv
EndFunction
STRING[] Property sDDxBlindFolds Auto Hidden	
FORM[] Property DDxBlindFolds Auto Hidden
Function iDDeSetBlindFoldsDDx()
	sDDxBlindFolds = NEW STRING[20]; MCM display name.	
	 DDxBlindFolds = NEW FORM[20]; Inventory device							
		sDDxBlindFolds[0] = "No DDx Blindfold"	
		 DDxBlindFolds[0] = None 					
		sDDxBlindFolds[1] = "Black Leather"
		 DDxBlindFolds[1] = ZadLib.blindfold 
		sDDxBlindFolds[2] = "Black Ebonite"
	 	 DDxBlindFolds[2] = ZadxLib.eboniteBlindfold 
		sDDxBlindFolds[3] = "Black Ebonite Unlocked"
		 DDxBlindFolds[3] = ZadxLib.EbblindfoldUnlocked 
		sDDxBlindFolds[4] = "Black Ebonite Blocking"
		 DDxBlindFolds[4] = ZadxLib.EbblindfoldBlocking 
		sDDxBlindFolds[5] = "Black Leather Unlocked"
		 DDxBlindFolds[5] = ZadxLib.blindfoldUnlocked
		sDDxBlindFolds[6] = "Black Leather Blocking" 
		 DDxBlindFolds[6] = ZadxLib.blindfoldBlocking 
		sDDxBlindFolds[7] = "White Ebonite"
		 DDxBlindFolds[7] = ZadxLib.wtEboniteBlindfold
		sDDxBlindFolds[8] = "White Ebonite Unlocked"  
		 DDxBlindFolds[8] = ZadxLib.WTEblindfoldUnlocked
		sDDxBlindFolds[9] = "White Ebonite Blocking"  
		 DDxBlindFolds[9] = ZadxLib.WTEblindfoldBlocking
		sDDxBlindFolds[10] = "White Leather"  
		 DDxBlindFolds[10] = ZadxLib.wtLeatherBlindfold
		sDDxBlindFolds[11] = "White Leather Unlocked" 
		 DDxBlindFolds[11] = ZadxLib.WTLblindfoldUnlocked 
		sDDxBlindFolds[12] = "White Leather Blocking" 
		 DDxBlindFolds[12] = ZadxLib.WTLblindfoldBlocking
		sDDxBlindFolds[13] = "Red Ebonite" 
		 DDxBlindFolds[13] = ZadxLib.rdEboniteBlindfold
		sDDxBlindFolds[14] = "Red Ebonite Unlocked"  
		 DDxBlindFolds[14] = ZadxLib.RDEblindfoldUnlocked
		sDDxBlindFolds[15] = "Red Ebonite Blocking" 
		 DDxBlindFolds[15] = ZadxLib.RDEblindfoldBlocking
		sDDxBlindFolds[16] = "Red Leather"  
		 DDxBlindFolds[16] = ZadxLib.rdLeatherBlindfold
		sDDxBlindFolds[17] = "Red Leather Unlocked"  
		 DDxBlindFolds[17] = ZadxLib.RDLblindfoldUnlocked
		sDDxBlindFolds[18] = "Red Leather Blocking" 
		 DDxBlindFolds[18] = ZadxLib.RDLblindfoldBlocking  
		sDDxBlindFolds[19] = "Natural Rope"  
		 DDxBlindFolds[19] = ZadxLib.zadx_blindfold_Rope_Inventory 
EndFunction 
;bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb

;Gag Slot No. 44
;ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
STRING[] Property sDDeGags Auto Hidden	
FORM[] Property DDeGags Auto Hidden
Function iDDeSetGags()
	sDDeGags = NEW STRING[75]
	 DDeGags = NEW FORM[75]
	  sDDeGags[0] = "No DDe Gag"
		 DDeGags[0] = None		 
		sDDeGags[1] = "Falmer Harness Ball"
		 DDeGags[1] = iDDe_FalmerGagHarnessBall_Inv
		sDDeGags[2] = "Falmer Harness Panel"
		 DDeGags[2] = iDDe_FalmerGagHarnessPanel_Inv
		sDDeGags[3] = "Falmer Harness Ring"
		 DDeGags[3] = iDDe_FalmerGagHarnessRing_Inv
		sDDeGags[4] = "Falmer Ball"
		 DDeGags[4] = iDDe_FalmerGagStrapBall_Inv
		sDDeGags[5] = "Falmer Ring"
		 DDeGags[5] = iDDe_FalmerGagStrapRing_Inv 
		sDDeGags[6] = "Wood Ball"
		 DDeGags[6] = iDDe_WoodGagStrapBall_Inv
		sDDeGags[7] = "Gold Bit"
		 DDeGags[7] = iDDe_GoldGagBit_Inv
		sDDeGags[8] = "Gold Harness Ball"
		 DDeGags[8] = iDDe_GoldGagHarnessBall_Inv
		sDDeGags[9] = "Gold Ball"
		 DDeGags[9] = iDDe_GoldGagStrapBall_Inv
		sDDeGags[10] = "Gold Ring"
		 DDeGags[10] = iDDe_GoldGagStrapRing_Inv
		sDDeGags[11] = "Inox Bit"
		 DDeGags[11] = iDDe_InoxGagBit_Inv
		sDDeGags[12] = "Inox Harness Ball"
		 DDeGags[12] = iDDe_InoxGagHarnessBall_Inv
		sDDeGags[13] = "Inox Harness Ring"
		 DDeGags[13] = iDDe_InoxGagHarnessRing_Inv
		sDDeGags[14] = "Inox Ball"
		 DDeGags[14] = iDDe_InoxGagStrapBall_Inv
		sDDeGags[15] = "Inox Ring"
		 DDeGags[15] = iDDe_InoxGagStrapRing_Inv
		sDDeGags[16] = "Lite Wood Ball"
		 DDeGags[16] = iDDe_LteWoodGagStrapBall_Inv
		sDDeGags[17] = "Rusty Harness Ball"
		 DDeGags[17] = iDDe_RustyGagHarnessBall_Inv
		sDDeGags[18] = "Rusty Harness Ring"
		 DDeGags[18] = iDDe_RustyGagHarnessRing_Inv
		sDDeGags[19] = "Rusty Ball"
		 DDeGags[19] = iDDe_RustyGagStrapBall_Inv
		sDDeGags[20] = "Rusty Ring"
		 DDeGags[20] = iDDe_RustyGagStrapRing_Inv
		sDDeGags[21] = "Chromo-Hex Harness Ball"
		 DDeGags[21] = iDDe_HexChGagHarnessBall_Inv
		sDDeGags[22] = "Chromo-Hex Harness Ring"
		 DDeGags[22] = iDDe_HexChGagHarnessRing_Inv
		sDDeGags[23] = "Chromo-Hex Ball"
		 DDeGags[23] = iDDe_HexChGagStrapBall_Inv
		sDDeGags[24] = "Chromo-Hex Ring"
		 DDeGags[24] = iDDe_HexChGagStrapRing_Inv
		sDDeGags[25] = "Red Hex Harness Ball"
		 DDeGags[25] = iDDe_HexRdGagHarnessBall_Inv
		sDDeGags[26] = "Red Hex Harness Ring"
		 DDeGags[26] = iDDe_HexRdGagHarnessRing_Inv
		sDDeGags[27] = "Red Hex Ball"
		 DDeGags[27] = iDDe_HexRdGagStrapBall_Inv
		sDDeGags[28] = "Red Hex Ring"
		 DDeGags[28] = iDDe_HexRdGagStrapRing_Inv
		sDDeGags[29] = "Hypnotic Harness Ball"
		 DDeGags[29] = iDDe_HypGagHarnessBall_Inv
		sDDeGags[30] = "Hypnotic Harness Ring"
		 DDeGags[30] = iDDe_HypGagHarnessRing_Inv
		sDDeGags[31] = "Hypnotic Ball"
		 DDeGags[31] = iDDe_HypGagStrapBall_Inv
		sDDeGags[32] = "Hypnotic Ring"
		 DDeGags[32] = iDDe_HypGagStrapRing_Inv
		sDDeGags[33] = "Jade Bit"
		 DDeGags[33] = iDDe_JadeGagBit_Inv
		sDDeGags[34] = "Jade Harness Ball"
		 DDeGags[34] = iDDe_JadeGagHarnessBall_Inv
		sDDeGags[35] = "Jade Harness Ring"
		 DDeGags[35] = iDDe_JadeGagHarnessRing_Inv
		sDDeGags[36] = "Jade Ball"
		 DDeGags[36] = iDDe_JadeGagStrapBall_Inv
		sDDeGags[37] = "Jade Ring"
		 DDeGags[37] = iDDe_JadeGagStrapRing_Inv
		sDDeGags[38] = "Fifa Bit"
		 DDeGags[38] = iDDe_FifaGagBit_Inv
		sDDeGags[39] = "Fifa Harness Ball"
		 DDeGags[39] = iDDe_FifaGagHarnessBall_Inv
		sDDeGags[40] = "Fifa Harness Ring"
		 DDeGags[40] = iDDe_FifaGagHarnessRing_Inv
		sDDeGags[41] = "Fifa Ball"
		 DDeGags[41] = iDDe_FifaGagStrapBall_Inv
		sDDeGags[42] = "Fifa Ring"
		 DDeGags[42] = iDDe_FifaGagStrapRing_Inv
		sDDeGags[43] = "Fire Bit"
		 DDeGags[43] = iDDe_FireGagBit_Inv
		sDDeGags[44] = "Fire Harness Ball"
		 DDeGags[44] = iDDe_FireGagHarnessBall_Inv
		sDDeGags[45] = "Fire Harness Ring"
		 DDeGags[45] = iDDe_FireGagHarnessRing_Inv
		sDDeGags[46] = "Fire Ball"
		 DDeGags[46] = iDDe_FireGagStrapBall_Inv
		sDDeGags[47] = "Fire Ring"
		 DDeGags[47] = iDDe_FireGagStrapRing_Inv
		sDDeGags[48] = "Rope Ball"
		 DDeGags[48] = iDDe_RopeGagStrapBall_Inv
		sDDeGags[49] = "Brown Leather Bit"
		 DDeGags[49] = iDDe_LeBrGagBit_Inv
		sDDeGags[50] = "Brown Leather Harness Ball"
		 DDeGags[50] = iDDe_LeBrGagHarnessBall_Inv
		sDDeGags[51] = "Brown Leather Harness Ring"
		 DDeGags[51] = iDDe_LeBrGagHarnessRing_Inv
		sDDeGags[52] = "Brown Leather Ball"
		 DDeGags[52] = iDDe_LeBrGagStrapBall_Inv
		sDDeGags[53] = "Brown Leather Ring"
		 DDeGags[53] = iDDe_LeBrGagStrapRing_Inv
		sDDeGags[54] = "Crimson Bit"
		 DDeGags[54] = iDDe_CrimsonGagBit_Inv
		sDDeGags[55] = "Crimson Harness Ball"
		 DDeGags[55] = iDDe_CrimsonGagHarnessBall_Inv
		sDDeGags[56] = "Crimson Harness Ring"
		 DDeGags[56] = iDDe_CrimsonGagHarnessRing_Inv
		sDDeGags[57] = "Crimson Ball"
		 DDeGags[57] = iDDe_CrimsonGagStrapBall_Inv
		sDDeGags[58] = "Crimson Ring"
		 DDeGags[58] = iDDe_CrimsonGagStrapRing_Inv
		sDDeGags[59] = "Orange-Hex Harness Ball"
		 DDeGags[59] = iDDe_HexOrGagHarnessBall_Inv
		sDDeGags[60] = "Orange-Hex Harness Ring"
		 DDeGags[60] = iDDe_HexOrGagHarnessRing_Inv
		sDDeGags[61] = "Orange-Hex Strap Ball"
		 DDeGags[61] = iDDe_HexOrGagStrapBall_Inv
		sDDeGags[62] = "Orange-Hex Strap Ring"
		 DDeGags[62] = iDDe_HexOrGagStrapRing_Inv	
		sDDeGags[63] = "Bumblebee Bit"
		 DDeGags[63] = iDDe_BumbeeGagBit_Inv
		sDDeGags[64] = "Bumblebee Harness Ball"
		 DDeGags[64] = iDDe_BumbeeGagHarnessBall_Inv
		sDDeGags[65] = "Bumblebee Harness Ring"
		 DDeGags[65] = iDDe_BumbeeGagHarnessRing_Inv
		sDDeGags[66] = "Bumblebee Strap Ball"
		 DDeGags[66] = iDDe_BumbeeGagStrapBall_Inv
		sDDeGags[67] = "Bumblebee Strap Ring"
		 DDeGags[67] = iDDe_BumbeeGagStrapRing_Inv
		sDDeGags[68] = "Wood Harness Ball"
		 DDeGags[68] = iDDe_WoodGagHarnessBall_Inv
		sDDeGags[69] = "Rope Harness Ball"
		 DDeGags[69] = iDDe_RopeGagHarnessBall_Inv
		sDDeGags[70] = "Rope Harness Ring"
		 DDeGags[70] = iDDe_RopeGagHarnessRing_Inv
		sDDeGags[71] = "Lite Wood Harness Ball"
		 DDeGags[71] = iDDe_LteWoodGagHarnessBall_Inv
		sDDeGags[72] = "Lite Wood Harness Ring"
		 DDeGags[72] = iDDe_LteWoodGagHarnessRing_Inv
		sDDeGags[73] = "Inox Mech Suit Gag"
		 DDeGags[73] = iDDe_InoxMechSuitGag_Inv
		sDDeGags[74] = "Dwemer Mech Suit Gag"
		 DDeGags[74] = iDDe_DwemerMechSuitGag_Inv 	  
EndFunction  
STRING[] Property sDDxGags Auto Hidden	
FORM[] Property DDxGags Auto Hidden
Function iDDeSetGagsDDx()
	sDDxGags = NEW STRING[81]
	 DDxGags = NEW FORM[81]
    sDDxGags[0] = "No DDx Gag"
		 DDxGags[0] = None
		sDDxGags[1] = "Harness Ball"
		 DDxGags[1] = ZadLib.gagBall
		sDDxGags[2] = "Strap Ball"
		 DDxGags[2] = ZadLib.gagStrapBall
		sDDxGags[3] = "Harness Ring"
		 DDxGags[3] = ZadLib.gagRing
		sDDxGags[4] = "Strap Ring"
		 DDxGags[4] = ZadLib.gagStrapRing
		sDDxGags[5] = "Panel "
		 DDxGags[5] = ZadLib.gagPanel
		sDDxGags[6] = "Black Ebonite Harness Ball"
		 DDxGags[6] = ZadxLib.gagEboniteBall
		sDDxGags[7] = "Black Ebonite Harness Ring"
		 DDxGags[7] = ZadxLib.gagEboniteRing
		sDDxGags[8] = "Black Ebonite Panel"
		 DDxGags[8] = ZadxLib.gagEbonitePanel
		sDDxGags[9] = "Black Ebonite Ball"
		 DDxGags[9] = ZadxLib.gagEboniteStrapBall
		sDDxGags[10] = "Black Ebonite Ring"
		 DDxGags[10] = ZadxLib.gagEboniteStrapRing
		sDDxGags[11] = "White Ebonite Harness Ball"
		 DDxGags[11] = ZadxLib.gagWTEboniteBall
		sDDxGags[12] = "White Ebonite Harness Ring"
		 DDxGags[12] = ZadxLib.gagWTEboniteRing
		sDDxGags[13] = "White Ebonite Panel"
		 DDxGags[13] = ZadxLib.gagWTEbonitePanel
		sDDxGags[14] = "White Ebonite Ball"
		 DDxGags[14] = ZadxLib.gagWTEboniteStrapBall
		sDDxGags[15] = "White Ebonite Ring"
		 DDxGags[15] = ZadxLib.gagWTEboniteStrapRing
		sDDxGags[16] = "White Leather Harness Ball"
		 DDxGags[16] = ZadxLib.gagWTLeatherBall
		sDDxGags[17] = "White Leather Harness Ring"
		 DDxGags[17] = ZadxLib.gagWTLeatherRing
		sDDxGags[18] = "White Leather Panel"
		 DDxGags[18] = ZadxLib.gagWTLeatherPanel
		sDDxGags[19] = "White Leather Ball"
		 DDxGags[19] = ZadxLib.gagWTLeatherStrapBall
		sDDxGags[20] = "White Leather Ring"
		 DDxGags[20] = ZadxLib.gagWTLeatherStrapRing
		sDDxGags[21] = "Red Ebonite Harness Ball"
		 DDxGags[21] = ZadxLib.gagRDEboniteBall
		sDDxGags[22] = "Red Ebonite Harness Ring"
		 DDxGags[22] = ZadxLib.gagRDEboniteRing
		sDDxGags[23] = "Red Ebonite Panel"
		 DDxGags[23] = ZadxLib.gagRDEbonitePanel
		sDDxGags[24] = "Red Ebonite Ball"
		 DDxGags[24] = ZadxLib.gagRDEboniteStrapBall
		sDDxGags[25] = "Red Ebonite Ring"
		 DDxGags[25] = ZadxLib.gagRDEboniteStrapRing
		sDDxGags[26] = "Red Leather Harness Ball"
		 DDxGags[26] = ZadxLib.gagRDLeatherBall
		sDDxGags[27] = "Red Leather Harness Ring"
		 DDxGags[27] = ZadxLib.gagRDLeatherRing
		sDDxGags[28] = "Red Leather Panel"
		 DDxGags[28] = ZadxLib.gagRDLeatherPanel
		sDDxGags[29] = "Red Leather Ball"
		 DDxGags[29] = ZadxLib.gagRDLeatherStrapBall
		sDDxGags[30] = "Red Leather Ring"
		 DDxGags[30] = ZadxLib.gagRDLeatherStrapRing
		sDDxGags[31] = "HR Bridle Base"
		 DDxGags[31] = ZadxLib.zadx_HR_BridleBaseInventory
		sDDxGags[32] = "HR Bridle Half"
		 DDxGags[32] = ZadxLib.zadx_HR_BridleHalfInventory
		sDDxGags[33] = "HR Bridle Full"
		 DDxGags[33] = ZadxLib.zadx_HR_BridleFullInventory
		sDDxGags[34] = "HR Bridle Base Rusty"
		 DDxGags[34] = ZadxLib.zadx_HR_RustyBridleBaseInventory
		sDDxGags[35] = "HR Bridle Half Rusty"
		 DDxGags[35] = ZadxLib.zadx_HR_RustyBridleHalfInventory
		sDDxGags[36] = "HR Bridle Full Rusty"
		 DDxGags[36] = ZadxLib.zadx_HR_RustyBridleFullInventory
		sDDxGags[37] = "HR Pear"
		 DDxGags[37] = ZadxLib.zadx_HR_PearGagInventory
		sDDxGags[38] = "HR Pear Rusty"
		 DDxGags[38] = ZadxLib.zadx_HR_RustyPearGagInventory
		sDDxGags[39] = "HR Iron Bit"
		 DDxGags[39] = ZadxLib.zadx_HR_IronBitGagInventory
		sDDxGags[40] = "HR Iron Bit Wood"
		 DDxGags[40] = ZadxLib.zadx_HR_IronBitGagWoodInventory
		sDDxGags[41] = "HR Iron Ring"
		 DDxGags[41] = ZadxLib.zadx_HR_IronRingGagInventory
		sDDxGags[42] = "HR Iron Bit Rusty"
		 DDxGags[42] = ZadxLib.zadx_HR_RustyIronBitGagInventory
		sDDxGags[43] = "HR Iron Bit Wood Rusty"
		 DDxGags[43] = ZadxLib.zadx_HR_RustyIronBitGagWoodInventory
		sDDxGags[44] = "HR Iron Ring Rusty"
		 DDxGags[44] = ZadxLib.zadx_HR_RustyIronRingGagInventory
		sDDxGags[45] = "Black Ebonite Starp Big Ball"
		 DDxGags[45] = ZadxLib.zadx_GagEboniteStrapBallBig_Inventory
		sDDxGags[46] = "Black Ebonite Harness Big Ball"
		 DDxGags[46] = ZadxLib.zadx_GagEboniteHarnessBallBig_Inventory
		sDDxGags[47] = "Natural Rope Ball"
		 DDxGags[47] = ZadxLib.zadx_gag_rope_ball_Inventory
		sDDxGags[48] = "Natural Rope Bit"
		 DDxGags[48] = ZadxLib.zadx_gag_rope_bit_Inventory
		sDDxGags[49] = "Tape"
		 DDxGags[49] = ZadxLib2.zadx_gag_tape_Inventory
		sDDxGags[50] = "Tape Large"
		 DDxGags[50] = ZadxLib2.zadx_gag_tape_large_Inventory
		sDDxGags[51] = "Tape Full"
		 DDxGags[51] = ZadxLib2.zadx_gag_tape_full_Inventory
		sDDxGags[52] = "Extreme Black Ball"
		 DDxGags[52] = ZadxLib2.zadx_Gag_Ball_Extreme_Black_Inventory
		sDDxGags[53] = "Extreme Purple Ball"
		 DDxGags[53] = ZadxLib2.zadx_Gag_Ball_Extreme_Purple_Inventory
		sDDxGags[54] = "Extreme Red Ball"
		 DDxGags[54] = ZadxLib2.zadx_Gag_Ball_Extreme_Red_Inventory
		sDDxGags[55] = "Extreme Inflatable"
		 DDxGags[55] = ZadxLib2.zadx_Gag_Inflat_Extreme_Inventory
		sDDxGags[56] = "Extreme Panel"
		 DDxGags[56] = ZadxLib2.zadx_Gag_Panel_Extreme_Inventory
	 	sDDxGags[57] = "Pony Bit Black Leather"
		 DDxGags[57] = ZadxLib.zadx_dud_Pony_BitGag_Chin_Leather_BlackInventory
		sDDxGags[58] = "Pony Bit White Leather"
		 DDxGags[58] = ZadxLib.zadx_dud_Pony_BitGag_Chin_White_Leather_Inventory
		sDDxGags[59] = "Pony Bit Red Leather"
		 DDxGags[59] = ZadxLib.zadx_dud_Pony_BitGag_Chin_Red_Leather_Inventory
		sDDxGags[60] = "Pony Bit Black Ebonite"
		 DDxGags[60] = ZadxLib.zadx_dud_Pony_BitGag_Chin_Ebonite_BlackInventory
		sDDxGags[61] = "Pony Bit White Ebonite"
		 DDxGags[61] = ZadxLib.zadx_dud_Pony_BitGag_Chin_White_Ebonite_Inventory
		sDDxGags[62] = "Pony Bit Red Ebonite"
		 DDxGags[62] = ZadxLib.zadx_dud_Pony_BitGag_Chin_Red_Ebonite_Inventory
		sDDxGags[63] = "Pony Blinders Black Leather"
		 DDxGags[63] = ZadxLib.zadx_dud_Pony_Harness_Blinders_Leather_BlackInventory
		sDDxGags[64] = "Pony Blinders White Leather"
		 DDxGags[64] = ZadxLib.zadx_dud_Pony_Harness_Blinders_White_Leather_Inventory
		sDDxGags[65] = "Pony Blinders Red Leather"
		 DDxGags[65] = ZadxLib.zadx_dud_Pony_Harness_Blinders_Red_Leather_Inventory
		sDDxGags[66] = "Pony Blinders Black Ebonite"
		 DDxGags[66] = ZadxLib.zadx_dud_Pony_Harness_Blinders_Ebonite_BlackInventory
		sDDxGags[67] = "Pony Blinders White Ebonite"
		 DDxGags[67] = ZadxLib.zadx_dud_Pony_Harness_Blinders_White_Ebonite_Inventory
		sDDxGags[68] = "Pony Blinders Red Ebonite"
		 DDxGags[68] = ZadxLib.zadx_dud_Pony_Harness_Blinders_Red_Ebonite_Inventory
		sDDxGags[69] = "Pony Ears Black Leather"
		 DDxGags[69] = ZadxLib.zadx_dud_Pony_Harness_Ears_Leather_BlackInventory
		sDDxGags[70] = "Pony Ears White Leather"
		 DDxGags[70] = ZadxLib.zadx_dud_Pony_Harness_Ears_White_Leather_Inventory
		sDDxGags[71] = "Pony Ears Red Leather"
		 DDxGags[71] = ZadxLib.zadx_dud_Pony_Harness_Ears_Red_Leather_Inventory
		sDDxGags[72] = "Pony Ears Black Ebonite"
		 DDxGags[72] = ZadxLib.zadx_dud_Pony_Harness_Ears_Ebonite_BlackInventory
		sDDxGags[73] = "Pony Ears White Ebonite"
		 DDxGags[73] = ZadxLib.zadx_dud_Pony_Harness_Ears_White_Ebonite_Inventory
		sDDxGags[74] = "Pony Ears Red Ebonite"
		 DDxGags[74] = ZadxLib.zadx_dud_Pony_Harness_Ears_Red_Ebonite_Inventory
		sDDxGags[75] = "Pony Secure Black Leather"
		 DDxGags[75] = ZadxLib.zadx_dud_Pony_Harness_Secure_Leather_BlackInventory
		sDDxGags[76] = "Pony Secure White Leather"
		 DDxGags[76] = ZadxLib.zadx_dud_Pony_Harness_Secure_White_Leather_Inventory
		sDDxGags[77] = "Pony Secure Red Leather"
		 DDxGags[77] = ZadxLib.zadx_dud_Pony_Harness_Secure_Red_Leather_Inventory
		sDDxGags[78] = "Pony Secure Black Ebonite"
		 DDxGags[78] = ZadxLib.zadx_dud_Pony_Harness_Secure_Ebonite_BlackInventory
		sDDxGags[79] = "Pony Secure White Ebonite"
		 DDxGags[79] = ZadxLib.zadx_dud_Pony_Harness_Secure_White_Ebonite_Inventory
		sDDxGags[80] = "Pony Secure Red Ebonite"
		 DDxGags[80] = ZadxLib.zadx_dud_Pony_Harness_Secure_Red_Ebonite_Inventory
EndFunction
;ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg


;Hood Slot No. 31, 42, 44
;hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
STRING[] Property sDDeHoods Auto Hidden	
FORM[] Property DDeHoods Auto Hidden
Function iDDeSetHoods()
	sDDeHoods = NEW STRING[44]
	 DDeHoods = NEW FORM[44]
	  sDDeHoods[0] = "No DDe Hood"
		 DDeHoods[0] = None		 
		sDDeHoods[1] = "Wood Iron Mask"
		 DDeHoods[1] = iDDe_WoodIronMask_Inv
		sDDeHoods[2] = "Brown Leather Iron Mask"
		 DDeHoods[2] = iDDe_LeBrIronMask_Inv
		sDDeHoods[3] = "Black Leather Iron Mask"
		 DDeHoods[3] = iDDe_LeBkIronMask_Inv
		sDDeHoods[4] = "White Leather Iron Mask"
		 DDeHoods[4] = iDDe_LeWhIronMask_Inv
		sDDeHoods[5] = "Red Leather Iron Mask"
		 DDeHoods[5] = iDDe_LeRdIronMask_Inv
		sDDeHoods[6] = "Light Wood Iron Mask"
		 DDeHoods[6] = iDDe_LteWoodIronMask_Inv
		sDDeHoods[7] = "Crimson Iron Mask"
		 DDeHoods[7] = iDDe_CrimsonIronMask_Inv
		sDDeHoods[8] = "Black Ebonite Iron Mask"
		 DDeHoods[8] = iDDe_EbBkIronMask_Inv
		sDDeHoods[9] = "White Ebonite Iron Mask"
		 DDeHoods[9] = iDDe_EbWhIronMask_Inv
		sDDeHoods[10] = "Red Ebonite Iron Mask"
		 DDeHoods[10] = iDDe_EbRdIronMask_Inv
		sDDeHoods[11] = "Gold Iron Mask"
		 DDeHoods[11] = iDDe_GoldIronMask_Inv
		sDDeHoods[12] = "Inox Iron Mask"
		 DDeHoods[12] = iDDe_InoxIronMask_Inv
		sDDeHoods[13] = "Rope Iron Mask"
		 DDeHoods[13] = iDDe_RopeIronMask_Inv
		sDDeHoods[14] = "Rusty Iron Mask"
		 DDeHoods[14] = iDDe_RustyIronMask_Inv
		sDDeHoods[15] = "Red-Hex Iron Mask"
		 DDeHoods[15] = iDDe_HexRdIronMask_Inv	
		sDDeHoods[16] = "Orange-Hex Iron Mask"
		 DDeHoods[16] = iDDe_HexOrIronMask_Inv
		sDDeHoods[17] = "Iron Mask"
		 DDeHoods[17] = iDDe_IronMask_Inv
		sDDeHoods[18] = "Hypnotic Iron Mask"
		 DDeHoods[18] = iDDe_HypIronMask_Inv
		sDDeHoods[19] = "Jade Iron Mask"
		 DDeHoods[19] = iDDe_JadeIronMask_Inv
		sDDeHoods[20] = "Fifa Iron Mask"
		 DDeHoods[20] = iDDe_FifaIronMask_Inv
		sDDeHoods[21] = "Fire Iron Mask"
		 DDeHoods[21] = iDDe_FireIronMask_Inv
		sDDeHoods[22] = "Bumblebee Iron Mask"
		 DDeHoods[22] = iDDe_BumbeeIronMask_Inv
		sDDeHoods[23] = "Mech Suit Iron Mask"
		 DDeHoods[23] = iDDe_InoxMechSuitIronMask_Inv
		sDDeHoods[24] = "Mech Suit Iron Mask Long"
		 DDeHoods[24] = iDDe_InoxMechSuitIronMaskL_Inv
		sDDeHoods[25] = "Dwemer Suit Iron Mask"
		 DDeHoods[25] = iDDe_DwemerMechSuitIronMask_Inv
		sDDeHoods[26] = "Dwemer Suit Iron Mask Long"
		 DDeHoods[26] = iDDe_DwemerMechSuitIronMaskL_Inv
		sDDeHoods[27] = "Falmer Cat Hood"
		 DDeHoods[27] = iDDe_FalmerCatHood_Inv
		sDDeHoods[28] = "Brown Leather Cat Hood"
		 DDeHoods[28] = iDDe_LeBrCatHood_Inv
		sDDeHoods[29] = "Wood Cat Hood"
		 DDeHoods[29] = iDDe_WoodCatHood_Inv
		sDDeHoods[30] = "Lite Wood Cat Hood"
		 DDeHoods[30] = iDDe_LteWoodCatHood_Inv
		sDDeHoods[31] = "Gold Cat Hood"
		 DDeHoods[31] = iDDe_GoldCatHood_Inv
		sDDeHoods[32] = "Inox Cat Hood"
		 DDeHoods[32] = iDDe_InoxCatHood_Inv
		sDDeHoods[33] = "Rope Cat Hood"
		 DDeHoods[33] = iDDe_RopeCatHood_Inv
		sDDeHoods[34] = "Rusty Cat Hood"
		 DDeHoods[34] = iDDe_RustyCatHood_Inv
		sDDeHoods[35] = "Chromo-Hex Cat Hood"
		 DDeHoods[35] = iDDe_HexChCatHood_Inv
		sDDeHoods[36] = "Red-Hex Cat Hood"
		 DDeHoods[36] = iDDe_HexRdCatHood_Inv
		sDDeHoods[37] = "Orange-Hex Cat Hood"
		 DDeHoods[37] = iDDe_HexOrCatHood_Inv
		sDDeHoods[38] = "Hypnotic Cat Hood"
		 DDeHoods[38] = iDDe_HypCatHood_Inv
		sDDeHoods[39] = "Jade Cat Hood"
		 DDeHoods[39] = iDDe_JadeCatHood_Inv
		sDDeHoods[40] = "Fifa Cat Hood"
		 DDeHoods[40] = iDDe_FifaCatHood_Inv
		sDDeHoods[41] = "Fire Cat Hood"
		 DDeHoods[41] = iDDe_FireCatHood_Inv
		sDDeHoods[42] = "Crimson Cat Hood"
		 DDeHoods[42] = iDDe_CrimsonCatHood_Inv
		sDDeHoods[43] = "Bumblebee Cat Hood"
		 DDeHoods[43] = iDDe_BumbeeCatHood_Inv 
EndFunction
STRING[] Property sDDxHoods Auto Hidden	
FORM[] Property DDxHoods Auto Hidden
Function iDDeSetHoodsDDx()
	sDDxHoods = NEW STRING[22]
	 DDxHoods = NEW FORM[22]
	  sDDxHoods[0] = "No DDx Hood"
		 DDxHoods[0] = None		 
		sDDxHoods[1] = "Black Rubber Hood"
		 DDxHoods[1] = ZadxLib.zadx_hood_rubber_black_Inventory
		sDDxHoods[2] = "Black Leather Hood"
		 DDxHoods[2] = ZadxLib.zadx_hood_leather_black_Inventory
		sDDxHoods[3] = "Black Eyes Rubber Hood"
		 DDxHoods[3] = ZadxLib.zadx_hood_rubber_openeyes_black_Inventory
		sDDxHoods[4] = "Black Face Rubber Hood"
		 DDxHoods[4] = ZadxLib.zadx_hood_rubber_openface_black_Inventory
		sDDxHoods[5] = "Blue Cat"
		 DDxHoods[5] = ZadxLib.zadx_catsuit_gasmask_blue_Inventory
		sDDxHoods[6] = "Cyan Cat"
		 DDxHoods[6] = ZadxLib.zadx_catsuit_gasmask_cyan_Inventory
		sDDxHoods[7] = "Greener Cat"
		 DDxHoods[7] = ZadxLib.zadx_catsuit_gasmask_dgreen_Inventory
		sDDxHoods[8] = "Grayer Cat"
		 DDxHoods[8] = ZadxLib.zadx_catsuit_gasmask_dgrey_Inventory
		sDDxHoods[9] = "Reder Cat"
		 DDxHoods[9] = ZadxLib.zadx_catsuit_gasmask_dred_Inventory
		sDDxHoods[10] = "Gold Cat"
		 DDxHoods[10] = ZadxLib.zadx_catsuit_gasmask_gold_Inventory
		sDDxHoods[11] = "Orange Cat"
		 DDxHoods[11] = ZadxLib.zadx_catsuit_gasmask_orange_Inventory
		sDDxHoods[12] = "Pink Cat"
		 DDxHoods[12] = ZadxLib.zadx_catsuit_gasmask_pink_Inventory
		sDDxHoods[13] = "Purple Cat"
		 DDxHoods[13] = ZadxLib.zadx_catsuit_gasmask_purple_Inventory
		sDDxHoods[14] = "Red Cat"
		 DDxHoods[14] = ZadxLib.zadx_catsuit_gasmask_red_Inventory
		sDDxHoods[15] = "White Cat"
		 DDxHoods[15] = ZadxLib.zadx_catsuit_gasmask_white_Inventory	
		sDDxHoods[16] = "Yellow Cat"
		 DDxHoods[16] = ZadxLib.zadx_catsuit_gasmask_yellow_Inventory
		sDDxHoods[17] = "Trans"
		 DDxHoods[17] = ZadxLib.zadx_hood_rubber_transparent_Inventory
		sDDxHoods[18] = "Trans Face"
		 DDxHoods[18] = ZadxLib.zadx_hood_rubber_openface_transparent_Inventory
		sDDxHoods[19] = "Trans Eyes Mouth"
		 DDxHoods[19] = ZadxLib.zadx_hood_rubber_openeyesmouth_transparent_Inventory 
		sDDxHoods[20] = "Black Face Mask"
		 DDxHoods[20] = ZadxLib.zadx_gag_facemask_biz_black_Inventory
		sDDxHoods[21] = "Trans Face Mask"
		 DDxHoods[21] = ZadxLib.zadx_gag_facemask_biz_transparent_Inventory
EndFunction
;hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh 	
	
;Collar Slot No. 45
;ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
STRING[] Property sDDeCollars Auto Hidden	
FORM[] Property DDeCollars Auto Hidden
Function iDDeSetCollars()
	sDDeCollars = NEW STRING[62]
	 DDeCollars = NEW FORM[62]
		sDDeCollars[0] = "No DDe Collar"
		 DDeCollars[0] = None
		sDDeCollars[1] = "Falmer Posture"
		 DDeCollars[1] = iDDe_FalmerCollarPosture_Inv
		sDDeCollars[2] = "Falmer Posture Steel"
		 DDeCollars[2] = iDDe_FalmerCollarPosture_Inv
		sDDeCollars[3] = "Falmer Harness"
		 DDeCollars[3] = iDDe_FalmerHarnessCollar_Inv
		sDDeCollars[4] = "Falmer Rings"
		 DDeCollars[4] = iDDe_FalmerCuffsCollar_Inv
		sDDeCollars[5] = "Wood Posture"
		 DDeCollars[5] = iDDe_WoodCollarPosture_Inv
		sDDeCollars[6] = "Wood Tall"
		 DDeCollars[6] = iDDe_WoodCollarTall_Inv
		sDDeCollars[7] = "Wood Rings"
		 DDeCollars[7] = iDDe_WoodCuffsCollar_Inv
		sDDeCollars[8] = "Iron Posture"
		 DDeCollars[8] = iDDe_IronCollarPosture_Inv 
		sDDeCollars[9] = "Gold Shackles"
		 DDeCollars[9] = iDDe_GoldCollar_Inv
		sDDeCollars[10] = "Gold Posture"
		 DDeCollars[10] = iDDe_GoldCollarPosture_Inv
		sDDeCollars[11] = "Gold Rings"
		 DDeCollars[11] = iDDe_GoldCuffsCollar_Inv
		sDDeCollars[12] = "Gold Harness"
		 DDeCollars[12] = iDDe_GoldHarnessCollar_Inv
		sDDeCollars[13] = "Inox Shackles"
		 DDeCollars[13] = iDDe_InoxCollar_Inv
		sDDeCollars[14] = "Inox Posture"
		 DDeCollars[14] = iDDe_InoxCollarPosture_Inv
		sDDeCollars[15] = "Inox Rings"
		 DDeCollars[15] = iDDe_InoxCuffsCollar_Inv
		sDDeCollars[16] = "Inox Harness"
		 DDeCollars[16] = iDDe_InoxHarnessCollar_Inv
		sDDeCollars[17] = "Lite Wood Tall"
		 DDeCollars[17] = iDDe_LteWoodCollarTall_Inv
		sDDeCollars[18] = "Lite Wood Posture"
		 DDeCollars[18] = iDDe_LteWoodCollarPosture_Inv
		sDDeCollars[19] = "Lite Wood Rings"
		 DDeCollars[19] = iDDe_LteWoodCuffsCollar_Inv
		sDDeCollars[20] = "Rusty Posture"
		 DDeCollars[20] = iDDe_RustyCollarPosture_Inv
		sDDeCollars[21] = "Rusty Rings"
		 DDeCollars[21] = iDDe_RustyCuffsCollar_Inv
		sDDeCollars[22] = "Rusty Harness"
		 DDeCollars[22] = iDDe_RustyHarnessCollar_Inv
		sDDeCollars[23] = "Chromo-Hex Tall"
		 DDeCollars[23] = iDDe_HexChCollarTall_Inv
		sDDeCollars[24] = "Chromo-Hex Posture"
		 DDeCollars[24] = iDDe_HexChCollarPosture_Inv
		sDDeCollars[25] = "Chromo-Hex Rings"
		 DDeCollars[25] = iDDe_HexChCuffsCollar_Inv
		sDDeCollars[26] = "Chromo-Hex Harness"
		 DDeCollars[26] = iDDe_HexChHarnessCollar_Inv
		sDDeCollars[27] = "Red Hex Posture"
		 DDeCollars[27] = iDDe_HexRdCollarPosture_Inv
		sDDeCollars[28] = "Red Hex Rings"
		 DDeCollars[28] = iDDe_HexRdCuffsCollar_Inv
		sDDeCollars[29] = "Red Hex Harness"
		 DDeCollars[29] = iDDe_HexRdHarnessCollar_Inv
		sDDeCollars[30] = "Hypnotic Posture"
		 DDeCollars[30] = iDDe_HypCollarPosture_Inv
		sDDeCollars[31] = "Hypnotic Rings"
		 DDeCollars[31] = iDDe_HypCuffsCollar_Inv
		sDDeCollars[32] = "Hypnotic Harness"
		 DDeCollars[32] = iDDe_HypHarnessCollar_Inv
		sDDeCollars[33] = "Jade Shackles"
		 DDeCollars[33] = iDDe_JadeCollar_Inv
		sDDeCollars[34] = "Jade Posture"
		 DDeCollars[34] = iDDe_JadeCollarPosture_Inv
		sDDeCollars[35] = "Jade Rings"
		 DDeCollars[35] = iDDe_JadeCuffsCollar_Inv
		sDDeCollars[36] = "Jade Harness"
		 DDeCollars[36] = iDDe_JadeHarnessCollar_Inv
		sDDeCollars[37] = "Fifa Shackles"
		 DDeCollars[37] = iDDe_FifaCollar_Inv
		sDDeCollars[38] = "Fifa Posture"
		 DDeCollars[38] = iDDe_FifaCollarPosture_Inv
		sDDeCollars[39] = "Fifa Rings"
		 DDeCollars[39] = iDDe_FifaCuffsCollar_Inv
		sDDeCollars[40] = "Fifa Harness"
		 DDeCollars[40] = iDDe_FifaHarnessCollar_Inv
		sDDeCollars[41] = "Fire Shackles"
		 DDeCollars[41] = iDDe_FireCollar_Inv
		sDDeCollars[42] = "Fire Posture"
		 DDeCollars[42] = iDDe_FireCollarPosture_Inv
		sDDeCollars[43] = "Fire Rings"
		 DDeCollars[43] = iDDe_FireCuffsCollar_Inv
		sDDeCollars[44] = "Fire Harness"
		 DDeCollars[44] = iDDe_FireHarnessCollar_Inv
		sDDeCollars[45] = "Rope Posture"
		 DDeCollars[45] = iDDe_RopeCollarPosture_Inv
		sDDeCollars[46] = "Rope Tall"
		 DDeCollars[46] = iDDe_RopeCollarTall_Inv
		sDDeCollars[47] = "Rope Rings"
		 DDeCollars[47] = iDDe_RopeCuffsCollar_Inv	
		sDDeCollars[48] = "Brown Leather Posture"
		 DDeCollars[48] = iDDe_LeBrCollarPosture_Inv
		sDDeCollars[49] = "Brown Leather Rings"
		 DDeCollars[49] = iDDe_LeBrCuffsCollar_Inv
		sDDeCollars[50] = "Brown Leather Harness"
		 DDeCollars[50] = iDDe_LeBrHarnessCollar_Inv 	
		sDDeCollars[51] = "Crimson Shackles"
		 DDeCollars[51] = iDDe_CrimsonCollar_Inv
		sDDeCollars[52] = "Crimson Posture"
		 DDeCollars[52] = iDDe_CrimsonCollarPosture_Inv
		sDDeCollars[53] = "Crimson Rings"
		 DDeCollars[53] = iDDe_CrimsonCuffsCollar_Inv
		sDDeCollars[54] = "Crimson Harness"
		 DDeCollars[54] = iDDe_CrimsonHarnessCollar_Inv
		sDDeCollars[55] = "Orange-Hex Posture"
		 DDeCollars[55] = iDDe_HexOrCollarPosture_Inv
		sDDeCollars[56] = "Orange-Hex Rings"
		 DDeCollars[56] = iDDe_HexOrCuffsCollar_Inv
		sDDeCollars[57] = "Orange-Hex Harness"
		 DDeCollars[57] = iDDe_HexOrHarnessCollar_Inv	
		sDDeCollars[58] = "Bumblebee Shackles"
		 DDeCollars[58] = iDDe_BumbeeCollar_Inv
		sDDeCollars[59] = "Bumblebee Posture"
		 DDeCollars[59] = iDDe_BumbeeCollarPosture_Inv
		sDDeCollars[60] = "Bumblebee Rings"
		 DDeCollars[60] = iDDe_BumbeeCuffsCollar_Inv 	
		sDDeCollars[61] = "Bumblebee Harness"
		 DDeCollars[61] = iDDe_BumbeeHarnessCollar_Inv 
EndFunction
STRING[] Property sDDxCollars Auto Hidden	
FORM[] Property DDxCollars Auto Hidden
Function iDDeSetCollarsDDx() 
	sDDxCollars = NEW STRING[56]
	 DDxCollars = NEW FORM[56]
		sDDxCollars[0] = "No DDx Collar"
		 DDxCollars[0] = None
		sDDxCollars[1] = "Restrictive"
		 DDxCollars[1] = ZadLib.collarRestrictive	
		sDDxCollars[2] = "Metal Paded"
		 DDxCollars[2] = ZadLib.cuffsPaddedCollar
		sDDxCollars[3] = "Metal Paded Posture"
		 DDxCollars[3] = ZadLib.collarPosture
		sDDxCollars[4] = "Harness"
		 DDxCollars[4] = ZadLib.harnessCollar
		sDDxCollars[5] = "Black Leather Posture"
		 DDxCollars[5] = ZadLib.collarPostureLeather
		sDDxCollars[6] = "Black Leather "
		 DDxCollars[6] = ZadLib.cuffsLeatherCollar
		sDDxCollars[7] = "Black Ebonite"
		 DDxCollars[7] = ZadxLib.cuffsEboniteCollar
		sDDxCollars[8] = "Black Ebonite Posture"
		 DDxCollars[8] = ZadxLib.collarPostureEbonite
		sDDxCollars[9] = "Black Ebonite Restrictive"
		 DDxCollars[9] = ZadxLib.EbRestrictiveCollar
		sDDxCollars[10] = "White Ebonite"
		 DDxCollars[10] = ZadxLib.cuffsWTEboniteCollar
		sDDxCollars[11] = "White Ebonite Posture"
		 DDxCollars[11] = ZadxLib.collarPostureWTEbonite
		sDDxCollars[12] = "White Ebonite Restrictive"
		 DDxCollars[12] = ZadxLib.WTErestrictiveCollar
		sDDxCollars[13] = "White Leather"
		 DDxCollars[13] = ZadxLib.cuffsWTLeatherCollar
		sDDxCollars[14] = "White Leather Posture"
		 DDxCollars[14] = ZadxLib.collarPostureWTLeather
		sDDxCollars[15] = "White Leather Restrictive"
		 DDxCollars[15] = ZadxLib.WTLrestrictiveCollar
		sDDxCollars[16] = "Red Ebonite"
		 DDxCollars[16] = ZadxLib.cuffsRDEboniteCollar
		sDDxCollars[17] = "Red Ebonite Posture"
		 DDxCollars[17] = ZadxLib.collarPostureRDEbonite
		sDDxCollars[18] = "Red Ebonite Restrictive"
		 DDxCollars[18] = ZadxLib.RDErestrictiveCollar
		sDDxCollars[19] = "Red Leather"
		 DDxCollars[19] = ZadxLib.cuffsRDLeatherCollar
		sDDxCollars[20] = "Red Leather Posture"
		 DDxCollars[20] = ZadxLib.collarPostureRDLeather
		sDDxCollars[21] = "Red Leather Restrictive"
		 DDxCollars[21] = ZadxLib.RDLrestrictiveCollar
		sDDxCollars[22] = "Black Ebonite Harness"
		 DDxCollars[22] = ZadxLib.eboniteHarnessCollar
		sDDxCollars[23] = "White Ebonite Harness"
		 DDxCollars[23] = ZadxLib.wtEboniteHarnessCollar
		sDDxCollars[24] = "White Leather Harness"
		 DDxCollars[24] = ZadxLib.wtLeatherHarnessCollar
		sDDxCollars[25] = "Red Ebonite Harness"
		 DDxCollars[25] = ZadxLib.rdEboniteHarnessCollar
		sDDxCollars[26] = "Red Leather Harness"
		 DDxCollars[26] = ZadxLib.rdLeatherHarnessCollar
		sDDxCollars[27] = "HR Iron"
		 DDxCollars[27] = ZadxLib.zadx_HR_IronCollarInventory 	
		sDDxCollars[28] = "HR Iron Rusty"
		 DDxCollars[28] = ZadxLib.zadx_HR_RustyIronCollarInventory
		sDDxCollars[29] = "HR Iron Mask of Shame"
		 DDxCollars[29] = ZadxLib.zadx_HR_MaskofShameInventory
		sDDxCollars[30] = "Natural Rope 1"
		 DDxCollars[30] = ZadxLib.zadx_Collar_Rope_1_Inventory
		sDDxCollars[31] = "Natural Rope 2"
		 DDxCollars[31] = ZadxLib.zadx_Collar_Rope_2_Inventory
		sDDxCollars[32] = "Trans Restrictive"
		 DDxCollars[32] = ZadxLib.zadx_restrictiveCollarTrans_Inventory
		sDDxCollars[33] = "Gold Posture"
		 DDxCollars[33] = ZadxLib.zadx_Collar_Posture_Gold_Inventory
		sDDxCollars[34] = "Silver Posture"
		 DDxCollars[34] = ZadxLib.zadx_Collar_Posture_Silver_Inventory
		sDDxCollars[35] = "Gold Padded"
		 DDxCollars[35] = ZadxLib.zadx_cuffs_Padded_Collar_Gold_Inventory
		sDDxCollars[36] = "Silver Padded"
		 DDxCollars[36] = ZadxLib.zadx_cuffs_Padded_Collar_Silver_Inventory
		sDDxCollars[37] = "Black Cat"
		 DDxCollars[37] = ZadxLib.zadx_catsuit_collar_black_Inventory 	
		sDDxCollars[38] = "Blue Cat"
		 DDxCollars[38] = ZadxLib.zadx_catsuit_collar_blue_Inventory
		sDDxCollars[39] = "Cyan Cat"
		 DDxCollars[39] = ZadxLib.zadx_catsuit_collar_cyan_Inventory
		sDDxCollars[40] = "Greener Cat"
		 DDxCollars[40] = ZadxLib.zadx_catsuit_collar_dgreen_Inventory
		sDDxCollars[41] = "Grayer Cat"
		 DDxCollars[41] = ZadxLib.zadx_catsuit_collar_dgrey_Inventory
		sDDxCollars[42] = "Reder Cat"
		 DDxCollars[42] = ZadxLib.zadx_catsuit_collar_dred_Inventory
		sDDxCollars[43] = "Gold Cat"
		 DDxCollars[43] = ZadxLib.zadx_catsuit_collar_gold_Inventory
		sDDxCollars[44] = "Orange Cat"
		 DDxCollars[44] = ZadxLib.zadx_catsuit_collar_orange_Inventory
		sDDxCollars[45] = "Pink Cat"
		 DDxCollars[45] = ZadxLib.zadx_catsuit_collar_pink_Inventory
		sDDxCollars[46] = "Purple Cat"
		 DDxCollars[46] = ZadxLib.zadx_catsuit_collar_purple_Inventory
		sDDxCollars[47] = "Red Cat"
		 DDxCollars[47] = ZadxLib.zadx_catsuit_collar_red_Inventory 	
		sDDxCollars[48] = "White Cat"
		 DDxCollars[48] = ZadxLib.zadx_catsuit_collar_white_Inventory
		sDDxCollars[49] = "Yellow Cat"
		 DDxCollars[49] = ZadxLib.zadx_catsuit_collar_yellow_Inventory 
		sDDxCollars[50] = "Red Paded"
		 DDxCollars[50] = ZadxLib2.zadx_cuffs_Padded_Collar_Red_Inventory
		sDDxCollars[51] = "White Paded"
		 DDxCollars[51] = ZadxLib2.zadx_cuffs_Padded_Collar_White_Inventory
		sDDxCollars[52] = "Black Paded"
		 DDxCollars[52] = ZadxLib2.zadx_cuffs_Padded_Collar_Black_Inventory
		sDDxCollars[53] = "Red Paded Posture"
		 DDxCollars[53] = ZadxLib2.zadx_Collar_Posture_Red_Inventory
		sDDxCollars[54] = "White Paded Posture"
		 DDxCollars[54] = ZadxLib2.zadx_Collar_Posture_White_Inventory
		sDDxCollars[55] = "Black Paded Posture"
		 DDxCollars[55] = ZadxLib2.zadx_Collar_Posture_Black_Inventory
EndFunction
STRING[] Property sCDxCollars Auto Hidden	
FORM[] Property CDxCollars Auto Hidden
Function iDDeSetCollarsCDx() 
	If (bGotCD)
		sCDxCollars = iDDeCDxUtil.SetCollarsCDxStr()
		 CDxCollars = iDDeCDxUtil.SetCollarsCDxForm()
	Else
		sCDxCollars = NEW STRING[1]
		 CDxCollars = NEW FORM[1]
			sCDxCollars[0] = "No CD"
			 CDxCollars[0] = None
	EndIf
EndFunction			
;ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

;Bra Slot No. 56
;bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
STRING[] Property sDDeBras Auto Hidden	
FORM[] Property DDeBras Auto Hidden
Function iDDeSetBras()
	sDDeBras = NEW STRING[25]
	 DDeBras = NEW FORM[25]
		sDDeBras[0] = "No DDe Bra"	
		 DDeBras[0] = None
		sDDeBras[1] = "Falmer "
		 DDeBras[1] = iDDe_FalmerBra_Inv
		sDDeBras[2] = "White Ebonite"
		 DDeBras[2] = iDDe_EbWhBra_Inv
		sDDeBras[3] = "Red Ebonite"
		 DDeBras[3] = iDDe_EbRdBra_Inv
		sDDeBras[4] = "White Leather"
		 DDeBras[4] = iDDe_LeWhBra_Inv
		sDDeBras[5] = "Red Leather"
		 DDeBras[5] = iDDe_LeRdBra_Inv
		sDDeBras[6] = "Wood "
		 DDeBras[6] = iDDe_WoodBra_Inv
		sDDeBras[7] = "Iron "
		 DDeBras[7] = iDDe_IronBra_Inv
		sDDeBras[8] = "Gold "
		 DDeBras[8] = iDDe_GoldBra_Inv
		sDDeBras[9] = "Inox "	
		 DDeBras[9] = iDDe_InoxBra_Inv
		sDDeBras[10] = "Lite Wood"
		 DDeBras[10] = iDDe_LteWoodBra_Inv
		sDDeBras[11] = "Rusty"
		 DDeBras[11] = iDDe_RustyBra_Inv
		sDDeBras[12] = "Chromo-Hex"	
		 DDeBras[12] = iDDe_HexChBra_Inv
		sDDeBras[13] = "Red Hex"
		 DDeBras[13] = iDDe_HexRdBra_Inv
		sDDeBras[14] = "Hypnotic"
		 DDeBras[14] = iDDe_HypBra_Inv
		sDDeBras[15] = "Black Ebonite"
		 DDeBras[15] = iDDe_EbBkBra_Inv 
		sDDeBras[16] = "Black Leather"
	 	 DDeBras[16] = iDDe_LeBkBra_Inv
		sDDeBras[17] = "Jade "
		 DDeBras[17] = iDDe_JadeBra_Inv
		sDDeBras[18] = "Fifa "
		 DDeBras[18] = iDDe_FifaBra_Inv
		sDDeBras[19] = "Fire "	
		 DDeBras[19] = iDDe_FireBra_Inv
		sDDeBras[20] = "Rope "	
		 DDeBras[20] = iDDe_RopeBra_Inv
		sDDeBras[21] = "Brown Leather"	
		 DDeBras[21] = iDDe_LeBrBra_Inv
		sDDeBras[22] = "Crimson "	
		 DDeBras[22] = iDDe_CrimsonBra_Inv
		sDDeBras[23] = "Orange-Hex "	
		 DDeBras[23] = iDDe_HexOrBra_Inv
		sDDeBras[24] = "Bumblebee "	
		 DDeBras[24] = iDDe_BumbeeBra_Inv 
EndFunction
STRING[] Property sDDxBras Auto Hidden	
FORM[] Property DDxBras Auto Hidden
Function iDDeSetBrasDDx()
	sDDxBras = NEW STRING[9]
	 DDxBras = NEW FORM[9]
		sDDxBras[0] = "No DDx Bra"	
		 DDxBras[0] = None
		sDDxBras[1] = "Metal Padded"
		 DDxBras[1] = ZadLib.braPadded
		sDDxBras[2] = "HR Chain Harness"
		 DDxBras[2] = ZadxLib.zadx_HR_ChainHarnessBraInventory
		sDDxBras[3] = "HR Chain Harness Rusty"
		 DDxBras[3] = ZadxLib.zadx_HR_RustyChainHarnessBraInventory
		sDDxBras[4] = "Gold Padded"	
		 DDxBras[4] = ZadxLib.zadx_chastitybra_Padded_Gold_Inventory
		sDDxBras[5] = "Silver Padded"
		 DDxBras[5] = ZadxLib.zadx_chastitybra_Padded_Silver_Inventory 
		sDDxBras[6] = "Red Padded"	
		 DDxBras[6] = ZadxLib2.zadx_chastitybra_Padded_Red_Inventory
		sDDxBras[7] = "White Padded"
		 DDxBras[7] = ZadxLib2.zadx_chastitybra_Padded_White_Inventory
		sDDxBras[8] = "Black Padded"
		 DDxBras[8] = ZadxLib2.zadx_chastitybra_Padded_Black_Inventory
EndFunction
STRING[] Property sCDxBras Auto Hidden	
FORM[] Property CDxBras Auto Hidden
Function iDDeSetBrasCDx()
	If (bGotCD)
	 	sCDxBras = iDDeCDxUtil.iDDeSetBrasCDxStr()
		 CDxBras = iDDeCDxUtil.iDDeSetBrasCDxForm()
	Else
		sCDxBras = NEW STRING[1]
		 CDxBras = NEW FORM[1]
			sCDxBras[0] = "No CD"	
			 CDxBras[0] = None	
	EndIf
EndFunction
;bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb

;Nipple Piercings Slot No. 51
;nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
STRING[] Property sDDxPieN Auto Hidden	
FORM[] Property DDxPieN Auto Hidden
Function iDDeSetPieNDDx()
	sDDxPieN = NEW STRING[12]
	 DDxPieN = NEW FORM[12]
		sDDxPieN[0] = "No DDx Nipple Piercings"
		 DDxPieN[0] = None
		sDDxPieN[1] = "Soul Gem"
		 DDxPieN[1] = ZadLib.piercingNSoul
		sDDxPieN[2] = "Common Soul Gem"
		 DDxPieN[2] = ZadxLib.PiercingsCommonSoulNips
		sDDxPieN[3] = "Shocking Soul Gem"
		 DDxPieN[3] = ZadxLib.PiercingsShockSoulNips
		sDDxPieN[4] = "HR Chain Harness Nipple"
		 DDxPieN[4] = ZadxLib.zadx_HR_ChainHarnessNippleInventory 
		sDDxPieN[5] = "HR Chain Harness Nipple Rusty"
		 DDxPieN[5] = ZadxLib.zadx_HR_RustyChainHarnessNippleInventory
		sDDxPieN[6] = "HR Nipple Clamps"
		 DDxPieN[6] = ZadxLib.zadx_HR_NippleClampsInventory
		sDDxPieN[7] = "HR Nipple Clamps Rusty"
		 DDxPieN[7] = ZadxLib.zadx_HR_RustyNippleClampsInventory
		sDDxPieN[8] = "HR Nipple Piercings"
		 DDxPieN[8] = ZadxLib.zadx_HR_NipplePiercingsInventory
		sDDxPieN[9] = "HR Nipple Piercings Rusty"
		 DDxPieN[9] = ZadxLib.zadx_HR_RustyNipplePiercingsInventory
		sDDxPieN[10] = "HR Nipple Chain Collar"
		 DDxPieN[10] = ZadxLib.zadx_HR_NippleChainCollarInventory
		sDDxPieN[11] = "HR Nipple Chain Collar Rusty"
		 DDxPieN[11] = ZadxLib.zadx_HR_RustyNippleChainCollarInventory 
EndFunction
;nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn

;Vag Piercings Slot No. 50
;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
STRING[] Property sDDxPieV Auto Hidden	
FORM[] Property DDxPieV Auto Hidden
Function iDDeSetPieVDDx()
	sDDxPieV = NEW STRING[4]
	 DDxPieV = NEW FORM[4]
		sDDxPieV[0] = "No DDx Vj Piercings"
		 DDxPieV[0] = None		
		sDDxPieV[1] = "Soul Gem"
		 DDxPieV[1] = ZadLib.piercingVSoul
		sDDxPieV[2] = "Common Soul Gem"
		 DDxPieV[2] = ZadxLib.PiercingsCommonSoulVag
		sDDxPieV[3] = "Shocking Soul Gem"
		 DDxPieV[3] = ZadxLib.PiercingsShockSoulVag
EndFunction
;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
 
;Arm Cuffs Slot No. 59
;aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
STRING[] Property sDDeCuffsA Auto Hidden	
FORM[] Property DDeCuffsA Auto Hidden
Function iDDeSetCuffsA()
	sDDeCuffsA = NEW STRING[18]
	 DDeCuffsA = NEW FORM[18]
		sDDeCuffsA[0] = "No DDe Arm Cuffs"	
		 DDeCuffsA[0] = None
		sDDeCuffsA[1] = "Falmer Rings"
		 DDeCuffsA[1] = iDDe_FalmerCuffsArms_Inv
		sDDeCuffsA[2] = "Wood Rings"
		 DDeCuffsA[2] = iDDe_WoodCuffsArms_Inv	
		sDDeCuffsA[3] = "Gold Rings"	
		 DDeCuffsA[3] = iDDe_GoldCuffsArms_Inv
		sDDeCuffsA[4] = "Inox Rings"	
		 DDeCuffsA[4] = iDDe_InoxCuffsArms_Inv
		sDDeCuffsA[5] = "Lite Wood Rings"	
		 DDeCuffsA[5] = iDDe_LteWoodCuffsArms_Inv
		sDDeCuffsA[6] = "Rusty Rings"	
		 DDeCuffsA[6] = iDDe_RustyCuffsArms_Inv
		sDDeCuffsA[7] = "Chromo-Hex Rings"	
		 DDeCuffsA[7] = iDDe_HexChCuffsArms_Inv 
		sDDeCuffsA[8] = "Red Hex Rings"	
		 DDeCuffsA[8] = iDDe_HexRdCuffsArms_Inv
		sDDeCuffsA[9] = "Hypnotic Rings"	
		 DDeCuffsA[9] = iDDe_HypCuffsArms_Inv
		sDDeCuffsA[10] = "Jade Rings"	
		 DDeCuffsA[10] = iDDe_JadeCuffsArms_Inv
		sDDeCuffsA[11] = "Fifa Rings"
		 DDeCuffsA[11] = iDDe_FifaCuffsArms_Inv
		sDDeCuffsA[12] = "Fire Rings"
		 DDeCuffsA[12] = iDDe_FireCuffsArms_Inv
		sDDeCuffsA[13] = "Rope Rings"
		 DDeCuffsA[13] = iDDe_RopeCuffsArms_Inv 
		sDDeCuffsA[14] = "Brown Leather Rings"	
		 DDeCuffsA[14] = iDDe_LeBrCuffsArms_Inv
		sDDeCuffsA[15] = "Crimson Rings"	
		 DDeCuffsA[15] = iDDe_CrimsonCuffsArms_Inv
		sDDeCuffsA[16] = "Orange-Hex Rings"	
		 DDeCuffsA[16] = iDDe_HexOrCuffsArms_Inv
		sDDeCuffsA[17] = "Bumblebee Rings"	
		 DDeCuffsA[17] = iDDe_BumbeeCuffsArms_Inv 
EndFunction
STRING[] Property sDDxCuffsA Auto Hidden	
FORM[] Property DDxCuffsA Auto Hidden
Function iDDeSetCuffsADDx()
	sDDxCuffsA = NEW STRING[19]
	 DDxCuffsA = NEW FORM[19]
		sDDxCuffsA[0] = "No DDx Arm Cuffs"	
		 DDxCuffsA[0] = None
		sDDxCuffsA[1] = "Metal Padded"
		 DDxCuffsA[1] = ZadLib.cuffsPaddedArms
		sDDxCuffsA[2] = "Leather"
		 DDxCuffsA[2] = ZadLib.cuffsLeatherArms
		sDDxCuffsA[3] = "Black Ebonite"
		 DDxCuffsA[3] = ZadxLib.cuffsEboniteArms
		sDDxCuffsA[4] = "White Ebonite"
		 DDxCuffsA[4] = ZadxLib.cuffsWTEboniteArms
		sDDxCuffsA[5] = "White Leather"
		 DDxCuffsA[5] = ZadxLib.cuffsWTLeatherArms
		sDDxCuffsA[6] = "Red Ebonite"
		 DDxCuffsA[6] = ZadxLib.cuffsRDEboniteArms
		sDDxCuffsA[7] = "Red Leather"
		 DDxCuffsA[7] = ZadxLib.cuffsRDLeatherArms
		sDDxCuffsA[8] = "HR Chain Harness"
		 DDxCuffsA[8] = ZadxLib.zadx_HR_ChainHarnessArmsInventory
		sDDxCuffsA[9] = "HR Chain Harness Rusty"
		 DDxCuffsA[9] = ZadxLib.zadx_HR_RustyChainHarnessArmsInventory
		sDDxCuffsA[10] = "Gold Padded"	
		 DDxCuffsA[10] = ZadxLib.zadx_cuffs_Padded_Arms_Gold_Inventory
		sDDxCuffsA[11] = "Silver Padded"
		 DDxCuffsA[11] = ZadxLib.zadx_cuffs_Padded_Arms_Silver_Inventory
		sDDxCuffsA[12] = "Rope Natural"
		 DDxCuffsA[12] = ZadxLib2.zadx_rope_cuffs_Arms_Inventory
		sDDxCuffsA[13] = "Rope Red"
		 DDxCuffsA[13] = ZadxLib2.zadx_rope_red_cuffs_Arms_Inventory
		sDDxCuffsA[14] = "Rope Black"	
		 DDxCuffsA[14] = ZadxLib2.zadx_rope_black_cuffs_Arms_Inventory
		sDDxCuffsA[15] = "Rope White"
		 DDxCuffsA[15] = ZadxLib2.zadx_rope_white_cuffs_Arms_Inventory
		sDDxCuffsA[16] = "Red Padded"	
		 DDxCuffsA[16] = ZadxLib2.zadx_cuffs_Padded_Arms_Red_Inventory
		sDDxCuffsA[17] = "White Padded"
		 DDxCuffsA[17] = ZadxLib2.zadx_cuffs_Padded_Arms_White_Inventory
		sDDxCuffsA[18] = "Black Padded"
		 DDxCuffsA[18] = ZadxLib2.zadx_cuffs_Padded_Arms_Black_Inventory
EndFunction		 	 
STRING[] Property sCDxCuffsA Auto Hidden	
FORM[] Property CDxCuffsA Auto Hidden
Function iDDeSetCuffsACDx()
	If (bGotCD)
		sCDxCuffsA = iDDeCDxUtil.iDDeSetCuffsACDxStr()
	 	 CDxCuffsA = iDDeCDxUtil.iDDeSetCuffsACDxForm()
	Else
		sCDxCuffsA = NEW STRING[1]
		 CDxCuffsA = NEW FORM[1]
			sCDxCuffsA[0] = "No CD"	
			 CDxCuffsA[0] = None
	EndIf				  
EndFunction 
;aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa

;Legs Cuffs Slot No. 53
;lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
STRING[] Property sDDeCuffsL Auto Hidden	
FORM[] Property DDeCuffsL Auto Hidden
Function iDDeSetCuffsL()
	sDDeCuffsL = NEW STRING[26]
	 DDeCuffsL = NEW FORM[26]	
		sDDeCuffsL[0] = "No DDe Leg Cuffs"	
		 DDeCuffsL[0] = None
		sDDeCuffsL[1] = "Falmer Rings"
		 DDeCuffsL[1] = iDDe_FalmerCuffsLegs_Inv	
		sDDeCuffsL[2] = "Wood Rings"
		 DDeCuffsL[2] = iDDe_WoodCuffsLegs_Inv	
		sDDeCuffsL[3] = "Iron Shackles"
		 DDeCuffsL[3] = iDDe_IronShacklesLegs_Inv
		sDDeCuffsL[4] = "Gold Rings"	
		 DDeCuffsL[4] = iDDe_GoldCuffsLegs_Inv
		sDDeCuffsL[5] = "Gold Shackles"
		 DDeCuffsL[5] = iDDe_GoldShacklesLegs_Inv	
		sDDeCuffsL[6] = "Inox Rings"	
		 DDeCuffsL[6] = iDDe_InoxCuffsLegs_Inv
		sDDeCuffsL[7] = "Inox Shackles"	
		 DDeCuffsL[7] = iDDe_InoxShacklesLegs_Inv
		sDDeCuffsL[8] = "Lite Wood Rings"
		 DDeCuffsL[8] = iDDe_LteWoodCuffsLegs_Inv	
		sDDeCuffsL[9] = "Rusty Rings"	
		 DDeCuffsL[9] = iDDe_RustyCuffsLegs_Inv
		sDDeCuffsL[10] = "Chromo-Hex Rings"	
		 DDeCuffsL[10] = iDDe_HexChCuffsLegs_Inv
		sDDeCuffsL[11] = "Red Hex Rings"
		 DDeCuffsL[11] = iDDe_HexRdCuffsLegs_Inv
		sDDeCuffsL[12] = "Hypnotic Rings"
		 DDeCuffsL[12] = iDDe_HypCuffsLegs_Inv
		sDDeCuffsL[13] = "Jade Rings"
		 DDeCuffsL[13] = iDDe_JadeCuffsLegs_Inv
		sDDeCuffsL[14] = "Jade Shackles"
		 DDeCuffsL[14] = iDDe_JadeShacklesLegs_Inv
		sDDeCuffsL[15] = "Fifa Rings"
		 DDeCuffsL[15] = iDDe_FifaCuffsLegs_Inv	
		sDDeCuffsL[16] = "Fifa Shackles"	
		 DDeCuffsL[16] = iDDe_FifaShacklesLegs_Inv
		sDDeCuffsL[17] = "Fire Rings"	
		 DDeCuffsL[17] = iDDe_FireCuffsLegs_Inv
		sDDeCuffsL[18] = "Fire Shackles"
		 DDeCuffsL[18] = iDDe_FireShacklesLegs_Inv	
		sDDeCuffsL[19] = "Rope Rings"
		 DDeCuffsL[19] = iDDe_RopeCuffsLegs_Inv	
		sDDeCuffsL[20] = "Brown Leather Rings"
		 DDeCuffsL[20] = iDDe_LeBrCuffsLegs_Inv
		sDDeCuffsL[21] = "Crimson Rings"
		 DDeCuffsL[21] = iDDe_CrimsonCuffsLegs_Inv
		sDDeCuffsL[22] = "Crimson Shackles"
		 DDeCuffsL[22] = iDDe_CrimsonShacklesLegs_Inv	
		sDDeCuffsL[23] = "Orange-Hex Rings"
		 DDeCuffsL[23] = iDDe_HexOrCuffsLegs_Inv	 
		sDDeCuffsL[24] = "Bumblebee Shackles"
		 DDeCuffsL[24] = iDDe_BumbeeShacklesLegs_Inv
		sDDeCuffsL[25] = "Bumblebee Rings"
		 DDeCuffsL[25] = iDDe_BumbeeCuffsLegs_Inv	
EndFunction
STRING[] Property sDDxCuffsL Auto Hidden	
FORM[] Property DDxCuffsL Auto Hidden
Function iDDeSetCuffsLDDx()
	sDDxCuffsL = NEW STRING[21]
	 DDxCuffsL = NEW FORM[21]	
		sDDxCuffsL[0] = "No DDx Leg Cuffs"	
		 DDxCuffsL[0] = None
		sDDxCuffsL[1] = "Metal Padded"
		 DDxCuffsL[1] = ZadLib.cuffsPaddedLegs
		sDDxCuffsL[2] = "Leather"
		 DDxCuffsL[2] = ZadLib.cuffsLeatherLegs
		sDDxCuffsL[3] = "Black Ebonite"
		 DDxCuffsL[3] = ZadxLib.cuffsEboniteLegs
		sDDxCuffsL[4] = "White Ebonite"
		 DDxCuffsL[4] = ZadxLib.cuffsWTEboniteLegs 
		sDDxCuffsL[5] = "White Leather"
		 DDxCuffsL[5] = ZadxLib.cuffsWTLeatherLegs
		sDDxCuffsL[6] = "Red Ebonite"
		 DDxCuffsL[6] = ZadxLib.cuffsRDEboniteLegs
		sDDxCuffsL[7] = "Red Leather"	
		 DDxCuffsL[7] = ZadxLib.cuffsRDLeatherLegs
		sDDxCuffsL[8] = "HR Chain Harness"
		 DDxCuffsL[8] = ZadxLib.zadx_HR_ChainHarnessLegsInventory
		sDDxCuffsL[9] = "HR Chain Harness Rusty"
		 DDxCuffsL[9] = ZadxLib.zadx_HR_RustyChainHarnessLegsInventory		
		sDDxCuffsL[10] = "Black Iron Shackles"	
		 DDxCuffsL[10] = ZadxLib.zadx_AnkleShackles_Black_Inventory
		sDDxCuffsL[11] = "Silver Shackles"
		 DDxCuffsL[11] = ZadxLib.zadx_AnkleShackles_Silver_Inventory
		sDDxCuffsL[12] = "Gold Padded"
		 DDxCuffsL[12] = ZadxLib.zadx_cuffs_Padded_Legs_Gold_Inventory
		sDDxCuffsL[13] = "Silver Padded"
		 DDxCuffsL[13] = ZadxLib.zadx_cuffs_Padded_Legs_Silver_Inventory
		sDDxCuffsL[14] = "Natural Rope"	
		 DDxCuffsL[14] = ZadxLib2.zadx_rope_cuffs_legs_Inventory
		sDDxCuffsL[15] = "Red Rope"
		 DDxCuffsL[15] = ZadxLib2.zadx_rope_red_cuffs_legs_Inventory
		sDDxCuffsL[16] = "Black Rope"
		 DDxCuffsL[16] = ZadxLib2.zadx_rope_black_cuffs_legs_Inventory
		sDDxCuffsL[17] = "White Rope"
		 DDxCuffsL[17] = ZadxLib2.zadx_rope_white_cuffs_legs_Inventory 
		sDDxCuffsL[18] = "Red Padded"
		 DDxCuffsL[18] = ZadxLib2.zadx_cuffs_Padded_Legs_Red_Inventory
		sDDxCuffsL[19] = "White Padded"
		 DDxCuffsL[19] = ZadxLib2.zadx_cuffs_Padded_Legs_White_Inventory
		sDDxCuffsL[20] = "Black Padded"
		 DDxCuffsL[20] = ZadxLib2.zadx_cuffs_Padded_Legs_Black_Inventory
		
EndFunction
STRING[] Property sCDxCuffsL Auto Hidden	
FORM[] Property CDxCuffsL Auto Hidden
Function iDDeSetCuffsLCDx()
	If (bGotCD)
		sCDxCuffsL = iDDeCDxUtil.iDDeSetCuffsLCDxStr()
		 CDxCuffsL = iDDeCDxUtil.iDDeSetCuffsLCDxForm()
	Else
		sCDxCuffsL = NEW STRING[1]
		 CDxCuffsL = NEW FORM[1]
			sCDxCuffsL[0] = "No CD"	
			 CDxCuffsL[0] = None 
	EndIf
EndFunction
;lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll

;Heavy Bondage Slot No. 46
;hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh 
STRING[] Property sDDeElbowBinders Auto Hidden	
FORM[] Property DDeElbowBinders Auto Hidden
Function iDDeSetElbowBinders()
	sDDeElbowBinders = NEW STRING[19]
	 DDeElbowBinders = NEW FORM[19]
		sDDeElbowBinders[0] = "No DDe ElbowBinder"
		 DDeElbowBinders[0] = None	
		sDDeElbowBinders[1] = "Falmer Elbowbinder"
		 DDeElbowBinders[1] = iDDe_FalmerElbowbinder_Inv
		sDDeElbowBinders[2] = "Wood Elbowbinder"
		 DDeElbowBinders[2] = iDDe_WoodElbowbinder_Inv
		sDDeElbowBinders[3] = "Gold Elbowbinder"
		 DDeElbowBinders[3] = iDDe_GoldElbowbinder_Inv
		sDDeElbowBinders[4] = "Inox Elbowbinder"
		 DDeElbowBinders[4] = iDDe_InoxElbowbinder_Inv
		sDDeElbowBinders[5] = "Rope Elbowbinder"
		 DDeElbowBinders[5] = iDDe_RopeElbowbinder_Inv
		sDDeElbowBinders[6] = "Lite Wood Elbowbinder"
		 DDeElbowBinders[6] = iDDe_LteWoodElbowbinder_Inv
		sDDeElbowBinders[7] = "Rusty Elbowbinder"
		 DDeElbowBinders[7] = iDDe_RustyElbowbinder_Inv
		sDDeElbowBinders[8] = "Chromo-Hex Elbowbinder"
		 DDeElbowBinders[8] = iDDe_HexChElbowbinder_Inv
		sDDeElbowBinders[9] = "Red Hex Elbowbinder"
		 DDeElbowBinders[9] = iDDe_HexRdElbowbinder_Inv
		sDDeElbowBinders[10] = "Black Hex Elbowbinder"
		 DDeElbowBinders[10] = iDDe_HexBkElbowbinder_Inv
		sDDeElbowBinders[11] = "Hypnotic Elbowbinder"
		 DDeElbowBinders[11] = iDDe_HypElbowbinder_Inv
		sDDeElbowBinders[12] = "Jade Elbowbinder"
		 DDeElbowBinders[12] = iDDe_JadeElbowbinder_Inv
		sDDeElbowBinders[13] = "Fifa Elbowbinder"
		 DDeElbowBinders[13] = iDDe_FifaElbowbinder_Inv
		sDDeElbowBinders[14] = "Fire Elbowbinder"
		 DDeElbowBinders[14] = iDDe_FireElbowbinder_Inv
		sDDeElbowBinders[15] = "Brown Leather Elbowbinder"
		 DDeElbowBinders[15] = iDDe_LeBrElbowbinder_Inv
		sDDeElbowBinders[16] = "Crimson Elbowbinder"
		 DDeElbowBinders[16] = iDDe_CrimsonElbowbinder_Inv
		sDDeElbowBinders[17] = "Orange-Hex Elbowbinder"
		 DDeElbowBinders[17] = iDDe_HexOrElbowbinder_Inv
		sDDeElbowBinders[18] = "Bumblebee Elbowbinder"
		 DDeElbowBinders[18] = iDDe_BumbeeElbowbinder_Inv 
EndFunction
STRING[] Property sDDxElbowBinders Auto Hidden	
FORM[] Property DDxElbowBinders Auto Hidden
Function iDDeSetElbowBindersDDx()
	sDDxElbowBinders = NEW STRING[8]
	 DDxElbowBinders = NEW FORM[8]
		sDDxElbowBinders[0] = "No DDx ElbowBinder"
		 DDxElbowBinders[0] = None	
		sDDxElbowBinders[1] = "Black Leather Elbowbinder"
		 DDxElbowBinders[1] = ZadxLib.zadx_ElbowbinderInventory
		sDDxElbowBinders[2] = "Red Leather Elbowbinder"
		 DDxElbowBinders[2] = ZadxLib.zadx_ElbowbinderRedInventory
		sDDxElbowBinders[3] = "White Leather Elbowbinder"
		 DDxElbowBinders[3] = ZadxLib.zadx_ElbowbinderWhiteInventory
		sDDxElbowBinders[4] = "Black Ebonite Elbowbinder"
		 DDxElbowBinders[4] = ZadxLib.zadx_ElbowbinderEboniteInventory
		sDDxElbowBinders[5] = "Red Ebonite Elbowbinder"
		 DDxElbowBinders[5] = ZadxLib.zadx_ElbowbinderEboniteRedInventory
		sDDxElbowBinders[6] = "White Ebonite Elbowbinder"
		 DDxElbowBinders[6] = ZadxLib.zadx_ElbowbinderEboniteWhiteInventory
		sDDxElbowBinders[7] = "Natural Rope Elbowbinder"
		 DDxElbowBinders[7] = ZadxLib.zadx_Armbinder_Rope_Strict_Inventory 
EndFunction	
STRING[] Property sDDeArmBinders Auto Hidden	
FORM[] Property DDeArmBinders Auto Hidden
Function iDDeSetArmBinders()
	sDDeArmBinders = NEW STRING[19]
	 DDeArmBinders = NEW FORM[19]
		sDDeArmBinders[0] = "No DDe ArmBinder"
		 DDeArmBinders[0] = None	
		sDDeArmBinders[1] = "Falmer Armbinder"
		 DDeArmBinders[1] = iDDe_FalmerArmbinder_Inv
		sDDeArmBinders[2] = "Wood Armbinder"
		 DDeArmBinders[2] = iDDe_WoodArmbinder_Inv
		sDDeArmBinders[3] = "Gold Armbinder"
		 DDeArmBinders[3] = iDDe_GoldArmbinder_Inv
		sDDeArmBinders[4] = "Inox Armbinder"
		 DDeArmBinders[4] = iDDe_InoxArmbinder_Inv
		sDDeArmBinders[5] = "Rope Armbinder"
		 DDeArmBinders[5] = iDDe_RopeArmbinder_Inv
		sDDeArmBinders[6] = "Lite Wood Armbinder"
		 DDeArmBinders[6] = iDDe_LteWoodArmbinder_Inv
		sDDeArmBinders[7] = "Rusty Armbinder"
		 DDeArmBinders[7] = iDDe_RustyArmbinder_Inv
		sDDeArmBinders[8] = "Chromo-Hex Armbinder"
		 DDeArmBinders[8] = iDDe_HexChArmbinder_Inv
		sDDeArmBinders[9] = "Red Hex Armbinder"
		 DDeArmBinders[9] = iDDe_HexRdArmbinder_Inv
		sDDeArmBinders[10] = "Black Hex Armbinder"
		 DDeArmBinders[10] = iDDe_HexBkArmbinder_Inv
		sDDeArmBinders[11] = "Hypnotic Armbinder"
		 DDeArmBinders[11] = iDDe_HypArmbinder_Inv
		sDDeArmBinders[12] = "Jade Armbinder"
		 DDeArmBinders[12] = iDDe_JadeArmbinder_Inv
		sDDeArmBinders[13] = "Fifa Armbinder"
		 DDeArmBinders[13] = iDDe_FifaArmbinder_Inv
		sDDeArmBinders[14] = "Fire Armbinder"
		 DDeArmBinders[14] = iDDe_FireArmbinder_Inv
		sDDeArmBinders[15] = "Brown Leather Armbinder"
		 DDeArmBinders[15] = iDDe_LeBrArmbinder_Inv
		sDDeArmBinders[16] = "Crimson Armbinder"
		 DDeArmBinders[16] = iDDe_CrimsonArmbinder_Inv
		sDDeArmBinders[17] = "Orange-Hex Armbinder"
		 DDeArmBinders[17] = iDDe_HexOrArmbinder_Inv
		sDDeArmBinders[18] = "Bumblebee Armbinder"
		 DDeArmBinders[18] = iDDe_BumbeeArmbinder_Inv 
EndFunction
STRING[] Property sDDxArmBinders Auto Hidden	
FORM[] Property DDxArmBinders Auto Hidden
Function iDDeSetArmBindersDDx()
	sDDxArmBinders = NEW STRING[8]
	 DDxArmBinders = NEW FORM[8]
		sDDxArmBinders[0] = "No DDx ArmBinder"
		 DDxArmBinders[0] = None	
		sDDxArmBinders[1] = "Black Leather Armbinder"
		 DDxArmBinders[1] = ZadLib.armbinder 
		sDDxArmBinders[2] = "Black Ebonite Armbinder"
		 DDxArmBinders[2] = ZadxLib.eboniteArmbinder
		sDDxArmBinders[3] = "White Ebonite Armbinder"
		 DDxArmBinders[3] = ZadxLib.wtEboniteArmbinder
		sDDxArmBinders[4] = "White Leather Armbinder"
		 DDxArmBinders[4] = ZadxLib.wtLeatherArmbinder
		sDDxArmBinders[5] = "Red Ebonite Armbinder"
		 DDxArmBinders[5] = ZadxLib.rdEboniteArmbinder	
		sDDxArmBinders[6] = "Red Leather Armbinder"
		 DDxArmBinders[6] = ZadxLib.rdLeatherArmbinder
		sDDxArmBinders[7] = "Natural Rope Armbinder"
		 DDxArmBinders[7] = ZadxLib.zadx_Armbinder_Rope_Inventory 
EndFunction	
STRING[] Property sDDeYokes Auto Hidden	
FORM[] Property DDeYokes Auto Hidden
Function iDDeSetYokes()
	sDDeYokes = NEW STRING[26]
	 DDeYokes = NEW FORM[26]
		sDDeYokes[0] = "No DDe Yoke"
		 DDeYokes[0] = None	
		sDDeYokes[1] = "Falmer Yoke"
		 DDeYokes[1] = iDDe_FalmerYoke_Inv
		sDDeYokes[2] = "Gold Yoke"
		 DDeYokes[2] = iDDe_GoldYoke_Inv
		sDDeYokes[3] = "Inox Yoke"
		 DDeYokes[3] = iDDe_InoxYoke_Inv
		sDDeYokes[4] = "Gold ZAP Yoke"
		 DDeYokes[4] = iDDe_GoldYokeZbf_Inv
		sDDeYokes[5] = "Inox ZAP Yoke"
		 DDeYokes[5] = iDDe_InoxYokeZbf_Inv
		sDDeYokes[6] = "Rusty Yoke"
		 DDeYokes[6] = iDDe_RustyYoke_Inv
		sDDeYokes[7] = "Rusty ZAP Yoke"
		 DDeYokes[7] = iDDe_RustyYokeZbf_Inv
		sDDeYokes[8] = "Chromo-Hex Yoke"
		 DDeYokes[8] = iDDe_HexChYoke_Inv
		sDDeYokes[9] = "Red Hex Yoke"
		 DDeYokes[9] = iDDe_HexRdYoke_Inv
		sDDeYokes[10] = "Red Hex ZAP Yoke"
		 DDeYokes[10] = iDDe_HexRdYokeZbf_Inv
		sDDeYokes[11] = "Hypnotic Yoke"
		 DDeYokes[11] = iDDe_HypYoke_Inv
		sDDeYokes[12] = "Hypnotic ZAP Yoke"
		 DDeYokes[12] = iDDe_HypYokeZbf_Inv
		sDDeYokes[13] = "Jade Yoke"
		 DDeYokes[13] = iDDe_JadeYoke_Inv
		sDDeYokes[14] = "Jade ZAP Yoke"
		 DDeYokes[14] = iDDe_JadeYokeZbf_Inv
		sDDeYokes[15] = "Fifa Yoke"
		 DDeYokes[15] = iDDe_FifaYoke_Inv
		sDDeYokes[16] = "Fifa ZAP Yoke"
		 DDeYokes[16] = iDDe_FifaYokeZbf_Inv
		sDDeYokes[17] = "Fire Yoke"
		 DDeYokes[17] = iDDe_FireYoke_Inv
		sDDeYokes[18] = "Fire ZAP Yoke"
		 DDeYokes[18] = iDDe_FireYokeZbf_Inv
		sDDeYokes[19] = "Crimson Yoke"
		 DDeYokes[19] = iDDe_CrimsonYoke_Inv
		sDDeYokes[20] = "Crimson ZAP Yoke"
		 DDeYokes[20] = iDDe_CrimsonYokeZbf_Inv
		sDDeYokes[21] = "Orange-Hex Yoke"
		 DDeYokes[21] = iDDe_HexOrYoke_Inv
		sDDeYokes[22] = "Orange-Hex ZAP Yoke"
		 DDeYokes[22] = iDDe_HexOrYokeZbf_Inv
		sDDeYokes[23] = "Bumblebee Yoke"
		 DDeYokes[23] = iDDe_BumbeeYoke_Inv
		sDDeYokes[24] = "Bumblebee ZAP Yoke"
		 DDeYokes[24] = iDDe_BumbeeYokeZbf_Inv
		sDDeYokes[25] = "Iron Yoke"
		 DDeYokes[25] = iDDe_IronYoke_Inv 
EndFunction
STRING[] Property sDDxYokes Auto Hidden	
FORM[] Property DDxYokes Auto Hidden
Function iDDeSetYokesDDx()
	sDDxYokes = NEW STRING[3]
	 DDxYokes = NEW FORM[3]
		sDDxYokes[0] = "No DDx Yoke"
		 DDxYokes[0] = None	
		sDDxYokes[1] = "Yoke"
		 DDxYokes[1] = ZadLib.yoke
		sDDxYokes[2] = "Steel Yoke"
		 DDxYokes[2] = ZadxLib.zadx_yoke_steel_Inventory	 
EndFunction	
STRING[] Property sDDeShackles Auto Hidden	
FORM[] Property DDeShackles Auto Hidden
Function iDDeSetShackles()
	sDDeShackles = NEW STRING[9]
	 DDeShackles = NEW FORM[9]
		sDDeShackles[0] = "No DDe Shackles"
		 DDeShackles[0] = None	
		sDDeShackles[1] = "Iron Arm Shackles"
		 DDeShackles[1] = iDDe_IronShacklesArms_Inv
		sDDeShackles[2] = "Gold Arm Shackles"
		 DDeShackles[2] = iDDe_GoldShacklesArms_Inv
		sDDeShackles[3] = "Inox Arm Shackles"
		 DDeShackles[3] = iDDe_InoxShacklesArms_Inv
		sDDeShackles[4] = "Jade Arm Shackles"
		 DDeShackles[4] = iDDe_JadeShacklesArms_Inv
		sDDeShackles[5] = "Fifa Shackles"
		 DDeShackles[5] = iDDe_FifaShacklesArms_Inv
		sDDeShackles[6] = "Fire Arm Shackles"
		 DDeShackles[6] = iDDe_FireShacklesArms_Inv
		sDDeShackles[7] = "Crimson Arm Shackles"
		 DDeShackles[7] = iDDe_CrimsonShacklesArms_Inv
		sDDeShackles[8] = "Bumblebee Arm Shackles"
		 DDeShackles[8] = iDDe_BumbeeShacklesArms_Inv 
EndFunction
STRING[] Property sDDxShackles Auto Hidden	
FORM[] Property DDxShackles Auto Hidden
Function iDDeSetShacklesDDx()
	sDDxShackles = NEW STRING[6]
	 DDxShackles = NEW FORM[6]
		sDDxShackles[0] = "No DDx Shackles"
		 DDxShackles[0] = None	
		sDDxShackles[1] = "HR Wrist Shackles"
		 DDxShackles[1] = ZadxLib.zadx_HR_WristShacklesInventory
		sDDxShackles[2] = "HR Rusty Wrist Shackles"
		 DDxShackles[2] = ZadxLib.zadx_HR_RustyWristShacklesInventory
		sDDxShackles[3] = "Steel Arm Shackles"
		 DDxShackles[3] = ZadxLib.zadx_shackles_steel_Inventory 
		sDDxShackles[4] = "Black Prisoner Chains"
		 DDxShackles[4] = ZadxLib.zadx_HR_PrisonerChains01Inventory
		sDDxShackles[5] = "Rusty Prisoner Chains"
		 DDxShackles[5] = ZadxLib.zadx_HR_RustyPrisonerChains01Inventory 
EndFunction	
STRING[] Property sDDePetSuits Auto Hidden	
FORM[] Property DDePetSuits Auto Hidden
Function iDDeSetPetSuits()
	sDDePetSuits = NEW STRING[1]
	 DDePetSuits = NEW FORM[1]
		sDDePetSuits[0] = "No DDe Pet Suit"
		 DDePetSuits[0] = None	 
EndFunction
STRING[] Property sDDxPetSuits Auto Hidden	
FORM[] Property DDxPetSuits Auto Hidden
Function iDDeSetPetSuitsDDx()
	sDDxPetSuits = NEW STRING[7]
	 DDxPetSuits = NEW FORM[7]
		sDDxPetSuits[0] = "No DDx Pet Suit"
		 DDxPetSuits[0] = None	
		sDDxPetSuits[1] = "Black Leather Pet Suit"
		 DDxPetSuits[1] = ZadxLib2.zadx_PetSuit_Black_Inventory
		sDDxPetSuits[2] = "Red Leather Pet Suit"
		 DDxPetSuits[2] = ZadxLib2.zadx_PetSuit_Red_Inventory
		sDDxPetSuits[3] = "White Leather Pet Suit"
		 DDxPetSuits[3] = ZadxLib2.zadx_PetSuit_White_Inventory
		sDDxPetSuits[4] = "Black Ebonite Pet Suit"
		 DDxPetSuits[4] = ZadxLib2.zadx_PetSuit_Ebonite_Black_Inventory
		sDDxPetSuits[5] = "Red Ebonite Pet Suit"
		 DDxPetSuits[5] = ZadxLib2.zadx_PetSuit_Ebonite_Red_Inventory
		sDDxPetSuits[6] = "White Ebonite Pet Suit"
		 DDxPetSuits[6] = ZadxLib2.zadx_PetSuit_Ebonite_White_Inventory 
EndFunction	
STRING[] Property sDDeBoxBinders Auto Hidden	
FORM[] Property DDeBoxBinders Auto Hidden
Function iDDeSetBoxBinders()
	sDDeBoxBinders = NEW STRING[19]
	 DDeBoxBinders = NEW FORM[19]
		sDDeBoxBinders[0] = "No DDe BoxBinder"
		 DDeBoxBinders[0] = None
		sDDeBoxBinders[1] = "Falmer Boxbinder"
		 DDeBoxBinders[1] = iDDe_FalmerBoxbinder_Inv
		sDDeBoxBinders[2] = "Wood Boxbinder"
		 DDeBoxBinders[2] = iDDe_WoodBoxbinder_Inv
		sDDeBoxBinders[3] = "Gold Boxbinder"
		 DDeBoxBinders[3] = iDDe_GoldBoxbinder_Inv
		sDDeBoxBinders[4] = "Inox Boxbinder"
		 DDeBoxBinders[4] = iDDe_InoxBoxbinder_Inv
		sDDeBoxBinders[5] = "Rope Boxbinder"
		 DDeBoxBinders[5] = iDDe_RopeBoxbinder_Inv
		sDDeBoxBinders[6] = "Lite Wood Boxbinder"
		 DDeBoxBinders[6] = iDDe_LteWoodBoxbinder_Inv
		sDDeBoxBinders[7] = "Rusty Boxbinder"
		 DDeBoxBinders[7] = iDDe_RustyBoxbinder_Inv
		sDDeBoxBinders[8] = "Chromo-Hex Boxbinder"
		 DDeBoxBinders[8] = iDDe_HexChBoxbinder_Inv
		sDDeBoxBinders[9] = "Red Hex Boxbinder"
		 DDeBoxBinders[9] = iDDe_HexRdBoxbinder_Inv
		sDDeBoxBinders[10] = "Black Hex Boxbinder"
		 DDeBoxBinders[10] = iDDe_HexBkBoxbinder_Inv
		sDDeBoxBinders[11] = "Hypnotic Boxbinder"
		 DDeBoxBinders[11] = iDDe_HypBoxbinder_Inv
		sDDeBoxBinders[12] = "Jade Boxbinder"
		 DDeBoxBinders[12] = iDDe_JadeBoxbinder_Inv
		sDDeBoxBinders[13] = "Fifa Boxbinder"
		 DDeBoxBinders[13] = iDDe_FifaBoxbinder_Inv
		sDDeBoxBinders[14] = "Fire Boxbinder"
		 DDeBoxBinders[14] = iDDe_FireBoxbinder_Inv
		sDDeBoxBinders[15] = "Brown Leather Boxbinder"
		 DDeBoxBinders[15] = iDDe_LeBrBoxbinder_Inv
		sDDeBoxBinders[16] = "Crimson Boxbinder"
		 DDeBoxBinders[16] = iDDe_CrimsonBoxbinder_Inv
		sDDeBoxBinders[17] = "Orange-Hex Boxbinder"
		 DDeBoxBinders[17] = iDDe_HexOrBoxbinder_Inv
		sDDeBoxBinders[18] = "Bumblebee Boxbinder"
		 DDeBoxBinders[18] = iDDe_BumbeeBoxbinder_Inv 	 
EndFunction
STRING[] Property sDDxBoxBinders Auto Hidden	
FORM[] Property DDxBoxBinders Auto Hidden
Function iDDeSetBoxBindersDDx()
	sDDxBoxBinders = NEW STRING[4]
	 DDxBoxBinders = NEW FORM[4]
		sDDxBoxBinders[0] = "No DDx Boxbinder"
		 DDxBoxBinders[0] = None	
		sDDxBoxBinders[1] = "Black Ebonitebox Binder"
		 DDxBoxBinders[1] = ZadxLib2.zadx_BoxBinder_Inventory
		sDDxBoxBinders[2] = "Red Ebonitebox Binder"
		 DDxBoxBinders[2] = zadx_BoxBinder_Red_Inventory
		sDDxBoxBinders[3] = "White Ebonitebox Binder"
		 DDxBoxBinders[3] = zadx_BoxBinder_White_Inventory 
EndFunction	
STRING[] Property sDDeBoxBinderOuts Auto Hidden	
FORM[] Property DDeBoxBinderOuts Auto Hidden
Function iDDeSetBoxBinderOuts()
	sDDeBoxBinderOuts = NEW STRING[19]
	 DDeBoxBinderOuts = NEW FORM[19]
		sDDeBoxBinderOuts[0] = "No DDe Boxbinder Outfit"
		 DDeBoxBinderOuts[0] = None
		sDDeBoxBinderOuts[1] = "Falmer Boxbinder Outfit"
		 DDeBoxBinderOuts[1] = iDDe_FalmerBoxbinderOut_Inv
		sDDeBoxBinderOuts[2] = "Wood Boxbinder Outfit"
		 DDeBoxBinderOuts[2] = iDDe_WoodBoxbinderOut_Inv
		sDDeBoxBinderOuts[3] = "Gold Boxbinder Outfit"
		 DDeBoxBinderOuts[3] = iDDe_GoldBoxbinderOut_Inv
		sDDeBoxBinderOuts[4] = "Inox Boxbinder Outfit"
		 DDeBoxBinderOuts[4] = iDDe_InoxBoxbinderOut_Inv
		sDDeBoxBinderOuts[5] = "Rope Boxbinder Outfit"
		 DDeBoxBinderOuts[5] = iDDe_RopeBoxbinderOut_Inv
		sDDeBoxBinderOuts[6] = "Lite Wood Boxbinder Outfit"
		 DDeBoxBinderOuts[6] = iDDe_LteWoodBoxbinderOut_Inv
		sDDeBoxBinderOuts[7] = "Rusty Boxbinder Outfit"
		 DDeBoxBinderOuts[7] = iDDe_RustyBoxbinderOut_Inv
		sDDeBoxBinderOuts[8] = "Chromo-Hex Boxbinder Outfit"
		 DDeBoxBinderOuts[8] = iDDe_HexChBoxbinderOut_Inv
		sDDeBoxBinderOuts[9] = "Red Hex Boxbinder Outfit"
		 DDeBoxBinderOuts[9] = iDDe_HexRdBoxbinderOut_Inv
		sDDeBoxBinderOuts[10] = "Black Hex Boxbinder Outfit"
		 DDeBoxBinderOuts[10] = iDDe_HexBkBoxbinderOut_Inv
		sDDeBoxBinderOuts[11] = "Hypnotic Boxbinder Outfit"
		 DDeBoxBinderOuts[11] = iDDe_HypBoxbinderOut_Inv
		sDDeBoxBinderOuts[12] = "Jade Boxbinder Outfit"
		 DDeBoxBinderOuts[12] = iDDe_JadeBoxbinderOut_Inv
		sDDeBoxBinderOuts[13] = "Fifa Boxbinder Outfit"
		 DDeBoxBinderOuts[13] = iDDe_FifaBoxbinderOut_Inv
		sDDeBoxBinderOuts[14] = "Fire Boxbinder Outfit"
		 DDeBoxBinderOuts[14] = iDDe_FireBoxbinderOut_Inv
		sDDeBoxBinderOuts[15] = "Brown Leather Boxbinder Outfit"
		 DDeBoxBinderOuts[15] = iDDe_LeBrBoxbinderOut_Inv
		sDDeBoxBinderOuts[16] = "Crimson Boxbinder Outfit"
		 DDeBoxBinderOuts[16] = iDDe_CrimsonBoxbinderOut_Inv
		sDDeBoxBinderOuts[17] = "Orange-Hex Boxbinder Outfit"
		 DDeBoxBinderOuts[17] = iDDe_HexOrBoxbinderOut_Inv
		sDDeBoxBinderOuts[18] = "Bumblebee Boxbinder Outfit"
		 DDeBoxBinderOuts[18] = iDDe_BumbeeBoxbinderOut_Inv 	 
EndFunction
STRING[] Property sDDxBoxBinderOuts Auto Hidden	
FORM[] Property DDxBoxBinderOuts Auto Hidden
Function iDDeSetBoxBindersOutDDx()
	sDDxBoxBinderOuts = NEW STRING[4]
	 DDxBoxBinderOuts = NEW FORM[4]
		sDDxBoxBinderOuts[0] = "No DDx Boxbinder Outfit"
		 DDxBoxBinderOuts[0] = None	
		sDDxBoxBinderOuts[1] = "Black Ebonite Boxbinder Outfit"
		 DDxBoxBinderOuts[1] = ZadxLib2.zadx_BoxBinderOutfit_Inventory
		sDDxBoxBinderOuts[2] = "Red Ebonite Boxbinder Outfit"
		 DDxBoxBinderOuts[2] = zadx_BoxBinderOutfit_Red_Inventory
		sDDxBoxBinderOuts[3] = "White Ebonite Boxbinder Outfit"
		 DDxBoxBinderOuts[3] = zadx_BoxBinderOutfit_White_Inventory 
EndFunction	
;hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh

;Belt SlotNo. 49
;eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
STRING[] Property sDDeBelts Auto Hidden	
FORM[] Property DDeBelts Auto Hidden
Function iDDeSetBelts()
	sDDeBelts = NEW STRING[33]
	 DDeBelts = NEW FORM[33]
		sDDeBelts[0] = "No DDe Belt"	
		 DDeBelts[0] = None
		sDDeBelts[1] = "Falmer Chain"
		 DDeBelts[1] = iDDe_FalmerBeltChain_Inv
		sDDeBelts[2] = "Falmer "
		 DDeBelts[2] = iDDe_FalmerBelt_Inv
		sDDeBelts[3] = "Wood "
		 DDeBelts[3] = iDDe_WoodBelt_Inv
		sDDeBelts[4] = "Iron "
		 DDeBelts[4] = iDDe_IronBelt_Inv
		sDDeBelts[5] = "Gold Chain"
		 DDeBelts[5] = iDDe_GoldBeltChain_Inv	
		sDDeBelts[6] = "Gold Padded"
		 DDeBelts[6] = iDDe_GoldBelt_Inv	
		sDDeBelts[7] = "Inox Chain"
		 DDeBelts[7] = iDDe_InoxBeltChain_Inv
		sDDeBelts[8] = "Inox Padded"
		 DDeBelts[8] = iDDe_InoxBelt_Inv	
		sDDeBelts[9] = "Lite Wood Padded"
		 DDeBelts[9] = iDDe_LteWoodBelt_Inv
		sDDeBelts[10] = "Rusty Chain"
		 DDeBelts[10] = iDDe_RustyBeltChain_Inv		
		sDDeBelts[11] = "Rusty "
		 DDeBelts[11] = iDDe_RustyBelt_Inv
		sDDeBelts[12] = "Chromo-Hex Chain"
		 DDeBelts[12] = iDDe_HexChBeltChain_Inv
		sDDeBelts[13] = "Chromo-Hex"
		 DDeBelts[13] = iDDe_HexChBelt_Inv
		sDDeBelts[14] = "Red Hex Chain"
		 DDeBelts[14] = iDDe_HexRdBeltChain_Inv
		sDDeBelts[15] = "Red Hex"
		 DDeBelts[15] = iDDe_HexRdBelt_Inv
		sDDeBelts[16] = "Hypnotic Chain"
		 DDeBelts[16] = iDDe_HypBeltChain_Inv 
		sDDeBelts[17] = "Hypnotic "
		 DDeBelts[17] = iDDe_HypBelt_Inv	
		sDDeBelts[18] = "Jade Padded"
		 DDeBelts[18] = iDDe_JadeBelt_Inv	
		sDDeBelts[19] = "Jade Chain"
		 DDeBelts[19] = iDDe_JadeBeltChain_Inv
		sDDeBelts[20] = "Fifa Chain" 
		 DDeBelts[20] = iDDe_FifaBeltChain_Inv	
		sDDeBelts[21] = "Fifa Padded"
		 DDeBelts[21] = iDDe_FifaBelt_Inv
		sDDeBelts[22] = "Fire Chain"
		 DDeBelts[22] = iDDe_FireBeltChain_Inv
		sDDeBelts[23] = "Fire Padded"
		 DDeBelts[23] = iDDe_FireBelt_Inv 
		sDDeBelts[24] = "Rope Padded"
		 DDeBelts[24] = iDDe_RopeBelt_Inv
		sDDeBelts[25] = "Crimson Chain"
		 DDeBelts[25] = iDDe_CrimsonBeltChain_Inv
		sDDeBelts[26] = "Crimson Padded"
		 DDeBelts[26] = iDDe_CrimsonBelt_Inv
		sDDeBelts[27] = "Iron Chain"
		 DDeBelts[27] = iDDe_IronBeltChain_Inv
		sDDeBelts[28] = "Orange-Hex Chain"
		 DDeBelts[28] = iDDe_HexOrBeltChain_Inv
		sDDeBelts[29] = "Orange-Hex Padded"
		 DDeBelts[29] = iDDe_HexOrBelt_Inv
		sDDeBelts[30] = "Bumblebee Chain"
		 DDeBelts[30] = iDDe_BumbeeBeltChain_Inv 
		sDDeBelts[31] = "Bumblebee Padded"
		 DDeBelts[31] = iDDe_BumbeeBelt_Inv 
		sDDeBelts[32] = "Brown Leather Padded"
		 DDeBelts[32] = iDDe_LeBrBelt_Inv 
EndFunction
STRING[] Property sDDxBelts Auto Hidden	
FORM[] Property DDxBelts Auto Hidden
Function iDDeSetBeltsDDx()
	sDDxBelts = NEW STRING[16]
	 DDxBelts = NEW FORM[16]
		sDDxBelts[0] = "No DDx Belt"	
		 DDxBelts[0] = None
		sDDxBelts[1] = "Metal Padded"
		 DDxBelts[1] = ZadLib.beltPadded
		sDDxBelts[2] = "Iron Chain"
		 DDxBelts[2] = ZadLib.beltIron
		sDDxBelts[3] = "Metal Open"
		 DDxBelts[3] = ZadLib.beltPaddedOpen
		sDDxBelts[4] = "Gold Padded"	
		 DDxBelts[4] = ZadxLib.zadx_chastitybelt_Padded_Gold_Inventory
		sDDxBelts[5] = "Silver Padded"
		 DDxBelts[5] = ZadxLib.zadx_chastitybelt_Padded_Silver_Inventory
		sDDxBelts[6] = "Natural Rope"
		 DDxBelts[6] = ZadxLib2.zadx_rope_crotch_Inventory
		sDDxBelts[7] = "Black Rope"
		 DDxBelts[7] = ZadxLib2.zadx_rope_black_crotch_Inventory
		sDDxBelts[8] = "Red Rope"	
		 DDxBelts[8] = ZadxLib2.zadx_rope_red_crotch_Inventory
		sDDxBelts[9] = "White Rope"
		 DDxBelts[9] = ZadxLib2.zadx_rope_white_crotch_Inventory 
		sDDxBelts[10] = "Red Padded"	
		 DDxBelts[10] = ZadxLib2.zadx_chastitybelt_Padded_Red_Inventory
		sDDxBelts[11] = "White Padded"
		 DDxBelts[11] = ZadxLib2.zadx_chastitybelt_Padded_White_Inventory
		sDDxBelts[12] = "Black Padded"
		 DDxBelts[12] = ZadxLib2.zadx_chastitybelt_Padded_Black_Inventory
		sDDxBelts[13] = "Red Padded Open"	
		 DDxBelts[13] = ZadxLib2.zadx_chastitybelt_PaddedOpen_Red_Inventory
		sDDxBelts[14] = "White Padded Open"
		 DDxBelts[14] = ZadxLib2.zadx_chastitybelt_PaddedOpen_White_Inventory
		sDDxBelts[15] = "Black Padded Open"
		 DDxBelts[15] = ZadxLib2.zadx_chastitybelt_PaddedOpen_Black_Inventory
EndFunction
STRING[] Property sCDxBelts Auto Hidden	
FORM[] Property CDxBelts Auto Hidden
Function iDDeSetBeltsCDx() 
	If (bGotCD)
		sCDxBelts = iDDeCDxUtil.iDDeSetBeltsCDxStr()
		 CDxBelts = iDDeCDxUtil.iDDeSetBeltsCDxForm()
	Else
		sCDxBelts = NEW STRING[1]
		 CDxBelts = NEW FORM[1]
			sCDxBelts[0] = "No CD Belt"	
			 CDxBelts[0] = None
	EndIf
EndFunction
;eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee

;Harness, Corset Slot No. 58
;hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
STRING[] Property sDDeHarness Auto Hidden	
FORM[] Property DDeHarness Auto Hidden
Function iDDeSetHarness()  
	sDDeHarness = NEW STRING[26]
	 DDeHarness = NEW FORM[26]	
		sDDeHarness[0] = "No DDe Harness"
		 DDeHarness[0] = None
		sDDeHarness[1] = "Falmer Full"
		 DDeHarness[1] = iDDe_FalmerHarnessFull_Inv
		sDDeHarness[2] = "Falmer Blocking"
		 DDeHarness[2] = iDDe_FalmerHarnessBlocking_Inv
		sDDeHarness[3] = "Falmer Locking"
		 DDeHarness[3] = iDDe_FalmerHarnessBody_Inv
		sDDeHarness[4] = "Gold Locking"
		 DDeHarness[4] = iDDe_GoldHarnessBody_Inv
		sDDeHarness[5] = "Inox Locking"
		 DDeHarness[5] = iDDe_InoxHarnessBody_Inv
		sDDeHarness[6] = "Wood Locking"
		 DDeHarness[6] = iDDe_WoodHarnessBody_Inv
		sDDeHarness[7] = "Lite Wood Locking"
		 DDeHarness[7] = iDDe_LteWoodHarnessBody_Inv
		sDDeHarness[8] = "Rusty Locking"
		 DDeHarness[8] = iDDe_RustyHarnessBody_Inv
		sDDeHarness[9] = "Chromo-Hex Locking"
		 DDeHarness[9] = iDDe_HexChHarnessBody_Inv
		sDDeHarness[10] = "Red Hex Locking"
		 DDeHarness[10] = iDDe_HexRdHarnessBody_Inv
		sDDeHarness[11] = "Hypnotic Locking"
		 DDeHarness[11] = iDDe_HypHarnessBody_Inv
		sDDeHarness[12] = "Jade Locking"
		 DDeHarness[12] = iDDe_JadeHarnessBody_Inv
		sDDeHarness[13] = "Fifa Locking"
		 DDeHarness[13] = iDDe_FifaHarnessBody_Inv
		sDDeHarness[14] = "Fire Locking"
		 DDeHarness[14] = iDDe_FireHarnessBody_Inv
		sDDeHarness[15] = "Rope Locking"
		 DDeHarness[15] = iDDe_RopeHarnessBody_Inv
		sDDeHarness[16] = "Brown Leather Locking"
		 DDeHarness[16] = iDDe_LeBrHarnessBody_Inv
		sDDeHarness[17] = "Crimson Locking"
		 DDeHarness[17] = iDDe_CrimsonHarnessBody_Inv
		sDDeHarness[18] = "Orange-Hex Locking"
		 DDeHarness[18] = iDDe_HexOrHarnessBody_Inv
		sDDeHarness[19] = "Bumblebee Locking"
		 DDeHarness[19] = iDDe_BumbeeHarnessBody_Inv	
		sDDeHarness[20] = "Black Ebonite Locking"
		 DDeHarness[20] = iDDe_EbBkHarnessBody_Inv
		sDDeHarness[21] = "Red Ebonite Locking"
		 DDeHarness[21] = iDDe_EbRdHarnessBody_Inv
		sDDeHarness[22] = "White Ebonite Locking"
		 DDeHarness[22] = iDDe_EbWhHarnessBody_Inv
		sDDeHarness[23] = "Black Leather Locking"
		 DDeHarness[23] = iDDe_LeBkHarnessBody_Inv
		sDDeHarness[24] = "Red Leather Locking"
		 DDeHarness[24] = iDDe_LeRdHarnessBody_Inv
		sDDeHarness[25] = "White Leather Locking"
		 DDeHarness[25] = iDDe_LeWhHarnessBody_Inv 
EndFunction
STRING[] Property sDDxHarness Auto Hidden	
FORM[] Property DDxHarness Auto Hidden
Function iDDeSetHarnessDDx()  
	sDDxHarness = NEW STRING[50]
	 DDxHarness = NEW FORM[50]	
		sDDxHarness[0] = "No DDx Harness"
		 DDxHarness[0] = None
		sDDxHarness[1] = "Black Leather Body"
		 DDxHarness[1] = ZadLib.harnessBody
		sDDxHarness[2] = "Black Leather Unlocked"
		 DDxHarness[2] = ZadxLib.harnessUnlocked
		sDDxHarness[3] = "Black Ebonite Body"
		 DDxHarness[3] = ZadxLib.eboniteHarnessBody  ; "normal" version, works as a chastity belt
		sDDxHarness[4] = "Black Ebonite Unlocked"
		 DDxHarness[4] = ZadxLib.EbharnessUnlocked
		sDDxHarness[5] = "White Ebonite Body"
		 DDxHarness[5] = ZadxLib.wtEboniteHarnessBody
		sDDxHarness[6] = "White Ebonite Unlocked"
		 DDxHarness[6] = ZadxLib.WTEharnessUnlocked
		sDDxHarness[7] = "White Leather Body"
		 DDxHarness[7] = ZadxLib.wtLeatherHarnessBody 
		sDDxHarness[8] = "White Leather Unlocked"
		 DDxHarness[8] = ZadxLib.WTLharnessUnlocked
		sDDxHarness[9] = "Red Ebonite Body"
		 DDxHarness[9] = ZadxLib.rdEboniteHarnessBody
		sDDxHarness[10] = "Red Ebonite Unlocked"
		 DDxHarness[10] = ZadxLib.RDEharnessUnlocked
		sDDxHarness[11] = "Red Leather Body"
		 DDxHarness[11] = ZadxLib.rdLeatherHarnessBody
		sDDxHarness[12] = "Red Leather Unlocked"
		 DDxHarness[12] = ZadxLib.RDLharnessUnlocked
		sDDxHarness[13] = "HR Chain Body"
		 DDxHarness[13] = ZadxLib.zadx_HR_ChainHarnessBodyInventory
		sDDxHarness[14] = "HR Chain Full"
		 DDxHarness[14] = ZadxLib.zadx_HR_ChainHarnessFullInventory
		sDDxHarness[15] = "HR Chain Body Rusty"
		 DDxHarness[15] = ZadxLib.zadx_HR_RustyChainHarnessBodyInventory
		sDDxHarness[16] = "HR Chain Full Rusty"
		 DDxHarness[16] = ZadxLib.zadx_HR_RustyChainHarnessFullInventory
		sDDxHarness[17] = "Natural Rope Full"
		 DDxHarness[17] = ZadxLib.zadx_Harness_Rope_Full_Inventory 
		sDDxHarness[18] = "Natural Rope Full Top Ch"
		 DDxHarness[18] = ZadxLib2.zadx_rope_harness_chaotic_fulltop_Inventory
		sDDxHarness[19] = "Natural Rope Hishi Ch"
		 DDxHarness[19] = ZadxLib2.zadx_rope_harness_chaotic_Hishi_Inventory
		sDDxHarness[20] = "Natural Rope Top Ch"
		 DDxHarness[20] = ZadxLib2.zadx_rope_harness_chaotic_Top_Inventory
		sDDxHarness[21] = "Natural Rope Ex"
		 DDxHarness[21] = ZadxLib2.zadx_rope_harness_Extreme_Inventory
		sDDxHarness[22] = "Natural Rope Full Top"
		 DDxHarness[22] = ZadxLib2.zadx_rope_harness_FullTop_Inventory
		sDDxHarness[23] = "Natural Rope Penta"
		 DDxHarness[23] = ZadxLib2.zadx_rope_harness_Penta_Crotch_Inventory
		sDDxHarness[24] = "Natural Rope Top Belt"
		 DDxHarness[24] = ZadxLib2.zadx_rope_harness_Top_Crotch_Inventory
		sDDxHarness[25] = "Natural Rope Top"
		 DDxHarness[25] = ZadxLib2.zadx_rope_harness_Top_Inventory
		sDDxHarness[26] = "Black Rope Full Top Ch"
		 DDxHarness[26] = ZadxLib2.zadx_rope_black_harness_chaotic_fulltop_Inventory
		sDDxHarness[27] = "Black Rope Hishi Ch"
		 DDxHarness[27] = ZadxLib2.zadx_rope_black_harness_chaotic_Hishi_Inventory
		sDDxHarness[28] = "Black Rope Top Ch"
		 DDxHarness[28] = ZadxLib2.zadx_rope_black_harness_chaotic_Top_Inventory
		sDDxHarness[29] = "Black Rope Ex"
		 DDxHarness[29] = ZadxLib2.zadx_rope_black_harness_Extreme_Inventory
		sDDxHarness[30] = "Black Rope Full Top"
		 DDxHarness[30] = ZadxLib2.zadx_rope_black_harness_FullTop_Inventory
		sDDxHarness[31] = "Black Rope Penta"
		 DDxHarness[31] = ZadxLib2.zadx_rope_black_harness_Penta_Crotch_Inventory
		sDDxHarness[32] = "Black Rope Top Belt"
		 DDxHarness[32] = ZadxLib2.zadx_rope_black_harness_Top_Crotch_Inventory
		sDDxHarness[33] = "Black Rope Top"
		 DDxHarness[33] = ZadxLib2.zadx_rope_black_harness_Top_Inventory
		sDDxHarness[34] = "Red Rope Full Top Ch"
		 DDxHarness[34] = ZadxLib2.zadx_rope_red_harness_chaotic_fulltop_Inventory
		sDDxHarness[35] = "Red Rope Hishi Ch"
		 DDxHarness[35] = ZadxLib2.zadx_rope_red_harness_chaotic_Hishi_Inventory
		sDDxHarness[36] = "Red Rope Top Ch"
		 DDxHarness[36] = ZadxLib2.zadx_rope_red_harness_chaotic_Top_Inventory
		sDDxHarness[37] = "Red Rope Ex"
		 DDxHarness[37] = ZadxLib2.zadx_rope_red_harness_Extreme_Inventory
		sDDxHarness[38] = "Red Rope Full Top"
		 DDxHarness[38] = ZadxLib2.zadx_rope_red_harness_FullTop_Inventory
		sDDxHarness[39] = "Red Rope Penta"
		 DDxHarness[39] = ZadxLib2.zadx_rope_red_harness_Penta_Crotch_Inventory
		sDDxHarness[40] = "Red Rope Top Belt"
		 DDxHarness[40] = ZadxLib2.zadx_rope_red_harness_Top_Crotch_Inventory
		sDDxHarness[41] = "Red Rope Top"
		 DDxHarness[41] = ZadxLib2.zadx_rope_red_harness_Top_Inventory
		sDDxHarness[42] = "White Rope Full Top Ch"
		 DDxHarness[42] = ZadxLib2.zadx_rope_white_harness_chaotic_fulltop_Inventory
		sDDxHarness[43] = "White Rope Hishi Ch"
		 DDxHarness[43] = ZadxLib2.zadx_rope_white_harness_chaotic_Hishi_Inventory
		sDDxHarness[44] = "White Rope Top Ch"
		 DDxHarness[44] = ZadxLib2.zadx_rope_white_harness_chaotic_Top_Inventory
		sDDxHarness[45] = "White Rope Ex"
		 DDxHarness[45] = ZadxLib2.zadx_rope_white_harness_Extreme_Inventory
		sDDxHarness[46] = "White Rope Full Top"
		 DDxHarness[46] = ZadxLib2.zadx_rope_white_harness_FullTop_Inventory
		sDDxHarness[47] = "White Rope Penta"
		 DDxHarness[47] = ZadxLib2.zadx_rope_white_harness_Penta_Crotch_Inventory
		sDDxHarness[48] = "White Rope Top Belt"
		 DDxHarness[48] = ZadxLib2.zadx_rope_white_harness_Top_Crotch_Inventory
		sDDxHarness[49] = "White Rope Top"
		 DDxHarness[49] = ZadxLib2.zadx_rope_white_harness_Top_Inventory 
EndFunction
;Corset
STRING[] Property sDDeCorsets Auto Hidden	
FORM[] Property DDeCorsets Auto Hidden
Function iDDeSetCorsetsDDe()
	sDDeCorsets = NEW STRING[1]
	 DDeCorsets = NEW FORM[1]	
	 	sDDeCorsets[0] = "No DDe Corset"
		 DDeCorsets[0] = None
EndFunction
STRING[] Property sDDxCorsets Auto Hidden	
FORM[] Property DDxCorsets Auto Hidden
Function iDDeSetCorsetsDDx()
	sDDxCorsets = NEW STRING[52]
	 DDxCorsets = NEW FORM[52]	
		sDDxCorsets[0] = "No DDx Corset"
		 DDxCorsets[0] = None
		sDDxCorsets[1] = "Black Leather Restrictive"
		 DDxCorsets[1] = ZadLib.corset
		sDDxCorsets[2] = "Black Ebonite Restrictive"
		 DDxCorsets[2] = ZadxLib.EbRestrictiveCorset
		sDDxCorsets[3] = "White Ebonite Restrictive"
		 DDxCorsets[3] = ZadxLib.WTErestrictiveCorset
		sDDxCorsets[4] = "White Leather Restrictive"
		 DDxCorsets[4] = ZadxLib.WTLrestrictiveCorset
		sDDxCorsets[5] = "Red Ebonite Restrictive"
		 DDxCorsets[5] = ZadxLib.RDErestrictiveCorset
		sDDxCorsets[6] = "Red Leather Restrictive"
		 DDxCorsets[6] = ZadxLib.RDLrestrictiveCorset
		sDDxCorsets[7] = "Trans Restrictive"
		 DDxCorsets[7] = ZadxLib.zadx_restrictiveCorsetTrans_Inventory	
		sDDxCorsets[8] = "Natural Rope Ch"
		 DDxCorsets[8] = ZadxLib2.zadx_rope_harness_corset_chaotic_Inventory
		sDDxCorsets[9] = "Natural Rope Penta Ch"
		 DDxCorsets[9] = ZadxLib2.zadx_rope_harness_corset_chaotic_Penta_Inventory
		sDDxCorsets[10] = "Natural Rope Top Ch"
		 DDxCorsets[10] = ZadxLib2.zadx_rope_harness_corset_chaotic_Top_Inventory
		sDDxCorsets[11] = "Natural Rope"
		 DDxCorsets[11] = ZadxLib2.zadx_rope_harness_corset_Inventory
		sDDxCorsets[12] = "Natural Rope Top"
		 DDxCorsets[12] = ZadxLib2.zadx_rope_harness_corset_Top_Inventory
		sDDxCorsets[13] = "Natural Rope Ex Ch"
		 DDxCorsets[13] = ZadxLib2.zadx_rope_harness_corsetExp_chaotic_Inventory
		sDDxCorsets[14] = "Natural Rope Penta Ex Ch"
		 DDxCorsets[14] = ZadxLib2.zadx_rope_harness_corsetExp_Chaotic_Penta_Inventory
		sDDxCorsets[15] = "Natural Rope Top Ex Ch"
		 DDxCorsets[15] = ZadxLib2.zadx_rope_harness_corsetExp_chaotic_Top_Inventory
		sDDxCorsets[16] = "Natural Rope Ex"
		 DDxCorsets[16] = ZadxLib2.zadx_rope_harness_corsetExp_Inventory
		sDDxCorsets[17] = "Natural Rope Penta Ex"
		 DDxCorsets[17] = ZadxLib2.zadx_rope_harness_corsetExp_Penta_Inventory
		sDDxCorsets[18] = "Natural Rope Top Ex"
		 DDxCorsets[18] = ZadxLib2.zadx_rope_harness_corsetExp_Top_Inventory
		sDDxCorsets[19] = "Black Rope Ch"
		 DDxCorsets[19] = ZadxLib2.zadx_rope_black_harness_corset_chaotic_Inventory
		sDDxCorsets[20] = "Black Rope Penta Ch"
		 DDxCorsets[20] = ZadxLib2.zadx_rope_black_harness_corset_chaotic_Penta_Inventory
		sDDxCorsets[21] = "Black Rope Top Ch"
		 DDxCorsets[21] = ZadxLib2.zadx_rope_black_harness_corset_chaotic_Top_Inventory
		sDDxCorsets[22] = "Black Rope"
		 DDxCorsets[22] = ZadxLib2.zadx_rope_black_harness_corset_Inventory
		sDDxCorsets[23] = "Black Rope Top"
		 DDxCorsets[23] = ZadxLib2.zadx_rope_black_harness_corset_Top_Inventory
		sDDxCorsets[24] = "Black Rope Ex Ch"
		 DDxCorsets[24] = ZadxLib2.zadx_rope_black_harness_corsetExp_chaotic_Inventory
		sDDxCorsets[25] = "Black Rope Penta Ex Ch"
		 DDxCorsets[25] = ZadxLib2.zadx_rope_black_harness_corsetExp_Chaotic_Penta_Inventory
		sDDxCorsets[26] = "Black Rope Top Ex"
		 DDxCorsets[26] = ZadxLib2.zadx_rope_black_harness_corsetExp_chaotic_Top_Inventory
		sDDxCorsets[27] = "Black Rope Ex"
		 DDxCorsets[27] = ZadxLib2.zadx_rope_black_harness_corsetExp_Inventory
		sDDxCorsets[28] = "Black Rope Penta Ex"
		 DDxCorsets[28] = ZadxLib2.zadx_rope_black_harness_corsetExp_Penta_Inventory
		sDDxCorsets[29] = "Black Rope Top Ex"
		 DDxCorsets[29] = ZadxLib2.zadx_rope_black_harness_corsetExp_Top_Inventory
		sDDxCorsets[30] = "Red Rope Ch"
		 DDxCorsets[30] = ZadxLib2.zadx_rope_red_harness_corset_chaotic_Inventory
		sDDxCorsets[31] = "Red Rope Penta Ch"
		 DDxCorsets[31] = ZadxLib2.zadx_rope_red_harness_corset_chaotic_Penta_Inventory
		sDDxCorsets[32] = "Red Rope Top Ch"
		 DDxCorsets[32] = ZadxLib2.zadx_rope_red_harness_corset_chaotic_Top_Inventory
		sDDxCorsets[33] = "Red Rope"
		 DDxCorsets[33] = ZadxLib2.zadx_rope_red_harness_corset_Inventory
		sDDxCorsets[34] = "Red Rope Top"
		 DDxCorsets[34] = ZadxLib2.zadx_rope_red_harness_corset_Top_Inventory
		sDDxCorsets[35] = "Red Rope Ex Ch"
		 DDxCorsets[35] = ZadxLib2.zadx_rope_red_harness_corsetExp_chaotic_Inventory
		sDDxCorsets[36] = "Red Rope Penta Ex Ch"
		 DDxCorsets[36] = ZadxLib2.zadx_rope_red_harness_corsetExp_Chaotic_Penta_Inventory
		sDDxCorsets[37] = "Red Rope Top Ex Ch"
		 DDxCorsets[37] = ZadxLib2.zadx_rope_red_harness_corsetExp_chaotic_Top_Inventory
		sDDxCorsets[38] = "Red Rope"
		 DDxCorsets[38] = ZadxLib2.zadx_rope_red_harness_corsetExp_Inventory
		sDDxCorsets[39] = "Red Rope Penta Ex"
		 DDxCorsets[39] = ZadxLib2.zadx_rope_red_harness_corsetExp_Penta_Inventory
		sDDxCorsets[40] = "Red Rope Top Ex"
		 DDxCorsets[40] = ZadxLib2.zadx_rope_red_harness_corsetExp_Top_Inventory
		sDDxCorsets[41] = "White Rope Ch"
		 DDxCorsets[41] = ZadxLib2.zadx_rope_white_harness_corset_chaotic_Inventory
		sDDxCorsets[42] = "White Rope Penta Ch"
		 DDxCorsets[42] = ZadxLib2.zadx_rope_white_harness_corset_chaotic_Penta_Inventory
		sDDxCorsets[43] = "White Rope Top Ch"
		 DDxCorsets[43] = ZadxLib2.zadx_rope_white_harness_corset_chaotic_Top_Inventory
		sDDxCorsets[44] = "White Rope"
		 DDxCorsets[44] = ZadxLib2.zadx_rope_white_harness_corset_Inventory
		sDDxCorsets[45] = "White Rope Top"
		 DDxCorsets[45] = ZadxLib2.zadx_rope_white_harness_corset_Top_Inventory
		sDDxCorsets[46] = "White Rope Ex Ch"
		 DDxCorsets[46] = ZadxLib2.zadx_rope_white_harness_corsetExp_chaotic_Inventory
		sDDxCorsets[47] = "White Rope Penta Ex Ch"
		 DDxCorsets[47] = ZadxLib2.zadx_rope_white_harness_corsetExp_Chaotic_Penta_Inventory
		sDDxCorsets[48] = "White Rope Top Ex Ch"
		 DDxCorsets[48] = ZadxLib2.zadx_rope_white_harness_corsetExp_chaotic_Top_Inventory
		sDDxCorsets[49] = "White Rope"
		 DDxCorsets[49] = ZadxLib2.zadx_rope_white_harness_corsetExp_Inventory
		sDDxCorsets[50] = "White Rope Penta Ex"
		 DDxCorsets[50] = ZadxLib2.zadx_rope_white_harness_corsetExp_Penta_Inventory
		sDDxCorsets[51] = "White Rope Top Ex"
		 DDxCorsets[51] = ZadxLib2.zadx_rope_white_harness_corsetExp_Top_Inventory 
EndFunction
;hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
 
;Plug A Slot No. 48
;papapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapap
STRING[] Property sDDePlugsA Auto Hidden	
FORM[] Property DDePlugsA Auto Hidden
Function iDDeSetPlugsA()
	sDDePlugsA = NEW STRING[9]
	 DDePlugsA = NEW FORM[9]
		sDDePlugsA[0] = "No DDe Anal Plug"
		 DDePlugsA[0] = None		
		sDDePlugsA[1] = "Falmer Soul Gem"
		 DDePlugsA[1] = iDDe_FalmerPlugSoulGemAn_Inv
		sDDePlugsA[2] = "Gold Soul Gem"
		 DDePlugsA[2] = iDDe_GoldPlugSoulGemAn_Inv
		sDDePlugsA[3] = "Inox Soul Gem"	
		 DDePlugsA[3] = iDDe_InoxPlugSoulGemAn_Inv
		sDDePlugsA[4] = "Jade Soul Gem"	
		 DDePlugsA[4] = iDDe_JadePlugSoulGemAn_Inv
		sDDePlugsA[5] = "Fifa Soul Gem"	
		 DDePlugsA[5] = iDDe_FifaPlugSoulGemAn_Inv
		sDDePlugsA[6] = "Fire Soul Gem"	
		 DDePlugsA[6] = iDDe_FirePlugSoulGemAn_Inv
		sDDePlugsA[7] = "Crimson Soul Gem"	
		 DDePlugsA[7] = iDDe_CrimsonPlugSoulGemAn_Inv	
		sDDePlugsA[8] = "Bumblebee Soul Gem"	
		 DDePlugsA[8] = iDDe_BumbeePlugSoulGemAn_Inv 
EndFunction
STRING[] Property sDDxPlugsA Auto Hidden	
FORM[] Property DDxPlugsA Auto Hidden
Function iDDeSetPlugsADDx()
	sDDxPlugsA = NEW STRING[22]
	 DDxPlugsA = NEW FORM[22]
		sDDxPlugsA[0] = "No DDx Anal Plug"
		 DDxPlugsA[0] = None		
		sDDxPlugsA[1] = "Vintage Iron"
		 DDxPlugsA[1] = ZadLib.plugIronAn
		sDDxPlugsA[2] = "Primitive "
		 DDxPlugsA[2] = ZadLib.plugPrimitiveAn
		sDDxPlugsA[3] = "Soul Gem"
		 DDxPlugsA[3] = ZadLib.plugSoulgemAn
		sDDxPlugsA[4] = "Inflatable "
		 DDxPlugsA[4] = ZadLib.plugInflatableAn
		sDDxPlugsA[5] = "Greater Soul Gem"
		 DDxPlugsA[5] = ZadxLib.PlugsGreaterSoulAnl
		sDDxPlugsA[6] = "Grand Soul Gem"
		 DDxPlugsA[6] = ZadxLib.PlugsGrandSoulAnl
		sDDxPlugsA[7] = "Black Soul Gem"
		 DDxPlugsA[7] = ZadxLib.PlugsBlackSoulAnl
		sDDxPlugsA[8] = "Filled Soul Gem"
		 DDxPlugsA[8] = ZadxLib.PlugsFilledSoulAnl	
		sDDxPlugsA[9] = "Shocking Soul Gem"
		 DDxPlugsA[9] = ZadxLib.PlugsShockSoulAnl
		sDDxPlugsA[10] = "HR Iron Pear"
		 DDxPlugsA[10] = ZadxLib.zadx_HR_IronPearAnalBlackInventory
		sDDxPlugsA[11] = "HR Iron Pear Bell"
		 DDxPlugsA[11] = ZadxLib.zadx_HR_IronPearAnalBellBlackInventory
		sDDxPlugsA[12] = "HR Iron Pear Chain"
		 DDxPlugsA[12] = ZadxLib.zadx_HR_IronPearAnalChainBlackInventory
		sDDxPlugsA[13] = "HR Iron Pear Sign"
		 DDxPlugsA[13] = ZadxLib.zadx_HR_IronPearAnalSignBlackInventory
		sDDxPlugsA[14] = "HR Iron Pear Rusty"
		 DDxPlugsA[14] = ZadxLib.zadx_HR_RustyIronPearAnalInventory
		sDDxPlugsA[15] = "HR Iron Pear Bell Rusty"
		 DDxPlugsA[15] = ZadxLib.zadx_HR_RustyIronPearAnalBellInventory
		sDDxPlugsA[16] = "HR Iron Pear Chain Rusty"
		 DDxPlugsA[16] = ZadxLib.zadx_HR_RustyIronPearAnalChainInventory	
		sDDxPlugsA[17] = "HR Rusty Iron Pear Sign"
		 DDxPlugsA[17] = ZadxLib.zadx_HR_RustyIronPearAnalSignInventory
		sDDxPlugsA[18] = "Pony Tail"
		 DDxPlugsA[18] = ZadxLib.zadx_HR_PlugPonyTail01Inventory
		sDDxPlugsA[19] = "Pony Tail Braided Bow"
		 DDxPlugsA[19] = ZadxLib.zadx_HR_PlugPonyTail02BowInventory
		sDDxPlugsA[20] = "Pony Tail Braided"
		 DDxPlugsA[20] = ZadxLib.zadx_HR_PlugPonyTail02Inventory
		sDDxPlugsA[21] = "Pony Tail Puffy"
		 DDxPlugsA[21] = ZadxLib.zadx_HR_PlugPonyTail03Inventory 
EndFunction
STRING[] Property sCDxPlugsA Auto Hidden	
FORM[] Property CDxPlugsA Auto Hidden
Function iDDeSetPlugsACDx()
	If (bGotCD)
		sCDxPlugsA = iDDeCDxUtil.iDDeSetPlugsACDxStr()
		 CDxPlugsA = iDDeCDxUtil.iDDeSetPlugsACDxForm()
	Else
		sCDxPlugsA = NEW STRING[1]
		 CDxPlugsA = NEW FORM[1]
		 	sCDxPlugsA[0] = "No CD Anal Plug"
			 CDxPlugsA[0] = None	
	EndIf	
EndFunction
;papapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapapap

;Plug V Slot No. 57
;pvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvp
STRING[] Property sDDePlugsV Auto Hidden	
FORM[] Property DDePlugsV Auto Hidden
Function iDDeSetPlugsV()
	sDDePlugsV = NEW STRING[10]
	 DDePlugsV = NEW FORM[10]
		sDDePlugsV[0] = "No DDe Vj Plug"
		 DDePlugsV[0] = None			 
		sDDePlugsV[1] = "Falmer Soul Gem"
		 DDePlugsV[1] = iDDe_FalmerPlugSoulGemVg_Inv
		sDDePlugsV[2] = "Falmer Chaos"
		 DDePlugsV[2] = iDDe_FalmerPlugChaosVg_Inv
		sDDePlugsV[3] = "Gold Soul Gem"
		 DDePlugsV[3] = iDDe_GoldPlugSoulGemVg_Inv
		sDDePlugsV[4] = "Inox Soul Gem"
		 DDePlugsV[4] = iDDe_InoxPlugSoulGemVg_Inv
		sDDePlugsV[5] = "Jade Soul Gem"
		 DDePlugsV[5] = iDDe_JadePlugSoulGemVg_Inv
		sDDePlugsV[6] = "Fifa Soul Gem"
		 DDePlugsV[6] = iDDe_FifaPlugSoulGemVg_Inv 
		sDDePlugsV[7] = "Fire Soul Gem"
		 DDePlugsV[7] = iDDe_FirePlugSoulGemVg_Inv
		sDDePlugsV[8] = "Crimson Soul Gem"
		 DDePlugsV[8] = iDDe_CrimsonPlugSoulGemVg_Inv
		sDDePlugsV[9] = "Bumblebee Soul Gem"
		 DDePlugsV[9] = iDDe_BumbeePlugSoulGemVg_Inv 
EndFunction
STRING[] Property sDDxPlugsV Auto Hidden	
FORM[] Property DDxPlugsV Auto Hidden
Function iDDeSetPlugsVDDx()
	sDDxPlugsV = NEW STRING[18]
	 DDxPlugsV = NEW FORM[18]
		sDDxPlugsV[0] = "No DDx Vj Plug"
		 DDxPlugsV[0] = None	
		sDDxPlugsV[1] = "Vintage Iron"
		 DDxPlugsV[1] = ZadLib.plugIronVag
		sDDxPlugsV[2] = "Primitive"
		 DDxPlugsV[2] = ZadLib.plugPrimitiveVag
		sDDxPlugsV[3] = "Soul Gem"
		 DDxPlugsV[3] = ZadLib.plugSoulgemVag
		sDDxPlugsV[4] = "Inflatable "
		 DDxPlugsV[4] = ZadLib.plugInflatableVag
		sDDxPlugsV[5] = "Chargeable "
		 DDxPlugsV[5] = ZadLib.plugChargeableVag 
		sDDxPlugsV[6] = "Training"
		 DDxPlugsV[6] = ZadLib.plugTrainingVag
		sDDxPlugsV[7] = "Greater Soul Gem"
		 DDxPlugsV[7] = ZadxLib.PlugsGreaterSoulVag
		sDDxPlugsV[8] = "Grand Soul Gem"
		 DDxPlugsV[8] = ZadxLib.PlugsGrandSoulVag
		sDDxPlugsV[9] = "Black Soul Gem"
		 DDxPlugsV[9] = ZadxLib.PlugsBlackSoulVag
		sDDxPlugsV[10] = "Filled Soul Gem"
		 DDxPlugsV[10] = ZadxLib.PlugsFilledSoulVag	
		sDDxPlugsV[11] = "Shocking Soul Gem"
		 DDxPlugsV[11] = ZadxLib.PlugsShockSoulVag
		sDDxPlugsV[12] = "HR Iron Vaginal"
		 DDxPlugsV[12] = ZadxLib.zadx_HR_IronPearVaginalBlackInventory
		sDDxPlugsV[13] = "HR Iron Pear Bell"
		 DDxPlugsV[13] = ZadxLib.zadx_HR_IronPearVaginalBellBlackInventory
		sDDxPlugsV[14] = "HR Iron Pear Chain"
		 DDxPlugsV[14] = ZadxLib.zadx_HR_IronPearVaginalChainBlackInventory
		sDDxPlugsV[15] = "HR Iron Pear Rusty"
		 DDxPlugsV[15] = ZadxLib.zadx_HR_RustyIronPearVaginalInventory
		sDDxPlugsV[16] = "HR Iron Pear Bell Rusty "
		 DDxPlugsV[16] = ZadxLib.zadx_HR_RustyIronPearVaginalBellInventory
		sDDxPlugsV[17] = "HR Iron Pear Chain Rusty"
		 DDxPlugsV[17] = ZadxLib.zadx_HR_RustyIronPearVaginalChainInventory 
EndFunction
STRING[] Property sCDxPlugsV Auto Hidden	
FORM[] Property CDxPlugsV Auto Hidden
Function iDDeSetPlugsVCDx()
	If (bGotCD)
		sCDxPlugsV = iDDeCDxUtil.iDDeSetPlugsVCDxStr()
		 CDxPlugsV = iDDeCDxUtil.iDDeSetPlugsVCDxForm()
	Else
		sCDxPlugsV = NEW STRING[1]
		 CDxPlugsV = NEW FORM[1]
		 	sCDxPlugsV[0] = "No CD Vj Plug"
			 CDxPlugsV[0] = None	
	EndIf		
EndFunction
;pvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvpvp   

;Gloves Slot No. 33
;ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
STRING[] Property sDDeGloves Auto Hidden	
FORM[] Property DDeGloves Auto Hidden
Function iDDeSetGloves()
	sDDeGloves = NEW STRING[35]
	 DDeGloves = NEW FORM[35]	
		sDDeGloves[0] = "No DDe Gloves"	
		 DDeGloves[0] = None	
		sDDeGloves[1] = "Falmer Paw"	
		 DDeGloves[1] = iDDe_FalmerBondageMittensPaw_Inv	
		sDDeGloves[2] = "Brown Leather Paw"	
		 DDeGloves[2] = iDDe_LeBrBondageMittensPaw_Inv	
		sDDeGloves[3] = "Wood Paw"	
		 DDeGloves[3] = iDDe_WoodBondageMittensPaw_Inv	
		sDDeGloves[4] = "Lite Wood Paw"	
		 DDeGloves[4] = iDDe_LteWoodBondageMittensPaw_Inv	
		sDDeGloves[5] = "Gold Paw"	
		 DDeGloves[5] = iDDe_GoldBondageMittensPaw_Inv	
		sDDeGloves[6] = "Inox Paw"	
		 DDeGloves[6] = iDDe_InoxBondageMittensPaw_Inv	
		sDDeGloves[7] = "Rope Paw"	
		 DDeGloves[7] = iDDe_RopeBondageMittensPaw_Inv	
		sDDeGloves[8] = "Rusty Paw"	
		 DDeGloves[8] = iDDe_RustyBondageMittensPaw_Inv	
		sDDeGloves[9] = "Chromo-Hex Paw"	
		 DDeGloves[9] = iDDe_HexChBondageMittensPaw_Inv	
		sDDeGloves[10] = "Red-Hex Paw"	
		 DDeGloves[10] = iDDe_HexRdBondageMittensPaw_Inv
		sDDeGloves[11] = "Orange-Hex Paw"	
		 DDeGloves[11] = iDDe_HexOrBondageMittensPaw_Inv 
		sDDeGloves[12] = "Hypnotic Paw"	
		 DDeGloves[12] = iDDe_HypBondageMittensPaw_Inv
		sDDeGloves[13] = "Jade Paw"	
		 DDeGloves[13] = iDDe_JadeBondageMittensPaw_Inv	
		sDDeGloves[14] = "Fifa Paw"	
		 DDeGloves[14] = iDDe_FifaBondageMittensPaw_Inv
		sDDeGloves[15] = "Fire Paw"	
		 DDeGloves[15] = iDDe_FireBondageMittensPaw_Inv	
		sDDeGloves[16] = "Crimson Paw"	
		 DDeGloves[16] = iDDe_CrimsonBondageMittensPaw_Inv	
		sDDeGloves[17] = "Bumblebee Paw"	
		 DDeGloves[17] = iDDe_BumbeeBondageMittensPaw_Inv	
		sDDeGloves[18] = "Falmer Cat"	
		 DDeGloves[18] = iDDe_FalmerCatGloves_Inv
		sDDeGloves[19] = "Brown Leather Cat"	
		 DDeGloves[19] = iDDe_LeBrCatGloves_Inv
		sDDeGloves[20] = "Wood Cat"	
		 DDeGloves[20] = iDDe_WoodCatGloves_Inv
		sDDeGloves[21] = "Lite Wood Cat"
		 DDeGloves[21] = iDDe_LteWoodCatGloves_Inv
		sDDeGloves[22] = "Gold Cat"	
		 DDeGloves[22] = iDDe_GoldCatGloves_Inv
		sDDeGloves[23] = "Inox Cat"	
		 DDeGloves[23] = iDDe_InoxCatGloves_Inv
		sDDeGloves[24] = "Rope Cat"	
		 DDeGloves[24] = iDDe_RopeCatGloves_Inv
		sDDeGloves[25] = "Rusty Cat"
		 DDeGloves[25] = iDDe_RustyCatGloves_Inv
		sDDeGloves[26] = "Chomo-Hex Cat"	
		 DDeGloves[26] = iDDe_HexChCatGloves_Inv	
		sDDeGloves[27] = "Red-Hex Cat"	
		 DDeGloves[27] = iDDe_HexRdCatGloves_Inv
		sDDeGloves[28] = "Orange-Hex Cat"	
		 DDeGloves[28] = iDDe_HexOrCatGloves_Inv
		sDDeGloves[29] = "Hypnotic Cat"	
		 DDeGloves[29] = iDDe_HypCatGloves_Inv
		sDDeGloves[30] = "Jade Cat"	
		 DDeGloves[30] = iDDe_JadeCatGloves_Inv
		sDDeGloves[31] = "Fifa Cat"
		 DDeGloves[31] = iDDe_FifaCatGloves_Inv
		sDDeGloves[32] = "Fire Cat"	
		 DDeGloves[32] = iDDe_FireCatGloves_Inv
		sDDeGloves[33] = "Crimson Cat"	
		 DDeGloves[33] = iDDe_CrimsonCatGloves_Inv
		sDDeGloves[34] = "Bumblebee Cat"	
		 DDeGloves[34] = iDDe_BumbeeCatGloves_Inv 
EndFunction
STRING[] Property sDDxGloves Auto Hidden	
FORM[] Property DDxGloves Auto Hidden
Function iDDeSetGlovesDDx()
	sDDxGloves = NEW STRING[30]
	 DDxGloves = NEW FORM[30]	
		sDDxGloves[0] = "No DDx Gloves"	
		 DDxGloves[0] = None	
		sDDxGloves[1] = "Restrictive" 
		 DDxGloves[1] = ZadLib.glovesRestrictive
		sDDxGloves[2] = "Black Ebonite Restrictive"
		 DDxGloves[2] = ZadxLib.EbRestrictiveGloves
		sDDxGloves[3] = "White Ebonite Restrictive"
		 DDxGloves[3] = ZadxLib.WTErestrictiveGloves
		sDDxGloves[4] = "White Leather Restrictive"
		 DDxGloves[4] = ZadxLib.WTLrestrictiveGloves
		sDDxGloves[5] = "Red Ebonite Restrictive"
		 DDxGloves[5] = ZadxLib.RDErestrictiveGloves
		sDDxGloves[6] = "Red Leather Restrictive"
		 DDxGloves[6] = ZadxLib.RDLrestrictiveGloves
		sDDxGloves[7] = "HR Chain Harness" 
		 DDxGloves[7] = ZadxLib.zadx_HR_ChainHarnessGlovesInventory
		sDDxGloves[8] = "HR Chain Harness Rusty"
		 DDxGloves[8] = ZadxLib.zadx_HR_RustyChainHarnessGlovesInventory
		sDDxGloves[9] = "Leather Black Paw"
		 DDxGloves[9] = ZadxLib.zadx_PawBondageMittensInventory
		sDDxGloves[10] = "Leather Red Paw"
		 DDxGloves[10] = ZadxLib.zadx_PawBondageMittensRedInventory
		sDDxGloves[11] = "Leather White Paw"
		 DDxGloves[11] = ZadxLib.zadx_PawBondageMittensWhiteInventory
		sDDxGloves[12] = "Ebonite Black Paw"
		 DDxGloves[12] = ZadxLib.zadx_PawBondageMittensLatexInventory
		sDDxGloves[13] = "Ebonite Red Paw" 
		 DDxGloves[13] = ZadxLib.zadx_PawBondageMittensRedLatexInventory
		sDDxGloves[14] = "Ebonite White Paw"
		 DDxGloves[14] = ZadxLib.zadx_PawBondageMittensWhiteLatexInventory
		sDDxGloves[15] = "Black Cat"
		 DDxGloves[15] = ZadxLib.zadx_catsuit_gloves_black_Inventory
		sDDxGloves[16] = "Blue Cat"
		 DDxGloves[16] = ZadxLib.zadx_catsuit_gloves_blue_Inventory
		sDDxGloves[17] = "Cyan Cat" 
		 DDxGloves[17] = ZadxLib.zadx_catsuit_gloves_cyan_Inventory
		sDDxGloves[18] = "Greener Cat"
		 DDxGloves[18] = ZadxLib.zadx_catsuit_gloves_dgreen_Inventory
		sDDxGloves[19] = "Grayer Cat"
		 DDxGloves[19] = ZadxLib.zadx_catsuit_gloves_dgrey_Inventory
		sDDxGloves[20] = "Reder Cat"
		 DDxGloves[20] = ZadxLib.zadx_catsuit_gloves_dred_Inventory
		sDDxGloves[21] = "Gold Cat"
		 DDxGloves[21] = ZadxLib.zadx_catsuit_gloves_gold_Inventory
		sDDxGloves[22] = "Orange Cat"
		 DDxGloves[22] = ZadxLib.zadx_catsuit_gloves_orange_Inventory
		sDDxGloves[23] = "Pink Cat" 
		 DDxGloves[23] = ZadxLib.zadx_catsuit_gloves_pink_Inventory
		sDDxGloves[24] = "Purple Cat"
		 DDxGloves[24] = ZadxLib.zadx_catsuit_gloves_purple_Inventory
		sDDxGloves[25] = "Red Cat"
		 DDxGloves[25] = ZadxLib.zadx_catsuit_gloves_red_Inventory
		sDDxGloves[26] = "White Cat"
		 DDxGloves[26] = ZadxLib.zadx_catsuit_gloves_white_Inventory
		sDDxGloves[27] = "Red White Cat" 
		 DDxGloves[27] = ZadxLib.zadx_catsuit_gloves_redwhite_Inventory
		sDDxGloves[28] = "Yellow Cat"
		 DDxGloves[28] = ZadxLib.zadx_catsuit_gloves_yellow_Inventory
		sDDxGloves[29] = "Trans Cat"
		 DDxGloves[29] = ZadxLib.zadx_catsuit_longgloves_transparent_Inventory 
EndFunction
;ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg 

;Boots Slot No. 37
;ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
STRING[] Property sDDeBoots Auto Hidden	
FORM[] Property DDeBoots Auto Hidden
Function iDDeSetBoots()
	sDDeBoots = NEW STRING[46]
	 DDeBoots = NEW FORM[46]
		sDDeBoots[0] = "No DDe Boots"	
		 DDeBoots[0] = None			 
		sDDeBoots[1] = "Falmer Pony"	
		 DDeBoots[1] = iDDe_FalmerPonyBoots_Inv
		sDDeBoots[2] = "Wood Pony"	
		 DDeBoots[2] = iDDe_WoodPonyBoots_Inv
		sDDeBoots[3] = "Gold Pony"	
		 DDeBoots[3] = iDDe_GoldPonyBoots_Inv
		sDDeBoots[4] = "Gold Ring"	
		 DDeBoots[4] = iDDe_GoldRingShoes_Inv
		sDDeBoots[5] = "Inox Pony"	
		 DDeBoots[5] = iDDe_InoxPonyBoots_Inv
		sDDeBoots[6] = "Inox Ring"	
		 DDeBoots[6] = iDDe_InoxRingShoes_Inv
		sDDeBoots[7] = "Lite Wood Pony"	
		 DDeBoots[7] = iDDe_LteWoodPonyBoots_Inv
		sDDeBoots[8] = "Rusty Pony"	
		 DDeBoots[8] = iDDe_RustyPonyBoots_Inv
		sDDeBoots[9] = "Chromo-Hex Pony"	
		 DDeBoots[9] = iDDe_HexChPonyBoots_Inv
		sDDeBoots[10] = "Red Hex Pony"	
		 DDeBoots[10] = iDDe_HexRdPonyBoots_Inv
		sDDeBoots[11] = "Hypnotic Pony"	
		 DDeBoots[11] = iDDe_HypPonyBoots_Inv
		sDDeBoots[12] = "Jade Pony"	
		 DDeBoots[12] = iDDe_JadePonyBoots_Inv
		sDDeBoots[13] = "Jade Ring"	
		 DDeBoots[13] = iDDe_JadeRingShoes_Inv
		sDDeBoots[14] = "Fifa Pony"	
		 DDeBoots[14] = iDDe_FifaPonyBoots_Inv
		sDDeBoots[15] = "Fifa Ring"	
		 DDeBoots[15] = iDDe_FifaRingShoes_Inv
		sDDeBoots[16] = "Fire Pony"	
		 DDeBoots[16] = iDDe_FirePonyBoots_Inv
		sDDeBoots[17] = "Fire Ring"	
		 DDeBoots[17] = iDDe_FireRingShoes_Inv
		sDDeBoots[18] = "Rope Pony"	
		 DDeBoots[18] = iDDe_RopePonyBoots_Inv
		sDDeBoots[19] = "Brown Leather Pony"	
		 DDeBoots[19] = iDDe_LeBrPonyBoots_Inv
		sDDeBoots[20] = "Crimson Pony"	
		 DDeBoots[20] = iDDe_CrimsonPonyBoots_Inv
		sDDeBoots[21] = "Crimson Ring"	
		 DDeBoots[21] = iDDe_CrimsonRingShoes_Inv
		sDDeBoots[22] = "Iron Ring"	
		 DDeBoots[22] = iDDe_IronRingShoes_Inv
		sDDeBoots[23] = "Orange-Hex Pony"	
		 DDeBoots[23] = iDDe_HexOrPonyBoots_Inv
		sDDeBoots[24] = "Bumblebee Pony"	
		 DDeBoots[24] = iDDe_BumbeePonyBoots_Inv
		sDDeBoots[25] = "Bumblebee Ring"	
		 DDeBoots[25] = iDDe_BumbeeRingShoes_Inv
		sDDeBoots[26] = "Falmer Heels"	
		 DDeBoots[26] = iDDe_FalmerSlaveHighHeels_Inv
		sDDeBoots[27] = "Brown Leather Heels"	
		 DDeBoots[27] = iDDe_LeBrSlaveHighHeels_Inv
		sDDeBoots[28] = "Wood Heels"	
		 DDeBoots[28] = iDDe_WoodSlaveHighHeels_Inv
		sDDeBoots[29] = "Lite Wood Heels"	
		 DDeBoots[29] = iDDe_LteWoodSlaveHighHeels_Inv
		sDDeBoots[30] = "Gold Heels"	
		 DDeBoots[30] = iDDe_GoldSlaveHighHeels_Inv
		sDDeBoots[31] = "Inox Heels"	
		 DDeBoots[31] = iDDe_InoxSlaveHighHeels_Inv
		sDDeBoots[32] = "Rope Heels"	
		 DDeBoots[32] = iDDe_RopeSlaveHighHeels_Inv
		sDDeBoots[33] = "Rusty Heels"	
		 DDeBoots[33] = iDDe_RustySlaveHighHeels_Inv
		sDDeBoots[34] = "Chromo-Hex Heels"	
		 DDeBoots[34] = iDDe_HexChSlaveHighHeels_Inv
		sDDeBoots[35] = "Red-Hex Heels"	
		 DDeBoots[35] = iDDe_HexRdSlaveHighHeels_Inv
		sDDeBoots[36] = "Orange-Hex Heels"	
		 DDeBoots[36] = iDDe_HexOrSlaveHighHeels_Inv
		sDDeBoots[37] = "Hypnotic Heels"	
		 DDeBoots[37] = iDDe_HypSlaveHighHeels_Inv
		sDDeBoots[38] = "Jade Heels"	
		 DDeBoots[38] = iDDe_JadeSlaveHighHeels_Inv
		sDDeBoots[39] = "Fifa Heels"	
		 DDeBoots[39] = iDDe_FifaSlaveHighHeels_Inv
		sDDeBoots[40] = "Fire Heels"	
		 DDeBoots[40] = iDDe_FireSlaveHighHeels_Inv
		sDDeBoots[41] = "Crimson Heels"	
		 DDeBoots[41] = iDDe_CrimsonSlaveHighHeels_Inv
		sDDeBoots[42] = "Bumblebee Heels"	
		 DDeBoots[42] = iDDe_BumbeeSlaveHighHeels_Inv 
		sDDeBoots[43] = "Black Ebonite Heels"	
		 DDeBoots[43] = iDDe_EbBkSlaveHighHeels_Inv
		sDDeBoots[44] = "Red Ebonite Heels"	
		 DDeBoots[44] = iDDe_EbRdSlaveHighHeels_Inv
		sDDeBoots[45] = "White Ebonite Heels"	
		 DDeBoots[45] = iDDe_EbWhSlaveHighHeels_Inv  
EndFunction
STRING[] Property sDDxBoots Auto Hidden	
FORM[] Property DDxBoots Auto Hidden
Function iDDeSetBootsDDx()
	sDDxBoots = NEW STRING[40]
	 DDxBoots = NEW FORM[40]
		sDDxBoots[0] = "No DDx Boots"	
		 DDxBoots[0] = None	
		sDDxBoots[1] = "Metal Unlocked"
		 DDxBoots[1] = ZadxLib.bootsUnlocked
		sDDxBoots[2] = "Metal Locking"
		 DDxBoots[2] = ZadxLib.bootsLocking
		sDDxBoots[3] = "Restrictive "
		 DDxBoots[3] = ZadxLib.restrictiveBoots
		sDDxBoots[4] = "Black Ebonite Restrictive"
		 DDxBoots[4] = ZadxLib.EbRestrictiveBoots
		sDDxBoots[5] = "White Ebonite Restrictive"
		 DDxBoots[5] = ZadxLib.WTErestrictiveBoots
		sDDxBoots[6] = "White Leather Restrictive"
		 DDxBoots[6] = ZadxLib.WTLrestrictiveBoots
		sDDxBoots[7] = "Red Ebonite Restrictive"
		 DDxBoots[7] = ZadxLib.RDErestrictiveBoots 
		sDDxBoots[8] = "Red Leather Restrictive"
		 DDxBoots[8] = ZadxLib.RDLrestrictiveBoots
		sDDxBoots[9] = "Black Leather Pony"
		 DDxBoots[9] = ZadxLib.PonyBoots
		sDDxBoots[10] = "Black Ebonite Pony"
		 DDxBoots[10] = ZadxLib.EbonitePonyBoots
		sDDxBoots[11] = "Red Leather Pony"
		 DDxBoots[11] = ZadxLib.RDLeatherPonyBoots
		sDDxBoots[12] = "White Leather Pony"
		 DDxBoots[12] = ZadxLib.WTLeatherPonyBoots
		sDDxBoots[13] = "Red Ebonite Pony"
		 DDxBoots[13] = ZadxLib.RDEbonitePonyBoots
		sDDxBoots[14] = "White Ebonite Pony"
		 DDxBoots[14] = ZadxLib.WTEbonitePonyBoots 
		sDDxBoots[15] = "HR Chain Harness"
		 DDxBoots[15] = ZadxLib.zadx_HR_ChainHarnessBootsInventory
		sDDxBoots[16] = "HR Chain Harness Rusty"
		 DDxBoots[16] = ZadxLib.zadx_HR_RustyChainHarnessBootsInventory
		sDDxBoots[17] = "HR Iron Ballet"
		 DDxBoots[17] = ZadxLib.zadx_HR_IronBalletBootsInventory
		sDDxBoots[18] = "HR Iron Ballet Heels"
		 DDxBoots[18] = ZadxLib.zadx_HR_IronBalletBootsHeelInventory
		sDDxBoots[19] = "HR Iron Ballet Rusty"
		 DDxBoots[19] = ZadxLib.zadx_HR_RustyIronBalletBootsInventory
		sDDxBoots[20] = "HR Iron Ballet Heels Rusty"
		 DDxBoots[20] = ZadxLib.zadx_HR_RustyIronBalletBootsHeelInventory
		sDDxBoots[21] = "Leather Black Heels"
		 DDxBoots[21] = ZadxLib.zadx_SlaveHighHeelsInventory
		sDDxBoots[22] = "Leather Red Heels"
		 DDxBoots[22] = ZadxLib.zadx_SlaveHighHeelsRedInventory
		sDDxBoots[23] = "Leather White Heels"
		 DDxBoots[23] = ZadxLib.zadx_SlaveHighHeelsWhiteInventory
		sDDxBoots[24] = "Trans Restrictive"
		 DDxBoots[24] = ZadxLib.zadx_restrictiveBootsTrans_Inventory 
		sDDxBoots[25] = "Black Cat Heels"
		 DDxBoots[25] = ZadxLib.zadx_catsuit_balletboots_black_Inventory
		sDDxBoots[26] = "Blue Cat Heels"
		 DDxBoots[26] = ZadxLib.zadx_catsuit_balletboots_blue_Inventory
		sDDxBoots[27] = "Cyan Cat Heels"
		 DDxBoots[27] = ZadxLib.zadx_catsuit_balletboots_cyan_Inventory
		sDDxBoots[28] = "Greener Cat Heels"
		 DDxBoots[28] = ZadxLib.zadx_catsuit_balletboots_dgreen_Inventory
		sDDxBoots[29] = "Grayer Cat Heels"
		 DDxBoots[29] = ZadxLib.zadx_catsuit_balletboots_dgrey_Inventory
		sDDxBoots[30] = "Reder Cat Heels"
		 DDxBoots[30] = ZadxLib.zadx_catsuit_balletboots_dred_Inventory
		sDDxBoots[31] = "Gold Cat Heels"
		 DDxBoots[31] = ZadxLib.zadx_catsuit_balletboots_gold_Inventory
		sDDxBoots[32] = "Orange Cat Heels"
		 DDxBoots[32] = ZadxLib.zadx_catsuit_balletboots_orange_Inventory
		sDDxBoots[33] = "Pink Cat Heels"
		 DDxBoots[33] = ZadxLib.zadx_catsuit_balletboots_pink_Inventory
		sDDxBoots[34] = "Purple Cat Heels"
		 DDxBoots[34] = ZadxLib.zadx_catsuit_balletboots_purple_Inventory
		sDDxBoots[35] = "Red Cat Heels"
		 DDxBoots[35] = ZadxLib.zadx_catsuit_balletboots_red_Inventory
		sDDxBoots[36] = "White Cat Heels"
		 DDxBoots[36] = ZadxLib.zadx_catsuit_balletboots_white_Inventory
		sDDxBoots[37] = "Yellow Cat Heels"
		 DDxBoots[37] = ZadxLib.zadx_catsuit_balletboots_yellow_Inventory
		sDDxBoots[38] = "Trans Cat Heels"
		 DDxBoots[38] = ZadxLib.zadx_catsuit_boots_transparent_Inventory
		sDDxBoots[39] = "Black Ebonite Pony Play"
		 DDxBoots[39] = ZadxLib.zadx_XinEbonitePonyBoots_Play_Inventory 
EndFunction
;ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo

;Suits Slot No. 32
;ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
STRING[] Property sDDeSuits Auto Hidden	
FORM[] Property DDeSuits Auto Hidden
Function iDDeSetSuits() 
	sDDeSuits = NEW STRING[86]
	 DDeSuits = NEW FORM[86]
		sDDeSuits[0] = "No DDe Dress"	
		 DDeSuits[0] = None	
		sDDeSuits[1] = "Falmer Elegant"	
		 DDeSuits[1] = iDDe_FalmerHobbleDressElegant_Inv
		sDDeSuits[2] = "Falmer Ex"	
		 DDeSuits[2] = iDDe_FalmerHobbleDress_Inv
		sDDeSuits[3] = "Falmer Open Ex"	
		 DDeSuits[3] = iDDe_FalmerHobbleDressOpen_Inv
		sDDeSuits[4] = "Falmer Latex"	
		 DDeSuits[4] = iDDe_FalmerHobbleDressLatex_Inv
		sDDeSuits[5] = "Falmer Open Latex"	
		 DDeSuits[5] = iDDe_FalmerHobbleDressOpenLatex_Inv 
		sDDeSuits[6] = "Brown Leather Elegant"	
		 DDeSuits[6] = iDDe_LeBrHobbleDressElegant_Inv
		sDDeSuits[7] = "Brown Leather Ex"	
		 DDeSuits[7] = iDDe_LeBrHobbleDress_Inv
		sDDeSuits[8] = "Brown Leather Open Ex"	
		 DDeSuits[8] = iDDe_LeBrHobbleDressOpen_Inv
		sDDeSuits[9] = "Brown Leather Latex"	
		 DDeSuits[9] = iDDe_LeBrHobbleDressLatex_Inv
		sDDeSuits[10] = "Brown Leather Open Latex"	
		 DDeSuits[10] = iDDe_LeBrHobbleDressOpenLatex_Inv
		sDDeSuits[11] = "Wood Elegant"	
		 DDeSuits[11] = iDDe_WoodHobbleDressElegant_Inv
		sDDeSuits[12] = "Wood Ex"	
		 DDeSuits[12] = iDDe_WoodHobbleDress_Inv
		sDDeSuits[13] = "Wood Open Ex"	
		 DDeSuits[13] = iDDe_WoodHobbleDressOpen_Inv
		sDDeSuits[14] = "Wood Latex"	
		 DDeSuits[14] = iDDe_WoodHobbleDressLatex_Inv
		sDDeSuits[15] = "Wood Open Latex"	
		 DDeSuits[15] = iDDe_WoodHobbleDressOpenLatex_Inv
		sDDeSuits[16] = "Lite Wood Elegant"	
		 DDeSuits[16] = iDDe_LteWoodHobbleDressElegant_Inv
		sDDeSuits[17] = "Lite Wood Ex"	
		 DDeSuits[17] = iDDe_LteWoodHobbleDress_Inv
		sDDeSuits[18] = "Lite Wood Open Ex"	
		 DDeSuits[18] = iDDe_LteWoodHobbleDressOpen_Inv
		sDDeSuits[19] = "Lite Wood Latex"	
		 DDeSuits[19] = iDDe_LteWoodHobbleDressLatex_Inv
		sDDeSuits[20] = "Lite Wood Open Latex"	
		 DDeSuits[20] = iDDe_LteWoodHobbleDressOpenLatex_Inv
		sDDeSuits[21] = "Gold Elegant"	
		 DDeSuits[21] = iDDe_GoldHobbleDressElegant_Inv
		sDDeSuits[22] = "Gold Ex"	
		 DDeSuits[22] = iDDe_GoldHobbleDress_Inv
		sDDeSuits[23] = "Gold Open Ex"	
		 DDeSuits[23] = iDDe_GoldHobbleDressOpen_Inv
		sDDeSuits[24] = "Gold Latex"	
		 DDeSuits[24] = iDDe_GoldHobbleDressLatex_Inv
		sDDeSuits[25] = "Gold Open Latex"	
		 DDeSuits[25] = iDDe_GoldHobbleDressOpenLatex_Inv
		sDDeSuits[26] = "Inox Elegant"	
		 DDeSuits[26] = iDDe_InoxHobbleDressElegant_Inv
		sDDeSuits[27] = "Inox Ex"	
		 DDeSuits[27] = iDDe_InoxHobbleDress_Inv
		sDDeSuits[28] = "Inox Open Ex"	
		 DDeSuits[28] = iDDe_InoxHobbleDressOpen_Inv
		sDDeSuits[29] = "Inox Latex"	
		 DDeSuits[29] = iDDe_InoxHobbleDressLatex_Inv
		sDDeSuits[30] = "Inox Open Latex"	
		 DDeSuits[30] = iDDe_InoxHobbleDressOpenLatex_Inv
		sDDeSuits[31] = "Rope Elegant"	
		 DDeSuits[31] = iDDe_RopeHobbleDressElegant_Inv
		sDDeSuits[32] = "Rope Ex"	
		 DDeSuits[32] = iDDe_RopeHobbleDress_Inv
		sDDeSuits[33] = "Rope Open Ex"	
		 DDeSuits[33] = iDDe_RopeHobbleDressOpen_Inv
		sDDeSuits[34] = "Rope Latex"	
		 DDeSuits[34] = iDDe_RopeHobbleDressLatex_Inv
		sDDeSuits[35] = "Rope Open Latex"	
		 DDeSuits[35] = iDDe_RopeHobbleDressOpenLatex_Inv
		sDDeSuits[36] = "Rusty Elegant"	
		 DDeSuits[36] = iDDe_RustyHobbleDressElegant_Inv
		sDDeSuits[37] = "Rusty Ex"	
		 DDeSuits[37] = iDDe_RustyHobbleDress_Inv
		sDDeSuits[38] = "Rusty Open Ex"	
		 DDeSuits[38] = iDDe_RustyHobbleDressOpen_Inv
		sDDeSuits[39] = "Rusty Latex"	
		 DDeSuits[39] = iDDe_RustyHobbleDressLatex_Inv
		sDDeSuits[40] = "Rusty Open Latex"	
		 DDeSuits[40] = iDDe_RustyHobbleDressOpenLatex_Inv
		sDDeSuits[41] = "Chromo-Hex Elegant"	
		 DDeSuits[41] = iDDe_HexChHobbleDressElegant_Inv
		sDDeSuits[42] = "Chromo-Hex Ex"	
		 DDeSuits[42] = iDDe_HexChHobbleDress_Inv
		sDDeSuits[43] = "Chromo-Hex Open Ex"	
		 DDeSuits[43] = iDDe_HexChHobbleDressOpen_Inv
		sDDeSuits[44] = "Chromo-Hex Latex"	
		 DDeSuits[44] = iDDe_HexChHobbleDressLatex_Inv
		sDDeSuits[45] = "Chromo-Hex Open Latex"	
		 DDeSuits[45] = iDDe_HexChHobbleDressOpenLatex_Inv
		sDDeSuits[46] = "Red-Hex Elegant"	
		 DDeSuits[46] = iDDe_HexRdHobbleDressElegant_Inv
		sDDeSuits[47] = "Red-Hex Ex"	
		 DDeSuits[47] = iDDe_HexRdHobbleDress_Inv
		sDDeSuits[48] = "Red-Hex Open Ex"	
		 DDeSuits[48] = iDDe_HexRdHobbleDressOpen_Inv
		sDDeSuits[49] = "Red-Hex Latex"	
		 DDeSuits[49] = iDDe_HexRdHobbleDressLatex_Inv
		sDDeSuits[50] = "Red-Hex Open Latex"	
		 DDeSuits[50] = iDDe_HexRdHobbleDressOpenLatex_Inv
		sDDeSuits[51] = "Orange-Hex Elegant"	
		 DDeSuits[51] = iDDe_HexOrHobbleDressElegant_Inv
		sDDeSuits[52] = "Orange-Hex Ex"	
		 DDeSuits[52] = iDDe_HexOrHobbleDress_Inv
		sDDeSuits[53] = "Orange-Hex Open Ex"	
		 DDeSuits[53] = iDDe_HexOrHobbleDressOpen_Inv
		sDDeSuits[54] = "Orange-Hex Latex"	
		 DDeSuits[54] = iDDe_HexOrHobbleDressLatex_Inv
		sDDeSuits[55] = "Orange-Hex Open Latex"	
		 DDeSuits[55] = iDDe_HexOrHobbleDressOpenLatex_Inv
		sDDeSuits[56] = "Hypnotic Elegant"	
		 DDeSuits[56] = iDDe_HypHobbleDressElegant_Inv
		sDDeSuits[57] = "Hypnotic Ex"	
		 DDeSuits[57] = iDDe_HypHobbleDress_Inv 
		sDDeSuits[58] = "Hypnotic Open Ex"	
		 DDeSuits[58] = iDDe_HypHobbleDressOpen_Inv
		sDDeSuits[59] = "Hypnotic Latex"	
		 DDeSuits[59] = iDDe_HypHobbleDressLatex_Inv 
		sDDeSuits[60] = "Hypnotic Open Latex"	
		 DDeSuits[60] = iDDe_HypHobbleDressOpenLatex_Inv
		sDDeSuits[61] = "Jade Elegant"	
		 DDeSuits[61] = iDDe_JadeHobbleDressElegant_Inv 
		sDDeSuits[62] = "Jade Ex"	
		 DDeSuits[62] = iDDe_JadeHobbleDress_Inv
		sDDeSuits[63] = "Jade Open Ex"	
		 DDeSuits[63] = iDDe_JadeHobbleDressOpen_Inv
		sDDeSuits[64] = "Jade Latex"	
		 DDeSuits[64] = iDDe_JadeHobbleDressLatex_Inv
		sDDeSuits[65] = "Jade Open Latex"	
		 DDeSuits[65] = iDDe_JadeHobbleDressOpenLatex_Inv
		sDDeSuits[66] = "Fifa Elegant"	
		 DDeSuits[66] =	iDDe_FifaHobbleDressElegant_Inv 	
		sDDeSuits[67] = "Fifa Ex"	
		 DDeSuits[67] =	iDDe_FifaHobbleDress_Inv
		sDDeSuits[68] = "Fifa Open Ex"	
		 DDeSuits[68] =	iDDe_FifaHobbleDressOpen_Inv
		sDDeSuits[69] = "Fifa Latex"	
		 DDeSuits[69] =	iDDe_FifaHobbleDressLatex_Inv
		sDDeSuits[70] = "Fifa Open Latex"	
		 DDeSuits[70] =	iDDe_FifaHobbleDressOpenLatex_Inv
		sDDeSuits[71] = "Fire Elegant"	
		 DDeSuits[71] =	iDDe_FireHobbleDressElegant_Inv
		sDDeSuits[72] = "Fire Ex"	
		 DDeSuits[72] =	iDDe_FireHobbleDress_Inv
		sDDeSuits[73] = "Fire Open Ex"	
		 DDeSuits[73] =	iDDe_FireHobbleDressOpen_Inv
		sDDeSuits[74] = "Fire Latex"	
		 DDeSuits[74] =	iDDe_FireHobbleDressLatex_Inv
		sDDeSuits[75] = "Fire Open Latex"	
		 DDeSuits[75] =	iDDe_FireHobbleDressOpenLatex_Inv
		sDDeSuits[76] = "Crimson Elegant"	
		 DDeSuits[76] =	iDDe_CrimsonHobbleDressElegant_Inv
		sDDeSuits[77] = "Crimson Ex"	
		 DDeSuits[77] =	iDDe_CrimsonHobbleDress_Inv
		sDDeSuits[78] = "Crimson Open Ex"	
		 DDeSuits[78] =	iDDe_CrimsonHobbleDressOpen_Inv
		sDDeSuits[79] = "Crimson Latex"	
		 DDeSuits[79] =	iDDe_CrimsonHobbleDressLatex_Inv
		sDDeSuits[80] = "Crimson Open Latex"	
		 DDeSuits[80] =	iDDe_CrimsonHobbleDressOpenLatex_Inv
		sDDeSuits[81] = "Bumblebee Elegant"	
		 DDeSuits[81] =	iDDe_BumbeeHobbleDressElegant_Inv
		sDDeSuits[82] = "Bumblebee Ex"	
		 DDeSuits[82] =	iDDe_BumbeeHobbleDress_Inv
		sDDeSuits[83] = "Bumblebee Open Ex"	
		 DDeSuits[83] =	iDDe_BumbeeHobbleDressOpen_Inv
		sDDeSuits[84] = "Bumblebee Latex"	
		 DDeSuits[84] =	iDDe_BumbeeHobbleDressLatex_Inv
		sDDeSuits[85] = "Bumblebee Open Latex"	
		 DDeSuits[85] =	iDDe_BumbeeHobbleDressOpenLatex_Inv	  
EndFunction
STRING[] Property sDDxSuits Auto Hidden	
FORM[] Property DDxSuits Auto Hidden
Function iDDeSetSuitsDDx()
	sDDxSuits = NEW STRING[33]
	 DDxSuits = NEW FORM[33]
		sDDxSuits[0] = "No DDx Dress"	
		 DDxSuits[0] = None	
		sDDxSuits[1] = "Leather Black Ex"
		 DDxSuits[1] = ZadxLib.zadx_HobbleDressInventory
		sDDxSuits[2] = "Leather Red Ex"
		 DDxSuits[2] = ZadxLib.zadx_HobbleDressRedInventory
		sDDxSuits[3] = "Leather White Ex"
		 DDxSuits[3] = ZadxLib.zadx_HobbleDressWhiteInventory
		sDDxSuits[4] = "Leather Black Open Ex"
		 DDxSuits[4] = ZadxLib.zadx_HobbleDressOpenInventory
		sDDxSuits[5] = "Leather Red Open Ex"
		 DDxSuits[5] = ZadxLib.zadx_HobbleDressRedOpenInventory
		sDDxSuits[6] = "Leather White Open Ex"
		 DDxSuits[6] = ZadxLib.zadx_HobbleDressWhiteOpenInventory
		sDDxSuits[7] = "Ebonite Black Ex"
		 DDxSuits[7] = ZadxLib.zadx_HobbleDressLatexInventory
		sDDxSuits[8] = "Ebonite Red Ex"
		 DDxSuits[8] = ZadxLib.zadx_HobbleDressLatexRedInventory
		sDDxSuits[9] = "Ebonite White Ex"
		 DDxSuits[9] = ZadxLib.zadx_HobbleDressLatexWhiteInventory
		sDDxSuits[10] = "Ebonite Black Open Ex"
		 DDxSuits[10] = ZadxLib.zadx_HobbleDressLatexOpenInventory
		sDDxSuits[11] = "Ebonite Red Open Ex"
		 DDxSuits[11] = ZadxLib.zadx_HobbleDressLatexRedOpenInventory
		sDDxSuits[12] = "Ebonite White Open Ex"
		 DDxSuits[12] = ZadxLib.zadx_HobbleDressLatexWhiteOpenInventory
		sDDxSuits[13] = "Leather Black Reg"
		 DDxSuits[13] = ZadxLib.zadx_HobbleDressRelaxedInventory
		sDDxSuits[14] = "Leather Red Reg"
		 DDxSuits[14] = ZadxLib.zadx_HobbleDressRedRelaxedInventory 
		sDDxSuits[15] = "Leather White Reg"	
		 DDxSuits[15] = ZadxLib.zadx_HobbleDressWhiteRelaxedInventory
		sDDxSuits[16] = "Leather Black Open Reg"	
		 DDxSuits[16] = ZadxLib.zadx_HobbleDressOpenRelaxedInventory
		sDDxSuits[17] = "Leather Red Open Reg"	
		 DDxSuits[17] = ZadxLib.zadx_HobbleDressRedOpenRelaxedInventory
		sDDxSuits[18] = "Leather White Open Reg"	
		 DDxSuits[18] = ZadxLib.zadx_HobbleDressWhiteOpenRelaxedInventory
		sDDxSuits[19] = "Ebonite Black Reg"	
		 DDxSuits[19] = ZadxLib.zadx_HobbleDressLatexRelaxedInventory
		sDDxSuits[20] = "Ebonite Red Reg"	
		 DDxSuits[20] = ZadxLib.zadx_HobbleDressLatexRedRelaxedInventory
		sDDxSuits[21] = "Ebonite White Reg"	
		 DDxSuits[21] = ZadxLib.zadx_HobbleDressLatexWhiteRelaxedInventory
		sDDxSuits[22] = "Ebonite Black Open Reg"	
		 DDxSuits[22] = ZadxLib.zadx_HobbleDressLatexOpenRelaxedInventory
		sDDxSuits[23] = "Ebonite Red Open Reg"	
		 DDxSuits[23] = ZadxLib.zadx_HobbleDressLatexRedOpenRelaxedInventory
		sDDxSuits[24] = "Ebonite White Open Reg"	
		 DDxSuits[24] = ZadxLib.zadx_HobbleDressLatexWhiteOpenRelaxedInventory
		sDDxSuits[25] = "Leather Black Elegant"	
		 DDxSuits[25] = ZadxLib.zadx_ElegantHobbleDressInventory
		sDDxSuits[26] = "Leather Red Elegant"	
		 DDxSuits[26] = ZadxLib.zadx_ElegantHobbleDressRedInventory
		sDDxSuits[27] = "Leather White Elegant"	
		 DDxSuits[27] = ZadxLib.zadx_ElegantHobbleDressWhiteInventory
		sDDxSuits[28] = "Ebonite Black Elegant"	
		 DDxSuits[28] = ZadxLib.zadx_ElegantHobbleDressLatexInventory
		sDDxSuits[29] = "Ebonite Red Elegant"	
		 DDxSuits[29] = ZadxLib.zadx_ElegantHobbleDressLatexRedInventory 
		sDDxSuits[30] = "Ebonite White Elegant"	
		 DDxSuits[30] = ZadxLib.zadx_ElegantHobbleDressLatexWhiteInventory 
		sDDxSuits[31] = "Trans Ex"	
		 DDxSuits[31] = ZadxLib.zadx_HobbleDressTransparentInventory
		sDDxSuits[32] = "Natural Rope"	
		 DDxSuits[32] = ZadxLib.zadx_Harness_Rope_Full_Inventory 
EndFunction
;ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd

;CatSuit Slot No. 32, 34, 38 
;ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
STRING[] Property sDDeCatSuits Auto Hidden	
FORM[] Property DDeCatSuits Auto Hidden
Function iDDeSetCatSuits() 
	sDDeCatSuits = NEW STRING[19]
	 DDeCatSuits = NEW FORM[19]
		sDDeCatSuits[0] = "No DDe CatSuit"	
		 DDeCatSuits[0] = None	
		sDDeCatSuits[1] = "Falmer CatSuit"	
		 DDeCatSuits[1] =	iDDe_FalmerCatSuit_Inv
		sDDeCatSuits[2] = "Brown CatSuit"	
		 DDeCatSuits[2] =	iDDe_LeBrCatSuit_Inv
		sDDeCatSuits[3] = "Wood CatSuit"	
		 DDeCatSuits[3] =	iDDe_WoodCatSuit_Inv
		sDDeCatSuits[4] = "Lite Wood CatSuit"	
		 DDeCatSuits[4] =	iDDe_LteWoodCatSuit_Inv
		sDDeCatSuits[5] = "Gold CatSuit"	
		 DDeCatSuits[5] =	iDDe_GoldCatSuit_Inv
		sDDeCatSuits[6] = "Inox CatSuit"	
		 DDeCatSuits[6] =	iDDe_InoxCatSuit_Inv
		sDDeCatSuits[7] = "Rope CatSuit"	
		 DDeCatSuits[7] =	iDDe_RopeCatSuit_Inv
		sDDeCatSuits[8] = "Rusty CatSuit"	
		 DDeCatSuits[8] =	iDDe_RustyCatSuit_Inv
		sDDeCatSuits[9] = "Chromo-Hex CatSuit"	
		 DDeCatSuits[9] =	iDDe_HexChCatSuit_Inv
		sDDeCatSuits[10] = "Red-Hex CatSuit"	
		 DDeCatSuits[10] =	iDDe_HexRdCatSuit_Inv
		sDDeCatSuits[11] = "Orange-Hex CatSuit"	
		 DDeCatSuits[11] =	iDDe_HexOrCatSuit_Inv
		sDDeCatSuits[12] = "Hypnotic CatSuit"	
		 DDeCatSuits[12] =	iDDe_HypCatSuit_Inv
		sDDeCatSuits[13] = "Jade CatSuit"	
		 DDeCatSuits[13] =	iDDe_JadeCatSuit_Inv
		sDDeCatSuits[14] = "FIFA CatSuit"	
		 DDeCatSuits[14] =	iDDe_FifaCatSuit_Inv
		sDDeCatSuits[15] = "Fire CatSuit"	
		 DDeCatSuits[15] = iDDe_FireCatSuit_Inv
		sDDeCatSuits[16] = "Crimson CatSuit"	
		 DDeCatSuits[16] = iDDe_CrimsonCatSuit_Inv	
		sDDeCatSuits[17] = "Bumbee CatSuit"	
		 DDeCatSuits[17] = iDDe_BumbeeCatSuit_Inv	
		sDDeCatSuits[18] = "Trans CatSuit"	
		 DDeCatSuits[18] = iDDe_TransCatSuit_Inv 
EndFunction
STRING[] Property sDDxCatSuits Auto Hidden	
FORM[] Property DDxCatSuits Auto Hidden
Function iDDeSetCatSuitsDDx()
	sDDxCatSuits = NEW STRING[16]
	 DDxCatSuits = NEW FORM[16]
		sDDxCatSuits[0] = "No DDx CatSuit"	
		 DDxCatSuits[0] = None	
		sDDxCatSuits[1] = "Black Cat Suit"	
		 DDxCatSuits[1] = ZadxLib.zadx_catsuit_black_Inventory
		sDDxCatSuits[2] = "Blue Cat Suit"	
		 DDxCatSuits[2] = ZadxLib.zadx_catsuit_blue_Inventory
		sDDxCatSuits[3] = "Cyan Cat Suit"	
		 DDxCatSuits[3] = ZadxLib.zadx_catsuit_cyan_Inventory
		sDDxCatSuits[4] = "Greener Cat Suit"	
		 DDxCatSuits[4] = ZadxLib.zadx_catsuit_dgreen_Inventory
		sDDxCatSuits[5] = "Greyer Cat Suit"	
		 DDxCatSuits[5] = ZadxLib.zadx_catsuit_dgrey_Inventory
		sDDxCatSuits[6] = "Reder Cat Suit"	
		 DDxCatSuits[6] = ZadxLib.zadx_catsuit_dred_Inventory
		sDDxCatSuits[7] = "Gold Cat Suit"	
		 DDxCatSuits[7] = ZadxLib.zadx_catsuit_gold_Inventory
		sDDxCatSuits[8] = "Orange Cat Suit"	
		 DDxCatSuits[8] = ZadxLib.zadx_catsuit_orange_Inventory
		sDDxCatSuits[9] = "Pink Cat Suit"	
		 DDxCatSuits[9] = ZadxLib.zadx_catsuit_pink_Inventory
		sDDxCatSuits[10] = "Purple Cat Suit"	
		 DDxCatSuits[10] = ZadxLib.zadx_catsuit_purple_Inventory
		sDDxCatSuits[11] = "Red Cat Suit"	
		 DDxCatSuits[11] = ZadxLib.zadx_catsuit_red_Inventory
		sDDxCatSuits[12] = "Red White Cat Suit"	
		 DDxCatSuits[12] = ZadxLib.zadx_catsuit_redwhite_Inventory
		sDDxCatSuits[13] = "White Cat Suit"	
		 DDxCatSuits[13] = ZadxLib.zadx_catsuit_white_Inventory
		sDDxCatSuits[14] = "Yellow Cat Suit"	
		 DDxCatSuits[14] = ZadxLib.zadx_catsuit_yellow_Inventory
		sDDxCatSuits[15] = "Trans Cat Suit"	
		 DDxCatSuits[15] = ZadxLib.zadx_catsuit_transparent_Inventory 
EndFunction
;ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

;Mech Slot No. 32, 33, 37, 42, 46, 48, 53, 57
;mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
STRING[] Property sDDeMech Auto Hidden	
FORM[] Property DDeMech Auto Hidden
Function iDDeSetMech() 
	sDDeMech = NEW STRING[3]
	 DDeMech = NEW FORM[3]
		sDDeMech[0] = "No DDe Mech"	
		 DDeMech[0] = None	
		sDDeMech[1] = "Inox Mech"	
		 DDeMech[1] =	iDDe_InoxMechSuit_Inv
		sDDeMech[2] = "Dwemer Mech"	
		 DDeMech[2] =	iDDe_DwemerMechSuit_Inv  
EndFunction
;mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm 

;KeyWords
;kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
STRING[] Property sDDsKwds Auto Hidden	
KEYWORD[] Property kDDsKwds Auto Hidden
STRING[] Property sDDeKwdsAll Auto Hidden	
KEYWORD[] Property kDDeKwdsAll Auto Hidden
Function iDDeSetKeywords()
	sDDsKwds = NEW STRING[25]	
	kDDsKwds = NEW KEYWORD[25]
	Form[] akDDeKwds = NEW Form[25]
		sDDsKwds[0] = "None"
		kDDsKwds[0] = None
		sDDsKwds[1] = "zad_DeviousHeavyBondage"
		kDDsKwds[1] = ZadLib.zad_DeviousHeavyBondage
		sDDsKwds[2] = "zad_DeviousArmCuffs"
		kDDsKwds[2] = ZadLib.zad_DeviousArmCuffs
		sDDsKwds[3] = "zad_DeviousGloves"
		kDDsKwds[3] = ZadLib.zad_DeviousGloves
		sDDsKwds[4] = "zad_DeviousLegCuffs"
		kDDsKwds[4] = ZadLib.zad_DeviousLegCuffs
		sDDsKwds[5] = "zad_DeviousCollar"
		kDDsKwds[5] = ZadLib.zad_DeviousCollar
		sDDsKwds[6] = "zad_DeviousGag"
		kDDsKwds[6] = ZadLib.zad_DeviousGag
		sDDsKwds[7] = "zad_DeviousBelt"
		kDDsKwds[7] = ZadLib.zad_DeviousBelt
		sDDsKwds[8] = "zad_DeviousHarness" 
		kDDsKwds[8] = ZadLib.zad_DeviousHarness
		sDDsKwds[9] = "zad_DeviousBoots"
		kDDsKwds[9] = ZadLib.zad_DeviousBoots
		sDDsKwds[10] = "zad_DeviousBlindfold"
		kDDsKwds[10] = ZadLib.zad_DeviousBlindfold
		sDDsKwds[11] = "zad_DeviousBra"
		kDDsKwds[11] = ZadLib.zad_DeviousBra
		sDDsKwds[12] = "zad_DeviousClamps"
		kDDsKwds[12] = ZadLib.zad_DeviousClamps
		sDDsKwds[13] = "zad_DeviousPiercingsNipple"
		kDDsKwds[13] = ZadLib.zad_DeviousPiercingsNipple
		sDDsKwds[14] = "zad_DeviousPiercingsVaginal"
		kDDsKwds[14] = ZadLib.zad_DeviousPiercingsVaginal
		sDDsKwds[15] = "zad_DeviousCorset"
		kDDsKwds[15] = ZadLib.zad_DeviousCorset
		sDDsKwds[16] = "zad_DeviousSuit"
		kDDsKwds[16] = ZadLib.zad_DeviousSuit
		sDDsKwds[17] = "zad_DeviousHood"
		kDDsKwds[17] = ZadLib.zad_DeviousHood
		sDDsKwds[18] = "zad_DeviousPonyGear"
		kDDsKwds[18] = ZadLib.zad_DeviousPonyGear	
		sDDsKwds[19] = "zad_DeviousBondageMittens"
		kDDsKwds[19] = ZadLib.zad_DeviousBondageMittens
		sDDsKwds[20] = "zad_DeviousPlugAnal"	
		kDDsKwds[20] = ZadLib.zad_DeviousPlugAnal
		sDDsKwds[21] = "zad_DeviousPlugVaginal"
		kDDsKwds[21] = ZadLib.zad_DeviousPlugVaginal
		sDDsKwds[22] = "iDDe_DeviousBoxbinder"
		kDDsKwds[22] = iDDe_DeviousBoxbinder
		;Duplicates
		sDDsKwds[23] = "zad_DeviousPlug" 
		kDDsKwds[23] = ZadLib.zad_DeviousPlug
		sDDsKwds[24] = "zad_DeviousHobbleSkirt"
		kDDsKwds[24] = ZadLib.zad_DeviousHobbleSkirt
		
	sDDeKwdsAll = NEW STRING[46]	
	kDDeKwdsAll = NEW KEYWORD[46]
		sDDeKwdsAll[0] = "None"
		kDDeKwdsAll[0] = None
		sDDeKwdsAll[1] = "zad_DeviousArmbinderElbow"
		kDDeKwdsAll[1] = ZadLib.zad_DeviousArmbinderElbow 
		sDDeKwdsAll[2] = "zad_DeviousArmbinder" 
		kDDeKwdsAll[2] = ZadLib.zad_DeviousArmbinder
		sDDeKwdsAll[3] = "zad_DeviousPetSuit"
		kDDeKwdsAll[3] = ZadLib.zad_DeviousPetSuit
		sDDeKwdsAll[4] = "zad_DeviousCuffsFront"
		kDDeKwdsAll[4] = ZadLib.zad_DeviousCuffsFront
		sDDeKwdsAll[5] = "zad_DeviousYoke" 
		kDDeKwdsAll[5] = ZadLib.zad_DeviousYoke
		sDDeKwdsAll[6] = "zad_DeviousYokeBB" 
		kDDeKwdsAll[6] = ZadLib.zad_DeviousYokeBB
		sDDeKwdsAll[7] = "zad_DeviousHeavyBondage"
		kDDeKwdsAll[7] = ZadLib.zad_DeviousHeavyBondage
		sDDeKwdsAll[8] = "zbfWornYoke"
		kDDeKwdsAll[8] = zbfWornYoke 
		sDDeKwdsAll[9] = "zbfWornWrist"
		kDDeKwdsAll[9] = zbfWornWrist	
		sDDeKwdsAll[10] = "zad_DeviousArmCuffs"
		kDDeKwdsAll[10] = ZadLib.zad_DeviousArmCuffs
		sDDeKwdsAll[11] = "zad_DeviousGloves"
		kDDeKwdsAll[11] = ZadLib.zad_DeviousGloves
		sDDeKwdsAll[12] = "zad_DeviousLegCuffs"
		kDDeKwdsAll[12] = ZadLib.zad_DeviousLegCuffs
		sDDeKwdsAll[13] = "zbfWornAnkles"
		kDDeKwdsAll[13] = zbfWornAnkles
		sDDeKwdsAll[14] = "zad_DeviousCollar"
		kDDeKwdsAll[14] = ZadLib.zad_DeviousCollar
		sDDeKwdsAll[15] = "zbfWornCollar"
		kDDeKwdsAll[15] = zbfWornCollar
		sDDeKwdsAll[16] = "zad_DeviousGag"
		kDDeKwdsAll[16] = ZadLib.zad_DeviousGag
		sDDeKwdsAll[17] = "zad_DeviousGagPanel"
		kDDeKwdsAll[17] = ZadLib.zad_DeviousGagPanel
		sDDeKwdsAll[18] = "zbfWornGag"
		kDDeKwdsAll[18] = zbfWornGag
		sDDeKwdsAll[19] = "zad_DeviousBelt"
		kDDeKwdsAll[19] = ZadLib.zad_DeviousBelt
		sDDeKwdsAll[20] = "zad_DeviousHarness" 
		kDDeKwdsAll[20] = ZadLib.zad_DeviousHarness
		sDDeKwdsAll[21] = "zad_DeviousBoots"
		kDDeKwdsAll[21] = ZadLib.zad_DeviousBoots
		sDDeKwdsAll[22] = "zad_DeviousBlindfold"
		kDDeKwdsAll[22] = ZadLib.zad_DeviousBlindfold
		sDDeKwdsAll[23] = "zad_DeviousPlug" 
		kDDeKwdsAll[23] = ZadLib.zad_DeviousPlug
		sDDeKwdsAll[24] = "zad_DeviousPlugAnal"	
		kDDeKwdsAll[24] = ZadLib.zad_DeviousPlugAnal
		sDDeKwdsAll[25] = "zad_DeviousPlugVaginal"
		kDDeKwdsAll[25] = ZadLib.zad_DeviousPlugVaginal
		sDDeKwdsAll[26] = "zad_DeviousBra"
		kDDeKwdsAll[26] = ZadLib.zad_DeviousBra
		sDDeKwdsAll[27] = "zad_DeviousClamps"
		kDDeKwdsAll[27] = ZadLib.zad_DeviousClamps
		sDDeKwdsAll[28] = "zad_DeviousPiercingsNipple"
		kDDeKwdsAll[28] = ZadLib.zad_DeviousPiercingsNipple
		sDDeKwdsAll[29] = "zad_DeviousPiercingsVaginal"
		kDDeKwdsAll[29] = ZadLib.zad_DeviousPiercingsVaginal
		sDDeKwdsAll[30] = "zad_DeviousCorset"
		kDDeKwdsAll[30] = ZadLib.zad_DeviousCorset
		sDDeKwdsAll[31] = "zad_DeviousSuit"
		kDDeKwdsAll[31] = ZadLib.zad_DeviousSuit
		sDDeKwdsAll[32] = "zad_DeviousStraitJacket"
		kDDeKwdsAll[32] = ZadLib.zad_DeviousStraitJacket
		sDDeKwdsAll[33] = "zad_DeviousHood"
		kDDeKwdsAll[33] = ZadLib.zad_DeviousHood
		sDDeKwdsAll[34] = "zad_BlockGeneric"
		kDDeKwdsAll[34] = ZadLib.zad_BlockGeneric
		sDDeKwdsAll[35] = "zad_InventoryDevice"
		kDDeKwdsAll[35] = ZadLib.zad_InventoryDevice
		sDDeKwdsAll[36] = "zbfWornDevice"
		kDDeKwdsAll[36] = zbfWornDevice
		sDDeKwdsAll[37] = "zad_QuestItem"
		kDDeKwdsAll[37] = ZadLib.zad_QuestItem	
		sDDeKwdsAll[38] = "iSUmKwdWornMech"
		kDDeKwdsAll[38] = iSUmKwdWornMech
		sDDeKwdsAll[39] = "zad_DeviousPonyGear"
		kDDeKwdsAll[39] = ZadLib.zad_DeviousPonyGear
		sDDeKwdsAll[40] = "zad_DeviousHobbleSkirt"
		kDDeKwdsAll[40] = ZadLib.zad_DeviousHobbleSkirt	
		sDDeKwdsAll[41] = "zad_DeviousBondageMittens"
		kDDeKwdsAll[41] = ZadLib.zad_DeviousBondageMittens
		sDDeKwdsAll[42] = "iDDe_DeviousBondageMittens"
		kDDeKwdsAll[42] = iDDe_DeviousBondageMittens
		sDDeKwdsAll[43] = "zad_PermitOral"
		kDDeKwdsAll[43] = ZadLib.zad_PermitOral
		sDDeKwdsAll[44] = "iDDe_DeviousBoxbinder"
		kDDeKwdsAll[44] = iDDe_DeviousBoxbinder
		sDDeKwdsAll[45] = "zad_DeviousAnkleShackles"
		kDDeKwdsAll[45] = ZadLib.zad_DeviousAnkleShackles
;StorageUtil
;sssssssssssssssssssssssssssssssssssssssssssssssss	
	INT iLen = kDDsKwds.Length	
		While (iLen > 0)
			iLen -= 1
			akDDeKwds[iLen] = (kDDsKwds[iLen] AS Form)
		EndWhile
	
	iLen = sDDsKwds.Length
		StorageUtil.StringListResize(iDDe.PlayerRef, "iDDesDDsKwdsStr", iLen, "")
		StorageUtil.StringListCopy(iDDe.PlayerRef, "iDDesDDsKwdsStr", sDDsKwds)
	
	iLen = akDDeKwds.Length
		StorageUtil.FormListResize(iDDe.PlayerRef, "iDDesDDsKwdsForm", iLen, None)
		StorageUtil.FormListCopy(iDDe.PlayerRef, "iDDesDDsKwdsForm", akDDeKwds)
EndFunction	 
;kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk

;Register iDDe Device Tags
;ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt
BOOL Function iDDeRegisterTags()
	iDDeUtil.Log("iDDeRegisterTags():-> ", "Registering Tags ... Start!", 3, 1)
		;Falmer
		ZadLib.RegisterGenericDevice(iDDe_FalmerArmbinder_Inv, "Falmer,Armbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerElbowbinder_Inv, "Falmer,Elbowbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerBeltChain_Inv, "Falmer,Belt,Iron,Chain,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerBelt_Inv, "Falmer,Belt,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerBlindfold_Inv, "Falmer,Blindfold,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerBlindfoldBlock_Inv, "Falmer,Blindfold,Blocking,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerBra_Inv, "Falmer,Bra,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerCollarTall_Inv, "Falmer,Collar,Tall,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerCollarPosture_Inv, "Falmer,Collar,Posture,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerCuffsArms_Inv, "Falmer,Cuffs,Arms,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerCuffsCollar_Inv, "Falmer,Collar,Cuffs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerCuffsLegs_Inv, "Falmer,Cuffs,Legs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerHarnessFull_Inv, "Falmer,Harness,Full,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerGagHarnessBall_Inv, "Falmer,Gag,Harness,Ball,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerHarnessBlocking_Inv, "Falmer,Harness,Blocking,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerHarnessCollar_Inv, "Falmer,Collar,Harness,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerHarnessBody_Inv, "Falmer,Harness,Locking,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerGagHarnessPanel_Inv, "Falmer,Gag,Harness,Panel,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerGagHarnessRing_Inv, "Falmer,Gag,Harness,Ring,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerPonyBoots_Inv, "Falmer,Boots,Pony,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerPlugSoulGemAn_Inv, "Falmer,Plug,Anal,Soulgem,Magic,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerPlugSoulGemVg_Inv, "Falmer,Plug,Vaginal,Soulgem,Magic,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerGagStrapBall_Inv, "Falmer,Gag,Ball,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerGagStrapRing_Inv, "Falmer,Gag,Ring,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerPlugChaosVg_Inv, "Falmer,Plug,Vaginal,Chaos,Magic,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerYoke_Inv, "Falmer,Yoke,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerBondageMittensPaw_Inv, "Falmer,Mittens,Paw,Blocking,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerHobbleDressElegant_Inv, "Falmer,Dress,Blocking,Hobble,Elegant,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerHobbleDress_Inv, "Falmer,Dress,Blocking,Hobble,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerHobbleDressOpen_Inv, "Falmer,Dress,Blocking,Hobble,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerSlaveHighHeels_Inv, "Falmer,Boots,Ballet,Blocking,Slave,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerHobbleDressLatex_Inv, "Falmer,Dress,Blocking,Hobble,Relaxed,Latex,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerHobbleDressOpenLatex_Inv, "Falmer,Dress,Blocking,Hobble,Relaxed,Latex,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FalmerCatSuit_Inv, "Falmer,CatSuit,DDe")
	
	iDDeUtil.Log("iDDeRegisterTags():-> ", "Registering Tags... Please Stand By!", 3, 1)

		;Ebonite Black
		ZadLib.RegisterGenericDevice(iDDe_EbBkBra_Inv, "Ebonite,Bra,Black,DDe")
		ZadLib.RegisterGenericDevice(iDDe_EbBkSlaveHighHeels_Inv, "Ebonite,Black,Boots,Ballet,Blocking,Slave,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_EbBkIronMask_Inv, "Ebonite,Black,Gag,Hood,HR,IronMask,DDe")
		
		;Ebonite White
		ZadLib.RegisterGenericDevice(iDDe_EbWhBra_Inv, "Ebonite,Bra,White,DDe")
		ZadLib.RegisterGenericDevice(iDDe_EbWhSlaveHighHeels_Inv, "Ebonite,White,Boots,Ballet,Blocking,Slave,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_EbWhIronMask_Inv, "Ebonite,White,Gag,Hood,HR,IronMask,DDe")
		
		;Ebonite Red
		ZadLib.RegisterGenericDevice(iDDe_EbRdBra_Inv, "Ebonite,Bra,Red,DDe")
		ZadLib.RegisterGenericDevice(iDDe_EbRdSlaveHighHeels_Inv, "Ebonite,Red,Boots,Ballet,Blocking,Slave,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_EbRdIronMask_Inv, "Ebonite,Red,Gag,Hood,HR,IronMask,DDe")
		
		;Leather Black
		ZadLib.RegisterGenericDevice(iDDe_LeBkBra_Inv, "Leather,Bra,Black,DDe") 
		ZadLib.RegisterGenericDevice(iDDe_LeBkIronMask_Inv, "Leather,Black,Gag,Hood,HR,IronMask,DDe")
		
		;Leather White
		ZadLib.RegisterGenericDevice(iDDe_LeWhBra_Inv, "Leather,Bra,White,DDe") 
		ZadLib.RegisterGenericDevice(iDDe_LeWhIronMask_Inv, "Leather,White,Bra,White,DDe")
		
		;Leather Red
		ZadLib.RegisterGenericDevice(iDDe_LeRdBra_Inv, "Leather,Bra,Red,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeRdIronMask_Inv, "Leather,Red,Gag,Hood,HR,IronMask,DDe")
		
		;Leather Brown
		ZadLib.RegisterGenericDevice(iDDe_LeBrArmbinder_Inv, "Leather,Brown,Armbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrElbowbinder_Inv, "Leather,Brown,Elbowbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrBelt_Inv, "Leather,Brown,Belt,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrGagBit_Inv, "Leather,Brown,Gag,Bit,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrBlindfold_Inv, "Leather,Brown,Blindfold,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrBra_Inv, "Leather,Brown,Bra,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrCollarPosture_Inv, "Leather,Brown,Collar,Posture,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrCuffsArms_Inv, "Leather,Brown,Cuffs,Arms,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrCuffsCollar_Inv, "Leather,Brown,Collar,Cuffs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrCuffsLegs_Inv, "Leather,Brown,Cuffs,Legs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrGagHarnessBall_Inv, "Leather,Brown,Harness,Ball,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrHarnessCollar_Inv, "Leather,Brown,Collar,Harness,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrHarnessBody_Inv, "Leather,Brown,Harness,Locking,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrGagHarnessRing_Inv, "Leather,Brown,Harness,Ring,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrPonyBoots_Inv, "Leather,Brown,Boots,Pony,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrGagStrapBall_Inv, "Leather,Brown,Gag,Ball,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrGagStrapRing_Inv, "Leather,Brown,Gag,Ring,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrBondageMittensPaw_Inv, "Leather,Brown,Mittens,Paw,Blocking,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrHobbleDressElegant_Inv, "Leather,Brown,Dress,Blocking,Hobble,Elegant,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrHobbleDress_Inv, "Leather,Brown,Dress,Blocking,Hobble,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrHobbleDressOpen_Inv, "Leather,Brown,Dress,Blocking,Hobble,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrSlaveHighHeels_Inv, "Leather,Brown,Boots,Ballet,Blocking,Slave,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrHobbleDressLatex_Inv, "Leather,Brown,Dress,Blocking,Hobble,Relaxed,Latex,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrHobbleDressOpenLatex_Inv, "Leather,Brown,Dress,Blocking,Hobble,Relaxed,Latex,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrIronMask_Inv, "Leather,Brown,Gag,Hood,HR,IronMask,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LeBrCatSuit_Inv, "LeBr,CatSuit,DDe")
		
		;Wood
		ZadLib.RegisterGenericDevice(iDDe_WoodArmbinder_Inv, "Wood,Armbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_WoodElbowbinder_Inv, "Wood,Elbowbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_WoodBra_Inv, "Wood,Bra,DDe") 
		ZadLib.RegisterGenericDevice(iDDe_WoodBelt_Inv, "Wood,Belt,DDe")
		ZadLib.RegisterGenericDevice(iDDe_WoodCollarTall_Inv, "Wood,Collar,DDe") 
		ZadLib.RegisterGenericDevice(iDDe_WoodCollarPosture_Inv, "Wood,Collar,Posture,DDe") 
		ZadLib.RegisterGenericDevice(iDDe_WoodCuffsArms_Inv, "Wood,Cuffs,Arms,DDe")
		ZadLib.RegisterGenericDevice(iDDe_WoodCuffsLegs_Inv, "Wood,Cuffs,Legs,DDe") 
		ZadLib.RegisterGenericDevice(iDDe_WoodGagHarnessBall_Inv, "Wood,Harness,Gag,DDe")
		ZadLib.RegisterGenericDevice(iDDe_WoodHarnessBody_Inv, "Wood,Harness,Locking,DDe")
		ZadLib.RegisterGenericDevice(iDDe_WoodGagStrapBall_Inv, "Wood,Gag,Ball,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_WoodCuffsCollar_Inv, "Wood,Collar,Cuffs,DDe") 
		ZadLib.RegisterGenericDevice(iDDe_WoodPonyBoots_Inv, "Wood,Boots,Pony,DDe")
		ZadLib.RegisterGenericDevice(iDDe_WoodBondageMittensPaw_Inv, "Wood,Mittens,Paw,Blocking,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_WoodHobbleDressElegant_Inv, "Wood,Dress,Blocking,Hobble,Elegant,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_WoodHobbleDress_Inv, "Wood,Dress,Blocking,Hobble,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_WoodHobbleDressOpen_Inv, "Wood,Dress,Blocking,Hobble,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_WoodSlaveHighHeels_Inv, "Wood,Boots,Ballet,Blocking,Slave,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_WoodHobbleDressLatex_Inv, "Wood,Dress,Blocking,Hobble,Relaxed,Latex,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_WoodHobbleDressOpenLatex_Inv, "Wood,Dress,Blocking,Hobble,Relaxed,Latex,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_WoodIronMask_Inv, "Wood,Gag,Hood,HR,IronMask,DDe")
		ZadLib.RegisterGenericDevice(iDDe_WoodCatSuit_Inv, "Wood,CatSuit,DDe")
		ZadLib.RegisterGenericDevice(iDDe_WoodBlindfold_Inv, "Wood,Blindfold,DDe")
		
		;Lite Wood
		ZadLib.RegisterGenericDevice(iDDe_LteWoodArmbinder_Inv, "Wood,Light,Armbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LteWoodElbowbinder_Inv, "Wood,Light,Elbowbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LteWoodBra_Inv, "Wood,Light,Bra,DDe") 
		ZadLib.RegisterGenericDevice(iDDe_LteWoodBelt_Inv, "Wood,Light,Belt,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LteWoodCollarTall_Inv, "Wood,Light,Collar,DDe") 
		ZadLib.RegisterGenericDevice(iDDe_LteWoodCollarPosture_Inv, "Wood,Light,Collar,Posture,DDe") 
		ZadLib.RegisterGenericDevice(iDDe_LteWoodCuffsArms_Inv, "Wood,Light,Cuffs,Arms,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LteWoodCuffsLegs_Inv, "Wood,Light,Cuffs,Legs,DDe") 
		ZadLib.RegisterGenericDevice(iDDe_LteWoodHarnessBody_Inv, "Wood,Light,Harness,Locking,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LteWoodGagHarnessBall_Inv, "Wood,Light,Gag,Ball,Harness,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LteWoodGagHarnessRing_Inv, "Wood,Light,Gag,Ring,Harness,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LteWoodGagStrapBall_Inv, "Wood,Gag,Light,Ball,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LteWoodCuffsCollar_Inv, "Wood,Light,Collar,Cuffs,DDe") 
		ZadLib.RegisterGenericDevice(iDDe_LteWoodPonyBoots_Inv, "Wood,Light,Boots,Pony,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LteWoodBondageMittensPaw_Inv, "Wood,Light,Mittens,Paw,Blocking,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LteWoodHobbleDressElegant_Inv, "Wood,Light,Dress,Blocking,Hobble,Elegant,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LteWoodHobbleDress_Inv, "Wood,Light,Dress,Blocking,Hobble,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LteWoodHobbleDressOpen_Inv, "Wood,Light,Dress,Blocking,Hobble,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LteWoodSlaveHighHeels_Inv, "Wood,Light,Boots,Ballet,Blocking,Slave,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LteWoodHobbleDressLatex_Inv, "Wood,Light,Dress,Blocking,Hobble,Relaxed,Latex,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LteWoodHobbleDressOpenLatex_Inv, "Wood,Light,Dress,Blocking,Hobble,Relaxed,Latex,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LteWoodIronMask_Inv, "Wood,Light,Gag,Hood,HR,IronMask,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LteWoodCatSuit_Inv, "LteWood,CatSuit,DDe")
		ZadLib.RegisterGenericDevice(iDDe_LteWoodBlindfold_Inv, "LteWood,Blindfold,DDe")
		;Iron
		ZadLib.RegisterGenericDevice(iDDe_IronShacklesArms_Inv, "Iron,Shackles,Arms,DDe")
		ZadLib.RegisterGenericDevice(iDDe_IronShacklesLegs_Inv, "Iron,Shackles,Legs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_IronBra_Inv, "Iron,Bra,DDe")
		ZadLib.RegisterGenericDevice(iDDe_IronBelt_Inv, "Iron,Belt,DDe")
		ZadLib.RegisterGenericDevice(iDDe_IronBeltChain_Inv, "Iron,Belt,Chain,DDe")
		ZadLib.RegisterGenericDevice(iDDe_IronCollarPosture_Inv, "Iron,Collar,Posture,DDe")
		ZadLib.RegisterGenericDevice(iDDe_IronRingShoes_Inv, "Iron,Boots,Shoes,Ring,Metal,DDe")
		ZadLib.RegisterGenericDevice(iDDe_IronMask_Inv, "Iron,Gag,Hood,HR,IronMask,DDe")
		ZadLib.RegisterGenericDevice(iDDe_IronBlindfold_Inv, "Iron,Blindfold,HR,DDe") 
		
		;Gold
		ZadLib.RegisterGenericDevice(iDDe_GoldArmbinder_Inv, "Gold,Armbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldElbowbinder_Inv, "Gold,Elbowbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldBeltChain_Inv, "Gold,Belt,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldBelt_Inv, "Gold,Belt,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldGagBit_Inv, "Gold,Gag,Bit,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldBlindfold_Inv, "Gold,Blindfold,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldBra_Inv, "Gold,Bra,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldCollar_Inv, "Gold,Collar,ZaZ,Simple,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldCollarPosture_Inv, "Gold,Collar,Posture,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldCuffsArms_Inv, "Gold,Cuffs,Arms,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldCuffsCollar_Inv, "Gold,Collar,Cuffs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldCuffsLegs_Inv, "Gold,Cuffs,Legs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldGagHarnessBall_Inv, "Gold,Harness,Ball,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldHarnessCollar_Inv, "Gold,Collar,Harness,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldHarnessBody_Inv, "Gold,Harness,Locking,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldPonyBoots_Inv, "Gold,Boots,Pony,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldRingShoes_Inv, "Gold,Boots,Shoes,Ring,Metal,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldShacklesArms_Inv, "Gold,Shackles,Arms,ZaZ,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldShacklesLegs_Inv, "Gold,Shackles,Legs,ZaZ,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldPlugSoulGemAn_Inv, "Gold,Plug,Anal,Soulgem,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldPlugSoulGemVg_Inv, "Gold,Plug,Vaginal,Soulgem,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldGagStrapBall_Inv, "Gold,Gag,Ball,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldGagStrapRing_Inv, "Gold,Gag,Ring,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldYoke_Inv, "Gold,Yoke,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldYokeZbf_Inv, "Gold,Yoke,ZaZ,Zbf,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldBondageMittensPaw_Inv, "Gold,Mittens,Paw,Blocking,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldHobbleDressElegant_Inv, "Gold,Dress,Blocking,Hobble,Elegant,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldHobbleDress_Inv, "Gold,Dress,Blocking,Hobble,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldHobbleDressOpen_Inv, "Gold,Dress,Blocking,Hobble,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldSlaveHighHeels_Inv, "Gold,Boots,Ballet,Blocking,Slave,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldHobbleDressLatex_Inv, "Gold,Dress,Blocking,Hobble,Relaxed,Latex,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldHobbleDressOpenLatex_Inv, "Gold,Dress,Blocking,Hobble,Relaxed,Latex,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldIronMask_Inv, "Gold,Gag,Hood,HR,IronMask,DDe")
		ZadLib.RegisterGenericDevice(iDDe_GoldCatSuit_Inv, "Gold,CatSuit,DDe")
		
		;Inox
		ZadLib.RegisterGenericDevice(iDDe_InoxArmbinder_Inv, "Inox,Armbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxElbowbinder_Inv, "Inox,Elbowbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxBeltChain_Inv, "Inox,Belt,Chain,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxBelt_Inv, "Inox,Belt,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxGagBit_Inv, "Inox,Gag,Bit,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxBlindfold_Inv, "Inox,Blindfold,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxBra_Inv, "Inox,Bra,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxCollar_Inv, "Inox,Collar,ZaZ,Simple,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxCollarPosture_Inv, "Inox,Collar,Posture,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxCuffsArms_Inv, "Inox,Cuffs,Arms,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxCuffsCollar_Inv, "Inox,Collar,Cuffs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxCuffsLegs_Inv, "Inox,Cuffs,Legs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxGagHarnessBall_Inv, "Inox,Harness,Ball,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxHarnessCollar_Inv, "Inox,Collar,Harness,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxHarnessBody_Inv, "Inox,Harness,Locking,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxGagHarnessRing_Inv, "Inox,Harness,Ring,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxPonyBoots_Inv, "Inox,Boots,Pony,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxRingShoes_Inv, "Inox,Boots,Shoes,Ring,Metal,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxShacklesArms_Inv, "Inox,Shackles,Arms,ZaZ,Simple,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxShacklesLegs_Inv, "Inox,Shackles,Legs,ZaZ,Simple,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxPlugSoulGemAn_Inv, "Inox,Plug,Anal,Soulgem,Magic,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxPlugSoulGemVg_Inv, "Inox,Plug,Vaginal,Soulgem,Magic,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxGagStrapBall_Inv, "Inox,Gag,Ball,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxGagStrapRing_Inv, "Inox,Gag,Ring,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxYoke_Inv, "Inox,Yoke,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxYokeZbf_Inv, "Inox,Yoke,ZaZ,Zbf,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxBondageMittensPaw_Inv, "Inox,Mittens,Paw,Blocking,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxHobbleDressElegant_Inv, "Inox,Dress,Blocking,Hobble,Elegant,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxHobbleDress_Inv, "Inox,Dress,Blocking,Hobble,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxHobbleDressOpen_Inv, "Inox,Dress,Blocking,Hobble,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxSlaveHighHeels_Inv, "Inox,Boots,Ballet,Blocking,Slave,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxHobbleDressLatex_Inv, "Inox,Dress,Blocking,Hobble,Relaxed,Latex,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxHobbleDressOpenLatex_Inv, "Inox,Dress,Blocking,Hobble,Relaxed,Latex,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxIronMask_Inv, "Inox,Gag,Hood,HR,IronMask,DDe")
		ZadLib.RegisterGenericDevice(iDDe_InoxCatSuit_Inv, "Inox,CatSuit,DDe")
		
		;Rope
		ZadLib.RegisterGenericDevice(iDDe_RopeArmbinder_Inv, "Rope,Armbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RopeElbowbinder_Inv, "Rope,Elbowbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RopeBra_Inv, "Rope,Bra,DDe") 
		ZadLib.RegisterGenericDevice(iDDe_RopeBelt_Inv, "Rope,Belt,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RopeCollarTall_Inv, "Rope,Collar,DDe") 
		ZadLib.RegisterGenericDevice(iDDe_RopeCollarPosture_Inv, "Rope,Collar,Posture,DDe") 
		ZadLib.RegisterGenericDevice(iDDe_RopeCuffsArms_Inv, "Rope,Cuffs,Arms,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RopeCuffsLegs_Inv, "Rope,Cuffs,Legs,DDe") 
		ZadLib.RegisterGenericDevice(iDDe_RopeHarnessBody_Inv, "Rope,Harness,Locking,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RopeGagHarnessBall_Inv, "Rope,Gag,Ball,Harness,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RopeGagHarnessRing_Inv, "Rope,Gag,Ring,Harness,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RopeGagStrapBall_Inv, "Rope,Gag,Ball,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RopeCuffsCollar_Inv, "Rope,Collar,Cuffs,DDe") 
		ZadLib.RegisterGenericDevice(iDDe_RopePonyBoots_Inv, "Rope,Boots,Pony,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RopeBondageMittensPaw_Inv, "Rope,Mittens,Paw,Blocking,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RopeHobbleDressElegant_Inv, "Rope,Dress,Blocking,Hobble,Elegant,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RopeHobbleDress_Inv, "Rope,Dress,Blocking,Hobble,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RopeHobbleDressOpen_Inv, "Rope,Dress,Blocking,Hobble,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RopeSlaveHighHeels_Inv, "Rope,Boots,Ballet,Blocking,Slave,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RopeHobbleDressLatex_Inv, "Rope,Dress,Blocking,Hobble,Relaxed,Latex,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RopeHobbleDressOpenLatex_Inv, "Rope,Dress,Blocking,Hobble,Relaxed,Latex,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RopeIronMask_Inv, "Rope,Gag,Hood,HR,IronMask,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RopeCatSuit_Inv, "Rope,CatSuit,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RopeBlindfold_Inv, "Rope,Blindfold,DDe")
		
		;Rusty
		ZadLib.RegisterGenericDevice(iDDe_RustyArmbinder_Inv, "Rusty,Armbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyElbowbinder_Inv, "Rusty,Elbowbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyBeltChain_Inv, "Rusty,Belt,Chain,Iron,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyBelt_Inv, "Rusty,Belt,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyBlindfold_Inv, "Rusty,Blindfold,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyBra_Inv, "Rusty,Bra,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyCollarPosture_Inv, "Rusty,Collar,Posture,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyCuffsArms_Inv, "Rusty,Cuffs,Arms,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyCuffsCollar_Inv, "Rusty,Cuffs,Collar,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyCuffsLegs_Inv, "Rusty,Cuffs,Legs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyGagHarnessBall_Inv, "Rusty,Gag,Harness,Ball,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyHarnessCollar_Inv, "Rusty,Harness,Collar,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyHarnessBody_Inv, "Rusty,Harness,Locking,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyGagHarnessRing_Inv, "Rusty,Gag,Harness,Ring,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyPonyBoots_Inv, "Rusty,Pony,Boots,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyGagStrapBall_Inv, "Rusty,Gag,Strap,Ball,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyGagStrapRing_Inv, "Rusty,Gag,Strap,Ring,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyYoke_Inv, "Rusty,Yoke,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyYokeZbf_Inv, "Rusty,Yoke,ZaZ,Zbf,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyBondageMittensPaw_Inv, "Rusty,Mittens,Paw,Blocking,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyHobbleDressElegant_Inv, "Rusty,Dress,Blocking,Hobble,Elegant,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyHobbleDress_Inv, "Rusty,Dress,Blocking,Hobble,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyHobbleDressOpen_Inv, "Rusty,Dress,Blocking,Hobble,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustySlaveHighHeels_Inv, "Rusty,Boots,Ballet,Blocking,Slave,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyHobbleDressLatex_Inv, "Rusty,Dress,Blocking,Hobble,Relaxed,Latex,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyHobbleDressOpenLatex_Inv, "Rusty,Dress,Blocking,Hobble,Relaxed,Latex,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyIronMask_Inv, "Rusty,Gag,Hood,HR,IronMask,DDe")
		ZadLib.RegisterGenericDevice(iDDe_RustyCatSuit_Inv, "Rusty,CatSuit,DDe")
		
		;Chromogen Hex
		ZadLib.RegisterGenericDevice(iDDe_HexChArmbinder_Inv, "Hex,Chromo,Armbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChElbowbinder_Inv, "Hex,Chromo,Elbowbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChBeltChain_Inv, "Hex,Chromo,Belt,Chain,Iron,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChBelt_Inv, "Hex,Chromo,Belt,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChBlindfold_Inv, "Hex,Chromo,Blindfold,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChBra_Inv, "Hex,Chromo,Bra,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChCollarTall_Inv, "Hex,Chromo,Collar,Tall,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChCollarPosture_Inv, "Hex,Chromo,Collar,Posture,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChCuffsArms_Inv, "Hex,Chromo,Cuffs,Arms,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChCuffsCollar_Inv, "Hex,Chromo,Cuffs,Collar,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChCuffsLegs_Inv, "Hex,Chromo,Cuffs,Legs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChGagHarnessBall_Inv, "Hex,Chromo,Gag,Harness,Ball,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChHarnessCollar_Inv, "Hex,Chromo,Harness,Collar,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChHarnessBody_Inv, "Hex,Chromo,Harness,Locking,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChGagHarnessRing_Inv, "Hex,Chromo,Gag,Harness,Ring,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChPonyBoots_Inv, "Hex,Chromo,Pony,Boots,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChGagStrapBall_Inv, "Hex,Chromo,Gag,Strap,Ball,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChGagStrapRing_Inv, "Hex,Chromo,Gag,Strap,Ring,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChYoke_Inv, "Hex,Chromo,Yoke,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChBondageMittensPaw_Inv, "Hex,Chromo,Mittens,Paw,Blocking,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChHobbleDressElegant_Inv, "Hex,Chromo,Dress,Blocking,Hobble,Elegant,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChHobbleDress_Inv, "Hex,Chromo,Dress,Blocking,Hobble,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChHobbleDressOpen_Inv, "Hex,Chromo,Dress,Blocking,Hobble,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChSlaveHighHeels_Inv, "Hex,Chromo,Boots,Ballet,Blocking,Slave,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChHobbleDressLatex_Inv, "Hex,Chromo,Gag,Hood,HR,IronMask,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexChCatSuit_Inv, "HexCh,CatSuit,DDe")
		
		;Red Hex
		ZadLib.RegisterGenericDevice(iDDe_HexRdArmbinder_Inv, "Hex,Red,Armbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdElbowbinder_Inv, "Hex,Red,Elbowbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdBeltChain_Inv, "Hex,Red,Belt,Chain,Iron,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdBelt_Inv, "Hex,Red,Belt,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdBlindfold_Inv, "Hex,Red,Blindfold,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdBra_Inv, "Hex,Red,Bra,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdCollarPosture_Inv, "Hex,Red,Collar,Posture,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdCuffsArms_Inv, "Hex,Red,Cuffs,Arms,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdCuffsCollar_Inv, "Hex,Red,Cuffs,Collar,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdCuffsLegs_Inv, "Hex,Red,Cuffs,Legs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdGagHarnessBall_Inv, "Hex,Red,Gag,Harness,Ball,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdHarnessCollar_Inv, "Hex,Red,Harness,Collar,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdHarnessBody_Inv, "Hex,Red,Harness,Locking,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdGagHarnessRing_Inv, "Hex,Red,Gag,Harness,Ring,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdPonyBoots_Inv, "Hex,Red,Pony,Boots,DDe") 
		ZadLib.RegisterGenericDevice(iDDe_HexRdGagStrapBall_Inv, "Hex,Red,Gag,Strap,Ball,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdGagStrapRing_Inv, "Hex,Red,Gag,Strap,Ring,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdYoke_Inv, "Hex,Red,Yoke,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdYokeZbf_Inv, "Hex,Red,Yoke,ZaZ,Zbf,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdBondageMittensPaw_Inv, "Hex,Red,Mittens,Paw,Blocking,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdHobbleDressElegant_Inv, "Hex,Red,Dress,Blocking,Hobble,Elegant,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdHobbleDress_Inv, "Hex,Red,Dress,Blocking,Hobble,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdHobbleDressOpen_Inv, "Hex,Red,Dress,Blocking,Hobble,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdSlaveHighHeels_Inv, "Hex,Red,Boots,Ballet,Blocking,Slave,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdHobbleDressLatex_Inv, "Hex,Red,Dress,Blocking,Hobble,Relaxed,Latex,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdHobbleDressOpenLatex_Inv, "Hex,Red,Dress,Blocking,Hobble,Relaxed,Latex,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdIronMask_Inv, "Hex,Red,Gag,Hood,HR,IronMask,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexRdCatSuit_Inv, "HexRd,CatSuit,DDe")
		
		;Orange Hex
		ZadLib.RegisterGenericDevice(iDDe_HexOrArmbinder_Inv, "Hex,Orange,Armbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrElbowbinder_Inv, "Hex,Orange,Elbowbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrBeltChain_Inv, "Hex,Orange,Belt,Chain,Iron,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrBelt_Inv, "Hex,Orange,Belt,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrBlindfold_Inv, "Hex,Orange,Blindfold,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrBra_Inv, "Hex,Orange,Bra,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrCollarPosture_Inv, "Hex,Orange,Collar,Posture,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrCuffsArms_Inv, "Hex,Orange,Cuffs,Arms,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrCuffsCollar_Inv, "Hex,Orange,Cuffs,Collar,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrCuffsLegs_Inv, "Hex,Orange,Cuffs,Legs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrGagHarnessBall_Inv, "Hex,Orange,Gag,Harness,Ball,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrHarnessCollar_Inv, "Hex,Orange,Harness,Collar,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrHarnessBody_Inv, "Hex,Orange,Harness,Locking,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrGagHarnessRing_Inv, "Hex,Orange,Gag,Harness,Ring,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrPonyBoots_Inv, "Hex,Orange,Pony,Boots,DDe") 
		ZadLib.RegisterGenericDevice(iDDe_HexOrGagStrapBall_Inv, "Hex,Orange,Gag,Strap,Ball,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrGagStrapRing_Inv, "Hex,Orange,Gag,Strap,Ring,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrYoke_Inv, "Hex,Orange,Yoke,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrYokeZbf_Inv, "Hex,Red,Yoke,ZaZ,Zbf,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrBondageMittensPaw_Inv, "Hex,Orange,Mittens,Paw,Blocking,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrHobbleDressElegant_Inv, "Hex,Orange,Dress,Blocking,Hobble,Elegant,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrHobbleDress_Inv, "Hex,Orange,Dress,Blocking,Hobble,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrHobbleDressOpen_Inv, "Hex,Orange,Dress,Blocking,Hobble,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrSlaveHighHeels_Inv, "Hex,Orange,Boots,Ballet,Blocking,Slave,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrHobbleDressLatex_Inv, "Hex,Orange,Dress,Blocking,Hobble,Relaxed,Latex,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrHobbleDressOpenLatex_Inv, "Hex,Orange,Dress,Blocking,Hobble,Relaxed,Latex,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrIronMask_Inv, "Hex,Orange,Gag,Hood,HR,IronMask,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexOrCatSuit_Inv, "HexOr,CatSuit,DDe")
		
		;Black Hex
		ZadLib.RegisterGenericDevice(iDDe_HexBkArmbinder_Inv, "Hex,Black,Armbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HexBkElbowbinder_Inv, "Hex,Black,Elbowbinder,DDe")
		
	iDDeUtil.Log("iDDeRegisterTags():-> ", "Registering Tags, Still... Please Stand By!", 3, 1)
	
		;Hypnotic
		ZadLib.RegisterGenericDevice(iDDe_HypArmbinder_Inv, "Hypnotic,Armbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypElbowbinder_Inv, "Hypnotic,Elbowbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypBeltChain_Inv, "Hypnotic,Belt,Chain,Iron,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypBelt_Inv, "Hypnotic,Belt,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypBlindfold_Inv, "Hypnotic,Blindfold,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypBra_Inv, "Hypnotic,Bra,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypCollarPosture_Inv, "Hypnotic,Collar,Posture,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypCuffsArms_Inv, "Hypnotic,Cuffs,Arms,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypCuffsCollar_Inv, "Hypnotic,Cuffs,Collar,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypCuffsLegs_Inv, "Hypnotic,Cuffs,Legs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypGagHarnessBall_Inv, "Hypnotic,Gag,Harness,Ball,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypHarnessCollar_Inv, "Hypnotic,Harness,Collar,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypHarnessBody_Inv, "Hypnotic,Harness,Locking,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypGagHarnessRing_Inv, "Hypnotic,Gag,Harness,Ring,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypPonyBoots_Inv, "Hypnotic,Pony,Boots,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypGagStrapBall_Inv, "Hypnotic,Gag,Strap,Ball,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypGagStrapRing_Inv, "Hypnotic,Gag,Strap,Ring,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypYoke_Inv, "Hypnotic,Yoke,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypYokeZbf_Inv, "Hypnotic,Yoke,ZaZ,Zbf,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypBondageMittensPaw_Inv, "Hypnotic,Mittens,Paw,Blocking,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypHobbleDressElegant_Inv, "Hypnotic,Dress,Blocking,Hobble,Elegant,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypHobbleDress_Inv, "Hypnotic,Dress,Blocking,Hobble,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypHobbleDressOpen_Inv, "Hypnotic,Dress,Blocking,Hobble,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypSlaveHighHeels_Inv, "Hypnotic,Boots,Ballet,Blocking,Slave,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypHobbleDressLatex_Inv, "Hypnotic,Dress,Blocking,Hobble,Relaxed,Latex,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypHobbleDressOpenLatex_Inv, "Hypnotic,Dress,Blocking,Hobble,Relaxed,Latex,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypIronMask_Inv, "Hypnotic,Gag,Hood,HR,IronMask,DDe")
		ZadLib.RegisterGenericDevice(iDDe_HypCatSuit_Inv, "Hyp,CatSuit,DDe")
		
		;Jade
		ZadLib.RegisterGenericDevice(iDDe_JadeArmbinder_Inv, "Jade,Armbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeElbowbinder_Inv, "Jade,Elbowbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeBeltChain_Inv, "Jade,Belt,Chain,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeBelt_Inv, "Jade,Belt,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeGagBit_Inv, "Jade,Gag,Bit,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeBlindfold_Inv, "Jade,Blindfold,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeBra_Inv, "Jade,Bra,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeCollar_Inv, "Jade,Collar,ZaZ,Simple,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeCollarPosture_Inv, "Jade,Collar,Posture,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeCuffsArms_Inv, "Jade,Cuffs,Arms,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeCuffsCollar_Inv, "Jade,Collar,Cuffs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeCuffsLegs_Inv, "Jade,Cuffs,Legs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeGagHarnessBall_Inv, "Jade,Harness,Ball,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeHarnessCollar_Inv, "Jade,Collar,Harness,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeHarnessBody_Inv, "Jade,Harness,Locking,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeGagHarnessRing_Inv, "Jade,Harness,Ring,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadePonyBoots_Inv, "Jade,Boots,Pony,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeRingShoes_Inv, "Jade,Boots,Shoes,Ring,Metal,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeShacklesArms_Inv, "Jade,Shackles,Arms,ZaZ,Simple,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeShacklesLegs_Inv, "Jade,Shackles,Legs,ZaZ,Simple,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadePlugSoulGemAn_Inv, "Jade,Plug,Anal,Soulgem,Magic,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadePlugSoulGemVg_Inv, "Jade,Plug,Vaginal,Soulgem,Magic,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeGagStrapBall_Inv, "Jade,Gag,Ball,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeGagStrapRing_Inv, "Jade,Gag,Ring,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeYoke_Inv, "Jade,Yoke,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeYokeZbf_Inv, "Jade,Yoke,ZaZ,Zbf,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeBondageMittensPaw_Inv, "Jade,Mittens,Paw,Blocking,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeHobbleDressElegant_Inv, "Jade,Dress,Blocking,Hobble,Elegant,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeHobbleDress_Inv, "Jade,Dress,Blocking,Hobble,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeHobbleDressOpen_Inv, "Jade,Dress,Blocking,Hobble,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeSlaveHighHeels_Inv, "Jade,Boots,Ballet,Blocking,Slave,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeHobbleDressLatex_Inv, "Jade,Dress,Blocking,Hobble,Relaxed,Latex,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeHobbleDressOpenLatex_Inv, "Jade,Dress,Blocking,Hobble,Relaxed,Latex,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeIronMask_Inv, "Jade,Gag,Hood,HR,IronMask,DDe")
		ZadLib.RegisterGenericDevice(iDDe_JadeCatSuit_Inv, "Jade,CatSuit,DDe")
		
		;Fifa
		ZadLib.RegisterGenericDevice(iDDe_FifaArmbinder_Inv, "Fifa,Armbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaElbowbinder_Inv, "Fifa,Elbowbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaBeltChain_Inv, "Fifa,Belt,Chain,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaBelt_Inv, "Fifa,Belt,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaGagBit_Inv, "Fifa,Gag,Bit,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaBlindfold_Inv, "Fifa,Blindfold,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaBra_Inv, "Fifa,Bra,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaCollar_Inv, "Fifa,Collar,ZaZ,Simple,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaCollarPosture_Inv, "Fifa,Collar,Posture,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaCuffsArms_Inv, "Fifa,Cuffs,Arms,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaCuffsCollar_Inv, "Fifa,Collar,Cuffs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaCuffsLegs_Inv, "Fifa,Cuffs,Legs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaGagHarnessBall_Inv, "Fifa,Harness,Ball,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaHarnessCollar_Inv, "Fifa,Collar,Harness,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaHarnessBody_Inv, "Fifa,Harness,Locking,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaGagHarnessRing_Inv, "Fifa,Harness,Ring,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaPonyBoots_Inv, "Fifa,Boots,Pony,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaRingShoes_Inv, "Fifa,Boots,Shoes,Ring,Metal,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaShacklesArms_Inv, "Fifa,Shackles,Arms,ZaZ,Simple,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaShacklesLegs_Inv, "Fifa,Shackles,Legs,ZaZ,Simple,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaPlugSoulGemAn_Inv, "Fifa,Plug,Anal,Soulgem,Magic,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaPlugSoulGemVg_Inv, "Fifa,Plug,Vaginal,Soulgem,Magic,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaGagStrapBall_Inv, "Fifa,Gag,Ball,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaGagStrapRing_Inv, "Fifa,Gag,Ring,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaYoke_Inv, "Fifa,Yoke,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaYokeZbf_Inv, "Fifa,Yoke,ZaZ,Zbf,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaBondageMittensPaw_Inv, "Fifa,Mittens,Paw,Blocking,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaHobbleDressElegant_Inv, "Fifa,Dress,Blocking,Hobble,Elegant,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaHobbleDress_Inv, "Fifa,Dress,Blocking,Hobble,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaHobbleDressOpen_Inv, "Fifa,Dress,Blocking,Hobble,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaSlaveHighHeels_Inv, "Fifa,Boots,Ballet,Blocking,Slave,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaHobbleDressLatex_Inv, "Fifa,Dress,Blocking,Hobble,Relaxed,Latex,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaHobbleDressOpenLatex_Inv, "Fifa,Dress,Blocking,Hobble,Relaxed,Latex,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaIronMask_Inv, "Fifa,Gag,Hood,HR,IronMask,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FifaCatSuit_Inv, "Fifa,CatSuit,DDe")
		
		;Fire
		ZadLib.RegisterGenericDevice(iDDe_FireArmbinder_Inv, "Fire,Armbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireElbowbinder_Inv, "Fire,Elbowbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireBeltChain_Inv, "Fire,Belt,Chain,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireBelt_Inv, "Fire,Belt,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireGagBit_Inv, "Fire,Gag,Bit,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireBlindfold_Inv, "Fire,Blindfold,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireBra_Inv, "Fire,Bra,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireCollar_Inv, "Fire,Collar,ZaZ,Simple,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireCollarPosture_Inv, "Fire,Collar,Posture,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireCuffsArms_Inv, "Fire,Cuffs,Arms,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireCuffsCollar_Inv, "Fire,Collar,Cuffs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireCuffsLegs_Inv, "Fire,Cuffs,Legs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireGagHarnessBall_Inv, "Fire,Harness,Ball,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireHarnessCollar_Inv, "Fire,Collar,Harness,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireHarnessBody_Inv, "Fire,Harness,Locking,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireGagHarnessRing_Inv, "Fire,Harness,Ring,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FirePonyBoots_Inv, "Fire,Boots,Pony,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireRingShoes_Inv, "Fire,Boots,Shoes,Ring,Metal,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireShacklesArms_Inv, "Fire,Shackles,Arms,ZaZ,Simple,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireShacklesLegs_Inv, "Fire,Shackles,Legs,ZaZ,Simple,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FirePlugSoulGemAn_Inv, "Fire,Plug,Anal,Soulgem,Magic,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FirePlugSoulGemVg_Inv, "Fire,Plug,Vaginal,Soulgem,Magic,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireGagStrapBall_Inv, "Fire,Gag,Ball,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireGagStrapRing_Inv, "Fire,Gag,Ring,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireYoke_Inv, "Fire,Yoke,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireYokeZbf_Inv, "Fire,Yoke,ZaZ,Zbf,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireBondageMittensPaw_Inv, "Fire,Mittens,Paw,Blocking,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireHobbleDressElegant_Inv, "Fire,Dress,Blocking,Hobble,Elegant,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireHobbleDress_Inv, "Fire,Dress,Blocking,Hobble,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireHobbleDressOpen_Inv, "Fire,Dress,Blocking,Hobble,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireSlaveHighHeels_Inv, "Fire,Boots,Ballet,Blocking,Slave,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireHobbleDressLatex_Inv, "Fire,Dress,Blocking,Hobble,Relaxed,Latex,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireHobbleDressOpenLatex_Inv, "Fire,Dress,Blocking,Hobble,Relaxed,Latex,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireIronMask_Inv, "Fire,Gag,Hood,HR,IronMask,DDe")
		ZadLib.RegisterGenericDevice(iDDe_FireCatSuit_Inv, "Fire,CatSuit,DDe")
		
		;Crimson
		ZadLib.RegisterGenericDevice(iDDe_CrimsonArmbinder_Inv, "Crimson,Red,Armbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonElbowbinder_Inv, "Crimson,Red,Elbowbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonBeltChain_Inv, "Crimson,Red,Belt,Chain,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonBelt_Inv, "Crimson,Red,Belt,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonGagBit_Inv, "Crimson,Red,Gag,Bit,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonBlindfold_Inv, "Crimson,Red,Blindfold,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonBra_Inv, "Crimson,Red,Bra,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonCollar_Inv, "Crimson,Red,Collar,ZaZ,Simple,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonCollarPosture_Inv, "Crimson,Red,Collar,Posture,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonCuffsArms_Inv, "Crimson,Red,Cuffs,Arms,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonCuffsCollar_Inv, "Crimson,Red,Collar,Cuffs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonCuffsLegs_Inv, "Crimson,Red,Cuffs,Legs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonGagHarnessBall_Inv, "Crimson,Red,Harness,Ball,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonHarnessCollar_Inv, "Crimson,Red,Collar,Harness,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonHarnessBody_Inv, "Crimson,Red,Harness,Locking,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonGagHarnessRing_Inv, "Crimson,Red,Harness,Ring,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonPonyBoots_Inv, "Crimson,Red,Boots,Pony,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonRingShoes_Inv, "Crimson,Red,Boots,Shoes,Ring,Metal,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonShacklesArms_Inv, "Crimson,Red,Shackles,Arms,ZaZ,Simple,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonShacklesLegs_Inv, "Crimson,Red,Shackles,Legs,ZaZ,Simple,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonPlugSoulGemAn_Inv, "Crimson,Red,Plug,Anal,Soulgem,Magic,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonPlugSoulGemVg_Inv, "Crimson,Red,Plug,Vaginal,Soulgem,Magic,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonGagStrapBall_Inv, "Crimson,Red,Gag,Ball,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonGagStrapRing_Inv, "Crimson,Red,Gag,Ring,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonYoke_Inv, "Crimson,Red,Yoke,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonYokeZbf_Inv, "Crimson,Red,Yoke,ZaZ,Zbf,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonBondageMittensPaw_Inv, "Crimson,Red,Mittens,Paw,Blocking,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonHobbleDressElegant_Inv, "Crimson,Red,Dress,Blocking,Hobble,Elegant,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonHobbleDress_Inv, "Crimson,Red,Dress,Blocking,Hobble,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonHobbleDressOpen_Inv, "Crimson,Red,Dress,Blocking,Hobble,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonSlaveHighHeels_Inv, "Crimson,Red,Boots,Ballet,Blocking,Slave,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonHobbleDressLatex_Inv, "Crimson,Red,Dress,Blocking,Hobble,Relaxed,Latex,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonHobbleDressOpenLatex_Inv, "Crimson,Red,Dress,Blocking,Hobble,Relaxed,Latex,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonIronMask_Inv, "Crimson,Red,Gag,Hood,HR,IronMask,DDe")
		ZadLib.RegisterGenericDevice(iDDe_CrimsonCatSuit_Inv, "Crimson,CatSuit,DDe")
		
		;Bumblebee
		ZadLib.RegisterGenericDevice(iDDe_BumbeeArmbinder_Inv, "Bumblebee,Armbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeElbowbinder_Inv, "Bumblebee,Elbowbinder,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeBeltChain_Inv, "Bumblebee,Belt,Chain,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeBelt_Inv, "Bumblebee,Belt,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeGagBit_Inv, "Bumblebee,Gag,Bit,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeBlindfold_Inv, "Bumblebee,Blindfold,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeBra_Inv, "Bumblebee,Bra,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeCollar_Inv, "Bumblebee,Collar,ZaZ,Simple,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeCollarPosture_Inv, "Bumblebee,Collar,Posture,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeCuffsArms_Inv, "Bumblebee,Cuffs,Arms,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeCuffsCollar_Inv, "Bumblebee,Collar,Cuffs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeCuffsLegs_Inv, "Bumblebee,Cuffs,Legs,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeGagHarnessBall_Inv, "Bumblebee,Harness,Ball,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeHarnessCollar_Inv, "Bumblebee,Collar,Harness,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeHarnessBody_Inv, "Bumblebee,Harness,Locking,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeGagHarnessRing_Inv, "Bumblebee,Harness,Ring,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeePonyBoots_Inv, "Bumblebee,Boots,Pony,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeRingShoes_Inv, "Bumblebee,Boots,Shoes,Ring,Metal,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeShacklesArms_Inv, "Bumblebee,Shackles,Arms,ZaZ,Simple,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeShacklesLegs_Inv, "Bumblebee,Shackles,Legs,ZaZ,Simple,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeePlugSoulGemAn_Inv, "Bumblebee,Plug,Anal,Soulgem,Magic,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeePlugSoulGemVg_Inv, "Bumblebee,Plug,Vaginal,Soulgem,Magic,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeGagStrapBall_Inv, "Bumblebee,Gag,Ball,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeGagStrapRing_Inv, "Bumblebee,Gag,Ring,Strap,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeYoke_Inv, "Bumblebee,Yoke,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeYokeZbf_Inv, "Bumblebee,Yoke,ZaZ,Zbf,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeBondageMittensPaw_Inv, "Bumblebee,Mittens,Paw,Blocking,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeHobbleDressElegant_Inv, "Bumblebee,Dress,Blocking,Hobble,Elegant,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeHobbleDress_Inv, "Bumblebee,Dress,Blocking,Hobble,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeHobbleDressOpen_Inv, "Bumblebee,Dress,Blocking,Hobble,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeSlaveHighHeels_Inv, "Bumblebee,Boots,Ballet,Blocking,Slave,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeHobbleDressLatex_Inv, "Bumblebee,Dress,Blocking,Hobble,Relaxed,Latex,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeHobbleDressOpenLatex_Inv, "Bumblebee,Dress,Blocking,Hobble,Relaxed,Latex,Open,Pincopallino,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeIronMask_Inv, "Bumblebee,Gag,Hood,HR,IronMask,DDe")
		ZadLib.RegisterGenericDevice(iDDe_BumbeeCatSuit_Inv, "Bumbee,CatSuit,DDe")
		
		;Trans
		ZadLib.RegisterGenericDevice(iDDe_TransCatSuit_Inv, "Transparent,Trans,CatSuit,DDe")
		
	Utility.Wait(1.1)
	iDDeUtil.Log("iDDeRegisterTags():-> ", "Registering Tags... Done!", 3, 1)
	RETURN True
EndFunction
;ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt

STRING[] Property sDDeOutMiscMCM Auto Hidden	
STRING[] Property sDDeOutMisc Auto Hidden
STRING[] Property sDDeOutRegMCM Auto Hidden
STRING[] Property sDDeOutReg Auto Hidden
STRING[] Property sDDeOutDrMCM Auto Hidden
STRING[] Property sDDeOutDr Auto Hidden
STRING[] Property sCDxOutMCM Auto Hidden
STRING[] Property sCDxOut Auto Hidden
Function iDDeSetMcmOutfits()
	sDDeOutMiscMCM = NEW STRING[7] 
	sDDeOutMisc = NEW STRING[7] ;Hard coded, do not change idx order.
		sDDeOutMiscMCM[0] = "No Outfit"
			 sDDeOutMisc[0] = ""
		sDDeOutMiscMCM[1] = "MCM Library"
			 sDDeOutMisc[1] = "iDDeOutMCM"
	  sDDeOutMiscMCM[2] = "Random DDs"
	   	 sDDeOutMisc[2] = "iDDeOutDDsAny"
  	sDDeOutMiscMCM[3] = "Random Custom"
	   	 sDDeOutMisc[3] = "iDDeOutCuAny"
	  sDDeOutMiscMCM[4] = "Random "
			 sDDeOutMisc[4] = "iDDeOutAny" 
		sDDeOutMiscMCM[5] = "Random Dress"
			 sDDeOutMisc[5] = "iDDeOutDrAny"
		sDDeOutMiscMCM[6] = "Previously Worn"
			 sDDeOutMisc[6] = "iDDeOutWorn"
	;Regular Outfits
	;-----------------------------------------------
	sDDeOutRegMCM = NEW STRING[37] 
	sDDeOutReg = NEW STRING[37]
		sDDeOutRegMCM[0] = "No Outfit"
	     sDDeOutReg[0] = ""
		sDDeOutRegMCM[1] = "Black Ebonite"
	     sDDeOutReg[1] = "iDDeOutBkEb"
	  sDDeOutRegMCM[2] = "White Ebonite"
	     sDDeOutReg[2] = "iDDeOutWhEb"
	  sDDeOutRegMCM[3] = "Red Ebonite"
	     sDDeOutReg[3] = "iDDeOutRdEb"
	  sDDeOutRegMCM[4] = "Black Leather"
	     sDDeOutReg[4] = "iDDeOutBkLe"
	  sDDeOutRegMCM[5] = "White Leather"
	     sDDeOutReg[5] = "iDDeOutWhLe"
	  sDDeOutRegMCM[6] = "Red Leather"
	     sDDeOutReg[6] = "iDDeOutRdLe"
	  sDDeOutRegMCM[7] = "Metal "
	     sDDeOutReg[7] = "iDDeOutMetal"
	  sDDeOutRegMCM[8] = "Falmer "
	     sDDeOutReg[8] = "iDDeOutFalmer"
	  sDDeOutRegMCM[9] = "Wood "
	     sDDeOutReg[9] = "iDDeOutWood"
	  sDDeOutRegMCM[10] = "Iron "
	     sDDeOutReg[10] = "iDDeOutIron"
	  sDDeOutRegMCM[11] = "Gold "
	     sDDeOutReg[11] = "iDDeOutGoldZad"
	  sDDeOutRegMCM[12] = "Gold ZAP"
	     sDDeOutReg[12] = "iDDeOutGoldZbf"
	  sDDeOutRegMCM[13] = "Inox "
	     sDDeOutReg[13] = "iDDeOutInoxZad"
	  sDDeOutRegMCM[14] = "Inox ZAP"
	     sDDeOutReg[14] = "iDDeOutInoxZbf"
	  sDDeOutRegMCM[15] = "Lite Wood"
	     sDDeOutReg[15] = "iDDeOutLteWood"
	  sDDeOutRegMCM[16] = "Rusty "
	     sDDeOutReg[16] = "iDDeOutRusty"
	  sDDeOutRegMCM[17] = "Chromo-Hex "
	     sDDeOutReg[17] = "iDDeOutHexCh"
	  sDDeOutRegMCM[18] = "Red Hex"
	     sDDeOutReg[18] = "iDDeHexRd"
	  sDDeOutRegMCM[19] = "Hypnotic"
	     sDDeOutReg[19] = "iDDeOutHyp"
	  sDDeOutRegMCM[20] = "Jade "
	     sDDeOutReg[20] = "iDDeOutJade"
	  sDDeOutRegMCM[21] = "Jade ZAP"
	     sDDeOutReg[21] = "iDDeOutJadeZbf"
	  sDDeOutRegMCM[22] = "Fifa "
	     sDDeOutReg[22] = "iDDeOutFifa"
	  sDDeOutRegMCM[23] = "Fifa ZAP"
	     sDDeOutReg[23] = "iDDeOutFifaZbf"
	  sDDeOutRegMCM[24] = "Fire "
	     sDDeOutReg[24] = "iDDeOutFire"
	  sDDeOutRegMCM[25] = "Fire ZAP"
	     sDDeOutReg[25] = "iDDeOutFireZbf"
	  sDDeOutRegMCM[26] = "Rope "
	     sDDeOutReg[26] = "iDDeOutRope"
	  sDDeOutRegMCM[27] = "Brown Leather"
	     sDDeOutReg[27] = "iDDeOutBrLea"
	  sDDeOutRegMCM[28] = "Crimson "
	     sDDeOutReg[28] = "iDDeOutCrimson"
	  sDDeOutRegMCM[29] = "Crimson ZAP"
	     sDDeOutReg[29] = "iDDeOutCrimsonZbf"
	  sDDeOutRegMCM[30] = "Orange Hex"
	     sDDeOutReg[30] = "iDDeOutHexOr"
	  sDDeOutRegMCM[31] = "BumbleBee "
	     sDDeOutReg[31] = "iDDeOutBumbee"
	  sDDeOutRegMCM[32] = "BumbleBee ZAP"
	     sDDeOutReg[32] = "iDDeOutBumbeeZbf" 
	  sDDeOutRegMCM[33] = "HR Black "
	     sDDeOutReg[33] = "iDDeOutHrBk"
	  sDDeOutRegMCM[34] = "HR Rusty"
	     sDDeOutReg[34] = "iDDeOutHrRu" 
	  sDDeOutRegMCM[35] = "Inox Mech"
	     sDDeOutReg[35] = "iDDeOutInoxMech" 
	  sDDeOutRegMCM[36] = "Dwemer Mech"
	     sDDeOutReg[36] = "iDDeOutDweMech" 
	;Dress Outfits
	;-----------------------------------------------
	sDDeOutDrMCM = NEW STRING[23] 
	sDDeOutDr = NEW STRING[23]
		sDDeOutDrMCM[0] = "No Dress"
		   sDDeOutDr[0] = ""
		sDDeOutDrMCM[1] = "Orange Hex Dress"
		   sDDeOutDr[1] = "iDDeOutDrHexOr"
		sDDeOutDrMCM[2] = "Gold Dress"
		   sDDeOutDr[2] = "iDDeOutDrGold"
		sDDeOutDrMCM[3] = "Inox Dress"
		   sDDeOutDr[3] = "iDDeOutDrInox"
		sDDeOutDrMCM[4] = "Crimson Dress"
		   sDDeOutDr[4] = "iDDeOutDrCrimson"
		sDDeOutDrMCM[5] = "BumbleBee Dress"
		   sDDeOutDr[5] = "iDDeOutDrBumbee"
		sDDeOutDrMCM[6] = "Red Hex Dress" 
		   sDDeOutDr[6] = "iDDeOutDrHexRd"
		sDDeOutDrMCM[7] = "Jade Dress" 
		   sDDeOutDr[7] = "iDDeOutDrJade"
		sDDeOutDrMCM[8] = "Black Ebonite Dress"
		   sDDeOutDr[8] = "iDDeOutDrEbBk"
		sDDeOutDrMCM[9] = "Red Ebonite Dress"
		   sDDeOutDr[9] = "iDDeOutDrEbRd"
		sDDeOutDrMCM[10] = "White Ebonite Dress"
		   sDDeOutDr[10] = "iDDeOutDrEbWh"
		sDDeOutDrMCM[11] = "Black Leather Dress"
		   sDDeOutDr[11] = "iDDeOutDrLeBk"
		sDDeOutDrMCM[12] = "Red Leather Dress" 
		   sDDeOutDr[12] = "iDDeOutDrLeRd"
		sDDeOutDrMCM[13] = "White Leather Dress" 
		   sDDeOutDr[13] = "iDDeOutDrLeWh"
		sDDeOutDrMCM[14] = "Brown Leather Dress"
		   sDDeOutDr[14] = "iDDeOutDrLeBr" 
		sDDeOutDrMCM[15] = "Wood Dress"
		   sDDeOutDr[15] = "iDDeOutDrWo" 
		sDDeOutDrMCM[16] = "Rusty Dress"
		   sDDeOutDr[16] = "iDDeOutDrRusty" 
		sDDeOutDrMCM[17] = "Hypnotic Dress"
		   sDDeOutDr[17] = "iDDeOutDrHyp" 
		sDDeOutDrMCM[18] = "Fifa Dress"
		   sDDeOutDr[18] = "iDDeOutDrFifa" 
		sDDeOutDrMCM[19] = "Rope Dress"
		   sDDeOutDr[19] = "iDDeOutDrRope" 
		sDDeOutDrMCM[20] = "Falmer Dress"
		   sDDeOutDr[20] = "iDDeOutDrFalmer" 
		sDDeOutDrMCM[21] = "Fire Dress"
		   sDDeOutDr[21] = "iDDeOutDrFire" 
		sDDeOutDrMCM[22] = "Lite Wood Dress"
		   sDDeOutDr[22] = "iDDeOutDrLteWood" 
	;CD Outfits
	;-----------------------------------------------
	If (iCDxVer >= 4.00)
		sCDxOutMCM = NEW STRING[8]
				sCDxOut = NEW STRING[8]
		sCDxOutMCM[3] = "CD Bronze"
			 sCDxOut[3] = "iDDeOutCDxBr"
		sCDxOutMCM[4] = "CD Black"
			 sCDxOut[4] = "iDDeOutCDxBk"
		sCDxOutMCM[5] = "CD Red"
			 sCDxOut[5] = "iDDeOutCDxRd"
		sCDxOutMCM[6] = "CD White"
			 sCDxOut[6] = "iDDeOutCDxWh"
		sCDxOutMCM[7] = "CD Cursed"
			 sCDxOut[7] = "iDDeOutCDxCursed"
	Else
		sCDxOutMCM = NEW STRING[3]
			 sCDxOut = NEW STRING[3]
	EndIf
		sCDxOutMCM[0] = "No CD"
			 sCDxOut[0] = ""
	  sCDxOutMCM[1] = "CD Silver"
			 sCDxOut[1] = "iDDeOutCDxSv"
	  sCDxOutMCM[2] = "CD Silver Quest"
			 sCDxOut[2] = "iDDeOutCDx" 
	;-----------------------------------------------
	INT iLen = sDDeOutReg.Length
		StorageUtil.StringListAdd(iDDe.PlayerRef, "iDDeOutRegPreMade", "Null")
		StorageUtil.StringListResize(iDDe.PlayerRef, "iDDeOutRegPreMade", iLen, "")
		StorageUtil.StringListCopy(iDDe.PlayerRef, "iDDeOutRegPreMade", sDDeOutReg)
		
	iLen = sDDeOutDr.Length
		StorageUtil.StringListAdd(iDDe.PlayerRef, "iDDeOutDrPreMade", "Null")
		StorageUtil.StringListResize(iDDe.PlayerRef, "iDDeOutDrPreMade", iLen, "")
		StorageUtil.StringListCopy(iDDe.PlayerRef, "iDDeOutDrPreMade", sDDeOutDr)
		
	iLen = sDDeOutMisc.Length
		StorageUtil.StringListAdd(iDDe.PlayerRef, "iDDeOutMiscPreMade", "Null")
		StorageUtil.StringListResize(iDDe.PlayerRef, "iDDeOutMiscPreMade", iLen, "")
		StorageUtil.StringListCopy(iDDe.PlayerRef, "iDDeOutMiscPreMade", sDDeOutMisc)
		
	iLen = sCDxOut.Length
		StorageUtil.StringListAdd(iDDe.PlayerRef, "iDDeOutCDxPreMade", "Null")
		StorageUtil.StringListResize(iDDe.PlayerRef, "iDDeOutCDxPreMade", iLen, "")
		StorageUtil.StringListCopy(iDDe.PlayerRef, "iDDeOutCDxPreMade", sCDxOut)
EndFunction 
  
Function iDDeSetFactions()
	If (iDDe.iDDeGotMod("iDDeSetFactions()", "Dawnguard.esm"))
		VampireLordFaction = GetFormFromFile(0x000071D3, "Dawnguard.esm") AS Faction
			;DLC1PlayerVampireChangeScript 020071D0
	Else
		VampireLordFaction = None
	EndIf
EndFunction

STRING[] Property sSexKwds Auto Hidden	
STRING[] Property sPoseKwds Auto Hidden
STRING[] Property sDanceKwds Auto Hidden
Function iDDeSetMiscArr()
	sSexKwds = NEW STRING[11]
		sSexKwds[0] = "zad_DeviousGag"
		sSexKwds[1] = "zad_DeviousBelt"
		sSexKwds[2] = "zad_DeviousGloves"
		sSexKwds[3] = "zad_DeviousSuit"
		sSexKwds[4] = "zad_DeviousBoots"
		sSexKwds[5] = "zad_DeviousHarness"
		sSexKwds[6] = "zad_DeviousBra"
		sSexKwds[7] = "zad_DeviousPlugVaginal"
		sSexKwds[8] = "zad_DeviousPlugAnal"
		sSexKwds[9] = "zad_DeviousHood"
		sSexKwds[10] = "zad_DeviousHeavyBondage"
	
	sPoseKwds = NEW STRING[4]
		sPoseKwds[0] = "zad_DeviousSuit"
		sPoseKwds[1] = "zad_DeviousBoots"
		sPoseKwds[2] = "zad_DeviousBra"
		sPoseKwds[3] = "zad_DeviousHeavyBondage"
		
	sDanceKwds = NEW STRING[2]
		sDanceKwds[0] = "zad_DeviousBra"
		sDanceKwds[1] = "zad_DeviousHeavyBondage"
EndFunction

;Misc
;mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
Armor Property zad_DeviceHider Auto
;mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
;Trans
;ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt
Armor Property iDDe_TransCatSuit_Inv Auto
;ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt

;DDx
;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Armor Property zadx_BoxBinder_Red_Inventory Auto
Armor Property zadx_BoxBinder_White_Inventory Auto
Armor Property zadx_BoxBinderOutfit_Red_Inventory Auto
Armor Property zadx_BoxBinderOutfit_White_Inventory Auto
;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;Dwemer DDs
;ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
Armor Property iDDe_DwemerMechSuit_Inv Auto
Armor Property iDDe_DwemerMechSuitGag_Inv Auto
Armor Property iDDe_DwemerMechSuitIronMask_Inv Auto
Armor Property iDDe_DwemerMechSuitIronMaskL_Inv Auto
;ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd

;Falmer DDs 
;fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
Armor Property iDDe_FalmerArmbinder_Inv Auto
Armor Property iDDe_FalmerElbowbinder_Inv Auto
Armor Property iDDe_FalmerBoxbinder_Inv Auto
Armor Property iDDe_FalmerBoxbinderOut_Inv Auto
Armor Property iDDe_FalmerBeltChain_Inv Auto
Armor Property iDDe_FalmerBelt_Inv Auto
Armor Property iDDe_FalmerBlindfold_Inv Auto
Armor Property iDDe_FalmerBlindfoldBlock_Inv Auto 
Armor Property iDDe_FalmerBra_Inv Auto
Armor Property iDDe_FalmerCollarTall_Inv Auto
Armor Property iDDe_FalmerCollarPosture_Inv Auto
Armor Property iDDe_FalmerCuffsArms_Inv Auto
Armor Property iDDe_FalmerCuffsCollar_Inv Auto
Armor Property iDDe_FalmerCuffsLegs_Inv Auto
Armor Property iDDe_FalmerHarnessFull_Inv Auto
Armor Property iDDe_FalmerGagHarnessBall_Inv Auto
Armor Property iDDe_FalmerHarnessBlocking_Inv Auto
Armor Property iDDe_FalmerHarnessCollar_Inv Auto
Armor Property iDDe_FalmerHarnessBody_Inv Auto
Armor Property iDDe_FalmerGagHarnessPanel_Inv Auto
Armor Property iDDe_FalmerGagHarnessRing_Inv Auto
Armor Property iDDe_FalmerPonyBoots_Inv Auto
Armor Property iDDe_FalmerPlugSoulGemAn_Inv Auto
Armor Property iDDe_FalmerPlugSoulGemVg_Inv Auto
Armor Property iDDe_FalmerGagStrapBall_Inv Auto
Armor Property iDDe_FalmerGagStrapRing_Inv Auto
Armor Property iDDe_FalmerPlugChaosVg_Inv Auto
Armor Property iDDe_FalmerYoke_Inv Auto
Armor Property iDDe_FalmerBondageMittensPaw_Inv Auto
Armor Property iDDe_FalmerHobbleDressElegant_Inv Auto
Armor Property iDDe_FalmerHobbleDress_Inv Auto
Armor Property iDDe_FalmerHobbleDressOpen_Inv Auto
Armor Property iDDe_FalmerSlaveHighHeels_Inv Auto
Armor Property iDDe_FalmerHobbleDressLatex_Inv Auto
Armor Property iDDe_FalmerHobbleDressOpenLatex_Inv Auto
Armor Property iDDe_FalmerCatSuit_Inv Auto
Armor Property iDDe_FalmerCatGloves_Inv Auto
Armor Property iDDe_FalmerCatHood_Inv Auto
;fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff

;Ebonite
;eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee 
;Black
Armor Property iDDe_EbBkBra_Inv Auto
Armor Property iDDe_EbBkSlaveHighHeels_Inv Auto
Armor Property iDDe_EbBkIronMask_Inv Auto
Armor Property iDDe_EbBkHarnessBody_Inv Auto
;White
Armor Property iDDe_EbWhBra_Inv Auto
Armor Property iDDe_EbWhSlaveHighHeels_Inv Auto
Armor Property iDDe_EbWhIronMask_Inv Auto
Armor Property iDDe_EbWhHarnessBody_Inv Auto
;Red 
Armor Property iDDe_EbRdBra_Inv Auto
Armor Property iDDe_EbRdSlaveHighHeels_Inv Auto
Armor Property iDDe_EbRdIronMask_Inv Auto
Armor Property iDDe_EbRdHarnessBody_Inv Auto
;eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee

;Leather 
;lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
;Black
Armor Property iDDe_LeBkBra_Inv Auto
Armor Property iDDe_LeBkIronMask_Inv Auto
Armor Property iDDe_LeBkHarnessBody_Inv Auto
;White
Armor Property iDDe_LeWhBra_Inv Auto
Armor Property iDDe_LeWhIronMask_Inv Auto
Armor Property iDDe_LeWhHarnessBody_Inv Auto
;Red
Armor Property iDDe_LeRdBra_Inv Auto
Armor Property iDDe_LeRdIronMask_Inv Auto
Armor Property iDDe_LeRdHarnessBody_Inv Auto
;Brown
Armor Property iDDe_LeBrArmbinder_Inv Auto
Armor Property iDDe_LeBrElbowbinder_Inv Auto
Armor Property iDDe_LeBrBoxbinder_Inv Auto
Armor Property iDDe_LeBrBoxbinderOut_Inv Auto
Armor Property iDDe_LeBrBelt_Inv Auto
Armor Property iDDe_LeBrGagBit_Inv Auto
Armor Property iDDe_LeBrBlindfold_Inv Auto
Armor Property iDDe_LeBrBra_Inv Auto
Armor Property iDDe_LeBrCollarPosture_Inv Auto
Armor Property iDDe_LeBrCuffsArms_Inv Auto
Armor Property iDDe_LeBrCuffsCollar_Inv Auto
Armor Property iDDe_LeBrCuffsLegs_Inv Auto
Armor Property iDDe_LeBrGagHarnessBall_Inv Auto
Armor Property iDDe_LeBrHarnessCollar_Inv Auto
Armor Property iDDe_LeBrHarnessBody_Inv Auto
Armor Property iDDe_LeBrGagHarnessRing_Inv Auto
Armor Property iDDe_LeBrPonyBoots_Inv Auto
Armor Property iDDe_LeBrGagStrapBall_Inv Auto
Armor Property iDDe_LeBrGagStrapRing_Inv Auto
Armor Property iDDe_LeBrBondageMittensPaw_Inv Auto
Armor Property iDDe_LeBrHobbleDressElegant_Inv Auto
Armor Property iDDe_LeBrHobbleDress_Inv Auto
Armor Property iDDe_LeBrHobbleDressOpen_Inv Auto
Armor Property iDDe_LeBrSlaveHighHeels_Inv Auto
Armor Property iDDe_LeBrHobbleDressLatex_Inv Auto
Armor Property iDDe_LeBrHobbleDressOpenLatex_Inv Auto
Armor Property iDDe_LeBrIronMask_Inv Auto
Armor Property iDDe_LeBrCatSuit_Inv Auto
Armor Property iDDe_LeBrCatGloves_Inv Auto
Armor Property iDDe_LeBrCatHood_Inv Auto
;lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll

;Wood DDs
;wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
Armor Property iDDe_WoodArmbinder_Inv Auto
Armor Property iDDe_WoodElbowbinder_Inv Auto
Armor Property iDDe_WoodBoxbinder_Inv Auto
Armor Property iDDe_WoodBoxbinderOut_Inv Auto
Armor Property iDDe_WoodBra_Inv Auto 
Armor Property iDDe_WoodBelt_Inv Auto
Armor Property iDDe_WoodCollarTall_Inv Auto 
Armor Property iDDe_WoodCollarPosture_Inv Auto 
Armor Property iDDe_WoodCuffsArms_Inv Auto
Armor Property iDDe_WoodCuffsLegs_Inv Auto 
Armor Property iDDe_WoodGagHarnessBall_Inv Auto
Armor Property iDDe_WoodHarnessBody_Inv Auto
Armor Property iDDe_WoodGagStrapBall_Inv Auto
Armor Property iDDe_WoodCuffsCollar_Inv Auto 
Armor Property iDDe_WoodPonyBoots_Inv Auto
Armor Property iDDe_WoodBondageMittensPaw_Inv Auto
Armor Property iDDe_WoodHobbleDressElegant_Inv Auto
Armor Property iDDe_WoodHobbleDress_Inv Auto
Armor Property iDDe_WoodHobbleDressOpen_Inv Auto
Armor Property iDDe_WoodSlaveHighHeels_Inv Auto
Armor Property iDDe_WoodHobbleDressLatex_Inv Auto
Armor Property iDDe_WoodHobbleDressOpenLatex_Inv Auto
Armor Property iDDe_WoodIronMask_Inv Auto
Armor Property iDDe_WoodCatSuit_Inv Auto
Armor Property iDDe_WoodCatGloves_Inv Auto
Armor Property iDDe_WoodCatHood_Inv Auto
Armor Property iDDe_WoodBlindfold_Inv Auto
;wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww

;Lite Wood DDs
;wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
Armor Property iDDe_LteWoodArmbinder_Inv Auto
Armor Property iDDe_LteWoodElbowbinder_Inv Auto
Armor Property iDDe_LteWoodBoxbinder_Inv Auto
Armor Property iDDe_LteWoodBoxbinderOut_Inv Auto
Armor Property iDDe_LteWoodBra_Inv Auto 
Armor Property iDDe_LteWoodBelt_Inv Auto
Armor Property iDDe_LteWoodCollarTall_Inv Auto 
Armor Property iDDe_LteWoodCollarPosture_Inv Auto 
Armor Property iDDe_LteWoodCuffsArms_Inv Auto
Armor Property iDDe_LteWoodCuffsLegs_Inv Auto 
Armor Property iDDe_LteWoodHarnessBody_Inv Auto
Armor Property iDDe_LteWoodGagHarnessBall_Inv Auto
Armor Property iDDe_LteWoodGagHarnessRing_Inv Auto
Armor Property iDDe_LteWoodGagStrapBall_Inv Auto
Armor Property iDDe_LteWoodCuffsCollar_Inv Auto 
Armor Property iDDe_LteWoodPonyBoots_Inv Auto
Armor Property iDDe_LteWoodBondageMittensPaw_Inv Auto
Armor Property iDDe_LteWoodHobbleDressElegant_Inv Auto
Armor Property iDDe_LteWoodHobbleDress_Inv Auto
Armor Property iDDe_LteWoodHobbleDressOpen_Inv Auto
Armor Property iDDe_LteWoodSlaveHighHeels_Inv Auto
Armor Property iDDe_LteWoodHobbleDressLatex_Inv Auto
Armor Property iDDe_LteWoodHobbleDressOpenLatex_Inv Auto
Armor Property iDDe_LteWoodIronMask_Inv Auto
Armor Property iDDe_LteWoodCatSuit_Inv Auto
Armor Property iDDe_LteWoodCatGloves_Inv Auto
Armor Property iDDe_LteWoodCatHood_Inv Auto
Armor Property iDDe_LteWoodBlindfold_Inv Auto
;wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww

;Iron DDs
;iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
Armor Property iDDe_IronShacklesArms_Inv Auto
Armor Property iDDe_IronShacklesLegs_Inv Auto
Armor Property iDDe_IronBra_Inv Auto
Armor Property iDDe_IronBelt_Inv Auto
Armor Property iDDe_IronBeltChain_Inv Auto
Armor Property iDDe_IronCollarPosture_Inv Auto
Armor Property iDDe_IronRingShoes_Inv Auto
Armor Property iDDe_IronMask_Inv Auto
Armor Property iDDe_IronBlindfold_Inv Auto
Armor Property iDDe_IronYoke_Inv Auto
;iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii

;Gold DDs
;ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
Armor Property iDDe_GoldArmbinder_Inv Auto
Armor Property iDDe_GoldElbowbinder_Inv Auto
Armor Property iDDe_GoldBoxbinder_Inv Auto
Armor Property iDDe_GoldBoxbinderOut_Inv Auto
Armor Property iDDe_GoldBeltChain_Inv Auto
Armor Property iDDe_GoldBelt_Inv Auto
Armor Property iDDe_GoldGagBit_Inv Auto
Armor Property iDDe_GoldBlindfold_Inv Auto
Armor Property iDDe_GoldBra_Inv Auto
Armor Property iDDe_GoldCollar_Inv Auto
Armor Property iDDe_GoldCollarPosture_Inv Auto
Armor Property iDDe_GoldCuffsArms_Inv Auto
Armor Property iDDe_GoldCuffsCollar_Inv Auto
Armor Property iDDe_GoldCuffsLegs_Inv Auto
Armor Property iDDe_GoldGagHarnessBall_Inv Auto
Armor Property iDDe_GoldHarnessCollar_Inv Auto
Armor Property iDDe_GoldHarnessBody_Inv Auto
Armor Property iDDe_GoldPonyBoots_Inv Auto
Armor Property iDDe_GoldRingShoes_Inv Auto
Armor Property iDDe_GoldShacklesArms_Inv Auto
Armor Property iDDe_GoldShacklesLegs_Inv Auto
Armor Property iDDe_GoldPlugSoulGemAn_Inv Auto
Armor Property iDDe_GoldPlugSoulGemVg_Inv Auto
Armor Property iDDe_GoldGagStrapBall_Inv Auto
Armor Property iDDe_GoldGagStrapRing_Inv Auto
Armor Property iDDe_GoldYoke_Inv Auto
Armor Property iDDe_GoldYokeZbf_Inv Auto
Armor Property iDDe_GoldBondageMittensPaw_Inv Auto
Armor Property iDDe_GoldHobbleDressElegant_Inv Auto
Armor Property iDDe_GoldHobbleDress_Inv Auto
Armor Property iDDe_GoldHobbleDressOpen_Inv Auto
Armor Property iDDe_GoldSlaveHighHeels_Inv Auto
Armor Property iDDe_GoldHobbleDressLatex_Inv Auto
Armor Property iDDe_GoldHobbleDressOpenLatex_Inv Auto
Armor Property iDDe_GoldIronMask_Inv Auto
Armor Property iDDe_GoldCatSuit_Inv Auto
Armor Property iDDe_GoldCatGloves_Inv Auto
Armor Property iDDe_GoldCatHood_Inv Auto
;ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg

;Inox DDs
;iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
Armor Property iDDe_InoxArmbinder_Inv Auto
Armor Property iDDe_InoxElbowbinder_Inv Auto
Armor Property iDDe_InoxBoxbinder_Inv Auto
Armor Property iDDe_InoxBoxbinderOut_Inv Auto
Armor Property iDDe_InoxBeltChain_Inv Auto
Armor Property iDDe_InoxBelt_Inv Auto
Armor Property iDDe_InoxGagBit_Inv Auto
Armor Property iDDe_InoxBlindfold_Inv Auto
Armor Property iDDe_InoxBra_Inv Auto
Armor Property iDDe_InoxCollar_Inv Auto
Armor Property iDDe_InoxCollarPosture_Inv Auto
Armor Property iDDe_InoxCuffsArms_Inv Auto
Armor Property iDDe_InoxCuffsCollar_Inv Auto
Armor Property iDDe_InoxCuffsLegs_Inv Auto
Armor Property iDDe_InoxGagHarnessBall_Inv Auto
Armor Property iDDe_InoxHarnessCollar_Inv Auto
Armor Property iDDe_InoxHarnessBody_Inv Auto
Armor Property iDDe_InoxGagHarnessRing_Inv Auto
Armor Property iDDe_InoxPonyBoots_Inv Auto
Armor Property iDDe_InoxRingShoes_Inv Auto
Armor Property iDDe_InoxShacklesArms_Inv Auto
Armor Property iDDe_InoxShacklesLegs_Inv Auto
Armor Property iDDe_InoxPlugSoulGemAn_Inv Auto
Armor Property iDDe_InoxPlugSoulGemVg_Inv Auto
Armor Property iDDe_InoxGagStrapBall_Inv Auto
Armor Property iDDe_InoxGagStrapRing_Inv Auto
Armor Property iDDe_InoxYoke_Inv Auto
Armor Property iDDe_InoxYokeZbf_Inv Auto
Armor Property iDDe_InoxBondageMittensPaw_Inv Auto
Armor Property iDDe_InoxHobbleDressElegant_Inv Auto
Armor Property iDDe_InoxHobbleDress_Inv Auto
Armor Property iDDe_InoxHobbleDressOpen_Inv Auto
Armor Property iDDe_InoxSlaveHighHeels_Inv Auto
Armor Property iDDe_InoxHobbleDressLatex_Inv Auto
Armor Property iDDe_InoxHobbleDressOpenLatex_Inv Auto
Armor Property iDDe_InoxIronMask_Inv Auto
Armor Property iDDe_InoxMechSuit_Inv Auto
Armor Property iDDe_InoxMechSuitGag_Inv Auto
Armor Property iDDe_InoxMechSuitIronMask_Inv Auto
Armor Property iDDe_InoxMechSuitIronMaskL_Inv Auto
Armor Property iDDe_InoxCatSuit_Inv Auto
Armor Property iDDe_InoxCatGloves_Inv Auto
Armor Property iDDe_InoxCatHood_Inv Auto
;iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii

;Rope DDs
;rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
Armor Property iDDe_RopeArmbinder_Inv Auto
Armor Property iDDe_RopeElbowbinder_Inv Auto
Armor Property iDDe_RopeBoxbinder_Inv Auto
Armor Property iDDe_RopeBoxbinderOut_Inv Auto
Armor Property iDDe_RopeBra_Inv Auto 
Armor Property iDDe_RopeBelt_Inv Auto
Armor Property iDDe_RopeCollarTall_Inv Auto 
Armor Property iDDe_RopeCollarPosture_Inv Auto 
Armor Property iDDe_RopeCuffsArms_Inv Auto
Armor Property iDDe_RopeCuffsLegs_Inv Auto 
Armor Property iDDe_RopeHarnessBody_Inv Auto
Armor Property iDDe_RopeGagHarnessBall_Inv Auto
Armor Property iDDe_RopeGagHarnessRing_Inv Auto
Armor Property iDDe_RopeGagStrapBall_Inv Auto
Armor Property iDDe_RopeCuffsCollar_Inv Auto 
Armor Property iDDe_RopePonyBoots_Inv Auto
Armor Property iDDe_RopeBondageMittensPaw_Inv Auto
Armor Property iDDe_RopeHobbleDressElegant_Inv Auto
Armor Property iDDe_RopeHobbleDress_Inv Auto
Armor Property iDDe_RopeHobbleDressOpen_Inv Auto
Armor Property iDDe_RopeSlaveHighHeels_Inv Auto
Armor Property iDDe_RopeHobbleDressLatex_Inv Auto
Armor Property iDDe_RopeHobbleDressOpenLatex_Inv Auto
Armor Property iDDe_RopeIronMask_Inv Auto
Armor Property iDDe_RopeCatSuit_Inv Auto
Armor Property iDDe_RopeCatGloves_Inv Auto
Armor Property iDDe_RopeCatHood_Inv Auto
Armor Property iDDe_RopeBlindfold_Inv Auto
;rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr

;Rusty
;sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss
Armor Property iDDe_RustyArmbinder_Inv Auto
Armor Property iDDe_RustyElbowbinder_Inv Auto
Armor Property iDDe_RustyBoxbinder_Inv Auto
Armor Property iDDe_RustyBoxbinderOut_Inv Auto
Armor Property iDDe_RustyBeltChain_Inv Auto
Armor Property iDDe_RustyBelt_Inv Auto
Armor Property iDDe_RustyBlindfold_Inv Auto
Armor Property iDDe_RustyBra_Inv Auto
Armor Property iDDe_RustyCollarPosture_Inv Auto
Armor Property iDDe_RustyCuffsArms_Inv Auto
Armor Property iDDe_RustyCuffsCollar_Inv Auto
Armor Property iDDe_RustyCuffsLegs_Inv Auto
Armor Property iDDe_RustyGagHarnessBall_Inv Auto
Armor Property iDDe_RustyHarnessCollar_Inv Auto
Armor Property iDDe_RustyHarnessBody_Inv Auto
Armor Property iDDe_RustyGagHarnessRing_Inv Auto
Armor Property iDDe_RustyPonyBoots_Inv Auto
Armor Property iDDe_RustyGagStrapBall_Inv Auto
Armor Property iDDe_RustyGagStrapRing_Inv Auto
Armor Property iDDe_RustyYoke_Inv Auto
Armor Property iDDe_RustyYokeZbf_Inv Auto
Armor Property iDDe_RustyBondageMittensPaw_Inv Auto
Armor Property iDDe_RustyHobbleDressElegant_Inv Auto
Armor Property iDDe_RustyHobbleDress_Inv Auto
Armor Property iDDe_RustyHobbleDressOpen_Inv Auto
Armor Property iDDe_RustySlaveHighHeels_Inv Auto
Armor Property iDDe_RustyHobbleDressLatex_Inv Auto
Armor Property iDDe_RustyHobbleDressOpenLatex_Inv Auto
Armor Property iDDe_RustyIronMask_Inv Auto
Armor Property iDDe_RustyCatSuit_Inv Auto
Armor Property iDDe_RustyCatGloves_Inv Auto
Armor Property iDDe_RustyCatHood_Inv Auto
;sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss

;Chromogen Hex
;ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
Armor Property iDDe_HexChArmbinder_Inv Auto
Armor Property iDDe_HexChElbowbinder_Inv Auto
Armor Property iDDe_HexChBoxbinder_Inv Auto
Armor Property iDDe_HexChBoxbinderOut_Inv Auto
Armor Property iDDe_HexChBeltChain_Inv Auto
Armor Property iDDe_HexChBelt_Inv Auto
Armor Property iDDe_HexChBlindfold_Inv Auto
Armor Property iDDe_HexChBra_Inv Auto
Armor Property iDDe_HexChCollarTall_Inv Auto
Armor Property iDDe_HexChCollarPosture_Inv Auto
Armor Property iDDe_HexChCuffsArms_Inv Auto
Armor Property iDDe_HexChCuffsCollar_Inv Auto
Armor Property iDDe_HexChCuffsLegs_Inv Auto
Armor Property iDDe_HexChGagHarnessBall_Inv Auto
Armor Property iDDe_HexChHarnessCollar_Inv Auto
Armor Property iDDe_HexChHarnessBody_Inv Auto
Armor Property iDDe_HexChGagHarnessRing_Inv Auto
Armor Property iDDe_HexChPonyBoots_Inv Auto
Armor Property iDDe_HexChGagStrapBall_Inv Auto
Armor Property iDDe_HexChGagStrapRing_Inv Auto
Armor Property iDDe_HexChYoke_Inv Auto
Armor Property iDDe_HexChBondageMittensPaw_Inv Auto
Armor Property iDDe_HexChHobbleDressElegant_Inv Auto
Armor Property iDDe_HexChHobbleDress_Inv Auto
Armor Property iDDe_HexChHobbleDressOpen_Inv Auto
Armor Property iDDe_HexChSlaveHighHeels_Inv Auto
Armor Property iDDe_HexChHobbleDressLatex_Inv Auto
Armor Property iDDe_HexChHobbleDressOpenLatex_Inv Auto
Armor Property iDDe_HexChCatSuit_Inv Auto
Armor Property iDDe_HexChCatGloves_Inv Auto
Armor Property iDDe_HexChCatHood_Inv Auto
;ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

;Red Hex
;rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
Armor Property iDDe_HexRdArmbinder_Inv Auto
Armor Property iDDe_HexRdElbowbinder_Inv Auto
Armor Property iDDe_HexRdBoxbinder_Inv Auto
Armor Property iDDe_HexRdBoxbinderOut_Inv Auto
Armor Property iDDe_HexRdBeltChain_Inv Auto
Armor Property iDDe_HexRdBelt_Inv Auto
Armor Property iDDe_HexRdBlindfold_Inv Auto
Armor Property iDDe_HexRdBra_Inv Auto
Armor Property iDDe_HexRdCollarPosture_Inv Auto
Armor Property iDDe_HexRdCuffsArms_Inv Auto
Armor Property iDDe_HexRdCuffsCollar_Inv Auto
Armor Property iDDe_HexRdCuffsLegs_Inv Auto
Armor Property iDDe_HexRdGagHarnessBall_Inv Auto
Armor Property iDDe_HexRdHarnessCollar_Inv Auto
Armor Property iDDe_HexRdHarnessBody_Inv Auto
Armor Property iDDe_HexRdGagHarnessRing_Inv Auto
Armor Property iDDe_HexRdPonyBoots_Inv Auto 
Armor Property iDDe_HexRdGagStrapBall_Inv Auto
Armor Property iDDe_HexRdGagStrapRing_Inv Auto
Armor Property iDDe_HexRdYoke_Inv Auto
Armor Property iDDe_HexRdYokeZbf_Inv Auto
Armor Property iDDe_HexRdBondageMittensPaw_Inv Auto
Armor Property iDDe_HexRdHobbleDressElegant_Inv Auto
Armor Property iDDe_HexRdHobbleDress_Inv Auto
Armor Property iDDe_HexRdHobbleDressOpen_Inv Auto
Armor Property iDDe_HexRdSlaveHighHeels_Inv Auto
Armor Property iDDe_HexRdHobbleDressLatex_Inv Auto
Armor Property iDDe_HexRdHobbleDressOpenLatex_Inv Auto
Armor Property iDDe_HexRdIronMask_Inv Auto
Armor Property iDDe_HexRdCatSuit_Inv Auto
Armor Property iDDe_HexRdCatGloves_Inv Auto
Armor Property iDDe_HexRdCatHood_Inv Auto
;rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr

;Orange Hex
;yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
Armor Property iDDe_HexOrArmbinder_Inv Auto
Armor Property iDDe_HexOrElbowbinder_Inv Auto
Armor Property iDDe_HexOrBoxbinder_Inv Auto
Armor Property iDDe_HexOrBoxbinderOut_Inv Auto
Armor Property iDDe_HexOrBeltChain_Inv Auto
Armor Property iDDe_HexOrBelt_Inv Auto
Armor Property iDDe_HexOrBlindfold_Inv Auto
Armor Property iDDe_HexOrBra_Inv Auto
Armor Property iDDe_HexOrCollarPosture_Inv Auto
Armor Property iDDe_HexOrCuffsArms_Inv Auto
Armor Property iDDe_HexOrCuffsCollar_Inv Auto
Armor Property iDDe_HexOrCuffsLegs_Inv Auto
Armor Property iDDe_HexOrGagHarnessBall_Inv Auto
Armor Property iDDe_HexOrHarnessCollar_Inv Auto
Armor Property iDDe_HexOrHarnessBody_Inv Auto
Armor Property iDDe_HexOrGagHarnessRing_Inv Auto
Armor Property iDDe_HexOrPonyBoots_Inv Auto 
Armor Property iDDe_HexOrGagStrapBall_Inv Auto
Armor Property iDDe_HexOrGagStrapRing_Inv Auto
Armor Property iDDe_HexOrYoke_Inv Auto
Armor Property iDDe_HexOrYokeZbf_Inv Auto
Armor Property iDDe_HexOrBondageMittensPaw_Inv Auto
Armor Property iDDe_HexOrHobbleDressElegant_Inv Auto
Armor Property iDDe_HexOrHobbleDress_Inv Auto
Armor Property iDDe_HexOrHobbleDressOpen_Inv Auto
Armor Property iDDe_HexOrSlaveHighHeels_Inv Auto
Armor Property iDDe_HexOrHobbleDressLatex_Inv Auto
Armor Property iDDe_HexOrHobbleDressOpenLatex_Inv Auto
Armor Property iDDe_HexOrIronMask_Inv Auto
Armor Property iDDe_HexOrCatSuit_Inv Auto
Armor Property iDDe_HexOrCatGloves_Inv Auto
Armor Property iDDe_HexOrCatHood_Inv Auto
;yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy

;Black Hex
;bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
Armor Property iDDe_HexBkArmbinder_Inv Auto
Armor Property iDDe_HexBkElbowbinder_Inv Auto
Armor Property iDDe_HexBkBoxbinder_Inv Auto
Armor Property iDDe_HexBkBoxbinderOut_Inv Auto
;bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb

;Hypnotic
;sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss
Armor Property iDDe_HypArmbinder_Inv Auto
Armor Property iDDe_HypElbowbinder_Inv Auto
Armor Property iDDe_HypBoxbinder_Inv Auto
Armor Property iDDe_HypBoxbinderOut_Inv Auto
Armor Property iDDe_HypBeltChain_Inv Auto
Armor Property iDDe_HypBelt_Inv Auto
Armor Property iDDe_HypBlindfold_Inv Auto
Armor Property iDDe_HypBra_Inv Auto
Armor Property iDDe_HypCollarPosture_Inv Auto
Armor Property iDDe_HypCuffsArms_Inv Auto
Armor Property iDDe_HypCuffsCollar_Inv Auto
Armor Property iDDe_HypCuffsLegs_Inv Auto
Armor Property iDDe_HypGagHarnessBall_Inv Auto
Armor Property iDDe_HypHarnessCollar_Inv Auto
Armor Property iDDe_HypHarnessBody_Inv Auto
Armor Property iDDe_HypGagHarnessRing_Inv Auto
Armor Property iDDe_HypPonyBoots_Inv Auto
Armor Property iDDe_HypGagStrapBall_Inv Auto
Armor Property iDDe_HypGagStrapRing_Inv Auto
Armor Property iDDe_HypYoke_Inv Auto
Armor Property iDDe_HypYokeZbf_Inv Auto
Armor Property iDDe_HypBondageMittensPaw_Inv Auto
Armor Property iDDe_HypHobbleDressElegant_Inv Auto
Armor Property iDDe_HypHobbleDress_Inv Auto
Armor Property iDDe_HypHobbleDressOpen_Inv Auto
Armor Property iDDe_HypSlaveHighHeels_Inv Auto
Armor Property iDDe_HypHobbleDressLatex_Inv Auto
Armor Property iDDe_HypHobbleDressOpenLatex_Inv Auto
Armor Property iDDe_HypIronMask_Inv Auto
Armor Property iDDe_HypCatSuit_Inv Auto
Armor Property iDDe_HypCatGloves_Inv Auto
Armor Property iDDe_HypCatHood_Inv Auto
;sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss

;Magical DDs
;mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
Armor Property iDDe_MagicalArmbinder Auto
Armor Property iDDe_MagicalAnkles Auto
Armor Property iDDe_InvShacklesArms_Inv Auto
;mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

;Jade DDs
;jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj
Armor Property iDDe_JadeArmbinder_Inv Auto
Armor Property iDDe_JadeElbowbinder_Inv Auto
Armor Property iDDe_JadeBoxbinder_Inv Auto
Armor Property iDDe_JadeBoxbinderOut_Inv Auto
Armor Property iDDe_JadeBeltChain_Inv Auto
Armor Property iDDe_JadeBelt_Inv Auto
Armor Property iDDe_JadeGagBit_Inv Auto
Armor Property iDDe_JadeBlindfold_Inv Auto
Armor Property iDDe_JadeBra_Inv Auto
Armor Property iDDe_JadeCollar_Inv Auto
Armor Property iDDe_JadeCollarPosture_Inv Auto
Armor Property iDDe_JadeCuffsArms_Inv Auto
Armor Property iDDe_JadeCuffsCollar_Inv Auto
Armor Property iDDe_JadeCuffsLegs_Inv Auto
Armor Property iDDe_JadeGagHarnessBall_Inv Auto
Armor Property iDDe_JadeHarnessCollar_Inv Auto
Armor Property iDDe_JadeHarnessBody_Inv Auto
Armor Property iDDe_JadeGagHarnessRing_Inv Auto
Armor Property iDDe_JadePonyBoots_Inv Auto
Armor Property iDDe_JadeRingShoes_Inv Auto
Armor Property iDDe_JadeShacklesArms_Inv Auto
Armor Property iDDe_JadeShacklesLegs_Inv Auto
Armor Property iDDe_JadePlugSoulGemAn_Inv Auto
Armor Property iDDe_JadePlugSoulGemVg_Inv Auto
Armor Property iDDe_JadeGagStrapBall_Inv Auto
Armor Property iDDe_JadeGagStrapRing_Inv Auto
Armor Property iDDe_JadeYoke_Inv Auto
Armor Property iDDe_JadeYokeZbf_Inv Auto
Armor Property iDDe_JadeBondageMittensPaw_Inv Auto
Armor Property iDDe_JadeHobbleDressElegant_Inv Auto
Armor Property iDDe_JadeHobbleDress_Inv Auto
Armor Property iDDe_JadeHobbleDressOpen_Inv Auto
Armor Property iDDe_JadeSlaveHighHeels_Inv Auto
Armor Property iDDe_JadeHobbleDressLatex_Inv Auto
Armor Property iDDe_JadeHobbleDressOpenLatex_Inv Auto
Armor Property iDDe_JadeIronMask_Inv Auto
Armor Property iDDe_JadeCatSuit_Inv Auto
Armor Property iDDe_JadeCatGloves_Inv Auto
Armor Property iDDe_JadeCatHood_Inv Auto
;jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj

;FIFA DDs
;fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
Armor Property iDDe_FifaArmbinder_Inv Auto
Armor Property iDDe_FifaElbowbinder_Inv Auto
Armor Property iDDe_FifaBoxbinder_Inv Auto
Armor Property iDDe_FifaBoxbinderOut_Inv Auto
Armor Property iDDe_FifaBeltChain_Inv Auto
Armor Property iDDe_FifaBelt_Inv Auto
Armor Property iDDe_FifaGagBit_Inv Auto
Armor Property iDDe_FifaBlindfold_Inv Auto
Armor Property iDDe_FifaBra_Inv Auto
Armor Property iDDe_FifaCollar_Inv Auto
Armor Property iDDe_FifaCollarPosture_Inv Auto
Armor Property iDDe_FifaCuffsArms_Inv Auto
Armor Property iDDe_FifaCuffsCollar_Inv Auto
Armor Property iDDe_FifaCuffsLegs_Inv Auto
Armor Property iDDe_FifaGagHarnessBall_Inv Auto
Armor Property iDDe_FifaHarnessCollar_Inv Auto
Armor Property iDDe_FifaHarnessBody_Inv Auto
Armor Property iDDe_FifaGagHarnessRing_Inv Auto
Armor Property iDDe_FifaPonyBoots_Inv Auto
Armor Property iDDe_FifaRingShoes_Inv Auto
Armor Property iDDe_FifaShacklesArms_Inv Auto
Armor Property iDDe_FifaShacklesLegs_Inv Auto
Armor Property iDDe_FifaPlugSoulGemAn_Inv Auto
Armor Property iDDe_FifaPlugSoulGemVg_Inv Auto
Armor Property iDDe_FifaGagStrapBall_Inv Auto
Armor Property iDDe_FifaGagStrapRing_Inv Auto
Armor Property iDDe_FifaYoke_Inv Auto
Armor Property iDDe_FifaYokeZbf_Inv Auto
Armor Property iDDe_FifaBondageMittensPaw_Inv Auto
Armor Property iDDe_FifaHobbleDressElegant_Inv Auto
Armor Property iDDe_FifaHobbleDress_Inv Auto
Armor Property iDDe_FifaHobbleDressOpen_Inv Auto
Armor Property iDDe_FifaSlaveHighHeels_Inv Auto
Armor Property iDDe_FifaHobbleDressLatex_Inv Auto
Armor Property iDDe_FifaHobbleDressOpenLatex_Inv Auto
Armor Property iDDe_FifaIronMask_Inv Auto
Armor Property iDDe_FifaCatSuit_Inv Auto
Armor Property iDDe_FifaCatGloves_Inv Auto
Armor Property iDDe_FifaCatHood_Inv Auto
;fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff

;Fire DDs
;iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
Armor Property iDDe_FireArmbinder_Inv Auto
Armor Property iDDe_FireElbowbinder_Inv Auto
Armor Property iDDe_FireBoxbinder_Inv Auto
Armor Property iDDe_FireBoxbinderOut_Inv Auto
Armor Property iDDe_FireBeltChain_Inv Auto
Armor Property iDDe_FireBelt_Inv Auto
Armor Property iDDe_FireGagBit_Inv Auto
Armor Property iDDe_FireBlindfold_Inv Auto
Armor Property iDDe_FireBra_Inv Auto
Armor Property iDDe_FireCollar_Inv Auto 
Armor Property iDDe_FireCollarPosture_Inv Auto
Armor Property iDDe_FireCuffsArms_Inv Auto
Armor Property iDDe_FireCuffsCollar_Inv Auto
Armor Property iDDe_FireCuffsLegs_Inv Auto
Armor Property iDDe_FireGagHarnessBall_Inv Auto
Armor Property iDDe_FireHarnessCollar_Inv Auto
Armor Property iDDe_FireHarnessBody_Inv Auto
Armor Property iDDe_FireGagHarnessRing_Inv Auto
Armor Property iDDe_FirePonyBoots_Inv Auto
Armor Property iDDe_FireRingShoes_Inv Auto
Armor Property iDDe_FireShacklesArms_Inv Auto
Armor Property iDDe_FireShacklesLegs_Inv Auto
Armor Property iDDe_FirePlugSoulGemAn_Inv Auto
Armor Property iDDe_FirePlugSoulGemVg_Inv Auto
Armor Property iDDe_FireGagStrapBall_Inv Auto
Armor Property iDDe_FireGagStrapRing_Inv Auto
Armor Property iDDe_FireYoke_Inv Auto
Armor Property iDDe_FireYokeZbf_Inv Auto
Armor Property iDDe_FireBondageMittensPaw_Inv Auto
Armor Property iDDe_FireHobbleDressElegant_Inv Auto
Armor Property iDDe_FireHobbleDress_Inv Auto
Armor Property iDDe_FireHobbleDressOpen_Inv Auto
Armor Property iDDe_FireSlaveHighHeels_Inv Auto
Armor Property iDDe_FireHobbleDressLatex_Inv Auto
Armor Property iDDe_FireHobbleDressOpenLatex_Inv Auto
Armor Property iDDe_FireIronMask_Inv Auto
Armor Property iDDe_FireCatSuit_Inv Auto
Armor Property iDDe_FireCatGloves_Inv Auto
Armor Property iDDe_FireCatHood_Inv Auto
;iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii

;Crimson DDs
;ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
Armor Property iDDe_CrimsonArmbinder_Inv Auto
Armor Property iDDe_CrimsonElbowbinder_Inv Auto
Armor Property iDDe_CrimsonBoxbinder_Inv Auto
Armor Property iDDe_CrimsonBoxbinderOut_Inv Auto
Armor Property iDDe_CrimsonBeltChain_Inv Auto
Armor Property iDDe_CrimsonBelt_Inv Auto
Armor Property iDDe_CrimsonGagBit_Inv Auto
Armor Property iDDe_CrimsonBlindfold_Inv Auto
Armor Property iDDe_CrimsonBra_Inv Auto
Armor Property iDDe_CrimsonCollar_Inv Auto
Armor Property iDDe_CrimsonCollarPosture_Inv Auto
Armor Property iDDe_CrimsonCuffsArms_Inv Auto
Armor Property iDDe_CrimsonCuffsCollar_Inv Auto
Armor Property iDDe_CrimsonCuffsLegs_Inv Auto
Armor Property iDDe_CrimsonGagHarnessBall_Inv Auto
Armor Property iDDe_CrimsonHarnessCollar_Inv Auto
Armor Property iDDe_CrimsonHarnessBody_Inv Auto
Armor Property iDDe_CrimsonGagHarnessRing_Inv Auto
Armor Property iDDe_CrimsonPonyBoots_Inv Auto
Armor Property iDDe_CrimsonRingShoes_Inv Auto
Armor Property iDDe_CrimsonShacklesArms_Inv Auto
Armor Property iDDe_CrimsonShacklesLegs_Inv Auto
Armor Property iDDe_CrimsonPlugSoulGemAn_Inv Auto
Armor Property iDDe_CrimsonPlugSoulGemVg_Inv Auto
Armor Property iDDe_CrimsonGagStrapBall_Inv Auto
Armor Property iDDe_CrimsonGagStrapRing_Inv Auto
Armor Property iDDe_CrimsonYoke_Inv Auto
Armor Property iDDe_CrimsonYokeZbf_Inv Auto
Armor Property iDDe_CrimsonBondageMittensPaw_Inv Auto
Armor Property iDDe_CrimsonHobbleDressElegant_Inv Auto
Armor Property iDDe_CrimsonHobbleDress_Inv Auto
Armor Property iDDe_CrimsonHobbleDressOpen_Inv Auto
Armor Property iDDe_CrimsonSlaveHighHeels_Inv Auto
Armor Property iDDe_CrimsonHobbleDressLatex_Inv Auto
Armor Property iDDe_CrimsonHobbleDressOpenLatex_Inv Auto
Armor Property iDDe_CrimsonIronMask_Inv Auto
Armor Property iDDe_CrimsonCatSuit_Inv Auto
Armor Property iDDe_CrimsonCatGloves_Inv Auto
Armor Property iDDe_CrimsonCatHood_Inv Auto
;ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

;Bumblebee DDs
;bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
Armor Property iDDe_BumbeeArmbinder_Inv Auto
Armor Property iDDe_BumbeeElbowbinder_Inv Auto
Armor Property iDDe_BumbeeBoxbinder_Inv Auto
Armor Property iDDe_BumbeeBoxbinderOut_Inv Auto
Armor Property iDDe_BumbeeBeltChain_Inv Auto
Armor Property iDDe_BumbeeBelt_Inv Auto
Armor Property iDDe_BumbeeGagBit_Inv Auto
Armor Property iDDe_BumbeeBlindfold_Inv Auto
Armor Property iDDe_BumbeeBra_Inv Auto
Armor Property iDDe_BumbeeCollar_Inv Auto
Armor Property iDDe_BumbeeCollarPosture_Inv Auto
Armor Property iDDe_BumbeeCuffsArms_Inv Auto
Armor Property iDDe_BumbeeCuffsCollar_Inv Auto
Armor Property iDDe_BumbeeCuffsLegs_Inv Auto
Armor Property iDDe_BumbeeGagHarnessBall_Inv Auto
Armor Property iDDe_BumbeeHarnessCollar_Inv Auto
Armor Property iDDe_BumbeeHarnessBody_Inv Auto
Armor Property iDDe_BumbeeGagHarnessRing_Inv Auto
Armor Property iDDe_BumbeePonyBoots_Inv Auto
Armor Property iDDe_BumbeeRingShoes_Inv Auto
Armor Property iDDe_BumbeeShacklesArms_Inv Auto
Armor Property iDDe_BumbeeShacklesLegs_Inv Auto
Armor Property iDDe_BumbeePlugSoulGemAn_Inv Auto
Armor Property iDDe_BumbeePlugSoulGemVg_Inv Auto
Armor Property iDDe_BumbeeGagStrapBall_Inv Auto
Armor Property iDDe_BumbeeGagStrapRing_Inv Auto
Armor Property iDDe_BumbeeYoke_Inv Auto
Armor Property iDDe_BumbeeYokeZbf_Inv Auto
Armor Property iDDe_BumbeeBondageMittensPaw_Inv Auto
Armor Property iDDe_BumbeeHobbleDressElegant_Inv Auto
Armor Property iDDe_BumbeeHobbleDress_Inv Auto
Armor Property iDDe_BumbeeHobbleDressOpen_Inv Auto
Armor Property iDDe_BumbeeSlaveHighHeels_Inv Auto
Armor Property iDDe_BumbeeHobbleDressLatex_Inv Auto
Armor Property iDDe_BumbeeHobbleDressOpenLatex_Inv Auto
Armor Property iDDe_BumbeeIronMask_Inv Auto
Armor Property iDDe_BumbeeCatSuit_Inv Auto
Armor Property iDDe_BumbeeCatGloves_Inv Auto
Armor Property iDDe_BumbeeCatHood_Inv Auto
;bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb

;iDDe Keywords
;iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
Keyword Property iDDe_DeviousBondageMittens Auto
Keyword Property iDDe_DeviousBoxbinder Auto

;ZaZ Animation Pack Keywords
;zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
Keyword Property zbfWornYoke Auto
Keyword Property zbfWornWrist Auto
Keyword Property zbfWornCollar Auto
Keyword Property zbfWornGag Auto
Keyword Property zbfWornAnkles Auto
Keyword Property zbfWornDevice Auto 

;SexLab Keywords
;sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss
Keyword Property SexLabNoStrip Auto

;iSUM keywords
;iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
Keyword Property iSUmKwdWornMech Auto

;Perks
;ppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp
;iDDe
Perk Property iDDe_PerkDeflectArrows Auto
Perk Property iDDe_PerkNoFallingDamage Auto
Perk Property iDDe_PerkHeavyBondage Auto
;Other
Perk Property zad_BoundActivation Auto
