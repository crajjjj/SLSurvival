Scriptname RND_DirtyBedroll extends activemagiceffect  
{this script gives disease if pc sleeping in a dirty place}

RND_PlayerScript Property RND_Player Auto

GlobalVariable Property RND_DiseaseChanceDirtyBedroll Auto  

event OnEffectStart(Actor akTarget, Actor akCaster)

	Location Loc = Game.GetPlayer().GetCurrentLocation()

	if Loc != None		
		if Loc.HasKeyword(LocTypeDungeon) == True || Loc.HasKeyword(LocTypeBanditCamp) == True || \
				Loc.HasKeyword(LocTypeHagravenNest) == True || Loc.HasKeyword(LocTypeAnimalDen) == True
			
				RND_Player.applyRandomDisease(RND_DiseaseChanceDirtyBedroll.GetValueInt())
		
		endif
	endif
	
endEvent

Keyword Property LocTypeDungeon Auto
Keyword Property LocTypeBanditCamp Auto
Keyword Property LocTypeHagravenNest Auto
Keyword Property LocTypeAnimalDen Auto
