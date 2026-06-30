Scriptname FWAddOn_CycleMagicEffect extends FWAddOnBase

spell[] property Always_FollicularPhase Auto
spell[] property Always_Ovulation Auto
spell[] property Always_LuthealPhase Auto
spell[] property Always_PMS Auto
spell[] property Always_Menstruation Auto
spell[] property Always_Trimester1 Auto
spell[] property Always_Trimester2 Auto
spell[] property Always_Trimester3 Auto
spell[] property Always_LaborPains Auto
spell[] property Always_Recovery Auto

spell[] property Sometimes_FollicularPhase Auto
spell[] property Sometimes_Ovulation Auto
spell[] property Sometimes_LuthealPhase Auto
spell[] property Sometimes_PMS Auto
spell[] property Sometimes_Menstruation Auto
spell[] property Sometimes_Trimester1 Auto
spell[] property Sometimes_Trimester2 Auto
spell[] property Sometimes_Trimester3 Auto
spell[] property Sometimes_LaborPains Auto
spell[] property Sometimes_Recovery Auto


;function Refresh(string strArg, FWAddOnManager sender)
;	if (strArg == "") || (strArg == "CME")
;		if sender != none
;			sender.RegisterCMEAddOn(self)
;		elseif AddOnManager != none
;			AddOnManager.RegisterCMEAddOn(self)
;		else
;			FW_log.WriteLog("Beeing Female Mod Manager - RefreshAddOns CME " + GetName() + " failed - Manager is none")
;		endif
;	endIf
;endFunction
