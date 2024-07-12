Scriptname SLV_SlaveGladiatorArenaTimer extends Quest  

Function StartArenaTimer()
RegisterForSingleUpdateGameTime(0.1) ; 6m
EndFunction 

Event OnUpdateGameTime()
;debug.notification("Arena Timer")

if  SLV_SlaveGladiatorQuest.getStage() == 1500
	debug.notification("Your enemy tries to throw you on the ground...")
	Utility.wait(5.0)

	Debug.notification("...and succeeded...the audience get freaked out as your opponent starts to rape you.")

	actor[] sexActors = new actor[2]
	sexActors[0] = Game.GetPlayer()
	sexActors[1] = Fighter1.getactorref()

	myScripts.SLV_Play2Sex(Game.GetPlayer(),Fighter1.getactorref(), "Anal", true)
endif
endEvent

SLV_Utilities Property myScripts auto
Quest Property SLV_SlaveGladiatorQuest Auto
ReferenceAlias Property Fighter1 Auto 
