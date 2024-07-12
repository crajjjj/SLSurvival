Scriptname zbfExternalInterface Extends Quest

; @section: Support
; 
; All these functions return boolean values indicating if support for a particular feature is present.
; 

; Detected capabilities.
; 
; Only read these values. They are overwritten at game load.
; 
; ::HasOverlay - Indicates support for overlay effects, such as drool, dirt and scars.  
; ::HasNsapAnimation - Support for Non-sexlab Animation Pack animations. Some of these are required for animations in zbfSexLab::
; 
Bool Function HasOverlay()
	Return bHasOverlay
EndFunction
Bool Function HasNsapAnimation()
	Return bHasNsapAnimation
EndFunction
Bool Function HasSexLab()
	Return bHasSexLab
EndFunction

; @section: Versions
; 

; Non-SexLab Animation Pack version
Int Function GetNsapVersion()
	Return iNsapVersion
EndFunction

; SlaveTats version
String Function GetSlaveTatsVersion()
	Return sSlaveTatsVersion
EndFunction

; RaceMenu version
Int Function GetRaceMenuVersion()
	Return iRaceMenuVersion
EndFunction

Int Function GetSexLabVersion()
	Return iSexLabVersion
EndFunction
String Function GetSexLabStringVersion()
	Return sSexLabVersion
EndFunction

; Retrieves the global _instance_ implementing the interface.
; 
; The interface is in all cases left empty, so that other mods can still depend on this code,
; and any way compile their code without all the dependencies.
; 
zbfExternalInterface Function GetApi() Global
	Return zbfUtil.GetGenericForm(0x02014ee3) As zbfExternalInterface
EndFunction

; @section: Interface
; 
; Contains all the methods used in the public api. These are all left empty, and will be implemented in
; ::zbfExternal. The reason for this setup is so that anyone depending on this file should not also have
; to have ::zbfExternal ready to compile. ::zbfExternal requires a significant number of mods to just compile
; so avoiding to that is a good idea.
; 

Function SetOverlay(Actor akActor, String asOverlayName, String asSection)
EndFunction

Function RemoveOverlay(Actor akActor, String asOverlayName, String asSection)
EndFunction

Function SynchronizeOverlay(Actor akActor)
EndFunction

; Returns the actors selected in zbfConfig
; 
Actor[] Function GetSelectedActors()
	Actor[] empty
	Return empty
EndFunction

; Returns the actors selected for SexLab in zbfConfig
; 
Actor[] Function GetSelectedSexLabActors()
	Actor[] empty
	Return empty
EndFunction


; @section: Private
; 
; Private functions and methods go here. Don't call these directly.
; 

Bool bHasOverlay
Bool bHasNsapAnimation
Bool bHasSexLab

String Property sSlaveTatsVersion Auto Hidden
Int Property iRaceMenuVersion Auto Hidden
Int Property iNsapVersion Auto Hidden
Int Property iSexLabVersion Auto Hidden
String Property sSexLabVersion Auto Hidden

; Initialization function. Fetches versions and capabilities from all mods.
; 
Bool Function Initialize()
	bHasOverlay = (sSlaveTatsVersion != "")
	bHasNsapAnimation = (iNsapVersion >= 11)
	bHasSexLab = iSexLabVersion >= 15000

	Log("Compatibility checking", aiLevel = iAlways)
	Log("-------------------------------------------------------", aiLevel = iAlways)
	Log("                   SexLab version: " + GetSexLabVersion(), aiLevel = iAlways)
	Log("                SlaveTats version: " + GetSlaveTatsVersion(), aiLevel = iAlways)
	Log("                 RaceMenu version: " + GetRaceMenuVersion(), aiLevel = iAlways)
	Log("Non SexLab Animation Pack version: " + GetNsapVersion(), aiLevel = iAlways)
	Log("-------------------------------------------------------", aiLevel = iAlways)
	Log("                   SexLab support: " + bHasSexLab, aiLevel = iAlways)
	Log("                  Overlay support: " + bHasOverlay, aiLevel = iAlways)
	Log("     Non SexLab Animation support: " + bHasNsapAnimation, aiLevel = iAlways)
	Log("-------------------------------------------------------", aiLevel = iAlways)

	Return IsRunning()
EndFunction

Int Property iDebugLevel Auto Hidden
Int iAlways = -1
Int iError = 0
Int iWarning = 1
Int iInfo = 2
Function Log(String asMessage, Bool abCondition = True, Int aiLevel = 2)
	If abCondition && (aiLevel <= iDebugLevel)
		Debug.Trace("zbfExternal: " + asMessage)
	EndIf
EndFunction
