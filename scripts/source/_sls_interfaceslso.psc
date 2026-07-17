Scriptname _SLS_InterfaceSlso extends Quest

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	; Pick the separate-orgasm/enjoyment provider. P+ is checked FIRST and wins over SLSO.esp:
	; P+ does ship SLSO-compat shims on sslActorAlias (GetFullEnjoyment/BonusEnjoyment/
	; OrgasmEffect), but the PPlus state talks to the native SexLabThread API directly - no
	; shim layer, and it works in the common case where SLSO.esp isn't in the load order at all.
	String Target = ""
	If _SLS_IntSlpp.GetIsInstalled()
		Target = "PPlus"
	ElseIf Game.GetModByName("SLSO.esp") != 255
		Target = "Installed"
	EndIf
	; Outside the state-change guard: RegForEvents is also the ahegao load-heal (a period stranded
	; by a save/load keeps its 0.1s update chain and a real-time deadline from the OLD session,
	; which the new session's restarted clock may not reach for hours). Gating it on a provider
	; change skipped that heal on every ordinary load.
	Ahegao.RegForEvents()
	If GetState() != Target
		GoToState(Target)
	EndIf
EndFunction

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
EndEvent

Bool Function GetIsInterfaceActive()
	String s = GetState()
	Return s == "Installed" || s == "PPlus"
EndFunction

State Installed
	Int Function GetEnjoyment(Int tid, Actor akTarget)
		Return _SLS_IntSlso.GetEnjoyment(Sexlab, tid, akTarget)
	EndFunction
	
	Function ModEnjoyment(Int tid, Actor akTarget, Int Enjoyment)
		_SLS_IntSlso.ModEnjoyment(Sexlab, tid, akTarget, Enjoyment) 
	EndFunction
	
	Function Orgasm(Int tid, Actor akTarget, bool Force = true)
		_SLS_IntSlso.Orgasm(Sexlab, tid, akTarget, Force)
	EndFunction
EndState

; P+ folded SexLab Separate Orgasm into its core, exposing the same 0-100 enjoyment on the P+-only
; SexLabThread type (via _SLS_IntSlpp) under different names. Selected when P+ is present (see
; PlayerLoadsGame), so every Slso.* caller - ahegao, sensitivity, cocksize, experience, cumswallow,
; bodyinflation - works under P+ with no per-caller branching.
State PPlus
	Int Function GetEnjoyment(Int tid, Actor akTarget)
		Return _SLS_IntSlpp.GetEnjoyment(Sexlab, tid, akTarget)
	EndFunction

	Function ModEnjoyment(Int tid, Actor akTarget, Int Enjoyment)
		_SLS_IntSlpp.ModEnjoyment(Sexlab, tid, akTarget, Enjoyment)
	EndFunction

	Function Orgasm(Int tid, Actor akTarget, bool Force = true)
		_SLS_IntSlpp.Orgasm(Sexlab, tid, akTarget) ; P+ ForceOrgasm always forces; Force arg unused
	EndFunction
EndState

Int Function GetEnjoyment(Int tid, Actor akTarget)
	Return 0
EndFunction

Function ModEnjoyment(Int tid, Actor akTarget, Int Enjoyment)
EndFunction

Function Orgasm(Int tid, Actor akTarget, bool Force = true)
EndFunction

_SLS_Ahegao Property Ahegao Auto
SexlabFramework Property Sexlab Auto
