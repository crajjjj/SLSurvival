Scriptname SLV_EnforcerSexStart extends Quest  

function SLV_EnforcerAnimalRape(Actor SLV_Animal1)
SLV_RapeAnimal1.ForceRefTo(SLV_Animal1)

SLV_Watcher1.ForceRefTo(SLV_Spectator1.getActorRef())
SLV_Watcher2.ForceRefTo(SLV_Spectator2.getActorRef())

myScripts.SLV_PlayScene(SLV_AnimalScene)
endFunction



function SLV_EnforcerNormalRape(Actor SLV_Rapist)
SLV_Raper1.ForceRefTo(SLV_Rapist)

if SLV_Rapist != SLV_Spectator1.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator1.getActorRef())
elseif SLV_Rapist != SLV_Spectator2.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator2.getActorRef())
elseif SLV_Rapist != SLV_Spectator3.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator3.getActorRef())
elseif SLV_Rapist != SLV_Spectator4.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator4.getActorRef())
elseif SLV_Rapist != SLV_Spectator5.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator5.getActorRef())
elseif SLV_Rapist != SLV_Spectator6.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator6.getActorRef())
endif

if SLV_Rapist != SLV_Spectator1.getActorRef() && SLV_Watcher1.getActorRef() != SLV_Spectator1.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator1.getActorRef())
elseif SLV_Rapist != SLV_Spectator2.getActorRef() && SLV_Watcher1.getActorRef() != SLV_Spectator2.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator2.getActorRef())
elseif SLV_Rapist != SLV_Spectator3.getActorRef() && SLV_Watcher1.getActorRef() != SLV_Spectator3.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator3.getActorRef())
elseif SLV_Rapist != SLV_Spectator4.getActorRef() && SLV_Watcher1.getActorRef() != SLV_Spectator4.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator4.getActorRef())
elseif SLV_Rapist != SLV_Spectator5.getActorRef() && SLV_Watcher1.getActorRef() != SLV_Spectator5.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator5.getActorRef())
elseif SLV_Rapist != SLV_Spectator6.getActorRef() && SLV_Watcher1.getActorRef() != SLV_Spectator6.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator6.getActorRef())
endif

myScripts.SLV_DisplayInformation("Spectator1: " + SLV_Spectator1.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Spectator2: " + SLV_Spectator2.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Spectator3: " + SLV_Spectator3.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Spectator4: " + SLV_Spectator4.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Spectator5: " + SLV_Spectator5.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Spectator6: " + SLV_Spectator6.getActorRef().getActorBase().getName())

myScripts.SLV_DisplayInformation("Watcher1: " + SLV_Watcher1.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Watcher2: " + SLV_Watcher2.getActorRef().getActorBase().getName())

myScripts.SLV_PlayScene(SLV_NormalScene )
endFunction


function SLV_EnforcerFreeRape(Actor SLV_Rapist)
SLV_EnforcerFillRefs(SLV_Rapist)

myScripts.SLV_PlayScene(SLV_FreeScene )
endFunction


function SLV_EnforcerDemonstration(Actor SLV_Rapist)
SLV_EnforcerFillRefs(SLV_Rapist)

myScripts.SLV_PlayScene(SLV_DemonstrationScene )
endFunction


function SLV_EnforcerDemonstration2(Actor SLV_Rapist)
SLV_EnforcerFillRefs(SLV_Rapist)

myScripts.SLV_PlayScene(SLV_DemonstrationScene2 )
endFunction


function SLV_EnforcerDemonstration3(Actor SLV_Rapist)
SLV_EnforcerFillRefs(SLV_Rapist)

myScripts.SLV_PlayScene(SLV_DemonstrationScene3 )
endFunction


function SLV_EnforcerDemonstration4(Actor SLV_Rapist)
SLV_EnforcerFillRefs(SLV_Rapist)

myScripts.SLV_PlayScene(SLV_DemonstrationScene4 )
endFunction


function SLV_EnforcerSlaverRape(Actor SLV_Rapist)
SLV_EnforcerFillRefs(SLV_Rapist)

myScripts.SLV_PlayScene(SLV_SlaverRapeScene )
endFunction

function SLV_EnforcerPunishFree(Actor SLV_Rapist)
SLV_EnforcerFillRefs(SLV_Rapist)

myScripts.SLV_PlayScene(SLV_PunishFreeScene )
endFunction


function SLV_EnforcerFillRefs(Actor SLV_Rapist)
SLV_Raper1.ForceRefTo(SLV_Rapist)

if SLV_Rapist != SLV_Spectator1.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator1.getActorRef())
elseif SLV_Rapist != SLV_Spectator2.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator2.getActorRef())
elseif SLV_Rapist != SLV_Spectator3.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator3.getActorRef())
elseif SLV_Rapist != SLV_Spectator4.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator4.getActorRef())
elseif SLV_Rapist != SLV_Spectator5.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator5.getActorRef())
elseif SLV_Rapist != SLV_Spectator6.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator6.getActorRef())
endif

if SLV_Rapist != SLV_Spectator1.getActorRef() && SLV_Watcher1.getActorRef() != SLV_Spectator1.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator1.getActorRef())
elseif SLV_Rapist != SLV_Spectator2.getActorRef() && SLV_Watcher1.getActorRef() != SLV_Spectator2.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator2.getActorRef())
elseif SLV_Rapist != SLV_Spectator3.getActorRef() && SLV_Watcher1.getActorRef() != SLV_Spectator3.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator3.getActorRef())
elseif SLV_Rapist != SLV_Spectator4.getActorRef() && SLV_Watcher1.getActorRef() != SLV_Spectator4.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator4.getActorRef())
elseif SLV_Rapist != SLV_Spectator5.getActorRef() && SLV_Watcher1.getActorRef() != SLV_Spectator5.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator5.getActorRef())
elseif SLV_Rapist != SLV_Spectator6.getActorRef() && SLV_Watcher1.getActorRef() != SLV_Spectator6.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator6.getActorRef())
endif

myScripts.SLV_DisplayInformation("Spectator1: " + SLV_Spectator1.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Spectator2: " + SLV_Spectator2.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Spectator3: " + SLV_Spectator3.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Spectator4: " + SLV_Spectator4.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Spectator5: " + SLV_Spectator5.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Spectator6: " + SLV_Spectator6.getActorRef().getActorBase().getName())

myScripts.SLV_DisplayInformation("Watcher1: " + SLV_Watcher1.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Watcher2: " + SLV_Watcher2.getActorRef().getActorBase().getName())

endFunction



function SLV_EnforcerGangbangRape(Actor[] sexActors)
; index 0 is player
SLV_Raper1.ForceRefTo(sexActors[1])

if sexActors.Length > 2
	SLV_Raper2.ForceRefTo(sexActors[2])
endif
if sexActors.Length > 3
	SLV_Raper3.ForceRefTo(sexActors[3])
endif
if sexActors.Length > 4
	SLV_Raper4.ForceRefTo(sexActors[4])
endif

if SLV_Raper1.getActorRef() != SLV_Spectator1.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator1.getActorRef()	&& SLV_Raper3.getActorRef() != SLV_Spectator1.getActorRef() && SLV_Raper4.getActorRef() != SLV_Spectator1.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator1.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator2.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator2.getActorRef()	&& SLV_Raper3.getActorRef() != SLV_Spectator2.getActorRef() && SLV_Raper4.getActorRef() != SLV_Spectator2.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator2.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator3.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator3.getActorRef()	&& SLV_Raper3.getActorRef() != SLV_Spectator3.getActorRef() && SLV_Raper4.getActorRef() != SLV_Spectator3.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator3.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator4.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator4.getActorRef()	&& SLV_Raper3.getActorRef() != SLV_Spectator4.getActorRef() && SLV_Raper4.getActorRef() != SLV_Spectator4.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator4.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator5.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator5.getActorRef()	&& SLV_Raper3.getActorRef() != SLV_Spectator5.getActorRef() && SLV_Raper4.getActorRef() != SLV_Spectator5.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator5.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator6.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator6.getActorRef()	&& SLV_Raper3.getActorRef() != SLV_Spectator6.getActorRef() && SLV_Raper4.getActorRef() != SLV_Spectator6.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator6.getActorRef())
endif

if SLV_Raper1.getActorRef() != SLV_Spectator1.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator1.getActorRef()	&& SLV_Raper3.getActorRef() != SLV_Spectator1.getActorRef() && SLV_Raper4.getActorRef() != SLV_Spectator1.getActorRef() && SLV_Watcher1.getActorRef() != SLV_Spectator1.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator1.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator2.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator2.getActorRef()	&& SLV_Raper3.getActorRef() != SLV_Spectator2.getActorRef() && SLV_Raper4.getActorRef() != SLV_Spectator2.getActorRef() && SLV_Watcher1.getActorRef() != SLV_Spectator2.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator2.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator3.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator3.getActorRef()	&& SLV_Raper3.getActorRef() != SLV_Spectator3.getActorRef() && SLV_Raper4.getActorRef() != SLV_Spectator3.getActorRef() && SLV_Watcher1.getActorRef() != SLV_Spectator3.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator3.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator4.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator4.getActorRef()	&& SLV_Raper3.getActorRef() != SLV_Spectator4.getActorRef() && SLV_Raper4.getActorRef() != SLV_Spectator4.getActorRef() && SLV_Watcher1.getActorRef() != SLV_Spectator4.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator4.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator5.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator5.getActorRef()	&& SLV_Raper3.getActorRef() != SLV_Spectator5.getActorRef() && SLV_Raper4.getActorRef() != SLV_Spectator5.getActorRef() && SLV_Watcher1.getActorRef() != SLV_Spectator5.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator5.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator6.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator6.getActorRef()	&& SLV_Raper3.getActorRef() != SLV_Spectator6.getActorRef() && SLV_Raper4.getActorRef() != SLV_Spectator6.getActorRef()&& SLV_Watcher1.getActorRef() != SLV_Spectator6.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator6.getActorRef())
endif

myScripts.SLV_DisplayInformation("Spectator1: " + SLV_Spectator1.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Spectator2: " + SLV_Spectator2.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Spectator3: " + SLV_Spectator3.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Spectator4: " + SLV_Spectator4.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Spectator5: " + SLV_Spectator5.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Spectator6: " + SLV_Spectator6.getActorRef().getActorBase().getName())

myScripts.SLV_DisplayInformation("Watcher1: " + SLV_Watcher1.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Watcher2: " + SLV_Watcher2.getActorRef().getActorBase().getName())

SLV_Watcher1.ForceRefTo(SLV_Spectator1.getActorRef())
SLV_Watcher2.ForceRefTo(SLV_Spectator2.getActorRef())

myScripts.SLV_PlayScene(SLV_GangbangScene)
EndFunction

SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_RapeAnimal1 Auto
ReferenceAlias Property SLV_Raper1 Auto
ReferenceAlias Property SLV_Raper2 Auto
ReferenceAlias Property SLV_Raper3 Auto
ReferenceAlias Property SLV_Raper4 Auto

ReferenceAlias Property SLV_Watcher1 Auto
ReferenceAlias Property SLV_Watcher2 Auto

ReferenceAlias Property SLV_Spectator1 Auto
ReferenceAlias Property SLV_Spectator2 Auto
ReferenceAlias Property SLV_Spectator3 Auto
ReferenceAlias Property SLV_Spectator4 Auto
ReferenceAlias Property SLV_Spectator5 Auto
ReferenceAlias Property SLV_Spectator6 Auto


Scene Property SLV_AnimalScene Auto
Scene Property SLV_GangbangScene Auto
Scene Property SLV_FreeScene Auto
Scene Property SLV_PunishFreeScene Auto
Scene Property SLV_NormalScene Auto
Scene Property SLV_DemonstrationScene Auto
Scene Property SLV_DemonstrationScene2 Auto
Scene Property SLV_DemonstrationScene3 Auto
Scene Property SLV_DemonstrationScene4 Auto

Scene Property SLV_SlaverRapeScene Auto

