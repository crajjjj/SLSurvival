Scriptname RND_FoodDisease extends activemagiceffect  
{this script adds random disease when eating raw or stale food}

GlobalVariable Property RND_DiseaseChance Auto  

RND_PlayerScript Property RND_Player Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	RND_Player.applyRandomDisease(RND_DiseaseChance.GetValueInt())

EndEvent

