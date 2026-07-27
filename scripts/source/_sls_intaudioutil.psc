Scriptname _SLS_IntAudioUtil Hidden
{AudioUtil (SKSE folder-based audio player: voice packs, gag-muffled slots, lipsync) wrappers.
The only place referencing the AudioUtil script type. AudioUtil ships no plugin file, so
presence is probed via its SKSE plugin version (like _SLS_IntSlpp) instead of GetModByName,
and - having no ESP form to hang an _SLS_Interface* quest on - each wrapper carries its own
install guard so callers may invoke it blind. A PlayVoice/PlaySFX that resolves nothing
returns 0; callers treat 0 as "not handled" and fall back to their legacy sound path.}

Bool Function GetIsInstalled() Global
	; -1 when the DLL isn't loaded. AudioUtil packs its version CommonLib-style
	; ((major<<24)|(minor<<16)|(patch<<4)), so any loaded build is > 0.
	Return SKSE.GetPluginVersion("AudioUtil") > 0
EndFunction

; Voice line for an actor, resolved through the actor's voice pack (slot). Handles gag
; muffling (toml gag_slot) and lipsync in the DLL. Returns an instance handle, 0 if the
; plugin is absent or no slot/category resolved. SLS plays into its own volume groups -
; "sls_voice" (voiced lines) and "sls_sfx" (impacts/gulps) - driven by the SLS MCM
; sliders via SetGroupVolume, independent of the voice-pack mod's own volume sliders.
Int Function PlayVoice(Actor akActor, String Category, Float Volume = 1.0, String Group = "", String Channel = "", Bool BlockLipSync = false) Global
	If GetIsInstalled()
		Return AudioUtil.PlayVoice(akActor, Category, Volume, Group, Channel, BlockLipSync)
	EndIf
	Return 0
EndFunction

; Named SFX at the actor's position. Returns an instance handle, 0 if not resolved.
Int Function PlaySFX(String SfxName, Actor akFollow, Float Volume = 1.0, String Group = "sfx", String Channel = "") Global
	If GetIsInstalled()
		Return AudioUtil.PlaySFX(SfxName, akFollow, Volume, Group, Channel)
	EndIf
	Return 0
EndFunction

; Random file from a loose folder (shuffle bag), 3D at the actor. Path is Data-relative.
; Unlike the Sound-form file lists this scans the whole folder, so voice-pack files beyond
; the stock set play too. Returns an instance handle, 0 if the folder is absent/empty.
Int Function PlayFolder(String DataRelativeFolder, Actor akFollow, Float Volume = 1.0, String Group = "", String Channel = "") Global
	If GetIsInstalled()
		Return AudioUtil.PlayFolder(DataRelativeFolder, akFollow, Volume, Group, Channel)
	EndIf
	Return 0
EndFunction

; Set a group's volume (0.0-1.0); applies to playing and future members. Group volumes
; are DLL session state (reset to the toml [groups] values each game start), so callers
; must reapply on load - see sls_utility.ApplyAudioUtilVolumes.
Function SetGroupVolume(String Group, Float Volume) Global
	If GetIsInstalled()
		AudioUtil.SetGroupVolume(Group, Volume)
	EndIf
EndFunction

Bool Function IsHandlePlaying(Int Handle) Global
	If Handle > 0 && GetIsInstalled()
		Return AudioUtil.IsHandlePlaying(Handle)
	EndIf
	Return false
EndFunction

Function StopHandle(Int Handle) Global
	If Handle > 0 && GetIsInstalled()
		AudioUtil.StopHandle(Handle)
	EndIf
EndFunction
