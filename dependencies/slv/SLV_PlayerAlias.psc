Scriptname SLV_PlayerAlias extends ReferenceAlias  

{ensures Slaverun will be registered for the events after each game load}

Event OnPlayerLoadGame()
	events.PrepareMod()
	swapJarls.updateAllJarls()
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
Utility.wait(3.0)
amputee.SLV_OnLoadGameIvanaAmputee()
endEvent

SLV_SwapAllJarls  Property swapJarls Auto
SLV_EventHandler Property events Auto

SLV_Amputee Property amputee Auto

