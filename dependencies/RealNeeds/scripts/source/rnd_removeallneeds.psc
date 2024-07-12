Scriptname RND_RemoveAllNeeds extends activemagiceffect  

event OnEffectStart(Actor akTarget, Actor akCaster)

	Actor PlayerRef = Game.GetPlayer()
	
	PlayerRef.RemoveSpell(RND_HungerSpell00)
	PlayerRef.RemoveSpell(RND_HungerSpell01)
	PlayerRef.RemoveSpell(RND_HungerSpell02)
	PlayerRef.RemoveSpell(RND_HungerSpell03)
	PlayerRef.RemoveSpell(RND_HungerSpell04)
	PlayerRef.RemoveSpell(RND_HungerSpell05)
	
	PlayerRef.RemoveSpell(RND_ThirstSpell00)
	PlayerRef.RemoveSpell(RND_ThirstSpell01)
	PlayerRef.RemoveSpell(RND_ThirstSpell02)
	PlayerRef.RemoveSpell(RND_ThirstSpell03)
	PlayerRef.RemoveSpell(RND_ThirstSpell04)
	
	PlayerRef.RemoveSpell(RND_InebriationSpell00)
	PlayerRef.RemoveSpell(RND_InebriationSpell01)
	PlayerRef.RemoveSpell(RND_InebriationSpell02)
	PlayerRef.RemoveSpell(RND_InebriationSpell03)
	PlayerRef.RemoveSpell(RND_InebriationSpell04)
	
	PlayerRef.RemoveSpell(RND_Rested)
	PlayerRef.RemoveSpell(RND_WellRested)
	PlayerRef.RemoveSpell(RND_MarriageRested)
	PlayerRef.RemoveSpell(RND_RestlessBeast)
	PlayerRef.RemoveSpell(RND_SleepSpell00)
	PlayerRef.RemoveSpell(RND_SleepSpell01)
	PlayerRef.RemoveSpell(RND_SleepSpell02)
	PlayerRef.RemoveSpell(RND_SleepSpell03)
	PlayerRef.RemoveSpell(RND_SleepSpell04)
	
	PlayerRef.RemoveSpell(RND_CheckNeedsSpell)
	PlayerRef.RemoveSpell(RND_DrinkFromWaterSource)
	
	PlayerRef.RemoveSpell(RND_WeightSpell00)
	PlayerRef.RemoveSpell(RND_WeightSpell01)
	PlayerRef.RemoveSpell(RND_WeightSpell02)
	PlayerRef.RemoveSpell(RND_WeightSpell03)
	PlayerRef.RemoveSpell(RND_WeightSpell04)
	
endEvent

Spell Property RND_CheckNeedsSpell Auto
Spell Property RND_DrinkFromWaterSource Auto

Spell Property RND_HungerSpell00 Auto
Spell Property RND_HungerSpell01 Auto
Spell Property RND_HungerSpell02 Auto
Spell Property RND_HungerSpell03 Auto
Spell Property RND_HungerSpell04 Auto
Spell Property RND_HungerSpell05 Auto

Spell Property RND_ThirstSpell00 Auto
Spell Property RND_ThirstSpell01 Auto
Spell Property RND_ThirstSpell02 Auto
Spell Property RND_ThirstSpell03 Auto
Spell Property RND_ThirstSpell04 Auto

Spell Property RND_InebriationSpell00 Auto
Spell Property RND_InebriationSpell01 Auto
Spell Property RND_InebriationSpell02 Auto
Spell Property RND_InebriationSpell03 Auto
Spell Property RND_InebriationSpell04 Auto

Spell Property RND_Rested Auto
Spell Property RND_RestlessBeast Auto
Spell Property RND_WellRested Auto
Spell Property RND_MarriageRested Auto
Spell Property RND_SleepSpell00 Auto
Spell Property RND_SleepSpell01 Auto
Spell Property RND_SleepSpell02 Auto
Spell Property RND_SleepSpell03 Auto
Spell Property RND_SleepSpell04 Auto

Spell Property RND_WeightSpell00 Auto
Spell Property RND_WeightSpell01 Auto
Spell Property RND_WeightSpell02 Auto
Spell Property RND_WeightSpell03 Auto
Spell Property RND_WeightSpell04 Auto