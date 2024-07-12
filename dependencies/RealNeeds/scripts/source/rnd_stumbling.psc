Scriptname RND_Stumbling extends activemagiceffect  
{this script is for the stumbling sabrecat }

int Sec = 10

event OnEffectStart(Actor akTarget, Actor akCaster)
	Sec = Utility.RandomInt(10,20)
	RegisterForSingleUpdate(Sec)
endEvent

event OnUpdate()

	Actor Player = Game.GetPlayer()
	
	if RND_InebriationPoints.GetValue() >= RND_InebriationLevel04.GetValue() - 15
		RND_BlackoutSpell.Cast(Player, Player)
	else

		if Utility.RandomInt(1,100) <= RND_TrippingChance.GetValue() * 2		
			RND_StumbleSpell.Cast(Player, Player)
		endif
		
		if Player.IsRunning() && Utility.RandomInt(1,100) <= RND_TrippingChance.GetValue()
			Player.PushActorAway(Player, 0)
			Player.ApplyHavokImpulse(Player.GetAngleX(), Player.GetAngleY(), -0.3, 150)
		endif	
	endif
	
	Sec = Utility.RandomInt(10,20)
	RegisterForSingleUpdate(Sec)
	
endEvent

Spell Property RND_StumbleSpell Auto
Spell Property RND_BlackoutSpell Auto

GlobalVariable Property RND_TrippingChance Auto
GlobalVariable Property RND_InebriationPoints Auto
GlobalVariable Property RND_InebriationLevel04 Auto
