Scriptname SLV_Mainquest2Timer extends Quest  

Function StartMainquest2Timer()
RegisterForSingleUpdateGameTime(24) ; 7 * 24h
EndFunction 

Event OnUpdateGameTime()

if SLV_Mainquest2Quest.getStage() == 180
	SLV_Mainquest2Quest.SetObjectiveCompleted(180)
	SLV_Mainquest2Quest.setStage(200)

	moveToRifen(SLV_JarlMorthal1.getActorRef())
	moveToRifen(SLV_Elenwen.getActorRef())
	moveToRifen(SLV_Maven.getActorRef())
	moveToRifen(SLV_Delphine.getActorRef())
	return
elseif SLV_Mainquest2Quest.getStage() == 280
	SLV_Mainquest2Quest.SetObjectiveCompleted(280)
	SLV_Mainquest2Quest.setStage(1000)

	SLV_JarlMorthal1.getActorRef().moveto( morthalHouse )

	ActorUtil.ClearPackageOverride( SLV_JarlMorthal1.getActorRef())
	SLV_JarlMorthal1.getActorRef().evaluatePackage()

	ActorUtil.ClearPackageOverride( SLV_Elenwen.getActorRef())
	SLV_Elenwen.getActorRef().evaluatePackage()

	ActorUtil.ClearPackageOverride( SLV_Maven.getActorRef())
	SLV_Maven.getActorRef().evaluatePackage()

	ActorUtil.ClearPackageOverride( SLV_Delphine.getActorRef())
	SLV_Delphine.getActorRef().evaluatePackage()


endif
endEvent

Quest Property SLV_Mainquest2Quest Auto
ObjectReference Property morthalHouse Auto

ReferenceAlias Property SLV_JarlMorthal1 Auto
ReferenceAlias Property SLV_Elenwen Auto
ReferenceAlias Property SLV_Maven Auto
ReferenceAlias Property SLV_Delphine Auto
ReferenceAlias Property SLV_LadyMaraPriestess Auto

function moveToRifen(Actor npc)

if npc.isDead()
	return
endif

npc.moveto( SLV_LadyMaraPriestess.getActorRef())

ActorUtil.ClearPackageOverride(npc)
npc.evaluatePackage()

ActorUtil.AddPackageOverride(npc, SLV_DoNothing ,100)
npc.evaluatePackage()
npc.moveto( SLV_LadyMaraPriestess.getActorRef())
endfunction
Package Property SLV_DoNothing Auto

