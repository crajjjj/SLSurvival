Scriptname RND_DrinkFromWaterfall extends activemagiceffect

{this script decreases Thirst when drinking}

GlobalVariable Property RND_ThirstPoints Auto
GlobalVariable Property RND_ThirstPointsPerHour Auto
GlobalVariable Property RND_ThirstLastUpdateTimeStamp Auto

RND_PlayerScript Property RND_Player Auto
RND_ThirstCountScript Property ThirstScript Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Actor Player = Game.GetPlayer()
	
	if Game.FindClosestReferenceOfAnyTypeInListFromRef(RND_WaterfallList, Player, 90.0)
	
		if RND_Player.isVampire()	
			RemoveThirstSpells()
		else
			if !Player.IsSneaking()
				Player.StartSneaking()
			endif
			
			; drink water
			RND_ThirstPoints.SetValue(0)
			RND_ThirstLastUpdateTimeStamp.SetValue(Utility.GetCurrentGameTime())
			if !Player.HasSpell(RND_ThirstSpell00)			
				RemoveThirstSpells()
				Player.AddSpell(RND_ThirstSpell00, false)
			endif
			if RND_1stPersonMsg.GetValue() == 1
				RND_ThirstLevel00ConsumeMessage.Show()
			else
				RND_ThirstLevel00ConsumeMessageB.Show()
			endif
			RND_Player.applyRandomDisease(RND_DiseaseChanceRiverWater.GetValueInt())
		
		
			Utility.Wait(2.0)
			if Player.IsSneaking()
				Player.StartSneaking()
			endif
		
			if Utility.RandomInt(0,100) <= 10
				if RND_AnimMisc.GetValue() == 1
					if !Player.GetAnimationVariableInt("i1stPerson") == 1 && !Player.GetAnimationVariableBool("bAnimationDriven")
						Player.PlayIdle(IdleUnControllableCough)
					endif
				endif
				Player.Say(CoughCough)
			endif
		endif
	endif
	
	ThirstScript.WidgetFade()
	
EndEvent

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
Message Property RND_ThirstLevel00ConsumeMessage Auto
Message Property RND_ThirstLevel00ConsumeMessageB Auto
GlobalVariable Property RND_1stPersonMsg Auto

FormList Property RND_WaterfallList Auto

Topic Property CoughCough Auto 
Idle Property IdleUnControllableCough  Auto
GlobalVariable Property RND_AnimMisc Auto
GlobalVariable Property RND_DiseaseChanceRiverWater Auto


