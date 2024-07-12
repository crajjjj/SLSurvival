Scriptname _STA_InterfaceDeviousDevices extends Quest  

Event OnInit()
	RegisterForModEvent("_STA_Int_PlayerLoadsGame", "On_STA_Int_PlayerLoadsGame")
	RegisterForSingleUpdate(15.0)
EndEvent

Event OnUpdate()
	PlayerLoadsGame()
EndEvent

Event On_STA_Int_PlayerLoadsGame()
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("Devious Devices - Integration.esm") != 255
		If GetState() != "Installed"
			GoToState("Installed")
		EndIf
	
	Else
		If GetState() != ""
			GoToState("")
		EndIf
	EndIf
EndFunction

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

; Installed =======================================
State Installed
	Bool  Function GetIsVibrating(Actor akTarget)
		Return _STA_IntDevious.GetIsVibrating(zadQuest, akTarget)
	EndFunction

	Bool Function GetIsAnimating(Actor akTarget)
		Return _STA_IntDevious.GetIsAnimating(zadQuest, akTarget)
	EndFunction
	
	Int Function VibrateEffect(actor akActor, int vibStrength, int duration, bool teaseOnly = false, bool silent = true)
	;/
	vibStrength: 
	if vibStrength == 5
		vibSoundSelect = VibrateVeryStrongSound
	elseIf vibStrength == 4
		vibSoundSelect = VibrateStrongSound
	elseIf vibStrength == 3
		vibSoundSelect = VibrateStandardSound
	elseIf vibStrength == 2
		vibSoundSelect = VibrateWeakSound
	elseIf vibStrength == 1
		vibSoundSelect = VibrateVeryWeakSound
	/;
		Return _STA_IntDevious.VibrateEffect(zadQuest, akActor, vibStrength, duration, teaseOnly, silent)
	EndFunction
	
	Function EdgeActor(Actor akActor)
		_STA_IntDevious.EdgeActor(zadQuest, akActor)
	EndFunction
	
	Bool Function HasVibeKeyword(Form akForm)
		If akForm.HasKeyword(zad_EffectVibratingWeak) || akForm.HasKeyword(zad_EffectLively) || akForm.HasKeyword(zad_EffectVeryLively) || akForm.HasKeyword(zad_EffectVibratingVeryStrong) || akForm.HasKeyword(zad_EffectVibrating) || akForm.HasKeyword(zad_EffectVibratingStrong) || akForm.HasKeyword(zad_EffectVibratingVeryWeak) ; One keyword for anything that vibrates would have been nice....
			Return true
		EndIf
		Return false
	EndFunction
	
	Bool Function HasVibeNipplePiercings(Actor akTarget)
		Form akForm = akTarget.GetWornForm(0x00200000)
		If akForm && HasVibeKeyword(akForm)
			Return true
		EndIf
		Return false
	EndFunction

	Bool Function HasVibePlugs(Actor akTarget)
		Form akForm = akTarget.GetWornForm(0x08000000) ; Vag plug
		If akForm && HasVibeKeyword(akForm)
			Return true
		EndIf
		akForm = akTarget.GetWornForm(0x00040000) ; Anal plug
		If akForm && HasVibeKeyword(akForm)
			Return true
		EndIf
		Return false
	EndFunction
EndState

; Not Installed ====================================

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
	zadQuest = Game.GetFormFromFile(0x00F624, "Devious Devices - Integration.esm") as Quest
	
	zad_EffectLively = Game.GetFormFromFile(0x01EDFA, "Devious Devices - Integration.esm") as Keyword
	zad_EffectVeryLively = Game.GetFormFromFile(0x01EDFB, "Devious Devices - Integration.esm") as Keyword
	zad_EffectVibrating = Game.GetFormFromFile(0x01DDCA, "Devious Devices - Integration.esm") as Keyword
	zad_EffectVibratingVeryWeak = Game.GetFormFromFile(0x01DDC9, "Devious Devices - Integration.esm") as Keyword
	zad_EffectVibratingWeak = Game.GetFormFromFile(0x01DDC8, "Devious Devices - Integration.esm") as Keyword
	zad_EffectVibratingStrong = Game.GetFormFromFile(0x01DDC7, "Devious Devices - Integration.esm") as Keyword
	zad_EffectVibratingVeryStrong = Game.GetFormFromFile(0x01DDC6, "Devious Devices - Integration.esm") as Keyword
EndEvent

Bool Function GetIsVibrating(Actor akTarget)
	Return false
EndFunction

Bool Function GetIsAnimating(Actor akTarget)
	Return false
EndFunction

Int Function VibrateEffect(actor akActor, int vibStrength, int duration, bool teaseOnly = false, bool silent = true)
EndFunction

Function EdgeActor(Actor akActor)
EndFunction

Bool Function HasVibeKeyword(Form akForm)
	Return false
EndFunction

Bool Function HasVibeNipplePiercings(Actor akTarget)
	Return false
EndFunction

Bool Function HasVibePlugs(Actor akTarget)
	Return false
EndFunction

Keyword zad_EffectLively
Keyword zad_EffectVeryLively
Keyword zad_EffectVibrating
Keyword zad_EffectVibratingVeryWeak
Keyword zad_EffectVibratingWeak
Keyword zad_EffectVibratingStrong
Keyword zad_EffectVibratingVeryStrong

Quest zadQuest
