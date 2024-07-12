Scriptname SLV_SwapWinterholdJarl extends Quest  

{watches for jarl changing and swaps with backup
 put on the Jarl alias
}

function updateJarlOfWinterhold()
	Actor jarl =  pJarl.GetRef() as Actor
	;Debug.notification("Old Jarl = " + jarl.getActorBase().getName())

	if !jarl.IsInFaction(isJarlFaction) == 1
		; swap the aliases
		Actor backup = pJarlBackup.GetActorRef()
		pJarl.ForceRefTo(backup)

		;Debug.notification("New Jarl = " + (pJarl.GetRef() as Actor).getActorBase().getName())
	endif	
endfunction

ReferenceAlias Property pJarl  Auto  
{Jarl alias}

ReferenceAlias Property pJarlBackup  Auto  
{JarlBackup alias}

Keyword Property pJarlKeyword Auto
{JobJarl keyword}

Faction Property isJarlFaction Auto
