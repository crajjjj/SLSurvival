Scriptname SLSF_External Hidden

;ACCESS THIS ONLY VIA GLOBALS


;*************** SGO
dcc_sgo_QuestController Function GetSGOAPI() Global
	Return Game.GetFormFromFile(0x00000D62, "dcc-soulgem-oven-000.esm") As dcc_sgo_QuestController
EndFunction

Bool Function IsPregnant(Actor PlayerRef, Int Value) Global
	dcc_sgo_QuestController SGO = GetSGOAPI()
	If SGO
		If SGO.ActorGemGetPercent(PlayerRef) > Value as Float
			Return True
		EndIf
	EndIf
	Return False
EndFunction
