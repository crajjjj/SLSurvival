Scriptname _SLS_Wildling extends Quest  

Event OnInit()
	If Self.IsRunning()
		Float NowTime = Utility.GetCurrentGameTime()
		CrawlBeginTime = NowTime
		BikiniBeginTime = NowTime
		NakedBeginTime = NowTime
		RegisterForModEvent("HookAnimationStarting", "OnAnimationStarting")
		RegisterForModEvent("_SLS_PlayerSwallowedCum", "On_SLS_PlayerSwallowedCum")
		RegisterForModEvent("_SLS_IntCoverShutdown", "On_SLS_IntCoverShutdown")
		RegForEvents()
		RegisterForSingleUpdateGameTime(1.0)
	EndIf
EndEvent

Event OnUpdateGameTime()
	Float UpdateTime = Utility.GetCurrentGameTime()
	Float Decline = -((WildlingPointsLossPerRank * (_SLS_WildlingLevel.GetValue() + 1.0)) / 24.0)
	ModWildlingPoints(Decline, "Update! Decline over time")
	Float MitigateFactor = -(Decline / 15.0) ; (/ 15.0) => Determines how much decline can be mitigated by mitgating factors
	
	; MitigateFactor * x => Determine the weight/importance of a mitigating factor
	
	; Average pack cum fullness
	If Menu.CumRegenTime > 0.0
		Float PackCumAvg = GetAveragePackCumFullness()
		Float Result
		If PackCumAvg >= 0.75 ; > 75% avg = decrease wildling points
			Result = -(((PackCumAvg - 0.75) * 4.0) * MitigateFactor * 3.0) ; (* 4.0) => Convert to factor 0 -> 1.  (* 3.0) => Difficulty
		Else
			Result = ((1.0 - (PackCumAvg) * 1.333)) * MitigateFactor * 3.0 ; (* 1.333) => Convert to factor 0 -> 1
		EndIf
		ModWildlingPoints(Result, "Pack cum fullness avg (" + ((PackCumAvg * 100.0) as Int) + "%)")
	EndIf
	
	; BiS dirt
	Dirt.UpdateLocalDirtyness()
	ModWildlingPoints((Dirt._SLS_PlayerDirtyness.GetValue() * MitigateFactor), "Dirtyness")
	
	; Sexlab cum
	ModWildlingPoints((((Sexlab.CountCum(PlayerRef, true, true, true) as Float) / 6.0) * MitigateFactor), "Cum on body")
	
	; FHU cum
	If Fhu.GetIsInterfaceActive() ; Avoid / 0
		ModWildlingPoints(((Fhu.GetCurrentCumAnal(PlayerRef) + Fhu.GetCurrentCumVaginal(PlayerRef)) / ((Fhu.GetCumCapacityMax() * 2.0)) * MitigateFactor * 2.0), "Cum in holes")
	EndIf
	
	; Pregnancy -FM
	If Fm.GetIsInterfaceActive()
		Race akRace = Fm.GetPregnancyRace(PlayerRef)
		If akRace
			VoiceType akVoice = akRace.GetDefaultVoiceType(female = false)
			Int Index = JsonUtil.FormListFind("SL Survival/CreatureTiers.json", "creatures", akVoice)
			If Index > -1 ; Creature pregnancy
				Float Tier = JsonUtil.FloatListGet("SL Survival/CreatureTiers.json", "tiers", Index)
				ModWildlingPoints(3.0 * MitigateFactor, "Creature pregnancy")
			Else
				ModWildlingPoints(1.0 * MitigateFactor, "Normal pregnancy")
			EndIf
		EndIf
	EndIf
	
	; Crawling
	CrawlTimeUpdate(MitigateFactor, UpdateTime)
	;ModWildlingPoints(CrawlTimeThisHour * MitigateFactor, "Crawling Time")
	
	; Bikini time
	BikiniTimeUpdate(MitigateFactor, UpdateTime)
	
	; Naked time
	NakedTimeUpdate(MitigateFactor, UpdateTime)

	UpdateRank()
	RegisterForSingleUpdateGameTime(1.0)
EndEvent

Function UpdateRank()
	Int NewLevel = GetWildlingLevel(_SLS_WildlingPoints.GetValue()) as Int
	Int WildlingRank  = _SLS_WildlingLevel.GetValue() as Int
	If NewLevel > WildlingRank ; Level up
		_SLS_WolfHowlSM.Play(PlayerRef)
		_SLS_WildlingLevel.SetValue(NewLevel)
		UpdateAllurePool()
		Debug.Notification("Wildling Level Up: " + (WildlingRank) + " -> " + NewLevel)
		Debug.Messagebox("Wildling Level Up! (" + (WildlingRank) + " -> " + NewLevel + ")\nAllure Pool: " + SnipToDecimalPlaces(AllurePool, 2) + "\n\nI can now tame: \n" + GetCreaturesAtTier(NewLevel))
	ElseIf NewLevel < WildlingRank ; Level down
		_SLS_WildlingLevel.SetValue(NewLevel)
		UpdateAllurePool()
		Debug.Notification("Wildling Level Down: " + (WildlingRank) + " -> " + NewLevel)
		Debug.Messagebox("Wildling Level Down! (" + (WildlingRank) + " -> " + NewLevel + ")\nAllure Pool: " + SnipToDecimalPlaces(AllurePool, 2) + "\n\nI've lost the ability to tame: \n" + GetCreaturesAtTier(WildlingRank))
	EndIf
EndFunction

Function UpdateAllurePool()
	AllurePool = AllurePointsPerLevel * _SLS_WildlingLevel.GetValue()
EndFunction

Function RecalcAllureSpent()
	Float TotalCost
	Float AllureCost
	Actor akActor
	Int i = 0
	While i < _SLS_AnimalFriendAliases.GetNumAliases()
		akActor = (_SLS_AnimalFriendAliases.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If akActor
			AllureCost = Friend.GetAllureCost(akActor)
			If AllureCost >= 0.0
				TotalCost += AllureCost
			EndIf
		EndIf
		i += 1
	EndWhile
EndFunction

Float Function GetWildlingLevel(Float Points)
	Return (-15 + Math.Sqrt(225 + (600 * Points))) / 20
	Float Result = (-15 + Math.Sqrt(225 + (600 * Points))) / 20
	Debug.Messagebox("Points: " + Points + "\nResult: " + Result)
	Return Result
EndFunction

Float Function GetMaxLevel()
	Return JsonUtil.FloatListGet("SL Survival/CreatureTiers.json", "tiers", JsonUtil.FloatListCount("SL Survival/CreatureTiers.json", "tiers") - 1)
EndFunction

Float Function GetMaxPointsAtLevel(Float Level)
	;Return (-3 + Math.Sqrt(9 + (12 * Level))) / 2 ; https://www.desmos.com/calculator -> https://www.symbolab.com/solver/equation-calculator/solve%20for%20p%2C%20p%5E%7B2%7D%2B3p%3D3l
	Return ((Level + ((Level * Level) / 1.5)) as Int) as Float ; https://www.desmos.com/calculator/twhlqwfnkl -> Decrease number to increase difficulty
EndFunction

Function ModWildlingPoints(Float Points, String ChangeStr)
	Float WildPoints = _SLS_WildlingPoints.GetValue()
	Float MaxLevel = GetMaxLevel()
	_SLS_WildlingPoints.SetValue(PapyrusUtil.ClampFloat(WildPoints + Points, 0.0, GetMaxPointsAtLevel(MaxLevel + 0.9)))
	LogPointsChange(Points, ChangeStr)
EndFunction

Function LogPointsChange(Float Points, String ChangeStr)
	StorageUtil.StringListInsert(Self, "_SLS_WildlingPointsLog", 0, ChangeStr + ": " + SnipToDecimalPlaces(Points, 3))
	If StorageUtil.StringListCount(Self, "_SLS_WildlingPointsLog") > 32
		StorageUtil.StringListPop(Self, "_SLS_WildlingPointsLog")
	EndIf
EndFunction

String Function GetCreaturesAtTier(Int Tier)
	Int i = 0
	String Creatures
	While i < JsonUtil.FloatListCount("SL Survival/CreatureTiers.json", "tiers")
		If JsonUtil.FloatListGet("SL Survival/CreatureTiers.json", "tiers", i) == Tier
			Creatures += JsonUtil.StringListGet("SL Survival/CreatureTiers.json", "names", i) + "\n"
		EndIf
		i += 1
	EndWhile
	Return Creatures
EndFunction

Function DisplayLog()
	UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	Int i = 0
	While i < StorageUtil.StringListCount(Self, "_SLS_WildlingPointsLog")
		ListMenu.AddEntryItem(StorageUtil.StringListGet(Self, "_SLS_WildlingPointsLog", i))
		i += 1
	EndWhile
	ListMenu.OpenMenu()
EndFunction

Float Function GetAveragePackCumFullness()
	; Returns average cum fullness of pack 0.0 -> 1.0
	; 1.0 if no pack members
	Int i = 0
	Float Avg
	Float Count
	Actor akActor
	While i < _SLS_AnimalFriendAliases.GetNumAliases()
		akActor = (_SLS_AnimalFriendAliases.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If akActor
			Avg += Util.GetLoadFullnessMod(akActor)
			Count += 1.0
		EndIf
		i += 1
	EndWhile
	If Count == 0.0
		Return 1.0
	EndIf
	Return (Avg / Count)
EndFunction

Event OnAnimationStarting(int tid, bool HasPlayer)
	If HasPlayer
		PlayerSexActors = SexLab.HookActors(tid as string)
		If Sexlab.CreatureCount(PlayerSexActors) > 0 ; Creature animation
			CurrentTid = tid
			PlayerIsVictim = Sexlab.IsVictim(tid, PlayerRef)
			SexPartner = GetSexPartner(PlayerSexActors)
			RegForEvents() ; Animation of relevance
		EndIf
	EndIf
EndEvent

Function RegForEvents()
	RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
	If Game.GetModByName("SLSO.esp") != 255
		RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
	Else
		RegisterForModEvent("HookOrgasmStart", "OnOrgasmStart")
	EndIf
EndFunction

Function UnRegisterForAnimEvents()
	UnRegisterForModEvent("HookAnimationEnd")
	UnRegisterForModEvent("SexLabOrgasmSeparate")
	UnRegisterForModEvent("HookOrgasmStart")
EndFunction

Event OnOrgasmStart(int tid, bool HasPlayer);(string eventName, string argString, float argNum, form sender)
	OrgasmEvent(ActorRef = None, tid = tid, HasPlayer = HasPlayer)
EndEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int tid)
	;Bool HasPlayer = Sexlab.FindPlayerController() == tid
	OrgasmEvent(ActorRef = ActorRef as Actor, tid = tid, HasPlayer = Sexlab.FindPlayerController() == tid)
EndEvent

Event On_SLS_PlayerSwallowedCum(Form akSource, Bool Swallowed, Float LoadSize, Float LoadSizeBase, Bool IsCumPotion)
	If Swallowed
		Float Points = GetCreatureTier(akSource as Actor) * 0.5
		If IsCumPotion
			Points = Points * 0.333
		EndIf
		String ChangeStr
		If Points > 0.0
			If PlayerIsVictim
				Points = Points * 0.5
				;Debug.Notification("Forced to drink " + (akSource as Actor).GetDisplayName() + "'s cum. Wildling points +" + SnipToDecimalPlaces(Points, Places = 1))
				ChangeStr = PlayerRef.GetDisplayName() + " forced to drink " + (akSource as Actor).GetDisplayName() + "'s cum"
			Else
				;Debug.Notification("Willfully drank " + (akSource as Actor).GetDisplayName() + "'s cum. Wildling points +" + SnipToDecimalPlaces(Points, Places = 1))
				ChangeStr = PlayerRef.GetDisplayName() + " drank " + (akSource as Actor).GetDisplayName() + "'s cum"
			EndIf
			;_SLS_WildlingPoints.Mod(Points)
			ModWildlingPoints(Points, ChangeStr)
		EndIf
	EndIf
EndEvent

Event OnAnimationEnd(int tid, bool HasPlayer)
	If tid == CurrentTid
		Float Points = GetPointsForSexActorList(PlayerSexActors) * 0.5
		String ChangeStr
		If PlayerIsVictim
			Points = Points * 0.5
			;Debug.Notification("Earned " + (Points as Int) + " wildling points from rape")
			ChangeStr = PlayerRef.GetDisplayName() + " raped by " + GetSexActorsRaceDes()
		Else
			;Debug.Notification("Earned " + (Points as Int) + " wildling points from sex")
			ChangeStr = PlayerRef.GetDisplayName() + " fucked " + GetSexActorsRaceDes()
		EndIf
		;_SLS_WildlingPoints.Mod(Points)
		ModWildlingPoints(Points, ChangeStr)
		UnRegisterForAnimEvents()
		CurrentTid = -1
		PlayerIsVictim = false
		SexPartner = None
	EndIf
EndEvent

String Function GetSexActorsRaceDes()
	Int i = 0
	String Result
	Race akRace
	Int ActorCount
	While i < PlayerSexActors.Length
		If PlayerSexActors[i] != PlayerRef
			If !akRace || PlayerSexActors[i].GetRace() == akRace
				akRace = PlayerSexActors[i].GetRace()
				ActorCount += 1
			EndIf
		EndIf
		i += 1
	EndWhile
	If ActorCount == 1
		Return SexPartner.GetDisplayName()
	EndIf
	Return ActorCount + "x " + akRace.GetName()
EndFunction

Function OrgasmEvent(Actor ActorRef = None, Int tid, Bool HasPlayer)
	If tid == CurrentTid
		Float Points
		String ChangeStr
		Points = GetPointsForCreature(SexPartner) * 0.5
		If ActorRef == PlayerRef
			If PlayerIsVictim
				Points = Points * 2.0
				;Debug.Notification("Forced to cum on " + SexPartner.GetDisplayName() + "'s cock. Wildling points +" + SnipToDecimalPlaces(Points, Places = 1))
				ChangeStr = PlayerRef.GetDisplayName() + " orgasmed on " + SexPartner.GetDisplayName() + "'s cock (Rape)"
			Else
				Points = Points
				;Debug.Notification("Willfully came on " + SexPartner.GetDisplayName() + "'s cock. Wildling points +" + SnipToDecimalPlaces(Points, Places = 1))
				ChangeStr = PlayerRef.GetDisplayName() + " orgasmed on " + SexPartner.GetDisplayName() + "'s cock"
			EndIf
		Else
			ChangeStr = SexPartner.GetDisplayName() + " came inside " + PlayerRef.GetDisplayName()
			If !ActorRef ; Non SLSO NPC orgasm
				If PlayerIsVictim
					Points = Points * 2.0
					ChangeStr += " (Rape)"
				EndIf
				
			Else ; SLSO NPC orgasm
				If PlayerIsVictim
					Points = Points * 2.0
					ChangeStr += " (Rape)"
				EndIf
			EndIf
			;Debug.Notification(SexPartner.GetDisplayName() + " came inside me. Wildling points +" + SnipToDecimalPlaces(Points, Places = 1))
		EndIf
		;_SLS_WildlingPoints.Mod(Points)
		ModWildlingPoints(Points, ChangeStr)
	EndIf
EndFunction

Float Function GetCreatureTier(Actor akActor)
	Int Index = JsonUtil.FormListFind("SL Survival/CreatureTiers.json", "creatures", akActor.GetVoiceType())
	If Index > -1
		Return JsonUtil.FloatListGet("SL Survival/CreatureTiers.json", "tiers", Index)
	EndIf
	Return 0.0
EndFunction

Float Function GetPointsForSexActorList(Actor[] SexActors)
	Int i = 0
	Float Points
	While i < SexActors.Length
		If SexActors[i] != PlayerRef
			Points += GetCreatureTier(SexActors[i])
		EndIf
		i += 1
	EndWhile
	Return Points
EndFunction

Float Function GetPointsForCreature(Actor Creature)
	Return GetCreatureTier(Creature)
EndFunction

Actor Function GetSexPartner(Actor[] SexActors)
	Int i = SexActors.Length
	While i > 0
		i -= 1
		If SexActors[i] != PlayerRef
			Return SexActors[i]
		EndIf
	EndWhile
EndFunction

Function CrawlToggle(Bool IsCrawling)
	If IsCrawling
		CrawlBeginTime = Utility.GetCurrentGameTime()
	Else
		;Float CrawlEndTime = Utility.GetCurrentGameTime()
		CrawlTimeThisHour += (Utility.GetCurrentGameTime() - CrawlBeginTime) * 24.0
		;Debug.Messagebox("Time spent Crawling: " + ((CrawlEndTime - CrawlBeginTime) * 24.0) + "\nTotal: " + CrawlTimeThisHour)
	EndIf
EndFunction

Function CrawlTimeUpdate(Float MitigateFactor, Float UpdateTime)
	If Init.IsCrawling
		CrawlTimeThisHour += (UpdateTime - CrawlBeginTime) * 24.0
		ModWildlingPoints(CrawlTimeThisHour * MitigateFactor * 2.0, "Crawling Time")
		CrawlBeginTime = UpdateTime
	ElseIf CrawlTimeThisHour > 0.0
		ModWildlingPoints(CrawlTimeThisHour * MitigateFactor * 2.0, "Crawling Time")
	EndIf
	CrawlTimeThisHour = 0.0
EndFunction

Event On_SLS_IntCoverShutdown(string eventName, string strArg, float numArg, Form sender)
	; 0 - Naked, 1 - Bikini/slooty, 2 - Full cover
	
	Float GameTime = Utility.GetCurrentGameTime()
	If numArg == 0 ; Naked
		NakedBeginTime = GameTime
		If OldCoverStatus == 1
			BikiniTimeThisHour += (GameTime - BikiniBeginTime) * 24.0
		EndIf
	ElseIf numArg == 1 ; Bikini
		BikiniBeginTime = GameTime
		If OldCoverStatus == 0
			NakedTimeThisHour += (GameTime - NakedBeginTime) * 24.0
		EndIf
	ElseIf numArg == 2
		If OldCoverStatus == 0
			NakedTimeThisHour += (GameTime - NakedBeginTime) * 24.0
		ElseIf OldCoverStatus == 1
			BikiniTimeThisHour += (GameTime - BikiniBeginTime) * 24.0
		EndIf
	EndIf
	OldCoverStatus = _SLS_BodyCoverStatus.GetValueInt()
EndEvent

Function BikiniTimeUpdate(Float MitigateFactor, Float UpdateTime)
	If _SLS_BodyCoverStatus.GetValueInt() == 1
		BikiniTimeThisHour += (UpdateTime - BikiniBeginTime) * 24.0
		ModWildlingPoints(BikiniTimeThisHour * MitigateFactor * 2.0, "Bikini Time")
		BikiniBeginTime = UpdateTime
	ElseIf BikiniTimeThisHour > 0.0
		ModWildlingPoints(BikiniTimeThisHour * MitigateFactor * 2.0, "Bikini Time")
	EndIf
	BikiniTimeThisHour = 0.0
EndFunction

Function NakedTimeUpdate(Float MitigateFactor, Float UpdateTime)
	If _SLS_BodyCoverStatus.GetValueInt() == 0
		NakedTimeThisHour += (UpdateTime - NakedBeginTime) * 24.0
		ModWildlingPoints(NakedTimeThisHour * MitigateFactor * 3.0, "Naked Time")
		NakedBeginTime = UpdateTime
	ElseIf NakedTimeThisHour > 0.0
		ModWildlingPoints(NakedTimeThisHour * MitigateFactor * 3.0, "Naked Time")
	EndIf
	NakedTimeThisHour = 0.0
EndFunction

String Function SnipToDecimalPlaces(String StrInput, Int Places)
	Return StringUtil.Substring(StrInput, startIndex = 0, len =  Places + 1 + StringUtil.Find(StrInput, ".", startIndex = 0))
EndFunction

Actor[] PlayerSexActors

Actor SexPartner

Bool PlayerIsVictim

Int CurrentTid = -1
Int OldCoverStatus = 2

Float LastUpdateDay
Float CrawlBeginTime
Float CrawlTimeThisHour
Float BikiniBeginTime
Float BikiniTimeThisHour
Float NakedBeginTime
Float NakedTimeThisHour

Float Property WildlingPointsLossPerRank = 2.5 Auto Hidden
Float Property AllurePool = 0.0 Auto Hidden
Float Property AllureSpent = 0.0 Auto Hidden
Float Property AllurePointsPerLevel = 2.0 Auto Hidden

GlobalVariable Property _SLS_WildlingLevel Auto
GlobalVariable Property _SLS_WildlingPoints Auto
GlobalVariable Property _SLS_BodyCoverStatus Auto

Actor Property PlayerRef Auto

Sound Property _SLS_WolfHowlSM Auto

Quest Property _SLS_AnimalFriendAliases Auto

SexlabFramework Property Sexlab Auto
_SLS_PlayerDirt Property Dirt Auto
_SLS_InterfaceFhu Property Fhu Auto
_SLS_InterfaceFm Property Fm Auto
_SLS_AnimalFriend Property Friend Auto
SLS_Utility Property Util Auto
sls_Init Property Init Auto
SLS_Mcm Property Menu Auto
