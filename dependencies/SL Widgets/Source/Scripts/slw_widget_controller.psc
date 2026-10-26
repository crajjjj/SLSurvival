Scriptname slw_widget_controller extends Quest

; Compile-time header for _SLS_IntSlw only, never shipped. Only the members SLS calls, read off
; SL Widgets 3.0.1 (slw_widget_controller.psc).

; False on iWant Status Bars older than 2.10, where NPC tracking stays off
Bool Function hasBarsAPI()
	Return False
EndFunction

; Registers the icons and label of a newly assigned slot
Function reloadNpcSlot(Int slot)
EndFunction
