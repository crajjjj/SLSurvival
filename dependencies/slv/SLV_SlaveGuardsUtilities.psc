Scriptname SLV_SlaveGuardsUtilities extends Quest  

function SLV_RemoveAllSlaver()
SLV_RemoveDawnstarSlaver()
SLV_RemoveFalkreathSlaver()
SLV_RemoveMarkarthSlaver()
SLV_RemoveMorthalSlaver()
SLV_RemoveMorthalSlaver()
SLV_RemoveRavenRockSlaver()
SLV_RemoveRiftenSlaver()
SLV_RemoveRiverwoodSlaver()
SLV_RemoveSolitudeSlaver()
SLV_RemoveWhiterunSlaver()
SLV_RemoveWindhelmSlaver()
SLV_RemoveWinterholdSlaver()
endfunction

function SLV_RemoveDawnstarSlaver()
SLV_GuardCleanup(SLV_DawnstarSlaver1)
endfunction
function SLV_AddDawnstarSlaver()
SLV_GuardSetup(SLV_DawnstarSlaver1)
endfunction

function SLV_RemoveFalkreathSlaver()
SLV_GuardCleanup(SLV_FalkreathSlaver1)
SLV_GuardCleanup(SLV_FalkreathSlaver2)
endfunction
function SLV_AddFalkreathSlaver()
SLV_GuardSetup(SLV_FalkreathSlaver1)
SLV_GuardSetup(SLV_FalkreathSlaver2)
endfunction

function SLV_RemoveMarkarthSlaver()
SLV_GuardCleanup(SLV_MarkarthSlaver1)
endfunction
function SLV_AddMarkarthSlaver()
SLV_GuardSetup(SLV_MarkarthSlaver1)
endfunction

function SLV_RemoveMorthalSlaver()
SLV_GuardCleanup(SLV_MorthalSlaver1)
SLV_GuardCleanup(SLV_MorthalSlaver2)
endfunction
function SLV_AddMorthalSlaver()
SLV_GuardSetup(SLV_MorthalSlaver1)
SLV_GuardSetup(SLV_MorthalSlaver2)
endfunction

function SLV_RemoveRavenRockSlaver()
SLV_GuardCleanup(SLV_RavenRockSlaver1)
SLV_GuardCleanup(SLV_RavenRockSlaver2)
endfunction
function SLV_AddRavenRockSlaver()
SLV_GuardSetup(SLV_RavenRockSlaver1)
SLV_GuardSetup(SLV_RavenRockSlaver2)
endfunction

function SLV_RemoveRiftenSlaver()
SLV_GuardCleanup(SLV_RiftenSlaver1)
SLV_GuardCleanup(SLV_RiftenSlaver2)
endfunction
function SLV_AddRiftenSlaver()
SLV_GuardSetup(SLV_RiftenSlaver1)
SLV_GuardSetup(SLV_RiftenSlaver2)
endfunction

function SLV_RemoveRiverwoodSlaver()
SLV_GuardCleanup(SLV_RiverwoodSlaver1)
SLV_GuardCleanup(SLV_RiverwoodSlaver2)
endfunction
function SLV_AddRiverwoodSlaver()
SLV_GuardSetup(SLV_RiverwoodSlaver1)
SLV_GuardSetup(SLV_RiverwoodSlaver2)
endfunction

function SLV_RemoveSolitudeSlaver()
SLV_GuardCleanup(SLV_SolitudeSlaver1)
endfunction
function SLV_AddSolitudeSlaver()
SLV_GuardSetup(SLV_SolitudeSlaver1)
endfunction

function SLV_RemoveWhiterunSlaver()
SLV_GuardCleanup(SLV_WhiterunSlaver1)
endfunction
function SLV_AddWhiterunSlaver()
SLV_GuardSetup(SLV_WhiterunSlaver1)
endfunction

function SLV_RemoveWindhelmSlaver()
SLV_GuardCleanup(SLV_WindhelmSlaver1)
endfunction
function SLV_AddWindhelmSlaver()
SLV_GuardSetup(SLV_WindhelmSlaver1)
endfunction

function SLV_RemoveWinterholdSlaver()
SLV_GuardCleanup(SLV_WinterholdSlaver1)
SLV_GuardCleanup(SLV_WinterholdSlaver2)
endfunction
function SLV_AddWinterholdSlaver()
SLV_GuardSetup(SLV_WinterholdSlaver1)
SLV_GuardSetup(SLV_WinterholdSlaver2)
endfunction

function SLV_RemoveAllGuards()
SLV_RemoveDawnstarGuards()
SLV_RemoveFalkreathGuards()
SLV_RemoveMarkarthGuards()
SLV_RemoveMorthalGuards()
SLV_RemoveMorthalGuards()
SLV_RemoveRavenRockGuards()
SLV_RemoveRiftenGuards()
SLV_RemoveRiverwoodGuards()
SLV_RemoveSolitudeGuards()
SLV_RemoveWhiterunGuards()
SLV_RemoveWindhelmGuards()
SLV_RemoveWinterholdGuards()
endfunction

function SLV_RemoveDawnstarGuards()
SLV_GuardCleanup(SLV_DawnstarGuard1.getActorRef())
SLV_GuardCleanup(SLV_DawnstarGuard2.getActorRef())
endfunction

function SLV_RemoveFalkreathGuards()
SLV_GuardCleanup(SLV_FalkreathGuard1.getActorRef())
SLV_GuardCleanup(SLV_FalkreathGuard2.getActorRef())
endfunction

function SLV_RemoveMarkarthGuards()
SLV_GuardCleanup(SLV_MarkarthGuard1.getActorRef())
SLV_GuardCleanup(SLV_MarkarthGuard2.getActorRef())
endfunction

function SLV_RemoveMorthalGuards()
SLV_GuardCleanup(SLV_MorthalGuard1.getActorRef())
SLV_GuardCleanup(SLV_MorthalGuard2.getActorRef())
endfunction

function SLV_RemoveRavenRockGuards()
SLV_GuardCleanup(SLV_RavenRockGuard1.getActorRef())
SLV_GuardCleanup(SLV_RavenRockGuard2.getActorRef())
endfunction

function SLV_RemoveRiftenGuards()
SLV_GuardCleanup(SLV_RiftenGuard1.getActorRef())
SLV_GuardCleanup(SLV_RiftenGuard2.getActorRef())
endfunction

function SLV_RemoveRiverwoodGuards()
SLV_GuardCleanup(SLV_RiverwoodGuard1.getActorRef())
SLV_GuardCleanup(SLV_RiverwoodGuard2.getActorRef())
endfunction

function SLV_RemoveSolitudeGuards()
SLV_GuardCleanup(SLV_SolitudeGuard1.getActorRef())
SLV_GuardCleanup(SLV_SolitudeGuard2.getActorRef())
endfunction

function SLV_RemoveWhiterunGuards()
SLV_GuardCleanup(SLV_WhiterunGuard1.getActorRef())
SLV_GuardCleanup(SLV_WhiterunGuard2.getActorRef())
endfunction

function SLV_RemoveWindhelmGuards()
SLV_GuardCleanup(SLV_WindhelmGuard1.getActorRef())
SLV_GuardCleanup(SLV_WindhelmGuard2.getActorRef())
endfunction

function SLV_RemoveWinterholdGuards()
SLV_GuardCleanup(SLV_WinterholdGuard1.getActorRef())
SLV_GuardCleanup(SLV_WinterholdGuard2.getActorRef())
endfunction

function SLV_GuardCleanup(Actor NPCActor) 
if NPCActor.isDead()
	NPCActor.resurrect()
endif
NPCActor.disable()
endfunction
function SLV_GuardSetup(Actor NPCActor) 
if NPCActor.isDead()
	NPCActor.resurrect()
endif
NPCActor.enable()
endfunction

ReferenceAlias Property SLV_DawnstarGuard1 Auto
ReferenceAlias Property SLV_DawnstarGuard2 Auto
ReferenceAlias Property SLV_FalkreathGuard1 Auto
ReferenceAlias Property SLV_FalkreathGuard2 Auto
ReferenceAlias Property SLV_MarkarthGuard1 Auto
ReferenceAlias Property SLV_MarkarthGuard2 Auto
ReferenceAlias Property SLV_MorthalGuard1 Auto
ReferenceAlias Property SLV_MorthalGuard2 Auto
ReferenceAlias Property SLV_RavenRockGuard1 Auto
ReferenceAlias Property SLV_RavenRockGuard2 Auto
ReferenceAlias Property SLV_RiftenGuard1 Auto
ReferenceAlias Property SLV_RiftenGuard2 Auto
ReferenceAlias Property SLV_RiverwoodGuard1 Auto
ReferenceAlias Property SLV_RiverwoodGuard2 Auto
ReferenceAlias Property SLV_SolitudeGuard1 Auto
ReferenceAlias Property SLV_SolitudeGuard2 Auto
ReferenceAlias Property SLV_WhiterunGuard1 Auto
ReferenceAlias Property SLV_WhiterunGuard2 Auto
ReferenceAlias Property SLV_WindhelmGuard1 Auto
ReferenceAlias Property SLV_WindhelmGuard2 Auto
ReferenceAlias Property SLV_WinterholdGuard1 Auto
ReferenceAlias Property SLV_WinterholdGuard2 Auto



Actor Property SLV_DawnstarSlaver1 Auto
Actor Property SLV_FalkreathSlaver1 Auto
Actor Property SLV_FalkreathSlaver2 Auto
Actor Property SLV_MarkarthSlaver1 Auto
Actor Property SLV_MorthalSlaver1 Auto
Actor Property SLV_MorthalSlaver2 Auto
Actor Property SLV_RavenRockSlaver1 Auto
Actor Property SLV_RavenRockSlaver2 Auto
Actor Property SLV_RiftenSlaver1 Auto
Actor Property SLV_RiftenSlaver2 Auto
Actor Property SLV_RiverwoodSlaver1 Auto
Actor Property SLV_RiverwoodSlaver2 Auto
Actor Property SLV_SolitudeSlaver1 Auto
Actor Property SLV_WhiterunSlaver1 Auto
Actor Property SLV_WindhelmSlaver1 Auto
Actor Property SLV_WinterholdSlaver1 Auto
Actor Property SLV_WinterholdSlaver2 Auto















