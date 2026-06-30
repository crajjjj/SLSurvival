Scriptname FWFertilityItem extends FWSpell

; Fertility Tonic effect - the symmetric counterpart of FWContraceptionItem.
; On drink it grants the woman a timed conception-chance boost (FW.Fertility),
; which FWAbilityBeeingFemale adds to its impregnation roll. It deliberately
; does NOT touch contraception: a fertility booster should not override a
; deliberate contraceptive that is already killing the sperm.

actor ActorRef
bool bInit=false

function execute()

	if bInit==false || ActorRef==none
		return
	endif
	; The tonic tier logic (magnitude floor, Gate 2 boost, mild Gate 1 nudge /
	; potent Gate 1 force) lives in Controller.ApplyFertilityTonic so the potion
	; and the "DrinkFertilityTonic" mod event stay in lockstep. The EFIT magnitude
	; selects the tier: ~2 = mild, ~4 = potent.
	Controller.ApplyFertilityTonic(ActorRef, GetMagnitude())
endfunction

Event OnWoman(Actor akTarget, Actor akCaster)
	ActorRef = akCaster
	execute()
endEvent

Event OnInit()
	bInit=true
	parent.OnInit()
	execute()
endEvent
