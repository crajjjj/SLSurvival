Scriptname SLV_SlaveHunterHelper extends Quest  


function SLV_FillWatcherRefs()
SLV_Spectator1 = spectators.Alias_Spectator1
SLV_Spectator2 = spectators.Alias_Spectator2
SLV_Spectator3 = spectators.Alias_Spectator3
SLV_Spectator4 = spectators.Alias_Spectator4
SLV_Spectator5 = spectators.Alias_Spectator5
SLV_Spectator6 = spectators.Alias_Spectator6

SLV_Spectator1.ForceRefTo(spectators.Alias_Spectator1.getActorRef())
SLV_Spectator2.ForceRefTo(spectators.Alias_Spectator2.getActorRef())
SLV_Spectator3.ForceRefTo(spectators.Alias_Spectator3.getActorRef())
SLV_Spectator4.ForceRefTo(spectators.Alias_Spectator4.getActorRef())
SLV_Spectator5.ForceRefTo(spectators.Alias_Spectator5.getActorRef())
SLV_Spectator6.ForceRefTo(spectators.Alias_Spectator6.getActorRef())

SLV_Raper1 = slaveHunter.Alias_SLV_BountyHunter1
SLV_Raper2 = slaveHunter.Alias_SLV_BountyHunter2
SLV_Watcher1 = slaveHunter.Alias_SLV_Watcher1
SLV_Watcher2 = slaveHunter.Alias_SLV_Watcher2

if SLV_Raper1.getActorRef() != SLV_Spectator1.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator1.getActorRef()	
	SLV_Watcher1.ForceRefTo(SLV_Spectator1.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator2.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator2.getActorRef()	
	SLV_Watcher1.ForceRefTo(SLV_Spectator2.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator3.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator3.getActorRef()	
	SLV_Watcher1.ForceRefTo(SLV_Spectator3.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator4.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator4.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator4.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator5.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator5.getActorRef()	
	SLV_Watcher1.ForceRefTo(SLV_Spectator5.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator6.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator6.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator6.getActorRef())
endif

if SLV_Raper1.getActorRef() != SLV_Spectator1.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator1.getActorRef()	&& SLV_Watcher1.getActorRef() != SLV_Spectator1.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator1.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator2.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator2.getActorRef()	&& SLV_Watcher1.getActorRef() != SLV_Spectator2.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator2.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator3.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator3.getActorRef()	&& SLV_Watcher1.getActorRef() != SLV_Spectator3.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator3.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator4.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator4.getActorRef()	&& SLV_Watcher1.getActorRef() != SLV_Spectator4.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator4.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator5.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator5.getActorRef()	&& SLV_Watcher1.getActorRef() != SLV_Spectator5.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator5.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator6.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator6.getActorRef()	&& SLV_Watcher1.getActorRef() != SLV_Spectator6.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator6.getActorRef())
endif

MiscUtil.PrintConsole("Spectator1: " + SLV_Spectator1)
MiscUtil.PrintConsole("Spectator1: " + SLV_Spectator1.getActorRef())
MiscUtil.PrintConsole("Spectator1: " + SLV_Spectator1.getActorRef().getActorBase())
MiscUtil.PrintConsole("Spectator1: " + SLV_Spectator1.getActorRef().getActorBase().getName())

MiscUtil.PrintConsole("Spectator1: " + SLV_Spectator1.getActorRef().getActorBase().getName())
MiscUtil.PrintConsole("Spectator2: " + SLV_Spectator2.getActorRef().getActorBase().getName())
MiscUtil.PrintConsole("Spectator3: " + SLV_Spectator3.getActorRef().getActorBase().getName())
MiscUtil.PrintConsole("Spectator4: " + SLV_Spectator4.getActorRef().getActorBase().getName())
MiscUtil.PrintConsole("Spectator5: " + SLV_Spectator5.getActorRef().getActorBase().getName())
MiscUtil.PrintConsole("Spectator6: " + SLV_Spectator6.getActorRef().getActorBase().getName())

MiscUtil.PrintConsole("Watcher1: " + SLV_Watcher1.getActorRef().getActorBase().getName())
MiscUtil.PrintConsole("Watcher2: " + SLV_Watcher2.getActorRef().getActorBase().getName())

SLV_Watcher1.ForceRefTo(SLV_Spectator1.getActorRef())
SLV_Watcher2.ForceRefTo(SLV_Spectator2.getActorRef())
EndFunction

SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Raper1 Auto
ReferenceAlias Property SLV_Raper2 Auto

ReferenceAlias Property SLV_Watcher1 Auto
ReferenceAlias Property SLV_Watcher2 Auto

ReferenceAlias Property SLV_Spectator1 Auto
ReferenceAlias Property SLV_Spectator2 Auto
ReferenceAlias Property SLV_Spectator3 Auto
ReferenceAlias Property SLV_Spectator4 Auto
ReferenceAlias Property SLV_Spectator5 Auto
ReferenceAlias Property SLV_Spectator6 Auto

SLV_FindSpecators Property spectators auto
SLV_SlaveHunter Property slaveHunter auto




