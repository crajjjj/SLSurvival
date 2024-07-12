Scriptname RND_ReminderScript extends ReferenceAlias  

GlobalVariable Property RND_ReminderInterval Auto
GlobalVariable Property RND_ReminderSound Auto
GlobalVariable Property RND_ReminderMessage Auto
GlobalVariable Property RND_ReminderSoundVolume Auto
GlobalVariable Property RND_State Auto

Bool HungryThirstySleepy

Event OnInit()
	HungryThirstySleepy = False
	RegisterForSingleUpdate(60.0)
EndEvent

Event OnUpdate()

	if RND_State.GetValue() == 1
	
		bool isBeast = Game.GetPlayer().GetRace().HasKeyword(ActorTypeCreature)
	
		if RND_HungerPoints.GetValue() >= RND_HungerLevel03.GetValue()
			HungryThirstySleepy = True
			if RND_ReminderSound.GetValue() == 1
				int instanceID = RND_SoundHungry.Play(Game.GetPlayer())
				Sound.SetInstanceVolume(instanceID, RND_ReminderSoundVolume.GetValue()/100)
				Game.GetPlayer().CreateDetectionEvent(Game.GetPlayer(), 30)
				Utility.Wait(5)
			endif
		endif

		if RND_ThirstPoints.GetValue() >= RND_ThirstLevel02.GetValue()
			HungryThirstySleepy = True
			if RND_ReminderSound.GetValue() == 1 && !isBeast
				ActorBase PlayerBase = Game.GetPlayer().GetBaseObject() as ActorBase
				if (PlayerBase.GetSex() == 0)
					int instanceID = RND_SoundThirstyMale.Play(Game.GetPlayer())
					Sound.SetInstanceVolume(instanceID, RND_ReminderSoundVolume.GetValue()/100)
				else
					int instanceID = RND_SoundThirstyFemale.Play(Game.GetPlayer())
					Sound.SetInstanceVolume(instanceID, RND_ReminderSoundVolume.GetValue()/100)
				endif
				Utility.Wait(5)
			endif
		endif
	
		if RND_SleepPoints.GetValue() >= RND_SleepLevel02.GetValue()
			HungryThirstySleepy = True
			if RND_ReminderSound.GetValue() == 1 && !isBeast
				ActorBase PlayerBase = Game.GetPlayer().GetBaseObject() as ActorBase
				if (PlayerBase.GetSex() == 0)
					int instanceID = RND_SoundTiredMale.Play(Game.GetPlayer())
					Sound.SetInstanceVolume(instanceID, RND_ReminderSoundVolume.GetValue()/100)
				else
					int instanceID = RND_SoundTiredFemale.Play(Game.GetPlayer())
					Sound.SetInstanceVolume(instanceID, RND_ReminderSoundVolume.GetValue()/100)
				endif
				Utility.Wait(5)
			endif
		endif
		
		; cast the check needs power to display message
		if HungryThirstySleepy
			if RND_ReminderMessage.GetValue() == 1
				RND_CheckNeedsSpell.Cast(Game.GetPlayer())
			endif
		endif

		HungryThirstySleepy = False
		if RND_ReminderInterval.GetValue() >= 1
			RegisterForSingleUpdate(RND_ReminderInterval.GetValue() * 60.0)
		endif
		
	endif

EndEvent

Sound Property RND_SoundHungry Auto  
Sound Property RND_SoundTiredMale Auto
Sound Property RND_SoundTiredFemale Auto
Sound Property RND_SoundThirstyFemale Auto
Sound Property RND_SoundThirstyMale Auto

Spell Property RND_CheckNeedsSpell Auto
Keyword property ActorTypeCreature Auto

GlobalVariable Property RND_HungerPoints Auto
GlobalVariable Property RND_ThirstPoints Auto
GlobalVariable Property RND_SleepPoints Auto

GlobalVariable Property RND_HungerLevel03 Auto
GlobalVariable Property RND_ThirstLevel02 Auto
GlobalVariable Property RND_SleepLevel02 Auto





