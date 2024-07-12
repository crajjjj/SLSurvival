Scriptname RND_WerewolfFeed extends activemagiceffect  
{this script decreases Hunger when feeding}

GlobalVariable Property RND_HungerPoints Auto
GlobalVariable Property RND_HungerPointsPerHour Auto
GlobalVariable Property RND_HungerLastUpdateTimeStamp Auto

GlobalVariable Property RND_ThirstPoints Auto
GlobalVariable Property RND_ThirstPointsPerHour Auto
GlobalVariable Property RND_ThirstLastUpdateTimeStamp Auto

RND_PlayerScript Property RND_Player Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	Actor Player = Game.GetPlayer()
	
	if RND_Player.isVampire()
		RND_HungerPoints.SetValue(10)
		RND_ThirstPoints.SetValue(10)
		RemoveHungerSpells()
		RemoveThirstSpells()
	else
	
		RND_HungerPoints.SetValue(RND_HungerLevel01.GetValue())
		RND_HungerLastUpdateTimeStamp.SetValue(Utility.GetCurrentGameTime())
		
		RND_ThirstPoints.SetValue(RND_ThirstLevel00.GetValue())
		RND_ThirstLastUpdateTimeStamp.SetValue(Utility.GetCurrentGameTime())
		
		if !Player.HasSpell(RND_HungerSpell01)
			RemoveHungerSpells()
			Player.AddSpell(RND_HungerSpell01, false)
			
			if RND_1stPersonMsg.GetValue() == 1
				RND_HungerLevel01ConsumeMessage.Show()
			else
				RND_HungerLevel01ConsumeMessageB.Show()
			endif
		endif
		
		if !Player.HasSpell(RND_ThirstSpell00)			
			RemoveThirstSpells()
			Player.AddSpell(RND_ThirstSpell00, false)
		endif
		
	endIf

EndEvent

GlobalVariable Property RND_1stPersonMsg Auto

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

GlobalVariable Property RND_HungerLevel01 Auto
Message Property RND_HungerLevel01ConsumeMessage Auto
Message Property RND_HungerLevel01ConsumeMessageB Auto

Function RemoveThirstSpells()
	Actor Player = Game.GetPlayer()
	Player.RemoveSpell(RND_ThirstSpell00)
	Player.RemoveSpell(RND_ThirstSpell01)
	Player.RemoveSpell(RND_ThirstSpell02)
	Player.RemoveSpell(RND_ThirstSpell03)
	Player.RemoveSpell(RND_ThirstSpell04)
EndFunction

Spell Property RND_ThirstSpell00 Auto
Spell Property RND_ThirstSpell01 Auto
Spell Property RND_ThirstSpell02 Auto
Spell Property RND_ThirstSpell03 Auto
Spell Property RND_ThirstSpell04 Auto

GlobalVariable Property RND_ThirstLevel00 Auto

