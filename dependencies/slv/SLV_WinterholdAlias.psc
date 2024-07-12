Scriptname SLV_WinterholdAlias extends ReferenceAlias  

Event OnPlayerLoadGame()
	Utility.wait(5)

	;MiscUtil.PrintConsole("MCM Jarl of Winterhold= " + pJarlBackup.GetActorRef().getActorBase().getName())
	pJarl.ForceRefTo(pJarlBackup.GetActorRef())
	;MiscUtil.PrintConsole(Winterholdquest Jarl of Winterhold= " + pJarl.GetActorRef().getActorBase().getName())
EndEvent
ReferenceAlias Property pJarl Auto 
ReferenceAlias Property pJarlBackup Auto 
