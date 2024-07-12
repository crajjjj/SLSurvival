Scriptname SLV_Mainquest2Alias extends ReferenceAlias  

Event OnPlayerLoadGame()
Utility.wait(6)
;MiscUtil.PrintConsole("MCM Jarl of Whiterun= " + pJarlBackup.GetActorRef().getActorBase().getName())
pJarl.ForceRefTo(pJarlBackup.GetActorRef())
;MiscUtil.PrintConsole("Jarl of Whiterun= " + pJarl.GetActorRef().getActorBase().getName())

pJarMorthal.ForceRefTo(pJarlMorthalBackup.GetActorRef())
	
EndEvent
ReferenceAlias Property pJarl Auto 
ReferenceAlias Property pJarlBackup Auto 
ReferenceAlias Property pJarMorthal Auto  
ReferenceAlias Property pJarlMorthalBackup  Auto