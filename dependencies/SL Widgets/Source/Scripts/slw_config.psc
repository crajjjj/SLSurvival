Scriptname slw_config extends Quest

; Compile-time header for _SLS_IntSlw only, never shipped: SL Widgets' own script provides these at
; runtime. Only the members SLS calls, read off SL Widgets 3.0.1 (slw_config.psc), the NPC slot calls
; its crosshair hotkey makes. The real script sits on SL Widgets' quest SLWidgetsConfig.

slw_widget_controller Property widget_controller Auto
Bool Property slw_stopped Auto

; Slot the actor is tracked in (1-3), 0 if none
Int Function findNpcSlot(Actor a)
	Return 0
EndFunction

; First empty NPC slot (1-3), 0 if all are taken
Int Function findFirstEmptyNpcSlot()
	Return 0
EndFunction

Function setNpcSlot(Int slot, Actor a)
EndFunction

; Empties the slot and releases its icons and label
Function clearNpcSlot(Int slot)
EndFunction
