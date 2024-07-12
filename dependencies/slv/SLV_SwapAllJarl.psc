Scriptname SLV_SwapAllJarl extends Quest  

function updateAllJarls()
	Actor jarl =  pJarl1.GetRef() as Actor
	if !jarl.IsInFaction(isJarlFaction) == 1
		; swap the aliases
		Actor backup = pJarlBackup1.GetActorRef()
		pJarl1.ForceRefTo(backup)
		;Debug.notification("New Jarl = " + (pJarl1.GetRef() as Actor).getActorBase().getName())
	endif

	Actor jarl2 =  pJarl2.GetRef() as Actor
	if !jarl2.IsInFaction(isJarlFaction) == 1
		; swap the aliases
		Actor backup2 = pJarlBackup2.GetActorRef()
		pJarl2.ForceRefTo(backup2)
		;Debug.notification("New Jarl = " + (pJarl2.GetRef() as Actor).getActorBase().getName())
	endif

	Actor jarl3 =  pJarl3.GetRef() as Actor
	if !jarl3.IsInFaction(isJarlFaction) == 1
		; swap the aliases
		Actor backup3 = pJarlBackup3.GetActorRef()
		pJarl3.ForceRefTo(backup3)
		;Debug.notification("New Jarl = " + (pJarl3.GetRef() as Actor).getActorBase().getName())
	endif

	Actor jarl4 =  pJarl4.GetRef() as Actor
	if !jarl4.IsInFaction(isJarlFaction) == 1
		; swap the aliases
		Actor backup4 = pJarlBackup4.GetActorRef()
		pJarl4.ForceRefTo(backup4)
		;Debug.notification("New Jarl = " + (pJarl4.GetRef() as Actor).getActorBase().getName())
	endif

	Actor jarl5 =  pJarl5.GetRef() as Actor
	if !jarl5.IsInFaction(isJarlFaction) == 1
		; swap the aliases
		Actor backup5 = pJarlBackup5.GetActorRef()
		pJarl5.ForceRefTo(backup5)
		;Debug.notification("New Jarl = " + (pJarl5.GetRef() as Actor).getActorBase().getName())
	endif
endfunction

ReferenceAlias Property pJarl1 Auto  
ReferenceAlias Property pJarl2 Auto    
ReferenceAlias Property pJarl3 Auto  
ReferenceAlias Property pJarl4 Auto 
ReferenceAlias Property pJarl5 Auto

ReferenceAlias Property pJarlBackup1 Auto  
ReferenceAlias Property pJarlBackup2 Auto    
ReferenceAlias Property pJarlBackup3 Auto  
ReferenceAlias Property pJarlBackup4 Auto 
ReferenceAlias Property pJarlBackup5 Auto

Faction Property isJarlFaction Auto