Scriptname SLS_KennelFollowerDisable extends ReferenceAlias  

; Events inside kennel may cause conflicts with mods like devious followers. Disable followers temporarily.
; Eg removing DDs that the follower is enforcing equip on => increased debt

Function DisableFollower()
	Actor Follower = Self.GetReference() as Actor
	Debug.Notification(Follower.GetBaseObject().GetName() + ": Yeah. I'm not staying here. You go right ahead. I'll meet you later")
	;StorageUtil.FormListAdd(Game.GetPlayer(), "SLS_KennelFollowers", Follower, false)
	Follower.Disable()
EndFunction

Function EnableFollower()
	Actor Follower = Self.GetReference() as Actor
	Follower.Enable()
	;Debug.Notification(Follower.GetBaseObject().GetName() + ": Wow. You look like hell")
EndFunction
