Scriptname SLV_AbolitionismJarl extends ReferenceAlias  

Event OnPlayerLoadGame()
Utility.wait(7)
;MiscUtil.PrintConsole("MCM Jarl of Morthal= " + pJarlBackup.GetActorRef().getActorBase().getName())
pJarl.ForceRefTo(pJarlBackup.GetActorRef())
;MiscUtil.PrintConsole("Jarl of Whiterun= " + pJarl.GetActorRef().getActorBase().getName())

;MiscUtil.PrintConsole("MCM Jarl of Whiterun= " + pJarlBackup.GetActorRef().getActorBase().getName())
pJarl2.ForceRefTo(pJarlBackup2.GetActorRef())
;MiscUtil.PrintConsole("Jarl of Whiterun= " + pJarl.GetActorRef().getActorBase().getName())

EndEvent
ReferenceAlias Property pJarl Auto 
ReferenceAlias Property pJarlBackup Auto 

ReferenceAlias Property pJarl2 Auto 
ReferenceAlias Property pJarlBackup2 Auto 