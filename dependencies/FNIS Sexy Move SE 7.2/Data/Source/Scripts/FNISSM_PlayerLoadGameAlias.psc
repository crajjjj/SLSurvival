scriptname FNISSM_PlayerLoadGameAlias extends ReferenceAlias

FNISSMquestScript Property FNISSMquest Auto
Keyword Property ActorTypeNPC Auto

bool DoMaleCheckOnce = true

event OnPlayerLoadGame()
	if ( !FNISSMquest.RequirementsAreMet() )
		FNISSMquest.StartUpStatus = -1
		return
	endif
	FNISSMquest.StartUpStatus = 1

	Debug.Trace("FNIS SexyMove started (load).")

	int currentCRC = FNIS_aa.GetInstallationCRC()
	if ( Game.GetPlayer().GetLeveledActorBase().GetSex() == 1 )
		FNISSMquest.FNISs3ModID = FNIS_aa.GetAAModID("fs3", "FNIS Sexy Move(360)", true)		;Check if 360 pack is installed
	endif
	if ( currentCRC != FNISSMquest.FNISaaCRC)
		FNISSMquest.FNISsmModID = FNIS_aa.GetAAModID("fsm", "FNIS Sexy Move", true)
		FNISSMquest.FNISsmMtBase = FNIS_aa.GetGroupBaseValue(FNISSMquest.FNISsmModID, FNIS_aa._mt(), "FNIS Sexy Move", true)
		FNISSMquest.FNISsmMtxBase = FNIS_aa.GetGroupBaseValue(FNISSMquest.FNISsmModID, FNIS_aa._mtx(), "FNIS Sexy Move", true)
		FNISSMquest.FNISs3ModID = FNIS_aa.GetAAModID("fs3", "FNIS Sexy Move(360)", true)
		if ( FNISSMquest.FNISs3ModID >= 0 )		; 360 pack installed
			FNISSMquest.FNISs3MtBase = FNIS_aa.GetGroupBaseValue(FNISSMquest.FNISs3ModID, FNIS_aa._mt(), "FNIS Sexy Move(360)", true)
			FNISSMquest.FNISs3MtxBase = FNIS_aa.GetGroupBaseValue(FNISSMquest.FNISs3ModID, FNIS_aa._mtx(), "FNIS Sexy Move(360)", true)
		endif
		FNISSMquest.FNISaaCRC = currentCRC
	endif

;;;	Only temporary fix for bug in previous release: reset male movement animation (but only once)
;;; REMOVE THIS PART IN NEXT RELEASE
	if DoMaleCheckOnce
		if ( Game.GetPlayer().GetLeveledActorBase().GetSex() != 1 ) 
			if ( Game.GetPlayer().GetAnimationVariableInt("FNISaa_mt") > 0 )
				FNIS_aa.SetAnimGroup(Game.GetPlayer(), "_mt", 0, 0, "FNIS Sexy Move", true)
			endif
		endif
		DoMaleCheckOnce = false
	endif
endEvent

Event OnCellLoad()
	FNISSMquest.isCellLoaded = true
	if FNISSMquest.DebugLevel > 1
		Debug.Trace("FNISSM LoadCell" + Game.getPlayer().GetParentCell())
	endIf
endEvent

Event OnRaceSwitchComplete()
	if ( Game.GetPlayer().GetLeveledActorBase().GetSex() == 1 )
		Race PlayerRace = Game.GetPlayer().GetRace()
		if PlayerRace.HasKeyword(ActorTypeNPC)			; reset FNIS Alternate Animations after race change to playable race
			if FNISSMquest.SM360
				FNIS_aa.SetAnimGroup(Game.GetPlayer(), "_mt", FNISSMquest.FNISs3MtBase, FNISSMquest.iSMPlayer - 1, "FNIS Sexy Move(360)", true)
				FNIS_aa.SetAnimGroup(Game.GetPlayer(), "_mtx", FNISSMquest.FNISs3MtxBase, FNISSMquest.iSMPlayer - 1, "FNIS Sexy Move(360)", true)
			else
				FNIS_aa.SetAnimGroup(Game.GetPlayer(), "_mt", FNISSMquest.FNISsmMtBase, FNISSMquest.iSMPlayer - 1, "FNIS Sexy Move", true)
				FNIS_aa.SetAnimGroup(Game.GetPlayer(), "_mtx", FNISSMquest.FNISsmMtxBase, FNISSMquest.iSMPlayer - 1, "FNIS Sexy Move", true)
			endif
		endif
		Debug.Trace("FNIS Sexy Move RACE CHANGE: " + PlayerRace.getname())
	endif
endEvent
