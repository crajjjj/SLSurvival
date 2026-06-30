Scriptname BFA_AbilityEffectPMSSexHurt extends activemagiceffect  

FWSystem property System Auto
SexLabFramework SexLab 

Quest Property BF_SSL Auto

float iSexHurt = 0.0
bool IsPlayer
float DamageScale
actor PlayerRef

Actor Property PlayerRefActor Auto

Event OnEffectStart(Actor target, Actor caster)
	PlayerRef = target
	
	If PlayerRef == PlayerRefActor
		IsPlayer = true
		Sexlab = (BF_SSL as BFA_ssl).Sexlab
		RegisterForModEvent("HookOrgasmStart", "OnSexLabOrgasm")
		RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
		RegisterForModEvent("HookStageStart", "SexLabStageEnter")
		RegisterForModEvent("HookPositionChange", "SexLabStageEnter")
		RegisterForModEvent("HookAnimationEnd", "SexLabStageExit")
		RegisterForSingleUpdate(2)
	Else
		Dispel()
	EndIf
endEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	;UnregisterForUpdate()
	;UnRegisterForModEvent("OrgasmStart")
	;UnRegisterForModEvent("StageStart")
	;UnRegisterForModEvent("PositionChange")
	;UnRegisterForModEvent("EndThread")
EndEvent

;Event onSexLabOrgasm(string hookName, string argString, float argNum, form sender)
Event OnSexLabOrgasm(int tid, bool HasPlayer)
	OrgasmHurts(tid, 2.0, 2.5, 2.8)
EndEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int tid)
	if ActorRef == PlayerRef ;Tkc (Loverslab): optimization
	else;if (ActorRef != PlayerRef)
		OrgasmHurts(tid, 1.1, 1.2, 1.3)
	endif
EndEvent

;Event SexLabStageEnter(string hookName, string argString, float argNum, form sender)
Event SexLabStageEnter(int tid, bool HasPlayer)
	OrgasmHurts(tid, 1.1, 1.2, 1.3)
EndEvent

Function OrgasmHurts(Int thread, float default, float rough, float aggressive)
	sslThreadController ssl_controller = SexLab.GetController(thread)
	if ssl_controller ;Tkc (Loverslab): optimization
	else;if ssl_controller==none
		return
	endif
	sslBaseAnimation animation = ssl_controller.Animation
	Int NumberOfActors = animation.PositionCount
	;If animation.HasTag("Vaginal") && (NumberOfActors > 1) && (ssl_controller.Positions.Find(PlayerRef) == 0)
	If animation.HasTag("Vaginal") ;Tkc (Loverslab): optimization
	 if NumberOfActors > 1
	  if ssl_controller.Positions.Find(PlayerRef)
	  else;if ssl_controller.Positions.Find(PlayerRef) == 0
		If IsPlayer
			float currentHP = PlayerRef.GetActorValue("Health")
			float toDMG = ((PlayerRef.GetBaseActorValue("Health") / 10) * iSexHurt * System.getDamageScale(2,PlayerRef))
			If currentHP - toDMG < 10
				toDMG = currentHP - 10
			EndIf
			If toDMG > 0
				PlayerRef.DamageActorValue("Health", toDMG);
			EndIf
		EndIf
		iSexHurt = default
		if animation.HasTag("Rough")
			iSexHurt += rough
		endIf
		if animation.HasTag("Aggressive")
			iSexHurt += aggressive
		endIf
	  EndIf
	 EndIf
	EndIf
EndFunction

;Event SexLabStageExit(string hookName, string argString, float argNum, form sender)
Event SexLabStageExit(int tid, bool HasPlayer)
	iSexHurt = 0
EndEvent

Event OnUpdate()
	;if PlayerRef && IsPlayer && (iSexHurt > 0) && (PlayerRef.GetActorValue("Health") > 20); && isFormValid() ;***Edit by Bane
	if PlayerRef ;Tkc (Loverslab): optimization ; atleast compilled script become smaller
		if IsPlayer
			if (iSexHurt > 0)
				if (PlayerRef.GetActorValue("Health") > 20)
					System.DoDamage(PlayerRef,iSexHurt,2) ; Do PMS Damage
				endIf
			endIf
		endIf
	endIf
	If Self as string == "[BFA_AbilityEffectPMSSexHurt <None>]" ;Tkc (Loverslab): optimization
	else;If Self as string != "[BFA_AbilityEffectPMSSexHurt <None>]"
		RegisterForSingleUpdate(2)
	EndIf
endEvent

; 02.06.2019 Tkc (Loverslab) optimizations: Changes marked with "Tkc (Loverslab)" comment