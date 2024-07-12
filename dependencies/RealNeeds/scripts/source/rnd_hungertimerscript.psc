Scriptname RND_HungerTimerScript extends activemagiceffect  
{this script increases Hunger points over time}

Actor Property PlayerREF Auto

GlobalVariable Property RND_HungerPoints Auto
GlobalVariable Property RND_HungerPointsPerHour Auto
GlobalVariable Property RND_HungerLastUpdateTimeStamp Auto
GlobalVariable Property RND_HoursThresholdGlobal Auto
GlobalVariable Property RND_DisableWeightGlobal Auto

RND_PlayerScript Property RND_Player Auto
GlobalVariable Property RND_DefaultWeightGlobal Auto
GlobalVariable Property RND_CurrentWeightGlobal Auto
Float weight

Event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForSingleUpdateGameTime(1)
	RND_HungerLastUpdateTimeStamp.SetValue(Utility.GetCurrentGameTime())
EndEvent

Event OnUpdateGameTime()

	if RND_Player.isVampire()
		RND_HungerPoints.SetValue(10)
		RemoveHungerSpells()
		Return
	endif
	
	; calculate number of hours passed since last update
	; and add Hunger points
	float NumOfHours = (Utility.GetCurrentGameTime() - RND_HungerLastUpdateTimeStamp.GetValue()) * 24
	RND_HungerPoints.SetValue(RND_HungerPoints.GetValue() + (RND_HungerPointsPerHour.GetValue() * NumOfHours))
	
	; Hunger points cap between 0-RND_HungerLevel05, 
	; so you don't end up eating a lot and still starving
	; or eating one huge meal hoping to last for a week
	if RND_HungerPoints.GetValue() > RND_HungerLevel05.GetValue()
		RND_HungerPoints.SetValue(RND_HungerLevel05.GetValue())
	elseif RND_HungerPoints.GetValue() < 0
		RND_HungerPoints.SetValue(0)
	endif
	
	RND_HungerLastUpdateTimeStamp.SetValue(Utility.GetCurrentGameTime())
	
	; new spell to add
	Spell HungerSpell
	Message HungerLevelMessage
	
	if RND_HungerPoints.GetValue() < RND_HungerLevel01.GetValue()
		HungerSpell = RND_HungerSpell00
		if RND_1stPersonMsg.GetValue() == 1
			HungerLevelMessage = RND_HungerLevel00TimerMessage
		else
			HungerLevelMessage = RND_HungerLevel00TimerMessageB
		endif
	
	elseif RND_HungerPoints.GetValue() >= RND_HungerLevel01.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel02.GetValue()
		HungerSpell = RND_HungerSpell01
		if RND_1stPersonMsg.GetValue() == 1
			HungerLevelMessage = RND_HungerLevel01TimerMessage
		else
			HungerLevelMessage = RND_HungerLevel01TimerMessageB
		endif
	
	elseif RND_HungerPoints.GetValue() >= RND_HungerLevel02.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel03.GetValue()
		HungerSpell = RND_HungerSpell02
		if RND_1stPersonMsg.GetValue() == 1
			HungerLevelMessage = RND_HungerLevel02TimerMessage
		else
			HungerLevelMessage = RND_HungerLevel02TimerMessageB
		endif
	
	elseif RND_HungerPoints.GetValue() >= RND_HungerLevel03.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel04.GetValue()
		HungerSpell = RND_HungerSpell03
		if RND_1stPersonMsg.GetValue() == 1
			HungerLevelMessage = RND_HungerLevel03TimerMessage
		else
			HungerLevelMessage = RND_HungerLevel03TimerMessageB
		endif
	
	elseif RND_HungerPoints.GetValue() >= RND_HungerLevel04.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel05.GetValue()
		HungerSpell = RND_HungerSpell04
		if RND_1stPersonMsg.GetValue() == 1
			HungerLevelMessage = RND_HungerLevel04TimerMessage
		else
			HungerLevelMessage = RND_HungerLevel04TimerMessageB
		endif
	
	elseif RND_HungerPoints.GetValue() >= RND_HungerLevel05.GetValue()
		HungerSpell = RND_HungerSpell05
		if RND_1stPersonMsg.GetValue() == 1
			HungerLevelMessage = RND_HungerLevel05TimerMessage
		else
			HungerLevelMessage = RND_HungerLevel05TimerMessageB
		endif
	
	endif
	
	If RND_DisableWeightGlobal.GetValueInt() == 1
	
		Float HoursThreshold = RND_HoursThresholdGlobal.GetValue() as Float
		weight = PlayerREF.GetActorBase().GetWeight() as float
		float newWeight
		
		If weight <= 100.0 && weight >= 0.0
		
			If NumOfHours >= HoursThreshold && PlayerREF.HasSpell(RND_HungerSpell00)
			
				PlayerREF.GetActorBase().SetWeight(weight + 0.3)
				newWeight = PlayerREF.GetActorBase().GetWeight() as float

			ElseIf NumOfHours >= HoursThreshold && PlayerREF.HasSpell(RND_HungerSpell01)
			
				PlayerREF.GetActorBase().SetWeight(weight + 0.2)
				newWeight = PlayerREF.GetActorBase().GetWeight() as float			
		
			ElseIf NumOfHours >= HoursThreshold && PlayerREF.HasSpell(RND_HungerSpell02)
			
				PlayerREF.GetActorBase().SetWeight(weight - 0.1)
				newWeight = PlayerREF.GetActorBase().GetWeight() as float
				
			ElseIf NumOfHours >= HoursThreshold && PlayerREF.HasSpell(RND_HungerSpell03)
			
				PlayerREF.GetActorBase().SetWeight(weight - 0.2)
				newWeight = PlayerREF.GetActorBase().GetWeight() as float

			ElseIf NumOfHours >= HoursThreshold && PlayerREF.HasSpell(RND_HungerSpell04)	
				
				PlayerREF.GetActorBase().SetWeight(weight - 0.3)
				newWeight = PlayerREF.GetActorBase().GetWeight() as float
				
			ElseIf NumOfHours >= HoursThreshold && PlayerREF.HasSpell(RND_HungerSpell05)	
				
				PlayerREF.GetActorBase().SetWeight(weight - 0.4)
				newWeight = PlayerREF.GetActorBase().GetWeight() as float		

			EndIf
			
			RND_CurrentWeightGlobal.SetValue(weight)
			
		ElseIf weight > 100.0
			
			PlayerREF.GetActorBase().SetWeight(100.0)
			
		ElseIf weight < 0.0
			
			PlayerREF.GetActorBase().SetWeight(0.0)

		EndIf
			
		If !PlayerREF.IsOnMount()
		
			If newWeight != weight
			
				PlayerREF.QueueNiNodeUpdate()				
				
			EndIf	
				
		EndIf		
		
		if Weight <= 100.0 && Weight > 80.0
			If !PlayerREF.HasSpell(RND_WeightSpell00)
				RemoveWeightSpells()
				PlayerREF.addSpell(RND_WeightSpell00, false)
				If RND_1stPersonMsg.GetValueInt() == 1
					Debug.Notification("Your weight is " + ((weight + 100) * 0.5) + " kg")
				EndIf				
			EndIf	
		elseif Weight <= 80.0 && Weight > 60.0
			If !PlayerREF.HasSpell(RND_WeightSpell01)
				RemoveWeightSpells()
				PlayerREF.addSpell(RND_WeightSpell01, false)
				If RND_1stPersonMsg.GetValueInt() == 1
					Debug.Notification("Your weight is " + ((weight + 100) * 0.5) + " kg")
				EndIf				
			EndIf
		elseif Weight <= 60.0 && Weight > 40.0
			If !PlayerREF.HasSpell(RND_WeightSpell02)
				RemoveWeightSpells()
				PlayerREF.addSpell(RND_WeightSpell02, false)
				If RND_1stPersonMsg.GetValueInt() == 1
					Debug.Notification("Your weight is " + ((weight + 100) * 0.5) + " kg")
				EndIf				
			EndIf
		elseif Weight <= 40.0 && Weight > 20.0
			If !PlayerREF.HasSpell(RND_WeightSpell03)
				RemoveWeightSpells()
				PlayerREF.addSpell(RND_WeightSpell03, false)
				If RND_1stPersonMsg.GetValueInt() == 1
					Debug.Notification("Your weight is " + ((weight + 100) * 0.5) + " kg")
				EndIf				
			EndIf
		elseif Weight <= 20.0 && Weight >= 0.0
			If !PlayerREF.HasSpell(RND_WeightSpell04)
				RemoveWeightSpells()
				PlayerREF.addSpell(RND_WeightSpell04, false)
				If RND_1stPersonMsg.GetValueInt() == 1
					Debug.Notification("Your weight is " + ((weight + 100) * 0.5) + " kg")
				EndIf				
			EndIf		
		endif		
	
	;section deprecated due to manual MCM weight setup, keep for reference?
	;ElseIf (RND_DisableWeightGlobal.GetValueInt() == 0

	;	PlayerREF.GetActorBase().SetWeight(RND_DefaultWeightGlobal.GetValue())
		
	;	If !PlayerREF.IsOnMount()		
		
	;		PlayerREF.QueueNiNodeUpdate()
			
	;	EndIf	
		
	;	RemoveWeightSpells()
	
	EndIf
	
	If PlayerREF.HasSpell(HungerSpell)
		RegisterForSingleUpdateGameTime(1)
	Else
		RemoveHungerSpells()
		PlayerREF.AddSpell(HungerSpell, false)
		HungerLevelMessage.Show()
	Endif	

EndEvent

GlobalVariable Property RND_1stPersonMsg Auto

Function RemoveHungerSpells()
	Actor Player = PlayerREF
	Player.RemoveSpell(RND_HungerSpell00)
	Player.RemoveSpell(RND_HungerSpell01)
	Player.RemoveSpell(RND_HungerSpell02)
	Player.RemoveSpell(RND_HungerSpell03)
	Player.RemoveSpell(RND_HungerSpell04)
	Player.RemoveSpell(RND_HungerSpell05)
EndFunction

Function RemoveWeightSpells()

	PlayerREF.RemoveSpell(RND_WeightSpell00)
	PlayerREF.RemoveSpell(RND_WeightSpell01)
	PlayerREF.RemoveSpell(RND_WeightSpell02)
	PlayerREF.RemoveSpell(RND_WeightSpell03)
	PlayerREF.RemoveSpell(RND_WeightSpell04)

EndFunction

Spell Property RND_HungerSpell00 Auto
Spell Property RND_HungerSpell01 Auto
Spell Property RND_HungerSpell02 Auto
Spell Property RND_HungerSpell03 Auto
Spell Property RND_HungerSpell04 Auto
Spell Property RND_HungerSpell05 Auto

Spell Property RND_WeightSpell00 Auto
Spell Property RND_WeightSpell01 Auto
Spell Property RND_WeightSpell02 Auto
Spell Property RND_WeightSpell03 Auto
Spell Property RND_WeightSpell04 Auto

GlobalVariable Property RND_HungerLevel00 Auto
GlobalVariable Property RND_HungerLevel01 Auto
GlobalVariable Property RND_HungerLevel02 Auto
GlobalVariable Property RND_HungerLevel03 Auto
GlobalVariable Property RND_HungerLevel04 Auto
GlobalVariable Property RND_HungerLevel05 Auto

Message Property RND_HungerLevel00TimerMessage Auto
Message Property RND_HungerLevel01TimerMessage Auto
Message Property RND_HungerLevel02TimerMessage Auto
Message Property RND_HungerLevel03TimerMessage Auto
Message Property RND_HungerLevel04TimerMessage Auto
Message Property RND_HungerLevel05TimerMessage Auto

Message Property RND_HungerLevel00TimerMessageB Auto
Message Property RND_HungerLevel01TimerMessageB Auto
Message Property RND_HungerLevel02TimerMessageB Auto
Message Property RND_HungerLevel03TimerMessageB Auto
Message Property RND_HungerLevel04TimerMessageB Auto
Message Property RND_HungerLevel05TimerMessageB Auto

