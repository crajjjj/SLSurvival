Scriptname AudioUtil Hidden
{Native folder-based audio player (voice + SFX). Plays loose WAV files by
 slot/category folder with no sound descriptor forms. See AudioUtil.toml.
 The optional PPA plugin bridge lives in AudioUtilPPA.psc.}

; =============================================================================
; CONCEPTS shared by every Play* call
;
;   handle   Every Play* returns an int instance handle: > 0 on success, 0 if
;            nothing played (unknown category, empty folder, actor invalid...).
;            Failures are logged to AudioUtil.log, never thrown. Handles stay
;            valid until the sound ends, is stopped, or is replaced on its
;            channel; calls on a dead handle are safe no-ops.
;
;   volume   0.0-1.0 base volume of this instance. The EFFECTIVE volume is
;            volume * group_volume * group_duck_factor, re-applied live when
;            the group changes.
;
;   group    Volume/duck bucket this instance joins. Any string; "" = none.
;            [groups] in AudioUtil.toml sets startup volumes; SetGroupVolume /
;            DuckGroup change them at runtime and affect ALL current and
;            future members of the group.
;
;   channel  Exclusivity lane. Any string; "" = none. Starting a sound on a
;            channel first STOPS whatever previously played on that channel.
;            Use one channel per logical stream (e.g. one per actor's body
;            SFX) so a new line replaces the old instead of stacking.
;
;   file selection  A category/folder with N files acts as a shuffle bag:
;            random order, no repeats until the bag empties, then reshuffle.
;
;   3D       Sounds follow the given actor's position while playing. Pass a
;            None actor to play unattached (2D-ish, at the listener).
; =============================================================================

; ===================== NATIVE — core =====================

; API version of the loaded DLL, for compatibility checks from scripts.
; Increases only when signatures/behavior change incompatibly.
int Function GetAPIVersion() global native

; Re-read AudioUtil.toml and rescan all slot folders in-game (no restart
; needed). Returns false if the file failed to parse - the previous config
; stays active in that case. Console (ConsoleUtil Extended): au reload
bool Function ReloadConfig() global native

; Play a voice line for an actor, resolving WHICH voice pack (slot) to use
; from the actor, then WHICH folder inside it from the category.
;
; Slot resolution (first hit wins):
;   1. pc_female_slot / pc_male_slot  - player only; reserved from NPCs
;   2. [npc_overrides]                - explicit per-NPC pin
;   3. [voicetype_remap] -> [voicetype_map]  - by the actor's VoiceType
;   4. [race_map]                     - substring match on race editor id
;   5. default_female_slot / default_male_slot
; Map values may be slot lists; then the actor picks one deterministically
; (same NPC = same slot every scene, load order independent).
;
; Category resolution inside the slot:
;   exact folder -> [category_aliases] -> [male_only_remap] (male slots) ->
;   [category_fallbacks] (one hop) -> the slot's `fallback` slot (retried per
;   category, up to 4 hops) -> [sfx] table as a last resort.
; If the actor is gagged (wears a [gag] keyword) and the slot names a gag_slot,
; resolution runs in that muffled slot instead, with [gag] default_category as
; the catch-all.
;
; category is case- and space-insensitive ("Battle Cry" == "BattleCry").
; blockLipSync=true plays this one line without moving the speaker's mouth.
; If your mod owns an actor's face across many lines (an ahegao / expression
; overlay), pass blockLipSync=true on each PlayVoice for that actor while the
; face is up - decide it per call from your own face-ownership state; there is
; no standing per-actor block in the API. Categories listed in [lipsync]
; block_categories never drive the mouth even when blockLipSync=false.
; Returns a handle (see CONCEPTS); 0 if no slot or no audio resolved.
int Function PlayVoice(Actor akActor, string category, float volume = 1.0, string group = "", string channel = "", bool blockLipSync = false) global native

; Same as PlayVoice but the slot is named explicitly ("F1", "M4", "C2"...)
; instead of resolved from an actor - for samples, tests, or when the caller
; already decided the voice. akFollow only provides the 3D position.
int Function PlayVoiceFromSlot(string slot, string category, Actor akFollow, float volume = 1.0, string group = "", string channel = "", bool blockLipSync = false) global native

; Play a named SFX. sfxName resolves first as a category of the sfx slot
; ("SFX0" by default; set via [general] sfx_slot), then the flat [sfx] table -
; so an sfx pool can use a scanned folder, an explicit file list (BSA-capable),
; or a folder ref, exactly like a voice category. Defaults into the "sfx" group
; so SFX volume/ducking applies unless overridden.
int Function PlaySFX(string sfxName, Actor akFollow, float volume = 1.0, string group = "sfx", string channel = "") global native

; Play one specific file. Path is relative to Data\ ('Sound\fx\MyMod\a.wav')
; and may resolve to a loose file OR to audio packed inside a BSA - the
; engine's resource loader handles both (loose wins over archive).
int Function PlayFile(string dataRelativePath, Actor akFollow, float volume = 1.0, string group = "", string channel = "") global native

; Play a random file from a loose folder (scanned on first use, then cached
; as a shuffle bag). Folder scanning cannot see into BSAs - for archived
; audio use PlayFile or a [slot.categories] file list in the toml.
int Function PlayFolder(string dataRelativeFolder, Actor akFollow, float volume = 1.0, string group = "", string channel = "") global native

; ===================== NATIVE — handles =====================

; True while the instance is audible. Also true during a short startup grace
; (~0.4s) right after Play* returns: the engine starts streams asynchronously
; and briefly reports "not playing" for sounds that are about to start.
bool Function IsHandlePlaying(int handle) global native

; Stop the instance now. Returns true if it was alive and stopped.
bool Function StopHandle(int handle) global native

; Clip length in seconds. May return 0.0 while the stream is still being
; prepared (see WaitForHandle for how to cope with that).
float Function GetHandleDuration(int handle) global native

; Change one instance's base volume mid-play (group multipliers still apply).
Function SetHandleVolume(int handle, float volume) global native

; ===================== NATIVE — groups & channels =====================
; Conventional group names: pc_high / pc_low (player voice), partner_high /
; partner_low (NPC voice), sfx (effects), oneshot (ambient one-shots). Any
; other name works - groups are created on first use.

; Set a group's volume (0.0-1.0). Applies immediately to playing members and
; to everything started later. A consumer mod calls this at runtime (e.g. from
; its own MCM - AudioUtil ships none); the toml [groups] values are only the
; startup state.
Function SetGroupVolume(string group, float volume) global native

; Temporarily scale a group by factor (0.0 = silent, 1.0 = no duck) without
; touching its stored volume - e.g. duck background voice while an important
; line plays. Ducks do not stack; the last factor wins. Undo with UnduckGroup.
Function DuckGroup(string group, float factor = 0.0) global native

; Restore a ducked group to its normal volume (equivalent to factor 1.0).
Function UnduckGroup(string group) global native

; Stop every playing instance that belongs to the group.
Function StopGroup(string group) global native

; Stop everything AudioUtil is playing and clear all channel bindings.
; Does not touch group volumes or the config.
Function StopAllAudio() global native

; Stop whatever currently occupies the channel (if anything) and free it.
Function StopChannel(string channel) global native

; ===================== NATIVE — lipsync =====================
; PlayVoice / PlayVoiceFromSlot automatically move the speaking actor's mouth
; in sync with the clip's loudness (the DLL reads the wav's amplitude envelope
; and drives the MFG Aah/BigAah phonemes per frame). Works for loose PCM wav
; files; xwm or BSA-packed audio plays normally but skips the mouth. Configure
; in AudioUtil.toml [lipsync] (enable/gain/attack_ms/release_ms/min_level).
;
; Plays nice with expression mods: only the two phonemes above are touched,
; and they are zeroed when the clip ends. If your mod sets phonemes itself
; (e.g. an expression cycler), skip your own mouth writes for an actor while
; IsLipSyncActive(actor) is true to avoid fighting over the jaw.

; True while AudioUtil is driving this actor's mouth (a voice line with a
; readable envelope is playing and lipsync is enabled).
bool Function IsLipSyncActive(Actor akActor) global native

; Fade this actor's mouth closed now; the audio itself keeps playing.
Function StopLipSync(Actor akActor) global native

; Master switch (runtime; the toml value is restored on ReloadConfig).
; Turning it off fades all active mouths closed.
Function SetLipSyncEnabled(bool enable) global native
bool Function IsLipSyncEnabled() global native

; Mouth-open strength, 0.0-2.0 (1.0 = envelope as-is). For a consumer mod's runtime control.
Function SetLipSyncGain(float gain) global native

; ===================== NATIVE — introspection =====================

; Which slot id PlayVoice would resolve for this actor right now ("M4",
; "F1", ...; "" if none). Useful for debugging voice assignment.
string Function GetSlotForActor(Actor akActor) global native

; Optional per-slot schema label, for consumers whose voice packs ship in more
; than one folder/category layout. "B" = the alternate layout, "A" = the default
; (also returned for a slot that doesn't set it, and for an unknown slot id).
; AudioUtil does not interpret this itself - a consumer mod sets variation on the
; slot and gates its own category routing on it. Leave unset if all packs share
; one layout.
string Function GetSlotVariation(string slot) global native

; Number of playable files behind slot/category after full category
; resolution (aliases/fallbacks applied). 0 = a PlayVoice would fail.
int Function GetCategoryFileCount(string slot, string category) global native

; True if slot/category resolves to at least one file. Cheap way to guard
; optional content ("play the rare line only if the pack ships it").
bool Function CategoryExists(string slot, string category) global native

; True if a data-relative path resolves to a real resource (loose file OR
; BSA-packed) in the current load order - the same lookup PlayFile uses. Confirms
; the path resolves, not that the audio is valid PCM. Use to audit explicit file
; lists (e.g. creature slot paths). Separators may be '/' or '\'.
bool Function FileExists(string path) global native

; ===================== NATIVE — debug =====================

; Play a file with explicit BuildSoundDataFromFile flags/priority instead of
; the toml's sound_flags/sound_priority - for experimenting when a file is
; silent or behaves oddly. Not for production use.
int Function DebugPlayFile(string dataRelativePath, Actor akFollow, int flags, int priority) global native

; ===================== WRAPPERS =====================
; Latent SKSE natives are possible (CommonLib RegisterLatentFunction), but
; playback already runs on the DLL's own thread, so PlayAndWait is done here
; by polling IsHandlePlaying + Utility.Wait — no suspended VM stack, no
; task-interface marshalling.

; Block the calling Papyrus thread until the instance finishes (or a safety
; timeout: clip duration + 1s, or 30s when the duration isn't known yet).
; Returns immediately for dead/invalid handles. Polls every 0.1s, so expect
; up to ~0.1s of overshoot past the actual clip end.
Function WaitForHandle(int handle) global
    if handle <= 0
        return
    endif
    float timeout = GetHandleDuration(handle) + 1.0
    if timeout < 1.5
        timeout = 30.0 ; duration may be 0 while the sound is still being built
    endif
    float waited = 0.0
    while IsHandlePlaying(handle) && waited < timeout
        Utility.Wait(0.1)
        waited += 0.1
    endwhile
EndFunction

; PlayVoice, then block until the line finishes. Same arguments and
; resolution as PlayVoice; discards the handle.
Function PlayVoiceAndWait(Actor akActor, string category, float volume = 1.0, string group = "", string channel = "", bool blockLipSync = false) global
    int h = PlayVoice(akActor, category, volume, group, channel, blockLipSync)
    WaitForHandle(h)
EndFunction

; PlaySFX, then block until it finishes. Same arguments as PlaySFX.
Function PlaySFXAndWait(string sfxName, Actor akFollow, float volume = 1.0, string group = "sfx", string channel = "") global
    int h = PlaySFX(sfxName, akFollow, volume, group, channel)
    WaitForHandle(h)
EndFunction

; Drop-in equivalent of a legacy PlaySound(Sound form, Actor, wait) helper:
; category string instead of a Sound form, optional blocking.
Function Play(string category, Actor akActor, bool waitForCompletion = true, float volume = 1.0, string group = "", string channel = "", bool blockLipSync = false) global
    if waitForCompletion
        PlayVoiceAndWait(akActor, category, volume, group, channel, blockLipSync)
    else
        PlayVoice(akActor, category, volume, group, channel, blockLipSync)
    endif
EndFunction
