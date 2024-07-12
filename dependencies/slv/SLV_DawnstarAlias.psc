Scriptname SLV_DawnstarAlias  extends ReferenceAlias  

Event OnPlayerLoadGame()
	Utility.wait(5)

	;MiscUtil.PrintConsole("MCM Jarl of Dawnstar= " + pJarlBackup.GetActorRef().getActorBase().getName())
	pJarl.ForceRefTo(pJarlBackup.GetActorRef())
	;MiscUtil.PrintConsole("Dawnstarquest Jarl of Dawnstar= " + pJarl.GetActorRef().getActorBase().getName())

	;MiscUtil.PrintConsole("MCM Housecarl of Dawnstar= " + pHousecarlBackup.GetActorRef().getActorBase().getName())
	pHousecarl.ForceRefTo(pHousecarlBackup.GetActorRef())
	;MiscUtil.PrintConsole("Dawnstarhquest Housecarl of Dawnstar= " + pHousecarl.GetActorRef().getActorBase().getName())
EndEvent
ReferenceAlias Property pJarl Auto 
ReferenceAlias Property pJarlBackup Auto 

ReferenceAlias Property pHousecarl Auto 
ReferenceAlias Property pHousecarlBackup Auto 