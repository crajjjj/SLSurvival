Scriptname _SLS_IntAmp Hidden 

Function Amputate(Quest AmpQuest, Actor akActor, Int morphType , Int bothLeftRight, Form akSource) Global
	(AmpQuest as _AMP_Main).ApplyAmputator(akActor, morphType , bothLeftRight, SendEvent = true, akSource = akSource)
EndFunction
