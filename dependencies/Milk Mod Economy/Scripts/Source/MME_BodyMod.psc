Scriptname MME_BodyMod extends Quest Hidden

Function SetNodeScale(Actor akActor, string nodeName, float value, bool isFemale)
	string modName = "MilkModEconomy"
	;Debug.Notification(akActor.GetLeveledActorBase().GetName() + " MME_BodyMod Scaling " + nodeName + " to " + value)
	
	If Game.GetModbyName("SexLab Inflation Framework.esp") != 255
		string SLIF_modName = "Milk Mod Economy"
		string sKey = ""
		
		If nodeName == "NPC L Breast"
			sKey = "slif_breast"
		ElseIf nodeName == "NPC L Breast01"
			sKey = "slif_breast01"
		ElseIf nodeName == "NPC L Breast P1"
			sKey = "slif_breast_p"
		ElseIf nodeName == "NPC L GenitalsScrotum [LGenScrot]"
			sKey = "slif_scrotum"
		ElseIf nodeName == "NPC Belly"
			sKey = "slif_belly"
		EndIf
		
		If (sKey != "")
			int SLIF_inflate = ModEvent.Create("SLIF_inflate")
			If (SLIF_inflate)
				ModEvent.PushForm(SLIF_inflate, akActor)
				ModEvent.PushString(SLIF_inflate, SLIF_modName)
				ModEvent.PushString(SLIF_inflate, sKey)
				ModEvent.PushFloat(SLIF_inflate, value)
				ModEvent.PushString(SLIF_inflate, modName)
				ModEvent.Send(SLIF_inflate)
			EndIf
		EndIf
	ElseIf NetImmerse.HasNode(akActor, nodeName, false)
		if akActor == Game.GetPlayer()																				;update 1st person view/skeleton (player only)
			If value != 1.0
				NiOverride.AddNodeTransformScale(akActor, true, isFemale, nodeName, modName, value)
			Else
				NiOverride.RemoveNodeTransformScale(akActor, true, isFemale, nodeName, modName)
			Endif
			NiOverride.UpdateNodeTransform(akActor, true, isFemale, nodeName)
		endif
		If value != 1.0																								;update 3rd person view/skeleton (player & NPCs)
			NiOverride.AddNodeTransformScale(akActor, false, isFemale, nodeName, modName, value)
		Else
			NiOverride.RemoveNodeTransformScale(akActor, false, isFemale, nodeName, modName)
		Endif
		NiOverride.UpdateNodeTransform(akActor, false, isFemale, nodeName)
	Endif
EndFunction

Function RemoveNiONodeScale(Actor akActor, string nodeName, bool isFemale)
	string modName = "MilkModEconomy"
	if akActor == Game.GetPlayer()																				;update 1st person view/skeleton (player only)
		NiOverride.RemoveNodeTransformScale(akActor, true, isFemale, nodeName, modName)
		NiOverride.UpdateNodeTransform(akActor, true, isFemale, nodeName)
	endif
	NiOverride.RemoveNodeTransformScale(akActor, false, isFemale, nodeName, modName)
	NiOverride.UpdateNodeTransform(akActor, false, isFemale, nodeName)
EndFunction


