scriptname fadeTattoos_mcm extends SKI_ConfigBase

int function GetVersion()
    return 2
endfunction

; OIDs
int alphaDropOffModeOID

; 0 = 100% alpha until removed
; 1 = Linear decrease
; 2 = Quadratic dropoff using formula (75% reduction by halfway mark)
int property alphaDropOffMode = 2 auto hidden

string[] tattooFadeModes

; Value initially used when a tattoo is manually added to be tracked
float defaultTattooDuration = 300.0 
; Maximum tattoo duration that can be inputted via the menu's slider
float maxDurationInput = 2400.0

int OIDToTextureMap
int OIDToActionMap
int OIDToValueMap

bool verboseMessages

event OnVersionUpdate(int newVersion)
    OnConfigInit()
    Debug.Notification("[ Fade Tattoos ] Version update complete")
endevent

event OnConfigInit()
    Pages = new string[3]
	Pages[0] = "General"
	Pages[1] = "Currently Tracked Tattoos"
	Pages[2] = "PC Tattoo Manager"
	
	tattooFadeModes = new string[3]
	tattooFadeModes[0] = "NO FADE"
	tattooFadeModes[1] = "LINEAR"
	tattooFadeModes[2] = "LINGERING"
endEvent

event OnConfigOpen()
	OIDToTextureMap = JValue.retain(JIntMap.object())
	OIDToActionMap = JValue.retain(JIntMap.object())
	OIDToValueMap = JValue.retain(JIntMap.object())
endEvent

event OnConfigClose()
	JValue.release(OIDToTextureMap)
	JValue.release(OIDToActionMap)
	JValue.release(OIDToValueMap)
endEvent

function listTatsForTarget(Actor target, int appliedMap)
    float tattooAge
    float tattooDuration
    float tattooAlpha
    string texturePath
    int tattooEntry
    int dataMap
    int i
    string actorName
    
    actorName = target.GetActorBase().GetName()
    AddTextOption("--- " + actorName + " ---","")
    AddEmptyOption()
    
    ; Get list of currently applied tattoos
    int template = JValue.retain(JMap.object())
    int appliedTattoos = JValue.retain(JArray.object())
    if SlaveTats.query_applied_tattoos(target, template, appliedTattoos)
        ; Error Occurred, return silently for now
        JValue.release(template)
        JValue.release(appliedTattoos)
        return
    endif
    JValue.release(template)
    
    ; Filter out tattoos that weren't added by this mod, and check for tattoo
    ; that might have gotten removed through external means
    fadeTattoos.appliedMapFilterAndUpdate(appliedMap, appliedTattoos)
    
    i = JArray.count(appliedTattoos) - 1
    while i >= 0
        tattooEntry = JArray.getObj(appliedTattoos,i)
        texturePath = JMap.getStr(tattooEntry,"texture")
		dataMap = JMap.getObj(appliedMap,texturePath)
        
        ; Duration property is in hours while tattooAge is in days, so we need to convert the age
        tattooAge = (Utility.GetCurrentGameTime() - JMap.getFlt(dataMap,"appliedAt"))*24.0
        tattooDuration = JMap.getFlt(dataMap,"duration")
        
        AddTextOption(JMap.getStr(tattooEntry,"texture"),"")
        AddEmptyOption()
        AddTextOption("Age: " + tattooAge + " h","")
        AddTextOption("Duration: " + tattooDuration + " h","")
        
        i -= 1
    endwhile
    
    JValue.release(appliedTattoos)
endfunction

function addMenuItem(string texturePath, string actionType, float value, int oId)
    JIntMap.setStr(OIDToTextureMap,oId,texturePath)
    JIntMap.setStr(OIDToActionMap,oId,actionType)
    JIntMap.setFlt(OIDToValueMap,oId,value)
endfunction

function playerTattooMenu()
    Actor playerRef = Game.GetPlayer()
    
    int appliedMap = JFormDB.getObj(playerRef, ".fTatsForm.appliedMap")
    if appliedMap == 0
        appliedMap = JMap.object()
        JFormDB.setObj(playerRef, ".fTatsForm.appliedMap", appliedMap)
    endif
    
    ; Get list of currently applied tattoos
    int template = JValue.retain(JMap.object())
    int appliedTattoos = JValue.retain(JArray.object())
    if SlaveTats.query_applied_tattoos(playerRef, template, appliedTattoos)
        ; Error Occurred, return silently for now
        JValue.release(template)
        JValue.release(appliedTattoos)
        return
    endif
    JValue.release(template)
    
    float tattooAge
    float tattooDuration
    float tattooAlpha
    string texturePath
    int tattooEntry
    int dataMap
    int i
    int optionFlag
    bool isTracked
    float tmp
    i = JArray.count(appliedTattoos) - 1
    while i >= 0
        tattooEntry = JArray.getObj(appliedTattoos,i)
        texturePath = JMap.getStr(tattooEntry,"texture")
        AddTextOption(JMap.getStr(tattooEntry,"texture"),"")

        if JMap.getInt(tattooEntry, "locked") > 0
            optionFlag = OPTION_FLAG_DISABLED
        else
            optionFlag = OPTION_FLAG_NONE
        endif
        
		dataMap = JMap.getObj(appliedMap,texturePath)
        isTracked = (dataMap != 0)
        if isTracked
            tmp = 1.0
        else
            tmp = 0.0
        endif
        addMenuItem(texturePath, "tracked", tmp,\
            AddToggleOption("Tracked", isTracked, optionFlag)\
        )
        
        if isTracked
            ; Duration property is in hours while tattooAge is in days, so we need to convert the age
            tattooAge = (Utility.GetCurrentGameTime() - JMap.getFlt(dataMap,"appliedAt"))*24.0
            tattooDuration = JMap.getFlt(dataMap,"duration")
            
            addMenuItem(texturePath, "age", tattooAge,\
                AddSliderOption("Age: ", tattooAge, "{0} h", optionFlag)\
            )
            addMenuItem(texturePath, "duration", tattooDuration,\
                AddSliderOption("Duration: ", tattooDuration, "{0} h", optionFlag)\
            )
        else
            AddEmptyOption()
            AddEmptyOption()
        endif
        
        i -= 1
    endwhile
    
    AddTextOption("(Wait 2 hours after making changes","")
    AddEmptyOption()
    AddTextOption("    to force an update)","")
    
    JValue.release(appliedTattoos)
endfunction

function printMsg(string msg)
    if verboseMessages
        Debug.trace("[FadeTattoosMCM] " + msg)
    endif
endfunction

int function getDataMapFor(Actor target, string texturePath)
    int appliedMap = JFormDB.getObj(target, ".fTatsForm.appliedMap")
    if appliedMap == 0
        return 0
    endif
    return JMap.getObj(appliedMap,texturePath)
endfunction

event OnPageReset(string page)
    printMsg("Page reset")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	
	if page == "" || page == Pages[0]
		alphaDropOffModeOID = AddMenuOption("Tattoo Fade Mode",tattooFadeModes[alphaDropOffMode])
	elseif page == Pages[1]
		AddHeaderOption("Currently Tracked Tattoos")
		
		SetCursorFillMode(LEFT_TO_RIGHT)
		
        int trackedArr = fadeTattoos.getRetainedTrackedArr()
        int appliedMap
        int i
        Actor target
        
        i = JArray.count(trackedArr) - 1
        while i >= 0 
            target = JArray.getForm(trackedArr,i) as Actor
            
            appliedMap = JFormDB.getObj(target, ".fTatsForm.appliedMap")
            
            if appliedMap != 0
                listTatsForTarget(target,appliedMap)
            endif
            
            i -= 1
        endwhile
        
        JValue.release(trackedArr)
    elseif page == Pages[2]
        AddHeaderOption("PC Tattoo Manager")
		
		SetCursorFillMode(LEFT_TO_RIGHT)
        
        playerTattooMenu()
	endif
endevent

event OnOptionMenuOpen(int option)
    printMsg("OnOptionMenuOpen")
	if option == alphaDropOffModeOID
		SetMenuDialogOptions(tattooFadeModes)
		SetMenuDialogStartIndex(alphaDropOffMode)
		SetMenuDialogDefaultIndex(2)
	endif
endevent

event OnOptionMenuAccept(int option, int index)
    printMsg("OnOptionMenuAccept")
	if option == alphaDropOffModeOID
		alphaDropOffMode = index
		SetMenuOptionValue(option,tattooFadeModes[index])
	endif
endevent

event OnOptionHighlight(int option)
	if alphaDropOffModeOID == option
		SetInfoText("NO FADE - Tattoos are 100% visible until they disappear, LINEAR - Tattoos linearly fade until they are gone, LINGERING - Tattoos initially fade quickly but then linger. Tattoos hit 25% visibility halfway through their life-cycle. When using this option I'd recommend a longer tattooDuration")
	endif
endEvent

event OnOptionSliderOpen(int option)
    printMsg("OnOptionSliderOpen")
    
    if JIntMap.hasKey(OIDToTextureMap,option)
        printMsg("Has key")
        string texture = JIntMap.getStr(OIDToTextureMap,option)
        string actType = JIntMap.getStr(OIDToActionMap,option)
        float  value   = JIntMap.getFlt(OIDToValueMap,option)
        
        printMsg(texture)
        printMsg(actType)
        printMsg("value=" + actType)
        
        if actType == "age"
            int dataMap = getDataMapFor(Game.GetPlayer(),texture)
            if dataMap == 0
                return
            endif
            float duration = JMap.getFlt(dataMap,"duration")
            if value > duration
                value = duration
            endif
            
            SetSliderDialogStartValue(value)
            SetSliderDialogDefaultValue(0)
            SetSliderDialogRange(0.0,duration)
            SetSliderDialogInterval(1)
        elseif actType == "duration"
            SetSliderDialogStartValue(value)
            SetSliderDialogDefaultValue(defaultTattooDuration)
            SetSliderDialogRange(0.0,maxDurationInput)
            SetSliderDialogInterval(1)
        endif
    endif
endEvent

event OnOptionSliderAccept(int option, float value)
    printMsg("OnOptionSliderAccept")
    if JIntMap.hasKey(OIDToTextureMap,option)
        printMsg("Has key")
        string texture = JIntMap.getStr(OIDToTextureMap,option)
        string actType = JIntMap.getStr(OIDToActionMap,option)
        
        printMsg(texture)
        printMsg(actType)
        
        int dataMap = getDataMapFor(Game.GetPlayer(),texture)
        if dataMap == 0
            return
        endif
        
        ; Format Notes:
        ;   Tattoos store duration & appliedAt
        ;       appliedAt is in days
        ;       duration is in hours
        ;   
        ;   For menu purposes, the player sees duration & *age*
        ;   where age = (CurrentTime - appliedAt)*24.0
        ; 
        ;   When shown to the player, both duration & age are in hours
        if actType == "age"
            ; appliedAt = CurrentTime - Age
            float newAppliedAt = Utility.GetCurrentGameTime() - value/24.0
            JMap.setFlt(dataMap,"appliedAt",newAppliedAt)
            
            SetSliderOptionValue(option, value)
        elseif actType == "duration"
            JMap.setFlt(dataMap,"duration",value)
            
            SetSliderOptionValue(option, value)
        endif
    endif
endEvent

event OnOptionSelect(int option)
    printMsg("OnOptionSelect")
    if JIntMap.hasKey(OIDToTextureMap,option)
        printMsg("Has key")
        string texture = JIntMap.getStr(OIDToTextureMap,option)
        string actType = JIntMap.getStr(OIDToActionMap,option)
        float  value   = JIntMap.getFlt(OIDToValueMap,option)
        
        printMsg(texture)
        printMsg(actType)
        
        if actType == "tracked"
            bool bValue = (value == 1.0)
            
            if bValue
                ; Tattoo is being un-tracked
                fadeTattoos.stopTattooFadeFor(Game.GetPlayer(),texture)
            else
                ; Tattoo is being added to tracking
                fadeTattoos.doAlphaFadeForTarget(Game.GetPlayer(),texture,defaultTattooDuration)
            endif
            
            ; Don't need to update the elements manually since the whole page
            ; is being reset (to update the age & duration elements)
            ForcePageReset()
        endif
    endif
endEvent