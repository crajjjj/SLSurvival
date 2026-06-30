Scriptname sr_FTUQuestBase extends Quest 

GlobalVariable Property questsDone auto
GlobalVariable Property questsStartAllowed auto
sr_FTUDeliveryFrame Property ftu auto
sr_inflateQuest Property inflater auto

Function CompleteAndWaitForReset(float hours)
	questsStartAllowed.SetValue(Utility.GetCurrentGameTime() + (hours / 24))
	questsDone.Mod(1)
	CompleteQuest()
	stop()
EndFunction

