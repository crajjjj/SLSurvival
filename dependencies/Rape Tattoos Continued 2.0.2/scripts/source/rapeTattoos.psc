ScriptName rapeTattoos extends Quest
; Script for randomly adding tattoos to the player after an aggressive sexual act

import PO3_SKSEFunctions
import rapeTattoos_utils

Actor property PlayerRef auto
SexLabFramework property SexLab auto
rapeTattoos_mcm property menuForm auto

bool zazInstalled = false
Faction zazSlaveFaction

int playerMissedChances = 0
int npcMissedChances = 0
int zazMissedChances = 0

string GROUP_EXCLUDED = "(excluded)"
string GROUP_UNASSIGNED = "(unassigned)"
string DEFAULT_GROUP = "(excluded)"

; I'd eventually like to expose this via the MCM, but need to improve the picking algorithm first
int MAX_TATTOOS_PER_GROUP = 1

Event OnInit()
	log("RapeTattoos Loaded", true)
	doEveryGameLoad()
	
	RegisterForKey(49) ; N Key
	RegisterForKey(21) ; Y Key
EndEvent

function doEveryGameLoad()
	log("Game loaded - registering for mod events")
	RegisterForModEvent("AnimationEnd","aniEndHook")
	RegisterForModEvent("RapeTattoos_addTattoo","addTattooEvent")
	RegisterForModEvent("RapeTattoos_addTattooV2","addTattooEventV2")

	zazInstalled = rapeTattoos_utils.isZazInstalled()
	if zazInstalled
		zazSlaveFaction = rapeTattoos_utils.getZazSlaveFaction()
	endif
endfunction

; Simple (legacy) Rape Tattoos mod event - kept for backwards compatibility
;
; Usage:
; -------------------------------------
; SendModEvent("RapeTattoos_addTattoo")
; -------------------------------------
event addTattooEvent(string eventName, string argString, float argNum, form sender)
	addTattooEventV2(PlayerRef, 1)
endevent

; RapeTattoos_addTattoo mod event handler
;
; TODO: Is there any way to have a single mod event with optional arguments
; here? As far as I'm aware function overloading isn't a thing in Papyrus, and
; it might be handy to add optional color/glow/gloss overrides to the event in
; the future.
;
; Usage:
; -----------------------------------------------------------------------------
; int handle = ModEvent.Create("RapeTattoos_addTattooV2")
; if (handle)
; 	ModEvent.PushForm(handle, target) ; target should be an Actor reference
; 	ModEvent.PushInt(handle, count)
; 	ModEvent.Send(handle)
; endIf
; -----------------------------------------------------------------------------
event addTattooEventV2(Form targetActor, int count)
	Actor target = targetActor as Actor
	if !target
		target = PlayerRef
	endif

	log("Received event to add " + count + " tattoo(s) to " + target.GetLeveledActorBase().GetName())
	doTattooActionFor(target, count)
endevent

Event OnKeyUp(int keyCode, float holdTime)
	if (!menuForm.debugEnabled)
		return
	endif

	if keyCode == 49 ; N key
		Actor target = Game.GetCurrentCrosshairRef() as Actor
		if !target
			target = PlayerRef
		endif

		log("[ Debug ] Adding " + menuForm.debugTattooCount + " tattoo(s) to " + target.GetLeveledActorBase().GetName(), true)

		doTattooActionFor(target, menuForm.debugTattooCount)
	elseif keyCode == 21 ; Y key
		Actor target = Game.GetCurrentCrosshairRef() as Actor
		if !target
			target = PlayerRef
		endif

		log("[ Debug ] Simulating post-rape event for " + target.GetLeveledActorBase().GetName(), true)

		maybeTriggerFor(target)
	endIf
endEvent

; This function handles all context independant actor eligibility tests
bool function isValidTattooTarget(Actor candidate)
    if candidate == None
        return false
    endif
    
    ; NPC Check
    if !menuForm.allowNPC && candidate != PlayerRef 
        return false
    endif
    
    ; Gender Check
    int gender = Math.LogicalAnd(SexLab.getGender(candidate), 1)
    if (!menuForm.allowMale && gender == 0) || (!menuForm.allowFemale && gender == 1)
        return false
    endif
    
    return true
endfunction

event aniEndHook(string eventName, string argString, float argNum, form sender)
    Actor[] actorList = SexLab.HookActors(argString)
    if SexLab.CreatureCount(actorList) > 0 && menuForm.excludeBeastiality
        ; Ignore sex scene
        return
    endif
    
    if menuForm.onlyVictim
        ; Only consider victim
        Actor victim = Sexlab.HookVictim(argString)
        if isValidTattooTarget(victim)
            maybeTriggerFor(victim)
        endif
    else
        ; Check all actors
        int i = actorList.Length - 1
        while i >= 0
            if isValidTattooTarget(actorList[i])
                maybeTriggerFor(actorList[i])
            endif
            i -= 1
        endwhile
    endif
endEvent

function maybeTriggerFor(Actor target)
	log("Checking for post-rape tattoo addition on " + target.GetLeveledActorBase().GetName() + "...")
	int missedChances = getMissedChancesFor(target)
	float curChance = getBaseChanceFor(target) + (missedChances as float) * getChanceIncreaseFor(target)
	float roll = Utility.RandomFloat()
	if roll < curChance
		int count = Utility.randomInt(getMinTattoosFor(target), getMaxTattoosFor(target))
		log("Post-rape tattoos triggered (" + roll + " &lt; " + curChance + ") - adding " + count + " tattoos")
		if doTattooActionFor(target, count)
            if PlayerRef != target && menuForm.enableNPCNotification
               string targetName = target.GetActorBase().GetName()
               log("" + targetName + " got tattooed", true, true)
            endif
            
			if menuForm.enableNotification && PlayerRef == target
				log("Your last partner left you a memento...", true, true)
			endif
			setMissedChancesFor(target, 0)
		else
			setMissedChancesFor(target, missedChances + 1)
		endIf
	else
		log("No tattoos to add this time (" + roll + " >= " + curChance + ")")
		setMissedChancesFor(target, missedChances + 1)
	endIf
endfunction

string function getGroupForEntry(int dataMap, int tattooEntry)
	int extraData = JMap.getObj(dataMap,JMap.getStr(tattooEntry,"texture"))
	if extraData == 0
		return DEFAULT_GROUP
	else
		string groupName = JMap.getStr(extraData,"group")
		if groupName == ""
			groupName = DEFAULT_GROUP
		endif
		return groupName
	endif
endfunction

; Returns retained JArray with Tattoo entries
; Tattoo entries may be modified from their default state
; (color, gloss, glow etc)
int function getAdjustedTattooArray()
	int template = JValue.retain(JMap.object())
	int matches = JValue.retain(JArray.object())
	if SlaveTats.query_available_tattoos(template,matches)
		; Error Occurred, ignore for now
	endif
	JValue.release(template)
	
	return matches
endfunction

; Picks the requested number of tattoos (or as many as possible) from the
; provided adjusted tattoo list, ensuring that the tattoos are eligible for
; adding to the target
int function pickTattoos(int adjustedList, Actor target, int dataMap, int count)
	int appliedTattoos = getCurrentlyAppliedTattoos(target)
	int groupCounts = getTattooCountPerGroup(target, appliedTattoos, dataMap)
	int pickedTattoos = JValue.retain(JArray.object())
	int appliedTextureMap = generateAppliedTextureMap(appliedTattoos)

	; Get rid of any ineligible tattoos - subsequent filters only need to check against group counts
	filterTattooList(adjustedList, groupCounts, dataMap, appliedTextureMap)

	log("Attempting to pick " + count + " tattoos to apply to " + target.GetLeveledActorBase().getName())

	int i = 0
	int chosenIndex
	int chosenTattoo
	string group
	string texture
	int groupCount

	; Things should be pretty well-filtered now, so no need to do any more full-array filters
	while i < count && JArray.count(adjustedList) > 0
		chosenIndex = Utility.RandomInt(0, JArray.count(adjustedList))
		chosenTattoo = JArray.getObj(adjustedList, chosenIndex)

		group = getGroupForEntry(dataMap, chosenTattoo)
		texture = JMap.getStr(chosenTattoo, "texture")
		groupCount = JMap.getInt(groupCounts, group)

		if JMap.hasKey(appliedTextureMap, texture)
			; A tattoo with this texture path has already been applied
			; This should almost never happen, so no need to refilter - just remove this one from the list and go around again
			JArray.eraseIndex(adjustedList, chosenIndex)
			log("Tattoo texture \"" + texture + "\" already applied - skipping")
		elseif group != GROUP_UNASSIGNED && groupCount >= MAX_TATTOOS_PER_GROUP
			; That group's full now - we actually need to re-filter
			filterTattooList(adjustedList, groupCounts, dataMap, appliedTextureMap)
			log("Tattoo group " + group + " already full (count: " + groupCount + ") - skipping")
		else
			; The tattoo was valid - add it to out picks
			JArray.addObj(pickedTattoos, chosenTattoo)
			JArray.eraseIndex(adjustedList, chosenIndex)
			; Don't forget to update the group count & applied texture map
			JMap.setInt(groupCounts, group, groupCount + 1)
			JMap.setInt(appliedTextureMap, texture, 1)
			; We successfully added a tattoo - increment the counter
			i += 1
		endif
	endwhile

	JValue.release(appliedTattoos)
	JValue.release(groupCounts)
	JValue.release(appliedTextureMap)

	log(JArray.count(pickedTattoos) + " tattoos picked for addition")

	return pickedTattoos
endfunction

; Takes a retained JArray of tattoo entries, as formatted from
; getAdjustedTattooArray() and removes any entries that:
; - Share the texture of an applied tattoo
; - Share the group of an applied tattoo (unless it's the special
;   "(unassigned)" group)
; - Is part of the "(excluded)" group
function filterTattooList(int adjustedList, int groupCounts, int dataMap, int appliedTextureMap)
	int i = JArray.count(adjustedList) - 1
	bool excluded
	string texturePath
	string group
	int tattoo

	log("Filtering " + JArray.count(adjustedList) + " tattoos...")

	; Loop through the list and removes entries that don't match criteria
	while i >= 0
		excluded = false
		
		; Determine group of tattoo
		tattoo = JArray.getObj(adjustedList, i)
		group = getGroupForEntry(dataMap, tattoo)
		
		if group == GROUP_EXCLUDED
			; Part of manually excluded group
			excluded = true
		elseif group != GROUP_UNASSIGNED && JMap.getInt(groupCounts, group) >= MAX_TATTOOS_PER_GROUP
			; Part of excludeable group for which the maximum number of tattoos has already been applied
			excluded = true
		else
			texturePath = JMap.getStr(tattoo, "texture")
			if JMap.hasKey(appliedTextureMap, texturePath)
				; A tattoo with this texture path has already been applied
				excluded = true
			endif
		endif
			
		if excluded
			; Remove entry from list/array
			JArray.eraseIndex(adjustedList, i)
		endif
		
		i -= 1
	endwhile

	log("Tattoos after filtering: " + JArray.count(adjustedList))
endfunction

; Returns a JArray of the currently applied tattoos on the target
int function getCurrentlyAppliedTattoos(Actor target)
	int template = JValue.retain(JMap.object())
	int appliedTattoos = JValue.retain(JArray.object())
	if SlaveTats.query_applied_tattoos(target, template, appliedTattoos)
		log("Failed to retrieve currently applied tattoos on " + target.GetLeveledActorBase().GetName())
		; Error Occurred, ignore for now
	endif
	JValue.release(template)
	return appliedTattoos
endfunction

; Converts a JArray of tattoos into a JMap whose keys are the textures of the
; tattoos, and whose values are all 1 (indicating that the texture is
; currently applied)
int function generateAppliedTextureMap(int appliedTattooArray)
	int appliedTextureMap = JValue.retain(JMap.object())
	int i = JArray.count(appliedTattooArray)
	while i >= 0
		JMap.setInt(appliedTextureMap, JMap.getStr(JArray.getObj(appliedTattooArray, i), "texture"), 1)
		i -= 1
	endwhile
	return appliedTextureMap
endfunction

; Returns a JMap mapping group names to the count of tattoos currently applied in that group
int function getTattooCountPerGroup(Actor target, int appliedTattoos, int dataMap)
	int groupCountMap = JValue.retain(JMap.object())
	int i = JArray.count(appliedTattoos) - 1
	int currentEntry
	string group
	int groupCount

	while i >= 0
		; Determine group of tattoo
		currentEntry = JArray.getObj(appliedTattoos, i)
		group = getGroupForEntry(dataMap, currentEntry)
		groupCount = JMap.getInt(groupCountMap, group)
		JMap.setInt(groupCountMap, group, groupCount + 1)
		i -= 1
	endwhile

	return groupCountMap
endfunction

; Not used internally any more - kept for backwards compatibility
; Use doTattooActionFor instead for more fine-grained control
bool function doTattooAction()
    return doTattooActionFor(PlayerRef)
endfunction

bool function doTattooActionFor(Actor target, int count = 1)
	bool tattoosAdded = addMultipleTattoos(target, count)

	if tattoosAdded
		; If any tattoos were successfully added, synchronize
		return !SlaveTats.synchronize_tattoos(target, !menuForm.debugEnabled)
	endif

	return tattoosAdded
endfunction

; Handles adding multiple (or just one) tattoo to an actor. Returns true if any
; tattoo was added (even if the full number couldn't be)
bool function addMultipleTattoos(Actor target, int count = 1)
	int dataMap = rapeTattoos_utils.getDataMap()
	int adjustedList = getAdjustedTattooArray()

	if JArray.count(adjustedList) == 0
		log("No valid tattoos available", true)
		JValue.release(dataMap)
		JValue.release(adjustedList)
		return false
	endif

	int chosenTattoos = pickTattoos(adjustedList, target, dataMap, count)
	int colorConfig = rapeTattoos_utils.getColorConfig()

	int i = JArray.count(chosenTattoos) - 1
	int totalAdded = 0
	int chosenTattoo

	while i >= 0
		chosenTattoo = JArray.getObj(chosenTattoos, i)

		; Overwrites properties if necessary
		setTattooColor(chosenTattoo, colorConfig)
		setTattooGlow(chosenTattoo, colorConfig)
		setTattooGloss(chosenTattoo)
		if areTattoosLockedFor(target)
			JMap.setInt(chosenTattoo, "locked", 1)
		endif

		; Adds the tattoo via SlaveTats, but don't sync yet
		if SlaveTats.add_tattoo(target, chosenTattoo, -1, ignore_lock=false, silent=true)
			; Tattoo addition failed - just log it for now
			log("Failed to add a tattoo to " + target.GetLeveledActorBase().GetName())
		else
			totalAdded += 1
			if !areTattoosPermanentFor(target)
				; If tattoo got added successfully and this is a non-permanent tattoo, register for fade-out
				fadeTattoos.doAlphaFadeForTarget(target, JMap.getStr(chosenTattoo, "texture"), getTattooDurationFor(target))
			endif
		endif

		i -= 1
	endwhile

	log("Added " + totalAdded + " of " + count + " requested tattoos")

	JValue.release(dataMap)
	JValue.release(adjustedList)
	JValue.release(chosenTattoos)
	JValue.release(colorConfig)

	return totalAdded > 0
endfunction

; Gets the base tattoo chance for an actor
float function getBaseChanceFor(Actor target)
	return getFloatValueFor(target, menuForm.baseChance, menuForm.npcBaseChance, menuForm.zazBaseChance)
endfunction

; Gets the chance increase for an actor
float function getChanceIncreaseFor(Actor target)
	return getFloatValueFor(target, menuForm.chanceIncrease, menuForm.npcChanceIncrease, menuForm.zazChanceIncrease)
endfunction

; Gets the minimum number of tattoos that can be applied to an actor
int function getMinTattoosFor(Actor target)
	return getIntValueFor(target, menuForm.minTattoos, menuForm.npcMinTattoos, menuForm.zazMinTattoos)
endfunction

; Gets the maximum number of tattoos that can be applied to an actor
int function getMaxTattoosFor(Actor target)
	return getIntValueFor(target, menuForm.maxTattoos, menuForm.npcMaxTattoos, menuForm.zazMaxTattoos)
endfunction

; Determines whether tattoos added to an actor should be permanent
bool function areTattoosPermanentFor(Actor target)
	return getBoolValueFor(target, menuForm.permanentTattoos, menuForm.npcPermanentTattoos, menuForm.zazPermanentTattoos)
endfunction

; Determines whether tattoos added to an actor should be locked
bool function areTattoosLockedFor(Actor target)
	return getBoolValueFor(target, menuForm.useLockedTats, menuForm.npcUseLockedTats, menuForm.zazUseLockedTats)
endfunction

; Gets the duration (in hours) that should be used for tattoos on an actor
float function getTattooDurationFor(Actor target)
	return getFloatValueFor(target, menuForm.tattooDurationHours, menuForm.npcTattooDurationHours, menuForm.zazTattooDurationHours)
endfunction

; Gets the number of missed chances that have accumulated for an actor (missed
; chances are calculated per "faction" rather than per actor)
int function getMissedChancesFor(Actor target)
	return getIntValueFor(target, playerMissedChances, npcMissedChances, zazMissedChances)
endfunction

; Sets the missed chances value for an actor (missed chances are calculated per
; "faction" rather than per actor)
function setMissedChancesFor(Actor target, int value)
	if zazSlaveFaction != None && target.IsInFaction(zazSlaveFaction)
		zazMissedChances = value
	elseif target == PlayerRef
		playerMissedChances = value
	else
		npcMissedChances = value
	endif
endfunction

; Picks an appropriate float value from the given values based on whether the target is the player, an NPC, or a Zaz slave
float function getFloatValueFor(Actor target, float playerValue, float npcValue, float zazValue)
	if zazSlaveFaction != None && target.IsInFaction(zazSlaveFaction)
		return zazValue
	elseif target == PlayerRef
		return playerValue
	else
		return npcValue
	endif
endfunction

; Picks an appropriate int value from the given values based on whether the target is the player, an NPC, or a Zaz slave
int function getIntValueFor(Actor target, int playerValue, int npcValue, int zazValue)
	if zazSlaveFaction != None && target.IsInFaction(zazSlaveFaction)
		return zazValue
	elseif target == PlayerRef
		return playerValue
	else
		return npcValue
	endif
endfunction

; Picks an appropriate bool value from the given values based on whether the target is the player, an NPC, or a Zaz slave
bool function getBoolValueFor(Actor target, bool playerValue, bool npcValue, bool zazValue)
	if zazSlaveFaction != None && target.IsInFaction(zazSlaveFaction)
		return zazValue
	elseif target == PlayerRef
		return playerValue
	else
		return npcValue
	endif
endfunction

; Sets (or doesn't) the color of a tattoo based on MCM configuration
function setTattooColor(int tattoo, int colorConfig)
	if menuForm.tattooColorMode == 0 ; Fixed color
		JMap.setInt(tattoo, "color", menuForm.tattooColor)
	elseif menuForm.tattooColorMode == 1 ; Random color
		JMap.setInt(tattoo, "color", Utility.RandomInt(0, 0xFFFFFF))
	elseif menuForm.tattooColorMode == 2 ; Weighted random color
		int colorMap = JMap.getObj(colorConfig, "colors")
		int selectedColor = getWeightedRandomColor(colorMap)
		JMap.setInt(tattoo, "color", selectedColor)
	endif ; For "None" color mode, don't override the color at all
endfunction

; Sets (or doesn't) the glow color of a tattoo based on MCM configuration
function setTattooGlow(int tattoo, int colorConfig)
	if menuForm.tattooGlowMode == 0 ; Fixed color
		JMap.setInt(tattoo, "glow", menuForm.tattooGlow)
	elseif menuForm.tattooGlowMode == 1 ; Random color
		JMap.setInt(tattoo, "glow", Utility.RandomInt(0, 0xFFFFFF))
	elseif menuForm.tattooGlowMode == 2 ; Weighted random color
		int glowMap = JMap.getObj(colorConfig, "glows")
		int selectedGlow = getWeightedRandomColor(glowMap)
		JMap.setInt(tattoo, "glow", selectedGlow)
	endif ; For "None" glow mode, don't override the glow at all
endfunction

; Picks a random color for a tattoo based on the user-configured colors and corresponding weights
int function getWeightedRandomColor(int colorMap)
	int colors = JMap.allKeys(colorMap)

	int weights = JMap.allValues(colorMap)
	int selectedIndex = getWeightedRandomIndex(weights)

	string selectedColorHex = "0x000000"
	if selectedIndex != -1
		selectedColorHex = JArray.getStr(colors, selectedIndex)
	endif

	return PO3_SKSEFunctions.StringToInt(selectedColorHex)
endfunction

; Picks a random index based on an array of index weights
int function getWeightedRandomIndex(int weights)
	int sum = 0
	int i = 0
	int count = JArray.count(weights)
	while i < count
		sum += JArray.getInt(weights, i)
		i += 1
	endwhile

	int randomRoll = Utility.randomInt(0, sum - 1)

	i = 0
	int cumWeight = 0 ; Cumulative weight - get your mind out of the gutter!
	while i < count
		cumWeight += JArray.getInt(weights, i)
		if randomRoll < cumWeight
			return i
		endif
		i += 1
	endwhile

	return -1
endfunction

; Sets (or unsets) the gloss of a tattoo based on MCM configuration
function setTattooGloss(int tattoo)
	int randomRoll = Utility.randomInt(0, 99)
	if randomRoll < menuForm.tattooGlossChance
		JMap.setInt(tattoo, "gloss", 1)
	else
		JMap.setInt(tattoo, "gloss", 0)
	endif
endfunction

function log(string msg, bool notify = false, bool immersive = false)
	if (!immersive)
		msg = "[ Rape Tattoos ] " + msg
	endif

	Debug.Trace(msg)

	if menuForm.debugEnabled || notify
		Debug.Notification(msg)
	endif
endfunction