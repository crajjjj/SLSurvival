Scriptname RND_LoadGame extends ReferenceAlias  

Spell Property RND_Maintenance Auto

Event OnPlayerLoadGame()
	RND_Maintenance.Cast(Game.GetPlayer(), Game.GetPlayer())
EndEvent

