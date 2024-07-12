;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 10
Scriptname RND_MilkingScript Extends Perk Hidden

;BEGIN FRAGMENT Fragment_7
Function Fragment_7(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
if Game.GetPlayer().GetItemCount(RND_Bucket) >= 1

	Game.DisablePlayerControls()
	
	RND_FadeOut.Apply()
	Utility.Wait(1)
	RND_FadeOut.PopTo(RND_Black)
	
	Utility.Wait(1)
	int instanceID = RND_SoundCow.Play(Game.GetPlayer())
	Sound.SetInstanceVolume(instanceID, RND_ReminderSoundVolume.GetValue()/100)	
	Utility.Wait(6)
	
	GameHour.SetValue(GameHour.GetValue() + 1)	
	RND_Black.PopTo(RND_FadeIn)
	Utility.Wait(1)
	
	Game.EnablePlayerControls()
	
	int SuccessRate = 50

	if RND_Player.feedCow()
		SuccessRate += Utility.RandomInt(20,40)
	endif
	
	if GameHour.GetValue() <= 7.0 || GameHour.GetValue() >= 19.0
		SuccessRate = 10
	endif
	
	if Utility.RandomInt(0,100) <= SuccessRate
		Game.GetPlayer().Additem(RND_Milk, Utility.RandomInt(1,3))
	else
		RND_CowMessage.Show()
	endif
	
	if Game.GetPlayer().IsSneaking()
		Game.GetPlayer().StartSneaking()
	endif
	
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property RND_Bucket  Auto
Potion Property RND_Milk  Auto  
Sound Property RND_SoundCow Auto
Message Property RND_CowMessage Auto
GlobalVariable Property RND_ReminderSoundVolume Auto
GlobalVariable Property GameHour Auto

RND_PlayerScript Property RND_Player Auto

ImageSpaceModifier Property RND_FadeOut Auto
ImageSpaceModifier Property RND_FadeIn Auto
ImageSpaceModifier Property RND_Black Auto

