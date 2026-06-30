Scriptname FWChildActor extends Actor conditional

FWChildSettings property ChildSettings auto
bool property HasMagicka = false auto
bool property CanWearWeapons = false auto


; Variable06 and Variable07 for Hearthfire - Source: BYOHRelationshipAdoptionScript.psc
;----------------------------------------------------------------------------------------------------
;STANDARD VARIABLES
;----------------------------------------------------------------------------------------------------
;RelationshipAdoption makes extensive use of Actor Values Variable06-07 for package conditionals and state-tracking. Values are:
;
;******************************
; Variable06 - Child State: Primarily used for package conditionals to override the child's standard schedule.
;   - -2 - Just Adopted, block packages until the child moves to their new home.
;   - -1 - Just Adopted, travel to home, then trigger the scheduler.
;   -  0 -  Normal
;   -  1 - Override Behaviors: Small overrides to the child's schedule that don't trump real Orders. Used to make the child feel more responsive.
;      - 1.0 - Child was recently adopted and sandboxes in their new house for an hour.
;	   - 1.1 - Child was given a weapon and spars with it for an hour.
;	   - 1.2 - Child was given a doll and plays with it for an hour.
;      - 1.3 - Child runs off crying and sandboxes in their room for an hour.
;   -  2 - Override Orders: Child ordered outside (Inside, 6am-9pm)
;   -  3 - Override Orders: Child ordered inside (Outside, any time)
;   -  4 - Override Orders: Child ordered to do chores (Anywhere, 6am-9pm)
;   -  5 - Override Orders: Child ordered to bed (Anywhere, 6pm-8am)
;   - 10 - Override Behavior: Child will "Never Speak to You Again" due to a hostile action. This lasts for 24h.
;******************************
; Variable07 - Forcegreet State: Determines which forcegreet to run when the player 'comes home' after an absence.
;   -  0 - [NOT INITIALIZED]
;   -  1 - DLG: Thanks for Adopting	  - First FG after Adoption, Dirty Move.
;   -  2 - DLG: Thanks and Chest	  - First FG after Adoption, Clean Move.
;   -  3 - DLG: Check the Chest       - First Clean Move after Adoption.
;   -  4 - Adopt a Pet				  - Player has an Animal Companion, child asks to keep it.
;   -  5 - Adopt a Critter			  - Child brings home a critter. 10% chance (plus other conditions).
;   -  6 - Name Calling 1             - Scene: Children call each other names, then play tag. 10% chance (plus other conditions).
;   -  7 - Name Calling 2             - Scene: Children call each other names, one runs off crying. 10% chance (plus other conditions).
;   -    -
;   - 10 - Ask for Allowance          - Generic, 25% Chance
;   - 11 - Give Gift to Player        - Generic, 25% Chance
;   - 12 - Ask for a Present		  - Generic, 25% Chance
;   - 13 - Suggest a Game			  - Generic, 25% Chance
;******************************
; Variable03 - Orders - BF Variable
;   -  0 - Wait
;   -  1 - Wait and Play
;   -  2 - *Waiting free slot*
;   -  3 - *Waiting free slot*
;   -  4 - *Waiting free slot*
;   -  5 - *Waiting free slot*
;   -  6 - *Waiting free slot*
;   -  7 - *Waiting free slot*
;   -  8 - *Waiting free slot*
;   -  9 - *Waiting free slot*
; 
;   - 10 - GoTo Spoon
;   - 11 - GoTo Home
;   - 12 - GoTo Meet place
;   - 13 - *GoTo free slot*
;   - 14 - *GoTo free slot*
;   - 15 - *GoTo free slot*
;   - 16 - *GoTo free slot*
;   - 17 - *GoTo free slot*
;   - 18 - *GoTo free slot*
;   - 19 - *GoTo free slot*
;   - 20 - *GoTo free slot*
;   - 21 - *GoTo free slot*
;   - 22 - *GoTo free slot*
;   - 23 - *GoTo free slot*
;   - 24 - *GoTo free slot*
;   - 25 - *GoTo free slot*
;   - 26 - *GoTo free slot*
;   - 27 - *GoTo free slot*
;   - 28 - *GoTo free slot*
;   - 29 - *GoTo free slot*
;
;   - 30 - Follow
;   - 31 - Follow and Play
;   - 32 - *Follow free slot*
;   - 33 - *Follow free slot*
;   - 34 - *Follow free slot*
;   - 35 - *Follow free slot*
;   - 36 - *Follow free slot*
;   - 37 - *Follow free slot*
;   - 38 - *Follow free slot*
;   - 39 - *Follow free slot*
;   - 40 - *Follow free slot*
;   - 41 - *Follow free slot*
;   - 42 - *Follow free slot*
;   - 43 - *Follow free slot*
;   - 44 - *Follow free slot*
;   - 45 - *Follow free slot*
;   - 46 - *Follow free slot*
;   - 47 - *Follow free slot*
;   - 48 - *Follow free slot*
;   - 49 - *Follow free slot*
;
;   - 99 - Leave me alone (Delete)




; Flags
;---------------------------
;  1 IsVampire
;  2 Hair from Father (all consumers read bit 2 as father's hair color)
;  4 IsFemale
;  8 Eyes from Mother
; 16 Nose from Mother
; 32 Fathers Last name


Actor Property PlayerRef Auto
GlobalVariable Property GameDaysPassed Auto
Faction property Faction_OtherParent auto
Faction Property CurrentFollowerFaction Auto
FormList property Factions_To_Transfer auto
Faction property PlayerFaction auto
FWAddOnManager property Manager auto
FWTextContents property Contents auto
Faction property Faction_MaySleep auto
spell property LevelUpFX auto
FWSystem property System auto

string function GetActorBaseNameOrNone(actor a)
	if a == none
		return "none"
	endIf
	ActorBase ab = a.GetLeveledActorBase()
	if ab && ab.GetName() != ""
		return ab.GetName()
	endIf
	return "none"
endFunction

actor _Mother
actor property Mother hidden
	actor function get()
		if _Mother==none
			_Mother=StorageUtil.GetFormValue(self,"FW.Child.Mother",none) as Actor
		endif
		return _Mother
	endFunction
	function Set(actor value)
		if _Mother!=none
			SetRelationshipRank(_Mother,0)
			Mother.SetRelationshipRank(self,0)
		endif
		StorageUtil.SetFormValue(self,"FW.Child.Mother",value)
		if _Mother==PlayerRef
;			ChildSettings.RemovePlayerChild(self)
			ChildSettings.RemovePlayerChild(self as Actor)
		endif
		
		_Mother = value
		if value == PlayerRef
;			ChildSettings.AddPlayerChild(self)
			ChildSettings.AddPlayerChild(self as Actor)
		endif
		if _Mother!=none
			SetRelationshipRank(_Mother, ChildSettings.ParentRelationShipLevel)
			_Mother.SetRelationshipRank(self,ChildSettings.ParentRelationShipLevel)
		endif
		
		;if _Father!=PlayerRef && _Mother!=PlayerRef && _Father!=none && Mother!=none
		;	_Mother.SetRelationshipRank(_Father,ChildSettings.ParentRelationShipLevel)
		;	_Father.SetRelationshipRank(_Mother,ChildSettings.ParentRelationShipLevel)
		;endif
	endFunction
endProperty

actor _Father
actor property Father hidden
	actor function get()
		if _Father==none
			_Father=StorageUtil.GetFormValue(self,"FW.Child.Father",none) as Actor
		endif
		return _Father
	endFunction
	function Set(actor value)
		if _Father!=none
			SetRelationshipRank(_Father,0)
			_Father.SetRelationshipRank(self,0)
		endif
		StorageUtil.SetFormValue(self,"FW.Child.Father",value)
		if _Father==PlayerRef
;			ChildSettings.RemovePlayerChild(self)
			ChildSettings.RemovePlayerChild(self as Actor)
		endif
		
		_Father = value
		if value == PlayerRef
;			ChildSettings.AddPlayerChild(self)
			ChildSettings.AddPlayerChild(self as Actor)
		endif
		if _Father!=none
			SetRelationshipRank(_Father,ChildSettings.ParentRelationShipLevel)
			_Father.SetRelationshipRank(self,ChildSettings.ParentRelationShipLevel)
		endif
		
		;if _Father!=PlayerRef && _Mother!=PlayerRef && _Father!=none && Mother!=none
		;	_Mother.SetRelationshipRank(_Father,ChildSettings.ParentRelationShipLevel)
		;	_Father.SetRelationshipRank(_Mother,ChildSettings.ParentRelationShipLevel)
		;endif
	endFunction
endProperty

float property Age hidden
	float function get()
		if dob==0
			dob=StorageUtil.GetFloatValue(self,"FW.Child.DOB",0)
		endif
		return GameDaysPassed.GetValue() - dob
	endFunction
endProperty


float dob = 0.0 ; Day of birth
float property DayOfBirth hidden
	float function get()
		if dob==0
			dob=StorageUtil.GetFloatValue(self,"FW.Child.DOB",0)
		endif
		return dob
	endFunction
	function set(float value)
		dob = value
		StorageUtil.SetFloatValue(self,"FW.Child.DOB",value)
	endFunction
endProperty

actor property Follow auto hidden conditional


;  0: Error
;  1: Mother
;  2: Father
;  3: Mother is dead
;  4: Father is dead
;  5: Don't know him/it (bandits, creatures, ...)
int property GetOtherParentRank hidden
	int function get()
		if Faction_OtherParent==none
			return 0
		else
			return GetFactionRank(Faction_OtherParent)
		endif
	endFunction
endProperty

int _order = 0
int property Order hidden
	int function get()
		return _order
	endfunction
	function set(int value)
		
		if value >= 0
			; Wait Orders
			if value < 2
				if value==0
					Order_Wait()
				else;if value==1
					Order_WaitAndPlay()
				endIf
			else
				; GoTo Orders
				if((value >= 10) && (value < 13))
					if value < 12
						if value==10
							Order_FollowAndPlayOther()
						else;if value==11
							Order_GoHome()
						endIf
					else;if value==12
						Order_MeetPlace()
					endIf
				else
					; Follow Orders
					if((value >= 30) && (value < 32))
						if value==30
							if _Mother==PlayerRef || _Father == PlayerRef
								Order_Follow(PlayerRef)
							endif
						else;if value==31
							if _Mother==PlayerRef || _Father == PlayerRef
								Order_FollowAndPlay(PlayerRef)
							endif
						endIf			
					else
						if value==99
							Order_LeaveMeAlone()
						else
							_order = value
							RefreshAI()
						endIf
					endIf
				endIf
			endIf	
		else
			_order = value
			RefreshAI()
		endif
	endFunction
endproperty

bool bIsVampire = false
bool property IsVampire hidden
	bool function get()
		return bIsVampire
	endFunction
	function set(bool value)
		int xflag = StorageUtil.GetIntValue(self, "FW.Child.Flag", 0)
		if (Math.LogicalAnd(xflag,1) == 1) && value==false
			StorageUtil.SetIntValue(self, "FW.Child.Flag", Math.LogicalXor(xflag,1) )
		elseif (Math.LogicalAnd(xflag,1) == 0) && value==true
			StorageUtil.SetIntValue(self, "FW.Child.Flag", Math.LogicalOr(xflag,1) )
		endif
		bIsVampire = value
	endFunction
endProperty

bool bUseFathersLastName
bool property UseFathersLastName hidden
	bool function get()
		return bUseFathersLastName
	endFunction
	function set(bool value)
		int xflag = StorageUtil.GetIntValue(self, "FW.Child.Flag", 0)
		if value==true
			StorageUtil.SetIntValue(self, "FW.Child.Flag", Math.LogicalOr(xflag,32) )
		else
			StorageUtil.SetIntValue(self, "FW.Child.Flag", Math.LogicalXor(xflag,32) )
		endif
		if _Name==""
			return
		endif
		string LastName = GetLastName()
		;Debug.Notification("UseFathersLastName: 1. '"+_Name+"' 2. '"+LastName+"'")
		parent.SetName(_Name)
		SetDisplayName(_Name+LastName,true)
		bUseFathersLastName = value
	endFunction
endProperty

string _Name = ""
string property Name hidden
	string function get()
		return _Name
	endFunction
	function set(string value)
		if value==""
			return
		endif
		_Name=value
		string LastName = GetLastName()
		;Debug.Notification("Name: 1. '"+_Name+"' 2. '"+LastName+"'")
		parent.SetName(_Name)
		SetDisplayName(_Name+LastName,true)
	endFunction
endProperty

int iSex
int property Sex hidden
	int function get()
		return iSex
	endFunction
	function set(int value)
		iSex = value
	endFunction
endProperty

bool property IsFemale hidden
	bool function get()
		return iSex==1
	endFunction
	function Set(bool value)
		if value==true
			iSex=1
		else
			iSex=0
		endif
	endFunction
endProperty

bool property IsMale hidden
	bool function get()
		return iSex==0
	endFunction
	function Set(bool value)
		if value==true
			iSex=0
		else
			iSex=1
		endif
	endFunction
endProperty

float _SmallSizeScale
float property SmallSizeScale
	float function get()
		return _SmallSizeScale
	endFunction
	function Set(float value)
		_SmallSizeScale=value
		UpdateSize()
	endFunction
endProperty

float _SizeDuration
float property SizeDuration
	float function get()
		return _SizeDuration
	endFunction
	function Set(float value)
		_SizeDuration=value
		UpdateSize()
	endFunction
endProperty

float property PlayerLastSeen = 0.0 auto hidden

bool property IsLearning
	bool function get()
		return bIsLearning
	endFunction
endProperty

ColorForm HairColor
float DoFavourStart = 0.0
float FollowPositionX=0.0
float FollowPositionY=0.0
float dontSleepStart=0.0

function Upgrade(int oldVersion, int newVersion)
	if oldVersion<9
		RemoveFromFaction(CurrentFollowerFaction)
		;RemoveFromFaction(Game.GetFormFromFile(0x5C84E, "Skyrim.esm") as faction)
	endif
endFunction

FWChildActorBase function GetChildActorBase()
	return GetBaseObject() as FWChildActorBase
endFunction

function OpenSkillMenu()
	ChildSettings.OpenSkillMenu(self)
endfunction

int function GetSex()
	return iSex
endFunction

function RefreshFactions()
	; Get Mother Factions
	if self.GetType() != 62
		return
	elseif !ChildSettings
		return
	elseif !Factions_To_Transfer
		return
	endif
	
	if Mother
		Faction[] fa = Mother.GetFactions(-10,20)
		int i = FWUtility.MinInt(fa.length, 25)
		while i>0
			i-=1
			if fa[i]
				if Factions_To_Transfer.HasForm(fa[i])
					int r1 = Mother.GetFactionRank(fa[i])
					int r2 = GetFactionRank(fa[i])
					int FaRank = FWUtility.MaxInt(r1, r2)
					SetFactionRank(fa[i],FaRank)
				endif
			endif
		endwhile
	endif
	
	; Get Father Factions
	if Father
		Faction[] fa = Father.GetFactions(-10,20)
		int i = FWUtility.MinInt(fa.length, 25)
		while i>0
			i-=1
			if fa[i]
				if Factions_To_Transfer.HasForm(fa[i])
					int r1 = Father.GetFactionRank(fa[i])
					int r2 = GetFactionRank(fa[i])
					int FaRank = FWUtility.MaxInt(r1, r2)
					SetFactionRank(fa[i],FaRank)
				endif
			endif
		endwhile
	endif
endFunction

function DebugFactions()
	faction[] f = GetFactions(-10,20)
	faction[] fp = PlayerRef.GetFactions(-10,20)
	faction[] fm = _Mother.GetFactions(-10,20)
	faction[] ff = _Mother.GetFactions(-10,20)
	int c = f.length
	FW_log.WriteLog("DebugFactions() " + GetDisplayName())
	while c>0
		c-=1
		string logStr = "- [" + f[c].GetFormID() + "] " + f[c].GetName() + " " + GetFactionRank(f[c]) + ": "
		logStr += "[Infamy: " + f[c].GetInfamy() + ";" + f[c].GetInfamyNonViolent() + ";" + f[c].GetInfamyViolent() + "]"
		logStr += "[PlayerReact: " + f[c].GetReaction(PlayerFaction) + "]"
		Debug.Notification(logStr)
		
		FW_log.WriteLog("- [" + f[c].GetFormID() + "] " + f[c].GetName() + " " + GetFactionRank(f[c]) + ":")
		FW_log.WriteLog("  - Infamy: " + f[c].GetInfamy() + ";" + f[c].GetInfamyNonViolent() + ";" + f[c].GetInfamyViolent())
		FW_log.WriteLog("  - PlayerReact: " + f[c].GetReaction(PlayerFaction))
		FW_log.WriteLog("  - Player Factions:")
		
		int cp = fp.Length
		while cp>0
			cp-=1
			FW_log.WriteLog("  - - [" + fp[cp].GetFormID() + "] " + fp[cp].GetName() + ": " + f[c].GetReaction(fp[cp]) + " / " + fp[cp].GetReaction(f[c]))
		endWhile
		
		FW_log.WriteLog("  - Mother Factions:")
		int cm = fm.Length
		while cm>0
			cm-=1
			FW_log.WriteLog("  - - [" + fm[cm].GetFormID() + "] " + fm[cm].GetName() + ": " + f[c].GetReaction(fm[cm]) + " / " + fm[cm].GetReaction(f[c]))
		endWhile
		
		FW_log.WriteLog("  - Father Factions:")
		int cf = ff.Length
		while cf>0
			cf-=1
			FW_log.WriteLog("  - - [" + ff[cf].GetFormID() + "] " + ff[cf].GetName() + ": " + f[c].GetReaction(ff[cf]) + " / " + ff[cf].GetReaction(f[c]))
		endWhile
	endwhile
endFunction

function SetSex(int Sex)
	int xflag = StorageUtil.GetIntValue(self, "FW.Child.Flag", 0)
	if Sex == 1
		if (Math.LogicalAnd(xflag,4) == 0) ;&& Sex==1
			StorageUtil.SetIntValue(self, "FW.Child.Flag", Math.LogicalOr(xflag,4) )
		endIf
		iSex=1
	else	
		if (Math.LogicalAnd(xflag,4) == 4) && Sex==0
			StorageUtil.SetIntValue(self, "FW.Child.Flag", Math.LogicalXor(xflag,4) )
		endif
		iSex=0
	endIf
endfunction

ColorForm Function GetHairColor()
	return HairColor
EndFunction

Function SetHairColor(ColorForm newColor)
	HairColor = newColor
	self.GetActorBase().SetHairColor(newColor)
	self.QueueNiNodeUpdate()
EndFunction

String Function GetName()
	return _Name
EndFunction

Function SetName(string newName)
	if newName==""
		return
	endif
	_Name = newName
	string LastName = GetLastName()
	parent.SetName(newName)
	SetDisplayName(newName+LastName,true)
	StorageUtil.SetStringValue(self,"FW.Child.Name",newName)
EndFunction

string Function GetLastName()
	string LastName = ""
	int xflag = StorageUtil.GetIntValue(self, "FW.Child.Flag", 0)
	
	if Mother==PlayerRef || Father==PlayerRef
		return " Dovahkiir"
	endif
	
	if (Math.LogicalAnd(xflag,32) == 32)
		LastName = GetActorsLastName(Father)
	endif
	
	if LastName==""
		LastName = GetActorsLastName(Mother)
	endif
	return LastName
endFunction

race property ChildRace hidden
	race function get()
		return StorageUtil.GetFormValue(self, "FW.Child.Race" ) as race
	endFunction
	
	function set(race value)
		StorageUtil.SetFormValue(self, "FW.Child.Race", value )
	endFunction
endProperty

string function GetActorsLastName(actor a)
	if a==none
		return ""
	endif
	string Name1 = a.GetName()
	string Name2 = a.GetDisplayName()
	ActorBase ab = a.GetLeveledActorBase()
	if ab!=none
		if StringUtil.GetLength(ab.GetName())>StringUtil.GetLength(Name1)
			Name1 = ab.GetName()
		endif
	endif
	int lName1 = StringUtil.GetLength(Name1)
	int lName2 = StringUtil.GetLength(Name2)
	if lName1 > lName2
		return StringUtil.Substring(Name1,lName2)
	elseif lName1 < lName2
		return StringUtil.Substring(Name2,lName1)
	endif
	return ""
endFunction

bool bOnLoadRunning=false
Event OnLoad()
	OnPlayerLoadGame()
endEvent

event OnInit()
	OnPlayerLoadGame()
endEvent

Event OnPlayerLoadGame()
	if bOnLoadRunning==true
		return
	endif
	bOnLoadRunning = true
	if bIsLearning
		bIsLearning = false
		SetDontMove(false)
		AllowPCDialogue(true)
	endif

;	FW_log.WriteLog("BeeingFemale: FWChildActor - Checking ChildNoEssential...")
;	FW_log.WriteLog("BeeingFemale: FWChildActor - ChildNoEssential is " + System.cfg.ChildNoEssential)
;	ActorBase myChildBase
;	if System.cfg.ChildNoEssential
;		FW_log.WriteLog("BeeingFemale: FWChildActor - ChildNoEssential is turned on!")
;		myChildBase = self.GetActorBase()
;		if(myChildBase.IsUnique())
;			FW_log.WriteLog("BeeingFemale: FWChildActor - Base actor of this child " + self + " is unique, so essential or protected flag will not be removed to prevent bug...")
;		else
;			if(myChildBase.IsEssential())
;				FW_log.WriteLog("BeeingFemale: FWChildActor - Child " + self + " is set to be essential. Removing essential tag...")
;				myChildBase.SetEssential(false)
;			else
;				if(myChildBase.IsProtected())
;					FW_log.WriteLog("BeeingFemale: FWChildActor - Child " + self + " is set to be protected. Removing protected tag...")
;					myChildBase.SetProtected(false)
;				else
;					FW_log.WriteLog("BeeingFemale: FWChildActor - Child " + self + " is neither essential nor protected.")
;				endIf
;			endIf
;		endIf
;	endIf
;	FW_log.WriteLog("BeeingFemale: FWChildActor - Finished checking ChildNoEssential")

	if _Father!=none || _Mother!=none
		InitChild()
	elseif bGivePerkRunning==false
		GivePerks()
	endif
	SetActorValue(ChildSettings.OrderAV(), StorageUtil.GetIntValue(self, "FW.Child.Order", 31))
	RegisterForUpdateGameTime(5)
	OnUpdateGameTime()
	RegisterForUpdate(10)
	bOnLoadRunning = false
	
	if _Name=="" || _Name==Contents.BabyBlankName
		;FWSystemConfig cfg = Game.GetFormFromFile(0x1828, "BeeingFemale.esm") as FWSystemConfig
		;SetName(cfg.System.getRandomChildName(GetSex()))
		SetName(FWSystem.getRandomChildName(GetSex()))
	endif
EndEvent

function InitChild()
	_Father = StorageUtil.GetFormValue(self,"FW.Child.Father",none) as Actor
	_Mother = StorageUtil.GetFormValue(self,"FW.Child.Mother",none) as Actor
	int flag = StorageUtil.GetIntValue(self, "FW.Child.Flag", 0)
	bIsVampire = Math.LogicalAnd(flag,1) == 1
	if Math.LogicalAnd(flag,4) == 4
		iSex=1
	else
		iSex=0
	endif
	Name = StorageUtil.GetStringValue(self,"FW.Child.Name","")
	if (Math.LogicalAnd(flag,2)==2 || Mother==none) && Father!=none
		HairColor = _Father.GetLeveledActorBase().GetHairColor()
	elseif Mother!=none
		HairColor = _Mother.GetLeveledActorBase().GetHairColor()
		endif

	if _Mother!=none
		SetRelationshipRank(_Mother, ChildSettings.ParentRelationShipLevel)
		_Mother.SetRelationshipRank(self, ChildSettings.ParentRelationShipLevel)
		
		if Mother == PlayerRef
;			ChildSettings.AddPlayerChild(self)
			ChildSettings.AddPlayerChild(self as Actor)
			self.SetFactionOwner(PlayerFaction)
		endif
	endif
	if _Father!=none
		SetRelationshipRank(_Father, ChildSettings.ParentRelationShipLevel)
		_Father.SetRelationshipRank(self, ChildSettings.ParentRelationShipLevel)
		
		if Father == PlayerRef
;			ChildSettings.AddPlayerChild(self)
			ChildSettings.AddPlayerChild(self as Actor)
			self.SetFactionOwner(PlayerFaction)
		endif
	endif
	
	;if _Mother!=none && _Father!=none
	;	if _Mother!=PlayerRef && _Father!=PlayerRef
	;		_Mother.SetRelationshipRank(_Father, ChildSettings.ParentRelationShipLevel)
	;		_Father.SetRelationshipRank(_Mother, ChildSettings.ParentRelationShipLevel)
	;	endif
	;endif
	
	; Default 31 (follow & play) matches the OnLoad AV default - previously this
	; used 0, leaving the property at "wait" while the AV said "follow & play"
	Order = StorageUtil.GetIntValue(self,"FW.Child.Order", 31)
	
	;self.SetActorOwner(Mother.GetLeveledActorBase())
	RefreshFactions()
	if bGivePerkRunning==false
		GivePerks()
	endif

	actor ParentActor = StorageUtil.GetFormValue(self, "FW.Child.ParentActor", none) as actor
	if(ParentActor)
	else
		ParentActor = _Mother
	endIf

	; Seed the base maturing duration in game days. _SizeDuration was never
	; initialized anywhere, so it defaulted to 0 -> modifiedSizeDuration is 0 in
	; UpdateSize -> the child snapped to full size, and with "grow into adults"
	; enabled it transitioned to an adult on its first growth tick (the kid and
	; the adult appearing together at birth). Pass none for the UNSCALED base; the
	; per-actor/race MatureTimeScale is applied separately in UpdateSize, so this
	; matches how custom children resolve their duration.
	_SizeDuration = Manager.ActorCustomMatureTimeInHours(none) / 24.0

	FW_log.WriteLog("FWChildActor - InitChild: The child " + self + " is determined by " + ParentActor + " (" + GetActorBaseNameOrNone(ParentActor) + "), whose race is " + ChildRace)
	
	bool bool_AllowPCDialogue = false
	if(StorageUtil.GetIntValue(ParentActor, "FW.AddOn.AllowPCDialogue", 0) == 1)
		bool_AllowPCDialogue = true
	else
		if(StorageUtil.GetIntValue(ChildRace, "FW.AddOn.AllowPCDialogue", 0) == 1)
			bool_AllowPCDialogue = true
		else
			if(StorageUtil.GetIntValue(none, "FW.AddOn.Global_AllowPCDialogue", 0) == 1)
				bool_AllowPCDialogue = true
			endIf
		endIf
	endIf
		
	if(bool_AllowPCDialogue)
		self.AllowPCDialogue(true)
		FW_log.WriteLog("FWChildActor - InitChild: Child " + self + " can talk to player")
	endIf

	RefreshAI()
	UpdateSize()
endFunction

function SetParent(actor akMother, actor akFather)
	;StorageUtil.SetFormValue(self,"FW.Child.Father",akFather)
	;StorageUtil.SetFormValue(self,"FW.Child.Mother",akMother)
	StorageUtil.SetFloatValue(self,"FW.Child.LastUpdate",GameDaysPassed.GetValue())
	Father=akFather
	Mother=akMother
	if Mother == PlayerRef || Father == PlayerRef
;		ChildSettings.AddPlayerChild(self)
		ChildSettings.AddPlayerChild(self as Actor)
	endif
endFunction

Event OnDeath(Actor akKiller)
	StorageUtil.SetFloatValue(self, "FW.Child.DOD", GameDaysPassed.GetValue())
	StorageUtil.SetFloatValue(self,"FW.Child.LastUpdate",GameDaysPassed.GetValue())

	;StorageUtil.GetIntValue(self, "FW.AddOn.StartGrowing", 0)
	StorageUtil.UnsetIntValue(self, "FW.AddOn.StartGrowing")

	UnregisterForUpdate()
	UnregisterForUpdateGameTime()
endEvent

Event OnUpdateGameTime()
	FW_log.WriteLog("FWChildActor - OnUpdateGameTime is called")

	if self.GetType() == 62
		FW_log.WriteLog("FWChildActor - OnUpdateGameTime : Type of " + self + " is kCharacter.")

		if IsDead() == false
			FW_log.WriteLog("FWChildActor - OnUpdateGameTime : " + self + " is not dead. Updating size and etc...")
			
			StorageUtil.SetFloatValue(self,"FW.Child.LastUpdate",GameDaysPassed.GetValue())
			UpdateSize()
			if GetState() == "MarkForDelete"
				; UpdateSize just replaced this child with an adult (Path B):
				; don't refresh stats or re-add the factions DeleteChild stripped.
				; In-place graduates (Path A) keep full child maintenance and orders.
				return
			endif
			UpdateStats()
			RefreshFactions()
		endif
	endif
endEvent

event OnUpdate()
	
endEvent

function UpdateSize()
	FW_log.WriteLog("FWChildActor - UpdateSize is called")
	bool IsGrowing = (StorageUtil.GetIntValue(self, "FW.AddOn.StartGrowing", 0) == 1)

	if(IsGrowing)
		FW_log.WriteLog("FWChildActor - UpdateSize : " + self + " is growing!")
		
		if self.GetType() == 62
			FW_log.WriteLog("FWChildActor - UpdateSize : Type of " + self + " is kCharacter.")

			actor ParentActor = StorageUtil.GetFormValue(self, "FW.Child.ParentActor", none) as actor
			if(ParentActor)
			else
				ParentActor = _Mother
			endIf

			FW_log.WriteLog("FWChildActor - UpdateSize: The child " + self + " is determined by " + ParentActor + " (" + GetActorBaseNameOrNone(ParentActor) + "), whose race is " + ChildRace)
	
			float modifiedSizeDuration = _SizeDuration * Manager.ActorMatureTimeScale(ParentActor)
			float modifiedFinalScale = Manager.ActorFinalScale(ParentActor)
			FW_log.WriteLog("FWChildActor - UpdateSize : modifiedSizeDuration of " + self + " is " + modifiedSizeDuration)
			FW_log.WriteLog("FWChildActor - UpdateSize : modifiedFinalScale of " + self + " is " + modifiedFinalScale)
			
			if(modifiedSizeDuration > 0)
				FW_log.WriteLog("FWChildActor - UpdateSize : modifiedSizeDuration of " + self + " is positive")
				
				If Age >= modifiedSizeDuration
	;				SetScale(1.0)
					SetScale(modifiedFinalScale)

					Manager.AddToSLandBF(self)

					StorageUtil.SetIntValue(self, "FW.AddOn.StartGrowing", 0)
					FW_log.WriteLog("FWChildActor - UpdateSize : " + self + " is fully grown! Current scale is " + GetScale())
					if Manager.ActorGrowUpToAdult(ParentActor)
						System.GrowChildToAdult(self as Actor)
					endif
				elseif Age < 0.0
					SetScale(_SmallSizeScale)

					FW_log.WriteLog("FWChildActor - UpdateSize : The age of " + self + " is negative. Setting the scale to be SmallSizeScale, " + GetScale())
				else
	;				SetScale((((1.0 - _SmallSizeScale) / modifiedSizeDuration) * Age) + _SmallSizeScale)
					SetScale((((modifiedFinalScale - _SmallSizeScale) / modifiedSizeDuration) * Age) + _SmallSizeScale)
					
					FW_log.WriteLog("FWChildActor - UpdateSize : " + self + " is growing! Current scale is " + GetScale())
				endIf
			else
				SetScale(modifiedFinalScale)

				Manager.AddToSLandBF(self)

				StorageUtil.SetIntValue(self, "FW.AddOn.StartGrowing", 0)
				FW_log.WriteLog("FWChildActor - UpdateSize : " + self + " is fully grown! Current scale is " + GetScale())
				if Manager.ActorGrowUpToAdult(ParentActor)
					System.GrowChildToAdult(self as Actor)
				endif
			endIf
		endif
	endIf
endFunction

function UpdateStats()
	RefreshActorValue("CarryWeight", 30)
endFunction

function RefreshActorValue(string ActorValue, float BaseValue = -1.0)
	if BaseValue<0
		BaseValue = GetBaseActorValue(ActorValue)
	endif
	float pav = parent.GetActorValue(ActorValue)
	float cav = StorageUtil.GetFloatValue(self,"FW.Child.Stat"+ActorValue, pav)
	if pav!=cav
		SetActorValue(ActorValue, cav)
		parent.SetActorValue(ActorValue, cav)
	endif
endfunction

function SetStateValue(string StateName, float BaseValue = 0.3)
	float val1 = BaseValue
	float val2 = BaseValue
	if Mother!=none
		val1 = Mother.GetAV(StateName)
	endif
	if Father!=none
		val2 = Father.GetAV(StateName)
	endif
	float newVal = (val1 + val2) / 2
	SetAV(StateName,newVal)
endFunction

bool Function HasFamilyRelationship(Actor akOther = None)
	if akOther==_Mother || akOther==_Father
		return true
	else
		return parent.HasFamilyRelationship(akOther)
	endif
endFunction

int Function GetRelationshipRank(Actor akOther)
	If akOther==_Father || akOther==_Mother
		if parent.GetRelationshipRank(akOther)!=ChildSettings.ParentRelationShipLevel
			SetRelationshipRank(akOther,ChildSettings.ParentRelationShipLevel)
		endif
		if akOther.GetRelationshipRank(self)!=ChildSettings.ParentRelationShipLevel
			akOther.SetRelationshipRank(self,ChildSettings.ParentRelationShipLevel)
		endif
		return ChildSettings.ParentRelationShipLevel
	else
		return parent.GetRelationshipRank(akOther)
	endif
endFunction

bool Function HasParentRelationship(Actor akOther)
	if akOther==Mother || akOther == Father
		return True
	Else
		return parent.HasParentRelationship(akOther)
	endif
endFunction


bool Function IsNearActor(actor akTarget, float Distance)
	Cell targetCell = self.GetParentCell()
	Cell playerCell = akTarget.GetParentCell()
	
	if (targetCell != playerCell)
		if (targetCell && targetCell.IsInterior() || playerCell && playerCell.IsInterior())
			return false
		else
			if (akTarget.GetDistance(self) > Distance)
				return false
			else
				return true
			endif
		endif
	else
		return true
	endif
endFunction


; List of orders
function Order_ShowInventory()
	OpenInventory()
endFunction

; Wait and do nothing
function Order_Wait()
	_order = 0
	PlayerLastSeen = GameDaysPassed.GetValue()
	;SetExpressionOverride(8, 50)
	;SetFactionRank(ChildSettings.Faction_Job, 0)
	RefreshAI()
	GoToState("Wait")
endFunction

; Wait and play
function Order_WaitAndPlay()
	_order = 1
	PlayerLastSeen = GameDaysPassed.GetValue()
	;SetExpressionOverride(10, 70)
	;SetFactionRank(ChildSettings.Faction_Job, 1)
	RefreshAI()
	GoToState("Wait")
endFunction

; Follow / Follow other parent
function Order_Follow(actor ActorToFollow = none)
	if ActorToFollow==none
		ActorToFollow=PlayerRef
	endIf
	If ActorToFollow==PlayerRef
		_order = 30
		;SetFactionRank(ChildSettings.Faction_Job, 2)
		;SetAV("WaitingForPlayer",0)
		;SetPlayerTeammate()
	else
		ChildSettings.SetOtherParentAlias()
		_order = 10
		;SetFactionRank(ChildSettings.Faction_Job, 4)
	endif
	Follow = ActorToFollow
	;SetExpressionOverride(10, 70)
	RefreshAI()
	GoToState("Follow")
endfunction

function Order_FollowAndPlay(actor ActorToFollow = none)
	if ActorToFollow==none
		ActorToFollow=PlayerRef
	endIf
	If ActorToFollow==PlayerRef
		_order = 31
		;SetFactionRank(ChildSettings.Faction_Job, 3)
		SetPlayerTeammate()
	else
		ChildSettings.SetOtherParentAlias(none, false)
		_order = 10
		;SetFactionRank(ChildSettings.Faction_Job, 4)
	endif
	Follow = ActorToFollow
	;SetExpressionOverride(10, 90)
	RefreshAI()
	GoToState("Follow")
endfunction

function Order_FollowAndPlayOther()
	if _Mother==PlayerRef && _Father!=none
		Order_FollowAndPlay(_Father)
	elseif _Mother!=none
		Order_FollowAndPlay(_Mother)
	endif
endFunction

function Order_DoFavour()
	DoFavourStart = Utility.GetCurrentRealTime()
	;SetExpressionOverride(11, 90)
	SetDoingFavor(true)
endFunction

function Order_LeaveMeAlone()
	_order = 99
	;SetExpressionOverride(14, 100)
	;SetFactionRank(ChildSettings.Faction_Job, 6)
	RefreshAI()
	DeleteChild()
endFunction

function Order_GoHome()
	_order = 11
	ChildSettings.SetHouseAlias()
	;SetExpressionOverride(11, 50)
	RefreshAI()
	GoToState(none)
endFunction

function Order_GoToOtherParent()
	Order_FollowAndPlayOther()
	RefreshAI()
	GoToState(none)
endFunction

function Order_DontSleepNow()
	dontSleepStart= GameDaysPassed.GetValue()
	SetFactionRank(Faction_MaySleep,0)
	RefreshAI()
endFunction

bool function Order_ActivateShild()
	return false
endFunction

function Order_MeetPlace()
	_order = 12
	PlayerLastSeen = GameDaysPassed.GetValue()
	;SetExpressionOverride(8, 50)
	;SetFactionRank(ChildSettings.Faction_Job, 0)
	RefreshAI()
	GoToState("Wait")
endFunction

function Order_SetMeetPlace()
	ChildSettings.SetMeetPoint()
	if _order==12
		RefreshAI()
	endif
endFunction

; Only heal the actor when his percent health value is below 'Percent' (percent = 0.0 - 1.0)
bool function Order_Heal(actor ActorToHeal, float Percent = 1.0)
	if ActorToHeal.GetAV("Health") / ActorToHeal.GetAV("MaxHealth")<Percent && ActorToHeal.GetDistance(self) < 500
		; Try to heal
		
	endif
	return false
endFunction

function Order_Dismount()
	Dismount()
endFunction

function DeleteChild()
	UnregisterForUpdate()
	RegisterForUpdate(3)
	RemoveFromAllFactions()
	AllowPCDialogue(false)
	goToState("MarkForDelete")
endFunction

function RefreshAI()
	if _order<30 || _order>=50
		SetActorValue("WaitingForPlayer",1)
		SetPlayerTeammate(false)
	else
		SetActorValue("WaitingForPlayer",0)
		SetPlayerTeammate(true)
	endif
	
;	bool isPlayerChild = false
;	if _Mother!=none
;		if _Mother==PlayerRef
;			isPlayerChild = true
;		endif
;	endif
;	if _Father!=none
;		if _Father==PlayerRef
;			isPlayerChild = true
;		endif
;	endif
;	if isPlayerChild && (_order==1 || _order==31 || (_order >=10 && _order<30))
		;SetActorValue("Variable06", 0)
;		int rnd = Utility.RandomInt(0,10)
		;if rnd==0
		;	SetActorValue("Variable07", 10) ; Ask for Allowance
		;elseif rnd==1
		;	SetActorValue("Variable07", 11) ; Give Gift to Player
		;elseif rnd==2
		;	SetActorValue("Variable07", 12) ; Ask for a Present
		;elseif rnd==3
		;	SetActorValue("Variable07", 13) ; Suggest a Game
		;endif
;	endif
	SetActorValue(ChildSettings.OrderAV(), _order)
	StorageUtil.SetIntValue(self,"FW.Child.Order", _order)
	EnableAI(false)
	EvaluatePackage()
	EnableAI(true)
endFunction

bool bInventoryChangedWheelLearning = false
Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	book iBook = akBaseItem as Book
	if iBook!=none
		if bIsLearning==false
			bIsLearning=true
			Utility.Wait(1)
			CheckInventory()
		else;if iBook!=none
			bInventoryChangedWheelLearning=true
		endIf
	endif
EndEvent

function CheckInventory()
	int c = GetNumItems()
	while c>0
		; Seems some items has been added, restart inventory check
		if bInventoryChangedWheelLearning==true
			c = GetNumItems()
			bInventoryChangedWheelLearning = false
		endif
		c-=1
		book b = GetNthForm(c) as book
		if(b != none)
			learnSpell(b)
		endif
	endWhile
	bIsLearning=false
endfunction

bool bIsLearning = false
bool function learnSpell(book iBook)
	if HasMagicka==false
		return false
	endif
	bIsLearning = true
	bool bLearndSuccess = false
	spell iBookSpell = iBook.GetSpell()
	if iBookSpell!=none
		if HasSpell(iBookSpell)==false && IsAllowedSpell(iBookSpell)
			float comp = GetActorValue("Comprehension")
			Utility.Wait(1)
			AllowPCDialogue(false)
			if IsOnMount() == true
				Dismount()
				SetVehicle(none)
				Utility.Wait(3)
			endIf
			SetDontMove(true)
			float wfp = GetActorValue("WaitingForPlayer")
			float v03 = GetActorValue(ChildSettings.OrderAV())
			SetActorValue("WaitingForPlayer",1)
			SetActorValue(ChildSettings.OrderAV(),0)
			EvaluatePackage()
			
			int HighestRating = 0
			int i = iBookSpell.GetNumEffects()
			EffectShader ShaderSelf
			EffectShader ShaderTarget
			while i>0
				i-=1
				MagicEffect mFX = iBookSpell.GetNthEffectMagicEffect(i)
				if mFX.GetSkillLevel() > HighestRating
					HighestRating = mFX.GetSkillLevel()
				endif
				if mFX.GetHitShader()!=none
					int deliv = mFX.GetDeliveryType()
					if deliv==0
						ShaderSelf=mFX.GetHitShader()
					elseif deliv==2 || deliv==3
						ShaderTarget=mFX.GetHitShader()
					endif
				endif
			endWhile
			float HR = Utility.RandomFloat(HighestRating * 0.8, HighestRating * 1.2)
			if HR>100
				HR=100
			endif
			
			Debug.SendAnimationEvent(self,"ChildReadBook")
			float hrDuration = (comp - HighestRating)/2
			if hrDuration <0
				hrDuration = 0
			endif
			Utility.Wait(3 + (50 - (comp / 2)) + hrDuration)
			Debug.SendAnimationEvent(self,"IdleForceDefaultState")
			Utility.Wait(1)
			if comp >= HR
				bLearndSuccess = true
			endif
			
			if(bLearndSuccess)
				AddSpell(iBookSpell)
				int j = iBookSpell.GetNumEffects()
				while j>0
					j-=1
					magiceffect me= iBookSpell.GetNthEffectMagicEffect(j)
					AddExp(me.GetSkillLevel() / 2)
				endwhile
				EquipSpell(iBookSpell,1)
				DrawWeapon()
				Utility.Wait(3)
				Debug.SendAnimationEvent(self,"ChildCastSpell")
				Utility.Wait(8)
				if ShaderSelf!=none
					ShaderSelf.Play(self,6)
				endif
				if ShaderTarget!=none
					if GetDistance(_Mother)<900
						ShaderTarget.Play(_Mother,4)
					elseif GetDistance(_Father)<900
						ShaderTarget.Play(_Father,4)
					endif
				endif
				Utility.Wait(4)
			endif
			UnequipSpell(iBookSpell,1)
			Utility.Wait(1)
			Debug.SendAnimationEvent(self,"ChildSweat")
			Utility.Wait(2)
			Debug.SendAnimationEvent(self,"IdleForceDefaultState")
			SetActorValue("WaitingForPlayer",wfp)
			SetActorValue(ChildSettings.OrderAV(), v03)
			SetDontMove(false)
			AllowPCDialogue(true)
			EvaluatePackage()
			RemoveItem(iBook,1)
			Utility.Wait(1)
		endif
	endif
	bIsLearning = false
	return bLearndSuccess
endFunction

bool function IsAllowedSpell(spell SpellToLearn)
	if HasMagicka==false
		return false
	endif
	if(SpellToLearn.GetEffectiveMagickaCost(self) * 1.4 > GetActorValue("Magicka"))
		return false
	endif
	int i = SpellToLearn.GetNumEffects()
	while i>0
		i-=1
		;Debug.Notification(i + "'" + SpellToLearn.GetNthEffectMagicEffect(i).GetAssociatedSkill()+ "': " + SpellToLearn.GetNthEffectMagicEffect(i).GetSkillLevel())
		if(SpellToLearn.GetNthEffectMagicEffect(i).GetAssociatedSkill()!="")
			if GetActorValue(SpellToLearn.GetNthEffectMagicEffect(i).GetAssociatedSkill()) < SpellToLearn.GetNthEffectMagicEffect(i).GetSkillLevel()
				return false
			endif
		endif
	endwhile
	return true
endFunction



; Actor Values
int Function GetLevel()
	return StorageUtil.GetIntValue(self, "FW.Child.Level", 1)
endFunction
function SetLevel(int newLevel)

	LevelUpFX.Cast(self,self)
	System.Message(FWUtility.MultiStringReplace(Contents.ChildLevelUp, Name, newLevel),System.MSG_Low)
	
	if(newLevel > FWChildSettings.ChildMaxLevel())
		StorageUtil.SetIntValue(self, "FW.Child.Level", FWChildSettings.ChildMaxLevel())
	elseif(newLevel <1)
		StorageUtil.SetIntValue(self, "FW.Child.Level", 1)
	else
		StorageUtil.SetIntValue(self, "FW.Child.Level", newLevel)
	endif
endFunction
function AddLevel(int Amount = 1)
	if(Amount>0)
		int newLevel = GetLevel() + Amount
		if(newLevel > FWChildSettings.ChildMaxLevel())
			newLevel = FWChildSettings.ChildMaxLevel()
		endif
		StorageUtil.SetIntValue(self, "FW.Child.Level", newLevel)
	endif
endFunction

float function GetExperience()
	return GetAV("Experience")
endFunction
function SetExperience(float newExp)
	SetAV("Experience", newExp)
endfunction
function AddExperience(float Amount)
	if GetLevel()< PlayerRef.GetLevel()
		ModAV("Experience", Amount)
	endif
endFunction
; Alias for Expereance
float function GetExp()
	return GetExperience()
endFunction
function SetExp(float newExp)
	SetExperience(newExp)
endfunction
function AddExp(float Amount)
	AddExperience(Amount)
endFunction

Function ForceActorValue(string asValueName, float afNewValue)
	if IsSpecialAV(asValueName)
		StorageUtil.SetFloatValue(self, "FW.Child.Stat"+asValueName, afNewValue)
	endif
	if asValueName!="Comprehension" && asValueName!="SkillPoints" && asValueName!="PerkPoints" && asValueName!="Experience"
		parent.ForceActorValue(asValueName, afNewValue)
	endif
endFunction

float Function GetActorValue(string asValueName)
	; Mirror of SetActorValue/ModActorValue: special stats live in StorageUtil,
	; everything else (WaitingForPlayer, the order AV, ...) is a real engine AV
	if IsSpecialAV(asValueName)
		return StorageUtil.GetFloatValue(self, "FW.Child.Stat"+asValueName, 0)
	endif
	return parent.GetActorValue(asValueName)
endFunction

float Function GetActorValuePercentage(string asValueName)
	if asValueName=="Comprehension"
		return GetActorValue(asValueName) / 100
	elseif asValueName=="SkillPoints"
		return GetActorValue(asValueName) / (GetLevel() * 5)
	elseif asValueName=="PerkPoints"
		return GetActorValue(asValueName) / GetLevel()
	elseif asValueName=="Experience"
		return GetActorValue(asValueName) / ChildSettings.getExperience(GetLevel())
	;elseif IsSpecialAV(asValueName)
		;return StorageUtil.GetFloatValue(self, "FW.Child.Stat"+asValueName, parent.GetBaseActorValue(asValueName)) / 100
	endIf
	if asValueName!="Comprehension" && asValueName!="SkillPoints" && asValueName!="PerkPoints"
		return parent.GetActorValuePercentage(asValueName)
	endif
endFunction

Function ModActorValue(string asValueName, float afAmount)
	if IsSpecialAV(asValueName)
		StorageUtil.SetFloatValue(self, "FW.Child.Stat"+asValueName, GetActorValue(asValueName) + afAmount)
	endif
	if(asValueName == "Experience" && afAmount>0)
		CheckForLevelUp()
	endIf
	if asValueName!="Comprehension" && asValueName!="SkillPoints" && asValueName!="PerkPoints" && asValueName!="Experience"
		parent.ModActorValue(asValueName, afAmount)
	endif
endFunction

Function SetActorValue(string asValueName, float afValue)
	if IsSpecialAV(asValueName)
		StorageUtil.SetFloatValue(self, "FW.Child.Stat"+asValueName, afValue)
	endif
	if asValueName!="Comprehension" && asValueName!="SkillPoints" && asValueName!="PerkPoints" && asValueName!="Experience"
		parent.SetActorValue(asValueName, afValue)
	endif
	if(asValueName == "Experience")
		CheckForLevelUp()
	endIf
endFunction

float Function GetBaseActorValue(string asValueName)
	if asValueName=="Comprehension"
		return 15
	elseif asValueName=="SkillPoints"
		return 0
	elseif asValueName=="PerkPoints"
		return 0
	;elseif asValueName=="Magicka"
	;	return 30
	;elseif asValueName=="CarryWeight"
	;	return 20
	;elseif asValueName=="Health"
	;	return 80
	elseif asValueName=="Experience"
		return 0
	endif
	return parent.GetBaseActorValue(asValueName)
endFunction

; Actor Value Alias
Function ForceAV(string asValueName, float afNewValue)
  ForceActorValue(asValueName, afNewValue)
EndFunction
float Function GetAV(string asValueName)
  return GetActorValue(asValueName)
EndFunction
float Function GetAVPercentage(string asValueName)
  return GetActorValuePercentage(asValueName)
EndFunction
Function ModAV(string asValueName, float afAmount)
  ModActorValue(asValueName, afAmount)
EndFunction
Function SetAV(string asValueName, float afValue)
  SetActorValue(asValueName, afValue)
EndFunction
float Function GetBaseAV(string asValueName)
  return GetBaseActorValue(asValueName)
EndFunction

int function calculateSkillPoints()
	float BasePoints = 126
	float CurPoints = 0.0

	CurPoints += StorageUtil.GetFloatValue(self, "FW.Child.StatComprehension", GetAV("Comprehension"))
	CurPoints += StorageUtil.GetFloatValue(self, "FW.Child.StatDestruction", GetAV("Destruction"))
	CurPoints += StorageUtil.GetFloatValue(self, "FW.Child.StatIllusion", GetAV("Illusion"))
	CurPoints += StorageUtil.GetFloatValue(self, "FW.Child.StatConjuration", GetAV("Conjuration"))
	CurPoints += StorageUtil.GetFloatValue(self, "FW.Child.StatRestoration", GetAV("Restoration"))
	CurPoints += StorageUtil.GetFloatValue(self, "FW.Child.StatAlteration", GetAV("Alteration"))
	CurPoints += StorageUtil.GetFloatValue(self, "FW.Child.StatBlock", GetAV("Block"))
	CurPoints += StorageUtil.GetFloatValue(self, "FW.Child.StatOneHanded", GetAV("OneHanded"))
	CurPoints += StorageUtil.GetFloatValue(self, "FW.Child.StatTwoHanded", GetAV("TwoHanded"))
	CurPoints += StorageUtil.GetFloatValue(self, "FW.Child.StatMarksman", GetAV("Marksman"))
	CurPoints += StorageUtil.GetFloatValue(self, "FW.Child.StatSneak", GetAV("Sneak"))
	
	CurPoints += StorageUtil.GetFloatValue(self, "FW.Child.StatMagicka", GetAV("Magicka")) / 5
	CurPoints += StorageUtil.GetFloatValue(self, "FW.Child.StatCarryWeight", GetAV("CarryWeight")) / 5
	CurPoints += StorageUtil.GetFloatValue(self, "FW.Child.StatHealth", GetAV("Health")) / 5
	
	return ((GetLevel() - 1) * ChildSettings.SkillpointsPerLevel) - (CurPoints - BasePoints) as int
endFunction

int function calculatePerkPoints()
	; First, give all Perks back
	GivePerks()
	
	; Now calculate perks
	;int basePoints = GetLevel() - 1
	;int i = ChildSettings.ChildPerkFile.length
	;while i>0
	;	i-=1
	;	string p = ChildSettings.ChildPerkFile[i]
	;	if p!=""
	;		int j=ChildSettings.ChildPerkRank[i]
	;		while j>0
	;			j-=1
	;			string modName = FWUtility.ModFile(FWUtility.getIniCString("ChildPerk", p, "Rank"+j,"ModName",""))
	;			int formID = FWUtility.getIniCInt("ChildPerk", p, "Rank"+j,"FormID",0)
	;			if modName!="" && formID>1
	;				spell s = Game.GetFormFromFile(formID,modName) as spell
	;				if s!=none
	;					if HasSpell(s)
	;						basePoints-=j+1
	;						j=0
	;					endif
	;				endif
	;			endif
	;		endWhile
	;	endif
	;endWhile
	int i = 0
	int basePoints = GetLevel() - 1
	while i<128
		string p = ChildSettings.ChildPerkFile[i]
		if p!="" && ChildSettings.ChildPerkEnabled[i]==true
			int pos = StorageUtil.StringListFind(self,"FW.Child.Perks",p)
			if pos>=0
				int currentRank = StorageUtil.IntListGet(self, "FW.Child.PerksLevel", pos)
				basePoints-=currentRank
			endif
		endif
		i+=1
	endwhile
	return basePoints
endFunction

bool bGivePerkRunning=false
function GivePerks()
	;int sc = StorageUtil.FormListCount(self,"FW.Child.Perks")
	;while sc>0
	;	sc-=1
	;	spell s = StorageUtil.FormListGet(self,"FW.Child.Perks",sc) as spell
	;	if s!=none
	;		parent.AddSpell(s)
	;	else
	;		StorageUtil.FormListRemoveAt(self,"FW.Child.Perks",sc)
	;	endif
	;endWhile
	
	;int i = ChildSettings.ChildPerk.length
	;while i>0
	;	i-=1
	;	leveledspell p = ChildSettings.ChildPerk[i]
	;	handlePerk(p)
	;endWhile
	if bGivePerkRunning==true
		return
	endif
	bGivePerkRunning = true
	int i = ChildSettings.ChildPerkFile.length
	while i>0
		i-=1
		handlePerk(i)
	endWhile
	bGivePerkRunning = false
endfunction

function handlePerk(int p)
	if GetType()==0
		return
	endif
	if ChildSettings == none
		return
	endif
	if ChildSettings.GetType()==0
		return
	endif
	if ChildSettings.ChildPerkFile.length<=0
		return
	endif
	
	if p>=0
		if ChildSettings.ChildPerkFile[p]==""
			return
		endif
		int pos = StorageUtil.StringListFind(self, "FW.Child.Perks", ChildSettings.ChildPerkFile[p])
		if pos>=0
			bool bUseAllSpells = ChildSettings.ChildPerkBool[p];p.GetChanceNone()==1
			int level = StorageUtil.IntListGet(self, "FW.Child.PerksLevel", pos)
			int num = ChildSettings.ChildPerkRank[p];p.GetNumForms()
			int rankID=0
			while rankID<num
				rankID+=1
				string modName = FWUtility.ModFile(FWUtility.getIniCString("ChildPerk", ChildSettings.ChildPerkFile[p], "Rank"+rankID,"ModName"))
				int formID = FWUtility.getIniCInt("ChildPerk", ChildSettings.ChildPerkFile[p], "Rank"+rankID,"FormID")
				if modName!="" && formID>1
					form frm = Game.GetFormFromFile(formID,modName)
					if frm!=none
						spell s = frm as spell
						Faction f = frm as Faction
						armor a = frm as armor
						Shout sh = frm as shout
						if s!=none
							if HasSpell(s)
								if (rankID>Level || (rankID<level && !bUseAllSpells))
									RemoveSpell(s)
								else
									; Make sure the effects are active!
									int j = s.GetNumEffects()
									while j>0
										j-=1
										magiceffect me = s.GetNthEffectMagicEffect(j)
										if HasMagicEffect(me)==false
											j=0
											RemoveSpell(s)
											AddSpell(s)
										endif
									endwhile
								endif
							elseif (rankID==level || (rankID<Level && bUseAllSpells))
								AddSpell(s)
							endif
						elseif f!=none
							if (rankID==level || (rankID<Level && bUseAllSpells))
								AddToFaction(f)
							elseif (rankID>Level || (rankID<level && !bUseAllSpells))
								RemoveFromFaction(f)
							endif
						elseif a!=none
							if (rankID==level || (rankID<Level && bUseAllSpells))
								if(GetItemCount(a)==0)
									AddItem(a)
								endif
							elseif (rankID>Level || (rankID<level && !bUseAllSpells))
								if(GetItemCount(a)>0)
									RemoveItem(a)
								endif
							endif
						elseif sh!=none
							if (rankID==level || (rankID<Level && bUseAllSpells))
								if HasSpell(sh)==false
									AddShout(sh)
								endif
							elseif (rankID>Level || (rankID<level && !bUseAllSpells))
								if HasSpell(sh)==true
									RemoveShout(sh)
								endif
							endif
						else
							if(frm==none)
								FW_log.WriteLog("Perk not Found: "+ChildSettings.ChildPerkFile[p]+"["+rankID+"]::No Form - "+modName+" "+formID)
							else
								FW_log.WriteLog("Perk not Found: "+ChildSettings.ChildPerkFile[p]+"["+rankID+"]::"+frm.GetName())
							endif
						endif
					else
						FW_log.WriteLog("Perk not Found: "+ChildSettings.ChildPerkFile[p]+"["+rankID+"]::No Form - "+modName+" "+formID)
					endif
				endif
			endWhile
		elseif p>=0 ; Here were some problems (spaming bug; p = none) - don't know the reason so i've just added this elseif
			int num = ChildSettings.ChildPerkRank[p];p.GetNumForms()
			string pF = ChildSettings.ChildPerkFile[p]
			int rankID=0
			while rankID < num
				rankID+=1
				string mf = FWUtility.getIniCString("ChildPerk", pF, "Rank"+rankID,"ModName")
				string mN = FWUtility.ModFile(mF)
				int formID = FWUtility.getIniCInt("ChildPerk", pF, "Rank"+rankID,"FormID")
				if mN!="" && formID>1
					form frm = Game.GetFormFromFile(formID,mN)
					if frm!=none
						spell s = frm as spell
						Faction f = frm as Faction
						armor a = frm as armor
						Shout sh = frm as shout
						if s!=none
							if HasSpell(s)
								RemoveSpell(s)
							endif
						elseif f!=none
							RemoveFromFaction(f)
						elseif a!=none
							if(GetItemCount(a)>0)
								RemoveItem(a)
							endif
						elseif sh!=none
							if HasSpell(sh)==true
								RemoveShout(sh)
							endif
						endif
					endif
				endif
			endWhile
		endif
	endif
endfunction

bool function IsSpecialAV(string av)
	if av=="Comprehension"
		return true
	elseif av=="Destruction"
		return true
	elseif av=="Illusion"
		return true
	elseif av=="Conjuration"
		return true
	elseif av=="Magicka"
		return true
	elseif av=="CarryWeight"
		return true
	elseif av=="Alteration"
		return true
	elseif av=="Block"
		return true
	elseif av=="Restoration"
		return true
	elseif av=="OneHanded"
		return true
	elseif av=="TwoHanded"
		return true
	elseif av=="Marksman"
		return true
	elseif av=="Health"
		return true
	elseif av=="Sneak"
		return true
	elseif av=="Experience"
		return true
		
	elseif av=="SkillPoints"
		return true
	elseif av=="PerkPoints"
		return true
	endif
	return false
endFunction

function CheckForLevelUp()
	;FW_log.WriteLog("CheckForLevelUp")
	int LevelUpCount=0
	int Level = GetLevel()
	int PlayerLevel = PlayerRef.GetLevel()
	float exp = getExp()
	bool bRunning = true
	int max = 30
	while bRunning
		float expForLevel = ChildSettings.getExperience(Level)
		if exp < expForLevel
			bRunning = false
		endif
		if Level >= FWChildSettings.ChildMaxLevel()
			bRunning = false
		endif
		if Level>PlayerLevel
			bRunning = false
		endif
		if bRunning == true
			exp -= expForLevel
			Level+=1
			LevelUpCount+=1
		endif
		if max <=0
			bRunning = false
		endif
		max-=1
		;FW_log.WriteLog("Had level up")
	endWhile
	if LevelUpCount>0
		StorageUtil.SetFloatValue(self, "FW.Child.StatExperience", exp)
		;Debug.Notification(GetName()+" had a Level-Up (" + Level + ")")
		SetLevel(Level)
		if bIsLearning==false
			CheckInventory()
		endif
	endif
endFunction

;function Delete()
;	DeleteStats()
;	parent.Delete()
;endFunction

function DeleteStats()
	StorageUtil.UnsetStringValue(self,"FW.Child.Name")
	StorageUtil.UnsetIntValue(self,"FW.Child.Flag")
	StorageUtil.UnsetFloatValue(self,"FW.Child.LastUpdate")
	StorageUtil.UnsetFormValue(self,"FW.Child.Mother")
	StorageUtil.UnsetFormValue(self,"FW.Child.Father")
	StorageUtil.UnsetIntValue(self,"FW.Child.Level")
	StorageUtil.UnsetFloatValue(self,"FW.Child.StatExperience")
			
	StorageUtil.UnsetFloatValue(self,"FW.Child.StatComprehension")
	StorageUtil.UnsetFloatValue(self,"FW.Child.StatDestruction")
	StorageUtil.UnsetFloatValue(self,"FW.Child.StatIllusion")
	StorageUtil.UnsetFloatValue(self,"FW.Child.StatConjuration")
	StorageUtil.UnsetFloatValue(self,"FW.Child.StatMagicka")
	
	StorageUtil.UnsetFloatValue(self,"FW.Child.StatRestoration")
	StorageUtil.UnsetFloatValue(self,"FW.Child.StatAlteration")
	StorageUtil.UnsetFloatValue(self,"FW.Child.StatBlock")
	StorageUtil.UnsetFloatValue(self,"FW.Child.StatCarryWeight")
	
	StorageUtil.UnsetFloatValue(self,"FW.Child.StatOneHanded")
	StorageUtil.UnsetFloatValue(self,"FW.Child.StatTwoHanded")
	StorageUtil.UnsetFloatValue(self,"FW.Child.StatMarksman")
	StorageUtil.UnsetFloatValue(self,"FW.Child.StatSneak")
	StorageUtil.UnsetFloatValue(self,"FW.Child.StatHealth")
	
	StorageUtil.UnsetFloatValue(self,"FW.Child.StatSkillPoints")
	StorageUtil.UnsetFloatValue(self,"FW.Child.StatPerkPoints")
	
	StorageUtil.FormListClear(self, "FW.Child.Perks")
	StorageUtil.IntListClear(self, "FW.Child.PerksLevel")
endfunction

state Follow

EndState

state MarkForDelete
	event OnUpdate()
		if self
			if IsOnMount()
				Dismount()
			endif
;			if Is3DLoaded()
;				if HasLos(PlayerRef) == false && IsNearActor(PlayerRef,2000)==false
					UnregisterForUpdate()
					UnregisterForUpdateGameTime()
					Disable(true)
					DeleteStats()
					StorageUtil.FormListRemove(none, "FW.Babys", self)
					Delete()
;				endif
;			endif
		endif
	endEvent
endState

state Wait
	;event OnUpdate()
	;	if self
	;		if parent.Is3DLoaded()
	;			if HasLos(PlayerRef)
	;				PlayerLastSeen = GameDaysPassed.GetValue()
	;			endif
	;		endif
	;	endif
	;endEvent
endState

Event OnActivate(ObjectReference akActionRef)
	actor a = akActionRef as Actor
	if a.GetType()==62 && self.GetType()==62
		if IsBleedingOut()==true
			if a.IsInCombat() == false
				RestoreActorValue("Health", 9999)
				DamageActorValue("Health", GetActorValue("Health") - 10)
			endif
		endif
		if a==_Father || a==_Mother
			SetRelationshipRank(a,ChildSettings.ParentRelationShipLevel)
			a.SetRelationshipRank(self,ChildSettings.ParentRelationShipLevel)
		else
			SetRelationshipRank(a,0)
		endif
		
		;DebugFactions()
		EvaluatePackage()
	endif
	
	; Make sure the child is in the baby list
	if( StorageUtil.FormListHas(none, "FW.Babys", self)== false)
		StorageUtil.FormListAdd(none, "FW.Babys", self)
	endif
endEvent
