Scriptname SLV_FindFightersScript extends Quest  

ReferenceAlias Property Fighter1  Auto  
ReferenceAlias Property Fighter2  Auto

Actor [] Property fighters Auto hidden

int function getFighters()
	;MiscUtil.PrintConsole("Start getting new fighters")

	gotostate("busy")
	start()
	;MiscUtil.PrintConsole("Started")
	Utility.wait(0.3)
	int actorCount = 0
	if(!fighters )
		fighters = new Actor[2]
	endif
	
	;MiscUtil.PrintConsole("Find Fighter1 has first ref = " + Fighter1.getReference())
	Actor a1 = Fighter1.getActorRef()
	if(a1)
		fighters[actorCount] = a1
		actorCount = actorCount + 1
		;MiscUtil.PrintConsole("Actor 1 has a value")
	endif
	a1 = Fighter2.getActorRef()
	if(a1)
		fighters[actorCount] = a1
		actorCount = actorCount + 1
		;MiscUtil.PrintConsole("Actor 2 has a value")
	endif

	;MiscUtil.PrintConsole("vor stop")
	stop()
	;MiscUtil.PrintConsole("Stopped")
	reset()

	;MiscUtil.PrintConsole("Found " + actorCount + " fighters ")
	gotostate("")
	return actorCount;
endFunction

state busy
int function getFighters()
	return -1
endFunction
endState
