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
		If (akActor.GetLeveledActorBase().GetSex() == 0) ; Male
			If akActor.GetWornForm(0x00000004)
				akActor.AddToFaction(_SLS_DaydreamHadClothesFact)
				Utility.WaitMenuMode(1.0)
				akActor.UnequipItem(akActor.GetWornForm(0x00000004))
				Sos.MakeErect(akActor)
				_SLS_LookAtMarkerRef.MoveTo(akActor, 0.0, 0.0, akActor.GetHeight() - 65.0)
				AllInOneKey.BeginLookAt(akTarget = _SLS_LookAtMarkerRef, MoveMarker = false)
				;Debug.SendAnimationEvent(PlayerRef, "DDBeltedSolo")
				Voices.Begin()
				Completed = UI.IsMenuOpen("Dialogue Menu")
			EndIf
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
		If !DoMoans(akActor, SexLabVoiceFemale01Mild, Reps = 3, StartVol = 0.3, EndVol = 0.5, WaitMin = 1.0, WaitMax = 1.8)
			Return false
		EndIf
		If !DoMoans(akActor, SexLabVoiceFemale01Medium, Reps = 3, StartVol = 0.5, EndVol = 0.9, WaitMin = 0.9, WaitMax = 1.6)
			Return false
		EndIf
		If !DoMoans(akActor, SexLabVoiceFemale01Hot, Reps = 1, StartVol = 1.0, EndVol = 1.0, WaitMin = 0.8, WaitMax = 1.0)
			Return false
		EndIf
		If !DoMoans(akActor, SexLabOrgasmFX, Reps = 1, StartVol = 1.0, EndVol = 1.0, WaitMin = 0.1, WaitMax = 0.2)
			Return false
		EndIf
		If !DoMoans(akActor, SexLabOrgasmFX, Reps = 1, StartVol = 1.0, EndVol = 1.0, WaitMin = 0.1, WaitMax = 0.2)
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
			If (akActor.GetLeveledActorBase().GetSex() == 0) ; Male
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

Bool Function DoMoans(Actor akActor, Sound Moan, Int Reps, Float StartVol, Float EndVol, Float WaitMin, Float WaitMax)
	Int i = 0
	Float VolMod = StorageUtil.GetFloatValue(Menu, "CumAddictDayDreamVol", Missing = 1.0)
	While i < Reps
		If UI.IsMenuOpen("Dialogue Menu")
			Int MoanInst = Moan.Play(akActor)
			Sound.SetInstanceVolume(MoanInst, (StartVol + ((EndVol - StartVol)/Reps) * i) * VolMod)
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
