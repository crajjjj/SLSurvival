Scriptname MME_Storage Hidden

; Variables in StorageUtil
; float
;	MME.MilkMaid.BreastBase
;	MME.MilkMaid.BreastBaseMod
;	MME.MilkMaid.LactacidCount
;	MME.MilkMaid.Level
;	MME.MilkMaid.MilkCount
;	MME.MilkMaid.MilkMaximum
;	MME.MilkMaid.MilkMax.Basevalue
;	MME.MilkMaid.MilkMax.Scalefactor
;	MME.MilkMaid.WeightBase

; (get|set|change)MilkCurrent() automatically restricts the 'current' value to the allowed maximum
; [this makes sure that these functions never return/store an invalid value where 'current > maximum']
; however some care must be taken:
;  -> set the MaidLevel before setting or changing MilkCurrent
;  -> refetch MilkCurrent after setting/changing it (value may have been truncated to upper limit)
;  -> refetch MilkMaximum after milking             (level may have increased and new limit applies)

function initializeActor(actor akActor, float Level = 0.0, float MilkCnt = 0.0) global
	Debug.Trace("MME_Storage: Triggered initializeActor() for actor " + akActor.GetLeveledActorBase().GetName())

	if StorageUtil.HasFloatValue(akActor, "MME.MilkMaid.Level")							;for maid<->slave conversion
		Debug.Trace("MME_Storage: actor " + akActor.GetLeveledActorBase().GetName() + " is already initialized, skipping")
	else
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.BreastBase", getBreastNodeScale(akActor))
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.BreastRows", 1)
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.BoobIncr", -1)
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.BoobPerLvl", -1)
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.Level", Level)
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkCount", MilkCnt)
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkMax.Basevalue", 2)
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkMax.Scalefactor", 1)
		; BreastCount, MilkMax.Basevalue and MilkMax.Scalefactor must be set before 'calculateMilkLimit()'
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkMaximum", calculateMilkLimit(akActor, Level))
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.WeightBase", akActor.GetLeveledActorBase().GetWeight())
	endif
endfunction

function deregisterActor(actor akActor) global
	Debug.Trace("MME_Storage: Triggered deregisterActor() for actor " + akActor.GetLeveledActorBase().GetName())
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.BreastBase")
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.BreastBaseMod")
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.BreastBaseModPotion")
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.BreastRows")
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.AdjustBreastRow")
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.BoobIncr")
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.BoobPerLvl")
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.LactacidCount")
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.Level")
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.MilkGen")
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.MilkCount")
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.MilkMaximum")
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.MilkMax.Basevalue")
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.MilkMax.Scalefactor")
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.PainCount")
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.WeightBase")
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.TimesMilked")
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.MilkingContainerCumsSUM")
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.MilkingContainerMilksSUM")
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.MilkingContainerLactacid")
	StorageUtil.UnsetIntValue(akActor, "MME.MilkMaid.MilkingMode")
	StorageUtil.UnsetIntValue(akActor, "MME.MilkMaid.IsSlave")
	StorageUtil.UnsetIntValue(akActor, "MME.MilkMaid.IsSuccubus")
	StorageUtil.UnsetIntValue(akActor, "MME.MilkMaid.IsVampire")
	StorageUtil.UnsetIntValue(akActor, "MME.MilkMaid.IsWerewolf")

	; obsolete - no longer used, but should be deleted
	StorageUtil.UnsetFloatValue(akActor, "MME.MilkMaid.BreastCount")
endfunction

; Beware:
;   'BreastRows' is stored as a float value for historical reasons,
;   but fractional values are invalid and potentially break things.
;    -> Provide an integer value instead.

int function getBreastRows(actor akActor) global
	Debug.Trace("MME_Storage: Triggered getBreastRows() for actor " + akActor.GetLeveledActorBase().GetName())
	int Value = StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.BreastRows", missing = 1) as int
	return verifyIntRange("MME_Storage.getBreastRows()", Value, 1, 4)
endfunction

int function setBreastRows(actor akActor, int Value) global
	Debug.Trace("MME_Storage: Triggered setBreastRows() for actor " + akActor.GetLeveledActorBase().GetName())
	int BreastRows = verifyIntRange("MME_Storage.setBreastRows()", Value, 1, 4)
	return StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.BreastRows", BreastRows) as int
endfunction

float function getBreastsBaseadjust(actor akActor) global
	Debug.Trace("MME_Storage: Triggered getBreastsBaseadjust() for actor " + akActor.GetLeveledActorBase().GetName())
	return StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.BreastBaseMod")
endfunction

function setBreastsBaseadjust(actor akActor, float Value) global
	Debug.Trace("MME_Storage: Triggered setBreastsBaseadjust() for actor " + akActor.GetLeveledActorBase().GetName())
	;fix Baseadjust, so Basevalue + Baseadjust is not negative
	float BreastsBasevalue = getBreastsBasevalue(akActor)
	if value < 0 && BreastsBasevalue * -1 > value
		value = BreastsBasevalue * -1
	endif
	StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.BreastBaseMod", Value)
endfunction

float function getBreastsBasevalue(actor akActor) global
	Debug.Trace("MME_Storage: Triggered getBreastsBasevalue() for actor " + akActor.GetLeveledActorBase().GetName())
	if StorageUtil.HasFloatValue(akActor, "MME.MilkMaid.BreastBase")
		return StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.BreastBase")
	elseif (NetImmerse.HasNode(akActor, "NPC L Breast", false))
		; value was not known yet for whatever reason - properly initialise it
		Debug.Trace("MME_Storage: Called getBreastsBasevalue() but value is not known yet!")
		float nodescale = NetImmerse.GetNodeScale(akActor, "NPC L Breast", false)
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.BreastBase", nodescale)
		return nodescale
	else
		; value was not known yet for whatever reason - properly initialise it
		Debug.Trace("MME_Storage: Called getBreastsBasevalue() but value is not known yet!")
		float nodescale = 1
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.BreastBase", nodescale)
		return nodescale
	endif
endfunction

function setBreastsBasevalue(actor akActor, float Value) global
	Debug.Trace("MME_Storage: Triggered setBreastsBasevalue() for actor " + akActor.GetLeveledActorBase().GetName())
	StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.BreastBase", Value)
	;fix Baseadjust, so Basevalue + Baseadjust is not negative
	setBreastsBaseadjust(akActor, getBreastsBaseadjust(akActor))
endfunction

float function getLactacidCurrent(actor akActor) global
	Debug.Trace("MME_Storage: Triggered getLactacidCurrent() for actor " + akActor.GetLeveledActorBase().GetName())
	return StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.LactacidCount")
endfunction

; verifies whether the provided value is inside the allowed range
;
; provided value   resulting 'LactacidCurrent'   return value
;        x < 0              0                       false
;   0 <= x <= Max           x                       true
;        x > Max           Max                      false
bool function setLactacidCurrent(actor akActor, float Value) global
	Debug.Trace("MME_Storage: Triggered setLactacidCurrent() for actor " + akActor.GetLeveledActorBase().GetName())
	float LactacidMax = getLactacidMaximum(akActor)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	
	if Value < 0
		Debug.Trace("MME_Storage: Provided values would result in LactacidCurrent = " + Value)
		Debug.Trace("MME_Storage: Clamping LactacidCurrent to 0 instead.")
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.LactacidCount", 0)
		return false
	else
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.LactacidCount", Value)
		return true
	endif
endfunction

bool function changeLactacidCurrent(actor akActor, float Delta) global
	Debug.Trace("MME_Storage: Triggered changeLactacidCurrent() for actor " + akActor.GetLeveledActorBase().GetName())
	float Value = getLactacidCurrent(akActor)
	return setLactacidCurrent(akActor, Value + Delta)
endfunction

float function getLactacidMaximum(actor akActor) global
	return (StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.Level") + 2) / 2 + 4
endfunction

; Beware:
;   'MaidLevel' is stored as a float value for historical reasons,
;   but fractional values are invalid and potentially break things.
;    -> Provide an integer value instead.

int function getMaidLevel(actor akActor) global
	Debug.Trace("MME_Storage: Triggered getMaidLevel() for actor " + akActor.GetLeveledActorBase().GetName())
	return StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.Level") as int
endfunction

int function setMaidLevel(actor akActor, int Value) global
	Debug.Trace("MME_Storage: Triggered setMaidLevel() for actor " + akActor.GetLeveledActorBase().GetName())
	StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.Level", Value)
	updateMilkMaximum(akActor)
	return Value
endfunction

float function getMilkCurrent(actor akActor) global
	Debug.Trace("MME_Storage: Triggered getMilkCurrent() for actor " + akActor.GetLeveledActorBase().GetName())
	return StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.MilkCount")
endfunction

float function updateMilkCurrent(actor akActor) global
	Debug.Trace("MME_Storage: Triggered updateMilkCurrent() for actor " + akActor.GetLeveledActorBase().GetName())
	float MilkCur = getMilkCurrent(akActor)
	float MilkMax = getMilkMaximum(akActor)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST

	if MilkCur <= MilkMax
		Debug.Trace("  -> " + MilkCur + " <=  " + MilkMax)
		return MilkCur
	elseif MilkQ.BreastScaleLimit
		Debug.Trace("  -> " + MilkCur + " >  " + MilkMax)
		Debug.Trace("MME_Storage: BreastScaleLimit is " + MilkQ.BreastScaleLimit)
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkCount", MilkMax)
		return MilkMax
	else 
		Debug.Trace("  -> " + MilkCur + " >  " + MilkMax)
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkCount", MilkCur)
		return MilkCur
	endif
endfunction

function setMilkCurrent(actor akActor, float Value, bool enforceMaxValue) global
	Debug.Trace("MME_Storage: Triggered setMilkCurrent() for actor " + akActor.GetLeveledActorBase().GetName())
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST

	if enforceMaxValue && MilkQ.PiercingCheck(akActor) != 2
		float MilkMax = getMilkMaximum(akActor)
		if Value <= 0
			Debug.Trace("  -> " + 0 + " <=  " + MilkMax)
			StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkCount", 0)
		elseif Value <= MilkMax
			Debug.Trace("  -> " + Value + " <=  " + MilkMax)
			StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkCount", Value)
		else
			Debug.Trace("  -> " + Value + " >  " + MilkMax)
			StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkCount", MilkMax)
		endif
	else
		if (Value) <= 0
			Debug.Trace("  -> " + Value + " (no limit enforced)")
			StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkCount", 0)
		else
			Debug.Trace("  -> " + Value + " (no limit enforced)")
			StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkCount", Value)
		endif
	endif
endfunction

function changeMilkCurrent(actor akActor, float Delta, bool enforceMaxValue) global
	Debug.Trace("MME_Storage: Triggered changeMilkCurrent() for actor " + akActor.GetLeveledActorBase().GetName())
	float MilkCur = getMilkCurrent(akActor)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST

	if enforceMaxValue && MilkQ.PiercingCheck(akActor) != 2
		float MilkMax = getMilkMaximum(akActor)
		if (MilkCur + Delta) <= 0
			StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkCount", 0)
		elseif (MilkCur + Delta) <= MilkMax
			StorageUtil.AdjustFloatValue(akActor, "MME.MilkMaid.MilkCount", Delta)
		else
			Debug.Trace("MME_Storage.changeMilkCurrent(): " + akActor.GetLeveledActorBase().GetName() + " -> " + (MilkCur + Delta) + ">" + MilkMax)
			StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkCount", MilkMax)
		endif
	else
		if (MilkCur + Delta) <= 0
			StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkCount", 0)
		else
			StorageUtil.AdjustFloatValue(akActor, "MME.MilkMaid.MilkCount", Delta)
		endif
	endif
endfunction

float function getMilkMaximum(actor akActor) global
	Debug.Trace("MME_Storage: Triggered getMilkMaximum() for actor " + akActor.GetLeveledActorBase().GetName())

	; intentionally not using 'missing = ...' in order to avoid computing
	; a default value that's immediately thrown away in almost every case
	if StorageUtil.HasFloatValue(akActor, "MME.MilkMaid.MilkMaximum")
		return StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.MilkMaximum")
	else
		; should only trigger when upgrading an existing savegame
		Debug.Trace("MME_Storage.getMilkMaximum(): Reinitializing default value for actor " + akActor.GetLeveledActorBase().GetName())
		float MaidLevel = StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.Level")
		float MilkMax   = calculateMilkLimit(akActor, MaidLevel)
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkMaximum", MilkMax)
		return MilkMax
	endif
endfunction

float function getMilkMaxBasevalue(actor akActor) global
	Debug.Trace("MME_Storage: Triggered getMilkMaxBasevalue() for actor " + akActor.GetLeveledActorBase().GetName())
	return StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.MilkMax.Basevalue", missing = 2)
endfunction

function setMilkMaxBasevalue(actor akActor, float Value) global
	Debug.Trace("MME_Storage: Triggered setMilkMaxBasevalue() for actor " + akActor.GetLeveledActorBase().GetName())
	StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkMax.Basevalue", Value)
	updateMilkMaximum(akActor)
endfunction

float function getMilkMaxScalefactor(actor akActor) global
	Debug.Trace("MME_Storage: Triggered getMilkMaxScalefactor() for actor " + akActor.GetLeveledActorBase().GetName())
	return StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.MilkMax.Scalefactor", missing = 1)
endfunction

function setMilkMaxScalefactor(actor akActor, float Value) global
	Debug.Trace("MME_Storage: Triggered setMilkMaxScalefactor() for actor " + akActor.GetLeveledActorBase().GetName())
	StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkMax.Scalefactor", Value)
	updateMilkMaximum(akActor)
endfunction

; Please note:
; - The milk production rate depends on the initial breast node's size, the
;   breast size increase per maid level, the number of breasts and the base
;   hourly production rate.
; - The calculated rate is further modified by actor arousal and global milk
;   production modifier -> MilkGenRate*ArousalBonus*GlobalMilkProdFactor
; - Lactacid bonus is no longer included, it must be applied separately.
; - A tick is expected to occur every two minutes. Changing the tick rate
;   changes the hourly milk production rate.

float function getMilkProdPerHour(actor akActor) global
	float MilkGen = StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.MilkGen")
	return calculateMilkProdPerHour(akActor, MilkGen)
endfunction

float function setMilkProdPerHour(actor akActor, float MilkProdPerHour) global
	float MilkGen = calculateMilkGen(akActor, MilkProdPerHour)
	StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkGen", MilkGen)

	; return value can be different then provided value
	return calculateMilkProdPerHour(akActor, MilkGen)
endfunction

; TODO dynamically adjust allowable maximum or restrict actual production rate to maximum
; (It is currently possible to have a milk production rate exceeding the maximum
;  configurable value. This is usually a result of an increased production rate
;  and/or regular milking.)
float function getMilkMaxProdPerHour(actor akActor) global
	; '25' was previously hardcoded in MilkMCM, it has no other significance
	return calculateMilkProdPerHour(akActor, 25)
endfunction

float function getPainCurrent(actor akActor) global
	Debug.Trace("MME_Storage: Triggered getPainCurrent() for actor " + akActor.GetLeveledActorBase().GetName())
	return StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.PainCount")
endfunction

; verifies whether the provided value is inside the allowed range
;
; provided value   resulting 'PainCurrent'   return value
;        x < 0              0                   false
;   0 <= x <= Max           x                   true
;        x > Max           Max                  false
bool function setPainCurrent(actor akActor, float Value) global
	Debug.Trace("MME_Storage: Triggered setPainCurrent() for actor " + akActor.GetLeveledActorBase().GetName())
	float PainMax = getPainMaximum(akActor)

	if Value < 0
		Debug.Trace("MME_Storage: Provided values would result in PainCurrent = " + Value)
		Debug.Trace("MME_Storage: Clamping PainCurrent to 0 instead.")
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.PainCount", 0)
		return false
	elseif Value > PainMax
		Debug.Trace("MME_Storage: Provided values would result in PainCurrent = " + Value)
		Debug.Trace("MME_Storage: Clamping PainCurrent to " + PainMax + " instead.")
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.PainCount", PainMax)
		return false
	else
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.PainCount", Value)
		return true
	endif
endfunction

float function getPainMaximum(actor akActor) global
	return (StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.Level") + 2) * 2
endfunction

float function getWeightBasevalue(actor akActor) global
	Debug.Trace("MME_Storage: Triggered getWeightBasevalue() for actor " + akActor.GetLeveledActorBase().GetName())
	return StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.WeightBase")
endfunction

function setWeightBasevalue(actor akActor, float Value) global
	Debug.Trace("MME_Storage: Triggered setWeightBasevalue() for actor " + akActor.GetLeveledActorBase().GetName())
	StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.WeightBase", Value)
endfunction

float function getBreastNodeScale(actor akActor) global
	string ActorName = akActor.GetLeveledActorBase().GetName()

	bool isFirstPerson = false
	if NetImmerse.HasNode(akActor, "NPC L Breast", isFirstPerson) && NetImmerse.HasNode(akActor, "NPC R Breast", isFirstPerson)
		float BreastL = NetImmerse.GetNodeScale(akActor, "NPC L Breast", isFirstPerson)
		float BreastR = NetImmerse.GetNodeScale(akActor, "NPC R Breast", isFirstPerson)

		; <sanity check>
		if (BreastL != BreastR)
			Debug.Trace("[MilkModEconomy] " + ActorName + " has differently sized left and right breast!")
			Debug.Trace("[MilkModEconomy] Asymetric breasts are not supported!")
		endif
		; </sanity check>

		return BreastL
	else
		;2k2k, smp skeleton?
		;Debug.Trace("[MilkModEconomy] Unsupported skeleton or armor - unable to find breast nodes for '" + ActorName + "'!")
		;Debug.Trace("[MilkModEconomy] (Mod will work but breast growth will have no visible effect.)")

		return 1.0
	endif
endfunction

; original formula to calculate the maximum milk limit was '(Level+2)*2'
float function calculateMilkLimit(actor akActor, float Level) global
	int   BreastRows      = getBreastRows(akActor)
	float BreastsPerRow   = 2
	float MilkBasevalue   = StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.MilkMax.Basevalue", missing = 2)
	float MilkScalefactor = StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.MilkMax.Scalefactor", missing = 1)

	return (MilkBasevalue + Level*MilkScalefactor)*BreastRows*BreastsPerRow
endfunction

; convert 'milk production per hour' to 'MME.MilkMaid.MilkGen'
float function calculateMilkGen(actor akActor, float MilkProdPerHour) global
	if MilkProdPerHour <= 0.0
		return 0.0
	endif

	float BreastsBasevalue = getBreastsBasevalue(akActor)
	float BoobPerLvl       = StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.BoobPerLvl", missing = -1)
	int   MaidLevel        = getMaidLevel(akActor)
	int   BreastRows       = getBreastRows(akActor)

	; use default if value is negative (e.g. -1)
	if BoobPerLvl < 0.0
		BoobPerLvl = 0.07
	endif

	return ((MilkProdPerHour/BreastRows)*3*10) - BreastsBasevalue - (BoobPerLvl*MaidLevel)
endfunction

; convert 'MME.MilkMaid.MilkGen' to 'milk production per hour'
float function calculateMilkProdPerHour(actor akActor, float MilkGen) global
	if MilkGen <= 0.0
		return 0.0
	endif

	float BreastsBasevalue = getBreastsBasevalue(akActor)
	float BoobPerLvl       = StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.BoobPerLvl", missing = -1)
	int   MaidLevel        = getMaidLevel(akActor)
	int   BreastRows       = getBreastRows(akActor)

	; use default if value is negative (e.g. -1)
	if BoobPerLvl < 0.0
		BoobPerLvl = 0.07
	endif

	return ((BreastsBasevalue + (BoobPerLvl*MaidLevel) + MilkGen)/3/10)*BreastRows
endfunction

function updateMilkMaximum(actor akActor) global
	float MilkMax = calculateMilkLimit(akActor, StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.Level"))

	; MilkMax must be >=1 to enable milking
	float MinValue = 1
	if MilkMax >= MinValue
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkMaximum", MilkMax)
	else
		Debug.Trace("MME_Storage: User provided values would result in MilkMax = " + MilkMax)
		Debug.Trace("MME_Storage: Clamping MilkMax to " + MinValue + " instead.")
		StorageUtil.SetFloatValue(akActor, "MME.MilkMaid.MilkMaximum", MinValue)
	endif
	updateMilkCurrent(akActor)
endfunction

int function verifyIntRange(string Caller, int Value, int MinValue, int MaxValue) global
	if Value < MinValue
		Debug.Trace("Function '" + Caller + "' provided invalid value '" + Value + "'! (allowed range is " + MinValue + " <= x <= " + MaxValue + ")")
		return MinValue
	elseif Value > MaxValue
		Debug.Trace("Function '" + Caller + "' provided invalid value '" + Value + "'! (allowed range is " + MinValue + " <= x <= " + MaxValue + ")")
		return MaxValue
	else
		return Value
	endif
endfunction
