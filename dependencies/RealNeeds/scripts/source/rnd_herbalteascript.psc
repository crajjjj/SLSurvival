Scriptname RND_HerbalTeaScript extends activemagiceffect  

GlobalVariable Property RND_InebriationPoints Auto
GlobalVariable Property RND_InebriationPointsPerHour Auto
GlobalVariable Property RND_InebriationLastUpdateTimeStamp Auto

Idle Property IdleDrunkStop Auto

RND_PlayerScript Property RND_Player Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Actor Player = Game.GetPlayer()
	
	if !RND_Player.isVampire()
	
		RND_InebriationPoints.SetValue(0)		
		RND_InebriationLastUpdateTimeStamp.SetValue(Utility.GetCurrentGameTime())
		if !Player.HasSpell(RND_InebriationSpell00)			
			RemoveInebriationSpells()
			Player.AddSpell(RND_InebriationSpell00, false)
		endif	
	endif
	
	bool loop = True
	int count = 0
	While loop == True
		if Player.PlayIdle(IdleDrunkStop)
			loop = False
		endif
		count += 1
		if count >= 5
			loop = False
		endif
		Utility.Wait(5)
	EndWhile
	
EndEvent

Function RemoveInebriationSpells()
	Actor PlayerRef = Game.GetPlayer()
	PlayerRef.RemoveSpell(RND_InebriationSpell00)
	PlayerRef.RemoveSpell(RND_InebriationSpell01)
	PlayerRef.RemoveSpell(RND_InebriationSpell02)
	PlayerRef.RemoveSpell(RND_InebriationSpell03)
EndFunction

Spell Property RND_InebriationSpell00 Auto
Spell Property RND_InebriationSpell01 Auto
Spell Property RND_InebriationSpell02 Auto
Spell Property RND_InebriationSpell03 Auto





