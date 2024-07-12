Scriptname RND_ThirstTimerScript extends activemagiceffect  
{this script increases Thirst points over time}

GlobalVariable Property RND_ThirstPoints Auto
GlobalVariable Property RND_ThirstPointsPerHour Auto
GlobalVariable Property RND_ThirstLastUpdateTimeStamp Auto

RND_PlayerScript Property RND_Player Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForSingleUpdateGameTime(1)
	RND_ThirstLastUpdateTimeStamp.SetValue(Utility.GetCurrentGameTime())
EndEvent

Event OnUpdateGameTime()

	if RND_Player.isVampire()
		RND_ThirstPoints.SetValue(10)
		RemoveThirstSpells()
		Return
	endif
	
	; calculate number of hours passed since last update
	; and add Thirst points
	float NumOfHours = (Utility.GetCurrentGameTime() - RND_ThirstLastUpdateTimeStamp.GetValue()) * 24
	RND_ThirstPoints.SetValue(RND_ThirstPoints.GetValue() + (RND_ThirstPointsPerHour.GetValue() * NumOfHours))
	
	; Thirst points cap between 0-RND_ThirstLevel04, 
	; so you don't end up eating a lot and still thirsty
	; or eating one huge meal hoping to last for a week
	if RND_ThirstPoints.GetValue() > RND_ThirstLevel04.GetValue()
		RND_ThirstPoints.SetValue(RND_ThirstLevel04.GetValue())
	elseif RND_ThirstPoints.GetValue() < 0
		RND_ThirstPoints.SetValue(0)
	endif

	RND_ThirstLastUpdateTimeStamp.SetValue(Utility.GetCurrentGameTime())
	
	; new spell to add
	Spell ThirstSpell
	Message ThirstLevelMessage
	
	if RND_ThirstPoints.GetValue() < RND_ThirstLevel01.GetValue()
		ThirstSpell = RND_ThirstSpell00
		if RND_1stPersonMsg.GetValue() == 1
			ThirstLevelMessage = RND_ThirstLevel00TimerMessage
		else
			ThirstLevelMessage = RND_ThirstLevel00TimerMessageB
		endif
	
	elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel01.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel02.GetValue()
		ThirstSpell = RND_ThirstSpell01
		if RND_1stPersonMsg.GetValue() == 1
			ThirstLevelMessage = RND_ThirstLevel01TimerMessage
		else
			ThirstLevelMessage = RND_ThirstLevel01TimerMessageB
		endif
	
	elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel02.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel03.GetValue()
		ThirstSpell = RND_ThirstSpell02
		if RND_1stPersonMsg.GetValue() == 1
			ThirstLevelMessage = RND_ThirstLevel02TimerMessage
		else
			ThirstLevelMessage = RND_ThirstLevel02TimerMessageB
		endif
	
	elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel03.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel04.GetValue()
		ThirstSpell = RND_ThirstSpell03
		if RND_1stPersonMsg.GetValue() == 1
			ThirstLevelMessage = RND_ThirstLevel03TimerMessage
		else
			ThirstLevelMessage = RND_ThirstLevel03TimerMessageB
		endif
	
	elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel04.GetValue()
		ThirstSpell = RND_ThirstSpell04
		if RND_1stPersonMsg.GetValue() == 1
			ThirstLevelMessage = RND_ThirstLevel04TimerMessage
		else
			ThirstLevelMessage = RND_ThirstLevel04TimerMessageB
		endif
	
	endif
	
	if Game.GetPlayer().HasSpell(ThirstSpell)
		RegisterForSingleUpdateGameTime(1)
	else
		RemoveThirstSpells()
		Game.GetPlayer().AddSpell(ThirstSpell, false)
		ThirstLevelMessage.Show()
	endif

EndEvent

GlobalVariable Property RND_1stPersonMsg Auto

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

Message Property RND_ThirstLevel00TimerMessage Auto
Message Property RND_ThirstLevel01TimerMessage Auto
Message Property RND_ThirstLevel02TimerMessage Auto
Message Property RND_ThirstLevel03TimerMessage Auto
Message Property RND_ThirstLevel04TimerMessage Auto

Message Property RND_ThirstLevel00TimerMessageB Auto
Message Property RND_ThirstLevel01TimerMessageB Auto
Message Property RND_ThirstLevel02TimerMessageB Auto
Message Property RND_ThirstLevel03TimerMessageB Auto
Message Property RND_ThirstLevel04TimerMessageB Auto
