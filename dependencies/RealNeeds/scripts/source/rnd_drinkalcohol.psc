Scriptname RND_DrinkAlcohol extends activemagiceffect  
{this script increases Inebriation when drinking}

GlobalVariable Property RND_InebriationPoints Auto
GlobalVariable Property RND_InebriationPointsPerHour Auto
GlobalVariable Property RND_InebriationLastUpdateTimeStamp Auto

RND_PlayerScript Property RND_Player Auto
RND_InebriationCountScript Property InebriationScript Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Actor Player = Game.GetPlayer()
		
	if RND_Player.isVampire()
		RND_InebriationPoints.SetValue(10)
		RemoveInebriationSpells()
	else
		; drink Alcohol
		int AdjPoints = Utility.RandomInt(-5,5)
		RND_InebriationPoints.SetValue(RND_InebriationPoints.GetValue() + RND_AlcoholPoints.GetValue() + AdjPoints)

		; Inebriation points cap between 0-RND_InebriationLevel04, 
		if RND_InebriationPoints.GetValue() > RND_InebriationLevel04.GetValue()
			RND_InebriationPoints.SetValue(RND_InebriationLevel04.GetValue())
		elseif RND_InebriationPoints.GetValue() < 0
			RND_InebriationPoints.SetValue(0)
		endif
	
		; update time stamp
		RND_InebriationLastUpdateTimeStamp.SetValue(Utility.GetCurrentGameTime())
	
		; new spell to add
		Spell InebriationSpell = RND_InebriationSpell00
	
		if RND_InebriationPoints.GetValue() < RND_InebriationLevel01.GetValue()
			InebriationSpell = RND_InebriationSpell00
	
		elseif RND_InebriationPoints.GetValue() >= RND_InebriationLevel01.GetValue() && RND_InebriationPoints.GetValue() < RND_InebriationLevel02.GetValue()
			InebriationSpell = RND_InebriationSpell01
	
		elseif RND_InebriationPoints.GetValue() >= RND_InebriationLevel02.GetValue() && RND_InebriationPoints.GetValue() < RND_InebriationLevel03.GetValue()
			InebriationSpell = RND_InebriationSpell02
	
		elseif RND_InebriationPoints.GetValue() >= RND_InebriationLevel03.GetValue()
			InebriationSpell = RND_InebriationSpell03
	
		endif
	
		if !Player.HasSpell(InebriationSpell)
			RemoveInebriationSpells()
			Player.AddSpell(InebriationSpell, false)
		endif
		
	endif
	
	if RND_AnimDrink.GetValue() == 1
		if Player.GetAnimationVariableInt("i1stPerson") != 1 && !Player.GetAnimationVariableBool("bAnimationDriven")	
			if player.GetSitState () == 3
				Player.PlayIdle(ChairDrinkingStart)
				Utility.Wait(10)
				Player.PlayIdle(idleStop_Loose)
			else
				Player.PlayIdle(idleDrink)
			endif
		endif
	endif
	
	InebriationScript.WidgetFade()

EndEvent

GlobalVariable Property RND_AnimDrink Auto

Idle Property idleDrink Auto
Idle Property ChairDrinkingStart Auto
Idle Property idleBarDrinkingStart Auto
Idle Property idleStop_Loose Auto

GlobalVariable Property RND_AlcoholPoints  Auto

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

GlobalVariable Property RND_InebriationLevel00 Auto
GlobalVariable Property RND_InebriationLevel01 Auto
GlobalVariable Property RND_InebriationLevel02 Auto
GlobalVariable Property RND_InebriationLevel03 Auto
GlobalVariable Property RND_InebriationLevel04 Auto

