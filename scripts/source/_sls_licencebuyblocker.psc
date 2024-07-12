Scriptname _SLS_LicenceBuyBlocker extends Quest  

Event OnInit()
	If Self.IsRunning()
		BuildLicenceGuyArray()
		BuildFactionArray()
		RegisterForSingleUpdateGameTime(0.2)
	EndIf
EndEvent

Event OnUpdateGameTime()
	DoRandomize()

	; Randomize again at 3am
	float Time = Utility.GetCurrentGameTime()
	Time -= Math.Floor(Time) ; Remove "previous in-game days passed" bit
	Time *= 24
	
	If Time < 2.5 ; 2.5 & !3.0 to allow for error in calc causing update spam
		Debug.trace("SLS_: Evictions Updating in " + (3.0 - Time))
		RegisterForSingleUpdateGameTime(3.0 - Time)
	Else
		Debug.trace("SLS_: Evictions Updating in " + (27.0 - Time))
		RegisterForSingleUpdateGameTime(27.0 - Time)
	Endif
EndEvent

Function DoRandomize()
	ResetFactions()
	RandomizeGuys()
EndFunction

Function BuildLicenceGuyArray()
	LicenceGuys = new Actor[5]
	LicenceGuys[0] = WhiterunGuy
	LicenceGuys[1] = WindhelmGuy
	LicenceGuys[2] = RiftenGuy
	LicenceGuys[3] = SolitudeGuy
	LicenceGuys[4] = MarkarthGuy
EndFunction

Function BuildFactionArray()
	BlockFactions = new Faction[3]
	BlockFactions[0] = _SLS_LicBlockNaked
	BlockFactions[1] = _SLS_LicBlockPaper
	BlockFactions[2] = _SLS_LicBlockBribe
EndFunction

Function RandomizeGuys()
	Int i = LicenceGuys.Length
	While i > 0
		i -= 1
		If Menu.LicBlockChance > Utility.RandomFloat(0.0, 100.0)
			LicenceGuys[i].AddToFaction(BlockFactions[Utility.RandomInt(0, (BlockFactions.Length - 1))])
		EndIf
	EndWhile
EndFunction

Function ResetFactions()
	Int i = LicenceGuys.Length
	While i > 0
		i -= 1
		LicenceGuys[i].RemoveFromFaction(_SLS_LicBlockNaked)
		LicenceGuys[i].RemoveFromFaction(_SLS_LicBlockPaper)
		LicenceGuys[i].RemoveFromFaction(_SLS_LicBlockBribe)
	EndWhile
EndFunction

Actor[] LicenceGuys

Actor Property WhiterunGuy Auto
Actor Property WindhelmGuy Auto
Actor Property RiftenGuy Auto
Actor Property SolitudeGuy Auto
Actor Property MarkarthGuy Auto

Faction[] BlockFactions

Faction Property _SLS_LicBlockNaked Auto
Faction Property _SLS_LicBlockPaper Auto
Faction Property _SLS_LicBlockBribe Auto

SLS_Mcm Property Menu Auto
