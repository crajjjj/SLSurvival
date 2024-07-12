Scriptname SLV_SwapWhiterunJarl extends Quest  

{watches for jarl changing and swaps with backup
 put on the Jarl alias
}

function updateJarlOfWhiterun()
	Actor jarl =  pJarl.GetRef() as Actor
	if !jarl.IsInFaction(isJarlFaction) == 1
		; swap the aliases
		Actor backup = pJarlBackup.GetActorRef()
		pJarl.ForceRefTo(backup)
	endif	
endfunction

ReferenceAlias Property pJarl  Auto  
{Jarl alias}

ReferenceAlias Property pJarlBackup  Auto  
{JarlBackup alias}

Faction Property isJarlFaction Auto

