Scriptname _SLS_DebugGetActorPack extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If akTarget
		
		
		Package AiPack = akTarget.GetCurrentPackage() ; Game.GetFormFromFile(0x015962, "Ordinator - Perks of Skyrim.esp") as Package
		Int FormId = AiPack.GetFormID()
		Int Index = Math.RightShift(Math.LogicalAnd(FormId, 0xFF000000), 24)
		String ModName = Game.GetModName(Index)
		Quest akQuest = AiPack.GetOwningQuest()
		Scene AkScene = akTarget.GetCurrentScene()
		
		Int QuestStage = -1
		Int QuestPriority = -1
		If akQuest
			QuestStage = akQuest.GetCurrentStageID()
			QuestPriority= akQuest.GetPriority()
		EndIf
		Debug.Messagebox("Target: " + akTarget.GetActorBase().GetName() + "\nAI Package : " + AiPack + "\nModName: " + ModName + "\n\nScene: " + AkScene + "\nQuest: " + akQuest + "\nQuest Priority: " + QuestPriority + "\nQuest Stage: "+ QuestStage)
	EndIf
EndEvent
