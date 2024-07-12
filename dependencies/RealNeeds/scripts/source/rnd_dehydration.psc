Scriptname RND_Dehydration extends activemagiceffect  

bool Loop = False
int CurrentStage = 0
float DamageHealth = 5.0

Int Property TimeInterval = 5 Auto
GlobalVariable Property RND_DieOfThirst Auto
ImageSpaceModifier Property RND_DehydrationBlur Auto

Actor PlayerRef

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if RND_DieOfThirst.GetValue() == 1
		CurrentStage = 0
		PlayerRef = Game.GetPlayer()
		DamageHealth = PlayerRef.GetActorValue("health") * 0.1
		RegisterForSingleUpdateGameTime(24)
	endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	Loop = False
	if CurrentStage == 1
		ImageSpaceModifier.removeCrossFade(2.0)
	endif
EndEvent

Event OnUpdateGameTime()

	if RND_DieOfThirst.GetValue() == 1
		if CurrentStage == 0
			Loop = True
			CurrentStage = 1
			RND_DehydrationBlur.ApplyCrossFade(2.0)
			RegisterForSingleUpdateGameTime(24)
			RegisterForSingleUpdate(TimeInterval)
		elseif CurrentStage == 1
			Loop = False
			PlayerRef.DamageActorValue("Health", 9999.0)
		endif
	endif

EndEvent

Event OnUpdate()

	if RND_DieOfThirst.GetValue() == 1
		if Utility.RandomInt(1,10) <= 3
			PlayerRef.DamageActorValue("Health", DamageHealth)
		endif
		if Loop
			RegisterForSingleUpdate(TimeInterval)
		endif
	endif
	
EndEvent




