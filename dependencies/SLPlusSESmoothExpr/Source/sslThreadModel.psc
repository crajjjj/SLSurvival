scriptname sslThreadModel extends Quest hidden
{ Animation Thread Model: Runs storage and information about a thread. Access only through functions; NEVER create a property directly to this. }

; import sslUtility
; import StorageUtil
; import SexLabUtil

int thread_id
int property tid hidden
	int function get()
		return thread_id
	endFunction
endProperty

bool property IsLocked hidden
	bool function get()
		return GetState() != "Unlocked"
	endFunction
endProperty

; Library & Data
sslSystemConfig property Config auto
sslActorLibrary property ActorLib auto
sslThreadLibrary property ThreadLib auto
sslAnimationSlots property AnimSlots auto
sslCreatureAnimationSlots property CreatureSlots auto

; Actor Info
sslActorAlias[] property ActorAlias auto hidden
Actor[] property Positions auto hidden
Actor property PlayerRef auto hidden

; Thread status
; bool[] property Status auto hidden
bool property SortActors auto hidden
bool property HasPlayer auto hidden
bool property AutoAdvance auto hidden
bool property LeadIn auto hidden
bool property FastEnd auto hidden

; Creature animation
Race property CreatureRef auto hidden

; Animation Info
int property Stage auto hidden
int property ActorCount auto hidden
Sound property SoundFX auto hidden
string property AdjustKey auto hidden
string[] property AnimEvents auto hidden

sslBaseAnimation property Animation auto hidden
sslBaseAnimation property StartingAnimation auto hidden
sslBaseAnimation[] CustomAnimations
sslBaseAnimation[] PrimaryAnimations
sslBaseAnimation[] LeadAnimations
sslBaseAnimation[] property Animations hidden
	sslBaseAnimation[] function get()
		if CustomAnimations.Length > 0
			return CustomAnimations
		elseIf LeadIn
			return LeadAnimations
		else
			return PrimaryAnimations
		endIf
	endFunction
endProperty

; Stat Tracking Info
float[] property SkillBonus auto hidden ; [0] Foreplay, [1] Vaginal, [2] Anal, [3] Oral, [4] Pure, [5] Lewd
float[] property SkillXP auto hidden    ; [0] Foreplay, [1] Vaginal, [2] Anal, [3] Oral, [4] Pure, [5] Lewd

bool[] property IsType auto hidden ; [0] IsAggressive, [1] IsVaginal, [2] IsAnal, [3] IsOral, [4] IsLoving, [5] IsDirty, [6] HadVaginal, [7] HadAnal, [8] HadOral
bool property IsAggressive hidden
	bool function get()
		return IsType[0]
	endfunction
	function set(bool value)
		IsType[0] = value
	endFunction
endProperty
bool property IsVaginal hidden
	bool function get()
		return IsType[1]
	endfunction
	function set(bool value)
		IsType[1] = value
	endFunction
endProperty
bool property IsAnal hidden
	bool function get()
		return IsType[2]
	endfunction
	function set(bool value)
		IsType[2] = value
	endFunction
endProperty
bool property IsOral hidden
	bool function get()
		return IsType[3]
	endfunction
	function set(bool value)
		IsType[3] = value
	endFunction
endProperty
bool property IsLoving hidden
	bool function get()
		return IsType[4]
	endfunction
	function set(bool value)
		IsType[4] = value
	endFunction
endProperty
bool property IsDirty hidden
	bool function get()
		return IsType[5]
	endfunction
	function set(bool value)
		IsType[5] = value
	endFunction
endProperty


; Timer Info
bool UseCustomTimers
float[] CustomTimers
float[] ConfigTimers
float[] property Timers hidden
	float[] function get()
		if UseCustomTimers
			return CustomTimers
		endIf
		return ConfigTimers
	endFunction
	function set(float[] value)
	;	if UseCustomTimers
	;		CustomTimers = value
	;	else
	;		ConfigTimers = value
	;	endIf
	if !value || value.Length < 1
		Log("Set() - Empty timers given for property Timers.", "ERROR")
	else
		CustomTimers    = value
		UseCustomTimers = true
	endIf
	endFunction
endProperty

; Thread info
float[] property CenterLocation auto hidden
ObjectReference property CenterRef auto hidden
ReferenceAlias property CenterAlias auto hidden

float[] property RealTime auto hidden
float property StartedAt auto hidden
float property TotalTime hidden
	float function get()
		return RealTime[0] - StartedAt
	endFunction
endProperty

Actor[] property Victims auto hidden
Actor property VictimRef hidden
	Actor function get()
		if Victims
			return Victims[0]
		endIf
		return none
	endFunction
	function set(Actor ActorRef)
		if ActorRef && (!Victims || Victims.Find(ActorRef) == -1)
			Victims = PapyrusUtil.PushActor(Victims, ActorRef)
		endIf
		IsAggressive = ActorRef != none && Victims
	endFunction
endProperty

bool property DisableOrgasms auto hidden

int property HiddenStatus auto hidden
bool property UseNPCHidden hidden
	bool function get()
		int NPCHidden = Config.NPCHidden
		return NPCHidden == 2 || (NPCHidden == 1 && (Utility.RandomInt(0, 2) as bool))
	endFunction
endProperty

; Beds
int[] property BedStatus auto hidden
; BedStatus[0] = -1 forbid, 0 allow, 1 force
; BedStatus[1] = 0 none, 1 bedroll, 2 single, 3 double
ObjectReference property BedRef auto hidden
int property BedTypeID hidden
	int function get()
		return BedStatus[1]
	endFunction
endProperty
bool property UsingBed hidden
	bool function get()
		return BedStatus[1] > 0
	endFunction
endProperty
bool property UsingBedRoll hidden
	bool function get()
		return BedStatus[1] == 1
	endFunction
endProperty
bool property UsingSingleBed hidden
	bool function get()
		return BedStatus[1] == 2
	endFunction
endProperty
bool property UsingDoubleBed hidden
	bool function get()
		return BedStatus[1] == 3
	endFunction
endProperty
bool property UseNPCBed hidden
	bool function get()
		int NPCBed = Config.NPCBed
		return NPCBed == 2 || (HiddenStatus == 1 && NPCBed > 0) || (NPCBed == 1 && (Utility.RandomInt(0, 2) as bool))
	endFunction
endProperty

;Furnitures
int[] property FurnitureStatus auto hidden
; FurnitureStatus[0] = -1 forbid, 0 allow, 1 force
; FurnitureStatus[1] = 0 none, 1 bedroll, 2 single, 3 double, 4 Chair, 5 Throne, 6 Bench, 7 Table, 8 AlchemysTable , ...
ObjectReference property FurnitureRef auto hidden
int property FurnitureTypeID hidden
	int function get()
		return FurnitureStatus[1]
	endFunction
endProperty
bool property UsingFurniture hidden
	bool function get()
		return FurnitureStatus[1] > 0
	endFunction
endProperty
bool property UsingFurnitureExtra hidden
	bool function get()
		return FurnitureStatus[1] >= 4 && FurnitureStatus[1] < 4+Config.FurnitureExtraLists.Length
	endFunction
endProperty
bool property UsingFurnitureRestrain hidden
	bool function get()
		return FurnitureStatus[1] >= Config.FurnitureExtraLists.Length
	endFunction
endProperty
bool property UseNPCFurniture hidden
	bool function get()
		int NPCFurniture = Config.NPCFurniture
		return NPCFurniture == 2 || (HiddenStatus == 1 && NPCFurniture > 0) || (NPCFurniture == 1 && (Utility.RandomInt(0, 2) as bool))
	endFunction
endProperty
Package property UseFurniturePackage auto

; Genders
int[] property Futas auto hidden
int[] property Genders auto hidden
int property Males hidden
	int function get()
		return Genders[0]
	endFunction
endProperty
int property Females hidden
	int function get()
		return Genders[1]
	endFunction
endProperty
int property MaleCreatures hidden
	int function get()
		return Genders[2]
	endFunction
endProperty
int property FemaleCreatures hidden
	int function get()
		return Genders[3]
	endFunction
endProperty
int property Creatures hidden
	int function get()
		return Genders[2] + Genders[3]
	endFunction
endProperty
bool property HasCreature hidden
	bool function get()
		return Creatures > 0
	endFunction
endProperty

; Local readonly
bool NoLeadIn
string[] Hooks
string[] Tags
string ActorKeys

; Debug testing
bool property DebugMode auto hidden
float property t auto hidden

; ------------------------------------------------------- ;
; --- Thread Making API                               --- ;
; ------------------------------------------------------- ;

state Making
	event OnUpdate()
		Fatal("Thread has timed out of the making process; resetting model for selection pool")
	endEvent
	event OnBeginState()
		Log("Entering Making State")
		; Action Events
		RegisterForModEvent(Key("RealignActors"), "RealignActors") ; To be used by the ConfigMenu without the CloseConfig issue
		RegisterForModEvent(Key(EventTypes[0]+"Done"), EventTypes[0]+"Done")
		RegisterForModEvent(Key(EventTypes[1]+"Done"), EventTypes[1]+"Done")
		RegisterForModEvent(Key(EventTypes[2]+"Done"), EventTypes[2]+"Done")
		RegisterForModEvent(Key(EventTypes[3]+"Done"), EventTypes[3]+"Done")
		RegisterForModEvent(Key(EventTypes[4]+"Done"), EventTypes[4]+"Done")
	endEvent

	int function AddActor(Actor ActorRef, bool IsVictim = false, sslBaseVoice Voice = none, bool ForceSilent = false)
		; Ensure we can add actor to thread
		if !ActorRef
			Fatal("Failed to add actor -- Actor is a figment of your imagination", "AddActor(NONE)")
			return -1
		elseIf ActorCount >= 5
			Fatal("Failed to add actor -- Thread has reached actor limit", "AddActor("+ActorRef.GetLeveledActorBase().GetName()+")")
			return -1
		elseIf Positions.Find(ActorRef) != -1
			Fatal("AddActor("+ActorRef.GetLeveledActorBase().GetName()+") -- Failed to add actor -- They have been already added to this thread", "AddActor("+ActorRef.GetLeveledActorBase().GetName()+")")
			return -1
		elseIf ActorLib.ValidateActor(ActorRef) < 0
			Fatal("AddActor("+ActorRef.GetLeveledActorBase().GetName()+") -- Failed to add actor -- They are not a valid target for animation", "AddActor("+ActorRef.GetLeveledActorBase().GetName()+")")
			return -1
		endIf
		sslActorAlias Slot = PickAlias(ActorRef)
		if !Slot || !Slot.SetActor(ActorRef)
			Fatal("AddActor("+ActorRef.GetLeveledActorBase().GetName()+") -- Failed to add actor -- They were unable to fill an actor alias", "AddActor("+ActorRef.GetLeveledActorBase().GetName()+")")
			return -1
		endIf
		; Update position info
		Positions  = PapyrusUtil.PushActor(Positions, ActorRef)
		ActorCount = Positions.Length
		; Update gender counts
		int g      = Slot.GetGender()
		Genders[g] = Genders[g] + 1
		if Slot.GetIsFuta()
			Futas[g] = Futas[g] + 1
		endIf
		; Flag as victim
		Slot.SetVictim(IsVictim)
		Slot.SetVoice(Voice, ForceSilent)
		; Return position
		return Positions.Find(ActorRef)
	endFunction

	bool function AddActors(Actor[] ActorList, Actor VictimActor = none)
		int Count = ActorList.Length
		if Count < 1 || ((Positions.Length + Count) > 5) || ActorList.Find(none) != -1
			Fatal("Failed to add actor list as it either contains to many actors placing the thread over it's limit, none at all, or an invalid 'None' entry -- "+ActorList, "AddActors()")
			return false
		endIf
		int i
		while i < Count
			if AddActor(ActorList[i], (ActorList[i] == VictimActor)) == -1
				return false
			endIf
			i += 1
		endWhile
		return true
	endFunction

	sslThreadController function StartThread()
		GoToState("Starting")
		UnregisterForUpdate()
		int i

		ThreadHooks = Config.GetThreadHooks()
		HookAnimationStarting()
		SendThreadEvent("AnimationStarting")

		; ------------------------- ;
		; --   Validate Thread   -- ;
		; ------------------------- ;

		if Positions.Find(none) != -1 || ActorCount != Positions.Length || Futas.Length < 4
			Positions  = PapyrusUtil.RemoveActor(Positions, none)
			ActorCount = Positions.Length
			Genders    = ActorLib.GenderCount(Positions)
			Futas      = ActorLib.TransCount(Positions)
			HasPlayer  = Positions.Find(PlayerRef) != -1
		endIf

		if ActorCount < 1 || Positions.Length < 1
			Fatal("No valid actors available for animation")
			return none
		endIf

		; ------------------------- ;
		; -- Validate Animations -- ;
		; ------------------------- ;

		; ToDo: Use the PapyrusUtil GetMatchingString function to build the common tags
		; Define common tags
		string[] CommonTag = new String[15]
		CommonTag[0] = "Aggressive"
		CommonTag[1] = "Oral"
		CommonTag[2] = "Anal"
		CommonTag[3] = "Vaginal"
		CommonTag[4] = "Pussy"
		CommonTag[5] = "Cunnilingus"
		CommonTag[6] = "Kissing"
		CommonTag[7] = "Blowjob"
		CommonTag[8] = "Boobjob"
		CommonTag[9] = "Footjob"
		CommonTag[10] = "Handjob"
		CommonTag[11] = "Masturbation"
		CommonTag[12] = "Furniture"
		CommonTag[13] = "BedOnly"
		CommonTag[14] = "FurnitureOnly"

		; primary animations
		i = PrimaryAnimations.Length
		if i
			; Add the most commond tags to the thread to check for it on the animation list
			int tagid = 0
			AddTags(CommonTag)
			;validate animations
			bool[] Valid = Utility.CreateBoolArray(i)
			while i
				i -= 1
				Valid[i] = PrimaryAnimations[i] && PrimaryAnimations[i].PositionCount == ActorCount && (!HasCreature || (PrimaryAnimations[i].HasRace(CreatureRef) && PrimaryAnimations[i].Creatures == Creatures))
				; update the thread tags
				if Valid[i]
					tagid = 0
					while tagid < CommonTag.length
						if HasTag(CommonTag[tagid]) && !PrimaryAnimations[i].HasTag(CommonTag[tagid])
							RemoveTag(CommonTag[tagid])
						endIf
						tagid += 1
					endWhile
				endIf
			endWhile
			; Check results
			if Valid.Find(true) == -1
				Log("Invalid animation list")
				PrimaryAnimations = sslUtility.AnimationArray(0) ; No valid animations
			elseIf Valid.Find(false) >= 0
				; Filter output
				i = PrimaryAnimations.Length
				int n = PapyrusUtil.CountBool(Valid, true)
				sslBaseAnimation[] Output = sslUtility.AnimationArray(n)
				while i && n
					i -= 1
					if Valid[i]
						n -= 1
						Output[n] = PrimaryAnimations[i]
					else
						Log("Invalid animation added - "+PrimaryAnimations[i])
					endIf
				endWhile
				PrimaryAnimations = Output
			endIf
		endIf
		; custom animations
		i = CustomAnimations.Length
		if i
			; Add the most commond tags to the thread to check for it on the animation list
			int tagid = 0
			AddTags(CommonTag)
			;validate animations
			bool[] Valid = Utility.CreateBoolArray(i)
			while i
				i -= 1
				Valid[i] = CustomAnimations[i] && CustomAnimations[i].PositionCount == ActorCount && (!HasCreature || (CustomAnimations[i].HasRace(CreatureRef) && CustomAnimations[i].Creatures == Creatures))
				; update the thread tags
				if Valid[i]
					tagid = 0
					while tagid < CommonTag.length
						if HasTag(CommonTag[tagid]) && !CustomAnimations[i].HasTag(CommonTag[tagid])
							RemoveTag(CommonTag[tagid])
						endIf
						tagid += 1
					endWhile
				endIf
			endWhile
			; Check results
			if Valid.Find(true) == -1
				Log("Invalid custom animation list")
				CustomAnimations = sslUtility.AnimationArray(0) ; No valid animations
			elseIf Valid.Find(false) >= 0
				; Filter output
				i = CustomAnimations.Length
				int n = PapyrusUtil.CountBool(Valid, true)
				sslBaseAnimation[] Output = sslUtility.AnimationArray(n)
				while i && n
					i -= 1
					if Valid[i]
						n -= 1
						Output[n] = CustomAnimations[i]
					else
						Log("Invalid custom animation added - "+CustomAnimations[i])
					endIf
				endWhile
				CustomAnimations = Output
			endIf
		endIf

		; Check LeadIn CoolDown and conditions
		float LeadInCoolDown = Math.Abs(SexLabUtil.GetCurrentGameRealTime() - StorageUtil.GetFloatValue(Config,"SexLab.LastLeadInEnd",0))
		if CustomAnimations.Length
			NoLeadIn = true
			if LeadIn
				Log("WARNING: LeadIn detected on Forced Animations. Disabling LeadIn")
				LeadIn = false
			endIf
		elseIf LeadIn
			; leadin animations
			i = LeadAnimations.Length
			if i
				bool[] Valid = Utility.CreateBoolArray(i)
				while i
					i -= 1
					Valid[i] = LeadAnimations[i] && LeadAnimations[i].PositionCount == ActorCount && (!HasCreature || (LeadAnimations[i].HasRace(CreatureRef) && LeadAnimations[i].Creatures == Creatures))
				endWhile
				; Check results
				if Valid.Find(true) == -1
					Log("Invalid lead in animation list")
					LeadAnimations = sslUtility.AnimationArray(0) ; No valid animations
					LeadIn = false
				elseIf Valid.Find(false) >= 0
					; Filter output
					i = LeadAnimations.Length
					int n = PapyrusUtil.CountBool(Valid, true)
					sslBaseAnimation[] Output = sslUtility.AnimationArray(n)
					while i && n
						i -= 1
						if Valid[i]
							n -= 1
							Output[n] = LeadAnimations[i]
						else
							Log("Invalid lead in animation added - "+LeadAnimations[i])
						endIf
					endWhile
					LeadAnimations = Output
				endIf
			endIf
		elseIf LeadInCoolDown < Config.LeadInCoolDown
			Log("LeadIn CoolDown "+LeadInCoolDown+"::"+Config.LeadInCoolDown)
			DisableLeadIn(True)
		elseIf Config.LeadInCoolDown > 0 && PrimaryAnimations && PrimaryAnimations.Length && !(HasTag("Anal") || HasTag("Vaginal")) && (HasTag("Oral") || HasTag("Cunnilingus") || HasTag("Blowjob") || HasTag("Boobjob") || HasTag("Footjob") || HasTag("Handjob") || HasTag("Masturbation") || HasTag("Kissing"))
			Log("None of the PrimaryAnimations have 'Anal' or 'Vaginal' tags. Disabling LeadIn")
			DisableLeadIn(True)
		endIf
		
		
		; ------------------------- ;
		; --    Locate Center    -- ;
		; ------------------------- ;

		; Search location marker near player or first position
		if !CenterRef
			if HasPlayer
				CenterOnObject(Game.FindClosestReferenceOfTypeFromRef(Config.LocationMarker, PlayerRef, 750.0))
			else
				CenterOnObject(Game.FindClosestReferenceOfTypeFromRef(Config.LocationMarker, Positions[0], 750.0))
			endIf
		endIf
		
		if !Config.AllowFurniture
			FurnitureStatus[0] = -1
		endIf
		
	;	if BedStatus[0] == 0 && (!HasPlayer && Config.NPCBed == 0) || (HasPlayer && AskBed == 0)
	;		BedStatus[0] = -1
	;	endIf
		
		; Check for restricted actor to prevent furniture detection
		if !CenterRef && FurnitureStatus[0] != -1 && (Config.ManageZadFilter || Config.ManageZazFilter) && ActorCount != Creatures
			i = ActorCount
			while i
				i -= 1
				sslActorAlias Slot = ActorAlias(Positions[i])
				if Slot && Slot.GetRestricted()
					FurnitureStatus[0] = -1
				;	BedStatus[0] = -1
					i = 0
				endIf
			endWhile
		endIf
		
		; Allow Manually Search Hidden locations
		if HiddenStatus == 0
			if (!HasPlayer && Config.NPCHidden == 0) || (HasPlayer && (Config.UseXMarkerHidden == 0 || (Config.UseXMarkerHidden == 2 && !(Config.DisablePlayer && IsVictim(PlayerRef)))))
				HiddenStatus = -1
			elseIf (!HasPlayer && Config.NPCHidden > 1) || (HasPlayer && Config.UseXMarkerHidden > 2)
				HiddenStatus = 1
			endIf
		endIf
		if !CenterRef && HasPlayer && Config.HasUtilityPlus && HiddenStatus == 0 && !(Config.DisablePlayer && IsVictim(PlayerRef))
			int option = Config.FollowPlayer.Show()
			if option == 1
				PlayerRef.SetFactionRank(Config.AnimatingFaction, 1)
				Log("RealTime:["+Utility.GetCurrentRealTime()+"]", "MoveScene(StartThread)")
				MoveScene()
				i = 60 ; Time to wait
				while i && !CenterRef
					i -= 1
					Utility.Wait(1.0)
					if !PlayerRef.IsInFaction(Config.AnimatingFaction)
						PlayerRef.SetFactionRank(Config.AnimatingFaction, 0) ; In case some mod call ValidateActor function.
					endIf
				endWhile
				HiddenStatus = 0
				Log("FollowPlayer End Waiting CenterRef:"+CenterRef)
			ElseIf option == 2
				CenterOnObject(PlayerRef)
			ElseIf option == 3
				HiddenStatus = -1
			endIf
		endIf
		log("HiddenStatus: "+ HiddenStatus)

		If Config.UseAdvancedFurn
			If !CenterRef
				CenterOnFurniture(HasPlayer, 750.0)
			endIf
			if (CenterRef as Actor)
				CenterOnNearFurniture(CenterRef, 300, HasPlayer)
			endIf
		Else
			; Search for nearby Furniture
			If !CenterRef ;|| ( && (CenterRef as Actor).GetFurnitureReference())
				CenterOnFurniture(HasPlayer, 750.0)
			endIf
			
			; Search for nearby bed
			if !CenterRef && BedStatus[0] != -1 && ActorCount != Creatures && !HasTag("Furniture")
				CenterOnBed(HasPlayer, 750.0)
			endIf
			
			if (CenterRef as Actor)
				if BedStatus[0] == 1 || !CenterOnNearFurniture(CenterRef, 300, HasPlayer) && ActorCount != Creatures && !HasTag("Furniture")
					CenterOnNearBed(CenterRef, 300, HasPlayer)
				endIf
			endIf
		EndIf

		; Automatic Search location marker Hidden Place near player or first position
		if !CenterRef && ActorCount != Creatures
			CenterOnHiddenMarker(HasPlayer, 2400)
		endIf
		
		; Center on fallback choices
		if !CenterRef
			if IsAggressive && !(VictimRef.GetFurnitureReference() || VictimRef.IsSwimming() || VictimRef.IsFlying())
				CenterOnObject(VictimRef)
			elseIf HasPlayer && !(PlayerRef.GetFurnitureReference() || PlayerRef.IsSwimming() || PlayerRef.IsFlying())
				CenterOnObject(PlayerRef)
			else
				i = 0
				while i < ActorCount
					if !(Positions[i].GetFurnitureReference() || Positions[i].IsSwimming() || Positions[i].IsFlying())
						CenterOnObject(Positions[i])
						i = ActorCount
					endIf
					i += 1
				endWhile
			endIf
		endIf
		
		; Center on first actor as last choice
		if !CenterRef
			CenterOnObject(Positions[0])
		endIf
		
		if HasCreature
			Log("CreatureRef: "+CreatureRef)
			if SortActors && ActorCount != Creatures
				Positions = ThreadLib.SortCreatures(Positions) ; required even if is already on the SetAnimation fuction
			endIf
		endIf
		
		if Config.ShowInMap && !HasPlayer && PlayerRef.GetDistance(CenterRef) > 750
			SetObjectiveDisplayed(0, True)
		endIf

		; Travel to the CenterRef and prestrip while the filter are being applied
		QuickEvent("TravelToCenter")
		
		; Get default foreplay if none and enabled
		if Config.ForeplayStage && !NoLeadIn && LeadAnimations.Length == 0 && ActorCount > 1 ; && !IsAggressive 
			if !HasCreature
				int RealMales = Males - Futas[0]
				if Males > 0 && RealMales == 0
					RealMales = -1
				endIf
				int RealFemales = Females - Futas[1]
				if Females > 0 && RealFemales == 0
					RealFemales = -1
				endIf
				SetLeadAnimations(AnimSlots.GetByType(ActorCount, RealMales, RealFemales, -1, IsAggressive, False))
			else
				SetLeadAnimations(CreatureSlots.GetByCreatureActorsTags(ActorCount, Positions, SexLabUtil.StringIfElse(IsAggressive,"Aggressive,LeadIn","LeadIn")))
			endIf
		endIf

		; Filter animations based on user settings and scene
		if FilterAnimations() < 0
			return none
		endIf

		; ------------------------- ;
		; --  Start Controller   -- ;
		; ------------------------- ;

		Action("Prepare")
		return self as sslThreadController
	endFunction

endState

bool hkReady
int hkMoveScene
state Starting
	event OnUpdate()
		Log("Thread has timed out of the starting MoveScene process; resetting model for selection pool")
		; StateCheck()
		if hkReady
			if Utility.IsInMenuMode()
				Utility.Wait(0.1)
				RegisterForSingleUpdate(8.0)
			else
				Log("RealTime:["+Utility.GetCurrentRealTime()+"]", "MoveScene(OnUpdate)")
				MoveScene()
			endIf
		endIf
	endEvent
	event OnBeginState()
		Log("Entering Starting State")
		hkMoveScene = Config.MoveScene
	endEvent

	event OnKeyDown(int KeyCode)
		; StateCheck()
		if hkReady && !Utility.IsInMenuMode() ; || UI.IsMenuOpen("Console") || UI.IsMenuOpen("Loading Menu")
			hkReady = false
			; Move Scene
			if KeyCode == hkMoveScene
				Log("RealTime:["+Utility.GetCurrentRealTime()+"]", "MoveScene(OnKeyDown)")
				MoveScene()

			endIf
			hkReady = true
		endIf
	endEvent

	function MoveScene()
		hkReady = false
		UnregisterForUpdate()
		; Processing Furnitures
	;	int PreFurnitureStatus = FurnitureTypeID
		if CenterRef
			if UsingFurniture && CenterRef.IsActivationBlocked()
				SetFurnitureIgnored(false)
			elseIf CenterRef.GetBaseObject() == Config.XMarkerHiddenPlace
				CenterRef.Enable()
			endIf
		endIf
		; Enable Controls
		if Config.GetThreadControlled() == (self as sslThreadController) || PlayerRef.IsInFaction(Config.AnimatingFaction) && PlayerRef.GetFactionRank(Config.AnimatingFaction) != 0
			if !HasPlayer
				Config.DisableThreadControl(self as sslThreadController)
			endIf
			PlayerRef.SetFactionRank(Config.AnimatingFaction, 0)
			Debug.Notification("Player movement unlocked - repositioning scene in 15 seconds...")
		;	int i
		;	while i < ActorCount
		;		actor ActorRef = Positions[i]
		;		if ActorRef != none && ActorRef != PlayerRef
		;			ActorRef.SetFactionRank(Config.AnimatingFaction, 2)
		;			ActorRef.EvaluatePackage()
		;		endIf
		;		i += 1
		;	endWhile
			
			CenterAlias.TryToClear()
			CenterAlias.ForceRefTo(PlayerRef) ; Make them follow me

			UnregisterForUpdate()
			
			; Lock hotkeys and wait 15 seconds
			Utility.WaitMenuMode(1.0)
			RegisterForKey(hkMoveScene)
			; Ready
			UnregisterForUpdate()
			RegisterForSingleUpdate(15.0)
			Log("RealTime:["+Utility.GetCurrentRealTime()+"]", "MoveScene()")
		
		elseIf PlayerRef.GetFactionRank(Config.AnimatingFaction) == 0
			UnregisterForKey(hkMoveScene)
			UnregisterForUpdate()
			Debug.Notification("Player movement locked - repositioning scene...")
			; Disable Controls
			if !HasPlayer
				Config.GetThreadControl(self as sslThreadController)
			endIf
			; Clear CenterAlias to avoid player repositioning to previous position
			if CenterAlias.GetReference() != none
				CenterAlias.TryToClear()
			endIf
			; Give player time to settle incase airborne
			Utility.Wait(1.0)
		;	int i
		;	while i < ActorCount
		;		actor ActorRef = Positions[i]
		;		if ActorRef != none && ActorRef != PlayerRef
		;			ActorRef.SetFactionRank(Config.AnimatingFaction, 0)
		;			ActorRef.EvaluatePackage()
		;		endIf
		;		i += 1
		;	endWhile
			; Center on player position 
			CenterOnObject(PlayerRef)
		endIf
		hkReady = true
	endFunction

endState

; ------------------------------------------------------- ;
; --- Actor Setup                                     --- ;
; ------------------------------------------------------- ;

bool function UseLimitedStrip()
	bool LeadInNoBody = !(Config.StripLeadInMale[2] || Config.StripLeadInFemale[2])
	return (LeadIn && (!LeadInNoBody || AnimSlots.CountTag(Animations, "LimitedStrip") == Animations.Length)) || (Config.LimitedStrip && ((!LeadInNoBody && AnimSlots.CountTag(Animations, "Kissing,Foreplay,LeadIn,LimitedStrip") == Animations.Length) || (LeadInNoBody && AnimSlots.CountTag(Animations, "LimitedStrip") == Animations.Length)))
endFunction

; Actor Overrides
function SetStrip(Actor ActorRef, bool[] StripSlots)
	if StripSlots && StripSlots.Length == 33
		ActorAlias(ActorRef).OverrideStrip(StripSlots)
	else
		Log("Malformed StripSlots bool[] passed, must be 33 length bool array, "+StripSlots.Length+" given", "ERROR")
	endIf
endFunction

function SetNoStripping(Actor ActorRef)
	if ActorRef
		bool[] StripSlots = new bool[33]
		sslActorAlias Slot = ActorAlias(ActorRef)
		if Slot
			Slot.OverrideStrip(StripSlots)
			Slot.DoUndress = false
		endIf
	endIf
endFunction

function DisableUndressAnimation(Actor ActorRef = none, bool disabling = true)
	if ActorRef && Positions.Find(ActorRef) != -1
		ActorAlias(ActorRef).DoUndress = !disabling
	else
		ActorAlias[0].DoUndress = !disabling
		ActorAlias[1].DoUndress = !disabling
		ActorAlias[2].DoUndress = !disabling
		ActorAlias[3].DoUndress = !disabling
		ActorAlias[4].DoUndress = !disabling
	endIf
endFunction

function DisableRedress(Actor ActorRef = none, bool disabling = true)
	if ActorRef && Positions.Find(ActorRef) != -1
		ActorAlias(ActorRef).DoRedress = !disabling
	else
		ActorAlias[0].DoRedress = !disabling
		ActorAlias[1].DoRedress = !disabling
		ActorAlias[2].DoRedress = !disabling
		ActorAlias[3].DoRedress = !disabling
		ActorAlias[4].DoRedress = !disabling
	endIf
endFunction

function DisableRagdollEnd(Actor ActorRef = none, bool disabling = true)
	if ActorRef && Positions.Find(ActorRef) != -1
		ActorAlias(ActorRef).DoRagdoll = !disabling
	else
		ActorAlias[0].DoRagdoll = !disabling
		ActorAlias[1].DoRagdoll = !disabling
		ActorAlias[2].DoRagdoll = !disabling
		ActorAlias[3].DoRagdoll = !disabling
		ActorAlias[4].DoRagdoll = !disabling
	endIf
endFunction

function DisablePathToCenter(Actor ActorRef = none, bool disabling = true)
	if ActorRef && Positions.Find(ActorRef) != -1
		ActorAlias(ActorRef).DisablePathToCenter(disabling)
	else
		ActorAlias[0].DisablePathToCenter(disabling)
		ActorAlias[1].DisablePathToCenter(disabling)
		ActorAlias[2].DisablePathToCenter(disabling)
		ActorAlias[3].DisablePathToCenter(disabling)
		ActorAlias[4].DisablePathToCenter(disabling)
	endIf
endFunction

function ForcePathToCenter(Actor ActorRef = none, bool forced = true)
	if ActorRef && Positions.Find(ActorRef) != -1
		ActorAlias(ActorRef).ForcePathToCenter(forced)
	else
		ActorAlias[0].ForcePathToCenter(forced)
		ActorAlias[1].ForcePathToCenter(forced)
		ActorAlias[2].ForcePathToCenter(forced)
		ActorAlias[3].ForcePathToCenter(forced)
		ActorAlias[4].ForcePathToCenter(forced)
	endIf
endFunction

function SetStartAnimationEvent(Actor ActorRef, string EventName = "IdleForceDefaultState", float PlayTime = 0.1)
	ActorAlias(ActorRef).SetStartAnimationEvent(EventName, PlayTime)
endFunction

function SetEndAnimationEvent(Actor ActorRef, string EventName = "IdleForceDefaultState")
	ActorAlias(ActorRef).SetEndAnimationEvent(EventName)
endFunction

; Orgasms
function DisableAllOrgasms(bool OrgasmsDisabled = true)
	DisableOrgasms = OrgasmsDisabled
endFunction

function DisableOrgasm(Actor ActorRef, bool OrgasmDisabled = true)
	if ActorRef
		ActorAlias(ActorRef).DisableOrgasm(OrgasmDisabled)
	endIf
endFunction

bool function IsOrgasmAllowed(Actor ActorRef)
	return ActorAlias(ActorRef).IsOrgasmAllowed()
endFunction

bool function NeedsOrgasm(Actor ActorRef)
	return ActorAlias(ActorRef).NeedsOrgasm()
endFunction

function ForceOrgasm(Actor ActorRef)
	if ActorRef
		ActorAlias(ActorRef).DoOrgasm(true)
	endIf
endFunction

; Voice
function SetVoice(Actor ActorRef, sslBaseVoice Voice, bool ForceSilent = false)
	ActorAlias(ActorRef).SetVoice(Voice, ForceSilent)
endFunction

sslBaseVoice function GetVoice(Actor ActorRef)
	return ActorAlias(ActorRef).GetVoice()
endFunction

; Actor Strapons
bool function IsUsingStrapon(Actor ActorRef)
	return ActorAlias(ActorRef).IsUsingStrapon()
endFunction

function EquipStrapon(Actor ActorRef)
	ActorAlias(ActorRef).EquipStrapon()
endFunction

function UnequipStrapon(Actor ActorRef)
	ActorAlias(ActorRef).UnequipStrapon()
endFunction

function SetStrapon(Actor ActorRef, Form ToStrapon)
	ActorAlias(ActorRef).SetStrapon(ToStrapon)
endfunction

Form function GetStrapon(Actor ActorRef)
	return ActorAlias(ActorRef).GetStrapon()
endfunction

; Expressions
function SetExpression(Actor ActorRef, sslBaseExpression Expression)
	ActorAlias(ActorRef).SetExpression(Expression)
endFunction
sslBaseExpression function GetExpression(Actor ActorRef)
	return ActorAlias(ActorRef).GetExpression()
endFunction

; Enjoyment/Pain
int function GetEnjoyment(Actor ActorRef)
	return ActorAlias(ActorRef).GetEnjoyment()
endFunction
int function GetPain(Actor ActorRef)
	return ActorAlias(ActorRef).GetPain()
endFunction

; Actor Information
int function GetPlayerPosition()
	return Positions.Find(PlayerRef)
endFunction

int function GetPosition(Actor ActorRef)
	return Positions.Find(ActorRef)
endFunction

bool function IsPlayerActor(Actor ActorRef)
	return ActorRef == PlayerRef
endFunction

bool function IsPlayerPosition(int Position)
	return Position == Positions.Find(PlayerRef)
endFunction

bool function HasActor(Actor ActorRef)
	return ActorRef && Positions.Find(ActorRef) != -1
endFunction

bool function PregnancyRisk(Actor ActorRef, bool AllowFemaleCum = false, bool AllowCreatureCum = false)
	return ActorRef && HasActor(ActorRef) && ActorCount > 1 && ActorAlias(ActorRef).PregnancyRisk() \
		&& (Males > 0 || (AllowFemaleCum && Females > 1 && Config.AllowFFCum) || (AllowCreatureCum && MaleCreatures > 0))
endFunction

; Aggressive/Victim Setup
function SetVictim(Actor ActorRef, bool Victimize = true)
	ActorAlias(ActorRef).SetVictim(Victimize)
endFunction

bool function IsVictim(Actor ActorRef)
	return HasActor(ActorRef) && Victims && Victims.Find(ActorRef) != -1
endFunction

bool function IsAggressor(Actor ActorRef)
	return HasActor(ActorRef) && Victims && Victims.Find(ActorRef) == -1
endFunction

int function GetHighestPresentRelationshipRank(Actor ActorRef)
	if ActorCount == 1
		return SexLabUtil.IntIfElse(ActorRef == Positions[0], 0, ActorRef.GetRelationshipRank(Positions[0]))
	endIf
	int out = -4 ; lowest possible
	int i = ActorCount
	while i > 0 && out < 4
		i -= 1
		if Positions[i] && Positions[i] != ActorRef
			int rank = ActorRef.GetRelationshipRank(Positions[i])
			if rank > out
				out = rank
			endIf
		endIf
	endWhile
	return out
endFunction

int function GetLowestPresentRelationshipRank(Actor ActorRef)
	if ActorCount == 1
		return SexLabUtil.IntIfElse(ActorRef == Positions[0], 0, ActorRef.GetRelationshipRank(Positions[0]))
	endIf
	int out = 4 ; highest possible
	int i = ActorCount
	while i > 0 && out > -4
		i -= 1
		if Positions[i] && Positions[i] != ActorRef
			int rank = ActorRef.GetRelationshipRank(Positions[i])
			if rank < out
				out = rank
			endIf
		endIf
	endWhile
	return out
endFunction

Float function GetPresentScaleDiff(Actor ActorRef)
	if ActorCount <= 1 || !ActorRef
		return 1.0
	endIf
	int CumSource = -1
	int ActorPosition = Positions.Find(ActorRef)
	if Animation
		CumSource = Animation.GetCumSource(ActorPosition, Stage)
	endIf
	if CumSource < 0 || ActorCount >= CumSource || !Positions[CumSource]
		If ActorCount > 2
			return GetHighestPresentScaleDiff(ActorRef)
		ElseIf ActorPosition == 1
			CumSource = 0
		Else
			CumSource = 1
		EndIf
	endIf
	Float ActorScale = 1.0
	Float RefScale = 1.0
	Actor TempActorRef
	int i = 0
	while i < 5
		if ActorAlias[i]
			TempActorRef = ActorAlias[i].GetActorReference()
			If TempActorRef
				If TempActorRef == ActorRef
					ActorScale = ActorAlias[i].GetBodyScale()
				ElseIf TempActorRef == Positions[CumSource]
					RefScale = ActorAlias[i].GetBodyScale()
				endIf
			endIf
		endIf
		i += 1
	endWhile
	return RefScale / ActorScale
endFunction

Float function GetHighestPresentScaleDiff(Actor ActorRef)
	if ActorCount == 1
		return 1.0
	endIf
	Float ActorScale = 1.0
	Float HighestScale = 0.0
	Float TempScale
	Actor TempActorRef
	int i = 0
	while i < 5
		if ActorAlias[i]
			TempActorRef = ActorAlias[i].GetActorReference()
			If TempActorRef
				If TempActorRef == ActorRef
					ActorScale = ActorAlias[i].GetBodyScale()
				Else
					TempScale = ActorAlias[i].GetBodyScale()
					If HighestScale <= 0.0 || HighestScale < TempScale
						HighestScale = TempScale
					endIf
				endIf
			endIf
		endIf
		i += 1
	endWhile
	return HighestScale / ActorScale
endFunction

Float function GetLowestPresentScaleDiff(Actor ActorRef)
	if ActorCount <= 1
		return 1.0
	endIf
	Float ActorScale = 1.0
	Float LowestScale = 0.0
	Float TempScale
	Actor TempActorRef
	int i = 0
	while i < 5
		if ActorAlias[i]
			TempActorRef = ActorAlias[i].GetActorReference()
			If TempActorRef
				If TempActorRef == ActorRef
					ActorScale = ActorAlias[i].GetBodyScale()
				Else
					TempScale = ActorAlias[i].GetBodyScale()
					If LowestScale <= 0.0 || LowestScale > TempScale
						LowestScale = TempScale
					endIf
				endIf
			endIf
		endIf
		i += 1
	endWhile
	return LowestScale / ActorScale
endFunction

function UpdateOpenMouthScales()
	
	Float[] ActorScale = Utility.CreateFloatArray(5, 1.0)
	int[] CumSource = Utility.CreateIntArray(5, -1)
	int[] ActorPosition = Utility.CreateIntArray(5, -1)
	Float LowestScale = 0.0
	Float HighestScale = 0.0
	int i = 0
	while i < 5
		if ActorAlias[i]
			ActorScale[i] = ActorAlias[i].GetBodyScale()
			If HighestScale <= 0.0 || HighestScale < ActorScale[i]
				HighestScale = ActorScale[i]
			endIf
			If LowestScale <= 0.0 || LowestScale > ActorScale[i]
				LowestScale = ActorScale[i]
			endIf
			ActorPosition[i] = Positions.Find(ActorAlias[i].GetActorReference())
			if Animation && ActorPosition[i] >= 0
				CumSource[i] = Animation.GetCumSource(ActorPosition[i], Stage)
			endIf
		endIf
		i += 1
	endWhile
	
	i = 0
	while i < 5
		if ActorAlias[i]
			if CumSource[i] >= 0 ; Get the real ActorAlias from the CumSource of the positions
				CumSource[i] =  ActorPosition.Find( CumSource[i] ) 
			endIf
			if CumSource[i] >= 0
				ActorAlias[i].SetOpenMouthScale(ActorScale[ ( CumSource[i] ) ] / ActorScale[i])
			elseIf  ActorCount == 2 && ActorScale[i] == HighestScale
				ActorAlias[i].SetOpenMouthScale(LowestScale / ActorScale[i])
			else
				ActorAlias[i].SetOpenMouthScale(HighestScale / ActorScale[i])
			endIf
		endIf
		i += 1
	endWhile

endFunction

function ChangeActors(Actor[] NewPositions)
	NewPositions = PapyrusUtil.RemoveActor(NewPositions, none)
	if NewPositions.Length < 1 || NewPositions.Length > 5 || GetState() == "Ending" || GetState() == "Frozen" ; || Positions == NewPositions
		return
	endIf
	int[] NewGenders = ActorLib.GenderCount(NewPositions)
	if PapyrusUtil.AddIntValues(NewGenders) == 0 ; || HasCreature || NewGenders[2] > 0
		return
	endIf
	int NewCreatures = NewGenders[2] + NewGenders[3]
	; Enter making state for alterations
	GoToState("Resetting")
	SendThreadEvent("ActorChangeStart")
	
	; Remove actors no longer present
	int i = ActorCount
	while i > 0
		i -= 1
		sslActorAlias Slot = ActorAlias(Positions[i])
		if Slot
			if NewPositions.Find(Positions[i]) == -1
				if Slot.GetState() == "Prepare" || Slot.GetState() == "Animating"
					Slot.ResetActor()
				else
					Slot.ClearAlias()
				endIf
			else
				Slot.GoToState("Resetting") ; To stop the Updates of the actor and disable some functions
				Slot.StopAnimating(true)
				Slot.UnlockActor()
			endIf
		endIf
	endWhile
	int aid = -1
	; Select new animations for changed actor count
	if CustomAnimations && CustomAnimations.Length > 0
		if CustomAnimations[0].PositionCount != NewPositions.Length
			Log("ChangeActors("+NewPositions+") -- Failed to force valid animation for the actors and now is trying to revert the changes if possible", "ERROR")
			NewPositions = Positions
			NewGenders = ActorLib.GenderCount(NewPositions)
			NewCreatures = NewGenders[2] + NewGenders[3]
		else
			Actor[] OldPositions = Positions
			int[] OldGenders = Genders
			if Positions != NewPositions ; Temporaly changin the values to help FilterAnimations()
				Positions  = NewPositions
				ActorCount = Positions.Length
				Genders    = NewGenders
				Futas      = ActorLib.TransCount(Positions)
				HasPlayer  = Positions.Find(PlayerRef) != -1
			endIf
			if Positions != OldPositions ; Temporaly changin the values to help FilterAnimations()
				Positions  = OldPositions
				ActorCount = Positions.Length
				Genders    = OldGenders
				Futas      = ActorLib.TransCount(Positions)
				HasPlayer  = Positions.Find(PlayerRef) != -1
			endIf
			aid = Utility.RandomInt(0, (CustomAnimations.Length - 1))
			Animation = CustomAnimations[aid]
			if SortActors && NewCreatures > 0
				NewPositions = ThreadLib.SortCreatures(NewPositions) ; required even if is already on the SetAnimation fuction but just the general one
		;	else ; not longer needed since is already on the SetAnimation fuction
		;		NewPositions = ThreadLib.SortActorsByAnimation(NewPositions, Animation)
			endIf
		endIf
	elseIf !PrimaryAnimations || PrimaryAnimations.Length < 1 || PrimaryAnimations[0].PositionCount != NewPositions.Length
		if PrimaryAnimations.Length > 0
			PrimaryAnimations[0].PositionCount
		endIf
		if NewCreatures > 0
			SetAnimations(CreatureSlots.GetByCreatureActors(NewPositions.Length, NewPositions))
		else
			if Creatures < 1 && Futas[0] + Futas[1] > 0 && Futas[0] + Futas[1] >= ActorCount - 1
				SetAnimations(AnimSlots.GetByTags(ActorCount, "Futa,Sex,", "", RequireAll = False))
			endIf
			if PrimaryAnimations.Length == 0 || PrimaryAnimations[0].PositionCount != NewPositions.Length
				SetAnimations(AnimSlots.GetByDefault(NewGenders[0], NewGenders[1], IsAggressive, (BedRef != none), Config.RestrictAggressive))
			endIf
		endIf
		if !PrimaryAnimations || PrimaryAnimations.Length < 1
			Log("ChangeActors("+NewPositions+") -- Failed to find valid animation for the actors", "FATAL")
			Stage   = Animation.StageCount
			FastEnd = true
			if HasPlayer
				MiscUtil.SetFreeCameraState(false)
				if Game.GetCameraState() < 8 && Game.GetCameraState() != 3
					Game.ForceThirdPerson()
				endIf
			endIf
			Utility.WaitMenuMode(0.5)
			GoToState("Ending")
			return
		elseIf PrimaryAnimations[0].PositionCount != NewPositions.Length
			Log("ChangeActors("+NewPositions+") -- Failed to find valid animation for the actors and now is trying to revert the changes if possible", "ERROR")
			NewPositions = Positions
			NewGenders = ActorLib.GenderCount(NewPositions)
			NewCreatures = NewGenders[2] + NewGenders[3]
		else
			Actor[] OldPositions = Positions
			int[] OldGenders = Genders
			if Positions != NewPositions ; Temporaly changin the values to help FilterAnimations()
				Positions  = NewPositions
				ActorCount = Positions.Length
				Genders    = NewGenders
				Futas      = ActorLib.TransCount(Positions)
				HasPlayer  = Positions.Find(PlayerRef) != -1
			endIf
			if FilterAnimations() < 0
				Log("ChangeActors("+NewPositions+") -- Failed to filter the animations for the actors", "ERROR")
				if Positions != OldPositions
					Positions  = OldPositions
					ActorCount = Positions.Length
					Genders    = OldGenders
					Futas      = ActorLib.TransCount(Positions)
					HasPlayer  = Positions.Find(PlayerRef) != -1
					if FilterAnimations() < 0
						Log("ChangeActors("+NewPositions+") -- Failed to revert the changes", "FATAL")
						Stage   = Animation.StageCount
						FastEnd = true
						if HasPlayer
							MiscUtil.SetFreeCameraState(false)
							if Game.GetCameraState() < 8 && Game.GetCameraState() != 3
								Game.ForceThirdPerson()
							endIf
						endIf
						Utility.WaitMenuMode(0.5)
						GoToState("Ending")
						return
					else
						NewPositions  = OldPositions
						NewGenders    = OldGenders
					endIf
				endIf
			endIf
			if Positions != OldPositions ; Temporaly changin the values to help FilterAnimations()
				Positions  = OldPositions
				ActorCount = Positions.Length
				Genders    = OldGenders
				Futas      = ActorLib.TransCount(Positions)
				HasPlayer  = Positions.Find(PlayerRef) != -1
			endIf
			aid = Utility.RandomInt(0, (PrimaryAnimations.Length - 1))
			Animation = PrimaryAnimations[aid]
			if SortActors && NewCreatures > 0
				NewPositions = ThreadLib.SortCreatures(NewPositions) ; required even if is already on the SetAnimation fuction but just the general one
		;	else ; not longer needed since is already on the SetAnimation fuction
		;		NewPositions = ThreadLib.SortActorsByAnimation(NewPositions, Animation)
			endIf
		endIf
	endIf
	; Prepare actors who weren't present before
	i = NewPositions.Length
	while i > 0
		i -= 1
		int SlotID = FindSlot(NewPositions[i])
		if SlotID == -1
			if ActorLib.ValidateActor(NewPositions[i]) < 0
				Log("ChangeActors("+NewPositions+") -- Failed to add new actor '"+NewPositions[i].GetLeveledActorBase().GetName()+"' -- The actor is not valid", "ERROR")
				NewPositions = PapyrusUtil.RemoveActor(NewPositions, NewPositions[i])
				int g      = ActorLib.GetGender(NewPositions[i])
				NewGenders[g] = NewGenders[g] - 1
			else
				; Slot into alias
				sslActorAlias Slot = PickAlias(NewPositions[i])
				if !Slot || !Slot.SetActor(NewPositions[i])
					Log("ChangeActors("+NewPositions+") -- Failed to add new actor '"+NewPositions[i].GetLeveledActorBase().GetName()+"' -- They were unable to fill an actor alias", "ERROR")
					NewPositions = PapyrusUtil.RemoveActor(NewPositions, NewPositions[i])
					int g      = Slot.GetGender()
					NewGenders[g] = NewGenders[g] - 1
				else
					; Update position info
					Positions  = PapyrusUtil.PushActor(Positions, NewPositions[i])
					ActorCount = Positions.Length
					; Update gender counts
					int g      = Slot.GetGender()
					Genders[g] = Genders[g] + 1
					; Flag as victim
					Slot.SetVictim(False)
					Slot.DoUndress = false
					Slot.PrepareActor()
				;	Slot.StartAnimating()
				endIf
			endIf
		else
			sslActorAlias Slot = ActorAlias[SlotID]
			if Slot
				Slot.UnregisterForUpdate() ; Don't whant missing Updates on the Animating State
				Slot.GoToState("Animating") ; To revert the effects of it's Resetting State
				Slot.LockActor() ; On the Animating State becouse is the one that have the event OnTranslationComplete() to hold the position
				int Seid = ModEvent.Create(Key("StripActor"))
				if Seid
					ModEvent.PushForm(Seid, Slot.ActorRef)
					ModEvent.Send(Seid)
				else
					Slot.Strip()
				endIf
			endIf
		endIf
	endWhile
	; Save new positions information
	Positions  = NewPositions
	; Double Checking the Positions for actors without Slots
	i = NewPositions.Length
	while i > 0
		i -= 1
		if FindSlot(NewPositions[i]) == -1
			Positions = PapyrusUtil.RemoveActor(Positions, NewPositions[i])
			Log("ChangeActors("+NewPositions+") -- Failed to add new actor '"+NewPositions[i].GetLeveledActorBase().GetName()+"' -- They were unable to fill an actor alias", "WARNING")
		endIf
	endWhile
	
	ActorCount = Positions.Length
	Genders    = NewGenders
	Futas      = ActorLib.TransCount(Positions)
	HasPlayer  = Positions.Find(PlayerRef) != -1
	UpdateAdjustKey()
	Log(AdjustKey, "Adjustment Profile")
	; Reset the animation for changed actor count
	GoToState("Animating")
	if aid >= 0
		; End lead in if thread was in it and can't be now
		if LeadIn && Positions.Length != 2
			UnregisterForUpdate()
			Stage  = 1
			LeadIn = false
			QuickEvent("Strip")
			StorageUtil.SetFloatValue(Config,"SexLab.LastLeadInEnd", SexLabUtil.GetCurrentGameRealTime())
			SendThreadEvent("LeadInEnd")
			SetAnimation(aid)
		;	Action("Advancing")
		else
			Stage  = 1
			SetAnimation(aid)
		;	Action("Advancing")
		endIf
	else
		; Reposition actors
		RealignActors()
	endIf
;	RegisterForSingleUpdate(0.1)
	SendThreadEvent("ActorChangeEnd")
endFunction

; ------------------------------------------------------- ;
; --- Animation Setup                                 --- ;
; ------------------------------------------------------- ;

function SetForcedAnimations(sslBaseAnimation[] AnimationList)
	if AnimationList && AnimationList.Length > 0
		CustomAnimations = AnimationList
	endIf
endFunction

sslBaseAnimation[] function GetForcedAnimations()
	sslBaseAnimation[] Output = sslUtility.AnimationArray(CustomAnimations.Length)
	int i = CustomAnimations.Length
	while i > 0
		i -= 1
		Output[i] = CustomAnimations[i]
	endWhile
	return Output
endFunction

function ClearForcedAnimations()
	CustomAnimations = sslUtility.AnimationArray(0)
endFunction

function SetAnimations(sslBaseAnimation[] AnimationList)
	if AnimationList && AnimationList.Length > 0
		PrimaryAnimations = AnimationList
	endIf
endFunction

sslBaseAnimation[] function GetAnimations()
	sslBaseAnimation[] Output = sslUtility.AnimationArray(PrimaryAnimations.Length)
	int i = PrimaryAnimations.Length
	while i > 0
		i -= 1
		Output[i] = PrimaryAnimations[i]
	endWhile
	return Output
endFunction

function ClearAnimations()
	PrimaryAnimations = sslUtility.AnimationArray(0)
endFunction

function SetLeadAnimations(sslBaseAnimation[] AnimationList)
	if AnimationList && AnimationList.Length > 0
		LeadIn = true
		LeadAnimations = AnimationList
	endIf
endFunction

sslBaseAnimation[] function GetLeadAnimations()
	sslBaseAnimation[] Output = sslUtility.AnimationArray(LeadAnimations.Length)
	int i = LeadAnimations.Length
	while i > 0
		i -= 1
		Output[i] = LeadAnimations[i]
	endWhile
	return Output
endFunction

function ClearLeadAnimations()
	LeadAnimations = sslUtility.AnimationArray(0)
endFunction

function AddAnimation(sslBaseAnimation AddAnimation, bool ForceTo = false)
	if AddAnimation
		sslBaseAnimation[] Adding = new sslBaseAnimation[1]
		Adding[0] = AddAnimation
		PrimaryAnimations = sslUtility.MergeAnimationLists(PrimaryAnimations, Adding)
	endIf
endFunction

function SetStartingAnimation(sslBaseAnimation FirstAnimation)
	StartingAnimation = FirstAnimation
endFunction

; Filter Vars
Keyword Vampire
Keyword ActorTypeGhost
Keyword ActorTypeDaedra
Faction JobSpellFaction
Faction CollegeofWinterholdFaction
Faction WarlockFaction
Faction NecromancerFaction
Faction JobApothecaryFaction
Faction JobTrainerAlchemyFaction

int function FilterAnimations()
	; Filter animations based on user settings and scene
	if !CustomAnimations || CustomAnimations.Length < 1
		Log("FilterAnimations() BEGIN - LeadAnimations="+LeadAnimations.Length+", PrimaryAnimations="+PrimaryAnimations.Length)
		string[] Filters
		string[] BasicFilters
		string[] RestrictiveFilters
		string[] BedFilters
		string[] FurnitureFilters
		string[] RequiredTags
		sslBaseAnimation[] FilteredPrimary
		sslBaseAnimation[] FilteredLead
		int i

		; Filter tags for Male Vaginal restrictions
		if (Futas[0] + Futas[1]) < 1 && ((!Config.UseCreatureGender && ActorCount == Males) || (Config.UseCreatureGender && ActorCount == (Males + MaleCreatures)))
			BasicFilters = AddString(BasicFilters, "Vaginal")
		elseIf (HasTag("Vaginal") || HasTag("Pussy") || HasTag("Cunnilingus"))
			if FemaleCreatures <= 0
				Filters = AddString(Filters, "CreatureSub")
			endIf
		endIf

		; Filter tags for Devices friendly animations
		int RestrictedCount = 0
		int RestrictedPosition = 0
		if (Config.ManageZadFilter || Config.ManageZazFilter) && ActorCount != Creatures
			i = ActorCount
			while i
				i -= 1
				sslActorAlias Slot = ActorAlias(Positions[i])
				if Slot && Slot.GetRestricted()
					RequiredTags = PapyrusUtil.MergeStringArray(RequiredTags, Slot.GetRequiredTags(), true)
					RestrictedPosition = i
					RestrictedCount +=1
				endIf
				if i == 0
					BasicFilters = PapyrusUtil.MergeStringArray(BasicFilters, Slot.GetForbiddenTags(), true)
				endIf
			endWhile
		endIf
		if RestrictedCount > 1
			RequiredTags = AddString(RequiredTags, "SubSub")
		else	
			Filters = AddString(Filters, "SubSub")
			if IsAggressive && Config.FixVictimPos
				if VictimRef == Positions[0] && ActorLib.GetGender(VictimRef) == 0 && ActorLib.GetTrans(VictimRef) == -1
					BasicFilters = AddString(BasicFilters, "Vaginal")
				endIf
				if Males > 0 && ActorLib.GetGender(VictimRef) == 1 && ActorLib.GetTrans(VictimRef) == -1
					Filters = AddString(Filters, "FemDom")
				elseIf Creatures > 0 && !ActorLib.IsCreature(VictimRef) && Males <= 0 && (!Config.UseCreatureGender || (Males + MaleCreatures) <= 0)
					Filters = AddString(Filters, "CreatureSub")
				endIf
			endIf
		endIf
		
		; Filter tags for same sex restrictions
		if ActorCount == 2 && Creatures == 0 && (Males == 0 || Females == 0) && Config.RestrictSameSex
			BasicFilters = AddString(BasicFilters, SexLabUtil.StringIfElse(Females == 2, "FM", "Breast"))
		endIf
		if Config.UseStrapons && Config.RestrictStrapons && (ActorCount - Creatures) == Females && Females > 0
			Filters = AddString(Filters, "Straight")
			Filters = AddString(Filters, "Gay")
		endIf
		if BasicFilters.Find("Breast") >= 0
			Filters = AddString(Filters, "Boobjob")
		endIf

		;Remove filtered basic tags from primary
		FilteredPrimary = sslUtility.FilterTaggedAnimations(PrimaryAnimations, BasicFilters, false)
		if PrimaryAnimations.Length > FilteredPrimary.Length
			Log("Filtered out '"+(PrimaryAnimations.Length - FilteredPrimary.Length)+"' primary animations with tags: "+BasicFilters)
			PrimaryAnimations = FilteredPrimary
		endIf

		; Filter tags for non-bed friendly animations
		if BedRef
			BedFilters = AddString(BedFilters, "Furniture")
			BedFilters = AddString(BedFilters, "NoBed")
			if Config.BedRemoveStanding
				BedFilters = AddString(BedFilters, "Standing")
			endIf
			if UsingBedRoll
				BedFilters = AddString(BedFilters, "BedOnly")
			elseIf UsingSingleBed
				BedFilters = AddString(BedFilters, "DoubleBed") ; For bed animations made specific for DoubleBed or requiring too mush space to use single beds
			elseIf UsingDoubleBed
				BedFilters = AddString(BedFilters, "SingleBed") ; For bed animations made specific for SingleBed
			endIf
		else
			BedFilters = AddString(BedFilters, "BedOnly")
		endIf

		; Adding Filters tags for Furniture animations if is not using beds becouse beds already removed furniture
		if CenterRef && Config.AllowFurniture && !UsingBed
			if UsingFurniture
				int iFurn = ThreadLib.GetFurnitureType(CenterRef)
				string[] TempTag = new string[1]
				if iFurn != -1 && sslUtility.Trim(Config.FurnitureTags[iFurn]) != "" && Config.ActiveFurnitureTags.Find(Config.FurnitureTags[iFurn]) != -1 ; && ((HasCreature && CreatureSlots.HasTagCache(Config.FurnitureTags[iFurn])) || (!HasCreature && AnimSlots.HasTagCache(Config.FurnitureTags[iFurn])))
					TempTag[0] = "Furniture"
					; Remove filtered TempTag tags from primary
					FilteredPrimary = sslUtility.FilterTaggedAnimations(PrimaryAnimations, TempTag, true)
					if PrimaryAnimations.Length > FilteredPrimary.Length
						Log("Filtered out '"+(PrimaryAnimations.Length - FilteredPrimary.Length)+"' primary animations without tags: " + TempTag)
						PrimaryAnimations = FilteredPrimary
					endIf
					; Remove filtered TempTag tags from lead in
					FilteredLead = sslUtility.FilterTaggedAnimations(LeadAnimations, TempTag, true)
					if LeadAnimations.Length > FilteredLead.Length
						Log("Filtered out '"+(LeadAnimations.Length - FilteredLead.Length)+"' lead in animations without tags: "+TempTag)
						LeadAnimations = FilteredLead
					endIf
					TempTag[0] = Config.FurnitureTags[iFurn]
					if TempTag[0] == "Table"
						TempTag == PapyrusUtil.PushString(TempTag, "Workbench")
					endIf
					; Remove filtered TempTag tags from primary
					FilteredPrimary = sslUtility.FilterTaggedAnimations(PrimaryAnimations, TempTag, true)
					if PrimaryAnimations.Length > FilteredPrimary.Length
						Log("Filtered out '"+(PrimaryAnimations.Length - FilteredPrimary.Length)+"' primary animations without tags: " + TempTag)
						PrimaryAnimations = FilteredPrimary
					endIf
					; Remove filtered TempTag tags from lead in
					FilteredLead = sslUtility.FilterTaggedAnimations(LeadAnimations, TempTag, true)
					if LeadAnimations.Length > FilteredLead.Length
						Log("Filtered out '"+(LeadAnimations.Length - FilteredLead.Length)+"' lead in animations without tags: "+TempTag)
						LeadAnimations = FilteredLead
					endIf
					Log("Runing animations over Furniture Type:"+(iFurn+4)+" Tag:"+TempTag+" Name: "+CenterRef.GetBaseObject().GetName())
					if !PrimaryAnimations || PrimaryAnimations.Length < 1; || !PrimaryAnimations[Utility.RandomInt(0, (PrimaryAnimations.Length - 1))].HasTag(Config.FurnitureTags[iFurn]) || !PrimaryAnimations[0].HasTag("Furniture")
						if !RequiredTags || RequiredTags.Length < 1
							if HasCreature
								if ActorCount != Creatures || ActorCount == 1
									FilteredPrimary = CreatureSlots.GetByRaceTags(ActorCount, CreatureRef, Config.FurnitureTags[iFurn]+",Furniture", PapyrusUtil.StringJoin(BasicFilters, ","))
								else
									FilteredPrimary = CreatureSlots.GetByCreatureActorsTags(ActorCount, Positions, Config.FurnitureTags[iFurn]+",Furniture", PapyrusUtil.StringJoin(BasicFilters, ","))
								endIf
							else
								FilteredPrimary = AnimSlots.GetByTags(ActorCount, Config.FurnitureTags[iFurn]+",Furniture", PapyrusUtil.StringJoin(BasicFilters, ","))
							endIf
							if FilteredPrimary.Length > 0
								Log("Set new primary animations with tags: "+Config.FurnitureTags[iFurn]+",Furniture")
								PrimaryAnimations = FilteredPrimary
								if RestrictedPosition > 0 && !ActorLib.IsCreature(Positions[RestrictedPosition])
									Actor FisrtPosition = Positions[0]
									Positions[0] = Positions[RestrictedPosition]
									Positions[RestrictedPosition] = FisrtPosition
								endIf
							elseIf PrimaryAnimations && PrimaryAnimations.Length > 0 && PrimaryAnimations[0].HasTag("Furniture")
								Log("Cleaning primary animations list to change location for lack of Furniture animations")
								PrimaryAnimations = FilteredPrimary
							endIf
							; Remove filtered TempTag tags from lead in
							if LeadAnimations && LeadAnimations.Length > 0
								FilteredLead = sslUtility.FilterTaggedAnimations(LeadAnimations, TempTag, true)
								if LeadAnimations.Length > FilteredLead.Length
									Log("Filtered out '"+(LeadAnimations.Length - FilteredLead.Length)+"' lead in animations without tags: "+TempTag)
									LeadAnimations = FilteredLead
								endIf
							endIf
						else
							RequiredTags = AddString(RequiredTags, Config.FurnitureTags[iFurn])
						endIf
					else
						RequiredTags = AddString(RequiredTags, Config.FurnitureTags[iFurn])

						FurnitureFilters = PapyrusUtil.RemoveString(Config.ActiveFurnitureTags, Config.FurnitureTags[iFurn])
						if Config.FurnitureTags[iFurn] == "Table"
							FurnitureFilters == PapyrusUtil.RemoveString(FurnitureFilters, "Workbench")
						endIf
					endIf
				else
					FurnitureFilters = PapyrusUtil.MergeStringArray(PapyrusUtil.StringArray(0), Config.ActiveFurnitureTags)
				endIf
				if !PrimaryAnimations || PrimaryAnimations.Length < 1
					Log("None available animation founded for Furniture:"+TempTag+" RequiredTags:"+RequiredTags+" BasicFilters:"+BasicFilters, "WARNING")
					; Fixing the filters
					RequiredTags = PapyrusUtil.RemoveString(RequiredTags, Config.FurnitureTags[iFurn])
					FurnitureFilters = PapyrusUtil.MergeStringArray(PapyrusUtil.StringArray(0), Config.ActiveFurnitureTags)
					if UsingFurniture && CenterRef.IsActivationBlocked()
						SetFurnitureIgnored(false)
					elseIf CenterRef.GetBaseObject() == Config.XMarkerHiddenPlace
						CenterRef.Enable()
					endIf
					; Center on fallback choices
					if IsAggressive && !(VictimRef.GetFurnitureReference() || VictimRef.IsSwimming() || VictimRef.IsFlying())
						CenterOnObject(VictimRef)
					elseIf HasPlayer && !(PlayerRef.GetFurnitureReference() || PlayerRef.IsSwimming() || PlayerRef.IsFlying())
						CenterOnObject(PlayerRef)
					else
						i = ActorCount
						while i > 0
							i -= 1
							if !(Positions[i].GetFurnitureReference() || Positions[i].IsSwimming() || Positions[i].IsFlying())
								CenterOnObject(Positions[i])
								i = 0
							endIf
						endWhile
					endIf
				else
					AddTag(Config.FurnitureTags[iFurn])
				endIf
			else
				FurnitureFilters = PapyrusUtil.MergeStringArray(PapyrusUtil.StringArray(0), Config.ActiveFurnitureTags)
				BedFilters = PapyrusUtil.PushString(BedFilters, "FurnitureOnly")
			endIf
		endIf


		; Remove any animations with filtered tags
		Filters = PapyrusUtil.RemoveString(Filters, "")
		BasicFilters = PapyrusUtil.RemoveString(BasicFilters, "")
		RestrictiveFilters = PapyrusUtil.RemoveString(RestrictiveFilters, "")
		BedFilters = PapyrusUtil.RemoveString(BedFilters, "")
		RequiredTags = PapyrusUtil.RemoveString(RequiredTags, "")
		; Remove filtered without RequiredTags tags from lead in
		if LeadAnimations && LeadAnimations.Length > 0 && RequiredTags && RequiredTags.Length > 0
			FilteredLead = sslUtility.FilterTaggedAnimations(LeadAnimations, RequiredTags, true)
			if LeadAnimations.Length > FilteredLead.Length
				Log("Filtered out '"+(LeadAnimations.Length - FilteredLead.Length)+"' lead in animations without tags: "+RequiredTags)
				LeadAnimations = FilteredLead
			endIf
		endIf
		
		; Set new animation list if required 
		if RequiredTags.Length > 0 && !CheckTags(RequiredTags)
			bool NeedAll = True
			if RequiredTags.Length > 0 && RequiredTags.Find("SubSub")== -1
				if RequiredTags.Find("Bound") >= 0
				;	RestrictiveFilters = PapyrusUtil.RemoveString(RestrictiveFilters, "Armbinder")
					RequiredTags = AddString(RequiredTags, "Armbinder")
					RequiredTags = AddString(RequiredTags, "Wrists")
					NeedAll = False
			;	elseif RequiredTags.Find("Yoke") >= 0
			;		RestrictiveFilters = PapyrusUtil.RemoveString(RestrictiveFilters, "Pillory") ; Pillory is furniture and shouldn't be related with the RestrictiveFilters
			;		NeedAll = False
				endIf
			endIf
			if HasCreature
				if ActorCount != Creatures || ActorCount == 1
					FilteredPrimary = CreatureSlots.GetByRaceTags(ActorCount, CreatureRef, PapyrusUtil.StringJoin(RequiredTags, ","), PapyrusUtil.StringJoin(BasicFilters, ","),NeedAll)
				else
					FilteredPrimary = CreatureSlots.GetByCreatureActorsTags(ActorCount, Positions, PapyrusUtil.StringJoin(RequiredTags, ","), PapyrusUtil.StringJoin(BasicFilters, ","),NeedAll)
				endIf
			else
				FilteredPrimary = AnimSlots.GetByTags(ActorCount, PapyrusUtil.StringJoin(RequiredTags, ","), PapyrusUtil.StringJoin(BasicFilters, ","),NeedAll)
			endIf
			if FilteredPrimary.Length > 0
				Log("Set new primary animations with RequiredTags: "+RequiredTags+" and without tags: "+BasicFilters)
				PrimaryAnimations = FilteredPrimary
				if RestrictedPosition > 0 && !ActorLib.IsCreature(Positions[RestrictedPosition])
					Actor FisrtPosition = Positions[0]
					Positions[0] = Positions[RestrictedPosition]
					Positions[RestrictedPosition] = FisrtPosition
				endIf
				string[] TempTag = new string[1]
				TempTag[0] = "Oral"
				if BasicFilters.Find(TempTag[0]) < 0 && HasTag(TempTag[0])
					FilteredPrimary = sslUtility.FilterTaggedAnimations(PrimaryAnimations, TempTag, true)
					if FilteredPrimary.Length > 0
						Log("Filtered out '"+(PrimaryAnimations.Length - FilteredPrimary.Length)+"' primary animations without tag: " + TempTag[0])
						PrimaryAnimations = FilteredPrimary
					endIf
				endIf
				TempTag[0] = "Vaginal"
				if BasicFilters.Find(TempTag[0]) < 0 && HasTag(TempTag[0])
					FilteredPrimary = sslUtility.FilterTaggedAnimations(PrimaryAnimations, TempTag, true)
					if FilteredPrimary.Length > 0
						Log("Filtered out '"+(PrimaryAnimations.Length - FilteredPrimary.Length)+"' primary animations without tag: " + TempTag[0])
						PrimaryAnimations = FilteredPrimary
					endIf
				endIf
				TempTag[0] = "Anal"
				if BasicFilters.Find(TempTag[0]) < 0 && HasTag(TempTag[0])
					FilteredPrimary = sslUtility.FilterTaggedAnimations(PrimaryAnimations, TempTag, true)
					if FilteredPrimary.Length > 0
						Log("Filtered out '"+(PrimaryAnimations.Length - FilteredPrimary.Length)+"' primary animations without tag: " + TempTag[0])
						PrimaryAnimations = FilteredPrimary
					endIf
				endIf
				TempTag[0] = "Aggressive"
				if Config.RestrictAggressive || HasTag(TempTag[0])
					FilteredPrimary = sslUtility.FilterTaggedAnimations(PrimaryAnimations, TempTag, HasTag(TempTag[0]))
					if FilteredPrimary.Length > 0
						Log("Filtered out'"+(PrimaryAnimations.Length - FilteredPrimary.Length)+"' primary animations [Aggressive]=" + !HasTag(TempTag[0]))
						PrimaryAnimations = FilteredPrimary
					endIf
				endIf
			endIf
		endIf
		; Adding Filters tags for Devices friendly animations
		if Config.ManageZadFilter || Config.ManageZazFilter
			if RequiredTags.Length < 1 || RequiredTags.Find("Bound")== -1
				RestrictiveFilters = AddString(RestrictiveFilters, "Bound")
				RestrictiveFilters = AddString(RestrictiveFilters, "Wrists")
			endIf
		;	if RequiredTags.Length < 1 || (RequiredTags.Find("Pillory")== -1 && RequiredTags.Find("Yoke")== -1)
		;		RestrictiveFilters = AddString(RestrictiveFilters, "Pillory") ; Pillory is furniture and shouldn't be related with the RestrictiveFilters
		;	endIf
			if RequiredTags.Length < 1 || RequiredTags.Find("Yoke")== -1
				RestrictiveFilters = AddString(RestrictiveFilters, "Yoke")
		;	else
		;		RestrictiveFilters = PapyrusUtil.RemoveString(RestrictiveFilters, "Pillory") ; Pillory is furniture and shouldn't be related with the RestrictiveFilters
			endIf
			if RequiredTags.Length < 1 || RequiredTags.Find("Armbinder")== -1
				RestrictiveFilters = AddString(RestrictiveFilters, "Armbinder")
			endIf
		endIf

		; Get default creature animations if none
		if HasCreature
			if Config.UseCreatureGender
				if ActorCount != Creatures 
					PrimaryAnimations = CreatureSlots.FilterCreatureGenders(PrimaryAnimations, Genders[2], Genders[3])
				else
					;TODO: Find bether solution instead of Exclude CC animations from filter  
				endIf
			endIf
			; Pick default creature animations if currently empty (none or failed above check)
			if PrimaryAnimations.Length == 0 ; || (BasicFilters.Length > 1 && PrimaryAnimations[0].CheckTags(BasicFilters, False))
				Log("Selecting new creature animations - "+PrimaryAnimations)
				Log("Creature Genders: "+Genders)
				SetAnimations(CreatureSlots.GetByCreatureActorsTags(ActorCount, Positions, "", PapyrusUtil.StringJoin(BasicFilters, ",")))
				if PrimaryAnimations.Length == 0
					SetAnimations(CreatureSlots.GetByCreatureActors(ActorCount, Positions))
					if PrimaryAnimations.Length == 0
						Fatal("Failed to find valid creature animations.")
						return -1
					endIf
				endIf
			endIf
			; Sort the actors to creature order
		;	Positions = ThreadLib.SortCreatures(Positions, Animations[0]) ; not longer needed since is already on the SetAnimation fuction

		; Get default primary animations if none
		elseIf PrimaryAnimations.Length == 0 ; || (BasicFilters.Length > 1 && PrimaryAnimations[0].CheckTags(BasicFilters, False))
			if Creatures < 1 && Futas[0] + Futas[1] > 0 && Futas[0] + Futas[1] >= ActorCount - 1
				SetAnimations(AnimSlots.GetByTags(ActorCount, "Futa,Sex,", PapyrusUtil.StringJoin(BasicFilters, ","), RequireAll = False))
			endIf
			if PrimaryAnimations.Length == 0
				SetAnimations(AnimSlots.GetByDefaultTags(Males, Females, IsAggressive, (BedRef != none), Config.RestrictAggressive, "", PapyrusUtil.StringJoin(BasicFilters, ",")))
				if PrimaryAnimations.Length == 0
					SetAnimations(AnimSlots.GetByDefault(Males, Females, IsAggressive, (BedRef != none), Config.RestrictAggressive))
					if PrimaryAnimations.Length == 0
						Fatal("Unable to find valid default animations")
						return -1
					endIf
				endIf
			endIf
		endIf

		; Remove any animations without filtered gender tags
		if Config.RestrictGenderTag
			string DefGenderTag = ""
			i = ActorCount
			int[] GendersAll = ActorLib.GetGendersAll(Positions)
			int[] FutasAll = ActorLib.GetTransAll(Positions)
			while i ;Make Position Gender Tag
				i -= 1
				if GendersAll[i] == 0
					DefGenderTag = "M" + DefGenderTag
				elseIf GendersAll[i] == 1
					DefGenderTag = "F" + DefGenderTag
				elseIf GendersAll[i] >= 2
					DefGenderTag = "C" + DefGenderTag
				endIf
			endWhile
			if DefGenderTag != ""
				string[] GenderTag = Utility.CreateStringArray(1, DefGenderTag)
				;Filtering Futa animations
				if (Futas[0] + Futas[1]) < 1
					BasicFilters = AddString(BasicFilters, "Futa")
				elseIf (Futas[0] + Futas[1]) != (Genders[0] + Genders[1])
					Filters = AddString(Filters, "AllFuta")
					Filters = AddString(Filters, "FutaAll")
				endIf
				;Make Extra Position Gender Tag if actor is Futanari or female use strapon
				i = ActorCount
				while i
					i -= 1
					if (Config.UseStrapons && GendersAll[i] == 1) || (FutasAll[i] == 1)
						if StringUtil.GetNthChar(DefGenderTag, ActorCount - i) == "F"
							GenderTag = AddString(GenderTag, StringUtil.Substring(DefGenderTag, 0, ActorCount - i) + "M" + StringUtil.Substring(DefGenderTag, (ActorCount - i) + 1))
						endIf
					elseIf (FutasAll[i] == 0)
						if StringUtil.GetNthChar(DefGenderTag, ActorCount - i) == "M"
							GenderTag = AddString(GenderTag, StringUtil.Substring(DefGenderTag, 0, ActorCount - i) + "F" + StringUtil.Substring(DefGenderTag, (ActorCount - i) + 1))
						endIf
					endIf
				endWhile
				if Config.UseStrapons
					DefGenderTag = ActorLib.GetGenderTag(0, Males + Females, Creatures)
					GenderTag = AddString(GenderTag, DefGenderTag)
				endIf
				DefGenderTag = ActorLib.GetGenderTag(Females, Males, Creatures)
				GenderTag = AddString(GenderTag, DefGenderTag)
				
				DefGenderTag = ActorLib.GetGenderTag(Females + Futas[0] - Futas[1], Males - Futas[0] + Futas[1], Creatures)
				GenderTag = AddString(GenderTag, DefGenderTag)
				; Remove filtered gender tags from primary
				FilteredPrimary = sslUtility.FilterTaggedAnimations(PrimaryAnimations, GenderTag, true)
				if FilteredPrimary.Length > 0 && PrimaryAnimations.Length > FilteredPrimary.Length
					Log("Filtered out '"+(PrimaryAnimations.Length - FilteredPrimary.Length)+"' primary animations without tags: "+GenderTag)
					PrimaryAnimations = FilteredPrimary
				endIf
				; Remove filtered gender tags from lead in
				if LeadAnimations && LeadAnimations.Length > 0
					FilteredLead = sslUtility.FilterTaggedAnimations(LeadAnimations, GenderTag, true)
					if LeadAnimations.Length > FilteredLead.Length
						Log("Filtered out '"+(LeadAnimations.Length - FilteredLead.Length)+"' lead in animations without tags: "+GenderTag)
						LeadAnimations = FilteredLead
					endIf
				endIf
			endIf
		endIf
		
		; Remove filtered tags from primary step by step
		; FurnitureFilters have special treatament
		if FurnitureFilters.Length > 0
			FilteredPrimary = sslUtility.FilterTaggedAnimations(PrimaryAnimations, PapyrusUtil.StringArray(1, "Furniture"), true)
			if FilteredPrimary.Length > 0
				if FurnitureFilters.Length != Config.ActiveFurnitureTags.Length
					string[] TempTag
					i = Config.ActiveFurnitureTags.Length
					while i
						i -= 1
						if FurnitureFilters.Find(Config.ActiveFurnitureTags[i]) < 0
							TempTag = PapyrusUtil.PushString(TempTag, Config.ActiveFurnitureTags[i])
						endIf
					endWhile
					FilteredPrimary = sslUtility.FilterTaggedAnimations(FilteredPrimary, TempTag, true)
					if FilteredPrimary.Length > 0 && PrimaryAnimations.Length > FilteredPrimary.Length
						Log("Filtered out '"+(PrimaryAnimations.Length - FilteredPrimary.Length)+"' primary animations without tags: "+TempTag)
						PrimaryAnimations = FilteredPrimary
					endIf
				else
					FilteredPrimary = sslUtility.FilterTaggedAnimations(FilteredPrimary, FurnitureFilters, true)
					if FilteredPrimary.Length > 0 && PrimaryAnimations.Length > FilteredPrimary.Length
					;	Log("Filtered out '"+(PrimaryAnimations.Length - FilteredPrimary.Length)+"' primary animations with tags: "+FurnitureFilters)
						Log("Filtered out '"+FilteredPrimary.Length+"' primary animations with tags: "+FurnitureFilters)
						PrimaryAnimations = sslUtility.RemoveDupesFromList(PrimaryAnimations, FilteredPrimary)
					endIf
				endIf
			endIf
		endIf
		; ToDo: Use the PapyrusUtil GetMatchingString to avoid some filters
		FilteredPrimary = sslUtility.FilterTaggedAnimations(PrimaryAnimations, BedFilters, false)
		if FilteredPrimary.Length > 0 && PrimaryAnimations.Length > FilteredPrimary.Length
			Log("Filtered out '"+(PrimaryAnimations.Length - FilteredPrimary.Length)+"' primary animations with tags: "+BedFilters)
			PrimaryAnimations = FilteredPrimary
		endIf
		FilteredPrimary = sslUtility.FilterTaggedAnimations(PrimaryAnimations, RestrictiveFilters, false)
		if FilteredPrimary.Length > 0 && PrimaryAnimations.Length > FilteredPrimary.Length
			Log("Filtered out '"+(PrimaryAnimations.Length - FilteredPrimary.Length)+"' primary animations with tags: "+RestrictiveFilters)
			PrimaryAnimations = FilteredPrimary
		endIf
		FilteredPrimary = sslUtility.FilterTaggedAnimations(PrimaryAnimations, BasicFilters, false)
		if FilteredPrimary.Length > 0 && PrimaryAnimations.Length > FilteredPrimary.Length
			Log("Filtered out '"+(PrimaryAnimations.Length - FilteredPrimary.Length)+"' primary animations with tags: "+BasicFilters)
			PrimaryAnimations = FilteredPrimary
		endIf
		FilteredPrimary = sslUtility.FilterTaggedAnimations(PrimaryAnimations, Filters, false)
		if FilteredPrimary.Length > 0 && PrimaryAnimations.Length > FilteredPrimary.Length
			Log("Filtered out '"+(PrimaryAnimations.Length - FilteredPrimary.Length)+"' primary animations with tags: "+Filters)
			PrimaryAnimations = FilteredPrimary
		endIf
		; Remove filtered tags from lead in
		if LeadAnimations && LeadAnimations.Length > 0
			Filters = PapyrusUtil.MergeStringArray(Filters, BasicFilters, true)
			Filters = PapyrusUtil.MergeStringArray(Filters, RestrictiveFilters, true)
			Filters = PapyrusUtil.MergeStringArray(Filters, BedFilters, true)
			Filters = PapyrusUtil.MergeStringArray(Filters, FurnitureFilters, true)
			FilteredLead = sslUtility.FilterTaggedAnimations(LeadAnimations, Filters, false)
			if LeadAnimations.Length > FilteredLead.Length
				Log("Filtered out '"+(LeadAnimations.Length - FilteredLead.Length)+"' lead in animations with tags: "+Filters)
				LeadAnimations = FilteredLead
			endIf
		endIf
		; Remove any animations with filtered Fetish tags
		if Config.RestrictFetishTags && ActorCount != Creatures
			string[] FetishTag = new string[3]
			if ActorCount == 1 || ActorLib.IsCreature(Positions[1])
				if !(Positions[0].HasKeyword(Vampire))
					FetishTag[0] = "Vampire"
				endIf
				if !(Positions[0].IsInFaction(JobSpellFaction) || Positions[0].IsInFaction(CollegeofWinterholdFaction) || Positions[0].IsInFaction(WarlockFaction) || Positions[0].IsInFaction(NecromancerFaction) || Positions[0].HasKeyword(ActorTypeDaedra) || Positions[0].HasKeyword(ActorTypeGhost))
					FetishTag[1] = "Mage"
				endIf
				if !(Positions[0].IsInFaction(JobApothecaryFaction) || Positions[0].IsInFaction(JobTrainerAlchemyFaction))
					FetishTag[2] = "Alchemy"
				endIf
			else
				if !(Positions[1].HasKeyword(Vampire))
					FetishTag[0] = "Vampire"
				endIf
				if !(Positions[1].IsInFaction(JobSpellFaction) || Positions[1].IsInFaction(CollegeofWinterholdFaction) || Positions[1].IsInFaction(WarlockFaction) || Positions[1].IsInFaction(NecromancerFaction) || Positions[1].HasKeyword(ActorTypeDaedra) || Positions[1].HasKeyword(ActorTypeGhost))
					FetishTag[1] = "Mage"
				endIf
				if !(Positions[1].IsInFaction(JobApothecaryFaction) || Positions[1].IsInFaction(JobTrainerAlchemyFaction))
					FetishTag[2] = "Alchemy"
				endIf
			endIf
			FetishTag = PapyrusUtil.RemoveString(FetishTag, "")
			; Necro detection
			if RequiredTags.Find("Necro")
				FetishTag = PapyrusUtil.PushString(FetishTag, "Necro")
			endIf
			; Remove filtered tags from primary
			FilteredPrimary = sslUtility.FilterTaggedAnimations(PrimaryAnimations, FetishTag, False)
			if FilteredPrimary.Length > 0 && PrimaryAnimations.Length > FilteredPrimary.Length
				Log("Filtered out '"+(PrimaryAnimations.Length - FilteredPrimary.Length)+"' primary animations with tags: "+FetishTag)
				PrimaryAnimations = FilteredPrimary
			endIf
			; Remove filtered tags from lead in
			if LeadAnimations && LeadAnimations.Length > 0
				FilteredLead = sslUtility.FilterTaggedAnimations(LeadAnimations, FetishTag, False)
				if LeadAnimations.Length > FilteredLead.Length
					Log("Filtered out '"+(LeadAnimations.Length - FilteredLead.Length)+"' lead in animations with tags: "+FetishTag)
					LeadAnimations = FilteredLead
				endIf
			endIf
		endIf
		; Remove Dupes
		if LeadAnimations && PrimaryAnimations && PrimaryAnimations.Length > LeadAnimations.Length
			PrimaryAnimations = sslUtility.RemoveDupesFromList(PrimaryAnimations, LeadAnimations)
		endIf
		; Make sure we are still good to start after all the filters
		if !LeadAnimations || LeadAnimations.Length < 1
			LeadIn = false
		endIf
		if !PrimaryAnimations || PrimaryAnimations.Length < 1
			Fatal("Empty primary animations after filters")
			return -1
		endIf
		Log("FilterAnimations() END - LeadAnimations="+LeadAnimations.Length+", PrimaryAnimations="+PrimaryAnimations.Length)
		return 1
	endIf
	return 0
endFunction

; ------------------------------------------------------- ;
; --- Thread Settings                                 --- ;
; ------------------------------------------------------- ;

function DisableLeadIn(bool disabling = true)
	NoLeadIn = disabling
	if disabling
		LeadIn = false
	endIf
endFunction

function DisableBedUse(bool disabling = true)
	BedStatus[0] = 0
	if disabling
		BedStatus[0] = -1
	endIf
endFunction

function SetBedFlag(int flag = 0)
	BedStatus[0] = flag
endFunction

function DisableFurnitureUse(bool disabling = true)
	FurnitureStatus[0] = 0
	if disabling
		FurnitureStatus[0] = -1
	endIf
endFunction

function SetFurnitureFlag(int flag = 0)
	FurnitureStatus[0] = flag
endFunction

function SetFurnitureIgnored(bool disabling = true)
	if !CenterRef || CenterRef == none
		return
	endIf
	CenterRef.SetDestroyed(disabling)
;	CenterRef.ClearDestruction()
	CenterRef.BlockActivation(disabling)
	CenterRef.SetNoFavorAllowed(disabling)
endFunction

ObjectReference CircleOfIntimacy
function SetCircleOfIntimacy(bool disabling = true)
	if CircleOfIntimacy
		CircleOfIntimacy.Disable()
		CircleOfIntimacy.Delete()
		CircleOfIntimacy = none
	endIf
	if !disabling && CenterRef
		CircleOfIntimacy = CenterRef.PlaceAtMe(Config.CircleOfIntimacy)
		int cycle
		while !CircleOfIntimacy.Is3DLoaded() && cycle < 50
			Utility.Wait(0.1)
			cycle += 1
		endWhile
		if cycle
			Log("Waited ["+cycle+"] cycles for CircleOfIntimacy["+CircleOfIntimacy+"]")
		endIf
		CircleOfIntimacy.Enable()
	endIf
endFunction

function SetTimers(float[] SetTimers)
	if !SetTimers || SetTimers.Length < 1
		Log("SetTimers() - Empty timers given.", "ERROR")
	else
		CustomTimers    = SetTimers
		UseCustomTimers = true
	endIf
endFunction

float function GetStageTimer(int maxstage)
	int last = ( Timers.Length - 1 )
	if stage == maxstage
		return Timers[last]
	elseIf stage < last
		return Timers[(stage - 1)]
	endIf
	return Timers[(last - 1)]
endfunction

int function AreUsingFurniture(Actor[] ActorList)
	if !ActorList || ActorList.Length < 1
		return -1
	endIf
	
	int i = ActorList.Length
	ObjectReference TempFurnitureRef
	while i > 0
		i -= 1
		TempFurnitureRef = ActorList[i].GetFurnitureReference()
		if TempFurnitureRef && TempFurnitureRef != none
			int FurnitureType = ThreadLib.GetBedType(TempFurnitureRef)
			if FurnitureType > 0
				return FurnitureType
			endIf
			FurnitureType = ThreadLib.GetFurnitureType(TempFurnitureRef)
			If FurnitureType >= 0 && Config.ActiveFurnitureTags.Find(Config.FurnitureTags[FurnitureType]) >= 0
				return  4 + FurnitureType
			endIf
		endIf
	endWhile
	return -1
endFunction

bool function SortFurnitureActors()
	if CenterRef && UsingFurniture
		int i = Positions.Length
		while i > 0
			i -= 1
			sslActorAlias Slot = ActorAlias(Positions[i])
			if Slot.GetRestricted() && Slot.GetFurnitureRef() == CenterRef
				if i != 0
					Positions = ThreadLib.SortFurnitureActors(Positions, i)
				endIf
				return true
			endIf
		endWhile
	endIf
	return false
endfunction

function CenterOnObject(ObjectReference CenterOn, bool resync = true)
	if CenterOn
		CenterRef = CenterOn
		; Check if it's a bed
		FurnitureRef  = none
		BedRef  = none
		BedStatus[1] = 0
		FurnitureStatus[1] = 0
		int Pos = Positions.Find(CenterOn as Actor)
		if Pos >= 0
			int SlotID = FindSlot(Positions[Pos])
			if SlotID != -1
				ActorAlias[SlotID].LockActor()
			endIf
			if CenterOn == VictimRef as ObjectReference
				Log("CenterRef == VictimRef: "+VictimRef)
			elseIf CenterOn == PlayerRef as ObjectReference
				Log("CenterRef == PlayerRef: "+PlayerRef)
			else
				Log("CenterRef == Positions["+Pos+"]: "+CenterRef)
			endIf
		elseIf CenterOn.GetBaseObject() != Config.LocationMarker && CenterOn.GetBaseObject() != Config.XMarkerHiddenPlace
			BedStatus[1] = ThreadLib.GetBedType(CenterOn)
			FurnitureStatus[1] = BedStatus[1]
			if FurnitureStatus[1] == 0
				int iFurn = ThreadLib.GetFurnitureType(CenterRef)
				if iFurn >= 0
					FurnitureStatus[1] = 4 + iFurn
				endIf
			endIf
		endIf
		; Get Position after Lock the Actor to aviod unwanted teleport.
		CenterLocation[0] = CenterOn.GetPositionX()
		CenterLocation[1] = CenterOn.GetPositionY()
		CenterLocation[2] = CenterOn.GetPositionZ()
		CenterLocation[3] = CenterOn.GetAngleX()
		CenterLocation[4] = CenterOn.GetAngleY()
		CenterLocation[5] = CenterOn.GetAngleZ()
		if FurnitureStatus[1] > 0
			FurnitureRef = CenterOn
			float[] FurnitureOffsets
			if FurnitureStatus[1] < 4
				BedRef = CenterOn
				Log("CenterRef == BedRef: "+BedRef)
				FurnitureOffsets = Config.GetBedOffsets(BedRef.GetBaseObject())
				if FurnitureStatus[1] == 1 && FurnitureOffsets == Config.BedOffset
					FurnitureOffsets[2] = 7.5 ; Most common BedRolls Up offset
					FurnitureOffsets[3] = 180 ; Most BedRolls meshes are rotated
				endIf
			else
				Log("CenterRef == FurnitureRef: "+FurnitureRef)
				FurnitureOffsets = Config.GetFurnitureOffsets(FurnitureRef.GetBaseObject())
			endIf
			Log("Using Furniture Type: "+FurnitureStatus[1]+"; "+CenterOn.GetBaseObject())
			Log("Furniture Location[PosX:"+CenterLocation[0]+",PosY:"+CenterLocation[1]+",PosZ:"+CenterLocation[2]+",AngX:"+CenterLocation[3]+",AngY:"+CenterLocation[4]+",AngZ:"+CenterLocation[5]+"]")
			Log("Furniture Offset[Forward:"+FurnitureOffsets[0]+",Sideward:"+FurnitureOffsets[1]+",Upward:"+FurnitureOffsets[2]+",Rotation:"+FurnitureOffsets[3]+"]")
			float Scale = CenterOn.GetScale()
			if Scale != 1.0
				FurnitureOffsets[0] = FurnitureOffsets[0] * Scale ; (((2-Scale)*((Math.ABS(FurnitureOffsets[0])-FurnitureOffsets[0])/(2*Math.ABS(FurnitureOffsets[0]))))+(Scale*((FurnitureOffsets[0]+Math.ABS(FurnitureOffsets[0]))/(2*FurnitureOffsets[0]))))
				FurnitureOffsets[1] = FurnitureOffsets[1] * Scale ; (((2-Scale)*((Math.ABS(FurnitureOffsets[1])-FurnitureOffsets[1])/(2*Math.ABS(FurnitureOffsets[1]))))+(Scale*((FurnitureOffsets[1]+Math.ABS(FurnitureOffsets[1]))/(2*FurnitureOffsets[1]))))
				
			;	If FurnitureOffsets[2] != 0.0
			;		FurnitureOffsets[2] = FurnitureOffsets[2] * (((2-Scale)*((Math.ABS(FurnitureOffsets[2])-FurnitureOffsets[2])/(2*Math.ABS(FurnitureOffsets[2]))))+(Scale*((FurnitureOffsets[2]+Math.ABS(FurnitureOffsets[2]))/(2*FurnitureOffsets[2]))))
			;	EndIf
				
				If FurnitureOffsets[2] < 0
					FurnitureOffsets[2] = FurnitureOffsets[2] * (2-Scale)
				Else
					FurnitureOffsets[2] = FurnitureOffsets[2] * Scale
				EndIf
				
			;	FurnitureOffsets[3] = FurnitureOffsets[3]
				
				Log("Scaled Furniture Offset[Forward:"+FurnitureOffsets[0]+",Sideward:"+FurnitureOffsets[1]+",Upward:"+FurnitureOffsets[2]+",Rotation:"+FurnitureOffsets[3]+"]")
			;	Log("Scaled Furniture Offset[Forward:"+FurnitureOffsets[0]+",Sideward:"+FurnitureOffsets[1]+",Upward:"+NewZ+",Rotation:"+FurnitureOffsets[3]+"]")
			endIf
			CenterLocation[0] = CenterLocation[0] + ((FurnitureOffsets[0] * Math.sin(CenterLocation[5])) + (FurnitureOffsets[1] * Math.cos(CenterLocation[5])))
			CenterLocation[1] = CenterLocation[1] + ((FurnitureOffsets[0] * Math.cos(CenterLocation[5])) - (FurnitureOffsets[1] * Math.sin(CenterLocation[5])))
			CenterLocation[2] = CenterLocation[2] + FurnitureOffsets[2]
			CenterLocation[5] = CenterLocation[5] + FurnitureOffsets[3]
			SetFurnitureIgnored(true)
		elseIf CenterRef.GetBaseObject() == Config.XMarkerHiddenPlace
			CenterRef.Disable()
		endIf
		if CenterAlias.GetReference() != CenterRef
			CenterAlias.TryToClear()
			CenterAlias.ForceRefTo(CenterRef)
		endIf
		if Config.UseIntimacyCircle
			SetCircleOfIntimacy(false)
		endIf
	endIf
endFunction

function CenterOnCoords(float LocX = 0.0, float LocY = 0.0, float LocZ = 0.0, float RotX = 0.0, float RotY = 0.0, float RotZ = 0.0, bool resync = true)
	CenterLocation[0] = LocX
	CenterLocation[1] = LocY
	CenterLocation[2] = LocZ
	CenterLocation[3] = RotX
	CenterLocation[4] = RotY
	CenterLocation[5] = RotZ
endFunction

bool function CenterOnHiddenMarker(bool AskPlayer = true, float Radius = 1500.0)
	bool InStart = GetState() == "Starting" || GetState() == "Making"
	int AskHidden = Config.UseXMarkerHidden
	if HiddenStatus == -1 || (InStart && (!HasPlayer && Config.NPCHidden == 0) || (HasPlayer && AskHidden == 0))
		return false ; Hiddens forbidden by flag or starting Hidden check/prompt disabled
	endIf
	bool HiddenScene = HiddenStatus == 1 
 	ObjectReference FoundMarker
	if !HiddenScene
		ObjectReference TempRef = Positions[0]
		if HasPlayer
			TempRef = PlayerRef
		endIf
		if TempRef && !TempRef.IsInInterior()
			Location CurrentLocation = TempRef.GetCurrentLocation()
			HiddenScene = ThreadLib.LocationHasKeyword(CurrentLocation, Keyword.GetKeyword("LocTypeCity")) || ThreadLib.LocationHasKeyword(CurrentLocation, Keyword.GetKeyword("LocTypeTown"))
		endIf
	endIf

	if HasPlayer && (!InStart || AskHidden == 1 ||  AskHidden == 3 || (AskHidden == 2 && (!IsVictim(PlayerRef) || UseNPCHidden)))
		if HiddenScene
			FoundMarker  = ThreadLib.FindHiddenReference(Positions, Config.XMarkerHiddenPlace, PlayerRef,  Radius * 2) ; Check within radius of player
		else
			FoundMarker  = ThreadLib.FindHiddenReference(Positions, Config.XMarkerHiddenPlace, PlayerRef,  Radius) ; Check within radius of player
			; Same Floor only
		;	if FoundMarker && !ThreadLib.SameFloor(FoundMarker, PlayerRef.GetPositionZ(), 200)
		;		Log("FoundMarker: "+FoundMarker+" is not in the same floor")
		;		FoundMarker = none
		;	endIf
		endIf
	;	AskPlayer = AskPlayer && AskHidden < 3 && (!InStart || !(AskHidden == 2 && IsVictim(PlayerRef))) ; Disable prompt if Hidden found but shouldn't ask
	elseIf !HasPlayer && UseNPCHidden
		if HiddenScene
			FoundMarker = ThreadLib.FindHiddenReference(Positions, Config.XMarkerHiddenPlace, Positions[0], Radius * 2) ; Check within radius of first position, if NPC Hiddens are allowed
		else
			FoundMarker = ThreadLib.FindHiddenReference(Positions, Config.XMarkerHiddenPlace, Positions[0], Radius) ; Check within radius of first position, if NPC Hiddens are allowed
			; Same Floor only
		;	if FoundMarker && !ThreadLib.SameFloor(FoundMarker, PlayerRef.GetPositionZ(), 200)
		;		Log("FoundMarker: "+FoundMarker+" is not in the same floor")
		;		FoundMarker = none
		;	endIf
		endIf
	endIf
	; Found a Hidden AND EITHER forced use OR don't care about players choice OR or player approved
	if FoundMarker ;&& (HiddenScene || (!AskPlayer || (AskPlayer && (Config.UseHidden.Show() as bool))))
		CenterOnObject(FoundMarker)
		return true ; Hidden found and approved for use
	endIf
	return false ; No Hidden found
endFunction

bool function CenterOnBed(bool AskPlayer = true, float Radius = 750.0)
	bool InStart = GetState() == "Starting" || GetState() == "Making"
	int AskBed = Config.AskBed
	if BedStatus[0] == -1 || (InStart && (!HasPlayer && Config.NPCBed == 0) || (HasPlayer && AskBed == 0))
		return false ; Beds forbidden by flag or starting bed check/prompt disabled
	endIf
	bool BedScene = BedStatus[0] == 1 || HasTag("BedOnly")
 	ObjectReference FoundBed
	int i = ActorCount
	while i > 0
		i -= 1
		FoundBed = Positions[i].GetFurnitureReference()
		if FoundBed
			int BedType = ThreadLib.GetBedType(FoundBed)
			if BedType > 0 && (ActorCount < 4 || BedType != 2)
				CenterOnObject(FoundBed)
				return true ; Bed found and approved for use
			endIf
		endIf
	endWhile
	if HasPlayer && (!InStart || AskBed == 1 ||  AskBed == 3 || (AskBed == 2 && (!IsVictim(PlayerRef) || UseNPCBed)))
		if BedScene || HiddenStatus == 1
			FoundBed  = ThreadLib.FindBed(PlayerRef, Radius * (2 + 1 + HiddenStatus)) ; Check within radius of player
		else
			FoundBed  = ThreadLib.FindBed(PlayerRef, Radius) ; Check within radius of player
			; Same Floor only
		;	if FoundBed && !ThreadLib.SameFloor(FoundBed, PlayerRef.GetPositionZ(), 200)
		;		Log("FoundBed: "+FoundBed+" is not in the same floor")
		;		FoundBed = none
		;	endIf
		endIf
		AskPlayer = AskPlayer && AskBed < 3 && (!InStart || !(AskBed == 2 && IsVictim(PlayerRef))) ; Disable prompt if bed found but shouldn't ask
	elseIf !HasPlayer && UseNPCBed
		if BedScene || HiddenStatus == 1
			FoundBed = ThreadLib.FindBed(Positions[0], Radius * (2 + 1 + HiddenStatus)) ; Check within radius of first position, if NPC beds are allowed
		else
			FoundBed = ThreadLib.FindBed(Positions[0], Radius) ; Check within radius of first position, if NPC beds are allowed
			; Same Floor only
		;	if FoundBed && !ThreadLib.SameFloor(FoundBed, PlayerRef.GetPositionZ(), 200)
		;		Log("FoundBed: "+FoundBed+" is not in the same floor")
		;		FoundBed = none
		;	endIf
		endIf
	endIf
	; Found a bed AND EITHER forced use OR don't care about players choice OR or player approved
	if FoundBed && (BedScene || (!AskPlayer || (AskPlayer && (Config.UseBed.Show() as bool))))
		CenterOnObject(FoundBed)
		return true ; Bed found and approved for use
	endIf
	return false ; No bed found
endFunction

bool function CenterOnNearBed(ObjectReference Reference, float Radius = 400.0, bool AskPlayer = true)
	bool InStart = GetState() == "Starting" || GetState() == "Making"
	int AskBed = Config.AskBed
	if BedStatus[0] == -1 || (InStart && (!HasPlayer && Config.NPCBed == 0) || (HasPlayer && AskBed == 0))
		return false ; Beds forbidden by flag or starting bed check/prompt disabled
	endIf
	bool BedScene = BedStatus[0] == 1 || HasTag("BedOnly")
 	ObjectReference FoundBed
	int i = ActorCount
	while i > 0
		i -= 1
		FoundBed = Positions[i].GetFurnitureReference()
		if FoundBed
			int BedType = ThreadLib.GetBedType(FoundBed)
			if BedType > 0 && (ActorCount < 4 || BedType != 2)
				CenterOnObject(FoundBed)
				return true ; Bed found and approved for use
			endIf
		endIf
	endWhile
	if (HasPlayer && (!InStart || AskBed == 1 ||  AskBed == 3 || (AskBed == 2 && (!IsVictim(PlayerRef) || UseNPCBed)))) || (!HasPlayer && UseNPCBed)
		if BedScene || HiddenStatus == 1
			FoundBed  = ThreadLib.FindBed(Reference, Radius * (2 + 1 + HiddenStatus)) ; Check within radius of Reference
		else
			FoundBed  = ThreadLib.FindBed(Reference, Radius) ; Check within radius of Reference
			; Same Floor only
		;	if FoundBed && !ThreadLib.SameFloor(FoundBed, PlayerRef.GetPositionZ(), 200)
		;		Log("FoundBed: "+FoundBed+" is not in the same floor")
		;		FoundBed = none
		;	endIf
		endIf
		AskPlayer = AskPlayer && AskBed < 3 && (!InStart || !(AskBed == 2 && IsVictim(PlayerRef))) ; Disable prompt if bed found but shouldn't ask
	endIf
	; Found a bed AND EITHER forced use OR don't care about players choice OR or player approved
	if FoundBed && (BedScene || (!AskPlayer || (HasPlayer && (Config.UseBed.Show() as bool))))
		CenterOnObject(FoundBed)
		return true ; Bed found and approved for use
	endIf
	return false ; No bed found
endFunction

bool function CenterOnFurniture(bool AskPlayer = true, float Radius = 750.0)
	bool InStart = GetState() == "Starting" || GetState() == "Making"
	int AskFurniture = Config.AskFurniture
 	bool UseAdvancedFurn = Config.UseAdvancedFurn
	if !Config.AllowFurniture || (!UseAdvancedFurn && FurnitureStatus[0] == -1) || Config.FurnitureExtraLists.Length < 1 || (InStart && (!HasPlayer && Config.NPCFurniture == 0) || (HasPlayer && AskFurniture == 0))
		return false ; Furnitures forbidden by flag or starting Furniture check/prompt disabled
	endIf
	bool FurnitureScene = FurnitureStatus[0] == 1 || (UseAdvancedFurn && BedStatus[0] == 1) || HasTag("FurnitureOnly")
	ObjectReference FoundFurniture
	int aid = -1
	sslBaseAnimation[] FurnitureAnimations
	if !UseAdvancedFurn && Animations.Length > 0 
		if HasTag("Furniture")
			FurnitureAnimations = Animations
			if FurnitureAnimations.Length > 0
				aid = Utility.RandomInt(0, (FurnitureAnimations.Length - 1))
				FurnitureScene = true
			else
				return false
			endIf
		else
			FurnitureAnimations = sslUtility.FilterTaggedAnimations(Animations, PapyrusUtil.StringArray(1, "Furniture"), true)
			if FurnitureAnimations.Length > 0
				aid = Utility.RandomInt(0, (FurnitureAnimations.Length - 1))
			else
				return false
			endIf
		endIf
	endIf
	bool UseFurniture = UseNPCFurniture || Config.NPCFurniture > 0 && (aid >= 0 || AreUsingFurniture(Positions) > 4)
	if HasPlayer && (!InStart || AskFurniture == 1 || AskFurniture == 3 || (AskFurniture == 2 && (!IsVictim(PlayerRef) || UseFurniture)))
		AskPlayer = AskPlayer && AskFurniture < 3 && (!InStart || !(AskFurniture == 2 && IsVictim(PlayerRef))) ; Disable prompt if Furniture found but shouldn't ask
		if aid >= 0
			if FurnitureScene || HiddenStatus == 1
				FoundFurniture = ThreadLib.FindFurnitureForAnimation(Positions, FurnitureAnimations[aid], PlayerRef, Radius * (2 + 1 + HiddenStatus), HiddenType = HiddenStatus)
			else
				FoundFurniture = ThreadLib.FindFurnitureForAnimation(Positions, FurnitureAnimations[aid], PlayerRef, Radius, HiddenType = HiddenStatus)
				; Same Floor only
				if FoundFurniture && !ThreadLib.SameFloor(FoundFurniture, PlayerRef.GetPositionZ(), 200)
					Log("FoundFurniture: "+FoundFurniture+" is not in the same floor")
					FoundFurniture = none
				endIf
			endIf
		else
			if FurnitureScene || HiddenStatus == 1
				if UseAdvancedFurn
					int AllowBed = BedStatus[0]
					if AllowBed == 0 && (!HasPlayer && Config.NPCBed == 0) || (HasPlayer && Config.AskBed == 0)
						AllowBed = -1
					endIf
					FoundFurniture = Config.FurnitureMarkers.FindFurnitureForAnimations(Positions, Animations, PlayerRef, Radius * (1 + 1 + HiddenStatus), AskPlayer, AllowBed, FurnitureStatus[0], HiddenStatus)
				else
					FoundFurniture = ThreadLib.FindFurnitureForAnimation(Positions, none, PlayerRef, Radius * (1 + 1 + HiddenStatus), HiddenType = HiddenStatus)
				endIf
			else
				if UseAdvancedFurn
					int AllowBed = BedStatus[0]
					if AllowBed == 0 && (!HasPlayer && Config.NPCBed == 0) || (HasPlayer && Config.AskBed == 0)
						AllowBed = -1
					endIf
					FoundFurniture = Config.FurnitureMarkers.FindFurnitureForAnimations(Positions, Animations, PlayerRef, Radius * 0.5, AskPlayer, AllowBed, FurnitureStatus[0], HiddenStatus)
				else
					FoundFurniture = ThreadLib.FindFurnitureForAnimation(Positions, none, PlayerRef, Radius * 0.5, HiddenType = HiddenStatus)
					; Same Floor only
					if FoundFurniture && !ThreadLib.SameFloor(FoundFurniture, PlayerRef.GetPositionZ(), 200)
						Log("FoundFurniture: "+FoundFurniture+" is not in the same floor")
						FoundFurniture = none
					endIf
				endIf
			endIf
		endIf
	elseIf !HasPlayer && UseFurniture
		if aid >= 0
			if FurnitureScene || HiddenStatus == 1
				FoundFurniture = ThreadLib.FindFurnitureForAnimation(Positions, FurnitureAnimations[aid], Positions[0], Radius * (2 + 1 + HiddenStatus), HiddenType = HiddenStatus)
			else
				FoundFurniture = ThreadLib.FindFurnitureForAnimation(Positions, FurnitureAnimations[aid], Positions[0], Radius, HiddenType = HiddenStatus)
				; Same Floor only
				if FoundFurniture && !ThreadLib.SameFloor(FoundFurniture, Positions[0].GetPositionZ(), 200)
					Log("FoundFurniture: "+FoundFurniture+" is not in the same floor")
					FoundFurniture = none
				endIf
			endIf
		else
			if FurnitureScene || HiddenStatus == 1
				if UseAdvancedFurn
					int AllowBed = BedStatus[0]
					if AllowBed == 0 && (!HasPlayer && Config.NPCBed == 0) || (HasPlayer && Config.AskBed == 0)
						AllowBed = -1
					endIf
					FoundFurniture = Config.FurnitureMarkers.FindFurnitureForAnimations(Positions, Animations, Positions[0], Radius * (1 + 1 + HiddenStatus), false, AllowBed, FurnitureStatus[0], HiddenStatus)
				else
					FoundFurniture = ThreadLib.FindFurnitureForAnimation(Positions, none, Positions[0], Radius * (1 + 1 + HiddenStatus), HiddenType = HiddenStatus)
				endIf
			else
				if UseAdvancedFurn
					int AllowBed = BedStatus[0]
					if AllowBed == 0 && (!HasPlayer && Config.NPCBed == 0) || (HasPlayer && Config.AskBed == 0)
						AllowBed = -1
					endIf
					FoundFurniture = Config.FurnitureMarkers.FindFurnitureForAnimations(Positions, Animations, Positions[0], Radius * 0.5, false, AllowBed, FurnitureStatus[0], HiddenStatus)
				else
					FoundFurniture = ThreadLib.FindFurnitureForAnimation(Positions, none, Positions[0], Radius * 0.5, HiddenType = HiddenStatus)
					; Same Floor only
					if FoundFurniture && !ThreadLib.SameFloor(FoundFurniture, Positions[0].GetPositionZ(), 200)
						Log("FoundFurniture: "+FoundFurniture+" is not in the same floor")
						FoundFurniture = none
					endIf
				endIf
			endIf
		endIf
	endIf
	; Found a Furniture AND EITHER forced use OR don't care about players choice OR or player approved
	if FoundFurniture && (FurnitureScene || UseAdvancedFurn || (!AskPlayer || (HasPlayer && (Config.UseFurniture.Show() as bool))))
		CenterOnObject(FoundFurniture)
		SortFurnitureActors()
		return true ; Furniture found and approved for use
	elseIf FoundFurniture
		int i = ActorCount
		while i > 0
			i -= 1
			if ActorAlias[i] != none
				ActorAlias[i].SetFurnitureRef(none)
			endIf
		endwhile
	endIf
	return false ; No Furniture found
endFunction

bool function CenterOnNearFurniture(ObjectReference Reference, float Radius = 400.0, bool AskPlayer = true)
	bool InStart = GetState() == "Starting" || GetState() == "Making"
	int AskFurniture = Config.AskFurniture
 	bool UseAdvancedFurn = Config.UseAdvancedFurn
	if !Config.AllowFurniture || (!UseAdvancedFurn && FurnitureStatus[0] == -1) || Config.FurnitureExtraLists.Length < 1 || (InStart && (!HasPlayer && Config.NPCFurniture == 0) || (HasPlayer && AskFurniture == 0))
		return false ; Furnitures forbidden by flag or starting Furniture check/prompt disabled
	endIf
	bool FurnitureScene = FurnitureStatus[0] == 1 || (UseAdvancedFurn && BedStatus[0] == 1) || HasTag("FurnitureOnly")
 	ObjectReference FoundFurniture
	int aid = -1
	sslBaseAnimation[] FurnitureAnimations
	if !UseAdvancedFurn && Animations.Length > 0 
		if HasTag("Furniture")
			FurnitureAnimations = Animations
			if FurnitureAnimations.Length > 0
				aid = Utility.RandomInt(0, (FurnitureAnimations.Length - 1))
				FurnitureScene = true
			else
				return false
			endIf
		else
			FurnitureAnimations = sslUtility.FilterTaggedAnimations(Animations, PapyrusUtil.StringArray(1, "Furniture"), true)
			if FurnitureAnimations.Length > 0
				aid = Utility.RandomInt(0, (FurnitureAnimations.Length - 1))
			else
				return false
			endIf
		endIf
	endIf
	bool UseFurniture = UseNPCFurniture || Config.NPCFurniture > 0 && (aid >= 0 || AreUsingFurniture(Positions) > 4)
	if (HasPlayer && (!InStart || AskFurniture == 1 || AskFurniture == 3 || (AskFurniture == 2 && (!IsVictim(PlayerRef) || UseFurniture)))) || (!HasPlayer && UseFurniture)
		AskPlayer = AskPlayer && AskFurniture < 3 && (!InStart || !(AskFurniture == 2 && IsVictim(PlayerRef))) ; Disable prompt if Furniture found but shouldn't ask
		if aid >= 0
			if FurnitureScene || HiddenStatus == 1
				FoundFurniture = ThreadLib.FindFurnitureForAnimation(Positions, FurnitureAnimations[aid], Reference, Radius * (2 + 1 + HiddenStatus), HiddenType = HiddenStatus)
			else
				FoundFurniture = ThreadLib.FindFurnitureForAnimation(Positions, FurnitureAnimations[aid], Reference, Radius, HiddenType = HiddenStatus)
				; Same Floor only
				if FoundFurniture && !ThreadLib.SameFloor(FoundFurniture, PlayerRef.GetPositionZ(), 200)
					Log("FoundFurniture: "+FoundFurniture+" is not in the same floor")
					FoundFurniture = none
				endIf
			endIf
		else
			if FurnitureScene || HiddenStatus == 1
				if UseAdvancedFurn
					int AllowBed = BedStatus[0]
					if AllowBed == 0 && (!HasPlayer && Config.NPCBed == 0) || (HasPlayer && Config.AskBed == 0)
						AllowBed = -1
					endIf
					FoundFurniture = Config.FurnitureMarkers.FindFurnitureForAnimations(Positions, Animations, Reference, Radius * (1 + 1 + HiddenStatus), AskPlayer, AllowBed, FurnitureStatus[0], HiddenStatus)
				else
					FoundFurniture = ThreadLib.FindFurnitureForAnimation(Positions, none, Reference, Radius * (1 + 1 + HiddenStatus), HiddenType = HiddenStatus)
				endIf
			else
				if UseAdvancedFurn
					int AllowBed = BedStatus[0]
					if AllowBed == 0 && (!HasPlayer && Config.NPCBed == 0) || (HasPlayer && Config.AskBed == 0)
						AllowBed = -1
					endIf
					FoundFurniture = Config.FurnitureMarkers.FindFurnitureForAnimations(Positions, Animations, Reference, Radius * 0.5, AskPlayer, AllowBed, FurnitureStatus[0], HiddenStatus)
				else
					FoundFurniture = ThreadLib.FindFurnitureForAnimation(Positions, none, Reference, Radius * 0.5, HiddenType = HiddenStatus)
					; Same Floor only
					if FoundFurniture && !ThreadLib.SameFloor(FoundFurniture, PlayerRef.GetPositionZ(), 200)
						Log("FoundFurniture: "+FoundFurniture+" is not in the same floor")
						FoundFurniture = none
					endIf
				endIf
			endIf
		endIf
	endIf
	; Found a Furniture AND EITHER forced use OR don't care about players choice OR or player approved
	if FoundFurniture && (FurnitureScene || UseAdvancedFurn || (!AskPlayer || (HasPlayer && (Config.UseFurniture.Show() as bool))))
		CenterOnObject(FoundFurniture)
		SortFurnitureActors()
		return true ; Furniture found and approved for use
	elseIf FoundFurniture
		int i = ActorCount
		while i > 0
			i -= 1
			if ActorAlias[i] != none
				ActorAlias[i].SetFurnitureRef(none)
			endIf
		endwhile
	endIf
	return false ; No Furniture found
endFunction

; ------------------------------------------------------- ;
; --- Event Hooks                                     --- ;
; ------------------------------------------------------- ;

function SetHook(string AddHooks)
	string[] Setting = PapyrusUtil.StringSplit(AddHooks)
	int i = Setting.Length
	while i
		i -= 1
		if Setting[i] != "" && Hooks.Find(Setting[i]) == -1
			AddTag(Setting[i])
			Hooks = PapyrusUtil.PushString(Hooks, Setting[i])
		endIf
	endWhile
endFunction

string function GetHook()
	return Hooks[0] ; v1.35 Legacy support, pre multiple hooks
endFunction

string[] function GetHooks()
	return Hooks
endFunction

function RemoveHook(string DelHooks)
	string[] Removing = PapyrusUtil.StringSplit(DelHooks)
	string[] NewHooks
	int i = Hooks.Length
	while i
		i -= 1
		if Removing.Find(Hooks[i]) != -1
			RemoveTag(Hooks[i])
		else
			NewHooks = PapyrusUtil.PushString(NewHooks, Hooks[i])
		endIf
	endWhile
	Hooks = NewHooks
endFunction

; ------------------------------------------------------- ;
; --- Tagging System                                  --- ;
; ------------------------------------------------------- ;

bool function HasTag(string Tag)
	return Tag != "" && Tags.Find(Tag) != -1
endFunction

bool function AddTag(string Tag)
	if Tag != "" && Tags.Find(Tag) == -1
		Tags = PapyrusUtil.PushString(Tags, Tag)
		return true
	endIf
	return false
endFunction

bool function RemoveTag(string Tag)
	if Tag != "" && Tags.Find(Tag) != -1
		Tags = PapyrusUtil.RemoveString(Tags, Tag)
		return true
	endIf
	return false
endFunction

function AddTags(string[] TagList)
	Tags = PapyrusUtil.MergeStringArray(Tags, TagList, True)
 endFunction

function SetTags(string TagList)
	AddTags(PapyrusUtil.StringSplit(TagList))
endFunction

bool function ToggleTag(string Tag)
	return (RemoveTag(Tag) || AddTag(Tag)) && HasTag(Tag)
endFunction

bool function AddTagConditional(string Tag, bool AddTag)
	if Tag != ""
		if AddTag
			AddTag(Tag)
		elseIf !AddTag
			RemoveTag(Tag)
		endIf
	endIf
	return AddTag
endFunction

;TODO: Use the new PapyrusUtil functions
; Because PapyrusUtil don't Remove Dupes from the Array
string[] function AddString(string[] ArrayValues, string ToAdd, bool RemoveDupes = true)
	if ToAdd != ""
		string[] Output = ArrayValues
		if !RemoveDupes || Output.length < 1
			return PapyrusUtil.PushString(Output, ToAdd)
		elseIf Output.Find(ToAdd) == -1
			int i = Output.Find("")
			if i != -1
				Output[i] = ToAdd
			else
				Output = PapyrusUtil.PushString(Output, ToAdd)
			endIf
		endIf
		return Output
	endIf
	return ArrayValues
endFunction

bool function CheckTags(string[] CheckTags, bool RequireAll = true, bool Suppress = false)
	int i = CheckTags.Length
	while i
		i -= 1
		if CheckTags[i] != ""
			bool Check = Tags.Find(CheckTags[i]) != -1
			if (Suppress && Check) || (!Suppress && RequireAll && !Check)
				return false ; Stop if we need all and don't have it, or are supressing the found tag
			elseIf !Suppress && !RequireAll && Check
				return true ; Stop if we don't need all and have one
			endIf
		endIf
	endWhile
	; If still here than we require all and had all
	return true
endFunction

string[] function GetTags()
	return Tags
endFunction

; ------------------------------------------------------- ;
; --- Actor Alias                                     --- ;
; ------------------------------------------------------- ;

int function FindSlot(Actor ActorRef)
	if !ActorRef
		return -1
	endIf
	int i
	while i < 5
		if ActorAlias[i].ActorRef == ActorRef
			return i
		endIf
		i += 1
	endWhile
	return -1
endFunction

sslActorAlias function ActorAlias(Actor ActorRef)
	int SlotID = FindSlot(ActorRef)
	if SlotID != -1
		return ActorAlias[SlotID]
	endIf
	return none
endFunction

sslActorAlias function PositionAlias(int Position)
	if Position < 0 || !(Position < Positions.Length)
		return none
	endIf
	return ActorAlias[FindSlot(Positions[Position])]
endFunction

; ------------------------------------------------------- ;
; --- Thread Events - SYSTEM USE ONLY                 --- ;
; ------------------------------------------------------- ;

function Action(string FireState)
	UnregisterForUpdate()
	EndAction()
	GoToState(FireState)
	FireAction()
endfunction

function SendThreadEvent(string HookEvent)
	Log(HookEvent, "Event Hook")
	SetupThreadEvent(HookEvent)
	int i = Hooks.Length
	while i
		i -= 1
		SetupThreadEvent(HookEvent+"_"+Hooks[i])
	endWhile
	; Legacy support for < v1.50 - To be removed eventually
	if HasPlayer
		SendModEvent("Player"+HookEvent, thread_id)
	endIf
endFunction

function SetupThreadEvent(string HookEvent)
	int eid = ModEvent.Create("Hook"+HookEvent)
	if eid
		ModEvent.PushInt(eid, thread_id)
		ModEvent.PushBool(eid, HasPlayer)
		ModEvent.Send(eid)
		; Log("Thread Hook Sent: "+HookEvent)
	endIf
	SendModEvent(HookEvent, thread_id)
endFunction

sslThreadHook[] ThreadHooks
function HookAnimationStarting()
	; Log("HookAnimationStarting() - "+ThreadHooks)
	int i = Config.GetThreadHookCount()
	while i > 0
		i -= 1
		if ThreadHooks[i] && ThreadHooks[i].CanRunHook(Positions, Tags) && ThreadHooks[i].AnimationStarting(self)
			Log("Global Hook AnimationStarting("+self+") - "+ThreadHooks[i])
		; else
		; 	Log("HookAnimationStarting() - Skipping["+i+"]: "+ThreadHooks[i])
		endIf
	endWhile
endFunction

function HookAnimationPrepare()
	; Log("HookAnimationPrepare() - "+ThreadHooks)
	int i = Config.GetThreadHookCount()
	while i > 0
		i -= 1
		if ThreadHooks[i] && ThreadHooks[i].CanRunHook(Positions, Tags) && ThreadHooks[i].AnimationPrepare(self as sslThreadController)
			Log("Global Hook AnimationPrepare("+self+") - "+ThreadHooks[i])
		; else
		; 	Log("HookAnimationPrepare() - Skipping["+i+"]: "+ThreadHooks[i])
		endIf
	endWhile
endFunction

function HookStageStart()
	int i = Config.GetThreadHookCount()
	while i > 0
		i -= 1
		if ThreadHooks[i] && ThreadHooks[i].CanRunHook(Positions, Tags) && ThreadHooks[i].StageStart(self as sslThreadController)
			Log("Global Hook StageStart("+self+") - "+ThreadHooks[i])
		; else
		; 	Log("HookStageStart() - Skipping["+i+"]: "+ThreadHooks[i])
		endIf
	endWhile
endFunction

function HookStageEnd()
	int i = Config.GetThreadHookCount()
	while i > 0
		i -= 1
		if ThreadHooks[i] && ThreadHooks[i].CanRunHook(Positions, Tags) && ThreadHooks[i].StageEnd(self as sslThreadController)
			Log("Global Hook StageEnd("+self+") - "+ThreadHooks[i])
		; else
		; 	Log("HookStageEnd() - Skipping["+i+"]: "+ThreadHooks[i])
		endIf
	endWhile
endFunction

function HookAnimationEnding()
	int i = Config.GetThreadHookCount()
	while i > 0
		i -= 1
		if ThreadHooks[i] && ThreadHooks[i].CanRunHook(Positions, Tags) && ThreadHooks[i].AnimationEnding(self as sslThreadController)
			Log("Global Hook AnimationEnding("+self+") - "+ThreadHooks[i])
		; else
		; 	Log("HookAnimationEnding() - Skipping["+i+"]: "+ThreadHooks[i])
		endIf
	endWhile
endFunction

function HookAnimationEnd()
	int i = Config.GetThreadHookCount()
	while i > 0
		i -= 1
		if ThreadHooks[i] && ThreadHooks[i].CanRunHook(Positions, Tags) && ThreadHooks[i].AnimationEnd(self as sslThreadController)
			Log("Global Hook AnimationEnd("+self+") - "+ThreadHooks[i])
		; else
		; 	Log("HookAnimationEnd() - Skipping["+i+"]: "+ThreadHooks[i])
		endIf
	endWhile
endFunction


; ------------------------------------------------------- ;
; --- Alias Events - SYSTEM USE ONLY                  --- ;
; ------------------------------------------------------- ;

string[] EventTypes
float[] AliasTimer
int[] AliasDone
float SyncTimer
int SyncDone

int property kPrepareActor = 0 autoreadonly hidden
int property kSyncActor    = 1 autoreadonly hidden
int property kResetActor   = 2 autoreadonly hidden
int property kRefreshActor = 3 autoreadonly hidden
int property kStartup      = 4 autoreadonly hidden

string function Key(string Callback)
	return "SSL_"+thread_id+"_"+Callback
endFunction

function QuickEvent(string Callback)
	ModEvent.Send(ModEvent.Create(Key(Callback)))
endfunction

; The WaitTime should be at least the double of the time that usualy taked on reach the SyncEventDone for 5 actors
; Less than that will cause Sync issues when some heavy mod be executed at the same time.
function SyncEvent(int id, float WaitTime)
	if AliasTimer[id] <= 0 || AliasTimer[id] < Utility.GetCurrentRealTime()
		AliasDone[id]  = 0
		AliasTimer[id] = Utility.GetCurrentRealTime() + WaitTime
		RegisterForSingleUpdate(WaitTime)
 		ModEvent.Send(ModEvent.Create(Key(EventTypes[id])))
	else
		Log(EventTypes[id]+" sync event attempting to start during previous wait sync")
		RegisterForSingleUpdate(WaitTime * 0.25)
	endIf
endFunction

bool SyncLock
function SyncEventDone(int id)
	while SyncLock
		Log("SyncLock("+EventTypes[id]+")")
		Utility.WaitMenuMode(0.1)
	endWhile
	SyncLock = true
	float TimeNow = Utility.GetCurrentRealTime()
	if AliasTimer[id] > 0.0 && AliasDone[id] < ActorCount ; || AliasTimer[id] < TimeNow
		AliasDone[id] = AliasDone[id] + 1
		if AliasDone[id] >= ActorCount
			UnregisterforUpdate()
			if DebugMode
				Log("Lag Timer: " + (AliasTimer[id] - TimeNow), "SyncDone("+EventTypes[id]+")")
			endIf
			AliasDone[id]  = 0
			AliasTimer[id] = 0.0
			if id >= kSyncActor && id <= kRefreshActor
				RemoveFade()
			endIf
		;	while id == kPrepareActor && GetState() != "Prepare" 
		;		Log("SyncEventDone("+id+") is Waiting for the 'Prepare' State to continue")
		;		Utility.WaitMenuMode(2.0)
		;	endWhile
			ModEvent.Send(ModEvent.Create(Key(EventTypes[id]+"Done")))
		endIf
	else
		Log("WARNING: SyncEventDone("+EventTypes[id]+") OUT OF TURN ON STATE '"+GetState()+"'")
		if DebugMode
			Log("Lag Timer: " + (AliasTimer[id] - TimeNow), "SyncDone("+EventTypes[id]+")")
		endIf
		if id >= kSyncActor && id <= kRefreshActor
			RemoveFade()
		endIf
	endIf
	SyncLock = false
endFunction

function SendTrackedEvent(Actor ActorRef, string Hook = "")
	; Append hook type, global if empty
	if Hook != ""
		Hook = "_"+Hook
	endIf
	; Send generic player callback event
	if ActorRef == PlayerRef
		SetupActorEvent(PlayerRef, "PlayerTrack"+Hook)
	endIf
	; Send actor callback events
	int i = StorageUtil.StringListCount(ActorRef, "SexLabEvents")
	while i
		i -= 1
		SetupActorEvent(ActorRef, StorageUtil.StringListGet(ActorRef, "SexLabEvents", i)+Hook)
	endWhile
	; Send faction callback events
	i = StorageUtil.FormListCount(Config, "TrackedFactions")
	while i
		i -= 1
		Faction FactionRef = StorageUtil.FormListGet(Config, "TrackedFactions", i) as Faction
		if FactionRef && ActorRef.IsInFaction(FactionRef)
			int n = StorageUtil.StringListCount(FactionRef, "SexLabEvents")
			while n
				n -= 1
				SetupActorEvent(ActorRef, StorageUtil.StringListGet(FactionRef, "SexLabEvents", n)+Hook)
			endwhile
		endIf
	endWhile
endFunction

function SetupActorEvent(Actor ActorRef, string Callback)
	int eid = ModEvent.Create(Callback)
	ModEvent.PushForm(eid, ActorRef)
	ModEvent.PushInt(eid, thread_id)
	ModEvent.Send(eid)
endFunction

; ------------------------------------------------------- ;
; --- Thread Setup - SYSTEM USE ONLY                  --- ;
; ------------------------------------------------------- ;

function Log(string msg, string src = "")
	msg = "Thread["+thread_id+"] "+src+" - "+msg
	Debug.Trace("SEXLAB - " + msg)
	if DebugMode
		SexLabUtil.PrintConsole(msg)
		Debug.TraceUser("SexLabDebug", msg)
	endIf
endFunction

function Fatal(string msg, string src = "", bool halt = true)
	msg = "FATAL - Thread["+thread_id+"] "+src+" - "+msg
	Debug.TraceStack("SEXLAB - " + msg)
	if DebugMode
		SexLabUtil.PrintConsole(msg)
		Debug.TraceUser("SexLabDebug", msg)
	endIf
	if halt
		Initialize()
	endIf
endFunction

function UpdateAdjustKey()
	if !Config.RaceAdjustments && Config.ScaleActors
		AdjustKey = "Global"
	else
		int i
		string NewKey
		while i < ActorCount
			NewKey += PositionAlias(i).GetActorKey()
			i += 1
			if i < ActorCount
				NewKey += "."
			endIf
		endWhile
		AdjustKey = NewKey
	endIf
	ActorAlias[0].SetAdjustKey(AdjustKey)
	ActorAlias[1].SetAdjustKey(AdjustKey)
	ActorAlias[2].SetAdjustKey(AdjustKey)
	ActorAlias[3].SetAdjustKey(AdjustKey)
	ActorAlias[4].SetAdjustKey(AdjustKey)
	
	UpdateOpenMouthScales()
endFunction

function RemoveFade()
	if HasPlayer
		Config.RemoveFade()
	endIf
endFunction

function ApplyFade()
	if HasPlayer
		Config.ApplyFade()
	endIf
endFunction

sslActorAlias function PickAlias(Actor ActorRef)
	int i
	while i < 5
		if ActorAlias[i].ForceRefIfEmpty(ActorRef)
			return ActorAlias[i]
		endIf
		i += 1
	endWhile
	return none
endFunction

function ResolveTimers()
	if !UseCustomTimers
		if LeadIn
			ConfigTimers = Config.StageTimerLeadIn
		elseIf IsAggressive
			ConfigTimers = Config.StageTimerAggr
		else
			ConfigTimers = Config.StageTimer
		endIf
	endIf
endFunction

function SetTID(int id)
	thread_id = id
	PlayerRef = Game.GetPlayer()
	DebugMode = Config.DebugMode

	Log(self, "Setup")
	; Reset function Libraries - SexLabQuestFramework
	if !Config || !ThreadLib || !ActorLib
		Form SexLabQuestFramework = Game.GetFormFromFile(0xD62, "SexLab.esm")
		if SexLabQuestFramework
			Config    = SexLabQuestFramework as sslSystemConfig
			ThreadLib = SexLabQuestFramework as sslThreadLibrary
			ActorLib  = SexLabQuestFramework as sslActorLibrary
		endIf
	endIf
	; Reset secondary object registry - SexLabQuestRegistry
	if !CreatureSlots
		Form SexLabQuestRegistry = Game.GetFormFromFile(0x664FB, "SexLab.esm")
		if SexLabQuestRegistry
			CreatureSlots = SexLabQuestRegistry as sslCreatureAnimationSlots
		endIf
	endIf
	; Reset animation registry - SexLabQuestAnimations
	if !AnimSlots
		Form SexLabQuestAnimations = Game.GetFormFromFile(0x639DF, "SexLab.esm")
		if SexLabQuestAnimations
			AnimSlots = SexLabQuestAnimations as sslAnimationSlots
		endIf
	endIf

	
	; Init thread info
	EventTypes = new string[5]
	EventTypes[0] = "Prepare"
	EventTypes[1] = "Sync"
	EventTypes[2] = "Reset"
	EventTypes[3] = "Refresh"
	EventTypes[4] = "Startup"

	CenterAlias = GetNthAlias(5) as ReferenceAlias

	ActorAlias = new sslActorAlias[5]
	ActorAlias[0] = GetNthAlias(0) as sslActorAlias
	ActorAlias[1] = GetNthAlias(1) as sslActorAlias
	ActorAlias[2] = GetNthAlias(2) as sslActorAlias
	ActorAlias[3] = GetNthAlias(3) as sslActorAlias
	ActorAlias[4] = GetNthAlias(4) as sslActorAlias

	ActorAlias[0].Setup()
	ActorAlias[1].Setup()
	ActorAlias[2].Setup()
	ActorAlias[3].Setup()
	ActorAlias[4].Setup()
	
	InitShares()
	Initialize()
endFunction

function InitShares()
	DebugMode      = Config.DebugMode
	AnimEvents     = new string[5]
	IsType         = new bool[9]
	HiddenStatus   = 0
	BedStatus      = new int[2]
	FurnitureStatus= new int[2]
	AliasDone      = new int[6]
	RealTime       = new float[1]
	AliasTimer     = new float[6]
	SkillXP        = new float[6]
	SkillBonus     = new float[6]
	CenterLocation = new float[6]
	if EventTypes.Length != 5 || EventTypes.Find("") != -1
		EventTypes = new string[5]
		EventTypes[0] = "Prepare"
		EventTypes[1] = "Sync"
		EventTypes[2] = "Reset"
		EventTypes[3] = "Refresh"
		EventTypes[4] = "Startup"
	endIf
	if !CenterAlias
		CenterAlias = GetAliasByName("CenterAlias") as ReferenceAlias
	endIf
endFunction

bool Initialized
function Initialize()
	UnregisterForUpdate()
	; Clear aliases
	ActorAlias[0].ClearAlias()
	ActorAlias[1].ClearAlias()
	ActorAlias[2].ClearAlias()
	ActorAlias[3].ClearAlias()
	ActorAlias[4].ClearAlias()
	if CenterAlias
	;	SetObjectiveDisplayed(0, False)
		CenterAlias.Clear()
	endIf
	; Forms
	Animation      = none
	CenterRef      = none
	SoundFX        = none
	BedRef         = none
	FurnitureRef   = none
	StartingAnimation = none
	; Boolean
	AutoAdvance    = true
	SortActors     = true
	HasPlayer      = false
	LeadIn         = false
	NoLeadIn       = false
	FastEnd        = false
	UseCustomTimers= false
	DisableOrgasms = false
	; Floats
	SyncTimer      = 0.0
	StartedAt      = 0.0
	; Integers
	SyncDone       = 0
	Stage          = 1
	ActorCount     = 0
	; StartAID       = -1

	if !Vampire
		Vampire = Game.GetFormFromFile(0xA82BB, "Skyrim.esm") as Keyword
	endIf
	If !ActorTypeGhost
		ActorTypeGhost = Game.GetFormFromFile(0xD205E, "Skyrim.esm") as Keyword
	endIf
	If !ActorTypeDaedra
		ActorTypeDaedra = Game.GetFormFromFile(0x13797, "Skyrim.esm") as Keyword
	endIf
	if !CollegeofWinterholdFaction
		CollegeofWinterholdFaction = Game.GetFormFromFile(0x1F259, "Skyrim.esm") as Faction
	endIf
	if !JobApothecaryFaction
		JobApothecaryFaction = Game.GetFormFromFile(0x5091C, "Skyrim.esm") as Faction
	endIf
	if !JobSpellFaction
		JobSpellFaction = Game.GetFormFromFile(0x50921, "Skyrim.esm") as Faction
	endIf
	if !JobTrainerAlchemyFaction
		JobTrainerAlchemyFaction = Game.GetFormFromFile(0xE3A56, "Skyrim.esm") as Faction
	endIf
	if !NecromancerFaction
		NecromancerFaction = Game.GetFormFromFile(0x34B74, "Skyrim.esm") as Faction
	endIf
	if !WarlockFaction
		WarlockFaction = Game.GetFormFromFile(0x26724, "Skyrim.esm") as Faction
	endIf

	; Storage Data
	Futas             = new int[4]
	Genders           = new int[4]
	Victims           = PapyrusUtil.ActorArray(0)
	Positions         = PapyrusUtil.ActorArray(0)
	CustomAnimations  = sslUtility.AnimationArray(0)
	PrimaryAnimations = sslUtility.AnimationArray(0)
	LeadAnimations    = sslUtility.AnimationArray(0)
	Hooks             = Utility.CreateStringArray(0)
	Tags              = Utility.CreateStringArray(0)
	CustomTimers      = Utility.CreateFloatArray(0)
	; Enter thread selection pool
	GoToState("Unlocked")
	Initialized = true
endFunction

; ------------------------------------------------------- ;
; --- State Restricted                                --- ;
; ------------------------------------------------------- ;

state Unlocked
	sslThreadModel function Make()
		InitShares()
		if !Initialized
			Initialize()
		endIf
		Initialized = false
		GoToState("Making")
		RegisterForSingleUpdate(60.0)
		return self
	endFunction
endState

; Making
sslThreadModel function Make()
	Log("Cannot enter make on a locked thread", "Make() ERROR")
	return none
endFunction
sslThreadController function StartThread()
	Log("Cannot start thread while not in a Making state", "StartThread() ERROR")
	return none
endFunction
int function AddActor(Actor ActorRef, bool IsVictim = false, sslBaseVoice Voice = none, bool ForceSilent = false)
	Log("Cannot add an actor to a locked thread", "AddActor() ERROR")
	return -1
endFunction
bool function AddActors(Actor[] ActorList, Actor VictimActor = none)
	Log("Cannot add a list of actors to a locked thread", "AddActors() ERROR")
	return false
endFunction
; State varied
function FireAction()
endFunction
function EndAction()
endFunction
function SyncDone()
endFunction
function RefreshDone()
endFunction
function PrepareDone()
endFunction
function ResetDone()
endFunction
function StripDone()
endFunction
function OrgasmDone()
endFunction
function StartupDone()
endFunction
function SetAnimation(int aid = -1)
endFunction
; Animating
event OnKeyDown(int keyCode)
endEvent
function EnableHotkeys(bool forced = false)
endFunction
function RealignActors()
endFunction
function MoveScene()
endFunction

; ------------------------------------------------------- ;
; --- Legacy; do not use these functions anymore!     --- ;
; ------------------------------------------------------- ;

bool function HasPlayer()
	return HasPlayer
endFunction
Actor function GetPlayer()
	return PlayerRef
endFunction
Actor function GetVictim()
	return VictimRef
endFunction
float function GetTime()
	return StartedAt
endfunction
function SetBedding(int flag = 0)
	SetBedFlag(flag)
endFunction