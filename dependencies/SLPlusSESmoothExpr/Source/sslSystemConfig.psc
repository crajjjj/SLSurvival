scriptname sslSystemConfig extends sslSystemLibrary

; ------------------------------------------------------- ;
; --- System Resources                                --- ;
; ------------------------------------------------------- ;

SexLabFramework property SexLab auto

int function GetVersion()
	return SexLabUtil.GetVersion()
endFunction

string function GetStringVer()
	return SexLabUtil.GetStringVer()
endFunction

bool property Enabled hidden
	bool function get()
		return SexLab.Enabled
	endFunction
endProperty

; bool property InDebugMode auto hidden
bool property DebugMode hidden
	bool function get()
		return InDebugMode
	endFunction
	function set(bool value)
		InDebugMode = value
		if InDebugMode
			Debug.OpenUserLog("SexLabDebug")
			Debug.TraceUser("SexLabDebug", "SexLab Debug/Development Mode Deactivated")
			MiscUtil.PrintConsole("SexLab Debug/Development Mode Activated")
			if PlayerRef && PlayerRef != none
				PlayerRef.AddSpell((Game.GetFormFromFile(0x073CC, "SexLab.esm") as Spell))
				PlayerRef.AddSpell((Game.GetFormFromFile(0x5FE9B, "SexLab.esm") as Spell))
			endIf				
		else
			if Debug.TraceUser("SexLabDebug", "SexLab Debug/Development Mode Deactivated")
				Debug.CloseUserLog("SexLabDebug")
			endIf
			MiscUtil.PrintConsole("SexLab Debug/Development Mode Deactivated")
			if PlayerRef && PlayerRef != none
				PlayerRef.RemoveSpell((Game.GetFormFromFile(0x073CC, "SexLab.esm") as Spell))
				PlayerRef.RemoveSpell((Game.GetFormFromFile(0x5FE9B, "SexLab.esm") as Spell))
			endIf				
		endIf
		int eid = ModEvent.Create("SexLabDebugMode")
		ModEvent.PushBool(eid, value)
		ModEvent.Send(eid)
	endFunction
endProperty


Faction property AnimatingFaction auto
Faction property GenderFaction auto
Faction property ForbiddenFaction auto
Weapon property DummyWeapon auto
Ammo property DummyArrow auto
Armor property NudeSuit auto
Armor property CalypsStrapon auto
Form[] property Strapons auto hidden

Form property CircleOfIntimacy auto hidden

Spell property SelectedSpell auto

Spell property CumVaginalOralAnalSpell auto
Spell property CumOralAnalSpell auto
Spell property CumVaginalOralSpell auto
Spell property CumVaginalAnalSpell auto
Spell property CumVaginalSpell auto
Spell property CumOralSpell auto
Spell property CumAnalSpell auto

Spell property Vaginal1Oral1Anal1 auto
Spell property Vaginal2Oral1Anal1 auto
Spell property Vaginal2Oral2Anal1 auto
Spell property Vaginal2Oral1Anal2 auto
Spell property Vaginal1Oral2Anal1 auto
Spell property Vaginal1Oral2Anal2 auto
Spell property Vaginal1Oral1Anal2 auto
Spell property Vaginal2Oral2Anal2 auto
Spell property Oral1Anal1 auto
Spell property Oral2Anal1 auto
Spell property Oral1Anal2 auto
Spell property Oral2Anal2 auto
Spell property Vaginal1Oral1 auto
Spell property Vaginal2Oral1 auto
Spell property Vaginal1Oral2 auto
Spell property Vaginal2Oral2 auto
Spell property Vaginal1Anal1 auto
Spell property Vaginal2Anal1 auto
Spell property Vaginal1Anal2 auto
Spell property Vaginal2Anal2 auto
Spell property Vaginal1 auto
Spell property Vaginal2 auto
Spell property Oral1 auto
Spell property Oral2 auto
Spell property Anal1 auto
Spell property Anal2 auto

Keyword property CumOralKeyword auto
Keyword property CumAnalKeyword auto
Keyword property CumVaginalKeyword auto
Keyword property CumOralStackedKeyword auto
Keyword property CumAnalStackedKeyword auto
Keyword property CumVaginalStackedKeyword auto

Keyword property ActorTypeNPC auto
Keyword property SexLabActive auto
Keyword property FurnitureBedRoll auto

; FormList property ValidActorList auto
; FormList property NoStripList auto
; FormList property StripList auto

Furniture property BaseMarker auto
Package property DoNothing auto

Sound property OrgasmFX auto
Sound property SquishingFX auto
Sound property SuckingFX auto
Sound property SexMixedFX auto

Sound[] property HotkeyUp auto
Sound[] property HotkeyDown auto

Static property LocationMarker auto
Static property XMarkerHiddenPlace auto hidden
FormList property BedsList auto
FormList property BedRollsList auto
FormList property DoubleBedsList auto
FormList property TempFurnitureLists auto
Message property UseBed auto
Message property UseFurniture auto
Message property UseFurnitureMarker auto
Message property FollowPlayer auto
Message property CleanSystemFinish auto
Message property CheckSKSE auto
Message property CheckFNIS auto
Message property CheckSkyrim auto
Message property CheckSexLabUtil auto
Message property CheckPapyrusUtil auto
Message property CheckSkyUI auto
Message property TakeThreadControl auto

Topic property LipSync auto
VoiceType property SexLabVoiceM auto
VoiceType property SexLabVoiceF auto
FormList property SexLabVoices auto
; FormList property VoicesPlayer auto ; No longer used - v1.56
FormList property FaceItemsList auto
ObjectReference property FaceItemsContainer auto
LeveledItem property FaceItems auto
SoundCategory property AudioSFX auto
SoundCategory property AudioVoice auto

Idle property IdleReset auto

GlobalVariable property FaceItemsChanceNone auto
GlobalVariable property DebugVar1 auto
GlobalVariable property DebugVar2 auto
GlobalVariable property DebugVar3 auto
GlobalVariable property DebugVar4 auto
GlobalVariable property DebugVar5 auto

; ------------------------------------------------------- ;
; --- Config Properties                               --- ;
; ------------------------------------------------------- ;

; Booleans
bool property RestrictAggressive auto hidden
bool property AllowCreatures auto hidden
bool property NPCSaveVoice auto hidden
bool property UseStrapons auto hidden
bool property RestrictStrapons auto hidden
bool property RedressVictim auto hidden
bool property WaitIdles auto hidden
bool property RagdollEnd auto hidden
bool property UseMaleNudeSuit auto hidden
bool property UseFemaleNudeSuit auto hidden
bool property UndressAnimation auto hidden
bool property UseLipSync auto hidden
bool property UseExpressions auto hidden
bool property UseFaceItems hidden
	bool function Get()
		return HasUtilityPlus && FaceItemsChanceNone.GetValue() == 0.0
	EndFunction
	function Set(bool Value)
		If HasUtilityPlus
			If Value
				FaceItemsChanceNone.SetValue(0.0)
			Else
				FaceItemsChanceNone.SetValue(100.0)
			EndIf
		EndIf
	EndFunction
EndProperty
bool property RefreshExpressions auto hidden
bool property ScaleActors auto hidden
bool property UseCum auto hidden
bool property AllowFFCum auto hidden
bool property DisablePlayer auto hidden
bool property AutoTFC auto hidden
bool property AutoAdvance auto hidden
bool property ForeplayStage auto hidden
bool property OrgasmEffects auto hidden
bool property RaceAdjustments auto hidden
bool property BedRemoveStanding auto hidden
bool property UseCreatureGender auto hidden
bool property LimitedStrip auto hidden
bool property RestrictSameSex auto hidden
bool property RestrictGenderTag auto hidden
bool property RestrictFetishTags auto hidden
bool property SeparateOrgasms auto hidden
bool property RemoveHeelEffect auto hidden
bool property ManageZadFilter auto hidden
bool property ManageZazFilter auto hidden
bool property AdjustTargetStage auto hidden
bool property ShowInMap auto hidden
bool property DisableTeleport auto hidden
bool property SeedNPCStats auto hidden
bool property DisableScale auto hidden
bool property AllowFurniture auto hidden
bool property UseAdvancedFurn auto hidden
bool property UseIntimacyCircle auto hidden
bool property FixVictimPos auto hidden

; Integers
int property AnimProfile auto hidden
int property AskBed auto hidden
int property NPCBed auto hidden
int property UseXMarkerHidden auto hidden
int property NPCHidden auto hidden
int property AskFurniture auto hidden
int property NPCFurniture auto hidden
int property OpenMouthSize auto hidden
int property UseFade auto hidden

int property Backwards auto hidden
int property AdjustStage auto hidden
int property AdvanceAnimation auto hidden
int property ChangeAnimation auto hidden
int property ChangePositions auto hidden
int property AdjustChange auto hidden
int property AdjustForward auto hidden
int property AdjustSideways auto hidden
int property AdjustUpward auto hidden
int property RealignActors auto hidden
int property MoveScene auto hidden
int property RestoreOffsets auto hidden
int property RotateScene auto hidden
int property EndAnimation auto hidden
int property ToggleFreeCamera auto hidden
int property TargetActor auto hidden
int property AdjustSchlong auto hidden

; Floats
float property CumTimer auto hidden
float property ShakeStrength auto hidden
float property AutoSUCSM auto hidden
float property MaleVoiceDelay auto hidden
float property FemaleVoiceDelay auto hidden
float property ExpressionDelay auto hidden
float property VoiceVolume auto hidden
float property SFXDelay auto hidden
float property SFXVolume auto hidden
float property LeadInCoolDown auto hidden

; Boolean Arrays
bool[] property StripMale auto hidden
bool[] property StripFemale auto hidden
bool[] property StripLeadInFemale auto hidden
bool[] property StripLeadInMale auto hidden
bool[] property StripVictim auto hidden
bool[] property StripAggressor auto hidden

; Float Array
float[] property StageTimer auto hidden
float[] property StageTimerLeadIn auto hidden
float[] property StageTimerAggr auto hidden
float[] property OpenMouthMale auto hidden
float[] property OpenMouthFemale auto hidden
float[] property BedOffset auto hidden
float[] property FurnitureOffset auto hidden
float[] property TableOffset auto hidden
float[] property BenchTableOffset auto hidden

; Compatibility checks
bool property HasHDTHeels auto hidden
bool property HasNiOverride auto hidden
bool property HasFrostfall auto hidden
bool property HasSchlongs auto hidden
bool property HasMFGFix auto hidden
bool property HasUtilityPlus auto hidden
bool property HasSLAroused auto hidden
bool property HasSLSO auto hidden
bool property HasZadDevice auto hidden
bool property HasZazDevice auto hidden
bool property HasRaceScale auto hidden ; Some mods remove the RaceScale from DefaultObjectManager making UseScale unrelevant

DefaultObjectManager DefaultObjects

FormList property FrostExceptions auto hidden
MagicEffect HDTHeelEffect

; Furniture Array
string[] property FurnitureTags auto
string[] property ActiveFurnitureTags auto hidden
FormList[] property FurnitureExtraLists auto
FormList[] property FurnitureRestrainLists auto
	
; Data
Actor CrosshairRef
Actor property TargetRef auto hidden
Actor[] property TargetRefs auto hidden

int HookCount
bool HooksInit
sslThreadHook[] ThreadHooks

int property LipsPhoneme auto hidden
bool property LipsFixedValue auto hidden
int property LipsMinValue auto hidden
int property LipsMaxValue auto hidden
int property LipsSoundTime auto hidden
float property LipsMoveTime auto hidden

; ------------------------------------------------------- ;
; --- Config Accessors                                --- ;
; ------------------------------------------------------- ;

float function GetVoiceDelay(bool IsFemale = false, int Stage = 1, bool IsSilent = false)
	if IsSilent
		return 3.0 ; Return basic delay for loop
	endIf
	float VoiceDelay = MaleVoiceDelay
	if IsFemale
		VoiceDelay = FemaleVoiceDelay
	endIf
	if Stage > 1
		VoiceDelay -= (Stage * 0.8) + Utility.RandomFloat(-0.2, 0.4)
		if VoiceDelay < 0.8
			return Utility.RandomFloat(0.8, 1.3) ; Can't have delay shorter than animation update loop
		endIf
	endIf
	return VoiceDelay
endFunction

bool[] function GetStrip(bool IsFemale, bool IsLeadIn = false, bool IsAggressive = false, bool IsVictim = false)
	if IsLeadIn
		if IsFemale
			return StripLeadInFemale
		else
			return StripLeadInMale
		endIf
 	elseif IsAggressive
 		if IsVictim
 			return StripVictim
 		else
 			return StripAggressor
 		endIf
 	elseIf IsFemale
 		return StripFemale
 	else
 		return StripMale
 	endIf
endFunction

bool function UsesNudeSuit(bool IsFemale)
	return ((!IsFemale && UseMaleNudeSuit) || (IsFemale && UseFemaleNudeSuit))
endFunction

bool function HasCreatureInstall()
	return FNIS.GetMajor(true) > 0 && (Game.GetCameraState() < 8 || PlayerRef.GetAnimationVariableInt("SexLabCreature") > 0)
endFunction

Form function GetFaceItem(int aiIndex)
	Form[] TempFaceItems = GetFaceItems()
	if aiIndex >= 0 && aiIndex < TempFaceItems.Length
		return TempFaceItems[aiIndex]
 	endIf
	return none
endFunction

Form[] function GetFaceItems()
	if !FaceItemsList
		return Utility.CreateFormArray(0)
 	endIf
	return PapyrusUtil.ClearNone(FaceItemsList.ToArray())
endFunction

bool function AddFaceItem(Form FaceItem)
	if !FaceItemsList || !FaceItems || !FaceItem
		return false
 	endIf
	If !FaceItemsList.HasForm(FaceItem)
		FaceItemsList.AddForm(FaceItem)
		FaceItems.AddForm(FaceItem, 1, 1)
	endIf
	return FaceItemsList.HasForm(FaceItem)
endFunction

bool function RemoveFaceItem(Form FaceItem)
	if !FaceItemsList || !FaceItems || !FaceItem
		return false
 	endIf
	If FaceItemsList.HasForm(FaceItem)
		FaceItemsList.RemoveAddedForm(FaceItem)
		If !FaceItemsList.HasForm(FaceItem)
			FaceItems.Revert()
			Form[] TempFaceItems = FaceItemsList.ToArray()
			int i = FaceItems.GetNumForms()
			int n
			While i > 0
				i -= 1
				n = TempFaceItems.Find(FaceItems.GetNthForm(i))
				if n >= 0
					TempFaceItems[n] = none
				EndIf
			EndWhile
			TempFaceItems = PapyrusUtil.ClearNone(TempFaceItems)
			i = TempFaceItems.Length
			While i > 0
				i -= 1
				FaceItems.AddForm(TempFaceItems[i], 1, 1)
			EndWhile
		EndIf
	endIf
	return !FaceItemsList.HasForm(FaceItem)
endFunction

function AddActorFaceItems(Actor ActorRef)
	if !ActorRef
		return
	endIf
	
	Form[] TempFaceItems = GetFaceItems()
	if !TempFaceItems || TempFaceItems.Length < 1
		return
	endIf
	
	; Use the container with the function RemoveAllItems() to preven redress issues
	; so the next step be just in case of error
	if FaceItemsContainer && FaceItemsContainer.IsEnabled() && (FaceItemsContainer.GetBaseObject() as Container)
		FaceItemsContainer.ResetInventory()
		FaceItemsContainer.RemoveAllItems((ActorRef as ObjectReference), false, True)
	else
		FaceItemsContainer = Game.GetFormFromFile(0x8FC31, "SexLab.esm") as ObjectReference
		FaceItemsContainer.Enable()
	endIf
	
	; This way almost for sure will trigger a redress event on the NPC's.
	; The safest way is add first each item into some empty container and
	; then use the function RemoveAllItems() on the container to move the 
	; items from the container to the actor and prevent the redress.
	int i
	int iCount = TempFaceItems.Length
	while i < iCount
		if ActorRef.GetItemCount(TempFaceItems[i]) < 1
			(ActorRef as ObjectReference).AddItem(TempFaceItems[i], 1, true)
			; the ObjectReference is trying to avoid the redress event of the Actor
		endif
		i += 1
	endWhile
	
endFunction

function UnequipActorFaceItems(Actor ActorRef)
	if !ActorRef
		return
	endIf

	Form[] TempFaceItems = GetFaceItems()
	if !TempFaceItems || TempFaceItems.Length < 1
		return
	endIf
	
	Form akWorn = ActorRef.GetWornForm(0x80000000)
	if akWorn && TempFaceItems.Find(akWorn)
		sslBaseExpression.UnequipFaceItem(ActorRef, akWorn)
	endIf
endFunction

function ClearActorFaceItems(Actor ActorRef)
	if !ActorRef
		return
	endIf
	
	Form[] TempFaceItems = GetFaceItems()
	if !TempFaceItems || TempFaceItems.Length < 1
		return
	endIf
;	Form akWorn = ActorRef.GetWornForm(0x80000000)
;	i = 25
;	while i && akWorn && TempFaceItems.Find(akWorn) != -1
;		i -= 1
;		ActorRef.UnequipItem(akWorn, true, true)
;		Utility.Wait(0.2)
;		akWorn = ActorRef.GetWornForm(0x80000000)
;	endWhile
	
	int i = TempFaceItems.Length
	int aiCount
	while i
		i -= 1
		aiCount = ActorRef.GetItemCount(TempFaceItems[i])
		if aiCount > 0
			ActorRef.RemoveItem(TempFaceItems[i], aiCount, true)
		endIf
	endWhile
	
	if ActorRef == Game.GetPlayer() && Game.GetCameraState() > 0
		Game.UpdateThirdPerson()
	endif
endFunction

float[] function GetOpenMouthPhonemes(bool isFemale)
	float[] Phonemes = new float[16]
	int i = 16
	while i > 0
		i -= 1
		if isFemale
			Phonemes[i] = OpenMouthFemale[i]
		else
			Phonemes[i] = OpenMouthMale[i]
		endIf
	endWhile
	return Phonemes
endFunction

bool function SetOpenMouthPhonemes(bool isFemale, float[] Phonemes)
	if Phonemes.Length < 16
		return false
	endIf
	if OpenMouthFemale.Length < 16
		OpenMouthFemale = new float[17]
	endIf
	if OpenMouthMale.Length < 16
		OpenMouthMale = new float[17]
	endIf
	int i = 16
	while i > 0
		i -= 1
		if isFemale
			OpenMouthFemale[i] = PapyrusUtil.ClampFloat(Phonemes[i], 0.0, 1.0)
		else
			OpenMouthMale[i] = PapyrusUtil.ClampFloat(Phonemes[i], 0.0, 1.0)
		endIf
	endWhile
	return true
endFunction

bool function SetOpenMouthPhoneme(bool isFemale, int id, float value)
	if id < 0 || id > 15 
		return false
	endIf
	if isFemale
		if OpenMouthFemale.Length < 16
			OpenMouthFemale = new float[17]
		endIf
		OpenMouthFemale[id] = PapyrusUtil.ClampFloat(value, 0.0, 1.0)
	else
		if OpenMouthMale.Length < 16
			OpenMouthMale = new float[17]
		endIf
		OpenMouthMale[id] = PapyrusUtil.ClampFloat(value, 0.0, 1.0)
	endIf
	return true
endFunction

int function GetOpenMouthExpression(bool isFemale)
	if isFemale
		if OpenMouthFemale.Length >= 17 && OpenMouthFemale[16] >= 0.0 && OpenMouthFemale[16] <= 16.0
			return OpenMouthFemale[16] as int
		endIf
	else
		if OpenMouthMale.Length >= 17 && OpenMouthMale[16] >= 0.0 && OpenMouthMale[16] <= 16.0
			return OpenMouthMale[16] as int
		endIf
	endIf
	return 16
endFunction

bool function SetOpenMouthExpression(bool isFemale, int value)
	if isFemale
		if OpenMouthFemale.Length < 17
			OpenMouthFemale = new float[17]
		endIf
		OpenMouthFemale[16] = PapyrusUtil.ClampInt(value, 0, 16) as Float
		return true
	else
		if OpenMouthMale.Length < 17
			OpenMouthMale = new float[17]
		endIf
		OpenMouthMale[16] = PapyrusUtil.ClampInt(value, 0, 16) as Float
		return true
	endIf
	return false
endFunction

bool function AddCustomBed(Form BaseBed, int BedType = 0) ; BedType: 0=SingledBed; 1=BedRoll; 2=DoubleBed
	if !BaseBed
		return false
	elseIf !BedsList.HasForm(BaseBed)
		BedsList.AddForm(BaseBed)
	endIf
	if BedType == 1 && !BedRollsList.HasForm(BaseBed)
		BedRollsList.AddForm(BaseBed)
		if DoubleBedsList.HasForm(BaseBed)
			DoubleBedsList.RemoveAddedForm(BaseBed)
		endIf
	elseIf BedType == 2 && !DoubleBedsList.HasForm(BaseBed)
		DoubleBedsList.AddForm(BaseBed)
		if BedRollsList.HasForm(BaseBed)
			BedRollsList.RemoveAddedForm(BaseBed)
		endIf
	endIf
	return true
endFunction

bool function SetCustomBedOffset(Form BaseBed, float Forward = 0.0, float Sideward = 0.0, float Upward = 37.0, float Rotation = 0.0)
	if !BaseBed || !BedsList.HasForm(BaseBed)
		Log("Invalid form or bed does not exist currently in bed list.", "SetBedOffset("+BaseBed+")")
		return false
	endIf
	float[] off = new float[4]
	off[0] = Forward
	off[1] = Sideward
	off[2] = Upward
	off[3] = PapyrusUtil.ClampFloat(Rotation, -360.0, 360.0)
	StorageUtil.FloatListCopy(BaseBed, "SexLab.BedOffset", off)
	return true
endFunction

bool function ClearCustomBedOffset(Form BaseBed)
	return StorageUtil.FloatListClear(BaseBed, "SexLab.BedOffset") > 0
endFunction

float[] function GetBedOffsets(Form BaseBed)
	float[] Offsets = new float[4]
	if StorageUtil.FloatListCount(BaseBed, "SexLab.BedOffset") == 4
		StorageUtil.FloatListSlice(BaseBed, "SexLab.BedOffset", Offsets)
		return Offsets
	endIf
	int i = BedOffset.Length
	; For some reason with the old function if you change the value of the variable with the returned BedOffset Array the value also change on the original BedOffset
	while i > 0
		i -= 1
		Offsets[i] = BedOffset[i]
	endWhile
	return Offsets
endFunction

int function GetFurnitureType(Form BaseFurniture)
	if !BaseFurniture || !FurnitureExtraLists || FurnitureExtraLists.Length < 1
		Log("Invalid form or Furniture List's Empty.", "GetFurnitureType("+BaseFurniture+")")
		return -1
	endIf
	int i = 0
	int r
	while i < (FurnitureExtraLists.Length + FurnitureRestrainLists.Length)
		if i < FurnitureExtraLists.Length
			if FurnitureExtraLists[i].HasForm(BaseFurniture)
				return i
			endIf
		elseIf i >= FurnitureExtraLists.Length
			r = i - FurnitureExtraLists.Length
			if FurnitureRestrainLists[r].HasForm(BaseFurniture)
				return i
			endIf
		endIf
		i += 1
	endWhile
	return -1
endFunction

bool function AddCustomFurniture(Form BaseFurniture, int FurnType = -1)
	if !BaseFurniture || FurnType < 0
		Log("Invalid form or furniture type.", "AddCustomFurniture("+BaseFurniture+", "+FurnType+")")
		return false
	elseIf !FurnitureTags || FurnitureTags.Length < 1
		Log("None FurnitureTag in existence.", "AddCustomFurniture("+BaseFurniture+", "+FurnType+")")
		return false
	elseIf FurnitureTags.Length <= FurnType
		Log("Invalid Furniture type.", "AddCustomFurniture("+BaseFurniture+", "+FurnType+")")
		return false
	endIf
	int FurnRestrainType = (FurnType - FurnitureExtraLists.Length)
	if FurnType < FurnitureExtraLists.Length
		if !FurnitureExtraLists[FurnType].HasForm(BaseFurniture)
			FurnitureExtraLists[FurnType].AddForm(BaseFurniture)
			return true
		endIf
	elseIf FurnType >= FurnitureExtraLists.Length && FurnRestrainType < FurnitureRestrainLists.Length
		if !FurnitureRestrainLists[FurnRestrainType].HasForm(BaseFurniture)
			FurnitureRestrainLists[FurnRestrainType].AddForm(BaseFurniture)
			return true
		endIf
	else
		Log("AddCustomFurniture("+BaseFurniture+", "+FurnType+") FurnType does not exist in Furnitures List's but exist on FurnitureTags. Usualy solve executing the CleanSystem option", "FATAL")
	endIf
	return false
endFunction

bool function HasCustomFurniture(Form BaseFurniture, int FurnType = -1)
	if !BaseFurniture || FurnType < 0
		Log("Invalid form or furniture type.", "HasCustomFurniture("+BaseFurniture+", "+FurnType+")")
		return false
	elseIf !FurnitureTags || FurnitureTags.Length < 1
		Log("Furniture Tags List Empty.", "HasCustomFurniture("+BaseFurniture+", "+FurnType+")")
		return false
	elseIf FurnitureTags.Length <= FurnType
		Log("Invalid Furniture type.", "HasCustomFurniture("+BaseFurniture+", "+FurnType+")")
		return false
	endIf
	int FurnRestrainType = (FurnType - FurnitureExtraLists.Length)
	if FurnType < FurnitureExtraLists.Length 
		return FurnitureExtraLists[FurnType].HasForm(BaseFurniture)
	elseIf FurnType >= FurnitureExtraLists.Length && FurnRestrainType < FurnitureRestrainLists.Length
		return FurnitureRestrainLists[FurnRestrainType].HasForm(BaseFurniture)
	else
		Log("HasCustomFurniture("+BaseFurniture+", "+FurnType+") FurnType does not exist in Furnitures List's but exist on FurnitureTags. Usualy solve executing the CleanSystem option", "FATAL")
	endIf
	return false
endFunction

; In the nif on the Center property of the NiTriShapeData: Forward = Y, Sideward = X, Upward = Z, Rotation = 
bool function SetCustomFurnitureOffsets(Form BaseFurniture, float Forward = 0.0, float Sideward = 0.0, float Upward = 0.0, float Rotation = 0.0)
	if !BaseFurniture || GetFurnitureType(BaseFurniture) < 0
		Log("Invalid form or furniture does not exist currently in furniture list.", "SetFurnitureOffset("+BaseFurniture+")")
		return false
	endIf
	float[] off = new float[4]
	off[0] = Forward
	off[1] = Sideward
	off[2] = Upward
	off[3] = PapyrusUtil.ClampFloat(Rotation, -360.0, 360.0)
	StorageUtil.FloatListCopy(BaseFurniture, "SexLab.FurnitureOffset", off)
	return true
endFunction

bool function ClearCustomFurnitureOffsets(Form BaseFurniture)
	return StorageUtil.FloatListClear(BaseFurniture, "SexLab.FurnitureOffset") > 0
endFunction

float[] function GetFurnitureOffsets(Form BaseFurniture)
	float[] Offsets = new float[4]
	if StorageUtil.FloatListCount(BaseFurniture, "SexLab.FurnitureOffset") == 4
		StorageUtil.FloatListSlice(BaseFurniture, "SexLab.FurnitureOffset", Offsets)
		return Offsets
	endIf
	float[] FurnitureOffsets
	int FurnitureType = GetFurnitureType(BaseFurniture)
	if FurnitureType >= 0 && FurnitureType < FurnitureTags.Length
		if FurnitureTags[FurnitureType] == "Table"
			FurnitureOffsets = TableOffset
		elseIf FurnitureTags[FurnitureType] == "BenchTable"
			FurnitureOffsets = BenchTableOffset
		else
			; Chair, Throne and Bench have all the same higth and center
			FurnitureOffsets = FurnitureOffset
		endIf
	endIf
	int i = FurnitureOffsets.Length
	while i > 0
		i -= 1
		Offsets[i] = FurnitureOffsets[i]
	endWhile
	return Offsets
endFunction

; ------------------------------------------------------- ;
; --- Strapon Functions                               --- ;
; ------------------------------------------------------- ;

Form function GetStrapon()
	if Strapons.Length > 0
		return Strapons[Utility.RandomInt(0, (Strapons.Length - 1))]
	endIf
	return none
endFunction

Form function WornStrapon(Actor ActorRef)
	int i = Strapons.Length
	while i
		i -= 1
		if ActorRef.GetItemCount(Strapons[i]) > 0
			return Strapons[i]
		endIf
	endWhile
	return none
endFunction

bool function HasStrapon(Actor ActorRef)
	return WornStrapon(ActorRef) != none
endFunction

Form function PickStrapon(Actor ActorRef)
	form Strapon = WornStrapon(ActorRef)
	if Strapon
		return Strapon
	endIf
	return GetStrapon()
endFunction

Form function EquipStrapon(Actor ActorRef)
	form Strapon = PickStrapon(ActorRef)
	if Strapon
		ActorRef.AddItem(Strapon, 1, true)
		ActorRef.EquipItem(Strapon, false, true)
	endIf
	return Strapon
endFunction

function UnequipStrapon(Actor ActorRef)
	int i = Strapons.Length
	while i
		i -= 1
		if ActorRef.IsEquipped(Strapons[i])
			ActorRef.RemoveItem(Strapons[i], 1, true)
		endIf
	endWhile
endFunction

function LoadStrapons()
	Strapons = new form[1]
	Strapons[0] = CalypsStrapon

	if Game.GetModByName("StrapOnbyaeonv1.1.esp") != 255
		LoadStrapon("StrapOnbyaeonv1.1.esp", 0x0D65)
	endIf
	if Game.GetModByName("TG.esp") != 255
		LoadStrapon("TG.esp", 0x0182B)
	endIf
	if Game.GetModByName("Futa equippable.esp") != 255
		LoadStrapon("Futa equippable.esp", 0x0D66)
		LoadStrapon("Futa equippable.esp", 0x0D67)
		LoadStrapon("Futa equippable.esp", 0x01D96)
		LoadStrapon("Futa equippable.esp", 0x022FB)
		LoadStrapon("Futa equippable.esp", 0x022FC)
		LoadStrapon("Futa equippable.esp", 0x022FD)
	endIf
	if Game.GetModByName("Skyrim_Strap_Ons.esp") != 255
		LoadStrapon("Skyrim_Strap_Ons.esp", 0x00D65)
		LoadStrapon("Skyrim_Strap_Ons.esp", 0x02859)
		LoadStrapon("Skyrim_Strap_Ons.esp", 0x0285A)
		LoadStrapon("Skyrim_Strap_Ons.esp", 0x0285B)
		LoadStrapon("Skyrim_Strap_Ons.esp", 0x0285C)
		LoadStrapon("Skyrim_Strap_Ons.esp", 0x0285D)
		LoadStrapon("Skyrim_Strap_Ons.esp", 0x0285E)
		LoadStrapon("Skyrim_Strap_Ons.esp", 0x0285F)
	endIf
	if Game.GetModByName("SOS Equipable Schlong.esp") != 255
		LoadStrapon("SOS Equipable Schlong.esp", 0x0D62)
	endIf
	ModEvent.Send(ModEvent.Create("SexLabLoadStrapons"))
endFunction

Armor function LoadStrapon(string esp, int id)
	Form Strapon = Game.GetFormFromFile(id, esp)
	if Strapon && (Strapon as Armor)
		Strapons = PapyrusUtil.PushForm(Strapons, Strapon)
	endif
	return Strapon as Armor
endFunction

; ------------------------------------------------------- ;
; --- Hotkeys                                         --- ;
; ------------------------------------------------------- ;

sslThreadController Control

event OnKeyDown(int keyCode)
	if !Utility.IsInMenuMode() && !UI.IsMenuOpen("Console") && !UI.IsMenuOpen("Loading Menu")
		if keyCode == ToggleFreeCamera
			ToggleFreeCamera()
		elseIf keyCode == TargetActor
			if Control
				DisableThreadControl(Control)
			else
				SetTargetActor()
			endIf
		elseIf keyCode == EndAnimation && BackwardsPressed()
			ThreadSlots.StopAll()
		endIf
	endIf
endEvent

event OnCrosshairRefChange(ObjectReference ActorRef)
	CrosshairRef = none
	if ActorRef
		CrosshairRef = ActorRef as Actor
	endIf
endEvent

function SetTargetActor()
	if CrosshairRef && CrosshairRef != none
		TargetRef = CrosshairRef
		SelectedSpell.Cast(TargetRef, TargetRef)
		Debug.Notification("SexLab Target Selected: "+TargetRef.GetLeveledActorBase().GetName())
		; Give them stats if they need it
		Stats.SeedActor(TargetRef)
		; Attempt to grab control of their animation?
		sslThreadController TargetThread = ThreadSlots.GetActorController(TargetRef)
		if TargetThread && !TargetThread.HasPlayer && (TargetThread.GetState() == "Animating" || TargetThread.GetState() == "Advancing" || TargetThread.GetState() == "Resetting")
			sslThreadController PlayerThread = ThreadSlots.GetActorController(PlayerRef)
			if (!PlayerThread || !(PlayerThread.GetState() == "Animating" || PlayerThread.GetState() == "Advancing" || PlayerThread.GetState() == "Resetting")) && TakeThreadControl.Show()
				if PlayerThread != none
					ThreadSlots.StopThread(PlayerThread)
				endIf
				GetThreadControl(TargetThread) 
			endIf
		endIf
	endif
endFunction

function AddTargetActor(Actor ActorRef)
	if ActorRef
		if TargetRefs.Find(ActorRef) != -1
			TargetRefs[TargetRefs.Find(ActorRef)] = none
		endIf
		TargetRefs[4] = TargetRefs[3]
		TargetRefs[3] = TargetRefs[2]
		TargetRefs[2] = TargetRefs[1]
		TargetRefs[1] = TargetRefs[0]
		TargetRefs[0] = ActorRef
	endIf
endFunction

; Actor function GetNthValidTargetActor(int i)
; 	Form FormRef = StorageUtil.FormListGet(self, "TargetActors", i)
; 	if SexLabUtil.IsActor(FormRef)
; 		return FormRef as Actor
; 	endIf
; 	return none
; endFunction

; Actor[] function GetTargetActors()
; 	StorageUtil.FormListRemove(self, "TargetActors", TargetRef, true)

; 	Actor[] Target
; 	int i = StorageUtil.FormListFilterByTypes(self, "TargetActors")
; 	while i

; 	endWhile

; 	Form[] All = new Form[5]
; 	StorageUtil.FormListSlice(self, "TargetActors", All)

; 	int i = 5
; 	while i
; 		i -= 1
; 		if All[i]
; 			if !SexLabUtil.IsActor(FormRef)
; 				StorageUtil.FormListRemove(self, "TargetActors", All[i])
; 			else

; 			endIf
; 		endIf

; 	endWhile



; endFunction

sslThreadController function GetThreadControlled()
	return Control
endFunction

function GetThreadControl(sslThreadController TargetThread)
	if Control || !(TargetThread.GetState() == "Animating" || TargetThread.GetState() == "Advancing" || TargetThread.GetState() == "Resetting")
		Log("Failed to control thread "+TargetThread)
		return ; Control not available
	endIf
	; Set active controlled thread
	Control = TargetThread
	if !Control || Control == none
		Log("Failed to control thread "+TargetThread)
		return ; Control not available
	endIf
	; Lock players movement
	PlayerRef.StopCombat()
	if PlayerRef.IsWeaponDrawn()
		PlayerRef.SheatheWeapon()
	endIf
	PlayerRef.SetFactionRank(AnimatingFaction, 1)
	ActorUtil.AddPackageOverride(PlayerRef, DoNothing, 100, 1)
	PlayerRef.EvaluatePackage()
	Game.DisablePlayerControls(true, true, false, false, false, false, false, false, 0)
	Game.SetPlayerAIDriven()
	; Give player control
	Control.AutoAdvance = false
	Control.EnableHotkeys(true)
	Log("Player has taken control of thread "+Control)
endFunction

function DisableThreadControl(sslThreadController TargetThread)
	if Control && Control == TargetThread
		; Release players thread control
		MiscUtil.SetFreeCameraState(false)
		if Game.GetCameraState() < 8 && Game.GetCameraState() != 3
			Game.ForceThirdPerson()
		endIf
		Control.DisableHotkeys()
		Control.AutoAdvance = true
		Control = none
		; Unlock players movement
		PlayerRef.RemoveFromFaction(AnimatingFaction)
		ActorUtil.RemovePackageOverride(PlayerRef, DoNothing)
		PlayerRef.EvaluatePackage()
		Game.EnablePlayerControls()
		Game.SetPlayerAIDriven(false)
	endIf
endfunction

function ToggleFreeCamera()
	int CameraState = Game.GetCameraState()
	Log("- CameraState: "+CameraState, "ToggleFreeCamera()")
	if CameraState != 3
;	if Game.GetCameraState() != 3
		if CameraState < 8
	;	if Game.GetCameraState() < 8
			Game.ForceThirdPerson()
		endIf
		MiscUtil.SetFreeCameraSpeed(AutoSUCSM)
	endIf
	MiscUtil.ToggleFreeCamera()

	if Game.GetCameraState() >= 8
		If !Game.IsCamSwitchControlsEnabled()
			Game.EnablePlayerControls(false, false, true, false, false, false, false, false)
		endIf
		Game.UpdateThirdPerson()
	endIf
endFunction

bool function BackwardsPressed()
	return Input.GetNumKeysPressed() > 1 && MirrorPress(Backwards)
endFunction

bool function AdjustStagePressed()
	return AdjustTargetStage != IsAdjustStagePressed()
endFunction

bool function IsAdjustStagePressed()
	return Input.GetNumKeysPressed() > 1 && MirrorPress(AdjustStage)
endFunction

bool function MirrorPress(int mirrorkey)
	if mirrorkey == 42 || mirrorkey == 54  ; Shift
		return Input.IsKeyPressed(42) || Input.IsKeyPressed(54)
	elseif mirrorkey == 29 || mirrorkey == 157 ; Ctrl
		return Input.IsKeyPressed(29) || Input.IsKeyPressed(157)
	elseif mirrorkey == 56 || mirrorkey == 184 ; Alt
		return Input.IsKeyPressed(56) || Input.IsKeyPressed(184)
	else
		return Input.IsKeyPressed(mirrorkey)
	endIf
endFunction

; ------------------------------------------------------- ;
; --- Animation Profiles                              --- ;
; ------------------------------------------------------- ;

function ExportProfile(int Profile = 1)
	SaveAdjustmentProfile()
endFunction

function ImportProfile(int Profile = 1)
	SetAdjustmentProfile("../SexLab/AnimationProfile_"+Profile+".json")
endfunction

function SwapToProfile(int Profile)
	AnimProfile = Profile
	SetAdjustmentProfile("../SexLab/AnimationProfile_"+Profile+".json")
endFunction

bool function SetAdjustmentProfile(string ProfileName) global native
bool function SaveAdjustmentProfile() global native

; ------------------------------------------------------- ;
; --- 3rd party compatibility                         --- ;
; ------------------------------------------------------- ;

Spell function GetHDTSpell(Actor ActorRef)
	if !HasHDTHeels || !HDTHeelEffect || !ActorRef; || !ActorRef.GetWornForm(Armor.GetMaskForSlot(37))
		return none
	endIf
	int i = ActorRef.GetSpellCount()
	while i
		i -= 1
		Spell SpellRef = ActorRef.GetNthSpell(i)
		Log(SpellRef.GetName(), "Checking("+SpellRef+") for HDT HighHeels")
		if SpellRef && StringUtil.Find(SpellRef.GetName(), "Heel") != -1
			return SpellRef
		endIf
		int n = SpellRef.GetNumEffects()
		while n
			n -= 1
			if SpellRef.GetNthEffectMagicEffect(n) == HDTHeelEffect
				return SpellRef
			endIf
		endWhile
	endWhile
	return none
endFunction


Faction property BardExcludeFaction auto
ReferenceAlias property BardBystander1 auto
ReferenceAlias property BardBystander2 auto
ReferenceAlias property BardBystander3 auto
ReferenceAlias property BardBystander4 auto
ReferenceAlias property BardBystander5 auto

bool function CheckBardAudience(Actor ActorRef, bool RemoveFromAudience = true)
	if !ActorRef
		return false; Invalid argument
	elseIf RemoveFromAudience
		return BystanderClear(ActorRef, BardBystander1) || BystanderClear(ActorRef, BardBystander2) || BystanderClear(ActorRef, BardBystander3) \
			|| BystanderClear(ActorRef, BardBystander4) || BystanderClear(ActorRef, BardBystander5)
	else
		return ActorRef == BardBystander1.GetReference() || ActorRef == BardBystander2.GetReference() || ActorRef == BardBystander3.GetReference() \
			|| ActorRef == BardBystander4.GetReference() || ActorRef == BardBystander5.GetReference()
	endIf
endFunction

bool function BystanderClear(Actor ActorRef, ReferenceAlias BardBystander)
	if ActorRef == BardBystander.GetReference()
		BardBystander.Clear()
		ActorRef.EvaluatePackage()
		Log("Cleared from bard audience", "CheckBardAudience("+ActorRef+")")
		return true
	endIf
	return false
endFunction

; ------------------------------------------------------- ;
; --- System Use                                      --- ;
; ------------------------------------------------------- ;

bool function CheckSystemPart(string CheckSystem)
	if CheckSystem == "Skyrim"
		return (StringUtil.SubString(Debug.GetVersionNumber(), 0, 3) as float) >= 1.5 ;SSE

	elseIf CheckSystem == "SKSE"
		return SKSE.GetScriptVersionRelease() >= 64 ;SSE

	elseIf CheckSystem == "SkyUI"
		return Quest.GetQuest("SKI_ConfigManagerInstance") != none

	elseIf CheckSystem == "SexLabUtil"
		return SexLabUtil.GetPluginVersion() >= 16300 ;SSE

	elseIf CheckSystem == "PapyrusUtil"
		return PapyrusUtil.GetVersion() >= 39 ;SSE

	elseIf CheckSystem == "NiOverride"
		return (SKSE.GetPluginVersion("SKEE64") >= 0 || SKSE.GetPluginVersion("SKEE") >= 0) && NiOverride.GetScriptVersion() >= 7 ;SSE

	elseIf CheckSystem == "FNIS"
		return FNIS.VersionCompare(7, 0, 0) >= 0 ;SSE

	elseIf CheckSystem == "FNISGenerated"
		return FNIS.IsGenerated()

	elseIf CheckSystem == "FNISCreaturePack"
		return FNIS.VersionCompare(7, 0, 0, true) >= 0 ;SSE

	elseIf CheckSystem == "FNISSexLabFramework" && PlayerRef.Is3DLoaded() && Game.GetCameraState() > 3
		return PlayerRef.GetAnimationVariableInt("SexLabFramework") >= 16000

	elseIf CheckSystem == "FNISSexLabCreature" && PlayerRef.Is3DLoaded() && Game.GetCameraState() > 3
		return PlayerRef.GetAnimationVariableInt("SexLabCreature") >= 16000

	endIf
	return false
endFunction

bool function CheckSystem()
	; Check Skyrim Version
	if !CheckSystemPart("Skyrim")
		CheckSkyrim.Show(1.5) ;SSE
		return false
	; Check SKSE install
	elseIf !CheckSystemPart("SKSE")
		CheckSKSE.Show(2.0017) ;SSE
		return false
	; Check SkyUI install - depends on passing SKSE check passing
	elseIf !CheckSystemPart("SkyUI")
		CheckSkyUI.Show(5.2) ;SSE
		return false
	; Check SexLabUtil install - this should never happen if they have properly updated
	elseIf !CheckSystemPart("SexLabUtil")
		CheckSexLabUtil.Show()
		return false
	; Check PapyrusUtil install - depends on passing SKSE check passing
	elseIf !CheckSystemPart("PapyrusUtil")
		CheckPapyrusUtil.Show(3.9) ;SSE
		return false
	; Check FNIS generation - soft fail
	; elseIf CheckSystemPart("FNISSexLabFramework")
		; CheckFNIS.Show()
	endIf
	; Return result
	return true
endFunction

function Reload()
	; DebugMode = true
	if DebugMode
		Debug.OpenUserLog("SexLabDebug")
		Debug.TraceUser("SexLabDebug", "Config Reloading...")
	endIf

	LoadLibs(false)
	SexLab = SexLabUtil.GetAPI()

	; SetVehicle Scaling Fix
	SexLabUtil.VehicleFixMode((DisableScale as int)) ;SSE

	; Configure SFX & Voice volumes
	AudioVoice.SetVolume(VoiceVolume)
	AudioSFX.SetVolume(SFXVolume)

	; Remove any targeted actors
	RegisterForCrosshairRef()
	CrosshairRef = none
	TargetRef    = none

	; TFC Toggle key
	UnregisterForAllKeys()
	RegisterForKey(ToggleFreeCamera)
	RegisterForKey(TargetActor)
	RegisterForKey(EndAnimation)

	; Mod compatability checks
	; - HDT/NiO High Heels
	HasNiOverride = Config.CheckSystemPart("NiOverride")
	HasHDTHeels   = Game.GetModByName("hdtHighHeel.esm") != 255
	if HasHDTHeels && !HDTHeelEffect
		HDTHeelEffect = Game.GetFormFromFile(0x800, "hdtHighHeel.esm") as MagicEffect
	endIf
	; - Frostfall exposure pausing
	HasFrostfall = Game.GetModByName("Frostfall.esp") != 255; && Game.GetModByName("Campfire.esm") != 255; || Game.GetModByName("Chesko_Frostfall.esp") != 255
	if HasFrostfall && !FrostExceptions
		FrostExceptions = Game.GetFormFromFile(0x6E7E6, "Frostfall.esp") as FormList
	endIf
	; - SOS/SAM Schlongs (currently unused)
	HasSchlongs = Game.GetModByName("Schlongs of Skyrim - Core.esm") != 255 || Game.GetModByName("SAM - Shape Atlas for Men.esp") != 255

	; - MFG Fix check
	HasMFGFix = (SKSE.GetPluginVersion("Mfg Console plugin") > 0 || SKSE.GetPluginVersion("MfgFix") > 0) && MfgConsoleFunc.ResetPhonemeModifier(PlayerRef) ; TODO: May need to check another way, some players might get upset that their mfg is reset on load
	If !HasMFGFix && OpenMouthSize > 100
		OpenMouthSize = 100
	endIf
	
	; - Default Object Manager Has RaceScale
	if !DefaultObjects
		DefaultObjects = Game.GetFormFromFile(0x31, "Skyrim.esm") as DefaultObjectManager
	endIf
	HasRaceScale = DefaultObjects && DefaultObjects.GetForm("SAT1") == Keyword.GetKeyword("RaceToScale")
	; - SexLab Separate Orgasm
	HasSLSO = Game.GetModByName("SLSO.esp") != 255
	; - SexLab Aroused
	HasSLAroused = Game.GetModByName("SexLabAroused.esm") != 255
	; - Devious Devices
	HasZadDevice = Game.GetModByName("Devious Devices - Assets.esm") != 255
	if !HasZadDevice && ManageZadFilter
		ManageZadFilter = False
	endIf
	; - ZaZ Animation Pack
	HasZazDevice = Game.GetModByName("ZaZAnimationPack.esm") != 255
	if !HasZazDevice && ManageZazFilter
		ManageZazFilter = False
	endIf

	if !XMarkerHiddenPlace
		XMarkerHiddenPlace = Game.GetFormFromFile(0x0034, "Skyrim.esm") as static ; XMarkerHeading [STAT:00000034]
	endIf
	
	if !DummyArrow
		DummyArrow = Game.GetFormFromFile(0x6A0BF, "Skyrim.esm") as Ammo
	endIf
	
	HasUtilityPlus = Game.IsPluginInstalled("SexLab UtilityPlus.esp") ;SSE
	; - Furnitures
	if !HasUtilityPlus && (ShowInMap || UseIntimacyCircle || AskFurniture > 0 || NPCFurniture > 0)
		AskFurniture = 0
		NPCFurniture = 0
		ShowInMap = False
		UseIntimacyCircle = False
	endIf
	
	if !FurnitureOffset || FurnitureOffset.Length != 4
		FurnitureOffset = new float[4]
	endIf
	
	if !TableOffset || TableOffset.Length != 4
		TableOffset = new float[4]
	endIf
	
	if !BenchTableOffset || BenchTableOffset.Length != 4
		BenchTableOffset = new float[4]
	endIf
	
	if !FadeToBlackHoldImod || FadeToBlackHoldImod == none
		FadeToBlackHoldImod = Game.GetFormFromFile(0xF756E, "Skyrim.esm") as ImageSpaceModifier ;0xF756D **0xF756E 0x10100C** 0xF756F 0xFDC57 0xFDC58 0x 0x 0x
	endIf
	if !FadeToBlurHoldImod || FadeToBlurHoldImod == none
		FadeToBlurHoldImod = Game.GetFormFromFile(0x44F3B, "Skyrim.esm") as ImageSpaceModifier ;0x201D3 0x44F3B **0xFD809 0x1037E2 0x1037E3 0x1037E4 0x1037E5 0x1037E6** 0x
	endIf

	if HasUtilityPlus
		if !ForceBlackVFX || ForceBlackVFX == none
			ForceBlackVFX = Game.GetFormFromFile(0x8FC39, "SexLab.esm") as VisualEffect ;0x44F3A 
		endIf
		if !ForceBlurVFX || ForceBlurVFX == none
			ForceBlurVFX = Game.GetFormFromFile(0x8FC3A, "SexLab.esm") as VisualEffect ;0x101967
		endIf

		if !FaceItems || FaceItems == none
			FaceItems = Game.GetFormFromFile(0x8FC36, "SexLab.esm") as LeveledItem
		endIf

		if !FaceItemsList || FaceItemsList == none
			FaceItemsList = Game.GetFormFromFile(0x8FC3B, "SexLab.esm") as FormList
		endIf

		if !CircleOfIntimacy || CircleOfIntimacy == none
			CircleOfIntimacy = Game.GetFormFromFile(0x836, "SexLab UtilityPlus.esp")
		endIf

		if (!FurnitureTags || FurnitureTags.Length != 26)
			FurnitureTags = new string[26]
			FurnitureTags[0] = "Chair"
			FurnitureTags[1] = "Throne"
			FurnitureTags[2] = "Bench"
			FurnitureTags[3] = "BenchTable"
			FurnitureTags[4] = "Table"
			FurnitureTags[5] = "Counter"
			FurnitureTags[6] = "Workbench"
			FurnitureTags[7] = "AlchemyWorkbench"
			FurnitureTags[8] = "EnchantingWorkbench"
			FurnitureTags[9] = "Coffin"
			FurnitureTags[10] = "Wall"
			FurnitureTags[11] = "Pillory"
			FurnitureTags[12] = "Rack"
			FurnitureTags[13] = "Pole"
			FurnitureTags[14] = "XCross"
			FurnitureTags[15] = "TiltedWheel"
			FurnitureTags[16] = "RPost1"
			FurnitureTags[17] = "RPost2"
			FurnitureTags[18] = "RPost3"
			FurnitureTags[19] = "RPost4"
			FurnitureTags[20] = "RPost5"
			FurnitureTags[21] = "RPost6"
			FurnitureTags[22] = "WoodenHorse"
			FurnitureTags[23] = "ShackleWall"
			FurnitureTags[24] = "Stockade"
			FurnitureTags[25] = "HorizontalPole"
		endIf
		
		if GetFurnitureOffsets(Game.GetFormFromFile(0xD932F, "Skyrim.esm"))[1] != -26.0
			Log("Updating furnitures for mod 'Skyrim.esm'")
		; Bench
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x2E6CF, "Skyrim.esm"), 0.0, 0.0, 0.0, 180.0) 		; CommonBench01 "Bench" [FURN:0002E6CF]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xA4AD6, "Skyrim.esm"), 0.0, 0.0, 0.0, 180.0) 		; FarmBench01F "Bench" [FURN:000A4AD6]
		; BenchTable
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xF5B9C, "Skyrim.esm"), -70.0, 0.0, 0.0, 0.0) 		; DweTableTwoBenches "Table" [FURN:000F5B9C]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xF5B9B, "Skyrim.esm"), -70.0, 0.0, 0.0, 0.0) 		; DweTableOneBench "Table" [FURN:000F5B9B]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xF5B98, "Skyrim.esm"), -57.0, 0.0, 0.0, 0.0) 		; NorTableTwoBenches "Table" [FURN:000F5B98]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xF5B9A, "Skyrim.esm"), -57.0, 0.0, 0.0, 0.0) 		; NorTableOneBench "Table" [FURN:000F5B9A]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xB0104, "Skyrim.esm"), -57.0, 0.0, 0.0, 0.0) 		; CommonTableTwoBenches "Table" [FURN:000B0104]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xB0105, "Skyrim.esm"), 57.0, 0.0, 0.0, 180.0) 		; CommonTableOneBench
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xA4ABB, "Skyrim.esm"), 60.0, 0.0, 0.0, 180.0) 		; FarmTableBeanch01
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xA4ABA, "Skyrim.esm"), -60.0, 0.0, 0.0, 0.0) 		; FarmTableBeanch02 "Bench" [FURN:000A4ABA]
		; Table
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xC4EF1, "Skyrim.esm"), 22.0, 0.0, 0.0, 0.0) 		; LeanTableMarker [FURN:000C4EF1]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x2EC1F, "Skyrim.esm"), -40.0, 0.0, 0.0, 0.0) 		; CommonTableRound01 [STAT:0002EC1F]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x2F239, "Skyrim.esm"), -45.0, 0.0, 0.0, 0.0) 		; CommonTableSquare01 [STAT:0002F239]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x42D30, "Skyrim.esm"), 51.0, 0.0, 0.0, 180.0) 		; OrcTable01 [STAT:00042D30]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x42D32, "Skyrim.esm"), -45.0, 0.0, 0.0, 0.0) 		; OrcTableSquare01 [STAT:00042D32]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x42D3D, "Skyrim.esm"), -40.0, 0.0, 0.0, 0.0) 		; OrcTableRound01 [STAT:00042D3D]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x63DEE, "Skyrim.esm"), -70.0, 0.0, -10.0, 0.0) 		; DweFurnitureTableA01 [STAT:00063DEE]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x63DEF, "Skyrim.esm"), -70.0, 0.0, -10.0, 0.0) 		; DweFurnitureTableA02 [STAT:00063DEF]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x889AF, "Skyrim.esm"), 52.0, 0.0, -10.0, 180.0) 		; DweFurnitureTableAThin01 [STAT:000889AF]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x889B0, "Skyrim.esm"), 68.0, 0.0, -10.0, 180.0) 		; DweFurnitureTableSqA01 [STAT:000889B0]
		; Counter
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x6CF36, "Skyrim.esm"), 22.0, 0.0, 0.0, 0.0) 		; CounterLeanMarker [FURN:0006CF36]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xF507A, "Skyrim.esm"), 22.0, 0.0, 0.0, 0.0) 		; CounterBarLeanMarker [FURN:000F507A]
		; Workbench
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xC4328, "Skyrim.esm"), 25.0, 0.0, 0.0, 0.0) 		; HammerTableMarker [FURN:000C4328]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xD932F, "Skyrim.esm"), 0.0, -26.0, 0.0, 90.0) 		; CraftingBlacksmithArmorWorkbench "Workbench" [FURN:000D932F]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xC4D4E, "Skyrim.esm"), -25.0, 0.0, 0.0, 0.0) 		; NobleCupboard01 "Cupboard" [CONT:000C4D4E] muy chico
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xC4D4F, "Skyrim.esm"), -50.0, 0.0, 0.0, 0.0) 		; NobleCupboard02 "Cupboard" [CONT:000C4D4F]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xC2A06, "Skyrim.esm"), -20.0, 0.0, -1.0, 0.0) 		; NobleNightTable01 "End Table" [CONT:000C2A06]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x42D91, "Skyrim.esm"), -28.5, 0.0, -2.0, 0.0) 		; OrcEndTable01 "End Table" [CONT:00042D91]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x24CA6, "Skyrim.esm"), -27.0, 0.0, -2.0, 0.0) 		; EndTable01 "End Table" [CONT:00024CA6]
		; Wall
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xCE0AD, "Skyrim.esm"), 0.0, 35.0, 10.0, 90.0) 		; MetalCageLongDouble
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xCE0AE, "Skyrim.esm"), 0.0, 35.0, 10.0, 90.0) 		; MetalCageSingle
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xF5BDD, "Skyrim.esm"), 0.0, 35.0, 10.0, 90.0) 		; MetalCageSingleSnow
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xAA041, "Skyrim.esm"), -110.0, -35.0, -87.0, 180.0)	; MetalCage
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x6b303, "Skyrim.esm"), -74.0, 0.0, 0.0, 0.0) 		; NobleWardrobe01 "Wardrobe" [CONT:0006B303]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x109D86, "Skyrim.esm"), -74.0, 0.0, 0.0, 0.0) 		; WinterholdBookCase01 "Bookcase" [CONT:00109D86]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x52FF5, "Skyrim.esm"), 44.0, 0.0, 0.0, 180.0) 		; WallLeanMarker
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x105291, "Skyrim.esm"), -16.5, 0.0, 0.0, 0.0) 		; WallCornerPeekL
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x105299, "Skyrim.esm"), -16.5, 0.0, 0.0, 0.0) 		; WallCornerPeekR
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x727A1, "Skyrim.esm"), 4.0, 0.0, 0.0, 0.0) 			; Tanning Rack
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xC84BE, "Skyrim.esm"), 73.0, 0.0, 0.0, 180.0)		; NobleDivider
		endIf
		
		log("NiOverride:"+SKSE.GetPluginVersion("NiOverride"))
		log("SKEE:"+SKSE.GetPluginVersion("SKEE"))
		log("PapyrusExtender:"+SKSE.GetPluginVersion("PapyrusExtender"))
		log("po3_PapyrusExtender:"+SKSE.GetPluginVersion("po3_PapyrusExtender"))
		log("powerofthree's Papyrus Extender:"+SKSE.GetPluginVersion("powerofthree's Papyrus Extender"))
		if UseAdvancedFurn && (SKSE.GetPluginVersion("PapyrusExtender") < 2 && SKSE.GetPluginVersion("powerofthree's Papyrus Extender") < 4); Relay on the PO3_SKSEFunctions, so need to be checked on each load game.
			UseAdvancedFurn = false
		endIf
		
		int r
		if !AllowFurniture && !ActiveFurnitureTags
			sslFurnitureMarkers.DisableAnimObjectsByFurnitureTag("Bed")
			sslFurnitureMarkers.DisableAnimObjectsByFurnitureTag("BedRoll")
			sslFurnitureMarkers.DisableAnimObjectsByFurnitureTag("DoubleBed")
			r = FurnitureTags.Length
			ActiveFurnitureTags = Utility.CreateStringArray(r)
			; The array values need to be set one by one to prevent issues.
			while r > 0
				r -= 1
				ActiveFurnitureTags[r] = FurnitureTags[r]
				if UseAdvancedFurn && SKSE.GetScriptVersionRelease() >= 64
					sslFurnitureMarkers.DisableAnimObjectsByFurnitureTag(ActiveFurnitureTags[r])
				endIf
			endWhile
		ElseIf UseAdvancedFurn && SKSE.GetScriptVersionRelease() >= 64	; Check and toggle the furniture AnimObjects
			r = ActiveFurnitureTags.Length
			While r
				r -= 1
				sslFurnitureMarkers.DisableAnimObjectsByFurnitureTag(ActiveFurnitureTags[r])
			endWhile
		endIf

		if Game.GetModByName("Dawnguard.esm") != 255 && !HasCustomFurniture(Game.GetFormFromFile(0xCCF3, "Dawnguard.esm"), FurnitureTags.Find("Coffin"))
			Log("Updating furnitures for mod 'Dawnguard.esm'")
			r = FurnitureTags.Find("Chair")
			AddCustomFurniture(Game.GetFormFromFile(0x1A959, "Dawnguard.esm"), r)
			
			r = FurnitureTags.Find("Throne")
			AddCustomFurniture(Game.GetFormFromFile(0x705F, "Dawnguard.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x19A7D, "Dawnguard.esm"), r)
			
			r = FurnitureTags.Find("Bench")
			AddCustomFurniture(Game.GetFormFromFile(0xCD5D, "Dawnguard.esm"), r)
			
			r = FurnitureTags.Find("Coffin")
			AddCustomFurniture(Game.GetFormFromFile(0x8E40, "Dawnguard.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0xCCF0, "Dawnguard.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0xCCF1, "Dawnguard.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0xCCF2, "Dawnguard.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0xCCF3, "Dawnguard.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0xCCF3, "Dawnguard.esm"), r)
		endIf
		
		if Game.GetModByName("HearthFires.esm") != 255 && GetFurnitureOffsets(Game.GetFormFromFile(0x5A9F, "HearthFires.esm"))[0] != 24.0
			Log("Updating furnitures for mod 'HearthFires.esm'")
			r = FurnitureTags.Find("Workbench")
			AddCustomFurniture(Game.GetFormFromFile(0x3065, "HearthFires.esm"), r)		; BYOHHouseCarpentersWorkbench
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x3065, "HearthFires.esm"), 20.0, 0.0, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x30DA, "HearthFires.esm"), r)		; BYOHHouseInteriorWorkbenchRoom01A
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x30DA, "HearthFires.esm"), 24.0, 0.0, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x30F2, "HearthFires.esm"), r)		; BYOHHouseInteriorWorkbenchRoom02_main
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x30F2, "HearthFires.esm"), 24.0, 0.0, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x3129, "HearthFires.esm"), r)		; BYOHHouseInteriorWorkbenchRoom01B
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x3129, "HearthFires.esm"), 24.0, 0.0, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x3AEE, "HearthFires.esm"), r)		; BYOHHouseInteriorWorkbenchRoom03
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x3AEE, "HearthFires.esm"), 24.0, 0.0, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x3AF9, "HearthFires.esm"), r)		; BYOHHouseInteriorWorkbenchRoom04
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x3AF9, "HearthFires.esm"), 24.0, 0.0, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x3AFA, "HearthFires.esm"), r)		; BYOHHouseInteriorWorkbenchRoom05
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x3AFA, "HearthFires.esm"), 24.0, 0.0, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x3AFB, "HearthFires.esm"), r)		; BYOHHouseInteriorWorkbenchRoom06
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x3AFB, "HearthFires.esm"), 24.0, 0.0, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x3AFC, "HearthFires.esm"), r)		; BYOHHouseInteriorWorkbenchRoom07
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x3AFC, "HearthFires.esm"), 24.0, 0.0, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x3AFD, "HearthFires.esm"), r)		; BYOHHouseInteriorWorkbenchRoom08
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x3AFD, "HearthFires.esm"), 24.0, 0.0, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x3AFE, "HearthFires.esm"), r)		; BYOHHouseInteriorWorkbenchRoom09
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x3AFE, "HearthFires.esm"), 24.0, 0.0, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x3AFF, "HearthFires.esm"), r)		; BYOHHouseInteriorWorkbenchRoom10
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x3AFF, "HearthFires.esm"), 24.0, 0.0, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x3B00, "HearthFires.esm"), r)		; BYOHHouseInteriorWorkbenchRoom11
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x3B00, "HearthFires.esm"), 24.0, 0.0, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x3B01, "HearthFires.esm"), r)		; BYOHHouseInteriorWorkbenchRoom12
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x3B01, "HearthFires.esm"), 24.0, 0.0, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x5A9E, "HearthFires.esm"), r)		; BYOHHouseInteriorWorkbenchRoom02_back
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x5A9E, "HearthFires.esm"), 24.0, 0.0, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x5A9F, "HearthFires.esm"), r)		; BYOHHouseInteriorWorkbenchRoom02_bedrooms
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x5A9F, "HearthFires.esm"), 24.0, 0.0, 0.0, 0.0)
			
			r = FurnitureTags.Find("Coffin")
			AddCustomFurniture(Game.GetFormFromFile(0x801, "HearthFires.esm"), r)
			
			r = FurnitureTags.Find("Wall")
			AddCustomFurniture(Game.GetFormFromFile(0x837C, "HearthFires.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x837C, "HearthFires.esm"), -74.0, 0.0, 0.0, 0.0) 		; BYOHHouseNobleWardrobe01 "Wardrobe" [CONT:0300837C]

		endIf
		
		if Game.GetModByName("Dragonborn.esm") != 255 && !HasCustomFurniture(Game.GetFormFromFile(0x2B086, "Dragonborn.esm"), FurnitureTags.Find("Throne"))
			Log("Updating furnitures for mod 'Dragonborn.esm'")
			r = FurnitureTags.Find("Chair")
			AddCustomFurniture(Game.GetFormFromFile(0x2174B, "Dragonborn.esm"), r)	; DLC2DarkElfChair01
		;	AddCustomFurniture(Game.GetFormFromFile(0x36793, "Dragonborn.esm"), r)	; DLC2DarkElfChair01L
		;	AddCustomFurniture(Game.GetFormFromFile(0x36794, "Dragonborn.esm"), r)	; DLC2DarkElfChair01R
			AddCustomFurniture(Game.GetFormFromFile(0x36795, "Dragonborn.esm"), r)	; DLC2DarkElfChair01F

			r = FurnitureTags.Find("Throne")
			AddCustomFurniture(Game.GetFormFromFile(0x2B086, "Dragonborn.esm"), r)

			r = FurnitureTags.Find("Bench")
			AddCustomFurniture(Game.GetFormFromFile(0x2174A, "Dragonborn.esm"), r)
		endIf

		if Game.GetModByName("Campfire.esm") != 255 && GetFurnitureOffsets(Game.GetFormFromFile(0x38691, "Campfire.esm"))[0] != 4.0
			Log("Updating furnitures for mod 'Campfire.esm'")
			AddCustomBed(Game.GetFormFromFile(0x365B0, "Campfire.esm"), 1)	; _Camp_Tent_SmallFur1BR_ACT "Saco de dormir" [ACTI:0F0365B0]
			AddCustomBed(Game.GetFormFromFile(0x624FA, "Campfire.esm"), 1)	; _Camp_Tent_SmallFur2BR_ACT "Saco de dormir" [ACTI:0F0624FA]
			AddCustomBed(Game.GetFormFromFile(0x397AF, "Campfire.esm"), 1)	; _Camp_Tent_LargeFur1BR_ACT "Saco de dormir" [ACTI:0F0397AF]
			AddCustomBed(Game.GetFormFromFile(0x397B0, "Campfire.esm"), 1)	; _Camp_Tent_LargeFur2BR_ACT "Saco de dormir" [ACTI:0F0397B0]
			AddCustomBed(Game.GetFormFromFile(0x397B1, "Campfire.esm"), 1)	; _Camp_Tent_LargeFur3BR_ACT "Saco de dormir" [ACTI:0F0397B1]
			AddCustomBed(Game.GetFormFromFile(0x397B2, "Campfire.esm"), 1)	; _Camp_Tent_LargeFur4BR_ACT "Saco de dormir" [ACTI:0F0397B2]
			AddCustomBed(Game.GetFormFromFile(0x36B69, "Campfire.esm"), 1)	; _Camp_Tent_SmallLeather1BR_ACT "Saco de dormir" [ACTI:0F036B69]
			AddCustomBed(Game.GetFormFromFile(0x397BA, "Campfire.esm"), 1)	; _Camp_Tent_SmallLeather2BR_ACT "Saco de dormir" [ACTI:0F0397BA]
			AddCustomBed(Game.GetFormFromFile(0x397BB, "Campfire.esm"), 1)	; _Camp_Tent_LargeLeather1BR_ACT "Saco de dormir" [ACTI:0F0397BB]
			AddCustomBed(Game.GetFormFromFile(0x397BC, "Campfire.esm"), 1)	; _Camp_Tent_LargeLeather2BR_ACT "Saco de dormir" [ACTI:0F0397BC]
			AddCustomBed(Game.GetFormFromFile(0x397BD, "Campfire.esm"), 1)	; _Camp_Tent_LargeLeather3BR_ACT "Saco de dormir" [ACTI:0F0397BD]
			AddCustomBed(Game.GetFormFromFile(0x536E3, "Campfire.esm"), 1)	; _Camp_Tent_HayPile1BR_ACT "Pila de heno" [ACTI:0F0536E3]
			AddCustomBed(Game.GetFormFromFile(0x38CBF, "Campfire.esm"), 1)	; _Camp_Bedroll_NPC_F "Saco de dormir" [FURN:0F038CBF]
			AddCustomBed(Game.GetFormFromFile(0x3900D, "Campfire.esm"), 1)	; _Camp_Bedroll_SpouseF "Saco de dormir" [FURN:0F03900D]
		;	AddCustomBed(Game.GetFormFromFile(0x36587, "Campfire.esm"), 1)	; _Camp_TentLayDownMarker "Acostarse" [FURN:0F036587]
		;	SetCustomBedOffset(Game.GetFormFromFile(0x36587, "Campfire.esm"), 0.0, 0.0, 0.0, 180.0)

			AddCustomBed(Game.GetFormFromFile(0x5DE67, "Campfire.esm"), 0)	; _Camp_BedNPC_Common "Cama" [FURN:0F05DE67]
			AddCustomBed(Game.GetFormFromFile(0x5DE68, "Campfire.esm"), 0)	; _Camp_BedNPC_Dwe "Cama" [FURN:0F05DE68]
			AddCustomBed(Game.GetFormFromFile(0x5DE69, "Campfire.esm"), 0)	; _Camp_BedNPC_Noble "Cama" [FURN:0F05DE69]
			AddCustomBed(Game.GetFormFromFile(0x5DE6A, "Campfire.esm"), 0)	; _Camp_BedNPC_Orc "Cama" [FURN:0F05DE6A]
			AddCustomBed(Game.GetFormFromFile(0x5DE6B, "Campfire.esm"), 0)	; _Camp_BedNPC_Upper "Cama" [FURN:0F05DE6B]
			

			r = FurnitureTags.Find("Wall")
			AddCustomFurniture(Game.GetFormFromFile(0x38691, "Campfire.esm"), r)	; _Camp_TanningRack "Soporte para curtir pieles" [FURN:0F038691]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x38691, "Campfire.esm"), 4.0, 0.0, 0.0, 0.0)

		endIf
		
		if Game.GetModByName("MiasLair.esp") != 255 && !HasCustomFurniture(Game.GetFormFromFile(0x35FF0, "MiasLair.esp"), FurnitureTags.Find("XCross"))
			Log("Updating furnitures for mod 'MiasLair.esp'")

			AddCustomBed(Game.GetFormFromFile(0x2523B, "MiasLair.esp"), 1)	; MiaLayDownMasterbate [FURN:6D02523B]
			SetCustomBedOffset(Game.GetFormFromFile(0x2523B, "MiasLair.esp"), 0.0, 0.0, 0.0, 0.0)	; 

			r = FurnitureTags.Find("Chair")
			AddCustomFurniture(Game.GetFormFromFile(0x2603FB, "MiasLair.esp"), r)	; MiaNobleChairMasterbate02 "Chair" [FURN:6D2603FB]

			r = FurnitureTags.Find("Throne")
			AddCustomFurniture(Game.GetFormFromFile(0xBDEC0, "MiasLair.esp"), r)	; MiaHairThrone "Hair Dresser's Chair" [FURN:6D0BDEC0]

			r = FurnitureTags.Find("Wall")
			AddCustomFurniture(Game.GetFormFromFile(0x2603FC, "MiasLair.esp"), r)	; MIaWallLeanMasturbateMarker [FURN:6D2603FC]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x2603FC, "MiasLair.esp"), 44.0, 0.0, 0.0, 180.0) 		; WallLeanMarker

			r = FurnitureTags.Find("Pillory")
			AddCustomFurniture(Game.GetFormFromFile(0x35FEF, "MiasLair.esp"), r)	; sslPillory01 "Pillory" [FURN:6D035FEF]

			r = FurnitureTags.Find("Rack")
			AddCustomFurniture(Game.GetFormFromFile(0x5A531, "MiasLair.esp"), r)	; sslRack01 "Rack" [FURN:6D05A531]

			r = FurnitureTags.Find("TiltedWheel")
			AddCustomFurniture(Game.GetFormFromFile(0x35FED, "MiasLair.esp"), r)	; sslWheel03 "Tilted Wheel" [FURN:6D035FED]

			r = FurnitureTags.Find("XCross")
			AddCustomFurniture(Game.GetFormFromFile(0x35FF0, "MiasLair.esp"), r)	; sslXCross "X Cross" [FURN:6D035FF0]
		endIf

		if Game.GetModByName("CollegeOfWinterholdImmersive.esp") != 255 && GetFurnitureOffsets(Game.GetFormFromFile(0x224341, "CollegeOfWinterholdImmersive.esp"))[0] != -88.0
			Log("Updating furnitures for mod 'CollegeOfWinterholdImmersive.esp'")

			AddCustomBed(Game.GetFormFromFile(0x224348, "CollegeOfWinterholdImmersive.esp"), 2)	; CWIArchMagesBed "Bed" [FURN:27224348]
	;		SetCustomBedOffset(Game.GetFormFromFile(0x224348, "CollegeOfWinterholdImmersive.esp"), 0.0, 0.0, 39.0, 0.0)

			r = FurnitureTags.Find("Chair")
			AddCustomFurniture(Game.GetFormFromFile(0x32CA0D, "CollegeOfWinterholdImmersive.esp"), r)	; CWIDweFurnitureChair02F "Stone Chair" [FURN:2732CA0D]

			r = FurnitureTags.Find("Throne")
			AddCustomFurniture(Game.GetFormFromFile(0x199F98, "CollegeOfWinterholdImmersive.esp"), r)	; CWIAMThrone "Throne" [FURN:27199F98]
			
			r = FurnitureTags.Find("Wall")
			AddCustomFurniture(Game.GetFormFromFile(0x224341, "CollegeOfWinterholdImmersive.esp"), r)	; CWIWardrobe6 "Armoire" [CONT:27224341]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x224341, "CollegeOfWinterholdImmersive.esp"), -88.0, 0.0, -77.0, 0.0)
			
			r = FurnitureTags.Find("AlchemyWorkbench")
			AddCustomFurniture(Game.GetFormFromFile(0x3581AC, "CollegeOfWinterholdImmersive.esp"), r)	; CWITueffelsAlddAchemy "Alchemy Lab" [FURN:273581AC]

			r = FurnitureTags.Find("EnchantingWorkbench")
			AddCustomFurniture(Game.GetFormFromFile(0x3581AD, "CollegeOfWinterholdImmersive.esp"), r)	; CWITueffelsAddEnchanting "Arcane Enchanter" [FURN:273581AD]
		endIf
		
		if Game.GetModByName("LegacyoftheDragonborn.esm") != 255 && !BedsList.HasForm(Game.GetFormFromFile(0x1C3F8, "LegacyoftheDragonborn.esm"))
			Log("Updating furnitures for mod 'LegacyoftheDragonborn.esm'")
			AddCustomBed(Game.GetFormFromFile(0x1C3F8, "LegacyoftheDragonborn.esm"))	; DBMHammock "Bed" [FURN:0C01C3F8]
			AddCustomBed(Game.GetFormFromFile(0x1C3F9, "LegacyoftheDragonborn.esm"))	; DBMHammockL "Bed" [FURN:0C01C3F9]
			AddCustomBed(Game.GetFormFromFile(0x1C3FA, "LegacyoftheDragonborn.esm"))	; DBMHammockR "Bed" [FURN:0C01C3FA]
			AddCustomBed(Game.GetFormFromFile(0x64F2F, "LegacyoftheDragonborn.esm"))	; NobleBedChildSingle01RDBM "Bed" [FURN:0C064F2F]
			AddCustomBed(Game.GetFormFromFile(0x64F30, "LegacyoftheDragonborn.esm"))	; NobleBedChildSingle01LDBM "Bed" [FURN:0C064F30]
			AddCustomBed(Game.GetFormFromFile(0x1A3B1C, "LegacyoftheDragonborn.esm"))	; UpperBedChildSingle01RDBM "Bed" [FURN:0C1A3B1C]
			AddCustomBed(Game.GetFormFromFile(0x1A3B1D, "LegacyoftheDragonborn.esm"))	; UpperBedChildSingle01LDBM "Bed" [FURN:0C1A3B1D]
			AddCustomBed(Game.GetFormFromFile(0x35CC23, "LegacyoftheDragonborn.esm"), 2)	; DBM_BigBed "Bed" [FURN:0C35CC23]
			AddCustomBed(Game.GetFormFromFile(0x236C92, "LegacyoftheDragonborn.esm"))	; DBM_MAASE_DweFurnitureBedSingle "Stone Bed" [FURN:0C236C92]

			r = FurnitureTags.Find("Chair")
			AddCustomFurniture(Game.GetFormFromFile(0x64F76, "LegacyoftheDragonborn.esm"), r)	; NobleChair02FrontDBMInvisibleVersion "Chair" [FURN:0C064F76]
			AddCustomFurniture(Game.GetFormFromFile(0x24B9A, "LegacyoftheDragonborn.esm"), r)	; CommonChair01WWW "Chair" [FURN:0C124B9A]
			AddCustomFurniture(Game.GetFormFromFile(0x22BAB, "LegacyoftheDragonborn.esm"), r)	; DweFurnitureChair01WWW "Stone Chair" [FURN:0C122BAB]

			r = FurnitureTags.Find("Throne")
			AddCustomFurniture(Game.GetFormFromFile(0x25163F, "LegacyoftheDragonborn.esm"), r)	; DLC1_SnowElfThroneDBM "Throne" [FURN:0C25163F]
			AddCustomFurniture(Game.GetFormFromFile(0x610D4, "LegacyoftheDragonborn.esm"), r)	; DBM_ReadingChair "Chair" [FURN:0C0610D4]
			AddCustomFurniture(Game.GetFormFromFile(0x6E01A9, "LegacyoftheDragonborn.esm"), r)	; DBM_NobleChair01 "Chair" [FURN:0C6E01A9]

			r = FurnitureTags.Find("Bench")
			AddCustomFurniture(Game.GetFormFromFile(0x122BAA, "LegacyoftheDragonborn.esm"), r)	; DweFurnitureBench01WWW "Stone Bench" [FURN:0C122BAA]

		;	r = FurnitureTags.Find("Wall")
		;	AddCustomFurniture(Game.GetFormFromFile(0x, "LegacyoftheDragonborn.esp"), r)	;
		;	SetCustomFurnitureOffsets(Game.GetFormFromFile(0x, "LegacyoftheDragonborn.esp"), 44.0, 0.0, 0.0, 180.0) 		;

			r = FurnitureTags.Find("Workbench")
			AddCustomFurniture(Game.GetFormFromFile(0x348338, "LegacyoftheDragonborn.esm"), r)	; DBM_BYOHHouseCarpentersWorkbench "Carpenter's Workbench" [FURN:0C348338]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x348338, "LegacyoftheDragonborn.esm"), 20.0, 0.0, 0.0, 0.0)
		;	AddCustomFurniture(Game.GetFormFromFile(0x74602F, "LegacyoftheDragonborn.esm"), r)	; DBM_RadiantResearchStation "Research Station" [FURN:0C74602F]
		;	AddCustomFurniture(Game.GetFormFromFile(0x7046AB, "LegacyoftheDragonborn.esm"), r)	; DBM_WritingWorkbench "Scribe's Desk" [FURN:0C7046AB]
		;	AddCustomFurniture(Game.GetFormFromFile(0x35CC01, "LegacyoftheDragonborn.esm"), r)	; ArchaeologyStation "Archaeology Workstation" [FURN:0C35CC01]

			r = FurnitureTags.Find("AlchemyWorkbench")
			AddCustomFurniture(Game.GetFormFromFile(0x64F78, "LegacyoftheDragonborn.esm"), r)	; DBM_AlchemyTableRainsShelter "Alchemy Lab" [FURN:0C064F78]
		endIf

		if Game.GetModByName("Vigilant.esm") != 255 && !BedsList.HasForm(Game.GetFormFromFile(0x119FED, "Vigilant.esm"))
			Log("Updating furnitures for mod 'Vigilant.esm'")
			AddCustomBed(Game.GetFormFromFile(0x119FED, "Vigilant.esm"))	; zzzCHHHFurnitureBedSingle01L "Cama" [FURN:13119FED]

			r = FurnitureTags.Find("Throne")
			AddCustomFurniture(Game.GetFormFromFile(0x368EE, "Vigilant.esm"), r)	; zzzBMLamaeThrone "Trono" [FURN:130368EE]
			AddCustomFurniture(Game.GetFormFromFile(0xE6435, "Vigilant.esm"), r)	; zzzCHWindhelmThrone "Trono" [FURN:130E6435]
			AddCustomFurniture(Game.GetFormFromFile(0xEC0D7, "Vigilant.esm"), r)	; zzzCHSOVThrone01Sittable "Trono" [FURN:130EC0D7]
			AddCustomFurniture(Game.GetFormFromFile(0x1D913D, "Vigilant.esm"), r)	; zzzCHVarlaThrone "Trono" [FURN:131D913D]
			AddCustomFurniture(Game.GetFormFromFile(0x1ECA43, "Vigilant.esm"), r)	; zzzCHDrozelThrone "Trono" [FURN:131ECA43]

			r = FurnitureTags.Find("Bench")
			AddCustomFurniture(Game.GetFormFromFile(0x7FB5A, "Vigilant.esm"), r)	; zzzCHwrBench01 "Banco" [FURN:1307FB5A]
		endIf

		if Game.GetModByName("Dwarfsphere.esp") != 255 && !BedsList.HasForm(Game.GetFormFromFile(0xFDF782, "Dwarfsphere.esp"))
			Log("Updating furnitures for mod 'Dwarfsphere.esp'")
			AddCustomBed(Game.GetFormFromFile(0xFDF782, "Dwarfsphere.esp"))	; DwaSpSSFurnitureBedSingle01L "Bed" [FURN:0EFDF782]

			r = FurnitureTags.Find("Chair")
			AddCustomFurniture(Game.GetFormFromFile(0xFDF781, "Dwarfsphere.esp"), r)	; DwaSpSSFurnitureChair02F "Chair" [FURN:0EFDF781]

			r = FurnitureTags.Find("Throne")
			AddCustomFurniture(Game.GetFormFromFile(0xFE99D6, "Dwarfsphere.esp"), r)	; DwaSpSSThrone "Many-Faced's Tool" [FURN:0EFE99D6]

			r = FurnitureTags.Find("Bench")
			AddCustomFurniture(Game.GetFormFromFile(0xE9F068, "Dwarfsphere.esp"), r)	; DwaSpChFurnitureBench01 "Bench" [FURN:0EE9F068]
		;	AddCustomFurniture(Game.GetFormFromFile(0xFDF785, "Dwarfsphere.esp"), r)	; DDwaSpSSFurnitureBench01 "Bench" [FURN:0EFDF785]

			r = FurnitureTags.Find("BenchTable")
			AddCustomFurniture(Game.GetFormFromFile(0xE9F069, "Dwarfsphere.esp"), r)	; DwaSpChTableOneBench "Table" [FURN:0EE9F069]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0xE9F069, "Dwarfsphere.esp"), -70.0, 0.0, 0.0, 0.0)	; DwaSpChTableOneBench "Table" [FURN:0EE9F069]

			r = FurnitureTags.Find("AlchemyWorkbench")
			AddCustomFurniture(Game.GetFormFromFile(0x67B598, "Dwarfsphere.esp"), r)	; DwaSpCraftingAlchemy "Alchemy Machine" [FURN:0E67B598]

			r = FurnitureTags.Find("EnchantingWorkbench")
			AddCustomFurniture(Game.GetFormFromFile(0xA68B8E, "Dwarfsphere.esp"), r)	; DwaSpCraftingBooks "Typewriter" [FURN:0EA68B8E]
			AddCustomFurniture(Game.GetFormFromFile(0xB235B, "Dwarfsphere.esp"), r)	; DwaSpCraftingEnchantingWorkbench "Soul Extractor" [FURN:0E0B235B]
		endIf

		if Game.GetModByName("Snazzy Furniture and Clutter Overhaul.esp") != 255 && !BedsList.HasForm(Game.GetFormFromFile(0x5905, "Snazzy Furniture and Clutter Overhaul.esp"))
			Log("Updating furnitures for mod 'Snazzy Furniture and Clutter Overhaul.esp'")
			AddCustomBed(Game.GetFormFromFile(0x5905, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01BL_Blue03 "Bed" [FURN:A7005905]
			AddCustomBed(Game.GetFormFromFile(0x5906, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01L_Brown01 "Bed" [FURN:A7005906]
			AddCustomBed(Game.GetFormFromFile(0x5907, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01L_Fur01 "Bed" [FURN:A7005907]
			AddCustomBed(Game.GetFormFromFile(0x5908, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01L_Green01 "Bed" [FURN:A7005908]
			AddCustomBed(Game.GetFormFromFile(0x5909, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01L_Plaid01 "Bed" [FURN:A7005909]
			AddCustomBed(Game.GetFormFromFile(0x590A, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01BL_Plaid02 "Bed" [FURN:A700590A]
			AddCustomBed(Game.GetFormFromFile(0x590B, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01L_Plaid03 "Bed" [FURN:A700590B]
			AddCustomBed(Game.GetFormFromFile(0x590C, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01L_Purple01 "Bed" [FURN:A700590C]
			AddCustomBed(Game.GetFormFromFile(0x590D, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01BL_Purple02 "Bed" [FURN:A700590D]
			AddCustomBed(Game.GetFormFromFile(0x590E, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01L_White01 "Bed" [FURN:A700590E]
			AddCustomBed(Game.GetFormFromFile(0x590F, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01R_Red02 "Bed" [FURN:A700590F]
			AddCustomBed(Game.GetFormFromFile(0x5910, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01R_Red03 "Bed" [FURN:A7005910]
			AddCustomBed(Game.GetFormFromFile(0x5911, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01R_Blue01 "Bed" [FURN:A7005911]
			AddCustomBed(Game.GetFormFromFile(0x5912, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01R_Blue03 "Bed" [FURN:A7005912]
			AddCustomBed(Game.GetFormFromFile(0x5913, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01R_Fur01 "Bed" [FURN:A7005913]
			AddCustomBed(Game.GetFormFromFile(0x5914, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01BR_Green01 "Bed" [FURN:A7005914]
			AddCustomBed(Game.GetFormFromFile(0x5915, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01R_Plaid01 "Bed" [FURN:A7005915]
			AddCustomBed(Game.GetFormFromFile(0x5916, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01R_Plaid02 "Bed" [FURN:A7005916]
			AddCustomBed(Game.GetFormFromFile(0x5917, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01R_Plaid03 "Bed" [FURN:A7005917]
			AddCustomBed(Game.GetFormFromFile(0x5918, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01R_Purple02 "Bed" [FURN:A7005918]
			AddCustomBed(Game.GetFormFromFile(0x5919, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01R_White01 "Bed" [FURN:A7005919]
			AddCustomBed(Game.GetFormFromFile(0x591A, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01R_Blue01 "Bed" [FURN:A700591A]
			AddCustomBed(Game.GetFormFromFile(0x591B, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01R_Blue02 "Bed" [FURN:A700591B]
			AddCustomBed(Game.GetFormFromFile(0x591C, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01R_Blue03 "Bed" [FURN:A700591C]
			AddCustomBed(Game.GetFormFromFile(0x591D, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01R_Brown01 "Bed" [FURN:A700591D]
			AddCustomBed(Game.GetFormFromFile(0x591E, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01R_Fur01 "Bed" [FURN:A700591E]
			AddCustomBed(Game.GetFormFromFile(0x591F, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01R_Green01 "Bed" [FURN:A700591F]
			AddCustomBed(Game.GetFormFromFile(0x5920, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01R_Plaid01 "Bed" [FURN:A7005920]
			AddCustomBed(Game.GetFormFromFile(0x5921, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01R_Plaid02 "Bed" [FURN:A7005921]
			AddCustomBed(Game.GetFormFromFile(0x5922, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01R_Plaid03 "Bed" [FURN:A7005922]
			AddCustomBed(Game.GetFormFromFile(0x5923, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01R_Purple01 "Bed" [FURN:A7005923]
			AddCustomBed(Game.GetFormFromFile(0x5924, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01R_Purple02 "Bed" [FURN:A7005924]
			AddCustomBed(Game.GetFormFromFile(0x5925, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01R_Red02 "Bed" [FURN:A7005925]
			AddCustomBed(Game.GetFormFromFile(0x5926, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01R_Red03 "Bed" [FURN:A7005926]
			AddCustomBed(Game.GetFormFromFile(0x5927, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01R_Red01 "Bed" [FURN:A7005927]
			AddCustomBed(Game.GetFormFromFile(0x5928, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01R_White01 "Bed" [FURN:A7005928]
			AddCustomBed(Game.GetFormFromFile(0x5929, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01L_Blue01 "Bed" [FURN:A7005929]
			AddCustomBed(Game.GetFormFromFile(0x592A, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01L_Blue02 "Bed" [FURN:A700592A]
			AddCustomBed(Game.GetFormFromFile(0x592B, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01L_Blue03 "Bed" [FURN:A700592B]
			AddCustomBed(Game.GetFormFromFile(0x592C, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01L_Brown01 "Bed" [FURN:A700592C]
			AddCustomBed(Game.GetFormFromFile(0x592D, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01BL_Fur01 "Bed" [FURN:A700592D]
			AddCustomBed(Game.GetFormFromFile(0x592E, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01L_Plaid01 "Bed" [FURN:A700592E]
			AddCustomBed(Game.GetFormFromFile(0x592F, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01L_Green01 "Bed" [FURN:A700592F]
			AddCustomBed(Game.GetFormFromFile(0x5930, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01L_Plaid02 "Bed" [FURN:A7005930]
			AddCustomBed(Game.GetFormFromFile(0x5931, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01BL_Plaid03 "Bed" [FURN:A7005931]
			AddCustomBed(Game.GetFormFromFile(0x5932, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01L_Purple01 "Bed" [FURN:A7005932]
			AddCustomBed(Game.GetFormFromFile(0x5933, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01L_Purple02 "Bed" [FURN:A7005933]
			AddCustomBed(Game.GetFormFromFile(0x5934, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01BL_Red02 "Bed" [FURN:A7005934]
			AddCustomBed(Game.GetFormFromFile(0x5935, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01L_Red03 "Bed" [FURN:A7005935]
			AddCustomBed(Game.GetFormFromFile(0x5936, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01BL_Red01 "Bed" [FURN:A7005936]
			AddCustomBed(Game.GetFormFromFile(0x5937, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01L_White01 "Bed" [FURN:A7005937]
			AddCustomBed(Game.GetFormFromFile(0x5938, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01_Blue01 "Bed" [FURN:A7005938]
			AddCustomBed(Game.GetFormFromFile(0x5939, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01_Blue02 "Bed" [FURN:A7005939]
			AddCustomBed(Game.GetFormFromFile(0x593A, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01_Blue03 "Bed" [FURN:A700593A]
			AddCustomBed(Game.GetFormFromFile(0x593B, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01_Brown01 "Bed" [FURN:A700593B]
			AddCustomBed(Game.GetFormFromFile(0x593C, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01_Fur01 "Bed" [FURN:A700593C]
			AddCustomBed(Game.GetFormFromFile(0x593D, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01_Green01 "Bed" [FURN:A700593D]
			AddCustomBed(Game.GetFormFromFile(0x593E, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01_Plaid01 "Bed" [FURN:A700593E]
			AddCustomBed(Game.GetFormFromFile(0x593F, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01_Plaid02 "Bed" [FURN:A700593F]
			AddCustomBed(Game.GetFormFromFile(0x5940, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01_Plaid03 "Bed" [FURN:A7005940]
			AddCustomBed(Game.GetFormFromFile(0x5941, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01B_Purple01 "Bed" [FURN:A7005941]
			AddCustomBed(Game.GetFormFromFile(0x5942, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01_Purple02 "Bed" [FURN:A7005942]
			AddCustomBed(Game.GetFormFromFile(0x5943, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01_Red02 "Bed" [FURN:A7005943]
			AddCustomBed(Game.GetFormFromFile(0x5944, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01B_Red03 "Bed" [FURN:A7005944]
			AddCustomBed(Game.GetFormFromFile(0x5945, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01_Red01 "Bed" [FURN:A7005945]
			AddCustomBed(Game.GetFormFromFile(0x5946, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01_White01 "Bed" [FURN:A7005946]
			AddCustomBed(Game.GetFormFromFile(0x70B2DD, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01BL_Blue01 "Bed" [FURN:A770B2DD]
			AddCustomBed(Game.GetFormFromFile(0x70B2DE, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01L_Red01 "Bed" [FURN:A770B2DE]
			AddCustomBed(Game.GetFormFromFile(0x70B2DF, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01L_Red03 "Bed" [FURN:A770B2DF]
			AddCustomBed(Game.GetFormFromFile(0x70B2E0, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01L_Red02 "Bed" [FURN:A770B2E0]
			AddCustomBed(Game.GetFormFromFile(0x7155AC, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01BL_White01 "Bed" [FURN:A77155AC]
			AddCustomBed(Game.GetFormFromFile(0x854D3D, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01B_Blue01 "Bed" [FURN:A7854D3D]
			AddCustomBed(Game.GetFormFromFile(0x854D3E, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01B_Plaid01 "Bed" [FURN:A7854D3E]
			AddCustomBed(Game.GetFormFromFile(0x854D3F, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01BR_Purple02 "Bed" [FURN:A7854D3F]
			AddCustomBed(Game.GetFormFromFile(0x854D40, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedChildSingle01BR_Plaid01 "Bed" [FURN:A7854D40]
			AddCustomBed(Game.GetFormFromFile(0x854D44, "Snazzy Furniture and Clutter Overhaul.esp"))	; GM_NobleBedSingle01BL_Green01 "Bed" [FURN:A7854D44]
			AddCustomBed(Game.GetFormFromFile(0x5947, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02L_Blue01 "Bed" [FURN:A7005947]
			AddCustomBed(Game.GetFormFromFile(0x5948, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02L_Blue02a "Bed" [FURN:A7005948]
			AddCustomBed(Game.GetFormFromFile(0x5949, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02L_Blue03 "Bed" [FURN:A7005949]
			AddCustomBed(Game.GetFormFromFile(0x594A, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02L_Brown02 "Bed" [FURN:A700594A]
			AddCustomBed(Game.GetFormFromFile(0x594B, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02L_Fur01a "Bed" [FURN:A700594B]
			AddCustomBed(Game.GetFormFromFile(0x594C, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02L_Green01 "Bed" [FURN:A700594C]
			AddCustomBed(Game.GetFormFromFile(0x594D, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02L_Plaid01a "Bed" [FURN:A700594D]
			AddCustomBed(Game.GetFormFromFile(0x594E, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02L_Plaid02 "Bed" [FURN:A700594E]
			AddCustomBed(Game.GetFormFromFile(0x594F, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02L_Plaid03a "Bed" [FURN:A700594F]
			AddCustomBed(Game.GetFormFromFile(0x5950, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02L_Purple02 "Bed" [FURN:A7005950]
			AddCustomBed(Game.GetFormFromFile(0x5951, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02L_Red02a "Bed" [FURN:A7005951]
			AddCustomBed(Game.GetFormFromFile(0x5952, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02_Blue01 "Bed" [FURN:A7005952]
			AddCustomBed(Game.GetFormFromFile(0x5953, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02_Blue02a "Bed" [FURN:A7005953]
			AddCustomBed(Game.GetFormFromFile(0x5954, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02_Blue03 "Bed" [FURN:A7005954]
			AddCustomBed(Game.GetFormFromFile(0x5956, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02_Brown02 "Bed" [FURN:A7005956]
			AddCustomBed(Game.GetFormFromFile(0x596C, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01B_Plaid03 "Bed" [FURN:A700596C]
			AddCustomBed(Game.GetFormFromFile(0x596F, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01_Red01 "Bed" [FURN:A700596F]
			AddCustomBed(Game.GetFormFromFile(0xAA74, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01R_Plaid02 "Bed" [FURN:A700AA74]
			AddCustomBed(Game.GetFormFromFile(0x70B2C2, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01_White01 "Bed" [FURN:A770B2C2]
			AddCustomBed(Game.GetFormFromFile(0x70B2C3, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01_Red03 "Bed" [FURN:A770B2C3]
			AddCustomBed(Game.GetFormFromFile(0x70B2C4, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01_Red02 "Bed" [FURN:A770B2C4]
			AddCustomBed(Game.GetFormFromFile(0x70B2C5, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01_Purple02 "Bed" [FURN:A770B2C5]
			AddCustomBed(Game.GetFormFromFile(0x70B2C6, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01_Purple01 "Bed" [FURN:A770B2C6]
			AddCustomBed(Game.GetFormFromFile(0x70B2C7, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01_Plaid02 "Bed" [FURN:A770B2C7]
			AddCustomBed(Game.GetFormFromFile(0x70B2C8, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01_Plaid01 "Bed" [FURN:A770B2C8]
			AddCustomBed(Game.GetFormFromFile(0x70B2C9, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01_Green01 "Bed" [FURN:A770B2C9]
			AddCustomBed(Game.GetFormFromFile(0x70B2CA, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01_Fur01 "Bed" [FURN:A770B2CA]
			AddCustomBed(Game.GetFormFromFile(0x70B2CB, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01B_Brown02 "Bed" [FURN:A770B2CB]
			AddCustomBed(Game.GetFormFromFile(0x70B2CC, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01_Brown01 "Bed" [FURN:A770B2CC]
			AddCustomBed(Game.GetFormFromFile(0x70B2CD, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01B_Blue03 "Bed" [FURN:A770B2CD]
			AddCustomBed(Game.GetFormFromFile(0x70B2CE, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01_Blue02 "Bed" [FURN:A770B2CE]
			AddCustomBed(Game.GetFormFromFile(0x70B2CF, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01_Blue01 "Bed" [FURN:A770B2CF]
			AddCustomBed(Game.GetFormFromFile(0x70B2D0, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01L_Red03 "Bed" [FURN:A770B2D0]
			AddCustomBed(Game.GetFormFromFile(0x70B2D1, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01R_Blue03 "Bed" [FURN:A770B2D1]
			AddCustomBed(Game.GetFormFromFile(0x70B2D2, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02_White01 "Bed" [FURN:A770B2D2]
			AddCustomBed(Game.GetFormFromFile(0x70B2D3, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02_Red02a "Bed" [FURN:A770B2D3]
			AddCustomBed(Game.GetFormFromFile(0x70B2D4, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02_Red01 "Bed" [FURN:A770B2D4]
			AddCustomBed(Game.GetFormFromFile(0x70B2D5, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02_Purple02 "Bed" [FURN:A770B2D5]
			AddCustomBed(Game.GetFormFromFile(0x70B2D6, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02_Purple01 "Bed" [FURN:A770B2D6]
			AddCustomBed(Game.GetFormFromFile(0x70B2D7, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02_Plaid03a "Bed" [FURN:A770B2D7]
			AddCustomBed(Game.GetFormFromFile(0x70B2D8, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02_Plaid02 "Bed" [FURN:A770B2D8]
			AddCustomBed(Game.GetFormFromFile(0x70B2D9, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02_Plaid01a "Bed" [FURN:A770B2D9]
			AddCustomBed(Game.GetFormFromFile(0x70B2DA, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02_Green01 "Bed" [FURN:A770B2DA]
			AddCustomBed(Game.GetFormFromFile(0x70B2DB, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02_Fur01a "Bed" [FURN:A770B2DB]
			AddCustomBed(Game.GetFormFromFile(0x70B2DC, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble02_Brown01 "Bed" [FURN:A770B2DC]
			AddCustomBed(Game.GetFormFromFile(0x84FC38, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01C_Blue01 "Bed" [FURN:A784FC38]
			AddCustomBed(Game.GetFormFromFile(0x854D3B, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01C_Brown01 "Bed" [FURN:A7854D3B]
			AddCustomBed(Game.GetFormFromFile(0x854D3C, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01C_Purple02 "Bed" [FURN:A7854D3C]
			AddCustomBed(Game.GetFormFromFile(0x854D41, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01C_White01 "Bed" [FURN:A7854D41]
			AddCustomBed(Game.GetFormFromFile(0x854D42, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01C_Plaid03 "Bed" [FURN:A7854D42]
			AddCustomBed(Game.GetFormFromFile(0x854D43, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01B_Plaid02 "Bed" [FURN:A7854D43]
			AddCustomBed(Game.GetFormFromFile(0x854D45, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01C_Red03 "Bed" [FURN:A7854D45]
			AddCustomBed(Game.GetFormFromFile(0x854D46, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01C_Blue03 "Bed" [FURN:A7854D46]
			AddCustomBed(Game.GetFormFromFile(0x854D47, "Snazzy Furniture and Clutter Overhaul.esp"), 2)	; GM_NobleBedDouble01C_Blue02 "Bed" [FURN:A7854D47]

			r = FurnitureTags.Find("Chair")
			AddCustomFurniture(Game.GetFormFromFile(0x5A5A, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_NobleChair01_Aqua "Chair" [FURN:A7005A5A]
			AddCustomFurniture(Game.GetFormFromFile(0x5A5B, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_NobleChair01_Blue "Chair" [FURN:A7005A5B]
			AddCustomFurniture(Game.GetFormFromFile(0x5A5C, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_NobleChair01_Gold "Chair" [FURN:A7005A5C]
			AddCustomFurniture(Game.GetFormFromFile(0x5A5E, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_NobleChair01_Green "Chair" [FURN:A7005A5E]
			AddCustomFurniture(Game.GetFormFromFile(0x5A5F, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_NobleChair01_Purple "Chair" [FURN:A7005A5F]
			AddCustomFurniture(Game.GetFormFromFile(0x5A60, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_NobleChair01_Red "Chair" [FURN:A7005A60]
			AddCustomFurniture(Game.GetFormFromFile(0x5A62, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_NobleChair01_White "Chair" [FURN:A7005A62]
			AddCustomFurniture(Game.GetFormFromFile(0x5A97, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_NobleChair02Front_Aqua "Chair" [FURN:A7005A97]
			AddCustomFurniture(Game.GetFormFromFile(0x5A98, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_NobleChair02Front_Blue "Chair" [FURN:A7005A98]
			AddCustomFurniture(Game.GetFormFromFile(0x5A99, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_NobleChair02Front_Gold "Chair" [FURN:A7005A99]
			AddCustomFurniture(Game.GetFormFromFile(0x5A9A, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_NobleChair02Front_Green "Chair" [FURN:A7005A9A]
			AddCustomFurniture(Game.GetFormFromFile(0x5A9B, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_NobleChair02Front_Purple "Chair" [FURN:A7005A9B]
			AddCustomFurniture(Game.GetFormFromFile(0x5A9C, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_NobleChair02Front_Red "Chair" [FURN:A7005A9C]
			AddCustomFurniture(Game.GetFormFromFile(0x5A9D, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_NobleChair02Front_White "Chair" [FURN:A7005A9D]
			AddCustomFurniture(Game.GetFormFromFile(0xFCD3, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_NobleChair02FrontIgnoreSandbox_Red "Chair" [FURN:A700FCD3]
			AddCustomFurniture(Game.GetFormFromFile(0x24116, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_NobleChair02FrontIgnoreSandbox_Green "Chair" [FURN:A7024116]
		;	AddCustomFurniture(Game.GetFormFromFile(0x729A4B, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_RockingHorse03 "Chair" [FURN:A7729A4B]
		;	AddCustomFurniture(Game.GetFormFromFile(0x729A4C, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_RockingHorse04 "Chair" [FURN:A7729A4C]

			r = FurnitureTags.Find("Throne")
			AddCustomFurniture(Game.GetFormFromFile(0x784E75, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_ThroneRiften01_Red "Throne" [FURN:A7784E75]
			AddCustomFurniture(Game.GetFormFromFile(0x86914D, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_ThroneRiften01_Blue "Throne" [FURN:A786914D]
			AddCustomFurniture(Game.GetFormFromFile(0x86914E, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_ThroneRiften01_Brown "Throne" [FURN:A786914E]

			r = FurnitureTags.Find("AlchemyWorkbench")
			AddCustomFurniture(Game.GetFormFromFile(0x7A8638, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingAlchemyWorkbenchDWEMER "Alchemy Lab" [FURN:A77A8638]
			AddCustomFurniture(Game.GetFormFromFile(0x7A8639, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingAlchemyWorkbenchNOBLE "Alchemy Lab" [FURN:A77A8639]
			AddCustomFurniture(Game.GetFormFromFile(0x7A863A, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingAlchemyWorkbenchREVAMP "Alchemy Lab" [FURN:A77A863A]
			AddCustomFurniture(Game.GetFormFromFile(0x7A863B, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingAlchemyWorkbenchSHABBY02 "Alchemy Lab" [FURN:A77A863B]
			AddCustomFurniture(Game.GetFormFromFile(0x7A863C, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingAlchemyWorkbenchSHABBY "Alchemy Lab" [FURN:A77A863C]
			AddCustomFurniture(Game.GetFormFromFile(0x7A863D, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingAlchemyWorkbenchTabletopDWEMER "Alchemy Lab" [FURN:A77A863D]
			AddCustomFurniture(Game.GetFormFromFile(0x7A863E, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingAlchemyWorkbenchTabletopNOBLE "Alchemy Lab" [FURN:A77A863E]
			AddCustomFurniture(Game.GetFormFromFile(0x7A863F, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingAlchemyWorkbenchTabletopREVAMP "Alchemy Lab" [FURN:A77A863F]
			AddCustomFurniture(Game.GetFormFromFile(0x7A8640, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingAlchemyWorkbenchTabletopSHABBY "Alchemy Lab" [FURN:A77A8640]
			AddCustomFurniture(Game.GetFormFromFile(0x7A8641, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingAlchemyWorkbenchTabletopSHABBY02 "Alchemy Lab" [FURN:A77A8641]
			
			AddCustomFurniture(Game.GetFormFromFile(0x7B7953, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingAlchemyWorkbenchVAMPIRE "Alchemy Lab" [FURN:A77B7953]
			AddCustomFurniture(Game.GetFormFromFile(0x7C6CAD, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingAlchemyWorkbenchTabletopVAMPIRE "Alchemy Lab" [FURN:A77C6CAD]
			AddCustomFurniture(Game.GetFormFromFile(0x7E531E, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingAlchemyWorkbenchSNOW01 "Alchemy Lab" [FURN:A77E531E]
			AddCustomFurniture(Game.GetFormFromFile(0x7E531F, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingAlchemyWorkbenchSNOW02 "Alchemy Lab" [FURN:A77E531F]
			AddCustomFurniture(Game.GetFormFromFile(0x7E5320, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingAlchemyWorkbenchTabletopSNOW01 "Alchemy Lab" [FURN:A77E5320]
			AddCustomFurniture(Game.GetFormFromFile(0x7E5321, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingAlchemyWorkbenchTabletopSNOW02 "Alchemy Lab" [FURN:A77E5321]
			AddCustomFurniture(Game.GetFormFromFile(0x859E49, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; CraftingAlchemyWorkbenchFIXED "Alchemy Lab" [FURN:A7859E49]

			r = FurnitureTags.Find("EnchantingWorkbench")
			AddCustomFurniture(Game.GetFormFromFile(0x7A8642, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingEnchantingWorkbenchDWEMER "Arcane Enchanter" [FURN:A77A8642]
			AddCustomFurniture(Game.GetFormFromFile(0x7A8644, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingEnchantingWorkbenchSHABBY "Arcane Enchanter" [FURN:A77A8644]
			AddCustomFurniture(Game.GetFormFromFile(0x7A8645, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingEnchantingWorkbenchTabletopDWEMER "Arcane Enchanter" [FURN:A77A8645]
			AddCustomFurniture(Game.GetFormFromFile(0x7A8647, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingEnchantingWorkbenchTabletopSHABBY "Arcane Enchanter" [FURN:A77A8647]
			AddCustomFurniture(Game.GetFormFromFile(0x7A8648, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingEnchantingWorkbenchSHABBY02 "Arcane Enchanter" [FURN:A77A8648]
			AddCustomFurniture(Game.GetFormFromFile(0x7A864A, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingEnchantingWorkbenchTabletopSHABBY02 "Arcane Enchanter" [FURN:A77A864A]
			AddCustomFurniture(Game.GetFormFromFile(0x7A864C, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingEnchantingWorkbenchVAMPIRE "Arcane Enchanter" [FURN:A77AD74C]
			AddCustomFurniture(Game.GetFormFromFile(0x7A864D, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingEnchantingWorkbenchTabletopVAMPIRE "Arcane Enchanter" [FURN:A77AD74D]
			AddCustomFurniture(Game.GetFormFromFile(0x7E5322, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingEnchantingWorkbenchSNOW01 "Arcane Enchanter" [FURN:A77E5322]
			AddCustomFurniture(Game.GetFormFromFile(0x7E5323, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingEnchantingWorkbenchSNOW02 "Arcane Enchanter" [FURN:A77E5323]
			AddCustomFurniture(Game.GetFormFromFile(0x7E5324, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingEnchantingWorkbenchTabletopSNOW01 "Arcane Enchanter" [FURN:A77E5324]
			AddCustomFurniture(Game.GetFormFromFile(0x7E5325, "Snazzy Furniture and Clutter Overhaul.esp"), r)	; GM_CraftingEnchantingWorkbenchTabletopSNOW02 "Arcane Enchanter" [FURN:A77E5325]
		endIf

		if Game.GetModByName("FurnitureMarkerSex.esp") != 255 && GetFurnitureOffsets(Game.GetFormFromFile(0x19DB2, "FurnitureMarkerSex.esp"))[0] != 32.0
			Log("Updating furnitures for mod 'FurnitureMarkerSex.esp'")
	;		AddCustomBed(Game.GetFormFromFile(0x7A8BD, "FurnitureMarkerSex.esp"))	; fmMarkerBed [STAT:9207A8BD]
	;		AddCustomBed(Game.GetFormFromFile(0x7A8BD, "FurnitureMarkerSex.esp"), 2)	; fmMarkerDoubleBed [STAT:9207A8BE]

			r = FurnitureTags.Find("Chair")
	;		AddCustomFurniture(Game.GetFormFromFile(0x664A0, "FurnitureMarkerSex.esp"), r)	; fmMarkerChair [STAT:000664A0]
	;		AddCustomFurniture(Game.GetFormFromFile(0x664A1, "FurnitureMarkerSex.esp"), r)	; fmMarkerChairGeneric [STAT:920664A1]
			AddCustomFurniture(Game.GetFormFromFile(0x6B5AD, "FurnitureMarkerSex.esp"), r)	; fmMarkerChairLowBack [STAT:9206B5AD]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x6B5AD, "FurnitureMarkerSex.esp"), 29.0, 0.0, 0.0, 0.0)
	;		AddCustomFurniture(Game.GetFormFromFile(0x6B5AE, "FurnitureMarkerSex.esp"), r)	; fmMarkerChairBackless [STAT:9206B5AE]
	;		SetCustomFurnitureOffsets(Game.GetFormFromFile(0x6B5AE, "FurnitureMarkerSex.esp"), 29.0, 0.0, 0.0, 0.0)
	;		AddCustomFurniture(Game.GetFormFromFile(0x6B5AF, "FurnitureMarkerSex.esp"), r)	; fmMarkerChairNoble [STAT:9206B5AF]
	;		SetCustomFurnitureOffsets(Game.GetFormFromFile(0x6B5AF, "FurnitureMarkerSex.esp"), 29.0, 0.0, 0.0, 0.0)

	;		r = FurnitureTags.Find("Throne")
	;		AddCustomFurniture(Game.GetFormFromFile(0x6649F, "FurnitureMarkerSex.esp"), r)	; fmMarkerThrone [STAT:0006649F]
			
	;		r = FurnitureTags.Find("Bench")
	;		AddCustomFurniture(Game.GetFormFromFile(0x19DAF, "FurnitureMarkerSex.esp"), r)	; fmMarkerBench [STAT:00019DAF]
	;		SetCustomFurnitureOffsets(Game.GetFormFromFile(0x19DAF, "FurnitureMarkerSex.esp"), 18.0, 0.0, 0.0, 0.0)

			r = FurnitureTags.Find("Table")
			AddCustomFurniture(Game.GetFormFromFile(0x19DAC, "FurnitureMarkerSex.esp"), r)	; fmMarkerTable [STAT:00019DAC]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x19DAC, "FurnitureMarkerSex.esp"), 36.0, 0.0, 0.0, 0.0)
	;		AddCustomFurniture(Game.GetFormFromFile(0x19DB1, "FurnitureMarkerSex.esp"), r)	; fmMarkerCraftingTable [STAT:00019DB1]
	;		SetCustomFurnitureOffsets(Game.GetFormFromFile(0x19DB1, "FurnitureMarkerSex.esp"), 36.0, 0.0, 0.0, 0.0)

			r = FurnitureTags.Find("Wall")
			AddCustomFurniture(Game.GetFormFromFile(0x19DAB, "FurnitureMarkerSex.esp"), r)	; fmMarkerWall [STAT:00019DAB]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x19DAB, "FurnitureMarkerSex.esp"), -29.0, 0.0, 0.0, 0.0)
			
			r = FurnitureTags.Find("Counter")
			AddCustomFurniture(Game.GetFormFromFile(0x19DB2, "FurnitureMarkerSex.esp"), r)	; fmMarkerCounter [STAT:00019DB2]
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x19DB2, "FurnitureMarkerSex.esp"), 32.0, 0.0, 0.0, 0.0)
		endIf

		if Game.GetModByName("riftrest.esp") != 255 && GetBedOffsets(Game.GetFormFromFile(0x1028E3, "riftrest.esp"))[0] != 20.0
			Log("Updating furnitures for mod 'RiftRest.esp'")
			AddCustomBed(Game.GetFormFromFile(0x1028E3, "riftrest.esp"), 1)	; man_BEDVIPSIT "Bed" [FURN:9C1028E3]
			SetCustomBedOffset(Game.GetFormFromFile(0x1028E3, "riftrest.esp"), 20.0, 0.0, 0.0, 15.0)	; 

			AddCustomBed(Game.GetFormFromFile(0xFFA17, "riftrest.esp"), 2)	; man_BEDVIP "Bed" [FURN:9C0FFA17]
			SetCustomBedOffset(Game.GetFormFromFile(0xFFA17, "riftrest.esp"), 10.0, 0.0, 37.0, 0.0)	; 
		endIf

		if HasZazDevice && !HasCustomFurniture(Game.GetFormFromFile(0x26D41, "ZaZAnimationPack.esm"), FurnitureTags.Find("HorizontalPole"))
			Log("Updating furnitures for mod 'ZaZAnimationPack.esm'")

			r = FurnitureTags.Find("Chair")
			AddCustomFurniture(Game.GetFormFromFile(0x48882, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x48882, "ZaZAnimationPack.esm"), 0.0, -20.0, 50.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x48883, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x48883, "ZaZAnimationPack.esm"), 0.0, -20.0, 50.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x48884, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x48884, "ZaZAnimationPack.esm"), 0.0, -20.0, 50.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x48885, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x48885, "ZaZAnimationPack.esm"), 0.0, -20.0, 50.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x48886, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x48886, "ZaZAnimationPack.esm"), 0.0, -20.0, 50.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x48887, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x48887, "ZaZAnimationPack.esm"), 0.0, -20.0, 50.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x48888, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x48888, "ZaZAnimationPack.esm"), 0.0, -20.0, 50.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x59ADC, "ZaZAnimationPack.esm"), r)

			r = FurnitureTags.Find("Throne")
			AddCustomFurniture(Game.GetFormFromFile(0x48881, "ZaZAnimationPack.esm"), r)

			r = FurnitureTags.Find("Stockade")
			AddCustomFurniture(Game.GetFormFromFile(0xFDDF, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x22782, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x26D2D, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3D7DE, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3DD42, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3DD43, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3DD44, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3F844, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3F845, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3F846, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3F84A, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3F84B, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3F84C, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3F850, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3F851, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3F852, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3F856, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3F857, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3F858, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3F85C, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3F85D, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3F85E, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3F862, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3F863, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3F864, "ZaZAnimationPack.esm"), r)

			r = FurnitureTags.Find("Wall")
			AddCustomFurniture(Game.GetFormFromFile(0x61F11, "ZaZAnimationPack.esm"), r)

			r = FurnitureTags.Find("ShackleWall")
			AddCustomFurniture(Game.GetFormFromFile(0x3B6DD, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B6EE, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B6FC, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B6DB, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B6EA, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B700, "ZaZAnimationPack.esm"), r)

			r = FurnitureTags.Find("WoodenHorse")
			AddCustomFurniture(Game.GetFormFromFile(0x5ABE7, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x5B158, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x5B15A, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x5B15C, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x5B15E, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x5B160, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x5B162, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x26D42, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x26D3E, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521BB, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521BC, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521BD, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521BE, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521BF, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521C0, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521C1, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521C2, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521C3, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521C4, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521C5, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521C6, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521C7, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521C8, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521C9, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521CA, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521CB, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x51C37, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521AB, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x51C39, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521AD, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x51C3A, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521AF, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x51C3E, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521B1, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x51C40, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521B3, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x51C42, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521B5, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x51C44, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521B7, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x51C46, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521B9, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521DC, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521DE, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521E0, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x521E2, "ZaZAnimationPack.esm"), r)

			r = FurnitureTags.Find("Table")
			AddCustomFurniture(Game.GetFormFromFile(0x488AE, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x488AF, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x488B0, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x488B1, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x488B2, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x488B8, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x488BA, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x488BC, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x488BD, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x488BE, "ZaZAnimationPack.esm"), r)

			r = FurnitureTags.Find("Coffin")
			AddCustomFurniture(Game.GetFormFromFile(0x4DA71, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4DA72, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4DA77, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4DA79, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4DA7B, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4DFEC, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4DFEE, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4DFF0, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x553A1, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x55E77, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x55E7D, "ZaZAnimationPack.esm"), r)
			
			r = FurnitureTags.Find("Pillory")
			AddCustomFurniture(Game.GetFormFromFile(0xFDE1, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x22781, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x22783, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x26383, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x263A4, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x26D43, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3FDE3, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3FDE7, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3FDE9, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3FDEB, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3FDF5, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3FDF6, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3FDF7, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3FDF8, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x41412, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x41419, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4141A, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4141B, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4141F, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x41420, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x41423, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x41429, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4142B, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4142E, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x41430, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x41432, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x41434, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x41436, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x50BC8, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x50BCA, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x50BCC, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x50BCE, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x51BFB, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x51BFD, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x51BFF, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x51C01, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x52209, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x5220A, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x5220B, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x5220C, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x5220D, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x5220E, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x5220F, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x52210, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x52211, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x52212, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x52213, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x52214, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x60E51, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x74A4E, "ZaZAnimationPack.esm"), r)

			r = FurnitureTags.Find("Pole")
			AddCustomFurniture(Game.GetFormFromFile(0x44AB2, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x44AB4, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x44AB5, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x44AB6, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x44ABA, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x44ABB, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x44ABC, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x44ABD, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45624, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45625, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45626, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45627, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45628, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45629, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45630, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45631, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45632, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45633, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45634, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45635, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45636, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45637, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45638, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45639, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4563A, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4563B, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4563C, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4563D, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4563E, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4563F, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45640, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45641, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x5D259, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x5D259, "ZaZAnimationPack.esm"), 16.5, 18.5, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x5D25B, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x5D25B, "ZaZAnimationPack.esm"), 16.5, 18.5, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x5D25D, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x5D25D, "ZaZAnimationPack.esm"), 16.5, 18.5, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x5D25F, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x5D25F, "ZaZAnimationPack.esm"), 16.5, 18.5, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x5D261, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x5D261, "ZaZAnimationPack.esm"), 16.5, 18.5, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x5D263, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x5D263, "ZaZAnimationPack.esm"), 16.5, 18.5, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x5D265, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x5D265, "ZaZAnimationPack.esm"), 16.5, 18.5, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x5D267, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x5D267, "ZaZAnimationPack.esm"), 16.5, 18.5, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x5D269, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x5D269, "ZaZAnimationPack.esm"), 16.5, 18.5, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x5D272, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x5D272, "ZaZAnimationPack.esm"), 16.5, 18.5, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x686AB, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x686AB, "ZaZAnimationPack.esm"), 16.5, 18.5, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x686AC, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x686AC, "ZaZAnimationPack.esm"), 16.5, 18.5, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x686AD, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x686AD, "ZaZAnimationPack.esm"), 16.5, 18.5, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x686AE, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x686AE, "ZaZAnimationPack.esm"), 16.5, 18.5, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x686AF, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x686AF, "ZaZAnimationPack.esm"), 16.5, 18.5, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x686B0, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x686B0, "ZaZAnimationPack.esm"), 16.5, 18.5, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x686B1, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x686B1, "ZaZAnimationPack.esm"), 16.5, 18.5, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x686B2, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x686B2, "ZaZAnimationPack.esm"), 16.5, 18.5, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x686B3, "ZaZAnimationPack.esm"), r)
			SetCustomFurnitureOffsets(Game.GetFormFromFile(0x686B3, "ZaZAnimationPack.esm"), 16.5, 18.5, 0.0, 0.0)
			AddCustomFurniture(Game.GetFormFromFile(0x77ADD, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x78046, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x78047, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x78048, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x78049, "ZaZAnimationPack.esm"), r)
			
			r = FurnitureTags.Find("RPost1")
			AddCustomFurniture(Game.GetFormFromFile(0x3B117, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B12F, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B135, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B13B, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x54E38, "ZaZAnimationPack.esm"), r)

			r = FurnitureTags.Find("RPost2")
			AddCustomFurniture(Game.GetFormFromFile(0x3B118, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B130, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B136, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B13C, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B11E, "ZaZAnimationPack.esm"), r)

			r = FurnitureTags.Find("RPost3")
			AddCustomFurniture(Game.GetFormFromFile(0x3B119, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B131, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B137, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B13D, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B11F, "ZaZAnimationPack.esm"), r)

			r = FurnitureTags.Find("RPost4")
			AddCustomFurniture(Game.GetFormFromFile(0x3B11A, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B132, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B138, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B13E, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B120, "ZaZAnimationPack.esm"), r)

			r = FurnitureTags.Find("RPost5")
			AddCustomFurniture(Game.GetFormFromFile(0x3B11B, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B133, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B139, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B13F, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B121, "ZaZAnimationPack.esm"), r)

			r = FurnitureTags.Find("RPost6")
			AddCustomFurniture(Game.GetFormFromFile(0x3B11C, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B134, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B13A, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B140, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3B122, "ZaZAnimationPack.esm"), r)

			r = FurnitureTags.Find("TiltedWheel")
			AddCustomFurniture(Game.GetFormFromFile(0xFDE0, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45BCC, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45BCD, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4F5D3, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4FB3B, "ZaZAnimationPack.esm"), r)

			r = FurnitureTags.Find("Rack")
			AddCustomFurniture(Game.GetFormFromFile(0xE2BF, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x3FE05, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4A999, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4A99B, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4A99D, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x4A99F, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x6451E, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x65005, "ZaZAnimationPack.esm"), r)

			r = FurnitureTags.Find("XCross")
			AddCustomFurniture(Game.GetFormFromFile(0xD7E0, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x2277F, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x232E7, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x26D2F, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x26D3B, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419C8, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419CA, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419CB, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419CC, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419D0, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419D2, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419D4, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419D6, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419D8, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419D9, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419DC, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419DE, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419E0, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419E2, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419E4, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419E6, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419E8, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419EA, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419EC, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419EE, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419F0, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419F2, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419F4, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419F6, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419F8, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419FA, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419FC, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x419FE, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x41A00, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x41A02, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x41A04, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x41A06, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45BD0, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45BD1, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45BCD, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x45BCF, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x500AF, "ZaZAnimationPack.esm"), r)
			AddCustomFurniture(Game.GetFormFromFile(0x500B1, "ZaZAnimationPack.esm"), r)
			
			r = FurnitureTags.Find("HorizontalPole")
			AddCustomFurniture(Game.GetFormFromFile(0x7dc1d, "ZaZAnimationPack.esm"), r) ;HorizontalPole
			AddCustomFurniture(Game.GetFormFromFile(0x26D41, "ZaZAnimationPack.esm"), r) ;SpitRost
		endIf
	endIf

	; Clean valid actors list
	StorageUtil.FormListRemove(self, "ValidActors", PlayerRef, true)
	StorageUtil.FormListRemove(self, "ValidActors", none, true)

	if GetBedOffsets(Game.GetFormFromFile(0xB8371, "Skyrim.esm"))[3] != 180.0
		SetCustomBedOffset(Game.GetFormFromFile(0xB8371, "Skyrim.esm"), 0.0, 0.0, 0.0, 180.0) 	; BedRoll Ground
	endIf
	Form DA02Altar = Game.GetFormFromFile(0x5ED79, "Skyrim.esm")
	if DA02Altar && !BedsList.HasForm(DA02Altar)
		BedsList.AddForm(DA02Altar)
		BedRollsList.AddForm(DA02Altar)
	endIf
	Form CivilWarCot01L = Game.GetFormFromFile(0xE2826, "Skyrim.esm")
	if CivilWarCot01L && !BedsList.HasForm(CivilWarCot01L)
		BedsList.AddForm(CivilWarCot01L)
	endIf
	Form WRTempleHealingAltar01 = Game.GetFormFromFile(0xD4848, "Skyrim.esm")
	if WRTempleHealingAltar01 && !BedsList.HasForm(WRTempleHealingAltar01)
		BedsList.AddForm(WRTempleHealingAltar01)
		SetCustomBedOffset(WRTempleHealingAltar01, 0.0, 0.0, 39.0, 90.0)
	endIf
	Form HHFurnitureBedSingle01 = Game.GetFormFromFile(0x2FBC7, "Skyrim.esm")
	if HHFurnitureBedSingle01 && !BedsList.HasForm(HHFurnitureBedSingle01)
		BedsList.AddForm(HHFurnitureBedSingle01)
	endIf
	
	; Dawnguard additions
	if Game.GetModByName("Dawnguard.esm") != 255
		; Serana doesn't have ActorTypeNPC, force validate.
		StorageUtil.FormListAdd(self, "ValidActors", Game.GetFormFromFile(0x2B6C, "Dawnguard.esm"), false)
		; Bedroll
		Form DLC1BedrollGroundF = Game.GetFormFromFile(0xC651, "Dawnguard.esm")
		if DLC1BedrollGroundF && !BedsList.HasForm(DLC1BedrollGroundF)
			BedsList.AddForm(DLC1BedrollGroundF)
			BedRollsList.AddForm(DLC1BedrollGroundF)
			SetCustomBedOffset(DLC1BedrollGroundF, 0.0, 0.0, 0.0, 180.0)
		endIf
	endIf

	; Dragonborn additions
	if Game.GetModByName("Dragonborn.esm") != 255 && !BedsList.HasForm(Game.GetFormFromFile(0x21749, "Dragonborn.esm"))
		Log("Adding Dragonborn beds to formlist...")
		; Single Bed
		Form DLC2DarkElfBed01             = Game.GetFormFromFile(0x21749, "Dragonborn.esm")
		Form DLC2DarkElfBed01R            = Game.GetFormFromFile(0x35037, "Dragonborn.esm")
		Form DLC2DarkElfBed01L            = Game.GetFormFromFile(0x35038, "Dragonborn.esm")
		BedsList.AddForm(DLC2DarkElfBed01)
		BedsList.AddForm(DLC2DarkElfBed01R)
		BedsList.AddForm(DLC2DarkElfBed01L)
		; Double Bed
		Form DLC2DarkElfBedDouble01       = Game.GetFormFromFile(0x32802, "Dragonborn.esm")
		Form DLC2DarkElfBedDouble01R      = Game.GetFormFromFile(0x36796, "Dragonborn.esm")
		Form DLC2DarkElfBedDouble01L      = Game.GetFormFromFile(0x36797, "Dragonborn.esm")
		BedsList.AddForm(DLC2DarkElfBedDouble01)
		BedsList.AddForm(DLC2DarkElfBedDouble01R)
		BedsList.AddForm(DLC2DarkElfBedDouble01L)
		DoubleBedsList.AddForm(DLC2DarkElfBedDouble01)
		DoubleBedsList.AddForm(DLC2DarkElfBedDouble01R)
		DoubleBedsList.AddForm(DLC2DarkElfBedDouble01L)
		; Bedroll
		Form BedRollHay01LDirtSnowPath01F = Game.GetFormFromFile(0x18617, "Dragonborn.esm")
		Form BedRollHay01LDirtSnowPath01R = Game.GetFormFromFile(0x18618, "Dragonborn.esm")
		Form BedRollHay01LDirtSnowPath    = Game.GetFormFromFile(0x1EE28, "Dragonborn.esm")
		Form BedrollHay01IceL             = Game.GetFormFromFile(0x25E51, "Dragonborn.esm")
		Form BedrollHay01IceR             = Game.GetFormFromFile(0x25E52, "Dragonborn.esm")
		Form BedrollHay01R_Ash            = Game.GetFormFromFile(0x28A68, "Dragonborn.esm")
		Form BedrollHay01L_Ash            = Game.GetFormFromFile(0x28AA9, "Dragonborn.esm")
		Form BedrollHay01LDirtPath01L     = Game.GetFormFromFile(0x2C0B2, "Dragonborn.esm")
		Form BedrollHay01LDirtPath01F     = Game.GetFormFromFile(0x2C0B3, "Dragonborn.esm")
		Form BedrollHay01LDirtPath01R     = Game.GetFormFromFile(0x2C0B4, "Dragonborn.esm")
		Form BedrollHay01GlacierL         = Game.GetFormFromFile(0x3D131, "Dragonborn.esm")
		Form BedrollHay01GlacierR         = Game.GetFormFromFile(0x3D132, "Dragonborn.esm")
		BedsList.AddForm(BedRollHay01LDirtSnowPath01F)
		BedsList.AddForm(BedRollHay01LDirtSnowPath01R)
		BedsList.AddForm(BedRollHay01LDirtSnowPath)
		BedsList.AddForm(BedrollHay01IceL)
		BedsList.AddForm(BedrollHay01IceR)
		BedsList.AddForm(BedrollHay01R_Ash)
		BedsList.AddForm(BedrollHay01L_Ash)
		BedsList.AddForm(BedrollHay01LDirtPath01L)
		BedsList.AddForm(BedrollHay01LDirtPath01F)
		BedsList.AddForm(BedrollHay01LDirtPath01R)
		BedsList.AddForm(BedrollHay01GlacierL)
		BedsList.AddForm(BedrollHay01GlacierR)
		BedRollsList.AddForm(BedRollHay01LDirtSnowPath01F)
		BedRollsList.AddForm(BedRollHay01LDirtSnowPath01R)
		BedRollsList.AddForm(BedRollHay01LDirtSnowPath)
		BedRollsList.AddForm(BedrollHay01IceL)
		BedRollsList.AddForm(BedrollHay01IceR)
		BedRollsList.AddForm(BedrollHay01R_Ash)
		BedRollsList.AddForm(BedrollHay01L_Ash)
		BedRollsList.AddForm(BedrollHay01LDirtPath01L)
		BedRollsList.AddForm(BedrollHay01LDirtPath01F)
		BedRollsList.AddForm(BedrollHay01LDirtPath01R)
		BedRollsList.AddForm(BedrollHay01GlacierL)
		BedRollsList.AddForm(BedrollHay01GlacierR)
	endIf

	; Remove gender override if player's gender matches normally
	if PlayerRef.GetFactionRank(GenderFaction) == PlayerRef.GetLeveledActorBase().GetSex()
		PlayerRef.RemoveFromFaction(GenderFaction)
	endIf

	; Clear or register creature animations if it's been toggled
	if !AllowCreatures && CreatureSlots.Slotted > 0
		CreatureSlots.Setup()
	elseIf AllowCreatures && CreatureSlots.Slotted < 1
		CreatureSlots.Setup()
		CreatureSlots.RegisterSlots()
	endIf

	; Remove any NPC thread control player has
	DisableThreadControl(Control)

	; Load json animation profile
	ImportProfile(PapyrusUtil.ClampInt(AnimProfile, 1, 5))

	; Init Thread Hooks
	if !HooksInit
		InitThreadHooks()
	endIf
endFunction

function InitThreadHooks()
	HookCount = 0
	ThreadHooks = new sslThreadHook[64]
	HooksInit = true
endFunction

int function RegisterThreadHook(sslThreadHook Hook)
	if !Hook
		Log("RegisterThreadHook("+Hook+") - INVALID HOOK")
		return -1
	elseIf !HooksInit
		InitThreadHooks()
	elseIf HookCount >= 64
		Log("RegisterThreadHook("+Hook+") - FAILED TO REGISTER, AT CAPACITY")
		return -1
	endIf

	; Find current index
	int idx = ThreadHooks.Find(Hook)

	; Add new hook
	if idx == -1
		idx = ThreadHooks.Find(none)
		ThreadHooks[idx] = Hook
	endIf

	; Update counter if higher than current saved count
	if (idx + 1) > HookCount
		HookCount = (idx + 1)
	endIf 

	Log("RegisterThreadHook("+Hook+") - Registered hook at ["+idx+"/"+HookCount+"]")

	; TODO: Should probably add better error handling incase count ever exceeds 64, but very unlikely.

	return ThreadHooks.Find(Hook)
endFunction

sslThreadHook[] function GetThreadHooks()
	return ThreadHooks
endFunction
int function GetThreadHookCount()
	return HookCount
endFunction

function Setup()
	parent.Setup()
	SetDefaults()
endFunction

function SetDefaults()
	DebugMode = false

	; Booleans
	RestrictAggressive = true
	; AllowCreatures     = false
	NPCSaveVoice       = false
	UseStrapons        = true
	RestrictStrapons   = false
	RedressVictim      = true
	WaitIdles          = false
	RagdollEnd         = false
	UseMaleNudeSuit    = false
	UseFemaleNudeSuit  = false
	UndressAnimation   = false
	UseLipSync         = true
	UseExpressions     = true
	UseFaceItems       = true
	RefreshExpressions = true
	ScaleActors        = false
	UseCum             = true
	AllowFFCum         = false
	DisablePlayer      = false
	AutoTFC            = false
	AutoAdvance        = true
	ForeplayStage      = false
	OrgasmEffects      = false
	RaceAdjustments    = true
	BedRemoveStanding  = true
	UseCreatureGender  = false
	LimitedStrip       = false
	RestrictSameSex    = false
	RestrictGenderTag  = true
	RestrictFetishTags = false
	SeparateOrgasms    = false
	RemoveHeelEffect   = HasHDTHeels
	ManageZadFilter    = HasZadDevice
	ManageZazFilter    = HasZazDevice
	AdjustTargetStage  = false
	ShowInMap          = false
	DisableTeleport    = true
	SeedNPCStats       = true
	HasRaceScale       = DefaultObjects && DefaultObjects.GetForm("SAT1") == Keyword.GetKeyword("RaceToScale")
	DisableScale       = !HasRaceScale
	AllowFurniture     = ActiveFurnitureTags.Length > 0
	UseAdvancedFurn    = false
	UseIntimacyCircle  = false
	FixVictimPos       = false
	LipsFixedValue     = true

	; Integers
	AnimProfile        = 1
	AskBed             = 1
	NPCBed             = 0
	UseXMarkerHidden   = 2
	NPCHidden          = 0
	AskFurniture       = 1
	NPCFurniture       = 0
	OpenMouthSize      = 80
	UseFade            = 0

	Backwards          = 54 ; Right Shift
	AdjustStage        = 157; Right Ctrl
	AdvanceAnimation   = 57 ; Space
	ChangeAnimation    = 24 ; O
	ChangePositions    = 13 ; =
	AdjustChange       = 37 ; K
	AdjustForward      = 38 ; L
	AdjustSideways     = 40 ; '
	AdjustUpward       = 39 ; ;
	RealignActors      = 26 ; [
	MoveScene          = 27 ; ]
	RestoreOffsets     = 12 ; -
	RotateScene        = 22 ; U
	ToggleFreeCamera   = 81 ; NUM 3
	EndAnimation       = 207; End
	TargetActor        = 49 ; N
	AdjustSchlong      = 46 ; C
	LipsSoundTime      = 0  ; Don't Cut
	LipsPhoneme        = 1  ; BigAah
	LipsMinValue       = 20
	LipsMaxValue       = 50


	; Floats
	CumTimer           = 120.0
	ShakeStrength      = 0.7
	AutoSUCSM          = 5.0
	MaleVoiceDelay     = 5.0
	FemaleVoiceDelay   = 4.0
	ExpressionDelay    = 2.0
	VoiceVolume        = 1.0
	SFXDelay           = 3.0
	SFXVolume          = 1.0
	LeadInCoolDown     = 0.0
	LipsMoveTime       = 0.2

	; Boolean strip arrays
	StripMale = new bool[34]
	StripMale[0] = true
	StripMale[1] = true
	StripMale[2] = true
	StripMale[3] = true
	StripMale[7] = true
	StripMale[8] = true
	StripMale[9] = true
	StripMale[4] = true
	StripMale[11] = true
	StripMale[15] = true
	StripMale[16] = true
	StripMale[17] = true
	StripMale[19] = true
	StripMale[23] = true
	StripMale[24] = true
	StripMale[26] = true
	StripMale[27] = true
	StripMale[28] = true
	StripMale[29] = true
	StripMale[32] = true

	StripFemale = new bool[34]
	StripFemale[0] = true
	StripFemale[1] = true
	StripFemale[2] = true
	StripFemale[3] = true
	StripFemale[4] = true
	StripFemale[7] = true
	StripFemale[8] = true
	StripFemale[9] = true
	StripFemale[11] = true
	StripFemale[15] = true
	StripFemale[16] = true
	StripFemale[17] = true
	StripFemale[19] = true
	StripFemale[23] = true
	StripFemale[24] = true
	StripFemale[26] = true
	StripFemale[27] = true
	StripFemale[28] = true
	StripFemale[29] = true
	StripFemale[32] = true

	StripLeadInFemale = new bool[34]
	StripLeadInFemale[0] = true
	StripLeadInFemale[2] = true
	StripLeadInFemale[9] = true
	StripLeadInFemale[14] = true
	StripLeadInFemale[32] = true

	StripLeadInMale = new bool[34]
	StripLeadInMale[0] = true
	StripLeadInMale[2] = true
	StripLeadInMale[8] = true
	StripLeadInMale[9] = true
	; StripLeadInMale[14] = true
	StripLeadInMale[19] = true
	StripLeadInMale[22] = true
	StripLeadInMale[32] = true

	StripVictim = new bool[34]
	StripVictim[1] = true
	StripVictim[2] = true
	StripVictim[4] = true
	StripVictim[9] = true
	StripVictim[11] = true
	StripVictim[16] = true
	StripVictim[24] = true
	StripVictim[26] = true
	StripVictim[28] = true
	StripVictim[32] = true

	StripAggressor = new bool[34]
	StripAggressor[2] = true
	StripAggressor[4] = true
	StripAggressor[9] = true
	StripAggressor[16] = true
	StripAggressor[24] = true
	StripAggressor[26] = true

	; Float timer arrays
	StageTimer = new float[5]
	StageTimer[0] = 30.0
	StageTimer[1] = 20.0
	StageTimer[2] = 15.0
	StageTimer[3] = 15.0
	StageTimer[4] = 9.0

	StageTimerLeadIn = new float[5]
	StageTimerLeadIn[0] = 10.0
	StageTimerLeadIn[1] = 10.0
	StageTimerLeadIn[2] = 10.0
	StageTimerLeadIn[3] = 8.0
	StageTimerLeadIn[4] = 8.0

	StageTimerAggr = new float[5]
	StageTimerAggr[0] = 20.0
	StageTimerAggr[1] = 15.0
	StageTimerAggr[2] = 10.0
	StageTimerAggr[3] = 10.0
	StageTimerAggr[4] = 4.0

	OpenMouthMale = new float[17]
	OpenMouthMale[1] = 0.8
	OpenMouthMale[16] = 16.0

	OpenMouthFemale = new float[17]
	OpenMouthFemale[1] = 1.0
	OpenMouthFemale[16] = 16.0

	int i = FurnitureExtraLists.Length
	while i > 0
		i -= 1
		if FurnitureExtraLists[i] != none
			FurnitureExtraLists[i].Revert()
		endIf
	endWhile
	i = FurnitureRestrainLists.Length
	while i > 0
		i -= 1
		if FurnitureRestrainLists[i] != none
			FurnitureRestrainLists[i].Revert()
		endIf
	endWhile

	Log(StorageUtil.ClearFloatListPrefix("SexLab.") + " Bed and Furniture Offsets Removed from StorageUtil.")

	BedOffset = new float[4]
	BedOffset[0] = 0.0
	BedOffset[2] = 37.0

	FurnitureOffset = new float[4]
	FurnitureOffset[0] = 0
	FurnitureOffset[1] = 0
	FurnitureOffset[2] = 0

	TableOffset = new float[4]
	TableOffset[0] = -68.0
	TableOffset[3] = 0.0

	BenchTableOffset = new float[4]
	BenchTableOffset[0] = -64.0
	BenchTableOffset[3] = 0.0

	; Valid actor types refrence
	;/ ActorTypes = new int[3]
	ActorTypes[0] = 43 ; kNPC
	ActorTypes[1] = 44 ; kLeveledCharacter
	ActorTypes[2] = 62 ; kCharacter /;

	; Reload config
	Reload()

	; Reset data
	LoadStrapons()

	if !HotkeyUp || HotkeyUp.Length != 3 || HotkeyUp.Find(none) != -1
		HotkeyUp = new Sound[3]
		hotkeyUp[0] = Game.GetFormFromFile(0x8AAF0, "SexLab.esm") as Sound
		hotkeyUp[1] = Game.GetFormFromFile(0x8AAF1, "SexLab.esm") as Sound
		hotkeyUp[2] = Game.GetFormFromFile(0x8AAF2, "SexLab.esm") as Sound
	endIf
	if !HotkeyDown || HotkeyDown.Length != 3 || HotkeyDown.Find(none) != -1
		HotkeyDown = new Sound[3]
		hotkeyDown[0] = Game.GetFormFromFile(0x8AAF3, "SexLab.esm") as Sound
		hotkeyDown[1] = Game.GetFormFromFile(0x8AAF4, "SexLab.esm") as Sound
		hotkeyDown[2] = Game.GetFormFromFile(0x8AAF5, "SexLab.esm") as Sound
	endIf

	; Rest some player configurations
	if PlayerRef && PlayerRef != none
		Stats.SetSkill(PlayerRef, "Sexuality", 75)
		VoiceSlots.ForgetVoice(PlayerRef)
	endIf
endFunction

; ------------------------------------------------------- ;
; --- Export/Import to JSON                           --- ;
; ------------------------------------------------------- ;

string File
function ExportSettings()
	File = "../SexLab/SexlabConfig.json"
	JsonUtil.ClearAll(File)
	
	; Set label of export
	JsonUtil.SetStringValue(File, "ExportLabel", PlayerRef.GetLeveledActorBase().GetName()+" - "+Utility.GetCurrentRealTime() as int)

	; Booleans
	ExportBool("RestrictAggressive", RestrictAggressive)
	ExportBool("AllowCreatures", AllowCreatures)
	ExportBool("NPCSaveVoice", NPCSaveVoice)
	ExportBool("UseStrapons", UseStrapons)
	ExportBool("RestrictStrapons", RestrictStrapons)
	ExportBool("RedressVictim", RedressVictim)
	ExportBool("WaitIdles", WaitIdles)
	ExportBool("RagdollEnd", RagdollEnd)
	ExportBool("UseMaleNudeSuit", UseMaleNudeSuit)
	ExportBool("UseFemaleNudeSuit", UseFemaleNudeSuit)
	ExportBool("UndressAnimation", UndressAnimation)
	ExportBool("UseLipSync", UseLipSync)
	ExportBool("UseExpressions", UseExpressions)
	ExportBool("UseFaceItems", UseFaceItems)
	ExportBool("RefreshExpressions", RefreshExpressions)
	ExportBool("ScaleActors", ScaleActors)
	ExportBool("UseCum", UseCum)
	ExportBool("AllowFFCum", AllowFFCum)
	ExportBool("DisablePlayer", DisablePlayer)
	ExportBool("AutoTFC", AutoTFC)
	ExportBool("AutoAdvance", AutoAdvance)
	ExportBool("ForeplayStage", ForeplayStage)
	ExportBool("OrgasmEffects", OrgasmEffects)
	ExportBool("RaceAdjustments", RaceAdjustments)
	ExportBool("BedRemoveStanding", BedRemoveStanding)
	ExportBool("UseCreatureGender", UseCreatureGender)
	ExportBool("LimitedStrip", LimitedStrip)
	ExportBool("RestrictSameSex", RestrictSameSex)
	ExportBool("RestrictGenderTag", RestrictGenderTag)
	ExportBool("RestrictFetishTags", RestrictFetishTags)
	ExportBool("SeparateOrgasms", SeparateOrgasms)
	ExportBool("RemoveHeelEffect", RemoveHeelEffect)
	ExportBool("ManageZadFilter", ManageZadFilter)
	ExportBool("ManageZazFilter", ManageZazFilter)
	ExportBool("AdjustTargetStage", AdjustTargetStage)
	ExportBool("ShowInMap", ShowInMap)
	ExportBool("DisableTeleport", DisableTeleport)
	ExportBool("SeedNPCStats", SeedNPCStats)
	ExportBool("DisableScale", DisableScale)
	ExportBool("AllowFurniture", AllowFurniture)
	ExportBool("UseAdvancedFurn", UseAdvancedFurn)
	ExportBool("UseIntimacyCircle", UseIntimacyCircle)
	ExportBool("FixVictimPos", FixVictimPos)
	ExportBool("LipsFixedValue", LipsFixedValue)

	; Integers
	ExportInt("AnimProfile", AnimProfile)
	ExportInt("AskBed", AskBed)
	ExportInt("NPCBed", NPCBed)
	ExportInt("UseXMarkerHidden", UseXMarkerHidden)
	ExportInt("NPCHidden", NPCHidden)
	ExportInt("AskFurniture", AskFurniture)
	ExportInt("NPCFurniture", NPCFurniture)
	ExportInt("OpenMouthSize", OpenMouthSize)
	ExportInt("UseFade", UseFade)

	ExportInt("Backwards", Backwards)
	ExportInt("AdjustStage", AdjustStage)
	ExportInt("AdvanceAnimation", AdvanceAnimation)
	ExportInt("ChangeAnimation", ChangeAnimation)
	ExportInt("ChangePositions", ChangePositions)
	ExportInt("AdjustChange", AdjustChange)
	ExportInt("AdjustForward", AdjustForward)
	ExportInt("AdjustSideways", AdjustSideways)
	ExportInt("AdjustUpward", AdjustUpward)
	ExportInt("RealignActors", RealignActors)
	ExportInt("MoveScene", MoveScene)
	ExportInt("RestoreOffsets", RestoreOffsets)
	ExportInt("RotateScene", RotateScene)
	ExportInt("EndAnimation", EndAnimation)
	ExportInt("ToggleFreeCamera", ToggleFreeCamera)
	ExportInt("TargetActor", TargetActor)
	ExportInt("AdjustSchlong", AdjustSchlong)
	ExportInt("LipsSoundTime", LipsSoundTime)
	ExportInt("LipsPhoneme", LipsPhoneme)
	ExportInt("LipsMinValue", LipsMinValue)
	ExportInt("LipsMaxValue", LipsMaxValue)

	; Floats
	ExportFloat("CumTimer", CumTimer)
	ExportFloat("ShakeStrength", ShakeStrength)
	ExportFloat("AutoSUCSM", AutoSUCSM)
	ExportFloat("MaleVoiceDelay", MaleVoiceDelay)
	ExportFloat("FemaleVoiceDelay", FemaleVoiceDelay)
	ExportFloat("ExpressionDelay", ExpressionDelay)
	ExportFloat("VoiceVolume", VoiceVolume)
	ExportFloat("SFXDelay", SFXDelay)
	ExportFloat("SFXVolume", SFXVolume)
	ExportFloat("LeadInCoolDown", LeadInCoolDown)
	ExportFloat("LipsMoveTime", LipsMoveTime)

	; Boolean Arrays
	ExportBoolList("StripMale", StripMale, 34)
	ExportBoolList("StripFemale", StripFemale, 34)
	ExportBoolList("StripLeadInFemale", StripLeadInFemale, 34)
	ExportBoolList("StripLeadInMale", StripLeadInMale, 34)
	ExportBoolList("StripVictim", StripVictim, 34)
	ExportBoolList("StripAggressor", StripAggressor, 34)

	; Float Array
	ExportFloatList("StageTimer", StageTimer, 5)
	ExportFloatList("StageTimerLeadIn", StageTimerLeadIn, 5)
	ExportFloatList("StageTimerAggr", StageTimerAggr, 5)
	ExportFloatList("OpenMouthMale", OpenMouthMale, 17)
	ExportFloatList("OpenMouthFemale", OpenMouthFemale, 17)

	; Export object registry
	ExportAnimations()
	ExportCreatures()
	ExportExpressions()
	ExportVoices()

	; Export Custom Face Scales
	StorageUtil.FormListRemove(none, "SexLab.MouthScaleActors", none, true)
	StorageUtil.UnsetFloatValue(none, "SexLab.MouthScale")
	
	Form[] MouthScaleActors = StorageUtil.FormListToArray(none, "SexLab.MouthScaleActors")
	ExportFormList("MouthScaleActors", MouthScaleActors)
	
	int i = MouthScaleActors.Length
	while i
		i -= 1
		if StorageUtil.HasFloatValue(MouthScaleActors[i], "SexLab.MouthScale")
			float Value = StorageUtil.GetFloatValue(MouthScaleActors[i], "SexLab.MouthScale")
			If Value <= 0.2 || Value >= 2
				StorageUtil.UnsetFloatValue(MouthScaleActors[i], "SexLab.MouthScale")
			Else
				ExportFloat("SexLab.MouthScale:"+sslUtility.GetFormAsString(MouthScaleActors[i]), Value)
			EndIf
		endIf
	endWhile
	
	; Export striplist items
	StorageUtil.FormListRemove(none, "AlwaysStrip", none, true)
	StorageUtil.UnsetIntValue(none, "SometimesStrip")
	
	Form[] AlwaysStrip = StorageUtil.FormListToArray(none, "AlwaysStrip")
	ExportFormList("AlwaysStrip", AlwaysStrip)
	
	i = AlwaysStrip.Length
	while i
		i -= 1
		if StorageUtil.HasIntValue(AlwaysStrip[i], "SometimesStrip")
			int Value = StorageUtil.GetIntValue(AlwaysStrip[i], "SometimesStrip")
			If Value <= 0 || Value >= 100
				StorageUtil.UnsetIntValue(AlwaysStrip[i], "SometimesStrip")
			Else
				ExportInt("SometimesStrip:"+sslUtility.GetFormAsString(AlwaysStrip[i]), Value)
			EndIf
		endIf
	endWhile
	
	StorageUtil.FormListRemove(none, "NoStrip", none, true)
	ExportFormList("NoStrip", StorageUtil.FormListToArray(none, "NoStrip"))

	ExportFormList("FaceItems", GetFaceItems())
	
	ExportStringList("ActiveFurnitureTags", ActiveFurnitureTags)

	; Save to JSON file
	JsonUtil.Save(File, true)
endFunction

function ImportSettings()
	File = "../SexLab/SexlabConfig.json"

	; Booleans
	RestrictAggressive = ImportBool("RestrictAggressive", RestrictAggressive)
	AllowCreatures     = ImportBool("AllowCreatures", AllowCreatures)
	NPCSaveVoice       = ImportBool("NPCSaveVoice", NPCSaveVoice)
	UseStrapons        = ImportBool("UseStrapons", UseStrapons)
	RestrictStrapons   = ImportBool("RestrictStrapons", RestrictStrapons)
	RedressVictim      = ImportBool("RedressVictim", RedressVictim)
	WaitIdles          = ImportBool("WaitIdles", WaitIdles)
	RagdollEnd         = ImportBool("RagdollEnd", RagdollEnd)
	UseMaleNudeSuit    = ImportBool("UseMaleNudeSuit", UseMaleNudeSuit)
	UseFemaleNudeSuit  = ImportBool("UseFemaleNudeSuit", UseFemaleNudeSuit)
	UndressAnimation   = ImportBool("UndressAnimation", UndressAnimation)
	UseLipSync         = ImportBool("UseLipSync", UseLipSync)
	UseExpressions     = ImportBool("UseExpressions", UseExpressions)
	UseFaceItems       = ImportBool("UseFaceItems", UseFaceItems)
	RefreshExpressions = ImportBool("RefreshExpressions", RefreshExpressions)
	ScaleActors        = ImportBool("ScaleActors", ScaleActors)
	UseCum             = ImportBool("UseCum", UseCum)
	AllowFFCum         = ImportBool("AllowFFCum", AllowFFCum)
	DisablePlayer      = ImportBool("DisablePlayer", DisablePlayer)
	AutoTFC            = ImportBool("AutoTFC", AutoTFC)
	AutoAdvance        = ImportBool("AutoAdvance", AutoAdvance)
	ForeplayStage      = ImportBool("ForeplayStage", ForeplayStage)
	OrgasmEffects      = ImportBool("OrgasmEffects", OrgasmEffects)
	RaceAdjustments    = ImportBool("RaceAdjustments", RaceAdjustments)
	BedRemoveStanding  = ImportBool("BedRemoveStanding", BedRemoveStanding)
	UseCreatureGender  = ImportBool("UseCreatureGender", UseCreatureGender)
	LimitedStrip       = ImportBool("LimitedStrip", LimitedStrip)
	RestrictSameSex    = ImportBool("RestrictSameSex", RestrictSameSex)
	RestrictGenderTag  = ImportBool("RestrictGenderTag", RestrictGenderTag)
	RestrictFetishTags = ImportBool("RestrictFetishTags", RestrictFetishTags)
	SeparateOrgasms    = ImportBool("SeparateOrgasms", SeparateOrgasms)
	RemoveHeelEffect   = ImportBool("RemoveHeelEffect", RemoveHeelEffect)
	if HasZadDevice
		ManageZadFilter    = ImportBool("ManageZadFilter", ManageZadFilter)
	else
		ManageZadFilter    = False
	endIf
	if HasZazDevice
		ManageZazFilter    = ImportBool("ManageZazFilter", ManageZazFilter)
	else
		ManageZazFilter    = False
	endIf
	AdjustTargetStage  = ImportBool("AdjustTargetStage", AdjustTargetStage)
	ShowInMap          = ImportBool("ShowInMap", ShowInMap)
	DisableTeleport    = ImportBool("DisableTeleport", DisableTeleport)
	SeedNPCStats       = ImportBool("SeedNPCStats", SeedNPCStats)
	DisableScale       = ImportBool("DisableScale", DisableScale)
	AllowFurniture     = ImportBool("AllowFurniture", AllowFurniture)
	UseAdvancedFurn    = ImportBool("UseAdvancedFurn", UseAdvancedFurn)
	UseIntimacyCircle  = ImportBool("UseIntimacyCircle", UseIntimacyCircle)
	FixVictimPos       = ImportBool("FixVictimPos", FixVictimPos)
	LipsFixedValue     = ImportBool("LipsFixedValue", LipsFixedValue)

	; Integers
	AnimProfile        = ImportInt("AnimProfile", AnimProfile)
	AskBed             = ImportInt("AskBed", AskBed)
	NPCBed             = ImportInt("NPCBed", NPCBed)
	UseXMarkerHidden   = ImportInt("UseXMarkerHidden", UseXMarkerHidden)
	NPCHidden          = ImportInt("NPCHidden", NPCHidden)
	AskFurniture       = ImportInt("AskFurniture", AskFurniture)
	NPCFurniture       = ImportInt("NPCFurniture", NPCFurniture)
	OpenMouthSize      = ImportInt("OpenMouthSize", OpenMouthSize)
	UseFade            = ImportInt("UseFade", UseFade)

	Backwards          = ImportInt("Backwards", Backwards)
	AdjustStage        = ImportInt("AdjustStage", AdjustStage)
	AdvanceAnimation   = ImportInt("AdvanceAnimation", AdvanceAnimation)
	ChangeAnimation    = ImportInt("ChangeAnimation", ChangeAnimation)
	ChangePositions    = ImportInt("ChangePositions", ChangePositions)
	AdjustChange       = ImportInt("AdjustChange", AdjustChange)
	AdjustForward      = ImportInt("AdjustForward", AdjustForward)
	AdjustSideways     = ImportInt("AdjustSideways", AdjustSideways)
	AdjustUpward       = ImportInt("AdjustUpward", AdjustUpward)
	RealignActors      = ImportInt("RealignActors", RealignActors)
	MoveScene          = ImportInt("MoveScene", MoveScene)
	RestoreOffsets     = ImportInt("RestoreOffsets", RestoreOffsets)
	RotateScene        = ImportInt("RotateScene", RotateScene)
	EndAnimation       = ImportInt("EndAnimation", EndAnimation)
	ToggleFreeCamera   = ImportInt("ToggleFreeCamera", ToggleFreeCamera)
	TargetActor        = ImportInt("TargetActor", TargetActor)
	AdjustSchlong      = ImportInt("AdjustSchlong", AdjustSchlong)
	LipsSoundTime      = ImportInt("LipsSoundTime", LipsSoundTime)
	LipsPhoneme        = ImportInt("LipsPhoneme", LipsPhoneme)
	LipsMinValue       = ImportInt("LipsMinValue", LipsMinValue)
	LipsMaxValue       = ImportInt("LipsMaxValue", LipsMaxValue)

	; Floats
	CumTimer           = ImportFloat("CumTimer", CumTimer)
	ShakeStrength      = ImportFloat("ShakeStrength", ShakeStrength)
	AutoSUCSM          = ImportFloat("AutoSUCSM", AutoSUCSM)
	MaleVoiceDelay     = ImportFloat("MaleVoiceDelay", MaleVoiceDelay)
	FemaleVoiceDelay   = ImportFloat("FemaleVoiceDelay", FemaleVoiceDelay)
	ExpressionDelay    = ImportFloat("ExpressionDelay", ExpressionDelay)
	VoiceVolume        = ImportFloat("VoiceVolume", VoiceVolume)
	SFXDelay           = ImportFloat("SFXDelay", SFXDelay)
	SFXVolume          = ImportFloat("SFXVolume", SFXVolume)
	LeadInCoolDown     = ImportFloat("LeadInCoolDown", LeadInCoolDown)
	LipsMoveTime       = ImportFloat("LipsMoveTime", LipsMoveTime)

	; Boolean Arrays
	StripMale          = ImportBoolList("StripMale", StripMale, 34)
	StripFemale        = ImportBoolList("StripFemale", StripFemale, 34)
	StripLeadInFemale  = ImportBoolList("StripLeadInFemale", StripLeadInFemale, 34)
	StripLeadInMale    = ImportBoolList("StripLeadInMale", StripLeadInMale, 34)
	StripVictim        = ImportBoolList("StripVictim", StripVictim, 34)
	StripAggressor     = ImportBoolList("StripAggressor", StripAggressor, 34)

	; Float Array
	StageTimer         = ImportFloatList("StageTimer", StageTimer, 5)
	StageTimerLeadIn   = ImportFloatList("StageTimerLeadIn", StageTimerLeadIn, 5)
	StageTimerAggr     = ImportFloatList("StageTimerAggr", StageTimerAggr, 5)
	OpenMouthMale      = ImportFloatList("OpenMouthMale", OpenMouthMale, 17)
	OpenMouthFemale    = ImportFloatList("OpenMouthFemale", OpenMouthFemale, 17)

	; String Array
	ActiveFurnitureTags = ImportStringList("ActiveFurnitureTags", ActiveFurnitureTags)

	; Register creature animations
	CreatureSlots.RegisterSlots()
	
	; Import object registry
	ImportAnimations()
	ImportCreatures()
	ImportExpressions()
	ImportVoices()

	; Import Custom Face Scales
	StorageUtil.FormListRemove(none, "SexLab.MouthScaleActors", none, true)
	StorageUtil.UnsetFloatValue(none, "SexLab.MouthScale")
	Form[] MouthScaleActors = JsonUtil.FormListToArray(File, "SexLab.MouthScaleActors")
	int i = MouthScaleActors.Length
	while i
		i -= 1
		if MouthScaleActors[i]
			ActorLib.MakeAlwaysStrip(MouthScaleActors[i])
			string FormAsString = sslUtility.GetFormAsString(MouthScaleActors[i])
			float Value = JsonUtil.GetFloatValue(File, "SexLab.MouthScale:"+sslUtility.GetFormAsString(MouthScaleActors[i]), 0)
			if Value >= 0.2 && Value <= 2 
				StorageUtil.SetFloatValue(MouthScaleActors[i], "SexLab.MouthScale", Value)
			elseIf StorageUtil.HasFloatValue(MouthScaleActors[i], "SexLab.MouthScale")
				StorageUtil.UnsetFloatValue(MouthScaleActors[i], "SexLab.MouthScale")
			endIf
		endIf
	endWhile

	; Import striplist items
	StorageUtil.FormListRemove(none, "AlwaysStrip", none, true)
	StorageUtil.UnsetIntValue(none, "SometimesStrip")
	Form[] AlwaysStrip = JsonUtil.FormListToArray(File, "AlwaysStrip")
	i = AlwaysStrip.Length
	while i
		i -= 1
		if AlwaysStrip[i]
			ActorLib.MakeAlwaysStrip(AlwaysStrip[i])
			string FormAsString = sslUtility.GetFormAsString(AlwaysStrip[i])
			int Value = JsonUtil.GetIntValue(File, "SometimesStrip:"+sslUtility.GetFormAsString(AlwaysStrip[i]), 0)
			if Value > 0 && Value < 100 
				StorageUtil.SetIntValue(AlwaysStrip[i], "SometimesStrip", Value)
			elseIf StorageUtil.HasIntValue(AlwaysStrip[i], "SometimesStrip")
				StorageUtil.UnsetIntValue(AlwaysStrip[i], "SometimesStrip")
			endIf
		endIf
	endWhile

	StorageUtil.FormListRemove(none, "NoStrip", none, true)
	Form[] NoStrip = JsonUtil.FormListToArray(File, "NoStrip")
	i = NoStrip.Length
	while i
		i -= 1
		if NoStrip[i]
			ActorLib.MakeNoStrip(NoStrip[i])
			if StorageUtil.HasIntValue(NoStrip[i], "SometimesStrip")
				StorageUtil.UnsetIntValue(AlwaysStrip[i], "SometimesStrip")
			endIf
		endIf
	endWhile

	Form[] TempFaceItems = JsonUtil.FormListToArray(File, "FaceItems")
	i = TempFaceItems.Length
	if FaceItemsList && FaceItems
		FaceItemsList.Revert()
		FaceItems.Revert()
	EndIf
	while i
		i -= 1
		AddFaceItem(TempFaceItems[i])
	endWhile

	JsonUtil.Unload(File, false, false)

	; Reload settings with imported values
	Reload()

endFunction

; Integers
function ExportInt(string Name, int Value)
	JsonUtil.SetIntValue(File, Name, Value)
endFunction
int function ImportInt(string Name, int Value)
	return JsonUtil.GetIntValue(File, Name, Value)
endFunction

; Booleans
function ExportBool(string Name, bool Value)
	JsonUtil.SetIntValue(File, Name, Value as int)
endFunction
bool function ImportBool(string Name, bool Value)
	return JsonUtil.GetIntValue(File, Name, Value as int) as bool
endFunction

; Floats
function ExportFloat(string Name, float Value)
	JsonUtil.SetFloatValue(File, Name, Value)
endFunction
float function ImportFloat(string Name, float Value)
	return JsonUtil.GetFloatValue(File, Name, Value)
endFunction

; Float Arrays
function ExportFloatList(string Name, float[] Values, int len)
	JsonUtil.FloatListClear(File, Name)
	if len == -1 || Values.Length == len
		JsonUtil.FloatListCopy(File, Name, Values)
	Else
		int i
		while i < len
			If i < Values.Length
				JsonUtil.FloatListAdd(File, Name, Values[i])
			else
				JsonUtil.FloatListAdd(File, Name, 0)
			endIf
			i += 1
		endWhile
	endIf
endFunction
float[] function ImportFloatList(string Name, float[] Values, int len)
	int FloatListCount = JsonUtil.FloatListCount(File, Name)
	if len == -1
		len = FloatListCount
	endIf
	if Values.Length != len
		Values = Utility.CreateFloatArray(len)
	endIf
	if FloatListCount < len
		len = FloatListCount
	endIf
	int i
	while i < len
		Values[i] = JsonUtil.FloatListGet(File, Name, i)
		i += 1
	endWhile
	return Values
endFunction

; Boolean Arrays
function ExportBoolList(string Name, bool[] Values, int len)
	JsonUtil.IntListClear(File, Name)
	if len == -1
		len = Values.Length
	endIf
	int i
	while i < len
		If i < Values.Length
			JsonUtil.IntListAdd(File, Name, Values[i] as int)
		else
			JsonUtil.IntListAdd(File, Name, 0)
		endIf
		i += 1
	endWhile
endFunction
bool[] function ImportBoolList(string Name, bool[] Values, int len)
	int ListCount = JsonUtil.IntListCount(File, Name)
	if len == -1
		len = ListCount
	endIf
	if Values.Length != len
		Values = Utility.CreateBoolArray(len)
	endIf
	if ListCount < len
		len = ListCount
	endIf
	int i
	while i < len
		Values[i] = JsonUtil.IntListGet(File, Name, i) as bool
		i += 1
	endWhile
	return Values
endFunction

; String Arrays
function ExportStringList(string Name, String[] Values, int len = -1)
	JsonUtil.StringListClear(File, Name)
	if len == -1 || Values.Length == len
		JsonUtil.StringListCopy(File, Name, Values)
	Else
		int i
		while i < len
			If i < Values.Length
				JsonUtil.StringListAdd(File, Name, Values[i])
			else
				JsonUtil.StringListAdd(File, Name, "")
			endIf
			i += 1
		endWhile
	endIf
endFunction
String[] function ImportStringList(string Name, String[] Values, int len = -1)
	int ListCount = JsonUtil.StringListCount(File, Name)
	if len == -1
		len = ListCount
	endIf
	if Values.Length != len
		Values = Utility.CreateStringArray(len)
	endIf
	if ListCount < len
		len = ListCount
	endIf
	int i
	while i < len
		Values[i] = JsonUtil.StringListGet(File, Name, i)
		i += 1
	endWhile
	return Values
endFunction

; Form Arrays
function ExportFormList(string Name, Form[] Values, int len = -1)
	JsonUtil.FormListClear(File, Name)
	if len == -1 || Values.Length == len
		JsonUtil.FormListCopy(File, Name, Values)
	Else
		int i
		while i < len
			If i < Values.Length
				JsonUtil.FormListAdd(File, Name, Values[i])
			else
				JsonUtil.FormListAdd(File, Name, none)
			endIf
			i += 1
		endWhile
	endIf
endFunction
Form[] function ImportFormList(string Name, Form[] Values, int len = -1)
	int ListCount = JsonUtil.FormListCount(File, Name)
	if len == -1
		len = ListCount
	endIf
	if Values.Length != len
		Values = Utility.CreateFormArray(len)
	endIf
	if ListCount < len
		len = ListCount
	endIf
	int i
	while i < len
		Values[i] = JsonUtil.FormListGet(File, Name, i)
		i += 1
	endWhile
	return Values
endFunction


; Animations
function ExportAnimations()
	JsonUtil.StringListClear(File, "Animations")
	int i = AnimSlots.Slotted
	while i
		i -= 1
		sslBaseAnimation Slot = AnimSlots.GetBySlot(i)
		JsonUtil.StringListAdd(File, "Animations", sslUtility.MakeArgs(",", Slot.Registry, Slot.Enabled as int, Slot.HasTag("LeadIn") as int, Slot.HasTag("Aggressive") as int))
	;	JsonUtil.StringListAdd(File, "Animations", sslUtility.MakeArgs(",", Slot.Registry, Slot.Enabled as int, Slot.HasTag("LeadIn") as int, Slot.HasTag("Aggressive") as int, PapyrusUtil.StringJoin(Slot.GetTags(), ",")))
	endWhile
endfunction
function ImportAnimations()
	int i = JsonUtil.StringListCount(File, "Animations")
	while i
		i -= 1
		; Registrar, Enabled, Foreplay, Aggressive
		string[] args = PapyrusUtil.StringSplit(JsonUtil.StringListGet(File, "Animations", i))
		if AnimSlots.FindByRegistrar(args[0]) != -1
			if args.Length > 4 && sslUtility.Trim(args[4]) != ""
				sslBaseAnimation Slot = AnimSlots.GetbyRegistrar(args[0])
				string[] RawTags = Slot.GetRawTags()
				If RawTags.Length > 0 ; Try to clean the stored Tags
					RawTags[0] = ""
					Slot.Save(Slot.SlotID)
				EndIf
				Slot.Enabled = (args[1] as int) as bool
				args[0] = ""
				args[1] = ""
				args[2] = ""
				args[3] = ""
				args = PapyrusUtil.RemoveString(args, "")
				Slot.AddTags(args)
			elseIf args.Length >= 4
				sslBaseAnimation Slot = AnimSlots.GetbyRegistrar(args[0])
				Slot.Enabled = (args[1] as int) as bool
				Slot.AddTagConditional("LeadIn", (args[2] as int) as bool)
				Slot.AddTagConditional("Aggressive", (args[3] as int) as bool)
			endIf
		endIf
	endWhile
endFunction

; Creatures
function ExportCreatures()
	JsonUtil.StringListClear(File, "Creatures")
	int i = CreatureSlots.Slotted
	while i
		i -= 1
		sslBaseAnimation Slot = CreatureSlots.GetBySlot(i)
		JsonUtil.StringListAdd(File, "Creatures", sslUtility.MakeArgs(",", Slot.Registry, Slot.Enabled as int))
	;	JsonUtil.StringListAdd(File, "Creatures", sslUtility.MakeArgs(",", Slot.Registry, Slot.Enabled as int, PapyrusUtil.StringJoin(Slot.GetTags(), ",")))
	endWhile
endFunction
function ImportCreatures()
	int i = JsonUtil.StringListCount(File, "Creatures")
	while i
		i -= 1
		; Registrar, Enabled
		string[] args = PapyrusUtil.StringSplit(JsonUtil.StringListGet(File, "Creatures", i))
		if CreatureSlots.FindByRegistrar(args[0]) != -1
			if args.Length > 2 && sslUtility.Trim(args[2]) != ""
				sslBaseAnimation Slot = CreatureSlots.GetbyRegistrar(args[0])
				string[] RawTags = Slot.GetRawTags()
				If RawTags.Length > 0 ; Try to clean the stored Tags
					RawTags[0] = ""
					Slot.Save(Slot.SlotID)
				EndIf
				Slot.Enabled = (args[1] as int) as bool
				args[0] = ""
				args[1] = ""
				args = PapyrusUtil.RemoveString(args, "")
				Slot.AddTags(args)
			elseIf args.Length >= 2
				CreatureSlots.GetbyRegistrar(args[0]).Enabled = (args[1] as int) as bool
			endIf
		endIf
	endWhile
endFunction

; Expressions
function ExportExpressions()
	int i = ExpressionSlots.Slotted
	while i
		i -= 1
		ExpressionSlots.GetBySlot(i).ExportJson()
	endWhile
endfunction
function ImportExpressions()
	int i = ExpressionSlots.Slotted
	while i
		i -= 1
		ExpressionSlots.GetBySlot(i).ImportJson()
	endWhile
endFunction

; Voices
function ExportVoices()
	JsonUtil.StringListClear(File, "Voices")
	int i = VoiceSlots.Slotted
	while i
		i -= 1
		sslBaseVoice Slot = VoiceSlots.GetBySlot(i)
		JsonUtil.StringListAdd(File, "Voices", sslUtility.MakeArgs(",", Slot.Registry, Slot.Enabled as int))
	endWhile
	; Player voice
	JsonUtil.SetStringValue(File, "PlayerVoice", VoiceSlots.GetSavedName(PlayerRef))
endfunction
function ImportVoices()
	int i = JsonUtil.StringListCount(File, "Voices")
	while i
		i -= 1
		; Registrar, Enabled
		string[] args = PapyrusUtil.StringSplit(JsonUtil.StringListGet(File, "Voices", i))
		if args.Length == 2 && VoiceSlots.FindByRegistrar(args[0]) != -1
			VoiceSlots.GetbyRegistrar(args[0]).Enabled = (args[1] as int) as bool
		endIf
	endWhile
	; Player voice
	VoiceSlots.ForgetVoice(PlayerRef)
	VoiceSlots.SaveVoice(PlayerRef, VoiceSlots.GetByName(JsonUtil.GetStringValue(File, "PlayerVoice", "$SSL_Random")))
endFunction

; ------------------------------------------------------- ;
; --- Misc                                            --- ;
; ------------------------------------------------------- ;

; int[] property ActorTypes auto hidden
function StoreActor(Form FormRef) global
	if FormRef
		StorageUtil.FormListAdd(none, "SexLab.ActorStorage", FormRef, false)
	endIf
endFunction

ImageSpaceModifier FadeEffect
VisualEffect ForceVFX
VisualEffect ForceBlackVFX
VisualEffect ForceBlurVFX
ImageSpaceModifier FadeToBlackHoldImod
ImageSpaceModifier FadeToBlurHoldImod
function RemoveFade(bool forceTest = false)
;	if !forceTest && UseFade < 1
;		return
;	endIf
	if FadeEffect != none
		bool Black = UseFade % 2 != 0
		If UseFade < 3
			if forceTest
				Utility.WaitMenuMode(5.0)
				if ForceVFX
					ForceVFX.Stop(PlayerRef)
				endIf
				FadeEffect.Remove()
			else
				if ForceVFX
					ForceVFX.Stop(PlayerRef)
				endIf
				ImageSpaceModifier.RemoveCrossFade()
			endIf
		else
			Game.FadeOutGame(false, Black, 0.5, 1.5)
		endIf
		FadeEffect = none
	endIf
endFunction

function ApplyFade(bool forceTest = false)
	if !forceTest && UseFade < 1
		RemoveFade(true)
		return
	endIf
	ImageSpaceModifier OldFadeEffect = FadeEffect
	FadeEffect = none
	bool Black
	if UseFade % 2 != 0
		if FadeToBlackHoldImod && FadeToBlackHoldImod != none
			FadeEffect = FadeToBlackHoldImod
			Black = True
		endIf
	else
		if FadeToBlurHoldImod && FadeToBlurHoldImod != none
			FadeEffect = FadeToBlurHoldImod
			Black = False
		endIf
	endIf
	if OldFadeEffect != FadeEffect
		if OldFadeEffect != none
			OldFadeEffect.Remove()
		endIf
		if FadeEffect != none
			If UseFade < 3
				if forceTest
					FadeEffect.Apply()
				else
					FadeEffect.ApplyCrossFade()
				endIf
				if Black && ForceBlackVFX
					ForceVFX = ForceBlackVFX
				elseIf !Black && ForceBlurVFX
					ForceVFX = ForceBlurVFX
				endIf
				if ForceVFX
					ForceVFX.Play(PlayerRef)
				endIf
			else
				Game.FadeOutGame(true, Black, 0.5, 3.0)
			endIf
		endIf
	endIf
endFunction

event OnInit()
	parent.OnInit()
	SetDefaults()
endEvent

function ReloadData()
	; ActorTypeNPC =            Game.GetForm(0x13794)
	; AnimatingFaction =        Game.GetFormFromFile(0xE50F, "SexLab.esm")
	; AudioSFX =                Game.GetFormFromFile(0x61428, "SexLab.esm")
	; AudioVoice =              Game.GetFormFromFile(0x61429, "SexLab.esm")
	; BaseMarker =              Game.GetFormFromFile(0x45A93 "SexLab.esm")
	; BedRollsList =            Game.GetFormFromFile(0x6198C, "SexLab.esm")
	; BedsList =                Game.GetFormFromFile(0x181B1, "SexLab.esm")
	; CalypsStrapon =           Game.GetFormFromFile(0x1A22A, "SexLab.esm")
	; CheckFNIS =               Game.GetFormFromFile(0x70C38, "SexLab.esm")
	; CheckPapyrusUtil =        Game.GetFormFromFile(0x70C3B, "SexLab.esm")
	; CheckSKSE =               Game.GetFormFromFile(0x70C39, "SexLab.esm")
	; CheckSkyrim =             Game.GetFormFromFile(0x70C3A, "SexLab.esm")
	; CheckSkyUI =              Game.GetFormFromFile(0x70C3C, "SexLab.esm")
	; CleanSystemFinish =       Game.GetFormFromFile(0x6CB9E, "SexLab.esm")
	; CumAnalKeyword =          Game.GetFormFromFile(0x, "SexLab.esm")
	; CumAnalSpell =            Game.GetFormFromFile(0x, "SexLab.esm")
	; CumOralAnalSpell =        Game.GetFormFromFile(0x, "SexLab.esm")
	; CumOralKeyword =          Game.GetFormFromFile(0x, "SexLab.esm")
	; CumOralSpell =            Game.GetFormFromFile(0x, "SexLab.esm")
	; CumVaginalAnalSpell =     Game.GetFormFromFile(0x, "SexLab.esm")
	; CumVaginalKeyword =       Game.GetFormFromFile(0x, "SexLab.esm")
	; CumVaginalOralAnalSpell = Game.GetFormFromFile(0x, "SexLab.esm")
	; CumVaginalOralSpell =     Game.GetFormFromFile(0x, "SexLab.esm")
	; CumVaginalSpell =         Game.GetFormFromFile(0x, "SexLab.esm")
	; DoNothing =               Game.GetFormFromFile(0x, "SexLab.esm")
	; DummyWeapon =             Game.GetFormFromFile(0x, "SexLab.esm")
	; ForbiddenFaction =        Game.GetFormFromFile(0x, "SexLab.esm")
	; GenderFaction =           Game.GetFormFromFile(0x, "SexLab.esm")
	; LipSync =                 Game.GetFormFromFile(0x, "SexLab.esm")
	; LocationMarker =          Game.GetFormFromFile(0x, "SexLab.esm")
	; NudeSuit =                Game.GetFormFromFile(0x, "SexLab.esm")
	; OrgasmFX =                Game.GetFormFromFile(0x, "SexLab.esm")
	; SexLabVoiceF =            Game.GetFormFromFile(0x, "SexLab.esm")
	; SexLabVoiceM =            Game.GetFormFromFile(0x, "SexLab.esm")
	; SexMixedFX =              Game.GetFormFromFile(0x, "SexLab.esm")
	; SquishingFX =             Game.GetFormFromFile(0x, "SexLab.esm")
	; SuckingFX =               Game.GetFormFromFile(0x, "SexLab.esm")
	; UseBed =                  Game.GetFormFromFile(0x, "SexLab.esm")
	; VoicesPlayer =            Game.GetFormFromFile(0x, "SexLab.esm")
endFunction

; ------------------------------------------------------- ;
; --- Pre 1.50 Config Accessors                       --- ;
; ------------------------------------------------------- ;

bool property bRestrictAggressive hidden
	bool function get()
		return RestrictAggressive
	endFunction
endProperty
bool property bAllowCreatures hidden
	bool function get()
		return AllowCreatures
	endFunction
endProperty
bool property bUseStrapons hidden
	bool function get()
		return UseStrapons
	endFunction
endProperty
bool property bRedressVictim hidden
	bool function get()
		return RedressVictim
	endFunction
endProperty
bool property bRagdollEnd hidden
	bool function get()
		return RagdollEnd
	endFunction
endProperty
bool property bUndressAnimation hidden
	bool function get()
		return UndressAnimation
	endFunction
endProperty
bool property bScaleActors hidden
	bool function get()
		return ScaleActors
	endFunction
endProperty
bool property bUseCum hidden
	bool function get()
		return UseCum
	endFunction
endProperty
bool property bAllowFFCum hidden
	bool function get()
		return AllowFFCum
	endFunction
endProperty
bool property bDisablePlayer hidden
	bool function get()
		return DisablePlayer
	endFunction
endProperty
bool property bAutoTFC hidden
	bool function get()
		return AutoTFC
	endFunction
endProperty
bool property bAutoAdvance hidden
	bool function get()
		return AutoAdvance
	endFunction
endProperty
bool property bForeplayStage hidden
	bool function get()
		return ForeplayStage
	endFunction
endProperty
bool property bOrgasmEffects hidden
	bool function get()
		return OrgasmEffects
	endFunction
endProperty