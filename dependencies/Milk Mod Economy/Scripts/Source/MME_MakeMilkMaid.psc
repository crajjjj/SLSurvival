Scriptname MME_MakeMilkMaid extends activemagiceffect Hidden

Event OnEffectStart( Actor akTarget, Actor akCaster )
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	String MaidName
	IF MilkQ.MILKmaid.find(akTarget) == -1 && MilkQ.MILKslave.find(akTarget) == -1
		MilkQ.AssignSlotMaid(akTarget)
	ELSEIF MilkQ.MILKmaid.find(akTarget) != -1
		MaidName = akTarget.GetLeveledActorBase().getname()
		Debug.Notification(MilkQ.formatString(JsonUtil.GetStringValue("/MME/Strings", "ismaid"), MaidName))
	ELSE 
		MaidName = akTarget.GetLeveledActorBase().getname()
		Debug.Notification(MilkQ.formatString(JsonUtil.GetStringValue("/MME/Strings", "isslave"), MaidName))
	ENDIF
EndEvent