Scriptname _SLS_GuardWarnMilkPunishAlias extends ReferenceAlias  

Event OnGetUp(ObjectReference akFurniture)
	Self.GetOwningQuest().SetCurrentStageID(20)
	((Self.GetOwningQuest().GetNthAlias(0) as ReferenceAlias).GetReference() as Actor).EvaluatePackage()
	Util.ResumeSwAddicted()
	_SLS_ScreamForHelpSpectateQuest.Stop()
	;Debug.Messagebox("Got UP")
EndEvent

SLS_Utility Property Util Auto

Quest Property _SLS_ScreamForHelpSpectateQuest Auto
