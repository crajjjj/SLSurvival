Scriptname sr_InfEventBase extends ReferenceAlias

sr_InflateQuest Property inflater auto
sr_InfEventManager Property manager auto

String Property eventName = "Dummy event" auto
String Property helpText = "Tooltip goes here" auto 
int property chanceDefault = 0 auto
int property chance = -1 auto hidden

; ------------------------------------------------------
;  Interface
;  To make a custom event, extend a script from this one
;  and override functions filter and execute.
;  Filter should return true if the event should be
;  triggered. Property ' chance' is of use here, that's
;  the event chance visible to the user in the config.
;  Execute will contain the script for the actual event.
; ------------------------------------------------------

bool Function Filter()
	return Utility.RandomInt(0, 99) < chance
EndFunction

Function Execute()
	Debug.Notification("I forgot to change this for event " + eventName)
EndFunction

; ------------------------------------------------------
; Interface functions end
; ------------------------------------------------------

Event OnPlayerLoadGame()
	RegisterForModEvent("fhu.EventRegister", "RegisterSelf")
	If chance < 0
		chance = chanceDefault
	EndIf
EndEvent

Event RegisterSelf(string modEventName, string strArg, float numArg, Form sender)
	If !manager.RegisterEvent(self)
		log("Failed to register!", 2)
	EndIf
EndEvent

Function log(string msg, int lvl = 1)
	String tosend = "["+eventName+"] " + msg
	If lvl == 2
		inflater.warn(tosend)
	ElseIf lvl == 3
		inflater.error(tosend)
	Else
		inflater.log(tosend)
	EndIf
EndFunction