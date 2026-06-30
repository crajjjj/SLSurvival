Scriptname mzinTextureUtility extends Quest  

String[] Property TexNames Auto Hidden
String[] Property TexPathsF Auto Hidden
String[] Property TexPathsM Auto Hidden
Int[] Property DirtSetCount Auto Hidden

mzinBatheMCMMenu Property Menu Auto
mzinUtility Property mzinUtil Auto

Event OnInit()
	TexNames = new String[4]
	TexNames[0] = "DirtFXBody.dds"
	TexNames[1] = "DirtFXHands.dds"
	TexNames[2] = "DirtFXFeet.dds"
	TexNames[3] = "DirtFXFace.dds"

	TexPathsF = new String[5]
	TexPathsF[0] = "\\mzin\\Bathe\\Set1\\F\\"
	TexPathsF[1] = "\\mzin\\Bathe\\Set2\\F\\"
	TexPathsF[2] = "\\mzin\\Bathe\\Set3\\F\\"
	TexPathsF[3] = "\\mzin\\Bathe\\Set4\\F\\"
	TexPathsF[4] = "\\mzin\\Bathe\\Set5\\F\\"

	TexPathsM = new String[5]
	TexPathsM[0] = "\\mzin\\Bathe\\Set1\\M\\"
	TexPathsM[1] = "\\mzin\\Bathe\\Set2\\M\\"
	TexPathsM[2] = "\\mzin\\Bathe\\Set3\\M\\"
	TexPathsM[3] = "\\mzin\\Bathe\\Set4\\M\\"
	TexPathsM[4] = "\\mzin\\Bathe\\Set5\\M\\"

	DirtSetCount = new Int[2]
	DirtSetCount[0] = 0
	DirtSetCount[1] = 0
EndEvent

Function UtilInit()
	OnInit()
	DirtSetCount[0] = InitTexSets(0) ; male
	DirtSetCount[1] = InitTexSets(1) ; female
EndFunction

Int Function InitTexSets(int aiSex)
	; this is a relatively heavy function. Should not be run with OnInit()

	Int SetCount
	Int TexCount
	String SetPrefix
	String SetGender = GetStringFromSex(aiSex)
	String[] TexPaths = GetTexPathFromSex(aiSex)
	
	While SetCount < TexPaths.Length
		SetCount += 1
		SetPrefix = "data/Textures/mzin/Bathe/Set" + SetCount + "/" + SetGender + "/"
		TexCount = 0
		While TexCount < TexNames.Length && MiscUtil.FileExists(SetPrefix + TexNames[TexCount])
			Menu.UpdateProgressRedetectDirtSets((TexPaths[SetCount] + TexNames[TexCount]))
			mzinUtil.LogTrace("Verified: " + SetPrefix + TexNames[TexCount])
			TexCount += 1
		EndWhile
		If TexCount == TexNames.Length ; Complete texture set
			mzinUtil.LogTrace("Complete set found!! Set " + SetCount + "(" + SetGender + ")")
		ElseIf TexCount == 0
			mzinUtil.LogTrace("Empty set detected. Ending search")
			Return SetCount - 1
		Else
			mzinUtil.LogTrace("Warning: Dirt Set " + SetCount + ": InitTexSets() halted after receiving a DNE for " + TexNames[TexCount])
			mzinUtil.LogMessageBox("Error: InitTexSets(): Incomplete texture set detected for set " + SetCount + "(" + SetGender + "). There should be " + TexNames.Length + " texture files per set but Mzin detected only " + TexCount + " files. One or more files are either missing or named incorrectly. You need to fix this first! Check your papyrus log. Search 'mzin'")
			Return -1
		EndIf
	EndWhile
	Return SetCount
EndFunction

String Function PickRandomDirtSet(int aiSex, bool abPlayer)
	int iDefault = (1 + (Menu.TexSetOverride as int))
	if DirtSetCount[aiSex] >= iDefault
		if Menu.TexSetOverride && abPlayer
			Return "\\mzin\\Bathe\\Set1\\" + GetStringFromSex(aiSex) + "\\"
		endIf
		return "\\mzin\\Bathe\\Set" + Utility.RandomInt(iDefault, DirtSetCount[aiSex]) + "\\" + GetStringFromSex(aiSex) + "\\"
	else
		return ""
	endIf 
EndFunction

String Function GetStringFromSex(int aiSex)
	if aiSex as bool
		return "F"
	else
		return "M"
	endIf
EndFunction

String[] Function GetTexPathFromSex(int aiSex)
	if aiSex
		return TexPathsF
	else
		return TexPathsM
	endIf
EndFunction
