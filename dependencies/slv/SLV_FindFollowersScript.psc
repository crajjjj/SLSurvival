Scriptname SLV_FindFollowersScript extends Quest  

ReferenceAlias Property Follower1  Auto  
ReferenceAlias Property Follower2  Auto
ReferenceAlias Property Follower3  Auto  
ReferenceAlias Property Follower4  Auto  
ReferenceAlias Property Follower5  Auto  

Actor [] Property followers Auto hidden

int function getFollowers()
	;MiscUtil.PrintConsole("Start getting new followers")

	gotostate("busy")
	start()
	;MiscUtil.PrintConsole("Started")
	Utility.wait(0.3)
	int actorCount = 0
	if(!followers)
		followers = new Actor[5]
	endif
	
	;MiscUtil.PrintConsole("Find Followers has first ref = " + Follower1.getReference())
	Actor a1 = Follower1.getActorRef()
	if(a1)
		followers[actorCount] = a1
		actorCount = actorCount + 1
		;MiscUtil.PrintConsole("Actor 1 has a value")
	endif
	a1 = Follower2.getActorRef()
	if(a1)
		followers[actorCount] = a1
		actorCount = actorCount + 1
		;MiscUtil.PrintConsole("Actor 2 has a value")
	endif
	a1 = Follower3.getActorRef()
	if(a1)
		followers[actorCount] = a1
		actorCount = actorCount + 1
		;MiscUtil.PrintConsole("Actor 3 has a value")
	endif
	a1 = Follower4.getActorRef()
	if(a1)
		followers[actorCount] = a1
		actorCount = actorCount + 1
		;MiscUtil.PrintConsole("Actor 4 has a value")
	endif
	a1 = Follower5.getActorRef()
	if(a1)
		followers[actorCount] = a1
		actorCount = actorCount + 1
		;MiscUtil.PrintConsole("Actor 5 has a value")
	endif

	;MiscUtil.PrintConsole("vor stop")
	stop()
	;MiscUtil.PrintConsole("Stopped")
	reset()

	;MiscUtil.PrintConsole("Found " + actorCount + " followers")
	gotostate("")
	return actorCount;
endFunction

state busy
int function getFollowers()
	return -1
endFunction
endState

