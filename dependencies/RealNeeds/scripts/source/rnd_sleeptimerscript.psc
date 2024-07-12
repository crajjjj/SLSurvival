Scriptname RND_SleepTimerScript extends ActiveMagicEffect  
{this script increases Sleep points over time}

GlobalVariable Property RND_SleepPoints Auto
GlobalVariable Property RND_SleepPointsPerHour Auto
GlobalVariable Property RND_SleepLastUpdateTimeStamp Auto

RND_PlayerScript Property RND_Player Auto
GlobalVariable Property RND_FastTravelSlowRate Auto
RND_SleepCountScript Property SleepScript Auto ;remove this on the next major update when not seriously playing!!!

Event OnEffectStart(Actor akTarget, Actor akCaster)
	; start the timer
	RegisterForSingleUpdateGameTime(1)
	RND_SleepLastUpdateTimeStamp.SetValue(Utility.GetCurrentGameTime())
	RND_Player.SleepLastUpdateLocation = Game.GetPlayer().GetCurrentLocation()
EndEvent


Event OnUpdateGameTime()
	
	; calculate number of hours passed since last update
	; and add Sleep points
	float NumOfHours = (Utility.GetCurrentGameTime() - RND_SleepLastUpdateTimeStamp.GetValue()) * 24
	float DiseaseFatiguePoints = RND_Player.getDisFatigue() * NumOfHours
	float SleepPoints = RND_SleepPointsPerHour.GetValue() * NumOfHours + DiseaseFatiguePoints
	
	if NumOfHours >= 3
		if RND_Player.SleepLastUpdateLocation != Game.GetPlayer().GetCurrentLocation()
			SleepPoints = SleepPoints * (100 - RND_FastTravelSlowRate.GetValue()) / 100
		endif
	endif
	
	RND_SleepPoints.SetValue(RND_SleepPoints.GetValue() + SleepPoints)
	
	; Sleep points cap between 0-RND_SleepLevel03, 
	If RND_SleepPoints.GetValue() > RND_SleepLevel04.GetValue()
		RND_SleepPoints.SetValue(RND_SleepLevel04.GetValue())
	EndIf
	
	If RND_SleepPoints.GetValue() < 0
		RND_SleepPoints.SetValue(0)
	EndIf
	
	; update time stamp
	RND_SleepLastUpdateTimeStamp.SetValue(Utility.GetCurrentGameTime())
	RND_Player.SleepLastUpdateLocation = Game.GetPlayer().GetCurrentLocation()
	
	; new spell to add
	Spell SleepSpell
	Message SleepLevelMessage
	
	if RND_SleepPoints.GetValue() < RND_SleepLevel01.GetValue()
		SleepSpell = RND_SleepSpell00
		if RND_1stPersonMsg.GetValue() == 1
			SleepLevelMessage = RND_SleepLevel00TimerMessage
		else
			SleepLevelMessage = RND_SleepLevel00TimerMessageB
		endif
	
	elseif RND_SleepPoints.GetValue() >= RND_SleepLevel01.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel02.GetValue()
		SleepSpell = RND_SleepSpell01
		if RND_1stPersonMsg.GetValue() == 1
			SleepLevelMessage = RND_SleepLevel01TimerMessage
		else
			SleepLevelMessage = RND_SleepLevel01TimerMessageB
		endif
	
	elseif RND_SleepPoints.GetValue() >= RND_SleepLevel02.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel03.GetValue()
		SleepSpell = RND_SleepSpell02
		if RND_1stPersonMsg.GetValue() == 1
			SleepLevelMessage = RND_SleepLevel02TimerMessage
		else
			SleepLevelMessage = RND_SleepLevel02TimerMessageB
		endif
	
	elseif RND_SleepPoints.GetValue() >= RND_SleepLevel03.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel04.GetValue()
		SleepSpell = RND_SleepSpell03
		if RND_1stPersonMsg.GetValue() == 1
			SleepLevelMessage = RND_SleepLevel03TimerMessage
		else
			SleepLevelMessage = RND_SleepLevel03TimerMessageB
		endif
	
	elseif RND_SleepPoints.GetValue() >= RND_SleepLevel04.GetValue()
		SleepSpell = RND_SleepSpell04
		if RND_1stPersonMsg.GetValue() == 1
			SleepLevelMessage = RND_SleepLevel04TimerMessage
		else
			SleepLevelMessage = RND_SleepLevel04TimerMessageB
		endif
	
	endif
	
	Actor PlayerRef = Game.GetPlayer()
	
	if (RND_SleepPoints.GetValue() < RND_SleepLevel01.GetValue()) && \
		(PlayerRef.HasSpell(RND_MarriageRested) || PlayerRef.HasSpell(RND_WellRested) ||\
		PlayerRef.HasSpell(RND_Rested) || PlayerRef.HasSpell(RND_RestlessBeast) || PlayerRef.HasSpell(RND_SleepSpell00))
			
		RegisterForSingleUpdateGameTime(1)
		
	elseif PlayerRef.HasSpell(SleepSpell)
		; Sleep level doesn't change
		RegisterForSingleUpdateGameTime(1)
	
	else
		RemoveSleepSpells()
		PlayerRef.AddSpell(SleepSpell, False)
		SleepLevelMessage.Show()
	endif
		
EndEvent

GlobalVariable Property RND_1stPersonMsg Auto

Function RemoveSleepSpells()
	Actor PlayerRef = Game.GetPlayer()
	PlayerRef.RemoveSpell(RND_SleepSpell00)
	PlayerRef.RemoveSpell(RND_SleepSpell01)
	PlayerRef.RemoveSpell(RND_SleepSpell02)
	PlayerRef.RemoveSpell(RND_SleepSpell03)
	PlayerRef.RemoveSpell(RND_SleepSpell04)
	PlayerRef.RemoveSpell(RND_Rested)
	PlayerRef.RemoveSpell(RND_WellRested)
	PlayerRef.RemoveSpell(RND_MarriageRested)
	PlayerRef.RemoveSpell(RND_RestlessBeast)
EndFunction

Spell Property RND_Rested Auto
Spell Property RND_RestlessBeast Auto
Spell Property RND_WellRested Auto
Spell Property RND_MarriageRested Auto

Spell Property RND_SleepSpell00 Auto
Spell Property RND_SleepSpell01 Auto
Spell Property RND_SleepSpell02 Auto
Spell Property RND_SleepSpell03 Auto
Spell Property RND_SleepSpell04 Auto

GlobalVariable Property RND_SleepLevel00 Auto
GlobalVariable Property RND_SleepLevel01 Auto
GlobalVariable Property RND_SleepLevel02 Auto
GlobalVariable Property RND_SleepLevel03 Auto
GlobalVariable Property RND_SleepLevel04 Auto

Message Property RND_SleepLevel00TimerMessage Auto
Message Property RND_SleepLevel01TimerMessage Auto
Message Property RND_SleepLevel02TimerMessage Auto
Message Property RND_SleepLevel03TimerMessage Auto
Message Property RND_SleepLevel04TimerMessage Auto

Message Property RND_SleepLevel00TimerMessageB Auto
Message Property RND_SleepLevel01TimerMessageB Auto
Message Property RND_SleepLevel02TimerMessageB Auto
Message Property RND_SleepLevel03TimerMessageB Auto
Message Property RND_SleepLevel04TimerMessageB Auto
