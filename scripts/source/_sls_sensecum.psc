Scriptname _SLS_SenseCum extends Quest  

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
			(GetNthAlias(i) as _SLS_SenseCumAlias).Shutdown()
		Else
			Return
		EndIf
		i += 1
	EndWhile
EndFunction

SLS_Utility Property Util Auto
