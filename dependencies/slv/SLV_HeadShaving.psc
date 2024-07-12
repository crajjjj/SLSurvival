Scriptname SLV_HeadShaving extends Quest  

string File

Function ShaveBodyHair()
	if !MCMMenu.SlaveShaving
		return
	endif

	if MCMMenu.ypsFashionShaving
 		SendModEvent("yps-SetPubicHairLengthEvent", "Bleached Blonde" , 0)
 		SendModEvent("yps-SetArmpitsHairLengthEvent", "Bleached Blonde" , 0)
		return
	endif
EndFunction

Function ResetSlaveName(Actor akActor)
	if !MCMMenu.SlaveRenaming
		return
	endif
	if !akActor.isinfaction(slavefaction)
		return
	endif
	String playerName = StorageUtil.GetStringValue(none, "SlaverunPlayerName")
	StorageUtil.SetIntValue(none, "SlaverunPlayerLevel", 0)

	myScripts.SLV_DisplayInformation("Original player name: " + playername)

	akActor.GetActorBase().SetName(playername)
EndFunction

Function SlaveName(Actor akActor)
	if !MCMMenu.SlaveRenaming
		return
	endif
	if !akActor.isinfaction(slavefaction)
		return
	endif

	File = "../Slaverun/SlaverunConfig.json"

	String playername = akActor.GetActorBase().GetName()
	StorageUtil.SetStringValue(none, "SlaverunPlayerName", playername)
	StorageUtil.SetIntValue(none, "SlaverunPlayerLevel", 0)
	String slavename = JsonUtil.GetStringValue(File, "SlaverunSlavename0" ,"the Cocksucker" )

	myScripts.SLV_DisplayInformation("Original player name: " + playername + " new slave name: " + playername + " " + slavename)

	akActor.GetActorBase().SetName(playername + " " + slavename)
EndFunction


Function NextSlaveName(Actor akActor)
	if !MCMMenu.SlaveRenaming
		return
	endif
	if !akActor.isinfaction(slavefaction)
		return
	endif

	File = "../Slaverun/SlaverunConfig.json"
	String playerName = StorageUtil.GetStringValue(none, "SlaverunPlayerName","")
	if playername == ""
		playername = akActor.GetActorBase().GetName()
		StorageUtil.SetStringValue(none, "SlaverunPlayerName", playername)
	endif

	int level = StorageUtil.GetIntValue(none, "SlaverunPlayerLevel",-1)
	level = level + 1
	if level > 9
		level = 0
	endif
	StorageUtil.SetIntValue(none, "SlaverunPlayerLevel", level)

	String slavename = JsonUtil.GetStringValue(File, "SlaverunSlavename" + level ,"the Cocksucker" )

	myScripts.SLV_DisplayInformation("Original player name: " + playername + " new slave name: " + playername + " " + slavename)
		
	akActor.GetActorBase().SetName(playername + " " + slavename)
EndFunction

Function ResetHairShave(Actor akActor)
	if !MCMMenu.SlaveShaving
		return
	endif

	StorageUtil.SetIntValue(none, "SlaverunPlayerRound", 0)
	UnShave(akActor)
EndFunction


Bool Function IsPlayerShaved(Actor akActor)
	String originalhair = StorageUtil.GetStringValue(none, "SlaverunPlayerHair")
	myScripts.SLV_DisplayInformation("Player Hair was:" + originalhair)

	String actualhair = ""

	int hp = akActor.GetActorBase().GetNumHeadParts()
	int i = 0
	WHILE i < hp
		if(akActor.GetActorBase().GetNthHeadPart(i).GetType() == 3)
			actualhair =  akActor.GetActorBase().GetNthHeadPart(i).GetName()
		endif
		i += 1
	EndWHILE

	if originalhair == actualhair || originalhair == ""
		;debug.notification("Player is not shaved") 
		return false
	else
		;debug.notification("Player is shaved") 
		return true
	endif
EndFunction

Function ShaveDeadPlayer(Actor akActor)
	if !MCMMenu.SlaveShaving 
		return
	endif
	if akActor == PlayerRef 
		return
	endif

	if MCMMenu.ypsFashionShaving && akActor == PlayerRef
		SendModEvent("yps-HaircutEvent", "HairFemaleRedguard03" , 1)
		if MCMMenu.ChangeHairColor
			SendModEvent("yps-HairColorBaseEvent", "Bleached Blonde" , 0x00DCD0BA)
			SendModEvent("yps-HairColorDyeEvent", "Bleached Blonde" , 0x00DCD0BA)
		endif
		return
	endif

	File = "../Slaverun/SlaverunConfig.json"
	String haircutname = "SlaverunHairCut0"

	String haircut = JsonUtil.GetStringValue(File, haircutname  ,"HairFemaleRedguard01" )
	HeadPart shavedHair = HeadPart.GetHeadPart(haircut)
	akActor.ChangeHeadPart(shavedHair)
	akActor.RegenerateHead()
EndFunction


Function ShaveNPC(Actor akActor)
	if !MCMMenu.SlaveShaving
		return
	endif

	if MCMMenu.ypsFashionShaving && akActor == PlayerRef
		SendModEvent("yps-HaircutEvent", "HairFemaleRedguard03" , 1)
		if MCMMenu.ChangeHairColor
			SendModEvent("yps-HairColorBaseEvent", "Bleached Blonde" , 0x00DCD0BA)
			SendModEvent("yps-HairColorDyeEvent", "Bleached Blonde" , 0x00DCD0BA)
		endif
		return
	endif

	File = "../Slaverun/SlaverunConfig.json"
	String haircutname = "SlaverunHairCut0"

	String haircut = JsonUtil.GetStringValue(File, haircutname  ,"HairFemaleRedguard01" )
	HeadPart shavedHair = HeadPart.GetHeadPart(haircut)
	akActor.ChangeHeadPart(shavedHair)
	akActor.RegenerateHead()
EndFunction
Actor Property PlayerRef Auto


Function Shave(Actor akActor)
	if !MCMMenu.SlaveShaving
		return
	endif

	if MCMMenu.ypsFashionShaving
		SendModEvent("yps-HaircutEvent", "HairFemaleRedguard03" , 1)  
 		if MCMMenu.ChangeHairColor
			SendModEvent("yps-HairColorBaseEvent", "Bleached Blonde" , 0x00DCD0BA)
			SendModEvent("yps-HairColorDyeEvent", "Bleached Blonde" , 0x00DCD0BA)
		endif
		return
	endif

	;if IsPlayerShaved(akActor)
	;	return
	;endif

	File = "../Slaverun/SlaverunConfig.json"

	String originalhair = ""
	int hp = akActor.GetActorBase().GetNumHeadParts()
	;debug.notification("Player HeadParts Num : "+hp)
	int i = 0
	WHILE i < hp
		;debug.notification("Player HeadPart Type ("+ i +") : " + akActor.GetActorBase().GetNthHeadPart(i).GetType())

		;debug.notification("Player HeadPart Name("+ i +") : " + akActor.GetActorBase().GetNthHeadPart(i).GetName())
		if(akActor.GetActorBase().GetNthHeadPart(i).GetType() == 3)
			originalhair = akActor.GetActorBase().GetNthHeadPart(i).GetName()
			if originalhair != ""
				StorageUtil.SetStringValue(none, "SlaverunPlayerHair", originalhair)
			endif
		endif
		i += 1
	EndWHILE

	;debug.notification("Player Hair was:" + StorageUtil.GetStringValue(none, "SlaverunPlayerHair"))
	myScripts.SLV_DisplayInformation("Player Hair was:" + StorageUtil.GetStringValue(none, "SlaverunPlayerHair"))

	StorageUtil.SetIntValue(none, "SlaverunPlayerRound", 0)
	String haircutname = "SlaverunHairCut0"
	String haircut = JsonUtil.GetStringValue(File, haircutname  ,"HairFemaleRedguard01" )
	HeadPart shavedHair = HeadPart.GetHeadPart(haircut)


	;debug.notification("Player Hair is now:" + haircut)
	myScripts.SLV_DisplayInformation("Player Hair is now:" + haircut)

	akActor.ChangeHeadPart(shavedHair)
	akActor.RegenerateHead()

	; Just tell us when x hours have passed in game
	if MCMMenu.ShaveRegrouthTime
		float hairtime = MCMMenu.ShaveRegrouthTime
		if hairtime < 1.0
			hairtime = 1.0
		endif
		RegisterForSingleUpdateGameTime(hairtime) ; 24 * 1
	else
		 RegisterForSingleUpdateGameTime(6.0) ; 24 * 1
	endif
EndFunction

Event OnUpdateGameTime()
	int round = StorageUtil.GetIntValue(none, "SlaverunPlayerRound")
	round = round + 1
	;Debug.notification("Round :" + round)
	myScripts.SLV_DisplayInformation("Player Hair was:" + StorageUtil.GetStringValue(none, "SlaverunPlayerHair"))

	if MCMMenu.ypsFashionShaving
		return
	endif
	if !MCMMenu.SlaveShaving
		return
	endif

	int maxround = 5
	if MCMMenu.ShaveRegrouthRound
		maxround = MCMMenu.ShaveRegrouthRound
	endif

	StorageUtil.SetIntValue(none, "SlaverunPlayerRound", round)

	if round > maxround
		Debug.notification("Your hair has regrown to its former length")
	    UnShave(Game.GetPlayer())
		return
	endif
		
	Debug.notification("Your hair has regrown a little bit")
	SetHairCutRound(round,Game.GetPlayer())
	if MCMMenu.ShaveRegrouthTime
		float hairtime = MCMMenu.ShaveRegrouthTime
		if hairtime < 1.0
			hairtime = 1.0
		endif
		RegisterForSingleUpdateGameTime(hairtime) ; 24 * 1
	else
		 RegisterForSingleUpdateGameTime(6.0) ; 24 * 1
	endif
endEvent

Function SaveActualHairCut(Actor akActor)
	String originalhair = ""
	myScripts.SLV_DisplayInformation("Saving actual Hair")
	;StorageUtil.SetStringValue(none, "SlaverunPlayerHair", originalhair)
	
	int hp = akActor.GetActorBase().GetNumHeadParts()
	;debug.notification("Player HeadParts Num : "+hp)
	int i = 0
	WHILE i < hp
		;debug.notification("Player HeadPart Type ("+ i +") : " + akActor.GetActorBase().GetNthHeadPart(i).GetType())

		;debug.notification("Player HeadPart Name("+ i +") : " + akActor.GetActorBase().GetNthHeadPart(i).GetName())
		if(akActor.GetActorBase().GetNthHeadPart(i).GetType() == 3)
			originalhair = akActor.GetActorBase().GetNthHeadPart(i).GetName()
			if originalhair != ""
				myScripts.SLV_DisplayInformation("Saved haircut:" + originalhair )
				StorageUtil.SetStringValue(none, "SlaverunPlayerHairStored", originalhair)
			endif
		endif
		i += 1
	EndWHILE
EndFunction

Function RestoreSavedHairCut(Actor akActor)
	String actualhair = ""

	int hp = akActor.GetActorBase().GetNumHeadParts()
	int i = 0
	WHILE i < hp
		if(akActor.GetActorBase().GetNthHeadPart(i).GetType() == 3)
			actualhair =  akActor.GetActorBase().GetNthHeadPart(i).GetName()
		endif
		i += 1
	EndWHILE

	myScripts.SLV_DisplayInformation("Player actual Hair is now:" + actualhair )


	String original_haircut = StorageUtil.GetStringValue(none, "SlaverunPlayerHairStored")
	myScripts.SLV_DisplayInformation("Player final Hair should be now:" + original_haircut)
	
	if original_haircut == ""
		return
	endif
	
	HeadPart unshavedHair = HeadPart.GetHeadPart(original_haircut)
	akActor.ChangeHeadPart(unshavedHair)
	akActor.RegenerateHead()

	String newactualhair = ""

	hp = akActor.GetActorBase().GetNumHeadParts()
	i = 0
	WHILE i < hp
		if(akActor.GetActorBase().GetNthHeadPart(i).GetType() == 3)
			newactualhair =  akActor.GetActorBase().GetNthHeadPart(i).GetName()
		endif
		i += 1
	EndWHILE

	myScripts.SLV_DisplayInformation("Player actual Hair is now:" + newactualhair )

	if(original_haircut != newactualhair) 
		String haircut = "1" + StorageUtil.GetStringValue(none, "SlaverunPlayerHairStored")
		myScripts.SLV_DisplayInformation("Failure Retry0 : Player final Hair should be now:" + haircut)

		unshavedHair = HeadPart.GetHeadPart(haircut)
		akActor.ChangeHeadPart(unshavedHair)
		akActor.RegenerateHead()
	else
		return
	endif

	hp = akActor.GetActorBase().GetNumHeadParts()
	i = 0
	WHILE i < hp
		if(akActor.GetActorBase().GetNthHeadPart(i).GetType() == 3)
			newactualhair =  akActor.GetActorBase().GetNthHeadPart(i).GetName()
		endif
		i += 1
	EndWHILE

	myScripts.SLV_DisplayInformation("Player actual Hair is now:" + newactualhair )

	if(original_haircut != newactualhair) 
		String haircut = "0" + StorageUtil.GetStringValue(none, "SlaverunPlayerHairStored")
		myScripts.SLV_DisplayInformation("Failure Retry1 : Player final Hair should be now:" + haircut)

		unshavedHair = HeadPart.GetHeadPart(haircut)
		akActor.ChangeHeadPart(unshavedHair)
		akActor.RegenerateHead()
	else
		return
	endif
EndFunction

Function UnShave(Actor akActor)
	if MCMMenu.ypsFashionShaving
		return
	endif

	String actualhair = ""

	int hp = akActor.GetActorBase().GetNumHeadParts()
	int i = 0
	WHILE i < hp
		if(akActor.GetActorBase().GetNthHeadPart(i).GetType() == 3)
			actualhair =  akActor.GetActorBase().GetNthHeadPart(i).GetName()
		endif
		i += 1
	EndWHILE

	myScripts.SLV_DisplayInformation("Player actual Hair is now:" + actualhair )


	String original_haircut = StorageUtil.GetStringValue(none, "SlaverunPlayerHair")
	myScripts.SLV_DisplayInformation("Player final Hair should be now:" + original_haircut)
	HeadPart unshavedHair = HeadPart.GetHeadPart(original_haircut)
	akActor.ChangeHeadPart(unshavedHair)
	akActor.RegenerateHead()

	String newactualhair = ""

	hp = akActor.GetActorBase().GetNumHeadParts()
	i = 0
	WHILE i < hp
		if(akActor.GetActorBase().GetNthHeadPart(i).GetType() == 3)
			newactualhair =  akActor.GetActorBase().GetNthHeadPart(i).GetName()
		endif
		i += 1
	EndWHILE

	myScripts.SLV_DisplayInformation("Player actual Hair is now:" + newactualhair )

	if(original_haircut != newactualhair) 
		String haircut = "1" + StorageUtil.GetStringValue(none, "SlaverunPlayerHair")
		myScripts.SLV_DisplayInformation("Failure Retry0 : Player final Hair should be now:" + haircut)

		unshavedHair = HeadPart.GetHeadPart(haircut)
		akActor.ChangeHeadPart(unshavedHair)
		akActor.RegenerateHead()
	else
		return
	endif

	hp = akActor.GetActorBase().GetNumHeadParts()
	i = 0
	WHILE i < hp
		if(akActor.GetActorBase().GetNthHeadPart(i).GetType() == 3)
			newactualhair =  akActor.GetActorBase().GetNthHeadPart(i).GetName()
		endif
		i += 1
	EndWHILE

	myScripts.SLV_DisplayInformation("Player actual Hair is now:" + newactualhair )

	if(original_haircut != newactualhair) 
		String haircut = "0" + StorageUtil.GetStringValue(none, "SlaverunPlayerHair")
		myScripts.SLV_DisplayInformation("Failure Retry1 : Player final Hair should be now:" + haircut)

		unshavedHair = HeadPart.GetHeadPart(haircut)
		akActor.ChangeHeadPart(unshavedHair)
		akActor.RegenerateHead()
	else
		return
	endif
EndFunction

Function SetHairCutRound(int round, Actor akActor)
	File = "../Slaverun/SlaverunConfig.json"
	String haircutname = "SlaverunHairCut" + round

	String haircut = JsonUtil.GetStringValue(File, haircutname  ,"HairFemaleRedguard03" )

	;Debug.notification("Setting new haircut :" + haircut)
	myScripts.SLV_DisplayInformation("Player Hair is now:" + haircut)

	HeadPart hairround =  HeadPart.GetHeadPart(haircut)
	akActor.ChangeHeadPart(hairround)
	akActor.RegenerateHead()

	String actualhair = ""

	int hp = akActor.GetActorBase().GetNumHeadParts()
	int i = 0
	WHILE i < hp
		if(akActor.GetActorBase().GetNthHeadPart(i).GetType() == 3)
			actualhair =  akActor.GetActorBase().GetNthHeadPart(i).GetName()
		endif
		i += 1
	EndWHILE

	myScripts.SLV_DisplayInformation("Player actual Hair is now:" + actualhair )

EndFunction

int maxtattoos = 19

Function StartProgressiveSlaveTats(Actor akActor)
	if !MCMMenu.SlaveTatoos
		return
	endif

	int level = StorageUtil.GetIntValue(none, "SlaverunTatooLevel",0)
	if level > maxtattoos
		level = maxtattoos
	endif
	StorageUtil.SetIntValue(none, "SlaverunTatooLevel", level)
	ProgressiveSlaveTats(akActor, level, false)
EndFunction

Function NextProgressiveSlaveTats(Actor akActor)
	if !MCMMenu.SlaveTatoos
		return
	endif

	int level = StorageUtil.GetIntValue(none, "SlaverunTatooLevel",-1)

	myScripts.SLV_DisplayInformation("SlaverunTatooLevel:" + level )

	level = level + 1
	if level > maxtattoos
		level = maxtattoos
	endif
	StorageUtil.SetIntValue(none, "SlaverunTatooLevel", level)
	ProgressiveSlaveTats(akActor, level, false)
EndFunction

Function RemoveProgressiveSlaveTats(Actor akActor)
	if !MCMMenu.SlaveTatoos
		return
	endif

	int level = StorageUtil.GetIntValue(none, "SlaverunTatooLevel",-1)

	myScripts.SLV_DisplayInformation("TatooLevel before RemoveProgressive:" + level )
	ProgressiveSlaveTats(akActor, level, true)

	level = StorageUtil.GetIntValue(none, "SlaverunTatooLevel",-1)
	level = level - 1
	if level < 0
		level = -1
	endif
	StorageUtil.SetIntValue(none, "SlaverunTatooLevel", level)
	myScripts.SLV_DisplayInformation("TatooLevel after RemoveProgressive:" + level )
EndFunction


Function RefreshProgressiveSlaveTats(Actor akActor)
	if !MCMMenu.SlaveTatoos
		return
	endif

	int level = StorageUtil.GetIntValue(none, "SlaverunTatooLevel",-1)

	myScripts.SLV_DisplayInformation("SlaverunTatooLevel:" + level )

	int tmplevel = 0
	while tmplevel <= level
		ProgressiveSlaveTats(akActor, tmplevel, false)
		tmplevel = tmplevel +1
	endwhile
EndFunction


int Function GetNextProgressiveSlaveTatLevel()
	int level = StorageUtil.GetIntValue(none, "SlaverunTatooLevel",-1)

	myScripts.SLV_DisplayInformation("SlaverunTatooLevel:" + level )

	level = level + 1
	if level > maxtattoos
		level = maxtattoos
	endif
	StorageUtil.SetIntValue(none, "SlaverunTatooLevel", level)
	return level
EndFunction


String Function GetProgressiveSlaveTatsSection(int stage)
	string[] Slavetatnames
	string[] Slavetatsections
	File = "../Slaverun/SlaverunConfig.json"
	int count = 0

	count = JsonUtil.StringListCount(File, "tatoosections")
	Slavetatsections= Utility.ResizeStringArray(Slavetatsections, count )
	JsonUtil.StringListSlice(File, "tatoosections", Slavetatsections)

	count = JsonUtil.StringListCount(File, "tatoonames")
	Slavetatnames= Utility.ResizeStringArray(Slavetatnames, count )
	JsonUtil.StringListSlice(File, "tatoonames", Slavetatnames)

	myScripts.SLV_DisplayInformation("Setting new tattoosection :" + Slavetatsections[stage])
	myScripts.SLV_DisplayInformation("Setting new tattooname :" + Slavetatnames[stage])

	return Slavetatsections[stage]
EndFunction


String Function GetProgressiveSlaveTatsName(int stage)
	string[] Slavetatnames
	string[] Slavetatsections
	File = "../Slaverun/SlaverunConfig.json"
	int count = 0

	count = JsonUtil.StringListCount(File, "tatoosections")
	Slavetatsections= Utility.ResizeStringArray(Slavetatsections, count )
	JsonUtil.StringListSlice(File, "tatoosections", Slavetatsections)

	count = JsonUtil.StringListCount(File, "tatoonames")
	Slavetatnames= Utility.ResizeStringArray(Slavetatnames, count )
	JsonUtil.StringListSlice(File, "tatoonames", Slavetatnames)

	myScripts.SLV_DisplayInformation("Setting new tattoosection :" + Slavetatsections[stage])
	myScripts.SLV_DisplayInformation("Setting new tattooname :" + Slavetatnames[stage])

	return Slavetatnames[stage]
EndFunction


String Function GetProgressiveFaceSlaveTatsSection(int stage)
	string[] Slavetatnames
	string[] Slavetatsections
	File = "../Slaverun/SlaverunConfig.json"
	int count = 0

	count = JsonUtil.StringListCount(File, "facetatoosections")
	Slavetatsections= Utility.ResizeStringArray(Slavetatsections, count )
	JsonUtil.StringListSlice(File, "facetatoosections", Slavetatsections)

	count = JsonUtil.StringListCount(File, "facetatoonames")
	Slavetatnames= Utility.ResizeStringArray(Slavetatnames, count )
	JsonUtil.StringListSlice(File, "facetatoonames", Slavetatnames)

	myScripts.SLV_DisplayInformation("Setting new facetattoosection :" + Slavetatsections[stage])
	myScripts.SLV_DisplayInformation("Setting new facetattooname :" + Slavetatnames[stage])

	return Slavetatsections[stage]
EndFunction


String Function GetProgressiveFaceSlaveTatsName(int stage)
	string[] Slavetatnames
	string[] Slavetatsections
	File = "../Slaverun/SlaverunConfig.json"
	int count = 0

	count = JsonUtil.StringListCount(File, "facetatoosections")
	Slavetatsections= Utility.ResizeStringArray(Slavetatsections, count )
	JsonUtil.StringListSlice(File, "facetatoosections", Slavetatsections)

	count = JsonUtil.StringListCount(File, "facetatoonames")
	Slavetatnames= Utility.ResizeStringArray(Slavetatnames, count )
	JsonUtil.StringListSlice(File, "facetatoonames", Slavetatnames)

	myScripts.SLV_DisplayInformation("Setting new facetattoosection :" + Slavetatsections[stage])
	myScripts.SLV_DisplayInformation("Setting new facetattooname :" + Slavetatnames[stage])

	return Slavetatnames[stage]
EndFunction



Function ProgressiveSlaveTats(Actor akActor, int stage, bool removeonly = false)
	if !MCMMenu.SlaveTatoos
		return
	endif

	string[] Slavetatnames
	string[] Slavetatsections
	File = "../Slaverun/SlaverunConfig.json"
	int count = 0

	count = JsonUtil.StringListCount(File, "tatoosections")
	Slavetatsections= Utility.ResizeStringArray(Slavetatsections, count )
	JsonUtil.StringListSlice(File, "tatoosections", Slavetatsections)

	count = JsonUtil.StringListCount(File, "tatoonames")
	Slavetatnames= Utility.ResizeStringArray(Slavetatnames, count )
	JsonUtil.StringListSlice(File, "tatoonames", Slavetatnames)

	if stage >= count
		myScripts.SLV_DisplayInformation("Tattoo count: " + count + " but stage is: " + stage)
		stage = count - 1
		StorageUtil.SetIntValue(none, "SlaverunTatooLevel", stage)
	endif

	myScripts.SLV_DisplayInformation("Setting new tattoosection :" + Slavetatsections[stage])
	myScripts.SLV_DisplayInformation("Setting new tattooname :" + Slavetatnames[stage])

	if Slavetatsections[stage] != ""
		SlaveTats.simple_remove_tattoo(akActor,Slavetatsections[stage],Slavetatnames[stage], silent = true)
		if !removeonly
			SlaveTats.simple_add_tattoo(akActor,Slavetatsections[stage],Slavetatnames[stage], silent = true)
		endif
	endif
	
	ProgressiveFaceSlaveTats(akActor, stage, removeonly)
EndFunction

Function ProgressiveFaceSlaveTats(Actor akActor, int stage, bool removeonly = false)
	if !MCMMenu.SlaveTatoos
		return
	endif

	string[] Slavetatnames
	string[] Slavetatsections
	File = "../Slaverun/SlaverunConfig.json"
	int count = 0

	count = JsonUtil.StringListCount(File, "facetatoosections")
	Slavetatsections= Utility.ResizeStringArray(Slavetatsections, count )
	JsonUtil.StringListSlice(File, "facetatoosections", Slavetatsections)

	count = JsonUtil.StringListCount(File, "facetatoonames")
	Slavetatnames= Utility.ResizeStringArray(Slavetatnames, count )
	JsonUtil.StringListSlice(File, "facetatoonames", Slavetatnames)

	if stage >= count
		myScripts.SLV_DisplayInformation("Face tattoo count: " + count + " but stage is: " + stage)
		return
	endif
	
	String facetatsection = Slavetatsections[stage]
	String facetatname = Slavetatnames[stage]

	if stage == 0 && facetatsection != ""
		SlaveTats.simple_remove_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (forehead)", silent = true)
		SlaveTats.simple_remove_tattoo(Game.GetPlayer(), "Slutmarks", "Cunt (right cheek)", silent = true)
		SlaveTats.simple_remove_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (left cheek)", silent = true)
	endif	

	myScripts.SLV_DisplayInformation("Setting new facetattoosection :" + Slavetatsections[stage])
	myScripts.SLV_DisplayInformation("Setting new facetattooname :" + Slavetatnames[stage])

	if Slavetatsections[stage] != ""
		SlaveTats.simple_remove_tattoo(akActor,Slavetatsections[stage],Slavetatnames[stage], silent = true)
		if !removeonly
			SlaveTats.simple_add_tattoo(akActor,Slavetatsections[stage],Slavetatnames[stage], silent = true)
		endif
	endif
EndFunction

SLV_MCMMenu Property MCMMenu Auto
Faction Property SlaveFaction Auto
SLV_Utilities Property myScripts auto

