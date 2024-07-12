Scriptname SAT_mcmConfig extends SKI_ConfigBase  

;PROPERTIES

Quest property SAT_Controller auto
SAT_UpkeepScript property main auto
float property StressDamMulti = 1.0 auto
float property StressTimeMulti = 1.0 auto
int property StressTimeValue = 25 auto
int property StressSexValue = 20 auto
int property TraumaDays = 2 auto
int property TraumaTimeValue = 20 auto
int property StressFreeValue = 10 auto
int property TraumaFreeValue = 10  auto
int property alcoholStressValue = 5 auto
int property alcoholTraumaValue = 1 auto
int property drugStressValue = 8 auto
int property drugTraumaValue = 4 auto
bool property TraumaArousalLock = true auto
bool property TraumaNoSex = true auto
bool property TraumaText = true auto
bool property StressText = true auto
bool property RisingArousal = true auto
bool property FollowerArousal = true auto

bool property rapeflash = true auto
bool property arousalVisuals = true  auto
bool property disableMod = false auto
bool property uninstallMod = false auto

int property traumaBeastRapeValue = 25 auto
int property traumaVaginalRapeValue = 15 auto
int property traumaAnalRapeValue = 20 auto
int property traumaOralRapeValue = 10 auto

int property traumaBeastConsensValue = 0 auto
int property traumaVaginalConsensValue = 0 auto
int property traumaAnalConsensValue = 0 auto
int property traumaOralConsensValue = 0 auto


;OIDS
int StressDamMultiOID 
int StressTimeMultiOID
int StressTimeValueOID
int StressSexValueOID 
int TraumaDaysOID 
int TraumaTimeValueOID 
int StressFreeValueOID 
int TraumaFreeValueOID 
int alcoholStressValueOID 
int alcoholTraumaValueOID 
int drugStressValueOID 
int drugTraumaValueOID 

int rapeflashOID
int traumaNoSexOID
int traumaBeastRapeValueOID 
int traumaVaginalRapeValueOID 
int traumaAnalRapeValueOID 
int traumaOralRapeValueOID 

int traumaBeastConsensValueOID 
int traumaVaginalConsensValueOID 
int traumaAnalConsensValueOID 
int  traumaOralConsensValueOID 
int  ArousalVisualsOID
int TraumaArousalLockOID
int disableModOID
int uninstallModOID
int TraumaTextOID
int StressTextOID
int RisingArousalOID
int FollowerArousalOID

Event OnPageReset(string page)
	
	If (page == "")
		If !uninstallMod
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0) ; Move cursor to top left position

		AddHeaderOption("Stress and Trauma by Guffel")
		AddEmptyOption()
		AddHeaderOption("Trauma Settings (" + main.Trauma as int +")" )
				
		AlcoholTraumaValueOID = AddSliderOption("Trauma Alcohol Reduction: ", AlcoholTraumaValue)
		DrugTraumaValueOID = AddSliderOption("Trauma Drug Reduction: ", DrugTraumaValue)
		TraumaTimeValueOID = AddSliderOption("Trauma Daily Reduction: ", TraumaTimeValue)
		TraumaDaysOID = AddSliderOption("Traumatised Days: ", TraumaDays)			 				   ;days before trauma is reduced
		TraumaNoSexOID = AddToggleOption("No Sex When Traumatised: ", TraumaNoSex)					;no sex during trauma days / only no rape during trauma days
		TraumaFreeValueOID = AddSliderOption("Trauma Effect Threshold: ", TraumaFreeValue) 			  ;lower trauma value before first visual effect
		TraumaArousalLockOID = AddToggleOption("Arousal Bocked When Traumatised: ", TraumaArousalLock)
		TraumaTextOID = AddToggleOption("Display Trauma Value: ", TraumaText)
		AddEmptyOption()
		TraumaVaginalRapeValueOID = AddSliderOption("Trauma Vaginal Rape: ", TraumaVaginalRapeValue)
		TraumaOralRapeValueOID = AddSliderOption("Trauma Oral Rape: ", TraumaOralRapeValue)
		TraumaAnalRapeValueOID = AddSliderOption("Trauma Anal Rape: ", TraumaAnalRapeValue)
		TraumaBeastRapeValueOID = AddSliderOption("Trauma Beast Rape: ", TraumaBeastRapeValue)
		AddEmptyOption()
		TraumaVaginalConsensValueOID = AddSliderOption("Trauma Vaginal Consens: ", TraumaVaginalConsensValue)
		TraumaOralConsensValueOID = AddSliderOption("Trauma Oral Consens: ", TraumaOralConsensValue)
		TraumaAnalConsensValueOID = AddSliderOption("Trauma Anal Consens: ", TraumaAnalConsensValue)
		TraumaBeastConsensValueOID = AddSliderOption("Trauma Beast Consens: ", TraumaBeastConsensValue)

		SetCursorPosition(1) ; Move cursor to top right position

		AddHeaderOption("Stress Settings (" + main.Stress as int +")" )
		AlcoholStressValueOID = AddSliderOption("Stress Alcohol Reduction: ", AlcoholStressValue)
		DrugStressValueOID = AddSliderOption("Stress Drug Reduction: ", DrugStressValue)
		StressTimeValueOID = AddSliderOption("Stress Daily Reduction: ", StressTimeValue)
		StressSexValueOID = AddSliderOption("Stress Sex Reduction: ", StressSexValue)
		StressTimeMultiOID = AddSliderOption("Stress Time Multi: ", StressTimeMulti, "{1}")
		StressDamMultiOID = AddSliderOption("Stress Damage Multi: ", StressDamMulti, "{1}")
		StressFreeValueOID = AddSliderOption("Stress Effect Threshold: ", StressFreeValue)   ;lower stress value before first visual effect
		RisingArousalOID = AddToggleOption("Link Arousal to Stress: ", RisingArousal)
		FollowerArousalOID = AddToggleOption("Link Follower Arousal to Stress: ", FollowerArousal)
		StressTextOID = AddToggleOption("Display Stress Value: ", StressText)
		AddEmptyOption()

		AddHeaderOption("Other Settings" )				
		RapeFlashOID = AddToggleOption("Screen Blur On Rape: ", RapeFlash)
		ArousalVisualsOID = AddToggleOption("Arousal Visuals: ", ArousalVisuals)		
		AddEmptyOption()
		DisableModOID = AddToggleOption("Disable Mod: ", DisableMod)
		UninstallModOID = AddToggleOption("Uninstall Mod: ", UninstallMod)
	else
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0) ; Move cursor to top left position

		AddHeaderOption("Stress and Trauma by Guffel")
		AddEmptyOption()
		AddHeaderOption("The Mod has been shut down...")
	endif
	EndIf
EndEvent

Event OnOptionHighlight(int option)
	If (option == AlcoholTraumaValueOID)
		SetInfoText("The amount the Trauma value is reduced when drinking alcohol i.e. any sort of mead, ale or wine.")
		
	ElseIf (option == DrugTraumaValueOID)
		SetInfoText("The amount the Trauma value is reduced when drinking Skooma or Double-Destilled Skooma.")
		
	ElseIf (option == TraumaTimeValueOID)
		SetInfoText("The amount the Trauma value is reduced per day, after not having sex (not being raped) during the Traumatised Days.")
		
	ElseIf (option == TraumaDaysOID)
		SetInfoText("You must have no sex (not being raped) for this number of days for the Trauma to start sinking. \n Example: By default you must not have sex for 2 days for the Trauma to sink. After 3 days of no Sex, the reduction will be 20, after 4 days 40 and so on.")
		
	ElseIf (option == TraumaFreeValueOID)
		SetInfoText("When the Trauma value exceeds this value, you are traumatised and the visual effects start. \n The effects get stronger at a Trauma value of 33 and 66.")
		
	ElseIf (option == TraumaNoSexOID)
		SetInfoText("When ticked: You can't have sex at all during the Traumatised Days for the Trauma to sink. \n When unticked: You can't be raped during the traumatised days for the Trauma to sink.")
		
	ElseIf (option == TraumaArousalLockOID)
		SetInfoText("When ticked: Your arousal will be blocked as long as the Trauma value excceds the Trauma Effect Threshold.")
		

	ElseIf (option == TraumaVaginalRapeValueOID)
		SetInfoText("The amount Trauma is increased, when being raped with an animation with the Vaginal Tag.")
		
	ElseIf (option == TraumaOralRapeValueOID)
		SetInfoText("The amount Trauma is increased, when being raped with an animation with the Oral Tag.")
		
	ElseIf (option == TraumaAnalRapeValueOID)
		SetInfoText("The amount Trauma is increased, when being raped with an animation with the Anal Tag.")
		
	ElseIf (option == TraumaBeastRapeValueOID)
		SetInfoText("The amount Trauma is increased, when being raped with an animation with the Beastiality Tag.")
		

	ElseIf (option == TraumaVaginalConsensValueOID)
		SetInfoText("The amount Trauma is increased, when having sex with an animation with the Vaginal Tag.")
		
	ElseIf (option == TraumaOralConsensValueOID)
		SetInfoText("The amount Trauma is increased, when having sex with an animation with the Oral Tag.")
		
	ElseIf (option == TraumaAnalConsensValueOID)
		SetInfoText("The amount Trauma is increased, when having sex with an animation with the Anal Tag.")
		
	ElseIf (option == TraumaBeastConsensValueOID)
		SetInfoText("The amount Trauma is increased, when having sex with an animation with the Beastiality Tag.")
		

	ElseIf (option == AlcoholStressValueOID)
		SetInfoText("The amount the Stress value is reduced when drinking alcohol i.e.any sort of mead, ale or wine.")
		
	ElseIf (option == DrugStressValueOID)
		SetInfoText("The amount the Stress value is reduced when drinking Skooma or Double-Destilled Skooma.")

	ElseIf (option == StressSexValueOID)
		SetInfoText("The amount the Stress value is reduced when having sex (not being raped, being the rape aggressor counts).")
		
	ElseIf (option == StressTimeValueOID)
		SetInfoText("The amount the Stress value is reduced per day. Stress reduction has no cooldown. The reduction starts directly after the end of every combat.")
		
	ElseIf (option == StressTimeMultiOID)
		SetInfoText("Every 10 in-game minutes of combat generate 1 point of Stress, times this multiplier. Adjust to your liking. Set to 0 to disable Combat-time Stress. \n 1 in-game minute, are roughtly 3 seconds real-time.")
		
	ElseIf (option == StressDamMultiOID)
		SetInfoText("Every 10% of damage taken generate 1 point of Stress, times this multiplier. Adjust to your liking. Set to 0 to disable Damage Stress.")
		
	ElseIf (option == StressFreeValueOID)
		SetInfoText("When the Stress value exceeds this value the visual effects start. \n The effects get stronger at a Stress value of 33 and 66.")
		
	ElseIf (option == RapeFlashOID)
		SetInfoText("When ticked: When raped, a screen blur appears in 0.5 seconds intervals for the duration of the animation.")
		
	ElseIf (option == ArousalVisualsOID)
		SetInfoText("When ticked: On Arousal values of 50 and 70 a medium and stong, surreal visual effect is applied in a regular interval.")

	ElseIf (option == DisableModOID)
		SetInfoText("When ticked: Pauses this mod.")

	ElseIf (option == UninstallModOID)
		SetInfoText("When ticked: Shuts down this mod. Only use when uninstalling! This can't be un-done!")

	ElseIf (option == StressTextOID)
		SetInfoText("When ticked: Shows the current Stress value in the top left corner of the screen every in-game hour.")

	ElseIf (option == TraumaTextOID)
		SetInfoText("When ticked: Shows the current Trauma value in the top left corner of the screen every in-game hour.")

	ElseIf (option == RisingArousalOID)
		SetInfoText("When ticked: The Arousal will rise equally to your Stress value, but not sink with it.")

	ElseIf (option == FollowerArousalOID)
		SetInfoText("When ticked: The Arousal of up to four Follower will rise, but not sink, with Player Stess. \n This simulates the effect of Stress for your Follower.")
	endif
endEvent


Event OnOptionSliderOpen(int option)		
	
	If (option == AlcoholTraumaValueOID)
		SetSliderDialogStartValue(AlcoholTraumaValue)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == DrugTraumaValueOID)
		SetSliderDialogStartValue(DrugTraumaValue)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == TraumaTimeValueOID)
		SetSliderDialogStartValue(TraumaTimeValue)
		SetSliderDialogDefaultValue(20.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == TraumaDaysOID)
		SetSliderDialogStartValue(TraumaDays)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 30.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == TraumaFreeValueOID)
		SetSliderDialogStartValue(TraumaFreeValue)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 32.0)
		SetSliderDialogInterval(1.0)

	elseIf (option == TraumaVaginalRapeValueOID)
		SetSliderDialogStartValue(TraumaVaginalRapeValue)
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == TraumaOralRapeValueOID)
		SetSliderDialogStartValue(TraumaOralRapeValue)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == TraumaAnalRapeValueOID)
		SetSliderDialogStartValue(TraumaAnalRapeValue)
		SetSliderDialogDefaultValue(25.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == TraumaBeastRapeValueOID)
		SetSliderDialogStartValue(TraumaBeastRapeValue)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)

	elseIf (option == TraumaVaginalConsensValueOID)
		SetSliderDialogStartValue(TraumaVaginalConsensValue)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == TraumaOralConsensValueOID)
		SetSliderDialogStartValue(TraumaOralConsensValue)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == TraumaAnalConsensValueOID)
		SetSliderDialogStartValue(TraumaAnalConsensValue)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == TraumaBeastConsensValueOID)
		SetSliderDialogStartValue(TraumaBeastConsensValue)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)

	elseIf (option == AlcoholStressValueOID)
		SetSliderDialogStartValue(AlcoholStressValue)
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == DrugStressValueOID)
		SetSliderDialogStartValue(DrugStressValue)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == StressTimeValueOID)
		SetSliderDialogStartValue(StressTimeValue)
		SetSliderDialogDefaultValue(25.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == StressTimeMultiOID)
		SetSliderDialogStartValue(StressTimeMulti)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	elseIf (option == StressDamMultiOID)
		SetSliderDialogStartValue(StressDamMulti)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	elseIf (option == StressFreeValueOID)
		SetSliderDialogStartValue(StressFreeValue)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 32.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == StressSexValueOID)
		SetSliderDialogStartValue(StressSexValue)
		SetSliderDialogDefaultValue(20.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	endif
endEvent

Event OnOptionSliderAccept(int option, float value)		

	If (option == AlcoholTraumaValueOID)
		AlcoholTraumaValue = value as int
		SetSliderOptionValue(option, value, "{0.0}")
	elseIf (option == DrugTraumaValueOID)
		DrugTraumaValue = value as int
		SetSliderOptionValue(option, value, "{0.0}")
	elseIf (option == TraumaTimeValueOID)
		TraumaTimeValue = value as int
		SetSliderOptionValue(option, value, "{0.0}")
	elseIf (option == TraumaDaysOID)
		TraumaDays = value as int
		SetSliderOptionValue(option, value, "{0.0}")
	elseIf (option == TraumaFreeValueOID)
		TraumaFreeValue = value as int
		SetSliderOptionValue(option, value, "{0.0}")

	elseIf (option == TraumaVaginalRapeValueOID)
		TraumaVaginalRapeValue = value as int
		SetSliderOptionValue(option, value, "{0.0}")
	elseIf (option == TraumaOralRapeValueOID)
		TraumaOralRapeValue = value as int
		SetSliderOptionValue(option, value, "{0.0}")
	elseIf (option == TraumaAnalRapeValueOID)
		TraumaAnalRapeValue = value as int
		SetSliderOptionValue(option, value, "{0.0}")
	elseIf (option == TraumaBeastRapeValueOID)
		TraumaBeastRapeValue = value as int
		SetSliderOptionValue(option, value, "{0.0}")

	elseIf (option == TraumaVaginalConsensValueOID)
		TraumaVaginalConsensValue = value as int
		SetSliderOptionValue(option, value, "{0.0}")
	elseIf (option == TraumaOralConsensValueOID)
		TraumaOralConsensValue = value as int
		SetSliderOptionValue(option, value, "{0.0}")
	elseIf (option == TraumaAnalConsensValueOID)
		TraumaAnalConsensValue = value as int
		SetSliderOptionValue(option, value, "{0.0}")
	elseIf (option == TraumaBeastConsensValueOID)
		TraumaBeastConsensValue = value as int
		SetSliderOptionValue(option, value, "{0.0}")

	elseIf (option == AlcoholStressValueOID)
		AlcoholStressValue = value as int
		SetSliderOptionValue(option, value, "{0.0}")
	elseIf (option == DrugStressValueOID)
		DrugStressValue = value as int
		SetSliderOptionValue(option, value, "{0.0}")
	elseIf (option == StressTimeValueOID)
		StressTimeValue = value as int
		SetSliderOptionValue(option, value, "{0.0}")
	elseIf (option == StressTimeMultiOID)
		StressTimeMulti = value
		SetSliderOptionValue(option, value, "{1}")
	elseIf (option == StressDamMultiOID)
		StressDamMulti = value
		SetSliderOptionValue(option, value, "{1}")
	elseIf (option == StressFreeValueOID)
		 StressFreeValue = value as int
		SetSliderOptionValue(option, value, "{0.0}")
	elseIf (option == StressSexValueOID)
		 StressSexValue = value as int
		SetSliderOptionValue(option, value, "{0.0}")
	endif
endEvent

Event OnOptionSelect(int option)
		
	If (option == TraumaNoSexOID)
		TraumaNoSex = !TraumaNoSex
		SetToggleOptionValue(TraumaNoSexOID, TraumaNoSex)
	ElseIf (option == TraumaArousalLockOID)
		TraumaArousalLock = !TraumaArousalLock
		SetToggleOptionValue(TraumaArousalLockOID, TraumaArousalLock)
	ElseIf (option == RapeFlashOID)
		RapeFlash = !RapeFlash
		SetToggleOptionValue(RapeFlashOID, RapeFlash)
	ElseIf (option == ArousalVisualsOID)
		ArousalVisuals = !ArousalVisuals
		SetToggleOptionValue(ArousalVisualsOID, ArousalVisuals)
	ElseIf (option == disableModOID)
		disableMod= !disableMod
			if disableMod
				SAT_Controller.UnregisterForUpdate()
				SAT_Controller.UnregisterForUpdateGameTime()
				SAT_Controller.UnregisterForModEvent("AnimationStart")
				SAT_Controller.UnregisterForModEvent("AnimationEnd")
			else
				SAT_Controller.RegisterForUpdateGameTime(0.0238)
				SAT_Controller.RegisterForModEvent("AnimationStart", "HavingSex")
				SAT_Controller.RegisterForModEvent("AnimationEnd", "SexEnded")
			endif
		SetToggleOptionValue(disableModOID, disableMod)
	ElseIf (option == uninstallModOID)
		uninstallMod= !uninstallMod
			if uninstallMod
				SAT_Controller.stop()
			endif
		SetToggleOptionValue(uninstallModOID, uninstallMod)
	ElseIf (option == TraumaTextOID)
		TraumaText = !TraumaText
		SetToggleOptionValue(TraumaTextOID, TraumaText)
	ElseIf (option == StressTextOID)
		StressText = !StressText
		SetToggleOptionValue(StressTextOID, StressText)
	ElseIf (option == RisingArousalOID)
		RisingArousal = !RisingArousal
		SetToggleOptionValue(RisingArousalOID, RisingArousal)
	ElseIf (option == FollowerArousalOID)
		FollowerArousal = !FollowerArousal
		SetToggleOptionValue(FollowerArousalOID, FollowerArousal)
	endif
endEvent
