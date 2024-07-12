Scriptname xPlayFurnitureOpenClose extends ObjectReference  

Import MiscUtil
import utility

event OnActivate(ObjectReference npc)
	Actor user = npc as Actor
	if user
		int sstate = user.GetSitState()
		if sstate >= 2 && sstate <= 3
			bool started=self.PlayGamebryoAnimation("close", true, 3.0)
			MiscUtil.PrintConsole("Closing?"+ (started as String))
		else
			bool started=self.PlayGamebryoAnimation("open", true, 1.0)
			MiscUtil.PrintConsole("Opening?"+ (started as String))
		endif
	endif		
endevent