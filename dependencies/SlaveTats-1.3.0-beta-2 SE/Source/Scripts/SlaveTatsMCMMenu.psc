scriptname SlaveTatsMCMMenu extends SKI_ConfigBase

SlaveTatsOnload property st_extra auto

int targets
Actor target
int sections = 0
int tattoos = 0

int needs_synch = 0

string[] target_menu_items
string[] section_menu_items
string[] tattoo_menu_items
string[] section_menu_current
int[] tattoo_menu_current

Form[] hair_colors
string[] hair_color_names
int num_hair_colors

string function VERSION() global
    return "1.0.0" ; This is the data structure version, not the release number that's shown to users
endfunction

int function GetVersion()
    return 4 ; This is the code version, for MCM. Also not the release number that's shown to users
endfunction

string function AREA(string page) global
    if page == "Body Tattoos"
        return "Body"
    elseif page == "Face Tattoos"
        return "Face"
    elseif page == "Hand Tattoos"
        return "Hands"
    elseif page == "Foot Tattoos"
        return "Feet"
    endif

    return ""
endfunction

bool function _setup_sections(string area, int slot)
    int query = JValue.addToPool(JMap.object(), "SlaveTats-_setup_sections")
    int matches = JValue.addToPool(JArray.object(), "SlaveTats-_setup_sections")
    int entry

    int applied = JValue.addToPool(JArray.object(), "SlaveTats-_setup_sections")
    if SlaveTats.query_applied_tattoos(target, 0, applied, area, slot)
        JValue.cleanPool("SlaveTats-_setup_sections")
        return true
    endif

    JMap.setStr(query, "area", area)
    if SlaveTats.query_available_tattoos(query, matches, applied)
        JValue.cleanPool("SlaveTats-_setup_sections")
        return true
    endif

    tattoos = JValue.releaseAndRetain(tattoos, JMap.object())

    JMap.setObj(tattoos, "[No Tattoo]", JValue.objectFromPrototype("[{\"name\":\"[No Tattoo]\", \"section\":\"[No Tattoo]\", \"area\":\"" + area + "\"}]"))

    int i = JArray.count(matches)
    while i > 0
        i -= 1

        entry = JArray.getObj(matches, i)

        JMap.removeKey(entry, "slot") ; The menu does not respect tattoo pre-specified slots. That's for mods.

        int section = JMap.getObj(tattoos, JMap.getStr(entry, "section"))
        if section == 0
            section = JValue.addToPool(JArray.object(), "SlaveTats-_setup_sections")
            JMap.setObj(tattoos, JMap.getStr(entry, "section"), section)
        endif
        JArray.addObj(section, entry)
    endwhile

    sections = JValue.releaseAndRetain(sections, JMap.allKeys(tattoos))

    int num_sections = JArray.count(sections)
    if num_sections > 127
        num_sections = 127
    endif

    section_menu_items = Utility.CreateStringArray(num_sections)
    i = 0
    while i < num_sections
        section_menu_items[i] = JArray.getStr(sections, i)
        i += 1
    endwhile

    JValue.cleanPool("SlaveTats-_setup_sections")

    return false
endfunction

bool function _setup_tattoos(string section)
    int tats = JMap.getObj(tattoos, section)
    if tats == 0
        return true
    endif

    int num_tats = JArray.count(tats)
    if num_tats > 127
        num_tats = 127
    endif

    tattoo_menu_items = Utility.CreateStringArray(num_tats)
    int i = 0
    while i < num_tats
        int entry = JArray.getObj(tats, i)
        tattoo_menu_items[i] = JMap.getStr(entry, "name")
        i += 1
    endwhile

    return false
endfunction

function cleanup()
    int i = JArray.count(targets)
    while i > 0
        i -= 1
        Actor who = JArray.getForm(targets, i) as Actor
        SlaveTats.remove_tattoos(who, 0, True)
        SlaveTats.synchronize_tattoos(who)
    endwhile

    JDB.setObj("SlaveTats", 0)
    JDB.setObj("SlaveTatsMenu", 0)

    JValue.cleanPool("SlaveTats-_setup_sections")
    JValue.cleanPool("SlaveTats-OnConfigOpen")
    JValue.cleanPool("SlaveTats-OnConfigClose")
endfunction

event OnVersionUpdate(int version)

endevent

event OnConfigOpen()
    if !JContainers.isInstalled()
        ShowMessage("Warning: This version of SlaveTats uses version 3 or greater of the JContainers API. You do not have JContainers installed.", false)
        return
    endif

    if JContainers.APIVersion() < 3
        ShowMessage("Warning: This version of SlaveTats uses version 3 or greater of the JContainers API. You have a different version installed.", false)
        return
    endif

    Pages = new string[6]

    Pages[0] = "Setup"
    Pages[1] = "Body Tattoos"
    Pages[2] = "Face Tattoos"
    Pages[3] = "Hand Tattoos"
    Pages[4] = "Foot Tattoos"
    Pages[5] = "Extra"

    needs_synch = JValue.addToPool(JFormMap.object(), "SlaveTats-OnConfigClose")

    target = Game.GetPlayer()

    string old_version = JDB.solveStr(".SlaveTatsMenu.version")
    if old_version != VERSION()
        Debug.Trace("SlaveTats Menu: Initializing the menu data structures, version " + VERSION())
        int config = JValue.addToPool(JMap.object(), "SlaveTats-OnConfigOpen")
        JMap.setStr(config, "version", VERSION())
        JMap.setObj(config, "known_targets", JArray.object())
        JMap.setForm(config, "last_target", target)
        JDB.setObj("SlaveTatsMenu", config)
        JArray.addForm(JDB.solveObj(".SlaveTatsMenu.known_targets"), target)

        Debug.Trace("SlaveTats Menu: Setting up player character")
        SlaveTats.upgrade_tattoos(target)
        JFormMap.setInt(needs_synch, target, 1)
    endif

    int known = JDB.solveObj(".SlaveTatsMenu.known_targets")
    if known == 0
        Debug.Trace("SlaveTats Menu: The list of known targets is null! Re-initializing it.")

        known = JValue.addToPool(JArray.object(), "SlaveTats-OnConfigOpen")
        JDB.solveObjSetter(".SlaveTatsMenu.known_targets", known)

        JArray.addForm(known, target)
    endif

    bool player_in_known = false

    int i = JArray.count(known)
    while i > 0
        i -= 1

        Actor previously_known = JArray.getForm(known, i) as Actor
        if previously_known == None
            JArray.eraseIndex(known, i)
        elseif previously_known == target
            player_in_known = True
        endif
    endwhile

    Debug.Trace("SlaveTats Menu: There are currently " + JArray.count(known) + " known targets.")

    if !player_in_known
        Debug.Trace("SlaveTats Menu: The player was not in the known list. Adding.")
        JArray.addForm(known, target)
    endif

    targets = JValue.addToPool(JArray.object(), "SlaveTats-OnConfigClose")
    JArray.addFromArray(targets, JDB.solveObj(".SlaveTatsMenu.known_targets"))

    target = JDB.solveForm(".SlaveTatsMenu.last_target") as Actor

    if target == None
        Debug.Trace("SlaveTats Menu: .SlaveTatsMenu.last_target is null. Falling back targets[0]")
        target = JArray.getForm(targets, 0) as Actor
        if target == None
            Debug.Trace("SlaveTats Menu: targets[0] is null. Falling back on Game.GetPlayer()")
            target = Game.GetPlayer()
            JArray.addForm(targets, target)
        endif
    endif

    Debug.Trace("SlaveTats Menu: The default target is " + target.GetLeveledActorBase().GetName())

    Actor player = Game.GetPlayer()
    Actor temp_target
    int loop_count = 12
    while loop_count > 0
        loop_count -= 1
        temp_target = Game.FindRandomActorFromRef(player, 300.0)
        if JArray.findForm(targets, temp_target) < 0
            JArray.addForm(targets, temp_target)
            Debug.Trace("SlaveTats Menu: Found nearby actor " + temp_target.GetLeveledActorBase().GetName())
        endif
    endwhile

    loop_count = JArray.count(targets)

    if loop_count > 127
        loop_count = 127
    endif

    Debug.Trace("SlaveTats Menu: Setting up target selection choices.")
    target_menu_items = Utility.CreateStringArray(loop_count)

    while loop_count > 0
        loop_count -= 1
        target_menu_items[loop_count] = (JArray.getForm(targets, loop_count) as Actor).GetLeveledActorBase().GetName()
    endwhile
    
    FormList HairColorList = Game.GetFormFromFile(0xE7BED, "Skyrim.esm") as FormList
    FormList SlaveTatsHairColors = Game.GetFormFromFile(0x6774, "SlaveTats.esp") as FormList
    
    int offset = 1
    num_hair_colors = offset + HairColorList.GetSize() + SlaveTatsHairColors.GetSize()
    hair_colors = Utility.CreateFormArray(num_hair_colors)
    hair_color_names = Utility.CreateStringArray(num_hair_colors)
    
    hair_color_names[0] = "[No change]"
    
    loop_count = SlaveTatsHairColors.GetSize()
    while loop_count > 0
        loop_count -= 1
        hair_colors[offset + loop_count] = SlaveTatsHairColors.GetAt(loop_count)
        hair_color_names[offset + loop_count] = hair_colors[offset + loop_count].GetName()
    endwhile
    
    offset = 1 + SlaveTatsHairColors.GetSize()
    
    loop_count = HairColorList.GetSize()
    while loop_count > 0
        loop_count -= 1
        hair_colors[offset + loop_count] = HairColorList.GetAt(loop_count)
        hair_color_names[offset + loop_count] = hair_colors[offset + loop_count].GetName()
    endwhile
    
    JValue.cleanPool("SlaveTats-OnConfigOpen")
endevent

function apply_to_target()
    if target != None
        st_extra.apply_customizations()

        Debug.Trace("SlaveTats Menu: Leaving target " + target.GetLeveledActorBase().GetName() + ". Queueing synchronization.")
        JDB.solveFormSetter(".SlaveTatsMenu.last_target", target)

        int known = JDB.solveObj(".SlaveTatsMenu.known_targets")
        if JArray.findForm(known, target) < 0
            JArray.addForm(known, target)
        endif

        JFormMap.setInt(needs_synch, target, 1)
    endif
endfunction

event OnConfigClose()
    apply_to_target()

    int keys = JValue.addToPool(JFormMap.allKeys(needs_synch), "SlaveTats-OnConfigClose")
    int i = JArray.count(keys)
    while i > 0
        i -= 1
        SlaveTats.synchronize_tattoos(JArray.getForm(keys, i) as Actor)
    endwhile

    JValue.cleanPool("SlaveTats-OnConfigClose")
    JValue.release(sections)
    JValue.release(tattoos)
endevent

event OnPageReset(string page)
    string area = AREA(page)

    if page == ""

    elseif page == "Setup"
        AddMenuOptionST("TARGET", "Target", target.GetLeveledActorBase().GetName())
    elseif page == "Extra"
        if target == Game.GetPlayer()
            AddHeaderOption("This tab is for NPC targets")
            AddHeaderOption("Use showracemenu on the console")
        else
            AddInputOptionST("NAME", "Name", target.GetLeveledActorBase().GetName())
            AddMenuOptionST("HAIRCOLOR", "Hair Color", "[No change]")
            AddSliderOptionST("WEIGHT", "Weight", target.GetActorBase().GetWeight())
        endif
    else
        SetCursorFillMode(LEFT_TO_RIGHT)

        AddHeaderOption(area + " Patterns")
        AddHeaderOption(area + " Colors")

        int external = JValue.addToPool(JArray.object(), "SlaveTats-OnPageReset")
        SlaveTats.external_slots(target, area, external)

        section_menu_current = new string[12]
        tattoo_menu_current = new int[12]

        int slots = SlaveTats.SLOTS(area)
        if slots > 12
            slots = 12
        endif

        int slot = 0
        while slot < slots
            if JArray.findInt(external, slot) >= 0
                section_menu_current[slot] = "External"
                tattoo_menu_current[slot] = 0
                AddMenuOptionST("SECTION_SLOT" + slot, "Section " + (slot + 1), "External", OPTION_FLAG_DISABLED)
                AddColorOptionST("COLOR_SLOT" + slot, "Ink " + (slot + 1), 0, OPTION_FLAG_DISABLED)
                AddMenuOptionST("TATTOO_SLOT" + slot, "Pattern " + (slot + 1), "External", OPTION_FLAG_DISABLED)
                AddColorOptionST("GLOW_SLOT" + slot, "Glow " + (slot + 1), 0, OPTION_FLAG_DISABLED)
                AddEmptyOption()
                AddToggleOptionST("GLOSS_SLOT" + slot, "Glossy " + (slot + 1), false, OPTION_FLAG_DISABLED)
            else
                int entry = SlaveTats.get_applied_tattoo_in_slot(target, area, slot)
                if entry == 0
                    section_menu_current[slot] = "[No Tattoo]"
                    tattoo_menu_current[slot] = 0
                    AddMenuOptionST("SECTION_SLOT" + slot, "Section " + (slot + 1), "[No Tattoo]")
                    AddColorOptionST("COLOR_SLOT" + slot, "Ink " + (slot + 1), 0)
                    AddMenuOptionST("TATTOO_SLOT" + slot, "Pattern " + (slot + 1), "[No Tattoo]")
                    AddColorOptionST("GLOW_SLOT" + slot, "Glow " + (slot + 1), 0)
                    AddEmptyOption()
                    AddToggleOptionST("GLOSS_SLOT" + slot, "Glossy " + (slot + 1), false)
                else
                    int flag = 0
                    if JMap.getInt(entry, "locked") > 0
                        flag = OPTION_FLAG_DISABLED
                    endif

                    section_menu_current[slot] = JMap.getStr(entry, "section")
                    tattoo_menu_current[slot] = entry

                    AddMenuOptionST("SECTION_SLOT" + slot, "Section " + (slot + 1), JMap.getStr(entry, "section"), flag)
                    AddColorOptionST("COLOR_SLOT" + slot, "Ink " + (slot + 1), JMap.getInt(entry, "color"), flag)
                    AddMenuOptionST("TATTOO_SLOT" + slot, "Pattern " + (slot + 1), JMap.getStr(entry, "name"), flag)
                    AddColorOptionST("GLOW_SLOT" + slot, "Glow " + (slot + 1), JMap.getInt(entry, "glow"), flag)
                    AddEmptyOption()
                    AddToggleOptionST("GLOSS_SLOT" + slot, "Glossy " + (slot + 1), JMap.getInt(entry, "gloss") as bool, flag)
                endif
            endif
            slot += 1
        endwhile
    endif
    
    JValue.cleanPool("SlaveTats-OnPageReset")
 endevent

state TARGET
    event OnMenuOpenST()
        SetMenuDialogStartIndex(JArray.findForm(targets, target))
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(target_menu_items)
    endevent

    event OnMenuAcceptST(int index)
        apply_to_target()
        target = JArray.getForm(targets, index) as Actor
        SetMenuOptionValueST(target_menu_items[index])
        SlaveTats.upgrade_tattoos(target)
    endevent

    event OnDefaultST()
        target = JArray.getForm(targets, 0) as Actor
        SetMenuOptionValueST(target_menu_items[0])
    endevent

    event OnHighlightST()
        SetInfoText("Select the person to modify. This list will always contain the player character. Any character you have tattooed will appear here as well. Finally, nearby characters will be added to the list.")
    endevent
endstate

state NAME
    event OnInputAcceptST(string value)
        SetInputOptionValueST(value)
        JMap.setStr(st_extra._actor_extra(target), "name", value)
        st_extra._requires_update_on_load(target)
    endevent
    
    event OnHighlightST()
        SetInfoText("Mods that change how followers work can interfere with this. If the name doesn't change, or the change doesn't stick, that's probably why.")
    endevent
endstate

state HAIRCOLOR
    event OnMenuOpenST()
        SetMenuDialogStartIndex(0)
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(hair_color_names)
    endevent
    
    event OnMenuAcceptST(int index)
        if index > 0
            SetMenuOptionValueST(hair_color_names[index])
            ColorForm selected = hair_colors[index] as ColorForm
            JMap.setForm(st_extra._actor_extra(target), "hair_color", selected)
            st_extra._requires_update_on_load(target)
        endif
    endevent
endstate

state WEIGHT
    event OnSliderOpenST()
        SetSliderDialogRange(0, 100)
        SetSliderDialogStartValue(target.GetActorBase().GetWeight())
        SetSliderDialogDefaultValue(50)
        SetSliderDialogInterval(1)
    endevent

    event OnSliderAcceptST(float value)
        SetSliderOptionValueST(value)
        JMap.setFlt(st_extra._actor_extra(target), "weight", value)
        st_extra._requires_update_on_load(target)
    endevent
endstate

state SECTION_SLOT0
    event OnMenuOpenST()
        int slot = 0
        _setup_sections(AREA(CurrentPage), slot)
        SetMenuDialogStartIndex(section_menu_items.Find(section_menu_current[slot]))
        SetMenuDialogDefaultIndex(section_menu_items.Find("[No Tattoo]"))
        SetMenuDialogOptions(section_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 0
        ; _setup_sections(CurrentPage) ; Not necessary, since OnMenuOpenST immediately precedes it
        if index < 0
            section_menu_current[slot] = "[No Tattoo]"
            SetMenuOptionValueST("[No Tattoo]")
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]", false, "TATTOO_SLOT" + slot)
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        elseif section_menu_current[slot] != section_menu_items[index]
            section_menu_current[slot] = section_menu_items[index]
            SetMenuOptionValueST(section_menu_current[slot])
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), 0)
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"), false, "TATTOO_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 0
        section_menu_current[slot] = "[No Tattoo]"
        SetMenuOptionValueST("[No Tattoo]")
    endEvent

    event OnHighlightST()
        int slot = 0
        SetInfoText("Pick a tattoo collection to select your tattoo from. To remove a tattoo, select [No Tattoo] from the section menu.")
    endEvent
endstate

state TATTOO_SLOT0
    event OnMenuOpenST()
        int slot = 0
        _setup_sections(AREA(CurrentPage), slot)
        _setup_tattoos(section_menu_current[slot])
        if tattoo_menu_current[slot] == 0
            SetMenuDialogStartIndex(0)
        else
            SetMenuDialogStartIndex(tattoo_menu_items.Find(JMap.getStr(tattoo_menu_current[slot], "name")))
        endif
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(tattoo_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 0

        if index == -1 || tattoo_menu_items[index] == "[No Tattoo]"
            Debug.Trace("SlaveTats Menu: Emptying slot " + slot)
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]")
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        else
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), index)
            Debug.Trace("SlaveTats Menu: Setting slot " + slot + " to " + JMap.getStr(entry, "name"))
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    Debug.Trace("SlaveTats Menu: Succeeded")
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"))
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 0
        int entry = JArray.getObj(tattoos, 0)
        if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
            entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
            if entry != 0
                tattoo_menu_current[slot] = entry
                SetMenuOptionValueST(JMap.getStr(entry, "name"))
            endif
        endif
    endEvent

    event OnHighlightST()
        int slot = 0
        int entry = tattoo_menu_current[slot]
        string credit = JMap.getStr(entry, "credit")
        if credit
            SetInfoText("Tattoo by: " + credit)
        endif
    endEvent
endstate

state COLOR_SLOT0
    event OnColorOpenST()
        int slot = 0
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "color"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 0
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != color
            JMap.setInt(entry, "color", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 0
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != 0
            JMap.setInt(entry, "color", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 0
        SetInfoText("Pick the ink color for this tattoo.")
    endEvent
endstate

state GLOW_SLOT0
    event OnColorOpenST()
        int slot = 0
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "glow"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 0
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != color
            JMap.setInt(entry, "glow", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 0
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != 0
            JMap.setInt(entry, "glow", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 0
        SetInfoText("Pick a color for the tattoo to glow (black is no glow).")
    endEvent
endstate

state GLOSS_SLOT0
    event OnSelectST()
        int slot = 0
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "gloss") > 0
            JMap.setInt(entry, "gloss", 0)
            SetToggleOptionValueST(false)
        else
            JMap.setInt(entry, "gloss", 1)
            SetToggleOptionValueST(true)
        endif
        SlaveTats.mark_actor(target)
    endEvent

    event OnDefaultST()
        int slot = 0
        int entry = tattoo_menu_current[slot]
        JMap.setInt(entry, "gloss", 0)
        SetToggleOptionValueST(false)
        SlaveTats.mark_actor(target)
    endEvent

    event OnHighlightST()
        int slot = 0
        SetInfoText("Checking this makes the tattoo slightly glossy, like skin.")
    endEvent
endstate

; From here down are copy-and-pasted duplicates of the above SLOT0 states. The only
; difference is the number at the end of the slot name, and the number assigned to
; the slot variable. This is ugly, but a necessary consequence of the way Papyrus states work

state SECTION_SLOT1
    event OnMenuOpenST()
        int slot = 1
        _setup_sections(AREA(CurrentPage), slot)
        SetMenuDialogStartIndex(section_menu_items.Find(section_menu_current[slot]))
        SetMenuDialogDefaultIndex(section_menu_items.Find("[No Tattoo]"))
        SetMenuDialogOptions(section_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 1
        ; _setup_sections(CurrentPage) ; Not necessary, since OnMenuOpenST immediately precedes it
        if index < 0
            section_menu_current[slot] = "[No Tattoo]"
            SetMenuOptionValueST("[No Tattoo]")
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]", false, "TATTOO_SLOT" + slot)
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        elseif section_menu_current[slot] != section_menu_items[index]
            section_menu_current[slot] = section_menu_items[index]
            SetMenuOptionValueST(section_menu_current[slot])
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), 0)
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"), false, "TATTOO_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 1
        section_menu_current[slot] = "[No Tattoo]"
        SetMenuOptionValueST("[No Tattoo]")
    endEvent

    event OnHighlightST()
        int slot = 1
        SetInfoText("Pick a tattoo collection to select your tattoo from. To remove a tattoo, select [No Tattoo] from the section menu.")
    endEvent
endstate

state TATTOO_SLOT1
    event OnMenuOpenST()
        int slot = 1
        _setup_sections(AREA(CurrentPage), slot)
        _setup_tattoos(section_menu_current[slot])
        if tattoo_menu_current[slot] == 0
            SetMenuDialogStartIndex(0)
        else
            SetMenuDialogStartIndex(tattoo_menu_items.Find(JMap.getStr(tattoo_menu_current[slot], "name")))
        endif
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(tattoo_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 1

        if index == -1 || tattoo_menu_items[index] == "[No Tattoo]"
            Debug.Trace("SlaveTats Menu: Emptying slot " + slot)
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]")
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        else
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), index)
            Debug.Trace("SlaveTats Menu: Setting slot " + slot + " to " + JMap.getStr(entry, "name"))
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    Debug.Trace("SlaveTats Menu: Succeeded")
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"))
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 1
        int entry = JArray.getObj(tattoos, 0)
        if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
            entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
            if entry != 0
                tattoo_menu_current[slot] = entry
                SetMenuOptionValueST(JMap.getStr(entry, "name"))
            endif
        endif
    endEvent

    event OnHighlightST()
        int slot = 1
        int entry = tattoo_menu_current[slot]
        string credit = JMap.getStr(entry, "credit")
        if credit
            SetInfoText("Tattoo by: " + credit)
        endif
    endEvent
endstate

state COLOR_SLOT1
    event OnColorOpenST()
        int slot = 1
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "color"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 1
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != color
            JMap.setInt(entry, "color", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 1
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != 0
            JMap.setInt(entry, "color", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 1
        SetInfoText("Pick the ink color for this tattoo.")
    endEvent
endstate

state GLOW_SLOT1
    event OnColorOpenST()
        int slot = 1
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "glow"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 1
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != color
            JMap.setInt(entry, "glow", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 1
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != 0
            JMap.setInt(entry, "glow", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 1
        SetInfoText("Pick a color for the tattoo to glow (black is no glow).")
    endEvent
endstate

state GLOSS_SLOT1
    event OnSelectST()
        int slot = 1
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "gloss") > 0
            JMap.setInt(entry, "gloss", 0)
            SetToggleOptionValueST(false)
        else
            JMap.setInt(entry, "gloss", 1)
            SetToggleOptionValueST(true)
        endif
        SlaveTats.mark_actor(target)
    endEvent

    event OnDefaultST()
        int slot = 1
        int entry = tattoo_menu_current[slot]
        JMap.setInt(entry, "gloss", 0)
        SetToggleOptionValueST(false)
        SlaveTats.mark_actor(target)
    endEvent

    event OnHighlightST()
        int slot = 1
        SetInfoText("Checking this makes the tattoo slightly glossy, like skin.")
    endEvent
endstate

state SECTION_SLOT2
    event OnMenuOpenST()
        int slot = 2
        _setup_sections(AREA(CurrentPage), slot)
        SetMenuDialogStartIndex(section_menu_items.Find(section_menu_current[slot]))
        SetMenuDialogDefaultIndex(section_menu_items.Find("[No Tattoo]"))
        SetMenuDialogOptions(section_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 2
        ; _setup_sections(CurrentPage) ; Not necessary, since OnMenuOpenST immediately precedes it
        if index < 0
            section_menu_current[slot] = "[No Tattoo]"
            SetMenuOptionValueST("[No Tattoo]")
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]", false, "TATTOO_SLOT" + slot)
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        elseif section_menu_current[slot] != section_menu_items[index]
            section_menu_current[slot] = section_menu_items[index]
            SetMenuOptionValueST(section_menu_current[slot])
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), 0)
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"), false, "TATTOO_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 2
        section_menu_current[slot] = "[No Tattoo]"
        SetMenuOptionValueST("[No Tattoo]")
    endEvent

    event OnHighlightST()
        int slot = 2
        SetInfoText("Pick a tattoo collection to select your tattoo from. To remove a tattoo, select [No Tattoo] from the section menu.")
    endEvent
endstate

state TATTOO_SLOT2
    event OnMenuOpenST()
        int slot = 2
        _setup_sections(AREA(CurrentPage), slot)
        _setup_tattoos(section_menu_current[slot])
        if tattoo_menu_current[slot] == 0
            SetMenuDialogStartIndex(0)
        else
            SetMenuDialogStartIndex(tattoo_menu_items.Find(JMap.getStr(tattoo_menu_current[slot], "name")))
        endif
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(tattoo_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 2

        if index == -1 || tattoo_menu_items[index] == "[No Tattoo]"
            Debug.Trace("SlaveTats Menu: Emptying slot " + slot)
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]")
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        else
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), index)
            Debug.Trace("SlaveTats Menu: Setting slot " + slot + " to " + JMap.getStr(entry, "name"))
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    Debug.Trace("SlaveTats Menu: Succeeded")
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"))
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 2
        int entry = JArray.getObj(tattoos, 0)
        if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
            entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
            if entry != 0
                tattoo_menu_current[slot] = entry
                SetMenuOptionValueST(JMap.getStr(entry, "name"))
            endif
        endif
    endEvent

    event OnHighlightST()
        int slot = 2
        int entry = tattoo_menu_current[slot]
        string credit = JMap.getStr(entry, "credit")
        if credit
            SetInfoText("Tattoo by: " + credit)
        endif
    endEvent
endstate

state COLOR_SLOT2
    event OnColorOpenST()
        int slot = 2
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "color"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 2
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != color
            JMap.setInt(entry, "color", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 2
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != 0
            JMap.setInt(entry, "color", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 2
        SetInfoText("Pick the ink color for this tattoo.")
    endEvent
endstate

state GLOW_SLOT2
    event OnColorOpenST()
        int slot = 2
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "glow"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 2
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != color
            JMap.setInt(entry, "glow", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 2
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != 0
            JMap.setInt(entry, "glow", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 2
        SetInfoText("Pick a color for the tattoo to glow (black is no glow).")
    endEvent
endstate

state GLOSS_SLOT2
    event OnSelectST()
        int slot = 2
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "gloss") > 0
            JMap.setInt(entry, "gloss", 0)
            SetToggleOptionValueST(false)
        else
            JMap.setInt(entry, "gloss", 1)
            SetToggleOptionValueST(true)
        endif
        SlaveTats.mark_actor(target)
    endEvent

    event OnDefaultST()
        int slot = 2
        int entry = tattoo_menu_current[slot]
        JMap.setInt(entry, "gloss", 0)
        SetToggleOptionValueST(false)
        SlaveTats.mark_actor(target)
    endEvent

    event OnHighlightST()
        int slot = 2
        SetInfoText("Checking this makes the tattoo slightly glossy, like skin.")
    endEvent
endstate

state SECTION_SLOT3
    event OnMenuOpenST()
        int slot = 3
        _setup_sections(AREA(CurrentPage), slot)
        SetMenuDialogStartIndex(section_menu_items.Find(section_menu_current[slot]))
        SetMenuDialogDefaultIndex(section_menu_items.Find("[No Tattoo]"))
        SetMenuDialogOptions(section_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 3
        ; _setup_sections(CurrentPage) ; Not necessary, since OnMenuOpenST immediately precedes it
        if index < 0
            section_menu_current[slot] = "[No Tattoo]"
            SetMenuOptionValueST("[No Tattoo]")
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]", false, "TATTOO_SLOT" + slot)
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        elseif section_menu_current[slot] != section_menu_items[index]
            section_menu_current[slot] = section_menu_items[index]
            SetMenuOptionValueST(section_menu_current[slot])
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), 0)
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"), false, "TATTOO_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 3
        section_menu_current[slot] = "[No Tattoo]"
        SetMenuOptionValueST("[No Tattoo]")
    endEvent

    event OnHighlightST()
        int slot = 3
        SetInfoText("Pick a tattoo collection to select your tattoo from. To remove a tattoo, select [No Tattoo] from the section menu.")
    endEvent
endstate

state TATTOO_SLOT3
    event OnMenuOpenST()
        int slot = 3
        _setup_sections(AREA(CurrentPage), slot)
        _setup_tattoos(section_menu_current[slot])
        if tattoo_menu_current[slot] == 0
            SetMenuDialogStartIndex(0)
        else
            SetMenuDialogStartIndex(tattoo_menu_items.Find(JMap.getStr(tattoo_menu_current[slot], "name")))
        endif
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(tattoo_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 3

        if index == -1 || tattoo_menu_items[index] == "[No Tattoo]"
            Debug.Trace("SlaveTats Menu: Emptying slot " + slot)
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]")
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        else
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), index)
            Debug.Trace("SlaveTats Menu: Setting slot " + slot + " to " + JMap.getStr(entry, "name"))
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    Debug.Trace("SlaveTats Menu: Succeeded")
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"))
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 3
        int entry = JArray.getObj(tattoos, 0)
        if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
            entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
            if entry != 0
                tattoo_menu_current[slot] = entry
                SetMenuOptionValueST(JMap.getStr(entry, "name"))
            endif
        endif
    endEvent

    event OnHighlightST()
        int slot = 3
        int entry = tattoo_menu_current[slot]
        string credit = JMap.getStr(entry, "credit")
        if credit
            SetInfoText("Tattoo by: " + credit)
        endif
    endEvent
endstate

state COLOR_SLOT3
    event OnColorOpenST()
        int slot = 3
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "color"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 3
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != color
            JMap.setInt(entry, "color", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 3
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != 0
            JMap.setInt(entry, "color", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 3
        SetInfoText("Pick the ink color for this tattoo.")
    endEvent
endstate

state GLOW_SLOT3
    event OnColorOpenST()
        int slot = 3
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "glow"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 3
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != color
            JMap.setInt(entry, "glow", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 3
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != 0
            JMap.setInt(entry, "glow", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 3
        SetInfoText("Pick a color for the tattoo to glow (black is no glow).")
    endEvent
endstate

state GLOSS_SLOT3
    event OnSelectST()
        int slot = 3
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "gloss") > 0
            JMap.setInt(entry, "gloss", 0)
            SetToggleOptionValueST(false)
        else
            JMap.setInt(entry, "gloss", 1)
            SetToggleOptionValueST(true)
        endif
        SlaveTats.mark_actor(target)
    endEvent

    event OnDefaultST()
        int slot = 3
        int entry = tattoo_menu_current[slot]
        JMap.setInt(entry, "gloss", 0)
        SetToggleOptionValueST(false)
        SlaveTats.mark_actor(target)
    endEvent

    event OnHighlightST()
        int slot = 3
        SetInfoText("Checking this makes the tattoo slightly glossy, like skin.")
    endEvent
endstate

state SECTION_SLOT4
    event OnMenuOpenST()
        int slot = 4
        _setup_sections(AREA(CurrentPage), slot)
        SetMenuDialogStartIndex(section_menu_items.Find(section_menu_current[slot]))
        SetMenuDialogDefaultIndex(section_menu_items.Find("[No Tattoo]"))
        SetMenuDialogOptions(section_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 4
        ; _setup_sections(CurrentPage) ; Not necessary, since OnMenuOpenST immediately precedes it
        if index < 0
            section_menu_current[slot] = "[No Tattoo]"
            SetMenuOptionValueST("[No Tattoo]")
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]", false, "TATTOO_SLOT" + slot)
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        elseif section_menu_current[slot] != section_menu_items[index]
            section_menu_current[slot] = section_menu_items[index]
            SetMenuOptionValueST(section_menu_current[slot])
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), 0)
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"), false, "TATTOO_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 4
        section_menu_current[slot] = "[No Tattoo]"
        SetMenuOptionValueST("[No Tattoo]")
    endEvent

    event OnHighlightST()
        int slot = 4
        SetInfoText("Pick a tattoo collection to select your tattoo from. To remove a tattoo, select [No Tattoo] from the section menu.")
    endEvent
endstate

state TATTOO_SLOT4
    event OnMenuOpenST()
        int slot = 4
        _setup_sections(AREA(CurrentPage), slot)
        _setup_tattoos(section_menu_current[slot])
        if tattoo_menu_current[slot] == 0
            SetMenuDialogStartIndex(0)
        else
            SetMenuDialogStartIndex(tattoo_menu_items.Find(JMap.getStr(tattoo_menu_current[slot], "name")))
        endif
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(tattoo_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 4

        if index == -1 || tattoo_menu_items[index] == "[No Tattoo]"
            Debug.Trace("SlaveTats Menu: Emptying slot " + slot)
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]")
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        else
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), index)
            Debug.Trace("SlaveTats Menu: Setting slot " + slot + " to " + JMap.getStr(entry, "name"))
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    Debug.Trace("SlaveTats Menu: Succeeded")
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"))
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 4
        int entry = JArray.getObj(tattoos, 0)
        if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
            entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
            if entry != 0
                tattoo_menu_current[slot] = entry
                SetMenuOptionValueST(JMap.getStr(entry, "name"))
            endif
        endif
    endEvent

    event OnHighlightST()
        int slot = 4
        int entry = tattoo_menu_current[slot]
        string credit = JMap.getStr(entry, "credit")
        if credit
            SetInfoText("Tattoo by: " + credit)
        endif
    endEvent
endstate

state COLOR_SLOT4
    event OnColorOpenST()
        int slot = 4
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "color"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 4
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != color
            JMap.setInt(entry, "color", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 4
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != 0
            JMap.setInt(entry, "color", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 4
        SetInfoText("Pick the ink color for this tattoo.")
    endEvent
endstate

state GLOW_SLOT4
    event OnColorOpenST()
        int slot = 4
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "glow"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 4
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != color
            JMap.setInt(entry, "glow", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 4
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != 0
            JMap.setInt(entry, "glow", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 4
        SetInfoText("Pick a color for the tattoo to glow (black is no glow).")
    endEvent
endstate

state GLOSS_SLOT4
    event OnSelectST()
        int slot = 4
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "gloss") > 0
            JMap.setInt(entry, "gloss", 0)
            SetToggleOptionValueST(false)
        else
            JMap.setInt(entry, "gloss", 1)
            SetToggleOptionValueST(true)
        endif
        SlaveTats.mark_actor(target)
    endEvent

    event OnDefaultST()
        int slot = 4
        int entry = tattoo_menu_current[slot]
        JMap.setInt(entry, "gloss", 0)
        SetToggleOptionValueST(false)
        SlaveTats.mark_actor(target)
    endEvent

    event OnHighlightST()
        int slot = 4
        SetInfoText("Checking this makes the tattoo slightly glossy, like skin.")
    endEvent
endstate

state SECTION_SLOT5
    event OnMenuOpenST()
        int slot = 5
        _setup_sections(AREA(CurrentPage), slot)
        SetMenuDialogStartIndex(section_menu_items.Find(section_menu_current[slot]))
        SetMenuDialogDefaultIndex(section_menu_items.Find("[No Tattoo]"))
        SetMenuDialogOptions(section_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 5
        ; _setup_sections(CurrentPage) ; Not necessary, since OnMenuOpenST immediately precedes it
        if index < 0
            section_menu_current[slot] = "[No Tattoo]"
            SetMenuOptionValueST("[No Tattoo]")
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]", false, "TATTOO_SLOT" + slot)
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        elseif section_menu_current[slot] != section_menu_items[index]
            section_menu_current[slot] = section_menu_items[index]
            SetMenuOptionValueST(section_menu_current[slot])
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), 0)
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"), false, "TATTOO_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 5
        section_menu_current[slot] = "[No Tattoo]"
        SetMenuOptionValueST("[No Tattoo]")
    endEvent

    event OnHighlightST()
        int slot = 5
        SetInfoText("Pick a tattoo collection to select your tattoo from. To remove a tattoo, select [No Tattoo] from the section menu.")
    endEvent
endstate

state TATTOO_SLOT5
    event OnMenuOpenST()
        int slot = 5
        _setup_sections(AREA(CurrentPage), slot)
        _setup_tattoos(section_menu_current[slot])
        if tattoo_menu_current[slot] == 0
            SetMenuDialogStartIndex(0)
        else
            SetMenuDialogStartIndex(tattoo_menu_items.Find(JMap.getStr(tattoo_menu_current[slot], "name")))
        endif
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(tattoo_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 5

        if index == -1 || tattoo_menu_items[index] == "[No Tattoo]"
            Debug.Trace("SlaveTats Menu: Emptying slot " + slot)
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]")
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        else
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), index)
            Debug.Trace("SlaveTats Menu: Setting slot " + slot + " to " + JMap.getStr(entry, "name"))
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    Debug.Trace("SlaveTats Menu: Succeeded")
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"))
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 5
        int entry = JArray.getObj(tattoos, 0)
        if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
            entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
            if entry != 0
                tattoo_menu_current[slot] = entry
                SetMenuOptionValueST(JMap.getStr(entry, "name"))
            endif
        endif
    endEvent

    event OnHighlightST()
        int slot = 5
        int entry = tattoo_menu_current[slot]
        string credit = JMap.getStr(entry, "credit")
        if credit
            SetInfoText("Tattoo by: " + credit)
        endif
    endEvent
endstate

state COLOR_SLOT5
    event OnColorOpenST()
        int slot = 5
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "color"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 5
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != color
            JMap.setInt(entry, "color", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 5
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != 0
            JMap.setInt(entry, "color", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 5
        SetInfoText("Pick the ink color for this tattoo.")
    endEvent
endstate

state GLOW_SLOT5
    event OnColorOpenST()
        int slot = 5
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "glow"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 5
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != color
            JMap.setInt(entry, "glow", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 5
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != 0
            JMap.setInt(entry, "glow", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 5
        SetInfoText("Pick a color for the tattoo to glow (black is no glow).")
    endEvent
endstate

state GLOSS_SLOT5
    event OnSelectST()
        int slot = 5
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "gloss") > 0
            JMap.setInt(entry, "gloss", 0)
            SetToggleOptionValueST(false)
        else
            JMap.setInt(entry, "gloss", 1)
            SetToggleOptionValueST(true)
        endif
        SlaveTats.mark_actor(target)
    endEvent

    event OnDefaultST()
        int slot = 5
        int entry = tattoo_menu_current[slot]
        JMap.setInt(entry, "gloss", 0)
        SetToggleOptionValueST(false)
        SlaveTats.mark_actor(target)
    endEvent

    event OnHighlightST()
        int slot = 5
        SetInfoText("Checking this makes the tattoo slightly glossy, like skin.")
    endEvent
endstate

state SECTION_SLOT6
    event OnMenuOpenST()
        int slot = 6
        _setup_sections(AREA(CurrentPage), slot)
        SetMenuDialogStartIndex(section_menu_items.Find(section_menu_current[slot]))
        SetMenuDialogDefaultIndex(section_menu_items.Find("[No Tattoo]"))
        SetMenuDialogOptions(section_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 6
        ; _setup_sections(CurrentPage) ; Not necessary, since OnMenuOpenST immediately precedes it
        if index < 0
            section_menu_current[slot] = "[No Tattoo]"
            SetMenuOptionValueST("[No Tattoo]")
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]", false, "TATTOO_SLOT" + slot)
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        elseif section_menu_current[slot] != section_menu_items[index]
            section_menu_current[slot] = section_menu_items[index]
            SetMenuOptionValueST(section_menu_current[slot])
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), 0)
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"), false, "TATTOO_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 6
        section_menu_current[slot] = "[No Tattoo]"
        SetMenuOptionValueST("[No Tattoo]")
    endEvent

    event OnHighlightST()
        int slot = 6
        SetInfoText("Pick a tattoo collection to select your tattoo from. To remove a tattoo, select [No Tattoo] from the section menu.")
    endEvent
endstate

state TATTOO_SLOT6
    event OnMenuOpenST()
        int slot = 6
        _setup_sections(AREA(CurrentPage), slot)
        _setup_tattoos(section_menu_current[slot])
        if tattoo_menu_current[slot] == 0
            SetMenuDialogStartIndex(0)
        else
            SetMenuDialogStartIndex(tattoo_menu_items.Find(JMap.getStr(tattoo_menu_current[slot], "name")))
        endif
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(tattoo_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 6

        if index == -1 || tattoo_menu_items[index] == "[No Tattoo]"
            Debug.Trace("SlaveTats Menu: Emptying slot " + slot)
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]")
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        else
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), index)
            Debug.Trace("SlaveTats Menu: Setting slot " + slot + " to " + JMap.getStr(entry, "name"))
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    Debug.Trace("SlaveTats Menu: Succeeded")
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"))
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 6
        int entry = JArray.getObj(tattoos, 0)
        if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
            entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
            if entry != 0
                tattoo_menu_current[slot] = entry
                SetMenuOptionValueST(JMap.getStr(entry, "name"))
            endif
        endif
    endEvent

    event OnHighlightST()
        int slot = 6
        int entry = tattoo_menu_current[slot]
        string credit = JMap.getStr(entry, "credit")
        if credit
            SetInfoText("Tattoo by: " + credit)
        endif
    endEvent
endstate

state COLOR_SLOT6
    event OnColorOpenST()
        int slot = 6
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "color"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 6
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != color
            JMap.setInt(entry, "color", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 6
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != 0
            JMap.setInt(entry, "color", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 6
        SetInfoText("Pick the ink color for this tattoo.")
    endEvent
endstate

state GLOW_SLOT6
    event OnColorOpenST()
        int slot = 6
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "glow"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 6
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != color
            JMap.setInt(entry, "glow", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 6
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != 0
            JMap.setInt(entry, "glow", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 6
        SetInfoText("Pick a color for the tattoo to glow (black is no glow).")
    endEvent
endstate

state GLOSS_SLOT6
    event OnSelectST()
        int slot = 6
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "gloss") > 0
            JMap.setInt(entry, "gloss", 0)
            SetToggleOptionValueST(false)
        else
            JMap.setInt(entry, "gloss", 1)
            SetToggleOptionValueST(true)
        endif
        SlaveTats.mark_actor(target)
    endEvent

    event OnDefaultST()
        int slot = 6
        int entry = tattoo_menu_current[slot]
        JMap.setInt(entry, "gloss", 0)
        SetToggleOptionValueST(false)
        SlaveTats.mark_actor(target)
    endEvent

    event OnHighlightST()
        int slot = 6
        SetInfoText("Checking this makes the tattoo slightly glossy, like skin.")
    endEvent
endstate

state SECTION_SLOT7
    event OnMenuOpenST()
        int slot = 7
        _setup_sections(AREA(CurrentPage), slot)
        SetMenuDialogStartIndex(section_menu_items.Find(section_menu_current[slot]))
        SetMenuDialogDefaultIndex(section_menu_items.Find("[No Tattoo]"))
        SetMenuDialogOptions(section_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 7
        ; _setup_sections(CurrentPage) ; Not necessary, since OnMenuOpenST immediately precedes it
        if index < 0
            section_menu_current[slot] = "[No Tattoo]"
            SetMenuOptionValueST("[No Tattoo]")
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]", false, "TATTOO_SLOT" + slot)
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        elseif section_menu_current[slot] != section_menu_items[index]
            section_menu_current[slot] = section_menu_items[index]
            SetMenuOptionValueST(section_menu_current[slot])
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), 0)
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"), false, "TATTOO_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 7
        section_menu_current[slot] = "[No Tattoo]"
        SetMenuOptionValueST("[No Tattoo]")
    endEvent

    event OnHighlightST()
        int slot = 7
        SetInfoText("Pick a tattoo collection to select your tattoo from. To remove a tattoo, select [No Tattoo] from the section menu.")
    endEvent
endstate

state TATTOO_SLOT7
    event OnMenuOpenST()
        int slot = 7
        _setup_sections(AREA(CurrentPage), slot)
        _setup_tattoos(section_menu_current[slot])
        if tattoo_menu_current[slot] == 0
            SetMenuDialogStartIndex(0)
        else
            SetMenuDialogStartIndex(tattoo_menu_items.Find(JMap.getStr(tattoo_menu_current[slot], "name")))
        endif
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(tattoo_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 7

        if index == -1 || tattoo_menu_items[index] == "[No Tattoo]"
            Debug.Trace("SlaveTats Menu: Emptying slot " + slot)
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]")
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        else
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), index)
            Debug.Trace("SlaveTats Menu: Setting slot " + slot + " to " + JMap.getStr(entry, "name"))
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    Debug.Trace("SlaveTats Menu: Succeeded")
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"))
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 7
        int entry = JArray.getObj(tattoos, 0)
        if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
            entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
            if entry != 0
                tattoo_menu_current[slot] = entry
                SetMenuOptionValueST(JMap.getStr(entry, "name"))
            endif
        endif
    endEvent

    event OnHighlightST()
        int slot = 7
        int entry = tattoo_menu_current[slot]
        string credit = JMap.getStr(entry, "credit")
        if credit
            SetInfoText("Tattoo by: " + credit)
        endif
    endEvent
endstate

state COLOR_SLOT7
    event OnColorOpenST()
        int slot = 7
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "color"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 7
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != color
            JMap.setInt(entry, "color", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 7
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != 0
            JMap.setInt(entry, "color", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 7
        SetInfoText("Pick the ink color for this tattoo.")
    endEvent
endstate

state GLOW_SLOT7
    event OnColorOpenST()
        int slot = 7
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "glow"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 7
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != color
            JMap.setInt(entry, "glow", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 7
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != 0
            JMap.setInt(entry, "glow", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 7
        SetInfoText("Pick a color for the tattoo to glow (black is no glow).")
    endEvent
endstate

state GLOSS_SLOT7
    event OnSelectST()
        int slot = 7
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "gloss") > 0
            JMap.setInt(entry, "gloss", 0)
            SetToggleOptionValueST(false)
        else
            JMap.setInt(entry, "gloss", 1)
            SetToggleOptionValueST(true)
        endif
        SlaveTats.mark_actor(target)
    endEvent

    event OnDefaultST()
        int slot = 7
        int entry = tattoo_menu_current[slot]
        JMap.setInt(entry, "gloss", 0)
        SetToggleOptionValueST(false)
        SlaveTats.mark_actor(target)
    endEvent

    event OnHighlightST()
        int slot = 7
        SetInfoText("Checking this makes the tattoo slightly glossy, like skin.")
    endEvent
endstate

state SECTION_SLOT8
    event OnMenuOpenST()
        int slot = 8
        _setup_sections(AREA(CurrentPage), slot)
        SetMenuDialogStartIndex(section_menu_items.Find(section_menu_current[slot]))
        SetMenuDialogDefaultIndex(section_menu_items.Find("[No Tattoo]"))
        SetMenuDialogOptions(section_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 8
        ; _setup_sections(CurrentPage) ; Not necessary, since OnMenuOpenST immediately precedes it
        if index < 0
            section_menu_current[slot] = "[No Tattoo]"
            SetMenuOptionValueST("[No Tattoo]")
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]", false, "TATTOO_SLOT" + slot)
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        elseif section_menu_current[slot] != section_menu_items[index]
            section_menu_current[slot] = section_menu_items[index]
            SetMenuOptionValueST(section_menu_current[slot])
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), 0)
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"), false, "TATTOO_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 8
        section_menu_current[slot] = "[No Tattoo]"
        SetMenuOptionValueST("[No Tattoo]")
    endEvent

    event OnHighlightST()
        int slot = 8
        SetInfoText("Pick a tattoo collection to select your tattoo from. To remove a tattoo, select [No Tattoo] from the section menu.")
    endEvent
endstate

state TATTOO_SLOT8
    event OnMenuOpenST()
        int slot = 8
        _setup_sections(AREA(CurrentPage), slot)
        _setup_tattoos(section_menu_current[slot])
        if tattoo_menu_current[slot] == 0
            SetMenuDialogStartIndex(0)
        else
            SetMenuDialogStartIndex(tattoo_menu_items.Find(JMap.getStr(tattoo_menu_current[slot], "name")))
        endif
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(tattoo_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 8

        if index == -1 || tattoo_menu_items[index] == "[No Tattoo]"
            Debug.Trace("SlaveTats Menu: Emptying slot " + slot)
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]")
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        else
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), index)
            Debug.Trace("SlaveTats Menu: Setting slot " + slot + " to " + JMap.getStr(entry, "name"))
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    Debug.Trace("SlaveTats Menu: Succeeded")
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"))
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 8
        int entry = JArray.getObj(tattoos, 0)
        if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
            entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
            if entry != 0
                tattoo_menu_current[slot] = entry
                SetMenuOptionValueST(JMap.getStr(entry, "name"))
            endif
        endif
    endEvent

    event OnHighlightST()
        int slot = 8
        int entry = tattoo_menu_current[slot]
        string credit = JMap.getStr(entry, "credit")
        if credit
            SetInfoText("Tattoo by: " + credit)
        endif
    endEvent
endstate

state COLOR_SLOT8
    event OnColorOpenST()
        int slot = 8
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "color"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 8
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != color
            JMap.setInt(entry, "color", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 8
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != 0
            JMap.setInt(entry, "color", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 8
        SetInfoText("Pick the ink color for this tattoo.")
    endEvent
endstate

state GLOW_SLOT8
    event OnColorOpenST()
        int slot = 8
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "glow"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 8
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != color
            JMap.setInt(entry, "glow", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 8
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != 0
            JMap.setInt(entry, "glow", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 8
        SetInfoText("Pick a color for the tattoo to glow (black is no glow).")
    endEvent
endstate

state GLOSS_SLOT8
    event OnSelectST()
        int slot = 8
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "gloss") > 0
            JMap.setInt(entry, "gloss", 0)
            SetToggleOptionValueST(false)
        else
            JMap.setInt(entry, "gloss", 1)
            SetToggleOptionValueST(true)
        endif
        SlaveTats.mark_actor(target)
    endEvent

    event OnDefaultST()
        int slot = 8
        int entry = tattoo_menu_current[slot]
        JMap.setInt(entry, "gloss", 0)
        SetToggleOptionValueST(false)
        SlaveTats.mark_actor(target)
    endEvent

    event OnHighlightST()
        int slot = 8
        SetInfoText("Checking this makes the tattoo slightly glossy, like skin.")
    endEvent
endstate

state SECTION_SLOT9
    event OnMenuOpenST()
        int slot = 9
        _setup_sections(AREA(CurrentPage), slot)
        SetMenuDialogStartIndex(section_menu_items.Find(section_menu_current[slot]))
        SetMenuDialogDefaultIndex(section_menu_items.Find("[No Tattoo]"))
        SetMenuDialogOptions(section_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 9
        ; _setup_sections(CurrentPage) ; Not necessary, since OnMenuOpenST immediately precedes it
        if index < 0
            section_menu_current[slot] = "[No Tattoo]"
            SetMenuOptionValueST("[No Tattoo]")
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]", false, "TATTOO_SLOT" + slot)
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        elseif section_menu_current[slot] != section_menu_items[index]
            section_menu_current[slot] = section_menu_items[index]
            SetMenuOptionValueST(section_menu_current[slot])
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), 0)
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"), false, "TATTOO_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 9
        section_menu_current[slot] = "[No Tattoo]"
        SetMenuOptionValueST("[No Tattoo]")
    endEvent

    event OnHighlightST()
        int slot = 9
        SetInfoText("Pick a tattoo collection to select your tattoo from. To remove a tattoo, select [No Tattoo] from the section menu.")
    endEvent
endstate

state TATTOO_SLOT9
    event OnMenuOpenST()
        int slot = 9
        _setup_sections(AREA(CurrentPage), slot)
        _setup_tattoos(section_menu_current[slot])
        if tattoo_menu_current[slot] == 0
            SetMenuDialogStartIndex(0)
        else
            SetMenuDialogStartIndex(tattoo_menu_items.Find(JMap.getStr(tattoo_menu_current[slot], "name")))
        endif
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(tattoo_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 9

        if index == -1 || tattoo_menu_items[index] == "[No Tattoo]"
            Debug.Trace("SlaveTats Menu: Emptying slot " + slot)
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]")
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        else
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), index)
            Debug.Trace("SlaveTats Menu: Setting slot " + slot + " to " + JMap.getStr(entry, "name"))
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    Debug.Trace("SlaveTats Menu: Succeeded")
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"))
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 9
        int entry = JArray.getObj(tattoos, 0)
        if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
            entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
            if entry != 0
                tattoo_menu_current[slot] = entry
                SetMenuOptionValueST(JMap.getStr(entry, "name"))
            endif
        endif
    endEvent

    event OnHighlightST()
        int slot = 9
        int entry = tattoo_menu_current[slot]
        string credit = JMap.getStr(entry, "credit")
        if credit
            SetInfoText("Tattoo by: " + credit)
        endif
    endEvent
endstate

state COLOR_SLOT9
    event OnColorOpenST()
        int slot = 9
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "color"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 9
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != color
            JMap.setInt(entry, "color", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 9
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != 0
            JMap.setInt(entry, "color", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 9
        SetInfoText("Pick the ink color for this tattoo.")
    endEvent
endstate

state GLOW_SLOT9
    event OnColorOpenST()
        int slot = 9
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "glow"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 9
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != color
            JMap.setInt(entry, "glow", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 9
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != 0
            JMap.setInt(entry, "glow", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 9
        SetInfoText("Pick a color for the tattoo to glow (black is no glow).")
    endEvent
endstate

state GLOSS_SLOT9
    event OnSelectST()
        int slot = 9
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "gloss") > 0
            JMap.setInt(entry, "gloss", 0)
            SetToggleOptionValueST(false)
        else
            JMap.setInt(entry, "gloss", 1)
            SetToggleOptionValueST(true)
        endif
        SlaveTats.mark_actor(target)
    endEvent

    event OnDefaultST()
        int slot = 9
        int entry = tattoo_menu_current[slot]
        JMap.setInt(entry, "gloss", 0)
        SetToggleOptionValueST(false)
        SlaveTats.mark_actor(target)
    endEvent

    event OnHighlightST()
        int slot = 9
        SetInfoText("Checking this makes the tattoo slightly glossy, like skin.")
    endEvent
endstate

state SECTION_SLOT10
    event OnMenuOpenST()
        int slot = 10
        _setup_sections(AREA(CurrentPage), slot)
        SetMenuDialogStartIndex(section_menu_items.Find(section_menu_current[slot]))
        SetMenuDialogDefaultIndex(section_menu_items.Find("[No Tattoo]"))
        SetMenuDialogOptions(section_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 10
        ; _setup_sections(CurrentPage) ; Not necessary, since OnMenuOpenST immediately precedes it
        if index < 0
            section_menu_current[slot] = "[No Tattoo]"
            SetMenuOptionValueST("[No Tattoo]")
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]", false, "TATTOO_SLOT" + slot)
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        elseif section_menu_current[slot] != section_menu_items[index]
            section_menu_current[slot] = section_menu_items[index]
            SetMenuOptionValueST(section_menu_current[slot])
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), 0)
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"), false, "TATTOO_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 10
        section_menu_current[slot] = "[No Tattoo]"
        SetMenuOptionValueST("[No Tattoo]")
    endEvent

    event OnHighlightST()
        int slot = 10
        SetInfoText("Pick a tattoo collection to select your tattoo from. To remove a tattoo, select [No Tattoo] from the section menu.")
    endEvent
endstate

state TATTOO_SLOT10
    event OnMenuOpenST()
        int slot = 10
        _setup_sections(AREA(CurrentPage), slot)
        _setup_tattoos(section_menu_current[slot])
        if tattoo_menu_current[slot] == 0
            SetMenuDialogStartIndex(0)
        else
            SetMenuDialogStartIndex(tattoo_menu_items.Find(JMap.getStr(tattoo_menu_current[slot], "name")))
        endif
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(tattoo_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 10

        if index == -1 || tattoo_menu_items[index] == "[No Tattoo]"
            Debug.Trace("SlaveTats Menu: Emptying slot " + slot)
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]")
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        else
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), index)
            Debug.Trace("SlaveTats Menu: Setting slot " + slot + " to " + JMap.getStr(entry, "name"))
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    Debug.Trace("SlaveTats Menu: Succeeded")
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"))
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 10
        int entry = JArray.getObj(tattoos, 0)
        if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
            entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
            if entry != 0
                tattoo_menu_current[slot] = entry
                SetMenuOptionValueST(JMap.getStr(entry, "name"))
            endif
        endif
    endEvent

    event OnHighlightST()
        int slot = 10
        int entry = tattoo_menu_current[slot]
        string credit = JMap.getStr(entry, "credit")
        if credit
            SetInfoText("Tattoo by: " + credit)
        endif
    endEvent
endstate

state COLOR_SLOT10
    event OnColorOpenST()
        int slot = 10
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "color"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 10
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != color
            JMap.setInt(entry, "color", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 10
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != 0
            JMap.setInt(entry, "color", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 10
        SetInfoText("Pick the ink color for this tattoo.")
    endEvent
endstate

state GLOW_SLOT10
    event OnColorOpenST()
        int slot = 10
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "glow"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 10
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != color
            JMap.setInt(entry, "glow", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 10
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != 0
            JMap.setInt(entry, "glow", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 10
        SetInfoText("Pick a color for the tattoo to glow (black is no glow).")
    endEvent
endstate

state GLOSS_SLOT10
    event OnSelectST()
        int slot = 10
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "gloss") > 0
            JMap.setInt(entry, "gloss", 0)
            SetToggleOptionValueST(false)
        else
            JMap.setInt(entry, "gloss", 1)
            SetToggleOptionValueST(true)
        endif
        SlaveTats.mark_actor(target)
    endEvent

    event OnDefaultST()
        int slot = 10
        int entry = tattoo_menu_current[slot]
        JMap.setInt(entry, "gloss", 0)
        SetToggleOptionValueST(false)
        SlaveTats.mark_actor(target)
    endEvent

    event OnHighlightST()
        int slot = 10
        SetInfoText("Checking this makes the tattoo slightly glossy, like skin.")
    endEvent
endstate

state SECTION_SLOT11
    event OnMenuOpenST()
        int slot = 11
        _setup_sections(AREA(CurrentPage), slot)
        SetMenuDialogStartIndex(section_menu_items.Find(section_menu_current[slot]))
        SetMenuDialogDefaultIndex(section_menu_items.Find("[No Tattoo]"))
        SetMenuDialogOptions(section_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 11
        ; _setup_sections(CurrentPage) ; Not necessary, since OnMenuOpenST immediately precedes it
        if index < 0
            section_menu_current[slot] = "[No Tattoo]"
            SetMenuOptionValueST("[No Tattoo]")
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]", false, "TATTOO_SLOT" + slot)
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        elseif section_menu_current[slot] != section_menu_items[index]
            section_menu_current[slot] = section_menu_items[index]
            SetMenuOptionValueST(section_menu_current[slot])
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), 0)
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"), false, "TATTOO_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 11
        section_menu_current[slot] = "[No Tattoo]"
        SetMenuOptionValueST("[No Tattoo]")
    endEvent

    event OnHighlightST()
        int slot = 11
        SetInfoText("Pick a tattoo collection to select your tattoo from. To remove a tattoo, select [No Tattoo] from the section menu.")
    endEvent
endstate

state TATTOO_SLOT11
    event OnMenuOpenST()
        int slot = 11
        _setup_sections(AREA(CurrentPage), slot)
        _setup_tattoos(section_menu_current[slot])
        if tattoo_menu_current[slot] == 0
            SetMenuDialogStartIndex(0)
        else
            SetMenuDialogStartIndex(tattoo_menu_items.Find(JMap.getStr(tattoo_menu_current[slot], "name")))
        endif
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(tattoo_menu_items)
    endEvent

    event OnMenuAcceptST(int index)
        int slot = 11

        if index == -1 || tattoo_menu_items[index] == "[No Tattoo]"
            Debug.Trace("SlaveTats Menu: Emptying slot " + slot)
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]")
                SetColorOptionValueST(0, false, "COLOR_SLOT" + slot)
                SetColorOptionValueST(0, false, "GLOW_SLOT" + slot)
                SetToggleOptionValueST(false, false, "GLOSS_SLOT" + slot)
            endif
        else
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), index)
            Debug.Trace("SlaveTats Menu: Setting slot " + slot + " to " + JMap.getStr(entry, "name"))
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    Debug.Trace("SlaveTats Menu: Succeeded")
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"))
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLOR_SLOT" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOW_SLOT" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSS_SLOT" + slot)
                endif
            endif
        endif
    endEvent

    event OnDefaultST()
        int slot = 11
        int entry = JArray.getObj(tattoos, 0)
        if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
            entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
            if entry != 0
                tattoo_menu_current[slot] = entry
                SetMenuOptionValueST(JMap.getStr(entry, "name"))
            endif
        endif
    endEvent

    event OnHighlightST()
        int slot = 11
        int entry = tattoo_menu_current[slot]
        string credit = JMap.getStr(entry, "credit")
        if credit
            SetInfoText("Tattoo by: " + credit)
        endif
    endEvent
endstate

state COLOR_SLOT11
    event OnColorOpenST()
        int slot = 11
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "color"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 11
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != color
            JMap.setInt(entry, "color", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 11
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != 0
            JMap.setInt(entry, "color", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 11
        SetInfoText("Pick the ink color for this tattoo.")
    endEvent
endstate

state GLOW_SLOT11
    event OnColorOpenST()
        int slot = 11
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "glow"))
        SetColorDialogDefaultColor(0)
    endEvent

    event OnColorAcceptST(int color)
        int slot = 11
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != color
            JMap.setInt(entry, "glow", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnDefaultST()
        int slot = 11
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != 0
            JMap.setInt(entry, "glow", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    endEvent

    event OnHighlightST()
        int slot = 11
        SetInfoText("Pick a color for the tattoo to glow (black is no glow).")
    endEvent
endstate

state GLOSS_SLOT11
    event OnSelectST()
        int slot = 11
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "gloss") > 0
            JMap.setInt(entry, "gloss", 0)
            SetToggleOptionValueST(false)
        else
            JMap.setInt(entry, "gloss", 1)
            SetToggleOptionValueST(true)
        endif
        SlaveTats.mark_actor(target)
    endEvent

    event OnDefaultST()
        int slot = 11
        int entry = tattoo_menu_current[slot]
        JMap.setInt(entry, "gloss", 0)
        SetToggleOptionValueST(false)
        SlaveTats.mark_actor(target)
    endEvent

    event OnHighlightST()
        int slot = 11
        SetInfoText("Checking this makes the tattoo slightly glossy, like skin.")
    endEvent
endstate
