Scriptname zbfExternal Extends zbfExternalInterface

zbfConfig Property Config Auto

; This script should not be accessed directly. Instead use ::zbfExternalInterface, or otherwise there
; may be significant dependencies needed just to compile the code.
; 
; code: Example how to use this script.
; zbfExternalInterface external = zbfExternalInterface.GetApi()
; external.SetOverlay(...)
; 

Bool bSlaveTats

Bool Function Initialize()
	Start()
	Int iSafety = 50
	While !IsRunning() && iSafety > 0
		iSafety -= 1
		Utility.Wait(0.1)
	EndWhile
	
	sSlaveTatsVersion = IntGetSlaveTatsVersion()
	iRaceMenuVersion = IntGetRaceMenuVersion()
	iNsapVersion = IntGetNsapVersion()

	IntFetchSexLabVersion()

	bSlaveTats = (sSlaveTatsVersion != "")

	Return Parent.Initialize()
EndFunction

; @section: Interface
; 
; These are the override versions of the interface in zbfExternalInterface::
; 

Function SetOverlay(Actor akActor, String asOverlayName, String asSection)
	If bSlaveTats
		SetOverlay_SlaveTats(akActor, asOverlayName, asSection)
	EndIf
EndFunction

Function RemoveOverlay(Actor akActor, String asOverlayName, String asSection)
	If bSlaveTats
		RemoveOverlay_SlaveTats(akActor, asOverlayName, asSection)
	EndIf
EndFunction

Function SynchronizeOverlay(Actor akActor)
	If bSlaveTats
		SynchronizeOverlay_SlaveTats(akActor)
	EndIf
EndFunction


; @section: SlaveTats
; 
; Implementation for SlaveTats.
; 
Function SetOverlay_SlaveTats(Actor akActor, String asOverlayName, String asSection)
	If asOverlayName != ""
		Bool result = SlaveTats.simple_add_tattoo(akActor, asSection, asOverlayName, 0, false, false)
		Log("SetOverlay(" + asOverlayName + ", " + asSection + ") failed on " + zbfUtil.GetActorName(akActor), result == False, iWarning)
	EndIf
EndFunction

Function RemoveOverlay_SlaveTats(Actor akActor, String asOverlayName, String asSection)
	If asOverlayName != ""
		Bool result = SlaveTats.simple_remove_tattoo(akActor, asSection, asOverlayName, false,false)
		Log("RemoveOverlay(" + asOverlayName + ", " + asSection + ") failed on " + zbfUtil.GetActorName(akActor), result == False, iWarning)
	EndIf
EndFunction

Function SynchronizeOverlay_SlaveTats(Actor akActor)
	Bool failed = SlaveTats.synchronize_tattoos(akActor, silent = True)
	If !failed
		JValue.cleanPool("SlaveTatsHighLevel")
	EndIf

	Log("SynchronizeOverlay failed on " + zbfUtil.GetActorName(akActor), failed, iError)
EndFunction

Actor[] Function GetSelectedActors()
	Return Config.SelectSlots
EndFunction

Actor[] Function GetSelectedSexLabActors()
	Return Config.SexLabActors
EndFunction


; @section: Private
; 
; Private functions and methods go here. Don't call these directly.
; 

Int Function IntGetNsapVersion()
	If Game.GetModByName("NonSexLabAnimationPack.esp")  != 255
		SKI_ConfigBase configBase = Game.GetFormFromFile(0x000D62, "NonSexLabAnimationPack.esp") As SKI_ConfigBase
		Log("NonSexLabAnimationPack found, but config quest could not be retrieved.", configBase == None, iWarning)
		If configBase != None
			Return configBase.GetVersion()
		EndIf
	EndIf

	Return 0
EndFunction

String Function IntGetSlaveTatsVersion()
	If Game.GetModByName("SlaveTats.esp")  != 255
		Return SlaveTats.VERSION()
	EndIf
	Return ""
EndFunction

Int Function IntGetRaceMenuVersion()
	If Game.GetModByName("RaceMenu.esp")  != 255
		Return RaceMenuBase.GetScriptVersionRelease()
	EndIf
	Return 0
EndFunction

Function IntFetchSexLabVersion()
	iSexLabVersion = 0
	sSexLabVersion = ""
	If Game.GetModByName("SexLab.esm")  != 255
		iSexLabVersion = SexLabUtil.GetVersion()
		sSexLabVersion = SexLabUtil.GetStringVer()
	EndIf
EndFunction

Int iAlways = -1
Int iError = 0
Int iWarning = 1
Int iInfo = 2
Function Log(String asMessage, Bool abCondition = True, Int aiLevel = 2)
	If abCondition && (aiLevel <= iDebugLevel)
		Debug.Trace("zbfExternal: " + asMessage)
	EndIf
EndFunction
