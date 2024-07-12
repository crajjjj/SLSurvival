Scriptname SLV_SwapDawnstarJarl extends Quest  


{watches for jarl changing and swaps with backup
 put on the Jarl alias
}

function updateJarlOfDawnstar()
	if !pJarl.GetActorRef().IsInFaction(isJarlFaction) == 1
		; swap the aliases
		pJarl.ForceRefTo(pJarlBackup.GetActorRef())
		pHousecarl.ForceRefTo(pHousecarlBackup.GetActorRef())
	endif	
endfunction

ReferenceAlias Property pJarl  Auto  
{Jarl alias}
ReferenceAlias Property pHousecarl  Auto  
{Housecarl alias}

ReferenceAlias Property pJarlBackup  Auto  
{JarlBackup alias}
ReferenceAlias Property pHousecarlBackup  Auto  
{HousecarlBackup alias}
Faction Property isJarlFaction Auto