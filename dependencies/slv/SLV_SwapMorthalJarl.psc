Scriptname SLV_SwapMorthalJarl extends Quest  

{watches for jarl changing and swaps with backup
 put on the Jarl alias
}

function updateJarlOfMorthal()
	Actor jarl =  pJarl.GetRef() as Actor

	if !jarl.IsInFaction(isJarlFaction) == 1
		; swap the aliases
		Actor backup = pJarlBackup.GetActorRef()
		pJarl.ForceRefTo(backup)
		;Actor backup2 = pHousecarlBackup.GetActorRef()
		;pHousecarl.ForceRefTo(backup2)

		;pJarlBackup.ForceRefTo(jarl)
		;Debug.notification("New Jarl = " + (pJarl.GetRef() as Actor).getActorBase().getName())
	endif	
endfunction

ReferenceAlias Property pJarl  Auto  
{Jarl alias}
;ReferenceAlias Property pHousecarl  Auto  
;{Housecarl alias}


ReferenceAlias Property pJarlBackup  Auto  
{JarlBackup alias}
;ReferenceAlias Property pHousecarlBackup  Auto  
;{HousecarlBackup alias}

Keyword Property pJarlKeyword Auto
{JobJarl keyword}

Faction Property isJarlFaction Auto
