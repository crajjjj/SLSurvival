Scriptname RND_ProgDisease extends activemagiceffect  
{this script handles progressive disease}

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Timer = 0.0
	CurrentStage = 0
	DiseaseLastUpdateTimeStamp = Utility.GetCurrentGameTime()
	Game.GetPlayer().AddSpell(RND_DiseaseStage0, false)
	RegisterForSingleUpdateGameTime(1)
	RegisterForSleep()
EndEvent

Event OnUpdateGameTime()

	; calculate number of hours passed since last update
	float NumOfHours = (Utility.GetCurrentGameTime() - DiseaseLastUpdateTimeStamp) * 24

	Timer += NumOfHours
	
	if Timer >= TimeGap
		CurrentStage += 1
		Timer = 0.0
		if CurrentStage == 1
			Game.GetPlayer().AddSpell(RND_DiseaseStage1, false)
		elseif CurrentStage == 2
			Game.GetPlayer().AddSpell(RND_DiseaseStage2, false)
		endif
	endif

	DiseaseLastUpdateTimeStamp = Utility.GetCurrentGameTime()
	RegisterForSingleUpdateGameTime(1)
	
EndEvent

Event OnSleepStop(bool abInterrupted)

	if CurrentStage > 3
		
		int Adjust = CurrentStage - 3
		
		Location RestLoc = Game.GetPlayer().GetCurrentLocation()		
		if RestLoc != None
			if RestLoc.HasKeyword(LocTypePlayerHouse) == True
				Adjust += 3
			elseif RestLoc.HasKeyword(LocTypeInn) == True
				Adjust += 2
			elseif RestLoc.HasKeyword(LocTypeBanditCamp) == True || RestLoc.HasKeyword(LocTypeAnimalDen) == True
				Adjust -= 1
			elseif RestLoc.HasKeyword(LocTypeDungeon) == True
				Adjust -= 3
			endif
		endif
		
		if Game.FindClosestReferenceOfAnyTypeInListFromRef(RND_FireList, Game.GetPlayer(), 120.0)
			Adjust += 2
		endif

		if (Utility.RandomInt(0,9) + Adjust) > DiseaseFatigue.GetValue()
		
			if Game.GetPlayer().HasSpell(RND_DiseaseStage2)
				Game.GetPlayer().RemoveSpell(RND_DiseaseStage2)
				
			elseif Game.GetPlayer().HasSpell(RND_DiseaseStage1)
				Game.GetPlayer().RemoveSpell(RND_DiseaseStage1)
				
			elseif Game.GetPlayer().HasSpell(RND_DiseaseStage0)
				Game.GetPlayer().RemoveSpell(RND_DiseaseStage0)
				
			else
				Self.Dispel()
			endif
		endif
	
	endif

EndEvent

int CurrentStage = 0
float Timer = 0.0
float DiseaseLastUpdateTimeStamp

Spell Property RND_DiseaseStage0 Auto
Spell Property RND_DiseaseStage1 Auto
Spell Property RND_DiseaseStage2 Auto
Spell Property RND_Disease Auto

Int Property TimeGap = 6 Auto
GlobalVariable Property DiseaseFatigue Auto

FormList Property RND_FireList Auto

Keyword Property LocTypeInn Auto
Keyword Property LocTypePlayerHouse Auto

Keyword Property LocTypeDungeon Auto
Keyword Property LocTypeBanditCamp Auto
Keyword Property LocTypeAnimalDen Auto

