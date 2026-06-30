Scriptname FWLaborPainsBase extends activemagiceffect  

FWSystem property System auto
float property DamageBase auto
float property UpdateDelay auto
int property KindOfPains auto
bool property Silent = false auto
actor ActorRef


Event OnEffectStart(Actor akTarget, Actor akCaster)
	ActorRef=akTarget
	Utility.Wait(Utility.RandomFloat( (UpdateDelay*0.75) + 2, (UpdateDelay* 1.1) + 2))
	OnUpdateGameTime()
endEvent

function OnUpdateGameTime()
	float rnd=Utility.RandomFloat(-1.0,1.0)
	if Silent ;Tkc (Loverslab): optimization
	else;if Silent==false
		System.PlayPainSound(ActorRef,(DamageBase+rnd) *4)
	endif

	; Find the list of fathers
	int my_num_men = StorageUtil.FormListCount(ActorRef, "FW.ChildFather")
	float my_LaborPains_DamageScale = 0
	float temp_LaborPains_DamageScale = 0
	actor a = none
	race abr = none
	while my_num_men > 0
		my_num_men -= 1
		a = (StorageUtil.FormListGet(ActorRef, "FW.ChildFather", my_num_men) As Actor)
		if a
			temp_LaborPains_DamageScale = StorageUtil.GetFloatValue(a, "FW.AddOn.Modify_Pain_LaborPains_by_FatherRace", 1.0)
			if(temp_LaborPains_DamageScale == 1.0)
				abr = a.GetRace()
				if abr
					temp_LaborPains_DamageScale = StorageUtil.GetFloatValue(abr, "FW.AddOn.Modify_Pain_LaborPains_by_FatherRace", 1.0)
				endIf
			endIf

			if(temp_LaborPains_DamageScale > my_LaborPains_DamageScale)
				my_LaborPains_DamageScale = temp_LaborPains_DamageScale
			endIf
		endIf
	endWhile
	my_LaborPains_DamageScale *= ((DamageBase + rnd) * (System.getDamageScale(3, ActorRef)))

	if(my_LaborPains_DamageScale > 0)
		System.DoDamage(ActorRef, my_LaborPains_DamageScale, KindOfPains)
	endIf
	; Contraction grimace WAVE - ownership handoff. The contraction drives the face
	; ONLY during OPENING contractions: still in Labor Pains (FW.CurrentState == 7) AND
	; GiveBirth not yet running (actor not in FW.GivingBirth). Once the push starts the
	; actor is in FW.GivingBirth and GiveBirth owns the face (it has the birth-stage
	; context), so we don't touch it. Grimace 3-4s, then relax until the next
	; contraction. Done BEFORE rescheduling so the wait can't overlap the next tick.
	; Audible (non-Silent) actors only.
	if !Silent && StorageUtil.GetIntValue(ActorRef, "FW.CurrentState", 0) == 7 && StorageUtil.FormListFind(none, "FW.GivingBirth", ActorRef) < 0
		int painStrength = ((DamageBase + rnd) * 4.0) as int
		if painStrength > 70
			painStrength = 70
		elseif painStrength < 15
			painStrength = 15
		endif
		System.Mimik(ActorRef, "Pained", painStrength) ; grimace
		Utility.Wait(Utility.RandomFloat(3.0, 4.0))     ; hold 3-4s
		; relax only if it's still an opening contraction; if the push began during the
		; wait, leave the face to GiveBirth rather than wiping it.
		if StorageUtil.GetIntValue(ActorRef, "FW.CurrentState", 0) == 7 && StorageUtil.FormListFind(none, "FW.GivingBirth", ActorRef) < 0
			System.Mimik(ActorRef)
		endif
	endif

	If self as string == "[FWLaborPainsBase <None>]" ;Tkc (Loverslab): optimization
	else;If self as string != "[FWLaborPainsBase <None>]"
		RegisterForSingleUpdateGameTime( Utility.RandomFloat(UpdateDelay*0.75,UpdateDelay* 1.1))
	EndIf
endFunction

; Relax our opening-contraction grimace when this effect ends - UNLESS GiveBirth is
; driving the face (the push and post-birth relief belong to GiveBirth). Mimik no-ops
; on a None/unloaded actor, so this is safe even if the actor unloaded.
Event OnEffectFinish(Actor akTarget, Actor akCaster)
	if !Silent && akTarget && StorageUtil.FormListFind(none, "FW.GivingBirth", akTarget) < 0
		System.Mimik(akTarget)
	endif
endEvent

; 02.06.2019 Tkc (Loverslab) optimizations: Changes marked with "Tkc (Loverslab)" comment