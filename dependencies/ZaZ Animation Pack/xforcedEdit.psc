Scriptname xForcedEdit extends ObjectReference  

int Property exitDistance = 64  Auto
float Property exitAngle = 0.0 Auto

event OnActivate(ObjectReference npc)
	Actor user = npc as Actor
	if user
		int sstate = user.GetSitState()
		if sstate != 2 && sstate != 3
			float angle = user.GetAngleZ()
			angle +=exitAngle
			float xoffset = exitDistance * math.sin(angle)
			float yoffset = exitDistance * math.cos(angle)
			user.SetPosition(user.GetPositionX() + xoffset, user.GetPositionY() + yoffset, user.GetPositionZ())
		endif
	endif		
endevent
