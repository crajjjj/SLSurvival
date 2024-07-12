Scriptname _SLS_IntDf  Hidden
;/
Float Function GetDfVersion(Quest DfMcmQuest) Global
	Return (DfMcmQuest as _DFlowMCM).GetDFVersion()
EndFunction
/;