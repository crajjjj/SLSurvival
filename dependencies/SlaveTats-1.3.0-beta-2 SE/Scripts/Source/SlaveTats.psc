scriptname SlaveTats hidden

import NiOverride
import NetImmerse

; A "tattoo" is a JMap containing the following keys:
; name -> string                The name to display for the tattoo. Should be unique within its section
; section -> string             The section to place the tattoo under, in the menu
; texture -> string             The path to the texture, relative to Data\Textures\Actors\Character\slavetats
; area -> string                One of "Body", "Face", "Hands", "Feet"

; The following keys are also meaningful, but not required:
; slot -> int                   The overlay index to use. Will be automatically selected and filled by add_tattoo() if absent
; color -> int                  The color to use. Can be overridden via the menu
; glow -> int                   The glow color to use. Can be overridden via the menu
; gloss -> int                  If > 0, use skin-like gloss. Otherwise, use matte color
; bump -> string                Currently ignored. Will be the bump map to apply, once I figure out how
; locked -> int                 If > 0, the tattoo can not be removed except by passing ignore_locked = true to remove_tattoos()
; excluded_by -> string         If an applied tattoo has a key equal to the excluded_by value, add_tattoo() will fail
; requires -> string            add_tattoo() will fail unless an applied tattoo has a key equal to the requires value, and tattoos with unmet requirements will be removed during synchronize_tattoos()
; requires_plugin -> string     The file name of an esp or esm file that must be loaded before query_available_tattoos() will include this tattoo in the result set. If this is a list of names instead of a name, requires_formid must be a list as well, and at least one of the plugin/formid pairs must be available
; requires_formid -> string     The form id that must be loadable from the requires_plugin file before query_available_tattoos() will include this tattoo in the result set.  If this is a list of formids instead of a formid, requires_plugin must be a list as well, and at least one of the plugin/formid pairs must be available
; domain -> string              If this is specified, the tattoo will not appear in the menu. The only way to access the tattoo will be from a mod that requests that specific domain from query_available_tattoos()
; spell_plugin -> string        The file name of the esp or esm file containing the spell to cast when the tattoo is applied, or a list of such filenames in order of preference
; spell_formid -> int           The form id for the spell, relative to the spell_plugin file, or a list of such formids relative to the corresponding names in spell_plugin
; spell_source_plugin -> string Similar to spell_plugin, except it determines who is "casting" the spell. Rarely needed.
; spell_source_formid -> int    Similar to spell_formid, except it determines who is "casting" the spell. Rarely needed
; event -> string               The name of a ModEvent to send when the tattoo is applied or cleared. The event is sent with "applied" or "cleared" as the first parameter, and the target actor as the second.
; credit -> string              The person who should be credited artistically for the tattoo
; in_bsa -> int                 If not 0, the tattoo texture may be loaded from a BSA file

; Arbitrary additional keys are allowed, which is helpful with excluded_by and requires, and may be useful for other mods using the API


; The 'high-level' API consists of the functions:
;  simple_add_tattoo()
;  simple_remove_tattoo()


; The primary API consists of the functions:
;  query_available_tattoos()
;  query_applied_tattoos()
;  add_tattoo()
;  remove_tattoos()
;  synchronize_tatoos()

; The other functions are situationally useful, or helpers.



; Constants defined this way don't get stuck with old values after code updates. This is no slower than accessing a property.
string function VERSION() global
    return "1.0.0" ; This is the data structure version, not the release number that's shown to users
endfunction

string function ROOT() global
    return "Data\\Textures\\"
endfunction

string function PREFIX() global
    return "Actors\\Character\\slavetats\\"
endfunction

int function SLOTS(string area) global
    if area == "Body"
        return NiOverride.GetNumBodyOverlays()
    elseif area == "Face"
        return NiOverride.GetNumFaceOverlays()
    elseif area == "Hands"
        return NiOverride.GetNumHandOverlays()
    elseif area == "Feet"
        return NiOverride.GetNumFeetOverlays()
    else
        return 0
    endif
endfunction

; Finds the tattoo with the matching section name and tattoo name, and inks it on
; the target in the specified color. Returns true if successful, otherwise false.
; If you're planning on adding more than one tattoo at the same time, pass false to the
; 'last' parameter for all but the last one.
bool function simple_add_tattoo(Actor target, string section, string name, int color = 0, bool last = true, bool silent = false, float alpha = 1.0) global
    int template = JValue.addToPool(JMap.object(), "SlaveTatsHighLevel")
    int matches = JValue.addToPool(JArray.object(), "SlaveTatsHighLevel")
    int tattoo = 0

    JMap.setStr(template, "section", section)
    JMap.setStr(template, "name", name)

    if query_available_tattoos(template, matches)
        JValue.cleanPool("SlaveTatsHighLevel")
        return false
    endif

    tattoo = JValue.addToPool(JArray.getObj(matches, 0), "SlaveTatsHighLevel")
    JMap.setInt(tattoo, "color", color)
    JMap.setFlt(tattoo, "invertedAlpha", 1.0 - alpha)

    JArray.clear(matches)

    if query_applied_tattoos(target, template, matches)
        JValue.cleanPool("SlaveTatsHighLevel")
        return false
    endif

    if JArray.count(matches) > 0
        JValue.cleanPool("SlaveTatsHighLevel")
        return false
    endif

    if add_tattoo(target, tattoo, -1, false, true)
        JValue.cleanPool("SlaveTatsHighLevel")
        return false
    endif

    if last
        if synchronize_tattoos(target, silent)
            JValue.cleanPool("SlaveTatsHighLevel")
            return false
        endif
    endif

    JValue.cleanPool("SlaveTatsHighLevel")
    return true
endfunction

; Removes the tattoo with the given section name and tattoo name from the actor. Returns true if
; successful, false otherwise.
; If you're planning on removing more than one tattoo at the same time, pass false to the
; 'last' parameter for all but the last one.
bool function simple_remove_tattoo(Actor target, string section, string name, bool last = true, bool silent = false) global
    int template = JValue.addToPool(JMap.object(), "SlaveTatsHighLevel")
    int matches = JValue.addToPool(JArray.object(), "SlaveTatsHighLevel")
    int tattoo = 0

    JMap.setStr(template, "section", section)
    JMap.setStr(template, "name", name)

    if query_applied_tattoos(target, template, matches)
        JValue.cleanPool("SlaveTatsHighLevel")
        return false
    endif

    if JArray.count(matches) == 0
        JValue.cleanPool("SlaveTatsHighLevel")
        return false
    endif

    tattoo = JValue.addToPool(JArray.getObj(matches, 0), "SlaveTatsHighLevel")

    if remove_tattoos(target, tattoo, true, true)
        JValue.cleanPool("SlaveTatsHighLevel")
        return false
    endif

    if last
        if synchronize_tattoos(target, silent)
            JValue.cleanPool("SlaveTatsHighLevel")
            return false
        endif
    endif

    JValue.cleanPool("SlaveTatsHighLevel")
    return true
endfunction

; This function compares a template JMap with another JMap. If every key in the template is in the other,
; and the simple values associated with those keys match, this function returns true. If the template is 0, this function
; returns true. If the value of a key in the template is "ANY" and that that key exists in the other map, that is considered
; a match for that key. If the value of a key in the template is a string containing *, it will act as a wildcard during the
; comparison. This function is meant for comparing a query tattoo entry with potential actual tattoo entries.
; If the include_configurable parameter is true, fields that are user-settable will be compared. Otherwise, those fields will
; be skipped, as they are unlikely to actually differentiate between two tattoos
bool function tattoo_matches(int template, int tattoo, bool include_configurable = false) global
    ;Debug.Trace("SlaveTats: Comparing " + template + " and " + tattoo)

    if template == 0
        return true
    endif

    if tattoo == 0
        return false
    endif

    int tkeys = JValue.addToPool(JMap.allKeys(template), "SlaveTats-tattoo_matches")
    string tkey

    int ival1
    int ival2
    float fval1
    float fval2
    string sval1
    string sval2
    int wildcard

    int i = JMap.count(template)
    while i > 0
        i -= 1

        tkey = JArray.getStr(tkeys, i)

        if include_configurable || (tkey != "color" && tkey != "glow" && tkey != "gloss")
            ;Debug.Trace("SlaveTats: tkey = " + tkey)

            sval1 = JMap.getStr(template, tkey)

            ;Debug.Trace("SlaveTats: sval1 = " + sval1)

            wildcard = StringUtil.Find(sval1, "*")

            ;Debug.Trace("SlaveTats: wildcard = " + wildcard)

            if !(sval1 == "ANY" && JMap.hasKey(tattoo, tkey))
                ival1 = JMap.getInt(template, tkey)
                fval1 = JMap.getFlt(template, tkey)

                ival2 = JMap.getInt(tattoo, tkey)
                fval2 = JMap.getFlt(tattoo, tkey)
                sval2 = JMap.getStr(tattoo, tkey)

                ;Debug.Trace("SlaveTats: ival1 = " + ival1)
                ;Debug.Trace("SlaveTats: fval1 = " + fval1)
                ;Debug.Trace("SlaveTats: sval2 = " + sval2)
                ;Debug.Trace("SlaveTats: ival2 = " + ival2)
                ;Debug.Trace("SlaveTats: fval2 = " + fval2)

                if (ival1 != ival2) || (fval1 != fval2) || (sval1 != sval2)
                    ;Debug.Trace("SlaveTats: First level eval failed.")
                    if wildcard >= 0
                        int sval1_len = StringUtil.GetLength(sval1)
                        int sval2_len = StringUtil.GetLength(sval2)

                        if sval2_len < sval1_len - 1
                            ;Debug.Trace("SlaveTats: The real value is too short to match the template value.")
                            JValue.cleanPool("SlaveTats-tattoo_matches")
                            return false
                        endif

                        if wildcard > 0
                            if StringUtil.SubString(sval2, 0, wildcard) != StringUtil.SubString(sval1, 0, wildcard)
                                ;Debug.Trace("SlaveTats: The prefixes did not match.")
                                JValue.cleanPool("SlaveTats-tattoo_matches")
                                return false
                            endif
                        endif

                        if wildcard < sval1_len - 1
                            string suffix = StringUtil.SubString(sval1, wildcard + 1)
                            if (StringUtil.SubString(sval2, sval2_len - StringUtil.GetLength(suffix))) != suffix
                                ;Debug.Trace("SlaveTats: The suffixes did not match.")
                                JValue.cleanPool("SlaveTats-tattoo_matches")
                                return false
                            endif
                        endif
                    else
                        JValue.cleanPool("SlaveTats-tattoo_matches")
                        return false
                    endif
                endif
            endif
        endif
    endwhile

    ;Debug.Trace("SlaveTats: Match found.")
    JValue.cleanPool("SlaveTats-tattoo_matches")
    return true
endfunction

; Determines if the passed JValue can sanely be used as a tattoo entry.
; The tattoo should already be retained by the caller
bool function is_tattoo(int tattoo) global
    if tattoo == 0
        return false
    endif

    if !JValue.isMap(tattoo)
        return false
    endif

    if JMap.getStr(tattoo, "name") == ""
        return false
    endif

    if JMap.getStr(tattoo, "section") == ""
        return false
    endif

    string area = JMap.getStr(tattoo, "area")
    if (area != "Body") && (area != "Face") && (area != "Hands") && (area != "Feet")
        return false
    endif

    if JMap.getStr(tattoo, "texture") == ""
        return false
    endif

    ; If color, glow, gloss, or slot are missing, they will come back with 0, which is a valid value

    return true
endfunction

; Accepts a JArray of tattoos and a tattoo template, and returns the index of the first tattoo
; that matches the template, or -1
int function find_tattoo(int array, int template) global
    int len = JArray.count(array)
    int i = 0
    while i < len
        if tattoo_matches(template, JArray.getObj(array, i))
            return i
        endif
        i += 1
    endwhile
    return -1
endfunction

; Checks whether the 'applied' JArray contains any tattoo that is exclusive with the
; specified tattoo. If it does, the index within applied is returned. Otherwise,
; returns -1
int function find_excluding_tattoo(int applied, int tattoo) global
    string attribute = JMap.getStr(tattoo, "excluded_by")
    if attribute == ""
        return -1
    endif

    int template = JValue.addToPool(JMap.object(), "SlaveTats-find_excluding_tattoo")
    JMap.setStr(template, attribute, "ANY")
    int result = find_tattoo(applied, template)

    JValue.cleanPool("SlaveTats-find_excluding_tattoo")

    return result
endfunction

; Checks whether the 'applied' JArray contains any tattoo that is required by the
; specified tattoo. If it does, the index within applied is returned. Otherwise,
; returns -1
; If a tattoo does not have a 'requires' trait, the first tattoo is notionally a match,
; and 0 is returned
int function find_required_tattoo(int applied, int tattoo) global
    string attribute = JMap.getStr(tattoo, "requires")
    if attribute == ""
        return 0
    endif

    int template = JValue.addToPool(JMap.object(), "SlaveTats-find_required_tattoo")
    JMap.setStr(template, attribute, "ANY")
    int result = find_tattoo(applied, template)

    JValue.cleanPool("SlaveTats-find_required_tattoo")

    return result
endfunction

; Checks whether the loaded environment contains any of the plugin/formid pairs that satisfy
; the tattoo's requirement
; The tattoo parameter should be an already created and retained JMap
bool function has_required_plugin(int tattoo) global
    if (JMap.getStr(tattoo, "requires_plugin") == "") && (JMap.getObj(tattoo, "requires_plugin") == 0)
        return true
    endif
    return (get_form(tattoo, "requires_plugin", "requires_formid") != None)
endfunction

; Reads and merges tattoo registries from the disk into a JArray of matching entries.
; The template parameter must be an already created and retained JMap containing the search fields and values, or 0 to match all entries.
; The matches parameter must be an already created and retained JArray, which will be filled with matching entries. It will not be cleared first.
; The applied parameter, if provided, should be an array of tattoos, against which the queried tattoos will have their excluded_by and requires
; attributes checked. Excluded tattoos will not be returned in the result set.
; The domain parameter contains the name of the tattoo domain to query. Only tattoos marked as members of that domain are returned in the result set
; This function returns true to signal an error. Zero matching tattoos is not an error.
bool function query_available_tattoos(int template, int matches, int applied = 0, string domain = "") global
    ; The data are loaded from the disk with each query. If this gets slow enough to be a problem, the database will be
    ; much too large to keep in memory anyway.
    int directory = JValue.addToPool(JValue.readFromDirectory(ROOT() + PREFIX()), "SlaveTats-query_available_tattoos")

    if directory == 0
        ;Debug.Trace("SlaveTats: No tattoo registries found.", 2)
        JValue.cleanPool("SlaveTats-query_available_tattoos")
        return true
    endif

    ;int processed = JValue.addToPool(JMap.allKeys(directory), "SlaveTats-query_available_tattoos")
    ;int diriter = JArray.count(processed)
    ;while diriter > 0
    ;    diriter -= 1
    ;    Debug.Trace("SlaveTats: Scanned " + JArray.getStr(processed, diriter))
    ;endwhile

    int registries = JValue.addToPool(JMap.allValues(directory), "SlaveTats-query_available_tattoos")

    ;Debug.Trace("SlaveTats: Found " + JArray.count(registries) + " registries")

    int i = JArray.count(registries)
    while i > 0
        i -= 1

        int entries = JValue.addToPool(JArray.getObj(registries, i), "SlaveTats-query_available_tattoos")
        if is_tattoo(entries) && (domain == JMap.getStr(entries, "domain"))
            ;Debug.Trace("SlaveTats: Registry " + i + " contains " + JMap.getStr(entries, "name"))
            if tattoo_matches(template, entries) && (applied == 0 || ((find_excluding_tattoo(applied, entries) < 0) && (find_required_tattoo(applied, entries) >= 0))) && has_required_plugin(entries)
                JArray.addObj(matches, entries)
            endif
        elseif JValue.isArray(entries)
            int j = JArray.count(entries)
            ;Debug.Trace("SlaveTats: Registry " + i + " contains " + j + " entries.")
            while j > 0
                j -= 1

                int entry = JValue.addToPool(JArray.getObj(entries, j), "SlaveTats-query_available_tattoos")
                ;Debug.Trace("SlaveTats: Registry " + i + "[" + j + "] contains " + JMap.getStr(entry, "name"))
                if is_tattoo(entry) && (domain == JMap.getStr(entry, "domain"))
                    if tattoo_matches(template, entry) && (applied == 0 || ((find_excluding_tattoo(applied, entry) < 0) && (find_required_tattoo(applied, entry) >= 0))) && has_required_plugin(entry)
                        JArray.addObj(matches, entry)
                    endif
                endif
            endwhile
        endif
    endwhile

    JValue.cleanPool("SlaveTats-query_available_tattoos")
    return false
endfunction

; Compares applied tattoos to a template, and merges the matching entries in a JArray.
; The template parameter must be an already created and retained JMap containing the search fields and values, or 0 to match all entries.
; The matches parameter must be an already created and retained JArray, which will be filled with matching entries. It will not be cleared first.
; The except_area and except_slot parameters, if provided, specify an area:slot combination to leave out of the match set. Neither parameter is useful alone.
; This function returns true to signal an error. Zero matching tattoos is not an error.
bool function query_applied_tattoos(Actor target, int template, int matches, string except_area = "", int except_slot = -1) global
    int applied = JFormDB.getObj(target, ".SlaveTats.applied")
    if applied == 0
        return false
    endif

    int i = JArray.count(applied)
    while i > 0
        i -= 1

        int entry = JArray.getObj(applied, i)
        if tattoo_matches(template, entry) && ((JMap.getStr(entry, "area") != except_area) || (JMap.getInt(entry, "slot") != except_slot))
            JArray.addObj(matches, entry)
        endif
    endwhile

    return false
endfunction

; Wrapper around query_applied_tattoos, simplifying the use case where you're searching
; for any tattoos that have a particular attribute, regardless of its value
bool function query_applied_tattoos_with_attribute(Actor target, string attrib, int matches, string except_area = "", int except_slot = -1) global
    int template = JValue.addToPool(JMap.object(), "SlaveTats-query_available_tattoos_with_attribute")
    JMap.setStr(template, attrib, "ANY")
    bool result = query_applied_tattoos(target, template, matches, except_area, except_slot)

    JValue.cleanPool("SlaveTats-query_available_tattoos_with_attribute")
    return result
endfunction

; Wrapper around query_applied_tattoos_with_attribute, further simplifying the case where
; you just want to know whether such tattoos exist.
bool function has_applied_tattoos_with_attribute(Actor target, string attrib, string except_area = "", int except_slot = -1) global
    int matches = JValue.addToPool(JArray.object(), "SlaveTats-has_applied_tattoos_with_attribute")
    if query_applied_tattoos_with_attribute(target, attrib, matches, except_area, except_slot)
        Debug.Trace("SlaveTats: query failed within has_applied_tattoos_with_attribute(" + target.GetLeveledActorBase().GetName() + ", " + attrib + ")", 2)
    endif

    bool result = JArray.count(matches) > 0

    if result
        Debug.Trace("SlaveTats: First matching tattoo with " + attrib + " is " + JMap.getStr(JArray.getObj(matches, 0), "name"))
    endif

    JValue.cleanPool("SlaveTats-has_applied_tattoos_with_attribute")
    return result
endfunction

function notify(string mesg, bool silent = false) global
    if silent
        Debug.Trace("SlaveTats: (Silenced) " + mesg)
    else
        Debug.Notification(mesg)
    endif
endfunction

; Compares applied tattoos to a template, and removes the matching entries
; The target parameter determines which actor is being changed
; The template parameter must be an already created and retained JMap containing the search fields and values, or 0 to match all entries.
; The ignore_lock parameter overrides tattoo locking if true
; This function returns true to signal an error. Zero matching tattoos is not an error.
bool function remove_tattoos(Actor target, int template, bool ignore_lock = False, bool silent = False) global
    log_tattoo("Asked to remove matching tattoos", template)

    if upgrade_tattoos(target)
        Debug.Trace("SlaveTats: Upgrade returned an error code.")
        return true
    endif

    return _remove_tattoos(target, template, ignore_lock, silent)
endfunction

bool function _remove_tattoos(Actor target, int template, bool ignore_lock = False, bool silent = False) global
    int applied = JFormDB.getObj(target, ".SlaveTats.applied")
    if applied == 0
        return false
    endif

    bool failed = false

    int i = JArray.count(applied)
    while i > 0
        i -= 1

        int entry = JArray.getObj(applied, i)
        if tattoo_matches(template, entry)
            if JMap.getInt(entry, "locked") > 0 && !ignore_lock
                notify("The tattoo resists all of your efforts to remove it.", silent)
                failed = true
            else
                JArray.eraseIndex(applied, i)
                JFormDB.setInt(target, ".SlaveTats.updated", 1)
            endif
        endif
    endwhile

    return failed
endfunction

; Removes any tattoo at the specified body area and slot combination
; The target parameter determines which actor is being changed
; The ignore_lock parameter overrides tattoo locking if true
; This function returns true to signal an error. Zero matching tattoos is not an error.
bool function remove_tattoo_from_slot(Actor target, string area, int slot, bool ignore_lock = False, bool silent = False) global
    int template = JValue.addToPool(JMap.object(), "SlaveTats-remove_tattoo_from_slot")

    JMap.setStr(template, "area", area)
    JMap.setInt(template, "slot", slot)

    if _remove_tattoos(target, template, ignore_lock, silent)
        JValue.cleanPool("SlaveTats-remove_tattoo_from_slot")
        return true
    endif

    JValue.cleanPool("SlaveTats-remove_tattoo_from_slot")
    return false
endfunction

; Finds and returns the tattoo in the given body area and slot. If no tattoo is found,
; returns 0
int function get_applied_tattoo_in_slot(Actor target, string area, int slot) global
    int template = JValue.addToPool(JMap.object(), "SlaveTats-get_applied_tattoo_in_slot")

    JMap.setStr(template, "area", area)
    JMap.setInt(template, "slot", slot)

    int matches = JValue.addToPool(JArray.object(), "SlaveTats-get_applied_tattoo_in_slot")

    if query_applied_tattoos(target, template, matches)
        JValue.cleanPool("SlaveTats-get_applied_tattoo_in_slot")
        return 0
    endif

    if JArray.count(matches) == 0
        JValue.cleanPool("SlaveTats-get_applied_tattoo_in_slot")
        return 0
    endif

    int tattoo = JArray.getObj(matches, 0)

    JValue.cleanPool("SlaveTats-get_applied_tattoo_in_slot")
    return tattoo
endfunction

; Fetches all applied tattoos, placing them into one of the JArrays on_body, on_face, on_hands, or on_feet
; Each of the output arrays should be already created and retained
; The output arrays will not be cleared first
; It is acceptable to pass the same array for more than one of the output parameters
; Returns true to indicate a failure
bool function get_applied_tattoos_by_area(Actor target, int on_body, int on_face, int on_hands, int on_feet) global
    int applied = JFormDB.getObj(target, ".SlaveTats.applied")
    if applied == 0
        return false
    endif

    int i = JArray.count(applied)
    while i > 0
        i -= 1

        int entry = JArray.getObj(applied, i)
        string area = JMap.getStr(entry, "area")

        if area == "Body"
            JArray.addObj(on_body, entry)
        elseif area == "Face"
            JArray.addObj(on_face, entry)
        elseif area == "Hands"
            JArray.addObj(on_hands, entry)
        elseif area == "Feet"
            JArray.addObj(on_feet, entry)
        else
            Debug.Trace("SlaveTats: Applied tattoo \"" + JMap.getStr(entry, "name") + "\"has unknown area: " + area, 2)
        endif
    endwhile

    return false
endfunction

; Fills matches with the slot numbers that are occupied by unknown overlays
; The matches parameter must be an already created and retained JArray, which will be filled with integers. It will not be cleared first.
bool function external_slots(Actor target, string area, int matches) global
    ActorBase target_base = target.GetActorBase()
    bool isFemale = target_base.GetSex() as bool

    string prefix = PREFIX()
    string suffix = "default.dds"

    int prefix_length = StringUtil.GetLength(prefix)
    int suffix_length = StringUtil.GetLength(suffix)

    int i = SLOTS(area)
    while i > 0
        i -= 1

        string nodeName = area + " [ovl" + i + "]"
        string overlay_path = NiOverride.GetNodeOverrideString(target, isFemale, nodeName, 9, 0)

        if (overlay_path != "") && (StringUtil.Substring(overlay_path, 0, prefix_length) != prefix) && (overlay_path != suffix) && (StringUtil.SubString(overlay_path, StringUtil.GetLength(overlay_path) - suffix_length - 1) != ("\\" + suffix))
            Debug.Trace("SlaveTats: Found external overlay: " + overlay_path)
            JArray.addInt(matches, i)
        endif
    endwhile
    return false
endfunction

; Returns an available slot number for the given target and body area
; Primarily for internal use
int function _available_slot(Actor target, string area) global
    Debug.Trace("SlaveTats: Searching for an available slot on " + target.GetLeveledActorBase().GetName() + " in " + area)

    int external = JValue.addToPool(JArray.object(), "SlaveTats-_available_slot")

    if external_slots(target, area, external)
        Debug.Trace("SlaveTats: Error reading external overlays. Aborting search.")
        JValue.cleanPool("SlaveTats-_available_slot")
        return -1
    endif

    Debug.Trace("SlaveTats: Found " + JArray.count(external) + " external overlays.")

    int total = SLOTS(area)
    int i = 0
    while i < total
        Debug.Trace("SlaveTats: Examining slot " + i)
        if JArray.findInt(external, i) == -1
            Debug.Trace("SlaveTats:    Not an external overlay")
            if get_applied_tattoo_in_slot(target, area, i) == 0
                Debug.Trace("SlaveTats:    Not a tattoo. This slot is available.")
                JValue.cleanPool("SlaveTats-_available_slot")
                return i
            endif
        endif
        i += 1
    endwhile

    Debug.Trace("SlaveTats: No available slot found.")

    JValue.cleanPool("SlaveTats-_available_slot")
    return -1
endfunction


; Adds the specified tattoo to the target, if possible. The passed in tattoo will not be retained.
; If slot is specified (not -1), replaces the tattoo in that slot.
; If slot is -1 and the tattoo already has a slot entry, uses the tattoo's preset slot value.
; If the slot is -1 and the tattoo doesn't have a slot preset, finds an available slot and uses that.
; Will fail if the slot is not specified in the arguments or the tattoo, and there are no slots left in the tattoo's body area
; Will fail if the slot is specified in the arguments or the tattoo, ignore_lock is false, and that slot is occupied by a locked tattoo
; Returns true to indicate failure
bool function add_tattoo(Actor target, int tattoo, int slot = -1, bool ignore_lock = False, bool silent = False) global
    if add_and_get_tattoo(target, tattoo, slot, ignore_lock, silent) == 0
        return true
    endif
    return false
endfunction

; Adds the tattoo, exactly as described in the add_tattoo comment, except that it also returns the added tattoo, or 0
; if adding failed. This is useful because the tattoo that actually gets added to the record is a copy of the passed
; in tattoo, and so making changes (e.g. color) to the passed in tattoo after adding does not affect the added tattoo.
; This is mostly needed for the menu, where tattoo traits are modified on the fly.
int function add_and_get_tattoo(Actor target, int tattoo, int slot = -1, bool ignore_lock = False, bool silent = False, bool try_upgrade = True) global
    log_tattoo("Asked to add a tattoo", tattoo)

    if try_upgrade && upgrade_tattoos(target)
        Debug.Trace("SlaveTats: Upgrade returned an error code.")
        return 0
    endif

    return _add_and_get_tattoo(target, tattoo, slot, ignore_lock, silent)
endfunction

int function _add_and_get_tattoo(Actor target, int tattoo, int slot = -1, bool ignore_lock = False, bool silent = False) global
    string area = JMap.getStr(tattoo, "area")

    string texture = JMap.getStr(tattoo, "texture")

    Debug.Trace("SlaveTats: Caller requested slot " + slot)

    if (slot == -1) && JMap.hasKey(tattoo, "slot")
        slot = JMap.getInt(tattoo, "slot")
        Debug.Trace("SlaveTats: Tattoo requested slot " + slot)
    endif

    if slot == -1
        slot = _available_slot(target, area)
        Debug.Trace("SlaveTats: Available slot " + slot)
    endif

    if slot == -1
        Debug.Trace("SlaveTats: All slot selection methods failed.", 1)
        return 0
    endif

    if remove_tattoo_from_slot(target, area, slot, ignore_lock, silent)
        Debug.Trace("SlaveTats: Current tattoo in " + area + ":" + slot + " is locked.", 1)
        return 0
    endif

    if texture == ""
        ; Probably "No Tattoo". Treat it as such
        Debug.Trace("SlaveTats: Tattoo has no texture. We're done.")
        return tattoo
    endif

    if JMap.getInt(tattoo, "in_bsa") == 0
        if !JContainers.fileExistsAtPath(ROOT() + PREFIX() + texture)
            Debug.Trace("SlaveTats: No such file: " + PREFIX() + JMap.getStr(tattoo, "texture"), 1)
            return 0
        endif
    endif

    string exclusion = JMap.getStr(tattoo, "excluded_by")

    if exclusion != ""
        if has_applied_tattoos_with_attribute(target, exclusion)
            Debug.Trace("SlaveTats: Couldn't apply tattoo because it is excluded by an already applied tattoo.")
            return 0
        endif
    endif

    string requirement = JMap.getStr(tattoo, "requires")

    if requirement != ""
        if !has_applied_tattoos_with_attribute(target, requirement)
            Debug.Trace("SlaveTats: Couldn't apply tattoo because it requires a tattoo not yet applied.")
            return 0
        endif
    endif

    int applied = JFormDB.getObj(target, ".SlaveTats.applied")
    if applied == 0
        applied = JValue.addToPool(JArray.object(), "SlaveTats-_add_and_get_tattoo")
        JFormDB.setObj(target, ".SlaveTats.applied", applied)
    endif

    int apply_tattoo = JValue.addToPool(JValue.shallowCopy(tattoo), "SlaveTats-_add_and_get_tattoo")
    JMap.setInt(apply_tattoo, "slot", slot)
    JArray.addObj(applied, apply_tattoo)

    JFormDB.setInt(target, ".SlaveTats.updated", 1)

    JValue.cleanPool("SlaveTats-_add_and_get_tattoo")

    return apply_tattoo
endfunction

; Get a form referenced in a tattoo, processing plugin/formid pairs in order until one is found that actually exists. If none of the
; plugin/formid pairs is valid, return None
; The tattoo parameter should be an already created and retained JMap
; The plugin_field parameter should contain the name of the tattoo attribute that specifies the plugin names(s)
; The formid_field parameter should contain the name of the tattoo attribute that specifies the plugin formids(s)
; The default value will be returned in the event that a form is not found
Form function get_form(int tattoo, string plugin_field, string formid_field, Form default = None) global
    int plugins = JMap.getObj(tattoo, plugin_field)
    int formids = JMap.getObj(tattoo, formid_field)

    string plugin
    int formid
    Form result

    if plugins == 0 && formids == 0
        plugin = JMap.getStr(tattoo, plugin_field)
        formid = JMap.getInt(tattoo, formid_field)
        if plugin == "" || formid == 0
            return default
        endif
        Debug.Trace("SlaveTats: Attempting to load " + plugin + " : " + formid)
        result = Game.GetFormFromFile(formid, plugin) ; Might produce None, but that's how I would report an error anyway.
        if (result as bool)
            return result
        endif
        return default
    endif

    if plugins == 0 || formids == 0
        Debug.Trace("SlaveTats: Trying to load a form from " + JMap.getStr(tattoo, "name") + "[" + plugin_field + " and " + formid_field + "] but one attribute is a container and the other is a simple value. Aborting.")
        return default
    endif

    if !(JValue.isArray(plugins) && JValue.isArray(formids))
        Debug.Trace("SlaveTats: Trying to load a form from " + JMap.getStr(tattoo, "name") + "[" + plugin_field + " and " + formid_field + "] but at least one of the attributes is not a list or a simple value. Aborting.")
        return default
    endif

    if JArray.count(plugins) != JArray.count(formids)
        Debug.Trace("SlaveTats: Trying to load a form from " + JMap.getStr(tattoo, "name") + "[" + plugin_field + " and " + formid_field + "] but the attributes have different lengths. Aborting.")
        return default
    endif

    int i = 0
    int max = JArray.count(plugins)
    while i < max
        plugin = JArray.getStr(plugins, i)
        formid = JArray.getInt(formids, i)
        Debug.Trace("SlaveTats: Attempting to load " + plugin + " : " + formid)
        result = Game.GetFormFromFile(formid, plugin)
        if (result as bool)
            return result
        endif
        i += 1
    endwhile

    return default
endfunction

; Casts the tattoo's spell, if it has one. Unless the tattoo specifies
; spell_source_plugin and spell_source_formid, the caster will be the
; target.
; If the tattoo specifies an event, sends it as a ModEvent with
; "applied" as the first parameter and the target as the second.
; If other kinds of tattoo magic are added later, this will activate them,
; as well.
bool function activate_tattoo_magic(Actor target, int tattoo, bool deactivate_first = false) global
    bool magic = false

    string tattoo_event = JMap.getStr(tattoo, "event")
    if tattoo_event != ""
        magic = true
        int evt

        if deactivate_first
            evt = ModEvent.Create(tattoo_event)
            if evt
                ModEvent.PushString(evt, "cleared")
                ModEvent.PushForm(evt, target)
                ModEvent.Send(evt)
                Debug.Trace("SlaveTats: Sent ModEvent " + tattoo_event + "(\"cleared\", " + target.GetLeveledActorBase().GetName() + ")")
            endif
        endif

        evt = ModEvent.Create(tattoo_event)
        if evt
            ModEvent.PushString(evt, "applied")
            ModEvent.PushForm(evt, target)
            ModEvent.Send(evt)
            Debug.Trace("SlaveTats: Sent ModEvent " + tattoo_event + "(\"applied\", " + target.GetLeveledActorBase().GetName() + ")")
        endif
    endif

    Spell spell_ = get_form(tattoo, "spell_plugin", "spell_formid") as Spell
    if spell_ != none
        magic = true

        Debug.Trace("SlaveTats: Tattoo spell = " + spell_.GetName())

        ObjectReference source = get_form(tattoo, "spell_source_plugin", "spell_source_formid", target) as ObjectReference

        if deactivate_first
            Debug.Trace("SlaveTats: Dispelling " + spell_.GetName())
            target.DispelSpell(spell_)
            Utility.Wait(0.25)
        endif

        Debug.Trace("SlaveTats: Casting " + spell_.GetName())
        spell_.Cast(source, target)
    endif

    if magic
        int activated = JFormDB.getObj(target, ".SlaveTats.activated")
        if activated == 0
            activated = JValue.addToPool(JArray.object(), "SlaveTats-activate_tattoo_magic") ; I would love for this to be a JSet, but no such beast exists
            JFormDB.setObj(target, ".SlaveTats.activated", activated)
        endif
        if JArray.findObj(activated, tattoo) < 0
            JArray.addObj(activated, tattoo)
        endif
    endif

    JValue.cleanPool("SlaveTats-activate_tattoo_magic")
    return false
endfunction

; If the tattoo specifies a spell, calling this function will dispel
; it from the target.
; If the tattoo specifies an event, sends it as a ModEvent with
; "cleared" as the first parameter and the target as the second.
; If other kinds of tattoo magic are added later, this will deactivate
; them, as well.
; The tattoo should have been returned from query_applied_tattoos or
; one of the related functions.
bool function deactivate_tattoo_magic(Actor target, int tattoo) global
    string tattoo_event = JMap.getStr(tattoo, "event")
    if tattoo_event != ""
        int evt = ModEvent.Create(tattoo_event)
        if evt
            ModEvent.PushString(evt, "cleared")
            ModEvent.PushForm(evt, target)
            ModEvent.Send(evt)
            Debug.Trace("SlaveTats: Sent ModEvent " + tattoo_event + "(\"cleared\", " + target.GetLeveledActorBase().GetName() + ")")
        endif
    endif

    Spell spell_ = get_form(tattoo, "spell_plugin", "spell_formid") as Spell
    if spell_ != none
        Debug.Trace("SlaveTats: Tattoo spell = " + spell_.GetName() + ". Dispelling.")
        target.DispelSpell(spell_)
    endif

    int activated = JFormDB.getObj(target, ".SlaveTats.activated")
    if activated != 0
        ; This will only work if the passed in tattoo is actually the same object. That should be
        ; okay, since presumably it came from query_applied_tattoos. If that's a bad assumption
        ; this will need to use find_tattoo() instead
        int tattoo_index = JArray.findObj(activated, tattoo)
        if tattoo_index >= 0
            JArray.eraseIndex(activated, tattoo_index)
        endif
    endif

    return false
endfunction

; Deactivates the magic from all applied tattoos.
bool function deactivate_all_tattoo_magic(Actor target) global
    int activated = JFormDB.getObj(target, ".SlaveTats.activated")
    if activated == 0
        return false
    endif

    int i = JArray.count(activated)
    while i > 0
        i -= 1

        deactivate_tattoo_magic(target, JArray.getObj(activated, i))
    endwhile

    return false
endfunction

; Call this to reactivate magic tied to applied tattoos matching the template. The
; magic will be deactivated, then activated again.
bool function refresh_tattoo_magic(Actor target, int template) global
    int matches = JValue.addToPool(JArray.object(), "SlaveTats-refresh_tattoo_magic")
    if query_applied_tattoos(target, template, matches)
        JValue.cleanPool("SlaveTats-refresh_tattoo_magic")
        return true
    endif

    int i = JArray.count(matches)
    while i > 0
        i -= 1

        activate_tattoo_magic(target, JArray.getObj(matches, i), true)
    endwhile

    JValue.cleanPool("SlaveTats-refresh_tattoo_magic")

    return false
endfunction

; Makes any necessary changes to JFormsDB for a given actor to update it to what the
; current code version expects.
; Returns true to report failure
bool function upgrade_tattoos(Actor target) global
    if target == None
        Debug.Trace("SlaveTats: upgrade_tattoos called with a null target")
        return true
    endif

    string actor_version = JFormDB.getStr(target, ".SlaveTats.version")
    string code_version = VERSION()

    if actor_version == code_version
        return false
    endif

    Debug.Trace("SlaveTats: Upgrading target " + target.GetLeveledActorBase().GetName() + " to SlaveTats " + code_version)

    int applied
    string path
    int i
    int template
    int matches
    int entry
    int apply_tattoo

    string prefix = PREFIX()
    int prefix_len = StringUtil.GetLength(prefix)

    if actor_version == ""
        JFormDB.setObj(target, ".SlaveTats.applied", JArray.object())
        actor_version = "1.0.0"

        ActorBase target_base = target.GetLeveledActorBase()
        bool isFemale = target_base.GetSex() as bool

        template = JValue.addToPool(JMap.object(), "SlaveTats-upgrade_tattoos")
        matches = JValue.addToPool(JArray.object(), "SlaveTats-upgrade_tattoos")

        Debug.Trace("SlaveTats: Prior version was <= 0.9.13 (or never had tattoos)")

        string area = "Body"
        i = SLOTS(area)
        while i > 0
            i -= 1

            string nodeName = area + " [ovl" + i + "]"
            path = NiOverride.GetNodeOverrideString(target, isFemale, nodeName, 9, 0)
            Debug.Trace("SlaveTats: Considering " + path)
            if StringUtil.SubString(path, 0, prefix_len) == prefix
                Debug.Trace("SlaveTats: Recognized as a tattoo.")
                JMap.setStr(template, "texture", "*" + StringUtil.SubString(path, prefix_len))
                JArray.clear(matches)
                query_available_tattoos(template, matches)
                if JArray.count(matches)
                    entry = JArray.getObj(matches, 0)
                    Debug.Trace("SlaveTats: Matched with " + JMap.getStr(entry, "name"))
                    JMap.setInt(entry, "color", NiOverride.GetNodeOverrideInt(target, isFemale, nodeName, 7, -1))
                    JMap.setInt(entry, "glow", NiOverride.GetNodeOverrideInt(target, isFemale, nodeName, 0, -1))
                    if NiOverride.GetNodeOverrideFloat(target, isFemale, nodeName, 2, -1) > 0.0
                        JMap.setInt(entry, "gloss", 1)
                    endif
                    _add_and_get_tattoo(target, entry, i, True, False)
                else
                    Debug.Trace("SlaveTats: No matching entry found.")
                endif
            endif
        endwhile

        area = "Face"
        i = SLOTS(area)
        while i > 0
            i -= 1

            string nodeName = area + " [ovl" + i + "]"
            path = NiOverride.GetNodeOverrideString(target, isFemale, nodeName, 9, 0)
            Debug.Trace("SlaveTats: Considering " + path)
            if StringUtil.SubString(path, 0, prefix_len) == prefix
                Debug.Trace("SlaveTats: Recognized as a tattoo.")
                JMap.setStr(template, "texture", "*" + StringUtil.SubString(path, prefix_len))
                JArray.clear(matches)
                query_available_tattoos(template, matches)
                if JArray.count(matches)
                    entry = JArray.getObj(matches, 0)
                    Debug.Trace("SlaveTats: Matched with " + JMap.getStr(entry, "name"))
                    _add_and_get_tattoo(target, entry, i, True, False)
                else
                    Debug.Trace("SlaveTats: No matching entry found.")
                endif
            endif
        endwhile

        area = "Hands"
        i = SLOTS(area)
        while i > 0
            i -= 1

            string nodeName = area + " [ovl" + i + "]"
            path = NiOverride.GetNodeOverrideString(target, isFemale, nodeName, 9, 0)
            Debug.Trace("SlaveTats: Considering " + path)
            if StringUtil.SubString(path, 0, prefix_len) == prefix
                Debug.Trace("SlaveTats: Recognized as a tattoo.")
                JMap.setStr(template, "texture", "*" + StringUtil.SubString(path, prefix_len))
                JArray.clear(matches)
                query_available_tattoos(template, matches)
                if JArray.count(matches)
                    entry = JArray.getObj(matches, 0)
                    Debug.Trace("SlaveTats: Matched with " + JMap.getStr(entry, "name"))
                    _add_and_get_tattoo(target, entry, i, True, False)
                else
                    Debug.Trace("SlaveTats: No matching entry found.")
                endif
            endif
        endwhile

        area = "Feet"
        i = SLOTS(area)
        while i > 0
            i -= 1

            string nodeName = area + " [ovl" + i + "]"
            path = NiOverride.GetNodeOverrideString(target, isFemale, nodeName, 9, 0)
            Debug.Trace("SlaveTats: Considering " + path)
            if StringUtil.SubString(path, 0, prefix_len) == prefix
                Debug.Trace("SlaveTats: Recognized as a tattoo.")
                JMap.setStr(template, "texture", "*" + StringUtil.SubString(path, prefix_len))
                JArray.clear(matches)
                query_available_tattoos(template, matches)
                if JArray.count(matches)
                    entry = JArray.getObj(matches, 0)
                    Debug.Trace("SlaveTats: Matched with " + JMap.getStr(entry, "name"))
                    _add_and_get_tattoo(target, entry, i, True, False)
                else
                    Debug.Trace("SlaveTats: No matching entry found.")
                endif
            endif
        endwhile

        JFormDB.setStr(target, ".SlaveTats.version", actor_version)
        JFormDB.setInt(target, ".SlaveTats.updated", 1)
        Debug.Trace("SlaveTats: Upgrade to " + actor_version + " finished.")
    endif

    JValue.cleanPool("SlaveTats-upgrade_tattoos")
    return false
endfunction

; Low-level function to clear an overlay from the target. Does NOT interact with SlaveTats
; record-keeping or tattoo database. You can use this function to clear a non-SlaveTats
; overlay. Use remove_tattoo instead if you want to remove a SlaveTats tattoo.
bool function clear_overlay(Actor target, bool isFemale, string area, int slot) global
    string nodeName = area + " [ovl" + slot + "]"
    NiOverride.AddNodeOverrideString(target, isFemale, nodeName, 9, 0, PREFIX() + "blank.dds", true)
    Utility.Wait(0.01)
    if NiOverride.HasNodeOverride(target, isFemale, nodeName, 9, 1)
        NiOverride.AddNodeOverrideString(target, isFemale, nodeName, 9, 1, PREFIX() + "blank.dds", true)
        Utility.Wait(0.01)
        NiOverride.RemoveNodeOverride(target, isFemale, nodeName, 9, 1)
        Utility.Wait(0.01)
    endif
    NiOverride.RemoveNodeOverride(target, isFemale, nodeName, 9, 0)
    Utility.Wait(0.01)
    NiOverride.RemoveNodeOverride(target, isFemale, nodeName, 7, -1)
    Utility.Wait(0.01)
    NiOverride.RemoveNodeOverride(target, isFemale, nodeName, 0, -1)
    Utility.Wait(0.01)
    NiOverride.RemoveNodeOverride(target, isFemale, nodeName, 8, -1)
    Utility.Wait(0.01)

    Debug.Trace("SlaveTats: Cleared " + nodeName)

    return false
endfunction

; Low-level function to apply an overlay to the target. Does NOT interact with SlaveTats
; record-keeping or tattoo database. You can use this function to apply a non-SlaveTats
; overlay. Use add_tattoo instead if you want to add a SlaveTats tattoo.
; The bump parameter is presently ignored, until I can divine the proper way to apply it
bool function apply_overlay(Actor target, bool isFemale, string area, int slot, string path, int color, int glow, bool gloss, string bump = "", float alpha = 1.0) global
    ; if !JContainers.fileExistsAtPath(ROOT() + path)
    ;     Debug.Trace("SlaveTats: No such file: " + path, 1)
    ;     return true
    ; endif
    string nodeName = area + " [ovl" + slot + "]"
    NiOverride.AddNodeOverrideString(target, isFemale, nodeName, 9, 0, path, true)
    Utility.Wait(0.01)
    if bump as bool
        debug.notification("Applying normal map: " + bump)
        NiOverride.AddNodeOverrideString(target, isFemale, nodeName, 9, 1, bump, true)
        Utility.Wait(0.01)
    endif
    NiOverride.AddNodeOverrideInt(target, isFemale, nodeName, 7, -1, color, true)
    Utility.Wait(0.01)
    NiOverride.AddNodeOverrideInt(target, isFemale, nodeName, 0, -1, glow, true)
    Utility.Wait(0.01)
    NiOverride.AddNodeOverrideFloat(target, isFemale, nodeName, 1, -1, 1.0, true)
    Utility.Wait(0.01)
    NiOverride.AddNodeOverrideFloat(target, isFemale, nodeName, 8, -1, alpha, true)
    Utility.Wait(0.01)
    if gloss
        NiOverride.AddNodeOverrideFloat(target, isFemale, nodeName, 2, -1, 5.0, true)
        Utility.Wait(0.01)
        NiOverride.AddNodeOverrideFloat(target, isFemale, nodeName, 3, -1, 5.0, true)
        Utility.Wait(0.01)
    else
        NiOverride.AddNodeOverrideFloat(target, isFemale, nodeName, 2, -1, 0.0, true)
        Utility.Wait(0.01)
        NiOverride.AddNodeOverrideFloat(target, isFemale, nodeName, 3, -1, 0.0, true)
        Utility.Wait(0.01)
    endif

    NiOverride.ApplyNodeOverrides(target)

    Debug.Trace("SlaveTats: Applied " + nodeName + " = " + path + ":" + color + ":" + glow + ":" + gloss)

    return false
endfunction

; Rarely needed, because add_tattoo and remove_tattoo already do it, but if you need to mark an actor as needing to be synchronized
; do it by calling this function. Most often, this will be useful when you have queried an applied tattoo, and then changed its color,
; glow color, or gloss.
function mark_actor(Actor target) global
    JFormDB.setInt(target, ".SlaveTats.updated", 1)
endfunction

; Called to bring the actual overlays of target in line with the description stored in
; JFormDB for the actor. That means, after you've called add_tattoo and remove_tattoos
; however many times you need, call synchronize_tattoos once to apply the changes you've
; made.
; Returns true to indicate failure
bool function synchronize_tattoos(Actor target, bool silent = false) global
    int i
    int idx
    int entry
    string area
    int slot
    string path
    int color
    int glow
    bool gloss
    string bump
    float alpha

    Debug.Trace("SlaveTats: Beginning synchronization for " + target.GetLeveledActorBase().GetName())

    if SKSE.GetPluginVersion("skee") < 1
        if !silent
            notify("SlaveTats requires NiOverride or RaceMenu.", silent)
        endif
        return true
    endif

    if NiOverride.HasOverlays(target) != true
        NiOverride.AddOverlays(target)
        Utility.Wait(0.5)
        if NiOverride.HasOverlays(target) != true
            notify("Target is not compatible with overlays.", silent)
            return true
        endif
    endif

    if upgrade_tattoos(target)
        Debug.Trace("SlaveTats: Upgrade returned an error code.")
        return true
    endif

    if JFormDB.getInt(target, ".SlaveTats.updated") == 0
        Debug.Trace("SlaveTats: Nothing has changed. Cancelling synchronization.")
        return false
    endif

    notify("Please wait while SlaveTats works on " + target.GetLeveledActorBase().GetName() + "...", silent)
    Game.DisablePlayerControls(false, false, false, false, false, true, false, false, 0)

    string prefix = PREFIX()

    int on_body = JValue.addToPool(JArray.object(), "SlaveTats-synchronize_tattoos")
    int on_face = JValue.addToPool(JArray.object(), "SlaveTats-synchronize_tattoos")
    int on_hands = JValue.addToPool(JArray.object(), "SlaveTats-synchronize_tattoos")
    int on_feet = JValue.addToPool(JArray.object(), "SlaveTats-synchronize_tattoos")

    int external_on_body = JValue.addToPool(JArray.object(), "SlaveTats-synchronize_tattoos")
    int external_on_face = JValue.addToPool(JArray.object(), "SlaveTats-synchronize_tattoos")
    int external_on_hands = JValue.addToPool(JArray.object(), "SlaveTats-synchronize_tattoos")
    int external_on_feet = JValue.addToPool(JArray.object(), "SlaveTats-synchronize_tattoos")

    int applied = JFormDB.getObj(target, ".SlaveTats.applied")
    bool loop = true

    while loop
        loop = false

        i = JArray.count(applied)
        while i > 0
            i -= 1

            if find_required_tattoo(applied, JArray.getObj(applied, i)) < 0
                remove_tattoos(target, JArray.getObj(applied, i), true, silent)
                loop = true
            endif
        endwhile
    endwhile

    if get_applied_tattoos_by_area(target, on_body, on_face, on_hands, on_feet)
        Game.EnablePlayerControls()
        JValue.cleanPool("SlaveTats-synchronize_tattoos")
        return true
    endif

    if external_slots(target, "Body", external_on_body)
        Game.EnablePlayerControls()
        JValue.cleanPool("SlaveTats-synchronize_tattoos")
        return true
    endif

    if external_slots(target, "Face", external_on_face)
        Game.EnablePlayerControls()
        JValue.cleanPool("SlaveTats-synchronize_tattoos")
        return true
    endif

    if external_slots(target, "Hands", external_on_hands)
        Game.EnablePlayerControls()
        JValue.cleanPool("SlaveTats-synchronize_tattoos")
        return true
    endif

    if external_slots(target, "Feet", external_on_feet)
        Game.EnablePlayerControls()
        JValue.cleanPool("SlaveTats-synchronize_tattoos")
        return true
    endif

    ActorBase target_base = target.GetActorBase()
    bool isFemale = target_base.GetSex() as bool

    int on_body_count = JArray.count(on_body)
    int on_face_count = JArray.count(on_face)
    int on_hands_count = JArray.count(on_hands)
    int on_feet_count = JArray.count(on_feet)

    int external_on_body_count = JArray.count(external_on_body)
    int external_on_face_count = JArray.count(external_on_face)
    int external_on_hands_count = JArray.count(external_on_hands)
    int external_on_feet_count = JArray.count(external_on_feet)

    if on_body_count + on_face_count + on_hands_count + on_feet_count == 0
        deactivate_all_tattoo_magic(target)

        i = SLOTS("Body")
        while i > 0
            i -= 1

            if JArray.findInt(external_on_body, i) == -1
                clear_overlay(target, isFemale, "Body", i)
            endif
        endwhile

        i = SLOTS("Face")
        while i > 0
            i -= 1

            if JArray.findInt(external_on_face, i) == -1
                clear_overlay(target, isFemale, "Face", i)
            endif
        endwhile

        i = SLOTS("Hands")
        while i > 0
            i -= 1

            if JArray.findInt(external_on_hands, i) == -1
                clear_overlay(target, isFemale, "Hands", i)
            endif
        endwhile

        i = SLOTS("Feet")
        while i > 0
            i -= 1

            if JArray.findInt(external_on_feet, i) == -1
                clear_overlay(target, isFemale, "Feet", i)
            endif
        endwhile

        if external_on_body_count + external_on_face_count + external_on_hands_count + external_on_feet_count == 0
            NiOverride.RemoveOverlays(target)
            Utility.Wait(0.01)

            if (NiOverride.HasOverlays(target) == true) && (target != Game.GetPlayer())
                notify("SlaveTats: NPC Uninstallation failed.", silent)
                Game.EnablePlayerControls()
                JValue.cleanPool("SlaveTats-synchronize_tattoos")
                return true
            endif
        endif

        JFormDB.setEntry("SlaveTats", target, 0)

        notify("SlaveTats is done with " + target.GetLeveledActorBase().GetName() + ".", silent)
        Game.EnablePlayerControls()
        JValue.cleanPool("SlaveTats-synchronize_tattoos")
        return false
    endif

    int empty_body_slots = JValue.addToPool(JArray.object(), "SlaveTats-synchronize_tattoos")
    int empty_face_slots = JValue.addToPool(JArray.object(), "SlaveTats-synchronize_tattoos")
    int empty_hands_slots = JValue.addToPool(JArray.object(), "SlaveTats-synchronize_tattoos")
    int empty_feet_slots = JValue.addToPool(JArray.object(), "SlaveTats-synchronize_tattoos")

    i = SLOTS("Body")
    while i > 0
        i -= 1
        JArray.addInt(empty_body_slots, i)
    endwhile

    i = SLOTS("Face")
    while i > 0
        i -= 1
        JArray.addInt(empty_face_slots, i)
    endwhile

    i = SLOTS("Hands")
    while i > 0
        i -= 1
        JArray.addInt(empty_hands_slots, i)
    endwhile

    i = SLOTS("Feet")
    while i > 0
        i -= 1
        JArray.addInt(empty_feet_slots, i)
    endwhile

    int to_deactivate = JValue.addToPool(JArray.object(), "SlaveTats-synchronize_tattoos")
    int to_activate = JValue.addToPool(JArray.object(), "SlaveTats-synchronize_tattoos")

    int activated = JFormDB.getObj(target, ".SlaveTats.activated")
    if activated > 0
        JArray.addFromArray(to_deactivate, activated)
    endif

    i = on_body_count
    while i > 0
        i -= 1

        entry = JArray.getObj(on_body, i)
        if is_tattoo(entry)
            slot = JMap.getInt(entry, "slot")
            path = prefix + JMap.getStr(entry, "texture")
            color = JMap.getInt(entry, "color")
            glow = JMap.getInt(entry, "glow")
            gloss = JMap.getInt(entry, "gloss") as bool
            bump = JMap.getStr(entry, "bump")
            alpha = 1.0 - JMap.getFlt(entry, "invertedAlpha")
            if bump as bool
                bump = prefix + bump
            endif
            if JArray.findInt(external_on_body, slot) < 0
                if !apply_overlay(target, isFemale, "Body", slot, path, color, glow, gloss, bump, alpha)
                    JArray.addObj(to_activate, entry)
                    idx = JArray.findInt(empty_body_slots, slot)
                    if idx >= 0
                        JArray.eraseIndex(empty_body_slots, idx)
                    endif
                endif
            endif
        endif
    endwhile

    i = on_face_count
    while i > 0
        i -= 1

        entry = JArray.getObj(on_face, i)
        if is_tattoo(entry)
            slot = JMap.getInt(entry, "slot")
            path = prefix + JMap.getStr(entry, "texture")
            color = JMap.getInt(entry, "color")
            glow = JMap.getInt(entry, "glow")
            gloss = JMap.getInt(entry, "gloss") as bool
            bump = JMap.getStr(entry, "bump")
            alpha = 1.0 - JMap.getFlt(entry, "invertedAlpha")
            if JArray.findInt(external_on_face, slot) < 0
                if !apply_overlay(target, isFemale, "Face", slot, path, color, glow, gloss, bump, alpha)
                    JArray.addObj(to_activate, entry)
                    idx = JArray.findInt(empty_face_slots, slot)
                    if idx >= 0
                        JArray.eraseIndex(empty_face_slots, idx)
                    endif
                endif
            endif
        endif
    endwhile

    i = on_hands_count
    while i > 0
        i -= 1

        entry = JArray.getObj(on_hands, i)
        if is_tattoo(entry)
            slot = JMap.getInt(entry, "slot")
            path = prefix + JMap.getStr(entry, "texture")
            color = JMap.getInt(entry, "color")
            glow = JMap.getInt(entry, "glow")
            gloss = JMap.getInt(entry, "gloss") as bool
            bump = JMap.getStr(entry, "bump")
            alpha = 1.0 - JMap.getFlt(entry, "invertedAlpha")
            if JArray.findInt(external_on_hands, slot) < 0
                if !apply_overlay(target, isFemale, "Hands", slot, path, color, glow, gloss, bump, alpha)
                    JArray.addObj(to_activate, entry)
                    idx = JArray.findInt(empty_hands_slots, slot)
                    if idx >= 0
                        JArray.eraseIndex(empty_hands_slots, idx)
                    endif
                endif
            endif
        endif
    endwhile

    i = on_feet_count
    while i > 0
        i -= 1

        entry = JArray.getObj(on_feet, i)
        if is_tattoo(entry)
            slot = JMap.getInt(entry, "slot")
            path = prefix + JMap.getStr(entry, "texture")
            color = JMap.getInt(entry, "color")
            glow = JMap.getInt(entry, "glow")
            gloss = JMap.getInt(entry, "gloss") as bool
            bump = JMap.getStr(entry, "bump")
            alpha = 1.0 - JMap.getFlt(entry, "invertedAlpha")
            if JArray.findInt(external_on_feet, slot) < 0
                if !apply_overlay(target, isFemale, "Feet", slot, path, color, glow, gloss, bump, alpha)
                    JArray.addObj(to_activate, entry)
                    idx = JArray.findInt(empty_feet_slots, slot)
                    if idx >= 0
                        JArray.eraseIndex(empty_feet_slots, idx)
                    endif
                endif
            endif
        endif
    endwhile

    i = JArray.count(empty_body_slots)
    while i > 0
        i -= 1

        slot = JArray.getInt(empty_body_slots, i)
        if JArray.findInt(external_on_body, slot) < 0
            clear_overlay(target, isFemale, "Body", slot)
        endif
    endwhile

    i = JArray.count(empty_face_slots)
    while i > 0
        i -= 1

        slot = JArray.getInt(empty_face_slots, i)
        if JArray.findInt(external_on_face, slot) < 0
            clear_overlay(target, isFemale, "Face", slot)
        endif
    endwhile

    i = JArray.count(empty_hands_slots)
    while i > 0
        i -= 1

        slot = JArray.getInt(empty_hands_slots, i)
        if JArray.findInt(external_on_hands, slot) < 0
            clear_overlay(target, isFemale, "Hands", slot)
        endif
    endwhile

    i = JArray.count(empty_feet_slots)
    while i > 0
        i -= 1

        slot = JArray.getInt(empty_feet_slots, i)
        if JArray.findInt(external_on_feet, slot) < 0
            clear_overlay(target, isFemale, "Feet", slot)
        endif
    endwhile

    JFormDB.setInt(target, ".SlaveTats.updated", 0)

    i = JArray.count(to_deactivate)
    while i > 0
        i -= 1

        idx = JArray.findObj(to_activate, JArray.getObj(to_deactivate, i))
        if idx >= 0
            JArray.eraseIndex(to_activate, idx)
            JArray.eraseIndex(to_deactivate, i)
        endif
    endwhile

    ;Debug.Trace("SlaveTats: Tattoos to deactivate:")
    ;i = JArray.count(to_deactivate)
    ;while i > 0
    ;    i -= 1
    ;
    ;    entry = JArray.getObj(to_deactivate, i)
    ;    Debug.Trace("SlaveTats: " + entry + JMap.getStr(entry, "name"))
    ;endwhile

    ;Debug.Trace("SlaveTats: Tattoos to activate:")
    ;i = JArray.count(to_activate)
    ;idx = 0
    ;while idx < i
    ;    entry = JArray.getObj(to_activate, idx)
    ;    Debug.Trace("SlaveTats: " + entry + JMap.getStr(entry, "name"))
    ;
    ;    idx += 1
    ;endwhile

    int tattoo
    int evt

    i = JArray.count(to_deactivate)
    while i > 0
        i -= 1
        tattoo = JArray.getObj(to_deactivate, i)

        deactivate_tattoo_magic(target, tattoo)

        evt = ModEvent.Create("SlaveTats-removed")
        if evt
            ModEvent.PushString(evt, JMap.getStr(tattoo, "section"))
            ModEvent.PushString(evt, JMap.getStr(tattoo, "name"))
            ModEvent.PushForm(evt, target)
            ModEvent.Send(evt)
        endif
    endwhile

    i = JArray.count(to_activate)
    idx = 0
    while idx < i
        tattoo = JArray.getObj(to_activate, idx)

        activate_tattoo_magic(target, tattoo)

        evt = ModEvent.Create("SlaveTats-added")
        if evt
            ModEvent.PushString(evt, JMap.getStr(tattoo, "section"))
            ModEvent.PushString(evt, JMap.getStr(tattoo, "name"))
            ModEvent.PushForm(evt, target)
            ModEvent.Send(evt)
        endif

        idx += 1
    endwhile

    ; This song and dance is an attempt to force the engine to always display the overlays.
    ; Doesn't work well enough to justify the trouble it causes.
    ;target.Disable()
    ;Utility.Wait(0.01)
    ;target.Enable()

    Debug.Trace("SlaveTats: Synchronization complete.")
    notify("SlaveTats is done with " + target.GetLeveledActorBase().GetName() + ".", silent)
    Game.EnablePlayerControls()
    JValue.cleanPool("SlaveTats-synchronize_tattoos")
    return false
endfunction

function _log_jcontainer(int jc, string indent) global
    if jc == 0
        Debug.Trace("SlaveTats: " + indent + "null")
        return
    endif

    int i
    int max

    string mkey

    int type

    if JValue.isMap(jc)
        Debug.Trace("SlaveTats: " + indent + "{")

        int keys = JValue.addToPool(JMap.allKeys(jc), "SlaveTats-_log_jcontainer")
        max = JArray.count(keys)
        i = 0
        while i < max
            mkey = JArray.getStr(keys, i)
            type = JMap.valueType(jc, mkey)
            if type == 1
                Debug.Trace("SlaveTats: " + indent + "  \"" + mkey + "\": none")
            elseif type == 2
                Debug.Trace("SlaveTats: " + indent + "  \"" + mkey + "\": " + JMap.getInt(jc, mkey))
            elseif type == 3
                Debug.Trace("SlaveTats: " + indent + "  \"" + mkey + "\": " + JMap.getFlt(jc, mkey))
            elseif type == 6
                Debug.Trace("SlaveTats: " + indent + "  \"" + mkey + "\": \"" + JMap.getStr(jc, mkey) + "\"")
            elseif type == 5
                Debug.Trace("SlaveTats: " + indent + "  \"" + mkey + "\": Nested object")
                _log_jcontainer(JMap.getObj(jc, mkey), indent + "  ")
            elseif type == 4
                Debug.Trace("SlaveTats: " + indent + "  \"" + mkey + "\": Form " + JMap.getForm(jc, mkey).GetName())
            else
                Debug.Trace("SlaveTats: " + indent + "  \"" + mkey + "\": Unknown type")
            endif
            i += 1
        endwhile

        Debug.Trace("SlaveTats: " + indent + "}")
    elseif JValue.isArray(jc)
        Debug.Trace("SlaveTats: " + indent + "[")
        max = JArray.count(jc)
        i = 0
        while i < max
            type = JArray.valueType(jc, i)
            if type == 1
                Debug.Trace("SlaveTats: " + indent + "  none")
            elseif type == 2
                Debug.Trace("SlaveTats: " + indent + "  " + JArray.getInt(jc, i))
            elseif type == 3
                Debug.Trace("SlaveTats: " + indent + "  " + JArray.getFlt(jc, i))
            elseif type == 6
                Debug.Trace("SlaveTats: " + indent + "  \"" + JArray.getStr(jc, i) + "\"")
            elseif type == 5
                Debug.Trace("SlaveTats: " + indent + "  Nested object ")
                _log_jcontainer(JArray.getObj(jc, i), indent + "  ")
            elseif type == 4
                Debug.Trace("SlaveTats: " + indent + "  Form " + JArray.getForm(jc, i).GetName())
            else
                Debug.Trace("SlaveTats: " + indent + "  Unknown type")
            endif
            i += 1
        endwhile
        Debug.Trace("SlaveTats: " + indent + "]")
    else
        Debug.Trace("SlaveTats: " + indent + "Not a map or an array.")
    endif

    JValue.cleanPool("SlaveTats-_log_jcontainer")
endfunction

; Dumps a tattoo to the log, with as much detail as is feasible
function log_tattoo(string msg, int tattoo) global
    Debug.Trace("SlaveTats: " + msg + " (tattoo = " + tattoo + ")")
    if tattoo == 0
        return
    endif
    _log_jcontainer(tattoo, "")
endfunction
