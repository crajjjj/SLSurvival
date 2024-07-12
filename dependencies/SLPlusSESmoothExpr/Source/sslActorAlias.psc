scriptname sslActorAlias extends ReferenceAlias

; Framework access
sslSystemConfig Config
sslActorLibrary ActorLib
sslActorStats Stats
Actor PlayerRef

; Actor Info
Actor property ActorRef auto hidden
ActorBase BaseRef
string ActorName
string RaceEditorID
String ActorRaceKey
int BaseSex
int Gender
bool isRealFemale
bool IsMale
bool IsFemale
bool IsCreature
bool IsFuta
bool IsVictim
bool IsAggressor
bool IsPlayer
bool IsTracked
bool IsSkilled
bool UseFaceItems
Faction AnimatingFaction

; Current Thread state
sslThreadController Thread
int Position
bool LeadIn

float StartWait
string StartAnimEvent
string EndAnimEvent
string ActorKey
bool NoOrgasm

; Voice
sslBaseVoice Voice
VoiceType ActorVoice
float BaseDelay
float VoiceDelay
float ExpressionDelay
bool IsForcedSilent
bool UseLipSync
bool IsLipFixed

; Expression
sslBaseExpression Expression
sslBaseExpression[] Expressions
float OpenMouthScale
int ExpressionType

; Positioning
bool Restricted
ObjectReference FurnitureRef
ObjectReference MarkerRef
float[] Offsets
float[] Center
float[] Loc

; Storage
int[] Flags
Form[] Equipment
bool[] StripOverride
float[] Skills
float[] OwnSkills

bool UseScale
float StartedAt
float ActorScale
float AnimScale
float NioScale
float LastOrgasm
int BestRelation
int BaseEnjoyment
int QuitEnjoyment
int FullEnjoyment
int Orgasms
int NthTranslation

Form Strapon
Form HadStrapon

Sound OrgasmFX

Spell HDTHeelSpell
Form HadBoots

;SLU+ ---BEGIN-----------------------------------
Keyword zad_Lockable
Keyword zad_DeviousYoke
Keyword zad_DeviousYokeBB
Keyword zad_DeviousArmbinder
Keyword zad_DeviousArmbinderElbow
Keyword zad_DeviousHeavyBondage
Keyword zad_DeviousStraitJacket
Keyword zad_DeviousBelt
Keyword zad_DeviousSuit
Keyword zad_DeviousPlugAnal
Keyword zad_DeviousPlugVaginal
Keyword zad_PermitAnal
Keyword zad_PermitVaginal
Keyword zad_DeviousGag
Keyword zad_DeviousGagPanel
Keyword zad_PermitOral
Keyword zad_DeviousBra
Keyword zad_DeviousPetSuit

Keyword zbfWornDevice
Keyword zbfAnimHandsYoke
Keyword zbfAnimHandsArmbinder
Keyword zbfAnimHandsElbows
Keyword zbfAnimHandsWrists
Keyword zbfWornBelt
Keyword zbfWornPreventAnal
Keyword zbfWornPreventVaginal
Keyword zbfWornHood
Keyword zbfWornGag
Keyword zbfWornPermitOral
Keyword zbfWornPreventOral
Keyword zbfWornBra
Keyword zbfWornPreventBreast
;SLU+ ---END------------------------------------

; Animation Position/Stage flags
bool property ForceOpenMouth auto hidden
bool property OpenMouth hidden
	bool function get()
		return Flags[1] == 1 || ForceOpenMouth == true
	endFunction
endProperty
bool property IsSilent hidden
	bool function get()
		return !Voice || IsForcedSilent || Flags[0] == 1 || Flags[1] == 1
	endFunction
endProperty
bool property UseStrapon hidden
	bool function get()
		return Flags[2] == 1 && Flags[4] == 0
	endFunction
endProperty
int property Schlong hidden
	int function get()
		return Flags[3]
	endFunction
endProperty
bool property MalePosition hidden
	bool function get()
		return Flags[4] == 0
	endFunction
endProperty

; ------------------------------------------------------- ;
; --- Load/Clear Alias For Use                        --- ;
; ------------------------------------------------------- ;

bool function SetActor(Actor ProspectRef)
	if !ProspectRef || ProspectRef != GetReference()
		Log("ERROR: SetActor("+ProspectRef+") on State:'Ready' is not allowed")
		return false ; Failed to set prospective actor into alias
	endIf
	; Init actor alias information
	ActorRef   = ProspectRef
	BaseRef    = ActorRef.GetLeveledActorBase()
	ActorName  = BaseRef.GetName()
	; ActorVoice = BaseRef.GetVoiceType()
	BaseSex    = BaseRef.GetSex()
	isRealFemale = BaseSex == 1
	Gender     = ActorLib.GetGender(ActorRef)
	IsMale     = Gender == 0
	IsFemale   = Gender == 1
	IsCreature = Gender >= 2
	IsFuta     = ActorLib.GetTrans(ActorRef) != -1
	IsTracked  = Config.ThreadLib.IsActorTracked(ActorRef)
	IsPlayer   = ActorRef == PlayerRef
	RaceEditorID = MiscUtil.GetRaceEditorID(BaseRef.GetRace())
	UseFaceItems = Config.UseFaceItems
	; Player and creature specific
	if IsPlayer
		Thread.HasPlayer = true
	endIf
	if IsCreature
		Thread.CreatureRef = BaseRef.GetRace()
		if sslCreatureAnimationSlots.HasRaceKey("Canines") && sslCreatureAnimationSlots.HasRaceID("Canines", RaceEditorID)
			ActorRaceKey = "Canines"
		else
			ActorRaceKey = sslCreatureAnimationSlots.GetRaceKeyByID(RaceEditorID)
		endIf
	elseIf !IsPlayer
		Stats.SeedActor(ActorRef)
	endIf
	; Actor's Adjustment Key
	ActorKey = RaceEditorID
	if !Config.RaceAdjustments
		if IsCreature
			if ActorRaceKey
				ActorKey = ActorRaceKey
			endIf
		else
			ActorKey = "Humanoid"
		endIf
	endIf
	if IsCreature
		ActorKey += "C"
	endIf
	if !IsCreature || Config.UseCreatureGender
		If isRealFemale
			ActorKey += "F"
		else
			ActorKey += "M"
		endIf
	endIf
	NioScale = 1.0
	float TempScale
	String Node = "NPC"
	if NetImmerse.HasNode(ActorRef, Node, False)
		
		; Remove SexLab "NPC" node if present by error
		if Config.HasNiOverride 
			Log(self, Node+":TransformKeys "+NiOverride.GetNodeTransformKeys(ActorRef, False, isRealFemale, Node))
			If NiOverride.RemoveNodeTransformScale(ActorRef, False, isRealFemale, "NPC", "SexLab.esm")
				NiOverride.UpdateNodeTransform(ActorRef, False, isRealFemale, "NPC")
			endIf
		endIf

		TempScale = NetImmerse.GetNodeScale(ActorRef, Node, False)
		if TempScale > 0
		;	Log(self, "NPC:NodeScale("+TempScale+")")
			NioScale = NioScale * TempScale
		endIf
	;	float[] Rotation = new float[3]
	;	if NetImmerse.GetNodeLocalRotationEuler(ActorRef, Node, Rotation, False)
	;		Log(Node +" Rotation:"+Rotation+" Rotate:"+NetImmerse.SetNodeLocalRotationEuler(ActorRef, Node, Utility.CreateFloatArray(3, 0.0), False))
	;	endIf
	endIf
	Node = "NPC Root [Root]"
	if NetImmerse.HasNode(ActorRef, Node, False)
		TempScale = NetImmerse.GetNodeScale(ActorRef, Node, False)
		if TempScale > 0
		;	Log(self, "NPC Root [Root]:NodeScale("+TempScale+")")
			NioScale = NioScale * TempScale
		endIf
	;	float[] Rotation = new float[3]
	;	if NetImmerse.GetNodeLocalRotationEuler(ActorRef, Node, Rotation, False)
	;		Log(Node +" Rotation:"+Rotation+" Rotate:"+NetImmerse.SetNodeLocalRotationEuler(ActorRef, Node, Utility.CreateFloatArray(3, 0.0), False))
	;	endIf
	endIf
	
;/ 	if Config.HasNiOverride 
		String[] NodesToRemove = new String[4]
		NodesToRemove[0] = "NPC L Calf [LClf]"
		NodesToRemove[1] = "NPC R Calf [RClf]"
		NodesToRemove[2] = "NPC L Thigh [LThg]"
		NodesToRemove[3] = "NPC R Thigh [RThg]"
	;	NodesToRemove[4] = "CME L Thigh [LThg]"
	;	NodesToRemove[5] = "CME R Thigh [RThg]"
	;	NodesToRemove[6] = "CME Body [Body]"
		float[] Values = new float[3]
		int i = 0
		While i < NodesToRemove.Length
			Log(self, NodesToRemove[i]+":NodeScale "+NetImmerse.GetNodeScale(ActorRef, NodesToRemove[i], False))
			NetImmerse.GetNodeLocalPosition(ActorRef, NodesToRemove[i], Values, False)
			Log(self, NodesToRemove[i]+":NodeLocalPosition "+Values)
			NetImmerse.GetNodeLocalRotationEuler(ActorRef, NodesToRemove[i], Values, False)
			Log(self, NodesToRemove[i]+":NodeLocalRotation "+Values)
			i += 1
		EndWhile
		String[] TransformedNodes = NiOverride.GetNodeTransformNames(ActorRef, False, isRealFemale)
		; Check for Knee Transformations
		Log(self,"TransformedNodes:"+TransformedNodes)
		int i = 0
		bool UpdateNodeTransform = false
		While i < TransformedNodes.Length
			Log(self, TransformedNodes[i]+":TransformKeys "+NiOverride.GetNodeTransformKeys(ActorRef, False, isRealFemale, TransformedNodes[i]))
			i += 1
		;	UpdateNodeTransform = NiOverride.RemoveNodeTransformPosition(ActorRef, False, isRealFemale, TransformedNodes[i], TransformKeys[k]) || UpdateNodeTransform
		;	UpdateNodeTransform = NiOverride.RemoveNodeTransformScale(ActorRef, False, isRealFemale, TransformedNodes[i], TransformKeys[k]) || UpdateNodeTransform
		;	UpdateNodeTransform = NiOverride.RemoveNodeTransformRotation(ActorRef, False, isRealFemale, TransformedNodes[i], TransformKeys[k]) || UpdateNodeTransform
			If UpdateNodeTransform
				NiOverride.UpdateNodeTransform(ActorRef, False, isRealFemale, TransformedNodes[i])
				UpdateNodeTransform = False
			EndIf
		EndWhile
	endIf
 /;
	if !Config.ScaleActors
		float ActorScalePlus
		ActorScalePlus = ((GetScale() * 25) + 0.5) as int
	;	Log(self, "ActorScalePlus("+ActorScalePlus+")")
		if ActorScalePlus != 25.0
			ActorKey += ActorScalePlus as int
		endIf
	endIf
	if !IsCreature
		; Detect Actors Tags
		if ActorRef.IsDead() || ActorRef.IsUnconscious() || ActorRef.GetActorValue("Health") <= 1.0
			AddRequiredTag("Necro")
			SetRestricted(true)
		endIf
		if Config.ManageZadFilter
			if ActorRef.WornHasKeyword(zad_Lockable)
				if ActorRef.WornHasKeyword(zad_DeviousYoke)
					AddRequiredTag("Yoke")
					SetRestricted(true)
				elseIf ActorRef.WornHasKeyword(zad_DeviousYokeBB)
					AddRequiredTag("BBYoke")
					SetRestricted(true)
				elseIf ActorRef.WornHasKeyword(zad_DeviousArmbinder) || ActorRef.WornHasKeyword(zad_DeviousArmbinderElbow)
					AddRequiredTag("Armbinder")
					SetRestricted(true)
				elseIf ActorRef.WornHasKeyword(zad_DeviousPetSuit)
					AddRequiredTag("PetSuit")
					SetRestricted(true)
				elseIf ActorRef.WornHasKeyword(zad_DeviousHeavyBondage) || ActorRef.WornHasKeyword(zad_DeviousStraitJacket)
					AddRequiredTag("Bound")
					SetRestricted(true)
				endIf
				if !ActorRef.WornHasKeyword(zad_PermitAnal) && (ActorRef.WornHasKeyword(zad_DeviousBelt) || ActorRef.WornHasKeyword(zad_DeviousSuit) || ActorRef.WornHasKeyword(zad_DeviousPlugAnal))
					AddForbiddenTag("Anal")
				endIf
				if !ActorRef.WornHasKeyword(zad_PermitVaginal) && (ActorRef.WornHasKeyword(zad_DeviousBelt) || ActorRef.WornHasKeyword(zad_DeviousSuit) || ActorRef.WornHasKeyword(zad_DeviousPlugVaginal))
					AddForbiddenTag("Vaginal")
				endIf
				if ActorRef.WornHasKeyword(zad_DeviousGag)
					ForceOpenMouth = true
					if !ActorRef.WornHasKeyword(zad_DeviousGagPanel) && !ActorRef.WornHasKeyword(zad_PermitOral)
						AddForbiddenTag("Oral")
						AddForbiddenTag("Blowjob")
					endIf
				endIf
				if ActorRef.WornHasKeyword(zad_DeviousBra) || ActorRef.WornHasKeyword(zad_DeviousSuit)
					AddForbiddenTag("Breast")
				endIf
			endIf
		endIf
		if Config.ManageZazFilter
			if ActorRef.WornHasKeyword(zbfWornDevice)
				if ActorRef.WornHasKeyword(zbfAnimHandsYoke)
					AddRequiredTag("Yoke")
					SetRestricted(true)
				elseIf ActorRef.WornHasKeyword(zbfAnimHandsArmbinder) || ActorRef.WornHasKeyword(zbfAnimHandsElbows)
					AddRequiredTag("Armbinder")
					SetRestricted(true)
				elseIf ActorRef.WornHasKeyword(zbfAnimHandsWrists)
					AddRequiredTag("Bound")
					SetRestricted(true)
				endIf
				if ActorRef.WornHasKeyword(zbfWornBelt) || ActorRef.WornHasKeyword(zbfWornPreventAnal)
					AddForbiddenTag("Anal")
				endIf
				if ActorRef.WornHasKeyword(zbfWornBelt) || ActorRef.WornHasKeyword(zbfWornPreventVaginal)
					AddForbiddenTag("Vaginal")
				endIf
				if ActorRef.WornHasKeyword(zbfWornGag)
					ForceOpenMouth = true
				endIf
				if ActorRef.WornHasKeyword(zbfWornPreventOral) || (!ActorRef.WornHasKeyword(zbfWornPermitOral) && (ActorRef.WornHasKeyword(zbfWornHood) || ActorRef.WornHasKeyword(zbfWornGag)))
					AddForbiddenTag("Oral")
					AddForbiddenTag("Blowjob")
				endIf
				if ActorRef.WornHasKeyword(zbfWornBra) || ActorRef.WornHasKeyword(zbfWornPreventBreast)
					AddForbiddenTag("Breast")
				endIf
			endIf
		endIf
	endIf
	; Set base voice/loop delay
	if IsCreature
		BaseDelay  = 3.0
	elseIf IsFemale
		BaseDelay  = Config.FemaleVoiceDelay
	else
		BaseDelay  = Config.MaleVoiceDelay
	endIf
	VoiceDelay = BaseDelay
	ExpressionDelay = Config.ExpressionDelay * BaseDelay
	If OpenMouthScale < 0.1
		OpenMouthScale = 1.0
	endIf
	; Init some needed arrays
	Flags   = new int[5]
	Offsets = new float[4]
	Loc     = new float[6]
	; Ready
	RegisterEvents()
	TrackedEvent("Added")
	GoToState("Ready")
	Log(self, "SetActor("+ActorRef+")")
	return true
endFunction

float function GetScale()
	float output = 1.0
	if Config.RaceAdjustments && BaseRef ; TODO: Make some native function to get the real diference bettewen the current Actor Scale and the Race Height
		output = BaseRef.GetHeight() ; Incompatible with actor that are being scaled iside the played game but there is none way to know the real Race Height of the actor to know the real diference with its current actor scale
		If JSONUtil.IsGood("../SexLab/RaceGenderScales.json") ;&& ActorRaceScale != 1.0 && ActorRaceScale > 0.0
			float ActorRaceScale = 1.0
			If isRealFemale ; Try to deal with the lack of native functions geting this from a JSON file
				ActorRaceScale = JSONUtil.GetFloatValue("../SexLab/RaceGenderScales.json", RaceEditorID + ".FemaleHeigth", 1.0)
			Else
				ActorRaceScale = JSONUtil.GetFloatValue("../SexLab/RaceGenderScales.json", RaceEditorID + ".MaleHeigth", 1.0)
			endIf
			If ActorRaceScale > 0.0
				output = ActorRef.GetScale() / ActorRaceScale
			endIf
			Log(self, "GetScale(): "+output+", BaseHeight:"+BaseRef.GetHeight()+", ActorScale:"+ActorRef.GetScale()+" , ActorRaceScale:"+ActorRaceScale)
		endIf
	elseIf ActorRef
		output = ActorRef.GetScale()
	endIf
	if NioScale > 0.0 ;&& NioScale != 1.0
		output = output * NioScale
	endIf
;	Log(self, "GetScale()")
	return output
EndFunction

float function GetBodyScale()
	float output = 1.0
	If ActorRef
		output = ActorRef.GetScale()
	endIf
	if NioScale > 0.0 ;&& NioScale != 1.0
		output = output * NioScale
	endIf
;	Log(self, "GetScale()")
	return output
EndFunction

function ClearAlias()
	; Maybe got here prematurely, give it 10 seconds before forcing the clear
	if GetState() == "Resetting"
		float Failsafe = Utility.GetCurrentRealTime() + 10.0
		while GetState() == "Resetting" && Utility.GetCurrentRealTime() < Failsafe
			Utility.WaitMenuMode(0.2)
		endWhile
	endIf
	; Make sure actor is reset
	if GetReference() && GetReference() as Actor != none
		; Init variables needed for reset
		ActorRef   = GetReference() as Actor
		BaseRef    = ActorRef.GetLeveledActorBase()
		ActorName  = BaseRef.GetName()
		BaseSex    = BaseRef.GetSex()
		isRealFemale = BaseSex == 1
		Gender     = ActorLib.GetGender(ActorRef)
		IsMale     = Gender == 0
		IsFemale   = Gender == 1
		IsCreature = Gender >= 2
		IsFuta     = ActorLib.GetTrans(ActorRef) != -1
		if !RaceEditorID || RaceEditorID == ""
			RaceEditorID = MiscUtil.GetRaceEditorID(BaseRef.GetRace())
		endIf
		if IsCreature
			ActorRaceKey = sslCreatureAnimationSlots.GetRaceKeyByID(RaceEditorID)
		endIf
		IsPlayer   = ActorRef == PlayerRef
		Log("Actor present during alias clear! This is usually harmless as the alias and actor will correct itself, but is usually a sign that a thread did not close cleanly.", "ClearAlias("+ActorRef+" / "+self+")")
		; Reset actor back to default
		ClearEvents()
		ClearEffects()
		StopAnimating(true)
		UnlockActor()
		RestoreActorDefaults()
		Unstrip()
		Config.ClearActorFaceItems(ActorRef)
	endIf
	Initialize()
	GoToState("")
endFunction

; Thread/alias shares
bool DebugMode
bool SeparateOrgasms
int[] FurnitureStatus
float[] RealTime
float[] SkillBonus
string AdjustKey
bool[] IsType

int Stage
int StageCount
string[] AnimEvents
sslBaseAnimation Animation

function LoadShares()
	DebugMode  = Config.DebugMode
	UseLipSync = Config.UseLipSync && !IsCreature
	UseScale   = !Config.DisableScale

	Center     = Thread.CenterLocation
	Position   = Thread.Positions.Find(ActorRef)
	FurnitureStatus = Thread.FurnitureStatus
	RealTime   = Thread.RealTime
	SkillBonus = Thread.SkillBonus
	AdjustKey  = Thread.AdjustKey
	IsType     = Thread.IsType
	LeadIn     = Thread.LeadIn
	AnimEvents = Thread.AnimEvents

	SeparateOrgasms = Config.SeparateOrgasms
	; AnimatingFaction = Config.AnimatingFaction ; TEMP
endFunction

; ------------------------------------------------------- ;
; --- Actor Prepartion                                --- ;
; ------------------------------------------------------- ;


state Ready
	event OnUpdate()
	;	if StartWait < 0.1
	;		StartWait = 0.1
	;	endIf
	;	string CurrentState = Thread.GetState()
	;	if CurrentState == "Ready"
	;		Log("WARNING: OnUpdate Event ON State:'Ready' FOR State:'"+CurrentState+"'")
	;		GoToState("Prepare")
	;		RegisterForSingleUpdate(StartWait)
	;	else
	;		Log("ERROR: OnUpdate Event ON State:'Ready' FOR State:'"+CurrentState+"'")
	;		RegisterForSingleUpdate(StartWait)
	;	endIf
		Log("ERROR: OnUpdate Event ON State:'Ready' FOR State:'"+Thread.GetState()+"'")
	endEvent

	event OnTranslationComplete()
		Log(GetState(),"OnTranslationComplete()")
		if MarkerRef && MarkerRef.IsEnabled() 
			if (Math.Abs(ActorRef.GetAngleZ() - Loc[5]) > 2.0) ; If the TranslateTo can't rotate it
				ActorRef.SetVehicle(none)
				MarkerRef.SetPosition(Loc[0], Loc[1], Loc[2])
				MarkerRef.SetAngle(Loc[3], Loc[4], Loc[5])
				ActorRef.SetPosition(Loc[0], Loc[1], Loc[2])
				ActorRef.SetAngle(Loc[3], Loc[4], Loc[5])
				AttachMarker()
				ActorRef.TranslateTo(Loc[0], Loc[1], Loc[2], Loc[3], Loc[4], Loc[5], 50000, 0.0)
				Log(ActorName +"-Loc- Angle:[X:"+Loc[3]+"Y:"+Loc[4]+"Z:"+Loc[5]+"] Position:[X:"+Loc[0]+"Y:"+Loc[1]+"Z:"+Loc[2]+"]", "OnTranslationComplete()")
				Log(ActorName +"-MarkerRef- Angle:[X:"+MarkerRef.GetAngleX()+"Y:"+MarkerRef.GetAngleY()+"Z:"+MarkerRef.GetAngleZ()+"] Position:[X:"+MarkerRef.GetPositionX()+"Y:"+MarkerRef.GetPositionY()+"Z:"+MarkerRef.GetPositionZ()+"]", "OnTranslationComplete()")
				Log(ActorName +"-ActorRef- Angle:[X:"+ActorRef.GetAngleX()+"Y:"+ActorRef.GetAngleY()+"Z:"+ActorRef.GetAngleZ()+"] Position:[X:"+ActorRef.GetPositionX()+"Y:"+ActorRef.GetPositionY()+"Z:"+ActorRef.GetPositionZ()+"]", "OnTranslationComplete()")
			elseIf IsInPosition(ActorRef, MarkerRef, 2.0)
				ActorRef.TranslateTo(Loc[0], Loc[1], Loc[2], Loc[3], Loc[4], Loc[5]+0.01, 500.0, 0.0001)
			endIf
		endIf
	endEvent

	bool function SetActor(Actor ProspectRef)
		Log("ERROR: SetActor("+ActorRef.GetLeveledActorBase().GetName()+") on State:'Ready' is not allowed")
		return false
	endFunction

	function PrepareActor()
		; Remove any unwanted combat effects
		ClearEffects()
		if IsPlayer
			sslThreadController Control = Config.GetThreadControlled()
			if Control && Control != none
				Config.DisableThreadControl(Control)
			endIf
			Game.SetPlayerAIDriven()
		endIf
		ActorRef.SetFactionRank(AnimatingFaction, 1)
		ActorRef.EvaluatePackage()
		; Starting Information
		LoadShares()
		GetPositionInfo()
		IsAggressor = Thread.VictimRef && Thread.Victims.Find(ActorRef) == -1
		string LogInfo
		; Calculate scales
		if UseScale
			Thread.ApplyFade()
			float display = ActorRef.GetScale()
			ActorRef.SetScale(1.0)
			float base = ActorRef.GetScale()
			ActorScale = ( display / base )
			AnimScale  = ActorScale
			if ActorScale > 0.0 && ActorScale != 1.0
				ActorRef.SetScale(ActorScale)
			endIf
			float FixNioScale = 1.0
			if (Thread.ActorCount > 1 || FurnitureStatus[1] >= 4) && Config.ScaleActors
				if Config.HasNiOverride && !IsCreature && NioScale > 0.0 && NioScale != 1.0
					FixNioScale = (FixNioScale / NioScale)
					NiOverride.AddNodeTransformScale(ActorRef, False, isRealFemale, "NPC", "SexLab.esm",FixNioScale)
					NiOverride.UpdateNodeTransform(ActorRef, False, isRealFemale, "NPC")
				endIf
				AnimScale = (1.0 / base)
			endIf
			LogInfo = "Scales["+display+"/"+base+"/"+ActorScale+"/"+AnimScale+"/"+NioScale+"] "
		else
			AnimScale = 1.0
		;	LogInfo = "Scales["+ActorRef.GetScale()+"/DISABLED/DISABLED/DISABLED/DISABLED/"+NioScale+"] "
			LogInfo = "Scales["+GetScale()+"/DISABLED/DISABLED/DISABLED/DISABLED/"+NioScale+"] "
		endIf
		; Stop other movements
		if DoPathToCenter
	;		PathToCenter()
		else
			LockActor()
			
			MoveToStartingPosition()

			; Start Wait Idle
			StartWaitIdle()
		endIf

		; Player specific actions
		if IsPlayer
			FormList FrostExceptions = Config.FrostExceptions
			if FrostExceptions
				FrostExceptions.AddForm(Config.BaseMarker)
			endIf
		endIf

		; Pick a voice if needed
		if !Voice && !IsForcedSilent
			if IsCreature
				SetVoice(Config.VoiceSlots.PickByRaceKey(sslCreatureAnimationSlots.GetRaceKey(BaseRef.GetRace())), IsForcedSilent)
			else
				SetVoice(Config.VoiceSlots.PickVoice(ActorRef), IsForcedSilent)
			endIf
		endIf
		if Voice
			LogInfo += "Voice["+Voice.Name+"] "
		endIf
		; Extras for non creatures
		if !IsCreature
			; Decide on strapon for female, default to worn, otherwise pick random.
			if IsFemale && !IsFuta && Config.UseStrapons
				HadStrapon = Config.WornStrapon(ActorRef)
				Strapon    = HadStrapon
				if !HadStrapon
					Strapon = Config.GetStrapon()
				endIf
				LogInfo += "Strapon["+sslUtility.GetItemName(Strapon)+"] "
			endIf
			; Strip actor
			Thread.RemoveFade()
			int Seid = ModEvent.Create(Thread.Key("StripActor"))
			if Seid
				ModEvent.PushForm(Seid, ActorRef)
				ModEvent.Send(Seid)
				Utility.Wait(1.0)
			else
				Strip()
			endIf
			ResolveStrapon()
			; Debug.SendAnimationEvent(ActorRef, "SOSFastErect")
			; Pick an expression if needed
			if !Expression && Config.UseExpressions
				Expressions = Config.ExpressionSlots.GetByStatus(ActorRef, IsVictim, IsType[0] && !IsVictim)
				if Expressions && Expressions.Length > 0
					If Animation 
						ExpressionType = Animation.GetStageExpressive(Position, Stage)
						If ExpressionType == 0
							ExpressionType = Animation.GetExpressive(Position)
						EndIf
					EndIf
					If ExpressionType != -1
						If ExpressionType == 1 && UseFaceItems ; Force Normal Expression
							sslBaseExpression[] FilteredExpressions = sslUtility.FilterTaggedExpressions(Expressions, PapyrusUtil.StringArray(1, "Ahegao"), False)
							If FilteredExpressions.Length > 0
								Expression = FilteredExpressions[Utility.RandomInt(0, (FilteredExpressions.Length - 1))]
							EndIf
						ElseIf ExpressionType == 2 && UseFaceItems ; Force Ahegao Expression
							sslBaseExpression[] FilteredExpressions = sslUtility.FilterTaggedExpressions(Expressions, PapyrusUtil.StringArray(1, "Ahegao"), True)
							If FilteredExpressions.Length > 0
								Expression = FilteredExpressions[Utility.RandomInt(0, (FilteredExpressions.Length - 1))]
							EndIf
						Else ; All Expression Allowed
							Expression = Expressions[Utility.RandomInt(0, (Expressions.Length - 1))]
						EndIf
						Log("Expression["+Expression.Name+"] BaseVoiceDelay["+BaseDelay+"] ExpressionDelay["+ExpressionDelay+"] LoopExpressionDelay["+LoopExpressionDelay+"] ")
					Else ; Expression Disabled
						Expression = none
						Log("Expression[None] BaseVoiceDelay["+BaseDelay+"] ExpressionDelay["+ExpressionDelay+"] LoopExpressionDelay["+LoopExpressionDelay+"] ")
					EndIf
				endIf
			endIf
			if Expression
				LogInfo += "Expression["+Expression.Name+"] "
			endIf
			if ActorRef.Is3DLoaded() && !(ActorRef.IsDisabled() || ActorRef.IsDead() || ActorRef.GetActorValue("Health") <= 1.0)
				ActorRef.ClearExpressionOverride()
				ActorRef.ResetExpressionOverrides()
				sslBaseExpression.ClearMFG(ActorRef)
			endIf
		endIf
		IsSkilled = !IsCreature || sslActorStats.IsSkilled(ActorRef)
		Log("IsSkilled:"+IsSkilled)
		if IsSkilled
			; Always use players stats for NPCS if present, so players stats mean something more
			Actor SkilledActor = ActorRef
			if !IsPlayer && Thread.HasPlayer
				SkilledActor = PlayerRef
			; If a non-creature couple, base skills off partner
			elseIf Thread.ActorCount > 1 && !Thread.HasCreature
				SkilledActor = Thread.Positions[sslUtility.IndexTravel(Position, Thread.ActorCount)]
			endIf
			; Get sex skills of partner/player
			Skills       = Stats.GetSkillLevels(SkilledActor)
			OwnSkills    = Stats.GetSkillLevels(ActorRef)
			; Try to prevent orgasms on fist stage resting enjoyment
			float FirsStageTime
			if LeadIn
				FirsStageTime = Config.StageTimerLeadIn[0]
			elseIf IsType[0]
				FirsStageTime = Config.StageTimerAggr[0]
			else
				FirsStageTime = Config.StageTimer[0]
			endIf
			BaseEnjoyment -= Math.Abs(CalcEnjoyment(SkillBonus, Skills, LeadIn, IsFemale, FirsStageTime, 1, StageCount)) as int
			if BaseEnjoyment < -5
				BaseEnjoyment += 10
			endIf
			; Add Bonus Enjoyment
			if IsVictim
				BestRelation = Thread.GetLowestPresentRelationshipRank(ActorRef)
				BaseEnjoyment += ((BestRelation - 3) + PapyrusUtil.ClampInt((OwnSkills[Stats.kLewd]-OwnSkills[Stats.kPure]) as int,-6,6)) * Utility.RandomInt(1, 10)
			else
				BestRelation = Thread.GetHighestPresentRelationshipRank(ActorRef)
				if IsAggressor
					BaseEnjoyment += (-1*((BestRelation - 4) + PapyrusUtil.ClampInt(((Skills[Stats.kLewd]-Skills[Stats.kPure])-(OwnSkills[Stats.kLewd]-OwnSkills[Stats.kPure])) as int,-6,6))) * Utility.RandomInt(1, 10)
				else
					BaseEnjoyment += (BestRelation + PapyrusUtil.ClampInt((((Skills[Stats.kLewd]+OwnSkills[Stats.kLewd])*0.5)-((Skills[Stats.kPure]+OwnSkills[Stats.kPure])*0.5)) as int,0,6)) * Utility.RandomInt(1, 10)
				endIf
			endIf
		else
			if IsVictim
				BestRelation = Thread.GetLowestPresentRelationshipRank(ActorRef)
				BaseEnjoyment += (BestRelation - 3) * Utility.RandomInt(1, 10)
			else
				BestRelation = Thread.GetHighestPresentRelationshipRank(ActorRef)
				if IsAggressor
					BaseEnjoyment += (-1*(BestRelation - 4)) * Utility.RandomInt(1, 10)
				else
					BaseEnjoyment += (BestRelation + 3) * Utility.RandomInt(1, 10)
				endIf
			endIf
		endIf
		LogInfo += "BaseEnjoyment["+BaseEnjoyment+"]"
		Log(LogInfo)
	;	; Play custom starting animation event
	;	if StartAnimEvent != ""
	;		Debug.SendAnimationEvent(ActorRef, StartAnimEvent)
	;	endIf
	;	if StartWait < 0.1
	;		StartWait = 0.1
	;	endIf
		GoToState("Prepare")
	;	RegisterForSingleUpdate(StartWait)
	endFunction

	function PathToCenter()
		ObjectReference CenterRef = Thread.CenterRef
		bool IsCenter = CenterRef == ActorRef as ObjectReference
		if CenterRef && ActorRef
			ObjectReference WaitRef = CenterRef
			if IsCenter && Thread.ActorCount > 1
			;	WaitRef = Thread.Positions[IntIfElse(Position != 0, 0, 1)]
				; Start Wait Idle
				StartWaitIdle()
			endIf
			float Distance = ActorRef.GetDistance(WaitRef)
			float MinDistance = ActorRef.GetLength() + 5
			if !IsCenter
				MinDistance += WaitRef.GetLength() + 5
			endIf
			Log("Current Distance From WaitRef["+WaitRef+"]: "+Distance+" // MinDistance: "+MinDistance)
			if WaitRef && Distance < 8000.0 && Distance > MinDistance
				if !IsCenter && ActorRef.GetDistance(CenterRef) > MinDistance
					ActorRef.SetFactionRank(AnimatingFaction, 2)
					ActorRef.EvaluatePackage()
				endIf
				ActorRef.SetLookAt(WaitRef, false)
				if IsPlayer
					Thread.RemoveFade()
				endIf
				
				; Start wait loop for actor pathing.
				Utility.Wait(0.1)
				int StuckCheck = 0
				float Failsafe = SexLabUtil.GetCurrentGameRealTime() + 15.0
				bool CheckNear = !IsCreature
				while Distance > MinDistance && SexLabUtil.GetCurrentGameRealTime() < Failsafe
					Utility.Wait(1.0)
					float Previous = Distance
					Distance = ActorRef.GetDistance(WaitRef)
					Log("Current Distance From WaitRef["+WaitRef+"]: "+Distance+" // Moved: "+(Previous - Distance)+" // StuckCheck: "+StuckCheck+" // MinDistance: "+MinDistance)
					if IsCenter
						if CheckNear && (Distance < MinDistance + 200)
							int Seid = ModEvent.Create(Thread.Key("StripActor"))
							if Seid
								ModEvent.PushForm(Seid, ActorRef)
							;	ModEvent.PushInt(Seid, -1)
								ModEvent.Send(Seid)
							endIf
							CheckNear = false
						endIf
					else
						float DistanceToCenter = ActorRef.GetDistance(CenterRef)
						if DistanceToCenter > MinDistance
							if CheckNear && (DistanceToCenter < MinDistance + 120) && Math.Abs(ActorRef.GetPositionZ() - CenterRef.GetPositionZ()) <= 50
								int Seid = ModEvent.Create(Thread.Key("StripActor"))
								if Seid
									ModEvent.PushForm(Seid, ActorRef)
								;	ModEvent.PushInt(Seid, -1)
									ModEvent.Send(Seid)
								endIf
								CheckNear = false
							endIf
							; Check if same distance as last time.
							if Math.Abs(Previous - Distance) < 1.0
								if StuckCheck > 2 ; Stuck for 2nd time, end loop.
									Distance = 0.0
								endIf
								StuckCheck += 1 ; End loop on next iteration if still stuck.
								Log("StuckCheck("+StuckCheck+") No progress while waiting for ["+WaitRef+"]")
							else
								StuckCheck -= 1 ; Reset stuckcheck if progress was made.
							endIf
						elseIf ActorRef.GetFactionRank(AnimatingFaction) != 1
							LockActor()
							
							MoveToStartingPosition()
						endIf
					endIf
				endWhile

			;	if IsPlayer
			;		Thread.ApplyFade()
			;	endIf
				ActorRef.ClearLookAt()
			endIf
		endIf
	endFunction

endState

bool Prepared ; TODO: Find better Solution
bool StartedUp ; TODO: Find better Solution
state Prepare
	event OnBeginState()
		if StartWait < 0.1
			StartWait = 0.1
		endIf
		if DoPathToCenter ; Check if is done with the walk before continue
			float Failsafe = SexLabUtil.GetCurrentGameRealTime() + 10.0
			While SexLabUtil.GetCurrentGameRealTime() < Failsafe && !(MarkerRef && MarkerRef.IsEnabled() && IsInPosition(ActorRef, MarkerRef, 75.0))
				Utility.Wait(1.0)
			EndWhile
			if !(MarkerRef && MarkerRef.IsEnabled() && IsInPosition(ActorRef, MarkerRef, 75.0))
				LockActor()
				MoveToStartingPosition()
				ActorRef.ClearLookAt()
			endIf
		endIf
		
		; Play custom starting animation event
		if StartAnimEvent != ""
			Debug.SendAnimationEvent(ActorRef, StartAnimEvent)
		endIf

		RegisterForSingleUpdate(StartWait)
	endEvent

	event OnUpdate()
		; Check if still among the living and able.
		if !ActorRef || ActorRef.IsDisabled() || (ActorRef.IsDead() && ActorRef.GetActorValue("Health") <= 0) ; Dead + Health for the Necro Mods compatibility
			Log("Actor is undefined, disabled, or has no health - Unable to continue animating")
			Thread.EndAnimation(true)
		else
			ClearEffects()
		;	if IsPlayer
				Thread.ApplyFade()
		;	endIf
			GetPositionInfo()
			; Starting position
			OffsetCoords(Loc, Center, Offsets)
			MarkerRef.SetPosition(Loc[0], Loc[1], Loc[2])
			MarkerRef.SetAngle(Loc[3], Loc[4], Loc[5])
		;	ActorRef.SetPosition(Loc[0], Loc[1], Loc[2])
		;	ActorRef.SetAngle(Loc[3], Loc[4], Loc[5])
			AttachMarker()
			if IsInPosition(ActorRef, MarkerRef, 40.0)
				ActorRef.StopTranslation() ; StopTranslation as side effect allow the actor move by the collisions but is required to stop any previous Translation and avoid the OnTranslationComplete.
				ActorRef.TranslateTo(Loc[0], Loc[1], Loc[2], Loc[3], Loc[4], Loc[5], 50000, 0.0)
			endIf
			if !IsPlayer || !ActorRef.IsOnMount()
				ActorRef.QueueNiNodeUpdate()
			endIf
			Debug.SendAnimationEvent(ActorRef, "SOSFastErect")
			; Notify thread prep is done
			if Thread.GetState() == "Prepare"
				if !Prepared
					Prepared = True
					Thread.SyncEventDone(kPrepareActor)
				endIf
			else
				StartAnimating()
			endIf
		endIf
	endEvent

	event OnTranslationComplete()
		Log(GetState(),"OnTranslationComplete()")
		if MarkerRef && MarkerRef.IsEnabled() 
			if (Math.Abs(ActorRef.GetAngleZ() - Loc[5]) > 2.0) ; If the TranslateTo can't rotate it
				ActorRef.SetVehicle(none)
				MarkerRef.SetPosition(Loc[0], Loc[1], Loc[2])
				MarkerRef.SetAngle(Loc[3], Loc[4], Loc[5])
				ActorRef.SetPosition(Loc[0], Loc[1], Loc[2])
				ActorRef.SetAngle(Loc[3], Loc[4], Loc[5])
				AttachMarker()
				ActorRef.TranslateTo(Loc[0], Loc[1], Loc[2], Loc[3], Loc[4], Loc[5], 50000, 0.0)
				Log(ActorName +"-Loc- Angle:[X:"+Loc[3]+"Y:"+Loc[4]+"Z:"+Loc[5]+"] Position:[X:"+Loc[0]+"Y:"+Loc[1]+"Z:"+Loc[2]+"]", "OnTranslationComplete()")
				Log(ActorName +"-MarkerRef- Angle:[X:"+MarkerRef.GetAngleX()+"Y:"+MarkerRef.GetAngleY()+"Z:"+MarkerRef.GetAngleZ()+"] Position:[X:"+MarkerRef.GetPositionX()+"Y:"+MarkerRef.GetPositionY()+"Z:"+MarkerRef.GetPositionZ()+"]", "OnTranslationComplete()")
				Log(ActorName +"-ActorRef- Angle:[X:"+ActorRef.GetAngleX()+"Y:"+ActorRef.GetAngleY()+"Z:"+ActorRef.GetAngleZ()+"] Position:[X:"+ActorRef.GetPositionX()+"Y:"+ActorRef.GetPositionY()+"Z:"+ActorRef.GetPositionZ()+"]", "OnTranslationComplete()")
			elseIf IsInPosition(ActorRef, MarkerRef, 2.0)
				ActorRef.TranslateTo(Loc[0], Loc[1], Loc[2], Loc[3], Loc[4], Loc[5]+0.01, 500.0, 0.0001)
			endIf
		endIf
	endEvent

	function StartAnimating()
		If ActorRef
			TrackedEvent("Start")
			; Remove from bard audience if in one
			Config.CheckBardAudience(ActorRef, true)
			; Prepare for loop
			StopAnimating(true)
			StartedAt  = SexLabUtil.GetCurrentGameRealTime()
			LastOrgasm = StartedAt
			GoToState("Animating")
			SyncAll(FALSE)
			PlayingSA = Animation.Registry
		;	if Stage == 1
		;		CurrentSA = PlayingSA
		;	endIf
			if ActorRef.GetActorValue("Paralysis") != 0.0
				Debug.SendAnimationEvent(ActorRef, "Ragdoll")
				Utility.Wait(0.1)
				SendDefaultAnimEvent()
				ActorRef.SetActorValue("Paralysis", 0.0)
				Utility.WaitMenuMode(0.2)
			endIf
			SendDefaultAnimEvent()
			If Config.HasSLSO;SLSO ---BEGIN-----------------------------------
				SLSO_StartAnimating()
			endIf;SLSO ---END------------------------------------
			; If enabled, start Auto TFC for player
			if IsPlayer && Config.AutoTFC
				int CameraState = Game.GetCameraState()
				Log("- CameraState: "+CameraState, "StartAnimating()")
				if CameraState < 8 && CameraState != 3
			;	if Game.GetCameraState() < 8 && Game.GetCameraState() != 3
					Game.ForceThirdPerson()
				endIf
				MiscUtil.SetFreeCameraState(true, Config.AutoSUCSM)
			;	MiscUtil.SetFreeCameraSpeed(Config.AutoSUCSM)
			endIf
			; Start update loop
			if Thread.GetState() == "Prepare"
				if !StartedUp
					StartedUp = True
					Thread.SyncEventDone(kStartUp)
				endIf
			else
				SyncLocation(true)
				SendAnimation()
			endIf
			RegisterForSingleUpdate(Utility.RandomFloat(1.0, 3.0))
		endIf
	endFunction
	
	event ResetActor()
		ClearEvents()
		GoToState("Resetting")
		Log("Resetting!")
		; Clear TFC
		Thread.ApplyFade()
		if IsPlayer
			MiscUtil.SetFreeCameraState(false)
		endIf
		StopAnimating(true)
		UnlockActor()
		RestoreActorDefaults()
		; Tracked events
		TrackedEvent("End")
		; Unstrip items in storage, if any
		if !IsCreature
			if !(ActorRef.IsDead() || ActorRef.GetActorValue("Health") <= 1.0)
				Unstrip()
				; Add back high heel effects
				if Config.RemoveHeelEffect
					; HDT High Heel
					if HDTHeelSpell && ActorRef.GetWornForm(0x00000080) && !ActorRef.HasSpell(HDTHeelSpell)
						ActorRef.AddSpell(HDTHeelSpell)
					endIf
					; NiOverride High Heels move out to prevent isues and add NiOverride Scale for race menu compatibility
				endIf
				if Config.HasNiOverride
					bool UpdateNiOPosition = NiOverride.RemoveNodeTransformPosition(ActorRef, false, isRealFemale, "NPC", "SexLab.esm")
					bool UpdateNiOScale = NiOverride.RemoveNodeTransformScale(ActorRef, false, isRealFemale, "NPC", "SexLab.esm")
					if UpdateNiOPosition || UpdateNiOScale ; I make the variables because not sure if execute both funtion in OR condition.
						NiOverride.UpdateNodeTransform(ActorRef, false, isRealFemale, "NPC")
					endIf
				endIf
			else
				if Config.HasNiOverride && NiOverride.RemoveNodeTransformScale(ActorRef, False, isRealFemale, "NPC", "SexLab.esm")
					NiOverride.UpdateNodeTransform(ActorRef, False, isRealFemale, "NPC")
				endIf
			endIf
		endIf
		Config.ClearActorFaceItems(ActorRef)
		; Free alias slot
		TryToClear()
		GoToState("")
		Thread.SyncEventDone(kResetActor)
	endEvent
endState

; ------------------------------------------------------- ;
; --- Animation Loop                                  --- ;
; ------------------------------------------------------- ;


function SendAnimation()
endFunction

function GetPositionInfo()
	if ActorRef
		if AdjustKey != Thread.AdjustKey
			SetAdjustKey(Thread.AdjustKey)
		endIf
		LeadIn     = Thread.LeadIn
		Stage      = Thread.Stage
		Animation  = Thread.Animation
		StageCount = Animation.StageCount
		if Stage > StageCount
			return
		endIf
		Log("Animation:"+Animation.Name+" AdjustKey:"+AdjustKey+" Position:"+Position+" Stage:"+Stage)
		Flags      = Animation.PositionFlags(Flags, AdjustKey, Position, Stage)
		Offsets    = new float[4]
		Offsets    = Animation.PositionOffsets(Offsets, AdjustKey, Position, Stage, FurnitureStatus[1])
		CurrentSA  = Animation.Registry
		; AnimEvents[Position] = Animation.FetchPositionStage(Position, Stage)
	endIf
endFunction

string PlayingSA
string CurrentSA
string PlayingAE
string CurrentAE
float LoopDelay
float LoopExpressionDelay
state Animating

	function SendAnimation()
		CurrentAE = AnimEvents[Position]
		if ActorRef.Is3DLoaded() && (!IsPlayer || Game.GetCameraState() > 3)
			ActorRef.SetAnimationVariableBool("bHumanoidFootIKDisable", False)
		endIf
		; Reenter SA - On stage 1 while animation hasn't changed since last call
		if Stage == 1 && PlayingAE != CurrentAE ;|| PlayingSA == CurrentSA)
			SendDefaultAnimEvent()
		;	Utility.Wait(0.2)
			Debug.SendAnimationEvent(ActorRef, Animation.FetchPositionStage(Position, 1))
			; Debug.SendAnimationEvent(ActorRef, Animation.FetchPositionStage(Position, 1)+"_REENTER")
		else
			; Enter a new SA - Not necessary on stage 1 since both events would be the same
			if Stage != 1 && PlayingSA != CurrentSA && PlayingSA != Animation.FetchPositionStage(Position, 1)
				SendDefaultAnimEvent() ; To unequip the AnimObject TODO: Find better solution
				Debug.SendAnimationEvent(ActorRef, Animation.FetchPositionStage(Position, 1))
				Utility.Wait(0.2)
				; Log("NEW SA - "+Animation.FetchPositionStage(Position, 1))
			endIf
			; Play the primary animation
		 	Debug.SendAnimationEvent(ActorRef, CurrentAE)
		 	; Log(CurrentAE)
		endIf
		; Save id of last SA played
		PlayingSA = Animation.Registry
		; Save id of last AE played
		PlayingAE  = CurrentAE
		Debug.SendAnimationEvent(ActorRef, "SOSBend"+Schlong)
	endFunction

	event OnUpdate()
		; Pause further updates if in menu
		if Utility.IsInMenuMode()
			Utility.Wait(0.1)
		endIf
		; Check if still among the living and able.
		if !ActorRef || ActorRef.IsDisabled() || (ActorRef.IsDead() && ActorRef.GetActorValue("Health") <= 0) ; Dead + Health for the Necro Mods compatibility
			Log("Actor is disabled, or has no health - Unable to continue animating")
			Thread.EndAnimation(true)
		;	return
		elseIf !ActorRef.Is3DLoaded()
			Log("Actor is out of cell or 3D unloaded - Unable to be animated will be ignored for now")
			; Loop
			LoopDelay += (VoiceDelay * 0.35)
			LoopExpressionDelay += (VoiceDelay * 0.35)
			RefreshExpressionDelay += (VoiceDelay * 0.35)
			RegisterForSingleUpdate(VoiceDelay * 0.35)
		else ; Else instead of return becouse return don't work on Events (at less in LE)
			; Lip sync and refresh expression
			if GetState() == "Animating"
				int Strength = CalcReaction()
				if LoopDelay >= VoiceDelay && (Config.LipsFixedValue || Strength > 10)
					LoopDelay = 0.0
					if OpenMouth && UseLipSync && !IsLipFixed && !Config.LipsFixedValue
						sslBaseVoice.MoveLips(ActorRef, none, 0.3)
						Log("PlayMoan:False; UseLipSync:"+UseLipSync+"; OpenMouth:"+OpenMouth+"; VoiceDelay:"+VoiceDelay+"; LoopDelay:"+LoopDelay)
					elseIf !IsSilent
						if Config.HasSLSO
							SLSO_Animating_Moan()
						else
							Voice.PlayMoan(ActorRef, Strength, IsVictim, UseLipSync && !IsLipFixed)
						;	Voice.PlayMoanEx(ActorRef, Strength, IsVictim, UseLipSync && !IsLipFixed, Config.LipsSoundTime, Config.LipsMoveTime, Config.LipsPhoneme, Config.LipsMinValue, Config.LipsMaxValue, Config.LipsFixedValue, Config.HasMFGFix)
							Log("PlayMoan:True; UseLipSync:"+UseLipSync+"; OpenMouth:"+OpenMouth+"; VoiceDelay:"+VoiceDelay+"; LoopDelay:"+LoopDelay)
						endIf
					endIf
				endIf
				if Expressions && Expressions.Length > 0
					int oldExpressionType = ExpressionType
					If Animation 
						ExpressionType = Animation.GetStageExpressive(Position, Stage)
						If ExpressionType == 0
							ExpressionType = Animation.GetExpressive(Position)
						EndIf
					EndIf
					if LoopExpressionDelay >= ExpressionDelay && (Config.RefreshExpressions || oldExpressionType != ExpressionType)
						sslBaseExpression oldExpression = Expression
						If ExpressionType != -1
							If ExpressionType == 1 && UseFaceItems ; Force Normal Expression
								sslBaseExpression[] FilteredExpressions = sslUtility.FilterTaggedExpressions(Expressions, PapyrusUtil.StringArray(1, "Ahegao"), False)
								If FilteredExpressions.Length > 0
									Expression = FilteredExpressions[Utility.RandomInt(0, (FilteredExpressions.Length - 1))]
								EndIf
							ElseIf ExpressionType == 2 && UseFaceItems ; Force Ahegao Expression
								sslBaseExpression[] FilteredExpressions = sslUtility.FilterTaggedExpressions(Expressions, PapyrusUtil.StringArray(1, "Ahegao"), True)
								If FilteredExpressions.Length > 0
									Expression = FilteredExpressions[Utility.RandomInt(0, (FilteredExpressions.Length - 1))]
								EndIf
							Else ; All Expression Allowed
								Expression = Expressions[Utility.RandomInt(0, (Expressions.Length - 1))]
							EndIf
							Log("Expression["+Expression.Name+"] BaseVoiceDelay["+BaseDelay+"] ExpressionDelay["+ExpressionDelay+"] LoopExpressionDelay["+LoopExpressionDelay+"] ")
						Else ; Expression Disabled
							Expression = none
							Log("Expression[None] BaseVoiceDelay["+BaseDelay+"] ExpressionDelay["+ExpressionDelay+"] LoopExpressionDelay["+LoopExpressionDelay+"] ")
						EndIf
						if oldExpression != Expression
							sslBaseExpression.UnequipWornFaceItem(ActorRef, oldExpression, Expression)
							RefreshExpression()
						endIf
						LoopExpressionDelay = 0.0
					endIf
				endIf
				if RefreshExpressionDelay > 8.0 && Math.Abs(OldStrength - Strength) > 10
					RefreshExpression()
				endIf
				; Trigger orgasm
				if !NoOrgasm && SeparateOrgasms && Strength >= 100 && Stage <= StageCount && (RealTime[0] - LastOrgasm) > (((IsMale as int) + (IsCreature as int) + 1) * 10.0)
					OrgasmEffect()
				endIf
			endIf
			; Loop
			LoopDelay += (VoiceDelay * 0.35)
			LoopExpressionDelay += (VoiceDelay * 0.35)
			RefreshExpressionDelay += (VoiceDelay * 0.35)
			RegisterForSingleUpdate(VoiceDelay * 0.35)
		endIf
	endEvent

	function SyncThread()
		; Sync with thread info
		GetPositionInfo()
		VoiceDelay = BaseDelay
		ExpressionDelay = Config.ExpressionDelay * BaseDelay
		Float RandomValue = 0.2
		if !IsSilent && Stage > 1
		;	VoiceDelay -= (Stage * 0.8) + Utility.RandomFloat(-0.2, 0.4)
			RandomValue = Utility.RandomFloat(-0.2, 0.4)
			VoiceDelay = (BaseDelay - ((CalcReaction() / 100) * BaseDelay)) + RandomValue
		endIf
		if VoiceDelay < 0.8
		;	VoiceDelay = Utility.RandomFloat(0.8, 1.4) ; Can't have delay shorter than animation update loop
			VoiceDelay = RandomValue + 1.0 ; Can't have delay shorter than animation update loop
		endIf
		; Update alias info
	;	GetEnjoyment()
		; Sync status
		if ActorRef && !IsCreature
			ResolveStrapon()
			sslBaseExpression.UnequipWornFaceItem(ActorRef, Expression)
			int Seid = ModEvent.Create(Thread.Key("RefreshActorExpression"))
			if Seid
				ModEvent.PushForm(Seid, ActorRef)
				ModEvent.Send(Seid)
			else
				RefreshExpression()
			endIf
		endIf
	;	Debug.SendAnimationEvent(ActorRef, "SOSBend"+Schlong)
		; SyncLocation(false)
	endFunction

	function SyncActor()
		SyncThread()
		SyncLocation(false)
		Thread.SyncEventDone(kSyncActor)
	endFunction

	function SyncAll(bool Force = false)
		If !ActorRef
			return
		endIf

		SyncThread()
		SyncLocation(Force)
		If Force
			Debug.SendAnimationEvent(ActorRef, "SOSBend"+Schlong)
		endIf
	endFunction

	function RefreshActor()
		If ActorRef
			UnregisterForUpdate()
			SyncThread()
			StopAnimating(true)
			SyncLocation(false)
		;	CurrentSA = PlayingSA
			CurrentAE = "SexLabSequenceExit1"
			Debug.SendAnimationEvent(ActorRef, CurrentAE)
			SendDefaultAnimEvent()
			Utility.WaitMenuMode(0.2)
			CurrentSA = Animation.Registry
			CurrentAE = Animation.FetchPositionStage(Position, 1)
			Debug.SendAnimationEvent(ActorRef, CurrentAE)
			PlayingSA = CurrentSA
			PlayingAE = CurrentAE
			SyncLocation(true)
			SendAnimation()
			RegisterForSingleUpdate(1.0)
			Thread.SyncEventDone(kRefreshActor)
		endIf
	endFunction

	function RefreshLoc()
		Offsets = Animation.PositionOffsets(Offsets, AdjustKey, Position, Stage, FurnitureStatus[1])
		SyncLocation(true)
	endFunction

	function SyncLocation(bool Force = false)
		If !ActorRef || !MarkerRef
			return
		endIf
		OffsetCoords(Loc, Center, Offsets)
		MarkerRef.SetPosition(Loc[0], Loc[1], Loc[2])
		MarkerRef.SetAngle(Loc[3], Loc[4], Loc[5])
		; Avoid forcibly setting on player coords if avoidable - causes annoying graphical flickering
	;	if Force 
	;		if IsPlayer && IsInPosition(ActorRef, MarkerRef, 40.0)
	;			AttachMarker()
	;			ActorRef.StopTranslation()
	;			ActorRef.TranslateTo(Loc[0], Loc[1], Loc[2], Loc[3], Loc[4], Loc[5], 50000, 0)
	;			return ; OnTranslationComplete() will take over when in place
	;		else
	;			ActorRef.SetPosition(Loc[0], Loc[1], Loc[2])
	;			ActorRef.SetAngle(Loc[3], Loc[4], Loc[5])
	;		endIf
	;	endIf
		AttachMarker()
		if Force || !IsInPosition(ActorRef, MarkerRef, 2.0)
			ActorRef.StopTranslation() ; StopTranslation as side effect allow the actor move by the collisions but is required to stop any previous Translation and avoid the OnTranslationComplete.
			ActorRef.TranslateTo(Loc[0], Loc[1], Loc[2], Loc[3], Loc[4], Loc[5], 50000, 0.0)
		endIf
	endFunction

	function Snap()
		if !(ActorRef && ActorRef.Is3DLoaded())
			return
		endIf
		; Quickly move into place and angle if actor is off by a lot
		float distance = ActorRef.GetDistance(MarkerRef)
		if distance > 125.0 || (Math.Abs(ActorRef.GetAngleZ() - Loc[5]) > 2.0) ;|| !IsInPosition(ActorRef, MarkerRef, 75.0)
			ActorRef.SetVehicle(none)
			MarkerRef.SetPosition(Loc[0], Loc[1], Loc[2])
			MarkerRef.SetAngle(Loc[3], Loc[4], Loc[5])
			ActorRef.SetPosition(Loc[0], Loc[1], Loc[2])
			ActorRef.SetAngle(Loc[3], Loc[4], Loc[5])
			AttachMarker()
			Log(ActorName +"-Loc- Angle:[X:"+Loc[3]+"Y:"+Loc[4]+"Z:"+Loc[5]+"] Position:[X:"+Loc[0]+"Y:"+Loc[1]+"Z:"+Loc[2]+"]", "Snap()")
			Log(ActorName +"-MarkerRef- Angle:[X:"+MarkerRef.GetAngleX()+"Y:"+MarkerRef.GetAngleY()+"Z:"+MarkerRef.GetAngleZ()+"] Position:[X:"+MarkerRef.GetPositionX()+"Y:"+MarkerRef.GetPositionY()+"Z:"+MarkerRef.GetPositionZ()+"]", "Snap()")
			Log(ActorName +"-ActorRef- Angle:[X:"+ActorRef.GetAngleX()+"Y:"+ActorRef.GetAngleY()+"Z:"+ActorRef.GetAngleZ()+"] Position:[X:"+ActorRef.GetPositionX()+"Y:"+ActorRef.GetPositionY()+"Z:"+ActorRef.GetPositionZ()+"]", "Snap()")
		elseIf distance > 2.0
			ActorRef.StopTranslation() ; StopTranslation as side effect allow the actor move by the collisions but is required to stop any previous Translation and avoid the OnTranslationComplete.
			ActorRef.TranslateTo(Loc[0], Loc[1], Loc[2], Loc[3], Loc[4], Loc[5], 50000, 0.0)
			return ; OnTranslationComplete() will take over when in place
		endIf
		; Begin very slowly rotating a small amount to hold position
		ActorRef.TranslateTo(Loc[0], Loc[1], Loc[2], Loc[3], Loc[4], Loc[5]+0.01, 500.0, 0.0001)
	endFunction

	event OnTranslationComplete()
		; Log(GetState(), "OnTranslationComplete()")
		Snap()
	endEvent

	;/ event OnTranslationFailed()
		Log(GetState(), "OnTranslationFailed()")
		; SyncLocation(false)
	endEvent /;

	function OrgasmEffect()
		if Config.HasSLSO ;SLSO
			OrgasmEffectSLSO()
		else
			DoOrgasm()
		endIf
	endFunction

	function DoOrgasm(bool Forced = false)
		if !ActorRef
			return
		endIf
		int Enjoyment = GetEnjoyment()
		if !Forced && (NoOrgasm || Thread.DisableOrgasms)
			; Orgasm Disabled for actor or whole thread
			return 
		elseIf !Forced && Enjoyment < 1
			; Actor have the orgasm few seconds ago or is in pain and can't orgasm
			return
		elseIf Math.Abs(RealTime[0] - LastOrgasm) < 5.0
			Log("Excessive OrgasmEffect Triggered")
			return
		endIf

		; Check if the animation allow Orgasm. By default all the animations with a CumID>0 are type SEX and allow orgasm 
		; But the Lesbian Animations usually don't have CumId assigned and still the orgasm should be allowed at least for Females.
		bool CanOrgasm = Forced || ((IsFemale || IsFuta) && (Animation.HasTag("Lesbian") || Animation.Females == Animation.PositionCount))
		int i = Thread.ActorCount
		while !CanOrgasm && i > 0
			i -= 1
			CanOrgasm = Animation.GetCumID(i, Stage) > 0 || Animation.GetCum(i) > 0
		endWhile
		if !CanOrgasm
			; Orgasm Disabled for the animation
			return
		endIf

		; Check Separate Orgasm conditions 
		if !Forced && Config.SeparateOrgasms
			if Enjoyment < 100 && (Stage < StageCount || Orgasms > 0)
				; Prevent the orgasm with low enjoyment at least the last stage be reached without orgasms
				return
			endIf
			bool IsCumSource = False
			i = Thread.ActorCount
			while !IsCumSource && i > 0
				i -= 1
				IsCumSource = Animation.GetCumSource(i, Stage) == Position
			endWhile
			if !IsCumSource
				if IsFuta && !(Animation.HasTag("Anal") || Animation.HasTag("Vaginal") || Animation.HasTag("Pussy") || Animation.HasTag("Cunnilingus") || Animation.HasTag("Fisting") || Animation.HasTag("Handjob") || Animation.HasTag("Blowjob") || Animation.HasTag("Boobjob") || Animation.HasTag("Footjob") || Animation.HasTag("Penis"))
					return
				elseIf IsMale && !(Animation.HasTag("Anal") || Animation.HasTag("Vaginal") || Animation.HasTag("Handjob") || Animation.HasTag("Blowjob") || Animation.HasTag("Boobjob") || Animation.HasTag("Footjob") || Animation.HasTag("Penis"))
					return
				elseIf IsFemale && !(Animation.HasTag("Anal") || Animation.HasTag("Vaginal") || Animation.HasTag("Pussy") || Animation.HasTag("Cunnilingus") || Animation.HasTag("Fisting") || Animation.HasTag("Breast"))
					return
				endIf
			endIf
		endIf
		UnregisterForUpdate()
		LastOrgasm = RealTime[0]
		Orgasms   += 1
		; Send an orgasm event hook with actor and orgasm count
		int eid = ModEvent.Create("SexLabOrgasm")
		ModEvent.PushForm(eid, ActorRef)
		ModEvent.PushInt(eid, FullEnjoyment)
		ModEvent.PushInt(eid, Orgasms)
		ModEvent.Send(eid)
		TrackedEvent("Orgasm")
		Log(ActorName + ": Orgasms["+Orgasms+"] FullEnjoyment ["+FullEnjoyment+"] BaseEnjoyment["+BaseEnjoyment+"] Enjoyment["+Enjoyment+"]")
		if Config.OrgasmEffects
			; Shake camera for player
			if IsPlayer && Config.ShakeStrength > 0 && Game.GetCameraState() >= 8
				Game.ShakeCamera(none, Config.ShakeStrength, Config.ShakeStrength + 1.0)
			endIf
			; Play SFX/Voice
			if !IsSilent
				PlayLouder(Voice.GetSound(100, false), ActorRef, Config.VoiceVolume)
			endIf
			PlayLouder(OrgasmFX, ActorRef, Config.SFXVolume)
		endIf
		; Apply cum to female positions from male position orgasm
		i = Thread.ActorCount
		if i > 1 && Config.UseCum && (MalePosition || IsCreature) && (IsMale || IsFuta || IsCreature || (Config.AllowFFCum && IsFemale))
			if i == 2
				Thread.PositionAlias(IntIfElse(Position == 1, 0, 1)).ApplyCum()
			else
				while i > 0
					i -= 1
					if Position != i && Position < Animation.PositionCount && Animation.IsCumSource(Position, i, Stage)
						Thread.PositionAlias(i).ApplyCum()
					endIf
				endWhile
			endIf
		endIf
		Utility.WaitMenuMode(0.2)
		; Reset enjoyment build up, if using multiple orgasms
		QuitEnjoyment += Enjoyment
		if IsSkilled
			if IsVictim
				BaseEnjoyment += ((BestRelation - 3) + PapyrusUtil.ClampInt((OwnSkills[Stats.kLewd]-OwnSkills[Stats.kPure]) as int,-6,6)) * Utility.RandomInt(5, 10)
			else
				if IsAggressor
					BaseEnjoyment += (-1*((BestRelation - 4) + PapyrusUtil.ClampInt(((Skills[Stats.kLewd]-Skills[Stats.kPure])-(OwnSkills[Stats.kLewd]-OwnSkills[Stats.kPure])) as int,-6,6))) * Utility.RandomInt(5, 10)
				else
					BaseEnjoyment += (BestRelation + PapyrusUtil.ClampInt((((Skills[Stats.kLewd]+OwnSkills[Stats.kLewd])*0.5)-((Skills[Stats.kPure]+OwnSkills[Stats.kPure])*0.5)) as int,0,6)) * Utility.RandomInt(5, 10)
				endIf
			endIf
		else
			if IsVictim
				BaseEnjoyment += (BestRelation - 3) * Utility.RandomInt(5, 10)
			else
				if IsAggressor
					BaseEnjoyment += (-1*(BestRelation - 4)) * Utility.RandomInt(5, 10)
				else
					BaseEnjoyment += (BestRelation + 3) * Utility.RandomInt(5, 10)
				endIf
			endIf
		endIf
		; VoiceDelay = 0.8
		RegisterForSingleUpdate(0.8)
	endFunction

	function OrgasmEffectSLSO(bool Forced = false)
		if !ActorRef
			return
		endIf
		;Log("OrgasmEffect Triggered")
		int Enjoyment = GetFullEnjoyment()
		if !Forced && (NoOrgasm || Thread.DisableOrgasms)
			; Orgasm Disabled for actor or whole thread
			return
		elseIf !Forced && Enjoyment < 1
			; Actor have the orgasm few seconds ago or is in pain and can't orgasm
			return
		elseIf Math.Abs(RealTime[0] - LastOrgasm) < 5.0
			Log("Excessive OrgasmEffect Triggered")
			return
		elseIf Forced != true && SeparateOrgasms
			;SLSO conditions to prevent orgasm
			if SLSO_DoOrgasm_Conditions(Forced) < 0
				return
			endIf
		endIf

		
		int i
		;/ SLSO: this probably breaks orgasms in some animations (Is not the reason but I'm too tired to discuse it)
		; Check if the animation allow Orgasm. By default all the animations with a CumID>0 are type SEX and allow orgasm 
		; But the Lesbian Animations usually don't have CumId assigned and still the orgasm should be allowed at least for Females.
		bool CanOrgasm = Forced || ((IsFemale || IsFuta) && (Animation.HasTag("Lesbian") || Animation.Females == Animation.PositionCount))
		int i = Thread.ActorCount
		while !CanOrgasm && i > 0
			i -= 1
			CanOrgasm = Animation.GetCumID(i, Stage) > 0 || Animation.GetCum(i) > 0
		endWhile
		if !CanOrgasm
			; Orgasm Disabled for the animation
			return
		endIf
		if !Forced && Config.SeparateOrgasms
			;if Enjoyment < 100 && (Stage < StageCount || Orgasms > 0)
			;	; Prevent the orgasm with low enjoyment at least the last stage be reached without orgasms
			;	return
			;endIf
			bool IsCumSource = False
			i = Thread.ActorCount
			while !IsCumSource && i > 0
				i -= 1
				IsCumSource = Animation.GetCumSource(i, Stage) == Position
			endWhile
			if !IsCumSource
				if IsFuta && !(Animation.HasTag("Anal") || Animation.HasTag("Vaginal") || Animation.HasTag("Pussy") || Animation.HasTag("Cunnilingus") || Animation.HasTag("Fisting") || Animation.HasTag("Handjob") || Animation.HasTag("Blowjob") || Animation.HasTag("Boobjob") || Animation.HasTag("Footjob") || Animation.HasTag("Penis"))
					return
				elseIf IsMale && !(Animation.HasTag("Anal") || Animation.HasTag("Vaginal") || Animation.HasTag("Handjob") || Animation.HasTag("Blowjob") || Animation.HasTag("Boobjob") || Animation.HasTag("Footjob") || Animation.HasTag("Penis"))
					return
				elseIf IsFemale && !(Animation.HasTag("Anal") || Animation.HasTag("Vaginal") || Animation.HasTag("Pussy") || Animation.HasTag("Cunnilingus") || Animation.HasTag("Fisting") || Animation.HasTag("Breast"))
					return
				endIf
			endIf
		endIf
		/;
		
		UnregisterForUpdate()
		LastOrgasm = RealTime[0]
		Orgasms   += 1
		
		; reset timers
		SLSO_DoOrgasm_Multiorgasm()
		
		; Send an orgasm event hook with actor and orgasm count
		int eid = ModEvent.Create("SexLabOrgasm")
		ModEvent.PushForm(eid, ActorRef)
		ModEvent.PushInt(eid, FullEnjoyment)
		ModEvent.PushInt(eid, Orgasms)
		ModEvent.Send(eid)
		
		; Send an slso separate orgasm event hook with actor and thread id
		SLSO_DoOrgasm_SexLabOrgasmSeparate()

		TrackedEvent("Orgasm")
		Log(ActorName + ": Orgasms["+Orgasms+"] Enjoyment ["+Enjoyment+"] BaseEnjoyment["+BaseEnjoyment+"] FullEnjoyment["+FullEnjoyment+"]")
		if Config.OrgasmEffects
			; Shake camera for player
			if IsPlayer && Config.ShakeStrength > 0 && Game.GetCameraState() >= 8
				Game.ShakeCamera(none, Config.ShakeStrength, Config.ShakeStrength + 1.0)
			endIf
			SLSO_DoOrgasm_Moan()
		endIf
		; Apply cum to female positions from male position orgasm
		i = Thread.ActorCount
		if i > 1 && Config.UseCum && (MalePosition || IsCreature) && (IsMale || IsFuta || IsCreature || (Config.AllowFFCum && IsFemale))
			if i == 2
				Thread.PositionAlias(IntIfElse(Position == 1, 0, 1)).ApplyCum()
			else
				while i > 0
					i -= 1
					if Position != i && Position < Animation.PositionCount && Animation.IsCumSource(Position, i, Stage)
						Thread.PositionAlias(i).ApplyCum()
					endIf
				endWhile
			endIf
		endIf
		Utility.WaitMenuMode(0.2)
		; Reset enjoyment build up, if using multiple orgasms
		QuitEnjoyment = FullEnjoyment
		; VoiceDelay = 0.8
		RegisterForSingleUpdate(0.8)
	endFunction

	event ResetActor()
		ClearEvents()
		if MarkerRef && ActorRef.GetDistance(MarkerRef) > 3000
			ActorRef.MoveTo(MarkerRef)
		endIf
		GoToState("Resetting")
		Log("Resetting!")
		; Clear TFC
		Thread.ApplyFade()
		if IsPlayer
			MiscUtil.SetFreeCameraState(false)
		endIf
		; Update stats
		if IsSkilled
			Actor VictimRef = Thread.VictimRef
			if IsVictim
				VictimRef = ActorRef
			endIf
			sslActorStats.RecordThread(ActorRef, Gender, BestRelation, StartedAt, RealTime[0], Utility.GetCurrentGameTime(), Thread.HasPlayer, VictimRef, Thread.Genders, Thread.SkillXP)
			Stats.AddPartners(ActorRef, Thread.Positions, Thread.Victims)
			if IsType[6]
				Stats.AdjustSkill(ActorRef, "VaginalCount", 1)
			endIf
			if IsType[7]
				Stats.AdjustSkill(ActorRef, "AnalCount", 1)
			endIf
			if IsType[8]
				Stats.AdjustSkill(ActorRef, "OralCount", 1)
			endIf
		endIf
		; Apply cum
		;/ int CumID = Animation.GetCum(Position)
		if CumID > 0 && !Thread.FastEnd && Config.UseCum && (Thread.Males > 0 || Config.AllowFFCum || Thread.HasCreature)
			ActorLib.ApplyCum(ActorRef, CumID)
		endIf /;
		; Make sure of play the last animation stage to prevet AnimObject issues
		CurrentAE = Animation.FetchPositionStage(Position, StageCount)
		if PlayingAE != CurrentAE
			Debug.SendAnimationEvent(ActorRef, CurrentAE)
		;	Utility.WaitMenuMode(0.2)
			PlayingAE = CurrentAE
		endIf
		StopAnimating(Thread.FastEnd, EndAnimEvent)
		UnlockActor()
		RestoreActorDefaults()
		; Tracked events
		TrackedEvent("End")
		; Unstrip items in storage, if any
		if !IsCreature
			if !(ActorRef.IsDead() || ActorRef.GetActorValue("Health") <= 1.0)
				Unstrip()
				; Add back high heel effects
				if Config.RemoveHeelEffect
					; HDT High Heel
					if HDTHeelSpell && ActorRef.GetWornForm(0x00000080) && !ActorRef.HasSpell(HDTHeelSpell)
						ActorRef.AddSpell(HDTHeelSpell)
					endIf
					; NiOverride High Heels move out to prevent isues and add NiOverride Scale for race menu compatibility
				endIf
				if Config.HasNiOverride
					bool UpdateNiOPosition = NiOverride.RemoveNodeTransformPosition(ActorRef, false, isRealFemale, "NPC", "SexLab.esm")
					bool UpdateNiOScale = NiOverride.RemoveNodeTransformScale(ActorRef, false, isRealFemale, "NPC", "SexLab.esm")
					if UpdateNiOPosition || UpdateNiOScale ; I make the variables because not sure if execute both funtion in OR condition.
						NiOverride.UpdateNodeTransform(ActorRef, false, isRealFemale, "NPC")
					endIf
				endIf
			else
				if Config.HasNiOverride && NiOverride.RemoveNodeTransformScale(ActorRef, False, isRealFemale, "NPC", "SexLab.esm")
					NiOverride.UpdateNodeTransform(ActorRef, False, isRealFemale, "NPC")
				endIf
			endIf
		endIf
		Config.ClearActorFaceItems(ActorRef)
		; Free alias slot
		TryToClear()
		GoToState("")
		Thread.SyncEventDone(kResetActor)
	endEvent
endState

state Resetting
	function ClearAlias()
	endFunction
	event OnUpdate()
	endEvent
	function Initialize()
	endFunction
endState

function SyncAll(bool Force = false)
endFunction

; ------------------------------------------------------- ;
; --- Actor Manipulation                              --- ;
; ------------------------------------------------------- ;

function StopAnimating(bool Quick = false, string ResetAnim = "IdleForceDefaultState")
	if !ActorRef || !ActorRef.Is3DLoaded()
		Log(ActorName +"- WARNING: ActorRef if Missing or Invalid", "StopAnimating("+Quick+")")
		return
	endIf
	; Disable free camera, if in it
	; if IsPlayer
	; 	MiscUtil.SetFreeCameraState(false)
	; endIf
	; Clear possibly troublesome effects
	bool Resetting = GetState() == "Resetting" || !Quick
	if Resetting
		int StageOffset = Stage
		if StageOffset > StageCount
			StageOffset = StageCount
		endIf
		if AdjustKey && AdjustKey != ""
			Offsets    = Animation.PositionOffsets(Offsets, AdjustKey, Position, StageOffset, FurnitureStatus[1])
		endIf
		float OffsetZ = 10.0
		if Offsets[2] < 1.0 ; Fix for animation default missaligned 
			Offsets[2] = OffsetZ ; hopefully prevents some users underground/teleport to giant camp problem?
		endIf
		OffsetCoords(Loc, Center, Offsets)
		float PositionX = ActorRef.GetPositionX()
		float PositionY = ActorRef.GetPositionY()
		float AngleZ = ActorRef.GetAngleZ()
		float Rotate = AngleZ
		String Node = "NPC Root [Root]"
		if !IsCreature
			Node = "MagicEffectsNode"
		endIf
		if NetImmerse.HasNode(ActorRef, Node, False)
			PositionX = NetImmerse.GetNodeWorldPositionX(ActorRef, Node, False)
			PositionY = NetImmerse.GetNodeWorldPositionY(ActorRef, Node, False)
			float[] Rotation = new float[3]
			if NetImmerse.GetNodeLocalRotationEuler(ActorRef, Node, Rotation, False)
				Rotate = AngleZ + Rotation[2]
				if Rotate >= 360.0
					Rotate = Rotate - 360.0
				elseIf Rotate < 0.0
					Rotate = Rotate + 360.0
				endIf
				Log(Node +" Rotation:"+Rotation+" AngleZ:"+AngleZ+" Rotate:"+Rotate)
			endIf
		endIf
		ActorRef.SetVehicle(none)
		if ActorRef.Is3DLoaded() && (!IsPlayer || Game.GetCameraState() > 3)
			ActorRef.SetAnimationVariableBool("bHumanoidFootIKDisable", true)
		endIf
		MarkerRef.SetPosition(PositionX, PositionY, Loc[2])
		MarkerRef.SetAngle(Loc[3], Loc[4], Rotate)
	;	ActorRef.SetPosition(PositionX, PositionY, Loc[2])
		ActorRef.StopTranslation() ; StopTranslation as side effect allow the actor move by the collisions but is required to stop any previous Translation and avoid the OnTranslationComplete.
		ActorRef.TranslateTo(PositionX, PositionY, Loc[2], Loc[3], Loc[4], Rotate, 50000, 0.0)
	else
		ActorRef.SetVehicle(none)
		if ActorRef.Is3DLoaded() && (!IsPlayer || Game.GetCameraState() > 3)
			ActorRef.SetAnimationVariableBool("bHumanoidFootIKDisable", true)
		endIf
	endIf
	; Stop animevent
	if IsCreature
		; Reset creature idle
		SendDefaultAnimEvent(Resetting)
		Utility.Wait(0.1)
		if ResetAnim != "IdleForceDefaultState" && ResetAnim != ""
			Debug.SendAnimationEvent(ActorRef, ResetAnim)
			Utility.Wait(0.1)
			If DoRagdoll && (!IsPlayer || (IsPlayer && Game.GetCameraState() != 3))
				ActorRef.PushActorAway(ActorRef, 0.001)
			endIf
		elseIf Resetting && ResetAnim == "IdleForceDefaultState"
			if ActorRef.IsDead() || ActorRef.IsUnconscious()
				if (!IsPlayer || (IsPlayer && Game.GetCameraState() != 3))
					ActorRef.SetDontMove(true)
				;	ActorRef.SetRestrained(true)
					ActorRef.KillSilent()
				;	Utility.Wait(0.1)
				;	Debug.SendAnimationEvent(ActorRef, "DeathAnimation")
				;	Utility.Wait(0.1)
				;	Debug.SendAnimationEvent(ActorRef, "ragdoll")
				else
					Debug.SendAnimationEvent(ActorRef, "DeathAnimation")
					Utility.Wait(0.1)
					Debug.SendAnimationEvent(ActorRef, "ragdoll")
				endIf
			elseIf DoRagdoll && (!IsPlayer || (IsPlayer && Game.GetCameraState() != 3))
				If ActorRef.GetActorValue("Health") <= 1.0
					ActorRef.KillSilent()
				elseIf (ActorRaceKey == "Spiders" || ActorRaceKey == "LargeSpiders" || ActorRaceKey == "GiantSpiders")
					ActorRef.PushActorAway(ActorRef, 0.001) ; Temporal Fix TODO:
				endIf
			endIf
		endIf
	else
		; Reset NPC/PC Idle Quickly
		if ResetAnim != "IdleForceDefaultState" && ResetAnim != ""
			Debug.SendAnimationEvent(ActorRef, ResetAnim)
			Utility.Wait(0.1)
			; Ragdoll NPC/PC if enabled and not in TFC
			if Resetting && DoRagdoll && (!IsPlayer || (IsPlayer && Game.GetCameraState() != 3))
				ActorRef.PushActorAway(ActorRef, 0.001)
			endIf
		elseIf !Resetting
			Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
		else
			If FurnitureRef != none
				Thread.SetFurnitureIgnored(false)
				Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
				Utility.Wait(0.1)
			elseif ActorRef.IsDead() || ActorRef.IsUnconscious()
					Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
					Utility.Wait(0.1)
					if (!IsPlayer || (IsPlayer && Game.GetCameraState() != 3))
					;	ActorRef.SetDontMove(true)
						ActorRef.SetRestrained(true)
						ActorRef.KillSilent()
					;	Utility.Wait(0.1)
					;	Debug.SendAnimationEvent(ActorRef, "IdleSoupDeath")
					;	Utility.Wait(0.1)
					;	Debug.SendAnimationEvent(ActorRef, "ragdoll")
					else
						Debug.SendAnimationEvent(ActorRef, "IdleSoupDeath")
						Utility.Wait(0.1)
						Debug.SendAnimationEvent(ActorRef, "ragdoll")
					endIf
			elseIf DoRagdoll && (!IsPlayer || (IsPlayer && Game.GetCameraState() != 3))
				;TODO: Detect the real actor position based on Node property intead of the Animation Tags
				If ActorRef.GetActorValue("Health") <= 1.0
					;TODO: chek the inventory items to make sure that will be the same once be killed
					ActorRef.KillSilent()
				elseIf Animation && (Animation.HasTag("Furniture") || (Animation.HasTag("Standing") && !IsType[0]))
					Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
				elseIf IsType[0] && IsVictim && Animation && Animation.HasTag("Rape") && !Animation.HasTag("Standing") && (!IsPlayer || (IsPlayer && Game.GetCameraState() != 3)) \
				&& (Animation.HasTag("DoggyStyle") || Animation.HasTag("Missionary") || Animation.HasTag("Laying"))
					ActorRef.PushActorAway(ActorRef, 0.001)
			;/	elseIf Animation.HasTag("DoggyStyle") && IsVictim
					Debug.SendAnimationEvent(ActorRef, "IdleCowering")
					Utility.Wait(1.0)
					Debug.SendAnimationEvent(ActorRef, "IdleChairExitStart")
				elseIf Animation.HasTag("Kneeling") && IsVictim
					Debug.SendAnimationEvent(ActorRef, "IdleCowering")
					Utility.Wait(1.0)
					Debug.SendAnimationEvent(ActorRef, "IdleChairExitStart")
				elseIf IsType[0] && IsVictim
					Debug.SendAnimationEvent(ActorRef, "IdleWarmArms")
					Utility.Wait(1.0)
					Debug.SendAnimationEvent(ActorRef, "IdleChairExitStart")
					Utility.Wait(1.0)
					Debug.SendAnimationEvent(ActorRef, "IdleBedExitStart")	
					Utility.Wait(1.0)
					Debug.SendAnimationEvent(ActorRef, "IdleSurrender")
				elseIf Animation.HasTag("Laying") || (Animation.HasTag("Cowgirl") && !IsVictim) || (Animation.HasTag("Missionary") && !IsVictim)
					Debug.SendAnimationEvent(ActorRef, "IdleSleepNod")
					Utility.Wait(1.0)
					Debug.SendAnimationEvent(ActorRef, "IdleBedExitStart")	
				elseIf Animation.HasTag("Cowgirl") || Animation.HasTag("Missionary")
					Debug.SendAnimationEvent(ActorRef, "IdleLayDown")	
			/;	else
					Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
				endIf
			else
				Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
			endIf
		endIf
	endIf
;	Log(ActorName +"-MarkerRef- Angle:[X:"+MarkerRef.GetAngleX()+"Y:"+MarkerRef.GetAngleY()+"Z:"+MarkerRef.GetAngleZ()+"] Position:[X:"+MarkerRef.GetPositionX()+"Y:"+MarkerRef.GetPositionY()+"Z:"+MarkerRef.GetPositionZ()+"]", "StopAnimating("+Quick+")")
;	Log(ActorName +"-ActorRef- Angle:[X:"+ActorRef.GetAngleX()+"Y:"+ActorRef.GetAngleY()+"Z:"+ActorRef.GetAngleZ()+"] Position:[X:"+ActorRef.GetPositionX()+"Y:"+ActorRef.GetPositionY()+"Z:"+ActorRef.GetPositionZ()+"]", "StopAnimating("+Quick+")")
	PlayingSA = "SexLabSequenceExit2"
	PlayingAE = "SexLabSequenceExit2"
endFunction

function SendDefaultAnimEvent(bool Exit = False)
	Debug.SendAnimationEvent(ActorRef, "AnimObjectUnequip")
	if !IsCreature
		Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
		Utility.Wait(0.1)
	elseIf ActorRaceKey != ""
		if ActorRaceKey == "Dragons"
			Debug.SendAnimationEvent(ActorRef, "FlyStopDefault") ; for Dragons only
			Utility.Wait(0.1)
			Debug.SendAnimationEvent(ActorRef, "Reset") ; for Dragons only
		elseIf ActorRaceKey == "Hagravens"
			Debug.SendAnimationEvent(ActorRef, "ReturnToDefault") ; for Dragons only
			Utility.Wait(0.1)
			if Exit
				Debug.SendAnimationEvent(ActorRef, "Reset") ; for Dragons only
			endIf
		elseIf ActorRaceKey == "Chaurus" || ActorRaceKey == "ChaurusReapers"
			Debug.SendAnimationEvent(ActorRef, "FNISDefault") ; for dwarvenspider and chaurus without time bettwen.
			Utility.Wait(0.1)
			if Exit
		;		Debug.SendAnimationEvent(ActorRef, "ReturnToDefault")
			endIf
		elseIf ActorRaceKey == "DwarvenSpiders"
			Debug.SendAnimationEvent(ActorRef, "ReturnToDefault")
			Utility.Wait(0.1)
			if Exit
		;		Debug.SendAnimationEvent(ActorRef, "FNISDefault") ; for dwarvenspider and chaurus
			endIf
		elseIf ActorRaceKey == "Draugrs" || ActorRaceKey == "Seekers" || ActorRaceKey == "DwarvenBallistas" || ActorRaceKey == "DwarvenSpheres" || ActorRaceKey == "DwarvenCenturions"
			Debug.SendAnimationEvent(ActorRef, "ForceFurnExit") ; for draugr, trolls daedras and all dwarven exept spiders
		elseIf ActorRaceKey == "Trolls"
			Debug.SendAnimationEvent(ActorRef, "ReturnToDefault")
			Utility.Wait(0.1)
			if Exit
				Debug.SendAnimationEvent(ActorRef, "ForceFurnExit") ; the troll need this afther "ReturnToDefault" to allow the attack idles
			endIf
		elseIf ActorRaceKey == "Chickens" || ActorRaceKey == "Rabbits" || ActorRaceKey == "Slaughterfishes"
			Debug.SendAnimationEvent(ActorRef, "ReturnDefaultState") ; for chicken, hare and slaughterfish
			Utility.Wait(0.1)
			if Exit
				Debug.SendAnimationEvent(ActorRef, "ReturnToDefault")
			endIf
		elseIf ActorRaceKey == "Werewolves" || ActorRaceKey == "VampireLords"
			Debug.SendAnimationEvent(ActorRef, "IdleReturnToDefault") ; for Werewolves and VampirwLords
			Utility.Wait(0.1)
		else
			Debug.SendAnimationEvent(ActorRef, "ReturnToDefault") ; the rest creature-animal
			Utility.Wait(0.1)
		endIf
	elseIf Exit
		Debug.SendAnimationEvent(ActorRef, "ReturnDefaultState") ; for chicken, hare and slaughterfish before the "ReturnToDefault"
		Debug.SendAnimationEvent(ActorRef, "ReturnToDefault") ; the rest creature-animal
		Debug.SendAnimationEvent(ActorRef, "FNISDefault") ; for dwarvenspider and chaurus
		Debug.SendAnimationEvent(ActorRef, "IdleReturnToDefault") ; for Werewolves and VampirwLords
		Debug.SendAnimationEvent(ActorRef, "ForceFurnExit") ; for Trolls afther the "ReturnToDefault" and draugr, daedras and all dwarven exept spiders
		Debug.SendAnimationEvent(ActorRef, "Reset") ; for Hagravens afther the "ReturnToDefault" and Dragons
		Utility.Wait(0.1)
	endIf
	Utility.Wait(0.2)
endFunction

function StartWaitIdle(string ResetAnim = "IdleForceDefaultState")
	if Config.WaitIdles && !IsCreature && !Restricted
		float Distance = 3000
		ObjectReference WaitRef = Thread.CenterAlias.GetReference()
		if WaitRef == ActorRef as ObjectReference && Thread.ActorCount > 1
			WaitRef = Thread.Positions[IntIfElse(Position != 0, 0, 1)]
		endIf
		if WaitRef
			Distance = ActorRef.GetDistance(WaitRef)
		endIf
		int Chance = Utility.RandomInt(0, 10)
		if IsType[0] && IsVictim && Distance < 3000.0
			if Chance > 4 && Distance > 800.0
				ActorRef.PushActorAway(ActorRef, 0.001)
			elseIf Chance > 6 && Distance > 200.0
				Debug.SendAnimationEvent(ActorRef, "IdleNervous")
			elseIf Chance > 4 && Distance > 200.0
				Debug.SendAnimationEvent(ActorRef, "IdleCowering")
			elseIf Chance > 8 && Distance < 80.0
				Debug.SendAnimationEvent(ActorRef, "IdleCowering")
			elseIf Chance > 6 && Distance < 80.0
				Debug.SendAnimationEvent(ActorRef, "IdleWarmArms")
			elseIf Chance > 4 && Distance < 80.0
				Debug.SendAnimationEvent(ActorRef, "ZapKneelDisplay")
			else
				Debug.SendAnimationEvent(ActorRef, "IdleSurrender")
			endIf
		elseIf Config.HasZazDevice && IsType[0] && Distance < 80.0
			if Chance > 4
				Debug.SendAnimationEvent(ActorRef, "ZapDomHandHips")
			endIf
		elseIf Config.HasSLAroused && Chance > 4
			if IsFemale && (!IsFuta || ActorRef.GetWornForm(Armor.GetMaskForSlot(32)) != none)
				Debug.SendAnimationEvent(ActorRef, "Aroused_Idle1")
			elseIf ActorRef.GetWornForm(Armor.GetMaskForSlot(32)) == none
				Debug.SendAnimationEvent(ActorRef, "Aroused_Idle2")
			endIf
		elseIf Config.HasZazDevice && (IsFemale || IsFuta) && Distance < 80.0
			if Chance > 8
				Debug.SendAnimationEvent(ActorRef, "ZapWriHorny01")
			elseIf Chance > 6
				Debug.SendAnimationEvent(ActorRef, "ZapWriHorny02")
			elseIf Chance > 4
				Debug.SendAnimationEvent(ActorRef, "ZapWriHorny03")
			else
				Debug.SendAnimationEvent(ActorRef, ResetAnim)
			endIf
		else
			Debug.SendAnimationEvent(ActorRef, ResetAnim)
		endIf
	endIf
endFunction

function AttachMarker()
	ActorRef.SetVehicle(MarkerRef)
	if ActorRef.Is3DLoaded() && (!IsPlayer || Game.GetCameraState() > 3)
		ActorRef.SetAnimationVariableBool("bHumanoidFootIKDisable", true)
	endIf
	if UseScale && AnimScale > 0.1 && (AnimScale != 1.0 || ActorScale != 1.0)
		ActorRef.SetScale(AnimScale)
	endIf
endFunction

function MoveToStartingPosition()
	if FurnitureStatus[1] <= 1
		int RelativePosition = Position
		Actor CenterActor = Thread.CenterRef as actor
		If CenterActor
			int CenterPosition = Thread.Positions.Find(CenterActor)
			If CenterPosition != -1
				RelativePosition = Position - CenterPosition
				If RelativePosition < 0
					RelativePosition = Thread.Positions.length + RelativePosition
				endIf
			endIf
			Log("Position:"+Position+"; RelativePosition:"+RelativePosition+"; CenterPosition:"+CenterPosition, "MoveToStartingPosition()")
		endIf
		; pre-move to starting position near other actors
		Offsets[0] = 0.0
		Offsets[1] = 0.0
		Offsets[2] = 5.0
		Offsets[3] = 0.0
		float ActorLength = ActorRef.GetLength()
		; Starting position
		if RelativePosition == 1
			Offsets[0] = (ActorLength * 0.75)
			Offsets[3] = 180.0

		elseif RelativePosition == 2
			Offsets[1] = -(ActorLength * 0.75)
			Offsets[3] = 90.0

		elseif RelativePosition == 3
			Offsets[1] = (ActorLength * 0.75)
			Offsets[3] = -90.0

		elseif RelativePosition == 4
			Offsets[0] = -(ActorLength * 0.75)

		endIf
	endIf
	OffsetCoords(Loc, Center, Offsets)
	MarkerRef.SetPosition(Loc[0], Loc[1], Loc[2])
	MarkerRef.SetAngle(Loc[3], Loc[4], Loc[5])
	If MarkerRef.GetDistance(ActorRef) > 80
		Thread.ApplyFade()
	endIf
;	ActorRef.SetPosition(Loc[0], Loc[1], Loc[2])
;	ActorRef.SetAngle(Loc[3], Loc[4], Loc[5])
	AttachMarker()
	if !IsInPosition(ActorRef, MarkerRef, 2.0)
		ActorRef.StopTranslation()
		ActorRef.TranslateTo(Loc[0], Loc[1], Loc[2], Loc[3], Loc[4], Loc[5], 50000, 0.0)
	endIf
	if !IsPlayer || !ActorRef.IsOnMount()
		ActorRef.QueueNiNodeUpdate()
	endIf
endFunction

function LockActor()
	if !ActorRef || ActorRef.IsDisabled()
		Log(ActorName +"- WARNING: ActorRef if Missing or Invalid", "LockActor()")
		return
	endIf
	; Stop whatever they are doing
	; SendDefaultAnimEvent()
	; Start DoNothing package
	ActorUtil.AddPackageOverride(ActorRef, Config.DoNothing, 100, 1)
	ActorRef.SetFactionRank(AnimatingFaction, 1)
	ActorRef.EvaluatePackage()
	; Remove any unwanted combat effects
	If SKSE.GetPluginVersion("Precision") >= 2000000
		Precision_Utility.ToggleDisableActor(ActorRef, true)
	endIf
	ClearEffects()
	; Attach positioning marker
	if !MarkerRef
		MarkerRef = ActorRef.PlaceAtMe(Config.BaseMarker)
		int cycle
		while !MarkerRef.Is3DLoaded() && cycle < 50
			Utility.Wait(0.1)
			cycle += 1
		endWhile
		if cycle
			Log("Waited ["+cycle+"] cycles for MarkerRef["+MarkerRef+"]")
		endIf
	endIf
	; Disable movement
	if IsPlayer
		int CameraState = Game.GetCameraState()
		Log("- CameraState: "+CameraState, "LockActor()")
		if CameraState < 8 && CameraState != 3
	;	if Game.GetCameraState() < 8 && Game.GetCameraState() != 3
			Game.ForceThirdPerson()
		endIf
		bool CanActivate = Game.IsActivateControlsEnabled()
		Game.DisablePlayerControls(false, false, true, false, false, false, CanActivate, false, 0)
		; abMovement = true, abFighting = true, abCamSwitch = false, abLooking = false, abSneaking = false, abMenu = true, abActivate = true, abJournalTabs = false, aiDisablePOVType = 0
		if !Config.HasSLSO ;SLSO: SexLab disables UI and SLSO don't.
			Game.DisablePlayerControls(true, true, true, false, false, false, false, false, 0)
		endIf
		Game.SetPlayerAIDriven()
		Game.EnablePlayerControls(false, false, false, false, false, false, CanActivate, false, 0)
		; Enable hotkeys if needed, and disable autoadvance if not needed
		if IsVictim && Config.DisablePlayer
			Thread.AutoAdvance = true
		else
			Thread.AutoAdvance = Config.AutoAdvance
			Thread.EnableHotkeys()
		endIf
	else ; ToDo: Find a way to fix the rotation issue of some the dead actors to be able to avoid resurrect them with this.
	;	If !ActorRef.IsDead()
			ActorRef.SetDontMove(true)
			ActorRef.SetRestrained(true)
	;	endIf
	endIf
	Loc[0] = ActorRef.GetPositionX()
	Loc[1] = ActorRef.GetPositionY()
	Loc[2] = ActorRef.GetPositionZ()
	Loc[3] = ActorRef.GetAngleX()
	Loc[4] = ActorRef.GetAngleY()
	Loc[5] = ActorRef.GetAngleZ()
	ObjectReference CenterRef = Thread.CenterAlias.GetReference()
	if CenterRef != none
		; Move if actor out of cell
		if CenterRef != ActorRef as ObjectReference
			if ActorRef.GetDistance(CenterRef) > 3000
				
				Loc[0] = Thread.CenterLocation[0] ; One by one to avoid issues with the arrays
				Loc[1] = Thread.CenterLocation[1]
				Loc[2] = Thread.CenterLocation[2]
				Loc[3] = Thread.CenterLocation[3]
				Loc[4] = Thread.CenterLocation[4]
				Loc[5] = Thread.CenterLocation[5]
				
				ActorRef.StopTranslation() ; StopTranslation as side effect allow the actor move by the collisions but is required to stop any previous Translation and avoid the OnTranslationComplete.
				ActorRef.MoveTo(CenterRef)
				ActorRef.TranslateTo(Loc[0], Loc[1], Loc[2], Loc[3], Loc[4], Loc[5], 50000, 0.0)
			endIf
		endIf
		Log(ActorName +"-CenterRef- Angle:[X:"+CenterRef.GetAngleX()+"Y:"+CenterRef.GetAngleY()+"Z:"+CenterRef.GetAngleZ()+"] Position:[X:"+CenterRef.GetPositionX()+"Y:"+CenterRef.GetPositionY()+"Z:"+CenterRef.GetPositionZ()+"]", "LockActor()")
	endIf
	MarkerRef.MoveTo(ActorRef)
	MarkerRef.Enable()
	AttachMarker()
	; Begin very slowly rotating a small amount to hold position
	if !IsInPosition(ActorRef, MarkerRef, 2.0)
		ActorRef.StopTranslation() ; StopTranslation as side effect allow the actor move by the collisions but is required to stop any previous Translation and avoid the OnTranslationComplete.
		ActorRef.TranslateTo(Loc[0], Loc[1], Loc[2], Loc[3], Loc[4], Loc[5], 50000, 0.0)
	endIf
	Log(ActorName +"-MarkerRef- Angle:[X:"+MarkerRef.GetAngleX()+"Y:"+MarkerRef.GetAngleY()+"Z:"+MarkerRef.GetAngleZ()+"] Position:[X:"+MarkerRef.GetPositionX()+"Y:"+MarkerRef.GetPositionY()+"Z:"+MarkerRef.GetPositionZ()+"]", "LockActor()")
	Log(ActorName +"-ActorRef- Angle:[X:"+ActorRef.GetAngleX()+"Y:"+ActorRef.GetAngleY()+"Z:"+ActorRef.GetAngleZ()+"] Position:[X:"+ActorRef.GetPositionX()+"Y:"+ActorRef.GetPositionY()+"Z:"+ActorRef.GetPositionZ()+"]", "LockActor()")
endFunction

function UnlockActor()
	if !ActorRef
		Log(ActorName +"- WARNING: ActorRef if Missing or Invalid", "UnlockActor()")
		return
	endIf
	; Remove from animation faction
	ActorRef.RemoveFromFaction(AnimatingFaction)
	ActorUtil.RemovePackageOverride(ActorRef, Config.DoNothing)
	ActorRef.SetFactionRank(AnimatingFaction, 0)
	ActorRef.EvaluatePackage()
	If SKSE.GetPluginVersion("Precision") >= 2000000
		Precision_Utility.ToggleDisableActor(ActorRef, false)
	endIf
	; Detach positioning marker
	ActorRef.SetVehicle(none)
	if ActorRef.Is3DLoaded() && (!IsPlayer || Game.GetCameraState() > 3)
		ActorRef.SetAnimationVariableBool("bHumanoidFootIKDisable", False)
	endIf
	MarkerRef && MarkerRef.Disable()
	ActorRef.StopTranslation()
	; Enable movement
	if IsPlayer
		Thread.RemoveFade()
		Thread.DisableHotkeys()
		MiscUtil.SetFreeCameraState(false)
		if Config.HasUtilityPlus && !Thread.FastEnd && FurnitureRef != none
			Thread.SetFurnitureIgnored(false)
			ActorUtil.AddPackageOverride(ActorRef, Thread.UseFurniturePackage, 100, 1)
			ActorRef.EvaluatePackage()
			Utility.Wait(2.0)
		endIf
		Game.EnablePlayerControls(true, true, true, false, false, false, false, false, 0)
		Game.SetPlayerAIDriven(false)
	else
	;	If !ActorRef.IsDead()
			ActorRef.SetRestrained(false)
			ActorRef.SetDontMove(false)
	;	endIf
		if Config.HasUtilityPlus && !Thread.FastEnd && FurnitureRef != none
			Thread.SetFurnitureIgnored(false)
			ActorUtil.AddPackageOverride(ActorRef, Thread.UseFurniturePackage, 100, 1)
			ActorRef.EvaluatePackage()
			Utility.Wait(2.0)
		endIf
	endIf
	MarkerRef && Log(ActorName +"-MarkerRef- Angle:[X:"+MarkerRef.GetAngleX()+"Y:"+MarkerRef.GetAngleY()+"Z:"+MarkerRef.GetAngleZ()+"] Position:[X:"+MarkerRef.GetPositionX()+"Y:"+MarkerRef.GetPositionY()+"Z:"+MarkerRef.GetPositionZ()+"]", "UnlockActor()")
	Log(ActorName +"-ActorRef- Angle:[X:"+ActorRef.GetAngleX()+"Y:"+ActorRef.GetAngleY()+"Z:"+ActorRef.GetAngleZ()+"] Position:[X:"+ActorRef.GetPositionX()+"Y:"+ActorRef.GetPositionY()+"Z:"+ActorRef.GetPositionZ()+"]", "UnlockActor()")
endFunction

function RestoreActorDefaults()
	; Make sure  have actor, can't afford to miss this block
	if !ActorRef
		ActorRef = GetReference() as Actor
		if !ActorRef
			Log(ActorName +"- WARNING: ActorRef if Missing or Invalid", "RestoreActorDefaults()")
			return ; No actor, reset prematurely or bad call to alias
		endIf
	endIf	
	; Reset to starting scale
	if UseScale && ActorScale > 0.0 && (ActorScale != 1.0 || AnimScale != 1.0)
		ActorRef.SetScale(ActorScale)
	endIf
	if !IsCreature
		; Reset voicetype
		; if ActorVoice && ActorVoice != BaseRef.GetVoiceType()
		; 	BaseRef.SetVoiceType(ActorVoice)
		; endIf
		; Remove strapon
		if Strapon && !HadStrapon; && Strapon != HadStrapon
			ActorRef.RemoveItem(Strapon, 1, true)
		endIf
		; Reset expression
		if ActorRef.Is3DLoaded() && !(ActorRef.IsDisabled() || ActorRef.IsDead() || ActorRef.GetActorValue("Health") <= 1.0)
			if Expression
				sslBaseExpression.UnequipWornFaceItem(ActorRef, Expression)
				sslBaseExpression.CloseMouth(ActorRef)
			elseIf sslBaseExpression.IsMouthOpen(ActorRef)
				Log("IsMouthOpen("+ActorRef+") - TRUE")
				sslBaseExpression.CloseMouth(ActorRef)			
			endIf
			ActorRef.ClearExpressionOverride()
			ActorRef.ResetExpressionOverrides()
			sslBaseExpression.ClearMFG(ActorRef)
		endIf
	endIf
	; Player specific actions
	if IsPlayer
		; Remove player from frostfall exposure exception
		FormList FrostExceptions = Config.FrostExceptions
		if FrostExceptions
			FrostExceptions.RemoveAddedForm(Config.BaseMarker)
		endIf
		Thread.RemoveFade()
	endIf
	; Remove SOS erection
	Debug.SendAnimationEvent(ActorRef, "SOSFlaccid")
	; Clear from animating faction
	ActorRef.SetFactionRank(AnimatingFaction, -1)
	ActorRef.RemoveFromFaction(AnimatingFaction)
	ActorUtil.RemovePackageOverride(ActorRef, Config.DoNothing)
	if Config.HasUtilityPlus
		ActorUtil.RemovePackageOverride(ActorRef, Thread.UseFurniturePackage)
	endIf
	ActorRef.EvaluatePackage()
;	Log(ActorName +"- Angle:[X:"+ActorRef.GetAngleX()+"Y:"+ActorRef.GetAngleY()+"Z:"+ActorRef.GetAngleZ()+"] Position:[X:"+ActorRef.GetPositionX()+"Y:"+ActorRef.GetPositionY()+"Z:"+ActorRef.GetPositionZ()+"]", "RestoreActorDefaults()")
endFunction

function RefreshActor()
endFunction

; ------------------------------------------------------- ;
; --- Data Accessors                                  --- ;
; ------------------------------------------------------- ;

int function GetGender()
	return Gender
endFunction

bool function GetIsFuta()
	return IsFuta
endFunction

function SetFurnitureRef(ObjectReference akFurniture, bool Restrictive = true)
	FurnitureRef = akFurniture
	if FurnitureRef != none
		NoUndress = Restrictive
		NoRedress = Restrictive
		Restricted = Restrictive
	endif
endFunction

ObjectReference function GetFurnitureRef()
	return FurnitureRef
endFunction

Bool function SetRestricted(bool value=true)
	NoUndress = value
	NoRedress = value
	if Restricted != value
		Restricted = value
		return true
	endIf
	return false
endFunction

bool function GetRestricted()
	return Restricted
endFunction

function SetVictim(bool Victimize)
	Actor[] Victims = Thread.Victims
	; Make victim
	if Victimize && (!Victims || Victims.Find(ActorRef) == -1)
		Victims = PapyrusUtil.PushActor(Victims, ActorRef)
		Thread.Victims = Victims
		Thread.IsAggressive = true
	; Was victim but now isn't, update thread
	elseIf IsVictim && !Victimize
		Victims = PapyrusUtil.RemoveActor(Victims, ActorRef)
		Thread.Victims = Victims
		if !Victims || Victims.Length < 1
			Thread.IsAggressive = false
		endIf
	endIf
	IsVictim = Victimize
endFunction

bool function IsVictim()
	return IsVictim
endFunction

string function GetActorKey()
	return ActorKey
endFunction

function SetAdjustKey(string KeyVar)
	if ActorRef
		AdjustKey = KeyVar
		Position  = Thread.Positions.Find(ActorRef)
	endIf
endfunction

function AdjustEnjoyment(int AdjustBy)
	BaseEnjoyment += AdjustBy
endfunction

int function GetEnjoyment()
;	Log(ActorName +"- RealTime:["+Utility.GetCurrentRealTime()+"], GameTime:["+SexLabUtil.GetCurrentGameRealTime()+"] IsMenuMode:"+Utility.IsInMenuMode(), "GetEnjoyment()")
	if Config.HasSLSO
		return SLSO_GetEnjoyment()
	endIf
	if !ActorRef
		Log(ActorName +"- WARNING: ActorRef if Missing or Invalid", "GetEnjoyment()")
		FullEnjoyment = 0
		return 0
	elseif !IsSkilled
		FullEnjoyment = BaseEnjoyment + (PapyrusUtil.ClampFloat(((RealTime[0] - StartedAt) + 1.0) / 5.0, 0.0, 40.0) + ((Stage as float / StageCount as float) * 60.0)) as int
	else
		if Position == 0
			Thread.RecordSkills()
			Thread.SetBonuses()
		endIf
		FullEnjoyment = BaseEnjoyment + CalcEnjoyment(SkillBonus, Skills, LeadIn, IsFemale, (RealTime[0] - StartedAt), Stage, StageCount)
		; Log("FullEnjoyment["+FullEnjoyment+"] / BaseEnjoyment["+BaseEnjoyment+"] / Enjoyment["+(FullEnjoyment - BaseEnjoyment)+"]")
	endIf

	int Enjoyment = FullEnjoyment - QuitEnjoyment
	if Enjoyment > 0
		return Enjoyment
	endIf
	return 0
endFunction

int function GetPain()
	if !ActorRef
		Log(ActorName +"- WARNING: ActorRef if Missing or Invalid", "GetPain()")
		return 0
	endIf
	GetEnjoyment()
	if FullEnjoyment < 0
		return Math.Abs(FullEnjoyment) as int
	endIf
	return 0	
endFunction

int function CalcReaction()
	if !ActorRef
		Log(ActorName +"- WARNING: ActorRef if Missing or Invalid", "CalcReaction()")
		return 0
	endIf
	int Strength
	if !Config.HasSLSO
		Strength = GetEnjoyment()
		; Check if the actor is in pain or too excited to care about pain
		if FullEnjoyment < 0 && Strength < Math.Abs(FullEnjoyment)
			Strength = FullEnjoyment
		endIf
	else
		Strength = CalculateFullEnjoyment()
	endIf
	return PapyrusUtil.ClampInt(Math.Abs(Strength) as int, 0, 100)
endFunction

function ApplyCum()
	if ActorRef && ActorRef.Is3DLoaded()
		Cell ParentCell = ActorRef.GetParentCell()
		int CumID = Animation.GetCumID(Position, Stage)
		if CumID > 0 && ParentCell && ParentCell.IsAttached() ; Error treatment for Spells out of Cell
			ActorLib.ApplyCum(ActorRef, CumID)
		endIf
	endIf
endFunction

function DisableOrgasm(bool bNoOrgasm)
	if ActorRef
		NoOrgasm = bNoOrgasm
	endIf
endFunction

bool function IsOrgasmAllowed()
	return !NoOrgasm && !Thread.DisableOrgasms
endFunction

bool function NeedsOrgasm()
	return GetEnjoyment() >= 100 && FullEnjoyment >= 100
endFunction

function SetVoice(sslBaseVoice ToVoice = none, bool ForceSilence = false)
	IsForcedSilent = ForceSilence
	if ToVoice && IsCreature == ToVoice.Creature
		Voice = ToVoice
	endIf
endFunction

sslBaseVoice function GetVoice()
	return Voice
endFunction

function SetExpression(sslBaseExpression ToExpression)
	if ToExpression
		sslBaseExpression oldExpression = Expression
		Expression = ToExpression
		if oldExpression != Expression
			sslBaseExpression.UnequipWornFaceItem(ActorRef, oldExpression, Expression)
			RefreshExpression()
		endIf
	endIf
endFunction

sslBaseExpression function GetExpression()
	return Expression
endFunction

function SetOpenMouthScale(float ToScale = 1.0)
	OpenMouthScale = PapyrusUtil.ClampFloat(ToScale, 0.1, 2.0)
	Log("OpenMouthScale:"+OpenMouthScale, "SetOpenMouthScale("+ToScale+")")
endFunction

float function GetOpenMouthScale()
	return OpenMouthScale
endFunction

function SetStartAnimationEvent(string EventName, float PlayTime)
	StartAnimEvent = EventName
	StartWait = PapyrusUtil.ClampFloat(PlayTime, 0.1, 10.0)
endFunction

function SetEndAnimationEvent(string EventName)
	EndAnimEvent = EventName
endFunction

bool function IsUsingStrapon()
	return Strapon && ActorRef.IsEquipped(Strapon)
endFunction

function ResolveStrapon(bool force = false)
	if Strapon
		if UseStrapon && !ActorRef.IsEquipped(Strapon)
			ActorRef.EquipItem(Strapon, true, true)
		elseIf !UseStrapon && ActorRef.IsEquipped(Strapon)
			ActorRef.UnequipItem(Strapon, true, true)
		endIf
	endIf
endFunction

function EquipStrapon()
	if Strapon && !ActorRef.IsEquipped(Strapon)
		ActorRef.EquipItem(Strapon, true, true)
	endIf
endFunction

function UnequipStrapon()
	if Strapon && ActorRef.IsEquipped(Strapon)
		ActorRef.UnequipItem(Strapon, true, true)
	endIf
endFunction

function SetStrapon(Form ToStrapon)
	if Strapon && !HadStrapon && Strapon != ToStrapon
		ActorRef.RemoveItem(Strapon, 1, true)
	endIf
	Strapon = ToStrapon
;	if GetState() == "Animating"
;		SyncThread()
;	endIf
endFunction

Form function GetStrapon()
	return Strapon
endFunction

bool function PregnancyRisk()
	int cumID = Animation.GetCumID(Position, Stage)
	return cumID > 0 && (cumID == 1 || cumID == 4 || cumID == 5 || cumID == 7) && IsFemale && !MalePosition && Thread.IsVaginal
endFunction

function OverrideStrip(bool[] SetStrip)
	if SetStrip.Length != 33
		Thread.Log("Invalid strip override bool[] - Must be length 33 - was "+SetStrip.Length, "OverrideStrip()")
	else
		StripOverride = SetStrip
	endIf
endFunction

bool function ContinueStrip(Form ItemRef, bool DoStrip = true)
	if !ItemRef
		return False
	endIf
	if StorageUtil.FormListHas(none, "AlwaysStrip", ItemRef) || SexLabUtil.HasKeywordSub(ItemRef, "AlwaysStrip")
		if StorageUtil.GetIntValue(ItemRef, "SometimesStrip", 100) < 100
			if !DoStrip
				return (StorageUtil.GetIntValue(ItemRef, "SometimesStrip", 100) >= Utility.RandomInt(76, 100))
			endIf
			return (StorageUtil.GetIntValue(ItemRef, "SometimesStrip", 100) >= Utility.RandomInt(1, 100))
		endIf
		return True
	endIf
	return (DoStrip && !(StorageUtil.FormListHas(none, "NoStrip", ItemRef) || SexLabUtil.HasKeywordSub(ItemRef, "NoStrip")))
endFunction

event OnActorStrip(form akTarget)
	if akTarget && akTarget == ActorRef as form
		Log("OnActorStrip("+akTarget+")")
		Strip()
	endIf
endEvent

event OnActorRefreshExpression(form akTarget)
	if akTarget && akTarget == ActorRef as form
		Log("OnActorRefreshExpression("+akTarget+")")
		RefreshExpression()
	endIf
endEvent

; Event received when this actor equips something - akReference may be None if object is not persistent
Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	if akBaseObject && akBaseObject.GetType() == 26
		Armor akBaseArmor = akBaseObject as Armor
		If akBaseArmor
			if Config.RemoveHeelEffect && Math.LogicalAnd(akBaseArmor.GetSlotMask(), 0x00000080) == 0x00000080
				HDTHeelSpell = Config.GetHDTSpell(ActorRef)
				if HDTHeelSpell
					Log(HDTHeelSpell, "RemoveHeelEffect (HDTHeelSpell)")
					ActorRef.RemoveSpell(HDTHeelSpell)
				endIf
				UpdateNiOHeelEffect(True)
				
			elseIf Strapon 
				If (Strapon == akBaseObject || Math.LogicalAnd(akBaseArmor.GetSlotMask(), (Strapon as armor).GetSlotMask()) != 0)
					Debug.SendAnimationEvent(ActorRef, "SOSFastErect")
					if GetState() == "Animating"
						Utility.Wait(0.2)
						Debug.SendAnimationEvent(ActorRef, "SOSBend"+Schlong)
					endIf
				endIf
				
			Else
				Form SomeStrapon = Config.GetStrapon()
				If SomeStrapon && (SomeStrapon == akBaseObject || Math.LogicalAnd(akBaseArmor.GetSlotMask(), (SomeStrapon as armor).GetSlotMask()) != 0)
					Debug.SendAnimationEvent(ActorRef, "SOSFastErect")
					if GetState() == "Animating"
						Utility.Wait(0.2)
						Debug.SendAnimationEvent(ActorRef, "SOSBend"+Schlong)
					endIf
				endIf
				
			endIf
		endIf
	endIf
EndEvent

; Event received when this actor unequips something - akReference may be None if object is not persistent
Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	if !IsStripping && Config.RemoveHeelEffect && akBaseObject && akBaseObject.GetType() == 26
		Armor akBaseArmor = akBaseObject as Armor
		if akBaseArmor && Math.LogicalAnd(akBaseArmor.GetSlotMask(), 0x00000080) == 0x00000080
			UpdateNiOHeelEffect()
		endIf
	endIf
EndEvent

; Event received when an item is removed from this object's inventory. If the item is a persistant reference, akItemReference
; will point at it - otherwise the parameter will be None
Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	if !IsStripping && Config.RemoveHeelEffect && akBaseItem && akBaseItem.GetType() == 26
		Armor akBaseArmor = akBaseItem as Armor
		if akBaseArmor && Math.LogicalAnd(akBaseArmor.GetSlotMask(), 0x00000080) == 0x00000080
			UpdateNiOHeelEffect()
		endIf
	endIf
EndEvent

bool NiOHeelLock
bool function UpdateNiOHeelEffect(bool Forced = false)
	if Config.HasNiOverride && (Forced || !NiOHeelLock)
		while NiOHeelLock
			Log("NiOHeelLock", "UpdateNiOHeelEffect("+Forced+")")
			Utility.WaitMenuMode(0.2)
		endWhile
		NiOHeelLock = True
	
		; Remove NiOverride High Heels and any other position offset
		float[] NioPos = new float[3]
		string[] MOD_OVERRIDE_KEY = NiOverride.GetNodeTransformKeys(ActorRef, False, isRealFemale, "NPC")
		int idx = 0
		bool UpdateNiOPosition = False
		While idx < MOD_OVERRIDE_KEY.Length
			If NiOverride.HasNodeTransformPosition(ActorRef, false, isRealFemale, "NPC", MOD_OVERRIDE_KEY[idx])
				if MOD_OVERRIDE_KEY[idx] == "SexLab.esm"
					; Remove SexLab Node if present by error
					NiOverride.RemoveNodeTransformPosition(ActorRef, False, isRealFemale, "NPC", MOD_OVERRIDE_KEY[idx])
				else
					float[] KeyPos = NiOverride.GetNodeTransformPosition(ActorRef, False, isRealFemale, "NPC", MOD_OVERRIDE_KEY[idx])
					NioPos[0] = -KeyPos[0]
					NioPos[1] = -KeyPos[1]
					NioPos[2] = -KeyPos[2]
					Log(self, "KeyPos:"+KeyPos+"; MOD_OVERRIDE_KEY:"+MOD_OVERRIDE_KEY[idx])
				endIf
				UpdateNiOPosition = True
			endIf
			idx += 1
		endWhile
		If UpdateNiOPosition
			Log(NioPos, "UpdateNiOHeelEffect("+Forced+")")
			If PapyrusUtil.CountFloat(NioPos, 0.0) != 3
				NiOverride.AddNodeTransformPosition(ActorRef, false, isRealFemale, "NPC", "SexLab.esm", NioPos)
			endIf
			NiOverride.UpdateNodeTransform(ActorRef, false, isRealFemale, "NPC")
		EndIf
		
		NiOHeelLock = False
		return UpdateNiOPosition
	endIf
	return false
endFunction

bool AmmoChecked
bool IsStripping
function Strip()
	if !ActorRef || IsCreature || IsStripping
		return
	endIf
	While IsStripping
		Utility.WaitMenuMode(2.0)
	EndWhile
	IsStripping = True
	; Start stripping animation
	;if DoUndress
	;	Debug.SendAnimationEvent(ActorRef, "Arrok_Undress_G"+BaseSex)
	;	NoUndress = true
	;endIf
	; Select stripping array
	bool[] Strip
	if StripOverride.Length == 33
		Strip = StripOverride
		Strip = PapyrusUtil.PushBool(Strip, Config.GetStrip(IsFemale, Thread.UseLimitedStrip(), IsType[0], IsVictim)[33])
	elseIf	StripOverride.Length == 34
		Strip = StripOverride
	else
		Strip = Config.GetStrip(IsFemale, Thread.UseLimitedStrip(), IsType[0], IsVictim)
	endIf
	Log("Strip: "+Strip)
	; Stripped storage
	Form ItemRef
	Form[] Stripped = new Form[35]
	if ActorRef.IsWeaponDrawn() || IsPlayer
		ActorRef.SheatheWeapon()
	endIf
	; Right hand
	ItemRef = ActorRef.GetEquippedObject(1)
	if ContinueStrip(ItemRef, Strip[32])
		Stripped[33] = ItemRef
		ActorRef.UnequipItemEX(ItemRef, 1, false)
		StorageUtil.SetIntValue(ItemRef, "Hand", 1)
	endIf
	; Left hand
	ItemRef = ActorRef.GetEquippedObject(0)
	if ContinueStrip(ItemRef, Strip[32])
		Stripped[32] = ItemRef
		ActorRef.UnequipItemEX(ItemRef, 2, false)
		StorageUtil.SetIntValue(ItemRef, "Hand", 2) 
	endIf
	; Ammo
	int i
	if Strip.Length > 33 && Strip[33] && !AmmoChecked
		If Config.UseAdvancedFurn && SKSE.GetScriptVersionRelease() >= 64
			ItemRef = PO3_SKSEFunctions.GetEquippedAmmo(ActorRef) as Form
			If ItemRef
				ActorRef.UnequipItem(ItemRef)
			EndIf
		ElseIf IsPlayer && Config.DummyArrow
			ActorRef.AddItem(Config.DummyArrow, 1, true)
			int n = ActorRef.GetItemCount(Config.DummyArrow)
			if n > 0
				ActorRef.EquipItemEx(Config.DummyArrow, 0, false, false)
				Utility.Wait(0.1)
				ActorRef.RemoveItem(Config.DummyArrow, n, true)
			endIf
		else
			i = ActorRef.GetNumItems()
			While i > 0
				i -= 1
				ItemRef = ActorRef.GetNthForm(i)
				bool IsAmmo = ItemRef.GetType() == 42 && (ItemRef as Ammo)
				If IsAmmo && ActorRef.IsEquipped(ItemRef)
				;	if ContinueStrip(ItemRef, Strip[33])
						Stripped[34] = ItemRef
						ActorRef.UnequipItemEX(ItemRef, 0, false)
				;	endIf
					i = 0
				EndIf
			EndWhile
		endIf
		AmmoChecked = true
	endIf
	; Strip armor slots
	Form BodyRef = ActorRef.GetWornForm(Armor.GetMaskForSlot(32))
	i = 31
	while i >= 0
		; Grab item in slot
		ItemRef = ActorRef.GetWornForm(Armor.GetMaskForSlot(i + 30))
		if ContinueStrip(ItemRef, Strip[i])
			; Start stripping animation
			if DoUndress && ItemRef == BodyRef ;Body
				Debug.SendAnimationEvent(ActorRef, "Arrok_Undress_G"+BaseSex)
				Utility.Wait(1.0)
				NoUndress = true
			endIf
			ActorRef.UnequipItemEX(ItemRef, 0, false)
			Stripped[i] = ItemRef
		endIf
		; Move to next slot
		i -= 1
	endWhile
	; Equip the nudesuit
	if Strip[2] && ((Gender == 0 && Config.UseMaleNudeSuit) || (Gender == 1 && Config.UseFemaleNudeSuit))
		ActorRef.EquipItem(Config.NudeSuit, true, true)
	endIf
	; Store stripped items
	Equipment = PapyrusUtil.MergeFormArray(Equipment, PapyrusUtil.ClearNone(Stripped), true)
	Log("Equipment: "+Equipment)
	IsStripping = False

	; Suppress NiOverride High Heels
	if Config.RemoveHeelEffect && ActorRef.GetWornForm(0x00000080)
		UpdateNiOHeelEffect()
	endIf
endFunction

function UnStrip()
 	if !ActorRef || IsCreature || Equipment.Length == 0
 		return
 	endIf
	; Remove nudesuit if present
	int n = ActorRef.GetItemCount(Config.NudeSuit)
	if n > 0
		ActorRef.RemoveItem(Config.NudeSuit, n, true)
	endIf
;/
	form StandardOutfit = StorageUtil.GetFormValue(ActorRef, "Sexlab.StandardOutfit")
	form SleepOutfit = StorageUtil.GetFormValue(ActorRef, "Sexlab.SleepOutfit")
	Log("StandardOutfit:"+StandardOutfit+" SleepOutfit:"+SleepOutfit)
	
	Outfit EmptyOutfit = Game.GetFormFromFile(0x0830, "SexLab UtilityPlus.esp") as Outfit

	if StandardOutfit && BaseRef.GetOutfit(false) == EmptyOutfit
		ActorRef.SetOutfit(StandardOutfit as Outfit, false)
		StorageUtil.UnsetFormValue(ActorRef, "Sexlab.StandardOutfit")
	endIf
	if SleepOutfit && BaseRef.GetOutfit(true) == EmptyOutfit
		ActorRef.SetOutfit(SleepOutfit as Outfit, true) 
		StorageUtil.UnsetFormValue(ActorRef, "Sexlab.SleepOutfit")
	endIf
	Log("StandardOutfit:"+BaseRef.GetOutfit(false)+" SleepOutfit:"+BaseRef.GetOutfit(true))
/;
	; Continue with undress, or am I disabled?
 	if !DoRedress
 		return ; Fuck clothes, bitch.
 	endIf
 	; Equip Stripped
 	int i = Equipment.Length
 	while i
 		i -= 1
 		if Equipment[i]
 			int hand = StorageUtil.GetIntValue(Equipment[i], "Hand", 0)
 			if hand != 0
	 			StorageUtil.UnsetIntValue(Equipment[i], "Hand")
	 		endIf
	 		ActorRef.EquipItemEx(Equipment[i], hand, false)
  		endIf
 	endWhile
endFunction

bool NoRagdoll
bool property DoRagdoll hidden
	bool function get()
		if NoRagdoll
			return false
		endIf
		return !NoRagdoll && Config.RagdollEnd
	endFunction
	function set(bool value)
		NoRagdoll = !value
	endFunction
endProperty

bool NoUndress
bool property DoUndress hidden
	bool function get()
		if NoUndress || GetState() == "Animating"
			return false
		endIf
		return Config.UndressAnimation
	endFunction
	function set(bool value)
		NoUndress = !value
	endFunction
endProperty

bool NoRedress
bool property DoRedress hidden
	bool function get()
		if NoRedress || (IsVictim && !Config.RedressVictim)
			return false
		endIf
		return !IsVictim || (IsVictim && Config.RedressVictim)
	endFunction
	function set(bool value)
		NoRedress = !value
	endFunction
endProperty

int PathingFlag
function ForcePathToCenter(bool forced)
	PathingFlag = (forced as int)
endFunction
function DisablePathToCenter(bool disabling)
	PathingFlag = IntIfElse(disabling, -1, (PathingFlag == 1) as int)
endFunction
bool property DoPathToCenter
	bool function get()
		return (PathingFlag == 0 && Config.DisableTeleport) || PathingFlag == 1
	endFunction
endProperty

event TravelToCenter()
;/	Outfit StandardOutfit = BaseRef.GetOutfit(false)
	Outfit SleepOutfit = BaseRef.GetOutfit(true)
	Log("StandardOutfit:"+StandardOutfit+" SleepOutfit:"+SleepOutfit)
	
	Outfit EmptyOutfit = Game.GetFormFromFile(0x0830, "SexLab UtilityPlus.esp") as Outfit
	
	if StandardOutfit && StandardOutfit.GetNumParts() > 0
		StorageUtil.SetFormValue(ActorRef, "Sexlab.StandardOutfit", StandardOutfit as form)
		ActorRef.SetOutfit(EmptyOutfit, false)
	endIf
	if SleepOutfit && SleepOutfit.GetNumParts() > 0
		StorageUtil.SetFormValue(ActorRef, "Sexlab.SleepOutfit", SleepOutfit as form)
		ActorRef.SetOutfit(EmptyOutfit, true) 
	endIf
	Log("StandardOutfit:"+BaseRef.GetOutfit(false)+" SleepOutfit:"+BaseRef.GetOutfit(true))
/;	
	
	; Remove any unwanted combat effects
	ClearEffects()
	if IsPlayer
		sslThreadController Control = Config.GetThreadControlled()
		if Control && Control != none
			Config.DisableThreadControl(Control)
		endIf
		Game.SetPlayerAIDriven()
	endIf
	ActorRef.SetFactionRank(AnimatingFaction, 1)
	ActorRef.EvaluatePackage()
	; Starting Information
	LoadShares()

	if DoPathToCenter
		PathToCenter()
	endIf
	
	; Remove HDT High Heels
	if Config.RemoveHeelEffect && ActorRef.GetWornForm(0x00000080)
		HDTHeelSpell = Config.GetHDTSpell(ActorRef)
		if HDTHeelSpell
			Log(HDTHeelSpell, "RemoveHeelEffect (HDTHeelSpell)")
			ActorRef.RemoveSpell(HDTHeelSpell)
		endIf
	endIf
	; Start Wait Idle
	StartWaitIdle()
endEvent

float RefreshExpressionDelay
int OldStrength
function RefreshExpression()
	if !ActorRef || IsCreature || !ActorRef.Is3DLoaded() || ActorRef.IsDisabled()
		; Do nothing
	elseIf OpenMouth || StorageUtil.GetIntValue(ActorRef, "Sexlab.ManualMouthOpen", 0) >= 1 || (IsPlayer && StorageUtil.GetIntValue(None, "Sexlab.ManualMouthOpen", 0) >= 1)
		sslBaseExpression.OpenMouthScaled(ActorRef, OpenMouthScale)
		Utility.Wait(1.0)
		if Config.RefreshExpressions && Expression && Expression != none && !ActorRef.IsDead() && !ActorRef.IsUnconscious() && ActorRef.GetActorValue("Health") > 1.0
			int Strength = CalcReaction()
			OldStrength = Strength
			Expression.Apply(ActorRef, Strength, BaseSex)
			IsLipFixed = UseFaceItems && Expression.IsLipFixedPhase(Expression.PickPhase(Strength, BaseSex), BaseSex)
			Log("Expression.Applied("+Expression.Name+") Strength:"+Strength+"; OpenMouth:"+OpenMouth+"; IsLipFixed:"+IsLipFixed)
		endIf
	else
		if Expression && Expression != none && !ActorRef.IsDead() && !ActorRef.IsUnconscious() && ActorRef.GetActorValue("Health") > 1.0
			int Strength = CalcReaction()
			OldStrength = Strength
			If sslBaseExpression.IsMouthOpen(ActorRef)
				Log("IsMouthOpen("+ActorRef+") - TRUE")
				sslBaseExpression.UnequipWornFaceItem(ActorRef, Expression)
				sslBaseExpression.CloseMouth(ActorRef)			
			endIf
			Expression.Apply(ActorRef, Strength, BaseSex)
			IsLipFixed = UseFaceItems && Expression.IsLipFixedPhase(Expression.PickPhase(Strength, BaseSex), BaseSex)
			Log("Expression.Applied("+Expression.Name+") Strength:"+Strength+"; OpenMouth:"+OpenMouth+"; IsLipFixed:"+IsLipFixed)
		elseIf sslBaseExpression.IsMouthOpen(ActorRef)
			Log("IsMouthOpen("+ActorRef+") - TRUE")
			sslBaseExpression.CloseMouth(ActorRef)			
		endIf
	endIf
	RefreshExpressionDelay = 0.0
endFunction

; ------------------------------------------------------- ;
; --- Actor Tagging System                            --- ;
; ------------------------------------------------------- ;

string[] ForbiddenTags
string[] RequiredTags
string[] function GetForbiddenTags()
	return PapyrusUtil.ClearEmpty(ForbiddenTags)
endFunction
string[] function GetRequiredTags()
	return PapyrusUtil.ClearEmpty(RequiredTags)
endFunction

bool function HasForbiddenTag(string Tag)
	return Tag != "" && ForbiddenTags.Find(Tag) != -1
endFunction
bool function HasRequiredTag(string Tag)
	return Tag != "" && RequiredTags.Find(Tag) != -1
endFunction

bool function AddForbiddenTag(string Tag)
	if Tag != "" && ForbiddenTags.Find(Tag) == -1
		int i = ForbiddenTags.Find("")
		if i != -1
			ForbiddenTags[i] = Tag
		else
			ForbiddenTags = PapyrusUtil.PushString(ForbiddenTags, Tag)
		endIf
		return true
	endIf
	return false
endFunction
bool function AddRequiredTag(string Tag)
	if Tag != "" && RequiredTags.Find(Tag) == -1
		int i = RequiredTags.Find("")
		if i != -1
			RequiredTags[i] = Tag
		else
			RequiredTags = PapyrusUtil.PushString(RequiredTags, Tag)
		endIf
		return true
	endIf
	return false
endFunction

bool function RemoveForbiddenTag(string Tag)
	if Tag != "" && ForbiddenTags.Find(Tag) != -1
		ForbiddenTags = PapyrusUtil.RemoveString(ForbiddenTags, Tag)
		return true
	endIf
	return false
endFunction
bool function RemoveRequiredTag(string Tag)
	if Tag != "" && RequiredTags.Find(Tag) != -1
		RequiredTags = PapyrusUtil.RemoveString(RequiredTags, Tag)
		return true
	endIf
	return false
endFunction

function AddForbiddenTags(string[] TagList)
	int i = TagList.Length
	while i
		i -= 1
		AddForbiddenTag(TagList[i])
	endWhile
endFunction
function AddRequiredTags(string[] TagList)
	int i = TagList.Length
	while i
		i -= 1
		AddRequiredTag(TagList[i])
	endWhile
endFunction

function SetForbiddenTags(string TagList)
	AddForbiddenTags(PapyrusUtil.StringSplit(TagList))
endFunction
function SetRequiredTags(string TagList)
	AddRequiredTags(PapyrusUtil.StringSplit(TagList))
endFunction

bool function CheckForbiddenTags(string[] CheckTags, bool RequireAll = true, bool Suppress = false)
	; return RequireAll && HasAllTag(CheckTags) || RequireAll && HasAllTag(CheckTags)
	bool Valid = ParseForbiddenTags(CheckTags, RequireAll)
	return (Valid && !Suppress) || (!Valid && Suppress)
endFunction
bool function CheckRequiredTags(string[] CheckTags, bool RequireAll = true, bool Suppress = false)
	; return RequireAll && HasAllTag(CheckTags) || RequireAll && HasAllTag(CheckTags)
	bool Valid = ParseRequiredTags(CheckTags, RequireAll)
	return (Valid && !Suppress) || (!Valid && Suppress)
endFunction

bool function ParseForbiddenTags(string[] TagList, bool RequireAll = true)
	return (RequireAll && HasAllForbiddenTag(TagList)) || (!RequireAll && HasOneForbiddenTag(TagList))
endFunction
bool function ParseRequiredTags(string[] TagList, bool RequireAll = true)
	return (RequireAll && HasAllRequiredTag(TagList)) || (!RequireAll && HasOneRequiredTag(TagList))
endFunction

bool function HasOneForbiddenTag(string[] TagList)
	int i = TagList.Length
	while i
		i -= 1
		if TagList[i] != "" && ForbiddenTags.Find(TagList[i]) != -1
			return true
		endIf
	endWhile
	return false
endFunction
bool function HasOneRequiredTag(string[] TagList)
	int i = TagList.Length
	while i
		i -= 1
		if TagList[i] != "" && RequiredTags.Find(TagList[i]) != -1
			return true
		endIf
	endWhile
	return false
endFunction

bool function HasAllForbiddenTag(string[] TagList)
	int i = TagList.Length
	while i
		i -= 1
		if TagList[i] != "" && ForbiddenTags.Find(TagList[i]) == -1
			return false
		endIf
	endWhile
	return true
endFunction
bool function HasAllRequiredTag(string[] TagList)
	int i = TagList.Length
	while i
		i -= 1
		if TagList[i] != "" && RequiredTags.Find(TagList[i]) == -1
			return false
		endIf
	endWhile
	return true
endFunction

; ------------------------------------------------------- ;
; --- System Use                                      --- ;
; ------------------------------------------------------- ;

function TrackedEvent(string EventName)
	if IsTracked
		Thread.SendTrackedEvent(ActorRef, EventName)
	endif
endFunction

function ClearEffects()
	if IsPlayer && GetState() != "Animating"
		; MiscUtil.SetFreeCameraState(false)
		int CameraState = Game.GetCameraState()
		Log("- CameraState: "+CameraState, "ClearEffects()")
		if CameraState < 8 && CameraState != 3
	;	if Game.GetCameraState() < 8 && Game.GetCameraState() != 3
			Game.ForceThirdPerson()
		endIf
	endIf
	
	Config.UnequipActorFaceItems(ActorRef)
	
	if ActorRef.IsInCombat()
		ActorRef.StopCombat()
	endIf
	if ActorRef.IsWeaponDrawn()
		ActorRef.SheatheWeapon()
	endIf
	if ActorRef.IsSneaking()
		ActorRef.StartSneaking()
	endIf
	ActorRef.ClearKeepOffsetFromActor()
	ActorRef.ClearLookAt()
endFunction

int property kPrepareActor = 0 autoreadonly hidden
int property kSyncActor    = 1 autoreadonly hidden
int property kResetActor   = 2 autoreadonly hidden
int property kRefreshActor = 3 autoreadonly hidden
int property kStartup      = 4 autoreadonly hidden

function RegisterEvents()
	string e = Thread.Key("")
	; Quick Events
	RegisterForModEvent(e+"Animate", "SendAnimation")
	RegisterForModEvent(e+"Orgasm", "OrgasmEffect")
	RegisterForModEvent(e+"TravelToCenter", "TravelToCenter")
	RegisterForModEvent(e+"Strip", "Strip")
	RegisterForModEvent(e+"StripActor", "OnActorStrip")
	RegisterForModEvent(e+"RefreshActorExpression", "OnActorRefreshExpression")
	; Sync Events
	RegisterForModEvent(e+"Prepare", "PrepareActor")
	RegisterForModEvent(e+"Sync", "SyncActor")
	RegisterForModEvent(e+"Reset", "ResetActor")
	RegisterForModEvent(e+"Refresh", "RefreshActor")
	RegisterForModEvent(e+"Startup", "StartAnimating")
endFunction

function ClearEvents()
	UnregisterForUpdate()
	string e = Thread.Key("")
	; Quick Events
	UnregisterForModEvent(e+"Animate")
	UnregisterForModEvent(e+"Orgasm")
	UnregisterForModEvent(e+"TravelToCenter")
	UnregisterForModEvent(e+"Strip")
	UnregisterForModEvent(e+"StripActor")
	UnregisterForModEvent(e+"RefreshActorExpression")
	; Sync Events
	UnregisterForModEvent(e+"Prepare")
	UnregisterForModEvent(e+"Sync")
	UnregisterForModEvent(e+"Reset")
	UnregisterForModEvent(e+"Refresh")
	UnregisterForModEvent(e+"Startup")
endFunction

function Initialize()
	; Clear actor
	if ActorRef && ActorRef != none
		; Stop events
		ClearEvents()
		; RestoreActorDefaults()
		; Remove nudesuit if present
		int n = ActorRef.GetItemCount(Config.NudeSuit)
		if n > 0
			ActorRef.RemoveItem(Config.NudeSuit, n, true)
		endIf
	endIf
	; Delete positioning marker
	if MarkerRef
		MarkerRef.Disable()
		MarkerRef.Delete()
	endIf
	; Forms
	ActorRef       = none
	FurnitureRef   = none
	MarkerRef      = none
	HadStrapon     = none
	Strapon        = none
	HDTHeelSpell   = none
	; Voice
	Voice          = none
	ActorVoice     = none
	IsForcedSilent = false
	; Expression
	Expression     = none
	Expressions    = sslUtility.ExpressionArray(0)
	OpenMouthScale = 1.0
	; Flags
	NoRagdoll      = false
	NoUndress      = false
	NoRedress      = false
	NoOrgasm       = false
	ForceOpenMouth = false
	Restricted     = false
	AmmoChecked    = false ; Temporal to low the stress of strip ammo
	IsStripping    = false ; Temporal to skip the OnObjectUnequipped while stripping
	Prepared       = false
	StartedUp      = false
	; Integers
	Orgasms        = 0
	BestRelation   = 0
	BaseEnjoyment  = 0
	QuitEnjoyment  = 0
	FullEnjoyment  = 0
	PathingFlag    = 0
	; Floats
	LastOrgasm     = 0.0
	ActorScale     = 1.0
	AnimScale      = 1.0
	NioScale       = 1.0
	StartWait      = 0.1
	; Strings
	EndAnimEvent   = "IdleForceDefaultState"
	StartAnimEvent = ""
	ActorKey       = ""
	PlayingSA      = ""
	CurrentSA      = ""
	PlayingAE      = ""
	CurrentAE      = ""
	ForbiddenTags  = Utility.CreateStringArray(0)
	RequiredTags   = Utility.CreateStringArray(0)
	; Storage
	StripOverride  = Utility.CreateBoolArray(0)
	Equipment      = Utility.CreateFormArray(0)
	; Make sure alias is emptied

	;SLU+ ---BEGIN-----------------------------------
	if Config.HasZadDevice
		if !zad_Lockable
			zad_Lockable = Keyword.GetKeyword("zad_Lockable")
		endIf
		if !zad_DeviousYoke
			zad_DeviousYoke = Keyword.GetKeyword("zad_DeviousYoke")
		endIf
		if !zad_DeviousYokeBB
			zad_DeviousYokeBB = Keyword.GetKeyword("zad_DeviousYokeBB")
		endIf
		if !zad_DeviousArmbinder
			zad_DeviousArmbinder = Keyword.GetKeyword("zad_DeviousArmbinder")
		endIf
		if !zad_DeviousArmbinderElbow
			zad_DeviousArmbinderElbow = Keyword.GetKeyword("zad_DeviousArmbinderElbow")
		endIf
		if !zad_DeviousHeavyBondage
			zad_DeviousHeavyBondage = Keyword.GetKeyword("zad_DeviousHeavyBondage")
		endIf
		if !zad_DeviousStraitJacket
			zad_DeviousStraitJacket = Keyword.GetKeyword("zad_DeviousStraitJacket")
		endIf
		if !zad_DeviousBelt
			zad_DeviousBelt = Keyword.GetKeyword("zad_DeviousBelt")
		endIf
		if !zad_DeviousSuit
			zad_DeviousSuit = Keyword.GetKeyword("zad_DeviousSuit")
		endIf
		if !zad_DeviousPlugAnal
			zad_DeviousPlugAnal = Keyword.GetKeyword("zad_DeviousPlugAnal")
		endIf
		if !zad_DeviousPlugVaginal
			zad_DeviousPlugVaginal = Keyword.GetKeyword("zad_DeviousPlugVaginal")
		endIf
		if !zad_PermitAnal
			zad_PermitAnal = Keyword.GetKeyword("zad_PermitAnal")
		endIf
		if !zad_PermitVaginal
			zad_PermitVaginal = Keyword.GetKeyword("zad_PermitVaginal")
		endIf
		if !zad_DeviousGag
			zad_DeviousGag = Keyword.GetKeyword("zad_DeviousGag")
		endIf
		if !zad_DeviousGagPanel
			zad_DeviousGagPanel = Keyword.GetKeyword("zad_DeviousGagPanel")
		endIf
		if !zad_PermitOral
			zad_PermitOral = Keyword.GetKeyword("zad_PermitOral")
		endIf
		if !zad_DeviousBra
			zad_DeviousBra = Keyword.GetKeyword("zad_DeviousBra")
		endIf
		if !zad_DeviousPetSuit
			zad_DeviousPetSuit = Keyword.GetKeyword("zad_DeviousPetSuit")
		endIf
	endIf

	if Config.HasZazDevice
		if !zbfWornDevice
			zbfWornDevice = Keyword.GetKeyword("zbfWornDevice")
		endIf
		if !zbfAnimHandsYoke
			zbfAnimHandsYoke = Keyword.GetKeyword("zbfAnimHandsYoke")
		endIf
		if !zbfAnimHandsArmbinder
			zbfAnimHandsArmbinder = Keyword.GetKeyword("zbfAnimHandsArmbinder")
		endIf
		if !zbfAnimHandsElbows
			zbfAnimHandsElbows = Keyword.GetKeyword("zbfAnimHandsElbows")
		endIf
		if !zbfAnimHandsWrists
			zbfAnimHandsWrists = Keyword.GetKeyword("zbfAnimHandsWrists")
		endIf
		if !zbfWornBelt
			zbfWornBelt = Keyword.GetKeyword("zbfWornBelt")
		endIf
		if !zbfWornPreventAnal
			zbfWornPreventAnal = Keyword.GetKeyword("zbfWornPreventAnal")
		endIf
		if !zbfWornPreventVaginal
			zbfWornPreventVaginal = Keyword.GetKeyword("zbfWornPreventVaginal")
		endIf
		if !zbfWornHood
			zbfWornHood = Keyword.GetKeyword("zbfWornHood")
		endIf
		if !zbfWornGag
			zbfWornGag = Keyword.GetKeyword("zbfWornGag")
		endIf
		if !zbfWornPermitOral
			zbfWornPermitOral = Keyword.GetKeyword("zbfWornPermitOral")
		endIf
		if !zbfWornPreventOral
			zbfWornPreventOral = Keyword.GetKeyword("zbfWornPreventOral")
		endIf
		if !zbfWornBra
			zbfWornBra = Keyword.GetKeyword("zbfWornBra")
		endIf
		if !zbfWornPreventBreast
			zbfWornPreventBreast = Keyword.GetKeyword("zbfWornPreventBreast")
		endIf
	endIf
	;SLU+ ---END------------------------------------

	;SLSO ---BEGIN-----------------------------------
	if Config.HasSLSO
		SLSO_Initialize()
	endIf
	;SLSO ---END------------------------------------
	TryToClear()
endFunction

function Setup()
	; Reset function Libraries - SexLabQuestFramework
	if !Config || !ActorLib || !Stats
		Form SexLabQuestFramework = Game.GetFormFromFile(0xD62, "SexLab.esm")
		if SexLabQuestFramework
			Config   = SexLabQuestFramework as sslSystemConfig
			ActorLib = SexLabQuestFramework as sslActorLibrary
			Stats    = SexLabQuestFramework as sslActorStats
		endIf
	endIf
	PlayerRef = Game.GetPlayer()
	Thread    = GetOwningQuest() as sslThreadController
	OrgasmFX  = Config.OrgasmFX
	DebugMode = Config.DebugMode
	AnimatingFaction = Config.AnimatingFaction
endFunction

function Log(string msg, string src = "")
	msg = "ActorAlias["+ActorName+"] "+src+" - "+msg
	Debug.Trace("SEXLAB - " + msg)
	if DebugMode
		SexLabUtil.PrintConsole(msg)
		Debug.TraceUser("SexLabDebug", msg)
	endIf
endFunction

function PlayLouder(Sound SFX, ObjectReference FromRef, float Volume)
	if SFX && FromRef && FromRef.Is3DLoaded() && Volume > 0.0
		if Volume > 0.5
			Sound.SetInstanceVolume(SFX.Play(FromRef), 1.0)
		else
			Sound.SetInstanceVolume(SFX.Play(FromRef), Volume)
		endIf
	endIf
endFunction

; ------------------------------------------------------- ;
; --- State Restricted                                --- ;
; ------------------------------------------------------- ;

; Ready
function PrepareActor()
endFunction
function PathToCenter()
endFunction
; Animating
function StartAnimating()
endFunction
function SyncActor()
endFunction
function SyncThread()
endFunction
function SyncLocation(bool Force = false)
endFunction
function RefreshLoc()
endFunction
function Snap()
endFunction
event OnTranslationComplete()
endEvent
event OnTranslationFailed()
	Log(GetState(), "OnTranslationFailed()")
endEvent
function OrgasmEffect()
endFunction
function DoOrgasm(bool Forced = false)
endFunction
function OrgasmEffectSLSO(bool Forced = false) ;SLSO
endFunction
event ResetActor()
endEvent
;/ function RefreshActor()
endFunction /;
event OnOrgasm()
	OrgasmEffect()
endEvent
event OrgasmStage()
	OrgasmEffect()
endEvent

function OffsetCoords(float[] Output, float[] CenterCoords, float[] OffsetBy) global native
bool function IsInPosition(Actor CheckActor, ObjectReference CheckMarker, float maxdistance = 30.0) global native
int function CalcEnjoyment(float[] XP, float[] SkillsAmounts, bool IsLeadin, bool IsFemaleActor, float Timer, int OnStage, int MaxStage) global native

int function IntIfElse(bool check, int isTrue, int isFalse)
	if check
		return isTrue
	endIf
	return isFalse
endfunction

; function AdjustCoords(float[] Output, float[] CenterCoords, ) global native
; function AdjustOffset(int i, float amount, bool backwards, bool adjustStage)
; 	Animation.
; endFunction

; function OffsetBed(float[] Output, float[] BedOffsets, float CenterRot) global native

; bool function _SetActor(Actor ProspectRef) native
; function _ApplyExpression(Actor ProspectRef, int[] Presets) global native


; function GetVars()
; 	IntShare = Thread.IntShare
; 	FloatShare = Thread.FloatS1hare
; 	StringShare = Thread.StringShare
; 	BoolShare
; endFunction

; int[] property IntShare auto hidden ; Stage, ActorCount, FurnitureStatus[1]
; float[] property FloatShare auto hidden ; RealTime, StartedAt
; string[] property StringShare auto hidden ; AdjustKey
; bool[] property BoolShare auto hidden ; 
; sslBaseAnimation[] property _Animation auto hidden ; Animation



;SLSO ---BEGIN-----------------------------------

Faction slaArousal
Faction slaExhibitionist
Bool bslaExhibitionist
Bool SLSOGetEnjoymentCheck1
Bool SLSOGetEnjoymentCheck2
Bool EstrusForcedEnjoymentMods
;Int AllowNonAggressorOrgasm
Int slaExhibitionistNPCCount
int BonusEnjoyment
int ActorFullEnjoyment
float sl_enjoymentrate
float MasturbationMod
float slaActorArousalMod
float ExhibitionistMod
float GenderMod
;Keyword zad_DeviousBelt

bool function IsCreature()
	return IsCreature
endFunction

bool function IsAggressor()
	return IsAggressor
endFunction

bool function IsSilent()
	return IsSilent
endFunction

string function GetActorName()
	return ActorName
endFunction

function SLSO_Initialize()
	;SLSO
	; Flags
	EstrusForcedEnjoymentMods = false
	bslaExhibitionist    = false
	; Integers
	BonusEnjoyment      = 0
	ActorFullEnjoyment      = 0
	slaExhibitionistNPCCount      = 0
	; Floats
	MasturbationMod     = 1.0
	slaActorArousalMod  = 1.0
	ExhibitionistMod    = 1.0
	GenderMod     = 1.0
	; Factions
	;slaArousal 	         = None
	;slaExhibitionist     = None
	if Config.HasSLAroused
		if !slaArousal
			slaArousal = Game.GetFormFromFile(0x3FC36, "SexLabAroused.esm") As Faction 
		endIf
		if !slaExhibitionist
			slaExhibitionist = Game.GetFormFromFile(0x713DA, "SexLabAroused.esm") As Faction
		endIf
	endIf
	; Keywords
	;zad_DeviousBelt = None
	Thread.Set_minimum_aggressor_orgasm_Count(-1)
endFunction

;SLSO enjoyment calc
int function GetFullEnjoyment()
	return ActorFullEnjoyment
endFunction

float function GetFullEnjoymentMod()
	return 	100*MasturbationMod/ExhibitionistMod/GenderMod*slaActorArousalMod
endFunction

int function CalculateFullEnjoyment()
	;this can be very script heavy, don't call it unless you absolutely have to, use GetFullEnjoyment()
	int slaActorArousal = 0
	String File = "/SLSO/Config.json"

	if JsonUtil.GetIntValue(File, "sl_sla_arousal") == 2
		if Config.HasSLAroused
			slaActorArousal = ActorRef.GetFactionRank(slaArousal)
		endIf
		if slaActorArousal < 0
			slaActorArousal = 0
		endIf
	endIf
	if JsonUtil.GetIntValue(File, "sl_sla_arousal") == 3
		if Config.HasSLAroused
			slaActorArousalMod = (ActorRef.GetFactionRank(slaArousal) as float) * 2 / 100
		endIf
		if slaActorArousalMod <= 0
			slaActorArousalMod = 1
		endIf
		;set agressor arousal modifier to 100% so we dont get stuck in loop if animation requires aggressor orgasm to finish
	endIf

	; realtime exhibitionism detection, very script heavy
	if !IsCreature
		if JsonUtil.GetIntValue(File, "sl_exhibitionist") == 2
			Cell akTargetCell = ActorRef.GetParentCell()
			int iRef = 0
			slaExhibitionistNPCCount = 0
			while iRef <= akTargetCell.getNumRefs(43) && slaExhibitionistNPCCount < 6 ;GetType() 62-char,44-lvchar,43-npc
				Actor aNPC = akTargetCell.getNthRef(iRef, 43) as Actor
				If aNPC!= none && aNPC.GetDistance(ActorRef) < 1000 && aNPC != ActorRef && aNPC.HasLOS(ActorRef)
					slaExhibitionistNPCCount += 1
				EndIf
				iRef = iRef + 1
			endWhile
			if bslaExhibitionist || OwnSkills[Stats.kLewd] > 5
				slaExhibitionistNPCCount = PapyrusUtil.ClampInt(slaExhibitionistNPCCount, 0, 7)
				;Log("slaExhibitionistNPCCount ["+slaExhibitionistNPCCount+"] FullEnjoyment MOD["+(FullEnjoyment-FullEnjoyment / (3 - 0.4 * slaExhibitionistNPCCount)) as int+"]")
				;ExhibitionistMod = (3 - 0.4 * slaExhibitionistNPCCount)
				ExhibitionistMod =  (1.6 - 0.2 * slaExhibitionistNPCCount)
			elseif slaExhibitionistNPCCount > 1 && !IsAggressor
				;Log("slaExhibitionistNPCCount ["+slaExhibitionistNPCCount+"] FullEnjoyment MOD["+(FullEnjoyment-FullEnjoyment / (1 + 0.2 * slaExhibitionistNPCCount)) as int+"]")
				ExhibitionistMod = (1 + 0.2 * slaExhibitionistNPCCount)
			endif
		endif
	endif
	if IsAggressor && JsonUtil.GetIntValue(File, "condition_aggressor_orgasm") == 1
		if slaActorArousalMod < 1
			slaActorArousalMod = 1
		endIf
		if ExhibitionistMod < 1
			ExhibitionistMod = 1
		endIf
	endIf
	
	int SLSO_FullEnjoyment = GetEnjoyment()
	;Log("SLSO_CalculateFullEnjoyment:")
	;Log("SLSO_FullEnjoyment ["+SLSO_FullEnjoyment+"] SL FullEnjoyment ["+FullEnjoyment+"] BaseEnjoyment["+BaseEnjoyment+"] SLArousal["+slaActorArousal+"]"+"] BonusEnjoyment["+BonusEnjoyment+"]")
	;Log("Modifiers: MasturbationMod["+MasturbationMod+" ExhibitionistMod ["+ExhibitionistMod+"] GenderMod["+GenderMod+"] sl_enjoymentrate["+sl_enjoymentrate+"]"+"] slaActorArousalMod["+slaActorArousalMod+"]")

	SLSO_FullEnjoyment = SLSO_FullEnjoyment + slaActorArousal + BonusEnjoyment

	if  EstrusForcedEnjoymentMods
		ActorFullEnjoyment = (SLSO_FullEnjoyment * JsonUtil.GetFloatValue(File, "sl_estrusforcedenjoyment")) as int
	else
		ActorFullEnjoyment = (SLSO_FullEnjoyment * MasturbationMod / ExhibitionistMod / GenderMod * sl_enjoymentrate * slaActorArousalMod) as int
	endIf
	
	;Log("SLSO_ActorFullEnjoyment with modifiers ["+ActorFullEnjoyment+"] = (SLSO_FullEnjoyment ["+SLSO_FullEnjoyment+"] * Modifiers ["+MasturbationMod / ExhibitionistMod / GenderMod * sl_enjoymentrate * slaActorArousalMod+"])")
	return ActorFullEnjoyment
endFunction

int function SLSO_GetEnjoyment()
	if !ActorRef
		Log(ActorName +"- WARNING: ActorRef if Missing or Invalid", "GetEnjoyment()")
		FullEnjoyment = 0
		return 0
	elseif !IsSkilled
		;run default sexlab enjoyment if: enabled in slso mcm, more than 2 actors, thread has no player or npc_game(), game() disabled
		if SLSOGetEnjoymentCheck1
			if SLSOGetEnjoymentCheck2
				FullEnjoyment = (PapyrusUtil.ClampFloat(((RealTime[0] - StartedAt) + 1.0) / 5.0, 0.0, 40.0) + ((Stage as float / StageCount as float) * 60.0)) as int
			else
				FullEnjoyment = (PapyrusUtil.ClampFloat(((RealTime[0] - StartedAt) + 1.0) / 5.0, 0.0, 40.0)) as int
			endIf
		endIf
	else
		if Position == 0
			Thread.RecordSkills()
			Thread.SetBonuses()
		endIf
		if SLSOGetEnjoymentCheck1
			if SLSOGetEnjoymentCheck2
				FullEnjoyment = BaseEnjoyment + CalcEnjoyment(SkillBonus, Skills, LeadIn, IsFemale, (RealTime[0] - StartedAt), Stage, StageCount)
			else
				FullEnjoyment = BaseEnjoyment + CalcEnjoyment(SkillBonus, Skills, LeadIn, IsFemale, (RealTime[0] - StartedAt), 1, StageCount)
			endIf
			if FullEnjoyment < 0
				FullEnjoyment = 0
			;elseIf FullEnjoyment > 100
			;	FullEnjoyment = 100
			endIf
		endIf
	endIf
	int SLSO_Enjoyment = FullEnjoyment - QuitEnjoyment
	;int SLSO_Enjoyment = FullEnjoyment - BaseEnjoyment
	;Log("SLSO_GetEnjoyment: SLSO_Enjoyment["+SLSO_Enjoyment+"] / FullEnjoyment["+FullEnjoyment+"] / QuitEnjoyment["+QuitEnjoyment+"] / BaseEnjoyment["+BaseEnjoyment+"]")
	if SLSO_Enjoyment > 0
		return SLSO_Enjoyment
	endIf
	return 0
	;return SLSO_Enjoyment - BaseEnjoyment
endFunction

function BonusEnjoyment(actor Ref = none, int fixedvalue = 0)
	if GetState() == "Animating"
		if Ref == none || Ref == ActorRef
			if Ref == none 
				;Log("Ref is none, setting to self")
				Ref = ActorRef
			endif
			
			if fixedvalue != 0
				;reduce enjoyment by fixed value
				if fixedvalue < 0
					BonusEnjoyment += fixedvalue
					
				;increase enjoyment by fixed value
				else
					BonusEnjoyment += fixedvalue
				endif
				
				;Log("change [" +Ref.GetDisplayName()+ "] BonusEnjoyment[" +BonusEnjoyment+ "] by fixed value[" +fixedvalue+ "]")
				
			;increase enjoyment based on arousal
			else
				;Log("change [" +Ref.GetDisplayName()+ "]")
				int slaActorArousal = 0
				String File = "/SLSO/Config.json"
				if JsonUtil.GetIntValue(File, "sl_sla_arousal") == 1
					if slaArousal != none
						slaActorArousal = ActorRef.GetFactionRank(slaArousal)
					endIf
					if slaActorArousal < 0
						slaActorArousal = 0
					endIf
				endIf
				
				slaActorArousal = PapyrusUtil.ClampInt(slaActorArousal/20, 1, 5)
				;Log("change [" +Ref.GetDisplayName()+ "] enjoyment by [" +slaActorArousal+ "] arousal mod")
				if !isRealFemale
					BonusEnjoyment +=slaActorArousal
				elseif JsonUtil.GetIntValue(File, "condition_female_orgasm_bonus") != 1
					BonusEnjoyment +=slaActorArousal
				else
				Log("female [" +Ref.GetDisplayName()+ "] bonus enjoyment [" +GetOrgasmCount()+ "]")
					BonusEnjoyment +=slaActorArousal + GetOrgasmCount()
				endif
			endIf
		
		;increase target enjoyment
		elseif Thread.ActorAlias(Ref) != none
			;Log("change target [" +Ref.GetDisplayName()+ "] enjoyment by [" +fixedvalue+ "]")
			Thread.ActorAlias(Ref).BonusEnjoyment(Ref, fixedvalue)
		endIf
	endIf
endFunction

;SLSO orgasm stuff
function Orgasm(float experience = 0.0)
	if experience == -2
		LastOrgasm = Math.Abs(RealTime[0] - 11)
		OrgasmEffectSLSO(true)
	elseif ActorFullEnjoyment >= 90
		if experience == -1
			LastOrgasm = Math.Abs(RealTime[0] - 11)
		endIf
		if Math.Abs(RealTime[0] - LastOrgasm) > 10.0
			OrgasmEffect()
		endIf
	endIf
endFunction

function HoldOut(float experience = 0.0)
	if Position == 0
		if  IsFemale 
			if (Animation.HasTag("Vaginal" || Animation.HasTag("Fisting") || Animation.HasTag("69")))
				LastOrgasm = Math.Abs(RealTime[0] - 8 + OwnSkills[Stats.kVaginal] + experience)
				BonusEnjoyment(ActorRef, (- 1 - OwnSkills[Stats.kVaginal]) as int)
			elseif(Animation.HasTag("Anal") || Animation.HasTag("Fisting"))
				LastOrgasm = Math.Abs(RealTime[0] - 8 + OwnSkills[Stats.kAnal] + experience)
				BonusEnjoyment(ActorRef, (-1 - OwnSkills[Stats.kAnal]) as int)
			else
				LastOrgasm = Math.Abs(RealTime[0] - 8 + experience)
				BonusEnjoyment(ActorRef, -1)
			endIf
		elseif IsMale || IsFuta
			if (Animation.HasTag("Anal") || Animation.HasTag("Fisting"))
				LastOrgasm = Math.Abs(RealTime[0] - 8 + OwnSkills[Stats.kAnal] + experience)
				BonusEnjoyment(ActorRef, (-1 - OwnSkills[Stats.kAnal]) as int)
			else
				LastOrgasm = Math.Abs(RealTime[0] - 8 + experience)
				BonusEnjoyment(ActorRef, -1)
			endIf
		endIf
	elseif Position == 1
		LastOrgasm = Math.Abs(RealTime[0] - 8 + experience)
		BonusEnjoyment(ActorRef, -1)
	endIf
endFunction

int function GetOrgasmCount()
	if !ActorRef
		Orgasms = 0
	endIf
	return Orgasms
endFunction

function SetOrgasmCount(int SetOrgasms = 0)
	if SetOrgasms >=0
		Orgasms = SetOrgasms
	endIf
endFunction

;Sexlab "patching", for interaluse only
int function SLSO_DoOrgasm_Conditions(bool Forced)
	String File = "/SLSO/Config.json"
	if LeadIn && JsonUtil.GetIntValue(File, "condition_leadin_orgasm") == 0
		Log(ActorName + " Orgasm blocked, orgasms disabled at LeadIn/Foreplay Stage")
		return -1
	endIf
	if IsPlayer && (JsonUtil.GetIntValue(File, "condition_player_orgasm") == 0)
		Log("Orgasm blocked, player is forbidden to orgasm")
		return -2
	endIf
	if JsonUtil.GetIntValue(File, "condition_ddbelt_orgasm") == 0
		if zad_DeviousBelt != none
			if ActorRef.WornHasKeyword(zad_DeviousBelt)
				Log("Orgasm blocked, " + ActorName + " has DD belt prevent orgasming")
				return -3
			EndIf
		endIf
	endIf
	if !Animation.HasTag("Estrus")
		if IsVictim
			if JsonUtil.GetIntValue(File, "condition_victim_orgasm") == 0
				Log("Orgasm blocked, " + ActorName + " is victim, victim forbidden to orgasm")
				return -4
			elseif JsonUtil.GetIntValue(File, "condition_victim_orgasm") == 2
				if (OwnSkills[Stats.kLewd]*10) as int < Utility.RandomInt(0, 100)
					Log("Orgasm blocked, " + ActorName + " is victim, victim didn't pass lewd check to orgasm")
					return -5
				endIf
			endIf
		endIf
		if !IsAggressor
			if !(Animation.HasTag("69") || Animation.HasTag("Masturbation")) || Thread.Positions.Length == 2
				if  !IsCreature && BaseRef.GetSex() != Gender || IsFuta
					if  JsonUtil.GetIntValue(File, "condition_futa_orgasm") == 1
						if Position == 0 && !(Animation.HasTag("Vaginal") || Animation.HasTag("Anal") || Animation.HasTag("Cunnilingus") || Animation.HasTag("Fisting") || Animation.HasTag("Lesbian"))
							Log(ActorName + " Orgasm blocked, futa female pos 0, conditions not met, no HasTag(Vaginal,Anal,Cunnilingus,Fisting)")
							return -11
						elseif Position != 0 && !(Animation.HasTag("Vaginal") || Animation.HasTag("Anal") || Animation.HasTag("Boobjob") || Animation.HasTag("Blowjob") || Animation.HasTag("Handjob") || Animation.HasTag("Footjob"))
							Log(ActorName + " Orgasm blocked, futa male pos > 0, conditions not met, no HasTag(Vaginal,Anal,Boobjob,Blowjob,Handjob,Footjob)")
							return -12
						endIf
					endIf
				elseif IsFemale
					if JsonUtil.GetIntValue(File, "condition_female_orgasm") == 1
						if Position == 0 && !(Animation.HasTag("Vaginal") || Animation.HasTag("Anal") || Animation.HasTag("Cunnilingus") || Animation.HasTag("Fisting") || Animation.HasTag("Lesbian"))
							Log(ActorName + " Orgasm blocked, female pos 0, conditions not met, no HasTag(Vaginal,Anal,Cunnilingus,Fisting)")
							return -6
						endIf
					endIf
				elseif IsMale
					if JsonUtil.GetIntValue(File, "condition_male_orgasm") == 1
						if Position == 0 && !(Animation.HasTag("Anal") || Animation.HasTag("Fisting"))
							Log(ActorName + " Orgasm blocked, male pos 0, conditions not met, no HasTag(Anal,Fisting)")
							return -7
						elseif Position != 0 && !(Animation.HasTag("Vaginal") || Animation.HasTag("Anal") || Animation.HasTag("Boobjob") || Animation.HasTag("Blowjob") || Animation.HasTag("Handjob") || Animation.HasTag("Footjob"))
							Log(ActorName + " Orgasm blocked, male pos > 0, conditions not met, no HasTag(Vaginal,Anal,Boobjob,Blowjob,Handjob,Footjob)")
							return -8
						endIf
					endIf
				endIf
			endIf
		endIf
		if StorageUtil.GetIntValue(ActorRef, "slso_forbid_orgasm") == 1
			Log("Orgasm blocked, " + ActorName + " is forbidden to orgasm (by other mod)")
			return -9
		endIf
	endIf
	if StorageUtil.GetIntValue(ActorRef, "slso_forbid_orgasm") == 1
		int Seid = ModEvent.Create("SexLabOrgasmSeparateDenied")
		if Seid
			ModEvent.PushForm(Seid, ActorRef)
			ModEvent.PushInt(Seid, Thread.tid)
			ModEvent.Send(Seid)
		endif
		Log("Orgasm blocked, " + ActorName + " is forbidden to orgasm")
		return -10
	endIf
	return 0
endFunction

function SLSO_DoOrgasm_Multiorgasm()
	String File = "/SLSO/Config.json"

	if BaseSex == 0
		if JsonUtil.GetIntValue(File, "condition_male_orgasm_penalty") == 1
			;male wont be able to orgasm 2nd time if slso game() and sla disabled
			;Log("male FullEnjoyment MOD["+(FullEnjoyment-FullEnjoyment / (1 + GetOrgasmCount()*2)) as int+"]")
			if (Position == 0 && !(Animation.HasTag("Anal") || Animation.HasTag("Fisting"))) || Position != 0
				if (!IsAggressor || IsPlayer)
					GenderMod = (1 + GetOrgasmCount()*2)
				endif
			endif
		endif
	endif
	;if (Utility.RandomInt(0, 100) > (JsonUtil.GetIntValue(File, "sl_multiorgasmchance") + ((OwnSkills[Stats.kLewd]*10) as int) - 10 * Orgasms)) || BaseSex != 1
	if (Utility.RandomInt(0, 100) > (JsonUtil.GetIntValue(File, "sl_multiorgasmchance") + ((OwnSkills[Stats.kLewd] * JsonUtil.GetIntValue(File, "sl_multiorgasmchance_curve")) as int) - 10 * Orgasms)) || BaseSex != 1
		;orgasm
		LastOrgasm = Math.Abs(RealTime[0])
		; Reset enjoyment build up, if using separate orgasms option
		if IsSkilled
			if IsVictim
				BaseEnjoyment += ((BestRelation - 3) + PapyrusUtil.ClampInt((OwnSkills[Stats.kLewd]-OwnSkills[Stats.kPure]) as int,-6,6)) * Utility.RandomInt(5, 10)
			else
				if IsAggressor
					BaseEnjoyment += (-1*((BestRelation - 4) + PapyrusUtil.ClampInt(((Skills[Stats.kLewd]-Skills[Stats.kPure])-(OwnSkills[Stats.kLewd]-OwnSkills[Stats.kPure])) as int,-6,6))) * Utility.RandomInt(5, 10)
				else
					BaseEnjoyment += (BestRelation + PapyrusUtil.ClampInt((((Skills[Stats.kLewd]+OwnSkills[Stats.kLewd])*0.5)-((Skills[Stats.kPure]+OwnSkills[Stats.kPure])*0.5)) as int,0,6)) * Utility.RandomInt(5, 10)
				endIf
			endIf
		else
			if IsVictim
				BaseEnjoyment += (BestRelation - 3) * Utility.RandomInt(5, 10)
			else
				if IsAggressor
					BaseEnjoyment += (-1*(BestRelation - 4)) * Utility.RandomInt(5, 10)
				else
					BaseEnjoyment += (BestRelation + 3) * Utility.RandomInt(5, 10)
				endIf
			endIf
		endIf
		;reset slso enjoyment build up
		BonusEnjoyment = 0
	else
		;slso multiorgasm for females (rnd + lewdness), reset timer
		LastOrgasm = Math.Abs(RealTime[0] - 9)
	endIf
endFunction

function SLSO_DoOrgasm_SexLabOrgasmSeparate()
	if SeparateOrgasms
		String File = "/SLSO/Config.json"
		if !IsPlayer && (IsAggressor || (!IsAggressor && JsonUtil.GetIntValue(File, "condition_consensual_orgasm") == 1))
			if JsonUtil.GetIntValue(File, "game_enabled") == 1
				if GetOrgasmCount() == Thread.Get_minimum_aggressor_orgasm_Count()
					if Utility.RandomInt(0, 100) < JsonUtil.GetIntValue(File, "condition_chance_minimum_aggressor_orgasm_increase")
						Thread.Set_minimum_aggressor_orgasm_Count(Thread.Get_minimum_aggressor_orgasm_Count() + 1)
						Log("Aggressor - " + ActorName + " increased required orgasms to: " + Thread.Get_minimum_aggressor_orgasm_Count())
					endif
				endif
			endif
		endif
		int Seid = ModEvent.Create("SexLabOrgasmSeparate")
		if Seid
			ModEvent.PushForm(Seid, ActorRef)
			ModEvent.PushInt(Seid, Thread.tid)
			ModEvent.Send(Seid)
		endif
	endif
endFunction

function SLSO_StartAnimating()
	String File = "/SLSO/Config.json"
	BonusEnjoyment = 0
;	if Config.HasSLAroused
;		slaArousal = Game.GetFormFromFile(0x3FC36, "SexLabAroused.esm") As Faction
;	endIf
;	if Config.HasZadDevice
;		zad_DeviousBelt = Game.GetFormFromFile(0x3330, "Devious Devices - Assets.esm") As Keyword
;	endif
	
	bool SLSO_GAME_enabled = (JsonUtil.GetIntValue(File, "game_enabled") == 1 && Thread.HasPlayer) || (JsonUtil.GetIntValue(File, "game_npc_enabled", 0) == 1 && !Thread.HasPlayer)

;GetEnjoyment() condi checks
;to enable default sexlab enjoyment gains if true
	if JsonUtil.GetIntValue(File, "sl_passive_enjoyment") == 1 || !SLSO_GAME_enabled
		SLSOGetEnjoymentCheck1 = true
	else
		SLSOGetEnjoymentCheck1 = false
	endIf
	
	if JsonUtil.GetIntValue(File, "sl_stage_enjoyment") == 1 || !SLSO_GAME_enabled
		SLSOGetEnjoymentCheck2 = true
	else
		SLSOGetEnjoymentCheck2 = false
	endIf

;CalculateFullEnjoyment() checks
	ExhibitionistMod = 1
	bslaExhibitionist = false
	slaExhibitionistNPCCount = 0
	if !IsCreature
	;Check if actor sla exhibitionist
		if Config.HasSLAroused
			if slaExhibitionist != none
				if ActorRef.GetFactionRank(slaExhibitionist) >= 0
					bslaExhibitionist = true
				endif
			endif
		endIf
	;check npcs nearby for exhibitionist modifier
		if JsonUtil.GetIntValue(File, "sl_exhibitionist") == 1
			Cell akTargetCell = ActorRef.GetParentCell()
			int iRef = 0
			while iRef <= akTargetCell.getNumRefs(43) && slaExhibitionistNPCCount < 6 ;GetType() 62-char,44-lvchar,43-npc
				Actor aNPC = akTargetCell.getNthRef(iRef, 43) as Actor
				If aNPC!= none && aNPC.GetDistance(ActorRef) < 1000 && aNPC != ActorRef && aNPC.HasLOS(ActorRef)
					slaExhibitionistNPCCount += 1
				EndIf
				iRef = iRef + 1
			endWhile
		endif
	;apply modifier 
		if JsonUtil.GetIntValue(File, "sl_exhibitionist") > 0
			if bslaExhibitionist || OwnSkills[Stats.kLewd] > 5
				slaExhibitionistNPCCount = PapyrusUtil.ClampInt(slaExhibitionistNPCCount, 0, 7)
				;Log("slaExhibitionistNPCCount ["+slaExhibitionistNPCCount+"] FullEnjoyment MOD["+(FullEnjoyment-FullEnjoyment / (3 - 0.4 * slaExhibitionistNPCCount)) as int+"]")
				;ExhibitionistMod = (3 - 0.4 * slaExhibitionistNPCCount)
				ExhibitionistMod =  (1.6 - 0.2 * slaExhibitionistNPCCount)
			elseif slaExhibitionistNPCCount > 1 && !IsAggressor
				;Log("slaExhibitionistNPCCount ["+slaExhibitionistNPCCount+"] FullEnjoyment MOD["+(FullEnjoyment-FullEnjoyment / (1 + 0.2 * slaExhibitionistNPCCount)) as int+"]")
				ExhibitionistMod = (1 + 0.2 * slaExhibitionistNPCCount)
			endif
		endif
	endif
	
;Estrus, force enjoyment modifiers to 1+
	bool EstrusAnim = false
	if (Animation.HasTag("Estrus") || Animation.HasTag("Machine") || Animation.HasTag("Slime") || Animation.HasTag("Ooze"))
		EstrusAnim = true
	endif
	
	if EstrusAnim && JsonUtil.GetFloatValue(File, "sl_estrusforcedenjoyment") > 0
		EstrusForcedEnjoymentMods = true
	endif
	
;apply masturbation modifier 
	MasturbationMod = 1
	if Thread.ActorCount == 1 && JsonUtil.GetIntValue(File, "sl_masturbation") == 1

		;Log("masturbation_penalty FullEnjoyment MOD["+(FullEnjoyment-FullEnjoyment * (1 - 1 * (OwnSkills[Stats.kLewd]) / 10)) as int+"]")
		;Estrus, increase enjoyment with lewdness
		if EstrusAnim == true
			MasturbationMod = 1 + 1 * (OwnSkills[Stats.kLewd]) / 10
		;normal, reduce enjoyment with lewdness
		else
			MasturbationMod = 1 - 1 * (OwnSkills[Stats.kLewd]) / 10
		endif
		MasturbationMod = PapyrusUtil.ClampFloat(MasturbationMod, 0.1, 2.0)
	endif

;apply arousal modifier, 1=100%
	slaActorArousalMod = 1

;apply gender modifier 
	GenderMod = 1
	if !isRealFemale
		sl_enjoymentrate = JsonUtil.GetFloatValue(File, "sl_enjoymentrate_male", missing = 1)
		if JsonUtil.GetIntValue(File, "condition_male_orgasm_penalty") == 1
			;male wont be able to orgasm 2nd time if slso game() and sla disabled
			;Log("male FullEnjoyment MOD["+(FullEnjoyment-FullEnjoyment / (1 + GetOrgasmCount()*2)) as int+"]")
			
			;can probably be broken(not refreshed) by manually changing position/animation
			; probably no one will notice so w/e
			if (Position == 0 && !(Animation.HasTag("Anal") || Animation.HasTag("Fisting"))) || Position != 0
				GenderMod = (1 + GetOrgasmCount()*2)
			endif
		endif
	else
		sl_enjoymentrate = JsonUtil.GetFloatValue(File, "sl_enjoymentrate_female", missing = 1)
	endif
		
	;OrgasmEffect() Orgasm condi checks
	;check if non aggressor actor meets orgasm conditions
	;can probably be broken by manually changing position/animation
	;perfomance decrease probably not worth it 
;		AllowNonAggressorOrgasm = 0
;		if !IsAggressor
;			if !(Animation.HasTag("69") || Animation.HasTag("Masturbation")) || Thread.Positions.Length == 2
;				if  IsFemale && JsonUtil.GetIntValue(File, "condition_female_orgasm") == 1
;					if Position == 0 && !(Animation.HasTag("Vaginal") || Animation.HasTag("Anal") || Animation.HasTag("Cunnilingus") || Animation.HasTag("Fisting") || Animation.HasTag("Lesbian"))
;						AllowNonAggressorOrgasm = 1
;					endIf
;				elseif IsMale && JsonUtil.GetIntValue(File, "condition_male_orgasm") == 1
;					if Position == 0 && !(Animation.HasTag("Anal") || Animation.HasTag("Fisting"))
;						AllowNonAggressorOrgasm = 2
;					elseif Position != 0 && && !(Animation.HasTag("Vaginal") || Animation.HasTag("Anal") || Animation.HasTag("Boobjob") || Animation.HasTag("Blowjob") || Animation.HasTag("Handjob") || Animation.HasTag("Footjob"))
;						AllowNonAggressorOrgasm = 3
;					endIf
;				endIf
;			endIf
;		endIf
endFunction

Function SLSO_Animating_Moan()
	String File = "/SLSO/Config.json"
	if !IsSilent
		if !IsFemale
			Voice.PlayMoan(ActorRef, PapyrusUtil.ClampInt(Math.Abs(ActorFullEnjoyment) as int, 0, 100), IsVictim, UseLipSync && !IsLipFixed)
			Log("PlayMoan:True; UseLipSync:"+UseLipSync+"; OpenMouth:"+OpenMouth+"; VoiceDelay:"+VoiceDelay+"; LoopDelay:"+LoopDelay)
			;Log("  !IsFemale " + ActorName)
		elseif ((JsonUtil.GetIntValue(File, "sl_voice_player") == 0 && IsPlayer) || (JsonUtil.GetIntValue(File, "sl_voice_npc") == 0 && !IsPlayer))
			Voice.PlayMoan(ActorRef, PapyrusUtil.ClampInt(Math.Abs(ActorFullEnjoyment) as int, 0, 100), IsVictim, UseLipSync && !IsLipFixed)
			Log("PlayMoan:True; UseLipSync:"+UseLipSync+"; OpenMouth:"+OpenMouth+"; VoiceDelay:"+VoiceDelay+"; LoopDelay:"+LoopDelay)
			;Log("  IsFemale " + ActorName)
		endIf
	endIf
endFunction

Function SLSO_DoOrgasm_Moan()
	String File = "/SLSO/Config.json"
	if !IsSilent
		if !IsFemale
			PlayLouder(Voice.GetSound(100, false), ActorRef, Config.VoiceVolume)
		;replace SL actor voice with SLSO, if voice options enabled in SLSO
		elseif ((JsonUtil.GetIntValue(File, "sl_voice_player") == 0 && IsPlayer) || (JsonUtil.GetIntValue(File, "sl_voice_npc") == 0 && !IsPlayer))
			PlayLouder(Voice.GetSound(100, false), ActorRef, Config.VoiceVolume)
		endIf
	endIf
	PlayLouder(OrgasmFX, MarkerRef, Config.SFXVolume)
endFunction

