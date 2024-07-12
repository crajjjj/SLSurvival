Scriptname SLV_SwapFalkreathJarl extends Quest  

{watches for jarl changing and swaps with backup
 put on the Jarl alias
}

function updateJarlOfFalkreath()
	Actor jarl =  pJarl.GetRef() as Actor
	;Debug.notification("Old Jarl = " + jarl.getActorBase().getName())
	;if pJarl.GetRef().HasKeyword(pJarlKeyword) == 0
	;if isWhiterunDefeated.isCompleted() == 1
	if !jarl.IsInFaction(isJarlFaction) == 1
		; swap the aliases
		Actor backup = pJarlBackup.GetActorRef()
		pJarl.ForceRefTo(backup)
		Actor backup2 = pHousecarlBackup.GetActorRef()
		pHousecarl.ForceRefTo(backup2)		;pJarlBackup.ForceRefTo(jarl)
		;Debug.notification("New Jarl = " + (pJarl.GetRef() as Actor).getActorBase().getName())
	endif	
endfunction

ReferenceAlias Property pJarl  Auto  
{Jarl alias}
ReferenceAlias Property pHousecarl  Auto  

ReferenceAlias Property pJarlBackup  Auto  
{JarlBackup alias}
ReferenceAlias Property pHousecarlBackup  Auto  

Keyword Property pJarlKeyword Auto
{JobJarl keyword}

Faction Property isJarlFaction Auto