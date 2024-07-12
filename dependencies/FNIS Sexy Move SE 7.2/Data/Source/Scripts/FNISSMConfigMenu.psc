Scriptname FNISSMConfigMenu extends SKI_ConfigBase  

FNISSMQuestScript Property FNISSMquest Auto

int OId1
int OId2
int OId3
int OId4
int OId5
int OId6
int OId7
int OId8
int OId9
int OId10
int OId11
int OId12
int OId13
int OId14
int OId15
int OId16
int OId17

bool[] SMno
int SMnoTotal
int SMnoMax

bool[] SMweight
int iSMweight

bool[] SMplayer
int[] OidPlayer
int iSMplayer

bool SMarmor
bool SMdialog
bool SMoff
bool SMnocoin
bool SM360

bool isConfigChangedNPC = false
bool isPlayerFemale
bool ONCE = TRUE

Event OnPageReset(string page)
	if ( FNISSMquest.StartUpStatus <= 0 )
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("ERRORS when starting FNIS Sexy Move")
		return
	endif
	
	If ONCE
		; preset "No Sexy moves NPC"
		SMno = FNISSMQuest.SMno				; Initial "No Sexy Move 1"
		SMnoTotal = FNISSMQuest.SMnoTotal	; one move preset
		SMnoMax = 3							; max 3 noMoves
		; preset "Move assignment"
		SMweight = new bool[3]
		iSMweight = FNISSMQuest.iSMweight	; Initial "Average Move assignment"
		SMweight[iSMweight] = true
		; preset "player move"
		SMplayer = new bool[10]
		OidPlayer = new int[10]
		iSMplayer = FNISSMQuest.iSMplayer	; Initial "Player Move 5 (NAP)"
		SMplayer[iSMplayer] = true
		; preset 360 style
		SM360 = FNISSMQuest.SM360			; Initial "Player moves 360 style"
		; preset armor weighting
		SMarmor = FNISSMQuest.SMarmor		; Initial "Armor equipped females equally sexy"
		; preset assignment dialog
		SMdialog = FNISSMQuest.SMdialog		; Initial "No assignment dialog"
		; preset SM temporarily off
		SMoff = FNISSMQuest.SMoff			; Initial "SM temporarily off" 
		; preset no coin
		SMnocoin = FNISSMQuest.SMnocoin		; Initial "no coin" (no coin = don't remember NPC changes")
		
		ONCE = false
	endIf
	isPlayerFemale = ( Game.GetPlayer().GetLeveledActorBase().GetSex() == 1 )
	
    SetCursorFillMode(TOP_TO_BOTTOM)
	AddHeaderOption("Don't use certain NPC moves (max. 3)")
	Oid1 = AddToggleOption("No Sexy Move 1 (female animation)", SMno[1])
	Oid2 = AddToggleOption("No Sexy Move 2 (a bit sexy)", SMno[2])
	Oid3 = AddToggleOption("No Sexy Move 3", SMno[3])
	Oid4 = AddToggleOption("No Sexy Move 4", SMno[4])
	Oid5 = AddToggleOption("No Sexy Move 5", SMno[5])
	Oid6 = AddToggleOption("No Sexy Move 6", SMno[6])
	Oid7 = AddToggleOption("No Sexy Move 7", SMno[7])
	Oid8 = AddToggleOption("No Sexy Move 8", SMno[8])
	Oid9 = AddToggleOption("No Sexy Move 9 (very sexy)", SMno[9])
	
	If isPlayerFemale
		AddEmptyOption()
	else
		SetCursorPosition(1)
	endIf
	
	AddHeaderOption("Average Move assignments")
	OId10 = AddToggleOption("less sexy", SMweight[0])
	OId11 = AddToggleOption("equally distributed", SMweight[1])
	OId12 = AddToggleOption("more sexy", SMweight[2])

	AddEmptyOption()
	OId13 = AddToggleOption("Armored NPCs less sexy", SMarmor)

	If isPlayerFemale
		SetCursorPosition(1)
		if ( FNISSMquest.FNISs3ModID < 0 )
			OId17 = AddToggleOption("360 pack NOT INSTALLED", false, OPTION_FLAG_DISABLED)
			SM360 = false
		else
			OId17 = AddToggleOption("Player moves 360 style", SM360)
		endif
		AddEmptyOption()
		AddHeaderOption("Player Movement")
		OidPlayer[0] = AddToggleOption("No Sexy Move (use default)", SMplayer[0])
		OidPlayer[1] = AddToggleOption("Sexy Move 1 (female animation)", SMplayer[1])
		OidPlayer[2] = AddToggleOption("Sexy Move 2 (a bit sexy)", SMplayer[2])
		OidPlayer[3] = AddToggleOption("Sexy Move 3", SMplayer[3])
		OidPlayer[4] = AddToggleOption("Sexy Move 4", SMplayer[4])
		OidPlayer[5] = AddToggleOption("Sexy Move 5", SMplayer[5])
		OidPlayer[6] = AddToggleOption("Sexy Move 6", SMplayer[6])
		OidPlayer[7] = AddToggleOption("Sexy Move 7", SMplayer[7])
		OidPlayer[8] = AddToggleOption("Sexy Move 8", SMplayer[8])
		OidPlayer[9] = AddToggleOption("Sexy Move 9 (very sexy)", SMplayer[9])
		
	endIf

	AddEmptyOption()
	OId14 = AddToggleOption("NPC assignment dialog", SMdialog)

	AddEmptyOption()
	OId15 = AddToggleOption("NPC walk assignments temporarily off", SMoff)

	AddEmptyOption()
	OId16 = AddToggleOption("No need to remember NPC assignments", SMnocoin)
endEvent

event OnOptionSelect(int option)
	; "No sexy move" options
    If (option == OId1)
		SMno[1] = set_SMno(OId1, SMno[1])
    elseIf (option == OId2)
		SMno[2] = set_SMno(OId2, SMno[2])
    elseIf (option == OId3)
		SMno[3] = set_SMno(OId3, SMno[3])
    elseIf (option == OId4)
		SMno[4] = set_SMno(OId4, SMno[4])
    elseIf (option == OId5)
		SMno[5] = set_SMno(OId5, SMno[5])
    elseIf (option == OId6)
		SMno[6] = set_SMno(OId6, SMno[6])
    elseIf (option == OId7)
		SMno[7] = set_SMno(OId7, SMno[7])
    elseIf (option == OId8)
		SMno[8] = set_SMno(OId8, SMno[8])
    elseIf (option == OId9)
		SMno[9] = set_SMno(OId9, SMno[9])

	; "Move assignment" options
	elseIf (option == OId10)
		set_SMweight(OId10, 0)
    elseIf (option == OId11)
		set_SMweight(OId11, 1)
    elseIf (option == OId12)
		set_SMweight(OId12, 2)

	; "Armor weighting" option
	elseIf (option == OId13)
		SMarmor = !SMarmor
		SetToggleOptionValue(OId13, SMarmor)
		isConfigChangedNPC = true

	; "Assignment dialog" option
	elseIf (option == OId14)
		SMdialog = !SMdialog
		SetToggleOptionValue(OId14, SMdialog)

	; "Temporarily off" option
	elseIf (option == OId15)
		SMoff = !SMoff
		SetToggleOptionValue(OId15, SMoff)

	; "No remember" option ("no coin")
	elseIf (option == OId16)
		SMnocoin = !SMnocoin
		SetToggleOptionValue(OId16, SMnocoin)

	; "Player Move" options
	elseIf isPlayerFemale
		If (option == OidPlayer[0])
			set_SMPlayer(0)
		elseIf (option == OidPlayer[1])
			set_SMPlayer(1)
		elseIf (option == OidPlayer[2])
			set_SMPlayer(2)
		elseIf (option == OidPlayer[3])
			set_SMPlayer(3)
		elseIf (option == OidPlayer[4])
			set_SMPlayer(4)
		elseIf (option == OidPlayer[5])
			set_SMPlayer(5)
		elseIf (option == OidPlayer[6])
			set_SMPlayer(6)
		elseIf (option == OidPlayer[7])
			set_SMPlayer(7)
		elseIf (option == OidPlayer[8])
			set_SMPlayer(8)
		elseIf (option == OidPlayer[9])
			set_SMPlayer(9)
	; "Player 360 style" option
		elseIf (option == OId17)
			SM360 = !SM360
		SetToggleOptionValue(OId17, SM360)
		endIf
    endIf
endEvent

Event OnConfigClose()
	; Options passed to Quest script
	If isConfigChangedNPC
		FNISSMquest.SMno = SMno
		FNISSMquest.iSMweight = iSMweight
		FNISSMquest.SMarmor = SMarmor
		FNISSMquest.isConfigChangedNPC = true
		isConfigChangedNPC = false
	endIf
	If ( FNISSMquest.iSMplayer != iSMplayer ) || ( FNISSMquest.SM360 != SM360 )
		FNISSMquest.iSMplayer = iSMplayer
		FNISSMquest.SM360 = SM360
		If isPlayerFemale
			bool bOk
			if ( iSMPlayer == 0 )
				bOk = FNIS_aa.SetAnimGroup(Game.GetPlayer(), "_mt", 0, 0, "FNIS Sexy Move", true)
				bOk = bOk && FNIS_aa.SetAnimGroup(Game.GetPlayer(), "_mtx", 0, 0, "FNIS Sexy Move", true)
			else
				if ( SM360 && ( FNISSMquest.FNISs3ModID >= 0 ))
					bOk = FNIS_aa.SetAnimGroup(Game.GetPlayer(), "_mt", FNISSMQuest.FNISs3MtBase, iSMPlayer - 1, "FNIS Sexy Move(360)", true)
					bOk = bOk && FNIS_aa.SetAnimGroup(Game.GetPlayer(), "_mtx", FNISSMQuest.FNISs3MtxBase, iSMPlayer - 1, "FNIS Sexy Move(360)")
				else
					bOk = FNIS_aa.SetAnimGroup(Game.GetPlayer(), "_mt", FNISSMQuest.FNISsmMtBase, iSMPlayer - 1, "FNIS Sexy Move", true)
					bOk = bOk && FNIS_aa.SetAnimGroup(Game.GetPlayer(), "_mtx", FNISSMQuest.FNISsmMtxBase, iSMPlayer - 1, "FNIS Sexy Move", true)
				endif
			endif
			if !bOk
				Debug.Trace("FNISSM - ERROR cannot set player animvar for group _mt/_mtx")
			endIf
		endIf
	endif
	FNISSMquest.SMdialog = SMdialog
	FNISSMquest.SMoff = SMoff
	FNISSMquest.SMnocoin = SMnocoin
endEvent

bool Function set_SMno(int OId, bool Val)
	If ( SMnoTotal < SMnoMax ) || ( ( SMnoTotal == SMnoMax ) && ( Val == True ) )
		SetToggleOptionValue(OId, !Val)
		If Val
			SMnoTotal -= 1
		else
			SMnoTotal += 1
		endIf
		isConfigChangedNPC = true
		return !Val
	else
		return Val
	endIf
endFunction

Function set_SMweight(int OId, int i)
	If ( i != iSMWeight ) 
		SMweight[i] = true
		SMweight[iSMweight] = false
		iSMweight = i
		SetToggleOptionValue(OId10, SMweight[0])
		SetToggleOptionValue(OId11, SMweight[1])
		SetToggleOptionValue(OId12, SMweight[2])
		isConfigChangedNPC = true
	endIf
endFunction

Function set_SMplayer(int i)
	If ( i != iSMplayer ) 
		SMplayer[i] = true
		SetToggleOptionValue(OidPlayer[i], SMplayer[i])
		SMplayer[iSMplayer] = false
		SetToggleOptionValue(OidPlayer[iSMplayer], SMplayer[iSMplayer])
		iSMplayer = i
	endIf
endFunction
