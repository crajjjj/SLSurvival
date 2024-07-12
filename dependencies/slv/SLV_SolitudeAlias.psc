Scriptname SLV_SolitudeAlias extends ReferenceAlias  

Event OnPlayerLoadGame()
	Utility.wait(5)

	;MiscUtil.PrintConsole("MCM General of Solitude= " + pJarlBackup.GetActorRef().getActorBase().getName())
	pJarl.ForceRefTo(pJarlBackup.GetActorRef())
	;MiscUtil.PrintConsole(Solitudequest General of Solitude= " + pJarl.GetActorRef().getActorBase().getName())
EndEvent
ReferenceAlias Property pJarl Auto 
ReferenceAlias Property pJarlBackup Auto 