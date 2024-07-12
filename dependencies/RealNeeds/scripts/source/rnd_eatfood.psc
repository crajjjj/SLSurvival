Scriptname RND_EatFood extends activemagiceffect  
{this script decreases Hunger when eating}

GlobalVariable Property RND_HungerPoints Auto
GlobalVariable Property RND_HungerPointsPerHour Auto
GlobalVariable Property RND_HungerLastUpdateTimeStamp Auto

RND_PlayerScript Property RND_Player Auto
RND_HungerCountScript Property HungerScript Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	Actor Player = Game.GetPlayer()
	
	if RND_Player.isVampire()
		RND_HungerPoints.SetValue(10)
		RemoveHungerSpells()	
	else
		; eat food
		int AdjPoints = Utility.RandomInt(-5,5)
		float HungerPoints = RND_HungerPoints.GetValue()
		RND_HungerPoints.SetValue(RND_HungerPoints.GetValue() - RND_FoodPoints.GetValue() - AdjPoints)
		
		if RND_ForceSatiation.GetValue() == 1
			if HungerPoints >= RND_HungerLevel02.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel01.GetValue()
				RND_HungerPoints.SetValue(RND_HungerLevel01.GetValue())
			endif
		endif

		; Hunger points cap between 0-RND_HungerLevel05, 
		; so you don't end up eating a lot and still starving
		; or eating one huge meal hoping to last for a week
		if RND_HungerPoints.GetValue() > RND_HungerLevel05.GetValue()
			RND_HungerPoints.SetValue(RND_HungerLevel05.GetValue())
		elseif RND_HungerPoints.GetValue() < 0
			RND_HungerPoints.SetValue(0)
		endif
	
		; update time stamp
		RND_HungerLastUpdateTimeStamp.SetValue(Utility.GetCurrentGameTime())
	
		; new spell to add
		Spell HungerSpell = RND_HungerSpell02
		Message HungerLevelMessage = None
	
		if RND_HungerPoints.GetValue() < RND_HungerLevel01.GetValue()
			HungerSpell = RND_HungerSpell00
			if RND_1stPersonMsg.GetValue() == 1
				HungerLevelMessage = RND_HungerLevel00ConsumeMessage
			else
				HungerLevelMessage = RND_HungerLevel00ConsumeMessageB
			endif
	
		elseif RND_HungerPoints.GetValue() >= RND_HungerLevel01.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel02.GetValue()
			HungerSpell = RND_HungerSpell01
			if RND_1stPersonMsg.GetValue() == 1
				HungerLevelMessage = RND_HungerLevel01ConsumeMessage
			else
				HungerLevelMessage = RND_HungerLevel01ConsumeMessageB
			endif
	
		elseif RND_HungerPoints.GetValue() >= RND_HungerLevel02.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel03.GetValue()
			HungerSpell = RND_HungerSpell02
			if RND_1stPersonMsg.GetValue() == 1
				HungerLevelMessage = RND_HungerLevel02ConsumeMessage
			else
				HungerLevelMessage = RND_HungerLevel02ConsumeMessageB
			endif
	
		elseif RND_HungerPoints.GetValue() >= RND_HungerLevel03.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel04.GetValue()
			HungerSpell = RND_HungerSpell03
			if RND_1stPersonMsg.GetValue() == 1
				HungerLevelMessage = RND_HungerLevel03ConsumeMessage
			else
				HungerLevelMessage = RND_HungerLevel03ConsumeMessageB
			endif
	
		elseif RND_HungerPoints.GetValue() >= RND_HungerLevel04.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel05.GetValue()
			HungerSpell = RND_HungerSpell04
			if RND_1stPersonMsg.GetValue() == 1
				HungerLevelMessage = RND_HungerLevel04ConsumeMessage
			else
				HungerLevelMessage = RND_HungerLevel04ConsumeMessageB
			endif
	
		elseif RND_HungerPoints.GetValue() >= RND_HungerLevel05.GetValue()
			HungerSpell = RND_HungerSpell05
			if RND_1stPersonMsg.GetValue() == 1
				HungerLevelMessage = RND_HungerLevel05ConsumeMessage
			else
				HungerLevelMessage = RND_HungerLevel05ConsumeMessageB
			endif
	
		endif
	
		if Player.HasSpell(HungerSpell)
			HungerLevelMessage.Show()
		else
			RemoveHungerSpells()
			Player.AddSpell(HungerSpell, false)
			HungerLevelMessage.Show()
		endIf
		
	endIf
	
	if RND_AnimEat.GetValue() == 1
		if Player.GetAnimationVariableInt("i1stPerson") != 1 && !Player.GetAnimationVariableBool("bAnimationDriven")
		
			if Player.GetSitState () == 3
				;Player.PlayIdle(ChairEatingStart)
				Debug.sendAnimationEvent(player, "ChairEatingStart")
			else		
				Player.PlayIdle(idleEatingStandingStart)
			endif
			Utility.Wait(10)
			Player.PlayIdle(idleStop_Loose)
		endif
	endIf
	
	HungerScript.WidgetFade()

EndEvent

GlobalVariable Property RND_AnimEat Auto
GlobalVariable Property RND_1stPersonMsg Auto

Idle Property ChairEatingStart Auto
Idle Property idleEatingStandingStart Auto
Idle Property idleStop_Loose Auto

GlobalVariable Property RND_FoodPoints  Auto 
GlobalVariable Property RND_ForceSatiation Auto

Function RemoveHungerSpells()
	Actor PlayerRef = Game.GetPlayer()
	PlayerRef.RemoveSpell(RND_HungerSpell00)
	PlayerRef.RemoveSpell(RND_HungerSpell01)
	PlayerRef.RemoveSpell(RND_HungerSpell02)
	PlayerRef.RemoveSpell(RND_HungerSpell03)
	PlayerRef.RemoveSpell(RND_HungerSpell04)
	PlayerRef.RemoveSpell(RND_HungerSpell05)
EndFunction

Spell Property RND_HungerSpell00 Auto
Spell Property RND_HungerSpell01 Auto
Spell Property RND_HungerSpell02 Auto
Spell Property RND_HungerSpell03 Auto
Spell Property RND_HungerSpell04 Auto
Spell Property RND_HungerSpell05 Auto

GlobalVariable Property RND_HungerLevel00 Auto
GlobalVariable Property RND_HungerLevel01 Auto
GlobalVariable Property RND_HungerLevel02 Auto
GlobalVariable Property RND_HungerLevel03 Auto
GlobalVariable Property RND_HungerLevel04 Auto
GlobalVariable Property RND_HungerLevel05 Auto

Message Property RND_HungerLevel00ConsumeMessage Auto
Message Property RND_HungerLevel01ConsumeMessage Auto
Message Property RND_HungerLevel02ConsumeMessage Auto
Message Property RND_HungerLevel03ConsumeMessage Auto
Message Property RND_HungerLevel04ConsumeMessage Auto
Message Property RND_HungerLevel05ConsumeMessage Auto

Message Property RND_HungerLevel00ConsumeMessageB Auto
Message Property RND_HungerLevel01ConsumeMessageB Auto
Message Property RND_HungerLevel02ConsumeMessageB Auto
Message Property RND_HungerLevel03ConsumeMessageB Auto
Message Property RND_HungerLevel04ConsumeMessageB Auto
Message Property RND_HungerLevel05ConsumeMessageB Auto

