Scriptname SLV_WindhelmAlias extends ReferenceAlias  

Event OnPlayerLoadGame()
	Utility.wait(5)

	;MiscUtil.PrintConsole("MCM Jarl of Windhelm= " + pJarlBackup.GetActorRef().getActorBase().getName())
	pJarl.ForceRefTo(pJarlBackup.GetActorRef())
	;MiscUtil.PrintConsole("Windhelmquest Jarl of Windhelm= " + pJarl.GetActorRef().getActorBase().getName())
EndEvent
ReferenceAlias Property pJarl Auto 
ReferenceAlias Property pJarlBackup Auto 