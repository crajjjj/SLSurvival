Scriptname SLV_SolitudeSwapJarl extends Quest  

function updateLeaderOfSolitude()
	Actor general =  pGeneral.GetRef() as Actor

	if  general.IsDead() ; || civilwar.iscompleted()
		; swap the aliases
		Actor backup = pGeneralBackup.GetActorRef()
		pGeneral.ForceRefTo(backup)
		;Debug.notification("New Generall = " + (pGeneral.GetRef() as Actor).getActorBase().getName())
	endif	
endfunction

ReferenceAlias Property pGeneral  Auto  
ReferenceAlias Property pGeneralBackup  Auto
  
Quest Property civilwar Auto

