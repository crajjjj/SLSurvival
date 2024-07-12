Scriptname SuccubusFeedScript Extends Perk Hidden

SexLabFramework Property SexLab Auto
Spell Property SuccubusFeedSelfCalm Auto
EffectShader Property GhostFXShader Auto

;Charm Feed
Function Fragment_1(ObjectReference akTargetRef, Actor akActor)
	Actor akTarget = akTargetRef as Actor
	ChooseSex(akTarget)
EndFunction

;Force Feed
Function Fragment_2(ObjectReference akTargetRef, Actor akActor)
	Actor akTarget = akTargetRef as Actor
	ChooseSex(akTarget)
EndFunction

;Sneak Feed
Function Fragment_3(ObjectReference akTargetRef, Actor akActor)
	Actor akTarget = akTargetRef as Actor
	If !SexLab.PlayerRef.IsDetectedBy(akTarget)
		ChooseSex(akTarget)
	Else
		Debug.Notification("$PSQ_DetectedFail")
	EndIf
EndFunction

;Follower Feed
Function Fragment_4(ObjectReference akTargetRef, Actor akActor)
	Actor akTarget = akTargetRef as Actor
	ChooseSex(akTarget)
EndFunction

;Sleeping Feed
Function Fragment_5(ObjectReference akTargetRef, Actor akActor)
	Actor akTarget = akTargetRef as Actor
	ChooseSex(akTarget)
EndFunction

;Contract
Function Fragment_6(ObjectReference akTargetRef, Actor akActor)
	Actor akTarget = akTargetRef as Actor
	akTarget.Activate(akTarget)
	ChooseSex(akTarget)
EndFunction

;Charge
Function Fragment_7(ObjectReference akTargetRef, Actor akActor)
	Actor akTarget = akTargetRef as Actor
		UIMenuBase menuBase = UIExtensions.GetMenu("UITextEntryMenu")
		menuBase.OpenMenu()
		Float Ret = menuBase.GetResultString() as Float
		StorageUtil.SetFloatValue(akTarget, "PSQ_ChargeValue", Ret)
	ChooseSex(akTarget)
EndFunction

;Switch Astral Effect
Function Fragment_8(ObjectReference akTargetRef, Actor akActor)
	Actor akTarget = akTargetRef as Actor
	If StorageUtil.GetIntValue(akTarget, "PSQ_AstralEffectNone") == 0
		StorageUtil.SetIntValue(akTarget, "PSQ_AstralEffectNone", 1)
		GhostFXShader.Stop(akTarget)
		akTarget.SetAlpha (1.0)
	Else
		StorageUtil.SetIntValue(akTarget, "PSQ_AstralEffectNone", 0)
		GhostFXShader.Play(akTarget)
		akTarget.SetAlpha (0.3)
	EndIf
EndFunction

Function ChooseSex(Actor SexActor)
	If Game.GetFormFromFile(0xE00, "UIExtensions.esp") != None
		UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
		
		Actor[] SexActors = New Actor[2]
		sslBaseAnimation[] anims
		
		String[] tOptions =  New String[2]
		tOptions[0] = "Female Position"	+ ";;" + -1 + ";;" +   1 + ";;" +  0 + ";;0"
		tOptions[1] = "Male Position"	+ ";;" + -1 + ";;" +   2 + ";;" +  1 + ";;0"
		
		ListMenu.SetPropertyStringA("appendEntries", tOptions)
		ListMenu.OpenMenu()
		
		Int sButton = Listmenu.GetResultInt()
		If sButton == 1
			SexActors[0] = SexLab.PlayerRef
			SexActors[1] = SexActor
		ElseIf sButton == 2
			SexActors[0] = SexActor
			SexActors[1] = SexLab.PlayerRef
		EndIf
		
		;/
		ListMenu.ResetMenu()
		String[] Tags = New String[3]
		String[] TagEntry = GetTagEntry()
		ListMenu.SetPropertyStringA("appendEntries", TagEntry)
		
		Int i = 0
		While i < 3
			ListMenu.OpenMenu()
			
			sButton = Listmenu.GetResultInt()
			If sButton == 10
				Tags[i] = ""
				i = 666
			Else
				Tags[i] = GetTagResult(sButton)
			EndIf
			
			i += 1
		EndWhile
		
		If Tags[0] != ""
			anims = SexLab.GetAnimationsByTag (2, Tags[0], Tags[1], Tags[2])
		EndIf
		/;
		
		SexLab.StartSex(SexActors, anims, Victim = SexActor)
	EndIf
EndFunction

String[] Function GetTagEntry()
	String[] sOptions =  New String[102]
	sOptions[0]   = "Act"				+ ";;" + -1 + ";;" +   1 + ";;" +  0 + ";;1"
	sOptions[1]   = "Organ"				+ ";;" + -1 + ";;" +   2 + ";;" +  1 + ";;1"
	sOptions[2]   = "SexPosition"		+ ";;" + -1 + ";;" +   3 + ";;" +  2 + ";;1"
	sOptions[3]   = "Sex"				+ ";;" + -1 + ";;" +   4 + ";;" +  3 + ";;1"
	sOptions[4]   = "Behavior"			+ ";;" + -1 + ";;" +   5 + ";;" +  4 + ";;1"
	sOptions[5]   = "Cum"				+ ";;" + -1 + ";;" +   6 + ";;" +  5 + ";;1"
	sOptions[6]   = "Misc"				+ ";;" + -1 + ";;" +   7 + ";;" +  6 + ";;1"
	sOptions[7]   = "Author"			+ ";;" + -1 + ";;" +   8 + ";;" +  7 + ";;1"
	sOptions[8]   = "Aggressive"		+ ";;" + -1 + ";;" +   9 + ";;" +  8 + ";;0"
	sOptions[9]   = "None"				+ ";;" + -1 + ";;" +  10 + ";;" +  9 + ";;0"
	
	sOptions[10]  = "Sex"				+ ";;" +  1 + ";;" +  20 + ";;" +  0 + ";;0"
	sOptions[11]  = "Foreplay"			+ ";;" +  1 + ";;" +  21 + ";;" +  1 + ";;0"
	sOptions[12]  = "Licking"			+ ";;" +  1 + ";;" +  22 + ";;" +  2 + ";;0"
	sOptions[13]  = "Cunnilingus"		+ ";;" +  1 + ";;" +  23 + ";;" +  3 + ";;0"
	sOptions[14]  = "Petting"			+ ";;" +  1 + ";;" +  24 + ";;" +  4 + ";;0"
	sOptions[15]  = "Blowjob"			+ ";;" +  1 + ";;" +  25 + ";;" +  5 + ";;0"
	sOptions[16]  = "Handjob"			+ ";;" +  1 + ";;" +  26 + ";;" +  6 + ";;0"
	sOptions[17]  = "Boobjob"			+ ";;" +  1 + ";;" +  27 + ";;" +  7 + ";;0"
	sOptions[18]  = "Footjob"			+ ";;" +  1 + ";;" +  28 + ";;" +  8 + ";;0"
	sOptions[19]  = "Breastfeeding"		+ ";;" +  1 + ";;" +  29 + ";;" +  9 + ";;0"
	sOptions[20]  = "Kneeling"			+ ";;" +  1 + ";;" +  30 + ";;" + 10 + ";;0"
	sOptions[21]  = "Fisting"			+ ";;" +  1 + ";;" +  31 + ";;" + 11 + ";;0"
	sOptions[22]  = "Fondling"			+ ";;" +  1 + ";;" +  32 + ";;" + 12 + ";;0"
	sOptions[23]  = "69"				+ ";;" +  1 + ";;" +  33 + ";;" + 13 + ";;0"
	
	sOptions[24]  = "Vaginal"			+ ";;" +  2 + ";;" +  40 + ";;" +  0 + ";;0"
	sOptions[25]  = "Pussy"				+ ";;" +  2 + ";;" +  41 + ";;" +  1 + ";;0"
	sOptions[26]  = "Anal"				+ ";;" +  2 + ";;" +  42 + ";;" +  2 + ";;0"
	sOptions[27]  = "Hands"				+ ";;" +  2 + ";;" +  43 + ";;" +  3 + ";;0"
	sOptions[28]  = "Dick"				+ ";;" +  2 + ";;" +  44 + ";;" +  4 + ";;0"
	sOptions[29]  = "Penis"				+ ";;" +  2 + ";;" +  45 + ";;" +  5 + ";;0"
	sOptions[30]  = "Oral"				+ ";;" +  2 + ";;" +  46 + ";;" +  6 + ";;0"
	sOptions[31]  = "Mouth"				+ ";;" +  2 + ";;" +  47 + ";;" +  7 + ";;0"
	sOptions[32]  = "Breast"			+ ";;" +  2 + ";;" +  48 + ";;" +  8 + ";;0"
	sOptions[33]  = "Boobs"				+ ";;" +  2 + ";;" +  49 + ";;" +  9 + ";;0"
	sOptions[34]  = "Feet"				+ ";;" +  2 + ";;" +  50 + ";;" + 10 + ";;0"
	sOptions[35]  = "Knees"				+ ";;" +  2 + ";;" +  51 + ";;" + 11 + ";;0"
	
	sOptions[36]  = "Missionary"		+ ";;" +  3 + ";;" +  60 + ";;" +  0 + ";;0"
	sOptions[37]  = "Cowgirl"			+ ";;" +  3 + ";;" +  61 + ";;" +  1 + ";;0"
	sOptions[38]  = "ReverseCowgirl"	+ ";;" +  3 + ";;" +  62 + ";;" +  2 + ";;0"
	sOptions[39]  = "RCowgirl"			+ ";;" +  3 + ";;" +  63 + ";;" +  3 + ";;0"
	sOptions[40]  = "Riding"			+ ";;" +  3 + ";;" +  64 + ";;" +  4 + ";;0"
	sOptions[41]  = "Doggystyle"		+ ";;" +  3 + ";;" +  65 + ";;" +  5 + ";;0"
	sOptions[42]  = "Doggy"				+ ";;" +  3 + ";;" +  66 + ";;" +  6 + ";;0"
	sOptions[43]  = "Standing"			+ ";;" +  3 + ";;" +  67 + ";;" +  7 + ";;0"
	sOptions[44]  = "Sitting"			+ ";;" +  3 + ";;" +  68 + ";;" +  8 + ";;0"
	sOptions[45]  = "Hugging"			+ ";;" +  3 + ";;" +  69 + ";;" +  9 + ";;0"
	sOptions[46]  = "Cuddling"			+ ";;" +  3 + ";;" +  70 + ";;" + 10 + ";;0"
	sOptions[47]  = "Holding"			+ ";;" +  3 + ";;" +  71 + ";;" + 11 + ";;0"
	sOptions[48]  = "Facing"			+ ";;" +  3 + ";;" +  72 + ";;" + 12 + ";;0"
	sOptions[49]  = "Kissing"			+ ";;" +  3 + ";;" +  73 + ";;" + 13 + ";;0"
	sOptions[50]  = "Laying"			+ ";;" +  3 + ";;" +  74 + ";;" + 14 + ";;0"
	sOptions[51]  = "Lying"				+ ";;" +  3 + ";;" +  75 + ";;" + 15 + ";;0"
	sOptions[52]  = "Reverse"			+ ";;" +  3 + ";;" +  76 + ";;" + 16 + ";;0"
	sOptions[53]  = "OnBack"			+ ";;" +  3 + ";;" +  77 + ";;" + 17 + ";;0"
	sOptions[54]  = "Behind"			+ ";;" +  3 + ";;" +  78 + ";;" + 18 + ";;0"
	sOptions[55]  = "Sleeping"			+ ";;" +  3 + ";;" +  79 + ";;" + 19 + ";;0"
	sOptions[56]  = "Sideways"			+ ";;" +  3 + ";;" +  80 + ";;" + 20 + ";;0"
	sOptions[57]  = "Spooning"			+ ";;" +  3 + ";;" +  81 + ";;" + 21 + ";;0"
	sOptions[58]  = "Binding"			+ ";;" +  3 + ";;" +  82 + ";;" + 22 + ";;0"
	sOptions[59]  = "Acrobatic"			+ ";;" +  3 + ";;" +  83 + ";;" + 23 + ";;0"
	
	sOptions[60]  = "FF"				+ ";;" +  4 + ";;" +  90 + ";;" +  0 + ";;0"
	sOptions[61]  = "MF"				+ ";;" +  4 + ";;" +  91 + ";;" +  1 + ";;0"
	sOptions[62]  = "MM"				+ ";;" +  4 + ";;" +  92 + ";;" +  2 + ";;0"
	sOptions[63]  = "Lesbian"			+ ";;" +  4 + ";;" +  93 + ";;" +  3 + ";;0"
	sOptions[64]  = "Straight"			+ ";;" +  4 + ";;" +  94 + ";;" +  4 + ";;0"
	
	sOptions[65]  = "Loving"			+ ";;" +  5 + ";;" + 100 + ";;" +  0 + ";;0"
	sOptions[66]  = "Dirty"				+ ";;" +  5 + ";;" + 101 + ";;" +  1 + ";;0"
	sOptions[67]  = "Fetish"			+ ";;" +  5 + ";;" + 102 + ";;" +  2 + ";;0"
	sOptions[68]  = "Rough"				+ ";;" +  5 + ";;" + 103 + ";;" +  3 + ";;0"
	
	sOptions[69]  = "Creampie"			+ ";;" +  6 + ";;" + 110 + ";;" +  0 + ";;0"
	sOptions[70]  = "AnalCreampie"		+ ";;" +  6 + ";;" + 111 + ";;" +  1 + ";;0"
	sOptions[71]  = "VaginalCum"		+ ";;" +  6 + ";;" + 112 + ";;" +  2 + ";;0"
	sOptions[72]  = "AnalCum"			+ ";;" +  6 + ";;" + 113 + ";;" +  3 + ";;0"
	sOptions[73]  = "Facial"			+ ";;" +  6 + ";;" + 114 + ";;" +  4 + ";;0"
	sOptions[74]  = "CumInMouth"		+ ";;" +  6 + ";;" + 115 + ";;" +  5 + ";;0"
	sOptions[75]  = "ChestCum"			+ ";;" +  6 + ";;" + 116 + ";;" +  6 + ";;0"
	sOptions[76]  = "HandsCum"			+ ";;" +  6 + ";;" + 117 + ";;" +  7 + ";;0"
	sOptions[77]  = "FeetCum"			+ ";;" +  6 + ";;" + 118 + ";;" +  8 + ";;0"
	sOptions[78]  = "EatingCum"			+ ";;" +  6 + ";;" + 119 + ";;" +  9 + ";;0"
	
	sOptions[79]  = "Default"			+ ";;" +  7 + ";;" + 120 + ";;" +  0 + ";;0"
	sOptions[80]  = "LeadIn"			+ ";;" +  7 + ";;" + 121 + ";;" +  1 + ";;0"
	sOptions[81]  = "Beds"				+ ";;" +  7 + ";;" + 122 + ";;" +  2 + ";;0"
	sOptions[82]  = "BedOnly"			+ ";;" +  7 + ";;" + 123 + ";;" +  3 + ";;0"
	sOptions[83]  = "Furniture"			+ ";;" +  7 + ";;" + 124 + ";;" +  4 + ";;0"
	sOptions[84]  = "DomSub"			+ ";;" +  7 + ";;" + 125 + ";;" +  5 + ";;0"
	sOptions[85]  = "Forced"			+ ";;" +  7 + ";;" + 126 + ";;" +  6 + ";;0"
	sOptions[86]  = "Powerbomb"			+ ";;" +  7 + ";;" + 127 + ";;" +  7 + ";;0"
	sOptions[87]  = "Muscle"			+ ";;" +  7 + ";;" + 128 + ";;" +  8 + ";;0"
	sOptions[88]  = "AggressiveDefault"	+ ";;" +  7 + ";;" + 129 + ";;" +  9 + ";;0"
	sOptions[89]  = "SexToy"			+ ";;" +  7 + ";;" + 130 + ";;" + 10 + ";;0"
	sOptions[90]  = "AnimObject"		+ ";;" +  7 + ";;" + 131 + ";;" + 11 + ";;0"
	
	sOptions[91]  = "3jiou"				+ ";;" +  8 + ";;" + 140 + ";;" +  0 + ";;0"
	sOptions[92]  = "4uDIK"				+ ";;" +  8 + ";;" + 141 + ";;" +  1 + ";;0"
	sOptions[93]  = "AP"				+ ";;" +  8 + ";;" + 142 + ";;" +  2 + ";;0"
	sOptions[94]  = "Arrok"				+ ";;" +  8 + ";;" + 143 + ";;" +  3 + ";;0"
	sOptions[95]  = "Athstai"			+ ";;" +  8 + ";;" + 144 + ";;" +  4 + ";;0"
	sOptions[96]  = "Bleagh"			+ ";;" +  8 + ";;" + 145 + ";;" +  5 + ";;0"
	sOptions[97]  = "FalloutBoy2"		+ ";;" +  8 + ";;" + 146 + ";;" +  6 + ";;0"
	sOptions[98]  = "M2M"				+ ";;" +  8 + ";;" + 147 + ";;" +  7 + ";;0"
	sOptions[99]  = "Mitos"				+ ";;" +  8 + ";;" + 148 + ";;" +  8 + ";;0"
	sOptions[100] = "Leito"				+ ";;" +  8 + ";;" + 149 + ";;" +  9 + ";;0"
	sOptions[101] = "Zyn"				+ ";;" +  8 + ";;" + 150 + ";;" + 10 + ";;0"
	Return sOptions
EndFunction

String Function GetTagResult(Int i)
	String TagResult
	If i == 9
		TagResult = "Aggressive"
	ElseIf i == 20
		TagResult = "Sex"
	ElseIf i == 21
		TagResult = "Foreplay"
	ElseIf i == 22
		TagResult = "Licking"
	ElseIf i == 23
		TagResult = "Cunnilingus"
	ElseIf i == 24
		TagResult = "Petting"
	ElseIf i == 25
		TagResult = "Blowjob"
	ElseIf i == 26
		TagResult = "Handjob"
	ElseIf i == 27
		TagResult = "Boobjob"
	ElseIf i == 28
		TagResult = "Footjob"
	ElseIf i == 29
		TagResult = "Breastfeeding"
	ElseIf i == 30
		TagResult = "Kneeling"
	ElseIf i == 31
		TagResult = "Fisting"
	ElseIf i == 32
		TagResult = "Fondling"
	ElseIf i == 33
		TagResult = "69"
	ElseIf i == 40
		TagResult = "Vaginal"
	ElseIf i == 41
		TagResult = "Pussy"
	ElseIf i == 42
		TagResult = "Anal"
	ElseIf i == 43
		TagResult = "Hands"
	ElseIf i == 44
		TagResult = "Dick"
	ElseIf i == 45
		TagResult = "Penis"
	ElseIf i == 46
		TagResult = "Oral"
	ElseIf i == 47
		TagResult = "Mouth"
	ElseIf i == 48
		TagResult = "Breast"
	ElseIf i == 49
		TagResult = "Boobs"
	ElseIf i == 50
		TagResult = "Feet"
	ElseIf i == 51
		TagResult = "Knees"
	ElseIf i == 60
		TagResult = "Missionary"
	ElseIf i == 61
		TagResult = "Cowgirl"
	ElseIf i == 62
		TagResult = "ReverseCowgirl"
	ElseIf i == 63
		TagResult = "RCowgirl"
	ElseIf i == 64
		TagResult = "Riding"
	ElseIf i == 65
		TagResult = "Doggystyle"
	ElseIf i == 66
		TagResult = "Doggy"
	ElseIf i == 67
		TagResult = "Standing"
	ElseIf i == 68
		TagResult = "Sitting"
	ElseIf i == 69
		TagResult = "Hugging"
	ElseIf i == 70
		TagResult = "Cuddling"
	ElseIf i == 71
		TagResult = "Holding"
	ElseIf i == 72
		TagResult = "Facing"
	ElseIf i == 73
		TagResult = "Kissing"
	ElseIf i == 74
		TagResult = "Laying"
	ElseIf i == 75
		TagResult = "Lying"
	ElseIf i == 76
		TagResult = "Reverse"
	ElseIf i == 77
		TagResult = "OnBack"
	ElseIf i == 78
		TagResult = "Behind"
	ElseIf i == 79
		TagResult = "Sleeping"
	ElseIf i == 80
		TagResult = "Sideways"
	ElseIf i == 81
		TagResult = "Spooning"
	ElseIf i == 82
		TagResult = "Binding"
	ElseIf i == 83
		TagResult = "Acrobatic"
	ElseIf i == 90
		TagResult = "FF"
	ElseIf i == 91
		TagResult = "MF"
	ElseIf i == 92
		TagResult = "MM"
	ElseIf i == 93
		TagResult = "Lesbian"
	ElseIf i == 94
		TagResult = "Straight"
	ElseIf i == 100
		TagResult = "Loving"
	ElseIf i == 101
		TagResult = "Dirty"
	ElseIf i == 102
		TagResult = "Fetish"
	ElseIf i == 103
		TagResult = "Rough"
	ElseIf i == 110
		TagResult = "Creampie"
	ElseIf i == 111
		TagResult = "AnalCreampie"
	ElseIf i == 112
		TagResult = "VaginalCum"
	ElseIf i == 113
		TagResult = "AnalCum"
	ElseIf i == 114
		TagResult = "Facial"
	ElseIf i == 115
		TagResult = "CumInMouth"
	ElseIf i == 116
		TagResult = "ChestCum"
	ElseIf i == 117
		TagResult = "HandsCum"
	ElseIf i == 118
		TagResult = "FeetCum"
	ElseIf i == 119
		TagResult = "EatingCum"
	ElseIf i == 120
		TagResult = "Default"
	ElseIf i == 121
		TagResult = "LeadIn"
	ElseIf i == 122
		TagResult = "Beds"
	ElseIf i == 123
		TagResult = "BedOnly"
	ElseIf i == 124
		TagResult = "Furniture"
	ElseIf i == 125
		TagResult = "DomSub"
	ElseIf i == 126
		TagResult = "Forced"
	ElseIf i == 127
		TagResult = "Powerbomb"
	ElseIf i == 128
		TagResult = "Muscle"
	ElseIf i == 129
		TagResult = "AggressiveDefault"
	ElseIf i == 130
		TagResult = "SexToy"
	ElseIf i == 131
		TagResult = "AnimObject"
	ElseIf i == 140
		TagResult = "3jiou"
	ElseIf i == 141
		TagResult = "4uDIK"
	ElseIf i == 142
		TagResult = "AP"
	ElseIf i == 143
		TagResult = "Arrok"
	ElseIf i == 144
		TagResult = "Athstai"
	ElseIf i == 145
		TagResult = "Bleagh"
	ElseIf i == 146
		TagResult = "FalloutBoy2"
	ElseIf i == 147
		TagResult = "M2M"
	ElseIf i == 148
		TagResult = "Mitos"
	ElseIf i == 149
		TagResult = "Leito"
	ElseIf i == 150
		TagResult = "Zyn"
	EndIf
	Return TagResult
EndFunction
