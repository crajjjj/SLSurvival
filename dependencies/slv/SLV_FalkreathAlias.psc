Scriptname SLV_FalkreathAlias extends ReferenceAlias  

Event OnPlayerLoadGame()
	Utility.wait(5)

	;MiscUtil.PrintConsole("MCM Jarl of Falkreath= " + pJarlBackup.GetActorRef().getActorBase().getName())
	pJarl.ForceRefTo(pJarlBackup.GetActorRef())
	;MiscUtil.PrintConsole("Falkreathquest Jarl of Falkreath= " + pJarl.GetActorRef().getActorBase().getName())

	;MiscUtil.PrintConsole("MCM Housecarl of Falkreath= " + pHousecarlBackup.GetActorRef().getActorBase().getName())
	pHousecarl.ForceRefTo(pHousecarlBackup.GetActorRef())
	;MiscUtil.PrintConsole("Falkreathquest Housecarl of Falkreath= " + pHousecarl.GetActorRef().getActorBase().getName())
EndEvent
ReferenceAlias Property pJarl Auto 
ReferenceAlias Property pJarlBackup Auto 

ReferenceAlias Property pHousecarl Auto 
ReferenceAlias Property pHousecarlBackup Auto 