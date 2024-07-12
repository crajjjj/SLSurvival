Scriptname _MA_Sgo extends Quest

_MA_Mcm Property Menu Auto

Int Function IF_ActorMilkGetCapacity(Quest SgoQuest, Actor Cow)
	dcc_sgo_QuestController SgoScript = SgoQuest as dcc_sgo_QuestController
	Return SgoScript.ActorMilkGetCapacity(Cow)
EndFunction

Function IF_ActorMilkRemove(Quest SgoQuest, Actor Cow)
	dcc_sgo_QuestController SgoScript = SgoQuest as dcc_sgo_QuestController
	SgoScript.ActorMilkRemove(Cow)
EndFunction

Int Function IF_ActorMilkGetCount(Quest SgoQuest, Actor Cow)
	dcc_sgo_QuestController SgoScript = SgoQuest as dcc_sgo_QuestController
	Return SgoScript.ActorMilkGetCount(Cow)
EndFunction

Function IF_SetSgoMilkTime(Quest SgoQuest)
	dcc_sgo_QuestController SgoScript = SgoQuest as dcc_sgo_QuestController
	SgoScript.OptMilkProduceTime = Menu.SgoMilkProductionTime
EndFunction

Float Function IF_GetSgoMilkTime(Quest SgoQuest)
	dcc_sgo_QuestController SgoScript = SgoQuest as dcc_sgo_QuestController
	Return SgoScript.OptMilkProduceTime
EndFunction