Scriptname _SLS_CumDesperateEffects extends ReferenceAlias  

Event OnInit()
	If Self.GetOwningQuest().IsRunning()
		RegisterForMenu("Dialogue Menu")
	EndIf
EndEvent

Event OnMenuOpen(String MenuName)
	Actor akActor = Game.GetCurrentCrosshairRef() as Actor
	If akActor && akActor.IsInDialogueWithPlayer() && (akActor.GetRace().IsRaceFlagSet(0x00000001) || _SLS_HumanTypeVoiceList.HasForm(akActor.GetVoiceType()))
		StorageUtil.FormListAdd(None, "_SLS_DaydreamActors", akActor)
		Bool Completed = false
		Int Gender = Sexlab.GetGender(akActor) ; GetGender honors SexLab gender overrides (futa = 2); base GetSex does not
		If Gender == 0 || Gender == 2 ; Male
			; Strip everything strippable (skip feet/index 7 and SexlabNoStrip-flagged items) so the
			; daydream works even when only partially clothed - the old code only checked the body slot.
			Bool Removed = false
			Int s = 0
			Form WornForm
			While s < Menu.SlotMasks.Length
				WornForm = akActor.GetWornForm(Menu.SlotMasks[s])
				If s != 7 && WornForm && !WornForm.HasKeyword(Menu.SexlabNoStrip)
					Removed = true
					akActor.UnequipItem(WornForm, abPreventEquip = false, abSilent = true)
				EndIf
				s += 1
			EndWhile
			If Removed ; only flag for re-dress on close if something was actually taken off
				akActor.AddToFaction(_SLS_DaydreamHadClothesFact)
				Utility.WaitMenuMode(1.0)
			EndIf
			Sos.MakeErect(akActor)
			Debug.SendAnimationEvent(akActor, "SOSFastErect")
			_SLS_LookAtMarkerRef.MoveTo(akActor, 0.0, 0.0, akActor.GetHeight() - 65.0)
			AllInOneKey.BeginLookAt(akTarget = _SLS_LookAtMarkerRef, MoveMarker = false)
			;Debug.SendAnimationEvent(PlayerRef, "DDBeltedSolo")
			Voices.Begin()
			Completed = UI.IsMenuOpen("Dialogue Menu")
		Else ; Female
			Completed = DoFemaleConvoEffect(akActor)
		EndIf
		If Completed
			If !PlayerRef.WornHasKeyword(_SLS_TongueKeyword)
				AllInOneKey.ToggleTongue(Utility.RandomInt(0, 15))
			EndIf
			If !sslBaseExpression.IsMouthOpen(PlayerRef)
				CumSwallow.OnKeyDown(0)
			EndIf
		EndIf
	EndIf
EndEvent

Bool Function DoFemaleConvoEffect(Actor akActor)
	If Sexlab.CountCumOral(akActor) == 0
		; Voice-pack categories: "NearOrgasmNoises" is the A-layout non-verbal moan; B-layout
		; packs ship "Penetrated Grunt"(+" Intense") instead (resolved per-NPC in DoMoans).
		; "Orgasm" ships in both layouts. The Sound forms stay as the no-pack fallback.
		If !DoMoans(akActor, SexLabVoiceFemale01Mild, Reps = 3, StartVol = 0.3, EndVol = 0.5, WaitMin = 1.0, WaitMax = 1.8, ACategory = "NearOrgasmNoises", BCategory = "Penetrated Grunt")
			Return false
		EndIf
		If !DoMoans(akActor, SexLabVoiceFemale01Medium, Reps = 3, StartVol = 0.5, EndVol = 0.9, WaitMin = 0.9, WaitMax = 1.6, ACategory = "NearOrgasmNoises", BCategory = "Penetrated Grunt")
			Return false
		EndIf
		If !DoMoans(akActor, SexLabVoiceFemale01Hot, Reps = 1, StartVol = 1.0, EndVol = 1.0, WaitMin = 0.8, WaitMax = 1.0, ACategory = "NearOrgasmNoises", BCategory = "Penetrated Grunt Intense")
			Return false
		EndIf
		If !DoMoans(akActor, SexLabOrgasmFX, Reps = 1, StartVol = 1.0, EndVol = 1.0, WaitMin = 0.1, WaitMax = 0.2, ACategory = "Orgasm")
			Return false
		EndIf
		If !DoMoans(akActor, SexLabOrgasmFX, Reps = 1, StartVol = 1.0, EndVol = 1.0, WaitMin = 0.1, WaitMax = 0.2, ACategory = "Orgasm")
			Return false
		EndIf
		
		If Utility.RandomInt(0, 1) == 0
			Util.BeginOverlay(akActor, Alpha = 1.0, TextureToApply = "\\SL Survival\\Oral1.dds", Area = "Face")
			Util.BeginOverlay(akActor, Alpha = 1.0, TextureToApply = "\\SL Survival\\Oral1.dds", Area = "Body")
		Else
			Util.BeginOverlay(akActor, Alpha = 1.0, TextureToApply = "\\SL Survival\\Oral2.dds", Area = "Face")
			Util.BeginOverlay(akActor, Alpha = 1.0, TextureToApply = "\\SL Survival\\Oral2.dds", Area = "Body")
		EndIf
	EndIf
	Return true
EndFunction

Event OnMenuClose(String MenuName)
	;Debug.Messagebox("Shutdown: \n" + StorageUtil.FormListToArray(None, "_SLS_DaydreamActors"))
	Actor akActor
	Voices.End()
	AllInOneKey.ClearLookAtTarget()
	;Debug.SendAnimationEvent(PlayerRef,"IdleForceDefaultState")
	Int i = StorageUtil.FormListCount(None, "_SLS_DaydreamActors")
	While i > 0
		i -= 1
		akActor = StorageUtil.FormListGet(None, "_SLS_DaydreamActors", i) as Actor
		If akActor
			akActor.RemoveFromFaction(_SLS_DaydreamHadClothesFact)
			Int Gender = Sexlab.GetGender(akActor) ; GetGender honors SexLab gender overrides (futa = 2); base GetSex does not
			If Gender == 0 || Gender == 2 ; Male
				akActor.AddItem(_SLS_HalfNakedCoverArmor, 1) ; Adding seems to refresh the outfit more reliably than removing
				akActor.RemoveItem(_SLS_HalfNakedCoverArmor, 999)

			Else
				Util.RemoveOverlay(akActor, TextureToRemove = "\\SL Survival\\Oral1.dds", Area = "Face")
				Util.RemoveOverlay(akActor, TextureToRemove = "\\SL Survival\\Oral2.dds", Area = "Face")
				Util.RemoveOverlay(akActor, TextureToRemove = "\\SL Survival\\Oral1.dds", Area = "Body")
				Util.RemoveOverlay(akActor, TextureToRemove = "\\SL Survival\\Oral2.dds", Area = "Body")
			EndIf
		EndIf
		StorageUtil.FormListRemoveAt(None, "_SLS_DaydreamActors", i)
	EndWhile
	If PlayerRef.WornHasKeyword(_SLS_TongueKeyword)
		AllInOneKey.ToggleTongue(0)
	EndIf
	If sslBaseExpression.IsMouthOpen(PlayerRef)
		CumSwallow.OnKeyDown(1) ; Dont send zero
	EndIf
EndEvent

Bool Function DoMoans(Actor akActor, Sound Moan, Int Reps, Float StartVol, Float EndVol, Float WaitMin, Float WaitMax, String ACategory = "", String BCategory = "")
	Int i = 0
	Float VolMod = StorageUtil.GetFloatValue(Menu, "CumAddictDayDreamVol", Missing = 1.0)
	; Resolve the voice-pack category once per tier: variation-aware (a B-layout slot gets
	; the B label when it ships that folder). "" = legacy Sound form only. The NPC herself
	; is the moaner, so this resolves against HER slot - each daydream NPC keeps her own
	; pack voice. Lipsync is auto-suppressed while she is in dialogue (the game owns the
	; mouth), so the moan plays without fighting the dialogue face.
	String Category = ""
	If ACategory != ""
		Category = _SLS_IntAudioUtil.ResolveCategory(akActor, ACategory, BCategory)
	EndIf
	While i < Reps
		If UI.IsMenuOpen("Dialogue Menu")
			Float Vol = (StartVol + ((EndVol - StartVol)/Reps) * i) * VolMod
			Bool Played = false
			If Category != ""
				Played = _SLS_IntAudioUtil.PlayVoice(akActor, Category, Vol, "sls_voice") > 0
			EndIf
			If !Played
				Int MoanInst = Moan.Play(akActor)
				Sound.SetInstanceVolume(MoanInst, Vol)
			EndIf
			i += 1
			Utility.Wait(Utility.RandomFloat(WaitMin, WaitMax))
		Else
			Return false
		EndIf
	EndWhile
	Return true
EndFunction

Actor Property PlayerRef Auto

Faction Property _SLS_DaydreamHadClothesFact Auto

ObjectReference Property _SLS_LookAtMarkerRef Auto

Armor Property _SLS_HalfNakedCoverArmor Auto

Keyword Property _SLS_TongueKeyword Auto

Sound Property SexLabVoiceFemale01Mild Auto
Sound Property SexLabVoiceFemale01Medium Auto
Sound Property SexLabVoiceFemale01Hot Auto
Sound Property SexLabOrgasmFX Auto

Formlist Property _SLS_HumanTypeVoiceList Auto

SLS_Mcm Property Menu Auto
SLS_Utility Property Util Auto
SexlabFramework Property Sexlab Auto
_SLS_CumSwallow Property CumSwallow Auto
_SLS_CumDesperationVoices Property Voices Auto
_SLS_AllInOneKey Property AllInOneKey Auto
_SLS_InterfaceSos Property Sos Auto
