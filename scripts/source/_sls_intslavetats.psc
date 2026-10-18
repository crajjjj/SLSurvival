Scriptname _SLS_IntSlavetats Hidden 

Int Function GetAvailableSlots(Actor akTarget, String Area) Global
	Return SlaveTats._available_slot(akTarget, Area)
EndFunction

; --- SLS overlays through SlaveTats (the optional SlaveTats Pack) --------------------------------------------
Bool Function AddTattoo(Actor akTarget, String Section, String Name, Float Alpha) Global
	Return SlaveTats.simple_add_tattoo(akTarget, Section, Name, 0, true, true, Alpha)
EndFunction

Bool Function RemoveTattoo(Actor akTarget, String Section, String Name) Global
	Return SlaveTats.simple_remove_tattoo(akTarget, Section, Name, true, true)
EndFunction

Bool Function HasTattoo(Actor akTarget, String Section, String Name) Global
	Int Template = JMap.object()
	JMap.setStr(Template, "section", Section)
	JMap.setStr(Template, "name", Name)
	Int Matches = JArray.object()
	SlaveTats.query_applied_tattoos(akTarget, Template, Matches)
	Return JArray.count(Matches) > 0
EndFunction

Int Function CountFreeSlots(Actor akTarget, String Area) Global
	Int Count = 0
	Int i = SlaveTats.SLOTS(Area)
	While i > 0
		i -= 1
		If SlaveTats.get_applied_tattoo_in_slot(akTarget, Area, i) == 0
			Count += 1
		EndIf
	EndWhile
	Return Count
EndFunction
