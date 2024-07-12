Scriptname MilkQUEST_Conditions extends Quest Conditional
{conditions for Milk Mod Economy }
;this used for conditions in CK/esp

;----------------------------------------------------------------------------
;(De)Buffs
;----------------------------------------------------------------------------

Bool Property ExhaustionDebuff = True Auto Conditional
Int Property ExhaustionMode Auto Conditional
; anyting = exhausion debuff until sleep or 1 day
; 300 = exhausion debuff has duration

Bool Property Buffs = True Auto Conditional

Bool Property Unmilked_DeBuffs_Skills = True Auto Conditional
Bool Property Unmilked_DeBuffs_SPMP = True Auto Conditional
Bool Property Unmilked_DeBuffs_SpeedStamina = True Auto Conditional

;----------------------------------------------------------------------------
;Milk effects constructor
;----------------------------------------------------------------------------

Bool Property MME_SimpleMilkPotions = False Auto Conditional

Bool Property Milk_RaceEffect = True Auto Conditional
Bool Property Milk_SkillsEffect = True Auto Conditional
Bool Property Milk_LactacidEffect = True Auto Conditional
Bool Property Milk_RNDEffect = True Auto Conditional
Int Property BrestEnlargement_MultiBreast_Effect Auto Conditional

;----------------------------------------------------------------------------
;Dialogues
;----------------------------------------------------------------------------

Bool Property MME_BreasfeedingAnimationsCheck = False Auto Conditional
Bool Property MME_DialogueMilking = True Auto Conditional

Bool Property MME_SubjectMaid Auto Conditional
Bool Property MME_SubjectSlave Auto Conditional

Float Property MME_SubjectMilk Auto Conditional
Float Property MME_TargetMilk Auto Conditional

Int Property MME_CanBeConvertedFromSlaveToMaid Auto Conditional
Int Property MME_CanBeConvertedFromMaidToSlave Auto Conditional
Int Property MME_FreeMaidSlots Auto Conditional

;----------------------------------------------------------------------------
;Debug
;----------------------------------------------------------------------------

Int Property Debug_enabled Auto Conditional

;----------------------------------------------------------------------------
;Dialogues Alias conditions
;----------------------------------------------------------------------------

Float[] Property MaidAliasMilk  Auto  Conditional
Float[] Property MaidAliasMaxMilk  Auto  Conditional
