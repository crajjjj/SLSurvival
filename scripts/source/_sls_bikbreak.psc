Scriptname _SLS_BikBreak extends ObjectReference  

;String Property JsonFile Auto

MiscObject Property WhatIAm Auto ; Self.GetReference() can't tell you what the object is. Because of (item 3 in container) bull. 

; "SL Survival/BikBreak/TAWoBA/IronCuirass.json"

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	If !akOldContainer && akNewContainer == Game.GetPlayer()
		;Armor SourceArmor = JsonUtil.GetFormValue(JsonFile, "sourcearmor") as Armor
		;MiscObject CobjToken = JsonUtil.GetFormValue(JsonFile, "cobjtoken") as MiscObject
		;Float SkillReq = JsonUtil.GetFloatValue(JsonFile, "skillreq")
		(Game.GetFormFromFile(0x10D7AF, "SL Survival.esp") as _SLS_BikiniBreak).BreakdownArmor(WhatIAm)
	EndIf
EndEvent
