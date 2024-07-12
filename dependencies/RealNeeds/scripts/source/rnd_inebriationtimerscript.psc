Scriptname RND_InebriationTimerScript extends activemagiceffect  
{this script decreases Inebriation points over time }

GlobalVariable Property RND_InebriationPoints Auto
GlobalVariable Property RND_InebriationPointsPerHour Auto
GlobalVariable Property RND_InebriationLastUpdateTimeStamp Auto

imageSpaceModifier property RND_DrunkBlur Auto
imageSpaceModifier property RND_DrunkBlurB Auto
GlobalVariable Property RND_IsmInebriation Auto
GlobalVariable Property RND_AnimInebriation Auto
GlobalVariable Property RND_DrunkBlackout Auto
RND_PlayerScript Property RND_Player Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	RegisterForSingleUpdateGameTime(1)
	RND_DrunkBlackout.SetValue(0)
	RND_InebriationLastUpdateTimeStamp.SetValue(Utility.GetCurrentGameTime())
	
	if RND_DrunkBlur && RND_DrunkBlurB
		if RND_IsmInebriation.GetValue() == 1
			RND_DrunkBlurB.applyCrossFade(2.0)
		else
			RND_DrunkBlur.applyCrossFade(2.0)
		endif
	endif	
EndEvent

Event OnEffectFinish(actor akTarget, actor akCaster)
	if RND_DrunkBlur && RND_DrunkBlurB
		imageSpaceModifier.removeCrossFade(2.0)
	endif
EndEvent


Event OnUpdateGameTime()

	if RND_Player.isVampire()
		RND_InebriationPoints.SetValue(10)
		RemoveInebriationSpells()
		Return
	endif
	
	; calculate number of hours passed since last update
	; and deducts Inebriation points
	float NumOfHours = (Utility.GetCurrentGameTime() - RND_InebriationLastUpdateTimeStamp.GetValue()) * 24
	RND_InebriationPoints.SetValue(RND_InebriationPoints.GetValue() - (RND_InebriationPointsPerHour.GetValue() * NumOfHours))
	
	; Inebriation points cap between 0-RND_InebriationLevel04, 
	if RND_InebriationPoints.GetValue() > RND_InebriationLevel04.GetValue()
		RND_InebriationPoints.SetValue(RND_InebriationLevel04.GetValue())
	elseif RND_InebriationPoints.GetValue() < 0
		RND_InebriationPoints.SetValue(0)
	endif
	
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
	
	if Game.GetPlayer().HasSpell(InebriationSpell)
		RegisterForSingleUpdateGameTime(1)
	else
		RemoveInebriationSpells()
		Game.GetPlayer().AddSpell(InebriationSpell, false)
	endif

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

GlobalVariable Property RND_InebriationLevel00 Auto
GlobalVariable Property RND_InebriationLevel01 Auto
GlobalVariable Property RND_InebriationLevel02 Auto
GlobalVariable Property RND_InebriationLevel03 Auto
GlobalVariable Property RND_InebriationLevel04 Auto

