scriptname rapeTattoos_mcm extends SKI_ConfigBase

import rapeTattoos_utils

int function GetVersion()
	return 2
endFunction

; OIDs
; Player Settings
int playerSettingsHeaderOID
int baseChanceOID
int chanceIncreaseOID
int minTattoosOID
int maxTattoosOID
int permanentTattoosOID
int useLockedTatsOID
int tattooDurationOID

; NPC Settings
int npcSettingsHeaderOID
int npcBaseChanceOID
int npcChanceIncreaseOID
int npcMinTattoosOID
int npcMaxTattoosOID
int npcPermanentTattoosOID
int npcUseLockedTatsOID
int npcTattooDurationOID

; Zaz Settings
int zazSettingsHeaderOID
int zazBaseChanceOID
int zazChanceIncreaseOID
int zazMinTattoosOID
int zazMaxTattoosOID
int zazPermanentTattoosOID
int zazUseLockedTatsOID
int zazTattooDurationOID

; Eligibility
int allowFemaleOID
int allowMaleOID
int allowNPCOID
int onlyVictimOID
int excludeBeastialityOID

; Color/Glow/Gloss
int tattooColorModeOID
int tattooColorOID
int tattooGlowModeOID
int tattooGlowOID
int tattooGlossChanceOID

; Notifications
int enableNotificationOID
int enableNPCNotificationOID

; Tattoo Config
int openTattooConfigOID

; Debug
int debugOID
int debugTattooCountOID
int debugTattooKeyDescriptionOID
int debugRapeKeyDescriptionOID

; Properties
; Player Settings
float property baseChance = 0.10 auto hidden
float property chanceIncrease = 0.07 auto hidden
int property minTattoos = 1 auto hidden
int property maxTattoos = 1 auto hidden
bool property permanentTattoos = False auto hidden
bool property useLockedTats = false auto hidden
float property tattooDurationHours = 168.0 auto hidden

; NPC Settings
float property npcBaseChance = 0.20 auto hidden
float property npcChanceIncrease = 0.10 auto hidden
int property npcMinTattoos = 1 auto hidden
int property npcMaxTattoos = 1 auto hidden
bool property npcPermanentTattoos = false auto hidden
bool property npcUseLockedTats = false auto hidden
float property npcTattooDurationHours = 336.0 auto hidden

; Zaz Settings
float property zazBaseChance = 0.50 auto hidden
float property zazChanceIncrease = 0.10 auto hidden
int property zazMinTattoos = 1 auto hidden
int property zazMaxTattoos = 2 auto hidden
bool property zazPermanentTattoos = false auto hidden
bool property zazUseLockedTats = false auto hidden
float property zazTattooDurationHours = 672.0 auto hidden

; Eligibility
bool property allowFemale = True auto hidden
bool property allowMale = False auto hidden
bool property allowNPC = False auto hidden
bool property onlyVictim = True auto hidden
bool property excludeBeastiality = True auto hidden

; Color/Glow/Gloss
int property tattooColorMode = 2 auto hidden
int property tattooColor = 0 auto hidden ; Used for fixed color mode
int property tattooGlowMode = 2 auto hidden
int property tattooGlow = 0 auto hidden ; Used for fixed glow mode
float property tattooGlossChance = 0.0 auto hidden ; Chance for tattoo gloss (0-100)

; Notifications
bool property enableNotification = True auto hidden
bool property enableNPCNotification = True auto hidden

; Debug
bool property debugEnabled = False auto hidden
int property debugTattooCount = 1 auto hidden

; Local state
int firstTattooPageIdx
int tattooPageCount
int tattoosPerPage = 50

int tattooList = 0
int currentlyAppliedList = 0
int applyQueue = 0
int removeQueue = 0
int tattooOIDToIdxMap = 0
int tattooTextureOIDToIdxMap = 0
int tattooExtraDataMap = 0
string[] tattooGroups

string[] potentialPages

string[] appliedOptions

; Tattoo Color Modes
; -------------------------------------------------------
; 0 = Fixed - Fixed color
; 1 = Random - Completely random color
; 2 = Custom - Weighted random color based on config file
; 3 = No override - Does not apply any color
; -------------------------------------------------------
string[] tattooColorModes

string JC_TAG = "rapeTattoos.mcm"
int INITIAL_PAGE_COUNT = 2
bool configPagesLoaded = false

bool zazInstalled = false

event OnConfigInit()
	initPages()
	
	appliedOptions = new string[2]
	appliedOptions[0] = "Not Applied"
	appliedOptions[1] = "Applied"
	
	tattooGroups = new string[39]
	tattooGroups[0] = "(unassigned)"
	tattooGroups[1] = "(excluded)"
	tattooGroups[2] = "tally"
	tattooGroups[3] = "forehead"
	tattooGroups[4] = "face"
	tattooGroups[5] = "mouth"
	tattooGroups[6] = "shoulder"
	
	tattooGroups[7] = "left arm"
	tattooGroups[8] = "right arm"
	tattooGroups[9] = "left hand"
	tattooGroups[10] = "right hand"
	tattooGroups[11] = "hands"
	
	tattooGroups[12] = "breasts"
	tattooGroups[13] = "left breast"
	tattooGroups[14] = "right breast"
	tattooGroups[15] = "front middle"
	tattooGroups[16] = "front lower"
	
	tattooGroups[17] = "upper back"
	tattooGroups[18] = "middle back"
	tattooGroups[19] = "lower back"
	
	tattooGroups[20] = "pubic"
	tattooGroups[21] = "butt"
	tattooGroups[22] = "left cheek"
	tattooGroups[23] = "right cheek"
	tattooGroups[24] = "left leg"
	tattooGroups[25] = "right leg"
	tattooGroups[26] = "feet"
	
	tattooGroups[27] = "misc 1 - a"
	tattooGroups[28] = "misc 1 - b"
	tattooGroups[29] = "misc 1 - c"
	tattooGroups[30] = "misc 1 - d"
	tattooGroups[31] = "misc 2 - a"
	tattooGroups[32] = "misc 2 - b"
	tattooGroups[33] = "misc 2 - c"
	tattooGroups[34] = "misc 2 - d"
	tattooGroups[35] = "misc 3 - a"
	tattooGroups[36] = "misc 3 - b"
	tattooGroups[37] = "misc 3 - c"
	tattooGroups[38] = "misc 3 - d"

	tattooColorModes = new string[4]
	tattooColorModes[0] = "Fixed"
	tattooColorModes[1] = "Random"
	tattooColorModes[2] = "Custom"
	tattooColorModes[3] = "None " ; Yes, the space is necessary - Papyrus does weird things with the string "None" in arrays
endEvent

event OnVersionUpdate(int newVersion)
	OnConfigInit()
	Debug.Notification("[ Rape Tattoos ] Version update complete")
endEvent

function initPages(int count = 0)
	if count == 0
		count = INITIAL_PAGE_COUNT
	endif
	Pages = Utility.CreateStringArray(count)
	Pages[0] = "General"
	Pages[1] = "Tattoo Setting Explanation"
endfunction

event OnConfigOpen()
	initPages()

	configPagesLoaded = false
	SetTextOptionValue(openTattooConfigOID, "Load tattoo config pages", true)
	SetOptionFlags(openTattooConfigOID, OPTION_FLAG_NONE)
endEvent

event OnConfigClose()
	if tattooExtraDataMap != 0
		JValue.writeToFile(tattooExtraDataMap, JContainers.userDirectory() + "rTats/settings.json")
		menu_performQueuedActions()
	endif

	JValue.release(tattooExtraDataMap)
	JValue.releaseObjectsWithTag(JC_TAG)
endEvent

function loadTattooConfigPages()
	log("Tattoo config load started...")
	SetTextOptionValue(openTattooConfigOID, "Loading tattoos - please wait...", true)
	SetOptionFlags(openTattooConfigOID, OPTION_FLAG_DISABLED)

	tattooList = getAvailableTattoos()
	int tattooCount = JArray.count(tattooList)
	log("Found " + tattooCount + " tattoos when querying SlaveTats")

	setFullPageSet(tattooCount)

	; Creates JMap for connecting the OID of tattoo elements to the tattoo idx
	tattooOIDToIdxMap = JValue.retain(JIntMap.object(), JC_TAG)
	tattooTextureOIDToIdxMap = JValue.retain(JIntMap.object(), JC_TAG)

	currentlyAppliedList = getAppliedSubset(tattooList)
	log("Currently applied tattoos on the player: " + JArray.count(currentlyAppliedList))
	applyQueue = JValue.retain(JArray.object(), JC_TAG)
	removeQueue = JValue.retain(JArray.object(), JC_TAG)

	tattooExtraDataMap = rapeTattoos_utils.getDataMap()

	configPagesLoaded = true

	SetTextOptionValue(openTattooConfigOID, "Tattoos loaded!")

	;UI.InvokeStringA(JOURNAL_MENU, MENU_ROOT + ".setPageNames", Pages)
endfunction

function setFullPageSet(int tattooCount)
	tattooPageCount = 0
	while tattooPageCount*tattoosPerPage < tattooCount
		tattooPageCount += 1
	endwhile
	if tattooPageCount > 126
		tattooPageCount = 126
	endif
	
	; Assign array of correct size
	int totalPages = tattooPageCount + INITIAL_PAGE_COUNT
	log("Total tattoo config pages: " + totalPages)
	initPages(totalPages)

	; Copy over page name data
	int i = INITIAL_PAGE_COUNT
	int pageNumber = 1
	while i < totalPages
		Pages[i] = "Tattoos Page " + pageNumber
		i += 1
		pageNumber += 1
	endwhile
endfunction

; Returns new and retained JArray
; with subset of tattoos that are currently applied
int function getAppliedSubset(int fullList)
	int subsetList = JValue.retain(JArray.object(), JC_TAG)
	int appliedList = JFormDB.getObj(Game.GetPlayer(), ".SlaveTats.applied")
	
	int i = JArray.count(fullList) - 1
	int currentTattoo
	int j
	while i >= 0
		currentTattoo = JArray.getObj(fullList,i)
		j = JArray.count(appliedList) - 1
		while j >=0
			if JMap.getStr(JArray.getObj(appliedList,j),"texture") == JMap.getStr(currentTattoo,"texture")
				JArray.addObj(subsetList,currentTattoo)
				j = -1
			endif
			j -= 1
		endwhile
		
		i -= 1
	endwhile
	
	return subsetList
endfunction

; The menu_ family of function allows you to perform
; isApplied, add, & remove actions while the menu is open without
; immediately making the actual changes.
; The main reason for this is that adding or removing any tattoo will stall the menu
; requiring the user to restart it, but it's also a more efficient method all around

bool function menu_isTattooApplied(int tattooEntry)
	bool check1 = JArray.findObj(currentlyAppliedList,tattooEntry) != -1
	bool check2 = JArray.findObj(applyQueue,tattooEntry) != -1
	bool check3 = JArray.findObj(removeQueue,tattooEntry) == -1
	return (check1 || check2) && check3
endfunction

function menu_applyTattoo(int tattooEntry)
	; If not already applied, add to apply queue and remove from remove queue if necessary
	if !menu_isTattooApplied(tattooEntry)
		JArray.addObj(applyQueue,tattooEntry)
		int i = JArray.findObj(removeQueue,tattooEntry)
		if i != -1
			JArray.eraseIndex(removeQueue,i)
		endif
	endif
endfunction

function menu_removeTattoo(int tattooEntry)
	; If applied, add to remove queue and remove from add queue if necessary
	if menu_isTattooApplied(tattooEntry)
		JArray.addObj(removeQueue,tattooEntry)
		int i = JArray.findObj(applyQueue,tattooEntry)
		if i != -1
			JArray.eraseIndex(applyQueue,i)
		endif
	endif
endfunction

; Perform queued applications and removals
function menu_performQueuedActions()
	Actor playerRef = Game.GetPlayer()
	int tatRef
	int temp
	
	int i = JArray.count(applyQueue) - 1
	while i >= 0
		tatRef = JArray.getObj(applyQueue,i)
		; Add tattoo
		SlaveTats.add_tattoo(playerRef,tatRef)
		
		; Update currentlyAppliedList
		JArray.addObj(currentlyAppliedList,tatRef)
		i -= 1
	endwhile
	JArray.clear(applyQueue)
	
	i = JArray.count(removeQueue) - 1
	while i >= 0
		tatRef = JArray.getObj(removeQueue,i)
		; Remove tattoo
		SlaveTats.remove_tattoos(playerRef,tatRef)
		
		; Update currentlyAppliedList
		temp = JArray.findObj(currentlyAppliedList,tatRef)
		if temp != -1
			JArray.eraseIndex(currentlyAppliedList,temp)
		endif
		i -= 1
	endwhile
	JArray.clear(removeQueue)
	
	SlaveTats.synchronize_tattoos(playerRef,silent=True)
endfunction

function setGroupForTattoo(int tattooEntry, string groupName)
	string tattooKey = JMap.getStr(tattooEntry,"texture")
	int tattooExtraData = JMap.getObj(tattooExtraDataMap,tattooKey)
	if tattooExtraData == 0
		; No data exists for this tattoo yet, create new JMap
		; Since this object is added as a member of another JMap, we do not need
		; to call retain()
		tattooExtraData = JMap.object()
		JMap.setObj(tattooExtraDataMap,tattooKey,tattooExtraData)
	endif
	JMap.setStr(tattooExtraData,"group",groupName)
endfunction

string function getGroupForTattoo(int tattooEntry)
	string tattooKey = JMap.getStr(tattooEntry,"texture")
	int tattooExtraData = JMap.getObj(tattooExtraDataMap,tattooKey)
	if tattooExtraData == 0
		; No entry exists for this tattoo yet, use default group
		return tattooGroups[1]
	else
		string groupName = JMap.getStr(tattooExtraData,"group")
		if groupName == ""
			; No group entry exists for this tattoo yet, use default group
			groupName = tattooGroups[1]
		endif
		return groupName
	endif
endfunction

int function getIndexForGroup(string groupName)
	int i = 0
	while i < tattooGroups.length
		if tattooGroups[i] == groupName
			return i
		endif
		i += 1
	endwhile
	return -1
endfunction

; Returns retained JArray with available tattoo JMaps
int function getAvailableTattoos()
	int template = JValue.retain(JMap.object())
	int matches = JValue.retain(JArray.object(), JC_TAG)
	if SlaveTats.query_available_tattoos(template,matches)
		; Error Occurred, just log it for now
		log("Failed to retrieve available tattoos from SlaveTats")
	endif
	JValue.release(template)

	; Sorts tattoo entries alphabetically by the texture path
	; I'm sort-of assuming that no two tattoos with share the same .dds file
	;
	; Note from the future: turns out there are now tattoo packs with tattoos
	; that share the same .dds - I don't think this is a major issue - the only
	; real impact right now is that Rape Tattoos will refuse to add a tattoo
	; if one with the same texture path is already applied.
	;
	; Second note from the future: this sort is crazy slow - I'm in two minds
	; about keeping it. Might consider farming it out to a Lua script to see if
	; that speeds it up any. Personally, I'm not sure the benefit of
	; alphabetically sorting the entries is worth the waiting time for the MCM
	; to load.
	; Disable the sort for now to speed things up
	; sortJArrayByStringKey(matches,"texture")
	return matches
	
endfunction

function sortJArrayByStringKey(int dataList, string sortKey)
	_sortJArrayByStringKey(dataList,sortKey,0,JArray.count(dataList))
endfunction

; Sorts a section of the JArray using the mergesort algorithm
function _sortJArrayByStringKey(int dataList, string sortKey, int startIndex, int indexLimit)
	if indexLimit - startIndex < 2
		; Section of size <1, so automatically sorted
		return
	else
		; Note: indexLimit - startIndex >= 2
		int splitIndex = startIndex + (indexLimit - startIndex) / 2
		
		; Sort both halves recursively
		_sortJArrayByStringKey(dataList,sortKey,startIndex,splitIndex)
		_sortJArrayByStringKey(dataList,sortKey,splitIndex,indexLimit)
		
		; Merge sorted sides
		int mainIdx = startIndex
		int segOneIdx = startIndex
		int segTwoIdx = splitIndex
		while mainIdx < indexLimit && segOneIdx < splitIndex && segTwoIdx < indexLimit
			if JMap.getStr(JArray.getObj(dataList,segOneIdx),sortKey) < JMap.getStr(JArray.getObj(dataList,segTwoIdx),sortKey)
				; Use the segment one value
				segOneIdx += 1
			else
				; Use the segment two value
				_moveItemForward(dataList,segOneIdx,segTwoIdx)
				segOneIdx += 1
				segTwoIdx += 1
			endif
			mainIdx += 1
		endwhile
	endif
endfunction

; Moves item from oldIdx to lowerIdx and shuffles the items from lowerIdx to oldIdx backwards
; Ex: a b c d -> a d b c
function _moveItemForward(int dataList, int lowerIdx, int oldIdx)
	while lowerIdx < oldIdx
		JArray.swapItems(dataList,lowerIdx,oldIdx)
		lowerIdx += 1
	endwhile
endfunction

event OnPageReset(string page)
	int i
	
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	
	if page == Pages[0] || page == ""
		zazInstalled = rapeTattoos_utils.isZazInstalled()
		if zazInstalled
			Debug.Trace("[ Rape Tattoos ] Zaz Animation Pack detected - ZAP integration will be enabled.")
		endif

		; Player Settings
		playerSettingsHeaderOID = AddHeaderOption("Player Settings")
		baseChanceOID = AddSliderOption("Base Chance", baseChance, "{2}")
		chanceIncreaseOID = AddSliderOption("Chance Increase per act", chanceIncrease, "{2}")
		minTattoosOID = AddSliderOption("Minimum Tattoos added", minTattoos)
		maxTattoosOID = AddSliderOption("Maximum Tattoos added", maxTattoos)
		permanentTattoosOID = AddToggleOption("Tattoos are permanent", permanentTattoos)
        useLockedTatsOID = AddToggleOption("Tattoos are 'locked'", useLockedTats)
		tattooDurationOID = AddSliderOption("Duration 'tattoos' last in hours", tattooDurationHours, "{1}")
		AddEmptyOption()

		; NPC Settings
		npcSettingsHeaderOID = AddHeaderOption("NPC Settings")
		npcBaseChanceOID = AddSliderOption("Base Chance", npcBaseChance, "{2}")
		npcChanceIncreaseOID = AddSliderOption("Chance Increase per act", npcChanceIncrease, "{2}")
		npcMinTattoosOID = AddSliderOption("Minimum Tattoos added", npcMinTattoos)
		npcMaxTattoosOID = AddSliderOption("Maximum Tattoos added", npcMaxTattoos)
		npcPermanentTattoosOID = AddToggleOption("Tattoos are permanent", npcPermanentTattoos)
		npcUseLockedTatsOID = AddToggleOption("Tattoos are 'locked'", npcUseLockedTats)
		npcTattooDurationOID = AddSliderOption("Duration 'tattoos' last in hours", npcTattooDurationHours, "{1}")
		AddEmptyOption()

		; Zaz Settings
		zazSettingsHeaderOID = AddHeaderOption("Zaz Slave Settings")
		if zazInstalled
			zazBaseChanceOID = AddSliderOption("Base Chance", zazBaseChance, "{2}")
			zazChanceIncreaseOID = AddSliderOption("Chance Increase per act", zazChanceIncrease, "{2}")
			zazMinTattoosOID = AddSliderOption("Minimum Tattoos added", zazMinTattoos)
			zazMaxTattoosOID = AddSliderOption("Maximum Tattoos added", zazMaxTattoos)
			zazPermanentTattoosOID = AddToggleOption("Tattoos are permanent", zazPermanentTattoos)
			zazUseLockedTatsOID = AddToggleOption("Tattoos are 'locked'", zazUseLockedTats)
			zazTattooDurationOID = AddSliderOption("Duration 'tattoos' last in hours", zazTattooDurationHours, "{1}")
		else
			AddTextOption("Zaz Animation Pack is not installed", "", OPTION_FLAG_DISABLED)
		endif
		AddEmptyOption()

		SetCursorPosition(1)

		; Tattoo Configuration
		AddHeaderOption("Tattoo configuration")
		if configPagesLoaded
			openTattooConfigOID = AddTextOption("", "Tattoos loaded!", OPTION_FLAG_DISABLED)
		else
			openTattooConfigOID = AddTextOption("", "Load tattoo config pages")
		endif

		; Eligibility
		AddHeaderOption("Eligibility Options")
		allowFemaleOID = AddToggleOption("Females", allowFemale)
		allowMaleOID = AddToggleOption("Males", allowMale)
		allowNPCOID = AddToggleOption("NPCs", allowNPC)
		onlyVictimOID = AddToggleOption("Only when victim", onlyVictim)
		excludeBeastialityOID = AddToggleOption("Ignore scenes with animals", excludeBeastiality)
		AddEmptyOption()

		; Color/Glow/Gloss
		AddHeaderOption("Tattoo Properties")
		tattooColorModeOID = AddMenuOption("Tattoo Color Mode", tattooColorModes[tattooColorMode])
		if tattooColorMode == 0
			tattooColorOID = AddColorOption("Fixed Color", tattooColor)
		else
			tattooColorOID = AddColorOption("Fixed Color", tattooColor, OPTION_FLAG_DISABLED)
		endif

		tattooGlowModeOID = AddMenuOption("Tattoo Glow Mode", tattooColorModes[tattooGlowMode])
		if tattooGlowMode == 0
			tattooGlowOID = AddColorOption("Fixed Glow Color", tattooGlow)
		else
			tattooGlowOID = AddColorOption("Fixed Glow Color", tattooGlow, OPTION_FLAG_DISABLED)
		endif

		tattooGlossChanceOID = AddSliderOption("Gloss Chance", tattooGlossChance, "{0}%")
		AddEmptyOption()

		; Notifications
		AddHeaderOption("Notifications")
		enableNotificationOID = AddToggleOption("Notification upon new player tattoo",enableNotification)
        enableNPCNotificationOID = AddToggleOption("Notification upon new NPC tattoo",enableNPCNotification)
		AddEmptyOption()

		; Debug
		AddHeaderOption("Debug Options")
		debugOID = AddToggleOption("Debug Mode Enabled", debugEnabled)
		int debugFlag = OPTION_FLAG_HIDDEN
		if (debugEnabled)
			debugFlag = OPTION_FLAG_NONE
		endif
		debugTattooKeyDescriptionOID = AddTextOption("N Key - Add some tattoos", "", debugFlag)
		debugRapeKeyDescriptionOID = AddTextOption("Y Key - Simulate post-rape event", "", debugFlag)
		debugTattooCountOID = AddSliderOption("Debug Tattoo Count", debugTattooCount, "{0}", debugFlag)

		return
	elseif page == Pages[1]
		SetCursorFillMode(LEFT_TO_RIGHT) 
		AddHeaderOption("Information About Tattoo Setting Pages")
		AddEmptyOption()
		
		AddTextOption("Depending on how many tattoos you have installed,","")
		AddTextOption("you will see multiple tattoo setting pages.","")
		
		AddTextOption("Each page is identical apart from the tattoos it","")
		AddTextOption("manages.","")
		
		AddTextOption("There are 50 tattoos per page,","")
		AddTextOption("and a maximum of 126 pages","")
		
		AddTextOption("(If you have more than 6300 tattoos installed,","")
		AddTextOption("you might be out of luck.)","")
		
		AddTextOption("If no tattoos were detected you won't see any","")
		AddTextOption("tattoo setting pages","")
		
		AddEmptyOption()
		AddEmptyOption()
		
		AddTextOption("The tattoo page lets to do two things:","")
		AddEmptyOption()
		
		AddTextOption("Assign tattoos to 'groups' and manually","")
		AddTextOption("add/remove them","")
		
		AddHeaderOption("Tattoo Groups")
		AddEmptyOption()
		
		AddTextOption("Without groups, randomly adding tattoos quickly","")
		AddTextOption("results in multiple tattoos occupying the same","")
		
		AddTextOption("space and being unreadable.","")
		AddEmptyOption()
		
		AddTextOption("To prevent this problem, each tattoo has a 'group'","")
		AddTextOption("property which indicates the area of the body it","")
		
		AddTextOption("gets applied to.","")
		AddEmptyOption()
		
		AddTextOption("Only one tattoo from each group will be applied.","")
		AddEmptyOption()
		
		AddEmptyOption()
		AddEmptyOption()
		AddTextOption("There are also two special groups: '(unassigned)'","")
		AddTextOption("and '(excluded)'","")
		
		AddTextOption("'(unassigned)' is the default group and is the","")
		AddTextOption("only group that allows multiple tattoos to be","")
		
		AddTextOption("applied","")
		AddEmptyOption()
		
		AddTextOption("Tattoos from the '(excluded)' group will never","")
		AddTextOption("be picked.","")
		
		AddEmptyOption()
		AddEmptyOption()
		
		AddTextOption("I've included my personal categorization of","")
		AddTextOption("tattoos as the default value but you can change","")
		
		AddTextOption("it however you wish.","")
		AddEmptyOption()
		
		AddTextOption("The tattoo categorization date is stored","")
		AddTextOption("separately in a .json file on your hardrive in","")
		
		AddTextOption("(on windows 7)","")
		AddTextOption(".../My Games/Skyrim/JCUser/rTats/settings.json","")
		
		AddHeaderOption("Tattoo Addition/Removal")
		AddEmptyOption()
		
		AddTextOption("This is more of a general tattoo debugging thing.","")
		AddEmptyOption()
		
		AddTextOption("Click on the texture path of the tattoo to add","")
		AddTextOption("or remove the tattoo.","")
		
		AddTextOption("The Y/N beside the texture path indicate whether","")
		AddTextOption("the tattoo is currently applied","")
		return
	endif
	
	; Assumes it must be one of the tattoo setting pages
	int tatCount = JArray.count(tattooList)
	
	; Determines which tattoo page this is and by what to offset the tattoo list
	i = firstTattooPageIdx
	int tattooOffset = 0
	while i < firstTattooPageIdx + tattooPageCount
		if page == Pages[i]
			tattooOffset = (i - firstTattooPageIdx)*tattoosPerPage
		endif
		i += 1
	endwhile
	
	if tattooOffset >= tatCount
		AddTextOption("Unused Page","")
	else
		int idxLimit = tattooOffset + tattoosPerPage
		if tatCount < idxLimit
			idxLimit = tatCount
		endIf
		
		i = idxLimit - 1
		AddHeaderOption("Tattoos indexed " + tattooOffset + " to " + i)
		SetCursorFillMode(LEFT_TO_RIGHT)
		AddHeaderOption("Name & Assigned Set")
		AddHeaderOption("Texture Path")
		
		int currentTattoo = 0
		int tempOID
		bool isApplied
		i = tattooOffset
		while i < idxLimit
			currentTattoo = JArray.getObj(tattooList,i)
			
			tempOID = AddMenuOption(JMap.getStr(currentTattoo,"name"),getGroupForTattoo(currentTattoo))
			JIntMap.setInt(tattooOIDToIdxMap,tempOID,i)
			
			isApplied = menu_isTattooApplied(currentTattoo)
			if isApplied
				tempOID = AddMenuOption(JMap.getStr(currentTattoo,"texture"),"Y")
			else
				tempOID = AddMenuOption(JMap.getStr(currentTattoo,"texture"),"N")
			endif
			JIntMap.setInt(tattooTextureOIDToIdxMap,tempOID,i)
			
			i += 1
		endwhile
	endif
	
endevent

event OnOptionMenuOpen(int option)
	if option == tattooColorModeOID
		SetMenuDialogStartIndex(tattooColorMode)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(tattooColorModes)

	elseif option == tattooGlowModeOID
		SetMenuDialogStartIndex(tattooGlowMode)
		SetMenuDialogDefaultIndex(3)
		SetMenuDialogOptions(tattooColorModes)

	elseif JIntMap.hasKey(tattooTextureOIDToIdxMap,option)
		int idx = JIntMap.getInt(tattooTextureOIDToIdxMap,option)
		int tattooEntry = JArray.getObj(tattooList,idx)
		
		SetMenuDialogOptions(appliedOptions)
		if menu_isTattooApplied(tattooEntry)
			SetMenuDialogStartIndex(1)
		else
			SetMenuDialogStartIndex(0)
		endif
		
		SetMenuDialogDefaultIndex(0)
		
	elseif JIntMap.hasKey(tattooOIDToIdxMap,option)
		int idx = JIntMap.getInt(tattooOIDToIdxMap,option)
		int tattooEntry = JArray.getObj(tattooList,idx)
		int currentGroupIndex = getIndexForGroup(getGroupForTattoo(tattooEntry))
		
		SetMenuDialogOptions(tattooGroups)
		SetMenuDialogStartIndex(currentGroupIndex)
		SetMenuDialogDefaultIndex(0)
	endif
endevent

event OnOptionMenuAccept(int option, int index)
	if option == tattooColorModeOID
		if tattooColorMode != index
			tattooColorMode = index
			SetMenuOptionValue(option, tattooColorModes[index])
		endif
		; Enable/Disable the fixed color option
		if tattooColorMode == 0
			SetOptionFlags(tattooColorOID, OPTION_FLAG_NONE)
		else
			SetOptionFlags(tattooColorOID, OPTION_FLAG_DISABLED)
		endif

	elseif option == tattooGlowModeOID
		if tattooGlowMode != index
			tattooGlowMode = index
			SetMenuOptionValue(option, tattooColorModes[index])
			ForcePageReset()
		endif
		; Enable/Disable the fixed glow option
		if tattooGlowMode == 0
			SetOptionFlags(tattooGlowOID, OPTION_FLAG_NONE)
		else
			SetOptionFlags(tattooGlowOID, OPTION_FLAG_DISABLED)
		endif

	elseif JIntMap.hasKey(tattooTextureOIDToIdxMap,option)
		int idx = JIntMap.getInt(tattooTextureOIDToIdxMap,option)
		int tattooEntry = JArray.getObj(tattooList,idx)
		
		bool isApplied = menu_isTattooApplied(tattooEntry)
		
		if index == 1 && !isApplied
			menu_applyTattoo(tattooEntry)
			SetMenuOptionValue(option,"Y")
		elseif index == 0 && isApplied
			menu_removeTattoo(tattooEntry)
			SetMenuOptionValue(option,"N")
		endif
		
	elseif JIntMap.hasKey(tattooOIDToIdxMap,option)
		int idx = JIntMap.getInt(tattooOIDToIdxMap,option)
		int tattooEntry = JArray.getObj(tattooList,idx)
		
		setGroupForTattoo(tattooEntry,tattooGroups[index])
		SetMenuOptionValue(option,tattooGroups[index])
	endif
endevent

event OnOptionSliderOpen(int option)
	; Player Settings
	if option == baseChanceOID ; Player base chance
		SetSliderDialogStartValue(baseChance)
		SetSliderDialogDefaultValue(0.10)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	elseIf option == chanceIncreaseOID ; Player chance increase
		SetSliderDialogStartValue(chanceIncrease)
		SetSliderDialogDefaultValue(0.07)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	elseif option == minTattoosOID ; Player min tattoos
		SetSliderDialogStartValue(minTattoos)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(1, 5)
		SetSliderDialogInterval(1)
	elseif option == maxTattoosOID; Player max tattoos
		SetSliderDialogStartValue(maxTattoos)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(1, 5)
		SetSliderDialogInterval(1)
	elseif option == tattooDurationOID ; Player tattoo duration
		SetSliderDialogStartValue(tattooDurationHours)
		SetSliderDialogDefaultValue(168.0)
		SetSliderDialogRange(0.5, 8760.0)
		SetSliderDialogInterval(0.5)

	; NPC Settings
	elseif option == npcBaseChanceOID ; NPC base chance
		SetSliderDialogStartValue(npcBaseChance)
		SetSliderDialogDefaultValue(0.20)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	elseif option == npcChanceIncreaseOID ; NPC chance increase
		SetSliderDialogStartValue(npcChanceIncrease)
		SetSliderDialogDefaultValue(0.10)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	elseif option == npcMinTattoosOID ; NPC min tattoos
		SetSliderDialogStartValue(npcMinTattoos)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(1, 5)
		SetSliderDialogInterval(1)
	elseif option == npcMaxTattoosOID ; NPC max tattoos
		SetSliderDialogStartValue(npcMaxTattoos)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(1, 5)
		SetSliderDialogInterval(1)
	elseif option == npcTattooDurationOID ; NPC tattoo duration
		SetSliderDialogStartValue(npcTattooDurationHours)
		SetSliderDialogDefaultValue(336.0)
		SetSliderDialogRange(0.5, 8760.0)
		SetSliderDialogInterval(0.5)

	; Zaz Settings
	elseif option == zazBaseChanceOID ; Zaz base chance
		SetSliderDialogStartValue(zazBaseChance)
		SetSliderDialogDefaultValue(0.50)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	elseif option == zazChanceIncreaseOID ; Zaz chance increase
		SetSliderDialogStartValue(zazChanceIncrease)
		SetSliderDialogDefaultValue(0.10)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	elseif option == zazMinTattoosOID ; Zaz min tattoos
		SetSliderDialogStartValue(zazMinTattoos)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(1, 5)
		SetSliderDialogInterval(1)
	elseif option == zazMaxTattoosOID ; Zaz max tattoos
		SetSliderDialogStartValue(zazMaxTattoos)
		SetSliderDialogDefaultValue(2)
		SetSliderDialogRange(1, 5)
		SetSliderDialogInterval(1)
	elseif option == zazTattooDurationOID ; Zaz tattoo duration
		SetSliderDialogStartValue(zazTattooDurationHours)
		SetSliderDialogDefaultValue(672.0)
		SetSliderDialogRange(0.5, 8760.0)
		SetSliderDialogInterval(0.5)

	; Everything else
	elseif option == tattooGlossChanceOID ; Gloss chance
		SetSliderDialogStartValue(tattooGlossChance)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif option == debugTattooCountOID ; Debug tattoo count
		SetSliderDialogStartValue(debugTattooCount)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(1, 20)
		SetSliderDialogInterval(1)
	endif
endEvent

event OnOptionSliderAccept(int option, float value)
	; Player Settings
	if option == baseChanceOID ; Player base chance
		baseChance = value
		SetSliderOptionValue(baseChanceOID, baseChance, "{2}")
	elseIf option == chanceIncreaseOID ; Player chance increase
		chanceIncrease = value
		SetSliderOptionValue(chanceIncreaseOID, chanceIncrease, "{2}")
	elseif option == minTattoosOID ; Player min tattoos
		minTattoos = value as int
		SetSliderOptionValue(minTattoosOID, minTattoos)
		if minTattoos > maxTattoos ; Don't permit min to be higher than max
			maxTattoos = minTattoos
			SetSliderOptionValue(maxTattoosOID, maxTattoos)
		endif
	elseif option == maxTattoosOID ; Player max tattoos
		maxTattoos = value as int
		SetSliderOptionValue(maxTattoosOID, maxTattoos)
		if maxTattoos < minTattoos ; Don't permit max to be lower than min
			minTattoos = maxTattoos
			SetSliderOptionValue(minTattoosOID, minTattoos)
		endif
	elseIf option == tattooDurationOID ; Player tattoo duration
		tattooDurationHours = value
		SetSliderOptionValue(tattooDurationOID, tattooDurationHours, "{1}")

	; NPC Settings
	elseif option == npcBaseChanceOID ; NPC base chance
		npcBaseChance = value
		SetSliderOptionValue(npcBaseChanceOID, npcBaseChance, "{2}")
	elseif option == npcChanceIncreaseOID ; NPC chance increase
		npcChanceIncrease = value
		SetSliderOptionValue(npcChanceIncreaseOID, npcChanceIncrease, "{2}")
	elseif option == npcMinTattoosOID ; NPC min tattoos
		npcMinTattoos = value as int
		SetSliderOptionValue(npcMinTattoosOID, npcMinTattoos)
		if npcMinTattoos > npcMaxTattoos ; Don't permit min to be higher than max
			npcMaxTattoos = npcMinTattoos
			SetSliderOptionValue(npcMaxTattoosOID, npcMaxTattoos)
		endif
	elseif option == npcMaxTattoosOID ; NPC max tattoos
		npcMaxTattoos = value as int
		SetSliderOptionValue(npcMaxTattoosOID, npcMaxTattoos)
		if npcMaxTattoos < npcMinTattoos ; Don't permit max to be lower than min
			npcMinTattoos = npcMaxTattoos
			SetSliderOptionValue(npcMinTattoosOID, npcMinTattoos)
		endif
	elseif option == npcTattooDurationOID ; NPC tattoo duration
		npcTattooDurationHours = value
		SetSliderOptionValue(npcTattooDurationOID, npcTattooDurationHours)

	; Zaz Settings
	elseif option == zazBaseChanceOID ; Zaz base chance
		zazBaseChance = value
		SetSliderOptionValue(zazBaseChanceOID, zazBaseChance, "{2}")
	elseif option == zazChanceIncreaseOID ; Zaz chance increase
		zazChanceIncrease = value
		SetSliderOptionValue(zazChanceIncreaseOID, zazChanceIncrease, "{2}")
	elseif option == zazMinTattoosOID ; Zaz min tattoos
		zazMinTattoos = value as int
		SetSliderOptionValue(zazMinTattoosOID, zazMinTattoos)
		if zazMinTattoos > zazMaxTattoos ; Don't permit min to be higher than max
			zazMaxTattoos = zazMinTattoos
			SetSliderOptionValue(zazMaxTattoosOID, zazMaxTattoos)
		endif
	elseif option == zazMaxTattoosOID ; Zaz max tattoos
		zazMaxTattoos = value as int
		SetSliderOptionValue(zazMaxTattoosOID, zazMaxTattoos)
		if zazMaxTattoos < zazMinTattoos ; Don't permit max to be lower than min
			zazMinTattoos = zazMaxTattoos
			SetSliderOptionValue(zazMinTattoosOID, zazMinTattoos)
		endif
	elseif option == zazTattooDurationOID ; Zaz tattoo duration
		zazTattooDurationHours = value
		SetSliderOptionValue(zazTattooDurationOID, zazTattooDurationHours)

	; Everything else
	elseif option == tattooGlossChanceOID
		tattooGlossChance = value
		SetSliderOptionValue(tattooGlossChanceOID, tattooGlossChance, "{0}%")
	elseif option == debugTattooCountOID
		debugTattooCount = value as int
		SetSliderOptionValue(debugTattooCountOID, debugTattooCount)
	endIf
endEvent

event OnOptionSelect(int option)
	; Player Settings
	if option == permanentTattoosOID ; Permanent
		permanentTattoos = !permanentTattoos
		SetToggleOptionValue(permanentTattoosOID, permanentTattoos)
	elseif option == useLockedTatsOID ; Locked
		useLockedTats = !useLockedTats
		SetToggleOptionValue(useLockedTatsOID, useLockedTats)

	; NPC Settings
	elseif option == npcPermanentTattoosOID ; Permanent
		npcPermanentTattoos = !npcPermanentTattoos
		SetToggleOptionValue(npcPermanentTattoosOID, npcPermanentTattoos)
	elseif option == npcUseLockedTatsOID ; Locked
		npcUseLockedTats = !npcUseLockedTats
		SetToggleOptionValue(npcUseLockedTatsOID, npcUseLockedTats)

	; Zaz Settings
	elseif option == zazPermanentTattoosOID ; Permanent
		zazPermanentTattoos = !zazPermanentTattoos
		SetToggleOptionValue(zazPermanentTattoosOID, zazPermanentTattoos)
	elseif option == zazUseLockedTatsOID ; Locked
		zazUseLockedTats = !zazUseLockedTats
		SetToggleOptionValue(zazUseLockedTatsOID, zazUseLockedTats)

	; Locked tattoos
	elseif option == useLockedTatsOID
		useLockedTats = !useLockedTats
		SetToggleOptionValue(useLockedTatsOID,useLockedTats)

	; Eligibility
	elseif option == allowFemaleOID ; Female
		allowFemale = !allowFemale
		SetToggleOptionValue(allowFemaleOID,allowFemale)
    elseif option == allowMaleOID ; Male
		allowMale = !allowMale
		SetToggleOptionValue(allowMaleOID,allowMale)
    elseif option == allowNPCOID ; NPC
		allowNPC = !allowNPC
		SetToggleOptionValue(allowNPCOID,allowNPC)
    elseif option == onlyVictimOID ; Victim only
		onlyVictim = !onlyVictim
		SetToggleOptionValue(onlyVictimOID,onlyVictim)
    elseif option == excludeBeastialityOID ; Exclude bestiality
		excludeBeastiality = !excludeBeastiality
		SetToggleOptionValue(excludeBeastialityOID,excludeBeastiality)

	; Tattoo Configuration
	elseif option == openTattooConfigOID
		loadTattooConfigPages()

	; Notifications
	elseif option == enableNotificationOID ; Player
		enableNotification = !enableNotification
		SetToggleOptionValue(enableNotificationOID,enableNotification)
    elseif option == enableNPCNotificationOID ; NPC
		enableNPCNotification = !enableNPCNotification
		SetToggleOptionValue(enableNPCNotificationOID,enableNPCNotification)

	; Debug
	elseif option == debugOID
		debugEnabled = !debugEnabled
		SetToggleOptionValue(debugOID,debugEnabled)
		; Hide/show the debug options
		int debugFlag = OPTION_FLAG_HIDDEN
		if debugEnabled
			debugFlag = OPTION_FLAG_NONE
		endif
		SetOptionFlags(debugTattooCountOID, debugFlag)
		SetOptionFlags(debugTattooKeyDescriptionOID, debugFlag)
		SetOptionFlags(debugRapeKeyDescriptionOID, debugFlag)
	endif
endEvent

event OnOptionColorAccept(int option, int color)
	if option == tattooColorOID
		tattooColor = color
	elseif option == tattooGlowOID
		tattooGlow = color
	endif
	SetColorOptionValue(option,color)
endEvent

event OnOptionHighlight(int option)
	; Player/NPC/Zaz Settings
	if playerSettingsHeaderOID == option
		SetInfoText(\
			"Settings for tattoos which should be applied to the you.\n" +\
			"WARNING: If Zaz Animation Pack is installed and the you get added to the Zaz slave faction, then the Zaz settings below will override the settings you choose here."\
		)
	elseif npcSettingsHeaderOID == option
		SetInfoText(\
			"Settings for tattoos which should be applied to NPCs.\n" +\
			"If Zaz Animation Pack is installed, then the Zaz settings below will instead be used for NPCs in the Zaz slave faction."\
		)
	elseif zazSettingsHeaderOID == option
		SetInfoText("If you have Zaz Animation Pack installed, then these settings will be applied to anyone (even you) in the Zaz slave faction.")
	elseif baseChanceOID == option || npcBaseChanceOID == option || zazBaseChanceOID == option
		SetInfoText("Base Chance that an aggressive sex act will trigger a tattoo")
	elseif chanceIncreaseOID == option || npcChanceIncreaseOID == option || zazChanceIncreaseOID == option
		SetInfoText("For each tattoo trigger that is missed, the chance to receive a tattoo increased by this amount. If you want true randomness, set this to 0.")
	elseif minTattoosOID == option || npcMinTattoosOID == option || zazMinTattoosOID == option
		SetInfoText("The minimum number of tattoos that will be added by a sex act. Note that this will not affect tattoos triggered by other mods.")
	elseif maxTattoosOID == option || npcMaxTattoosOID == option || zazMaxTattoosOID == option
		SetInfoText("The maximum number of tattoos that can be added by a sex act. Note that this will not affect tattoos triggered by other mods.")
	elseif permanentTattoosOID == option || npcPermanentTattoosOID == option || zazPermanentTattoosOID == option
		SetInfoText("Tattoos that get applied won't disappear on their own.")
	elseif tattooDurationOID == option || npcTattooDurationOID == option || zazTattooDurationOID == option
		SetInfoText("Duration that tattoo will remain (in game hours.) If permanent tattoos are enabled this option has no effect.")
	elseif useLockedTatsOID == option || npcUseLockedTatsOID == option || zazUseLockedTatsOID == option
		SetInfoText("If true, tattoos aren't removeable through this menu, nor the SlaveTats one. However if the tattoo is non-permenant it will still fade and expire on it's own.")

	; Eligibility
    elseif allowFemaleOID == option
		SetInfoText("Female characters can be tattooed")
    elseif allowMaleOID == option
		SetInfoText("Male characters can be tattooed")
    elseif allowNPCOID == option
		SetInfoText("NPCs can be tattooed")
    elseif onlyVictimOID == option
		SetInfoText("Only victims (of a non-consenual sex act) may be tattooed")
    elseif excludeBeastialityOID == option
		SetInfoText("If true, scenes involving animals are ignored. Animals won't receive tattooes either way.")

	; Tattoo Configuration
	elseif openTattooConfigOID == option
		SetInfoText(\
			"If you're a first-time user, or need to assign groups to your installed tattoos, click here to load the configuration pages for them. " +\
			"Please be patient - this can take a while if you have a lot of tattoos installed. " +\
			"Once you have configured your tattoo groups, the data is stored in your user directory, and will persist across saves. " +\
			"If you already have a configuration file set up in your user directory, you won't need to configure your tattoos again unless you add new packs. " +\
			"See the mod documentation for full details."\
		)

	; Color, glow & gloss
	elseif tattooColorModeOID == option
		if tattooColorMode == 0
			SetInfoText("All tattoos added by this mod will have the color you pick below. The classic Rape Tattoos behaviour.")
		elseif tattooColorMode == 1
			SetInfoText("Each tattoo added by this mod will be given a commpletely random color - you'll probably end up looking like an art experiment gone wrong.")
		elseif tattooColorMode == 2
			SetInfoText("Each tattoo will be given a random color from a weighted color set configured by you (or one of the custom configurations provided with the mod). See the mod documentation for details.")
		elseif tattooColorMode == 3
			SetInfoText("Tattoo colors will not be overriden - tattoos will always use their default color (usually black).")
		endif
	elseif tattooColorOID == option
		SetInfoText("In fixed color mode, this color will be applied to every tattoo added by the mod.")

	elseif tattooGlowModeOID == option
		if tattooColorMode == 0
			SetInfoText("All tattoos added by this mod will have the glow color you pick below. Lighter glow colors will have more impact on the final appearance of the tattoo.")
		elseif tattooColorMode == 1
			SetInfoText("Each tattoos added by this mod will be given a commpletely random glow color.")
		elseif tattooColorMode == 2
			SetInfoText("Each tattoo will be given a random glow color from a weighted color set configured by you (or one of the custom configurations provided with the mod). See the mod documentation for details.")
		elseif tattooColorMode == 3
			SetInfoText("Tattoo glow colors will not be overriden - tattoos will always use their default glow color.")
		endif
	elseif tattooGlowOID == option
		SetInfoText("In fixed glow mode, this glow color will be applied to every tattoo added by the mode.")

	elseif enableNotificationOID == option
		SetInfoText("If disabled, you won't receive a notification when a tattoo has been applied. For people who like surprises.")
	elseif enableNPCNotificationOID == option
		SetInfoText("Whether to display a message when an NPC gets tattooed")

	; Debug
	elseif debugOID == option
		SetInfoText("Enables debugging options. This is only intended for testing/debugging purposes - it WILL spam your notification feed if you leave it on!")
	elseif debugTattooKeyDescriptionOID == option && debugEnabled
		SetInfoText("Pressing the 'N' key will add random tattoos to the actor currently under the crosshairs or yourself if you're not looking at anyone. You can configure the number of tattoos to be added below.")
	elseif debugRapeKeyDescriptionOID == option && debugEnabled
		SetInfoText("Pressing the 'Y' key will simulate a post-rape tattoo event on the actor currently under the crosshairs or yourself if you're not looking at anyone. This includes the random roll, so does not guarantee that any tattoos will be added.")
	elseif debugTattooCountOID == option && debugEnabled
		SetInfoText("How many tattoos should be added when you press the 'N' key. Be warned - adding lots of tattoos can be a little slow if you have a lot of SlaveTats packs installed!")
	endif
endEvent

function log(string msg)
	msg = "[ Rape Tattoos ] " + msg
	Debug.Trace(msg)
endfunction