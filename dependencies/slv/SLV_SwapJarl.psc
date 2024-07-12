Scriptname SLV_SwapJarl extends Quest  

{watches for jarl changing and swaps with backup
 put on the Jarl alias
}

function updateJarlOfWhiterun()
	if !pJarl.GetActorRef().IsInFaction(isJarlFaction) == 1
		; swap the aliases
		pJarl.ForceRefTo(pJarlBackup.GetActorRef())
		mainquest.isWhiterunImperial = false  
	endif	
endfunction

function updateJarlOfMorthal()
	if !pJarMorthal.GetActorRef().IsInFaction(isJarlFaction) == 1
		; swap the aliases
		pJarMorthal.ForceRefTo(pJarlMorthalBackup.GetActorRef())
	endif	
endfunction

ReferenceAlias Property pJarl  Auto  
ReferenceAlias Property pJarlBackup  Auto
Faction Property isJarlFaction Auto
SLV_SoftDependency Property mainquest auto

ReferenceAlias Property pJarMorthal Auto  
ReferenceAlias Property pJarlMorthalBackup  Auto