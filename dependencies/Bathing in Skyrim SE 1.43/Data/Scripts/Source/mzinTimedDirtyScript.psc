ScriptName mzinTimedDirtyScript extends ActiveMagicEffect
{ this script increases the player's dirty level over time }

FormList Property SoapBonusSpellList Auto

GlobalVariable Property Tier1Threshold Auto
GlobalVariable Property Tier2Threshold Auto
GlobalVariable Property Tier3Threshold Auto

Spell Property DirtyTier0 Auto
Spell Property DirtyTier1 Auto
Spell Property DirtyTier2 Auto
Spell Property DirtyTier3 Auto

GlobalVariable Property DirtyLevel Auto
GlobalVariable Property DirtyRatePerHour Auto
GlobalVariable Property LastDirtyUpdateTime Auto

Event OnUpdateGameTime()
	
	; acquire the player
	Actor Player = Game.GetPlayer()
	
	; calculate how many game hours have passed since last update
	Float HoursPassed = (Utility.GetCurrentGameTime() - LastDirtyUpdateTime.GetValue()) * 24
	
	; increment dirty level
	DirtyLevel.SetValue(DirtyLevel.GetValue() + (DirtyRatePerHour.GetValue() * HoursPassed))
	
	; display at most 1 exit and 1 enter message per run
	; this will display the highest tier exited and lowest tier entered
	; skipping messages for all tier switches that may occur inbetween
	Message EnterMessage = None
	Message ExitMessage = None
	
	; detect going from tier 0 to tier 1
	if Player.HasSpell(DirtyTier0) && DirtyLevel.GetValue() > Tier1Threshold.GetValue()
	
		; set spells
		Player.RemoveSpell(DirtyTier0)
		Player.AddSpell(DirtyTier1, False)
		
		; set messages
		EnterMessage = EnterTier1Message
		ExitMessage = ExitTier0Message
		
		; remove existing soap bonuses
		Int SoapBonusesIndex = SoapBonusSpellList.GetSize()
		While SoapBonusesIndex
			SoapBonusesIndex -= 1
			If Player.HasSpell(SoapBonusSpellList.GetAt(SoapBonusesIndex) As Spell)
				Player.RemoveSpell(SoapBonusSpellList.GetAt(SoapBonusesIndex) As Spell)
			EndIf
		EndWhile
		
	EndIf
	
	; detect going from tier 1 to tier 2
	if Player.HasSpell(DirtyTier1) && DirtyLevel.GetValue() > Tier2Threshold.GetValue()
	
		; set spells
		Player.RemoveSpell(DirtyTier1)
		Player.AddSpell(DirtyTier2, False)
		
		; set messages
		EnterMessage = EnterTier2Message
		If ExitMessage == None
			ExitMessage = ExitTier1Message
		EndIf
		
	EndIf
	
	; detect going from tier 2 to tier 3
	if Player.HasSpell(DirtyTier2) && DirtyLevel.GetValue() > Tier3Threshold.GetValue()
	
		; set spells
		Player.RemoveSpell(DirtyTier2)
		Player.AddSpell(DirtyTier3, False)
		
		; set messages
		EnterMessage = EnterTier3Message
		If ExitMessage == None
			ExitMessage = ExitTier2Message
		EndIF
		
	EndIf
	
	; show the exit tier message if the player exited a tier
	If ExitMessage != None
		ExitMessage.Show()
	EndIf
	
	; show the enter tier message if the player entered a tier
	If EnterMessage != None
		EnterMessage.Show()
	EndIf
	
	; need may not exceed 1.0
	if DirtyLevel.GetValue() > 1.0
		DirtyLevel.SetValue(1.0)
	EndIf
	
	; needs may not be less than 0.0
	if DirtyLevel.GetValue() < 0.0
		DirtyLevel.SetValue(0.0)
	EndIf
	
	; update the time snap shot of this run
	LastDirtyUpdateTime.SetValue(Utility.GetCurrentGameTime())
	
EndEvent

Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	; tick timer every game hour
	RegisterForUpdateGameTime(1)
	
	; take a snapshot of the time the effect started
	; this is useful since OnUpdateGameTime() does not fire when sleeping or waiting
	; manual calculation is needed to determine actual game hours passed since the effect start
	; we also take a snapshot every time the effect updates
	LastDirtyUpdateTime.SetValue(Utility.GetCurrentGameTime())
	
EndEvent

Message Property EnterTier0Message Auto
Message Property EnterTier1Message Auto
Message Property EnterTier2Message Auto
Message Property EnterTier3Message Auto

Message Property ExitTier0Message Auto
Message Property ExitTier1Message Auto
Message Property ExitTier2Message Auto
Message Property ExitTier3Message Auto