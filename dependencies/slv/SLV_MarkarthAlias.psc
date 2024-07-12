Scriptname SLV_MarkarthAlias extends ReferenceAlias  

Event OnPlayerLoadGame()
	Utility.wait(5)

	;MiscUtil.PrintConsole("MCM Jarl of Markarth= " + pJarlBackup.GetActorRef().getActorBase().getName())
	pJarl.ForceRefTo(pJarlBackup.GetActorRef())
	;MiscUtil.PrintConsole("Markarthquest Jarl of Markarth= " + pJarl.GetActorRef().getActorBase().getName())

	;MiscUtil.PrintConsole("MCM Housecarl of Markarth= " + pHousecarlBackup.GetActorRef().getActorBase().getName())
	pHousecarl.ForceRefTo(pHousecarlBackup.GetActorRef())
	;MiscUtil.PrintConsole("Markarthquest Housecarl of Markarth= " + pHousecarl.GetActorRef().getActorBase().getName())
EndEvent
ReferenceAlias Property pJarl Auto 
ReferenceAlias Property pJarlBackup Auto 

ReferenceAlias Property pHousecarl Auto 
ReferenceAlias Property pHousecarlBackup Auto 