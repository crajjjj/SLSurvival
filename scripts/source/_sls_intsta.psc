Scriptname _SLS_IntSta Hidden 

Int Function GetPlayerMasochismAttitude(Quest SpankQuest) Global
	_STA_SpankUtil SpankUtil = SpankQuest as _STA_SpankUtil
	Return SpankUtil.GetMasochismAttitude(SpankUtil.PlayerMasochism)
EndFunction

Function QueueComment(Quest DialogUtilQuest, Topic WhatToSay, Bool PriorityComment, Bool ForcedGagComment = false) Global
	(DialogUtilQuest as _STA_SexDialogUtil).QueueComment(WhatToSay, PriorityComment, ForcedGagComment)
EndFunction

Float Function GetPlayerMasochism(Quest SpankQuest) Global
	Return (SpankQuest as _STA_SpankUtil).PlayerMasochism
EndFunction

Float Function GetMasochismStepSize(Quest SpankQuest) Global
	Return (SpankQuest as _STA_SpankUtil).MasochismStepSize
EndFunction
