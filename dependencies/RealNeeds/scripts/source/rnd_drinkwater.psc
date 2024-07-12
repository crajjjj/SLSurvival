Scriptname RND_DrinkWater extends activemagiceffect  
{this script decreases Thirst when drinking}

GlobalVariable Property RND_ThirstPoints Auto
GlobalVariable Property RND_ThirstPointsPerHour Auto
GlobalVariable Property RND_ThirstLastUpdateTimeStamp Auto

GlobalVariable Property RND_WaterPoints  Auto

RND_PlayerScript Property RND_Player Auto
RND_ThirstCountScript Property ThirstScript Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Actor Player = Game.GetPlayer()
	
	if RND_Player.isVampire()
		RND_ThirstPoints.SetValue(10)
		RemoveThirstSpells()
	else
		; drink water
		int AdjPoints = Utility.RandomInt(-5,5)
		RND_ThirstPoints.SetValue(RND_ThirstPoints.GetValue() - RND_WaterPoints.GetValue() - AdjPoints)

		if RND_ThirstPoints.GetValue() > RND_ThirstLevel04.GetValue()
			RND_ThirstPoints.SetValue(RND_ThirstLevel04.GetValue())
		elseif RND_ThirstPoints.GetValue() < 0
			RND_ThirstPoints.SetValue(0)
		endif
	
		RND_ThirstLastUpdateTimeStamp.SetValue(Utility.GetCurrentGameTime())
	
		; new spell to add
		Spell ThirstSpell = RND_ThirstSpell02
		Message ThirstLevelMessage = None
	
		if RND_ThirstPoints.GetValue() < RND_ThirstLevel01.GetValue()
			ThirstSpell = RND_ThirstSpell00
			if RND_1stPersonMsg.GetValue() == 1
				ThirstLevelMessage = RND_ThirstLevel00ConsumeMessage
			else
				ThirstLevelMessage = RND_ThirstLevel00ConsumeMessageB
			endif
	
		elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel01.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel02.GetValue()
			ThirstSpell = RND_ThirstSpell01
			if RND_1stPersonMsg.GetValue() == 1
				ThirstLevelMessage = RND_ThirstLevel01ConsumeMessage
			else
				ThirstLevelMessage = RND_ThirstLevel01ConsumeMessageB
			endif
	
		elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel02.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel03.GetValue()
			ThirstSpell = RND_ThirstSpell02
			if RND_1stPersonMsg.GetValue() == 1
				ThirstLevelMessage = RND_ThirstLevel02ConsumeMessage
			else
				ThirstLevelMessage = RND_ThirstLevel02ConsumeMessageB
			endif
	
		elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel03.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel04.GetValue()
			ThirstSpell = RND_ThirstSpell03
			if RND_1stPersonMsg.GetValue() == 1
				ThirstLevelMessage = RND_ThirstLevel03ConsumeMessage
			else
				ThirstLevelMessage = RND_ThirstLevel03ConsumeMessageB
			endif
	
		elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel04.GetValue() 
			ThirstSpell = RND_ThirstSpell04
			if RND_1stPersonMsg.GetValue() == 1
				ThirstLevelMessage = RND_ThirstLevel04ConsumeMessage
			else
				ThirstLevelMessage = RND_ThirstLevel04ConsumeMessageB
			endif
	
		endif
	
		if Player.HasSpell(ThirstSpell)
			ThirstLevelMessage.Show()
		else
			RemoveThirstSpells()
			Player.AddSpell(ThirstSpell, false)
			ThirstLevelMessage.Show()
		endif
		
	endif
	
	if RND_AnimDrink.GetValue() == 1 && idleDrink
		if !Player.GetAnimationVariableInt("i1stPerson") == 1 && !Player.GetAnimationVariableBool("bAnimationDriven")
		
			if player.GetSitState () == 3
				Player.PlayIdle(ChairDrinkingStart)
				Utility.Wait(10)
				Player.PlayIdle(idleStop_Loose)
			else
				Player.PlayIdle(idleDrink)
			endif
		endif
	endif
	
	ThirstScript.WidgetFade()

EndEvent

GlobalVariable Property RND_AnimDrink Auto
GlobalVariable Property RND_1stPersonMsg Auto

Idle Property idleDrink Auto
Idle Property ChairDrinkingStart Auto
Idle Property idleBarDrinkingStart Auto
Idle Property idleStop_Loose Auto

Function RemoveThirstSpells()
	Actor PlayerRef = Game.GetPlayer()
	PlayerRef.RemoveSpell(RND_ThirstSpell00)
	PlayerRef.RemoveSpell(RND_ThirstSpell01)
	PlayerRef.RemoveSpell(RND_ThirstSpell02)
	PlayerRef.RemoveSpell(RND_ThirstSpell03)
	PlayerRef.RemoveSpell(RND_ThirstSpell04)
EndFunction

Spell Property RND_ThirstSpell00 Auto
Spell Property RND_ThirstSpell01 Auto
Spell Property RND_ThirstSpell02 Auto
Spell Property RND_ThirstSpell03 Auto
Spell Property RND_ThirstSpell04 Auto

GlobalVariable Property RND_ThirstLevel00 Auto
GlobalVariable Property RND_ThirstLevel01 Auto
GlobalVariable Property RND_ThirstLevel02 Auto
GlobalVariable Property RND_ThirstLevel03 Auto
GlobalVariable Property RND_ThirstLevel04 Auto

Message Property RND_ThirstLevel00ConsumeMessage Auto
Message Property RND_ThirstLevel01ConsumeMessage Auto
Message Property RND_ThirstLevel02ConsumeMessage Auto
Message Property RND_ThirstLevel03ConsumeMessage Auto
Message Property RND_ThirstLevel04ConsumeMessage Auto

Message Property RND_ThirstLevel00ConsumeMessageB Auto
Message Property RND_ThirstLevel01ConsumeMessageB Auto
Message Property RND_ThirstLevel02ConsumeMessageB Auto
Message Property RND_ThirstLevel03ConsumeMessageB Auto
Message Property RND_ThirstLevel04ConsumeMessageB Auto

