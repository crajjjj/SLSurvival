Scriptname _SLS_IntBf Hidden

; Hidden global wrappers around Beeing Female NG's API. Only this script references
; the concrete BF types (FWController / FWSystem / FWUtility); everything is reached
; through global calls so it resolves lazily and SLS loads fine when BF is absent.
;   FWController (BF_Controller, 0x00182A) - main pregnancy/sperm/state API
;   FWSystem     (BF_Main,       0x000D62) - creature-pregnancy checks
;   FWUtility    - global helpers (no instance needed)

Bool Function GetIsPregnant(Quest BfController, Actor akActor) Global
	Return (BfController as FWController).IsPregnant(akActor)
EndFunction

; Father's race of the current/last pregnancy. Creature pregnancy is detected caller-side
; from this race's voice type (CreatureTiers.json), i.e. "father is a creature".
Race Function GetPregnancyRace(Actor Mother) Global
	Return FWUtility.GetLastChildFatherRace(Mother)
EndFunction

; BF cycle/pregnancy state: 0 follicular,1 ovulating,2 luteal,3 menstruation,
; 4-6 trimesters,7 labor,8 recovery.
Int Function GetFemaleState(Quest BfController, Actor akActor) Global
	Return (BfController as FWController).GetFemaleState(akActor)
EndFunction

; Number of distinct males with conception-viable sperm currently in the actor.
Int Function GetRelevantSpermCount(Quest BfController, Actor akActor) Global
	Return (BfController as FWController).RelevantSpermCount(akActor)
EndFunction

; Donor actors of the viable sperm (for caller-side creature-race checks).
Actor[] Function GetRelevantSpermActors(Quest BfController, Actor akActor) Global
	Return (BfController as FWController).GetRelevantSpermActors(akActor)
EndFunction

; Supplementary creature-pregnancy signal via BF's Estrus integrations.
Bool Function IsPregnantByCreature(Quest BfMain, Actor akActor) Global
	FWSystem sys = BfMain as FWSystem
	If sys
		Return sys.IsActorPregnantByChaurus(akActor) || sys.IsActorPregnantByEstrusSpider(akActor) || sys.IsActorPregnantByEstrusDwemer(akActor)
	EndIf
	Return false
EndFunction

; Trigger BF's fertility tonic (used by the SLS fertility potion). Magnitude >= 3.5 forces
; the cycle fertile; below that is a milder boost.
Function DrinkFertilityTonic(Actor akActor, Float Magnitude) Global
	akActor.SendModEvent("BeeingFemale", "DrinkFertilityTonic", Magnitude)
EndFunction
