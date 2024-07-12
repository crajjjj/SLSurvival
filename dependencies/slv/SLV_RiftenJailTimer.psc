Scriptname SLV_RiftenJailTimer extends Quest  

Function StartProgressRiftenSlave()
if !Game.GetPlayer().IsInFaction(zbf_Slave)
	return
endif

RegisterForSingleUpdateGameTime(24.0) 
EndFunction 

Event OnUpdateGameTime()
if !Game.GetPlayer().IsInFaction(zbf_Slave)
	return
endif

if RiftenJailRape.getStage() >= 5000
	return
endif

if RiftenJailRape.getStage() >= 2500
	RiftenJailRape.setStage(5000)
	setNextTimer("4th")

	ActorUtil.AddPackageOverride(Maul.GetActorRef(), FollowPlayer ,100)
	Maul.GetActorRef().evaluatePackage()

	Maul.GetActorRef().moveto(newMarker)

	CellDoor.Lock(false)

	return
endif
if RiftenJailRape.getStage() >= 3500
	RiftenJailRape.setStage(4000)
	setNextTimer("3th")
	return
endif
if RiftenJailRape.getStage() >= 2500
	RiftenJailRape.setStage(3000)
	setNextTimer("2nd")
	return
endif
if RiftenJailRape.getStage() >= 1500
	RiftenJailRape.setStage(2000)
	setNextTimer("1st")
	return
endif	
setNextTimer("")
endEvent

function setNextTimer(String day)
if day !=""
	Debug.MessageBox("Your " + day + " day in Riften prison ended.")
endif
RegisterForSingleUpdateGameTime(24.0 )
EndFunction

Faction Property zbf_Slave Auto
SLV_RiftenJailRape Property RiftenJailRape Auto
ObjectReference Property newMarker Auto
ReferenceAlias Property Maul Auto 
Package Property FollowPlayer Auto
ObjectReference Property CellDoor  Auto  