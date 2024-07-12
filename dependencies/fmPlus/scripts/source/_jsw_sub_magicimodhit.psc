scriptName _JSW_SUB_MagicIModHit extends ActiveMagicEffect

;	rewritten by subhuman to use RegisterForSingleupdate() instead of wait(), and removed unused variables

{Scripted effect play a one off Imod if the player is hit by the spell with optional removal Imod.}

;======================================================================================;
;               PROPERTIES  /
;=============/

Actor				Property	playerRef		Auto

ImageSpaceModifier	property	OnStartImodFX	auto
{main isMod for spell (MUST BE ANIMATED IMOD)}
ImageSpaceModifier	property	OnFinishImodFX	auto
{Optional ending Imod for spell (MUST BE ANIMATED IMOD)}

float Property fImodStrength = 1.0 auto
{IsMod Strength from 0.0 to 1.0}

; 2.14
Bool				Property		SetGlobal	=	False	Auto	;	do we update a global variable in OnUpdate?
Float				Property		TimeOffset	=	0.10	Auto	;	how much to offset the GV by
GlobalVariable		Property		GlobalToSet				Auto	;	optional GV to set in OnUpdate()
GlobalVariable		Property		GameDaysPassed			Auto	;	

;======================================================================================;
;	 EVENTS     /
;=============/

event	OnEffectStart(Actor Target, Actor Caster)
	
	if (Target == playerRef)
		if OnStartImodFX
			OnStartImodFX.Apply(fImodStrength)
		endIf
	endif
	if SetGlobal
		RegisterForSingleUpdate(5.0)
	endIf

endEvent

event	OnUpdate()

	if GlobalToSet && GameDaysPassed
		GlobalToSet.SetValue(GameDaysPassed.GetValue() + TimeOffset)
	endIf

endEvent

event	OnEffectFinish(Actor Target, Actor Caster)

;	GoToState("Dead")
	if OnFinishImodFX
		OnFinishImodFX.Apply(fImodStrength) 
	endif

endEvent
;/
state Dead
	event OnUpdate()
	endEvent
endState/;
