Scriptname _SLS_InterfaceFm extends Quest

; Unified pregnancy interface. Aggregates Beeing Female (preferred) and Fertility Mode.
; Empty state = neither installed (safe no-ops); "Installed" = FM and/or BF present.
; The name is kept as _SLS_InterfaceFm so the existing CK quest/script attachment and the
; "Fm" property fills on consumers keep working - it now also serves Beeing Female through
; the _SLS_IntBf globals, preferring BF over FM when both are present.

Quest FmQuest       ; Fertility Mode   0x000D62 (Fertility Mode.esm)
Quest BfController   ; BF FWController  0x00182A (BeeingFemale.esm)
Quest BfMain         ; BF FWSystem      0x000D62 (BeeingFemale.esm)
Bool FmActive
Bool BfActive

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("Fertility Mode.esm") != 255 || Game.GetModByName("BeeingFemale.esm") != 255
		If GetState() != "Installed"
			GoToState("Installed") ; OnEndState resolves the providers
		Else
			; Already "Installed": no transition fires, so OnEndState won't run. Re-resolve here so a
			; provider added after the interface first went Installed (e.g. BF added to a save that
			; already had FM) is picked up - its quests resolve and its mod events get registered.
			ResolveProviders()
		EndIf
	Else
		If GetState() != ""
			GoToState("")
		EndIf
	EndIf
EndFunction

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
	ResolveProviders()
EndEvent

Function ResolveProviders()
	FmActive = Game.GetModByName("Fertility Mode.esm") != 255
	BfActive = Game.GetModByName("BeeingFemale.esm") != 255
	If FmActive
		FmQuest = Game.GetFormFromFile(0x000D62, "Fertility Mode.esm") as Quest
	EndIf
	If BfActive
		BfController = Game.GetFormFromFile(0x00182A, "BeeingFemale.esm") as Quest
		BfMain = Game.GetFormFromFile(0x000D62, "BeeingFemale.esm") as Quest
		RegisterForModEvent("BeeingFemaleConception", "OnBeeingFemaleConception")
		RegisterForModEvent("BeeingFemaleLabor", "OnBeeingFemaleLabor")
	EndIf
EndFunction

Bool Function GetIsInterfaceActive()
	Return GetState() == "Installed"
EndFunction

State Installed
	Bool Function GetIsPregnant(Actor akActor)
		If BfActive
			Return _SLS_IntBf.GetIsPregnant(BfController, akActor)
		EndIf
		Return _SLS_IntFm.GetIsPregnant(FmQuest, akActor)
	EndFunction

	Bool Function GetGaveBirth(Actor akActor)
		If FmActive
			Return _SLS_IntFm.GetGaveBirth(FmQuest, akActor)
		EndIf
		Return false
	EndFunction

	Race Function GetPregnancyRace(Actor PregnantActor)
		If BfActive
			; BF's GetLastChildFatherRace returns the last child's father even after birth;
			; gate on IsPregnant so this honours FM's "None unless currently pregnant" contract.
			If _SLS_IntBf.GetIsPregnant(BfController, PregnantActor)
				Return _SLS_IntBf.GetPregnancyRace(PregnantActor)
			EndIf
			Return None
		EndIf
		Return _SLS_IntFm.GetPregnancyRace(FmQuest, PregnantActor)
	EndFunction

	; --- Beeing Female specific (default when BF absent) ---
	Int Function GetFemaleState(Actor akActor)
		If BfActive
			Return _SLS_IntBf.GetFemaleState(BfController, akActor)
		EndIf
		Return -1
	EndFunction

	Int Function GetRelevantSpermCount(Actor akActor)
		If BfActive
			Return _SLS_IntBf.GetRelevantSpermCount(BfController, akActor)
		EndIf
		Return 0
	EndFunction

	Actor[] Function GetRelevantSpermActors(Actor akActor)
		If BfActive
			Return _SLS_IntBf.GetRelevantSpermActors(BfController, akActor)
		EndIf
		Actor[] Empty
		Return Empty
	EndFunction

	Bool Function IsPregnantByCreature(Actor akActor)
		If BfActive
			Return _SLS_IntBf.IsPregnantByCreature(BfMain, akActor)
		EndIf
		Return false
	EndFunction

	; --- BF conception/labor relays (player only) -> SLS namespace ---
	Event OnBeeingFemaleConception(Form Mother, Int ChildCount, Form Father0, Form Father1, Form Father2)
		If (Mother as Actor) == Game.GetPlayer()
			Int e = ModEvent.Create("_SLS_BfConception")
			If e
				ModEvent.PushInt(e, ChildCount)
				ModEvent.PushForm(e, Father0)
				ModEvent.Send(e)
			EndIf
		EndIf
	EndEvent

	Event OnBeeingFemaleLabor(Form Mother, Int ChildCount, Form Father0, Form Father1, Form Father2)
		If (Mother as Actor) == Game.GetPlayer()
			Int e = ModEvent.Create("_SLS_BfLabor")
			If e
				ModEvent.PushInt(e, ChildCount)
				ModEvent.PushForm(e, Father0)
				ModEvent.Send(e)
			EndIf
		EndIf
	EndEvent
EndState

; ---- Empty-state no-op fallbacks (neither FM nor BF installed) ----
Bool Function GetIsPregnant(Actor akActor)
	Return false
EndFunction

Bool Function GetGaveBirth(Actor akActor)
	Return false
EndFunction

Race Function GetPregnancyRace(Actor PregnantActor)
	Return None
EndFunction

Int Function GetFemaleState(Actor akActor)
	Return -1
EndFunction

Int Function GetRelevantSpermCount(Actor akActor)
	Return 0
EndFunction

Actor[] Function GetRelevantSpermActors(Actor akActor)
	Actor[] Empty
	Return Empty
EndFunction

Bool Function IsPregnantByCreature(Actor akActor)
	Return false
EndFunction

Event OnBeeingFemaleConception(Form Mother, Int ChildCount, Form Father0, Form Father1, Form Father2)
EndEvent

Event OnBeeingFemaleLabor(Form Mother, Int ChildCount, Form Father0, Form Father1, Form Father2)
EndEvent
