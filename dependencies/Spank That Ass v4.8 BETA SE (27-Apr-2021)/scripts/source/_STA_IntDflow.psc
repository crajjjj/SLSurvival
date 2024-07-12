Scriptname _STA_IntDflow  Hidden 

Float Function GetDfVersion(Quest DfMcmQuest) Global
	Return (DfMcmQuest as _DFlowMCM).GetDFVersion()
EndFunction
