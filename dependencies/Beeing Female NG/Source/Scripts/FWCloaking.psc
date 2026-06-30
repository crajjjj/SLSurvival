Scriptname FWCloaking extends ActiveMagicEffect

Spell property BeeingFemaleSpell Auto
Spell property BeeingMaleSpell Auto
Spell property BeeingNUFemaleSpell Auto

FWSystem property System auto
MagicEffect Property BeingMaleEffect Auto
MagicEffect Property BeeingFemaleEffect Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	;FW_log.WriteLog("FWCloaking::OnEffectStart("+akTarget.GetLeveledActorBase().GetName()+", "+akCaster.GetLeveledActorBase().GetName()+")")
	If StorageUtil.FormListHas(BeeingFemaleSpell, "BF_CloakEffectList", akTarget) ;Tkc (Loverslab): optimization
	else;If !StorageUtil.FormListHas(BeeingFemaleSpell, "BF_CloakEffectList", akTarget)
		StorageUtil.FormListAdd(BeeingFemaleSpell, "BF_CloakEffectList", akTarget)
;		If (akTarget.GetFormID() < 4278190080) ;Exclude Temporary References (FormID > 0xFF000000)
;			If akTarget.HasSpell(BeeingFemaleSpell)
;				if akTarget.HasMagicEffect(BeeingFemaleEffect) ;Tkc (Loverslab): optimization
;				else;if !akTarget.HasMagicEffect(BeeingFemaleSpell.GetNthEffectMagicEffect(0))
					;FW_log.WriteLog("- Target has Female Spell already but not the Effect")
;					akTarget.RemoveSpell(BeeingFemaleSpell)
;					Utility.WaitMenuMode(2.5)
;				endif
;			endif
;			if akTarget.HasSpell(BeeingMaleSpell)
;				if akTarget.HasMagicEffect(BeingMaleEffect) ;Tkc (Loverslab): optimization
;				else;if !akTarget.HasMagicEffect(BeeingMaleSpell.GetNthEffectMagicEffect(0))
					;FW_log.WriteLog("- Target has Male Spell already but not the Effect")
;					akTarget.RemoveSpell(BeeingMaleSpell)
;					Utility.WaitMenuMode(2.5)
;				endif
;			endif
			
			;/If (! akTarget) 
				;FW_log.WriteLog("- Target is none")
				Dispel()
			
			ElseIf System.IsValidateMaleActor(akTarget) > 0;(akTarget.GetLeveledActorBase().GetSex() == 0)
				;if akTarget.HasMagicEffect(BeeingMaleSpell.GetNthEffectMagicEffect(0))==false
				if akTarget.HasSpell(BeeingMaleSpell)==false
					;FW_log.WriteLog("- Target is male - Add Spell")
					akTarget.AddSpell(BeeingMaleSpell)
				endif
			ElseIf (akTarget.GetLeveledActorBase().IsUnique())
				;if akTarget.HasMagicEffect(BeeingFemaleSpell.GetNthEffectMagicEffect(0))==false
				if akTarget.HasSpell(BeeingFemaleSpell)==false  && System.IsValidateFemaleActor(akTarget) > 0
					;FW_log.WriteLog("- Target is female unique - Add Spell")
					akTarget.AddSpell(BeeingFemaleSpell)
				endif
			ElseIf BeeingNUFemaleSpell!=none
				;if akTarget.HasMagicEffect(BeeingNUFemaleSpell.GetNthEffectMagicEffect(0))==false
				if akTarget.HasSpell(BeeingNUFemaleSpell)==false
					;FW_log.WriteLog("- Target is female non-unique - Add Spell")
					akTarget.AddSpell(BeeingNUFemaleSpell)
				endif
			EndIf/;
			;Tkc (Loverslab): optimization \/
			If akTarget			
				If System.IsValidateMaleActor(akTarget) > 0;(akTarget.GetLeveledActorBase().GetSex() == 0)
					;if akTarget.HasMagicEffect(BeeingMaleSpell.GetNthEffectMagicEffect(0))==false
					if akTarget.HasSpell(BeeingMaleSpell) ;Tkc (Loverslab): optimization
					else;if akTarget.HasSpell(BeeingMaleSpell)==false
						;FW_log.WriteLog("- Target is male - Add Spell")
						akTarget.AddSpell(BeeingMaleSpell)
					endif
				elseIf System.IsValidateFemaleActor(akTarget) > 0
					if akTarget.HasSpell(BeeingFemaleSpell)
					else
						akTarget.AddSpell(BeeingFemaleSpell)
					endIf
					
					if(System.cfg.NPCHaveItems)
						if(akTarget == System.PlayerRef)
						else
							if(akTarget.HasSpell(BeeingNUFemaleSpell))
							else
								akTarget.AddSpell(BeeingNUFemaleSpell)
							endIf
						endIf
					endIf
;				ElseIf (akTarget.GetLeveledActorBase().IsUnique())
;					;if akTarget.HasMagicEffect(BeeingFemaleSpell.GetNthEffectMagicEffect(0))==false
;					if akTarget.HasSpell(BeeingFemaleSpell) ;Tkc (Loverslab): optimization
;					else;if akTarget.HasSpell(BeeingFemaleSpell)==false
;						if System.IsValidateFemaleActor(akTarget) > 0
;							;FW_log.WriteLog("- Target is female unique - Add Spell")
;							akTarget.AddSpell(BeeingFemaleSpell)
;						endif
;					endif
;				ElseIf BeeingNUFemaleSpell
;					;if akTarget.HasMagicEffect(BeeingNUFemaleSpell.GetNthEffectMagicEffect(0))==false
;					if akTarget.HasSpell(BeeingNUFemaleSpell) ;Tkc (Loverslab): optimization
;					else;if akTarget.HasSpell(BeeingNUFemaleSpell)==false
;						;FW_log.WriteLog("- Target is female non-unique - Add Spell")
;						akTarget.AddSpell(BeeingNUFemaleSpell)
;					endif
				endIf
				
				bool myIsDispelledCustomChildActor = (StorageUtil.GetIntValue(akTarget, "FW.Child.DispelledCustomChildActor", 0) == 1)
				if(myIsDispelledCustomChildActor)
					FW_log.WriteLog("FWCloaking: Recasting DefaultCustomChildSpell to the actor " + akTarget)
					akTarget.AddSpell(System._BF_DefaultCustomChildSpell)
					StorageUtil.SetIntValue(akTarget, "FW.Child.DispelledCustomChildActor", 0)
				endIf
			Else
				;FW_log.WriteLog("- Target is none")
				Dispel()				
			EndIf
;		EndIf
	EndIf
EndEvent

; 02.06.2019 Tkc (Loverslab) optimizations: Changes marked with "Tkc (Loverslab)" comment. As I understood it most possiblt not using anymore but optimized on any case