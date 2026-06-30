Scriptname FWAddOn_Race extends FWAddOnBase  

Race[] property RaceID auto
MiscObject property BabyMesh_Female auto hidden
Armor property BabyArmor_Female auto
ActorBase property BabyActor_Female auto
ActorBase property BabyActor_FemalePlayer auto
MiscObject property BabyMesh_Male auto hidden
Armor property BabyArmor_Male auto
ActorBase property BabyActor_Male auto
ActorBase property BabyActor_MalePlayer auto
ActorBase property AdultActor_Female auto
ActorBase property AdultActor_FemalePlayer auto
ActorBase property AdultActor_Male auto
ActorBase property AdultActor_MalePlayer auto
bool property Female_Force_This_Baby = false auto
Bool Property DisablePregnancy = false Auto
float property Duration_01_Follicular = 1.0 auto
float property Duration_02_Ovulation = 1.0 auto
float property Duration_03_Luteal = 1.0 auto
float property Duration_04_Menstruation = 1.0 auto
float property Duration_05_Trimester1 = 1.0 auto
float property Duration_06_Trimester2 = 1.0 auto
float property Duration_07_Trimester3 = 1.0 auto
float property Duration_08_Recovery = 1.0 auto
float property Duration_09_LaborPains = 1.0 auto
float property Duration_10_SecondsBetweenLaborPains = 1.0 auto
float property Duration_11_SecondsBetweenBabySpawn = 1.0 auto
float property Duration_MaleSperm = 1.0 auto
float property Pain_Mittelschmerz = 1.0 auto
float property Pain_Menstruation = 1.0 auto
float property Pain_PMS = 1.0 auto
float property Pain_LaborPains = 1.0 auto
float property Pain_GivingBirth = 1.0 auto
float property Pain_Abortus = 1.0 auto
float property Pain_Phase_CyclePains = 1.0 auto
float property Pain_Phase_PregnantPains = 1.0 auto
float property PMS_ChanceScale = 1.0 auto
float property Max_CME_EffectsScale = 1.0 auto
float property ChanceToBecomePregnantScale = 1.0 auto
float property Sizes_Belly_Max = 1.0 auto
float property Sizes_Breasts_Max = 1.0 auto
float property Sizes_Belly_Max_Multiple = 1.0 auto
float property Sizes_Breasts_Max_Multiple = 1.0 auto
float property Multiple_Threshold_Chance = 1.0 auto
float property Multiple_Threshold_Max_Babys = 1.0 auto
float property Irregulation_Chance_Scale = 1.0 auto
float property Irregulation_Value_Scale = 1.0 auto
float property ContraceptionDuration = 1.0 auto



;function Refresh(string strArg, FWAddOnManager sender)
;	if (strArg == "") || (strArg == "Race")
;		if sender != none
;			sender.RegisterRaceAddOn(self)
;		elseif AddOnManager != none
;			AddOnManager.RegisterRaceAddOn(self)
;		else
;			FW_log.WriteLog("Beeing Female Mod Manager - RefreshAddOns PMS "+GetName()+" failed - Manager is none")
;		endif
;	endIf
;endFunction
