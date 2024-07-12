Scriptname _SLS_SenseArousal extends Quest  

Function Shutdown()
	StopEffects()
	Stop()
EndFunction

Function StopEffects()
	Int i = 1
	ObjectReference ObjRef
	While i < GetNumAliases()
		ObjRef = (GetNthAlias(i) as ReferenceAlias).GetReference()
		If ObjRef
			(GetNthAlias(i) as _SLS_SenseArousalAlias).Shutdown()
		Else
			Return
		EndIf
		i += 1
	EndWhile
EndFunction

Faction Property sla_Arousal Auto Hidden

_SLS_InterfaceSlax Property SlAroused Auto
;sslActorStats Property SlStats Auto ; Seeding stats doesn't do what I want - seed arousal
