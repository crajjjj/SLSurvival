ScriptName fadeTattoos extends Quest
{Script for applying and the gradually fading out a tattoo.
SlaveTats handles the actual tattoo application and whatnot}

Actor property PlayerRef auto
fadeTattoos_mcm property menuForm auto

float updateEvery = 2.0

bool verboseMessages = False

Event OnInit()
	Debug.Notification("FadeTattoos Loaded")
	
    doEveryGameLoad()
EndEvent

function doEveryGameLoad()
    printMsg("doEveryGameLoad")
	RegisterForSingleUpdateGameTime(0.5)
endfunction

int function getRetainedTrackedArr() global
    int trackedArray = JDB.solveObj(".fTats.trackedTargets")
    if trackedArray == 0
        trackedArray = JArray.object()
        JDB.solveObjSetter(".fTats.trackedTargets",trackedArray, True)
    endif
    return JValue.retain(trackedArray)
endfunction

function startTrackingFor(Actor target) global
    int trackedArray = getRetainedTrackedArr()
    if JArray.findForm(trackedArray,target) == -1
        JArray.addForm(trackedArray,target)
    endif
    JValue.release(trackedArray)
    
endfunction

function endTrackingFor(Actor target) global
    int trackedArray = getRetainedTrackedArr()
    int idx = JArray.findForm(trackedArray,target)
    if idx > -1
        JArray.eraseIndex(trackedArray,idx)
    endif
    JValue.release(trackedArray)
endfunction


function simple_doAlphaFadeFor(string section, string name, float fadeDuration, float startAt = 0.0) global
    simple_doAlphaFadeForTarget(Game.GetPlayer(),section,name,fadeDuration,startAt)
Endfunction

; Wrapper for doAlphaFadeFor that lets you identify the tattoo by it's 'section'
; and 'name' instead (like SlaveTats.simple_add_tattoo)
; Internally this will just run some additional code to determine the tattoo's
; texture path before calling doAlphaFadeFor
function simple_doAlphaFadeForTarget(Actor target, string section, string name, float fadeDuration, float startAt = 0.0) global
	int template = JValue.retain(JMap.object())
    int matches = JValue.retain(JArray.object())
    int tattoo = 0

    JMap.setStr(template, "section", section)
    JMap.setStr(template, "name", name)

    if SlaveTats.query_available_tattoos(template, matches)
		; Error trying to get tattoo
		JValue.release(template)
		JValue.release(matches)
        return
    endif
    
    tattoo = JArray.getObj(matches, 0)
	string texturePath = JMap.getStr(tattoo,"texture")
	JValue.release(template)
	JValue.release(matches)
	
	if texturePath == ""
		; No matching tattoo could be found or texture was not defined for some other reason
		return
	endif
	
	doAlphaFadeForTarget(target,texturePath,fadeDuration,startAt)
endfunction

function doAlphaFadeFor(string tattooTexturePath, float fadeDuration, float startAt = 0.0) global
    doAlphaFadeForTarget(Game.GetPlayer(), tattooTexturePath, fadeDuration, startAt)
endfunction

; Performs a fade out effect for the tattoo with the specified texture
; float fadeDuration - Hours that fadeout effect takes
; float startAt - Hours tattoo has already been present. Default 0
function doAlphaFadeForTarget(Actor target, string tattooTexturePath, float fadeDuration, float startAt = 0.0) global
    int applied = JFormDB.getObj(target, ".fTatsForm.appliedMap")
    if applied == 0
        applied = JValue.addToPool(JMap.object(), "FadeTats-doAlphaFadeFor")
        JFormDB.setObj(target, ".fTatsForm.appliedMap", applied)
    endif
    ; Add target to the list of actors that needs to be updated
    ; if it is not already being tracked
    startTrackingFor(target)
    
    int dMap = JMap.getObj(applied,tattooTexturePath)
    if dMap == 0
        dMap = JValue.addToPool(JMap.object(), "FadeTats-doAlphaFadeFor")
        JMap.setObj(applied, tattooTexturePath, dMap)
    endif
    
    JMap.setFlt(dMap, "appliedAt", Utility.GetCurrentGameTime() - startAt/24.0)
	JMap.setFlt(dMap, "duration", fadeDuration)
    
    JValue.cleanPool("FadeTats-doAlphaFadeFor")
endfunction

; Returns true if slave-tats needs to be resyncronized
function updateForTarget(Actor target, int appliedMap)
    printMsg("Update for target: " + target)
    bool needUpdate = False
	float tattooAge
	float tattooDuration
	float tattooAlpha
	int tattooEntry
    string texturePath
	int dataMap
	int i
    
	; Get list of currently applied tattoos
	int template = JValue.retain(JMap.object())
	int appliedTattoos = JValue.retain(JArray.object())
	if SlaveTats.query_applied_tattoos(target, template, appliedTattoos)
		; Error Occurred, silentely quit for now
        JValue.release(appliedTattoos)
        JValue.release(template)
        printMsg("Error occured gettting applied tattoos")
        return
	endif
	JValue.release(template)
	
	; Filter out tattoos that weren't added by this mod, and check for tattoo
	; that might have gotten removed through external means
	appliedMapFilterAndUpdate(appliedMap, appliedTattoos)
	
    printMsg("Filtering done")
    
	i = JArray.count(appliedTattoos) - 1
    if i == -1
        printMsg("No tracked tattoos, remove from tracking")
        ; Actor has no tracked tattoos and should be removed from the tracking
        ; list
        endTrackingFor(target)
    else
        while i >= 0 
            printMsg("Tattoo Index: " + i)
            tattooEntry = JArray.getObj(appliedTattoos,i)
            texturePath = JMap.getStr(tattooEntry,"texture")
            dataMap = JMap.getObj(appliedMap,texturePath)
            tattooAge = Utility.GetCurrentGameTime() - JMap.getFlt(dataMap,"appliedAt")
            ; Duration property is in hours while tattooAge is in days, so we need to convert the duration
            tattooDuration = JMap.getFlt(dataMap,"duration")/24.0
            
            ;Debug.Notification("Found Tattoo Active for: " + tattooAge + " (max: " + tattooDuration + ")")
            if tattooAge > tattooDuration
                printMsg("Remove Tattoo")
                ; Remove Tattoo
                ;Debug.Notification("Removing it")
                SlaveTats.remove_tattoos(target,tattooEntry,ignore_lock=True,silent=True)
                
                ; Stop Tracking data for this tattoo
                JMap.removeKey(appliedMap, texturePath)
            else
                printMsg("Update Tattoo")
                ; Updates tattoo alpha according to mode
                tattooAlpha = getAlphaForMode(menuForm.alphaDropOffMode,tattooAge / tattooDuration)
                ;Debug.Notification("Updating Alpha: " + tattooAlpha)
                JMap.setFlt(tattooEntry,"invertedAlpha",1.0 - tattooAlpha)
            endIf
            needUpdate = True
            
            i -= 1
        endwhile
        
        if needUpdate
            ; If something got changed, update tattoo display thingy 
            SlaveTats.mark_actor(target)
            SlaveTats.synchronize_tattoos(target,silent=True)
        endIf
    endif
	
    printMsg("Function done")
	JValue.release(appliedTattoos)
    
endfunction

function printMsg(string msg)
    if verboseMessages
        Debug.Trace("[FadeTattoos] " + msg)
    endif
endfunction

Event OnUpdateGameTime()
    printMsg("OnUpdateGameTime - 1")
    updateTattooState()
    printMsg("OnUpdateGameTime - 2")
    RegisterForSingleUpdateGameTime(updateEvery)
    printMsg("OnUpdateGameTime - 3")
endEvent

function updateTattooState()
    printMsg("updateTattooState")
    int trackedArr = getRetainedTrackedArr()
    int appliedMap
    bool removeTarget
    int i
    Actor target
    
    i = JArray.count(trackedArr) - 1
    if i == -1
        printMsg("No tracked actors")
    endif
	while i >= 0
        printMsg("updateTattooState Actor Idx: " + i)
        target = JArray.getForm(trackedArr,i) as Actor
        removeTarget = False
        appliedMap = JFormDB.getObj(target, ".fTatsForm.appliedMap")
        
        if appliedMap == 0
            removeTarget = True
        else
            if JMap.count(appliedMap) == 0
                ; Remove object
                JFormDB.setObj(target, ".fTatsForm.appliedMap", 0)
                removeTarget = True
            endif
        endif
        
        if removeTarget
            printMsg("Remove")
            JArray.eraseIndex(trackedArr,i)
        else
            printMsg("Update")
            updateForTarget(target,appliedMap)
        endif
        
        i -= 1
    endwhile
    
    JValue.release(trackedArr)
endfunction

float function getAlphaForMode(int mode, float fracDone) global
	if mode == 1
		return 1.0 - fracDone
	elseif mode == 2
		; Using the quadratic equation x^2 - 2x + 1
		; to model the alpha drop-off of the tattoo as it fades
		; This way the tattoo loses 75% of it's intensity by the halfway mark
		; but lingers for a while.
		return fracDone*fracDone - 2.0*fracDone + 1.0
	else
		return 1.0
	endif
endfunction

; Note: This only stops the tattoo from being faded out. The tattoo will remain
;       applied at the current alpha value
function stopTattooFadeFor(Actor target, string tattooTexturePath) global
    int appliedMap = JFormDB.getObj(target, ".fTatsForm.appliedMap")
    if appliedMap == 0 || !JMap.hasKey(appliedMap,tattooTexturePath)
        ; No data is being tracked for this tattoo
        return
    endif
    
    ; Remove tracking data
    JMap.removeKey(appliedMap, tattooTexturePath)
    
    if JArray.count(JMap.allKeys(appliedMap)) == 0
        ; No more data is being tracked for this actor, remove them
        ; from the tracked actor list
        endTrackingFor(target)
    endif
endfunction

; Takes a retained JArray of currently applied tattoo entries and removes any entries
; that didn't get added by this mod itself (which would have a datamap entry)
; Also removes any entries from the datamap list that are no longer applied to the body.
; So tracked tattoos can be removed through other means without there being old data lingering
function appliedMapFilterAndUpdate(int appliedMap, int appliedTatList) global
	int keyList = JValue.retain(JMap.allKeys(appliedMap))
	
	int i = JArray.count(appliedTatList) - 1
	int currentTat
	int j
	while i >= 0
		currentTat = JArray.getObj(appliedTatList,i)
		j = JArray.findStr(keyList,JMap.getStr(currentTat,"texture"))
		if j == -1
			; Tattoo is not part of tracked set
			; Remove from array
			JArray.eraseIndex(appliedTatList,i)
		else
			; Tattoo is part of tracked set
			; Remove this item from the key list since it is accounted for
			JArray.eraseIndex(keyList,j)
		endif
		i -= 1
	endwhile
	
	; Any items left in the keyList are items not in the applied list, so we need
	; to delete their entries
	i = JArray.count(keyList) - 1
	while i >= 0
        JMap.removeKey(appliedMap,JArray.getStr(keyList,i))
		i -= 1
	endwhile
	
	; Since keyList was retained at the start
	JValue.release(keyList)
	
	; Any items left in appliedTatList will have a valid time entry in appliedMap object
	; So, job done
endfunction