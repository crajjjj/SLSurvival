Scriptname _JSW_BB_Utility extends Quest

Actor Property PlayerRef  Auto                          ; Reference to the player. Game.GetPlayer() is slow

_JSW_BB_Storage Property Storage  Auto                  ; Storage data helper
_JSW_BB_Compatibility Property Compatibility  Auto      ; Helper script with compatibility patches

GlobalVariable Property ForceGender  Auto               ; For the player to be the specified gender

GlobalVariable Property VerboseMode  Auto               ; Show verbose notification messages
GlobalVariable Property PregnancyDuration  Auto         ; Full duration of a pregnancy, eg. 30 days
GlobalVariable Property RecoveryDuration  Auto          ; Full duration of recovery from a pregnancy before becoming fertile, eg. 10 days
GlobalVariable Property CycleDuration  Auto             ; Full duration of the menstrual cycle, eg. 28 days
GlobalVariable Property MenstruationBegin  Auto         ; Starting day of menstruation, eg. day 0
GlobalVariable Property MenstruationEnd  Auto           ; Ending day of menstruation, eg. day 7
GlobalVariable Property OvulationBegin  Auto            ; Starting day of ovulation, eg. day 8
GlobalVariable Property OvulationEnd  Auto              ; Ending day of ovulation, eg. day 16
GlobalVariable Property EggLife  Auto                   ; The age an egg can reach before it is no longer viable, eg 1.0 days
GlobalVariable Property SpermLife  Auto                 ; Time before sperm is removed, eg. 5 days
GlobalVariable Property ScalingMethod  Auto             ; The scaling method for bellies and breasts
GlobalVariable Property BellyScaleMax  Auto             ; The maximum belly size for NiOverride (breasts piggy back on it)
GlobalVariable Property BellyScaleMult  Auto            ; The amount of breast scaling relative to belly scaling
GlobalVariable Property BreastScaleMult  Auto           ; The amount of breast scaling relative to belly scaling
GlobalVariable Property ConceptionChance  Auto          ; Maximum percentage for fertility calculations

GlobalVariable Property AllowCreatures  Auto            ; Allow insemination from creatures
GlobalVariable Property UniqueWomenOnly  Auto           ; Only track women with the IsUnique flag enabled
GlobalVariable Property UniqueMenOnly  Auto             ; Only track men with the IsUnique flag enabled

GlobalVariable Property PMSStaminaReduction  Auto       ; The percentage of stamina to reduce during PMS
GlobalVariable Property PMSMagickaReduction  Auto       ; The percentage of magicka to reduce during PMS
GlobalVariable Property OvulationStaminaBonus  Auto     ; The percentage of stamina to add during ovulation
GlobalVariable Property OvulationMagickaBonus  Auto     ; The percentage of magicka to add during ovulation

FormList Property ActorBlackList  Auto                  ; Explicitly chosen actors that are not available for tracking

Keyword Property ActorTypeNPC  Auto                     ; Only NPC tagged actors can be tracked
Keyword Property ActorTypeCreature  Auto                ; Keyword for identifying creature types
Keyword Property SpawnedChild  Auto                     ; Keyword for identifying Fertility Mode children

MagicEffect Property EffectFertility  Auto              ; Magic effect for increased fertility
MagicEffect Property EffectContraception  Auto          ; Magic effect for decreased fertility

Spell Property EffectSpellPMS  Auto                     ; Constant ability for premenstrual syndrome which occurs during the luteal phase
Spell Property EffectSpellOvulation  Auto               ; Constant ability for ovulation
Spell Property EffectSpellFirstTrimester  Auto          ; Constant ability for the first trimester of pregnancy
Spell Property EffectSpellSecondTrimester  Auto         ; Constant ability for the second trimester of pregnancy
Spell Property EffectSpellThirdTrimester  Auto          ; Constant ability for the third trimester of pregnancy

ImageSpaceModifier Property FadeToBlack  Auto           ; Visual effect for fading to black
ImageSpaceModifier Property HoldBlack  Auto             ; Visual effect for retaining the black screen
ImageSpaceModifier Property FadeFromBlack  Auto         ; Visual effect for fading back from black

; Const values: relevant form types for the cell scan
int _kNPC = 43
int _kLeveledCharacter = 44
int _kCharacter = 62

; Mutable values: spell effect metrics for reversal
float _staminaDelta = 0.0
float _magickaDelta = 0.0
float _speechDelta = 0.0

function UpdateOvulationStatus(Actor akActor, int actorIndex)
{Updates the current egg status for the given actor}
    int cycleDay = Math.Ceiling(Storage.LastGameHours[actorIndex] + Storage.LastGameHoursDelta[actorIndex]) % (CycleDuration.GetValueInt() + 1)
    int ovulationDay = ((OvulationEnd.GetValueInt() - OvulationBegin.GetValueInt()) / 2) + OvulationBegin.GetValueInt()
    float birthDay = (now - Storage.LastBirth[actorIndex])
    float now = Utility.GetCurrentGameTime()
    
    if (Storage.LastConception[actorIndex] > 0.0)
        Storage.LastOvulation[actorIndex] = 0.0 ; Clear ovulation status, the actor was fertilized
    elseIf (cycleDay >= MenstruationBegin.GetValueInt() && cycleDay <= MenstruationEnd.GetValueInt() && !PlayerRef.HasMagicEffect(EffectFertility))
        Storage.LastOvulation[actorIndex] = 0.0 ; Clear ovulation status, the actor is shedding an unfertilized egg
    elseIf (cycleDay == ovulationDay && Storage.LastOvulation[actorIndex] == 0.0 && !PlayerRef.HasMagicEffect(EffectFertility))
        Storage.LastOvulation[actorIndex] = 0.001
        
        if (VerboseMode.GetValueInt())
            Debug.Notification(akActor.GetDisplayName() + " is ovulating")
        endIf
    elseIf (Storage.LastOvulation[actorIndex] != 0.0 && !PlayerRef.HasMagicEffect(EffectFertility))
        ; Add time to the egg's lifespan. It dies after N days
        Storage.LastOvulation[actorIndex] = Storage.LastOvulation[actorIndex] + (now - Storage.LastGameHours[actorIndex])
    endIf
    
    if (akActor == PlayerRef)
		int stateID = 2 ; Default to luteal phase
			
		if (Storage.LastConception[actorIndex] > 0.0)
			int pregnantDay = (now - Storage.LastConception[actorIndex]) as int
			int trimesterDuration = Math.Ceiling(PregnancyDuration.GetValueInt() / 3)
			
			if (pregnantDay < trimesterDuration)
				stateID = 4
			elseIf (pregnantDay < trimesterDuration * 2)
				stateID = 5
			elseIf (pregnantDay < PregnancyDuration.GetValueInt())
				stateID = 6
			else
				stateID = 20
			endIf
		elseIf (Storage.LastBirth[actorIndex] != 0.0 && birthDay < RecoveryDuration.GetValueInt())
			stateID = 8
		elseIf (cycleDay >= MenstruationBegin.GetValueInt() && cycleDay <= MenstruationEnd.GetValueInt() && !PlayerRef.HasMagicEffect(EffectFertility))
			stateID = 3
		elseIf ((cycleDay >= OvulationBegin.GetValueInt() && cycleDay <= OvulationEnd.GetValueInt()) || PlayerRef.HasMagicEffect(EffectFertility))
			if (Storage.LastOvulation[actorIndex] == 0.0)
				stateID = 1
			else
				stateID = 0
			endIf
		endIf
	    
	    ; Order of operations: remove any active cycle effects
		if (stateID != 2 && PlayerRef.HasSpell(EffectSpellPMS))
			; Restore stamina and magicka when the effect ends
			PlayerRef.ModActorValue("Stamina", _staminaDelta)
			PlayerRef.ModActorValue("Magicka", _magickaDelta)
			
			; UI-only spell to show PMS in the active effects list
			PlayerRef.RemoveSpell(EffectSpellPMS)
		elseIf (!(stateID == 0 || stateID == 1) && PlayerRef.HasSpell(EffectSpellOvulation))
			; Restore stamina and magicka when the effect ends
			PlayerRef.ModActorValue("Stamina", -_staminaDelta)
			PlayerRef.ModActorValue("Magicka", -_magickaDelta)
			
			; UI-only spell to show ovulation in the active effects list
			PlayerRef.RemoveSpell(EffectSpellOvulation)
		elseIf (stateID != 4 && PlayerRef.HasSpell(EffectSpellFirstTrimester))
			; Restore stamina and magicka when the effect ends
			PlayerRef.ModActorValue("Stamina", _staminaDelta)
			PlayerRef.ModActorValue("Magicka", _magickaDelta)
			
			; UI-only spell to show first trimester in the active effects list
			PlayerRef.RemoveSpell(EffectSpellFirstTrimester)
		elseIf (stateID != 5 && PlayerRef.HasSpell(EffectSpellSecondTrimester))
			; UI-only spell to show second trimester in the active effects list
			PlayerRef.RemoveSpell(EffectSpellSecondTrimester)
		elseIf (stateID != 6 && PlayerRef.HasSpell(EffectSpellThirdTrimester))
			; UI-only spell to show third trimester in the active effects list
			PlayerRef.RemoveSpell(EffectSpellThirdTrimester)
		endIf
		
		; Order of operations: add new active cycle effects
		if (stateID == 2 && !PlayerRef.HasSpell(EffectSpellPMS))
			_staminaDelta = PlayerRef.GetActorValue("Stamina") * PMSStaminaReduction.GetValue()
			_magickaDelta = PlayerRef.GetActorValue("Magicka") * PMSMagickaReduction.GetValue()
			
			; Debuff stamina and magicka while the effect is active
			PlayerRef.ModActorValue("Stamina", -_staminaDelta)
			PlayerRef.ModActorValue("Magicka", -_magickaDelta)
			
			; UI-only spell to show PMS in the active effects list
			PlayerRef.AddSpell(EffectSpellPMS)
		elseIf ((stateID == 0 || stateID == 1) && !PlayerRef.HasSpell(EffectSpellOvulation))
			_staminaDelta = PlayerRef.GetActorValue("Stamina") * OvulationStaminaBonus.GetValue()
			_magickaDelta = PlayerRef.GetActorValue("Magicka") * OvulationMagickaBonus.GetValue()
			
			; Buff stamina and magicka while the effect is active
			PlayerRef.ModActorValue("Stamina", _staminaDelta)
			PlayerRef.ModActorValue("Magicka", _magickaDelta)
			
			; UI-only spell to show ovulation in the active effects list
			PlayerRef.AddSpell(EffectSpellOvulation)
		elseIf (stateID == 4 && !PlayerRef.HasSpell(EffectSpellFirstTrimester))
			_staminaDelta = PlayerRef.GetActorValue("Stamina") * PMSStaminaReduction.GetValue()
			_magickaDelta = PlayerRef.GetActorValue("Magicka") * PMSMagickaReduction.GetValue()
			
			; Debuff stamina and magicka while the effect is active
			PlayerRef.ModActorValue("Stamina", -_staminaDelta)
			PlayerRef.ModActorValue("Magicka", -_magickaDelta)
			
			; UI-only spell to show first trimester in the active effects list
			PlayerRef.AddSpell(EffectSpellFirstTrimester)
		elseIf (stateID == 5 && !PlayerRef.HasSpell(EffectSpellSecondTrimester))
			; UI-only spell to show second trimester in the active effects list
			PlayerRef.AddSpell(EffectSpellSecondTrimester)
		elseIf (stateID == 6 && !PlayerRef.HasSpell(EffectSpellThirdTrimester))
			; UI-only spell to show third trimester in the active effects list
			PlayerRef.AddSpell(EffectSpellThirdTrimester)
		endIf
	endIf
endFunction

bool function IsConceptionPossible(Actor akActor, int actorIndex)
{Checks if the specified actor is in a fertile time of the cycle}
    if (Storage.LastConception[actorIndex] > 0.0)
        return false ; The actor is currently pregnant
    endIf
    
    float birthDay = (Utility.GetCurrentGameTime() - Storage.LastBirth[actorIndex])
    
    if (Storage.LastBirth[actorIndex] != 0.0 && birthDay < RecoveryDuration.GetValueInt())
        ; Recovery from birth, no chance of conception
        return false
    else
        int cycleDay = Math.Ceiling(Storage.LastGameHours[actorIndex] + Storage.LastGameHoursDelta[actorIndex]) % (CycleDuration.GetValueInt() + 1)
        float spermCount = Storage.SpermCount[actorIndex]
        int ovulationDay = ((OvulationEnd.GetValueInt() - OvulationBegin.GetValueInt()) / 2) + OvulationBegin.GetValueInt()
        int viableDayStart = ovulationDay - (SpermLife.GetValueInt() - 1)
        int viableDayEnd = ovulationDay + EggLife.GetValueInt()
        int fertility = 0
        
        if (cycleDay >= viableDayStart && cycleDay < ovulationDay)
            ; Increase fertility percentage up to half the viable period
            fertility = ConceptionChance.GetValueInt() / (ovulationDay - viableDayStart) * (cycleDay - viableDayStart + 1)
        elseIf (cycleDay < viableDayEnd && cycleDay >= ovulationDay)
            fertility = ConceptionChance.GetValueInt()
        endIf
        
        if (akActor.HasMagicEffect(EffectContraception))
            fertility = 3
        elseIf (akActor.HasMagicEffect(EffectFertility))
            fertility += ConceptionChance.GetValueInt()
        endIf
        
        ; Clamp the fertility percentage
        if (fertility > ConceptionChance.GetValueInt())
            fertility = ConceptionChance.GetValueInt()
        elseIf (fertility < 0)
            fertility = 0
        endIf
        
        if (Storage.LastOvulation[actorIndex] != 0.0 && (Storage.LastOvulation[actorIndex] <= EggLife.GetValue() || akActor.HasMagicEffect(EffectFertility)))
            ; We have a viable egg, now check for sperm viability
            if (Storage.SpermCount[actorIndex] > 100.0)
                return Utility.RandomInt(1, 100) < fertility
            else
                return false ; Insufficient sperm for conception
            endIf
        else
            return false ; The actor has no viable egg available
        endIf
    endIf
endFunction

Form[] function GetAllCellActors()
{Scan for all relevant NPCs in the current cell}
    Cell currentCell = PlayerRef.GetParentCell()
    Form[] result
    int n1 = currentCell.GetNumRefs(_kNPC) as int
    int n2 = currentCell.GetNumRefs(_kCharacter) as int
    int n3 = currentCell.GetNumRefs(_kLeveledCharacter) as int
    int n = n1 + n2 + n3
    int index = 0
    
    if (!n)
        return result
    endIf
    
    result = Utility.ResizeFormArray(result, result.Length + n, none)
    
    while (n1)
        n1 -= 1
        result[index] = currentCell.GetNthRef(n1, _kNPC) as Actor
        index += 1
    endWhile
    
    while (n2)
        n2 -= 1
        result[index] = currentCell.GetNthRef(n2, _kCharacter) as Actor
        index += 1
    endWhile
    
    while (n3)
        n3 -= 1
        result[index] = currentCell.GetNthRef(n3, _kLeveledCharacter) as Actor
        index += 1
    endWhile
    
    return result
endFunction

function AddActor(Actor akActor)
{Add a new actor to the tracking list}
    if (!akActor)
        return
    endIf
    
    if (ActorBlackList.Find(akActor) == -1 && \
        GetActorGender(akActor) == 1 && \
        akActor.IsEnabled() && \
        !akActor.IsDead() && \
        !akActor.IsChild() && \
        !akActor.IsGhost() && \
        akActor.GetRace().HasKeyword(ActorTypeNPC) && \
        Storage.RaceBlacklist.Find(akActor.GetRace()) == -1 && \
        akActor.GetDisplayName() != "ghost")
        
        if (!UniqueWomenOnly.GetValueInt() || akActor.GetLeveledActorBase().IsUnique())
            Storage.TrackedActorAdd(akActor)
        endIf
    endIf
endFunction

function AddFather(Actor akActor)
{Add a new father to the tracking list}
    if (!akActor)
        return
    endIf
    
    if (ActorBlackList.Find(akActor) == -1 && \
        GetActorGender(akActor) == 0 && \
        akActor.IsEnabled() && \
        !akActor.IsDead() && \
        !akActor.IsChild() && \
        !akActor.IsGhost() && \
        (akActor.GetRace().HasKeyword(ActorTypeNPC) || akActor.GetRace().HasKeyword(ActorTypeCreature)) && \
        Storage.RaceBlacklist.Find(akActor.GetRace()) == -1 && \
        akActor.GetDisplayName() != "ghost")
        
        if (!UniqueMenOnly.GetValueInt() || akActor.GetLeveledActorBase().IsUnique())
            Storage.TrackedFatherAdd(akActor)
        endIf
    endIf
endFunction

function SexLabOrgasm(string hookName, string argString, float argNum, Form sender)
{Worker function for SexLab's orgasm event}
    Compatibility.SexLabOrgasm(hookName, argString, argNum, sender)
endFunction

function SexLabSeparateOrgasm(Form actorRef, int thread)
{Worker function for SexLab's separate orgasm event}
    Compatibility.SexLabSeparateOrgasm(actorRef, thread)
endFunction

function BellyBreastScale(Actor akActor, int actorIndex)
{Scale the belly using the currently configured method}
    int pregnantDay = 0
    
    if (Storage.LastConception[actorIndex] > 0.0)
        pregnantDay = (Utility.GetCurrentGameTime() - Storage.LastConception[actorIndex]) as int
    endIf
    
    if (pregnantDay > 0)
        SetBellyBreastScale(akActor, pregnantDay)
    else
        ClearBellyBreastScale(akActor)
    endIf
endFunction

function SetBellyBreastScale(Actor akActor, int pregnantDay)
{Helper function for updating  the specified actor's belly/breast scaling with the current method}
    float bellyScale = (pregnantDay as float / (PregnancyDuration.GetValueInt() as float * 1.0)) * BellyScaleMult.GetValue()
    float breastScale = bellyScale * BreastScaleMult.GetValue()
    
    if (ScalingMethod.GetValueInt() == 3 && Game.GetModbyName("SexLab Inflation Framework.esp") != 255)
        ; SexLab Inflation Framework
        SLIFMorph(akActor, "slif_belly", bellyScale)
		SLIFMorph(akActor, "slif_breast", breastScale)
    elseIf (ScalingMethod.GetValueInt() == 2)
        ; NiOverride
        float bellyScaleNode = BellyScaleMax.GetValue() * bellyScale
        float breastScaleNode = bellyScaleNode / 10
        
        NiOverride.AddNodeTransformScale(akActor, false, true, "NPC Belly", "Fertility Mode", bellyScaleNode + 1.0)
        NiOverride.AddNodeTransformScale(akActor, true, true, "NPC Belly", "Fertility Mode", bellyScaleNode + 1.0)
        NiOverride.AddNodeTransformScale(akActor, false, true, "NPC L Breast", "Fertility Mode", breastScaleNode + 1.0)
        NiOverride.AddNodeTransformScale(akActor, true, true, "NPC L Breast", "Fertility Mode", breastScaleNode + 1.0)
        NiOverride.AddNodeTransformScale(akActor, false, true, "NPC R Breast", "Fertility Mode", breastScaleNode + 1.0)
        NiOverride.AddNodeTransformScale(akActor, true, true, "NPC R Breast", "Fertility Mode", breastScaleNode + 1.0)
        NiOverride.UpdateNodeTransform(akActor, false, true, "NPC Belly")
        NiOverride.UpdateNodeTransform(akActor, true, true, "NPC Belly")
        NiOverride.UpdateNodeTransform(akActor, false, true, "NPC L Breast")
        NiOverride.UpdateNodeTransform(akActor, true, true, "NPC L Breast")
        NiOverride.UpdateNodeTransform(akActor, false, true, "NPC R Breast")
        NiOverride.UpdateNodeTransform(akActor, true, true, "NPC R Breast")
    elseIf (ScalingMethod.GetValueInt() == 1)
        ; NetImmerse
        float bellyScaleNode = BellyScaleMax.GetValue() * bellyScale
        float breastScaleNode = bellyScaleNode / 10
        
        NetImmerse.SetNodeScale(akActor, "NPC Belly", bellyScaleNode + 1.0, false)
        NetImmerse.SetNodeScale(akActor, "NPC Belly", bellyScaleNode + 1.0, true)
        NetImmerse.SetNodeScale(akActor, "NPC L Breast", breastScaleNode + 1.0, false)
        NetImmerse.SetNodeScale(akActor, "NPC L Breast", breastScaleNode + 1.0, true)
        NetImmerse.SetNodeScale(akActor, "NPC R Breast", breastScaleNode + 1.0, false)
        NetImmerse.SetNodeScale(akActor, "NPC R Breast", breastScaleNode + 1.0, true)
    else
        ; BodyMorph
        NiOverride.SetBodyMorph(akActor, "PregnancyBelly", "Fertility Mode", bellyScale)
        NiOverride.SetBodyMorph(akActor, "BreastsSH", "Fertility Mode", breastScale)
        NiOverride.SetBodyMorph(akActor, "BreastsNewSH", "Fertility Mode", breastScale)
        NiOverride.UpdateModelWeight(akActor)
    endIf
endfunction

function ClearBellyBreastScale(Actor akActor)
{Helper function for clearing the specified actor's belly/breast scaling with the current method}
    if (ScalingMethod.GetValueInt() == 3 && Game.GetModbyName("SexLab Inflation Framework.esp") != 255)
        ; SexLab Inflation Framework
        SLIFMorph(akActor, "slif_belly", 0.0, true)
        SLIFMorph(akActor, "slif_breast", 0.0, true)
    elseIf (ScalingMethod.GetValueInt() == 2)
        ; NiOverride
        NiOverride.RemoveNodeTransformScale(akActor, false, true, "NPC Belly", "Fertility Mode")
        NiOverride.RemoveNodeTransformScale(akActor, true, true, "NPC Belly", "Fertility Mode")
        NiOverride.RemoveNodeTransformScale(akActor, false, true, "NPC L Breast", "Fertility Mode")
        NiOverride.RemoveNodeTransformScale(akActor, true, true, "NPC L Breast", "Fertility Mode")
        NiOverride.RemoveNodeTransformScale(akActor, false, true, "NPC R Breast", "Fertility Mode")
        NiOverride.RemoveNodeTransformScale(akActor, true, true, "NPC R Breast", "Fertility Mode")
        NiOverride.UpdateNodeTransform(akActor, false, true, "NPC Belly")
        NiOverride.UpdateNodeTransform(akActor, true, true, "NPC Belly")
        NiOverride.UpdateNodeTransform(akActor, false, true, "NPC L Breast")
        NiOverride.UpdateNodeTransform(akActor, true, true, "NPC L Breast")
        NiOverride.UpdateNodeTransform(akActor, false, true, "NPC R Breast")
        NiOverride.UpdateNodeTransform(akActor, true, true, "NPC R Breast")
    elseIf (ScalingMethod.GetValueInt() == 1)
        ; NetImmerse
        NetImmerse.SetNodeScale(akActor, "NPC Belly", 1.0, false)
        NetImmerse.SetNodeScale(akActor, "NPC Belly", 1.0, true)
        NetImmerse.SetNodeScale(akActor, "NPC L Breast", 1.0, false)
        NetImmerse.SetNodeScale(akActor, "NPC L Breast", 1.0, true)
        NetImmerse.SetNodeScale(akActor, "NPC R Breast", 1.0, false)
        NetImmerse.SetNodeScale(akActor, "NPC R Breast", 1.0, true)
    else
        ; BodyMorph
        NiOverride.ClearBodyMorph(akActor, "PregnancyBelly", "Fertility Mode")
        NiOverride.ClearBodyMorph(akActor, "BreastsSH", "Fertility Mode")
        NiOverride.ClearBodyMorph(akActor, "BreastsNewSH", "Fertility Mode")
        NiOverride.UpdateModelWeight(akActor)
    endIf
endFunction

function SLIFMorph(Actor akActor, string morphName, float scale, bool reset = false)
{Helper function for scaling morphs through SLIF}
    if (!reset)
        int handle = ModEvent.Create("SLIF_morph")
        
        if (handle)
            ModEvent.PushForm(handle, akActor)
            ModEvent.PushString(handle, "Fertility Mode")
            ModEvent.PushString(handle, morphName)
            ModEvent.PushFloat(handle, scale)
            ModEvent.PushString(handle, "Fertility Mode.esm")
            ModEvent.Send(handle)
        endIf
    else
        int handle = ModEvent.Create("SLIF_unregisterMorph")
        
        if (handle)
            ModEvent.PushForm(handle, akActor)
            ModEvent.PushString(handle, "Fertility Mode")
            ModEvent.PushString(handle, morphName)
            ModEvent.Send(handle)
        endIf
    endIf
endFunction

Actor function TrySpawnChild(Actor akActor, int raceIndex)
{Attempt to spawn a child actor and send to the package location}
	int gender = Utility.RandomInt(0, 1)
    ActorBase childBase = Storage.Children[2 * raceIndex + gender]
    
    ; Match hair color to the parent
    childBase.SetHairColor(akActor.GetActorBase().GetHairColor())
    
    Actor child = PlayerRef.PlaceActorAtMe(childBase) as Actor
    
    child.EvaluatePackage()
    child.MoveToPackageLocation()

    return child
endFunction

string function TryAdoptChildMcm(Actor child)
{Attempt to adopt a spawned child actor through the Hearthfire adoption system}
    return Compatibility.TryAdoptChildMcm(child)
endFunction

Actor function TrySpawnChildAdopt(Actor akActor)
{Attempt to spawn a child actor through the Hearthfire adoption system}
    return Compatibility.TrySpawnChildAdopt(akActor)
endFunction

string function GenerateName(string msg)
	return ((self as Form) as UILIB_1).ShowTextInput(msg, "")
endFunction

function RenameChild(Actor akActor)
{Renames the specified child}
    if (!akActor.HasKeyword(SpawnedChild))
        return
    endIf
    
    int sex = GetActorGender(akActor)
    string genderMsg = "son"
    
    if (sex == 1)
        genderMsg = "daughter"
    endIf
    
    akActor.SetDisplayName(((self as Form) as UILIB_1).ShowTextInput("Name your " + genderMsg, ""), true)
endFunction

int function GetActorGender(Actor akActor)
{Identify the actor's gender}
	if (akActor == PlayerRef && ForceGender.GetValueInt() == 1)
		return 1 ; Female
    elseIf (akActor == PlayerRef && ForceGender.GetValueInt() == 2)
    	return 0 ; Male
    else
    	return Compatibility.GetActorGender(akActor)
    endIf
endFunction

function FadeEffect(float fadeIn = 2.0, float holdFade = 5.0)
{Apply a fade to black and back effect}
    FadeToBlack.Apply()
    Utility.Wait(fadeIn)
    FadeToBlack.PopTo(HoldBlack)
    Utility.Wait(holdFade)
    HoldBlack.PopTo(FadeFromBlack)
    HoldBlack.Remove()
endFunction

function SendTrackingEvent(string eventName, Form akSender, int iTrackingIndex)
{Fire a custom tracking event where the sender is the tracked actor}
    int handle = ModEvent.Create(eventName)
    
    if (handle)
        ModEvent.PushString(handle, eventName)
        ModEvent.PushForm(handle, akSender)
        ModEvent.PushInt(handle, iTrackingIndex)
        ModEvent.Send(handle)
    endIf
endFunction

function SendDetailedTrackingEvent(string eventName, Form akSender, string motherName, string fatherName, int iTrackingIndex)
{Fire a custom tracking event where the sender is the tracked actor}
	int handle = ModEvent.Create(eventName)
    
    if (handle)
        ModEvent.PushString(handle, eventName)
        ModEvent.PushForm(handle, akSender)
        ModEvent.PushString(handle, motherName)
        ModEvent.PushString(handle, fatherName)
        ModEvent.PushInt(handle, iTrackingIndex)
        ModEvent.Send(handle)
    endIf
endFunction