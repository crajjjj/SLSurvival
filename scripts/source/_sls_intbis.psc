Scriptname _SLS_IntBis Hidden

Function TryBatheActor(Quest BisQuest, Actor DirtyActor, MiscObject WashProp) Global
	(BisQuest as mzinBatheQuest).TryWashActor(DirtyActor, WashProp) ; Renewed renamed TryBatheActor -> TryWashActor
EndFunction
