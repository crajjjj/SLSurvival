Scriptname RND_EWMScript extends EWM_HandleModBase

;Check Need
Event On_RND_Check()
	(Game.GetFormFromFile(0x0002E0CB, "RealisticNeedsandDiseases.esp") As Spell).Cast(Game.GetPlayer())
EndEvent

;Drink From Water Source
Event On_RND_Drink()
	(Game.GetFormFromFile(0x0004295C, "RealisticNeedsandDiseases.esp") As Spell).Cast(Game.GetPlayer())
EndEvent

;Customize Food
Event On_RND_Custom()
	(Game.GetFormFromFile(0x00192A07, "RealisticNeedsandDiseases.esp") As Spell).Cast(Game.GetPlayer())
EndEvent

;Toggle Widgets
Event On_RND_Widget()
	(Game.GetFormFromFile(0x00192A05, "RealisticNeedsandDiseases.esp") As Spell).Cast(Game.GetPlayer())
EndEvent

;Rest
Event On_RND_Rest()
	(Game.GetFormFromFile(0x00192A04, "RealisticNeedsandDiseases.esp") As Spell).Cast(Game.GetPlayer())
EndEvent


;This can be used if the function is supposed to replace a spell
;In this case, the spell will be hidden from the magic menu if user check "Hide Spells" in EWM's MCM.
;The HasSpells property have to be set to true in this script's properties for this feature to be taken into account.
Spell Function GetFunctionSpell(Int functionIndex)
	if functionIndex == 0 
		;Check Need
		return Game.GetFormFromFile(0x0002E0CB, "RealisticNeedsandDiseases.esp") As Spell
	endif
	if functionIndex == 1 
		;Drink From Water Source
		return Game.GetFormFromFile(0x0004295C, "RealisticNeedsandDiseases.esp") As Spell
	endif
	if functionIndex == 2
		;Customize Food
		return Game.GetFormFromFile(0x00192A07, "RealisticNeedsandDiseases.esp") As Spell
	endif
	if functionIndex == 3
		;Toggle Widgets
		return Game.GetFormFromFile(0x00192A05, "RealisticNeedsandDiseases.esp") As Spell
	endif
	if functionIndex == 4
		;Rest
		return Game.GetFormFromFile(0x00192A04, "RealisticNeedsandDiseases.esp") As Spell
	endif

	return none
EndFunction

;This can be used if some functions have conditions to be available. 
;In the following example, _DemoEWM_Fct2 is only available if the player is a male, while _DemoEWM_Fct1 have no conditions.
Bool Function GetFunctionCondition(Int functionIndex)
	;Debug.Notification("EWM Simple Action - GetFunctionCondition : true")
	;Debug.Trace("EWM Simple Action - GetFunctionCondition : true")
	return true
EndFunction

Function OnHandlerInit()
	;If your addon need specific initilisation, do it in this function instead of using the OnInit event. This one is only fired when your addon is recognized and registered by EWM.
EndFunction

Event OnShowStatus(string eventName, string strArg, float numArg, Form sender)
	;you can put display messages in here, that'll be shown when the wheel is opened if the user checked the option in the MCM.
EndEvent